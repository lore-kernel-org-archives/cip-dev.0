From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 26 Jul 2018 11:29:42 +0800
Subject: [cip-dev] [CIP Core] Criteria for prioritizing security fixes
 in Debian LTS
In-Reply-To: <000301d42002$87e767e0$97b637a0$@toshiba.co.jp>
References: <000301d42002$87e767e0$97b637a0$@toshiba.co.jp>
Message-ID: <1532575782.21552.51.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2018-07-20 at 17:20 +0900, Daniel Sangorrin wrote:
[...]
> Without further delay, I would appreciate it if you reviewed the
> criteria below to prioritize security fixes:

The criteria make sense to me.  I have a few points:

> 1)??Packages that are popular among members' package lists
> 	[Rationale] popular packages are often the target of exploits
> 	- Examples: bash, busybox[-static], zlib, sqlite3, iptables, net-tools, libcap2, util-linux, dropbear, libsqlite3, tzdata
> 2) CVEs with high "base score", high "impact score",?
> ???high "exploitability score", and low "attack complexity"
> 	[Rationale] these CVEs usually refer to bugs that are easy to exploit
> 	or have a high impact.
> 3) Network software (CVEs with "Access Vector (AV): Network")
> 	[Rationale] bugs that can be exploited remotely are the most dangerous
> 	- Network servers examples: apache2, nginx, openssh-server, openssh-sftp-server,
> 	??tftp-hpa, postgresql, nfs-kernel-server, strongswan, netcat,vsftpd
> 	- Network libs examples: libssh, libssl, zeromq3, libsocketcan, net-snmp,
> 	??libnet, libnss, openldap, openvpn, libcurl..
> 	- Network clients examples: openssh-client, sshpass, ntp, wireless-tools,
> 	??wget, obexftp, iproute2...
> 	- Update software examples: apt, unattended-upgrades...

I don't think remote filesystem implementations are security-
supportable over the period required by LTS, and I thought we agreed
that remote filesystem code in the kernel wouldn't be supported.

> 4) Security software
> 	[Rationale] LSM modules, encryption, and authorization are the
> 	foundation of a security-hardened system
> 	- Examples: apparmor, libseccomp, libselinux, *crypt*, libnettle4, libkeyutils1, tpm2-tools, pam, login, passwd, pwauth, xauth, libsasl, php-auth, shadow, sudo...
> 5) Language runtimes/compilers
> 	[Rationale] they are common to many applications.
> 	- Examples: gcc, libc, libstdc++, lua, nodejs, openjdk, perl, python, tcl...

You should probably discuss with the LTS team which version(s) of
OpenJDK are security supportable.  Updates to OpenJDK are dependent on
upstream support.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
