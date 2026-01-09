Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29098D16802
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:30:17 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7455.1767954591985370217
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 02:29:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dRtnOmn4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEC5310B93A;
	Fri,  9 Jan 2026 11:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767954590;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=I3KhyQUqsgT+gOhsBlOa23Hq/anVOWO6f801/NJfmA8=;
	b=dRtnOmn43YEm2poxxLu/HRd6V4DxB5k5S8Aknta7Sk6VDSJd5f/s2zdYBEK/rX/MyR0aG6
	osdB1XJfKMSOeOYv4Dm/flzCPjYwR7OzxBG6TsKdCO+58XG44o7cGqu/BBXJZwlFJy50dk
	bwQ6QYMM2v0LCOJPjlCPIooibqEDosD9zRhbMQNcuvyLlC4bbYOB91deW6h4uCtDl5knnW
	XibxX0hrUw4Oi6v3c227vUC9hxDgd/lmi0Zdm8HPYdLkXTv4GiwmTX7f6dqdC6TjqZaSF0
	1Tmrqdx7GmpVmMf6hoDnvLICzrkumBIwppkeYQFsOTl1aJxRGhRoMknXW0YWKg==
Date: Fri, 9 Jan 2026 11:29:45 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 18/22] hwmon: (tmp108) Add NXP
 p3t1085 support
Message-ID: <aWDYmZhusaYmPaUw@duo.ucw.cz>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <20260108092823.489287-19-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XHy+sxZ4Ln9SsGr"
Content-Disposition: inline
In-Reply-To: <20260108092823.489287-19-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 10:30:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21497


--0XHy+sxZ4Ln9SsGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add compatible string 'nxp,p3t1085' since p3t1085's register layout is the
> same as tmp108.

> +++ b/drivers/hwmon/Kconfig
> @@ -2063,7 +2063,7 @@ config SENSORS_TMP108
>  	select REGMAP_I2C
>  	help
>  	  If you say yes here you get support for Texas Instruments TMP108
> -	  sensor chips.
> +	  sensor chips and NXP P3T1085.
>

I believe this should be something like

"Enable this driver to get get support for Texas Instruments TMP108
and NXP P3T1085 sensor chips."

Plus, this should really modify the config "" text, otherwise users
will not see this supports P3T1085 unless they open help...?

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--0XHy+sxZ4Ln9SsGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWDYmQAKCRAw5/Bqldv6
8nWLAJ4p0KlgHJ6irvga2xfJ1wVwpMMEdwCfRfBFnf/agC5jGxf0nK1i5MY/q3Y=
=U3TO
-----END PGP SIGNATURE-----

--0XHy+sxZ4Ln9SsGr--

