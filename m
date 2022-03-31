Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E20C433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 10:18:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.5358.1648721914546725899
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 03:18:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 17C6D1C0B96; Thu, 31 Mar 2022 12:18:32 +0200 (CEST)
Date: Thu, 31 Mar 2022 12:18:31 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 15/39] mmc: renesas_sdhi: Add a condition of
 cmd/data timeout for retune
Message-ID: <20220331101831.GD21513@amd>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20220330185454.10887-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 10:18:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7898


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit ed2fab9a8229cc70fe03032e48d0ec375df6013e upstream.
>=20
> According to the datasheet, this controller needs retune when
> cmd or data timeout happens. So, add a condition into
> .check_retune().

> @@ -790,11 +792,19 @@ static bool renesas_sdhi_check_scc_error(struct tmi=
o_mmc_host *host)
>  	if (mmc_doing_tune(host->mmc))
>  		return false;
> =20
> +	if (((mrq->cmd->error =3D=3D -ETIMEDOUT) ||
> +	     (mrq->data && mrq->data->error =3D=3D -ETIMEDOUT)) &&
> +	    ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
> +	     (host->ops.get_cd && host->ops.get_cd(host->mmc))))
> +		ret |=3D true;

I'd preffer simple "ret =3D true" here.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJFf/cACgkQMOfwapXb+vJefACgprvvbgB0vLv6slPhYkgf+kgc
+rAAn2V55+c1f2nAZ5h4AKZfzhGxilwM
=RKid
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--

