Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1822C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 07:02:25 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.42251.1745823687154100803
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 00:01:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dbvIJNga;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C53010273D88;
	Mon, 28 Apr 2025 09:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745823685; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BpsQ19YKPk3cjw5wRERHuIGcEdTinFq71Ckya9Dyn2w=;
	b=dbvIJNgaJYkTxsW1p47BRe2uEdGbRN1db9VmxKXzeeK7fVVZz4TlzxSGYYNFvLg21TjEhP
	QvCkXntE0lzIZAQal4oZToSJfmNlVih48JHkkknyQWmy9/QPUoNGd3nc1i/N1Ib77Vriyk
	zqI+uG6uepH78rx7jDtob3gZbdocwSJ2BcbKqrwNJN3NbIVIoc1TUPNKGuTZSAKFuLEfzO
	jVPW1X5FuRFoSimbeQtgzdG8uLmguqvssemLdSOds3wWB8kFP+UOEq+tNJl7G4HQkWgO3Q
	O6g8hIsLH6y+6hD4VA85yKR8A51yKWGX+Bo7iq9N0+EKn4DGpMl8Sux9MMV9Fw==
Date: Mon, 28 Apr 2025 09:01:20 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH v5.10.y-cip 0/3] RZ/G3S: Backport DMA
Message-ID: <aA8nwI87irhzJxS3@duo.ucw.cz>
References: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9vdwK22kOypQiahX"
Content-Disposition: inline
In-Reply-To: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 07:02:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18681


--9vdwK22kOypQiahX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S DMA support to v5.10.y CIP.

Thank you. Series looks okay to me, and I can apply it if there are no
other comments and it passes testing.

If you wanted to help me, adding note "All the patches are already in
v6.12-cip" would be nice. (I checked few, and assume they are).

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9vdwK22kOypQiahX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaA8nwAAKCRAw5/Bqldv6
8qe6AJ4+xdl2rENaGlDvL6c5FLQ3C5DltgCgvXZ8pp2XVzvFh0hmf+eLVcXHyng=
=GXdD
-----END PGP SIGNATURE-----

--9vdwK22kOypQiahX--

