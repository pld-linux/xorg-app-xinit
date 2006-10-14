# FIXME:
# - make it compatible with xinitrc-ng
#
Summary:	xinit application
Summary(pl):	Aplikacja xinit
Name:		xorg-app-xinit
Version:	1.0.3
Release:	0.1
License:	MIT
Group:		X11/Applications
Source0:	http://xorg.freedesktop.org/releases/individual/app/xinit-%{version}.tar.bz2
# Source0-md5:	f04a903cc0e18b3c338f58eb90f6caf8
Source1:	startx.1x.it
Source2:	startx.1x.pl
Source3:	xinit.1x.it
Source4:	xinit.1x.pl
Patch0:		%{name}-xwrapper.patch
Patch1:		%{name}-xinitdir.patch
URL:		http://xorg.freedesktop.org/
BuildRequires:	autoconf >= 2.57
BuildRequires:	automake
BuildRequires:	cpp
BuildRequires:	pkgconfig >= 1:0.19
BuildRequires:	xorg-lib-libX11-devel
BuildRequires:	xorg-proto-inputproto-devel
BuildRequires:	xorg-util-util-macros >= 0.99.2
Requires:	/etc/X11/xinit/xinitrc
Requires:	xorg-app-xauth
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
xinit application.

%description -l pl
Aplikacja xinit.

%package xinitrc
Summary:	xinitrc script provided by Xorg
Summary(pl):	Skrypt xinitrc dostarczany z dystrybucj± Xorg
Group:		X11
Provides:	xinitrc
Obsoletes:	xinitrc

%description xinitrc
xinitrc script provided by Xorg.

%description xinitrc -l pl
Skrypt xinitrc dostarczany z dystrybucj± Xorg.

%prep
%setup -q -n xinit-%{version}
%patch0 -p0
%patch1 -p1

%build
%{__aclocal}
%{__autoconf}
%{__autoheader}
%{__automake}
%configure

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

%files xinitrc
%defattr(644,root,root,755)
%attr(755,root,root) /etc/X11/xinit/xinitrc
