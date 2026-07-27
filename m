Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB1BC53219
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 12:40:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29764.1785156024044279165
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 05:40:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HcH2VmE2;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63FC4118FBC;
	Mon, 27 Jul 2026 14:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785156018;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4RY0IMYx8oeDMN95h7SOTeX0xePE5ICbpZFYHVTWflU=;
	b=HcH2VmE2R+vWJsOp7lzvWVT/6DyXzAcgAORUtKVb0RX7lxJcZayV6N+dqX/h3W/Vj6Lz6M
	7s4pqFdXLPJdcqmRVJnrHqBP3yXYAYDw7a/zbMK2jchwl4Craxw7LrnVJ22um9YzOvDjFy
	CWtJlvxmmGYmilMvuMlT/xF0cFCyNk9/9hilKYVGI7gWdoeELH8acKaibSThlR2H5B+kRo
	BD7DXMxpx6QNOFaHlJ1VWpKNUoHoPm8tHkYzuGGbLJtQW70rJW+7UU5TyPkeHVC9Lc7SQY
	mC3c2/0/PSv/+03xAd3pO+U0rDRxiM5erumlUO3SQu0eTOqrL4TZFR8Ohv6pYQ==
Date: Mon, 27 Jul 2026 14:40:15 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip v2 00/22] Backport RZ/G3S USB support
Message-ID: <amdRr8AyS5v6aAob@duo.ucw.cz>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KOt96YbKGCxwFljY"
Content-Disposition: inline
In-Reply-To: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 12:40:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23760


--KOt96YbKGCxwFljY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Patches backport the Renesas RZ/G3S USB support.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--KOt96YbKGCxwFljY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamdRrwAKCRAw5/Bqldv6
8sFrAJ90Mz/U3Jt7UgmqzeamsmCil09iCgCeJZVuLN5VDiyKt7voG/4UGihiS5U=
=T6Dw
-----END PGP SIGNATURE-----

--KOt96YbKGCxwFljY--

