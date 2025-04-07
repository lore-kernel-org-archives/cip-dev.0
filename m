Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEAEC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:48:57 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.41560.1744012134138914483
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Apr 2025 00:48:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=K2jInoBn;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B07B4103B92CF;
	Mon,  7 Apr 2025 09:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744012132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HS9Uj7PSE0NYLp9YCmOF7vaC8E/NLQIatjsrtJ85kZE=;
	b=K2jInoBnWx6zzmmhvTxmhD/vVt40JSaI3Yrz+cRx5Ex6DgITxcInVnTrEH1aJvk0B7cO6J
	cq+u03zk3qWs/Qpr1m3IKislsb27n4Sqw3qboYkOibLVZTP27hwjnKDOM1iRQDMy+O3lDZ
	MBKapP6OqyB/pyC3oQwhJswxuhXSyom9l5962zuuKEa7dXznm7cL6QVO9Lfay7CNQ0r9Y0
	6JX8Slfe09rbWiU9BaM04A4ZiV2nkNO3pum8Tn+gzNS4+4qm7ePfws3PclzCVRgnMVfb4T
	CiDshyhf7R8mHXzV0xQ40tXFon/JXYkR2o02gMSpigolK8gU4LZij9phVaKCuQ==
Date: Mon, 7 Apr 2025 09:48:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 0/3] Add RZ/G3E RIIC support
Message-ID: <Z/ODXfCuMEDaBx50@duo.ucw.cz>
References: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKJi2Pz1bngZWu2F"
Content-Disposition: inline
In-Reply-To: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Apr 2025 07:48:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18482


--tKJi2Pz1bngZWu2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for the I2C Bus Interface (RIIC) found in =
the
> Renesas RZ/G3E (R9A09G047) SoC to linux-6.12.y-cip kernel.
>=20
> All patches are cherry-picked from mainline kernel.
>=20
> base commit: 18d2300f61bca arm64: dts: renesas: r9a09g047e57-smarc: Add S=
CIF pincontrol

Thanks, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tKJi2Pz1bngZWu2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ/ODXQAKCRAw5/Bqldv6
8qbOAJ9z7QhWtPKqxTT74EEMpB+Q2fQDeQCfQq9I+OQ/yVYUmBMJNNGxqeJGgWI=
=4NIb
-----END PGP SIGNATURE-----

--tKJi2Pz1bngZWu2F--

