Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F12C4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 10:29:27 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19532.1784629763405588254
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 03:29:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=f0crZVkc;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A28E211AA5F;
	Tue, 21 Jul 2026 12:29:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784629760;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zGNxLYA2/SUwWgTiuoMYZsILmVJWIqTiQG6CjJr10BE=;
	b=f0crZVkcfJRMX4Rch/pvNwfWFCqdRHZ9Mb50x3gNSR5dDHWJ3GX99tSIGqUtf7fzwXZ13i
	G8cdBn3YmUOx+u9MzJ+57av9xwKBYyu3taf8E4UlJ0yhOrz35OxwN8CUt/111dFeKBRaYM
	EfGkqH62CVOBF+MAPtl8f+xRRX6rI+kMbziXSaq7WxtKmxd96P6HU/+4J1I7isbd/PsHcq
	SYZQwUrCKe46gctYw4X+UsqnpNUqJY2omu2RhLeT5+a92cpN8YNb57INUY4vZAZ2ukJqQz
	OkwYm58yZhlEt/uwsQHH8YSvHLhfA384xW2TaT/V/AUaurJdbUv59kHfVJaHLw==
Date: Tue, 21 Jul 2026 12:29:16 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	tommaso.merciai.xr@bp.renesas.com
Subject: Re: [cip-dev] [PATCH v2 6.1.y-cip] i3c: master: dw: stop hardcoding
 initial speed
Message-ID: <al9J_Pud3pqoEXBO@duo.ucw.cz>
References: <1784598692-26475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SR3e3J4saubMK7mE"
Content-Disposition: inline
In-Reply-To: <1784598692-26475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 10:29:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23693


--SR3e3J4saubMK7mE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jack Chen <zenghuchen@google.com>
>=20
> commit 510d2358c466bf6588034f0d3b2266eed2bc0a51 upstream.
>=20
> Bus-speed could be default(12.5MHz) or defined by users in dts.
> Dw-i3c-master should not hard-code the initial speed to be
> I3C_BUS_TYP_I3C_SCL_RATE (12.5MHz)
> And because of Synopsys's I3C controller limit (hcnt/lcnt register
> length) and core-clk provided, there is a limit to bus speed, too.
> For example, when core-clk is 250 MHz, the bus speed cannot be
> lowered below 1MHz.
>=20
> Tested: tested with an i3c sensor and captured with a logic
> analyzer.

This is already in 6.12.0, so no need to do anything there. Looks good
to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I'll apply it if it passes testing (and there are no other comments).

Best regards,
                                                                Pavel


> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -531,7 +531,7 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *maste=
r)
>  	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
>  		hcnt =3D SCL_I3C_TIMING_CNT_MIN;
> =20
> -	lcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
> +	lcnt =3D DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
>  	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
>  		lcnt =3D SCL_I3C_TIMING_CNT_MIN;
> =20
> @@ -541,7 +541,8 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *maste=
r)
>  	if (!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_I2C_SLAVE_PRESENT))
>  		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
> =20
> -	lcnt =3D DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period);
> +	lcnt =3D max_t(u8,
> +		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
>  	scl_timing =3D SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
>  	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
> =20

--SR3e3J4saubMK7mE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCal9J/AAKCRAw5/Bqldv6
8n/jAJ4s6+T6rU1shBYlMzwSto8mIZWHkQCfWSTsvtEsnzZSuDYYqrRUh2MKf3k=
=uTW5
-----END PGP SIGNATURE-----

--SR3e3J4saubMK7mE--

