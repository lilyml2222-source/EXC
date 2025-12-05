local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SERENA EXC",
   LoadingTitle = "SERENA EXC Autowalk",
   LoadingSubtitle = "SERENA EXC",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SERENA EXC", 
      FileName = "SERENA EXC"
   },
   KeySystem = false,
})

-- ==================== WHITELIST SYSTEM ====================
local WhitelistURL = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/WL.txt"
local WhitelistedUsers = {}
local PlayerName = game.Players.LocalPlayer.Name

-- Discord Configuration
local DiscordInfo = {
    InviteLink = "https://discord.gg/Amy3YeJh29",
    Username = "@fscania",
    SupportChannel = "#support-tickets",
    WhitelistChannel = "#whitelist-request",
    AnnouncementChannel = "#announcements"
}

-- Fungsi load whitelist dari GitHub kamu
local function LoadWhitelist()
    print("[SERENA EXC] Memuat whitelist dari GitHub...")
    
    local success, response = pcall(function()
        return game:HttpGet(WhitelistURL)
    end)
    
    if success and response then
        WhitelistedUsers = {}
        
        -- Proses setiap baris dari file WL.txt
        for username in string.gmatch(response, "[^\r\n]+") do
            username = username:gsub("^%s*(.-)%s*$", "%1"):lower()
            if username ~= "" and username ~= " " then
                table.insert(WhitelistedUsers, username)
                print("[WHITELIST] ✓ " .. username)
            end
        end
        
        print("[SERENA EXC] Whitelist berhasil dimuat (" .. #WhitelistedUsers .. " user)")
        return true
    else
        warn("[SERENA EXC] Gagal mengambil whitelist dari GitHub!")
        return false
    end
end

-- Fungsi cek whitelist
local function IsWhitelisted(username)
    username = username:lower()
    
    for _, whitelistedName in ipairs(WhitelistedUsers) do
        if username == whitelistedName then
            return true
        end
    end
    
    return false
end

-- Fungsi copy ke clipboard
local function CopyToClipboard(text)
    pcall(function()
        setclipboard(text)
    end)
end

-- Fungsi cek posisi user di whitelist
local function GetWhitelistPosition(username)
    username = username:lower()
    for i, name in ipairs(WhitelistedUsers) do
        if name == username then
            return i
        end
    end
    return "N/A"
end

-- ==================== PROSES VERIFIKASI ====================
-- Load whitelist dulu
LoadWhitelist()

-- Cek apakah user ada di whitelist
if not IsWhitelisted(PlayerName) then
    Rayfield:Notify({
        Title = "❌ ACCESS DENIED",
        Content = "Username kamu tidak ada di whitelist!",
        Duration = 5,
        Image = 4483345998,
    })
    
    task.wait(2)
    
    -- Tampilkan info detail sebelum kick
    game.Players.LocalPlayer:Kick(
        "╔══════════════════════════════════════════╗\n" ..
        "║             SERENA EXC                   ║\n" ..
        "╠══════════════════════════════════════════╣\n" ..
        "║ ❌ AKUN TIDAK DI-WHITELIST               ║\n" ..
        "║                                          ║\n" ..
        "║ Username: " .. PlayerName .. string.rep(" ", 34 - #PlayerName) .. "║\n" ..
        "║                                          ║\n" ..
        "║ 📌 Join Discord untuk request whitelist  ║\n" ..
        "║                                          ║\n" ..
        "║ 🔗 Link: discord.gg/Amy3YeJh29           ║\n" ..
        "║                                          ║\n" ..
        "║ 👤 Admin: @fscania                       ║\n" ..
        "║ 📍 Channel: #whitelist-request           ║\n" ..
        "╚══════════════════════════════════════════╝"
    )
    return -- Stop script
end

-- Jika lolos whitelist
Rayfield:Notify({
    Title = "✅ ACCESS GRANTED",
    Content = "Selamat datang di SERENA EXC, " .. PlayerName .. "!",
    Duration = 3,
    Image = 4483345998,
})

print("[SERENA EXC] User " .. PlayerName .. " berhasil diverifikasi!")

-- ==================== TAB UTAMA - AUTO WALK ====================
local MainTab = Window:CreateTab("Main", 4483345998)

-- Header
MainTab:CreateParagraph({
    Title = "🚀 SERENA EXC AUTOWALK",
    Content = "Premium autowalk script dengan whitelist system"
})

-- DAFTAR SCRIPT MAP
local MapScripts = {
    ["MT BOTOL"]      = "https://raw.githubusercontent.com/lilyml2222-source/bttll/refs/heads/main/botol.lua",
    ["MT TALI"]       = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_Tali.lua",
    ["MT ZORA"]       = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_Zora.lua",
    ["MT ANEH PRO"]   = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_AnehPro.lua",
    ["MT LONELY"]     = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_Lonely.lua",
    ["MT ENTAH APA"]  = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_EntahApa.lua",
    ["MT ARUNIKA"]    = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_Arunika.lua",
    ["MT DAY ONE"]    = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_DayOne.lua",
    ["MT PENGANGGURAN"] = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_Pengangguran.lua",
    ["MT LEMBAYANA"]  = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_Lembayana.lua",
    ["MT NETIZEN"]    = "https://raw.githubusercontent.com/lilyml2222-source/EXC/refs/heads/main/Script_Netizen.lua",
}

-- Buat dropdown map
local MapList = {}
for Name, Link in pairs(MapScripts) do
    table.insert(MapList, Name)
end
table.sort(MapList)

MainTab:CreateDropdown({
   Name = "🎯 Select Map",
   Options = MapList,
   CurrentOption = {"-- Select Map --"},
   MultipleOptions = false,
   Flag = "MapDropdown",
   Callback = function(Option)
       local SelectedMap = Option[1] 
       local ScriptLink = MapScripts[SelectedMap]
       
       if ScriptLink then
           -- Cek whitelist lagi sebelum eksekusi
           if not IsWhitelisted(PlayerName) then
               game.Players.LocalPlayer:Kick("⚠️ Access revoked during session!")
               return
           end
           
           Rayfield:Notify({
               Title = "📂 Loading Script",
               Content = "Executing: " .. SelectedMap,
               Duration = 2,
               Image = 4483345998,
           })
           
           -- Eksekusi script map
           local success, errorMsg = pcall(function()
               loadstring(game:HttpGet(ScriptLink))()
           end)
           
           if success then
               print("[SERENA EXC] ✓ Script " .. SelectedMap .. " executed successfully")
               Rayfield:Notify({
                   Title = "✅ Success",
                   Content = "Script " .. SelectedMap .. " executed!",
                   Duration = 2,
                   Image = 4483345998,
               })
           else
               warn("[SERENA EXC] ✗ Failed to load script: " .. errorMsg)
               Rayfield:Notify({
                   Title = "❌ Error",
                   Content = "Failed to load script!\nCheck console for details.",
                   Duration = 3,
                   Image = 4483345998,
               })
           end
       else
           Rayfield:Notify({
               Title = "⚠️ Warning",
               Content = "Script for this map is not available",
               Duration = 3,
               Image = 4483345998,
           })
       end
   end,
})

-- Quick Status
MainTab:CreateLabel("👤 User: " .. PlayerName)
MainTab:CreateLabel("🟢 Status: Whitelisted")
MainTab:CreateLabel("📊 Total Maps: " .. #MapList)

-- ==================== TAB DISCORD ====================
local DiscordTab = Window:CreateTab("Discord", 4483345998)

-- Header dengan logo
DiscordTab:CreateParagraph({
    Title = "⚡ SERENA EXC DISCORD",
    Content = "Join our community for support, updates, and whitelist requests"
})

-- Card Link Discord
DiscordTab:CreateParagraph({
    Title = "🔗 Invitation Link",
    Content = "```" .. DiscordInfo.InviteLink .. "```"
})

-- Tombol Aksi
DiscordTab:CreateButton({
    Name = "📋 Copy Discord Link",
    Callback = function()
        CopyToClipboard(DiscordInfo.InviteLink)
        Rayfield:Notify({
            Title = "✅ Copied",
            Content = "Discord link copied to clipboard!",
            Duration = 2,
            Image = 4483345998,
        })
    end,
})

DiscordTab:CreateButton({
    Name = "🌐 Open in Browser",
    Callback = function()
        Rayfield:Notify({
            Title = "Opening Discord",
            Content = "Opening Discord in your browser...",
            Duration = 2,
            Image = 4483345998,
        })
        task.wait(1)
        -- Perbaikan: menggunakan syn.execute untuk membuka browser
        pcall(function()
            if syn and syn.execute then
                syn.execute("start " .. DiscordInfo.InviteLink)
            else
                -- Fallback untuk executor lain
                local HttpService = game:GetService("HttpService")
                HttpService:GetAsync(DiscordInfo.InviteLink, true)
            end
        end)
    end,
})

-- Informasi Channel
DiscordTab:CreateSection("📌 Important Channels")

DiscordTab:CreateParagraph({
    Title = DiscordInfo.WhitelistChannel,
    Content = "• Request whitelist access\n• Submit your Roblox username\n• Wait for admin approval"
})

DiscordTab:CreateParagraph({
    Title = DiscordInfo.SupportChannel,
    Content = "• Technical support\n• Bug reports\n• Script issues"
})

DiscordTab:CreateParagraph({
    Title = DiscordInfo.AnnouncementChannel,
    Content = "• Script updates\n• New features\n• Maintenance notices"
})

-- Contact Info
DiscordTab:CreateSection("👤 Contact Information")

DiscordTab:CreateParagraph({
    Title = "Admin Discord",
    Content = "```" .. DiscordInfo.Username .. "```"
})

DiscordTab:CreateButton({
    Name = "📋 Copy Username",
    Callback = function()
        CopyToClipboard(DiscordInfo.Username)
        Rayfield:Notify({
            Title = "✅ Copied",
            Content = "Admin username copied!",
            Duration = 2,
            Image = 4483345998,
        })
    end,
})

-- How to Request Whitelist
DiscordTab:CreateSection("📝 How to Request Whitelist")

DiscordTab:CreateParagraph({
    Content = "1. Join Discord server using link above\n" ..
             "2. Go to " .. DiscordInfo.WhitelistChannel .. " channel\n" ..
             "3. Send this format:\n" ..
             "```\n" ..
             "🎫 WHITELIST REQUEST\n" ..
             "• Roblox Username: " .. PlayerName .. "\n" ..
             "• Request Date: [Current Date]\n" ..
             "• Reason: [Your reason here]\n" ..
             "```\n" ..
             "4. Wait for admin approval (1-24 hours)"
})

-- ==================== TAB WHITELIST ====================
local WhitelistTab = Window:CreateTab("Whitelist", 4483345998)

-- User Status Card
WhitelistTab:CreateParagraph({
    Title = "👤 YOUR STATUS",
    Content = "Username: " .. PlayerName .. "\n" ..
             "Status: ✅ WHITELISTED\n" ..
             "Verified: " .. os.date("%Y-%m-%d")
})

-- Whitelist Statistics
WhitelistTab:CreateSection("📊 Statistics")

WhitelistTab:CreateLabel("Total Whitelisted Users: " .. #WhitelistedUsers)

-- PERBAIKAN: Fungsi dipisah untuk menghindari error
local userPosition = GetWhitelistPosition(PlayerName)
WhitelistTab:CreateLabel("Your Position: #" .. tostring(userPosition))

-- Whitelist Controls
WhitelistTab:CreateSection("🔄 Controls")

WhitelistTab:CreateButton({
    Name = "🔄 Refresh Whitelist",
    Callback = function()
        if LoadWhitelist() then
            -- Update position setelah refresh
            userPosition = GetWhitelistPosition(PlayerName)
            Rayfield:Notify({
                Title = "✅ Whitelist Updated",
                Content = "Total users: " .. #WhitelistedUsers .. "\nYour position: #" .. userPosition,
                Duration = 3,
                Image = 4483345998,
            })
        else
            Rayfield:Notify({
                Title = "❌ Update Failed",
                Content = "Check internet connection",
                Duration = 3,
                Image = 4483345998,
            })
        end
    end,
})

-- Sample Whitelisted Users
if #WhitelistedUsers > 0 then
    WhitelistTab:CreateSection("👥 Whitelisted Users")
    
    local sampleText = ""
    local count = 0
    for i = 1, math.min(10, #WhitelistedUsers) do
        if WhitelistedUsers[i] == PlayerName:lower() then
            sampleText = sampleText .. "👑 " .. WhitelistedUsers[i] .. " (YOU)\n"
        else
            sampleText = sampleText .. "• " .. WhitelistedUsers[i] .. "\n"
        end
        count = count + 1
    end
    
    if #WhitelistedUsers > 10 then
        sampleText = sampleText .. "... and " .. (#WhitelistedUsers - 10) .. " more users"
    end
    
    WhitelistTab:CreateParagraph({
        Title = "Recent Users (" .. count .. " shown)",
        Content = sampleText
    })
end

-- Whitelist Info
WhitelistTab:CreateSection("ℹ️ Information")

WhitelistTab:CreateParagraph({
    Title = "Source",
    Content = "```" .. WhitelistURL .. "```"
})

WhitelistTab:CreateParagraph({
    Title = "How Whitelist Works",
    Content = "• Admin edits WL.txt file on GitHub\n" ..
             "• Script fetches updated list automatically\n" ..
             "• Changes apply after refresh\n" ..
             "• Immediate effect for new sessions"
})

-- ==================== TAB ABOUT ====================
local AboutTab = Window:CreateTab("About", 4483345998)

-- Header
AboutTab:CreateParagraph({
    Title = "💎 SERENA EXC",
    Content = "Premium Autowalk Script System\nVersion: 3.0 • EXC Edition"
})

-- Features
AboutTab:CreateSection("✨ Features")

AboutTab:CreateParagraph({
    Content = "✅ Whitelist System\n" ..
             "✅ Auto Map Execution\n" ..
             "✅ Discord Integration\n" ..
             "✅ Real-time Updates\n" ..
             "✅ Secure Access Control"
})

-- Credits
AboutTab:CreateSection("👑 Credits")

AboutTab:CreateParagraph({
    Title = "Developer",
    Content = "lilyml2222-source\nGitHub: lilyml2222-source"
})

AboutTab:CreateParagraph({
    Title = "Discord Admin",
    Content = DiscordInfo.Username .. "\nServer: discord.gg/Amy3YeJh29"
})

-- Support
AboutTab:CreateSection("🆘 Support")

AboutTab:CreateParagraph({
    Content = "For issues or questions:\n" ..
             "1. Join our Discord\n" ..
             "2. Visit " .. DiscordInfo.SupportChannel .. "\n" ..
             "3. Tag " .. DiscordInfo.Username .. "\n" ..
             "4. Create a support ticket"
})

AboutTab:CreateButton({
    Name = "🐛 Report Bug",
    Callback = function()
        CopyToClipboard(DiscordInfo.InviteLink)
        Rayfield:Notify({
            Title = "Bug Report",
            Content = "Please report bugs in Discord!\nLink copied to clipboard.",
            Duration = 4,
            Image = 4483345998,
        })
    end,
})

-- Version Info
AboutTab:CreateSection("📋 Version Information")

AboutTab:CreateLabel("Script: SERENA EXC v3.0")
AboutTab:CreateLabel("Rayfield UI: Latest")
AboutTab:CreateLabel("Whitelist System: Active")
AboutTab:CreateLabel("Last Updated: " .. os.date("%Y-%m-%d"))

-- ==================== NOTIFIKASI AWAL ====================
Rayfield:Notify({
    Title = "⚡ SERENA EXC v3.0",
    Content = "Welcome " .. PlayerName .. "!\nPremium autowalk system loaded successfully.",
    Duration = 5,
    Image = 4483345998,
})

-- Console Log
print("╔══════════════════════════════════════════╗")
print("║           SERENA EXC v3.0                ║")
print("╠══════════════════════════════════════════╣")
print("║ User: " .. PlayerName .. string.rep(" ", 38 - #PlayerName) .. "║")
print("║ Status: WHITELISTED ✓                    ║")
print("║ Whitelist Users: " .. #WhitelistedUsers .. string.rep(" ", 24 - tostring(#WhitelistedUsers):len()) .. "║")
print("║ Discord: discord.gg/Amy3YeJh29           ║")
print("║ Admin: @fscania                          ║")
print("╚══════════════════════════════════════════╝")
