//tags list:
//#manager #msloop #dare #brad #whitney #julie #shawndra #stephen #river
//#chat #sfx #loud
//#flicker

VAR chosen = ""
VAR loopcount = 0
VAR distrust = false

LIST location = office, meeting, crimescene, outside

LIST present = (manager), msloop, dare, brad, whitney, julie, shawndra, stephen, river, cops, security

<<<<<<< HEAD
LIST known = julieName, shawndraName, stephenName, riverName, smudge, clean, loupe, lie, allergy, perfume, kill_scissors, solve_scissors, kill_pen, solve_pen, kill_tweezers, solve_tweezers
=======
LIST known = julieName, shawndraName, stephenName, riverName, smudge, clean, loupe, kill_scissors, solve_scissors, kill_pen, solve_pen, kill_tweezers, solve_tweezers
>>>>>>> parent of 9dee05e... Submitted!

->start_loop
=== start_loop ===
~ location = office
~ present += manager
"The lights are flickering again." #manager
+ ["{Weird|Huh|Wish I could fix it}."]->intro01

=== intro01 ===
"{boardroom:You okay? }{loopcount >= 2:You look a little pale. }Oh, right; you have to get up to that meeting with Monica. We'll check into the lights without you." #manager
+ ["Thanks. Just a sec."] ->intro02

= intro02
{TURNS_SINCE(-> intro01) == 1:"Alright, but be quick. Gotta represent the punctuality of Maintenance!"|} #manager
+ {TURNS_SINCE(-> intro01) == 1} ["Punctuality? In this company? Say it ain't so."]
    -- "Ha. {&'We make the Clock Work for You,'|We put the 'timelines' in 'timeliness,'|We try to be ahead of the times,} but we're still fans of the old-fashioned way."->intro02
+ {known ? (smudge, clean, loupe)}[Start group thread with Brad and Whitney]->fix
+ [Remind Dare in Untangling]->introDare
+ [Remind Brad in Janitorial]->introBrad
+ [Remind Whitney in Resources]->introWhitney
+ [Hurry on your way]->boardroom


= introDare
~ chosen = "dare"
Of course! What kind of Clockwork employee would I be if I forgot a summons from Monica Loop herself. I'll just leave these lines a-tanglin'. #chat #dare
+ ["I'd never doubt you."]->boardroom

= introBrad
~ chosen = "brad"
Oh yeah, I'm ready. It'll be a nice break. And hey, maybe some of these floors will actually get a smudge while we're up there. #chat #brad
+ ["Give Medusa a fighting chance without a reflection."]->boardroom

= introWhitney
~ chosen = "whitney"
Yeah, not a clue what the meeting's about. But thanks for the reminder! See you there. #chat #whitney
+ ["Oh, you brought your glasses today?"]->boardroom

=== boardroom ===
~ location = meeting
~ present -= manager
~ present += (julie, shawndra, stephen, river)
{
        - chosen == "dare":
            ~ present += dare

        - chosen == "brad":
            ~ present += brad
            
        - chosen == "whitney":
            ~ present += whitney
}
{I|Back i}n the boardroom, everyone seems to be waiting for {something|Ms. Loop to arrive}. Everyone including you{|. It's eerily quiet}.
+ [Talk to {known ? shawndraName:Shawndra|your neighbor}]
  ~ known += shawndraName
  -- "Good morning! Yes, I'm Shawndra. Human Resources, but I don't bite. Does Maintenance know what this meeting's about?" #shawndra
  ++ ["I was hoping you did."]
  -- "No, alas. Such is the state of our intra-company communication." #shawndra
  ++ ["{Yeah|I guess so|Mm-hmm}."]->boardroom_msloopenters
+ [Remark on the weather]
  -- "Yeah, it sure is. I remember last year it was the opposite. Like some kind of weird cycle." #stephen
  ++ ["Ain't that the way."]
    --- "All I can say is thank goodness for the top-notch climate control in this office." #julie
    +++ [Sit back, satisfied to have broken the silence]
      ---- "Clockwork Inc is nothing if not gifted in controlling variables." #shawndra
      ++++ [...]->boardroom_msloopenters
    +++ {present ? (dare)}["Who actually designed this building?"]
      ---- "Whoever they were, they forgot to leave room for spaceheaters on the floor of the TM room." #river
      ++++ ["Is that why maintenance keeps getting requests for ceiling mounts?"]
      ---- "May cooler heads prevail." #dare
      ++++ [Laugh]->boardroom_msloopenters
      ++++ [Groan]->boardroom_msloopenters
      ++++ [Pick a fight]->fight
    +++ ["It is nice in here."]
      ---- "Well, it would be if the coffee maker in Accounting weren't on the fritz. #stephen
      ++++ [...]
      ~ known += stephenName
      ---- "I wouldn't say your chemical dependency has any bearing on whether the atmosphere is nice, Stephen." #julie
      ++++ [....]
      ~ known += julieName
      ---- "Well, Julie, I'd say it's actually kinda chilly." #stephen
      ++++ [.....]->boardroom_msloopenters
    +++ ["Wow this is boring."]
      ~ distrust = true
      ---- "...Worse than sitting in silence in a boardroom with strangers?" #stephen
      ++++ ["Fair."]->boardroom_msloopenters
      ++++ [Pick a fight]->fight
  ++ [Lapse into silence]->boardroom_msloopenters
+ [Wait this out]->boardroom_msloopenters

= boardroom_msloopenters
~present += msloop
Finally, {Ms. Monica Loop|Ms. Loop} steps into the room.
+ [...]
-"Thank you for your patience, everyone. I hope you all had a chance to get acquainted! It's so seldom that we have interdepartmental gatherings." #msloop
+ [...]
- "As you know, here at Clockwork Inc, our chief value is integrity, and that implies a need to stick together." #msloop
+ [...]
- "Now, I'm sure you're all wondering why I've gathered you here today..."
A low whine cuts her off. #msloop
vvhmvvhmVVHMVVVHHMMmwumwumwumwub #sfx #flicker
+ [There go the lights]
- "...And when we'll get the power fluctuations under control. Let's just give the generators a moment to kick in." #msloop
+ [...]
- Everything's louder in the silence after the TM's surge. Or is someone moving?
+ [...]->boardroom_split

= boardroom_split
The lights turn on again. <>
{
        - chosen == "dare":
            -> scissors

        - chosen == "brad":
            -> pen
            
        - chosen == "whitney":
            -> tweezers

        - else:
            // breakfast-based dreams have no effect
            -> focusgroup
}

= scissors
~ location = crimescene
~ present -= msloop
Five people gasp. Five people including you, as the total number still drawing breath in this room.
+ [{known ? (kill_scissors):It's reflex more than anything|{pen && tweezers:Oh dear|"...Ms. Loop?"}}]
~ known += kill_scissors
- {known ? stephenName:Stephen|The dour man} is already bending over her before anyone else can react. Ms. Loop? Oh my goodness! Are those scissors? ->interrogation

= pen
~ location = crimescene
~ present -= msloop
Five people gasp. Five people including you, as the total number still drawing breath in this room.
+ [{known ? (kill_pen):It's reflex more than anything|{scissors && tweezers:Oh dear|"...Ms. Loop?"}}]
~ known += kill_pen
<<<<<<< HEAD
->evidence_tunnel->
-
+ [...]->pen_interosub

= pen_interosub
"I'll make this short. I totally lied just now." #stephen
+ [...]
- "Never try to write multiple murder mystery choose-your-own-adventures in a single day.
"You'll be better off reminding Dare about the meeting for closer to the full experience." #stephen
+ [...]
- "I killed Ms. Loop, and I would've gotten away with it, too--except that I thought I had to also take out this snitching janitor who I recognize from the time I snuck a corporate spy into the TM room." #stephen
+ [...]
- "Brad is, by the way, casually amazing at cleaning glass. In case you wanna know." #stephen
~ known += (clean, solve_pen)
+ [...]
- "It was good pay, and I don't believe this TM our jobs are all relying on actually works. So I needed money. Don't judge me." #stephen
+ [Judge him]
- "Anyway, you stopped me from killing Brad or anyone else who claimed to know about the bribe. And here come the police now, opening the doors." #stephen
+ [Oh no, not the circuit!]->loop_reset
=======
- {known ? stephenName:Stephen|The dour man} is already bending over her before anyone else can react. Oh my goodness. Ms. Loop! Is that a pen? ->interrogation
>>>>>>> parent of 9dee05e... Submitted!

= tweezers
~ location = crimescene
~ present -= msloop
Five people gasp. Five people including you, as the total number still drawing breath in this room.
+ [{known ? (kill_tweezers):It's reflex more than anything|{scissors && pen:Oh dear|"...Ms. Loop?"}}]
<<<<<<< HEAD
- {known ? stephenName:Stephen|The dour man} is already bending over her before anyone else can react. He straightens with something in his hand.
+ ["What is it?"]
- "Someone stuck her with a pair of tweezers!" #stephen #loud
+ [{known ? kill_tweezers:Act shocked|{known ? kill_pen:What?|{known ? kill_scissors:What?|WHAT?!}}}]
~ known += kill_tweezers
->evidence_tunnel->
-
+ [...]->tweezers_interosub

= tweezers_interosub
"Wow, you got me." #river
+ [...]
- "Never try to write multiple murder mystery choose-your-own-adventures in a single day.
"You'll be better off reminding Dare about the meeting for closer to the full experience." #river
+ [...]
- "I killed Ms. Loop cause she was totally gonna fire me for my habitual lack of diligence in the TM room overnight." #river
+ [...]
- "We know there are some business rivals trying to steal our information, sneaking around and stuff, but it's just really important to me that I get the highest score in every mobile app game on my phone, and it's not like we're allowed to have those in the building let alone the TM room." #river
+ [...]
- "Anyway, it totally woulda worked out if I hadn't gotten wet fingernail polish on your gemologist friend Whitney's perfect little jeweler's loupe when I grabbed the tweezers from her toolkit. Oh well." #river
~ known += (loupe, solve_tweezers)
+ [...]
- "But here comes the fuzz, to open the door and take me to justice. Hope they have wifi." #river
+ [Oh no, not the circuit!]->loop_reset

=== interrogation ===
Everyone looks a bit shellshocked.{loopcount > 3: You try to match their expressions.}
+ [Let's figure this out]->question_hub

= question_hub
+ {chosen == "dare" && known ? (perfume, allergy)}["I know who did this."]->accuse_shawndra
+ {chosen == "dare"}[Talk to Dare]->interrogate_dare
+ {chosen == "brad"}[Talk to Brad]->interrogate_brad
+ {chosen == "whitney"}[Talk to Whitney]->interrogate_whitney
+ [Talk to {known ? shawndraName:Shawndra|the woman sitting next to you}]->interrogate_shawndra
+ [Talk to {known ? julieName:Julie|the woman next to the body}]->interrogate_julie
+ [Talk to {known ? stephenName:Stephen|the idiot, or murderer, who picked up a murder weapon in front of you}]->interrogate_stephen
+ [Talk to {known ? riverName:River|the individual checking their manicure}]->interrogate_river
+ [Open a window]->loop_reset

= interrogate_dare
"{TURNS_SINCE(->question_hub) < 2:Who would hurt Monica|Got more questions}?" #dare
+ ["Were you friends?"]
-- "Yeah, I think so. We worked pretty closely together. Had some bonding hijinks with company crises over the years." #dare
++ ["Didn't you just start here this spring?"]
--- "Ha, I guess you're right. Time flies." #dare
+++ ["So it does."]->interrogate_dare
+ ["Did she seem at all...off recently?"]
-- "She's been really busy, like the rest of the higher ups, with getting new investors and potential clients." #dare
++ ["Something wrong with the old investors?"]
--- "She didn't let much slip usually, but I was there when one of them got dropped." #dare
+++ ["Dropped?"]
--- "He was...um. Not in allignment with the company values. Wanted the TM for personal gains at any global cost." #dare
+++ ["...That sounds dramatic."]
--- "It was, a little. But there are plenty of well-intentioned investors who we just need convince that we're serious." #dare
+++ ["Speaking of serious..."]->interrogate_dare
+++ ["Does the TM...work?"]
--- "How do I put this...I can legally tell you that we claim it does and everyone in leadership here is in accordance with our company values." #dare
+++ ["Uh-huh"]->interrogate_dare
++ ["Is the company in financial trouble?"]
--- "No. Or it certainly shouldn't be." #dare
+++ [...]
--- "We're careful not to let too much of the TM technique get public, but gems like Julie over there, in Marketing, have all the information and expertise they need to spread the word." #dare
~ known += julieName
+++ ["Good to know."]->interrogate_dare
+ ["Did you see anything?"]
-- "Other than my favorite scissors up there?" #dare
++ ["Those are yours?"]
-- "Yeah, I brought them with me cause neighbor Jeff keeps borrowing them for his kirigami. Dulls them like nothing else." #dare
++ ["Fair, I guess."]
-- "You saw how dark it was. No, I didn't see, hear, or smell anything...not that I would." #dare
++ [...]
-- "I mean smell. I got a new eau de toilette that's a little strong." #dare
++ ["Is that lavender?"]
~ known += perfume
-- "Yeah, one of my favorites. I haven't gotten to wear any for ages, cause my desk mate was allergic." #dare
++ {known ? (perfume, allergy)}["...I think I know who did this."]->accuse_shawndra
++ ["...Was?"]
-- "Don't look at me like that. She got poached by the competition." #dare
++ ["So not dead."]
--- "Not as of last week." #dare
+++ [Cool]->interrogate_dare
++ ["There's competition in the field of 'untangling?'"]
--- "Sure is. What, did you think it was a fake department?" #dare
+++ ["Of course not."]
---- "More like 'of course, knot.'" #dare
++++ [...]->interrogate_dare
+++ ["It does sound fake."]
~ known += stephenName
---- "Oh please, you're as bad as doubters like Stephen over there. He doesn't even think the TM is real." #dare
++++ [...]->interrogate_dare
+ ["Not right now."]->question_hub

//+ [...]->loop_reset
=======
What the heck?! Where did those tweezers come from? Ms. Loop? Ms. Loop?? ->interrogation

= interrogation
Oh no. Poor Ms. Loop.
+ {chosen == "dare"}[Talk to Dare]->boardroom_dare
+ {chosen == "brad"}[Talk to Brad]->boardroom_brad
+ {chosen == "whitney"}[Talk to Whitney]->boardroom_whitney
+ [...]->boardroom_reset

= boardroom_dare
Sure nuff. #dare
+ [...]->boardroom_reset
>>>>>>> parent of 9dee05e... Submitted!

= boardroom_brad
Indeed. #brad
+ [...]->boardroom_reset

= boardroom_whitney
Wow. #whitney
<<<<<<< HEAD
+ [...]->loop_reset

= interrogate_shawndra
"{TURNS_SINCE(->question_hub) < 2:Hello. {known ? shawndraName:Yes, it is|Of course. My name's} Shawndra.|Something else?}" #shawndra
~ known += shawndraName
+ ["What department are you from again?"]
-- "Human Resources. {TURNS_SINCE(->question_hub) < 3:This is going to throw the company structure into chaos.|{I just told you that. Do you think I'm lying?|Ya jerk.}}" #shawndra
++ [Maybe]->interrogate_shawndra
//only available after you give it a moment in the scissors arc
+ {chosen == "dare" && TURNS_SINCE(->question_hub) > 1}["Is your hand okay?"]
-- "Yeah. Just an allergic reaction. Or I might be breaking out in hives. This is a stressful situation." #shawndra
++ [...]
-- "Are you okay?" #shawndra
++ ["Are you allergic to lavender?"]
-- "Why do you ask?" #shawndra
++ ["Thought I smelled it."]
~ known += lie
--- "No, I'm not." #shawndra
+++ ["Okay."] -> interrogate_shawndra
++ ["I'm a little claustrophobic."]
--- "...What?" #shawndra
+++ ["Strong scents help distract me."]
--- "Okay." #shawndra
+++ ["So you're alright if I spray some of my lavender perfume?"]
~ known += allergy
--- "No, sorry. {known ? lie:And sorry for lying earlier; |}I am allergic. Probably not good for the evidence either when someone finally gets to gather it, anyway."
+++ {known ? (perfume, allergy)}[Accuse Shawndra]->accuse_shawndra
+++ ["Yeah, you're right."]->interrogate_shawndra
+ ["I guess that's all."]->question_hub

= interrogate_julie
"{TURNS_SINCE(->question_hub) < 2:Hello. {known ? julieName:Yes; did Stephen tell you my name? I'd hate to think what else.|Good to meet you, I suppose; I'm Julie.}|There's more?}" #julie
~ known += julieName
+ ["I guess that's all."]->question_hub

= interrogate_stephen
"{TURNS_SINCE(->question_hub) < 2:What do you need? {known ? stephenName:Yes, the name's Stephen|I'm Stephen}. More importantly, I'm innocent.|More questions?}" #stephen
~ known += stephenName
+ ["I guess that's all."]->question_hub

= interrogate_river
"Sorry, do I look like a fully formed character to you?{ Okay, fine, you can know my name's River.|}"
~ known += riverName
+ ["I guess that's all."]->question_hub

=== accuse_shawndra ===
You point out the facts of the perfume on the scissors and the rash on Shawndra's hand, with her known allergy to lavender.
+ [...]
- "But I keep track of everyone's allergy warnings from HR. I'm really careful." #dare
+ [...]
- "I don't think anybody's complaining this time." #stephen
+ [...]
- "But what if it had been a more serious allergy?" #dare
+ [It's an allergy that's getting her caught for murder, but you take their point]
- "What if I mess up again? What if someone else dies?" #dare
+ ["You didn't kill anyone."]
- "But I could have! I don't have that many friends! I can't spare any more." #dare #loud
+ [...]
- "I'm so sorry, Shawndra." #dare
+ [{known ? solve_scissors:Is this manipulation?|What the heck}]
- "I didn't mean to hurt you." #dare
+ [{known ? solve_scissors:Wow, they're good|Is Shawndra crying?}]
- "You didn't." #shawndra
+ [...]
- "I didn't know there was an allergy list to fill in." #shawndra
+ [...]
- "But we're always so careful; it's one of the first onboarding steps." #dare
+ [...]
- "I didn't know. I didn't as such go through onboarding." #shawndra
+ [...]
- "What do you mean?" #dare
+ [...]
- "I wasn't hired by Clockwork Inc, I was hired by The Times. They subbed me in for one of your new hires before they arrived." #shawndra
+ [...]
- "Did you think Monica had found out? Is that why you killed her?" #dare
+ [...]
- "I know I left evidence in the TM room. I smudged one of those ridiculous lenses."  #shawndra
~ known += smudge
+ [...]
- "They're not lenses, they're loupes." #julie
+ [...]
- "They're bogus is what they are. But they hold a fingerprint well. I still haven't found the real machine, but I couldn't take jail time. Which is why..."
- Shawndra grabs the scissors where Stephen left them on the table, wrapping them in her sleeve and backing toward the window. #shawndra
+ [Oh dear]
- "I'll be taking my leave now." She unlatches the window. #shawndra
+ [{loop_reset:The familiar TM|A bone-rattling} hum kicks in]->loop_reset

=== loop_reset ===
vvhmvvhmVVHMVVVHHMMMVVVVHHHHHMMMMMMMMMMM #sfx
+ [...]
=======
+ [...]->boardroom_reset

= boardroom_reset
>>>>>>> parent of 9dee05e... Submitted!
~ chosen = ""
~ loopcount ++
~ known -= lie
~ present -= (manager, msloop, dare, brad, whitney, julie, shawndra, stephen, river, cops, security)
#flicker
->start_loop

<<<<<<< HEAD
=== evidence_tunnel ===
"Nobody's leaving this room until we get to the bottom of this." #stephen
+ ["We need to get help."]
-- "By leaving the room? Destroying evidence? We don't have phones, thanks to the secrecy-over-security Clockwork policy." #stephen
++ [...]
-- "'Destroying evidence?!' You just picked up the murder weapon!" #julie #loud
++ [Yeah, he did]
-- "Well. I didn't...okay that was a bad move. I was just shocked." #stephen
++ [...]
-- "Anyway, it's not like I'm leaving until you're satisfied I'm innocent. I am, you know." #stephen
++ [My, how fair and measured]
-- "But we would've all heard the door open if it were someone from outside; it squeaks." #stephen
++ [It did squeak when everyone walked in]
-- "We can send someone to get help as soon as we establish someone who's innocent." #stephen
-- ->->
+ {interrogation}[Right, this again]->->
+ {boardroom.tweezers_interosub}[Right, this again]->->
+ {boardroom.pen_interosub}[Right, this again]->->

=== fix ===
Sup? #chat #brad
Oh, that meeting! #chat #whitney
+ ["Actually, I need you two to skip."]
- Skip out on an elbow-rubbing demand? Gladly. #chat #brad
- Why? #chat #whitney
+ ["Just got a maintenance request on one of the loupes in the TM. Critical importance."]
- Hate to point it out, we aren't maintenance. #chat #brad
+ ["No, but Whitney has a loupe to replace it with while you, King of Clean, do your thing."]
- Okay, I as royalty accept my subjects' request. #chat #brad
- Do I really have to miss the meeting? #chat #whitney
+ ["Yeah, sorry, Whit. Critical means real danger here."]
- Alright, meet you in five in the TM airlock, okay? #chat #whitney
- You got it. #chat #brad
+ ["Okay. Let me know how it goes!"]
~ location = meeting
~ present -= manager
~ present += (msloop, shawndra, stephen, river, julie)
- By the time you arrive, you can hear Ms. Loop in the hall. You sit out of habit and a little hope.
+ [...]->boardroom.boardroom_msloopenters

=== focusgroup ===
Ms. Loop chuckles.
+ [...]
- "Much better. Now each of your managers recommended you for this focus group to improve Clockwork from the inside." #msloop
+ [...]
- "Just like the loupes we use in the TM, you'll help Clockwork Inc focus in on what makes this company special." #msloop
+ [...]->winSwitchTunnel->
- Some time later, the meeting seems to be wrapping up.
+ [Oh good]
- "Thank you so much for your feedback, everyone. I think it's about time we all head to lunch and then back to the same old same old, but I'll be reaching out to you in the next week. We want to keep this dialogue open, make sure to keep each other in the loop." #msloop
+ [{loopcount > 2:If she only knew|...}]
- As you file into the lobby, Ms. Loop pulls on the door. Immediately, the room is filled with {loop_reset:a familiar |}gut-churning noise.
+ [Open a window]->loop_reset

= winning
~ present += dare
Dare pops their head in the door.
+ [What brought them here without a reminder?]
- "Did it happen again, Dare?" #msloop
+ [Again?]
- "Yes, ma'am. No reports yet on who got caught." #dare
+ [Oh]
- There is at least one offensively sharp pen still on the table.
+ [Pocket it and stand]
- "Actually, I do have some information regarding...getting caught."
+ [Congratulations! You are no longer stuck in a loop.]->finish

=== winSwitchTunnel ===
{
        - fix:
            ->focusgroup.winning

        - else:
            ->->
}
=======
=== focusgroup ===
I'm so glad we could have this talk. #msloop
+ [...]->boardroom.boardroom_reset
>>>>>>> parent of 9dee05e... Submitted!

=== fight ===
~ present += security
A minute later, you're tackled to the ground by security. They call local law enforcement.
+ ["{That's overkill|C'mon, not again}!"]->arrest

= arrest
The security team pretends not to hear your objections, and you see flashing lights reflecting from the entryway.
+ [...]
-As the doors open, a{loopcount >= 1: now-familiar|n otherwordly} whine jostles your bones along with the TM's rustling and haywire lights...
<<<<<<< HEAD
+ [...]->loop_reset
=======
+ [...]
-vvhmvvhmVVHMVVVHHMMMVVVVHHHHHMMMMMMMMMMM #sfx
+ [...]->boardroom.boardroom_reset
>>>>>>> parent of 9dee05e... Submitted!

=== finish ===
\ 
-> END