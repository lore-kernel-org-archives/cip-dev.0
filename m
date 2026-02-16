Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D640E7BDA5
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 11:58:02 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18092.1771243079455474412
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 03:57:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=B86vy4vT;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBF1110ECFE;
	Mon, 16 Feb 2026 12:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771243077;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dOu4sYL8IgbBBkNo7Puka0o/J3brxLi20ZJ7hyc9Qi8=;
	b=B86vy4vTIbmVKRjWqrPcc1XqgZP0/Kb/xlO2CRS444n1jGwyAVd33UU4ECSQ53S/xtUNXD
	9wZTQstcATekmNvilp1Mfshy1ZexyXXtTqLrztGOYqV71XfbWitIoQzmjKkJ1SWqqgyU7d
	B+k1qbRukgf2jOU96Sh/5TcBgS22KQ9vHmxRAg9PEhWEIhCA0N7BVYCs1wrSbH83mcBlCs
	tStnP2a9lodS8ZYVONpUor0OlWpbCo2PWsNtNH9SLwtWr8rPyxZIcJ48OjLQekxTVTsPjT
	TY4EygaQO7yvqzBn8rNrTIXcWwNZXE89QlTg+ZfKr+r88jBfahkWiwrOlZO46Q==
Date: Mon, 16 Feb 2026 12:57:55 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: tommaso.merciai.xr@bp.renesas.com, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] i2c: riic: Move suspend handling to
 NOIRQ phase
Message-ID: <aZMGQ31JBsck9820@duo.ucw.cz>
References: <20260210102637.484003-1-tommaso.merciai.xr@bp.renesas.com>
 <aZMFskqvbJa24JYR@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPPbDHk7GQcCUyHO"
Content-Disposition: inline
In-Reply-To: <aZMFskqvbJa24JYR@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 11:58:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21879


--bPPbDHk7GQcCUyHO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2026-02-16 12:55:30, Pavel Machek wrote:
> Hi!
>=20
> > Wake up the controller in the suspend() callback while runtime PM is
> > still enabled. The I2C controller will remain available until the
> > suspend_noirq() callback (pm_runtime_force_suspend()) is called. During
> > resume, the I2C controller can be restored by the resume_noirq() callba=
ck
> > (pm_runtime_force_resume()). Finally, the resume() callback re-enables
> > autosuspend. As a result, the I2C controller can remain available until
> > the system enters suspend_noirq() and from resume_noirq().
>=20
> > +++ b/drivers/i2c/busses/i2c-riic.c
> > @@ -606,6 +634,10 @@ static int riic_i2c_resume(struct device *dev)
> >  	if (ret)
> >  		return ret;
> > =20
> > +	ret =3D pm_runtime_force_resume(dev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret =3D riic_init_hw(riic);
> >  	if (ret) {
> >  		/*
>=20
> Similar to the next error return, this likely should do
> "reset_control_assert(riic->rstc);" before returning. I guess fixed
> patch would be best here.

Hmm, maybe that's not the best way forward.

It appears that same problem exists in mainline, too? So probably we
should merge this and let you fix it in the mainline.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can this if it passes testing and there are no other comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--bPPbDHk7GQcCUyHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZMGQwAKCRAw5/Bqldv6
8hIpAKCD7Qz76w8jrIki2H9gjV3FE9cwQQCfQb85MIU+bi8kPlDm5Ts8vqSYFuc=
=xk0c
-----END PGP SIGNATURE-----

--bPPbDHk7GQcCUyHO--

