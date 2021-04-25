using UnityEngine;

public class WeakSpot : MonoBehaviour
{
	private void OnTriggerEnter2D(Collider2D collision) // engros à chaque qu'un objet rentre dans cette zone cette méthode est lue
	{
		if(collision.transform.CompareTag("Ennemi"))//vérifie si ce qui rentre dans la zone est bien tagué ennemie
		{
			RomanHealth romanHealth = collision.transform.GetComponent<RomanHealth>(); //on récupère le script playerhealth avec une référence temporaire
			romanHealth.DamageEnemi(1);
		}
	}
	
}
