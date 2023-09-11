using UnityEngine;
using UnityEngine.SceneManagement;

public class PauseController : MonoBehaviour
{
    [SerializeField] private GameObject pausePanel;
    [SerializeField] private GameObject settingsPanel;
    private bool isPaused = false;

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            if (isPaused)
            {
                Resume();
            }
            else
            {
                Pause();
            }
        }
    }

    public void Resume()
    {
        pausePanel.SetActive(false);
        settingsPanel.SetActive(false);
        Time.timeScale = 1f; // Resumes the game time.
        isPaused = false;
    }

    void Pause()
    {
        ShowPauseMenu();
        Time.timeScale = 0f; // Stops the game time.
        isPaused = true;
    }

    public void ShowSettings()
    {
        pausePanel.SetActive(false);
        settingsPanel.SetActive(true);
    }

    public void ShowPauseMenu()
    {
        settingsPanel.SetActive(false);
        pausePanel.SetActive(true);
    }


    public void LoadMenu()
    {
        Time.timeScale = 1f; // Make sure game time is normal before changing scenes.
        SceneManager.LoadScene("TitleScene");
    }

}
