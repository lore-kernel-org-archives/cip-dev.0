Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22939EB8FB6
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 12:08:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.6917.1694002110282351405
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 05:08:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C31051C000B; Wed,  6 Sep 2023 14:08:28 +0200 (CEST)
Date: Wed, 6 Sep 2023 14:08:28 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	cip-dev@lists.cip-project.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/20] Add Renesas RZ/G2L DSI,VSP,FCP support
Message-ID: <ZPhrvIIlP0PXQhk+@duo.ucw.cz>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <ZPg8n16XTqWOXhMf@duo.ucw.cz>
 <TYWPR01MB9420204038AA15EE4A27B69D92EFA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TnI4OMKGDSIGTdTl"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420204038AA15EE4A27B69D92EFA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 12:08:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12988


--TnI4OMKGDSIGTdTl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series aims to add RZ/G2L DSI,VSP,FCP support
> > >
> > > All the patches are cherry-picked from the mainline except the last
> > > 6 patches.
> >=20
> > Thanks for the series. I only found tiny nits in the first 14 patches, =
and they
> > pass testing, so I can merge them if there are no other comments.
> >=20
>=20
> I reviewed this series, LGTM without last 6 patches.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review. I added your reviewed-by tag and applied/pushed the
series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TnI4OMKGDSIGTdTl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPhrvAAKCRAw5/Bqldv6
8rAlAJ9hHDMDEr3qmBuyzn3tk0gjHC5d6wCgiW+2nCLTHZDUNSbuTA3PdgTatWY=
=8n+3
-----END PGP SIGNATURE-----

--TnI4OMKGDSIGTdTl--

