Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8ABC0218C
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 20:07:28 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.17432.1737835640284907167
 for <cip-dev@lists.cip-project.org>;
 Sat, 25 Jan 2025 12:07:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=B7rHrNeV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D664101ECB20;
	Sat, 25 Jan 2025 21:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737835637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qni1HZ84XFFQM+9HCmMe+bK8Qj+rgCzup6yvJyVEeO0=;
	b=B7rHrNeVSu6b6xdGXQTBucXvTv+CJf7KvgCCKeCFpO5YLlSjQvaYC7POfSrJpZCe6xj0YF
	4W5gz1wpcy+tm4DQFdjTOo9N3W3hdx6vQWavB3d11pUUi2Q/D1hKybSlBz7D2hwLCd+dHY
	LrN/yYocQ2DKRvHYnXydjYGR6WcvosokXywdQqzidKZZ4DeofVj/MuUdITPq5Fo8QU8ZbE
	ODnWuOP2Hk22eiY/rHNX4ZAEpWywZkvx+NBziMLlQAVhGyT0i+LKFKxwKtrYbWZMOmEhm2
	4lyC+BlKTxx1oanNTccfZr78rVdrTx9+oYcFKxPXXpGnV3HNZBZ58emkyWLmIA==
Date: Sat, 25 Jan 2025 21:07:11 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH v5.10.y-cip v2 10/16] rtc: renesas-rtca3: Add driver for
 RTCA-3 available on Renesas RZ/G3S SoC
Message-ID: <Z5Toaw//Y4V4g418@duo.ucw.cz>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
 <20250124090041.1401132-11-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WNMG1IAorDRP7sIo"
Content-Disposition: inline
In-Reply-To: <20250124090041.1401132-11-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Jan 2025 20:07:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17663


--WNMG1IAorDRP7sIo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit d4488377609e36cd9785533c29ccea4b86c292b9 upstream.
>=20
> The RTC IP (RTCA-3) available on the Renesas RZ/G3S SoC has calendar count
> mode and binary count mode (selectable though RCR2.CNTMD) capabilities,
> alarm capabilities, clock error correction capabilities. It can generate
> alarm, period, carry interrupts.

You'll get some comments below. I guess these should be fixed in
mainline, first, so should not block merge.

> +++ b/drivers/rtc/rtc-renesas-rtca3.c
> +static irqreturn_t rtca3_periodic_handler(int irq, void *dev_id)
> +{
> +	struct rtca3_priv *priv =3D dev_id;
> +	u8 val, pending;
> +
> +	spin_lock(&priv->lock);
=2E..
> +	if (pending) {
=2E..
> +		if (atomic_read(&priv->alrm_sstep) > RTCA3_ALRM_SSTEP_IRQ) {
> +			/* Alarm setup in progress. */
> +			atomic_dec(&priv->alrm_sstep);
> +
> +			if (atomic_read(&priv->alrm_sstep) =3D=3D RTCA3_ALRM_SSTEP_IRQ) {

This is.. "interesting" use of atomic variable. It is likely safe,
because you are doing this under lock. In fact, most of the accesses
to priv->alrm_sstep are under lock, so best way may be to put
remaining uses under lock and switch alrm_sstep to normal int.

> +static int rtca3_read_time(struct device *dev, struct rtc_time *tm)
> +{
=2E..
> +	year =3D FIELD_GET(RTCA3_RYRCNT_YEAR, year);
> +	year100 =3D bcd2bin((year =3D=3D 0x99) ? 0x19 : 0x20);
> +	tm->tm_year =3D (year100 * 100 + bcd2bin(year)) - 1900;

Could this be simplified?

year100 =3D (year =3D=3D 0x99) ? 0 : 100;
tm->tm_year =3D year100 + bcd2bin(year);

or even:

if (year =3D=3D 0x99) tm->tm_year =3D 99;
else tm->tm_year =3D 100 + bcd2bin(year);

> +static int rtca3_set_time(struct device *dev, struct rtc_time *tm)
> +{
=2E..
> +	/* Update time. */
> +	writeb(bin2bcd(tm->tm_sec), priv->base + RTCA3_RSECCNT);
> +	writeb(bin2bcd(tm->tm_min), priv->base + RTCA3_RMINCNT);
> +	writeb(bin2bcd(tm->tm_hour), priv->base + RTCA3_RHRCNT);
> +	writeb(bin2bcd(tm->tm_wday), priv->base + RTCA3_RWKCNT);
> +	writeb(bin2bcd(tm->tm_mday), priv->base + RTCA3_RDAYCNT);
> +	writeb(bin2bcd(tm->tm_mon + 1), priv->base + RTCA3_RMONCNT);
> +	writew(bin2bcd(tm->tm_year % 100), priv->base + RTCA3_RYRCNT);

Note this does not do same 1999 year fixup. Plus will happily set
alarm for 1970 or 2110, when hardware can't do that.

> +static int rtca3_read_alarm(struct device *dev, struct rtc_wkalrm *wkalr=
m)
> +{
=2E..
> +	year =3D FIELD_GET(RTCA3_RYRAR_YR, year);
> +	year100 =3D bcd2bin((year =3D=3D 0x99) ? 0x19 : 0x20);
> +	tm->tm_year =3D (year100 * 100 + bcd2bin(year)) - 1900;

This is second copy of this year conversion code. Put it into helper?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WNMG1IAorDRP7sIo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5VEbwAKCRAw5/Bqldv6
8sEdAKCUFZGxtdoZchDNQVVoVu7/7CV6ugCfVw9WDPjLENkXcGGQEwD9nnxOF6U=
=BT3x
-----END PGP SIGNATURE-----

--WNMG1IAorDRP7sIo--

