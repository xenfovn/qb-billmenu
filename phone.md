```QBCore.Functions.CreateCallback('qb-phone:server:PayInvoice', function(source, cb, society, amount, invoiceId, sendercitizenid)
    local Invoices = {}
    local Ply = QBCore.Functions.GetPlayer(source)
    local SenderPly = QBCore.Functions.GetPlayerByCitizenId(sendercitizenid)
    local invoiceMailData = {}
    if SenderPly and Config.BillingCommissions[society] then
        local commission = round(amount * Config.BillingCommissions[society])
        SenderPly.Functions.AddMoney('bank', commission)
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Commission Received',
            message = string.format('You received a commission check of $%s when %s %s paid a bill of $%s.', commission, Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, amount)
        }
    elseif not SenderPly and Config.BillingCommissions[society] then
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Bill Paid',
            message = string.format('%s %s paid a bill of $%s', Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, amount)
        }
    end
    Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
    TriggerEvent('qb-phone:server:sendNewMailToOffline', sendercitizenid, invoiceMailData)
    TriggerEvent("qb-bossmenu:server:addAccountMoney", society, amount)
    exports.oxmysql:execute('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
    TriggerClientEvent('qb-billmenu:server:CreateLog', 'logbill', 'Bill', 'lightgreen', '**'..Ply.PlayerData.charinfo.firstname..'** ('..Ply.PlayerData.citizenid..') Please Pay the Following'..amount..' for company'..society..' Thank you. (Invoice Number: '..invoiceId..')')
    local invoices = exports.oxmysql:executeSync('SELECT * FROM phone_invoices WHERE citizenid = ?', {Ply.PlayerData.citizenid})
    if invoices[1] ~= nil then
        Invoices = invoices
    end
    cb(true, Invoices)
end)
```
```QBCore.Functions.CreateCallback('qb-phone:server:DeclineInvoice', function(source, cb, sender, amount, invoiceId)
    local Invoices = {}
    local Ply = QBCore.Functions.GetPlayer(source)
    exports.oxmysql:execute('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
    local invoices = exports.oxmysql:executeSync('SELECT * FROM phone_invoices WHERE citizenid = ?', {Ply.PlayerData.citizenid})
    TriggerClientEvent('qb-billmenu:server:CreateLog', 'logbill', 'Bill', 'red', '**'..Ply.PlayerData.charinfo.firstname..'** ('..Ply.PlayerData.citizenid..') Cancelled Invoice Amount '..amount..'. (Invoice Number: '..invoiceId..')')
    if invoices[1] ~= nil then
        Invoices = invoices
    end
    cb(true, Invoices)
end)```
