QBCore = exports['qb-core']:GetCoreObject() -- shared core , support only qbcore newversion , contact admin for support
FileName = GetCurrentResourceName() -- allowed u change file name ! 

Config = {}

Config.oxmysql = 187 -- your version oxmysql , 1.9.3 = 193 , 1.8.7 = 187

Config.Webhooks = { -- webhook log send bild
    ['logbill'] = '',
}

Lang = { -- config language
    newinvoice = 'bạn nhận được hóa đơn mới',
    sendsuccess = 'Bạn đã gửi hóa đơn',
    invaildamount = 'số tiền phải lớn hơn 0',
    selfbillerror = 'không thể gửi hóa đơn cho bản thân',
    playernotonline = 'Người chơi không tồn tại',
    noaccess = 'bạn không có quyền làm việc này',
    billform = 'Hóa Đơn Từ',
    billing = 'Hóa Đơn',
    createbill = 'Tạo Hóa Đơn',
    amount = 'số tiền: ',
    reason = 'nội dung: ',
    pleasepayit = 'vui lòng thanh toán hóa đơn',

    cid = 'Số ID(#)',
    camount = 'Số Tiền ($)',
    creason = 'nội dung',
}

Config.job = { -- rename job label
    ['police'] = {
        label = 'cảnh sát'
    },
    ['mechanic'] = {
        label = 'cứu hộ'
    },
    ['doxe'] = {
        label = 'độ xe'
    },
    ['ambulance'] = {
        label = 'bệnh viên'
    },
}

--- dev by candoit#3550

----------------------------------------------------------------------------------------------------
-----------------------------------------TEMPLATES DOCUMENT-----------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--   command open bill--if filename is qb-billmenu then event : qb-billmenu:bill   -----------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--                                                                                 -----------------
--      RegisterCommand('billmenu', function(source, args)                         -----------------
--          -- do stuff                                                            -----------------
--          TriggerEvent('qb-billmenu:bill')                                       -----------------
--           -- do stuff                                                           -----------------
--      end)                                                                       -----------------
--                                                                                 -----------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
------------------------------   exports function      ---------------------------------------------
----------------------------------------------------------------------------------------------------
--                                                                                  ----------------
--  exports['qb-billmenu']AddBill(cid, amount, reason)                              ----------------
--                                                                                  ----------------
--  exports['qb-billmenu']AddBill('1', '100000', 'trả tiền')                        ----------------
--                                                                                  ----------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
