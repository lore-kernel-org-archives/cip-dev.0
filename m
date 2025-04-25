Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BC5C369D1
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 07:31:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.1936.1745566285276237425
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 00:31:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=U8hn83+J;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 547B410273D85;
	Fri, 25 Apr 2025 09:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745566283; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eKVO68qegSAealk78w9qlENDtQtLVOq7N81N2MoDTbs=;
	b=U8hn83+JOq6Ke+0V/+hfzABfoptvn+EK9Do1dEglNTysXS9RQP8NYKsGeY2aWbcUDwp8Gg
	y5w2Z2GIhDLRAi9KS72xC12WjIzsyiIqwmBVXyJvXJbtDh9RCOPGsO6HhlBTVqfOSI+o4Y
	a4lw2p/QVArALSmPwVws/H+zoxPxvRndt61m3AtBXfcxNh4LxfR4QrWoW7ESb5Io4kTMTV
	muZ5zk7xFuXD3EFFyAgzSKf1HJejJz+BLUOOTLplOGPPrJhDD+Zoub9QXsTPaH6b0Jd3Vf
	7KvsiDXgvIK1c3vEa52SghgFpJvvEJQ9ZuE/JRP0qDBW9oORwKAF5bPDhqcc6Q==
Date: Fri, 25 Apr 2025 09:31:16 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/10] Add SYS and OPP support to
 Renesas RZ/V2H(P) SoC
Message-ID: <aAs6RCYTuzmkBTBY@duo.ucw.cz>
References: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QowJrskB27whSbfl"
Content-Disposition: inline
In-Reply-To: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 07:31:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18600


--QowJrskB27whSbfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add SYS support to RZ/V2H SoC.
> The base driver was first added to RZ/G3S and later extended to
> RZ/V2H SoC hence Ive included changes for RZ/G3S too. Alsong side
> added the clock and reset entries for SYS and GIC and added OPP
> table to the RZ/V2H SoC DTSI.
>=20
> Note,
> - All the patches have been cherry-picked from v6.15-rc3.
> - I plan to send similar patch series for v6.1-cip

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QowJrskB27whSbfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAs6RAAKCRAw5/Bqldv6
8hjzAJ4luiBlrFiXCqBAqqzHL2S/GjDClgCdFvVeb2HVL20bUuwjDmbWG0A3EFI=
=WhxW
-----END PGP SIGNATURE-----

--QowJrskB27whSbfl--

