Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F3CD4F4C
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 00:41:06 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web10.297.1725496851163060141
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Sep 2024 17:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=uZjOt8H+;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27830bce86bso165370fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 04 Sep 2024 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1725496850; x=1726101650; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1vAwzhAN8OvULnyls7+D6YBW28yWmnseSfGT6BGLG44=;
        b=uZjOt8H+g4jseKaQvYyg3m/f1zI4VBVIeg5hKGTgzCDE9AjciouvC6RUetezkGexWS
         3liRFEyZ40kXjuPl8toXGCyy26/6bSxsltg14AIJmNLvMCYQzOQwdZ4a3j4qEH58QQdu
         hxa9/nf5JoKjEX3ntRHiIHFcnBnIqe0Q73Z+fwZVWpZJTfRJpHF/GJamHYJ4WNQMJHdM
         zHf7FSpIT9mxFrPuvyK7Ypk7eFTUKryQFwlrWpMLya4MmIlGn0sNJLTZpaLwoDH3YBDh
         wzbyIwSiNLMtKc2zNd6XLeYipPxnRYjrddZaLyRzXLW8SGLoT9nEzyvuVSZjqlC2AdmL
         n4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496850; x=1726101650;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vAwzhAN8OvULnyls7+D6YBW28yWmnseSfGT6BGLG44=;
        b=GvfpoVJWrCVpxviYfsv0oF4AbSuNlz67qlZaGdjRu6T6IvbXK1WJpl5X7ME+PHdMo1
         8NJA+pbNi3N3m/OQ+LsBU0ikMnF8WxM5tMIhQEChhzRuDVpoghkkev3GWR5ed9PnnlxD
         SP3cQmTS7uIArekcgRndGCaDRaUmhRlSxadoDir0cRzn7eQIKLpwiku8g0YVFBJJbxoQ
         HHkllAZKh4MO2ae5+xiahk8Uj27QgsfAnUyG72C/jFH4eXUARax8mg1+P6aqaU+7/tjR
         jI/P4aUwBhQgLntZMimm3ab6Zhp/NHGHdIEIBOne8yYiDoPKod1XdcYz8YTcLBbr2ByY
         ZpNA==
X-Gm-Message-State: AOJu0YwihQUFidPfr4D+xJDxb1cRn7ysxsvkcaMqoEz35XK967HguX/h
	bG28HDzJkQOTNadzC17bBsO3E8l6/1WBsG/WWVguqhGXdoMfZ+wE8Yuff0dtWmEM1iTvxVB/7A+
	e/W/8m7PzOUV33seZd6HOR+4W7/Jb/ORzufyzDRJAYq8Dwb/LNmk=
X-Google-Smtp-Source: AGHT+IFnmFRdwjmzGj8NZErcFeKFViZys37+a25Nyzp4hTp/VY7tngsWcMFtUCNz2jSXndhhxsKlaffYBBOdd/Nh4C4=
X-Received: by 2002:a05:6871:400c:b0:277:dcb2:845e with SMTP id
 586e51a60fabf-277dcb29f6emr15686904fac.48.1725496848845; Wed, 04 Sep 2024
 17:40:48 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Sep 2024 09:40:12 +0900
Message-ID: <CAODzB9r8adug8TRWcOzF2oXSj0BCJTRNTCiDqiYSs1j0bePuvg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Sep 2024 00:41:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16849

Hi!

It's this week's CVE report.

This week reported 67 new CVEs and 20 updated CVEs.

* New CVEs
CVE-2021-4442: tcp: add sanity tests to TCP_QUEUE_SEQ

Announce: https://lore.kernel.org/linux-cve-announce/2024082945-CVE-2021-4442-0a5f@gregkh/

Introduced by commit ee99528 ("tcp: Initial repair mode") in v3.5-rc1.
Fixed in v5.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8811f4a9836e31c14ecdf79d9f3cb7c5d463265d]
stable/4.19: [319f460237fc2965a80aa9a055044e1da7b3692a]
stable/5.10: [046f3c1c2ff450fb7ae53650e9a95e0074a61f3e]
stable/5.4: [3bf899438c123c444f6b644a57784dfbb6b15ad6]

CVE-2022-48944: sched: Fix yet more sched_fork() races

Announce: https://lore.kernel.org/linux-cve-announce/2024083006-CVE-2022-48944-274c@gregkh/

Introduced by commit 4ef0c5c ("kernel/sched: Fix sched_fork() access
an invalid sched_task_group") in v5.16-rc1.
Fixed in v5.17-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [b1e8206582f9d680cff7d04828708c8b6ab32957]
stable/5.15: [3411613611a5cddf7e80908010dc87cb527dd13b]

CVE-2024-44944: netfilter: ctnetlink: use helper function to calculate expect ID

Announce: https://lore.kernel.org/linux-cve-announce/2024083044-CVE-2024-44944-56c0@gregkh/

Introduced by commit 3c79107 ("netfilter: ctnetlink: don't use
conntrack/expect object addresses as id") in v5.1-rc7.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st stable/4.19

Fixed status
mainline: [782161895eb4ac45cf7cfa8db375bd4766cb8299]
stable/4.19: [66e7650dbbb8e236e781c670b167edc81e771450]
stable/5.10: [eb4ca1a97e08ff5b920664ba292e576257e2d184]
stable/5.15: [5e2c24f7b0911b15c29aefce760bcf770542fb61]
stable/5.4: [64c0b8e64be8368617ef08dfc59a3160563a1435]
stable/6.1: [24f407042cf90b0872de667460230d8d50c06c39]
stable/6.6: [27662b46f2adaa52c1665a82af4b21c42c4337fd]

CVE-2024-44945: netfilter: nfnetlink: Initialise extack before use in ACKs

Announce: https://lore.kernel.org/linux-cve-announce/2024083152-CVE-2024-44945-eb4d@gregkh/

Introduced by commit bf2ac49 ("netfilter: nfnetlink: Handle ACK flags
for batch messages") in v6.10-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1a7b382a9d3f0f3e5a80e0be2991c075fa4f618]

CVE-2024-44946: kcm: Serialise kcm_sendmsg() for the same socket.

Announce: https://lore.kernel.org/linux-cve-announce/2024083150-CVE-2024-44946-9cf1@gregkh/

Introduced by commit ab7ac4e ("kcm: Kernel Connection Multiplexor
module") in v4.6-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [807067bf014d4a3ae2cc55bd3de16f22a01eb580]
stable/4.19: [8c9cdbf600143bd6835c8b8351e5ac956da79aec]
stable/5.10: [eb06c8d3022ce6738711191c89f9b3e9cfb91914]
stable/5.15: [fa6c23fe6dcac8c8bd63920ee8681292a2bd544e]
stable/5.4: [6633b17840bf828921254d788ccd15602843fe9b]
stable/6.1: [72da240aafb142630cf16adc803ccdacb3780849]
stable/6.6: [00425508f30baa5ab6449a1f478480ca7cffa6da]

CVE-2024-44947: fuse: Initialize beyond-EOF page contents before
setting uptodate

Announce: https://lore.kernel.org/linux-cve-announce/2024090219-CVE-2024-44947-f49c@gregkh/

Introduced by commit a1d75f2 ("fuse: add store request") in v2.6.36-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c0da3d163eb32f1f91891efaade027fa9b245b9]
stable/4.19: [49934861514d36d0995be8e81bb3312a499d8d9a]
stable/5.10: [4690e2171f651e2b415e3941ce17f2f7b813aff6]
stable/5.15: [8c78303eafbf85a728dd84d1750e89240c677dd9]
stable/5.4: [33168db352c7b56ae18aa55c2cae1a1c5905d30e]
stable/6.1: [831433527773e665bdb635ab5783d0b95d1246f4]
stable/6.6: [ac42e0f0eb66af966015ee33fd355bc6f5d80cd6]

CVE-2024-44948: x86/mtrr: Check if fixed MTRRs exist before saving them

Announce: https://lore.kernel.org/linux-cve-announce/2024090407-CVE-2024-44948-5554@gregkh/

Introduced by commit 2b1f627 ("[PATCH] x86: Save the MTRRs of the BSP
before booting an AP") in v2.6.22-rc1.
Fixed in v6.11-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [919f18f961c03d6694aa726c514184f2311a4614]
stable/4.19: [34f36e6ee5bd7eff8b2adcd9fcaef369f752d82e]
stable/5.10: [450b6b22acdaac67a18eaf5ed498421ffcf10051]
stable/5.15: [ca7d00c5656d1791e28369919e3e10febe9c3b16]
stable/5.4: [06c1de44d378ec5439db17bf476507d68589bfe9]
stable/6.1: [8aa79dfb216b865e96ff890bc4ea71650f9bc8d7]
stable/6.6: [8a90d3fc7c24608548d3a750671f9dac21d1a462]

CVE-2024-44949: parisc: fix a possible DMA corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024090410-CVE-2024-44949-8f05@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc2.
CIP does not support parisc architecture.

Fixed status
mainline: [7ae04ba36b381bffe2471eff3a93edced843240f]
stable/6.6: [642a0b7453daff0295310774016fcb56d1f5bc7f]

CVE-2024-44950: serial: sc16is7xx: fix invalid FIFO access with
special register set

Announce: https://lore.kernel.org/linux-cve-announce/2024090410-CVE-2024-44950-67fb@gregkh/

Introduced by commit dfeae61 ("serial: sc16is7xx") in v3.16-rc1.
Fixed in v6.11-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d3b793faaab1305994ce568b59d61927235f57b]

CVE-2024-44951: serial: sc16is7xx: fix TX fifo corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024090411-CVE-2024-44951-9121@gregkh/

Introduced by commit 4409df5 ("serial: sc16is7xx: change EFR lock to
operate on each channels") in v6.8-rc1.
Fixed in v6.11-rc3.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [133f4c00b8b2bfcacead9b81e7e8edfceb4b06c4]

CVE-2024-44952: driver core: Fix uevent_show() vs driver detach race

Announce: https://lore.kernel.org/linux-cve-announce/2024090411-CVE-2024-44952-6290@gregkh/

Introduced by commit c0a4009 ("drivers: core: synchronize
really_probe() and dev_uevent()") in v6.10-rc4.
Fixed in v6.11-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.6

Fixed status
mainline: [15fffc6a5624b13b428bb1c6e9088e32a55eb82c]
stable/4.19: [49ea4e0d862632d51667da5e7a9c88a560e9c5a1]
stable/5.10: [f098e8fc7227166206256c18d56ab622039108b1]
stable/5.15: [9c23fc327d6ec67629b4ad323bd64d3834c0417d]
stable/5.4: [dd98c9630b7ee273da87e9a244f94ddf947161e2]
stable/6.1: [4a7c2a8387524942171037e70b80e969c3b5c05b]
stable/6.6: [4d035c743c3e391728a6f81cbf0f7f9ca700cf62]

CVE-2024-44953: scsi: ufs: core: Fix deadlock during RTC update

Announce: https://lore.kernel.org/linux-cve-announce/2024090411-CVE-2024-44953-1a10@gregkh/

Introduced by commit 6bf999e ("scsi: ufs: core: Add UFS RTC support")
in v6.8-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3911af778f208e5f49d43ce739332b91e26bc48e]

CVE-2024-44954: ALSA: line6: Fix racy access to midibuf

Announce: https://lore.kernel.org/linux-cve-announce/2024090411-CVE-2024-44954-6838@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc3.

Fixed status
mainline: [15b7a03205b31bc5623378c190d22b7ff60026f1]
stable/4.19: [643293b68fbb6c03f5e907736498da17d43f0d81]
stable/5.10: [e7e7d2b180d8f297cea6db43ea72402fd33e1a29]
stable/5.15: [a54da4b787dcac60b598da69c9c0072812b8282d]
stable/5.4: [40f3d5cb0e0cbf7fa697913a27d5d361373bdcf5]
stable/6.1: [c80f454a805443c274394b1db0d1ebf477abd94e]
stable/6.6: [535df7f896a568a8a1564114eaea49d002cb1747]

CVE-2024-44955: drm/amd/display: Don't refer to dc_sink in
is_dsc_need_re_compute

Announce: https://lore.kernel.org/linux-cve-announce/2024090412-CVE-2024-44955-20e8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit b9b5a82c ("drm/amd/display:
Fix DSC-re-computing") in 6.11-rc1.

Fixed status
mainline: [fcf6a49d79923a234844b8efe830a61f3f0584e4]

CVE-2024-44956: drm/xe/preempt_fence: enlarge the fence critical section

Announce: https://lore.kernel.org/linux-cve-announce/2024090412-CVE-2024-44956-8bcf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
preempt_fence_work_func was introduced by commit dd08ebf6c ("drm/xe:
Introduce a new DRM driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [3cd1585e57908b6efcd967465ef7685f40b2a294]

CVE-2024-44957: xen: privcmd: Switch from mutex to spinlock for irqfds

Announce: https://lore.kernel.org/linux-cve-announce/2024090412-CVE-2024-44957-5c8e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit f8941e6c ("xen: privcmd: Add
support for irqfd") in 6.6-rc1.

Fixed status
mainline: [1c682593096a487fd9aebc079a307ff7a6d054a3]
stable/6.6: [c2775ae4d9227729f8ca9ee2a068f62a00d5ea9c]

CVE-2024-44958: sched/smt: Fix unbalance sched_smt_present dec/inc

Announce: https://lore.kernel.org/linux-cve-announce/2024090413-CVE-2024-44958-80e9@gregkh/

Introduced by commit c5511d0 ("sched/smt: Make sched_smt_present track
topology") in v4.20-rc5.
Fixed in v6.11-rc2.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [e22f910a26cc2a3ac9c66b8e935ef2a7dd881117]
stable/5.15: [2a3548c7ef2e135aee40e7e5e44e7d11b893e7c4]
stable/6.1: [2cf7665efe451e48d27953e6b5bc627d518c902b]
stable/6.6: [65727331b60197b742089855ac09464c22b96f66]

CVE-2024-44959: tracefs: Use generic inode RCU for synchronizing freeing

Announce: https://lore.kernel.org/linux-cve-announce/2024090413-CVE-2024-44959-61a5@gregkh/

Introduced by commit baa23a8 ("tracefs: Reset permissions on remount
if permissions are options") in v6.9-rc7.
Fixed in v6.11-rc3.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [0b6743bd60a56a701070b89fb80c327a44b7b3e2]
stable/6.6: [726f4c241e17be75a9cf6870d80cd7479dc89e8f]

CVE-2024-44960: usb: gadget: core: Check for unset descriptor

Announce: https://lore.kernel.org/linux-cve-announce/2024090413-CVE-2024-44960-039b@gregkh/

Introduced by commit 54f83b8 ("USB: gadget: Reject endpoints with 0
maxpacket value") in v5.4-rc6.
Fixed in v6.11-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st stable/4.19

Fixed status
mainline: [973a57891608a98e894db2887f278777f564de18]
stable/4.19: [ba15815dd24cc5ec0d23e2170dc58c7db1e03b4a]
stable/5.10: [7cc9ebcfe58be22f18056ad8bc6272d120bdcb3e]
stable/5.15: [50c5248b0ea8aae0529fdf28dac42a41312d3b62]
stable/5.4: [df8e734ae5e605348aa0ca2498aedb73e815f244]
stable/6.1: [a0362cd6e503278add954123957fd47990e8d9bf]
stable/6.6: [1a9df57d57452b104c46c918569143cf21d7ebf1]

CVE-2024-44961: drm/amdgpu: Forward soft recovery errors to userspace

Announce: https://lore.kernel.org/linux-cve-announce/2024090414-CVE-2024-44961-8666@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc3.
It seems as if this bug was introduced by commit e84e697d ("drm/amdgpu: abort
submissions during prepare on error") in 6.5-rc1.

Fixed status
mainline: [829798c789f567ef6ba4b084c15b7b5f3bd98d51]
stable/6.6: [0da0b06165d83a8ecbb6582d9d5a135f9d38a52a]

CVE-2024-44962: Bluetooth: btnxpuart: Shutdown timer and prevent
rearming when driver unloading

Announce: https://lore.kernel.org/linux-cve-announce/2024090414-CVE-2024-44962-c329@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 689ca16 ("Bluetooth: NXP: Add
protocol support for NXP Bluetooth chipsets") in 6.4-rc1.

Fixed status
mainline: [0d0df1e750bac0fdaa77940e711c1625cff08d33]
stable/6.6: [4d9adcb94d55e9be8a3e464d9f2ff7d27e2ed016]

CVE-2024-44963: btrfs: do not BUG_ON() when freeing tree block after error

Announce: https://lore.kernel.org/linux-cve-announce/2024090414-CVE-2024-44963-2e6d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [bb3868033a4cccff7be57e9145f2117cbdc91c11]

CVE-2024-44964: idpf: fix memory leaks and crashes while performing a soft reset

Announce: https://lore.kernel.org/linux-cve-announce/2024090414-CVE-2024-44964-ebb1@gregkh/

Introduced by commit 02cbfba ("idpf: add ethtool callbacks") in v6.7-rc1.
Introduced by commit e4891e4 ("idpf: split &idpf_queue into 4
strictly-typed queue structures") in v6.11-rc1.
Fixed in v6.11-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f01032a2ca099ec8d619aaa916c3762aa62495df]

CVE-2024-44965: x86/mm: Fix pti_clone_pgtable() alignment assumption

Announce: https://lore.kernel.org/linux-cve-announce/2024090415-CVE-2024-44965-d41d@gregkh/

Introduced by commit 16a3fe6 ("x86/mm/pti: Clone kernel-image on PTE
level for 32 bit") in v4.19-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41e71dbb0e0a0fe214545fe64af031303a08524c]
stable/4.19: [18da1b27ce16a14a9b636af9232acb4fb24f4c9e]
stable/5.10: [d00c9b4bbc442d99e1dafbdfdab848bc1ead73f6]
stable/5.15: [4d143ae782009b43b4f366402e5c37f59d4e4346]
stable/5.4: [25a727233a40a9b33370eec9f0cad67d8fd312f8]
stable/6.1: [5c580c1050bcbc15c3e78090859d798dcf8c9763]
stable/6.6: [ca07aab70dd3b5e7fddb62d7a6ecd7a7d6d0b2ed]

CVE-2024-44966: binfmt_flat: Fix corruption when not offsetting data start

Announce: https://lore.kernel.org/linux-cve-announce/2024090449-CVE-2024-44966-3aac@gregkh/

Introduced by commit 04d82a6 ("binfmt_flat: allow not offsetting data
start") in v5.13-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3eb3cd5992f7a0c37edc8d05b4c38c98758d8671]
stable/5.15: [3a684499261d0f7ed5ee72793025c88c2276809c]
stable/6.1: [af65d5383854cc3f172a7d0843b628758bf462c8]
stable/6.6: [49df34d2b7da9e57c839555a2f7877291ce45ad1]

CVE-2024-44967: drm/mgag200: Bind I2C lifetime to DRM device

Announce: https://lore.kernel.org/linux-cve-announce/2024090453-CVE-2024-44967-dd14@gregkh/

Introduced by commit b279df2 ("drm/mgag200: Switch I2C code to managed
cleanup") in v6.0-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb1ae34e48a09b7a1179c579aed042b032e408f4]
stable/6.1: [55a6916db77102765b22855d3a0add4751988b7c]
stable/6.6: [81d34df843620e902dd04aa9205c875833d61c17]

CVE-2024-44968: tick/broadcast: Move per CPU pointer access into the
atomic section

Announce: https://lore.kernel.org/linux-cve-announce/2024090456-CVE-2024-44968-3e4f@gregkh/

Introduced by commit f7d43dd ("tick/broadcast: Make takeover of
broadcast hrtimer reliable") in v6.11-rc1.
Fixed in v5.15.165.
Bug introduced commit was backported to following branches.
cip/4.19 cip/6.1 stable/4.19 stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.10 stable/6.6

Fixed status
mainline: [541a900d245536d4809cb1aa322c3fcc2cdb58a6]
stable/4.19: [f54abf332a2bc0413cfa8bd6a8511f7aa99faea0]
stable/5.10: [668c6c4a7e9e9f081c06b70f30104fb7013437ed]
stable/6.1: [f54abf332a2bc0413cfa8bd6a8511f7aa99faea0]
stable/6.6: [f91fb47ecacc178a83a77eeebd25cbaec18c01d6]

CVE-2024-44969: s390/sclp: Prevent release of buffer in I/O

Announce: https://lore.kernel.org/linux-cve-announce/2024090456-CVE-2024-44969-48bf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
CIP does not support s390 architecture.

Fixed status
mainline: [bf365071ea92b9579d5a272679b74052a5643e35]
stable/4.19: [7a7e60ed23d471a07dbbe72565d2992ee8244bbe]
stable/5.10: [a3e52a4c22c846858a6875e1c280030a3849e148]
stable/5.15: [a88a49473c94ccfd8dce1e766aacf3c627278463]
stable/5.4: [1ec5ea9e25f582fd6999393e2f2c3bf56f234e05]
stable/6.1: [46f67233b011385d53cf14d272431755de3a7c79]
stable/6.6: [1e8b7fb427af6b2ddd54eff66a6b428a81c96633]

CVE-2024-44970: net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink

Announce: https://lore.kernel.org/linux-cve-announce/2024090456-CVE-2024-44970-f687@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit f97d5c2a ("net/mlx5e:
Add handle
SHAMPO cqe support") in 5.16-rc1.

Fixed status
mainline: [fba8334721e266f92079632598e46e5f89082f30]
stable/6.1: [7b379353e9144e1f7460ff15f39862012c9d0d78]
stable/6.6: [650e24748e1e0a7ff91d5c72b72a2f2a452b5b76]

CVE-2024-44971: net: dsa: bcm_sf2: Fix a possible memory leak in
bcm_sf2_mdio_register()

Announce: https://lore.kernel.org/linux-cve-announce/2024090457-CVE-2024-44971-eb75@gregkh/

Introduced by commit 771089c ("net: dsa: bcm_sf2: Ensure that MDIO
diversion is used") in v5.10-rc1.
Fixed in v6.11-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3862093ee93fcfbdadcb7957f5f8974fffa806a]
stable/5.10: [b7b8d9f5e679af60c94251fd6728dde34be69a71]
stable/5.15: [c05516c072903f6fb9134b8e7e1ad4bffcdc4819]
stable/6.1: [7feef10768ea71d468d9bbc1e0d14c461876768c]
stable/6.6: [a7d2808d67570e6acae45c2a96e0d59986888e4c]

CVE-2024-44972: btrfs: do not clear page dirty inside
extent_write_locked_range()

Announce: https://lore.kernel.org/linux-cve-announce/2024090457-CVE-2024-44972-23b5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 44962ca3 ("btrfs: don't
redirty pages in compress_file_range") in 6.6-rc1.

Fixed status
mainline: [97713b1a2ced1e4a2a6c40045903797ebd44d7e0]
stable/6.6: [ba4dedb71356638d8284e34724daca944be70368]

CVE-2024-44973: mm, slub: do not call do_slab_free for kfence object

Announce: https://lore.kernel.org/linux-cve-announce/2024090425-CVE-2024-44973-a92d@gregkh/

Introduced by commit 782f890 ("mm/slub: free KFENCE objects in
slab_free_hook()") in v6.8-rc1.
Fixed in v6.11-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a371d558e6f3aed977a8a7346350557de5d25190]

CVE-2024-44974: mptcp: pm: avoid possible UaF when selecting endp

Announce: https://lore.kernel.org/linux-cve-announce/2024090440-CVE-2024-44974-dbe8@gregkh/

Introduced by commit 01cacb0 ("mptcp: add netlink-based PM") in v5.7-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48e50dcbcbaaf713d82bf2da5c16aeced94ad07d]
stable/6.6: [9a9afbbc3fbfca4975eea4aa5b18556db5a0c0b8]

CVE-2024-44975: cgroup/cpuset: fix panic caused by partcmd_update

Announce: https://lore.kernel.org/linux-cve-announce/2024090442-CVE-2024-44975-7c21@gregkh/

Introduced by commit 0c7f293 ("cgroup/cpuset: Add
cpuset.cpus.exclusive.effective for v2") in v6.7-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [959ab6350add903e352890af53e86663739fcb9a]

CVE-2024-44976: ata: pata_macio: Fix DMA table overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024090442-CVE-2024-44976-0775@gregkh/

Introduced by commit 09fe2bf ("ata: pata_macio: Fix max_segment_size
with PAGE_SIZE == 64K") in v6.10-rc3.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [822c8020aebcf5804a143b891e34f29873fee5e2]

CVE-2024-44977: drm/amdgpu: Validate TA binary size

Announce: https://lore.kernel.org/linux-cve-announce/2024090443-CVE-2024-44977-7f6b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc5.
It seems as if this bug was introduced by commit e50d9ba0 ("drm/amdgpu: Add
debugfs TA load/unload/invoke support") in 5.19-rc1.

Fixed status
mainline: [c99769bceab4ecb6a067b9af11f9db281eea3e2a]
stable/6.1: [5ab8793b9a6cc059f503cbe6fe596f80765e0f19]
stable/6.6: [50553ea7cbd3344fbf40afb065f6a2d38171c1ad]

CVE-2024-44978: drm/xe: Free job before xe_exec_queue_put

Announce: https://lore.kernel.org/linux-cve-announce/2024090443-CVE-2024-44978-096b@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e7f30563677fbeff62d368d5d2a5ac7aaa9746a]

CVE-2024-44979: drm/xe: Fix missing workqueue destroy in xe_gt_pagefault

Announce: https://lore.kernel.org/linux-cve-announce/2024090443-CVE-2024-44979-74c3@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6f78359ac75f24cac3c1bdd753c49c1877bcd82]

CVE-2024-44980: drm/xe: Fix opregion leak

Announce: https://lore.kernel.org/linux-cve-announce/2024090443-CVE-2024-44980-d1ba@gregkh/

Introduced by commit 44e6949 ("drm/xe/display: Implement display
support") in v6.8-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4b2a0ae1a31fd3d1b5ca18ee08319b479cf9b5f]

CVE-2024-44981: workqueue: Fix UBSAN 'subtraction overflow' error in
shift_and_mask()

Announce: https://lore.kernel.org/linux-cve-announce/2024090444-CVE-2024-44981-2604@gregkh/

Introduced by commit 1211f3b ("workqueue: Preserve OFFQ bits in
cancel[_sync] paths") in v6.10-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38f7e14519d39cf524ddc02d4caee9b337dad703]

CVE-2024-44982: drm/msm/dpu: cleanup FB if dpu_format_populate_layout fails

Announce: https://lore.kernel.org/linux-cve-announce/2024090444-CVE-2024-44982-dd24@gregkh/

Introduced by commit 25fdd59 ("drm/msm: Add SDM845 DPU support") in v4.19-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfa1a6283be390947d3649c482e5167186a37016]
stable/5.15: [9b8b65211a880af8fe8330a101e1e239a2d4008f]
stable/6.1: [7ecf85542169012765e4c2817cd3be6c2e009962]
stable/6.6: [a3c5815b07f4ee19d0b7e2ddf91ff9f03ecbf27d]

CVE-2024-44983: netfilter: flowtable: validate vlan header

Announce: https://lore.kernel.org/linux-cve-announce/2024090444-CVE-2024-44983-dcdd@gregkh/

Introduced by commit 4cd91f7 ("netfilter: flowtable: add vlan
support") in v5.13-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ea14ccb60c8ab829349979b22b58a941ec4a3ee]
stable/5.15: [c05155cc455785916164aa5e1b4605a2ae946537]
stable/6.1: [d9384ae7aec46036d248d1c2c2757e471ab486c3]
stable/6.6: [0279c35d242d037abeb73d60d06a6d1bb7f672d9]

CVE-2024-44984: bnxt_en: Fix double DMA unmapping for XDP_REDIRECT

Announce: https://lore.kernel.org/linux-cve-announce/2024090445-CVE-2024-44984-43ea@gregkh/

Introduced by commit 578fcfd ("bnxt_en: Let the page pool manage the
DMA mapping") in v6.6-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8baeef7616d5194045c5a6b97fd1246b87c55b13]
stable/6.6: [fa4e6ae38574d0fc5596272bee64727d8ab7052b]

CVE-2024-44985: ipv6: prevent possible UAF in ip6_xmit()

Announce: https://lore.kernel.org/linux-cve-announce/2024090445-CVE-2024-44985-2dde@gregkh/

Introduced by commit 0c9f227 ("ipv6: use skb_expand_head in ip6_xmit")
in v5.15-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d5ff7e339d04622d8282661df36151906d0e1c7]
stable/5.15: [975f764e96f71616b530e300c1bb2ac0ce0c2596]
stable/6.1: [38a21c026ed2cc7232414cb166efc1923f34af17]
stable/6.6: [124b428fe28064c809e4237b0b38e97200a8a4a8]

CVE-2024-44986: ipv6: fix possible UAF in ip6_finish_output2()

Announce: https://lore.kernel.org/linux-cve-announce/2024090445-CVE-2024-44986-1197@gregkh/

Introduced by commit 5796015 ("ipv6: allocate enough headroom in
ip6_finish_output2()") in v5.14-rc2.
Fixed in v6.11-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [da273b377ae0d9bd255281ed3c2adb228321687b]
stable/5.15: [e891b36de161fcd96f12ff83667473e5067b9037]
stable/6.1: [3574d28caf9a09756ae87ad1ea096c6f47b6101e]
stable/6.6: [6ab6bf731354a6fdbaa617d1ec194960db61cf3b]

CVE-2024-44987: ipv6: prevent UAF in ip6_send_skb()

Announce: https://lore.kernel.org/linux-cve-announce/2024090446-CVE-2024-44987-f916@gregkh/

Introduced by commit 0625491 ("ipv6: ip6_push_pending_frames() should
increment IPSTATS_MIB_OUTDISCARDS") in v2.6.32-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faa389b2fbaaec7fd27a390b4896139f9da662e3]
stable/4.19: [571567e0277008459750f0728f246086b2659429]
stable/5.10: [cb5880a0de12c7f618d2bdd84e2d985f1e06ed7e]
stable/5.15: [24e93695b1239fbe4c31e224372be77f82dab69a]
stable/5.4: [ce2f6cfab2c637d0bd9762104023a15d0ab7c0a8]
stable/6.1: [9a3e55afa95ed4ac9eda112d4f918af645d72f25]
stable/6.6: [af1dde074ee2ed7dd5bdca4e7e8ba17f44e7b011]

CVE-2024-44988: net: dsa: mv88e6xxx: Fix out-of-bound access

Announce: https://lore.kernel.org/linux-cve-announce/2024090446-CVE-2024-44988-516a@gregkh/

Introduced by commit 75c05a7 ("net: dsa: mv88e6xxx: Fix counting of
ATU violations") in v5.0-rc6.
Fixed in v6.11-rc5.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [528876d867a23b5198022baf2e388052ca67c952]
stable/5.10: [050e7274ab2150cd212b2372595720e7b83a15bd]
stable/5.15: [a10d0337115a6d223a1563d853d4455f05d0b2e3]
stable/5.4: [d39f5be62f098fe367d672b4dd4bc4b2b80e08e7]
stable/6.1: [18b2e833daf049223ab3c2efdf8cdee08854c484]
stable/6.6: [f7d8c2fabd39250cf2333fbf8eef67e837f90a5d]

CVE-2024-44989: bonding: fix xfrm real_dev null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024090446-CVE-2024-44989-8a2d@gregkh/

Introduced by commit 18cb261 ("bonding: support hardware encryption
offload to slaves") in v5.9-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8cde9805981c50d0c029063dc7d82821806fc44]
stable/5.10: [21816b696c172c19d53a30d45ee005cce246ed21]
stable/5.15: [2f72c6a66bcd7e0187ec085237fee5db27145294]
stable/6.1: [7fa9243391ad2afe798ef4ea2e2851947b95754f]
stable/6.6: [4582d4ff413a07d4ed8a4823c652dc5207760548]

CVE-2024-44990: bonding: fix null pointer deref in bond_ipsec_offload_ok

Announce: https://lore.kernel.org/linux-cve-announce/2024090446-CVE-2024-44990-6b62@gregkh/

Introduced by commit 18cb261 ("bonding: support hardware encryption
offload to slaves") in v5.9-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95c90e4ad89d493a7a14fa200082e466e2548f9d]
stable/5.10: [81216b9352be43f8958092d379f6dec85443c309]
stable/5.15: [2f5bdd68c1ce64bda6bef4d361a3de23b04ccd59]
stable/6.1: [32a0173600c63aadaf2103bf02f074982e8602ab]
stable/6.6: [0707260a18312bbcd2a5668584e3692d0a29e3f6]

CVE-2024-44991: tcp: prevent concurrent execution of tcp_sk_exit_batch

Announce: https://lore.kernel.org/linux-cve-announce/2024090447-CVE-2024-44991-2437@gregkh/

Introduced by commit e9bd0cc ("tcp: Don't allocate tcp_death_row
outside of struct netns_ipv4.") in v6.1-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [565d121b69980637f040eb4d84289869cdaabedf]
stable/6.1: [e3d9de3742f4d5c47ae35f888d3023a5b54fcd2f]
stable/6.6: [99580ae890ec8bd98b21a2a9c6668f8f1555b62e]

CVE-2024-44992: smb/client: avoid possible NULL dereference in
cifs_free_subrequest()

Announce: https://lore.kernel.org/linux-cve-announce/2024090447-CVE-2024-44992-9050@gregkh/

Introduced by commit 69c3c02 ("cifs: Implement netfslib hooks") in v6.10-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74c2ab6d653b4c2354df65a7f7f2df1925a40a51]

CVE-2024-44993: drm/v3d: Fix out-of-bounds read in `v3d_csd_job_run()`

Announce: https://lore.kernel.org/linux-cve-announce/2024090447-CVE-2024-44993-b6db@gregkh/

Introduced by commit 0ad5bc1 ("drm/v3d: fix up register addresses for
V3D 7.x") in v6.8-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [497d370a644d95a9f04271aa92cb96d32e84c770]

CVE-2024-44994: iommu: Restore lost return in iommu_report_device_fault()

Announce: https://lore.kernel.org/linux-cve-announce/2024090448-CVE-2024-44994-9c09@gregkh/

Introduced by commit 3dfa64a ("iommu: Make iommu_report_device_fault()
return void") in v6.9-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fca5b78511e98bdff2cdd55c172b23200a7b3404]

CVE-2024-44995: net: hns3: fix a deadlock problem when config TC
during resetting

Announce: https://lore.kernel.org/linux-cve-announce/2024090448-CVE-2024-44995-16e5@gregkh/

Introduced by commit bb6b94a ("net: hns3: Add reset interface
implementation in client") in v4.15-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be5e816d00a506719e9dbb1a9c861c5ced30a109]
stable/5.10: [fc250eca15bde34c4c8f806b9d88f55bd56a992c]
stable/5.15: [195918217448a6bb7f929d6a2ffffce9f1ece1cc]
stable/5.4: [67492d4d105c0a6321b00c393eec96b9a7a97a16]
stable/6.1: [6ae2b7d63cd056f363045eb65409143e16f23ae8]
stable/6.6: [fa1d4de7265c370e673583ac8d1bd17d21826cd9]

CVE-2024-44996: vsock: fix recursive ->recvmsg calls

Announce: https://lore.kernel.org/linux-cve-announce/2024090448-CVE-2024-44996-8b26@gregkh/

Introduced by commit 634f1a7 ("vsock: support sockmap") in v6.4-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69139d2919dd4aa9a553c8245e7c63e82613e3fc]
stable/6.6: [921f1acf0c3cf6b1260ab57a8a6e8b3d5f3023d5]

CVE-2024-44997: net: ethernet: mtk_wed: fix use-after-free panic in
mtk_wed_setup_tc_block_cb()

Announce: https://lore.kernel.org/linux-cve-announce/2024090449-CVE-2024-44997-2480@gregkh/

Introduced by commit 7996844 ("net: ethernet: mtk_wed: introduce wed
wo support") in v6.2-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db1b4bedb9b97c6d34b03d03815147c04fffe8b4]
stable/6.6: [326a89321f9d5fe399fe6f9ff7c0fc766582a6a0]

CVE-2024-44998: atm: idt77252: prevent use after free in dequeue_rx()

Announce: https://lore.kernel.org/linux-cve-announce/2024090449-CVE-2024-44998-6505@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9a18e8f770c9b0703dab93580d0b02e199a4c79]
stable/4.19: [628ea82190a678a56d2ec38cda3addf3b3a6248d]
stable/5.10: [1cece837e387c039225f19028df255df87a97c0d]
stable/5.15: [24cf390a5426aac9255205e9533cdd7b4235d518]
stable/5.4: [09e086a5f72ea27c758b3f3b419a69000c32adc1]
stable/6.1: [379a6a326514a3e2f71b674091dfb0e0e7522b55]
stable/6.6: [ef23c18ab88e33ce000d06a5c6aad0620f219bfd]

CVE-2024-44999: gtp: pull network headers in gtp_dev_xmit()

Announce: https://lore.kernel.org/linux-cve-announce/2024090449-CVE-2024-44999-187d@gregkh/

Introduced by commit 999cb27 ("gtp: add IPv6 support") in v6.10-rc1.
Introduced by commit 459aa66 ("gtp: add initial driver for datapath of
GPRS Tunneling Protocol (GTP-U)") in v4.7-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a3be7ff9224f424e485287b54be00d2c6bd9c40]
stable/4.19: [3d89d0c4a1c6d4d2a755e826351b0a101dbc86f3]
stable/5.10: [cbb9a969fc190e85195d1b0f08038e7f6199044e]
stable/5.15: [1f6b62392453d8f36685d19b761307a8c5617ac1]
stable/5.4: [f5dda8db382c5751c4e572afc7c99df7da1f83ca]
stable/6.1: [137d565ab89ce3584503b443bc9e00d44f482593]
stable/6.6: [34ba4f29f3d9eb52dee37512059efb2afd7e966f]

CVE-2024-45000: fs/netfs/fscache_cookie: add missing "n_accesses" check

Announce: https://lore.kernel.org/linux-cve-announce/2024090449-CVE-2024-45000-fd6f@gregkh/

Introduced by commit 12bb21a ("fscache: Implement cookie user counting
and resource pinning") in v5.17-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f71aa06398aabc2e3eaac25acdf3d62e0094ba70]
stable/6.1: [b8a50877f68efdcc0be3fcc5116e00c31b90e45b]
stable/6.6: [dfaa39b05a6cf34a16c525a2759ee6ab26b5fef6]

CVE-2024-45001: net: mana: Fix RX buf alloc_size alignment and atomic op panic

Announce: https://lore.kernel.org/linux-cve-announce/2024090450-CVE-2024-45001-50df@gregkh/

Introduced by commit 80f6215 ("net: mana: Add support for jumbo
frame") in v6.4-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32316f676b4ee87c0404d333d248ccf777f739bc]
stable/6.6: [65f20b174ec0172f2d6bcfd8533ab9c9e7e347fa]

CVE-2024-45002: rtla/osnoise: Prevent NULL dereference in error handling

Announce: https://lore.kernel.org/linux-cve-announce/2024090450-CVE-2024-45002-c292@gregkh/

Introduced by commit 1eceb2f ("rtla/osnoise: Add osnoise top mode") in
v5.17-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90574d2a675947858b47008df8d07f75ea50d0d0]
stable/6.1: [fc575212c6b75d538e1a0a74f4c7e2ac73bc46ac]
stable/6.6: [753f1745146e03abd17eec8eee95faffc96d743d]

CVE-2024-45003: vfs: Don't evict inode under the inode lru traversing context

Announce: https://lore.kernel.org/linux-cve-announce/2024090450-CVE-2024-45003-3bc2@gregkh/

Introduced by commit e50e512 ("ext4: xattr-in-inode support") in v4.13-rc1.
Introduced by commit 7959cf3 ("ubifs: journal: Handle xattrs like
files") in v5.2-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a0629834cd82f05d424bbc193374f9a43d1f87d]
stable/5.10: [03880af02a78bc9a98b5a581f529cf709c88a9b8]
stable/5.15: [cda54ec82c0f9d05393242b20b13f69b083f7e88]
stable/5.4: [3525ad25240dfdd8c78f3470911ed10aa727aa72]
stable/6.1: [437741eba63bf4e437e2beb5583f8633556a2b98]
stable/6.6: [b9bda5f6012dd00372f3a06a82ed8971a4c57c32]

CVE-2024-45004: KEYS: trusted: dcp: fix leak of blob encryption key

Announce: https://lore.kernel.org/linux-cve-announce/2024090451-CVE-2024-45004-61b4@gregkh/

Introduced by commit 2e8a0f4 ("KEYS: trusted: Introduce NXP DCP-backed
trusted keys") in v6.10-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e28bf61a5f9ab30be3f3b4eafb8d097e39446bb]

CVE-2024-45005: KVM: s390: fix validity interception issue when gisa
is switched off

Announce: https://lore.kernel.org/linux-cve-announce/2024090451-CVE-2024-45005-2297@gregkh/

Introduced by commit fe0ef00 ("KVM: s390: sort out physical vs virtual
pointers usage") in v6.2-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a44bb061d04b0306f2aa8add761d86d152b9377]
stable/6.6: [051c0a558154174cfcea301a386e4c91ade83ce1]

CVE-2024-45006: xhci: Fix Panther point NULL pointer deref at
full-speed re-enumeration

Announce: https://lore.kernel.org/linux-cve-announce/2024090451-CVE-2024-45006-6642@gregkh/

Introduced by commit 651aaf3 ("usb: xhci: Handle USB transaction error
on address command") in v4.15-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af8e119f52e9c13e556be9e03f27957554a84656]
stable/4.19: [ef0a0e616b2789bb804a0ce5e161db03170a85b6]
stable/5.10: [0f0654318e25b2c185e245ba4a591e42fabb5e59]
stable/5.15: [365ef7c4277fdd781a695c3553fa157d622d805d]
stable/5.4: [a57b0ebabe6862dce0a2e0f13e17941ad72fc56b]
stable/6.1: [5ad898ae82412f8a689d59829804bff2999dd0ea]
stable/6.6: [6b99de301d78e1f5249e57ef2c32e1dec3df2bb1]

CVE-2024-45007: char: xillybus: Don't destroy workqueue from work item
running on it

Announce: https://lore.kernel.org/linux-cve-announce/2024090452-CVE-2024-45007-74c8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.
Affected file was introduced by commit a53d120 ("char: xillybus: Add driver
for XillyUSB (Xillybus variant for USB)") in 5.14-rc1.

Fixed status
mainline: [ccbde4b128ef9c73d14d0d7817d68ef795f6d131]
stable/5.15: [409b495f8e3300d5fba08bc817fa8825dae48cc9]
stable/6.1: [5d3567caff2a1d678aa40cc74a54e1318941fad3]
stable/6.6: [a7ad105b12256ec7fb6d6d1a0e2e60f00b7da157]

CVE-2024-45008: Input: MT - limit max slots

Announce: https://lore.kernel.org/linux-cve-announce/2024090452-CVE-2024-45008-1d89@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc2.

Fixed status
mainline: [99d3bf5f7377d42f8be60a6b9cb60fb0be34dceb]
stable/4.19: [2829c80614890624456337e47320289112785f3e]
stable/5.10: [05dd9aabd04f9b5eb04dab9bb83d8c3e982d7549]
stable/5.15: [95f73d01f547dfc67fda3022c51e377a0454b505]
stable/5.4: [87f610a1a7fbdb1f2e3d90b54c955bd3b8a0c322]
stable/6.1: [94736334b8a25e4fae8daa6934e54a31f099be43]
stable/6.6: [8f04edd554d191834e9e1349ef030318ea6b11ba]


* Updated CVEs

CVE-2023-31083: BUG: general protection fault in hci_uart_tty_ioctl

stable/6.1, stable/4.19, stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [aea24ef5e9b2bbc5d5d05e39b10573971b91241c]
stable/5.10: [56b82e6ff3f55ed41d619bd181c2a684b5371e1d]
stable/5.15: [c6a73b7469f096016a55065157cd11906d81e062]
stable/5.4: [7732c54f2b41dac9a55e4e12de9691f6f93bf91a]
stable/6.1: [c06e7c45a743ac8222af2a348e5d9e26e31bfcc1]

CVE-2024-35937: wifi: cfg80211: check A-MSDU format more carefully

stable/6.1 was fixed.

Fixed status
stable/6.1: [9eb3bc0973d084423a6df21cf2c74692ff05647e]
stable/6.6: [5d7a8585fbb31e88fb2a0f581b70667d3300d1e9]
stable/6.8: [16da1e1dac23be45ef6e23c41b1508c400e6c544]

CVE-2024-35966: Bluetooth: RFCOMM: Fix not validating setsockopt user input

stable/6.1 was fixed.

Fixed status
stable/6.1: [eea40d33bf936a5c7fb03c190e61e0cfee00e872]
stable/6.6: [4ea65e2095e9bd151d0469328dd7fc2858feb546]
stable/6.8: [c3f787a3eafe519c93df9abbb0ca5145861c8d0f]

CVE-2024-40972: ext4: do not create EA inode under buffer lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [0752e7fb549d90c33b4d4186f11cfd25a556d1dd]
stable/6.6: [737fb7853acd5bc8984f6f42e4bfba3334be8ae1]
stable/6.9: [111103907234bffd0a34fba070ad9367de058752]

CVE-2024-43845: udf: Fix bogus checksum computation in udf_rename()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c996b570305e7a6910c2ce4cdcd4c22757ffe241]
stable/6.10: [40d7b3ed52449d36143bab8d3e70926aa61a60f4]
stable/6.6: [fe2ead240c31e8d158713beca9d0681a6e6a53ab]

CVE-2024-43884: Bluetooth: MGMT: Add error handling to pair_device()

stable/4.19, stable/5.10, stable/5.15, stable/5.4, stable/6.1,
stable/6.10, stable/6.6  were fixed.

Fixed status
stable/4.19: [11b4b0e63f2621b33b2e107407a7d67a65994ca1]
stable/5.10: [9df9783bd85610d3d6e126a1aca221531f6f6dcb]
stable/5.15: [951d6cb5eaac5130d076c728f2a6db420621afdb]
stable/5.4: [90e1ff1c15e5a8f3023ca8266e3a85869ed03ee9]
stable/6.1: [5da2884292329bc9be32a7778e0e119f06abe503]
stable/6.10: [ee0799103b1ae4bcfd80dc11a15df085f6ee1b61]
stable/6.6: [064dd929c76532359d2905d90a7c12348043cfd4]

CVE-2024-43897: net: drop bad gso csum_start and offset in virtio_net_hdr

stable/6.1 was fixed.

Fixed status
stable/6.1: [f01c5e335fbb7fb612d40f14a3c02e2612a43d3b]
stable/6.10: [2edbb3e8838c672cd7e247e47989df9d03fc6668]
stable/6.6: [6772c4868a8e7ad5305957cdb834ce881793acb7]

CVE-2024-44938: jfs: Fix shift-out-of-bounds in dbDiscardAG

stable/6.1 was fixed.

Fixed status
stable/6.1: [bd04a149e3a29e7f71b7956ed41dba34e42d539e]
stable/6.10: [234e6ea0855cdb5673d54ecaf7dc5c78f3e84630]
stable/6.6: [f650148b43949ca9e37e820804bb6026fff404f3]

CVE-2024-44939: jfs: fix null ptr deref in dtInsertEntry

stable/6.1 was fixed.

Fixed status
stable/6.1: [53023ab11836ac56fd75f7a71ec1356e50920fa9]
stable/6.10: [9c2ac38530d1a3ee558834dfa16c85a40fd0e702]
stable/6.6: [6ea10dbb1e6c58384136e9adfd75f81951e423f6]

CVE-2024-44940: fou: remove warn in gue_gro_receive on unsupported protocol

stable/6.1 was fixed.

Fixed status
stable/6.1: [5a2e37bc648a2503bf6d687aed27b9f4455d82eb]
stable/6.10: [440ab7f97261bc28501636a13998e1b1946d2e79]
stable/6.6: [3db4395332e7050ef9ddeb3052e6b5019f2a2a59]

CVE-2021-3669: reading /proc/sysvipc/shm does not scale with large
shared memory segment counts

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [0365c9029ad9cd4d9639f4a56755567ab479b51c]
stable/5.4: [29a132d7931c3cc80e791a3e3f32bbde3fd0600b]

CVE-2021-3759: memcg: charge semaphores and sem_undo objects

stable/4.19 was fixed.

Fixed status
stable/4.19: [9e235ce6facfef2cbde3e2a5f1ccce28d341880f]
stable/5.10: [836686e1a01d7e2fda6a5a18252243ff30a6e196]
stable/5.4: [bad83d55134e647a739ebef2082541963f2cbc92]

CVE-2023-52435: net: prevent mss overflow in skb_segment()

stable/4.19 was fixed.

Fixed status
stable/4.19: [0d3ffbbf8631d6db0552f46250015648991c856f]
stable/5.10: [8f8f185643747fbb448de6aab0efa51c679909a3]
stable/5.15: [6c53e8547687d9c767c139cd4b50af566f58c29a]
stable/5.4: [cd1022eaf87be8e6151435bd4df4c242c347e083]
stable/6.1: [989b0ff35fe5fc9652ee5bafbe8483db6f27b137]
stable/6.6: [95b3904a261a9f810205da560e802cc326f50d77]

CVE-2023-6915: ida: Fix crash in ida_free when the bitmap is empty

stable/4.19 was fixed.

Fixed status
stable/4.19: [89db5346acb5a15e670c4fb3b8f3c30fa30ebc15]
stable/5.10: [dbf8b0d9387fa02de0aa047ce23eb3a7bd134e03]
stable/5.15: [5dbcdaf4dbfe074e9142991c5c28eef789c1f6c6]
stable/5.4: [ef7152f8705fed11796641d7644acc3c950b5967]
stable/6.1: [9efdc0081ccae62c44a929e21d32bacc5f2e113f]
stable/6.6: [ffcaafdb8be64555e9928d943a3655c755dba92b]

CVE-2024-41011: drm/amdkfd: don't allow mapping the MMIO HDP page with
large pages

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [f7276cdc1912325b64c33fcb1361952c06e55f63]
stable/5.15: [8ad4838040e5515939c071a0f511ce2661a0889d]
stable/5.4: [009c4d78bcf07c4ac2e3dd9f275b4eaa72b4f884]
stable/6.1: [89fffbdf535ce659c1a26b51ad62070566e33b28]
stable/6.6: [4b4cff994a27ebf7bd3fb9a798a1cdfa8d01b724]
stable/6.9: [be4a2a81b6b90d1a47eaeaace4cc8e2cb57b96c7]

CVE-2024-41098: ata: libata-core: Fix null pointer dereference on error

stable/4.19, stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/4.19: [d9c4df80b1b009de1eb77c07e3bb4d45bd212aa5]
stable/5.10: [e83405e75d90694ee6a5d898f7f0473ac2686054]
stable/5.15: [221e3b1297e74fdec32d0f572f4dcb2260a0a2af]
stable/5.4: [56e62977eaaae3eb7122ee2cf9b720b6703114a9]
stable/6.1: [0f0d37c154bb108730c90a91aa31e3170e827962]
stable/6.6: [119c97ace2a9ffcf4dc09a23bb057d6c281aff28]

CVE-2024-42228: drm/amdgpu: Using uninitialized value *size when
calling amdgpu_vce_cs_reloc

stable/4.19, stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/4.19: [d35cf41c8eb5d9fe95b21ae6ee2910f9ba4878e8]
stable/5.10: [df02642c21c984303fe34c3f7d72965792fb1a15]
stable/5.15: [da6a85d197888067e8d38b5d22c986b5b5cab712]
stable/5.4: [3b505759447637dcccb50cbd98ec6f8d2a04fc46]
stable/6.1: [9ee1534ecdd5b4c013064663502d7fde824d2144]
stable/6.6: [855ae72c20310e5402b2317fc537d911e87537ef]

CVE-2024-42314: btrfs: fix extent map use-after-free when adding pages
to compressed bio

stable/6.1 was fixed.

Fixed status
stable/6.1: [c1cc3326e27b0bd7a2806b40bc48e49afaf951e7]
stable/6.10: [b7859ff398b6b656e1689daa860eb34837b4bb89]
stable/6.6: [c205565e0f2f439f278a4a94ee97b67ef7b56ae8]

CVE-2024-43853: cgroup/cpuset: Prevent UAF in proc_cpuset_show()

stable/4.19, stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [27d6dbdc6485d68075a0ebf8544d6425c1ed84bb]
stable/5.10: [688325078a8b5badd6e07ae22b27cd04e9947aec]
stable/5.15: [4e8d6ac8fc9f843e940ab7389db8136634e07989]
stable/5.4: [10aeaa47e4aa2432f29b3e5376df96d7dac5537a]
stable/6.1: [29a8d4e02fd4840028c38ceb1536cc8f82a257d4]
stable/6.10: [29ac1d238b3bf126af36037df80d7ecc4822341e]
stable/6.6: [96226fbed566f3f686f53a489a29846f2d538080]

CVE-2024-43891: tracing: Have format file honor EVENT_FILE_FL_FREED

stable/6.6 was fixed.

Fixed status
stable/6.10: [531dc6780d94245af037c25c2371c8caf652f0f9]
stable/6.6: [4ed03758ddf0b19d69eed69386d65a92d0091e0c]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

