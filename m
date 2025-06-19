Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ADDC71155
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 06:16:04 +0000 (UTC)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by mx.groups.io with SMTP id smtpd.web11.3013.1750347831471027961
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 08:43:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=uGSuu7NX;
 spf=pass (domain: kernel.org, ip: 147.75.193.91, mailfrom: conor@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 97E18A54685;
	Thu, 19 Jun 2025 15:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A54C4CEEA;
	Thu, 19 Jun 2025 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347830;
	bh=UbDHYv4/Cb5WoHKg1VJxoa9UngLpiaMmnTd19/PwptM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGSuu7NXaEtJvu48wGI1d0RQhNxurzk/4YoD2OwkgxoNo7+eXq3sFq1lcq0pPZzCc
	 Ux2R6Qm6TPLx/zZAy5ntXvk1dSGgxkQ1EVlaGxMO4KoSfaSLYqBPTj8Qp2qMV8Lbnx
	 +HlO1TboQyfZq3S5NFKiNBAXUEhkNfYLVl0U7/0nE7k44eVr40AGzWjiQumHYNflkG
	 vTQenG5QyoVpqYTtbRETpae3Yv55h3T2fxQ8idikidr4cOadgwrVts7XNwBJU2qh9B
	 4JBuSe8D4SygK6fAkjivtqrt9a+SP6lanBIgLPpkiJkQFnL4+X5MgBgCaLL5FdF27I
	 MJ33Bt9Feucfg==
Date: Thu, 19 Jun 2025 16:43:46 +0100
From: Conor Dooley <conor@kernel.org>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: cip-dev@lists.cip-project.org, drm@lists.freedesktop.org,
	devicetree@vger.kernel.org, noralf@tronnes.org, robh+dt@kernel.org,
	krzk@kernel.org, onlywig@gmail.com
Subject: Re: [PATCH 3/3] dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel
Message-ID: <20250619-earlobe-skiing-25605816a861@spud>
References: <20250618033731.171812-1-zaq14760@gmail.com>
 <20250618033731.171812-4-zaq14760@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250618033731.171812-4-zaq14760@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QN4uNdCU9WfwuFc9"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 06:16:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19148

--QN4uNdCU9WfwuFc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 11:37:31AM +0800, LiangCheng Wang wrote:
> The binding is for the MAYQUEEN PIXPAPER e-ink display panel,
> controlled via an SPI interface.
>=20
> Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> ---
>  .../bindings/display/mayqueen,pixpaper.yaml   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mayqueen,pi=
xpaper.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.=
yaml b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
> new file mode 100644
> index 000000000..f7c33957e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mayqueen,pixpaper.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAYQUEEN PIXPAPER e-ink display panel
> +
> +maintainers:
> +  - LC Wang <zaq14760@gmail.com>
> +
> +description: |
> +  The PIXPAPER is an e-ink display panel controlled via an SPI interface.
> +  The panel has a resolution of 122x250 pixels and requires GPIO pins for
> +  reset, busy, and data/command control.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: mayqueen,pixpaper
> +
> +  reg:
> +    maxItems: 1
> +    description: SPI chip select number for the device.
> +
> +  spi-max-frequency:
> +    default: 1000000
> +    description: Maximum SPI clock frequency in Hz.

Does this actually not have a max?
The display surely has a maximum supported frequency, which might be
lowered based on the board it is connected to.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO for the panel reset pin.
> +
> +  busy-gpios:
> +    maxItems: 1
> +    description: GPIO for the panel busy pin.
> +
> +  dc-gpios:
> +    maxItems: 1
> +    description: GPIO for the data/command pin.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - busy-gpios
> +  - dc-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        display@0 {
> +            compatible =3D "mayqueen,pixpaper";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            reset-gpios =3D <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +            busy-gpios =3D <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +            dc-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> --=20
> 2.34.1
>=20
>=20

--QN4uNdCU9WfwuFc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFQwMgAKCRB4tDGHoIJi
0nzdAQDQF27g4xVuG40BdEuZhLCUiWhBPHYBn8EQEm95V/OXPgEA2EOdbu3YDyPo
pV7ouU6xHIaC8fClsUQI5hIMcom12AI=
=D9VV
-----END PGP SIGNATURE-----

--QN4uNdCU9WfwuFc9--

