Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4133EC43334
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 11:50:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.5652.1658836215430987004
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jul 2022 04:50:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 775FB1C000A; Tue, 26 Jul 2022 13:50:11 +0200 (CEST)
Date: Tue, 26 Jul 2022 13:50:10 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/24] RZ/G2L Fixes from mainline
Message-ID: <20220726115010.GA31613@duo.ucw.cz>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420641E3E74AABE6703758792949@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB9420641E3E74AABE6703758792949@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 11:50:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8928


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Xu Wang (1):
> >   iio: adc: rzg2l_adc: Remove unnecessary print function dev_err()
>=20
> I reviewed this series, so I don't have any pointing out.
> I can push to CIP tree.

Thank you. I already had series applied and tested, so I did the push.

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYt/U8gAKCRAw5/Bqldv6
8sUwAJ9fwpHWt3k5sU3+aPzYt9YgQ4aUQgCeP9YLMI4eSrhgD9SnkHHnOlZue5M=
=UXqC
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

