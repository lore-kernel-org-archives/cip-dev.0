Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05786D68BC2
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 22:27:30 +0000 (UTC)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27240.1766010439152961940
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 14:27:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=rXQS3Y99;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64467071f9fso5080304d50.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 14:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1766010438; x=1766615238; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RL7FjGmuNCn8FCuXLfmt3spfeW46qBG6tkDnSBQy4fc=;
        b=rXQS3Y99tRCHyJqf5Ug+IauBijXyySyoAqKLnGAcLC7Nq2JaGhmolKvX939n8Z5ZlD
         /mK7KEX6zdcNwTQFcsnEnNeKpDkWSDRojLU0sl6IUUKqAUn82kdCx0slQsvRtGu/0xDV
         jLVm3knQ3ljAW/BhhughRG6qhFo80hDBDrH+mfcxDICbi4aGcCKhYeTMenXo2yAa38vk
         oGoABFwTINCe0ZCy3kcaqbJqsIKgkl0nEjdbImYAc1nNqyTujITLOACZSu7kLA8AsSH8
         TJ+rYVSdP/t3cTVryv3r40ZWmPYEnSfkPj4TBjzD+KRolnWTzCRy/FYn7eJ/0GDI4NPR
         M/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010438; x=1766615238;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL7FjGmuNCn8FCuXLfmt3spfeW46qBG6tkDnSBQy4fc=;
        b=gVdQdIe3V1H31Pw9bQerPeU44+o90TbLn6T26mgpnjzMhjooArtDJ/Qyx+HVu7RDUd
         y5Vb2LS1DfNJeWQzpTg+CGE9JmMqUI5810oNoUovPoYwugyXS4tBZ4aALsVdsIO/1Smx
         8qx0SjKhFaJHtF6GEq3ObAohetQssJsAJ/+pp/BYnmNy0ZkrOEijhYIjdSLLttvSXrxE
         ErLZxgH17srEFjRbYdOgy/LzXxh0bh/xv0CpxEV3tiyQSyM+TMYNj+1D9/NR/UFqZijh
         cHHeArEpweEijLTvkJSKgYQQVmMkf/2j641De965TuCj7CZw3sYuFIW6o+pF7/HS/M03
         zsFQ==
X-Gm-Message-State: AOJu0YxC/i1545xdJgXvf1YexvdyBjLzLkNuyL/uiOIPX0yTv3KJpDJa
	EqicWcp6qrip6Q3rTavu0hh7vbyYfNcobeuANZv9j2aZowu75AwbC+37OXWRtCcKz2PiTJQ/oin
	eymIOyZ5zxCFl1ZmV2SKf7zo+K1CaNCqQhNEmLNhd3Sth+1trx5eutKQ=
X-Gm-Gg: AY/fxX69Fbxj/fWwT31xKV/C7dfr+YPmQCz35wmVCnK2JYiWkCV/FrtYpnd+N85H+rM
	egBKLbmoqzIphKpDpFDbyzHOzXCueBBDY5J3d9q271/0enkFtVAheypkpleL6uDOfwr+t1RvkqH
	8Jz1+yFtcMhqi7ZNWFg01Wv0xBjF8E8ZrwNANidPpcwua+9Ft7F/LjPtlp2bcdA0NYxwkCxvV4V
	Ww/pP8IwrYz6UOlpHvPXodGRXwcotsxVcnCkGB1zGZudFJIFD50p6N0lvkZ5iWXaUpMaWbN
X-Google-Smtp-Source: AGHT+IHtqmZckXGA4ShiRjVg42v8AuYjfqkdX8xrqdzLejdYbYKSgI0CXi/kley4hoASYL2eYR5zZHaKi1/cz3YAS4g=
X-Received: by 2002:a53:e6cd:0:b0:644:2e1b:c8bb with SMTP id
 956f58d0204a3-64555650e2dmr13610362d50.59.1766010436708; Wed, 17 Dec 2025
 14:27:16 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Dec 2025 07:26:40 +0900
X-Gm-Features: AQt7F2rEnHJDt9v8pqyASYkf8xq9rOdw6GLjnD7atPjMEFg-7h4X1yid3z2KLSM
Message-ID: <CAODzB9oG+DtSnmO9XQUc8HOJ-Y9KOvj5sWUo3d1RmGx323rTZg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 22:27:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21121

Hi!

It's this week's CVE report.

This week reported 161 new CVEs and 2 updated CVEs.

* New CVEs
CVE-2025-40345: usb: storage: sddr55: Reject out-of-bound new_pba

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40345

Introduced commit is not determined.Fixed in v6.18.


Fixed status
mainline: [b59d4fda7e7d0aff1043a7f742487cb829f5aac1]
stable/5.10: [d00a6c04a502cd52425dbf35588732c652b16490]
stable/5.15: [26e9b5da3231da7dc357b363883b5b7b51a64092]
stable/6.1: [aa64e0e17e3a5991a25e6a46007770c629039869]
stable/6.12: [a20f1dd19d21dcb70140ea5a71b1f8cbe0c7e68f]
stable/6.6: [04a8a6393f3f2f471e05eacca33282dd30b01432]

CVE-2025-40346: arch_topology: Fix incorrect error check in
topology_parse_cpu_capacity()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40346

Introduced by commit b8fe128 ("arch_topology: Adjust initial CPU
capacities with current freq") in v5.7-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2eead19334516c8e9927c11b448fbe512b1f18a1]
stable/5.10: [64da320252e43456cc9ec3055ff567f168467b37]
stable/5.15: [02fbea0864fd4a863671f5d418129258d7159f68]
stable/6.1: [a77f8434954cb1e9c42c3854e40855fdcf5ab235]
stable/6.12: [45379303124487db3a81219af7565d41f498167f]
stable/6.6: [3373f263bb647fcc3b5237cfaef757633b9ee25e]

CVE-2025-40347: net: enetc: fix the deadlock of enetc_mdio_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40347

Introduced by commit 6d36ecd ("net: enetc: take the MDIO lock only
once per NAPI poll cycle") in v5.12-rc3.
Fixed in v6.18-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [50bd33f6b3922a6b760aa30d409cae891cec8fb5]
stable/6.12: [1f92f5bd057a4fad9dab6af17963cdd21e5da6ed]
stable/6.6: [2781ca82ce8cad263d80b617addb727e6a84c9e5]

CVE-2025-40348: slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40348

Introduced by commit f7381b9 ("slab: mark slab->obj_exts allocation
failures unconditionally") in v6.18-rc1.
Fixed in v6.18-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.17

Fixed status
mainline: [6ed8bfd24ce1cb31742b09a3eb557cd008533eec]
stable/6.12: [c7af5300d78460fc5037ddc77113ba3dbfe77dc0]

CVE-2025-40349: hfs: validate record offset in hfsplus_bmap_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40349

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
cip/4.19-st: [fcc1294756b1e0ec07b48482016f43cbcf22eddc]
mainline: [738d5a51864ed8d7a68600b8c0c63fe6fe5c4f20]
stable/5.10: [40dfe7a4215a1f20842561ffaf5a6f83a987e75b]
stable/5.15: [418e48cab99c52c1760636a4dbe464bf6db2018b]
stable/6.1: [0058d20d76182861dbdd8fd6e2dd8d18d6d3becf]
stable/6.12: [17ed51cfce6c62cffb97059ef392ad2e0245806e]
stable/6.6: [4f40a2b3969daf10dca4dea6f6dd0e813f79b227]

CVE-2025-40350: net/mlx5e: RX, Fix generating skb from non-linear
xdp_buff for striding RQ

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40350

Introduced by commit f52ac70 ("net/mlx5e: RX, Add XDP multi-buffer
support in Striding RQ") in v6.4-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87bcef158ac1faca1bd7e0104588e8e2956d10be]
stable/6.12: [cb9edd583e23979ee546981be963ad5f217e8b18]
stable/6.6: [8b051d7f530e8a5237da242fbeafef02fec6b813]

CVE-2025-40351: hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40351

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
cip/4.19-st: [7970910075f90d07b69ea4cbd443674d10ccd8fb]
mainline: [9b3d15a758910bb98ba8feb4109d99cc67450ee4]
stable/5.10: [b07630afe1671096dc64064190cae3b6165cf6e4]
stable/5.15: [9df3c241fbf69edce968b20eeeeb3f6da34af041]
stable/6.1: [1b9e5ade272f8be6421c9eea4c4f6810180017f9]
stable/6.12: [295527bfdefd5bf31ec8218e2891a65777141d05]
stable/6.6: [2bb8bc99b1a7a46d83f95c46f530305f6df84eaf]

CVE-2025-40352: platform/mellanox: mlxbf-pmc: add sysfs_attr_init() to
count_clock init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40352

Introduced by commit 5efc800 ("platform/mellanox: mlxbf-pmc: Add
support for monitoring cycle count") in v6.14-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7b4747d8e0e7871c3d4971cded1dcc9af6af9e9]

CVE-2025-40353: arm64: mte: Do not warn if the page is already tagged
in copy_highpage()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40353

Introduced commit is not determined.Fixed in v6.18-rc3.
According to the commit log, commit 0609139 ("mm: migrate: support
poisoned recover from migrate folio") cause the problem.

Fixed status
mainline: [b98c94eed4a975e0c80b7e90a649a46967376f58]
stable/6.12: [5ff5765a1fc526f07d3bbaedb061d970eb13bcf4]

CVE-2025-40354: drm/amd/display: increase max link count and fix
link->enc NULL pointer access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40354

Introduced commit is not determined.Fixed in v6.18-rc3.
hwss/dcn401 was added by 70839da ("drm/amd/display: Add new DCN401
sources") in 6.11-rc1.

Fixed status
mainline: [bec947cbe9a65783adb475a5fb47980d7b4f4796]
stable/6.12: [f28092be4e12b7df9e4f415d25bf0d767bc2d9ed]

CVE-2025-40355: sysfs: check visibility before changing group
attribute ownership

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40355

Introduced by commit 303a427 ("sysfs: add
sysfs_group{s}_change_owner()") in v5.7-rc1.
Introduced by commit 0c17270 ("net: sysfs: Implement is_visible for
phys_(port_id, port_name, switch_id)") in v6.17-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7fbb8218b4ad35fec0bd2256d2b9c8d60331f33]

CVE-2025-40356: spi: rockchip-sfc: Fix DMA-API usage

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40356

Introduced by commit b69386f ("spi: rockchip-sfc: Using normal memory
for dma") in v6.14-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee795e82e10197c070efd380dc9615c73dffad6c]

CVE-2025-40357: net/smc: fix general protection fault in __smc_diag_dump

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40357

Introduced by commit d25a92c ("net/smc: Introduce IPPROTO_SMC") in v6.11-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f584239a9ed25057496bf397c370cc5163dde419]
stable/6.12: [5b6fc95c4a161326567bdf12a333768565b638f2]

CVE-2025-40358: riscv: stacktrace: Disable KASAN checks for non-current tasks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40358

Introduced by commit 5d8544e ("RISC-V: Generic library routines and
assembly") in v4.15-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [060ea84a484e852b52b938f234bf9b5503a6c910]
stable/6.12: [27379fcc15a10d3e3780fe79ba3fc7ed1ccd78e2]
stable/6.6: [f34ba22989da61186f30a40b6a82e0b3337b96fc]

CVE-2025-40359: perf/x86/intel: Fix KASAN global-out-of-bounds warning

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40359

Introduced by commit 0902624 ("perf/x86/intel: Rename model-specific
pebs_latency_data functions") in v6.11-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ba6502ce167fc3d598c08c2cc3b4ed7ca5aa251]
stable/6.12: [1b61a1da3d8105ea1be548c94c2856697eb7ffd1]

CVE-2025-40360: drm/sysfb: Do not dereference NULL pointer in plane reset

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40360

Introduced by commit b715650 ("drm/gem: Export implementation of
shadow-plane helpers") in v5.15-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14e02ed3876f4ab0ed6d3f41972175f8b8df3d70]
stable/5.15: [6abeff03cb79a2c7f4554a8e8738acd35bb37152]
stable/6.1: [c4faf7f417eea8b8d5cc570a1015736f307aa2d5]
stable/6.12: [6bdef5648a60e49d4a3b02461ab7ae3776877e77]
stable/6.6: [b61ed8005bd3102510fab5015ac6a275c9c5ea16]

CVE-2025-40361: fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40361

Introduced commit is not determined.Fixed in v6.18-rc1.
Commit 71b565c ("ext4: drop ext4_kvmalloc()") changed from GFP_NOFS to
GFP_KERNEL.

Fixed status
mainline: [1534f72dc2a11ded38b0e0268fbcc0ca24e9fd4a]
stable/5.10: [5e6b27f4e68682aa3db9f83ca04adef89903159b]
stable/5.15: [bb7d0d13c6e1f061464d1c425b08348a4e0c235d]
stable/6.1: [add8458cac0b33a5e7a6b98457b38baea9600859]
stable/6.12: [238f7a7356c33a9797a6297c6fdfd87f113b2325]
stable/6.6: [199ab7b43c5ef7d384f6a08e786e107b3509acda]

CVE-2025-40362: ceph: fix multifs mds auth caps issue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40362

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [22c73d52a6d05c5a2053385c0d6cd9984732799d]
stable/6.12: [07640d34a781bb2e39020a39137073c03c4aa932]

CVE-2025-40363: net: ipv6: fix field-spanning memcpy warning in AH output

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40363

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [2327a3d6f65ce2fe2634546dde4a25ef52296fec]
stable/5.10: [9bf27de51bd6db5ff827780ec0eba55de230ba45]
stable/5.15: [0bf756ae1e69fec5e6332c37830488315d6d771b]
stable/6.1: [75b16b2755e12999ad850756ddfb88ad4bfc7186]
stable/6.12: [c14cf41094136691c92ef756872570645d61f4a1]
stable/6.6: [f28dde240160f3c48a50d641d210ed6a3b9596ed]

CVE-2025-68167: gpiolib: fix invalid pointer access in debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68167

Introduced by commit e348544 ("gpio: protect the list of GPIO devices
with SRCU") in v6.9-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f6115ad8864cf3f48598f26c74c7c8e5c391919]
stable/6.12: [70180a6031056096c93ed2f47c41803268bdd91c]

CVE-2025-68168: jfs: fix uninitialized waitqueue in transaction manager

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68168

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [300b072df72694ea330c4c673c035253e07827b8]
stable/5.10: [8cae9cf23e0bd424ac904e753639a587543ce03a]
stable/5.15: [a2aa97cde9857f881920635a2e3d3b11769619c5]
stable/6.1: [d2dd7ca05a11685c314e62802a55e8d67a90e974]
stable/6.12: [cbf2f527ae4ca7c7dabce42e85e8deb58588a37e]
stable/6.6: [2a9575a372182ca075070b3cd77490dcf0c951e7]

CVE-2025-68169: netpoll: Fix deadlock in memory allocation under spinlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68169

Introduced by commit 248f657 ("netpoll: Optimize skb refilling on
critical path") in v6.15-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [327c20c21d80e0d87834b392d83ae73c955ad8ff]

CVE-2025-68170: drm/radeon: Do not kfree() devres managed rdev

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68170

Introduced by commit a9ed2f0 ("drm/radeon: change drm_dev_alloc to
devm_drm_dev_alloc") in v6.12-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3328443363a0895fd9c096edfe8ecd372ca9145e]
stable/6.12: [f7482516002a11317912e29577bbf33cf59a0fb1]

CVE-2025-68171: x86/fpu: Ensure XFD state on signal delivery

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68171

Introduced by commit 6723654 ("x86/fpu: Update XFD state where
required") in v5.16-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [388eff894d6bc5f921e9bfff0e4b0ab2684a96e9]
stable/6.1: [eefbfb722042fc9210d2e0ac2b063fd1abf51895]
stable/6.12: [5b2619b488f1d08b960c43c6468dd0759e8b3035]
stable/6.6: [1811c610653c0cd21cc9add14595b7cffaeca511]

CVE-2025-68172: crypto: aspeed - fix double free caused by devm

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68172

Introduced by commit 2f1cf4e ("crypto: aspeed - Add ACRY RSA driver")
in v6.3-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c9bf72cc1ced1297b235f9422d62b613a3fdae9]
stable/6.12: [29d0504077044a7e1ffbd09a6118018d5954a6e5]
stable/6.6: [0dd6474ced33489076e6c0f3fe5077bf12e85b28]

CVE-2025-68173: ftrace: Fix softlockup in ftrace_module_enable

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68173

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [4099b98203d6b33d990586542fa5beee408032a3]
stable/6.1: [a1dd0abd741a8111260676da729825d6c1461a71]
stable/6.12: [40c8ee40e48a2c82c762539952ed8fc0571db5bf]
stable/6.6: [e81e6d6d99b16dae11adbeda5c996317942a940c]

CVE-2025-68174: amd/amdkfd: enhance kfd process check in switch partition

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68174

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [45da20e00d5da842e17dfc633072b127504f0d0e]

CVE-2025-68175: media: nxp: imx8-isi: Fix streaming cleanup on release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68175

Introduced commit is not determined.Fixed in v6.18-rc1.
imx-isi was added by cf21f32 ("media: nxp: Add i.MX8 ISI driver") in 6.4-rc1.

Fixed status
mainline: [47773031a148ad7973b809cc7723cba77eda2b42]

CVE-2025-68176: PCI: cadence: Check for the existence of
cdns_pcie::ops before using it

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68176

Introduced commit is not determined.Fixed in v6.18-rc1.
pcie-cadence-host.c and pcie-cadence.h were added by 1b79c52 ("PCI:
cadence: Add host driver for Cadence PCIe controller") in 4.16-rc1.
pcie-cadence.c was added by 37dddf1 ("PCI: cadence: Add EndPoint
Controller driver for Cadence PCIe controller") in 4.16-rc1.

Fixed status
mainline: [49a6c160ad4812476f8ae1a8f4ed6d15adfa6c09]
stable/5.10: [d5dbe92ac8a4ca6226093241f95f9cb1b0d2e0e1]
stable/5.15: [eb3d29ca0820fa3d7cccad47d2da56c9ab5469ed]
stable/6.1: [0d0bb756f002810d249caee51f3f1c309f3cdab5]
stable/6.12: [953eb3796ef06b8ea3bf6bdde14156255bc75866]
stable/6.6: [1810b2fd7375de88a74976dcd402b29088e479ed]

CVE-2025-68177: cpufreq/longhaul: handle NULL policy in longhaul_exit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68177

Introduced commit is not determined.Fixed in v6.18-rc1.
It seems as if 4.x kernels are affected too.

Fixed status
mainline: [592532a77b736b5153e0c2e4c74aa50af0a352ab]
stable/5.10: [956b56d17a89775e4957bbddefa45cd3c6c71000]
stable/5.15: [55cf586b9556863e3c2a45460aba71bcb2be5bcd]
stable/6.1: [fd93e1d71b3b14443092919be12b1abf08de35eb]
stable/6.12: [64adabb6d9d51b7e7c02fe733346a2c4dd738488]
stable/6.6: [8d6791c480f22d6e9a566eaa77336d3d37c5c591]

CVE-2025-68178: blk-cgroup: fix possible deadlock while configuring policy

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68178

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [5d726c4dbeeddef612e6bed27edd29733f4d13af]
stable/6.12: [56ac639d6fa6fbb99caee74ee1c7276fc9bb47ed]
stable/6.6: [e1729523759cda2c0afb76b1c88e0d2f2ef5b7cb]

CVE-2025-68179: s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68179

Introduced by commit 00a34d5 ("s390: select
ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP") in v6.2-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64e2f60f355e556337fcffe80b9bcff1b22c9c42]
stable/6.12: [5e23918e4352288323d13fb511116cdea0234b71]
stable/6.6: [7088465f10816d9425b95740b37c95f082041d76]

CVE-2025-68180: drm/amd/display: Fix NULL deref in debugfs odm_combine_segments

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68180

Introduced by commit 07926ba ("drm/amd/display: Add debugfs interface
for ODM combine info") in v6.7-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dd97ceb645c08aca9fc871a3006e47fe699f0ac]
stable/6.12: [d990c7f180aa7c6ffd2c1b3c77160e50672039ce]

CVE-2025-68181: drm/radeon: Remove calls to drm_put_dev()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68181

Introduced by commit a9ed2f0 ("drm/radeon: change drm_dev_alloc to
devm_drm_dev_alloc") in v6.12-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [745bae76acdd71709773c129a69deca01036250b]
stable/6.12: [2fa41445d8c98f2a65503c373796466496edc0e7]

CVE-2025-68182: wifi: iwlwifi: fix potential use after free in
iwl_mld_remove_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68182

Introduced by commit d1e879e ("wifi: iwlwifi: add iwlmld sub-driver")
in v6.15-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77e67d5daaf155f7d0f99f4e797c4842169ec19e]

CVE-2025-68183: ima: don't clear IMA_DIGSIG flag when setting or
removing non-IMA xattr

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68183

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [88b4cbcf6b041ae0f2fc8a34554a5b6a83a2b7cd]
stable/6.12: [edd824eb45e4f7e05ad3ab090dab6dbdb79cd292]
stable/6.6: [d2993a7e98eb70c737c6f5365a190e79c72b8407]

CVE-2025-68184: drm/mediatek: Disable AFBC support on Mediatek DRM driver

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68184

Introduced by commit c410fa9 ("drm/mediatek: Add AFBC support to
Mediatek DRM driver") in v6.2-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9882a40640036d5bbc590426a78981526d4f2345]
stable/6.12: [0eaa0a3dfe218c4cf1a0782ccbbc9e3931718f17]
stable/6.6: [df1ad5de2197ea1b527d13ae7b699e9ee7d724d4]

CVE-2025-68185: nfs4_setup_readdir(): insufficient locking for
->d_parent->d_inode dereferencing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68185

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [a890a2e339b929dbd843328f9a92a1625404fe63]
stable/5.10: [e6cafe71eb3b5579b245ba1bd528a181e77f3df1]
stable/5.15: [fa4daf7d11e45b72aad5d943a7ab991f869fff79]
stable/6.1: [504b3fb9948a9e96ebbabdee0d33966a8bab15cb]
stable/6.12: [40be5b9080114f18b0cea386db415b68a7273c1a]
stable/6.6: [eacfd08b26a062f1095b18719715bc82ad35312e]

CVE-2025-68186: ring-buffer: Do not warn in
ring_buffer_map_get_reader() when reader catches up

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68186

Introduced by commit 117c392 ("ring-buffer: Introducing ring-buffer
mapping functions") in v6.10-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa997d2d2a0b2e76f4df0f1f12829f02acb4fb6b]
stable/6.12: [b42dbef4f208326271434d5ab71c4129a3ddd1a9]

CVE-2025-68187: net: mdio: Check regmap pointer returned by
device_node_to_regmap()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68187

Introduced by commit 67e3ba9 ("net: mdio: Add MDIO bus controller for
Airoha AN7583") in v6.17-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2b526c2cf57d14ee269e012ed179081871f45a1]

CVE-2025-68188: tcp: use dst_dev_rcu() in
tcp_fastopen_active_disable_ofo_check()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68188

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected function was added by cf1ef3f ("net/tcp_fastopen: Disable
active side TFO in certain scenarios") in 4.12-rc1.

Fixed status
mainline: [b62a59c18b692f892dcb8109c1c2e653b2abc95c]
stable/6.12: [bc2b881a0896c111c1041d8bb1f92a3b3873ace5]

CVE-2025-68189: drm/msm: Fix GEM free for imported dma-bufs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68189

Introduced by commit de651b6 ("drm/msm: Fix refcnt underflow in error
path") in v6.17-rc4.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c34e08ba6c0037a72a7433741225b020c989e4ae]

CVE-2025-68190: drm/amdgpu/atom: Check kcalloc() for WS buffer in
amdgpu_atom_execute_table_locked()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68190

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [cc9a8e238e42c1f43b98c097995137d644b69245]
stable/6.12: [35f3fb86bb0158a298d6834e7e110dcaf07f490c]

CVE-2025-68191: udp_tunnel: use netdev_warn() instead of netdev_WARN()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68191

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected code was introduced by cc4e383 ("udp_tunnel: add central NIC
RX port offload infrastructure") in 5.9-rc1.

Fixed status
mainline: [dc2f650f7e6857bf384069c1a56b2937a1ee370d]
stable/5.10: [087f1ed450dc6e7e49ffbbbe5b78be1218c6d5e0]
stable/5.15: [45e4e4a8772fa1c5f6f38e82b732b3a9d8137af4]
stable/6.1: [7758ec35ff3e9a31558eda4f0f9eb0ddfa78a8ba]
stable/6.12: [51b3033088f0420b19027e3d54cd989b6ebd987e]
stable/6.6: [c018a87942bf1607aeebf8dba5a210ca9a09a0fd]

CVE-2025-68192: net: usb: qmi_wwan: initialize MAC header offset in
qmimux_rx_fixup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68192

Introduced by commit c6adf77 ("net: usb: qmi_wwan: add qmap mux
protocol support") in v4.12-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e120f46768d98151ece8756ebd688b0e43dc8b29]
stable/5.10: [0aabccdcec1f4a36f95829ea2263f845bbc77223]
stable/5.15: [4e6b9004f01d0fef5b19778399bc5bf55f8c2d71]
stable/6.1: [bf527b80b80a282ab5bf1540546211fc35e5cd42]
stable/6.12: [ae811175cea35b03ac6d7c910f43a82a43b9c3b3]
stable/6.6: [dd03780c29f87c26c0e0bb7e0db528c8109461fb]

CVE-2025-68193: drm/xe/guc: Add devm release action to safely tear down CT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68193

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected files were added by dd08ebf ("drm/xe: Introduce a new DRM
driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [ee4b32220a6b41e71512e8804585325e685456ba]

CVE-2025-68194: media: imon: make send_packet() more robust

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68194

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [eecd203ada43a4693ce6fdd3a58ae10c7819252c]
stable/5.10: [f58ab83b7b7133e6baefe03a46846c4f6ce45e2f]
stable/5.15: [26f6a1dd5d81ad61a875a747698da6f27abf389b]
stable/6.1: [667afd4681781f60a644cd0d2ee6c59cb1c36208]
stable/6.12: [0213e4175abbb9dfcbf7c197e3817d527f459ad5]
stable/6.6: [8231e80118463be5598daaf266c1c83650f1948b]

CVE-2025-68195: x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68195

Introduced by commit 607b9fb ("x86/CPU/AMD: Add RDSEED fix for Zen5")
in v6.18-rc4.
Fixed in v6.18-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.17

Fixed status
mainline: [f1fdffe0afea02ba783acfe815b6a60e7180df40]

CVE-2025-68196: drm/amd/display: Cache streams targeting link when
performing LT automation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68196

Introduced commit is not determined.Fixed in v6.18-rc1.
Affeced code was added by 9c6669c ("drm/amd/display: Fix Link Override
Sequencing When Switching Between DIO/HPO") in 6.17-rc1.

Fixed status
mainline: [f5b69101f956f5b89605a13cb15f093a7906f2a1]

CVE-2025-68197: bnxt_en: Fix null pointer dereference in
bnxt_bs_trace_check_wrap()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68197

Introduced by commit 84fcd94 ("bnxt_en: Manage the FW trace context
memory") in v6.13-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff02be05f78399c766be68ab0b2285ff90b2aaa8]

CVE-2025-68198: crash: fix crashkernel resource shrink

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68198

Introduced by commit 16c6006 ("kexec: enable kexec_crash_size to
support two crash kernel regions") in v6.5-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00fbff75c5acb4755f06f08bd1071879c63940c5]
stable/6.12: [f89c5e7077f63e45e8ba5a77b7cf0803130367e6]
stable/6.6: [f01f9c348d76d40bf104a94449e3ce4057fdefee]

CVE-2025-68199: codetag: debug: handle existing CODETAG_EMPTY in
mark_objexts_empty for slabobj_ext

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68199

Introduced by commit 09c4656 ("codetag: debug: introduce
OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations") in v6.10-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1abbdf3d57aa964e572940d67c9ec5dc87710738]
stable/6.12: [fc6acd4cddf76e7eb7db63649fe36980ce208f56]

CVE-2025-68200: bpf: Add bpf_prog_run_data_pointers()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68200

Introduced by commit ec624fe ("net/sched: Extend qdisc control block
with tc control block") in v5.16-rc7.
Fixed in v6.18-rc6.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [4ef92743625818932b9c320152b58274c05e5053]
stable/5.15: [c4cdd143c35974a2cedd000fa9eb3accc3023b20]
stable/6.1: [5e149d8a8e732126fb6014efd60075cf63a73f91]
stable/6.12: [6392e5f4b1a3cce10e828309baf35d22abd3457d]
stable/6.6: [baa61dcaa50b7141048c8d2aede7fe9ed8f21d11]

CVE-2025-68201: drm/amdgpu: remove two invalid BUG_ON()s

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68201

Introduced commit is not determined.Fixed in v6.18-rc2.
gfx_v11_0.c was added by 3d879e8 ("drm/amdgpu: add init support for
GFX11 (v2)") in 5.19-rc1. gfx_v12_0.c was added by 52cb80c
("drm/amdgpu: Add gfx v12_0 ip block support (v6)") in 6.11-rc1.

Fixed status
mainline: [5d55ed19d4190d2c210ac05ac7a53f800a8c6fe5]
stable/6.12: [eaf12bffd7f79f4d46ec028706f9d1a2d90f46fd]

CVE-2025-68202: sched_ext: Fix unsafe locking in the scx_dump_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68202

Introduced by commit 07814a9 ("sched_ext: Print debug dump after an
error exit") in v6.12-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f02151c411dda46efcc5dc57b0845efcdcfc26d]
stable/6.12: [13d1c96d3a9f208bc1aa8642f6362dca25a157d2]

CVE-2025-68203: drm/amdgpu: fix lock warning in
amdgpu_userq_fence_driver_process

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68203

Introduced commit is not determined.Fixed in v6.18-rc6.
Affected file was added by 97ff194 ("drm/amdgpu: Implement a new
userqueue fence driver") in 6.16-rc1.

Fixed status
mainline: [6623c5f9fd877868fba133b4ae4dab0052e82dad]

CVE-2025-68204: pmdomain: arm: scmi: Fix genpd leak on provider
registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68204

Introduced by commit 898216c ("firmware: arm_scmi: add device power
domain support using genpd") in v4.17-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7458f72cc28f9eb0de811effcb5376d0ec19094a]
stable/5.10: [c6e11d320fd6cbaef6d589f2fcb45aa25a6b960a]
stable/5.15: [582f48d22eb5676fe7be3589b986ddd29f7bf4d1]
stable/6.1: [7f569197f7ad09319af960bd7e43109de5c67c04]
stable/6.12: [921b090841ae7a08b19ab14495bdf8636dc31e21]
stable/6.6: [ad120c08b89a81d41d091490bbe150343473b659]

CVE-2025-68205: ALSA: hda/hdmi: Fix breakage at probing nvhdmi-mcp driver

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68205

Introduced by commit ad781b5 ("ALSA: hda/hdmi: Rewrite to new probe
method") in v6.17-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82420bd4e17bdaba8453fbf9e10c58c9ed0c9727]

CVE-2025-68206: netfilter: nft_ct: add seqadj extension for natted connections

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68206

Introduced by commit 1a64edf ("netfilter: nft_ct: add helper set
support") in v4.12-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90918e3b6404c2a37837b8f11692471b4c512de2]

CVE-2025-68207: drm/xe/guc: Synchronize Dead CT worker with unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68207

Introduced by commit d2c5a5a ("drm/xe/guc: Dead CT helper") in v6.13-rc1.
Fixed in v6.18-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [95af8f4fdce8349a5fe75264007f1af2aa1082ea]
stable/6.12: [35959ab7d16b618616edf6df882a4533d2efe193]

CVE-2025-68208: bpf: account for current allocated stack depth in
widen_imprecise_scalars()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68208

Introduced by commit 2793a8b ("bpf: exact states comparison for
iterator convergence checks") in v6.7-rc1.
Fixed in v6.18-rc6.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b0c8e6d3d866b6a7f73877f71968dbffd27b7785]
stable/6.12: [9944c7938cd5b3f37b0afec0481c7c015e4f1c58]
stable/6.6: [64b12dca2b0abcb5fc0542887d18b926ea5cf711]

CVE-2025-68209: mlx5: Fix default values in create CQ

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68209

Introduced by commit cdd04f4 ("net/mlx5: Add support to create SQ and
CQ for ASO") in v6.0-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5eba42f01340f73888dfe560be2806057c25913]

CVE-2025-68210: erofs: avoid infinite loop due to incomplete
zstd-compressed data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68210

Introduced by commit 7c35de4 ("erofs: Zstandard compression support")
in v6.10-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2a12cc3b97f062186568a7b94ddb7aa2ef68140]
stable/6.12: [4d0e0bb1908acac5b27d30b45c450e8ead97eb00]

CVE-2025-68211: ksm: use range-walk function to jump over holes in
scan_get_next_rmap_item

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68211

Introduced by commit 31dbd01 ("ksm: Kernel SamePage Merging") in v2.6.32-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5548c318d6520d4fa3c5ed6003eeb710763cbc5]
stable/6.12: [74f78421c925b6d17695566f0c5941de57fd44b3]

CVE-2025-68212: fs: Fix uninitialized 'offp' in statmount_string()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68212

Introduced by commit 37c4a95 ("statmount: allow to retrieve
idmappings") in v6.15-rc1.
Introduced by commit e52e97f ("statmount: let unset strings be empty")
in v6.14-rc2.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0778ac7df5137d5041783fadfc201f8fd55a1d9b]

CVE-2025-68213: idpf: fix possible vport_config NULL pointer deref in remove

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68213

Introduced by commit e1e3fec ("idpf: preserve coalescing settings
across resets") in v6.17-rc1.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [118082368c2b6ddefe6cb607efc312285148f044]
stable/6.12: [a0e1c9bc1c9fe735978150ad075616a728073bc7]

CVE-2025-68214: timers: Fix NULL function pointer race in timer_shutdown_sync()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68214

Introduced by commit 0cc04e8 ("timers: Add shutdown mechanism to the
internal functions") in v6.2-rc1.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 stable/6.1

Fixed status
mainline: [20739af07383e6eb1ec59dcd70b72ebfa9ac362c]
stable/6.1: [1a975716cc8977f461e45e28e3e5977d46ad7a6a]
stable/6.12: [176725f4848376530a0f0da9023f956afcc33585]
stable/6.6: [6665fbd7730b26d770c232b20d1b907e6a67a914]

CVE-2025-68215: ice: fix PTP cleanup on driver removal in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68215

Introduced by commit e800654 ("ice: Use ice_adapter for PTP shared
data instead of auxdev") in v6.13-rc1.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [23a5b9b12de9dcd15ebae4f1abc8814ec1c51ab0]
stable/6.12: [f5eb91f876ebecbcd90f9edcaea98dcb354603b3]

CVE-2025-68216: LoongArch: BPF: Disable trampoline for kernel module
function trace

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68216

Introduced by commit f9b6b41 ("LoongArch: BPF: Add basic bpf
trampoline support") in v6.17-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [677e6123e3d24adaa252697dc89740f2ac07664e]

CVE-2025-68217: Input: pegasus-notetaker - fix potential out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68217

Introduced by commit 1afca2b ("Input: add Pegasus Notetaker tablet
driver") in v4.8-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69aeb507312306f73495598a055293fa749d454e]
stable/5.10: [36bc92b838ff72f62f2c17751a9013b29ead2513]
stable/5.15: [015b719962696b793997e8deefac019f816aca77]
stable/6.1: [084264e10e2ae8938a54355123ad977eb9df56d6]
stable/6.12: [9ab67eff6d654e34ba6da07c64761aa87c2a3c26]
stable/6.6: [d344ea1baf1946c90f0cd6f9daeb5f3e0a0ca479]

CVE-2025-68218: nvme-multipath: fix lockdep WARN due to partition scan work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68218

Introduced by commit 1f02134 ("nvme-multipath: defer partition
scanning") in v6.12-rc4.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [6d87cd5335784351280f82c47cc8a657271929c3]
stable/6.1: [89456dab7ba5ab63d60945440926673a3205e829]
stable/6.12: [ef4ab2a8abe554379e10303ae86f7c501336ba0d]
stable/6.6: [e2a897ad5f538d314955c747a0a2edb184fcdecd]

CVE-2025-68219: cifs: fix memory leak in smb3_fs_context_parse_param error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68219

Introduced by commit 24e0a1e ("cifs: switch to new mount api") in v5.11-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e4d9120cfa413dd34f4f434befc5dbe6c38b2e5]
stable/6.12: [48d69290270891f988e72edddd9688c20515421d]
stable/6.6: [7627864dc3121f39e220f5253a227edf472de59e]

CVE-2025-68220: net: ethernet: ti: netcp: Standardize
knav_dma_open_channel to return NULL on error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68220

Introduced commit is not determined.Fixed in v6.18-rc5.
This fix kindly reverted commit 5b6cb43 ("net: ethernet: ti:
netcp_core: return error while dma channel open issue") in 4.12-rc1.

Fixed status
mainline: [90a88306eb874fe4bbdd860e6c9787f5bbc588b5]
stable/5.10: [8427218ecbd7f8559c37972e66cb0fa06e82353b]
stable/5.15: [3afeb909c3e2e0eb19b1e20506196e5f2d9c2259]
stable/6.1: [2572c358ee434ce4b994472cceeb4043cbff5bc5]
stable/6.12: [fbb53727ca789a8d27052aab4b77ca9e2a0fae2b]
stable/6.6: [952637c5b9be64539cd0e13ef88db71a1df46373]

CVE-2025-68221: mptcp: fix address removal logic in mptcp_pm_nl_rm_addr

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68221

Introduced by commit 6361139 ("mptcp: pm: remove '_nl' from
mptcp_pm_nl_rm_addr_received") in v6.15-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92e239e36d600002559074994a545fcfac9afd2d]

CVE-2025-68222: pinctrl: s32cc: fix uninitialized memory in s32_pinctrl_desc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68222

Introduced by commit fd84aaa ("pinctrl: add NXP S32 SoC family
support") in v6.4-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97ea34defbb57bfaf71ce487b1b0865ffd186e81]
stable/6.12: [583ac7f65791ceda38ea1a493a4859f7161dcb03]
stable/6.6: [3b90bd8aaeb21b513ecc4ed03299e80ece44a333]

CVE-2025-68223: drm/radeon: delete radeon_fence_process in
is_signaled, no deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68223

Introduced commit is not determined.Fixed in v6.18-rc7.


Fixed status
mainline: [9eb00b5f5697bd56baa3222c7a1426fa15bacfb5]
stable/6.12: [73bc12d6a547f9571ce4393acfd73c004e2df9e5]

CVE-2025-68224: scsi: core: Fix a regression triggered by scsi_host_busy()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68224

Introduced commit is not determined.Fixed in v6.18-rc4.
According to the commit log, this bug was introduced by 995412e
("blk-mq: Replace tags->lock with SRCU for tag iterators") in
6.18-rc1.

Fixed status
mainline: [a0b7780602b1b196f47e527fec82166a7e67c4d0]
stable/5.10: [143257917b836bd5fc434063030fda199e249624]
stable/5.15: [804b5b8e3545445450387ae6891262c421c49304]
stable/6.1: [d579f496681c5136d63cb4fbb685511227e73602]
stable/6.12: [47c8b35a1f1d53aac156480cea0a0c5c82919f03]
stable/6.6: [5d778778b40bcdfd9f8817fea1ec6ebcbec69c0a]

CVE-2025-68225: lib/test_kho: check if KHO is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68225

Introduced by commit b753522 ("kho: add test for kexec handover") in v6.17-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a26ec8f3d4e56d4a7ffa301e8032dca9df0bbc05]

CVE-2025-68226: smb: client: fix incomplete backport in
cfids_invalidation_worker()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68226


This bug is backport issue. This bug is affectedto 6.12, 6.17, and 6.6.
Bug introduced commit was backported to following branches.
stable/6.12 stable/6.17 stable/6.6

Fixed status
mainline: [n,e,v,e,r]
stable/6.12: [1ebfea90f9f0e4ecac45dba6813fa65fcc889f06]
stable/6.6: [64332afa9f769135972021b8f2b06b089f024068]

CVE-2025-68227: mptcp: Fix proto fallback detection with BPF

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68227

Introduced by commit 0b4f33d ("mptcp: fix tcp fallback crash") in v5.7-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c77b3b79a92e3345aa1ee296180d1af4e7031f8f]
stable/5.10: [92c4092fe012ecdfa5fb05d394f1c1d8f91ad81c]
stable/5.15: [7ee8f015eb47907745e2070184a8ab1e442ac3c4]
stable/6.1: [344974ea1a3ca30e4920687b0091bda4438cebdb]
stable/6.12: [9b1980b6f23fa30bf12add19f37c7458625099eb]
stable/6.6: [037cc50589643342d69185b663ecf9d26cce91e8]

CVE-2025-68228: drm/plane: Fix create_in_format_blob() return value

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68228

Introduced by commit 0d6dcd7 ("drm/plane: modify create_in_formats to
acommodate async") in v6.16-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cead55e24cf9e092890cf51c0548eccd7569defa]

CVE-2025-68229: scsi: target: tcm_loop: Fix segfault in
tcm_loop_tpg_address_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68229

Introduced by commit 2628b35 ("tcm_loop: Show address of tpg in
configfs") in v4.5-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6965188f84a7883e6a0d3448e86b0cf29b24dfc]
stable/5.10: [3d8c517f6eb27e47b1a198e05f8023038329b40b]
stable/5.15: [f449a1edd7a13bb025aaf9342ea6f8bf92684bbf]
stable/6.1: [1c9ba455b5073253ceaadae4859546e38e8261fe]
stable/6.12: [72e8831079266749a7023618a0de2f289a9dced6]
stable/6.6: [a6ef60898ddaf1414592ce3e5b0d94276d631663]

CVE-2025-68230: drm/amdgpu: fix gpu page fault after hibernation on PF
passthrough

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68230

Introduced commit is not determined.Fixed in v6.18-rc5.
gfx_v9_4_3.c was added by 7c0f7ee ("drm/amdgpu: add gc v9_4_3
rlc_funcs implementation") in 6.4-rc1. aqua_vanjaram.c was added by
6df442a ("drm/amdgpu: add new doorbell assignment table for
aqua_vanjaram") in 6.5-rc1.

Fixed status
mainline: [eb6e7f520d6efa4d4ebf1671455abe4a681f7a05]
stable/6.12: [a45d6359eefb41e08d374a3260b10bff5626823b]

CVE-2025-68231: mm/mempool: fix poisoning order>0 pages with HIGHMEM

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68231

Introduced by commit bdfedb7 ("mm, mempool: poison elements backed by
slab allocator") in v4.1-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec33b59542d96830e3c89845ff833cf7b25ef172]
stable/6.1: [ea4131665107e66ece90e66bcec1a2f1246cbd41]
stable/6.12: [6a13b56537e7b0d97f4bb74e8038ce471f9770d7]
stable/6.6: [19de79aaea33ee1ea058c8711b3b2b4a7e4decd4]

CVE-2025-68232: veth: more robust handing of race to avoid txq getting stuck

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68232

Introduced by commit dc82a33 ("veth: apply qdisc backpressure on full
ptr_ring to reduce TX drops") in v6.16-rc1.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [5442a9da69789741bfda39f34ee7f69552bf0c56]
stable/6.12: [dd419a3f2ebc18cc00bc32c57fd052d7a188b78b]

CVE-2025-68233: drm/tegra: Add call to put_pid()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68233

Introduced by commit e09db97 ("drm/tegra: Support context isolation")
in v6.0-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6cbab9f0da72b4dc3c3f9161197aa3b9daa1fa3a]
stable/6.1: [6b572e5154af08ee13f8d2673e86f83bc5ff86cd]
stable/6.12: [cbf2cbdb0733d7974dab296ffba0e7ae9b6524e5]
stable/6.6: [2e78580e6e7deac6556236ef96db5bbf7b46857e]

CVE-2025-68234: io_uring/cmd_net: fix wrong argument types for
skb_queue_splice()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68234

Introduced by commit 9e4ed35 ("io_uring/netcmd: add tx timestamping
cmd support") in v6.17-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46447367a52965e9d35f112f5b26fc8ff8ec443d]

CVE-2025-68235: nouveau/firmware: Add missing kfree() of nvkm_falcon_fw::boot

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68235

Introduced by commit 2541626 ("drm/nouveau/acr: use common falcon HS
FW code for ACR FWs") in v6.2-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [949f1fd2225baefbea2995afa807dba5cbdb6bd3]
stable/6.12: [6492add9a3a163d5e0390428d2636adc3e61b883]
stable/6.6: [7d1977b4ae5c50e1aafc5c51500fc08bd7afd6a0]

CVE-2025-68236: scsi: ufs: ufs-qcom: Fix UFS OCP issue during UFS
power down (PC=3)

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68236

Introduced commit is not determined.Fixed in v6.18-rc5.


Fixed status
mainline: [5127be409c6c3815c4a7d8f6d88043e44f9b9543]

CVE-2025-68237: mtdchar: fix integer overflow in read/write ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68237

Introduced by commit 095bb6e ("mtdchar: add MEMREAD ioctl") in v6.1-rc1.
Introduced by commit 6420ac0 ("mtdchar: prevent unbounded allocation
in MEMWRITE ioctl") in v5.17-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4185bed738da755b191aa3f2e16e8b48450e1b8]
stable/6.1: [f37efdd97fd1ec3e0d0f1eec279c8279e28f981e]
stable/6.12: [eb9361484814fb12f3b7544b33835ea67d7a6a97]
stable/6.6: [457376c6fbf0c69326a9bf1f72416225f681192b]

CVE-2025-68238: mtd: rawnand: cadence: fix DMA device NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68238

Introduced by commit d76d22b ("mtd: rawnand: cadence: use
dma_map_resource for sdma address") in v6.14-rc4.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [5c56bf214af85ca042bf97f8584aab2151035840]
stable/5.10: [2178b0255eae108bb10e5e99658b28641bc06f43]
stable/5.15: [9c58c64ec41290c12490ca7e1df45013fbbb41fd]
stable/6.1: [e282a4fdf3c6ee842a720010a8b5f7d77bedd126]
stable/6.12: [0c635241a62f2f5da1b48bfffae226d1f86a76ef]
stable/6.6: [b146e0b085d9d6bfe838e0a15481cba7d093c67f]

CVE-2025-68239: binfmt_misc: restore write access before closing files
opened by open_exec()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68239

Introduced by commit e7850f4 ("binfmt_misc: fix possible deadlock in
bm_register_write") in v5.12-rc3.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [90f601b497d76f40fa66795c3ecf625b6aced9fd]

CVE-2025-68240: nilfs2: avoid having an active sc_timer before freeing sci

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68240

Introduced by commit 3f66cc2 ("nilfs2: use kthread_create and
kthread_stop for the log writer thread") in v6.12-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a6b60cb147d53968753a34805211d2e5e08c027]
stable/6.12: [36049e81dc7f077e0e24d5b9688a7458beacef8f]

CVE-2025-68241: ipv4: route: Prevent rt_bind_exception() from
rebinding stale fnhe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68241

Introduced by commit 67d6d68 ("ipv4: make exception cache less
predictible") in v5.15-rc1.
Fixed in v6.18-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [ac1499fcd40fe06479e9b933347b837ccabc2a40]
stable/5.10: [4b7210da22429765d19460d38c30eeca72656282]
stable/5.15: [298f1e0694ab4edb6092d66efed93c4554e6ced1]
stable/6.1: [b8a44407bdaf2f0c5505cc7d9fc7d8da90cf9a94]
stable/6.12: [b84f083f50ecc736a95091691339a1b363962f0e]
stable/6.6: [041ab9ca6e80d8f792bb69df28ebf1ef39c06af8]

CVE-2025-68242: NFS: Fix LTP test failures when timestamps are delegated

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68242

Introduced by commit e12912d ("NFSv4: Add support for delegated atime
and mtime attributes") in v6.11-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b623390045a81fc559decb9bfeb79319721d3dfb]
stable/6.12: [b2e4cda71ed062c87573b016d2d956a62f4258ed]

CVE-2025-68243: NFS: Check the TLS certificate fields in nfs_match_client()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68243

Introduced by commit 90c9550 ("NFS: support the kernel keyring for
TLS") in v6.17-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb2cba0854a7f315c8100a807a6959b99d72479e]

CVE-2025-68244: drm/i915: Avoid lock inversion when pinning to GGTT on
CHV/BXT+VTD

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68244

Introduced by commit 7d1c261 ("drm/i915: Take reservation lock around
i915_vma_pin.") in v5.13-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84bbe327a5cbb060f3321c9d9d4d53936fc1ef9b]
stable/5.15: [e988634d7aae7214818b9c86cd7ef9e78c84b02d]
stable/6.1: [20d94a6117b752fd10a78cefdc1cf2c16706048b]
stable/6.12: [4e73066e3323add260e46eb51f79383d87950281]
stable/6.6: [3dec22bde207a36f1b8a4b80564cbbe13996a7cd]

CVE-2025-68245: net: netpoll: fix incorrect refcount handling causing
incorrect cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68245

Introduced by commit efa95b0 ("netpoll: fix use after free") in v3.17-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49c8d2c1f94cc2f4d1a108530d7ba52614b874c2]
stable/5.10: [9b0bb18b4b9dc017c1825a2c5e763615e34a1593]
stable/5.15: [890472d6fbf062e6de7fdd56642cb305ab79d669]
stable/6.1: [4afd4ebbad52aa146838ec23082ba393e426a2bb]
stable/6.12: [c79a6d9da29219616b118a3adce9a14cd30f9bd0]
stable/6.6: [c645693180a98606c430825223d2029315d85e9d]

CVE-2025-68246: ksmbd: close accepted socket when per-IP limit rejects
connection

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68246

Introduced commit is not determined.Fixed in v6.18-rc6.
Affected code was added by e6bb919 ("ksmbd: limit repeated connections
from clients with the same IP") in 6.17-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [98a5fd31cbf72d46bf18e50b3ab0ce86d5f319a9]
stable/6.1: [7a3c7154d5fc05956a8ad9e72ecf49e21555bfca]
stable/6.12: [4587a7826be1ae0190dba10ff70b46bb0e3bc7d3]
stable/6.6: [5746b2a0f5eb3d79667b3c51fe849bd62464220e]

CVE-2025-68247: posix-timers: Plug potential memory leak in do_timer_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68247

Introduced by commit ec2d0c0 ("posix-timers: Provide a mechanism to
allocate a given timer ID") in v6.15-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0fd4d42e27f761e9cc82801b3f183e658dc749d]

CVE-2025-68248: vmw_balloon: indicate success when effectively
deflating during migration

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68248

Introduced by commit 3544c4f ("mm/balloon_compaction: stop using
__ClearPageMovable()") in v6.17-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ba5a8a7faa647ada8eae61a36517cf369f5bbe4]

CVE-2025-68249: most: usb: hdm_probe: Fix calling put_device() before
device initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68249

Introduced by commit 97a6f77 ("drivers: most: add USB adapter driver")
in v5.9-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8cc9e5fcb0e2eef21513a4fec888f5712cb8162]
stable/5.10: [3509c748e79435d09e730673c8c100b7f0ebc87c]
stable/5.15: [ad2be44882716dc3589fbc5572cc13f88ead6b24]
stable/6.1: [c400410fe0580dd6118ae8d60287ac9ce71a65fd]
stable/6.12: [7d851f746067b8ee5bac9c262f326ace0a6ea253]
stable/6.6: [6fb8fbc0aa542af5bf0fed94fa6b0edf18144f95]

CVE-2025-68250: hung_task: fix warnings caused by unaligned lock pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68250

Introduced by commit e711faa ("hung_task: replace blocker_mutex with
encoded blocker") in v6.16-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c97513cddcfc235f2522617980838e500af21d01]

CVE-2025-68251: erofs: avoid infinite loops due to corrupted subpage
compact indexes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68251

Introduced by commit 8d2517a ("erofs: fix up compacted indexes for
block size < 4096") in v6.8-rc1.
Introduced by commit 1a5223c ("erofs: do sanity check on m->type in
z_erofs_load_compact_lcluster()") in v6.17-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e13d315ae077bb7c3c6027cc292401bc0f4ec683]

CVE-2025-68252: misc: fastrpc: Fix dma_buf object leak in fastrpc_map_lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68252

Introduced by commit 9031626 ("misc: fastrpc: Fix fastrpc_map_lookup
operation") in v6.18-rc1.
Fixed in v6.18-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.17 stable/6.6

Fixed status
mainline: [fff111bf45cbeeb659324316d68554e35d350092]
stable/6.1: [c2fef5ebb73f3dabae6fbc571d181914ed32c483]
stable/6.12: [e17b13387827adce7acb19ac0f07f9bcafe0ff4c]
stable/6.6: [9a297a68c3ba4a7ecb31ed52f61bd6634abb79d3]

CVE-2025-68253: mm: don't spin in add_stack_record when gfp flags don't allow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68253

Introduced by commit 97769a5 ("mm, bpf: Introduce try_alloc_pages()
for opportunistic page allocation") in v6.15-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c83aab85e18103a6dc066b4939e2c92a02bb1b05]

CVE-2025-68254: staging: rtl8723bs: fix out-of-bounds read in OnBeacon
ESR IE parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68254

Introduced commit is not determined.Fixed in v6.19-rc1.
Affected file was added by 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in 4.12-rc1.

Fixed status
mainline: [502ddcc405b69fa92e0add6c1714d654504f6fd7]
stable/6.12: [d1ab7f9cee22e7b8a528da9ac953e4193b96cda5]

CVE-2025-68255: staging: rtl8723bs: fix stack buffer overflow in
OnAssocReq IE parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68255

Introduced commit is not determined.Fixed in v6.19-rc1.
Affected file was added by 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in 4.12-rc1.

Fixed status
mainline: [6ef0e1c10455927867cac8f0ed6b49f328f8cf95]
stable/6.12: [61871c83259a511980ec2664964cecc69005398b]

CVE-2025-68256: staging: rtl8723bs: fix out-of-bounds read in
rtw_get_ie() parser

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68256

Introduced commit is not determined.Fixed in v6.19-rc1.
Affected file was added by 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in 4.12-rc1.

Fixed status
mainline: [154828bf9559b9c8421fc2f0d7f7f76b3683aaed]
stable/6.12: [a54e2b2db1b7de2e008b4f62eec35aaefcc663c5]

CVE-2025-68257: comedi: check device's attached status in compat ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68257

Introduced by commit 3fbfd22 ("comedi: get rid of
compat_alloc_user_space() mess in COMEDI_CHANINFO compat") in
v5.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0de7d9cd07a2671fa6089173bccc0b2afe6b93ee]
stable/6.12: [f6e629dfe6f590091c662a87c9fcf118b1c1c7dc]

CVE-2025-68258: comedi: multiq3: sanitize config options in multiq3_attach()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68258

Introduced by commit 77e01cd ("Staging: comedi: add multiq3 driver")
in v2.6.30-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f24c6e3a39fa355dabfb684c9ca82db579534e72]
stable/6.12: [8952bc1973cd54158c35e06bfb8c29ace7375a48]

CVE-2025-68259: KVM: SVM: Don't skip unrelated instruction if
INT3/INTO is replaced

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68259

Introduced by commit 6ef88d6 ("KVM: SVM: Re-inject INT3/INTO instead
of retrying the instruction") in v6.0-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4da3768e1820cf15cced390242d8789aed34f54d]
stable/6.12: [87cc1622c88a4888959d64fa1fc9ba1e264aa3d4]

CVE-2025-68260: rust_binder: fix race condition on death_list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68260

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e0ae02ba831da2b707905f4e602e43f8507b8cc]

CVE-2025-68261: ext4: add i_data_sem protection in
ext4_destroy_inline_data_nolock()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68261

Introduced by commit c755e25 ("ext4: fix deadlock between inline_data
and ext4_expand_extra_isize_ea()") in v4.11-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [0cd8feea8777f8d9b9a862b89c688b049a5c8475]
stable/6.12: [22a76b0861ae61a299c8e126c1aca8c4fda820fd]

CVE-2025-68262: crypto: zstd - fix double-free in per-CPU stream cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68262

Introduced by commit f5ad93f ("crypto: zstd - convert to acomp") in v6.17-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48bc9da3c97c15f1ea24934bcb3b736acd30163d]

CVE-2025-68263: ksmbd: ipc: fix use-after-free in ipc_msg_send_request

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68263

Introduced commit is not determined.Fixed in v6.19-rc1.
Affected file was added by 0626e66 ("cifsd: add server handler for
central processing and tranport layers") in 5.15-rc1.

Fixed status
mainline: [1fab1fa091f5aa97265648b53ea031deedd26235]
stable/6.12: [5ac763713a1ef8f9a8bda1dbd81f0318d67baa4e]

CVE-2025-68264: ext4: refresh inline data size before write operations

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68264

Introduced commit is not determined.Fixed in v6.19-rc1.


Fixed status
mainline: [892e1cf17555735e9d021ab036c36bc7b58b0e3b]
stable/6.12: [210ac60a86a3ad2c76ae60e0dc71c34af6e7ea0b]

CVE-2025-68265: nvme: fix admin request_queue lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68265

Introduced commit is not determined.Fixed in v6.18-rc7.


Fixed status
mainline: [03b3bcd319b3ab5182bc9aaa0421351572c78ac0]
stable/6.12: [e8061d02b49c5c901980f58d91e96580e9a14acf]

CVE-2025-68266: bfs: Reconstruct file type when loading from disk

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68266

Introduced commit is not determined.Fixed in v6.18-rc7.


Fixed status
mainline: [34ab4c75588c07cca12884f2bf6b0347c7a13872]
stable/6.12: [77899444d46162aeb65f229590c26ba266864223]

CVE-2025-68281: ASoC: SDCA: bug fix while parsing mipi-sdca-control-cn-list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68281

Introduced commit is not determined.Fixed in v6.18-rc6.
Affected code was added by 50a4795 ("ASoC: SDCA: Add support for -cn-
value properties") in 6.17-rc1.

Fixed status
mainline: [eb2d6774cc0d9d6ab8f924825695a85c14b2e0c2]

CVE-2025-68282: usb: gadget: udc: fix use-after-free in usb_gadget_state_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68282

Introduced by commit 5702f75 ("usb: gadget: udc-core: move
sysfs_notify() to a workqueue") in v3.12-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [baeb66fbd4201d1c4325074e78b1f557dff89b5b]
stable/6.1: [c12a0c3ef815ddd67e47f9c819f9fe822fed5467]
stable/6.12: [10014310193cf6736c1aeb4105c5f4a0818d0c65]
stable/6.6: [f02a412c0a18f02f0f91b0a3d9788315a721b7fd]

CVE-2025-68283: libceph: replace BUG_ON with bounds check for map->max_osd

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68283

Introduced commit is not determined.Fixed in v6.18.


Fixed status
mainline: [ec3797f043756a94ea2d0f106022e14ac4946c02]
stable/6.1: [57f5fbae9f1024aba17ff75e00433324115c548a]
stable/6.12: [e67e3be690f5f7e3b031cf29e8d91e6d02a8e30d]
stable/6.6: [becc488a4d864db338ebd4e313aa3c77da24b604]

CVE-2025-68284: libceph: prevent potential out-of-bounds writes in
handle_auth_session_key()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68284

Introduced commit is not determined.Fixed in v6.18.


Fixed status
mainline: [7fce830ecd0a0256590ee37eb65a39cbad3d64fc]
stable/5.15: [f22c55a20a2d9ffbbac57408d5d488cef8201e9d]
stable/6.1: [8dfcc56af28cffb8f25fb9be37b3acc61f2a3d09]
stable/6.12: [5ef575834ca99f719d7573cdece9df2fe2b72424]
stable/6.6: [ccbccfba25e9aa395daaea156b5e7790910054c4]

CVE-2025-68285: libceph: fix potential use-after-free in have_mon_and_osd_map()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68285

Introduced commit is not determined.Fixed in v6.18.


Fixed status
mainline: [076381c261374c587700b3accf410bdd2dba334e]
stable/5.10: [bb4910c5fd436701faf367e1b5476a5a6d2aff1c]
stable/5.15: [05ec43e9a9de67132dc8cd3b22afef001574947f]
stable/6.1: [7c8ccdc1714d9fabecd26e1be7db1771061acc6e]
stable/6.12: [e08021b3b56b2407f37b5fe47b654be80cc665fb]
stable/6.6: [183ad6e3b651e8fb0b66d6a2678f4b80bfbba092]

CVE-2025-68286: drm/amd/display: Check NULL before accessing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68286

Introduced commit is not determined.Fixed in v6.18.


Fixed status
mainline: [3ce62c189693e8ed7b3abe551802bbc67f3ace54]
stable/5.10: [781f2f32e9c19eb791b52af283c96f9a9677a7f2]
stable/5.15: [09092269cb762378ca8b56024746b1a136761e0d]
stable/6.1: [109e9c92543f3105e8e1efd2c5e6b92ef55d5743]
stable/6.12: [f7cf491cd5b54b5a093bd3fdf76fa2860a7522bf]
stable/6.6: [9d1a65cbe3ec5da3003c8434ac7a38dcdc958fd9]

CVE-2025-68287: usb: dwc3: Fix race condition between concurrent
dwc3_remove_requests() call paths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68287

Introduced by commit 72246da ("usb: Introduce DesignWare USB3 DRD
Driver") in v3.2-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4037689a366743c4233966f0e74bc455820d316]
stable/5.10: [467add9db13219101f14b6cc5477998b4aaa5fe2]
stable/5.15: [67192e8cb7f941b5bba91e4bb290683576ce1607]
stable/6.1: [47de14d741cc4057046c9e2f33df1f7828254e6c]
stable/6.12: [7cfb62888eba292fa35cd9ddbd28ce595f60e139]
stable/6.6: [afc0e34f161ce61ad351303c46eb57bd44b8b090]

CVE-2025-68288: usb: storage: Fix memory leak in USB bulk transport

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68288

Introduced by commit a45b599 ("scsi: sg: allocate with __GFP_ZERO in
sg_build_indirect()") in v4.17-rc7.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [41e99fe2005182139b1058db71f0d241f8f0078c]
stable/5.10: [83f0241959831586d9b6d47f6bd5d3dec8f43bf0]
stable/5.15: [4ba515dfff7eeca369ab85cdbb3f3b231c71720c]
stable/6.1: [467fec3cefbeb9e3ea80f457da9a5666a71ca0d0]
stable/6.12: [0f18eac44c5668204bf6eebb01ddb369ac56932b]
stable/6.6: [cb1401b5bcc2feb5b038fc4b512e5968b016e05e]

CVE-2025-68289: usb: gadget: f_eem: Fix memory leak in eem_unwrap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68289

Introduced by commit 4249d6f ("usb: gadget: eem: fix echo command
packet response issue") in v5.14-rc1.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [e4f5ce990818d37930cd9fb0be29eee0553c59d9]
stable/5.10: [a9985a88b2fc29fbe1657fe8518908e261d6889c]
stable/5.15: [5a1628283cd9dccf1e44acfb74e77504f4dc7472]
stable/6.1: [0ac07e476944a5e4c2b8b087dd167dec248c1bdf]
stable/6.12: [e72c963177c708a167a7e17ed6c76320815157cf]
stable/6.6: [41434488ca714ab15cb2a4d0378418d1be8052d2]

CVE-2025-68290: most: usb: fix double free on late probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68290

Introduced by commit 723de0f ("staging: most: remove device from
interface structure") in v5.6-rc1.
Introduced by commit 4b12709 ("most: usb: Fix use-after-free in
hdm_disconnect") in v6.18-rc3.
Introduced by commit a8cc9e5 ("most: usb: hdm_probe: Fix calling
put_device() before device initialization") in v6.18-rc3.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.17 stable/6.6

Fixed status
mainline: [baadf2a5c26e802a46573eaad331b427b49aaa36]
stable/5.10: [90e6ce2b1b19fb8b9d4afee69f40e4c6a4791154]
stable/5.15: [a4c4118c2af284835b16431bbfe77e0130c06fef]
stable/6.1: [0dece48660be16918ecf2dbdc7193e8be03e1693]
stable/6.12: [2274767dc02b756b25e3db1e31c0ed47c2a78442]
stable/6.6: [993bfdc3842893c394de13c8200c338ebb979589]

CVE-2025-68291: mptcp: Initialise rcv_mss before calling
tcp_send_active_reset() in mptcp_do_fastclose().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68291

Introduced by commit ae15506 ("mptcp: fix duplicate reset on
fastclose") in v6.18-rc7.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/6.1 stable/6.1 stable/6.12 stable/6.17 stable/6.6

Fixed status
mainline: [f07f4ea53e22429c84b20832fa098b5ecc0d4e35]
stable/6.12: [05f5e26d488cdc7abc2a826cf1071782d5a21203]

CVE-2025-68292: mm/memfd: fix information leak in hugetlb folios

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68292

Introduced by commit 89c1905 ("mm/gup: introduce memfd_pin_folios()
for pinning memfd folios") in v6.11-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de8798965fd0d9a6c47fc2ac57767ec32de12b49]
stable/6.12: [50b4c1c28733a536d637d2f0401d60bcfef60ef2]

CVE-2025-68293: mm/huge_memory: fix NULL pointer deference when splitting folio

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68293

Introduced by commit c010d47 ("mm: thp: split huge page to any lower
order pages") in v6.9-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cff47b9e39a6abf03dde5f4f156f841b0c54bba0]
stable/6.12: [592db83615a9f0164472ec789c2ed34ad35f732f]

CVE-2025-68294: io_uring/net: ensure vectored buffer node import is
tied to notification

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68294

Introduced by commit 23371ea ("io_uring/net: implement vectored reg
bufs for zctx") in v6.15-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6041803a831266a2a5a5b5af66f7de0845bcbf3]

CVE-2025-68295: smb: client: fix memory leak in cifs_construct_tcon()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68295

Introduced by commit f2aee32 ("cifs: set domainName when a domain-key
is used in multiuser") in v5.3-rc7.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [3184b6a5a24ec9ee74087b2a550476f386df7dc2]
stable/5.10: [ff8f9bd1c46ee02d5558293915d42e82646d5ee9]
stable/5.15: [d146e96fef876492979658dce644305de35878d4]
stable/6.1: [3dd546e867e94c2f954bca45a961b6104ba708b6]
stable/6.12: [f15288c137d960836277d0e3ecc62de68e52f00f]
stable/6.6: [f62ffdfb431bdfa4b6d24233b7fd830eca0b801e]

CVE-2025-68296: drm, fbcon, vga_switcheroo: Avoid race condition in fbcon setup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68296

Introduced by commit 6a9ee8a ("vga_switcheroo: initial implementation
(v15)") in v2.6.34-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb76d0f5553575599561010f24c277cc5b31d003]
stable/6.12: [482330f8261b4bea8146d9bd69c1199e5dfcbb5c]

CVE-2025-68297: ceph: fix crash in process_v2_sparse_read() for
encrypted directories

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68297

Introduced commit is not determined.Fixed in v6.18.
Affected function was added by f36217e ("libceph: support sparse reads
on msgr2 secure codepath") in 6.6-rc1.

Fixed status
mainline: [43962db4a6f593903340c85591056a0cef812dfd]
stable/6.12: [47144748fbf12068ba4b82512098fe1ac748a2e9]
stable/6.6: [5a3f3e39b18705bc578fae58abacc8ef93c15194]

CVE-2025-68298: Bluetooth: btusb: mediatek: Avoid
btusb_mtk_claim_iso_intf() NULL deref

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68298

Introduced by commit e9087e8 ("Bluetooth: btusb: mediatek: Add locks
for usb_driver_claim_interface()") in v6.14-rc1.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [c884a0b27b4586e607431d86a1aa0bb4fb39169c]
stable/6.12: [2fa09fe98ca3b114d66285f65f7e108fea131815]

CVE-2025-68299: afs: Fix delayed allocation of a cell's anonymous key

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68299

Introduced by commit 330e2c5 ("afs: Fix dynamic lookup to fail on cell
lookup failure") in v6.18-rc7.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
stable/6.17

Fixed status
mainline: [d27c71257825dced46104eefe42e4d9964bd032e]

CVE-2025-68300: fs/namespace: fix reference leak in grab_requested_mnt_ns

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68300

Introduced by commit 78f0e33 ("fs/namespace: correctly handle errors
returned by grab_requested_mnt_ns") in v6.18-rc7.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.17

Fixed status
mainline: [7b6dcd9bfd869eee7693e45b1817dac8c56e5f86]
stable/6.12: [4a16b2a0c1f033f95f5d0b98b9e40e8bf7c4c2c5]

CVE-2025-68301: net: atlantic: fix fragment overflow handling in RX path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68301

Introduced by commit 6aecbba ("net: atlantic: add check for
MAX_SKB_FRAGS") in v5.18-rc7.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [5ffcb7b890f61541201461580bb6622ace405aec]
stable/5.10: [34147477eeab24077fcfe9649e282849347d760c]
stable/5.15: [b0c4d5135b04ea100988e2458c98f2d8564cda16]
stable/6.1: [5d6051ea1b0417ae2f06a8440d22e48fbc8f8997]
stable/6.12: [3fd2105e1b7e041cc24be151c9a31a14d5fc50ab]
stable/6.6: [3be37c3c96b16462394fcb8e15e757c691377038]

CVE-2025-68302: net: sxgbe: fix potential NULL dereference in sxgbe_rx()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68302

Introduced by commit 1edb9ca ("net: sxgbe: add basic framework for
Samsung 10Gb ethernet driver") in v3.15-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5bce28f6b9125502abec4a67d68eabcd24b3b17]
stable/5.10: [ac171c3c755499c9f87fe30b920602255f8b5648]
stable/5.15: [18ef3ad1bb57dcf1a9ee61736039aedccf670b21]
stable/6.1: [46e5332126596a2ca791140feab18ce1fc1a3c86]
stable/6.12: [45b5b4ddb8d6bea5fc1625ff6f163bbb125d49cc]
stable/6.6: [7fd789d6ea4915034eb6bcb72f6883c8151083e5]

CVE-2025-68303: platform/x86: intel: punit_ipc: fix memory corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68303

Introduced by commit fdca4f1 ("platform:x86: add Intel P-Unit mailbox
IPC driver") in v4.5-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b9c0adbc3f8a524d291baccc9d0c04097fb4869]
stable/5.15: [15d560cdf5b36c51fffec07ac2a983ab3bff4cb2]
stable/6.1: [46e9d6f54184573dae1dcbcf6685a572ba6f4480]
stable/6.12: [a21615a4ac6fecbb586d59fe2206b63501021789]
stable/6.6: [3e7442c5802146fd418ba3f68dcb9ca92b5cec83]

CVE-2025-68304: Bluetooth: hci_core: lookup hci_conn on RX path on protocol side

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68304

Introduced by commit 5af1f84 ("Bluetooth: hci_sync: Fix UAF on
hci_abort_conn_sync") in v6.6-rc1.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [79a2d4678ba90bdba577dc3af88cc900d6dcd5ee]

CVE-2025-68305: Bluetooth: hci_sock: Prevent race in socket write iter
and sock bind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68305

Introduced by commit 6fe26f6 ("Bluetooth: MGMT: Protect mgmt_pending
list with its own lock") in v6.16-rc2.
Fixed in v6.18.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [89bb613511cc21ed5ba6bddc1c9b9ae9c0dad392]
stable/6.12: [e90c05fc5bbea956450a05cc3b36b8fa29cf195e]
stable/6.6: [fe68510fc99bb4b88c9c611f83699749002d515a]

CVE-2025-68306: Bluetooth: btusb: mediatek: Fix kernel crash when
releasing mtk iso interface

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68306

Introduced by commit ceac1cb ("Bluetooth: btusb: mediatek: add ISO
data transmission functions") in v6.11-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4015b979767125cf8a2233a145a3b3af78bfd8fb]
stable/6.12: [421e88a0d85782786b7a1764c75518b4845e07b3]

CVE-2025-68307: can: gs_usb: gs_usb_xmit_callback(): fix handling of
failed transmitted URBs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68307

Introduced by commit d08e973 ("can: gs_usb: Added support for the
GS_USB CAN devices") in v3.16-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [516a0cd1c03fa266bb67dd87940a209fd4e53ce7]
stable/6.1: [f7a5560675bd85efaf16ab01a43053670ff2b000]
stable/6.12: [4a82072e451eacf24fc66a445e906f5095d215db]
stable/6.6: [1a588c40a422a3663a52f1c5535e8fb6b044167d]

CVE-2025-68308: can: kvaser_usb: leaf: Fix potential infinite loop in
command parsers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68308

Introduced by commit 7259124 ("can: kvaser_usb: Split driver into
kvaser_usb_core.c and kvaser_usb_leaf.c") in v4.19-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c73772cd2b8cc108d5f5334de89ad648d89b9ec]
stable/5.10: [58343e0a4d43699f0e2f5b169384bbe4c0217add]
stable/5.15: [69c7825df64e24dc15d31631a1fc9145324b1345]
stable/6.1: [028e89c7e8b4346302e88df01cc50e0a1f05791a]
stable/6.12: [0897cea266e39166a36111059ba147192b36592f]
stable/6.6: [e9dd83a75a7274edef21682c823bf0b66d7b6b7f]

CVE-2025-68309: PCI/AER: Fix NULL pointer access by aer_info

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68309

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by db89ccb ("PCI/AER: Define aer_stats
structure for AER capable devices") in 4.19-rc1.

Fixed status
mainline: [0a27bdb14b028fed30a10cec2f945c38cb5ca4fa]

CVE-2025-68310: s390/pci: Avoid deadlock between PCI error recovery
and mlx5 crdump

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68310

Introduced by commit 4cdf2f4 ("s390/pci: implement minimal PCI error
recovery") in v5.16-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fd20f65df6aa430454a0deed8f43efa91c54835]
stable/6.1: [d0df2503bc3c2be385ca2fd96585daad1870c7c5]
stable/6.12: [3591d56ea9bfd3e7fbbe70f749bdeed689d415f9]
stable/6.6: [b63c061be622b17b495cbf78a6d5f2d4c3147f8e]

CVE-2025-68311: tty: serial: ip22zilog: Use platform device for probing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68311

Introduced commit is not determined.Fixed in v6.18-rc1.
This bug was introduced by 84a9582 ("serial: core: Start managing
serial controllers to enable runtime PM") in 6.5-rc1.

Fixed status
mainline: [3fc36ae6abd263a5cbf93b2f5539eccc1fc753f7]
stable/6.12: [460e0dc9af2d7790d5194c6743d79f9b77b58836]

CVE-2025-68312: usbnet: Prevents free active kevent

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68312

Introduced by commit a69e617 ("usbnet: Fix linkwatch use-after-free on
disconnect") in v6.0-rc1.
Fixed in v6.18-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [420c84c330d1688b8c764479e5738bbdbf0a33de]
stable/5.10: [88a38b135d69f5db9024ff6527232f1b51be8915]
stable/5.15: [43005002b60ef3424719ecda16d124714b45da3b]
stable/6.1: [3a10619fdefd3051aeb14860e4d4335529b4e94d]
stable/6.12: [2ce1de32e05445d77fc056f6ff8339cfb78a5f84]
stable/6.6: [9a579d6a39513069d298eee70770bbac8a148565]

CVE-2025-68313: x86/CPU/AMD: Add RDSEED fix for Zen5

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68313

Introduced commit is not determined.Fixed in v6.18-rc4.
Affected function was added by 3e4147f ("x86/CPU/AMD: Add
X86_FEATURE_ZEN5") in 6.8-rc2.

Fixed status
mainline: [607b9fb2ce248cc5b633c5949e0153838992c152]
stable/6.12: [e980de2ff109dacb6d9d3a77f01b27c467115ecb]

CVE-2025-68314: drm/msm: make sure last_fence is always updated

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68314

Introduced by commit 92395af ("drm/msm: Add VM_BIND submitqueue") in v6.17-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86404a9e3013d814a772ac407573be5d3cd4ee0d]

CVE-2025-68315: f2fs: fix to detect potential corrupted nid in free_nid_list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68315

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [8fc6056dcf79937c46c97fa4996cda65956437a9]
stable/6.12: [6b9525596a83cd5b7bbc2c7bd5f9ad9cf5ad60fa]

CVE-2025-68316: scsi: ufs: core: Fix invalid probe error return value

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68316

Introduced by commit 69f5eb7 ("scsi: ufs: core: Move the
ufshcd_device_init(hba, true) call") in v6.13-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2b32bc1d9e359a9f90d0de6af16699facb10935]

CVE-2025-68317: io_uring/zctx: check chained notif contexts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68317

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [ab3ea6eac5f45669b091309f592c4ea324003053]
stable/6.12: [aaafd17d3f4be2c15539359a5b4bfa00237f687f]

CVE-2025-68318: clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68318

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by ae81b69 ("clk: thead: Add support for
T-Head TH1520 AP_SUBSYS clocks") in 6.11-rc1.

Fixed status
mainline: [c567bc5fc68c4388c00e11fc65fd14fe86b52070]

CVE-2025-68319: netconsole: Acquire su_mutex before navigating configs hierarchy

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68319

Introduced by commit df03f83 ("net: netconsole: cache userdata
formatted string in netconsole_target") in v6.9-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7d2fcf7ae31471b4e08b7e448b8fd0ec2e06a1b]

CVE-2025-68320: lan966x: Fix sleeping in atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68320

Introduced by commit 12c2d0a ("net: lan966x: add ethtool configuration
and statistics") in v5.17-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0216721ce71252f60d89af49c8dff613358058d3]
stable/6.12: [c8ab03aa5bd9fd8bfe5d9552d8605826759fdd4d]
stable/6.6: [5a5d2f7727752b64d13263eacd9f8d08a322e662]

CVE-2025-68321: page_pool: always add GFP_NOWARN for ATOMIC allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68321

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by ff7d6b2 ("page_pool: refurbish version of
page_pool code") in 4.18-rc1.

Fixed status
mainline: [f3b52167a0cb23b27414452fbc1278da2ee884fc]
stable/5.15: [0ec2cd5c58793d0c622797cd5fbe26634b357210]
stable/6.1: [9835a0fd59a1df5ec0740fdab6d50db68e0f10de]
stable/6.12: [3671a0775952026228ae44e096eb144bca75f8dc]
stable/6.6: [7613c06ffa89c1e2266fb532e23ef7dfdf269d73]

CVE-2025-68322: parisc: Avoid crash due to unaligned access in unwinder

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68322

Introduced commit is not determined.Fixed in v6.18-rc5.


Fixed status
mainline: [fd9f30d1038ee1624baa17a6ff11effe5f7617cb]
stable/6.12: [9ac1f44723f26881b9fe7e69c7bc25397b879155]


* Updated CVEs
CVE-2025-40215: xfrm: delete x->tunnel as we delete x

stable/6.12 was fixed.

Fixed status
stable/6.12: [dc3636912d41770466543623cb76e7b88fdb42c7]

CVE-2025-40256: xfrm: also call xfrm_state_delete_tunnel at destroy
time for states that were never added

stable/6.12 was fixed.

Fixed status
stable/6.12: [f7d879c19d306512c2e260f37e8a3e5c85e37c50]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

