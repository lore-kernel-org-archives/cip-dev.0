Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C0C36008
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 20:14:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.5691.1742933633489176188
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 13:13:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=O2QowTQI;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B56D2102F66E4;
	Tue, 25 Mar 2025 21:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742933631; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1e2VwgiI/7s1gE8myYEin707gmPA0oZDJB9TUnjSAsk=;
	b=O2QowTQIuu8g+KfVwxCKANnBFQeNL60SBJnLq6vxsrr+msSVMx6pZy3ooDLnLJ8S/ESBHX
	W8JpATeACofa2/Fd7DaujwCv+e471acaK3W/O1EjcKpLOirLab8uv0knyWpQybh2ldzKod
	TF7oDM9m36wSQIlTwZfewpQ3I18TqM18/gV8GJa6W2PMWMwJcUK8prT4X35xVp9RPCFgUe
	92Z916RXiHQT4GYzS2JX1AjoV68bjhKKnTRU2suigV4csEM/zyukBrfuHR6MJHPZB3hwvX
	zVNFcCSNC5Pj7YIqmR18WYEo/5Nj6B6ibMurZ225/yl5ST3n2oj1ezKRWpi9+Q==
Date: Tue, 25 Mar 2025 21:13:45 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/16] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Message-ID: <Z+MOeS51tO4dKnpL@duo.ucw.cz>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qzXsIEOBn/IL9Qkd"
Content-Disposition: inline
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 20:14:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18367


--qzXsIEOBn/IL9Qkd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds initial support for the Renesas RZ/G3E SoC and
> RZ/G3E SMARC EVK platform to linux-6.12.y-cip kernel. The RZ/G3E device i=
s a
> general-purpose microprocessor with a quad-core CA-55, single core CM-33,
> Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.

Thank you. It looks good on quick scan, I'll apply it if it passes
testing and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qzXsIEOBn/IL9Qkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+MOeQAKCRAw5/Bqldv6
8rGmAJwNrDzeZ/EEhDLW9Sh+wrS0AFGukwCcCUCwg3s7e+By5IwEVTn3vgJlTOA=
=vjgT
-----END PGP SIGNATURE-----

--qzXsIEOBn/IL9Qkd--

