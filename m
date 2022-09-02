Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD44C38145
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 10:33:29 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.4968.1662114803535348219
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 03:33:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: ucw.cz, ip: 46.255.230.98,
 mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 501D71C000B; Fri,  2 Sep 2022 12:33:21 +0200 (CEST)
Date: Fri, 2 Sep 2022 12:33:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/26] Add RZ/G2UL support
Message-ID: <20220902103319.GC16210@duo.ucw.cz>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 10:33:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9454


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add Basic board support for SMARC EVK
> based on RZ/G2UL SoC.
>=20
> All these patches are cherry-picked from the mainline.
>=20
> Subsequent patch series will add more functionality to this
> platform.

This series looks okay for me.

The only weird thing is 26/, where we enable nfsroot in the dts. I
guess that's convenient for your configuration, but booting from eMMC
is going to be more common, and I guess it may confusing to some.

Best regards,
								Pavel
--
'DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk'
'HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany'

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYxHb7wAKCRAw5/Bqldv6
8s3tAJ9enejjd5JGQh++bn/Y4op6oEkXfgCghbYhEYdSZUKAy6TuIWIHrdwcKTs=
=yqtt
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

