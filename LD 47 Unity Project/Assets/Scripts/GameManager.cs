using UnityEngine;
using UnityEngine.UI;
using System;
using System.Collections.Generic;
using TMPro;
//using DG.Tweening;
using Ink.Runtime;

public class GameManager : MonoBehaviour
{
    //public static GameManager ins;
    //public Node startingNode;

    public static event Action<Story> OnCreateStory;


    void Start()
    {
        // Load the next story block
        story = new Story(inkJSONAsset.text);
        if (OnCreateStory != null) OnCreateStory(story);

        // Start the refresh cycle
        RefreshView();

    }

    // This is the main function called every time the story changes. It does a few things:
    // Destroys all the old content and choices.
    // Continues over all the lines of text, then displays all the choices. If there are no choices, the story is finished!
    void RefreshView()
    {
        // Remove all the UI on screen
        RemoveChildren();

        Image storyBacker = Instantiate(panelPrefab) as Image;
        storyBacker.transform.SetParent(canvas.transform, false);

        // Read all the content until we can't continue any more
        while (story.canContinue)
        {
            // Continue gets the next line of the story
            string text = story.Continue();
            // This removes any white space from the text.
            text = text.Trim();
            // Display the text on screen!
            CreateContentView(text, storyBacker);
        }

        // Get the current tags (if any)
        List<string> tags = story.currentTags;

        // If there are tags, search for lighting and location instructions.
        if (tags.Count > 0)
        {
            /*if (tags.Contains("lit"))
            {

                brightness = lt.intensity;

                inLights = GameObject.FindGameObjectsWithTag("InnerLight");
                if (tags.Contains("normal"))
                {
                    brightness = normalLight;
                }
                if (tags.Contains("dark"))
                {
                    brightness = lowLight;
                }
                if (tags.Contains("bright"))
                {
                    brightness = highLight;
                }


                foreach (GameObject inLight in inLights)
                {
                    lt = inLight.GetComponent<Light>();

                    //DOTween sequence to slow light change
                    lt.DOIntensity(brightness, .75f);
                    //lt.intensity = DOTween.brightness;
                }

            }*/
        }

        // Display all the choices, if there are any!
        if (story.currentChoices.Count > 0)
        {
            for (int i = 0; i < story.currentChoices.Count; i++)
            {
                Choice choice = story.currentChoices[i];
                Button button = CreateChoiceView(choice.text.Trim(), storyBacker);
                // Tell the button what to do when we press it
                button.onClick.AddListener(delegate {
                    OnClickChoiceButton(choice);
                });
            }
        }
        // If we've read all the content and there's no choices, the story is finished!
        else
        {
            Button choice = CreateChoiceView("End of story.\nRestart?", storyBacker);
            choice.onClick.AddListener(delegate {
                Start();
            });
        }
    }

    // When we click the choice button, tell the story to choose that choice!
    void OnClickChoiceButton(Choice choice)
    {
        story.ChooseChoiceIndex(choice.index);
        RefreshView();
    }

    // Creates a textbox showing the line of text
    void CreateContentView(string text, Image backer)
    {
        /*Image storyBacker = Instantiate(panelPrefab) as Image;
        storyBacker.transform.SetParent(canvas.transform, false);*/
        TextMeshProUGUI storyText = Instantiate(textPrefab) as TextMeshProUGUI;
        storyText.text = text;
        storyText.transform.SetParent(backer.transform, false);
    }

    // Creates a button showing the choice text
    Button CreateChoiceView(string text, Image backer)
    {
        // Creates the button from a prefab
        Button choice = Instantiate(buttonPrefab) as Button;
        choice.transform.SetParent(backer.transform, false);

        // Gets the text from the button prefab
        TextMeshProUGUI choiceText = choice.GetComponentInChildren<TextMeshProUGUI>();
        choiceText.text = text;

        // Make the button expand to fit the text
        /*HorizontalLayoutGroup layoutGroup = choice.GetComponent<HorizontalLayoutGroup>();
        layoutGroup.childForceExpandHeight = false;*/

        return choice;
    }

    // Destroys all the children of this gameobject (all the UI)
    void RemoveChildren()
    {
        int childCount = canvas.transform.childCount;
        for (int i = childCount - 1; i >= 0; --i)
        {
            GameObject.Destroy(canvas.transform.GetChild(i).gameObject);
        }
    }

    [SerializeField]
    private TextAsset inkJSONAsset;
    public Story story;

    [SerializeField]
    private Canvas canvas;

    // UI Prefabs
    [SerializeField]
    private TextMeshProUGUI textPrefab;
    [SerializeField]
    private Button buttonPrefab;
    [SerializeField]
    private Image panelPrefab;
}
