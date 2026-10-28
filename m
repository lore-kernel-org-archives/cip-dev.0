Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6251.1793219337247393477
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2026 13:28:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NPyHBhha;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F04B105884;
	Wed, 28 Oct 2026 21:28:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793219334; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=8HmFcrfUvHpHmiOCr/KwoL+4s+oCZzdab8VzIl9sh9Y=;
	b=NPyHBhha3EYtKoCOxB8NwGVC5uXKRXlTrX71eEVSN/c3Ih9YoZ5isg57fGvFHSXyMpBG7t
	TbXOkFrVF2J4UhXRBuolQ9+VgR+jqXoUjn2d2HBZHEuV9xGbYvkP0RuvPaE8+qppcoLBxt
	2tT2YOVahHX7lTNOg71UmixQHz+3Tw6jUJ2zyv5L+9MF4TEoU7EER7vLAC3bn8hUbE9LTV
	Ble2hLguObeTtAhF6CmgdPNklsyRDRjpQU3L2jRPhnbfVlH0b8pxRV9t8D6v6fQ2lCIbqe
	7ojJl/pG/bvwZCJUJudb20vnzijOpQZMIqG24iGBh7q9dnD6nwQA2tqhAbpKZw==
Date: Wed, 28 Oct 2026 21:28:51 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: IRC meeting & daylight saving time
Message-ID: <auJbAxG7BR1g-Gqd@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwb1xHk//0dm8Zsr"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 28 Oct 2026 20:29:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24560


--hwb1xHk//0dm8Zsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

There was dst change in europe this weekend. I believe meeting is
still Thursday, 12:00 UTC, which will mean 13h MET.

Best regards,
								Pavel

--hwb1xHk//0dm8Zsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauJbAwAKCRAw5/Bqldv6
8jYoAKC+zxQDiURq93+NwZN3q5oDzzuQmQCgmt26UVEOLB4QGbpGYICSx5l8Q7I=
=pY3l
-----END PGP SIGNATURE-----

--hwb1xHk//0dm8Zsr--
