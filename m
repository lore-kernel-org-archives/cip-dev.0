Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20765C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 15:36:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15047.1751643386372579939
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 08:36:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Fq8IAGSK;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1C8B103972A7;
	Fri,  4 Jul 2025 17:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751643384; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mjmLVaJokj9xRimGRN3yR681NAo4hgJgKvLtF93DM8Q=;
	b=Fq8IAGSKDkFBZ5cgSposCR9/FPt/5qV+6DzO5PXu2e3lUGgMt21uu00195VLHOpwNr4Pns
	RpzcKtDe7sv1kuANFP9k0oML0Uwd/9Oj1UuvFsRDlCmEciidDx5O4JpVxy1tcTrFkXqr/v
	5vLHpNAovWbon/dzgvyc5gMwdKalMj+QstKf8ZORYwqGwEVqte9EVclWIbcS08m6MmdSbM
	I8Q0XWSwpLtrJaurlYC3JfJMcx4bFyWy4gE7+pZNkMlSyI+7SyVsBTGRXP4B/sCqPiIjkJ
	m1QB4fV84Oq8+BiGf1EOaXgBkVgnWHudzCCGo1CTTFSu7/XKTLJR58cwMuaoXg==
Date: Fri, 4 Jul 2025 17:36:17 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: tommaso.merciai.xr@bp.renesas.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Message-ID: <aGf08b3oohZ4Frsx@duo.ucw.cz>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB148189EEA4EDF0CE5D2D292309243A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tGj/kfTbXwb5KPjh"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148189EEA4EDF0CE5D2D292309243A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 15:36:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19364


--tGj/kfTbXwb5KPjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Biju Das (2):
> >   clk: renesas: r9a09g047: Add ICU clock/reset
> >   clk: renesas: r9a09g047: Add CANFD clocks and resets
> >=20
> > Fabrizio Castro (1):
> >   clk: renesas: r9a09g057: Add entries for the DMACs
> >=20
> > John Madieu (1):
> >   clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP
> >=20
> > Lad Prabhakar (3):
> >   clk: renesas: rzv2h: Refactor PLL configuration handling
> >   clk: renesas: r9a09g057: Add clock and reset entries for GE3D
> >   dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC
> >=20
> > Tommaso Merciai (5):
> >   clk: renesas: r9a09g047: Add CRU0 clocks and resets
> >   clk: renesas: r9a09g047: Add clock and reset entries for GE3D
> >   dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
> >   arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
> >   arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52
> >=20
> >  .../bindings/gpu/arm,mali-bifrost.yaml        |  4 ++
> >  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 49
> > +++++++++++++++++
> >  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 15 ++++++
> >  drivers/clk/renesas/r9a09g047-cpg.c           | 53
> > ++++++++++++++++++-
> >  drivers/clk/renesas/r9a09g057-cpg.c           | 40 +++++++++++++-
> >  drivers/clk/renesas/rzv2h-cpg.c               | 13 +++--
> >  drivers/clk/renesas/rzv2h-cpg.h               | 34 +++++++++---
> >  7 files changed, 193 insertions(+), 15 deletions(-)
>=20
> I reviewed this series, looks good to me.
> I can apply, if there are no other comments and test is green.
>=20
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1=
903593678
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you. I added the tag, and pushed the changes.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tGj/kfTbXwb5KPjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGf08QAKCRAw5/Bqldv6
8nc6AKCKYE1c+UNN+xRTaHTeG3bR9sQWpwCbBFOVbUo9Gl4xjdwMip/LMlDbV3A=
=+yJY
-----END PGP SIGNATURE-----

--tGj/kfTbXwb5KPjh--

