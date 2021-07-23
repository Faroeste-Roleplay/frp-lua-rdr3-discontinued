function RankToRankName(org_type_or_id, rank)
    local ranks = config[org_type_or_id]

    if ranks then
        if rank ~= -1 then
            for rank_id, rank_name in pairs(ranks) do
                if rank == rank_id then
                    return rank_name
                end
            end
        else
            return "Sem Rank"
        end
    end

    return nil
end

exports("RankToRankName", RankToRankName)
