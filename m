Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD84D5B168
	for <webhook@archiver.kernel.org>; Sat, 13 Dec 2025 20:29:02 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12939.1765657740145519987
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Dec 2025 12:29:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=iU7+4Spi;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5573110A991D6;
	Sat, 13 Dec 2025 21:28:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765657734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YD+QmPpAO8H63S4a+/jBUf7r1M3q/6J2rakpK/fLoRU=;
	b=iU7+4Spi3pBaeuZcH5G6cT9W6dHYKTshwCY89w+pRiSCMrAg4UEkkCbQR325ZNKk2umO9G
	CWdiFMJkEbEAO9z1fZ0j6+b5rlG2WF97qCFsV4h5WlrtAg4GJlUJHAXlxWnpizJvgBDiCa
	fSJ6dnEGOW6QzNMTWczv6tayQOe02j2RYTs8Yvybbgwpw0gwRFzmJK8dxndzeNC5JgKD6d
	FWSYjx/o7u8bROUJ11LUoKx1NcJ35JEZGOqBu+fDxPaXBk1ROAdWC/NewCJr6pAM9gEU2Y
	u6NHTQZt1JPHnQIMAjdgEpaErVhevc7RXGVQoFMPILMSdsODZLVKNbKsoKwzOg==
Date: Sat, 13 Dec 2025 21:28:51 +0100
From: Pavel Machek <pavel@denx.de>
To: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Add RZ/V2N WDT support
Message-ID: <aT3Mg2yLDdswHQ7v@duo.ucw.cz>
References: <20251212213804.24005-1-ovidiu.panait.rb@renesas.com>
 <CACe6DC6-RyyEbor39QXftawrwR817hh=s6Bnz7CDed8Ty1tmfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0nPzOmrcjSKB9AJN"
Content-Disposition: inline
In-Reply-To: <CACe6DC6-RyyEbor39QXftawrwR817hh=s6Bnz7CDed8Ty1tmfA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Dec 2025 20:29:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21013


--0nPzOmrcjSKB9AJN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Lad Prabhakar (4):
> >   clk: renesas: r9a09g056: Add clock and reset entries for WDT
> >     controllers
> >   dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056)
> >     support
> >   arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
> >   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
> >
> >  .../bindings/watchdog/renesas,wdt.yaml        |  4 +-
> >  arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 40 +++++++++++++++++++
> >  .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  4 ++
> >  drivers/clk/renesas/r9a09g056-cpg.c           | 20 ++++++++++
> >  4 files changed, 67 insertions(+), 1 deletion(-)
> >
>=20
> I reviewed this series, and it looks good to me.
> I can apply to this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

It looks good to me, too, and it passed	testing, so I'm	adding your
reviewed-by and	pushing	the result.

Thank you,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0nPzOmrcjSKB9AJN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaT3MgwAKCRAw5/Bqldv6
8hlHAJ4zQP+FRVXycC2kjVK8/3J05zuNUACeOwdFsH7NKvgiVuqNsAZX0AI5Yjw=
=qvai
-----END PGP SIGNATURE-----

--0nPzOmrcjSKB9AJN--

