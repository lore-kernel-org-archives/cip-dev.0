Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2252CCFC520
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 09:04:19 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6252.1763802255152193079
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 01:04:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XpI+UznS;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FFDE10092103;
	Sat, 22 Nov 2025 10:04:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763802252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3HmHRKkOeyr7w705ET1fdha2K0Xw8a3c+fwi0sFqU4o=;
	b=XpI+UznSiRkW/D1MCTEzm5mKxm5R7sMSlQvtIzBkVQyjBlzvDRI6ChgEgE1r+XQdIR4Z25
	sZjtfaH7nz8ij621KSmMZz4Edn2OfMbShfGY8LRARWZ1Ia3eR2WZRyUcH8VrEwp1o4RETM
	A8WkHR/CvGN2voT5+2ZdR7FhEDqiAer7wUSUwpkqjbeFJplb3Z5hqiQu+uuih62rslmqsz
	Y5rLDkIG9GuG6fAcPAorA1zQe8L1m2XJyMJ16yKKK8BFiK3ZsX4IN7V/is44uNiTQQNiBo
	Xas8dFgpXXEAVikhOeTP55J7xlWgbvel+lC1Ypm9JbGx+LVzI6Qmv8Y6tNRbOg==
Date: Sat, 22 Nov 2025 10:04:10 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 0/6] Add RZ/V2H XSPI support
Message-ID: <aSF8ikxWk72YRxv/@duo.ucw.cz>
References: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6tTuu5tu1Rwc+w7J"
Content-Disposition: inline
In-Reply-To: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 09:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20685


--6tTuu5tu1Rwc+w7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds XSPI support for the Renesas RZ/V2H SoC and enables the
> MT25QU512ABB8E12 flash device used on the RZ/V2H EVK board.
>=20
> Patches were cherry-picked from mainline kernel.

Series looks good to me. I can apply it if there are no other comments
and it passes testing.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6tTuu5tu1Rwc+w7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSF8iQAKCRAw5/Bqldv6
8lLCAKC18Wj7gTd6iKMSFnlv5wKmmsxOPgCeOgS4llIKe5KKJB9Boq7Knvk/yx8=
=dBLH
-----END PGP SIGNATURE-----

--6tTuu5tu1Rwc+w7J--

