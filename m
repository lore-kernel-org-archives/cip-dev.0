Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA418C43217
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 09:10:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.38390.1669885803652520353
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Dec 2022 01:10:04 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E28B31C09FC; Thu,  1 Dec 2022 10:10:00 +0100 (CET)
Date: Thu, 1 Dec 2022 10:10:00 +0100
From: Pavel Machek <pavel@denx.de>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: pavel@denx.de, cip-dev@lists.cip-project.org, uli@fpond.eu,
	Peter Foley <pefoley2@pefoley.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RESEND][PATCH for 4.4.y] extcon: adc-jack: Fix incompatible
 pointer type warning
Message-ID: <Y4hvaLkRZm8fiWYV@duo.ucw.cz>
References: <20221201001903.1695510-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+uE0t1KFnGPkq4qR"
Content-Disposition: inline
In-Reply-To: <20221201001903.1695510-1-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 09:10:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10150


--+uE0t1KFnGPkq4qR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Peter Foley <pefoley2@pefoley.com>
>=20
> commit 8a522bf2d4f788306443d36b26b54f0aedcdfdbe upstream.
>=20
> This patch fixes the incompatible warning of extcon-adc-jack.c driver
> when calling devm_extcon_dev_allocate().

So AFAICT:

This is not applicable to 4.4-st.

This problem exists in both 4.4-cip and 4.4-cip-rt, but our testing
only discovered it in -cip-rt variant.

I can apply it to 4.4-cip if that's okay with everyone.

Thanks and best regards,
								Pavel
							=09
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> [cw00.choi: Modify the patch title and descritpion]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  include/linux/extcon/extcon-adc-jack.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/extcon/extcon-adc-jack.h b/include/linux/extco=
n/extcon-adc-jack.h
> index 53c60806bcfb6d..373b76a90ed41c 100644
> --- a/include/linux/extcon/extcon-adc-jack.h
> +++ b/include/linux/extcon/extcon-adc-jack.h
> @@ -58,7 +58,7 @@ struct adc_jack_pdata {
>  	const char *name;
>  	const char *consumer_channel;
> =20
> -	const enum extcon *cable_names;
> +	const unsigned int *cable_names;
> =20
>  	/* The last entry's state should be 0 */
>  	struct adc_jack_cond *adc_conditions;

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+uE0t1KFnGPkq4qR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4hvaAAKCRAw5/Bqldv6
8j+3AJ4kAb7M3lpM5BPcQA7txN+aTO5ymACffKOqWlgtWskzHrqeuUD6U72RcD8=
=Hf+Z
-----END PGP SIGNATURE-----

--+uE0t1KFnGPkq4qR--

