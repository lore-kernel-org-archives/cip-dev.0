Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8882FC3DA60
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 10:57:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12568.1721300227989118725
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 03:57:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9E6011C0099; Thu, 18 Jul 2024 12:57:04 +0200 (CEST)
Date: Thu, 18 Jul 2024 12:57:04 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/23] Add PMIC DA9062 support
Message-ID: <Zpj1AOGTBEIYd8YB@duo.ucw.cz>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
 <OS3PR01MB639111E831D0C816B954D7C892AC2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kJcRp+hchnmCfVtf"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB639111E831D0C816B954D7C892AC2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 10:57:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16584


--kJcRp+hchnmCfVtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, looks good to me.
> I can apply this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I applied patch with your reviewed-by tag.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kJcRp+hchnmCfVtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpj1AAAKCRAw5/Bqldv6
8l3BAJsF4BnaUyth0EoQUcWc+V9GyBKTogCgqQEBFtOkqcmKtuPNx4PsAHGftAE=
=Ltrp
-----END PGP SIGNATURE-----

--kJcRp+hchnmCfVtf--

