local radius = 500 -- set the radius here

hook.Add("HUDPaint", "ShowSteamID64", function()
    local ply = LocalPlayer()
    if ply:Team() == TEAM_STAFF then
        local players = ents.FindInSphere(ply:GetPos(), radius)
        local y = 100
        draw.SimpleText("Nearby players", "DermaLarge", 60,y -40 ,Color(255 ,255 ,255), TEXT_ALIGN_LEFT)
        for _, v in pairs(players) do
            if v:IsPlayer() then
                draw.RoundedBox(8, 50,y ,250 ,30 ,Color(0 ,0 ,0 ,150))
                local nick = v:Nick()
                local sid64 = v:SteamID64()
                local x,y2 = gui.MousePos()
                if x >=50 and x <=300 and y2 >=y and y2 <=y +30 then 
                    if sid64 then 
                        draw.SimpleText(nick .. " - " .. sid64, "DermaDefaultBold", 60,y +8 ,Color(255 ,0 ,0), TEXT_ALIGN_LEFT)
                    else 
                        draw.SimpleText(nick .. " - nil", "DermaDefaultBold", 60,y +8 ,Color(255 ,0 ,0), TEXT_ALIGN_LEFT)
                    end 
                else 
                    if sid64 then 
                        draw.SimpleText(nick .. " - " .. sid64, "DermaDefaultBold", 60,y +8 ,Color(255 ,255 ,255), TEXT_ALIGN_LEFT)
                    else 
                        draw.SimpleText(nick .. " - nil", "DermaDefaultBold", 60,y +8 ,Color(255 ,255 ,255), TEXT_ALIGN_LEFT)
                    end 
                end 
                y = y +40 
            end 
        end 
    end
end)

hook.Add("Think", "CopySteamID64", function()
    if input.IsMouseDown(MOUSE_LEFT) then
        local x,y = gui.MousePos()
        if x >=50 and x <=300 then 
            for i=1,#player.GetAll() do 
                local v = player.GetAll()[i]
                if y >=100+(i-1)*40 and y <=130+(i-1)*40 then
                    local sid64 = v:SteamID64()
                    SetClipboardText(sid64 or 'nil')
                    break
                end
            end
        end
    end
end)
