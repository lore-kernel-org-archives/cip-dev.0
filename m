Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1A1EB64D9
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 15:38:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15616.1688744321563779120
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 08:38:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0E8BA1C0ABB; Fri,  7 Jul 2023 17:38:40 +0200 (CEST)
Date: Fri, 7 Jul 2023 17:38:39 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 6.1.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Message-ID: <ZKgxf9qJ7eegwmNY@duo.ucw.cz>
References: <20230703131944.353224-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420E53A4E9D48F6D85FD3D6922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYizaaaLEZd6KBWF"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420E53A4E9D48F6D85FD3D6922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 15:38:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12275


--aYizaaaLEZd6KBWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > commit 3e6ac852fbc71a234de24b5455086f6b98d3d958 upstream.
> >=20
> > Currently {modprobe, bind} after {rmmod, unbind} results in probe failu=
re.
> >=20
> > genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs. 00000004
> > (85070400.usb3drd)
> > renesas_usb3: probe of 85070000.usb3peri failed with error -16
> >=20
> > The reason is, it is trying to register an interrupt handler for the sa=
me IRQ twice.
> > The devm_request_irq() was called with the parent device.
> > So the interrupt handler won't be unregistered when the usb3-peri devic=
e is
> > unbound.
> >=20
> > Fix this issue by replacing "parent dev"->"dev" as the irq resource is =
managed
> > by this driver.
> >=20
> > Fixes: 9cad72dfc556 ("usb: gadget: Add support for RZ/V2M USB3DRD drive=
r")
> > Cc: stable <stable@kernel.org>

> Looks good to me. I can apply, if there are no comments.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Patch looks good to me, too. Commit being fixed is not in 6.1, so Greg
should not be picking this to stable-6.1 and we should not have
rejects. Good.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aYizaaaLEZd6KBWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKgxfwAKCRAw5/Bqldv6
8rjkAKCcfyKbfYN4pie2aO0EW8qpBzw9iQCeNrk3Xhf1QvvhEUO4XTxsTRsYpP0=
=ml6C
-----END PGP SIGNATURE-----

--aYizaaaLEZd6KBWF--

