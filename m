Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B4FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 09:18:36 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10855.1777886308764890146
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 02:18:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=bF720TPi;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4303711426A;
	Mon,  4 May 2026 11:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777886306;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EWzjCbGffhKpQQGGO7RHBcQDFi+9fTq6QMSzUfh7CkA=;
	b=bF720TPiVfn7yUJQuHcBAj29URLvqdZLfLH646OKfskT8eH0UmQtCqObENIy537xjDAj5k
	QxHXbsW7xLxNx/tAWUW5nJ98CwSRvHKDk5YCW8dshWSkDU0iyxDCLm60QUUq3Ht3iS+4HF
	T66sRXWvi8RhBSkdoXwbO985J0voaQreeletDXO6qsE+v8whNr5nHmzAw3RpSbg9BZeFsP
	GPFPQ1JcDsEUPh4ojtsveLronCRZuAKw9w4JofAEHArOGQPlnzsTBeN1y8dJjHThOwEtVs
	x7076H3pBgXR/siz/C4UsgiS3Fm6cu1AB/uajNQJwMsIoLo9MkaMJKd1L2eJmw==
Date: Mon, 4 May 2026 11:18:23 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
	cip-dev@lists.cip-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
Message-ID: <afhkX2Ys2BG1gnqy@duo.ucw.cz>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEaLSnFnVzGAR+pM"
Content-Disposition: inline
In-Reply-To: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 09:18:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22857


--DEaLSnFnVzGAR+pM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>=20
> This fixes an issue caused by the use of msleep during spinlock.
> In the original commit, msleep was changed to mdelay, but this fix was not
> carried over during the backport to 5.10.y tree.

Doing this as a quick fix is probably okay, but this should not be
final version.

You are right that msleep inside spinlock will blow up immediately:

> ```
> [   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
> [   62.683957] Modules linked in:

But mdelay for 20 msec inside irqsave spinlock is borderline
unacceptable, too.

I believe we'll need Renesas to analyze/fix this properly after the
CVE emergency is done.

This fix is good for now, but better fix is needed.

Claudiu, are you right person for this, or should we cc someone else?

Best regards,
								Pavel


> index 5166a115879ea..90f2a0e5b2aa0 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -386,7 +386,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan =
*ch)
>  	val =3D readl(usb2_base + USB2_ADPCTRL);
>  	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
> =20
> -	msleep(20);
> +	mdelay(20);
> =20
>  	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
>  	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);


--=20

--DEaLSnFnVzGAR+pM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafhkXwAKCRAw5/Bqldv6
8l4DAJwLQ6N1oT4KVzwMek0jrXCS58qXjQCgvcp3cNkn9ABnuvmSjiZwaWyOiwE=
=iTXT
-----END PGP SIGNATURE-----

--DEaLSnFnVzGAR+pM--

