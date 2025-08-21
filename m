Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99828CA0EDC
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 11:21:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7002.1755775302155124325
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 04:21:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=M65h+Ls+;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1034010398818;
	Thu, 21 Aug 2025 13:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755775300; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QX6YsLjRwWUeWbZuccJ8OESZhmdI1aln20YANuIKoYA=;
	b=M65h+Ls+rRU1o3ND4RxyAn3tfERiVZHDyLOh2Vrojnk4Yr4DNS9k9F5csllijs0CHwCzJ4
	R/ikoRuTci6qwnEf1AHlkgvlBNKftpJzPiCDje4THvyZaRuRBro65DOQID+WKIWSg+Tswd
	QF257U5q1fyNKHKIVcEOxh8msDtG1nJ9vaG+MvLhO8mkGPTTa9wsSXNKIw7rdGLFIgJzkL
	RqBxpHwgwvEDuyKT5wsW03BNeaNlvMYYKVPkqocTjNe1NRDXl62XHhkw5JW9Lq1qGhC5rd
	Usx5kp7mbp71WV+FKinFLGcVGmm4cppLCCahG8DaCrndY2DeVrxrOEe7sNeXjg==
Date: Thu, 21 Aug 2025 13:21:35 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if: Add RZ/G3E xSPI
 support
Message-ID: <aKcBPxrTxnIw8BgT@duo.ucw.cz>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
 <20250820084645.6988-19-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xkq79rEJ+NMTW1k+"
Content-Disposition: inline
In-Reply-To: <20250820084645.6988-19-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 11:21:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19934


--Xkq79rEJ+NMTW1k+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 687cac9559d8e9277830bdfb68b57d7403695b1d upstream.
>=20
> Add support for RZ/G3E xSPI. Compared to RPC-IF, it can support writes on
> memory-mapped area. Introduce struct rpcif_impl for holding the function
> pointers and data to handle the differences between xspi and rpc-if
> interface.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://lore.kernel.org/r/20250424090000.136804-7-biju.das.jz@bp.re=
nesas.com
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> [Biju: Squashed the commit 798dc3f19c9e
> ("memory: renesas-rpc-if: Add missing static keyword")]
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
>  #symbol 'rpcif_impl' was not declared. Should it be static?
>  #symbol 'xspi_impl' was not declared. Should it be static?

Not sure where these #symbol.. comments come from. They should not be
here.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Xkq79rEJ+NMTW1k+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKcBPwAKCRAw5/Bqldv6
8pPQAJ0cAnSurgirFOZspdoA7WKTDBNZwwCfSr/sW5es9LaPZdo4n2K/fzUJUtU=
=PTWr
-----END PGP SIGNATURE-----

--Xkq79rEJ+NMTW1k+--

