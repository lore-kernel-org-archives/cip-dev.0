Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4678AC36014
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 08:00:58 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2734.1743580852535209797
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Apr 2025 01:00:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=c9NXBIaA;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CBAC10269396;
	Wed,  2 Apr 2025 10:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743580850; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JvBPJybLj2vQhtrF6uw5bW3Sfq7z4knOo88K9+QSqmI=;
	b=c9NXBIaAiqK5fiGL4GF2YqWaOZryfZyRbZ/yIqHDZojIlZ78ZjetpLM9HlcuqbnMmQqCfE
	qdYIuM6c99Wy9u1swBzTQImKEIz1N1vc8pe3/0U5Kee37/N0ORh0i+PyrBoBusXxKmgD58
	/pehzOeSx8sRBZmXX8m09rsUi2dhjguizIxRDS0toAUGnwpnDQ7plVc2pr0okWAq16LBny
	SSEzFUUd84jvECQ5/wL6Emp7CUMJry85hcYg1l29g1OcooLovgCW+wsbpITiaXYZaFuxKX
	PiTLbjO2bsQLnTxh9ZgdpqCY/f4tPe/ntxmPJiXDX/4wqwuJxGtnzKFsIqX05Q==
Date: Wed, 2 Apr 2025 10:00:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/43] Add RZ/G3E pinctrl support
Message-ID: <Z+zurnvTibN6iojS@duo.ucw.cz>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F5UtmnZFdVssArKs"
Content-Disposition: inline
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Apr 2025 08:00:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18456


--F5UtmnZFdVssArKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds pin controller support for the Renesas RZ/G3E(R9A0=
9G047)
> SoC to linux-6.1.y-cip kernel, this series adds also device node for SCIF
> pincontrol into RZ/G3E SMARC EVK board dts.
> The RZ/G3E PFC (Pin Function Controller) is almost similar to the one fou=
nd
> into the RZ/V2H which is in turn similar to the one found into the RZ/G2L=
 SoC,
> for this reason pinctrl-rzg2l.c has been re-used.
>=20
> All patches are cherry-picked from mainline kernel.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--F5UtmnZFdVssArKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+zurgAKCRAw5/Bqldv6
8gV1AJ92fVFwUveWcJ7VERJ0PmGRcbSlPQCgqxTcpmQQuh1FpNs46ABDzRUf53c=
=uXm+
-----END PGP SIGNATURE-----

--F5UtmnZFdVssArKs--

