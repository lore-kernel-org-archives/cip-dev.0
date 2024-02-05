Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE93FC48292
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 19:33:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3271.1707161592750283274
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 11:33:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4EF431C0050; Mon,  5 Feb 2024 20:33:09 +0100 (CET)
Date: Mon, 5 Feb 2024 20:33:08 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RISC-V
 SoC
Message-ID: <ZcE39ErfLUNez/TS@duo.ucw.cz>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fj2+xXRtRKy90u39"
Content-Disposition: inline
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 19:33:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14755


--Fj2+xXRtRKy90u39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> support for this SoC has already been added to 6.1-cip kernel.
>=20
> RFC->v1
> * Patch #35 updated according uptstream for easier maitainance.
>   Rest of the patches have been unchanged.
> * Merged RFC series [0] and preporatory series [1].
> * Previous test run results can be found at [2].
> * RISC-V Renesas defconfig file can be found at [3].

Thanks for patches. AFAICT 1..4 are already applied to the 5.10 tree,
so we won't duplicate those.

I only have minor comment to one of the patches, that should not
prevent merge. I can apply the series if there are no other comments.

I rely on you for testing. I'd like to see qemu-risv enabled for 5.10
and 6.1, so that we have more than once architecture.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Fj2+xXRtRKy90u39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcE39AAKCRAw5/Bqldv6
8hF7AJ4+ltjwD5m+RzSRxeiQhh3ZbhbYEQCgsc3eCdRlTK36WUBmgmzKMuLqGe8=
=j0ey
-----END PGP SIGNATURE-----

--Fj2+xXRtRKy90u39--

