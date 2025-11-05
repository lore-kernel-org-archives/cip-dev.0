Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A496CCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 20:30:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19878.1762374621609260907
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 12:30:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=I7+6h7cX;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8B7210398810;
	Wed,  5 Nov 2025 21:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762374619; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=p3fPbFauhO+ft4bYB2V7yb8CHAeobE5+6ygkUwVdkyY=;
	b=I7+6h7cXj/Ub3+qSXW6r5OLz83epnKiMf4OR2MQLWUfvViklLjA3TyUUOSrbyPVrqZBQ0e
	x3Gjkxmc7mOzaD0U7rlfUNhOt+pY1smzi4yVTlYaebC7G3dwcTfDVMnf3btqHD3qehG444
	hoez3a6lElFxGS9vHv6gWyiFGo3aIBIKmI6Amxh/v9xx2k0E7IxNdod+WNYrRxi6Ms5Rl0
	b1BCFi//gD3yueHaQE7OwkeRZ2CT6xFjr9k/DWqMphW73qIlFwAmXvNKPIS3eASuCIHS2f
	OrTi71yQWzX/Q2JzGz2Gzh1VXX9nKDUpv+CsEaFtIO398vMG0gNRdJn/7vPdXg==
Date: Wed, 5 Nov 2025 21:30:15 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.157-cip48-rt26
Message-ID: <aQuz1zrUaJKmaYU7@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/BVq3z2C0Xsr3EkQ"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 20:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20366


--/BVq3z2C0Xsr3EkQ
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
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/BVq3z2C0Xsr3EkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQuz1wAKCRAw5/Bqldv6
8v5WAKDBN+S9rXHV+eTX411TrdBSjqjFgQCfY5vJ4Pnb4aMldkHGDGvxQ+uFgOE=
=iAbK
-----END PGP SIGNATURE-----

--/BVq3z2C0Xsr3EkQ--

