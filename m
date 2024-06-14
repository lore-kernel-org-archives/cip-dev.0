Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11B1C27C75
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 09:29:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7522.1718357358912864965
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 02:29:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B4F621C0082; Fri, 14 Jun 2024 11:29:16 +0200 (CEST)
Date: Fri, 14 Jun 2024 11:29:16 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/7] Fix USBHS pipe configuration
Message-ID: <ZmwNbDHGqiRo43j8@duo.ucw.cz>
References: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB63889B571C233701108910F892C22@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cRGQZOvb4tNaVb02"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63889B571C233701108910F892C22@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 09:29:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16232


--cRGQZOvb4tNaVb02
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, LGTM.
> I can apppy this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, I added your reviewed-by tag and applied the
series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cRGQZOvb4tNaVb02
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmwNbAAKCRAw5/Bqldv6
8vcOAJ9S5pQU415g3i5BNYNuM7D9VQkXlwCfW517eDE0bYFTi/VMekIXITOJNyQ=
=3G0z
-----END PGP SIGNATURE-----

--cRGQZOvb4tNaVb02--

