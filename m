Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787BB104BED5
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:32:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18063.1773225175019327390
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:32:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VcC4ZfHS;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CE77110CD3;
	Wed, 11 Mar 2026 11:32:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773225172;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=adSnHWVnzQTDRswXjPSN9LmI632fg/Zb2Y1GIyVC9+U=;
	b=VcC4ZfHSiGP0qn8sqEphC3iCf2mLKxxPZudozbeiy+zxJ6g0diijEohJvJCh1DEb7Qr5PE
	vWHxku7nG5WygUFsWwCQeHpM4L6TKcWPWcKjFkyVhbNCstmMS19KyiKOLxhXt97zR6+uju
	2R7L5k2lEghFP5sLut0m6aa+SqlNmQMelYrmBDw0LeuWVMge3hbEctLOb0tgEF4/auluXn
	MeNJ2AD3/ZCoiVHzRnGMhwLZCuOZyOyIOy3J2B1Sb0Alwj9bhamlddRH2IFuY8rdTaj32j
	3phH1CuY2o6AcjSo2NBT/Zbj1pFuHSM80o2pJv4GRywlK41rihC4PH+pRt8QkQ==
Date: Wed, 11 Mar 2026 11:32:48 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: Pavel Machek <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Message-ID: <abFE0CF056kznlGe@duo.ucw.cz>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
 <aaxXNCvXO5KiRQJ/@duo.ucw.cz>
 <TY7P301MB198402755BA8B35FC4ABB850D346A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y4fUgPwU4hLF+PZe"
Content-Disposition: inline
In-Reply-To: <TY7P301MB198402755BA8B35FC4ABB850D346A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:32:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22274


--y4fUgPwU4hLF+PZe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This series adds display support for the Renesas RZ/V2N SoC and EVK
> > > board.
> > >
> > > All patches were cherry-picked from mainline kernel.
> > >
> > > Note: This series depends on:
> > > https://lore.kernel.org/cip-dev/20260225121232.129678-1-
> > ovidiu.panait.rb@renesas.com/
> >=20
> > Thank you, applied.
>=20
> Looks like this series is not present in the 6.12 branch, could you
> please double check?

Yep, sorry about that, it should be fixed now.

Best regards,
								Pavel

--y4fUgPwU4hLF+PZe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabFE0AAKCRAw5/Bqldv6
8r7MAJwPMVBAdZNdFx+b3rlSPL3qSwrXhgCeJ8c/oBCQKOHHs5Qujzp3zrtruPM=
=bQa1
-----END PGP SIGNATURE-----

--y4fUgPwU4hLF+PZe--

