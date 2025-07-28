Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A167AC83F26
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 20:12:49 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.91092.1753733562333481185
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 13:12:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=S+33Ihzk;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 763551038C126;
	Mon, 28 Jul 2025 22:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753733560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=h+iQvMm2riU/XiXJMwNn2Qq3wq9Vnj741F4Nby5d69k=;
	b=S+33Ihzkq6CCcfDS/cggWkGtGFzO9LoLFoU2PWa6sNVwHHX2FKKNeG/3DppD8/Hdyv1bVB
	9q1Wd3vOJKulEIJhEoSWFzd2Jd2FsVTkjz6vZqwgPupmFxYQVhUrivkeRUEurzFlXl/+Kt
	pHhfJ5jP9mjTLOgZTtepPZEGIoD+t6h31fCPIqbqBF6ta9bRIBMF2tK7Y2sM2I1YDGE8Fg
	Wbn054G+Safd6WGcnFR73PJGVguibZhZqg7ENtiyaETsGZMIONgn6OKU39Y7EO/S3m+giS
	BrCwbB/6WnGVfmde2ykfaEwJSpihvoJzXPiw1iqSug0yEc8mhYYQyoWK0cvCkg==
Date: Mon, 28 Jul 2025 22:12:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc:
 Add I2C2 and PMIC support
Message-ID: <aIfZseR9WgRYf45U@duo.ucw.cz>
References: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yBiEc6LGx3JCzK0H"
Content-Disposition: inline
In-Reply-To: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 20:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19609


--yBiEc6LGx3JCzK0H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for the Renesas RAA215300 PMIC into
> linux 6.12.y-cip kernel, on the RZ/G3E SMARC EVK board.
>=20
> To enable PMIC communication, the I2C2 pinctrl configuration is added fir=
st,
> followed by the RAA215300 node.

Thanks for the patches, both this and 6.1 version looks ok to me, and
I can apply them if they pass testing and there are no other comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yBiEc6LGx3JCzK0H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIfZsQAKCRAw5/Bqldv6
8gA9AJ9L8A5xMUhCDu2Bg0KDS1xA2uSx6ACgwJzNlKBt+JM8jBNhvnD6ajhhprc=
=Rx8B
-----END PGP SIGNATURE-----

--yBiEc6LGx3JCzK0H--

