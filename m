Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76A1C433EF
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 23:54:08 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.174.1641513246686317924
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 15:54:07 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 05F161C0B96; Fri,  7 Jan 2022 00:54:01 +0100 (CET)
Date: Fri, 7 Jan 2022 00:54:00 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/31] Add sound/adc support for
 RZ/G2L
Message-ID: <20220106235400.GA31562@duo.ucw.cz>
References: <16C5324B2EFDDB95.12001@lists.cip-project.org>
 <OSZPR01MB701986387CEBA39F8BC4DAD5AA4C9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB701986387CEBA39F8BC4DAD5AA4C9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 23:54:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7336


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hi All,
> >=20
> > This patch series adds Sound and ADC support for Renesas RZ/G2L SoC and=
 enables RIIC/SOUND/CANFD/ADC
> > on Renesas SMARC EVK.
> >=20
> > I have also included the missing driver patch for riic and kernel confi=
gs.
> >=20
> > All the patches have been cherry picked from v5.16-rc7.
> >
> Do you want me to separate out audio related patches and just send the AD=
C for now until the audio patch comments are resolved/fixed?
>

Yes, I was thinking about that, too. That would be easy way forward.

Thank you and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYdeBGAAKCRAw5/Bqldv6
8rXbAJ9hR+f1N86R3L81/QLCM2i399qRVQCeJtXrevyuBPYCMqwZgt4gcNMLqgo=
=CV5e
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

