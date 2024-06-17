Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BDAC2BA15
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 11:52:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.54749.1718625133034085178
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 04:52:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8324A1C009A; Mon, 17 Jun 2024 13:52:11 +0200 (CEST)
Date: Mon, 17 Jun 2024 13:52:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/14] Add Display support for SMARC
 RZ/{G2L,G2LC,V2L}
Message-ID: <ZnAja/EbkQHrjfLL@duo.ucw.cz>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nlm5TXa8O6CWpIcN"
Content-Disposition: inline
In-Reply-To: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 11:52:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16263


--Nlm5TXa8O6CWpIcN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add Display support for SMARC RZ/{G2L,G2LC,V2L}=
 EVK
> platforms.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Patch 1 mainline commit does not include some files present
> in 5.10 tree, so manually moved across.

Thanks for the series. I could not find anything significant in the
review and it passes testing. I can apply the series if there are no
other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Nlm5TXa8O6CWpIcN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnAjawAKCRAw5/Bqldv6
8n1EAJ4hSTiPoVfvgLaJxrNK8PUIKUD7sACgub/HzV+rpsv1yQg3BjFVR811rZM=
=6OeO
-----END PGP SIGNATURE-----

--Nlm5TXa8O6CWpIcN--

