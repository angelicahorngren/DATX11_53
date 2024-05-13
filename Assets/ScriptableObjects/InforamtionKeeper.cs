using System;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

//Just a class that keeps information between scenes
[CreateAssetMenu(fileName ="InformationKeeper", menuName ="Persistence")]
public class InforamtionKeeper : ScriptableObject
{
    // Start is called before the first frame update

    // Join code (If empty then IsHost)
    // empty code when in main menu
    public String JoinCode = "";
    public Boolean StartLevel = true;
    public Controls controls = new();

    void OnEnable(){
        JoinCode = "";
        StartLevel = true;
    }
    public class Controls 
    {
        public KeyCode Interact = KeyCode.Return;
        public KeyCode PauseGame = KeyCode.Escape;
        public KeyCode MoveUp = KeyCode.UpArrow;
        public KeyCode MoveDown = KeyCode.DownArrow;
        public KeyCode MoveRight = KeyCode.RightArrow;
        public KeyCode MoveLeft = KeyCode.LeftArrow;
    }

}
