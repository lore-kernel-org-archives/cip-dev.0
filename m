Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A202C64EC4
	for <webhook@archiver.kernel.org>; Wed,  8 Mar 2023 23:53:57 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web11.943.1678319631146861730
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Mar 2023 15:53:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=UN15zdsc;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f169.google.com with SMTP id q15so369484oiw.11
        for <cip-dev@lists.cip-project.org>; Wed, 08 Mar 2023 15:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1678319630;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6dZX/phw5bCyNYD8P/N63ZR52qE6gUROGFXgSzbziS0=;
        b=UN15zdscI/fhy10jMQYoI5nIBQx+oaOi7QX7iGz0LPIlV4x/tTvJnRlYn3byPdunBm
         opi8AyslP/TFWermOGQGLi3ZfHOFc1uT1Tguf2Yza2BAvMLDMm03v+KEMfKeOuST4l7a
         Jw2/jf5rH0iZPb/hXvCzpTGGPz5jW4OzM9jdbXTTwMFjHANDCsjW/UKu36zLLYfiAJLW
         B13QELPyZKWeTcGbBjamSa4US2mb8/DCRRuzLebzdatCrXJ5L/+y+s2o0K1XhOjcyjfw
         Rvphc5FIBS3zAUyhTwrx1AHnRzWFHwZ0hKWv+OZ3/iBOd0oOt9EJIDU+EBTjzTlt5xg6
         67BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678319630;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dZX/phw5bCyNYD8P/N63ZR52qE6gUROGFXgSzbziS0=;
        b=ORwuDqOiYv5PXhcTblLiYJnGluZxD396xqxH1bq3JHGs+Ms5yNjMgfiB6CwApnfrMp
         AhKHBzDcLtOROuAhIgati9rXPXvCbhJsuFrW3VL5yZRSHUArHTlUJAtItAZUHGHsuvP9
         N6iQrNQ2PcuWw6sY4VqPU5HPKKwvi7aEcET4SMWsENO/oW8gDHQfuj4qr6GxHXuCHZ1z
         yGAK2S555Ide6+7sycOkoL/4vasU3BSQy29NIvwPlYuB4fmvHM3F8agV3aNCrzDDU8Q+
         3pjSUXhjrMJPhrOMU463D6Y7Z6R2EqraEyQTnr76yDBTu0ivOVTVpkKb8fZ/6drtxxST
         rPnA==
X-Gm-Message-State: AO0yUKVeC3k/5fdtWadc0ZTn68wyCyzEHvYBEHHFiUmlGBKg8cfgFgdc
	eRudnCeUfkHYBZU/0XYX1c98Zm4b70tuLRoCRi31JPN4ugAJHcf18lg=
X-Google-Smtp-Source: AK7set9ebKtBgjchKiSj9dtvpLMqSZUvUFzEqUcKHtKzZHSw35GwsHvpd3y56jCOId7zNZEOQjFiJL420P8OPPz1baU=
X-Received: by 2002:a05:6808:994:b0:37f:a0a1:bda1 with SMTP id
 a20-20020a056808099400b0037fa0a1bda1mr6697185oic.3.1678319629466; Wed, 08 Mar
 2023 15:53:49 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Mar 2023 08:53:13 +0900
Message-ID: <CAODzB9odjOOprcdZrLRODAFGmagntFM1dfguLy1GamkEw==fgw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Mar 2023 23:53:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10952

Hi !

It's this week's CVE report.

This week reported 11 new CVEs and 4 updated CVEs.

* New CVEs

CVE-2023-23002: Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL check
in qca_serdev_probe

CVSS v3 score is not provided.

In the Linux kernel before 5.16.3, drivers/bluetooth/hci_qca.c
misinterprets the devm_gpiod_get_index_optional return
value (expects it to be NULL in the error case, whereas it is actually
an error pointer).

Introduced by commit 77131df ("Bluetooth: hci_qca: Replace
devm_gpiod_get() with devm_gpiod_get_optional()") in 5.7-rc1
so that before 5.7 kernels aren't affected by this issue.

Fixed status
mainline: [6845667146a28c09b5dfc401c1ad112374087944]
stable/5.10: [4579954bf4cc0bdfc4a42c88b16fe596f1e7f82d]
stable/5.15: [9186e6ba52af11ba7b5f432aa2321f36e00ad721]

CVE-2023-23003: perf expr: Fix missing check for return value of hashmap__new()

CVSS v3 score is not provided.

In the Linux kernel before 5.16, tools/perf/util/expr.c lacks a check
for the hashmap__new return value.
Introduced by commit cb94a02 ("perf metric: Restructure struct
expr_parse_ctx.") in 5.16-rc1 so that
before 5.16 kernels aren't affected by this issue.

Fixed status
mainline: [0a515a06c5ebfa46fee3ac519e418f801e718da4]

CVE-2023-23004: malidp: Fix NULL vs IS_ERR() checking

CVSS v3 score is not provided.

In the Linux kernel before 5.19, drivers/gpu/drm/arm/malidp_planes.c
misinterprets the get_sg_table return value (expects it to be NULL in
the error case, whereas it is actually an error pointer).

Introduced by commit 1f23a56 ("drm/malidp: Enable MMU prefetch on
Mali-DP650") in 4.20-rc1 so that before 4.20 kernels aren't
affeceted by this issue.

Fixed status
mainline: [15342f930ebebcfe36f2415049736a77d7d2e045]

CVE-2023-23005: mm/demotion: fix NULL vs IS_ERR checking in memory_tier_init

CVSS v3 score is not provided.

** DISPUTED ** In the Linux kernel before 6.2, mm/memory-tiers.c
misinterprets the alloc_memory_type return value (expects it to be
NULL in the error case, whereas it is actually an error pointer).
NOTE: this is disputed by third parties because there are no realistic
cases in which a user can cause the alloc_memory_type error case to be
reached.

Introduced by commit 7b88bda ("mm/demotion/dax/kmem: set node's
abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE") in 6.1-rc1
so before 6.1 kernels are not affected by this issue.

Fixed status
mainline: [4a625ceee8a0ab0273534cb6b432ce6b331db5ee]

CVE-2023-23006: net/mlx5: DR, Fix NULL vs IS_ERR checking in
dr_domain_init_resources

CVSS v3 score is not provided.

In the Linux kernel before 5.15.13,
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
misinterprets the mlx5_get_uars_page return value (expects it to be
NULL in the error case, whereas it is actually an error pointer).

Introduced by commit 4ec9e7b ("net/mlx5: DR, Expose steering domain
functionality") in 5.4-rc1 so that
before 5.4 kernels aren't affected by this issue.

Fixed status
mainline: [6b8b42585886c59a008015083282aae434349094]
stable/5.10: [4cd1da02f0c39606e3378c9255f17d6f85d106c7]
stable/5.15: [4595dffccfa5b9360162c72cc0f6a33477d871cf]
stable/5.4: [db484d35a9482d21a7f36da4dfc7a68aa2e9e1d6]

CVE-2023-1192: use-after-free in smb2_is_status_io_timeout()

CVSS v3 score is not provided.

A use-after-free bug was found in smb2_is_status_io_timeout() in cifs subsystem.

This bug was introduced by commit a848c4f ("cifsd: add Kconfig and
Makefile") in 5.15-rc1.

Fixed status
Not fixed yet

CVE-2023-1193: use-after-free in setup_async_work()

CVSS v3 score is not provided.

A use-after-free in setup_async_work() in cifs subsystem.
This bug was introduced by commit a848c4f ("cifsd: add Kconfig and
Makefile") in 5.15-rc1.
Stable 5.10, 5.4, and 4.x kernels are not affected by this issue.

Fixed status
Not fixed yet

CVE-2023-1194: use-after-free in parse_lease_state()

CVSS v3 score is not provided.

A use-after-free bug was found in parse_lease_state() in cifsd.
This bug was introduced by commit a848c4f ("cifsd: add Kconfig and
Makefile") in 5.15-rc1.
Stable 5.10, 5.4, and 4.x kernels are not affected by this issue.

Fixed status
Not fixed yet

CVE-2023-1195: use-after-free caused by invalid pointer `hostname`

A use-after-free bug was found in cifs subsystem.
Introduced by commit 7be3248 ("cifs: To match file servers, make sure
the server hostname matches") in 5.16-rc1.
This commit was backported to 5.15 so it was affected by this issue.
However, before 5.15 kernels do not contain commit 7be3248
so these kernels are not affected.

Fixed status
mainline: [153695d36ead0ccc4d0256953c751cabf673e621]
stable/5.15: [ee2536830b161d16859b2771effdde6b819c253f]

CVE-2023-1249: coredump: Use the vma snapshot in fill_files_note

CVSS v3 score is not provided.

A use-after-free bug was found in the coredump feature. A missing
mmap_lock in file_files_note() could possibly lead to a use-after-free
bug.

This commit's Fixes tags adresse following commits.
- a07279c ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot") in 5.10-rc1
- 2aa362c ("coredump: extend core dump note section to contain file
names of mapped files") in 3.7-rc1

Fixed status
mainline: [390031c942116d4733310f0684beb8db19885fe6]
stable/5.10: [558564db44755dfb3e48b0d64de327d20981e950]
stable/5.15: [39fd0cc079c98dafcf355997ada7b5e67f0bb10a]

CVE-2023-1252: kernel: ovl: fix use after free in struct ovl_aio_req

CVSS v3 score is not provided.

A use-after-free bug was found in overlayfs. If ext4 file system is
used by ovlfs, a use-after-free could happen as result of a race
condition.
This bug was introduced by commit 2406a30 ("ovl: implement async IO
routines") in 5.16-rc1. This patch was backported to 5.10 and 5.15 so
that both are affected.

Fixed status
mainline: [9a254403760041528bc8f69fe2f5e1ef86950991]
stable/5.10: [4fd9f0509a1452b45e89c668e2bab854cb05cd25]
stable/5.15: [2f372e38f5724301056e005353c8beecc3f8d257]

* Updated CVEs

CVE-2022-4269: kernel: net: CPU soft lockup in TC mirred
egress-to-ingress action

The mainline was fixed.

Fixed status
mainline: [ca22da2fbd693b54dc8e3b7b54ccc9f7e9ba3640]

CVE-2023-22998: drm/virtio: Fix NULL vs IS_ERR checking in
virtio_gpu_object_shmem_init

Stable 5.10 was fixed.

Fixed status
mainline: [c24968734abfed81c8f93dc5f44a7b7a9aecadfa,
64b88afbd92fbf434759d1896a7cf705e1c00e79]
stable/5.10: [0a4181b23acf53e9c95b351df6a7891116b98f9b,
87c647def389354c95263d6635c62ca0de7d12ca]
stable/5.15: [72893aadc0017f0f2998b33e7fa5e6b3a3a72d02,
60630834fad38252369bf4a351a03b75b76786e3]

CVE-2023-26605: KASAN: use-after-free Read in inode_cgwb_move_to_attached

The mainline and stable 5.15 were fixed.

Fixed status
mainline: [4e3c51f4e805291b057d12f5dda5aeb50a538dc4]
stable/5.15: [8ce9b1c97fcec906c3386277a33da19e240c3624]

CVE-2023-26607: KASAN: slab-out-of-bounds Read in ntfs_attr_find

This bug was fixed by commit 36a4d82 ("ntfs: fix out-of-bounds read in
ntfs_attr_find()") in 6.1-rc1. so, the mainline and all stable kernels
are fixed.

The mainline, 4.1
Fixed status
mainline: [36a4d82dddbbd421d2b8e79e1cab68c8126d5075]
stable/4.14: [801906eea32d9781725905271a1d4ab275743fc9]
stable/4.19: [4301aa833a734257ad3715f607cbde17402eda94]
stable/5.10: [6322dda483344abe47d17335809f7bbb730bd88b]
stable/5.15: [ab6a1bb17e3c2f6670020d7edeea2fbfe6466690]
stable/5.4: [0e2ce0954b39c8d60928f61217b72f352722a2cf]

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

