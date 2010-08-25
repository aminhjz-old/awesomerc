-- Smart clients placement

require("awful.placement")
require("awful.client")

function smartplace(c)
   local c = c or client.focus
   if #awful.client.visible(c.screen) == 1 then
      awful.placement.centered(c)
   else
      awful.placement.no_overlap(c)
   end

   return awful.placement.no_offscreen(c)
end
