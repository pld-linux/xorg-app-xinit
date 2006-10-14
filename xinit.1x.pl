.\" 1999 PTM Rafa³ Witkowski
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
.SH SK£ADNIA
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
Program \fIxinit\fP jest u¿ywany do startu systemu X Window 
i pierwszego programu klienta dla systemów, które nie mog±
wystartowaæ X wprost z katalogu \fI/etc/init\fP albo w ¶rodowisku które
u¿ywa wielu systemów okien. Kiedy pierwszy klient
istnieje, \fIxinit\fP bêdzie koñczy³ proces X serwera i ten siê zakoñczy.
.PP
Je¿eli ¿aden program klienta nie jest podany w linii komendy,
\fIxinit\fP bêdzie szuka³ w g³ównym katalogu u¿ytkownika pliku \fI.xinitrc\fP
aby wykonaæ go jako skrypt pow³oki w celu uruchomienia programu klienta.
Je¿eli ten plik nie istnieje, \fIxinit\fP bêdzie 
u¿ywa³ nastêpuj±cej komendy jako domy¶lnej:
.sp
	xterm  \-geometry  +1+1  \-n  login  \-display  :0
.sp
.PP
Je¿eli w linii komendy nie jest podany ¿aden program serwera,
\fIxinit\fP bêdzie szuka³ w g³ównym katalogu u¿ytkownika pliku 
skryptowego \fI.xserverrc\fP.
Nastêpnie wykona go jako skrypt pow³oki w celu uruchomienia programu serwera.
Je¿eli plik ten nie istnieje, \fIxinit\fP bêdzie u¿ywa³ 
nastêpuj±cej komendy domy¶lnej:
.sp
	X  :0
.sp
Proszê zwróciæ uwagê, ¿e jest to program o nazwie \fIX\fP 
w aktualnej ¶cie¿ce dostêpu.
Jednak serwery s± zwykle nazywane \fIXdisplaytype\fP gdzie 
\fIdisplaytype\fP oznacza typ graficznego wy¶wietlacza, który jest 
obs³ugiwany przez ten serwer.
Administrator sieci powinien wiêc utworzyæ dowi±zanie do 
odpowiedniego typu serwera w komputerze lub utworzyæ 
skrypt pow³oki, który wywo³a \fIxinit\fP z odpowiednim serwerem.
.PP
Uwaga, podczas u¿ywania skryptu \fI.xserverrc\fP nale¿y upewniæ siê 
czy wykonujemy "exec" z prawdziwym X serwerem.	
Nieudane wykonanie tego etapu mo¿e uczyniæ X serwer powolnym (slowly)
dla startu i zakoñczenia.
Na przyk³ad :
.sp
	exec Xdisplaytype
.PP
Wa¿nym punktem jest to, ¿e programy, które s± wykonywane przez skrypt
\fI\.xinitrc\fP
powinny byæ wykonywane w tle, je¿eli one nie zakoñcz± siê prawid³owo,
tak ¿e one nie uchroni± innych programów przed wystartowaniem.
Jednak ostatni d³ugo¿yj±cy uruchomiony program
(zazwyczaj mened¿er okien lub emulator terminala)
powinien zostaæ pozostawiony w pierwszym planie (foreground). Jest to
konieczne by skrypt siê nie zakoñczy³ (co sygnalizuje, ¿e zadanie u¿ytkownika 
jest wykonane i \fIxinit\fP powinien siê zakoñczyæ).
.PP
W linii komend mo¿e byæ jeszcze podany alternatywny klient i/lub serwer.
¯±dany program klienta i jego argumenty powinny byæ podane jako pierwsze 
argumenty linii komendy \fIxinit\fP.  W celu zadeklarowania szczególnej
linii komendy serwera, do³±cz podwójn± kreskê (\-\^\-) do 
linii komendy  \fIxinit\fP  (po wszelkich klientach i argumentach),
a za ni± oczekiwan± komendê serwera.
.PP
Zarówno nazwa programu klienta jak i nazwa programu serwera 
Musz± siê zaczynaæ znakiem uko¶nika (/) albo kropk± (.). 
W przeciwnym razie bêd± one traktowane jako argumenty do³±czane do ich 
indywidualnych linii startowych. To umo¿liwia dodanie argumentów 
(na przyk³ad, kolorów obrazu i t³a) bez potrzeby powtarzania ca³ej 
linii komendy.
.PP
Je¿eli nazwa serwera nie jest zadeklarowana, a pierwszy argument 
wystêpuj±cy po podwójnej kresce (--) to dwukropek z doklejon± cyfr±, to
 \fIxinit\fP rozpozna ten numer jako kod display zamiast zero. 
Wszystkie pozosta³e argumenty s± do³±czane na koñcu linii komend serwera.
.PP
.SH PRZYK£ADY:
Poni¿ej s± poszczególne przyk³ady na u¿ywanie argumentów w linii komend
\fIxinit\fP .
.TP 8
.B "xinit"
Xinit uruchomi tu serwer o nazwie \fIX\fP i wykona skrypt 
U¿ytkownika \fI\.xinitrc\fP, o ile taki istnieje, a w przeciwnym razie 
wystartuje program \fIxterm\fP.
.TP 8
.B "xinit \-\^\- /usr/X11R6/bin/Xqdss  :1"
tu widaæ, jak mo¿na uruchomiæ okre¶lony typ 
serwera na innym wy¶wietlaczu.
.TP 8
.B "xinit \-geometry =80x65+10+10 \-fn 8x13 \-j \-fg white \-bg navy"
To uruchomi serwer o nazwie \fIX\fP, i do³±czy podane argumenty 
do domy¶lnej linii komend programu \fIxterm\fP.
Program zignoruje skrypt \fI\.xinitrc\fP.
.TP 8
.B "xinit \-e widgets \-\^\- ./Xsun \-l \-c"
Ten przyk³ad u¿yje komendy \fI\.\/Xsun \-l \-c\fP aby uruchomiæ
serwer i do³±czyæ argumenty \fI\-e widgets\fP do domy¶lnej 
komendy \fIxterm\fP.
.TP 8
.B "xinit /usr/ucb/rsh fasthost cpupig \-display ws:1 \-\^\-  :1 \-a 2 \-t 5"
Ten przyk³ad uruchomi serwer o nazwie \fIX\fP na wy¶wietlaczu o kodzie 1,
z argumentami \fI\-a 2 \-t 5\fP. 
Potem uruchomi sieciow± pow³okê 
na zdalny komputer \fBfasthost\fP, na którym wykona komendê \fIcpupig\fP, 
nakazuj±c jej wy¶wietlanie obrazu z powrotem do lokalnej stacji.
.PP
Poni¿ej jest przyk³ad skryptu \fI\.xinitrc\fP uruchamiaj±cego zegar,
poszczególne terminale i pozostawiaj±cego mened¿er okien pracuj±cy w trybie
``ostatniej'' aplikacji. 
Zak³adaj±c, ¿e mened¿er okien
zosta³ skonfigurowany prawid³owo, u¿ytkownik wybiera pozycjê menu
``Exit'' aby zamkn±æ program X.
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
Sieæ, która chce tworzyæ wspólne ¶rodowisko startowe
mo¿e po prostu utworzyæ domy¶lny skrypt \fI\.xinitrc\fP,
który odwo³uje siê do pliku
startowego dla sieci rozleg³ych  o ¶cie¿ce dostêpu:
.sp
.in +8
.nf
#!/bin/sh
\&. /usr/local/lib/site.xinitrc
.fi
.in -8
.sp
Innym podej¶ciem jest napisanie skryptu, który uruchomi \fIxinit\fP
ze specjalnym skryptem pow³oki. 
Takie skrypty s± zwykle nazywane \fIx11\fP, \fIxstart\fP
albo \fIstartx\fP i s± wygodnym sposobem zapewnienia prostego
interfejsu dla pocz±tkuj±cych u¿ytkowników. :
.sp
.in +8
.nf
#!/bin/sh
xinit /usr/local/lib/site.xinitrc \-\^\- /usr/X11R6/bin/X bc
.fi
.in -8
.sp
.SH "ZMIENNE ¦RODOWISKA"
.TP 15
.B DISPLAY
Ta zmienna okre¶la nazwê wy¶wietlacza, z którym programy klienta 
powinny siê po³±czyæ.
.TP 15
.B XINITRC
Ta zmienna deklaruje plik skryptu inicjuj±cego zawieraj±cy
komendy pow³oki do wystartowania inicjuj±cego okna.
Domy¶lnie jest u¿ywany plik \fI\.xinitrc\fP w katalogu home.
.SH PLIKI
.xinitrc domy¶lny skrypt klienta dla programu klienta xterm; uruchamiany
je¿eli nie istnieje plik .xinitrc
.TP 15
.I .xinitrc
domy¶lny skrypt dla programu klienta 
.TP 15
.I xterm
uruchamiany, je¿eli nie istanieje plik \fI.xinitrc\fP
.TP 15
.I .xserverrc
domy¶lny skrypt dla programu serwera 
.TP 15
.I X
serwer uruchamiany je¿eli nie istnieje plik \fI.xserverrc\fP
.SH ZOBACZ TAK¯E
.IR X (1),
.IR startx (1),
.IR Xserver (1),
.IR xterm (1)
.SH AUTOR
Bob Scheifler, MIT Laboratory dla Computer Scienc
