using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//sert à faire le lien entre les vraies points de vies du joueur et la partie graphique à l'écran qui va consister en l'activation et la désactivation des game object de santé
public class HealthBar : MonoBehaviour
{
	public int life;
	public int startlife;
	public GameObject heart1;
	public GameObject heart2;
	public GameObject heart3;
	
	
	public void SetMaxHealth(int health)// méthode que l'on appellera à l'initialisation ou la réinitialisation des points de vie elle doit permettre que graphiquement la barre de point de vie soit mise à jour
	{
		if (health == 0)
		{
			heart1.SetActive(false);
			heart3.SetActive(false);
			heart2.SetActive(false);
		}
		if (health == 1)
		{
			heart1.SetActive(true);
			heart3.SetActive(false);
			heart2.SetActive(false);
		}
		if (health == 2)
		{
			heart2.SetActive(true);
			heart1.SetActive(true);
			heart3.SetActive(false);
		}
		if (health == 3)
		{
			heart3.SetActive(true);
			heart2.SetActive(true);
			heart1.SetActive(true);
		}

	}
	public void SetHealth(int health)
	{
		if (health == 0)
		{
			heart1.SetActive(false);
			heart3.SetActive(false);
			heart2.SetActive(false);
		}
		if (health == 1)
		{
			heart1.SetActive(true);
			heart3.SetActive(false);
			heart2.SetActive(false);
		}
		if (health == 2)
		{
			heart2.SetActive(true);
			heart1.SetActive(true);
			heart3.SetActive(false);
		}
		if (health == 3)
		{
			heart3.SetActive(true);
			heart2.SetActive(true);
			heart1.SetActive(true);
		}

	}
}
