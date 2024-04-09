using System;
using UnityEngine;

//Just a class that keeps information between scenes
[CreateAssetMenu(fileName ="InformationKeeper", menuName ="Persistence")]
public class InforamtionKeeper : ScriptableObject
{
    // Start is called before the first frame update

    // Join code (If empty then IsHost)
    // empty code when in main menu
    public String JoinCode = "";
}
