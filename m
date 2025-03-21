Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E94C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 20:12:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2955.1742587954473253235
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 13:12:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=StR+EVzZ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89A08101E8FE3;
	Fri, 21 Mar 2025 21:12:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742587952; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=T9ygIH1nVRsHF2B6EdRank43t08WOYJnKQzmiF2WTH0=;
	b=StR+EVzZJUWgOvGqni7V/K7ZEQGLKela41DFAZkmQWzHaUVOgsdSd0MpKUgGBacbYRhJLj
	tiRUAdQ26V780zO5CNXyMl6P0EnW+j4ye0v1QPRMaCuFitXqlfbFncEpN4yNsI8SZeeQ3t
	AIYmGq0ekBCK5VrlrCNQj5vWUg3hBExGmtqD2oZIv5AvlpxW9kD10aAsZaPUek1OlnwjB5
	+rP5U5xbbRNOPUDSottaCE5OpKhHOoqjWT1MQx8ALP4JlL3RQcT/7NZgkDH3cr5n5Eub8a
	Vcxja7NMqpeOol9+8szKfcAyhSg0r1LzHB4A6EzP4iDvaRFYk5e56SwzAPj9Cg==
Date: Fri, 21 Mar 2025 21:12:28 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/21] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Message-ID: <Z93ILAaLP1+LR2gP@duo.ucw.cz>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V/MFdOASBV68KMVO"
Content-Disposition: inline
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 20:12:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18331


--V/MFdOASBV68KMVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds initial support for the Renesas RZ/G3E SoC and
> RZ/G3E SMARC EVK platform to linux-6.1.y-cip kernel. The RZ/G3E device is=
 a
> general-purpose microprocessor with a quad-core CA-55, single core CM-33,
> Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
>=20
> All patches are cherry-picked from mainline kernel.

Ok, thanks for the series, it looks good to me.

Should I simply try to apply it to both 6.1 and 6.12? I guess I can do
that if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--V/MFdOASBV68KMVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ93ILAAKCRAw5/Bqldv6
8oekAKCMR2tplsz82B6lugNi5Jw5hcpRgQCdFfJLK9vwVkpNlqoqupSueVsFpnM=
=tBuJ
-----END PGP SIGNATURE-----

--V/MFdOASBV68KMVO--

