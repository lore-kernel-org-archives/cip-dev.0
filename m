Return-Path: <SRS0=4xW5=CM=lists.cip-project.org=bounce+64572+5411+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7792C2D0E3
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:54:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83E5208C7
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="E3iOxoE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83E5208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5411+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VvdQYY4521723xPSzwHSGMBA; Thu, 03 Sep 2020 13:54:24 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.23903.1599166463174389363
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 13:54:23 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A068A1C0B79; Thu,  3 Sep 2020 22:54:21 +0200 (CEST)
Date: Thu, 3 Sep 2020 22:54:06 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 4/4] serial: sh-sci: Don't check for mctrl_gpio_to_gpiod() returning error
Message-ID: <20200903205406.GD24361@duo.ucw.cz>
References: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903142719.13010-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200903142719.13010-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mRUR9ow3kM4RNcCzrjkE7jayx4520388AA=
Content-Type: multipart/mixed; boundary="B9BJY8BIULUXo18G5NVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599166464;
 bh=7feiqBAO1lZw/fMoDElHLnqx62ZJkTJX9rn0tTsAtO4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=E3iOxoE/GvAOQplDuNhtOzZJgZSupq0GXbo/ybb7bZeiFOZ1HFUuNobAVwwF8NQVfIp
 R2299QGz00r8fNv+9GxW6ohbFUKWV4VIc1ceOdbUxWan+U4+Z4E9G3czHa8+YkYh+t4LD
 rWjVQoPEWedWviSGLLnibh0SMqcuzeZv3BA=

--B9BJY8BIULUXo18G5NVR
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline

--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Since commit 1d267ea6539f2663 ("serial: mctrl-gpio: simplify init
> routine"), mctrl_gpio_init() returns failure if the assignment to any
> member of the gpio array results in an error pointer.
> Since commit c359522194593815 ("serial: mctrl_gpio: Avoid probe failures
> in case of missing gpiolib"), mctrl_gpio_to_gpiod() returns NULL in the
> !CONFIG_GPIOLIB case.

Quick git log shows that "serial: mctrl_gpio: Avoid probe failures" is
not mentioned in 4.4 commit history. That very probably means that
this patch is not safe for 4.4 (situation similar to previous patch).

NAK.

Best regards,
								Pavel

> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1871,12 +1871,12 @@ static unsigned int sci_get_mctrl(struct uart_por=
t *port)
>  	if (s->autorts) {
>  		if (sci_get_cts(port))
>  			mctrl |=3D TIOCM_CTS;
> -	} else if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS))) {
> +	} else if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS)) {
>  		mctrl |=3D TIOCM_CTS;
>  	}
> -	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR)))
> +	if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR))
>  		mctrl |=3D TIOCM_DSR;
> -	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD)))
> +	if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD))
>  		mctrl |=3D TIOCM_CAR;
> =20
>  	return mctrl;
> @@ -2782,10 +2782,8 @@ static int sci_probe_single(struct platform_device=
 *dev,
>  		return PTR_ERR(sciport->gpios);
> =20
>  	if (p->capabilities & SCIx_HAVE_RTSCTS) {
> -		if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
> -							UART_GPIO_CTS)) ||
> -		    !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
> -							UART_GPIO_RTS))) {
> +		if (mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_CTS) ||
> +		    mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_RTS)) {
>  			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
>  			return -EINVAL;
>  		}
> --=20
> 2.17.1
>=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1FX7gAKCRAw5/Bqldv6
8lXWAJ9FM+kKmVzbeWIzO/DsGP0QgZjfSACfXWHGLUsVywWMvRwa46OpJlORemE=
=jgWR
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--

--B9BJY8BIULUXo18G5NVR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5411): https://lists.cip-project.org/g/cip-dev/message=
/5411
Mute This Topic: https://lists.cip-project.org/mt/76607965/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--B9BJY8BIULUXo18G5NVR--
