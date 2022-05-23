import ui
import osproc

template mpvCmd(channel: string): string =
  "streamlink  -p mpv --twitch-low-latency https://www.twitch.tv/" & channel & " best"

proc main*() =
  var mainwin: Window

  var menu = newMenu("File")
  menu.addQuitItem(proc(): bool {.closure.} =
    mainwin.destroy()
    return true)

  menu.addPreferencesItem(proc() = discard)
  menu = newMenu("Help")
  menu.addItem("Help", proc () = discard)
  menu.addAboutItem(proc () = discard)

  mainwin = newWindow("TwitchNim", 640, 480, true)
  mainwin.margined = true
  mainwin.onClosing = (proc (): bool = return true)

  let box = newVerticalBox(true)
  mainwin.setChild(box)

  var group = newGroup("Launch", true)
  box.add(group, false)

  var inner = newVerticalBox(true)
  group.child = inner

  var entry = newEntry("Chanel")
  inner.add entry

  inner.add newButton("Launch", proc() = discard execCmd(mpvCmd(entry.text)))

  show(mainwin)
  mainLoop()

init()
main()
