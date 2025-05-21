Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C86BC54E65
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 22:16:25 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web11.11065.1747865773997946329
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 May 2025 15:16:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=NHF0/z4G;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70dd29b0d34so29124527b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 21 May 2025 15:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1747865773; x=1748470573; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JDByxrBAI8ekX/7m0BpLbJL9GT4oiRuCTbr8Zc3jfz8=;
        b=NHF0/z4G8rxrynROP/BN5zw1oPJXdgYp8NfB89xjn8rRHS1f5whiirqhfCtWH7WRn8
         +N+ARPvGTG1NLmzW6egpO2ZZxk8dcsjFSS2gTEuqOaF0ueTJY+J69NEw9zvnEpBGqwkp
         Ntwdv2njho3ywMvqZnOsyzWNGMrlAWw7v7Xd1BGQFq0T+CuBsdtFOFiRfz0cSh/jx+pI
         EXx/loBgvlDlHzRNUrLnWhqDNvxXCj1sVruzQ2Sd0N/t5S+MWVB0rgO0iIHlGxLk6B5p
         IA4pW/ogkSJ48HwJyqRtQs2T28djfKwk4ZwnvtPmidAkvS63/2BTz1E0Fa9gvMo5zUIX
         k8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747865773; x=1748470573;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDByxrBAI8ekX/7m0BpLbJL9GT4oiRuCTbr8Zc3jfz8=;
        b=majH9Wsm9YooYwSoJJ1XkB8KtehzqKQTKjcc/a58qEeTLz0pApWi95zC+VK6+Vmewa
         1z3MDIfjAupenPyrDOE8laUn6dUo+VkzX8Rfwbbfs8XJsVKjciHwVdSfZOOa4r/eycVM
         kb3dehkhuiKXEOjjbOyXiVIoLvKMtjo9RLOlTpj1ftLtePgECJY4sYCnrBOK6ZiRWBq7
         Qcr9MQ/baJ9eWP60k/A7pR8C0ID4YZckkGTpkLkbYjOjqE7+d/5xqOjKZrd6rqs4f95O
         Scs6c+0kuNA/VIgC74TfQ/eCgD2XuK2dgz0HicGfg0BzXmVHt2TEyKyiRpQl3BzcjmNS
         aprQ==
X-Gm-Message-State: AOJu0YxXgjnLBaDqaQJI5W0VeHJNhH/H+Ys8avqlFrT2+z93In38IDG9
	7FAuLwjBDZC5Mdz56GlCmREYynXGivZukk4lOCO/q5e6flkHLph7Dj6E6YIJ3JvqeO1sn/vMvhR
	kUO4Swtql74Kg4Xn2dfLWu9VK7Mub0CvZ/y92jhrlKbVRywI+nkYQHxw=
X-Gm-Gg: ASbGncuSUKakBdP5ZijU9ZAFfYlE3JCBF+czVSr/0833J6Sw8tvHGjWtm8iFVRssiG8
	velpoN4y4n2PtQ17OCdipamxc3ukHq99Hvj6cuIN9Q2FFOId+KbWjF3ooY81HPNaV16EntaSABP
	C+j2cadLbv9JxH48GFEtxUi0/lHK5Ik8q12A==
X-Google-Smtp-Source: AGHT+IFrTMuXyYpg3nBZD+/UjGxJfIvx7uM7jQY0usT9pYbaaMoyXPRstQVUBil/rRJ4qDR5UhfWimyX5hxHBS+2ohs=
X-Received: by 2002:a05:690c:4886:b0:70d:f9b0:b6b5 with SMTP id
 00721157ae682-70df9b0bac2mr44546627b3.13.1747865771926; Wed, 21 May 2025
 15:16:11 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 22 May 2025 07:15:36 +0900
X-Gm-Features: AX0GCFvQAHHlxwO6u_Yzji44a5QGsRL6q2hcj9O-u5yXTIeRjinQdjD9GTh7bJI
Message-ID: <CAODzB9pF6DgNQwxA3U4BmDvVxvOB26WmwZ+V7QrNkDCwSf=ywg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 May 2025 22:16:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18935

Hi!

It's this week's CVE report.

This week reported 100 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2025-37890: net_sched: hfsc: Fix a UAF vulnerability in class with
netem as child qdisc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37890

Introduced by commit 37d9cf1 ("sched: Fix detection of empty queues in
child qdiscs") in v5.0-rc3.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [141d34391abbb315d68556b7c67ad97885407547]
stable/5.15: [e3e949a39a91d1f829a4890e7dfe9417ac72e4d0]
stable/6.1: [8df7d37d626430035b413b97cee18396b3450bef]
stable/6.6: [6082a87af4c52f58150d40dec1716011d871ac21]

CVE-2025-37891: ALSA: ump: Fix buffer overflow at UMP SysEx message conversion

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37891

Introduced by commit 0b5288f ("ALSA: ump: Add legacy raw MIDI
support") in v6.5-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56f1f30e6795b890463d9b20b11e576adf5a2f77]
stable/6.6: [ce4f77bef276e7d2eb7ab03a5d08bcbaa40710ec]

CVE-2025-37892: mtd: inftlcore: Add error check for inftl_read_oob()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37892

Introduced by commit 8593fbc ("[MTD] Rework the out of band handling
completely") in v2.6.20.16.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d027951dc85cb2e15924c980dc22a6754d100c7c]
stable/5.10: [0300e751170cf80c05ca1a762a7b449e8ca6b693]
stable/5.15: [e7d6ceff95c55297f0ee8f9dbc4da5c558f30e9e]
stable/5.4: [b828d394308e8e00df0a6f57e7dabae609bb8b7b]
stable/6.1: [6af3b92b1c0b58ca281d0e1501bad2567f73c1a5]
stable/6.6: [7772621041ee78823ccc5f1fe38f6faa22af7023]

CVE-2025-37894: net: use sock_gen_put() when sk_state is TCP_TIME_WAIT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37894

Introduced by commit c9d1d23 ("net: add heuristic for enabling TCP
fraglist GRO") in v6.10-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f920436a44295ca791ebb6dae3f4190142eec703]

CVE-2025-37895: bnxt_en: Fix error handling path in bnxt_init_chip()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37895

Introduced by commit 4045296 ("bnxt_en: Fix DIM shutdown") in v6.13-rc7.
Fixed in v6.15-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [9ab7a709c926c16b4433cf02d04fcbcf35aaab2b]

CVE-2025-37896: spi: spi-mem: Add fix to avoid divide error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37896

Introduced by commit 226d6cb ("spi: spi-mem: Estimate the time taken
by operations") in v6.14-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e4d3d8a5e51e07bd0d6cdd81b5e4af79f796927]

CVE-2025-37897: wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37897

Introduced by commit 68d57a0 ("wireless: add plfxlc driver for
pureLiFi X, XL, XC devices") in v5.19-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fb15ae3b0a9221be01715dac0335647c79f3362]
stable/6.1: [93d646911be1e5be20d4f5d6c48359464cef0097]
stable/6.6: [36a9a2647810e57e704dde59abdf831380ca9102]

CVE-2025-37898: powerpc64/ftrace: fix module loading without patchable
function entries

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37898

Introduced by commit eec3796 ("powerpc64/ftrace: Move ftrace sequence
out of line") in v6.13-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [534f5a8ba27863141e29766467a3e1f61bcb47ac]

CVE-2025-37899: ksmbd: fix use-after-free in session logoff

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37899

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc5.


Fixed status
mainline: [2fc9feff45d92a92cd5f96487655d5be23fb7e2b]

CVE-2025-37900: iommu: Fix two issues in iommu_copy_struct_from_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37900

Introduced by commit e9d36c0 ("iommu: Add iommu_copy_struct_from_user
helper") in v6.7-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30a3f2f3e4bd6335b727c83c08a982d969752bc1]

CVE-2025-37901: irqchip/qcom-mpm: Prevent crash when trying to handle
non-wake GPIOs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37901

Introduced by commit a6199bb ("irqchip: Add Qualcomm MPM controller
driver") in v5.18-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38a05c0b87833f5b188ae43b428b1f792df2b384]
stable/6.1: [45aced97f01d5ab14c8a2a60f6748f18c501c3f5]
stable/6.6: [dfbaecf7e38f5e9bfa5e47a1e525ffbb58bab8cf]

CVE-2025-37902: dm: fix copying after src array boundaries

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37902

Introduced by commit 5a2a6c4 ("dm: always update the array size in
realloc_argv on success") in v6.15-rc5.
Fixed in v5.15.182.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.14 stable/6.6

Fixed status
mainline: [aaa763ab8cecae6308c5ec7f309e1bc3a7ebd29f]
stable/6.1: [4c4f168b46229d527bda801ef15ad793b069f0ae]
stable/6.6: [ed3248a403740a623c73afd95f88cc37e0cd3ad2]

CVE-2025-37903: drm/amd/display: Fix slab-use-after-free in hdcp

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37903

Introduced by commit da3fd7a ("drm/amd/display: Update CP property
based on HW query") in v5.5-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be593d9d91c5a3a363d456b9aceb71029aeb3f1d]
stable/6.1: [e25139c4aa5621f2db8e86688c33546cdd885e42]
stable/6.6: [bbc66abcd297be67e3d835276e21e6fdc65205a6]

CVE-2025-37904: btrfs: fix the inode leak in btrfs_iget()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37904

Introduced by commit 7c855e1 ("btrfs: remove conditional path
allocation in btrfs_read_locked_inode()") in v6.13-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48c1d1bb525b1c44b8bdc8e7ec5629cb6c2b9fc4]

CVE-2025-37905: firmware: arm_scmi: Balance device refcount when
destroying devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37905

Introduced by commit d4f9ddd ("firmware: arm_scmi: Add dynamic scmi
devices creation") in v5.13-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ca67840c0ddf3f39407339624cef824a4f27599]
stable/5.15: [91ff1e9652fb9beb0174267d6bb38243dff211bb]
stable/6.1: [ff4273d47da81b95ed9396110bcbd1b7b7470fe8]
stable/6.6: [2fbf6c9695ad9f05e7e5c166bf43fac7cb3276b3]

CVE-2025-37906: ublk: fix race between io_uring_cmd_complete_in_task
and ublk_cancel_cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37906

Introduced by commit 216c8f5 ("ublk: replace monitor with cancelable
uring_cmd") in v6.7-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f40139fde5278d81af3227444fd6e76a76b9506d]

CVE-2025-37907: accel/ivpu: Fix locking order in ivpu_job_submit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37907

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [ab680dc6c78aa035e944ecc8c48a1caab9f39924]

CVE-2025-37908: mm, slab: clean up slab->obj_exts always

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37908

Introduced by commit 21c690a ("mm: introduce slabobj_ext to support
slab object extensions") in v6.10-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be8250786ca94952a19ce87f98ad9906448bc9ef]

CVE-2025-37909: net: lan743x: Fix memleak issue when GSO enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37909

Introduced by commit 23f0703 ("lan743x: Add main source files for new
lan743x driver") in v4.17-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d52e2e38b85c8b7bc00dca55c2499f46f8c8198]
stable/5.15: [df993daa4c968b4b23078eacc248f6502ede8664]
stable/6.1: [a0e0efbabbbe6a1859bc31bf65237ce91e124b9b]
stable/6.6: [dae1ce27ceaea7e1522025b15252e3cc52802622]

CVE-2025-37910: ptp: ocp: Fix NULL dereference in Adva board SMA sysfs
operations

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37910

Introduced by commit ef61f55 ("ptp: ocp: add Adva timecard support")
in v6.9-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e98386d79a23c57cf179fe4138322e277aa3aa74]

CVE-2025-37911: bnxt_en: Fix out-of-bound memcpy() during ethtool -w

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37911

Introduced by commit c74751f ("bnxt_en: Return error if FW returns
more data than dump length") in v5.5-rc3.
Fixed in v6.15-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
mainline: [6b87bd94f34370bbf1dfa59352bed8efab5bf419]
stable/5.15: [69b10dd23ab826d0c7f2d9ab311842251978d0c1]
stable/6.1: [43292b83424158fa6ec458799f3cb9c54d18c484]
stable/6.6: [4d69864915a3a052538e4ba76cd6fd77cfc64ebe]

CVE-2025-37912: ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37912

Introduced by commit 6ebbe97 ("ice: Add a per-VF limit on number of
FDIR filters") in v6.11-rc1.
Fixed in v6.15-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [425c5f266b2edeee0ce16fedd8466410cdcfcfe3]
stable/5.15: [a32dcc3b8293600ddc4024731b4d027d4de061a4]
stable/6.1: [0561f2e374c3732b90e50f0a244791a4308ec67e]
stable/6.6: [eae60cfe25d022d7f0321dba4cc23ad8e87ade48]

CVE-2025-37913: net_sched: qfq: Fix double list add in class with
netem as child qdisc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37913

Introduced by commit 37d9cf1 ("sched: Fix detection of empty queues in
child qdiscs") in v5.0-rc3.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f139f37dcdf34b67f5bf92bc8e0f7f6b3ac63aa4]
stable/5.15: [0bf32d6fb1fcbf841bb9945570e0e2a70072c00f]
stable/6.1: [0aa23e0856b7cedb3c88d8e3d281c212c7e4fbeb]
stable/6.6: [a43783119e01849fbf2fe8855634e8989b240cb4]

CVE-2025-37914: net_sched: ets: Fix double list add in class with
netem as child qdisc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37914

Introduced by commit 37d9cf1 ("sched: Fix detection of empty queues in
child qdiscs") in v5.0-rc3.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a6d0c00fa07972384b0c308c72db091d49988b6]
stable/5.15: [554acc5a2ea9703e08023eb9a003f9e5a830a502]
stable/6.1: [9efb6a0fa88e0910d079fdfeb4f7ce4d4ac6c990]
stable/6.6: [72c3da7e6ceb74e74ddbb5a305a35c9fdfcac6e3]

CVE-2025-37915: net_sched: drr: Fix double list add in class with
netem as child qdisc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37915

Introduced by commit 37d9cf1 ("sched: Fix detection of empty queues in
child qdiscs") in v5.0-rc3.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f99a3fbf023e20b626be4b0f042463d598050c9a]
stable/5.15: [2968632880f1792007eedd12eeedf7f6e2b7e9f3]
stable/6.1: [4f0ecf50cdf76da95828578a92f130b653ac2fcf]
stable/6.6: [db205b92dfe0501e5b92fb7cf00971d0e44ba3eb]

CVE-2025-37916: pds_core: remove write-after-free of client_id

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37916

Introduced by commit 1065903 ("pds_core: add the aux client API") in v6.4-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dfd76010f8e821b66116dec3c7d90dd2403d1396]
stable/6.6: [9b467c5bcdb45a41d2a49fbb9ffca73d1380e99b]

CVE-2025-37917: net: ethernet: mtk-star-emac: fix spinlock recursion
issues on rx/tx poll

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37917

Introduced by commit 0a8bd81 ("net: ethernet: mtk-star-emac: separate
tx/rx handling with two NAPIs") in v6.0-rc1.
Fixed in v6.14.6.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d886f8d85494d12b2752fd7c6c32162d982d5dd5]
stable/6.1: [bedd287fdd3142dffad7ae2ac6ef15f4a2ad0629]
stable/6.6: [94107259f972d2fd896dbbcaa176b3b2451ff9e5]

CVE-2025-37918: Bluetooth: btusb: avoid NULL pointer dereference in
skb_dequeue()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37918

Introduced by commit 20981ce ("Bluetooth: btusb: Add WCN6855
devcoredump support") in v6.4-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0317b033abcd1d8dd2798f0e2de5e84543d0bd22]
stable/6.6: [2e8d44ebaa7babdd5c5ab50ca275826e241920d6]

CVE-2025-37919: ASoC: amd: acp: Fix NULL pointer deref in acp_i2s_set_tdm_slot

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37919

Introduced by commit cd60dec ("ASoC: amd: acp: Refactor TDM slots
selction based on acp revision id") in v6.12-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d9b64156d849e358cb49b6b899fb0b7d262bda8]

CVE-2025-37920: xsk: Fix race condition in AF_XDP generic RX path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37920

Introduced by commit bf0bdd1 ("xdp: fix race on generic receive path")
in v5.3-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1356ac7749cafc4e27aa62c0c4604b5dca4983e]

CVE-2025-37921: vxlan: vnifilter: Fix unlocked deletion of default FDB entry

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37921

Introduced by commit f9c4bb0 ("vxlan: vni filtering support on collect
metadata device") in v5.18-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [087a9eb9e5978e3ba362e1163691e41097e8ca20]
stable/6.1: [2d4a121296aa3940d2df9906f955c2b6b4e38bc3]
stable/6.6: [3576e9a80b6c4381b01ce0cbaa07f5e92d4492ed]

CVE-2025-37922: book3s64/radix : Align section vmemmap start address
to PAGE_SIZE

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37922

Introduced by commit 368a059 ("powerpc/book3s64/vmemmap: switch radix
to use a different vmemmap handling function") in v6.6-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cf7e13fecbab0894f6986fc6986ab2eba8de52e]
stable/6.6: [9a8d4d7072d4df108479b1adc4b0840e96f6f61d]

CVE-2025-37923: tracing: Fix oob write in trace_seq_to_buffer()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37923

Introduced by commit 3c56819 ("tracing: splice support for
tracing_pipe") in v2.6.30-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5178c41bb43444a6008150fe6094497135d07cb]
stable/5.15: [1a3f9482b50b74fa9421bff8ceecfefd0dc06f8f]
stable/6.1: [441021e5b3c7d9bd1b963590652c415929f3b157]
stable/6.6: [056ebbddb8faf4ddf83d005454dd78fc25c2d897]

CVE-2025-37924: ksmbd: fix use-after-free in kerberos authentication

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37924

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc5.


Fixed status
mainline: [e86e9134e1d1c90a960dd57f59ce574d27b9a124]
stable/6.1: [e34a33d5d7e87399af0a138bb32f6a3e95dd83d2]
stable/6.6: [b447463562238428503cfba1c913261047772f90]

CVE-2025-37926: ksmbd: fix use-after-free in ksmbd_session_rpc_open

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37926

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc5.


Fixed status
mainline: [a1f46c99d9ea411f9bf30025b912d881d36fc709]

CVE-2025-37927: iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37927

Introduced by commit ca3bf5d ("iommu/amd: Introduces ivrs_acpihid
kernel parameter") in v4.7-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8dee308e4c01dea48fc104d37f92d5b58c50b96c]
stable/5.15: [466d9da267079a8d3b69fa72dfa3a732e1f6dbb5]
stable/6.1: [c3f37faa71f5d26dd2144b3f2b14525ec8f5e41f]
stable/6.6: [13d67528e1ae4486e9ab24b70122fab104c73c29]

CVE-2025-37928: dm-bufio: don't schedule in atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37928

Introduced by commit 7cd3267 ("dm bufio: remove
dm_bufio_cond_resched()") in v4.9-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3d8f0a7f5e8b193db509c7191fefeed3533fc44]
stable/6.1: [a99f5bf4f7197009859dbce14c12f8e2ce5a5a69]
stable/6.6: [c8c83052283bcf2fdd467a33d1d2bd5ba36e935a]

CVE-2025-37929: arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37929

Introduced by commit a595138 ("arm64: errata: Add newer ARM cores to
the spectre_bhb_loop_affected() lists") in v6.15-rc1.
Fixed in v6.15-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.14 stable/6.6

Fixed status
mainline: [fee4d171451c1ad9e8aaf65fc0ab7d143a33bd72]
stable/5.15: [6266b3509b2c6ebf2f9daf2239ff8eb60c5f5bd3]
stable/6.1: [446289b8b36b2ee98dabf6388acbddcc33ed41be]
stable/6.6: [3821cae9bd5a99a42d3d0be1b58e41f072cd4c4c]

CVE-2025-37930: drm/nouveau: Fix WARN_ON in nouveau_fence_context_kill()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37930

Introduced by commit ea13e5a ("drm/nouveau: signal pending fences when
channel has been killed") in v5.6-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbe5679f30d7690a9b6838a583b9690ea73fe0e9]
stable/5.15: [2ec0f5f6d4768f292c8406ed92fa699f184577e5]
stable/6.1: [47ca11836c35c5698088fd87f7fb4b0ffa217e17]
stable/6.6: [126f5c6e0cb84e5c6f7a3a856d799d85668fb38e]

CVE-2025-37931: btrfs: adjust subpage bit start based on sectorsize

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37931

Introduced by commit c4aec29 ("btrfs: introduce submit_eb_subpage() to
submit a subpage metadata page") in v5.13-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e08e49d986f82c30f42ad0ed43ebbede1e1e3739]

CVE-2025-37932: sch_htb: make htb_qlen_notify() idempotent

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37932

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc2.


Fixed status
mainline: [5ba8b837b522d7051ef81bacf3d95383ff8edce5]
stable/6.1: [73cf6af13153d62f9b76eff422eea79dbc70f15e]
stable/6.6: [bbbf5e0f87078b715e7a665d662a2c0e77f044ae]

CVE-2025-37933: octeon_ep: Fix host hang issue during device reboot

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37933

Introduced by commit 5cb96c2 ("octeon_ep: add heartbeat monitor") in v6.4-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34f42736b325287a7b2ce37e415838f539767bda]
stable/6.6: [7e1ca1bed3f66e00377f7d2147be390144924276]

CVE-2025-37934: ASoC: simple-card-utils: Fix pointer check in
graph_util_parse_link_direction

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37934

Introduced by commit 844de7e ("ASoC: audio-graph-card2: expand
dai_link property part") in v6.11-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cc393d2232ec770b5f79bf0673d67702a3536c3]

CVE-2025-37935: net: ethernet: mtk_eth_soc: fix SER panic with 4GB+ RAM

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37935

Introduced by commit 2d75891 ("net: ethernet: mtk_eth_soc: support
36-bit DMA addressing on MT7988") in v6.6-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e0490fc36cdac696f96e57b61d93b9ae32e0f4c]
stable/6.6: [cb625f783f70dc6614f03612b8e64ad99cb0a13c]

CVE-2025-37936: perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
with vCPU's value.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37936

Introduced by commit c59a1f1 ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR
emulation for extended PEBS") in v6.0-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58f6217e5d0132a9f14e401e62796916aa055c1b]
stable/6.1: [160153cf9e4aa875ad086cc094ce34aac8e13d63]
stable/6.6: [34b6fa11431aef71045ae5a00d90a7d630597eda]

CVE-2025-37937: objtool, media: dib8000: Prevent divide-by-zero in
dib8000_set_dds()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37937

Introduced by commit 173a64c ("[media] dib8000: enhancement") in v3.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f141e838a025effbf8b904813f797f606e0499cc]
cip/4.4-st: [13fa057ca7eed228c449daa5b0f97b88a0455bc7]
mainline: [e63d465f59011dede0a0f1d21718b59a64c3ff5c]
stable/5.10: [976a85782246a29ba0f6d411a7a4f524cb9ea987]
stable/5.15: [9b76b198cf209797abcb1314c18ddeb90fe0827b]
stable/5.4: [536f7f3595ef8187cfa9ea50d7d24fcf4e84e166]
stable/6.1: [b9249da6b0ed56269d4f21850df8e5b35dab50bd]
stable/6.6: [75b42dfe87657ede3da3f279bd6b1b16d69af954]

CVE-2025-37938: tracing: Verify event formats that have "%*p.."

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37938

Introduced by commit 5013f45 ("tracing: Add check of trace event print
fmts for dereferencing pointers") in v5.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea8d7647f9ddf1f81e2027ed305299797299aa03]
stable/6.1: [6854c87ac823181c810f8c07489ba543260c0023]
stable/6.6: [4d11fac941d83509be4e6a21038281d6d96da50c]

CVE-2025-37939: libbpf: Fix accessing BTF.ext core_relo header

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37939

Introduced by commit cf57916 ("libbpf: Support BTF.ext loading and
output in either endianness") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a7c2a84359612e54328aa52030eb202093da6e2]

CVE-2025-37940: ftrace: Add cond_resched() to ftrace_graph_set_hash()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37940

Introduced by commit b9b0c83 ("ftrace: Convert graph filter to use
hash tables") in v4.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42ea22e754ba4f2b86f8760ca27f6f71da2d982c]
stable/5.10: [618655d54c5f8af5d57b77491d08c0f0ff77d114]
stable/5.15: [dd38803c9088b848c6b56f4f6d7efc4497bfde61]
stable/5.4: [e5b4ae6f01d4a510d5725eca7254519a1093920d]
stable/6.1: [8dd7d7280357596ba63dfdb4c1725d9dd24bd42a]
stable/6.6: [5d336ac215e5c76e43ef4bca9ba699835e53e2fd]

CVE-2025-37941: ASoC: codecs: wcd937x: fix a potential memory leak in
wcd937x_soc_codec_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37941

Introduced by commit 313e978 ("ASoC: codecs: wcd937x: add audio
routing and Kconfig") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e330acf4efd63876d673c046cd073a1d4ed57a8]

CVE-2025-37942: HID: pidff: Make sure to fetch pool before checking
SIMULTANEOUS_MAX

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37942

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [1f650dcec32d22deb1d6db12300a2b98483099a9]

CVE-2025-37943: wifi: ath12k: Fix invalid data access in
ath12k_dp_rx_h_undecap_nwifi

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37943

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [9a0dddfb30f120db3851627935851d262e4e7acb]
stable/6.6: [7f1d986da5c6abb75ffe4d0d325fc9b341c41a1c]

CVE-2025-37944: wifi: ath12k: Fix invalid entry fetch in
ath12k_dp_mon_srng_process

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37944

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [63fdc4509bcf483e79548de6bc08bf3c8e504bb3]
stable/6.6: [2c512f2eadabb1e80816116894ffaf7d802a944e]

CVE-2025-37945: net: phy: allow MDIO bus PM ops to start/stop state
machine for phylink-controlled PHY

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37945

Introduced by commit 744d23c ("net: phy: Warn about incorrect
mdio_bus_phy_resume() state") in v6.0-rc1.
Fixed in v6.15-rc2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [fc75ea20ffb452652f0d4033f38fe88d7cfdae35]

CVE-2025-37946: s390/pci: Fix duplicate pci_dev_put() in
disable_slot() when PF has child VFs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37946

Introduced by commit bcb5d6c ("s390/pci: introduce lock to synchronize
state of zpci_dev's") in v6.9-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05a2538f2b48500cf4e8a0a0ce76623cc5bafcf1]

CVE-2025-37947: ksmbd: prevent out-of-bounds stream writes by validating *pos

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37947

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.


Fixed status
mainline: [0ca6df4f40cf4c32487944aaf48319cb6c25accc]
stable/6.1: [7f61da79df86fd140c7768e668ad846bfa7ec8e1]
stable/6.6: [04c8a38c60346bb5a7c49b276de7233f703ce9cb]

CVE-2025-37948: arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37948

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc7.


Fixed status
mainline: [0dfefc2ea2f29ced2416017d7e5b1253a54c2735]
stable/6.1: [8fe5c37b0e08a97cf0210bb75970e945aaaeebab]
stable/6.6: [42a20cf51011788f04cf2adbcd7681f02bdb6c27]

CVE-2025-37949: xenbus: Use kref to track req lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37949

Introduced by commit fd8aa90 ("xen: optimize xenbus driver for
multiple concurrent xenstore accesses") in v4.11-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f0304dfd9d217c2f8b04a9ef4b3258a66eedd27]
stable/5.15: [4d260a5558df4650eb87bc41b2c9ac2d6b2ba447]
stable/6.1: [8b02f85e84dc6f7c150cef40ddb69af5a25659e5]
stable/6.6: [cbfaf46b88a4c01b64c4186cdccd766c19ae644c]

CVE-2025-37950: ocfs2: fix panic in failed foilio allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37950

Introduced by commit 7e119cf ("ocfs2: convert w_pages to w_folios") in
v6.14-rc1.
Introduced by commit 9a5e086 ("ocfs2: use an array of folios instead
of an array of pages") in v6.14-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31d4cd4eb2f8d9b87ebfa6a5e443a59e3b3d7b8c]

CVE-2025-37951: drm/v3d: Add job to pending list if the reset was skipped

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37951

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.
affected file was added in 4.18-rc1.

Fixed status
mainline: [35e4079bf1a2570abffce6ababa631afcf8ea0e5]
stable/6.1: [5235b56b7e5449d990d21d78723b1a5e7bb5738e]
stable/6.6: [12125f7d9c15e6d8ac91d10373b2db2f17dcf767]

CVE-2025-37952: ksmbd: Fix UAF in __close_file_table_ids

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37952

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.


Fixed status
mainline: [36991c1ccde2d5a521577c448ffe07fcccfe104d]
stable/6.6: [fec1f9e9a650e8e7011330a085c77e7bf2a08ea9]

CVE-2025-37953: sch_htb: make htb_deactivate() idempotent

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37953

Introduced by commit 5ba8b83 ("sch_htb: make htb_qlen_notify()
idempotent") in v6.15-rc2.
Fixed in v6.15-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.1 stable/6.12 stable/6.14 stable/6.6

Fixed status
mainline: [3769478610135e82b262640252d90f6efb05be71]
stable/6.1: [c928dd4f6bf0c25c72b11824a1e9ac9bd37296a0]
stable/6.6: [31ff70ad39485698cf779f2078132d80b57f6c07]

CVE-2025-37954: smb: client: Avoid race in open_cached_dir with lease breaks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37954

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.


Fixed status
mainline: [3ca02e63edccb78ef3659bebc68579c7224a6ca2]
stable/6.6: [2ed98e89ebc2e1bc73534dc3c18cb7843a889ff9]

CVE-2025-37955: virtio-net: free xsk_buffs on error in virtnet_xsk_pool_enable()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37955

Introduced by commit e9f3962 ("virtio_net: xsk: rx: support fill with
xsk buffer") in v6.11-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4397684a292a71fbc1e815c3e283f7490ddce5ae]

CVE-2025-37956: ksmbd: prevent rename with empty string

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37956

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.


Fixed status
mainline: [53e3e5babc0963a92d856a5ec0ce92c59f54bc12]
stable/6.6: [6ee551672c8cf36108b0cfba92ec0c7c28ac3439]

CVE-2025-37957: KVM: SVM: Forcibly leave SMM mode on SHUTDOWN interception

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37957

Introduced by commit ed129ec ("KVM: x86: forcibly leave nested mode on
vCPU reset") in v6.1-rc7.
Fixed in v6.15-rc6.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [a2620f8932fa9fdabc3d78ed6efb004ca409019f]

CVE-2025-37958: mm/huge_memory: fix dereferencing invalid pmd migration entry

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37958

Introduced by commit 84c3fc4 ("mm: thp: check pmd migration entry in
common path") in v4.14-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7]

CVE-2025-37959: bpf: Scrub packet on bpf_redirect_peer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37959

Introduced by commit 9aa1206 ("bpf: Add redirect_peer helper") in v5.10-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4327229948879814229b46aa26a750718888503]
stable/6.1: [de1067cc8cf0e8c11ae20cbe5c467aef19d04ded]
stable/6.6: [355b0526336c0bf2bf7feaca033568ede524f763]

CVE-2025-37960: memblock: Accept allocated memory before use in
memblock_double_array()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37960

Introduced by commit dcdfdd4 ("mm: Add support for unaccepted memory")
in v6.5-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da8bf5daa5e55a6af2b285ecda460d6454712ff4]

CVE-2025-37961: ipvs: fix uninit-value for saddr in do_output_route4

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37961

Introduced by commit 4754957 ("ipvs: do not use random local source
address for tunnels") in v4.2-rc5.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e34090d7214e0516eb8722aee295cb2507317c07]
stable/6.1: [7d0032112a0380d0b8d7c9005f621928a9b9fc76]
stable/6.6: [adbc8cc1162951cb152ed7f147d5fbd35ce3e62f]

CVE-2025-37962: ksmbd: fix memory leak in parse_lease_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37962

Introduced by commit bab703e ("ksmbd: add bounds check for create
lease context") in v6.15-rc1.
Fixed in v6.15-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.14 stable/6.6

Fixed status
mainline: [eb4447bcce915b43b691123118893fca4f372a8f]
stable/6.1: [facf22c1a394c1e023dab5daf9a494f722771e1c]
stable/6.6: [af9e2d4732a548db8f6f5a90c2c20a789a3d7240]

CVE-2025-37963: arm64: bpf: Only mitigate cBPF programs loaded by
unprivileged users

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37963

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc7.


Fixed status
mainline: [f300769ead032513a68e4a02e806393402e626f8]
stable/6.1: [6e52d043f7dbf1839a24a3fab2b12b0d3839de7a]
stable/6.6: [80251f62028f1ab2e09be5ca3123f84e8b00389a]

CVE-2025-37964: x86/mm: Eliminate window where TLB flushes may be
inadvertently skipped

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37964

Introduced by commit 6db2526 ("x86/mm/tlb: Only trim the mm_cpumask
once a second") [2] in v6.14-rc1.
Fixed in v6.15-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [fea4e317f9e7e1f449ce90dedc27a2d2a95bee5a]
stable/5.15: [12f703811af043d32b1c8a30001b2fa04d5cd0ac]
stable/6.1: [02ad4ce144bd27f71f583f667fdf3b3ba0753477]
stable/6.6: [d41072906abec8bb8e01ed16afefbaa558908c89]

CVE-2025-37965: drm/amd/display: Fix invalid context error in dml helper

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37965

Introduced by commit 366e77c ("drm/amd/display: Protect FPU in
dml2_validate()/dml21_validate()") in v6.15-rc2.
Fixed in v6.15-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.14

Fixed status
mainline: [9984db63742099ee3f3cff35cf71306d10e64356]

CVE-2025-37966: riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37966

Introduced by commit 09d6775 ("riscv: Add support for userspace
pointer masking") in v6.13-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae08d55807c099357c047dba17624b09414635dd]

CVE-2025-37967: usb: typec: ucsi: displayport: Fix deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37967

Introduced by commit af8622f ("usb: typec: ucsi: Support for
DisplayPort alt mode") in v5.2-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [364618c89d4c57c85e5fc51a2446cd939bf57802]

CVE-2025-37968: iio: light: opt3001: fix deadlock due to concurrent flag access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37968

Introduced by commit 94a9b7b ("iio: light: add support for TI's
opt3001 light sensor") in v4.3-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f063a28002e3350088b4577c5640882bf4ea17ea]

CVE-2025-37969: iio: imu: st_lsm6dsx: fix possible lockup in
st_lsm6dsx_read_tagged_fifo

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37969

Introduced by commit 801a6e0 ("iio: imu: st_lsm6dsx: add support to
LSM6DSO") in v4.20-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8114ef86e2058e2554111b793596f17bee23fa15]
stable/5.15: [35b8c0a284983b71d92d082c54b7eb655ed4194f]
stable/6.1: [16857370b3a30663515956b3bd27f3def6a2cf06]
stable/6.6: [9ce662851380fe2018e36e15c0bdcb1ad177ed95]

CVE-2025-37970: iio: imu: st_lsm6dsx: fix possible lockup in
st_lsm6dsx_read_fifo

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37970

Introduced by commit 290a6ce ("iio: imu: add support to lsm6dsx
driver") in v4.11-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [159ca7f18129834b6f4c7eae67de48e96c752fc9]
stable/5.15: [f3cf233c946531a92fe651ff2bd15ebbe60630a7]
stable/6.1: [6c4a5000618a8c44200d455c92e2f2a4db264717]
stable/6.6: [da33c4167b9cc1266a97215114cb74679f881d0c]

CVE-2025-37971: staging: bcm2835-camera: Initialise dev in v4l2_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37971

Introduced by commit 42a2f66 ("staging: vc04_services: Move global
g_state to vchiq_state") in v6.10-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98698ca0e58734bc5c1c24e5bbc7429f981cd186]

CVE-2025-37972: Input: mtk-pmic-keys - fix possible null pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37972

Introduced by commit b581acb ("Input: mtk-pmic-keys - transfer per-key
bit in mtk_pmic_keys_regs") in v6.0-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11cdb506d0fbf5ac05bf55f5afcb3a215c316490]
stable/6.1: [334d74a798463ceec02a41eb0e2354aaac0d6249]
stable/6.6: [90fa6015ff83ef1c373cc61b7c924ab2bcbe1801]

CVE-2025-37973: wifi: cfg80211: fix out-of-bounds access during
multi-link element defragmentation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37973

Introduced by commit 2481b5d ("wifi: cfg80211: handle BSS data
contained in ML probe responses") in v6.5-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [023c1f2f0609218103cbcb48e0104b144d4a16dc]
stable/6.6: [73dde269a1a43e6b1aa92eba13ad2df58bfdd38e]

CVE-2025-37974: s390/pci: Fix missing check for zpci_create_device()
error return

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37974

Introduced by commit 0467cdd ("s390/pci: Sort PCI functions prior to
creating virtual busses") in v6.13-rc1.
Fixed in v6.15-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [42420c50c68f3e95e90de2479464f420602229fc]

CVE-2025-37975: riscv: module: Fix out-of-bounds relocation access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37975

Introduced by commit 080c432 ("riscv: optimize ELF relocation function
in riscv") in v6.8-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b4cce68efb93e31a8e51795d696df6e379cb41c]

CVE-2025-37976: wifi: ath12k: Fix invalid entry fetch in
ath12k_dp_mon_srng_process

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37976

This CVE announce does not contain fixed commit in the mainline.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63fdc4509bcf483e79548de6bc08bf3c8e504bb3]
stable/6.6: [2c512f2eadabb1e80816116894ffaf7d802a944e]

CVE-2025-37977: scsi: ufs: exynos: Disable iocc if dma-coherent
property isn't set

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37977

Introduced by commit cc52e15 ("scsi: ufs: ufs-exynos: Support
ExynosAuto v9 UFS") in v5.16-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f92bb7436802f8eb7ee72dc911a33c8897fde366]

CVE-2025-37978: block: integrity: Do not call set_page_dirty_lock()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37978

Introduced by commit 492c5d4 ("block: bio-integrity: directly map user
buffers") in v6.8-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39e160505198ff8c158f11bce2ba19809a756e8b]

CVE-2025-37979: ASoC: qcom: Fix sc7280 lpass potential buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37979

Introduced by commit 77d0ffe ("ASoC: qcom: Add macro for lpass DAI
id's max limit") in v5.18-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a31a4934b31faea76e735bab17e63d02fcd8e029]
stable/6.1: [d78888853eb53f47ae16cf3aa5d0444d0331b9f8]
stable/6.6: [a12c14577882b1f2b4cff0f86265682f16e97b0c]

CVE-2025-37980: block: fix resource leak in blk_register_queue() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37980

Introduced by commit 320ae51 ("blk-mq: new multi-queue block IO
queueing mechanism") in v3.13-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40f2eb9b531475dd01b683fdaf61ca3cfd03a51e]
stable/6.6: [549cbbd14bbec12469ceb279b79c763c8a24224e]

CVE-2025-37981: scsi: smartpqi: Use is_kdump_kernel() to check for kdump

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37981

Introduced by commit 058311b ("scsi: smartpqi: Add fw log to kdump")
in v6.12-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2d5a0072235a69749ceb04c1a26dc75df66a31a]

CVE-2025-37982: wifi: wl1251: fix memory leak in wl1251_tx_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37982

Introduced by commit c5483b7 ("wl12xx: check if elp wakeup failed") in
v2.6.32-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0f0dc96de03ffeefc2a177b7f8acde565cb77f4]
stable/5.10: [f08448a885403722c5c77dae51964badfcb69495]
stable/5.15: [2996144be660d930d5e394652abe08fe89dbe00e]
stable/5.4: [13c9744c1bcdb5de4e7dc1a78784788ecec52add]
stable/6.1: [8fd4b9551af214d037fbc9d8e179840b8b917841]
stable/6.6: [4a43fd36710669d67dbb5c16287a58412582ca26]

CVE-2025-37983: qibfs: fix _another_ leak

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37983

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
According to the commit message, this bug was introduced in initial merge
commit f931551 ("IB/qib: Add new qib driver for QLogic PCIe InfiniBand
adapters")
in 2.6.35-rc1.

Fixed status
mainline: [bdb43af4fdb39f844ede401bdb1258f67a580a27]
stable/5.10: [3c2fde33e3e505dfd1a895d1f24bad650c655e14]
stable/5.15: [5fe708c5e3c8b2152c6caaa67243e431a5d6cca3]
stable/5.4: [5e280cce3a29b7fe7b828c6ccd5aa5ba87ceb6b6]
stable/6.1: [545defa656568c74590317cd30068f85134a8216]
stable/6.6: [5d53e88d8370b9ab14dd830abb410d9a2671edb6]

CVE-2025-37984: crypto: ecdsa - Harden against integer overflows in
DIV_ROUND_UP()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37984

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
The ecdsa_x962_verify was added by d6793ff ("crypto: ecdsa - Move
X9.62 signature
decoding into template") in 6.13-rc1. The ecdsa_p1363_verify was added by
b041638 ("crypto: ecdsa - Support P1363 signature decoding") in 6.13-rc1.
The ecc_digits_from_bytes was added by c6ab5c9 ("crypto: ecc - Prevent
ecc_digits_from_bytes from reading too many bytes") in 6.10-rc1.

Fixed status
mainline: [b16510a530d1e6ab9683f04f8fb34f2e0f538275]

CVE-2025-37985: USB: wdm: close race between wdm_open and wdm_wwan_port_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37985

Introduced by commit cac6fb0 ("usb: class: cdc-wdm: WWAN framework
integration") in v5.14-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1846ed4eb527bdfe6b3b7dd2c78e2af4bf98f4f]
stable/5.15: [b02a3fef3e8c8fe5a0a266f7a14f38cc608fb167]
stable/6.1: [217fe1fc7d112595a793e02b306710e702eac492]
stable/6.6: [54f7f8978af19f899dec80bcc71c8d4855dfbd72]

CVE-2025-37986: usb: typec: class: Invalidate USB device pointers on
partner unregistration

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37986

Introduced by commit 59de2a5 ("usb: typec: Link enumerated USB devices
with Type-C partner") in v6.7-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66e1a887273c6b89f09bc11a40d0a71d5a081a8e]

CVE-2025-37987: pds_core: Prevent possible adminq overflow/stuck condition

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37987

Introduced by commit 45d76f4 ("pds_core: set up device and adminq") in v6.4-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9e2f070d8af60f2c8c02b2ddf0a9e90b4e9220c]

CVE-2025-37988: fix a couple of races in MNT_TREE_BENEATH handling by
do_move_mount()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37988

Introduced by commit 6ac3928 "fs: allow to mount beneath top mount" #
v6.5+ in v6.5-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d039eac6e5950f9d1ecc9e410c2fd1feaeab3b6]
stable/6.6: [4f435c1f4c48ff84968e2d9159f6fa41f46cf998]

CVE-2025-37989: net: phy: leds: fix memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37989

Introduced by commit 3928ee6 ("net: phy: leds: Add support for "link"
trigger") in v4.15-rc1.
Introduced by commit 2e0bc45 ("net: phy: leds: add support for led
triggers on phy link state change") in v4.10-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7f0ee992adf601aa00c252418266177eb7ac2bc]
stable/5.10: [95bed65cc0eb2a610550abf849a8b94374da80a7]
stable/5.15: [663c3da86e807c6c07ed48f911c7526fad6fe1ff]
stable/5.4: [966d6494e2ed9be9052fcd9815afba830896aaf8]
stable/6.1: [f41f097f68a33d392579885426d0734a81219501]
stable/6.6: [618541a6cc1511064dfa58c89b3445e21844092f]

CVE-2025-37990: wifi: brcm80211: fmac: Add error handling for
brcmf_usb_dl_writeimage()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37990

Introduced by commit 71bb244 ("brcm80211: fmac: add USB support for
bcm43235/6/8 chipsets") in v3.4-rc1.
Fixed in v6.15-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e089e7b585d95122c8122d732d1d5ef8f879396]
stable/5.15: [508be7c001437bacad7b9a43f08a723887bcd1ea]
stable/6.1: [524b70441baba453b193c418e3142bd31059cc1f]
stable/6.6: [08424a0922fb9e32a19b09d852ee87fb6c497538]

CVE-2025-37991: parisc: Fix double SIGFPE crash

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37991

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc5.


Fixed status
mainline: [de3629baf5a33af1919dec7136d643b0662e85ef]
stable/5.15: [ec4584495868bd465fe60a3f771915c0e7ce7951]
stable/6.1: [6c639af49e9e5615a8395981eaf5943fb40acd6f]
stable/6.6: [6a098c51d18ec99485668da44294565c43dbc106]


* Updated CVEs

CVE-2024-28956: x86: Indirect Target Selection

stable/6.1, stable/6.12, stable/6.14 were fixed.

Fixed status
stable/6.1: [ed2e894a7645ac3cd22e0a8e8897496a5e5c7d0a,
0eda20c29e12ae38ff9767be802c16e06063a775,
5e7d4f2aceb216f458f24a22d9915e3968ed0fbb,
dbd8f170af4731d1251289a9419dae6f15a06308,
b1701fee52d1d68d1e12ad140b3551435a8e9fe7,
139c0b8318c2ea8afd2f12b6401466c6010286da,
e6da4a83e3689e963f115c0a8cff5da6f5b51256,
9502e83c22bef5ecfb2386aaa837d8afcf1fcece,
959cadf09dbae7b304f03e039b8d8e13c529e2dd,
c2bece04baf819b9614a35852e4573ee402e059d,
7e00c01ff80fd32f3cdfbebc29ddd6af1c404282,
73c71762fe985e50d5fb07b6dec325ebada7256f,
69afd82670d85120723f5d3a1443e910ec6f58a7]
stable/6.12: [76f847655bcbbeca672a4d5413a087fcf1d73e4e,
a6f2a436e9d6aa96013814cface08d8602638123,
16a7d5b7a46ec0db7d30bb52d096a222fa0e22ed,
51000047235f8d14ead34749f59e3eee80fa1403,
68d59e9ba38424389168eddf8791265818f67292,
4dc1902fdee72dd9474c9878c7153cf3769f8294,
9f132c0397df9cc073172560b6e4c975a4746c0e,
bd57853b863ea427c8fa25f7eb61f03cb6baf5ad,
15335117c5d73a0cc0404056c94cc8b6a371e25a,
88a817e60dbbda17135800adf9704d0bdcbcf98f,
2a6194e124273d5f6dbdbb16d92466f418ebf0e9,
bb85c3abbfd89198324752a4c2c67d2b7db6ab79,
7e78061be78b8593df9b0cd0f21b1fee425035de]
stable/6.14: [7f45fd5c1d1a9a7012ba61b44ec0938726222e7e,
9d874becc1cad5e94643bccfbb0764438fccfe6c,
4d8fb075de84c5d42670ea313e2482e58008204a,
34cef73d9c2da3d62fa3ee417021313f7bde57cb,
87c956ecd58c19bc6a5c5ccdc68539f1acf7d643,
7e538a619a81a7b84794a1b5003a84b4aa4e4f70,
8c68d68ff16e48cefa9ba0aff96c1a78074d6fed,
30ee713988c3ba3194dec2fffb418fc5e0061757,
74e25bb6186403ab44251a3ed38c19ebedd759e6,
0e8173b6bdfe2dbe4ad63d5ae9f66c27e660b486,
63d0ad4271ba9fd7a7cd6774f969be420a9ab40e,
36ae9d4420983351c7ae5047b8673f7737e6d7f5,
62be60f56a682e69f0d48c0ad46d3e45484c78f5]

CVE-2025-37821: sched/eevdf: Fix se->slice being set to U64_MAX and
resulting crash

stable/6.12 was fixed.

Fixed status
stable/6.12: [86b37810fa1e40b93171da023070b99ccbb4ea04]
stable/6.14: [50a665496881262519f115f1bfe5822f30580eb0]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

