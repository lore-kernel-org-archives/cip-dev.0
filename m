Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42630CDE008
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 10:16:07 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7935.1782382563665496263
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2026 03:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VtxS3z9u;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5573115751;
	Thu, 25 Jun 2026 12:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782382561;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ljs3tye3JKe+ttIV8MqkQiw+ooTwSu3WdQo0BG04Hx0=;
	b=VtxS3z9umDojiqAhv4ybuExu8lCoPQVX9mubrssu7r67uAUA4IwSitappbtJzsHg3cnsg+
	heQV/bGwB4fTlB2WAN+S9UodcePzixRWteVBY3KsXGSwSzehAu32ABpcYXsNmv1V+zMA/Q
	qJKajuMlBWd3reCPUClqfMWPn6Po8Lko76wvO3rQKvN/EkXLi58Ps71NPm2P6O/iIlgfXd
	r5ppcBY7KJ1ABRhyEybdOFf/q+Z3+hkterp3NQCnKJT7CyOFbWe0py5dNr0nwKilbYGgRM
	jP2zCdE5oBZC/djkmrCPOP5/gKnuwS/s3AU+KLzzwihudOTc9tXg/dLQCFlCxg==
Date: Thu, 25 Jun 2026 12:15:55 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Pavel Machek <pavel@nabladev.com>, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Message-ID: <ajz_2_TJxMeESfhY@duo.ucw.cz>
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
 <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
 <ajBolVke5ENiZ9n2@duo.ucw.cz>
 <18B987A3256F1E3A.267903@lists.cip-project.org>
 <66c961dc-ebdb-4691-a86f-c7f39209f839@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NNwIS6jY8BW0AyW7"
Content-Disposition: inline
In-Reply-To: <66c961dc-ebdb-4691-a86f-c7f39209f839@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2026 10:16:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23279


--NNwIS6jY8BW0AyW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Gentle ping on this topic.

There are other patches currently being reviewed.

If you want to help us here, could you comment on these emails in this
thread?

Date: Mon, 15 Jun 2026 23:50:44 +0000
=46rom: "Nobuhiro Iwamatsu ...
Date: Wed, 17 Jun 2026 06:03:03 +0000
=46rom: Biju Das <biju.das.jz@bp.renesas.com>

Thanks and best regards,
								Pavel

--NNwIS6jY8BW0AyW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCajz/2wAKCRAw5/Bqldv6
8qa1AJ4vdVtvTg5APcx1X8LPo3nshQKVAACbBP/EihrbX7EDp35cHSydsbi4gvo=
=hI6l
-----END PGP SIGNATURE-----

--NNwIS6jY8BW0AyW7--

