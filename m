Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFD2C282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 09:34:43 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.49719.1740994470776540890
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 01:34:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WXzHh5OK;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11FDE103718CD;
	Mon,  3 Mar 2025 10:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740994468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LtsSnYAtEXkdNhiJ6hVL9wok66jW8XZ8oBJVKOmquoE=;
	b=WXzHh5OKRR6MZ1tLWypewml/rwoRK65rdX5ZFwV6ikbyJ5Jbsy7MXPs77kxtCRVgC2CZiG
	AHuwaaJsC3Cdl5ndGbHzQG1CSr6yYoRnmpqWx/K5pQq82mANdyRG81hbzr3UbbP/YMoaNZ
	7mPiLDEhU3J91CgZYM6fAyHB5Bhball/L3NgVyJ2qMVZX2coK30eFtRT3Lyhn1o2Gv3WFw
	yk6w4UmB9DewDKLInq6DTJyeR30sWRtnWqTtZSfXTsqKfhTAqnmntj5FSz3tBfGOwOOTn5
	cscEVeN9tXrcY1kbiw9pzedYIANxYgB6MnvtOonKxY9pNlGproWOM8iwHJmGEw==
Date: Mon, 3 Mar 2025 10:34:21 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: paul.barker.ct@bp.renesas.com, pavel@denx.de,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN & IPv6
 support
Message-ID: <Z8V3nYpwV72TnVZy@duo.ucw.cz>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
 <TY7PR01MB14818285CED4A08E1A8690D2092C92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmhY0BGuGcMv9zC2"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818285CED4A08E1A8690D2092C92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 09:34:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17996


--vmhY0BGuGcMv9zC2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series backports recent ravb driver improvements to CIP 6.1.=
y.
> >=20
> > Paul Barker (12):
> >   net: ravb: Fix maximum TX frame size for GbEth devices
> >   net: ravb: Fix R-Car RX frame size limit
> >   net: ravb: Factor out checksum offload enable bits
> >   net: ravb: Disable IP header RX checksum offloading
> >   net: ravb: Drop IP protocol check from RX csum verification
> >   net: ravb: Combine if conditions in RX csum validation
> >   net: ravb: Simplify types in RX csum validation
> >   net: ravb: Disable IP header TX checksum offloading
> >   net: ravb: Simplify UDP TX checksum offload
> >   net: ravb: Enable IPv6 RX checksum offloading for GbEth
> >   net: ravb: Enable IPv6 TX checksum offload for GbEth
> >   net: ravb: Add VLAN checksum support
> >=20
> >  drivers/net/ethernet/renesas/ravb.h      |   7 ++
> >  drivers/net/ethernet/renesas/ravb_main.c | 120
> > +++++++++++++----------
> >  2 files changed, 77 insertions(+), 50 deletions(-)
> >=20
>=20
> I reviewed this series and 5.10.y, looks good to me.
> I can apply this series, if there are no other comments.
>=20
> Test:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1696481=
092
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1696483=
186
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

I reviewed them, too, and code looks ok to me. I'm just wondering what
the gain is here, AFAICT there are only very minor performance
tweaks (is it even measurable?). What is the reason for having these?

Plus, I don't believe they are all in 6.12. I believe we'll be able to
simply cherry-pick them from mainline, but if not, we'll need your
help.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vmhY0BGuGcMv9zC2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ8V3nQAKCRAw5/Bqldv6
8mLGAJ9drdkEXQhXSRCVheRqys8bieq1JwCgvDpMm/KwismXqn4Kxb4uBTLCQiQ=
=Ta9r
-----END PGP SIGNATURE-----

--vmhY0BGuGcMv9zC2--

