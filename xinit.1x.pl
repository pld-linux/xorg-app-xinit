.\" 1999 PTM Rafa� Witkowski
.\" Poprawki: Przemek Borys
.\" $XConsortium: xinit.man /main/24 1996/12/09 17:09:20 kaleb $
.\" $XFree86: xc/programs/xinit/xinit.man,v 3.2 1996/12/23 07:11:25 dawes Exp $
.\" Copyright (c) 1988  X Consortium
.\" 
.\" Permission is hereby granted, free of charge, to any person obtaining
.\" a copy of this software and associated documentation files (the
.\" "Software"), to deal in the Software without restriction, including
.\" without limitation the rights to use, copy, modify, merge, publish,
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
.TH XINIT 1 "Release 6.3" "X Version 11"
.SH NAZWA
xinit \- inicjalizer systemu X Window 
.SH SK�ADNIA
.B xinit
[ [
.I klient
]
.I opcje
] [
.B \-\^\-
[
.I server
] [
.I display
]
.I opcje
]
.SH OPIS
Program \fIxinit\fP jest u�ywany do startu systemu X Window 
i pierwszego programu klienta dla system�w, kt�re nie mog�
wystartowa� X wprost z katalogu \fI/etc/init\fP albo w �rodowisku kt�re
u�ywa wielu system�w okien. Kiedy pierwszy klient
istnieje, \fIxinit\fP b�dzie ko�czy� proces X serwera i ten si� zako�czy.
.PP
Je�eli �aden program klienta nie jest podany w linii komendy,
\fIxinit\fP b�dzie szuka� w g��wnym katalogu u�ytkownika pliku \fI.xinitrc\fP
aby wykona� go jako skrypt pow�oki w celu uruchomienia programu klienta.
Je�eli ten plik nie istnieje, \fIxinit\fP b�dzie 
u�ywa� nast�puj�cej komendy jako domy�lnej:
.sp
	xterm  \-geometry  +1+1  \-n  login  \-display  :0
.sp
.PP
Je�eli w linii komendy nie jest podany �aden program serwera,
\fIxinit\fP b�dzie szuka� w g��wnym katalogu u�ytkownika pliku 
skryptowego \fI.xserverrc\fP.
Nast�pnie wykona go jako skrypt pow�oki w celu uruchomienia programu serwera.
Je�eli plik ten nie istnieje, \fIxinit\fP b�dzie u�ywa� 
nast�puj�cej komendy domy�lnej:
.sp
	X  :0
.sp
Prosz� zwr�ci� uwag�, �e jest to program o nazwie \fIX\fP 
w aktualnej �cie�ce dost�pu.
Jednak serwery s� zwykle nazywane \fIXdisplaytype\fP gdzie 
\fIdisplaytype\fP oznacza typ graficznego wy�wietlacza, kt�ry jest 
obs�ugiwany przez ten serwer.
Administrator sieci powinien wi�c utworzy� dowi�zanie do 
odpowiedniego typu serwera w komputerze lub utworzy� 
skrypt pow�oki, kt�ry wywo�a \fIxinit\fP z odpowiednim serwerem.
.PP
Uwaga, podczas u�ywania skryptu \fI.xserverrc\fP nale�y upewni� si� 
czy wykonujemy "exec" z prawdziwym X serwerem.	
Nieudane wykonanie tego etapu mo�e uczyni� X serwer powolnym (slowly)
dla startu i zako�czenia.
Na przyk�ad :
.sp
	exec Xdisplaytype
.PP
Wa�nym punktem jest to, �e programy, kt�re s� wykonywane przez skrypt
\fI\.xinitrc\fP
powinny by� wykonywane w tle, je�eli one nie zako�cz� si� prawid�owo,
tak �e one nie uchroni� innych program�w przed wystartowaniem.
Jednak ostatni d�ugo�yj�cy uruchomiony program
(zazwyczaj mened�er okien lub emulator terminala)
powinien zosta� pozostawiony w pierwszym planie (foreground). Jest to
konieczne by skrypt si� nie zako�czy� (co sygnalizuje, �e zadanie u�ytkownika 
jest wykonane i \fIxinit\fP powinien si� zako�czy�).
.PP
W linii komend mo�e by� jeszcze podany alternatywny klient i/lub serwer.
��dany program klienta i jego argumenty powinny by� podane jako pierwsze 
argumenty linii komendy \fIxinit\fP.  W celu zadeklarowania szczeg�lnej
linii komendy serwera, do��cz podw�jn� kresk� (\-\^\-) do 
linii komendy  \fIxinit\fP  (po wszelkich klientach i argumentach),
a za ni� oczekiwan� komend� serwera.
.PP
Zar�wno nazwa programu klienta jak i nazwa programu serwera 
Musz� si� zaczyna� znakiem uko�nika (/) albo kropk� (.). 
W przeciwnym razie b�d� one traktowane jako argumenty do��czane do ich 
indywidualnych linii startowych. To umo�liwia dodanie argument�w 
(na przyk�ad, kolor�w obrazu i t�a) bez potrzeby powtarzania ca�ej 
linii komendy.
.PP
Je�eli nazwa serwera nie jest zadeklarowana, a pierwszy argument 
wyst�puj�cy po podw�jnej kresce (--) to dwukropek z doklejon� cyfr�, to
 \fIxinit\fP rozpozna ten numer jako kod display zamiast zero. 
Wszystkie pozosta�e argumenty s� do��czane na ko�cu linii komend serwera.
.PP
.SH PRZYK�ADY:
Poni�ej s� poszczeg�lne przyk�ady na u�ywanie argument�w w linii komend
\fIxinit\fP .
.TP 8
.B "xinit"
Xinit uruchomi tu serwer o nazwie \fIX\fP i wykona skrypt 
U�ytkownika \fI\.xinitrc\fP, o ile taki istnieje, a w przeciwnym razie 
wystartuje program \fIxterm\fP.
.TP 8
.B "xinit \-\^\- /usr/X11R6/bin/Xqdss  :1"
tu wida�, jak mo�na uruchomi� okre�lony typ 
serwera na innym wy�wietlaczu.
.TP 8
.B "xinit \-geometry =80x65+10+10 \-fn 8x13 \-j \-fg white \-bg navy"
To uruchomi serwer o nazwie \fIX\fP, i do��czy podane argumenty 
do domy�lnej linii komend programu \fIxterm\fP.
Program zignoruje skrypt \fI\.xinitrc\fP.
.TP 8
.B "xinit \-e widgets \-\^\- ./Xsun \-l \-c"
Ten przyk�ad u�yje komendy \fI\.\/Xsun \-l \-c\fP aby uruchomi�
serwer i do��czy� argumenty \fI\-e widgets\fP do domy�lnej 
komendy \fIxterm\fP.
.TP 8
.B "xinit /usr/ucb/rsh fasthost cpupig \-display ws:1 \-\^\-  :1 \-a 2 \-t 5"
Ten przyk�ad uruchomi serwer o nazwie \fIX\fP na wy�wietlaczu o kodzie 1,
z argumentami \fI\-a 2 \-t 5\fP. 
Potem uruchomi sieciow� pow�ok� 
na zdalny komputer \fBfasthost\fP, na kt�rym wykona komend� \fIcpupig\fP, 
nakazuj�c jej wy�wietlanie obrazu z powrotem do lokalnej stacji.
.PP
Poni�ej jest przyk�ad skryptu \fI\.xinitrc\fP uruchamiaj�cego zegar,
poszczeg�lne terminale i pozostawiaj�cego mened�er okien pracuj�cy w trybie
``ostatniej'' aplikacji. 
Zak�adaj�c, �e mened�er okien
zosta� skonfigurowany prawid�owo, u�ytkownik wybiera pozycj� menu
``Exit'' aby zamkn�� program X.
.sp
.in +8
.nf
xrdb \-load $HOME/.Xresources
xsetroot \-solid gray &
xclock \-g 50x50\-0+0 \-bw 0 &
xload \-g 50x50\-50+0 \-bw 0 &
xterm \-g 80x24+0+0 &
xterm \-g 80x24+0\-0 &
twm
.fi
.in -8
.sp
Sie�, kt�ra chce tworzy� wsp�lne �rodowisko startowe
mo�e po prostu utworzy� domy�lny skrypt \fI\.xinitrc\fP,
kt�ry odwo�uje si� do pliku
startowego dla sieci rozleg�ych  o �cie�ce dost�pu:
.sp
.in +8
.nf
#!/bin/sh
\&. /usr/local/lib/site.xinitrc
.fi
.in -8
.sp
Innym podej�ciem jest napisanie skryptu, kt�ry uruchomi \fIxinit\fP
ze specjalnym skryptem pow�oki. 
Takie skrypty s� zwykle nazywane \fIx11\fP, \fIxstart\fP
albo \fIstartx\fP i s� wygodnym sposobem zapewnienia prostego
interfejsu dla pocz�tkuj�cych u�ytkownik�w. :
.sp
.in +8
.nf
#!/bin/sh
xinit /usr/local/lib/site.xinitrc \-\^\- /usr/X11R6/bin/X bc
.fi
.in -8
.sp
.SH "ZMIENNE �RODOWISKA"
.TP 15
.B DISPLAY
Ta zmienna okre�la nazw� wy�wietlacza, z kt�rym programy klienta 
powinny si� po��czy�.
.TP 15
.B XINITRC
Ta zmienna deklaruje plik skryptu inicjuj�cego zawieraj�cy
komendy pow�oki do wystartowania inicjuj�cego okna.
Domy�lnie jest u�ywany plik \fI\.xinitrc\fP w katalogu home.
.SH PLIKI
.xinitrc domy�lny skrypt klienta dla programu klienta xterm; uruchamiany
je�eli nie istnieje plik .xinitrc
.TP 15
.I .xinitrc
domy�lny skrypt dla programu klienta 
.TP 15
.I xterm
uruchamiany, je�eli nie istanieje plik \fI.xinitrc\fP
.TP 15
.I .xserverrc
domy�lny skrypt dla programu serwera 
.TP 15
.I X
serwer uruchamiany je�eli nie istnieje plik \fI.xserverrc\fP
.SH ZOBACZ TAK�E
.IR X (1),
.IR startx (1),
.IR Xserver (1),
.IR xterm (1)
.SH AUTOR
Bob Scheifler, MIT Laboratory dla Computer Scienc
