Return-Path: <SRS0=WDiq=CM=lists.cip-project.org=bounce+64572+5412+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92ABC433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:58:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F2F206B8
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="q4Pr31RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F2F206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5412+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 56wWYY4521723xmWGaYF8RTN; Thu, 03 Sep 2020 13:58:04 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.24054.1599166683267686991
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 13:58:03 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DF6E61C0B76; Thu,  3 Sep 2020 22:57:59 +0200 (CEST)
Date: Thu, 3 Sep 2020 22:57:58 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] of: Add missing exports of node name compare functions
Message-ID: <20200903205758.GE24361@duo.ucw.cz>
References: <20200903160052.8806-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903173146.GB7795@duo.ucw.cz>
 <OSBPR01MB50487C1B7518C6B4B7835E37AA2C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB50487C1B7518C6B4B7835E37AA2C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dcR5OOcdLwyKQCdYRyUh4G0tx4520388AA=
Content-Type: multipart/mixed; boundary="RgJDfWX3xQ1b5llS1hFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599166684;
 bh=KgVdjtTXeQm4uft7nn3I8d2UpoC12knSQAgeBGFMgqQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=q4Pr31RZT0brPSbp9CS+eVgdjTwYhi4fY5MI9B/1kK3M2e3nNCkXml56aBv8mmlrCVD
 UGvGH5FHUph7wZKr0Qruu//B56VSvTj4Xt0u4Y0elyNKY5cZOWPWYhMcIolpRHp6p+oMJ
 cUhYf3nSzF/owoVpHGrtjhBiGY5Cx10DSgo=

--RgJDfWX3xQ1b5llS1hFB
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline

--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Commit f42b0e18f2e5 ("of: add node name compare helper functions")
> > > failed to add the module exports to of_node_name_eq() and
> > > of_node_name_prefix(). Add them now.
> > >
> > > Fixes: f42b0e18f2e5 ("of: add node name compare helper functions")
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > Fixes build failure for multi_v7_defconfig
> > > ---
> >
> > Ok, what is going on here?
> >
> > I don't believe f42b0e18f2e5 causes build failure; it adds functions,
> > but it can't cause build failure without a user.
> >
> > Which commit fails the build? Do we have that in 4.4.y-cip? Can
> > this be placed before the buggy commit so that build is not broken?
> >
> For multi_v7_defconfig I get this below build error:
>=20
> ERROR: "of_node_name_eq" [drivers/gpu/drm/rcar-du/rcar-du-drm.ko] undefin=
ed!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
> Makefile:1161: recipe for target 'modules' failed
> make: *** [modules] Error 2
>=20
> commit eeaa48eee492d ("drm: rcar-du: Support panels connected directly to=
 the DPAD outputs") fails the build which was added in 4.4-cip kernel.
>

Aha, so I'd expect Fixes: eeaa48eee492d ("drm: rcar-du: Support panels
connected directly to the DPAD outputs") in this patch. And yes, this
means that failure is real and this patch should go in.

ACK.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1FY1gAKCRAw5/Bqldv6
8ljIAJ9vjbdgUsSGyaJ0wAeJmWZnbTTMVACfeMuLxuC/F43YkKXB+Qlbtt8Norw=
=d7D8
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--

--RgJDfWX3xQ1b5llS1hFB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5412): https://lists.cip-project.org/g/cip-dev/message=
/5412
Mute This Topic: https://lists.cip-project.org/mt/76610346/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--RgJDfWX3xQ1b5llS1hFB--
