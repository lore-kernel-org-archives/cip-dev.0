Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB79CF857A
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 10:37:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8264.1727951822568999881
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Oct 2024 03:37:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4C0161C00B3; Thu,  3 Oct 2024 12:37:00 +0200 (CEST)
Date: Thu, 3 Oct 2024 12:36:59 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/16] Full duplex audio + RZ/G2UL DU support
Message-ID: <Zv5zy1t6xWMtfEc4@duo.ucw.cz>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o6/6bjGEm8z0vkc8"
Content-Disposition: inline
In-Reply-To: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 10:37:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16991


--o6/6bjGEm8z0vkc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aim to add support for
> 1) RZ/G2UL display
> 2) Audio full duplex
> 3) Auto loading for CSI driver
>=20
> All the patches are cherry-picked from the mainline

I went through patches, and apart from Iwamatsu-san comments, patches
look ok to me.

This one has to wait:

>   pinctrl: renesas: rzg2l: Use dev_err_probe()

But I believe I can apply the rest if they pass testing and there are
no other comments.

Same applies to 5.10 series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--o6/6bjGEm8z0vkc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZv5zywAKCRAw5/Bqldv6
8oBoAJ4zstPTX/DkiMx77UWsqxpr93XW8QCfZgvVtx7hKm/6Ehqj1Myqu5VvEg8=
=LpXJ
-----END PGP SIGNATURE-----

--o6/6bjGEm8z0vkc8--

