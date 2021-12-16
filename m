Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03337C433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 09:08:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.8151.1639645716115804730
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 01:08:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 625591C0B98; Thu, 16 Dec 2021 10:08:30 +0100 (CET)
Date: Thu, 16 Dec 2021 10:08:24 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, uli@fpond.eu, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification for
 Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Message-ID: <20211216090824.GB5178@amd>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB6252F8B94A684EFA61315C6B92779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: 
 <TYAPR01MB6252F8B94A684EFA61315C6B92779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 09:08:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7118


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds initial support for Renesas RZ/G2L SoC [0] and
> > Renesas RZ/G2L SMARC EVK [1].
> >=20
> > The RZ/G2L microprocessor includes a Cortex-A55 (1.2 GHz) CPU, 16-bit
> > DDR3L/DDR4 interface, 3D graphics engine with Arm Mali-G31 and video co=
dec
> > (H.264). It also has many interfaces such as camera input, display outp=
ut,
> > USB 2.0, and Gbit-Ether, making it ideal for applications such as
> > entry-class industrial human-machine interfaces (HMIs) and embedded dev=
ices
> > with video capabilities.
> >=20
> > Patches add support for the following:
> > * Documentation for RZ/G2{L,LC,UL} SoC variants
> > * Documentation for Renesas SMARC EVK
> > * SYSC binding doc required for SoC identification
> > * SoC identification support
> > * Enabling ARCH_R9A07G044 in defconfig
> >=20
> > All the patches have been cherry picked from v5.16-rc5
> >=20
> > [0] https://www.renesas.com/us/en/products/microcontrollers-microproces=
sors/
> > rz-arm-based-high-end-32-64-bit-mpus/rzg2l-general-purpose-microprocess=
ors-dual-
> > core-arm-cortex-a55-12-ghz-cpus-3d-graphics-and-video-codec
> > [1] https://www.renesas.com/us/en/products/microcontrollers-microproces=
sors/
> > rz-arm-based-high-end-32-64-bit-mpus/rtk9744l23s01000be-rzg2l-evaluatio=
n-board-kit
> >=20
>=20
>=20
> LGTM. I can merge this seriese, If there is no objection.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Looks good to me too. I have series ready due to testing, so I'll push
it.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmG7AgcACgkQMOfwapXb+vK59gCcCAzzZFCm9DFJ6kVOB5AOt4PY
iisAn0iRt8EVu22F1aWl9eUM+/7xnCvn
=aaf+
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

