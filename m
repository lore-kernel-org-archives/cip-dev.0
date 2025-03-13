Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654DEC28B2E
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 10:51:40 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.11604.1741863098918326172
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 03:51:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=X+rpd7tc;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29D5F1020211A;
	Thu, 13 Mar 2025 11:51:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741863096; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=T9rZwQlXIJmvbFzQHD2K67Yl1LklxvXynsjYXJa0USA=;
	b=X+rpd7tckLKlC18XHAlegyhPZkNmTpTDYYk4tuMmUY2fdwt5PflAK3+Vw2dGsrjjJEv/Xt
	rdVm4qYl8ZNiBj0T0DzbCmNBohPbInojR5YEMOIWnnSxuoqHfq5C/j41oL14JjRUBzHBKW
	GLnozLDCG3RpJSU1YPCxVLXuv20ro7C/6FW0j6mUdZji726IY2aeZkT9V4omj0q/nh8GmC
	UyEqHJw3TQ3E8bNvOo/qMQKLPZVUaaMKZzxE43CXIBm4i6U8UT5wlytv1TyzXMRFTJo8g5
	4L4x9dSc0SqR2/R3HDj5p/MY2Vu4CGYF4lWqo+1wJrYOKPVXkj5cSe2XRooSXA==
Date: Thu, 13 Mar 2025 11:51:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Message-ID: <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WtbyVe1m4dnPeYvy"
Content-Disposition: inline
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 10:51:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18187


--WtbyVe1m4dnPeYvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series add support for RZ/G3E SoC to linux-6.1.y-cip kernel.
> All patches are cherry-picked from mainline kernel.

85 patches, 3000+ lines of code. So we deserve so back story here:

What is RZ/G3E? Is it new generation of something? Is it used
somewhere?

Why is it important? Why is it important for -cip?

Does this add complete support? Or just enough to boot?

Is it in 6.12? If not, what will we do with 6.12-cip?

Do you have it in lab running tests somewhere? When was it released?
What was first mainline kernel to work there?

I'm curious, and, dunno, 50 lines of explanation what this is would
not be out of place for 3000 lines of patches.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WtbyVe1m4dnPeYvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9K4sQAKCRAw5/Bqldv6
8p8/AKC+mzYZPoyBGv/Vw8dEySAdu3KFpwCdHkC5sbIZw6mHnzPUD5rORo6R3pc=
=9WyX
-----END PGP SIGNATURE-----

--WtbyVe1m4dnPeYvy--

