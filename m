Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FB2C88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 13:36:25 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23314.1789479379304409109
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 06:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=aqXBdQK/;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C63A51035D6;
	Tue, 15 Sep 2026 15:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789479372; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=GiTb1rs+jFIJlNlhAz55mWWutHRrbmwuFSEKR2Oz8rM=;
	b=aqXBdQK/OSVqkVHkfgrBs0Fzr7bo32yKkXwLJcqOKmbzh2xzyqBr7ubSsvA3X9eb1OI0x2
	9kLRsP/tJHZfrzXNLkQS2qiBfl6+GnyNJbgsNPISbJhNCWmgol16tKcJJdtgMPZHJNGwBs
	NN/yMndSkjVrvuzYYcY7qysKkzyS0cUQAx8ksac6bMTnbYj4weSPxB4SRQAV+kAQWzyFUM
	XluoGTSVkZ+mD/zTYCs2ZGHFDiW3yiwXp8e5ua4zf8Fnm/VgobcuWAjNL0bS/DsvHT4XBL
	Z/yfclSeuwdL2ttLCuILByVjMn6kC3J0jR1HV8OO8X7F0GIoNU80lyYhKuSPyg==
Date: Tue, 15 Sep 2026 15:36:06 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: 7.2.6-rc1, 5.15.221-rc1 testing fails
Message-ID: <aqlJxhduleYsXGO1@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2td5JFAd9D481bs"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 13:36:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24187


--s2td5JFAd9D481bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I'm seeing testing failures:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2842909542
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2842913623

I suspect it is gitlab problem (and not kernel problem), but those
usually clear with retries and this one does not. Could someone take a
look?

Best regards,
									Pavel

--s2td5JFAd9D481bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqlJxgAKCRAw5/Bqldv6
8mR3AJwMWPiJlVSVIUBiKl3dxvP59dMj+gCfR7EXQoLjgFfXyiGNqR+L786zbLU=
=GcUf
-----END PGP SIGNATURE-----

--s2td5JFAd9D481bs--

