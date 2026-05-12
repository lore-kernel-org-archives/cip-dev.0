Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F023CD4F24
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 13:19:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75591.1778591997399622152
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 May 2026 06:19:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Ofu9aBoK;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75F9E11552E;
	Tue, 12 May 2026 15:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778591604; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=Q3WOIU/xYBJH96Kc+gyh8HkN1ZkNzH02iRprOeq127k=;
	b=Ofu9aBoKmDGqELjkmu41T5jJ+gV5qg+UfTcsIprJ+oWYS36B/yjI4NJQLSxCn0UEqbPsca
	t3SXXWEixnMmNmYjZFn7ouE44g56NMrUObHlUmR62OqSWBxLlCULKtdNj0rB5Sa3CwriZ2
	Nw9PNSGfpQYJs8xNFnkfJRE2anxQs6f4jI/NQGmj2EblB+tqmkOMo1fWV3fswfV+PKSykD
	avCbD7tYEkqJcAayyO8LB/S6SCnyts1QnzcGY/mLkp1LydLBRrcqMkFoABGTSZUTXuZVVK
	un0OHdLzI3J7KQucmwk7GAHq+cfFFd4++DDf+XJmZO5GPPA/xSWTfQvsCgwW7g==
Date: Tue, 12 May 2026 15:13:16 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip132-rt48
Message-ID: <agMnbGSVkku5uBYh@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+dXL/SNOO47rj6vU"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 13:19:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22930


--+dXL/SNOO47rj6vU
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


--+dXL/SNOO47rj6vU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCagMnbAAKCRAw5/Bqldv6
8nTCAJ4qZd3CC6zpubTnZRFye8Ael7XwugCeJEuFr0brbKJTf6jJdidpeQRlWZY=
=PSJg
-----END PGP SIGNATURE-----

--+dXL/SNOO47rj6vU--

