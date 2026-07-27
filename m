Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB369C53219
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 12:37:50 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29714.1785155860291173619
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 05:37:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=WLrdxcUt;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 585C5118FBC;
	Mon, 27 Jul 2026 14:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785155854;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QtmG/r3cC+L8Iybmdj/AfNNmZbBTKLA0ZuZuhDJVimc=;
	b=WLrdxcUtX7S/vF5affysfeouNuBVTvWY6hy7XFfs6nDr3m1Rmj0BVSOPDRH6ayI8mQuty9
	GaYuscXLB50Y97JS4G6ZRjleEG/7H8WfBqEKovdF4viI1stcvaGi9fjqBEneD8Gku13nob
	RnSoFX8IMSRLh2Cfm/N7nQozAqhEIWLMt8cqd7b7QOVITvL6xMoTeJJCDRGfJKATefoEzn
	E0SO0+pkpxeytBAypMc13MQ2fCrGbW3mi1KqMQsTwNHM7SXv6A9HHF0KvcyUy9xN3YsAzn
	xokjneGUxhjVn0z1MN3AxINxYLRlyZF1msAc6OL3Ele+cL5RhWbEYvGlUI6TOw==
Date: Mon, 27 Jul 2026 14:37:33 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip v2 00/17] Backport RZ/G3S USB support
Message-ID: <amdRDRxJSeiQI1Ql@duo.ucw.cz>
References: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RsWdMBh3SyWcLMHf"
Content-Disposition: inline
In-Reply-To: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 12:37:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23759


--RsWdMBh3SyWcLMHf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Patches backport the Renesas RZ/G3S USB support.

I had a minor comment here, but that should be fixed in mainline,
first.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--RsWdMBh3SyWcLMHf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamdRDQAKCRAw5/Bqldv6
8uo1AJ4uPwhtG4BNWq1hs6sohuYVnII6igCgsZDXfQ2zXtLYFwJ1U3+8u14a4Iw=
=gEWd
-----END PGP SIGNATURE-----

--RsWdMBh3SyWcLMHf--

