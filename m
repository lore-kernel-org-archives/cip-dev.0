Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C99C77B73
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:00:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5062.1686045600499559232
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:00:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 524661C0CAF; Tue,  6 Jun 2023 11:59:57 +0200 (CEST)
Date: Tue, 6 Jun 2023 11:59:56 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Message-ID: <ZH8DnHZb8dDrq+Zm@duo.ucw.cz>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABO6qcVyo1oTBrCm"
Content-Disposition: inline
In-Reply-To: <20230606075235.183132-4-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:00:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11855


--ABO6qcVyo1oTBrCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue 2023-06-06 08:52:30, Biju Das wrote:
> commit 654c293e1687b31819f9bf1ac71b5a85a8053210 upstream.
>=20
> The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> the Renesas RZ/G2L family SoCs. It consists of eight 16-bit timer
> channels and one 32-bit timer channel. It supports the following
> functions
>  - Counter
>  - Timer
>  - PWM
>=20
> The 8/16/32 bit registers are mixed in each channel.
>=20
> Add MTU3a core driver for RZ/G2L SoC. The core driver shares the
> clk and channel register access for the other child devices like
> Counter, PWM and Clock event.

> +struct rz_mtu3_priv {
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	raw_spinlock_t lock;
> +};

Why is raw_spinlock used here? This is not really a core code... this
makes analysis for rt safety more interesting.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ABO6qcVyo1oTBrCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH8DnAAKCRAw5/Bqldv6
8oJQAJ9F2RSAD3A/TDRdj5qxmTfHqhFyxgCfaPlly/Zq6xHUD4sJHOs9AvCMeDY=
=SXne
-----END PGP SIGNATURE-----

--ABO6qcVyo1oTBrCm--

