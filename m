Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA585C47DB3
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 11:01:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.11498.1706698906099432783
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 03:01:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AF01A1C0079; Wed, 31 Jan 2024 12:01:43 +0100 (CET)
Date: Wed, 31 Jan 2024 12:01:43 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/9] Update SSI interrupts for RZ/G2L family
 and Split out RZ/G2UL DTS/I
Message-ID: <Zbool5lQpvLbXPhh@duo.ucw.cz>
References: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZboZqpdu5x6aEohp@duo.ucw.cz>
 <OSZPR01MB70192961567BB010EF309A57AA7C2@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOgjsLdlvgIw304a"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB70192961567BB010EF309A57AA7C2@OSZPR01MB7019.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 11:01:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14555


--qOgjsLdlvgIw304a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series does the below,
> > > - Updates SSI interrupts for RZ/G2L family
> > > - Splits up RZ/G2UL DTS/I for re-using for RZ/Five SoC
> > >
> > > Note, patch #5 has been newly added and rest of the patches have been
> > > cherry-picked from upstream kernel.
> >=20
> > I'll take more detailed look but just to be sure: do you plan to backpo=
rt RISC-V changes to 5.10? If
> > so, do you have some kind of WIP series, just to get an idea how big ch=
anges that means?
> >=20
> I've already posted out an RFC series [0] adding support for RZ/Five RISC=
-V SoC to 5.10-cip.
>=20
> [0] https://patchwork.kernel.org/project/cip-dev/cover/20240130203346.944=
88-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Yep, sorry, I seen it shortly after sending the email, sorry for
confusion.

I went through the series. I'm okay with taking 1-4 (provided they
pass testing and there are no other comments).

I'd propose taking 5-9 after we decide to take the [0]. I'll take a
short look at the series, but ultimately I believe we should talk
about 5.10 RISC-V at the IRC meeting.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qOgjsLdlvgIw304a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZboolwAKCRAw5/Bqldv6
8mpKAJ4s0yPE3nI0WlNOQfAayuYW7nZv8ACfYiU7N1MdsUvZU9fVZOhcd+NQ9co=
=mN4J
-----END PGP SIGNATURE-----

--qOgjsLdlvgIw304a--

