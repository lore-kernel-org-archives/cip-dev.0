Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB8BC531CB
	for <webhook@archiver.kernel.org>; Thu, 23 Jul 2026 09:52:27 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19781.1784800342688078600
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2026 02:52:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=GtKB6vTG;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C175C11B029;
	Thu, 23 Jul 2026 11:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784800340; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=92kfuiILZI/Rx8dVb5Iszwiu+d3/P2VsaWeI7PaH8bQ=;
	b=GtKB6vTGnlPH/aR1go47TcgNuB07RN1wUOqh6t2w7GHvTdwLuswThAWsJ/ftNlclyNVSIx
	cUv8Sk3Rt3ID/9k7YWAtFn7cqkl1eXXxUEYexS0yu7icrmFhTDDWcHTHj610mCrhjxZpyD
	aws+wcefZCpN4OiPUWVmRTNSVp0J8hutwUCRrhO6udRFW/gHOTSfU4/fen3EggyJ5jnlLc
	QF8Wo1Y4Bc5++qqMZPuPO9jIIxppWza0Ka7BMaqQIxhw1HeFsO3baHREQCE1Qt8hwJMzmT
	wIPyuaqvUeeqEvWTVtC18QeQFxR1eDJs7+R/XpCMeLAs3advlAXm5i6cMX8cOw==
Date: Thu, 23 Jul 2026 11:52:17 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip134-rt49
Message-ID: <amHkUWDMGea26fIf@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xuoWfNCyLae2AxRo"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jul 2026 09:52:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23725


--xuoWfNCyLae2AxRo
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

--xuoWfNCyLae2AxRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamHkUQAKCRAw5/Bqldv6
8rrgAKC3D1t8bOmzKfhctTaN1sR5gOKsiQCfVgDqWPapNAKBbkjelv26EqiPsvs=
=vHPd
-----END PGP SIGNATURE-----

--xuoWfNCyLae2AxRo--

