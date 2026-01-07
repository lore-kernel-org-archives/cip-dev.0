Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED612CFD63D
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:57:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6336.1767794255520173296
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:57:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fH5GPHCf;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1F7410D43A;
	Wed,  7 Jan 2026 14:57:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767794252;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=C5zneh0i+u+Ves+IMzYFKY2ILyDUBT3cwG8WaAyhpuE=;
	b=fH5GPHCfcUidZDIumixz1L4JMCRWFKTPCVMyIoAycKD/UMyEbjImBlmmlodWf8RwnwghHu
	f5E1xaPQifwN7tfHt2eZl2/LIvYQJio+oSTdxQCXDswE2khcPBGtPhycvUXj8PcSuOsTpK
	oObCioycGjb2WELdaQhKsE1VFPhvKqnzJ9bxC+e4CfBOMcMa6E8/KPkUt3Pxw7Qh9Z3CHy
	+fEoJUUG4s6uYmR5e4p0yaWnqUuhZCGhpk2YGgGym9dEoQzzr74f3padWO2VfoQ5QLjMXG
	uWaJn0swguDbs3Mgl6N/mkUpa1ItDfXdT6nVnU3NgfnF4+OUFpbPHFklD1BGLQ==
Date: Wed, 7 Jan 2026 14:57:27 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support for
 RZ/G3E CANFD
Message-ID: <aV5mR8hWfrCqPoqD@duo.ucw.cz>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qbTbLFdhcUDQV1zr"
Content-Disposition: inline
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:57:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21414


--qbTbLFdhcUDQV1zr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI, s2ram
> powers down the SoC. After resume, reinitialize the hardware for
> CANFD operations. All the patches in this series are cherry picked
> from mainline.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--qbTbLFdhcUDQV1zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV5mRwAKCRAw5/Bqldv6
8vI2AJ0SrepM6MsVu4LIzYlVEhn01eUZ0gCaApL5UZi7rN2IYLi1up/b7gnk7JA=
=/aSY
-----END PGP SIGNATURE-----

--qbTbLFdhcUDQV1zr--

