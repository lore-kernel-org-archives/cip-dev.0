Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A486C88E53
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 13:40:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23410.1789479630322796213
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 06:40:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=E2H9hhje;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA5AD104190;
	Tue, 15 Sep 2026 15:40:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789479624;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=26HwN8DSsGJ6Wzm3gwx8m7rqFybv9weXVqagUFOfJOo=;
	b=E2H9hhjeyIZ4AqKvKSbx/k9QZJ2CnU1qbXdsvM6WfHOw6p2pIu5np2jKuSVExxvissrX4M
	4L5sgpe8y3QvIfihU8zQmPqR3AW7QEkgNSgU95k2bqs/OT3/+klhCi/Yp1TgZYKTnM4G2o
	6mpSVxQ22U5DsebtueRkolBkAafIrwQ3r99TH7Tn4vrYwwWVgsKj8o4RGHjPS7L1Qp1DrX
	MuTrAC3RS3Nej61HwqllOsfN1Gog8g9j3812sjv7V/tg7AaZsgs9QXzAEV74D5Q7cEASVV
	+76WQ87EuekXaNohmpq6msQU5NNNlNs6PMz5dhSMspZeKz9TRvVhYaQoddbZ+w==
Date: Tue, 15 Sep 2026 15:40:21 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH linux-5.10.y-cip 0/2] Backport RZ/G2L GPIO set_config
 functionality
Message-ID: <aqlKxV0w0aV6z3IM@duo.ucw.cz>
References: <20260915122321.2531353-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vpKZuKEia183ucql"
Content-Disposition: inline
In-Reply-To: <20260915122321.2531353-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 13:40:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24188


--vpKZuKEia183ucql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Series backports RZ/G2L GPIO set_config functionality.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel


--vpKZuKEia183ucql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqlKxQAKCRAw5/Bqldv6
8h/BAKCy2YjqrCzGOv+retd322cbzfXBiQCdGTg8g14ZH8p1CUzwFd1qc9uRxvM=
=Smby
-----END PGP SIGNATURE-----

--vpKZuKEia183ucql--

