Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0FC71141
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.18950.1650529974154516102
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 01:32:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B0A9F1C0B87; Thu, 21 Apr 2022 10:32:49 +0200 (CEST)
Date: Thu, 21 Apr 2022 10:32:48 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 03/24] ASoC: dt-bindings: renesas,rz-ssi:
 Update slave dma channel configuration parameter
Message-ID: <20220421083248.GA3269@amd>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20220420213424.27837-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8154


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>  .../bindings/sound/renesas,rz-ssi.yaml        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml =
b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> index 471937cb8d05..414ff8035a4e 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> +++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> @@ -48,6 +48,24 @@ properties:
>    dmas:
>      minItems: 1
>      maxItems: 2
> +    description:
> +      The first cell represents a phandle to dmac

I would not mind . at the end of the sentence, to be consistent with
the next paragraph, but that's really a nitpicking.

> +      The second cell specifies the encoded MID/RID values of the SSI po=
rt
> +      connected to the DMA client and the slave channel configuration
> +      parameters.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJhFrAACgkQMOfwapXb+vKjZwCeLPmA2kBveAJBxhmvtLJ9BK/S
xNEAn0/otsXskPhBF1xo4w8yffT+6ROu
=/LM6
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

