#!/usr/bin/env bash
foo=${1:-""}
osascript <<EOD
if application "iTerm" is running then
	tell application "iTerm"
		set newWindow to (create window with default profile)
		tell newWindow
			tell current session
				write text "${foo}"
			end tell
		end tell
	end tell
else
	tell application "iTerm"
		activate
		tell current window
			tell current session
				write text "${foo}"
			end tell
		end tell
	end tell
end if
EOD
