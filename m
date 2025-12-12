Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38693D4921F
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 12:18:05 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11330.1765541874864381006
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 04:17:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85F8010041086;
	Fri, 12 Dec 2025 13:17:17 +0100 (CET)
Date: Fri, 12 Dec 2025 13:17:14 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/5] Add RZ/V2N General Timer (GTM) support
Message-ID: <aTwHsY50UE33lrbh@duo.ucw.cz>
References: <20251212091959.22073-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3R6URFURUIzMfx7"
Content-Disposition: inline
In-Reply-To: <20251212091959.22073-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 12:18:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20983


--/3R6URFURUIzMfx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds General Timer (GTM) support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay	to me, I can apply it if it passes testing and there
are no other comments.

Best regards,
     								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/3R6URFURUIzMfx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTwHygAKCRAw5/Bqldv6
8ujSAKC1P5AjMRZobfjdqddloJe2sI5RnACeMreLKW89VolcjY5W831I2YK+Bbk=
=ZypF
-----END PGP SIGNATURE-----

--/3R6URFURUIzMfx7--

