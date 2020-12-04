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
        (key,value) = split(field, ":")
        if key == "byr" passport.byr = 1 end
        if key == "iyr" passport.iyr = 1 end
        if key == "eyr" passport.eyr = 1 end
        if key == "hgt" passport.hgt = 1 end
        if key == "hcl" passport.hcl = 1 end
        if key == "ecl" passport.ecl = 1 end
        if key == "pid" passport.pid = 1 end
    end
    return passport
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

# passport = Passport()
# passport.byr = 1
# passport.iyr = 1
# passport.eyr = 1
# passport.hgt = 1
# passport.hcl = 1
# validatePassport(passport)
# println(passport.isValid)

# line = "hcl:1f7352 iyr:2014 hgt:70cm eyr:1983"
# passport = Passport()
# println(passport)
# pasport = addLineToPassport(line, passport)
# println(passport)

# passports = collectPassports("data_test.txt")
# for passport in passports
#     println(passport)
# end