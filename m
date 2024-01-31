Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC47C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 11:33:57 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.11847.1706700835463291916
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 03:33:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F0E1A1C0079; Wed, 31 Jan 2024 12:33:52 +0100 (CET)
Date: Wed, 31 Jan 2024 12:33:52 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five
 RISC-V SoC
Message-ID: <ZbowIA9sDtDExkBU@duo.ucw.cz>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9G/gtpmfLksWXwrm"
Content-Disposition: inline
In-Reply-To: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 11:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14558


--9G/gtpmfLksWXwrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> support for this SoC has already been added to 6.1-cip kernel.
>=20
> Sending this series as an RFC as,
> 1] Support for Global DMA cohernet pool is added
> 2] As support for non-coherent DMA is missing for RISC-V core,
>    required changes have been added directly in ax45mp_cache.c
>    (ie patch #26)
> 3] Patch #26 has been newly added, rest of the patches have been
>    cherry-picked from upstream kernel.

I quickly went through this, and found nothing too crazy. But as this
adds whole new architecture into 5.10-cip, I guess I should get
confirmation on the IRC. We'll also need to add this (and RISC-V qemu)
to 5.10 testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9G/gtpmfLksWXwrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbowIAAKCRAw5/Bqldv6
8ozNAJ0SnZ/vU9LXTOssFpKwFO8866pxxwCfX4rtrzPBdKu7fUj+GnixA4CPtrA=
=Ut3D
-----END PGP SIGNATURE-----

--9G/gtpmfLksWXwrm--

