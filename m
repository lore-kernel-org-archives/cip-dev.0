Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF71073C94
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 10:47:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.103621.1775645257520301721
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 03:47:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=BK9XU58H;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41841112A04;
	Wed,  8 Apr 2026 12:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775645255;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sNXbLUxuMC8jGOStdFD8czlm0W83u1vCCQCkRHVOMrw=;
	b=BK9XU58HUmKJDe5tEl4uehTjw8Y+Z0XkiSMSnHMk3wN8QPQPP6WAhX3McMvMmmGsnHc5R1
	jYdaxp0buwowBUXmudlJe2KCmo63Eyy6NeacC0rftYPOMu084swLct/6arijEc3UKaFDXE
	f2GogNdtJNzCS9Y3rDSeKBqmfsgVrO6X2JrOs76HhA/oeyD00tnPT+NZygdkpegeTx0U1H
	LFtqQ08495DuyLLNudi2T4Yd9Hp/EXIJBlXVWBqyvD/Xa7c5nbl5hdysLOFtHHsqBSHqLq
	+mqkXNUMx8bN9hRRhECixu3nY48lfSW1DgAkTC/QhUvJj6n90SMXQ5rUUL6fLw==
Date: Wed, 8 Apr 2026 12:47:33 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 0/7] Add RZ/V2N TSU support
Message-ID: <adYyRYcGKV-VMAAt@duo.ucw.cz>
References: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rqj2HNFKGPcJy4gf"
Content-Disposition: inline
In-Reply-To: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 10:47:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22653


--Rqj2HNFKGPcJy4gf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds TSU support for the Renesas RZ/V2N SoC.
>=20
> All patches, except for patches 4/7 and 6/7, were cherry-picked
> from mainline kernel.
>=20
> The RZ/V2H binding patch (1/7) was missed during RZ/V2H TSU backporting,
> so it was added in this series.
>=20
> Patch 4/7 is needed to fix asynchronous aborts during unbind. See the MST=
OP
> series for more details:
> https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.beznea.u=
j@bp.renesas.com/
>=20
> Patch 6/7 is a backport specific change that is needed to allow the
> thermal driver to read calibration data from the system controller.

Aha, explanation is here, I just missed it. Sorry for noise.

Series looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel


--Rqj2HNFKGPcJy4gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadYyRQAKCRAw5/Bqldv6
8uGsAKC55EmNLSOzE6wYnl86yNCcizYIhACeNF4och4+GPDwBD1NXP3OPtKvAEs=
=bZqa
-----END PGP SIGNATURE-----

--Rqj2HNFKGPcJy4gf--

