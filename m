Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1758CCEFCE5
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 18:06:42 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.96324.1767722795139009937
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 10:06:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dePNdN0C;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0F1C10C434;
	Tue,  6 Jan 2026 19:06:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767722792;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/i/LKT9gV2d3mFt0wUqlZvHLkmTa6/FmGaZtWE5vazM=;
	b=dePNdN0CMeb/Wxa2ftj86O/1tYiVS36McuFTgekSmQfxNvpisTb+u0COg/YlkIOhVYmsFG
	Z8PqfdMUEXnY4c6FReeV+qAAIiFIXvTvvlDaC3h9BxIAjuUX8EQJStZ+tIK4kzn1lIidZe
	+CAl0f3v2gzE7zJUA8kEoniL7ubLijOQEBG/xEolStMBQA5HreaD/tDaf87Q/bkxtgwTH9
	Wb5ShqcuMehQrF/FyaWWFYHY+o/GGZe58A+GxikhYwntZywIoGcKvNDLZQvk3WcwhmZrHV
	dWi5P1qnzkgwDFos2veUZbxMyYMnkf/wksMU6uML8y94IuVXOciuJ4ntInlFDA==
Date: Tue, 6 Jan 2026 19:06:25 +0100
From: Pavel Machek <pavel@nabladev.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Add I2C support to RZ/T2H and
 RZ/N2H SoCs
Message-ID: <aV1PIXoRBlL3IvHV@duo.ucw.cz>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0NTjJGqLGJWjfKwA"
Content-Disposition: inline
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 18:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21390


--0NTjJGqLGJWjfKwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add I2C support to Renesas RZ/T2H and RZ/N2H
> SoCs and enable the I2C support on the EVKs. Note, all the patches have
> been cherry picked from upstream kernel.

Thank you. Applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--0NTjJGqLGJWjfKwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV1PIQAKCRAw5/Bqldv6
8nu9AKCSrJJc2I5dBS+M8R6jMgjF8yqjEgCbB775K/8q7kPB6lUeZDB6/oax0/U=
=PSNa
-----END PGP SIGNATURE-----

--0NTjJGqLGJWjfKwA--

