Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF8EB64D9
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 15:36:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.15373.1688744155909575658
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 08:35:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E1E381C0ABB; Fri,  7 Jul 2023 17:35:51 +0200 (CEST)
Date: Fri, 7 Jul 2023 17:35:51 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	pavel@denx.de, fabrizio.castro.jz@renesas.com
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] usb: gadget: udc: renesas_usb3: Fix
 RZ/V2M {modprobe,bind} error
Message-ID: <ZKgw16/ePAKx/1FB@duo.ucw.cz>
References: <20230703132113.353419-1-biju.das.jz@bp.renesas.com>
 <176E900B4C685A01.1228@lists.cip-project.org>
 <TYWPR01MB94208D921A8950BC0A3CD6FD922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YfxuNtXXsaKka9sT"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94208D921A8950BC0A3CD6FD922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 15:36:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12274


--YfxuNtXXsaKka9sT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Currently {modprobe, bind} after {rmmod, unbind} results in probe fai=
lure.
> > >
> > > genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs.
> > > 00000004
> > > (85070400.usb3drd)
> > > renesas_usb3: probe of 85070000.usb3peri failed with error -16
> > >
> > > The reason is, it is trying to register an interrupt handler for the =
same IRQ
> > twice.
> > > The devm_request_irq() was called with the parent device.
> > > So the interrupt handler won't be unregistered when the usb3-peri
> > > device is unbound.
> > >
> > > Fix this issue by replacing "parent dev"->"dev" as the irq resource is
> > > managed by this driver.

> > I reviewed this series. Looks fine to me.
> > I can apply, if there are no comments and issues.
> >=20
> > Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/9199460=
31
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> >=20
> Applied, thanks.

Looks ok to me, too.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YfxuNtXXsaKka9sT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKgw1wAKCRAw5/Bqldv6
8oGJAKCSCP5bi0/ystbhR7L079QszFVrngCdG3ac5perBofMHC7bi9yPUU4SlEc=
=ybEs
-----END PGP SIGNATURE-----

--YfxuNtXXsaKka9sT--

