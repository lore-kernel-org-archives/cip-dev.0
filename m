Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC3EEF325
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 08:39:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39805.1772699935767071787
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 00:38:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=MYWzh+nH;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A251103E81;
	Thu,  5 Mar 2026 09:38:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772699933;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rEq9Yebhnij+2hxP7RzARffY5XiRnvdH5xbK4llTCyM=;
	b=MYWzh+nHw0HXZG9Fly89y1FS5COhHiBiUQFAusQyiBysChNd+WNMHb1BOaI3eDcN/M2Sh8
	KJVzdZoKXzegdmzHr9hfA0XK0LlzLtRE7kCVA+Dwy3q/0MyCWHbik/+6ICoP/4I4U4l8No
	bKu7iO/tLPeqHfR8XnKZqOp1zyu3x33n9xef2TamXQmPa/NedVWjZSoQNdxXxfL8hHfL61
	UHZykvLqCKO/U6YHto85CZE2bINLypVfOb6RD9Uz2AN6X7SsQZb2MtspNFRiy42i2ZHnRd
	I7Uj+1JeUieu0s+oUThkHBYTAT6DnVwHxv7yG+stlJ+8Z+0hJrBL+LEwFFLh4Q==
Date: Thu, 5 Mar 2026 09:38:47 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 0/9] i3c: renesas: Add suspend/resume support
Message-ID: <aalBF+b7kANaKaIT@duo.ucw.cz>
References: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMRoA4JJALvlyOuO"
Content-Disposition: inline
In-Reply-To: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 08:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22074


--lMRoA4JJALvlyOuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series enable I3C on RZ/G3E SoM and adds suspend/resume support to t=
he
> Renesas I3C controller driver into linux-cip-6.1.y.
>=20
> The series also includes patches required to backport:
>=20
>  - devm_clk_bulk_get_all_enabled()
>=20
> Into linux-cip-6.1.y, which are used by the main suspend/resume
> patch.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--lMRoA4JJALvlyOuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaalBFwAKCRAw5/Bqldv6
8rL9AJoD/b7eb9fNdR2ic/f815/G8+7/sQCfaFJPQmZTejZr4RmdFNc+AAZc3rY=
=8TXa
-----END PGP SIGNATURE-----

--lMRoA4JJALvlyOuO--

