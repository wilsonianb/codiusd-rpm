%define name codiusd
%define version %(echo $CODIUSD_VERSION)
%define release %(echo $CODIUSD_RELEASE)
%define buildroot %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

Name: %{name}
Version: %{version}
Release: %{release}
Summary: codiusd

Group: Installation Script
License: Apache-2.0
Source: %{name}.tar.gz
BuildRoot: %{buildroot}
Requires: nodejs
Requires: hyper-container
Requires: hyperstart
Requires: qemu-hyper
Requires: moneyd-xrp
BuildRequires: systemd-units
%{?systemd_requires}
AutoReqProv: no

%description
Codius Host Software

%prep
%setup -c -n %{name}

%build

%pre

%install
install -d %{buildroot}/usr/lib/codiusd
cp -r ./codiusd/* %{buildroot}/usr/lib/codiusd/
install -d %{buildroot}/var/lib/codius
install -D codiusd.service %{buildroot}%{_unitdir}/codiusd.service

%post
%systemd_post codiusd.service

%preun
%systemd_preun codiusd.service

%postun
%systemd_postun_with_restart codiusd.service

%clean
rm -rf %{buildroot}

%files
%defattr(644, root, root, 755)
/usr/lib/codiusd
/var/lib/codius
%{_unitdir}/codiusd.service

%changelog
* Tue Jan 10 2019 Brandon Wilson <brandon@coil.com> - 2.0.0-1
- Add scriptlets
- Do not auto enable packages

* Thu Sep 27 2018 Brandon Wilson <brandon@coil.com> - 1.2.5
- Initial rpm packaging
