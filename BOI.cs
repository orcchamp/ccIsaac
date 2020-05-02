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

    public override Game Game => new Game(60, "The Binding Of Isaac: Afterbirth+ ", "the_binding_of_isaac_afterbirth_plus", "PC", ConnectorType.SimpleTCPConnector);
    
    // When adding new functions to the mod please add the new Crowd Control Effect here
    //This is a display name mapped to a unique string. This is used to map the function from CC to Mod
    public override List<Effect> Effects => new List<Effect>
    {
        new Effect("Add Heart Container", "add_heart_container"),
        new Effect("Remove Heart Container", "remove_heart_container"),
        new Effect("Damage Player", "damage_half_heart"),
        new Effect("Heal Player", "heal_half_heart"),
        new Effect("Teleport Player", "random_tp"),
        new Effect("Apply A Random Curse", "apply_random_curse", "give_take_item"),
        //Stats folder
        new Effect("Change Stats", "change_stats", ItemKind.Folder),
        new Effect("Buff Random Stat", "add_stat", "change_stats"),
        new Effect("Nerf Random Stat", "remove_stat", "change_stats"),
        //Trinket Folder
        new Effect("Give Take Trinket", "give_take_trinket", ItemKind.Folder),
        new Effect("Give Random Trinket", "replace_trinket", "give_take_trinket"),
        new Effect("Drop Trinket", "drop_trinket", "give_take_trinket"),
        //Give Take Consumeable Folder
        new Effect("Give/Take Consumeable", "give_take_consumeable", ItemKind.Folder),
        new Effect("Give Coin", "add_coin", "give_take_consumeable"),
        new Effect("Take Coin", "remove_coin", "give_take_consumeable"),
        new Effect("Give Bomb", "add_bomb", "give_take_consumeable"),
        new Effect("Take Bomb", "remove_bomb", "give_take_consumeable"),
         new Effect("Give Golden Bomb", "add_golden_bomb", "give_take_consumeable"),
        new Effect("Take Golden Bomb", "remove_golden_bomb", "give_take_consumeable"),
        new Effect("Give Key", "add_key", "give_take_consumeable"),
        new Effect("Take Key", "remove_key", "give_take_consumeable"),
        new Effect("Give Golden Key", "add_golden_key", "give_take_consumeable"),
        new Effect("Take Golden Key", "remove_golden_key", "give_take_consumeable"),

 

        // Use Folder
        new Effect("Use Item", "use_item", ItemKind.Folder),
        //Consumeables
        new Effect("Use Random Pill", "use_random_pill", "use_item"),
        new Effect("Use Random Card", "use_random_card", "use_item"),
        // Dice
        new Effect("Use D1", "use_d1", "use_item"),
        new Effect("Use D4", "use_d4", "use_item"),
        new Effect("Use D6", "use_d6", "use_item"),
        new Effect("Use D7", "use_d7", "use_item"),
        new Effect("Use D8", "use_d8", "use_item"),
        new Effect("Use D10", "use_d10", "use_item"),
        new Effect("Use D12", "use_d12", "use_item"),
        new Effect("Use D20", "use_d20", "use_item"),
        new Effect("Use D Infinity", "use_d_inf", "use_item"),
        //Other Items
        new Effect("Use Guppies Head", "use_guppies_head", "use_item"),
        new Effect("Use Guppies Paw", "use_guppies_paw", "use_item"),
        new Effect("Use Shovel", "use_shovel", "use_item"),
        new Effect("Use Dad's Key", "use_dads_key", "use_item"),
        new Effect("Use Clicker", "use_clicker", "use_item"),
        new Effect("Use Pause", "use_pause", "use_item"),
        new Effect("Use Mega Blast", "use_mega_blast", "use_item"),
        new Effect("Use Forget Me Now", "use_forget_me_now", "use_item"),

        //Give or Take Items folder
        new Effect("Give/take Item", "give_take_item", ItemKind.Folder),
        new Effect("Give Missing No", "give_missing_no", "give_take_item"),
        new Effect("Give Soy Milk", "give_soy_milk", "give_take_item"),
        new Effect("Give The Mind", "give_the_mind", "give_take_item"),
        new Effect("Give Brimstone", "give_brimstone", "give_take_item"),
        new Effect("Give Knife", "give_knife", "give_take_item"),
        new Effect("Give Polyphemus", "give_poly", "give_take_item"),
        new Effect("Give Sacred Heart", "give_sacred_heart", "give_take_item"),
        new Effect("Take Missing No", "remove_missing_no", "give_take_item"),
        new Effect("Take Soy Milk", "remove_soy_milk", "give_take_item"),
        new Effect("Take The Mind", "remove_the_mind", "give_take_item"),
        new Effect("Take Brimstone", "remove_brimstone", "give_take_item"),
        new Effect("Take Knife", "remove_knife", "give_take_item"),
        new Effect("Take Polyphemus", "remove_poly", "give_take_item"),
        new Effect("Take Sacred Heart", "remove_sacred_heart", "give_take_item"),
    };
}
