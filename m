Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1830C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 08:00:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.16832.1667462389952231126
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 00:59:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8ADAC1C09DB; Thu,  3 Nov 2022 08:59:47 +0100 (CET)
Date: Thu, 3 Nov 2022 08:59:47 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Message-ID: <20221103075947.GB12403@duo.ucw.cz>
References: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
 <20221103074354.GA12403@duo.ucw.cz>
 <OS0PR01MB59224E2B90A0FD095A1AC8B186389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59224E2B90A0FD095A1AC8B186389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 08:00:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9899


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > RZ/G2L has separate channel specific IRQs for transmit and error
> > > interrupts. But the IRQ handler processes both channels, even if
> > there
> > > no interrupt occurred on one of the channels.
> > >
> > > This patch fixes the issue by passing a channel specific context
> > > parameter instead of global one for the IRQ register and the IRQ
> > > handler, it just handles the channel which is triggered the
> > interrupt.
> >=20
> > Can you elaborate what "the issue" is? AFAICT the code worked before,
> > and will work after the patch, with maybe tiny little less overhead
> > after the patch?
>=20
> Basically, tx IRQs are channel specific.
> Previously if any txIRQ is triggered, you are unnecessarily
> Checking IRQ status of the txIRQ which is not triggered.
>=20
> For eg: if ch0 IRQ is triggered you are checking for ch1 IRQ status
> as well. Similarly, if ch1 IRQ is triggered, then you are checking ch0
> IRQ status.

Understood, but checking ch1 status on ch0 IRQ is not going to cause
any problems, right?

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2N08wAKCRAw5/Bqldv6
8hHkAKCzD5dVXAXTPcPKMWv8CaSPO/cOBgCgtVcBBUk8u5Eb6XdULgGROY4cB5s=
=0wtY
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

