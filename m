Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3597DF433C8
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 20:59:26 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26402.1776373162768588108
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 13:59:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Fq8eAbzu;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B71B611411D;
	Thu, 16 Apr 2026 22:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776373161;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IDU6hRmtshAjDPc8dtGhdyMG9sOgNDQrpJHwmwNenl8=;
	b=Fq8eAbzuopXJ2+P9ZpcP89EKOyoIAodCOtxXSiiosPqMzjcNYDITntools2KPDhl3eYR4a
	8cYl4/ffUWO3+85x4FQhLiirdoqKQiPywZD+0OMwd88qjhHmlimG5fP6biEbvwYpp0mT3Z
	jZjbeeA6Hsn3BC6WBNlDsu9MKodqas0J2XMjX5YpRpCBWm0RWSeN3OjuIRlahjpDAndMeS
	fQqrGtcn7T9pE2Jt7QMoKgxF5mtTlKYmccgeO/c2BXzcXr2KVgeHWiDJq0ZRR8PrAR2rBC
	Lf3eDKHYcRf/WgdL+UZCgOW+Ml98PrcKN7Hi6Y7UzNzJfTBK8E0beSC/EoUCGQ==
Date: Thu, 16 Apr 2026 22:59:19 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Pavel Machek <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [PATCH 6.1.y-cip 2/7] drm: renesas: rz-du: Implement MIPI DSI
 host transfers
Message-ID: <aeFNp1ow-aKSZWx0@duo.ucw.cz>
References: <20260413171831.3091144-1-chris.brandt@renesas.com>
 <20260413171831.3091144-2-chris.brandt@renesas.com>
 <ad4JUH9p71MPyIlK@duo.ucw.cz>
 <OS3PR01MB8319E1A2764C46EC3D8C326E8A252@OS3PR01MB8319.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="er2JjA4OyOf7+aMp"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB8319E1A2764C46EC3D8C326E8A252@OS3PR01MB8319.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 20:59:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22755


--er2JjA4OyOf7+aMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> These patches are direct backports from mainline.
> I am trying to keep the CIP version as close to the mainline version as p=
ossible.

Understood. You don't have to change these in -CIP, but consider
fixing them in mainline.

> > > +	dsi->dcs_buf_virt =3D dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_B=
UF_SIZE,
> > > +					       &dsi->dcs_buf_phys, GFP_KERNEL);
> > > +	if (!dsi->dcs_buf_virt)
> > > +		return -ENOMEM;
> > > +
> > >  	return 0;
> > >
> >
> > This probably should be { err =3D -ENOMEM; goto err_pm_disable; }
>=20
> That is a good point.
> I wrote that part of the driver for an older version of the kernel a coup=
le years ago before they had those return options.
> Then, someone else ported it to the mainline version of the driver and su=
bmitted it.
> When I reviewed the mainline version, I didn't catch that.
> I might push a fix to mainline with CC:stable.
>=20

Yes, please.

Best regards,
									Pavel

--er2JjA4OyOf7+aMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaeFNpwAKCRAw5/Bqldv6
8gYwAKCT0ibvBx0gYG+nrcmGcs9DlCvQswCePGsb6/Wu7ON3/ShTG8b9jB/D9Yg=
=p9Wt
-----END PGP SIGNATURE-----

--er2JjA4OyOf7+aMp--

