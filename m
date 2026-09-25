Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8200C9830E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 12:33:44 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7022.1790339622055933041
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 05:33:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=GRrwO2rR;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 217D2104DF1;
	Fri, 25 Sep 2026 14:33:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790339615;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WUspSVc+xNkowKhq8R8vQ23Kmm7wJscnP/NaSGYd+tI=;
	b=GRrwO2rRkyCAyyndzCqVMLp0xJMC1z6aJmnWFkwq3ad3ni42uuSTv+Ve4W/DExExmJZC7v
	5FWTHpwbTv2frCzK1wY/As4gaT1Yrdp5YaSnRJVYpdd10248H2ctX4wm4n3O9IGVt/f6f1
	ashTs74iyglR3e7uf5lAyP6LJJNNQ8YksNhqRibKVhnT6kdYuex8EO37DoTRR2lts1lHMg
	jT3X9/j5E+BkAN30RseJfBuM2D5RtIslRK3vFst0zH63rwlPEYExRrB4XuN3nwz1qSlooJ
	spcCBLBNdVy/sWs1Ods/rHWOxrNkivW7woFO8jEkuDPwiTHOyEG9u428TFln3Q==
Date: Fri, 25 Sep 2026 14:33:28 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/10] Add RTC support to RZ/V2N SoC
Message-ID: <arZqGGvpX429C0OA@duo.ucw.cz>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB148184F29618545209EEF1699CD802@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3M0SpiTIUVUqZDY"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148184F29618545209EEF1699CD802@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 12:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24347


--/3M0SpiTIUVUqZDY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add RTC support to RZ/V2N SoC. The RTC IP on
> > RZ/V2N SoC is identical to one found on the RZ/V2H(P) SoC for which pat=
ches
> > have been already backported.
> >=20
> > All the patches have been cherry-picked from upstream kernel.
> >=20
> > Cheers,
> > Prabhakar
> >=20
> > Lad Prabhakar (6):
> >   rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup
> >     error path
> >   rtc: renesas-rtca3: Check RADJ poll result during initial setup
> >   rtc: renesas-rtca3: Fix incorrect error message for reset assert
> >   rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
> >   rtc: renesas-rtca3: Factor out year decoding helper
> >   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC RTC
> >=20
> > Ovidiu Panait (4):
> >   dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
> >   clk: renesas: r9a09g056: Add clock and reset entries for RTC
> >   arm64: dts: renesas: r9a09g056: Add RTC node
> >   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC
>=20
> I reviewed this series, looks good to me.
> I can apply this if tests are no issues and there are no other comments.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2=
881561788
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Looks good to me, too.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

As you are already running the tests, I'll let you apply the series.

Thank and best regards,
                                                                Pavel

--/3M0SpiTIUVUqZDY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCarZqFwAKCRAw5/Bqldv6
8losAKCRINd92+WE7e/a7n37q8jlGocCGQCfSBwklCVG2qRW5lNOGGGZG9i7Rw4=
=veCH
-----END PGP SIGNATURE-----

--/3M0SpiTIUVUqZDY--

