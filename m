Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC9E6E810
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 11:21:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14508.1770117688960893626
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Feb 2026 03:21:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Q49x1o4a;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4FBD10CD3B;
	Tue,  3 Feb 2026 12:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770117686;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qMDTV67SsDiR+5cWm/mglpk45+gZy0tPM/njkmoP7h4=;
	b=Q49x1o4aE3rtg3YnLnD4Fv/qD7kq8Y+qc/WXe8qXXiS992ofIG22PBSt9J8tcq+jypOHhG
	T77ZYkD6MqbSRE6BV+ItOP7l1i2//xce0iPCzXIFaW/rb+q0meg+nW4eMWmZaFVp23PqUG
	F43JPqCpG3NHRFkbWb6QVBVtne6X5INmjdeg0MUtN5bKDrEELvYcR3c7+qq1Ukl6So0kFT
	LNMEkbfs6Jo1LTwcnDeeEZNDl5M17NGedl8XF3HwYToYp4Z2YcnfyHhQ8GkbV/Df7+0AlD
	eedIWvLXtdUZxVoYpuJ7Wfw8INk4L6SwD/L0Kl7pfe0TXH0lOc+dSs7DjHEvRg==
Date: Tue, 3 Feb 2026 12:21:20 +0100
From: Pavel Machek <pavel@nabladev.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	john.madieu@gmail.com
Subject: Re: [PATCH 6.12.y-cip 0/2] ADD RZ/G3E TSU support
Message-ID: <aYHaMO8DZzKrUz7Z@duo.ucw.cz>
References: <20260203091332.98580-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XV7uqMZZKj+yqLVX"
Content-Disposition: inline
In-Reply-To: <20260203091332.98580-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Feb 2026 11:21:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21822


--XV7uqMZZKj+yqLVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds the TSU (thermal sensor) support for Renesas RZ/G3E and
> addresses an unbind issue seen with the TSU device.
>=20
> Patch 1 extends the PM domain detach allowlist to include the RZ/G3E SoC
> compatible, avoiding asynchronous aborts when the TSU is unbound.
>=20
> Patch 2 backports the upstream RZ/G3E TSU DTSI support (TSU node, thermal=
 zone,
> and CPU cooling maps). It also adds a "syscon" fallback compatible to the
> system-controller node so the TSU driver can access calibration data via
> syscon_regmap_lookup_by_phandle_args().
>=20
> This has been tested on an RZ/G3E SMARC platform.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--XV7uqMZZKj+yqLVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYHaMAAKCRAw5/Bqldv6
8i6hAJ9ubIf2l6Uc/4CNak/dcMheqque7gCeLYT3Q+byvUy/cGrlvAVei9Jf73Q=
=oQs6
-----END PGP SIGNATURE-----

--XV7uqMZZKj+yqLVX--

