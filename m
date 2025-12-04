Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F3D1F9B9
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 11:02:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40759.1764846160469790152
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 03:02:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Llx2/Fb9;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E273103AF6C3;
	Thu,  4 Dec 2025 12:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764846158; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9NGmoS1knn2tG7O2/fvAIJ2po/qxpwkyMk5YZGnMcOc=;
	b=Llx2/Fb9I7Mt888n+sGZNmctGn/J0u53Xruf7/KkZ5xT1kmcm+ZfhOflFkn9bIe2n6Ynsb
	/EkFe9IrOaqlsHQxwIisx8bBJz3yLbShnqS5ZRAkjuNkFpO4pbatOegsjHhP/PL0VPUV4M
	aTRbGCRjYa8XGYfm6ls2DEaCg+mNIEb4AevAoNl47l6VHc2S540ECtk1ZEm+fCW7GaaoQ8
	AFdqELLKZttcZyJYDMPy24U0YEBNhbWYyXGkU0rNhjSs3wH2AhSP1vce+o9U4rzdFL8+2o
	CIiEz+oN+WXJk/Knkj3dVFus9oFG5F2VYh5NHRFJ5bSjchI2u4aGujBj8Mr6Ag==
Date: Thu, 4 Dec 2025 12:02:33 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 11/11] arm64: dts: renesas: Add CN15 eMMC and
 SD overlays for RZ/V2H and RZ/V2N EVKs
Message-ID: <aTFqSex/VgHNt/XE@duo.ucw.cz>
References: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
 <20251203154058.33022-12-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x98YkM7JYGvUsv/4"
Content-Disposition: inline
In-Reply-To: <20251203154058.33022-12-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 11:02:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20843


--x98YkM7JYGvUsv/4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 3d6c2bc7629c8b1bfd75416767122096bb75ba7b upstream.
>=20
> Introduce device tree overlays for supporting the eMMC (RTK0EF0186B02000B=
J)
> and microSD (RTK0EF0186B01000BJ) sub-boards connected via the CN15
> connector on the RZ/V2H and RZ/V2N evaluation kits.
>=20
> These overlays enable SDHI0 with appropriate pin control settings, power
> regulators, and GPIO handling. Both sub-boards are supported using shared
> overlay files that can be applied to either EVK due to their identical
> connector layout and interface support.
>=20
> To support this, new DT overlay files are added:
> - `rzv2-evk-cn15-emmc.dtso` for eMMC
> - `rzv2-evk-cn15-sd.dtso` for microSD
>=20
> Additionally, the base DTS files for both EVKs are updated to include a
> fixed 1.8V regulator (`reg_1p8v`) needed by the eMMC sub-board and
> potential future use cases such as HDMI output.

This confused me, because the overlays are not here, but we already
have them in tree, so we should be ok.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x98YkM7JYGvUsv/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTFqSQAKCRAw5/Bqldv6
8qkAAKC1o89ZHAruxQE2wlgnP7mmZvhkRgCfQoM2Rh6eeFyp3NsTB+Qk81RftMo=
=ygP8
-----END PGP SIGNATURE-----

--x98YkM7JYGvUsv/4--

