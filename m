Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D27C0218F
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 12:09:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.17973.1738325386673628801
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 04:09:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=QRLQu+jW;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BC3C10382D08
	for <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 13:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738325385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=zf4xYfBsuAxuOQae5ijt/eRtACSlSxY62NtjXfVXuG4=;
	b=QRLQu+jW2wnfrOXsFS+1u2Auy4H1VBP6LYsX8yJ6HECSDK2wnpGpxQ+OV0BxeLY/4xS+gD
	HlCOf/OwHlbn1CIHa7vjyOVOcn2cLB7RuSn/OIybOkZuWVPt5TlkZk5YcVGY3tNPB4dIkc
	FtSFY3Oh8W77XJ4XILkqDV94tfzSVRsBq339yBIkax9yCJuVb/785PmSx4tam3iMEZ5nzC
	SaVi1bWoXSxf39+JRp/9NZtkP/FVEOsfRx96GacLxzpVGv6yaK2Wj2MJ6FaU8zNJ6x46jQ
	x9ndABx44qMB4zuVAqMkcotDJQ0xgpcMi1LVczcasfTEv5bJ20R3iXw/xL+OOA==
Date: Fri, 31 Jan 2025 13:09:41 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: 6.12-cip: please provide backports for 6.12, too
Message-ID: <Z5y9hdHd5KpV6G2Q@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Lq3cTicQpcOzs5N"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 12:09:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17719


--5Lq3cTicQpcOzs5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

As discussed on the IRC meeting, we should be preparing for 6.12-cip
branch.

If you are aware of patches in 6.1-cip that are not in 6.12, please
let us know. If you submit patches for 6.1 (or other) -cip branches,
please provide patches for 6.12, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5Lq3cTicQpcOzs5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5y9hQAKCRAw5/Bqldv6
8qOnAJ4zDz5ytxzz7yUqiToOTZCwDbpKzQCgi5sF1mbeuqRO/UexQvG2rU2ZY0I=
=/upZ
-----END PGP SIGNATURE-----

--5Lq3cTicQpcOzs5N--

