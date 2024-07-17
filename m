Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C17AC3DA4B
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 11:12:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12759.1721214735027754785
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 04:12:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 891E01C009C; Wed, 17 Jul 2024 13:12:13 +0200 (CEST)
Date: Wed, 17 Jul 2024 13:12:13 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 22/31] dt-bindings: mfd: Convert da9063 to yaml
Message-ID: <ZpenDV9i+M/VRqAR@duo.ucw.cz>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
 <20240716082255.56551-23-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJ88lsdmz31L4Rfd"
Content-Disposition: inline
In-Reply-To: <20240716082255.56551-23-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 11:12:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16564


--xJ88lsdmz31L4Rfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

These tables do not seem to be translated to the yml. Similar tables
are also gone from 28/ .

> -DA9093 consists of a large and varied group of sub-devices (I2C Only):
> -
> -Device                   Supply Names    Description
> -------                   ------------    -----------
> -da9063-regulator        :               : LDOs & BUCKs
> -da9063-onkey            :               : On Key
> -da9063-rtc              :               : Real-Time Clock (DA9063 only)
> -da9063-watchdog         :               : Watchdog
> -
=2E.
> -- regulators : This node defines the settings for the LDOs and BUCKs.
> -  The DA9063(L) regulators are bound using their names listed below:
> -
> -    bcore1    : BUCK CORE1
> -    bcore2    : BUCK CORE2
> -    bpro      : BUCK PRO
> -    bmem      : BUCK MEM
> -    bio       : BUCK IO
> -    bperi     : BUCK PERI
> -    ldo1      : LDO_1	(DA9063 only)
> -    ldo2      : LDO_2	(DA9063 only)
> -    ldo3      : LDO_3
> -    ldo4      : LDO_4	(DA9063 only)
> -    ldo5      : LDO_5	(DA9063 only)
> -    ldo6      : LDO_6	(DA9063 only)
> -    ldo7      : LDO_7
> -    ldo8      : LDO_8
> -    ldo9      : LDO_9
> -    ldo10     : LDO_10	(DA9063 only)
> -    ldo11     : LDO_11

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xJ88lsdmz31L4Rfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpenDQAKCRAw5/Bqldv6
8leuAJ0QQji10D1E1ajcqrBipSLtf7x9VACgsnYlljDNvH356fJnKiOSEObHC90=
=i3U6
-----END PGP SIGNATURE-----

--xJ88lsdmz31L4Rfd--

