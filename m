Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA3ECD13CF
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 09:47:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.35128.1725270443713095566
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Sep 2024 02:47:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EAB631C009A; Mon,  2 Sep 2024 11:47:20 +0200 (CEST)
Date: Mon, 2 Sep 2024 11:47:20 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 08/30] media: dt-bindings: Document Renesas
 RZ/G2L CRU block
Message-ID: <ZtWJqOdRxkBkUb9y@duo.ucw.cz>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-9-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="egDdwRtnIGfETPh9"
Content-Disposition: inline
In-Reply-To: <20240805164342.211857-9-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Sep 2024 09:47:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16837


--egDdwRtnIGfETPh9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit a18004173a087573628ddc9910f0665a3829f48f upstream.
>=20
> Document the CRU block found on Renesas RZ/G2L (and alike) SoCs.

>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l=
-cru.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.ya=
ml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> new file mode 100644
> index 000000000000..7dde7967c886
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
=2E..
> +description:
> +  The CRU image processing module is a data conversion module equipped w=
ith pixel
> +  color space conversion, LUT, pixel format conversion, etc. An MIPI CSI=
-2 input and
> +  parallel (including ITU-R BT.656) input are provided as the image sens=
or interface.

input -> inputs?

> +  clocks:
> +    items:
> +      - description: CRU Main clock

Main -> main?

> +      - description: CRU Register access clock

Register -> register?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--egDdwRtnIGfETPh9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZtWJqAAKCRAw5/Bqldv6
8n1JAJ4iV/8ZSNTrdQWgxnVyQBx8fUNncACfRuUmK6xN+3TviV7WfzHoFUIdiPY=
=Fgwp
-----END PGP SIGNATURE-----

--egDdwRtnIGfETPh9--

