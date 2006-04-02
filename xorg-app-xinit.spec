# FIXME:
# - /etc/X11/xinit vs /usr/lib{,64}/X11/xinit
# - make it compatible with xinitrc-ng
#
Summary:	xinit application
Summary(pl):	Aplikacja xinit
Name:		xorg-app-xinit
Version:	1.0.2
Release:	0.1
License:	MIT
Group:		X11/Applications
Source0:	http://xorg.freedesktop.org/releases/individual/app/xinit-%{version}.tar.bz2
# Source0-md5:	d591fafe69b57969b0521c461073a01f
Patch0:		%{name}-xwrapper.patch
URL:		http://xorg.freedesktop.org/
BuildRequires:	autoconf >= 2.57
BuildRequires:	automake
BuildRequires:	cpp
BuildRequires:	pkgconfig >= 1:0.19
BuildRequires:	xorg-lib-libX11-devel
BuildRequires:	xorg-util-util-macros >= 0.99.2
Requires:	xorg-app-xauth
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
