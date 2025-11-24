Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC89ECFD2F6
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 00:08:23 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5405.1763942900506234669
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Nov 2025 16:08:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BhiFIo8B;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso51792371cf.0
        for <cip-dev@lists.cip-project.org>; Sun, 23 Nov 2025 16:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763942899; x=1764547699; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxoTtZn1mmD7NAQef6nA/+nih7UW4ke2oHjAE9g0qU8=;
        b=BhiFIo8B+gU4Sq6hVS/folvGhmJgqAipwMjXRSI1jrpOzcA1CrBHsZT4Ni0LJ//Qai
         R+FOjs8mLxPww8t1JF8QNJ0xb3Gif3yNO0nx6op/Y3yMEn+bRCIvpM7wV96BIcDlzs8X
         9Gp5k1DLHqTLWYqnMF5hfR0O2zIhCuqQiDUta0BOfp+7+ib/c7li3x1YgQgZsuvRnVCT
         TeKiPhttpNJCrhB9Vz4bSTjIkIo0N4AZBNmIjOjy2B09engzasarzv16Vxu/S1od+M23
         EnafE/hHfKil52FFzYTnYu4J1XR0rSfcWvplTgGvHqhm0xlSwsdX5prcT/c4d7PdUBgT
         1TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763942899; x=1764547699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxoTtZn1mmD7NAQef6nA/+nih7UW4ke2oHjAE9g0qU8=;
        b=kRowNgLe9yTYNut7Ql5SCEbOsSwQNR6E1Cl4UaVpatbdcbuob/o/grQldB6eCVGf6F
         dIyOXncbKQidIatj9jCQaIEqPCuQuNejZDfSrRslJyYt6ivr0oUCDfOnTpdAOLD8MoCF
         T+dOogk9KSYc199REiSfvBIRqEpUmfXfRb5FvjDIu3Kiy2UnRao9awEXsw+NrjOQv8aQ
         Zal2YDDRyZR+OXnL7e4/WoajaGULXVqSowbpNRqZk7663xhN0F3U5ZlT2kxtYi3xTNnr
         VtTiAg74wwc2l0a8KJxK0ZuXPtebPQiwoMxE0UUmF7dfZvts5FY0BNrWXLScmkSo2j9k
         yttg==
X-Gm-Message-State: AOJu0YzMPzgC8S2eM6K/oUC3X01zaZC2xKrlSeeUL/wazXdMkZI0JHT9
	69EMNnUv2y5wka1+TTozBgXkkgIJ3UZGTMaIh1MQUEV3JKiAPSgYeZVveVnDKMRM2xMXX1SPHwc
	SGWHvPpv8SE8Onho/NTsoVXUdFLPP/uWPMZAC2jsxxA==
X-Gm-Gg: ASbGncvE6eV+ApAMcRv4qHtklvwi8QsmlW2jmGmDXvgavJ06JndbEGNaA073M7eqZGh
	toLzfA3iVpEe1GMd0dcnGD1hqG3YaK91bdLsvMo8rLMgwpqsZsU9AeYwGg38xJUdoHzkKrEKyId
	/tz65KoJP/sjlh3WrcYWGUHPthGD5s+KEO/Xw2s69BVVgrpEsFxIndzzi37CkXmaSuQ7esnCScL
	nPKeDp3ZTNBhvABmpZ0nbqfr0yAkBtGI8H4JYOPUifufe6qbKERZ4wuUbrbuS5J9/C5
X-Google-Smtp-Source: AGHT+IE1yPou8KK3y9LAAN+OMg/3O+uMgBGZHVEtBVPKeCUBN8xETu/9fyOAXY7RNvhbZc7+Q1PFR6+Ykum1OTo4UA0=
X-Received: by 2002:ac8:7d4e:0:b0:4e8:aa11:5869 with SMTP id
 d75a77b69052e-4ee58924bbemr117904891cf.70.1763942899477; Sun, 23 Nov 2025
 16:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Mon, 24 Nov 2025 09:08:08 +0900
X-Gm-Features: AWmQ_bmF05m39zhOk1QCLFxsHHvWEIqIGYYT54R8KXKjJkGB5hR5v10035fna1E
Message-ID: <CACe6DC6LKK9Pc0Xa1H5gMYO_xhwpeyg2x39Sau0tgHKPpHX3Tg@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/9] Add RZ/V2H USB2.0 support
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, 
	nobuhiro1.iwamatsu@toshiba.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 00:08:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20698

Hi all,

2025=E5=B9=B411=E6=9C=8821=E6=97=A5(=E9=87=91) 1:57 Ovidiu Panait via lists=
.cip-project.org
<ovidiu.panait.rb=3Drenesas.com@lists.cip-project.org>:
>
> Hi,
>
> This series adds USB2.0 support for the Renesas RZ/V2H SoC.
>
> Patches were cherry-picked from mainline kernel.
>
> Best regards,
> Ovidiu
>
> Lad Prabhakar (9):
>   dt-bindings: usb: renesas,usbhs: Add RZ/V2H(P) SoC support
>   dt-bindings: reset: Document RZ/V2H(P) USB2PHY reset
>   reset: Add USB2PHY port reset driver for Renesas RZ/V2H(P)
>   dt-bindings: phy: renesas,usb2-phy: Add clock constraint for RZ/G2L
>     family
>   dt-bindings: phy: renesas,usb2-phy: Document RZ/V2H(P) SoC
>   phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/V2H(P)
>   arm64: dts: renesas: r9a09g057: Add USB2.0 support
>   arm64: defconfig: Enable RZ/V2H(P) USB2 PHY controller reset driver
>   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB2.0 support
>
>  .../bindings/phy/renesas,usb2-phy.yaml        |  11 +-
>  .../reset/renesas,rzv2h-usb2phy-reset.yaml    |  56 ++++
>  .../bindings/usb/renesas,usbhs.yaml           |   6 +-
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 113 ++++++++
>  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  65 +++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  30 ++
>  drivers/reset/Kconfig                         |   7 +
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-rzv2h-usb2phy.c           | 270 ++++++++++++++++++
>  10 files changed, 554 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/renesas,rzv2h=
-usb2phy-reset.yaml
>  create mode 100644 drivers/reset/reset-rzv2h-usb2phy.c
>

Looks good to me,  I can apply this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu

