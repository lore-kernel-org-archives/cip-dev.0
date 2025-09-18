Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F1CAC59A
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 00:26:07 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web11.2372.1758155163454174711
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 17:26:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=qESNtl2t;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.170, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea5bc345eddso362760276.1
        for <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1758155162; x=1758759962; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ntBx/EIcbPie7YsDaSR+Sh1kOXDb6xqsfUEEiuulaqc=;
        b=qESNtl2tDO7QpJg9b2QzVQkktlNTTMB80+yU0oM+rBTWhl4bNqiDwDdvOdouBb/ZSg
         iCwskC2nRf07GESKwAdEbjn8qyg29hFTwfdOJBFDaPagdLO4RAUDj2t1amqzyJUgOz50
         8D0Haky2FnW1LSjCrqdvd3GqIrnmJoJJb25f0U/MIlmrw8gguCGEr8RJXAwBzEuLIEFs
         LSs8pPjhDLFS68L8Abhxte9avTrH6LoC3h3GRdpoXjcRZJ7GjsduUaD4MEyaNmyR9v7T
         LmITbiu1PCkuiyhEW9o2KNnB262ljE+2+wvneyxsy5RDnn+bYBCWK7s7RL6/u6Z8ls+7
         XBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155162; x=1758759962;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntBx/EIcbPie7YsDaSR+Sh1kOXDb6xqsfUEEiuulaqc=;
        b=S1Hvvzm2oxnfGmX3xJFBena9UcPFxV4BUNanfX3chKShjDD4ksmZfD5MJ8DXSxo3J7
         YEq3Chf3SUIc3220FaehqNd4VDD/NjxUSt7R0M6L1GUa20igh+XyE0KiJR+6YPCA9Sdv
         s/WRtFzlsU+TezE8EdbtJTDXnal57WzDT/s5wi8Ovhlv6XSymIVDbgpKNQnzzk4ChB1w
         FC6LM5+rVdqg/hZgObAWQ1whS8GPxUSXCyAflkIU48wPa5AhYAr+yOsEB7kFwYAalABC
         noVvow9O5/0EghpJN1FIKtGFN2v0CY2KR0rMsiTVJE1s8DzV2TwtEC7mkBt4IGYxUmQO
         h5Rw==
X-Gm-Message-State: AOJu0YwyJZYxbsHWs3VNd5Su5Noyc0+CU+N1GY479mgjVqhQovrXS/ns
	6hxrFzdTxj+ZUZn4WYspBHN5BusSg3Na3cyiEMPSouGGyLWrKQmj0ZX4XdsvuVBcIoYSBO6aguE
	525Nz3AxQ9U3daYsksrTxkJfR+jC4dWaS9woRgyrTq28yOIbVAnUYCJM=
X-Gm-Gg: ASbGncsbq+c3G+P7jBHdHeUN2qQIjjsbO0D2ZCJIAwR1Nr6v0e1i523gpeTL2dbGHdJ
	u9gSqyEfSkJC68HLH0R3c0dzr67oyZ139rPtZZWxkzD7OPSWf5D5cP9taFBKDL0MQRjt0MJahGm
	uN1VMxlTJ/A9cPlSE70EkcNGovseC+KoNPPNiOJtoPyKRmcVqdSl2iMWZK6lOpn0+DUVigQFI74
	W+fzRYxCY4DNTD7Ix2UW7rdGcQ=
X-Google-Smtp-Source: AGHT+IFtxr15HaMVdVTj1h4bn+3VR8pOYwPdjGQZuOuGadXFWHBu0GMGrVMsJ7S/4S5ci09I1gnbWo4cYr0JDRG3XDI=
X-Received: by 2002:a05:6902:1b89:b0:ea2:239d:3aa3 with SMTP id
 3f1490d57ef6-ea5c06abde6mr3649757276.39.1758155159866; Wed, 17 Sep 2025
 17:25:59 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Sep 2025 09:25:23 +0900
X-Gm-Features: AS18NWDJjn1ZJkRpmmsJUOliNlhTLauCgyuWctru62iY0lCyAMCf9uGCrOzTF8I
Message-ID: <CAODzB9oAoMTgYV_D6M-LV+RV9RANcNXP5KgvtguQ-z=p1=jRhA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Sep 2025 00:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20081

Hi!

It's this week's CVE report.

This week reported 449 new CVEs and 1 updated CVEs.

* New CVEs
CVE-2025-39736: mm/kmemleak: avoid deadlock by moving pr_warn()
outside kmemleak_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39736

Introduced by commit c566586 ("mm: kmemleak: use the memory pool for
early allocations") in v5.4-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47b0f6d8f0d2be4d311a49e13d2fd5f152f492b2]
stable/5.10: [4b0151e1d468eb2667c37b7af99b3c075072d334]
stable/5.15: [f249d32bb54876b4b6c3ae071af8ddca77af390b]
stable/5.4: [c7b6ea0ede687e7460e593c5ea478f50aa41682a]
stable/6.1: [62879faa8efe8d8a9c7bf7606ee9c068012d7dac]
stable/6.12: [a0854de00ce2ee27edf39037e7836ad580eb3350]
stable/6.6: [1da95d3d4b7b1d380ebd87b71a61e7e6aed3265d]

CVE-2025-39737: mm/kmemleak: avoid soft lockup in __kmemleak_do_cleanup()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39737

Introduced commit is not determined.Fixed in v6.17-rc2.
Vulnerable function was added by c89da70 ("kmemleak: allow freeing
internal objects after kmemleak was disabled") in 3.15-rc1.

Fixed status
mainline: [d1534ae23c2b6be350c8ab060803fbf6e9682adc]
stable/5.10: [1ef72a7fedc5bca70e8cc980985790de10d407aa]
stable/5.15: [a04de4c40aab9b338dfa989cf4aec70fd187eeb2]
stable/5.4: [9f1f4e95031f84867c5821540466d62f88dab8ca]
stable/6.1: [f014c10d190b92aad366e56b445daffcd1c075e4]
stable/6.12: [8d2d22a55ffe35c38e69795468a7addd1a80e9ce]
stable/6.6: [e21a3ddd58733ce31afcb1e5dc3cb80a4b5bc29b]

CVE-2025-39738: btrfs: do not allow relocation of partially dropped subvolumes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39738

Introduced commit is not determined.Fixed in v6.17-rc2.


Fixed status
mainline: [4289b494ac553e74e86fed1c66b2bf9530bc1082]
stable/5.15: [fa086b1398cf7e5f7dee7241bd5f2855cb5df8dc]
stable/6.1: [fcb1f77b8ed8795608ca7a1f6505e2b07236c1f3]
stable/6.12: [39a93e1c9dbf7e11632efeb20fcf0fc1dcf64d51]
stable/6.6: [f83d4c81bda3b7d1813268ab77408f7a0ce691ff]

CVE-2025-39739: iommu/arm-smmu-qcom: Add SM6115 MDSS compatible

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39739

Introduced by commit 3581b70 ("drm/msm/disp/dpu1: add support for
display on SM6115") in v6.2-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7fa8520f30373ce99c436c4d57c76befdacbef3]
stable/6.12: [c62963370627f3aa22d991e0a3e93f5d61ad9b08]
stable/6.6: [a11b6ee7cab87c4d75e95ac9e7443155f7cecb55]

CVE-2025-39740: drm/xe/migrate: prevent potential UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39740

Introduced by commit 270172f ("drm/xe: Update xe_ttm_access_memory to
use GPU for non-visible access") in v6.16-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [145832fbdd17b1d77ffd6cdd1642259e101d1b7e]

CVE-2025-39741: drm/xe/migrate: don't overflow max copy size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39741

Introduced by commit 270172f ("drm/xe: Update xe_ttm_access_memory to
use GPU for non-visible access") in v6.16-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4126cb327a2e3273c81fcef1c594c5b7b645c44c]

CVE-2025-39742: RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39742

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by b094a36 ("IB/hfi1: Refine user
process affinity algorithm") in 4.8-rc1.

Fixed status
mainline: [59f7d2138591ef8f0e4e4ab5f1ab674e8181ad3a]
stable/5.10: [1a7cf828ed861de5be1aff99e10f114b363c19d3]
stable/5.15: [9d3211cb61a0773a2440d0a0698c1e6e7429f907]
stable/5.4: [9bba1a9994c523b44db64f63b564b4719ea2b7ef]
stable/6.1: [4b4317b0d758ff92ba96f4e448a8992a6fe607bf]
stable/6.12: [9b05e91afe948ed819bf87d7ba0fccf451ed79a6]
stable/6.6: [89fdac333a17ed990b41565630ef4791782e02f5]

CVE-2025-39743: jfs: truncate good inode pages when hard link is 0

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39743

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [2d91b3765cd05016335cd5df5e5c6a29708ec058]
stable/5.10: [5845b926c561b8333cd65169526eec357d7bb449]
stable/5.15: [8ed7275910fb7177012619864e04d3008763f3ea]
stable/5.4: [89fff8e3d6710fc32507b8e19eb5afa9fb79b896]
stable/6.1: [b5b471820c33365a8ccd2d463578bf4e47056c2c]
stable/6.12: [df3fd8daf278eca365f221749ae5b728e8382a04]
stable/6.6: [34d8e982bac48bdcca7524644a8825a580edce74]

CVE-2025-39744: rcu: Fix rcu_read_unlock() deadloop due to IRQ work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39744

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [b41642c87716bbd09797b1e4ea7d904f06c39b7b]
stable/6.12: [1cfa244f7198d325594e627574930b7b91df5bfe]
stable/6.6: [e7a375453cca2b8a0d2fa1b82b913f3fed7c0507]

CVE-2025-39745: rcutorture: Fix rcutorture_one_extend_check() splat in
RT kernels

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39745

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [8d71351d88e478d3c4e945e3218e97ec677fd807]

CVE-2025-39746: wifi: ath10k: shutdown driver when hardware is unreliable

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39746

Introduced commit is not determined.Fixed in v6.17-rc1.
Affected driver was added by 5e3dd15 in 3.11-rc1.

Fixed status
mainline: [c256a94d1b1b15109740306f7f2a7c2173e12072]
stable/6.12: [201c9b4485edc618863a60f97a2d88bddd139467]

CVE-2025-39747: drm/msm: Add error handling for krealloc in metadata setup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39747

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by 9902cb9 ("drm/msm/gem: Add metadata")
in 6.8-rc1.

Fixed status
mainline: [1c8c354098ea9d4376a58c96ae6b65288a6f15d8]
stable/6.12: [53dc780c1e94ea782d8936b41bfaa83c663702eb]

CVE-2025-39748: bpf: Forget ranges when refining tnum after JSET

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39748

Introduced commit is not determined.Fixed in v6.17-rc1.
It seems as if this bug was introduced by 6742050 ("bpf: generalize
reg_set_min_max() to handle non-const register comparisons") in
6.8-rc1.

Fixed status
mainline: [6279846b9b2532e1b04559ef8bd0dec049f29383]
stable/6.12: [f01e06930444cab289a8783017af9b64255bd103]

CVE-2025-39749: rcu: Protect ->defer_qs_iw_pending from data race

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39749

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by 0864f05 ("rcu: Use irq_work to get
scheduler's attention in clean context") in 5.3-rc1.

Fixed status
mainline: [90c09d57caeca94e6f3f87c49e96a91edd40cbfd]
stable/5.10: [f937759c7432d6151b73e1393b6517661813d506]
stable/5.15: [0ad84d62217488e679ecc90e8628980dcc003de3]
stable/5.4: [74f58f382a7c8333f8d09701aefaa25913bdbe0e]
stable/6.1: [b5de8d80b5d049f051b95d9b1ee50ae4ab656124]
stable/6.12: [e35e711c78c8a4c43330c0dcb1c4d507a19c20f4]
stable/6.6: [b55947b725f190396f475d5d0c59aa855a4d8895]

CVE-2025-39750: wifi: ath12k: Correct tid cleanup when tid setup fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39750

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by d889913 ("wifi: ath12k: driver for
Qualcomm Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [4a2bf707270f897ab8077baee8ed5842a5321686]
stable/6.12: [2ef17d1476ab26bce89764e2f16833d7f52acc38]
stable/6.6: [30cad87978057516c93467516bc481a3eacfd66a]

CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39751

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by 44f0c97 ("ALSA: hda/ca0132: Add
tuning controls") in 3.9-rc1.

Fixed status
mainline: [a409c60111e6bb98fcabab2aeaa069daa9434ca0]
stable/5.10: [fb8116c38d67d6e23f3b5e34bbc8d9f8c12e81e5]
stable/5.15: [c2dacfe495b72699a9480c95f8eef2285042e474]
stable/5.4: [04fa6f5e94034654da3505d9e908dd9090f0e83c]
stable/6.1: [86a024a5a521da362fb67a3a6a84f54331503326]
stable/6.12: [417407cdf587e3ae41a0e728daa562ee88fc1bd6]
stable/6.6: [0de69bc9b3661e16c4b08b34949529553906f5e1]

CVE-2025-39752: ARM: rockchip: fix kernel hang during smp initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39752

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if vulnerable code was added by 3ee851e ("ARM: rockchip:
add basic smp support for rk3288") in 3.19-rc1.

Fixed status
mainline: [7cdb433bb44cdc87dc5260cdf15bf03cc1cd1814]
stable/5.10: [888a453c2a239765a7ab4de8a3cedae2e3802528]
stable/5.15: [c0726d1e466e2d0da620836e293a59e6427ccdff]
stable/5.4: [3c6bf7a324b8995b9c7d790c8d2abf0668f51551]
stable/6.1: [265583266d93db4ff83d088819b1f63fdf0131db]
stable/6.12: [0223a3683d502b7e5eb2eb4ad7e97363fa88d531]
stable/6.6: [d7d6d076ee9532c4668f14696a35688d35dd16f4]

CVE-2025-39753: gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39753

Introduced commit is not determined.Fixed in v6.17-rc1.
According to the commit log, this bug was introduced by 7ee364724
("migrate: Remove call to ->writepage") in 6.16-rc1.

Fixed status
mainline: [5c8f12cf1e64e0e8e6cb80b0c935389973e8be8d]
stable/6.12: [9d9b053f7f9c5a35049abe56af9e6ac70b6b0e4b]
stable/6.6: [3d2c05cbc6a3725d832b912b637971f37301c7e5]

CVE-2025-39754: mm/smaps: fix race between smaps_hugetlb_range and migration

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39754

Introduced by commit 25ee01a ("mm: hugetlb: proc: add hugetlb-related
fields to /proc/PID/smaps") in v4.4-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45d19b4b6c2d422771c29b83462d84afcbb33f01]
stable/6.12: [2a1f3663974162b8f1e098196f557cfc1d160138]

CVE-2025-39756: fs: Prevent file descriptor table allocations exceeding INT_MAX

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39756

Introduced by commit 9cfe015 ("get rid of NR_OPEN and introduce a
sysctl_nr_open") in v2.6.25-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04a2c4b4511d186b0fce685da21085a5d4acd370]
stable/5.10: [f95638a8f22eba307dceddf5aef9ae2326bbcf98]
stable/5.15: [749528086620f8012b83ae032a80f6ffa80c45cd]
stable/5.4: [b4159c5a90c03f8acd3de345a7f5fc63b0909818]
stable/6.1: [628fc28f42d979f36dbf75a6129ac7730e30c04e]
stable/6.12: [d4f9351243c17865a8cdbe6b3ccd09d0b13a7bcc]
stable/6.6: [237e416eb62101f21b28c9e6e564d10efe1ecc6f]

CVE-2025-39757: ALSA: usb-audio: Validate UAC3 cluster segment descriptors

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39757

Introduced by commit 11785ef ("ALSA: usb-audio: Initial Power Domain
support") in v4.19-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecfd41166b72b67d3bdeb88d224ff445f6163869]
stable/5.10: [786571b10b1ae6d90e1242848ce78ee7e1d493c4]
stable/5.15: [275e37532e8ebe25e8a4069b2d9f955bfd202a46]
stable/5.4: [799c06ad4c9c790c265e8b6b94947213f1fb389c]
stable/6.1: [47ab3d820cb0a502bd0074f83bb3cf7ab5d79902]
stable/6.12: [ae17b3b5e753efc239421d186cd1ff06e5ac296e]
stable/6.6: [1034719fdefd26caeec0a44a868bb5a412c2c1a5]

CVE-2025-39758: RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39758

Introduced by commit c2ff29e ("siw: Inline do_tcp_sendpages()") in v6.5-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c18646248fed07683d4cee8a8af933fc4fe83c0d]
stable/6.12: [673cf582fd788af12cdacfb62a6a593083542481]
stable/6.6: [5661fdd218c2799001b88c17acd19f4395e4488e]

CVE-2025-39759: btrfs: qgroup: fix race between quota disable and
quota rescan ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39759

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [e1249667750399a48cafcf5945761d39fa584edf]
stable/6.1: [7cda0fdde5d9890976861421d207870500f9aace]
stable/6.12: [dd0b28d877b293b1d7f8727a7de08ae36b6b9ef0]
stable/6.6: [b172535ccba12f0cf7d23b3b840989de47fc104d]

CVE-2025-39760: usb: core: config: Prevent OOB read in SS endpoint
companion parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39760

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if 4.x kernels are affected too.

Fixed status
mainline: [cf16f408364efd8a68f39011a3b073c83a03612d]
stable/5.10: [5c3097ede7835d3caf6543eb70ff689af4550cd2]
stable/5.15: [058ad2b722812708fe90567875704ae36563e33b]
stable/6.1: [b10e0f868067c6f25bbfabdcf3e1e6432c24ca55]
stable/6.12: [9512510cee7d1becdb0e9413fdd3ab783e4e30ee]
stable/6.6: [5badd56c711e2c8371d1670f9bd486697575423c]

CVE-2025-39761: wifi: ath12k: Decrement TID on RX peer frag setup error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39761

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by d889913 ("wifi: ath12k: driver for
Qualcomm Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [7c0884fcd2ddde0544d2e77f297ae461e1f53f58]
stable/6.12: [7c3e99fd4a66a5ac9c7dd32db07359666efe0002]
stable/6.6: [eb1e1526b82b8cf31f1ef9ca86a2647fb6cd89c6]

CVE-2025-39762: drm/amd/display: add null check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39762

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by 29e178d ("drm/amd/display: Add dc cap
for dp tunneling") in 6.17-rc1.

Fixed status
mainline: [158b9201c17fc93ed4253c2f03b77fd2671669a1]

CVE-2025-39763: ACPI: APEI: send SIGBUS to current task if synchronous
memory error not recovered

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39763

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [79a5ae3c4c5eb7e38e0ebe4d6bf602d296080060]
stable/6.12: [cfc9bc15bda6fd0c496cbe2c628564d4d7c332c1]
stable/6.6: [082735fbcdb6cd0cf20fbec94516ab2996f1cdd5]

CVE-2025-39764: netfilter: ctnetlink: remove refcounting in expectation dumpers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39764

Introduced by commit cf6994c ("[NETFILTER]: nf_conntrack_netlink: sync
expectation dumping with conntrack table dumping") in v2.6.23-rc1.
Introduced by commit e844a92 ("netfilter: ctnetlink: allow to dump
expectation per master conntrack") in v3.10-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1492e3dcb2be3aa46d1963da96aa9593e4e4db5a]

CVE-2025-39765: ALSA: timer: fix ida_free call while not allocated

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39765

Introduced by commit 3774591 ("ALSA: timer: Introduce virtual
userspace-driven timers") in v6.12-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5003a65790ed66be882d1987cc2ca86af0de3db1]
stable/6.12: [34327b362ce2849a5eb02f47e800049e7a20a0ba]

CVE-2025-39766: net/sched: Make cake_enqueue return NET_XMIT_CN when
past buffer_limit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39766

Introduced by commit 046f6fd ("sched: Add Common Applications Kept
Enhanced (cake) qdisc") in v4.19-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15de71d06a400f7fdc15bf377a2552b0ec437cf5]
stable/5.10: [de04ddd2980b48caa8d7e24a7db2742917a8b280]
stable/5.15: [0dacfc5372e314d1219f03e64dde3ab495a5a25e]
stable/5.4: [7689ab22de36f8db19095f6bdf11f28cfde92f5c]
stable/6.1: [710866fc0a64eafcb8bacd91bcb1329eb7e5035f]
stable/6.12: [ff57186b2cc39766672c4c0332323933e5faaa88]
stable/6.6: [aa12ee1c1bd260943fd6ab556d8635811c332eeb]

CVE-2025-39767: LoongArch: Optimize module load time by optimizing
PLT/GOT counting

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39767

Introduced by commit fcdfe9d ("LoongArch: Add ELF and module support")
in v5.19-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63dbd8fb2af3a89466538599a9acb2d11ef65c06]
stable/6.12: [e94cdb9fb279430cbd323a74c7ec124c85109747]
stable/6.6: [5189c0b7c251363a4dd7678ed11b054c54f36f6f]

CVE-2025-39768: net/mlx5: HWS, fix complex rules rehash error flow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39768

Introduced by commit 17e0acc ("net/mlx5: HWS, support complex
matchers") in v6.16-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a842b1bf18a32ee0c25dd6dd98728b786a76fe4]

CVE-2025-39769: bnxt_en: Fix lockdep warning during rmmod

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39769

Introduced by commit 004b500 ("eth: bnxt: remove most dependencies on
RTNL") in v6.15-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4611d88a37cfc18cbabc6978aaf7325d1ae3f53a]

CVE-2025-39770: net: gso: Forbid IPv6 TSO with extensions on devices
with only IPV6_CSUM

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39770

Introduced by commit 04c20a9 ("net: skip offload for NETIF_F_IPV6_CSUM
if ipv6 header contains extension") in v6.12-rc6.
Fixed in v6.17-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [864e3396976ef41de6cc7bc366276bf4e084fff2]
stable/6.1: [a0478d7e888028f85fa7785ea838ce0ca09398e2]
stable/6.12: [041e2f945f82fdbd6fff577b79c33469430297aa]
stable/6.6: [2156d9e9f2e483c8c3906c0ea57ea312c1424235]

CVE-2025-39771: regulator: pca9450: Use devm_register_sys_off_handler

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39771

Introduced by commit 6157e62 ("regulator: pca9450: Add restart
handler") in v6.16-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [447be50598c05499f7ccc2b1f6ddb3da30f8099a]

CVE-2025-39772: drm/hisilicon/hibmc: fix the hibmc loaded failed bug

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39772

Introduced by commit b3df5e6 ("drm/hibmc: Drop drm_vblank_cleanup") in
v4.14-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93a08f856fcc5aaeeecad01f71bef3088588216a]
stable/5.15: [ddf1691f25345699296e642f0f59f2d464722fa3]
stable/6.1: [c950e1be3a24d021475b56efdb49daa7fbba63a9]
stable/6.12: [a4f1b9c57092c48bdc7958abd23403ccaed437b2]
stable/6.6: [f93032e5d68f459601c701f6ab087b5feb3382e8]

CVE-2025-39773: net: bridge: fix soft lockup in br_multicast_query_expired()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39773

Introduced by commit d902eee ("bridge: Add multicast count/interval
sysfs entries") in v2.6.34-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1547bf460baec718b3398365f8de33d25c5f36f]
stable/5.15: [34171b9e53bd1dc264f5556579f2b04f04435c73]
stable/6.1: [43e281fde5e76a866a4d10780c35023f16c0e432]
stable/6.12: [bdb19cd0de739870bb3494c815138b9dc30875c4]
stable/6.6: [96476b043efb86a94f2badd260f7f99c97bd5893]

CVE-2025-39774: iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39774

Introduced by commit 89ee817 ("iio: adc: rzg2l_adc: Simplify the
runtime PM code") in v6.14-rc1.
Fixed in v6.17-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12

Fixed status
mainline: [c69e13965f26b8058f538ea8bdbd2d7718cf1fbe]

CVE-2025-39775: mm/mremap: fix WARN with uffd that has remap events disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39775

Introduced by commit 0cef0bb ("mm: clear uffd-wp PTE/PMD state on
mremap()") in v6.13.
Fixed in v6.17-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [772e5b4a5e8360743645b9a466842d16092c4f94]

CVE-2025-39776: mm/debug_vm_pgtable: clear page table entries at destroy_args()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39776

Introduced by commit 3c9b84f ("mm/debug_vm_pgtable: introduce struct
pgtable_debug_args") in v5.15-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dde30854bddfb5d69f30022b53c5955a41088b33]
stable/5.15: [7bf57a0709cd7c9088cea8de023d6f4fbf2518b0]
stable/6.1: [47d2a149611b8a94d24add9868c442a4af278658]
stable/6.12: [61a9f2e5c49f05e3ea2c16674540a075a1b4be6f]
stable/6.6: [63962ff932ef359925b94be2a88df6b4fd4fed0a]

CVE-2025-39777: crypto: acomp - Fix CFI failure due to type punning

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39777

Introduced by commit 42d9f6c ("crypto: acomp - Move scomp stream
allocation code into acomp") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [962ddc5a7a4b04c007bba0f3e7298cda13c62efd]

CVE-2025-39779: btrfs: subpage: keep TOWRITE tag until folio is cleaned

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39779

Introduced by commit 3470da3 ("btrfs: subpage: introduce helpers for
writeback status") in v5.13-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1511360c8ac882b0c52caa263620538e8d73220]
stable/6.12: [3d61136945a7008fc90d013c3c67007ce0c96131]

CVE-2025-39780: sched/ext: Fix invalid task state transitions on class switch

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39780

Introduced by commit a8532fa ("sched_ext: TASK_DEAD tasks must be
switched into SCX on ops_enable") in v6.12-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddf7233fcab6c247379d0928d46cc316ee122229]
stable/6.12: [786f6314604b34c3e7de5f733f4e08e35c448a50]

CVE-2025-39781: parisc: Drop WARN_ON_ONCE() from flush_cache_vmap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39781

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable code was added by 72d95924 ("parisc: Try to fix random
segmentation faults in package builds") in 6.10-rc4.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [4eab1c27ce1f0e89ab67b01bf1e4e4c75215708a]
stable/6.12: [8f8a07ad04da5b3c90fab61c33d4a8256a680591]
stable/6.6: [69cf90e5aa50fe3cb0c1a63cabc4761db44b0035]

CVE-2025-39782: jbd2: prevent softlockup in jbd2_log_do_checkpoint()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39782

Introduced commit is not determined.Fixed in v6.17-rc3.


Fixed status
mainline: [9d98cf4632258720f18265a058e62fde120c0151]
stable/5.10: [f7ee8fd689e6d534f9fd2494b9266f7998082e65]
stable/5.15: [84ff98c1ea19acd3f9389e4bb6061364e943f85e]
stable/5.4: [f683d611518d30334813eecf9a8c687453e2800e]
stable/6.1: [26cb9aad94cb1811d8fae115594cc71fa3d91ab0]
stable/6.12: [429d50cbaff45090d52a1ea850d5de8c14881ee7]
stable/6.6: [41f40038de62e8306897cf6840791b268996432a]

CVE-2025-39783: PCI: endpoint: Fix configfs group list head handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39783

Introduced by commit ef1433f ("PCI: endpoint: Create configfs entry
for each pci_epf_device_id table entry") in v4.18-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d79123d79a8154b4318529b7b2ff7e15806f480b]
stable/5.10: [d5aecddc3452371d9da82cdbb0c715812524b54b]
stable/5.15: [dc4ffbd571716ff3b171418fb03abe80e720a7b1]
stable/5.4: [80ea6e6904fb2ba4ccb5d909579988466ec65358]
stable/6.1: [409af8b9f7b4f23cd0464e71c6cd6fe13c076ae2]
stable/6.12: [6cf65505523224cab1449d726d2ce8180c2941ee]
stable/6.6: [0758862386f114d9ab1e23181461bd1e2e9ec4c6]

CVE-2025-39784: PCI: Fix link speed calculation on retrain failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39784

Introduced by commit de9a6c8 ("PCI/bwctrl: Add pcie_set_target_speed()
to set PCIe Link Speed") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9989e0ca7462c62f93dbc62f684448aa2efb9226]

CVE-2025-39785: drm/hisilicon/hibmc: fix irq_request()'s irq name
variable is local

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39785

Introduced by commit b11bc1a ("drm/hisilicon/hibmc: Add MSI irq
getting and requesting for HPD") in v6.16-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bed4ec42a4e0dc8113172696ff076d1eb6d8bcb]

CVE-2025-39786: iio: adc: ad7173: fix channels index for syscalib_mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39786

Introduced by commit 031bdc8 ("iio: adc: ad7173: add calibration
support") in v6.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0eb8d7b25397330beab8ee62c681975b79f37223]

CVE-2025-39787: soc: qcom: mdt_loader: Ensure we don't read past the ELF header

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39787

Introduced by commit 2aad40d ("remoteproc: Move qcom_mdt_loader into
drivers/soc/qcom") in v4.11-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f9967fed9d066ed3dae9372b45ffa4f6fccfeef]
stable/5.10: [e1720eb32acf411c328af6a8c8f556c94535808e]
stable/5.15: [0d59ce2bfc3bb13abe6240335a1bf7b96536d022]
stable/5.4: [1096eb63ecfc8df90b70cd068e6de0c2ff204dfd]
stable/6.1: [43d26997d88c4056fce0324e72f62556bc7e8e8d]
stable/6.12: [87bfabb3b2f46827639173f143aa43f7cfc0a7e6]
stable/6.6: [981c845f29838e468a9bfa87f784307193a31297]

CVE-2025-39788: scsi: ufs: exynos: Fix programming of HCI_UTRL_NEXUS_TYPE

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39788

Introduced by commit 55f4b1f ("scsi: ufs: ufs-exynos: Add UFS host
support for Exynos SoCs") in v5.9-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01aad16c2257ab8ff33b152b972c9f2e1af47912]
stable/5.10: [01510a9e8222f11cce064410f3c2fcf0756c0a08]
stable/5.15: [098b2c8ee208c77126839047b9e6e1925bb35baa]
stable/6.1: [c1f025da8f370a015e412b55cbcc583f91de8316]
stable/6.12: [dc8fb963742f1a38d284946638f9358bdaa0ddee]
stable/6.6: [6d53b2a134da77eb7fe65c5c7c7a3c193539a78a]

CVE-2025-39789: crypto: x86/aegis - Add missing error checks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39789

Introduced by commit 1d373d4 ("crypto: x86 - Add optimized AEGIS
implementations") in v4.18-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d9eb180fbe8828cce43bce4c370124685b205c3]

CVE-2025-39790: bus: mhi: host: Detect events pointing to unexpected TREs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39790

Introduced by commit 1d3173a ("bus: mhi: core: Add support for
processing events from client device") in v5.7-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bd398e20f0833ae8a1267d4f343591a2dd20185]
stable/5.15: [7b3f0e3b60c27f4fcb69927d84987e5fd6240530]
stable/6.1: [4079c6c59705b96285219b9efc63cab870d757b7]
stable/6.12: [2ec99b922f4661521927eeada76f431eebfbabc4]
stable/6.6: [5e17429679a8545afe438ce7a82a13a54e8ceabb]

CVE-2025-39791: dm: dm-crypt: Do not partially accept write BIOs with
zoned targets

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39791

Introduced by commit f211268 ("dm: Use the block layer zone append
emulation") in v6.10-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e549663849e5bb3b985dc2d293069f0d9747ae72]
stable/6.12: [8864616719b6bbf92356bc89ff544b0cd484c656]

CVE-2025-40300: x86/vmscape: Enable the mitigation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40300



Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f8f173413f1cbf52660d04df92d0069c4306d25,556c1ad666ad90c50ec8fccb930dd5046cfbecfb]
stable/5.10: [ac60717f9a8d21c58617d0b34274babf24135835,c08192b5d6730a914dee6175bc71092ee6a65f14]
stable/5.15: [d5490dfa35427a2967e00a4c7a1b95fdbc8ede34,2f4f2f8f860cb4c3336a7435ebe8dcfded0c9c6e]
stable/6.1: [15006289e5c38b2a830e1fba221977a27598176c,893387c18612bb452336a5881da0d015a7e8f4a2]
stable/6.12: [d7ddc93392e4a7ffcccc86edf6ef3e64c778db52,459274c77b37ac63b78c928b4b4e748d1f9d05c8]
stable/6.6: [f866eef8d1c65504d30923c3f14082ad294d0e6d,34e5667041050711a947e260fc9ebebe08bddee5]

CVE-2025-39792: dm: Always split write BIOs to zoned device limits

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39792

Introduced by commit f211268 ("dm: Use the block layer zone append
emulation") in v6.10-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2df7168717b7d2d32bcf017c68be16e4aae9dd13]
stable/6.12: [d10bf66d9f9335ffc7521b3029b114f50604cabe]

CVE-2025-39793: io_uring/memmap: cast nr_pages to size_t before shifting

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39793

Introduced by commit 087f997 ("io_uring/memmap: implement mmap for
regions") in v6.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33503c083fda048c77903460ac0429e1e2c0e341]

CVE-2025-39794: ARM: tegra: Use I/O memcpy to write to IRAM

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39794

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable code was first added by b36ab97 ("ARM: tegra: rework Tegra
secondary CPU core bringup") in 3.4-rc1.

Fixed status
mainline: [398e67e0f5ae04b29bcc9cbf342e339fe9d3f6f1]
stable/5.10: [75a3bdfeed2f129a2c7d9fd7779382b78e35b014]
stable/5.15: [2499b0ac908eefbb8a217aae609b7a5b5174f330]
stable/5.4: [b28c1a14accc79ead1e87bbdae53309da60be1e7]
stable/6.1: [387435f4833f97aabfd74434ee526e31e8a626ea]
stable/6.12: [9b0b3b5e5cae95e09bf0ae4a9bcb58d9b6d57f87]
stable/6.6: [46b3a7a3a36d5833f14914d1b95c69d28c6a76d6]

CVE-2025-39795: block: avoid possible overflow for chunk_sectors check
in blk_stack_limits()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39795

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable code was added by 22ada80 ("block: use lcm_not_zero() when
stacking chunk_sectors") in 5.10-rc1.

Fixed status
mainline: [448dfecc7ff807822ecd47a5c052acedca7d09e8]
stable/5.10: [418751910044649baa2b424ea31cce3fc4dcc253]
stable/5.15: [8b3ce085b52e674290cbfdd07034e7653ffbe4dc]
stable/6.1: [31f2f080898e50cbf2bae62d35f9f2a997547b38]
stable/6.12: [46aa80ef49594ed7de685ecbc673b291e9a2c159]
stable/6.6: [3b9d69f0e68aa6b0acd9791c45d445154a8c66e9]

CVE-2025-39796: net: lapbether: ignore ops-locked netdevs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39796

Introduced by commit 4c975fd ("net: hold instance lock during
NETDEV_REGISTER/UP") in v6.15-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53898ebabe843bfa7baea9dae152797d5d0563c9]

CVE-2025-39797: xfrm: Duplicate SPI Handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39797

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [94f39804d891cffe4ce17737d295f3b195bc7299]
stable/6.12: [2fc5b54368a1bf1d2d74b4d3b8eea5309a653e38]
stable/6.6: [3d8090bb53424432fa788fe9a49e8ceca74f0544]

CVE-2025-39798: NFS: Fix the setting of capabilities when automounting
a new filesystem

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39798

Introduced by commit 54ceac4 ("NFS: Share NFS superblocks per-protocol
per-server per-FSID") in v2.6.20.16.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b01f21cacde9f2878492cf318fee61bf4ccad323]
stable/5.10: [73fcb101bb3eb2a552d7856a476b2c0bc3b5ef9e]
stable/5.15: [3924dab90816d0c683a110628ef386f83a9d1e13]
stable/5.4: [95eb0d97ab98a10e966125c1f274e7d0fc0992b3]
stable/6.1: [175afda783e38c0660f2afc0602dd9c83d4e7ee1]
stable/6.12: [816a6f60c2c2b679a33fa4276442bafd11473651]
stable/6.6: [987c20428f067c1c7f29ed0a2bd8c63fa74b1c2c]

CVE-2025-39799: ACPI: processor: perflib: Move problematic pr->performance check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39799

Introduced by commit d33bd88 ("ACPI: processor: perflib: Fix initial
_PPC limit application") in v6.17-rc1.
Fixed in v6.17-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.12 stable/6.16 stable/6.6

Fixed status
mainline: [d405ec23df13e6df599f5bd965a55d13420366b8]
stable/5.10: [fc36403e741d7674a44632313db33fa7605cb2b4]
stable/5.15: [edc065c19257adfd9c356178dac021df661e169e]
stable/5.4: [cb4b5f4a1e778f6a20d06d4eda6842714a817618]
stable/6.1: [fd9cad6b0676e0bb3a98ee0a8865a86e2f53eb07]
stable/6.12: [bf2809541497749c4f2646b87bf75244f5a2a5d9]
stable/6.6: [19849010c9e18d54375091864a3313fc328d6186]

CVE-2022-50234: io_uring/af_unix: defer registered files gc to io_uring release

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50234

Introduced by commit 6b06314 ("io_uring: add file set registration")
in v5.1-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0091bfc81741b8d3aeb3b7ab8636f911b2de6e80]
stable/5.10: [c378c479c5175833bb22ff71974cda47d7b05401]
stable/5.15: [813d8fe5d30388f73a21d3a2bf46b0a1fd72498c]
stable/5.4: [04df9719df1865f6770af9bc7880874af0e594b2]
stable/6.1: [0091bfc81741b8d3aeb3b7ab8636f911b2de6e80]

CVE-2022-50235: NFSD: Protect against send buffer overflow in NFSv2 READDIR

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50235

Introduced by commit 53b1119 ("NFSD: Fix READDIR buffer overflow") in v5.16-rc7.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [00b4492686e0497fdb924a9d4c8f6f99377e176c]
stable/5.10: [0e57d696f60dee6117a8ace0cac7c5761d375277]
stable/5.15: [dc7f225090c29a5f3b9419b1af32846a201555e7]
stable/6.1: [00b4492686e0497fdb924a9d4c8f6f99377e176c]

CVE-2022-50236: iommu/mediatek: Fix crash on isr after kexec()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50236

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected function was added by 0df4fab ("iommu/mediatek: Add mt8173
IOMMU driver") in 4.6-rc1.

Fixed status
mainline: [00ef8885a945c37551547d8ac8361cacd20c4e42]
stable/6.1: [85cc8a187f2de7a91e2cea522e9406fa12999269]

CVE-2022-50239: cpufreq: qcom: fix writes in read-only memory region

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50239

Introduced by commit a8811ec ("cpufreq: qcom: Add support for krait
based socs") in v5.7-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01039fb8e90c9cb684430414bff70cea9eb168c5]
stable/5.10: [794ded0bc461287a268bed21fea2eebb6e5d232c]
stable/5.15: [14d260f94ff89543597ffea13db8b277a810e08e]
stable/6.1: [01039fb8e90c9cb684430414bff70cea9eb168c5]

CVE-2022-50241: NFSD: fix use-after-free on source server when doing
inter-server copy

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50241

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [019805fea91599b22dfa62ffb29c022f35abeb06]
stable/5.10: [bbacfcde5fff25ac22597e8373a065c647da6738]
stable/5.15: [83b94969751a691347606dbe6b1865efcfa5a643]
stable/6.1: [019805fea91599b22dfa62ffb29c022f35abeb06]

CVE-2022-50242: drivers: net: qlcnic: Fix potential memory leak in
qlcnic_sriov_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50242

Introduced by commit f197a7a ("qlcnic: VF-PF communication channel
implementation") in v3.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [132c502919bb08e16e3054cb28bb7b149ec20cf5]
cip/4.4-st: [4c41500e8d745894759010bf2d6f168a7e19f64d]
mainline: [01de1123322e4fe1bbd0fcdf0982511b55519c03]
stable/5.10: [14b349a15c297cf3e01b5deb4116f7cf297b6184]
stable/5.15: [8399b9893548c03fdb18be277bf99d985dbde925]
stable/5.4: [a44490abaf00f5b0cc5c448a17eae331c6195d0a]
stable/6.1: [dcae92a249551d1a447804b4be1c9fab0e8c95e8]

CVE-2022-50243: sctp: handle the error returned from
sctp_auth_asoc_init_active_key

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50243

Introduced by commit 58acd10 ("sctp: update active_key for asoc when
old key is being replaced") in v5.14-rc3.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [b8fa99a3a11bdd77fef6b4a97f1021eb30b5ba40]
mainline: [022152aaebe116a25c39818a07e175a8cd3c1e11]
stable/5.10: [f65955340e0044f5c41ac799a01698ac7dee8a4e]
stable/5.15: [19d636b663e0e92951bba5fced929ca7fd25c552]
stable/5.4: [382ff44716603a54f5fd238ddec6a2468e217612]
stable/6.1: [022152aaebe116a25c39818a07e175a8cd3c1e11]

CVE-2022-50244: cxl: fix possible null-ptr-deref in cxl_pci_init_afu|adapter()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50244

Introduced by commit f204e0b ("cxl: Driver code for powernv PCIe based
cards for userspace access") in v3.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c4b2e35df919d99bbbed033c2fa0b607f9f463b5]
cip/4.4-st: [db0b40c0192dc81d91b6cbf296238ec47ca6a8b0]
mainline: [02cd3032b154fa02fdf90e7467abaeed889330b2]
stable/5.10: [0f63c0ddc2ea20d783d29243f4dbe0f9e95dfdec]
stable/5.15: [22511eefa61db26e12c97dd7ada3071dbdfcb004]
stable/5.4: [361412dae1690d4b5df6f92fc943cdc773c95cbc]
stable/6.1: [2f5fd31b2f24b9b8a80ab566fd8c4e1e94cb4339]

CVE-2022-50245: rapidio: fix possible UAF when kfifo_alloc() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50245

Introduced by commit e8de370 ("rapidio: add mport char device driver")
in v4.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a253dde0403a153075ffb254f6f7b2635e49e97a]
mainline: [02d7d89f816951e0862147d751b1150d67aaebdd]
stable/5.10: [5ee850645e42f541ce1ea8130c2b27cc495f965c]
stable/5.15: [2f5cc7fd73fd6253cc71214f0dd499cc62feb469]
stable/5.4: [311b488405ac45af46756b1c8f1d27007b68b07e]
stable/6.1: [cb87af2c19c0993f6e21f75b963a5599c5a73e76]

CVE-2022-50246: usb: typec: tcpci: fix of node refcount leak in
tcpci_register_port()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50246

Introduced by commit 5e85a04 ("usb: typec: add fwnode to tcpc") in v4.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0384e87e3fec735e47f1c133c796f32ef7a72a9b]
stable/5.10: [d3b6c28a71f111a6c67ddc3238aab95910fd86cf]
stable/5.15: [ba75be6f0d9d028d20852564206565a4c03e3288]
stable/5.4: [4f257e2eba419ab4cd880c822346450e4e7b2af3]
stable/6.1: [5f125507d2270035dfcf83fbff6cff5a143e200c]

CVE-2022-50247: usb: xhci-mtk: fix leakage of shared hcd when fail to
set wakeup irq

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50247

Introduced by commit 04284eb ("usb: xhci-mtk: add support runtime PM")
in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03a88b0bafbe3f548729d970d8366f48718c9b19]
stable/5.15: [ffb14aac2658873050671198543b9b8194149c14]
stable/6.1: [c8e7463844888dc8344bbb9cbad88cdce9cb8077]

CVE-2022-50248: wifi: iwlwifi: mvm: fix double free on tx path.

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50248

Introduced by commit 08f7d8b ("iwlwifi: mvm: bring back mvm GSO code")
in v5.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0473cbae2137b963bd0eaa74336131cb1d3bc6c3]
stable/5.10: [ae966649f665bc3868b935157dd4a3c31810dcc0]
stable/5.15: [d8e32f1bf1a9183a6aad560c6688500222d24299]
stable/5.4: [0e1e311fd929c6a8dcfddcb4748c47b07e39821f]
stable/6.1: [3a2ecd1ec14075117ccb3e85f0fed224578ec228]

CVE-2022-50249: memory: of: Fix refcount leak bug in of_get_ddr_timings()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50249

Introduced by commit e6b42eb ("memory: emif: add device tree support
to emif driver") in v3.7-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [68c9c4e6495b825be3a8946df1a0148399555fe4]
cip/4.4-st: [249214e3fbb905d05d11ea96bef5446668ebb3e3]
mainline: [05215fb32010d4afb68fbdbb4d237df6e2d4567b]
stable/5.10: [daaec4b3fe2297b022c6b2d6bf48b6e5265a60b9]
stable/5.15: [2680690f9ce4e6abbb4f559e97271c15b7eeda97]
stable/5.4: [85a40bfb8e7a170abcf9dae2c0898a1983e48daa]
stable/6.1: [05215fb32010d4afb68fbdbb4d237df6e2d4567b]

CVE-2022-50250: regulator: core: fix use_count leakage when handling boot-on

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50250

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected code was added by 05f224c ("regulator: core: Clean enabling
always-on regulators + their supplies") in 5.0-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [dc3391d49479bc2bf8a2b88dbf86fdd800882fee]
mainline: [0591b14ce0398125439c759f889647369aa616a0]
stable/5.10: [4b737246ff50f810d6ab4be13c1388a07f0c14b1]
stable/5.15: [feb847e6591e8c7a09cc39721cc9ca74fd9a5d80]
stable/5.4: [5bfc53df288e8ea54ca6866fb92034214940183f]
stable/6.1: [bc6c381df5793ebcf32db88a3e65acf7870379fc]

CVE-2022-50251: mmc: vub300: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50251

Introduced by commit 88095e7 ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC
driver") in v3.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a46e681151bbdacdf6b89ee8c4e5bad0555142bb]
cip/4.4-st: [8818e3434ad114473bb38cde5533a79d64380de7]
mainline: [0613ad2401f88bdeae5594c30afe318e93b14676]
stable/5.10: [3049a3b927a40d89d4582ff1033cd7953be773c7]
stable/5.15: [afc898019e7bf18c5eb7a0ac19852fcb1b341b3c]
stable/5.4: [3b29f8769d32016b2d89183db4d80c7a71b7e35e]
stable/6.1: [2044b2ea77945f372ef161d1bbf814e471767ff2]

CVE-2022-50252: igb: Do not free q_vector unless new one was allocated

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50252

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [68e8adbcaf7a8743e473343b38b9dad66e2ac6f3]
cip/4.4-st: [d2c9161a24646de191fbda07847f09fed989eed4]
mainline: [0668716506ca66f90d395f36ccdaebc3e0e84801]
stable/5.10: [3cb18dea11196fb4a06f78294cec5e61985e1aff]
stable/5.15: [314f7092b27749bdde44c14095b5533afa2a3bc8]
stable/5.4: [f96bd8adc8adde25390965a8c1ee81b73cb62075]
stable/6.1: [56483aecf6b22eb7dff6315b3a174688c6ad494c]

CVE-2022-50253: bpf: make sure skb->len != 0 when redirecting to a
tunneling device

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50253

Introduced commit is not determined.Fixed in v6.2-rc1.
Vulnerable function was added by 4e3264d ("bpf: Fix bpf_redirect to an
ipip/ip6tnl dev") in 4.9-rc6.

Fixed status
cip/4.19-st: [e6a63203e5a90a39392fa1a7ffc60f5e9baf642a]
mainline: [07ec7b502800ba9f7b8b15cb01dd6556bb41aaca]
stable/5.10: [6d935a02658be82585ecb39aab339faa84496650]
stable/5.15: [5d3f4478d22b2cb1810f6fe0f797411e9d87b3e5]
stable/5.4: [772431f30ca040cfbf31b791d468bac6a9ca74d3]
stable/6.1: [f186303845a01cc7e991f9dc51d7e5a3cdc7aedb]

CVE-2022-50254: media: ov8865: Fix an error handling path in ov8865_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50254

Introduced by commit 73dcffe ("media: i2c: Support 19.2MHz input clock
in ov8865") in v5.17-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [080e0b7404850406628674b07286f16cc389a892]
stable/6.1: [080e0b7404850406628674b07286f16cc389a892]

CVE-2022-50255: tracing: Fix reading strings from synthetic events

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50255

Introduced by commit bd82631 ("tracing: Add support for dynamic
strings to synthetic events") in v5.10-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0934ae9977c27133449b6dd8c6213970e7eece38]
stable/5.15: [d9c79fbcbdb6cb10c07c85040eaf615180b26c48]
stable/6.1: [0934ae9977c27133449b6dd8c6213970e7eece38]

CVE-2022-50256: drm/meson: remove drm bridges at aggregate driver unbind time

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50256

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected driver was added by bbbe775 ("drm: Add support for Amlogic
Meson Graphic Controller") in 4.10-rc1.

Fixed status
mainline: [09847723c12fc2753749cec3939a02ee92dac468]
stable/6.1: [09847723c12fc2753749cec3939a02ee92dac468]

CVE-2022-50257: xen/gntdev: Prevent leaking grants

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50257

Introduced by commit dbe97cf ("xen/gntdev: Avoid blocking in
unmap_grant_pages()") in v5.19-rc4.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [cb1ccfe7655380f77a58b340072f5f40bc285902]
cip/4.4-st: [4d5558f08360e839717a0d0ace04cf65658553bb]
mainline: [0991028cd49567d7016d1b224fe0117c35059f86]
stable/5.10: [49db6cb81400ba863e1a85e55fcdf1031807c23f]
stable/5.15: [1cb73704cb4778299609634a790a80daba582f7d]
stable/5.4: [3d056d81b93a787613eda44aeb21fc14c3392b34]
stable/6.1: [0991028cd49567d7016d1b224fe0117c35059f86]

CVE-2022-50258: wifi: brcmfmac: Fix potential stack-out-of-bounds in
brcmf_c_preinit_dcmds()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50258

Introduced commit is not determined.Fixed in v6.3-rc1.
It looks as if vulnerable code was added by 0af29bf ("brcmfmac: use
fwil for default configuration setup.") in 3.8-rc1.

Fixed status
cip/4.19-st: [d481fd6064bf215d7c5068e15aa390c3b16c9cd0]
mainline: [0a06cadcc2a0044e4a117cc0e61436fc3a0dad69]
stable/5.10: [d6ef66194bb4a6c18f5b9649bf62597909b040e4]
stable/5.15: [3a3a5e3f94068cd562d62a57da6983c8cd07d53c]
stable/5.4: [17dbe90e13f52848c460d253f15b765038ec6dc0]
stable/6.1: [881f50d76c3892262730ddf5c894eb00310e736c]

CVE-2022-50259: bpf, sockmap: fix race in sock_map_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50259

Introduced by commit 7e81a35 ("bpf: Sockmap, ensure sock lock held
during tear down") in v5.5-rc7.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [0a182f8d607464911756b4dbef5d6cad8de22469]
stable/5.10: [be719496ae6a7fc325e9e5056a52f63ebc84cc0c]
stable/5.15: [a443c55d96dede82a724df6e70a318ad15c199e1]
stable/5.4: [4cabc3af4a6f36c222fecb15858c1060e59218e7]
stable/6.1: [5c3568166129bc73fd6b37748d2d8f95cd8f22f3]

CVE-2022-50260: drm/msm: Make .remove and .shutdown HW shutdown consistent

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50260

Introduced by commit 9d5cbf5 ("drm/msm: add shutdown support for
display platform_driver") in v5.9-rc3.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
mainline: [0a58d2ae572adaec8d046f8d35b40c2c32ac7468]
stable/6.1: [0a58d2ae572adaec8d046f8d35b40c2c32ac7468]

CVE-2022-50261: drm/sti: Fix return type of
sti_{dvo,hda,hdmi}_connector_mode_valid()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50261

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [8f9941dea3a70b73f2063f9dcc4aaae6af03c5ba]
cip/4.4-st: [442213484ed09af13c57b4862269e63a881cd75f]
mainline: [0ad811cc08a937d875cbad0149c1bab17f84ba05]
stable/5.10: [6e3c4d3fa5d458d685561ecbaf8daa9dba14979e]
stable/5.15: [a075c21ee026f4a74f9fce5928ea3c8d18a8af13]
stable/5.4: [511b48ee8e4aec2d03d2af06b363d9eb3230b017]
stable/6.1: [04371a75a58422a301a9ff9ae3babd310ac3bb3f]

CVE-2022-50262: fs/ntfs3: Validate BOOT record_size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50262

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected function was added by 82cae26 ("fs/ntfs3: Add initialization
of super block") in 5.15-rc1.

Fixed status
mainline: [0b66046266690454dc04e6307bcff4a5605b42a1]
stable/5.15: [af7a195deae349f15baa765d000a5188920d61dd]
stable/6.1: [db91a9c59162a9c56792ded88160442c0a2dabd5]

CVE-2022-50263: vdpasim: fix memory leak when freeing IOTLBs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50263

Introduced by commit bda324f ("vdpasim: control virtqueue support") in
v5.19-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b7a04a30eef20e6b24926a45c0ce7906ae85bd6]
stable/6.1: [16b22e27fba6fd816d0dcb98f42cc71f0836c27e]

CVE-2022-50264: clk: socfpga: Fix memory leak in socfpga_gate_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50264

Introduced by commit a30a67b ("clk: socfpga: Don't have get_parent for
single parent ops") in v5.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b8ba891ad4d1ef6bfa4c72efc83f9f9f855f68b]
stable/5.10: [3e8fd1d0fab4d5c9a50d225dddc207deac12f13a]
stable/5.15: [9de42116fc4540f6a1ceb51fd037b734ab7be12e]
stable/5.4: [6f2198914fb9aac286a6ff6cf09b23752141e04f]
stable/6.1: [bd72ab5e6fc1c4d3e6b84636141d26a41b977b03]

CVE-2022-50265: kcm: annotate data-races around kcm->rx_wait

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50265

Introduced by commit ab7ac4e ("kcm: Kernel Connection Multiplexor
module") in v4.6-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f1f7122bb2ef056afc6f91ce4c35ab6df1207c8d]
mainline: [0c745b5141a45a076f1cb9772a399f7ebcb0948a]
stable/5.10: [e2a28807b1ceaa309164b92c38d73d12feea33df]
stable/5.15: [62086d1c4602e4f2ec07b975165afc2ed0ff1be9]
stable/5.4: [663682cd3192dd4f3547b7890a4391c72441001d]
stable/6.1: [0c745b5141a45a076f1cb9772a399f7ebcb0948a]

CVE-2022-50266: kprobes: Fix check for probe enabled in kill_kprobe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50266

Introduced by commit 3031313 ("kprobes: Fix to check probe enabled
before disarm_kprobe_ftrace()") in v5.9-rc7.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
mainline: [0c76ef3f26d5ef2ac2c21b47e7620cff35809fbb]
stable/6.1: [c909985dd0c0f74b61e3f8f0e04bf8aa9c8b97c7]

CVE-2022-50267: mmc: rtsx_pci: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50267

Introduced by commit ff984e5 ("mmc: Add realtek pcie sdmmc host
driver") in v3.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c87db77423a282b3b38b8a6daf057b822680516]
stable/5.15: [30dc645461dfc63e52b3af8ee4a98e17bf14bacf]
stable/6.1: [ffa9b2a79e3e959683efbad3f6db937eca9d38f5]

CVE-2022-50268: mmc: moxart: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50268

Introduced by commit 1b66e94 ("mmc: moxart: Add MOXA ART SD/MMC
driver") in v3.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c7e9a2059fb943fc3c3fa12261518fd72a0fc136]
cip/4.4-st: [8db6e8190cc413a915f1764681c29afac7e8cf7d]
mainline: [0ca18d09c744fb030ae9bc5836c3e357e0237dea]
stable/5.10: [7c3b301ca8b0cab392c71da8fcdfa499074f8e97]
stable/5.15: [f0502fe86a2db2336c9498d2de3e97f22dcf85ae]
stable/5.4: [b174f2b36c638fc7737df6c8aac1889a646be98f]
stable/6.1: [40aa73c70e8a5706f9cbe01409a5e51cc0f1750e]

CVE-2022-50269: drm/vkms: Fix memory leak in vkms_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50269

Introduced by commit 2df7af9 ("drm/vkms: Add vkms_config type") in v5.12-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d0b368b9d104b437e1f4850ae94bdb9a3601e89]
stable/5.15: [bad13de764888b765ceaa4668893b52bd16653cc]
stable/6.1: [bebd60ec3bf21062f103e32e6203c6daabdbd51b]

CVE-2022-50270: f2fs: fix the assign logic of iocb

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50270

Introduced by commit bd984c0 ("f2fs: show more DIO information in
tracepoint") in v5.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0db18eec0d9a7ee525209e31e3ac2f673545b12f]
stable/6.1: [b4244ca341ea95c52ee8fa93d04f5af3e584dd37]

CVE-2022-50271: vhost/vsock: Use kvmalloc/kvfree for larger packets.

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50271

Introduced by commit 433fc58 ("VSOCK: Introduce vhost_vsock.ko") in v4.8-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7aac8c63f604e6a6a46560c0f0188cd0332cf320]
mainline: [0e3f72931fc47bb81686020cc643cde5d9cd0bb8]
stable/5.10: [b4a5905fd2ef841cd61e969ea692c213c2e5c1f7]
stable/5.15: [e28a4e7f0296824c61a81e7fd54ab48bad3e75ad]
stable/5.4: [e6d0152c95108651f1880c1ddfab47cb9e3e62d0]
stable/6.1: [0e3f72931fc47bb81686020cc643cde5d9cd0bb8]

CVE-2022-50272: media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50272

Introduced by commit 76f9a82 ("V4L/DVB: AZ6027: Initial import of the
driver") in v2.6.34-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7abfe467cd685f5da7ecb415441e45e3e4e2baa8]
cip/4.4-st: [b36b2c4da770e46d61ea520867d7869fba9079bf]
mainline: [0ed554fd769a19ea8464bb83e9ac201002ef74ad]
stable/5.10: [559891d430e3f3a178040c4371ed419edbfa7d65]
stable/5.15: [210fcf64be4db82c0e190e74b5111e4eef661a7a]
stable/5.4: [8b256d23361c51aa4b7fdb71176c1ca50966fb39]
stable/6.1: [6b60cf73a931af34b7a0a3f467a79d9fe0df2d70]

CVE-2022-50273: f2fs: fix to do sanity check on destination blkaddr
during recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50273

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by 93770ab7 ("f2fs: introduce
DATA_GENERIC_ENHANCE") in 5.2-rc1.

Fixed status
mainline: [0ef4ca04a3f9223ff8bc440041c524b2123e09a3]
stable/5.10: [73fb4bd2c055a393816f078f158cdd3025006f1d]
stable/5.15: [ed854f10e6afd5cbd5c3274d4c4df4bfe0ab4362]
stable/5.4: [68b1e607559d3dc85f94b0d738d7c4e8029b0cfa]
stable/6.1: [0ef4ca04a3f9223ff8bc440041c524b2123e09a3]

CVE-2022-50274: media: dvbdev: adopts refcnt to avoid UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50274

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [219b44bf94203bd433aa91b7796475bf656348e5]
mainline: [0fc044b2b5e2d05a1fa1fb0d7f270367a7855d79]
stable/5.10: [2abd73433872194bccdf1432a0980e4ec5273c2a]
stable/5.15: [88a6f8a72d167294c0931c7874941bf37a41b6dd]
stable/5.4: [6d18b44bb44e1f4d97dfe0efe92ac0f0984739c2]
stable/6.1: [9945d05d6693710574f354c5dbddc47f5101eb77]

CVE-2022-50275: drm/radeon: Add the missed acpi_put_table() to fix memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50275

Introduced by commit 268ba0a ("drm/radeon: implement ACPI VFCT vbios
fetch (v3)") in v3.6-rc3.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4760fa67aff6bd8ef0b14c1fa04c295e734c7309]
mainline: [10276a20be1115e1f76c189330da2992df980eee]
stable/5.10: [b4b30f56ec512e2c35fc0761bc90b0e519d8fa6e]
stable/5.15: [6d25bc63708145c10f9c099d5c005602a7f2ef5f]
stable/5.4: [a0f26560be2c566b62331cb0eeffa52929aa4d44]
stable/6.1: [9e203e437310f61fdf3c1107f41f85864cf4f6b1]

CVE-2022-50276: power: supply: fix null pointer dereferencing in
power_supply_get_battery_info

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50276

Introduced by commit 3afb50d ("power: supply: core: Add some helpers
to use the battery OCV capacity table") in v5.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [104bb8a663451404a26331263ce5b96c34504049]
stable/5.10: [5beadb55f4e36fafe5d6df5dcd5f85d803f3f134]
stable/5.15: [d21534ab4fd7883e1c8037a76671d4e8b6ea14cb]
stable/5.4: [8ea68b4e3fa9392ef9dae303abc8735a033c280f]
stable/6.1: [b8131efb89d9f837c9244f900f0fc2699fd1181d]

CVE-2022-50277: ext4: don't allow journal inode to have encrypt flag

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50277

Introduced by commit 38ea50d ("ext4: support direct I/O with fscrypt
using blk-crypto") in v5.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [86cc7f501b1cfb797090d1aebf6b933f5dcb93a5]
mainline: [105c78e12468413e426625831faa7db4284e1fec]
stable/5.10: [a41d63f2047169ff05c3225ff6a8da5f0df141dc]
stable/5.15: [58fef3ebc83cfaeffa1f24182f3394248c0da907]
stable/5.4: [b47c6901094352ecb541a0936b26efa92929fea2]
stable/6.1: [bcc5057e1781a3ee889225480d995c3b5cbde555]

CVE-2022-50278: PNP: fix name memory leak in pnp_alloc_dev()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50278

Introduced by commit 1fa5ae8 ("driver core: get rid of struct device's
bus_id string array") in v2.6.30-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bbcf772216aa237036cc3ae3158288d0a95aaf4d]
cip/4.4-st: [56d3ebc1a82965c37ddfd35eeb77b44b683e5a87]
mainline: [110d7b0325c55ff3620073ba4201845f59e22ebf]
stable/5.10: [dac87e295cddc8ab316cff14ab2071b5221d84fa]
stable/5.15: [c12b314bb23dc0c83e03402cc84574700947e3b2]
stable/5.4: [81b024df4755e6bb6993b786584eca6eabbb9791]
stable/6.1: [290dd73b943c95c006df973257076ff163adf4d0]

CVE-2022-50279: wifi: rtlwifi: Fix global-out-of-bounds bug in
_rtl8812ae_phy_set_txpower_limit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50279

Introduced by commit 21e4b07 ("rtlwifi: rtl8821ae: Move driver from
staging to regular tree") in v3.18-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fc3442247716fc426bbcf62ed65e086e48a6d44f]
mainline: [117dbeda22ec5ea0918254d03b540ef8b8a64d53]
stable/5.10: [1e950b9a841bc96e98ee25680d5c7aa305120be1]
stable/5.15: [0c962dcd6bf64b78eaffc09e497a2beb4e48bc32]
stable/5.4: [28ea268d95e57cdf6394a058f0d854206d478772]
stable/6.1: [f1fe40120de6ad4ffa8299fde035a5feba10d4fb]

CVE-2022-50280: pnode: terminate at peers of source

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50280

Introduced by commit f2ebb3a ("smarter propagate_mnt()") in v3.15-rc1.
Introduced by commit 5ec0811 ("propogate_mnt: Handle the first
propogated copy being a slave") in v4.6-rc7.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [7f57df69de7f05302fad584eb8e3f34de39e0311]
cip/4.4-st: [5f42cabfcb67a45d0ab251405177274c57457c4f]
mainline: [11933cf1d91d57da9e5c53822a540bbdc2656c16]
stable/5.10: [b591b2919d018ef91b4a9571edca94105bcad3df]
stable/5.15: [c24cc476acd8bccb5af54849aac5e779d8223bf5]
stable/5.4: [2dae4211b579ce98985876a73a78466e285238ff]
stable/6.1: [784a4f995ee24460aa72e00b085612fad57ebce5]

CVE-2022-50281: MIPS: SGI-IP27: Fix platform-device leak in
bridge_platform_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50281

Introduced by commit 5dc76a9 ("MIPS: PCI: use information from 1-wire
PROM for IOC3 detection") in v5.5-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11bec9cba4de06b3c0e9e4041453c2caaa1cbec1]
stable/5.10: [da2aecef866b476438d02c662507a0e4e818da9d]
stable/5.15: [93296e7ab774230b7c36541dead10b6da39b650f]
stable/6.1: [11bec9cba4de06b3c0e9e4041453c2caaa1cbec1]

CVE-2022-50282: chardev: fix error handling in cdev_device_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50282

Introduced by commit 233ed09 ("chardev: add helper function to
register char devs with a struct device") in v4.12-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [34d17b39bceef25e4cf9805cd59250ae05d0a139]
cip/4.4-st: [f158b59aeda1d88ec33bcdd3c7f6823cdf8be565]
mainline: [11fa7fefe3d8fac7da56bc9aa3dd5fb3081ca797]
stable/5.10: [c46db6088bccff5115674d583fef46ede80077a2]
stable/5.15: [28dc61cc49c6e995121c6d86bef4b73df78dda80]
stable/5.4: [d85b5247a79355b8432bfd9ac871f96117f750d4]
stable/6.1: [85a5660491b507d33662b8e81c142e6041e642eb]

CVE-2022-50283: mtd: core: add missing of_node_get() in dynamic partitions code

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50283

Introduced by commit ad9b10d ("mtd: core: introduce of support for
dynamic partitions") in v6.0-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12b58961de0bd88b3c7dfa5d21f6d67f4678b780]
stable/6.1: [12b58961de0bd88b3c7dfa5d21f6d67f4678b780]

CVE-2022-50284: ipc: fix memory leak in init_mqueue_fs()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50284

Introduced by commit dc55e35 ("ipc: Store mqueue sysctls in the ipc
namespace") in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12b677f2c697d61e5ddbcb6c1650050a39392f54]
stable/6.1: [28dad915abe46d38c5799a0c8130e9a2a1540385]

CVE-2022-50285: mm,hugetlb: take hugetlb_lock before decrementing
h->resv_huge_pages

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50285

Introduced by commit a88c769 ("mm: hugetlb: fix hugepage memory leak
caused by wrong reserve count") in v4.4-rc5.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2b35432d324898ec41beb27031d2a1a864a4d40e]
cip/4.4-st: [f9c1a649bf448f3048c1a39bc95c4936154c7563]
mainline: [12df140f0bdfae5dcfc81800970dd7f6f632e00c]
stable/5.10: [568e3812b1778b4c0c229649b59977d88f400ece]
stable/5.15: [112a005d1ded04a4b41b6d01833cc0bda90625cc]
stable/5.4: [11993652d0b49e27272db0a37aa828d8a3a4b92b]
stable/6.1: [12df140f0bdfae5dcfc81800970dd7f6f632e00c]

CVE-2022-50286: ext4: fix delayed allocation bug in ext4_clu_mapped
for bigalloc + inline

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50286

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected function was added by 0b02f4c ("ext4: fix reserved cluster
accounting at delayed write time") in 4.20-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [1ed1eef0551bebee8e56973ccd0900e3578edfb7]
mainline: [131294c35ed6f777bd4e79d42af13b5c41bf2775]
stable/5.10: [9404839e0c9db5a517ea83c0ca3388b39d105fdf]
stable/5.15: [d440d6427a5e3a877c1c259b8d2b216ddb65e185]
stable/5.4: [6f4200ec76a0d31200c308ec5a71c68df5417004]
stable/6.1: [81b915181c630ee1cffa052e52874fe4e1ba91ac]

CVE-2022-50287: drm/i915/bios: fix a memory leak in generate_lfp_data_ptrs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50287

Introduced by commit a87d0a8 ("drm/i915/bios: Generate LFP data table
pointers if the VBT lacks them") in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1382901f75a5a7dc8eac05059fd0c7816def4eae]
stable/6.1: [7c852e8f93f04e57c1e3883caa72542469c6c4c4]

CVE-2022-50288: qlcnic: prevent ->dcb use-after-free on
qlcnic_dcb_enable() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50288

Introduced by commit 3c44bba ("qlcnic: Disable DCB operations from
SR-IOV VFs") in v3.14-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d12a7510293d3370b234b0b7c5eda33e58786768]
cip/4.4-st: [e22ac280fe43fcc720c34b49460645986f2dbeaa]
mainline: [13a7c8964afcd8ca43c0b6001ebb0127baa95362]
stable/5.10: [513787ff9a331b461115e8a145a983d650a84fcb]
stable/5.15: [95df720e64a6409d8152827a776c43f615e3321a]
stable/5.4: [8f97eeb02a553cdc78c83a0596448a370e1518c4]
stable/6.1: [a2a694e6edbdb3efb34e1613a31fdcf6cf444a55]

CVE-2022-50289: ocfs2: fix memory leak in ocfs2_stack_glue_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50289

Introduced by commit 3878f11 ("ocfs2: Move the hb_ctl_path sysctl into
the stack glue.") in v2.6.26-rc7.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b0822faebd79971617abd495beb2d6f5356b88bf]
cip/4.4-st: [dee087ca456917628b772b5719aea8ae90f12796]
mainline: [13b6269dd022aaa69ca8d1df374ab327504121cf]
stable/5.10: [f5f2682d3a34dd8350bf63f232d885fd95f25b92]
stable/5.15: [61d68cf2ba79128c48d4b3fa4d10c34dc18ba572]
stable/5.4: [7c8bf45cea9c8d6fb3e14d8cd5ae60e0372f39b7]
stable/6.1: [0b2128b70849f2728949babfc1c760096ef72f5d]

CVE-2022-50290: wifi: mac80211: fix memory leak in ieee80211_if_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50290

Introduced by commit 5a49051 ("mac80211: use per-CPU TX/RX
statistics") in v4.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13e5afd3d773c6fc6ca2b89027befaaaa1ea7293]
stable/5.10: [b2c0b94f48373ee743a4d63825a9d52364418837]
stable/5.15: [2e32f1299814e8aa2e75aa58704543a36ea3e201]
stable/6.1: [9a50a7f64243bd21a84353c371f3977b9ffd9fa5]

CVE-2022-50291: kcm: annotate data-races around kcm->rx_psock

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50291

Introduced by commit ab7ac4e ("kcm: Kernel Connection Multiplexor
module") in v4.6-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1b8a5692ab25db4ef1c2cc8e5d21f7a65dc3d079]
mainline: [15e4dabda11b0fa31d510a915d1a580f47dfc92e]
stable/5.10: [c325f92d8d9b223d5842609ca067e898e9d34566]
stable/5.15: [342d918cf9a45df9cf11bbe7162b851adefd178f]
stable/5.4: [e94395e916b48a5b912a0a04570981b5b091acb0]
stable/6.1: [15e4dabda11b0fa31d510a915d1a580f47dfc92e]

CVE-2022-50292: drm/msm/dp: fix bridge lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50292

Introduced by commit c3bf8e2 ("drm/msm/dp: Add eDP support via
aux_bus") in v5.19-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16194958f888d63839042d1190f7001e5ddec47b]
stable/6.1: [16194958f888d63839042d1190f7001e5ddec47b]

CVE-2022-50293: btrfs: do not BUG_ON() on ENOMEM when dropping extent
items for a range

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50293

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [162d053e15fe985f754ef495a96eb3db970c43ed]
stable/5.15: [50f993da945074b2a069da099a0331b23a0c89a0]
stable/6.1: [1baf3370e2dc5e6bd1368348736189457dab2a27]

CVE-2022-50294: wifi: libertas: fix memory leak in lbs_init_adapter()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50294

Introduced by commit 7919b89 ("libertas: convert libertas driver to
use an event/cmdresp queue") in v2.6.26-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [98e0ff6980c89239d9e5d3da90d791c2383dc23a]
cip/4.4-st: [2c3d08be6e4f3026f8bd11f89114ba6f5a0389f9]
mainline: [16a03958618fb91bb1bc7077cf3211055162cc2f]
stable/5.10: [9c8f50c7433bdfba1588831c413136ecc3f29f99]
stable/5.15: [037f84c0bfae5c436c651d0e804264e2648010ec]
stable/5.4: [23b34e08de5c2380414c9d3c33e8235094bcccae]
stable/6.1: [653d13a73e498d0bb6aeaf689aaa960defa7878b]

CVE-2022-50295: io_uring/msg_ring: Fix NULL pointer dereference in
io_msg_send_fd()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50295

Introduced by commit e6130eb ("io_uring: add support for passing fixed
file descriptors") in v6.0-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16bbdfe5fb0e78e0acb13e45fc127e9a296913f2]
stable/6.1: [16bbdfe5fb0e78e0acb13e45fc127e9a296913f2]

CVE-2022-50296: UM: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50296

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [844748412be03a236dcf4a208b588162a275e189]
cip/4.4-st: [18df6180e3802866a092fabb1dfd6742d6b6bea9]
mainline: [16c546e148fa6d14a019431436a6f7b4087dbccd]
stable/5.10: [6a73e6edcbf3cdd82796dcdf0c0f5fe5d91021af]
stable/5.15: [7efe61dc6aa45aab8a40e304fa2dae21e33b0db4]
stable/5.4: [cd251d39b13485eb94ee65bb000d024e02c00e45]
stable/6.1: [16c546e148fa6d14a019431436a6f7b4087dbccd]

CVE-2022-50297: wifi: ath9k: verify the expected usb_endpoints are present

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50297

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [d64436af0bc3c9e579be761d7684f228fb95f3bb]
cip/4.4-st: [c75627585b598c6a41c0e5a0c4155e0867199fee]
mainline: [16ef02bad239f11f322df8425d302be62f0443ce]
stable/5.10: [1824ccabee5445347b83642e4087cc2eca070343]
stable/5.15: [c319196a0e34ed2e66d6f876f58d8d446335c2a7]
stable/5.4: [ca57748593ddd8e46d033fbaeb9d01ec533a6bfe]
stable/6.1: [0b7e6d681e00a96cde2b32a15ffa70e1be2e3209]

CVE-2022-50298: slimbus: qcom-ngd: cleanup in probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50298

Introduced by commit e1ae85e ("slimbus: qcom-ngd-ctrl: add Protection
Domain Restart Support") in v5.11-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16f14551d0df9e7cd283545d7d748829594d912f]
stable/5.15: [1d567179f27788925dc90fe5e905cdabfce7d190]
stable/6.1: [16f14551d0df9e7cd283545d7d748829594d912f]

CVE-2022-50299: md: Replace snprintf with scnprintf

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50299

Introduced by commit 7660388 ("md/raid0: replace printk() with
pr_*()") in v4.10-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [897b1450abe5a67c842a5d24173ce4449ccdfa94]
mainline: [1727fd5015d8f93474148f94e34cda5aa6ad4a43]
stable/5.10: [76694e9ce0b2238c0a5f3ba54f9361dd3770ec78]
stable/5.15: [5d8259c9d1915a50c60c7d6e9e7fb9b7da64a175]
stable/5.4: [97238b88583c27c9d3b4a0cedb45f816523f17c3]
stable/6.1: [1727fd5015d8f93474148f94e34cda5aa6ad4a43]

CVE-2022-50300: btrfs: fix extent map use-after-free when handling
missing device in read_one_chunk

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50300

Introduced by commit adfb69a ("btrfs: add_missing_dev() should return
the actual error") in v4.15-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1742e1c90c3da344f3bb9b1f1309b3f47482756a]
stable/5.15: [b8e7ed42bc3ca0d0e4191ee394d34962d3624c22]
stable/6.1: [169a4cf46882974d4db6d85eb623ec898e51bbc0]

CVE-2022-50301: iommu/omap: Fix buffer overflow in debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50301

Introduced by commit bd4396f ("iommu/omap: Consolidate OMAP IOMMU
modules") in v3.19-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [648472df221f2bbffb433b964bcb87baccc586d8]
cip/4.4-st: [75660b1a2e68f809c68db56974ee7b836ce96a5d]
mainline: [184233a5202786b20220acd2d04ddf909ef18f29]
stable/5.10: [2fee0dbfaeaaa4bda04279ce772c4572b1429d04]
stable/5.15: [0c7043a5b5c3b35f5dc8875757f71e7f491d64d4]
stable/5.4: [4010a1afaae1c0fb9c2cac5de703bed29b1f1782]
stable/6.1: [184233a5202786b20220acd2d04ddf909ef18f29]

CVE-2022-50302: lockd: set other missing fields when unlocking files

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50302

Introduced by commit aec1582 ("lockd: set fl_owner when unlocking
files") in v5.19-rc7.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [18ebd35b61b4693a0ddc270b6d4f18def232e770]
stable/5.10: [31c93ee5f1e4dc278b562e20f3c3274ac34997f3]
stable/5.15: [95d42a8d3d4ae84a0bd3ee23e1fee240cdf0a9f0]
stable/6.1: [d7aa9f7778316beb690f6e2763b6d672ad8b256f]

CVE-2022-50303: drm/amdkfd: Fix double release compute pasid

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50303

Introduced commit is not determined.Fixed in v6.2-rc1.
Introduced by 4a488a7 ("amdkfd: Add amdkfd skeleton driver") in 3.19-rc1.

Fixed status
mainline: [1a799c4c190ea9f0e81028e3eb3037ed0ab17ff5]
stable/6.1: [a02c07b619899179384fde06f951530438a3512d]

CVE-2022-50304: mtd: core: fix possible resource leak in init_mtd()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50304

Introduced by commit 445caaa ("mtd: Allocate bdi objects dynamically")
in v4.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1aadf01e5076b9ab6bf294b9622335c651314895]
stable/6.1: [26c304a3f136009c5a2a04e2bf3ac6aa25aabcb4]

CVE-2022-50305: ASoC: sof_es8336: fix possible use-after-free in
sof_es8336_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50305

Introduced by commit 89cdb22 ("ASoC: sof_es8336: reduce pop noise on
speaker") in v6.1-rc6.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b41beaa7a58467505ec3023af8aad74f878b888]
stable/6.1: [390a1a98288a53b2e7555097d83c6e55d579b166]

CVE-2022-50306: ext4: fix potential out of bound read in ext4_fc_replay_scan()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50306

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected functions were implemented by 8016e29 ("ext4: fast commit
recovery path") in 5.10-rc1.

Fixed status
mainline: [1b45cc5c7b920fd8bf72e5a888ec7abeadf41e09]
stable/5.15: [6969367c1500c15eddc38fda12f6d15518ad6d03]
stable/6.1: [1b45cc5c7b920fd8bf72e5a888ec7abeadf41e09]

CVE-2022-50307: s390/cio: fix out-of-bounds access on cio_ignore free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50307

Introduced by commit 172da89 ("s390/cio: avoid excessive
path-verification requests") in v5.15-rc4.
Introduced by commit 0c3812c ("s390/cio: derive cdev information only
for IO-subchannels") in v5.16-rc1.
Fixed in v6.1-rc3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [1b6074112742f65ece71b0f299ca5a6a887d2db6]
stable/5.15: [0e501fd0f38e42304bfa0d46a812d93f80294a87]
stable/6.1: [1b6074112742f65ece71b0f299ca5a6a887d2db6]

CVE-2022-50308: ASoC: qcom: Add checks for devm_kcalloc

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50308

Introduced by commit 24caf8d ("ASoC: qcom: lpass-sc7180: Add platform
driver for lpass audio") in v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bf5ee979076ceb121ee51c95197d890b1cee7f4]
stable/5.10: [4518d7cc38b7d1a7ce5a7878ca601c91e19fe47d]
stable/5.15: [f849c116d320e85d1e2c2804c0edb0be3953b62d]
stable/6.1: [b1e4f92dd0c1d3c162d7ca6c1196995565cca96d]

CVE-2022-50309: media: xilinx: vipp: Fix refcount leak in xvip_graph_dma_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50309

Introduced by commit df33051 ("[media] v4l: xilinx: Add Xilinx Video
IP core") in v4.1-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3c38467c3255c428cdbd3cefaccca4662f302dc9]
cip/4.4-st: [628dec9f97f3adb0a2544bcb7c540debee2769a7]
mainline: [1c78f19c3a0ea312a8178a6bfd8934eb93e9b10a]
stable/5.10: [2630cc88327a5557aa0d9cc63be95e3c6e0a55b3]
stable/5.15: [2ea7caa9684687cf3adc1467cf4af3653a776192]
stable/5.4: [59b315353252abe7b8fdb8651ca31b8484ce287a]
stable/6.1: [1c78f19c3a0ea312a8178a6bfd8934eb93e9b10a]

CVE-2022-50310: ip6mr: fix UAF issue in ip6mr_sk_done() when
addrconf_init_net() failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50310

Introduced by commit 7d9b1b5 ("ip6mr: fix use-after-free in
ip6mr_sk_done()") in v5.18-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ca695207ed2271ecbf8ee6c641970f621c157cc]
stable/6.1: [1ca695207ed2271ecbf8ee6c641970f621c157cc]

CVE-2022-50311: cxl: Fix refcount leak in cxl_calc_capp_routing

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50311

Introduced by commit f24be42 ("cxl: Add psl9 specific code") in v4.12-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ee870f72465015327ad96204b0e92450d04870cd]
mainline: [1d09697ff22908ae487fc8c4fbde1811732be523]
stable/5.10: [81c8bbf5b2b5f0c8030fff1716c00849cda8571a]
stable/5.15: [6a310e8db5409676b4b3e6c1f54dff174e4fd04d]
stable/5.4: [f2d60f6ba173cded65081cee690b67802395a479]
stable/6.1: [2d7b6580384e6d65419933ddc525bd176095da54]

CVE-2022-50312: drivers: serial: jsm: fix some leaks in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50312

Introduced by commit 03a8482 ("drivers: serial: jsm: Enable support
for Digi Classic adapters") in v3.19-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6066bd69ffba3a6abc7c0793ccba1da79b7d77e3]
cip/4.4-st: [f68d482d950ad961707bf3fc4137da218c378f8f]
mainline: [1d5859ef229e381f4db38dce8ed58e4bf862006b]
stable/5.10: [71ffe5111f0ffa2fd43c14fd176c6f05d4e82212]
stable/5.15: [6be8e565a4a60530797a974d0a3d0e30656166a1]
stable/5.4: [744c2d33a88b082d9d504520f0132b3d688547b2]
stable/6.1: [1d5859ef229e381f4db38dce8ed58e4bf862006b]

CVE-2022-50313: erofs: fix order >= MAX_ORDER warning due to crafted
negative i_size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50313

Introduced by commit 431339b ("staging: erofs: add inode operations")
in v4.19-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dd73601a1cba37a0ed5f89a8662c90191df5873]
stable/5.10: [0ab621fcdff1a58ff4de51a8590fa92a0ecd34be]
stable/5.15: [acc2f40b980c61a9178b72cdedd150b829064997]
stable/5.4: [17a0cdbd7b0cf0fc0d7ca4187a67f8f1c18c291f]
stable/6.1: [1dd73601a1cba37a0ed5f89a8662c90191df5873]

CVE-2022-50314: nbd: Fix hung when signal interrupts nbd_start_device_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50314

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by e46c728 ("nbd: add a basic netlink
interface") in 4.12-rc1.

Fixed status
cip/4.19-st: [c7b4641bd2395c2f3cd3b0a0cbf292ed9d489398]
mainline: [1de7c3cf48fc41cd95adb12bd1ea9033a917798a]
stable/5.10: [b2700f98b3f4dd19fb4315b70581e5caff89eb49]
stable/5.15: [c0d73be0af8c1310713bc39a8d7a22e35084e14f]
stable/5.4: [3575949513ea3b387b30dac1e69468a923c86caf]
stable/6.1: [1de7c3cf48fc41cd95adb12bd1ea9033a917798a]

CVE-2022-50315: ata: ahci: Match EM_MAX_SLOTS with SATA_PMP_MAX_PORTS

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50315

Introduced commit is not determined.Fixed in v6.1-rc2.


Fixed status
cip/4.19-st: [67a00c299c5c143817c948fbc7de1a2fa1af38fb]
cip/4.4-st: [1057ffaaa91c056af75a437ba2de98b3ab4212e1]
mainline: [1e41e693f458eef2d5728207dbd327cd3b16580a]
stable/5.10: [303d0f761431d848dd8d7ff9fd9b8c101879cabe]
stable/5.15: [8fbe13de1cc7cef2564be3cbf60400b33eee023b]
stable/5.4: [383b7c50f5445ff8dbbf03080905648d6980c39d]
stable/6.1: [1e41e693f458eef2d5728207dbd327cd3b16580a]

CVE-2022-50316: orangefs: Fix kmemleak in orangefs_sysfs_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50316

Introduced commit is not determined.Fixed in v6.2-rc1.
kobject was used since commit dc3012a ("orangefs: remove dead code in
sysfs") in 4.9-rc1.

Fixed status
mainline: [1f2c0e8a587bcafad85019a2d80f158d8d41a868]
stable/6.1: [22409490294180c39be7dd0e5b2667d41556307d]

CVE-2022-50317: drm/bridge: megachips: Fix a null pointer dereference bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50317

Introduced by commit 11632d4 ("drm/bridge: megachips: Ensure both
bridges are probed before registration") in v5.17-rc1.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [5bc20bafcd87ba0858ab772cefc7047cb51bc249]
mainline: [1ff673333d46d2c1b053ebd0c1c7c7c79e36943e]
stable/5.10: [877e92e9b1bdeb580b31a46061005936be902cd4]
stable/5.15: [4610e7a4111fa3f3ce27c09d6d94008c55f1cd31]
stable/5.4: [1daf69228e310938177119c4eadcd30fc75c81e0]
stable/6.1: [1ff673333d46d2c1b053ebd0c1c7c7c79e36943e]

CVE-2022-50318: perf/x86/intel/uncore: Fix reference count leak in
hswep_has_limit_sbox()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50318

Introduced by commit 9d48015 ("perf/x86/intel/uncore: Remove uncore
extra PCI dev HSWEP_PCI_PCU_3") in v5.12.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [5a96c10a56037db006ba6769307a9731cf6073be]
mainline: [1ff9dd6e7071a561f803135c1d684b13c7a7d01d]
stable/5.10: [c0539d5d474ee6fa4ebc41f927a0f98f81244f25]
stable/5.15: [3485f197518061371568f842405159aa9e4df551]
stable/5.4: [e293263248f25c6b8aa1caf7c1103d40aa03311e]
stable/6.1: [bd66877c0b3b42eed0ecee0bd2a2a505c1e54177]

CVE-2022-50319: coresight: trbe: remove cpuhp instance node before
remove cpuhp state

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50319

Introduced by commit 3fbf7f0 ("coresight: sink: Add TRBE driver") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20ee8c223f792947378196307d8e707c9cdc2d61]
stable/5.15: [18b9202188a4e59923834c60b5c82ea1da7d1811]
stable/6.1: [3c18888bc0b51835c74123b1e04d5df11543724c]

CVE-2022-50320: ACPI: tables: FPDT: Don't call acpi_os_map_memory() on
invalid phys address

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50320

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by d1eb86e ("ACPI: tables: introduce
support for FPDT table") in 5.12-rc1-dontuse.

Fixed status
mainline: [211391bf04b3c74e250c566eeff9cf808156c693]
stable/5.15: [30eca146c89d216dda95868ce00a2d35cf73d5a4]
stable/6.1: [211391bf04b3c74e250c566eeff9cf808156c693]

CVE-2022-50321: wifi: brcmfmac: fix potential memory leak in
brcmf_netdev_start_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50321

Introduced by commit 270a6c1 ("brcmfmac: rework headroom check in
.start_xmit()") in v4.13-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e5d01e85cf46628647cd696cb72ba4659b18967f]
mainline: [212fde3fe76e962598ce1d47b97cc78afdfc71b3]
stable/5.10: [e08e6812efb6a8c676e733de0518594d1517e0d9]
stable/5.15: [e8ef89e5b89ee041a94eecfb6c31fcc237f9168c]
stable/5.4: [d869a189505224601e310c7769cb90b0e2f60b31]
stable/6.1: [7f159116d620615779adbf88a5d94713702216d8]

CVE-2022-50322: rtc: msc313: Fix function prototype mismatch in
msc313_rtc_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50322

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected function was added by be7d9c9 ("rtc: Add support for the
MSTAR MSC313 RTC") in 5.16-rc1.

Fixed status
mainline: [21b8a1dd56a163825e5749b303858fb902ebf198]
stable/6.1: [ba50fee6b41bcbafaeed3c51f90d37d1480ff9a0]

CVE-2022-50323: net: do not sense pfmemalloc status in skb_append_pagefrags()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50323

Introduced by commit 3261400 ("tcp: TX zerocopy should not sense
pfmemalloc status") in v6.0-rc5.
Fixed in v6.1-rc3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [228ebc41dfab5b5d34cd76835ddb0ca8ee12f513]
stable/5.15: [92b4c5c3fa810212da20088bcc6c0a77fc8607bd]
stable/6.1: [228ebc41dfab5b5d34cd76835ddb0ca8ee12f513]

CVE-2022-50324: mtd: maps: pxa2xx-flash: fix memory leak in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50324

Introduced by commit e644f7d ("[MTD] MAPS: Merge Lubbock and Mainstone
drivers into common PXA2xx driver") in v2.6.24-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6fa9550ef3e13d7e9b2d4db6dd57292ccd072a90]
cip/4.4-st: [990f8169451637ad7f27ad6a74a8fe745b53faa5]
mainline: [2399401feee27c639addc5b7e6ba519d3ca341bf]
stable/5.10: [1d0c2b762dad2b8dd166e17c0e90b88b86a3284f]
stable/5.15: [f35981083cb3fc1ba6427c1543152c5e3f59d104]
stable/5.4: [cf9c4c25caad05c6b492cbba739a467511814279]
stable/6.1: [a1b061cafdbcb1ff259731f30e2bdc1de64dcaba]

CVE-2022-50325: ASoC: Intel: avs: Fix potential RX buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50325

Introduced by commit f14a1c5 ("ASoC: Intel: avs: Add module management
requests") in v5.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23ae34e033b2c0e5e88237af82b163b296fd6aa9]
stable/6.1: [0bad12fee5ae16ab439d97c66c4238f5f4cc7f68]

CVE-2022-50326: media: airspy: fix memory leak in airspy probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50326

Introduced by commit ca9dc8d ("media: airspy: respect the DMA
coherency rules") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23bc5eb55f8c9607965c20d9ddcc13cb1ae59568]
stable/6.1: [23bc5eb55f8c9607965c20d9ddcc13cb1ae59568]

CVE-2022-50327: ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50327

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected function was added by a36a7fe ("ACPI / processor_idle: Add
support for Low Power Idle(LPI) states") in 4.8-rc1.

Fixed status
mainline: [2437513a814b3e93bd02879740a8a06e52e2cf7d]
stable/5.10: [fdee7a0acc566c4194d40a501b8a1584e86cc208]
stable/5.15: [ad1190744da9d812da55b76f2afce750afb0a3bd]
stable/5.4: [8e8b5f12ee4ab6f5d252c9ca062a4ada9554e6d9]
stable/6.1: [b85f0e292f73f353eea915499604fbf50c8238b4]

CVE-2022-50328: jbd2: fix potential use-after-free in jbd2_fc_wait_bufs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50328

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by ff780b9 ("jbd2: add fast commit
machinery") in 5.10-rc1.

Fixed status
mainline: [243d1a5d505d0b0460c9af0ad56ed4a56ef0bebd]
stable/5.10: [1d4d16daec2a6689b6d3fbfc7d2078643adc6619]
stable/5.15: [d11d2ded293976a1a0d9d9471827a44dc9e3c63f]
stable/6.1: [243d1a5d505d0b0460c9af0ad56ed4a56ef0bebd]

CVE-2022-50329: block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50329

Introduced by commit 64dc8c7 ("block, bfq: fix possible uaf for
'bfqq->bic'") in v6.2-rc1.
Fixed in v6.2-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [246cf66e300b76099b5dbd3fdd39e9a5dbc53f02]
stable/5.10: [1425f1bb5df5239021fd09ebc2a5e8070e705d36]
stable/5.15: [7949b0df3dd9f4817ed4a4e989fa9ee81df6205f]
stable/6.1: [1ed959fef5b1c6f1a7a3fbea543698c30ebd6678]

CVE-2022-50330: crypto: cavium - prevent integer overflow loading firmware

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50330

Introduced by commit 9e2c7d9 ("crypto: cavium - Add Support for
Octeon-tx CPT Engine") in v4.11-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [90e483e7f20c32287d2a9da967e122938f52737a]
mainline: [2526d6bf27d15054bb0778b2f7bc6625fd934905]
stable/5.10: [3a720eb89026c5241b8c4abb33370dc6fb565eee]
stable/5.15: [172c8a24fc8312cf6b88d3c88469653fdcb1c127]
stable/5.4: [584561e94260268abe1c83e00d9c205565cb7bc5]
stable/6.1: [2526d6bf27d15054bb0778b2f7bc6625fd934905]

CVE-2022-50331: wwan_hwsim: fix possible memory leak in wwan_hwsim_dev_new()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50331

Introduced by commit f36a111 ("wwan_hwsim: WWAN device simulator") in v5.14-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [258ad2fe5ede773625adfda88b173f4123e59f45]
stable/5.15: [50c31fa952309536c6e4461ff815ddccc8dff9d5]
stable/6.1: [258ad2fe5ede773625adfda88b173f4123e59f45]

CVE-2022-50332: video/aperture: Call sysfb_disable() before removing PCI devices

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50332


This vulnerability is only affected to 6.0.x. Fixed by 25a6688f
("video/aperture: Call sysfb_disable() before removing PCI devices")
in 6.0.6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [n,e,v,e,r]

CVE-2022-50333: fs: jfs: fix shift-out-of-bounds in dbDiscardAG

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50333

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [624843f1bac448150f6859999c72c4841c14a2e3]
cip/4.4-st: [7d78f4375d21def1afee9eeb073e354bc2e3faf3]
mainline: [25e70c6162f207828dd405b432d8f2a98dbf7082]
stable/5.10: [911999b193735cd378517b6cd5fe585ee345d49c]
stable/5.15: [10b87da8fae79c7daf5eda6a9e4f1d31b85b4d92]
stable/5.4: [50163a115831ef4e6402db5a7ef487d1989d7249]
stable/6.1: [3d340b684dcec5e34efc470227cd1c7d2df121ad]

CVE-2022-50334: hugetlbfs: fix null-ptr-deref in hugetlbfs_parse_param()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50334

Introduced commit is not determined.Fixed in v6.2-rc1.
Vulnerable code was added by 32021982 ("hugetlbfs: Convert to
fs_context") in 5.1-rc1.

Fixed status
mainline: [26215b7ee923b9251f7bb12c4e5f09dc465d35f2]
stable/5.10: [dcd28191be9bbf307ba51a5b485773a55b0037c4]
stable/5.15: [9a8862820cbf1f18dca4f3b4c289d88561b3a384]
stable/5.4: [fa71639873518e3587632ae58e25e4a96b57fa90]
stable/6.1: [f2207145693ae5697a7b59e2add4b92f9e5b0e3c]

CVE-2022-50335: 9p: set req refcount to zero to avoid uninitialized usage

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50335

Introduced by commit 728356d ("9p: Add refcount to p9_req_t") in v4.20-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [26273ade77f54716e30dfd40ac6e85ceb54ac0f9]
stable/5.15: [1cabce56626a61f4f02452cba61ad4332a4b73f8]
stable/6.1: [967fc34f297e40fd2e068cf6b0c3eb4916228539]

CVE-2022-50336: fs/ntfs3: Add null pointer check to attr_load_runs_vcn

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50336

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected function was added by be71b5c ("fs/ntfs3: Add attrib
operations") in 5.15-rc1.

Fixed status
mainline: [2681631c29739509eec59cc0b34e977bb04c6cf1]
stable/5.15: [ea6b3598406c58c5d09b6f4328e09616c077597f]
stable/6.1: [1621734cd3047f7979da1d7d5c5444d583d8b0ed]

CVE-2022-50337: ocxl: fix pci device refcount leak when calling get_function_0()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50337

Introduced by commit 87db757 ("ocxl: control via sysfs whether the
FPGA is reloaded on a link reset") in v5.9-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27158c72678b39ee01cc01de1aba6b51c71abe2f]
stable/5.10: [a40e1b0a922a53fa925ea8b296e3de30a31ed028]
stable/5.15: [37a13b274e4513c757e50c002ddcbf4bc89adbb2]
stable/6.1: [40ff4c2335a98f0ee96b099bfd70b8e6644f321f]

CVE-2022-50338: binder: fix UAF of alloc->vma in race with munmap()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50338


Introduced by dd2283f ("mm: mmap: zap pages with read mmap_sem in
munmap") in 4.20-rc1. The mainline was fixed by a43cfc8 ("android:
binder: stop saving a pointer to the VMA") in 6.0-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a43cfc87caaf46710c8027a8c23b8a55f1078f19]
stable/5.15: [622ef885a89ad04cfb76ee478fb44f051125d1f1]
stable/5.4: [27a594bc7a7c8238d239e3cdbcf2edfa3bbe9a1b]

CVE-2023-53147: xfrm: add NULL check in xfrm_update_ae_params

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53147

Introduced by commit d8647b7 ("xfrm: Add user interface for esn and
big anti-replay windows") in v2.6.39-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [44f69c96f8a147413c23c68cda4d6fb5e23137cd]
cip/4.4-st: [813abdcb87be9804bc3eb2a8d9db0eb618d7d107]
mainline: [00374d9b6d9f932802b55181be9831aa948e5b7c]
stable/5.10: [bd30aa9c7febb6e709670cd5154194189ca3b7b5]
stable/5.15: [075448a2eb753f813fe873cfa52853e9fef8eedb]
stable/5.4: [8046beb890ebc83c5820188c650073e1c6066e67]
stable/6.1: [87b655f4936b6fc01f3658aa88a22c923b379ebd]

CVE-2023-53148: igb: Fix igb_down hung on surprise removal

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53148

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [124e39a734cb90658b8f0dc110847bbfc6e33792]
cip/4.4-st: [86e0a187d2ba897f109fbadca70f5709f52e14ea]
mainline: [004d25060c78fc31f66da0fa439c544dda1ac9d5]
stable/5.10: [994c2ceb70ea99264ccc6f09e6703ca267dad63c]
stable/5.15: [fa92c463eba75dcedbd8d689ffdcb83293aaa0c3]
stable/5.4: [c9f56f3c7bc908caa772112d3ae71cdd5d18c257]
stable/6.1: [39695e87d86f0e7d897fba1d2559f825aa20caeb]

CVE-2023-53149: ext4: avoid deadlock in fs reclaim with page writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53149

Introduced by commit c8585c6 ("ext4: fix races between changing inode
journal mode and ext4_writepages") in v4.7-rc1.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00d873c17e29cc32d90ca852b82685f1673acaa5]

CVE-2023-53150: scsi: qla2xxx: Pointer may be dereferenced

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53150

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [a69125a3ce88d9a386872034e7664b30cc4bcbed]
cip/4.4-st: [fb3b7444fd03bad5cd1e1e818fb2f3148eea9939]
mainline: [00eca15319d9ce8c31cdf22f32a3467775423df4]
stable/5.10: [5addd62586a94a572359418464ce0ae12fa46187]
stable/5.15: [0715da51391d223bf4981e28346770edea7eeb74]
stable/5.4: [3f22f9ddbb29dba369daddb084be3bacf1587529]
stable/6.1: [b06d1b525364bbcf4929b4b35d81945b10dc9883]

CVE-2023-53151: md/raid10: prevent soft lockup while flush writes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53151

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [00ecb6fa67c0f772290c5ea5ae8b46eefd503b83]
cip/4.4-st: [3db794acdc7eb50bc288ebbd4c9e2bae6e11a3c2]
mainline: [010444623e7f4da6b4a4dd603a7da7469981e293]
stable/5.10: [634daf6b2c81015cc5e28bf694a6a94a50c641cd]
stable/5.15: [84a578961b2566e475bfa8740beaf0abcc781a6f]
stable/5.4: [d0345f7c7dbc5d42e4e6f1db99c1c1879d7b0eb5]
stable/6.1: [1d467e10507167eb6dc2c281a87675b731955d86]

CVE-2023-53152: drm/amdgpu: fix calltrace warning in amddrm_buddy_fini

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53152

Introduced commit is not determined.Fixed in v6.5-rc1.
The psp_free_shared_bufs was introduced by da40bf8 ("drm/amdgpu/psp:
move shared buffer frees into single function") in 5.19-rc1.

Fixed status
mainline: [01382501509871d0799bab6bd412c228486af5bf]
stable/6.1: [ab6f446c220db0c131f2071846afd835799be0fb]

CVE-2023-53153: wifi: cfg80211: Fix use after free for wext

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53153

Introduced by commit fffd093 ("cfg80211: rework key operation") in v2.6.32-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a2a92b3e9d8e03ee3f9ee407fc46a9b4bd02d8b6]
mainline: [015b8cc5e7c4d7bb671f1984d7b7338c310b185b]
stable/5.10: [2cfe78619b0de6d2da773978bc2d22797212eaa7]
stable/5.15: [fd081afd21eb35b968b0330700c43ec94986e1c4]
stable/5.4: [6f1959c17d4cb5b74af6fc31dc787e1dc3e4f6e2]
stable/6.1: [22dfb21bf1cd876616d45cda1bc6daa89eec6747]

CVE-2023-53163: fs/ntfs3: don't hold ni_lock when calling truncate_setsize()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53163

Introduced by commit 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0226635c304cfd5c9db9b78c259cb713819b057e]
stable/5.15: [8414983c2e649364d8af29080a0869266b31abb6]
stable/6.1: [73fee7e1e5ea11b51c51c46e0577a197ca3602cf]

CVE-2023-53164: irqchip/ti-sci: Fix refcount leak in
ti_sci_intr_irq_domain_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53164

Introduced by commit cd844b0 ("irqchip/ti-sci-intr: Add support for
Interrupt Router driver") in v5.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02298b7bae12936ca313975b02e7f98b06670d37]
stable/5.10: [df8d3536b660c6c6f6b25fa8b157e9b38ad78142]
stable/5.15: [856fc2195494d1175ada0f1f46f92c5b28ce12eb]
stable/5.4: [07fceab32096c1290b491f2fcaace03f78e2db37]
stable/6.1: [a0d91a48e1a020fb636f0fcaf44672f123bb0799]

CVE-2023-53165: udf: Fix uninitialized array access for some pathnames

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53165

Introduced commit is not determined.Fixed in v6.5-rc1.
Vulnerable code was added by 484a10f ("udf: Merge linux specific
translation into CS0 conversion function") in 4.6-rc1.

Fixed status
cip/4.19-st: [b37f998d357102e8eb0f8eeb33f03fff22e49cbf]
mainline: [028f6055c912588e6f72722d89c30b401bbcf013]
stable/5.10: [4503f6fc95d6dee85fb2c54785848799e192c51c]
stable/5.15: [985f9666698960dfc87a106d6314203fa90fda75]
stable/5.4: [3f1368af47acf4d0b2a5fb0d2c0d6919d2234b6d]
stable/6.1: [a6824149809395dfbb5bc36bc7057cc3cb84e56d]

CVE-2023-53166: power: supply: bq25890: Fix external_power_changed race

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53166

Introduced by commit eab25b4 ("power: supply: bq25890: On the bq25892
set the IINLIM based on external charger detection") in v5.18-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [029a443b9b6424170f00f6dd5b7682e682cce92e]
stable/6.1: [72c28207c19c2c46fab8ae994aff25e197fb2949]

CVE-2023-53167: tracing: Fix null pointer dereference in tracing_err_log_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53167

Introduced by commit 8a06290 ("tracing: Add tracing error log") in v5.2-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02b0095e2fbbc060560c1065f86a211d91e27b26]
stable/5.10: [7060e5aac6dc195124c106f49106d653a416323a]
stable/5.15: [3b5d9b7b875968a8a8c99dac45cb85b705c44802]
stable/5.4: [93114cbc7cb169f6f26eeaed5286b91bb86b463b]
stable/6.1: [938d5b7a75e18264887387ddf9169db6d8aeef98]

CVE-2023-53168: usb: ucsi_acpi: Increase the command completion timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53168

Introduced by commit e080650 ("usb: typec: ucsi: acpi: Reduce the
command completion timeout") in v5.16-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02d210f434249a7edbc160969b75df030dc6934d]
stable/6.1: [1e8525f37871741a52370627633962f8bdcab15a]

CVE-2023-53169: x86/resctrl: Clear staged_config[] before and after it is used

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53169

Introduced by commit 75408e4 ("x86/resctrl: Allow different CODE/DATA
configurations to be staged") in v5.15-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0424a7dfe9129b93f29b277511a60e87f052ac6b]
stable/5.15: [86db319d25db70cf4af4557e05f6fa6f39c70003]
stable/6.1: [3fc5941ecc31a495b6b84b465f36155009db99b5]

CVE-2023-53170: net: dsa: Removed unneeded of_node_put in felix_parse_ports_node

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53170

Introduced by commit de879a0 ("net: dsa: felix: add functionality when
not all ports are supported") in v6.3-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04499f28b40bfc24f20b0e2331008bb90a54a6cf]

CVE-2023-53171: vfio/type1: prevent underflow of locked_vm via exec()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53171

Introduced by commit 73fa0d1 ("vfio: Type1 IOMMU implementation") in v3.6-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [046eca5018f8a5dd1dc2cedf87fb5843b9ea3026]
stable/5.10: [5a271242716846cc016736fb76be2b40ee49b0c3]
stable/5.15: [eafb81c50da899dd80b340c841277acc4a1945b7]
stable/6.1: [a6b2aabe664098d5cf877ae0fd96459464a30e17]

CVE-2023-53172: fsverity: reject FS_IOC_ENABLE_VERITY on mode 3 fds

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53172

Introduced by commit 56124d6 ("fsverity: support enabling with tree
block size < PAGE_SIZE") in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04839139213cf60d4c5fc792214a08830e294ff8]

CVE-2023-53173: tty: pcn_uart: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53173

Introduced commit is not determined.Fixed in v6.3-rc1.
Vulnerable code was added by 4dec5f1a ("tty: serial: pch_uart.c:
remove debugfs dentry pointer") in 5.13-rc1.

Fixed status
mainline: [04a189c720aa2b6091442113ce9b9bc93552dff8]
stable/5.15: [cf042964c2fa72950bbbf25b2cdd732b873e89db]
stable/6.1: [4459d1e7bd0421b3b6fcd745773d8823f71615ef]

CVE-2023-53174: scsi: core: Fix possible memory leak if device_add() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53174

Introduced by commit ee959b0 ("SCSI: convert struct class_device to
struct device") in v2.6.26-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [06c5340858011aa1195aec43a776e3185fbf7f56]
cip/4.4-st: [527002e75e215b8e84a1f77e3578d1e5ee7bf78b]
mainline: [04b5b5cb0136ce970333a9c6cec7e46adba1ea3a]
stable/5.10: [aa9a76d5ffdecd3b52ac333eb89361b0c9fe04e8]
stable/5.15: [6bc7f4c8c27d526f968788b8a985896755b1df35]
stable/5.4: [e12fac07f61caac9c5b186d827658b3470787619]
stable/6.1: [b191ff1f075c4875f11271cbf0093e6e044a12aa]

CVE-2023-53175: PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
during hibernation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53175

Introduced by commit dc2b453 ("PCI: hv: Rework MSI handling") in v5.17-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04bbe863241a9be7d57fb4cf217ee4a72f480e70]
stable/6.1: [223fc5352054900f70b8b5e10cfc2f297e70c512]
stable/6.6: [04bbe863241a9be7d57fb4cf217ee4a72f480e70]

CVE-2023-53176: serial: 8250: Reinit port->pm on port specific driver unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53176

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [c9e080c3005fd183c56ff8f4d75edb5da0765d2c]
cip/4.4-st: [2ca286c81c9c9cc5ac99e18e3e8535ba5fad3322]
mainline: [04e82793f068d2f0ffe62fcea03d007a8cdc16a7]
stable/5.10: [2c86a1305c1406f45ea780d06953c484ea1d9e6e]
stable/5.15: [1ba5594739d858e524ff0f398ee1ebfe0a8b9d41]
stable/5.4: [d5cd2928d31042a7c0a01464f9a8d95be736421d]
stable/6.1: [af4d6dbb1a92ea424ad1ba1d0c88c7fa2345d872]

CVE-2023-53177: media: hi846: fix usage of pm_runtime_get_if_in_use()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53177

Introduced by commit e8c0882 ("media: i2c: add driver for the SK Hynix
Hi-846 8M pixel camera") in v5.16-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04fc06f6dc1592ed5d675311ac50d8fba5db62ab]
stable/6.1: [42ec6269f98edd915ee37da3c6456bb6243ea56a]

CVE-2023-53178: mm: fix zswap writeback race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53178

Introduced commit is not determined.Fixed in v6.4-rc3.


Fixed status
mainline: [04fc7816089c5a32c29a04ec94b998e219dfb946]
stable/6.1: [2cab13f500a6333bd2b853783ac76be9e4956f8a]

CVE-2023-53179: netfilter: ipset: add the missing
IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53179

Introduced by commit 886503f ("netfilter: ipset: actually allow
allowable CIDR 0 in hash:net,port,net") in v4.20-rc2.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [e632d09dffc68b9602d6893a99bfe3001d36cefc]
cip/4.4-st: [524198e91701c882c77ac601617da0dbc99f8b3a]
mainline: [050d91c03b28ca479df13dfb02bcd2c60dd6a878]
stable/5.10: [83091f8ac03f118086596f17c9a52d31d6ca94b3]
stable/5.15: [a9e6142e5f8f6ac7d1bca45c1b2b13b084ea9e14]
stable/5.4: [109e830585e89a03d554bf8ad0e668630d0a6260]
stable/6.1: [7ca0706c68adadf86a36b60dca090f5e9481e808]
stable/6.6: [050d91c03b28ca479df13dfb02bcd2c60dd6a878]

CVE-2023-53180: wifi: ath12k: Avoid NULL pointer access during
management transmit cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53180

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected function was added by d889913 ("wifi: ath12k: driver for
Qualcomm Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [054b5580a36e435692c203c19abdcb9f7734320e]

CVE-2023-53181: dma-buf/dma-resv: Stop leaking on krealloc() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53181

Introduced by commit d3c8069 ("dma-buf: use new iterator in
dma_resv_get_fences v3") in v5.16-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05abb3be91d8788328231ee02973ab3d47f5e3d2]
stable/6.1: [19e7b9f1f7e1cb92a4cc53b4c064f7fb4b1f1983]

CVE-2023-53182: ACPICA: Avoid undefined behavior: applying zero offset
to null pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53182

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [35465c7a91c6b46e7c14d0c01d0084349a38ce51]
cip/4.4-st: [d5822e74cd1e7135404cdb1ab26651fd700a57f8]
mainline: [05bb0167c80b8f93c6a4e0451b7da9b96db990c2]
stable/5.10: [16359bc02c093b0862e31739c07673340a2106a6]
stable/5.15: [3a7a4aa3958ce0c4938a443d65001debe9a9af9c]
stable/5.4: [710e09fd116e2fa53e319a416ad4e4f8027682b6]
stable/6.1: [8c4a7163b7f1495e3cc58bec7a4100de6612cde9]

CVE-2023-53183: btrfs: exit gracefully if reloc roots don't match

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53183

Introduced commit is not determined.Fixed in v6.5-rc6.
Vulnerable code was added by e0b085b0 ("btrfs: cleanup error handling
in prepare_to_merge") in 5.13-rc1.

Fixed status
mainline: [05d7ce504545f7874529701664c90814ca645c5d]
stable/5.15: [69dd147de419b04d1d8d2ca67ef424cddd5b8fd5]
stable/6.1: [9d04716e36654275aea00fb93fc9b30b850925e7]

CVE-2023-53184: arm64/sme: Set new vector length before reallocating

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53184

Introduced by commit d4d5be9 ("arm64/fpsimd: Ensure SME storage is
allocated after SVE VL changes") in v6.5-rc3.
Fixed in v6.5-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [05d881b85b48c7ac6a7c92ce00aa916c4a84d052]
stable/6.1: [356e711640aea6ed145da9407499388b45264cb4]

CVE-2023-53185: wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53185

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9e3031eea2d45918dc44cbfc6a6029e82882916f]
cip/4.4-st: [e91301f5753d0f787bf4a9b0b08438e7b4ac0b61]
mainline: [061b0cb9327b80d7a0f63a33e7c3e2a91a71f142]
stable/5.10: [1044187e7249073f719ebbf9e5ffb4f16f99e555]
stable/5.15: [95b4b940f0fb2873dcedad81699e869eb7581c85]
stable/5.4: [4dc3560561a08842b4a4c07ccc5a90e5067dbb5b]
stable/6.1: [09740fa9827cfbaf23ecd041e602a426f99be888]

CVE-2023-53186: skbuff: Fix a race between coalescing and releasing SKBs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53186

Introduced by commit 53e0961 ("page_pool: add frag page recycling
support in page pool") in v5.15-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0646dc31ca886693274df5749cd0c8c1eaaeb5ca]
stable/5.15: [906a6689bb0191ad2a44131a3377006aa098af59]
stable/6.1: [71850b5af92da21b4862a9bc55bda61091247d00]

CVE-2023-53187: btrfs: fix use-after-free of new block group that became unused

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53187

Introduced by commit a9f1897 ("btrfs: move out now unused BG from the
reclaim list") in v6.5-rc1.
Fixed in v6.5-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [0657b20c5a76c938612f8409735a8830d257866e]
stable/6.1: [6297644db23f77c02ae7961cc542d162629ae2c4]

CVE-2023-53188: net: openvswitch: fix race on port output

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53188

Introduced by commit 7f8a436 ("openvswitch: Add conntrack action") in v4.3-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [eac61dbac3adf0ce0618961d0f51eb5881ee4d35]
cip/4.4-st: [ce4d47e20777562494adf75a349f5aac91a16b9f]
mainline: [066b86787fa3d97b7aefb5ac0a99a22dad2d15f8]
stable/5.10: [284be5db6c8d06d247ed056cfc448c4f79bbb16c]
stable/5.15: [5efcb301523baacd98a47553d4996e924923114d]
stable/5.4: [9b0dd09c1ceb35950d2884848099fccc9ec9a123]
stable/6.1: [644b3051b06ba465bc7401bfae9b14963cbc8c1c]

CVE-2023-53189: ipv6/addrconf: fix a potential refcount underflow for idev

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53189

Introduced by commit b7b1bfc ("ipv6: split duplicate address detection
and router solicitation timer") in v3.11-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [df62fdcd004afa72ecbed0e862ebb983acd3aa57]
cip/4.4-st: [4e56e28c606b2dc89d34738b28d24e6c96d132b8]
mainline: [06a0716949c22e2aefb648526580671197151acc]
stable/5.10: [2ad31ce40e8182860b631e37209e93e543790b7c]
stable/5.15: [82abd1c37d3bf2a2658b34772c17a25a6f9cca42]
stable/5.4: [c7eeba47058532f6077d6a658e38b6698f6ae71a]
stable/6.1: [436b7cc7eae7851c184b671ed7a4a64c750b86f7]

CVE-2023-53190: vxlan: Fix memory leaks in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53190

Introduced by commit f9c4bb0 ("vxlan: vni filtering support on collect
metadata device") in v5.18-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06bf62944144a92d83dd14fd1378d2a288259561]
stable/6.1: [5896f55810680391a32652ca2b91245a05c11e22]

CVE-2023-53191: irqchip/alpine-msi: Fix refcount leak in
alpine_msix_init_domains

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53191

Introduced by commit e6b78f2 ("irqchip: Add the Alpine MSIX interrupt
controller") in v4.6-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [eef09f786df4b34b97557929287c4e5a83bbf09b]
mainline: [071d068b89e95d1b078aa6bbcb9d0961b77d6aa1]
stable/5.10: [c9aaf4efe1f02b2fef21a69fb3652f5ad12a5710]
stable/5.15: [d6c66c46889752fa4962c6388516f7ab66a8d6a1]
stable/5.4: [9e79ac4f70fd51243e1c6108d4b0baf16cfde99c]
stable/6.1: [65e30bd1310d90b794c377bf405394157854aa30]

CVE-2023-53192: vxlan: Fix nexthop hash size

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53192

Introduced by commit 1274e1c ("vxlan: ecmp support for mac fdb
entries") in v5.8-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0756384fb1bd38adb2ebcfd1307422f433a1d772]
stable/5.10: [c650597647ecb318d02372277bdfd866c6829f78]
stable/5.15: [32ef2c0c6cf11a076f0280a7866b9abc47821e19]
stable/6.1: [7b8717658dff8b471cbfc124bf9b5ca4229579ed]

CVE-2023-53193: drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v10_0_hw_fini

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53193

Introduced by commit c8b5a95 ("drm/amdgpu: Fix desktop freezed after
gpu-reset") in v6.3.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [08c677cb0b436a96a836792bb35a8ec5de4999c2]
stable/6.1: [59e2439111ac2bd24ea0cecf5825cf06684b2c6c]

CVE-2023-53194: fs/ntfs3: Add length check in indx_get_root

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53194

Introduced commit is not determined.Fixed in v6.4-rc1.
Vulnerable function was added by 82cae26 ("fs/ntfs3: Add
initialization of super block") in 5.15-rc1.

Fixed status
mainline: [08e8cf5f2d9ec383a2e339a2711b62a54ff3fba0]
stable/5.15: [85afd3007465f8bc74afffbf5b84ec29f5310b03]
stable/6.1: [0d04e45c65f0785e558b93d2631d58680f263e10]

CVE-2023-53195: mlxsw: minimal: fix potential memory leak in
mlxsw_m_linecards_init

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53195

Introduced by commit 01328e2 ("mlxsw: minimal: Extend module to port
mapping with slot index") in v6.1-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08fc75735fda3be97194bfbf3c899c87abb3d0fe]
stable/6.1: [d4f5b1dd816dccd4ee6bb60b2a81a3d4373636a9]

CVE-2023-53196: usb: dwc3: qcom: Fix potential memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53196

Introduced by commit 2bc0235 ("usb: dwc3: qcom: Add support for
booting with ACPI") in v5.3-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [097fb3ee710d4de83b8d4f5589e8ee13e0f0541e]
stable/5.10: [74f8606ddfa450d2255b4e61472a7632def1e8c4]
stable/5.15: [b626cd5e4a87a281629e0c2b07519990077c0fbe]
stable/5.4: [648a163cff21ea355c8765e882ba8bf66a870a3e]
stable/6.1: [c3b322b84ab5dda7eaca9ded763628b7467734f4]

CVE-2023-53197: USB: uhci: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53197

Introduced commit is not determined.Fixed in v6.3-rc1.
Vulnerable code was added by 5649d86 ("USB: host: uhci: remove dentry
pointer for debugfs") in 5.13-rc1.

Fixed status
mainline: [0a3f82c79c86278e7f144564b1cb6cc5c3657144]
stable/5.15: [c6af1dbc99ad37bf67c8703982df4d7f12d256c1]
stable/6.1: [e529aeb771aef1402c899b6b405610ef444d5d88]

CVE-2023-53198: raw: Fix NULL deref in raw_get_next().

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53198

Introduced by commit 0daf07e ("raw: convert raw sockets to RCU") in v6.0-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a78cf7264d29abeca098eae0b188a10aabc8a32]
stable/6.1: [b34056bedf04d08ef24f713a7f93bad1274a838d]

CVE-2023-53199: wifi: ath9k: hif_usb: clean up skbs if
ath9k_hif_usb_rx_stream() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53199

Introduced by commit 6ce708f ("ath9k: Fix out-of-bound memcpy in
ath9k_hif_usb_rx_stream") in v5.17-rc1.
Introduced by commit 44b23b4 ("ath9k: hif_usb: Reduce indent 1
column") in v2.6.38-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [3fc6401fafde11712a83089fa2cc874cfd10e2cd]
mainline: [0af54343a76263a12dbae7fafb64eb47c4a6ad38]
stable/5.10: [f26dd69f61eff2eedf5df2d199bdd23108309947]
stable/5.15: [61490d2710277e8a55009b7682456ae22f8087cf]
stable/5.4: [cd8316767099920a5d41feed1afab0c482a43e9f]
stable/6.1: [9acdec72787af1bc8ed92711b52118c8e3e638a2]

CVE-2023-53200: netfilter: x_tables: fix percpu counter block leak on
error path when creating new netns

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53200

Introduced by commit 71ae0df ("netfilter: xtables: use percpu rule
counters") in v4.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0af8c09c896810879387decfba8c942994bb61f5]
stable/5.15: [e306dbee4c98025a9326386023a12ef4d887e9d1]
stable/6.1: [512b6c4b83c91d007301ea7d7f095d16c3aceacd]

CVE-2023-53201: RDMA/bnxt_re: wraparound mbox producer index

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53201

Introduced by commit cee0c7b ("RDMA/bnxt_re: Refactor command queue
management code") in v5.7-rc1.
Introduced by commit 1ac5a40 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
in v4.11-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0af91306e17ef3d18e5f100aa58aa787869118af]
stable/5.10: [9341501e2f7af29f5b5562c2840a7fde40eb7de4]
stable/5.15: [79226176cdd1b65a1e6a90e0e1a2b490f0a9df33]
stable/6.1: [c9be352be9bb15e6b83e40abc4df7f4776b435ba]

CVE-2023-53202: PM: domains: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53202

Introduced commit is not determined.Fixed in v6.3-rc1.
Vulnerable code was added by 718072c ("PM: domains: create debugfs
nodes when adding power domains") in 5.11-rc1.

Fixed status
mainline: [0b6200e1e9f53dabdc30d0f6c51af9a5f664d32b]
stable/5.15: [dddc132eb0dca3969f9146ef8feac0aa542aa305]
stable/6.1: [cde67cb7d2d1757baa83271c1f0892727e79f52e]

CVE-2023-53203: wifi: mt76: mt7996: rely on mt76_connac2_mac_tx_rate_val

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53203

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b8e2d69467f78a7c9d87b452220e87012435e33]

CVE-2023-53204: af_unix: Fix data-races around user->unix_inflight.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53204

Introduced by commit 712f4aa ("unix: properly account for FDs passed
over unix sockets") in v4.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [03d133dfbcec9d439729cc64706c7eb6d1663a24]
cip/4.4-st: [de65f95276f9ff4fe6b4e2eaf8f2551fd2861f13]
mainline: [0bc36c0650b21df36fbec8136add83936eaf0607]
stable/5.10: [b401d7e485b0a234cf8fe9a6ae99dbcd20863138]
stable/5.15: [9151ed4b006125cba7c06c79df504340ea4e9386]
stable/5.4: [adcf4e069358cdee8593663650ea447215a1c49e]
stable/6.1: [b9cdbb38e030fc2fe97fe27b54cbb6b4fbff250f]
stable/6.6: [0bc36c0650b21df36fbec8136add83936eaf0607]

CVE-2023-53205: KVM: s390/diag: fix racy access of physical cpu number
in diag 9c handler

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53205

Introduced by commit 87e28a1 ("KVM: s390: diag9c (directed yield)
forwarding") in v5.13-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bc380beb78aa352eadbc21d934dd9606fcee808]
stable/5.15: [a9ccf140a2a03a0ae82be4bdfbdd17bdaea72ff5]
stable/6.1: [86bfb18bad60fc468e5f112cbbd918462a8dd435]

CVE-2023-53206: hwmon: (pmbus_core) Fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53206

Introduced by commit df5f6b6 ("hwmon: (pmbus/core) Generalise pmbus
get status") in v6.4-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bd66784274a287beada2933c2c0fa3a0ddae0d7]

CVE-2023-53207: ublk: fail to recover device if queue setup is interrupted

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53207

Introduced by commit c732a85 ("ublk_drv: add START_USER_RECOVERY and
END_USER_RECOVERY support") in v6.1-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c0cbd4ebc375ceebc75c89df04b74f215fab23a]
stable/6.1: [84415f934ad4e96f3507fd09b831953d60fb04ec]

CVE-2023-53208: KVM: nSVM: Load L1's TSC multiplier based on L1 state,
not L2 state

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53208

Introduced by commit 5228eb9 ("KVM: x86: nSVM: implement nested TSC
scaling") in v5.16-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c94e2468491cbf0754f49a5136ab51294a96b69]
stable/6.1: [5b2b0535fa7adee7e295fed0a3095082131a8d05]
stable/6.6: [0c94e2468491cbf0754f49a5136ab51294a96b69]

CVE-2023-53209: wifi: mac80211_hwsim: Fix possible NULL dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53209

Introduced commit is not determined.Fixed in v6.5-rc1.
Vulnerable code was added by af4f2aa3 ("wifi: mac80211_hwsim: fix TX
link selection") in 6.0-rc1.

Fixed status
mainline: [0cc80943ef518a1c51a1111e9346d1daf11dd545]
stable/6.1: [d0124848c7940aba73492e282506b32a13f2e30e]

CVE-2023-53210: md/raid5-cache: fix null-ptr-deref for
r5l_flush_stripe_to_raid()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53210

Introduced by commit 0dd00cb ("raid5-cache: fully initialize flush_bio
when needed") in v5.18-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d0bd28c500173bfca78aa840f8f36d261ef1765]
stable/6.1: [711fb92606208a8626b785da4f9f23d648a5b6c8]
stable/6.6: [0d0bd28c500173bfca78aa840f8f36d261ef1765]

CVE-2023-53211: driver core: location: Free struct acpi_pld_info *pld
before return false

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53211

Introduced by commit bc443c3 ("driver core: location: Check for
allocations failure") in v5.19-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d150f967e8410e1e6712484543eec709356a65d]
stable/6.1: [8fe72b8f59f63ca776bb8a4fcd2f406057a9fc90]

CVE-2023-53213: wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53213

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [39f9bd880abac6068bedb24a4e16e7bd26bf92da]
cip/4.4-st: [87df9db9c2cab864c945a4ecb7a9b9b6490a2c91]
mainline: [0da40e018fd034d87c9460123fa7f897b69fdee7]
stable/5.10: [549825602e3e6449927ca1ea1a08fd89868439df]
stable/5.15: [936a23293bbb3332bdf4cdb9c1496e80cb0bc2c8]
stable/5.4: [425eea395f1f5ae349fb55f7fe51d833a5324bfe]
stable/6.1: [e29661611e6e71027159a3140e818ef3b99f32dd]

CVE-2023-53214: f2fs: fix to avoid potential memory corruption in
__update_iostat_latency()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53214

Introduced by commit a4b6817 ("f2fs: introduce periodic iostat io
latency traces") in v5.15-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0dbbf0fb38d5ec5d4138d1aeaeb43d9217b9a592]
stable/5.15: [aa4d726af72a21732ce120484e0b1240674a13b3]
stable/6.1: [22ddbbff116ee7dce5431feb1c0f36a507d2d68d]

CVE-2023-53215: sched/fair: Don't balance task to its current running CPU

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53215

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [a5286f4655ce2fa28f477c0b957ea7f323fe2fab]
mainline: [0dd37d6dd33a9c23351e6115ae8cdac7863bc7de]
stable/5.10: [6b0c79aa33075b34c3cdcea4132c0afb3fc42d68]
stable/5.15: [3cb43222bab8ab328fc91ed30899b3df2efbccfd]
stable/5.4: [cec1857b1ea5cc3ea2b600564f1c95d1a6f27ad1]
stable/6.1: [78a5f711efceb37e32c48cd6b40addb671fea9cc]

CVE-2023-53216: arm64: efi: Make efi_rt_lock a raw_spinlock

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53216

Introduced by commit ff7a167 ("arm64: efi: Execute runtime services
from a dedicated stack") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [0e68b5517d3767562889f1d83fdb828c26adb24f]
stable/5.10: [030b1c4217a4f504c7d0795a2bd86b7181e56f11]
stable/5.15: [6a72729ed6accc86dad5522895e8fa2f96642a2c]
stable/6.1: [8b38969fa01662ec539a0d08a8ea5ec6f31fa4ed]

CVE-2023-53217: nubus: Partially revert proc_create_single_data() conversion

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53217

Introduced by commit 3f3942a ("proc: introduce
proc_create_single{,_data}") in v4.18-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e96647cff9224db564a1cee6efccb13dbe11ee2]
stable/5.10: [f70407e8e0272e00d133c5e039168ff1bae6bcac]
stable/5.15: [c06edf13f4cf7f9e8ff4bc6f7e951e4f074dc105]
stable/6.1: [67e3b5230cefed1eca470c460a2035f02986cebb]

CVE-2023-53218: rxrpc: Make it so that a waiting process can be aborted

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53218

Introduced by commit 540b1c4 ("rxrpc: Fix deadlock between call
creation and sendmsg/recvmsg") in v4.11-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0eb362d254814ce04848730bf32e75b8ee1a4d6c]

CVE-2023-53219: media: netup_unidvb: fix use-after-free at del_timer()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53219

Introduced by commit 52b1eaf ("[media] netup_unidvb: NetUP Universal
DVB-S/S2/T/T2/C PCI-E card driver") in v4.3-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [90229e9ee957d4514425e4a4d82c50ab5d57ac4d]
cip/4.4-st: [656ba05db4e606a307470ef96735b8f059ce6afe]
mainline: [0f5bb36bf9b39a2a96e730bf4455095b50713f63]
stable/5.10: [f9982db735a8495eee14267cf193c806b957e942]
stable/5.15: [051af3f0b7d1cd8ab7f3e2523ad8ae1af44caba3]
stable/5.4: [1550bcf2983ae1220cc8ab899a39a423fa7cb523]
stable/6.1: [07821524f67bf920342bc84ae8b3dea2a315a89e]

CVE-2023-53220: media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53220

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [adcb73f8ce9aec48b1f85223f401c1574015d8d2]
cip/4.4-st: [3b10c0e875fa8b898f72e845761203abf646ec66]
mainline: [1047f9343011f2cedc73c64829686206a7e9fc3f]
stable/5.10: [a9def3e9718a4dc756f48db147d42ec41a966240]
stable/5.15: [5b1ea100ad3695025969dc4693f307877fb688d6]
stable/5.4: [991c77fe18c6f374bbf83376f8c42550aa565662]
stable/6.1: [6ab7ea4e17d6a605d05308adf8f3408924770cba]
stable/6.6: [1047f9343011f2cedc73c64829686206a7e9fc3f]

CVE-2023-53221: bpf: Fix memleak due to fentry attach failure

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53221

Introduced by commit e21aa34 ("bpf: Fix fexit trampoline.") in v5.12-rc5.
Fixed in v6.5-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [108598c39eefbedc9882273ac0df96127a629220]
stable/6.1: [20109ddd5bea2c24d790debf5d02584ef24c3f5e]

CVE-2023-53222: jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53222

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [ef5c205b6e6f8d1f18ef0b4a9832b1b5fa85f7f2]
cip/4.4-st: [6726f0c94ae60b41d9273fcf4f39823ab3630312]
mainline: [11509910c599cbd04585ec35a6d5e1a0053d84c1]
stable/5.10: [47b7eaae08e8b2f25bdf37bc14d21be090bcb20f]
stable/5.15: [de984faecddb900fa850af4df574a25b32bb93f5]
stable/5.4: [a4855aeb13e4ad1f23e16753b68212e180f7d848]
stable/6.1: [c7feb54b113802d2aba98708769d3c33fb017254]

CVE-2023-53223: drm/msm/dsi: Add missing check for alloc_ordered_workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53223

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [9257974858ee847b2e1fd552691b8ba5c2fc1c7b]
cip/4.4-st: [b9cec763024783893822045bce588ab8799b6d8d]
mainline: [115906ca7b535afb1fe7b5406c566ccd3873f82b]
stable/5.10: [540c66180afd59309a442d3bf1f2393464c8b4c5]
stable/5.15: [5dfe7a5386fde5a656ca06602b31bf50e26954cd]
stable/5.4: [3a9a4a9725c60f04326b5019a52ce15aee808506]
stable/6.1: [25a6499b1a53d854eda2b161b5c8a20296515dbe]

CVE-2023-53224: ext4: Fix function prototype mismatch for ext4_feat_ktype

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53224

Introduced by commit b99fee5 ("ext4: create ext4_feat kobject
dynamically") in v4.16-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2b69cdd9f9a7f596e3dd31f05f9852940d177924]
mainline: [118901ad1f25d2334255b3d50512fa20591531cd]
stable/5.10: [1ba10d3640e9783dad811fe4e24d55465c37c64d]
stable/5.15: [c98077f7598a562f51051eec043be0cb3e1b1b5e]
stable/5.4: [99e3fd21f8fc975c95e8cf76fbf6a3d2656f8f71]
stable/6.1: [0a1394e07c5d6bf1bfc25db8589ff1b1bfb6f46a]

CVE-2023-53225: spi: imx: Don't skip cleanup in remove's error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53225

Introduced by commit d593574 ("spi: imx: do not access registers while
clocks disabled") in v4.16-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [11951c9e3f364d7ae3b568a0e52c8335d43066b5]
stable/5.10: [aa93a46f998a9069368026ac52bba96868c59157]
stable/5.15: [f90822ad63d11301e425311dac0c8e12ca1737b8]
stable/6.1: [6d16305a1535873e0a8a8ae92ea2d9106ec2d7df]

CVE-2023-53226: wifi: mwifiex: Fix OOB and integer underflow when rx packets

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53226

Introduced by commit 2dbaf75 ("mwifiex: report received management
frames to cfg80211") in v3.7-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8824aa4ab62c800f75d96f48e1883a5f56ec5869]
cip/4.4-st: [529338df36d4be7610175795f9d90127332e362b]
mainline: [11958528161731c58e105b501ed60b83a91ea941]
stable/5.10: [3fe3923d092e22d87d1ed03e2729db444b8c1331]
stable/5.15: [7c54b6fc39eb1aac51cf2945f8a25e2a47fdca02]
stable/5.4: [29eca8b7863d1d7de6c5b746b374e3487d14f154]
stable/6.1: [3975e21d4d01efaf0296ded40d11c06589c49245]
stable/6.6: [11958528161731c58e105b501ed60b83a91ea941]

CVE-2023-53227: ubifs: dirty_cow_znode: Fix memleak in error handling path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53227

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5759076fc7c54614084002345a21bc2c578bf4a8]
cip/4.4-st: [620ba05b7325625a7cc450ac91845a69badc56bd]
mainline: [122deabfe1428bffe95e2bf364ff8a5059bdf089]
stable/5.10: [9d4768523b092bfb9a9bfa6b1d903b968c8008cf]
stable/5.15: [10b6c359e374df1120b951768260083ef047d7fb]
stable/5.4: [510b80abe8d2d89e4ff21d71f1804ba2e5d3a96b]
stable/6.1: [76c488e8a0e2783c6d8753cb7354a420593e8c30]

CVE-2023-53228: drm/amdgpu: drop redundant sched job cleanup when cs is aborted

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53228

Introduced by commit f7d66fb ("drm/amdgpu: cleanup scheduler job
initialization v2") in v6.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1253685f0d3eb3eab0bfc4bf15ab341a5f3da0c8]

CVE-2023-53229: wifi: mac80211: fix invalid drv_sta_pre_rcu_remove
calls for non-uploaded sta

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53229

Introduced by commit 6a9d1b9 ("mac80211: add pre-RCU-sync sta removal
driver operation") in v3.14-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7e68d7c640d41d8a371b8f6c2d2682ea437cbe21]
cip/4.4-st: [25d18be3993cb1c88f23a6628cad668254b8f7f2]
mainline: [12b220a6171faf10638ab683a975cadcf1a352d6]
stable/5.10: [3fe20515449a80a177526d2ecd13b43f6ee41aeb]
stable/5.15: [30c5a016a37a668c1c07442cf94de6e99ea7417a]
stable/5.4: [a3593082e0dadf87f17ea4ca9fa0210caaa2aebf]
stable/6.1: [022c8320d9eb7394538bd716fa1a07a5ed92621b]

CVE-2023-53230: smb: client: fix warning in cifs_smb3_do_mount()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53230

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [12c30f33cc6769bf411088a2872843c4f9ea32f9]
stable/5.15: [9850867042674361f455ea8901375cff5b800be5]
stable/6.1: [945f4a7aff84fde1f825d17a5050880345da3228]

CVE-2023-53231: erofs: Fix detection of atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53231

Introduced commit is not determined.Fixed in v6.5-rc1.
It looks as if vulnerable code was added by 648f2de0 ("erofs: use
workqueue decompression for atomic contexts only") in 5.13-rc1.

Fixed status
mainline: [12d0a24afd9ea58e581ea64d64e066f2027b28d9]

CVE-2023-53232: mt76: mt7921: fix kernel panic by accessing
unallocated eeprom.data

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53232

Introduced by commit 16d98b5 ("mt76: mt7921: rely on
mcu_get_nic_capability") in v5.16-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12db28c3ef31f719bd18fa186a40bb152e6a527c]
stable/6.1: [11181b6c8641cd417935b76ea997d0169f2db262]

CVE-2023-53233: net/smc: fix deadlock triggered by cancel_delayed_work_syn()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53233

Introduced by commit a52bcc9 ("net/smc: improve termination
processing") in v5.8-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13085e1b5cab8ad802904d72e6a6dae85ae0cd20]
stable/5.10: [9708efad9ba5095b9bb7916e11a135b3bd66c071]
stable/5.15: [b615238e5bc01e13dc0610febddc1ca99bab1df6]
stable/6.1: [3517584cf1b35bd02f4a90267ddf9dcf17bd9c87]

CVE-2023-53234: watchdog: Fix kmemleak in watchdog_cdev_register

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53234

Introduced by commit 72139df ("watchdog: Fix the race between the
release of watchdog_core_data and cdev") in v5.5-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
cip/4.19-st: [8c1655600f4f2839fb844fe8c70b2b65fadc7a56]
mainline: [13721a2ac66b246f5802ba1b75ad8637e53eeecc]
stable/5.10: [c5a21a5501508ae3afa2fe6d5a3e74a37fa48df3]
stable/5.15: [23cc41c3f19c4d858c3708f1c0a06e94958e6c3b]
stable/5.4: [59e391b3fc507a15b7e8e9d9f4de87cae177c366]
stable/6.1: [ac099d94e0480c937aa9172ab64074981ca1a4d3]

CVE-2023-53235: drm/tests: helpers: Avoid a driver uaf

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53235

Introduced by commit d987803 ("drm/tests: helpers: Allow to pass a
custom drm_driver") in v6.3-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [139a27854bf5ce93ff9805f9f7683b88c13074dc]
stable/6.6: [139a27854bf5ce93ff9805f9f7683b88c13074dc]

CVE-2023-53236: iommufd: Do not corrupt the pfn list when doing batch carry

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53236

Introduced by commit f394576 ("iommufd: PFN handling for iopt_pages")
in v6.2-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13a0d1ae7ee6b438f5537711a8c60cba00554943]

CVE-2023-53237: drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fini

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53237

Introduced by commit c8b5a95 ("drm/amdgpu: Fix desktop freezed after
gpu-reset") in v6.3.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [13af556104fa93b1945c70bbf8a0a62cd2c92879]
stable/6.1: [02e6cb9b3aeffc6b0e3955f6e0346293e2415cbc]

CVE-2023-53238: phy: hisilicon: Fix an out of bounds check in
hisi_inno_phy_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53238

Introduced by commit ba8b0ee ("phy: add inno-usb2-phy driver for
hi3798cv200 SoC") in v4.17-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2843a2e703f5cb85c9eeca11b7ee90861635a010]
mainline: [13c088cf3657d70893d75cf116be937f1509cc0f]
stable/5.10: [ad249aa3c38f329f91fba8b4b3cd087e79fb0ce8]
stable/5.15: [6d8a71e4c3a2fa4960cc50996e76a42b62fab677]
stable/5.4: [195e806b2afb0bad6470c9094f7e45e0cf109ee0]
stable/6.1: [01cb355bb92e8fcf8306e11a4774d610c5864e39]

CVE-2023-53239: drm/msm/mdp5: Add check for kzalloc

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53239

Introduced by commit 1cff744 ("drm/msm: Convert to using
__drm_atomic_helper_crtc_reset() for reset.") in v5.3-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13fcfcb2a9a4787fe4e49841d728f6f2e9fa6911]
stable/5.10: [49907c8873826ee771ba0ca1629e809c6479f617]
stable/5.15: [82943a0730e00c14b03e25a4b2a1a9477ae89d7b]
stable/5.4: [3975ea6eaffe26aec634b5c473e51dc76e73af62]
stable/6.1: [bc579a2ee8b2e20c152b24b437d094832d8c9c9e]

CVE-2023-53240: xsk: check IFF_UP earlier in Tx path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53240

Introduced by commit ca2e1a6 ("xsk: Mark napi_id on sendmsg()") in v6.0-rc1.
Introduced by commit 18b1ab7 ("xsk: Fix race at socket teardown") in v5.18-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1596dae2f17ec5c6e8c8f0e3fec78c5ae55c1e0b]
stable/6.1: [cecc68559cd57fffb2be50685f262b9af2318e16]

CVE-2023-53241: nfsd: call op_release, even when op_func returns an error

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53241

Introduced by commit 34b1744 ("nfsd4: define ->op_release for compound
ops") in v4.14-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15a8b55dbb1ba154d82627547c5761cac884d810]
stable/5.10: [65a33135e91e6dd661ecdf1194b9d90c49ae3570]
stable/5.15: [b11d8162c24af4a351d21e2c804d25ca493305e3]
stable/6.1: [b623a8e5d38a69a3ef8644acb1030dd7c7bc28b3]

CVE-2023-53242: thermal/drivers/hisi: Drop second sensor hi3660

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53242

Introduced by commit 7d3a2a2 ("thermal/drivers/hisi: Fix number of
sensors on hi3660") in v4.20-rc7.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15cc25829a97c3957e520e971868aacc84341317]
stable/5.10: [e02bc492883abf751fd1a8d89fc025fbce6744c6]
stable/5.15: [f5aaf140ab1c02889c088e1b1098adad600541af]
stable/5.4: [3cf2181e438f43ed24e12424fe36d156cca233b9]
stable/6.1: [9f6756cd09889c7201ee31e6f76fbd914fb0b80d]

CVE-2023-53243: btrfs: add handling for RAID1C23/DUP to
btrfs_reduce_alloc_profile

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53243

Introduced by commit 47e6f74 ("btrfs: add support for 3-copy
replication (raid1c3)") in v5.5-rc1.
Introduced by commit 8d6fac0 ("btrfs: add support for 4-copy
replication (raid1c4)") in v5.5-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [160fe8f6fdb13da6111677be6263e5d65e875987]
stable/5.10: [a3fbd156bd2cd16e3c64e250ebce33eb9f2ef612]
stable/5.15: [12b6d68498982a053a4a7e561a04387e57ca6f1a]
stable/6.1: [4fadf53fa95142f01f215012e97c384529759a72]

CVE-2023-53244: media: pci: tw68: Fix null-ptr-deref bug in buf
prepare and finish

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53244

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected functions were added by e15d1c1 ("[media] tw68: refactor and
cleanup the tw68 driver") in 3.18-rc1.

Fixed status
mainline: [1634b7adcc5bef645b3666fdd564e5952a9e24e0]
stable/5.15: [dcf632bca424e6ff8c8eb89c96694e7f05cd29b6]
stable/6.1: [3c67f49a6643d973e83968ea35806c7b5ae68b56]

CVE-2023-53245: scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53245

Introduced by commit 3930d73 ("scsi: storvsc: use default I/O timeout
handler for FC devices") in v4.13-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [311db605e07f0d4fc0cc7ddb74f1e5692ea2f469]
mainline: [175544ad48cbf56affeef2a679c6a4d4fb1e2881]
stable/5.10: [1678408d08f31a694d5150a56796dd04c9710b22]
stable/5.15: [7a792b3d888aab2c65389f9f4f9f2f6c000b1a0d]
stable/5.4: [048ebc9a28fb918ee635dd4b2fcf4248eb6e4050]
stable/6.1: [ed70fa5629a8b992a5372d7044d1db1f8fa6de29]

CVE-2023-53246: cifs: fix DFS traversal oops without CONFIG_CIFS_DFS_UPCALL

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53246

Introduced commit is not determined.Fixed in v6.3-rc5.


Fixed status
cip/4.19-st: [8afb1fabcec1929db46977e84baeee0cc0e79242]
cip/4.4-st: [7ec0165902c1a49d838dce7095b5c1add73a5f6a]
mainline: [179a88a8558bbf42991d361595281f3e45d7edfc]
stable/5.10: [26a32a212bc540f4773cd6af8cf73e967d72569c]
stable/5.15: [b64305185b76f1d5145ce594ff48f3f0e70695bd]
stable/5.4: [657d7c215ca974d366ab1808213f716e1e3aa950]
stable/6.1: [b7d854c33ab48e55fc233699bbefe39ec9bb5c05]

CVE-2023-53247: btrfs: set_page_extent_mapped after read_folio in
btrfs_cont_expand

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53247

Introduced commit is not determined.Fixed in v6.5-rc3.


Fixed status
mainline: [17b17fcd6d446b95904a6929c40012ee7f0afc0c]
stable/6.1: [0a5e0bc8e8618e32a6ca64450867628eb0a627bf]

CVE-2023-53248: drm/amdgpu: install stub fence into potential unused
fence pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53248

Introduced commit is not determined.Fixed in v6.5-rc1.
Introduced by d38ceaf ("drm/amdgpu: add core driver (v4)") in 4.2-rc1.

Fixed status
mainline: [187916e6ed9d0c3b3abc27429f7a5f8c936bd1f0]
stable/5.10: [04bd3a362d2f1788272776bd8b10e5a012e69b77]
stable/5.15: [4921792e04f2125b5eadef9dbe9417a8354c7eff]
stable/6.1: [78b25110eb8c6990f7f5096bc0136c12a2b4cc99]

CVE-2023-53249: clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53249

Introduced by commit daeb145 ("clk: imx: imx8mn: Switch to clk_hw
based API") in v5.6-rc1.
Introduced by commit 96d6392 ("clk: imx: Add support for i.MX8MN clock
driver") in v5.4-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [188d070de9132667956f5aadd98d2bd87d3eac89]
stable/5.10: [294321349bd3b0680847fc2bbe66b9ab3e522fea]
stable/5.15: [50b5ddde8fad5f0ffd239029d0956af633a0f9b1]
stable/6.1: [9ba3693b0350b154fdd7830559bbc7b04c067096]

CVE-2023-53250: firmware: dmi-sysfs: Fix null-ptr-deref in
dmi_sysfs_register_handle

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53250

Introduced by commit 660ba67 ("firmware: dmi-sysfs: Fix memory leak in
dmi_sysfs_register_handle") in v5.19-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [18e126e97c961f7a93823795c879d7c085fe5098]
stable/5.15: [b4fe158259fb5fead52ff2b55841ec5c39492604]
stable/6.1: [e851996b32264e78a10863c2ac41a8689d7b9252]

CVE-2023-53251: wifi: iwlwifi: pcie: fix NULL pointer dereference in
iwl_pcie_irq_rx_msix_handler()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53251

Introduced by commit abc599e ("iwlwifi: pcie: don't crash when rx
queues aren't allocated in interrupt") in v5.12-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1902f1953b8ba100ee8705cb8a6f1a9795550eca]
stable/5.15: [3b9de981fe7f1c6e07c7b852421ad69be3d4b6c2]
stable/6.1: [2d690495eb2766d58e25c83676f422219c4fcf18]

CVE-2023-53252: Bluetooth: use RCU for hci_conn_params and iterate
safely in hci_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53252

Introduced by commit e8907f7 ("Bluetooth: hci_sync: Make use of
hci_cmd_sync_queue set 3") in v5.17-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [195ef75e19287b4bc413da3e3e3722b030ac881e]
stable/6.1: [13ad45ad14df992a6754a130a19abc8c142d54e2]

CVE-2023-53253: HID: nvidia-shield: Reference hid_device devm
allocation of input_dev name

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53253

Introduced by commit 0930856 ("HID: nvidia-shield: Initial driver
implementation with Thunderstrike support") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [197d3143520fec9fde89aebabc9f0d7464f08e50]
stable/6.6: [197d3143520fec9fde89aebabc9f0d7464f08e50]

CVE-2023-53254: cacheinfo: Fix shared_cpu_map to handle shared caches
at different levels

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53254

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected function was added by 246246c ("drivers: base: support cpu
cache information interface to userspace via sysfs") in 3.19-rc1.

Fixed status
mainline: [198102c9103fc78d8478495971947af77edb05c1]
stable/6.1: [2f588d0345d69a35e451077afed428fd057a5e34]

CVE-2023-53255: firmware: stratix10-svc: Fix a potential resource leak
in svc_create_memory_pool()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53255

Introduced by commit 7ca5ce8 ("firmware: add Intel Stratix10 service
layer driver") in v5.0-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1995f15590ca222f91193ed11461862b450abfd6]
stable/5.10: [c04ed61ebf01968d7699b121663982493ed577fb]
stable/5.15: [974ac045a05ad12a0b4578fb303f00dcc22f3aba]
stable/5.4: [e3373e6b6c79aff698442b00d20c9f285d296e46]
stable/6.1: [cb8a31a56df8492fb0d900959238e1a3ff8b8981]

CVE-2023-53256: firmware: arm_ffa: Fix FFA device names for logical partitions

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53256

Introduced by commit e781858 ("firmware: arm_ffa: Add initial FFA bus
support for device enumeration") in v5.14-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19b8766459c41c6f318f8a548cc1c66dffd18363]
stable/5.15: [c2f65991097a62efbdb2bed3c06fc86b08c9593b]
stable/6.1: [dfc5aaa57f52a5800c339369d235fa30fb734feb]

CVE-2023-53257: wifi: mac80211: check S1G action frame size

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53257

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected logic was added by f5a4c24 ("mac80211: introduce individual
TWT support in AP mode") in 5.15-rc1.

Fixed status
mainline: [19e4a47ee74718a22e963e8a647c8c3bfe8bb05c]
stable/5.15: [fedd9377dd9c71a950d432fbe1628eebfbed70a1]
stable/6.1: [7ae7a1378a119780c8c17a6b5fc03011c3bb7029]
stable/6.6: [19e4a47ee74718a22e963e8a647c8c3bfe8bb05c]

CVE-2023-53258: drm/amd/display: Fix possible underflow for displays
with large vblank

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53258

Introduced commit is not determined.Fixed in v6.5-rc1.
Vulnerable function was added by 67c7959 ("drm/amd/display: Move
populate dml pipes from DCN314 to dml") in 6.0-rc2.

Fixed status
mainline: [1a4bcdbea4319efeb26cc4b05be859a7867e02dc]
stable/6.1: [d5741133e6e2f304b40ca1da0e16f62af06f4d22]

CVE-2023-53259: VMCI: check context->notify_page after call to
get_user_pages_fast() to avoid GPF

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53259

Introduced by commit a1d8843 ("VMCI: Fix two UVA mapping bugs") in v4.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [576c9fa0b32fa9d6fc83e1699151bf548f190331]
cip/4.4-st: [23afa695dd11b7fe3294f96ca849cc9bda98172b]
mainline: [1a726cb47fd204109c767409fa9ca15a96328f14]
stable/5.10: [d4198f67e7556b1507f14f60d81a72660e5560e4]
stable/5.15: [a3c89e8c69a58f62451c0a75b77fcab25979b897]
stable/5.4: [b4239bfb260d1e6837766c41a0b241d7670f1402]
stable/6.1: [055891397f530f9b1b22be38d7eca8b08382941f]

CVE-2023-53260: ovl: fix null pointer dereference in ovl_permission()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53260

Introduced by commit 4b7791b ("ovl: handle idmappings in
ovl_permission()") in v5.19-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a73f5b8f079fd42a544c1600beface50c63af7c]
stable/6.1: [53dd2ca2c02fdcfe3aad2345091d371063f97d17]

CVE-2023-53261: coresight: Fix memory leak in acpi_buffer->pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53261

Introduced by commit 76ffa5a ("coresight: Support for ACPI bindings")
in v5.3-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a9e02673e2550f5612099e64e8761f0c8fc0f50]
stable/6.6: [1a9e02673e2550f5612099e64e8761f0c8fc0f50]

CVE-2023-53262: f2fs: fix scheduling while atomic in decompression path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53262

Introduced by commit bff139b ("f2fs: handle decompress only post
processing in softirq") in v6.0-rc1.
Introduced by commit 95fa90c ("f2fs: support recording errors into
superblock") in v6.1-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1aa161e43106d46ca8e9a86f4aa28d420258134b]
stable/6.1: [74f74c8b8419a289b85aa9c85e5f4d8c2cc9f5fb]

CVE-2025-39800: btrfs: abort transaction on unexpected eb generation
at btrfs_copy_root()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39800

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [33e8f24b52d2796b8cfb28c19a1a7dd6476323a8]
stable/6.1: [4290e34fb87ae556b12c216efd0ae91583446b7a]
stable/6.12: [da2124719f386b6e5d4d4b1a2e67c440e4d5892f]
stable/6.6: [4734255ef39b416864139dcda96a387fe5f33a6a]

CVE-2025-39801: usb: dwc3: Remove WARN_ON for device endpoint command timeouts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39801

Introduced commit is not determined.Fixed in v6.17-rc3.


Fixed status
mainline: [45eae113dccaf8e502090ecf5b3d9e9b805add6f]
stable/5.15: [dfe40159eec6ca63b40133bfa783eee2e3ed829f]
stable/6.1: [5a1a847d841505dba2bd85602daf5c218e1d85b8]
stable/6.12: [f49697dfba2915a9ff36f94604eb76fa61413929]
stable/6.6: [84c95dbf5bece56086cdb65a64162af35158bdd9]

CVE-2025-39802: lib/crypto: arm/poly1305: Fix register corruption in
no-SIMD contexts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39802

Introduced by commit 773426f ("crypto: arm/poly1305 - Add block-only
interface") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52c3e242f4d0043186b70d65460ba1767f27494a]

CVE-2025-39803: scsi: ufs: core: Remove WARN_ON_ONCE() call from
ufshcd_uic_cmd_compl()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39803

Introduced by commit fcd8b04 ("scsi: ufs: core: Make
ufshcd_uic_cmd_compl() easier to analyze") in v6.13-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5203d89d59bfcbe1f348aa0d2dc4449a8ba644c]

CVE-2025-39804: lib/crypto: arm64/poly1305: Fix register corruption in
no-SIMD contexts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39804

Introduced by commit a59e546 ("crypto: arm64/poly1305 - Add block-only
interface") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eec76ea5a7213c48529a46eed1b343e5cee3aaab]

CVE-2022-50339: Bluetooth: avoid hci_dev_test_and_set_flag() in mgmt_init_hdev()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50339

Introduced by commit 3f2893d ("Bluetooth: don't try to cancel
uninitialized works at mgmt_index_removed()") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f74ca25d6d6629ffd4fd80a1a73037253b57d06b]
stable/6.1: [f74ca25d6d6629ffd4fd80a1a73037253b57d06b]

CVE-2022-50340: media: vimc: Fix wrong function called when vimc_init() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50340

Introduced by commit 4a29b70 ("[media] vimc: Subdevices as modules")
in v4.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f74d3f326d1d5b8951ce263c59a121ecfa65e7c0]
stable/5.10: [14d85b600bb1f6f8ef61fa8fc1907e2e623d8350]
stable/5.15: [9c9ff35d68691aaea85b2e93763772e23930b3a3]
stable/6.1: [f38df8984ef1b45ba23888d0e232cc21a95bd04b]

CVE-2022-50341: cifs: fix oops during encryption

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50341

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [f7f291e14dde32a07b1f0aa06921d28f875a7b54]
stable/5.10: [fe6ea044c4f05706cb71040055b1c70c6c8275e0]
stable/5.15: [bf0543b93740916ee91956f9a63da6fc0d79daaa]
stable/5.4: [e8e2861cc3258dbe407d01ea8c59bb5a53132301]
stable/6.1: [e8d16a54842d609fd4a3ed2d81d4333d6329aa94]

CVE-2022-50342: floppy: Fix memory leak in do_floppy_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50342

Introduced by commit 302cfee ("floppy: use a separate gendisk for each
media format") in v5.11-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8ace2e304c5dd8a7328db9cd2b8a4b1b98d83ec]
stable/5.15: [f36d8c8651506aea5f09899f5356ece5d1384f50]
stable/6.1: [55b3c66a0d441cd37154ae95e44d0b82ccfd580e]

CVE-2022-50343: rapidio: fix possible name leaks when rio_add_device() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50343

Introduced by commit e8de370 ("rapidio: add mport char device driver")
in v4.6-rc1.
Introduced by commit 1fa5ae8 ("driver core: get rid of struct device's
bus_id string array") in v2.6.30-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [80fad2e53eaed2b3a2ff596575f65669e13ceda5]
mainline: [f9574cd48679926e2a569e1957a5a1bcc8a719ac]
stable/5.10: [88fa351b20ca300693a206ccd3c4b0e0647944d8]
stable/5.15: [ec3f04f74f50d0b6bac04d795c93c2b852753a7a]
stable/5.4: [440afd7fd9b164fdde6fc9da8c47d3d7f20dcce8]
stable/6.1: [85fbf58b15c09d3a6a03098c1e42ebfe9002f39d]

CVE-2022-50344: ext4: fix null-ptr-deref in ext4_write_info

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50344

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [947264e00c46de19a016fd81218118c708fed2f3]
cip/4.4-st: [9100bfc847ac7ead4d632abac876dfdb51a0a8bd]
mainline: [f9c1f248607d5546075d3f731e7607d5571f2b60]
stable/5.10: [f34ab95162763cd7352f46df169296eec28b688d]
stable/5.15: [533c60a0b97cee5daab376933f486207e6680fb7]
stable/5.4: [3638aa1c7d87c0ca0aef23cf58cae2c48e7daca4]
stable/6.1: [f9c1f248607d5546075d3f731e7607d5571f2b60]

CVE-2022-50345: NFSD: Protect against send buffer overflow in NFSv3 READ

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50345

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [fa6be9cc6e80ec79892ddf08a8c10cabab9baf38]
stable/5.10: [c23687911f82a63fa2977ce9c992b395e90f8ba0]
stable/5.15: [75d9de25a6f833dd0701ca546ac926cabff2b5af]
stable/6.1: [fa6be9cc6e80ec79892ddf08a8c10cabab9baf38]

CVE-2022-50346: ext4: init quota for 'old.inode' in 'ext4_rename'

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50346

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [7dfb8259f66faafa68d23a261b284d2c2c67649b]
cip/4.4-st: [716c50d63379a51ecb77695e5336c707f73c5023]
mainline: [fae381a3d79bb94aa2eb752170d47458d778b797]
stable/5.10: [84a2f2ed49d6a4d92b354219077434c57d334620]
stable/5.15: [def7a39091e60e1c4a2f623629082a00092602be]
stable/5.4: [f263e349bacc2f303526dcfa61c4bc50132418b1]
stable/6.1: [13271fbbe85d73a7c47058f56a52f2a7f00d6e39]

CVE-2022-50347: mmc: rtsx_usb_sdmmc: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50347

Introduced by commit c7f6558 ("mmc: Add realtek USB sdmmc host
driver") in v3.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [89303ddbb502c3bc8edbf864f9f85500c8fe07e9]
cip/4.4-st: [e244a2cf0c8dbc00ef87eddac79c9cde5079142a]
mainline: [fc38a5a10e9e5a75eb9189854abeb8405b214cc9]
stable/5.10: [7fa922c7a3dd623fd59f1af50e8896fd9ca7f654]
stable/5.15: [df683201c7ffbd21a806a7cad657b661c5ebfb6f]
stable/5.4: [937112e991ed25d1727d878734adcbef3b900274]
stable/6.1: [a522e26a20a43dcfbef9ee9f71ed803290e852b0]

CVE-2022-50348: nfsd: Fix a memory leak in an error handling path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50348

Introduced by commit 6ee95d1 ("nfsd: add support for upcall version
2") in v5.4-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd1ef88049de09bc70d60b549992524cfc0e66ff]
stable/5.10: [e060c4b9f33c1fca74df26d57a98e784295327e6]
stable/5.15: [aed8816305575b38dcc77feb6f1bc1d0ed32f5b8]
stable/5.4: [acc393aecda05bf64ed13b732931462e07a1bf08]
stable/6.1: [fd1ef88049de09bc70d60b549992524cfc0e66ff]

CVE-2022-50349: misc: tifm: fix possible memory leak in tifm_7xx1_switch_media()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50349

Introduced by commit 2428a8f ("tifm: move common device management
tasks from tifm_7xx1 to tifm_core") in v2.6.22-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1695b1adcc3a7d985cd22fa3b55761edf3fab50d]
cip/4.4-st: [7d52ac9c7a21b2a6f21d6676715a569cb00f752c]
mainline: [fd2c930cf6a5b9176382c15f9acb1996e76e25ad]
stable/5.10: [57c857353d5020bdec8284d9c0fee447484fe5e0]
stable/5.15: [848c45964ded537107e010aaf353aa30a0855387]
stable/5.4: [ee2715faf7e7153f5142ed09aacfa89a64d45dcb]
stable/6.1: [ef843ee20576039126d34d6eb5f45d14c3e6ce18]

CVE-2022-50350: scsi: target: iscsi: Fix a race condition between
login_work and the login thread

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50350

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected driver was added by e48354c ("iscsi-target: Add iSCSI fabric
support for target v4.1") in 3.1-rc1.

Fixed status
mainline: [fec1b2fa62c162d03f5dcd7b03e3c89d3116d49f]
stable/6.1: [3ecdca49ca49d4770639d81503c873b6d25887c4]

CVE-2022-50351: cifs: Fix xid leak in cifs_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50351

Introduced by commit 087f757 ("cifs: add shutdown support") in v5.13-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fee0fb1f15054bb6a0ede452acb42da5bef4d587]
stable/5.15: [593d877c39aa9f3fe1a4b5b022492886d7d700ec]
stable/6.1: [fee0fb1f15054bb6a0ede452acb42da5bef4d587]

CVE-2022-50352: net: hns: fix possible memory leak in hnae_ae_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50352

Introduced by commit 6fe6611 ("net: add Hisilicon Network Subsystem
hnae framework support") in v4.4-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7ae1345f6ad715acbcdc9e1ac28153684fd498bb]
cip/4.4-st: [ad4bdfe10c797c930d658cab5b9de96a28f93b44]
mainline: [ff2f5ec5d009844ec28f171123f9e58750cef4bf]
stable/5.10: [2974f3b330ef25f5d34a4948d04290c2cd7802cf]
stable/5.15: [91f8f5342bee726ed5692583d58f69e7cc9ae60e]
stable/5.4: [dfc0337c6dceb6449403b33ecb141f4a1458a1e9]
stable/6.1: [ff2f5ec5d009844ec28f171123f9e58750cef4bf]

CVE-2023-53263: drm/nouveau/disp: fix use-after-free in error handling
of nouveau_connector_create

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53263

Introduced by commit 95983ae ("drm/nouveau/disp: add connector class")
in v6.0-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b254b791d7b7dea6e8adc887fbbd51746d8bb27]
stable/6.1: [3f27451c9f29d5ed00232968680c7838a44dcac7]

CVE-2023-53264: clk: imx: clk-imxrt1050: fix memory leak in
imxrt1050_clocks_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53264

Introduced by commit 7154b04 ("clk: imx: Add initial support for
i.MXRT1050 clock driver") in v5.18-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b280598ab3bd8a2dc8b96a12530d5b1ee7a8f4a]
stable/6.1: [1839032251a66f2ae5a043c495532830a55d28c4]

CVE-2023-53265: ubi: ensure that VID header offset + VID header size
<= alloc, size

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53265

Introduced by commit 801c135 ("UBI: Unsorted Block Images") in v2.6.22-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [771e207a839a29ba943e89f473b0fecd16089e2e]
cip/4.4-st: [2321d65f6efd1091ce5febd0c8b9d97756b848e8]
mainline: [1b42b1a36fc946f0d7088425b90d491b4257ca3e]
stable/5.10: [846bfba34175c23b13cc2023c2d67b96e8c14c43]
stable/5.15: [701bb3ed5a88a73ebbe1266895bdeff065226dca]
stable/5.4: [f7adb740f97b6fa84e658892dcb08e37a31a4e77]
stable/6.1: [61aeba0e4b4124cfe3c5427feaf29c626dfa89e5]

CVE-2023-53266: arm64: acpi: Fix possible memory leak of ffh_ctxt

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53266

Introduced by commit 1d280ce ("arm64: Add architecture specific ACPI
FFH Opregion callbacks") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b561d3949f8478c5403c9752b5533211a757226]

CVE-2023-53267: driver: soc: xilinx: fix memory leak in
xlnx_add_cb_for_notify_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53267

Introduced by commit 05e5ba4 ("driver: soc: xilinx: Add support of
multiple callbacks for same event in event management driver") in
v5.19-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bea534991b9b35c41848a397666ada436456beb]
stable/6.1: [d35290addcbac94b076babe0a798a8c043421812]

CVE-2023-53268: ASoC: fsl_mqs: move of_node_put() to the correct location

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53268

Introduced by commit a9d2736 ("ASoC: fsl_mqs: Fix error handling in
probe") in v5.5-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c34890273a020d61d6127ade3f68ed1cb21c16a]
stable/5.10: [b5a6930fc6a432e32714c4ed3c597077d999cf6d]
stable/5.15: [6a129c0e9935112ecf2ffb6de98f83b8fd090c86]
stable/6.1: [402299cca89273b62384b5f9645ea49cd5fc4a57]

CVE-2023-53269: block: ublk: make sure that block size is set correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53269

Introduced by commit 71f28f3 ("ublk_drv: add io_uring based userspace
block driver") in v6.0-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d1665279a845d16c93687389e364386e3fe0f38]
stable/6.1: [231a49460ac0203270da2471928d392e5586370f]

CVE-2023-53270: ext4: fix i_disksize exceeding i_size problem in
paritally written case

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53270

Introduced by commit 6476924 ("ext4: Add delayed allocation support in
data=writeback mode") in v2.6.27-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dedde690303c05ef732b7c5c8356fdf60a4ade3]
stable/5.15: [18eb23891aeae3229baf8c7c23b76be3364e1967]
stable/6.1: [d30090eb546d993ea3f3023452540c476ea614a5]

CVE-2023-53271: ubi: Fix unreferenced object reported by kmemleak in
ubi_resize_volume()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53271

Introduced by commit 799dca3 ("UBI: hide EBA internals") in v4.9-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [26ec2d66aecab8ff997b912c20247fedba4f5740]
mainline: [1e591ea072df7211f64542a09482b5f81cb3ad27]
stable/5.10: [31d60afe2cc2b712dbefcaab6b7d6a47036f844e]
stable/5.15: [95a72417dd13ebcdcb1bd0c5d4d15f7c5bfbb288]
stable/5.4: [07b60f7452d2fa731737552937cb81821919f874]
stable/6.1: [27b760b81951d8d5e5c952a696af8574052b0709]

CVE-2023-53272: net: ena: fix shift-out-of-bounds in exponential backoff

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53272

Introduced by commit 4bb7f4c ("net: ena: reduce driver load time") in v5.8-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e9cb763e9bacf0c932aa948f50dcfca6f519a26]
stable/5.10: [1e760b2d18bf129b3da052c2946c02758e97d15e]
stable/5.15: [3e36cc94d6e60a27f27498adf1c71eeba769ab33]
stable/6.1: [90947ebf8794e3c229fb2e16e37f1bfea6877f14]

CVE-2023-53273: Drivers: vmbus: Check for channel allocation before
looking up relids

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53273

Introduced by commit 8b6a877 ("Drivers: hv: vmbus: Replace the per-CPU
channel lists with a global array of channels") in v5.8-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1eb65c8687316c65140b48fad27133d583178e15]
stable/5.10: [176c6b4889195fbe7016d9401175b48c5c9edf68]
stable/5.15: [c373e49fbb87aa177819866ed9194ebc5414dfd6]
stable/6.1: [8c3f0ae5435fd20bb1e3a8308488aa6ac33151ee]

CVE-2023-53274: clk: mediatek: mt8183: Add back SSPM related clocks

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53274

Introduced by commit 3f37ba7 ("clk: mediatek: mt8183: Convert all
remaining clocks to common probe") in v6.4-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1eb8d61ac5c9c7ec56bb96d433532807509b9288]

CVE-2023-53275: ALSA: hda: fix a possible null-pointer dereference due
to data race in snd_hdac_regmap_sync()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53275

Introduced commit is not determined.Fixed in v6.5-rc1.
Vulnerable function was added by 1a462be5 ("ALSA: hda: Manage
concurrent reg access more properly") in 5.6-rc1.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [1f4a08fed450db87fbb5ff5105354158bdbe1a22]
stable/5.10: [9f9eed451176ffcac6b5ba0f6dae1a6b4a1cb0eb]
stable/5.15: [8703b26387e1fa4f8749db98d24c67617b873acb]
stable/5.4: [109f0aaa0b8838a88af9125b79579023539300a7]
stable/6.1: [cdd412b528dee6e0851c4735d6676ec138da13a4]

CVE-2023-53276: ubifs: Free memory for tmpfile name

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53276

Introduced commit is not determined.Fixed in v6.4-rc1.
Encrypted filenames feature was introduced by f4f61d2 ("ubifs: Implement
  encrypted filenames") in 4.10-rc1.

Fixed status
cip/4.19-st: [107d481642c356a5668058066360fc473911e628]
mainline: [1fb815b38bb31d6af9bd0540b8652a0d6fe6cfd3]
stable/5.10: [b8f444a4fadfb5070ed7e298e0a5ceb4a18014f3]
stable/5.15: [ce840284929b75dbbf062e0ce7fcb78a63b08b5e]
stable/5.4: [823f554747f8aafaa965fb2f3ae794110ed429ef]
stable/6.1: [29738e1bcc799dd754711d4e4aab967f0c018175]

CVE-2023-53277: wifi: iwl3945: Add missing check for
create_singlethread_workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53277

Introduced by commit b481de9 ("[IWLWIFI]: add iwlwifi wireless
drivers") in v2.6.24-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3ae2fc4de12686f3fe695824169c1272c9f798f7]
mainline: [1fdeb8b9f29dfd64805bb49475ac7566a3cb06cb]
stable/5.10: [2f80b3ff92514ebd227e5c55d3d1e480401b02b7]
stable/5.15: [505c74c4c0b1c5bcaa98a93b3087c268156070f1]
stable/5.4: [7e594abc0424e4f8c2385f11aefeaadcfc507aa5]
stable/6.1: [34f611204ae589bd5c494b10b41fb13436bd3c3f]

CVE-2023-53278: ubifs: Fix memory leak in ubifs_sysfs_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53278

Introduced by commit 2e3cbf4 ("ubifs: Export filesystem error
counters") in v5.17-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [203a55f04f66eea1a1ca7e5a302a7f5c99c62327]
stable/6.1: [1c5fdf2d4647219d2267ccb08c7f2c7095bf3450]

CVE-2023-53279: misc: vmw_balloon: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53279

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 37b85bd ("drivers: vmw_balloon: remove
dentry pointer for debugfs") in 5.13-rc1.

Fixed status
mainline: [209cdbd07cfaa4b7385bad4eeb47e5ec1887d33d]
stable/5.15: [b94b39bf3d545671f210a2257d18e33c8b874699]
stable/6.1: [d1c545e44c1ec08bef0c0c14e632eec516431e9c]

CVE-2023-53280: scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53280

Introduced by commit 219d27d ("scsi: qla2xxx: Fix race conditions in
the code for aborting SCSI commands") in v5.2-rc1.
Introduced by commit 5621b0d ("scsi: qla2xxx: Simpify unregistration
of FC-NVMe local/remote ports") in v4.14-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20fce500b232b970e40312a9c97e7f3b6d7a709c]
stable/5.10: [0b1ce92fabdb7d02ddf8641230a06e2752ae5baa]
stable/5.15: [522ee1b3030f3b6b5fd59489d12b4ca767c9e5da]
stable/5.4: [b7084ebf4f54d46fed5153112d685f4137334175]
stable/6.1: [f459d586fdf12c53116c9fddf43065165fdd5969]

CVE-2023-53281: drivers: staging: rtl8723bs: Fix locking in
_rtw_join_timeout_handler()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53281

Introduced by commit 041879b ("drivers: staging: rtl8192bs: Fix
deadlock in rtw_joinbss_event_prehandle()") in v5.19-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [215792eda008f6a1e7ed9d77fa20d582d22bb114]
stable/5.15: [209850f17717a3b5cc558578bef5631ac7045539]
stable/6.1: [2a50e44a66d268ee5db3d177f1fdc1503dbce6e7]

CVE-2023-53282: scsi: lpfc: Fix use-after-free KFENCE violation during
sysfs firmware write

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53282

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [21681b81b9ae548c5dae7ae00d931197a27f480c]
stable/5.15: [51ab4eb1a25e73c7fc2ad9026520c4d8369c93cc]
stable/6.1: [8dfefa8f424ab208e552df1bfd008b732f3d0ad1]

CVE-2023-53284: drm/msm/dpu: check for null return of devm_kzalloc()
in dpu_writeback_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53284

Introduced by commit 77b001a ("drm/msm/dpu: add the writeback
connector layer") in v5.19-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21e9a838f505178e109ccb3bf19d7808eb0326f4]
stable/6.1: [3723c4dbcd14cc96771000ce0b0540801e6ba059]

CVE-2023-53285: ext4: add bounds checking in get_max_inline_xattr_value_size()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53285

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
cip/4.19-st: [3d7b8fbcd2273e2b9f4c6de5ce2f4c0cd3cb1205]
cip/4.4-st: [c3ac22e756897ef7d656548a55275bccdaadb52a]
mainline: [2220eaf90992c11d888fe771055d4de330385f01]
stable/5.10: [4597554b4f7b29e7fd78aa449bab648f8da4ee2c]
stable/5.15: [f22b274429e88d3dc7e79d375b56ce4f2f59f0b4]
stable/5.4: [486efbbc9445dca7890a1b86adbccb88b91284b0]
stable/6.1: [1d2caddbeeee56fbbc36b428c5b909c3ad88eb7f]

CVE-2023-53286: RDMA/mlx5: Return the firmware result upon destroying QP/RQ

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53286

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [22664c06e997087fe37f9ba208008c948571214a]
stable/5.10: [73311dd831858d797cf8ebe140654ed519b41c36]
stable/5.15: [1a650d3ccd79cdd5796edd864683a6b8dd0bf576]
stable/6.1: [5fe7815e784bf21061885f8112a7108aef5c45bd]

CVE-2023-53287: usb: cdns3: Put the cdns set active part outside the spin lock

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53287

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected driver was added by 7733f6c ("usb: cdns3: Add Cadence USB3 DRD Driver")
  in 5.4-rc1.

Fixed status
mainline: [2319b9c87fe243327285f2fefd7374ffd75a65fc]
stable/5.15: [c861a61be6d30538ebcf7fcab1d43f244e298840]
stable/6.1: [bbc9c3652708108738009e096d608ece3cd9fa8a]
stable/6.6: [2319b9c87fe243327285f2fefd7374ffd75a65fc]

CVE-2023-53288: drm/client: Fix memory leak in drm_client_modeset_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53288

Introduced commit is not determined.Fixed in v6.5-rc3.
Vulnerable function was added by cf13909a ("drm/fb-helper: Move out
modeset config code") in 5.3-rc1.

Fixed status
mainline: [2329cc7a101af1a844fbf706c0724c0baea38365]
stable/5.10: [5f2a12f64347f535c6ef55fa7eb36a2874d69b59]
stable/5.15: [1369d0c586ad44f2d18fe2f4cbc5bcb24132fa71]
stable/5.4: [5d580017bdb9b3e930b6009e467e5e1589f8ca8a]
stable/6.1: [917bef37cfaca07781c6fbaf6cd9404d27e64e6f]

CVE-2023-53289: media: bdisp: Add missing check for create_workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53289

Introduced by commit 28ffeeb ("[media] bdisp: 2D blitter driver using
v4l2 mem2mem framework") in v4.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2bfbe3ad371ac5349302833198df14e442622cbc]
cip/4.4-st: [83d3d1f07871a8adf2af2b720338c4e5cecbfed7]
mainline: [2371adeab717d8fe32144a84f3491a03c5838cfb]
stable/5.10: [4362444dca02ab44ac844feda3cf6238ef953673]
stable/5.15: [519b0849401194745ea40f9e07513b870afc1b42]
stable/5.4: [c6a315f0b14074ac89723f55b749a557dda0ae2b]
stable/6.1: [c2e55481731b0e8c96f30f661e430aa884fbd354]

CVE-2023-53290: samples/bpf: Fix fout leak in hbm's run_bpf_prog

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53290

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected function was added by a1270fe ("bpf: User program for testing
HBM") in 5.1-rc1.

Fixed status
mainline: [23acb14af1914010dd0aae1bbb7fab28bf518b8e]
stable/5.10: [7560ed6592ff4077528c239c71e91b19de985b97]
stable/5.15: [e3e6e252d74f20f6fc610c7fef3ae7dda0109a6f]
stable/5.4: [a7ec2f424f6edad34651137783a0a59eca9aa37e]
stable/6.1: [f2065b8b0a215bc6aa061287a2e3d9eab2446422]

CVE-2023-53291: rcu/rcuscale: Stop kfree_scale_thread thread(s) after
unloading rcuscale

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53291

Introduced by commit e6e78b0 ("rcuperf: Add kfree_rcu() performance
Tests") in v5.6-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23fc8df26dead16687ae6eb47b0561a4a832e2f6]
stable/5.10: [604d6a5ff718874904b0fe614878a42b42c0d699]
stable/5.15: [f766d45ab294871a3d588ee76c666852f151cad9]
stable/6.1: [b8a6ba524d41f4da102e65f90498d9a910839621]

CVE-2023-53292: blk-mq: fix NULL dereference on q->elevator in
blk_mq_elv_switch_none

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53292

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected function was added by d48ece2 ("blk-mq: init hctx sched after update
  ctx and hctx mapping") in 4.19-rc1.

Fixed status
mainline: [245165658e1c9f95c0fecfe02b9b1ebd30a1198a]

CVE-2023-53293: Bluetooth: btrtl: check for NULL in btrtl_set_quirks()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53293

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [253cf30e8d3d001850a95c4729d668f916b037ab]
stable/6.1: [ea160ece08668a30ce69f92cc08e87da54a64a9c]

CVE-2023-53294: fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53294

Introduced by commit 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [254e69f284d7270e0abdc023ee53b71401c3ba0c]
stable/5.15: [f8d9e062a695a3665c4635c4f216a75912687598]
stable/6.1: [d69d5e2a81df94534bdb468bcdd26060fcb7191a]

CVE-2023-53295: udf: Do not update file length for failed writes to inline files

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53295

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [5a6c373d761f55635e175fa2f407544bae8f583b]
cip/4.4-st: [e2eef29721c1aecd4abc68583d96ff4fc6f01561]
mainline: [256fe4162f8b5a1625b8603ca5f7ff79725bfb47]
stable/5.10: [eb2133900cac2d2f78befd6be41666cf1a2315d9]
stable/5.15: [c5787d77a5c29fffd295d138bd118b334990a567]
stable/5.4: [7bd8d9e1cf5607ee14407f4060b9a1dbb3c42802]
stable/6.1: [6837910aeb2c9101fc036dcd1b1f32615c20ec1a]

CVE-2023-53296: sctp: check send stream number after wait_for_sndbuf

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53296

Introduced by commit 5bbbbe3 ("sctp: introduce stream scheduler
foundations") in v4.15-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9346a1a21142357972a6f466ba6275ddc54b04ac]
mainline: [2584024b23552c00d95b50255e47bd18d306d31a]
stable/5.10: [b4b6dfad41aaae9e36e44327b18d5cf4b20dd2ce]
stable/5.15: [667eb99cf7c15fe5b0ecefe75cf658e20ef20c9f]
stable/5.4: [0443fff49d6352160c200064156c25898bd9f58c]
stable/6.1: [d2128636b303aa9cf065055402ee6697409a8837]

CVE-2023-53297: Bluetooth: L2CAP: fix "bad unlock balance" in
l2cap_disconnect_rsp

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53297

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [6a27762340ad08643de3bc17fe1646ea489ca2e2]
cip/4.4-st: [56e18c51b6cedad27b25a52bb5d4da27e597a819]
mainline: [25e97f7b1866e6b8503be349eeea44bb52d661ce]
stable/5.10: [55410a9144c76ecda126e6cdec556dfcd8f343b2]
stable/5.15: [116b9c002c894097adc2b8684db2d1da4229ed46]
stable/5.4: [2112c4c47d36bc5aba3ddeb9afedce6ae6a67e7d]
stable/6.1: [fd269a0435f8e9943b7a57c5a59688848d42d449]

CVE-2023-53298: nfc: fix memory leak of se_io context in nfc_genl_se_io

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53298

Introduced by commit 5ce3f32 ("NFC: netlink: SE API implementation")
in v3.13-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [af452e35b9e6a87cd49e54a7a3d60d934b194651]
cip/4.4-st: [f4fe24f3b1585176c05d2a92d3a393e81188cb33]
mainline: [25ff6f8a5a3b8dc48e8abda6f013e8cc4b14ffea]
stable/5.10: [8978315cb4bf8878c9c8ec05dafd8f7ff539860d]
stable/5.15: [c494365432dcdc549986f4d9af9eb6190cbdb153]
stable/5.4: [271eed1736426103335c5aac50f15b0f4d236bc0]
stable/6.1: [b2036a252381949d3b743a3de069324ae3028a57]

CVE-2023-53299: md/raid10: fix leak of 'r10bio->remaining' for recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53299

Introduced by commit 24afd80 ("md/raid10: handle recovery of
replacement devices.") in v3.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1d2c6c6e37fe5de11fd01a82badf03390e12df7a]
cip/4.4-st: [ffd924761e4a0fb0eb0b9812ef643a51cf5e76e9]
mainline: [26208a7cffd0c7cbf14237ccd20c7270b3ffeb7e]
stable/5.10: [1697fb124c6d6c5237e9cbd78890310154738084]
stable/5.15: [8d09065802c53cc938d162b62f6c4150b392c90e]
stable/5.4: [8c5d5d7ffd1e76734811b8ea5417cf0432b9952c]
stable/6.1: [11141630f03efffdfe260b3582b2d93d38171b97]

CVE-2023-53300: media: hi846: Fix memleak in hi846_init_controls()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53300

Introduced by commit e8c0882 ("media: i2c: add driver for the SK Hynix
Hi-846 8M pixel camera") in v5.16-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2649c1a20e8e399ee955d0e22192f9992662c3d2]
stable/6.1: [fd22e8c8c38fb40f130d3a60e52c59996a5bbae9]

CVE-2023-53301: f2fs: fix kernel crash due to null io->bio

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53301

Introduced by commit 64bf0ee ("f2fs: pass the bio operation to
bio_alloc_bioset") in v5.18-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [267c159f9c7bcb7009dae16889b880c5ed8759a8]
stable/6.1: [83dbb9a1bd5ef2eea73275906fc50b2fdda39cd5]

CVE-2023-53302: wifi: iwl4965: Add missing check for
create_singlethread_workqueue()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53302

Introduced by commit b481de9 ("[IWLWIFI]: add iwlwifi wireless
drivers") in v2.6.24-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [874a85051cc8df8c5b928d8ff172b342cdc5424b]
mainline: [26e6775f75517ad6844fe5b79bc5f3fa8c22ee61]
stable/5.10: [3185d6cfc59277a77bf311dce701b7e25193f66a]
stable/5.15: [f15ef0ebcf56be1d4a3c9a7a80a1f1f82ab0eaad]
stable/5.4: [c002d2741400771171b68dde9af937a4dfa0d1b3]
stable/6.1: [2f85c768bea2057e3299d19514da9e932c4f92d2]

CVE-2023-53303: net: microchip: vcap api: Fix possible memory leak for
vcap_dup_rule()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53303

Introduced by commit 814e769 ("net: microchip: vcap api: Add a storage
state to a VCAP rule") in v6.3-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [281f65d29d6da1a9b6907fb0b145aaf34f4e4822]
stable/6.6: [281f65d29d6da1a9b6907fb0b145aaf34f4e4822]

CVE-2023-53304: netfilter: nft_set_rbtree: fix overlap expiration walk

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53304

Introduced by commit c9e6978 ("netfilter: nft_set_rbtree: Switch to
node list walk for overlap detection") in v6.2-rc6.
Fixed in v6.5-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
cip/4.19-st: [8284a79136c384059e85e278da2210b809730287]
mainline: [f718863aca469a109895cb855e6b81fff4827d71]
stable/5.10: [893cb3c3513cf661a0ff45fe0cfa83fe27131f76]
stable/5.15: [50cbb9d195c197af671869c8cadce3bd483735a0]
stable/5.4: [acaee227cf79c45a5d2d49c3e9a66333a462802c]
stable/6.1: [89a4d1a89751a0fbd520e64091873e19cc0979e8]

CVE-2023-53305: Bluetooth: L2CAP: Fix use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53305

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [1a40c56e8bff3e424724d78a9a6b3272dd8a371d]
cip/4.4-st: [a2aec4c772bc9168cb88c0a5a757ef1035155f12]
mainline: [f752a0b334bb95fe9b42ecb511e0864e2768046f]
stable/5.10: [2958cf9f805b9f0bdc4a761bf6ea281eb8d44f8e]
stable/5.15: [548a6b64b3c0688f01119a6fcccceb41f8c984e4]
stable/5.4: [fe49aa73cca6608714477b74bfc6874b9db979df]
stable/6.1: [149daab45922ab1ac7f0cbeacab7251a46bf5e63]

CVE-2023-53306: fsdax: force clear dirty mark if CoW

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53306

Introduced by commit f80e166 ("fsdax: invalidate pages when CoW") in v6.2-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f76b3a32879de215ced3f8c754c4077b0c2f79e3]

CVE-2023-53307: rbd: avoid use-after-free in do_rbd_add() when
rbd_dev_create() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53307

Introduced by commit 1643dfa ("rbd: introduce a per-device ordered
workqueue") in v4.9-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e3cbb4d60764295992c95344f2d779439e8b34ce]
mainline: [f7c4d9b133c7a04ca619355574e96b6abf209fba]
stable/5.10: [ae16346078b1189aee934afd872d9f3d0a682c33]
stable/5.15: [a73783e4e0c4d1507794da211eeca75498544dff]
stable/5.4: [9787b328c42c13c4f31e7d5042c4e877e9344068]
stable/6.1: [faa7b683e436664fff5648426950718277831348]

CVE-2023-53308: net: fec: Better handle pm_runtime_get() failing in .remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53308

Introduced by commit a31eda6 ("net: fec: fix clock count mis-match") in v5.4.
Fixed in v6.4-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [be85912c36ddca3e8b2eef1b5392cd8db6bdb730]
mainline: [f816b9829b19394d318e01953aa3b2721bca040d]
stable/5.10: [83996d317b1deddc85006376082e8886f55aa709]
stable/5.15: [c1bc2870f14e526a01897e14c747a0a0ca125231]
stable/5.4: [b22b514209ff8c4287abb853399890ab97e1b5ca]
stable/6.1: [9407454a9b18bbeff216e8ecde87ffb2171e9ccf]

CVE-2023-53309: drm/radeon: Fix integer overflow in radeon_cs_parser_init

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53309

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [cfa9148bafb2d3292b65de1bac79dcca65be2643]
cip/4.4-st: [1641e0893689d7928cffa3ed5253c6603d635461]
mainline: [f828b681d0cd566f86351c0b913e6cb6ed8c7b9c]
stable/5.10: [e6825b30d37fe89ceb87f926d33d4fad321a331e]
stable/5.15: [c0d7dbc6b7a61a56028118c00af2c8319d44a682]
stable/5.4: [b8fab6aebdf2115ec2d7bd2f3498d5b911ff351e]
stable/6.1: [2e1be420b86980c25a75325e90dfc3fc73126f61]

CVE-2023-53310: power: supply: axp288_fuel_gauge: Fix
external_power_changed race

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53310

Introduced by commit 30abb3d ("power: supply: axp288_fuel_gauge: Take
lock before updating the valid flag") in v5.18-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8319774d6f1567d6e7d03653174ab0c82c5c66d]
stable/6.1: [0456b912121e45b3ef54abe3135e5dcb541f956c]

CVE-2023-53311: nilfs2: fix use-after-free of nilfs_root in dirtying
inodes via iput

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53311

Introduced by commit 0ae45f6 ("vfs: add support for a lazytime mount
option") in v4.0-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a3c3b4cbf9b8554120fb230e6516e980c6277487]
cip/4.4-st: [3b01f950382a41c82314c2ce95e966275e4961ad]
mainline: [f8654743a0e6909dc634cbfad6db6816f10f3399]
stable/5.10: [37207240872456fbab44a110bde6640445233963]
stable/5.15: [3645510cf926e6af2f4d44899370d7e5331c93bd]
stable/5.4: [d2c539c216cce74837a9cf5804eb205939b82227]
stable/6.1: [7532ff6edbf5242376b24a95a2fefb59bb653e5a]

CVE-2023-53312: net: fix net_dev_start_xmit trace event vs
skb_transport_offset()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53312

Introduced by commit 66e4c8d ("net: warn if transport header was not
set") in v5.19-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f88fcb1d7d961b4b402d675109726f94db87571c]
stable/6.1: [ced61418f46993d571385812bafed3a7d4ab6918]

CVE-2023-53313: md/raid10: fix wrong setting of max_corr_read_errors

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53313

Introduced by commit 1e50915 ("raid: improve MD/raid10 handling of
correctable read errors.") in v2.6.33-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [025fde32fb957a5c271711bc66841f817ff5f299]
cip/4.4-st: [e4bf18b238ba76b5f5dae7e41e68113a765f651c]
mainline: [f8b20a405428803bd9881881d8242c9d72c6b2b2]
stable/5.10: [b1d8f38310bce3282374983b229d94edbaf1e570]
stable/5.15: [3c76920e547d4b931bed758bad83fd658dd88b4e]
stable/5.4: [31c805a44b7569ca1017a4714385182d98bba212]
stable/6.1: [05d10428e8dffed0bac2502f34151729fc189cd3]

CVE-2023-53314: fbdev/ep93xx-fb: Do not assign to struct fb_info.dev

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53314

Introduced by commit 88017bd ("ep93xx video driver") in v2.6.32-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1c6ff2a7c593db851f23e31ace2baf557ea9d0ff]
cip/4.4-st: [7d367b163f19b1d7d17fc38f957b6fa86c7adee3]
mainline: [f90a0e5265b60cdd3c77990e8105f79aa2fac994]
stable/5.10: [4aade6c9100a3537788b6a9c7ac481037d19efdf]
stable/5.15: [309c27162afea79b3c7f8747bb650faf6923b639]
stable/5.4: [8ffa40ff64aa43a9a28fcf209b48d86a3e0f4972]
stable/6.1: [f83c1b13f8154e0284448912756d0a351a1a602a]
stable/6.6: [f90a0e5265b60cdd3c77990e8105f79aa2fac994]

CVE-2023-53315: wifi: ath11k: Fix SKB corruption in REO destination ring

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53315

Introduced commit is not determined.Fixed in v6.4-rc1.
The ath11k driver was added by d5c6515 ("ath11k: driver for Qualcomm IEEE
  802.11ax devices") in 5.6-rc1.

Fixed status
mainline: [f9fff67d2d7ca6fa8066132003a3deef654c55b1]
stable/5.10: [866921dc06b94df91acfcf9359b57da943ed99b3]
stable/5.15: [3d3f8fe01a01d94a17fe1ae0d2e894049a972717]
stable/6.1: [068fd06148fbf0af95bb08dc77cff34ee679fdbc]

CVE-2023-53316: drm/msm/dp: Free resources after unregistering them

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53316

Introduced by commit c943b49 ("drm/msm/dp: add displayPort driver
support") in v5.10-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa0048a4b1fa7a50c8b0e514f5b428abdf69a6f8]
stable/5.10: [c67a55f7cc8d767d624235bf1bcd0947e56abe0f]
stable/5.15: [3c3f3d35f5e05c468b048eb42a4f8c62c6655692]
stable/6.1: [4e9f1a2367aea7d61f6781213e25313cd983b0d7]

CVE-2023-53317: ext4: fix WARNING in mb_find_extent

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53317

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
cip/4.19-st: [775b00ba23f6f916fe2ac60c5ff7fd0fe4f28d0d]
mainline: [fa08a7b61dff8a4df11ff1e84abfc214b487caf7]
stable/5.10: [5d356d902e9d5b1aaaaf2326d365340fa8a90c1b]
stable/5.15: [d55e76e11592a1d18a179c7fd34ca1b52632beb3]
stable/5.4: [1b90fbc7590124c57a2e590de7fd07eba26606f1]
stable/6.1: [dba62fa84a8eac44a53a2862de8a40e5bdfa0ae3]

CVE-2023-53318: recordmcount: Fix memory leaks in the uwrite function

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53318

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [444ec005404cead222ebce2561a9451c9ee5ad89]
cip/4.4-st: [1227af526218db06ddbc8743deb447061e8a2b31]
mainline: [fa359d068574d29e7d2f0fdd0ebe4c6a12b5cfb9]
stable/5.10: [2d9ca5f62f2ba160ff9c9be4adf401c46c04edef]
stable/5.15: [ff70ad9159fbb566b2c15724f44207e8deccd527]
stable/5.4: [3ed95a6f6c646e8bb15c354536e0ab10e8f39c08]
stable/6.1: [895130e63c93926f07caf5db286b97bd27b81de9]

CVE-2023-53319: KVM: arm64: Handle kvm_arm_init failure correctly in
finalize_pkvm

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53319

Introduced by commit 87727ba ("KVM: arm64: Ensure CPU PMU probes
before pKVM host de-privilege") in v6.4-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa729bc7c9c8c17a2481358c841ef8ca920485d3]

CVE-2023-53320: scsi: mpi3mr: Fix issues in mpi3mr_get_all_tgt_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53320

Introduced by commit f5e6d5a ("scsi: mpi3mr: Add support for driver
commands") in v5.19-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb428a2005fc1260d18b989cc5199f281617f44d]
stable/6.1: [8ba997b22f2cd5d29aad8c39f6201f7608ed0c04]

CVE-2023-53321: wifi: mac80211_hwsim: drop short frames

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53321

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [fba360a047d5eeeb9d4b7c3a9b1c8308980ce9a6]
stable/5.10: [672205c6f2d11978fcd7f0f336bb2c708e28874b]
stable/5.15: [c64ee9dd335832d5e2ab0a8fc83a34ad4c729799]
stable/5.4: [3beb97bed860d95b14ad23578ce8ddaea62023db]
stable/6.1: [b9a175e3b250b0dc6e152988040aa5014e98e61e]
stable/6.6: [fba360a047d5eeeb9d4b7c3a9b1c8308980ce9a6]

CVE-2023-53322: scsi: qla2xxx: Wait for io return on terminate rport

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53322

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [4647d2e88918a078359d1532d90c417a38542c9e]
cip/4.4-st: [b7479b463da8e9b52f33fea8a35abe39df75a86c]
mainline: [fc0cba0c7be8261a1625098bd1d695077ec621c9]
stable/5.10: [a9fe97fb7b4ee21bffb76f2acb05769bad27ae70]
stable/5.15: [079c8264ed9fea8cbcac01ad29040f901cbc3692]
stable/5.4: [d25fded78d88e1515439b3ba581684d683e0b6ab]
stable/6.1: [90770dad1eb30967ebd8d37d82830bcf270b3293]

CVE-2023-53323: ext2/dax: Fix ext2_setsize when len is page aligned

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53323

Introduced by commit 2aa3048 ("iomap: switch iomap_zero_range to use
iomap_iter") in v5.15-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcced95b6ba2a507a83b8b3e0358a8ac16b13e35]
stable/6.1: [9e54fd14bd143c261e52fde74355e85e9526c58c]

CVE-2023-53324: drm/msm/mdp5: Don't leak some plane state

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53324

Introduced by commit 21a01ab ("drm/atomic: Fix freeing connector/plane
state too early by tracking commits, v3.") in v4.15-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7fc11a830b2eb07a0e3c6f917e5e636df6fc5d4c]
mainline: [fd0ad3b2365c1c58aa5a761c18efc4817193beb6]
stable/5.10: [815e42029f6e1e762898079f85546d6a0391ab95]
stable/5.15: [c0b1eee648702e04f1005d451f9689575b7f52ed]
stable/5.4: [b8a61df6f40448cf46611f7af05b00970d08d620]
stable/6.1: [2965015006ef18ca96d2eab9ebe6bca884c63291]
stable/6.6: [fd0ad3b2365c1c58aa5a761c18efc4817193beb6]

CVE-2023-53325: drm/mediatek: dp: Change logging to dev for
mtk_dp_aux_transfer()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53325

Introduced commit is not determined.Fixed in v6.6-rc1.
Vulerable functions were added by f70ac097 ("drm/mediatek: Add MT8195
Embedded DisplayPort driver") in 6.1-rc1.

Fixed status
mainline: [fd70e2019bfbcb0ed90c5e23839bf510ce6acf8f]
stable/6.1: [4c743c1dd2ee2a72951660b6798d4d7f7674f87b]
stable/6.6: [fd70e2019bfbcb0ed90c5e23839bf510ce6acf8f]

CVE-2023-53326: powerpc: Don't try to copy PPR for task with NULL pt_regs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53326

Introduced by commit fa43981 ("powerpc/ptrace: Enable support for
NT_PPPC_TAR, NT_PPC_PPR, NT_PPC_DSCR") in v4.8-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd7276189450110ed835eb0a334e62d2f1c4e3be]
stable/5.10: [80a4200d51e5a7e046f4a90f5faa5bafd5a60c58]
stable/5.15: [7624973bc15b76d000e8e6f9b8080fcb76d36595]
stable/6.1: [064a1c7b0f8403260d77627e62424a72ca26cee2]

CVE-2023-53327: iommufd/selftest: Catch overflow of uptr and length

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53327

Introduced by commit f4b20bb ("iommufd: Add kernel support for testing
iommufd") in v6.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd8c1a4aee973e87d890a5861e106625a33b2c4e]

CVE-2023-53328: fs/ntfs3: Enhance sanity check while generating attr_list

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53328

Introduced commit is not determined.Fixed in v6.5-rc1.
The ntfs3 support is added by 4342306 ("fs/ntfs3: Add file operations and
  implementation") 5.15-rc1.

Fixed status
mainline: [fdec309c7672cbee4dc0229ee4cbb33c948a1bdd]
stable/5.15: [e7799bb4dbe26bfb665f29ea87981708fd6012d8]
stable/6.1: [4246bbef0442f4a1e974df0ab091f4f33ac69451]

CVE-2023-53329: workqueue: fix data race with the pwq->stats[] increment

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53329

Introduced by commit 725e8ec ("workqueue: Add pwq->stats[] and a
monitoring script") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe48ba7daefe75bbbefa2426deddc05f2d530d2d]
stable/6.6: [fe48ba7daefe75bbbefa2426deddc05f2d530d2d]

CVE-2023-53330: caif: fix memory leak in cfctrl_linkup_request()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53330

Introduced by commit b482cd2 ("net-caif: add CAIF core protocol
stack") in v2.6.35-rc1.
Introduced by commit 8d545c8 ("caif: Disconnect without waiting for
response") in v2.6.35-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3acf3783a84cbdf0c9f8cf2f32ee9c49af93a2da]
cip/4.4-st: [d849764f973b52f571a2cbaeee185f1536d32202]
mainline: [fe69230f05897b3de758427b574fc98025dfc907]
stable/5.10: [84b2cc7b36b7f6957d307fb3d01603f93cb2d655]
stable/5.15: [dc1bc903970bdf63ca40ab923d3ccb765da9a8d9]
stable/5.4: [33df9c5d5e2a18c70f5f5f3c2757d654c1b6ffa3]
stable/6.1: [3ad47c8aa5648226184415e4a0cb1bf67ffbfd48]

CVE-2023-53331: pstore/ram: Check start of empty przs during init

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53331

Introduced by commit 3069637 ("pstore/ram: Do not treat empty buffers
as valid") in v5.0-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [c807ccdd812d18985860504b503899f3140a9549]
cip/4.4-st: [b123e6a8ac148a82e4f5bf31f018d6306ae6ad70]
mainline: [fe8c3623ab06603eb760444a032d426542212021]
stable/5.10: [dc2f60de9a7d3efd982440117dab5579898d808c]
stable/5.15: [fedecaeef88899d940b69368c996e8b3b0b8650d]
stable/5.4: [e972231db29b5d1dccc13bf9d5ba55b6979a69ed]
stable/6.1: [e95d7a8a6edd14f8fab44c777dd7281db91f6ae2]
stable/6.6: [fe8c3623ab06603eb760444a032d426542212021]

CVE-2023-53332: genirq/ipi: Fix NULL pointer deref in
irq_data_get_affinity_mask()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53332

Introduced by commit 3b8e29a ("genirq: Implement
ipi_send_mask/single()") in v4.6-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [feabecaff5902f896531dde90646ca5dfa9d4f7d]
stable/6.1: [926aef60ea64cd9becf2829f7388f48dbe8bcb11]

CVE-2023-53333: netfilter: conntrack: dccp: copy entire header to
stack buffer, not just basic one

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53333

Introduced by commit 2bc7804 ("[NETFILTER]: nf_conntrack: add DCCP
protocol support") in v2.6.26-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff0a3a7d52ff7282dbd183e7fc29a1fe386b0c30]
stable/5.10: [9bdcda7abaf22f6453e5b5efb7eb4e524095d5d8]
stable/5.15: [c052797ac36813419ad3bfa54cb8615db4b41f15]
stable/5.4: [337fdce450637ea663bc816edc2ba81e5cdad02e]
stable/6.1: [5c618daa5038712c4a4ef8923905a2ea1b8836a1]

CVE-2023-53334: USB: chipidea: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53334

Introduced commit is not determined.Fixed in v6.3-rc1.
Vulnerable code was added by 8f6c7c5 ("USB: chipidea: remove dentry
storage for debugfs file") in 5.14-rc1.

Fixed status
mainline: [ff35f3ea3baba5b81416ac02d005cfbf6dd182fa]
stable/5.15: [4322661af6d7a586a5798ab9aa443f49895b6943]
stable/6.1: [610373dd354f3d393aa3bdcab59f55024c16b5e5]

CVE-2025-39805: net: macb: fix unregister_netdev call order in macb_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39805

Introduced by commit 8b73fa3 ("net: macb: Added ZynqMP-specific
initialization") in v5.18-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01b9128c5db1b470575d07b05b67ffa3cb02ebf1]
stable/6.12: [ff0d3bad32108b57265e5b48f15327549af771d3]

CVE-2025-39806: HID: multitouch: fix slab out-of-bounds access in
mt_report_fixup()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39806

Introduced by commit c8000de ("HID: multitouch: Add support for
GT7868Q") in v6.11-rc5.
Fixed in v6.17-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [0379eb8691b9c4477da0277ae0832036ca4410b4]
stable/5.15: [4263e5851779f7d8ebfbc9cc7d2e9b0217adba8d]
stable/6.1: [7ab7311c43ae19c66c53ccd8c5052a9072a4e338]
stable/6.12: [3055309821dd3da92888f88bad10f0324c3c89fe]
stable/6.6: [d4e6e2680807671e1c73cd6a986b33659ce92f2b]

CVE-2025-39807: drm/mediatek: Add error handling for old state CRTC in
atomic_disable

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39807

Introduced by commit d208261 ("drm/mediatek: Add wait_event_timeout
when disabling plane") in v6.16-rc7.
Fixed in v6.17-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [0c6b24d70da21201ed009a2aca740d2dfddc7ab5]
stable/6.12: [7d5cc22efa44e0fe321ce195c71c3d7da211fbb2]

CVE-2025-39808: HID: hid-ntrig: fix unable to handle page fault in
ntrig_report_version()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39808

Introduced commit is not determined.Fixed in v6.17-rc4.


Fixed status
mainline: [185c926283da67a72df20a63a5046b3b4631b7d9]
stable/5.10: [019c34ca11372de891c06644846eb41fca7c890c]
stable/5.15: [4338b0f6544c3ff042bfbaf40bc9afe531fb08c7]
stable/5.4: [22ddb5eca4af5e69dffe2b54551d2487424448f1]
stable/6.1: [6070123d5344d0950f10ef6a5fdc3f076abb7ad2]
stable/6.12: [98520a9a3d69a530dd1ee280cbe0abc232a35bff]
stable/6.6: [e422370e6ab28478872b914cee5d49a9bdfae0c6]

CVE-2025-39809: HID: intel-thc-hid: intel-quicki2c: Fix ACPI dsd
ICRS/ISUB length

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39809

Introduced by commit 5282e45 ("HID: intel-thc-hid: intel-quicki2c: Add
THC QuickI2C ACPI interfaces") in v6.14-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1db9df89a213318a48d958385dc1b17b379dc32b]

CVE-2025-39810: bnxt_en: Fix memory corruption when FW resources
change during ifdown

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39810

Introduced by commit ec5d31e ("bnxt_en: Handle firmware reset status
during IF_UP.") in v5.4-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2747328ba2714f1a7454208dbbc1dc0631990b4a]
stable/6.12: [d00e98977ef519280b075d783653e2c492fffbb6]

CVE-2025-39811: drm/xe/vm: Clear the scratch_pt pointer on error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39811

Introduced by commit 06951c2 ("drm/xe: Use NULL PTEs as scratch PTEs")
in v6.8-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b55ddf36229e0278c956215784ab1feeff510aa]
stable/6.12: [c8277d229c7840e8090d4704e50f2ca014d194c7]

CVE-2025-39812: sctp: initialize more fields in sctp_v6_from_sk()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39812

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e8750469242cad8f01f320131fd5a6f540dbb99]
stable/5.10: [9546934c2054bba1bd605c44e936619159a34027]
stable/5.15: [17d6c7747045e9b802c2f5dfaba260d309d831ae]
stable/5.4: [45e4b36593edffb7bbee5828ae820bc10a9fa0f3]
stable/6.1: [65b4693d8bab5370cfcb44a275b4d8dcb06e56bf]
stable/6.12: [1bbc0c02aea1f1c405bd1271466889c25a1fe01b]
stable/6.6: [463aa96fca6209bb205f49f7deea3817d7ddaa3a]

CVE-2025-39813: ftrace: Fix potential warning in trace_printk_seq
during ftrace_dump

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39813

Introduced by commit d769041 ("ring_buffer: implement new locking") in
v2.6.28-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4013aef2ced9b756a410f50d12df9ebe6a883e4a]
stable/5.10: [5ab0ec206deb99eb3baf8f1d7602aeaa91dbcc85]
stable/5.15: [a6f0f8873cc30fd4543b09adf03f7f51d293f0e6]
stable/5.4: [f299353e7ccbcc5c2ed8993c48fbe7609cbe729a]
stable/6.1: [e80ff23ba8bdb0f41a1afe2657078e4097d13a9a]
stable/6.12: [ced94e137e6cd5e79c65564841d3b7695d0f5fa3]
stable/6.6: [28c8fb7ae2ad27d81c8de3c4fe608c509f6a18aa]

CVE-2025-39814: ice: fix NULL pointer dereference in
ice_unplug_aux_dev() on reset

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39814

Introduced by commit c24a65b ("iidc/ice/irdma: Update IDC to support
multiple consumers") in v6.16-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60dfe2434eed13082f26eb7409665dfafb38fa51]

CVE-2025-39815: RISC-V: KVM: fix stack overrun when loading vlenb

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39815

Introduced by commit 2fa2903 ("RISC-V: KVM: add 'vlenb' Vector CSR")
in v6.8-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [799766208f09f95677a9ab111b93872d414fbad7]
stable/6.12: [c76bf8359188a11f8fd790e5bbd6077894a245cc]

CVE-2025-39816: io_uring/kbuf: always use READ_ONCE() to read ring
provided buffer lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39816

Introduced by commit ae98dbf ("io_uring/kbuf: add support for
incremental buffer consumption") in v6.12-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98b6fa62c84f2e129161e976a5b9b3cb4ccd117b]

CVE-2025-39817: efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39817

Introduced by commit da27a24 ("efivarfs: guid part of filenames are
case-insensitive") in v3.9-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6358f8cf64850f3f27857b8ed8c1b08cfc4685c]
stable/5.10: [794399019301944fd6d2e0d7a51b3327e26c410e]
stable/5.15: [568e7761279b99c6daa3002290fd6d8047ddb6d2]
stable/5.4: [0f63fbabeaaaaaaf5b742a2f4c1b4590d50bf1f6]
stable/6.1: [d7f5e35e70507d10cbaff5f9e194ed54c4ee14f7]
stable/6.12: [c2925cd6207079c3f4d040d082515db78d63afbf]
stable/6.6: [925599eba46045930b850a98ae594d2e3028ac40]

CVE-2025-39818: HID: intel-thc-hid: intel-thc: Fix incorrect pointer
arithmetic in I2C regs save

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39818

Introduced by commit 4228966 ("HID: intel-thc-hid: intel-thc: Add THC
I2C config interfaces") in v6.14-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7fc15ed629be89e51e09b743277c53e0a0168f5]

CVE-2025-39819: fs/smb: Fix inconsistent refcnt update

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39819

Introduced commit is not determined.Fixed in v6.17-rc4.


Fixed status
mainline: [ab529e6ca1f67bcf31f3ea80c72bffde2e9e053e]
stable/6.1: [3fc11ff13fbc2749871d6ac2141685cf54699997]
stable/6.12: [4735f5991f51468b85affb8366b7067248457a71]
stable/6.6: [4191ea1f0bb3e27d65c5dcde7bd00e709ec67141]

CVE-2025-39820: drm/msm/dpu: Add a null ptr check for dpu_encoder_needs_modeset

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39820

Introduced by commit 1ce69c2 ("drm/msm/dpu: move resource allocation
to CRTC") in v6.15-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abebfed208515726760d79cf4f9f1a76b9a10a84]

CVE-2025-39821: perf: Avoid undefined behavior from stopping/starting
inactive events

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39821

Introduced by commit 9734e25 ("perf: Fix the throttle logic for a
group") in v6.16-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b64fdd422a85025b5e91ead794db9d3ef970e369]

CVE-2025-39822: io_uring/kbuf: fix signedness in this_len calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39822

Introduced by commit ae98dbf ("io_uring/kbuf: add support for
incremental buffer consumption") in v6.12-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c64eff368ac676e8540344d27a3de47e0ad90d21]

CVE-2025-39823: KVM: x86: use array_index_nospec with indices that
come from guest

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39823

Introduced by commit 7150629 ("KVM: X86: Implement PV sched yield
hypercall") in v5.3-rc1.
Introduced by commit bdf7ffc ("KVM: LAPIC: Fix pv ipis out-of-bounds
access") in v4.19-rc3.
Introduced by commit 4180bf1 ("KVM: X86: Implement "send IPI"
hypercall") in v4.19-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c87bd4dd43a624109c3cc42d843138378a7f4548]
stable/5.10: [31a0ad2f60cb4816e06218b63e695eb72ce74974]
stable/5.15: [d51e381beed5e2f50f85f49f6c90e023754efa12]
stable/5.4: [72777fc31aa7ab2ce00f44bfa3929c6eabbeaf48]
stable/6.1: [33e974c2d5a82b2f9d9ba0ad9cbaabc1c8e3985f]
stable/6.12: [67a05679621b7f721bdba37a5d18665d3aceb695]
stable/6.6: [f49161646e03d107ce81a99c6ca5da682fe5fb69]

CVE-2025-39824: HID: asus: fix UAF via HID_CLAIMED_INPUT validation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39824

Introduced by commit 9ce12d8 ("HID: asus: Add i2c touchpad support")
in v4.10-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3af6ca9a8c34bbd8cff32b469b84c9021c9e7e4]
stable/5.10: [7170122e2ae4ab378c9cdf7cc54dea8b0abbbca5]
stable/5.15: [eaae728e7335b5dbad70966e2bd520a731fdf7b2]
stable/5.4: [9a9e4a8317437bf944fa017c66e1e23a0368b5c7]
stable/6.1: [a8ca8fe7f516d27ece3afb995c3bd4d07dcbe62c]
stable/6.12: [c0d77e3441a92d0b4958193c9ac1c3f81c6f1d1c]
stable/6.6: [5f3c0839b173f7f33415eb098331879e547d1d2d]

CVE-2025-39825: smb: client: fix race with concurrent opens in rename(2)

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39825

Introduced commit is not determined.Fixed in v6.17-rc2.


Fixed status
mainline: [d84291fc7453df7881a970716f8256273aca5747]
stable/6.1: [c9e7de284da0be5b44dbe79d71573f9f7f9b144c]
stable/6.12: [c9991af5e09924f6f3b3e6996a5e09f9504b4358]
stable/6.6: [24b9ed739c8c5b464d983e12cf308982f3ae93c2]

CVE-2025-39826: net: rose: convert 'use' field to refcount_t

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39826

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d860d1faa6b2ce3becfdb8b0c2b048ad31800061]
stable/6.1: [fb07156cc0742ba4e93dfcc84280c011d05b301f]
stable/6.12: [0085b250fcc79f900c82a69980ec2f3e1871823b]
stable/6.6: [f8c29fc437d03a98fb075c31c5be761cc8326284]

CVE-2025-39827: net: rose: include node references in rose_neigh refcount

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39827

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da9c9c877597170b929a6121a68dcd3dd9a80f45]
stable/6.1: [4cce478c3e82a5fc788d72adb2f4c4e983997639]
stable/6.12: [d7563b456ed44151e1a82091d96f60166daea89b]
stable/6.6: [9c547c8eee9d1cf6e744611d688b9f725cf9a115]

CVE-2025-39828: atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39828

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a]
stable/5.10: [0a6a6d4fb333f7afe22e59ffed18511a7a98efc8]
stable/5.15: [62f368472b0aa4b5d91d9b983152855c6b6d8925]
stable/5.4: [b502f16bad8f0a4cfbd023452766f21bfda39dde]
stable/6.1: [51872b26429077be611b0a1816e0e722278015c3]
stable/6.12: [33f9e6dc66b32202b95fc861e6b3ea4b0c185b0b]
stable/6.6: [3c80c230d6e3e6f63d43f4c3f0bb344e3e8b119b]

CVE-2025-39829: trace/fgraph: Fix the warning caused by missing
unregister notifier

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39829

Introduced by commit 4a2b8dd ("tracing/function-graph-tracer: fix a
regression while suspend to disk") in v2.6.30-rc1.
Fixed in v6.17-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edede7a6dcd7435395cf757d053974aaab6ab1c2]
stable/6.12: [2a2deb9f8df70480050351ac27041f19bb9e718b]

CVE-2025-39830: net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39830

Introduced by commit c61afff ("net/mlx5: HWS, added memory management
handling") in v6.12-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c0a959bebdc1ada13cf9a8242f177c5400299e6]

CVE-2025-39831: fbnic: Move phylink resume out of service_task and
into open/close

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39831

Introduced by commit 6968437 ("eth: fbnic: Add link detection") in v6.11-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ede14a2c6365e7e5d855643c7c8390b5268c467]
stable/6.12: [7aab65c62a8a8b48c02e600fe9367b2af662fcb6]

CVE-2025-39832: net/mlx5: Fix lockdep assertion on sync reset unload event

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39832

Introduced by commit 7a9770f ("net/mlx5: Handle sync reset unload
event") in v6.5-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [902a8bc23a24882200f57cadc270e15a2cfaf2bb]
stable/6.12: [0c87dba9ccd3801d3b503f0b4fd41be343af4f06]
stable/6.6: [ddac9d0fe2493dd550cbfc75eeaf31e9b6dac959]

CVE-2025-39833: mISDN: hfcpci: Fix warning when deleting uninitialized timer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39833

Introduced by commit 87c5fa1 ("mISDN: Add different different timer
settings for hfc-pci") in v2.6.29-rc1.
Introduced by commit 175302f ("mISDN: hfcpci: Fix use-after-free bug
in hfcpci_softirq") in v6.1-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97766512a9951b9fd6fc97f1b93211642bb0b220]

CVE-2025-39834: net/mlx5: HWS, Fix memory leak in
hws_action_get_shared_stc_nic error flow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39834

Introduced by commit 504e536 ("net/mlx5: HWS, added actions handling")
in v6.12-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a630f83592cdad1253523a1b760cfe78fef6cd9c]

CVE-2025-39835: xfs: do not propagate ENODATA disk errors into xattr code

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39835

Introduced by commit 07120f1 ("xfs: Add xfs_has_attr and subroutines")
in v5.9-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae668cd567a6a7622bc813ee0bb61c42bed61ba7]
stable/5.10: [157ddfb05961c68ab7d457a462822a698e4e4bf4]
stable/5.15: [90bae69c2959c39912f0c2f07a9a7894f3fc49f5]
stable/6.1: [e358d4b6225e4c1eb208686a05e360ef8df59e07]
stable/6.12: [dcdf36f1b67884c722abce9b8946e34ffb9f67c8]
stable/6.6: [d3cc7476b89fb45b7e00874f4f56f6b928467c60]

CVE-2025-39836: efi: stmm: Fix incorrect buffer allocation method

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39836

Introduced by commit c44b6be ("efi: Add tee-based EFI variable
driver") in v6.8-rc1.
Fixed in v6.17-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5e81e672699e0c5557b2b755cc8f7a69aa92bff]
stable/6.12: [77ff27ff0e4529a003c8a1c2492c111968c378d3]

CVE-2022-50353: mmc: wmt-sdmmc: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50353

Introduced by commit 3a96dff ("mmc: SD/MMC Host Controller for
Wondermedia WM8505/WM8650") in v3.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ecd6f77af3478f5223aa4011642a891b7dc91228]
mainline: [29276d56f6ed138db0f38cd31aedc0b725c8c76c]
stable/5.10: [9bedf64dda84b29151e41591d8ded9ff0e6d336a]
stable/5.15: [58c3a8d0f1abeb1ca5c2df948be58ad4f7bb6f67]
stable/5.4: [c7a328cea791cc2769b6417943939420913b4a46]
stable/6.1: [eb7a2d516d4fbd165c07877a20feccb047342b1f]

CVE-2022-50354: drm/amdkfd: Fix kfd_process_device_init_vm error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50354

Introduced commit is not determined.Fixed in v6.2-rc1.
The kfd_process_free_gpuvm takes kptr pointer since commit 68df0f19
("drm/amdkfd: Separate pinned BOs destruction from general routine")
in 5.16-rc1.

Fixed status
mainline: [29d48b87db64b6697ddad007548e51d032081c59]
stable/6.1: [9d74d1f52e16d8e07f7fbe52e96d6391418a2fe9]

CVE-2022-50355: staging: vt6655: fix some erroneous memory clean-up loops

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50355

Introduced by commit 5341ee0 ("staging: vt6655: check for memory
allocation failures") in v4.18-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [637672a71f5016a40b0a6c0f3c8ad25eacedc8c3]
mainline: [2a2db520e3ca5aafba7c211abfd397666c9b5f9d]
stable/5.10: [95ac62e8545be2b0a8cae0beef7c682e2e470e48]
stable/5.15: [f19e5b7df54590c831f350381963f25585c8f7d5]
stable/5.4: [88b9cc60f26e8a05d1ddbddf91b09ca2915f20e0]
stable/6.1: [2a2db520e3ca5aafba7c211abfd397666c9b5f9d]

CVE-2022-50356: net: sched: sfb: fix null pointer access issue when
sfb_init() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50356

Introduced by commit e13e02a ("net_sched: SFB flow scheduler") in v2.6.39-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a3fc78210b9f0e85372a2435368962009f480fc]
stable/5.10: [ded86c4191a3c17f8200d17a7d8a6f63b74554ae]
stable/5.15: [c2e1e59d59fafe297779ceae1fe0e6fbebc3e745]
stable/6.1: [2a3fc78210b9f0e85372a2435368962009f480fc]

CVE-2022-50357: usb: dwc3: core: fix some leaks in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50357

Introduced by commit 6f0764b ("usb: dwc3: add a power supply for
current control") in v5.13-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a735e4b5580a2a6bbd6572109b4c4f163c57462]
stable/6.1: [2a735e4b5580a2a6bbd6572109b4c4f163c57462]

CVE-2022-50358: brcmfmac: return error when getting invalid
max_flowrings from dongle

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50358

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [2aca4f3734bd717e04943ddf340d49ab62299a00]
stable/5.10: [2e8bb402b060a6c22160de3d72cee057698177c8]
stable/5.15: [10c4b63d09a5b0ebf1b61af1dae7f25555cf58b6]
stable/5.4: [3cc9299036bdb647408e11e41de3eb1ff6d428cd]
stable/6.1: [200347eb3b2608cc8b54c13dd1d5e03809ba2eb2]

CVE-2022-50359: media: cx88: Fix a null-ptr-deref bug in buffer_prepare()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50359

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [4befc7ffa18ef9a4b70d854465313a345a06862f]
cip/4.4-st: [19296d9c98e8ec6b72fa9a6a879d47a0baeeb35d]
mainline: [2b064d91440b33fba5b452f2d1b31f13ae911d71]
stable/5.10: [c2257c8a501537afab276c306cb717b7260276e1]
stable/5.15: [6f21976095c1e92454ab030976f95f40d652351b]
stable/5.4: [9181af2dbf06e7f432e5dbe88d10b22343e851b9]
stable/6.1: [2b064d91440b33fba5b452f2d1b31f13ae911d71]

CVE-2022-50360: drm/msm/dp: fix aux-bus EP lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50360

Introduced by commit c3bf8e2 ("drm/msm/dp: Add eDP support via
aux_bus") in v5.19-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b57f726611e294dc4297dd48eb8c98ef1938e82]
stable/6.1: [2b57f726611e294dc4297dd48eb8c98ef1938e82]

CVE-2022-50361: wifi: wilc1000: add missing unregister_netdev() in
wilc_netdev_ifc_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50361

Introduced by commit 09ed8bf ("wilc1000: Rename workqueue from
"WILC_wq" to "NETDEV-wq"") in v5.17-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b88974ecb358990e1c33fabcd0b9e142bab7f21]
stable/6.1: [a1bdecedc7ad0512365267cd1a26bfc2ae455c59]

CVE-2022-50362: dmaengine: hisilicon: Add multi-thread support for a DMA channel

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50362

Introduced by commit e9f08b6 ("dmaengine: hisilicon: Add Kunpeng DMA
engine support") in v5.6-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cbb95883c990d0002a77e13d3278913ab26ad79]
stable/5.10: [af12e209a9d559394d35875ba0e6c80407605888]
stable/5.15: [7cb9b20941e1fb20d22d0a2f460a3d4fa417274c]
stable/6.1: [2cbb95883c990d0002a77e13d3278913ab26ad79]

CVE-2022-50363: skmsg: pass gfp argument to alloc_sk_msg()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50363

Introduced by commit 4331291 ("skmsg: Get rid of unncessary memset()")
in v6.0-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d1f274b95c6e4ba6a813b3b8e7a1a38d54a0a08]
stable/6.1: [2d1f274b95c6e4ba6a813b3b8e7a1a38d54a0a08]

CVE-2022-50364: i2c: mux: reg: check return value after calling
platform_get_resource()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50364

Introduced by commit b3fdd32 ("i2c: mux: Add register-based mux
i2c-mux-reg") in v4.3-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d47b79d2bd39cc6369eccf94a06568d84c906ae]
stable/5.10: [61df25c41b8e0d2c988ccf17139f70075a2e1ba4]
stable/5.15: [8212800943997fab61874550278d653cb378c60c]
stable/6.1: [f7a440c89b6d460154efeb058272760e41bdfea8]

CVE-2022-50365: skbuff: Account for tail adjustment during pull operations

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50365

Introduced by commit 3dcbdb1 ("net: gso: Fix skb_segment splat when
splitting gso_size mangled skb having linear-headed frag_list") in
v5.3.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [2d59f0ca153e9573ec4f140988c0ccca0eb4181b]
cip/4.4-st: [d51739208ff544e141df71ef1ac81d2d19c81ab5]
mainline: [2d7afdcbc9d32423f177ee12b7c93783aea338fb]
stable/5.10: [821be5a5ab09a40ba09cb5ba354f18cf7996fea0]
stable/5.15: [8fb773eed4909ef5dc1bbeb3629a337d3336df7e]
stable/5.4: [668dc454bcbd1da73605201ff43f988c70848215]
stable/6.1: [331615d837f4979eb91a336a223a5c7f7886ecd5]

CVE-2022-50366: powercap: intel_rapl: fix UBSAN shift-out-of-bounds issue

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50366

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [4ebba43384722adbd325baec3a12c572d94488eb]
cip/4.4-st: [ae1c382fca8c35d0d48ea152c28f7e817de8bf9c]
mainline: [2d93540014387d1c73b9ccc4d7895320df66d01b]
stable/5.10: [708b9abe1b4a2f050a483db4b7edfc446b13df1f]
stable/5.15: [139bbbd01114433b80fe59f5e1330615aadf9752]
stable/5.4: [49a6ffdaed60f0eb52c198fafebc05994e16e305]
stable/6.1: [2d93540014387d1c73b9ccc4d7895320df66d01b]

CVE-2022-50367: fs: fix UAF/GPF bug in nilfs_mdt_destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50367

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [ec2aab115eb38ac4992ea2fcc2a02fbe7af5cf48]
cip/4.4-st: [802ba69f686ed47a8e591f5be8f8aa29556b732c]
mainline: [2e488f13755ffbb60f307e991b27024716a33b29]
stable/5.10: [1e555c3ed1fce4b278aaebe18a64a934cece57d8]
stable/5.15: [64b79e632869ad3ef6c098a4731d559381da1115]
stable/5.4: [70e4f70d54e0225f91814e8610477d65f33cefe4]
stable/6.1: [2e488f13755ffbb60f307e991b27024716a33b29]

CVE-2022-50368: drm/msm/dsi: fix memory corruption with too many bridges

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50368

Introduced by commit a689554 ("drm/msm: Initial add DSI connector
support") in v4.1-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4e5587cddb334f7a5bb1c49ea8bbfc966fafe1b8]
mainline: [2e786eb2f9cebb07e317226b60054df510b60c65]
stable/5.10: [21c4679af01f1027cb559330c2e7d410089b2b36]
stable/5.15: [9f035d1fb30648fe70ee01627eb131c56d699b35]
stable/5.4: [f649ed0e1b7a1545f8e27267d3c468b3cb222ece]
stable/6.1: [2e786eb2f9cebb07e317226b60054df510b60c65]

CVE-2022-50369: drm/vkms: Fix null-ptr-deref in vkms_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50369

Introduced by commit 6c234fe ("drm/vkms: Implement CRC debugfs API")
in v4.20-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fe2a8f40c21161ffe7653cc234e7934db5b7cc5]
stable/5.10: [0b8f390e2251191f1b179cc87f65d54c96565f0d]
stable/5.15: [1f9836f95271e7acf016667eee0aeae3386f9645]
stable/6.1: [596f1ba3987e601e31a5abf1f75ce1d2635aceac]

CVE-2022-50370: i2c: designware: Fix handling of real but unexpected
device interrupts

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50370

Introduced by commit c7b79a7 ("mfd: intel-lpss: Add Intel Alder Lake
PCH-S PCI IDs") in v5.12-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [301c8f5c32c8fb79c67539bc23972dc3ef48024c]
stable/5.15: [7fa5304c4b5b425d4a0b3acf10139a7f6108a85f]
stable/6.1: [301c8f5c32c8fb79c67539bc23972dc3ef48024c]

CVE-2022-50371: led: qcom-lpg: Fix sleeping in atomic

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50371

Introduced by commit 24e2d05 ("leds: Add driver for Qualcomm LPG") in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3031993b3474794ecb71b6f969a3e60e4bda9d8a]
stable/6.1: [380304391fa7fb084745f26b4b9a59f4666520c1]

CVE-2022-50372: cifs: Fix memory leak when build ntlmssp negotiate blob failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50372

Introduced by commit 49bd49f ("cifs: send workstation name during
ntlmssp session setup") in v5.16-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30b2d7f8f13664655480d6af45f60270b3eb6736]
stable/6.1: [30b2d7f8f13664655480d6af45f60270b3eb6736]

CVE-2022-50373: fs: dlm: fix race in lowcomms

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50373

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [30ea3257e8766027c4d8d609dcbd256ff9a76073]
stable/5.15: [27d3e646dd83bafd7094890462eebfce3ac31e4a]
stable/6.1: [30ea3257e8766027c4d8d609dcbd256ff9a76073]

CVE-2022-50374: Bluetooth: hci_{ldisc,serdev}: check percpu_init_rwsem() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50374

Introduced by commit 67d2f87 ("Bluetooth: hci_ldisc: Allow sleeping
while proto locks are held.") in v4.15-rc1.
Introduced by commit d73e172 ("Bluetooth: hci_serdev: Init hci_uart
proto_lock to avoid oops") in v4.16-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3124d320c22f3f4388d9ac5c8f37eaad0cefd6b1]
stable/5.10: [d7cc0d51ffcbfd1caaa809fcf9cff05c46d0fb4d]
stable/5.15: [b8917dce2134739b39bc0a5648b18427f2cad569]
stable/6.1: [3124d320c22f3f4388d9ac5c8f37eaad0cefd6b1]

CVE-2023-53335: RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53335

Introduced by commit 944661d ("RDMA/iw_cxgb4: atomically lookup ep and
get a reference") in v4.7-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [283861a4c52c1ea4df3dd1b6fc75a50796ce3524]
stable/5.15: [9dca64042d855a24b0bd81ce242e5dc7e939f6eb]
stable/6.1: [2cfc00e974d75a3aa8155f2660f57d342e1f67ca]

CVE-2023-53336: media: ipu-bridge: Fix null pointer deref on SSDB/PLD
parsing warnings

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53336

Introduced by commit 485aa3d ("media: ipu3-cio2: Parse sensor
orientation and rotation") in v5.16-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [284be5693163343e1cf17c03917eecd1d6681bcf]
stable/6.6: [284be5693163343e1cf17c03917eecd1d6681bcf]

CVE-2023-53337: nilfs2: do not write dirty data after degenerating to read-only

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53337

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [e9c5412c5972124776c1b873533eb39e287a4dfa]
cip/4.4-st: [a6f09c9cba48940b502961a361b9d887e9972273]
mainline: [28a65b49eb53e172d23567005465019658bfdb4d]
stable/5.10: [7c3e662048053802f6b0db3a78e97f4e1f7edc4f]
stable/5.15: [13f73ef77baa4764dc1ca4fcbae9cade05b83866]
stable/5.4: [4569a292a84e340e97d178898ad1cfe1a3080a61]
stable/6.1: [a73201c607d8e506358d60aafddda4246bdd9350]

CVE-2023-53338: lwt: Fix return values of BPF xmit ops

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53338

Introduced by commit 3a0af8f ("bpf: BPF for lightweight tunnel
infrastructure") in v4.10-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29b22badb7a84b783e3a4fffca16f7768fb31205]
stable/5.10: [a97f221651fcdc891166e9bc270e3d9bfa5a0080]
stable/5.15: [e3f647e4b642f9f6d32795a16f92c116c138d2af]
stable/5.4: [67f8f2bae8e7ac72e09def2b667e44704c4d1ee1]
stable/6.1: [065d5f17096ec9161180e2c890afdff4dc6125f2]
stable/6.6: [29b22badb7a84b783e3a4fffca16f7768fb31205]

CVE-2023-53339: btrfs: fix BUG_ON condition in btrfs_cancel_balance

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53339

Introduced commit is not determined.Fixed in v6.5-rc7.


Fixed status
cip/4.19-st: [7c93b89cd46636b5e74c12fa21dd86167bc6ea8d]
mainline: [29eefa6d0d07e185f7bfe9576f91e6dba98189c2]
stable/5.10: [bd7bef82ce0e929ef4cf63a34990545aaca28077]
stable/5.15: [b966e9e1e250dfdb41a7f41775faea4a37af923c]
stable/5.4: [a0a462a0f20926918d6009f0b4b25673e883fc98]
stable/6.1: [ceb9ba8e30833a4823e2dc73f80ebcdf2498d01a]

CVE-2023-53340: net/mlx5: Collect command failures data only for known commands

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53340

Introduced by commit 34f46ae ("net/mlx5: Add command failures data to
debugfs") in v5.18-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a0a935fb64ee8af253b9c6133bb6702fb152ac2]
stable/6.1: [411e4d6caa7f7169192b8dacc8421ac4fd64a354]

CVE-2023-53341: of/fdt: run soc memory setup when
early_init_dt_scan_memory fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53341

Introduced by commit 1f01228 ("of/fdt: Rework
early_init_dt_scan_memory() to call directly") in v5.17-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a12187d5853d9fd5102278cecef7dac7c8ce7ea]
stable/6.1: [c4849f18185fd4e93b04cd45552f8d68c0240e21]

CVE-2023-53342: net: marvell: prestera: fix handling IPv4 routes with nhid

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53342

Introduced by commit 396b80c ("net: marvell: prestera: Add neighbour
cache accounting") in v6.1-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aa71b4b294ee2c3041d085404cea914be9b3225]
stable/6.1: [a3e5f3b7f25d7b90f3b76d98a946fec6e5f79216]

CVE-2023-53343: icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev
in icmp6_dev().

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53343

Introduced by commit 4832c30 ("net: ipv6: put host and anycast routes
on device with address") in v4.14-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8803c59fde4dd370a627dfbf7183682fa0cabf70]
mainline: [2aaa8a15de73874847d62eb595c6683bface80fd]
stable/5.10: [d30ddd7ff15df9d91a793ce3f06f0190ff7afacc]
stable/5.15: [3fabca5d9cae0140b6aad09a1c6b9aa57089fbb8]
stable/5.4: [61b4c4659746959056450b92a5d7e6bc1243b31b]
stable/6.1: [1462e9d9aa52d14665eaca6d89d22c4af44ede04]

CVE-2023-53344: can: bcm: bcm_tx_setup(): fix KMSAN uninit-value in vfs_write

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53344

Introduced by commit 6f3b911 ("can: bcm: add support for CAN FD
frames") in v4.8-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [618b15d09fed6126356101543451d49860db4388]
mainline: [2b4c99f7d9a57ecd644eda9b1fb0a1072414959f]
stable/5.10: [ab2a55907823f0bca56b6d03ea05e4071ba8535f]
stable/5.15: [bf70e0eab64c625da84d9fdf4e84466b79418920]
stable/5.4: [78bc7f0ab99458221224d3ab97199c0f8e6861f1]
stable/6.1: [c11dbc7705b3739974ac31a13f4ab81e61a5fb07]

CVE-2023-53345: rxrpc: Fix potential data race in rxrpc_wait_to_be_connected()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53345

Introduced by commit 9d35d88 ("rxrpc: Move client call connection to
the I/O thread") in v6.2-rc4.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b5fdc0f5caa505afe34d608e2eefadadf2ee67a]

CVE-2023-53346: kernel/fail_function: fix memory leak with using
debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53346

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected function was added by 4b1a29a7 ("error-injection: Support
fault injection framework") in 4.16-rc1.

Fixed status
mainline: [2bb3669f576559db273efe49e0e69f82450efbca]
stable/5.10: [dd9981a11d74ff2eb253bb5c459876f8bd3c6c36]
stable/5.15: [bb99db06b8b6ce9351633fc61bec9919d8f6f52b]
stable/5.4: [f6d3aee1c66358471275df9dddd480010f061b0e]
stable/6.1: [29d53c4c5a6f6d2b93aaac95b65cb4c907faf2ff]

CVE-2023-53347: net/mlx5: Handle pairing of E-switch via uplink un/load APIs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53347

Introduced by commit 04de7dd ("net/mlx5e: Infrastructure for
duplicated offloading of TC flows") in v5.0-rc1.
Introduced by commit 1418ddd ("net/mlx5e: Duplicate offloaded TC
eswitch rules under uplink LAG") in v5.0-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2be5bd42a5bba1a05daedc86cf0e248210009669]
stable/6.1: [b17294e7aa8c39dbb9c3e28e2d1983c88b94b387]

CVE-2023-53348: btrfs: fix deadlock when aborting transaction during
relocation with scrub

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53348

Introduced by commit 55e3a60 ("btrfs: Fix data checksum error cause by
replace with io-load.") in v4.3-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d82a40aa7d6fcae0250ec68b8566cdee7bfd44c]
stable/6.1: [6134a4bb6b1c411a244edee041ac89266c78d45c]

CVE-2023-53349: media: ov2740: Fix memleak in ov2740_init_controls()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53349

Introduced by commit 866edc8 ("media: i2c: Add ov2740 image sensor
driver") in v5.8-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d899592ed7829d0d5140853bac4d58742a6b8af]
stable/5.10: [a163ee11345d8322321c28bd61631de32455b987]
stable/5.15: [3969b2ebc66039306f505c7c630c5530800f83c0]
stable/6.1: [fc33380ae06f438b652f66b9370b543976ac8a03]

CVE-2023-53350: accel/qaic: Fix slicing memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53350

Introduced by commit ff13be8 ("accel/qaic: Add datapath") in v6.4-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d956177b7c96e62fac762a3b7da4318cde27a73]

CVE-2023-53351: drm/sched: Check scheduler work queue before calling
timeout handling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53351

Introduced by commit 11b3b9f ("drm/sched: Check scheduler ready before
calling timeout handling") in v6.3.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2da5bffe9eaa5819a868e8eaaa11b3fd0f16a691]

CVE-2023-53352: drm/ttm: check null pointer before accessing when swapping

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53352

Introduced by commit a2848d0 ("drm/ttm: never consider pinned BOs for
eviction&swap") in v6.5-rc2.
Fixed in v6.5-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [2dedcf414bb01b8d966eb445db1d181d92304fb2]
stable/5.10: [d39971d902d067b4dc366981b75b17c8c57ed5d1]
stable/5.15: [8089eb93d6787dbf348863e935698b4610d90321]
stable/6.1: [1fdd16d89c01336d9a942b5f03673c17d401da87]

CVE-2023-53353: accel/habanalabs: postpone mem_mgr IDR destruction to
hpriv_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53353

Introduced commit is not determined.Fixed in v6.4-rc1.
The habanalabs driver was added by c4d6634 ("habanalabs: add skeleton driver")
  in 5.1-rc1.

Fixed status
mainline: [2e8e9a895c4589f124a37fc84d123b5114406e94]

CVE-2023-53354: skbuff: skb_segment, Call zero copy functions before
using skbuff frags

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53354

Introduced by commit bf5c25d ("skbuff: in skb_segment, call zerocopy
functions once per nskb") in v4.16-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fcab3f661dbfd88e27ddbbe65368f3fa2d823175]
mainline: [2ea35288c83b3d501a88bc17f2df8f176b5cc96f]
stable/5.10: [8836c266201c29a5acb4f582227686f47b65ad61]
stable/5.15: [d5790386595d06ea9decfd9ba5f1ea48cf09aa02]
stable/5.4: [d44403ec0676317b7f7edf2a035bb219fee3304e]
stable/6.1: [04c3eee4e13f60bf6f9a366ad39f88a01a57166e]
stable/6.6: [2ea35288c83b3d501a88bc17f2df8f176b5cc96f]

CVE-2023-53355: staging: pi433: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53355

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 4ef027d ("staging: pi433: add debugfs
interface") in 5.18-rc1.

Fixed status
mainline: [2f36e789e540df6a9fbf471b3a2ba62a8b361586]
stable/6.1: [04f3cda40e9f6653ae15ed3fcf26ef2860f4df66]

CVE-2023-53356: usb: gadget: u_serial: Add null pointer check in gserial_suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53356

Introduced by commit aba3a8d ("usb: gadget: u_serial: add suspend
resume callbacks") in v5.8-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f6ecb89fe8feb2b60a53325b0eeb9866d88909a]
stable/5.10: [2788a3553f7497075653210b42e2aeb6ba95e28e]
stable/5.15: [a8ea7ed644cbf6314b5b0136b5398754b549fb8f]
stable/6.1: [e60a827ac074ce6bd58305fe5a86afab5fce6a04]

CVE-2023-53357: md/raid10: check slab-out-of-bounds in md_bitmap_get_counter

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53357

Introduced by commit ef42567 ("md/bitmap: optimise scanning of empty
bitmaps.") in v2.6.36-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [374fb914304d9b500721007f3837ea8f1f9a2418]
mainline: [301867b1c16805aebbc306aafa6ecdc68b73c7e5]
stable/5.10: [39fa14e824acfd470db4f42c354297456bd82b53]
stable/5.15: [a134dd582c0d5b6068efa308bd485cf1d00b3f65]
stable/5.4: [b0b971fe7d61411ede63c3291764dbde1577ef2c]
stable/6.1: [be1a3ec63a840cc9e59a033acf154f56255699a1]

CVE-2023-53358: ksmbd: fix racy issue under cocurrent smb2 tree disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53358

Introduced commit is not determined.Fixed in v6.4-rc1.
The ksmbd was introduced in 5.15.

Fixed status
mainline: [30210947a343b6b3ca13adc9bfc88e1543e16dd5]
stable/5.15: [b36295c17fb97424406f0c3ab321b1ccaabb9be8]
stable/6.1: [bd80d35725a0cf4df9307bfe2f1a3b2cb983d8e6]

CVE-2023-53359: USB: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53359

Introduced commit is not determined.Fixed in v6.3-rc1.
Vulnerable code was added by 9c174b5 ("USB: core: no need to save
usb_devices_root") in 5.13-rc1.

Fixed status
mainline: [30374434edab20e25776f8ecb4bc9d1e54309487]
stable/5.15: [6683327b51a601daba32900072349dfa1d4e8fea]
stable/6.1: [c68ece7baf2aa9783b8244482c03010d477d4a93]

CVE-2023-53360: NFSv4.2: Rework scratch handling for READ_PLUS (again)

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53360

Introduced by commit fbd2a05 (NFSv4.2: Rework scratch handling for
READ_PLUS) in v6.4-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [303a78052091c81e9003915c521fdca1c7e117af]
stable/6.1: [adac9f0ddd2b291c7ce41f549fdb27a13616cff5]
stable/6.6: [303a78052091c81e9003915c521fdca1c7e117af]

CVE-2023-53361: LoongArch: mm: Add p?d_leaf() definitions

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53361

Introduced by commit 09cfefb ("LoongArch: Add memory management") in v5.19-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [303be4b33562a5b689261ced1616bf16ad49efa7]
stable/6.1: [cc9bf2d62f196ec600f9e6ea3a6ced11f54a2df9]
stable/6.6: [303be4b33562a5b689261ced1616bf16ad49efa7]

CVE-2023-53362: bus: fsl-mc: don't assume child devices are all fsl-mc devices

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53362

Introduced by commit 3c28a76 ("vfio: Add struct device to
vfio_device") in v6.1-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [303c9c63abb9390e906052863f82bb4e9824e5c0]
stable/6.1: [5bd9dc3e767edf582be483be8d6bbc7433bd4cf8]

CVE-2023-53363: PCI: Fix use-after-free in pci_bus_release_domain_nr()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53363

Introduced by commit c14f7cc ("PCI: Assign PCI domain IDs by
ida_alloc()") in v6.2-rc1.
Fixed in v6.3-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [30ba2d09edb5ea857a1473ae3d820911347ada62]
stable/5.10: [52b0343c7d628f37b38e3279ba585526b850ad3b]
stable/5.15: [ad367516b1c09317111255ecfbf5e42c33e31918]
stable/6.1: [fbf45385e3419b8698b5e0a434847072375cfec2]

CVE-2023-53364: regulator: da9063: better fix null deref with partial DT

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53364

Introduced by commit 98e2dd5 ("regulator: da9063: fix null pointer
deref with partial DT config") in v6.5-rc3.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30c694fd4a99fbbc4115d180156ca01b60953371]

CVE-2023-53365: ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53365

Introduced by commit 14fb64e ("[IPV6] MROUTE: Support PIM-SM (SSM).")
in v2.6.26-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8382e7ed2d63e6c2daf6881fa091526dc6c879cd]
cip/4.4-st: [d5bb03e374ade9e332267de07b90364530daf284]
mainline: [30e0191b16e8a58e4620fa3e2839ddc7b9d4281c]
stable/5.10: [1683124129a4263dd5bce2475bab110e95fa0346]
stable/5.15: [1bb54a21f4d9b88442f8c3307c780e2db64417e4]
stable/5.4: [0438e60a00d4e335b3c36397dbf26c74b5d13ef0]
stable/6.1: [691a09eecad97e745b9aa0e3918db46d020bdacb]

CVE-2023-53366: block: be a bit more careful in checking for NULL bdev
while polling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53366

Introduced by commit be4d234 ("bio: add allocation cache abstraction")
in v5.15-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [310726c33ad76cebdee312dbfafc12c1b44bf977]
stable/6.1: [1af0bdca03f367874da45d6cbe05fa05b90b1439]

CVE-2023-53367: accel/habanalabs: fix mem leak in capture user mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53367

Introduced commit is not determined.Fixed in v6.5-rc1.
The habanalabs driver was added by c4d6634 ("habanalabs: add skeleton driver")
  in 5.1-rc1.

Fixed status
mainline: [314a7ffd7c196b27eedd50cb7553029e17789b55]

CVE-2023-53368: tracing: Fix race issue between cpu buffer write and swap

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53368

Introduced by commit f1affca ("tracing: Add snapshot in the per_cpu
trace directories") in v3.10-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3163f635b20e9e1fb4659e74f47918c9dddfe64e]
stable/5.10: [c5d30d6aa83d99fba8dfdd9cf6c4e4e7a63244db]
stable/5.15: [6182318ac04648b46db9d441fd7d696337fcdd0b]
stable/5.4: [90e037cabc2c2dfc39b3dd9c5b22ea91f995539a]
stable/6.1: [74c85396bd73eca80b96510b4edf93b9a3aff75f]
stable/6.6: [3163f635b20e9e1fb4659e74f47918c9dddfe64e]


* Updated CVEs

CVE-2024-26954: ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

stable/6.6 was fixed.

Fixed status
stable/6.6: [9e4937cbc150f9d5a9b5576e1922ef0b5ed2eb72]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

