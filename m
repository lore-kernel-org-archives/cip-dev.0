Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32482E7316F
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 13:29:48 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52111.1770038979823095605
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 05:29:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cNWvuQAK;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A7D210D46A;
	Mon,  2 Feb 2026 14:29:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770038977;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=m8SgQNIaAZH20vil9pmToU/+R4Z2i0uN4S5OxBPQHQ4=;
	b=cNWvuQAKbrq4gorRAbv/wWDSSc1nYt0eMx6clHmS+oLT1lYOiDgYgHmso09z7ZyxZfgyup
	AcnSXqTgm7HCV6yShUtRKiTIZ8EIX6jwJZUQJtfKHqqdA7sjdsw2cXaM8aNPfwp4pdqe6b
	gGLgAPTFp5aUaw5YApuVNQD4HJZjCH1WG16Ol6/plkIsd3pUCsaln70Q7Ql49lTov9Q8tW
	/0OtLc1vGNs5OmguawkBr1ncxH42OawIFIDF89i/bsQb39oM1S7IFbYQGSeLk7fOOHX5St
	ZQjyIX+NM4r5DJD3j0uqdgHeBs8pQw962jZq/WT431Kb0HWeG8h4JrBf1uJuGQ==
Date: Mon, 2 Feb 2026 14:29:33 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 07/11] thermal/drivers/renesas/rzg3e: Fix add
 thermal driver for the Renesas RZ/G3E SoC
Message-ID: <aYCmvU2dsWdrMiG8@duo.ucw.cz>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
 <20260128132522.6902-8-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IWkjD7RGjZPryK5c"
Content-Disposition: inline
In-Reply-To: <20260128132522.6902-8-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 13:29:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21810


--IWkjD7RGjZPryK5c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: John Madieu <john.madieu.xa@bp.renesas.com>
>=20
> commit dc67521c20b701b5237ff486ae078829dc1f8fea upstream.
>=20
> When applied the change commit 19d3a401a617, a conflict appeared
> resulting into a manual fix. However the new file rzg3e_thermal.c was
> not added but stayed locally in source tree and miss to be merged with
> the entire change.
>=20
> Fix this by adding the file back.

Ok, so you know you made a mistake, but for -cip, it would be
better to put this before the 6/ patch. You can't undo the mistake for
mainline, but ou can do that for -cip :-).

> Fixes: 19d3a401a617 ("Add thermal driver for the Renesas RZ/G3E SoC")

>  - used devm_reset_control_get_exclusive() + reset_control_deassert() +
>    devm_add_action_or_reset() instead of
>    devm_reset_control_get_exclusive_deasserted() as the latter is not
>    available in v6.1 CIP; added rzg3e_thermal_reset_assert() action
>    function for this

Yep so... this seems to be repeat issue in Renesas patches. Are we
going to hit it again in future? If so, maybe we should introduce
devm_reset_control_get_exclusive_deasserted() to 6.1, too.

> +	/* Convert to temperature */
> +	*temp =3D rzg3e_thermal_code_to_temp(priv, code);
> +
> +	dev_dbg(priv->dev, "temp=3D%d mC (%d.%03d=B0C), code=3D0x%03x\n",
> +		*temp, *temp / 1000, abs(*temp) % 1000, code);
> +

I'd expect dmesg output to be ASCII, not unicode, as it goes over
various serial lines etc. So maybe =B0C -> degC or just C.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--IWkjD7RGjZPryK5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYCmvQAKCRAw5/Bqldv6
8g+9AJ45s6GdASVMoYPhRtFto240Dveo5ACfeWjGiwZvZ/Y2xvVgti/JtnbyjF4=
=UHsp
-----END PGP SIGNATURE-----

--IWkjD7RGjZPryK5c--

