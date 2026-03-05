Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4D3EEF328
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 08:44:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39845.1772700238718279625
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 00:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ETiopY29;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D5C8101FAE;
	Thu,  5 Mar 2026 09:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772700236;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jw04Gg+LmPAX8oimytj4Z3qj7APOGtEbDJoQemUvgaQ=;
	b=ETiopY29ValwL//s5CXiFI3wPZX+3FwR9syApOvvwfYYd5gX+lJXgMiz2sssGNkMTdJIl+
	bB4ErKggHPZLAxmJkgEe/nT0O3Nm5mlapNT9391myOWHK7oIKgtM6c8Z5sGa6BTuCJENfe
	2aWjCqMiXHx6WL+0i9DtzSwBY2S2pAXLFj65Xz+Qk7lM3jQMRHoRsPVUmGIHOGNyVo4znC
	tgWTnGbUQKz2H5Ve+OQ+INSdx38AI6zPZAx4WUr8S2mh8EAA1nWuUoz1fQYWaL3p/44k7p
	uWov2glRr3GQWXTnmbKRyilcmOL5NWkorFwI96XUvLLujOkcdv8r8NxR8NXeIg==
Date: Thu, 5 Mar 2026 09:43:54 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cosmin-gabriel.tanislav.xa@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 07/11] arm64: dts: renesas:
 r9a09g077: Add ADCs support
Message-ID: <aalCSrGJNlwyuQU4@duo.ucw.cz>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260303165351.914437-8-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sx7gA9BAHBn7M+W6"
Content-Disposition: inline
In-Reply-To: <20260303165351.914437-8-cosmin-gabriel.tanislav.xa@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 08:44:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22077


--sx7gA9BAHBn7M+W6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit a82a42963c89085d79c7f260495bd6e9601a37f8 upstream.
>=20
> Renesas RZ/T2H (R9A09G077) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 6-channel
> ADC.

This should be "12-bit", I'd say. But it is in changelog, so nothing
to see here.

Best regards,
								Pavel

--sx7gA9BAHBn7M+W6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaalCSgAKCRAw5/Bqldv6
8l+aAKCzLlhywCk6drbtrHuiyK4r/Q8OhgCfWBnQoHeUaLgFJinCwXFy5zOwnh8=
=KgWo
-----END PGP SIGNATURE-----

--sx7gA9BAHBn7M+W6--

