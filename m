Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0047ECA5FB3
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 10:18:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7708.1790849873551198973
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 03:17:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cyAhAjC1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9CB0107345;
	Thu, 01 Oct 2026 12:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790849868;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WekQmllWbGCuUmHFxeNqwVBJsB9egbSOq94hb71fHKg=;
	b=cyAhAjC1Dv7A/tm8NwRU0acMGjv1UWPzm4Qspp19qvh+RcOVuSjSqHiS4j4xrVHMJfQAuA
	ytE5P6bdOF+GqGVKkzoNJv92aK+DZQgpNGUWsjPaCfEpv6eGVD5E5PHzhbsl2uWbZNoj1T
	1GQrj7u6eSBfiC+i2rb3IGIiDwmBlwzXXe0FeN9rKzkGd5RHZYjpjD2Tk9CaIF9j04d2lZ
	3X+D2BwF72KXzEx7n61ilMWsVpH3vChgApIYs7Odf1BakQQ6Wdi3qwnPLV8Fi4L7+TgoG3
	m3z/91AGYnhaY6JyRR+REiRFjmadLeonsNRQNAzvOaGM/hR7inTEz29L/hPupQ==
Date: Thu, 1 Oct 2026 12:17:46 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 0/4] Backport RZ/G2{E,H,N,M} iommu properties
Message-ID: <ar4zSql9jPk3V1JV@duo.ucw.cz>
References: <20260930150929.597001-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iHD6zrqKebfggEjP"
Content-Disposition: inline
In-Reply-To: <20260930150929.597001-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 10:18:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24394


--iHD6zrqKebfggEjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Series backports the missing IOMMU properties for RZ/G2{E,H,N,M} SoCs.
> Without these, some boards fail to boot when CONFIG_MODULES=y and no
> other modules are enabled.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--iHD6zrqKebfggEjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCar4zSgAKCRAw5/Bqldv6
8sv/AKC9ZBZhx5qJv+8iC5+PQD795OCILgCfe6qikqXc3/aqcO4/CngK/FSb7qw=
=nCUm
-----END PGP SIGNATURE-----

--iHD6zrqKebfggEjP--

