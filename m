Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9893DC46CD3
	for <webhook@archiver.kernel.org>; Tue, 26 Dec 2023 18:36:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.86331.1703615787231141189
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Dec 2023 10:36:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A02E71C0050; Tue, 26 Dec 2023 19:36:25 +0100 (CET)
Date: Tue, 26 Dec 2023 19:36:24 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH RFC 17/30] cache: Add L2 cache management for Andes
 AX45MP RISC-V core
Message-ID: <ZYsdKDiw7G+kxQ3m@duo.ucw.cz>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231220230646.219816-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M5ZWvZ4no9DuopX5"
Content-Disposition: inline
In-Reply-To: <20231220230646.219816-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Dec 2023 18:36:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14197


--M5ZWvZ4no9DuopX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +static void ax45mp_dma_cache_inv(phys_addr_t paddr, size_t size)
> +{
> +	unsigned long start =3D (unsigned long)phys_to_virt(paddr);
> +	unsigned long end =3D start + size;
> +	unsigned long line_size;
> +	unsigned long flags;
> +
> +	if (unlikely(start =3D=3D end))
> +		return;
> +
> +	line_size =3D ax45mp_priv.ax45mp_cache_line_size;
> +
> +	start =3D start & (~(line_size - 1));
> +	end =3D ((end + line_size - 1) & (~(line_size - 1)));

Could some macros be used to make this more readable? I'm pretty sure
we have macros for cacheline alignment and aligning end to cacheline bounda=
ry.

> +	local_irq_save(flags);
> +
> +	ax45mp_cpu_dcache_inval_range(start, end);
> +
> +	local_irq_restore(flags);
> +}
> +
> +static void ax45mp_dma_cache_wback(phys_addr_t paddr, size_t size)
> +{
> +	unsigned long start =3D (unsigned long)phys_to_virt(paddr);
> +	unsigned long end =3D start + size;
> +	unsigned long line_size;
> +	unsigned long flags;
> +
> +	line_size =3D ax45mp_priv.ax45mp_cache_line_size;
> +	start =3D start & (~(line_size - 1));
> +	local_irq_save(flags);
> +	ax45mp_cpu_dcache_wb_range(start, end);
> +	local_irq_restore(flags);
> +}

This should be very similar to the previous function, but is not.

In particular, it does not check start =3D=3D end special case, and does
not line-align the end.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--M5ZWvZ4no9DuopX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZYsdKAAKCRAw5/Bqldv6
8svmAKC83kRAn93s4ORfepm1tL6qeu2TxgCfdx0aUmsifU85PrzLEwwK9mlp/ns=
=z6qT
-----END PGP SIGNATURE-----

--M5ZWvZ4no9DuopX5--

