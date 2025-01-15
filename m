Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A60C02180
	for <webhook@archiver.kernel.org>; Wed, 15 Jan 2025 23:41:36 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web11.36928.1736984492208544321
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jan 2025 15:41:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=ftN+FBki;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.180, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso545209276.2
        for <cip-dev@lists.cip-project.org>; Wed, 15 Jan 2025 15:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1736984491; x=1737589291; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/YQucWwThcsbby38Ez2wGqR5F8rUoAbh5gU0sPHKlpg=;
        b=ftN+FBkiL6CXM66J8YEmHV/ZvdB1KIDOMaC0LVm6IhPcz1zRCuhGCeD2XPLHGtMeWi
         n33TW6fEzE+7mdlmMRMCkPcgWFcjvwKa36qN+Xj830GhlB/56OI8VrMF22iJvycKnRPx
         PXTInVjn83rhKtT48zRtkt+llRu0JTCIJB7yOt217LbHgOpvfpNiqx3AhFoMci34uYes
         3nw+rEuJI2BYG396zoWah6wty0xn71Np2+9CoTTfBGsuEvE4+jFDc6vaMq23vPaky5Kw
         3ndWCrXJ6Qf+49ybc2awZwOCzVjDs06cFfKccCAe5ZtFgCCNFHocE7UvoaXMA7kSeFf3
         5NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736984491; x=1737589291;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YQucWwThcsbby38Ez2wGqR5F8rUoAbh5gU0sPHKlpg=;
        b=nFC/Tt/A9/2+RdLryq0i0OzrPb/am9FmMknKmkRULAS0ndEnVQz51PCKvNDS6nhT+d
         ZFGlAPn2aMxtjzh5ZRvrkZNvrsw3tJm8eOelXRQXaAPiMNqHoXPyzTT5TvWWi/MFrRm0
         y5WjjSsvmgQcCrGp6kxNtS7OP6Pr4Vl/HiVmJu07Iudvamf1EUpV8AT2e2fOntbz7cQ3
         1D+/i2jDLdzXgDrag5x4zBQO80MxuTOlV06dD778N1zKgUY7GG1Zdt6SYcO9jd5ptN9U
         zQwNExkyPmKFbInOc4w8XwTE2ORHzWsJ3PjwglSkH6b/e7DI5dt+vz3ofT3lNqaV2L+k
         fbBA==
X-Gm-Message-State: AOJu0Yy1BKN7PQY/b2bmjWpOaG9jnSSVDwAioB70MU6VtoG0oeObdCKD
	Nakt4NRQV1+pVvlsRITuwOw7ku9soSAP4C86D83GyVmQgJ2/R/adAGs5w0nn7tfiE/BgoLP3sqW
	TiMYMFCkyjyNiyMqJRF/KESOrWU+ysn1hNdfb/FkzsiaEE/DGj9Q=
X-Gm-Gg: ASbGnctKU6ZBxAnoIFls2O3OibbLWxjzHCZGI9Ufu9DFWm2wZia1Ttq8eWlsdH9oeD+
	LKf7R/BRYywsMDVDxmVW4SoybfdpIp2Fgx1VNO1g=
X-Google-Smtp-Source: AGHT+IHcK1dlrVgrgLD+YMXbQaU2p2mtK0UWXt/+0Eic4NGsCDREeFo1nuFAzlUPmRoIu+U6LTwNMyRkmkX+hoL+olc=
X-Received: by 2002:a05:6902:982:b0:e57:3e89:5d5b with SMTP id
 3f1490d57ef6-e573e8960c1mr13743951276.27.1736984489706; Wed, 15 Jan 2025
 15:41:29 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Jan 2025 08:40:53 +0900
X-Gm-Features: AbW1kvbU1ATcp_seIF-E-ZFurzUYIvJOli7vkuLaD7pd0pVBZUdpaXOoBFtD-h0
Message-ID: <CAODzB9qAyhM12i2K8eqhUAwtTRi9-JxFKHci0BdsjERkxiPHzw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jan 2025 23:41:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17541

Hi!

It's this week's CVE report.

This week reported 103 new CVEs and 26 updated CVEs.

* New CVEs
CVE-2024-41149: block: avoid to reuse `hctx` not removed from cpuhp
callback list

Announce: https://lore.kernel.org/linux-cve-announce/2025011141-CVE-2024-41149-7e9b@gregkh/

Introduced by commit 22465bb ("blk-mq: move cpuhp callback registering
out of q->sysfs_lock") in v6.13-rc2.
Fixed in v6.12.7.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.6

Fixed status
mainline: [b5792c162dcf6197bf3d2de2be6c8169435b73d0]
stable/6.6: [ee18012c80155f6809522804099621070c69ec72]

CVE-2024-41932: sched: fix warning in sched_setaffinity

Announce: https://lore.kernel.org/linux-cve-announce/2025011116-CVE-2024-41932-ed84@gregkh/

Introduced by commit 8f9ea86 ("sched: Always preserve the user
requested cpumask") in v6.2-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70ee7947a29029736a1a06c73a48ff37674a851b]

CVE-2024-41935: f2fs: fix to shrink read extent node in batches

Announce: https://lore.kernel.org/linux-cve-announce/2025011118-CVE-2024-41935-e11d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [3fc5d5a182f6a1f8bd4dc775feb54c369dd2c343]
stable/6.6: [295b50e95e900da31ff237e46e04525fa799b2cf]

CVE-2024-43098: i3c: Use i3cdev->desc->info instead of calling
i3c_device_get_info() to avoid deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2025011118-CVE-2024-43098-e732@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [6cf7b65f7029914dc0cd7db86fac9ee5159008c6]
stable/5.10: [5ac1dd51aaa0ce8b5421d1137e857955a4b6f55e]
stable/5.15: [2d98fa2a50b8058de52ada168fa5dbabb574711b]
stable/5.4: [9a2173660ee53d5699744f02e6ab7bf89fcd0b1a]
stable/6.1: [816187b1833908941286e71b0041059a4acd52ed]
stable/6.6: [ffe19e363c6f8b992ba835a361542568dea17409]

CVE-2024-45828: i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request

Announce: https://lore.kernel.org/linux-cve-announce/2025011119-CVE-2024-45828-8cbd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
i3c was introduced in 5.0.

Fixed status
mainline: [6ca2738174e4ee44edb2ab2d86ce74f015a0cc32]
stable/5.15: [a6cddf68b3405b272b5a3cad9657be0b02b34bf4]
stable/6.1: [9d745a56aea45e47f4755bc12e6429d6314dbb54]
stable/6.6: [a6dc4b4fda2e147e557050eaae51ff15edeb680b]

CVE-2024-46896: drm/amdgpu: don't access invalid sched

Announce: https://lore.kernel.org/linux-cve-announce/2025011141-CVE-2024-46896-8e7c@gregkh/

Introduced by commit 2320c9e ("drm/sched: memset() 'job' in
drm_sched_job_init()") in v6.13-rc1.
Fixed in v6.13-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [a93b1020eb9386d7da11608477121b10079c076a]
stable/6.1: [65501a4fd84ecdc0af863dbb37759242aab9f2dd]
stable/6.6: [da6b2c626ae73c303378ce9eaf6e3eaf16c9925a]

CVE-2024-47141: pinmux: Use sequential access to access desc->pinmux data

Announce: https://lore.kernel.org/linux-cve-announce/2025011119-CVE-2024-47141-13f5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [5a3e85c3c397c781393ea5fb2f45b1f60f8a4e6e]
stable/6.6: [2da32aed4a97ca1d70fb8b77926f72f30ce5fb4b]

CVE-2024-47143: dma-debug: fix a possible deadlock on radix_lock

Announce: https://lore.kernel.org/linux-cve-announce/2025011119-CVE-2024-47143-37ba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It looks as if this bug was introduced by commit 2d62ece ("dma-debug: add core
checking functions") in 2.6.30-rc1.

Fixed status
mainline: [7543c3e3b9b88212fcd0aaf5cab5588797bdc7de]
stable/5.10: [3ccce34a5c3f5c9541108a451657ade621524b32]
stable/5.15: [efe1b9bbf356357fdff0399af361133d6e3ba18e]
stable/6.1: [8c1b4fea8d62285f5e1a8194889b39661608bd8a]
stable/6.6: [c212d91070beca0d03fef7bf988baf4ff4b3eee4]

CVE-2024-47408: net/smc: check smcd_v2_ext_offset when receiving proposal msg

Announce: https://lore.kernel.org/linux-cve-announce/2025011141-CVE-2024-47408-e686@gregkh/

Introduced by commit 5c21c4c ("net/smc: determine accepted ISM
devices") in v5.10-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ab332deb671d8f7e66d82a2ff2b3f715bc3a4ad]
stable/5.15: [a36364d8d4fabb105001f992fb8ff2d3546203d6]
stable/6.1: [e1cc8be2a785a8f1ce1f597f3e608602c5fccd46]
stable/6.6: [935caf324b445fe73d7708fae6f7176fb243f357]

CVE-2024-47794: bpf: Prevent tailcall infinite loop caused by freplace

Announce: https://lore.kernel.org/linux-cve-announce/2025011120-CVE-2024-47794-09e9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [d6083f040d5d8f8d748462c77e90547097df936e]

CVE-2024-47809: dlm: fix possible lkb_resource null dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025011120-CVE-2024-47809-7b40@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It looks as if this bug was introduced by commit 9ac8ba46 ("fs: dlm:
handle -EINVAL as log_error()") in 6.1-rc7 and 43279e5 ("dlm: clear
defunct cancel state") in 2.6.30-rc1.

Fixed status
mainline: [b98333c67daf887c724cd692e88e2db9418c0861]
stable/6.6: [6fbdc3980b70e9c1c86eccea7d5ee68108008fa7]

CVE-2024-48873: wifi: rtw89: check return value of
ieee80211_probereq_get() for RNR

Announce: https://lore.kernel.org/linux-cve-announce/2025011120-CVE-2024-48873-75a9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It looks as if this bug was introduced by commit c6aa9a9c ("wifi: rtw89:
add RNR support for 6 GHz scan") in 6.4-rc1.

Fixed status
mainline: [630d5d8f2bf6b340202b6bc2c05d794bbd8e4c1c]
stable/6.6: [1a0f54cb3fea5d087440b2bae03202c445156a8d]

CVE-2024-48875: btrfs: don't take dev_replace rwsem on task already holding it

Announce: https://lore.kernel.org/linux-cve-announce/2025011121-CVE-2024-48875-5b79@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [8cca35cb29f81eba3e96ec44dad8696c8a2f9138]
stable/6.6: [a5bc4e030f50fdbb1fbc69acc1e0c5f57c79d044]

CVE-2024-48876: stackdepot: fix stack_depot_save_flags() in NMI context

Announce: https://lore.kernel.org/linux-cve-announce/2025011121-CVE-2024-48876-da61@gregkh/

Introduced by commit 4434a56 ("stackdepot: make fast paths lock-less
again") in v6.8-rc3.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [031e04bdc834cda3b054ef6b698503b2b97e8186]

CVE-2024-48881: bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again

Announce: https://lore.kernel.org/linux-cve-announce/2025011121-CVE-2024-48881-c4e5@gregkh/

Introduced by commit 028ddca ("bcache: Remove unnecessary NULL point
check in node allocations") in v6.5-rc1.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
mainline: [b2e382ae12a63560fca35050498e19e760adf8c0]
stable/5.10: [336e30f32ae7c043fde0f6fa21586ff30bea9fe2]
stable/5.15: [fb5fee35bdd18316a84b5f30881a24e1415e1464]
stable/5.4: [4379c5828492a4c2a651c8f826a01453bd2b80b0]
stable/6.1: [5202391970ffbf81975251b3526b890ba027b715]
stable/6.6: [cc05aa2c0117e20fa25a3c0d915f98b8f2e78667]

CVE-2024-49568: net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when
receiving proposal msg

Announce: https://lore.kernel.org/linux-cve-announce/2025011142-CVE-2024-49568-e5f6@gregkh/

Introduced by commit 8c3dca3 ("net/smc: build and send V2 CLC
proposal") in v5.10-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7863c9f3d24ba49dbead7e03dfbe40deb5888fdf]
stable/6.6: [295a92e3df32e72aff0f4bc25c310e349d07ffbf]

CVE-2024-49569: nvme-rdma: unquiesce admin_q before destroy it

Announce: https://lore.kernel.org/linux-cve-announce/2025011122-CVE-2024-49569-c532@gregkh/

Introduced by commit 958dc1d ("nvme-rdma: add clean action for failed
reconnection") in v5.12-rc1.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [5858b687559809f05393af745cbadf06dee61295]

CVE-2024-49571: net/smc: check iparea_offset and ipv6_prefixes_cnt
when receiving proposal msg

Announce: https://lore.kernel.org/linux-cve-announce/2025011142-CVE-2024-49571-c86d@gregkh/

Introduced by commit e7b7a64 ("smc: support variable CLC proposal
messages") in v4.16-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a29e220d3c8edbf0e1beb0f028878a4a85966556]
stable/5.10: [846bada23bfcdeb83621b045ed85dc06c7833ff0]
stable/5.15: [f10635268a0a49ee902a3b63b5dbb76f4fed498e]
stable/6.1: [62056d1592e63d85e82357ee2ae6a6a294f440b0]
stable/6.6: [91a7c27c1444ed4677b83fd5308d2cf03f5f0851]

CVE-2024-49573: sched/fair: Fix NEXT_BUDDY

Announce: https://lore.kernel.org/linux-cve-announce/2025011142-CVE-2024-49573-fa46@gregkh/

Introduced by commit 152e11f ("sched/fair: Implement delayed dequeue")
in v6.12-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [493afbd187c4c9cc1642792c0d9ba400c3d6d90d]

CVE-2024-50051: spi: mpc52xx: Add cancel_work_sync before module remove

Announce: https://lore.kernel.org/linux-cve-announce/2025011122-CVE-2024-50051-d822@gregkh/

Introduced by commit ca632f5 ("spi: reorganize drivers") in v3.1-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [984836621aad98802d92c4a3047114cf518074c8]
stable/5.10: [e0c6ce8424095c2da32a063d3fc027494c689817]
stable/5.15: [cd5106c77d6d6828aa82449f01f4eb436d602a21]
stable/5.4: [d0cde3911cf24e1bcdd4caa1d1b9ef57589db5a1]
stable/6.1: [373d55a47dc662e5e30d12ad5d334312f757c1f1]
stable/6.6: [f65d85bc1ffd8a2c194bb2cd65e35ed3648ddd59]

CVE-2024-51729: mm: use aligned address in copy_user_gigantic_page()

Announce: https://lore.kernel.org/linux-cve-announce/2025011143-CVE-2024-51729-799d@gregkh/

Introduced by commit 530dd99 ("mm: memory: improve
copy_user_large_folio()") in v6.11-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5d09de9f1bf9674c6418ff10d0a40cfe29268e1]

CVE-2024-52319: mm: use aligned address in clear_gigantic_page()

Announce: https://lore.kernel.org/linux-cve-announce/2025011143-CVE-2024-52319-61ca@gregkh/

Introduced by commit 78fefd0 ("mm: memory: convert clear_huge_page()
to folio_zero_user()") in v6.11-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8aca2bc96c833ba695ede7a45ad7784c836a262e]

CVE-2024-52332: igb: Fix potential invalid memory access in igb_init_module()

Announce: https://lore.kernel.org/linux-cve-announce/2025011122-CVE-2024-52332-9d2f@gregkh/

Introduced by commit bbd98fe ("igb: Fix DCA errors and do not use
context index for 82576") in v2.6.29-rc4.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0566f83d206c7a864abcd741fe39d6e0ae5eef29]
stable/5.10: [e0155b1b1509d0ef4799bd1cd73309ca466df3f3]
stable/5.15: [4fe517643f529e805bb6b890a4331c100e8f2484]
stable/5.4: [4458046617dfadc351162dbaea1945c57eebdf36]
stable/6.1: [8009cdcc493fa30d4572016daf2d6999da4d6c54]
stable/6.6: [f309733a8c9da7d4266a8a3755020b738a570cae]

CVE-2024-53680: ipvs: fix UB due to uninitialized stack access in
ip_vs_protocol_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025011123-CVE-2024-53680-88d4@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [146b6f1112eb30a19776d6c323c994e9d67790db]
stable/5.10: [0b2cbed82b7c6504a8a0fbd181f92dd56b432c12]
stable/5.15: [d6e1776f51c95827142f1d7064118e255e2deec1]
stable/5.4: [31d1ddc1ce8e8d3f101a679243abb42a313ee88a]
stable/6.1: [664d0feab92495b6a27edc3d1119e232c0fe8b2b]
stable/6.6: [124834133b32f9386bb2d8581d9ab92f65e951e4]

CVE-2024-53682: regulator: axp20x: AXP717: set ramp_delay

Announce: https://lore.kernel.org/linux-cve-announce/2025011157-CVE-2024-53682-263d@gregkh/

Introduced by commit d2ac3df ("regulator: axp20x: add support for the
AXP717") in v6.10-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f07ae52f5cf6a5584fdf7c8c652f027d90bc8b74]

CVE-2024-53685: ceph: give up on paths longer than PATH_MAX

Announce: https://lore.kernel.org/linux-cve-announce/2025011143-CVE-2024-53685-e6c3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc4.


Fixed status
mainline: [550f7ca98ee028a606aa75705a7e77b1bd11720f]
stable/6.6: [c47ed91156daf328601d02b58d52d9804da54108]

CVE-2024-53687: riscv: Fix IPIs usage in kfence_protect_page()

Announce: https://lore.kernel.org/linux-cve-announce/2025011157-CVE-2024-53687-5f05@gregkh/

Introduced by commit 47513f2 ("riscv: Enable KFENCE for riscv64") in v5.14-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3431a8bb336cece8adc452437befa7d4534b2fd]
stable/6.6: [6f796a6a396d6f963f2cc8f5edd7dfba2cca097f]

CVE-2024-53689: block: Fix potential deadlock while freezing queue and
acquiring sysfs_lock

Announce: https://lore.kernel.org/linux-cve-announce/2025011158-CVE-2024-53689-c526@gregkh/

Introduced by commit af28141 ("block: freeze the queue in
queue_attr_store") in v6.11-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be26ba96421ab0a8fa2055ccf7db7832a13c44d2]

CVE-2024-53690: nilfs2: prevent use of deleted inode

Announce: https://lore.kernel.org/linux-cve-announce/2025011144-CVE-2024-53690-8ad8@gregkh/

Introduced by commit d250065 ("nilfs2: pathname operations") in v2.6.30-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [901ce9705fbb9f330ff1f19600e5daf9770b0175]
stable/5.10: [5d4ed71327b0b5f3b179a19dc3c06be9509ab3db]
stable/5.15: [912188316a8c9e41b8c1603c2276a05043b14f96]
stable/5.4: [55e4baa0d32f0530ddc64c26620e1f2f8fa2724c]
stable/6.1: [ef942d233643777f7b2a5deef620e82942983143]
stable/6.6: [284760b320a0bac411b18108316939707dccb12b]

CVE-2024-54191: Bluetooth: iso: Fix circular lock in iso_conn_big_sync

Announce: https://lore.kernel.org/linux-cve-announce/2025011158-CVE-2024-54191-eeef@gregkh/

Introduced by commit 07a9342 ("Bluetooth: ISO: Send BIG Create Sync
via hci_sync") in v6.13-rc1.
Fixed in v6.13-rc3.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [7a17308c17880d259105f6e591eb1bc77b9612f0]

CVE-2024-54193: accel/ivpu: Fix WARN in ivpu_ipc_send_receive_internal()

Announce: https://lore.kernel.org/linux-cve-announce/2025011144-CVE-2024-54193-9ce6@gregkh/

Introduced by commit 8ed520f ("accel/ivpu: Move set autosuspend delay
to HW specific code") in v6.7-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f6482caa6acdfdfc744db7430771fe7e6c4e787]

CVE-2024-54455: accel/ivpu: Fix general protection fault in ivpu_bo_list()

Announce: https://lore.kernel.org/linux-cve-announce/2025011145-CVE-2024-54455-0e8e@gregkh/

Introduced by commit 37dee2a ("accel/ivpu: Improve buffer object debug
logs") in v6.8-rc2.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b2efb9db0c22a130bbd1275e489b42c02d08050]

CVE-2024-54460: Bluetooth: iso: Fix circular lock in iso_listen_bis

Announce: https://lore.kernel.org/linux-cve-announce/2025011158-CVE-2024-54460-c8c8@gregkh/

Introduced by commit 02171da ("Bluetooth: ISO: Add hcon for listening
bis sk") in v6.9-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [168e28305b871d8ec604a8f51f35467b8d7ba05b]

CVE-2024-54680: smb: client: fix TCP timers deadlock after rmmod

Announce: https://lore.kernel.org/linux-cve-announce/2025011145-CVE-2024-54680-db98@gregkh/

Introduced by commit ef7134c ("smb: client: Fix use-after-free of
network namespace.") in v6.12-rc7.
Fixed in v6.13-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [e9f2517a3e18a54a3943c098d2226b245d488801]
stable/6.6: [906807c734ed219dcb2e7bbfde5c4168ed72a3d0]

CVE-2024-54683: netfilter: IDLETIMER: Fix for possible ABBA deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2025011159-CVE-2024-54683-042e@gregkh/

Introduced by commit 0902b46 ("netfilter: xtables: idletimer target
implementation") in v2.6.36-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f36b01994d68ffc253c8296e2228dfe6e6431c03]
stable/6.6: [8c2c8445cda8f59c38dec7dc10509bcb23ae26a0]

CVE-2024-55639: net: renesas: rswitch: avoid use-after-put for a
device tree node

Announce: https://lore.kernel.org/linux-cve-announce/2025011159-CVE-2024-55639-b3d2@gregkh/

Introduced by commit b46f1e5 ("net: renesas: rswitch: Simplify struct
phy * handling") in v6.3-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66b7e9f85b8459c823b11e9af69dbf4be5eb6be8]
stable/6.6: [bf8c6755f02029d1eddc3ff19b870240f054afc7]

CVE-2024-55641: xfs: unlock inodes when erroring out of xfs_trans_alloc_dir

Announce: https://lore.kernel.org/linux-cve-announce/2025011159-CVE-2024-55641-fa58@gregkh/

Introduced by commit bd55621 ("xfs: Hold inode locks in
xfs_trans_alloc_dir") in v6.10-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53b001a21c9dff73b64e8c909c41991f01d5d00f]

CVE-2024-55642: block: Prevent potential deadlocks in zone write plug
error recovery

Announce: https://lore.kernel.org/linux-cve-announce/2025011100-CVE-2024-55642-29a8@gregkh/

Introduced by commit dd291d7 ("block: Introduce zone write plugging")
in v6.10-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe0418eb9bd69a19a948b297c8de815e05f3cde1]

CVE-2024-55881: KVM: x86: Play nice with protected guests in
complete_hypercall_exit()

Announce: https://lore.kernel.org/linux-cve-announce/2025011145-CVE-2024-55881-ad68@gregkh/

Introduced by commit b5aead0 ("KVM: x86: Assume a 64-bit hypercall for
guests with protected state") in v5.16-rc2.
Fixed in v6.13-rc4.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [9b42d1e8e4fe9dc631162c04caa69b0d1860b0f0]
stable/5.15: [0840d360a8909c722fb62459f42836afe32ededb]
stable/6.1: [7ed4db315094963de0678a8adfd43c46471b9349]
stable/6.6: [3d2634ec0d1dbe8f4b511cf5261f327c6a76f4b6]

CVE-2024-55916: Drivers: hv: util: Avoid accessing a ringbuffer not
initialized yet

Announce: https://lore.kernel.org/linux-cve-announce/2025011146-CVE-2024-55916-3a1f@gregkh/

Introduced by commit e0fa3e5 ("Drivers: hv: utils: fix a race on
userspace daemons registration") in v4.9-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07a756a49f4b4290b49ea46e089cbe6f79ff8d26]
stable/5.10: [d81f4e73aff9b861671df60e5100ad25cc16fbf8]
stable/5.15: [042253c57be901bfd19f15b68267442b70f510d5]
stable/5.4: [f091a224a2c82f1e302b1768d73bb6332f687321]
stable/6.1: [718fe694a334be9d1a89eed22602369ac18d6583]
stable/6.6: [89fcec5e466b3ac9b376e0d621c71effa1a7983f]

CVE-2024-56368: ring-buffer: Fix overflow in __rb_map_vma

Announce: https://lore.kernel.org/linux-cve-announce/2025011146-CVE-2024-56368-e3cd@gregkh/

Introduced by commit 117c392 ("ring-buffer: Introducing ring-buffer
mapping functions") in v6.10-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c58a812c8e49ad688f94f4b050ad5c5b388fc5d2]

CVE-2024-56369: drm/modes: Avoid divide by zero harder in drm_mode_vrefresh()

Announce: https://lore.kernel.org/linux-cve-announce/2025011146-CVE-2024-56369-be56@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc4.


Fixed status
mainline: [9398332f23fab10c5ec57c168b44e72997d6318e]
stable/5.15: [e7c7b48a0fc5ed83baae400a1b15e33978c25d7f]
stable/6.1: [69fbb01e891701e6d04db1ddb5ad49e42c4dd963]
stable/6.6: [b39de5a71bac5641d0fda33d1cf5682d82cf1ae5]

CVE-2024-56372: net: tun: fix tun_napi_alloc_frags()

Announce: https://lore.kernel.org/linux-cve-announce/2025011147-CVE-2024-56372-99e3@gregkh/

Introduced by commit de4f5fe ("iov_iter: add iter_iovec() helper") in v6.4-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [429fde2d81bcef0ebab002215358955704586457]
stable/6.6: [efe74dd58a72bd987b158142c904b7ef2ad132e2]

CVE-2024-56788: net: ethernet: oa_tc6: fix tx skb race condition
between reference pointers

Announce: https://lore.kernel.org/linux-cve-announce/2025011147-CVE-2024-56788-7a74@gregkh/

Introduced by commit 53fbde8 ("net: ethernet: oa_tc6: implement
transmit path to transfer tx ethernet frames") in v6.12-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e592b5110b3e9393881b0a019d86832bbf71a47f]

CVE-2024-57791: net/smc: check return value of sock_recvmsg when
draining clc data

Announce: https://lore.kernel.org/linux-cve-announce/2025011147-CVE-2024-57791-7bc8@gregkh/

Introduced by commit fb4f792 ("net/smc: tolerate future SMCD
versions") in v5.8-rc5.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5b8ee5022a19464783058dc6042e8eefa34e8cd]
stable/5.10: [82c7ad9ca09975aae737abffd66d1ad98874c13d]
stable/5.15: [6b80924af6216277892d5f091f5bfc7d1265fa28]
stable/6.1: [d7d1f986ebb284b1db8dafca7d1bdb6dd2445cf6]
stable/6.6: [7a6927814b4256d603e202ae7c5e38db3b338896]

CVE-2024-57792: power: supply: gpio-charger: Fix set charge current limits

Announce: https://lore.kernel.org/linux-cve-announce/2025011150-CVE-2024-57792-0002@gregkh/

Introduced by commit be2919d ("power: supply: gpio-charger: add
charge-current-limit feature") in v5.10-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afc6e39e824ad0e44b2af50a97885caec8d213d1]
stable/5.10: [b29c7783ac1fe36d639c089cf471ac7a46df05f0]
stable/5.15: [c3703d9340ca2820e1ac63256f4b423ea8559831]
stable/6.1: [6abbbd8286b6f944eecf3c74444c138590135211]
stable/6.6: [13eb3cae1d8e23cce96c095abe34da8028c09ac5]

CVE-2024-57793: virt: tdx-guest: Just leak decrypted memory on
unrecoverable errors

Announce: https://lore.kernel.org/linux-cve-announce/2025011150-CVE-2024-57793-4d57@gregkh/

Introduced by commit f4738f5 ("virt: tdx-guest: Add Quote generation
support using TSM_REPORTS") in v6.7-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27834971f616c5e154423c578fa95e0444444ce1]

CVE-2024-57798: drm/dp_mst: Ensure mst_primary pointer is valid in
drm_dp_mst_handle_up_req()

Announce: https://lore.kernel.org/linux-cve-announce/2025011151-CVE-2024-57798-68b5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.


Fixed status
mainline: [e54b00086f7473dbda1a7d6fc47720ced157c6a8]
stable/6.1: [f61b2e5e7821f868d6afc22382a66a30ee780ba0]
stable/6.6: [9735d40f5fde9970aa46e828ecc85c32571d58a2]

CVE-2024-57799: phy: rockchip: samsung-hdptx: Set drvdata before
enabling runtime PM

Announce: https://lore.kernel.org/linux-cve-announce/2025011151-CVE-2024-57799-ae66@gregkh/

Introduced by commit 553be28 ("phy: rockchip: Add Samsung HDMI/eDP
Combo PHY driver") in v6.9-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d23e48654620fdccfcc74cc2cef04eaf7353d07]

CVE-2024-57800: ALSA: memalloc: prefer dma_mapping_error() over
explicit address checking

Announce: https://lore.kernel.org/linux-cve-announce/2025011152-CVE-2024-57800-699a@gregkh/

Introduced by commit c880a51 ("ALSA: memalloc: Use proper DMA mapping
API for x86 WC buffer allocations") in v6.12-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa0308134d26dbbeb209a1581eea46df663866b6]

CVE-2024-57804: scsi: mpi3mr: Fix corrupt config pages PHY state is
switched in sysfs

Announce: https://lore.kernel.org/linux-cve-announce/2025011152-CVE-2024-57804-4bad@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.


Fixed status
mainline: [711201a8b8334a397440ac0b859df0054e174bc9]

CVE-2024-57805: ASoC: SOF: Intel: hda-dai: Do not release the link DMA on STOP

Announce: https://lore.kernel.org/linux-cve-announce/2025011152-CVE-2024-57805-fbae@gregkh/

Introduced by commit ab55937 ("ASoC: SOF: Intel: hda: Always clean up
link DMA during stop") in v6.12-rc5.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8d0ba147d901022bcb69da8d8fd817f84e9f3ca]

CVE-2024-57806: btrfs: fix transaction atomicity bug when enabling simple quotas

Announce: https://lore.kernel.org/linux-cve-announce/2025011153-CVE-2024-57806-0afb@gregkh/

Introduced by commit 182940f ("btrfs: qgroup: add new quota mode for
simple quotas") in v6.7-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2363e6fcc7938c5f0f6ac066fad0dd247598b51]

CVE-2024-57807: scsi: megaraid_sas: Fix for a potential deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2025011153-CVE-2024-57807-b595@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.
It looks as if this bug was introduced by commit ae6874b ("scsi: megaraid_sas:
Early detection of VD deletion through RaidMap update") in 5.14-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [50740f4dc78b41dec7c8e39772619d5ba841ddd7]
stable/5.10: [f36d024bd15ed356a80dda3ddc46d0a62aa55815]
stable/5.15: [3c654998a3e8167a58b6c6fede545fe400a4b554]
stable/5.4: [78afb9bfad00c4aa58a424111d7edbcab9452f2b]
stable/6.1: [edadc693bfcc0f1ea08b8fa041c9361fd042410d]
stable/6.6: [f50783148ec98a1d38b87422e2ceaf2380b7b606]

CVE-2024-57809: PCI: imx6: Fix suspend/resume support on i.MX6QDL

Announce: https://lore.kernel.org/linux-cve-announce/2025011103-CVE-2024-57809-a6be@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [0a726f542d7c8cc0f9c5ed7df5a4bd4b59ac21b3]

CVE-2024-57838: s390/entry: Mark IRQ entries to fix stack depot warnings

Announce: https://lore.kernel.org/linux-cve-announce/2025011105-CVE-2024-57838-4111@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [45c9f2b856a075a34873d00788d2e8a250c1effd]
stable/5.15: [ca687fdce5b95f84d91d6e36ac77047771eb3dfc]
stable/6.1: [5bb7a2c3afcf8732dc65ea49c09147b07da1d993]
stable/6.6: [1af22528fee8072b7adc007b8ca49cc4ea62689e]

CVE-2024-57839: Revert "readahead: properly shorten readahead when
falling back to do_page_cache_ra()"

Announce: https://lore.kernel.org/linux-cve-announce/2025011101-CVE-2024-57839-daf6@gregkh/

Introduced by commit 7c87758 ("readahead: properly shorten readahead
when falling back to do_page_cache_ra()") in v6.11-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a220d6b95b1ae12c7626283d7609f0a1438e6437]

CVE-2024-57843: virtio-net: fix overflow inside virtnet_rq_alloc

Announce: https://lore.kernel.org/linux-cve-announce/2025011103-CVE-2024-57843-1c15@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
This bug was introduced by commit f9dac92 ("virtio_ring: enable premapped mode
whatever use_dma_api") in 6.10-rc1.

Fixed status
mainline: [6aacd1484468361d1d04badfe75f264fa5314864]
stable/6.6: [a8f7d6963768b114ec9644ff0148dde4c104e84b]

CVE-2024-57849: s390/cpum_sf: Handle CPU hotplug remove during sampling

Announce: https://lore.kernel.org/linux-cve-announce/2025011103-CVE-2024-57849-64db@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [a0bd7dacbd51c632b8e2c0500b479af564afadf3]
stable/5.10: [99192c735ed4bfdff0d215ec85c8a87a677cb898]
stable/5.15: [06a92f810df8037ca36157282ddcbefdcaf049b8]
stable/5.4: [238e3af849dfdcb1faed544349f7025e533f9aab]
stable/6.1: [b5be6a0bb639d165c8418d8dddd8f322587be8be]
stable/6.6: [a69752f1e5de817941a2ea0609254f6f25acd274]

CVE-2024-57850: jffs2: Prevent rtime decompress memory corruption

Announce: https://lore.kernel.org/linux-cve-announce/2025011104-CVE-2024-57850-7e8d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [fe051552f5078fa02d593847529a3884305a6ffe]
stable/5.10: [f6fc251baefc3cdc4f41f2f5a47940d7d4a67332]
stable/5.15: [bd384b04ad1995441b18fe6c1366d02de8c5d5eb]
stable/5.4: [421f9e9f0fae9f8e721ffa07f22d9765fa1214d5]
stable/6.1: [47c9a7f81027a78afea9d2e9a54bfd8fabb6b3d0]
stable/6.6: [6808a1812a3419542223e7fe9e2de577e99e45d1]

CVE-2024-57872: scsi: ufs: pltfrm: Dellocate HBA during ufshcd_pltfrm_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2025011104-CVE-2024-57872-28ee@gregkh/

Introduced by commit 03b1781 ("[SCSI] ufs: Add Platform glue driver
for ufshcd") in v3.10-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [897df60c16d54ad515a3d0887edab5c63da06d1f]

CVE-2024-57874: arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGED_ADDR_CTRL

Announce: https://lore.kernel.org/linux-cve-announce/2025011113-CVE-2024-57874-539d@gregkh/

Introduced by commit 2200aa7 ("arm64: mte: ptrace: Add
NT_ARM_TAGGED_ADDR_CTRL regset") in v5.10-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca62d90085f4af36de745883faab9f8a7cbb45d3]
stable/5.10: [1152dd13845efde5554f80c7e1233bae1d26bd3e]
stable/5.15: [1c176f5155ee6161fee6f416b64aa50394d3f220]
stable/6.1: [1370cf3eb5495d70e00547598583a4cd45b40b99]
stable/6.6: [96035c0093db258975b8887676afe59a64c34a72]

CVE-2024-57875: block: RCU protect disk->conv_zones_bitmap

Announce: https://lore.kernel.org/linux-cve-announce/2025011107-CVE-2024-57875-7902@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
This bug was introduced by commit dd291d7 ("block: Introduce zone write
plugging") in 6.10-rc1.

Fixed status
mainline: [d7cb6d7414ea1b33536fa6d11805cb8dceec1f97]

CVE-2024-57876: drm/dp_mst: Fix resetting msg rx state after topology removal

Announce: https://lore.kernel.org/linux-cve-announce/2025011107-CVE-2024-57876-1d02@gregkh/

Introduced by commit 1d08261 ("drm/display/dp_mst: Fix down/up message
handling after sink disconnect") in v6.3-rc1.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [a6fa67d26de385c3c7a23c1e109a0e23bfda4ec7]
stable/6.1: [94b33b2d7640e807869451384eb88321dd0ffbd4]
stable/6.6: [d834d20d2e86c52ed5cab41763fa61e6071680ef]

CVE-2024-57877: arm64: ptrace: fix partial SETREGSET for NT_ARM_POE

Announce: https://lore.kernel.org/linux-cve-announce/2025011108-CVE-2024-57877-ee49@gregkh/

Introduced by commit 1751981 ("arm64/ptrace: add support for
FEAT_POE") in v6.12-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [594bfc4947c4fcabba1318d8384c61a29a6b89fb]

CVE-2024-57878: arm64: ptrace: fix partial SETREGSET for NT_ARM_FPMR

Announce: https://lore.kernel.org/linux-cve-announce/2025011108-CVE-2024-57878-465c@gregkh/

Introduced by commit 4035c22 ("arm64/ptrace: Expose FPMR via ptrace")
in v6.9-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5d71291841aecfe5d8435da2dfa7f58ccd18bc8]

CVE-2024-57879: Bluetooth: iso: Always release hdev at the end of iso_listen_bis

Announce: https://lore.kernel.org/linux-cve-announce/2025011131-CVE-2024-57879-7fa8@gregkh/

Introduced by commit 02171da ("Bluetooth: ISO: Add hcon for listening
bis sk") in v6.9-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c76fff747a73ba01d1d87ed53dd9c00cb40ba05]

CVE-2024-57880: ASoC: Intel: sof_sdw: Add space for a terminator into DAIs array

Announce: https://lore.kernel.org/linux-cve-announce/2025011134-CVE-2024-57880-c009@gregkh/

Introduced by commit 27fd36a ("ASoC: Intel: sof-sdw: Add new code for
parsing the snd_soc_acpi structs") in v6.10-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [255cc582e6e16191a20d54bcdbca6c91d3e90c5e]

CVE-2024-57881: mm/page_alloc: don't call pfn_to_page() on possibly
non-existent PFN in split_large_buddy()

Announce: https://lore.kernel.org/linux-cve-announce/2025011146-CVE-2024-57881-7516@gregkh/

Introduced by commit fd919a8 ("mm: page_isolation: prepare for
hygienic freelists") in v6.10-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faeec8e23c10bd30e8aa759a2eb3018dae00f924]

CVE-2024-36476: RDMA/rtrs: Ensure 'ib_sge list' is accessible

Announce: https://lore.kernel.org/linux-cve-announce/2025011531-CVE-2024-36476-b2a1@gregkh/

Introduced by commit 9cb8374 ("RDMA/rtrs: server: main functionality")
in v5.8-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb514b31395946022f13a08e06a435f53cf9e8b3]
stable/5.10: [7eaa71f56a6f7ab87957213472dc6d4055862722]
stable/5.15: [143378075904e78b3b2a810099bcc3b3d82d762f]
stable/6.1: [32e1e748a85bd52b20b3857d80fd166d22fa455a]
stable/6.6: [b238f61cc394d5fef27b26d7d9aa383ebfddabb0]

CVE-2024-39282: net: wwan: t7xx: Fix FSM command timeout issue

Announce: https://lore.kernel.org/linux-cve-announce/2025011532-CVE-2024-39282-491b@gregkh/

Introduced by commit 13e920d ("net: wwan: t7xx: Add core components")
in v5.19-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f619d518db9cd1a933c3a095a5f95d0c1584ae8]
stable/6.1: [b8ab9bd0c8855cd5a6f4e0265083576257ff3fc5]
stable/6.6: [0cd3bde081cd3452c875fa1e5c55834c670d6e05]

CVE-2024-53681: nvmet: Don't overflow subsysnqn

Announce: https://lore.kernel.org/linux-cve-announce/2025011532-CVE-2024-53681-e199@gregkh/

Introduced by commit 95409e2 ("nvmet: implement unique discovery NQN")
in v6.9-rc3.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4db3d750ac7e894278ef1cb1c53cc7d883060496]

CVE-2024-54031: netfilter: nft_set_hash: unaligned atomic read on
struct nft_set_ext

Announce: https://lore.kernel.org/linux-cve-announce/2025011532-CVE-2024-54031-f640@gregkh/

Introduced by commit 7ffc748 ("netfilter: nft_set_hash: skip
duplicated elements pending gc run") in v6.13-rc2.
Fixed in v6.13-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [542ed8145e6f9392e3d0a86a0e9027d2ffd183e4]
stable/5.10: [6a14b46052eeb83175a95baf399283860b9d94c4]
stable/5.15: [277f00b0c2dca8794cf4837722960bdc4174911f]
stable/5.4: [352f8eaaabd008f09d1e176194edc261a7304084]
stable/6.1: [607774a13764676d4b8be9c8b9c66b8cf3469043]
stable/6.6: [4f49349c1963e507aa37c1ec05178faeb0103959]

CVE-2024-57795: RDMA/rxe: Remove the direct link to net_device

Announce: https://lore.kernel.org/linux-cve-announce/2025011533-CVE-2024-57795-e560@gregkh/

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ac5415022d16d63d912a39a06f32f1f51140261]

CVE-2024-57801: net/mlx5e: Skip restore TC rules for vport rep without
loaded flag

Announce: https://lore.kernel.org/linux-cve-announce/2025011533-CVE-2024-57801-6479@gregkh/

Introduced by commit d156953 ("net/mlx5e: Modify and restore TC rules
for IPSec TX rules") in v6.6-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a03b368562a7ff5f5f1f63b5adf8309cbdbd5be]
stable/6.6: [3e45dd1622a2c1a83c11bf42fdd8c1810123d6c0]

CVE-2024-57802: netrom: check buffer length before accessing it

Announce: https://lore.kernel.org/linux-cve-announce/2025011533-CVE-2024-57802-c728@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4fd163aed2edd967a244499754dec991d8b4c7d]
stable/5.10: [cf6befa7c569787f53440274bbed1405fc07738d]
stable/5.15: [769e36c2119a51070faf58819c58274f57a088db]
stable/5.4: [64e9f54a14f2887be8634fb85cd2f13bec18a184]
stable/6.1: [78a110332ae268d0b005247c3b9a7d703b875c49]
stable/6.6: [f647d72245aadce30618f4c8fd3803904418dbec]

CVE-2024-57841: net: fix memory leak in tcp_conn_request()

Announce: https://lore.kernel.org/linux-cve-announce/2025011534-CVE-2024-57841-751f@gregkh/

Introduced by commit ff46e3b ("Fix race for duplicate reqsk on
identical SYN") in v6.10-rc6.
Fixed in v6.13-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [4f4aa4aa28142d53f8b06585c478476cfe325cfc]
stable/5.15: [9d38959677291552d1b0ed2689a540af279b5bf8]
stable/6.1: [de3f999bf8aee16e9da1c1224191abdc69e97c9d]
stable/6.6: [2af69905180b3fea12f9c1db374b153a06977021]

CVE-2024-57844: drm/xe: Fix fault on fd close after unbind

Announce: https://lore.kernel.org/linux-cve-announce/2025011534-CVE-2024-57844-a3cd@gregkh/

Introduced by commit 514447a ("drm/xe: Stop accumulating LRC timestamp
on job_free") in v6.12-rc7.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe39b222a4139354d32ff9d46b88757f63f71d63]

CVE-2024-57857: RDMA/siw: Remove direct link to net_device

Announce: https://lore.kernel.org/linux-cve-announce/2025011534-CVE-2024-57857-29db@gregkh/

Introduced by commit bdcf26b ("rdma/siw: network and RDMA core
interface") in v5.3-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16b87037b48889d21854c8e97aec8a1baf2642b3]

CVE-2024-57882: mptcp: fix TCP options overflow.

Announce: https://lore.kernel.org/linux-cve-announce/2025011507-CVE-2024-57882-8f05@gregkh/

Introduced by commit 1bff1e4 ("mptcp: optimize out option generation")
in v5.15-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbb26f7d8451fe56ccac802c6db48d16240feebd]
stable/6.1: [09ba95321a269019b5aa8e0c3bc80cf86d91fd18]
stable/6.6: [53fe947f67c93a5334aed3a7259fcc8a204f8bb6]

CVE-2024-57883: mm: hugetlb: independent PMD page table shared count

Announce: https://lore.kernel.org/linux-cve-announce/2025011510-CVE-2024-57883-b603@gregkh/

Introduced by commit 39dde65 ("[PATCH] shared page table for hugetlb
page") in v2.6.20.16.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59d9094df3d79443937add8700b2ef1a866b1081]

CVE-2024-57884: mm: vmscan: account for free pages to prevent infinite
Loop in throttle_direct_reclaim()

Announce: https://lore.kernel.org/linux-cve-announce/2025011510-CVE-2024-57884-4cf8@gregkh/

Introduced by commit 5a1c84b ("mm: remove reclaim and compaction retry
approximations") in v4.8-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6aaced5abd32e2a57cd94fd64f824514d0361da8]
stable/5.10: [d675fefbaec3815b3ae0af1bebd97f27df3a05c8]
stable/5.15: [63eac98d6f0898229f515cb62fe4e4db2430e99c]
stable/5.4: [66cd37660ec34ec444fe42f2277330ae4a36bb19]
stable/6.1: [bfb701192129803191c9cd6cdd1f82cd07f8de2c]
stable/6.6: [1ff2302e8aeac7f2eedb551d7a89617283b5c6b2]

CVE-2024-57885: mm/kmemleak: fix sleeping function called from invalid
context at print message

Announce: https://lore.kernel.org/linux-cve-announce/2025011510-CVE-2024-57885-ea46@gregkh/

Introduced by commit 3a6f33d ("mm/kmemleak: use %pK to display kernel
pointers in backtrace") in v6.2-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cddc76b165161a02ff14c4d84d0f5266d9d32b9e]
stable/6.6: [86d946f3f9992aaa12abcfd09f925446c2cd42a2]

CVE-2024-57886: mm/damon/core: fix new damon_target objects leaks on
damon_commit_targets()

Announce: https://lore.kernel.org/linux-cve-announce/2025011511-CVE-2024-57886-9059@gregkh/

Introduced by commit 9cb3d0b ("mm/damon/core: implement DAMON context
commit function") in v6.11-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8debfc5b1aa569d3d2ac836af2553da037611c61]

CVE-2024-57887: drm: adv7511: Fix use-after-free in adv7533_attach_dsi()

Announce: https://lore.kernel.org/linux-cve-announce/2025011511-CVE-2024-57887-db31@gregkh/

Introduced by commit 1e4d58c ("drm/bridge: adv7533: Create a MIPI DSI
device") in v4.8-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81adbd3ff21c1182e06aa02c6be0bfd9ea02d8e8]
stable/6.6: [1f49aaf55652580ae63ab83d67211fe6a55d83dc]

CVE-2024-57888: workqueue: Do not warn when cancelling WQ_MEM_RECLAIM
work from !WQ_MEM_RECLAIM worker

Announce: https://lore.kernel.org/linux-cve-announce/2025011511-CVE-2024-57888-0b38@gregkh/

Introduced by commit fca839c ("workqueue: warn if memory reclaim tries
to flush !WQ_MEM_RECLAIM workqueue") in v4.5-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de35994ecd2dd6148ab5a6c5050a1670a04dec77]

CVE-2024-57889: pinctrl: mcp23s08: Fix sleeping in atomic context due
to regmap locking

Announce: https://lore.kernel.org/linux-cve-announce/2025011512-CVE-2024-57889-a2a5@gregkh/

Introduced by commit 8f38910 ("pinctrl: mcp23s08: switch to regmap
caching") in v4.13-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a37eecb705f33726f1fb7cd2a67e514a15dfe693]
stable/5.10: [c55d186376a87b468c9ee30f2195e0f3857f61a0]
stable/5.15: [9372e160d8211a7e17f2abff8370794f182df785]
stable/5.4: [788d9e9a41b81893d6bb8faa05f045c975278318]
stable/6.1: [0310cbad163a908d09d99c26827859365cd71fcb]
stable/6.6: [8c6fd5803b988a5e78c9b9e42c70a936d7cfc6ec]

CVE-2024-57890: RDMA/uverbs: Prevent integer overflow issue

Announce: https://lore.kernel.org/linux-cve-announce/2025011512-CVE-2024-57890-aaf3@gregkh/

Introduced by commit 67cdb40 ("[IB] uverbs: Implement more commands")
in v2.6.20.16.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0257e089d1bbd35c69b6c97ff73e3690ab149a9]
stable/5.10: [42a6eb4ed7a9a41ba0b83eb0c7e0225b5fca5608]
stable/5.15: [c2f961c46ea0e5274c5c320d007c2dd949cf627a]
stable/5.4: [c57721b24bd897338a81a0ca5fff41600f0f1ad1]
stable/6.1: [346db03e9926ab7117ed9bf19665699c037c773c]
stable/6.6: [b92667f755749cf10d9ef1088865c555ae83ffb7]

CVE-2024-57891: sched_ext: Fix invalid irq restore in scx_ops_bypass()

Announce: https://lore.kernel.org/linux-cve-announce/2025011512-CVE-2024-57891-06ef@gregkh/

Introduced by commit 0e7ffff ("scx: Fix raciness in scx_ops_bypass()")
in v6.12-rc6.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18b2093f4598d8ee67a8153badc93f0fa7686b8a]

CVE-2024-57892: ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

Announce: https://lore.kernel.org/linux-cve-announce/2025011513-CVE-2024-57892-6d53@gregkh/

Introduced by commit 8f9e8f5 ("ocfs2: Fix Q_GETNEXTQUOTA for
filesystem without quotas") in v4.6-rc3.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f3fd772d152229d94602bca243fbb658068a597]
stable/6.6: [2e3d203b1adede46bbba049e497765d67865be18]

CVE-2024-57893: ALSA: seq: oss: Fix races at processing SysEx messages

Announce: https://lore.kernel.org/linux-cve-announce/2025011513-CVE-2024-57893-b263@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc6.


Fixed status
mainline: [0179488ca992d79908b8e26b9213f1554fc5bacc]
stable/6.1: [cff1de87ed14fc0f2332213d2367100e7ad0753a]
stable/6.6: [d2392b79d8af3714ea8878b71c66dc49d3110f44]

CVE-2024-57894: Bluetooth: hci_core: Fix sleeping function called from
invalid context

Announce: https://lore.kernel.org/linux-cve-announce/2025011513-CVE-2024-57894-fbfe@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.


Fixed status
mainline: [4d94f05558271654670d18c26c912da0c1c15549]
stable/6.1: [028a68886ead0764f4b26adfcaebf9f1955e76ea]
stable/6.6: [bef333418368c58690b501894324c09124e4614f]

CVE-2024-57895: ksmbd: set ATTR_CTIME flags when setting mtime

Announce: https://lore.kernel.org/linux-cve-announce/2025011514-CVE-2024-57895-9034@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.


Fixed status
mainline: [21e46a79bbe6c4e1aa73b3ed998130f2ff07b128]
stable/6.6: [1d7ee876b8b96efc14e177a7fe8d45ac25d68849]

CVE-2024-57896: btrfs: flush delalloc workers queue before stopping
cleaner kthread during unmount

Announce: https://lore.kernel.org/linux-cve-announce/2025011514-CVE-2024-57896-af67@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.


Fixed status
mainline: [f10bef73fb355e3fc85e63a50386798be68ff486]
stable/5.10: [a2718ed1eb8c3611b63f8933c7e68c8821fe2808]
stable/5.15: [63f4b594a688bf922e8691f0784679aa7af7988c]
stable/6.1: [1ea629e7bb2fb40555e5e01a1b5095df31287017]
stable/6.6: [35916b2f96505a18dc7242a115611b718d9de725]

CVE-2024-57897: drm/amdkfd: Correct the migration DMA map direction

Announce: https://lore.kernel.org/linux-cve-announce/2025011514-CVE-2024-57897-de29@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.
The svm_migrate_copy_to_vram was added by commit 0b0e518 ("drm/amdkfd:
HMM migrate
ram to vram") in 5.14-rc1. The svm_migrate_copy_to_ram was added by commit
48ff079 ("drm/amdkfd: HMM migrate vram to ram") in 5.14-rc1.

Fixed status
mainline: [5c3de6b02d38eb9386edf50490e050bb44398e40]
stable/5.15: [22d36ad92e5703e2e9bdf228990c0999d5d53ea3]
stable/6.1: [465b18e1c518e799593797d4603f4ab76de4e1d8]
stable/6.6: [d0fafe701c6aca785cc8685f9f76fdc73e662f47]

CVE-2024-57898: wifi: cfg80211: clear link ID from bitmap during link
delete after clean up

Announce: https://lore.kernel.org/linux-cve-announce/2025011515-CVE-2024-57898-bfde@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.


Fixed status
mainline: [b5c32ff6a3a38c74facdd1fe34c0d709a55527fd]

CVE-2024-57899: wifi: mac80211: fix mbss changed flags corruption on
32 bit systems

Announce: https://lore.kernel.org/linux-cve-announce/2025011515-CVE-2024-57899-0b1c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.
It looks as this bug was introduced by commit f81a9de ("mac80211: update mesh
beacon on workqueue") in 3.11-rc1.

Fixed status
mainline: [49dba1ded8dd5a6a12748631403240b2ab245c34]
stable/6.6: [86772872f9f5097cd03d0e1c6813238bd38c250b]

CVE-2024-57900: ila: serialize calls to nf_register_net_hooks()

Announce: https://lore.kernel.org/linux-cve-announce/2025011515-CVE-2024-57900-72ad@gregkh/

Introduced by commit 7f00fea ("ila: Add generic ILA translation
facility") in v4.5-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [260466b576bca0081a7d4acecc8e93687aa22d0e]
stable/5.10: [d3017895e393536b234cf80a83fc463c08a28137]
stable/5.15: [ad0677c37c14fa28913daea92d139644d7acf04e]
stable/5.4: [1638f430f8900f2375f5de45508fbe553997e190]
stable/6.1: [eba25e21dce7ec70e2b3f121b2f3a25a4ec43eca]
stable/6.6: [17e8fa894345e8d2c7a7642482267b275c3d4553]

CVE-2024-57901: af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK

Announce: https://lore.kernel.org/linux-cve-announce/2025011516-CVE-2024-57901-1f9e@gregkh/

Introduced by commit 79eecf6 ("af_packet: Handle outgoing VLAN packets
without hardware offloading") in v6.11-rc1.
Fixed in v6.13-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [f91a5b8089389eb408501af2762f168c3aaa7b79]
stable/5.10: [0d3fa6c3c9ca7aa255696150f5b759ac4a4974e1]
stable/5.15: [de4f8d477c67ec1d7c28f3486c3e47d147d90a01]
stable/5.4: [560cbdd26b510626f3f4f27d34c44dfd3dd3499d]
stable/6.1: [5d336714db324bef84490c75dcc48b387ef0346e]
stable/6.6: [a693b87692b4d7c50f4fc08a996678d60534a9da]

CVE-2024-57902: af_packet: fix vlan_get_tci() vs MSG_PEEK

Announce: https://lore.kernel.org/linux-cve-announce/2025011516-CVE-2024-57902-7ddb@gregkh/

Introduced by commit 79eecf6 ("af_packet: Handle outgoing VLAN packets
without hardware offloading") in v6.11-rc1.
Fixed in v6.13-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [77ee7a6d16b6ec07b5c3ae2b6b60a24c1afbed09]
stable/5.10: [fa57f07ba0622c8692f40e1300adca59277b0044]
stable/5.15: [65c67049e9ed481f6b52264b39618b8c6dfb1d3e]
stable/5.4: [66ffb0cf2125dcf9e902eede4a43653a24fd9cb2]
stable/6.1: [d91b4a9baa018a001d5c884e236c0cfd31f9f4a1]
stable/6.6: [7aa78d0d8546d8ce5a764add3f55d72e707c18f1]

CVE-2024-57903: net: restrict SO_REUSEPORT to inet sockets

Announce: https://lore.kernel.org/linux-cve-announce/2025011517-CVE-2024-57903-fd2a@gregkh/

Introduced by commit 8c7138b ("net: Unpublish sk from sk_reuseport_cb
before call_rcu") in v5.4-rc2.
Fixed in v6.13-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt

Fixed status
mainline: [5b0af621c3f6ef9261cf6067812f2fd9943acb4b]
stable/5.15: [579cfa595af1e00ccc9c3a849a4add6bba8b4bad]
stable/6.1: [ad2ad4cd11af9d63187cd074314b71b7cf8a2a59]
stable/6.6: [ad91a2dacbf8c26a446658cdd55e8324dfeff1e7]

CVE-2025-21629: net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets

Announce: https://lore.kernel.org/linux-cve-announce/2025011517-CVE-2025-21629-e230@gregkh/

Introduced by commit 04c20a9 ("net: skip offload for NETIF_F_IPV6_CSUM
if ipv6 header contains extension") in v6.12-rc6.
Fixed in v6.13-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [68e068cabd2c6c533ef934c2e5151609cf6ecc6d]
stable/6.1: [ac9cfef69565021c9e1022a493a9c40b03e2caf9]
stable/6.6: [95ccf006bbc8b59044313b8c309dcf29c546abd4]

CVE-2025-21630: io_uring/net: always initialize kmsg->msg.msg_inq upfront

Announce: https://lore.kernel.org/linux-cve-announce/2025011517-CVE-2025-21630-7665@gregkh/

Introduced by commit c6f32c7 ("io_uring/net: get rid of ->prep_async()
for receive side") in v6.10-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6e60a0a68b7e6b3c7e33863a16e8e88ba9eee6f]

* Updated CVEs

CVE-2024-26873: scsi: hisi_sas: Fix a deadlock issue related to automatic dump

stable/6.6 was fixed.

Fixed status
stable/6.6: [a47f0b03149af538af4442ff0702eac430ace1cb]
stable/6.8: [85c98073ffcfe9e46abfb9c66f3364467119d563]

CVE-2024-44985: ipv6: prevent possible UAF in ip6_xmit()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [c47e022011719fc5727bca661d662303180535ba]
stable/5.15: [975f764e96f71616b530e300c1bb2ac0ce0c2596]
stable/5.4: [b3a3d5333c13a1be57499581eab4a8fc94d57f36]
stable/6.1: [38a21c026ed2cc7232414cb166efc1923f34af17]
stable/6.10: [fc88d6c1f2895a5775795d82ec581afdff7661d1]
stable/6.6: [124b428fe28064c809e4237b0b38e97200a8a4a8]

CVE-2024-47726: f2fs: fix to wait dio completion

stable/6.6 was fixed.

Fixed status
stable/6.11: [e3db757ff9b7101ae68650ac5f6dd5743b68164e]
stable/6.6: [c2a7fc514637f640ff55c3f3e3ed879970814a3f]

CVE-2024-49998: net: dsa: improve shutdown sequence

stable/5.15 was fixed.

Fixed status
stable/5.15: [87bd909a7014e32790e8c759d5b7694a95778ca5]
stable/6.11: [b4a65d479213fe84ecb14e328271251eebe69492]

CVE-2024-50121: nfsd: cancel nfsd_shrinker_work using sync mode in
nfs4_state_shutdown_net

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f67138dd338cb564ade7d3755c8cd4f68b46d397]
stable/5.15: [5ade4382de16c34d9259cb548f36ec5c4555913c]
stable/6.1: [36775f42e039b01d4abe8998bf66771a37d3cdcc]
stable/6.11: [add1df5eba163a3a6ece11cb85890e2e410baaea]
stable/6.6: [f965dc0f099a54fca100acf6909abe52d0c85328]

CVE-2024-53099: bpf: Check validity of link->type in bpf_link_show_fdinfo()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [79f87a6ec39fb5968049a6775a528bf58b25c20a]
stable/5.15: [24fec234d2ba9ca3c14e545ebe3fd6dcb47f074d]
stable/6.1: [4e8074bb33d18f56af30a0252cb3606d27eb1c13]
stable/6.11: [b3eb1b6a9f745d6941b345f0fae014dc8bb06d36]
stable/6.6: [d5092b0a1aaf35d77ebd8d33384d7930bec5cb5d]

CVE-2024-53149: usb: typec: ucsi: glink: fix off-by-one in connector_status

stable/6.6 was fixed.

Fixed status
stable/6.12: [6ba6f7f29e0dff47a2799e60dcd1b5c29cd811a5]
stable/6.6: [8a2273e5c1beb285729aa001422967b4711c53fe]

CVE-2024-53164: net: sched: fix ordering of qlen adjustment

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [5e473f462a16f1a34e49ea4289a667d2e4f35b52]
stable/5.15: [33db36b3c53d0fda2699ea39ba72bee4de8336e8]
stable/5.4: [44782565e1e6174c94bddfa72ac7267cd09c1648]
stable/6.1: [489422e2befff88a1de52b2acebe7b333bded025]
stable/6.12: [e3e54ad9eff8bdaa70f897e5342e34b76109497f]
stable/6.6: [97e13434b5da8e91bdf965352fad2141d13d72d3]

CVE-2024-53179: smb: client: fix use-after-free of signing key

stable/6.6 was fixed.

Fixed status
stable/6.12: [0e2b654a3848bf9da3b0d54c1ccf3f1b8c635591]
stable/6.6: [39619c65ab4bbb3e78c818f537687653e112764d]

CVE-2024-56582: btrfs: fix use-after-free in btrfs_encoded_read_endio()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a40de0330af4fb7bc6b354250c24f294f8b826a0]
stable/6.12: [f8a5129e4a9fc3f6aa3f137513253b51b31b94d4]
stable/6.6: [6228f13f1996a4feb9b601d6644bf0bfe03671dd]

CVE-2024-56588: scsi: hisi_sas: Create all dump files during debugfs
initialization

stable/6.6 was fixed.

Fixed status
stable/6.12: [6c55f99123075e5429850b41b06f7dfffcb708eb]
stable/6.6: [7c8c50c9855a9e1b0d1e3680e5ad839002a9deb5]

CVE-2024-56599: wifi: ath10k: avoid NULL pointer error during sdio remove

stable/6.6 was fixed.

Fixed status
stable/6.12: [543c0924d446b21f35701ca084d7feca09511220]
stable/6.6: [b35de9e01fc79c7baac666fb2dcb4ba7698a1d97]

CVE-2024-56607: wifi: ath12k: fix atomic calls in
ath12k_mac_op_set_bitrate_mask()

stable/6.6 was fixed.

Fixed status
stable/6.12: [2093f062b26805789b73f2af214691475d9baa29]
stable/6.6: [3ed6b2daa4e9029987885f86835ffbc003d11c01]

CVE-2024-56609: wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb

stable/6.6 was fixed.

Fixed status
stable/6.12: [9bca6528f20325d30c22236b23116f161d418f6d]
stable/6.6: [3d94c4b21966b49c3e26ceeefacaa11ff7ee6d68]

CVE-2024-56616: drm/dp_mst: Fix MST sideband message body length check

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [109f91d8b9335b0f3714ef9920eae5a8b21d56af]
stable/5.15: [70e7166612f4e6da8d7d0305c47c465d88d037e5]
stable/6.1: [780fa184d4dc38ad6c4fded345ab8f9be7a63e96]
stable/6.12: [1fc1f32c4a3421b9d803f18ec3ef49db2fb5d5ef]
stable/6.6: [c58947a8d4a500902597ee1dbadf0518d7ff8801]

CVE-2024-56626: ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write

stable/5.15 was fixed.

Fixed status
stable/5.15: [1aea5c9470be2c7129704fb1b9562b1e3e0576f8]
stable/6.1: [8cd7490fc0f268883e86e840cda5311257af69ca]
stable/6.12: [c5797f195c67132d061d29c57a7c6d30530686f0]
stable/6.6: [164d3597d26d9acff5d5b8bc3208bdcca942dd6a]

CVE-2024-56627: ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read

stable/5.15 was fixed.

Fixed status
stable/5.15: [6bd1bf0e8c42f10a9a9679a4c103a9032d30594d]
stable/6.1: [de4d790dcf53be41736239d7ee63849a16ff5d10]
stable/6.12: [81eed631935f2c52cdaf6691c6d48e0b06e8ad73]
stable/6.6: [27de4295522e9a33e4a3fc72f7b8193df9eebe41]

CVE-2024-56694: bpf: fix recursive lock when verdict program return SK_PASS

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [221109ba2127eabd0aa64718543638b58b15df56]
stable/5.15: [6694f7acd625ed854bf6342926e771d65dad7f69]
stable/5.4: [078f7e1521442a55db4bed812a2fbaf02ac33819]
stable/6.1: [386efa339e08563dd33e83bc951aea5d407fe578]
stable/6.12: [f84c5ef6ca23cc2f72f3b830d74f67944684bb05]
stable/6.6: [da2bc8a0c8f3ac66fdf980fc59936f851a083561]

CVE-2024-56715: ionic: Fix netdev notifier unregister on failure

stable/5.15 was fixed.

Fixed status
stable/5.15: [87847938f5708b2509b279369c96572254bcf2ba]
stable/6.1: [da93a12876f8b969df7316dc93aac7e725f88252]
stable/6.12: [ee2e931b2b46de9af7f681258e8ec8e2cd81cfc6]
stable/6.6: [da5736f516a664a9e1ff74902663c64c423045d2]

CVE-2024-56716: netdevsim: prevent bad user input in
nsim_dev_health_break_write()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [81bdfcd6e6a998e219c9dd49ec7291c2e0594bbc]
stable/5.15: [b3a6daaf7cfb2de37b89fd7a5a2ad4ea9aa3e181]
stable/6.1: [d10321be26ff9e9e912697e9e8448099654ff561]
stable/6.12: [8e9ef6bdf71bf25f4735e0230ce1919de8985835]
stable/6.6: [470c5ecbac2f19b1cdee2a6ce8d5650c3295c94b]

CVE-2024-56759: btrfs: fix use-after-free when COWing tree bock and
tracing is enabled

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ba5120a2fb5f23b4d39d302e181aa5d4e28a90d1]
stable/5.15: [526ff5b27f090fb15040471f892cd2c9899ce314]
stable/6.1: [66376f1a73cba57fd0af2631d7888605b738e499]
stable/6.12: [c3a403d8ce36f5a809a492581de5ad17843e4701]
stable/6.6: [9a466b8693b9add05de99af00c7bdff8259ecf19]

CVE-2024-56761: x86/fred: Clear WFE in missing-ENDBRANCH #CPs

stable/6.6 was fixed.

Fixed status
stable/6.12: [b939f108e86b76119428a6fa4e92491e09ac7867]
stable/6.6: [151447859d6fb0dcce8259f0971c6e94fb801661]

CVE-2024-56763: tracing: Prevent bad count for tracing_cpumask_write

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2558d753df0628d4187d8e1fd989339460f4f364]
stable/5.15: [f60172b447317cb6c5e74b5601a151866269baf6]
stable/6.1: [3d15f4c2449558ffe83b4dba30614ef1cd6937c3]
stable/6.12: [1cca920af19df5dd91254e5ff35e68e911683706]
stable/6.6: [03041e474a6a8f1bfd4b96b164bb3165c48fa1a3]

CVE-2024-56766: mtd: rawnand: fix double free in atmel_pmecc_create_user()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [1562871ef613fa9492aa0310933eff785166a90e]
stable/5.15: [3d825a241e65f7e3072978729e79d735ec40b80e]
stable/5.4: [ca9818554b0f33e87f38e4bfa2dac056692d46cc]
stable/6.1: [6ea15205d7e2b811fbbdf79783f686f58abfb4b7]
stable/6.12: [d2f090ea57f8d6587e09d4066f740a8617767b3d]
stable/6.6: [dd45c87782738715d5e7c167f8dabf0814a7394a]

CVE-2024-56767: dmaengine: at_xdmac: avoid null_prt_deref in
at_xdmac_prep_dma_memset

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [ed1a8aaa344522c0c349ac9042db27ad130ef913]
stable/5.15: [8d364597de9ce2a5f52714224bfe6c2e7a29b303]
stable/5.4: [3d229600c54e9e0909080ecaf1aab0642aefa5f0]
stable/6.1: [fdba6d5e455388377ec7e82a5913ddfcc7edd93b]
stable/6.12: [54376d8d26596f98ed7432a788314bb9154bf3e3]
stable/6.6: [e658f1c133b854b2ae799147301d82dddb8f3162]

CVE-2024-56769: media: dvb-frontends: dib3000mb: fix uninit-value in
dib3000_write_reg

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [e11778189513cd7fb2edced5bd053bc18ede8418]
stable/5.15: [53106510736e734ce8b731ba871363389bfbf4c9]
stable/5.4: [035772fcd631eee2756b31cb6df249c0a8d453d7]
stable/6.1: [3876e3a1c31a58a352c6bf5d2a90e3304445a637]
stable/6.12: [c1197c1457bb7098cf46366e898eb52b41b6876a]
stable/6.6: [1d6de21f00293d819b5ca6dbe75ff1f3b6392140]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

