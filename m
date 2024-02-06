Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40172C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 17:16:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.27072.1707239796475585121
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 09:16:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 35DB11C0076; Tue,  6 Feb 2024 18:16:33 +0100 (CET)
Date: Tue, 6 Feb 2024 18:16:32 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 4.4.y-cip 0/2] Drop undocumented register definitions
Message-ID: <ZcJpcAByGWMBTEgy@duo.ucw.cz>
References: <20240202101807.153140-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB6388993D6F46E71E12707AE292422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LATAZnWA9HcY/MEf"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388993D6F46E71E12707AE292422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 17:16:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14830


--LATAZnWA9HcY/MEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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

Thanks for review, I added your reviewed-by tag, and as it tests ok, I
pushed the series.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LATAZnWA9HcY/MEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcJpcAAKCRAw5/Bqldv6
8mOgAJ9toBKJ4ozzbVI3QRafOCHrcoD97gCbBwnefwIbRyO270Wb0+19550GARc=
=Fo8P
-----END PGP SIGNATURE-----

--LATAZnWA9HcY/MEf--

