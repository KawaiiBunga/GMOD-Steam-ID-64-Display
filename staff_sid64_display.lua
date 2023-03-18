-- Config--
local radius = 500 -- set the radius here for showing Names/SID64
local staffteam = TEAM_STAFF -- Set the staff team here

local title = "Nearby players" -- The title above the nearby players
local titlecolor = Color(255 ,255 ,255) -- Color of the title

local playercolor = Color(255 ,255 ,255) -- The color of the text when not hovered
local hovercolor = Color(33, 148, 255) -- The color the text will change to when hovered

-- Font settings for the title --
surface.CreateFont( "titlefont", { -- Don't change this line
	font = "Roboto",
	extended = false,
	size = 24,
	antialias = true,
	underline = true,
	shadow = true,
	outline = true,
} )

-- Font settings for the nick/sid64 --
surface.CreateFont( "playerfont", { -- Don't change this line
	font = "Roboto",
	extended = false,
	size = 14,
	antialias = true,
} )
-- End config--



-- DON'T TOUCH ANYTHING PAST HERE UNLESS YOU KNOW WHAT YOU ARE DOING! --
-- DON'T TOUCH ANYTHING PAST HERE UNLESS YOU KNOW WHAT YOU ARE DOING! --
-- DON'T TOUCH ANYTHING PAST HERE UNLESS YOU KNOW WHAT YOU ARE DOING! --
hook.Add("HUDPaint", "ShowSteamID64", function()
    local ply = LocalPlayer()
    if ply:Team() == staffteam then
        local players = ents.FindInSphere(ply:GetPos(), radius)
        local y = 100
        draw.SimpleText(title, "titlefont", 60,y -40 , titlecolor, TEXT_ALIGN_LEFT)
        for _, v in pairs(players) do
            if v:IsPlayer() then
                draw.RoundedBox(8, 50,y ,250 ,30 ,Color(0 ,0 ,0 ,150))
                local nick = v:Nick()
                local sid64 = v:SteamID64()
                local x,y2 = gui.MousePos()
                if x >=50 and x <=300 and y2 >=y and y2 <=y +30 then 
                    if sid64 then 
                        draw.SimpleText(nick .. " - " .. sid64, "playerfont", 60,y +8 ,hovercolor, TEXT_ALIGN_LEFT)
                    else 
                        draw.SimpleText(nick .. " - nil", "playerfont", 60,y +8 ,hovercolor, TEXT_ALIGN_LEFT)
                    end 
                else 
                    if sid64 then 
                        draw.SimpleText(nick .. " - " .. sid64, "playerfont", 60,y +8 ,playercolor, TEXT_ALIGN_LEFT)
                    else 
                        draw.SimpleText(nick .. " - nil", "playerfont", 60,y +8 ,playercolor, TEXT_ALIGN_LEFT)
                    end 
                end 
                y = y +40 
            end 
        end 
    end
end)

hook.Add("Think", "CopySteamID64", function()
    if input.IsMouseDown(MOUSE_LEFT) then
        if not buttonPressed then
            local x,y = gui.MousePos()
            if x >=50 and x <=300 then 
                for i=1,#player.GetAll() do 
                    local v = player.GetAll()[i]
                    if y >=100+(i-1)*40 and y <=130+(i-1)*40 then
                        local sid64 = v:SteamID64()
                        SetClipboardText(sid64 or 'nil')
                        notification.AddLegacy("SID64 Copied!", NOTIFY_GENERIC, 5)
                        surface.PlaySound("buttons/button15.wav")
                        buttonPressed = true
                        break
                    end
                end
            end
        end
    else
        buttonPressed = false
    end
end)
