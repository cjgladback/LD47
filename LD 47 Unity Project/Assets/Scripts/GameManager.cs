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
    private List<GameObject> spawnedCharacters;


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

            //declaring and clearing the voice to hand through to CreateContentView()
            string voice = "";

            //check current tags for chat or sfx tags to alter voice
            List<string> tags = story.currentTags;
            if (tags.Count > 0)
            {
                if (tags.Contains("chat"))
                {
                    voice = "chat";
                }
                else if(tags.Contains("sfx")){
                    voice = "sfx";
                }
                else if (tags.Contains("loud"))
                {
                    voice = "loud";
                }
            }

            // Display the text on screen!
            CreateContentView(text, voice, storyBacker);
        }
        
        //discover the location tags
        var currentLocation = story.variablesState["location"] as Ink.Runtime.InkList;
        if (currentLocation.ContainsItemNamed("office"))
        {
            Debug.Log("We're in the office.");
            background.GetComponent<SpriteRenderer>().sprite = officeSprite;
        } else if (currentLocation.ContainsItemNamed("meeting"))
        {
            Debug.Log("We're in the boardroom.");
            background.GetComponent<SpriteRenderer>().sprite = boardroomSprite;
        } else if (currentLocation.ContainsItemNamed("crimescene"))
        {
            Debug.Log("We're at a crimescene.");
            background.GetComponent<SpriteRenderer>().sprite = boardroomSprite;
        }

        //TO-DO clear previously created characters
        int spawned = standBack.transform.childCount;
        for (int i = spawned - 1; i >= 0; --i)
        {
            GameObject.Destroy(standBack.transform.GetChild(i).gameObject);
        }

        //run forloop through present characters to determine their number and therefore placement?
        var inSight = story.variablesState["present"] as Ink.Runtime.InkList;
        //Debug.Log(inSight.maxItem.Value + " should be the number.");
        //Ink lists start at 1, unlike arrays
        foreach (var item in inSight)
        {
            string name = $"{item.Key}";
            name = name.Replace("present.", "");
            Debug.Log(name);

            GameObject character = Instantiate(characterPrefab);
            character.transform.SetParent(standBack.transform, false);
            
            //spent about 4 hours reading through all sorts of documentation and answers failing to find
            //the right way to use a string to find an object/prefab/what have ye to use
            if (name == "manager")
            {
                character.GetComponent<SpriteRenderer>().sprite = manager;
            } else if (name == "msloop")
            {
                character.GetComponent<SpriteRenderer>().sprite = msloop;
            } else if (name == "dare")
            {
                character.GetComponent<SpriteRenderer>().sprite = dare;
            } else if (name == "brad")
            {
                character.GetComponent<SpriteRenderer>().sprite = brad;
            } else if (name == "whitney")
            {
                character.GetComponent<SpriteRenderer>().sprite = whitney;
            } else if (name == "julie")
            {
                character.GetComponent<SpriteRenderer>().sprite = julie;
            } else if (name == "shawndra")
            {
                character.GetComponent<SpriteRenderer>().sprite = shawndra;
            } else if (name == "stephen")
            {
                character.GetComponent<SpriteRenderer>().sprite = stephen;
            } else if (name == "river")
            {
                character.GetComponent<SpriteRenderer>().sprite = river;
            } else if (name == "security")
            {
                character.GetComponent<SpriteRenderer>().sprite = security;
            } else if (name == "cops")
            {
                character.GetComponent<SpriteRenderer>().sprite = cops;
            }
        }

        // Finding tags has to happen after the story progresses and only looks at the most recent line.
        /*List<string> tags = story.currentTags;
        if (tags.Count > 0)
        {
            if (tags.Contains("chat"))
            {
                Debug.Log("This is a chat message.");
            }
            if (tags.Contains("manager"))
            {
                Debug.Log("The manager is speaking.");
            }
            if (tags.Contains("dare"))
            {
                Debug.Log("Daré is speaking.");
            }
            if (tags.Contains("brad"))
            {
                Debug.Log("Brad is speaking.");
            }
            if (tags.Contains("whitney"))
            {
                Debug.Log("Whitney is speaking.");
            }
            if (tags.Contains("msloop"))
            {
                Debug.Log("Ms. Loop is speaking.");
            }
        }*/

        // If there are tags, search for lighting and location instructions.
        /*if (tags.Count > 0)
        {
            *//*if (tags.Contains("lit"))
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

            }*//*
        }*/

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
    void CreateContentView(string text, string voice, Image backer)
    {
        TextMeshProUGUI x;
        
        if (voice != "")
        {
            if (voice == "chat")
            {
                x = chatPrefab;
            } else if (voice == "sfx"){
                x = sfxPrefab;
            } else
            {
                x = loudPrefab;
            }
        } else {
            x = textPrefab;
        }
        
        // Creates paragraph from the TextMesh prefab and sets parent to the panel prefab instance
        TextMeshProUGUI storyText = Instantiate(x) as TextMeshProUGUI;
        storyText.text = text;
        storyText.transform.SetParent(backer.transform, false);
    }

    // Creates a button showing the choice text
    Button CreateChoiceView(string text, Image backer)
    {
        // Creates the button from a prefab and sets parent to the panel prefab instance
        Button choice = Instantiate(buttonPrefab) as Button;
        choice.transform.SetParent(backer.transform, false);

        // Gets the text from the button prefab
        TextMeshProUGUI choiceText = choice.GetComponentInChildren<TextMeshProUGUI>();
        choiceText.text = text;

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
    private TextMeshProUGUI chatPrefab;
    [SerializeField]
    private TextMeshProUGUI sfxPrefab;
    [SerializeField]
    private TextMeshProUGUI loudPrefab;

    [SerializeField]
    private Button buttonPrefab;
    [SerializeField]
    private Image panelPrefab;

    // Sprites
    [SerializeField]
    private GameObject background;
    [SerializeField]
    private Sprite officeSprite;
    [SerializeField]
    private Sprite boardroomSprite;
    [SerializeField]
    private GameObject characterPrefab;

    // Placement empties
    [SerializeField]
    private GameObject standBack;
    [SerializeField]
    private GameObject speaking;

    // All character sprites
    [SerializeField]
    private Sprite manager;
    [SerializeField]
    private Sprite msloop;
    [SerializeField]
    private Sprite dare;
    [SerializeField]
    private Sprite brad;
    [SerializeField]
    private Sprite whitney;
    [SerializeField]
    private Sprite julie;
    [SerializeField]
    private Sprite shawndra;
    [SerializeField]
    private Sprite stephen;
    [SerializeField]
    private Sprite river;
    [SerializeField]
    private Sprite security;
    [SerializeField]
    private Sprite cops;
}
