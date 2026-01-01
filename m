Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF652EEB577
	for <webhook@archiver.kernel.org>; Thu,  1 Jan 2026 00:49:15 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.97089.1767228549053592488
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 16:49:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=2k5dyXkx;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.45, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-644715aad1aso12965788d50.0
        for <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 16:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1767228548; x=1767833348; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BUIOICfvZnHkVfeiVJonjdk3ET9IzNe8KJvVFLXEBs4=;
        b=2k5dyXkxG5kj2nee1KaXoHhSnAlh8IcSqGaxxGUdZ2lWmInNR33zbdKBb9m+dcwQOO
         ZJmFyY6J3R8Tg4MSQPlR25s4eoSAsl+K6kwzsDHk28JGjskwSaU1PlOlIILRV2ui8+Cr
         5gzDzM8iaFcMKhe29Q8w0X34WGKsV9II4GTn9k37rU0rPH6tFte2WF8F4lhAM7hCndkf
         WBDJ6cnMbD9ehzJph/2vB5w5t6V11Gc54owGBy25RIEJR3vasrewTn0U68zgWtChrP6E
         0d0pDuzCCncPeJd+WGfCmRz8M8H+C5VyElkragmG3EZjY1XggKZtSb/llsLztX5FHbhr
         44DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767228548; x=1767833348;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUIOICfvZnHkVfeiVJonjdk3ET9IzNe8KJvVFLXEBs4=;
        b=GeTUrjhrN6FualDTLJnVRWgwNhjubKh86G9phcJb/R9pJ6FmzgD3vWSiFZRsCofM1C
         BqCKFTNq4NG/nN9Vb9Ey6VwFpJmSLI7NWQHgyxMbL1W70/VCqwtrRSMhc7o2Ge48Vrnd
         xs59rBJj9JdEZPyJQ0DTktthxUMIShoIrU/z0aMJkWqFuxai5niFDaOvIiHUqYAw4V6N
         R2qEOo4IRvSxk8KtuV++8Ce0ewGBKKTYRkKql/JsVsrByqML7wf+VSOPM3Aks6NUN/5M
         HXggXSJ75LoNu86MohpkQEKdOcXZfRXlYr+x4B4AbzqqftEDiAyjtWcCR7nCxkYHJeCy
         j6NQ==
X-Gm-Message-State: AOJu0YyGexF+5dA5dUdB8LzVMDW/bbCypEAeuDqApEoR9p346bJLqAAn
	FItsappRIVCkkk+cQOFi6E67yJY0gOTDA96NBDVQPnXwzDzKWXK2QNuVeylklJUbaEnYAUX8AFt
	CNNJyyYVrNWeaMATTAzb+yM67tJItdZbfAuYZkN9ikksSoCwYDFq4jWU=
X-Gm-Gg: AY/fxX7EPXIbJ70qh/X/KADmYdER9la7+n41Kk9bBJQWXTNz0HjOpKFPzA9IQXDsgPa
	WlvRWYh/5lv6J0fn1QP84IkwTH051wuR4LBgo1OQaUgCEaYfoYwHI1wvDNgeIrWHtQUt9RMEj+B
	54atVzBgUC5zS+BJ3jGDT2ZPqVSq8ojcfRxCf40iYBI0QzzbB7+ZTM8x3BLRE61tAk+z/34AojO
	J31KR28vfTS5LR/7/RwkG51OrVMlZdXmn+uE+xN7H/jjMlIrg63afsjCHFpsxxIIgeVWq47r8ll
	YrEOHm4=
X-Google-Smtp-Source: AGHT+IEFCZTxjBr1HRCebgKcMDglbNxkYQAEXIDFj1+FspmmzUA16aqUbtnBEhvYDCIZqjMJjxbXfBB4v+Vg2UdadFY=
X-Received: by 2002:a05:690e:11c6:b0:641:f5bc:692a with SMTP id
 956f58d0204a3-646632c32fbmr34471519d50.35.1767228546241; Wed, 31 Dec 2025
 16:49:06 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 Jan 2026 09:48:30 +0900
X-Gm-Features: AQt7F2payw3mEHN665tjv2GaspDzJw6l-nYRdOTTt7UvL_rfeC9k5jw8ciGXzos
Message-ID: <CAODzB9ph44GAFLdrzNhmvNT1nuCvvwfFiMaZv9f3C6x5rTZVEA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jan 2026 00:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21297

Hi!

It's this week's CVE report.

This week reported 244 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2022-50784: wifi: iwlwifi: mei: fix potential NULL-ptr deref after clone

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50784

Introduced by commit 2da4366 ("iwlwifi: mei: add the driver to allow
cooperation with CSME") in v5.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3df49dda431f7ae4132a9a0ac25a5134c04e812]
stable/6.1: [0183b7c49cfdda91284505cbcdc7feecde48cbb9]

CVE-2022-50785: fsi: occ: Prevent use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50785

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file is added by 7ed98dd ("fsi: Add On-Chip Controller (OCC)
driver") in v5.0-rc1.

Fixed status
mainline: [d3e1e24604031b0d83b6c2d38f54eeea265cfcc0]

CVE-2022-50786: media: s5p-mfc: Clear workbit to handle error condition

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50786

Introduced by commit 818cd91 ("[media] s5p-mfc: Extract open/close MFC
instance commands") in v3.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [12242bd13ce68acd571b2cce6ab302e154e8a4ee]
mainline: [d3f3c2fe54e30b0636496d842ffbb5ad3a547f9b]
stable/5.10: [8ff64edf9d16e8c277dcc8189794763624e6b4b8]
stable/5.15: [ff27800c0a6d81571671b33f696109804d015409]
stable/6.1: [bd1b72f0c39a0d791a087b4e643701a48328ba8e]

CVE-2022-50809: xhci: dbc: Fix memory leak in xhci_alloc_dbc()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50809

Introduced by commit 5346759 ("xhci: dbc: refactor xhci_dbc_init()")
in v5.18-rc1.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d591b32e519603524a35b172156db71df9116902]
stable/5.15: [103b459590e1eb4d80b02761eb36c7cae1d9b58e]

CVE-2022-50810: rapidio: devices: fix missing put_device in mport_cdev_open

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50810

Introduced by commit e8de370 ("rapidio: add mport char device driver")
in v4.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dfee9fe93dd34cd9d49520718f6ec2072de25e48]
mainline: [d5b6e6eba3af11cb2a2791fa36a2524990fcde1a]
stable/5.10: [53915ecc43c5139d6cdd1caa4fdc9290b9597008]
stable/5.15: [a0d93aac54ce07a7cc71e90645d0cdabbda50450]
stable/6.1: [b596242585984b5f3085aa8f7a82c65640b384b6]

CVE-2022-50811: erofs: fix missing unmap if
z_erofs_get_extent_compressedlen() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50811

Introduced by commit cec6e93 ("erofs: support parsing big pcluster
compress indexes") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5d188b8f8b38d3d71dd05993874b4fc9284ce95]
stable/6.1: [373b6f350aecf5dca2e7474f0b4ec8cca659f2f0]

CVE-2022-50812: security: Restrict CONFIG_ZERO_CALL_USED_REGS to gcc
or clang > 15.0.6

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50812

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected config was added by a82adfd ("hardening: Introduce
CONFIG_ZERO_CALL_USED_REGS") in v5.15-rc1.

Fixed status
mainline: [d6a9fb87e9d18f3394a9845546bbe868efdccfd2]
stable/5.15: [8a4236456a3a402f6bb92aa7b75e7a3b4ef7a72c]
stable/6.1: [21ca0bfa11bbb9a9207f5d2104f47d3d71b4616e]

CVE-2022-50813: drivers: mcb: fix resource leak in mcb_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50813

Introduced by commit 7bc3640 ("mcb: Acquire reference to device in
probe") in v4.7-rc4.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e420ca85bf42a684ea729c505c07de6709500ed2]
mainline: [d7237462561fcd224fa687c56ccb68629f50fc0d]
stable/5.10: [0d1c2c8db28919c4351000d7c1692f1767bdc4f7]
stable/5.15: [f3686e5e8de0a03c8e70e3ee0ce3078fed612909]
stable/6.1: [0468a585710bbb807a1b9c31df54bcf564d28b2b]

CVE-2022-50814: crypto: hisilicon/zip - fix mismatch in get/set sgl_sge_nr

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50814

Introduced by commit f081fda ("crypto: hisilicon - add sgl_sge_nr
module param for zip") in v5.5-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d74f9340097a881869c4c22ca376654cc2516ecc]
stable/5.10: [d88b88514ef28515ccfa1f1787c2aedef75a79dd]
stable/5.15: [272093471305261c4e07a2fc97c2d1e53cd56819]

CVE-2022-50815: ext2: Add sanity checks for group and filesystem size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50815

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [d766f2d1e3e3bd44024a7f971ffcf8b8fbb7c5d2]

CVE-2022-50816: ipv6: ensure sane device mtu in tunnels

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50816

Introduced by commit c12b395 ("gre: Support GRE over IPv6") in v3.7-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [78297d513157a31fd629626fe4cbb85a7dcbb94a]
cip/4.4-st: [a7d5e6209ff790d8f8af524847f0b8ad291ce389]
mainline: [d89d7ff01235f218dad37de84457717f699dee79]
stable/5.10: [44affe7ede596f078c4f2f41e0d160266ccda818]
stable/5.15: [ad3f1d9bf162c487d23df684852597961b745cae]

CVE-2022-50817: net: hsr: avoid possible NULL deref in skb_clone()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50817

Introduced by commit f266a68 ("net/hsr: Better frame dispatch") in v3.17-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8b57135fd9ffe9a5b445350a686442a531c5339]
stable/5.10: [ff7ba766758313129794f150bbc4d351b5e17a53]
stable/5.15: [35ece858660eae13ee0242496a1956c39d29418e]

CVE-2022-50818: scsi: pm8001: Fix running_req for internal abort commands

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50818

Introduced by commit 2cbbf48 ("scsi: pm8001: Use libsas internal abort
support") in v5.18-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8c22c4697c11ed28062afe3c2b377025be11a23]

CVE-2022-50819: udmabuf: Set ubuf->sg = NULL if the creation of sg table fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50819

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by 284562e ("udmabuf: implement
begin_cpu_access/end_cpu_access hooks") in v5.6-rc1.

Fixed status
mainline: [d9c04a1b7a15b5e74b2977461d9511e497f05d8f]
stable/5.10: [bbe2f6f90310b3a0b5de4e0dc022b36faabfd718]
stable/5.15: [dfbed8c92eb853929f4fa676ba493391dab47be4]

CVE-2022-50820: perf/arm_dmc620: Fix hotplug callback leak in dmc620_pmu_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50820

Introduced by commit 53c218d ("driver/perf: Add PMU driver for the ARM
DMC-620 memory controller") in v5.11-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9f564c966e63925aac4ba273a9319d7fb6f4b4e]
stable/5.15: [b99fbe8d949a99fe456f08c7aad421327685aa50]
stable/6.1: [adf7c3bbcc819db6e95b6a61c9822230f0ef4778]

CVE-2022-50821: SUNRPC: Don't leak netobj memory when
gss_read_proxy_verf() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50821

Introduced by commit 030d794 ("SUNRPC: Use gssproxy upcall for server
RPCGSS authentication.") in v3.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [76f2497a2faa6a4e91efb94a7f55705b403273fd]
mainline: [da522b5fe1a5f8b7c20a0023e87b52a150e53bf5]
stable/5.10: [2cd6026e257362f030c8be57abaf7fc0049df60a]
stable/5.15: [d01fa993eb7fbc305f0a9c3e8bfac6513efc13b6]
stable/6.1: [c9ded831e2552b9c3cab7e2591a190e94f9d29c0]

CVE-2022-50822: RDMA/restrack: Release MR restrack when delete

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50822

Introduced by commit 13ef553 ("RDMA/restrack: Count references to the
verbs objects") in v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dac153f2802db1ad46207283cb9b2aae3d707a45]
stable/5.15: [13586753ae55146269a6dc8b216f17d86b81560c]
stable/6.1: [8731cb5c7820bef577bab4ff17691fbf61c671cb]

CVE-2022-50823: clk: tegra: Fix refcount leak in tegra114_clock_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50823

Introduced by commit 2cb5efe ("clk: tegra: Implement clocks for
Tegra114") in v3.10-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8cc87a9c142ae0e276a3ff9ce50f78a1668da36f]
cip/4.4-st: [de170cc36ef1639e6910df6df50260e81dee8986]
mainline: [db16a80c76ea395766913082b1e3f939dde29b2c]
stable/5.10: [c01bfd23cc13a420b3f6a36bcab98410f49d480d]
stable/5.15: [e7a57fb92af52c4da69cd947752e8946e5ada50a]

CVE-2022-50824: tpm: tpm_tis: Add the missed acpi_put_table() to fix memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50824

Introduced by commit 4cb586a ("tpm_tis: Consolidate the platform and
acpi probe flow") in v4.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [de667a2704ae799f697fd45cf4317623d8c79fb7]
mainline: [db9622f762104459ff87ecdf885cc42c18053fd9]
stable/5.10: [3b6c822238da9ee8984803355601bcc603d49cb5]
stable/5.15: [43135fb098126ef2cd6ed584900fd7bfa25f95ce]
stable/6.1: [e60fa800a32a693d672b1a091424d780278c4587]

CVE-2022-50825: usb: typec: wusb3801: fix fwnode refcount leak in
wusb3801_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50825

Introduced by commit d016cbe ("usb: typec: Support the WUSB3801 port
controller") in v5.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc18a4c7b3bd447cef2395deeb1f6ac16dfaca0e]
stable/6.1: [82d1211f673bbdc822eaf1dbcbf1f2ae06556964]

CVE-2022-50826: ipu3-imgu: Fix NULL pointer dereference in
imgu_subdev_set_selection()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50826

Introduced by commit 0d346d2 ("media: v4l2-subdev: add subdev-wide
state struct") in v5.14-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc608edf7d45ba0c2ad14c06eccd66474fec7847]
stable/5.15: [fa6bbb4894b9b947063c6ff90018a954c5f9f4b3]
stable/6.1: [5038ee677606106c91564f9c4557d808d14bad70]

CVE-2022-50827: scsi: lpfc: Fix memory leak in lpfc_create_port()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50827

Introduced by commit 5e63330 ("scsi: lpfc: vmid: Add support for VMID
in mailbox command") in v5.14-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc8e483f684a24cc06e1d5fa958b54db58855093]
stable/5.15: [9749595feb33a1a2b848800192224ffeed5346b4]

CVE-2022-50828: clk: zynqmp: Fix stack-out-of-bounds in strncpy`

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50828

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by 3fde0e1 ("drivers: clk: Add ZynqMP clock
driver") in v4.20-rc1.

Fixed status
mainline: [dd80fb2dbf1cd8751efbe4e53e54056f56a9b115]
stable/5.10: [d9e2585c3bcecb1c83febad31b9f450e93d2509e]
stable/5.15: [0a07b13af04d0db7325018aaa83b5ffe864790c9]

CVE-2022-50829: wifi: ath9k: hif_usb: Fix use-after-free in
ath9k_hif_usb_reg_in_cb()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50829

Introduced by commit 3deff76 ("ath9k_htc: Increase URB count for
REG_IN pipe") in v3.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0c8dd2ea4b419da96ab4953e4967e9363e2f8a4f]
cip/4.4-st: [91fe4f211da69c2b33a59f9e98c5a1ad4792cc44]
mainline: [dd95f2239fc846795fc926787c3ae0ca701c9840]
stable/5.10: [98d9172822dc6f38138333941984bd759a89d419]
stable/5.15: [355f16f756aad0c95cdaa0c14a34ab4137d32815]
stable/6.1: [71fc0ad671a62c494d2aec731baeabd3bfe6c95d]

CVE-2022-50830: auxdisplay: hd44780: Fix potential memory leak in
hd44780_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50830

Introduced by commit 718e05e ("auxdisplay: Introduce
hd44780_common.[ch]") in v5.11-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddf75a86aba2cfb7ec4497e8692b60c8c8fe0ee7]
stable/5.15: [8311961a1724bfc64390c539dedc31e067a80315]
stable/6.1: [6cd37f8232f5e169a723e1d5fbe3b2139c2ef763]

CVE-2022-50832: wifi: wilc1000: fix potential memory leak in wilc_mac_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50832

Introduced by commit c5c77ba ("staging: wilc1000: Add SDIO/SPI 802.11
driver") in v4.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deb962ec9e1c9a81babd3d37542ad4bd6ac3396e]
stable/5.10: [a1e94fb4d09d0fcfeaa73aa49d787f06c42db7ee]
stable/5.15: [5706d00fde3f1d5eb7296a4dfefb6aea35108224]
stable/6.1: [07dcd756e28f27e4f8fcd8b809ffa05a5cc5de2b]

CVE-2022-50833: Bluetooth: use hdev->workqueue when queuing
hdev->{cmd,ncmd}_timer works

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50833

Introduced by commit 877afad ("Bluetooth: When HCI work queue is
drained, only queue chained work") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deee93d13d385103205879a8a0915036ecd83261]

CVE-2022-50834: nfc: Fix potential resource leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50834

Introduced by commit 5ce3f32 ("NFC: netlink: SE API implementation")
in v3.13-rc1.
Introduced by commit 29e7692 ("nfc: netlink: Add capability to reply
to vendor_cmd with data") in v4.3-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d1d912e7f82d7216ba4e266048ec1d1f5ea93839]
cip/4.4-st: [53983404b123c7de37d4b67f4ca189c7c689613d]
mainline: [df49908f3c52d211aea5e2a14a93bbe67a2cb3af]
stable/5.10: [e0f5c962c066e769c187f037fedc883f8abd4e82]
stable/5.15: [b63bc2db244c1b57e36f16ea5f2a1becda413f68]
stable/6.1: [b32f6bef248562bb5191ada527717ea50b319466]

CVE-2022-50835: jbd2: add miss release buffer head in fc_do_one_pass()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50835

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by 5b849b5 ("jbd2: fast commit recovery
path") in v5.10-rc1.

Fixed status
mainline: [dfff66f30f66b9524b661f311bbed8ff3d2ca49f]
stable/5.10: [e65506ff181fc176088f32117d69b9cb1ddda777]
stable/5.15: [56fcd0788f0d9243c1754bd6f80b8b327c4afeee]

CVE-2022-50836: remoteproc: sysmon: fix memory leak in qcom_add_sysmon_subdev()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50836

Introduced by commit 027045a ("remoteproc: qcom: Add shutdown-ack
irq") in v5.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e01ce676aaef3b13d02343d7e70f9637d93a3367]
stable/5.10: [e4539eb5c0c342567183fe386d0699c8dab49490]
stable/5.15: [131c0a3ead78d45f0f39ddb42cf1bd9be26239b0]
stable/6.1: [ec97e9a5c2f25d2f9f9d7005e9ac67f23cc751cd]

CVE-2022-50837: net: dsa: tag_8021q: avoid leaking ctx on
dsa_tag_8021q_register() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50837

Introduced by commit 328621f ("net: dsa: tag_8021q: absorb
dsa_8021q_setup into dsa_tag_8021q_{,un}register") in v5.15-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e095493091e850d5292ad01d8fbf5cde1d89ac53]
stable/5.15: [09f30f394e832ed09859b6a80fdd20668a9104ff]
stable/6.1: [14ed46a13aba42a6ddd85de6f6274090df3586a5]

CVE-2022-50838: net: stream: purge sk_error_queue in sk_stream_kill_queues()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50838

Introduced by commit 24bcbe1 ("net: stream: don't purge sk_error_queue
in sk_stream_kill_queues()") in v5.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
cip/4.19-st: [6f00bd0402a1e3d2d556afba57c045bd7931e4d3]
cip/4.4-st: [a7aa8a4653090c8d8d70b9221dadff15e866fc0a]
mainline: [e0c8bccd40fc1c19e1d246c39bcf79e357e1ada3]
stable/5.10: [9062493811676ee0efe6c74d98f00ca38c4e17d4]
stable/5.15: [9da204cd67c4fe97e8aa465d10d5c2e7076f7f42]
stable/6.1: [b458d349f8753f666233828ebd30df6f100cf7d5]

CVE-2022-50839: jbd2: fix potential buffer head reference count leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50839

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by ff780b9 ("jbd2: add fast commit
machinery") in v5.10-rc1.

Fixed status
mainline: [e0d5fc7a6d80ac2406c7dfc6bb625201d0250a8a]
stable/5.10: [7a33dde572fceb45d02d188e0213c47059401c93]
stable/5.15: [e7385c868ee038d6a0cb0e85c22d2741e7910fd5]

CVE-2022-50840: scsi: snic: Fix possible UAF in snic_tgt_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50840

Introduced by commit c8806b6 ("snic: driver for Cisco SCSI HBA") in v4.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3007f96ca20c848d0b1b052df6d2cb5ae5586e78]
cip/4.4-st: [365c0afccfbede8ef0ef56f1dc11f91ccb94ab1c]
mainline: [e118df492320176af94deec000ae034cc92be754]
stable/5.10: [ad27f74e901fc48729733c88818e6b96c813057d]
stable/5.15: [1895e908b3ae66a5312fd1b2cdda2da82993dca7]
stable/6.1: [4141cd9e8b3379aea52a85d2c35f6eaf26d14e86]

CVE-2022-50841: fs/ntfs3: Add overflow check for attribute size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50841

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.

Fixed status
mainline: [e19c6277652efba203af4ecd8eed4bd30a0054c9]
stable/5.15: [d4489ba8fb806e07b43eecca5e9af5865d94cbf6]
stable/6.1: [0bb9f93ba63acfdb7c363d9f9fc2199fc6fa913d]

CVE-2022-50842: drm/virtio: Check whether transferred 2D BO is shmem

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50842

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [e473216b42aa1fd9fc6b94b608b42c210c655908]
stable/5.10: [f134f261d76ae3d5ecf68db642eaa746ceb84cfb]
stable/5.15: [f122bcb34f1a4b02ef3d95058d8fd1316ea03785]

CVE-2022-50843: dm clone: Fix UAF in clone_dtr()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50843

Introduced by commit 7431b78 ("dm: add clone target") in v5.4-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4b5957c6f749a501c464f92792f1c8e26b61a94]
stable/5.10: [342cfd8426dff4228e6c714bcb9fc8295a2748dd]
stable/5.15: [856edd0e92f3fe89606b704c86a93daedddfe6ec]
stable/6.1: [9e113cd4f61f3b0000843b2d0a90ce8b40a1fcff]

CVE-2022-50844: drm/amdgpu: Fix type of second parameter in
odn_edit_dpm_table() callback

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50844

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by e3933f2 ("drm/amd/pp: Add edit/commit/show
OD clock/voltage support in sysfs") in v4.17-rc1.

Fixed status
mainline: [e4d0ef752081e7aa6ffb7ccac11c499c732a2e05]
stable/5.10: [9606bbc271ac86c266d1f4a0285dd69b3fda2d0f]
stable/5.15: [f9084e9930db562bdcd47fa199a66fb45e16dab5]
stable/6.1: [36217f676b55932a12d6732c95388150015fdee6]

CVE-2022-50845: ext4: fix inode leak in ext4_xattr_inode_create() on
an error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50845

Introduced commit is not determined.Fixed in v6.2-rc1.
Vulnerable code was added by bd3b963 ("ext4: attach jinode after
creation of xattr inode") in v4.13-rc1.

Fixed status
cip/4.19-st: [eab94a46560f68d4bcd15222701ced479f84f427]
mainline: [e4db04f7d3dbbe16680e0ded27ea2a65b10f766a]
stable/5.10: [9882601ee689975c1c0076ee65bf222a2a35e535]
stable/5.15: [322cf639b0b7f137543072c55545adab782b3a25]
stable/6.1: [70e5b46beba64706430a87a6d516054225e8ac8a]

CVE-2022-50846: mmc: via-sdmmc: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50846

Introduced by commit f0bf7f6 ("mmc: Add new via-sdmmc host controller
driver") in v2.6.31-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [95025a8dd0ec015872f6c16473fe04d6264e68ca]
cip/4.4-st: [62ed09edba9825d6c3b18c146690a7b063ab40ef]
mainline: [e4e46fb61e3bb4628170810d3f2b996b709b90d9]
stable/5.10: [63400da6cd37a9793c19bb6aed7131b58b975a04]
stable/5.15: [0959cc1685eb19774300d43ef25e318b457b156b]
stable/6.1: [ba91b413983a9235792523c6b9f7ba2586c4d75d]

CVE-2022-50847: drm/bridge: it6505: Initialize AUX channel in it6505_i2c_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50847

Introduced by commit b5c84a9 ("drm/bridge: add it6505 driver") in v5.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e577d4b13064c337b83fe7edecb3f34e87144821]
stable/6.1: [172d4d64075075f955e6e416915e3f287eec514a]

CVE-2022-50848: drivers: dio: fix possible memory leak in dio_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50848

Introduced by commit 2e4c77b ("m68k: dio - Kill warn_unused_result
warnings") in v2.6.29-rc2.
Introduced by commit 1fa5ae8 ("driver core: get rid of struct device's
bus_id string array") in v2.6.30-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a524e7fed696a4dfef671e0fda3511bfd2dca0cf]
cip/4.4-st: [c1e25ce800ed734dbb59e52ed1e0e965b642376a]
mainline: [e63e99397b2613d50a5f4f02ed07307e67a190f1]
stable/5.10: [fce9890e1be4c0460dad850cc8c00414a9d25f0f]
stable/5.15: [a0ead7e8da84f4c3759417b8e928b65e0207c646]
stable/6.1: [78fddc0ff971f9874d53c854818cc4aafa144114]

CVE-2022-50849: pstore: Avoid kcore oops by vmap()ing with VM_IOREMAP

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50849

Introduced by commit 404a604 ("staging: android: persistent_ram:
handle reserving and mapping memory") in v3.4-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6d9460214e363e1f3d0756ee5d947e76e3e6f86c]
cip/4.4-st: [2a17effeadfddbc058e275561497334bed835794]
mainline: [e6b842741b4f39007215fd7e545cb55aa3d358a2]
stable/5.10: [295f59cd2cdeed841850d02dddde3a122cbf6fc6]
stable/5.15: [ebc73c4f266281e2cad1a372ecd81572d95375b6]
stable/6.1: [2f82381d0681b10f9ddd27be98c27363b5a3cd1c]

CVE-2022-50850: scsi: ipr: Fix WARNING in ipr_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50850

Introduced by commit f72919e ("[SCSI] ipr: implement shutdown changes
and remove obsolete write cache parameter") in v2.6.34-rc2.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5debd337f534b122f7c5eac6557a41b5636c9b51]
cip/4.4-st: [351e7e7d4fd71f6b98289ec97642f191ae62bb2c]
mainline: [e6f108bffc3708ddcff72324f7d40dfcd0204894]
stable/5.10: [f4ba143b04a17559f2c85e18b47db117f40d8cf3]
stable/5.15: [e59da172059f05c594fda03a9e8a3a0e1f5116c0]
stable/6.1: [4399a8632e5f8f1f695d91d992c7d418fb451f07]

CVE-2022-50851: vhost_vdpa: fix the crash in unmap a large memory

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50851

Introduced by commit 4c8cf31 ("vhost: introduce vDPA-based backend")
in v5.7-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e794070af224ade46db368271896b2685ff4f96b]
stable/6.1: [8b258a31c2e8d4d4e42be70a7c6ca35a5afbff0d]

CVE-2022-50852: wifi: mt76: mt7921: fix use after free in mt7921_acpi_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50852

Introduced by commit f965333 ("mt76: mt7921: introduce ACPI SAR
support") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7de4b4979bd8d313ec837931dde936653ca82ea]

CVE-2022-50853: NFSv4: Fix a credential leak in _nfs4_discover_trunking()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50853

Introduced by commit 4f40a5b ("NFSv4: Add an fattr allocation to
_nfs4_discover_trunking()") in v5.19-rc5.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [e83458fce080dc23c25353a1af90bfecf79c7369]
stable/5.15: [c6aca4c7ba8f6d40a0cfeeb09160dd8efdf97c64]
stable/6.1: [b247a9828f6607d41189fa6c2a3be754d33cae86]

CVE-2022-50854: nfc: virtual_ncidev: Fix memory leak in virtual_nci_send()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50854

Introduced by commit e624e6c ("nfc: Add a virtual nci device driver")
in v5.12-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e840d8f4a1b323973052a1af5ad4edafcde8ae3d]
stable/5.15: [88e879c9f59511174ef0ab1a3c9c83e2dbf8a213]

CVE-2022-50855: bpf: prevent leak of lsm program after failed attach

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50855

Introduced by commit 69fd337 ("bpf: per-cgroup lsm flavor") in v6.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e89f3edffb860a0f54a9ed16deadb7a4a1fa3862]
stable/6.1: [6a1504dd36cd9a0a69250d61da8bdb17b29f1fe8]

CVE-2022-50856: cifs: Fix xid leak in cifs_ses_add_channel()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50856

Introduced by commit d70e9fa ("cifs: try opening channels after
mounting") in v5.5-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e909d054bdea75ef1ec48c18c5936affdaecbb2c]
stable/5.10: [7286f875510486fdc2fc426b7c826262e2283a65]
stable/5.15: [847301f0ee1c29f34cc48547ce1071990f24969c]

CVE-2022-50857: rapidio: rio: fix possible name leak in rio_register_mport()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50857

Introduced by commit 2aaf308 ("rapidio: rework device hierarchy and
introduce mport class of devices") in v3.15-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a73a626c0510d203e369aeb26c4d6ec9c75af027]
mainline: [e92a216d16bde65d21a3227e0fb2aa0794576525]
stable/5.10: [97d9eb45ffa67ffa112a6659953321b8f7db0065]
stable/5.15: [a47de2fd3f88a7788be19f94ade72c2244a98045]
stable/6.1: [9abba4aa60874c5216fc8de7dededadc791de696]

CVE-2022-50858: mmc: alcor: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50858

Introduced by commit c5413ad ("mmc: add new Alcor Micro Cardreader
SD/MMC driver") in v5.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e93d1468f429475a753d6baa79b853b7ee5ef8c0]
stable/5.10: [4a6e5d0222804a3eaf2ea4cf893f412e7cf98cb2]
stable/5.15: [29c5b4da41f35108136d843c7432885c78cf8272]
stable/6.1: [60fafcf2fb7ee9a4125dc9a86eeb9d490acf23e2]

CVE-2022-50859: cifs: Fix the error length of VALIDATE_NEGOTIATE_INFO message

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50859

Introduced by commit d5c7076 ("smb3: add smb3.1.1 to default dialect
list") in v5.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e98ecc6e94f4e6d21c06660b0f336df02836694f]
stable/5.10: [9312e04b6c6bc46354ecd0cc82052a2b3df0b529]
stable/5.15: [60480291c1fcafad8425d93f771b5bcc2bd398b4]

CVE-2022-50860: apparmor: Fix memleak in alloc_ns()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50860

Introduced by commit a1bd627 ("apparmor: share profile name on
replacement") in v4.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9e6fa49dbab6d84c676666f3fe7d360497fd65b]
stable/5.10: [9a32aa87a25d800b2c6f47bc2749a7bfd9a486f3]
stable/5.15: [5f509fa740b17307f0cba412485072f632d5af36]
stable/6.1: [12695b4b76d437b9c0182a6f7dfb2248013a9daf]

CVE-2022-50861: NFSD: Finish converting the NFSv2 GETACL result encoder

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50861

Introduced by commit f8cba47 ("NFSD: Update the NFSv2 GETACL result
encoder to use struct xdr_stream") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [ea5021e911d3479346a75ac9b7d9dcd751b0fb99]
stable/5.10: [a20b0abab966a189a79aba6ebf41f59024a3224d]
stable/5.15: [5030d4d2bf8b6f6f3d16401ab92a88bc5aa2377a]
stable/6.1: [2b825efb0577a32a872e872a869e0947cf9dd6d3]

CVE-2022-50862: bpf: prevent decl_tag from being referenced in func_proto

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50862

Introduced by commit bd16dee ("bpf: Add BTF_KIND_DECL_TAG typedef
support") in v5.16-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea68376c8bed5cd156900852aada20c3a0874d17]

CVE-2022-50863: wifi: rtw89: free unused skb to prevent memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50863

Introduced commit is not determined.Fixed in v6.1-rc1.
Vulerable code was added by fc5f311 ("rtw89: don't flush hci queues
and send h2c if power is off") in v5.19-rc1.

Fixed status
mainline: [eae672f386049146058b9e5d3d33e9e4af9dca1d]

CVE-2022-50864: nilfs2: fix shift-out-of-bounds due to too large
exponent of block size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50864

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [ebeccaaef67a4895d2496ab8d9c2fb8d89201211]
stable/5.10: [ec93b5430ec0f60877a5388bb023d60624f9ab9f]
stable/5.15: [8b6ef451b5701b37d9a5905534595776a662edfc]
stable/6.1: [a16731fa1b96226c75bbf18e73513b14fc318360]

CVE-2022-50865: tcp: fix a signed-integer-overflow bug in tcp_add_backlog()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50865

Introduced by commit c9c3321 ("tcp: add tcp_add_backlog()") in v4.9-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec791d8149ff60c40ad2074af3b92a39c916a03f]
stable/5.10: [4f23cb2be530785db284a685d1b1c30224d8a538]
stable/5.15: [a85d39f14aa8a71e29cfb5eb5de02878a8779898]

CVE-2022-50866: ASoC: pxa: fix null-pointer dereference in filter()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50866

Introduced by commit 7a824e2 ("ASoC: mmp: add audio dma support") in v3.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0abd1d78317a3a2dfe00b203fbf14ee7df537e0a]
cip/4.4-st: [34d19864c61186553a780ef24533b037efdf7837]
mainline: [ec7bf231aaa1bdbcb69d23bc50c753c80fb22429]
stable/5.10: [21a1409e8cf73053b54f7860548e3043dfa351a9]
stable/5.15: [83baa509396a742e0ce145b09fde1ce0a948f49a]
stable/6.1: [21b92cf41952577a95bfa430e39478cbd66e42a7]

CVE-2022-50867: drm/msm/a6xx: Fix kvzalloc vs state_kcalloc usage

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50867

According to the .vulnerable file, this bug was introduced by commit
b859f9b in v5.17-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83d18e9d9c0150d98dc24e3642ea93f5e245322c]

CVE-2022-50868: hwrng: amd - Fix PCI device refcount leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50868

Introduced by commit 96d63c0 ("[PATCH] Add AMD HW RNG driver") in v2.6.20.16.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e246f5eff26055bdcb61a2cc99c50af72a19680f]
mainline: [ecadb5b0111ea19fc7c240bb25d424a94471eb7d]
stable/5.10: [5998e5c30e839f73e62cb29e0d9617b0d16ccba3]
stable/5.15: [2b79a5e560779b35e1164d57ae35c48b43373082]
stable/6.1: [2e10ecd012ae2b2a374b34f307e9bc1e6096c03d]

CVE-2022-50869: fs/ntfs3: Fix slab-out-of-bounds in r_page

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50869

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.

Fixed status
mainline: [ecfbd57cf9c5ca225184ae266ce44ae473792132]
stable/5.15: [ed686e7a26dd19ae6b46bb662f735acfa88ff7bc]
stable/6.1: [6d076293e5bffdf897ea5f975669206e09beed6a]

CVE-2022-50870: powerpc/rtas: avoid device tree lookups in rtas_os_term()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50870

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [06a07fbb32b3a23eec20a42b1e64474da0a3b33e]
mainline: [ed2213bfb192ab51f09f12e9b49b5d482c6493f3]
stable/5.10: [f2167f10fcca68ab9ae3f8d94d2c704c5541ac69]
stable/5.15: [d8939315b7342860df143afe0adda6212cdd3193]
stable/6.1: [464d10e8d797454e16a173ef1292a446b2adf21c]

CVE-2022-50871: wifi: ath11k: Fix qmi_msg_handler data structure initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50871

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file is added by d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.

Fixed status
mainline: [ed3725e15a154ebebf44e0c34806c57525483f92]
stable/6.1: [a10e1530c424bb277b4edc7def0195857a548495]

CVE-2022-50872: ARM: OMAP2+: Fix memory leak in realtime_counter_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50872

Introduced by commit fa6d79d ("ARM: OMAP: Add initialisation for the
real-time counter.") in v3.7-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e3a6af3059e4f83d1a986a3180eb1e04f99c9e64]
cip/4.4-st: [72454576f3cb45650e06aa83e6612a6b1e02fc25]
mainline: [ed8167cbf65c2b6ff6faeb0f96ded4d6d581e1ac]
stable/5.10: [4862c41d5f3bee1ec64c979c82bd8cfe96b78f7d]
stable/5.15: [10fcdad2b9f3f424873714eb8713a3e6f7ab84bb]
stable/6.1: [98df4bdf3b010c23cc3c542d0c303016e5fceb40]

CVE-2022-50873: vdpa/vp_vdpa: fix kfree a wrong pointer in vp_vdpa_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50873

Introduced by commit ffbda8e ("vdpa/vp_vdpa : add vdpa tool support in
vp_vdpa") in v5.19-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed843d6ed7310a27cf7c8ee0a82a482eed0cb4a6]
stable/6.1: [6ccc891f36d0c20ee220551caabdcd3886ec584b]

CVE-2022-50874: RDMA/erdma: Fix refcount leak in erdma_mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50874

Introduced by commit 1550557 ("RDMA/erdma: Add verbs implementation")
in v6.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee84146c05ad2316b9a7222d0ec4413e0bf30eeb]
stable/6.1: [8372207b009d6abdd60bb05624640bd86386599f]

CVE-2022-50875: of: overlay: fix null pointer dereferencing in
find_dup_cset_node_entry() and find_dup_cset_prop()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50875

Introduced by commit 2fe0e87 ("of: overlay: check prevents multiple
fragments touching same property") in v5.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee9d7a0e754568180a2f8ebc4aad226278a9116f]
stable/5.10: [2b4af99b44861646013821019dd13a4ac48c0219]
stable/5.15: [ce1b3a41e7964cb8dd56a702a95dd90ad27f51cd]
stable/6.1: [71d88c7453ec3d2ceff98e18ce4d6354abd3b5b6]

CVE-2022-50876: usb: musb: Fix musb_gadget.c rxstate overflow bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50876

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [7c80f3a918ba9aa26fb699ee887064ec3af0396a]
cip/4.4-st: [d805cddb60fb551669b6f5ff354cfdca528ddf0d]
mainline: [eea4c860c3b366369eff0489d94ee4f0571d467d]
stable/5.10: [acf0006f2b2b2ca672988875fd154429aafb2a9b]
stable/5.15: [3c84c7f592c4ba38f54ddaddd0115acc443025db]

CVE-2022-50877: net: broadcom: bcm4908_enet: update TX stats after
actual transmission

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50877

Introduced by commit 4feffea ("net: broadcom: bcm4908enet: add BCM4908
controller driver") in v5.12-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef3556ee16c68735ec69bd08df41d1cd83b14ad3]
stable/5.15: [c9589e18a60c55c76772a38117ef9a16b942e56b]

CVE-2022-50878: gpu: lontium-lt9611: Fix NULL pointer dereference in
lt9611_connector_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50878

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by 23278bf ("drm/bridge: Introduce LT9611 DSI
to HDMI bridge") in v5.10-rc1.

Fixed status
mainline: [ef8886f321c5dab8124b9153d25afa2a71d05323]
stable/5.10: [3959e8faf8bf6bea619e8856c736db64e6eced37]
stable/5.15: [a29f7427041a943484f916157c43c46d3bbf25d4]

CVE-2022-50879: objtool: Fix SEGFAULT

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50879

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by dcc914f ("objtool: Move checking code to
check.c") in v4.13-rc1.

Fixed status
mainline: [efb11fdb3e1a9f694fa12b70b21e69e55ec59c36]
stable/5.10: [0af0e115ff59d638f45416a004cdd8edb38db40c]
stable/5.15: [23a249b1185cdd5bfb6971d1608ba49e589f2288]
stable/6.1: [fcee8a2d4db404a93e690d79e7273b6ef9d33575]

CVE-2022-50880: wifi: ath10k: add peer map clean up for peer delete in
ath10k_sta_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50880

Introduced by commit d0eeafa ("ath10k: Clean up peer when sta goes
away.") in v4.8-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f12fc305c127bd07bb50373e29c6037696f916a8]
mainline: [f020d9570a04df0762a2ac5c50cf1d8c511c9164]
stable/5.10: [08faf07717be0c88b02b5aa45aad2225dfcdd2dc]
stable/5.15: [54a3201f3c1ff813523937da78b5fa7649dbab71]

CVE-2022-50881: wifi: ath9k: Fix use-after-free in ath9k_hif_usb_disconnect()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50881

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [f099c5c9e2ba08a379bd354a82e05ef839ae29ac]
stable/5.10: [99ff971b62e5bd5dee65bbe9777375206f5db791]
stable/5.15: [634a5471a6bd774c0d0fa448dfa6ec593e899ec9]
stable/6.1: [1f137c634a8c8faba648574f687805641e62f92e]

CVE-2022-50882: media: uvcvideo: Fix memory leak in uvc_gpio_parse

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50882

Introduced by commit 2886477 ("media: uvcvideo: Implement
UVC_EXT_GPIO_UNIT") in v5.12-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0f078457f18f10696888f8d0e6aba9deb9cde92]
stable/5.15: [6c5da92103bddd1f0c36cb69446ff7cae3043986]

CVE-2022-50883: bpf: Prevent decl_tag from being referenced in func_proto arg

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50883

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected function was added by 2667a26 ("bpf: btf: Add BTF_KIND_FUNC
and BTF_KIND_FUNC_PROTO") in v5.0-rc1.

Fixed status
mainline: [f17472d4599697d701aa239b4c475a506bccfd19]
stable/5.10: [329a76635548ee8fceb3b78c7d54d96524e80925]
stable/5.15: [b327c68ace71ba9cb3105ae6a5955a229e9bdca3]
stable/6.1: [e6d276dcc9204f95632580c43d66c52ca502d7ec]

CVE-2022-50884: drm: Prevent drm_copy_field() to attempt copying a NULL pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50884

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [8052612b9d08048ebbebcb572894670b4ac07d2f]
cip/4.4-st: [e1d0b649822686000f31403a5f2b97619fd770cf]
mainline: [f6ee30407e883042482ad4ad30da5eaba47872ee]
stable/5.10: [c28a8082b25ce4ec94999e10a30c50d20bd44a25]
stable/5.15: [ca163e389f0ae096a4e1e19f0a95e60ed80b4e31]

CVE-2022-50885: RDMA/rxe: Fix NULL-ptr-deref in rxe_qp_do_cleanup()
when socket create failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50885

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7340ca9f782be6fbe3f64a134dc112772764f766]
mainline: [f67376d801499f4fa0838c18c1efcad8840e550d]
stable/5.10: [6bb5a62bfd624039b05157745c234068508393a9]
stable/5.15: [f64f08b9e6fb305a25dd75329e06ae342b9ce336]
stable/6.1: [821f9a18210f6b9fd6792471714c799607b25db4]

CVE-2022-50886: mmc: toshsd: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50886

Introduced by commit a5eb8bb ("mmc: add Toshiba PCI SD controller
driver") in v3.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4f6cb1c685f9e20a4a9fa565e442f5af4dad70ff]
cip/4.4-st: [b0e4cc72f5be30a29894b9de75e8fd318b503451]
mainline: [f670744a316ea983113a65313dcd387b5a992444]
stable/5.10: [aabbedcb6c9a72d12d35dc672e83f0c8064d8a61]
stable/5.15: [6444079767b68b1fbed0e7668081146e80dcb719]
stable/6.1: [bfd77b194c94aefbde4efc30ddf8607dd9244672]

CVE-2022-50887: regulator: core: fix unbalanced of node refcount in
regulator_dev_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50887

Introduced by commit 69511a4 ("regulator: map consumer regulator based
on device tree") in v3.3-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3ac888db0f67813d91373a9a61c840f815cd4ec9]
cip/4.4-st: [88f16859e74a9a93d108bcc29645af7e47b532af]
mainline: [f2b41b748c19962b82709d9f23c6b2b0ce9d2f91]
stable/5.10: [f48c474efe05cf9ce5e535b5e0ddd710e963936c]
stable/5.15: [cda1895f3b7f324ece1614308a815a3994983b97]
stable/6.1: [2f98469c3141f8e42ba11075a273fb795bbad57f]

CVE-2022-50888: remoteproc: qcom: q6v5: Fix potential null-ptr-deref
in q6v5_wcss_init_mmio()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50888

Introduced by commit 0af65b9 ("remoteproc: qcom: wcss: Add non pas
wcss Q6 support for QCS404") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f360e2b275efbb745ba0af8b47d9ef44221be586]
stable/5.15: [098ebb9089c4eedea09333f912d105fa63377496]
stable/6.1: [0903a87490a9ed456ac765a84dcc484c1ee42c32]

CVE-2022-50889: dm integrity: Fix UAF in dm_integrity_dtr()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50889

Introduced by commit 7eada90 ("dm: add integrity target") in v4.12-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f50cb2cbabd6c4a60add93d72451728f86e4791c]
stable/5.10: [a506b5c92757b034034ef683e667bffc456c600b]
stable/5.15: [9215b25f2e105032114e9b92c9783a2a84ee8af9]
stable/6.1: [b6c93cd61afab061d80cc842333abca97b289774]

CVE-2023-54162: ksmbd: fix possible memory leak in smb2_lock()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54162

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3ca9f7aeba793d74361d88a8800b2f205c9236b]
stable/5.15: [bfe8372ef2dbdce97f13b21d76e2080ddeef5a79]
stable/6.1: [6bf555ed8938444466c3d7f3252eb874a518f293]

CVE-2023-54164: Bluetooth: ISO: fix iso_conn related locking and validity issues

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54164

Introduced by commit 241f519 ("Bluetooth: ISO: Avoid circular locking
dependency") in v6.2-rc1.
Introduced by commit 6a5ad25 ("Bluetooth: ISO: Fix possible circular
locking dependency") in v6.2-rc5.
Fixed in v6.5-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [d40ae85ee62e3666f45bc61864b22121346f88ef]
stable/6.1: [e969bfed84c1f88dc722a678ee08488e86f0ec1a]

CVE-2023-54165: zsmalloc: move LRU update from zs_map_object() to zs_malloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54165

Introduced by commit 64f768c ("zsmalloc: add a LRU to zs_pool to keep
track of zspages in LRU order") in v6.2-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d461aac924b937bcb4fd0ca1242b3ef6868ecddd]

CVE-2023-54166: igc: Fix Kernel Panic during ndo_tx_timeout callback

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54166

Introduced by commit 9b27517 ("igc: Add ndo_tx_timeout support") in v6.2-rc8.
Fixed in v6.5-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [d4a7ce642100765119a872d4aba1bf63e3a22c8a]
stable/5.15: [feba294c454a51bb1e80dd2ff038e335f07ae481]
stable/6.1: [c09df09241fdd6aa5b94a5243369662a13ec608a]

CVE-2023-54167: m68k: mm: Move initrd phys_to_virt handling after paging_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54167

Introduced by commit 376e3fd ("m68k: Enable memtest functionality") in
v5.17-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4b97925e87eb133e400fe4a482d750c74ce392f]
stable/6.1: [ceb089e2337f810d3594d310953d9af4783f660a]

CVE-2023-54168: RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54168

Introduced by commit 8390413 ("IB/mlx4: Sanity check userspace send
queue sizes") in v2.6.24-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3d5ae269c4bd392ec1edbfb3bd031b8f42d7feff]
mainline: [d50b3c73f1ac20dabc53dc6e9d64ce9c79a331eb]
stable/5.10: [9ad3221c86cc9c6305594b742d4a72dfbd4ea579]
stable/5.15: [9911be2155720221a4f1f722b22bd0e2388d8bcf]
stable/6.1: [3ce0df3493277b9df275cb8455d9c677ae701230]

CVE-2023-54169: net/mlx5e: fix memory leak in mlx5e_ptp_open

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54169

Introduced by commit 145e563 ("net/mlx5e: Add TX PTP port object
support") in v5.11-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d543b649ffe58a0cb4b6948b3305069c5980a1fa]
stable/5.15: [4892e1e548b5bd6524c1c89df06e4849df26fc20]
stable/6.1: [83a8f7337a14cdb215c76a8f4cf3f3be8b59177d]

CVE-2023-54170: keys: Fix linking a duplicate key to a keyring's assoc_array

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54170

Introduced by commit df593ee ("keys: Hoist locking out of
__key_link_begin()") in v5.3-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d55901522f96082a43b9842d34867363c0cdbac5]
stable/5.10: [0a6b0ca58685be34979236f83f2b322635b80b32]
stable/5.15: [9aecfebea24fe6071ace5cc9fd6d690b87276bbb]
stable/6.1: [00edfa6d4fe022942e2f2e6f3294ff13ef78b15c]

CVE-2023-54171: tracing: Fix memory leak of iter->temp when reading trace_pipe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54171

Introduced by commit ff89510 ("tracing: Save off entry when peeking at
next entry") in v5.7-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5a821896360cc8b93a15bd888fabc858c038dc0]
stable/5.10: [1a1e793e021d75cd0accd8f329ec9456e5cd105e]
stable/5.15: [954792db9f61b6c0b8a94b8831fed5f146014029]
stable/6.1: [be970e22c53d5572b2795b79da9716ada937023b]

CVE-2023-54172: x86/hyperv: Disable IBT when hypercall page lacks
ENDBR instruction

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54172

Introduced commit is not determined.Fixed in v6.5-rc5.
Affected file was added by 8730046 ("Drivers: hv vmbus: Move Hypercall
page setup out of common code") in v4.11-rc1.

Fixed status
mainline: [d5ace2a776442d80674eff9ed42e737f7dd95056]
stable/6.1: [98cccbd0a19a161971bc7f7feb10577adc62c400]

CVE-2023-54173: bpf: Disable preemption in bpf_event_output

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54173

Introduced by commit 2a916f2 ("bpf: Use migrate_disable/enable in
array macros and cgroup/lirc code.") in v5.7-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d62cc390c2e99ae267ffe4b8d7e2e08b6c758c32]
stable/5.10: [3048cb0dc0cc9dc74ed93690dffef00733bcad5b]
stable/5.15: [c81bdf8f9f2b002d217c3d5357cdea9f2b82ff90]
stable/6.1: [36dd8ca330b76585640ed32255a3c99f901e1502]

CVE-2023-54174: vfio: Fix NULL pointer dereference caused by
uninitialized group->iommufd

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54174

Introduced by commit 9eefba8 ("vfio: Move vfio group specific code
into group.c") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d649c34cb916b015fdcb487e51409fcc5caeca8d]

CVE-2023-54175: i2c: xiic: xiic_xfer(): Fix runtime PM leak on error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54175

Introduced by commit fdacc3c ("i2c: xiic: Switch from waitqueue to
completion") in v5.16-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [d663d93bb47e7ab45602b227701022d8aa16040a]
stable/5.10: [2d320d9de7d31c0eb279b3f8a02cf1af473a3737]
stable/5.15: [72cb227a368cf286efb8ce1e741e8c7085747b4d]
stable/6.1: [06e661a259978305c0015f6f33d14477a0cfbe8f]

CVE-2023-54176: mptcp: stricter state check in mptcp_worker

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54176

Introduced by commit e16163b ("mptcp: refactor shutdown and close") in
v5.11-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6a0443733434408f2cbd4c53fea6910599bab9e]
stable/5.15: [f0b4a4086cf27240fc621a560da9735159049dcc]
stable/6.1: [aff9099e9c51f15c8def05c75b2b73e8487b5d54]

CVE-2023-54177: quota: fix warning in dqgrab()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54177

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [965bad2bf1afef64ec16249da676dc7310cca32e]
cip/4.4-st: [e16796783a3b3cf1c96f3406e53128ee8874dc2b]
mainline: [d6a95db3c7ad160bc16b89e36449705309b52bcb]
stable/5.10: [cbaebbba722cb9738c55903efce11f51cdd97bee]
stable/5.15: [579d814de87c3cac69c9b261efa165d07cde3357]
stable/6.1: [6432843debe1ec7d76c5b2f76c67f9c5df22436e]

CVE-2023-54178: of: unittest: fix null pointer dereferencing in
of_unittest_find_node_by_name()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54178

Introduced by commit 0d638a0 ("of: Convert to using %pOF instead of
full_name") in v4.14-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0b7d715511915a1b39f5fdcbe57a7922dfd66513]
mainline: [d6ce4f0ea19c32f10867ed93d8386924326ab474]
stable/5.10: [f41c65f8d05be734898cbe72af59a401b97d298a]
stable/5.15: [ea5bc6f5aa099e3e84d037282836234ad77cba88]
stable/6.1: [43cc228099c514467b8074d7ede6673cef9f33b9]

CVE-2023-54179: scsi: qla2xxx: Array index may go out of bound

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54179

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [e697f466bf61280b7e996c9ea096d7ec371c31ea]
mainline: [d721b591b95cf3f290f8a7cbe90aa2ee0368388d]
stable/5.10: [bcd773969a87d9802053c0db5be84abd6594a024]
stable/5.15: [748d8f8698a2f48ffe32dd7b35dbab1810ed1f82]
stable/6.1: [2b3bdef089b920b4a19fefb4f4e6dda56a4bb583]

CVE-2023-54180: btrfs: handle case when repair happens with dev-replace

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54180

Introduced commit is not determined.Fixed in v6.2-rc3.


Fixed status
mainline: [d73a27b86fc722c28a26ec64002e3a7dc86d1c07]
stable/6.1: [53e9d6851b56626885476a2966194ba994f8bb4b]

CVE-2023-54181: bpf: Fix issue in verifying allow_ptr_leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54181

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2]
stable/6.1: [c96c67991aac6401b4c6996093bccb704bb2ea4b]

CVE-2023-54182: f2fs: fix to check readonly condition correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54182

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected code was added by a7d9fe3 ("f2fs: support RO feature") in v5.14-rc1.

Fixed status
mainline: [d78dfefcde9d311284434560d69c0478c55a657e]
stable/5.15: [e2759a59a4cc96af712084e9db7065c858c4fe9f]
stable/6.1: [e05d63f8b48aad4613bd582c945bee41e2dd7255]

CVE-2023-54183: media: v4l2-core: Fix a potential resource leak in
v4l2_fwnode_parse_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54183

Introduced by commit ca50c19 ("[media] v4l: fwnode: Support generic
fwnode for parsing standardised properties") in v4.13-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2342942331e1f034ff58f293e10d0d9b7581601f]
mainline: [d7b13edd4cb4bfa335b6008ab867ac28582d3e5c]
stable/5.10: [d8a8f75fce049bdb3144b607deefe51e996b9660]
stable/5.15: [caf058833b6f3fe7beabf738110f79bb987c8fff]
stable/6.1: [25afb3e03bf8ab02567af4b6ffbfd6250a91a9f8]

CVE-2023-54184: scsi: target: iscsit: Free cmds before session free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54184

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [d8990b5a4d065f38f35d69bcd627ec5a7f8330ca]
stable/5.10: [4621e24c9257c6379343bf0c11b473817cf7edcd]
stable/5.15: [1911cca5916b6e106de7afa3ec0a38447158216c]
stable/6.1: [a7a4def6c7046e090bb10c6d550fdeb487db98ba]

CVE-2023-54185: btrfs: remove BUG_ON()'s in add_new_free_space()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54185

Introduced commit is not determined.Fixed in v6.5-rc4.


Fixed status
mainline: [d8ccbd21918fd7fa6ce3226cffc22c444228e8ad]
stable/6.1: [23e72231f8281505883514b23709076e234d4f27]

CVE-2023-54186: usb: typec: altmodes/displayport: fix pin_assignment_show

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54186

Introduced by commit 0e3bb7d ("usb: typec: Add driver for DisplayPort
alternate mode") in v4.19-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0e61a7432fcd4bca06f05b7f1c7d7cb461880fe2]
mainline: [d8f28269dd4bf9b55c3fb376ae31512730a96fce]
stable/5.10: [ff466f77d0a56719979c4234abd412abd98eae8f]
stable/5.15: [fc0e18f95c88435bd8a1ceb540243cd7fbcd9781]
stable/6.1: [08bd1be1c716fd50a7df48f82dcbc59a103082b5]

CVE-2023-54187: f2fs: fix potential corruption when moving a directory

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54187

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [d94772154e524b329a168678836745d2773a6e02]
stable/5.10: [957904f531fd857a92743b11fbc9c9ffdf7f3207]
stable/5.15: [8f57f3e112cf1d16682b6ff9c31c72f40f7da9c9]
stable/6.1: [8a0b544b7caedfbc05065b6377fd1d8bf7ef5e70]

CVE-2023-54188: dmaengine: apple-admac: Fix 'current_tx' not getting freed

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54188

Introduced by commit b127315 ("dmaengine: apple-admac: Add Apple ADMAC
driver") in v6.0-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9503be5a100c553731c0e8a82c7b4201e8a970c]
stable/6.1: [b7abd535881a48587961c2099b1d2933ebd42c4b]

CVE-2023-54189: pstore/ram: Add check for kstrdup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54189

Introduced by commit e163fdb ("pstore/ram: Regularize prz label
allocation lifetime") in v5.5-rc6.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d97038d5ec2062733c1e016caf9baaf68cf64ea1]
stable/5.10: [a14cb307267ba7a1715403e071bdc4deda77eef5]
stable/5.15: [38a9d7dac3ad25323145b4aaea3b5f434f50011d]
stable/6.1: [f57ba91a46d3fc52bfdac9cca5cf5572ec7afd6d]

CVE-2023-54190: leds: led-core: Fix refcount leak in of_led_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54190

Introduced by commit 699a8c7 ("leds: Add of_led_get() and led_put()")
in v5.6-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da1afe8e6099980fe1e2fd7436dca284af9d3f29]
stable/5.10: [1d6101d9222e1ca8c01b3fa9ebf0dcf7bcd82564]
stable/5.15: [690efcb5827c3bacbf1de90cd14907b91bf8cb7b]
stable/6.1: [d880981b82223f9bf128dfdd2424abb0c658f345]

CVE-2023-54191: wifi: mt76: mt7996: fix memory leak in mt7996_mcu_exit

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54191

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da5b4d93e141b52c5a71d0c41a042d1bcaf70d2e]

CVE-2023-54192: f2fs: fix null pointer panic in tracepoint in
__replace_atomic_write_block

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54192

Introduced by commit 2f3a9ae ("f2fs: introduce
trace_f2fs_replace_atomic_write_block") in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [da6ea0b050fa720302b56fbb59307e7c7531a342]
stable/6.1: [424f8cdc0ad29e4940be96dcc0b935ba497adeda]

CVE-2023-54193: net/sched: cls_api: remove block_cb from driver_list
before freeing

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54193

Introduced by commit 59094b1 ("net: sched: use flow block API") in v5.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da94a7781fc3c92e7df7832bc2746f4d39bc624e]
stable/5.10: [7311c8be3755611bf6edea4dfbeb190b4bdd489f]
stable/5.15: [cb145932fcf6814e7e95e467eb70e7849a845ae9]
stable/6.1: [55866fe3fded3ce94ac3fc1bb3dfce654282f483]

CVE-2023-54194: exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54194

Introduced commit is not determined.Fixed in v6.5-rc5.
Affected function was added by 1e49a94 ("exfat: add bitmap
operations") in 5.7-rc1.

Fixed status
mainline: [daf60d6cca26e50d65dac374db92e58de745ad26]
stable/5.10: [79d16a84ea41272dfcb0c00f9798ddd0edd8098d]
stable/5.15: [8a34a242cf03211cc89f68308d149b793f63c479]
stable/6.1: [1427a7e96fb90d0896f74f5bcd21feb03cc7c3d0]

CVE-2023-54195: rxrpc: Fix timeout of a call that hasn't yet been
granted a channel

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54195

Introduced by commit 9d35d88 ("rxrpc: Move client call connection to
the I/O thread") in v6.2-rc4.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db099c625b13a74d462521a46d98a8ce5b53af5d]

CVE-2023-54196: fs/ntfs3: Fix NULL pointer dereference in 'ni_write_inode'

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54196

Introduced commit is not determined.Fixed in v6.4-rc1.
Vulnerable code was added by 82cae26 ("fs/ntfs3: Add initialization of
super block") in v5.15-rc1.

Fixed status
mainline: [db2a3cc6a3481076da6344cc62a80a4e2525f36f]
stable/5.15: [6d3d3283e6b4fb3f3ee05dac30ee1461930b8103]
stable/6.1: [329fc4d3f73d865b25f2ee4eafafb040ace37ad5]

CVE-2023-54197: Revert "Bluetooth: btsdio: fix use after free bug in
btsdio_remove due to unfinished work"

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54197

Introduced by commit 1e9ac11 ("Bluetooth: btsdio: fix use after free
bug in btsdio_remove due to unfinished work") in v6.3-rc4.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
cip/4.19-st: [70a104588e3131415e559c06deb834ce259a285a]
cip/4.4-st: [d4b3b023e2e7443bbfbebe1c3600db32ddb49cad]
mainline: [db2bf510bd5d57f064d9e1db395ed86a08320c54]
stable/5.10: [0837d10f6c37a47a0c73bccf1e39513613a2fcc2]
stable/5.15: [a789192f366147a0fbb395650079906d1d04e0b9]
stable/6.1: [952030c914b5f2288609efe868537afcff7a3f51]

CVE-2023-54198: tty: fix out-of-bounds access in tty_driver_lookup_tty()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54198

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [b79109d6470aaae7062998353e3a19449055829d]
cip/4.4-st: [5c397a78da8aa734a77d510324d5482aac383737]
mainline: [db4df8e9d79e7d37732c1a1b560958e8dadfefa1]
stable/5.10: [84ea44dc3e4ecb2632586238014bf6722aa5843b]
stable/5.15: [f9d9d25ad1f0d060eaf297a2f7f03b5855a45561]
stable/6.1: [765566110eb0da3cf60198b0165ecceeaafa6444]

CVE-2023-54199: drm/msm/adreno: Fix null ptr access in adreno_gpu_cleanup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54199

Introduced by commit 17e822f ("drm/msm: fix unbalanced
pm_runtime_enable in adreno_gpu_{init, cleanup}") in v5.9-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbeedbcb268d055d8895aceca427f897e12c2b50]
stable/5.10: [b26bd7791f3cdf3c3318162b1d40c9d1910facca]
stable/5.15: [399d01375659c273fb6ad9ccfb6e92bc5b891e0d]
stable/6.1: [7af606b9eb11d6cdf767cabbddc326e20d0d4702]

CVE-2023-54200: netfilter: nf_tables: always release netdev hooks from notifier

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54200

Introduced by commit 68a3765 ("netfilter: nf_tables: skip netdev
events generated on netns removal") in v5.15-rc7.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc1c9fd4a8bbe1e06add9053010b652449bfe411]
stable/5.15: [8d56f00c61f67b450fbbdcb874855e60ad92c560]
stable/6.1: [30e4b13b1bfbdf3bf3b27036d8209ea1b9f0d880]

CVE-2023-54201: RDMA/efa: Fix wrong resources deallocation order

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54201

Introduced by commit ff6629f ("RDMA/efa: Do not delay freeing of DMA
pages") in v5.7-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc202c57e9a1423aed528e4b8dc949509cd32191]
stable/6.1: [cf38960386f3cc4abf395e556af915e4babcafd2]

CVE-2023-54202: drm/i915: fix race condition UAF in i915_perf_add_config_ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54202

Introduced by commit f89823c ("drm/i915/perf: Implement
I915_PERF_ADD/REMOVE_CONFIG interface") in v4.14-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc30c011469165d57af9adac5baff7d767d20e5c]
stable/5.15: [6eeb1cba4c9dc47656ea328afa34953c28783d8c]
stable/6.1: [240b1502708858b5e3f10b6dc5ca3f148a322fef]

CVE-2023-54203: ksmbd: fix slab-out-of-bounds in init_smb2_rsp_hdr

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54203

Introduced by commit 39b291b ("ksmbd: return unsupported error on smb1
mount") in v6.3-rc4.
Fixed in v6.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [dc8289f912387c3bcfbc5d2db29c8947fa207c11]
stable/5.15: [921536046bd165efeb07beef5630aff35cd6a489]
stable/6.1: [a8334a0c535d0f0b4d64926c8fe0922ed98f7d43]

CVE-2023-54204: mmc: sunplus: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54204

Introduced by commit 4e268fe ("mmc: Add mmc driver for Sunplus
SP7021") in v6.2-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dce6d8f985fa1ef5c2af47f4f86ea65511b78656]

CVE-2023-54205: pinctrl: stm32: Fix refcount leak in stm32_pctrl_get_irq_domain

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54205

Introduced by commit d86f4d7 ("pinctrl: stm32: check irq controller
availability at probe") in v5.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcef18c8ac40aa85bb339f64c1dd31dd458b06fb]
stable/5.10: [8ab860dd8717a7e4a143988885fea0d7e5a9412e]
stable/5.15: [af54707c0ccab52b3d532402436ea101011a9299]
stable/6.1: [601be03fa8b81747a154bdef9b559411a5b921e8]

CVE-2023-54206: net/sched: flower: fix filter idr initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54206

Introduced by commit 08a0063 ("net/sched: flower: Move filter handle
initialization earlier") in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd4f6bbfa646f258e5bcdfac57a5c413d687f588]

CVE-2023-54207: HID: uclogic: Correct devm device reference for
hidinput input_dev name

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54207

Introduced by commit cce2dbd ("HID: uclogic: name the input nodes
based on their tool") in v4.1-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd613a4e45f8d35f49a63a2064e5308fa5619e29]
stable/6.1: [f283805d984343b2f216e2f4c6c7af265b9542ae]

CVE-2023-54208: media: ov5675: Fix memleak in ov5675_init_controls()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54208

Introduced by commit bf27502 ("media: ov5675: Add support for OV5675
sensor") in v5.4-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd74ed6c213003533e3abf4c204374ef01d86978]
stable/5.10: [bcae9115a163198dce9126aa8bedc1c007ec30ed]
stable/5.15: [ba54908ae8225d58f1830edb394d4153bcb7d0aa]
stable/6.1: [49b849824b9862f177fc77fc92ef95ec54566ecf]

CVE-2023-54209: block: fix blktrace debugfs entries leakage

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54209

Introduced by commit 99d055b ("block: remove per-disk debugfs files in
blk_unregister_queue") in v5.19-rc4.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd7de3704af9989b780693d51eaea49a665bd9c2]
stable/6.1: [aa07e56c6a9c7558165690d14eed4fe8babf34fb]

CVE-2023-54210: Bluetooth: hci_sync: Avoid use-after-free in dbg for
hci_remove_adv_monitor()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54210

Introduced by commit 7cf5c29 ("Bluetooth: hci_sync: Refactor remove
Adv Monitor") in v6.0-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de6dfcefd107667ce2dbedf4d9337f5ed557a4a1]
stable/6.1: [0d4d6b083da9b033ddccef72d77f373c819ae3ea]

CVE-2023-54211: tracing: Fix warning in trace_buffered_event_disable()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54211

Introduced by commit 0fc1b09 ("tracing: Use temp buffer when filtering
events") in v4.7-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b4f4ab423107dc1ba8e9cc6488c645be6403d3f5]
mainline: [dea499781a1150d285c62b26659f62fb00824fce]
stable/5.10: [a6d2fd1703cdc8ecfc3e73987e0fb7474ae2b074]
stable/5.15: [813cede7b2f5a4b1b75d2d4bb4e705cc8e063b20]
stable/6.1: [a3a3c7bddab9b6c5690b20796ef5e332b8c48afb]

CVE-2023-54213: USB: sisusbvga: Add endpoint checks

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54213

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [a8f980ecb0112100366c64e0404d9dd1dcbd2fcd]
cip/4.4-st: [fc29a8521dd406725ae749a5724f5100687ce0e9]
mainline: [df05a9b05e466a46725564528b277d0c570d0104]
stable/5.10: [ccef03c5113506d27dd6530d3a9ef5715c068e13]
stable/5.15: [43f569fd0699c4240a5c96e5ba1a0844a595afca]
stable/6.1: [d5dba4b7bf904143702fb4be641802ee2e9c95aa]

CVE-2023-54214: Bluetooth: L2CAP: Fix potential user-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54214

Introduced by commit a6a5568 ("Bluetooth: Lock the L2CAP channel when
sending") in v3.5-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a6a7d1541fefddf7ca0cfb34c1bff63ff809cc49]
cip/4.4-st: [18e38ad2ce165eb713c2a4a4047f0275b254af14]
mainline: [df5703348813235874d851934e957c3723d71644]
stable/5.10: [b8ed41cc04fb74005aa51d17865ca3d022760335]
stable/5.15: [31a288a4df7f6a28e65da22a4ab2add4a963738e]
stable/6.1: [64e28ecf44e46de9f01915a4146706a21c3469d2]

CVE-2023-54215: virtio-vdpa: Fix cpumask memory leak in virtio_vdpa_find_vqs()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54215

Introduced by commit 3dad568 ("virtio-vdpa: Support interrupt affinity
spreading mechanism") in v6.4-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df9557046440b0a62250fee3169a8f6a139f55a6]

CVE-2023-54216: net/mlx5e: TC, Fix using eswitch mapping in nic mode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54216

Introduced by commit 6702782 ("net/mlx5e: TC, Set CT miss to the
specific ct action instance") in v6.3-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dfa1e46d6093831b9d49f0f350227a1d13644a2f]

CVE-2023-54217: Revert "drm/msm: Add missing check and destroy for
alloc_ordered_workqueue"

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54217

Introduced by commit 643b7d0 ("drm/msm: Add missing check and destroy
for alloc_ordered_workqueue") in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dfa70344d1b5f5ff08525a8c872c8dd5e82fc5d9]

CVE-2023-54218: net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54218

Introduced by commit 6c7c98b ("sock: avoid dirtying sk_stamp, if
possible") in v4.12-rc1.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [564c3150ad357d571a0de7d8b644aa1f7e6e21b7]
mainline: [dfd9248c071a3710c24365897459538551cb7167]
stable/5.10: [d06f67b2b8dcd00d995c468428b6bccebc5762d8]
stable/5.15: [de260d1e02cde39d317066835ee6e5234fc9f5a8]
stable/6.1: [7145f2309d649ad6273b9f66448321b9b4c523c8]

CVE-2023-54219: Revert "IB/isert: Fix incorrect release of isert connection"

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54219

Introduced by commit 699826f ("IB/isert: Fix incorrect release of
isert connection") in v6.4-rc7.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
cip/4.19-st: [a277b736309f923d9baff0ef166d694d348a5b96]
cip/4.4-st: [bf8744485c3f1579962ab9b713c4245c0635f569]
mainline: [dfe261107c080709459c32695847eec96238852b]
stable/5.10: [aa950b9835f2d004b071fd220459edd3cd0a3603]
stable/5.15: [1bb42aca7a9611c1991a790834e2a65f3345c5e8]
stable/6.1: [3f39698e7e842abc9bd2bd97bf5eeda4543db758]

CVE-2023-54220: serial: 8250: Fix oops for port->pm on uart_change_pm()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54220

Introduced by commit 04e8279 ("serial: 8250: Reinit port->pm on port
specific driver unbind") in v6.4-rc1.
Fixed in v6.5-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
cip/4.19-st: [720a297b334e85d34099e83d1f375b92c3efedd6]
cip/4.4-st: [7c5593b3e976fba655a7f1dcc3e61c440ebff60b]
mainline: [dfe2aeb226fd5e19b0ee795f4f6ed8bc494c1534]
stable/5.10: [bd70d0b28010d560a8be96b44fea86fe2ba016ae]
stable/5.15: [18e27df4f2b4e257c317ba8076f31a888f6cc64b]
stable/6.1: [0c05493341d6f2097f75f0a5dbb7b53a9e8c5f6c]

CVE-2023-54221: clk: imx93: fix memory leak and missing unwind goto in
imx93_clocks_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54221

Introduced by commit 24defbe ("clk: imx: add i.MX93 clk") in v5.18-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e02ba11b457647050cb16e7cad16cec3c252fade]
stable/6.1: [280a5ff665e12d1e0c54c20cedc9c5008aa686a5]

CVE-2023-54222: hte: tegra-194: Fix off by one in tegra_hte_map_to_line_id()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54222

Introduced by commit 09574cc ("hte: Add Tegra194 HTE kernel provider")
in v5.19-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e078180d66848a6a890daf0a3ce28dc43cc66790]
stable/6.1: [fed87ce073c7b9f4f255105f90bd930df06d18a7]

CVE-2023-54223: net/mlx5e: xsk: Fix invalid buffer access for legacy rq

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54223

Introduced by commit 7abd955 ("net/mlx5e: RX, Fix page_pool page
fragment tracking for XDP") in v6.5-rc2.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0f52298fee449fec37e3e3c32df60008b509b16]

CVE-2023-54224: btrfs: fix lockdep splat and potential deadlock after
failure running delayed items

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54224

Introduced commit is not determined.Fixed in v6.6-rc2.


Fixed status
cip/4.19-st: [126d5a99e583e2d387ee4ea7b796c8fec4483244]
cip/4.4-st: [2d058dccf8b8a65225b3101ff42428d61bb41e0d]
mainline: [e110f8911ddb93e6f55da14ccbbe705397b30d0b]
stable/5.10: [3d379dd109f80c8f3b9aaa2d15681b37803aa4c0]
stable/5.15: [779c3cf2749c7a7bad6f839cb2954a25ba92f4d6]
stable/6.1: [32247b9526bfdaeef85f7339d9b4f913c7370f92]

CVE-2023-54225: net: ipa: only reset hashed tables when supported

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54225

Introduced by commit d338ae2 ("net: ipa: kill all other transaction
lists") in v6.1-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e11ec2b868af2b351c6c1e2e50eb711cc5423a10]
stable/6.1: [50c24f0c940728792c8bdf65c1eaf6b91b3b0dcd]

CVE-2023-54226: af_unix: Fix data races around sk->sk_shutdown.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54226

Introduced by commit 3c73419 ("af_unix: fix 'poll for write'/
connected DGRAM sockets") in v2.6.26-rc7.
Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1c488f4e95b498c977fbeae784983eb4cf6085e8]
mainline: [e1d09c2c2f5793474556b60f83900e088d0d366d]
stable/5.10: [8307e372e7445ec7d3cd2ff107ce5078eaa02815]
stable/5.15: [a41559ae3681975f1ced815d8d4c983b6b938499]
stable/6.1: [e410895892f99700ce54347d42c8dbe962eea9f4]

CVE-2023-54227: blk-mq: fix tags leak when shrink nr_hw_queues

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54227

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [e1dd7bc93029024af5688253b0c05181d6e01f8e]

CVE-2023-54228: regulator: raa215300: Fix resource leak in case of error

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54228

Introduced by commit 7bce166 ("regulator: Add Renesas PMIC RAA215300
driver") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt

Fixed status
mainline: [e21ac64e669e960688e79bf5babeed63132dac8a]

CVE-2023-54229: wifi: ath11k: fix registration of 6Ghz-only phy
without the full channel range

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54229

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected file was added by d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.

Fixed status
mainline: [e2ceb1de2f83aafd8003f0b72dfd4b7441e97d14]
stable/5.10: [532f8bac60419eb28158770470b9bb655de207c8]
stable/5.15: [f97832620d7f320bea81707f34631371e87a419b]
stable/6.1: [8d1342108c2bf11aaaf293becfc010ecdb6170d9]

CVE-2023-54230: amba: bus: fix refcount leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54230

Introduced by commit 5de1540 ("drivers/amba: create devices from
device tree") in v3.1-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9062ce0ccbd82fbe81cc839a512c0ad90847e01c]
cip/4.4-st: [8e6b7e85b722bd7d09738b6a5d7797e82fd039e6]
mainline: [e312cbdc11305568554a9e18a2ea5c2492c183f3]
stable/5.10: [9baf2278b3eed2c50112169121257d8a6ee0606c]
stable/5.15: [4f1807fddd9bf175ee5e14fffc6b6106e4b297ef]
stable/6.1: [81ff633a88be2482c163d3acd2801d501261ce6a]

CVE-2023-54231: net: libwx: fix memory leak in wx_setup_rx_resources

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54231

Introduced by commit 850b971 ("net: libwx: Allocate Rx and Tx
resources") in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e315e7b83a22043bffee450437d7089ef373cbf6]

CVE-2023-54232: m68k: Only force 030 bus error if PC not in exception table

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54232

Introduced commit is not determined.Fixed in v6.3-rc2.


Fixed status
cip/4.19-st: [f55cb52ec98b22125f5bda36391edb8894f7e8cf]
cip/4.4-st: [193e83a8194fcb23b6fb4aea9518a67b786df1c5]
mainline: [e36a82bebbf7da814530d5a179bef9df5934b717]
stable/5.10: [df1da53a7e98f0b2a0eb2241c154f148f2f2c1d8]
stable/5.15: [8bf8d5dade4c5e1d8a2386f29253ed28b5d87735]
stable/6.1: [54fa25ffab2b700df5abd58c136d64a912c53953]

CVE-2023-54233: ASoC: SOF: avoid a NULL dereference with unsupported widgets

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54233

Introduced commit is not determined.Fixed in v6.3-rc6.
Affected file was added by 3acd527 ("ASoC: SOF: ipc4-topology: Add
route_setup/route_free ops") in v6.0-rc1.

Fixed status
mainline: [e3720f92e0237921da537e47a0b24e27899203f8]

CVE-2023-54234: scsi: mpi3mr: Fix missing mrioc->evtack_cmds initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54234

Introduced by commit c1af985 ("scsi: mpi3mr: Add Event acknowledgment
logic") in v5.17-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e39ea831ebad4ab15c4748cb62a397a8abcca36e]
stable/6.1: [4e0dfdb48a824deac3dfbc67fb856ef2aee13529]

CVE-2023-54235: PCI/DOE: Fix destroy_work_on_stack() race

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54235

Introduced by commit abf04be ("PCI/DOE: Fix memory leak with
CONFIG_DEBUG_OBJECTS=y") in v6.3-rc6.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [e3a3a097eaebaf234a482b4d2f9f18fe989208c1]
stable/6.1: [d96799ee3b78962c80e4b6653734f488f999ca09]

CVE-2023-54236: net/net_failover: fix txq exceeding warning

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54236

Introduced by commit cfc80d9 ("net: Introduce net_failover driver") in
v4.18-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3cbdcb0fbb61045ef3ce0e072927cc41737f787]
stable/5.10: [f032e125149d914e542548c17ebd613851031368]
stable/5.15: [2d5cebf57296f0189a61482035ad420384eedead]
stable/6.1: [c942f5cd63b7c2e73fe06744185a34b03267595b]

CVE-2023-54237: net/smc: fix potential panic dues to unprotected
smc_llc_srv_add_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54237

Introduced by commit 2d2209f ("net/smc: first part of add link
processing as SMC server") in v5.8-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e40b801b3603a8f90b46acbacdea3505c27f01c0]
stable/6.1: [f2f46de98c11d41ac8d22765f47ba54ce5480a5b]

CVE-2023-54238: mlx5: fix skb leak while fifo resync and push

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54238

Introduced by commit 58a5189 ("net/mlx5e: Add resiliency for PTP TX
port timestamp") in v6.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e435941b1da1a0be4ff8a7ae425774c76a5ac514]
stable/6.1: [234cffda95e1049f58e8ec136ef105c633f0ed19]

CVE-2023-54239: iommufd: Check for uptr overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54239

Introduced by commit 8d160cd ("iommufd: Algorithms for PFN storage")
in v6.2-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4395701330fc4aee530905039516fe770b81417]

CVE-2023-54240: net: ethernet: mtk_eth_soc: fix possible NULL pointer
dereference in mtk_hwlro_get_fdir_all()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54240

Introduced by commit 7aab747 ("net: ethernet: mediatek: add ethtool
functions to configure RX flows of HW LRO") in v4.9-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [751b2e22a188b0c306029d094da29b6b8de31430]
mainline: [e4c79810755f66c9a933ca810da2724133b1165a]
stable/5.10: [75f2de75c1182e80708c932418e4895dbc88b68f]
stable/5.15: [072324cfab9b96071c0782f51f53cc5aea1e9d5b]
stable/6.1: [ff5faed5f5487b0fd2b640ba1304f82a5ebaab42]

CVE-2023-54241: MIPS: KVM: Fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54241

Introduced by commit 45c7e8a ("MIPS: Remove KVM_TE support") in v5.13-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4de2057698636c0ee709e545d19b169d2069fa3]
stable/5.15: [cd517f9a9d07d41f4f3593b1da3982261e09d162]
stable/6.1: [bd9cf2a5f9e1b2229ad22f21de6f6ad1a9c8858e]

CVE-2023-54242: block, bfq: Fix division by zero error on zero wsum

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54242

Introduced commit is not determined.Fixed in v6.4-rc1.
Vulnerable function was added by 76f1df8 ("bfq: Limit number of
requests consumed by each cgroup") in v5.17-rc1.

Fixed status
mainline: [e53413f8deedf738a6782cc14cc00bd5852ccf18]
stable/6.1: [1655cfc85250a224b0d9486c8136baeea33b9b5c]

CVE-2023-54243: netfilter: ebtables: fix table blob use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54243

Introduced by commit c58dd2d ("netfilter: Can't fail and free after
table replacement") in v3.15-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e58a171d35e32e6e8c37cfe0e8a94406732a331f]
stable/5.10: [9060abce3305ab2354c892c09d5689df51486df5]
stable/5.15: [dbb3cbbf03b3c52cb390fabec357f1e4638004f5]
stable/6.1: [3dd6ac973351308d4117eda32298a9f1d68764fd]

CVE-2023-54244: ACPI: EC: Fix oops when removing custom query handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54244

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [0d528a7c421b1f1772fc1d29370b3b5fc0f42b19]
cip/4.4-st: [4a8961871f4abc8bec42cdd8685088b401d4adbd]
mainline: [e5b492c6bb900fcf9722e05f4a10924410e170c1]
stable/5.10: [066b90bca755f0b876e7b027b75d1796861d6db0]
stable/5.15: [f4a573eed6377d356f835a4b00099d5dacee0da0]
stable/6.1: [86a159fd5bdb01ec34b160cfda1a313b616d9302]

CVE-2023-54245: ASoC: codecs: tx-macro: Fix for KASAN: slab-out-of-bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54245

Introduced commit is not determined.Fixed in v6.3-rc3.
Affected file was added by c39667d ("ASoC: codecs: lpass-tx-macro: add
support for lpass tx macro") in v5.12-rc1-dontuse.

Fixed status
mainline: [e5e7e398f6bb7918dab0612eb6991f7bae95520d]
stable/5.15: [da35a4e6eee5d73886312e85322a6e97df901987]
stable/6.1: [57f9a9a232bde7abfe49c3072b29a255da9ba891]

CVE-2023-54246: rcuscale: Move rcu_scale_writer()
schedule_timeout_uninterruptible() to _idle()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54246

Introduced commit is not determined.Fixed in v6.6-rc1.
Vulnerable code was added by df37e66 ("rcutorture: Add rcuperf holdoff
boot parameter to reduce interference") in v4.7-rc1.

Fixed status
mainline: [e60c122a1614b4f65b29a7bef9d83b9fd30e937a]
stable/5.10: [55887adc76e19aec9763186e2c1d0a3481d20e96]
stable/5.15: [4f03fba096bfded90e0d71eba8839a46922164d1]
stable/6.1: [83ed0cdb6ae0383dd14b02375c353773836884ed]

CVE-2023-54247: bpf: Silence a warning in btf_type_id_size()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54247

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected file was added by 69b693f ("bpf: btf: Introduce BPF Type
Format (BTF)") in v4.18-rc1.

Fixed status
mainline: [e6c2f594ed961273479505b42040782820190305]
stable/6.1: [61f4bd46a03a81865aca3bcbad2f7b7032fb3160]

CVE-2023-54248: fs/ntfs3: Add check for kmemdup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54248

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6c3cef24cb0d045f99d5cb039b344874e3cfd74]
stable/5.15: [952bbfcedbf895963509861e55a6e4fc105eb842]
stable/6.1: [7898db22ed6cee909513cf4935b5f9f0298b74f0]

CVE-2023-54249: bus: mhi: ep: Only send -ENOTCONN status if client
driver is available

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54249

Introduced by commit e827569 ("bus: mhi: ep: Add support for
processing command rings") in v5.19-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6cebcc27519dcf1652e604c73b9fd4f416987c0]
stable/6.1: [353aea15d6edbd4e69e039356a1bd3e641f7d952]

CVE-2023-54250: ksmbd: avoid out of bounds access in decode_preauth_ctxt()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54250

Introduced commit is not determined.Fixed in v6.3-rc7.
Affected file was added by e2f3448 ("cifsd: add server-side procedures
for SMB3") in v5.15-rc1.

Fixed status
mainline: [e7067a446264a7514fa1cfaa4052cdb6803bc6a2]
stable/5.15: [39f5b4b313b445c980a2a295bed28228c29228ed]
stable/6.1: [a2f6ded41bec1d3be643c80a5eb97f1680309001]

CVE-2023-54251: net/sched: taprio: Limit
TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54251

Introduced by commit 4cfd577 ("taprio: Add support for txtime-assist
mode") in v5.3-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e739718444f7bf2fa3d70d101761ad83056ca628]
stable/5.15: [f04f6d9b3b060f7e11219a65a76da65f1489e391]
stable/6.1: [0b45af982a4df0b14fb8669ee2a871cfdfa6a39c]

CVE-2023-54252: platform/x86: think-lmi: Fix memory leaks when parsing
ThinkStation WMI strings

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54252

Introduced by commit 8a02d70 ("platform/x86: think-lmi: Add
possible_values for ThinkStation") in v6.3-rc5.
Fixed in v6.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [e7d796fccdc8d17c2d21817ebe4c7bf5bbfe5433]
stable/5.15: [cccdb30935c82be805d3362a15680b95d5cb3ee0]
stable/6.1: [081da7b1c881828244b93b3befb7c18389f696bb]

CVE-2023-54253: btrfs: set page extent mapped after read_folio in
relocate_one_page

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54253

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [e7f1326cc24e22b38afc3acd328480a1183f9e79]
stable/6.1: [08daa38ca212d87f77beae839bc9be71079c7abf]

CVE-2023-54254: drm/ttm: Don't leak a resource on eviction error

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54254

Introduced by commit 4037979 ("drm/ttm: Fix multihop assert on
eviction.") in v5.15-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8188c461ee015ba0b9ab2fc82dbd5ebca5a5532]
stable/5.15: [7738335d73d0686ec8995e0448e5d1b48cffb2a4]
stable/6.1: [e9c44738cb1f537b177cc1beabcf6913690460cd]

CVE-2023-54255: sh: dma: Fix DMA channel offset calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54255

Introduced by commit 7f47c71 ("sh: dma: More legacy cpu dma
chainsawing.") in v3.5-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [479380acfa63247b5ac62476138f847aefc62692]
cip/4.4-st: [7a0b0a316ca889032aa5f8adf83236acc320ae2f]
mainline: [e82e47584847129a20b8c9f4a1dcde09374fb0e0]
stable/5.10: [d1c946552af299f4fa85bf7da15e328123771128]
stable/5.15: [196f6c71905aa384c0177acf194a1144d480333b]
stable/6.1: [8fb11fa4805699c6b73a9c8a9d45807f9874abe3]

CVE-2023-54257: net: macb: fix a memory corruption in extended buffer
descriptor mode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54257

Introduced by commit 7b42961 ("net: macb: Add support for PTP
timestamps in DMA descriptors") in v4.13-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [82e626af24683e01211abe66cec27a387f8f17c9]
mainline: [e8b74453555872851bdd7ea43a7c0ec39659834f]
stable/5.10: [1bec9da233f779e7b6954ee07ad7e6d8f2a4dd83]
stable/5.15: [7ccc58a1a75601c936069d4a0741940623990ade]
stable/6.1: [9412a9bf5952cdf5d0f736cc1e8c68fd366c2d47]

CVE-2023-54258: cifs: fix potential oops in cifs_oplock_break

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54258

Introduced by commit da787d5 ("SMB3: Do not send lease break
acknowledgment if all file handles have been closed") in v6.5-rc1.
Fixed in v6.5-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [e8f5f849ffce24490eb9449e98312b66c0dba76f]
stable/5.15: [b99f490ea87ebcca3a429fd8837067feb56a4c7c]
stable/6.1: [5ee28bcfbaacf289eb25c662a2862542ea6ce6a7]

CVE-2023-54259: soundwire: bus: Fix unbalanced pm_runtime_put()
causing usage count underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54259

Introduced commit is not determined.Fixed in v6.4-rc1.
This commit reverts 443a98e ("soundwire: bus: use
pm_runtime_resume_and_get()") in v5.19-rc1.

Fixed status
mainline: [e9537962519e88969f5f69cd0571eb4f6984403c]
stable/6.1: [4e5e9da139c007dfc397a159093b4c4187ee67fa]

CVE-2023-54260: cifs: Fix lost destroy smbd connection when MR allocate failed

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54260

Introduced by commit c739858 ("CIFS: SMBD: Implement RDMA memory
registration") in v4.16-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d303e25887127364a6765eaf7ac68aa2bac518a9]
mainline: [e9d3401d95d62a9531082cd2453ed42f2740e3fd]
stable/5.10: [caac205e0d5b44c4c23a10c6c0976d50ebe16ac2]
stable/5.15: [46cd6c639cddba2bd2d810ceb16bb20374ad75b0]
stable/6.1: [c51ae01104b318bf15f3c5097faba5c72addba7a]

CVE-2023-54261: drm/amdkfd: Add missing gfx11 MQD manager callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54261

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected file was added by cc009e6 ("drm/amdkfd: Add KFD support for
soc21 v3") in v5.19-rc1.

Fixed status
mainline: [e9dca969b2426702a73719ab9207e43c6d80b581]

CVE-2023-54262: net/mlx5e: Don't clone flow post action attributes second time

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54262

Introduced by commit 8300f22 ("net/mlx5e: Create new flow attr for
multi table actions") in v5.18-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9fce818fe003b6c527f25517b9ac08eb4661b5d]
stable/6.1: [c382b693ffcb1f1ebf60d76ab9dedfe9ea13eedf]

CVE-2023-54263: drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54263

Introduced commit is not determined.Fixed in v6.5-rc3.


Fixed status
mainline: [ea293f823a8805735d9e00124df81a8f448ed1ae]

CVE-2023-54264: fs/sysv: Null check to prevent null-ptr-deref bug

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54264

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [baa60c66a310c50785289b0ede6fdce8ec3219c7]
cip/4.4-st: [a198a65061cbb00fe04d0942eaf03be12a90835a]
mainline: [ea2b62f305893992156a798f665847e0663c9f41]
stable/5.10: [7f740bc696d4617f8ee44565e8ac0d36278a1e91]
stable/5.15: [afd9a31b5aa4b3747f382d44a7b03b7b5d0b7635]
stable/6.1: [1416eebaad80bdc85ad9f97f27242011b031e2a9]

CVE-2023-54265: ipv6: Fix an uninit variable access bug in __ip6_make_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54265

Introduced by commit 14878f7 ("[IPV6]: Add ICMPMsgStats MIB (RFC 4293)
[rev 2]") in v2.6.24-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f394f690a30a5ec0413c62777a058eaf3d6e10d5]
cip/4.4-st: [5639b9e625cc3d534f4035e150c9f471388b7170]
mainline: [ea30388baebcce37fd594d425a65037ca35e59e8]
stable/5.10: [605b056d63302ae84eb136e88d4df49124bd5e0d]
stable/5.15: [d65ff2fe877c471aa6e79efa7bd8ff66e147c317]
stable/6.1: [2c9cefc142c1dc2759e19a92d3b2b3715e985beb]

CVE-2023-54266: media: dvb-usb: m920x: Fix a potential memory leak in
m920x_i2c_xfer()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54266

Introduced by commit a2ab06d ("media: m920x: don't use stack on USB
reads") in v5.17-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
cip/4.19-st: [c0178e938f110cdf6937f26975c0c951dbb1d9db]
cip/4.4-st: [62321bc9f683b076b079b38d00a72878db64b668]
mainline: [ea9ef6c2e001c5dc94bee35ebd1c8a98621cf7b8]
stable/5.10: [d13a84874a2e0236c9325b3adc8e126d0888ad6b]
stable/5.15: [7ca7cd02114ac8caa6b0a64734b9af6be1559353]
stable/6.1: [2b6e20ef0585a467c24c7e4fde28518e5b33225a]

CVE-2023-54267: powerpc/pseries: Rework lppaca_shared_proc() to avoid
DEBUG_PREEMPT

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54267

Introduced by commit f13c13a ("powerpc: Stop using non-architected
shared_proc field in lppaca") in v3.12-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eac030b22ea12cdfcbb2e941c21c03964403c63f]
stable/5.10: [953c54dfdc5d3eb7243ed902b50acb5ea1db4355]
stable/5.15: [2935443dc9c28499223d8c881474259e4b998f2a]
stable/6.1: [4c8568cf4c45b415854195c8832b557cdefba57a]

CVE-2023-54268: debugobjects: Don't wake up kswapd from fill_pool()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54268

Introduced by commit 3ac7fe5 ("infrastructure to debug (dynamic)
objects") in v2.6.26-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb799279fb1f9c63c520fe8c1c41cb9154252db6]
stable/5.10: [fd673079749bac97bb30f1461df079e6c8e86511]
stable/5.15: [aee97eec77029270866c704f66cdf2881cbd2fe1]
stable/6.1: [d7fff52c99d52f180d8bef95d8ed8fec6343889c]

CVE-2023-54269: SUNRPC: double free xprt_ctxt while still in use

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54269

Introduced by commit 773f91b ("SUNRPC: Fix NFSD's request deferral on
RDMA transports") in v5.18-rc3.
Fixed in v6.4-rc3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [eb8d3a2c809abd73ab0a060fe971d6b9019aa3c1]
stable/5.15: [7851771789e87108a92697194105ef0c9307dc5e]
stable/6.1: [fd86534872f445f54dc01e7db001e25eadf063a8]

CVE-2023-54270: media: usb: siano: Fix use after free bugs caused by
do_submit_urb

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54270

Introduced by commit dd47fbd ("[media] smsusb: don't sleep while
atomic") in v4.6-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1477b00ff582970df110fc9e15a5e2021acb9222]
mainline: [ebad8e731c1c06adf04621d6fd327b860c0861b5]
stable/5.10: [42f8ba8355682f6c4125b75503cac0cef4ac91d3]
stable/5.15: [114f768e7314ca9e1fdbebe11267c4403e89e7f2]
stable/6.1: [479796534a450fd44189080d51bebefa3b42c6fc]

CVE-2023-54271: blk-cgroup: Fix NULL deref caused by blkg_policy_data
being installed before init

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54271

Introduced by commit 9d179b8 ("blkcg: Fix multiple bugs in
blkcg_activate_policy()") in v5.4-rc4.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec14a87ee1999b19d8b7ed0fa95fea80644624ae]

CVE-2023-54272: fs/ntfs3: Fix a possible null-pointer dereference in ni_clear()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54272

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected code was added by 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.

Fixed status
mainline: [ec275bf9693d19cc0fdce8436f4c425ced86f6e7]
stable/5.15: [20f9bfc664d6a478f9a5bbc0c380f80f7a1a06c6]
stable/6.1: [39c6312009574ca73865354133ca222e7753a71b]

CVE-2023-54273: xfrm: Fix leak of dev tracker

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54273

Introduced by commit 919e43f ("xfrm: add an interface to offload
policy") in v6.2-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec8f32ad9a65a8cbb465b69e154aaec9d2fe45c4]

CVE-2023-54274: RDMA/srpt: Add a check for valid 'mad_agent' pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54274

Introduced by commit a42d985 ("ib_srpt: Initial SRP Target merge for
v3.3-rc1") in v3.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eca5cd9474cd26d62f9756f536e2e656d3f62f3a]
stable/5.10: [8ec6acdb9b6a80eeb13e778dfedb5d72a88f14fe]
stable/5.15: [00cc21e32ea1b8ebbabf5d645da9378d986bf8ba]
stable/6.1: [4323aaedeba32076e652aad056afd7885bb96bb7]

CVE-2023-54275: wifi: ath11k: Fix memory leak in ath11k_peer_rx_frag_setup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54275

Introduced by commit 243874c ("ath11k: handle RX fragments") in v5.7-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed3f83b3459a67a3ab9d806490ac304b567b1c2d]
stable/5.10: [137963e3b95776f1d57c62f249a93fe47e019a22]
stable/5.15: [53c8a256e5d3f31d80186de03a3d2a7f747b2aa0]
stable/6.1: [e596b36e15a7158b0bb2d55077b6b381ee41020c]

CVE-2023-54276: nfsd: move init of percpu reply_cache_stats counters
back to nfsd_init_net

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54276

Introduced by commit f5f9d4a ("nfsd: move reply cache initialization
into nfsd startup") in v6.3-rc1.
Fixed in v6.5-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [ed9ab7346e908496816cffdecd46932035f66e2e]
stable/5.10: [3025d489f9c8984d1bf5916c4a20097ed80fca5c]
stable/5.15: [8549384d0f65981761fe2077d04fa2a8d37b54e0]
stable/6.1: [66a178177b2b3bb1d71e854c5e7bbb320eb0e566]

CVE-2023-54277: fbdev: udlfb: Fix endpoint check

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54277

Introduced by commit aaf7dbe ("video: fbdev: udlfb: properly check
endpoint type") in v5.18-rc5.
Fixed in v6.4-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [ed9de4ed39875706607fb08118a58344ae6c5f42]
stable/5.10: [58ecc165abdaed85447455e6dc396758e8c6f219]
stable/5.15: [9e12c58a5ece41be72157cef348576b135c9fc72]
stable/6.1: [c8fdf7feca77cd99e25ef0a1e9e72dfc83add8ef]

CVE-2023-54278: s390/vmem: split pages when debug pagealloc is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54278

Introduced by commit bb1520d ("s390/mm: start kernel with DAT
enabled") in v6.3-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edc1e4b6e26536868ef819a735e04a5b32c10589]

CVE-2023-54279: MIPS: fw: Allow firmware to pass a empty env

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54279

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [830181ddced5a05a711dc9da8043203b1f33a77e]
cip/4.4-st: [6d28e13c2df3cd51c16289cd54da039e518771f2]
mainline: [ee1809ed7bc456a72dc8410b475b73021a3a68d5]
stable/5.10: [47e61cadc7a5f3dffd42d2d6fda81be163f1ab82]
stable/5.15: [3ef93b7bd9e042db240843f24a80e14da38c6830]
stable/6.1: [a6b54af407873227caef6262e992f5422cdcb6ae]

CVE-2023-54280: cifs: fix potential race when tree connecting ipc

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54280

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [ee20d7c6100752eaf2409d783f4f1449c29ea33d]

CVE-2023-54281: btrfs: release path before inode lookup during the ino
lookup ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54281

Introduced by commit 23d0b79 ("btrfs: Add unprivileged version of
ino_lookup ioctl") in v4.18-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee34a82e890a7babb5585daf1a6dd7d4d1cf142a]
stable/5.10: [7390bb377b5fb3be23cb021e0f184d1f576be7d6]
stable/5.15: [380bbd46d61c894a8dcaace09e54bc7426d81014]
stable/6.1: [50e385d98b2a52480836ea41c142b81eeeb277af]

CVE-2023-54282: media: tuners: qt1010: replace BUG_ON with a regular error

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54282

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [f844bc3a47d8d1c55a4a9cfca38c538e9df7e678]
cip/4.4-st: [b8c2fd6ae6057d3185342598c155e7cd67636ba2]
mainline: [ee630b29ea44d1851bb6c903f400956604834463]
stable/5.10: [2ae53dd15eef90d34fc084b5b2305a67bb675a26]
stable/5.15: [48bb6a9fa5cb150ac2a22b3c779c96bc0ed21071]
stable/6.1: [257092cb544c7843376b3e161f789e666ef06c98]

CVE-2023-54283: bpf: Address KCSAN report on bpf_lru_list

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54283

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [a89d14410ea0352420f03cddc67e0002dcc8f9a5]
mainline: [ee9fd0ac3017c4313be91a220a9ac4c99dde7ad4]
stable/5.10: [b6d9a4062c944ad095b34dc112bf646a84156f60]
stable/5.15: [819ca25444b377935faa2dbb0aa3547519b5c80f]
stable/6.1: [c006fe361cfd947f51a56793deddf891e5cbfef8]

CVE-2023-54284: media: av7110: prevent underflow in write_ts_to_decoder()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54284

Introduced by commit fd46d16 ("V4L/DVB (11759): dvb-ttpci: Add TS
replay capability") in v2.6.31-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6606e2404ee9e20a3ae5b42fc3660d41b739ed3e]
cip/4.4-st: [6993318d7316fcb072ffa391cdc18a64e3e34281]
mainline: [eed9496a0501357aa326ddd6b71408189ed872eb]
stable/5.10: [86ba65e5357bfbb6c082f68b265a292ee1bdde1d]
stable/5.15: [ca4ce92e3ec9fd3c7c936b912b95c53331d5159c]
stable/6.1: [423350af9e27f005611bd881b1df2cab66de943d]

CVE-2023-54285: iomap: Fix possible overflow condition in
iomap_write_delalloc_scan

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54285

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected code was added by f43dc4d ("iomap: buffered write failure
should not truncate the page cache") in v6.2-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [eee2d2e6ea5550118170dbd5bb1316ceb38455fb]

CVE-2023-54286: wifi: iwlwifi: dvm: Fix memcpy: detected
field-spanning write backtrace

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54286

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [3ed3c1c2fc3482b72e755820261779cd2e2c5a3e]
cip/4.4-st: [f5d266b6e53e87f70baf74f60406cc3ca6cd2059]
mainline: [ef16799640865f937719f0771c93be5dca18adc6]
stable/5.10: [91ad1ab3cc7e981cb6d6ee100686baed64e1277e]
stable/5.15: [87940e4030e4705e1f3fd2bbb1854eae8308314b]
stable/6.1: [57189c885149825be8eb8c3524b5af017fdeb941]

CVE-2023-54287: tty: serial: imx: disable Ageing Timer interrupt request irq

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54287

Introduced by commit 8a61f0c ("serial: imx: Disable irqs before
requesting them") in v4.3-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef25e16ea9674b713a68c3bda821556ce9901254]
stable/5.15: [3d41d9b256ae626c0dc434427c8e32450358d3b4]
stable/6.1: [9795ece3a85ba9238191e97665586e2d79703ff3]

CVE-2023-54288: wifi: mac80211: fortify the spinlock against deadlock
by interrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54288

Introduced by commit 4444bc2 ("wifi: mac80211: Proper mark iTXQs for
resumption") in v6.2-rc5.
Fixed in v6.4-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [ef6e1997da63ad0ac3fe33153fec9524c9ae56c9]
stable/6.1: [c79d794a2cd76eca47b2491c5030be9a6418c5d6]

CVE-2023-54289: scsi: qedf: Fix NULL dereference in error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54289

Introduced by commit 61d8658 ("scsi: qedf: Add QLogic FastLinQ offload
FCoE driver framework.") in v4.11-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f025312b089474a54e4859f3453771314d9e3d4f]
stable/5.10: [ac64019e4d4b08c23edb117e0b2590985e33de1d]
stable/5.15: [b1de5105d29b145b727b797e2d5de071ab3a7ca1]
stable/6.1: [c316bde418af4c2a9df51149ed01d1bd8ca5bebf]

CVE-2023-54291: vduse: fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54291

Introduced by commit 28f6288 ("vduse: Support set_vq_affinity
callback") in v6.4-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f06cf1e1a503169280467d12d2ec89bf2c30ace7]

CVE-2023-54292: RDMA/irdma: Fix data race on CQP request done

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54292

Introduced by commit 915cc7a ("RDMA/irdma: Add miscellaneous utility
definitions") in v5.14-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0842bb3d38863777e3454da5653d80b5fde6321]
stable/5.15: [c5b5dbcbf91f769b8eb25f88e32a1522f920f37a]
stable/6.1: [5986e96be7d0b82e50a9c6b019ea3f1926fd8764]

CVE-2023-54293: bcache: fixup btree_cache_wait list damage

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54293

Introduced by commit 8e71022 ("bcache: make bch_btree_check() to be
multithreaded") in v5.7-rc1.
Introduced by commit b144e45 ("bcache: make bch_sectors_dirty_init()
to be multithreaded") in v5.7-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0854489fc07d2456f7cc71a63f4faf9c716ffbe]
stable/5.10: [bcb295778afda4f2feb0d3c0289a53fd43d5a3a6]
stable/5.15: [cbdd5b3322f7bbe6454c97cac994757f1192c07b]
stable/6.1: [25ec4779d0fb3ed9cac1e4d9e0e4261b4a12f6ed]

CVE-2023-54294: md/raid10: fix memleak of md thread

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54294

Introduced by commit 43a5212 ("md-cluster: choose correct label when
clustered layout is not supported") in v4.16-rc4.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [abf4d67060c8f63caff096e5fca1564bfef1e5d4]
mainline: [f0ddb83da3cbbf8a1f9087a642c448ff52ee9abd]
stable/5.10: [2a65555f7e0f4a05b663879908a991e6d9f81e51]
stable/5.15: [d6cfcf98b824591cffa4c1e9889fb4fa619359fe]
stable/6.1: [36ba0c7b86acd9c2ea80a273204d52c21c955471]

CVE-2023-54295: mtd: spi-nor: Fix shift-out-of-bounds in spi_nor_set_erase_type

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54295

Introduced by commit 5390a8d ("mtd: spi-nor: add support to
non-uniform SFDP SPI NOR flash memories") in v4.20-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0f0cfdc3a024e21161714f2e05f0df3b84d42ad]
stable/5.10: [e6409208c13f7c56adc12dd795abf4141e3d5e64]
stable/5.15: [61d44a4db2f54dbac7d22c2541574ea5755e0468]
stable/6.1: [53b2916ebde741c657a857fa1936c0d9fcb59170]

CVE-2023-54296: KVM: SVM: Get source vCPUs from source VM for SEV-ES
intrahost migration

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54296

Introduced by commit 6defa24 ("KVM: SEV: Init target VMCBs in
sev_migrate_from") in v5.19-rc4.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1187ef24eb8f36e8ad8106d22615ceddeea6097]
stable/6.1: [5c18ace750e4d4d58d7da02d1c669bf21c824158]

CVE-2023-54297: btrfs: zoned: fix memory leak after finding block
group with super blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54297

Introduced by commit 1265925 ("btrfs: implement log-structured
superblock for ZONED mode") in v5.11-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1a07c2b4e2c473ec322b8b9ece071b8c88a3512]
stable/5.15: [ab80a901f8daca07c4a54af0ab0de745c9918294]
stable/6.1: [c35ea606196243063e63785918c7c8fe27c45798]

CVE-2023-54298: thermal: intel: quark_dts: fix error pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54298

Introduced by commit 8c18769 ("thermal: intel Quark SoC X1000 DTS
thermal driver") in v4.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d0178f2788fb1183a5cc350213efdc94010b9147]
cip/4.4-st: [773a2197caeb84455f6e5a9dc2133e5803541bdc]
mainline: [f1b930e740811d416de4d2074da48b6633a672c8]
stable/5.10: [f73134231fa23e0856c15010db5f5c03693c1e92]
stable/5.15: [5eaf55b38691291d49417c22e726591078ca1893]
stable/6.1: [69e49f1b53605706bc2203455021539aba2ebe21]

CVE-2023-54299: usb: typec: bus: verify partner exists in
typec_altmode_attention

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54299

Introduced by commit 8a37d87 ("usb: typec: Bus type for alternate
modes") in v4.19-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f23643306430f86e2f413ee2b986e0773e79da31]
stable/5.10: [38e1f2ee82bacbbfded8f1c06794a443d038d054]
stable/5.15: [0ad6bad31da692f8d7acacab07eabe7586239ae0]
stable/6.1: [0d3b5fe47938e9c451466845304a2bd74e967a80]

CVE-2023-54300: wifi: ath9k: avoid referencing uninit memory in
ath9k_wmi_ctrl_rx

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54300

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [28259ce4f1f1f9ab37fa817756c89098213d2fc0]
cip/4.4-st: [458c833deea9a2aa8c5b14c7d3ba7396a5dbfbe9]
mainline: [f24292e827088bba8de7158501ac25a59b064953]
stable/5.10: [250efb4d3f5b32a115ea6bf25437ba44a1b3c04f]
stable/5.15: [ad5425e70789c29b93acafb5bb4629e4eb908296]
stable/6.1: [d1c2ff2bd84c3692c9df267a2b991ce92bfca8ef]

CVE-2023-54301: serial: 8250_bcm7271: fix leak in `brcmuart_probe`

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54301

Introduced by commit 41a4694 ("serial: 8250: Add new 8250-core based
Broadcom STB driver") in v5.13-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f264f2f6f4788dc031cef60a0cf2881902736709]
stable/5.15: [5258395e67fee6929fb8e50c8239f8de51b8cb2d]
stable/6.1: [2a3e5f428fc4315be6144524912eaefac16f43a9]

CVE-2023-54302: RDMA/irdma: Fix data race on CQP completion stats

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54302

Introduced by commit 915cc7a ("RDMA/irdma: Add miscellaneous utility
definitions") in v5.14-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2c3037811381f9149243828c7eb9a1631df9f9c]
stable/5.15: [bf0f9f65b7fe36ea9d2e23263dcefc90255d7b1f]
stable/6.1: [4e1a5842a359ee18d5a9e75097d7cf4d93e233bb]

CVE-2023-54303: bpf: Disable preemption in bpf_perf_event_output

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54303

Introduced by commit 8c7dcb8 ("bpf: implement sleepable uprobes by
chaining gps") in v6.0-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2c67a3e60d1071b65848efaa8c3b66c363dd025]
stable/6.1: [3654ed5daf492463c3faa434c7000d45c2da2ace]

CVE-2023-54304: firmware: meson_sm: fix to avoid potential NULL
pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54304

Introduced by commit 8cde3c2 ("firmware: meson_sm: Rework driver as a
proper platform driver") in v5.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2ed165619c16577c02b703a114a1f6b52026df4]
stable/5.10: [9f4017cac70c04090dd4f672e755d6c875af67d8]
stable/5.15: [502dfc5875bab9ae5d6a2939146c2c5e5683be40]
stable/6.1: [bd3a6b6d5dd863dbbe17985c7612159cf4533cad]

CVE-2023-54305: ext4: refuse to create ea block when umounted

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54305

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [21f6a80d9234422e2eb445734b22c78fc5bf6719]
mainline: [f31173c19901a96bb2ebf6bcfec8a08df7095c91]
stable/5.10: [0dc0fa313bb4e86382a3e7125429710d44383196]
stable/5.15: [116008ada3d0de4991099edaf6b8c2e9cd6f225a]
stable/6.1: [05cbf6ddd9847c7b4f0662c048f195b09405a9d0]

CVE-2023-54306: net: tls: avoid hanging tasks on the tx_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54306

Introduced by commit 79ffe60 ("net/tls: add a TX lock") in v5.4-rc7.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3221361dc85d4de22586ce8441ec2c67b454f5d]
stable/5.10: [7123a4337bf73132bbfb5437e4dc83ba864a9a1e]
stable/5.15: [be5d5d0637fd88c18ee76024bdb22649a1de00d6]
stable/6.1: [1f800f6aae57d2d8f63d32fff383017cbc11cf65]

CVE-2023-54307: ptp_qoriq: fix memory leak in probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54307

Introduced by commit 7f4399b ("ptp_qoriq: fix NULL access if ptp dt
node missing") in v5.2-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f33642224e38d7e0d59336e10e7b4e370b1c4506]
stable/5.10: [3907fcb5a439933cf8c10d6dc300bc11eba30de3]
stable/5.15: [c0de1a26e6595b0e7969c5b35990a77a2d93104f]
stable/6.1: [43b4331ce0cd88ccba425e0702ba35c1a52daccf]

CVE-2023-54308: ALSA: ymfpci: Create card with device-managed
snd_devm_card_new()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54308

Introduced by commit c6e6bb5 ("ALSA: ymfpci: Allocate resources with
device-managed APIs") in v5.15-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f33fc1576757741479452255132d6e3aaf558ffe]
stable/5.15: [95642872c466030240199ba796a40771c493ed0c]
stable/6.1: [db7d7782677ff998c06997903d5400a0ba91cebb]

CVE-2023-54309: tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54309

Introduced by commit 6f99612 ("tpm: Proxy driver for supporting
multiple emulated TPMs") in v4.8-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [04e8697d26613ccea760cf57eb20a5a27f788c0f]
mainline: [f4032d615f90970d6c3ac1d9c0bce3351eb4445c]
stable/5.10: [9ff7fcb3a2ed0e9b895bb5b4c13872d584a8815b]
stable/5.15: [e08295290c53a3cf174c236721747a01b9550ae2]
stable/6.1: [99b998fb9d7d2d2d9dbb3e19db2d0ade02f5a604]

CVE-2023-54310: scsi: message: mptlan: Fix use after free bug in
mptlan_remove() due to race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54310

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [60c8645ad6f5b722615383d595d63b62b07a13c3]
cip/4.4-st: [4f4e2bfa38f4f40998ea09159c09a626b134dd92]
mainline: [f486893288f3e9b171b836f43853a6426515d800]
stable/5.10: [697f92f8317e538d8409a0c95d6370eb40b34c05]
stable/5.15: [e84282efc87f2414839f6e15c31b4daa34ebaac1]
stable/6.1: [9c6da3b7f12528cd52c458b33496a098b838fcfc]

CVE-2023-54311: ext4: fix deadlock when converting an inline directory
in nojournal mode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54311

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
mainline: [f4ce24f54d9cca4f09a395f3eecce20d6bec4663]
stable/5.10: [5f8b55136ad787aed2c184f7cb3e93772ae637a3]
stable/5.15: [640c8c365999c6f23447ac766437236ad88317c5]
stable/6.1: [665cc3ba50330049524c1d275bc840a8f28dde73]

CVE-2023-54312: samples/bpf: Fix buffer overflow in tcp_basertt

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54312

Introduced by commit c890063 ("bpf: sample BPF_SOCKET_OPS_BASE_RTT
program") in v4.15-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cf7514fedc25675e68b74941df28a883951e70fd]
mainline: [f4dea9689c5fea3d07170c2cb0703e216f1a0922]
stable/5.10: [bd3e880dce27d225598730d2bbb3dc05b443af22]
stable/5.15: [e92f61e0701ea780e57e1be8dbd1fbec5f42c09e]
stable/6.1: [56c25f2763a16db4fa1b486e6a21dc246cd992bd]

CVE-2023-54313: ovl: fix null pointer dereference in ovl_get_acl_rcu()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54313

Introduced by commit 332f606 ("ovl: enable RCU'd ->get_acl()") in v5.15-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4e19e595cc2e76a8a58413eb19d3d9c51328b53]
stable/5.15: [d97481c7b2739a704848bb3c01f224dc71bdf78e]
stable/6.1: [c4a5fb1ae5d3f02d3227afde2b9339994389463d]

CVE-2023-54314: media: af9005: Fix null-ptr-deref in af9005_i2c_xfer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54314

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [63d962ac7a52c0ff4cd09af2e284dce5e5955dfe]
cip/4.4-st: [414bf683269343ff857d2e394d42c065274407d5]
mainline: [f4ee84f27625ce1fdf41e8483fa0561a1b837d10]
stable/5.10: [c7e5ac737db25d7387fe517cb5207706782b6cf8]
stable/5.15: [033b0c0780adee32dde218179e9bc51d2525108f]
stable/6.1: [abb6fd93e05e80668d2317fe1110bc99b05034c3]

CVE-2023-54315: powerpc/powernv/sriov: perform null check on iov
before dereferencing iov

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54315

Introduced by commit 052da31 ("powerpc/powernv/sriov: De-indent setup
and teardown") in v5.9-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4f913c980bc6abe0ccfe88fe3909c125afe4a2d]
stable/5.10: [07c19c0ad4b07f4b598da369714de028f6a6a323]
stable/5.15: [d3a0d96c16e5f8d55e2c70163abda3c7c8328106]
stable/6.1: [d9a1aaea856002cb58dfb7c8d8770400fa1a0299]

CVE-2023-54316: refscale: Fix uninitalized use of wait_queue_head_t

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54316

Introduced by commit 653ed64 ("refperf: Add a test to measure
performance of read-side synchronization") in v5.9-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5063e8948dad7f31adb007284a5d5038ae31bb8]
stable/5.10: [066fbd8bc981cf49923bf828b7b4092894df577f]
stable/5.15: [ec9d118ad99dc6f1bc674c1e649c25533d89b9ba]
stable/6.1: [e0322a255a2242dbe4686b6176b3c83dea490529]

CVE-2023-54317: dm flakey: don't corrupt the zero page

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54317

Introduced by commit a00f527 ("dm flakey: Properly corrupt multi-page
bios.") in v5.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [98e311be44dbe31ad9c42aa067b2359bac451fda]
mainline: [f50714b57aecb6b3dc81d578e295f86d9c73f078]
stable/5.10: [f2b478228bfdd11e358c5bc197561331f5d5c394]
stable/5.15: [ff60b2bb680ebcaf8890814dd51084a022891469]
stable/6.1: [be360c83f2d810493c04f999d69ec9152981e0c0]

CVE-2023-54318: net/smc: use smc_lgr_list.lock to protect
smc_lgr_list.list iterate in smcr_port_add

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54318

Introduced by commit 1f90a05 ("net/smc: add smcr_port_add() and
smcr_link_up() processing") in v5.8-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5146e3ef0a9eea405874b36178c19a4863b8989]
stable/5.10: [d1c6c93c27a4bf48006ab16cd9b38d85559d7645]
stable/5.15: [06b4934ab2b534bb92935c7601852066ebb9eab8]
stable/6.1: [70c8d17007dc4a07156b7da44509527990e569b3]

CVE-2023-54319: pinctrl: at91-pio4: check return value of devm_kasprintf()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54319

Introduced by commit 7761808 ("pinctrl: introduce driver for Atmel
PIO4 controller") in v4.4-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3e8ce1d5a1a9d758b359e5c426543957f35991f8]
cip/4.4-st: [b4f153588140611cf75c42fae4c0be089e09551b]
mainline: [f6fd5d4ff8ca0b24cee1af4130bcb1fa96b61aa0]
stable/5.10: [f3c7b95c9991dab02e616fc251b6c3516e0bd0ac]
stable/5.15: [0a95dd17a73b7603818ad7c46c99d757232be331]
stable/6.1: [0af388fce352ed2ab383fd5d1a08db551ca15c38]

CVE-2023-54320: platform/x86/amd: pmc: Fix memory leak in
amd_pmc_stb_debugfs_open_v2()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54320

Introduced commit is not determined.Fixed in v6.4-rc1.
Vulnerable code was added by 1ecfd30 ("platform/x86/amd: pmc: Add
num_samples message id support to STB") in v6.3-rc1.

Fixed status
mainline: [f6e7ac4c35a28aef0be93b32c533ae678ad0b9e7]

CVE-2023-54321: driver core: fix potential null-ptr-deref in device_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54321

Introduced by commit 57eee3d ("Driver core: Call device_pm_add() after
bus_add_device() in device_add()") in v2.6.26-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6837f34a34973ef6600c08195ed300e24e97317]
stable/5.15: [2c59650d078b1b3f1ea50d5f8ee9fcc537dc02d3]
stable/6.1: [7cf515bf9e8c2908dc170ecf2df117162a16c9c5]

CVE-2023-54322: arm64: set __exception_irq_entry with __irq_entry as a default

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54322

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected code was added by 9a5ad7d ("arm64: Add __exception_irq_entry
definition for function graph") in v4.3-rc1.

Fixed status
mainline: [f6794950f0e5ba37e3bbedda4d6ab0aad7395dd3]
stable/5.10: [c71d6934c6ac40a97146a410e0320768c7b1bb3c]
stable/5.15: [0bd309f22663f3ee749bea0b6d70642c31a1c0a5]

CVE-2023-54323: cxl/pmem: Fix nvdimm registration races

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54323

Introduced by commit 21083f5 ("cxl/pmem: Register 'pmem' / cxl_nvdimm
devices") in v5.14-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f57aec443c24d2e8e1f3b5b4856aea12ddda4254]
stable/6.1: [a371788d4f4a7f59eecd22644331d599979fd283]

CVE-2023-54324: dm: fix a race condition in retrieve_deps

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54324

Introduced commit is not determined.Fixed in v6.6-rc2.


Fixed status
mainline: [f6007dce0cd35d634d9be91ef3515a6385dcee16]
stable/6.1: [dbf1a719850577bb51fc7512a3972994b797a17b]

CVE-2023-54325: crypto: qat - fix out-of-bounds read

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54325

Introduced by commit 67916c9 ("crypto: qat - add AES-CTR support for
QAT GEN4 devices") in v5.11-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6044cc3030e139f60c281386f28bda6e3049d66]
stable/5.15: [7697139d5dfd491f4c495a914a1dd68f6e827a0f]
stable/6.1: [dc3809f390357c8992f0a23083da934a20fef9af]

CVE-2023-54326: misc: pci_endpoint_test: Free IRQs before removing the device

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54326

Introduced by commit e033271 ("pci_endpoint_test: Add 2 ioctl
commands") in v4.19-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fb7f8bdb886f2ebf35ee5edaf2bf5f02b063ddb7]
mainline: [f61b7634a3249d12b9daa36ffbdb9965b6f24c6c]
stable/5.10: [cdf9a7e2cdc7a5464e3cc6d0b715ba2b1d215521]
stable/5.15: [14bdee38e96c7d37ca15e7bea50411eee25fe315]
stable/6.1: [c2dba13bc0c62b79a3cbe4bfe5faa32231bf9b55]


* Updated CVEs

No update

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

