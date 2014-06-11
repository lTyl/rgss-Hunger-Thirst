#===============================================================================
# Hunger & Thirst
#===============================================================================
# Written by Synthesize
# March 1, 2008
# Version 1.0.1
#===============================================================================
module SynHT
  Default_hunger = 0    # Default Hunger
  Default_thirst = 0    # Default Thirst
  Frames_hunger_down = 40   # # of frames before hunger rises
  Frames_thirst_down = 250    # # of frames before thirst rises
  Call_event_hunger = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  # 200% Hunger(Death), 175% Hunger, 150% Hunger, 125% Hunger, 100% Hunger
  # 75% hunger, 50% Hunger, 25% Hunger, 0% Hunger.
  Call_event_thirst = [10, 11, 12, 13, 14, 15, 16, 17, 18]
  # 200% Thirst(Death), 175% Thirst, 150% Thirst, 125% Thirst, 100% Thirst
  # 75% Thirst, 50% Thirst, 25% Thirst, 0% Thirst.
end
=begin
#-------------------------------------------------------------------------------
# Documentation
#-------------------------------------------------------------------------------
# Introduction
#-------------------------------------------------------------------------------
This script was designed for RPG Maker XP. However it is compatible with RPG Maker
VX after a few adjsutments are made. What does it do? This script allows each actor
to have their own hunger and thirst that decreases slowly over time. These points
may be restored bye ating food or by drinking a beverage. In future releases,
should there be any, will warrant additional features.
#-------------------------------------------------------------------------------
# Compatibility
#-------------------------------------------------------------------------------
This script should be compatible with most scripts as no methods are rewritten.
#-------------------------------------------------------------------------------
# Usage:
#-------------------------------------------------------------------------------
Place in a new script above main. Customize the options at the top of the script
to your liking.
Default_hunger = 0 is the default hunger that each actor starts with.
Default_thirst = 0 is the default thirst level each actor starts with.
Frames_hunger_down = 500 the amount of frames before the actors hunger starts to rise
Frames_thirst_down = 250 refer to the above.
Call_event_hunger = [x,x,x,x,x,x,x,x,x] calls the common event (x) when hunger reaches
a certain percentage.
Call_event_thirst = [], refer to the above description.
#-------------------------------------------------------------------------------
# Creating items/Events that 'refill' an actors Hunger/Thirst
#-------------------------------------------------------------------------------
First, create an Item in the item Database, set an icon. Next, Call a Common Event
and call the event for that item. So for example, if you had an item called 'Apple',
then make a new common event called 'Apple" and call the apple common event. That way,
when the item is used, the common event is called. On the 'Apple' common event page
you can add any message, animation or anything you want. In order to remove some
hunger/thirst you will then call one of the many commands in the $HTS global
variable class by means of a Call Script event command.
#-------------------------------------------------------------------------------
# The HTS Class
#-------------------------------------------------------------------------------
The HTS class allows anyone -RGSS experience or otherwise- to easily customize
the script with easy to udnerstand commands. You call the HTS commands by using
a Call script event command and any of the following commands listed below:
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
=end
#-------------------------------------------------------------------------------
# Game_Actor:: Create Hunger and Thirst Points
#-------------------------------------------------------------------------------
class Game_Actor < Game_Battler
  attr_accessor :hunger
  attr_accessor :thirst
  alias syn_ht_setup setup
  def setup(actor_id)
    syn_ht_setup(actor_id)
    @hunger = SynHT::Default_hunger
    @thirst = SynHT::Default_thirst
  end
end
#-------------------------------------------------------------------------------
# Scene_Map:: Reduce Hunger/Thirst points
#-------------------------------------------------------------------------------
class Scene_Map
  alias syn_ht_update update
  #-----------------------------------------------------------------------------
  # Initiate variables
  #-----------------------------------------------------------------------------
  def initialize
    @wait_time = 0
    @wait_time_thirst = 0
  end
  #-----------------------------------------------------------------------------
  # Update:: Updates the surrent scene
  #-----------------------------------------------------------------------------
  def update
    syn_ht_update
    wait(1, true) if @wait_time != SynHT::Frames_hunger_down
    wait(1, false) if @wait_time_thirst != SynHT::Frames_thirst_down
    if @wait_time == SynHT::Frames_hunger_down or @wait_time2 == SynHT::Frames_thirst_down
      for i in 0...$game_party.actors.size
        $game_party.actors[i].hunger += 1 if @wait_time == SynHT::Frames_hunger_down
        $game_party.actors[i].thirst += 1 if @wait_time2 == SynHT::Frames_thirst_down
        call_ht_event(0, 0) if $game_party.actors[i].hunger == 200
        call_ht_event(1, 0) if $game_party.actors[i].hunger == 175
        call_ht_event(2, 0) if $game_party.actors[i].hunger == 150
        call_ht_event(3, 0) if $game_party.actors[i].hunger == 125
        call_ht_event(4, 0) if $game_party.actors[i].hunger == 100
        call_ht_event(5, 0) if $game_party.actors[i].hunger == 75
        call_ht_event(6, 0) if $game_party.actors[i].hunger == 50
        call_ht_event(7, 0) if $game_party.actors[i].hunger == 25
        call_ht_event(8, 0) if $game_party.actors[i].hunger == 0
        call_ht_event(0, 1) if $game_party.actors[i].thirst == 200
        call_ht_event(1, 1) if $game_party.actors[i].thirst == 175
        call_ht_event(2, 1) if $game_party.actors[i].thirst == 150
        call_ht_event(3, 1) if $game_party.actors[i].thirst == 125
        call_ht_event(4, 1) if $game_party.actors[i].thirst == 100
        call_ht_event(5, 1) if $game_party.actors[i].thirst == 75
        call_ht_event(6, 1) if $game_party.actors[i].thirst == 50
        call_ht_event(7, 1) if $game_party.actors[i].thirst == 25
        call_ht_event(8, 1) if $game_party.actors[i].thirst == 0
      end
    end
    @wait_time = 0 if @wait_time == SynHT::Frames_hunger_down
    @wait_time2 = 0 if @wait_time2  == SynHT::Frames_thirst_down
  end
  #-----------------------------------------------------------------------------
  # Wait:: Allows Wait Times
  #-----------------------------------------------------------------------------
  def wait(duration, variable)
    for i in 0...duration
      @wait_time += 1 if variable
      @wait_time_thirst if variable == false 
      break if i >= duration / 2
    end
  end
  #-----------------------------------------------------------------------------
  # Call_HT_Event:: Call the specified Common Event
  #-----------------------------------------------------------------------------
  def call_ht_event(event_id, mode)
    case mode
    when 0
      $game_temp.common_event_id = SynHT::Call_event_hunger[event_id]
    when 1
      $game_temp.common_event_id = SynHT::Call_event_thirst[event_id]
    end
  end
end
#-------------------------------------------------------------------------------
# HT_Data:: Modifies the hunger/thirst points of each actor
#-------------------------------------------------------------------------------
class HT_Data
  #-----------------------------------------------------------------------------
  # Add Hunger
  #-----------------------------------------------------------------------------
  def add_hunger(amount, member)
    $game_party.actors[member].hunger += amount
  end
  #-----------------------------------------------------------------------------
  # Add Thirst
  #-----------------------------------------------------------------------------
  def add_thirst(amount, member)
    $game_party.actors[member].thirst += amount
  end
  #-----------------------------------------------------------------------------
  # Remove Hunger
  #-----------------------------------------------------------------------------
  def remove_hunger(amount, member)
    add_hunger(-amount, member)
  end
  #-----------------------------------------------------------------------------
  # Remove Thirst
  #-----------------------------------------------------------------------------
  def remove_thirst(amount, member)
    add_thirst(-amount, member)
  end
  #-----------------------------------------------------------------------------
  # Set Hunger
  #-----------------------------------------------------------------------------
  def set_hunger(amount, memebr)
    $game_party.actors[member].hunger = amount
  end
  #-----------------------------------------------------------------------------
  # Set Thirst
  #-----------------------------------------------------------------------------
  def set_thirst(amount, member)
    $game_party.actors[member].thirst = amount
  end
  #-----------------------------------------------------------------------------
  # Check Hunger
  #-----------------------------------------------------------------------------
  def check_hunger(amount, member, sign)
    case sign
    when ">"
      if $game_party.actors[member].hunger >= amount
        return true
      else
        return false
      end
    when "<"
      if $game_party.actors[member].hunger <= amount
        return true
      else
        return false
      end
    when "!"
      if $game_party.actors[member].hunger != amount
        return true
      else
        return false
      end
    when "="
      if $game_party.actors[member].hunger == amount
        return true
      else
        return false
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Check Thirst
  #-----------------------------------------------------------------------------
  def check_thirst(amount, member, sign)
    case sign
    when ">"
      if $game_party.actors[member].thirst >= amount
        return true
      else
        return false
      end
    when "<"
      if $game_party.actors[member].thirst <= amount
        return true
      else
        return false
      end
    when "!"
      if $game_party.actors[member].thirst != amount
        return true
      else
        return false
      end
    when "="
      if $game_party.actors[member].thirst == amount
        return true
      else
        return false
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Print Hunger
  #-----------------------------------------------------------------------------
  def print_hunger
    p $game_party.actors[0].hunger
  end
  #-----------------------------------------------------------------------------
  # Print Thirst
  #-----------------------------------------------------------------------------
  def print_thirst
    p $game_party.actors[0].thirst
  end
end  
#-------------------------------------------------------------------------------
# Redefine $HTS global variable
#-------------------------------------------------------------------------------
class Game_System
  alias syn_ht_update update
  def update
    syn_ht_update
    $HTS = HT_Data.new
  end
end
#===============================================================================
# Written by Synthesize
# Version 1.0.1
# March 1, 2008
#===============================================================================
# Hunger and Thirst
#===============================================================================

