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

LIST known = julieName, shawndraName, stephenName, riverName, smudge, clean, loupe

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
Everyone seems to be waiting for {something|Ms. Loop to arrive}. Everyone including you.{| It's eerily quiet}
+ [Talk to {known ? shawndraName: Shawndra|your neighbor}]
  ~ known += shawndraName
  -- "Good morning! Yes, I'm Shawndra. Human Resources, but I don't bite. Does Maintenance know what this meeting's about?" #shawndra
  ++ ["I was hoping you did."]
  -- "No, alas. Such is the state of our intra-company communication." #shawndra
  ++ ["{Yeah|I guess so|Mm-hmm}."]->boardroom_split
+ [Remark on the weather]
  -- "Yeah, it sure is. I remember last year it was the opposite. Like some kind of weird cycle." #stephen
  ++ ["Ain't that the way."]
    --- "All I can say is thank goodness for the top-notch climate control in this office." #julie
    +++ [Sit back, satisfied to have broken the silence]
      ---- "Clockwork Inc is nothing if not gifted in controlling variables." #Shawndra
      ++++ [...]->boardroom_split
    +++ {present ? (dare)}["Who actually designed this building?"]
      ---- "Whoever they were, they forgot to leave room for spaceheaters on the floor of the TM room." #river
      ++++ ["Is that why maintenance keeps getting requests for ceiling mounts?"]
      ---- "May cooler heads prevail." #dare
      ++++ [Laugh]->boardroom_split
      ++++ [Groan]->boardroom_split
      ++++ [Pick a fight]->fight
    +++ ["Wow this is boring."]
      ~ distrust = true
      ---- "...Worse than sitting in silence in a boardroom with strangers?" #stephen
      ++++ ["Fair."]->boardroom_split
      ++++ [Pick a fight]->fight
  ++ [Lapse into silence]->boardroom_split
+ [Wait this out]->boardroom_split

= boardroom_split
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
Ms. Loop? Oh my goodness! Are those scissors? ->interrogation

= pen
Oh my goodness. Ms. Loop! Is that a pen? ->interrogation

= tweezers
What the heck?! Where did those tweezers come from? Ms. Loop? Ms. Loop?? ->interrogation

= interrogation
~ location = crimescene
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
+ [...]->boardroom.boardroom_reset

=== finish ===
\ 
-> END