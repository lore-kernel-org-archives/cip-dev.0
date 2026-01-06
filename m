Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D47CDC188
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:14:49 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88619.1767701686136726586
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:14:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=W7p9Z5Cc;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09A521097A4;
	Tue,  6 Jan 2026 13:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767701684;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fRZCZESxTmaguNr7Gmcg/TvA8HzUqcrfbrb7F+l8Kh4=;
	b=W7p9Z5CcY/1UwzKUIOjfBADy6UyBr7GbkagypD/O4IN/4o33d+7KZIejQX9x6fHMIO9G9X
	MMSmnGBsEtr+U4wtQtRDNqQLTI4zV8zC2zJpAghxkVZYYzUgRYrMkg7FLErm1XAGQGe1Vv
	4rYac2qYz/SYaPFa7dqNcxXJ7qolm3EksEHnlTgfhhdKb42/IcUqKlrhXaBxKUGYoUUwN0
	F/vfvKkxOdkkZOKdW8wbalTDegZY2juxihsiYWmaXb2nSlyuMiMtCb5Lj8MkhSgdgXTAer
	ELJfUvg94bCMmlPEKP2NLkprfNa60qs/+w2MzHM0X6RlSKcrhLBf470vxr+D7g==
Date: Tue, 6 Jan 2026 13:14:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: biju.das.au@gmail.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support
 for RZ/G3E CANFD
Message-ID: <aVz8r/qCX/dzdtmE@duo.ucw.cz>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DjMoJy/DPfH8ubiT"
Content-Disposition: inline
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:14:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21374


--DjMoJy/DPfH8ubiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI, s2ram
> powers down the SoC. After resume, reinitialize the hardware for
> CANFD operations. All the patches in this series are cherry picked
> from mainline.

I'm not sure what your plans are; I assume you'll send v2 of this for
6.1. That's ok.

But if you have plans for any more submissions, please consider giving
us a bit of timeout. There are currently 6 series in flight from 3
different people and it starts being confusing.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--DjMoJy/DPfH8ubiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVz8rwAKCRAw5/Bqldv6
8mCyAKCXw0T3FmfFPOxWTmUNyoKqkSZanACdFR+6HnFgR2TjTC9IERcSvQK8Pfg=
=xDWe
-----END PGP SIGNATURE-----

--DjMoJy/DPfH8ubiT--

