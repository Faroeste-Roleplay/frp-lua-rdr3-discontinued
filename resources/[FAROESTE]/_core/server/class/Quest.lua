function API.Quest(id, quests)
    local self = {}

    self.id = id
    self.quests = quests or {}

    self.addQuest = function(name, step)
        self.quests[name] = step
        API_Database.execute("FCRP/SetCJail", {questId = qid, charid = cid, questSteps = step})
    end

    self.remQuest = function(name)
        self.quests[name] = nil
        local rows = API_Database.query("FCRP/RemQuest", {questId = qid})
        if #rows > 0 then
            return true
        end
        return false
    end

    self.updateQuest = function(name, step)
        self.quests[name] = step
        API_Database.execute("FCRP/UpdCJail", {questSteps = value, questId = qid})
    end

    self.getQuest = function(name, cid)
        if key == nil then
            key = "all"
        end
        local rows = API_Database.query("FCRP/GetQuest", {charid = cid})
        if #rows > 0 then
            return rows
        else
            return ""
        end
    end

    return self
end
