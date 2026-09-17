Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE243C88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:43:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35586.1789638213643360595
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:43:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=G+iH6YtU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57846102ABC;
	Thu, 17 Sep 2026 11:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789638207; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=6vlasTJB9CBCPOA4Y8PbY68a7+jbLRa7qo8XcFswUlE=;
	b=G+iH6YtUmm3W6PVMcPFucCLItoQyBa1p8Q4FD9GEPOEfVO2HB245+mTIqaHH8C0WIme+ef
	X8efXuFVDVFtl/OuXbRh3wnnXmzgQrOHwyTIZjOjEuvHoRRPBS3q0men/DkB904HFlOk9p
	k1r/nz3/xXTSumOLij9CKp5yRmME35eI5kbQPlhAekKWSaHfyGYMlMdy3xJZ975CRncJ8+
	CsDf3eVI+w8io/L2tKW8Lm54AewFHujEXT9wRqGhSktLoodw01I8OawdN8g3NbqeJyeGDu
	6cFLq+nR6o3Y9r2uvsaC1B60/214VHXRLRG1Dbgf4a2EKk6i/Uyp5vpxq4ljAw==
Date: Thu, 17 Sep 2026 11:43:24 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip136-rt50
Message-ID: <aqu2PACWBpiJURyl@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p/X8IO6a1ZCTMfiA"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:43:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24219


--p/X8IO6a1ZCTMfiA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel


--p/X8IO6a1ZCTMfiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqu2PAAKCRAw5/Bqldv6
8vD3AKCwx3GGpILannpxgCAEDDgEVcGo4gCbBTdhBL5BN6ykETqipZ83670yBfA=
=LZ7Z
-----END PGP SIGNATURE-----

--p/X8IO6a1ZCTMfiA--

