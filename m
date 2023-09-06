Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF64EB8FAF
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 12:05:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.6821.1694001894045130086
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 05:04:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9A8C61C000B; Wed,  6 Sep 2023 14:04:50 +0200 (CEST)
Date: Wed, 6 Sep 2023 14:04:50 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: Re: [cip-dev] [isar-cip-core 1/3] Kconfig: Opt additional IEC
 62443-4-2 features when security option is selected
Message-ID: <ZPhq4o2lJ5B40ryZ@duo.ucw.cz>
References: <20230906045643.2640096-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230906045643.2640096-2-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6bxp79wzxDKlXdeh"
Content-Disposition: inline
In-Reply-To: <20230906045643.2640096-2-Sai.Sathujoda@toshiba-tsip.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 12:05:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12987


--6bxp79wzxDKlXdeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Data encryption, Secureboot and Swupdate options will be automatically
> selected when security extensions is selected.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>

Would "Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>"
be more appropriate sign-off?

> ---
>  Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Kconfig b/Kconfig
> index ec49631..75d6ba4 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -170,6 +170,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
> =20
>  config IMAGE_SECURITY
>  	bool "Security extensions"
> +        select IMAGE_DATA_ENCRYPTION
> +        help
> +          This enables security, encrpytion, secureboot and swupdate for=
 IEC 62443-4-2.


"encryption".

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6bxp79wzxDKlXdeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPhq4gAKCRAw5/Bqldv6
8ldQAKCKVglkpJTepORqR+V4Vs/+Woxl1gCfZaE4v/XNthxzUi6rxHjLQyHb1Sc=
=/KdW
-----END PGP SIGNATURE-----

--6bxp79wzxDKlXdeh--

