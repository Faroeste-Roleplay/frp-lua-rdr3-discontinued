function API.Slot(slotId, itemId, itemAmount, ammoInClip, ammoInWeapon, infoData)
    local self = {}

   -- self.slotId = slotId
    self.itemId = itemId
    self.itemAmount = itemAmount
    self.itemData = API.getItemDataFromId(itemId)

    self.ammoInClip = ammoInClip
    self.ammoInWeapon = ammoInWeapon
    self.itemMetaData = infoData or "[]"


    -- self.getSlotId = function()
    --     return self.slotId
    -- end

    -- self.setSlotId = function(this, v)
    --     self.slotId = v
    -- end

    self.getItemId = function()
        return self.itemId
    end

    self.getItemAmount = function()
        return self.itemAmount
    end

    self.getItemData = function()
        return self.itemData
    end

    self.getItemMetaData = function()
        return self.itemMetaData
    end

    self.setItemAmount = function(this, v)
        self.itemAmount = v
    end

    self.addItemAmount = function(this, v)
        self:setItemAmount(self:getItemAmount() + v)
    end

    self.removeItemAmount = function(this, v)
        self:setItemAmount(self:getItemAmount() - v)
    end

    self.getAmmoInClip = function()
        if self:getItemId() ~= "lasso" then
            if self.ammoInClip == nil and self:getItemData():getType() == "weapon" then
                self.ammoInClip = 0
            end
        end

        return self.ammoInClip
    end

    self.setAmmoInClip = function(this, v)
        self.ammoInClip = v
    end

    self.getAmmoInWeapon = function()
        if self:getItemId() ~= "lasso" then
            if self.ammoInWeapon == nil and self:getItemData():getType() == "weapon" then
                if not self:getItemData():isMelee() and not self:getItemData():isThrowable() then
                    self.ammoInWeapon = 0
                else
                    self.ammoInWeapon = 1
                end
            end
        end

        return self.ammoInWeapon
    end

    self.setAmmoInWeapon = function(this, v)
        self.ammoInWeapon = v
    end

    self.getSyncData = function()
        return {name = self.itemId, amount = {self.itemAmount,self:getAmmoInClip(), self:getAmmoInWeapon()}, info = self.itemMetaData}
    end

    return self
end
