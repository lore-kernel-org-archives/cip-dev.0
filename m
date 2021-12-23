Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23941C433EF
	for <webhook@archiver.kernel.org>; Thu, 23 Dec 2021 18:43:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.36545.1640284999384475716
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 10:43:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4FF561C0B7F; Thu, 23 Dec 2021 19:43:14 +0100 (CET)
Date: Thu, 23 Dec 2021 19:43:13 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add support for RZ/G2L
 family
Message-ID: <20211223184313.GB22980@duo.ucw.cz>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222134951.19432-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222231343.GA25345@amd>
 <OSZPR01MB7019D83A9F1DFC14AD31114EAA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB7019D83A9F1DFC14AD31114EAA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Dec 2021 18:43:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7263


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +	if (gpriv->chip_id =3D=3D RENESAS_RZG2L) {
> > > +		char *irq_name;
> > > +		int err_irq;
> > > +		int tx_irq;
> > > +
> > > +		err_irq =3D platform_get_irq_byname(pdev, ch =3D=3D 0 ? "ch0_err" =
: "ch1_err");
> > > +		if (err_irq < 0) {
> > > +			err =3D err_irq;
> > > +			goto fail;
> > > +		}
> >=20
> > This leaks ndev; it should free_candev(ndev); before returning, AFAICT.
> >=20
> Agreed, this needs a fix.

Yes. OTOH this is just a problem in error paths. Other patches look
good, so this should probably be fixed in the mainline.

I can apply the series if there are no other comments.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYcTDQQAKCRAw5/Bqldv6
8r8JAKC1hAVnJhLtjaENJpOo5v9Hq+Nl6ACdG8C+cfhhKW/Kp7oOgH53IqHznjo=
=djIW
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

