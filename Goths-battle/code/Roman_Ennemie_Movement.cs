using UnityEngine;
 
public class Roman_Ennemie_Movement : MonoBehaviour
{
	public float speed;
	public Animator animator;
	//public Transform[] waypoints; //liste des points à atteindre par l'ennemie
	public int damageOnCollision = 1;//variable qui permet de modifier les dégats infligé par les romains

	public Transform target; //la cible vers la quelle l'ennemie doit se déplacer 
	//private int destPoint; // le point vers lequel doit aller l'ennemie c'est l'index de la list waypoints
	
	
	
	
	// Start is called before the first frame update
	void Start()
	{
	
	}

	// Update is called once per frame
	void Update()
	{
	        Vector3 dir = target.position - transform.position;//création du vecteur 3 dir qui prend la position d la cible moins celle de l'ennemie donne la direction dans laquelle il faut se déplacer 
	        transform.Translate(dir.normalized * speed * Time.deltaTime); //pour déplacer notre ennemie dans la direction normaliser (donc le vecteur est à taille 1 donc aura toujours la même taille
	        
	        //si l'ennemie est quasiment arrivé à sa destination (utile si on veut faire en sorte que l'ennemie se déplace d'un point à un autre) mais nous on veut pas ça on veut juste que l'ennemie se déplace pour atteindre le joueur (cette partie pourra être intéressante pour les pilums)
	        //if(Vector3.Distance(transform.position, target.position) < 0.3f)
	        //{
	        	//destPoint = (destpoint + 1 ) % waypoints.Length; //index de la place des positions dans la variables waypoint (donc 0 égale première destination de la liste( le % est une division qui permet de faire en sorte que notre machin soit de nouveau égale à 0 à la fin
	        	//target = waypoints[destPoints]; //la target devient le point de la liste numéro despoints
	        //}
		
		
	//Ici on va passer aux conditions If pour animer notre poursuivant	
	var X = dir.x;
	var Y = dir.y;    
	if (X<0 && Y>0)
	{
		if (Mathf.Abs(X)>Mathf.Abs(Y))
		{
			animator.SetBool("InpLeft",true);
			animator.SetBool("InpDown",false); 
			animator.SetBool("InpUp",false); 
			animator.SetBool("InpRight",false);
		}else{
			animator.SetBool("InpUp",true); 
			animator.SetBool("InpDown",false); 
			animator.SetBool("InpRight",false); 
			animator.SetBool("InpLeft",false); 
		}
	}
	if (X>0 && Y>0)
	{
		if (Mathf.Abs(X)>Mathf.Abs(Y))
		{
			animator.SetBool("InpRight",true);
			animator.SetBool("InpDown",false); 
			animator.SetBool("InpUp",false);
			animator.SetBool("InpLeft",false); 			
		}else{
			animator.SetBool("InpUp",true);
			animator.SetBool("InpDown",false);
			animator.SetBool("InpRight",false); 
			animator.SetBool("InpLeft",false); 
		}
	}
	if (X>0 && Y<0)
	{
		if (Mathf.Abs(X)>Mathf.Abs(Y))
		{
			animator.SetBool("InpRight",true);
			animator.SetBool("InpDown",false); 
			animator.SetBool("InpUp",false); 
			animator.SetBool("InpLeft",false); 
		}else{
			animator.SetBool("InpDown",true);
			animator.SetBool("InpUp",false); 
			animator.SetBool("InpRight",false); 
			animator.SetBool("InpLeft",false); 
		}	
	}
	if (X<0 && Y<0)
	{
		if (Mathf.Abs(X)>Mathf.Abs(Y))
		{
			animator.SetBool("InpLeft",true);
			animator.SetBool("InpDown",false); 
			animator.SetBool("InpUp",false); 
			animator.SetBool("InpRight",false); 
		}else{
			animator.SetBool("InpDown",true);
			animator.SetBool("InpUp",false); 
			animator.SetBool("InpRight",false); 
			animator.SetBool("InpLeft",false); 
		}	
	}   
	
	}
	    
	private void OnCollisionEnter2D(Collision2D collision)
	{
		if (collision.transform.CompareTag("Player"))//vérifie si le player rentre en collision avec l'ennemie 
		{
			Player_Health playerHealth = collision.transform.GetComponent<Player_Health>();//on récupère le script playerhealth avec une référence temporaire
			playerHealth.TakeDamage(damageOnCollision);
		}
	}
}
