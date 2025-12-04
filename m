Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F0DD1F9B4
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 10:45:25 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40525.1764845121160673741
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 02:45:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UZJXrJmH;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 869A0103ABB62;
	Thu,  4 Dec 2025 11:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764845119; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PgTINeMCaysTI1w7dFHVxP3Ck7ryg8rhYwHCF3C7iZ4=;
	b=UZJXrJmHHRRzbif9BWLj3DhzEO3LJ/06V6jbR+BgIrdGnPfz8tkX8LVOsWUvEnI0467EZt
	gLf+Y0J5709gxw1RsjdrInX9cw3D7ZkR+NhHXOquIIKAuud3H2D57pz8A/Bc9kG8XoEauc
	fCd2z4MZzTGIXRkgkVoUsQjjMrquSkuaQ8krkrbrFac6NeKJo9+HoN0g0g1r96iBOCSmlH
	eD1pL+qsM4K8jFkUDRoYX20k5THQ4FW1lbNYAoSAG+JrixudNp61+7iFTIj5Wutzy5KX6s
	U1FLbu2V50hf5NKCuuSjLzyoxjN5irsa6ta+b6IZ3BlTLpXw6Ihqf1Ez4eTcCQ==
Date: Thu, 4 Dec 2025 11:45:16 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 06/12] dt-bindings: serial: renesas:
 Document RZ/V2N SCIF
Message-ID: <aTFmPKKMoErVHwg3@duo.ucw.cz>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
 <20251203153757.32977-7-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eABX5RCgx1+ng2W8"
Content-Disposition: inline
In-Reply-To: <20251203153757.32977-7-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:45:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20842


--eABX5RCgx1+ng2W8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 5eb2d4b3e9a19f08e0ccbb81e0fbfa61de229345 upstream.
>=20
> Document SCIF bindings for the Renesas RZ/V2N (a.k.a R9A09G056) SoC.
> The SCIF interface in Renesas RZ/V2N is identical to the one available
> in RZ/V2H(P), so `renesas,scif-r9a09g057` will be used as a fallback,
> allowing reuse of the existing driver without modifications.

I'd expect some kind of generic fallback, not reusing id from other
hardware.

Best regards,
								Pavel=20

> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -83,6 +83,7 @@ properties:
>        - items:
>            - enum:
>                - renesas,scif-r9a09g047      # RZ/G3E
> +              - renesas,scif-r9a09g056      # RZ/V2N
>            - const: renesas,scif-r9a09g057   # RZ/V2H fallback
> =20
>    reg:


--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--eABX5RCgx1+ng2W8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTFmPAAKCRAw5/Bqldv6
8vzVAJ0fqRj6MBrWfsA0xtyDPT0etZcFngCff29EhE0Hr7epU0jvso0uK6Xx+J8=
=kXlb
-----END PGP SIGNATURE-----

--eABX5RCgx1+ng2W8--

