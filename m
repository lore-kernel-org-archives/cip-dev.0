Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E745CD5BC9
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 20:31:12 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23866.1779741065326345508
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 13:31:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=FypiMzL5;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 581ED1129BB;
	Mon, 25 May 2026 22:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779741062; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=ac0yDZZDwA7b5pBDib+mnCatV7DIiOEc9RUvk1J3aaY=;
	b=FypiMzL5EKKHuiC3eon5JIfMbyntHXqJZvstCfPUGiYv9veO7G471Xp7Td4XcjRzuf8Blh
	kX3Fv7hWhz4RVBPJI//UNZAgkL6UcyowRNseBRAMVCYb25cBePJhmn347HXyfC00fVrdkG
	Vd+7d+blGKKDjK/p7/8DZMCwaar38RCEK6AXo/NiHX1YYtRGX+L3aZF5oZYEyePLhcQtKI
	ePr41FpXkZjFBanrRYP2Ve2Lm3fcin8wObsodS5nxdx1va1qK2IXcw13yc8cJ2Nb+waT7x
	5xwhipEf2MOcivY7CUvZn1yBNOiv9oOfSvGi057fDocOfVtC5xf7ETZUDKG33g==
Date: Mon, 25 May 2026 22:30:59 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip111-rt61
Message-ID: <ahSxg46Y56LaS9xi@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QZmQhrUI3/FslNx2"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 May 2026 20:31:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23008


--QZmQhrUI3/FslNx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--QZmQhrUI3/FslNx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahSxgwAKCRAw5/Bqldv6
8k37AKCUB4Knh5nz8GyYHuO9GLo28ITduACdEMSWR5dSGMIIi8vTHxraKGptDFo=
=dOMi
-----END PGP SIGNATURE-----

--QZmQhrUI3/FslNx2--

