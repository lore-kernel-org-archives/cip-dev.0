Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0617BCFD2F6
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 00:07:54 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5186.1763942869835874866
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Nov 2025 16:07:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ae+N76fp;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee2014c228so30919111cf.2
        for <cip-dev@lists.cip-project.org>; Sun, 23 Nov 2025 16:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763942869; x=1764547669; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HuqLMZSnPP248XqKG+AC41N/HVnBHW41r2TXGtCpI0=;
        b=Ae+N76fpaBy48cO811VwyetW2vtyR3ytfO0kIuL34maRAsqTeza2JQ+Lmdj9BSsXtx
         5AgnAPkesDZS/xCuc9XkpMFf22PT0p3/NJsIvqrhxG7QRlXEYdeLQRDxEj8A9oCl/Gi8
         dl31tLHsPXWBHPAfiXm0VZPbFnddLQ0ya9JzJHs54OrSco1KMS+bXJ0J2MHCQng49gbQ
         938IFowvIl2lvFRCGsEFG0GDqPtRGf7YGZ6jbUrkJguhZiRpJ/YL6HeX490HwAe8Bd03
         xUqUiLuTzNuAqySj8t0I2VJPXe9VlVgjCrtKbzKfP3RZEBp5gKNvOvRRyucqqJHlUGPI
         TdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763942869; x=1764547669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HuqLMZSnPP248XqKG+AC41N/HVnBHW41r2TXGtCpI0=;
        b=hMaWiwt6/SAiBd/dkml682BCYI2cqEfk3Y7w/3hXIbcB+j5xYtACnljx83OFHT1MSa
         ihCL1FA6l8EBdW2e3z7jc66P6OQMt/wr8Tpzh7sCiEcI6Y5hPuA6FbBd4AK8xtyW8Wi3
         Jwf4bhV5hp9ext/O4bGJut9tMS59m5CuJs/YMhP6/WehRkS8Hf6PPUfOy2U6MP0lWkvv
         W4QtPGCXsC370frHLIwW762UWvVeisdivvYK18kZJIGP4z/+3nNzOUgvj1S3F3mRWLBe
         NWwmkvz9Y0eoWY6mF1sHbYcPvVYcQXfhFUvOM6WZTl8zWEyONa87dRjDn4yRvODlOOV4
         AyVw==
X-Gm-Message-State: AOJu0Yw7WZNwuubycsAtXg5cGJZiSFe54jJClQmjjAj1mgEARLOfHISE
	TUG5UdJpGZrMoZP3Odu/fm/MnpjfydqxfhDg9GM0GiCwZYbNiK94xOwFvGghJUHmEr8b0++3xXC
	Ox/oDveNCYx61Jw//dOdICGOfllxFZGk=
X-Gm-Gg: ASbGncvevjnsTSr/OgPUcMiqVTVP1Rf4VNpoJhqfzxrmEUyrv9cqCmDxXhjP9Y686VC
	xiSR3AbT5CX11TE9xD1pGCbzGhMcGAsjVOSBQjazbmL6AY3xjOEy7ktJUC7WlAj91b8VHoRU3Uh
	A5830SofqEzWSUdO94dAtXsJ5EOwOdKJKSsdT4Pr5i99dEMzg51JE8dR5ubd2NAyoHaNtUuIufE
	rOye7r8/aCZWReBtFoV3aA6yfQDATl86cUEOlZq8HA2Bdbb0NVXQrH8viAMyHeQxKOf
X-Google-Smtp-Source: AGHT+IF7ZDOJvsaSsWNhW64xLVbocCZ6h8SVmhhqJxYYyx0ntqLkrMdrW9r8H8M5c8M6RRqCYiwDh2eSmQnbTdFnLcc=
X-Received: by 2002:ac8:57cd:0:b0:4ee:1527:cae0 with SMTP id
 d75a77b69052e-4ee58751c79mr150129401cf.0.1763942868776; Sun, 23 Nov 2025
 16:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Mon, 24 Nov 2025 09:07:37 +0900
X-Gm-Features: AWmQ_bm0z81teUDme1nKV3-sAFlzTrIztX221JLLQtULZ60711jSapQ5ymbFox8
Message-ID: <CACe6DC4YQQfySU-Cy81aEBN42L7hp+Ff0JvmhJctsWvg4xE0Hw@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H XSPI support
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 00:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20697

Hi all,

2025=E5=B9=B411=E6=9C=8821=E6=97=A5(=E9=87=91) 17:06 Ovidiu Panait via list=
s.cip-project.org
<ovidiu.panait.rb=3Drenesas.com@lists.cip-project.org>:
>
> Hi,
>
> This series adds XSPI support for the Renesas RZ/V2H SoC and enables the
> MT25QU512ABB8E12 flash device used on the RZ/V2H EVK board.
>
> Patches were cherry-picked from mainline kernel.
>
> Best regards,
> Ovidiu
>
> Lad Prabhakar (6):
>   dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
>   clk: renesas: r9a09g057: Add support for xspi mux and divider
>   clk: renesas: r9a09g057: Add XSPI clock/reset
>   dt-bindings: memory: renesas,rzg3e-xspi: Document RZ/V2H(P) and RZ/V2N
>     support
>   arm64: dts: renesas: r9a09g057: Add XSPI node
>   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable serial NOR FLASH
>
>  .../renesas,rzg3e-xspi.yaml                   |  9 ++-
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 21 +++++++
>  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 55 +++++++++++++++++++
>  drivers/clk/renesas/r9a09g057-cpg.c           | 39 +++++++++++--
>  drivers/clk/renesas/rzv2h-cpg.h               |  2 +
>  .../dt-bindings/clock/renesas,r9a09g057-cpg.h |  1 +
>  6 files changed, 122 insertions(+), 5 deletions(-)
>

Looks good to me,  I can apply this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro
--=20
Nobuhiro Iwamatsu

