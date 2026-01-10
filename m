Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5B7D25027
	for <webhook@archiver.kernel.org>; Sat, 10 Jan 2026 22:39:42 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.421.1768084773093269431
 for <cip-dev@lists.cip-project.org>;
 Sat, 10 Jan 2026 14:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Ha9gAAOM;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 138A410972A;
	Sat, 10 Jan 2026 23:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768084770; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=VPqSEbaQlX0Uz9byYLph2eo3RLm3bHhqX/7z6OpGNHU=;
	b=Ha9gAAOMrNFbN4QmbCbaMRJkW4VfEovACSh/5badFTKuPlYLLZ+yetXpxzyA3gTzxtroSP
	cpn6mUKrhDOxbox+t1otjF5AEuR9Ei6y5Gip7x4CgG/Nu/46LhDjynl4hixKczAF3X7ZRu
	zwwa5hHs6NAQ/sCWuoNna5injqbQOaaR7gETlmkQUWoZ10//cC42mZ+BWMT07hZ78fBenA
	XG8zrsNp3JuGIEM4mEm/a3TFMUT2EkQ89nvFmcNeLPWsbQl9zQAOFYzgVeQLRtaTXgunDU
	Dx8Orttgo0Ckx/sQyeTjKJqwP5TxhbL0zbwv4eN/FY7SIfx57BX48oFNhFeHKw==
Date: Sat, 10 Jan 2026 23:39:26 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.247-cip68-rt30
Message-ID: <aWLVHnFYQWsNWmjj@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FBISP1rv2QdLdi7O"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Jan 2026 22:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21528


--FBISP1rv2QdLdi7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--FBISP1rv2QdLdi7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWLVHgAKCRAw5/Bqldv6
8o8TAKC3+do+fJMdJy8HRbMKopzicz+CBACffgV7rXGfuYG8nJYZ3oo9i+MjKB8=
=Ie33
-----END PGP SIGNATURE-----

--FBISP1rv2QdLdi7O--

