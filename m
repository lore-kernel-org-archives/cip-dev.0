Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0188DC44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 10:18:20 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3124.1784110694601749590
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 03:18:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=gs0R3TpT;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6616A119B5D;
	Wed, 15 Jul 2026 12:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784110692;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Pmf1uvVXV7p386ZCk/NnF5gGwjgwUs1bCAX5V2kd4Ec=;
	b=gs0R3TpTShLKKwLHUfH84a+HAOT9d24vpZd4xa6KUHeuB95dE109T9x+XxA5Pq8K81GqKl
	JoJzBdcAzK+azLCKDmHZ19M72UyMDWzvx0/cZrA8uUkH6TYOhUWDfeQRHJZc7ekkanDA0s
	vQpcV2zWGyE36vvZkWBRzrtDxkAdpyJoYpwZr4eU2gi6uFLu8Y0hluRGZd2k0dNBgRpr4L
	NYafSZSfEplUDWwyq+AKu21gpvV/1PJSuo+yTKRXcg0yahud/ypvHeP1odVHtg/BtzbLJw
	zd52A6n7bOPUhHGaRvAE7U/vs4Gbni/2QhkeDA+cjBd9MTyozraSMsXs5FcsOA==
Date: Wed, 15 Jul 2026 12:18:09 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 10/23] pinctrl: renesas: rzg2l: Add support
 for selecting power source for {WDT,AWO,ISO}
Message-ID: <aldeYc-IRbM2fWHP@duo.ucw.cz>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-11-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hhBE4dtVOGXHZii9"
Content-Disposition: inline
In-Reply-To: <20260703105923.251255-11-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 10:18:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23590


--hhBE4dtVOGXHZii9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The RZ/G3L SoC has support for setting power source that are not
> controlled by the following voltage control registers:
>   - SD_CH{0,1,2}_POC, XSPI_POC, ETH{0,1}_POC, I3C_SET.POC
>=20
> Add support for selecting voltages using OTHER_POC register for
> setting I/O domain voltage for WDT, ISO and AWO by extending
> rzg2l_caps_to_pwr_reg() with a mask output parameter so that callers
> callers can identify which bit(s) within OTHER_POC correspond to the
> requested domain. Update rzg2l_get_power_source() to extract the
> relevant bit field via field_get() when reading OTHER_POC, and update
> rzg2l_set_power_source() to perform a read-modify-write under the
> spinlock when writing to OTHER_POC, since multiple domains share the
> same register.

I believe more robustness is needed here.

> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -958,25 +983,37 @@ static int rzg2l_set_power_source(struct rzg2l_pinc=
trl *pctrl, u32 pin, u32 caps
> =20
>  	switch (ps) {
>  	case 1800:
> -		val =3D PVDD_1800;
> +		poc_val =3D PVDD_1800;
>  		break;
>  	case 2500:
>  		if (!(caps & (PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH1)))
>  			return -EINVAL;
> -		val =3D PVDD_2500;
> +		poc_val =3D PVDD_2500;
>  		break;
>  	case 3300:
> -		val =3D PVDD_3300;
> +		poc_val =3D PVDD_3300;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> =20
> -	pwr_reg =3D rzg2l_caps_to_pwr_reg(regs, caps);
> +	pwr_reg =3D rzg2l_caps_to_pwr_reg(regs, caps, &mask);
>  	if (pwr_reg < 0)
>  		return pwr_reg;
> =20
> -	writeb(val, pctrl->base + pwr_reg);
> +	if (pwr_reg =3D=3D OTHER_POC) {
> +		scoped_guard(raw_spinlock, &pctrl->lock) {
> +			val =3D readb(pctrl->base + pwr_reg);
> +			if (poc_val)
> +				val |=3D mask;
> +			else
> +				val &=3D ~mask;
> +			writeb(val, pctrl->base + pwr_reg);
> +		}

This is strange. You test that ps is right ammount of milivolts, but
here you just ignore poc_val, no matter if user selected 1800, 2500 or
3300mV.

I believe you should cross-check values here, so that if user requests
1800mV, he does not silenly get 3300mV (or vice versa, I'm not sure
how the hardware work).

Best regards,
								Pavel

--hhBE4dtVOGXHZii9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaldeYQAKCRAw5/Bqldv6
8k1DAKCj7KTCCuwovw2nfbBoZ9+r9e0jPwCgjO6CArXec10cGUtx+ZAPs0w92Ro=
=AYLA
-----END PGP SIGNATURE-----

--hhBE4dtVOGXHZii9--

