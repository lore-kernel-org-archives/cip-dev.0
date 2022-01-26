Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E64C433EF
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 22:05:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.20403.1643234729820870590
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 14:05:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EF3681C0B98; Wed, 26 Jan 2022 23:05:24 +0100 (CET)
Date: Wed, 26 Jan 2022 23:05:24 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Message-ID: <20220126220524.GA26019@duo.ucw.cz>
References: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB625274BC4EFFA92D99EF211792209@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: 
 <TYAPR01MB625274BC4EFFA92D99EF211792209@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 22:05:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7491


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > make sure we free CAN network device
> >=20
> > commit 72b1e360572f9fa7d08ee554f1da29abce23f288 upstream.
> >=20
> > Make sure we free CAN network device in the error path. There are sever=
al
> > jumps to fail label after allocating the CAN network device successfull=
y. This
> > patch places the free_candev() under fail label so that in failure path=
 a jump to
> > fail label frees the CAN network device.
> >=20
> > Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
> > Link:
> > https://lore.kernel.org/all/20220106114801.20563-1-prabhakar.mahadev-la=
d.r
> > j@bp.renesas.com
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Kieran Bingham
> > <kieran.bingham+renesas@ideasonboard.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/net/can/rcar/rcar_canfd.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> LGTM.
> If there is no other opinion, I can apply this.
>   Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/4571230=
34

Looks good to me, go ahead :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYfHFpAAKCRAw5/Bqldv6
8pD8AJ495YWz1OEyvk9sZFBmvsTgfp5JuACeJmoXzr65tQCNbEC5Kitlv1ABq8U=
=gKUl
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

