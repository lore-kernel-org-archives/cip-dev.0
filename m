Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB185D41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:08:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46896.1765800525057090615
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 04:08:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ucw.cz header.s=gen1 header.b=GZ3ss1qW;
 spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 14BD81C01B5; Mon, 15 Dec 2025 13:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1765800523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7/H9hlJcYB8cwj0/K2ENEfi8ICCoEyybh2PtMF2Olc=;
	b=GZ3ss1qW7uci5a96cFgNJItrvpantj9Q99D5GTW2D47dn+trXeBhQOaxgV1Lq88+swMFT2
	AQ9uA7XJ6z8IyvSLb/k9mTzPLX3V1jLv1avKUTieoaqZlvmqs/SoLzbL7AHQPCuJs+iM8y
	GuP5EdEXyRZR2dBlAsFyKHcw0dL6MUY=
Date: Mon, 15 Dec 2025 13:08:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Biju <biju.das.au@gmail.com>, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-bit polling
 support
Message-ID: <aT/6SsDvu79jDDQx@duo.ucw.cz>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mXWOwZdySKaejlpK"
Content-Disposition: inline
In-Reply-To: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 12:08:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21053


--mXWOwZdySKaejlpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
> During testing it is found that, if the DMA buffer is not aligned to 128
> bit it fallback to PIO mode. In such cases, 64-bit access is much more
> efficient than the current 16-bit.

This looks okay to me. I can apply it if it passes testing and there
are no other comments.

Best regards,
                                                                Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--mXWOwZdySKaejlpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaT/6SgAKCRAw5/Bqldv6
8kA5AKCQXF1SkVn2x+s+oy5Ajgd6mTdnhQCgqemsANbUnIdWx13mRqDeUYYmrt8=
=uRiP
-----END PGP SIGNATURE-----

--mXWOwZdySKaejlpK--

