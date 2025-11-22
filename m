Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B522CFC521
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 09:05:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6294.1763802319860911547
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 01:05:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Vn0Oz+TU;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AC621007D74D;
	Sat, 22 Nov 2025 10:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763802317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EjNvCIn02betziZXpIRHnkRnlHHpXwcRo7WNblMmYsQ=;
	b=Vn0Oz+TUD+dlesRvZUYurnFhaoQ4vKmroDF8kFZdal9TiYLD74snlD/YTahmr1kyArj7BF
	FtbtcksMRh/choaKxIz9kg5b+N0M3KHFVal6CXWR8vidT9j/xop2VJKe5zH4vP5nxP+wTm
	bX0m0Z64gd+05ZuERdUiWCIFFXQXvcZL0QWCxZK/eNZXaMHy4LxlO86cFzfHUjKXmBOLTt
	pIHn7Bz1wyRdt0tCvK0ogo1cnscMNf1XcjR3QGEyc47yiCsR3lWlvRHf7jVIWEsX2zpE0b
	9xE7GqjMP+V62645LAXS9HTTxFCrr3OJFcplMQAyoYY2ED1grN+NMYhhJDNmHw==
Date: Sat, 22 Nov 2025 10:05:05 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/9] Add RZ/V2H USB2.0 support
Message-ID: <aSF8wdGCBHk7UJzs@duo.ucw.cz>
References: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fiAfEGwNzNwLUZM"
Content-Disposition: inline
In-Reply-To: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 09:05:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20686


--2fiAfEGwNzNwLUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds USB2.0 support for the Renesas RZ/V2H SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Series looks good to me. I can apply it if there are no other comments
and it passes testing.

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2fiAfEGwNzNwLUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSF8wQAKCRAw5/Bqldv6
8srPAJwIxnZO9wz31AbOHkZDVmmWj7XoAACgpOiIrpVRdfvidCG/mkbONIIGpS4=
=IK5v
-----END PGP SIGNATURE-----

--2fiAfEGwNzNwLUZM--

