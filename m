Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AEDC54E60
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 21:09:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4245.1710450546359919496
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 14:09:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D06771C007B; Thu, 14 Mar 2024 22:09:02 +0100 (CET)
Date: Thu, 14 Mar 2024 22:09:02 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 4.19.y-cip 1/9] memory: renesas-rpc-if: fix possible NULL
 pointer dereference of resource
Message-ID: <ZfNnbopvuNjTQNfC@duo.ucw.cz>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240314192950.27343-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opn+IqN5k8dVqzjR"
Content-Disposition: inline
In-Reply-To: <20240314192950.27343-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 21:09:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15320


--opn+IqN5k8dVqzjR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>=20
> commit 59e27d7c94aa02da039b000d33c304c179395801 upstream.
>=20
> The platform_get_resource_byname() can return NULL which would be
> immediately dereferenced by resource_size().  Instead dereference it
> after validating the resource.

This claims to fix a bug, but it really does not. 4/9 adds a return
and that fixes the bug. I guess there's nothing that can or should be
done about it at this point.

Best regards,
								Pavel

> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -192,10 +192,10 @@ int rpcif_sw_init(struct rpcif *rpc, struct device =
*dev)
>  	}
> =20
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
> -	rpc->size =3D resource_size(res);
>  	rpc->dirmap =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rpc->dirmap))
>  		rpc->dirmap =3D NULL;
> +	rpc->size =3D resource_size(res);
> =20
>  	rpc->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
>  	if (IS_ERR(rpc->rstc))

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--opn+IqN5k8dVqzjR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfNnbgAKCRAw5/Bqldv6
8nXXAKCib4MRVqxkVCC/Va9dlqnvBd9n5wCggRS9QSAzdAd+LghTtUxLsh24jqM=
=yuUE
-----END PGP SIGNATURE-----

--opn+IqN5k8dVqzjR--

