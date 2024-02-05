Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51C2C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 19:36:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3351.1707161804477303725
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 11:36:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2E4021C0050; Mon,  5 Feb 2024 20:36:42 +0100 (CET)
Date: Mon, 5 Feb 2024 20:36:41 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 35/48] cache: ax45mp_cache: Add non coherent
 support
Message-ID: <ZcE4yZZQD/T7qDaJ@duo.ucw.cz>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240205124135.14779-36-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gHpGZQFnGPtEwZxW"
Content-Disposition: inline
In-Reply-To: <20240205124135.14779-36-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 19:36:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14756


--gHpGZQFnGPtEwZxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As support for non-coherent DMA is missing in 5.10-cip for RISC-V
> architecture, introducing a new patch to support non-coherent DMA
> support on RZ/Five SoC.

> +void arch_sync_dma_for_cpu(phys_addr_t paddr,
> +			   size_t size, enum dma_data_direction dir)
> +{
> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +		break;
> +
> +	case DMA_FROM_DEVICE:
> +	case DMA_BIDIRECTIONAL:
> +		/* FROM_DEVICE invalidate needed if speculative CPU prefetch only */

I believe the comment will need fixing w.r.t. english.

Plus, some explanation. The risc-v CPU you are using is not doing
speculative execution, right?

> +		ax45mp_dma_cache_inv(paddr, size);

If it is, it could do prefetch here, and break the rules, no?

If it is not, do we need the invalidate?

> +		break;

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gHpGZQFnGPtEwZxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcE4yQAKCRAw5/Bqldv6
8q7ZAKCOJh58BYOufe9d1yDutAM045ZHDQCggehE2dPrLwDll3dzrMOxxAhoVcE=
=tJjp
-----END PGP SIGNATURE-----

--gHpGZQFnGPtEwZxW--

