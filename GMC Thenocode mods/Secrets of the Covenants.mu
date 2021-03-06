/*

2020-03-09: Noticed the Lance already had a stat named "Stigmata" which is not taken by a whole lot of our players (none at this count). So I renamed that stat "Stigmata miracle" and kept the merit as "Stigmata". Games that use this code should +census Stigmata before they load it just in case a player has that stat. You might need to adjust their attributes.

2020-07-11: Noticed the new coils aren't XP-costing correctly. Plus, the Crucible merit isn't being taken into account with existing coils. Added!

2020-08-04: Noticed the prereqs were wrong for the coils, and not just these coils. You need Status (Ordo Dracul) of equivalent level to the coil OR 1 if it's your Mystery Coil. It is not restricted to Ordo Dracul.

2020-08-28: Noticed I had a bunch of Theban Sorcery Miracles classed as MERITS. Also, Aaron's Rod was spelled Aaron's Road. How embarrassing. The fix is below, and here's the code to remove the bad merits (finding out which of your players have them is an exercise for +census):

&merit.Apple_of_Eden [v(d.dd)]=
&prereq-text.merit.Apple_of_Eden [v(d.dd)]=
&prerequisite.merit.Apple_of_Eden [v(d.dd)]=
&tags.merit.Apple_of_Eden [v(d.dt)]=
&merit.Marian_Apparition [v(d.dd)]=
&prereq-text.merit.Marian_Apparition [v(d.dd)]=
&prerequisite.merit.Marian_Apparition [v(d.dd)]=
&tags.merit.Marian_Apparition [v(d.dt)]=
&merit.Revelatory_Shroud [v(d.dd)]=
&prereq-text.merit.Revelatory_Shroud [v(d.dd)]=
&prerequisite.merit.Revelatory_Shroud [v(d.dd)]=
&tags.merit.Revelatory_Shroud [v(d.dt)]=
&merit.Apparition_of_the_Host [v(d.dd)]=
&prereq-text.merit.Apparition_of_the_Host [v(d.dd)]=
&prerequisite.merit.Apparition_of_the_Host [v(d.dd)]=
&tags.merit.Apparition_of_the_Host [v(d.dt)]=
&merit.Bloody_Icon [v(d.dd)]=
&prereq-text.merit.Bloody_Icon [v(d.dd)]=
&prerequisite.merit.Bloody_Icon [v(d.dd)]=
&tags.merit.Bloody_Icon [v(d.dt)]=
&merit.The_Walls_of_Jericho [v(d.dd)]=
&prereq-text.merit.The_Walls_of_Jericho [v(d.dd)]=
&prerequisite.merit.The_Walls_of_Jericho [v(d.dd)]=
&tags.merit.The_Walls_of_Jericho [v(d.dt)]=
&merit.Aaron's_Road [v(d.dd)]=
&prereq-text.merit.Aaron's_Road [v(d.dd)]=
&prerequisite.merit.Aaron's_Road [v(d.dd)]=
&tags.merit.Aaron's_Road [v(d.dt)]=
&merit.Blessing_the_Legion [v(d.dd)]=
&prereq-text.merit.Blessing_the_Legion [v(d.dd)]=
&prerequisite.merit.Blessing_the_Legion [v(d.dd)]=
&tags.merit.Blessing_the_Legion [v(d.dt)]=
&merit.Miracle_of_the_Dead_Sun [v(d.dd)]=
&prereq-text.merit.Miracle_of_the_Dead_Sun [v(d.dd)]=
&prerequisite.merit.Miracle_of_the_Dead_Sun [v(d.dd)]=
&tags.merit.Miracle_of_the_Dead_Sun [v(d.dt)]=
&merit.Pledge_to_the_Worthless_One [v(d.dd)]=
&prereq-text.merit.Pledge_to_the_Worthless_One [v(d.dd)]=
&prerequisite.merit.Pledge_to_the_Worthless_One [v(d.dd)]=
&tags.merit.Pledge_to_the_Worthless_One [v(d.dt)]=
&merit.Great_Prophecy [v(d.dd)]=
&prereq-text.merit.Great_Prophecy [v(d.dd)]=
&prerequisite.merit.Great_Prophecy [v(d.dd)]=
&tags.merit.Great_Prophecy [v(d.dt)]=
&merit.The_Guiding_Star [v(d.dd)]=
&prereq-text.merit.The_Guiding_Star [v(d.dd)]=
&prerequisite.merit.The_Guiding_Star [v(d.dd)]=
&tags.merit.The_Guiding_Star [v(d.dt)]=
&merit.Apocalypse [v(d.dd)]=
&prereq-text.merit.Apocalypse [v(d.dd)]=
&prerequisite.merit.Apocalypse [v(d.dd)]=
&tags.merit.Apocalypse [v(d.dt)]=
&merit.The_Judgment_Fast [v(d.dd)]=
&prereq-text.merit.The_Judgment_Fast [v(d.dd)]=
&prerequisite.merit.The_Judgment_Fast [v(d.dd)]=
&tags.merit.The_Judgment_Fast [v(d.dt)]=

2020-08-28: Updated NOLA's sheets to take on the combination of Pledge to the Worthless One and Coil of the Wyrm 4. Note that NOLA applies Vigor, Celerity, and Resilience directly to the appropriate stats (str/dex/sta) so that they can pass prerequisites, so those stats aren't included in the counts below. You might want to change the code to account for those.

&health.maximum.vampire [v(d.dd)]=if(cand(u(.has, %0, miracle.pledge_to_the_worthless_one), u(.at_least, %0, discipline.coil_of_the_wyrm, 4)), u(.value, %0, advantage.blood_potency), 0)

&advantage.defense [v(d.dd)]=add(ladd(u(.value_full, %0, skill.athletics), .), min(ladd(u(.value_full, %0, attribute.wits).[udefault(.has, 0, %0, merit.embodiment_of_the_firstborn_(wits))], .), ladd(u(.value_full, %0, attribute.dexterity).[udefault(.has, 0, %0, merit.embodiment_of_the_firstborn_(dexterity))], .)), udefault(.value, 0, %0, discipline.celerity), if(cand(u(.has, %0, miracle.pledge_to_the_worthless_one), u(.at_least, %0, discipline.coil_of_the_wyrm, 4)), u(.value, %0, advantage.blood_potency), 0))

&ADVANTAGE.WEAPONRY_DEFENSE [v(d.dd)]=if(u(.has, %0, merit.defensive_combat_(weaponry)), add(ladd(u(.value_full, %0, skill.weaponry), .), u(advantage.defense, %0)), 0)

&ADVANTAGE.BRAWL_DEFENSE [v(d.dd)]=if(u(.has, %0, merit.defensive_combat_(brawl)), add(ladd(u(.value_full, %0, skill.brawl), .), u(advantage.defense, %0)), 0)

&ADVANTAGE.SPEED [v(d.dd)]=add(u(.value_stats, %0, attribute.strength attribute.dexterity special.species_factor merit.fleet_of_foot merit.strength_augmentation merit.augmented_speed), udefault(.has, 0, %0, merit.embodiment_of_the_firstborn_(dexterity)), udefault(.has, 0, %0, merit.embodiment_of_the_firstborn_(strength)), switch(udefault(%0/_form.current, u(v(d.sfs)/f.default_form, u(%0/_bio.template))), urshul, 3, urhan, 3, 0), switch(get(%0/_bio.seeming), Beast, 3, 0), if(cand(u(.has, %0, miracle.pledge_to_the_worthless_one), u(.at_least, %0, discipline.coil_of_the_wyrm, 4)), u(.value, %0, advantage.blood_potency), 0))


*/

think Merits and rites - 342 lines.

&merit.Chorister [v(d.dd)]=2

&prereq-text.merit.Chorister [v(d.dd)]=Not a member of Circle of the Crone

&prerequisite.merit.Chorister [v(d.dd)]=u(.is_not, bio.covenant, %0, Circle of the Crone)

&tags.merit.Chorister [v(d.dt)]=vampire

&merit.Mandragora_Garden [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Mandragora_Garden [v(d.dd)]=Status (Circle of the Crone) 1 or higher, Safe Place (same level), Cruac

&prerequisite.merit.Mandragora_Garden [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:1 merit.safe_place_(*):%2)

&tags.merit.Mandragora_Garden [v(d.dt)]=vampire.circle of the crone

&merit.Temple_Guardian [v(d.dd)]=1.2.3

&prereq-text.merit.Temple_Guardian [v(d.dd)]=Status (Circle of the Crone) 1 or higher, Athletics 2, Brawl 2, Weaponry 2

&prerequisite.merit.Temple_Guardian [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 skill.athletics:2 skill.brawl:2 skill.weaponry:2)

&tags.merit.Temple_Guardian [v(d.dt)]=vampire.circle of the crone

&merit.Viral_Mythology [v(d.dd)]=3

&prereq-text.merit.Viral_Mythology [v(d.dd)]=Status (Circle of the Crone) 1 or higher, Cruac 1, Presence 3, Expression 3

&prerequisite.merit.Viral_Mythology [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:1 attribute.presence:3 skill.expression:3)

&tags.merit.Viral_Mythology [v(d.dt)]=vampire.circle of the crone

&merit.What_You've_Done_For_Her_Lately [v(d.dd)]=1

&prereq-text.merit.What_You've_Done_For_Her_Lately [v(d.dd)]=Status (Circle of the Crone) 1 or higher, Cruac 2

&prerequisite.merit.What_You've_Done_For_Her_Lately [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:2)

&tags.merit.What_You've_Done_For_Her_Lately [v(d.dt)]=vampire.circle of the crone

&merit.Unbridled_Chaos [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Unbridled_Chaos [v(d.dd)]=Status (Circle of the Crone) 1 or higher, Cruac 1

&prerequisite.merit.Unbridled_Chaos [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:1)

&tags.merit.Unbridled_Chaos [v(d.dt)]=vampire.circle of the crone

&merit.Primal_Creation [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Primal_Creation [v(d.dd)]=Status (Circle of the Crone) 1 or higher, Cruac 1

&prerequisite.merit.Primal_Creation [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:1)

&tags.merit.Primal_Creation [v(d.dt)]=vampire.circle of the crone

&merit.Opening_the_Void [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Opening_the_Void [v(d.dd)]=Status (Circle of the Crone) 1 or higher, Cruac 1

&prerequisite.merit.Opening_the_Void [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:1)

&tags.merit.POpening_the_Void [v(d.dt)]=vampire.circle of the crone

&rite.The_Mantle_of_Amorous_Fire [v(d.dd)]=1

&prerequisite.rite.The_Mantle_of_Amorous_Fire [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.The_Mantle_of_Amorous_Fire [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.The_Mantle_of_Amorous_Fire [v(d.dt)]=vampire.circle of the crone

&rite.The_Pool_of_Forbidden_Truths [v(d.dd)]=1

&prerequisite.rite.The_Pool_of_Forbidden_Truths [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.The_Pool_of_Forbidden_Truths [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.The_Pool_of_Forbidden_Truths [v(d.dt)]=vampire.circle of the crone

&rite.Donning_the_Beast's_Flesh [v(d.dd)]=3

&prerequisite.rite.Donning_the_Beast's_Flesh [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Donning_the_Beast's_Flesh [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Donning_the_Beast's_Flesh [v(d.dt)]=vampire.circle of the crone

&rite.Mantle_of_the_Beast's_Breath [v(d.dd)]=2

&prerequisite.rite.Mantle_of_the_Beast's_Breath [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Mantle_of_the_Beast's_Breath [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Mantle_of_the_Beast's_Breath [v(d.dt)]=vampire.circle of the crone

&rite.Shed_the_Virulent_Bowels [v(d.dd)]=2

&prerequisite.rite.Shed_the_Virulent_Bowels [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Shed_the_Virulent_Bowels [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Shed_the_Virulent_Bowels [v(d.dt)]=vampire.circle of the crone

&rite.Curse_of_Aphrodite's_Favor [v(d.dd)]=3

&prerequisite.rite.Curse_of_Aphrodite's_Favor [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Curse_of_Aphrodite's_Favor [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Curse_of_Aphrodite's_Favor [v(d.dt)]=vampire.circle of the crone

&rite.Curse_of_the_Beloved_Toy [v(d.dd)]=3

&prerequisite.rite.Curse_of_the_Beloved_Toy [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Curse_of_the_Beloved_Toy [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Curse_of_the_Beloved_Toy [v(d.dt)]=vampire.circle of the crone

&rite.Gorgon's_Gaze [v(d.dd)]=4

&prerequisite.rite.Gorgon's_Gaze [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Gorgon's_Gaze [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Gorgon's_Gaze [v(d.dt)]=vampire.circle of the crone

&rite.Mantle_of_the_Glorious_Dervish [v(d.dd)]=3

&prerequisite.rite.Mantle_of_the_Glorious_Dervish [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Mantle_of_the_Glorious_Dervish [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Mantle_of_the_Glorious_Dervish [v(d.dt)]=vampire.circle of the crone

&rite.Bounty_of_the_Storm [v(d.dd)]=4

&prerequisite.rite.Bounty_of_the_Storm [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Bounty_of_the_Storm [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Bounty_of_the_Storm [v(d.dt)]=vampire.circle of the crone

&rite.Denying_Hades [v(d.dd)]=5

&prerequisite.rite.Denying_Hades [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Denying_Hades [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Denying_Hades [v(d.dt)]=vampire.circle of the crone

&rite.Mantle_of_the_Predator_Goddess [v(d.dd)]=4

&prerequisite.rite.Mantle_of_the_Predator_Goddess [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Mantle_of_the_Predator_Goddess [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Mantle_of_the_Predator_Goddess [v(d.dt)]=vampire.circle of the crone

&rite.Birthing_the_God [v(d.dd)]=5

&prerequisite.rite.Birthing_the_God [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Birthing_the_God [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Birthing_the_God [v(d.dt)]=vampire.circle of the crone

&rite.Mantle_of_the_Crone [v(d.dd)]=5

&prerequisite.rite.Mantle_of_the_Crone [v(d.dd)]=u(.at_least_all, %0, merit.status_(circle_of_the_crone):1 discipline.cruac:%2)

&prereq-text.rite.Mantle_of_the_Crone [v(d.dd)]=Circle of the Crone, Cruac at this level or higher

&tags.rite.Mantle_of_the_Crone [v(d.dt)]=vampire.circle of the crone

&merit.Courtoisie [v(d.dd)]=1.2.3

&prereq-text.merit.Courtoisie [v(d.dd)]=Status (Invictus) 1 or higher, Composure 3, Socialize 2, Weaponry 2

&prerequisite.merit.Courtoisie [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):1 attribute.composure:3 skill.socialize:2 skill.weaponry:2)

&tags.merit.Courtoisie [v(d.dt)]=vampire.invictus

&merit.Crowdsourcing [v(d.dd)]=1.2.3

&prereq-text.merit.Crowdsourcing [v(d.dd)]=Status (Invictus) 1 or higher, Contacts 1, Resources 3

&prerequisite.merit.Crowdsourcing [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):1 merit.contacts_(*):1 merit.resources:3)

&tags.merit.Crowdsourcing [v(d.dt)]=vampire.invictus

&merit.Information_Network [v(d.dd)]=1

&prereq-text.merit.Information_Network [v(d.dd)]=Status (Invictus) 2 or higher, Contacts 1

&prerequisite.merit.Information_Network [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):2 merit.contacts_(*):1)

&tags.merit.Information_Network [v(d.dt)]=vampire.invictus

&merit.Moderator [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Moderator [v(d.dd)]=Status (Invictus) 2 or higher, Computer 3, Contacts (Online) 1

&prerequisite.merit.Moderator [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):2 merit.contacts_(online):1 skill.computer:3)

&tags.merit.Moderator [v(d.dt)]=vampire.invictus

&merit.One_Foot_in_the_Door [v(d.dd)]=2

&prereq-text.merit.One_Foot_in_the_Door [v(d.dd)]=Not a member of Invictus

&prerequisite.merit.One_Foot_in_the_Door [v(d.dd)]=u(.is_not, bio.covenant, %0, Invictus)

&tags.merit.One_Foot_in_the_Door [v(d.dt)]=vampire.invictus

&merit.Noblesse_Oblige [v(d.dd)]=3

&prereq-text.merit.Noblesse_Oblige [v(d.dd)]=Status (Invictus) 1 or higher, Status (City) 3

&prerequisite.merit.Noblesse_Oblige [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):1 merit.status_(city):3)

&tags.merit.Noblesse_Oblige [v(d.dt)]=vampire.invictus

&merit.Prestigious_Sire [v(d.dd)]=1

&prereq-text.merit.Prestigious_Sire [v(d.dd)]=Status (Invictus) 1 or higher, Mentor 4

&prerequisite.merit.Prestigious_Sire [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):1 merit.mentor_(*):3)

&tags.merit.Prestigious_Sire [v(d.dt)]=vampire.invictus

&merit.Social_Engineering [v(d.dd)]=4

&prereq-text.merit.Social_Engineering [v(d.dd)]=Status (Invictus) 1 or higher, Investigation 2, Manipulation 3, Subterfuge 2, Wits 3

&prerequisite.merit.Social_Engineering [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):1 skill.investigation:2 attribute.manipulation:3 skill.subterfuge:2 attribute.wits:3)

&tags.merit.Social_Engineering [v(d.dt)]=vampire.invictus

&merit.Tech_Savvy [v(d.dd)]=1.2.3

&prereq-text.merit.Tech_Savvy [v(d.dd)]=Status (Invictus) 1 or higher, Computer 2, Crafts 2, Science 1, Resources 1

&prerequisite.merit.Tech_Savvy [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):1 skill.computer:2 skill.crafts:2 skill.science:1 merit.resources:1)

&tags.merit.Tech_Savvy [v(d.dt)]=vampire.invictus

&merit.Travel_Agent [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Travel_Agent [v(d.dd)]=Status (Invictus) 2 or higher, Contacts (Inner City) 1

&prerequisite.merit.Travel_Agent [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):2 merit.contacts_(inner_city):1)

&tags.merit.Travel_Agent [v(d.dt)]=vampire.invictus

&merit.Oath_of_Abstinence [v(d.dd)]=5

&tags.merit.Oath_of_Abstinence [v(d.dt)]=vampire.invictus

&merit.Oath_of_the_Handshake_Deal [v(d.dd)]=1

&tags.merit.Oath_of_the_Handshake_Deal [v(d.dt)]=vampire.invictus

&merit.Oath_of_the_Hard_Motherfucker [v(d.dd)]=2

&prereq-text.merit.Oath_of_the_Hard_Motherfucker [v(d.dd)]=No Invictus Status

&prerequisite.merit.Oath_of_the_Hard_Motherfucker [v(d.dd)]=u(.has_not, %0, merit.status_(invictus))

&tags.merit.Oath_of_the_Hard_Motherfucker [v(d.dt)]=vampire.invictus

&merit.Oath_of_Matrimony [v(d.dd)]=5

&tags.merit.Oath_of_Matrimony [v(d.dt)]=vampire.invictus

&merit.Oath_of_the_Model_Prisoner [v(d.dd)]=3

&tags.merit.Oath_of_the_Model_Prisoner [v(d.dt)]=vampire.invictus

&merit.Oath_of_Office [v(d.dd)]=3

&tags.merit.Oath_of_Office [v(d.dt)]=vampire.invictus

&merit.Oath_of_the_Refugee [v(d.dd)]=2

&tags.merit.Oath_of_the_Refugee [v(d.dt)]=vampire.invictus

&merit.Oath_of_the_Righteous_Kill [v(d.dd)]=3

&prereq-text.merit.Oath_of_the_Righteous_Kill [v(d.dd)]=Empathy 3, Status (Invictus) 3

&prerequisite.merit.Oath_of_the_Righteous_Kill [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):3 skill.empathy:3)

&tags.merit.Oath_of_the_Righteous_Kill [v(d.dt)]=vampire.invictus

&merit.Oath_of_the_Righteous_Kill [v(d.dd)]=3

&prereq-text.merit.Oath_of_the_Righteous_Kill [v(d.dd)]=Empathy 3, Invictus Status 3

&prerequisite.merit.Oath_of_the_Righteous_Kill [v(d.dd)]=u(.at_least_all, %0, merit.status_(invictus):3 skill.empathy:3)

&tags.merit.Oath_of_the_Righteous_Kill [v(d.dt)]=vampire.invictus

&merit.Oath_of_the_Safe_Word [v(d.dd)]=2

&tags.merit.Oath_of_the_Safe_Word [v(d.dt)]=vampire.invictus

&merit.Oath_of_the_True_Knight [v(d.dd)]=5

&prereq-text.merit.Oath_of_the_True_Knight [v(d.dd)]=Invictus Status 2

&prerequisite.merit.Oath_of_the_True_Knight [v(d.dd)]=u(.at_least, %0, merit.status_(invictus), 2)

&tags.merit.Oath_of_the_True_Knight [v(d.dt)]=vampire.invictus

&merit.Crusade [v(d.dd)]=1.2.3

&prereq-text.merit.Crusade [v(d.dd)]=Status (Lancea et Sanctum) 1 or higher, Occult 2, Resolve 3, Weaponry 2, either Theban Sorcery 2 or Sorcerous Eunuch 1

&prerequisite.merit.Crusade [v(d.dd)]=cand(u(.at_least_all, %0, merit.status_(lancea_et_sanctum):1 skill.occult:2 attribute.resolve:3 skill.weaponry:2), u(.list_at_least, %0, discipline.theban_sorcery:2 merit.sorcerous_eunuch:1))

&tags.merit.Crusade [v(d.dt)]=vampire.lancea et sanctum

&merit.Flock [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Flock [v(d.dd)]=Status (Lancea et Sanctum) 1 or higher, Herd at equal or greater value

&prerequisite.merit.Flock [v(d.dd)]=u(.at_least_all, %0, merit.status_(lancea_et_sanctum):1 merit.herd:%2)

&tags.merit.Flock [v(d.dt)]=vampire.lancea et sanctum

&merit.Laity [v(d.dd)]=2

&prereq-text.merit.Laity [v(d.dd)]=Not a member of Lancea et Sanctum

&prerequisite.merit.Laity [v(d.dd)]=u(.is_not, bio.covenant, %0, Lancea et Sanctum)

&tags.merit.Laity [v(d.dt)]=vampire.lancea et sanctum

&merit.Sanctuary [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Sanctuary [v(d.dd)]=Status (Lancea et Sanctum) 2 or higher, Status (City) 2, Safe Place 1

&prerequisite.merit.Sanctuary [v(d.dd)]=u(.at_least_all, %0, merit.status_(lancea_et_sanctum):2 merit.status_(city):2 merit.safe_place_(*):1)

&tags.merit.Sanctuary [v(d.dt)]=vampire.lancea et sanctum

&merit.Sorcerous_Eunuch [v(d.dd)]=1

&prereq-text.merit.Sorcerous_Eunuch [v(d.dd)]=Status (Lancea et Sanctum) 1 or higher, Resolve 3

&prerequisite.merit.Sorcerous_Eunuch [v(d.dd)]=u(.at_least_all, %0, merit.status_(lancea_et_sanctum):1 attribute.resolve:3)

&tags.merit.Sorcerous_Eunuch [v(d.dt)]=vampire.lancea et sanctum

think Moving the Miracle "Stigmata" to "Stigmata miracle"

&miracle.stigmata [v(d.dd)]=

&prerequisite.miracle.stigmata [v(d.dd)]=

&prereq-text.miracle.stigmata [v(d.dd)]=

&tags.miracle.stigmata [v(d.dt)]=

&miracle.stigmata_miracle [v(d.dd)]=4

&prerequisite.miracle.stigmata_miracle [v(d.dd)]=cand(u(.is_full, %0, bio.covenant, lancea et sanctum), u(.at_least, %0, discipline.theban_sorcery, v(miracle.stigmata)), u(.at_least, %0, advantage.integrity, v(miracle.stigmata)))

&prereq-text.miracle.stigmata_miracle [v(d.dd)]=Lancea et Sanctum, Theban Sorcery at this level or higher, Humanity at this level or higher

&tags.miracle.stigmata_miracle [v(d.dt)]=vampire.lancea et sanctum

think Entering the Stigmata merit


&merit.Stigmata [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Stigmata [v(d.dd)]=Status (Lancea et Sanctum) 1 or higher, Humanity (3 or more dots higher than the merit) or Mortal

&prerequisite.merit.Stigmata [v(d.dd)]=or(u(.at_least_all, %0, merit.status_(lancea_et_sanctum):1 advantage.humanity:[add(%2, 3)]), u(.is_full, %0, bio.template, Human))

&tags.merit.Stigmata [v(d.dt)]=vampire.lancea et sanctum.human.supernatural

&merit.Temple_of_Damnation [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Temple_of_Damnation [v(d.dd)]=Status (Lancea et Sanctum) 1 or higher, Safe Place (equal or greater value)

&prerequisite.merit.Temple_of_Damnation [v(d.dd)]=u(.at_least_all, %0, merit.status_(lancea_et_sanctum):1 merit.safe_place_(*):%2)

&tags.merit.Temple_of_Damnation [v(d.dt)]=vampire.lancea et sanctum

&miracle.Apple_of_Eden [v(d.dd)]=1

&prereq-text.miracle.Apple_of_Eden [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Apple_of_Eden [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Apple_of_Eden [v(d.dt)]=vampire.lancea et sanctum

&miracle.Marian_Apparition [v(d.dd)]=1

&prereq-text.miracle.Marian_Apparition [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Marian_Apparition [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Marian_Apparition [v(d.dt)]=vampire.lancea et sanctum

&miracle.Revelatory_Shroud [v(d.dd)]=1

&prereq-text.miracle.Revelatory_Shroud [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Revelatory_Shroud [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Revelatory_Shroud [v(d.dt)]=vampire.lancea et sanctum

&miracle.Apparition_of_the_Host [v(d.dd)]=2

&prereq-text.miracle.Apparition_of_the_Host [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Apparition_of_the_Host [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Apparition_of_the_Host [v(d.dt)]=vampire.lancea et sanctum

&miracle.Bloody_Icon [v(d.dd)]=2

&prereq-text.miracle.Bloody_Icon [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Bloody_Icon [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Bloody_Icon [v(d.dt)]=vampire.lancea et sanctum

&miracle.The_Walls_of_Jericho [v(d.dd)]=2

&prereq-text.miracle.The_Walls_of_Jericho [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.The_Walls_of_Jericho [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.The_Walls_of_Jericho [v(d.dt)]=vampire.lancea et sanctum

&miracle.Aaron's_Rod [v(d.dd)]=3

&prereq-text.miracle.Aaron's_Rod [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Aaron's_Rod [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Aaron's_Rod [v(d.dt)]=vampire.lancea et sanctum

&miracle.Blessing_the_Legion [v(d.dd)]=3

&prereq-text.miracle.Blessing_the_Legion [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Blessing_the_Legion [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Blessing_the_Legion [v(d.dt)]=vampire.lancea et sanctum

&miracle.Miracle_of_the_Dead_Sun [v(d.dd)]=3

&prereq-text.miracle.Miracle_of_the_Dead_Sun [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Miracle_of_the_Dead_Sun [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Miracle_of_the_Dead_Sun [v(d.dt)]=vampire.lancea et sanctum

&miracle.Pledge_to_the_Worthless_One [v(d.dd)]=3

&prereq-text.miracle.Pledge_to_the_Worthless_One [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Pledge_to_the_Worthless_One [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Pledge_to_the_Worthless_One [v(d.dt)]=vampire.lancea et sanctum

&miracle.Great_Prophecy [v(d.dd)]=4

&prereq-text.miracle.Great_Prophecy [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Great_Prophecy [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Great_Prophecy [v(d.dt)]=vampire.lancea et sanctum

&miracle.The_Guiding_Star [v(d.dd)]=3

&prereq-text.miracle.The_Guiding_Star [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.The_Guiding_Star [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.The_Guiding_Star [v(d.dt)]=vampire.lancea et sanctum

&miracle.Apocalypse [v(d.dd)]=5

&prereq-text.miracle.Apocalypse [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.Apocalypse [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.Apocalypse [v(d.dt)]=vampire.lancea et sanctum

&miracle.The_Judgment_Fast [v(d.dd)]=5

&prereq-text.miracle.The_Judgment_Fast [v(d.dd)]=Theban Sorcery

&prerequisite.miracle.The_Judgment_Fast [v(d.dd)]=u(.has, %0, discipline.theban_sorcery)

&tags.miracle.The_Judgment_Fast [v(d.dt)]=vampire.lancea et sanctum

&merit.Independent_Study [v(d.dd)]=2

&prereq-text.merit.Independent_Study [v(d.dd)]=Not a member of Ordo Dracul

&prerequisite.merit.Independent_Study [v(d.dd)]=u(.is_not, bio.covenant, %0, Ordo Dracul)

&tags.merit.Independent_Study [v(d.dt)]=vampire.ordo dracul

&merit.Nest_Guardian [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Nest_Guardian [v(d.dd)]=Status (Ordo Dracul) 1 or higher

&prerequisite.merit.Nest_Guardian [v(d.dd)]=u(.has, %0, merit.status_(ordo_dracul))

&tags.merit.Nest_Guardian [v(d.dt)]=vampire.ordo dracul

&merit.Rites_of_the_Impaled [v(d.dd)]=1.2.3

&prereq-text.Rites_of_the_Impaled [v(d.dd)]=Status (Ordo Dracul) 1 or higher, Resolve 3, Stamina 3, Weaponry 2, Sworn 1

&prerequisite.Rites_of_the_Impaled [v(d.dd)]=u(.at_least_all, %0, merit.status_(ordo_dracul):1 attribute.resolve:3 attribute.stamina:3 skill.weaponry:2 merit.sworn_(*):1)

&tags.Rites_of_the_Impaled [v(d.dt)]=vampire.ordo dracul

&merit.Twilight_Judge [v(d.dd)]=3

&prereq-text.merit.Twilight_Judge [v(d.dd)]=Status (Ordo Dracul) 4

&prerequisite.merit.Twilight_Judge [v(d.dd)]=u(.at_least, %0, merit.status_(ordo_dracul), 4)

&tags.merit.Twilight_Judge [v(d.dt)]=vampire.ordo dracul

&merit.Chapterhouse [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Chapterhouse [v(d.dd)]=Status (Ordo Dracul) 3, Nest Guardian

&prerequisite.merit.Chapterhouse [v(d.dd)]=u(.at_least_all, %0, merit.status_(ordo_dracul):3 merit.Nest_Guardian:1)

&tags.merit.Chapterhouse [v(d.dt)]=vampire.ordo dracul

&merit.Crucible [v(d.dd)]=3

&prereq-text.merit.Crucible [v(d.dd)]=Status (Ordo Dracul) 1 or higher, Nest Guardian, Occult 4

&prerequisite.merit.Crucible [v(d.dd)]=u(.at_least_all, %0, merit.status_(ordo_dracul):1 merit.Nest_Guardian:1 skill.occult:4)

&tags.merit.Crucible [v(d.dt)]=vampire.ordo dracul

&merit.Feng_Shui [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Feng_Shui [v(d.dd)]=Status (Ordo Dracul) 1 or higher, Nest Guardian, Academics 2, Occult 3

&prerequisite.merit.Feng_Shui [v(d.dd)]=u(.at_least_all, %0, merit.status_(ordo_dracul):1 merit.Nest_Guardian:1 skill.occult:3 skill.academics:2)

&tags.merit.Feng_Shui [v(d.dt)]=vampire.ordo dracul

&merit.Perilous_Nest [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Perilous_Nest [v(d.dd)]=Status (Ordo Dracul) 1 or higher, Nest Guardian, Occult 3

&prerequisite.merit.Perilous_Nest [v(d.dd)]=u(.at_least_all, %0, merit.status_(ordo_dracul):1 merit.Nest_Guardian:1 skill.occult:3)

&tags.merit.Perilous_Nest [v(d.dt)]=vampire.ordo dracul

&merit.Alley_Cat [v(d.dd)]=1.2.3

&prereq-text.merit.Alley_Cat [v(d.dd)]=Status (Carthian Movement) 1, Athletics 2, Stealth 2, Streetwise 2

&prerequisite.merit.Alley_Cat [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):1 skill.athletics:2 skill.stealth:2 skill.streetwise:2)

&tags.merit.Alley_Cat [v(d.dt)]=vampire.carthian movement

&merit.Army_of_One [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Army_of_One [v(d.dd)]=Status (Carthian Movement) equal or higher, Athletics 2, Stealth 2, Streetwise 2

&prerequisite.merit.Army_of_One [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):%2 skill.athletics:2 skill.stealth:2 skill.streetwise:2)

&tags.merit.Army_of_One [v(d.dt)]=vampire.carthian movement

&merit.Casual_User [v(d.dd)]=2

&prereq-text.merit.Casual_User [v(d.dd)]=Not a member of Carthian Movement

&prerequisite.merit.Casual_User [v(d.dd)]=u(.is_not, bio.covenant, %0, Carthian Movement)

&tags.merit.Casual_User [v(d.dt)]=vampire.carthian movement

&merit.Court_Jester [v(d.dd)]=2

&prereq-text.merit.Court_Jester [v(d.dd)]=Status (Carthian Movement) 1, Status (Praxis) 2, Politics 2

&prerequisite.merit.Court_Jester [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):1 merit.status_(Praxis):2 skill.politics:2)

&tags.merit.Court_Jester [v(d.dt)]=vampire.carthian movement

&merit.Devotion_Experimenter [v(d.dd)]=2

&prereq-text.merit.Devotion_Experimenter [v(d.dd)]=Status (Carthian Movement) 2, Science 2

&prerequisite.merit.Devotion_Experimenter [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):2 skill.science:2)

&tags.merit.Court_Jester [v(d.dt)]=vampire.carthian movement

&merit.Fucking_Thief [v(d.dd)]=1

&prereq-text.merit.Fucking_Thief [v(d.dd)]=Status (Carthian Movement) 1, Subterfuge 3

&prerequisite.merit.Fucking_Thief [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):1 skill.subterfuge:3)

&tags.merit.Fucking_Thief [v(d.dt)]=vampire.carthian movement

&merit.Jack-Booted_Thug [v(d.dd)]=2

&prereq-text.merit.Jack-Booted_Thug [v(d.dd)]=Status (Carthian Movement) 2, Status (Praxis) 1, Intimidation 3

&prerequisite.merit.Jack-Booted_Thug [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):2 merit.status_(Praxis):1 skill.intimidation:3)

&tags.merit.Jack-Booted_Thug [v(d.dt)]=vampire.carthian movement

&merit.Mobilize_Outrage [v(d.dd)]=1.2.3

&prereq-text.merit.Mobilize_Outrage [v(d.dd)]=Status (Carthian Movement) 1, Brawl 2, Willpower 5

&prerequisite.merit.Mobilize_Outrage [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):1 skill.brawl:2 advantage.willpower:5)

&tags.merit.Mobilize_Outrage [v(d.dt)]=vampire.carthian movement

&merit.Sell_Out [v(d.dd)]=3

&prereq-text.merit.Sell_Out [v(d.dd)]=Status (Carthian Movement) 4, Status (Praxis) 4, Politics 3

&prerequisite.merit.Sell_Out [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):4 merit.status_(Praxis):4 skill.politics:3)

&tags.merit.Sell_Out [v(d.dt)]=vampire.carthian movement

&merit.Smooth_Criminal [v(d.dd)]=2

&prereq-text.merit.Smooth_Criminal [v(d.dd)]=Status (Carthian Movement) 1, Politics 1, Streetwise 2, Subterfuge 2

&prerequisite.merit.Smooth_Criminal [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):1 skill.politics:1 skill.streetwise:2 skill.subterfuge:2)

&tags.merit.Smooth_Criminal [v(d.dt)]=vampire.carthian movement

&merit.toss_that_shit_right_back [v(d.dd)]=1

&prereq-text.merit.toss_that_shit_right_back [v(d.dd)]=Status (Carthian Movement) 1, Athletics 2, Dexterity 3

&prerequisite.merit.toss_that_shit_right_back [v(d.dd)]=u(.at_least_all, %0, merit.status_(carthian_movement):1 skill.athletics:2 attribute.dexterity:3)

&tags.merit.toss_that_shit_right_back [v(d.dt)]=vampire.carthian movement

&merit.breaking_the_chains [v(d.dd)]=1

&prereq-text.merit.breaking_the_chains [v(d.dd)]=Status (Carthian Movement) 1

&prerequisite.merit.breaking_the_chains [v(d.dd)]=u(.at_least, %0, merit.status_(carthian_movement), 1)

&tags.merit.breaking_the_chains [v(d.dt)]=vampire.carthian movement

&merit.cease_fire [v(d.dd)]=5

&prereq-text.merit.cease_fire [v(d.dd)]=Status (Carthian Movement) 5

&prerequisite.merit.cease_fire [v(d.dd)]=u(.at_least, %0, merit.status_(carthian_movement), 5)

&tags.merit.cease_fire [v(d.dt)]=vampire.carthian movement

&merit.Coda_Against_Sorcery [v(d.dd)]=1.2.3.4.5

&prereq-text.merit.Coda_Against_Sorcery [v(d.dd)]=Status (Carthian Movement) 1

&prerequisite.merit.Coda_Against_Sorcery [v(d.dd)]=u(.at_least, %0, merit.status_(carthian_movement), 1)

&tags.merit.Coda_Against_Sorcery [v(d.dt)]=vampire.carthian movement

&merit.Empower_Judiciary [v(d.dd)]=3

&prereq-text.merit.Empower_Judiciary [v(d.dd)]=Status (Carthian Movement) 3

&prerequisite.merit.Empower_Judiciary [v(d.dd)]=u(.at_least, %0, merit.status_(carthian_movement), 3)

&tags.merit.Empower_Judiciary [v(d.dt)]=vampire.carthian movement

&merit.Establish_Precedent [v(d.dd)]=2

&prereq-text.merit.Establish_Precedent [v(d.dd)]=Status (Carthian Movement) 4

&prerequisite.merit.Establish_Precedent [v(d.dd)]=u(.at_least, %0, merit.status_(carthian_movement), 4)

&tags.merit.Establish_Precedent [v(d.dt)]=vampire.carthian movement

&merit.Weaponize_Dissent [v(d.dd)]=2

&prereq-text.merit.Weaponize_Dissent [v(d.dd)]=Status (Carthian Movement) 2

&prerequisite.merit.Weaponize_Dissent [v(d.dd)]=u(.at_least, %0, merit.status_(carthian_movement), 2)

&tags.merit.Weaponize_Dissent [v(d.dt)]=vampire.carthian movement

think Coils and scales

&discipline.coil_of_zirnitra [v(d.dd)]=1.2.3.4.5

&tags.discipline.coil_of_zirnitra [v(d.dt)]=vampire.coil

&prerequisite.DISCIPLINE.COIL_OF_Zirnitra [v(d.dd)]=case(1, u(.is_full, %0, bio.mystery_coil, Coil of Zirnitra), u(.has, %0, merit.status_(ordo_dracul)), u(.at_most_stat, %0, discipline.coil_of_Zirnitra, merit.status_(ordo_dracul)))

&prereq-text.DISCIPLINE.COIL_OF_Zirnitra [v(d.dd)]=Status (Ordo Dracul) 1 (if Mystery Coil) or of equivalent level (if not)

&scale.grafting_unholy_flesh [v(d.dd)]=Coil of Zirnitra:4

&prerequisite.scale.grafting_unholy_flesh [v(d.dd)]=u(.is_full, %0, bio.covenant, Ordo Dracul)

&prereq-text.scale.grafting_unholy_flesh [v(d.dd)]=Covenant is Ordo Dracul

&scale.psychic_lobotomy [v(d.dd)]=Coil of Zirnitra:1

&prerequisite.scale.psychic_lobotomy [v(d.dd)]=u(.is_full, %0, bio.covenant, Ordo Dracul)

&prereq-text.scale.psychic_lobotomy [v(d.dd)]=Covenant is Ordo Dracul

&discipline.coil_of_ziva [v(d.dd)]=1.2.3.4.5

&tags.discipline.coil_of_ziva [v(d.dt)]=vampire.coil.ordo dracul

&prerequisite.DISCIPLINE.COIL_OF_Ziva [v(d.dd)]=case(1, u(.is_full, %0, bio.mystery_coil, Coil of Ziva), u(.has, %0, merit.status_(ordo_dracul)), u(.at_most_stat, %0, discipline.coil_of_Ziva, merit.status_(ordo_dracul)))

&prereq-text.DISCIPLINE.COIL_OF_Ziva [v(d.dd)]=Status (Ordo Dracul) 1 (if Mystery Coil) or of equivalent level (if not)

&scale.bleed_the_sin [v(d.dd)]=Coil of Ziva:2

&prerequisite.scale.bleed_the_sin [v(d.dd)]=u(.is_full, %0, bio.covenant, Ordo Dracul)

&prereq-text.scale.bleed_the_sin [v(d.dd)]=Covenant is Ordo Dracul

&scale.siphon_the_soul [v(d.dd)]=Coil of Ziva:3

&prerequisite.scale.siphon_the_soul [v(d.dd)]=u(.is_full, %0, bio.covenant, Ordo Dracul)

&prereq-text.scale.siphon_the_soul [v(d.dd)]=Covenant is Ordo Dracul

think XP costs for coils updating...

&xp.discipline.coil_of_zirnitra [v(d.xpcd)]=add(if(u(.is_full, %0, bio.mystery_coil, Coil of Zirnitra), u(cost.standard, 3, %1, %2), u(cost.standard, 4, %1, %2)), if(u(.has, %0, merit.crucible), -1, 0))

&xp.discipline.coil_of_ziva [v(d.xpcd)]=add(if(u(.is_full, %0, bio.mystery_coil, Coil of Ziva), u(cost.standard, 3, %1, %2), u(cost.standard, 4, %1, %2)), if(u(.has, %0, merit.crucible), -1, 0))

&xp.discipline.coil_of_the_ascendant [v(d.xpcd)]=add(if(u(.is_full, %0, bio.mystery_coil, Coil of the Ascendant), u(cost.standard, 3, %1, %2), u(cost.standard, 4, %1, %2)), if(u(.has, %0, merit.crucible), -1, 0))

&xp.discipline.coil_of_the_Wyrm [v(d.xpcd)]=add(if(u(.is_full, %0, bio.mystery_coil, Coil of the Wyrm), u(cost.standard, 3, %1, %2), u(cost.standard, 4, %1, %2)), if(u(.has, %0, merit.crucible), -1, 0))

&xp.discipline.coil_of_the_voivode [v(d.xpcd)]=add(if(u(.is_full, %0, bio.mystery_coil, Coil of the Voivode), u(cost.standard, 3, %1, %2), u(cost.standard, 4, %1, %2)), if(u(.has, %0, merit.crucible), -1, 0))

think Entry complete.
