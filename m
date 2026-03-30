Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C73FB3D02
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 10:28:59 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47810.1774866528326672172
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Mar 2026 03:28:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Fo7VVgbB;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C459111D7C;
	Mon, 30 Mar 2026 12:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774866526;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zGC5f118XBcq7Pmzk4Q9n68ToqglIg2hO32s5n3wP7U=;
	b=Fo7VVgbB4gGq9yZXz5rXYn5GJYcWcPvekPk/cVEl/FlXcqtODE98ARkCiND8t2lVvmz2ya
	Jite3op6A2druWKLFEjeuALTy4VH+l6NmEiryjDDxxnutqu3PAItUp33NjZj67HFSxCVFa
	rmB3hVsW17kN0L/6cc8auCMu5fvGfuxREmc4soeRHXB/H/nHf+UPYiNkGbFDot1Xr2mX+L
	nyspMM4rVQiQn8+E7nitHP41+8FCgm4EPSCj8ycvysctJQtjRD2RxlFFwGGN5wIVoeT2EK
	soZ5nDchkwRPvaCE+tpLLLghhYEhil3mVxI9RejLvhYGdS+KN2X/zYwa3NrCyg==
Date: Mon, 30 Mar 2026 12:28:44 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoCs
Message-ID: <acpQXIzit4oEPTT8@duo.ucw.cz>
References: <20260327095327.36412-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7K9FOhHT70IKuLZh"
Content-Disposition: inline
In-Reply-To: <20260327095327.36412-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Mar 2026 10:28:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22605


--7K9FOhHT70IKuLZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add CANFD support on the Renesas
> RZ/V2H and RZ/V2N SoCs. CANFD has been tested with external
> CAN PHY transceiver as the EVK isn't fitted with one.
>=20
> Note,
> - All the patches have been cherry-picked from upstream
>   kernel.
> - Patches apply cleanly on top of commit-id 1ea90e3298a62
>   of linux-6.1.y-cip branch

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--7K9FOhHT70IKuLZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacpQXAAKCRAw5/Bqldv6
8iI4AJ0cif8U8asV78idudIVN6Szuey5gACgoI9natXRVj9PnKLrNMPerDvcYOM=
=o+DZ
-----END PGP SIGNATURE-----

--7K9FOhHT70IKuLZh--

