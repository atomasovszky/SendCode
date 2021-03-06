on run argv
    set cmd to item 1 of argv
    tell application "Google Chrome"
        repeat with w in (windows)
            set j to 0
            repeat with t in (tabs of w)
                set j to j + 1
                if title of t contains "RStudio" then
                    set (active tab index of w) to j
                    set index of w to 1

                    set URL of front window's active tab to "javascript:{" & "
                        var input = document.getElementById('rstudio_console_input');
                        var textarea = input.getElementsByTagName('textarea')[0];
                        textarea.value += \"" & cmd & "\";
                        var e = document.createEvent('KeyboardEvent');
                        e.initKeyboardEvent('input');
                        textarea.dispatchEvent(e);
                        var e = document.createEvent('KeyboardEvent');
                        e.initKeyboardEvent('keydown');
                        Object.defineProperty(e, 'keyCode', {'value' : 13});
                        input.dispatchEvent(e);
                    " & "}"

                    tell application "Sublime Text" to activate
                    return
                end if
            end repeat
        end repeat
    end tell
end run
