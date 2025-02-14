Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46977C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 19:33:41 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.29729.1739561619981261741
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 11:33:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=EdwVyJTD;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9A071034EAC2;
	Fri, 14 Feb 2025 20:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739561618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/Pknl0MC+PjKFY6zruAsw+O6fYy6cR1ny2nKBfrFg7s=;
	b=EdwVyJTDkTrtHkittSLjmf+RRv+t7jKZ4pngyIgpenBP+4PD4HXjJ7EhAE2GjdqB4xzY2U
	HYYDD33Yz2LHo4+zkXejf2/ZhqPqFiI0fROMK1qmm+HT44UpCR7D9e7fVTf10zEIyJChDy
	j8X0zr6S7L9+DPXABv9BE4Km/nS1IueQS9x4CycHeI+iIfytPqoq9eKAkzydVE51fd3ex+
	YhT/aC+KdslJ8Xi606SlPEtj3uVYP2+2WYsjepH1bqgMCR6N0i24OG9GVjYjMRlcBfI6cW
	kAaQvl58TPV1Dxo+wnBvUzg477ZR99y5vLy1HmgoY4QWW/IvWItcJUHfCi0Zfg==
Date: Fri, 14 Feb 2025 20:33:33 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.128-cip37-rt20 (rt49)
Message-ID: <Z6+ajcS6lwDLRNyd@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DaggFNN9wXy33mjy"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 19:33:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17847


--DaggFNN9wXy33mjy
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

--DaggFNN9wXy33mjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ6+ajQAKCRAw5/Bqldv6
8hQgAKCPPtHT/rd570+OZ8xbwNT9db+NDgCfZqUu41/XlS1U+HTPdLvchG5AXN4=
=cbUz
-----END PGP SIGNATURE-----

--DaggFNN9wXy33mjy--

