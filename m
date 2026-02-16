Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF3E7BDA5
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 11:55:42 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18064.1771242935389941802
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 03:55:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Kub9YvF4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A02810E0D1;
	Mon, 16 Feb 2026 12:55:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771242933;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FtQtKzGY5PW4GNYHp/CMzgTfmQ8BxmyaxtDvdbx+YCg=;
	b=Kub9YvF4V8MmfzllG23ch2BG/6GIqN66+rjTKeLoJPk5xw0IFuFyjpSvzgyUijgdvh0lkw
	fSrfOsoEcpPFYRP41INKVh61ua/rDhn+BXAxv+xji8q8XDhNgYmF53fheIfuURmNi1SI29
	S9gvA0FoOm0ahdoshWosUgq0tZZQkgrgs5hekNzD1wi/TQFu50JlTiiMe1ZaECUV2hDABs
	keThaWgFYuF9mabg7qg4gpRh7FnqWDnBEo3HntnEChQ79RaoHsN9NXJkc9H8ZQS6YlyQ29
	8xfPntFGMojJMYDUs2FXASlv/7ZengTXVWf+nakZr/8vFaEv6URYsaUXm2kazA==
Date: Mon, 16 Feb 2026 12:55:30 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] i2c: riic: Move suspend handling to
 NOIRQ phase
Message-ID: <aZMFskqvbJa24JYR@duo.ucw.cz>
References: <20260210102637.484003-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="67o2HD/7RW7dLWT9"
Content-Disposition: inline
In-Reply-To: <20260210102637.484003-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 11:55:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21878


--67o2HD/7RW7dLWT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Wake up the controller in the suspend() callback while runtime PM is
> still enabled. The I2C controller will remain available until the
> suspend_noirq() callback (pm_runtime_force_suspend()) is called. During
> resume, the I2C controller can be restored by the resume_noirq() callback
> (pm_runtime_force_resume()). Finally, the resume() callback re-enables
> autosuspend. As a result, the I2C controller can remain available until
> the system enters suspend_noirq() and from resume_noirq().

> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -606,6 +634,10 @@ static int riic_i2c_resume(struct device *dev)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D riic_init_hw(riic);
>  	if (ret) {
>  		/*

Similar to the next error return, this likely should do
"reset_control_assert(riic->rstc);" before returning. I guess fixed
patch would be best here.

Thanks and best regards,
							Pavel
--=20
In cooperation with Nabla.

--67o2HD/7RW7dLWT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZMFsgAKCRAw5/Bqldv6
8iTjAJ45XM3wESwhwByANZUMcuo++VdDdACgtAH3T4BP7QjNEztXNfpulOzWbiY=
=UuHg
-----END PGP SIGNATURE-----

--67o2HD/7RW7dLWT9--

