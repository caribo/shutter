��    S      �  q   L             	        )  .   ,  5   [  #   �  &   �  #   �        �      �   �  ,   S	     �	     �	     �	     �	     �	     �	     �	     �	     �	     �	  �   
  #   �
  1   �
     �
           	           1     O  
   U  &   `  4   �     �     �  	   �     �     �            [   %     �     �  -   �     �  H   �  ,        <     \     e     r     �     �  *   �  (   �       	   "     ,  
   2     =     N  	   T  
   ^     i     v     �  P   �  %   �  A   �  t  A  *   �  T   �  (   6     _     d  2   q  M   �  	   �     �       �     �  �     �     �     �  *   �  .   �  +     /   :  .   j  #   �  �   �  �   `  +   �          !     $     2     G     [     ^     e     {     �  �   �  %   <  /   b     �     �     �  '   �  ,   �     �       +     6   C  
   z     �     �     �     �     �     �  l   �     T     ]  @   c     �  ^   �  5         I     j     s  *   �     �     �  &   �  #   
     .  
   M     X     _     o  
   �     �     �     �     �     �  \   �  !   3  =   U  r  �  +     _   2  +   �     �     �  ?   �  F         ]   '   f      �   �   �             
          '       G       #                           !                 Q                 <      *   (   ?                  J       6                        7          =      R   &   H          K   1   .      +      5           :   ,   N       3           $   A   P       M   8   >      C          9   4   ;      F   -   	   B       S       )      D      %   E       I      /          0   2   L   @   O   "       3D reflection 3D rotate A: Add a custom text watermark to your screenshot Add a shadow to the image on a transparent background Add a torn-like border to the image Add an inverted 3d border to the image Add sepia color toning to the image Add soft edges around the image Adds a fading reflection below an image and views it in perspective

Based on a script by Fred Weinhaus

http://www.fmwconcepts.com/imagemagick/3Dreflection/index.php Applies a perspective distortion to an image

Based on a script by Fred Weinhaus

http://www.fmwconcepts.com/imagemagick/3Drotate/index.php Apply a distortion effect to your screenshot Auto: B: Background color Barrel Distortion Bordereffects C: Channel Choose background color Choose sky color Choose stroke color Create various dispersion-like effects in the border of an image

Based on a script by Fred Weinhaus

http://www.fmwconcepts.com/imagemagick/bordereffects/index.php Cut a jigsaw piece out of the image Cut out a jigsaw piece at the bottom right corner D: Density: Effect Error while executing plugin %s. Fade percent for mirror image Fade: Font size: Gap between image and mirror in pixels Give the picture an offset with itself as background Granularity: Gravity: Grayscale Hard Shadow Invert the colors of the image Jigsaw Piece 1 Jigsaw Piece 2 Make your screenshot look like a polaroid photo, add a caption, and even rotate it a little Negate Offset Opacity percent applied to whole mirror image Opacity: Output zoom factor; where value > 1 means zoom in and < 1 means zoom out Perseptive rotation about left edge of image Perspective exaggeration factor Polaroid Raise Border Raise a rectangular 3d-border Resize Resize your screenshot Rotation about image horizontal centerline Rotation about image vertical centerline Rotation about the image center Rotation: Sepia Sepia tone Shutter Branding Size: Sky color Soft Edges Stroke color Sunk Border Text: The base grain size or pixelization size used to create the detail in the border The frequency of detail in the border The pad size of constant color around the perimeter of the border The parameter d describes the linear scaling of the image. Using d=1, and a=b=c=0 leaves the image as it is. Choosing other d-values scales the image by that amount. a,b and c distort the image. Using negative values shifts distant points away from the center.

Defined by Barrel Correction Distortion, by Helmut Dersch.
http://www.all-in-one.ee/~dersch/barrel/barrel.html The size or dimension of the border region There are several wild-cards available, like
%Y = year
%m = month
%d = day
%T = time There was an error executing the plugin. Tool Torned Paper Turn the image into a grayscale image (256 shades) Turn the image into a polaroid one with the Shutter logo and a subtitle added Watermark Zoom factor for output image Zoom: off - No automatic adjustment

c - Center bounding box in output

zc - Zoom to fill and center bounding box in output

out - Creates an output image of size needed to hold the transformed image Project-Id-Version: shutter
Report-Msgid-Bugs-To: FULL NAME <EMAIL@ADDRESS>
POT-Creation-Date: 2010-08-31 19:30+0200
PO-Revision-Date: 2010-03-31 00:33+0000
Last-Translator: Mario Kemper (Romario) <mario.kemper@googlemail.com>
Language-Team: Slovak <sk@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Launchpad-Export-Date: 2011-01-28 04:22+0000
X-Generator: Launchpad (build 12274)
 3D zrkadlenie 3D otáčanie A: Pridať vlastný text vodoznaku do snímku Pridať tieň obrázku na priehľadnom pozadí Pridať roztrhané ohraničenie do obrázku Pridať obrátené  3D ohraničenie do obrázku Pridať sépia farbu prechádzajúcu do obrazu Pridať jemné hrany okolo obrázku Pridá strácanie odrazu pod obrázok a perspektívne pohľady

Na základe skriptu Freda Weinhausa

http://www.fmwconcepts.com/imagemagick/3Dreflection/index.php Použiť skreslenie pohľadu na obrázok

Na základe skriptu Fred Weinhausa

http://www.fmwconcepts.com/imagemagick/3Drotate/index.php Použiť efekt skreslenia vo vašej snímke Automaticky: B: Farba pozadia Súdkové skreslenie Efekty ohraničenia C: Kanál Vybrať farbu pozadia Vybrať farbu oblohy Vyberte farbu ťahu Vytvárať rôzne efekty rozptylu na okraji obrazu

Na základe skriptu Freda Weinhausa

http://www.fmwconcepts.com/imagemagick/bordereffects/index.php Vystrihnúť kúsok puzzle z obrázku Vystrihnúť kúsok puzzle v pravom dolnom rohu D: Hustota: Efekt Chyba pri spúšťaní rozšírenia %s. Slabnutie v percentách pre zrkadlový obraz Strácanie: Veľkosť písma: Rozdiel medzi obrazom a zrkadlom v pixeloch Dajte obrázku vyváženie so sebou samým ako pozadie Zrnitosť: Gravitácia: Odtiene šedej Silný tieň Prevrátiť farby obrazu Kúsok puzzle 1 Kúsok puzzle 2 Urobte si svoj snímok vyzerajúci ako fotografia z polaroidu, pridajte titulok, a dokonca ho trochu otočte Negatív Posun Priehľadnosť v percentách použitá na celý zrkadlový obraz Priehľadnosť: Výstup faktoru priblíženia, kde hodnota > 1 znamená zväčšenie a < 1 znamená oddialenie Perspektívne otáčanie okolo ľavého okraja obrazu Faktor zvýraznenia perspektívy Polaroid Rozšíriť ohraničenie Rozšíriť obdĺžnikové 3D ohraničenie Zmeniť veľkosť Zmeniť veľkosť snímku Rotácia okolo vodorovnej osi obrázku Rotácia okolo zvislej osi obrázku Rotácia okolo stredu obrázku Otočenie: Sépia Sýtosť sépie Urobiť značku Shutter Veľkosť: Farba oblohy Jemné hrany Farba ťahu Klesajúce ohraničenie Text: Základná veľkosť zrna alebo pixelizácie použitá na vytvorenie detailov v ohraničení Frekvencie detailu v ohraničení Veľkosť podložky konštantnej farby po obvode ohraničenia Parameter d opisuje lineárne škálovanie obrazu. Použitie d=1,  a a=b=c=0 ponechá obraz, taký ako je. Výber ostatných d-hodnôt stupnice obrazu o túto sumu. a, b a c skresľujú obraz. Pomocou záporných hodnôt posuniete vzdialenejšie body od stredu.

Definované Barrel Correction Distortion, Helmut Dersch.
http://www.all-in-one.ee/~dersch/barel/barrel.html Veľkosť alebo rozmer ohraničenia oblasti Existuje k dispozícii niekoľko divokých kariet, ako
%Y = rok
%m = mesiac
%d = deň
%T = čas Došlo ku chybe pri spustení rozšírenia. Nástroj Tornedo papier Otočte obrázok do obrázku v stupňoch šedej (256 odtieňov) Otočiť obrázok do polaroidu s logom Shutter a pridaným podtitulkom Vodoznak Faktor priblíženia pre výstup obrazu Priblíženie: off - Žiadne automatické nastavenie

c - Centrum orámovania na výstupe

zc - Vyplniť priblíženie a vystrediť orámovanie výstupu

out - Vytvorí výstup obrazu o  veľkosti, potrebnej ku transformácii obrázku 