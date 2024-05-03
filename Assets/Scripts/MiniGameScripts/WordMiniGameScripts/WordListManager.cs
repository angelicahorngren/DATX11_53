using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using System.Text;
public class WordListManager : MonoBehaviour
{
    private TextMeshProUGUI wordListText;
    public WordSearchGridGenerator wordSearchGridGenerator;
    public GameObject winScreen;
    private int coloredWordCount = 0;

    void Start()
    {
        // Find the TextMeshPro component in children
        wordListText = GetComponentInChildren<TextMeshProUGUI>();

        wordSearchGridGenerator = FindObjectOfType<WordSearchGridGenerator>();

        UpdateWordListText(wordSearchGridGenerator.GetWordList());
        winScreen.SetActive(false);

    }

    private void UpdateWordListText(List<string> wordList)
    {

        // Convert the wordList List<string> to a single string with line breaks
        StringBuilder wordListString = new StringBuilder("ORDLISTA: \n \n");

        foreach (string word in wordList)
        {
            wordListString.Append(word + "\n");
        }

        wordListText.text = wordListString.ToString();
    
    }

    public void MarkWordAsFound(string word, Color color)
    {
            string currentText = wordListText.text;
            string coloredWord = $"<color=#{ColorUtility.ToHtmlStringRGB(color)}>{word}</color>";
            wordListText.text = currentText.Replace(word, coloredWord);
            coloredWordCount++;
            
            if(coloredWordCount >= 4)
            {
                winScreen.SetActive(true);
            }
    }
}