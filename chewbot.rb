require 'discordrb'

bot = Discordrb::Bot.new token: '[your token]]', application_id: [your application id]

bot.message(with_text: '#$ping') do |event|
  event.respond 'Pong!'
end
bot.message(with_text: '#$who is champ') do |event|
  event.respond 'John Cena!'
end
bot.message(with_text: '#$GotPvP Staff') do |event|
  event.respond '**Owner:** `Saito`
**Global Admins:** `Hihihi565` (& developer) <> `OregonDuckHAWK` <> `jschrods17` <> `silly_dudez`
**Developers:** `GotMilk2014`
**Dual Admins:** `Comboshot` - Creative, Prison1 <> `Urbanajlucas` - Survival, Kitpvp <> `DancingPie` - GTA, Oppvp <> `xCosta` - Duels, Factions
**Single Server Admins:** `Morzaiden` - Creative <> `BrianED` - Skyblock <> `Wolfy` - Prison1, Prison2 <> `Casey11303` - Skyblock <> `Kaurobi` - Factions <> `DinomikeYT` - Kitpvp <> `Wallisj10` - Oppvp <> `Asymmetrically` - Duels
**Mods:** `Livid12` - Hub(1) <> `Omlphoebee` - Creative <> `Biill` - Creative <> `Superfighter6` - Creative <> `Lilyxd` - Creative <> `AceAmy` - Survival <> `TheLorax_` - Survival <> `Jam123661` - Survival <> `pupPIEabsol` - Survival <> `Jasonjayo` - Survival <> `Jackobolt` - Survival <> `Ella268` - Skyblock <> `K4r4d` - Skyblock <> `xRavenClawx` -Skyblock <> `Tiffrox` - Skyblock <> `OstoReal468` - Skyblock <> `Aussified` - Factions <> `SnowyYT` - Factions <> `DMdjs` - Factions <> `Stomsteven` - Factions <> `HalfCreeper_` - Prison2 <> `Foxxe` - Prison2 <> `iCreepeh` - Prison2 <> *`Mr_Huck_Me`* - Prison2 <> *`Sarcastic_Taco`* - GTA <> *`Nubzyy`* - GTA <> `PinguMemes` - GTA <> `PeacefulDreamers` - KitPvP <> `Dreamerss` - KitPvP <> `ItzKat_` - Oppvp <> `AmyJedward110` - Duels
**Helpers**: `Cella_Autumn` - Creative <> `Scorp_ion` - Survival <> `SleepyTrev` - Skyblock <> `CeylonHeart` - Skyblock <> `Skimtar` - Factions <> `xZydon11` - Factions <> `ChewLeKitten` - Prison1 <> `oDaddyo` - Prison1 <> `oMamao` - Prison1 <> `HerDarkness` - Prison2 <> `HisDarkness` - Prison2 <> `Dancing_Jitterz` - OpPvP <> `Becky_Winter` - OpPvP <> `Dancing_Ping` - OpPvP
**Discord Admin:** `Chew` (Chew Le Kitten Queen)
**Discord Mod:** `Mini` (Mini Mouse) <> `Urbanajlucas` (Urby)
**Discord Helper:** *`<No one>`*
(Visit link: https://goo.gl/2Us7j6 for a "better view of it")'
end
bot.message(with_text: '#$music') do |event|
  event.respond 'Chew has written a nifty little tutorial on how to use the music bot. Read it here: http://chewcraft.me/discord/Music/'
end
bot.message(with_text: '#$code') do |event|
  event.respond 'Chewbotcca was written in Ruby. Check the source code here: https://github.com/Chewsterchew/Chewbotcca'
end
bot.message(with_text: '#$pinned') do |event|
  event.respond '```Pinned Messages Leaderboard:
  ChewLeKitten - 4 Pinned Messages
  Kat - 2 Pinned Messages
  PreEminentMaster - 1 Pinned Message
  Scyth - 2 Pinned Messages
  Flowes - 1 Pinned Message
  GotPvP - 1 Pinned Message
  hihihih565 - 1 Pinned Message
  Jeefbot - 1 Pinned Message
  jshrods - 1 Pinned Message
  KekAussi - 1 Pinned Message
  Lvito - 1 Pinned Message
  MrJoCrafter - 1 Pinned Message
  ShinySingularity - 1 Pinned Message
  Urbana - 1 Pinned Message```'
end

bot.run
