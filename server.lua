RegisterNetEvent(FileName..':server:send', function(playerId, amount, reason)
    local biller = QBCore.Functions.GetPlayer(source)
    local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
    local amount = tonumber(amount)
    if billed ~= nil then
        if amount and amount > 0 then
            if Config.oxmysql >= 187 then
                exports.oxmysql:insert('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (:citizenid, :amount, :society, :sender)', {
                    ['citizenid'] = billed.PlayerData.citizenid,
                    ['amount'] = amount,
                    ['society'] = biller.PlayerData.job.name,
                    ['sender'] = biller.PlayerData.charinfo.firstname
                })
            else
                MySQL.Async.execute('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (:citizenid, :amount, :society, :sender)', {
                    ['citizenid'] = billed.PlayerData.citizenid,
                    ['amount'] = amount,
                    ['society'] = biller.PlayerData.job.name,
                    ['sender'] = biller.PlayerData.charinfo.firstname
                })
            end
            TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
            TriggerClientEvent('QBCore:Notify', source, Lang.sendsuccess, 'success')
            TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, Lang.newinvoice)
            TriggerClientEvent(FileName..':client:sendBillingMail', playerId, biller.PlayerData.job.name, amount, reason, billed.PlayerData.citizenid)
            TriggerEvent(FileName..':server:CreateLog', 'logbill', 'Hóa Đơn', 'blue', '**'..biller.PlayerData.charinfo.firstname..'** ('..biller.PlayerData.citizenid..') đã gửi hóa đơn cho **'..billed.PlayerData.charinfo.firstname..'** ('..billed.PlayerData.citizenid..') số tiền $'..amount..' thành công.')
        else
            TriggerClientEvent('QBCore:Notify', source, Lang.invaildamount, 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang.selfbillerror, 'error')
    end
end)

local Colors = {
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}

RegisterNetEvent(FileName..':server:CreateLog', function(name, title, color, message, tagEveryone)    
    local tag = tagEveryone or false
    local webHook = Config.Webhooks[name] or Config.Webhooks['logbill']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'QBCore Logs',
                ['icon_url'] = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670',
            },
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'by candoit#3550', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'by candoit#3550', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)