.\" 1999 PTM Rafa� Witkowski
.\" Poprawki: Przemek Borys
.\" $XConsortium: startx.man /main/8 1996/12/09 17:09:15 kaleb $
.\" Copyright (c) 1993  X Consortium
.\" 
.\" $XFree86: xc/programs/xinit/startx.man,v 1.1.1.3.2.2 1998/11/05 19:38:35 hohndel Exp $
.\"
.\" Permission is hereby granted, free of charge, to any person obtaining
.\" a copy of this software and associated documentation PLIKI (the
.\" "Software"), to deal in the Software without restriction, including
.\" without limitation the rights to use, copy, modje�eliy, merge, publish,
.\" distribute, sublicense, and/or sell copies of the Software, and to
.\" permit persons to whom the Software is furnished to do so, subject to
.\" the following conditions:
.\" 
.\" The above copyright notice and this permission notice shall be included
.\" in all copies or substantial portions of the Software.
.\" 
.\" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
.\" OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
.\" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
.\" IN NO EVENT SHALL THE X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR
.\" OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
.\" ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
.\" OTHER DEALINGS IN THE SOFTWARE.
.\" 
.\" Except as contained in this notice, the name of the X Consortium shall
.\" not be used in advertising or otherwise to promote the sale, use or
.\" other dealings in this Software without prior written authorization
.\" from the X Consortium.
.TH STARTX 1 "Release 6.3" "X Version 11"
.SH NAZWA
startx \- inicjuje sesj� X-Windows
.SH SK�ADNIA
.B startx
.RI [[ klient ]
.I opcje
\&\.\|.\|.]
.RB [ \-\^\-
.RI [ serwer ]
.I opcje
\&.\|.\|.]
.SH OPIS
UWAGA: Skrypt \fIstartx\fP  dostarczony razem z dystrybucj� X11 
jest przyk�adem przeznaczonym bardziej jako baza dla indywidualnych 
rozwi�za� ni� jako gotowy produkt. Administratorzy sieci powinni go 
dostosowa� do w�asnych sieci. Je�eli to zrobi�, powinni te� wtedy 
zaktualizowa� te strony podr�cznika!
.PP
Skrypt startx jest interfejsem do programu xinit, kt�ry dostarcza
przyjaznej obs�ugi u�ytkownika dla uruchamiania pojedynczej sesji systemu 
X Window. Jest wywo�ywany zwykle bez argument�w.
.PP
Jest jeden wa�ny wyj�tek w przypadku kiedy wybrana jest odmienna g��bia
koloru. Wtedy wchodzi w gr� dopasowanie argument�w dla serwera, opcja 
jest z przedrostkiem 
.RB `--'
(Zobacz stron� podr�cznika
.IR xinit (1)
dla szceg��w o argumentach). W szczeg�lno�ci aby uruchomi� serwer w trybie 
16bpp u�yj
.sp
startx -- -bpp 16
.PP
Aby okre�li� program klienta, u�ywanego do pracy,
\fIstartx\fR najpierw szuka pliku o nazwie
.I .xinitrc
w osobistym katalogu u�ytkownika.
Je�eli go nie znajdzie, u�ywa pliku
.I xinitrc
w katalogu bibliotecznym programu 
.I xinit
.pp
Je�eli w linii komend s� podane opcje, to maj� one pierwsze�stwo nad tymi 
z plik�w. Aby okre�li� serwer, przeznaczony do uruchomienia, 
.I startx
najpierw szuka pliku nazwanego 
.I .xserverrc
w osobistym katalogu u�ytkownika.
Je�eli go nie znajdzie, u�ywa pliku 
.I xserverrc
w katalogu bibliotecznym 
.IR xinit .
U�ytkownik w rzeczywisto�ci rzadko potrzebuje tworzy� plik 
.I .xserverrc.	
.PP
(Zobacz podr�cznik
.IR xinit (1)
dla dalszych szczeg��w o argumentach). 
.PP
Plik 
.I .xinitrc
jest zazwyczaj skryptem pow�oki, kt�rego wywo�uj� liczni klienci, w��czaj�c 
swoje w�a�ciwo�ci u�ytkownika. Gdy skrypt ten istnieje, 
.I startx 
przerywaj�c sesj� serwera i zamyka te� ka�d� inn�, wymagaj�c� tego sesj�. 
Wi�kszo�� klient�w uruchamianych przez 
.I .xinitrc
powinno pracowa� w tle. Ostatni klient powinien pracowa� 
w pierwszym planie; je�eli istnieje, sesja b�dzie zako�czona.
Cz�sto wybiera si� jako ``magicznego'' klienta mened�era sesji, mened�era
okien, albo zgo�a \fIxterm\fP.
.SH PRZYK�AD
.PP
Poni�ej jest przyk�ad \fI\.xinitrc\fP, uruchamiaj�cy poszczeg�lne aplikacje 
i pozostawiaj�cy mened�er okien w pracy jako ``ostatni�'' aplikacj�.  
Zak�adaj�c, �e mened�er okien jest prawid�owo skonfigurowany, u�ytkownik 
wybiera opcj� ``Exit'' menu do zamkni�cia sesji X.
.sp
.in +4
.nf
xrdb  \-load  $HOME/.Xresources
xsetroot  \-solid  gray  &
xbiff  \-geometry  \-430+5  &
oclock  \-geometry  75x75\-0\-0  &
xload  \-geometry  \-80\-0  &
xterm  \-geometry  +0+60  \-ls  &
xterm  \-geometry  +0\-100  &
xconsole  \-geometry  \-0+0  \-fn  5x7  &
exec  twm
.fi
.in -4
.SH "Zmienne �rodowiska"
.TP 25
DISPLAY
Ta zmienna zostaje ustawiana na nazw� wy�wietlacza, z kt�rym klient powinien 
si� ��czy�.  UWAGA : 
.IR ustawiana ,
nie czytana.
.SH PLIKI
.TP 25
.I $(HOME)/.xinitrc
Klient przeznaczony do uruchomienia.  Typowy skrypt pow�oki kt�ry wykonuje 
wiele program�w w tle.
.TP 25
.I $(HOME)/.xserverrc
Serwer przeznaczony do uruchomienia.  Domy�lnym jest
.I X.
.TP 25
.I <XRoot>/lib/X11/xinit/xinitrc
Klient przeznaczony do uruchomienia, je�eli u�ytkownik nie ma pliku
.I .xinitrc
 <XRoot> odnosi si� do katalogu root w ga��zi instalacyjnej X11.
.TP 25
.I <XRoot>/lib/X11/xinit/xserverrc
Klient (chyba serwer?! - przyp. t�um.) przeznaczony do uruchomienia je�eli 
u�ytkownik nie ma pliku
.I .xserverrc
Jest to wymagane tylko wtedy, kiedy serwer potrzebuje specjalnych argument�w 
lub nie jest nazwany.  <XRoot> odnosi si� do katalogu root w ga��zi 
instalacyjnej X11.
.SH "ZOBACZ TAK�E"
.IR xinit (1)
