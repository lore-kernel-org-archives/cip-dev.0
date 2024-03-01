Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCFC5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 12:18:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.21297.1709295484041544027
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Mar 2024 04:18:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F34DD1C006B; Fri,  1 Mar 2024 13:18:00 +0100 (CET)
Date: Fri, 1 Mar 2024 13:18:00 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/5] Add RZ/G2UL MTU3a support
Message-ID: <ZeHHeHkklgZq8HIF@duo.ucw.cz>
References: <20240226103949.138960-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB63881BCB411CF35BC6A90364925F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IVP7BW7PwBDl+IyY"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63881BCB411CF35BC6A90364925F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 12:18:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15116


--IVP7BW7PwBDl+IyY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Biju Das (5):
> >   dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
> >     names
> >   dt-bindings: timer: renesas,rz-mtu3: Improve documentation
> >   dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
> >   arm64: dts: renesas: r9a07g043: Add MTU3a node
> >   arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
> >=20
> >  .../bindings/timer/renesas,rz-mtu3.yaml       | 67 +++++++++---------
> >  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 70
> > +++++++++++++++++++
> >  .../boot/dts/renesas/r9a07g043u11-smarc.dts   | 11 +++
> >  .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi |  6 ++
> > arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 13 ++++
> >  5 files changed, 134 insertions(+), 33 deletions(-)
>=20
> I reviewed this series, looks good to me. I can apply this series, if the=
re are no other comment.
> Test pipeline: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipe=
lines/1194909294
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review. Series looks ok to me, too, so I added your
Reviewed-by: tag and pushed it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IVP7BW7PwBDl+IyY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZeHHeAAKCRAw5/Bqldv6
8nKJAJ9HwXcXDtcxzXaJTSserL/f4JDZOwCfR1cLSOE+X/6kJSY/PdcMIV1tOU0=
=57Jd
-----END PGP SIGNATURE-----

--IVP7BW7PwBDl+IyY--

