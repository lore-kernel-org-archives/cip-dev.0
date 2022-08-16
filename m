Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77459C25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 20:24:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.20562.1660681444471982094
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 13:24:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1064D1C0001; Tue, 16 Aug 2022 22:24:01 +0200 (CEST)
Date: Tue, 16 Aug 2022 22:24:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/31] Renesas RZ/V2L extend peripheral support
Message-ID: <20220816202400.GA31726@duo.ucw.cz>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 20:24:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9251


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hi All,
>=20
> This patches series backports support for below IP blocks on the Renesas
> RZ/V2L SoC and also enables on SMARC EVK:
> * USB2.0
> * TSU/OPP
> * SPI/SBC
> * CANFD
> * ADC
> * WDT
> * I2C
> * Audio
> * SDHI/eMMC
> * Timer (OSTM)
>=20
> Note:
> * All the patches have been cherry picked from 6.0-rc1 kernel.
> * Patch 13/31 is required for future addition of SoC's (RZ/G2UL)
> * Patch 04/31 adds CANFD binding patch for RZ/G2L, device tree is
>   already merged into CIP
> * Patch 16/31 is a cosmetic change which affects both RZ/G2L and
> RZ/V2L

Thanks for patches. They look okay to me; I can apply them if there
are no other comments and it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYvv84AAKCRAw5/Bqldv6
8mYPAJ9eEDpT2OrQ48gR0bUeCtUo82Pv4QCdE3wbNJVQ/5RQkZE8yONk/SjgW3M=
=gLwJ
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

