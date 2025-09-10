Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA55CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 22:31:45 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web10.32315.1757543497540403223
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Sep 2025 15:31:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=G6emq3Py;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.180, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e970e624b7cso1128347276.0
        for <cip-dev@lists.cip-project.org>; Wed, 10 Sep 2025 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1757543496; x=1758148296; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xtZmvy6fVTSI2KAw5DZCLqWFmlmBvpmmRWztkg8IuCc=;
        b=G6emq3PyFYrBnz+leA4DPiNmOBbTWnYeF64po/1zFYvqk+fxf9lK9oBRHy5+eR99PU
         Es3g4eSMYZdfuTdBMuZJhobeY7sebVpznvhw4deRyJgNEOa4CKlROE5GZkTy7wjQYUKM
         /eK2oSnmIhQ2lMZtjBla2JOHcXEkyoBegefD3Ow90PumGHSXVi2GiyWmhbuwIEiojnfU
         ouS6ETX4gQ3dwQgdgAFCSBplJ08woLYV+duDMIpaBMWq1IaesGJm5YuqAanzqxCwGi0S
         23/X8jbn3uvXNFNVebDtp1Kq8wTRzS10ivQEuKIqzZWiVRZH6zQBdFoVypyt7Y/UUngQ
         6DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757543496; x=1758148296;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtZmvy6fVTSI2KAw5DZCLqWFmlmBvpmmRWztkg8IuCc=;
        b=miMDJFyGOM+2pFpW4h3Fo/Igcc3Yr0SyIsvIi4ZaDjJy3Nckdl04gmMVZsW3icTLSk
         GEupSVYsBH+MR/r0enaMaJ2crwbR8VMx90m8Mgnlh9bKmT7a6+0gVm2uphdlvLbXru0E
         9Pmj5DI9nb5P/y3GwBuRNb2PoV/hG+vDBmeW/hOCsZObaj207zg2dcXMLwKNjmkX7lbR
         ayAvKS3YCpV7ncbOaQ8ENcBG8MfcgjV0oHpLxsmCoTDeWGDNM1exsI6mOBYVjuM5inXl
         7i18itB9AZVxl7Y+xpt1x7liDvcSuheJG6ebcfKgQKLNDSt2VeJw855ei6+7+tmZiThW
         stMg==
X-Gm-Message-State: AOJu0YwAWVxAZ7A/DBjki1X2QAha3Sy9tOoA1VqtcxGOQDHBkCTC/yOs
	Ky66AdkMTKJccuZGcVHGtX+pOkq9Y4oawLsccd9DpwLXioSTH3dw4GmofbNJZWEBe/L+75icyZ3
	E7cXi6YbDh1PTR+f5LMlhyH9AhxrNr3x7hEuyESZY5dyOR/PIeNrhsS8=
X-Gm-Gg: ASbGncvYvFQH+AWdMRMDkRwu2pR0n9YYNHhWkgCmCBa4qHP+MASMQ/6wfllvaZWAxoT
	z8SfcNGFtOQOPHx/K3m73UwmlaZoJE05ifcElOxNizXzG2T8RcKRz9YhDDU/nbSYqALB/+n768L
	N6S8y6DSLskOy9TSWIT9snErP3deNqygkfglILB+/wud0U7H9yP8/Y+knXi73NaYwKSav3WGmtW
	MysGDEyS161sM5gOVo=
X-Google-Smtp-Source: AGHT+IGm/ctLE6x/vQ5sNhW5qOZWfFlgwhTl6Xe+lW+9d22IKuBk2no/lvR60zG5bIAf1Nz3eVwrLPdOlLGj+qyQbVo=
X-Received: by 2002:a05:690c:8d07:b0:71c:1ad7:9953 with SMTP id
 00721157ae682-72eeb1ee9e7mr12273247b3.2.1757543494621; Wed, 10 Sep 2025
 15:31:34 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Sep 2025 07:30:58 +0900
X-Gm-Features: Ac12FXw-3CEIr4NwKxTnx71wQJapjvw-75WmaHdGOrCCJOiE0lNqS8E3-Gy3zBE
Message-ID: <CAODzB9pZu5rg4+GviH9bFR3WaY1bYH5w-q2n9+evLoAuYSO_Mw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Sep 2025 22:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20036

Hi!

It's this week's CVE report.

This week reported 118 new CVEs and 18 updated CVEs.

* New CVEs
CVE-2025-38679: media: venus: Fix OOB read due to missing payload bound check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38679

Introduced by commit 09c2845 ("[media] media: venus: hfi: add Host
Firmware Interface (HFI)") in v4.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06d6770ff0d8cc8dfd392329a8cc03e2a83e7289]
stable/6.1: [a3eef5847603cd8a4110587907988c3f93c9605a]
stable/6.12: [6f08bfb5805637419902f3d70069fe17a404545b]
stable/6.6: [8f274e2b05fdae7a53cee83979202b5ecb49035c]

CVE-2025-38680: media: uvcvideo: Fix 1-byte out-of-bounds read in
uvc_parse_format()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38680

Introduced by commit c0efd23 ("V4L/DVB (8145a): USB Video Class
driver") in v2.6.26-rc9.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [782b6a718651eda3478b1824b37a8b3185d2740c]
stable/5.10: [1e269581b3aa5962fdc52757ab40da286168c087]
stable/5.15: [8343f3fe0b755925f83d60b05e92bf4396879758]
stable/5.4: [9ad554217c9b945031c73df4e8176a475e2dea57]
stable/6.1: [ffdd82182953df643aa63d999b6f1653d0c93778]
stable/6.12: [cac702a439050df65272c49184aef7975fe3eff2]
stable/6.6: [a97e062e4ff3dab84a2f1eb811e9eddc6699e2a9]

CVE-2025-38681: mm/ptdump: take the memory hotplug lock inside ptdump_walk_pgd()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38681

Introduced by commit bbd6ec6 ("arm64/mm: Enable memory hot remove") in v5.7-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59305202c67fea50378dcad0cc199dbc13a0e99a]
stable/5.10: [3ee9a8c27bfd72c3f465004fa8455785d61be5e8]
stable/5.15: [69bea84b06b5e779627e7afdbf4b60a7d231c76f]
stable/6.1: [ac25ec5fa2bf6e606dc7954488e4dded272fa9cd]
stable/6.12: [ff40839e018b82c4d756d035f34a63aa2d93be83]
stable/6.6: [1636b5e9c3543b87d673e32a47e7c18698882425]

CVE-2025-38682: i2c: core: Fix double-free of fwnode in i2c_unregister_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38682

Introduced by commit df6d727 ("i2c: core: Do not dereference fwnode in
struct device") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c24e5fc0c7096e00c202a6a3e0c342c1afb47c2]

CVE-2025-38683: hv_netvsc: Fix panic during namespace deletion with VF

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38683

Introduced by commit 4c26280 ("hv_netvsc: Fix VF namespace also in
synthetic NIC NETDEV_REGISTER event") in v6.12-rc5.
Fixed in v6.17-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [33caa208dba6fa639e8a92fd0c8320b652e5550c]
stable/5.10: [3ca41ab55d23a0aa71661a5a56a8f06c11db90dc]
stable/5.15: [3467c4ebb334658c6fcf3eabb64a6e8b2135e010]
stable/6.1: [4eff1e57a8ef98d70451b94e8437e458b27dd234]
stable/6.12: [d036104947176d030bec64792d54e1b4f4c7f318]
stable/6.6: [2a70cbd1aef8b8be39992ab7b776ce1390091774]

CVE-2025-38684: net/sched: ets: use old 'nbands' while purging unused classes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38684

Introduced by commit 103406b ("net/sched: Always pass notifications
when child class becomes empty") in v6.16-rc5.
Introduced by commit c062f2a ("net/sched: sch_ets: don't remove idle
classes from the round-robin list") in v5.16-rc6.
Introduced by commit dcc68b4 ("net: sch_ets: Add a new Qdisc") in v5.6-rc1.
Fixed in v6.17-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.12 stable/5.10 stable/5.15 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [87c6efc5ce9c126ae4a781bc04504b83780e3650]
stable/5.10: [bdfddcde86e8b9245d9c0c2efe2b6fe8dcf6bf41]
stable/5.15: [be9692dafdfb36d9c43afd9d4e1d9d9ba8e7b51b]
stable/6.1: [97ec167cd2e8a81a2d87331a2ed92daf007542c8]
stable/6.12: [5b3b346bc4c2aa2c428735438a11989d251f32f1]
stable/6.6: [84a24fb446ee07b22b64aae6f0e3f4a38266310a]

CVE-2025-38685: fbdev: Fix vmalloc out-of-bounds write in fast_imageblit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38685

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [af0db3c1f898144846d4c172531a199bb3ca375d]
stable/5.15: [078e62bffca4b7e72e8f3550eb063ab981c36c7a]
stable/6.1: [4c4d7ddaf1d43780b106bedc692679f965dc5a3a]
stable/6.12: [ed9b8e5016230868c8d813d9179523f729fec8c6]
stable/6.6: [27b118aebdd84161c8ff5ce49d9d536f2af10754]

CVE-2025-38686: userfaultfd: fix a crash in UFFDIO_MOVE when PMD is a
migration entry

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38686

Introduced by commit adef440 ("userfaultfd: UFFDIO_MOVE uABI") in v6.8-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aba6faec0103ed8f169be8dce2ead41fcb689446]
stable/6.12: [bb81c18dbd42650c844e160cafa7cbb20243a96a]

CVE-2025-38687: comedi: fix race between polling and detaching

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38687

Introduced by commit 2f3fdcd ("staging: comedi: add rw_semaphore to
protect against device detachment") in v3.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35b6fc51c666fc96355be5cd633ed0fe4ccf68b2]
stable/5.10: [cd4286123d6948ff638ea9cd5818ae4796d5d252]
stable/5.15: [d85fac8729c9acfd72368faff1d576ec585e5c8f]
stable/5.4: [fe67122ba781df44a1a9716eb1dfd751321ab512]
stable/6.1: [0f989f9d05492028afd2bded4b42023c57d8a76e]
stable/6.12: [017198079551a2a5cf61eae966af3c4b145e1f3b]
stable/6.6: [5c4a2ffcbd052c69bbf4680677d4c4eaa5a252d4]

CVE-2025-38688: iommufd: Prevent ALIGN() overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38688

Introduced by commit 51fe614 ("iommufd: Data structure to provide IOVA
to PFN mapping") in v6.2-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b42497e3c0e74db061eafad41c0cd7243c46436b]
stable/6.12: [ebb6021560b94649bec6b8faba6fe0dca2218e81]
stable/6.6: [d19b817540c0abe84854a64ee9ee34cecc3bbeef]

CVE-2025-38689: x86/fpu: Fix NULL dereference in avx512_status()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38689

Introduced by commit 22aafe3 ("x86/fpu: Remove init_task FPU state
dependencies, add debugging warning for PF_KTHREAD tasks") in
v6.16-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31cd31c9e17ece125aad27259501a2af69ccb020]

CVE-2025-38690: drm/xe/migrate: prevent infinite recursion

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38690

Introduced by commit 270172f ("drm/xe: Update xe_ttm_access_memory to
use GPU for non-visible access") in v6.16-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d7a1cbebbb691891671def57407ba2f8ee914e8]

CVE-2025-38691: pNFS: Fix uninited ptr deref in block/scsi layout

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38691

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by 34dc93c ("pnfs/blocklayout: allocate
  separate pages for the layoutcommit payload") in 3.18-rc1.

Fixed status
mainline: [9768797c219326699778fba9cd3b607b2f1e7950]
stable/5.10: [2896f101110076ac6bf99d7aaf463d61e26f89dd]
stable/5.15: [4f783333cbfa2ee7d4aa8e47f6bd1b3f77534fcf]
stable/5.4: [579b85f893d9885162e1cabf99a4a088916e143e]
stable/6.1: [9be5c04beca3202d0a5f09fb4b2ecb644caa0bc5]
stable/6.12: [f0b2eee3fbba9b7e3746ef698424ef5e4a197776]
stable/6.6: [24334f3cf8a294f253071b5bf22d754dbb6d0f2d]

CVE-2025-38692: exfat: add cluster chain loop check for dir

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38692

Introduced commit is not determined.Fixed in v6.17-rc1.
Introduced by 1acf1a5 ("exfat: add in-memory and on-disk structures
and headers") in 5.7-rc1.

Fixed status
mainline: [99f9a97dce39ad413c39b92c90393bbd6778f3fd]
stable/6.12: [aa8fe7b7b73d4c9a41bb96cb3fb3092f794ecb33]
stable/6.6: [868f23286c1a13162330fa6c614fe350f78e3f82]

CVE-2025-38693: media: dvb-frontends: w7090p: fix null-ptr-deref in
w7090p_tuner_write_serpar and w7090p_tuner_read_serpar

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38693

Introduced commit is not determined.Fixed in v6.17-rc1.
Affected functions were added by 713d54a ("[media] DiB7090: add support
  for the dib7090 based") in 2.6.39-rc1.

Fixed status
mainline: [ed0234c8458b3149f15e496b48a1c9874dd24a1b]
stable/5.10: [b3d77a3fc71c084575d3df4ec6544b3fb6ce587d]
stable/5.15: [17b30e5ded062bd74f8ca6f317e1d415a8680665]
stable/5.4: [7a41ecfc3415ebe3b4c44f96b3337691dcf431a3]
stable/6.1: [454a443eaa792c8865c861a282fe6d4f596abc3a]
stable/6.12: [f98132a59ccc59a8b97987363bc99c8968934756]
stable/6.6: [6bbaec6a036940e22318f0454b50b8000845ab59]

CVE-2025-38694: media: dvb-frontends: dib7090p: fix null-ptr-deref in
dib7090p_rw_on_apb()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38694

Introduced commit is not determined.Fixed in v6.17-rc1.
Affected function was added by 713d54a ("[media] DiB7090: add support for
  the dib7090 based") in 2.6.39-rc1.

Fixed status
mainline: [ce5cac69b2edac3e3246fee03e8f4c2a1075238b]
stable/5.10: [ce8b7c711b9c4f040b5419729d0972db8e374324]
stable/5.15: [529fd5593b721e6f4370c591f5086649ed149ff6]
stable/5.4: [bc07cae4f36bb18d5b6a9ed835c1278ca44ec82e]
stable/6.1: [c33280d6bd668dbdc5a5f07887cc63a52ab4789c]
stable/6.12: [0bb32863426afe0badac25c28d59021f211d0f48]
stable/6.6: [09906650484a09b3a4d4b3d3065395856810becd]

CVE-2025-38695: scsi: lpfc: Check for hdwq null ptr when cleaning up
lpfc_vport structure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38695

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [6698796282e828733cde3329c887b4ae9e5545e9]
stable/5.10: [74bdf54a847dab209d2a8f65852f59b7fa156175]
stable/5.15: [5e25ee1ecec91c61a8acf938ad338399cad464de]
stable/5.4: [6711ce7e9de4eb1a541ef30638df1294ea4267f8]
stable/6.1: [add68606a01dcccf18837a53e85b85caf0693b4b]
stable/6.12: [571617f171f723b05f02d154a2e549a17eab4935]
stable/6.6: [7925dd68807cc8fd755b04ca99e7e6f1c04392e8]

CVE-2025-38696: MIPS: Don't crash in stack_top() for tasks without ABI or vDSO

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38696

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable logic was added by ea7e0480 ("MIPS: VDSO: Always map near top
  of user memory") in 4.19-rc8.

Fixed status
mainline: [e9f4a6b3421e936c3ee9d74710243897d74dbaa2]
stable/5.10: [e78033e59444d257d095b73ce5d20625294f6ec2]
stable/5.15: [bd90dbd196831f5c2620736dc221db2634cf1e8e]
stable/5.4: [ab18e48a503230d675e824a0d68a108bdff42503]
stable/6.1: [5b6839b572b503609b9b58bc6c04a816eefa0794]
stable/6.12: [82d140f6aab5e89a9d3972697a0dbe1498752d9b]
stable/6.6: [f22de2027b206ddfb8a075800bb5d0dacf2da4b8]

CVE-2025-38697: jfs: upper bound check of tree index in dbAllocAG

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38697

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if this bug was introduced in 2.6.12 or prior version.

Fixed status
mainline: [c214006856ff52a8ff17ed8da52d50601d54f9ce]
stable/5.10: [a4f199203f79ca9cd7355799ccb26800174ff093]
stable/5.15: [1467a75819e41341cd5ebd16faa2af1ca3c8f4fe]
stable/5.4: [5bdb9553fb134fd52ec208a8b378120670f6e784]
stable/6.1: [49ea46d9025aa1914b24ea957636cbe4367a7311]
stable/6.12: [c8ca21a2836993d7cb816668458e05e598574e55]
stable/6.6: [173cfd741ad7073640bfb7e2344c2a0ee005e769]

CVE-2025-38698: jfs: Regular file corruption check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38698

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if this bug was introduced in 2.6.12 or prior version.

Fixed status
mainline: [2d04df8116426b6c7b9f8b9b371250f666a2a2fb]
stable/5.10: [6bc86f1d7d5419d5b19483ba203ca0b760c41c51]
stable/5.15: [9ad054cd2c4ca8c371e555748832aa217c41fc65]
stable/5.4: [9f896c3d0192241d6438be6963682ace8203f502]
stable/6.1: [9605cb2ea38ba014d0e704cba0dbbb00593fa9fd]
stable/6.12: [00462be586b33076f8b8023e7ba697deedc131db]
stable/6.6: [78989af5bbf55a0cf1165b0fa73921bc02f1543b]

CVE-2025-38699: scsi: bfa: Double-free fix

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38699

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by 7725ccf ("[SCSI] bfa: Brocade BFA FC SCSI
  driver") in 2.6.32-rc4.

Fixed status
mainline: [add4c4850363d7c1b72e8fce9ccb21fdd2cf5dc9]
stable/5.10: [9337c2affbaebe00b75fdf84ea0e2fcf93c140af]
stable/5.15: [ba024d92564580bb90ec367248ace8efe16ce815]
stable/5.4: [684c92bb08a25ed3c0356bc7eb532ed5b19588dd]
stable/6.1: [8e03dd9fadf76db5b9799583074a1a2a54f787f1]
stable/6.12: [13f613228cf3c96a038424cd97aa4d6aadc66294]
stable/6.6: [39cfe2c83146aad956318f866d0ee471b7a61fa5]

CVE-2025-38700: scsi: libiscsi: Initialize iscsi_conn->dd_data only if
memory is allocated

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38700

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if this bug was introduced by 5d91e20 ("[SCSI] iscsi:
remove session/conn_data_size from iscsi_transport") in 2.6.27-rc1.

Fixed status
mainline: [3ea3a256ed81f95ab0f3281a0e234b01a9cae605]
stable/5.10: [9ea6d961566c7d762ed0204b06db05756fdda3b6]
stable/5.15: [fd5aad080edb501ab5c84b7623d612d0e3033403]
stable/5.4: [f53af99f441ee79599d8df6113a7144d74cf9153]
stable/6.1: [a145c269dc5380c063a20a0db7e6df2995962e9d]
stable/6.12: [35782c32528d82aa21f84cb5ceb2abd3526a8159]
stable/6.6: [66a373f50b4249d57f5a88c7be9676f9d5884865]

CVE-2025-38701: ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38701

Introduced commit is not determined.Fixed in v6.17-rc1.
The ext4_create_inline_data and ext4_update_inline_data were added by
67cf5b0 ("ext4: add the basic function for inline data support") in
3.8-rc1. The ext4_inline_data_truncate was added by aef1c85 ("ext4:
let ext4_truncate handle inline data correctly") in 3.8-rc1.

Fixed status
mainline: [099b847ccc6c1ad2f805d13cfbcc83f5b6d4bc42]
stable/5.10: [1199a6399895f4767f0b9a68a6ff47c3f799b7c7]
stable/5.15: [7f322c12df7aeed1755acd3c6fab48c7807795fb]
stable/5.4: [8085a7324d8ec448c4a764af7853e19bbd64e17a]
stable/6.1: [2817ac83cb4732597bf36853fe13ca616f4ee4e2]
stable/6.12: [81e7e2e7ba07e7c8cdce43ccad2f91adbc5a919c]
stable/6.6: [d960f4b793912f35e9d72bd9d1e90553063fcbf1]

CVE-2025-38702: fbdev: fix potential buffer overflow in
do_register_framebuffer()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38702

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if this bug was added in 2.6.12-rc2 or before.

Fixed status
mainline: [523b84dc7ccea9c4d79126d6ed1cf9033cf83b05]
stable/6.1: [5c3f5a25c62230b7965804ce7a2e9305c3ca3961]
stable/6.12: [806f85bdd3a60187c21437fc51baace11f659f35]
stable/6.6: [cbe740de32bb0fb7a5213731ff5f26ea6718fca3]

CVE-2025-38703: drm/xe: Make dma-fences compliant with the safe access rules

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38703

Introduced commit is not determined.Fixed in v6.17-rc1.
Affected driver was added by dd08ebf ("drm/xe: Introduce a new DRM
driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [6bd90e700b4285e6a7541e00f969cab0d696adde]
stable/6.12: [b17fcce70733c211cb5dabf54f4f9491920b1d92]

CVE-2025-38704: rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
pointer access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38704

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if vulnerable logic was added by 3a5761dc ("rcu/nocb: Fix
NOCB kthreads spawn failure with rcu_nocb_rdp_deoffload() direct
call") in 6.0-rc1.

Fixed status
mainline: [1bba3900ca18bdae28d1b9fa10f16a8f8cb2ada1]
stable/6.12: [cce3d027227c69e85896af9fbc6fa9af5c68f067]

CVE-2025-38705: drm/amd/pm: fix null pointer access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38705

Introduced commit is not determined.Fixed in v6.17-rc1.
The amdgpu_set_pp_power_profile_mode was added by 37c5c4d
("drm/amdgpu: add custom power policy support in sysfs") in 4.17-rc1.
The parse_input_od_command_lines was added by d7bf1b5 ("drm/amd/pm:
add fan temperature/pwm curve OD setting support for SMU13") in
6.7-rc1.

Fixed status
mainline: [d524d40e3a6152a3ea1125af729f8cd8ca65efde]
stable/6.12: [a83ffafd02a7af59848755c109d544e3894af737]

CVE-2025-38706: ASoC: core: Check for rtd == NULL in
snd_soc_remove_pcm_runtime()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38706

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [2d91cb261cac6d885954b8f5da28b5c176c18131]
stable/5.10: [8b465bedc2b417fd27c1d1ab7122882b4b60b1a0]
stable/5.15: [82ba7b8cf9f6e3bf392a9f08ba3d1c0b200ccb94]
stable/6.1: [7f8fc03712194fd4e2df28af7f7f7a38205934ef]
stable/6.12: [2fce20decc6a83f16dd73744150c4e7ea6c97c21]
stable/6.6: [41f53afe53a57a7c50323f99424b598190acf192]

CVE-2025-38707: fs/ntfs3: Add sanity check for file name

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38707

Introduced commit is not determined.Fixed in v6.17-rc1.
Introduced by 4534a70 ("fs/ntfs3: Add headers and misc files") in 5.15-rc1.

Fixed status
mainline: [e841ecb139339602bc1853f5f09daa5d1ea920a2]
stable/5.15: [bde58c1539f3ffddffc94d64007de16964e6b8eb]
stable/6.1: [f99eb9a641f4ef927d8724f4966dcfd1f0e9f835]
stable/6.12: [2ac47f738ddfc1957a33be163bc97ee8f78e85a6]
stable/6.6: [3572737a768dadea904ebc4eb34b6ed575bb72d9]

CVE-2025-38708: drbd: add missing kref_get in handle_write_conflicts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38708

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [00c9c9628b49e368d140cfa61d7df9b8922ec2a8]
stable/5.10: [810cd546a29bfac90ed1328ea01d693d4bd11cb1]
stable/5.15: [84ef8dd3238330d1795745ece83b19f0295751bf]
stable/5.4: [0336bfe9c237476bd7c45605a36ca79c2bca62e5]
stable/6.1: [57418de35420cedab035aa1da8a26c0499b7f575]
stable/6.12: [7d483ad300fc0a06f69b019dda8f74970714baf8]
stable/6.6: [9f53b2433ad248cd3342cc345f56f5c7904bd8c4]

CVE-2025-38709: loop: Avoid updating block size under exclusive owner

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38709

Introduced commit is not determined.Fixed in v6.17-rc1.
The loop_set_block_size was added by 89e4fde ("loop: add ioctl for changing
logical block size") in 4.14-rc1.

Fixed status
mainline: [7e49538288e523427beedd26993d446afef1a6fb]
stable/6.12: [139a000d20f2f38ce34296feddd641d730fe1c08]
stable/6.6: [ce8da5d13d8c2a7b30b2fb376a22e8eb1a70b8bb]

CVE-2025-38710: gfs2: Validate i_depth for exhash directories

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38710

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [557c024ca7250bb65ae60f16c02074106c2f197b]
stable/6.12: [53a0249d68a210c16e961b83adfa82f94ee0a53d]

CVE-2025-38711: smb/server: avoid deadlock when linking with ReplaceIfExists

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38711

Introduced commit is not determined.Fixed in v6.17-rc1.
Introduced by 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in 5.15-rc1.

Fixed status
mainline: [d5fc1400a34b4ea5e8f2ce296ea12bf8c8421694]
stable/5.15: [9d5012ffe14120f978ee34aef4df3d6cb026b7c4]
stable/6.1: [ac98d54630d5b52e3f684d872f0d82c06c418ea9]
stable/6.12: [814cfdb6358d9b84fcbec9918c8f938cc096a43a]
stable/6.6: [1e858a7a51c7b8b009d8f246de7ceb7743b44a71]

CVE-2025-38712: hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38712

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable code was added by 95e0d7d ("hfsplus: implement attributes
file creation functionality") in 3.13-rc1.

Fixed status
mainline: [c7c6363ca186747ebc2df10c8a1a51e66e0e32d9]
stable/5.10: [9046566fa692f88954dac8c510f37ee17a15fdb7]
stable/5.15: [03cd1db1494cf930e2fa042c9c13e32bffdb4eba]
stable/5.4: [bb0eea8e375677f586ad11c12e2525ed3fc698c2]
stable/6.1: [dee5c668ad71ddbcb4b48d95e8a4f371314ad41d]
stable/6.12: [1bb8da27ff15e346d4bc9e248e819c9a88ebf9d6]
stable/6.6: [b3359392b75395a31af739a761f48f4041148226]

CVE-2025-38713: hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38713

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if this bug was introduced in 2.6.12-rc2 or before.

Fixed status
mainline: [94458781aee6045bd3d0ad4b80b02886b9e2219b]
stable/5.10: [76a4c6636a69d69409aa253b049b1be717a539c5]
stable/5.15: [ccf0ad56a779e6704c0b27f555dec847f50c7557]
stable/5.4: [73f7da507d787b489761a0fa280716f84fa32b2f]
stable/6.1: [13604b1d7e7b125fb428cddbec6b8d92baad25d5]
stable/6.12: [f7534cbfac0a9ffa4fa17cacc6e8b6446dae24ee]
stable/6.6: [291bb5d931c6f3cd7227b913302a17be21cf53b0]

CVE-2025-38714: hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38714

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if this bug was introduced in 2.6.12-rc2 or before.

Fixed status
mainline: [c80aa2aaaa5e69d5219c6af8ef7e754114bd08d2]
stable/5.10: [ffee8a7bed0fbfe29da239a922b59c5db897c613]
stable/5.15: [5ab59229bef6063edf3a6fc2e3e3fd7cd2181b29]
stable/5.4: [032f7ed6717a4cd3714f9801be39fdfc7f1c7644]
stable/6.1: [a2abd574d2fe22b8464cf6df5abb6f24d809eac0]
stable/6.12: [475d770c19929082aab43337e6c077d0e2043df3]
stable/6.6: [8583d067ae22b7f32ce5277ca5543ac8bf86a3e5]

CVE-2025-38715: hfs: fix slab-out-of-bounds in hfs_bnode_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38715

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [a431930c9bac518bf99d6b1da526a7f37ddee8d8]
stable/5.10: [67ecc81f6492275c9c54280532f558483c99c90e]
stable/5.15: [a1a60e79502279f996e55052f50cc14919020475]
stable/5.4: [e7d2dc2421e821e4045775e6dc226378328de6f6]
stable/6.1: [fe2891a9c43ab87d1a210d61e6438ca6936e2f62]
stable/6.12: [efc095b35b23297e419c2ab4fc1ed1a8f0781a29]
stable/6.6: [384a66b89f9540a9a8cb0f48807697dfabaece4c]

CVE-2025-38716: hfs: fix general protection fault in hfs_find_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38716

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [736a0516a16268995f4898eded49bfef077af709]
stable/6.12: [5d8b249527362e0ccafcaf76b3bec2a0d2aa1498]
stable/6.6: [4f032979b63ad52e08aadf0faeac34ed35133ec0]

CVE-2025-38717: net: kcm: Fix race condition in kcm_unattach()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38717

Introduced by commit ab7ac4e ("kcm: Kernel Connection Multiplexor
module") in v4.6-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52565a935213cd6a8662ddb8efe5b4219343a25d]
stable/6.12: [c0bffbc92a1ca3960fb9cdb8e9f75a68468eb308]

CVE-2025-38718: sctp: linearize cloned gso packets in sctp_rcv

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38718

Introduced by commit 90017ac ("sctp: Add GSO support") in v4.8-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd60d8a086191fe33c2d719732d2482052fa6805]
stable/5.10: [03d0cc6889e02420125510b5444b570f4bbf53d5]
stable/5.15: [cd0e92bb2b7542fb96397ffac639b4f5b099d0cb]
stable/5.4: [d0194e391bb493aa6cec56d177b14df6b29188d5]
stable/6.12: [7d757f17bc2ef2727994ffa6d5d6e4bc4789a770]
stable/6.6: [ea094f38d387d1b0ded5dee4a3e5720aa4ce0139]

CVE-2025-38719: net: hibmcge: fix the division by zero issue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38719

Introduced by commit 40735e7 ("net: hibmcge: Implement .ndo_start_xmit
function") in v6.13-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7004b26f0b64331143eb0b312e77a357a11427ce]

CVE-2025-38720: net: hibmcge: fix rtnl deadlock issue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38720

Introduced by commit 3f5a61f ("net: hibmcge: Add reset supported in
this module") in v6.14-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c875503a9b9082928d7d3fc60b5400d16fbfae4e]

CVE-2025-38721: netfilter: ctnetlink: fix refcount leak on table dump

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38721

Introduced by commit d205dc4 ("[NETFILTER]: ctnetlink: fix deadlock in
table dumping") in v2.6.20.16.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de788b2e6227462b6dcd0e07474e72c089008f74]
stable/5.10: [962518c6ca9f9a13df099cafa429f72f68ad61f0]
stable/5.15: [19b909a4b1452fb97e477d2f08b97f8d04095619]
stable/5.4: [586892e341fbf698e7cbaca293e1353957db725a]
stable/6.1: [41462f4cfc583513833f87f9ee55d12da651a7e3]
stable/6.12: [a2cb4df7872de069f809de2f076ec8e54d649fe3]
stable/6.6: [30cf811058552b8cd0e98dff677ef3f89d6d34ce]

CVE-2025-38722: habanalabs: fix UAF in export_dmabuf()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38722

Introduced by commit db1a8dd ("habanalabs: add support for dma-buf
exporter") in v5.16-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33927f3d0ecdcff06326d6e4edb6166aed42811c]
stable/6.12: [c07886761fd6251db6938d4e747002e3d150d231]

CVE-2025-38723: LoongArch: BPF: Fix jump offset calculation in tailcall

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38723

Introduced by commit 5dc6155 ("LoongArch: Add BPF JIT support") in v6.1-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd39d9e6b7e4c58fa77783e7aedf7ada51d02ea3]
stable/6.1: [1a782fa32e644aa9fbae6c8488f3e61221ac96e1]
stable/6.12: [f83d469e16bb1f75991ca67c56786fb2aaa42bea]
stable/6.6: [17c010fe45def335fe03a0718935416b04c7f349]

CVE-2025-38724: nfsd: handle get_client_locked() failure in
nfsd4_setclientid_confirm()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38724

Introduced by commit d20c11d ("nfsd: Protect session creation and
client confirm using client_lock") in v3.17-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [908e4ead7f757504d8b345452730636e298cbf68]
stable/5.10: [d35ac850410966010e92f401f4e21868a9ea4d8b]
stable/5.15: [f3aac6cf390d8b80e1d82975faf4ac61175519c0]
stable/5.4: [3f252a73e81aa01660cb426735eab932e6182e8d]
stable/6.1: [22f45cedf281e6171817c8a3432c44d788c550e1]
stable/6.12: [74ad36ed60df561a303a19ecef400c7096b20306]
stable/6.6: [d71abd1ae4e0413707cd42b10c24a11d1aa71772]

CVE-2025-38725: net: usb: asix_devices: add phy_mask for ax88772 mdio bus

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38725

Introduced by commit e532a09 ("net: usb: asix: ax88772: add phylib
support") in v5.14-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4faff70959d51078f9ee8372f8cff0d7045e4114]
stable/5.15: [75947d3200de98a9ded9ad8972e02f1a177097fe]
stable/6.1: [59ed6fbdb1bc03316e09493ffde7066f031c7524]
stable/6.12: [ee2cd40b0bb46056949a2319084a729d95389386]
stable/6.6: [ccef5ee4adf56472aa26bdd1f821a6d0cd06089a]

CVE-2025-38726: net: ftgmac100: fix potential NULL pointer access in
ftgmac100_phy_disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38726

Introduced by commit e24a6c8 ("net: ftgmac100: Get link speed and
duplex for NC-SI") in v6.12-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e88fbc30dda1cb7438515303704ceddb3ade4ecd]
stable/6.12: [ae59ec969c07c73f0610f8bd7e648f01e798d222]

CVE-2025-38727: netlink: avoid infinite retry looping in netlink_unicast()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38727

Introduced by commit ae8f160 ("netlink: Fix wraparounds of
sk->sk_rmem_alloc.") in v6.16-rc6.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10 cip/6.1
cip/6.12 stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [759dfc7d04bab1b0b86113f1164dc1fec192b859]
stable/5.10: [6bee383ff83352a693d03efdf27cdd80742f71b2]
stable/5.15: [f324959ad47e62e3cadaffa65d3cff790fb48529]
stable/5.4: [47d49fd07f86d1f55ea1083287303d237e9e0922]
stable/6.1: [d42b71a34f6b8a2d5c53df81169b03b8d8b5cf4e]
stable/6.12: [44ddd7b1ae0b7edb2c832eb16798c827a05e58f0]
stable/6.6: [346c820ef5135cf062fa3473da955ef8c5fb6929]

CVE-2025-38728: smb3: fix for slab out of bounds on mount to ksmbd

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38728

Introduced commit is not determined.Fixed in v6.17-rc2.
Introduced by fe856be ("CIFS: parse and store info on iface queries")
in 4.18-rc2.

Fixed status
mainline: [7d34ec36abb84fdfb6632a0f2cbda90379ae21fc]
stable/6.1: [9bdb8e98a0073c73ab3e6c631ec78877ceb64565]
stable/6.12: [8de33d4d72e8fae3502ec3850bd7b14e7c7328b6]
stable/6.6: [a0620e1525663edd8c4594f49fb75fe5be4724b0]

CVE-2025-38729: ALSA: usb-audio: Validate UAC3 power domain descriptors, too

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38729

Introduced by commit 9a2fe9b ("ALSA: usb: initial USB Audio Device
Class 3.0 support") in v4.17-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d832ccbc301fbd9e5a1d691bdcf461cdb514595f]
stable/5.10: [ebc9e06b6ea978a20abf9b87d41afc51b2d745ac]
stable/5.15: [f03418bb9d542f44df78eec2eff4ac83c0a8ac0d]
stable/5.4: [1666207ba0a5973735ef010812536adde6174e81]
stable/6.1: [40714daf4d0448e1692c78563faf0ed0f9d9b5c7]
stable/6.12: [cd08d390d15b204cac1d3174f5f149a20c52e61a]
stable/6.6: [07c8d78dbb5e0ff8b23f7fd69cd1d4e2ba22b3dc]

CVE-2025-38730: io_uring/net: commit partial buffers on retry

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38730

Introduced by commit c56e022 ("io_uring: add support for user mapped
provided buffer ring") in v6.4-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41b70df5b38bc80967d2e0ed55cc3c3896bba781]
stable/6.12: [fe9da1812f8697a38f7e30991d568ec199e16059]
stable/6.6: [3b53dc1c641f2884d4750fc25aaf6c36b90db606]

CVE-2025-38731: drm/xe: Fix vm_bind_ioctl double free bug

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38731

Introduced by commit b43e864 ("drm/xe/uapi: Add
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR") in v6.15-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [111fb43a557726079a67ce3ab51f602ddbf7097e]

CVE-2025-38732: netfilter: nf_reject: don't leak dst refcount for
loopback packets

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38732

Introduced by commit f53b9b0 ("netfilter: introduce support for reject
at prerouting stage") in v5.9-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91a79b792204313153e1bdbbe5acbfc28903b3a5]
stable/5.10: [7b8b503c06274ef3c6c1a107743f1ec0d0a53ef8]
stable/5.15: [82ef97abf22790182f7d433c74960dfd61b99c33]
stable/6.1: [b7a885ba25960c91db237c3f83b4285156789bce]
stable/6.12: [51e8531371f90bee742c63775c9a568e5d6bf3c5]
stable/6.6: [a0a3ace2a57887dac1e7c9a724846040c3e31868]

CVE-2025-38733: s390/mm: Do not map lowcore with identity mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38733

Introduced by commit 32db401 ("s390/mm: Pin identity mapping base to
zero") in v6.11-rc5.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93f616ff870a1fb7e84d472cad0af651b18f9f87]
stable/6.12: [30bf5728bb217a6d1ba73f44094c9b9c6bc9a567]

CVE-2025-38734: net/smc: fix UAF on smcsk after smc_listen_out()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38734

Introduced by commit 3b2dec2 ("net/smc: restructure client and server
code in af_smc") in v4.18-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9cef55ed49117bd63695446fb84b4b91815c0b4]
stable/6.12: [2e765ba0ee0eae35688b443e97108308a716773e]
stable/6.6: [070b4af44c4b6e4c35fb1ca7001a6a88fd2d318f]

CVE-2025-38735: gve: prevent ethtool ops after shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38735

Introduced by commit 974365e ("gve: Implement
suspend/resume/shutdown") in v5.17-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75a9a46d67f46d608205888f9b34e315c1786345]
stable/6.1: [48a4e89d50e8ea52e800bc7865970b92fcf4647c]
stable/6.12: [a7efffeecb881b4649fdc30de020ef910f35d646]
stable/6.6: [ba51d73408edf815cbaeab148625576c2dd90192]

CVE-2025-38736: net: usb: asix_devices: Fix PHY address mask in MDIO
bus initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38736

Introduced by commit 4faff70 ("net: usb: asix_devices: add phy_mask
for ax88772 mdio bus") in v6.17-rc2.
Fixed in v6.17-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.16 stable/6.6

Fixed status
mainline: [24ef2f53c07f273bad99173e27ee88d44d135b1c]
stable/5.15: [fcb4ce9f729c1d08e53abf9d449340e24c3edee6]
stable/6.1: [8f141f2a4f2ef8ca865d5921574c3d6535e00a49]
stable/6.12: [22042ffedd8c2c6db08ccdd6d4273068eddd3c5c]
stable/6.6: [748da80831221ae24b4bc8d7ffb22acd5712a341]

CVE-2025-38737: cifs: Fix oops due to uninitialised variable

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38737

Introduced by commit a2906d3 ("cifs: Switch crypto buffer to use a
folio_queue rather than an xarray") in v6.12-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [453a6d2a68e54a483d67233c6e1e24c4095ee4be]
stable/6.12: [4931fe2dbe1cc0e7d350a4b51b0b330e43971d98]

CVE-2025-39673: ppp: fix race conditions in ppp_fill_forward_path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39673

Introduced by commit f6efc67 ("net: ppp: resolve forwarding path for
bridge pppoe devices") in v5.13-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0417adf367a0af11adf7ace849af4638cfb573f7]
stable/5.15: [9a1969fbffc1f1900d92d7594b1b7d8d72ef3dc7]
stable/6.1: [0f1630be6fcca3f0c63e4b242ad202e5cde28a40]
stable/6.12: [94731cc551e29511d85aa8dec61a6c071b1f2430]
stable/6.6: [ca18d751bcc9faf5b7e82e9fae1223d103928181]

CVE-2025-39674: scsi: ufs: ufs-qcom: Fix ESI null pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39674

Introduced by commit e46a28c ("scsi: ufs: qcom: Remove the MSI
descriptor abuse") in v6.16-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6300d5c5438724c0876828da2f6e2c1a661871fc]

CVE-2025-39675: drm/amd/display: Add null pointer check in
mod_hdcp_hdcp1_create_session()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39675

Introduced by commit 2deade5 ("drm/amd/display: Remove hdcp display
state with mst fix") in v5.8-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a2ca2ea64b1b63c8baa94a8f5deb70b2248d119]
stable/5.15: [2af45aadb7b5d3852c76e2d1e985289ada6f48bf]
stable/6.1: [ee0373b20bb67b1f00a1b25ccd24c8ac996b6446]
stable/6.12: [97fc94c5fd3c6ac5a13e457d38ee247737b8c4bd]
stable/6.6: [857b8387a9777e42b36e0400be99b54c251eaf9a]

CVE-2025-39676: scsi: qla4xxx: Prevent a potential error pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39676

Introduced by commit 1348373 ("[SCSI] qla4xxx: fix flash/ddb support")
in v3.2-rc7.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9dcf111dd3e7ed5fce82bb108e3a3fc001c07225]
stable/5.10: [ad8a9d38d30c691a77c456e72b78f7932d4f234d]
stable/5.15: [325bf7d57c4e2a341e381c5805e454fb69dd78c3]
stable/5.4: [d0225f41ee70611ca88ccb22c8542ecdfa7faea8]
stable/6.1: [46288d12d1c30d08fbeffd05abc079f57a43a2d4]
stable/6.12: [f1424c830d6ce840341aac33fe99c8ac45447ac1]
stable/6.6: [f5ad0819f902b4b33591791b92a0350fb3692a6b]

CVE-2025-39677: net/sched: Fix backlog accounting in qdisc_dequeue_internal

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39677

Introduced by commit 2d3cbfd ("net_sched: Flush gso_skb list too
during ->change()") in v6.15-rc7.
Introduced by commit 4b549a2 ("fq_codel: Fair Queue Codel AQM") in v3.5-rc1.
Introduced by commit 10239ed ("net-qdisc-hhf: Heavy-Hitter Filter
(HHF) qdisc") in v3.14-rc1.
Fixed in v6.17-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [52bf272636bda69587952b35ae97690b8dc89941]

CVE-2025-39678: platform/x86/amd/hsmp: Ensure sock->metric_tbl_addr is non-NULL

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39678

Introduced by commit 5150542 ("platform/x86/amd/hsmp: add support for
metrics tbl") in v6.7-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c78fb287e1f430b929f2e49786518350d15605c]

CVE-2025-39679: drm/nouveau/nvif: Fix potential memory leak in nvif_vmm_ctor().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39679

Introduced by commit 6b252cf ("drm/nouveau: nvkm/vmm: implement raw
ops to manage uvmm") in v6.6-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb8aeaa3191b617c6faf8ae937252e059673b7ea]
stable/6.12: [cabcb52d76d3d42f16c344a96e098dd9d18602f8]
stable/6.6: [72553fe19317fe93cb8591c83095c446bc7fe292]

CVE-2025-39680: i2c: rtl9300: Fix out-of-bounds bug in rtl9300_i2c_smbus_xfer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39680

Introduced by commit c366be7 ("i2c: Add driver for the RTL9300 I2C
controller") in v6.13-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57f312b955938fc4663f430cb57a71f2414f601b]

CVE-2025-39681: x86/cpu/hygon: Add missing resctrl_cpu_detect() in
bsp_init helper

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39681

Introduced by commit 923f3a2 ("x86/resctrl: Query LLC monitoring
properties once during boot") in v5.8-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8df126349dad855cdfedd6bbf315bad2e901c2f]
stable/5.10: [62f12cde10118253348a7540e85606869bd69432]
stable/5.15: [873f32201df8876bdb2563e3187e79149427cab4]
stable/6.1: [fb81222c1559f89bfe3aa1010f6d112531d55353]
stable/6.12: [a9e5924daa954c9f585c1ca00358afe71d6781c4]
stable/6.6: [7207923d8453ebfb35667c1736169f2dd796772e]

CVE-2025-39682: tls: fix handling of zero-length records on the rx_list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39682

Introduced by commit 84c61fe ("tls: rx: do not use the standard
strparser") in v6.0-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62708b9452f8eb77513115b17c4f8d1a22ebf843]
stable/6.1: [2902c3ebcca52ca845c03182000e8d71d3a5196f]
stable/6.12: [3439c15ae91a517cf3c650ea15a8987699416ad9]
stable/6.6: [c09dd3773b5950e9cfb6c9b9a5f6e36d06c62677]

CVE-2025-39683: tracing: Limit access to parser->buffer when
trace_get_user failed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39683

Introduced by commit 8c9af47 ("ftrace: Handle commands when closing
set_ftrace_filter file") in v5.13-rc1.
Fixed in v6.17-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [6a909ea83f226803ea0e718f6e88613df9234d58]
stable/5.10: [b842ef39c2ad6156c13afdec25ecc6792a9b67b9]
stable/5.15: [41b838420457802f21918df66764b6fbf829d330]
stable/6.1: [418b448e1d7470da9d4d4797f71782595ee69c49]
stable/6.12: [d0c68045b8b0f3737ed7bd6b8c83b7887014adee]
stable/6.6: [58ff8064cb4c7eddac4da1a59da039ead586950a]

CVE-2025-39684: comedi: Fix use of uninitialized memory in
do_insn_ioctl() and do_insnlist_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39684

Introduced by commit ed9eccb ("Staging: add comedi core") in v2.6.29-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cd212e895ca2d58963fdc6422502b10dd3966bb]
stable/5.15: [868a1b68dcd9f2805bb86aa64862402f785d8c4a]
stable/6.1: [ff4a7c18799c7fe999fa56c5cf276e13866b8c1a]
stable/6.12: [f3b0c9ec54736f3b8118f93a473d22e11ee65743]
stable/6.6: [d84f6e77ebe3359394df32ecd97e0d76a25283dc]

CVE-2025-39685: comedi: pcl726: Prevent invalid irq number

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39685

Introduced by commit fff4620 ("staging: comedi: pcl726: enable the
interrupt support code") in v3.13-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96cb948408b3adb69df7e451ba7da9d21f814d00]
stable/5.15: [bab220b0bb5af652007e278e8e8357f952b0e1ea]
stable/6.1: [5a33d07c94ba91306093e823112a7aa9727549f6]
stable/6.12: [a3cfcd0c78c80ca7cd80372dc28f77d01be57bf6]
stable/6.6: [0eb4ed2aa261dee228f1668dbfa6d87353e8162d]

CVE-2025-39686: comedi: Make insn_rw_emulate_bits() do insn->n samples

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39686

Introduced by commit ed9eccb ("Staging: add comedi core") in v2.6.29-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7afba9221f70d4cbce0f417c558879cba0eb5e66]
stable/5.15: [ab77e85bd3bc006ef40738f26f446a660813da44]
stable/6.1: [ae8bc1f07bcb31b8636420e03d1f9c3df6219a2b]
stable/6.12: [92352ed2f9ac422181e381c2430c2d0dfb46faa0]
stable/6.6: [842f307a1d115b24f2bcb2415c4e344f11f55930]

CVE-2025-39687: iio: light: as73211: Ensure buffer holes are zeroed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39687

Introduced by commit 403e558 ("iio: light: as73211: New driver") in v5.10-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [433b99e922943efdfd62b9a8e3ad1604838181f2]
stable/5.10: [fd441fd972067f80861a0b66605c0febb0d038dd]
stable/5.15: [d8c5d87a431596e0e02bd7fe3bff952b002a03bb]
stable/6.1: [83f14c4ca1ad78fcfb3e0de07d6d8a0c59550fc2]
stable/6.12: [cce55ca4e7a221d5eb2c0b757a868eacd6344e4a]
stable/6.6: [99b508340d0d1b9de0856c48c77898b14c0df7cf]

CVE-2025-39689: ftrace: Also allocate and copy hash for reading of filter files

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39689

Introduced by commit c20489d ("ftrace: Assign iter->hash to filter or
notrace hashes on seq read") in v4.12-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfb336cf97df7b37b2b2edec0f69773e06d11955]
stable/5.10: [c4cd93811e038d19f961985735ef7bb128078dfb]
stable/5.15: [e0b6b223167e1edde5c82edf38e393c06eda1f13]
stable/5.4: [12064e1880fc9202be75ff668205b1703d92f74f]
stable/6.1: [a40c69f4f1ed96acbcd62e9b5ff3a596f0a91309]
stable/6.12: [c591ba1acd081d4980713e47869dd1cc3d963d19]
stable/6.6: [3b114a3282ab1a12cb4618a8f45db5d7185e784a]

CVE-2025-39690: iio: accel: sca3300: fix uninitialized iio scan data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39690

Introduced by commit edeb67f ("iio: accel: sca3300: use
IIO_DECLARE_BUFFER_WITH_TS") in v6.16-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e5b705cc6147f0b9173c6219079f41416bdd3c0]

CVE-2025-39691: fs/buffer: fix use-after-free when call bh_read() helper

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39691

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7375f22495e7cd1c5b3b5af9dcc4f6dffe34ce49]
stable/5.10: [3169edb8945c295cf89120fc6b2c35cfe3ad4c9e]
stable/5.15: [03b40bf5d0389ca23ae6857ee25789f0e0b47ce8]
stable/5.4: [70a09115da586bf662c3bae9c0c4a1b99251fad9]
stable/6.1: [c58c6b532b7b69537cfd9ef701c7e37cdcf79dc4]
stable/6.12: [042cf48ecf67f72c8b3846c7fac678f472712ff3]
stable/6.6: [c5aa6ba1127307ab5dc3773eaf40d73a3423841f]

CVE-2025-39692: smb: server: split ksmbd_rdma_stop_listening() out of
ksmbd_rdma_destroy()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39692

Introduced by commit 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in v5.15-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bac7b996d42e458a94578f4227795a0d4deef6fa]
stable/6.1: [524e90e58a267dad11e23351d9e4b1f941490976]
stable/6.12: [003e6a3150299f681f34cb189aa068018cef6a45]
stable/6.6: [212eb86f75b4d7b82f3d94aed95ba61103bccb93]

CVE-2025-39693: drm/amd/display: Avoid a NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39693

Introduced commit is not determined.Fixed in v6.17-rc3.
Vulnerable function was added by 88694af ("drm/amd/display: Expose HDR
output metadata for supported connectors") in 5.3-rc1.

Fixed status
mainline: [07b93a5704b0b72002f0c4bd1076214af67dc661]
stable/5.15: [9c92d12b5cb9d9d88c12ae71794d3a7382fcdec0]
stable/6.1: [6f860abff89417c0354b6ee5bbca188a233c5762]
stable/6.12: [f653dd30839eb4f573a7539e90b8a58ff9bedf2f]
stable/6.6: [36a6b43573d152736eaf2557fe60580dd73e9350]

CVE-2025-39694: s390/sclp: Fix SCCB present check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39694

Introduced by commit ada1da3 ("s390/sclp: sort out physical vs virtual
pointers usage") in v5.16-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [430fa71027b6ac9bb0ce5532b8d0676777d4219a]
stable/6.1: [aa5073ac1a2a274812f3b04c278992e68ff67cc7]
stable/6.12: [61605c847599fbfdfafe638607841c7d73719081]
stable/6.6: [86c2825791c3836a8f77a954b9c5ebe6fab410c5]

CVE-2025-39695: RDMA/rxe: Flush delayed SKBs while releasing RXE resources

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39695

Introduced by commit 1a633bd ("RDMA/rxe: Let destroy qp succeed with
stuck packet") in v6.10-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c3e9a9f2972b364e8c2cfbfdeb23c6d6be4f87f]
stable/6.12: [732d4bd7b78a2752ad43cc39287ef41893c5eee2]

CVE-2025-39696: ALSA: hda: tas2781: Fix wrong reference of tasdevice_priv

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39696

Introduced by commit 4fe2385 ("ALSA: hda/tas2781: Move and unified the
calibrated-data getting function for SPI and I2C into the tas2781_hda
lib") in v6.16-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f4422e7c9436abf81a00270be7e4d6d3760ec0e]

CVE-2025-39697: NFS: Fix a race when updating an existing write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39697

Introduced by commit bd37d6f ("NFSv4: Convert
nfs_lock_and_join_requests() to use nfs_page_find_head_request()") in
v4.14-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76d2e3890fb169168c73f2e4f8375c7cc24a765e]
stable/5.10: [0ff42a32784e0f2cb46a46da8e9f473538c13e1b]
stable/5.15: [f230d40147cc37eb3aef4d50e2e2c06ea73d9a77]
stable/6.1: [c32e3c71aaa1c1ba05da88605e2ddd493c58794f]
stable/6.12: [92278ae36935a54e65fef9f8ea8efe7e80481ace]
stable/6.6: [181feb41f0b268e6288bf9a7b984624d7fe2031d]

CVE-2025-39698: io_uring/futex: ensure io_futex_wait() cleans up
properly on failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39698

Introduced by commit 194bb58 ("io_uring: add support for futex wake
and wait") in v6.7-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [508c1314b342b78591f51c4b5dadee31a88335df]
stable/6.12: [d9f93172820a53ab42c4b0e5e65291f4f9d00ad2]

CVE-2025-39699: iommu/riscv: prevent NULL deref in iova_to_phys

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39699

Introduced by commit 488ffbf ("iommu/riscv: Paging domain support") in
v6.13-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99d4d1a070870aa08163af8ce0522992b7f35d8c]

CVE-2025-39700: mm/damon/ops-common: ignore migration request to invalid nodes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39700

Introduced by commit b51820e ("mm/damon/paddr: introduce
DAMOS_MIGRATE_COLD action for demotion")        [6.11.x] in v6.11-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e6c3130690a01076efdf45aa02ba5d5c16849a0]
stable/6.12: [7c303fa1f311aadc17fa82b7bbf776412adf45de]

CVE-2025-39701: ACPI: pfr_update: Fix the driver update version check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39701

Introduced by commit 0db89fa ("ACPI: Introduce Platform Firmware
Runtime Update device driver") in v5.17-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8151320c747efb22d30b035af989fed0d502176e]
stable/6.1: [79300ff532bccbbf654992c7c0863b49a6c3973c]
stable/6.12: [b00219888c11519ef75d988fa8a780da68ff568e]
stable/6.6: [cf0a88124e357bffda487cbf3cb612bb97eb97e4]

CVE-2025-39702: ipv6: sr: Fix MAC comparison to be constant-time

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39702

Introduced by commit bf355b8 ("ipv6: sr: add core files for SR HMAC
support") in v4.10-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a458b2902115b26a25d67393b12ddd57d1216aaa]
stable/5.15: [3b348c9c8d2ca2c67559ffd0e258ae7e1107d4f0]
stable/6.1: [86b6d34717fe0570afce07ee79b8eeb40341f831]
stable/6.12: [b3967c493799e63f648e9c7b6cb063aa2aed04e7]
stable/6.6: [3ddd55cf19ed6cc62def5e3af10c2a9df1b861c3]

CVE-2025-39703: net, hsr: reject HSR frame if skb can't hold tag

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39703

Introduced by commit 48b491a ("net: hsr: fix mac_len checks") in v5.13-rc4.
Fixed in v6.17-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [7af76e9d18a9fd6f8611b3313c86c190f9b6a5a7]
stable/5.10: [8d9bc4a375a1ba05f7dfa0407de8e510ab9bd14d]
stable/5.15: [3ae272ab523dd6bdc26e879027ed79feac9dd1b3]
stable/6.1: [b640188b8a6690e685939053c7efdbc7818b5f4e]
stable/6.12: [acd69b597bd3f76d3b3d322b84082226c00eeaa4]
stable/6.6: [b117c41b00902c1a7e24347c405cb82504aeae0b]

CVE-2025-39704: LoongArch: KVM: Fix stack protector issue in send_ipi_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39704

Introduced by commit daee2f9 ("LoongArch: KVM: Add IPI read and write
function") in v6.13-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c68549c81bcca70fc464e305ffeefd9af968287]

CVE-2025-39705: drm/amd/display: fix a Null pointer dereference vulnerability

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39705

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by 4562236 ("drm/amd/dc: Add dc display
driver (v2)") in 4.15-rc1.

Fixed status
mainline: [1bcf63a44381691d6192872801f830ce3250e367]
stable/6.12: [0961673cc5f0055957aa46f25eb4ef6c07e00165]

CVE-2025-39706: drm/amdkfd: Destroy KFD debugfs after destroy KFD wq

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39706

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if this bug was introduced by 851a645e ("drm/amdkfd: Add debugfs
  support to KFD") in 4.16-rc1.

Fixed status
mainline: [2e58401a24e7b2d4ec619104e1a76590c1284a4c]
stable/6.1: [fc35c955da799ba62f6f977d58e0866d0251e3f8]
stable/6.12: [96609a51e6134542bf90e053c2cd2fe4f61ebce3]
stable/6.6: [74ee7445c3b61c3bd899a54bd82c1982cb3a8206]

CVE-2025-39707: drm/amdgpu: check if hubbub is NULL in
debugfs/amdgpu_dm_capabilities

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39707

Introduced commit is not determined.Fixed in v6.17-rc1.
Introduced by 42ab1cf ("drm/amd/display: Add DCHUBBUB callback to
report MALL status") in 6.7-rc1.

Fixed status
mainline: [b4a69f7f29c8a459ad6b4d8a8b72450f1d9fd288]
stable/6.12: [83cfdc2b018cd9c0f927b781d4e07c0d4a911fac]

CVE-2025-39708: media: iris: Fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39708

Introduced by commit fb583a2 ("media: iris: introduce host firmware
interface with necessary hooks") in v6.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f837559ccdd275c5a059e6ac4d5034b03409f1d]

CVE-2025-39709: media: venus: protect against spurious interrupts during probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39709

Introduced by commit af2c383 ("[media] media: venus: adding core part
and helper functions") in v4.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3200144a2fa4209dc084a19941b9b203b43580f0]
stable/5.10: [88cf63c2599761c48dec8f618d57dccf8f6f4b53]
stable/5.15: [9db6a78bc5e418e0064e2248c8f3b9b9e8418646]
stable/5.4: [18c2b2bd982b8546312c9a7895515672169f28e0]
stable/6.1: [37cc0ac889b018097c217c5929fd6dc2aed636a1]
stable/6.12: [639eb587f977c02423f4762467055b23902b4131]
stable/6.6: [f54be97bc69b1096198b6717c150dec69f2a1b4d]

CVE-2025-39710: media: venus: Add a check for packet size after
reading from shared memory

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39710

Introduced by commit d96d3f3 ("[media] media: venus: hfi: add Venus
HFI files") in v4.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49befc830daa743e051a65468c05c2ff9e8580e6]
stable/5.10: [f5b7a943055a4a106d40a03bacd940e28cc1955f]
stable/5.15: [ef09b96665f16f3f0bac4e111160e6f24f1f8791]
stable/5.4: [0520c89f6280d2b60ab537d5743601185ee7d8ab]
stable/6.1: [7638bae4539dcebc3f68fda74ac35d73618ec440]
stable/6.12: [2d8cea8310a245730816a1fd0c9fa4a5a3bdc68c]
stable/6.6: [ba567c2e52fbcf0e20502746bdaa79e911c2e8cf]

CVE-2025-39711: media: ivsc: Fix crash at shutdown due to missing
mei_cldev_disable() calls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39711

Introduced by commit 78876f7 ("media: pci: intel: ivsc: Add ACE
submodule") in v6.6-rc1.
Introduced by commit 29006e1 ("media: pci: intel: ivsc: Add CSI
submodule") in v6.6-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c92c49fc688cfadacc47ae99b06a31237702e9e]
stable/6.12: [639f5b33fcd7c59157f29b09f6f2866eacf9279c]
stable/6.6: [3c0e4cc4f55f9a1db2a761e4ffb27c9594245888]

CVE-2025-39712: media: mt9m114: Fix deadlock in
get_frame_interval/set_frame_interval

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39712

Introduced by commit 24d756e ("media: i2c: Add driver for onsemi
MT9M114 camera sensor") in v6.7-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [298d1471cf83d5a2a05970e41822a2403f451086]
stable/6.12: [0d23b548d71e5d76955fdf1d73addd8f6494f602]

CVE-2025-39713: media: rainshadow-cec: fix TOCTOU race condition in
rain_interrupt()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39713

Introduced by commit 0f314f6 ("[media] rainshadow-cec: new RainShadow
Tech HDMI CEC driver") in v4.12-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7af160aea26c7dc9e6734d19306128cce156ec40]
stable/5.10: [6aaef1a75985865d8c6c5b65fb54152060faba48]
stable/5.15: [fbc81e78d75bf28972bc22b1599559557b1a1b83]
stable/5.4: [2964dbe631fd21ad7873b1752b895548d3c12496]
stable/6.1: [3c3e33b7edca7a2d6a96801f287f9faeb684d655]
stable/6.12: [ed905fe7cba03cf22ae0b84cf1b73cd1c070423a]
stable/6.6: [1c2769dc80255824542ea5a4ff1a07dcdeb1603f]

CVE-2025-39714: media: usbtv: Lock resolution while streaming

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39714

Introduced by commit 0e0fe39 ("[media] usbtv: Add support for PAL
video source") in v3.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e40e0bb778907b2441bff68d73c3eb6b6cd319f]
stable/5.10: [ee7bade8b9244834229b12b6e1e724939bedd484]
stable/5.15: [5427dda195d6baf23028196fd55a0c90f66ffa61]
stable/5.4: [c35e7c7a004ef379a1ae7c7486d4829419acad1d]
stable/6.1: [ef9b3c22405192afaa279077ddd45a51db90b83d]
stable/6.12: [c3d75524e10021aa5c223d94da4996640aed46c0]
stable/6.6: [3d83d0b5ae5045a7a246ed116b5f6c688a12f9e9]

CVE-2025-39715: parisc: Revise gateway LWS calls to probe user read access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39715

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [f6334f4ae9a4e962ba74b026e1d965dfdf8cbef8]
stable/6.1: [e8b496c52aa0c6572d88db7cab85aeea6f9c194d]
stable/6.12: [bc0a24c24ceebabb5ba65900e332233d79e625e6]
stable/6.6: [8bccf47adbf658293528e86960e6d6f736b1c9f7]

CVE-2025-39716: parisc: Revise __get_user() to probe user read access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39716

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [89f686a0fb6e473a876a9a60a13aec67a62b9a7e]
stable/6.1: [28a9b71671fb4a2993ef85b8ef6f117ea63894fe]
stable/6.12: [f410ef9a032caf98117256b22139c31342d7bb06]
stable/6.6: [4c981077255acc2ed5b3df6e8dd0125c81b626a9]

CVE-2025-39717: open_tree_attr: do not allow id-mapping changes
without OPEN_TREE_CLONE

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39717

Introduced by commit 2462651 ("fs: allow changing idmappings") in v6.15-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9308366f062129d52e0ee3f7a019f7dd41db33df]

CVE-2025-39718: vsock/virtio: Validate length in packet header before skb_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39718

Introduced by commit 71dc9ec ("virtio/vsock: replace virtio_vsock_pkt
with sk_buff") in v6.3-rc1.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [0dab92484474587b82e8e0455839eaf5ac7bf894]
stable/6.1: [969b06bd8b7560efb100a34227619e7d318fbe05]
stable/6.12: [faf332a10372390ce65d0b803888f4b25a388335]
stable/6.6: [ee438c492b2e0705d819ac0e25d04fae758d8f8f]

CVE-2025-39719: iio: imu: bno055: fix OOB access of hw_xlate array

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39719

Introduced by commit 4aefe1c ("iio: imu: add Bosch Sensortec BNO055
core driver") in v6.1-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [399b883ec828e436f1a721bf8551b4da8727e65b]
stable/6.1: [a0691ab6334f1769acc64ea9e319414a682ff45d]
stable/6.12: [4808ca3aa30ae857454d0b41d2d0bf161a312b45]
stable/6.6: [50e823a23816b792daf6e8405f8d6045952bb90e]

CVE-2025-39720: ksmbd: fix refcount leak causing resource not released

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39720

Introduced commit is not determined.Fixed in v6.17-rc3.
Vulnerable code was added by ee426bf ("ksmbd: add refcnt to ksmbd_conn
struct") in 6.12-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [89bb430f621124af39bb31763c4a8b504c9651e2]
stable/6.12: [36e010bb865fbaa1202fe9bcce3fd486d6db7606]
stable/6.6: [a1d2bab4d53368a526c97aba92671dd71814f95a]

CVE-2025-39721: crypto: qat - flush misc workqueue during device shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39721

Introduced by commit e5745f3 ("crypto: qat - enable power management
for QAT GEN4") in v5.18-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d4df408ba9bad2b205c7fb8afc1836a6a4ca88a]
stable/6.12: [fe546f5c50fc474daca6bee72caa7ab68a74c33d]
stable/6.6: [5858448a6c65d8ee3f8600570d3ce19febcb33be]

CVE-2025-39722: crypto: caam - Prevent crash on suspend with iMX8QM / iMX8ULP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39722

Introduced by commit d283570 ("crypto: caam - i.MX8ULP donot have CAAM
page0 access") in v6.10-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ffc47feddcf8eb4d8ac7b42111a02c8e8146512]
stable/6.12: [f9534674ce53f133c91c272f091f0242932574ae]

CVE-2025-39723: netfs: Fix unbuffered write error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39723

Introduced by commit 288ace2 ("netfs: New writeback implementation")
in v6.10-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3de58b12ce074ec05b8741fa28d62ccb1070468]
stable/6.12: [f08c80af3c9a9849cd178b4843b7c01d103506a1]

CVE-2025-39724: serial: 8250: fix panic due to PSLVERR

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39724

Introduced by commit c49436b ("serial: 8250_dw: Improve unwritable LCR
workaround") in v3.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f8fdd4dbffc05982b96caf586f77a014b2a9353]
stable/5.10: [b8ca8e3f75ede308b4d49a6ca5081460be01bdb5]
stable/5.15: [68c4613e89f000e8198f9ace643082c697921c9f]
stable/5.4: [0b882f00655afefbc7729c6b5aec86f7a5473a3d]
stable/6.1: [c826943abf473a3f7260fbadfad65e44db475460]
stable/6.12: [8e2739478c164147d0774802008528d9e03fb802]
stable/6.6: [cb7b3633ed749db8e56f475f43c960652cbd6882]

CVE-2025-39725: mm/vmscan: fix hwpoisoned large folio handling in
shrink_folio_list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39725

Introduced by commit 1b04495 ("mm/vmscan: don't try to reclaim
hwpoison folio") in v6.15-rc1.
Fixed in v6.16.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [9f1e8cd0b7c4c944e9921b52a6661b5eda2705ab]
stable/6.12: [656eaddbc952e1baae2f69281c22debe22140312]

CVE-2025-39727: mm: swap: fix potential buffer overflow in setup_clusters()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39727

Introduced by commit b843786 ("mm: swapfile: fix SSD detection with
swapfile on btrfs") in v6.12-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [152c1339dc13ad46f1b136e8693de15980750835]
stable/6.12: [91b370800b3f2b3dda244c0ab06719c4971190a5]

CVE-2025-39729: crypto: ccp - Fix dereferencing uninitialized error pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39729

Introduced by commit 9770b42 ("crypto: ccp - Move dev_info/err
messages for SEV/SNP init and shutdown") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fa766726c091ff0ec7d26874f6e4724d23ecb0e]

CVE-2025-39730: NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39730

Introduced by commit 20fa190 ("nfs: add export operations") in v4.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef93a685e01a281b5e2a25ce4e3428cf9371a205]
stable/5.10: [cb09afa0948d96b1e385d609ed044bb1aa043536]
stable/5.15: [3570ef5c31314c13274c935a20b91768ab5bf412]
stable/5.4: [7f8eca87fef7519e9c41f3258f25ebc2752247ee]
stable/6.1: [763810bb883cb4de412a72f338d80947d97df67b]
stable/6.12: [2ad40b7992aa26bc631afc1a995b0e3ddc30de3f]
stable/6.6: [12ad3def2e5e0b120e3d0cb6ce8b7b796819ad40]

CVE-2025-39731: f2fs: vm_unmap_ram() may be called from an invalid context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39731

Introduced by commit bff139b ("f2fs: handle decompress only post
processing in softirq") in v6.0-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08a7efc5b02a0620ae16aa9584060e980a69cb55]
stable/6.1: [eb69e69a5ae6c8350957893b5f68bd55b1565fb2]
stable/6.12: [0fe7976b62546f1e95eebfe9879925e9aa22b7a8]
stable/6.6: [1023836d1b9465593c8746f97d608da32958785f]

CVE-2025-39732: wifi: ath11k: fix sleeping-in-atomic in
ath11k_mac_op_set_bitrate_mask()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39732

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65c12b104cb942d588a1a093acc4537fb3d3b129]
stable/6.12: [9c0e3144924c7db701575a73af341d33184afeaf]

CVE-2025-39733: team: replace team lock with rtnl lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39733

Introduced by commit 6b1d3c5 ("team: grab team lock during
team_change_rx_flags") in v6.15.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfb4fb77f9a8ce33ce357224569eae5564eec573]

CVE-2025-39734: Revert "fs/ntfs3: Replace inode_trylock with inode_lock"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39734

Introduced by commit 69505fe ("fs/ntfs3: Replace inode_trylock with
inode_lock") in v6.11-rc1.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [a49f0abd8959048af18c6c690b065eb0d65b2d21]
stable/5.15: [bec8109f957a6e193e52d1728799994c8005ca83]
stable/6.1: [1903a6c1f2818154f6bc87bceaaecafa92b6ac5c]
stable/6.12: [b356ee013a79e7e3147bfe065de376706c5d2ee9]
stable/6.6: [a936be9b5f51c4d23f66fb673e9068c6b08104a4]


Fixed status

* Updated CVEs

CVE-2023-52935: mm/khugepaged: fix ->anon_vma race

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [cee956ab1efbd858b4ca61c8b474af5aa24b29a6]
stable/5.15: [abdf3c33918185c3e8ffeb09ed3e334b3d7df47c]
stable/5.4: [352fbf61ce776fef18dca6a68680a6cd943dac95]

CVE-2024-47704: drm/amd/display: Check link_res->hpo_dp_link_enc before using it

stable/6.1 was fixed.

Fixed status
stable/6.1: [8c22a62288194f072eb3a51045b700fce1c18d9e]

CVE-2024-57924: fs: relax assertions on failure to encode file handles

stable/6.1 was fixed.

Fixed status
stable/6.1: [73697928c806fe4689939722184a86fc1c1957b4]

CVE-2025-22103: net: fix NULL pointer dereference in l3mdev_l3_rcv

stable/6.12 was fixed.

Fixed status
stable/6.12: [59599bce44af3df7a215ebc81cb166426e1c9204]

CVE-2025-22113: ext4: avoid journaling sb update on error if journal
is destroying

stable/6.12 was fixed.

Fixed status
stable/6.12: [eddca44ddf810e27f0c96913aa3cc92ebd679ddb]

CVE-2025-22124: md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb

stable/6.12 was fixed.

Fixed status
stable/6.12: [60196f92bbc7901eb5cfa5d456651b87ea50a4a3]

CVE-2025-22125: md/raid1,raid10: don't ignore IO flags

stable/6.12 was fixed.

Fixed status
stable/6.12: [73506e581c0b1814cdfd2229d589f30751d7de26]

CVE-2025-23133: wifi: ath11k: update channel list in reg notifier
instead reg worker

stable/6.12 was fixed.

Fixed status
stable/6.12: [26618c039b78a76c373d4e02c5fbd52e3a73aead]

CVE-2025-37842: spi: fsl-qspi: use devm function instead of driver remove

stable/6.6 was fixed.

Fixed status
stable/6.6: [50ae352c1848cab408fb4f7d7f50c71f818bbdbf]

CVE-2025-37931: btrfs: adjust subpage bit start based on sectorsize

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [5111b148360f50cac9abbae8fca44cc0ac4bf9bf]
stable/6.6: [977849e8acd2466ac3cb49e04a3ecc73837f6b90]

CVE-2025-37968: iio: light: opt3001: fix deadlock due to concurrent flag access

stable/5.10, stable/5.15, stable/5.4, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [957e8be112636d9bc692917286e81e54bd87decc]
stable/5.15: [1d7def97e7eb65865ccc01bbdf4eb9e6bbe8a5b5]
stable/5.4: [a9c56ccb7cddfca754291fb24b108a5350a5fbe9]
stable/6.1: [748ebd8e61d0bc182c331b8df3887af7285c8a8f]
stable/6.6: [e791bf216c9e236b34dabf514ec0ede140cca719]

CVE-2025-38095: dma-buf: insert memory barrier before updating num_fences

stable/5.15 was fixed.

Fixed status
stable/5.15: [d0b7f11dd68b593bd970e5735be00e8d89bace30]

CVE-2025-38148: net: phy: mscc: Fix memory leak when using one step timestamping

stable/5.15 was fixed.

Fixed status
stable/5.15: [24b24295464f25fb771d36ed558c7cd942119361]

CVE-2025-38272: net: dsa: b53: do not enable EEE on bcm63xx

stable/6.12 was fixed.

Fixed status
stable/6.12: [3fbe3f4c57fda09f32e13fa05f53a0cc6f500619]

CVE-2025-38306: fs/fhandle.c: fix a race in call of has_locked_children()

stable/6.12 was fixed.

Fixed status
stable/6.12: [6482c3dccbfb8d20e2856ce67c75856859930b3f]

CVE-2025-38453: io_uring/msg_ring: ensure io_kiocb freeing is deferred for RCU

stable/6.12 was fixed.

Fixed status
stable/6.12: [094ba14a471cc6c68078c7ad488539eaf32c2277]

CVE-2025-38502: bpf: Fix oob access in cgroup local storage

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [c1c74584b9b4043c52e41fec415226e582d266a3]
stable/6.1: [66da7cee78590259b400e51a70622ccd41da7bb2]
stable/6.12: [41688d1fc5d163a6c2c0e95c0419e2cb31a44648]
stable/6.6: [7acfa07c585e3d7a64654d38f0a5c762877d0b9b]

CVE-2025-38556: HID: core: Harden s32ton() against conversion to 0 bits

stable/6.12 was fixed.

Fixed status
stable/6.12: [d3b504146c111548ab60b6ef7aad00bfb1db05a2]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

