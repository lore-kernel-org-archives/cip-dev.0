Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE2CC3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 12:49:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.12399.1743684565777057314
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Apr 2025 05:49:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hyHywiJ7;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C446C1029837E;
	Thu,  3 Apr 2025 14:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743684563; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=y8amJntVYFCSDzAWuW5rWr477JgPgy+48D4jw4uVZSg=;
	b=hyHywiJ7Oz9cJgvBFRO0Nsjmlx87rZwOgK67ZGuiaOEuKqatoQT6en9f0fVrdTAdobnoFq
	MumNEp8rCq3k1hH3JQyOVR4jxBpm5LB66/V2QVSMKcGHkkhJenYdwhLc8hrkrVMsVXQGUW
	6pXWDshSM6qyUAO9ZDIKnzlK50j3fExZ1e3B7Mn9Ky1OV2/36nRh75l3kAcEPGel+ekUwB
	aCJsjsmATPq1S/fhwRPGjbFnZZxy2wqgf5H/fTr3nDFQvIV/LlI7wwBaZi1ZlczSsiDdUp
	cQrL8K1JuWavnsefuLjGKdycjWT25P98p9MX9v8Sx5IRWKOkOcH8GWtOho9d0Q==
Date: Thu, 3 Apr 2025 14:49:19 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.132-cip40-rt21
Message-ID: <Z+6Dz/rET16OpupE@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="40gmkgLw1iVI4KYv"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Apr 2025 12:49:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18462


--40gmkgLw1iVI4KYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--40gmkgLw1iVI4KYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+6DzwAKCRAw5/Bqldv6
8jzXAKC1eAKbRIFnXY5vkCYQavwZwJkQpwCgiJvoDkpVc5nqTwMevEYXQuUYRTc=
=6Txl
-----END PGP SIGNATURE-----

--40gmkgLw1iVI4KYv--

