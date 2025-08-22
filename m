Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0CACA0EFC
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 11:36:23 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.7752.1755862574460956751
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 04:36:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bJIML8tn;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8DD3103F5654;
	Fri, 22 Aug 2025 13:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755862572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=V9swQidqj1uyGoBqLfqGkViOST7eSse841mWRlDYzB0=;
	b=bJIML8tnL+ncAOMmZk95Uc4BC+123bLIOFbJS6fkOE/u+T5T/aJ74zrX9ZQ5p6tPSOvKrK
	BBVNle5BoMfVC4XI97Ebp4xldk4Z8K5YPqGOQeQAT8EJHmKmj/kh3ZUCQ62mrA5Mch3cxt
	A3Hd1DvZfu/Cp4GWe9Ud6uEJusKlg5gmzkH5IF/haEdCd4oaKmPn2PlkjYJR+1SsEs5T8z
	FpKkJ/PBOkUJh4vuxQ2NzSa8f2B9G5ruc9205qEPU2Lp1hQRkgXOtnL3q8zYDEQ5GVAXEc
	OmX8XJB1oC/KREXe9i3cr4nbTXpkCprK0DHBA+5a0RrvTCMSx4sCLfX9FPfDsw==
Date: Fri, 22 Aug 2025 13:36:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 55/55] media: i2c: ov5645: Set
 V4L2_SUBDEV_FL_HAS_EVENTS flag
Message-ID: <aKhWKC0G6Q9UBkWA@duo.ucw.cz>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <20250820160413.801341-56-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2m7Ah9sl1c05BCdQ"
Content-Disposition: inline
In-Reply-To: <20250820160413.801341-56-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 11:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19948


--2m7Ah9sl1c05BCdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The ov5645 subdev can generate control events, therefore set
> the V4L2_SUBDEV_FL_HAS_EVENTS flag.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

This misses "upstream XXX" marking, and likely some sign-offs, too.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2m7Ah9sl1c05BCdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKhWKAAKCRAw5/Bqldv6
8t4qAJ9whXMHFUUXCzET3Jd4/Sc92c0aDgCglZGlAVBDzTLBlVLFK2BhSh28nQw=
=rksd
-----END PGP SIGNATURE-----

--2m7Ah9sl1c05BCdQ--

