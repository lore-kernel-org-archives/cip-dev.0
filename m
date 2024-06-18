Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C1EC27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:52:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.81238.1718697134271308813
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 00:52:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6135C1C0082; Tue, 18 Jun 2024 09:52:09 +0200 (CEST)
Date: Tue, 18 Jun 2024 09:52:08 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/14] Add Display support for SMARC
 RZ/{G2L,G2LC,V2L}
Message-ID: <ZnE8qB/BotcBt1l4@duo.ucw.cz>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB638836BCBA440B2E9BCABA2392CE2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="19M6WfSZpltTe6fw"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB638836BCBA440B2E9BCABA2392CE2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 07:52:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16281


--19M6WfSZpltTe6fw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add Display support for SMARC RZ/{G2L,G2LC,V2=
L}
> > EVK platforms.
> >=20
> > All the patches are cherry-picked from the mainline.

> I reviewed this series, I don=E2=80=99t have any comment.
> I can apppy this series, if there are no other comments.

Thanks for review, I added your reviewed-by tag and applied the
series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--19M6WfSZpltTe6fw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnE8qAAKCRAw5/Bqldv6
8qKMAJsG5n4X5Vmt53wDBYn80qsUZO8dxgCghHRBQIrWE5m+zyokNRoe6npWCow=
=MzsS
-----END PGP SIGNATURE-----

--19M6WfSZpltTe6fw--

