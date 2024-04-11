Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD23CD11C2
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 02:22:03 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web11.8189.1712802116746673363
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 19:21:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=weNZpdlM;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22a96054726so5993325fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 19:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1712802116; x=1713406916; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1XtpzBnIasfSALJ1pnWTQPFh9EbNWNcRGveNBHECJU=;
        b=weNZpdlMvvnhcxtwBfXzExwhFH+JM2L6QChaixPQiWED5Za/jWmN935SdflckIb4OM
         Auexf5cT0jzqb9CgMZhX7+YmZek1Otj0f5FvYta7c4Mr4hNnvV2G4BMrTT63z51ggFr+
         /DcZsAoS+G3qA7vgQO6J3VkuOP+z8XTlvkzxF/VMQsQ1s8Mmrpzn2WbWPPMmpC5y04/G
         05ox2tk9LYhm+OBIT2kvgw5SznaWGUoUjzq/qIOF99uasIIa/HLNztAMCElp3Fk2j33k
         3q3k7eOv05oguINMQf4KcPh7mai1702Qlt+nic1l5JlC4tsmL03rUCzPPdb+4qQDpkqk
         MK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712802116; x=1713406916;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1XtpzBnIasfSALJ1pnWTQPFh9EbNWNcRGveNBHECJU=;
        b=S1Cdg6F8D2+zZz5wM9IhXUQzSHmyCmVhitdVtEZV3JbiKs3ckVO3bvN2mEW8Nzmli5
         s27+OyyoayAshRG5RmAS8Y8gQrqQ7/bCun+DJW5oGTpNxE/HV2UIiNbO2A/4RSVVm/59
         nRcQRr6fuuprDdUsKR7ViDr8SWysbW36YY4lpZ3ED/j3+yOgI0MQsbm7tC895YFs9P1u
         udyrp5oMElHksSwyCzhtnfHy0yWz+FEOzE4K+Y0+L0CqoZ2Ab6gn3nOMEF3ZpJtXBPUq
         8YA0XDYyj+FUA14pZ9l+8ECcbfCwwRebj2ipig9IEovOvKd5km2M2qyVjias8kGCa8dW
         r0NQ==
X-Gm-Message-State: AOJu0YwJFGWBNvVzy+t92D5yzYDhHnXJbAogndVCRc6zv/VHfp7vsw+d
	QGxta3/XMgHfDI4I+9FgZux9I9eGG8Z60xs2CsM3RE0oG935e8RxSb05C7Et5zpmV95t/N2c2pC
	rRr3hzCov6AnZWt+HzlVcujC2l2ozd42BzYnLeSXFxgB/rfeADzg=
X-Google-Smtp-Source: AGHT+IFExNdRwF8TEtLqJT/P/eiApwvScFljiB+cBGRKVkXzqZIqgxi+ptP6CtAM1+ofN6grnqwz3FGnunt8wvRJ/HE=
X-Received: by 2002:a05:6870:968b:b0:22e:f3cd:b69e with SMTP id
 o11-20020a056870968b00b0022ef3cdb69emr5076761oaq.54.1712802114696; Wed, 10
 Apr 2024 19:21:54 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Apr 2024 11:21:18 +0900
Message-ID: <CAODzB9oM1P0CiuaQ4EOUrAyAzY=LvLw1ow+2N+PsMosLBsF0qA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 02:22:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15539

Hi!

It's this week's CVE report.

This week reported 82 new CVEs and 16 updated CVEs.

* New CVEs

CVE-2024-26745: powerpc/pseries/iommu: IOMMU table is not initialized
for kdump over SR-IOV

Announce: https://lore.kernel.org/linux-cve-announce/2024040454-CVE-2024-26745-fa88@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b1fc44e ("pseries/iommu/ddw: Fix kdump to work in
absence of ibm,dma-window") in v6.0-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [09a3c1e46142199adcee372a420b024b4fc61051]
stable/6.1: [7eb95e0af5c9c2e6fad50356eaf32d216d0e7bc3]
stable/6.6: [d4d1e4b1513d975961de7bb4f75e450a92d65ebf]
stable/6.7: [5da6d306f315344af1ca2eff4bd9b10b130f0c28]

CVE-2024-26746: dmaengine: idxd: Ensure safe user copy of completion record

Announce: https://lore.kernel.org/linux-cve-announce/2024040457-CVE-2024-26746-8aa9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c2f156b ("dmaengine: idxd: create kmem cache for
event log fault items") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [d3ea125df37dc37972d581b74a5d3785c3f283ab]
stable/6.6: [5e3022ea42e490a36ec6f2cfa6fc603deb0bace4]
stable/6.7: [bb71e040323175e18c233a9afef32ba14fa64eb7]

CVE-2024-26750: af_unix: Drop oob_skb ref before purging queue in GC.

Announce: https://lore.kernel.org/linux-cve-announce/2024040457-CVE-2024-26750-4468@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 25236c91b ("af_unix: Fix task hung while purging
oob_skb in GC.") in 6.8-rc5.
This commit was backported to 5.15, 6.1, 6.6, and 6.7.
Fixed in 6.8-rc6.

Fixed status
mainline: [aa82ac51d63328714645c827775d64dbfd9941f3]
stable/5.15: [6c480d0f131862645d172ca9e25dc152b1a5c3a6]
stable/6.1: [c4c795b21dd23d9514ae1c6646c3fb2c78b5be60]
stable/6.6: [e9eac260369d0cf57ea53df95427125725507a0d]
stable/6.7: [43ba9e331559a30000c862eea313248707afa787]

CVE-2024-26780: af_unix: Fix task hung while purging oob_skb in GC.

Announce: https://lore.kernel.org/linux-cve-announce/2024040458-CVE-2024-26780-9951@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1279f9d ("af_unix: Call kfree_skb() for dead
unix_(sk)->oob_skb in GC.") in 6.8-rc4.
This commit was backported to 5.15, 6.1, 6.6, and 6.7.
Fixed in 6.8-rc5.

Fixed status
mainline: [25236c91b5ab4a26a56ba2e79b8060cf4e047839]
stable/5.15: [36f7371de977f805750748e80279be7e370df85c]
stable/6.1: [2a3d40b4025fcfe51b04924979f1653993b17669]
stable/6.6: [69e0f04460f4037e01e29f0d9675544f62aafca3]
stable/6.7: [cb8890318dde26fc89c6ea67d6e9070ab50b6e91]

CVE-2024-26781: mptcp: fix possible deadlock in subflow diag

Announce: https://lore.kernel.org/linux-cve-announce/2024040458-CVE-2024-26781-0389@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b8adb69 ("mptcp: fix lockless access in subflow
ULP diag") in 6.8-rc6.
This commit was backported to 5.10, 5.15, 6.1, 6.6, and 6.7.
Fixed in 6.8-rc7.

Fixed status
mainline: [d6a9608af9a75d13243d217f6ce1e30e57d56ffe]
stable/5.10: [70e5b013538d5e4cb421afed431a5fcd2a5d49ee]
stable/5.15: [cc32ba2fdf3f8b136619fff551f166ba51ec856d]
stable/6.1: [f27d319df055629480b84b9288a502337b6f2a2e]
stable/6.6: [fa8c776f4c323a9fbc8ddf25edcb962083391430]
stable/6.7: [d487e7ba1bc7444d5f062c4930ef8436c47c7e63]

CVE-2024-26782: mptcp: fix double-free on socket dismantle

Announce: https://lore.kernel.org/linux-cve-announce/2024040458-CVE-2024-26782-71ca@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cf7da0d ("mptcp: Create SUBFLOW socket for
incoming connections") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [10048689def7e40a4405acda16fdc6477d4ecc5c]
stable/5.10: [f74362a004225df935863dea6eb7d82daaa5b16e]
stable/5.15: [4a4eeb6912538c2d0b158e8d11b62d96c1dada4e]
stable/6.1: [d93fd40c62397326046902a2c5cb75af50882a85]
stable/6.6: [ce0809ada38dca8d6d41bb57ab40494855c30582]
stable/6.7: [85933e80d077c9ae2227226beb86c22f464059cc]

CVE-2024-26783: mm/vmscan: fix a bug calling wakeup_kswapd() with a
wrong zone index

Announce: https://lore.kernel.org/linux-cve-announce/2024040458-CVE-2024-26783-68c8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c574bbe ("NUMA balancing: optimize page placement
for memory tiering system") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [2774f256e7c0219e2b0a0894af1c76bdabc4f974]
stable/6.6: [d6159bd4c00594249e305bfe02304c67c506264e]
stable/6.7: [bdd21eed8b72f9e28d6c279f6db258e090c79080]

CVE-2024-26784: pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal

Announce: https://lore.kernel.org/linux-cve-announce/2024040459-CVE-2024-26784-9e9c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2af23ce ("pmdomain: arm: Add the SCMI performance
domain") in v6.7-rc1.
This commit is not backported to older stable kernel.
Fixed in v6.8-rc7.

Fixed status
mainline: [eb5555d422d0fc325e1574a7353d3c616f82d8b5]
stable/6.7: [f6aaf131e4d4a9a26040ecc018eb70ab8b3d355d]

CVE-2024-26785: iommufd: Fix protection fault in iommufd_test_syz_conv_iova

Announce: https://lore.kernel.org/linux-cve-announce/2024040459-CVE-2024-26785-857d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9227da7 ("iommufd: Add
iommufd_access_change_ioas(_id) helpers") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [cf7c2789822db8b5efa34f5ebcf1621bc0008d48]
stable/6.7: [fc719ecbca45c9c046640d72baddba3d83e0bc0b]

CVE-2024-26786: iommufd: Fix iopt_access_list_id overwrite bug

Announce: https://lore.kernel.org/linux-cve-announce/2024040459-CVE-2024-26786-802f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9227da7 ("iommufd: Add
iommufd_access_change_ioas(_id) helpers") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [aeb004c0cd6958e910123a1607634401009c9539]
stable/6.6: [f1fb745ee0a6fe43f1d84ec369c7e6af2310fda9]
stable/6.7: [9526a46cc0c378d381560279bea9aa34c84298a0]

CVE-2024-26787: mmc: mmci: stm32: fix DMA API overlapping mappings warning

Announce: https://lore.kernel.org/linux-cve-announce/2024040459-CVE-2024-26787-48c0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 46b723d ("mmc: mmci: add stm32 sdmmc variant") in
v4.20-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [6b1ba3f9040be5efc4396d86c9752cdc564730be]
stable/5.10: [0224cbc53ba82b84affa7619b6d1b1a254bc2c53]
stable/5.15: [5ae5060e17a3fc38e54c3e5bd8abd6b1d5bfae7c]
stable/6.1: [70af82bb9c897faa25a44e4181f36c60312b71ef]
stable/6.6: [176e66269f0de327375fc0ea51c12c2f5a97e4c4]
stable/6.7: [d610a307225951929b9dff807788439454476f85]

CVE-2024-26788: dmaengine: fsl-qdma: init irq after reg initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024040400-CVE-2024-26788-1f84@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b092529 ("dmaengine: fsl-qdma: Add qDMA
controller driver for Layerscape SoCs") in v5.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [87a39071e0b639f45e05d296cc0538eef44ec0bd]
stable/5.10: [9579a21e99fe8dab22a253050ddff28d340d74e1]
stable/5.15: [4529c084a320be78ff2c5e64297ae998c6fdf66b]
stable/5.4: [3cc5fb824c2125aa3740d905b3e5b378c8a09478]
stable/6.1: [474d521da890b3e3585335fb80a6044cb2553d99]
stable/6.6: [a69c8bbb946936ac4eb6a6ae1e849435aa8d947d]
stable/6.7: [677102a930643c31f1b4c512b041407058bdfef8]

CVE-2024-26789: crypto: arm64/neonbs - fix out-of-bounds access on short input

Announce: https://lore.kernel.org/linux-cve-announce/2024040400-CVE-2024-26789-1744@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fc074e1 ("crypto: arm64/aes-neonbs-ctr - fallback
to plain NEON for final chunk") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [1c0cf6d19690141002889d72622b90fc01562ce4]
stable/6.1: [034e2d70b5c7f578200ad09955aeb2aa65d1164a]
stable/6.6: [1291d278b5574819a7266568ce4c28bce9438705]
stable/6.7: [9e8ecd4908b53941ab6f0f51584ab80c6c6606c4]

CVE-2024-26790: dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Announce: https://lore.kernel.org/linux-cve-announce/2024040400-CVE-2024-26790-a4a4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b092529 ("dmaengine: fsl-qdma: Add qDMA
controller driver for Layerscape SoCs") in v5.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [9d739bccf261dd93ec1babf82f5c5d71dd4caa3e]
stable/5.10: [bb3a06e9b9a30e33d96aadc0e077be095a4f8580]
stable/5.15: [106c1ac953a66556ec77456c46e818208d3a9bce]
stable/5.4: [518d78b4fac68cac29a263554d7f3b19da99d0da]
stable/6.1: [237ecf1afe6c22534fa43abdf2bf0b0f52de0aaa]
stable/6.6: [5b696e9c388251f1c7373be92293769a489fd367]
stable/6.7: [ad2f8920c314e0a2d9e984fc94b729eca3cda471]

CVE-2024-26791: btrfs: dev-replace: properly validate device names

Announce: https://lore.kernel.org/linux-cve-announce/2024040400-CVE-2024-26791-1002@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc7.
Linux 4.4 may be affected. Vulnerable function would be
btrfs_dev_replace_start() in fs/btrfs/dev-replace.c.
(https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/fs/btrfs/dev-replace.c?h=linux-4.4.y-st#n308)

Fixed status
mainline: [9845664b9ee47ce7ee7ea93caf47d39a9d4552c4]
stable/4.19: [11d7a2e429c02d51e2dc90713823ea8b8d3d3a84]
stable/5.10: [2886fe308a83968dde252302884a1e63351cf16d]
stable/5.15: [ab2d68655d0f04650bef09fee948ff80597c5fb9]
stable/5.4: [c6652e20d7d783d060fe5f987eac7b5cabe31311]
stable/6.1: [f590040ce2b712177306b03c2a63b16f7d48d3c8]
stable/6.6: [b1690ced4d2d8b28868811fb81cd33eee5aefee1]
stable/6.7: [343eecb4ff49a7b1cc1dfe86958a805cf2341cfb]

CVE-2024-26792: btrfs: fix double free of anonymous device after
snapshot creation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024040401-CVE-2024-26792-6048@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e03ee2f ("btrfs: do not ASSERT() if the newly
created subvolume already got read") in 6.8-rc4.
This commit was backported to 5.10, 5.15, 6.1, 6.6, and 6.7.
Fixed in 6.8-rc7.

Fixed status
mainline: [e2b54eaf28df0c978626c9736b94f003b523b451]
stable/6.1: [c34adc20b91a8e55e048b18d63f4f4ae003ecf8f]
stable/6.6: [eb3441093aad251418921246fc3b224fd1575701]
stable/6.7: [c8ab7521665bd0f8bc4a900244d1d5a7095cc3b9]

CVE-2024-26793: gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Announce: https://lore.kernel.org/linux-cve-announce/2024040401-CVE-2024-26793-2beb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 459aa66 ("gtp: add initial driver for datapath of
GPRS Tunneling Protocol (GTP-U)") in v4.7-rc1.
Linux 4.4 is not affected.
Fixed in v6.8-rc7.

Fixed status
mainline: [616d82c3cfa2a2146dd7e3ae47bda7e877ee549e]
stable/4.19: [01129059d5141d62fae692f7a336ae3bc712d3eb]
stable/5.10: [e668b92a3a01429923fd5ca13e99642aab47de69]
stable/5.15: [9376d059a705c5dfaac566c2d09891242013ae16]
stable/5.4: [ec92aa2cab6f0048f10d6aa4f025c5885cb1a1b6]
stable/6.1: [abd32d7f5c0294c1b2454c5a3b13b18446bac627]
stable/6.6: [93dd420bc41531c9a31498b9538ca83ba6ec191e]
stable/6.7: [5366969a19a8a0d2ffb3d27ef6e8905e5e4216f8]

CVE-2024-26794: btrfs: fix race between ordered extent completion and fiemap

Announce:
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b0ad381 ("btrfs: fix deadlock with fiemap and
extent locking") in 6.8-rc6.
This commit was backported to 6.6 and 6.7.
Fixed in 6.8-rc7.

Fixed status
mainline: [a1a4a9ca77f143c00fce69c1239887ff8b813bec]
stable/6.6: [d43f8e58f10a44df8c08e7f7076f3288352cd168]
stable/6.7: [31d07a757c6d3430e03cc22799921569999b9a12]

CVE-2024-26795: riscv: Sparse-Memory/vmemmap out-of-bounds fix

Announce: https://lore.kernel.org/linux-cve-announce/2024040402-CVE-2024-26795-404a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d95f1a5 ("RISC-V: Implement sparsemem") in v5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [a11dd49dcb9376776193e15641f84fcc1e5980c9]
stable/5.10: [8af1c121b0102041809bc137ec600d1865eaeedd]
stable/5.15: [5941a90c55d3bfba732b32208d58d997600b44ef]
stable/6.1: [8310080799b40fd9f2a8b808c657269678c149af]
stable/6.6: [a278d5c60f21aa15d540abb2f2da6e6d795c3e6e]
stable/6.7: [2a1728c15ec4f45ed9248ae22f626541c179bfbe]

CVE-2024-26796: drivers: perf: ctr_get_width function for legacy is not defined

Announce: https://lore.kernel.org/linux-cve-announce/2024040402-CVE-2024-26796-85c5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cc4c07c ("drivers: perf: Implement perf event
mmap support  in the SBI backend") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [682dc133f83e0194796e6ea72eb642df1c03dfbe]
stable/6.6: [e0d17ee872cf8d0f51cc561329b8e1a0aa792bbb]
stable/6.7: [e4f50e85de5a6b21dfdc0d7ca435eba4f62935c3]

CVE-2024-26797: drm/amd/display: Prevent potential buffer overflow in
map_hw_resources

Announce: https://lore.kernel.org/linux-cve-announce/2024040402-CVE-2024-26797-704f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7966f31 ("drm/amd/display: Introduce DML2") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [0f8ca019544a252d1afb468ce840c6dcbac73af4]
stable/6.7: [50a6302cf881f67f1410461a68fe9eabd00ff31d]

CVE-2024-26798: fbcon: always restore the old font data in fbcon_do_set_font()

Announce: https://lore.kernel.org/linux-cve-announce/2024040402-CVE-2024-26798-191e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a5a9230 ("fbdev: fbcon: Properly revert changes
when vc_resize() failed") in v6.0-rc3.
This commit was backported to 5.15.
Fixed in v6.8-rc7.

Fixed status
mainline: [00d6a284fcf3fad1b7e1b5bc3cd87cbfb60ce03f]
stable/5.15: [20a4b5214f7bee13c897477168c77bbf79683c3d]
stable/6.1: [2f91a96b892fab2f2543b4a55740c5bee36b1a6b]
stable/6.6: [73a6bd68a1342f3a44cac9dffad81ad6a003e520]
stable/6.7: [a2c881413dcc5d801bdc9535e51270cc88cb9cd8]

CVE-2024-26799: ASoC: qcom: Fix uninitialized pointer dmactl

Announce: https://lore.kernel.org/linux-cve-announce/2024040403-CVE-2024-26799-1fd6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b81af58 ("ASoC: qcom: Add lpass CPU driver for
codec dma control") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [1382d8b55129875b2e07c4d2a7ebc790183769ee]
stable/6.6: [99adc8b4d2f38bf0d06483ec845bc48f60c3f8cf]
stable/6.7: [d5a7726e6ea62d447b79ab5baeb537ea6bdb225b]

CVE-2024-26800: tls: fix use-after-free on failed backlog decryption

Announce: https://lore.kernel.org/linux-cve-announce/2024040403-CVE-2024-26800-0bf4@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8590541 ("net: tls: handle backlogging of crypto
requests") in 6.8-rc5.
This commit was backported to 6.1, 6.6, and 6.7.
Fixed in 6.8-rc7.

Fixed status
mainline: [13114dc5543069f7b97991e3b79937b6da05f5b0]
stable/6.1: [f2b85a4cc763841843de693bbd7308fe9a2c4c89]
stable/6.6: [81be85353b0f5a7b660635634b655329b429eefe]
stable/6.7: [1ac9fb84bc7ecd4bc6428118301d9d864d2a58d1]

CVE-2024-26801: Bluetooth: Avoid potential use-after-free in hci_error_reset

Announce: https://lore.kernel.org/linux-cve-announce/2024040403-CVE-2024-26801-da9f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c7741d1 ("Bluetooth: Perform a power cycle when
receiving hardware error event") in v4.0-rc1.
Fixed in v6.8-rc7.

Fixed status
mainline: [2449007d3f73b2842c9734f45f0aadb522daf592]
stable/4.19: [e0b278650f07acf2e0932149183458468a731c03]
stable/5.10: [6dd0a9dfa99f8990a08eb8fdd8e79bee31c7d8e2]
stable/5.15: [da4569d450b193e39e87119fd316c0291b585d14]
stable/5.4: [98fb98fd37e42fd4ce13ff657ea64503e24b6090]
stable/6.1: [45085686b9559bfbe3a4f41d3d695a520668f5e1]
stable/6.6: [2ab9a19d896f5a0dd386e1f001c5309bc35f433b]
stable/6.7: [dd594cdc24f2e48dab441732e6dfcafd6b0711d1]

CVE-2024-26802: stmmac: Clear variable when destroying workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024040403-CVE-2024-26802-b3da@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5a55861 ("net: stmmac: support FPE link partner
hand-shaking procedure") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [8af411bbba1f457c33734795f024d0ef26d0963f]
stable/5.15: [8e99556301172465c8fe33c7f78c39a3d4ce8462]
stable/6.1: [17ccd9798fe0beda3db212cfa3ebe373f605cbd6]
stable/6.6: [699b103e48ce32d03fc86c35b37ee8ae4288c7e3]
stable/6.7: [f72cf22dccc94038cbbaa1029cb575bf52e5cbc8]

CVE-2024-26803: net: veth: clear GRO when clearing XDP even when down

Announce: https://lore.kernel.org/linux-cve-announce/2024040404-CVE-2024-26803-9985@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d3256ef ("veth: allow enabling NAPI even without
XDP") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [fe9f801355f0b47668419f30f1fac1cf4539e736]
stable/5.15: [f011c103e654d83dc85f057a7d1bd0960d02831c]
stable/6.1: [7985d73961bbb4e726c1be7b9cd26becc7be8325]
stable/6.6: [16edf51f33f52dff70ed455bc40a6cc443c04664]
stable/6.7: [8f7a3894e58e6f5d5815533cfde60e3838947941]

CVE-2024-26804: net: ip_tunnel: prevent perpetual headroom growth

Announce: https://lore.kernel.org/linux-cve-announce/2024040404-CVE-2024-26804-a6ff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 243aad8 ("ip_gre: include route header_len in
max_headroom calculation") in v2.6.34-rc3.
Fixed in v6.8-rc7.

Fixed status
mainline: [5ae1e9922bbdbaeb9cfbe91085ab75927488ac0f]
stable/5.10: [2e95350fe9db9d53c701075060ac8ac883b68aee]
stable/5.15: [afec0c5cd2ed71ca95a8b36a5e6d03333bf34282]
stable/5.4: [f81e94d2dcd2397137edcb8b85f4c5bed5d22383]
stable/6.1: [ab63de24ebea36fe73ac7121738595d704b66d96]
stable/6.6: [a0a1db40b23e8ff86dea2786c5ea1470bb23ecb9]
stable/6.7: [049d7989c67e8dd50f07a2096dbafdb41331fb9b]

CVE-2024-26805: netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Announce: https://lore.kernel.org/linux-cve-announce/2024040404-CVE-2024-26805-7016@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1853c94 ("netlink, mmap: transform mmap skb into
full skb on taps") in v4.3-rc3.
Fixed in v6.8-rc7.

Fixed status
mainline: [661779e1fcafe1b74b3f3fe8e980c1e207fea1fd]
stable/4.19: [ec343a55b687a452f5e87f3b52bf9f155864df65]
stable/5.10: [f19d1f98e60e68b11fc60839105dd02a30ec0d77]
stable/5.15: [c71ed29d15b1a1ed6c464f8c3536996963046285]
stable/5.4: [9ae51361da43270f4ba0eb924427a07e87e48777]
stable/6.1: [0b27bf4c494d61e5663baa34c3edd7ccebf0ea44]
stable/6.6: [d3ada42e534a83b618bbc1e490d23bf0fdae4736]
stable/6.7: [59fc3e3d049e39e7d0d271f20dd5fb47c57faf1d]

CVE-2024-26806: spi: cadence-qspi: remove system-wide suspend helper
calls from runtime PM hooks

Announce: https://lore.kernel.org/linux-cve-announce/2024040404-CVE-2024-26806-4644@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0578a6d ("spi: spi-cadence-quadspi: add runtime
pm support") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [959043afe53ae80633e810416cee6076da6e91c6]
stable/6.7: [041562ebc4759c9932b59a06527f8753b86da365]

CVE-2024-26807: spi: cadence-qspi: fix pointer reference in runtime PM hooks

Announce: https://lore.kernel.org/linux-cve-announce/2024040405-CVE-2024-26807-c071@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2087e85 ("spi: cadence-quadspi: fix
suspend-resume implementations") in v6.4-rc1.
This commit is backported to 4.19, 5.10, 5.15, 5.4, and 6.1.
Fixed in v6.8-rc7.

Fixed status
mainline: [32ce3bb57b6b402de2aec1012511e7ac4e7449dc]
stable/6.6: [03f1573c9587029730ca68503f5062105b122f61]
stable/6.7: [34e1d5c4407c78de0e3473e1fbf8fb74dbe66d03]

CVE-2024-26808: netfilter: nft_chain_filter: handle NETDEV_UNREGISTER
for inet/ingress basechain

Announce: https://lore.kernel.org/linux-cve-announce/2024040458-CVE-2024-26808-2df2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 60a3815 ("netfilter: add inet ingress support")
in v5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc2.

Fixed status
mainline: [01acb2e8666a6529697141a6017edbf206921913]
stable/5.10: [9489e214ea8f2a90345516016aa51f2db3a8cc2f]
stable/5.15: [70f17b48c86622217a58d5099d29242fc9adac58]
stable/6.1: [af149a46890e8285d1618bd68b8d159bdb87fdb3]
stable/6.6: [e5888acbf1a3d8d021990ce6c6061fd5b2bb21b4]
stable/6.7: [36a0a80f32209238469deb481967d777a3d539ee]

CVE-2024-26809: netfilter: nft_set_pipapo: release elements in clone
only from destroy path

Announce: https://lore.kernel.org/linux-cve-announce/2024040401-CVE-2024-26809-b0d1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9827a0e ("netfilter: nft_set_pipapo: release
elements in clone from abort path") in v5.19-rc6.
This commit was backported to 5.10 and 5.15.
Fixed in v6.9-rc1.

Fixed status
mainline: [b0e256f3dd2ba6532f37c5c22e07cb07a36031ee]
stable/5.10: [b36b83297ff4910dfc8705402c8abffd4bbf8144]
stable/5.15: [362508506bf545e9ce18c72a2c48dcbfb891ab9c]
stable/6.1: [5ad233dc731ab64cdc47b84a5c1f78fff6c024af]
stable/6.6: [ff90050771412b91e928093ccd8736ae680063c2]
stable/6.7: [821e28d5b506e6a73ccc367ff792bd894050d48b]

CVE-2024-26810: vfio/pci: Lock external INTx masking ops

Announce: https://lore.kernel.org/linux-cve-announce/2024040548-CVE-2024-26810-4371@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 89e1f7d ("vfio: Add PCI device driver") in v3.6-rc1.
Fixed in v6.9-rc1.
Backporting the fix to 4.19 was failed.
https://lore.kernel.org/stable/20240327122702.2841569-1-sashal@kernel.org/
Patch for 5.4 and 5.10 is available.
https://lore.kernel.org/stable/20240401165302.3699643-1-alex.williamson@redhat.com/

Fixed status
mainline: [810cd4bb53456d0503cc4e7934e063835152c1b7]
stable/5.15: [ec73e079729258a05452356cf6d098bf1504d5a6]
stable/6.1: [3fe0ac10bd117df847c93408a9d428a453cd60e5]
stable/6.6: [04a4a017b9ffd7b0f427b8c376688d14cb614651]
stable/6.8: [03505e3344b0576fd619416793a31eae9c5b73bf]

CVE-2024-26812: vfio/pci: Create persistent INTx handler

Announce: https://lore.kernel.org/linux-cve-announce/2024040550-CVE-2024-26812-1e08@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 89e1f7d ("vfio: Add PCI device driver") in v3.6-rc1.
Fixed in v6.9-rc1.
Backporting the fix to 4.19 was failed.
https://lore.kernel.org/stable/20240327122755.2842328-1-sashal@kernel.org/
Patch for 5.4 and 5.10 is available.
https://lore.kernel.org/stable/20240401165302.3699643-1-alex.williamson@redhat.com/

Fixed status
mainline: [18c198c96a815c962adc2b9b77909eec0be7df4d]
stable/5.15: [4cb0d7532126d23145329826c38054b4e9a05e7c]
stable/6.1: [7d29d4c72c1e196cce6969c98072a272d1a703b3]
stable/6.6: [69276a555c740acfbff13fb5769ee9c92e1c828e]
stable/6.8: [0e09cf81959d9f12b75ad5c6dd53d237432ed034]

CVE-2024-26813: vfio/platform: Create persistent IRQ handlers

Announce: https://lore.kernel.org/linux-cve-announce/2024040551-CVE-2024-26813-b9e8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 57f972e ("vfio/platform: trigger an interrupt via
eventfd") in v4.1-rc1.
Fixed in v6.9-rc1.
Backporting the fix to 4.19 was failed.
https://lore.kernel.org/stable/20240327122707.2841648-1-sashal@kernel.org/
Patch for 5.4 and 5.10 is available
https://lore.kernel.org/stable/20240401165302.3699643-6-alex.williamson@redhat.com/

Fixed status
mainline: [675daf435e9f8e5a5eab140a9864dfad6668b375]
stable/5.15: [cc5838f19d39a5fef04c468199699d2a4578be3a]
stable/6.1: [7932db06c82c5b2f42a4d1a849d97dba9ce4a362]
stable/6.6: [62d4e43a569b67929eb3319780be5359694c8086]
stable/6.8: [0f8d8f9c2173a541812dd750529f4a415117eb29]

CVE-2024-26814: vfio/fsl-mc: Block calling interrupt handler without trigger

Announce: https://lore.kernel.org/linux-cve-announce/2024040551-CVE-2024-26814-b578@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cc0ee20 ("vfio/fsl-mc: trigger an interrupt via
eventfd") in v5.10-rc1.
Fixed in v6.9-rc1.
Patch for 5.4 and 5.10 is available
https://lore.kernel.org/stable/20240401165302.3699643-6-alex.williamson@redhat.com/

Fixed status
mainline: [7447d911af699a15f8d050dfcb7c680a86f87012]
stable/5.15: [b7a2f0955ffceffadfe098b40b50307431f45438]
stable/6.1: [083e750c9f5f4c3bf61161330fb84d7c8e8bb417]
stable/6.6: [ee0bd4ad780dfbb60355b99f25063357ab488267]
stable/6.8: [bf0bc84a20e6109ab07d5dc072067bd01eb931ec]

CVE-2024-27437: vfio/pci: Disable auto-enable of exclusive INTx IRQ

Announce: https://lore.kernel.org/linux-cve-announce/2024040551-CVE-2024-27437-cc07@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 89e1f7d ("vfio: Add PCI device driver") in v3.6-rc1.
Fixed in v6.9-rc1.
Backporting the fix to 4.19 was failed.
https://lore.kernel.org/stable/20240327122510.2840000-1-sashal@kernel.org/
Patch for 5.4 and 5.10 is available
https://lore.kernel.org/stable/20240401165302.3699643-6-alex.williamson@redhat.com/

Fixed status
mainline: [fe9a7082684eb059b925c535682e68c34d487d43]
stable/5.15: [b7a2f0955ffceffadfe098b40b50307431f45438]
stable/6.1: [139dfcc4d723ab13469881200c7d80f49d776060]
stable/6.6: [2a4a666c45107206605b7b5bc20545f8aabc4fa2]
stable/6.8: [bf0bc84a20e6109ab07d5dc072067bd01eb931ec]

CVE-2024-26811: ksmbd: validate payload size in ipc response

Announce: https://lore.kernel.org/linux-cve-announce/2024040822-CVE-2024-26811-f7f5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc3.
The ksmbd was introduced in 5.15 so prior to Linux 5.15 is not affected.

Fixed status
mainline: [a677ebd8ca2f2632ccdecbad7b87641274e15aac]
stable/6.1: [51a6c2af9d20203ddeeaf73314ba8854b38d01bd]
stable/6.6: [a637fabac554270a851033f5ab402ecb90bc479c]
stable/6.8: [76af689a45aa44714b46d1a7de4ffdf851ded896]

CVE-2024-2201: Mitigations for the native BHI hardware vulnerabilty

Announce: https://www.vusec.net/projects/native-bhi/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in the master branch.

For vulnerability detail, please see:
https://vusec.net/projects/native-bhi
https://vusec.net/projects/bhi-spectre-bhb

Fixed status
mainline: [0cd01ac5dcb1e18eb18df0f0d05b5de76522a437,
1e3ad78334a69b36e107232e337f9d693dcc9df2,
  7390db8aea0d64e9deb28b8e1ce716f5020c7ee5,
0f4a837615ff925ba62648d280a861adf1582df7,
  be482ff9500999f56093738f9219bbabc729d163,
ec9404e40e8f36421a2b66ecb76dc2209fe7f3ef,
  95a6ccbdc7199a14b71ad8901cb788ba7fb5167b,
ed2e8d49b54d677f3123668a21a57822d679651f]
stable/5.15: [276fb9a658d0f44bc2e11b5f838cbe4e5759a223,
55516b355b0c6c747fa89edc53f10cf4b03441ef,
  bd53ec80f21839cfd4d852a6088279d602d67e5b,
a9ca0e34a406b5e122ad1e9b7e12a4281fccfca1,
  aa6247c9da2571afafd2bf7c709b0535f66d3900,
f825494f2c6fab421c5c59b5def321775c825818,
  c2b9e038896f01ba4bec87cfc97573b7f1b736d6,
a976b129dc868561f6cbb5e2dafe2345f32450e8]
stable/6.1: [fd52c0397b53ebcd4931981b3bc38f3b760b74df,
74fcb181772e5b8a8f1244c7393c56ae6d03c330,
  07dbb10f153f483e8249acebdffedf922e2ec2e1,
29c50bb6fbe4598d313ddb7ddb183e8b3d7bdf80,
  42196bdec0824900b02bc21e02e9bb139197ca14,
bb8384b6dfbc49be230071d1e844a8741982b1ec,
  43704e993ae54b8caf821501229dd2534ecb0e56,
3e4283b77107d1105a378859eb196e3ba5661270,
  e21838dfd0844b093a92d4cdd4db836b473c912d]
stable/6.6: [108feca9e47df1bed26ac7b04306587d9ebccda3,
eb0f175b34287f886019b86ac2f410df331d2c34,
  eb36b0dce2138581bc6b5e39d0273cb4c96ded81,
c6e3d590d0514612d96c572cba66ae0cb4b505a2,
  118794d0a572c7a8514dc774e68b59d41857b81c,
d414b401f9539858574a19af4ffc0fc0d53bfb8f,
  1c42ff893a8fb802dd90ca06af928826fdf0d16b,
cb238e95ee72a64e53a4f93181aae634cc0d3be6,
  6d9ef0c36980ef051cb55aeefb6438429e37268a]
stable/6.8: [36264ae643789d014a81bc9427797a5af607150e,
33257e28bf6d8691a040b7f1f5cd13997539f717,
  8f51637712e4da5be410a1666f8aee0d86eef898,
aec26bd00ed73c21f8f98b3e1667bc4cf016a9cf,
  a96b54b4b839536b8ffa81ec0b831d3106243a23,
a39bfa52671beb750fa2e1c7400469cde9c8ff9f,
  2bf604dc494f9f747eee62e7d46b2c179aa243dc,
15d6de3746ed724b93aca6c16e1ada68d379cb48]


CVE-2024-25742: Instruction raise #VC exception at exit

Announce: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3008.html
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in 6.9-rc1.
This bug is AMD CPU specific.
CVE-2024-25742 and CVE-2024-25743 were fixed by same commits. However,
there is no information about difference between CVE-2024-25742 and
CVE-2024-25743 yet.

Fixed status
mainline: [b82a8dbd3d2f4563156f7150c6f2ecab6e960b30,
be5341eb0d43b1e754799498bd2e8756cc167a41,
  55617fb991df535f953589586468612351575704,
f4116bfc44621882556bbf70f5284fbf429a5cf6,
  e3ef461af35a8c74f2f4ce6616491ddb355a208f]
stable/6.1: [b8ec27ae221eee458b15b700706db311474ac619,
d5f999317e83efc07b8a7d26f9556b1271a6d373,
  e09d243a518b5634201f88a5d894e8dc4d37215c,
cde700ceb0eaad67792fb2c22f44bf8a08e548f5]
stable/6.6: [34c686e5be2fa1c03ae09568159a9ef37d1c7cf5,
4591766ff6552339fbaa3d3c71814faef1988c2f,
  22ca647c8f880f21881e9b2d38070dc61196a39d,
239bff0171a86e1bafd7da03631d74df1dfec6f1]

CVE-2024-25743: Instruction raise #VC exception at exit

Announce:
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in 6.9-rc1.
This bug is AMD CPU specific.
CVE-2024-25742 and CVE-2024-25743 were fixed by same commits. However,
there is no information about difference between CVE-2024-25742 and
CVE-2024-25743 yet.

Fixed status
mainline: [b82a8dbd3d2f4563156f7150c6f2ecab6e960b30,
be5341eb0d43b1e754799498bd2e8756cc167a41,
  55617fb991df535f953589586468612351575704,
f4116bfc44621882556bbf70f5284fbf429a5cf6,
e3ef461af35a8c74f2f4ce6616491ddb355a208f]
stable/6.1: [b8ec27ae221eee458b15b700706db311474ac619,
d5f999317e83efc07b8a7d26f9556b1271a6d373,
  e09d243a518b5634201f88a5d894e8dc4d37215c,
cde700ceb0eaad67792fb2c22f44bf8a08e548f5]
stable/6.6: [34c686e5be2fa1c03ae09568159a9ef37d1c7cf5,
4591766ff6552339fbaa3d3c71814faef1988c2f,
  22ca647c8f880f21881e9b2d38070dc61196a39d,239bff0171a86e1bafd7da03631d74df1dfec6f1]

CVE-2021-47181: usb: musb: tusb6010: check return value after calling
platform_get_resource()

Announce: https://lore.kernel.org/linux-cve-announce/2024041029-CVE-2021-47181-13bb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

Fixed status
cip/4.4: [1ba7605856e05fa991d4654ac69e5ace66c767b9]
cip/4.4-rt: [1ba7605856e05fa991d4654ac69e5ace66c767b9]
cip/4.4-st: [1ba7605856e05fa991d4654ac69e5ace66c767b9]
mainline: [14651496a3de6807a17c310f63c894ea0c5d858e]
stable/4.19: [f87a79c04a33ab4e5be598c7b0867e6ef193d702]
stable/4.4: [1ba7605856e05fa991d4654ac69e5ace66c767b9]
stable/5.10: [679eee466d0f9ffa60a2b0c6ec19be5128927f04]
stable/5.15: [06cfb4cb2241e704d72e3045cf4d7dfb567fbce0]
stable/5.4: [3ee15f1af17407be381bcf06a78fa60b471242dd]

CVE-2021-47182: scsi: core: Fix scsi_mode_sense() buffer length handling

Announce: https://lore.kernel.org/linux-cve-announce/2024041032-CVE-2021-47182-377e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
It seems as if all stable kernels are affected.

Fixed status
mainline: [17b49bcbf8351d3dbe57204468ac34f033ed60bc]
stable/5.15: [e15de347faf4a9f494cbd4e9a623d343dc1b5851]

CVE-2021-47183: scsi: lpfc: Fix link down processing to address NULL
pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024041033-CVE-2021-47183-e130@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
It looks as if commit db7531d2 ("scsi: lpfc: Convert abort handling to
SLI-3 and SLI-4 handlers") introduced by this issue.

Fixed status
mainline: [1854f53ccd88ad4e7568ddfafafffe71f1ceb0a6]
stable/5.15: [28de48a7cea495ab48082d9ff4ef63f7cb4e563a]

CVE-2021-47184: i40e: Fix NULL ptr dereference on VSI filter sync

Announce: https://lore.kernel.org/linux-cve-announce/2024041033-CVE-2021-47184-7544@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 41c445f ("i40e: main driver core") in v3.12-rc1.
Fixed in v5.16-rc2.

Fixed status
mainline: [37d9e304acd903a445df8208b8a13d707902dea6]
stable/4.19: [87c421ab4a43433cb009fea44bbbc77f46913e1d]
stable/5.10: [f866513ead4370402428ef724b03c3312295c178]
stable/5.15: [e91e8427a1e1633a0261e3bb0201c836ac5b3890]
stable/5.4: [c30162da91327e4cdf7cd03079f096bb3654738c]

CVE-2021-47185: tty: tty_buffer: Fix the softlockup issue in flush_to_ldisc

Announce: https://lore.kernel.org/linux-cve-announce/2024041033-CVE-2021-47185-c363@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

Fixed status
cip/4.4: [0380f643f3a7a61b0845cdc738959c2ad5735d61]
cip/4.4-rt: [0380f643f3a7a61b0845cdc738959c2ad5735d61]
cip/4.4-st: [0380f643f3a7a61b0845cdc738959c2ad5735d61]
mainline: [3968ddcf05fb4b9409cd1859feb06a5b0550a1c1]
stable/4.19: [4f300f47dbcf9c3d4b2ea76c8554c8f360400725]
stable/4.4: [0380f643f3a7a61b0845cdc738959c2ad5735d61]
stable/5.10: [77e9fed33056f2a88eba9dd4d2d5412f0c7d1f41]
stable/5.15: [5c34486f04700f1ba04907231dce0cc2705c2d7d]
stable/5.4: [d491c84df5c469dd9621863b6a770b3428137063]

CVE-2021-47186: tipc: check for null after calling kmemdup

Announce: https://lore.kernel.org/linux-cve-announce/2024041033-CVE-2021-47186-7287@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc2.
It looks as if it was introduced by commit 1ef6f7c939 ("tipc: add
automatic session key exchange") in 5.10-rc1.

Fixed status
mainline: [3e6db079751afd527bf3db32314ae938dc571916]
stable/5.10: [a7d91625863d4ffed63b993b5e6dc1298b6430c9]
stable/5.15: [9404c4145542c23019a80ab1bb2ecf73cd057b10]

CVE-2021-47187: arm64: dts: qcom: msm8998: Fix CPU/L2 idle state
latency and residency

Announce: https://lore.kernel.org/linux-cve-announce/2024041034-CVE-2021-47187-b158@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
It looks as if it was introduced by commit c3083c8 ("arm64: dts: qcom:
msm8998: Add PSCI cpuidle low power states") in 5.3-rc1.

Fixed status
mainline: [3f1dcaff642e75c1d2ad03f783fa8a3b1f56dd50]
stable/5.10: [e52fecdd0c142b95c720683885b06ee3f0e065c8]
stable/5.15: [118c826ef8b43efe0fda8faf419673707ee8c5e5]
stable/5.4: [a14d7038ea201c5526375becfc43b9ba281b1e82]

CVE-2021-47188: scsi: ufs: core: Improve SCSI abort handling

Announce: https://lore.kernel.org/linux-cve-announce/2024041034-CVE-2021-47188-092a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7a3e97b ("[SCSI] ufshcd: UFS Host controller
driver") in v3.4-rc1.
Fixed in v5.16-rc2.
Backporting the fix to 4.4, 4.19, 5.4, and 5.10 were failed.
- 4.4: https://lore.kernel.org/stable/164302218723442@kroah.com/
- 4.19: https://lore.kernel.org/stable/1643022186182229@kroah.com/
- 5.4: https://lore.kernel.org/stable/164302218620219@kroah.com/
- 5.10: https://lore.kernel.org/stable/164302218510944@kroah.com/

Fixed status
mainline: [3ff1f6b6ba6f97f50862aa50e79959cc8ddc2566]
stable/5.15: [c36baca06efa833adaefba61f45fefdc49b6d070]

CVE-2021-47189: btrfs: fix memory ordering between normal and ordered
work functions

Announce: https://lore.kernel.org/linux-cve-announce/2024041034-CVE-2021-47189-a3f4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 08a9ff3 ("btrfs: Added btrfs_workqueue_struct
implemented ordered execution based on kernel workqueue") in
v3.15-rc1.
Fixed in v5.16-rc2.

Fixed status
cip/4.4: [bd660a20fea3ec60a49709ef5360f145ec0fe779]
cip/4.4-rt: [bd660a20fea3ec60a49709ef5360f145ec0fe779]
cip/4.4-st: [bd660a20fea3ec60a49709ef5360f145ec0fe779]
mainline: [45da9c1767ac31857df572f0a909fbe88fd5a7e9]
stable/4.19: [ed058d735a70f4b063323f1a7bb33cda0f987513]
stable/4.4: [bd660a20fea3ec60a49709ef5360f145ec0fe779]
stable/5.10: [6adbc07ebcaf8bead08b21687d49e0fc94400987]
stable/5.15: [47e6f9f69153247109042010f3a77579e9dc61ff]
stable/5.4: [670f6b3867c8f0f11e5097f353b164cecfec6179]

CVE-2021-47190: perf bpf: Avoid memory leak from perf_env__insert_btf()

Announce: https://lore.kernel.org/linux-cve-announce/2024041034-CVE-2021-47190-0261@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3792cb2 ("perf bpf: Save BTF in a rbtree in
perf_env") in v5.1-rc2.
Fixed in v5.16-rc1.

Fixed status
mainline: [4924b1f7c46711762fd0e65c135ccfbcfd6ded1f]
stable/5.10: [11589d3144bc4e272e0aae46ce8156162e99babc]
stable/5.15: [ab7c3d8d81c511ddfb27823fb07081c96422b56e]
stable/5.4: [642fc22210a5e59d40b1e4d56d21ec3effd401f2]

CVE-2021-47191: scsi: scsi_debug: Fix out-of-bound read in resp_readcap16()

Announce: https://lore.kernel.org/linux-cve-announce/2024041034-CVE-2021-47191-ec4f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

Fixed status
mainline: [4e3ace0051e7e504b55d239daab8789dd89b863c]
stable/5.10: [3e20cb072679bdb47747ccc8bee3233a4cf0765a]
stable/5.15: [5b8bed6464ad6653586e30df046185fd816ad999]

CVE-2021-47192: scsi: core: sysfs: Fix hang when device state is set via sysfs

Announce: https://lore.kernel.org/linux-cve-announce/2024041035-CVE-2021-47192-3d45@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f0f82e2 ("scsi: core: Fix capacity set to zero
after offlinining device") in v5.14-rc5.
Fixed in v5.16-rc2.
Linux 4.19 and 5.4 both use get_unaligned_be32() to get alloc_len
value so they seem to be affected.
Linux 4.4 calculates alloc_len value in the resp_readcap16(). It might
be nice to apply the fix.

Fixed status
mainline: [4edd8cd4e86dd3047e5294bbefcc0a08f66a430f]
stable/5.10: [a792e0128d232251edb5fdf42fb0f9fbb0b44a73]
stable/5.15: [bcc0e3175a976b7fa9a353960808adb0bb49ead8]
stable/5.4: [edd783162bf2385b43de6764f2d4c6e9f4f6be27]

CVE-2021-47193: scsi: pm80xx: Fix memory leak during rmmod

Announce: https://lore.kernel.org/linux-cve-announce/2024041035-CVE-2021-47193-c4b0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
It looks as if it was intorudced by commit 5a141315 ("csi: pm80xx:
Increase the number of outstanding I/O supported to 1024") in
5.10-rc1.

Fixed status
mainline: [51e6ed83bb4ade7c360551fa4ae55c4eacea354b]
stable/5.15: [269a4311b15f68d24e816f43f123888f241ed13d]

CVE-2021-47194: cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

Announce: https://lore.kernel.org/linux-cve-announce/2024041035-CVE-2021-47194-51cd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ac80014 ("cfg80211: .stop_ap when interface is
going down") in v3.6-rc1.
Fixed in v5.16-rc2.

Fixed status
cip/4.4: [8f06bb8c216bcd172394f61e557727e691b4cb24]
cip/4.4-rt: [8f06bb8c216bcd172394f61e557727e691b4cb24]
cip/4.4-st: [8f06bb8c216bcd172394f61e557727e691b4cb24]
mainline: [563fbefed46ae4c1f70cffb8eb54c02df480b2c2]
stable/4.19: [b8a045e2a9b234cfbc06cf36923886164358ddec]
stable/4.4: [8f06bb8c216bcd172394f61e557727e691b4cb24]
stable/5.10: [7b97b5776daa0b39dbdadfea176f9cc0646d4a66]
stable/5.15: [5a9b671c8d74a3e1b999e7a0c7f366079bcc93dd]
stable/5.4: [52affc201fc22a1ab9a59ef0ed641a9adfcb8d13]

CVE-2021-47195: spi: fix use-after-free of the add_lock mutex

Announce: https://lore.kernel.org/linux-cve-announce/2024041035-CVE-2021-47195-38e8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6098475 ("spi: Fix deadlock when adding SPI
controllers on SPI buses") in v5.15-rc6.
Fixed in v5.16-rc2.

Fixed status
mainline: [6c53b45c71b4920b5e62f0ea8079a1da382b9434]
stable/5.15: [37330f37f6666c7739a44b2b6b95b047ccdbed2d]

CVE-2021-47196: RDMA/core: Set send and receive CQ before forwarding
to the driver

Announce: https://lore.kernel.org/linux-cve-announce/2024041036-CVE-2021-47196-d1b8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 514aee6 ("RDMA: Globally allocate and release QP
memory") in v5.15-rc1.
Fixed in v5.16-rc2.

Fixed status
mainline: [6cd7397d01c4a3e09757840299e4f114f0aa5fa0]
stable/5.15: [b70e072feffa0ba5c41a99b9524b9878dee7748e]

CVE-2021-47197: net/mlx5e: nullify cq->dbg pointer in mlx5_debug_cq_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2024041036-CVE-2021-47197-aaec@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 94b960b ("net/mlx5e: Fix memory leak in
mlx5_core_destroy_cq() error path") in v5.15-rc6.
Fixed in v5.16-rc2.

Fixed status
mainline: [76ded29d3fcda4928da8849ffc446ea46871c1c2]
stable/5.10: [471c492890557bd58f73314bb4ad85d5a8fd5026]
stable/5.15: [2ae38157080616a13a9fe3f0b4b6ec0070aa408a]

CVE-2021-47198: scsi: lpfc: Fix use-after-free in lpfc_unreg_rpi() routine

Announce: https://lore.kernel.org/linux-cve-announce/2024041036-CVE-2021-47198-2426@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
The lpfc_reg_fab_ctrl_node() and lpfc_mbx_cmpl_fc_reg_login() were
introduced by commit
fe83e3b9 ("scsi: lpfc: Fix node handling for Fabric Controller and
Domain Controller") in 5.14-rc1.

Fixed status
mainline: [79b20beccea3a3938a8500acef4e6b9d7c66142f]
stable/5.15: [dbebf865b3239595c1d4dba063b122862583b52a]

CVE-2021-47199: net/mlx5e: CT, Fix multiple allocations and memleak of mod acts

Announce: https://lore.kernel.org/linux-cve-announce/2024041036-CVE-2021-47199-604a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1ef3018 ("net/mlx5e: CT: Support clear action")
in v5.7-rc1.
Fixed in v5.16-rc2.

Fixed status
mainline: [806401c20a0f9c51b6c8fd7035671e6ca841f6c2]
stable/5.15: [486e8de6e233ff2999493533c6259d1cb538653b]

CVE-2021-47200: drm/prime: Fix use after free in mmap with drm_gem_ttm_mmap

Announce: https://lore.kernel.org/linux-cve-announce/2024041037-CVE-2021-47200-ae55@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9786b65 ("drm/ttm: fix mmap refcounting") in v5.5-rc1.
Fixed in v5.16-rc1.
Backporting the fix to 5.10 was failed.
- 5.10: https://lore.kernel.org/stable/163766826320226@kroah.com/

Fixed status
mainline: [8244a3bc27b3efd057da154b8d7e414670d5044f]
stable/5.15: [4f8e469a2384dfa4047145b0093126462cbb6dc0]

CVE-2021-47201: iavf: free q_vectors before queues in iavf_disable_vf

Announce: https://lore.kernel.org/linux-cve-announce/2024041037-CVE-2021-47201-d7c8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 65c7006 ("i40evf: assign num_active_queues inside
i40evf_alloc_queues") in v4.13-rc1.
Fixed in v5.16-rc2.

Fixed status
mainline: [89f22f129696ab53cfbc608e0a2184d0fea46ac1]
stable/5.10: [78638b47132244e3934dc5dc79f6372d5ce8e98c]
stable/5.15: [9ef6589cac9a8c47f5544ccdf4c498093733bb3f]
stable/5.4: [926e8c83d4c1c2dac0026637eb0d492df876489e]

CVE-2021-47202: thermal: Fix NULL pointer dereferences in of_thermal_ functions

Announce: https://lore.kernel.org/linux-cve-announce/2024041037-CVE-2021-47202-58b2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
It looks as if Linux 4.x is affected.

Fixed status
mainline: [96cfe05051fd8543cdedd6807ec59a0e6c409195]
stable/5.10: [6a315471cb6a07f651e1d3adc8962730f4fcccac]
stable/5.15: [ef2590a5305e0b8e9342f84c2214aa478ee7f28e]
stable/5.4: [828f4c31684da94ecf0b44a2cbd35bbede04f0bd]

CVE-2021-47203: scsi: lpfc: Fix list_add() corruption in lpfc_drain_txq()

Announce: https://lore.kernel.org/linux-cve-announce/2024041037-CVE-2021-47203-ff72@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

Fixed status
cip/4.4: [ad4776b5eb2e58af1226847fcd3b4f6d051674dd]
cip/4.4-rt: [ad4776b5eb2e58af1226847fcd3b4f6d051674dd]
cip/4.4-st: [ad4776b5eb2e58af1226847fcd3b4f6d051674dd]
mainline: [99154581b05c8fb22607afb7c3d66c1bace6aa5d]
stable/4.19: [b291d147d0268e93ad866f8bc820ea14497abc9b]
stable/4.4: [ad4776b5eb2e58af1226847fcd3b4f6d051674dd]
stable/5.10: [c097bd5a59162156d9c2077a2f58732ffbaa9fca]
stable/5.15: [814d3610c4ce86e8cf285b2cdac0057a42e82de5]
stable/5.4: [16bcbfb56d759c25665f786e33ec633b9508a08f]

CVE-2021-47204: net: dpaa2-eth: fix use-after-free in dpaa2_eth_remove

Announce: https://lore.kernel.org/linux-cve-announce/2024041037-CVE-2021-47204-82d1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7472dd9 ("staging: fsl-dpaa2/eth: Move print
message") in v4.17-rc1.
Fixed in v5.16-rc2.

Fixed status
mainline: [9b5a333272a48c2f8b30add7a874e46e8b26129c]
stable/5.10: [1c4099dc0d6a01e76e4f7dd98e4b3e0d55d80ad9]
stable/5.15: [32d4686224744819ddcae58b666c21d2a4ef4c88]
stable/5.4: [d74ff10ed2d93dc9b67e99a74b36fb9a83273d8a]

CVE-2021-47205: clk: sunxi-ng: Unregister clocks/resets when unbinding

Announce: https://lore.kernel.org/linux-cve-announce/2024041038-CVE-2021-47205-3f43@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

following lines shows affected file name and its introduced version.
ccu-sun4i-a10.c in 4.14-rc1
ccu-sun50i-a100-r.c in 5.10-rc1
ccu-sun50i-a100.c in 5.10-rc1
ccu-sun50i-a64.c in 4.10-rc1
ccu-sun50i-h6-r.c in 4.18-rc1
ccu-sun50i-h6.c in 4.17-rc1
ccu-sun50i-h616.c in 5.12-rc1-dontuse
ccu-sun5i.c in 4.11-rc1
ccu-sun6i-a31.c in 4.9-rc1
ccu-sun8i-a23.c in 4.9-rc1
ccu-sun8i-a33.c in 4.9-rc1
ccu-sun8i-a83t.c in 4.13-rc1
ccu-sun8i-de2.c in 4.13-rc1
ccu-sun8i-h3.c in 4.8-rc1
ccu-sun8i-r.c in 4.12-rc1
ccu-sun8i-r40.c in 4.14-rc1
ccu-sun8i-v3s.c in 4.11-rc1
ccu-sun9i-a80-de.c in 4.11-rc1
ccu-sun9i-a80-usb.c in 4.11-rc1
ccu-sun9i-a80.c in 4.11-rc1
ccu-suniv-f1c100s.c in 5.0-rc1
ccu_common.c in 4.8-rc1
ccu_common.h in 4.8-rc1

Fixed status
mainline: [9bec2b9c6134052994115d2d3374e96f2ccb9b9d]
stable/5.15: [b5dd513daa70ee8f6d281a20bd28485ee9bb7db2]

CVE-2021-47206: usb: host: ohci-tmio: check return value after calling
platform_get_resource()

Announce: https://lore.kernel.org/linux-cve-announce/2024041038-CVE-2021-47206-fe4c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

Fixed status
cip/4.4: [28e016e02118917e50a667bc72fb80098cf2b460]
cip/4.4-rt: [28e016e02118917e50a667bc72fb80098cf2b460]
cip/4.4-st: [28e016e02118917e50a667bc72fb80098cf2b460]
mainline: [9eff2b2e59fda25051ab36cd1cb5014661df657b]
stable/4.19: [951b8239fd24678b56c995c5c0456ab12e059d19]
stable/4.4: [28e016e02118917e50a667bc72fb80098cf2b460]
stable/5.10: [2474eb7fc3bfbce10f7b8ea431fcffe5dd5f5100]
stable/5.15: [065334f6640d074a1caec2f8b0091467a22f9483]
stable/5.4: [f98986b7acb4219f95789095eced93ed69d81d35]

CVE-2021-47207: ALSA: gus: fix null pointer dereference on pointer block

Announce: https://lore.kernel.org/linux-cve-announce/2024041038-CVE-2021-47207-7ac9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

Fixed status
cip/4.4: [3e28e083dcdf03a18a083f8a47b6bb6b1604b5be]
cip/4.4-rt: [3e28e083dcdf03a18a083f8a47b6bb6b1604b5be]
cip/4.4-st: [3e28e083dcdf03a18a083f8a47b6bb6b1604b5be]
mainline: [a0d21bb3279476c777434c40d969ea88ca64f9aa]
stable/4.19: [ab4c1ebc40f699f48346f634d7b72b9c5193f315]
stable/4.4: [3e28e083dcdf03a18a083f8a47b6bb6b1604b5be]
stable/5.10: [1ac6cd87d8ddd36c43620f82c4d65b058f725f0f]
stable/5.15: [16721797dcef2c7c030ffe73a07f39a65f9323c3]
stable/5.4: [c6d2cefdd05c4810c416fb8d384b5c377bd977bc]

CVE-2021-47209: sched/fair: Prevent dead task groups from regaining cfs_rq's

Announce: https://lore.kernel.org/linux-cve-announce/2024041004-CVE-2021-47209-1cf6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a7b359f ("sched/fair: Correctly insert cfs_rq's
to list on unthrottle") in v5.13-rc7.
Fixed in v5.16-rc1.

Fixed status
mainline: [b027789e5e50494c2325cc70c8642e7fd6059479]
stable/5.15: [512e21c150c1c3ee298852660f3a796e267e62ec]

CVE-2021-47210: usb: typec: tipd: Remove WARN_ON in tps6598x_block_read

Announce: https://lore.kernel.org/linux-cve-announce/2024041004-CVE-2021-47210-1d37@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
It looks as if it was introduced by commit 8d361fa ("usb: typec:
tps6598x: Remove VLA usage") in 4.19-rc1.

Fixed status
mainline: [b7a0a63f3fed57d413bb857de164ea9c3984bc4e]
stable/4.19: [2a897d384513ba7f7ef05611338b9a6ec6aeac00]
stable/5.10: [eff8b7628410cb2eb562ca0d5d1f12e27063733e]
stable/5.15: [2c71811c963b6c310a29455d521d31a7ea6c5b5e]
stable/5.4: [30dcfcda8992dc42f18e7d35b6a1fa72372d382d]

CVE-2021-47211: ALSA: usb-audio: fix null pointer dereference on pointer cs_desc

Announce: https://lore.kernel.org/linux-cve-announce/2024041004-CVE-2021-47211-cde3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

Fixed status
mainline: [b97053df0f04747c3c1e021ecbe99db675342954]
stable/5.15: [58fa50de595f152900594c28ec9915c169643739]

CVE-2021-47212: net/mlx5: Update error handler for UCTX and UMEM

Announce: https://lore.kernel.org/linux-cve-announce/2024041005-CVE-2021-47212-01d8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6a6fabb ("net/mlx5: Update pci error handler
entries and command translation") in v5.2-rc6.
The snd_usb_set_sample_rate_v2v3() was introduced by commit 93db51d0
("ALSA: usb-audio: Check valid altsetting at parsing rates for
UAC2/3") in 5.11-rc1.
So, prior to 5.11 is not affected.
Fixed in v5.16-rc2.

Fixed status
mainline: [ba50cd9451f6c49cf0841c0a4a146ff6a2822699]
stable/5.15: [a51a6da375d82aed5c8f83abd13e7d060421bd48]

CVE-2021-47213: NFSD: Fix exposure in nfsd4_decode_bitmap()

Announce: https://lore.kernel.org/linux-cve-announce/2024041005-CVE-2021-47213-c84f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d1c263a ("NFSD: Replace READ* macros in
nfsd4_decode_fattr()") in v5.11-rc1.
Fixed in v5.16-rc2.

Fixed status
mainline: [c0019b7db1d7ac62c711cda6b357a659d46428fe]
stable/5.15: [10c22d9519f3f5939de61a1500aa3a926b778d3a]

CVE-2021-47214: hugetlb, userfaultfd: fix reservation restore on
userfaultfd error

Announce: https://lore.kernel.org/linux-cve-announce/2024041005-CVE-2021-47214-59f9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c7b1850 ("hugetlb: don't pass page cache pages to
restore_reserve_on_error") in v5.14-rc7.
Fixed in v5.16-rc2.

Fixed status
mainline: [cc30042df6fcc82ea18acf0dace831503e60a0b7]
stable/5.15: [b5069d44e2fbc4a9093d005b3ef0949add3dd27e]

CVE-2021-47215: net/mlx5e: kTLS, Fix crash in RX resync flow

Announce: https://lore.kernel.org/linux-cve-announce/2024041005-CVE-2021-47215-2718@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e9ce991 ("net/mlx5e: kTLS, Add resiliency to RX
resync failures") in v5.13-rc1.
Fixed in v5.16-rc2.

Fixed status
mainline: [cc4a9cc03faa6d8db1a6954bb536f2c1e63bdff6]
stable/5.15: [ebeda7a9528ae690e6bf12791a868f0cca8391f2]

CVE-2021-47216: scsi: advansys: Fix kernel pointer leak

Announce: https://lore.kernel.org/linux-cve-announce/2024041006-CVE-2021-47216-1700@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.

Fixed status
cip/4.4: [06d7d12efb5c62db9dea15141ae2b322c2719515]
cip/4.4-rt: [06d7d12efb5c62db9dea15141ae2b322c2719515]
cip/4.4-st: [06d7d12efb5c62db9dea15141ae2b322c2719515]
mainline: [d4996c6eac4c81b8872043e9391563f67f13e406]
stable/4.19: [f5a0ba4a9b5e70e7b2f767636d26523f9d1ac59d]
stable/4.4: [06d7d12efb5c62db9dea15141ae2b322c2719515]
stable/5.10: [055eced3edf5b675d12189081303f6285ef26511]
stable/5.15: [27490ae6a85a70242d80615ca74d0362a820d6a7]
stable/5.4: [cc248790bfdcf879e3094fa248c85bf92cdf9dae]

CVE-2021-47217: x86/hyperv: Fix NULL deref in set_hv_tscchange_cb() if
Hyper-V setup fails

Announce: https://lore.kernel.org/linux-cve-announce/2024041006-CVE-2021-47217-a7d0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9328626 ("x86/hyperv: Reenlightenment
notifications support") in v4.16-rc1.
Fixed in v5.16-rc2.

Fixed status
mainline: [daf972118c517b91f74ff1731417feb4270625a4]
stable/4.19: [b20ec58f8a6f4fef32cc71480ddf824584e24743]
stable/5.10: [9c177eee116cf888276d3748cb176e72562cfd5c]
stable/5.15: [8823ea27fff6084bbb4bc71d15378fae0220b1d8]
stable/5.4: [b0e44dfb4e4c699cca33ede431b8d127e6e8d661]

CVE-2021-47218: selinux: fix NULL-pointer dereference when hashtab
allocation fails

Announce: https://lore.kernel.org/linux-cve-announce/2024041006-CVE-2021-47218-cdc8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 03414a4 ("selinux: do not allocate hashtabs
dynamically") in v5.8-rc1.
Fixed in v5.16-rc3.

Fixed status
mainline: [dc27f3c5d10c58069672215787a96b4fae01818b]
stable/5.10: [b17dd53cac769dd13031b0ca34f90cc65e523fab]
stable/5.15: [83c8ab8503adf56bf68dafc7a382f4946c87da79]

CVE-2021-47219: scsi: scsi_debug: Fix out-of-bound read in resp_report_tgtpgs()

Announce: https://lore.kernel.org/linux-cve-announce/2024041006-CVE-2021-47219-c09e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
All stable kernels look to be affected.

Fixed status
mainline: [f347c26836c270199de1599c3cd466bb7747caa9]
stable/5.10: [8440377e1a5644779b4c8d013aa2a917f5fc83c3]
stable/5.15: [66523553fa62c7878fc5441dc4e82be71934eb77]

CVE-2024-26815: net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX check

Announce: https://lore.kernel.org/linux-cve-announce/2024041006-CVE-2024-26815-7f4e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a54fc09 ("net/sched: taprio: allow user input of
per-tc max SDU") in v6.1-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [343041b59b7810f9cdca371f445dd43b35c740b1]
stable/6.1: [bd2474a45df7c11412c2587de3d4e43760531418]
stable/6.6: [6915b1b28fe57e92c78e664366dc61c4f15ff03b]

CVE-2024-26816: x86, relocs: Ignore relocations in .notes section

Announce: https://lore.kernel.org/linux-cve-announce/2024041039-CVE-2024-26816-5054@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5ead97c ("xen: Core Xen implementation") in v2.6.23-rc1.
Introduced by commit da1a679 ("Add /sys/kernel/notes") in v2.6.23-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [aaa8736370db1a78f0e8434344a484f9fd20be3b]
stable/4.19: [13edb509abc91c72152a11baaf0e7c060a312e03]
stable/5.10: [a4e7ff1a74274e59a2de9bb57236542aa990d20a]
stable/5.15: [c7cff9780297d55d97ad068b68b703cfe53ef9af]
stable/5.4: [52018aa146e3cf76569a9b1e6e49a2b7c8d4a088]
stable/6.1: [47635b112a64b7b208224962471e7e42f110e723]
stable/6.6: [af2a9f98d884205145fd155304a6955822ccca1c]

* Updated CVEs

CVE-2023-28746: Register File Data Sampling (RFDS)

stable 5.15 was fixed.

Fixed status
mainline: [e95df4ec0c0c9791941f112db699fae794b9862a,
4e42765d1be01111df0c0275bbaf1db1acef346e,
  8076fcde016c9c0e0660543e67bff86cb48a7c9c,
2a0180129d726a4b953232175857d442651b55a0]
stable/5.15: [a2b586df5546311f9be5f6acb9fe489b623c526e,
4fa001418efd40ad00ff429e6064ab8eeeddc739,
  2fb08b672eb78c4930413cf529734792456ae15f,
2ae88e83f3b7e579a7085d140f61122f128932f1]
stable/6.1: [8b5760939db9c49c03b9e19f6c485a8812f48d83,
29476fac750dddeabc3503bf9b13e05b949d7adb,
  d405b9c03f06b1b5e73ebc4f34452687022f7029,
b2e92ab17e440a97c716b701ecd897eebca11ac0]
stable/6.6: [c35ca0968de41952af2ad7d22881e4a7c6e1b145,
ddfd38558acc5b3891fd197372fedb76372da740,
  77018fb9efe50cf24e61275ee09253cf1fbb6854,
4a5b5bfea063745471af6395d22ebaea8242225e]
stable/6.7: [18867a204511d032c2a6ed083461a10905061fac,
13acf9f1df3513ea7a5170399c2a8e297e5fbdc1,
  fe5f4d14cdad934c5c92080cebd5b18189bf4ac9,
328607cf9e1fcbbc3f5521391d601306f72a5890]
stable/6.8: [056c33c67a74aec19668b927d460825f5e9aab42,
7586a7c0ba2f16ee6fe7f1ad95313775717e9f53,
  c8a1b14f43bb89a62c1471ec2931f152b37b3782,
50d33b98b1e23d1cd8743b3cac7a0ae5718b8b00]

CVE-2023-47233: Use after Free bug in brcmf_cfg80211_detach

stable 5.15 was fixed.

Fixed status
mainline: [0f7352557a35ab7888bc7831411ec8a3cbe20d78]
stable/5.15: [8c36205123dc57349b59b4f1a2301eb278cbc731]
stable/6.1: [0b812f706fd7090be74812101114a0e165b36744]
stable/6.6: [190794848e2b9d15de92d502b6ac652806904f5a]
stable/6.7: [6678a1e7d896c00030b31491690e8ddc9a90767a]
stable/6.8: [0a7591e14a8da794d0b93b5d1c6254ccb23adacb]

CVE-2023-52488: serial: sc16is7xx: convert from _raw_ to _noinc_
regmap functions for FIFO

stable 5.15 was fixed.

Fixed status
mainline: [dbf4ab821804df071c8b566d9813083125e6d97b]
stable/5.15: [e635f652696ef6f1230621cfd89c350cb5ec6169]
stable/6.1: [416b10d2817c94db86829fb92ad43ce7d002c573]
stable/6.6: [084c24e788d9cf29c55564de368bf5284f2bb5db]
stable/6.7: [aa7cb4787698add9367b19f7afc667662c9bdb23]

CVE-2024-24857: Integer overflow bug was found in bluetooth device driver

The mainline, 5.15, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [7835fcfd132eb88b87e8eb901f88436f63ab60f7]
stable/5.15: [a8170af8b10e904c0052aa4ec31c653635730d92]
stable/6.1: [18e189442a5896255e764f8e875c13d16248ef2f]
stable/6.6: [d75632d0db3cdc31873d25756066a7f56bc87737]
stable/6.8: [d0bfebd8ca411697248d0cebe4ad2649f23ab0bf]

CVE-2024-24858: Race condition bug in bluetooth driver causes DoS

The mainline, 5.15, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [7835fcfd132eb88b87e8eb901f88436f63ab60f7]
stable/5.15: [a8170af8b10e904c0052aa4ec31c653635730d92]
stable/6.1: [18e189442a5896255e764f8e875c13d16248ef2f]
stable/6.6: [d75632d0db3cdc31873d25756066a7f56bc87737]
stable/6.8: [d0bfebd8ca411697248d0cebe4ad2649f23ab0bf]

CVE-2024-24861: Race condition bug was found in media/xc4000 device
driver in xc4000 xc4000_get_frequency()

stable 5.15 was fixed.

Fixed status
mainline: [36d503ad547d1c75758a6fcdbec2806f1b6aeb41]
stable/5.15: [fec51819607ff0a80ad8ce678120fda80ca0b2fa]
stable/6.1: [09c1be4d581d3356159abcc5a8a7a6c5f1bf1e77]
stable/6.6: [dc5e4f240473b64f7b2f24424e96c92435ebd8d7]
stable/6.7: [b0864de231dece0f7226b909521bebc86105743a]
stable/6.8: [5c26122885cedcb99606cdc06a3419db7feb1e1e]

CVE-2024-26629: nfsd: fix RELEASE_LOCKOWNER

stable 5.15 was fixed.

Fixed status
mainline: [edcf9725150e42beeca42d085149f4c88fa97afd]
stable/5.15: [c6f8b3fcc62725e4129f2c0fd550d022d4a7685a]
stable/6.1: [e4cf8941664cae2f89f0189c29fe2ce8c6be0d03]
stable/6.6: [b7d2eee1f53899b53f069bba3a59a419fc3d331b]
stable/6.7: [8f5b860de87039b007e84a28a5eefc888154e098]

CVE-2024-26642: netfilter: nf_tables: disallow anonymous set with timeout flag

stable 5.15 was fixed.

Fixed status
mainline: [16603605b667b70da974bea8216c93e7db043bf1]
stable/5.15: [7cdc1be24cc1bcd56a3e89ac4aef20e31ad09199]
stable/6.1: [72c1efe3f247a581667b7d368fff3bd9a03cd57a]
stable/6.6: [c0c2176d1814b92ea4c8e7eb7c9cd94cd99c1b12]
stable/6.7: [8e07c16695583a66e81f67ce4c46e94dece47ba7]

CVE-2024-26643: netfilter: nf_tables: mark set as dead when unbinding
anonymous set with timeout

stable 5.15 was fixed.

Fixed status
mainline: [552705a3650bbf46a22b1adedc1b04181490fc36]
stable/5.15: [291cca35818bd52a407bc37ab45a15816039e363]
stable/6.1: [406b0241d0eb598a0b330ab20ae325537d8d8163]
stable/6.6: [b2d6f9a5b1cf968f1eaa71085ceeb09c2cb276b1]
stable/6.7: [5224afbc30c3ca9ba23e752f0f138729b2c48dd8]

CVE-2024-26654: ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

stable 5.15 was fixed.

Fixed status
mainline: [051e0840ffa8ab25554d6b14b62c9ab9e4901457]
stable/5.15: [8c990221681688da34295d6d76cc2f5b963e83f5]
stable/6.1: [9d66ae0e7bb78b54e1e0525456c6b54e1d132046]
stable/6.6: [61d4787692c1fccdc268ffa7a891f9c149f50901]
stable/6.7: [e955e8a7f38a856fc6534ba4e6bffd4d5cc80ac3]
stable/6.8: [3c907bf56905de7d27b329afaf59c2fb35d17b04]

CVE-2024-26687: xen/events: close evtchn after mapping cleanup

Fixed status
mainline: [fa765c4b4aed2d64266b694520ecb025c862c5a9]
stable/5.15: [ea592baf9e41779fe9a0424c03dd2f324feca3b3]
stable/6.1: [585a344af6bcac222608a158fc2830ff02712af5]
stable/6.6: [20980195ec8d2e41653800c45c8c367fa1b1f2b4]
stable/6.7: [9be71aa12afa91dfe457b3fb4a444c42b1ee036b]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

