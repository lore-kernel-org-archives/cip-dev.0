Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3644EC01CC
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 11:05:51 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14666.1774263941240307763
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2026 04:05:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=adYwuf/F;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b45bb7548so2908413f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774263939; x=1774868739; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEgk8GSQEsn3SVpxN+cX+X4If2GOWS5cIolLFwIFJFU=;
        b=adYwuf/Fskc9lFbxGp3wiFAeziY/gYQDf7TD/fy+37gKUbxQoViwoZWRlH4IvwNJfW
         AUjq+UK2oLS3SyvLTMeZF7adfXi1md25LsPppbyuUkDMoVmaOySo6dHFn5bo5Hk1zBli
         8kHaBueNq9KDkeh+pgjzYf87cvzve+I1DclEaSz4wdhr4LrKx76bQOp/qMqZ0JW5x3u6
         0EFxqJxRpYhSwNT0BYC1813pgjlKb9dxNvjw3Pg5Q50TGrMyWUnvRvsAscCnI9lDcCmG
         S6TPbJOf7lxTDGNd8wb6HjlXWU3a4wNB+EKbgmqecau6QXx1m10/RBps5ifvrfHs3TBy
         1NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774263939; x=1774868739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEgk8GSQEsn3SVpxN+cX+X4If2GOWS5cIolLFwIFJFU=;
        b=Oaj3WVnK3PSMmyx/VUej3ey6oOane5y3mvNEwD749/qFjGCD0u0YGP5Aa9bRTjzOkc
         5FtByaBRpWmx/WTA10pbgs1jDMjUFE3nl8hc6ZG2RnbqX77G0kbJs1WOflyh/D/gG+gb
         dQd2oFT1kWRrbsu7Lmp0cYXS63nryLCO9j00bLdA7KS4Vm1b6xA+1xa5gQQ2eV+ECGzh
         EskmbmU50MYG/xjFjOSHZJujvekdNFCkyLsw3FfADlKMLh8SjuWYuv7Hox6GssdbGBuD
         LTdJIcY30yQSzXPbblXtTTa7RIhm4AvWIfGDUV106uO952sygnK5n4JfXbsFx8CdAAyZ
         lLcg==
X-Gm-Message-State: AOJu0YwhebNzO7pkU90QqQUxEyS9dVanc2xt0ElIlVMFLSGa3vjPlsXo
	IeoSfQ0sqejU97BjbT/rmLNdymiYQP4HR1s8wY/scXA+jkiT5j/+NtoEmUcgA89CYBU=
X-Gm-Gg: ATEYQzyZvO+UEXKd2c6bJu/sfjPvTsC4xG5k6z9lgEhsg2N0n9l1Umrl4dZkEwGXRIg
	oRVH0GM7ZeP6isqHpK2FfjbkJkUOWFc3JHytXVsNYEREK0FcNPRd5xCHwA6Q4AeSw5+uJu4sPrV
	d45qifxjUqHJ5yOAMkKwrCjwoLslpQF9uFDJFzRlveJ/8RjFAAX55DFcETW1GnSYa4zo1PkcVRu
	WYNRRtoqncxxUB7DKiJubNgUEeKec8LRzZB+S9zXnN0xMMiAd+75maNRaf1pBRHWNHICjpCGR5O
	V0DYIx2gTiMVOlwFvvuKjqsIKlDaeqvOeWTqxSgumQgdRl2Tb2phDtMKROzQ+chS2sj/982SBPi
	sUPYBrgAuVgWWyU4WrwM59hJ6hXflMpvXHJs5T+SdhqrcBPN1QnlL0+E6jbFAwtF38GwKM3t35Q
	Au0bdW5l65gImD2ucCPOKGCWWObWYfdiM=
X-Received: by 2002:a05:6000:2512:b0:43b:48d3:2a46 with SMTP id ffacd0b85a97d-43b64278272mr18413322f8f.33.1774263939196;
        Mon, 23 Mar 2026 04:05:39 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470f902sm30220785f8f.28.2026.03.23.04.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 04:05:38 -0700 (PDT)
Message-ID: <69b5da97-4fa2-4ce6-a1f7-74b9bce6712f@tuxon.dev>
Date: Mon, 23 Mar 2026 13:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
To: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
References: <189BC4ACC53FCB81.1328210@lists.cip-project.org>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <189BC4ACC53FCB81.1328210@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 11:05:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22529

Hi, CIP maintainers,

Gentle ping on this series and the v6.1, v6.12 backports.

Thank you!

On 3/11/26 13:05, claudiu beznea via lists.cip-project.org wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds PCIe support for the Renesas RZ/G3S SoC.
> Please have a look.
> 
> Thank you,
> Claudiu
> 
> Claudiu Beznea (11):
>    clk: renesas: r9a08g045: Add PCIe clocks and resets
>    dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
>    PCI: Add Renesas RZ/G3S host controller driver
>    PCI: rzg3s-host: Initialize MSI status bitmap before use
>    PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
>    PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and
>      RZG3S_PCI_PINTRCVIS
>    arm64: dts: renesas: r9a08g045: Use syscon compatible for the system
>      controller
>    arm64: dts: renesas: r9a08g045: Add PCIe node
>    arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
>    arm64: dts: renesas: rzg3s-smarc: Enable PCIe
>    arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
> 
> Felix Gu (1):
>    PCI: rzg3s-host: Fix device node reference leak in
>      rzg3s_pcie_host_parse_port()
> 
> Kevin Xie (1):
>    PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
> 
> Marek Vasut (1):
>    genirq/msi: Silence 'set affinity failed' warning
> 
> Niklas Cassel (2):
>    PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to
>      PCIE_RESET_CONFIG_WAIT_MS
>    PCI: Move link up wait time and max retries macros to pci.h
> 
> Syed Nayyar Waris (1):
>    lib/bitmap: add bitmap_{read,write}()
> 
>   .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  249 +++
>   MAINTAINERS                                   |    8 +
>   arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   67 +-
>   .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
>   arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
>   arch/arm64/configs/defconfig                  |    1 +
>   drivers/clk/renesas/r9a08g045-cpg.c           |   19 +
>   drivers/pci/controller/Kconfig                |    9 +
>   drivers/pci/controller/Makefile               |    1 +
>   drivers/pci/controller/pcie-rzg3s-host.c      | 1764 +++++++++++++++++
>   drivers/pci/pci.h                             |   19 +
>   include/linux/bitmap.h                        |   77 +
>   include/linux/msi.h                           |    2 +
>   kernel/irq/msi.c                              |    2 +-
>   14 files changed, 2232 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
>   create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c
> 


