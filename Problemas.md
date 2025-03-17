# Apartat de problemas

Aixo es un apartat en el qual explico els problemas que s'han anat produint en el nostre servidor i en el muntatge, tambe serveix com a resum i guia per documetnar el seguiment de la instalacio i el muntatge del process.

El nostre servidor el tenim montat amb Centos Stream, tindrem els nostres docker compose amb la configuracio necesaria per aixecar un servidor de streaming i Kubernetes ens ajudara a repartir aquesta carrega entre els nostres servidors fisics.

Una vegada instalat el nostre Centos en el servidor podem veure que esta en una xarxa diferent a la de la nostre aula llavors ens hem de conectar el ti4, tambe hem demanat el profesorat que ens obrin un port per poder treballar externament desde casa o qualsevol altre lloc.

Depress d'una investigacio ens hem decantat en fer servir tecnologies com minikube docker ffmpeg nginx hls redis git i altres mes.

El ffmpeg es el nostre converosr de mp4 a hls una extensio per fer streaming en web i el nginx ens dona el servei de web i ens processa tambe el nostre streaming, el redis es la nostre cache que ens ajuda a millorar el rendiment dels nostres videos aixis l'usuari no ha de tornar a fer la solicitud i ens estalviem el treball del servidor per tenir uns millors resultats.
El git el fem servir per pujar la nostre documentacio i tenir un seguiment del muntatge aixis ens assegurem de que si el servei cau amb un git clone podem tornar a tenir tota la informacio que necessitem.

Aqui explicarem una mica la ruta per d'aqui a un futur poder fer una traça de la nostre peticio.
Primer l'usuari demana una peticio el nostre servidor i li presenta la plana web la qual te enllaços de pelicules, quan l'usuari clica un enllaç li obre un reproductor i li dona el video ja processat amb una extensio hls, i com funciona aixo  a la hora de pujar el nostre docker una de les coses que fem es executar un script que ens revisa si tenim un arxiu mp4 a la carpeta que li hem seleccionat i despress processa aixo amb comandes de ffmpeg per passar-los a format hls, una vegada fet aixo els arxius hls es posen en un altre carpeta /stream i d'aqui els agafa l'usuari quan fa clic en el nostre video desde la web.

Tambe en paralel tenim el redis que va funcionant cada vegade que un usuari mira una peli es guarda una cache i si un altre usuari o el mateix fa servir els mateixos paquets doncs els poden agafar desde la cache que sera molt mes rapid que fer la peticio de forma tradicional.

Tot aixo ja ens funciona a la nostre maquina virtual, ara toca passar aquest muntatge en el nostre servidor Centos.

Ja tenim el servei web en funcionament ens falta solucionar uns errors de la reproduccio de video i ja tindriem la plana del servei en funcionament.

# Ideas futuras
Tenim ideas com millorar el procesament de mp4 i poder tenir un entorn mes autoamtitzat ja que ara quan montem el Docker necessitem entrar a dintre la maquina i enviar els videos necesaris quan en realitat podriem nomes copiar desde el principi aixo.
