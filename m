Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1058DD4921D
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 12:15:25 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11398.1765541714931941672
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 04:15:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Kvg+mowE;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C4B310AE8C02;
	Fri, 12 Dec 2025 13:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765541707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=elQl+nBvRWyRYYd/g9ZOuqau+Q66pPzDsvb4o0CHN70=;
	b=Kvg+mowEGHN5x2aePSCbSVja3SglaM5Owa+wS1vle73eqSwUzUtGG0Ad9L3D3nVkRE3emZ
	2O4Yrcu0CTguLjuB7rX7fIB7L/8LBw7hNYBjkSSqq8GA0+Ii8DLsptOOLAnc+vmmMt68ZL
	a9nPa2I1SttFk8IM/r2LNoLystbeRNPqkEFmiNU5Sfk24131NcbMfyLjtjIW12x4ynd1XG
	hDjpfjRn8wRLhNOgZhzE/j8eRfaukToLuaWo2XPB/JtXZj6+P73ApP1hHFNtv4HLlLkp2+
	QabgUaUCi1Inw5xyglfG3I6xHoHESIH4iPM5f8sow9qaYXkIGBSW/zqcHMPaIA==
Date: Fri, 12 Dec 2025 13:14:54 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N General Timer (GTM)
 support
Message-ID: <aTwHLJTWYJiiBCZM@duo.ucw.cz>
References: <20251212091928.22009-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PfOLHAaM8+XdpB2g"
Content-Disposition: inline
In-Reply-To: <20251212091928.22009-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 12:15:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20982


--PfOLHAaM8+XdpB2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds General Timer (GTM) support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me, I can apply it if it passes testing and there
are no other comments.

Best regards,
								Pavel

> Lad Prabhakar (5):
>   clk: renesas: r9a09g056-cpg: Add clock and reset entries for OSTM
>     instances
>   dt-bindings: timer: renesas,ostm: Document RZ/V2N (R9A09G056) support
>   clocksource/drivers/renesas-ostm: Unconditionally enable reprobe
>     support
>   arm64: dts: renesas: r9a09g056: Add OSTM0-OSTM7 nodes
>   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable OSTM timers on
>     RZ/V2N EVK
>=20
>  .../bindings/timer/renesas,ostm.yaml          | 12 +--
>  arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 80 +++++++++++++++++++
>  .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 32 ++++++++
>  drivers/clk/renesas/r9a09g056-cpg.c           | 26 ++++++
>  drivers/clocksource/renesas-ostm.c            |  4 +-

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PfOLHAaM8+XdpB2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTwHPgAKCRAw5/Bqldv6
8pHFAJ9qfgtoDivDCw5BGzST8QLps4U6hwCbBgu832WGstsPTOH7vTMHmegqKps=
=4Ycp
-----END PGP SIGNATURE-----

--PfOLHAaM8+XdpB2g--

