//tags list:
//#manager #msloop #dare #brad #whitney #julie #shawndra #stephen #river
//#chat #private #loud

VAR chosen = ""
VAR smudge = false
VAR clean = false
VAR loupe = false
VAR loopcount = 0

->start_loop
=== start_loop ===
The lights are flickering again. #manager
//{boardroom: You okay?|} #manager
+ [{Weird.|Huh.|Nothing I can do about it.}]->intro01
=== intro01 ===
Oh, right; you have to get up to that meeting with Monica. We'll check into the lights without you. #manager
+ Thanks. ->intro02
= intro02
Just a sec and I'll be on my way.
Alright, but be quick. Gotta represent the punctuality of Maintenance. #manager
+ [Remind Daré in Untangling]->introDare
+ [Remind Brad in Janitorial]->introBrad
+ [Remind Whitney in Resources]->introWhitney
+ [Hurry on your way]->boardroom
= introDare
~ chosen = "dare"
Hey, remember to head up to the meeting. #chat
Of course! What kind of Clockwork employee would I be if I forgot a summons from Monica Loop herself. I'll just leave these lines a-tanglin'. #chat #dare
+ [I'd never doubt you.]->boardroom
= introBrad
~ chosen = "brad"
Ready for this meeting? #chat
It'll be a nice break. And hey, maybe some of these floors will actually get a smudge while we're up there. #chat #brad
+ [Give Medusa a fighting chance without a reflection.]->boardroom
= introWhitney
~ chosen = "whitney"
I'm about to go to this meeting. Do you know what it's about? #chat
Not a clue. But thanks for the reminder! See you there. #chat #whitney
+ [Oh, you brought your glasses today?]->boardroom
=== boardroom ===
Stuff happens in the boardroom.
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
    }    {chosen == "dare": ->scissors|chosen == "brad"|}
= scissors
Ms. Loop? Oh my goodness! Are those scissors? ->interrogation
= pen
Oh my goodness. Ms. Loop! Is that a pen? ->interrogation
= tweezers
What the heck?! Where did those tweezers come from? Ms. Loop? Ms. Loop?? ->interrogation
= interrogation
Oh no. Poor Ms. Loop.
+ {chosen == "dare"}[Talk to Daré]->boardroom_dare
+ {chosen == "brad"}[Talk to Brad]->boardroom_brad
+ {chosen == "whitney"}[Talk to Whitney]->boardroom_whitney
+ [...]->boardroom_reset
= boardroom_dare
Sure nuff. #dare
->boardroom_reset
= boardroom_brad
Indeed. #brad
->boardroom_reset
= boardroom_whitney
Wow. #whitney
->boardroom_reset
= boardroom_reset
~ chosen = ""
~ loopcount ++
{loopcount >= 3: ->finish|->start_loop}

=== focusgroup ===
I'm so glad we could have this talk. #msloop
->boardroom.boardroom_reset

=== finish ===
\ 
-> END