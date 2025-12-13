Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68D7D5B165
	for <webhook@archiver.kernel.org>; Sat, 13 Dec 2025 20:28:12 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12808.1765657684580158657
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Dec 2025 12:28:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=MK30H37E;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4193110A991D6;
	Sat, 13 Dec 2025 21:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765657678; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2zNRXURxYd5EKaXc22gpFRQUzthx1lfVRPsGk3bFwHc=;
	b=MK30H37EILLAqgpCs9V+WeINig+d6+F6w7oEUIVLpGOj8JueB+nFIlEHo/l7QrniMJqPpJ
	3bAQqLR5MfA+YR9JMwgaVfPjpFyEC81LDCbO3ZcZ3dIn0cgiMtyFQvtsArqJ0hX7aBhcDx
	9LtokgfxPuEEh4NEhdBRVvoJgHwbIwuinS/68veDT/3bhbyoERhGP1xy+U2Msyqn5F2u78
	Cj3/acA3SWSoBeiBgFu5oNBF392duEALKopoauQiT+wYOAYuBN110sXitpuF3onsvhg2+g
	vBUCb0zMGgKoO0kQuKgpVy7UafEDeH6zPQRSnnNBQOs7/yvPRySlqhutg42Rng==
Date: Sat, 13 Dec 2025 21:27:53 +0100
From: Pavel Machek <pavel@denx.de>
To: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
Message-ID: <aT3LfLdcMwi7SdVT@duo.ucw.cz>
References: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
 <CACe6DC60jwpi9ec46qn-iBsyjM4Mf-bf6=_x70=JXRzYZvAmXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoRuIgvCz2nkjF3t"
Content-Disposition: inline
In-Reply-To: <CACe6DC60jwpi9ec46qn-iBsyjM4Mf-bf6=_x70=JXRzYZvAmXg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Dec 2025 20:28:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21012


--hoRuIgvCz2nkjF3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Lad Prabhakar (4):
> >   dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056)
> >     support
> >   clk: renesas: r9a09g056: Add clock and reset entries for WDT
> >     controllers
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

It looks good to me, too, and it passed testing, so I'm adding your
reviewed-by and pushing the result.

Thank you,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hoRuIgvCz2nkjF3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaT3MSQAKCRAw5/Bqldv6
8q+4AKCr5hVYRRQ09IHvxho16OFS/WRNiQCbBmUz7ADii+cIFnHTR7zsZNHtPzU=
=8lX6
-----END PGP SIGNATURE-----

--hoRuIgvCz2nkjF3t--

