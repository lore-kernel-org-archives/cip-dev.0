Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8676D1BDE7
	for <webhook@archiver.kernel.org>; Mon,  4 Nov 2024 19:05:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3851.1730747127879925990
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Nov 2024 11:05:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 58BB11C006B; Mon,  4 Nov 2024 20:05:25 +0100 (CET)
Date: Mon, 4 Nov 2024 20:05:24 +0100
From: Pavel Machek <pavel@denx.de>
To: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/2] media: platform: rzg2l-cru:
 Trivial code cleanup
Message-ID: <Zyka9IsjXqc8SDsf@duo.ucw.cz>
References: <20241101141538.34849-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CACe6DC4g=YwAi9OK3Z0DMQ4HfYQ3+j7dB9BvQMzULmB19P3qtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oXjOsTolHmCPJvGa"
Content-Disposition: inline
In-Reply-To: <CACe6DC4g=YwAi9OK3Z0DMQ4HfYQ3+j7dB9BvQMzULmB19P3qtg@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Nov 2024 19:05:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17168


--oXjOsTolHmCPJvGa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > This patch series aims to fix trivial code changes to RZ/G2L CRU driver.
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (1):
> >   media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in
> >     parentheses
> >
> > Yang Li (1):
> >   media: rzg2l-cru: Remove unneeded semicolon
>=20
> I revewed this series,  looks good to me.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oXjOsTolHmCPJvGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZyka9AAKCRAw5/Bqldv6
8tHIAJ9xT6SS47FFtN4uLWH+dnPobYrVvwCfR/blUTHe9CZi77H1E1RK6XdwKI4=
=vH8Y
-----END PGP SIGNATURE-----

--oXjOsTolHmCPJvGa--

