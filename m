Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801B0C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 10:38:54 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.19050.1741084723958954762
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 02:38:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VbSwLiea;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82CA010382C18;
	Tue,  4 Mar 2025 11:38:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741084721; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JaejzodXKCVs6pg33UTaAH1WoqRSANMjuZIJPITSHTE=;
	b=VbSwLieaTKPXivRjp3tPFvoO4yFXEidDmPU07tSUXNjG6t6sGoS09UQLEpczBSuo+lHLy2
	khi6Cg7vN06hmq15BMzzdN6MmaisppzlQta3e5Ih3gXZVJWOSMAvCsDC6qq3IJH8QeVDdK
	lUTrkDimT/FJt9ChICUhwGzWNzqAy8A8b3Jzzd5DiWkiUZP/6GWIIMH8w7oEC8ST2Kt4p9
	QOu+2myEcT16SCzDY2bRAbSOad9+x8X7kElSqRjmi4xDbIJJtd4Ix1/uLxdE+LoiKfaJ+Q
	K7qAoLpH2C5sPA2R0Q72Kzp/QpFo0F44LQgWFfLXga/udIVzD8gbONfVZY6rFw==
Date: Tue, 4 Mar 2025 11:38:36 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN
 & IPv6 support
Message-ID: <Z8bYLLQBMnxUMiR8@duo.ucw.cz>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
 <TY7PR01MB14818285CED4A08E1A8690D2092C92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <Z8V3nYpwV72TnVZy@duo.ucw.cz>
 <69b929e7-36c8-4705-8fa7-708395bbd5b1@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+S34yqUKxziHaBnm"
Content-Disposition: inline
In-Reply-To: <69b929e7-36c8-4705-8fa7-708395bbd5b1@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 10:38:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18013


--+S34yqUKxziHaBnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> Paul Barker (12):
> >>>   net: ravb: Fix maximum TX frame size for GbEth devices
> >>>   net: ravb: Fix R-Car RX frame size limit
> >>>   net: ravb: Factor out checksum offload enable bits
> >>>   net: ravb: Disable IP header RX checksum offloading
> >>>   net: ravb: Drop IP protocol check from RX csum verification
> >>>   net: ravb: Combine if conditions in RX csum validation
> >>>   net: ravb: Simplify types in RX csum validation
> >>>   net: ravb: Disable IP header TX checksum offloading
> >>>   net: ravb: Simplify UDP TX checksum offload
> >>>   net: ravb: Enable IPv6 RX checksum offloading for GbEth
> >>>   net: ravb: Enable IPv6 TX checksum offload for GbEth
> >>>   net: ravb: Add VLAN checksum support

> >> Test:
> >>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1696=
481092
> >>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1696=
483186
> >>
> >> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> >=20
> > I reviewed them, too, and code looks ok to me. I'm just wondering what
> > the gain is here, AFAICT there are only very minor performance
> > tweaks (is it even measurable?). What is the reason for having these?
>=20
> Performance gain from enabling checksum offload can be significant,
> especially on the SoCs with a single CPU core such as RZ/G2UL and
> RZ/Five. For example, we've seen up to 40% improvement in bandwidth in
> TCP RX testing on RZ/G2UL.

Ok, thanks for the info. I did not expect 40% improvement. Both 5.10
and 6.1:

Reviewed-by: Pavel Machek <pavel@denx.de>

I expect that Nobuhiro Iwamatsu will apply the changes soon. I can
also apply them.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+S34yqUKxziHaBnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ8bYLAAKCRAw5/Bqldv6
8lvCAJ9sziiUVUgnFYXG9alkO11yWWexJgCgnRXds+Sv1L/NzTIpxDutF8IvJw8=
=3btW
-----END PGP SIGNATURE-----

--+S34yqUKxziHaBnm--

