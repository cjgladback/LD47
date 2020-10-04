//tags list:
//#manager #msloop #dare #brad #whitney #julie #shawndra #stephen #river
//#chat #sfx #loud
//#flicker

VAR chosen = ""
VAR smudge = false
VAR clean = false
VAR loupe = false
VAR loopcount = 0

->start_loop
=== start_loop ===
The lights are flickering again. #manager
+ ["{Weird|Huh|Nothing I can do about it}."]->intro01

=== intro01 ===
{boardroom: You okay?} {loopcount >= 2: You look a little pale.} Oh, right; you have to get up to that meeting with Monica. We'll check into the lights without you. #manager
+ ["Thanks. Just a sec."] ->intro02

= intro02
{TURNS_SINCE(-> intro01) == 1: Alright, but be quick. Gotta represent the punctuality of Maintenance!|} #manager
+ {TURNS_SINCE(-> intro01) == 1} ["Punctuality? In this company? Say it ain't so."]
    -- Ha. {&'We make the Clock Work for You,'|We put the 'lines' in 'timeliness,'|We try to be ahead of the times,} but we're still fans of the old-fashioned way.->intro02
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
No, not a clue what the meeting's about. But thanks for the reminder! See you there. #chat #whitney
+ ["Oh, you brought your glasses today?"]->boardroom

=== boardroom ===
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
#flicker
{loopcount >= 3: ->finish|->start_loop}

=== focusgroup ===
I'm so glad we could have this talk. #msloop
+ [...]->boardroom.boardroom_reset

=== finish ===
\ 
-> END