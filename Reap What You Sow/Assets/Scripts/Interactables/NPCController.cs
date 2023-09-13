using UnityEngine;

public class NPCController : MonoBehaviour
{

    [SerializeField] private GameObject dialoguePanel;

    public void Talk()
    {
        dialoguePanel.SetActive(true);

        //Debug.Log("Talking to NPC!");
    }

}
