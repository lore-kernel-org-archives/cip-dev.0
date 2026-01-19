Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC5DD29C3C
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 15:54:21 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38102.1768838058539109490
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 07:54:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Uyl36w0P;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D25A3106508;
	Mon, 19 Jan 2026 16:54:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768838056;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eTRPbLmgbo8gvyTOy7ImzvRLEPzixq410qrlwpN09dw=;
	b=Uyl36w0PR33CfuEDZR9tFlO5t/2jZZ/08TReZlYDrrWE1i4Hq9uArtLFdcV3qVfmODb6pR
	kAyMVWupnM+PC3/DclHFcz4XfK0qfExRQZYWuqWupqD46TqZZpvo8tqumQYp0eC2iF47rf
	kzXfYgd9Yu3UNQjPloNdjLiVsueyfohtHMOAHatfJkP5Uc9aWHVFAtZ1say4nMM8UpAmVc
	ec3Sxyd+5llcach93Lhl101HvWwyJxTd9yOZT6Q/ndG3QIRui87Jx85eT5IMlOKsB4piI/
	pXeg2I39jH7njRzTxQM8+eY6k7pnMnRnWcX0h1QDSspK1ZuEO/rrxadZE9VKJw==
Date: Mon, 19 Jan 2026 16:54:11 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2N USB2.0 support
Message-ID: <aW5To/fZ3bbZAVPo@duo.ucw.cz>
References: <20260119125104.32147-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9Uhn3i0fbZV22U5"
Content-Disposition: inline
In-Reply-To: <20260119125104.32147-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 15:54:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21671


--z9Uhn3i0fbZV22U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds USB2.0 support for the Renesas RZ/V2N SoC.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--z9Uhn3i0fbZV22U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaW5TowAKCRAw5/Bqldv6
8oRoAJ4qtehA2r7lsGt5gm+M71h+lmxSTQCfYtXtJtqgLjgeEIda8LQ1r6inVfA=
=dLIB
-----END PGP SIGNATURE-----

--z9Uhn3i0fbZV22U5--

