Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC2EB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 20:44:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7254.1689108293078146052
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 13:44:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3C02C1C0AC1; Tue, 11 Jul 2023 22:44:50 +0200 (CEST)
Date: Tue, 11 Jul 2023 22:44:49 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: Re: [cip-dev] [isar-cip-core] Kconfig: Add additional features to
 security image
Message-ID: <ZK2/Qarei/u9hbEW@duo.ucw.cz>
References: <20230711133838.437045-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UsxtliONbjIuU3fD"
Content-Disposition: inline
In-Reply-To: <20230711133838.437045-1-Sai.Sathujoda@toshiba-tsip.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 20:44:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12324


--UsxtliONbjIuU3fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> From IEC certification perspective, a security image is needed which has =
the
> below features along with security customizations.
> 1. Data encryption (CR4.1)
> 2. Secure boot (EDR 3.14)
> 3. SWupdate (NDR 3.10)
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Kconfig b/Kconfig
> index 94e807a..a9c3425 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -171,6 +171,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
> =20
>  config IMAGE_SECURITY
>  	bool "Security extensions"
> +	select IMAGE_DATA_ENCRYPTION
> +	help
> +	  This enables security customizations, data encryption, Secureboot and=
 SWupdate, all in need for IEC certification perspective.
> =20

Is Kconfig help text usually wrapped at 80-or-so columns? (I know this
applies to kernel kconfig, but it also may be case here...?)

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UsxtliONbjIuU3fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZK2/QQAKCRAw5/Bqldv6
8oHaAJ91komddbI84KBoTHWB+TWADAEIAgCgmmzwjkyP0Jt8JQSUDH6iMkluEDk=
=CpAK
-----END PGP SIGNATURE-----

--UsxtliONbjIuU3fD--

