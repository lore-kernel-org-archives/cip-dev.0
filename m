Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED4C77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 13:19:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.22085.1684847981410247792
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 06:19:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3E6411C0AB3; Tue, 23 May 2023 15:19:38 +0200 (CEST)
Date: Tue, 23 May 2023 15:19:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
 deprecate old ones
Message-ID: <ZGy9adIV+qjSXZBg@duo.ucw.cz>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <20230519082058.109760-15-biju.das.jz@bp.renesas.com>
 <ZGf0bB94Ugj2sQ36@duo.ucw.cz>
 <OS0PR01MB592279CFAE4F7FC03C7414E1867D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UGxf7EnRM+s8Oxu4"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592279CFAE4F7FC03C7414E1867D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 13:19:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11612


--UGxf7EnRM+s8Oxu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The callbacks that are only useful with CONFIG_PM_SLEEP is enabled,
> > > are now also wrapped with a new pm_sleep_ptr() macro, which is
> > > inspired from pm_ptr(). This is needed for drivers that use different
> > > callbacks for sleep and runtime PM, to handle the case where CONFIG_PM
> > > is set and CONFIG_PM_SLEEP is not.
> > >
> > > This commit also deprecates the following macros:
> > >
> > > SIMPLE_DEV_PM_OPS()
> > > UNIVERSAL_DEV_PM_OPS()
> > >
> > > And introduces the following macros:
> > >
> > > DEFINE_SIMPLE_DEV_PM_OPS()
> > > DEFINE_UNIVERSAL_DEV_PM_OPS()
> >=20
> > Changing interfaces / deprecating macros is not good thing to do in -cip
> > kernel. How sure are we this will not cause build failures or build
> > warnings in unrelated piece of code?
>=20
> Please see the commit [1] carefully,
>=20
> Deprecated is just a comment and it is just single header file change and
> There is no existing macros changed.

I'll need to look at the commit more carefuly.

However previous patch redefines pm_ptr macro, which may have
implications elsewhere. And indeed

commit 5ef11c56b2332613cacd5e7ac17cfb1a073b66ab
    r8169: Avoid misuse of pm_ptr() macro

is example of such effect, and we'd need to pick it up.

I believe it would be less intrusive to make i2c driver work w/o core
changes.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UGxf7EnRM+s8Oxu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGy9aQAKCRAw5/Bqldv6
8tMSAJ99+h6efVoweAkL0yoseUtQiTRudwCgg2PO2CdaHKnA6+wVPad/NmM9tjk=
=k6RL
-----END PGP SIGNATURE-----

--UGxf7EnRM+s8Oxu4--

