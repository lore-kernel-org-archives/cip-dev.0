Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A62EDEC52
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 13:55:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12521.1694613317953301168
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 06:55:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9ED161C001C; Wed, 13 Sep 2023 15:55:14 +0200 (CEST)
Date: Wed, 13 Sep 2023 15:55:14 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	cip-dev@lists.cip-project.org, claudiu.beznea.uj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/15] Enable Renesas PMIC RAA215300 and RTC
 builtin support
Message-ID: <ZQG/QqFj0ghN1Igm@duo.ucw.cz>
References: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
 <ZQDTgRxUYarvm9Yb@duo.ucw.cz>
 <TYWPR01MB94201AFC7560164310CEFAA092F0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Cc//h0v5xmAn2QM"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94201AFC7560164310CEFAA092F0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 13:55:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13099


--9Cc//h0v5xmAn2QM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The first patch is equivalent to the commit 2023c5c8fe2e85 "rtc: isl1=
208:
> > > do not advertise update interrupt feature if no interrupt specified"
> > > on the mainline.
> >=20
> > Thanks for the series. It looks okay to me and I can apply it if there =
are no other
> > comments and if it passes testing.
>=20
> I reviewed this series, LGTM.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review. I applied the series with your reviewed-by tag, and
pushed the result out.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9Cc//h0v5xmAn2QM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQG/QgAKCRAw5/Bqldv6
8ujIAJ9icxQe08WEV6OYsIsqHh6EuswiEQCfclk7rksOmooCxj21fDMPTo81PjM=
=DdsR
-----END PGP SIGNATURE-----

--9Cc//h0v5xmAn2QM--

