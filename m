Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACF8CA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 13:41:12 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.9703.1755783667840113827
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 06:41:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=eaLlmfBM;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A47F1038C11E;
	Thu, 21 Aug 2025 15:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755783665; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5OmGIvypG/4kD5xNf3Fzjno6ipdjgyqpINSMNJwF4IQ=;
	b=eaLlmfBM03bkZ9J3nn7k5lX73Ymh2FZ7nQPja6hKwH5K2P1FOMs482jbAf4ci/nkYIDPYr
	7lQxhbXD11uqLicGwtqI/SC8YgRTaee9atqyB+woIYbriS2t7bLsKuhB2UClwD+qnlC5Ak
	9F84dok9KtPZ4VoxrEln0/8T66oeFtn6yi1fJJ6BSn2VYjEQ8wHrAt0eh3wkr69uGBzXER
	r5OOKdHHQs/7D5DIuVnDpXMHHvjeQtD4/x8U4F0ttLQ0sPX56XnrzIy4o3YmmI9DZdCT7u
	1SIr/HrDAG43k7hNWxR59rmMfyogtFTM7Xrr8PYTyzCyck1BV3cckIzYnec0ew==
Date: Thu, 21 Aug 2025 15:41:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if: Add
 RZ/G3E xSPI support
Message-ID: <aKch7HhlHu/Jp6ef@duo.ucw.cz>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
 <20250820084645.6988-19-biju.das.jz@bp.renesas.com>
 <aKcBPxrTxnIw8BgT@duo.ucw.cz>
 <TY3PR01MB11346EFFD9F8914171836AC9D8632A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qKhi4MjyB2Q7Khis"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346EFFD9F8914171836AC9D8632A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 13:41:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19936


--qKhi4MjyB2Q7Khis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2025-08-21 13:08:33, Biju Das wrote:
> Hi Pavel,
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Pavel Machek via
> > lists.cip-project.org
> > Subject: Re: [cip-dev] [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if:=
 Add RZ/G3E xSPI support
> >=20
> > Hi!
> >=20
> > > commit 687cac9559d8e9277830bdfb68b57d7403695b1d upstream.
> > >
> > > Add support for RZ/G3E xSPI. Compared to RPC-IF, it can support writes
> > > on memory-mapped area. Introduce struct rpcif_impl for holding the
> > > function pointers and data to handle the differences between xspi and
> > > rpc-if interface.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Link:
> > > https://lore.kernel.org/r/20250424090000.136804-7-biju.das.jz@bp.renes
> > > as.com
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > [Biju: Squashed the commit 798dc3f19c9e
> > > ("memory: renesas-rpc-if: Add missing static keyword")]
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > >  #symbol 'rpcif_impl' was not declared. Should it be static?
> > >  #symbol 'xspi_impl' was not declared. Should it be static?
> >=20
> > Not sure where these #symbol.. comments come from. They should not be h=
ere.
>=20
> I agree. It is a mistake from my side while squashing the patches at last=
 minute.
>=20
> Do you want me to send a patch for fixing this or you can take care while=
 applying.

Problem exists in 6.1 series, too. I believe we can take care while
applying, no need to resend.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qKhi4MjyB2Q7Khis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKch7AAKCRAw5/Bqldv6
8rrkAKCQ7bbdD0KGcJMYbD4Gp7zhD8e1xACghzZ6MiIZxAp2E9GGIDUe2HDb+HA=
=AX4Q
-----END PGP SIGNATURE-----

--qKhi4MjyB2Q7Khis--

