Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751AED0BB47
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 22:47:13 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web10.1345.1729723624965740374
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Oct 2024 15:47:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=G6+kwfDk;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2918664a3fso332023276.0
        for <cip-dev@lists.cip-project.org>; Wed, 23 Oct 2024 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1729723624; x=1730328424; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nlDj8i+QLljFv7kHKjrRfw0kK3lZtj0h6ahrF51QgRE=;
        b=G6+kwfDk3q/XT69z68m0auD/CvEutm5SmNG2ym+f4CX3GrKdtqx0/Vb2lrbVkw/1Wt
         LZWo+WQkusnwnpRIRK1CB30Lexaa4FA+LPp/3nNfPpQrlYG3W8gxoE8R/yHLONqA+Ola
         x2ZzlRPlV2enVHpIyYyNc6otw9ocDT3cS/q/2CV8kXrgw8Wd6MUdEgWsz4RkBWeQcxXX
         mcKgTZ4UJSMzPr98mVZoy9I4AH3hti3uxvwhG8q0v5y/hrCKdRYCEG2tSweW16HJg2O5
         fG5VdwGOm8bL+8UsfscOoNnN3g5TASjp0kvMeMnABcVK8B8+kOVFeV0WCazoPv1locut
         yXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723624; x=1730328424;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlDj8i+QLljFv7kHKjrRfw0kK3lZtj0h6ahrF51QgRE=;
        b=spnxW7O/62ElzBwcRA1CyqXHcz5HiOxIG4UpNcahRQKENVBMkQ6VA6nbddkMfnX/xj
         7Jfu294kb0sgnbawVJRDEsH7fj3oZRa1DXWUBUPskuFu38Xc4h4m7wLikKZploEUO68w
         0xhpT48IUtffZwkGiG3tIHhQiFmPalsvwsih+gSWs33vkyYCUcq4YpnuAvTz0KpEi717
         EqmJ6VP3CSNEaCeozMPtG/Vtn8TiWSNcuxZ7bRNkoA3phB/a3hNIyA3+le6c8wBPbcQi
         jLjYlrfDX7cNeoAiajfhADo1FXfE3F11SgPdvf4GrySQ11BAWccmCAf8ZH+dNHr/CmNZ
         F33A==
X-Gm-Message-State: AOJu0YwUDD07w5SKn1WoPGmUdgTLU487lBVmpqYM3XY45/uLkPhOfSqj
	Ao3d5gl7M5hl6JrYySCUa9X4bv1qC1kBSDvKNAXa+Yij6RTBmzB8Zq25KO3CKlwLq5zLp8nDFJ/
	7JcxLfLDtEmSRCJEXDR8SMerquqO0+XYUCvluLyGPEdEYBmZla8Y=
X-Google-Smtp-Source: AGHT+IHDXB0RPbLk3eKeMvDtlR7Ggzp8Zw+0nROFZnm1Ikmwd8FtIal7PIIdq61T/fqjjKt3nEJWoApncD4h1okI9N0=
X-Received: by 2002:a05:6902:2589:b0:e20:2dba:42cb with SMTP id
 3f1490d57ef6-e2ea8a1f2a3mr56853276.6.1729723620740; Wed, 23 Oct 2024 15:47:00
 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Oct 2024 07:46:24 +0900
Message-ID: <CAODzB9rhct1T25bZNF=EB6A7Hkar_v+v7SP9bS=5Nq7suNLzjw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Oct 2024 22:47:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17074

Hi!

It's this week's CVE report.

This week reported 384 new CVEs and 37 updated CVEs.

* New CVEs

CVE-2024-8805: Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

Announce: https://www.cve.org/CVERecord?id=CVE-2024-8805

It was introduced by commit ba15a58b ("Bluetooth: Fix SSP
acceptor just-works confirmation without MITM") in 3.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b25e11f978b63cb7857890edb3a698599cddb10e]
stable/6.1: [d17c631ba04e960eb6f8728b10d585de20ac4f71]
stable/6.6: [830c03e58beb70b99349760f822e505ecb4eeb7e]

CVE-2022-48946: udf: Fix preallocation discarding at indirect extent boundary

Announce: https://lore.kernel.org/linux-cve-announce/2024102138-CVE-2022-48946-5989@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc1.

Fixed status
cip/4.4: [942a9a2c63ecf3ebed703b324314dc3795f94d52]
cip/4.4-rt: [942a9a2c63ecf3ebed703b324314dc3795f94d52]
cip/4.4-st: [942a9a2c63ecf3ebed703b324314dc3795f94d52]
mainline: [cfe4c1b25dd6d2f056afc00b7c98bcb3dd0b1fc3]
stable/4.19: [72f651c96c8aadf087fd782d551bf7db648a8c2e]
stable/5.10: [1a075f4a549481ce6e8518d8379f193ccec6b746]
stable/5.15: [63dbbd8f1499b0a161e701a04aa50148d60bd1f7]
stable/5.4: [4d835efd561dfb9bf5409f11f4ecd428d5d29226]
stable/6.1: [12a88f572d6d94b5c0b72e2d1782cc2e96ac06cf]

CVE-2022-48947: Bluetooth: L2CAP: Fix u8 overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024102140-CVE-2022-48947-0ab5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1.

Fixed status
cip/4.4: [ecd0e9a0f8e8b66882251c3f14c8dcd52b7bc5b3]
cip/4.4-rt: [ecd0e9a0f8e8b66882251c3f14c8dcd52b7bc5b3]
cip/4.4-st: [ecd0e9a0f8e8b66882251c3f14c8dcd52b7bc5b3]
mainline: [bcd70260ef56e0aee8a4fc6cd214a419900b0765]
stable/4.19: [ad528fde0702903208d0a79d88d5a42ae3fc235b]
stable/5.10: [f3fe6817156a2ad4b06f01afab04638a34d7c9a6]
stable/5.15: [19a78143961a197de8502f4f29c453b913dc3c29]
stable/5.4: [9fdc79b571434af7bc742da40a3405f038b637a7]

CVE-2022-48948: usb: gadget: uvc: Prevent buffer overflow in setup handler

Announce: https://lore.kernel.org/linux-cve-announce/2024102140-CVE-2022-48948-588a@gregkh/

Introduced by commit cdda479 ("USB gadget: video class function
driver") in v2.6.35-rc1.
Fixed in v6.2-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [a20527da42a634a12fe166532797b7d262403120]
cip/4.4-rt: [a20527da42a634a12fe166532797b7d262403120]
cip/4.4-st: [a20527da42a634a12fe166532797b7d262403120]
mainline: [4c92670b16727365699fe4b19ed32013bab2c107]
stable/4.19: [bc8380fe5768c564f921f7b4eaba932e330b9e4b]
stable/5.10: [c79538f32df12887f110dcd6b9c825b482905f24]
stable/5.15: [6b41a35b41f77821db24f2d8f66794b390a585c5]
stable/5.4: [b8fb1cba934ea122b50f13a4f9d6fc4fdc43d2be]
stable/6.1: [d1a92bb8d697f170d93fe922da763d7d156b8841]

CVE-2022-48949: igb: Initialize mailbox message for VF reset

Announce: https://lore.kernel.org/linux-cve-announce/2024102140-CVE-2022-48949-a7a1@gregkh/

Introduced by commit 6ddbc4c ("igb: Indicate failure on vf reset for
empty mac address") in v4.0-rc1.
Fixed in v6.2-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de5dc44370fbd6b46bd7f1a1e00369be54a041c8]
stable/4.19: [ef1d739dd1f362aec081278ff92f943c31eb177a]
stable/5.10: [f2479c3daaabccbac6c343a737615d0c595c6dc4]
stable/5.15: [367e1e3399dbc56fc669740c4ab60e35da632b0e]
stable/5.4: [c581439a977545d61849a72e8ed631cfc8a2a3c1]
stable/6.1: [c383c7c35c7bc15e07a04eefa060a8a80cbeae29]

CVE-2022-48950: perf: Fix perf_pending_task() UaF

Announce: https://lore.kernel.org/linux-cve-announce/2024102141-CVE-2022-48950-dc5f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc8.

Fixed status
mainline: [517e6a301f34613bff24a8e35b5455884f2d83d8]
stable/5.15: [8bffa95ac19ff27c8261904f89d36c7fcf215d59]

CVE-2022-48951: ASoC: ops: Check bounds for second channel in
snd_soc_put_volsw_sx()

Announce: https://lore.kernel.org/linux-cve-announce/2024102141-CVE-2022-48951-da5f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc8.

Fixed status
cip/4.4: [acf37a15557b31506b1881617bd17a574627719f]
cip/4.4-rt: [acf37a15557b31506b1881617bd17a574627719f]
cip/4.4-st: [acf37a15557b31506b1881617bd17a574627719f]
mainline: [97eea946b93961fffd29448dcda7398d0d51c4b2]
stable/4.19: [18a168d85eadcfd45f015b5ecd2a97801b959e43]
stable/5.10: [50b5f6d4d9d2d69a7498c44fd8b26e13d73d3d98]
stable/5.15: [cf611d786796ec33da09d8c83d7d7f4e557b27de]
stable/5.4: [9796d07c753164b7e6b0d7ef23fb4482840a9ef8]

CVE-2022-48952: PCI: mt7621: Add sentinel to quirks table

Announce: https://lore.kernel.org/linux-cve-announce/2024102141-CVE-2022-48952-a932@gregkh/

Introduced by commit b483b4e ("staging: mt7621-pci: add quirks for
'E2' revision using 'soc_device_attribute'") in v5.5-rc1.
Fixed in v6.2-rc1.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [19098934f910b4d47cb30251dd39ffa57bef9523]
stable/5.15: [3e9c395ef2d52975b2c2894d2da09d6db2958bc6]
stable/6.1: [a4997bae1b5b012c8a6e2643e26578a7bc2cae36]

CVE-2022-48953: rtc: cmos: Fix event handler registration ordering issue

Announce: https://lore.kernel.org/linux-cve-announce/2024102141-CVE-2022-48953-c6c0@gregkh/

Introduced by commit 6492fed ("rtc: rtc-cmos: Do not check
ACPI_FADT_LOW_POWER_S0") in v6.0-rc1.
Introduced by commit a474aae ("rtc-cmos: move wake setup from ACPI
glue into RTC driver") in v2.6.28-rc1.
Fixed in v6.1-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [4919d3eb2ec0ee364f7e3cf2d99646c1b224fae8]
stable/5.10: [0bcfccb48696aba475f046c2021f0733659ce0ef]
stable/5.15: [60c6e563a843032cf6ff84b2fb732cd8754fc10d]

CVE-2022-48954: s390/qeth: fix use-after-free in hsci

Announce: https://lore.kernel.org/linux-cve-announce/2024102141-CVE-2022-48954-30f2@gregkh/

Introduced by commit f7936b7 ("s390/qeth: Update MACs of LEARNING_SYNC
device") in v5.15-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebaaadc332cd21e9df4dcf9ce12552d9354bbbe4]
stable/5.15: [db6343a5b0d9661f2dd76f653c6d274d38234d2b]

CVE-2022-48955: net: thunderbolt: fix memory leak in tbnet_open()

Announce: https://lore.kernel.org/linux-cve-announce/2024102141-CVE-2022-48955-d31e@gregkh/

Introduced by commit 180b068 ("thunderbolt: Allow multiple DMA tunnels
over a single XDomain connection") in v5.13-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed14e5903638f6eb868e3e2b4e610985e6a6c876]
stable/5.15: [b9274dbe399952a8175db2e1ee148b7c9ba2b538]

CVE-2022-48956: ipv6: avoid use-after-free in ip6_fragment()

Announce: https://lore.kernel.org/linux-cve-announce/2024102142-CVE-2022-48956-75c8@gregkh/

Introduced by commit 1758fd4 ("ipv6: remove unnecessary dst_hold() in
ip6_fragment()") in v4.13-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [803e84867de59a1e5d126666d25eb4860cfd2ebe]
stable/4.19: [7e0dcd5f3ade221a6126278aca60c8ab4cc3bce9]
stable/5.10: [8208d7e56b1e579320b9ff3712739ad2e63e1f86]
stable/5.15: [7390c70bd431cbfa6951477e2c80a301643e284b]
stable/5.4: [6b6d3be3661bff2746cab26147bd629aa034e094]

CVE-2022-48957: dpaa2-switch: Fix memory leak in
dpaa2_switch_acl_entry_add() and dpaa2_switch_acl_entry_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2024102142-CVE-2022-48957-8250@gregkh/

Introduced by commit 1110318 ("dpaa2-switch: add tc flower hardware
offload on ingress traffic") in v5.13-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fad22a1281c500f15b172c9d261eff347ca634b]
stable/5.15: [54d830e24247fa8361b016dd2069362866f45cb6]

CVE-2022-48958: ethernet: aeroflex: fix potential skb leak in greth_init_rings()

Announce: https://lore.kernel.org/linux-cve-announce/2024102142-CVE-2022-48958-bb88@gregkh/

Introduced by commit d4c4113 ("net: Add Aeroflex Gaisler 10/100/1G
Ethernet MAC driver") in v2.6.34-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [8401d9194b043bb37cee1cbdaf6f6f1541e5779d]
cip/4.4-rt: [8401d9194b043bb37cee1cbdaf6f6f1541e5779d]
cip/4.4-st: [8401d9194b043bb37cee1cbdaf6f6f1541e5779d]
mainline: [063a932b64db3317ec020c94466fe52923a15f60]
stable/4.19: [bfaa8f6c5b84b295dd73b0138b57c5555ca12b1c]
stable/5.10: [87277bdf2c370ab2d07cfe77dfa9b37f82bbe1e5]
stable/5.15: [c7adcbd0fd3fde1b19150c3e955fb4a30c5bd9b7]
stable/5.4: [99669d94ce145389f1d6f197e6e18ed50d43fb76]

CVE-2022-48959: net: dsa: sja1105: fix memory leak in
sja1105_setup_devlink_regions()

Announce: https://lore.kernel.org/linux-cve-announce/2024102142-CVE-2022-48959-6120@gregkh/

Introduced by commit bf425b8 ("net: dsa: sja1105: expose static config
as devlink region") in v5.10-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78a9ea43fc1a7c06a420b132d2d47cbf4344a5df]
stable/5.10: [4be43e46c3f945fc7dd9e23c73a7a66927a3b814]
stable/5.15: [f3b5dda26cd0535aac09ed09c5d83f19b979ec9f]

CVE-2022-48960: net: hisilicon: Fix potential use-after-free in hix5hd2_rx()

Announce: https://lore.kernel.org/linux-cve-announce/2024102142-CVE-2022-48960-c9af@gregkh/

Introduced by commit 57c5bc9 ("net: hisilicon: add hix5hd2 mac
driver") in v3.16-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [7915327276c98876e2505490a6a66ba1276930d8]
cip/4.4-rt: [7915327276c98876e2505490a6a66ba1276930d8]
cip/4.4-st: [7915327276c98876e2505490a6a66ba1276930d8]
mainline: [433c07a13f59856e4585e89e86b7d4cc59348fab]
stable/4.19: [3a4eddd1cb023a71df4152fcc76092953e6fe95a]
stable/5.10: [93aaa4bb72e388f6a4887541fd3d18b84f1b5ddc]
stable/5.15: [b8ce0e6f9f88a6bb49d291498377e61ea27a5387]
stable/5.4: [1b6360a093ab8969c91a30bb58b753282e2ced4c]

CVE-2022-48961: net: mdio: fix unbalanced fwnode reference count in
mdio_device_release()

Announce: https://lore.kernel.org/linux-cve-announce/2024102143-CVE-2022-48961-d44b@gregkh/

Introduced by commit a9049e0 ("mdio: Add support for mdio drivers.")
in v4.5-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb37617687f2bfa5b675df7779f869147c9002bd]
stable/5.15: [16854177745a5648f8ec322353b432e18460f43a]

CVE-2022-48962: net: hisilicon: Fix potential use-after-free in hisi_femac_rx()

Announce: https://lore.kernel.org/linux-cve-announce/2024102143-CVE-2022-48962-1842@gregkh/

Introduced by commit 542ae60 ("net: hisilicon: Add Fast Ethernet MAC
driver") in v4.8-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4640177049549de1a43e9bc49265f0cdfce08cfd]
stable/4.19: [aceec8ab752428d8e151321479e82cc1a40fee2e]
stable/5.10: [296a50aa8b2982117520713edc1375777a9f8506]
stable/5.15: [6f4798ac9c9e98f41553c4f5e6c832c8860a6942]
stable/5.4: [e71a46cc8c9ad75f3bb0e4b361e81f79c0214cca]

CVE-2022-48963: net: wwan: iosm: fix memory leak in ipc_mux_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024102143-CVE-2022-48963-9cf2@gregkh/

Introduced by commit 1f52d7b ("net: wwan: iosm: Enable M.2 7360 WWAN
card support") in v5.18-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23353efc26e98b61b925274ecbb8f0610f69a8aa]

CVE-2022-48964: ravb: Fix potential use-after-free in ravb_rx_gbeth()

Announce: https://lore.kernel.org/linux-cve-announce/2024102143-CVE-2022-48964-8230@gregkh/

Introduced by commit 1c59eb6 ("ravb: Fillup ravb_rx_gbeth() stub") in v5.16-rc1.
Fixed in v6.1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt

Fixed status
mainline: [5a5a3e564de6a8db987410c5c2f4748d50ea82b8]

CVE-2022-48965: gpio/rockchip: fix refcount leak in rockchip_gpiolib_register()

Announce: https://lore.kernel.org/linux-cve-announce/2024102143-CVE-2022-48965-0039@gregkh/

Introduced by commit 936ee26 ("gpio/rockchip: add driver for rockchip
gpio") in v5.15-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63ff545af73f759d1bd04198af8ed8577fb739fc]
stable/5.15: [5cb8f1a784fd6115be58282fe15105572319d8be]

CVE-2022-48966: net: mvneta: Prevent out of bounds read in mvneta_config_rss()

Announce: https://lore.kernel.org/linux-cve-announce/2024102143-CVE-2022-48966-d8f6@gregkh/

Introduced by commit cad5d84 ("net: mvneta: Fix the CPU choice in
mvneta_percpu_elect") in v4.5-rc6.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8b4fc13900b8e8be48debffd0dfd391772501f7]
stable/4.19: [5a142486a0db6b0b85031f22d69acd0cdcf8f72b]
stable/5.10: [146ebee8fcdb349d7ec0e49915e6cdafb92544ae]
stable/5.15: [a6b30598fec84f8809f5417cde73071ca43e8471]
stable/5.4: [eec1fc21edc2bb99c9e66cf66f0b5d4d643fbb50]

CVE-2022-48967: NFC: nci: Bounds check struct nfc_target arrays

Announce: https://lore.kernel.org/linux-cve-announce/2024102144-CVE-2022-48967-c2ae@gregkh/

Introduced by commit 019c4fb ("NFC: Add NCI multiple targets support")
in v3.4-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [5570db2c17c4823871e38ca0bc41e8c7f196408f]
cip/4.4-rt: [5570db2c17c4823871e38ca0bc41e8c7f196408f]
cip/4.4-st: [5570db2c17c4823871e38ca0bc41e8c7f196408f]
mainline: [e329e71013c9b5a4535b099208493c7826ee4a64]
stable/4.19: [cff35329070b96b4484d23f9f48a5ca2c947e750]
stable/5.10: [27eb2d7a1b9987b6d0429b7716b1ff3b82c4ffc9]
stable/5.15: [908b2da426fe9c3ce74cf541ba40e7a4251db191]
stable/5.4: [6778434706940b8fad7ef35f410d2b9929f256d2]

CVE-2022-48968: octeontx2-pf: Fix potential memory leak in otx2_init_tc()

Announce: https://lore.kernel.org/linux-cve-announce/2024102144-CVE-2022-48968-9b4a@gregkh/

Introduced by commit 2e2a812 ("octeontx2-pf: Unify flow management
variables") in v5.15-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbf33f5ac76f2cdb47ad9763f620026d5cfa57ce]
stable/5.15: [eefd8953a74822cb72006632b9ee9dd95f92c146]

CVE-2022-48969: xen-netfront: Fix NULL sring after live migration

Announce: https://lore.kernel.org/linux-cve-announce/2024102144-CVE-2022-48969-8fe7@gregkh/

Introduced by commit 4ec2411 ([NET]: Do not check netif_running() and
carrier state in ->poll()) in v2.6.24-rc8.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d50b7914fae04d840ce36491d22133070b18cca9]
stable/4.19: [99859947517e446058ad7243ee81d2f9801fa3dd]
stable/5.10: [e6860c889f4ad50b6ab696f5ea154295d72cf27a]
stable/5.15: [e6e897d4fe2f89c0bd94600a40bedf5e6e75e050]
stable/5.4: [ed773dd798bf720756d20021b8d8a4a3d7184bda]

CVE-2022-48970: af_unix: Get user_ns from in_skb in unix_diag_get_exact().

Announce: https://lore.kernel.org/linux-cve-announce/2024102144-CVE-2022-48970-7c96@gregkh/

Introduced by commit cae9910 ("net: Add UNIX_DIAG_UID to Netlink UNIX
socket diagnostics.") in v5.3-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3abe42e94900bdd045c472f9c9be620ba5ce553]
stable/5.10: [575a6266f63dbb3b8eb1da03671451f0d81b8034]
stable/5.15: [5c014eb0ed6c8c57f483e94cc6e90f34ce426d91]
stable/5.4: [c66d78aee55dab72c92020ebfbebc464d4f5dd2a]

CVE-2022-48971: Bluetooth: Fix not cleanup led when bt_init fails

Announce: https://lore.kernel.org/linux-cve-announce/2024102144-CVE-2022-48971-6025@gregkh/

Introduced by commit e64c97b ("Bluetooth: Add combined LED trigger for
controller power") in v4.9-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f3957c7eb4e07df944169a3e50a4d6790e1c744]
stable/4.19: [8a66c3a94285552f6a8e45d73b34ebbad11d388b]
stable/5.10: [e7b950458156d410509a08c41930b75e72985938]
stable/5.15: [edf7284a98296369dd0891a0457eec37df244873]
stable/5.4: [2c6cf0afc3856359e620e96edd952457d258e16c]

CVE-2022-48972: mac802154: fix missing INIT_LIST_HEAD in ieee802154_if_add()

Announce: https://lore.kernel.org/linux-cve-announce/2024102145-CVE-2022-48972-4ccd@gregkh/

Introduced by commit fcf39e6 ("ieee802154: add wpan_dev_list") in v3.19-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [9d0edaaeb7f9ae628e5c4448ef0a8e6d74496df3]
cip/4.4-rt: [9d0edaaeb7f9ae628e5c4448ef0a8e6d74496df3]
cip/4.4-st: [9d0edaaeb7f9ae628e5c4448ef0a8e6d74496df3]
mainline: [b3d72d3135d2ef68296c1ee174436efd65386f04]
stable/4.19: [f00c84fb1635c27ba24ec5df65d5bd7d7dc00008]
stable/5.10: [42c319635c0cf7eb36eccac6cda76532f47b61a3]
stable/5.15: [a110287ef4a423980309490df632e1c1e73b3dc9]
stable/5.4: [1831d4540406708e48239cf38fd9c3b7ea98e08f]

CVE-2022-48973: gpio: amd8111: Fix PCI device reference count leak

Announce: https://lore.kernel.org/linux-cve-announce/2024102145-CVE-2022-48973-a0e7@gregkh/

Introduced by commit f942a7d ("gpio: add a driver for GPIO pins found
on AMD-8111 south bridge chips") in v3.6-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [4a6c9401ea802987f5e49b7b625b2a59b88417d6]
cip/4.4-rt: [4a6c9401ea802987f5e49b7b625b2a59b88417d6]
cip/4.4-st: [4a6c9401ea802987f5e49b7b625b2a59b88417d6]
mainline: [45fecdb9f658d9c82960c98240bc0770ade19aca]
stable/4.19: [b2bc053ebbba57a06fa655db5ea796de2edce445]
stable/5.10: [5ee6413d3dd972930af787b2c0c7aaeb379fa521]
stable/5.15: [4271515f189bd5fe2ec86b4089dab7cb804625d2]
stable/5.4: [48bd5d3801f6b67cc144449d434abbd5043a6d37]

CVE-2022-48974: netfilter: conntrack: fix using __this_cpu_add in preemptible

Announce: https://lore.kernel.org/linux-cve-announce/2024102145-CVE-2022-48974-d2d0@gregkh/

Introduced by commit c56716c ("netfilter: extensions: introduce
extension genid count") in v5.19-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9464d0b68f11a9bc768370c3260ec02b3550447b]

CVE-2022-48975: gpiolib: fix memory leak in gpiochip_setup_dev()

Announce: https://lore.kernel.org/linux-cve-announce/2024102145-CVE-2022-48975-d7f9@gregkh/

Introduced by commit 159f3cd ("gpiolib: Defer gpio device setup until
after gpiolib initialization") in v4.6-rc3.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec851b23084b3a0af8bf0f5e51d33a8d678bdc49]
stable/5.15: [6daaa84b621485fe28c401be18debf92ae8ef04a]

CVE-2022-48976: netfilter: flowtable_offload: fix using __this_cpu_add
in preemptible

Announce: https://lore.kernel.org/linux-cve-announce/2024102145-CVE-2022-48976-2980@gregkh/

Introduced by commit b038177 ("netfilter: nf_flow_table: count pending
offload workqueue tasks") in v6.0-rc1.
Fixed in v6.1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [a81047154e7ce4eb8769d5d21adcbc9693542a79]

CVE-2022-48977: can: af_can: fix NULL pointer dereference in can_rcv_filter

Announce: https://lore.kernel.org/linux-cve-announce/2024102145-CVE-2022-48977-0990@gregkh/

Introduced by commit 4e096a1 ("net: introduce CAN specific pointer in
the struct net_device") in v5.12-rc1.
Fixed in v6.1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [0acc442309a0a1b01bcdaa135e56e6398a49439c]
stable/5.10: [c42221efb1159d6a3c89e96685ee38acdce86b6f]
stable/5.15: [c142cba37de29f740a3852f01f59876af8ae462a]
stable/5.4: [3982652957e8d79ac32efcb725450580650a8644]

CVE-2022-48978: HID: core: fix shift-out-of-bounds in hid_report_raw_event

Announce: https://lore.kernel.org/linux-cve-announce/2024102146-CVE-2022-48978-8a19@gregkh/

Introduced by commit dde5845 ("[PATCH] Generic HID layer - code
split") in v2.6.20.16.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [cfc5604ebce2f3c5d2bae77b11dcf06dc15af3ae]
cip/4.4-rt: [cfc5604ebce2f3c5d2bae77b11dcf06dc15af3ae]
cip/4.4-st: [cfc5604ebce2f3c5d2bae77b11dcf06dc15af3ae]
mainline: [ec61b41918587be530398b0d1c9a0d16619397e5]
stable/4.19: [8e14f20e12224ee2429f75a5c9418a700e26a8d3]
stable/5.10: [bc03f809da78fc79e4aee132d4e5c6a2b3aeec73]
stable/5.15: [f755d11c55b29049b77da5cd9ab2faae96eb33c3]
stable/5.4: [db1ed1b3fb4ec0d19080a102956255769bc45c79]

CVE-2022-48979: drm/amd/display: fix array index out of bound error in DCN32 DML

Announce: https://lore.kernel.org/linux-cve-announce/2024102146-CVE-2022-48979-d40f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1.
The LinkCapacitySupport was added by commit 74458c0 ("drm/amd/display:
Add DCN3.1
DML calculation support") in 5.14-rc1.

Fixed status
mainline: [aeffc8fb2174f017a10df114bc312f899904dc68]

CVE-2022-48980: net: dsa: sja1105: avoid out of bounds access in
sja1105_init_l2_policing()

Announce: https://lore.kernel.org/linux-cve-announce/2024102146-CVE-2022-48980-0fec@gregkh/

Introduced by commit 38fbe91 ("net: dsa: sja1105: configure the
multicast policers, if present") in v5.14-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8bac7f9fdb0017b32157957ffffd490f95faa07]
stable/5.15: [5e88c6f4aaa70c542e59e5a9d2244bcc99cd245d]

CVE-2022-48981: drm/shmem-helper: Remove errant put in error path

Announce: https://lore.kernel.org/linux-cve-announce/2024102146-CVE-2022-48981-a877@gregkh/

Introduced by commit 2194a63 ("drm: Add library for shmem backed GEM
objects") in v5.2-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24013314be6ee4ee456114a671e9fa3461323de8]
stable/5.10: [6a4da05acd062ae7774b6b19cef2b7d922902d36]
stable/5.15: [83e3da8bb92fcfa7a1d232cf55f9e6c49bb84942]
stable/5.4: [585a07b820059462e0c93b76c7de2cd946b26b40]

CVE-2022-48982: Bluetooth: Fix crash when replugging CSR fake controllers

Announce: https://lore.kernel.org/linux-cve-announce/2024102146-CVE-2022-48982-717d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1.

Fixed status
mainline: [b5ca338751ad4783ec8d37b5d99c3e37b7813e59]
stable/5.10: [549b46f8130effccf168293270bb3b1d5da529cc]
stable/5.15: [a49894a5ac3656f1a4f0f6b110460060e8026bf8]

CVE-2022-48983: io_uring: Fix a null-ptr-deref in io_tctx_exit_cb()

Announce: https://lore.kernel.org/linux-cve-announce/2024102147-CVE-2022-48983-7e0c@gregkh/

Introduced by commit d56d938 ("io_uring: do ctx initiated file note
removal") in v5.12-rc3.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [998b30c3948e4d0b1097e639918c5cff332acac5]
stable/5.15: [f895511de9d27fff71dad2c234ad53b4afd2b06c]

CVE-2022-48984: can: slcan: fix freed work crash

Announce: https://lore.kernel.org/linux-cve-announce/2024102147-CVE-2022-48984-ea9e@gregkh/

Introduced by commit cfcb446 ("can: slcan: remove legacy
infrastructure") in v6.0-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb855e9f3b6b42c72af3f1eb0b288998fe0d5ebb]

CVE-2022-48985: net: mana: Fix race on per-CQ variable napi work_done

Announce: https://lore.kernel.org/linux-cve-announce/2024102147-CVE-2022-48985-40b5@gregkh/

Introduced by commit e1b5683 ("net: mana: Move NAPI from EQ to CQ") in
v5.15-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18010ff776fa42340efc428b3ea6d19b3e7c7b21]
stable/5.15: [fe50a9bbeb1f042e756c5cfa7708112c944368de]

CVE-2022-48986: mm/gup: fix gup_pud_range() for dax

Announce: https://lore.kernel.org/linux-cve-announce/2024102147-CVE-2022-48986-cd7d@gregkh/

Introduced by commit 414fd08 ("mm/gup: fix gup_pmd_range() for dax")
in v5.0-rc7.
Fixed in v6.1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [fcd0ccd836ffad73d98a66f6fea7b16f735ea920]
stable/5.10: [f1cf856123ceb766c49967ec79b841030fa1741f]
stable/5.15: [3ac29732a2ffa64c7de13a072b0f2848b9c11037]
stable/5.4: [04edfa3dc06ecfc6133a33bc7271298782dee875]

CVE-2022-48987: media: v4l2-dv-timings.c: fix too strict blanking sanity checks

Announce: https://lore.kernel.org/linux-cve-announce/2024102147-CVE-2022-48987-c88b@gregkh/

This CVE announce does not contain fixed commit in the mainline.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.4: [73f7c322a4e4358d4cb46ff69f15be751c6b4e10]
cip/4.4-rt: [73f7c322a4e4358d4cb46ff69f15be751c6b4e10]
cip/4.4-st: [73f7c322a4e4358d4cb46ff69f15be751c6b4e10]
mainline: [5eef2141776da02772c44ec406d6871a790761ee]
stable/4.19: [2572ab14b73aa45b6ae7e4c089ccf119fed5cf89]
stable/5.10: [32f01f0306a98629508f84d7ef0d1d037bc274a2]
stable/5.15: [6fb8bc29bfa80707994a63cc97e2f9920e0b0608]
stable/5.4: [4afc77068e36cee45b39d4fdc7513de26980f72c]

CVE-2022-48988: memcg: fix possible use-after-free in
memcg_write_event_control()

Announce: https://lore.kernel.org/linux-cve-announce/2024102148-CVE-2022-48988-188f@gregkh/

Introduced by commit 347c4a8 ("memcg: remove cgroup_event->cft") in v3.14-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a7ba45b1a435e7097ca0f79a847d0949d0eb088]
stable/4.19: [e1ae97624ecf400ea56c238bff23e5cd139df0b8]
stable/5.10: [f1f7f36cf682fa59db15e2089039a2eeb58ff2ad]
stable/5.15: [aad8bbd17a1d586005feb9226c2e9cfce1432e13]
stable/5.4: [35963b31821920908e397146502066f6b032c917]

CVE-2022-48989: fscache: Fix oops due to race with cookie_lru and use_cookie

Announce: https://lore.kernel.org/linux-cve-announce/2024102148-CVE-2022-48989-54c3@gregkh/

Introduced by commit 12bb21a ("fscache: Implement cookie user counting
and resource pinning") in v5.17-rc1.
Fixed in v6.1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5b52de3214a29911f949459a79f6640969b5487]

CVE-2022-48990: drm/amdgpu: fix use-after-free during gpu recovery

Announce: https://lore.kernel.org/linux-cve-announce/2024102148-CVE-2022-48990-1cf1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc7.
It seems as if this bug was introduced by commit f6a3f6 ("drm/amdgpu: Get rid of
amdgpu_job->external_hw_fence") in 6.0-rc1.

Fixed status
mainline: [3cb93f390453cde4d6afda1587aaa00e75e09617]

CVE-2022-48991: mm/khugepaged: invoke MMU notifiers in shmem/file collapse paths

Announce: https://lore.kernel.org/linux-cve-announce/2024102148-CVE-2022-48991-3987@gregkh/

Introduced by commit f3f0e1d ("khugepaged: add support of collapse for
tmpfs/shmem pages") in v4.8-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f268f6cf875f3220afc77bdd0bf1bb136eb54db9]
stable/4.19: [ff2a1a6f869650aec99e9d070b5ab625bfbc5bc3]
stable/5.10: [7f445ca2e0e59c7971d0b7b853465e50844ab596]
stable/5.15: [1a3f8c6cd29d9078cc81b29d39d0e9ae1d6a03c3]
stable/5.4: [5ffc2a75534d9d74d49760f983f8eb675fa63d69]

CVE-2022-48992: ASoC: soc-pcm: Add NULL check in BE reparenting

Announce: https://lore.kernel.org/linux-cve-announce/2024102148-CVE-2022-48992-2962@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc7.

Fixed status
cip/4.4: [d07f6d35bd19c20c270cabaa0661d186692107f0]
cip/4.4-rt: [d07f6d35bd19c20c270cabaa0661d186692107f0]
cip/4.4-st: [d07f6d35bd19c20c270cabaa0661d186692107f0]
mainline: [db8f91d424fe0ea6db337aca8bc05908bbce1498]
stable/4.19: [e7166d6821c15f3516bcac8ae3f155924da1908c]
stable/5.10: [f6f45e538328df9ce66aa61bafee1a5717c4b700]
stable/5.15: [9f74b9aa8d58c18927bb9b65dd5ba70a5fd61615]
stable/5.4: [f2ba66d8738584d124aff4e760ed1337f5f6dfb6]

CVE-2022-48994: ALSA: seq: Fix function prototype mismatch in
snd_seq_expand_var_event

Announce: https://lore.kernel.org/linux-cve-announce/2024102149-CVE-2022-48994-530f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc7.

Fixed status
cip/4.4: [ea6a3a0981f7ff2176768ad6d521a2e26a848728]
cip/4.4-rt: [ea6a3a0981f7ff2176768ad6d521a2e26a848728]
cip/4.4-st: [ea6a3a0981f7ff2176768ad6d521a2e26a848728]
mainline: [05530ef7cf7c7d700f6753f058999b1b5099a026]
stable/4.19: [2f46e95bf344abc4e74f8158901d32a869e0adb6]
stable/5.10: [15c42ab8d43acb73e2eba361ad05822c0af0ecfa]
stable/5.15: [fccd454129f6a0739651f7f58307cdb631fd6e89]
stable/5.4: [63badfed200219ca656968725f1a43df293ac936]

CVE-2022-48995: Input: raydium_ts_i2c - fix memory leak in raydium_i2c_send()

Announce: https://lore.kernel.org/linux-cve-announce/2024102149-CVE-2022-48995-8d2e@gregkh/

Introduced by commit 3b384bd ("Input: raydium_ts_i2c - do not split tx
transactions") in v5.10.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c9a59939deb4bfafdc451100c03d1e848b4169b]
stable/5.10: [a82869ac52f3d9db4b2cf8fd41edc2dee7a75a61]
stable/5.15: [53b9b1201e34ccc895971218559123625c56fbcd]

CVE-2022-48996: mm/damon/sysfs: fix wrong empty schemes assumption
under online tuning in damon_sysfs_set_schemes()

Announce: https://lore.kernel.org/linux-cve-announce/2024102149-CVE-2022-48996-e9ca@gregkh/

Introduced by commit da87878 ("mm/damon/sysfs: support online inputs
update") in v5.19-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95bc35f9bee5220dad4e8567654ab3288a181639]

CVE-2022-48997: char: tpm: Protect tpm_pm_suspend with locks

Announce: https://lore.kernel.org/linux-cve-announce/2024102149-CVE-2022-48997-cd65@gregkh/

Introduced by commit e891db1 ("tpm: turn on TPM on suspend for TPM
1.x") in v5.1-rc5.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23393c6461422df5bf8084a086ada9a7e17dc2ba]
stable/5.10: [4e0d6c687c925e27fd4bc78a2721d10acf5614d6]
stable/5.15: [571b6bbbf54d835ea6120f65575cb55cd767e603]
stable/5.4: [d699373ac5f3545243d3c73a1ccab77fdef8cec6]

CVE-2022-48998: powerpc/bpf/32: Fix Oops on tail call tests

Announce: https://lore.kernel.org/linux-cve-announce/2024102149-CVE-2022-48998-1016@gregkh/

Introduced by commit 51c66ad ("powerpc/bpf: Implement extended BPF on
PPC32") in v5.13-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89d21e259a94f7d5582ec675aa445f5a79f347e4]

CVE-2022-48999: ipv4: Handle attempt to delete multipath route when
fib_info contains an nh reference

Announce: https://lore.kernel.org/linux-cve-announce/2024102150-CVE-2022-48999-c5fd@gregkh/

Introduced by commit 493ced1 ("ipv4: Allow routes to use nexthop
objects") in v5.3-rc1.
Introduced by commit 6bf92d7 ("net: ipv4: fix route with nexthop
object delete warning") in v5.18-rc2.
Fixed in v6.1-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [61b91eb33a69c3be11b259c5ea484505cd79f883]
stable/5.10: [0b5394229ebae09afc07aabccb5ffd705ffd250e]
stable/5.15: [25174d91e4a32a24204060d283bd5fa6d0ddf133]
stable/5.4: [cc3cd130ecfb8b0ae52e235e487bae3f16a24a32]

CVE-2022-49000: iommu/vt-d: Fix PCI device refcount leak in has_external_pci()

Announce: https://lore.kernel.org/linux-cve-announce/2024102150-CVE-2022-49000-2c9c@gregkh/

Introduced by commit 89a6079 ("iommu/vt-d: Force IOMMU on for platform
opt in hint") in v5.0-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afca9e19cc720bfafc75dc5ce429c185ca93f31d]
stable/5.10: [10ed7655a17f6a3eaecd1293830488259ccd5723]
stable/5.15: [b6eea8b2e858a20ad58ac62dc2de90fea2413f94]

CVE-2022-49001: riscv: fix race when vmap stack overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024102150-CVE-2022-49001-589c@gregkh/

Introduced by commit 31da94c ("riscv: add VMAP_STACK overflow
detection") in v5.14-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e1864332fbc1b993659eab7974da9fe8bf8c128]
stable/5.15: [ac00301adb19df54f2eae1efc4bad7447c0156ce]

CVE-2022-49002: iommu/vt-d: Fix PCI device refcount leak in
dmar_dev_scope_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024102150-CVE-2022-49002-5b24@gregkh/

Introduced by commit 2e45528 ("iommu/vt-d: Unify the way to process
DMAR device scope array") in v3.15-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [c47bafffc6e5365d64cc384a3415c793fff5481e]
cip/4.4-rt: [c47bafffc6e5365d64cc384a3415c793fff5481e]
cip/4.4-st: [c47bafffc6e5365d64cc384a3415c793fff5481e]
mainline: [4bedbbd782ebbe7287231fea862c158d4f08a9e3]
stable/4.19: [876d7bfb89273997056220029ff12b1c2cc4691d]
stable/5.10: [a5c65cd56aed027f8a97fda8b691caaeb66d115e]
stable/5.15: [bdb613ef179ad4bb9d56a2533e9b30e434f1dfb7]
stable/5.4: [cbdd83bd2fd67142b03ce9dbdd1eab322ff7321f]

CVE-2022-49003: nvme: fix SRCU protection of nvme_ns_head list

Announce: https://lore.kernel.org/linux-cve-announce/2024102150-CVE-2022-49003-482c@gregkh/

Introduced by commit e7d6580 ("nvme-multipath: revalidate paths during
rescan") in v5.15-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [899d2a05dc14733cfba6224083c6b0dd5a738590]
stable/5.15: [787d81d4eb150e443e5d1276c6e8f03cfecc2302]

CVE-2022-49004: riscv: Sync efi page table's kernel mappings before switching

Announce: https://lore.kernel.org/linux-cve-announce/2024102151-CVE-2022-49004-18ac@gregkh/

Introduced by commit b91540d ("RISC-V: Add EFI runtime services") in v5.10-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f105a742725a1b78766a55169f1d827732e62b8]
stable/5.15: [fa7a7d185ef380546b4b1fed6f84f31dbae8cec7]

CVE-2022-49005: ASoC: ops: Fix bounds check for _sx controls

Announce: https://lore.kernel.org/linux-cve-announce/2024102151-CVE-2022-49005-c5ba@gregkh/

Introduced by commit 4f1e50d ("ASoC: ops: Reject out of bounds values
in snd_soc_put_volsw_sx()") in v5.17-rc3.
Fixed in v6.1-rc8.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.4: [787686e7dcccc694ee4ab30633d08304f5daf4b1]
cip/4.4-rt: [787686e7dcccc694ee4ab30633d08304f5daf4b1]
cip/4.4-st: [787686e7dcccc694ee4ab30633d08304f5daf4b1]
mainline: [698813ba8c580efb356ace8dbf55f61dac6063a8]
stable/4.19: [46bab25cc0230df60d1c02b651cc5640a14b08df]
stable/5.10: [b50c9641897274c3faef5f95ac852f54b94be2e8]
stable/5.15: [98b15c706644bebc19d2e77ccc360cc51444f6d0]
stable/5.4: [73dce3c1d48c4662bdf3ccbde1492c2cb4bfd8ce]

CVE-2022-49006: tracing: Free buffers when a used dynamic event is removed

Announce: https://lore.kernel.org/linux-cve-announce/2024102151-CVE-2022-49006-83c9@gregkh/

Introduced by commit 77b44d1 ("tracing/kprobes: Rename Kprobe-tracer
to kprobe-event") in v2.6.33-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4313e5a613049dfc1819a6dfb5f94cf2caff9452]
stable/5.10: [be111ebd8868d4b7c041cb3c6102e1ae27d6dc1d]
stable/5.15: [417d5ea6e735e5d88ffb6c436cf2938f3f476dd1]
stable/5.4: [1603feac154ff38514e8354e3079a455eb4801e2]

CVE-2022-49007: nilfs2: fix NULL pointer dereference in
nilfs_palloc_commit_free_entry()

Announce: https://lore.kernel.org/linux-cve-announce/2024102151-CVE-2022-49007-c02b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc8.

Fixed status
cip/4.4: [a61ed2aa52bd4319661afab1ac4a34c9d444c541]
cip/4.4-rt: [a61ed2aa52bd4319661afab1ac4a34c9d444c541]
cip/4.4-st: [a61ed2aa52bd4319661afab1ac4a34c9d444c541]
mainline: [f0a0ccda18d6fd826d7c7e7ad48a6ed61c20f8b4]
stable/4.19: [bc3fd3293887b4cf84a9109700faeb82de533c89]
stable/5.10: [e858917ab785afe83c14f5ac141301216ccda847]
stable/5.15: [33021419fd81efd3d729a7f19341ba4b98fe66ce]
stable/5.4: [9a130b72e6bd1fb07fc3cde839dc6fb53da76f07]

CVE-2022-49008: can: can327: can327_feed_frame_to_netdev(): fix
potential skb leak when netdev is down

Announce: https://lore.kernel.org/linux-cve-announce/2024102151-CVE-2022-49008-d62f@gregkh/

Introduced by commit 43da2f0 ("can: can327: CAN/ldisc driver for
ELM327 based OBD-II adapters") in v6.0-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fa452cfafed521aaf5a18c71003fe24b1ee6141]

CVE-2022-49009: hwmon: (asus-ec-sensors) Add checks for devm_kcalloc

Announce: https://lore.kernel.org/linux-cve-announce/2024102152-CVE-2022-49009-9bee@gregkh/

Introduced by commit d0ddfd2 ("hwmon: (asus-ec-sensors) add driver for
ASUS EC") in v5.18-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bdc112be727cf1ba65be79541147f960c3349d8]

CVE-2022-49010: hwmon: (coretemp) Check for null before removing sysfs attrs

Announce: https://lore.kernel.org/linux-cve-announce/2024102152-CVE-2022-49010-f8e1@gregkh/

Introduced by commit 199e0de ("hwmon: (coretemp) Merge pkgtemp with
coretemp") in v3.0-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [7d99f778bd89b6948eae160a953d1b96ab040c70]
cip/4.4-rt: [7d99f778bd89b6948eae160a953d1b96ab040c70]
cip/4.4-st: [7d99f778bd89b6948eae160a953d1b96ab040c70]
mainline: [a89ff5f5cc64b9fe7a992cf56988fd36f56ca82a]
stable/4.19: [280110db1a7d62ad635b103bafc3ae96e8bef75c]
stable/5.10: [f06e0cd01eab954bd5f2190c9faa79bb5357e05b]
stable/5.15: [7692700ac818866d138a8de555130a6e70e6ac16]
stable/5.4: [89eecabe6a47403237f45aafd7d24f93cb973653]

CVE-2022-49011: hwmon: (coretemp) fix pci device refcount leak in nv1a_ram_new()

Announce: https://lore.kernel.org/linux-cve-announce/2024102152-CVE-2022-49011-069a@gregkh/

Introduced by commit 14513ee ("hwmon: (coretemp) Use PCI host bridge
ID to identify CPU if necessary") in v3.14-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [5af7ac66721144aea39900160ea468200ebfc0ca]
cip/4.4-rt: [5af7ac66721144aea39900160ea468200ebfc0ca]
cip/4.4-st: [5af7ac66721144aea39900160ea468200ebfc0ca]
mainline: [7dec14537c5906b8bf40fd6fd6d9c3850f8df11d]
stable/4.19: [2f74cffc7c85f770b1b1833dccb03b8cde3be102]
stable/5.10: [c40db1e5f316792b557d2be37e447c20d9ac4635]
stable/5.15: [6e035d5a2a6b907cfce9a80c5f442c2e459cd34e]
stable/5.4: [ea5844f946b1ec5c0b7c115cd7684f34fd48021b]

CVE-2022-49012: afs: Fix server->active leak in afs_put_server

Announce: https://lore.kernel.org/linux-cve-announce/2024102152-CVE-2022-49012-8eb3@gregkh/

Introduced by commit 2757a4d ("afs: Fix access after dec in put
functions") in v6.0-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef4d3ea40565a781c25847e9cb96c1bd9f462bc6]

CVE-2022-49013: sctp: fix memory leak in sctp_stream_outq_migrate()

Announce: https://lore.kernel.org/linux-cve-announce/2024102152-CVE-2022-49013-dd61@gregkh/

Introduced by commit 637784a ("sctp: introduce priority based stream
scheduler") in v4.15-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ed7bfc79542119ac0a9e1ce8a2a5285e43433e9]
stable/5.10: [176ee6c673ccd118e9392fd2dbb165423bdb99ca]
stable/5.15: [0dfb9a566327182387c90100ea54d8426cee8c67]
stable/5.4: [a7555681e50bdebed2c40ff7404ee73c2e932993]

CVE-2022-49014: net: tun: Fix use-after-free in tun_detach()

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2022-49014-1627@gregkh/

Introduced by commit 83c1f36 ("tun: send netlink notification when the
device is modified") in v4.17-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5daadc86f27ea4d691e2131c04310d0418c6cd12]
stable/4.19: [1f23f1890d91812c35d32eab1b49621b6d32dc7b]
stable/5.10: [5f442e1d403e0496bacb74a58e2be7f500695e6f]
stable/5.15: [04b995e963229501401810dab89dc73e7f12d054]
stable/5.4: [16c244bc65d1175775325ec0489a5a5c830e02c7]

CVE-2022-49015: net: hsr: Fix potential use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2022-49015-1fd0@gregkh/

Introduced by commit f421436 ("net/hsr: Add support for the
High-availability Seamless Redundancy protocol (HSRv0)") in v3.13-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [ff3660cdcffefcdc861c75e040239ae0c988f179]
cip/4.4-rt: [ff3660cdcffefcdc861c75e040239ae0c988f179]
cip/4.4-st: [ff3660cdcffefcdc861c75e040239ae0c988f179]
mainline: [7e177d32442b7ed08a9fa61b61724abc548cb248]
stable/4.19: [b35d899854d5d5d58eb7d7e7c0f61afc60d3a9e9]
stable/5.10: [7ca81a161e406834a1fdc405fc83a572bd14b8d9]
stable/5.15: [dca370e575d9b6c983f5015e8dc035e23e219ee6]
stable/5.4: [53a62c5efe91665f7a41fad0f888a96f94dc59eb]

CVE-2022-49016: net: mdiobus: fix unbalanced node reference count

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2022-49016-c7bb@gregkh/

Introduced by commit bc1bee3 ("net: mdiobus: Introduce
fwnode_mdiobus_register_phy()") in v5.14-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cdde1560118f82498fc9e9a7c1ef7f0ef7755891]
stable/5.15: [543d917f691ab06885ee779c862065899eaa4251]

CVE-2022-49017: tipc: re-fetch skb cb after tipc_msg_validate

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2022-49017-ae90@gregkh/

Introduced by commit fc1b6d6 ("tipc: introduce TIPC encryption &
authentication") in v5.5-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3067bc61fcfe3081bf4807ce65560f499e895e77]
stable/5.10: [a1ba595e35aa3afbe417ff0af353afb9f65559c0]
stable/5.15: [1daec0815655e110c6f206c5e777a4af8168ff58]

CVE-2022-49018: mptcp: fix sleep in atomic at close time

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2022-49018-7ee3@gregkh/

Introduced by commit 30e51b9 ("mptcp: fix unreleased socket in accept
queue") in v6.0.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4f166651d03b5484fa179817ba8ad4899a5a6ac]

CVE-2022-49019: net: ethernet: nixge: fix NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2022-49019-435d@gregkh/

Introduced by commit 492caff ("net: ethernet: nixge: Add support for
National Instruments XGE netdev") in v4.17-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9256db4e45e8b497b0e993cc3ed4ad08eb2389b6]
stable/5.10: [45752af0247589e6d3dede577415bfe117b4392c]
stable/5.15: [9c584d6d9cfb935dce8fc81a4c26debac0a3049b]
stable/5.4: [910c0264b64ef2dad8887714a7c56c93e39a0ed3]

CVE-2022-49020: net/9p: Fix a potential socket leak in p9_socket_open

Announce: https://lore.kernel.org/linux-cve-announce/2024102154-CVE-2022-49020-2d32@gregkh/

Introduced by commit 6b18662 ("9p connect fixes") in v2.6.33-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [1a4a5f088037994f165e53d494bb140686c142a3]
cip/4.4-rt: [1a4a5f088037994f165e53d494bb140686c142a3]
cip/4.4-st: [1a4a5f088037994f165e53d494bb140686c142a3]
mainline: [dcc14cfd7debe11b825cb077e75d91d2575b4cb8]
stable/4.19: [8b14bd0b500aec1458b51cb621c8e5fab3304260]
stable/5.10: [e01c1542379fb395e7da53706df598f38905dfbf]
stable/5.15: [8782b32ef867de7981bbe9e86ecb90e92e8780bd]
stable/5.4: [2d24d91b9f44620824fc37b766f7cae00ca32748]

CVE-2022-49021: net: phy: fix null-ptr-deref while probe() failed

Announce: https://lore.kernel.org/linux-cve-announce/2024102154-CVE-2022-49021-9979@gregkh/

Introduced by commit e139345 ("[PATCH] PHY Layer fixup") in v2.6.20.16.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [369eb2c9f1f72adbe91e0ea8efb130f0a2ba11a6]
stable/4.19: [0744c7be4de564db03e24527b2e096b7e0e20972]
stable/5.10: [fe6bc99c27c21348f548966118867ed26a9a372c]
stable/5.15: [7730904f50c7187dd16c76949efb56b5fb55cd57]
stable/5.4: [3e21f85d87c836462bb52ef2078ea561260935c1]

CVE-2022-49022: wifi: mac8021: fix possible oob access in
ieee80211_get_rate_duration

Announce: https://lore.kernel.org/linux-cve-announce/2024102154-CVE-2022-49022-c605@gregkh/

Introduced by commit db3e1c4 ("mac80211: Import airtime calculation
code from mt76") in v5.5-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e8f7abcc3473bc9603323803aeaed4ffcc3a2ab]
stable/5.10: [0184ede0ec61b9cd075babfaa45081b1bf322234]
stable/5.15: [59b54f0563b6546c94bdb6823d3b382c75407019]

CVE-2022-49023: wifi: cfg80211: fix buffer overflow in elem comparison

Announce: https://lore.kernel.org/linux-cve-announce/2024102154-CVE-2022-49023-381d@gregkh/

Introduced by commit 0b8fb82 ("cfg80211: Parsing of Multiple BSSID
information in scanning") in v5.1-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f16b5c82a025cd4c864737409234ddc44fb166a]
stable/5.10: [9e6b79a3cd17620d467311b30d56f2648f6880aa]
stable/5.15: [88a6fe3707888bd1893e9741157a7035c4159ab6]
stable/5.4: [f5c2ec288a865dbe3706b09bed12302e9f6d696b]

CVE-2022-49024: can: m_can: pci: add missing m_can_class_free_dev() in
probe/remove methods

Announce: https://lore.kernel.org/linux-cve-announce/2024102154-CVE-2022-49024-e31a@gregkh/

Introduced by commit cab7ffc ("can: m_can: add PCI glue driver for
Intel Elkhart Lake") in v5.11-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1eca1d4cc21b6d0fc5f9a390339804c0afce9439]
stable/5.15: [ea8dc27bb044e19868155e500ce397007be98656]

CVE-2022-49025: net/mlx5e: Fix use-after-free when reverting termination table

Announce: https://lore.kernel.org/linux-cve-announce/2024102155-CVE-2022-49025-4bcc@gregkh/

Introduced by commit 10caabd ("net/mlx5e: Use termination table for
VLAN push actions") in v5.3-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52c795af04441d76f565c4634f893e5b553df2ae]
stable/5.10: [0d2f9d95d9fbe993f3c4bafb87d59897b0325aff]
stable/5.15: [372eb550faa0757349040fd43f59483cbfdb2c0b]
stable/5.4: [0a2d73a77060c3cbdc6e801cd5d979d674cd404b]

CVE-2022-49026: e100: Fix possible use after free in e100_xmit_prepare

Announce: https://lore.kernel.org/linux-cve-announce/2024102155-CVE-2022-49026-f8d1@gregkh/

Introduced by commit 5e5d494 ("e100: Release skb when DMA mapping is
failed in e100_xmit_prepare") in v4.3-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45605c75c52c7ae7bfe902214343aabcfe5ba0ff]
stable/5.10: [b775f37d943966f6f77dca402f5a9dedce502c25]
stable/5.15: [9fc27d22cdb9b1fcd754599d216a8992fed280cd]

CVE-2022-49027: iavf: Fix error handling in iavf_init_module()

Announce: https://lore.kernel.org/linux-cve-announce/2024102155-CVE-2022-49027-3006@gregkh/

Introduced by commit 2803b16 ("i40e/i40evf: Use private workqueue") in v4.6-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [227d8d2f7f2278b8468c5531b0cd0f2a905b4486]
stable/5.10: [971c55f0763b480e63ceb7a22beb19be2509e5ed]
stable/5.15: [0d9f5bd54b913018031c5b964fc1f9a31f5f6cb5]

CVE-2022-49028: ixgbevf: Fix resource leak in ixgbevf_init_module()

Announce: https://lore.kernel.org/linux-cve-announce/2024102155-CVE-2022-49028-78e7@gregkh/

Introduced by commit 40a13e2 ("ixgbevf: Use a private workqueue to
avoid certain possible hangs") in v4.5-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cfa238a48f34038464b99d0b4825238c2687181]
stable/5.10: [f166c62cad798c53300b4b327e44300c73ec492d]
stable/5.15: [7109e941099244cc876a4b3cb7a3ec79f104374a]

CVE-2022-49029: hwmon: (ibmpex) Fix possible UAF when
ibmpex_register_bmc() fails

Announce: https://lore.kernel.org/linux-cve-announce/2024102155-CVE-2022-49029-0ffd@gregkh/

Introduced by commit 57c7c3a ("hwmon: IBM power meter driver") in v2.6.24-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [eae626f96af07c2cbd2f715ad2f9a7a8da932e6d]
cip/4.4-rt: [eae626f96af07c2cbd2f715ad2f9a7a8da932e6d]
cip/4.4-st: [eae626f96af07c2cbd2f715ad2f9a7a8da932e6d]
mainline: [e2a87785aab0dac190ac89be6a9ba955e2c634f2]
stable/4.19: [24b9633f7db7f4809be7053df1d2e117e7c2de10]
stable/5.10: [90907cd4d11351ff76c9a447bcb5db0e264c47cd]
stable/5.15: [45f6e81863747c0d7bc6a95ec51129900e71467a]
stable/5.4: [7b2b67fe1339389e0bf3c37c7a677a004ac0e4e3]

CVE-2022-49030: libbpf: Handle size overflow for ringbuf mmap

Announce: https://lore.kernel.org/linux-cve-announce/2024102155-CVE-2022-49030-cee8@gregkh/

Introduced by commit bf99c93 ("libbpf: Add BPF ring buffer support")
in v5.8-rc1.
Fixed in v6.1-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [927cbb478adf917e0a142b94baa37f06279cc466]
stable/5.10: [8a549ab6724520aa3c07f47e0eba820293551490]
stable/5.15: [0140e079a42064680394fff1199a7b5483688dec]

CVE-2022-49031: iio: health: afe4403: Fix oob read in afe4403_read_raw

Announce: https://lore.kernel.org/linux-cve-announce/2024102156-CVE-2022-49031-5b75@gregkh/

Introduced by commit b36e825 ("iio: health/afe440x: Use regmap
fields") in v4.8-rc1.
Fixed in v6.1-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58143c1ed5882c138a3cd2251a336fc8755f23d9]
stable/4.19: [726fa3e4ab97dcff1c745bdc4fb137366cb8d3df]
stable/5.10: [b1756af172fb80a3edc143772d49e166ec691b6c]
stable/5.15: [e7e76a77aabef8989cbc0a8417af1aa040620867]
stable/5.4: [2d6a437064ffbe685c67ddb16dfc0946074c6c3f]

CVE-2022-49032: iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw

Announce: https://lore.kernel.org/linux-cve-announce/2024102156-CVE-2022-49032-d2a1@gregkh/

Introduced by commit b36e825 ("iio: health/afe440x: Use regmap
fields") in v4.8-rc1.
Fixed in v6.1-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc92d9e3de0b2d30a3ccc08048a5fad533e4672b]
stable/4.19: [f5575041ec15310bdc50c42b8b22118cc900226e]
stable/5.10: [5eb114f55b37dbc0487aa9c1913b81bb7837f1c4]
stable/5.15: [f7419fc42afc035f6b29ce713e17dcd2000c833f]
stable/5.4: [3f566b626029ca8598d48e5074e56bb37399ca1b]

CVE-2022-49033: btrfs: qgroup: fix sleep from invalid context bug in
btrfs_qgroup_inherit()

Announce: https://lore.kernel.org/linux-cve-announce/2024102156-CVE-2022-49033-a8c6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc7.

Fixed status
cip/4.4: [44ab5fcfd8d492ae34b9b6157ed1204e01a2fcd0]
cip/4.4-rt: [44ab5fcfd8d492ae34b9b6157ed1204e01a2fcd0]
cip/4.4-st: [44ab5fcfd8d492ae34b9b6157ed1204e01a2fcd0]
mainline: [f7e942b5bb35d8e3af54053d19a6bf04143a3955]
stable/4.19: [f4b930a1602b05e77fee31f9616599b25e910a86]
stable/5.10: [01d7c41eac9129fba80d8aed0060caab4a7dbe09]
stable/5.15: [044da1a371a0da579e805e89c96865f62d8f6f69]
stable/5.4: [8eb912af525042a7365295eb62f6d5270c2a6462]

CVE-2023-52917: ntb: intel: Fix the NULL vs IS_ERR() bug for
debugfs_create_dir()

Announce: https://lore.kernel.org/linux-cve-announce/2024102100-CVE-2023-52917-f16d@gregkh/

Introduced by commit e26a584 ("NTB: Split ntb_hw_intel and
ntb_transport drivers") in v4.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e229897d373a87ee09ec5cc4ecd4bb2f895fc16b]
stable/5.10: [ef7e34237e2612b116a84c9640628a6f7a0d693e]
stable/5.15: [a429158f2e0a7a03eb67fd5e204e1f6735c725aa]
stable/6.1: [7cbd6d7fb9ba2be03978809c848e2e50eaeead2c]
stable/6.6: [16e5bed6c1883b19f9fcbdff996aa3381954d5f3]

CVE-2024-47675: bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()

Announce: https://lore.kernel.org/linux-cve-announce/2024102103-CVE-2024-47675-643d@gregkh/

Introduced by commit 89ae89f ("bpf: Add multi uprobe link") in v6.6-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fe6e308abaea082c20fbf2aa5df8e14495622cf]
stable/6.6: [790c630ab0e7d7aba6d186581d4627c09fce60f3]

CVE-2024-47676: mm/hugetlb.c: fix UAF of vma in hugetlb fault pathway

Announce: https://lore.kernel.org/linux-cve-announce/2024102105-CVE-2024-47676-016b@gregkh/

Introduced by commit 9acad7b ("hugetlb: use vmf_anon_prepare() instead
of anon_vma_prepare()") in v6.9-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98b74bb4d7e96b4da5ef3126511febe55b76b807]

CVE-2024-47677: exfat: resolve memory leak from exfat_create_upcase_table()

Announce: https://lore.kernel.org/linux-cve-announce/2024102106-CVE-2024-47677-714d@gregkh/

Introduced by commit a13d1a4 ("exfat: move freeing sbi, upcase table
and dropping nls into rcu-delayed helper") in v6.8-rc6.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c290fe508eee36df1640c3cb35dc8f89e073c8a8]

CVE-2024-47678: icmp: change the order of rate limits

Announce: https://lore.kernel.org/linux-cve-announce/2024102106-CVE-2024-47678-0b1b@gregkh/

Introduced by commit c0303ef ("net: reduce cycles spend on ICMP
replies that gets rate limited") in v4.11-rc1.
Introduced by commit 4cdf507 ("icmp: add a global rate limitation") in
v3.18-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c2bd38b95f75f3d2a08c93e35303e26d480d24e]
stable/6.1: [997ba8889611891f91e8ad83583466aeab6239a3]
stable/6.6: [662ec52260cc07b9ae53ecd3925183c29d34288b]

CVE-2024-47679: vfs: fix race between evice_inodes() and find_inode()&iput()

Announce: https://lore.kernel.org/linux-cve-announce/2024102106-CVE-2024-47679-e793@gregkh/

Introduced by commit 63997e9 ("split invalidate_inodes()") in v2.6.37-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88b1afbf0f6b221f6c5bb66cc80cd3b38d696687]
stable/5.10: [47a68c75052a660e4c37de41e321582ec9496195]
stable/5.15: [3721a69403291e2514d13a7c3af50a006ea1153b]
stable/6.1: [540fb13120c9eab3ef203f90c00c8e69f37449d1]
stable/6.6: [0eed942bc65de1f93eca7bda51344290f9c573bb]

CVE-2024-47680: f2fs: check discard support for conventional zones

Announce: https://lore.kernel.org/linux-cve-announce/2024102107-CVE-2024-47680-194f@gregkh/

Introduced by commit 30f1e72 ("block: move discard checks into the
ioctl handler") in v6.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43aec4d01bd2ce961817a777b3846f8318f398e4]

CVE-2024-47681: wifi: mt76: mt7996: fix NULL pointer dereference in
mt7996_mcu_sta_bfer_he

Announce: https://lore.kernel.org/linux-cve-announce/2024102107-CVE-2024-47681-bd36@gregkh/

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f503ae90c7355e8506e68498fe84c1357894cd5b]
stable/6.6: [8e4b60ae8a047ad2fb175fcfdd54feee80983a45]

CVE-2024-47682: scsi: sd: Fix off-by-one error in
sd_read_block_characteristics()

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-47682-0582@gregkh/

Introduced by commit 7fb019c ("scsi: sd: Switch to using scsi_device
VPD pages") in v5.19-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f81eaf08385ddd474a2f41595a7757502870c0eb]
stable/6.1: [60312ae7392f9c75c6591a52fc359cf7f810d48f]
stable/6.6: [568c7c4c77eee6df7677bb861b7cee7398a3255d]

CVE-2024-47683: drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-47683-8cf2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit 4562236 ("drm/amd/dc: Add dc display
driver (v2)") in 4.15-rc1.

Fixed status
mainline: [8151a6c13111b465dbabe07c19f572f7cbd16fef]
stable/6.1: [7c887efda1201110211fed8921a92a713e0b6bcd]
stable/6.6: [a53841b074cc196c3caaa37e1f15d6bc90943b97]

CVE-2024-47684: tcp: check skb is non-NULL in tcp_rto_delta_us()

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-47684-4869@gregkh/

Introduced by commit e1a10ef ("tcp: introduce tcp_rto_delta_us()
helper for xmit timer fix") in v4.13-rc5.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8770db2d54437a5f49417ae7b46f7de23d14db6]
stable/5.10: [ec31cf42fc4e35bb1248ce6eb1de6de9f851ac86]
stable/5.15: [5c4c03288a4aea705e36aa44119c13d7ee4dce99]
stable/6.1: [96c4983eab2a5da235f7fff90beaf17b008ba029]
stable/6.6: [570f7d8c9bf14f041152ba8353d4330ef7575915]

CVE-2024-47685: netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-47685-af1e@gregkh/

Introduced by commit c8d7b98 ("netfilter: move nf_send_resetX() code
to nf_reject_ipvX modules") in v3.18-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c778fe48d20ef362047e3376dee56d77f8500d4]
stable/5.10: [dcf48ab3ca2c55b09c8f9c8de0df01c1943bc4e5]
stable/5.15: [fbff87d682e57ddbbe82abf6d0a1a4a36a98afcd]
stable/6.1: [7ea2bcfd9bf4c3dbbf22546162226fd1c14d8ad2]
stable/6.6: [af4b8a704f26f38310655bad67fd8096293275a2]

CVE-2024-47686: ep93xx: clock: Fix off by one in ep93xx_div_recalc_rate()

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-47686-e46a@gregkh/

Introduced by commit 9645ccc ("ep93xx: clock: convert in-place to
COMMON_CLK") in v5.16-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7f06284a6427475e3df742215535ec3f6cd9662]
stable/6.1: [7a5bd2fb92388c51d267f6ce57c40f1cca8af1e0]
stable/6.6: [66e78ade976dbd9bea09166aa8d66afc0963cde4]

CVE-2024-47687: vdpa/mlx5: Fix invalid mr resource destroy

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-47687-9a03@gregkh/

Introduced by commit 512c0cd ("vdpa/mlx5: Decouple cvq iotlb handling
from hw mapping code") in v6.7-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc12502905b7a3de9097ea6b98870470c2921e09]

CVE-2024-47688: driver core: Fix a potential null-ptr-deref in
module_add_driver()

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-47688-0fe1@gregkh/

Introduced by commit 85d2b0a ("module: don't ignore
sysfs_create_link() failures") in v6.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [18ec12c97b39ff6aa15beb8d2b25d15cd44b87d8]
stable/6.6: [b8e45b910525704010d10c9dcbf2abf3005aa97c]

CVE-2024-47689: f2fs: fix to don't set SB_RDONLY in f2fs_handle_critical_error()

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-47689-cdec@gregkh/

Introduced by commit b62e71b ("f2fs: support
errors=remount-ro|continue|panic mountoption") in v6.5-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [930c6ab93492c4b15436524e704950b364b2930c]
stable/6.6: [649ec8b30df113042588bd3d3cd4e98bcb1091e0]

CVE-2024-47690: f2fs: get rid of online repaire on corrupted directory

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-47690-113f@gregkh/

Introduced by commit 510022a ("f2fs: add F2FS_INLINE_DOTS to recover
missing dot dentries") in v4.1-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [884ee6dc85b959bc152f15bca80c30f06069e6c4]
stable/5.15: [e8d64f598eeb079c42a52deaa3a91312c736a49d]
stable/6.1: [f4746f2d79507f65cfbde11d3c39ee8338aa50af]
stable/6.6: [f9ce2f550d53d044ecfb5ce996406cf42cd6b84d]

CVE-2024-47691: f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()

Announce: https://lore.kernel.org/linux-cve-announce/2024102111-CVE-2024-47691-ab21@gregkh/

Introduced by commit 7950e9a ("f2fs: stop gc/discard thread after fs
shutdown") in v4.16-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7f114d864ac91515bb07ac271e9824a20f5ed95]
stable/6.6: [fc18e655b62ac6bc9f12f5de0d749b4a3fe1e812]

CVE-2024-47692: nfsd: return -EINVAL when namelen is 0

Announce: https://lore.kernel.org/linux-cve-announce/2024102111-CVE-2024-47692-38d2@gregkh/

Introduced by commit 7472595 ("nfsd: un-deprecate nfsdcld") in v5.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22451a16b7ab7debefce660672566be887db1637]
stable/5.10: [0f1d007bbea38a61cf9c5392708dc70ae9d84a3d]
stable/5.15: [b7b7a8df41ef18862dd6b22289fb46c2c12398af]
stable/6.1: [84a563d136faf514fdad1ade28d7a142fd313cb8]
stable/6.6: [318f70857caab3da9a6ada9bc8c1f4f7591b695e]

CVE-2024-47693: IB/core: Fix ib_cache_setup_one error flow cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024102112-CVE-2024-47693-f12d@gregkh/

Introduced by commit 1901b91 ("IB/core: Fix potential NULL pointer
dereference in pkey cache") in v5.7-rc6.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [1403c8b14765eab805377dd3b75e96ace8747aed]
stable/5.15: [1730d47d1865af89efd01cf0469a9a739cbf60f2]
stable/6.1: [45f63f4bb9a7128a6209d766c2fc02b3d42fbf3e]
stable/6.6: [d08754be993f270e3d296d8f5d8e071fe6638651]

CVE-2024-47694: IB/mlx5: Fix UMR pd cleanup on error flow of driver init

Announce: https://lore.kernel.org/linux-cve-announce/2024102112-CVE-2024-47694-5594@gregkh/

Introduced by commit 6384201 ("IB/mlx5: Create UMR QP just before
first reg_mr occurs") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [112e6e83a894260cc7efe79a1fc47d4d51461742]

CVE-2024-47695: RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds

Announce: https://lore.kernel.org/linux-cve-announce/2024102112-CVE-2024-47695-2d7b@gregkh/

Introduced by commit 6a98d71 ("RDMA/rtrs: client: main functionality")
in v5.8-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e4289b29e216a55d08a89e126bc0b37cbad9f38]
stable/5.15: [0429a4e972082e3a2351da414b1c017daaf8aed2]
stable/6.1: [5ac73f8191f3de41fef4f934d84d97f3aadb301f]
stable/6.6: [01b9be936ee8839ab9f83a7e84ee02ac6c8303c4]

CVE-2024-47696: RDMA/iwcm: Fix
WARNING:at_kernel/workqueue.c:#check_flush_dependency

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-47696-e1f7@gregkh/

Introduced by commit aee2424 ("RDMA/iwcm: Fix a use-after-free related
to destroying CM IDs") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [86dfdd8288907f03c18b7fb462e0e232c4f98d89]
stable/5.10: [2efe8da2ddbf873385b4bc55366d09350b408df6]
stable/5.15: [da0392698c62397c19deb1b9e9bdf2fbb5a9420e]
stable/6.1: [a64f30db12bdc937c5108158d98c8eab1925c548]
stable/6.6: [8b7df76356d098f85f3bd2c7cf6fb43f531893d7]

CVE-2024-47697: drivers: media: dvb-frontends/rtl2830: fix an
out-of-bounds write error

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-47697-5277@gregkh/

Introduced by commit df70dda ("[media] rtl2830: implement PID filter")
in v4.0-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46d7ebfe6a75a454a5fa28604f0ef1491f9d8d14]
stable/5.10: [badbd736e6649c4e6d7b4ff7e2b9857acfa9ea94]
stable/5.15: [86d920d2600c3a48efc2775c1666c1017eec6956]
stable/6.1: [3dba83d3c81de1368d15a39f22df7b53e306052f]
stable/6.6: [58f31be7dfbc0c84a6497ad51924949cf64b86a2]

CVE-2024-47698: drivers: media: dvb-frontends/rtl2832: fix an
out-of-bounds write error

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-47698-d5fe@gregkh/

Introduced by commit 4b01e01 ("[media] rtl2832: implement PID filter")
in v4.0-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ae06f360cfaca2b88b98ca89144548b3186aab1]
stable/5.10: [6ae3b9aee42616ee93c4585174f40c767828006d]
stable/5.15: [a879b6cdd48134a3d58949ea4f075c75fa2d7d71]
stable/6.1: [15bea004e939d938a6771dfcf2a26cc899ffd20a]
stable/6.6: [527ab3eb3b0b4a6ee00e183c1de6a730239e2835]

CVE-2024-47699: nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-47699-c54c@gregkh/

Introduced by commit 17c76b0 ("nilfs2: B-tree based block mapping") in
v2.6.30-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9403001ad65ae4f4c5de368bdda3a0636b51d51a]
stable/5.10: [24bf40740a3da6b4056721da34997ae6938f3da1]
stable/5.15: [73d23ecf234b7a6d47fb883f2dabe10e3230b31d]
stable/6.1: [f68523e0f26faade18833fbef577a4295d8e2c94]
stable/6.6: [21839b6fbc3c41b3e374ecbdb0cabbbb2c53cf34]

CVE-2024-47700: ext4: check stripe size compatibility on remount as well

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-47700-00ff@gregkh/

Introduced by commit c3defd9 ("ext4: treat stripe in block unit") in v6.5-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee85e0938aa8f9846d21e4d302c3cf6a2a75110d]
stable/6.6: [faeff8b1ee2eaa5969c8e994d66c3337298cefed]

CVE-2024-47701: ext4: avoid OOB when system.data xattr changes
underneath the filesystem

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-47701-7db5@gregkh/

Introduced by commit e8e948e ("ext4: let ext4_find_entry handle inline
data") in v3.8-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6b72f5d82b1017bad80f9ebf502832fc321d796]
stable/5.10: [7fc22c3b3ffc0e952f5e0062dd11aa6ae76affba]
stable/5.15: [be2e9b111e2790962cc66a177869b4e9717b4e29]
stable/6.1: [ea32883e4a03ed575a2eb7a66542022312bde477]
stable/6.6: [2a6579ef5f2576a940125729f7409cc182f1c8df]

CVE-2024-47702: bpf: Fail verification for sign-extension of packet
data/data_end/data_meta

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-47702-c5c4@gregkh/

Introduced by commit 1f1e864 ("bpf: Handle sign-extenstin ctx member
accesses") in v6.6-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92de36080c93296ef9005690705cba260b9bd68a]

CVE-2024-47703: bpf, lsm: Add check for BPF LSM return value

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-47703-36ea@gregkh/

Introduced by commit 520b7aa ("bpf: lsm: Initialize the BPF LSM
hooks") in v5.7-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d99e198be279045e6ecefe220f5c52f8ce9bfd5]

CVE-2024-47704: drm/amd/display: Check link_res->hpo_dp_link_enc before using it

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-47704-d937@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit e8702d0b ("drm/amd/display:
add enable/disable dp link output to link_hwss") in 5.18-rc1.

Fixed status
mainline: [0beca868cde8742240cd0038141c30482d2b7eb8]
stable/6.6: [be2ca7a2c1561390d28bf2f92654d819659ba510]

CVE-2024-47705: block: fix potential invalid pointer dereference in
blk_add_partition

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-47705-12bc@gregkh/

Introduced by commit b720530 (block: allow partitions on host aware
zone devices) in v5.5.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26e197b7f9240a4ac301dd0ad520c0c697c2ea7d]
stable/5.10: [4bc4272e2506941c3f3d4fb8b0c659ee814dcf6f]
stable/5.15: [cc4d21d9492db4e534d3e01253cf885c90dd2a8b]
stable/6.1: [64cf2a39202ca2d9df5ee70eb310b6141ce2b8ed]
stable/6.6: [80f5bfbb80ea1615290dbc24f49d3d8c86db58fe]

CVE-2024-47706: block, bfq: fix possible UAF for bfqq->bic with merge chain

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-47706-7312@gregkh/

Introduced by commit 36eca89 ("block, bfq: add Early Queue Merge
(EQM)") in v4.12-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18ad4df091dd5d067d2faa8fce1180b79f7041a7]
stable/5.10: [e1277ae780cca4e69ef5468d4582dfd48f0b8320]
stable/5.15: [8aa9de02a4be2e7006e636816ce19b0d667ceaa3]
stable/6.1: [ddbdaad123254fb53e32480cb74a486a6868b1e0]
stable/6.6: [7faed2896d78e48ec96229e73b30b0af6c00a9aa]

CVE-2024-47707: ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()

Announce: https://lore.kernel.org/linux-cve-announce/2024102117-CVE-2024-47707-d8db@gregkh/

Introduced by commit e332bc6 ("ipv6: Don't call with
rt6_uncached_list_flush_dev") in v4.3-rc7.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04ccecfa959d3b9ae7348780d8e379c6486176ac]
stable/6.1: [f2bd9635543ca41533b870f420872819f8331823]
stable/6.6: [0ceb2f2b5c813f932d6e60d3feec5e7e713da783]

CVE-2024-47708: netkit: Assign missing bpf_net_context

Announce: https://lore.kernel.org/linux-cve-announce/2024102117-CVE-2024-47708-2b8f@gregkh/

Introduced by commit 401cb7d ("net: Reference bpf_redirect_info via
task_struct on PREEMPT_RT.") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [157f29152b61ca41809dd7ead29f5733adeced19]

CVE-2024-47709: can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

Announce: https://lore.kernel.org/linux-cve-announce/2024102117-CVE-2024-47709-8e66@gregkh/

Introduced by commit 76fe372 ("can: bcm: Remove proc entry when dev is
unregistered.") in v6.11-rc7.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/6.1 cip/6.1-rt stable/4.19
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [94b0818fa63555a65f6ba107080659ea6bcca63e]
stable/5.10: [5cc00913c1fdcab861c4e65fa20d1f1e1bbbf977]
stable/5.15: [9550baada4c8ef8cebefccc746384842820b4dff]
stable/6.1: [7a145d6ec2124bdb94bd6fc436b342ff6ddf2b70]
stable/6.6: [c3d941cc734e0c8dc486c062926d5249070af5e4]

CVE-2024-47710: sock_map: Add a cond_resched() in sock_hash_free()

Announce: https://lore.kernel.org/linux-cve-announce/2024102118-CVE-2024-47710-3882@gregkh/

Introduced by commit 75e68e5 ("bpf, sockhash: Synchronize delete from
bucket list on map free") in v5.8-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [b1339be951ad31947ae19bc25cb08769bf255100]
stable/5.10: [1a11a1a53255ddab8a903cdae01b9d3eb2c1a47b]
stable/5.15: [984648aac87a6a1c8fd61663bec3f7b61eafad5e]
stable/6.1: [04f62c012e0e4683e572b30baf6004ca0a3f6772]
stable/6.6: [80bd490ac0a3b662a489e17d8eedeb1e905a3d40]

CVE-2024-47711: af_unix: Don't return OOB skb in manage_oob().

Announce: https://lore.kernel.org/linux-cve-announce/2024102118-CVE-2024-47711-349d@gregkh/

Introduced by commit 93c99f2 ("af_unix: Don't stop recv(MSG_DONTWAIT)
if consumed OOB skb is at the head.") in v6.10-rc6.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5aa57d9f2d5311f19434d95b2a81610aa263e23b]

CVE-2024-47712: wifi: wilc1000: fix potential RCU dereference issue in
wilc_parse_join_bss_param

Announce: https://lore.kernel.org/linux-cve-announce/2024102118-CVE-2024-47712-13c2@gregkh/

Introduced by commit 205c503 ("wifi: wilc1000: fix RCU usage in
connect path") in v6.9-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [6d7c6ae1efb1ff68bc01d79d94fdf0388f86cdd8]
stable/5.10: [557418e1704605a81c9e26732449f71b1d40ba1e]
stable/5.15: [bf090f4fe935294361eabd9dc5a949fdd77d3d1b]
stable/6.1: [b040b71d99ee5e17bb7a743dc01cbfcae8908ce1]
stable/6.6: [84398204c5df5aaf89453056cf0647cda9664d2b]

CVE-2024-47713: wifi: mac80211: use two-phase skb reclamation in
ieee80211_do_stop()

Announce: https://lore.kernel.org/linux-cve-announce/2024102119-CVE-2024-47713-2624@gregkh/

Introduced by commit 5061b0c ("mac80211: cooperate more with network
namespaces") in v2.6.32-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d301de12da6e1bb069a9835c38359b8e8135121]
stable/5.10: [f232916fab67ca1c3425926df4a866e59ff26908]
stable/5.15: [acb53a716e492a02479345157c43f21edc8bc64b]
stable/6.1: [db5ca4b42ccfa42d2af7b335ff12578e57775c02]
stable/6.6: [058c9026ad79dc98572442fd4c7e9a36aba6f596]

CVE-2024-47714: wifi: mt76: mt7996: use hweight16 to get correct tx antenna

Announce: https://lore.kernel.org/linux-cve-announce/2024102119-CVE-2024-47714-f88b@gregkh/

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f98c3de92bb05dac4a4969df8a4595ed380b4604]
stable/6.6: [50d87e3b70980abc090676b6b4703fcbd96221f9]

CVE-2024-47715: wifi: mt76: mt7915: fix oops on non-dbdc mt7986

Announce: https://lore.kernel.org/linux-cve-announce/2024102120-CVE-2024-47715-ff4e@gregkh/

Introduced by commit 0335c03 ("wifi: mt76: fix race condition related
to checking tx queue fill status") in v6.7-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [862bf7cbd772c2bad570ef0c5b5556a1330656dd]
stable/6.6: [818dd118f4a997f8b4fe9c010b22402d410a2424]

CVE-2024-47716: ARM: 9410/1: vfp: Use asm volatile in fmrx/fmxr macros

Announce: https://lore.kernel.org/linux-cve-announce/2024102120-CVE-2024-47716-72df@gregkh/

Introduced by commit 4708fb0 ("ARM: vfp: Reimplement VFP exception
entry in C code") in v6.6-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89a906dfa8c3b21b3e5360f73c49234ac1eb885b]
stable/6.6: [9fc60f2bdd43e758bdf0305c0fc83221419ddb3f]

CVE-2024-47717: RISC-V: KVM: Don't zero-out PMU snapshot area before
freeing data

Announce: https://lore.kernel.org/linux-cve-announce/2024102120-CVE-2024-47717-f7fc@gregkh/

Introduced by commit c2f41dd ("RISC-V: KVM: Implement SBI PMU Snapshot
feature") in v6.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47d40d93292d9cff8dabb735bed83d930fa03950]

CVE-2024-47718: wifi: rtw88: always wait for both firmware loading attempts

Announce: https://lore.kernel.org/linux-cve-announce/2024102121-CVE-2024-47718-c7cd@gregkh/

Introduced by commit c8e5695 ("rtw88: load wowlan firmware if wowlan
is supported") in v5.6-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e735a4c6137262bcefe45bb52fde7b1f5fc6c4d]
stable/5.10: [a0c1e2da652cf70825739bc12d49ea15805690bf]
stable/5.15: [ceaab3fb64d6a5426a3db8f87f3e5757964f2532]
stable/6.1: [7887ad11995a4142671cc49146db536f923c8568]
stable/6.6: [1b8178a2ae272256ea0dc4f940320a81003535e2]

CVE-2024-47719: iommufd: Protect against overflow of ALIGN() during
iova allocation

Announce: https://lore.kernel.org/linux-cve-announce/2024102121-CVE-2024-47719-09a2@gregkh/

Introduced by commit 51fe614 ("iommufd: Data structure to provide IOVA
to PFN mapping") in v6.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f6887349b2f829a4121c518aeb064fc922714e4]
stable/6.6: [cd6dd564ae7d99967ef50078216929418160b30e]

CVE-2024-47720: drm/amd/display: Add null check for set_output_gamma
in dcn30_set_output_transfer_func

Announce: https://lore.kernel.org/linux-cve-announce/2024102121-CVE-2024-47720-c007@gregkh/

Introduced by commit d99f138 ("drm/amd/display: Add DCN3 HWSEQ") in v5.9-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08ae395ea22fb3d9b318c8bde28c0dfd2f5fa4d2]
stable/5.15: [44948d3cb943602ba4a0b5ed3c91ae0525838fb1]
stable/6.1: [64886a4e6f1dce843c0889505cf0673b5211e16a]
stable/6.6: [ddf9ff244d704e1903533f7be377615ed34b83e7]

CVE-2024-47721: wifi: rtw89: remove unused C2H event ID
RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading

Announce: https://lore.kernel.org/linux-cve-announce/2024102122-CVE-2024-47721-cb0a@gregkh/

Introduced by commit ff53fce ("wifi: rtw89: wow: update latest PTK GTK
info to mac80211 after resume") in v6.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56310ddb50b190b3390fdc974aec455d0a516bd2]

CVE-2024-47723: jfs: fix out-of-bounds in dbNextAG() and diAlloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024102103-CVE-2024-47723-d904@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e63866a475562810500ea7f784099bfe341e761a]
stable/5.10: [0338e66cba272351ca9d7d03f3628e390e70963b]
stable/5.15: [ead82533278502428883085a787d5a00f15e5eb9]
stable/6.1: [6ce8b6ab44a8b5918c0ee373d4ad19d19017931b]
stable/6.6: [c1ba4b8ca799ff1d99d01f37d7ccb7d5ba5533d2]

CVE-2024-47724: wifi: ath11k: use work queue to process beacon tx event

Announce: https://lore.kernel.org/linux-cve-announce/2024102103-CVE-2024-47724-c771@gregkh/

Introduced by commit 3a415da ("wifi: ath11k: add P2P IE in beacon
template") in v6.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [177b49dbf9c1d8f9f25a22ffafa416fc2c8aa6a3]

CVE-2024-47726: f2fs: fix to wait dio completion

Announce: https://lore.kernel.org/linux-cve-announce/2024102104-CVE-2024-47726-ae53@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [96cfeb0389530ae32ade8a48ae3ae1ac3b6c009d]

CVE-2024-47727: x86/tdx: Fix "in-kernel MMIO" check

Announce: https://lore.kernel.org/linux-cve-announce/2024102105-CVE-2024-47727-1049@gregkh/

Introduced by commit 31d58c4 ("x86/tdx: Handle in-kernel MMIO") in v5.19-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4fc4d01471528da8a9797a065982e05090e1d81]
stable/6.1: [25703a3c980e21548774eea8c8a87a75c5c8f58c]
stable/6.6: [4c0c5dcb5471de5fc8f0a1c4980e5815339e1cee]

CVE-2024-47728: bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error

Announce: https://lore.kernel.org/linux-cve-announce/2024102105-CVE-2024-47728-824a@gregkh/

Introduced by commit 8a67f2d ("bpf: expose bpf_strtol and bpf_strtoul
to all program types") in v6.1-rc1.
Introduced by commit d7a4cb9 ("bpf: Introduce bpf_strtol and
bpf_strtoul helpers") in v5.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b3786a6c5397dc220b1483d8e2f4867743e966f]
stable/6.1: [8397bf78988f3ae9dbebb0200189a62a57264980]
stable/6.6: [a634fa8e480ac2423f86311a602f6295df2c8ed0]

CVE-2024-47729: drm/xe: Use reserved copy engine for user binds on
faulting devices

Announce: https://lore.kernel.org/linux-cve-announce/2024102105-CVE-2024-47729-8985@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [852856e3b6f679c694dd5ec41e5a3c11aa46640b]

CVE-2024-47730: crypto: hisilicon/qm - inject error before stopping queue

Announce: https://lore.kernel.org/linux-cve-announce/2024102106-CVE-2024-47730-2f1e@gregkh/

Introduced by commit 6c6dd58 ("crypto: hisilicon/qm - add controller
reset interface") in v5.8-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b04f06fc0243600665b3b50253869533b7938468]
stable/6.1: [98d3be34c9153eceadb56de50d9f9347e88d86e4]
stable/6.6: [aa3e0db35a60002fb34ef0e4ad203aa59fd00203]

CVE-2024-47731: drivers/perf: Fix ali_drw_pmu driver interrupt status clearing

Announce: https://lore.kernel.org/linux-cve-announce/2024102106-CVE-2024-47731-fd73@gregkh/

Introduced by commit cf7b610 ("drivers/perf: add DDR Sub-System
Driveway PMU driver for Yitian 710 SoC") in v6.1-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3dd920977dccc453c550260c4b7605b280b79c3]
stable/6.1: [24f30b34ff76648d26872dd4eaa002f074225058]
stable/6.6: [3b839d4619042b02eecdfc986484ac6e6be6acbf]

CVE-2024-47732: crypto: iaa - Fix potential use after free bug

Announce: https://lore.kernel.org/linux-cve-announce/2024102106-CVE-2024-47732-f8aa@gregkh/

Introduced by commit b190447 ("crypto: iaa - Add compression mode
management along with fixed mode") in v6.8-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0d3b845a1b10b7b5abdad7ecc69d45b2aab3209]

CVE-2024-47733: netfs: Delete subtree of 'fs/netfs' when netfs module exits

Announce: https://lore.kernel.org/linux-cve-announce/2024102107-CVE-2024-47733-6591@gregkh/

Introduced by commit 7eb5b3e ("netfs, fscache: Move /proc/fs/fscache
to /proc/fs/netfs and put in a symlink") in v6.8-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c58a9575e02c2b90a3180007d57105ceaa7c246]

CVE-2024-47734: bonding: Fix unnecessary warnings and logs from
bond_xdp_get_xmit_slave()

Announce: https://lore.kernel.org/linux-cve-announce/2024102107-CVE-2024-47734-ad75@gregkh/

Introduced by commit 9e2ee5c ("net, bonding: Add XDP support to the
bonding driver") in v5.15-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cbfd45fbcf0cb26d85c981b91c62fe73cdee01c]
stable/5.15: [c1be35e774f8ed415e01209fddd963c5a74e8e9f]
stable/6.1: [6b64197b4bf1a5703a8b105367baf20f1e627a75]
stable/6.6: [ccd3e6ff05e5236d1b9535f23f3e6622e0bb32b8]

CVE-2024-47735: RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled

Announce: https://lore.kernel.org/linux-cve-announce/2024102107-CVE-2024-47735-5d51@gregkh/

Introduced by commit 9a44353 ("IB/hns: Add driver files for hns RoCE
driver") in v4.9-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74d315b5af180220d561684d15897730135733a6]
stable/5.10: [07f0f643d7e570dbe8ef6f5c3367a43e3086a335]
stable/5.15: [29c0f546d3fd66238b42cf25bcd5f193bb1cf794]
stable/6.1: [425589d4af09c49574bd71ac31f811362a5126c3]
stable/6.6: [094a1821903f33fb91de4b71087773ee16aeb3a0]

CVE-2024-47736: erofs: handle overlapped pclusters out of crafted
images properly

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-47736-712a@gregkh/

Introduced by commit 8e6c8fa ("erofs: enable big pcluster feature") in
v5.13-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50]

CVE-2024-47737: nfsd: call cache_put if xdr_reserve_space returns NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-47737-b77e@gregkh/

Introduced by commit ddd1ea5 ("nfsd4: use xdr_reserve_space in
attribute encoding") in v3.16-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d078cbf5c38de83bc31f83c47dcd2184c04a50c7]
stable/5.10: [9f03f0016ff797932551881c7e06ae50e9c39134]
stable/5.15: [9803ab882d565a8fb2dde5999d98866d1c499dfd]
stable/6.1: [81821617312988096f5deccf0f7da6f888e98056]
stable/6.6: [a1afbbb5276f943ad7173d0b4c626b8c75a260da]

CVE-2024-47738: wifi: mac80211: don't use rate mask for offchannel TX either

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-47738-3f0e@gregkh/

Introduced by commit 9df66d5 ("cfg80211: fix default HE tx bitrate
mask in 2G band") in v5.14-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [e7a7ef9a0742dbd0818d5b15fba2c5313ace765b]
stable/6.1: [aafca50e71dc8f3192a5bfb325135a7908f3ef9e]
stable/6.6: [d54455a3a965feb547711aff7afd2ca5deadb99c]

CVE-2024-47739: padata: use integer wrap around to prevent deadlock on
seq_nr overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-47739-8bc4@gregkh/

Introduced by commit bfde23c ("padata: unbind parallel jobs from
specific CPUs") in v5.4-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a22b2812393d93d84358a760c347c21939029a6]
stable/5.10: [46c4079460f4dcaf445860679558eedef4e1bc91]
stable/5.15: [72164d5b648951684b1a593996b37a6083c61d7d]
stable/6.1: [ab205e1c3846326f162180e56825b4ba38ce9c30]
stable/6.6: [1b8cf11b3ca593a8802a51802cd0c28c38501428]

CVE-2024-47740: f2fs: Require FMODE_WRITE for atomic write ioctls

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-47740-ae86@gregkh/

Introduced by commit 88b88a6 ("f2fs: support atomic writes") in v3.18-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f5a100f87f32cb65d4bb1ad282a08c92f6f591e]
stable/5.10: [000bab8753ae29a259feb339b99ee759795a48ac]
stable/5.15: [88ff021e1fea2d9b40b2d5efd9013c89f7be04ac]
stable/6.1: [32f348ecc149e9ca70a1c424ae8fa9b6919d2713]
stable/6.6: [5e0de753bfe87768ebe6744d869caa92f35e5731]

CVE-2024-47741: btrfs: fix race setting file private on concurrent
lseek using same fd

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-47741-5974@gregkh/

Introduced by commit 3c32c72 ("btrfs: use cached state when looking
for delalloc ranges with lseek") in v6.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ee85f5515e86a4e2a2f51969795920733912bad]
stable/6.6: [f56a6d9c267ec7fa558ede7755551c047b1034cd]

CVE-2024-47742: firmware_loader: Block path traversal

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-47742-b72d@gregkh/

Introduced by commit abb139e ("firmware: teach the kernel to load
firmware files directly from the filesystem") in v3.7-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0e5311aa8022107d63c54e2f03684ec097d1394]
stable/5.10: [c30558e6c5c9ad6c86459d9acce1520ceeab9ea6]
stable/5.15: [a77fc4acfd49fc6076e565445b2bc5fdc3244da4]
stable/6.1: [3d2411f4edcb649eaf232160db459bb4770b5251]
stable/6.6: [7420c1bf7fc784e587b87329cc6dfa3dca537aa4]

CVE-2024-47743: KEYS: prevent NULL pointer dereference in find_asymmetric_key()

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-47743-77c3@gregkh/

Introduced by commit 7d30198 ("keys: X.509 public key issuer lookup
without AKID") in v5.17-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70fd1966c93bf3bfe3fe6d753eb3d83a76597eef]
stable/6.1: [3322fa8f2aa40b0b3651034cd541647a600cc6c0]
stable/6.6: [a3765b497a4f5224cb2f7a6a2d3357d3066214ee]

CVE-2024-47744: KVM: Use dedicated mutex to protect kvm_usage_count to
avoid deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2024102111-CVE-2024-47744-7571@gregkh/

Introduced by commit 0bf5049 ("KVM: Drop kvm_count_lock and instead
protect kvm_usage_count with kvm_lock") in v6.3-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44d17459626052a2390457e550a12cb973506b2f]
stable/6.6: [4777225ec89f52bb9ca16a33cfb44c189f1b7b47]

CVE-2024-47745: mm: call the security_mmap_file() LSM hook in remap_file_pages()

Announce: https://lore.kernel.org/linux-cve-announce/2024102111-CVE-2024-47745-42e6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [ea7e2d5e49c05e5db1922387b09ca74aa40f46e2]
stable/6.6: [49d3a4ad57c57227c3b0fd6cd4188b2a5ebd6178]

CVE-2024-47746: fuse: use exclusive lock when FUSE_I_CACHE_IO_MODE is set

Announce: https://lore.kernel.org/linux-cve-announce/2024102111-CVE-2024-47746-f737@gregkh/

Introduced by commit 205c1d8 ("fuse: allow parallel dio writes with
FUSE_DIRECT_IO_ALLOW_MMAP") in v6.9-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f3d8ff457982f4055fe8f7bf19d3821ba22c376]

CVE-2024-47747: net: seeq: Fix use after free vulnerability in ether3
Driver Due to Race Condition

Announce: https://lore.kernel.org/linux-cve-announce/2024102112-CVE-2024-47747-8dca@gregkh/

Introduced by commit 6fd9c53 ("net: seeq: Convert timers to use
timer_setup()") in v4.15-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5109b60ee4fcb2f2bb24f589575e10cc5283ad4]
stable/5.10: [338a0582b28e69460df03af50e938b86b4206353]
stable/5.15: [822c7bb1f6f8b0331e8d1927151faf8db3b33afd]
stable/6.1: [1c57d61a43293252ad732007c7070fdb112545fd]
stable/6.6: [d2abc379071881798d20e2ac1d332ad855ae22f3]

CVE-2024-47748: vhost_vdpa: assign irq bypass producer token correctly

Announce: https://lore.kernel.org/linux-cve-announce/2024102112-CVE-2024-47748-a134@gregkh/

Introduced by commit 2cf1ba9 ("vhost_vdpa: implement IRQ offloading in
vhost_vdpa") in v5.9-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02e9e9366fefe461719da5d173385b6685f70319]
stable/5.10: [0c170b1e918b9afac25e2bbd01eaa2bfc0ece8c0]
stable/5.15: [927a2580208e0f9b0b47b08f1c802b7233a7ba3c]
stable/6.1: [ec5f1b54ceb23475049ada6e7a43452cf4df88d1]
stable/6.6: [ca64edd7ae93402af2596a952e0d94d545e2b9c0]

CVE-2024-47749: RDMA/cxgb4: Added NULL check for lookup_atid

Announce: https://lore.kernel.org/linux-cve-announce/2024102112-CVE-2024-47749-c227@gregkh/

Introduced by commit cfdda9d ("RDMA/cxgb4: Add driver for Chelsio T4
RNIC") in v2.6.35-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e766e6a92410ca269161de059fff0843b8ddd65f]
stable/5.10: [dd598ac57dcae796cb58551074660c39b43fb155]
stable/5.15: [b11318dc8a1ec565300bb1a9073095af817cc508]
stable/6.1: [39cb9f39913566ec5865581135f3e8123ad1aee1]
stable/6.6: [0d50ae281a1712b9b2ca72830a96b8f11882358d]

CVE-2024-47750: RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-47750-390b@gregkh/

Introduced by commit 70f9252 ("RDMA/hns: Use the reserved loopback QPs
to free MR before destroying MPT") in v5.18-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd8489294dd2beefb70f12ec4f6132aeec61a4d0]
stable/6.1: [2ccf1c75d39949d8ea043d04a2e92d7100ea723d]
stable/6.6: [d2d9c5127122745da6e887f451dd248cfeffca33]

CVE-2024-47751: PCI: kirin: Fix buffer overflow in kirin_pcie_parse_port()

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-47751-7a96@gregkh/

Introduced by commit b22dbbb ("PCI: kirin: Support PERST# GPIOs for
HiKey970 external PEX 8606 bridge") in v5.16-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c500a86693a126c9393e602741e348f80f1b0fc5]
stable/6.1: [a5f795f9412854df28e66679c5e6b68b0b79c229]
stable/6.6: [95248d7497bcbfe7deed4805469c6ff6ddd7f9d1]

CVE-2024-47752: media: mediatek: vcodec: Fix H264 stateless decoder
smatch warning

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-47752-1b11@gregkh/

Introduced by commit 06fa5f7 ("media: mtk-vcodec: vdec: support
stateless H.264 decoding") in v5.16-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7878d3a385efab560dce793b595447867fb163f2]
stable/6.6: [c6b9f971b43980de8893610f606d751131fb5d86]

CVE-2024-47753: media: mediatek: vcodec: Fix VP8 stateless decoder
smatch warning

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-47753-45cf@gregkh/

Introduced by commit 7a7ae26 ("media: mediatek: vcodec: support
stateless VP8 decoding") in v5.19-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b113bc7c0e83b32f4dd2d291a2b6c4803e0a2c44]
stable/6.6: [dbe5b7373801c261f3ea118145fbb2caac5f9324]

CVE-2024-47754: media: mediatek: vcodec: Fix H264 multi stateless
decoder smatch warning

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-47754-a412@gregkh/

Introduced by commit 397edc7 ("media: mediatek: vcodec: add h264
decoder driver for mt8186") in v5.19-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9be85491619f1953b8a29590ca630be571941ffa]
stable/6.6: [588bcce9e64cc5138858ab562268eb3943c5b06c]

CVE-2024-47756: PCI: keystone: Fix if-statement expression in ks_pcie_quirk()

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-47756-1c60@gregkh/

Introduced by commit 86f271f ("PCI: keystone: Add workaround for
Errata #i2037 (AM65x SR 1.0)") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.6

Fixed status
mainline: [6188a1c762eb9bbd444f47696eda77a5eae6207a]
stable/5.10: [c289903b7a216df5ea6e1850ddf1b958eea9921d]
stable/5.15: [dc5aeba07395c8dfa29bb878c8ce4d5180427221]
stable/6.1: [23838bef2adb714ec37b2d6141dccf4a3a70bdef]
stable/6.6: [e85ab507882db165c10a858d7f685a0a38f0312e]

CVE-2024-47757: nilfs2: fix potential oob read in nilfs_btree_check_delete()

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-47757-2b1e@gregkh/

Introduced by commit 17c76b0 ("nilfs2: B-tree based block mapping") in
v2.6.30-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9c96351aa6718b42a9f42eaf7adce0356bdb5e8]
stable/5.10: [d20674f31626e0596ae4c1d9401dfb6739b81b58]
stable/5.15: [c4f8554996e8ada3be872dfb8f60e93bcf15fb27]
stable/6.1: [a8abfda768b9f33630cfbc4af6c4214f1e5681b0]
stable/6.6: [257f9e5185eb6de83377caea686c306e22e871f2]

CVE-2024-49850: bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos

Announce: https://lore.kernel.org/linux-cve-announce/2024102151-CVE-2024-49850-4cc6@gregkh/

Introduced by commit 74753e1 ("libbpf: Replace btf__type_by_id() with
btf_type_by_id().") in v5.17-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d2786d65aaa954ebd3fcc033ada433e10da21c4]
stable/6.1: [dc7ce14f00bcd50641f2110b7a32aa6552e0780f]
stable/6.6: [2288b54b96dcb55bedebcef3572bb8821fc5e708]

CVE-2024-49851: tpm: Clean up TPM space after command failure

Announce: https://lore.kernel.org/linux-cve-announce/2024102152-CVE-2024-49851-edd9@gregkh/

Introduced by commit 745b361 ("tpm: infrastructure for TPM spaces") in
v4.12-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3aaebcbb7c6b403416f442d1de70d437ce313a7]
stable/5.10: [2c9b228938e9266a1065a3f4fe5c99b7235dc439]
stable/5.15: [ebc4e1f4492d114f9693950621b3ea42b2f82bec]
stable/6.1: [c84ceb546f30432fccea4891163f7050f5bee5dd]
stable/6.6: [82478cb8a23bd4f97935bbe60d64528c6d9918b4]

CVE-2024-49852: scsi: elx: libefc: Fix potential use after free in
efc_nport_vport_del()

Announce: https://lore.kernel.org/linux-cve-announce/2024102152-CVE-2024-49852-875e@gregkh/

Introduced by commit fcd4273 ("scsi: elx: libefc: SLI and FC PORT
state machine interfaces") in v5.14-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e4b02fad094976763af08fec2c620f4f8edd9ae]
stable/5.15: [16a570f07d870a285b0c0b0d1ca4dff79e8aa5ff]
stable/6.1: [abc71e89170ed32ecf0a5a29f31aa711e143e941]
stable/6.6: [baeb8628ab7f4577740f00e439d3fdf7c876b0ff]

CVE-2024-49853: firmware: arm_scmi: Fix double free in OPTEE transport

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2024-49853-b3ea@gregkh/

Introduced by commit 5f90f18 ("firmware: arm_scmi: Add optee
transport") in v5.18-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e98dba934b2fc587eafb83f47ad64d9053b18ae0]
stable/6.1: [d7f4fc2bc101e666da649605a9ece2bd42529c7a]
stable/6.6: [6699567b0bbb378600a4dc0a1f929439a4e84a2c]

CVE-2024-49854: block, bfq: fix uaf for accessing waker_bfqq after splitting

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2024-49854-1ba5@gregkh/

Introduced by commit 42c306ed ("block, bfq: don't break merge chain in
bfq_split_bfqq()") in 6.12-rc1.
Bug introduced commit was backported to following branches.
stable/5.10 stable/5.15 stable/6.1 stable/6.11 stable/6.6

Fixed status
mainline: [1ba0403ac6447f2d63914fb760c44a3b19c44eaf]
stable/5.15: [63a07379fdb6c72450cb05294461c6016b8b7726]
stable/6.1: [de0456460f2abf921e356ed2bd8da87a376680bd]
stable/6.6: [0780451f03bf518bc032a7c584de8f92e2d39d7f]

CVE-2024-49855: nbd: fix race between timeout and normal completion

Announce: https://lore.kernel.org/linux-cve-announce/2024102153-CVE-2024-49855-8997@gregkh/

Introduced by commit 2895f18 ("nbd: don't clear 'NBD_CMD_INFLIGHT'
flag if request is not completed") in v5.19-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9ea57c91f03bcad415e1a20113bdb2077bcf990]
stable/6.1: [9c25faf72d780a9c71081710cd48759d61ff6e9b]
stable/6.6: [6e73b946a379a1dfbb62626af93843bdfb53753d]

CVE-2024-49856: x86/sgx: Fix deadlock in SGX NUMA node search

Announce: https://lore.kernel.org/linux-cve-announce/2024102154-CVE-2024-49856-f5f7@gregkh/

Introduced by commit 901ddbb ("x86/sgx: Add a basic NUMA allocation
scheme to sgx_alloc_epc_page()") in v5.13-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c936844010466535bd46ea4ce4656ef17653644]
stable/5.15: [40fb64257dab507d86b5f1f2a62f3669ef0c91a8]
stable/6.1: [20c96d0aaabfe361fc2a11c173968dc67feadbbf]
stable/6.6: [fb2d057539eda67ec7cfc369bf587e6518a9b99d]

CVE-2024-49857: wifi: iwlwifi: mvm: set the cipher for secured NDP ranging

Announce: https://lore.kernel.org/linux-cve-announce/2024102154-CVE-2024-49857-7233@gregkh/

Introduced by commit 626be4b ("wifi: iwlwifi: mvm: modify
iwl_mvm_ftm_set_secured_ranging() parameters") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a949075d4bbf1ca83ccdeaa6ef4ac2ce7526c5f4]

CVE-2024-49858: efistub/tpm: Use ACPI reclaim memory for event log to
avoid corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024102123-CVE-2024-49858-b7c4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit 33b6d034 ("efi: call
get_event_log before ExitBootServices") in 4.16-rc1.

Fixed status
mainline: [77d48d39e99170b528e4f2e9fc5d1d64cdedd386]
stable/5.10: [f76b69ab9cf04358266e3cea5748c0c2791fbb08]
stable/5.15: [11690d7e76842f29b60fbb5b35bc97d206ea0e83]
stable/6.1: [5b22c038fb2757c652642933de5664da471f8cb7]
stable/6.6: [19fd2f2c5fb36b61506d3208474bfd8fdf1cada3]

CVE-2024-49859: f2fs: fix to check atomic_file in f2fs ioctl interfaces

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49859-9917@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [bfe5c02654261bfb8bd9cb174a67f3279ea99e58]
stable/6.1: [26b07bd2e1f124b0e430c8d250023f7205c549c3]
stable/6.6: [7cb51731f24b216b0b87942f519f2c67a17107ee]

CVE-2024-49860: ACPI: sysfs: validate return type of _STR method

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49860-2a48@gregkh/

Introduced by commit d1efe3c ("ACPI: Add new sysfs interface to export
device description") in v3.7-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bb1e7d027413835b086aed35bc3f0713bc0f72b]
stable/5.10: [4b081991c4363e072e1748efed0bbec8a77daba5]
stable/5.15: [0cdfb9178a3bba843c95c2117c82c15f1a64b9ce]
stable/6.1: [5c8d007c14aefc3f2ddf71e4c40713733dc827be]
stable/6.6: [f0921ecd4ddc14646bb5511f49db4d7d3b0829f0]

CVE-2024-49861: bpf: Fix helper writes to read-only maps

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49861-5288@gregkh/

Introduced by commit 57c3bb7 ("bpf: Introduce ARG_PTR_TO_{INT,LONG}
arg types") in v5.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32556ce93bc45c730829083cb60f95a2728ea48b]
stable/6.6: [a2c8dc7e21803257e762b0bf067fd13e9c995da0]

CVE-2024-49862: powercap: intel_rapl: Fix off by one in get_rpi()

Announce: https://lore.kernel.org/linux-cve-announce/2024102125-CVE-2024-49862-b995@gregkh/

Introduced by commit 98ff639 ("powercap: intel_rapl: Support per
Interface primitive information") in v6.5-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95f6580352a7225e619551febb83595bcb77ab17]
stable/6.6: [288cbc505e2046638c615c36357cb78bc9fee1e0]

CVE-2024-49863: vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-49863-6a74@gregkh/

Introduced by commit 3f8ca2e ("vhost/scsi: Extract common handling
code from control queue handler") in v4.20-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [221af82f606d928ccef19a16d35633c63026f1be]
stable/5.10: [6592347f06e2b19a624270a85ad4b3ae48c3b241]
stable/5.15: [46128370a72c431df733af5ebb065c4d48c9ad39]
stable/6.1: [ace9c778a214da9c98d7b69d904d1b0816f4f681]
stable/6.6: [25613e6d9841a1f9fb985be90df921fa99f800de]

CVE-2024-49864: rxrpc: Fix a race between socket set up and I/O thread creation

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-49864-5158@gregkh/

Introduced by commit a275da6 ("rxrpc: Create a per-local endpoint
receive queue and I/O thread") in v6.2-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc212465326e8587325f520a052346f0b57360e6]
stable/6.6: [cdf4bbbdb956d7426f687f38757ebca2a2759a0f]

CVE-2024-49865: drm/xe/vm: move xa_alloc to prevent UAF

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-49865-ae89@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74231870cf4976f69e83aa24f48edb16619f652f]

CVE-2024-49866: tracing/timerlat: Fix a race during cpuhp processing

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-49866-159b@gregkh/

Introduced by commit c8895e2 ("trace/osnoise: Support hotplug
operations") in v5.14-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [829e0c9f0855f26b3ae830d17b24aec103f7e915]
stable/5.15: [322920b53dc11f9c2b33397eb3ae5bc6a175b60d]
stable/6.1: [ce25f33ba89d6eefef64157655d318444580fa14]
stable/6.6: [a6e9849063a6c8f4cb2f652a437e44e3ed24356c]

CVE-2024-49867: btrfs: wait for fixup workers before stopping cleaner
kthread during umount

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-49867-b47a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc2.

Fixed status
mainline: [41fd1e94066a815a7ab0a7025359e9b40e4b3576]
stable/5.10: [70b60c8d9b42763d6629e44f448aa5d8ae477d61]
stable/5.15: [4c98fe0dfa2ae83c4631699695506d8941db4bfe]
stable/6.1: [9da40aea63f8769f28afb91aea0fac4cf6fbbb65]
stable/6.6: [ed87190e9d9c80aad220fb6b0b03a84d22e2c95b]

CVE-2024-49868: btrfs: fix a NULL pointer dereference when failed to
start a new trasacntion

Announce: https://lore.kernel.org/linux-cve-announce/2024102113-CVE-2024-49868-8dce@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc2.
It seems as if this bug was introduced by commit 0b246afa ("btrfs: root->fs_info
cleanup, add fs_info convenience variables") in 4.10-rc1.

Fixed status
mainline: [c3b47f49e83197e8dffd023ec568403bcdbb774b]
stable/5.10: [d73d48acf36f57362df7e4f9d76568168bf5e944]
stable/5.15: [37fee9c220b92c3b7bf22b51c51dde5364e7590b]
stable/6.1: [d13249c0df7aab885acb149695f82c54c0822a70]
stable/6.6: [7ad0c5868f2f0418619089513d95230c66cb7eb4]

CVE-2024-49869: btrfs: send: fix buffer overflow detection when
copying path to cache entry

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-49869-f804@gregkh/

Introduced by commit c0247d2 ("btrfs: send: annotate struct
name_cache_entry with __counted_by()") in v6.11-rc4.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96c6ca71572a3556ed0c37237305657ff47174b7]

CVE-2024-49870: cachefiles: fix dentry leak in cachefiles_open_file()

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-49870-44f0@gregkh/

Introduced by commit 1f08c92 ("cachefiles: Implement backing file
wrangling") in v5.17-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da6ef2dffe6056aad3435e6cf7c6471c2a62187c]
stable/6.1: [d32ff64c872d7e08e893c32ba6a2374583444410]
stable/6.6: [c7d10fa7d7691558ff967668494672415f5fa151]

CVE-2024-49871: Input: adp5589-keys - fix NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-49871-1293@gregkh/

Introduced by commit 30df385 ("Input: adp5589-keys - use
devm_add_action_or_reset() for register clear") in v5.11-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb5cc65f973661241e4a2b7390b429aa7b330c69]
stable/5.15: [4449fedb8a710043fc0925409eba844c192d4337]
stable/6.1: [34e304cc53ae5d3c8e3f08b41dd11e0d4f3e01ed]
stable/6.6: [7c3f04223aaf82489472d614c6decee5a1ce8d7f]

CVE-2024-49872: mm/gup: fix memfd_pin_folios alloc race panic

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-49872-16d4@gregkh/

Introduced by commit 89c1905 ("mm/gup: introduce memfd_pin_folios()
for pinning memfd folios") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce645b9fdc78ec5d28067286e92871ddae6817d5]

CVE-2024-49873: mm/filemap: fix filemap_get_folios_contig THP panic

Announce: https://lore.kernel.org/linux-cve-announce/2024102114-CVE-2024-49873-3190@gregkh/

Introduced by commit 89c1905 ("mm/gup: introduce memfd_pin_folios()
for pinning memfd folios") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c225c4f6056b46a8a5bf2ed35abf17a2d6887691]

CVE-2024-49874: i3c: master: svc: Fix use after free vulnerability in
svc_i3c_master Driver Due to Race Condition

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-49874-6deb@gregkh/

Introduced by commit 0f74f8b ("i3c: Make i3c_master_unregister()
return void") in v6.4-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61850725779709369c7e907ae8c7c75dc7cec4f3]
stable/6.6: [4ac637122930cc4ab7e2c22e364cf3aaf96b05b1]

CVE-2024-49875: nfsd: map the EBADMSG to nfserr_io to avoid warning

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-49875-02ba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [340e61e44c1d2a15c42ec72ade9195ad525fd048]
stable/5.10: [0ea4333c679f333e23956de743ad17387819d3f2]
stable/5.15: [825789ca94602543101045ad3aad19b2b60c6b2a]
stable/6.1: [6fe058502f8864649c3d614b06b2235223798f48]
stable/6.6: [f7d8ee9db94372b8235f5f22bb24381891594c42]

CVE-2024-49876: drm/xe: fix UAF around queue destruction

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-49876-7fe2@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d2be279f1ca9e7288282d4214f16eea8a727cdb]

CVE-2024-49877: ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-49877-038a@gregkh/

Introduced by commit cf76c78 ("ocfs2: don't put and assigning null to
bh allocated outside") in v4.20-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st stable/4.19

Fixed status
mainline: [33b525cef4cff49e216e4133cc48452e11c0391e]
stable/5.10: [61b84013e560382cbe7dd56758be3154d43a3988]
stable/5.15: [df944dc46d06af65a75191183d52be017e6b9dbe]
stable/6.1: [01cb2e751cc61ade454c9bc1aaa2eac1f8197112]
stable/6.6: [d52c5652e7dcb7a0648bbb8642cc3e617070ab49]

CVE-2024-49878: resource: fix region_intersects() vs add_memory_driver_managed()

Announce: https://lore.kernel.org/linux-cve-announce/2024102115-CVE-2024-49878-8099@gregkh/

Introduced by commit c221c0b ("device-dax: "Hotplug" persistent memory
for use like normal RAM") in v5.1-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4afe4183ec77f230851ea139d91e5cf2644c68b]
stable/5.10: [1d5f85f1b7db79c75c9e07d6571ce2a7bdf725c4]
stable/5.15: [8a6fef7d22a1d952aed68584d3fcc0d018d2bdc3]
stable/6.1: [4b90d2eb451b357681063ba4552b10b39d7ad885]
stable/6.6: [393331e16ce205e036e58b3d8ca4ee2e635f21d9]

CVE-2024-49879: drm: omapdrm: Add missing check for alloc_ordered_workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-49879-b16c@gregkh/

Introduced by commit 2f95bc6 ("drm: omapdrm: Perform
initialization/cleanup at probe/remove time") in v4.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e794b7b9b92977365c693760a259f8eef940c536]
stable/5.10: [2bda89735199683b03f55b807bd1e31a3857520b]
stable/5.15: [e60b0d3b5aa2e8d934deca9e11215af84e632bc9]
stable/6.1: [f37a1d9e5e22d5489309c3cd2db476dcdcc6530c]
stable/6.6: [b57b53e8ffcdfda87d954fc4187426a54fe75a3d]

CVE-2024-49880: ext4: fix off by one issue in alloc_flex_gd()

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-49880-11cd@gregkh/

Introduced by commit 665d3e0 ("ext4: reduce unnecessary memory
allocation in alloc_flex_gd()") in v6.8-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6121258c2b33ceac3d21f6a221452692c465df88]

CVE-2024-49881: ext4: update orig_path in ext4_find_extent()

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-49881-bfd0@gregkh/

Introduced by commit 10809df ("ext4: teach ext4_ext_find_extent() to
realloc path if necessary") in v3.18-rc2.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b4b2dcace35f618fe361a87bae6f0d13af31bc1]
stable/5.10: [6766937d0327000ac1b87c97bbecdd28b0dd6599]
stable/5.15: [a9fcb1717d75061d3653ed69365c8d45331815cd]
stable/6.1: [6801ed1298204d16a38571091e31178bfdc3c679]
stable/6.6: [f55ecc58d07a6c1f6d6d5b5af125c25f8da0bda2]

CVE-2024-49882: ext4: fix double brelse() the buffer of the extents path

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-49882-4169@gregkh/

Introduced by commit ecb94f5 ("ext4: collapse a single extent tree
block into the inode if possible") in v3.7-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcaa6c31134c0f515600111c38ed7750003e1b9c]
stable/5.10: [b6c29c8f3d7cb67b505f3b2f6c242d52298d1f2e]
stable/5.15: [32bbb59e3f18facd7201bef110010bf35819b8c3]
stable/6.1: [78bbc3d15b6f443acb26e94418c445bac940d414]
stable/6.6: [68a69cf60660c73990c1875f94a5551600b04775]

CVE-2024-49883: ext4: aovid use-after-free in ext4_ext_insert_extent()

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-49883-ca93@gregkh/

Introduced by commit 10809df ("ext4: teach ext4_ext_find_extent() to
realloc path if necessary") in v3.18-rc2.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a164f3a432aae62ca23d03e6d926b122ee5b860d]
stable/5.10: [5e811066c5ab709b070659197dccfb80ab650ddd]
stable/5.15: [9df59009dfc6d9fc1bd9ddf6c5ab6e56d6ed887a]
stable/6.1: [51db04892a993cace63415be99848970a0f15ef2]
stable/6.6: [8162ee5d94b8c0351be0a9321be134872a7654a1]

CVE-2024-49884: ext4: fix slab-use-after-free in ext4_split_extent_at()

Announce: https://lore.kernel.org/linux-cve-announce/2024102116-CVE-2024-49884-fa56@gregkh/

Introduced by commit dfe5080 ("ext4: drop EXT4_EX_NOFREE_ON_ERR from
rest of extents handling code") in v3.18-rc2.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c26ab35702f8cd0cdc78f96aa5856bfb77be798f]
stable/5.10: [e52f933598b781d291b9297e39c463536da0e185]
stable/5.15: [cafcc1bd62934547c76abf46c6d0d54f135006fe]
stable/6.1: [a5401d4c3e2a3d25643c567d26e6de327774a2c9]
stable/6.6: [8fe117790b37c84c651e2bad9efc0e7fda73c0e3]

CVE-2024-49885: mm, slub: avoid zeroing kmalloc redzone

Announce: https://lore.kernel.org/linux-cve-announce/2024102117-CVE-2024-49885-d5d0@gregkh/

Introduced by commit 946fa0d ("mm/slub: extend redzone check to extra
allocated kmalloc space than requested") in v6.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59090e479ac78ae18facd4c58eb332562a23020e]

CVE-2024-49886: platform/x86: ISST: Fix the KASAN report slab-out-of-bounds bug

Announce: https://lore.kernel.org/linux-cve-announce/2024102117-CVE-2024-49886-3477@gregkh/

Introduced by commit 9a1aac8 ("platform/x86: ISST: PUNIT device
mapping with Sub-NUMA clustering") in v6.0-rc1.
Fixed in v6.12-rc2.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [7d59ac07ccb58f8f604f8057db63b8efcebeb3de]
stable/5.15: [1973c4d8ee0782a808303d75e3be9c12baaacd97]
stable/6.1: [cdd03afcb6eda3103da5a0948d3db12372f62910]
stable/6.6: [8176d4878ed2af5d93ddd0e971e24c412124d38b]

CVE-2024-49887: f2fs: fix to don't panic system for no free segment
fault injection

Announce: https://lore.kernel.org/linux-cve-announce/2024102117-CVE-2024-49887-04ba@gregkh/

Introduced by commit 8b10d36 ("f2fs: introduce FAULT_NO_SEGMENT") in v6.9-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65a6ce4726c27b45600303f06496fef46d00b57f]

CVE-2024-49888: bpf: Fix a sdiv overflow issue

Announce: https://lore.kernel.org/linux-cve-announce/2024102117-CVE-2024-49888-027c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [7dd34d7b7dcf9309fc6224caf4dd5b35bedddcb7]

CVE-2024-49889: ext4: avoid use-after-free in ext4_ext_show_leaf()

Announce: https://lore.kernel.org/linux-cve-announce/2024102117-CVE-2024-49889-6140@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [4e2524ba2ca5f54bdbb9e5153bea00421ef653f5]
stable/5.10: [b0cb4561fc4284d04e69c8a66c8504928ab2484e]
stable/5.15: [4999fed877bb64e3e7f9ab9996de2ca983c41928]
stable/6.1: [2eba3b0cc5b8de624918d21f32b5b8db59a90b39]
stable/6.6: [34b2096380ba475771971a778a478661a791aa15]

CVE-2024-49890: drm/amd/pm: ensure the fw_info is not null before using it

Announce: https://lore.kernel.org/linux-cve-announce/2024102118-CVE-2024-49890-ba65@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit 3bace359 ("drm/amd/powerplay:
add hardware manager sub-component") in 4.5-rc1.

Fixed status
mainline: [186fb12e7a7b038c2710ceb2fb74068f1b5d55a4]
stable/5.10: [29f388945770bd0a6c82711436b2bc98b0dfac92]
stable/5.15: [9550d8d6f19fac7623f044ae8d9503825b325497]
stable/6.1: [fd5f4ac1a986f0e7e9fa019201b5890554f87bcf]
stable/6.6: [b511474f49588cdca355ebfce54e7eddbf7b75a5]

CVE-2024-49891: scsi: lpfc: Validate hdwq pointers before
dereferencing in reset/errata paths

Announce: https://lore.kernel.org/linux-cve-announce/2024102118-CVE-2024-49891-931a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [2be1d4f11944cd6283cb97268b3e17c4424945ca]

CVE-2024-49892: drm/amd/display: Initialize get_bytes_per_element's default to 1

Announce: https://lore.kernel.org/linux-cve-announce/2024102118-CVE-2024-49892-b04d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks commits 057fc695 and b04641a introduced. Both commits were
merged in 5.4-rc1.

Fixed status
mainline: [4067f4fa0423a89fb19a30b57231b384d77d2610]
stable/5.10: [f921335123f6620c3dce5c96fbb95f18524a021c]
stable/5.15: [1f9f8186e239222f1c8d3dd73bf3bc6ae86c5e76]
stable/6.1: [a23d6029e730f8a151b1a34afb169baac1274583]
stable/6.6: [c7630935d9a4986e8c0ed91658a781b7a77d73f7]

CVE-2024-49893: drm/amd/display: Check stream_status before it is used

Announce: https://lore.kernel.org/linux-cve-announce/2024102118-CVE-2024-49893-72a4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit 00c3911 ("drm/amd/display:
Add misc DC changes for DCN401") in 6.11-rc1.

Fixed status
mainline: [58a8ee96f84d2c21abb85ad8c22d2bbdf59bd7a9]

CVE-2024-49894: drm/amd/display: Fix index out of bounds in degamma
hardware format translation

Announce: https://lore.kernel.org/linux-cve-announce/2024102118-CVE-2024-49894-08a0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit 44c6f2e ("drm/amd/display:
Handle HDR use cases.") in 4.17-rc1.

Fixed status
mainline: [b7e99058eb2e86aabd7a10761e76cae33d22b49f]
stable/5.10: [c130a3c09e3746c1a09ce26c20d21d449d039b1d]
stable/5.15: [c6979719012a90e5b8e3bc31725fbfdd0b9b2b79]
stable/6.1: [2495c8e272d84685403506833a664fad932e453a]
stable/6.6: [122e3a7a8c7bcbe3aacddd6103f67f9f36bed473]

CVE-2024-49895: drm/amd/display: Fix index out of bounds in DCN30
degamma hardware format translation

Announce: https://lore.kernel.org/linux-cve-announce/2024102119-CVE-2024-49895-b244@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 03f54d7d3 ("drm/amd/display:
Add DCN3 DPP")
in 5.9-rc1.

Fixed status
mainline: [bc50b614d59990747dd5aeced9ec22f9258991ff]
stable/5.10: [ad89f83343a501890cf082c8a584e96b59fe4015]
stable/5.15: [de6ee4f9e6b1c36b4fdc7c345c1a6de9e246093e]
stable/6.1: [f3ccd855b4395ce65f10dd37847167f52e122b70]
stable/6.6: [0d38a0751143afc03faef02d55d31f70374ff843]

CVE-2024-49896: drm/amd/display: Check stream before comparing them

Announce: https://lore.kernel.org/linux-cve-announce/2024102119-CVE-2024-49896-f220@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [35ff747c86767937ee1e0ca987545b7eed7a0810]
stable/5.10: [0167d570f6a0b38689c4a0e50bf79c518d827500]
stable/5.15: [14db8692afe1aa2143b673856bb603713d8ea93f]
stable/6.1: [e8da54b7f8a17e44e67ea6d1037f35450af28115]
stable/6.6: [42d31a33643813cce55ee1ebbad3a2d0d24a08e0]

CVE-2024-49897: drm/amd/display: Check phantom_stream before it is used

Announce: https://lore.kernel.org/linux-cve-announce/2024102119-CVE-2024-49897-42cd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 235c6763 ("drm/amd/display:
add DCN32/321
specific files for Display Core") in 6.0-rc1.

Fixed status
mainline: [3718a619a8c0a53152e76bb6769b6c414e1e83f4]

CVE-2024-49898: drm/amd/display: Check null-initialized variables

Announce: https://lore.kernel.org/linux-cve-announce/2024102119-CVE-2024-49898-adff@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit 235c676 ("drm/amd/display:
add DCN32/321 specific files for Display Core") in 6.0-rc1.

Fixed status
mainline: [367cd9ceba1933b63bc1d87d967baf6d9fd241d2]

CVE-2024-49899: drm/amd/display: Initialize denominators' default to 1

Announce: https://lore.kernel.org/linux-cve-announce/2024102119-CVE-2024-49899-3daa@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
get_bytes_per_element in display_rq_dlg_calc_20.c was added by commit
728c06986a ("drm/amd/display: Add DCN2 changes to DML") in 5.3-rc1.
get_bytes_per_element in dml1_display_rq_dlg_calc.c was added by commit
6d04ee9dc1 ("drm/amd/display: Restructuring and cleaning up DM") in 4.15-rc1.
CalculateVMGroupAndRequestTimes in dml2_core_shared.c was added by commit
70839da63 ("drm/amd/display: Add new DCN401 sources") in 6.11-rc1.

Fixed status
mainline: [b995c0a6de6c74656a0c39cd57a0626351b13e3c]

CVE-2024-49900: jfs: Fix uninit-value access of new_ea in ea_buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024102120-CVE-2024-49900-1a7d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [2b59ffad47db1c46af25ccad157bb3b25147c35c]
stable/5.10: [8b1dcf25c26d42e4a68c4725ce52a0543c7878cc]
stable/5.15: [d7444f91a9f93eaa48827087ed0f3381c194181d]
stable/6.1: [6041536d18c5f51a84bc37cd568cbab61870031e]
stable/6.6: [c076b3746224982eebdba5c9e4b1467e146c0d64]

CVE-2024-49901: drm/msm/adreno: Assign msm_gpu->pdev earlier to avoid nullptrs

Announce: https://lore.kernel.org/linux-cve-announce/2024102120-CVE-2024-49901-4522@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [16007768551d5bfe53426645401435ca8d2ef54f]
stable/6.6: [9288a9676c529ad9c856096db68fad812499bc4a]

CVE-2024-49902: jfs: check if leafidx greater than num leaves per dmap tree

Announce: https://lore.kernel.org/linux-cve-announce/2024102120-CVE-2024-49902-0b84@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [d64ff0d2306713ff084d4b09f84ed1a8c75ecc32]
stable/5.10: [2451e5917c56be45d4add786e2a059dd9c2c37c4]
stable/5.15: [25d2a3ff02f22e215ce53355619df10cc5faa7ab]
stable/6.1: [058aa89b3318be3d66a103ba7c68d717561e1dc6]
stable/6.6: [7fff9a9f866e99931cf6fa260288e55d01626582]

CVE-2024-49903: jfs: Fix uaf in dbFreeBits

Announce: https://lore.kernel.org/linux-cve-announce/2024102120-CVE-2024-49903-6af0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [d6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234]
stable/5.10: [fd026b6b6758d5569705c02540b40f3bbf822b9a]
stable/5.15: [e7ae14f7ee76c6ef5a48aebab1a278ad78f42619]
stable/6.1: [0c238da83f56bb895cab1e5851d034ac45b158d1]
stable/6.6: [4218b31ecc7af7e191768d32e32ed4386d8f9b76]

CVE-2024-49904: drm/amdgpu: add list empty check to avoid null pointer issue

Announce: https://lore.kernel.org/linux-cve-announce/2024102120-CVE-2024-49904-121b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit f5e4cc84 ("drm/amdgpu:
implement RAS ACA driver framework") in 6.9-rc1.

Fixed status
mainline: [4416377ae1fdc41a90b665943152ccd7ff61d3c5]

CVE-2024-49905: drm/amd/display: Add null check for 'afb' in
amdgpu_dm_plane_handle_cursor_update (v2)

Announce: https://lore.kernel.org/linux-cve-announce/2024102121-CVE-2024-49905-7f47@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit 03a66367 ("drm/amd/display:
use FB pitch to fill dc_cursor_attributes") in 5.11-rc1.

Fixed status
mainline: [cd9e9e0852d501f169aa3bb34e4b413d2eb48c37]
stable/6.1: [bd0e24e5e608ccb9fdda300bb974496d6d8cf57d]
stable/6.6: [75839e2365b666ff4e1b9047e442cab138eac4f6]

CVE-2024-49906: drm/amd/display: Check null pointer before try to access it

Announce: https://lore.kernel.org/linux-cve-announce/2024102121-CVE-2024-49906-5cae@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [1b686053c06ffb9f4524b288110cf2a831ff7a25]

CVE-2024-49907: drm/amd/display: Check null pointers before using dc->clk_mgr

Announce: https://lore.kernel.org/linux-cve-announce/2024102121-CVE-2024-49907-d177@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 4d55b0d ("drm/amd/display: Add
DCN3 CLK_MGR") in 5.9-rc1.

Fixed status
mainline: [95d9e0803e51d5a24276b7643b244c7477daf463]
stable/5.10: [8d54001f8dccd56146973f23f3ab2ba037a21251]
stable/5.15: [a545a9403e04c6e17fdc04a26a61d9feebbba106]
stable/6.1: [a2773e0a4b79e7a6463abdffaf8cc4f24428ba18]
stable/6.6: [9641bc4adf8446034e490ed543ae7e9833cfbdf5]

CVE-2024-49908: drm/amd/display: Add null check for 'afb' in
amdgpu_dm_update_cursor (v2)

Announce: https://lore.kernel.org/linux-cve-announce/2024102121-CVE-2024-49908-a7fe@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 66eba12a ("drm/amd/display: Do cursor
programming with rest of pipe") in 6.11-rc1.

Fixed status
mainline: [0fe20258b4989b9112b5e9470df33a0939403fd4]

CVE-2024-49909: drm/amd/display: Add NULL check for function pointer
in dcn32_set_output_transfer_func

Announce: https://lore.kernel.org/linux-cve-announce/2024102121-CVE-2024-49909-5d54@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 235c676 ("drm/amd/display: add
DCN32/321 specific files for Display Core") in 6.0-rc1.

Fixed status
mainline: [28574b08c70e56d34d6f6379326a860b96749051]

CVE-2024-49910: drm/amd/display: Add NULL check for function pointer
in dcn401_set_output_transfer_func

Announce: https://lore.kernel.org/linux-cve-announce/2024102122-CVE-2024-49910-b56b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 70839da ("drm/amd/display: Add
new DCN401 sources") in 6.11-rc1.

Fixed status
mainline: [dd340acd42c24a3f28dd22fae6bf38662334264c]

CVE-2024-49911: drm/amd/display: Add NULL check for function pointer
in dcn20_set_output_transfer_func

Announce: https://lore.kernel.org/linux-cve-announce/2024102122-CVE-2024-49911-8636@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was introduced by commit 7ed4e6352 ("drm/amd/display: Add
DCN2 HW Sequencer and Resource") in 5.3-rc1.

Fixed status
mainline: [62ed6f0f198da04e884062264df308277628004f]

CVE-2024-49912: drm/amd/display: Handle null 'stream_status' in
'planes_changed_for_existing_stream'

Announce: https://lore.kernel.org/linux-cve-announce/2024102122-CVE-2024-49912-987d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was introduced by commit a5e39ae ("drm/amd/display: Add
function for validate and update new stream") in 6.2-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [8141f21b941710ecebe49220b69822cab3abd23d]
stable/6.1: [c4b699b93496c423b0e5b584d4eb4ab849313bcf]
stable/6.6: [4778982c73d6c9f3fdbdbc6b6c8aa18df98251af]

CVE-2024-49913: drm/amd/display: Add null check for
top_pipe_to_program in commit_planes_for_stream

Announce: https://lore.kernel.org/linux-cve-announce/2024102122-CVE-2024-49913-229b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if first bug introduced commit might be 71b81f127 ("drm/amd/display:
decouple global lock out of pipe control lock") in 5.7-rc1.

Fixed status
mainline: [66d71a72539e173a9b00ca0b1852cbaa5f5bf1ad]
stable/5.10: [1ebfa6663807c144be8c8b6727375012409d2356]
stable/5.15: [8ab59527852a6f7780aad6185729550ca0569122]
stable/6.1: [40193ff73630adf76bc0d82398f7d90fb576dba4]
stable/6.6: [e47e563c6f0db7d792a559301862c19ead0dfc2f]

CVE-2024-49914: drm/amd/display: Add null check for
pipe_ctx->plane_state in dcn20_program_pipe

Announce: https://lore.kernel.org/linux-cve-announce/2024102122-CVE-2024-49914-477e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit 7ed4e6352c1 ("drm/amd/display: Add DCN2
HW Sequencer and Resource") in 5.3-rc1.

Fixed status
mainline: [8e4ed3cf1642df0c4456443d865cff61a9598aa8]

CVE-2024-49915: drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw

Announce: https://lore.kernel.org/linux-cve-announce/2024102123-CVE-2024-49915-42ec@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected function was added by commit 235c6763 ("drm/amd/display: add
DCN32/321 specific files for Display Core") in 6.0-rc1.

Fixed status
mainline: [c395fd47d1565bd67671f45cca281b3acc2c31ef]

CVE-2024-49916: drm/amd/display: Add NULL check for clk_mgr and
clk_mgr->funcs in dcn401_init_hw

Announce: https://lore.kernel.org/linux-cve-announce/2024102123-CVE-2024-49916-3384@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected function was added by commit 70839da63 ("drm/amd/display:
Add new DCN401 sources") in 6.11-rc1.

Fixed status
mainline: [4b6377f0e96085cbec96eb7f0b282430ccdd3d75]

CVE-2024-49917: drm/amd/display: Add NULL check for clk_mgr and
clk_mgr->funcs in dcn30_init_hw

Announce: https://lore.kernel.org/linux-cve-announce/2024102123-CVE-2024-49917-f643@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit d99f1387 ("drm/amd/display:
Add DCN3 HWSEQ") in 5.9-rc1.

Fixed status
mainline: [cba7fec864172dadd953daefdd26e01742b71a6a]

CVE-2024-49918: drm/amd/display: Add null check for head_pipe in
dcn32_acquire_idle_pipe_for_head_pipe_in_layer

Announce: https://lore.kernel.org/linux-cve-announce/2024102123-CVE-2024-49918-4c25@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit b03b44b6 ('Partially revert
"drm/amd/display: update add plane to context logic with a new
algorithm"') in 6.7-rc1.

Fixed status
mainline: [ac2140449184a26eac99585b7f69814bd3ba8f2d]

CVE-2024-49919: drm/amd/display: Add null check for head_pipe in
dcn201_acquire_free_pipe_for_layer

Announce: https://lore.kernel.org/linux-cve-announce/2024102123-CVE-2024-49919-42fb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit 3f68c01b ("drm/amd/display:
add cyan_skillfish display support") in 5.16-rc1.

Fixed status
mainline: [f22f4754aaa47d8c59f166ba3042182859e5dff7]

CVE-2024-49920: drm/amd/display: Check null pointers before multiple uses

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49920-038d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [fdd5ecbbff751c3b9061d8ebb08e5c96119915b4]

CVE-2024-49921: drm/amd/display: Check null pointers before used

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49921-621b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [be1fb44389ca3038ad2430dac4234669bc177ee3]

CVE-2024-49922: drm/amd/display: Check null pointers before using them

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49922-5435@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit 4562236b3 ("drm/amd/dc: Add dc
display driver (v2)") in 4.15-rc1.

Fixed status
mainline: [1ff12bcd7deaeed25efb5120433c6a45dd5504a8]

CVE-2024-49923: drm/amd/display: Pass non-null to
dcn20_validate_apply_pipe_split_flags

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49923-3462@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
dcn20_resource.c was added by commit 7ed4e6352 ("drm/amd/display:
Add DCN2 HW Sequencer and Resource") in 5.3-rc1.
dcn21_resource.c was added by commit 6f4e6361c ("drm/amd/display:
Add Renoir resource (v2)") in 5.4-rc1.

Fixed status
mainline: [5559598742fb4538e4c51c48ef70563c49c2af23]

CVE-2024-49924: fbdev: pxafb: Fix possible use after free in pxafb_task()

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49924-93af@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [4a6921095eb04a900e0000da83d9475eb958e61e]
stable/5.10: [e6897e299f57b103e999e62010b88e363b3eebae]
stable/5.15: [4cda484e584be34d55ee17436ebf7ad11922b97a]
stable/6.1: [3c0d416eb4bef705f699213cee94bf54b6acdacd]
stable/6.6: [fdda354f60a576d52dcf90351254714681df4370]

CVE-2024-49925: fbdev: efifb: Register sysfs groups through driver core

Announce: https://lore.kernel.org/linux-cve-announce/2024102124-CVE-2024-49925-b469@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [95cdd538e0e5677efbdf8aade04ec098ab98f457]
stable/6.6: [36bfefb6baaa8e46de44f4fd919ce4347337620f]

CVE-2024-49926: rcu-tasks: Fix access non-existent percpu rtpcp
variable in rcu_tasks_need_gpcb()

Announce: https://lore.kernel.org/linux-cve-announce/2024102125-CVE-2024-49926-f707@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [fd70e9f1d85f5323096ad313ba73f5fe3d15ea41]

CVE-2024-49927: x86/ioapic: Handle allocation failures gracefully

Announce: https://lore.kernel.org/linux-cve-announce/2024102125-CVE-2024-49927-86cf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [830802a0fea8fb39d3dc9fb7d6b5581e1343eb1f]
stable/5.15: [e479cb835feeb2abff97f25766e23b96a6eabe28]
stable/6.1: [ec862cd843faa6f0e84a7a07362f2786446bf697]
stable/6.6: [077e1b7cd521163ded545987bbbd389519aeed71]

CVE-2024-49928: wifi: rtw89: avoid reading out of bounds when loading
TX power FW elements

Announce: https://lore.kernel.org/linux-cve-announce/2024102125-CVE-2024-49928-05d6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit e3ec7017f6a2 ("rtw89: add Realtek
802.11ax driver") in 5.16-rc1.

Fixed status
mainline: [ed2e4bb17a4884cf29c3347353d8aabb7265b46c]

CVE-2024-49929: wifi: iwlwifi: mvm: avoid NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024102125-CVE-2024-49929-1031@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [557a6cd847645e667f3b362560bd7e7c09aac284]
stable/6.6: [6dcadb2ed3b76623ab96e3e7fbeda1a374d01c28]

CVE-2024-49930: wifi: ath11k: fix array out-of-bound access in SoC stats

Announce: https://lore.kernel.org/linux-cve-announce/2024102125-CVE-2024-49930-34e8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit d5c65159f ("ath11k: driver for
Qualcomm IEEE 802.11ax devices") in 5.6-rc1.

Fixed status
mainline: [69f253e46af98af17e3efa3e5dfa72fcb7d1983d]
stable/5.10: [0f26f26944035ec67546a944f182cbad6577a9c0]
stable/5.15: [4dd732893bd38cec51f887244314e2b47f0d658f]
stable/6.1: [73e235728e515faccc104b0153b47d0f263b3344]
stable/6.6: [7a552bc2f3efe2aaf77a85cb34cdf4a63d81a1a7]

CVE-2024-49931: wifi: ath12k: fix array out-of-bound access in SoC stats

Announce: https://lore.kernel.org/linux-cve-announce/2024102126-CVE-2024-49931-f484@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit d88991320 ("wifi: ath12k: driver for Qualcomm
Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [e106b7ad13c1d246adaa57df73edb8f8b8acb240]
stable/6.6: [d0e4274d9dc9f8409d56d622cd3ecf7b6fd49e2f]

CVE-2024-49932: btrfs: don't readahead the relocation inode on RST

Announce: https://lore.kernel.org/linux-cve-announce/2024102126-CVE-2024-49932-e139@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [04915240e2c3a018e4c7f23418478d27226c8957]

CVE-2024-49933: blk_iocost: fix more out of bound shifts

Announce: https://lore.kernel.org/linux-cve-announce/2024102126-CVE-2024-49933-f918@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit 7caa47151a ("blkcg: implement
blk-iocost") in 5.4-rc1.

Fixed status
mainline: [9bce8005ec0dcb23a58300e8522fe4a31da606fa]
stable/5.10: [1f61d509257d6a05763d05bf37943b35306522b1]
stable/5.15: [f4ef9bef023d5c543cb0f3194ecacfd47ef590ec]
stable/6.1: [59121bb38fdc01434ea3fe361ee02b59f036227f]
stable/6.6: [1ab2cfe19700fb3dde4c7dfec392acff34db3120]

CVE-2024-49934: fs/inode: Prevent dump_mapping() accessing invalid
dentry.d_name.name

Announce: https://lore.kernel.org/linux-cve-announce/2024102126-CVE-2024-49934-0ac9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 3e9d80a ("mm,fs: split dump_mapping()
out from dump_page()") in 5.17-rc1.

Fixed status
mainline: [7f7b850689ac06a62befe26e1fd1806799e7f152]

CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()

Announce: https://lore.kernel.org/linux-cve-announce/2024102126-CVE-2024-49935-004d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [0a2ed70a549e61c5181bad5db418d223b68ae932]
stable/5.15: [92e5661b7d0727ab912b76625a88b33fdb9b609a]
stable/6.1: [68a599da16ebad442ce295d8d2d5c488e3992822]
stable/6.6: [68a8e45743d6a120f863fb14b72dc59616597019]

CVE-2024-49936: net/xen-netback: prevent UAF in xenvif_flush_hash()

Announce: https://lore.kernel.org/linux-cve-announce/2024102127-CVE-2024-49936-bf74@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit 40d8abde ("xen-netback:
add control protocol implementation") in 4.7-rc1.

Fixed status
mainline: [0fa5e94a1811d68fbffa0725efe6d4ca62c03d12]
stable/5.10: [a7f0073fcd12ed7de185ef2c0af9d0fa1ddef22c]
stable/5.15: [a0465723b8581cad27164c9073fd780904cd22d4]
stable/6.1: [efcff6ce7467f01f0753609f420333f3f2ceceda]
stable/6.6: [143edf098b80669d05245b2f2367dd156a83a2c5]

CVE-2024-49937: wifi: cfg80211: Set correct chandef when starting CAC

Announce: https://lore.kernel.org/linux-cve-announce/2024102127-CVE-2024-49937-74ee@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [20361712880396e44ce80aaeec2d93d182035651]
stable/6.1: [95f32191e50b75e0f75fae1bb925cdf51d8df0a3]
stable/6.6: [04053e55dd50741cf6c59b9bbaa4238218c05c70]

CVE-2024-49938: wifi: ath9k_htc: Use __skb_set_length() for resetting
urb before resubmit

Announce: https://lore.kernel.org/linux-cve-announce/2024102127-CVE-2024-49938-5a61@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [94745807f3ebd379f23865e6dab196f220664179]
stable/5.10: [b02eb7c86ff2ef1411c3095ec8a52b13f68db04f]
stable/5.15: [012ae530afa0785102360de452745d33c99a321b]
stable/6.1: [6a875220670475d9247e576c15dc29823100a4e4]
stable/6.6: [e37e348835032d6940ec89308cc8996ded691d2d]

CVE-2024-49939: wifi: rtw89: avoid to add interface to list twice when SER

Announce: https://lore.kernel.org/linux-cve-announce/2024102127-CVE-2024-49939-b39d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit e3ec7017f6a ("rtw89: add Realtek
802.11ax driver") in 5.16-rc1.

Fixed status
mainline: [7dd5d2514a8ea58f12096e888b0bd050d7eae20a]
stable/6.6: [fdc73f2cfbe897f4733156df211d79ced649b23c]

CVE-2024-49940: l2tp: prevent possible tunnel refcount underflow

Announce: https://lore.kernel.org/linux-cve-announce/2024102127-CVE-2024-49940-1c88@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [24256415d18695b46da06c93135f5b51c548b950]

CVE-2024-49941: gpiolib: Fix potential NULL pointer dereference in
gpiod_get_label()

Announce: https://lore.kernel.org/linux-cve-announce/2024102128-CVE-2024-49941-442e@gregkh/

Introduced by commit 5a646e0 ("gpiolib: Return label, if set, for IRQ
only line") in v6.11-rc1.
Introduced by commit a86d276 ("gpiolib: fix the speed of descriptor
label setting with SRCU") in v6.9.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b99b5ab885993bff010ebcd93be5e511c56e28a]

CVE-2024-49942: drm/xe: Prevent null pointer access in xe_migrate_copy

Announce: https://lore.kernel.org/linux-cve-announce/2024102128-CVE-2024-49942-b97c@gregkh/

Introduced by commit 266c858 ("drm/xe/xe2: Handle flat ccs move for
igfx.") in v6.8-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7257d9c9a3c6cfe26c428e9b7ae21d61f2f55a79]

CVE-2024-49943: drm/xe/guc_submit: add missing locking in wedged_fini

Announce: https://lore.kernel.org/linux-cve-announce/2024102128-CVE-2024-49943-f733@gregkh/

Introduced by commit 8ed9aaa ("drm/xe: Force wedged state and block GT
reset upon any GPU hang") in v6.11-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [790533e44bfc7af929842fccd9674c9f424d4627]

CVE-2024-49944: sctp: set sk_state back to CLOSED if autobind fails in
sctp_listen_start

Announce: https://lore.kernel.org/linux-cve-announce/2024102128-CVE-2024-49944-240a@gregkh/

Introduced by commit 5e8f3f7 ("sctp: simplify sctp listening code") in
v2.6.30-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8beee4d8dee76b67c75dc91fd8185d91e845c160]
stable/5.10: [dd70c8a89ef99c3d53127fe19e51ef47c3f860fa]
stable/5.15: [e7a8442195e8ebd97df467ce4742980ab57edcce]
stable/6.1: [9230a59eda0878d7ecaa901d876aec76f57bd455]
stable/6.6: [7f64cb5b4d8c872296eda0fdce3bcf099eec7aa7]

CVE-2024-49945: net/ncsi: Disable the ncsi work before freeing the
associated structure

Announce: https://lore.kernel.org/linux-cve-announce/2024102128-CVE-2024-49945-d756@gregkh/

Introduced by commit 2d283bd ("net/ncsi: Resource management") in v4.8-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0ffa68c70b367358b2672cdab6fa5bc4c40de2c]

CVE-2024-49946: ppp: do not assume bh is held in ppp_channel_bridge_input()

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-49946-762f@gregkh/

Introduced by commit 4cf476c ("ppp: add PPPIOCBRIDGECHAN and
PPPIOCUNBRIDGECHAN ioctls") in v5.11-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aec7291003df78cb71fd461d7b672912bde55807]
stable/5.15: [176dd41e8c2bd997ed3d66568a3362e69ecce99b]
stable/6.1: [635deca1800a68624f185dc1e04a8495b48cf185]
stable/6.6: [f9620e2a665aa642625bd2501282bbddff556bd7]

CVE-2024-49947: net: test for not too small csum_start in
virtio_net_hdr_to_skb()

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-49947-b46e@gregkh/

Introduced by commit 9181d6f ("net: add more sanity check in
virtio_net_hdr_to_skb()") in v6.8-rc1.
Fixed in v6.12-rc2.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [49d14b54a527289d09a9480f214b8c586322310a]
stable/6.6: [d9dfd41e32ccc5198033ddd1ff1516822dfefa5a]

CVE-2024-49948: net: add more sanity checks to qdisc_pkt_len_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-49948-ba28@gregkh/

Introduced by commit 1def923 ("net_sched: more precise pkt_len
computation") in v3.9-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab9a9a9e9647392a19e7a885b08000e89c86b535]
stable/5.10: [566a931a1436d0e0ad13708ea55479b95426213c]
stable/5.15: [2415f465730e48b6e38da1c7c097317bf5dd2d20]
stable/6.1: [27a8fabc54d2f960d47bdfbebf2bdc6e8a92a4c4]
stable/6.6: [9b0ee571d20a238a22722126abdfde61f1b2bdd0]

CVE-2024-49949: net: avoid potential underflow in qdisc_pkt_len_init() with UFO

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-49949-c792@gregkh/

Introduced by commit cf9acc9 ("net: virtio_net_hdr_to_skb: count
transport header in UFO") in v5.16-rc2.
Fixed in v6.12-rc2.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [c20029db28399ecc50e556964eaba75c43b1e2f1]
stable/5.10: [ba26060a29d3ca1bfc737aa79f7125128f35147c]
stable/5.15: [939c88cbdc668dadd8cfa7a35d9066331239041c]
stable/6.1: [d6114993e0a89fde84a60a60a8329a571580b174]
stable/6.6: [25ab0b87dbd89cecef8a9c60a02bb97832e471d1]

CVE-2024-49950: Bluetooth: L2CAP: Fix uaf in l2cap_connect

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-49950-bbf4@gregkh/

Introduced by commit 7b064ed ("Bluetooth: Fix authentication if acl
data comes before remote feature evt") in v3.8-rc6.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [333b4fd11e89b29c84c269123f871883a30be586]
stable/6.6: [b90907696c30172b809aa3dd2f0caffae761e4c6]

CVE-2024-49951: Bluetooth: MGMT: Fix possible crash on mgmt_index_removed

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-49951-a620@gregkh/

Introduced by commit 7cf5c29 ("Bluetooth: hci_sync: Refactor remove
Adv Monitor") in v6.0-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f53e1c9c726d83092167f2226f32bd3b73f26c21]
stable/6.6: [4883296505aa7e4863c6869b689afb6005633b23]

CVE-2024-49952: netfilter: nf_tables: prevent nf_skb_duplicated corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-49952-4b61@gregkh/

Introduced by commit d877f07 ("netfilter: nf_tables: add nft_dup
expression") in v4.3-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92ceba94de6fb4cee2bf40b485979c342f44a492]
stable/5.10: [531754952f5dfc4b141523088147071d6e6112c4]
stable/5.15: [38e3fd0c4a2616052eb3c8f4e6f32d1ff47cd663]
stable/6.1: [b40b027a0c0cc1cb9471a13f9730bb2fff12a15b]
stable/6.6: [4e3542f40f3a94efa59ea328e307c50601ed7065]

CVE-2024-49953: net/mlx5e: Fix crash caused by calling
__xfrm_state_delete() twice

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-49953-5cf8@gregkh/

Introduced by commit b2f7b01 ("net/mlx5e: Simulate missing IPsec TX
limits hardware functionality") in v6.4-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b124695db40d5c9c5295a94ae928a8d67a01c3d]
stable/6.6: [fab615ac9fcb8589222303099975d464d8857527]

CVE-2024-49954: static_call: Replace pointless WARN_ON() in
static_call_module_notify()

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-49954-cea5@gregkh/

Introduced by commit 9183c3f ("static_call: Add inline static call
infrastructure") in v5.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe513c2ef0a172a58f158e2e70465c4317f0a9a2]
stable/5.15: [bc9356513d56b688775497b7ac6f2b967f46a80c]
stable/6.1: [ea2cdf4da093d0482f0ef36ba971e2e0c7673425]
stable/6.6: [e67534bd31d79952b50e791e92adf0b3e6c13b8c]

CVE-2024-49955: ACPI: battery: Fix possible crash when unregistering a
battery hook

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-49955-f517@gregkh/

Introduced by commit fa93854 ("battery: Add the battery hooking API")
in v4.17-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76959aff14a0012ad6b984ec7686d163deccdc16]
stable/5.10: [da964de4c18199e14b961b5b2e5e6570552a313c]
stable/5.15: [07b98400cb0285a6348188aa8c5ec6a2ae0551f7]
stable/6.1: [ca1fb7942a287b40659cc79551a1de54a2c2e7d5]
stable/6.6: [ce31847f109c3a5b2abdd19d7bcaafaacfde53de]

CVE-2024-49956: gfs2: fix double destroy_workqueue error

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-49956-5278@gregkh/

Introduced by commit 30e388d ("gfs2: Switch to a per-filesystem glock
workqueue") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6cb9df81a2c462b89d2f9611009ab43ae8717841]

CVE-2024-49957: ocfs2: fix null-ptr-deref when journal load failed.

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-49957-3302@gregkh/

Introduced by commit f6f50e2 ("jbd2: Fail to load a journal if it is
too short") in v2.6.32-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5784d9fcfd43bd853654bb80c87ef293b9e8e80a]
stable/5.10: [bf605ae98dab5c15c5b631d4d7f88898cb41b649]
stable/5.15: [ff55291fb36779819211b596da703389135f5b05]
stable/6.1: [82dfdd1e31e774578f76ce6dc90c834f96403a0f]
stable/6.6: [86a89e75e9e4dfa768b97db466ad6bedf2e7ea5b]

CVE-2024-49958: ocfs2: reserve space for inline xattr before attaching
reflink tree

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-49958-1bc6@gregkh/

Introduced by commit ef962df ("ocfs2: xattr: fix inlined xattr
reflink") in v3.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ca60b86f57a4d9648f68418a725b3a7de2816b0]
stable/5.10: [aac31d654a0a31cb0d2fa36ae694f4e164a52707]
stable/5.15: [020f5c53c17f66c0a8f2d37dad27ace301b8d8a1]
stable/6.1: [5c2072f02c0d75802ec28ec703b7d43a0dd008b5]
stable/6.6: [637c00e06564a945e9d0edb3d78d362d64935f9f]

CVE-2024-49959: jbd2: stop waiting for space when
jbd2_cleanup_journal_tail() returns error

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-49959-ce09@gregkh/

Introduced by commit 8c3f25d ("jbd2: don't give up looking for space
so easily in __jbd2_log_wait_for_space") in v2.6.28-rc4.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5cacdc6f2bb2a9bf214469dd7112b43dd2dd68a]
stable/5.10: [481e8f18a290e39e04ddb7feb2bb2a2cc3b213ed]
stable/5.15: [ec7f8337c98ad281020ad1f11ba492462d80737a]
stable/6.1: [70bae48377a2c4296fd3caf4caf8f11079111019]
stable/6.6: [1c62dc0d82c62f0dc8fcdc4843208e522acccaf5]

CVE-2024-49960: ext4: fix timer use-after-free on failed mount

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-49960-f9cb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit 618f0031 ("ext4:
fix memory leak in ext4_fill_super") in 5.14-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [0ce160c5bdb67081a62293028dc85758a8efb22a]
stable/6.6: [9203817ba46ebba7c865c8de2aba399537b6e891]

CVE-2024-49961: media: i2c: ar0521: Use cansleep version of gpiod_set_value()

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-49961-7541@gregkh/

Introduced by commit 852b50a ("media: On Semi AR0521 sensor driver")
in v6.0-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bee1aed819a8cda47927436685d216906ed17f62]
stable/6.1: [9f08876d766755a92f1b9543ae3ee21bfc596fb8]
stable/6.6: [625a77b68c96349c16fcc1faa42784313e0b1a85]

CVE-2024-49962: ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in
acpi_db_convert_to_package()

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-49962-8d16@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by 9957510 ("ACPICA: Linuxize: Export
debugger files to Linux") in 4.4-rc1.

Fixed status
mainline: [a5242874488eba2b9062985bf13743c029821330]
stable/5.10: [cbb67e245dacd02b5e1d82733892647df1523982]
stable/5.15: [1c9b8775062f8d854a80caf186af57fc617d454c]
stable/6.1: [f282db38953ad71dd4f3f8877a4e1d37e580e30a]
stable/6.6: [4588ea78d3904bebb613b0bb025669e75800f546]

CVE-2024-49963: mailbox: bcm2835: Fix timeout during suspend mode

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-49963-a198@gregkh/

Introduced by commit 0bae6af ("mailbox: Enable BCM2835 mailbox
support") in v4.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc09f007caed3b2f6a3b6bd7e13777557ae22bfd]
stable/5.10: [32ee78823dea2d54adaf6e05f86622eba359e091]
stable/5.15: [df293ea78740a41384d648041f38f645700288e1]
stable/6.1: [90320cfc07b7d6e7a58fd8168f6380ec52ff0251]
stable/6.6: [10a58555e0bb5cc4673c8bb73b8afc5fa651f0ac]

CVE-2024-49964: mm/hugetlb: fix memfd_pin_folios free_huge_pages leak

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-49964-e06e@gregkh/

Introduced by commit 89c1905 ("mm/gup: introduce memfd_pin_folios()
for pinning memfd folios") in v6.11-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c56b6f3d801d7ec8965993342bdd9e2972b6cb8e]

CVE-2024-49965: ocfs2: remove unreasonable unlock in ocfs2_read_blocks

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-49965-9ed0@gregkh/

Introduced by commit cf76c78 ("ocfs2: don't put and assigning null to
bh allocated outside") in v4.20-rc1.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st stable/4.19

Fixed status
mainline: [c03a82b4a0c935774afa01fd6d128b444fd930a1]
stable/5.10: [3f1ca6ba5452d53c598a45d21267a2c0c221eef3]
stable/5.15: [f55a33fe0fb5274ef185fd61947cf142138958af]
stable/6.1: [81aba693b129e82e11bb54f569504d943d018de9]
stable/6.6: [84543da867c967edffd5065fa910ebf56aaae49d]

CVE-2024-49966: ocfs2: cancel dqi_sync_work before freeing oinfo

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-49966-2893@gregkh/

Introduced by commit 171bf93 ("ocfs2: Periodic quota syncing") in v2.6.29-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35fccce29feb3706f649726d410122dd81b92c18]
stable/5.10: [14114d8148db07e7946fb06b56a50cfa425e26c7]
stable/5.15: [4173d1277c00baeedaaca76783e98b8fd0e3c08d]
stable/6.1: [bbf41277df8b33fbedf4750a9300c147e8f104eb]
stable/6.6: [ef768020366f47d23f39c4f57bcb03af6d1e24b3]

CVE-2024-49967: ext4: no need to continue when the number of entries is 1

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-49967-a58a@gregkh/

Introduced by commit ac27a0e ("[PATCH] ext4: initial copy of files
from ext3") in v2.6.20.16.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a00a393d6a7fb1e745a41edd09019bd6a0ad64c]
stable/5.10: [133ff0d78f1b160de011647bb65807195ca5d1ca]
stable/5.15: [aca593e6070e21979430c344e9cb0b272a9e7e10]
stable/6.1: [a02d7f5b24193aed451ac67aad3453472e79dc78]
stable/6.6: [2d64e7dada22ab589d1ac216a3661074d027f25e]

CVE-2024-49968: ext4: filesystems without casefold feature cannot be
mounted with siphash

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-49968-ce10@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [985b67cd86392310d9e9326de941c22fc9340eec]

CVE-2024-49969: drm/amd/display: Fix index out of bounds in DCN30
color transformation

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-49969-cf83@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 03f54d7d ("drm/amd/display:
Add DCN3 DPP") in 5.9-rc1.

Fixed status
mainline: [d81873f9e715b72d4f8d391c8eb243946f784dfc]
stable/5.10: [7ab69af56a23859b647dee69fa1052c689343621]
stable/5.15: [c13f9c62015c56a938304cef6d507227ea3e0039]
stable/6.1: [0f1e222a4b41d77c442901d166fbdca967af0d86]
stable/6.6: [929506d5671419cffd8d01e9a7f5eae53682a838]

CVE-2024-49970: drm/amd/display: Implement bounds check for stream
encoder creation in DCN401

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-49970-a345@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 70839da6 ("drm/amd/display: Add
new DCN401 sources") in 6.11-rc1.

Fixed status
mainline: [bdf606810210e8e07a0cdf1af3c467291363b295]

CVE-2024-49971: drm/amd/display: Increase array size of dummy_boolean

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-49971-ad07@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit a00e85713 ("drm/amd/display:
Update DML2.1 generated code") in 6.11-rc1.

Fixed status
mainline: [6d64d39486197083497a01b39e23f2f8474b35d3]

CVE-2024-49972: drm/amd/display: Deallocate DML memory if allocation fails

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-49972-9c6d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit 669d6b07 ("drm/amd/display:
avoid large on-stack structures") in 6.11-rc1.

Fixed status
mainline: [892abca6877a96c9123bb1c010cafccdf8ca1b75]

CVE-2024-49973: r8169: add tally counter fields added with RTL8125

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-49973-8824@gregkh/

Introduced by commit f1bce4a ("r8169: add support for RTL8125") in v5.4-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ced8e8b8f40accfcce4a2bbd8b150aa76d5eff9a]
stable/5.10: [991e8b0bab669b7d06927c3e442b3352532e8581]
stable/5.15: [21950321ad33d7613b1453f4c503d7b1871deb61]
stable/6.1: [fe44b3bfbf0c74df5712f44458689d0eccccf47d]
stable/6.6: [1c723d785adb711496bc64c24240f952f4faaabf]

CVE-2024-49974: NFSD: Limit the number of concurrent async COPY operations

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-49974-bda6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [aadc3bbea163b6caaaebfdd2b6c4667fbc726752]

CVE-2024-49975: uprobes: fix kernel info leak via "[uprobes]" vma

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-49975-4533@gregkh/

Introduced by commit d4b3b63 ("uprobes/core: Allocate XOL slots for
uprobes use") in v3.5-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34820304cc2cd1804ee1f8f3504ec77813d29c8e]
stable/5.10: [f561b48d633ac2e7d0d667020fc634a96ade33a0]
stable/5.15: [21cb47db1ec9765f91304763a24565ddc22d2492]
stable/6.1: [24141df5a8615790950deedd926a44ddf1dfd6d8]
stable/6.6: [5b981d8335e18aef7908a068529a3287258ff6d8]

CVE-2024-49976: tracing/timerlat: Drop interface_lock in stop_kthread()

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-49976-83a3@gregkh/

Introduced by commit 5bfbcd1 ("tracing/timerlat: Add interface_lock
around clearing of kthread in stop_kthread()") in v6.11-rc7.
Fixed in v6.12-rc2.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b484a02c9cedf8703eff8f0756f94618004bd165]
stable/6.6: [a4a05ceffe8fad68b45de38fe2311bda619e76e2]

CVE-2024-49977: net: stmmac: Fix zero-division error when disabling tc cbs

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-49977-b657@gregkh/

Introduced by commit b8c4336 ("net: stmmac: No need to calculate speed
divider when offload is disabled") in v6.10-rc5.
Fixed in v6.12-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [675faf5a14c14a2be0b870db30a70764df81e2df]
stable/5.10: [e33fe25b1efe4f2e6a5858786dbc82ae4c44ed4c]
stable/5.15: [b0da9504a528f05f97d926b4db74ff21917a33e9]
stable/6.1: [5d43e1ad4567d67af2b42d3ab7c14152ffed25c6]
stable/6.6: [03582f4752427f60817d896f1a827aff772bd31e]

CVE-2024-49978: gso: fix udp gso fraglist segmentation after pull from frag_list

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-49978-2bff@gregkh/

Introduced by commit 9fd1ff5 ("udp: Support UDP fraglist GRO/GSO.") in v5.6-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1e40ac5b5e9077fe1f7ae0eb88034db0f9ae1ab]
stable/6.1: [080e6c9a3908de193a48f646c5ce1bfb15676ffc]
stable/6.6: [af3122f5fdc0d00581d6e598a668df6bf54c9daa]

CVE-2024-49979: net: gso: fix tcp fraglist segmentation after pull
from frag_list

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-49979-f897@gregkh/

Introduced by commit bee88cd ("net: add support for segmenting TCP
fraglist GSO packets") in v6.10-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17bd3bd82f9f79f3feba15476c2b2c95a9b11ff8]

CVE-2024-49980: vrf: revert "vrf: Remove unnecessary RCU-bh critical section"

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-49980-da73@gregkh/

Introduced by commit 504fc6f ("vrf: Remove unnecessary RCU-bh critical
section") in v6.6-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b04c4d9eb4f25b950b33218e33b04c94e7445e51]
stable/6.6: [718a752bd746b3f4dd62516bb437baf73d548415]

CVE-2024-49981: media: venus: fix use after free bug in venus_remove
due to race condition

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-49981-0fb7@gregkh/

Introduced by commit af2c383 ("[media] media: venus: adding core part
and helper functions") in v4.13-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5a85ed88e043474161bbfe54002c89c1cb50ee2]
stable/5.10: [60b6968341a6dd5353554f3e72db554693a128a5]
stable/5.15: [bf6be32e2d39f6301ff1831e249d32a8744ab28a]
stable/6.1: [2a541fcc0bd2b05a458e9613376df1289ec11621]
stable/6.6: [b0686aedc5f1343442d044bd64eeac7e7a391f4e]

CVE-2024-49982: aoe: fix the potential use-after-free problem in more places

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-49982-c6b7@gregkh/

Introduced by commit f98364e ("aoe: fix the potential use-after-free
problem in aoecmd_cfg_pkts") in v6.9-rc1.
Fixed in v6.12-rc2.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [6d6e54fc71ad1ab0a87047fd9c211e75d86084a3]
stable/5.10: [f63461af2c1a86af4217910e47a5c46e3372e645]
stable/5.15: [07b418d50ccbbca7e5d87a3a0d41d436cefebf79]
stable/6.1: [bc2cbf7525ac288e07d465f5a1d8cb8fb9599254]
stable/6.6: [acc5103a0a8c200a52af7d732c36a8477436a3d3]

CVE-2024-49983: ext4: drop ppath from ext4_ext_replay_update_ex() to
avoid double-free

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-49983-275e@gregkh/

Introduced by commit 8016e29 ("ext4: fast commit recovery path") in v5.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c0f4cc84d3a601c99bc5e6e6eb1cbda542cce95]
stable/5.10: [8c26d9e53e5fbacda0732a577e97c5a5b7882aaf]
stable/5.15: [a34bed978364114390162c27e50fca50791c568d]
stable/6.1: [6367d3f04c69e2b8770b8137bd800e0784b0abbc]
stable/6.6: [1b558006d98b7b0b730027be0ee98973dd10ee0d]

CVE-2024-49984: drm/v3d: Prevent out of bounds access in performance
query extensions

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-49984-e47f@gregkh/

Introduced by commit bae7cb5 ("drm/v3d: Create a CPU job extension for
the reset performance query job") in v6.8-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f32b5128d2c440368b5bf3a7a356823e235caabb]

CVE-2024-49985: i2c: stm32f7: Do not prepare/unprepare clock during
runtime suspend/resume

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-49985-0b2a@gregkh/

Introduced by commit 4e7bca6 ("i2c: i2c-stm32f7: add PM Runtime
support") in v5.0-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [048bbbdbf85e5e00258dfb12f5e368f908801d7b]
stable/5.10: [9b8bc33ad64192f54142396470cc34ce539a8940]
stable/5.15: [1883cad2cc629ded4a3556c0bbb8b42533ad8764]
stable/6.1: [c2024b1a583ab9176c797ea1e5f57baf8d5e2682]
stable/6.6: [22a1f8a5b56ba93d3e8b7a1dafa24e01c8bb48ba]

CVE-2024-49986: platform/x86: x86-android-tablets: Fix use after free
on platform_device_register() errors

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-49986-19eb@gregkh/

Introduced by commit 5eba014 ("platform/x86: x86-android-tablets: Add
support for instantiating platform-devs") in v5.17-rc1.
Introduced by commit e2200d3 ("platform/x86: x86-android-tablets: Add
gpio_keys support to x86_android_tablet_init()") in v6.4-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fae3129c0c08e72b1fe93e61fd8fd203252094a]
stable/6.6: [aac871e493fc8809e60209d9899b1af07e9dbfc8]

CVE-2024-49987: bpftool: Fix undefined behavior in qsort(NULL, 0, ...)

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-49987-e897@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit d0fe92fb ("tools: bpftool:
print netfilter link info") in 6.4-rc1.

Fixed status
mainline: [f04e2ad394e2755d0bb2d858ecb5598718bf00d5]
stable/6.6: [c2d9f9a7837ab29ccae0c42252f17d436bf0a501]

CVE-2024-49988: ksmbd: add refcnt to ksmbd_conn struct

Announce: https://lore.kernel.org/linux-cve-announce/2024102137-CVE-2024-49988-89d5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [ee426bfb9d09b29987369b897fe9b6485ac2be27]
stable/6.6: [18f06bacc197d4ac9b518ad1c69999bc3d83e7aa]

CVE-2024-49989: drm/amd/display: fix double free issue during amdgpu
module unload

Announce: https://lore.kernel.org/linux-cve-announce/2024102137-CVE-2024-49989-8165@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 54618888d1ea7a ("drm/amd/display:
break down dc_link.c") in 6.3-rc1.

Fixed status
mainline: [20b5a8f9f4670a8503aa9fa95ca632e77c6bf55d]
stable/6.6: [cf6f3ebd6312d465fee096d1f58089b177c7c67f]

CVE-2024-49990: drm/xe/hdcp: Check GSC structure validity

Announce: https://lore.kernel.org/linux-cve-announce/2024102137-CVE-2024-49990-c3e9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit 4af50beb4e ("drm/xe:
Use gsc_proxy_init_done to check proxy status") in 6.10-rc1.

Fixed status
mainline: [b4224f6bae3801d589f815672ec62800a1501b0d]

CVE-2024-49991: drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024102137-CVE-2024-49991-59d4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [c86ad39140bbcb9dc75a10046c2221f657e8083b]
stable/6.6: [30ceb873cc2e97348d9da2265b2d1ddf07f682e1]

CVE-2024-49992: drm/stm: Avoid use-after-free issues with crtc and plane

Announce: https://lore.kernel.org/linux-cve-announce/2024102137-CVE-2024-49992-fd66@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [19dd9780b7ac673be95bf6fd6892a184c9db611f]
stable/6.1: [d02611ff001454358be6910cb926799e2d818716]
stable/6.6: [0a1741d10da29aa84955ef89ae9a03c4b6038657]

CVE-2024-49993: iommu/vt-d: Fix potential lockup if qi_submit_sync
called with 0 count

Announce: https://lore.kernel.org/linux-cve-announce/2024102138-CVE-2024-49993-5b57@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit 8a1d82462 ("iommu/vt-d:
Multiple descriptors per qi_submit_sync()") in 5.8-rc1.

Fixed status
mainline: [3cf74230c139f208b7fb313ae0054386eee31a81]
stable/5.10: [de9e7f68762585f7532de8a06de9485bf39dbd38]
stable/5.15: [8840dc73ac9e1028291458ef1429ec3c2524ffec]
stable/6.1: [e03f00aa4a6c0c49c17857a4048f586636abdc32]
stable/6.6: [dfdbc5ba10fb792c9d6d12ba8cb6e465f97365ed]

CVE-2024-49994: block: fix integer overflow in BLKSECDISCARD

Announce: https://lore.kernel.org/linux-cve-announce/2024102138-CVE-2024-49994-de99@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [697ba0b6ec4ae04afb67d3911799b5e2043b4455]

CVE-2024-49995: tipc: guard against string buffer overrun

Announce: https://lore.kernel.org/linux-cve-announce/2024102138-CVE-2024-49995-ec59@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
This bug was introduced by commit b97bf3fd ("[TIPC] Initial merge") in
2.6.16-rc1.

Fixed status
mainline: [6555a2a9212be6983d2319d65276484f7c5f431a]
stable/5.10: [e2b2558971e02ca33eb637a8350d68a48b3e8e46]
stable/5.15: [54dae0e9063ed23c9acf8d5ab9b18d3426a8ac18]
stable/6.1: [80c0be7bcf940ce9308311575c3aff8983c9b97a]
stable/6.6: [12d26aa7fd3cbdbc5149b6e516563478d575026e]

CVE-2024-49996: cifs: Fix buffer overflow when parsing NFS reparse points

Announce: https://lore.kernel.org/linux-cve-announce/2024102138-CVE-2024-49996-0d29@gregkh/

Introduced by commit d5ecebc ("smb3: Allow query of symlinks stored as
reparse points") in v5.3-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2a8910af01653c1c268984855629d71fb81f404]
stable/6.6: [c6db81c550cea0c73bd72ef55f579991e0e4ba07]

CVE-2024-49997: net: ethernet: lantiq_etop: fix memory disclosure

Announce: https://lore.kernel.org/linux-cve-announce/2024102138-CVE-2024-49997-0d01@gregkh/

Introduced by commit 504d472 ("MIPS: Lantiq: Add ethernet driver") in v3.0-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45c0de18ff2dc9af01236380404bbd6a46502c69]
stable/5.10: [185df159843d30fb71f821e7ea4368c2a3bfcd36]
stable/5.15: [469856f76f4802c5d7e3d20e343185188de1e2db]
stable/6.1: [2bf4c101d7c99483b8b15a0c8f881e3f399f7e18]
stable/6.6: [e66e38d07b31e177ca430758ed97fbc79f27d966]

CVE-2024-49998: net: dsa: improve shutdown sequence

Announce: https://lore.kernel.org/linux-cve-announce/2024102139-CVE-2024-49998-1a69@gregkh/

Introduced by commit ee53437 ("net: dsa: fix panic when DSA master
device unbinds on shutdown") in v5.17-rc4.
Fixed in v6.12-rc2.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [6c24a03a61a245fe34d47582898331fa034b6ccd]

CVE-2024-49999: afs: Fix the setting of the server responding flag

Announce: https://lore.kernel.org/linux-cve-announce/2024102139-CVE-2024-49999-e815@gregkh/

Introduced by commit 98f9fda ("afs: Fold the afs_addr_cursor struct
in") in v6.8-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff98751bae40faed1ba9c6a7287e84430f7dec64]

CVE-2024-50000: net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024102139-CVE-2024-50000-c542@gregkh/

Introduced by commit a669673 ("net/mlx5e: Convert TIR to a dedicated
object") in v5.15-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f25389e779500cf4a59ef9804534237841bce536]
stable/5.15: [4655456a64a0f936098c8432bac64e7176bd2aff]
stable/6.1: [b48ee5bb25c02ca2b81e0d16bf8af17ab6ed3f8b]
stable/6.6: [0168ab6fbd9e50d20b97486168b604b2ab28a2ca]

CVE-2024-50001: net/mlx5: Fix error path in multi-packet WQE transmit

Announce: https://lore.kernel.org/linux-cve-announce/2024102139-CVE-2024-50001-67e4@gregkh/

Introduced by commit 5af75c7 ("net/mlx5e: Enhanced TX MPWQE for SKBs")
in v5.10-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bcae12c795f32ddfbf8c80d1b5f1d3286341c32]
stable/5.10: [ca36d6c1a49b6965c86dd528a73f38bc62d9c625]
stable/5.15: [ce828b347cf1b3c1b12b091d02463c35ce5097f5]
stable/6.1: [fc357e78176945ca7bcacf92ab794b9ccd41b4f4]
stable/6.6: [26fad69b34fcba80d5c7d9e651f628e6ac927754]

CVE-2024-50002: static_call: Handle module init failure correctly in
static_call_del_module()

Announce: https://lore.kernel.org/linux-cve-announce/2024102139-CVE-2024-50002-bdfd@gregkh/

Introduced by commit 9183c3f ("static_call: Add inline static call
infrastructure") in v5.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b30051c4864234ec57290c3d142db7c88f10d8a]
stable/5.15: [ed4c8ce0f307f2ab8778aeb40a8866d171e8f128]
stable/6.1: [b566c7d8a2de403ccc9d8a06195e19bbb386d0e4]
stable/6.6: [c0abbbe8c98c077292221ec7e2baa667c9f0974c]

CVE-2024-50003: drm/amd/display: Fix system hang while resume with TBT monitor

Announce: https://lore.kernel.org/linux-cve-announce/2024102106-CVE-2024-50003-43bc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc2.
Vulnerable function  was added by commit e27c41d5b068 ("drm/amd/display:
Support for DMUB HPD interrupt handling") in 5.16-rc1.

Fixed status
mainline: [52d4e3fb3d340447dcdac0e14ff21a764f326907]
stable/5.15: [eb9329cd882aa274e92bdb1003bc088433fdee86]
stable/6.1: [722d2d8fc423108597b97efbf165187d16d9aa1e]
stable/6.6: [68d603f467a75618eeae5bfe8af32cda47097010]

CVE-2024-50004: drm/amd/display: update DML2 policy
EnhancedPrefetchScheduleAccelerationFinal DCN35

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-50004-101e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc2.
It seems as if this bug was introduced by commit 115009d1 ("drm/amd/display:
Add DCN35 DML2 support") in 6.7-rc1.

Fixed status
mainline: [0d5e5e8a0aa49ea2163abf128da3b509a6c58286]

CVE-2024-50005: mac802154: Fix potential RCU dereference issue in
mac802154_scan_worker

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-50005-3479@gregkh/

Introduced by commit e2c3e6f ("mac802154: Handle active scanning") in v6.5-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bff1709b3980bd7f80be6786f64cc9a9ee9e56da]
stable/6.6: [e676e4ea76bbe7f1156d8c326b9b6753849481c2]

CVE-2024-50006: ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Announce: https://lore.kernel.org/linux-cve-announce/2024102108-CVE-2024-50006-fe44@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [cc749e61c011c255d81b192a822db650c68b313f]
stable/5.10: [53b1999cfd2c7addf2e581a32865fe8835467b44]
stable/5.15: [ef05572da0c0eb89614ed01cc17d3c882bdbd1ff]
stable/6.1: [9fedf51ab8cf7b69bff08f37fe0989fec7f5d870]
stable/6.6: [d43776b907659affef1de888525847d64b244194]

CVE-2024-50007: ALSA: asihpi: Fix potential OOB array access

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-50007-0253@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Vulnerable function was added by commit 719f82d3 ("ALSA: Add support
of AudioScience ASI boards") in 2.6.35-rc1.

Fixed status
mainline: [7b986c7430a6bb68d523dac7bfc74cbd5b44ef96]
stable/5.10: [219587bca2678e31700ef09ecec178ba1f735674]
stable/5.15: [36ee4021bcc37b834996e79740d095d6f8dd948f]
stable/6.1: [e658227d9d4f4e122d81690fdbc0d438b10288f5]
stable/6.6: [7a55740996701f7b2bc46dc988b60ef2e416a747]

CVE-2024-50008: wifi: mwifiex: Fix memcpy() field-spanning write
warning in mwifiex_cmd_802_11_scan_ext()

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-50008-0152@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [498365e52bebcbc36a93279fe7e9d6aec8479cee]
stable/5.10: [1756918f51e9ab247a0f4782cc28853c2bb457c1]
stable/5.15: [e59bdb1ba594104cd0ee0af3ee9e4435d842a8fe]
stable/6.1: [17199b69a84798efffc475040fbef44374ef1de1]
stable/6.6: [fef7b51f22cf2049b0ca6740adeb0ba6f2e671dc]

CVE-2024-50009: cpufreq: amd-pstate: add check for cpufreq_cpu_get's
return value

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-50009-1b62@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
amd_pstate_adjust_perf was added by commit 1d215f03 ("cpufreq: amd-pstate:
Add fast switch function for AMD P-State") in 5.17-rc1.
amd_pstate_update_limits was added by commit e571a5e ("cpufreq: amd-pstate:
Update amd-pstate preferred core ranking dynamically") in 6.9-rc1.

Fixed status
mainline: [5493f9714e4cdaf0ee7cec15899a231400cb1a9f]

CVE-2024-50010: exec: don't WARN for racy path_noexec check

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-50010-57e8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [0d196e7589cefe207d5d41f37a0a28a1fdeeb7c6]

CVE-2024-50011: ASoC: Intel: soc-acpi-intel-rpl-match: add missing empty item

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-50011-98c9@gregkh/

Introduced by commit 65ab45b ("ASoC: Intel: soc-acpi: Add match
entries for some cs42l43 laptops") in v6.11-rc1.
Fixed in v6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5afc29ba44fdd1bcbad4e07246c395d946301580]

CVE-2024-50012: cpufreq: Avoid a bad reference count on CPU node

Announce: https://lore.kernel.org/linux-cve-announce/2024102109-CVE-2024-50012-db7d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc2.
Vulnerable function was added by commit 8486a32d ("cpufreq: Add
of_perf_domain_get_sharing_cpumask") in 5.15-rc1.

Fixed status
mainline: [c0f02536fffbbec71aced36d52a765f8c4493dc2]
stable/6.6: [0f41f383b5a61a2bf6429a449ebba7fb08179d81]

CVE-2024-50013: exfat: fix memory leak in exfat_load_bitmap()

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-50013-05ef@gregkh/

Introduced by commit 1e49a94 ("exfat: add bitmap operations") in v5.7-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2b537b3e533f28e0d97293fe9293161fe8cd137]
stable/5.10: [f692160d3e1e5450605071b8df8f7d08d9b09a83]
stable/5.15: [ddf704c2ce3b73f38d2dd8cf1bb0f7ec038bdf63]
stable/6.1: [4e1813e52f86eb8db0c6c9570251f2fcbc571f5d]
stable/6.6: [bf0b3b35259475d1fe377bcaa565488e26684f7a]

CVE-2024-50014: ext4: fix access to uninitialised lock in fc replay path

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-50014-d684@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit bc71726c ("ext4: abort
the filesystem if failed to async write metadata buffer") in 5.9-rc2.

Fixed status
mainline: [23dfdb56581ad92a9967bcd720c8c23356af74c1]

CVE-2024-50015: ext4: dax: fix overflowing extents beyond inode size
when partially writing

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-50015-1eb0@gregkh/

Introduced by commit 776722e ("ext4: DAX iomap write support") in v4.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dda898d7ffe85931f9cca6d702a51f33717c501e]
stable/5.10: [f8a7c342326f6ad1dfdb30a18dd013c70f5e9669]
stable/5.15: [8c30a9a8610c314554997f86370140746aa35661]
stable/6.1: [abfaa876b948baaea4d14f21a1963789845c8b4c]
stable/6.6: [5efccdee4a7d507a483f20f880b809cc4eaef14d]

CVE-2024-50016: drm/amd/display: Avoid overflow assignment in link_dp_cts

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-50016-745a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
dp_set_test_pattern (renamed from dc_link_dp_set_test_pattern) was added by
commit 4562236b3 ("drm/amd/dc: Add dc display driver (v2)") in 4.15-rc1.

Fixed status
mainline: [a15268787b79fd183dd526cc16bec9af4f4e49a1]
stable/6.6: [a1495acc6234fa79b775599d3f49009afd53299f]

CVE-2024-50017: x86/mm/ident_map: Use gbpages only where full GB page
should be mapped.

Announce: https://lore.kernel.org/linux-cve-announce/2024102110-CVE-2024-50017-f157@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [cc31744a294584a36bf764a0ffa3255a8e69f036]

CVE-2024-50018: net: napi: Prevent overflow of napi_defer_hard_irqs

Announce: https://lore.kernel.org/linux-cve-announce/2024102111-CVE-2024-50018-65e9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
This bug was introduced by commit 6f8b12d ("net: napi: add
hard irqs deferral feature") in 5.8-rc1.

Fixed status
mainline: [08062af0a52107a243f7608fd972edb54ca5b7f8]

CVE-2024-50019: kthread: unpark only parked kthread

Announce: https://lore.kernel.org/linux-cve-announce/2024102126-CVE-2024-50019-5896@gregkh/

Introduced by commit 5c25b5f ("workqueue: Tag bound workers with
KTHREAD_IS_PER_CPU") in v5.11-rc5.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [214e01ad4ed7158cab66498810094fac5d09b218]
stable/5.15: [40a6e660d2a3a7a5cb99f0b8ff4fb41bad039f68]
stable/6.1: [8608196a155cb6cfae04d96b10a2652d0327e33f]
stable/6.6: [19a5029981c87c2ad0845e713837faa88f5d8e2b]

CVE-2024-50020: ice: Fix improper handling of refcount in
ice_sriov_set_msix_vec_count()

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-50020-e41a@gregkh/

Introduced by commit 4035c72 ("ice: reconfig host after changing MSI-X
on VF") in v6.8.
Introduced by commit 4d38cb4 ("ice: manage VFs MSI-X using resource
tracking") in v6.7-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d517cf89874c6039e6294b18d66f40988e62502a]

CVE-2024-50021: ice: Fix improper handling of refcount in
ice_dpll_init_rclk_pins()

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-50021-d60d@gregkh/

Introduced by commit d7999f5 ("ice: implement dpll interface to
control cgu") in v6.7-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccca30a18e36a742e606d5bf0630e75be7711d0a]

CVE-2024-50022: device-dax: correct pgoff align in dax_set_mapping()

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-50022-0531@gregkh/

Introduced by commit b9b5777 ("device-dax: use ALIGN() for determining
pgoff") in v5.17-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fcbd9785d4c17ea533c42f20a9083a83f301fa6]
stable/6.1: [9c4198dfdca818c5ce19c764d90eabd156bbc6da]
stable/6.6: [b822007e8db341d6f175c645ed79866db501ad86]

CVE-2024-50023: net: phy: Remove LED entry from LEDs list on unregister

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-50023-0e72@gregkh/

Introduced by commit c938ab4 ("net: phy: Manual remove LEDs to ensure
correct ordering") in v6.4.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f50b5d74c68e551667e265123659b187a30fe3a5]
stable/6.6: [143ffa7878e2d9d9c3836ee8304ce4930f7852a3]

CVE-2024-50024: net: Fix an unsafe loop on the list

Announce: https://lore.kernel.org/linux-cve-announce/2024102129-CVE-2024-50024-a052@gregkh/

Introduced by commit b827357 ("genetlink: fix netns vs. netlink table
locking (2)") in v2.6.32-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dae9f1187189bc09ff6d25ca97ead711f7e26f9]
stable/5.10: [68ad5da6ca630a276f0a5c924179e57724d00013]
stable/5.15: [1cdec792b2450105b1314c5123a9a0452cb2c2f0]
stable/6.1: [5f03a7f601f33cda1f710611625235dc86fd8a9e]
stable/6.6: [3be342e0332a7c83eb26fbb22bf156fdca467a5d]

CVE-2024-50025: scsi: fnic: Move flush_work initialization out of if block

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-50025-38d8@gregkh/

Introduced by commit 379a58c ("scsi: fnic: Move fnic_fnic_flush_tx()
to a work queue") in v6.8-rc5.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f30e5f77d2f205ac14d09dec40fd4bb76712f13d]

CVE-2024-50026: scsi: wd33c93: Don't use stale scsi_pointer value

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-50026-a7cf@gregkh/

Introduced by commit dbb2da5 ("scsi: wd33c93: Move the SCSI pointer to
private command data") in v5.18-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9023ed8d91eb1fcc93e64dc4962f7412b1c4cbec]
stable/6.1: [3afeceda855dea9b85cddd96307d4d17c8742005]
stable/6.6: [e04642a207f1d2ae28a08624c04c67f5681f3451]

CVE-2024-50027: thermal: core: Free tzp copy along with the thermal zone

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-50027-91e1@gregkh/

Introduced by commit 3d439b1 ("thermal/core: Alloc-copy-free the
thermal zone parameters structure") in v6.4-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [827a07525c099f54d3b15110408824541ec66b3c]

CVE-2024-50028: thermal: core: Reference count the zone in
thermal_zone_get_by_id()

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-50028-5655@gregkh/

Introduced by commit 1ce50e7 ("thermal: core: genetlink support for
events/cmd/sampling") in v5.9-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a42a5839f400e929c489bb1b58f54596c4535167]

CVE-2024-50029: Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync

Announce: https://lore.kernel.org/linux-cve-announce/2024102130-CVE-2024-50029-8df2@gregkh/

Introduced by commit e07a06b ("Bluetooth: Convert SCO
configure_datapath to hci_sync") in v6.1-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18fd04ad856df07733f5bb07e7f7168e7443d393]
stable/6.6: [867639300759e3e1c5b1e1a5ff89231f263a32a7]

CVE-2024-50030: drm/xe/ct: prevent UAF in send_recv()

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-50030-13ae@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db7f92af626178ba59dbbcdd5dee9ec24a987a88]

CVE-2024-50031: drm/v3d: Stop the active perfmon before being destroyed

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-50031-c158@gregkh/

Introduced by commit 26a4dc2 ("drm/v3d: Expose performance counters to
userspace") in v5.15-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d1fd3638ee3a9f9bca4785fffb638ca19120718]
stable/5.15: [24ab54a066d2ef671b03eb909ca2114c0c9ac1e7]
stable/6.1: [0c9e9a3a4873705740b19300cadc6599170646ef]
stable/6.6: [07c51108d9e278831c16191d1223ee49986e7890]

CVE-2024-50032: rcu/nocb: Fix rcuog wake-up from offline softirq

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-50032-e7ba@gregkh/

Introduced by commit 9139f93 ("rcu/nocb: Fix RT throttling hrtimer
armed from offline CPU") in v6.12-rc1.
Fixed in v6.12-rc3.
Bug introduced commit was backported to following branches.
stable/6.1 stable/6.11 stable/6.6

Fixed status
mainline: [f7345ccc62a4b880cf76458db5f320725f28e400]
stable/6.6: [84a5feebba10354c683983f5f1372a144225e4c2]

CVE-2024-50033: slip: make slhc_remember() more robust against malicious packets

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-50033-ce5e@gregkh/

Introduced by commit b5451d7 ("slip: Move the SLIP drivers") in v3.2-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d3fce8cbe3a70a1c7c06c9b53696be5d5d8dd5c]
stable/5.10: [36b054324d18e51cf466134e13b6fbe3c91f52af]
stable/5.15: [5e336384cc9b608e0551f99c3d87316ca3b0e51a]
stable/6.1: [ff5e0f895315706e4ca5a19df15be6866cee4f5d]
stable/6.6: [8bb79eb1db85a10865f0d4dd15b013def3f2d246]

CVE-2024-50034: net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC

Announce: https://lore.kernel.org/linux-cve-announce/2024102131-CVE-2024-50034-46ef@gregkh/

Introduced by commit d25a92c ("net/smc: Introduce IPPROTO_SMC") in v6.11-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fd27ea183c208e478129a85e11d880fc70040f2]

CVE-2024-50035: ppp: fix ppp_async_encode() illegal access

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-50035-82d8@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40dddd4b8bd08a69471efd96107a4e1c73fabefc]
stable/5.10: [30d91a478d58cbae3dbaa8224d17d0d839f0d71b]
stable/5.15: [fadf8fdb3110d3138e05c3765f645535434f8d76]
stable/6.1: [ce249a4c68d0ce27a8c5d853338d502e2711a314]
stable/6.6: [8fe992ff3df493d1949922ca234419f3ede08dff]

CVE-2024-50036: net: do not delay dst_entries_add() in dst_release()

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-50036-9d91@gregkh/

Introduced by commit f886497 ("ipv4: fix dst race in sk_dst_get()") in
v3.16-rc3.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac888d58869bb99753e7652be19a151df9ecb35d]
stable/6.6: [eae7435b48ffc8e9be0ff9cfeae40af479a609dd]

CVE-2024-50037: drm/fbdev-dma: Only cleanup deferred I/O if necessary

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-50037-770e@gregkh/

Introduced by commit 5a498d4 ("drm/fbdev-dma: Only install deferred
I/O if necessary") in v6.11-rc7.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcddc71ec7ecf15b4df3c41288c9cf0b8e886111]

CVE-2024-50038: netfilter: xtables: avoid NFPROTO_UNSPEC where needed

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-50038-dc41@gregkh/

Introduced by commit 0269ea4 ("netfilter: xtables: add cluster match")
in v2.6.30-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bfcb7b71e735560077a42847f69597ec7dcc326]
stable/5.15: [85ff9a0f793ca52c527e75cd40a69c948627ebde]
stable/6.1: [8f482bb7e27b37f1f734bb9a8eeb28b23d59d189]
stable/6.6: [997f67d813ce0cf5eb3cdb8f124da68141e91b6c]

CVE-2024-50039: net/sched: accept TCA_STAB only for root qdisc

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-50039-41b0@gregkh/

Introduced by commit 175f9c1 ("net_sched: Add size table for qdiscs")
in v2.6.27-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cb7cf1540ddff5473d6baeb530228d19bc97b8a]
stable/5.10: [adbc3eef43fc94c7c8436da832691ae02333a972]
stable/5.15: [8fb6503592d39065316f45d267c5527b4e7cd995]
stable/6.1: [76feedc74b90270390fbfdf74a2e944e96872363]
stable/6.6: [1edf039ee01788ffc25625fe58a903ae2efa213e]

CVE-2024-50040: igb: Do not bring the device up after non-fatal error

Announce: https://lore.kernel.org/linux-cve-announce/2024102132-CVE-2024-50040-f156@gregkh/

Introduced by commit 004d250 ("igb: Fix igb_down hung on surprise
removal") in v6.5-rc1.
Fixed in v6.12-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [330a699ecbfc9c26ec92c6310686da1230b4e7eb]
stable/5.10: [d79af3af2f49c6aae9add3d492c04d60c1b85ce4]
stable/5.15: [0a94079e3841d00ea5abb05e3233d019a86745f6]
stable/6.1: [6a39c8f5c8aae74c5ab2ba466791f59ffaab0178]
stable/6.6: [57c5053eaa5f9a8a99e34732e37a86615318e464]

CVE-2024-50041: i40e: Fix macvlan leak by synchronizing access to
mac_filter_hash

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-50041-6118@gregkh/

Introduced by commit fed0d9f ("i40e: Fix VF's MAC Address change on
VM") in v5.19-rc6.
Fixed in v6.12-rc3.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [dac6c7b3d33756d6ce09f00a96ea2ecd79fae9fb]
stable/5.15: [9db6ce9e2738b05a3672aff4d42169cf3bb5a3e3]
stable/6.1: [9a9747288ba0a9ad4f5c9877f18dd245770ad64e]
stable/6.6: [703c4d820b31bcadf465288d5746c53445f02a55]

CVE-2024-50042: ice: Fix increasing MSI-X on VF

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-50042-ca9e@gregkh/

Introduced by commit 2a2cb4c ("ice: replace ice_vf_recreate_vsi() with
ice_vf_reconfig_vsi()") in v6.8-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bce9af1b030bf59d51bbabf909a3ef164787e44e]

CVE-2024-50043: nfsd: fix possible badness in FREE_STATEID

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-50043-86f8@gregkh/

Introduced by commit 3f29cc8 ("nfsd: split sc_status out of sc_type")
in v6.9-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c88c150a467fcb670a1608e2272beeee3e86df6e]

CVE-2024-50044: Bluetooth: RFCOMM: FIX possible deadlock in
rfcomm_sk_state_change

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-50044-2ee1@gregkh/

Introduced by commit 3241ad8 ("[Bluetooth] Add timestamp support to
L2CAP, RFCOMM and SCO") in v2.6.27-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08d1914293dae38350b8088980e59fbc699a72fe]
stable/5.10: [ef44274dae9b0a90d1a97ce8b242a3b8243a7745]
stable/5.15: [496b2ab0fd10f205e08909a125485fdc98843dbe]
stable/6.1: [ced98072d3511b232ae1d3347945f35f30c0e303]
stable/6.6: [38b2d5a57d125e1c17661b8308c0240c4a43b534]

CVE-2024-50045: netfilter: br_netfilter: fix panic with metadata_dst skb

Announce: https://lore.kernel.org/linux-cve-announce/2024102133-CVE-2024-50045-283d@gregkh/

Introduced by commit 11538d0 ("bridge: vlan dst_metadata hooks in
ingress and egress paths") in v4.11-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9ff7665cd128012868098bbd07e28993e314fdb]
stable/5.10: [cce8419b8168f6e7eb637103a47f916f3de8bc81]
stable/5.15: [95c0cff5a1a5d28bf623b92eb5d1a8f56ed30803]
stable/6.1: [78ed917133b118661e1fe62d4a85d5d428ee9568]
stable/6.6: [3453f5839420bfbb85c86c61e49f49ffd0f041c4]

CVE-2024-50046: NFSv4: Prevent NULL-pointer dereference in
nfs42_complete_copies()

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-50046-a9b4@gregkh/

Introduced by commit 0e65a32 ("NFS: handle source server reboot") in v5.5-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a848c29e3486189aaabd5663bc11aea50c5bd144]
stable/5.10: [f892165c564e3aab272948dbb556cc20e290c55a]
stable/5.15: [584c019baedddec3fd634053e8fb2d8836108d38]
stable/6.1: [632344b9efa064ca737bfcdaaaced59fd5f18ae9]
stable/6.6: [fca41e5fa4914d12b2136c25f9dad69520b52683]

CVE-2024-50047: smb: client: fix UAF in async decryption

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-50047-7a27@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
smb3_crypto_aead_allocate, smb3_init_transform_rq, and crypt_message were added
by commit 026e93dc0 ("CIFS: Encrypt SMB3 requests before sending") in 4.11-rc1.
decrypt_raw_data was added by commit 4326ed2f6 ("CIFS: Decrypt and process small
encrypted packets") in 4.11-rc1.

Fixed status
mainline: [b0abcd65ec545701b8793e12bc27dc98042b151a]
stable/6.6: [0809fb86ad13b29e1d6d491364fc7ea4fb545995]

CVE-2024-50048: fbcon: Fix a NULL pointer dereference issue in fbcon_putcs

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-50048-f299@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [5b97eebcce1b4f3f07a71f635d6aa3af96c236e7]
stable/6.1: [8266ae6eafdcd5a3136592445ff4038bbc7ee80e]
stable/6.6: [f7fb5dda555344529ce584ff7a28b109528d2f1b]

CVE-2024-50049: drm/amd/display: Check null pointer before dereferencing se

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-50049-26da@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit 93c2340 ("drm/amd/display:
add more checks to validate seamless boot timing") in 5.5-rc1.

Fixed status
mainline: [ff599ef6970ee000fa5bc38d02fa5ff5f3fc7575]
stable/5.10: [f4149eec960110ffd5bcb161075dd9f1d7773075]
stable/5.15: [c643ef59390e49f1dfab35e8ea65f5db5e527d64]
stable/6.1: [97a79933fb08a002ba9400d1a7a5df707ecdb896]
stable/6.6: [65b2d49e55fe13ae56da3a7685bdccadca31134a]

CVE-2024-50055: driver core: bus: Fix double free in driver API bus_register()

Announce: https://lore.kernel.org/linux-cve-announce/2024102134-CVE-2024-50055-7d1f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [bfa54a793ba77ef696755b66f3ac4ed00c7d1248]
stable/6.6: [d885c464c25018b81a6b58f5d548fc2e3ef87dd1]

CVE-2024-50056: usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-50056-78bf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [a7bb96b18864225a694e3887ac2733159489e4b0]

CVE-2024-50057: usb: typec: tipd: Free IRQ only if it was requested before

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-50057-d046@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It seems as if this bug was introduced by commit 94ea04ec ("usb:
typec: tps6598x:
Fix fault at module removal") in 6.4-rc3.

Fixed status
mainline: [db63d9868f7f310de44ba7bea584e2454f8b4ed0]
stable/6.6: [b72bf5cade51ba4055c8a8998d275e72e6b521ce]

CVE-2024-50058: serial: protect uart_port_dtr_rts() in uart_shutdown() too

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-50058-e827@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit af224ca2 ("serial: core:
Prevent unsafe uart port access, part 3") in 4.7-rc1.

Fixed status
mainline: [602babaa84d627923713acaf5f7e9a4369e77473]
stable/6.6: [e418d91195d29d5f9c9685ff309b92b04b41dc40]

CVE-2024-50059: ntb: ntb_hw_switchtec: Fix use after free
vulnerability in switchtec_ntb_remove due to race condition

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-50059-4ccd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit 33dea5aae ("NTB: switchtec_ntb: Introduce
initial NTB driver") in 4.15-rc1.

Fixed status
mainline: [e51aded92d42784313ba16c12f4f88cc4f973bbb]
stable/5.10: [b650189687822b705711f0567a65a164a314d8df]
stable/5.15: [92728fceefdaa2a0a3aae675f86193b006eeaa43]
stable/6.1: [3ae45be8492460a35b5aebf6acac1f1d32708946]
stable/6.6: [fa840ba4bd9f3bad7f104e5b32028ee73af8b3dd]

CVE-2024-50060: io_uring: check if we need to reschedule during overflow flush

Announce: https://lore.kernel.org/linux-cve-announce/2024102135-CVE-2024-50060-6994@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [eac2ca2d682f94f46b1973bdf5e77d85d77b8e53]
stable/6.1: [a2493904e95ce94bbec819d8f7f03b99976eb25c]
stable/6.6: [f4ce3b5d26ce149e77e6b8e8f2058aa80e5b034e]

CVE-2024-50061: i3c: master: cdns: Fix use after free vulnerability in
cdns_i3c_master Driver Due to Race Condition

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-50061-50ab@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit 603f2bee2c ("i3c: master: Add driver for
Cadence IP") in 5.0-rc1.

Fixed status
mainline: [609366e7a06d035990df78f1562291c3bf0d4a12]
stable/6.6: [ea0256e393e0072e8c80fd941547807f0c28108b]

CVE-2024-50062: RDMA/rtrs-srv: Avoid null pointer deref during path
establishment

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-50062-1ea1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit 9cb8374804 ("RDMA/rtrs: server: main
functionality") in 5.8-rc1.

Fixed status
mainline: [d0e62bf7b575fbfe591f6f570e7595dd60a2f5eb]
stable/5.15: [394b2f4d5e014820455af3eb5859eb328eaafcfd]
stable/6.1: [b5d4076664465487a9a3d226756995b12fb73d71]
stable/6.6: [ccb8e44ae3e2391235f80ffc6be59bec6b889ead]

CVE-2024-50063: bpf: Prevent tail call between progs attached to different hooks

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-50063-1a59@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [28ead3eaabc16ecc907cfb71876da028080f6356]
stable/6.6: [5d5e3b4cbe8ee16b7bf96fd73a421c92a9da3ca1]

CVE-2024-50064: zram: free secondary algorithms names

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-50064-33d1@gregkh/

Introduced by commit 001d927 ("zram: add recompression algorithm sysfs
knob") in v6.2-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [684826f8271ad97580b138b9ffd462005e470b99]
stable/6.6: [6272936fd242ca1f784c3e21596dfb3859dff276]

CVE-2024-50065: ntfs3: Change to non-blocking allocation in ntfs_d_hash

Announce: https://lore.kernel.org/linux-cve-announce/2024102136-CVE-2024-50065-c751@gregkh/

Introduced by commit d392e85 ("fs/ntfs3: Fix the format of the
"nocase" mount option") in v6.11-rc1.
Fixed in v6.12-rc3.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [589996bf8c459deb5bbc9747d8f1c51658608103]
stable/6.6: [c556e72cea2a1131ae418be017dd6fc76fffe2fb]

CVE-2023-52918: media: pci: cx23885: check cx23885_vdev_init() return

Announce: https://lore.kernel.org/linux-cve-announce/2024102230-CVE-2023-52918-cf21@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc1.

Fixed status
cip/4.4: [aa9c4d0e9d3db84d2a1a5a19dcdabcd938c027ac]
cip/4.4-st: [aa9c4d0e9d3db84d2a1a5a19dcdabcd938c027ac]
mainline: [15126b916e39b0cb67026b0af3c014bfeb1f76b3]
stable/4.19: [8e31b096e2e1949bc8f0be019c9ae70d414404c6]
stable/5.10: [e7385510e2550a9f8b6f3d5f33c5b894ab9ba976]
stable/5.15: [a5f1d30c51c485cec7a7de60205667c3ff86c303]
stable/5.4: [199a42fc4c45e8b7f19efeb15dbc36889a599ac2]
stable/6.1: [06ee04a907d64ee3910fecedd05d7f1be4b1b70e]
stable/6.6: [b1397fb4a779fca560c43d2acf6702d41b4a495b]

CVE-2023-52919: nfc: nci: fix possible NULL pointer dereference in
send_acknowledge()

Announce: https://lore.kernel.org/linux-cve-announce/2024102232-CVE-2023-52919-4a94@gregkh/

Introduced by commit 391d8a2 ("NFC: Add NCI over SPI receive") in v3.11-rc1.
Fixed in v6.6-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [bee47349504c09414e9602292a87af6fadc1a583]
cip/4.4-rt: [bee47349504c09414e9602292a87af6fadc1a583]
cip/4.4-st: [bee47349504c09414e9602292a87af6fadc1a583]
mainline: [7937609cd387246aed994e81aa4fa951358fba41]
stable/4.19: [5622592f8f74ae3e594379af02e64ea84772d0dd]
stable/5.10: [c95fa5b20fe03609e0894656fa43c18045b5097e]
stable/5.15: [ffdc881f68073ff86bf21afb9bb954812e8278be]
stable/5.4: [76050b0cc5a72e0c7493287b7e18e1cb9e3c4612]
stable/6.1: [d7dbdbe3800a908eecd4975c31be47dd45e2104a]

CVE-2023-7122: iommufd: Do not UAF during iommufd_put_object()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-7122

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f9c4d8c468c189d6dc470324bd52955f8aa0a10]

CVE-2024-50066: mm/mremap: fix move_normal_pmd/retract_page_tables race

Announce: https://lore.kernel.org/linux-cve-announce/2024102340-CVE-2024-50066-7803@gregkh/

Introduced by commit 1d65b77 ("mm/khugepaged: retract_page_tables()
without mmap or vma lock") in v6.6-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fa1066fc5d00cb9f1b0e83b7ff6ef98d26ba2aa]
stable/6.6: [17396e32f975130b3e6251f024c8807d192e4c3e]

* Updated CVEs

CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use to
prevent UAF

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [9722aa53fa234ff04c7c50df225b4fbf032c6d61]
stable/5.15: [b6a9b12e8c724931bf9a7f7afeb3fb14d2b9696b]

CVE-2023-52904: ALSA: usb-audio: Fix possible NULL pointer dereference
in snd_usb_pcm_has_fixed_rate()

stable/5.15 was fixed.

Fixed status
stable/5.15: [f57204edc10760c935d8d36ea999dc8acf018030]
stable/6.1: [a474d4ad59cd4642d1b7e3a6c08cef9eca0992c8]

CVE-2024-26921: inet: inet_defrag: prevent sk release while still in use

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [9705f447bf9a6cd088300ad2c407b5e1c6591091]
stable/5.15: [4318608dc28ef184158b4045896740716bea23f0]
stable/6.1: [7d0567842b78390dd9b60f00f1d8f838d540e325]
stable/6.6: [f4877225313d474659ee53150ccc3d553a978727]
stable/6.8: [e09cbe017311508c21e0739e97198a8388b98981]

CVE-2024-27017: netfilter: nft_set_pipapo: walk over current view on
netlink dump

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ff89db14c63a827066446460e39226c0688ef786]
stable/5.15: [ce9fef54c5ec9912a0c9a47bac3195cc41b14679]
stable/6.1: [52735a010f37580b3a569a996f878fdd87425650]
stable/6.6: [f24d8abc2bb8cbf31ec713336e402eafa8f42f60]
stable/6.8: [721715655c72640567e8742567520c99801148ed]

CVE-2024-27072: media: usbtv: Remove useless locks in usbtv_video_free()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4ec4641df57cbdfdc51bb4959afcdbcf5003ddb9]
stable/5.15: [d5ed208d04acf06781d63d30f9fa991e8d609ebd]
stable/6.1: [bdd82c47b22a8befd617b723098b2a41b77373c7]
stable/6.6: [dea46e246ef0f98d89d59a4229157cd9ffb636bf]
stable/6.8: [3e7d82ebb86e94643bdb30b0b5b077ed27dce1c2]

CVE-2024-35963: Bluetooth: hci_sock: Fix not validating setsockopt user input

stable/6.1 was fixed.

Fixed status
stable/6.1: [781f3a97a38a338bc893b6db7f9f9670bf1a9e37]
stable/6.6: [0c18a64039aa3f1c16f208d197c65076da798137]
stable/6.8: [50173882bb187e70e37bac01385b9b114019bee2]

CVE-2024-35965: Bluetooth: L2CAP: Fix not validating setsockopt user input

stable/5.10 was fixed.

Fixed status
stable/5.10: [f13b04cf65a86507ff15a9bbf37969d25be3e2a0]
stable/6.1: [9d42f373391211c7c8af66a3a316533a32b8a607]
stable/6.6: [28234f8ab69c522ba447f3e041bbfbb284c5959a]
stable/6.8: [8ee0c132a61df9723813c40e742dc5321824daa9]

CVE-2024-36893: usb: typec: tcpm: Check for port partner validity
before consuming it

stable/5.15 was fixed.

Fixed status
stable/5.15: [2a07e6f0ad8a6e504a3912cfe8dc859b7d0740a5]
stable/6.1: [d56d2ca03cc22123fd7626967d096d8661324e57]
stable/6.6: [789326cafbd1f67f424436b6bc8bdb887a364637]

CVE-2024-38544: RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [de5a059e36657442b5637cc16df5163e435b9cb4]
stable/5.15: [e0e14dd35d4242340c7346aac60c7ff8fbf87ffc]
stable/6.1: [faa8d0ecf6c9c7c2ace3ca3e552180ada6f75e19]
stable/6.6: [21b4c6d4d89030fd4657a8e7c8110fd941049794]
stable/6.9: [30df4bef8b8e183333e9b6e9d4509d552c7da6eb]

CVE-2024-38545: RDMA/hns: Fix UAF for cq async event

stable/5.15 was fixed.

Fixed status
stable/5.15: [330c825e66ef65278e4ebe57fd49c1d6f3f4e34e]
stable/6.1: [763780ef0336a973e933e40e919339381732dcaf]
stable/6.6: [63da190eeb5c9d849b71f457b15b308c94cbaf08]
stable/6.9: [37a7559dc1358a8d300437e99ed8ecdab0671507]

CVE-2024-38588: ftrace: Fix possible use-after-free issue in ftrace_location()

stable/5.10 was fixed.

Fixed status
stable/5.10: [1880a324af1c95940a7c954b6b937e86844a33bd]
stable/5.15: [8ea8ef5e42173560ac510e92a1cc797ffeea8831]
stable/6.1: [dbff5f0bfb2416b8b55c105ddbcd4f885e98fada]
stable/6.6: [7b4881da5b19f65709f5c18c1a4d8caa2e496461]
stable/6.9: [31310e373f4c8c74e029d4326b283e757edabc0b]

CVE-2024-38632: vfio/pci: fix potential memory leak in vfio_intx_enable()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [a6d810554d7d9d07041f14c5fcd453f3d3fed594]
stable/6.1: [91ced077db2062604ec270b1046f8337e9090079]
stable/6.6: [0bd22a4966d55f1d2c127a53300d5c2b50152376]
stable/6.9: [35fef97c33f3d3ca0455f9a8e2a3f2c1f8cc9140]

CVE-2024-39463: 9p: add missing locking around taking dentry fid list

stable/5.15 was fixed.

Fixed status
stable/5.15: [3bb6763a8319170c2d41c4232c8e7e4c37dcacfb]
stable/6.1: [cb299cdba09f46f090b843d78ba26b667d50a456]
stable/6.6: [f0c5c944c6d8614c19e6e9a97fd2011dcd30e8f5]
stable/6.9: [fe17ebf22feb4ad7094d597526d558a49aac92b4]

CVE-2024-41016: ocfs2: strict bound check before memcmp in
ocfs2_xattr_find_entry()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [57a3d89831fcaa2cdbe024b47c7c36d5a56c3637]
stable/5.15: [c031d286eceb82f72f8623b7f4abd2aa491bfb5e]
stable/6.1: [cfb926051fab19b10d1e65976211f364aa820180]
stable/6.10: [e4ffea01adf3323c821b6f37e9577d2d400adbaa]
stable/6.6: [c726dea9d0c806d64c26fcef483b1fb9474d8c5e]

CVE-2024-41071: wifi: mac80211: Avoid address calculations via out of
bounds array indexing

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a2bb0c5d0086be5ab5054465dfaa381a1144905c]
stable/6.6: [26b177ecdd311f20de4c379f0630858a675dfc0c]

CVE-2024-43866: net/mlx5: Always drain health in shutdown callback

stable/6.1 was fixed.

Fixed status
stable/6.1: [5005e2e159b300c1b8c6820a1e13a62eb0127b9b]
stable/6.10: [6048dec754554a1303d632be6042d3feb3295285]
stable/6.6: [6b6c2ebd83f2bf97e8f221479372aaca97a4a9b2]

CVE-2024-44931: gpio: prevent potential speculation leaks in
gpio_device_get_desc()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [9d682e89c44bd5819b01f3fbb45a8e3681a4b6d0]
stable/5.15: [c65ab97efcd438cb4e9f299400f2ea55251f3a67]
stable/6.1: [672c19165fc96dfad531a5458e0b3cdab414aae4]
stable/6.10: [d776c0486b03a5c4afca65b8ff44573592bf93bb]
stable/6.6: [1b955f786a4bcde8c0ccb2b7d519def2acb6f3cc]

CVE-2024-46695: selinux,smack: don't bypass permissions check in
inode_setsecctx hook

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2dbc4b7bac60b02cc6e70d05bf6a7dfd551f9dda]
stable/5.15: [fe0cd53791119f6287b6532af8ce41576d664930]
stable/6.1: [eebec98791d0137e455cc006411bb92a54250924]
stable/6.10: [f71ec019257ba4f7ab198bd948c5902a207bad96]
stable/6.6: [459584258d47ec3cc6245a82e8a49c9d08eb8b57]

CVE-2024-46710: drm/vmwgfx: Prevent unmapping active read buffers

stable/6.1 was fixed.

Fixed status
stable/6.1: [58a3714db4d9dcaeb9fc4905141e17b9f536c0a5]
stable/6.10: [d5228d158e4c0b1663b3983044913c15c3d0135e]
stable/6.6: [0851b1ec650adadcaa23ec96daad95a55bf966f0]

CVE-2024-46849: ASoC: meson: axg-card: fix 'use-after-free'

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [5a2cc2bb81399e9ebc72560541137eb04d61dc3d]
stable/5.15: [fb0530025d502cb79d2b2801b14a9d5261833f1a]
stable/6.1: [e1a199ec31617242e1a0ea8f312341e682d0c037]
stable/6.10: [7d318166bf55e9029d56997c3b134f4ac2ae2607]
stable/6.6: [e43364f578cdc2f8083abbc0cb743ea55e827c29]

CVE-2024-46852: dma-buf: heaps: Fix off-by-one in CMA heap fault handler

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [007180fcb6cc4a93211d4cc45fef3f5ccccd56ae]
stable/5.15: [79cce5e81d20fa9ad553be439d665ac3302d3c95]
stable/6.1: [84175dc5b2c932266a50c04e5ce342c30f817a2f]
stable/6.10: [e79050882b857c37634baedbdcf7c2047c24cbff]
stable/6.6: [eb7fc8b65cea22f9038c52398c8b22849e9620ea]

CVE-2024-46853: spi: nxp-fspi: fix the KASAN report out-of-bounds bug

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [609260542cf86b459c57618b8cdec8020394b7ad]
stable/5.15: [491f9646f7ac31af5fca71be1a3e5eb8aa7663ad]
stable/6.1: [09af8b0ba70072be831f3ec459f4063d570f9e24]
stable/6.10: [d1a1dfcec77c57b1181da93d11a3db1bc4eefa97]
stable/6.6: [af9ca9ca3e44f48b2a191e100d452fbf850c3d87]

CVE-2024-46854: net: dpaa: Pad packets to ETH_ZLEN

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [1f31f51bfc8214a6deaac2920e6342cb9d019133]
stable/5.15: [38f5db5587c0ee53546b28c50ba128253181ac83]
stable/6.1: [f43190e33224c49e1c7ebbc25923ff400d87ec00]
stable/6.10: [ce8eabc912fe9b9a62be1a5c6af5ad2196e90fc2]
stable/6.6: [34fcac26216ce17886af3eb392355b459367af1a]

CVE-2024-46855: netfilter: nft_socket: fix sk refcount leaks

stable/5.15 was fixed.

Fixed status
stable/5.15: [ddc7c423c4a5386bf865474c694b48178efd311a]
stable/6.1: [33c2258bf8cb17fba9e58b111d4c4f4cf43a4896]
stable/6.10: [1f68e097e20d3c695281a9c6433acc37be47fe11]
stable/6.6: [83e6fb59040e8964888afcaa5612cc1243736715]

CVE-2024-46858: mptcp: pm: Fix uaf in __timer_delete_sync

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [0e7814b028cd50b3ff79659d23dfa9da6a1e75e1]
stable/5.15: [3554482f4691571fc4b5490c17ae26896e62171c]
stable/6.1: [67409b358500c71632116356a0b065f112d7b707]
stable/6.10: [12134a652b0a10064844ea235173e70246eba6dc]
stable/6.6: [6452b162549c7f9ef54655d3fb9977b9192e6e5b]

CVE-2024-46859: platform/x86: panasonic-laptop: Fix SINF array out of
bounds accesses

stable/5.15 was fixed.

Fixed status
stable/5.15: [b7c2f692307fe704be87ea80d7328782b33c3cef]
stable/6.1: [9291fadbd2720a869b1d2fcf82305648e2e62a16]
stable/6.10: [b38c19783286a71693c2194ed1b36665168c09c4]
stable/6.6: [6821a82616f60aa72c5909b3e252ad97fb9f7e2a]

CVE-2024-46865: fou: fix initialization of grc

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [392f6a97fcbecc64f0c00058b2db5bb0e4b8cc3e]
stable/5.15: [16ff0895283058b0f96d4fe277aa25ee096f0ea8]
stable/6.1: [5d537b8d900514509622ce92330b70d2e581d409]
stable/6.10: [aca06c617c83295f0caa486ad608fbef7bdc11e8]
stable/6.6: [7ae890ee19479eeeb87724cca8430b5cb3660c74]

CVE-2024-47670: ocfs2: add bounds checking to ocfs2_xattr_find_entry()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [34759b7e4493d7337cbc414c132cef378c492a2c]
stable/5.15: [5bbe51eaf01a5dd6fb3f0dea81791e5dbc6dc6dd]
stable/6.1: [9b32539590a8e6400ac2f6e7cf9cbb8e08711a2f]
stable/6.10: [8e7bef408261746c160853fc27df3139659f5f77]
stable/6.6: [1f6e167d6753fe3ea493cdc7f7de8d03147a4d39]

CVE-2024-47671: USB: usbtmc: prevent kernel-usb-infoleak

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [16e0ab9ed3ae7d19ca8ee718ba4e09d5c0f909ca]
stable/5.15: [0c927dfc0b9bd177f7ab6ee59ef0c4ea06c110a7]
stable/6.1: [ba6269e187aa1b1f20faf3c458831a0d6350304b]
stable/6.10: [e872738e670ddd63e19f22d0d784f0bdf26ecba5]
stable/6.11: [6c7fc36da021b13c34c572a26ba336cd102418f8]
stable/6.6: [51297ef7ad7824ad577337f273cd092e81a9fa08]

CVE-2024-47672: wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [de46b1d24f5f752b3bd8b46673c2ea4239661244]
stable/5.15: [1afed66cb271b3e65fe9df1c9fba2bf4b1f55669]
stable/6.1: [1b0cd832c9607f41f84053b818e0b7908510a3b9]
stable/6.10: [7188b7a72320367554b76d8f298417b070b05dd3]
stable/6.6: [4d0a900ec470d392476c428875dbf053f8a0ae5e]

CVE-2024-47673: wifi: iwlwifi: mvm: pause TCM when the firmware is stopped

stable/5.15 was fixed.

Fixed status
stable/5.15: [a15df5f37fa3a8b7a8ec7a339d1e897bc524e28f]
stable/6.1: [5948a191906b54e10f02f6b7a7670243a39f99f4]
stable/6.10: [55086c97a55d781b04a2667401c75ffde190135c]
stable/6.6: [2c61b561baf92a2860c76c2302a62169e22c21cc]

CVE-2024-47674: mm: avoid leaving partial pfn mappings around in error case

stable/5.15 was fixed.

Fixed status
stable/5.15: [5b2c8b34f6d76bfbd1dd4936eb8a0fbfb9af3959]
stable/6.1: [65d0db500d7c07f0f76fc24a4d837791c4862cd2]
stable/6.6: [a95a24fcaee1b892e47d5e6dcc403f713874ee80]

CVE-2023-52530: wifi: mac80211: fix potential key use-after-free

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e8e599a635066c50ac214c3e10858f1d37e03022]
stable/5.15: [e8a834eb09bb95c2bf9c76f1a28ecef7d8c439d0]
stable/6.1: [2f4e16e39e4f5e78248dd9e51276a83203950b36]

CVE-2024-26718: dm-crypt, dm-verity: disable tasklets

stable/5.15 was fixed.

Fixed status
stable/5.15: [b825e0f9d68c178072bffd32dd34c39e3d2d597a]
stable/6.1: [30884a44e0cedc3dfda8c22432f3ba4078ec2d94]
stable/6.6: [5735a2671ffb70ea29ca83969fe01316ee2ed6fc]
stable/6.7: [0c45a20cbe68bc4d681734f5c03891124a274257]

CVE-2024-39497: drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [3ae63a8c1685e16958560ec08d30defdc5b9cca0]
stable/6.1: [2219e5f97244b79c276751a1167615b9714db1b0]
stable/6.6: [1b4a8b89bf6787090b56424d269bf84ba00c3263]
stable/6.9: [03c71c42809ef4b17f5d874cdb2d3bf40e847b86]

CVE-2024-40953: KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [71fbc3af3dacb26c3aa2f30bb3ab05c44d082c84]
stable/5.15: [82bd728a06e55f5b5f93d10ce67f4fe7e689853a]
stable/6.1: [92c77807d938145c7c3350c944ef9f39d7f6017c]
stable/6.6: [a937ef951bba72f48d2402451419d725d70dba20]
stable/6.9: [95c8dd79f3a14df96b3820b35b8399bd91b2be60]

CVE-2024-43845: udf: Fix bogus checksum computation in udf_rename()

stable/5.15 was fixed.

Fixed status
stable/5.15: [9c439311c13fc6faab1921441165c9b8b500c83b]
stable/6.1: [c996b570305e7a6910c2ce4cdcd4c22757ffe241]
stable/6.10: [40d7b3ed52449d36143bab8d3e70926aa61a60f4]
stable/6.6: [fe2ead240c31e8d158713beca9d0681a6e6a53ab]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

