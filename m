Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C215C433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 10:55:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.62981.1640861712752965058
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 02:55:13 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 627931C0B77; Thu, 30 Dec 2021 11:55:08 +0100 (CET)
Date: Thu, 30 Dec 2021 11:55:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 04/31] ASoC: dt-bindings: renesas,rz-ssi:
 Update slave dma channel configuration parameter
Message-ID: <20211230105507.GA9799@amd>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20211229101530.22783-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 10:55:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7311


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit bed0b1c1e88a27b76c74584128cadebc6fa58622 upstream.
>=20
> The DMAC on RZ/G2L has specific slave channel configuration
> parameters for SSI.
> This patch updates the dmas description and example node to include
> the encoded slave channel configuration.

> +++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> @@ -48,6 +48,24 @@ properties:
>    dmas:
>      minItems: 1
>      maxItems: 2
> +    description:
> +      The first cell represents a phandle to dmac
> +      The second cell specifies the encoded MID/RID values of the SSI po=
rt
> +      connected to the DMA client and the slave channel configuration
> +      parameters.
> +      bits[0:9]   - Specifies MID/RID value of a SSI channel as below
> +                    MID/RID value of SSI rx0 =3D 0x256
> +                    MID/RID value of SSI tx0 =3D 0x255
> +                    MID/RID value of SSI rx1 =3D 0x25a
> +                    MID/RID value of SSI tx1 =3D 0x259
> +                    MID/RID value of SSI rt2 =3D 0x25f
> +                    MID/RID value of SSI rx3 =3D 0x262
> +                    MID/RID value of SSI tx3 =3D 0x261
> +      bit[10]     - HIEN =3D 1, Detects a request in response to the ris=
ing edge
> +                    of the signal
> +      bit[11]     - LVL =3D 0, Detects based on the edge
> +      bits[12:14] - AM =3D 2, Bus cycle mode
> +      bit[15]     - TM =3D 0, Single transfer mode

I wish there was better solution to this. Device tree sources are
quite human-readable, this really is not.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHNkAsACgkQMOfwapXb+vLHtwCfZm+WF3E7OZ3g4L9vS4ZU41VY
poIAn387pzUenRjHjJ2dX3e6kjllerF6
=Hhy5
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

