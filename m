Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FB0C4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 08:00:44 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8851.1714118435207394917
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Apr 2024 01:00:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5418D1C0080; Fri, 26 Apr 2024 10:00:32 +0200 (CEST)
Date: Fri, 26 Apr 2024 10:00:31 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Out-of-order CPUs leak secrets
Message-ID: <ZitfH2agERiqT1I6@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5spY/VMj+bpiFl8a"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Apr 2024 08:00:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15771


--5spY/VMj+bpiFl8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

If you are doing something security-sensitive, and untrusted people
have easy access to your CPU, well, there's a problem. Or, more
accurately, there's ton of problems, there are various workarounds,
but problems still remain.

Intel says on their website "No product or component can be absolutely
secure.". I'd translate it as "performance is more important than
security for us".

Here's list of recent CVEs. If you have affected Atom hardware and
would like to run 4.19 or older, or are using any non-ancient x86 with
5.10 or older, let us know. Or maybe just talk to the vendor and ask
for your money back :-).

Best regards,
								Pavel

* CVE-2023-28746 Intel Atom FPregs information leak
  		 "reg file data sampling".

Information exposure through microarchitectural state after transient
execution from some register files for some Intel(R) Atom(R)
Processors may allow an authenticated user to potentially enable
information disclosure via local access.

Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst

   Common name          Family_Model
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
   ATOM_GOLDMONT           06_5CH
   ATOM_GOLDMONT_D         06_5FH
   ATOM_GOLDMONT_PLUS      06_7AH
   ATOM_TREMONT_D          06_86H
   ATOM_TREMONT            06_96H
   ALDERLAKE               06_97H
   ALDERLAKE_L             06_9AH
   ATOM_TREMONT_L          06_9CH
   RAPTORLAKE              06_B7H
   RAPTORLAKE_P            06_BAH
   ATOM_GRACEMONT          06_BEH
   RAPTORLAKE_S            06_BFH
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

--

Primary, workaround is in firmware, in form of new microcode support,
overloading VERW instruction.

-stable-5.10 has the backports adding VERW, getting them to 4.19 will
not be easy:

91cf85f75375359b73cd78a47cf1d6d50ec5e4b8 KVM/x86: Export RFDS_NO and RFDS_C=
LEAR to guests
66d5260fc7d5adb115c97f0e011ee13c0caa8ea6 x86/rfds: Mitigate Register File D=
ata Sampling (RFDS)
6e04cae36b8f52c81cbcafdb8f198d80739943f1 x86/mmio: Disable KVM mitigation w=
hen X86_FEATURE_CLEAR_CPU_BUF is set
b9a97767c6be8a5e746609da7cbb4f63b42b0622 KVM/VMX: Move VERW closer to VMent=
ry for MDS mitigation
52aad34ee36fa1f02fc1eacff51a8f695ead7fe8 KVM/VMX: Use BT+JNC, i.e. EFLAGS.C=
F to select VMRESUME vs. VMLAUNCH
6192d9ed311f70eb7e8ab4a874631a98c5a9217e x86/bugs: Use ALTERNATIVE() instea=
d of mds_user_clear static key
50f021f0b985629accf10481a6e89af8b9700583 x86/entry_32: Add VERW just before=
 userspace transition
edc702b4a820fc7ffc20e732db1c421cfffbb746 x86/entry_64: Add VERW just before=
 userspace transition
35e36eac881cddea42ca5fd93facc145a2d5369d x86/bugs: Add asm helpers for exec=
uting VERW
8b20c6f894b7d7d87d3aa1a85cbc7d57378e1346 x86/asm: Add _ASM_RIP() macro for =
x86-64 (%rip) suffix

* CVE-2024-2201 "branch history injection"
  "spectre BHI"

https://lwn.net/Articles/969210/
https://thehackernews.com/2024/04/researchers-uncover-first-native.html

-stable-6.1 has the backports, getting them to 5.10 does not look trivial

69129794d94c544810e68b2b4eaa7e44063f9bf2 -- x86/bugs: Fix BHI retpoline che=
ck

7390db8aea0d64e9deb28b8e1ce716f5020c7ee5 -- x86/bhi: Add support for cleari=
ng branch history at syscall entry
ec9404e40e8f36421a2b66ecb76dc2209fe7f3ef -- x86/bhi: Add BHI mitigation knob

69129794d94c544810e68b2b4eaa7e44063f9bf2    x86/bugs: Fix BHI retpoline che=
ck
5f882f3b0a8bf0788d5a0ee44b1191de5319bb8a    x86/bugs: Clarify that syscall =
hardening isn't a BHI mitigation
1cea8a280dfd1016148a3820676f2f03e3f5b898    x86/bugs: Fix BHI handling of R=
RSBA
cb2db5bb04d7f778fbc1a1ea2507aab436f1bff3    x86/bugs: Cache the value of MS=
R_IA32_ARCH_CAPABILITIES
dfe648903f42296866d79f10d03f8c85c9dfba30    x86/bugs: Fix BHI documentation
04f4230e2f86a4e961ea5466eda3db8c1762004d    x86/bugs: Fix return type of sp=
ectre_bhi_state()

ed2e8d49b54d677f3123668a21a57822d679651f      KVM: x86: Add BHI_NO
95a6ccbdc7199a14b71ad8901cb788ba7fb5167b      x86/bhi: Mitigate KVM by defa=
ult
ec9404e40e8f36421a2b66ecb76dc2209fe7f3ef      x86/bhi: Add BHI mitigation k=
nob
be482ff9500999f56093738f9219bbabc729d163      x86/bhi: Enumerate Branch His=
tory Injection (BHI) bug
0f4a837615ff925ba62648d280a861adf1582df7      x86/bhi: Define SPEC_CTRL_BHI=
_DIS_S
7390db8aea0d64e9deb28b8e1ce716f5020c7ee5      x86/bhi: Add support for clea=
ring branch history at syscall entry
1e3ad78334a69b36e107232e337f9d693dcc9df2      x86/syscall: Don't force use =
of indirect calls for system calls
0cd01ac5dcb1e18eb18df0f0d05b5de76522a437      x86/bugs: Change commas to se=
micolons in 'spectre_v2' sysfs file

* CVE-2024-2193 Speculative Race Condition (SRC)
      GhostRace

https://nvd.nist.gov/vuln/detail/CVE-2024-2193
https://download.vusec.net/papers/ghostrace_sec24.pdf

This is problem all over the kernel. Patch below makes it harder to
exploit, but is not a real fix. This patch is present in -stable-4.19.

944d5fe50f3f03daacfea16300e656a1691c4a23 Subject: sched/membarrier: reduce =
the ability to hammer on sys_membarrier

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5spY/VMj+bpiFl8a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZitfHwAKCRAw5/Bqldv6
8pTbAJ9OvOJqQVgPsIKzZrzZhOuPoU8DvwCgkTOLM2o0oNAcweiXkTwokhjCxvY=
=3D9T
-----END PGP SIGNATURE-----

--5spY/VMj+bpiFl8a--

