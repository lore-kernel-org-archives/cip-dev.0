Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF1D116E2
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 22:36:52 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5277.1764369404589033158
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 14:36:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h95/dG0B;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: iwamatsu@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-882390f7952so25716366d6.3
        for <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 14:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764369403; x=1764974203; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYqGlpX3xi2u2IT56vMjxit1e2QG4PJXNqXs162N5NQ=;
        b=h95/dG0B7MJoxbivzRtfc0oQb+kWo7X379ytYQz1Wll+jeEVIjvMa41QEitEotnPH5
         jcWVX5EioVe0YHIfCqNyoIrrLY4Aph9px8kpZnyckllB8hPCxoWlQdN1PV8zjr6zr6kA
         ONAAmemZN8rcomfu6PnRwmXFjmhhTXKbWiezSyd44w7QCxOx7GXG+YkQuezv0US7DEs0
         US97e28iUbSvjWR1aX6S8f2kkItFRh3a7sYhH4AuFJ9xpYbUOB3eH/u7RXMcSmrWuhl2
         67FVrLEPxcLezNdo4UdoykhvOWMZwwp9PY6EZJ3ox2W34ZVFE/ZYqNa43V4wzwOCwLdN
         l6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764369403; x=1764974203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYqGlpX3xi2u2IT56vMjxit1e2QG4PJXNqXs162N5NQ=;
        b=Ccyl99aMfw23cYEs3+eAs4g325LCManNhoBZkBaR09MBs9tK12PrxRS3fYB30mmqWw
         1qG3cG78ycKWrSBWr60bXguY/RnnghA64i+m4wAUzbbAxQkwm5fYd9TG5lPZyuygeLWl
         BbXuuzkW2hltQgAOzxsfiedA4TmODPrp6B8cw7sl1SOa8HxAFh0K4OrDECmhyX0qTS65
         tmnS2SwxHwWv5gk10VlPEtuuE+pQl8EHXqduOKExApC/3MmnNdekFM45c7NYpPqZX5XF
         iKIKYOTPNKucCEoesBmEPfhdfjGCHmp3CE/TZStI2Vl5RhIsjkQcRvgXN49XdrBwNYar
         l8hA==
X-Gm-Message-State: AOJu0YwLD8/z99TFOq1VNL7tLZFk/RdPC/a0Cof2Odu5Rs3QTWbslM8k
	e4N3eIAcTbrgR+Y3bsNcNikfrEMDgHVwysMbNFAGF9ozrfsK5MZHaSf8XlR4/puBwE2QoWXnu+I
	tRKXsdKsHaVRe2EiSxUZmC1xyQHrY0/U=
X-Gm-Gg: ASbGncuSVtYsmJA0jnEi9Vc47/z/5jTc7FGCApXrYXzcI4pW6anUeeKoSPUmLtF28yo
	rTSibkCZshQ8SRSpOPUdjf5ijQ6kvOyPghlRkfzSoHyJTw2sY4bnqZpHRtGa+EiLwHPktSvEe2d
	e71twycU+ji+oeaKxzXEdUgcyFBB+nbV2ZSf8F/c/IJ1/d8ZJrd7NanGK0s+ht8b/Xw58wQRIJG
	fPvGRg/pP3ZNDSqBMWxV30HkNuKHx3hplz9YncCXoWSo8QcJff3WH8blCLaMhnCvUieXdJm2LdW
	cps=
X-Google-Smtp-Source: AGHT+IGsGR7oQwfcNF4Iqm0p94QdplisWM5TQsyeXUtwznpE3pXJattIJxrX3+0GEFT0N0uVLiQznvMXBkfxciq5PH0=
X-Received: by 2002:a05:6214:f0d:b0:880:5a6d:acdd with SMTP id
 6a1803df08f44-8847c4c7f44mr397172066d6.20.1764369403543; Fri, 28 Nov 2025
 14:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20251127113012.55325-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251127113012.55325-1-ovidiu.panait.rb@renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 29 Nov 2025 07:36:32 +0900
X-Gm-Features: AWmQ_bk_JERWxkUUE6hXpkeQn9STVHAUX0vnGSB3-oIcY-5pItbisauQBBA2AMw
Message-ID: <CACe6DC57Z28GLrWP_xOiDm0YPATqi+UWjiugvN+6poZjzwucnQ@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2H DMAC support
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 22:36:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20770

Hi  all,

2025=E5=B9=B411=E6=9C=8827=E6=97=A5(=E6=9C=A8) 20:30 Ovidiu Panait via list=
s.cip-project.org
<ovidiu.panait.rb=3Drenesas.com@lists.cip-project.org>:
>
> Hi,
>
> This series adds DMAC support for the Renesas RZ/V2H SoC.
>
> Patches were cherry-picked from mainline kernel.
>
> Best regards,
> Ovidiu
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
>  drivers/dma/sh/rz-dmac.c                      |  84 ++++++++-
>  drivers/irqchip/irq-renesas-rzv2h.c           |  35 ++++
>  include/linux/irqchip/irq-renesas-rzv2h.h     |  23 +++
>  5 files changed, 382 insertions(+), 27 deletions(-)
>  create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h
>

I reviewed this series, and it looks good to me.
I can apply to this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
   Nobuhiro

--=20
Nobuhiro Iwamatsu

