Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C14F8DFC3
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 21:09:36 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26366.1776373773122291082
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 14:09:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=jx4nF1OU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA94711418C;
	Thu, 16 Apr 2026 23:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776373771;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qpNI1mTt+mUHeduDo7mH3PMlNbtDhE3CcqYjqNKKy2o=;
	b=jx4nF1OU9i67/upJLEqbTVHRqG2CyLK3sWtkxUV/rbBZwxiIQYKt5hQ5msJBBQjAJLyi15
	V8jlaBTg+bdq0Mn8MQzu2dp3U+wIheVUu8nyVuLdfadJIu4yZYKOtDiA90uNAunqEdE2Fy
	Y+DAFsoCZwPBMCkBiLKKfgbPOMqJ25X2anvKQ9QSfqo4F71zqnZhJ2Svb2UVCDWGPy8+BU
	r6FHbEWwk0iyqMfvsQKSsDXy3yHzuiCaqS82jHqYDd/m4LDZC9wk4i1tFNn5DyZ8dkEivo
	/OVv7h8t61kfUrDJ1a6lIoHxvBCt5NAmDdqA63wOzD3C0/xqLWWf3gBK3jibFg==
Date: Thu, 16 Apr 2026 23:09:29 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris.Brandt@renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/10] Add additional support for
 MIPI-DSI for RZ/G2L
Message-ID: <aeFQCcJsg-z-IGN-@duo.ucw.cz>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dU0Zk1dmymY/H17a"
Content-Disposition: inline
In-Reply-To: <20260415181810.4073807-1-chris.brandt@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 21:09:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22757


--dU0Zk1dmymY/H17a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> There is important functionality missing from the MIPI-DSI display driver=
 and also the clock
> driver for generating the correct pixel clock frequencies.
>=20
> Since everything is now accepted in mainline, this is the backport of tho=
se patches.

So MIPI-DSI does not work at all in 5.10-cip, or it only works with
some panels and this adds support for more panels or ...?

As with 6.1 and 6.12 versions, I had some minor comments, but those
should be fixed in mainline, first, so they should not block the
merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--dU0Zk1dmymY/H17a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaeFQCQAKCRAw5/Bqldv6
8nmHAJ0WzF5GbS/ZAyQleXnw7Vlw2n58pACgol79T7dHQGrXfQwpI1H3MfrBFs8=
=McYP
-----END PGP SIGNATURE-----

--dU0Zk1dmymY/H17a--

