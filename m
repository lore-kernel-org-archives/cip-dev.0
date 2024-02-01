Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6819C47DDF
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 09:48:20 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12147.1706780892857958656
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Feb 2024 01:48:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 938D51C0075; Thu,  1 Feb 2024 10:48:09 +0100 (CET)
Date: Thu, 1 Feb 2024 10:48:09 +0100
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/9] Update SSI interrupts for RZ/G2L family
 and Split out RZ/G2UL DTS/I
Message-ID: <Zbto2Rzm9tBXntaf@duo.ucw.cz>
References: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZboZqpdu5x6aEohp@duo.ucw.cz>
 <OSZPR01MB70192961567BB010EF309A57AA7C2@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <Zbool5lQpvLbXPhh@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJ9Hmy2h+qM1tM7c"
Content-Disposition: inline
In-Reply-To: <Zbool5lQpvLbXPhh@duo.ucw.cz>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 09:48:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14576


--aJ9Hmy2h+qM1tM7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I'll take more detailed look but just to be sure: do you plan to back=
port RISC-V changes to 5.10? If
> > > so, do you have some kind of WIP series, just to get an idea how big =
changes that means?
> > >=20
> > I've already posted out an RFC series [0] adding support for RZ/Five RI=
SC-V SoC to 5.10-cip.
> >=20
> > [0] https://patchwork.kernel.org/project/cip-dev/cover/20240130203346.9=
4488-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>=20
> Yep, sorry, I seen it shortly after sending the email, sorry for
> confusion.
>=20
> I went through the series. I'm okay with taking 1-4 (provided they
> pass testing and there are no other comments).

I applied patches 1-4. I propose we take the rest with the [0].

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aJ9Hmy2h+qM1tM7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbto2QAKCRAw5/Bqldv6
8jHHAKC8lzQ+IZsEGSxY7CU64JPoiREnhACbBnycw/wzTqdkmKA9LaWD5O/EStU=
=SgAl
-----END PGP SIGNATURE-----

--aJ9Hmy2h+qM1tM7c--

