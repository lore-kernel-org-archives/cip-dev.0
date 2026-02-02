Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C416E7316C
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 13:21:08 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52320.1770038464517266208
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 05:21:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cldP+GZt;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB19E10A8D2;
	Mon,  2 Feb 2026 14:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770038462;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+BAVE9u576yCtiSqsVO9OBYGMQmISXSlojc7uJRAwxw=;
	b=cldP+GZty6owkmiB5SDUJ/92DnINfNPMcc90XbQrXQjEUQ8v8o2t+aw2pOve0wfubsB9U1
	vr2aSn0EoePDrWZgQwO6VGBzVTD7lnUSsRvIzTOQ21XNGTKqzkXmCSAZurToU0iywgcmCo
	6IhnUdlY+Ywyc+lP1EFkblfyHvxJKuNPztt+9V4CFOgTpPbfkzG6/34BDi5k7c/2uijIut
	dB/aTEh1ttRkVIi8oNe52dACitG/mEteMZZe2hX6+e2WlEiukSAksJSL7tNjnYzbG8Wzqv
	4poXUD3eW6PN9qGLYa8L2vrrKrUhs9hzWpdhd/0ERrcOgMA2GkbNPDZThNFT/Q==
Date: Mon, 2 Feb 2026 14:21:00 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 06/11] thermal/drivers/renesas/rzg3e: Add
 thermal driver for the Renesas RZ/G3E SoC
Message-ID: <aYCkvAeQu+kLXDlZ@duo.ucw.cz>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
 <20260128132522.6902-7-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LOFYOdQoxBqgR3FT"
Content-Disposition: inline
In-Reply-To: <20260128132522.6902-7-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 13:21:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21808


--LOFYOdQoxBqgR3FT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/drivers/thermal/Kconfig
> @@ -373,6 +373,13 @@ config RZG3S_THERMAL
>  	  Enable this to plug the RZ/G3S thermal sensor driver into the Linux
>  	  thermal framework.
> =20
> +config RZG3E_THERMAL
> +	tristate "Renesas RZ/G3E thermal driver"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	help
> +	 Enable this to plug the RZ/G3E thermal sensor driver into the Linux
> +	 thermal framework
> +

There should really be "." at the end of sentence. Plus, there's
something wrong with indentation here, as this is indented differently
=66rom the entry above.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--LOFYOdQoxBqgR3FT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYCkvAAKCRAw5/Bqldv6
8nrbAKCHij7H0wtDLElMqRNKzsyI7ABa+wCgnBcBAVjzB1jwKir11zJ2yi5n8fg=
=IvQ0
-----END PGP SIGNATURE-----

--LOFYOdQoxBqgR3FT--

