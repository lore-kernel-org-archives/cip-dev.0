Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B651C433EF
	for <webhook@archiver.kernel.org>; Tue, 14 Jun 2022 10:14:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.4371.1655201638031806047
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jun 2022 03:13:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A45081C0BB5; Tue, 14 Jun 2022 12:13:53 +0200 (CEST)
Date: Tue, 14 Jun 2022 12:13:53 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] 4.4 backports -- x86 speculation
Message-ID: <20220614101353.GA20387@duo.ucw.cz>
References: <1346806064.1124697.1649068981110@webmail.strato.com>
 <20220404112733.GA9863@duo.ucw.cz>
 <971433328.1146259.1649072970767@webmail.strato.com>
 <86774150.3004766.1651578900027@webmail.strato.com>
 <20220503130137.GA12566@duo.ucw.cz>
 <1032096920.483689.1652714463015@webmail.strato.com>
 <20220517091848.GA29900@duo.ucw.cz>
 <1414117524.1401631.1654239722410@webmail.strato.com>
 <1772872442.3583605.1654764609414@webmail.strato.com>
 <16F8276E2E3F8D91.11238@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <16F8276E2E3F8D91.11238@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jun 2022 10:14:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8555


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > And possibly these?
> > > >=20
> > > >     4.9.306: speculation fixes, mostly x86 + 7833a9b54
> > > >=20
> > > > ** !M | 890fb470c 0cbb76 o  | x86/speculation: Add RETPOLINE_AMD su=
pport to the inline asm CALL_NOSPEC vari$
> > > > ** !M | 3dd518cb6 4cd24d o  | x86/retpoline: Make CONFIG_RETPOLINE =
depend on compiler support...
> > > > ** !M | 376afe749 ef014a o  | x86/retpoline: Remove minimal retpoli=
ne support...
> > > > **   | e6291bd93 6e8855 .  | Documentation: Add section about CPU v=
ulnerabilities for Spectre...
> > > > **   | 8e08ef80a 4c9205 .  | Documentation: Add swapgs description =
to the Spectre v1 documentation...
> > > > **   | cdba32608 82ca67 .+ | Documentation: refer to config RANDOMI=
ZE_BASE for kernel address-space randomi$
> > > > ** a | 71d79539a a5ce9f o  | x86/speculation: Merge one test in spe=
ctre_v2_user_select_mitigation()
> > > > ** a | a90155024 f8a66d o  | x86,bugs: Unconditionally allow spectr=
e_v2=3Dretpoline,amd
> > > > **   | a771511ca d45476 o  | x86/speculation: Rename RETPOLINE_AMD =
to RETPOLINE_LFENCE...
> > > > **   | d0ba50275 1e19da o  | x86/speculation: Add eIBRS + Retpoline=
 options
> > > > **   | f9238d337 5ad3eb .  | Documentation/hw-vuln: Update spectre =
doc
> > > > **   | 6481835a9 44a391 o  | x86/speculation: Include unprivileged =
eBPF status in Spectre v2 mitigation rep$
> > > > **   | b6a1aec08 244d00 o  | x86/speculation: Use generic retpoline=
 by default on AMD
> > > > **   | 0db1c4307 e9b601 .  | x86/speculation: Update link to AMD sp=
eculation whitepaper
> > > > **   | 8edabefdc eafd98 o  | x86/speculation: Warn about Spectre v2=
 LFENCE mitigation
> > > > **   | 075376018 0de05d o  | x86/speculation: Warn about eIBRS + LF=
ENCE + Unprivileged eBPF + SMT
> > > > ** !!a | 10b908aab 541625 o  | arm/arm64: Provide a wrapper for SMC=
CC 1.1 calls...
> >=20
> > I have backported all of these; see the attached
> > tarball. Compile-tested only.
>=20
> Thanks for the tarball.
>=20
> 0001-ptrace-Check-PTRACE_O_SUSPEND_SECCOMP-permission-on-.patch
> 0002-xen-blkfront-don-t-use-gnttab_query_foreign_access-f.patch
> 0003-x86-modpost-Replace-last-remnants-of-RETPOLINE-with-.patch
>=20
> I already had these from the last round.
>=20
> 0004-arm-arm64-smccc-psci-add-arm_smccc_1_1_get_conduit.patch
>=20
> I'll take this, but I'll need to recheck the context.
>=20
> 0005-x86-speculation-Add-RETPOLINE_AMD-support-to-the-inl.patch
> 0006-x86-retpoline-Make-CONFIG_RETPOLINE-depend-on-compil.patch
> 0007-x86-retpoline-Remove-minimal-retpoline-support.patch
> 0008-Documentation-Add-section-about-CPU-vulnerabilities-.patch
> 0009-Documentation-Add-swapgs-description-to-the-Spectre-.patch
> 0010-Documentation-refer-to-config-RANDOMIZE_BASE-for-ker.patch
> 0011-x86-speculation-Rename-RETPOLINE_AMD-to-RETPOLINE_LF.patch
> 0012-x86-speculation-Add-eIBRS-Retpoline-options.patch
> 0013-Documentation-hw-vuln-Update-spectre-doc.patch
> 0014-x86-speculation-Include-unprivileged-eBPF-status-in-.patch
> 0015-x86-speculation-Use-generic-retpoline-by-default-on-.patch
> 0016-x86-speculation-Update-link-to-AMD-speculation-white.patch
> 0017-x86-speculation-Warn-about-Spectre-v2-LFENCE-mitigat.patch
> 0018-x86-speculation-Warn-about-eIBRS-LFENCE-Unprivileged.patch
>=20
> Applied to -st-rc branch. Let me attempt to do some basic testing.

With all the patches applied, I get this:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2581576742

  LD      arch/x86/platform/intel-mid/built-in.o
1704  CC      arch/x86/platform/efi/efi.o
1705  CC      kernel/cpu.o
1706  CC      mm/mempool.o
1707In file included from ./arch/x86/include/asm/bitops.h:16,
1708                 from include/linux/bitops.h:18,
1709                 from include/linux/kernel.h:10,
1710                 from include/linux/list.h:8,
1711                 from include/linux/module.h:9,
1712                 from arch/x86/kernel/irq_32.c:11:
1713arch/x86/kernel/irq_32.c: In function 'call_on_stack':
1714./arch/x86/include/asm/nospec-branch.h:154:9: error: expected ':' or ')=
' before 'ANNOTATE_RETPOLINE_SAFE'
1715  154 |         ANNOTATE_RETPOLINE_SAFE                                =
 \
1716      |         ^~~~~~~~~~~~~~~~~~~~~~~
1717./arch/x86/include/asm/alternative.h:119:20: note: in definition of mac=
ro 'OLDINSTR_2'
1718  119 |         "661:\n\t" oldinstr "\n662:\n"                         =
                                 \
1719      |                    ^~~~~~~~
1720./arch/x86/include/asm/nospec-branch.h:153:9: note: in expansion of mac=
ro 'ALTERNATIVE_2'
1721  153 |         ALTERNATIVE_2(                                         =
 \
1722      |         ^~~~~~~~~~~~~
1723arch/x86/kernel/irq_32.c:59:22: note: in expansion of macro 'CALL_NOSPE=
C'
1724   59 |                      CALL_NOSPEC
1725      |                      ^~~~~~~~~~~
1726

Let me try to reorder patches and see which one introduces it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYqhfYQAKCRAw5/Bqldv6
8tHAAJ0RqmQ4ib2zRgZzpYx9O++zyI3yiQCgr30uCLl6QtgsLsmPnmtv/DRDHMg=
=tHra
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

