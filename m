Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C220C369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 19:15:57 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3299.1745435753199647816
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 12:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=AtAAcPJ2;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E005102A8CAA;
	Wed, 23 Apr 2025 21:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745435751; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=o6kXnlLLsWQdEspvtF441VKu4Kf4uxovpz+oPosG8fM=;
	b=AtAAcPJ2CgQQ1M7MapSmbVtQX4demOJXev41Au9YNOdlzf6OlFnZ54iXayOd4LlcE268Df
	w3mK+D5fWkHJlxsWQJ4kOkKwXzhlAN19bspmB3bPk36i6FdLlBqjHvWfUVbt6FBSXzJXRY
	6OlLRj3nDNT+UOVB2Je2Mha/cT/NelpMkDetEsdJM0VHPaDQjzluOM/B8k/OPK5+OgiEqh
	f7FgVRZtKzaj6SzIAYMdka7rmMHvcFTGu8XtgsNoNk3cV9Za4nDgeWkteAAbWDodB0JFV+
	gUhS98yrFGsLtXeQayeU9BDwLpSqERxvolKjp4S/rkwllDm8owO/929jH3sl4g==
Date: Wed, 23 Apr 2025 21:15:43 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 6.12.y-cip 03/10] soc: renesas: Add SYSC driver for
 Renesas RZ family
Message-ID: <aAk8X/KVkfcYJz2O@duo.ucw.cz>
References: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250423181400.13960-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R0B5FHTKqjE6ku4t"
Content-Disposition: inline
In-Reply-To: <20250423181400.13960-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 19:15:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18580


--R0B5FHTKqjE6ku4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit c1aca5588279fc341a2e12d61e853bb1fd4c72d5 upstream.
>=20
> The RZ/G3S system controller (SYSC) has various registers that control
> different functionalities.  One of the exposed register offers
> information about the SoC identification.
>=20
> Add a driver that identifies the SoC.  Later the driver will be extended
> with other functionalities.

Nitpick:

> +++ b/drivers/soc/renesas/rz-sysc.c
> +static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct of_device=
_id *match)
> +{
> +	const struct rz_sysc_init_data *sysc_data =3D match->data;
> +	const struct rz_sysc_soc_id_init_data *soc_data =3D sysc_data->soc_id_i=
nit_data;
> +	struct soc_device_attribute *soc_dev_attr;
> +	const char *soc_id_start, *soc_id_end;
> +	u32 val, revision, specific_id;
> +	struct soc_device *soc_dev;
> +	char soc_id[32] =3D {0};
> +	size_t size;
> +
> +	soc_id_start =3D strchr(match->compatible, ',') + 1;
> +	soc_id_end =3D strchr(match->compatible, '-');
> +	size =3D soc_id_end - soc_id_start + 1;
> +	if (size > 32)
> +		size =3D sizeof(soc_id);

I'd expect sizeof(soc_id) instead of 32... or maybe 32 in both places,
or maybe const int max_size =3D 32, and then using it three times.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--R0B5FHTKqjE6ku4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAk8XwAKCRAw5/Bqldv6
8mZDAKC/YRN/T2kNn3SmVoco92gkp1fUNwCdE4SCqd6McLhVDoTZpNDQ5q/L9LU=
=qu5x
-----END PGP SIGNATURE-----

--R0B5FHTKqjE6ku4t--

