Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685D0C761AE
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:13:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.web11.482.1750227223013603313
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 23:13:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=EtgWsDgr;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: krzk@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5EEA14A7A8;
	Wed, 18 Jun 2025 06:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F10C4CEE7;
	Wed, 18 Jun 2025 06:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750227222;
	bh=wJQDPPQJetS4I1Aeo7+LVEsKKXqK6ABtx+3C+TzKErI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EtgWsDgr2wXdqXmImNsunifsLSxtCatEBORnG7d9QydIbP74GwbHkNGgESDGIBpMI
	 TFyeR0u4SdMAzAklV2ZBB7gGLLWJVSOBXzHtJ+nyuMZL8GbK6z6emec0uGK0oFjQ97
	 LvTgPYs1+hZn+Xc3P9x4Qmlde4pxSdHAJ86QOqBvDpQKF84vUKKIdsNJdF2PqKX0S7
	 HS+OCKIe/0PcKUphfaMLbzF775tmFu1Mi3uBiMj60wLHfyNXo8OeysWzXitDZTtv3d
	 5fstH1ww9NWhCSb4y/LKdSnK/F0naKU74WdML+5h1U46LH6RC9S47XfX/n53uKRo2i
	 /kT+3ZNoo3jEg==
Message-ID: <76b20182-a3b2-4906-85e5-8db524d0811a@kernel.org>
Date: Wed, 18 Jun 2025 08:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel
To: LiangCheng Wang <zaq14760@gmail.com>, cip-dev@lists.cip-project.org
Cc: drm@lists.freedesktop.org, devicetree@vger.kernel.org,
 noralf@tronnes.org, robh+dt@kernel.org, onlywig@gmail.com
References: <20250618034936.172150-1-zaq14760@gmail.com>
 <20250618034936.172150-4-zaq14760@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250618034936.172150-4-zaq14760@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 09:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19131

On 18/06/2025 05:49, LiangCheng Wang wrote:
> The binding is for the MAYQUEEN PIXPAPER e-ink display panel,
> controlled via an SPI interface.
> 
> Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> ---
>  .../bindings/display/mayqueen,pixpaper.yaml   | 67 +++++++++++++++++++

Don't send multiple patches but version them correctly.

>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
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

Don't capitalize all letters. Mayqueen Pixpaper or whatever it is really
called.

> +
> +maintainers:
> +  - LC Wang <zaq14760@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

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

Drop description

> +
> +  spi-max-frequency:
> +    default: 1000000
> +    description: Maximum SPI clock frequency in Hz.

Drop description


> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO for the panel reset pin.

Drop description


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

unevaluatedProperties instead



Best regards,
Krzysztof

