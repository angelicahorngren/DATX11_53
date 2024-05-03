using System;
using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using Unity.VisualScripting;
using UnityEngine;

public class PlayerItemHandlerScript : MonoBehaviour
{

    enum EnumItems {Empty, MagnifyingGlass, NotePad, Blacklight}
    [SerializeField] private EnumItems ItemInHand;
    // Start is called before the first frame update
    void Start()
    {
        ItemInHand = EnumItems.Empty;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void DropItem(){
        ItemInHand = EnumItems.Empty;
    }

    void PickUpMagnifyingGlass(){
        ItemInHand = EnumItems.MagnifyingGlass;
    }
    void PickUpNotePad(){
        ItemInHand = EnumItems.NotePad;
    }
    void PickUpBlacklight(){
        ItemInHand = EnumItems.Blacklight;
    }

    EnumItems GetItemInHand(){
        return ItemInHand;
    }
}
