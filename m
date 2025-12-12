Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63145D49222
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 12:54:25 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12019.1765544062210191627
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 04:54:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=JFW0Gzr2;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FD4D1004E46E;
	Fri, 12 Dec 2025 13:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765544058; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qjNfpwRFiEyI5mmrvhmjzYT2fuiHEts9/RH9UIb1A0k=;
	b=JFW0Gzr2rvR72YhP9DXv10dHlgi5lFMAU8KGPWbraCAkk4L5th4floOGN3h+DOkF+5jKa8
	Qiu2pMFDpE4SiFbnAr1mky8d+WAiaflMdu0EDDt9VOJlhJxFCqG8tJyruUWfxCKOaAkJ/z
	yEDx/aVr/CTnQ4ZrTg7Xy1OxusbCTFGMWWVdf805GfrIzDpyDhsdcW7SkLJGlPF39t4ZKH
	R09gXp58hLmvfcSyfJCNJ6Sz+Kj4LPf8Xn/5OeUQCMT1INdthzt5pbytHlz2ge1A9t3vA+
	4BYrVdeMo+IZKaEylSPVjreFYJ4XN2MGGrdmSXKDphutPKObzkrfxA7CDvyVrw==
Date: Fri, 12 Dec 2025 13:53:59 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 16/38] soc: renesas: Add RZ/N2H (R9A09G087)
 config option
Message-ID: <aTwQZyolWR8CqoOz@duo.ucw.cz>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251205143258.13748-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i911/pgd0RVH9XKa"
Content-Disposition: inline
In-Reply-To: <20251205143258.13748-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 12:54:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20984


--i911/pgd0RVH9XKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit c7968f5e7c7c7b46cad1e92294c211417a7ba90f upstream.
>=20
> Add a new Kconfig option, ARCH_R9A09G087, to enable ARM64 platform
> support for the Renesas RZ/N2H SoC.

I would not mind 15/ and 16/ to be the last, so that config option
works when it is introduced.

Best regards,
								Pavel=20
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--i911/pgd0RVH9XKa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTwQZwAKCRAw5/Bqldv6
8inkAKCJkFTofAkLFbI3lUhdTM/bxvQaXwCbB/tJvOs3jImeYQx5AXNZZlKot2Q=
=ZqBF
-----END PGP SIGNATURE-----

--i911/pgd0RVH9XKa--

