Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D9FC77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 19:15:20 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3609.1750706111803026647
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 12:15:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Xnz0xNhb;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33A89102933A8;
	Mon, 23 Jun 2025 21:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750706109; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=cgl6GsRruz2H3CvLNo636PYhN3PKrP2sZKmCliGoGUU=;
	b=Xnz0xNhbH3MocF3lzwq56EROsPaqmnau3gCOl8j+CVnG+NlKmqbv798K/cupxMPsGm1wfY
	d69qidJQz+DpOE2zHk0+OqTHbdQYKQDU4mjx615lKc+g1VoLhDoyEI2x6dxlH+vfChvDgE
	o3CsUtxBT6X+WzVY1ItNiNy5iciTNtVddZWS2M0cCpJ5pRBg6Y3iZfX7j+ubH5uZCQ9Ohu
	tB/rl2v2lROkYP4/+fO8NTyUKkExltd2nnspxdNsmGchsnXsUJHUlC/GtPIcw1gy9o9JbL
	IpZauoTLnBYhECLPiYWpm+zvW7xKBxN4ANnyjnLLX8eX25H/vXNjed8bDRVawA==
Date: Mon, 23 Jun 2025 21:15:04 +0200
From: Pavel Machek <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: 6.15.x testing, gitlab mirroring
Message-ID: <aFmnuI/5U3dZ4FaB@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4oTA1WeKWvKsMcgs"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 19:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19216


--4oTA1WeKWvKsMcgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Greg pushed 6.12.35, but I can't see it being tested on gitlab:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

6.12.34 is few days old.

On a related note, it would be nice to get 6.15.x testing going.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4oTA1WeKWvKsMcgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFmnuAAKCRAw5/Bqldv6
8kG8AJ4xzbaJ70Q12c8vmlIdd62oPAScPgCfaszg8hXrwanV99gWlGKioteeNA4=
=+aZ7
-----END PGP SIGNATURE-----

--4oTA1WeKWvKsMcgs--

