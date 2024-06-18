Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A61C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:49:01 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.81218.1718696937923385456
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 00:48:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D30BE1C0082; Tue, 18 Jun 2024 09:48:51 +0200 (CEST)
Date: Tue, 18 Jun 2024 09:48:51 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/8] Add Display support for SMARC
 RZ/{G2L,G2LC,V2L}
Message-ID: <ZnE746hhan6CPZUu@duo.ucw.cz>
References: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB6388AE7E377B73FA6D232BAF92CE2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kmTFJ7IdeCYmOY5c"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388AE7E377B73FA6D232BAF92CE2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 07:49:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16280


--kmTFJ7IdeCYmOY5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Adapted header files/KConfig changes for 6.1 kernel in patch#4
> > (0004-drm-renesas-Add-RZ-G2L-DU-Support.patch)
> > similar to rcar_du and shmobile drm drivers.
> >=20
> > Biju Das (8):
> >   drm: Place Renesas drivers in a separate dir
> >   dt-bindings: display: Document Renesas RZ/G2L DU bindings
> >   dt-bindings: display: renesas,rzg2l-du: Document RZ/V2L DU bindings
> >   drm: renesas: Add RZ/G2L DU Support
> >   arm64: dts: renesas: r9a07g044: Add DU node
> >   arm64: dts: renesas: r9a07g054: Add DU node
> >   arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
> >   arm64: defconfig: Enable Renesas RZ/G2L display unit DRM driver
>=20
> I reviewed this series, I don=E2=80=99t have any comment.
> So, I can apppy this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, I added your reviewed-by tag and applied the
series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kmTFJ7IdeCYmOY5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnE74wAKCRAw5/Bqldv6
8gutAKCmyUS+3/zRmqAFCp8eSxRjfmklOwCgov2+aUJdpQjFH5Vzg1f12iZAyD8=
=I3mi
-----END PGP SIGNATURE-----

--kmTFJ7IdeCYmOY5c--

