Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1154EB64DB
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 08:35:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.13437.1686818105499903938
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jun 2023 01:35:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 44B321C0E65; Thu, 15 Jun 2023 10:35:03 +0200 (CEST)
Date: Thu, 15 Jun 2023 10:35:02 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/7] RZ/V2M UART FIFO support
Message-ID: <ZIrNNmmu+Dv/6SUh@duo.ucw.cz>
References: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
 <TYCPR01MB9418B4EB28AF68095D5979B7925AA@TYCPR01MB9418.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d3f02+Yuni6Zj+w0"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB9418B4EB28AF68095D5979B7925AA@TYCPR01MB9418.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 08:35:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12043


--d3f02+Yuni6Zj+w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series. Looks fine to me.
> I can apply, if there are no other comments and issues.
>=20
> Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/899=
103569
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, I added your reviewed-by tag and applied the
series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--d3f02+Yuni6Zj+w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIrNNgAKCRAw5/Bqldv6
8vf8AJ47357boGVziVDJ48pytMTOVeqycQCfdgAL+9WiQla3fNP1ezt7S8FfbRo=
=GHs0
-----END PGP SIGNATURE-----

--d3f02+Yuni6Zj+w0--

