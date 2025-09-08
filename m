Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A347CAC582
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 09:01:43 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.8442.1757322096401786184
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Sep 2025 02:01:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=eqD3eFYy;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7023F1038C108;
	Mon,  8 Sep 2025 11:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757322094; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=M4Rbb8LeSftR9zYskIC3y3S1R9MHZk53fb7sluc3o/0=;
	b=eqD3eFYyGowZD7EH6F8AlHWlxeO1EqKvAb7RPW0veohN7ac1jdRvmHn6LOQo5dEtjkouaz
	wl1IS9hE2g2lDL4mNzmjZglGP/LnL2iaFCKAgLz4n0Ey+BNxMojglisAfaAmuUFZT3ycPY
	96j1MzSLbtgAMYNov5+BVNlDNtP2j1G2Gu16seiVBAexduAA0Jx1sjTQzSeSIIyTtNHNom
	+6XkwA6ExxZGT7fmb6dhYQhXCIi0Ugnde9A51GP2pW6Lh5dpSxWxV+e/bsXBvBg/8bUMCj
	M8tA7IfqMvWwCaljdXFiRzD7x5loHvRM8rSTwIB8jKZyRAZ3/kuKRwSRcHTb0w==
Date: Mon, 8 Sep 2025 11:01:27 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip102-rt57
Message-ID: <aL6bZ+Hc5s0ENx6F@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kiy22LMZ2xWv+G7C"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Sep 2025 09:01:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20021


--Kiy22LMZ2xWv+G7C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Kiy22LMZ2xWv+G7C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaL6bZwAKCRAw5/Bqldv6
8sNEAJ914oltflk9nP1s530HNrue2iKUpQCY+E9ChaImKNl8BTQ+3eoN3zUxjQ==
=0RhY
-----END PGP SIGNATURE-----

--Kiy22LMZ2xWv+G7C--

