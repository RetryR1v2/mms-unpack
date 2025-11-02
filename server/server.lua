-- Server Side
local VORPcore = exports.vorp_core:GetCore()

--- Register Usable Items

for h,v in ipairs(Config.Boxes) do
    exports.vorp_inventory:registerUsableItem(v.BoxItem, function(data)
        local src = data.source
        if exports.vorp_inventory:canCarryItem(src, v.RewardItem, v.RewardAmont) then
            exports.vorp_inventory:subItem(src, v.BoxItem, 1)
            exports.vorp_inventory:addItem(src, v.RewardItem, v.RewardAmont)
            VORPcore.NotifyRightTip(src,_U('YouRecived') .. v.RewardAmont .. ' ' .. v.RewardItemLabel,8000)
            if v.GiveBackEmptyBox then
                exports.vorp_inventory:addItem(src, v.EmptyBoxItem, 1)
            end
        else
            VORPcore.NotifyRightTip(src,_U('CantCarryItem'),8000)
        end
    end)
    if v.CanCreateBox then
        exports.vorp_inventory:registerUsableItem(v.RewardItem, function(data)
        local src = data.source
        if exports.vorp_inventory:getItemCount(src, nil, v.RewardItem) >= v.RewardAmont and exports.vorp_inventory:getItemCount(src, nil, v.EmptyBoxItem) >= 1 and exports.vorp_inventory:canCarryItem(src, v.BoxItem, 1) then
            exports.vorp_inventory:subItem(src, v.EmptyBoxItem, 1)
            exports.vorp_inventory:subItem(src, v.RewardItem, v.RewardAmont)
            exports.vorp_inventory:addItem(src, v.BoxItem, 1)
            VORPcore.NotifyRightTip(src,_U('BoxPacked') .. v.BoxItemLabel,8000)
        elseif exports.vorp_inventory:getItemCount(src, nil, v.EmptyBoxItem) >= 1 and exports.vorp_inventory:canCarryItem(src, v.BoxItem, 1) then
            VORPcore.NotifyRightTip(src,_U('CantCarryItem'),8000)
        elseif exports.vorp_inventory:getItemCount(src, nil, v.RewardItem) < v.RewardAmont then
            VORPcore.NotifyRightTip(src,_U('NotEnogh') .. v.RewardItemLabel,8000)
        elseif exports.vorp_inventory:getItemCount(src, nil, v.EmptyBoxItem) < 1 then
            VORPcore.NotifyRightTip(src,_U('NotEnogh') .. v.EmptyBoxItemLabel,8000)
        end
    end)
    end
end