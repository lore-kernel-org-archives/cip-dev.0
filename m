Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1585.1793033053201963763
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 09:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=AyfJjw9O;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BB2B105C62;
	Mon, 26 Oct 2026 17:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793033046;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uyhY5E+T3lQ/sO0TuBRguNZOOQYR5cHd2poSZS+mV/Q=;
	b=AyfJjw9OpA93cu/2+Ci/xltRPEK8tM98FNY4jaaF6pk3ozrmXLivVOs8wXHnAT1y8I90O8
	wIT8rcYLl9oMeaWZrxB0o/mnZebUQ0qTZSO+IlefjcalduoUD6Z/UUXWpnWPyHrbZRvhaS
	YUrumJjgep8ThC2SDn8M4I4is29N3TWT9nJX9rB9PO/GVHh7pK73jt0HIXhiMKPBs2YUkX
	aDAPaRJ46vi1DTMvkTSuYHwwfxzSmwM5l1nixS5tAHOILLUPzXyys8R+XYm+Et63VD+xYC
	nie0HVHenVClvxV+crpx9iNbHbsi+Y3F004K4YjioqeKZxEGodET12gDUEhcQw==
Date: Mon, 26 Oct 2026 17:44:01 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	claudiu.beznea.uj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
Message-ID: <at-DUZn8PsBDbxxQ@duo.ucw.cz>
References: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zg1K/anfbYOi09qi"
Content-Disposition: inline
In-Reply-To: <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 16:44:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24546


--zg1K/anfbYOi09qi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit c69e13965f26b8058f538ea8bdbd2d7718cf1fbe upstream.
>=20
> When stress-testing the system by repeatedly unbinding and binding the ADC
> device in a loop, and the ADC is a supplier for another device (e.g., a
> thermal hardware block that reads temperature through the ADC), it may
> happen that the ADC device is runtime-resumed immediately after runtime PM
> is enabled, triggered by its consumer. At this point, since drvdata is not
> yet set and the driver's runtime PM callbacks rely on it, a crash can
> occur. To avoid this, set drvdata just after it was allocated.

I'm not sure this was diagnosed properly. Ok, I guess that fixes
immediate problem.

We now publish indo_dev pointer before ->hw_params is initialized,
before mutex is initialized, and before ioremap is done (and
others). If that races with PM callbacks, bad things are going to
happen.

Actually I'm not 100% convinced that this patch solves all the
problems, are suspend/resume callbacks fine running while
adc_hw_init() is running / before irq is initialized?

What happens if PM callbacks are running, then devm_request_irq()
fails and device is unregistered racing with callbacks?

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index d48aec92add9ac..418211c06f1fe2 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -436,6 +436,8 @@ static int rzg2l_adc_probe(struct platform_device *pd=
ev)
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
> +	platform_set_drvdata(pdev, indio_dev);
> +
>  	adc =3D iio_priv(indio_dev);
> =20
>  	adc->hw_params =3D device_get_match_data(dev);
> @@ -490,8 +492,6 @@ static int rzg2l_adc_probe(struct platform_device *pd=
ev)
>  	if (ret)
>  		return ret;
> =20
> -	platform_set_drvdata(pdev, indio_dev);
> -
>  	ret =3D rzg2l_adc_hw_init(dev, adc);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret,

Consider moving platform_set_drvdata() immediately before
pm_runtime_set_autosuspend_delay().

I'm okay with taking this patch, but someone should take second look
at the mainline.

Best regards,
								Pavel

--zg1K/anfbYOi09qi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCat+DUQAKCRAw5/Bqldv6
8tXCAKDBM1Kp8qpaCxxJDBvptMG9jU7cAwCfTY4NJmDGyifdfyjGOt4xL2vYku4=
=6QYi
-----END PGP SIGNATURE-----

--zg1K/anfbYOi09qi--
