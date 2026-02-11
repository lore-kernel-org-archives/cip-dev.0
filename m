Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C4E9E311
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 14:25:27 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20005.1770819924556837151
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Feb 2026 06:25:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=IMeqUoKr;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07A43108E1A;
	Wed, 11 Feb 2026 15:25:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770819921;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MrXLc9n0pzFe7QPvGUfwBiwjgFLpRVJqtXlDl09LPHk=;
	b=IMeqUoKrTEtAqPfntYLbVgy7eoaprGKkM05y2v+81Z+Ta7co4cXDp4OCyvK5hUUTZ9P1f2
	yhXDdj+tR3T0IMGdKbtCJ3Zr59hrPRpYa95KqG/GDCfCK4j55UCGK1sgz15edKTIkjv6vf
	HW7XeqHSLrdS3vLMipATgomd3mAqYgIEHsbM1gWR5K+xTz83YvTDRHXvt/nITxosxdkUco
	yrxeFBTO1wrT3awKu7t93QkEWCT4WZHSrFMQd/DdqeTgBaGebx+id3OmhhL80PSiPjSWo6
	AoMOjHpTHo/aZ3Bg2L7NW5SrTgOfMSLZKs8hK3vAbL+JurZlXtH0aUwni6AKfA==
Date: Wed, 11 Feb 2026 15:25:17 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip] i2c: riic: Move suspend handling to NOIRQ phase
Message-ID: <aYyRTRXYwG57A9B/@duo.ucw.cz>
References: <20260210102747.484082-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aqNAhW5rupwcvy6D"
Content-Disposition: inline
In-Reply-To: <20260210102747.484082-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Feb 2026 14:25:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21855


--aqNAhW5rupwcvy6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit e383f0961422f983451ac4dd6aed1a3d3311f2be upstream.
>=20
> Commit 53326135d0e0 ("i2c: riic: Add suspend/resume support") added
> suspend support for the Renesas I2C driver and following this change
> on RZ/G3E the following WARNING is seen on entering suspend ...

I don't see anything obviously wrong with this patch, but ... do we
need 6.12 version, too?

Thanks and best regards,
								Pavel

--=20
In cooperation with Nabla.

--aqNAhW5rupwcvy6D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYyRTQAKCRAw5/Bqldv6
8lQYAJkBMd6HmCFMzN6ijXU8cyHSD7tCTgCXXuWnRDQ+VQHrpYzklurof2XNQQ==
=t2Pt
-----END PGP SIGNATURE-----

--aqNAhW5rupwcvy6D--

