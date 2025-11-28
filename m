Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39755D116EA
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 22:35:52 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5261.1764369341962215912
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 14:35:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A7bMmR//;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso27307951cf.0
        for <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 14:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764369341; x=1764974141; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhZSaXpXJ6NGWggDIkwq0XEskStawd2h75U2LWY5uus=;
        b=A7bMmR//IJiFfRS1NdmGnCcO1u9KvfXaKPRTmR/NN+plMgRDpz4RGi8z0ysnWB/ViJ
         Psf9K4lj0ys6isbxcGzVEAPobkCuz9TlS2zSTkOq8Ylnzbjf3arIy5bg0WS9fxLDYvgm
         qa5MCupQp1ZWRs1vZ1c3XRUrTI843UKNpNr8NNN2mA/Vro17UuXgnVpgfNcCEiQd+qFZ
         H6T9evyFfAAx6slcAZx5bPRKbq+aZgFec9UpGRy/y+tA1HFyz2o9rDqhTXtsqfAsXvHt
         IKM/XefGQoDG7XDF1F5gmc6pMeIIfeQ75E1aZ0Az38df0Jitp5pfyKEvLTARA/trJfKF
         IwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764369341; x=1764974141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhZSaXpXJ6NGWggDIkwq0XEskStawd2h75U2LWY5uus=;
        b=GyQzT2tERpr87mumpE4dYHStG45bAla8jl7yH3zQEIBGrSS+aDXonQyP7a56zTau76
         Pn2X0yOkpLrrySuDVHBAVhXNdLipFaHZg0CNfm4aoGUCKsRUAtCCzUoeEMj8YMxEx57y
         JPHlyE0amtCuPOGd4ajZ4Gvy/HGAFtWXzV/RTIbEvFX3+HZuOsliU/W4AvnXtds6GP0h
         94TqX9ubdITVnpVvonhoKvNCvNfMyCEJqY2UVRMhRni4mRsYbJVdXgpRkViOuddvZu24
         zsfSXM0m+GkqCpLYkwoT8kFPfM4ztVIKHMl2M9qDsTLXU8/YPYb1mRE6m1rtHUjwKY/P
         fo0w==
X-Gm-Message-State: AOJu0YzQ7YwSl6qbZ4mtdyp/S81hf+sgOM8evzlxdKoMavNsI86+LDq1
	dflxTL17Bqo1yNRaRDtclDwtB6tbYmxBaxqdDqTZu52I8Qo0mqMvpmDcmkt3oKBl3jnazj/pX34
	hRumEsyN6pf1/bkZ/CftVHLSHsUKG1T0xT4Lycinypw==
X-Gm-Gg: ASbGncsiAdFBj3G6BYCsxhqmFQgIy5spcqzRR7NJfhi6Fcdb9wFb2q8hbd2DcxFjE8G
	jOZj/9+iB6N85twqaXRHwlczqkHrzntDV2T3GrvuXzAVnON4SeRtFS4yFQdqOlKc3P+LfudtPbB
	+FE1btgg13FoLpmlX6j0/zBZObiXUbS3VXcjHJtyN/4rbmymI5KkhI2rKi8PkGEg6D+GzAwTw6z
	gHfx5ZfyMD6YFBK+7pZ/6NUfpwECwpSIYTlXuSjMXAMrwfBrLxIP1aS3rU4RKI54C18
X-Google-Smtp-Source: AGHT+IExu14w8CyuXS37rQNmafsGdopoq+apApAJpFyegE0e1RD9EcU+HS0BeU64y0nW5HohliFQfEyINufyd0+Hr9Y=
X-Received: by 2002:a05:622a:1107:b0:4ee:d6:7a51 with SMTP id
 d75a77b69052e-4efbd915b6bmr265011201cf.12.1764369340967; Fri, 28 Nov 2025
 14:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 29 Nov 2025 07:35:29 +0900
X-Gm-Features: AWmQ_bmfYRnFm7YDIua0KquogGAfe23bDHD2n2e2LHucsbNcTza5mH0dIiYZBaw
Message-ID: <CACe6DC4HpsHngXRgjpt+MmR1Qi211fgDWv=+3vx7n9d9EXq=6Q@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 22:35:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20769

Hi all,

2025=E5=B9=B411=E6=9C=8827=E6=97=A5(=E6=9C=A8) 20:29 Ovidiu Panait via list=
s.cip-project.org
<ovidiu.panait.rb=3Drenesas.com@lists.cip-project.org>:
>
> Hi,
>
> This series adds DMAC support for the Renesas RZ/V2H SoC.
>
> Upstream commit 1b86d3ecde5c ("dmaengine: dmatest: prevent using swiotlb
> buffer with nobounce parameter") was cherry-picked to allow dmatest to
> validate DMA controller functionality with and without swiotlb. The
> remaining patches add the actual support for the RZ/V2H DMAC.
>
> Patches were cherry-picked from mainline kernel.
>
> Best regards,
> Ovidiu
>
> Amelie Delaunay (1):
>   dmaengine: dmatest: prevent using swiotlb buffer with nobounce
>     parameter
>
> Fabrizio Castro (5):
>   dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
>   irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req()
>   dmaengine: sh: rz-dmac: Allow for multiple DMACs
>   dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
>   arm64: dts: renesas: r9a09g057: Add DMAC nodes
>
>  .../bindings/dma/renesas,rz-dmac.yaml         | 102 +++++++++--
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 165 ++++++++++++++++++
>  drivers/dma/dmatest.c                         |  17 +-
>  drivers/dma/sh/rz-dmac.c                      |  84 ++++++++-
>  drivers/irqchip/irq-renesas-rzv2h.c           |  35 ++++
>  include/linux/irqchip/irq-renesas-rzv2h.h     |  23 +++
>  6 files changed, 398 insertions(+), 28 deletions(-)
>  create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h

I reviewed this series, looks good to me.
I can apply this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
   Nobuhiro

--=20
Nobuhiro Iwamatsu

