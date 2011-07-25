# FIXME:
# - make it compatible with xinitrc-ng
#   for example: /etc/X11/kdm/Xsession: line 42: exec: /etc/X11/xinit/Xclients: cannot execute: No such file or directory
#
Summary:	xinit application - X Window System initializer
Summary(pl.UTF-8):	Aplikacja xinit do uruchamiania X Window System
Name:		xorg-app-xinit
Version:	1.3.1
Release:	1
License:	MIT
Group:		X11/Applications
Source0:	http://xorg.freedesktop.org/releases/individual/app/xinit-%{version}.tar.bz2
# Source0-md5:	ee234056d8a3dbf37b61b4bcb35b88e4
Source1:	startx.1x.it
Source2:	startx.1x.pl
Source3:	xinit.1x.it
Source4:	xinit.1x.pl
Patch0:		%{name}-xwrapper.patch
Patch1:		%{name}-consolekit-support.patch
URL:		http://xorg.freedesktop.org/
BuildRequires:	ConsoleKit-devel
BuildRequires:	autoconf >= 2.60
BuildRequires:	automake
BuildRequires:	cpp
BuildRequires:	pkgconfig >= 1:0.19
BuildRequires:	xorg-lib-libX11-devel
BuildRequires:	xorg-proto-inputproto-devel
BuildRequires:	xorg-util-util-macros >= 1.8
Requires:	/etc/X11/xinit/xinitrc
Requires:	xorg-app-xauth
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
The xinit program is used to start the X Window System server and a
first client program on systems that cannot start X directly from init
or in environments that use multiple window systems. When this first
client exits, xinit will kill the X server and then terminate.

%description -l pl.UTF-8
Program xinit służy do uruchamiania serwera X Window System i
pierwszego programu klienckiego na systemach, które nie mogą uruchomić
X bezpośrednio z inita lub w środowiskach używających wielu systemów
okienkowych. Po zakończeniu pierwszego klienta xinit zabija serwer X i
kończy działanie.

%package xinitrc
Summary:	xinitrc script provided by Xorg
Summary(pl.UTF-8):	Skrypt xinitrc dostarczany z dystrybucją Xorg
Group:		X11
Provides:	xinitrc
Obsoletes:	xinitrc

%description xinitrc
xinitrc script provided by Xorg.

%description xinitrc -l pl.UTF-8
Skrypt xinitrc dostarczany z dystrybucją Xorg.

%prep
%setup -q -n xinit-%{version}
%patch0 -p1
%patch1 -p1

%build
%{__aclocal}
%{__autoconf}
%{__autoheader}
%{__automake}
%configure \
	--with-consolekit \
	--with-xinitdir=/etc/X11/xinit

%{__make}

%install
rm -rf $RPM_BUILD_ROOT

%{__make} install \
	DESTDIR=$RPM_BUILD_ROOT

install -D %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/it/man1/startx.1x
install -D %{SOURCE2} $RPM_BUILD_ROOT%{_mandir}/pl/man1/startx.1x
install -D %{SOURCE3} $RPM_BUILD_ROOT%{_mandir}/it/man1/xinit.1x
install -D %{SOURCE4} $RPM_BUILD_ROOT%{_mandir}/pl/man1/xinit.1x

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc COPYING ChangeLog README
%attr(755,root,root) %{_bindir}/startx
%attr(755,root,root) %{_bindir}/xinit
%{_mandir}/man1/startx.1x*
%{_mandir}/man1/xinit.1x*
%lang(it) %{_mandir}/it/man1/startx.1x*
%lang(it) %{_mandir}/it/man1/xinit.1x*
%lang(pl) %{_mandir}/pl/man1/startx.1x*
%lang(pl) %{_mandir}/pl/man1/xinit.1x*

%if 0
# Not finished. see TODO at start of spec
%files xinitrc
%defattr(644,root,root,755)
%attr(755,root,root) /etc/X11/xinit/xinitrc
%endif
