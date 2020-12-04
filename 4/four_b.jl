requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

mutable struct Passport
    byr:: Int
    iyr:: Int
    eyr:: Int
    hgt:: Int
    hcl:: Int
    ecl:: Int
    pid:: Int
    isValid:: Bool
    Passport() = new()
end

function addLineToPassport(line, passport)
    fieldes = split(line," ")
    for field in fieldes
        (key::String, value:: String) = split(field, ":")
        if key == "byr" && isValidByr(value) passport.byr = 1 end
        if key == "iyr" && isValidIyr(value) passport.iyr = 1 end
        if key == "eyr" && isValidEyr(value) passport.eyr = 1 end
        if key == "hgt" && isValidHgt(value) passport.hgt = 1 end
        if key == "hcl" && isValidHcl(value) passport.hcl = 1 end
        if key == "ecl" && isValidEcl(value) passport.ecl = 1 end
        if key == "pid" && isValidPid(value) passport.pid = 1 end
    end
    return passport
end

function isValidNumberRange(value:: String, min::Int, max::Int, size::Int)
    isCorrectSize = length(value) == size 
    intValue = 0
    try
        intValue = parse(Int, value)
    catch
        return false
    end
    isValidRange = (intValue >= min) && (intValue <= max)
    return  isCorrectSize && isValidRange
end

function isValidByr(value)
    return isValidNumberRange(value, 1920, 2002, 4)
end

function isValidIyr(value)
    return isValidNumberRange(value, 2010, 2020, 4)
end

function isValidEyr(value)
    return isValidNumberRange(value, 2020, 2030, 4)
end

function isValidHgt(valueString)
    result = false
    if(length(valueString) < 3)
        return false
    else
        unit = SubString(valueString, length(valueString)-1)
        value::String = SubString(valueString, 1:length(valueString)-2)
        if unit == "cm" && isValidNumberRange(value,150,193,3)
            result = true 
        end
        if unit == "in" && isValidNumberRange(value,59,76,2)
            result = true
        end
    end
    return result
end

function isValidHcl(value)
    rx = r"(#[a-z0-9]{6})"
    matchResult = match(rx, value)
    return matchResult != nothing && matchResult.match == value
end

function isValidEcl(value)
    correctColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    return findfirst(isequal(value), correctColors) != nothing
end

function isValidPid(value)
    rx = r"([0-9]{9})"
    matchResult = match(rx, value)
    return matchResult != nothing && matchResult.match == value
end


function validatePassport(p::Passport)
    if(p.byr + p.iyr + p.eyr + p.hgt + p.hcl + p.ecl + p.pid) == 7
        p.isValid = true
    end
end
    

function collectPassports(fileName)
    passports = []
    passportCounter = 1
    currentPassport = Passport()
    open(fileName) do file
        for line in eachline(file)
            if length(line) == 0 
                validatePassport(currentPassport)
                push!(passports, currentPassport)
                currentPassport = Passport()
                passportCounter += 1
            else
                addLineToPassport(line, currentPassport)
            end
        end
    end
    return passports
end

allPassports = collectPassports("data.txt")
numberOfValidPassports = 0
for passport in allPassports
    if passport.isValid
        global numberOfValidPassports += 1
    end
end
println(numberOfValidPassports)

# line = "hcl:1f7352 iyr:2014 hgt:70cm eyr:1983"
# passport = Passport()
# println(passport)
# pasport = addLineToPassport(line, passport)
# println(passport)

# passports = collectPassports("data_test.txt")
# for passport in passports
#     println(passport)
# end

function assertTrue(value::Bool)
    return value == true
end

function assertFalse(value::Bool)
    return value == false
end

# println("Byr")
# println(assertFalse(isValidByr("1900")))
# println(assertFalse(isValidByr("2003")))
# println(assertFalse(isValidByr("abc")))
# println(assertFalse(isValidByr("201")))
# println(assertTrue(isValidByr("1972")))

# println("\nIyr")
# println(assertFalse(isValidIyr("abc")))
# println(assertFalse(isValidIyr("1972")))
# println(assertTrue(isValidIyr("2011")))
# println(assertFalse(isValidIyr("2040")))

# println("\nEyr")
# println(assertFalse(isValidEyr("abc")))
# println(assertFalse(isValidEyr("1972")))
# println(assertTrue(isValidEyr("2021")))
# println(assertFalse(isValidEyr("2040")))

# println("\nHgt")
# println(assertFalse(isValidHgt("123cm")))
# println(assertTrue(isValidHgt("151cm")))
# println(assertFalse(isValidHgt("151in")))
# println(assertTrue(isValidHgt("59in")))
# println(assertFalse(isValidHgt("77in")))

# println("\nHcl")
# println(assertFalse(isValidHcl("#1234a56.")))
# println(assertFalse(isValidHcl("#1234a51234a5")))
# println(assertTrue(isValidHcl("#abc123")))
# println(assertFalse(isValidHcl("#ab")))

# println("\nPid")
# println(assertTrue(isValidPid("123456789")))
# println(assertFalse(isValidPid("1234567890")))
# println(assertFalse(isValidPid("1A3456789")))
# println(assertFalse(isValidPid("1A345")))

# println("\nEcl")
# println(assertTrue(isValidEcl("brn")))
# println(assertFalse(isValidEcl("bla")))
# println(assertFalse(isValidEcl("asdf")))

