Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B70ACCF9EE
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 09:24:16 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2889.1761729852848404988
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 02:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=eT4MzDqp;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12E37101E8B7F;
	Wed, 29 Oct 2025 10:24:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1761729851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lVCZbgtgGjI6qkEAr09WyO/TEYqUbefQ9L3sBSaPjB4=;
	b=eT4MzDqpcGP5T/7M47ncI5TdS6TM2sNPME3rkQuQVO3QBMh6WBLSDJoXgbWNZG+3LhFGMk
	+vwqxj4NXGsgZKlo+iSHTgCQQNlnjXD7MO3nXY0HLX7KrULvPLltULoG1rfE3MFMkSU/ew
	bnDAc+sUAH70hatACzH7w2OFSyYY2OhoVavbQmTnIGL7ywm2cEeKrXmy0H3BoewApdiA67
	Xlw5CGXwbnfXgFtpz12/xUmvB2InKzDLP10eLrCRmWTlz9Mcs7PmC+crGPGAQ8PBdfr2zE
	FkvCooVXofGlN9D1QCBBITlMuXWOWlIe76IJS8s90W1W4ab7fv/3vyNnLLHzNw==
Date: Wed, 29 Oct 2025 10:24:06 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip] mm: page_alloc: Add kernel parameter to
 select maximum PCP batch scale number
Message-ID: <aQHdNhBR2DiWAtEx@duo.ucw.cz>
References: <20251027092658.84955-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mo7TAx6uuBYuI2Dr"
Content-Disposition: inline
In-Reply-To: <20251027092658.84955-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 09:24:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20272


--mo7TAx6uuBYuI2Dr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid
> too long latency") introduced default PCP (Per-CPU Pageset) batch size as
> a configuration flag. The configuration flag is CONFIG_PCP_BATCH_SCALE_MA=
X.
>=20
> The ARM64 defconfig has CONFIG_PCP_BATCH_SCALE_MAX=3D5. This defconfig
> is used by a high range of SoCs.
>=20
> The Renesas RZ/G3S SoC is a single CPU SoC, with L1$ (I-cache 32Kbytes,
> D-cache 32 Kbytes), L3$ (256 Kbytes), but no L2$. It is currently used in
> a configuration with 1 GiB RAM size. In this configuration, starting with
> commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid too
> long latency") the "bonnie++ -d /mnt -u root" benchmark takes ~14 minutes
> while previously it took ~10 minutes. The /mnt directory is mounted on SD
> card. Same behavior is reproduced on similar Renesas single core devices
> (e.g., Renesas RZ/G2UL). bonnie++ version used was 1.04.
>=20
> Add a new kernel parameter to allow systems like Renesas RZ/G3S to
> continue have the same performance numbers with the default mainline
=2E..

> This patch was posted as RFC at [1] but got no feedback. Starting with
> kernel v6.17 the behaviour was restored by commits:
>=20
> 18ebe55a9236 ("mm/readahead: terminate async readahead on natural boundar=
y")
> 38b0ece6d763 ("mm/filemap: allow arch to request folio size for exec
> memory")

Ok, so this is not mainline, because mainline has different solution.

It is also not queued for stable.

It introduces kernel parameter that will be special for -cip, not seen
in mainline nor -stable.

Presumably you'll be telling your customers to set the command line
parameter. Would it make sense to ask them to tune the config instead?

Best regards,
									Pavel

> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4734,6 +4734,12 @@
>  			for debug and development, but should not be
>  			needed on a platform with proper driver support.
> =20
> +	pcp_batch_scale_max=3Dn
> +			Format: <integer>
> +			Range: 0,6 : number
> +			Default : CONFIG_PCP_BATCH_SCALE_MAX
> +			Used for setting the scale number for PCP batch scale algorithm.
> +
>  	pdcchassis=3D	[PARISC,HW] Disable/Enable PDC Chassis Status codes at
>  			boot time.
>  			Format: { 0 | 1 }

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mo7TAx6uuBYuI2Dr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQHdNgAKCRAw5/Bqldv6
8gwBAJ9HvnmbUd6b2GgRDSRixajXu+jCzQCfaB4BItTefeMCvUP/dXJmZo2sYs0=
=OzcA
-----END PGP SIGNATURE-----

--mo7TAx6uuBYuI2Dr--

