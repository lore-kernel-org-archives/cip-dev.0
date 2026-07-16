Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2755C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:42:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9946.1784198540271548111
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 03:42:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Oaq8TIwE;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD730119FA1;
	Thu, 16 Jul 2026 12:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784198537;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=C6zuZM2uov/5GzwwhRTwT7GIFtagRCYq3CZbY6RxCc8=;
	b=Oaq8TIwE1x10XAV+5AtzixqhAEZmvprLt/PkGDIic81z4lDOS4yWWyGo5yxJEduOY3hWZ3
	BojAFl+ckS28PYCmo8jZtKkbCZFDZX4oEoD5vBh4HdafquBxPICG9BoTvdqgiKMVkv7NZe
	s3xauLMg9coIMGxjzRXxOJT5KSL0Upbg8WHXKmaf3++qcYM2t0W/eD25MnjWXRyTWMhi9R
	EZte/ejXp4cNpufUVxuPdttBIsHNCDf/PWJe4l/Xf230qG7U1ebQXHFDuL0AiJDdzJ13Bx
	+lnir3GpRRPz045KhDOwUK+evR9ztVgvpRG70zYIVCTJwgBzMAiSo8aO0oxV1A==
Date: Thu, 16 Jul 2026 12:42:14 +0200
From: Pavel Machek <pavel@nabladev.com>
To: biju.das.jz@bp.renesas.com
Cc: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl:
 renesas: Document RZ/G3L SoC
Message-ID: <ali1hhUOV931Lxb4@duo.ucw.cz>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-3-biju.das.jz@bp.renesas.com>
 <aldc9NpJgAOV7vA9@duo.ucw.cz>
 <TY7PR01MB148181F049410E17227C1645ACDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB113465350CAAF966182F658E786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oUmVvgf3V/HaPr8A"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113465350CAAF966182F658E786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 10:42:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23613


--oUmVvgf3V/HaPr8A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > -----Original Message-----
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > > Behalf Of Pavel Machek via lists.cip-project.org
> > > Sent: Wednesday, July 15, 2026 7:12 PM
> > > To: Biju <biju.das.au@gmail.com>
> > > Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=
=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=
=8B
> > > =EF=BC=A3=EF=BC=B0=EF=BC=B4) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pa=
vel Machek
> > > <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> > > Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Subject: Re: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl:=
 renesas:
> > > Document RZ/G3L SoC
> > >
> > > Hi!
> > >
> > > There seems to be something wrong here:
> > >
> > > > Add documentation for the pin controller found on the Renesas RZ/G3L
> > > > (R9A08G046) SoC. The RZ/G3L PFC is similar to the RZ/G3S SoC but has
> > > > more pins.
> > > ...
> > > > Document renesas,clonech property for controlling clone channel
> > > > control register located on SYSC IP block on RZ/G3L SoC.
> > >
> > > Ok, no mention of deleting constraints for *57.
> > >
> > > > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinct=
rl.
> > > > +++ yaml
> > > > @@ -154,15 +165,10 @@ allOf:
> > > >        properties:
> > > >          compatible:
> > > >            contains:
> > > > -            const: renesas,r9a09g057-pinctrl
> > > > +            const: renesas,r9a08g046-pinctrl
> > > >      then:
> > > > -      properties:
> > > > -        resets:
> > > > -          maxItems: 2
> > > > -    else:
> > > > -      properties:
> > > > -        resets:
> > > > -          minItems: 3
> > > > +      required:
> > > > +        - renesas,clonech
> > > >
> > > >    - if:
> > > >        properties:
> > >
> > > But now we delete constraints for *57, and add constraints for *46.
> > > That looks wrong?
> >=20
> > This is a side effect by backporting.
> > Depending on the order of commits, the contents of the commit log may n=
ot match those of the patch.
>=20
> The issue is we applied a patch twice in 6.12.y-cip which created duplica=
te entries
>=20
> Patch 1:
>=20
> commit 64e2071b58f579b758c83ae3170f2eee5b46fb03
> dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
>=20
> Patch 2:
>=20
> commit fb73d663b31398aea8528fb231e660c4958b29ff
> dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
>=20
> If we need a clean history we need to revert a patch or
>=20
> Options:
>=20
> 1) Revert offending patch to remove duplicate entry and send new version
>=20
> 2) Update the change log while applying.
>=20
> Please let me know how you want to proceed.

Aha, ok, I see, thanks for explanation.

Best regards,
								Pavel

--oUmVvgf3V/HaPr8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCali1hgAKCRAw5/Bqldv6
8gfIAJwIpllAnYHA2pLJW+VBiBSkCekxmACdEQO3ohPskMWogQJFUbxuYRj7rDs=
=a6BT
-----END PGP SIGNATURE-----

--oUmVvgf3V/HaPr8A--

