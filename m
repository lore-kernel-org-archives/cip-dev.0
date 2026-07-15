Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8359C44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 11:02:22 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3692.1784113330521786496
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 04:02:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ghGp3Zey;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35885119BB3;
	Wed, 15 Jul 2026 13:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784113326;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BGgkJZ1YIOpebeFL0uwFxF6wfX4u0fS1kSR1t3WNA/k=;
	b=ghGp3Zey0B8rE36Jd49w9QlnDZnutO64TuMQOjJshqlbLK8+GRpmpQiLLcPUIjSSVhuM3A
	uuqE5CxjA+pTmJxQCVws0ZlI0+I1UecqQGB98Bh6TYDq8JjzNSM3qUedIrmllq9qMNU0ug
	c6ljxBO+qCMESy74bBk6MKaMNI1/G4FF/YaKzNzl346q+wQbWhXX17ttZ2RQBw9a8xvywY
	oY341bl4oKfXxNaGmLJA8nIqBBtnFRKcATBOFey8fvoQR4fAvCMgygrRnCPkHHlIYqsHc3
	OF/7x/Ab8Esc1Mpz2UxMoahe7ztlGGiJzZMWPnW8hJIpp+wMiMG/+FPZ8aQCDw==
Date: Wed, 15 Jul 2026 13:01:58 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/4] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
Message-ID: <aldopt3Cx04KEM5L@duo.ucw.cz>
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hz7MoXn3ISsSc94+"
Content-Disposition: inline
In-Reply-To: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 11:02:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23595


--Hz7MoXn3ISsSc94+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add the max-frequency property set to
> 133333333 Hz (133.33 MHz) to both SDHI0 and SDHI1 MMC controller nodes in
> the RZ/G2{L,LC,UL}/RZ/V2L device tree.
>=20
> This change results in approximately 33% performance improvement as
> it sets the SD clk to 100 MHz instead of the max 133 MHz.
>=20
> All the patches in this series are cherry-picked from mainline.

Thank you, applied.

Best regards,
								Pavel

--Hz7MoXn3ISsSc94+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaldopgAKCRAw5/Bqldv6
8koxAKCLaGBTxyQXHMj4P7mkZFM4n5ACywCgsceOxtiK/apun+ffBlIoteBww+M=
=CAR6
-----END PGP SIGNATURE-----

--Hz7MoXn3ISsSc94+--

