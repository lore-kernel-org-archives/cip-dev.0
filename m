Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496FC3DA49
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 12:30:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.16362.1722342640101104516
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jul 2024 05:30:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ABB7D1C008E; Tue, 30 Jul 2024 14:30:38 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:30:38 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 12/13] rtc: isl1208: Add a delay for clearing
 alarm
Message-ID: <Zqjc7hY7eEXVDTfX@duo.ucw.cz>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
 <20240729153504.510443-13-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4io9EUgHJI2teuBB"
Content-Disposition: inline
In-Reply-To: <20240729153504.510443-13-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jul 2024 12:30:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16685


--4io9EUgHJI2teuBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 0dbd610c426ed695eef5d26584259d96b6250c76 upstream.
>=20
> As per the latest HW manual[1], the INT# output is pulled low after the
> alarm is triggered. After the INT# output is pulled low, it is low for at
> least 250ms, even if the correct action is taken to clear it. It is
> impossible to clear ALM if it is still active. The host must wait for the
> RTC to progress past the alarm time plus the 250ms delay before clearing
> ALM.

> [1]https://www.renesas.com/us/en/document/dst/raa215300-datasheet?r=3D150=
6351

Ok, so this is kind of interesting. Yes, Renesas hw manual documents
250ms delay, but is that true for other chips? This seems to be
generic driver.

> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/bcd.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -628,6 +629,18 @@ isl1208_rtc_interrupt(int irq, void *data)
>  	struct isl1208_state *isl1208 =3D i2c_get_clientdata(client);
>  	int handled =3D 0, sr, err;
> =20
> +	if (!isl1208->config->has_tamper) {
> +		/*
> +		 * The INT# output is pulled low 250ms after the alarm is
> +		 * triggered. After the INT# output is pulled low, it is low for
> +		 * at least 250ms, even if the correct action is taken to clear
> +		 * it. It is impossible to clear ALM if it is still active. The
> +		 * host must wait for the RTC to progress past the alarm time
> +		 * plus the 250ms delay before clearing ALM.
> +		 */
> +		msleep(250);
> +	}

Plus 250 msec in interrupt handler is strange. I guess this is i2c so
you can sleep, but... Plus I'd expect it to be conditional on we
having the alarm interrupt?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4io9EUgHJI2teuBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqjc7gAKCRAw5/Bqldv6
8sJDAJ90ig2OP7W5FwEn68uG1clVMp+/SgCfaUIOT6Dkzd0zDyT/elxBHmCACpQ=
=EnX2
-----END PGP SIGNATURE-----

--4io9EUgHJI2teuBB--

