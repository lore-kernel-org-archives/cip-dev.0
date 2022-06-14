Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CD7C433EF
	for <webhook@archiver.kernel.org>; Tue, 14 Jun 2022 10:58:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4743.1655204305714444459
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jun 2022 03:58:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0FAFE1C0BB5; Tue, 14 Jun 2022 12:58:21 +0200 (CEST)
Date: Tue, 14 Jun 2022 12:58:20 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] 4.4 backports -- x86 speculation
Message-ID: <20220614105820.GB20387@duo.ucw.cz>
References: <20220404112733.GA9863@duo.ucw.cz>
 <971433328.1146259.1649072970767@webmail.strato.com>
 <86774150.3004766.1651578900027@webmail.strato.com>
 <20220503130137.GA12566@duo.ucw.cz>
 <1032096920.483689.1652714463015@webmail.strato.com>
 <20220517091848.GA29900@duo.ucw.cz>
 <1414117524.1401631.1654239722410@webmail.strato.com>
 <1772872442.3583605.1654764609414@webmail.strato.com>
 <16F8276E2E3F8D91.11238@lists.cip-project.org>
 <16F8751F2AB1EA42.18003@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <16F8751F2AB1EA42.18003@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jun 2022 10:58:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8556


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I have backported all of these; see the attached
> > > tarball. Compile-tested only.
> >=20
> > Thanks for the tarball.
> >=20
> > 0001-ptrace-Check-PTRACE_O_SUSPEND_SECCOMP-permission-on-.patch
> > 0002-xen-blkfront-don-t-use-gnttab_query_foreign_access-f.patch
> > 0003-x86-modpost-Replace-last-remnants-of-RETPOLINE-with-.patch
> >=20
> > I already had these from the last round.
> >=20
> > 0004-arm-arm64-smccc-psci-add-arm_smccc_1_1_get_conduit.patch
> >=20
> > I'll take this, but I'll need to recheck the context.
> >=20
> > 0005-x86-speculation-Add-RETPOLINE_AMD-support-to-the-inl.patch
> > 0006-x86-retpoline-Make-CONFIG_RETPOLINE-depend-on-compil.patch
> > 0007-x86-retpoline-Remove-minimal-retpoline-support.patch
> > 0008-Documentation-Add-section-about-CPU-vulnerabilities-.patch
> > 0009-Documentation-Add-swapgs-description-to-the-Spectre-.patch
> > 0010-Documentation-refer-to-config-RANDOMIZE_BASE-for-ker.patch
> > 0011-x86-speculation-Rename-RETPOLINE_AMD-to-RETPOLINE_LF.patch
> > 0012-x86-speculation-Add-eIBRS-Retpoline-options.patch
> > 0013-Documentation-hw-vuln-Update-spectre-doc.patch
> > 0014-x86-speculation-Include-unprivileged-eBPF-status-in-.patch
> > 0015-x86-speculation-Use-generic-retpoline-by-default-on-.patch
> > 0016-x86-speculation-Update-link-to-AMD-speculation-white.patch
> > 0017-x86-speculation-Warn-about-Spectre-v2-LFENCE-mitigat.patch
> > 0018-x86-speculation-Warn-about-eIBRS-LFENCE-Unprivileged.patch
> >=20
> > Applied to -st-rc branch. Let me attempt to do some basic testing.
>=20
> With all the patches applied, I get this:

My tree currently looks like this:

882867c873bbf048cd3574a3fda18742726839b8 x86/retpoline: Remove minimal retp=
oline support
5a5cafcebb8d249808b0bd63ca75642e5e1ec821 x86/retpoline: Make CONFIG_RETPOLI=
NE depend on compiler support
64bdd7860d908641beb8c2aceeb34b4ddd773024 x86/speculation: Add RETPOLINE_AMD=
 support to the inline asm CALL_NOSPEC variant
41f63e3d55265f90c76a00412252a34cd3f0142e arm/arm64: smccc/psci: add arm_smc=
cc_1_1_get_conduit()
b45151ba21854b8b38897696e163b04a7b09e204 x86, modpost: Replace last remnant=
s of RETPOLINE with CONFIG_RETPOLINE
728dc418dd6a8f3ce99f306ef52e6286aa6e13d9 xen/blkfront: don't use gnttab_que=
ry_foreign_access() for mapped status
10e10492a0474d9b57558f67cae41d2d7d7d11cf ptrace: Check PTRACE_O_SUSPEND_SEC=
COMP permission on PTRACE_SEIZE
67f46bb7179f10425f9fbf81faa81c05c1d810f4 add needed testing
5cd6adc62818c613bef3fdcf48d5c1473e617e9f (origin/linux-4.4.y-st, linux-4.4.=
y-st) Merge changes from 4.9.314.

Testing 64bdd786, that one fails, testing 41f63e3d5: that one does not
fail in the same
way. https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/563276=
264.

So it looks like 64bdd7860d908641beb8c2aceeb34b4ddd773024
x86/speculation: Add RETPOLINE_AMD support to the inline asm causes
the build problem.

I have reproduced problem locally, let me try to debug it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYqhpzAAKCRAw5/Bqldv6
8hplAJ9PSyDTBjZllTermQ++umeEGVSA9gCgsXQ7NZXo9QTqSi/6FOYFYTW9Vhs=
=12X2
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--

