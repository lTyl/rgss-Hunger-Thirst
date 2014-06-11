!WARNING!: Damn old. Pushed onto Github for archival purposes.
====================

## Summary ##

+ Script Name: Hunger and Thirst
+ Written by: lTyl
+ Current Version: V1.0.0
+ Release Date: March 1, 2008
+ Demo: NO DEMO

# What is it? #

This script was designed for RPG Maker XP. However it is compatible with RPG Maker
VX after a few adjsutments are made. What does it do? This script allows each actor
to have their own hunger and thirst that decreases slowly over time. These points
may be restored bye ating food or by drinking a beverage. In future releases,
should there be any, will warrant additional features.

# Features #
1. Lazy to write

# Compatibility #
No methods are rewritten, should be fine for most.

# Usage #
Place in a new script above main. Customize the options at the top of the script
to your liking.
Default_hunger = 0 is the default hunger that each actor starts with.
Default_thirst = 0 is the default thirst level each actor starts with.
Frames_hunger_down = 500 the amount of frames before the actors hunger starts to rise
Frames_thirst_down = 250 refer to the above.
Call_event_hunger = [x,x,x,x,x,x,x,x,x] calls the common event (x) when hunger reaches
a certain percentage.
Call_event_thirst = [], refer to the above description.

# Creating Items #
First, create an Item in the item Database, set an icon. Next, Call a Common Event
and call the event for that item. So for example, if you had an item called 'Apple',
then make a new common event called 'Apple" and call the apple common event. That way,
when the item is used, the common event is called. On the 'Apple' common event page
you can add any message, animation or anything you want. In order to remove some
hunger/thirst you will then call one of the many commands in the $HTS global
variable class by means of a Call Script event command.

# HTS Class #
The HTS class allows anyone -RGSS experience or otherwise- to easily customize
the script with easy to udnerstand commands. You call the HTS commands by using
a Call script event command and any of the following commands listed below:
```
$HTS.
    add_hunger(amount, member)
    add_thirst(amount, member)
    remove_hunger(amount, member)
    remove_thirst(amount, member)
    set_hunger(amount, member)
    set_thirst(amount, member)
    check_hunger(amount, member, sign)
    check_thirst(amount, member, sign)
    print_hunger
    print_thirst
Where:
Amount = Numerical value
Member = Members Position -1 (Position1-1 = 0)
Sign = "<",">","=","!"
   "<" = Less Than
   ">" = Greater Than
   "=" = Equal to
   "!" = Not Equal to
```

## License ##
Released under the WTFPL (http://www.wtfpl.net/)