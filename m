Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEBE104BEDB
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:34:28 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18075.1773225263617171159
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:34:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=F6ONaqNj;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D89F4103E88;
	Wed, 11 Mar 2026 11:34:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773225262;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HHAEC9tXOT8WEyG4MKwW1V6YyNlw/XvjqdThma/nArM=;
	b=F6ONaqNj7B8BSZmwZA/zTesiIQkMi2Q2IgbIdQN1cBQfwGlAvY8ztMJmnLZwYrv3TVMX/1
	TeVbIZcJPLiniVsfoImBDxL5bdRXnYgvIu4VPzvdnly3uqGuubnilDm+g5AJOuKoOND621
	v38ijeH8BEPwjHonksOUxJgW/hdZM+gpXNlUwCAMG4NKNNF6zlhfldfWwBUMNt4olV0sFB
	ZX52We9C+qvINj3QzU1mOmL1dZUficJelUjXSJwYl/NYRSvCslbgn9308/vtmJc4gK1bRa
	7xI++hQXyK5h/hjkIyUwuh+ssy9J12/VwRZERWn428Mcx7wvaLb2u0M3wTMSJA==
Date: Wed, 11 Mar 2026 11:34:20 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/5] Add RZ/V2N Interrupt Controller Unit
 (ICU) support
Message-ID: <abFFLOUfBwQWKZpc@duo.ucw.cz>
References: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bk1Wa001QQNESpHB"
Content-Disposition: inline
In-Reply-To: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:34:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22276


--bk1Wa001QQNESpHB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds Interrupt Controller Unit (ICU) support for the
> Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.
>=20
> Note: This series depends on:
> https://lore.kernel.org/cip-dev/20260305153725.19821-1-ovidiu.panait.rb@r=
enesas.com/

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--bk1Wa001QQNESpHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabFFLAAKCRAw5/Bqldv6
8soRAJ0VD5gaYs9zzdLa3ED1NSGe33LbvwCdFZ3GvsnKhZAn0QYyTQuNkXp0YKM=
=Nb0q
-----END PGP SIGNATURE-----

--bk1Wa001QQNESpHB--

