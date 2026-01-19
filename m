Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB72DD29C40
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 16:01:01 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37885.1768838457557066156
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 08:00:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Yv/f9DyN;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82A8B10857E;
	Mon, 19 Jan 2026 17:00:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768838455;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gPbspTKHpEiSME+RbztvNWMTlN3dQQBkMnhX5rcQCRI=;
	b=Yv/f9DyNOtHS6gs12jiylb1aFbQbm9lcgAIHvalFmPsXpySV/MfTtGW4ysDMVyvXjvCwmX
	sBU5wcNFJAVx8b/sSAe2afKbfe0Hv7YpmiaTMY1l9eEXgI95RzPkVrMgBwsdWiPgFlWj0x
	0Y3n+5sGq1pa57CdTQrvL7l5YijCvCKE7ut4AxAvPKnsSlOO3ssaRWaxMp4loG6yGOpAi+
	RAi6lyFpwXJ3tDJWLHg7deglYYaIkDLcTk45I30d9iisJfN9BDBAeBSPnCSaj4CVZBZu+s
	QosYLLg07dNve8C2duizS5cfRha0UALsvwyqm5W2NCN3UpIeGUaeCzzsvXp6NA==
Date: Mon, 19 Jan 2026 17:00:54 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/5] Add RZ/V2N XSPI support
Message-ID: <aW5VNiVsV77nEIra@duo.ucw.cz>
References: <20260119125516.32220-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmM1fAe4+yZueiuQ"
Content-Disposition: inline
In-Reply-To: <20260119125516.32220-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 16:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21674


--nmM1fAe4+yZueiuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds XSPI support for the Renesas RZ/V2N SoC and enables the
> MT25QU512ABB8E12 flash device used on the RZ/V2N EVK board.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--nmM1fAe4+yZueiuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaW5VNgAKCRAw5/Bqldv6
8v0TAJ40rDyyW9KahZ7KRz3JrRdEB2KHXgCffYdi7gVQIU5BMi5W8Q8jzfJQ2CA=
=N8OX
-----END PGP SIGNATURE-----

--nmM1fAe4+yZueiuQ--

