Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305FDC43458
	for <webhook@archiver.kernel.org>; Sat, 27 Jun 2026 13:14:24 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.901.1782566060621015573
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 Jun 2026 06:14:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=QJ6ft0xd;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 403D4118255;
	Sat, 27 Jun 2026 15:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782566058;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9RA4iKvnBHGVWC0ysh50B9OQ4zsYO5ChDpGfMYiXXAs=;
	b=QJ6ft0xdBrbaTcex1VzjvOXcaqc5KJvPUJvlD65xPhei/xfbRHYTaVMGm3t895lcrpZWhv
	OYHyr4Za/NuBXxm3qEBoDd3rITaQq+tSwVX4BnemHtC6J4P5DzMEeXK+GxXzDy+lIsl6oG
	dDCGlMrOU9pNJ27Vg6/oELJCei2Xno8nC1SVecIoSXBuv4ljoTxVvqMtf+iWtMQGQZk7dO
	hEL3KGqynd3nvQnMrhzZ9EW5VJDgbwPYJvX9wH6NVs2IjvTdMckAbRbMC6dlO6LQRbmNbw
	TdmEM7D9m5WSrw0O7YoJQmrLFa0CiYGsSk+/EdaLc9ZkY1asEIlUrfDSYr9Uhg==
Date: Sat, 27 Jun 2026 15:14:12 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/24] Add RSPI support for RZ/G3E SoC
Message-ID: <aj_MpONoxK_Ka6c8@duo.ucw.cz>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uanhl3n3KjH7jZwK"
Content-Disposition: inline
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 Jun 2026 13:14:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23293


--uanhl3n3KjH7jZwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RSPI support for the Renesas RZ/G3E SoC, which
> features three RSPI controllers. The series also enables DMA support in
> the RSPI driver, and backports the necessary infrastructure changes
> into linux-6.12.y-cip.
>=20
> The series is structured as follows:
>  - Clock entries for the three RSPI instances on RZ/G3E SoC
>  - DT binding updates: document DMA properties and add RZ/G3E compatible
>  - Device tree nodes for RZ/G3E RSPI controllers and SMARC board enableme=
nt
>  - Driver improvements backported from mainline: DMA support, device-mana=
ged
>   APIs, bug fixes for clock setup and FIFO thresholds

Thank you, applied.

Best regards,
									Pavel

--uanhl3n3KjH7jZwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj/MpAAKCRAw5/Bqldv6
8vmGAKCG24UlTsV8yrgbUb5ABb0Kxf/ogQCfTZFQ91XCEXr9Ie7y7NehN5Xi8/M=
=7fyY
-----END PGP SIGNATURE-----

--uanhl3n3KjH7jZwK--

