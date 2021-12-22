Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796CDC433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 10:05:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.17501.1640167498802893668
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 02:04:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2E3EC1C0B7C; Wed, 22 Dec 2021 11:04:54 +0100 (CET)
Date: Wed, 22 Dec 2021 11:04:53 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 20/22] dmaengine: sh: make array ds_lut static
Message-ID: <20211222100453.GD15186@amd>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220133139.21624-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <20211220133139.21624-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 10:05:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7227


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 4c0eee50658746b0333d35a75d3db6e0aac08ef9 upstream.
>=20
> Don't populate the read-only array ds_lut on the stack but instead it
> static. Also makes the object code smaller by 163 bytes:
>=20
> Before:
>    text    data     bss     dec     hex filename
>   23508    4796       0   28304    6e90 ./drivers/dma/sh/rz-dmac.o
>=20
> After:
>    text    data     bss     dec     hex filename
>   23281    4860       0   28141    6ded ./drivers/dma/sh/rz-dmac.o

Heh.

> @@ -574,7 +574,7 @@ static void rz_dmac_issue_pending(struct dma_chan *ch=
an)
>  static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth ds)
>  {
>  	u8 i;
> -	const enum dma_slave_buswidth ds_lut[] =3D {
> +	static const enum dma_slave_buswidth ds_lut[] =3D {
>  		DMA_SLAVE_BUSWIDTH_1_BYTE,
>  		DMA_SLAVE_BUSWIDTH_2_BYTES,
>  		DMA_SLAVE_BUSWIDTH_4_BYTES,

Array could be avoided altogether; you could check for power of two
and then count bits. That would give even shorter code, but I'm not
sure about readability.

I'd also not mind using usual convention here: return int, >=3D 0
success, < 0 errno.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHC+EUACgkQMOfwapXb+vJvZACaAhpn4fz8aF0sVezNQVnRTh6c
0lQAoKcmy/9mwOU8+bFntYdPQ7iJVrO0
=QbIg
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

