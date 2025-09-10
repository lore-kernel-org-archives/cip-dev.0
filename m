Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38232CA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 08:56:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.12881.1757494592767465776
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Sep 2025 01:56:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=A0Az69Sg;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 720811038C108;
	Wed, 10 Sep 2025 10:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757494590; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=Dhl3QcSTWGxtCPD5L0QpZzajJJ9NwFxkwYZGNex6LWc=;
	b=A0Az69Sg4Gyg1HKTLLHGB3HAPpBLqlREJY5QfobpX+QRmXXRJ2WukrCeI28ykqGm/DguTI
	Bsru4zXXZmndhvPH/oonF/1ZPws0r2iq855aJjJxMNQKPaGApL87egio2rpfjhBApPXB0e
	SNhLtvZkqWQ50zG/m8Lvg4wOcNPDCpcLFpdh4DMz/5whnyBKmyxgH8q0KtbVt3dEhVYSuL
	yUZoaRLUxE11oIfykiGS9Cl+YImqnJ6K9t4N2wV7cyhnlywQZXZqUtV87iWtIdn8edzr9k
	dZakvMZYV/C45svmhuLJY9YDh35/Oy+IeuuQ/6yMcC39uRaR9oRtbN0o/Si9Mw==
Date: Wed, 10 Sep 2025 10:56:25 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Subject: 5.10, 6.1-rt
Message-ID: <aME9OVprzmQL4E/A@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nx3/YxCnigbwJq8/"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Sep 2025 08:56:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20032


--Nx3/YxCnigbwJq8/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's 5.10.242-rt136 out. Could I get matching 5.10.242-cipX, or is
it okay if I create one?

There's no recent 6.1-rt release. It would be good to get matching
-cip when one is released.

Thanks and best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Nx3/YxCnigbwJq8/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaME9OQAKCRAw5/Bqldv6
8ih0AJ4xQES3Xk4ZWuAf6jwEiK6H8bdVGACgjBK8QhKKnfNA0J2aH8kAh/kTFL4=
=NEKv
-----END PGP SIGNATURE-----

--Nx3/YxCnigbwJq8/--

