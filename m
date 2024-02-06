Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A62C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 17:51:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.28292.1707241903481586865
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 09:51:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3C7841C0081; Tue,  6 Feb 2024 18:51:40 +0100 (CET)
Date: Tue, 6 Feb 2024 18:51:39 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 5.10.y-cip 00/44] Add support for Renesas RZ/Five
 RISC-V SoC
Message-ID: <ZcJxq9pc0UV/GW8q@duo.ucw.cz>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eOzCwzldb1uQ0i3t"
Content-Disposition: inline
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 17:51:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14832


--eOzCwzldb1uQ0i3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> support for this SoC has already been added to 6.1-cip kernel.
>=20
> v1->v2
> - Dropped the first patches from [1] as they were already merged into CIP
> - Rebased the patches on top of v5.10.209-cip44
> - Had to manually apply changes for patch #10 and #12, rest of the patches
>   are unchanged.
> - Added Reviewed-by tag from Nobuhiro Iwamatsu for all the patches

Thanks for the series. Patches #10 and #12 still look ok to me, it
passes the testing, and it already has Nobuhiro's reviewed-by tag. So
I went ahead and applied the series.

Looking forward to seeing risc-v renesas & qemu results in the gitlab!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--eOzCwzldb1uQ0i3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcJxqwAKCRAw5/Bqldv6
8gICAJ48tBEj8essSJsZ/doaaFPgf775WwCfeqAffSKf6pobM4fm0Kix/B1S8wI=
=ohpY
-----END PGP SIGNATURE-----

--eOzCwzldb1uQ0i3t--

