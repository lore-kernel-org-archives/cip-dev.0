Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635B9C35FFF
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:20:20 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.4438.1742379615583819071
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:20:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Fxc1UPdY;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D1DE101E91D5;
	Wed, 19 Mar 2025 11:20:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742379613; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1PYT9c3f89M8rsrQ9HjUlOX8DyByqhblQ32vYY3Qfcg=;
	b=Fxc1UPdYs5ulYkrt78/e7EAG6VYqCGAYARiX/q2UkwkuHWfbggYBbi85gkTFKitckD6cT0
	o+njMc1U571+ngBxpooSorP49ajcm33mwKorcMD1oHtHTfiV+exziko2C3vz8WdJggxMdn
	PJsHTYlydVrh4tJZ0x7bAJ5Sd0pUr+nuhI4bxbhYi8K9/Mu9wwCn5JTUppFGt4UCcHQPZf
	w+Tpet8YSyfrnb+8of3ef5ikaN9fgx2BYY4stNxDErDEQuloFd++u5MiroOsUPXoL72/QW
	lzEZj73YgPVMqndfskeaqzHj2NdbbsC7MT6VUO2lhhNDE9YdtQI1xsyJD5W3fg==
Date: Wed, 19 Mar 2025 11:20:06 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 06/12] serial: sh-sci: describe locking
 requirements for invalidating RXDMA
Message-ID: <Z9qaVlIje4J2ZcWh@duo.ucw.cz>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
 <20250319094754.2404386-7-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mjLZwsJV+ov2wDoy"
Content-Disposition: inline
In-Reply-To: <20250319094754.2404386-7-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:20:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18274


--mjLZwsJV+ov2wDoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> commit 8efc440549087de41abadf62f4bde1d827135338 upstream.
>=20
> Make sure everyone knows that calling this function needs protection.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Link: https://lore.kernel.org/r/20240506114016.30498-8-wsa+renesas@sang-e=
ngineering.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/sh-sci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 69f8ac561513..7c93c9a1079b 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1264,6 +1264,7 @@ static int sci_dma_rx_find_active(struct sci_port *=
s)
>  	return -1;
>  }
> =20
> +/* Must only be called with uart_port_lock taken */
>  static void sci_dma_rx_chan_invalidate(struct sci_port *s)
>  {
>  	unsigned int i;

Instead of comment, would lockdep_assert(...) be better / more robust
way to accomplish this?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mjLZwsJV+ov2wDoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9qaVgAKCRAw5/Bqldv6
8ojTAJ4lijHVr2fX3qem9ttn0iS0J2jc8ACfX6lMoBF9U99vRNnoATTGsWDDkPc=
=Vcvn
-----END PGP SIGNATURE-----

--mjLZwsJV+ov2wDoy--

