Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63618C369CB
	for <webhook@archiver.kernel.org>; Sat, 26 Apr 2025 07:14:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.5211.1745651659098785288
 for <cip-dev@lists.cip-project.org>;
 Sat, 26 Apr 2025 00:14:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=B0uKiZqI;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C7C3102A4BFC;
	Sat, 26 Apr 2025 09:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745651657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dftkyxejuNZgrs4D9J+BRT/93s/1IxZ+0DnupoXyxXs=;
	b=B0uKiZqIp6UfjBgG7MB5Enm3AFW+tJr+4qgQ4fsD5WZiU38JYryw6iUSuXmeUZUDaM4aO7
	QiSSBEic3QzuRYBeswFrG+4CNFAtSN6ABK3cdP54lLRX1Bp/PwQXAyKypM0IBZJw/RXnaf
	WJ7LzGHwPn5AYQ+EvfUELOwoA73ztfq12ZCtUvbq/+6d4ISgEEKN3AZdE4nxOQCn3hQLEU
	Wzqad2dkBN3MtlzcX+Wd2S8Z46ET4UpX4hNJBFJv9NTC8+aPSDySE0T26eKzL4fH9dSzsR
	PB5YajbRGMQabVOehPlaKDbP/dqr70IXo1U82TkKBL86DyeKKsLYt8M7FhvhBQ==
Date: Sat, 26 Apr 2025 09:14:09 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/21] Add SYSC/MMC/GTM driver
 support for Renesas RZ/V2H(P) SoC
Message-ID: <aAyHwQABeRiZtiL0@duo.ucw.cz>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5deM31/5ZCX6qycv"
Content-Disposition: inline
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Apr 2025 07:14:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18645


--5deM31/5ZCX6qycv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add below driver support to
> Renesas RZ/V2H(P) SoC:
> - eMMC/SDHI
> - GTM
> - SYSC
>=20
> Note,
> - All the patches have been cherry picked from upstream kernel
>   v6.15-rc1

And all patches seem to be in 6.12-cip, too. Good.

Series looks okay to me, I can apply it provided it passes testing and
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5deM31/5ZCX6qycv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAyHwQAKCRAw5/Bqldv6
8lxyAKCFytCdUle/Gs+nxsQ+Lz4oauaBKACfVldFrzqnd8jkghQFDaCv09xJtL8=
=ISER
-----END PGP SIGNATURE-----

--5deM31/5ZCX6qycv--

