Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9907FC3DA64
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 07:56:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.38133.1722412598236640135
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 00:56:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9DEEE1C0082; Wed, 31 Jul 2024 09:56:36 +0200 (CEST)
Date: Wed, 31 Jul 2024 09:56:36 +0200
From: Pavel Machek <pavel@denx.de>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y cip 7/8] net: ravb: Use NAPI threaded mode on
 1-core CPUs with GbEth IP
Message-ID: <ZqnuNFDSL1FHkydY@duo.ucw.cz>
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
 <20240729150049.1924352-8-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80LMwF0x2FFkD8pw"
Content-Disposition: inline
In-Reply-To: <20240729150049.1924352-8-paul.barker.ct@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 07:56:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16691


--80LMwF0x2FFkD8pw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> NAPI Threaded mode (along with the previously enabled SW IRQ Coalescing)
> is required to improve network stack performance for single core SoCs
> using the GbEth IP (currently the RZ/G2L SoC family and the RZ/G3S SoC).
>=20
> This patch gives the following improvements during testing with iperf3.
>=20
>   * RZ/G2UL:
>     * TCP TX: +32% bandwidth (638Mbps -> 841Mbps)
>     * TXP RX: +8.8% bandwidth (667Mbps -> 726Mbps)
>     * UDP RX: +104% bandwidth (53Mbps -> 108Mbps)
>=20
>   * RZ/G3S:
>     * TCP TX: 29% bandwidth (529Mbps -> 681Mbps)
>     * UDP RX: +1290% bandwidth (6.46Mbps -> 90Mbps)
>=20
>   * RZ/Five:
>     * UDP RX: Test no longer crashes (0 -> 20 Mbps)

I believe you'll really need to get the test to work in both
configurations as you still allow user to select.

> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2953,8 +2953,11 @@ static int ravb_probe(struct platform_device *pdev)
>  	if (info->nc_queues)
>  		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
> =20
> -	if (info->coalesce_irqs)
> +	if (info->coalesce_irqs) {
>  		netdev_sw_irq_coalesce_default_on(ndev);
> +		if (num_present_cpus() =3D=3D 1)
> +			dev_set_threaded(ndev, true);
> +	}
> =20

And as this heuristic is not really reliable. Users can offline CPUs,
for example, so you can have machine with num_present_cpus() =3D=3D 2 but
only single CPU online. I'm running in similar configuration on my
notebook at the moment.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--80LMwF0x2FFkD8pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqnuNAAKCRAw5/Bqldv6
8oU4AJ9ndBxfTIOtp0MQqBN06ssghrrZEQCbBkAbapgrnjZ3pcd+vi5b6TdY4K4=
=aEO9
-----END PGP SIGNATURE-----

--80LMwF0x2FFkD8pw--

