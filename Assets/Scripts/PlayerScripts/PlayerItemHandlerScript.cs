using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using UnityEngine;

public class PlayerItemHandlerScript : MonoBehaviour
{

    private enum EnumItems {Empty, MagnifyingGlass, NotePad, Blacklight}
    [SerializeField] EnumItems ItemInHand;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
