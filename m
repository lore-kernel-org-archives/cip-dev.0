Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D0C433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 09:36:56 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web09.49245.1638783414352918963
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Dec 2021 01:36:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=3tqE+93P;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.54,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f54.google.com with SMTP id y13so40102383edd.13
        for <cip-dev@lists.cip-project.org>;
 Mon, 06 Dec 2021 01:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIgSFPqHE7Lo/e9dZ+G63gxwqEzgJfqaLu9WlIi+W0k=;
        b=3tqE+93P1dSVwnNh9SUJMf955g1cI5BtdhOTNEsqN1zzZ4SSPT9BEiwK9SiQ3gUKJI
         Y9AArpn39hRoyxJ55QNn0tmMXjV/JVkUfw5MMqSzjqoLktZF0AINlHT2sOZufC5Bu3qc
         VjvPw7mu2Hbcusc6kKxc/Aeuo9fpzYSrOZ1EH1mDJPVE93ey8uohjkO8MfG0TWjP6QKh
         eOKZZGMXW7P3mtCWZfg8UQsezofP++1n0IfONuRijzAfRoklpMbYvbA/Lh6bCQbwUcXS
         K9wPOQaWhSNihlDykR8N6sWytqCwVyNi4jH5AIUXjLE+4w0i1nG7tXFZjKNCPvQcETcn
         7SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIgSFPqHE7Lo/e9dZ+G63gxwqEzgJfqaLu9WlIi+W0k=;
        b=M7OGQv90DdApeqdEOQOzBK4XI4H5oZR44CJBF48owOubiRUM+FFiBzH4ucsx7w3CBp
         zNVxlSZTWfCO2rY+Ts4141sF6KGYmKtx5BPi48QRdNXzKB1N2IeKTwXFiJvl3dWmrJsm
         6nZtk1QNfLg+9u9AWwt9kVceMKQjQ7sLCM8fZ5MCDpePf9/v8DVrc36OndvLS1E1JeDE
         ZZvBrAvmPgfIncqFcpPrMQUprBVb+MNf+xdjkHuh/LdFTTd135Kcn3jlaCaIirA7hYO0
         mlPSNpVXMKycim/d9LB8Mzfx93deR71GQIdAosxE2yz4UVdfJxwFyLQ9Fqvl0byIPW1U
         AlDQ==
X-Gm-Message-State: AOAM532IeZIig/65EhZ4c/05M6kgJc5iGF+veSu4PZLh+YOIHgjV1+j2
	He/ibmOBuopUN43ht+Ttvp4HGANGheoxHzxwtGbnrvbllNjEnV4=
X-Google-Smtp-Source: 
 ABdhPJzuvu+yZXJwocbgTxC+WNM6xj/0fTKAjuYzh+uZ+BjpAPs4RLSXwhTTZrO2RljIa70MIBEkFEjBMr1OmsvFo+w=
X-Received: by 2002:a50:e608:: with SMTP id y8mr52941446edm.39.1638783412786;
 Mon, 06 Dec 2021 01:36:52 -0800 (PST)
MIME-Version: 1.0
References: 
 <TYAPR01MB62524C420EECB609794B0587926B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB62524C420EECB609794B0587926B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Mon, 6 Dec 2021 18:34:01 +0900
Message-ID: 
 <CANgtXuNNcmc7mj8JxEVvRW7x0qavcDHTcj+7qW6Uh8+pMXkcBg@mail.gmail.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v5.10.83-cip1 / First release of the
 CIP 5.10.y Linux kernel
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, pavel@denx.de, Chris.Paterson2@renesas.com,
	masami.ichikawa@cybertrust.co.jp, uli@fpond.eu,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Dec 2021 09:36:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7069

On Sun, Dec 5, 2021 at 8:24 AM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi all,
>
> We release v5.10.83-cip1, which is the first release of the CIP 5.10.y Linux kernel !
> This is based on v5.10.83 with some additional updates for the Renesas reference
> boards.
>
> You can get this release via the git tree at:
>
>   v5.10.83-cip1:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-5.10.y-cip
>     commit hash:
>       2332f07a324fd78d7c7436deeed23cd7db441ea7
>     added commits:
>       CIP: Add a number to the version suffix
>       dt-bindings: pci: rcar-pci-ep: Document missing interrupts property
>       dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings
>       dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings
>       memory: renesas-rpc-if: Make rpcif_enable/disable_rpm() as static inline
>       spi: spi-mem: Fix passing zero to 'PTR_ERR' warning
>       clk: renesas: r8a774a1: Add RPC clocks
>       clk: renesas: r8a774b1: Add RPC clocks
>       clk: renesas: r8a774c0: Add RPC clocks
>       pinctrl: renesas: r8a77990: Add QSPI[01] pins, groups and functions
>       pinctrl: renesas: r8a77990: Optimize pinctrl image size for R8A774C0
>       pinctrl: renesas: r8a77951: Add QSPI[01] pins, groups and functions
>       pinctrl: renesas: r8a77951: Optimize pinctrl image size for R8A774E1
>       pinctrl: renesas: r8a7796: Add QSPI[01] pins, groups and functions
>       pinctrl: renesas: r8a7796: Optimize pinctrl image size for R8A774A1
>       pinctrl: renesas: r8a77965: Add QSPI[01] pins, groups and functions
>       pinctrl: renesas: r8a77965: Optimize pinctrl image size for R8A774B1
>       Add configuration for gitlab-ci.
>

In the link here under there is the difference with Linux stable v5.10.83:
https://www.diffchecker.com/1Ber9vjb

Other than having linux-5.10.y-cip tested on more boards,
respectively 164 builds vs 184 builds for CIP kernel.
We could also test CIP kernel on arm64,
Linux stable looks not yet tested on arm64 with KernelCI.
I currently don't see any relevant difference from both build tests.

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

