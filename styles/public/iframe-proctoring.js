// This script runs inside the exam iframe and detects violations
// It communicates with the parent page via postMessage
// IMPORTANT: Only ACTUAL violations are detected - normal interactions (clicks, typing, scrolling) are NOT treated as violations

(function() {
  // Only run if we're in an iframe
  if (window.self === window.top) {
    return
  }

  const sendViolationToParent = (violationType, description) => {
    window.parent.postMessage(
      {
        type: "VIOLATION",
        violationType: violationType,
        description: description,
        timestamp: new Date().toISOString(),
      },
      "*"
    )
    console.log("[v0-iframe] Violation detected and sent to parent:", violationType)
  }

  // Use capture phase (true) for better event interception
  // Block copy attempts - prevents unauthorized content copying
  document.addEventListener(
    "copy",
    (e) => {
      e.preventDefault()
      e.stopPropagation()
      sendViolationToParent("COPY_ATTEMPT", "Student attempted to copy content from exam")
    },
    true
  )

  // Block cut attempts - prevents text manipulation
  document.addEventListener(
    "cut",
    (e) => {
      e.preventDefault()
      e.stopPropagation()
      sendViolationToParent("CUT_ATTEMPT", "Student attempted to cut content from exam")
    },
    true
  )

  // Block paste attempts - prevents external content injection
  document.addEventListener(
    "paste",
    (e) => {
      e.preventDefault()
      e.stopPropagation()
      sendViolationToParent("PASTE_ATTEMPT", "Student attempted to paste content into exam")
    },
    true
  )

  // Block right-click - prevents context menu access
  document.addEventListener(
    "contextmenu",
    (e) => {
      e.preventDefault()
      e.stopPropagation()
      sendViolationToParent("RIGHT_CLICK", "Student attempted to right-click inside exam")
    },
    true
  )

  // NORMAL INTERACTIONS (NOT VIOLATIONS):
  // - Clicking form elements: allowed
  // - Typing answers: allowed
  // - Scrolling: allowed
  // - Focus changes: allowed
  // - Form submissions: allowed
  // - Selection: allowed (can't copy/paste anyway)

  // Track activity for heartbeat
  let lastActivity = Date.now()

  const updateActivity = () => {
    lastActivity = Date.now()
  }

  // These listeners ONLY track activity, they don't trigger violations
  document.addEventListener("click", updateActivity)
  document.addEventListener("keydown", updateActivity)
  document.addEventListener("mousemove", updateActivity)
  document.addEventListener("change", updateActivity)
  document.addEventListener("input", updateActivity)
  document.addEventListener("focusin", updateActivity)
  document.addEventListener("scroll", updateActivity)

  // Send activity heartbeat to parent every 5 seconds
  setInterval(() => {
    window.parent.postMessage(
      {
        type: "IFRAME_ACTIVITY",
        timestamp: Date.now(),
        lastActivity: lastActivity,
      },
      "*"
    )
  }, 5000)

  console.log("[v0-iframe] Proctoring initialized - monitoring for violations only (copy/paste/right-click)")
})()
