# Iframe Violation Detection System

## Overview
The exam monitoring system uses a dual-layer violation detection approach:
- **Parent Page Layer**: Detects violations in the parent document (fullscreen exit, tab switch, window blur, keyboard shortcuts)
- **Iframe Layer**: Detects violations within the exam form iframe (copy, paste, cut, right-click)

## Key Design Principles

### 1. Normal Interactions are NOT Violations
The following are **allowed and never trigger violations**:
- ✅ Left-clicking form elements
- ✅ Typing answers in text inputs
- ✅ Scrolling within the form
- ✅ Selecting/changing form options (radio buttons, checkboxes, dropdowns)
- ✅ Focusing on input fields
- ✅ Tab navigation between form fields
- ✅ Form submission
- ✅ Text selection (with mouse or keyboard)

### 2. Only Explicit Violations are Detected
The following **trigger violations**:
- ❌ Copy attempts (Ctrl+C or right-click → Copy)
- ❌ Paste attempts (Ctrl+V or right-click → Paste)
- ❌ Cut attempts (Ctrl+X or right-click → Cut)
- ❌ Right-click context menu
- ❌ Tab switching (actual window focus loss)
- ❌ Application switching (Alt+Tab)
- ❌ Fullscreen exit
- ❌ Window minimize/blur

## Implementation Details

### Parent Page (`/app/student/exam/[examId]/page.tsx`)
```typescript
// Only violations trigger this function - normal activity is ignored
const handleIframeMessage = (event: MessageEvent) => {
  if (event.origin !== window.location.origin) return
  
  if (event.data.type === "VIOLATION") {
    logViolation(event.data.violationType, event.data.description)
  } else if (event.data.type === "IFRAME_ACTIVITY") {
    // Activity tracked but NOT logged as violation
    console.log("[v0] Iframe activity heartbeat")
  }
}
```

### Iframe Script (`/public/iframe-proctoring.js`)
```javascript
// Activity tracking - NEVER triggers violations
document.addEventListener("click", updateActivity)  // ✅ Normal click
document.addEventListener("keydown", updateActivity) // ✅ Typing answers
document.addEventListener("input", updateActivity)   // ✅ Form input

// Violation detection - ONLY these trigger violations
document.addEventListener("copy", (e) => {
  e.preventDefault()
  sendViolationToParent("COPY_ATTEMPT", "...")  // ❌ Copy attempt
})

document.addEventListener("paste", (e) => {
  e.preventDefault()
  sendViolationToParent("PASTE_ATTEMPT", "...") // ❌ Paste attempt
})

document.addEventListener("contextmenu", (e) => {
  e.preventDefault()
  sendViolationToParent("RIGHT_CLICK", "...")   // ❌ Right-click
})
```

## Data Flow

1. Student interacts with exam form (clicks, types, selects options)
   - Activity tracked locally in iframe
   - No messages sent to parent
   - No violations logged

2. Student attempts prohibited action (copy/paste/right-click)
   - Event prevented from executing
   - Violation message sent to parent via `window.parent.postMessage()`
   - Parent logs violation with timestamp and details
   - Teacher dashboard displays violation

3. Activity heartbeat sent every 5 seconds
   - Confirms iframe is still active
   - Tracked for monitoring purposes
   - Not classified as violations

## Security Considerations

- **Same-origin validation**: Only messages from same origin are processed
- **Capture phase listeners**: Prevents event bubbling interference
- **Event prevention**: Copy/paste/cut are completely blocked
- **Cross-frame communication**: Uses postMessage API safely with origin verification
- **Iframe sandbox**: `allow-forms allow-scripts allow-same-origin` prevents high-risk operations

## Testing Violations

### ✅ These SHOULD work normally:
1. Click on text input → type answer → should work
2. Use Tab key to navigate → should work
3. Select option from dropdown → should work
4. Scroll form up/down → should work
5. Click submit button → should work

### ❌ These SHOULD be blocked:
1. Try Ctrl+C (copy) → blocked, violation logged
2. Try Ctrl+V (paste) → blocked, violation logged
3. Try Ctrl+X (cut) → blocked, violation logged
4. Right-click on form → blocked, violation logged
5. Switch tabs → detected, violation logged
6. Exit fullscreen → detected, violation logged

## Troubleshooting

**Problem**: Students report they can't type in the exam
- Check: Is the iframe form responsive? Try clicking in the input field first
- Check: Browser console for errors
- Check: Iframe sandbox attribute allows `allow-forms` and `allow-scripts`

**Problem**: Violations not appearing in teacher dashboard
- Check: Exam session created in database when exam started
- Check: Violations API returning data properly
- Check: Teacher refreshing dashboard to see live updates

**Problem**: False positives (normal actions triggering violations)
- Root cause: Only copy/paste/cut/right-click should trigger
- If happening, check browser console for unexpected errors
- Verify iframe script is injected successfully

## Future Enhancements

Potential additional violation types:
- Browser developer tools detection
- Screen recording detection
- Multiple display detection
- Virtual machine detection
- Suspicious keyboard patterns
