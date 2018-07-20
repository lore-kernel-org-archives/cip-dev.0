From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 20 Jul 2018 17:20:34 +0900
Subject: [cip-dev] [CIP Core] Criteria for prioritizing security fixes in
	Debian LTS
Message-ID: <000301d42002$87e767e0$97b637a0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

As platinum-level sponsors of the Debian LTS, we (CIP members) can provide a list of packages that we rely on and that should be prioritized in terms of security support.
[Note] The list of packages from each member can be found here:
Ref: https://docs.google.com/spreadsheets/d/1hrhYnDYSxeA-ZXaHB329-CzgY8H4H5iHXP1AeFFdJDc/
[Note] The list can be updated at any time (by notifying deblts at freexian.com)
[Note] The votes will be weighted by the amount of money contributed.
[Note] The Customer recognizes that this contract is a best-effort contract

During the Open Source Summit in Japan, we discussed about how to prioritize those packages. I proposed to create a set of criteria and Agustin mentioned that it would be a good idea to have you (Ben) evaluate these criteria and its impact before attending to DebConf. 
[Note] Based on your feedback, CIP will decide to contact the Freexian leads before the DebConf or not.

Without further delay, I would appreciate it if you reviewed the criteria below to prioritize security fixes:
1)  Packages that are popular among members' package lists
	[Rationale] popular packages are often the target of exploits
	- Examples: bash, busybox[-static], zlib, sqlite3, iptables, net-tools, libcap2, util-linux, dropbear, libsqlite3, tzdata
2) CVEs with high "base score", high "impact score", 
   high "exploitability score", and low "attack complexity"
	[Rationale] these CVEs usually refer to bugs that are easy to exploit
	or have a high impact.
3) Network software (CVEs with "Access Vector (AV): Network")
	[Rationale] bugs that can be exploited remotely are the most dangerous
	- Network servers examples: apache2, nginx, openssh-server, openssh-sftp-server,
	  tftp-hpa, postgresql, nfs-kernel-server, strongswan, netcat,vsftpd
	- Network libs examples: libssh, libssl, zeromq3, libsocketcan, net-snmp,
	  libnet, libnss, openldap, openvpn, libcurl..
	- Network clients examples: openssh-client, sshpass, ntp, wireless-tools,
	  wget, obexftp, iproute2...
	- Update software examples: apt, unattended-upgrades...
4) Security software
	[Rationale] LSM modules, encryption, and authorization are the
	foundation of a security-hardened system
	- Examples: apparmor, libseccomp, libselinux, *crypt*, libnettle4, libkeyutils1, tpm2-tools, pam, login, passwd, pwauth, xauth, libsasl, php-auth, shadow, sudo...
5) Language runtimes/compilers
	[Rationale] they are common to many applications.
	- Examples: gcc, libc, libstdc++, lua, nodejs, openjdk, perl, python, tcl...

Best regards,
Daniel Sangorrin
