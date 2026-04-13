Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F189EF531CB
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 19:35:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1167.1776108897295480058
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 12:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=LPPoyAD4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5630112CA4;
	Mon, 13 Apr 2026 21:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776108894; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=vjtJrLzsoY5Nc6lWVTeU6gv8qJnP+8WXk9A9ZRBW7bg=;
	b=LPPoyAD4GM0YxIhwSTvJMKiLKFgA3S9MXITyQ30vBIK6oi0H7PsroVZRa8Qv699q1E1f4O
	1JRME3YZwHITvxykF5Dc17VBHhfR3BDxPsPy8sGioD46ryNovKhBiuVAtEa7l8vOgGdRjA
	0DUNOS3ESLapeh8ctw6uzpASmbeCniCyaW0d00AFDp9XzpbUVLRVN3vqT2+8tqa4KFCdQH
	ZA+SKiHDYkenVwDJCysEBsVV4hfvsXcCNugWfqJ1dMLsxEheUmOkZUEGEyWEXhvHV7qlW5
	qyq4F4f8WzCFy4Zym5CJjMgpI52U8fOSCCoGF0L/jf/7COu3eYKbDjrXRm7KrA==
Date: Mon, 13 Apr 2026 21:34:52 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.167-cip53-rt29
Message-ID: <ad1FXBucvcGYi9wc@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D5wdJDOtl4ybu1oa"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 19:35:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22697


--D5wdJDOtl4ybu1oa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--D5wdJDOtl4ybu1oa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad1FXAAKCRAw5/Bqldv6
8qPUAJ0T0uKwY8KjOM/Jux49e6ue0MxaHwCbBMDpFF0czn5+5z5VO5gAy/4AGBE=
=Sp5s
-----END PGP SIGNATURE-----

--D5wdJDOtl4ybu1oa--

