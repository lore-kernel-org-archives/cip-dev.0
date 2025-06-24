Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9228C77B7F
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 15:34:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.1483.1750779270147704770
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 08:34:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XhWUgRrA;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C4A8101E91FF;
	Tue, 24 Jun 2025 17:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750779267; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=L/fVPQM28zpLf/z+iO9YixEYu3ZA5hHwmLA6tMb8x1s=;
	b=XhWUgRrA4bUE9UvS/HJvfEW+OuJu0nmNq4s2rwUnDiUX7sckAnFU5mRJEkhU4x/Q1lfe0B
	GC7V2GmpUbHzIaEb6rixZ4ATqoQ4Rsr/7a4b1vwqQNDPJ3DqRot8M8vod8Jo76HQ9ZLrsi
	pKtF1/z/Aeua8+TPwzIhc4Fft2q4BuwWBkIxjSI0PmO9TWWdkxVzyLF7ntpOyFEGZjs4ya
	+Sjp5z0Y4RWQKiUb3bxqnk5+EV2h1Yu8uAqrcmj3zyD99Pp0T7/0Rhr4HvWrshhdwcWYQY
	iauDRMM4S2gsmd1PqcfN3XjWXFS8STNyNFGnezU0AATbXbp3fk3ny/GfBJkv7w==
Date: Tue, 24 Jun 2025 17:34:20 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: tommaso.merciai.xr@bp.renesas.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/17] Add support for RZ/G3E SDHI
Message-ID: <aFrFfEUVVtaEXrXJ@duo.ucw.cz>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB1481888A60B76147F355A71129278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HAjC4xYuaz/c4fM+"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481888A60B76147F355A71129278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 15:34:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19228


--HAjC4xYuaz/c4fM+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add SDHI support for the Renesas RZ/G3E SoCs =
into
> > the linux-6.1.y-cip kernel.
> >=20
> > The SD/MMC block on the RZ/G3E ("R9A09G047") SoC is similar to that of =
the
> > RZ/V2H, but the SD0 channel has only dedicated pins, so we must use
> > SD_STATUS register to control voltage and power enable (internal regula=
tor).
> >=20
> > For SD1 and SD2 channel we can either use gpio regulator or internal re=
gulator
> > (using SD_STATUS register) for voltage switching.
> >=20
> > This patchset applies on top of [1]
> >=20
> > [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D974771
> >=20
> > Thanks & Regards,
> > Tommaso
> > Biju Das (10):
> >   clk: renesas: r9a09g047: Add SDHI clocks/resets
> >   dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
> >   of: base: Add of_get_available_child_by_name()
> >   mmc: renesas_sdhi: Add support for RZ/G3E SoC
> >   mmc: renesas_sdhi: Use of_get_available_child_by_name()
> >   arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
> >   arm64: dts: renesas: r9a09g057: Add support for enabling SDHI internal
> >     regulator
> >   arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
> >   arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on
> >     SDHI0
> >   arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1
> >=20
> > Krzysztof Kozlowski (1):
> >   mmc: renesas_sdhi: use typedef for dma_filter_fn
> >=20
> > Wolfram Sang (6):
> >   mmc: tmio: add callback for dma irq
> >   mmc: renesas_sdhi: improve naming of DMA struct
> >   mmc: renesas_sdhi: remove accessor function for internal_dmac
> >   mmc: renesas_sdhi: take DMA end interrupts into account
> >   mmc: renesas_sdhi: add helper to access quirks
> >   mmc: renesas_sdhi: use plain numbers for end_flags
> >=20
> >  .../devicetree/bindings/mmc/renesas,sdhi.yaml |  16 ++
> >  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 +++++++
> >  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  49 ++++++
> >  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  21 +++
> >  .../boot/dts/renesas/renesas-smarc2.dtsi      |  18 ++
> >  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 154
> > ++++++++++++++++++
> >  drivers/clk/renesas/r9a09g047-cpg.c           |  31 ++++
> >  drivers/mmc/host/Kconfig                      |   2 +-
> >  drivers/mmc/host/renesas_sdhi.h               |  20 ++-
> >  drivers/mmc/host/renesas_sdhi_core.c          | 148
> > +++++++++++++++--
> >  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  82 ++++++----
> >  drivers/mmc/host/tmio_mmc.h                   |  11 ++
> >  drivers/mmc/host/tmio_mmc_core.c              |   3 +
> >  drivers/of/base.c                             |  27 +++
> >  include/linux/of.h                            |   9 +
> >  15 files changed, 605 insertions(+), 46 deletions(-)
> >=20
> I reviewed this series, looks good to me. I can apply, if there are no ot=
her comments.
> Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/188=
5943849
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I added the reviewed-by tag and pushed the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HAjC4xYuaz/c4fM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFrFfAAKCRAw5/Bqldv6
8imaAJ91UAcNat2pkbBS+/JsOfAa4Q7+TwCfS2OfQWHa/z7B1lsUroZQ0/SCv/A=
=XIzV
-----END PGP SIGNATURE-----

--HAjC4xYuaz/c4fM+--

