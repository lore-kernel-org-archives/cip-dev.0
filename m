Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9097EC61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 08:42:45 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.131596.1700815355780877417
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Nov 2023 00:42:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6E39D1C0072; Fri, 24 Nov 2023 09:42:32 +0100 (CET)
Date: Fri, 24 Nov 2023 09:42:31 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, claudiu.beznea.uj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/11] Add versa3 clk generator support
Message-ID: <ZWBh992Lae38o/3t@duo.ucw.cz>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
 <TYVPR01MB1124586158EA9F30C835538AC92B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLPqzHh1+wj6vIct"
Content-Disposition: inline
In-Reply-To: <TYVPR01MB1124586158EA9F30C835538AC92B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 08:42:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13713


--yLPqzHh1+wj6vIct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > All the patches are cherry-picked from the mainline.
> >=20
> > Biju Das (7):
> >   dt-bindings: clock: Add Renesas versa3 clock generator bindings
> >   dt-bindings: clock: versaclock3: Add description for #clock-cells
> >     property
> >   clk: Add support for versa3 clock driver
> >   clk: vc3: Fix 64 by 64 division
> >   clk: vc3: Fix output clock mapping
> >   clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
> >   arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk
> >=20
> > Daniel Palmer (1):
> >   clk: fixed: add devm helper for clk_hw_register_fixed_factor()
> >=20
> > Marek Vasut (1):
> >   clk: fixed-factor: Introduce devm_clk_hw_register_fixed_factor_index()
> >=20
> > Marijn Suijten (1):
> >   clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
> >=20
> > Samuel Holland (1):
> >   clk: fixed: Remove Allwinner A10 special-case logic
> >=20
>=20
> I reviewed this series, LGTM. So, I can apply this series.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yLPqzHh1+wj6vIct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWBh9wAKCRAw5/Bqldv6
8gz9AJ4pgeWI3fXl2bwfFQq4ncIpY9JCRwCgj3Y6AYv4kZi3vAgyyP4rdrjcM9Q=
=OHOw
-----END PGP SIGNATURE-----

--yLPqzHh1+wj6vIct--

