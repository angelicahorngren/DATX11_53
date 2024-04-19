using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.SearchService;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class backtogame : MonoBehaviour
{
    [SerializeField] private Button BackToGameButton;
    public GameObject winScreen;
    // Start is called before the first frame update
  public void BackToGameButtonClicked()
    {
        print("Back to game button clicked");
    }
    void Start()
    {
        BackToGameButton.onClick.AddListener(BackToGameButtonClicked);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
