Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA57C3ABA3
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 10:16:17 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15579.1746180971892827840
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 03:16:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VzSV2UOq;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E33A710267FBE;
	Fri,  2 May 2025 12:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746180970; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=d3RSwLWSsjh+dMeXk4CpDr1QuB3+/fxWuqKGCn0SjMY=;
	b=VzSV2UOqUlGd1rNH0GlE/kdt2BnpgUdlzOl6NCezpMHd1KLm1yJYtrCi0oaL4CwXiW1OQn
	XEaYyE117UkmqMQZoUXB+p0ORnqIpN/qTEGQJxW6KvGtzgNUpZIyAd4h8hE75bNuF1a5Hu
	yQWTyg60RGxgoTactn4yPWWu70Hs6kV9SniowbAIFvxtf//ew441iIznmQq7/g3XUaXKM6
	/VaIR/lAE63SpOmBkLcvj91NKTHU5fnb0xOc7kXlIM/Bt2w5ldIIxotc/jCifus49UKegd
	LEo8v+LZQK870jNtQH70IHiZigQH3QincAKWG1GcWX6aFX61g8pRWHDXfjKjCA==
Date: Fri, 2 May 2025 12:16:04 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip98-rt55
Message-ID: <aBSbZI/zHqgAGFNo@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qoJnhNt9r1QjsvMR"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 10:16:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18757


--qoJnhNt9r1QjsvMR
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
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qoJnhNt9r1QjsvMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBSbZAAKCRAw5/Bqldv6
8mM1AJ9wJRjNVbKOtAsSba4kO55g5ae7UgCeLZMN1dPmy20flPqy13ROgz1nAEQ=
=3eZS
-----END PGP SIGNATURE-----

--qoJnhNt9r1QjsvMR--

