Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE4CC48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 17:17:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.27097.1707239853586852084
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 09:17:33 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DD3761C0076; Tue,  6 Feb 2024 18:17:31 +0100 (CET)
Date: Tue, 6 Feb 2024 18:17:31 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 4.19.y-cip 0/2] Drop undocumented register definitions
Message-ID: <ZcJpq5oVynB3XtS/@duo.ucw.cz>
References: <20240202103200.171406-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB638896E67835B158BC93D8C592422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+ZMkrZFUG02Xh8hR"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB638896E67835B158BC93D8C592422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 17:17:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14831


--+ZMkrZFUG02Xh8hR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to remove undocumented register definitions on t=
he
> > ethernet driver (ravb.h) in 4.19 cip kernel.
> >=20
> > All the patches are cherry-picked from the mainline.
> >=20
> > Sergey Shtylyov (1):
> >   ravb: update "undocumented" annotations
> >=20
> > Simon Horman (1):
> >   ravb: remove undocumented endianness selection
> >=20
> >  drivers/net/ethernet/renesas/ravb.h      | 27
> > ++++++++++++------------
> >  drivers/net/ethernet/renesas/ravb_main.c |  6 ------
> >  2 files changed, 13 insertions(+), 20 deletions(-)
>=20
> I reviewed this series. I can apply this series, if we have no other comm=
ent.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, I added the tag and pushed the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+ZMkrZFUG02Xh8hR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcJpqwAKCRAw5/Bqldv6
8vN7AJ0VqSafTYI3Ai1ZuZwnLgGcZMT5TACfQKcXsHsFFs/3SN7NL/KKpLkpIIk=
=G0h+
-----END PGP SIGNATURE-----

--+ZMkrZFUG02Xh8hR--

