Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F19C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 13:50:13 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.8754.1659534610368692511
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 06:50:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4CAB51C0004; Wed,  3 Aug 2022 15:50:06 +0200 (CEST)
Date: Wed, 3 Aug 2022 15:50:05 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 00/24] Add RZ/{G2LC, V2L} support
Message-ID: <20220803135005.GA4038@duo.ucw.cz>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
 <20220802165635.GC9523@duo.ucw.cz>
 <TYWPR01MB94208C220D2FE64530969868929C9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB94208C220D2FE64530969868929C9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 13:50:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9047


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Pavel Machek <pavel@denx.de>
> > Sent: Wednesday, August 3, 2022 1:57 AM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =
=E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3
> > =E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <nobuhiro1.iwamatsu@toshiba.co.jp=
>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-dev@lists.cip-project.org
> > Subject: Re: [PATCH 5.10.y-cip 00/24] Add RZ/{G2LC, V2L} support
> >=20
> > Hi!
> >=20
> > > This patch series aims to add Basic board support for SMARC EVK based
> > > on RZ/G2LC and RZ/V2L SoC. RZ/{G2L, G2LC, V2L} share the same SMARC
> > > EVK board, but SoM is different and pin mapping of SoM module is
> > > different.
> > >
> > > All these patches are cherry-picked from the mainline.
> >=20
> > Series looks okay to me. I can apply it if there are no other commands =
(and if it
> > passes testing).
> >=20
>=20
> I reviewed this series, LGTM.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Pavel, please push to git.kernel.org.

Done, thank you for the review.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYup9DQAKCRAw5/Bqldv6
8hbWAJ4pNqYd6kxcusvOrlbCvQ6Z9HqvfwCgjvad26FdUXYjsEHCP1SWGU0dJXA=
=F9ox
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

