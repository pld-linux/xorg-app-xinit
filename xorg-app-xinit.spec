Summary:	xinit application
Summary(pl):	Aplikacja xinit
Name:		xorg-app-xinit
Version:	1.0.1
Release:	0.3
License:	MIT
Group:		X11/Applications
Source0:	http://xorg.freedesktop.org/releases/X11R7.0/src/app/xinit-%{version}.tar.bz2
# Source0-md5:	8c353e39389edbdffc5387acc24948a0
Patch0:		%{name}-xwrapper.patch
URL:		http://xorg.freedesktop.org/
BuildRequires:	autoconf >= 2.57
BuildRequires:	automake
BuildRequires:	cpp
BuildRequires:	pkgconfig >= 1:0.19
BuildRequires:	xorg-lib-libX11-devel
BuildRequires:	xorg-util-util-macros >= 0.99.2
Requires:	xorg-app-xauth
Requires:	xorg-lib-libXdmcp
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
xinit application.

%description -l pl
Aplikacja xinit.

%prep
%setup -q -n xinit-%{version}
%patch0 -p0

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

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc COPYING ChangeLog README
%attr(755,root,root) %{_bindir}/*
%{_libdir}/X11/xinit
%{_mandir}/man1/*.1x*
