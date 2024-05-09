using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using TMPro;

public class DialogueLogic : MonoBehaviour
{
    public TextMeshProUGUI introText;
    public TextMeshProUGUI continuationText;

    public GameObject nextDialoguePanel;

    public GameObject dialogueWindow;
  
    public string[] lines;
    public float textSpeed;
    private int index;

    // Start is called before the first frame update
    void Start()
    {
        introText.text = string.Empty;
        StartDialogue();
    }


    void StartDialogue() {

        index = 0;
        StartCoroutine(TypeLine());

    }

    public void ClickContinue(){

        if (introText.text == lines[index]){
                nextDialoguePanel.SetActive(true);
                NextLine();
            }
            else {
                StopTypingAndPrintLine();
            }
    }

    public void SecondClickContinue(){
        if (continuationText.text == lines[index] && index < lines.Length - 1){
            NextLine();
        }
        else {
            StopTypingAndPrintLine();
        }
        if (index == lines.Length - 1){
            dialogueWindow.SetActive(false);
        }
    }


    public void ClickBack(){
        if (continuationText.text == lines[index] && index <= lines.Length - 1){
            PreviousLine();
        }
        else {
            StopTypingAndPrintLine();
        }
    }

    void StopTypingAndPrintLine(){
        StopAllCoroutines();
        introText.text = lines[index];
        continuationText.text = lines[index];
    }


    IEnumerator TypeLine(){

        foreach(char c in lines[index].ToCharArray()){

            if (index == 0){
                introText.text += c;

            }else {
                continuationText.text += c;
            }
            yield return new WaitForSeconds(textSpeed);
        }
    }

    void NextLine(){

        index++;
        continuationText.text = string.Empty;
        StartCoroutine(TypeLine());
    }
    

    void PreviousLine(){

        index--;
        continuationText.text = lines[index];
    }
}


