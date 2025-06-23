Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775D0C77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 11:16:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.17136.1750677379388294445
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 04:16:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=J50zARq0;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C31010246DB8;
	Mon, 23 Jun 2025 13:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750677377; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qe92E8x6/SkyMRehVMc/0K8wSdn6f31cUvXYHqvIa+Q=;
	b=J50zARq0HDDexaIfbwr6Ot+VgT+1V0yBpTSq8RP2TtnvIH6pjXayTv9/1k7zt3POwIG4kx
	FuW/nUW6lZyFSsQlqvH+u/fin1baHE7wAJ0qRT47j4mizhUdAUY5OTqAU8ozIv3CZBvoCF
	Oh5Sj6P5YgtLoHOI1sMRsCMAKt8dilR/XQEUmje/rmPPNIwm8WCa5uc8OWI6dERaKO7tRB
	uGU1anvEUzjtKE7V/ScY2ohv3m9ux/mCLfJGNr+UIMhHjvP/OoV/9RWmIsCH5wLVu/PWIE
	NGkWttlOcspQBvEM+G3CnLXk8sIMSajf7NZMa356hGIBUrt5MNznTDh4aXSwkw==
Date: Mon, 23 Jun 2025 13:16:12 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 0/8] Add support for RZ/G3E WDT
Message-ID: <aFk3fJb1XRFVhDgs@duo.ucw.cz>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QiMmS2sJKfyMWyNB"
Content-Disposition: inline
In-Reply-To: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 11:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19183


--QiMmS2sJKfyMWyNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add Watchdog Timer (WDT) support for the
> Renesas RZ/G3E SoCs.
>=20
> The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33 cold
> reset, system reset and asserting WDTUDFCM pin where as WDT1 can be used
> for CA55 cold reset, system reset and asserting WDTUDFCA pin. Other 2
> watchdogs can be used for system reset. So define WDT{1..3} in SoC
> dtsi.

Looks good to me. I can	apply it if it passes testing and there	are no
other comments.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QiMmS2sJKfyMWyNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFk3fAAKCRAw5/Bqldv6
8loKAJ9QUCBzjavydUq6IUlvdVav0N7KZwCfUu9833IZRS+ye4riaLMA6iwOx08=
=UVp4
-----END PGP SIGNATURE-----

--QiMmS2sJKfyMWyNB--

