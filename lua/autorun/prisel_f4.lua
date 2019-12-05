if SERVER then
    util.AddNetworkString("prisel:f4:open")

    function MyMenu(ply)
        net.Start("prisel:f4:open")
        net.Send(ply)
    end

    hook.Add("ShowSpare2", "PriselHookF4", MyMenu)
end

if CLIENT then

	
	
    blur = Material("pp/blurscreen")

    function DrawBlur2(p, a, d)
        x, y = p:LocalToScreen(0, 0)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(blur)

        for i = 1, d do
            blur:SetFloat("$blur", (i / d) * (a))
            blur:Recompute()
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        end
    end

    local function drawRectOutline(x, y, w, h, color)
        surface.SetDrawColor(color)
        surface.DrawOutlinedRect(x, y, w, h)
    end

    net.Receive("prisel:f4:open", function()
        if IsValid(priselF4Frame) then
            priselF4Frame:Close()
        end

        priselF4Frame = vgui.Create("DFrame")
        priselF4Frame:SetSize(1000, 600)
        priselF4Frame:Center()
        priselF4Frame:MakePopup()
        priselF4Frame:SetDraggable(false)
        priselF4Frame:ShowCloseButton(false)
        priselF4Frame:SetTitle("")

        priselF4Frame.Paint = function(s, w, h)
            DrawBlur2(s, 3, 6)
            draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 220))
            draw.SimpleText("Prisel.fr", "DermaLarge", w / 2, 25, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        local ClosepriselF4Frame = vgui.Create("DButton", priselF4Frame)
        ClosepriselF4Frame:SetSize(50, 25)
        ClosepriselF4Frame:SetPos(950, 0)
        ClosepriselF4Frame:SetText("X")
        ClosepriselF4Frame:SetFont("PriselFront")
        ClosepriselF4Frame:SetTextColor(Color(255, 255, 255, 255))
        ClosepriselF4Frame.Paint = function() end

        ClosepriselF4Frame.DoClick = function()
            priselF4Frame:Close()
        end

        local Scroll = vgui.Create("DScrollPanel", priselF4Frame)
        Scroll:SetSize(1000, 25)
        Scroll:SetPos(200, 50)
        local List = vgui.Create("DIconLayout", Scroll)
        List:SetSize(1000, 25)
        List:SetPos(0, 0)
        List:SetSpaceY(0)
        List:SetSpaceX(0)
        local centerAcueil = vgui.Create("DPanel", priselF4Frame)
        centerAcueil:SetPos(5, 80)
        centerAcueil:SetSize(990, priselF4Frame:GetTall() - 85)

        centerAcueil.Paint = function()
            draw.RoundedBox(0, 0, 0, 500, 520, Color(30, 30, 30, 200))
            draw.RoundedBox(0, 505, 230, 490, 300, Color(30, 30, 30, 200))
            draw.RoundedBox(0, 505, 0, 490, 225, Color(30, 30, 30, 200))
            draw.WordBox(2, 300, 100, "   " .. LocalPlayer():GetName() .. "  ", "PriselFront", Color(30, 30, 30, 240), Color(255, 255, 255, 255))
            draw.WordBox(2, 300, 125, "   " .. LocalPlayer():GetUserGroup() .. "  ", "PriselFront", Color(30, 30, 30, 240), Color(255, 255, 255, 255))
            draw.WordBox(2, 300, 150, "   " .. LocalPlayer():SteamID() .. "  ", "PriselFront", Color(30, 30, 30, 240), Color(255, 255, 255, 255))
            draw.WordBox(2, 300, 175, "   " .. "$" .. formatNumberPrisel(LocalPlayer():getDarkRPVar("money")) .. "  ", "PriselFront", Color(30, 30, 30, 240), Color(255, 255, 255, 255))
            draw.WordBox(2, 300, 200, "   " .. LocalPlayer():getDarkRPVar("job") .. "  ", "PriselFront", Color(30, 30, 30, 240), Color(255, 255, 255, 255))
            draw.SimpleText(">  Commande roleplay", "PriselFront", 510, 235, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
            draw.SimpleText(">  Information roleplay", "PriselFront", 10, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
            draw.SimpleText(">  Message du serveur", "PriselFront", 510, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
            drawRectOutline(0, 0, 390, 520, Color(255, 255, 255, 1))
            drawRectOutline(395, 230, 445, 300, Color(255, 255, 255, 1))
            drawRectOutline(395, 0, 445, 225, Color(255, 255, 255, 1))
        end

        local PriselMessageJour = vgui.Create("DTextEntry", centerAcueil)
        PriselMessageJour:SetSize(400, 200)
        PriselMessageJour:SetPos(520, 40)
        PriselMessageJour:SetPaintBackground(false)
        PriselMessageJour:SetMultiline(true)
        PriselMessageJour:SetEditable(false)
        PriselMessageJour:SetFont("PriselFront")
        PriselMessageJour:SetTextColor(Color(255, 255, 255))
        PriselMessageJour:SetText("Nous vous souhaitons un bon jeu sur notre serveur")
        local PriselButtonDM = vgui.Create("DButton", centerAcueil)
        PriselButtonDM:SetSize(300, 25)
        PriselButtonDM:SetPos(600, 330)
        PriselButtonDM:SetText("Déposer de l'argent au sol")
        PriselButtonDM:SetTextColor(Color(255, 255, 255, 255))
        PriselButtonDM:SetFont("PriselFront")

        PriselButtonDM.OnCursorEntered = function(self)
            self.hover = true
        end

        PriselButtonDM.OnCursorExited = function(self)
            self.hover = false
        end

        PriselButtonDM.Paint = function(self, w, h)
            if self.hover then
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 90, 115, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 90, 115, 200))
            end

            PriselButtonDM.DoClick = function()
                priselF4Frame:Close()
                local FrameDM = vgui.Create("DFrame")
                FrameDM:SetSize(300, 100)
                FrameDM:Center()
                FrameDM:MakePopup()
                FrameDM:SetDraggable(false)
                FrameDM:ShowCloseButton(false)
                FrameDM:SetTitle("")

                FrameDM.Paint = function(self, w, h)
                    draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 240))
                    draw.SimpleText("DÃ©poser de l'argent au sol", "PriselFront", 150, 15, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER)
                end

                local CloseButtonDM = vgui.Create("DButton", FrameDM)
                CloseButtonDM:SetSize(50, 25)
                CloseButtonDM:SetPos(155, 65)
                CloseButtonDM:SetText("Annuler")
                CloseButtonDM:SetTextColor(Color(255, 255, 255, 200))

                CloseButtonDM.Paint = function(self, w, h)
                    draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))
                end

                CloseButtonDM.DoClick = function()
                    FrameDM:SetVisible(false)
                end

                local TextDM = vgui.Create("DTextEntry", FrameDM)
                TextDM:SetSize(280, 20)
                TextDM:Center()
                local ValideButtonDM = vgui.Create("DButton", FrameDM)
                ValideButtonDM:SetSize(50, 25)
                ValideButtonDM:SetPos(100, 65)
                ValideButtonDM:SetText("Valider")
                ValideButtonDM:SetTextColor(Color(255, 255, 255, 200))

                ValideButtonDM.Paint = function(self, w, h)
                    draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))
                end

                ValideButtonDM.DoClick = function()
                    FrameDM:Close()
                    LocalPlayer():ConCommand("say /dropmoney " .. TextDM:GetText())
                end
            end
        end

        local PriselButtonAJ = vgui.Create("DButton", centerAcueil)
        PriselButtonAJ:SetSize(300, 25)
        PriselButtonAJ:SetPos(600, 360)
        PriselButtonAJ:SetText("Donner de l'argent à un joueur")
        PriselButtonAJ:SetTextColor(Color(255, 255, 255, 255))
        PriselButtonAJ:SetFont("PriselFront")

        PriselButtonAJ.OnCursorEntered = function(self)
            self.hover = true
        end

        PriselButtonAJ.OnCursorExited = function(self)
            self.hover = false
        end

        PriselButtonAJ.Paint = function(self, w, h)
            if self.hover then
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 90, 115, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 90, 115, 200))
            end
        end

        PriselButtonAJ.DoClick = function()
            priselF4Frame:Close()
            local FrameDM = vgui.Create("DFrame")
            FrameDM:SetSize(300, 100)
            FrameDM:Center()
            FrameDM:MakePopup()
            FrameDM:SetDraggable(false)
            FrameDM:ShowCloseButton(false)
            FrameDM:SetTitle("")

            FrameDM.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 240))
                draw.SimpleText("Donner de l'argent à  la personne en face", "PriselFront", 150, 15, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER)
            end

            local CloseButtonDM = vgui.Create("DButton", FrameDM)
            CloseButtonDM:SetSize(50, 25)
            CloseButtonDM:SetPos(155, 65)
            CloseButtonDM:SetText("Annuler")
            CloseButtonDM:SetTextColor(Color(255, 255, 255, 200))

            CloseButtonDM.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))
            end

            CloseButtonDM.DoClick = function()
                FrameDM:SetVisible(false)
            end

            local TextDM = vgui.Create("DTextEntry", FrameDM)
            TextDM:SetSize(280, 20)
            TextDM:Center()
            local ValideButtonDM = vgui.Create("DButton", FrameDM)
            ValideButtonDM:SetSize(50, 25)
            ValideButtonDM:SetPos(100, 65)
            ValideButtonDM:SetText("Valider")
            ValideButtonDM:SetTextColor(Color(255, 255, 255, 200))

            ValideButtonDM.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))
            end

            ValideButtonDM.DoClick = function()
                FrameDM:Close()
                LocalPlayer():ConCommand("say /give " .. TextDM:GetText())
            end
        end

        local PriselButtonRPN = vgui.Create("DButton", centerAcueil)
        PriselButtonRPN:SetSize(300, 25)
        PriselButtonRPN:SetPos(600, 390)
        PriselButtonRPN:SetText("Redirection Boutique")
        PriselButtonRPN:SetTextColor(Color(255, 255, 255, 255))
        PriselButtonRPN:SetFont("PriselFront")

        PriselButtonRPN.OnCursorEntered = function(self)
            self.hover = true
        end

        PriselButtonRPN.OnCursorExited = function(self)
            self.hover = false
        end

        PriselButtonRPN.Paint = function(self, w, h)
            if self.hover then
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 90, 115, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 90, 115, 200))
            end
        end

        PriselButtonRPN.DoClick = function()
       		LocalPlayer():ConCommand("say !vip")
        end

        local PriselButtonAD = vgui.Create("DButton", centerAcueil)
        PriselButtonAD:SetSize(300, 25)
        PriselButtonAD:SetPos(600, 420)
        PriselButtonAD:SetText("Message aux administrteurs")
        PriselButtonAD:SetTextColor(Color(255, 255, 255, 255))
        PriselButtonAD:SetFont("PriselFront")

        PriselButtonAD.OnCursorEntered = function(self)
            self.hover = true
        end

        PriselButtonAD.OnCursorExited = function(self)
            self.hover = false
        end

        PriselButtonAD.Paint = function(self, w, h)
            if self.hover then
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 90, 115, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 90, 115, 200))
            end
        end

        PriselButtonAD.DoClick = function()
            priselF4Frame:Close()
            local FrameDM = vgui.Create("DFrame")
            FrameDM:SetSize(300, 100)
            FrameDM:Center()
            FrameDM:MakePopup()
            FrameDM:SetDraggable(false)
            FrameDM:ShowCloseButton(false)
            FrameDM:SetTitle("")

            FrameDM.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 240))
                draw.SimpleText("Envoyez un message aux administrteurs", "PriselFront", 150, 15, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER)
            end

            local CloseButtonDM = vgui.Create("DButton", FrameDM)
            CloseButtonDM:SetSize(50, 25)
            CloseButtonDM:SetPos(155, 65)
            CloseButtonDM:SetText("Annuler")
            CloseButtonDM:SetTextColor(Color(255, 255, 255, 200))

            CloseButtonDM.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))
            end

            CloseButtonDM.DoClick = function()
                FrameDM:SetVisible(false)
            end

            local TextDM = vgui.Create("DTextEntry", FrameDM)
            TextDM:SetSize(280, 20)
            TextDM:Center()
            local ValideButtonDM = vgui.Create("DButton", FrameDM)
            ValideButtonDM:SetSize(50, 25)
            ValideButtonDM:SetPos(100, 65)
            ValideButtonDM:SetText("Valider")
            ValideButtonDM:SetTextColor(Color(255, 255, 255, 200))

            ValideButtonDM.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))
            end

            ValideButtonDM.DoClick = function()
                FrameDM:Close()
                LocalPlayer():ConCommand("say /adminhelp " .. TextDM:GetText())
            end
        end

        local PriselJobModel3 = vgui.Create("DModelPanel", centerAcueil)
        PriselJobModel3:SetPos(centerAcueil:GetWide() / 2 - 400, 50)
        PriselJobModel3:SetSize(200, 500)
        PriselJobModel3:SetModel(LocalPlayer():GetModel())
        PriselJobModel3.LayoutEntity = function() return false end
        PriselJobModel3:SetFOV(10)
        PriselJobModel3:SetCamPos(Vector(200, 0, 70))
        PriselJobModel3:SetLookAt(Vector(0, 0, 30))
        PriselJobModel3.Entity:SetEyeTarget(Vector(200, 200, 200))
        local centerJob = vgui.Create("DPanel", priselF4Frame)
        centerJob:SetPos(5, 80)
        centerJob:SetSize(990, priselF4Frame:GetTall() - 35)
        centerJob:SetVisible(false)
        centerJob.Paint = function() end
        local ScrollJobs = vgui.Create("DScrollPanel", centerJob)
        ScrollJobs:SetSize(1010, priselF4Frame:GetTall() - 35)
        ScrollJobs:SetPos(0, 0)
        local ListJobs = vgui.Create("DIconLayout", ScrollJobs)
        ListJobs:SetSize(750, priselF4Frame:GetTall() - 35)
        ListJobs:SetPos(0, 0)
        ListJobs:SetSpaceY(0)
        ListJobs:SetSpaceX(0)

        for k, v in pairs(DarkRP.getCategories().jobs) do
            local actual = 0

            for _, c in pairs(RPExtraTeams) do
                if v.name == c.category then
                    actual = actual + 1
                end
            end

            if actual == 1 or actual == 2 then
                actual = 1
            end

            if actual == 3 or actual == 4 then
                actual = 2
            end

            if actual == 5 or actual == 6 then
                actual = 3
            end

            if actual == 7 or actual == 8 then
                actual = 4
            end

            if actual == 9 or actual == 10 then
                actual = 5
            end

            if actual == 11 or actual == 12 then
                actual = 6
            end

            if actual == 13 or actual == 14 then
                actual = 7
            end

            if actual == 15 or actual == 16 then
                actual = 8
            end

            if actual == 17 or actual == 18 then
                actual = 9
            end

            if actual == 19 or actual == 20 then
                actual = 10
            end

            if actual == 21 or actual == 22 then
                actual = 11
            end

            if actual == 23 or actual == 24 then
                actual = 12
            end

            if actual == 25 or actual == 26 then
                actual = 13
            end

            if actual == 27 or actual == 28 then
                actual = 14
            end

            if actual == 29 or actual == 30 then
                actual = 15
            end

            local category = ListJobs:Add("DPanel")
            category:SetSize(990, 25 + (actual * 50))

            category.Paint = function(s, w, h)
                draw.RoundedBox(0, 0, 0, w, 25, Color(30, 30, 30, 200))
                draw.SimpleText(">  " .. v.name, "PriselFront", 10, 5, Color(230, 230, 230), TEXT_ALIGN_LEFT)
            end

            local ScrollJobList = vgui.Create("DScrollPanel", category)
            ScrollJobList:SetSize(category:GetWide(), category:GetTall() - 25)
            ScrollJobList:SetPos(0, 25)
            local ListJobList = vgui.Create("DIconLayout", ScrollJobList)
            ListJobList:SetSize(990, priselF4Frame:GetTall() - 10)
            ListJobList:SetPos(0, 0)
            ListJobList:SetSpaceY(0)
            ListJobList:SetSpaceX(0)

            for d, j in pairs(RPExtraTeams) do
                if v.name == j.category then
                    local job = ListJobList:Add("DButton")
                    job:SetSize(ListJobList:GetWide() / 2.5, 50)
                    job:SetPos(0, (d * 52))
                    job:SetText("")

                    job.OnCursorEntered = function(self)
                        self.hover = true
                    end

                    job.OnCursorExited = function(self)
                        self.hover = false
                    end

                    job.Paint = function(self, w, h)
                        if self.hover then
                            draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 255))
                        else
                            draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 200))
                        end

                        draw.SimpleText(j.name, "PriselFront", 60, 10, Color(255, 255, 255, 255))

                        for k, v in pairs(player.GetAll()) do
                            draw.SimpleText(team.NumPlayers(j['team']) .. "/" .. j.max, "PriselFront", 60, 25, Color(255, 255, 255, 255))
                        end

                        drawRectOutline(0, 0, w, h, Color(255, 255, 255, 1))
                    end

                    job.DoClick = function()
                        if IsValid(PriselInfoJob2) then
                            PriselInfoJob2:Close()
                        end

                        if istable(j.model) then
                            job_mdl = j.model[1]
                        else
                            job_mdl = j.model
                        end

                        if IsValid(PriselInfoJob) then
                            PriselInfoJob:Close()
                        end

                        PriselInfoJob = vgui.Create("DFrame", priselF4Frame)
                        PriselInfoJob:SetSize(245, 520)
                        PriselInfoJob:SetPos(755, 80)
                        PriselInfoJob:SetDraggable(false)
                        PriselInfoJob:ShowCloseButton(false)
                        PriselInfoJob:SetTitle("")

                        PriselInfoJob.Paint = function(self, w, h)
                            draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))
                            draw.SimpleText(j.name, "PriselFront2", 245 / 2, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
                        end

                        local PriselJobModel = vgui.Create("DModelPanel", PriselInfoJob)
                        PriselJobModel:SetPos(45 / 2, 40)
                        PriselJobModel:SetSize(200, 200)
                        PriselJobModel:SetModel(job_mdl)
                        PriselJobModel.LayoutEntity = function() return false end
                        PriselJobModel:SetFOV(55)
                        PriselJobModel:SetCamPos(Vector(25, 0, 64))
                        PriselJobModel:SetLookAt(Vector(0, 0, 62))
                        PriselJobModel.Entity:SetEyeTarget(Vector(200, 200, 100))
                        local PriselJobDescription = vgui.Create("DTextEntry", PriselInfoJob)
                        PriselJobDescription:SetSize(200, 200)
                        PriselJobDescription:SetPos(45 / 2, 250)
                        PriselJobDescription:SetPaintBackground(false)
                        PriselJobDescription:SetMultiline(true)
                        PriselJobDescription:SetEditable(false)
                        PriselJobDescription:SetFont("PriselFront")
                        PriselJobDescription:SetTextColor(Color(255, 255, 255))
                        PriselJobDescription:SetText(j.description)
                        local PriselButtonValide = vgui.Create("DButton", PriselInfoJob)
                        PriselButtonValide:SetSize(80, 25)
                        PriselButtonValide:SetPos(80, 480)
                        PriselButtonValide:SetText("Valider")
                        PriselButtonValide:SetTextColor(Color(255, 255, 255, 255))
                        PriselButtonValide:SetFont("PriselFront")

                        PriselButtonValide.Paint = function(self, w, h)
                            draw.RoundedBox(0, 0, 0, w, h, Color(40, 90, 115, 255))
                        end

                        PriselButtonValide.DoClick = function()
                            if j.vote then
                                LocalPlayer():ConCommand("say /vote" .. j.command)
                            else
                                LocalPlayer():ConCommand("say /" .. j.command)
                            end

                            priselF4Frame:Close()
                        end
                    end

                    if istable(j.model) then
                        job_mdl = j.model[1]
                    else
                        job_mdl = j.model
                    end

                    JobSpawnIcon = vgui.Create("SpawnIcon", job)
                    JobSpawnIcon:SetSize(50, 50)
                    JobSpawnIcon:SetPos(0, 0)
                    JobSpawnIcon:SetModel(job_mdl)
                end
            end
        end

        local centerEntities = vgui.Create("DPanel", priselF4Frame)
        centerEntities:SetPos(5, 80)
        centerEntities:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        centerEntities:SetVisible(false)
        centerEntities.Paint = function() end
        local ScrollEntities = vgui.Create("DScrollPanel", centerEntities)
        ScrollEntities:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        ScrollEntities:SetPos(0, 0)
        local ListEntities = vgui.Create("DIconLayout", ScrollEntities)
        ListEntities:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        ListEntities:SetPos(0, 0)
        ListEntities:SetSpaceY(1)
        ListEntities:SetSpaceX(0)

        for k, v in pairs(DarkRP.getCategories().entities) do
            local actual = 0

            for _, c in pairs(DarkRPEntities) do
                if v.name == c.category then
                    actual = actual + 1
                end
            end

            if actual == 1 or actual == 2 then
                actual = 1
            end

            if actual == 3 or actual == 4 then
                actual = 2
            end

            if actual == 5 or actual == 6 then
                actual = 3
            end

            if actual == 7 or actual == 8 then
                actual = 4
            end

            if actual == 9 or actual == 10 then
                actual = 5
            end

            if actual == 11 or actual == 12 then
                actual = 6
            end

            if actual == 13 or actual == 14 then
                actual = 7
            end

            if actual == 15 or actual == 16 then
                actual = 8
            end

            if actual == 17 or actual == 18 then
                actual = 9
            end

            if actual == 19 or actual == 20 then
                actual = 10
            end

            if actual == 21 or actual == 22 then
                actual = 11
            end

            if actual == 23 or actual == 24 then
                actual = 12
            end

            if actual == 25 or actual == 26 then
                actual = 13
            end

            if actual == 27 or actual == 28 then
                actual = 14
            end

            if actual == 29 or actual == 30 then
                actual = 15
            end

            local category = ListEntities:Add("DPanel")
            category:SetSize(990, 25 + (actual * 50))

            category.Paint = function(s, w, h)
                draw.RoundedBox(0, 0, 0, w, 25, Color(30, 30, 30, 200))
                draw.SimpleText(">  " .. v.name, "PriselFront", 10, 5, Color(230, 230, 230), TEXT_ALIGN_LEFT)
            end

            local ScrollJobList = vgui.Create("DScrollPanel", category)
            ScrollJobList:SetSize(category:GetWide(), category:GetTall() - 25)
            ScrollJobList:SetPos(0, 25)
            local ListJobList = vgui.Create("DIconLayout", ScrollJobList)
            ListJobList:SetSize(990, priselF4Frame:GetTall() - 85)
            ListJobList:SetPos(0, 0)
            ListJobList:SetSpaceY(0)
            ListJobList:SetSpaceX(0)
            local ShowThisItem = true

            for d, j in ipairs(DarkRPEntities) do
                if istable(j.allowed) and not table.HasValue(j.allowed, LocalPlayer():Team()) then
                    ShowThisItem = false
                end

                if j.customCheck and not j.customCheck(LocalPlayer()) then
                    ShowThisItem = false
                end

                if v.name == j.category then
                    if ShowThisItem == true then
                        local job = ListJobList:Add("DPanel")
                        job:SetSize(ListJobList:GetWide() / 2, 50)
                        job:SetPos(0, (d * 52))

                        job.OnCursorEntered = function(self)
                            self.hover = true
                        end

                        job.OnCursorExited = function(self)
                            self.hover = false
                        end

                        job.Paint = function(self, w, h)
                            if self.hover then
                                draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 255))
                            else
                                draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 200))
                            end

                            draw.SimpleText(j.name, "PriselFront", 60, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                            draw.SimpleText("$" .. j.price, "PriselFront", 60, 25, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                            drawRectOutline(0, 0, w, h, Color(255, 255, 255, 1))
                        end

                        local PriselButtonValide = vgui.Create("DButton", job)
                        PriselButtonValide:SetSize(50, 25)
                        PriselButtonValide:SetPos(430, 10)
                        PriselButtonValide:SetText("Valider")
                        PriselButtonValide:SetTextColor(Color(255, 255, 255, 255))
                        PriselButtonValide:SetFont("PriselFront")

                        PriselButtonValide.Paint = function(self, w, h)
                            draw.RoundedBox(0, 0, 0, w, h, Color(40, 90, 115, 255))
                        end

                        PriselButtonValide.DoClick = function()
                            LocalPlayer():ConCommand("say /" .. j['cmd'])
                        end

                        JobSpawnIcon = vgui.Create("SpawnIcon", job)
                        JobSpawnIcon:SetSize(50, 50)
                        JobSpawnIcon:SetPos(0, 0)
                        JobSpawnIcon:SetModel(j.model)
                    end
                end
            end
        end

        local centerWeapons = vgui.Create("DPanel", priselF4Frame)
        centerWeapons:SetPos(5, 80)
        centerWeapons:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        centerWeapons:SetVisible(false)
        centerWeapons.Paint = function() end
        local ScrollWeapons = vgui.Create("DScrollPanel", centerWeapons)
        ScrollWeapons:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        ScrollWeapons:SetPos(0, 0)
        local ListWeapons = vgui.Create("DIconLayout", ScrollWeapons)
        ListWeapons:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        ListWeapons:SetPos(0, 0)
        ListWeapons:SetSpaceY(1)
        ListWeapons:SetSpaceX(0)

        for k, v in pairs(DarkRP.getCategories().weapons) do
            for d, j in pairs(CustomShipments) do
                if v.name == j.category then
                    if j.noship == true then
                        if table.HasValue(j.allowed, LocalPlayer():Team()) then
                            local job = ListWeapons:Add("DPanel")
                            job:SetSize(ListWeapons:GetWide() / 2, 50)
                            job:SetPos(0, (d * 52))

                            job.OnCursorEntered = function(self)
                                self.hover = true
                            end

                            job.OnCursorExited = function(self)
                                self.hover = false
                            end

                            job.Paint = function(self, w, h)
                                if self.hover then
                                    draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 255))
                                else
                                    draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 200))
                                end

                                draw.SimpleText(j.name, "PriselFront", 60, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                                draw.SimpleText("$" .. j.price, "PriselFront", 60, 25, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                                drawRectOutline(0, 0, w, h, Color(255, 255, 255, 1))
                            end

                            local PriselButtonValide3 = vgui.Create("DButton", job)
                            PriselButtonValide3:SetSize(50, 25)
                            PriselButtonValide3:SetPos(430, 10)
                            PriselButtonValide3:SetText("Valider")
                            PriselButtonValide3:SetTextColor(Color(255, 255, 255, 255))
                            PriselButtonValide3:SetFont("PriselFront")

                            PriselButtonValide3.Paint = function(self, w, h)
                                draw.RoundedBox(0, 0, 0, w, h, Color(40, 90, 115, 255))
                            end

                            PriselButtonValide3.DoClick = function()
                                RunConsoleCommand("DarkRP", "buy", j.name)
                            end

                            JobSpawnIcon3 = vgui.Create("SpawnIcon", job)
                            JobSpawnIcon3:SetSize(50, 50)
                            JobSpawnIcon3:SetPos(0, 0)
                            JobSpawnIcon3:SetModel(j.model)
                        end
                    end
                end
            end
        end

        local centerCaisse = vgui.Create("DPanel", priselF4Frame)
        centerCaisse:SetPos(5, 80)
        centerCaisse:SetSize(990, priselF4Frame:GetTall() - 35)
        centerCaisse:SetVisible(false)
        centerCaisse.Paint = function() end
        local ScrollCaisse = vgui.Create("DScrollPanel", centerCaisse)
        ScrollCaisse:SetSize(1010, priselF4Frame:GetTall() - 35)
        ScrollCaisse:SetPos(0, 0)
        local ListCaisse = vgui.Create("DIconLayout", ScrollCaisse)
        ListCaisse:SetSize(990, priselF4Frame:GetTall() - 35)
        ListCaisse:SetPos(0, 0)
        ListCaisse:SetSpaceY(0)
        ListCaisse:SetSpaceX(0)

        for d, j in pairs(FoodItems) do
            local job = ListCaisse:Add("DPanel")
            job:SetSize(ListCaisse:GetWide() / 2, 50)
            job:SetPos(0, (d * 52))

            job.OnCursorEntered = function(self)
                self.hover = true
            end

            job.OnCursorExited = function(self)
                self.hover = false
            end

            job.Paint = function(self, w, h)
                if self.hover then
                    draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 255))
                else
                    draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 200))
                end

                draw.SimpleText(j.name, "PriselFront", 60, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                draw.SimpleText("$" .. j.price, "PriselFront", 60, 25, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                drawRectOutline(0, 0, w, h, Color(255, 255, 255, 1))
            end

            local PriselButtonValide3 = vgui.Create("DButton", job)
            PriselButtonValide3:SetSize(50, 25)
            PriselButtonValide3:SetPos(430, 10)
            PriselButtonValide3:SetText("Valider")
            PriselButtonValide3:SetTextColor(Color(255, 255, 255, 255))
            PriselButtonValide3:SetFont("PriselFront")

            PriselButtonValide3.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(40, 90, 115, 255))
            end

            PriselButtonValide3.DoClick = function()
                RunConsoleCommand("DarkRP", "buyfood", j.name)
            end

            JobSpawnIcon3 = vgui.Create("SpawnIcon", job)
            JobSpawnIcon3:SetSize(50, 50)
            JobSpawnIcon3:SetPos(0, 0)
            JobSpawnIcon3:SetModel(j.model)
        end

        local centerAmmos = vgui.Create("DPanel", priselF4Frame)
        centerAmmos:SetPos(5, 80)
        centerAmmos:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        centerAmmos:SetVisible(false)
        centerAmmos.Paint = function() end
        local ScrollAmmos = vgui.Create("DScrollPanel", centerAmmos)
        ScrollAmmos:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        ScrollAmmos:SetPos(0, 0)
        local ListAmmos = vgui.Create("DIconLayout", ScrollAmmos)
        ListAmmos:SetSize(priselF4Frame:GetWide() - 10, priselF4Frame:GetTall() - 85)
        ListAmmos:SetPos(0, 0)
        ListAmmos:SetSpaceY(1)
        ListAmmos:SetSpaceX(0)

        for k, v in pairs(DarkRP.getCategories().ammo) do
            local actual = 0

            for _, c in pairs(GAMEMODE.AmmoTypes) do
                if v.name == c.category then
                    actual = actual + 1
                end
            end

            if actual == 1 or actual == 2 then
                actual = 1
            end

            if actual == 3 or actual == 4 then
                actual = 2
            end

            if actual == 5 or actual == 6 then
                actual = 3
            end

            if actual == 7 or actual == 8 then
                actual = 4
            end

            if actual == 9 or actual == 10 then
                actual = 5
            end

            if actual == 11 or actual == 12 then
                actual = 6
            end

            if actual == 13 or actual == 14 then
                actual = 7
            end

            if actual == 15 or actual == 16 then
                actual = 8
            end

            if actual == 17 or actual == 18 then
                actual = 9
            end

            if actual == 19 or actual == 20 then
                actual = 10
            end

            if actual == 21 or actual == 22 then
                actual = 11
            end

            if actual == 23 or actual == 24 then
                actual = 12
            end

            if actual == 25 or actual == 26 then
                actual = 13
            end

            if actual == 27 or actual == 28 then
                actual = 14
            end

            if actual == 29 or actual == 30 then
                actual = 15
            end

            local category = ListAmmos:Add("DPanel")
            category:SetSize(990, 25 + (actual * 50))

            category.Paint = function(s, w, h)
                draw.RoundedBox(0, 0, 0, w, 25, Color(30, 30, 30, 200))
                draw.SimpleText(">  " .. v.name, "PriselFront", 10, 5, Color(230, 230, 230), TEXT_ALIGN_LEFT)
            end

            local ScrollJobList = vgui.Create("DScrollPanel", category)
            ScrollJobList:SetSize(category:GetWide(), category:GetTall() - 25)
            ScrollJobList:SetPos(0, 25)
            local ListJobList = vgui.Create("DIconLayout", ScrollJobList)
            ListJobList:SetSize(990, priselF4Frame:GetTall() - 85)
            ListJobList:SetPos(0, 0)
            ListJobList:SetSpaceY(0)
            ListJobList:SetSpaceX(0)

            for d, j in pairs(GAMEMODE.AmmoTypes) do
                if v.name == j.category then
                    local job = ListJobList:Add("DPanel")
                    job:SetSize(ListJobList:GetWide() / 2, 50)
                    job:SetPos(0, (d * 52))

                    job.OnCursorEntered = function(self)
                        self.hover = true
                    end

                    job.OnCursorExited = function(self)
                        self.hover = false
                    end

                    job.Paint = function(self, w, h)
                        if self.hover then
                            draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 255))
                        else
                            draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 200))
                        end

                        draw.SimpleText(j.name, "PriselFront", 60, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                        draw.SimpleText("$" .. j.price, "PriselFront", 60, 25, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                        drawRectOutline(0, 0, w, h, Color(255, 255, 255, 1))
                    end

                    local PriselButtonValide4 = vgui.Create("DButton", job)
                    PriselButtonValide4:SetSize(50, 25)
                    PriselButtonValide4:SetPos(430, 10)
                    PriselButtonValide4:SetText("Valider")
                    PriselButtonValide4:SetTextColor(Color(255, 255, 255, 255))
                    PriselButtonValide4:SetFont("PriselFront")

                    PriselButtonValide4.Paint = function(self, w, h)
                        draw.RoundedBox(0, 0, 0, w, h, Color(40, 90, 115, 255))
                    end

                    PriselButtonValide4.DoClick = function()
                        LocalPlayer():ConCommand("say /buyammo " .. j.ammoType)
                    end

                    JobSpawnIcon4 = vgui.Create("SpawnIcon", job)
                    JobSpawnIcon4:SetSize(50, 50)
                    JobSpawnIcon4:SetPos(0, 0)
                    JobSpawnIcon4:SetModel(j.model)
                end
            end
        end

        local centerForum = vgui.Create("DPanel", priselF4Frame)
        centerForum:SetPos(5, 80)
        centerForum:SetSize(990, priselF4Frame:GetTall() - 85)
        centerForum:SetVisible(false)

        centerForum.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, 25, Color(30, 30, 30, 200))
            draw.SimpleText(">  Notre forum", "PriselFront", 10, 5, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
        end

        PriselDHTML = vgui.Create("DHTML", centerForum)
        PriselDHTML:SetSize(1010, priselF4Frame:GetTall() - 110)
        PriselDHTML:SetPos(0, 25)
        PriselDHTML:OpenURL("https://steamcommunity.com/id/prisel")
        local aceuil = List:Add("DButton")
        aceuil:SetText("Accueil")
        aceuil:SetSize(90, 25)
        aceuil:SetFont("PriselFront2")
        aceuil:SetTextColor(Color(255, 255, 255, 255))
        aceuil.Paint = function() end

        aceuil.OnCursorEntered = function()
            aceuil:SetFont("PriselFront7")
        end

        aceuil.OnCursorExited = function()
            aceuil:SetFont("PriselFront2")
        end

        aceuil.DoClick = function()
            centerAcueil:SetVisible(true)
            centerJob:SetVisible(false)
            centerEntities:SetVisible(false)
            centerWeapons:SetVisible(false)
            centerAmmos:SetVisible(false)
            centerForum:SetVisible(false)
            centerCaisse:SetVisible(false)

            if IsValid(PriselInfoJob) then
                PriselInfoJob:Close()
            end

            if IsValid(PriselInfoJob2) then
                PriselInfoJob2:Remove()
            end
        end

        local jobp = List:Add("DButton")
        jobp:SetText("Métiers")
        jobp:SetSize(90, 25)
        jobp:SetFont("PriselFront2")
        jobp:SetTextColor(Color(255, 255, 255, 255))
        jobp.Paint = function() end

        jobp.OnCursorEntered = function()
            jobp:SetFont("PriselFront7")
        end

        jobp.OnCursorExited = function()
            jobp:SetFont("PriselFront2")
        end

        jobp.DoClick = function()
            centerJob:SetVisible(true)
            centerEntities:SetVisible(false)
            centerWeapons:SetVisible(false)
            centerAmmos:SetVisible(false)
            centerForum:SetVisible(false)
            centerAcueil:SetVisible(false)
            centerCaisse:SetVisible(false)

            if IsValid(PriselInfoJob) then
                PriselInfoJob:Close()
            end

            if IsValid(PriselInfoJob2) then
                PriselInfoJob2:Remove()
            end

            PriselInfoJob2 = vgui.Create("DFrame", priselF4Frame)
            PriselInfoJob2:SetSize(245, 520)
            PriselInfoJob2:SetPos(755, 80)
            PriselInfoJob2:SetDraggable(false)
            PriselInfoJob2:ShowCloseButton(false)
            PriselInfoJob2:SetTitle("")
            PriselInfoJob2:SetVisible(true)

            PriselInfoJob2.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))
                draw.SimpleText(LocalPlayer():getDarkRPVar("job"), "PriselFront2", 245 / 2, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            end

            local PriselJobModel2 = vgui.Create("DModelPanel", PriselInfoJob2)
            PriselJobModel2:SetPos(45 / 2, 40)
            PriselJobModel2:SetSize(200, 500)
            PriselJobModel2:SetModel(LocalPlayer():GetModel())
            PriselJobModel2.LayoutEntity = function() return false end
            PriselJobModel2:SetFOV(10)
            PriselJobModel2:SetCamPos(Vector(200, 0, 70))
            PriselJobModel2:SetLookAt(Vector(0, 0, 30))
            PriselJobModel2.Entity:SetEyeTarget(Vector(200, 200, 200))
        end

        local entp = List:Add("DButton")
        entp:SetText("Entités")
        entp:SetSize(90, 25)
        entp:SetFont("PriselFront2")
        entp:SetTextColor(Color(255, 255, 255, 255))
        entp.Paint = function() end

        entp.OnCursorEntered = function()
            entp:SetFont("PriselFront7")
        end

        entp.OnCursorExited = function()
            entp:SetFont("PriselFront2")
        end

        entp.DoClick = function()
            centerJob:SetVisible(false)
            centerEntities:SetVisible(true)
            centerWeapons:SetVisible(false)
            centerAmmos:SetVisible(false)
            centerForum:SetVisible(false)
            centerCaisse:SetVisible(false)
            centerAcueil:SetVisible(false)

            if IsValid(PriselInfoJob) then
                PriselInfoJob:Close()
            end

            if IsValid(PriselInfoJob2) then
                PriselInfoJob2:Close()
            end
        end

        local weaponsP = List:Add("DButton")
        weaponsP:SetText("Armes")
        weaponsP:SetSize(90, 25)
        weaponsP:SetFont("PriselFront2")
        weaponsP:SetTextColor(Color(255, 255, 255, 255))
        weaponsP.Paint = function() end

        weaponsP.OnCursorEntered = function()
            weaponsP:SetFont("PriselFront7")
        end

        weaponsP.OnCursorExited = function()
            weaponsP:SetFont("PriselFront2")
        end

        weaponsP.DoClick = function()
            centerJob:SetVisible(false)
            centerEntities:SetVisible(false)
            centerWeapons:SetVisible(true)
            centerAmmos:SetVisible(false)
            centerForum:SetVisible(false)
            centerCaisse:SetVisible(false)
            centerAcueil:SetVisible(false)

            if IsValid(PriselInfoJob) then
                PriselInfoJob:Close()
            end

            if IsValid(PriselInfoJob2) then
                PriselInfoJob2:Close()
            end
        end

        local Caisses = List:Add("DButton")
        Caisses:SetText("Nourritures")
        Caisses:SetSize(120, 25)
        Caisses:SetFont("PriselFront2")
        Caisses:SetTextColor(Color(255, 255, 255, 255))
        Caisses.Paint = function() end

        Caisses.OnCursorEntered = function()
            Caisses:SetFont("PriselFront7")
        end

        Caisses.OnCursorExited = function()
            Caisses:SetFont("PriselFront2")
        end

        Caisses.DoClick = function()
            centerJob:SetVisible(false)
            centerEntities:SetVisible(false)
            centerWeapons:SetVisible(false)
            centerAmmos:SetVisible(false)
            centerForum:SetVisible(false)
            centerAcueil:SetVisible(false)
            centerCaisse:SetVisible(true)

            if IsValid(PriselInfoJob) then
                PriselInfoJob:Close()
            end

            if IsValid(PriselInfoJob2) then
                PriselInfoJob2:Close()
            end
        end

        local ammosP = List:Add("DButton")
        ammosP:SetText("Munitions")
        ammosP:SetSize(90, 25)
        ammosP:SetFont("PriselFront2")
        ammosP:SetTextColor(Color(255, 255, 255, 255))
        ammosP.Paint = function() end

        ammosP.OnCursorEntered = function()
            ammosP:SetFont("PriselFront7")
        end

        ammosP.OnCursorExited = function()
            ammosP:SetFont("PriselFront2")
        end

        ammosP.DoClick = function()
            centerJob:SetVisible(false)
            centerEntities:SetVisible(false)
            centerWeapons:SetVisible(false)
            centerAmmos:SetVisible(true)
            centerForum:SetVisible(false)
            centerAcueil:SetVisible(false)
            centerCaisse:SetVisible(false)

            if IsValid(PriselInfoJob) then
                PriselInfoJob:Close()
            end

            if IsValid(PriselInfoJob2) then
                PriselInfoJob2:Close()
            end
        end

        local forum = List:Add("DButton")
        forum:SetText("Forum")
        forum:SetSize(90, 25)
        forum:SetFont("PriselFront2")
        forum:SetTextColor(Color(255, 255, 255, 255))
        forum.Paint = function() end

        forum.OnCursorEntered = function()
            forum:SetFont("PriselFront7")
        end

        forum.OnCursorExited = function()
            forum:SetFont("PriselFront2")
        end

        forum.DoClick = function()
            if IsValid(PriselInfoJob) then
                PriselInfoJob:Close()
            end

            if IsValid(PriselInfoJob2) then
                PriselInfoJob2:Close()
            end

            centerJob:SetVisible(false)
            centerEntities:SetVisible(false)
            centerWeapons:SetVisible(false)
            centerAmmos:SetVisible(false)
            centerForum:SetVisible(true)
            centerAcueil:SetVisible(false)
            centerCaisse:SetVisible(false)
        end
    end)
end
