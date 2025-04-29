Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3210C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:21:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.13154.1745914896931451365
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 01:21:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=LTYdlPrg;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0513C10271400;
	Tue, 29 Apr 2025 10:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745914894; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xf7yAqSweXokEi+0UXZsMW050Kz4HAMkpjRu/IiV37M=;
	b=LTYdlPrg4Rxdz1+3CkqwUMs2Ur5Ke+dABmI3CKwilG1DZg6Lcas8123jjP/7U5tg88f5BC
	Y1FUKpCohAzkuCILDayfp9LuzJ6joeqXB2b2dlp3R6ptX9nemVSD39ROQ8VTbqXM96TV+e
	5UMD/K276mE2eOMuoJ72mcfbyYdFbGG/MdqpOCaT3ZkAcOk6PXrINqpG9kwTUX0/WycelO
	pH/DFKOyAY6K+Odgm5LuMrnIvXG4ozUWgJfqe+cXlFlhP4aJ8p8Dnmp8j0+mQtP26zzj5i
	JndgCPkVJOajQjZxiXahgC8zn0HnPtS4pOdzjiXbYs6cPaKIXO9TGNyxrGhHxA==
Date: Tue, 29 Apr 2025 10:21:27 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for
 Renesas RZ/V2H(SoC) and EVK
Message-ID: <aBCMB/ipNRSXCtPX@duo.ucw.cz>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="22+cfJUA3+/eSqg2"
Content-Disposition: inline
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 08:21:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18707


--22+cfJUA3+/eSqg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> This patch series aims to add initial support for Renesas
> RZ/V2H(P) SoC. With the initial patches in, the EVK platform
> can boot up with the below features enabled.
> - EXT CLKs
> - 4X CA55
> - SCIF
> - PFC
> - CPG
> - SYS
> - GIC
> - ARMv8 Timer
> - SDHI
> - I2C
> - OSTM

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--22+cfJUA3+/eSqg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBCMBwAKCRAw5/Bqldv6
8su0AJ43IrJaz/P/jaGE8vNBYypaRRke5ACgiHh4F1Ie8zHwu4B1rNVDZvAXPOY=
=mPm3
-----END PGP SIGNATURE-----

--22+cfJUA3+/eSqg2--

