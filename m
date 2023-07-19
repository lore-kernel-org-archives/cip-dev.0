Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00982C001B0
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 14:05:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.14646.1689775526120589478
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 07:05:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D2961C0ABB; Wed, 19 Jul 2023 16:05:23 +0200 (CEST)
Date: Wed, 19 Jul 2023 16:05:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 08/13] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <ZLfto/jBVajAsHe/@duo.ucw.cz>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <20230718140608.119449-9-biju.das.jz@bp.renesas.com>
 <ZLfZRrLwZmb7ZIf8@duo.ucw.cz>
 <OS0PR01MB59223622DA8C82AD2A955E058639A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JOcEuuerl9PdU3ff"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59223622DA8C82AD2A955E058639A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 14:05:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12432


--JOcEuuerl9PdU3ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +++ b/drivers/pwm/pwm-rz-mtu3.c
> > > @@ -0,0 +1,552 @@
> >=20
> > > +static void rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct
> > pwm_device *pwm,
> > > +				 struct pwm_state *state)
> > > +{
> > > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > > +	int rc;
> > > +
> > > +	rc =3D pm_runtime_resume_and_get(chip->dev);
> > > +	if (rc)
> > > +		return;
> >=20
> > Should this at least WARN_ON? Unlike mainline, we can't error here, but
> > I doubt we should just ignore error silently.
>=20
> WARN_ON or dev_err what do you prefer??

WARN_ON would be suitable.

> > Should this goto disable_clock, too?
>=20
> Not required, as rz_mtu3_pwm_pm_disable will call disable_clk, see
> suspend.

Aha, good.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JOcEuuerl9PdU3ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLftogAKCRAw5/Bqldv6
8qD+AJsFRE3ZVoIzlhZFHzFyR8zKEtISVgCfXKMlDXC6+epOxTzuUXd714mI8OI=
=WihT
-----END PGP SIGNATURE-----

--JOcEuuerl9PdU3ff--

