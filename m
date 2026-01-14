Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B812D29FF7
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 11:44:14 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8218.1768391043647160013
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 03:44:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Cq7uFCM9;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EAD310B420;
	Wed, 14 Jan 2026 12:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768391041;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WUXom4HLPmR/f1tS+L9MpHa0iqxJVP5sQIscIKVRLlU=;
	b=Cq7uFCM9sXy/duZg9QPDNYnIS1o07weXldyAyxdkWLlfg9adhoHp8O4n5VC0E+UmtCemZ4
	iJpFhR0YsWCpXw+phyUgP05Z/IYOCegjJhVWIjv681xYfU4mJcBVbHFwBOMLyvUEghnoE5
	dD36jeHaAKgQrh299NlKJ7sNM0i8VDd1VhMWyB9jZ1BQ2m+VeizE/tdF81PlmYyJ5qau03
	7RP25TnZF/g0MCNRYT8rzAwWJVrqZ55dTsTJ947Ahv4O2Zi8GgLYoMp4njwjIWW7aHKK09
	36xUe0dgnjX9SumBtV3prYlySklGGtZTPHvm3MQxwdSIuBn8tr8/2aYTfzbWSA==
Date: Wed, 14 Jan 2026 12:43:55 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: Pavel Machek <pavel@nabladev.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 04/22] i3c: master: Add basic driver
 for the Renesas I3C controller
Message-ID: <aWeBe5+GkGtvfYO4@duo.ucw.cz>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <20260108092823.489287-5-tommaso.merciai.xr@bp.renesas.com>
 <aWDW8tT9BNp3Cz+L@duo.ucw.cz>
 <aWDtZhy_vCiwVYuS@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y/QDvUIW7V9AzTX4"
Content-Disposition: inline
In-Reply-To: <aWDtZhy_vCiwVYuS@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 11:44:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21540


--Y/QDvUIW7V9AzTX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i=
3c_priv_xfer *i3c_xfers,
> > > +					 int i3c_nxfers)
> > > +{
> > > +	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
> > > +	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
> > > +	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(d=
ev);
> > > +	struct renesas_i3c_xfer *xfer;
> > > +	int i;
> > > +
> > > +	/* Enable I3C bus. */
> > > +	renesas_i3c_bus_enable(m, true);
> > > +
> > > +	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
> > > +	if (!xfer)
> > > +		return -ENOMEM;
> >=20
> > ...where is xfer freed?
>=20
> Please correct me if I'm wrong but xfer is freed at the end of
> renesas_i3c_send_ccc_cmd()

Can you check the code again? It looked to me like ccc_cmd() does its
own allocation, and frees it. priv_xfers() does allocation, but does
not free it, otherwise being similar to ccc_cmd().

> > > +	ret =3D devm_add_action_or_reset(&pdev->dev, renesas_i3c_reset_cont=
rol_assert,
> > > +				       i3c->tresetn);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D devm_add_action_or_reset(&pdev->dev, renesas_i3c_reset_cont=
rol_assert,
> > > +				       i3c->presetn);
> > > +	if (ret)
> > > +		return ret;
> >=20
> > This is wrong, AFAICT. If return happens at marked line, we'll leave
> > tresetn asserted.
>=20
> Ouch, you are right!
> This should be:
>=20
> 	ret =3D reset_control_deassert(i3c->tresetn);
> 	if (ret)
> 		return ret;
>=20
> 	ret =3D reset_control_deassert(i3c->presetn);
> 	if (ret) {
> 		reset_control_assert(i3c->tresetn);
> 		return ret;
> 	}
>=20
> As I've introduce these calls because of missing
>=20
> devm_reset_control_get_optional_exclusive_deasserted()

Yeah, and then we would need to do two more asserts when the devm_
setup fails.

Perhaps backporting
devm_reset_control_get_optional_exclusive_deasserted() would be best?

> Should I fix in v2? Or you can take of this while applying?
> Thanks.

I won't do fixing this. I'll likely apply patch with known problems,
and will expect you to fix it up in follow up patches.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--Y/QDvUIW7V9AzTX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWeBewAKCRAw5/Bqldv6
8vATAJ9QGEBCA74I4+dpcVSOB7UL+qbyjwCgrdj+bIufrCWGZFA9SbqWrI5lhh0=
=x03Q
-----END PGP SIGNATURE-----

--Y/QDvUIW7V9AzTX4--

