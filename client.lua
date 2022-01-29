RegisterNetEvent(FileName..':bill', function()
    local bill = exports['qb-input']:ShowInput({
        header = Lang.createbill,
		submitText = Lang.billing,
        inputs = {
            {
                text = Lang.cid,
				name = 'citizenid',
                type = 'number',
                isRequired = true
            },
            {
                text = Lang.camount,
                name = 'billprice',
                type = 'number',
                isRequired = false
            },
            {
                text = Lang.creason,
                name = 'reason',
                type = 'text',
                isRequired = false
            }
        }
    })
    if bill ~= nil then
        if bill.citizenid == nil or bill.billprice == nil or bill.reason == nil then 
            return 
        end
        TriggerServerEvent(FileName..':server:send', bill.citizenid, bill.billprice, bill.reason)
    end
end)

RegisterNetEvent(FileName..':client:sendBillingMail',function(name,price,reason,citizenid)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = ''..Lang.billform..' '..Config.job[name].label..'',
        subject = Lang.billing,
        message = ''..Lang.sendsuccess..', <br>'..Lang.amount..'<br> $'..price..' '..Lang.reason..''..reason..'<br><br> '..Lang.pleasepayit..'',
        button = {}
    })
    data = {}
end)

exports('AddBill', function(cid, amount, reason)
    TriggerServerEvent(FileName..':server:send', cid, amount, reason)
end)