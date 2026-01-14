Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C10D29FF7
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 11:53:44 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8259.1768391615903967499
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 03:53:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=YEEW6IBv;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15D3810A7F9;
	Wed, 14 Jan 2026 12:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768391613;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=R0Vil1CXTElmi3GaV2kd/FPF5fyQ9xJjd6nr8CivrZY=;
	b=YEEW6IBvJFoOKgeZO+OZz5xamauxe9FlIIwHDf8P7dCjIWbKguUpDgz57AznQd+b6rST0w
	rCWXagEgn+em8bwZpLi+RaExjlNfhrq6GBF3+FcOacUM14TiIbZjR+UBWDWCDd6RMt6QK2
	X4Wa6WUK3EYG5yMsInJonCydpf11IHfy/BWlYL5lcfPZUIBhsBzw0dg8YTDGDsKpACgxHd
	71gz7IcbQuRyxK/Fp1CTpHH8HjMmr3Dx2OhT8EH4xpXtiFyliCsmwGXFUGzU7K7v9HJmzq
	akC+0UiBCt9zA1L3gCylsw1CQ7xJLRplGuFRyQIdpkK8uq4RzuIqL0wDmDjBmA==
Date: Wed, 14 Jan 2026 12:53:30 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 04/22] i3c: master: Add basic driver for the
 Renesas I3C controller
Message-ID: <aWeDum6VUxnXZV6T@duo.ucw.cz>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <20260108092823.489287-5-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mfRPM3yy4KSncbbC"
Content-Disposition: inline
In-Reply-To: <20260108092823.489287-5-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 11:53:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21541


--mfRPM3yy4KSncbbC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I see incosistency here: ccc_cmd() does kfree(), priv_xfers does not;
and I don't see who does free xfer in case of priv_xfers. I summarized
functions below to point out the memory leak.

If I'm misunderstanding the code, please point out where xfer is freed
in renesas_i3c_priv_xfers().

Best regards,
								Pavel

> +++ b/drivers/i3c/master/renesas-i3c.c

> +static int renesas_i3c_send_ccc_cmd(struct i3c_master_controller *m,
> +					   struct i3c_ccc_cmd *ccc)
> +{
=2E..
> +	struct renesas_i3c_xfer *xfer;
=2E..
> +	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
> +	if (!xfer)
> +		return -ENOMEM;
=2E..
> +	renesas_i3c_wait_xfer(i3c, xfer);
=2E..
> +	kfree(xfer);
> +
> +	return ret;
> +}
> +
> +static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_p=
riv_xfer *i3c_xfers,
> +					 int i3c_nxfers)
> +{
=2E..
> +	struct renesas_i3c_xfer *xfer;
=2E..
> +	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	init_completion(&xfer->comp);
> +
> +	for (i =3D 0; i < i3c_nxfers; i++) {
=2E..
> +		renesas_i3c_wait_xfer(i3c, xfer);
> +	}
> +
> +	return 0;
> +}

--=20
In cooperation with Nabla.

--mfRPM3yy4KSncbbC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWeDugAKCRAw5/Bqldv6
8jb9AJ97Scxlyxb6X6riQxRRPxLj1DAJpQCghBvRSMCeowF6A/OR3JdodXok8Yc=
=X/aO
-----END PGP SIGNATURE-----

--mfRPM3yy4KSncbbC--

