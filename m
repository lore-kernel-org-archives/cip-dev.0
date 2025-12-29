Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8CE92FDE
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 20:58:05 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51372.1767041877949354670
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 12:57:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=HTgxbdE4;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD5D110092128;
	Mon, 29 Dec 2025 21:57:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1767041875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XpXc+DLQxkCnTJcGlENHi42NRIKsoKqLT/vji9NgpWQ=;
	b=HTgxbdE4VbqhmmBsYWGcuvUsEhaY+Z3N2FbXhItnVqYJsZdocJs2f2iAk1W2cAXciut81l
	GSCXH46vRm4TugmTg4qTTQL7XUTmJ2oUSyjx82bXWTRFlP2Co2GZ9rH6QwCGbKlgvl357D
	NziurCeMuIwlUfb2VFiKKYthk3wBaSE+2V5asmN9ZJ2wsSygzXiHmQmM4VXC4fuEBYc25o
	8MZ/f4rOa5IHRhxlH0eNg02j6uUmrb13OtVyZltEo+10gvITI22YxqdEQTPhyv3Zxc+BIC
	6vXmF2USs+YQP+DAJ9sBEy0WDv8fsaFKvcrjvWW3wuoOPpnJ833b3JtxGYtxzA==
Date: Mon, 29 Dec 2025 21:57:50 +0100
From: Pavel Machek <pavel@denx.de>
To: biju.das.jz@bp.renesas.com
Cc: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"biju.das.au" <biju.das.au@gmail.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 4/5] arm64: dts: renesas:
 r9a09g047e57-smarc: Add gpio keys
Message-ID: <aVLrTt0DmgE2fubv@duo.ucw.cz>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
 <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
 <TY7PR01MB1481814158E5E8E076C44B8DFCDB2A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134650A811981E9B7EBCC1CD86B2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="diu6ZVfwIQs/tUUx"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134650A811981E9B7EBCC1CD86B2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 20:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21253


--diu6ZVfwIQs/tUUx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > [ Upstram commit 9e95446b0cf93a91bc3b3b64c6d423f4024a6ff0 ]
> > >
> > > RZ/G3E SMARC EVK  has 3 user buttons called USER_SW1, USER_SW2 and
> > > USER_SW3 and SLEEP button with NMI support. Add a DT node in device
> > > tree to instantiate the gpio-keys driver for these buttons.
> > >
> > > The system can enter into STR state by pressing the sleep button and
> > > wakeup from STR is done by pressing power button. The USER_SW{1,2,3}
> > > configured as wakeup-source, so it can wakeup the system during s2idl=
e.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Link:
> > > https://lore.kernel.org/20250702092755.70847-1-biju.das.jz@bp.renesas.
> > > com
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > [Biju: Squashed the commit 3e5df910b592d4 ("arm64: dts: renesas:
> > > r9a09g047e57-smarc: Fix gpio key's pin control node"]
> >=20
> > Why did you need to squash the commit?
>=20
> Previously Pavel mentioned to squash fixes patches like this
> So that cip-kenel have clean functional patch.

I'm not sure if I would request the squash here; I guess both options
would be okay here.

Best regards,
								Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--diu6ZVfwIQs/tUUx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVLrTgAKCRAw5/Bqldv6
8sI5AKC3aog+sIFJf7d7IpN2OEfqPjrYPwCfTa37CCSKgE/0N9E6GXnx+UDF4pI=
=2Qit
-----END PGP SIGNATURE-----

--diu6ZVfwIQs/tUUx--

