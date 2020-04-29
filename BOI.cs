using System;
using System.Collections.Generic;
using CrowdControl.Common;
using CrowdControl.Games.Packs;
using ConnectorType = CrowdControl.Common.ConnectorType;

public class BOI : SimpleTCPPack
{
    public override string Host => "127.0.0.1";

    public override ushort Port => 58430;

    public BOI(IPlayer player, Func<CrowdControlBlock, bool> responseHandler, Action<object> statusUpdateHandler) : base(player, responseHandler, statusUpdateHandler) { }

    public override Game Game => new Game(42, "The Binding Of Isaac: Afterbirth+ ", "the_binding_of_isaac_afterbirth_plus", "PC", ConnectorType.SimpleTCPConnector);
    
    // When adding new functions to the mod please add the new Crowd Control Effect here
    //This is a display name mapped to a unique string. This is used to map the function from CC to Mod
    public override List<Effect> Effects => new List<Effect>
    {
        new Effect("Add Heart Container", "add_heart_container"),
        new Effect("Remove Heart Container", "remove_heart_container"),
        new Effect("Damage Player", "damage_half_heart"),
        new Effect("Heal Player", "heal_half_heart"),
        new Effect("Give Coin", "add_coin"),
        new Effect("Take Coin", "remove_coin"),
        new Effect("Give Bomb", "add_bomb"),
        new Effect("Take Bomb", "remove_bomb"),
         new Effect("Give Golden Bomb", "add_golden_bomb"),
        new Effect("Take Golden Bomb", "remove_golden_bomb"),
        new Effect("Give Key", "add_key"),
        new Effect("Take Key", "remove_key"),
        new Effect("Give Golden Key", "add_golden_key"),
        new Effect("Take Golden Key", "remove_golden_key"),

        new Effect("Buff Random Stat", "add_stat"),
        new Effect("Nerf Random Stat", "remove_stat"),
        
        new Effect("Teleport Player", "random_tp"),
        new Effect("Give Random Trinket", "replace_trinket"),
        new Effect("Drop Trinket", "drop_trinket"),

        new Effect("Use Random Pill", "use_random_pill"),
        new Effect("Use Random Card", "use_random_card"),

        new Effect("Use D1", "use_d1"),
        new Effect("Use D4", "use_d4"),
        new Effect("Use D6", "use_d6"),
        new Effect("Use D7", "use_d7"),
        new Effect("Use D8", "use_d8"),
        new Effect("Use D10", "use_d10"),
        new Effect("Use D12", "use_d12"),
        new Effect("Use D20", "use_d20"),
        new Effect("Use D Infinity", "use_d_inf"),

        new Effect("Use Guppies Head", "use_guppies_head"),
        new Effect("Use Guppies Paw", "use_guppies_paw"),
        
        new Effect("Use Shovel", "use_shovel"),
        new Effect("Use Dad's Key", "use_dads_key"),
        new Effect("Use Clicker", "use_clicker"),
        new Effect("Use Pause", "use_pause"),
        new Effect("Use Mega Blast", "use_mega_blast"),
        new Effect("Use Forget Me Now", "use_forget_me_now"),

        new Effect("Give Missing No", "give_missing_no"),
        new Effect("Give Soy Milk", "give_soy_milk"),
        new Effect("Give The Mind", "give_the_mind"),
        new Effect("Give Brimstone", "give_brimstone"),
        new Effect("Give Knife", "give_knife"),
        new Effect("Give Polyphemus", "give_poly"),
        new Effect("Give Sacred Heart", "give_sacred_heart"),
        new Effect("Take Missing No", "remove_missing_no"),
        new Effect("Take Soy Milk", "remove_soy_milk"),
        new Effect("Take The Mind", "remove_the_mind"),
        new Effect("Take Brimstone", "remove_brimstone"),
        new Effect("Take Knife", "remove_knife"),
        new Effect("Take Polyphemus", "remove_poly"),
        new Effect("Take Sacred Heart", "remove_sacred_heart"),

        new Effect("Apply A Random Curse", "apply_random_curse"),
    };
}
