//tags list:
//#manager #msloop #dare #brad #whitney #julie #shawndra #stephen #river
//#chat #sfx #loud
//
//#flicker

VAR chosen = ""
VAR loopcount = 0
VAR distrust = false

LIST location = office, meeting, crimescene, outside

LIST present = (manager), msloop, dare, brad, whitney, julie, shawndra, stephen, river, cops, security

LIST known = julieName, shawndraName, stephenName, riverName, smudge, clean, loupe, kill_scissors, solve_scissors, kill_pen, solve_pen, kill_tweezers, solve_tweezers

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
{I|Back i}n the boardroom, everyone seems to be waiting for {something|Ms. Loop to arrive}. Everyone including you.{| It's eerily quiet}
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
vvhmvvhmVVHMVVVHHMmmmmmwumwumwumwub #sfx
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
- {known ? stephenName:Stephen|The dour man} is already bending over her before anyone else can react. Oh my goodness. Ms. Loop! Is that a pen? ->interrogation

= tweezers
~ location = crimescene
~ present -= msloop
Five people gasp. Five people including you, as the total number still drawing breath in this room.
+ [{known ? (kill_tweezers):It's reflex more than anything|{scissors && pen:Oh dear|"...Ms. Loop?"}}]
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

= boardroom_brad
Indeed. #brad
+ [...]->boardroom_reset

= boardroom_whitney
Wow. #whitney
+ [...]->boardroom_reset

= boardroom_reset
~ chosen = ""
~ loopcount ++
~ present -= (manager, msloop, dare, brad, whitney, julie, shawndra, stephen, river, cops, security)
#flicker
->start_loop

=== focusgroup ===
I'm so glad we could have this talk. #msloop
+ [...]->boardroom.boardroom_reset

=== fight ===
~ present += security
A minute later, you're tackled to the ground by security. They call local law enforcement.
+ ["{That's overkill|C'mon, not again}!"]->arrest

= arrest
The security team pretends not to hear your objections, and you see flashing lights reflecting from the entryway.
+ [...]
-As the doors open, a{loopcount >= 1: now-familiar|n otherwordly} whine jostles your bones along with the TM's rustling and haywire lights...
+ [...]
-vvhmvvhmVVHMVVVHHMMMVVVVHHHHHMMMMMMMMMMM #sfx
+ [...]->boardroom.boardroom_reset

=== finish ===
\ 
-> END