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

Els errors de reproduccio de video estan resolts i ara tenim tot el sistema en funcionament, ens hem adonat compte de que el rendiment es molt dolent i el volem optimitzar, pero ara ja hem de passar el seguent pas que es muntar el nostre kubernetes, per fer aixo necesitarem primer tenir en funcionament el nostre master i worker i despress ja muntarem amb docker compose el nostre o nostres servidors de pelicules.
El problema era que a la configuracio del index.html el video que anaba a buscar tenia malament la adreça, llavors el que hem fet es automatitzar aquesta adreça i fer que cada vegade que s'inicia el docker agafi la adreça corresponent.

Ara mateix estem muntant la infraestrectura i necessitem tenir muntat tot el necesari per que la xarxe estigui en funcionament correct, ens estem trobant que quan iniciem el sistema operatiu no funciona 

# Ideas futuras
Tenim ideas com millorar el procesament de mp4 i poder tenir un entorn mes autoamtitzat ja que ara quan montem el Docker necessitem entrar a dintre la maquina i enviar els videos necesaris quan en realitat podriem nomes copiar desde el principi aixo.
Ens hem adonat compte que volem serparar els serveis de stream i els serveis web ja que ara ho tenim tot alla mateix, pero aixo ho farem mentres muntem el nostre kubernetes.

Sembla que tindrem que tornar a muntar tot de nou, ja que ens esta donant molts de problemas la arrancada i el fet de haver fet canvis en el disc del sistema no ens deixa iniciar correctament el nostre servidor

# Notas
Ens hem d'enrecordar d'aprofitar la oportunitat de fer servir el nostre cdn de cloudflare i el domini de github, tambe hem de investigar si les oportunitats i advantatges que ens dona el github students es retanble.
