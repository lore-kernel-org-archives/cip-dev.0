Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A664DC83036
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.20123.1650539849088464129
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 04:17:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C681E1C0B8B; Thu, 21 Apr 2022 13:17:25 +0200 (CEST)
Date: Thu, 21 Apr 2022 13:17:25 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L SoC
Message-ID: <20220421111725.GC9759@amd>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYWPR01MB9420C80542707FC4B160E5E992F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB9420C80542707FC4B160E5E992F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8162


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds sound support to Renesas RZ/G2L SoC and enables =
SSI
> > and codec on Renesas RZ/G2L SMARC EVK.
> >=20
> > All the patches have been cherry picked from v5.18-rc3.
> >=20
> > Sound support patches were already sent earlier as part of bulk series =
[0], but
> > due to some review comments the patches were rejected, now that the dri=
ver is
> > fixed upstream, re-sending the series with all the fixes.
> >=20
> > [0] https://patchwork.kernel.org/project/cip-dev/cover/
> > 20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>=20
> Looks good to me.=20
> I am testing on https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pip=
elines/521117833.
> I can merge it if there are no other comments and test is successful.
>=20

Aside from minor comments I sent, series looks good to me. I'm okay
with series being merged.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJhPUQACgkQMOfwapXb+vJCBQCePkt3JRsC5mPv9rr2G+IOds5r
AAMAoL3bTXOyLx0sYugazZCus2PFcpfK
=/xUj
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

