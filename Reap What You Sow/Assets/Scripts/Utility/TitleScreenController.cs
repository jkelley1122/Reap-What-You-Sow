using UnityEngine;
using UnityEngine.SceneManagement;

public class TitleScreenController : MonoBehaviour
{
    public GameObject mainMenuPanel;  // Assign MainMenuPanel here
    public GameObject settingsPanel;  // Assign SettingsPanel here

    void Start()
    {
        ShowMainMenu();
    }
    
    public void StartGame()
    {
        SceneManager.LoadScene("FarmScene");
    }


    public void ShowSettings()
    {
        mainMenuPanel.SetActive(false);
        settingsPanel.SetActive(true);
    }

    public void ShowMainMenu()
    {
        settingsPanel.SetActive(false);
        mainMenuPanel.SetActive(true);
    }

    public void ExitGame()
    {
        #if UNITY_EDITOR
            UnityEditor.EditorApplication.isPlaying = false;
        #else
            Application.Quit();
        #endif
    }
}
