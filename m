Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76892C3ABB6
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 07:02:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2531.1746601350458030177
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 May 2025 00:02:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=C7qVfrKO;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0987410382D36;
	Wed,  7 May 2025 09:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746601348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uczd/kAlt5fYmWZv9YMNqdRkMpgwvFqMjPAPlAQQPv4=;
	b=C7qVfrKOV5feVPxerI0sEDDbfebnriXBvZU06vRq6dafV/Pva9bHjB8nTKNPghhn9dkFbm
	gdcBKY8eejD11OV9HKjGD/EG3KICXLC3Q0tVyCCqbKKFyCzloLvp/Wdk6V2SR1JHQuaWBc
	9umYkiz7PDp14N41IaJHxADGBQkIEukcz0ctnHMxPRFH7DL1BnVFn7I2y2LTlAjAIHaiO1
	Hl3/KO9cLazaeDOhGxd9C98/CiUNh8wm1HLuiS4jLDkgaB0b75+NwOGacslJoHqA/8qIVH
	tyQ41YkYLU6/4f0aTZTDfxTxevmUFuv44VB9d7TnX05hDmTf3+qyeYTx+OPjvA==
Date: Wed, 7 May 2025 09:02:21 +0200
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Message-ID: <aBsFfQm2iBM6kIBD@duo.ucw.cz>
References: <1833151A32081021.4816@lists.cip-project.org>
 <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3i8DRLH/TfFswSGP"
Content-Disposition: inline
In-Reply-To: <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 May 2025 07:02:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18772


--3i8DRLH/TfFswSGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> >=20
> > commit 379c590113ce46f605439d4887996c60ab8820cc upstream.
> >=20
> > When the addresses of the shmobile_smp_mpidr, shmobile_smp_fn, and
> > shmobile_smp_arg variables are not multiples of 4 bytes, secondary CPU
> > bring-up fails:
> >=20
> >     smp: Bringing up secondary CPUs ...
> >     CPU1: failed to come online
> >     CPU2: failed to come online
> >     CPU3: failed to come online
> >     smp: Brought up 1 node, 1 CPU
> >=20
> > Fix this by adding the missing alignment directive.
> >=20
> > Fixes: 4e960f52fce16a3b ("ARM: shmobile: Move shmobile_smp_{mpidr, fn,
> > arg}[] from .text to .bss")
> > Closes: https://lore.kernel.org/r/CAMuHMdU=3DQR-JLgEHKWpsr6SbaZRc-
> > Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Link:
> > https://lore.kernel.org/c499234d559a0d95ad9472883e46077311051cd8.174161=
220
> > 8.git.geert+renesas@glider.be
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi All,
> >=20
> > Note:
> > - This issue has been replicated on 4.4-cip with older compilers and
> > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE enabled.
> > - The offending commit 4e960f52fce16a3b is not present in v4.4 release =
so
> > this patch wont be backported into 4.4-cip by stable hence just sending
> > this for 4.4-cip only. Please note this patch has been cherry-picked v6=
=2E14
> > release.
> >
> Gentle ping for review.

I could not find traces of the email in my mail archives. Strange.

Anyway, adding alignment is unlikely to hurt anything, and patch looks
ok to me.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3i8DRLH/TfFswSGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBsFfQAKCRAw5/Bqldv6
8ma0AJ9QWmaRDXfgv1/6fNX0osgo9Q2/qACgwaZaFuCzBtqTJ0XZZT5BOF6EdaU=
=GF6D
-----END PGP SIGNATURE-----

--3i8DRLH/TfFswSGP--

