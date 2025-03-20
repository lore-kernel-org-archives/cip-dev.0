Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C013AC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 10:02:47 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3794.1742464955492047341
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 03:02:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XYyHIp0h;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D183101E90CF;
	Thu, 20 Mar 2025 11:02:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742464953; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4Hm5aptyRKr71soy+xBndPuCBn6Flje1nSnLRPkVjcs=;
	b=XYyHIp0hKhlrS0cscqW5j2uj+wyprr5ATWFj3TfNkD2VT0yipECmN/c0YFDzndipL2OYJO
	Oboie0nuc++v/FcDCUStKECsgzLyZzphSt0NeTW/X24TVe4WMqSudGBDwNTCJvy9cu5QvB
	Hxv7yxA176jilHR7pJD5gnyT0/WgIciiCLlAA0LcY6HBbmH9TqrJ21lN/RCOY+5F2k+gg/
	pb1z2uTSM15W303Dmd5MiOWPbXugxF4DDb6UK5KYqOnDO1R+oB5fDKhbs7wxG4HpQjwzR8
	lL+ClkBzocKyyCNu29qUQOgBaLhB1SXGpZAWbKQ83jvMVPSjWaiQBjY6nqXAlA==
Date: Thu, 20 Mar 2025 11:02:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support
 for RZ/G3E serial driver
Message-ID: <Z9vns4WDhX0uvZ2N@duo.ucw.cz>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
 <182E2D5440856AF6.20726@lists.cip-project.org>
 <Z9qcRBPx38dI4QtV@duo.ucw.cz>
 <Z9qdLZ6MSVEaMpj0@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ByHjVEvjxQdf1kuI"
Content-Disposition: inline
In-Reply-To: <Z9qdLZ6MSVEaMpj0@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 10:02:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18290


--ByHjVEvjxQdf1kuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Yup sorry, I forgot to update the cover letter :'(
> Basically on v1 I missed my SOB.

No problem.

For some reason, your patches don't seem to hit the cip-dev mailing
list (?).

It passed the testing so I applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ByHjVEvjxQdf1kuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9vnswAKCRAw5/Bqldv6
8jDOAJ9+E6EWhUwKWKbcgviCC7pAWJ8QOwCeIKxrhpZ8rL9URSd51bUipl6yJBs=
=HHuc
-----END PGP SIGNATURE-----

--ByHjVEvjxQdf1kuI--

