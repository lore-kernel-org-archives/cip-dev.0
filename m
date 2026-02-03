Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770BDE6E811
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 11:23:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14425.1770117806814587040
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Feb 2026 03:23:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=F0HIf5VF;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C197910E016;
	Tue,  3 Feb 2026 12:23:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770117804;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ub0b1wb4jOQsyiSAcctrZjGZGZiHed7ss+JWD5fMXws=;
	b=F0HIf5VFEg1DOYL/C97bgHh/x1W3uOFMZ0ti8V9cSRJe7W0MaboHk2YzRc4Is3PaP3lcAy
	Fargc9DdZ44ub0JNDVz9eJea9+/t5o1rox1YpRigI+m6oxO20lXpZcNqxSLayNhqkJiito
	eTez1qX9DHJ7shakN6AzS9IwZzjgC1DzgtlCYmCbXDOyD1Nf4YheA1MwR0qdWW0m2gqBha
	vUZLm/Ip74N/BpfBqVZiPdRQYag2Y0oiSkD8dBoLb4a1FIeQ0wFMPR98zZ4clnTJ1t1Cvi
	DA/edEeznUI9IcdfMSnClykfsNh1I9VmDtMVejJZ/uR+RARkXBuYw1CqheV6aQ==
Date: Tue, 3 Feb 2026 12:23:22 +0100
From: Pavel Machek <pavel@nabladev.com>
To: john.madieu.xa@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	john.madieu@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/2] ADD RZ/G3E TSU support
Message-ID: <aYHaqqXncpyY45B5@duo.ucw.cz>
References: <20260203091201.98565-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YtRLpsQ/M1vm9dN2"
Content-Disposition: inline
In-Reply-To: <20260203091201.98565-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Feb 2026 11:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21823


--YtRLpsQ/M1vm9dN2
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

Same as 6.12, this looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel


--=20
In cooperation with Nabla.

--YtRLpsQ/M1vm9dN2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYHaqgAKCRAw5/Bqldv6
8jZXAKCo09trZVfnrdLyt+/pAI8XZAlZaACePh1HxiphgDchJ0onrkw2mNsbaNA=
=cXoK
-----END PGP SIGNATURE-----

--YtRLpsQ/M1vm9dN2--

