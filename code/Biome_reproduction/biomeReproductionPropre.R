#tentative biome

#le haut correspondra � un climat tropical et le bas polaire
#variable taille matrix
weight <- 8#doit �tre un multiple du nombre de cell atmosp�rique (boucle) +1
var<-30#valeur autour de laquelle va varier les statistique de mes individus 
#nombre d'it�rations/g�n�rations
temps<-200
nSp<-40 #nombre d'esp�ces/ de grandes familles d'individus
#on cr�e une matrix qui va servir de map
Matrixmap <- matrix(0,weight,weight)
#d'abord on tente de cr�er notre matrice ensoleillement
MatrixS <- matrix(0,weight,weight)
MatrixS
#l'ensoleillement = on va juste �tal� les valeurs de 1 � 100 sur toute la longueur de la matrix
c<-seq(100,1,length.out=weight) #petit vecteur ce qu'il y a de plus simple remplie de 100x (100/100)
for(i in 1:weight){#on remplit la matrix de 100 � 1
  MatrixS[i,]<- c[i]
}
MatrixS

#Maintenant on fait la matrix de pluviom�trie
MatrixP <- matrix(0,weight,weight)
#on d�finie le nombre de boucle atmosphérique 
boucle<-3 # attention dans cette méthode il faut que boucle+1 soit un multiple de 100
zonep<-weight/(boucle+1)#correspond au nombre de ligne et de colonne que fait une zone de pluvio
c<-0
c1<-1
l<-0
l1<-1
t<-81:100#vecteur correspondant � la pluvio possible en tropical
p<-1:10#correspond � la pluvio possible en polaire
d<-1:30#corrspond � la pluvio possible en désert
te<-31:80#correspond � la pluvio possible en milieu tmpéré
Pluvio <- list(t,d,te,p)#liste avec mes dif catégories de pluvio

#on d�fini Pluvio ne marche que pour une boucle de 3 cellule
for(i in 1:(weight/zonep)){#premi�re boucle sur les lignes
  c<-zonep+c #donne c+25 � chaque itération de la boucle 
  for(j in 1:(weight/zonep)){#deuxième boucle pour les colonnes 
    l<-zonep+l
    pluvio<-sample(Pluvio[[i]],1)#on prend un nombre al�atoire entre les borne d�finie plus tot de pluviosit� possible
    MatrixP[c1:c,l1:l]<- matrix(pluvio,zonep,zonep)#c,c1 et l,l1 me servent � borner la zone dans laquel je vais mettre les valeurs de pluvio
    l1<-zonep+l1
  }
  l<-0
  l1<-1
  c1<-zonep+c1
}
MatrixP


#on cr�e ici la matrice de capacit� maximal d'occupation des biomes par mes individus 
maxPlace<-matrix(0,weight,weight)
for(i in 1:weight){
  for(j in 1:weight){
    maxPlace[i,j]<-round(((MatrixP[i,j]+MatrixS[i,j])^(1/7))*5,0)
  }
}
maxPlace


#on fait les individus maintenant
#donc chaques individues est un vecteur et tous ces vecteurs sont contenus dans des listes contenues elles m�me dans une autre liste qui regroupe tous les ind.
#individu type = sp(x,y,f�condit�,migration,pr�dation,contre_predation,photosynth�se,besoin en eau,dur�e de vie,xlist,ylist,count,long) count donne une indication sur le moment de la naissance donc la g�n�ration de l'individu

#cr�e une palette de couleur
rain<-rainbow(nSp)
#les listes r�unissant mes genres (indiv 1 et descendant)
Families <- list()
gr<-NULL

#et voici mes individus de d�part
for(a in 1:nSp){#bon en gros cette boucle me g�n�re mes 5 esp�ces dans la liste famille avec n*Sp liste avec un certain nombre de vecteur ind 
  Families[[a]]<-list()#list des genres
  for(b in 1){
    longev<-sample(50:90,1)#j'ai fais cette varaible ici �a la rend plus simple � touver 
    Families[[a]][[1]] <- c(sample(weight,1),sample(weight,1),0,sample(30,1),sample(30,1),sample(30:-30,1),sample(30,1),sample(100:70,1),longev,a,1,0,longev)
    #liste avec les ind
    #assign(paste("SP", letters[a], sep=""),c(sample(weight,1),sample(weight,1),sample(30,1),sample(30,1),sample(30,1),sample(30,1),sample(30,1),sample(30,1)))
  }
}
Families
count_sp1<-matrix(0,weight,weight)#pour la premi�re it�ration de la boucle z histoire que f�conde est quelque chose � ce mettre sous la dent

z<-0
pres<-matrix(0,temps,nSp)
map<-list()


#on tente la boucle for qui va permettre de calculer l'�volution des stat pour chaque individues
for(z in 1:temps){#cette boucle correspond au nombre de fois que je veux que le process ce r�p�te donc va faire varier le nombre de fois que mes ind peuvent se multiplier et le temps de vie
  maxg<-NULL#vecteur stockant les valeurs = au nombre d'sp pour chaque genre
  for(w in 1:length(Families)){#boucle calculant les valeurs pour maxg
    maxg[w]<-length(Families[[w]])
  }
  posx<-matrix(0,nSp,max(maxg))#vecteur qui me permettra de compiler les position x,y de chaque individus
  posy<-matrix(0,nSp,max(maxg))
  for(y in 1:length(Families)){
    nombresp_in_genre<-length(Families[[y]])#me donne le nombre d'in a une liste y de la liste famille
    for(x in 1:nombresp_in_genre){#et on stocke nos valeurs de xy de chacune de nos espèce dans les matrix posx et posy
      posx[y,x]<- Families[[y]][[x]][[1]]#on récupère la 1ère val de l'ind x de la liste y de la liste famille
      posy[y,x]<- Families[[y]][[x]][[2]]
    }
  }
  #on calcul combien il y a d'sp en tout non ça va me dire combien il peut y en avoir potentiellement mais c'est tout faudrait faire un length de chaque ligne puis les sum
  nSp1 <- (length(posx[1,])*length(posx[,1]))
  for(b in 1:weight){#cette double boucle correspond au coordonné x,y de la matrixmap
    for(c in 1:weight){#une double boucle for pour voyager dans la Matrixmap on vérifie s'il y a des individues sur chaque case et combien il y en a, si il y en a on fait le test de ces valeurs (on fait ça au lieu de juste les tester au cas par cas pour les stats d'intération entre ind)
      #premièrement je vais devoir compter combien d'individu il y a sur ces coordonnées 
      #on part du principe que ces valeur sont mises dans la Matrixmap
      #test de la présence sur une case
      #il me faut une double boucle for pour tester tout ça dans pos x et dans posy yeah xD
      count<-0
      pre_sp<-list()
      #cette double boucle sert à voyager dans mes matrix de position pour en extraire une position et vérifier si elle correspond à l'endroit où l'on est 
      for(u in 1:length(posx[1,])){#nombre de colonne
        for(v in 1:length(posx[,1])){#nombre de ligen dans posx
          if(b==posx[v,u]&c==posy[v,u]){#doit permettre de vérifier si il y a du monde à notre position et combien ils sont 
            if(Families[[v]][[u]][[9]]>0){
              count<-count+1
              pre_sp[[count]] <- Families[[v]][[u]]# je vais ensuite lancé mes test sur les ind de cette liste
            }
          }  
        }
      }
      if(length(pre_sp)>=1){ #comme �a on lance les test de stat que si il y a du people
        #donc d'abord on test la pr�dation sur la case
        if(length(pre_sp)>1){ #Boucle Prédation
          #ouais on lance le test prédation que si il y a plusieurs individues sur la case sinon c'est inutile
          #on d�finit la cible de la prédation pour �a je vais choisir un individue al�atoir dans ma liste d'esp�ce pr�sente sauf celle qui effectue la prédation
          #tout le monde fait son test de prédation ce qui peut engendrer des animaux qui s'entretue
          pred<-NULL#on d�finit les variables utiles pour es boucles for 
          def<-NULL
          pred_ind<-NULL
          ind_predate<-NULL
          for(f in 1:length(pre_sp)){#on fait autant d'itération qu'il y a de monde sur la case
            #cette boucle permet de tirer les valeurs � comparer avec la stat prédation et anti_prédation de chque ind présent sur la case
            #il me faudrait un meilleur syst�me pour d�finir si la pr�dation fonctionne ou pas 
            pred[f]<-sample(200,1)
            def[f]<-sample(500,1)
            ind_predate<-pre_sp[[sample(length(pre_sp),1)]]
            #if(pre_sp[[f]][[5]]>=pred[f]){#si la valeur de pred est inférieur a la valeur de prédation de l'individu alors on définis comme prédateur et on définis sa cible
            pred_ind<-pre_sp[[f]]
            ind_predate<-pre_sp[[sample(length(pre_sp),1)]]
            #if(ind_predate[6]<=def[f]){#si la valeur défense de l'individu prédater est supérieur a sa stat anti pred alors celui ci subit les effet de la prédation et le prédateur gagne un bonus sur sa fécondité
            if(abs(pred_ind[5]/ind_predate[6])>1){  
              Families[[pred_ind[10]]][[pred_ind[11]]][[3]]<-(Families[[pred_ind[10]]][[pred_ind[11]]][[3]])+150
              Families[[ind_predate[10]]][[ind_predate[11]]][[9]]<-0
              #}    
            }
          }
        }
        #boucle test dépendant des matrix S et P
        for(d in 1:length(pre_sp)){#donc dans cette boucle je dois juste sélectionner les ind présent et leur ajouter un bonus de féc en fct des matrix s et P et de leur stat associé
          #donc le but de cette boucle est d'inférer un bonus de fécondité en fonction de la valeur d'ensoleillement et du niveau de la stat photosynthèse
          Families[[pre_sp[[d]][[10]]]][[pre_sp[[d]][[11]]]][[3]]<-Families[[pre_sp[[d]][[10]]]][[pre_sp[[d]][[11]]]][[3]]+(0.003*MatrixS[b,c]+0.35)*(Families[[pre_sp[[d]][[10]]]][[pre_sp[[d]][[11]]]][[7]])+(MatrixS[b,c]*0.1)
          #fonction pour besoin en eau plus y a d'eau et moins les besoins en eau sont important plus le bonus est fort
          Families[[pre_sp[[d]][[10]]]][[pre_sp[[d]][[11]]]][[3]]<-Families[[pre_sp[[d]][[10]]]][[pre_sp[[d]][[11]]]][[3]]+((((0.003)*MatrixP[b,c]-0.55))*Families[[pre_sp[[d]][[10]]]][[pre_sp[[d]][[11]]]][[8]]+60)
          #donc fécondation peut dans le max est égale à 50
        }
      }
    }
  }
  #maintenant on test la mise à bas puis la migration pour cest test plus besoins d'être sur la Matrixmap
  #donc pour la mise à bas il faut que la valeur aléatoire entre 1 et 50 soit inf à la valeur de fécondité arrondie
  #si c'est le cas alors dans Families dans la même liste que l'ind parent on crée un nouvel individu à la place length(families[[x]])+1 avec les mêmes position x,y que le parents
  fecond<-list()
  for(a in 1:length(Families)){
    fecond[[a]]<-list()
    for(b in 1:length(Families[[a]])){
      fec_test<-sample(300,1)
      if(fec_test<=Families[[a]][[b]][[3]] & Families[[a]][[b]][[9]]>0 & count_sp1[Families[[a]][[b]][[1]],Families[[a]][[b]][[2]]]<maxPlace[Families[[a]][[b]][[1]],Families[[a]][[b]][[2]]]){#le différent de 0 c'est pour éviter que les morts se reproduisent
        longevite<-sample((Families[[a]][[b]][[13]]-var):(Families[[a]][[b]][[13]]+var),1)
        Families[[a]][[length(Families[[a]])+1]]<-c(Families[[a]][[b]][[1]],Families[[a]][[b]][[2]],0,sample((Families[[a]][[b]][[4]]-var):(Families[[a]][[b]][[4]]+var),1),sample((Families[[a]][[b]][[5]]-var):(Families[[a]][[b]][[5]]+var),1),sample((Families[[a]][[b]][[6]]-var):(Families[[a]][[b]][[6]]+var),1),sample((Families[[a]][[b]][[7]]-var):(Families[[a]][[b]][[7]]+var),1),sample((Families[[a]][[b]][[8]]-var):(Families[[a]][[b]][[8]]+var),1),longevite,a,length(Families[[a]])+1,z,longevite)
      }
      if(Families[[a]][[b]][[3]]>0){ #on rentre la valeur de f�condit� dans une liste
        fecond[[a]][[b]]<-Families[[a]][[b]][[3]]
      }
      Families[[a]][[b]][[3]]<-0
      if(Families[[a]][[b]][[9]]>0){#on fait perdre un an de vie � chaque ind
        Families[[a]][[b]][[9]]<-(Families[[a]][[b]][[9]])-1 
      }
      #et maintenant test de la migration 
      #donc ce test consiste à si ta valeur de migration plus haute ou égale à la valeur test alors le machin se déplace aléatoirement d'une case autour de lui
      #donc sa valeur 1 et 2 prennent -1,0 ou 1 la valeur final ne pouvant pas être inférieur à 1 ou supérieur à 100
      mig_test<-sample(700,1)
      if(mig_test<=Families[[a]][[b]][[4]]){
        if(Families[[a]][[b]][[1]]<weight&Families[[a]][[b]][[1]]>1){
          Families[[a]][[b]][[1]]<-sample((Families[[a]][[b]][[1]]-1):(Families[[a]][[b]][[1]]+1),1)
        }
        else if(Families[[a]][[b]][[1]]==weight){
          Families[[a]][[b]][[1]]<-sample(c((Families[[a]][[b]][[1]]-1),(Families[[a]][[b]][[1]]-1),(Families[[a]][[b]][[1]])),1)
        }
        else if(Families[[a]][[b]][[1]]==1){
          Families[[a]][[b]][[1]]<-sample(c((Families[[a]][[b]][[1]]),(Families[[a]][[b]][[1]]+1),(Families[[a]][[b]][[1]]+1)),1)#on fait un vecteur avec deuc m�me chiffre pour toujours avoir 2/3 chance de bouger
        }
        if(Families[[a]][[b]][[2]]<weight&Families[[a]][[b]][[2]]>1){
          Families[[a]][[b]][[2]]<-sample((Families[[a]][[b]][[2]]-1):(Families[[a]][[b]][[2]]+1),1)
        }
        else if(Families[[a]][[b]][[2]]==weight){
          Families[[a]][[b]][[2]]<-sample(c((Families[[a]][[b]][[2]]-1),(Families[[a]][[b]][[2]]-1),(Families[[a]][[b]][[2]])),1)
        }
        else if(Families[[a]][[b]][[2]]==1){
          Families[[a]][[b]][[2]]<-sample(c((Families[[a]][[b]][[2]]),(Families[[a]][[b]][[2]]+1),(Families[[a]][[b]][[2]]+1)),1)
        }
      }
    }
  }
  pox<-NULL
  poy<-NULL
  Fa<-NULL
  c<-0
  longr<-NULL
  Gen<-NULL
  # on veut avoir le nombre d'ind vivant par famille à chaque nouvelle itération
  #j'imagine que la longueur de la liste famille sans les ind avec une F[[i]][[j]][[9]]<0
  for(j in 1:length(Families)){#cete boucle doit permettre un plot toutes les itérations d'ou sont chaque ind
    for(i in 1:length(Families[[j]])){
      c<-c+1
      pox[c]<-Families[[j]][[i]][[1]]
      poy[c]<-Families[[j]][[i]][[2]]
      Fa[c]<-Families[[j]][[i]][[10]]
      longr[c]<-Families[[j]][[i]][[9]]
      Gen[c]<-Families[[j]][[i]][[12]]
    }
  }
  #plot(poy[longr>0],pox[longr>0],col=rain[as.numeric(Fa[longr>0])],main = as.character(z))
  #if(z==temps){      #�a c'est pour �viter de faire le calcul � chaque it�ration et juste � la fin mais l� on va en avoir besoin 
  #on va essayer de faire une carte de densité le but �tant = plus on a d'ind � un endroit plus on a un gros cercle 
  count_sp<-list()
  count_sp1<-matrix(0,weight,weight)#destin� � �tre la map avec le nombre d'individu par position xy
  map_count<-0
  for(x in 1:weight){
    count_sp[[x]]<-list()
    for(y in 1:weight){
      for(u in 1:length(posx[1,])){#nombre de colonne dans posx
        for(v in 1:length(posx[,1])){#nombre de ligne dans posx
          if(x==posx[v,u]&y==posy[v,u]){#doit permettre de vérifier si il y a du monde à notre position et combien ils sont 
            if(Families[[v]][[u]][[9]]>0){#si l'individu n'est pas mort alors il est conpt�
              map_count<-map_count+1
            }
          }
          count_sp[[x]][y]<-map_count #sous forme de liste
          count_sp1[x,y]<-map_count # sous forme de matrix
        }
      }
      map_count<-0# on remet le compte � zero
    }
  }
  #}
  FamiliesL<-NULL
  for(i in 1:length(Families)){
    FamiliesL[i]<-length(Gen[Fa==i&longr>0])
  }
  pres[z,]<-FamiliesL
  pie(FamiliesL,col=rainbow(nSp),main = as.character(z))
  map[[z]]<-count_sp1#comme �a je peux voir tous les comptages
}


#Partie permettant de visualiser les r�sultats de la boucle juste au-dessus 
x11()#permet d'ouvrir une autre fen�tre graphique ce qui nous permettra de comparer les prochains graphe au graphique de la tarte final
MatrixP
MatrixS
maxPlace
count_sp1
pres


Gencount<-NULL
for(i in 1:z){
  Gencount[i]<-sum(Gen==i)
}
Gencount #les phases de fort taux de reproductions correspondent � celle d'expansions et celle de faible taux de reproduction a des milieux satur�es 
plot(1:z,Gencount,type="l")

#les plots 
maxPlace
count_sp1#donne le nombre d'sp � chaque x,y 
map[[70]]
pres#donne le nombre d'sp dans chaque famille � chaque gen
plot(poy[longr>0],pox[longr>0],col=rain[as.numeric(Fa[longr>0])])
#pour le pie faire en sorte que l'on est autant de ct�gorie que de part de tarte
FamiliesL<-NULL
for(i in 1:length(Families)){
  FamiliesL[i]<-length(Gen[Fa==i&longr>0])
}
as.numeric(levels(as.factor(Fa)))

plot(1:z,Gencount,type="l")
#moyenne glissante
genCountMean<-NULL
gen7<-NULL
J<-7
L<-0
c<-0
for(i in 1:length(Gencount)){#on fait une moyenne glissante sur 7 g�n�rations
  L<-L+1
  gen7[L]<-Gencount[i]
  if(L==J){
    c<-c+1
    genCountMean[c]<-mean(gen7)
    L<-0
    gen7<-NULL
  }
}
genCountMean
length(Gencount)
blop <- seq(1,length(Gencount),length.out = length(genCountMean))
length(blop)==length(genCountMean)
points(blop,genCountMean,col = "red", type = "l")
X11()
map[[10]]
map[[20]]#<-
map[[30]]
map[[40]]#<--taux deviens constant on augmente dans la courbe de population
map[[50]]
map[[60]]
map[[70]]#<--baisse du tau de descendance on viens de saturer les milieux 
map[[80]]#<-- # on arrivait peut �tre aussi � un moment ou il y a bcp de vieux et peu de jeune 
map[[90]]
map[[100]]
map[[110]]
map[[120]]
map[[130]]
map[[140]]
map[[150]]
map[[160]]
map[[170]]#<-- augmentation du taux de descendance on sort d'une p�riode avec un peu moins d'individus 
map[[180]]
map[[190]]
map[[200]]

pox<-NULL
poy<-NULL
Fa<-NULL
Gen<-NULL
c<-0
long<-NULL
pred<-NULL
antiprec<-NULL
photo<-NULL
Bes_O<-NULL
mig<-NULL
longr<-NULL
for(j in 1:length(Families)){
  for(i in 1:length(Families[[j]])){
    c<-c+1
    pox[c]<-Families[[j]][[i]][[1]]
    poy[c]<-Families[[j]][[i]][[2]]
    Fa[c]<-Families[[j]][[i]][[10]]
    long[c]<-Families[[j]][[i]][[13]]
    Gen[c]<-Families[[j]][[i]][[12]]
    pred[c]<-Families[[j]][[i]][[5]]
    antiprec[c]<-Families[[j]][[i]][[6]]
    photo[c]<-Families[[j]][[i]][[7]]
    mig[c]<-Families[[j]][[i]][[4]]
    Bes_O[c]<-Families[[j]][[i]][[8]]
    longr[c]<-Families[[j]][[i]][[9]]
  }
}
#plot des moyennes
pred_mean<-matrix(0,length(Families),max(Gen)+1)
antipred_mean<-matrix(0,length(Families),max(Gen)+1)
photo_mean<-matrix(0,length(Families),max(Gen)+1)
Bes_O_mean<-matrix(0,length(Families),max(Gen)+1)
mig_mean<-matrix(0,length(Families),max(Gen)+1)
long_mean<-matrix(0,length(Families),max(Gen)+1)
for(j in 1:length(Families)){
  for(i in 0:max(Gen)){
    pred_mean[j,i+1]<-mean(pred[Gen==i&Fa==j])
    mig_mean[j,i+1]<-mean(mig[Gen==i&Fa==j])
    antipred_mean[j,i+1]<-mean(antiprec[Gen==i&Fa==j])
    photo_mean[j,i+1]<-mean(photo[Gen==i&Fa==j])
    Bes_O_mean[j,i+1]<-mean(Bes_O[Gen==i&Fa==j])
    long_mean[j,i+1]<-mean(long[Gen==i&Fa==j])
  }
}
plot(1:length(pres[,1]),log(pres[,1]),col=rain[1],type="l",ylim = c(0,10))
for(i in 1:length(pres[1,])){
  points(1:length(pres[,1]),log(pres[,i]),col=rain[i],type="l")
}
plot(1:length(pres[,1]),pres[,1],col=rain[1],type="l",ylim = c(0,900),xlab = "Nombre de g�n�rations", ylab = "Nombre d'individu")
for(i in 1:length(pres[1,])){
  points(1:length(pres[,1]),pres[,i],col=rain[i],type="l")
}
legend("topleft", pch = 21, cex = 0.5, col = rainbow(length(pres[1,])), pt.bg = rainbow(length(pres[1,])), legend=c(1:nSp))

plot(1:(max(Gen)+1),long_mean[1,],col=rain[1],type="o",ylim = c(-50,300))
for(i in 1:length(long_mean[,1])){
  points(1:(max(Gen)+1),long_mean[i,],col=rain[i],type="o")
}
plot(1:(max(Gen)+1),pred_mean[1,],col=rain[1],type="o",ylim = c(-500,500), xlab = "Nombre de g�n�rations", ylab = "valeur de pr�dation")
for(i in 1:length(pred_mean[,1])){
  points(1:(max(Gen)+1),pred_mean[i,],col=rain[i],type="o")
}
plot(1:(max(Gen)+1),antipred_mean[1,],col=rain[1],type="b",ylim = c(-600,500),xlab = "Nombre de g�n�rations", ylab = "valeur d'antipr�dation")
for(i in 1:length(antipred_mean[,1])){
  points(1:(max(Gen)+1),antipred_mean[i,],col=rain[i],type="b")
}
plot(1:(max(Gen)+1),photo_mean[1,],col=rain[1],type="b",ylim = c(-50,350),xlab = "Nombre de g�n�rations", ylab = "valeur de photosynth�se")
for(i in 1:length(photo_mean[,1])){
  points(1:(max(Gen)+1),photo_mean[i,],col=rain[i],type="b")
}
plot(1:(max(Gen)+1),Bes_O_mean[1,],col=rain[1],type="b",ylim = c(-150,250),xlab = "Nombre de g�n�rations", ylab = "valeur de Besoin en eau")
for(i in 1:length(Bes_O_mean[,1])){
  points(1:(max(Gen)+1),Bes_O_mean[i,],col=rain[i],type="b")
}
plot(1:(max(Gen)+1),mig_mean[1,],col=rain[1],type="b",ylim = c(-100,200),xlab = "Nombre de g�n�rations", ylab = "valeur de migration")
for(i in 1:length(mig_mean[,1])){
  points(1:(max(Gen)+1),mig_mean[i,],col=rain[i],type="b")
}
#pour que la pred soit vraimeent rentable il faut des valeurs super �lev� d�s le d�but (entre 200 et 300 si l'ont se fit � l'esp�ce 11 d'une ancienne run avec des valeurs de photosynth�se tr�s basse)

#ça serait sympa des stat qui dépendent de la taille de la population
#et faire une stat qui donne des bonus si faible luminosité et basse pluvio en gros qu'il soit sur un pied d'égalité avec les zone de hautes pluv et lum
#il faudrait aussi que la valeur de def soit dépendante du degrée de réussite au test de pred 

plot(pred,antiprec,col=c(1:nSp)[as.factor(Fa)])
plot(pred[longr>0],antiprec[longr>0],col=as.numeric(levels(as.factor(Fa[longr>0])))[as.factor(Fa[longr>0])])
pie(FamiliesL,col=rainbow(nSp))
f<-35
hist(pred[Fa==f&Gen==z-1])
abline(v=mean(pred[Fa==f&Gen==z]),b=1,col="red" )
abline(v=median(pred[Fa==f&Gen==z]),b=1,col="blue" )
hist(antiprec[Fa==f&Gen==z-1],breaks = 10)
abline(v=mean(antiprec[Fa==f&Gen==z]),b=1,col="red" )
abline(v=median(antiprec[Fa==f&Gen==z]),b=1,col="blue" )
hist(photo[Fa==f&Gen==z-1],breaks = 10)
hist(Bes_O[Fa==f&Gen==z-1],breaks = 10)
hist(mig[Fa==f&Gen==z-1],breaks = 10)



hist(pred)
abline(v=mean(pred),b=1,col="red" )
abline(v=median(pred),b=1,col="blue" )
hist(mig)
abline(v=mean(mig),b=1,col="red" )
abline(v=median(mig),b=1,col="blue" )
hist(photo)
abline(v=mean(photo),b=1,col="red" )
abline(v=median(photo),b=1,col="blue" )
hist(Bes_O)
abline(v=mean(Bes_O),b=1,col="red" )
abline(v=median(Bes_O),b=1,col="blue" )
hist(antiprec)
abline(v=mean(antiprec),b=1,col="red" )
abline(v=median(antiprec),b=1,col="blue" )

