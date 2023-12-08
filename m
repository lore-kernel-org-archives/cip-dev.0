Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C69C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 11:38:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.29063.1702035515730911776
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 03:38:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A22471C0080; Fri,  8 Dec 2023 12:38:32 +0100 (CET)
Date: Fri, 8 Dec 2023 12:38:32 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
Message-ID: <ZXMAOPmuU1J+JCtw@duo.ucw.cz>
References: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KvMnWqh686X2TNUS"
Content-Disposition: inline
In-Reply-To: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 11:38:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13935


--KvMnWqh686X2TNUS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add RZ/G2L DSI support on
> RZ/{G2L,GLC,V2L} SMARC EVKs.
> =20
> All the patches are cherry-picked from the mainline, except [1] and [2]
>=20
> Without [1] DU is giving probe failure as the encoder is not
> able to find all the connected bridges due to the framework changes
> between mainline and 5.10 kernel. So just restructured the bridge handlin=
g.
>=20
> IA55 IRQ driver is not backported to 5.10, so defining it in dts is
> giving warnings, so drop IRQs in patch[2].

This series fails testing on x86:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/5706662029

  CC      drivers/hid/hid-lg4ff.o
3346In file included from drivers/gpu/drm/drm_bridge_connector.c:11:
3347./include/drm/drm_bridge.h:903:34: error: static declaration of 'devm_d=
rm_of_get_bridge' follows non-static declaration
3348  903 | static inline struct drm_bridge *devm_drm_of_get_bridge(struct =
device *dev,
3349      |                                  ^~~~~~~~~~~~~~~~~~~~~~
3350./include/drm/drm_bridge.h:894:20: note: previous declaration of 'devm_=
drm_of_get_bridge' was here
3351  894 | struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, s=
truct device_node *node,
3352      |                    ^~~~~~~~~~~~~~~~~~~~~~
3353  CC      drivers/hid/hid-lg-g15.o
3354make[3]: *** [scripts/Makefile.build:286: drivers/gpu/drm/drm_bridge_co=
nnector.o] Error 1
3355make[3]: *** Waiting for unfinished jobs....
3356  CC      drivers/hid/hid-microsoft.o
3357

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KvMnWqh686X2TNUS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXMAOAAKCRAw5/Bqldv6
8kUWAJ4lNUab4JX+FokpRtlZ8Dp254mRzACcC6kwh/hqxnNA4zctEOpfQTbrtMc=
=6c7y
-----END PGP SIGNATURE-----

--KvMnWqh686X2TNUS--

