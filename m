Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C58C77B7C
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 08:44:46 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.3753.1750754686105147632
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 01:44:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XwUpFEBn;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B06B9101EC1DA;
	Tue, 24 Jun 2025 10:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750754683; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OTIDkYxGSySZMp9dCFT9ti1IaPLvauH0yVTtRw614Q8=;
	b=XwUpFEBnHBOxIpmRWGRnjaWRcseQuMm2+GgTW2TGPj1Y2WraoDVavdtH4dAIwGKeRgFIxt
	PfDzHdeALnyFTbGYssTP9M9fM2sGDUVThKMmvkQw+GyfGj64cnGn2ZIxr4AYdNeGtE0k+J
	BoEQRu7PIN9aa9+clv6Io98wFuWSeUlxl38PYHTh+3v/FJ20CJRTgWn/i9ctJ5jhOJ+uSu
	l0aNxt7mmiWnhoB1BvOYLM8JqDfhkiZEgdTgFNNAgxh1b1aspDOZ+sXI31glbqSESmICAq
	7wXwWyvIwdSPHHdTgTRu3jP3wqwHTlnhVkmoRhhxrNcb5fE4h9+sZHgUYwym2A==
Date: Tue, 24 Jun 2025 10:44:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 07/17] mmc: renesas_sdhi: take DMA end
 interrupts into account
Message-ID: <aFpldcyO4dPmbwih@duo.ucw.cz>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
 <20250623144639.2119707-8-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OrWIKpLxBtpMV3A9"
Content-Disposition: inline
In-Reply-To: <20250623144639.2119707-8-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 08:44:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19226


--OrWIKpLxBtpMV3A9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit c330601c9c93392000c077d973b182cc0164b9ac upstream.
>=20
> So far, we have been relying on access_end interrupts only to mark DMA
> transfers as done implying that DMA end interrupts have occurred by then
> anyhow. On some SoCs under some conditions, this turned out to be not
> enough. So, we enable DMA interrupts as well and make sure that both
> events, DMA irq and access_end irq, have happened before finishing the
> DMA transfer.

> +	u32 dma_irqs =3D INFO1_DTRANEND0 |
> +			(priv->quirks && priv->quirks->old_info1_layout ?
> +			INFO1_DTRANEND1_OLD : INFO1_DTRANEND1);
>

This expression is ... fun enough to deserve macro or inline
function. It got better in follow up patches, but may be still worth
macro/inline.

Anyway, this is nothing to block the merge.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OrWIKpLxBtpMV3A9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFpldQAKCRAw5/Bqldv6
8n85AJoCUhccdAtDmFoE/hmexpbaqE8ZDQCfaaa02c65EmWDGmboOBnrhmwlzbk=
=qRqE
-----END PGP SIGNATURE-----

--OrWIKpLxBtpMV3A9--

