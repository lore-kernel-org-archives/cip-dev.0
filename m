Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DF3CFD637
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:44:55 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6077.1767793486148731574
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:44:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fAbiIkR4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB31410BEE8;
	Wed,  7 Jan 2026 14:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767793484;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HayMwz7JbdoUe8AB3EECAzL3Iw3rf0ydhMU9RrXfmzQ=;
	b=fAbiIkR4zqBpI1NKYJJsMaacDERKY0ZR3+4KdN9o1iswAIDp23xkpStNNbNW8MrEGuXm1N
	ZcJX5RbIFw7ZyrJqdxVMZOAXNDuYE5ikTGTmTNtbgXkISdysuFAMc0O8uLRreCvKXSX7rH
	DQ/nxZZXQ5jMvgBdUn9UHxwVQ/+prRq/WYY2Od0aFeeirpGRM/HIuG6524MrqpBsuacc1L
	FtuXuZmVAVFSKFuCcF3eR4dnlvz8e88pb10HTJHVehBivIBl/vJmRLgEhuA1ojE4EggPJl
	RWLN8UDfn9+xNZymYUM8FtK2Uw9dpybpkcqyiRx6RG6fVlV+Hcwt8iHdN7A54Q==
Date: Wed, 7 Jan 2026 14:44:42 +0100
From: Pavel Machek <pavel@nabladev.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: Pavel Machek <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 05/17] watchdog: rzv2h: Add support
 for RZ/T2H
Message-ID: <aV5jSlA6Bi1EDisa@duo.ucw.cz>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251231170026.17006-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aVuhl9TJVs6rlwNT@duo.ucw.cz>
 <OSZPR01MB7019B74B463D9AC6DD6B4AF8AA86A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AO8nJ4EDpFIF7C30"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB7019B74B463D9AC6DD6B4AF8AA86A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:44:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21413


--AO8nJ4EDpFIF7C30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +	ret =3D pm_runtime_put(&pdev->dev);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}
> >=20
> > I believe this can be simply "return pm_runtime_put()".
> >=20
> pm_runtime_put() may return 1 if the device is already suspended.
> call trace:
> pm_runtime_put() ->
>    __pm_runtime_idle() ->
>        rpm_idle() ->
>            rpm_suspend() ->
>                rpm_check_suspend_allowed() [0]
>=20
> [0] https://elixir.bootlin.com/linux/v6.19-rc3/source/drivers/base/power/=
runtime.c#L292

Aha. Patch is correct, sorry for the noise.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--AO8nJ4EDpFIF7C30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV5jSgAKCRAw5/Bqldv6
8h3VAJ9g8ZmkvxCfur4fLKHNSYuZnX+fygCfT9DOotpAAYwZig8zEMn4BJNBZ9E=
=DIyj
-----END PGP SIGNATURE-----

--AO8nJ4EDpFIF7C30--

