LaundryConfig = { }

-- Time it takes to wash one cloth, in seconds (default: 30)
LaundryConfig.WashTime = 30

-- How many time will it take to put one dirty cloth in the dirty cloth cart (it's a delay) (default: 120)
LaundryConfig.DirtyClothDelay = 120

-- How many dirty clothes can be in the dirty clothes cart at most (default: 20)
LaundryConfig.DirtyCartMaxCloth = 20

-- How much money will anyone earn per clean cloth (default: 10)
LaundryConfig.MoneyPerCloth = 10

-- <clothes> = How many clean clothes are in the cart (default: "<clothes> clean clothes")
LaundryConfig.PhraseCleanClothes = "%d clean clothes"
-- Example : If there is 6 clean clothes, "Clean clothes : <clothes>" will show "Clean clothes : 6"

-- <clothes> = How many dirty clothes are in the cart (default: "<clothes> dirty clothes")
LaundryConfig.PhraseDirtyClothes = "%d dirty clothes"
-- Example : If there is 9 dirty clothes, "Clean clothes : <clothes>" will show "Dirty clothes : 9"

-- <money> = Money received, <clothes> = clothes washed (default: "You received <money> for washing <clothes> clothes")
LaundryConfig.PhraseNotifyText = "You received %s for washing %d clothes"
-- Example : "You got <money> for <clothes> clothes" will show "You got 60$ for 6 clothes"

LaundryConfig.PhraseCantInteract = "You cannot interact with this"

-- true = Blacklist teams, false = Whitelist teams (default: true)
LaundryConfig.BlackOrWhiteList = true
-- Example : If the value is true, all teams in the configuration below will be blacklisted of the addon

-- Name of white/blacklisted teams
LaundryConfig.Teams = {
    ["Guard"] = true,
    ["Chief Guard"] = true,
    ["Director"] = true
}