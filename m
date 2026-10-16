Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF68CCA464
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 10:09:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18369.1792145382636535520
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Oct 2026 03:09:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Q0+zXDMX;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B636C105D71;
	Fri, 16 Oct 2026 12:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792145376;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hFTr/wiTYPbGFDoHb6a5vG7MaCh7UDSGvS7cvnmiX9I=;
	b=Q0+zXDMXZXUD4UNExleNsoZPP8cEATDxb/NmZx5iRtTz1rx08qxy6jtPxsc3ppqlhrVPRG
	dM9uAtkSC25piNKkYtIUDz9PSOnKYIADnFebryoA8T00GSpOV+zR7Ck+6yHzGvWfIGBbZr
	EvQeBuQI5r6YAAZTzzf0kDH0+ehIG56AaAWgxiIpEkvO8Zp9U78j2h0hcK7nECEt4F7c9e
	vnHqKaAnc0hsPVRB1iZ9LCbFUsrRyx3cWulXtYRwD4oJxoCvUM0/rxN3EXvfL0Fp3PxXN7
	a5A8jj/cSw7vmGMLyVk+1mTQtiHNn61sY7BF20u6SmkgVjpczOvKJqurGFm7Pg==
Date: Fri, 16 Oct 2026 12:09:32 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	john.madieu.xa@bp.renesas.com, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] Remove duplicate field_get()
Message-ID: <atH33BfCxojSs-AN@duo.ucw.cz>
References: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9CN0xjlWwALNNE7"
Content-Disposition: inline
In-Reply-To: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Oct 2026 10:09:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24478


--q9CN0xjlWwALNNE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This series fixes the duplication of field_get() introduced by the LTS commit
> 94cad2c26306 ("bitfield: Add non-constant field_{prep,get}()
> helpers").

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--q9CN0xjlWwALNNE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatH33AAKCRAw5/Bqldv6
8sRkAJkBHSv+Gqi2Q6y3o526IpRSulsRTQCcDhxd0QxVJZI5qU7kM8+rPjxctDA=
=LBL5
-----END PGP SIGNATURE-----

--q9CN0xjlWwALNNE7--

