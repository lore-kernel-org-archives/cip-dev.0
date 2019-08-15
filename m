From: yasin.demirci@siemens.com (Demirci, Yasin)
Date: Thu, 15 Aug 2019 11:27:10 +0000
Subject: [cip-dev] [Cip-security]  Testing CIP kernel with Debian gcc
In-Reply-To: <CAFk6z8N0-9=LRfxVK5zgdsXC34om0W5-xzX4wbkDa59ZSK30yg@mail.gmail.com>
References: <TYAPR01MB4286F48F657C60E5BBF5341DE1D70@TYAPR01MB4286.jpnprd01.prod.outlook.com>
	<TYAPR01MB228561299852241F36E8328BB7D70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<5087d1355a38d5a1cb4c1e9e07bf64a0fddb625e.camel@codethink.co.uk>
	<CAFk6z8N0-9=LRfxVK5zgdsXC34om0W5-xzX4wbkDa59ZSK30yg@mail.gmail.com>
Message-ID: <DB6PR10MB17651F1D60CF3450B5A5B867E0AC0@DB6PR10MB1765.EURPRD10.PROD.OUTLOOK.COM>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Lin-san,

I'm not sure about the consequences of the two different approaches.
However I thought we want to make security a mandatory feature in CIP so an optional removal would not be planned?

Best Regards
Yasin

-----Urspr?ngliche Nachricht-----
Von: cip-security-bounces at lists.cip-project.org <cip-security-bounces@lists.cip-project.org> Im Auftrag von SZ Lin (???)
Gesendet: Donnerstag, 15. August 2019 04:51
An: cip-dev at lists.cip-project.org; cip-security at lists.cip-project.org
Cc: pavel at denx.de; Ben Hutchings <ben.hutchings@codethink.co.uk>; Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Betreff: Re: [Cip-security] [cip-dev] Testing CIP kernel with Debian gcc

Hi all,

According to the discussion in IRC weekly meeting last week, do we want to add extra compiler options (e.g., security hardening) in CIP development? Or use origin setting from Debian package.

I also attached Debian gcc 6.3 and 8.3 options below

Any feedback is appreciated.

SZ

== Debian 9 gcc 6.3 options ==
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/6/lto-wrapper
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian 6.3.0-18+deb9u1' --with-bugurl=file:///usr/share/doc/gcc-6/README.Bugs
--enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++
--prefix=/usr --program-suffix=-6 --program-prefix=x86_64-linux-gnu-
--enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-libmpx --enable-plugin --enable-default-pie --with-system-zlib --disable-browser-plugin --enable-java-awt=gtk --enable-gtk-cairo --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-6-amd64/jre
--enable-java-home
--with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-6-amd64
--with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-6-amd64
--with-arch-directory=amd64
--with-ecj-jar=/usr/share/java/eclipse-ecj.jar
--with-target-system-zlib --enable-objc-gc=auto --enable-multiarch
--with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu Thread model: posix gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1) ==

== Debian 10 gcc 8.3 options ==
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/8/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian 8.3.0-19' --with-bugurl=file:///usr/share/doc/gcc-8/README.Bugs
--enable-languages=c,ada,c++,go,brig,d,fortran,objc,obj-c++
--prefix=/usr --with-gcc-major-version-only --program-suffix=-8
--program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --enable-bootstrap --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-libmpx --enable-plugin --enable-default-pie --with-system-zlib --with-target-system-zlib --enable-objc-gc=auto --enable-multiarch --disable-werror
--with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none --without-cuda-driver --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu --with-build-config=bootstrap-lto --enable-link-mutex Thread model: posix gcc version 8.3.0 (Debian 8.3.0-19) ==

Ben Hutchings <ben.hutchings@codethink.co.uk> ? 2019?8?9? ?? ??9:05???
>
> On Thu, 2019-08-08 at 12:05 +0000, Chris Paterson wrote:
> [...]
> > Do Debian make any changes/fixes in their gcc package?
>
> Yes, they are usually snapshots of a release branch, with some cherry- 
> picked fixes e.g. for gcc-8 in buster the latest changelog entry is:
>
> gcc-8 (8.3.0-6) unstable; urgency=medium
>
>   * Update to SVN 20190406 (r270182) from the gcc-8-branch.
>     - Fix PR middle-end/89934, PR lto/89896.
>   * Fix PR fortran/89981, taken from the trunk.
>
>  -- Matthias Klose <doko@debian.org>  Sat, 06 Apr 2019 16:44:55 +0200
>
> Older gcc packages also have backports of retpoline support.
>
> > The packages provided in the links above are presumably for compiling in the native system.
> > Does Debian provide suitable packages for cross-compiling?
> [...]
>
> Yes, starting with stretch there are cross-compilers for x86 and arm64 
> targetting most release architectures.  They are named gcc-<major>- 
> <triplet>, e.g. gcc-8-arm-linux-gnueabihf (except that x86_64 is 
> changed to x86-64 since underscores aren't allowed in package names).
>
> Ben.
>
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.codethink.co.uk%2F&amp;data=02%7C01%7Cyasin.demirci%40siemens.com%7Cce7f021bcba74953d9a908d7212b6575%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637014342590931622&amp;sdata=EWVK36tc%2FQ3F5czxC%2Fbt8uC28Ej0zptuBBLDcjOIe8g%3D&amp;reserved=0                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United 
> Kingdom
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.cip-project.org%2Fmailman%2Flistinfo%2Fcip-dev&amp;data=02%7C01%7Cya
> sin.demirci%40siemens.com%7Cce7f021bcba74953d9a908d7212b6575%7C38ae3bc
> d95794fd4addab42e1495d55a%7C1%7C0%7C637014342590931622&amp;sdata=RKknv
> i5KP616jx33TDg4NpK3RhHSOr4k1wJeFR%2FTZKM%3D&amp;reserved=0
_______________________________________________
Cip-security mailing list
Cip-security at lists.cip-project.org
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.cip-project.org%2Fmailman%2Flistinfo%2Fcip-security&amp;data=02%7C01%7Cyasin.demirci%40siemens.com%7Cce7f021bcba74953d9a908d7212b6575%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637014342590931622&amp;sdata=MqI70UA3fjV33uZIU7cZZKzCby0r5I6HUZZqmd%2FvfDc%3D&amp;reserved=0
