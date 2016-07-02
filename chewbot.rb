require 'discordrb'

bot = Discordrb::Bot.new token: 'MTczNTQ3NzgxMTQ1ODg2NzIw.Cll7xw.AUZgawYqS_U9DyagZ6CCf312dQE', application_id: 173547735289561088

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end
bot.message(with_text: 'Who is champ?') do |event|
  event.respond 'John Cena!'
end
bot.message(with_text: 'GotPvP Staff') do |event|
  event.respond '**Owner**: Saito
**Admins**: Hihihi565 (& developer) <> OregonDuckHAWK <> jschrods17 <> silly_dudez
**Developers**: GotMilk2014
**Dual Admins**: Comboshot - Creative, Prison1 <> Urbanajlucas - Survival, Kitpvp <> DancingPie - GTA, Oppvp <> xCosta - Duels, Factions
**Single Server Admins**: Morzaiden - Creative <> BrianED - Skyblock <> Wolfy - Prison1, Prison2 <> Casey11303 - Skyblock <> Kaurobi - Factions <> DinomikeYT - Kitpvp <> Wallisj10 - Oppvp <> Asymmetrically - Duels
**Mods**: Livid12 - Hub(1) <> Omlphoebee - Creative <> Biill - Creative <> Superfighter6 - Creative <> Lilyxd - Creative <> AceAmy - Survival <> TheLorax_ - Survival <> Jam123661 - Survival <> pupPIEabsol - Survival <> Jasonjayo - Survival <> Jackobolt - Survival <> Ella268 - Skyblock <> K4r4d - Skyblock <> xRavenClawx -Skyblock <> Tiffrox - Skyblock <> OstoReal468 - Skyblock <> Aussified - Factions <> SnowyYT - Factions <> DMdjs - Factions <> Stomsteven - Factions <> HalfCreeper_ - Prison2 <> Foxxe - Prison2 <> iCreepeh - Prison2 <> Mr_Huck_Me - Prison2 <> Sarcastic_Taco - GTA <> Nubzyy - GTA <> PinguMemes - GTA <> PeacefulDreamers - KitPvP <> Dreamerss - KitPvP <> ItzKat_ - Oppvp <> AmyJedward110 - Duels
**Helpers**: Cella_Autumn - Creative <> Scorp_ion - Survival <> SomeKidsBrother - Survival <> SleepyTrev - Skyblock <> CeylonHeart - Skyblock <> Skimtar - Factions <> xZydon11 - Factions <> ChewLeKitten - Prison1 <> LewisJordann - Prison1 <> oBlueo - Prison1 <> MaxxyTheWolf - Prison2 <> HollzTheOcelot - Prison2 <> MrJitterz - OpPvP <> Becky_Winter - OpPvP <> Horror_inT - OpPvP
**Discord Admin**: Chew (Chew Le Kitten Queen)
**Discord Mod**: Mini (Mini Mouse) <> Urbanajlucas (Urby)
**Discord Helper**: <No one>

(Visit link: https://docs.google.com/document/d/1IUB0ISzaFvLhgEobNkTl5hCzebrNLRnekj5RwtyEPVg/edit?usp=sharing for a "better view of it")'
end

bot.run