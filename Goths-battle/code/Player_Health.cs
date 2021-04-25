using UnityEngine;
using System.Collections;

public class Player_Health : MonoBehaviour
{
	public int maxHealth = 3; // la vie max du joueur
	public int currentHealth; //les points de vies du joueur 
	
	public SpriteRenderer graphics;//permet d'accèder au sprite renderer
	
	public float invincibilityTimeAfterHit = 2f;
	public float invincibilityFlash = 0.1f;
	public bool isInvincible = false; // variable d'invincibilité après avoir pris un coup
	public HealthBar healthBar;
	// Start is called before the first frame update
	void Start()
	{
        	currentHealth = 3;
        	healthBar.SetMaxHealth(currentHealth);
        		
	}

	// Update is called once per frame
	void Update()
	{
		if(Input.GetKeyDown(KeyCode.H)) //pour tester la barre de vie
		{
         	TakeDamage(1);
        }
	}
	
	public void TakeDamage(int damage)//met à jour les points de vies 
	{
		if(!isInvincible) // donc si invincible est sur false on prend des dommages
		{
			currentHealth -= damage; // = currentHealth = currentHealth-damage
			healthBar.SetHealth(currentHealth);
			isInvincible = true;
			StartCoroutine(InvincibilityFlash());
			StartCoroutine(HandleInvincibilityDelay());
		}
	}
	
	public IEnumerator InvincibilityFlash()
	{
		while(isInvincible) //car on veut que ce soit actif tant que le joueur est invincible
		{
			graphics.color = new Color(1f,1f,1f,0f);//les valeurs de 0 à 1 car on va utiliser les valeurs normalisé e la palette
			yield return new WaitForSeconds(invincibilityFlash);
			graphics.color = new Color(1f,1f,1f,1f);
			yield return new WaitForSeconds(invincibilityFlash);
			
		}
	}
	public IEnumerator HandleInvincibilityDelay()
	{
		yield return new WaitForSeconds(invincibilityTimeAfterHit);
		isInvincible = false;
	}
}
