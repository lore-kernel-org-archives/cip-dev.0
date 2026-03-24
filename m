Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C9DE9A746
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:21:55 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15844.1774344109286407639
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:21:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=TIXFhiXY;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 071D611212F;
	Tue, 24 Mar 2026 10:21:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774344107;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Q+2YfwuuOSB3rJ0ZAc6bb5G3+hn5MKKS8W2zy/qXqX4=;
	b=TIXFhiXY10HGxKrP8mK+FEYeDXyCPoyxABESz4hrQmY/Hnn+POPFdDhGVhrmwBMX2GoooY
	L1c+k6u2Dokx/YJNY+gFCXTpstXujbocd77U7fp/JGOXgXKyP+McT3szMhX8zZ8AlXbO2Z
	UzRK5WYOXlZCYrmASC0f/HCV/YNHqfAB2UGVjki0Z0yVNPTxYn1CZmEEWES9A439MXWFGs
	V4S/GPB5CagcVMnJ3mL1caFb3SJDQzCwTx4wxXaqHo3QEg7ECyKZ7VK2Sm7YxesmmJcKec
	MPGPXwzJLHSOmKpzgUUzjUJgu94MCiGIA0mk1l3ksaVpEMcMWSk/HPvQhrHW1Q==
Date: Tue, 24 Mar 2026 10:21:44 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 28/35] net: pcs: rzn1-miic: Add per-SoC
 control for MIIC register unlock/lock
Message-ID: <acJXqPomd7I20YO7@duo.ucw.cz>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DeqQWjoq9ii8b5EN"
Content-Disposition: inline
In-Reply-To: <20260316145915.8580-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:21:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22540


--DeqQWjoq9ii8b5EN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

One more nitpick.

> index 765d6ca4e4ca..d8ba1164c886 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -155,6 +155,9 @@ struct miic {
>   * @sw_mode_mask: Switch mode mask
>   * @reset_ids: Reset names array
>   * @reset_count: Number of entries in the reset_ids array
> + * @init_unlock_lock_regs: Flag to indicate if registers need to be unlocked
> + *  before access.
> + * @miic_write: Function pointer to write a value to a MIIC register

I'd expect either all of sentences to have "." at the end, or none of
them.

Best regards,
								Pavel

--DeqQWjoq9ii8b5EN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJXqAAKCRAw5/Bqldv6
8niWAJwJGMU+J8GmAdDlNGIC/XcQpzeeBgCguIuqj57PFAYU2Mmk1uXU0kioPH0=
=N7zu
-----END PGP SIGNATURE-----

--DeqQWjoq9ii8b5EN--

