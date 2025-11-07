Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4D8CCF9E3
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 20:58:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9765.1762549126536375037
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 12:58:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bpXHQ2HA;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6811103ABB76;
	Fri,  7 Nov 2025 21:58:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762549124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uU/1iiKaqdPE+apycGP+RJ7OKn6iIJtmjVtIrtlHaTY=;
	b=bpXHQ2HAja444QkHdl++RO/3jhU1DAvahn9U9O6jR9mBDvglxW0XzWEuUlRp5uMsak4fN2
	N2jOcvB9MM3PRED+DY1BFi4ZIan29UzwUVNT2GU0SYEKW8Vytdyeeca2xGVgJQKkqgNeH8
	xwKQNcx3gtPlbBepiSoHLwtEKyQSk07L/W+NtTtiA2XsUVK/b9XpApvf2wRKj2GxEZ7eE9
	HP0ph84yUU4I8dFO9dgVOtm/xoW3/mjTn2yfvky147EfT+yYglVCXMx3NBaFVVWG2963vH
	LUYegqtacIZ4ixmw5u5L5waDi3mHFSMsXcnEGjMUYXqbdXfREOTiTyryIXly6g==
Date: Fri, 7 Nov 2025 21:58:39 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 0/9] Add RZ/V2H GBETH support
Message-ID: <aQ5dfw7gCW4oreQB@duo.ucw.cz>
References: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148187CA80E39D402B7A18BAECDC3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6kJ51twpinVmxR2O"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148187CA80E39D402B7A18BAECDC3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 20:58:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20477


--6kJ51twpinVmxR2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Biju Das (1):
> >   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Replace RZG2L macros
> >=20
> > Lad Prabhakar (8):
> >   dt-bindings: clock: renesas,r9a09g057-cpg: Add USB2 PHY and GBETH PTP
> >     core clocks
> >   clk: renesas: r9a09g057: Add clock and reset entries for USB2
> >   clk: renesas: r9a09g057: Add clock and reset entries for GBETH0/1
> >   dt-bindings: net: Define interrupt constraints for DWMAC vendor
> >     bindings
> >   dt-bindings: net: dwmac: Increase 'maxItems' for 'interrupts' and
> >     'interrupt-names'
> >   arm64: dts: renesas: r9a09g057: Add GBETH nodes
> >   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH
> >   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Fix pinctrl node name for
> >     GBETH1
> >=20
> >  .../bindings/net/amlogic,meson-dwmac.yaml     |   6 +
> >  .../bindings/net/intel,dwmac-plat.yaml        |   6 +
> >  .../bindings/net/mediatek-dwmac.yaml          |   6 +
> >  .../bindings/net/nxp,dwmac-imx.yaml           |   8 +
> >  .../bindings/net/rockchip-dwmac.yaml          |  10 +
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |  22 +-
> >  .../devicetree/bindings/net/stm32-dwmac.yaml  |  10 +
> >  .../bindings/net/toshiba,visconti-dwmac.yaml  |   6 +
> >  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 209
> > ++++++++++++++++++
> >  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 102 +++++++--
> >  drivers/clk/renesas/r9a09g057-cpg.c           |  84 ++++++-
> >  .../dt-bindings/clock/renesas,r9a09g057-cpg.h |   4 +
> >  12 files changed, 447 insertions(+), 26 deletions(-)
> >=20
> I reviewed this series, looks good to me.
> I can apply this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, it passes testing, so I applied it.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6kJ51twpinVmxR2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQ5dfwAKCRAw5/Bqldv6
8gcYAJ4iyoi3d8O80xrrwmQEndnZHegvqACePYZvhjAhHPzA8lMvFR/GpK3ZJUw=
=aqbM
-----END PGP SIGNATURE-----

--6kJ51twpinVmxR2O--

