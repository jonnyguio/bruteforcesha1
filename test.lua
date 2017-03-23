local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
local sha1 = require 'sha1'
local maxLength = 4

local function combinations(comb, size)
    local t = {}
    function recFunc (totalAttempts, attempt, k, t)
        if k == 0 then
            t[#t+1] = attempt
        else
            for x = 1, totalAttempts:len() do
                recFunc(totalAttempts, attempt .. totalAttempts:sub(x,x), k - 1, t)
            end
        end
    end
    recFunc(comb, "", size, t)
    return t
end

if (arg[1] == nil) then
    print ("No hash entered.")
    return false
end

print ("Pass: " .. arg[1])

local pass = arg[1]

for i = 1, maxLength do
    for _, try in ipairs(combinations(chars, i)) do
        if (sha1(try) == pass) then
            print ("Found pass: " .. try)
            return nil
        end
    end
end