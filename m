Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC5D3F079
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:54:03 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15149.1769612039980984272
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 06:54:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=L3aVpFYW;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC4EB10A932;
	Wed, 28 Jan 2026 15:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769612037;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eTUACf6eAmbbZCsFD3prte48Dpx4cXqKh7M4ftuqL4Y=;
	b=L3aVpFYWk9eew62z7khtzIc0XrPTmHLVKH5wE3A2PSi8Af+aOKO/rw08qlboZt4KIFPnYn
	O62LQD95+6uh1eWmiPOIJOior7LPin5x91EXsmQRmkUPQaaH0EA+rilhUd4FP6u4msLgTP
	Tm9gHyxOTgX/+t1K7jNtTUYXUZObfiIx1XIHD1nD/Vy6kumte4j6EuALCjcr0wzpglnGGU
	ALSi8f/6ssy9Ln8v+RmYhu4QnbGBo7KygtyJ/vdzYFTnlYRq5ZQLKkQc8lxAytRlkdvZ0q
	QfOwFI+ifSK0dU/5m4ABc094fbSixMpRvCA5DavJiPMRc1oEidneHeHgO+QlFA==
Date: Wed, 28 Jan 2026 15:53:53 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: Pavel Machek <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
Message-ID: <aXojAXHZbGXvNYnx@duo.ucw.cz>
References: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
 <aXobun68mrXuVr45@duo.ucw.cz>
 <TY7P301MB19846F4567485E366FC20509D391A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ge6DxUcV3ql0h3Bt"
Content-Disposition: inline
In-Reply-To: <TY7P301MB19846F4567485E366FC20509D391A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 14:54:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21767


--ge6DxUcV3ql0h3Bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The devm reset callback that should undo the reset_control_deassert()
> > done
> > > during probe is incorrectly calling reset_control_deassert() again,
> > > instead of reset_control_assert().
> > >
> > > Fix this by calling reset_control_assert() and rename the callback
> > > function accordingly.
> >=20
> > Quick note here what if there is upstream equivalent or why not would
> > be nice.
> >=20
> > I have my guesses, but...
> >=20
>=20
> This fixes an issue introduced by the 6.1-cip backport-specific bits,
> so there is no upstream equivalent for this patch.
>=20
> Should I send v2 to include this info?

So 6.12 is okay, because bug was not introduced there, and there's no
upstream commit to mention. No need to resend.

Thank you,
								Pavel
--=20
In cooperation with Nabla.

--ge6DxUcV3ql0h3Bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXojAQAKCRAw5/Bqldv6
8ucRAKCYMGPPpFkP32d3rmMi8IQBlFVJQgCgpyZkiHWTFLu9sZx/zGuND6shCio=
=Y0CO
-----END PGP SIGNATURE-----

--ge6DxUcV3ql0h3Bt--

