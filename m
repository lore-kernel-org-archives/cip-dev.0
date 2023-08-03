Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB66EC001DF
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 08:12:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9556.1691050365547452361
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Aug 2023 01:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 16C311C0A9A; Thu,  3 Aug 2023 10:12:42 +0200 (CEST)
Date: Thu, 3 Aug 2023 10:12:41 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip] tty: serial: sh-sci: Fix sleeping in atomic
 context
Message-ID: <ZMtheQLIQUHJwhS2@duo.ucw.cz>
References: <20230802141919.474558-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942035A7B11C466B09ADF4C99208A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="caMZtou1BjquZJRH"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB942035A7B11C466B09ADF4C99208A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 08:12:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12544


--caMZtou1BjquZJRH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Fix sleeping in atomic context warning as reported by the Smatch static
> > checker tool by replacing disable_irq->disable_irq_nosync.
> >=20
> > Reported by: Dan Carpenter <dan.carpenter@linaro.org>

> LGTM. I can apply if there are no comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Looks good to me, too (both 5.10 and 6.1). Go ahead!

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--caMZtou1BjquZJRH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZMtheQAKCRAw5/Bqldv6
8kNAAJwOo8qGP6DElGZKIK7xDIRl6y/lOwCfdpwJrGUmSGl2NQKP3B+S70EkPJE=
=H/UY
-----END PGP SIGNATURE-----

--caMZtou1BjquZJRH--

