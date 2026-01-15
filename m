Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EFAD41176
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 11:40:33 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33803.1768477226308724769
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 03:40:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=c6OwByut;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C771810D504;
	Thu, 15 Jan 2026 12:40:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768477224;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=CFyM0eDNC0SsALyBvWQW8E6deYX85l43IBeF0SLe4x0=;
	b=c6OwByutbVORXwAeQhlRx2YfHlXF2tNTujd69aUJXQRJ485O9HuFSblZv4hEqSa1ArtSjT
	OBDpdQUgetbawk8nhccmMMthZmjTVEq2HDLe8Er4Li20SyqcD/a+2ZYWPwOVQM/hK0PrTg
	OMadkT//v9mBhRF0a3lYr21eq2mcpPfeyUjeNrqw4bjk4OuciTfWWwDZPFzTba2637MwIp
	TZd2xzgBrpBD9P0ed9iByCRHLIWQzYAhSZy/WQ+0k7fEtmY3+qqKWqQ3LnAX7jwrGQrJTH
	vId4OX9p0g6vs5DobIrKUTRFsAYjRU8Dx94bHq3eoPpIhutqNbDfoQk2wUjRTQ==
Date: Thu, 15 Jan 2026 12:40:19 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five,
 V2L}: Backport MSTOP support
Message-ID: <aWjSI5U7wVForVba@duo.ucw.cz>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EmxrZMX9M+IH00Sh"
Content-Disposition: inline
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 11:40:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21623


--EmxrZMX9M+IH00Sh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the MSTOP (Module Stop) support for the Renesas
> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>=20
> The purpose of MSTOP is to reduce power consumption by stopping
> unnecessary module's functions.

It would be good to somehow quantify the power consumption improvements.

> Changes in v2:
> - dropped patches:
> -- rpmsg: core: Drop dev_pm_domain_detach() call

Does the diffstat match the patches?

If there's v4 of this, could you merge reviewed-by: comments to make
things easier?

>  drivers/rpmsg/rpmsg_core.c                    |   2 +-

Thanks and best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--EmxrZMX9M+IH00Sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWjSIwAKCRAw5/Bqldv6
8lf8AJ9DYUjjmHZMxT7bn9dcVtltL2OEpQCglHhx1CAkug/IZMXno1Mnai17EAo=
=UNtY
-----END PGP SIGNATURE-----

--EmxrZMX9M+IH00Sh--

