local naughty = require("naughty")
local io = io

module("tools.google")

-----------------------------
-- Google translate
-----------------------------
function translate(words, from, to)
    local val = "< error >"

    local f = io.popen("wget -qO- \"http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q="..words.."&langpair="..from.."|"..to.."\" | sed 's/.*\"translatedText\":\"\\([^\"]*\\)\".*}/\\1\\n/'")
    if f then
        val = f:read("*line")
        f:close()
    end
    naughty.notify({
        text = '<span color="red"><big>' .. words .. '</big></span>\n<span color="yellow">' .. val .. "</span>",
        timeout = 10,
        position = "top_right"
    })
end
