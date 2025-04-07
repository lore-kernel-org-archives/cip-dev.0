Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AFAC3601A
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:49:47 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.41569.1744012181370268140
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Apr 2025 00:49:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Ia+mmlsV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30423103B92D8;
	Mon,  7 Apr 2025 09:49:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744012179; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ShULmC3PxyWcKQapZshabJHiYKsuBXvOQi77NRCfjmU=;
	b=Ia+mmlsVO6EyCt8uTszes2lRxD8dvgbKG7mxNZcaoVto/GNF7UJYyAke54ThCJEPAKbrwq
	h9Ub8EiYWLeJqGbV7GE0UoYChRGIfHLVRisq2kv7tXqx0hz9lzovSspadl6sQazfhqG73x
	bsNziBZptOq88MuX/HVi3W8TjC5qLIvt/WG/m966JRqTfAOoOSTW+niZQvmYjOZbTSmt/1
	/8bXnCjPor2LIBCpb3c2lNCWMUmoExcr1X1isrjM6Xt7yggDTuzm2HvGByjBXFab+CdTx4
	Bib8qfVWdkoUqDin6Z2L3+bfuykgcdLgGrWMTRTZgciDsiQYCMCQveZ7JHq18A==
Date: Mon, 7 Apr 2025 09:49:35 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 0/9] Add RZ/G3E RIIC support
Message-ID: <Z/ODj1/v2a/FRFp5@duo.ucw.cz>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t/qAOVq0e/g6cdKF"
Content-Disposition: inline
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Apr 2025 07:49:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18483


--t/qAOVq0e/g6cdKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for the I2C Bus Interface (RIIC) found in =
the
> Renesas RZ/G3E (R9A09G047) SoC to linux-6.1.y-cip kernel.
>=20
> All patches are cherry-picked from mainline kernel.
>=20
> base commit: e423d82c34b97 Mark this as 6.1.132-cip40 release.

Thanks, applied.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t/qAOVq0e/g6cdKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ/ODjwAKCRAw5/Bqldv6
8nYPAKCaaCUZrxhHU3ZP02sl1J9uIcS55QCeNgy8Pz5ASu3/IKeKL0AK575IQcY=
=Uiv0
-----END PGP SIGNATURE-----

--t/qAOVq0e/g6cdKF--

