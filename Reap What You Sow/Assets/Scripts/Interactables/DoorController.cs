using UnityEngine;
using UnityEngine.SceneManagement;

public class DoorController : MonoBehaviour
{
    [SerializeField] private string destinationScene; // Name of the scene to which this door leads.

    public void Enter()
    {
        SceneManager.LoadScene(destinationScene);

        //Debug.Log("Entering the door!");
    }
}
