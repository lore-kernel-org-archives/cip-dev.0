Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06090CF318C
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 10:48:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3894.1763549297710320600
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 02:48:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XDqrvTUV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBD14101E0E5F;
	Wed, 19 Nov 2025 11:48:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763549295; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=htbfQCZ2tjK7FToawwfmnpmICYDyIbldsBg9xxfwCFw=;
	b=XDqrvTUV37ijWqipEJQ6fCvaxT/unJgbOIr6oi90XMgjmyLAiGdHxhP1KAMCVla+QyJPPZ
	kgt2ADTHuCrGpzS8bBCRDYfJWRy3Qj+V93/ZeyXb/aK8uUn+T/eQibXliGB3thDn8svkPD
	PErYEDDLOjK+a25RB1BJK/d/hiUirVuVdql/vEIHwlQvNfNLp2CKEYq2h21hpXgee4k5Yg
	qakGwruwaCUz9JY1yAivXm1MhWirglhoZtvBrdoa39NcarpB/HRoEW3Icc6W15F8lxaSGG
	W1Xn7w2t9Bxk3XbjLKKczZ5AgA303YvYyg1n0gUopHix/2pORR/Evk19EsLQwg==
Date: Wed, 19 Nov 2025 11:48:10 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/1] Add RZ/V2H eMMC support
Message-ID: <aR2gausPIYNpQR15@duo.ucw.cz>
References: <20251114111403.74450-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148186CD256FDE1796064D52ECDD7A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Te9NJvBIExfs8aih"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148186CD256FDE1796064D52ECDD7A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Nov 2025 10:48:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20625


--Te9NJvBIExfs8aih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  arch/arm64/boot/dts/renesas/Makefile          |  6 ++
> >  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  9 +++
> >  .../boot/dts/renesas/rzv2-evk-cn15-emmc.dtso  | 50 ++++++++++++++
> >  .../boot/dts/renesas/rzv2-evk-cn15-sd.dtso    | 69
> > +++++++++++++++++++
> >  4 files changed, 134 insertions(+)
> >  create mode 100644
> > arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
> >  create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
> >=20
> I reviewed this patch, looks good to me.
> I can apply this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Te9NJvBIExfs8aih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaR2gagAKCRAw5/Bqldv6
8riGAJ0RCSwrveacIM/5l5R3mrvTBoqUVwCfTonx2JMAj1EDVMqpDtO9lMlfY1c=
=q45Y
-----END PGP SIGNATURE-----

--Te9NJvBIExfs8aih--

