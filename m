Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38C0EB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 20:07:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2650.1688501226940453990
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 13:07:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DBFAD1C0DFD; Tue,  4 Jul 2023 22:07:02 +0200 (CEST)
Date: Tue, 4 Jul 2023 22:07:02 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/3] RZ/V2M I2C driver improvements
Message-ID: <ZKR75gaHVmf59H9/@duo.ucw.cz>
References: <20230630155118.584293-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420A3CB3F831F9DB6FE51CD922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkHF/+AsezNb5Gxm"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420A3CB3F831F9DB6FE51CD922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 20:07:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12218


--VkHF/+AsezNb5Gxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to improve RZ/V2M I2C driver, based on the feedb=
ack
> > from Pavel.

> I reviewed this series. Looks fine to me.
> I can apply, if there are no other comments and issues.
>=20
> Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/919=
943145
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Looks good to me, too.

Reviewed-by: Pavel Machek <pavel@denx.de>

Thank you,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VkHF/+AsezNb5Gxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKR75gAKCRAw5/Bqldv6
8ueoAJ91iVWUaSZFfCqSxAmgFAy6wsVq1ACeNHL7huXs9X/PRuKAGFnXjwh+W2M=
=UGm6
-----END PGP SIGNATURE-----

--VkHF/+AsezNb5Gxm--

