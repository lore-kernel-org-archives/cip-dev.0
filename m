Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C90C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 06:22:15 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.41795.1745821223319403932
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 23:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WGBVtN44;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6ABA1026E03A;
	Mon, 28 Apr 2025 08:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745821221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=af/RkxkygDZaiJ9YNFBq1gjO8AoSzZrdb1eU99EHPrE=;
	b=WGBVtN44PH+nzpNH7JcdkdOo8r83FassYyDukQGjZjeQ3pJxuUSzEC3aRemsTX5VwNDw9D
	qkskCwyIoUkmz7tfyesNIP3c/k+D+kZADRlFZB1HVTv3QkRj2cDyjl4KmU6oWN+14zWzuU
	Hy50f1SUpWG87uGLOHWRFDL/FYNk0ltGmbc/J62VwyfYel9M/haR2UqsWGqpnRIeGwSkF0
	LYnM0BQhPusNKZRwL8/HBNSV6xQfHDeOQvPZCMdQjVp9buTVHiI2UzqxoMiQLb4E2VDnIl
	mWgGG1Pu6bPauiwf49/xwB193Lzr7KzzZWgOV5CmCQgi9JB/EyeN4JmgPskJAw==
Date: Mon, 28 Apr 2025 08:20:17 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for
 Renesas RZ/V2H(SoC) and EVK
Message-ID: <aA8eIaCLSscXD1Yr@duo.ucw.cz>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CrBDn/VT2D+kMcLY"
Content-Disposition: inline
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 06:22:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18679


--CrBDn/VT2D+kMcLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add initial support for Renesas
> RZ/V2H(P) SoC. With the initial patches in, the EVK platform
> can boot up with the below features enabled.

Thank you. Series looks okay to me, and I can apply it if there are no
other comments and it passes testing.

> Note,
> - All the patches have been cherry picked from v6.15-rc3
> - There are some RZ/G2L SoC family patches which update

If you wanted to help me, adding note "All the patches are already in
v6.1-cip" would be nice. (I checked few, and assume they are).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CrBDn/VT2D+kMcLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaA8eIQAKCRAw5/Bqldv6
8rNjAJ0QMkWN4vfu2mztqizpV2qs9DLpVACeNUAGb7oaxgR1pUFeT//DbIUKpWo=
=uMbh
-----END PGP SIGNATURE-----

--CrBDn/VT2D+kMcLY--

