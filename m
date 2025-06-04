Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13CC5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 19:32:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.25741.1749065557752540308
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 12:32:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=BU7dBnKw;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D579910397298;
	Wed,  4 Jun 2025 21:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749065555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UGVuYa2nZWPYDmEGCfaB4yDyr1J5wft5X7UxLZjw82k=;
	b=BU7dBnKwXdWFZ7j10ZLbWRGd2/vgauJVmc7mAsYA6In11lPDHI5AlxPoGBuxTJOOttglML
	24XifdjtGPRgk/Rn4UYRD9ZXuGYEGOPLwta3DsW4n4qP+zfXbSg06NLdYVsc4BDCnB4U7Z
	B4xWXiNv/xKU1CSUvh7B3KWMkpFM3sLvgdTNMy6URxCixxiD/DiFtl8fmG0a9p+oNbEv6x
	5EH4dT+JlmuUhCbEmvC+wxkznv88YSxmfj0hl2ZqMZN8eRcWWXVaXkCKYlTkhYeXeRUhzR
	v7vSryte/KCSmDI+TxDjzkVUiitSMqbzjexSh6/STBetnK8okEBZ9L+kHlF+gA==
Date: Wed, 4 Jun 2025 21:32:29 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
Message-ID: <aECfTblonQThFl+1@duo.ucw.cz>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818FD9A1E03EE9BF60F7EF1926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b9dpDdIEViMWJwFx"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818FD9A1E03EE9BF60F7EF1926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 19:32:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19015


--b9dpDdIEViMWJwFx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 21 +++-
> >  drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
> >  drivers/tty/serial/sh-sci.c                   | 96
> > ++++++++++++++++++-
> >  7 files changed, 300 insertions(+), 27 deletions(-)  create mode 100644
> > arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi
> >  create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
>=20
> I reviewed this series, looks good to me.
> I can apply this, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--b9dpDdIEViMWJwFx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaECfTQAKCRAw5/Bqldv6
8imsAJ0SrUyd7Z9qHksK1jE2XwnvqfvcWgCfe4/JXmSpSHb4Qpobh7DXDrCokYw=
=6vdh
-----END PGP SIGNATURE-----

--b9dpDdIEViMWJwFx--

