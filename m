Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1C6CD37AC
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 22:57:01 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.396.1778713013142197089
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 May 2026 15:56:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=iVrQ6wuM;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.45, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64d5a7926cfso7353569d50.2
        for <cip-dev@lists.cip-project.org>; Wed, 13 May 2026 15:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778713012; cv=none;
        d=google.com; s=arc-20240605;
        b=h7EPW7WtYY9uURAfdqMm6+CBfrMNR4GNxMULX/giNLrxl8aWTvDr6/QnAonowzfa3p
         +eqLgLE24kUPEa1tlp8VxstVX+n8vpzteHDp9XGxIRvQ0Vn2cthLxDxvNsAIJzmL8Pg+
         mdOU7ETIVdospPqRscc8w7qlLT3P7mWOROGmscO1dn7jfs5IkgGUvA1HaPLWLgcxX45h
         5rcDLbkXOFFUCbNO8Et1q1beM2khRuYTy0SI652zjRGK2143Aj/qMTnTFMfAj9eD5t9j
         i+Ly9nJLJSiLrhWhZ8Axd0efRLRRF3w35Oo6UHN04dQXfRJ1rybFWej0GlaklhED8rf+
         sO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7oPvk21HtfEPrTY8bkjw6yCQ+ZTDDhkYTbOTIh83X+A=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=SiKuM4lzDAmxm6KCFksAJqNaAG2lkE/hO+fV16KtDG38Mm598W/x63RlKiQIUsFzCu
         Zh4dKhc2CbGA4fFYZlFystkNEHnMz8CyW1JVgEVaHIcAdJXVizcZPXgEiZyv4noDv4X6
         FRq0BRFVtTXMsMEcop468SO8t9prNDchig0M5zjwdTSVGJQmcNvDIHNk91RpNcY4hD6D
         UjlAD0GjrAFS+QRI7J3QlOkSqoV862xXTh+FVKOKW8KfS9jFcpnZ8sKrkdHFGGtWm+8C
         EwCoVe2a1PeIy+/iD20qUP4yKCzyywd1OGdMS67L7Zzvvgi69hEW3sTBNLs9fZoh7vnX
         9pdQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1778713012; x=1779317812; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7oPvk21HtfEPrTY8bkjw6yCQ+ZTDDhkYTbOTIh83X+A=;
        b=iVrQ6wuM4MMVF/04605uMh2byXWo8ZKzJQaRf91BY2gcj1byxkCoEpJowJamNEZqlD
         CU/ixWHd5vnVEChXOeoT3dkQkBkC6GFozwl+bb6uYe91890za7GmAP7f6wsUlxA7bKKK
         LX1bZtWpJyQlZEDpJiy5Y6n+KF3ch8Pa9xY6FHitebW082RytE9o6o3SI9upZJGY1g0V
         qaTLHKq/CyhGRJlln/bcYe5TRaQC2B9uMfspqxsLUzfNuQUnV4O661wQGQ1tUlAMUF+d
         Zquueb8TF2/6S+DmtxoMY6We74GmEFK1swirTvz1bMRI8u28WuZV+nqrJoZCGYEwzHe/
         sLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713012; x=1779317812;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oPvk21HtfEPrTY8bkjw6yCQ+ZTDDhkYTbOTIh83X+A=;
        b=HsLwgA4HEmOFzmZaNQynmgfwS/wTbyQMX5d4NxOaj/lKJO7wT0mCN6hWWTnQx5pqqn
         NKuwnrLvY2k9e4Hf5LM8J0avVF4x78wzwCBGrTHwC+t670B1IUksJ2QjLNRMIX//rLty
         tm4xfd86gGNShj9mDJIiNQrYT91dapRO8Lm/KuRaE8NzjXgOblzaLijW2XdfJ7Kqioiw
         eht/OafvX+TfJe6M0PRmX+VfJ6GbFkrpA82vqhNwDleiL9xxd0oxnh+5MXmV5JlnVETc
         yiLTBlVm/OHCEZOmkTSfwQ57QCBFZX4gYMpcYrFEnpCCoepB4D1q2nvjX+YXZ3qg5yZv
         m6Tw==
X-Gm-Message-State: AOJu0YxEVow4VhWCFDMcbTVrIVWrIt7B2jBSzTy5dD/KwcRZRF1vO/cF
	qpAEEZ/SMIsYe6VbGfv+VBeIn3yGpDEIkEO0qJ91KndFIAVY3O4EF7GPHut0UU9QcgwIx4ngIDl
	s70uozVABXbJ+kn1ml6/hV2IsSoBiQkDbNCqEWmSnwDP3hb8MNvI04uAgJw==
X-Gm-Gg: Acq92OFOpKxJ5p7y+oKEmrQ57Bop63+RKgZuBp7X1UcgMSp839XLxKPZoy0nbwQm+kz
	BVqeD+QV6EEZCpGldZVzhQrZ5nA1ZE4l5guP0FNTmO3igmXLkEQBABcc1RgMHlPGBr2mU6sEsjd
	9Eeu38r3Lf8BJgKb/BXkg3445E/mBg9V3qVEeulMDoHvRJInK+vRCnu2BoLo0QEts1gUUwKJ/34
	CxNCSlO0deLL8IrLrUp/b34ivRr1fBVBnbykZmXJgMV79dtON0/dLVrTSMiFrEDEuovve+uR6qx
	v/EK+7HC
X-Received: by 2002:a05:690c:e3cd:b0:79e:766d:81df with SMTP id
 00721157ae682-7c6dc4aeb9dmr51744587b3.33.1778713009872; Wed, 13 May 2026
 15:56:49 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 May 2026 07:56:13 +0900
X-Gm-Features: AVHnY4LYdKEJKbBrE5CJMDG8DbKy83CnNfhSBjf9olCetEszv8qeWCU3qOav8CI
Message-ID: <CAODzB9pqnuo5_kS8-9oVcK5=erKeVw+PvOzQzA3ajr4RUJ=7Gg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 May 2026 22:57:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22931

Hi!

It's this week's CVE report.

This week reported 215 new CVEs and 7 updated CVEs.

* New CVEs
CVE-2026-43284: xfrm: esp: avoid in-place decrypt on shared skb frags

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43284


Fixed in master.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4c50a4034e62ab75f1d5cdd191dd5f9c77fdff4]
stable/5.10: [a6cb440f274a22456ef3e86b457344f1678f38f9]
stable/5.15: [ab8b995323e5237041472d07e5055f5f7dcdf15b]
stable/6.1: [5d55c7336f8032d434adcc5fab987ccc93a44aec]
stable/6.12: [b54edf1e9a3fd3491bdcb82a21f8d21315271e0d]
stable/6.18: [71a1d9d985d26716f74d21f18ee8cac821b06e97]
stable/6.6: [50ed1e7873100f77abad20fd31c51029bc49cd03]
stable/7.0: [52646cbd00e765a6db9c3afe9535f26218276034]

CVE-2025-71296: drm/tests: shmem: Hold reservation lock around purge

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71296

Introduced by commit 954907f ("drm/shmem-helper: Refactor
locked/unlocked functions") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f41307d589c2f25d556d47b165df808124cd0c4]
stable/6.18: [cdf8bbbd9017adcfb91ad9a902198d4b507719a9]

CVE-2025-71297: wifi: rtw88: 8822b: Avoid WARNING in rtw8822b_config_trx_mode()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71297

According to the .vulnerable file, this bug was introduced by commit
297bcf8 in v5.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44d1f624bbdd2d60319374ba85f7195a28d00c90]
stable/6.1: [7852ca1cc65ad43fb8b620e6a65d5cb15e4e4487]
stable/6.12: [0d0c2fb80ca4c284c397dd7546743a3b5fdf4020]
stable/6.18: [509becaee5680a39bde00c2c7d448dfeb39a8e05]
stable/6.6: [a96d161cfdb11cd2c35d5e498b93431164823338]

CVE-2025-71298: drm/tests: shmem: Hold reservation lock around madvise

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71298

Introduced by commit 954907f ("drm/shmem-helper: Refactor
locked/unlocked functions") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [607d07d8cc0b835a8701259f08a03dc149b79b4f]
stable/6.18: [9cc77691b5fd615625955cedf726da57543088f1]

CVE-2025-71299: spi: cadence-quadspi: Parse DT for flashes with the
rest of the DT parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71299

According to the .vulnerable file, this bug was introduced by commit
f1eb4e7 in v6.18.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f0736a4e136a6eb61e0cf530ddc18ab6d816ba3]
stable/6.18: [08dca4c8099a41a9fa3be128a793387603f73a17]

CVE-2025-71300: Revert "arm64: zynqmp: Add an OP-TEE node to the device tree"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71300

According to the .vulnerable file, this bug was introduced by commit
06d22ed in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c197179990124f991fca220d97fac56779a02c6d]
stable/6.12: [eece81eeda10eb42c687399fb5aa69977ae15664]
stable/6.18: [3983ef126e439900bbf419724a9759863c146660]

CVE-2025-71301: drm/tests: shmem: Hold reservation lock around vmap/vunmap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71301

Introduced by commit 954907f ("drm/shmem-helper: Refactor
locked/unlocked functions") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cda83b099f117f2a28a77bf467af934cb39e49cf]
stable/6.18: [6b953d92f2f29e74b125617c6f00300fa1bed97e]

CVE-2025-71302: drm/panthor: fix for dma-fence safe access rules

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71302

According to the .vulnerable file, this bug was introduced by commit
de85488 in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efe24898485c5c831e629d9c6fb9350c35cb576f]
stable/6.18: [ab8c0de60f16d7e0b162ccbbb35fcf1f277c97c2]

CVE-2026-43285: mm/slab: do not access current->mems_allowed_seq if !allow_spin

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43285

Introduced by commit af92793 ("slab: Introduce kmalloc_nolock() and
kfree_nolock().") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [144080a5823b2dbd635acb6decf7ab23182664f3]
stable/6.18: [353dd9934447b9193643ae1afd938607a74d4915]

CVE-2026-43286: mm/hugetlb: restore failed global reservations to subpool

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43286

Introduced by commit a833a69 ("mm: hugetlb: fix incorrect fallback for
subpool") in v6.15-rc7.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d3f9bb4c8af70304d19c22e30f5d16a2d589bb5]
stable/6.18: [5eac1322a7b14b8cd05ec896618278b90fba7f39]

CVE-2026-43287: drm: Account property blob allocations to memcg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43287

According to the .vulnerable file, this bug was introduced by commit
e2f5d2e in v4.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9d71f229f8dab0ce460e0b6eecad93d12fe62c8d]
mainline: [26b4309a3ab82a0697751cde52eb336c29c19035]
stable/5.10: [b6117210ed349356f8e6027ff020b4d620bca42b]
stable/5.15: [815fa29cab3c67bebb9d0b5f41145cdd3a14d04d]
stable/6.1: [866e0c1a9e7244d58ed74853cb22b81e1900cfdd]
stable/6.12: [8e1664b9ee43608eb973d357ae5d858d30cbc9ca]
stable/6.18: [cb8b9a1755fe9f38e4fb7f287486d7e7fab3dba4]
stable/6.6: [bbfaa5761f589a81031b493cb01275a990d6fb25]

CVE-2026-43288: ext4: move ext4_percpu_param_init() before ext4_mb_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43288

According to the .vulnerable file, this bug was introduced by commit
d5e03cb in v3.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [270564513489d98b721a1e4a10017978d5213bff]
stable/6.12: [9e9fb259bcddf459a0168f4a964e979e500a68a5]
stable/6.18: [bf5b609524497c195f801cd5707252384aed8149]
stable/6.6: [0d5fcb063cdabb9aeaa8554b7fedad2092c4150e]

CVE-2026-43289: kexec: derive purgatory entry from symbol

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43289

Introduced by commit 8652d44 ("kexec: support purgatories with
.text.hot sections") in v6.4-rc7.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
cip/4.19-st: [a45869d456fdbe698f4818b195fc337b961d3607]
mainline: [480e1d5c64bb14441f79f2eb9421d5e26f91ea3d]
stable/5.10: [027797595a108726f4a0a45d225f603b0ffbd22b]
stable/5.15: [1737d37ae1d2814e6cf0a1af87af3d41f0812b95]
stable/6.1: [f736032c638a33a243e9126e617788f763d648f9]
stable/6.12: [875355152b33436907c2a6d2ffad1431fa86c62b]
stable/6.18: [36eb314184a0ae74dd42914b47d2b9fc43be8034]
stable/6.6: [cfccd3b8c51bc57a8a6fcb2fd30453afae5bc0d2]

CVE-2026-43290: media: uvcvideo: Return queued buffers on
start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43290

Introduced by commit 7dd56c4 ("media: uvcvideo: Remove
stream->is_streaming field") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cf3b6fd54ebb1ebc977bdc47fb6cfcf9a471a22]
stable/6.18: [69c32df23bed6001864779b965fa009bcd9a26de]

CVE-2026-43291: net: nfc: nci: Fix parameter validation for packet data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43291

Introduced by commit 9c328f5 ("net: nfc: nci: Add parameter validation
for packet data") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [571dcbeb8e635182bb825ae758399831805693c2]
stable/5.15: [a24a8a582da4426b2042e510a1080df84083b51d]
stable/6.1: [f5218426f765eee22e178df9c126d974792fb6a5]
stable/6.12: [3b91160e9a91b5a2662875417dc42dc5b0bf03ea]
stable/6.18: [c692db813a7e3b7c3c17d6e9a3ad2a018bf1142b]
stable/6.6: [ad058a4317db7fdb3f09caa6ed536d24a62ce6a0]

CVE-2026-43292: mm/vmalloc: prevent RCU stalls in kasan_release_vmalloc_node

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43292

According to the .vulnerable file, this bug was introduced by commit
282631c in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5747435e0fd474c24530ef1a6822f47e7d264b27]
stable/6.12: [2efa9c02c9b4c0d6866aa445f11056809b25ca28]
stable/6.18: [1afe45f89d54b7183768ebbbbf14238ec187ab5c]

CVE-2026-43293: media: chips-media: wave5: Fix kthread worker
destruction in polling mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43293

Introduced by commit ed7276e ("media: chips-media: wave5: Add hrtimer
based polling support") in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a0c122e834b2f7f029526422c71be922960bf03]
stable/6.12: [156020e889edf4593870d926d3c4a6d06baac44a]
stable/6.18: [cc8071b1bac6568ea09d54be2d4f74dba80e17f8]

CVE-2026-43294: drm: renesas: rz-du: mipi_dsi: fix kernel panic when
rebooting for some panels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43294

According to the .vulnerable file, this bug was introduced by commit
7a043f9 in v6.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt

Fixed status
mainline: [64aa8b3a60a825134f7d866adf05c024bbe0c24c]
stable/6.18: [79f42487ed60d0d5ffce97c3bb98f80c3d17735a]

CVE-2026-43295: rapidio: replace rio_free_net() with kfree() in
rio_scan_alloc_net()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43295

Introduced by commit e6b585c ("rapidio: move net allocation into core
code") in v4.6-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8883d5f21c6d69eb47bb6e9f66b5350dfe9f3d17]
mainline: [666183dcdd9ad3b8156a1df7f204f728f720380f]
stable/5.10: [83e579c2f7f6b1706323d744833b26470049dcc2]
stable/5.15: [34a4f233df5eef5f1f113b2196142c0568b387f8]
stable/6.1: [fecf292c6691970897396190855aa38826b7104e]
stable/6.12: [87272e3e70ec4b666885bd520ff77463c11444ef]
stable/6.18: [e5a732bfe29451e16abf9c6f07ce5948b22f3d59]
stable/6.6: [649c2e853608cad0b0cba545555d168e67f094b3]

CVE-2026-43296: octeontx2-af: Workaround SQM/PSE stalls by disabling sticky

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43296

According to the .vulnerable file, this bug was introduced by commit
5d9b976 in v5.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70e9a5760abfb6338d63994d4de6b0778ec795d6]
stable/5.10: [9a3fd301329474f449e75f86d8a4f6b9c603fd6c]
stable/5.15: [d0b3c8a80336029d9356f429151eb27922d80a3c]
stable/6.1: [36cc5a5e0178d5fb79e04173b8aa623b0108819a]
stable/6.12: [cec2ceb35ce7bc874c43812bb39200d6cf691b87]
stable/6.18: [8052d0587fb14b85539c3a14a226586c0c3d6b4c]
stable/6.6: [d9b549b6951ba178ec14339a031cae65f4e43fe1]

CVE-2026-43297: media: rockchip: rga: Fix possible ERR_PTR dereference
in rga_buf_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43297

Introduced by commit 6040702 ("media: rockchip: rga: allocate DMA
descriptors per buffer") in v6.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81f8e0e6a2e115df9274d0289779f8fca694479c]
stable/6.12: [5da29ade540b51763b950987bd410add7edaf3d1]
stable/6.18: [1af2853b4e97fd95262fdef311b2334337069bc9]

CVE-2026-43298: drm/amdgpu: Skip vcn poison irq release on VF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43298

According to the .vulnerable file, this bug was introduced by commit
46d75d2 in v6.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8980be03b3f9a4b58197ef95d3b37efa41a25331]
stable/6.18: [8ee9aa80d4f1893a6699d46c403a1731548b544b]

CVE-2026-43299: btrfs: do not ASSERT() when the fs flips RO inside
btrfs_repair_io_failure()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43299

According to the .vulnerable file, this bug was introduced by commit
908960c in v3.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ceaad6cd6e7fa5f73b0b2796a2e85d75d37e9f3]

CVE-2026-43300: drm/panel: Fix a possible null-pointer dereference in
jdi_panel_dsi_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43300

According to the .vulnerable file, this bug was introduced by commit
2520508 in v6.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95eed73b871111123a8b1d31cb1fce7e902e49ea]
stable/6.12: [ec2f37bbb733cdd7ed7d04171fca728a532414d5]
stable/6.18: [2f5427d8726b22b807beec248d7d6bf88e291e0b]

CVE-2026-43301: media: chips-media: wave5: Fix PM runtime usage count underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43301

Introduced by commit 9707a62 ("media: chips-media: wave5: Add the v4l2
layer") in v6.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cf4452e824c1e2d41c9c0b13cc8a32a0a7dec38]
stable/6.18: [3a278a55ead50db2444c8f01410c7f5a68723990]

CVE-2026-43302: drm/v3d: Set DMA segment size to avoid debug warnings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43302

According to the .vulnerable file, this bug was introduced by commit
57692c9 in v4.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9eb018828b1b30dfba689c060735c50fc5b9f704]
stable/5.15: [14d0d6c8b4504a60cfeea74775ab2e0164019e65]
stable/6.1: [225023e3619b81af6d8d0e680503fc2d68633023]
stable/6.12: [cf510785f74e74c54de40a43a955b7f844857487]
stable/6.18: [0290934d30abe7c88e18140fd5184c3f386b1e44]
stable/6.6: [2663ef70c6123b2232190f917275e5c3175f97d0]

CVE-2026-43303: mm/page_alloc: clear page->private in free_pages_prepare()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43303

Introduced by commit 3b8000a ("mm/vmalloc: huge vmalloc backing pages
should be split rather than compound") in v5.18-rc4.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac1ea219590c09572ed5992dc233bbf7bb70fef9]
stable/6.18: [23b82b7a26182ad840ae67d390d7ec9771e8c00f]

CVE-2026-43304: libceph: define and enforce CEPH_MAX_KEY_LEN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43304

According to the .vulnerable file, this bug was introduced by commit
cd1a677 in v5.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac431d597a9bdfc2ba6b314813f29a6ef2b4a3bf]
stable/5.15: [6405e8c680974bb74e2c98d5249fb52c7b12a6c6]
stable/6.1: [8d745d38c88ecbed95f6b2b39857bf89f35a3244]
stable/6.12: [1b275bd49e58752efb83767a5d1aed41356c5e64]
stable/6.18: [c1a0f5f1e5e7e98c36a362ec3d1fcfd9932931ed]
stable/6.6: [e1dc45d97975f9db65694d234fbddf1915176e16]

CVE-2026-43305: drm/amd/display: Fix mismatched unlock for DMUB HW
lock in HWSS fast path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43305

According to the .vulnerable file, this bug was introduced by commit
7d04198 in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af3303970da5ce5bfe6dffdd07f38f42aad603e0]

CVE-2026-43306: bpf: crypto: Use the correct destructor kfunc type

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43306

According to the .vulnerable file, this bug was introduced by commit
3e1c6f3 in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b40a5d724f29fc2eed23ff353808a9aae616b48a]
stable/6.12: [4e3e57dbf46dad3498f8c4219ce2dba756875962]
stable/6.18: [50d6fd69388cc7b05dce72f09080674dcede4ac9]

CVE-2026-43307: iio: accel: adxl380: Avoid reading more entries than
present in FIFO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43307

Introduced by commit df36de1 ("iio: accel: add ADXL380 driver") in v6.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1b14015224cfcccd5356333763f2f4f401bd810]
stable/6.12: [a40f316085985f916ba1599fc303fdbc6a078e86]
stable/6.18: [a8e88edfd69df7b63c882aa53e61e7c078806ad7]

CVE-2026-43308: btrfs: don't BUG() on unexpected delayed ref type in
run_one_delayed_ref()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43308

According to the .vulnerable file, this bug was introduced by commit
5d4f98a in v2.6.31-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7d1d4ff56744074e005771aff193b927392d51f]

CVE-2026-43309: md raid: fix hang when stopping arrays with metadata
through dm-raid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43309

According to the .vulnerable file, this bug was introduced by commit
0dd84b3 in v6.0-rc3.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [cefcb9297fbdb6d94b61787b4f8d84f55b741470]
stable/6.18: [24783dd06de870d646c25207bae186f78195f912]

CVE-2026-43310: media: verisilicon: Avoid G2 bus error while decoding
H.264 and HEVC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43310

Introduced by commit cb5dd5a ("media: hantro: Introduce G2/HEVC
decoder") in v5.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0203ddf9af7c8e170e1e99ce83b4dc07f0cd765]

CVE-2026-43311: soc/tegra: pmc: Fix unsafe generic_handle_irq() call

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43311

According to the .vulnerable file, this bug was introduced by commit
0474cc8 in v6.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6d96073af681780820c94079b978474a8a44413]

CVE-2026-43312: media: i2c: ov5647: Initialize subdev before controls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43312

Introduced by commit 4974c2f ("media: ov5647: Support gain, exposure
and AWB controls") in v5.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eee13cbccacb6d0a3120c126b8544030905b069d]
stable/5.15: [f2a1998bc0053ebfe137f65081ed13afd9f34502]
stable/6.1: [59e372aa4cf60e2500eba7f978acdcb18bb49032]
stable/6.12: [2dedda97a64e7735844609c6c77c0dd953d73833]
stable/6.18: [8ecb21c20387cc0c8aa00489a21ccc69f6b0f5d1]
stable/6.6: [cabd025182cfed4a19b3aab57493e312d681e398]

CVE-2026-43313: ACPI: processor: Fix NULL-pointer dereference in
acpi_processor_errata_piix4()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43313

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f132e089fe89cadc2098991f0a3cb05c3f824ac6]
stable/5.15: [06724a60cfa9767ea90b0f5d3dfb5cdd251b64f5]
stable/6.1: [ad86ac604f8391c0212a91412d4f764c7a85f254]
stable/6.12: [b803811485ac0b2f774b6bf3abc8b999ba3b7033]
stable/6.18: [29f60d3d06818d40118a30d663231f027ae87a05]
stable/6.6: [01e8751b37a366b1ca561add0042f2ceb18c03bf]

CVE-2026-43314: dm: remove fake timeout to avoid leak request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43314

According to the .vulnerable file, this bug was introduced by commit
e6ee8c0 in v2.6.31-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3a9c95a15d2f4466acad5c68faeff79ca5e9f47]
stable/5.10: [ece6720de9403260088209b0b92d45e0b49ff856]
stable/5.15: [8200fca818c1e2f65bc6cb16d934ff6049302197]
stable/6.1: [b307b6307f6459841312432bd4bc9519cbac97f5]
stable/6.12: [cf2d06c9fd4b6521ea5b7f73c99c64c2c6f5e224]
stable/6.18: [6cdb21e0c9fdee484feba14fc9e72e9d07daf9f3]
stable/6.6: [4f9e7ca933a9fbf9912a384b061a00c77332cbf0]

CVE-2026-43315: KVM: nSVM: Remove a user-triggerable WARN on
nested_svm_load_cr3() succeeding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43315

Introduced by commit b222b0b ("KVM: nSVM: refactor the CR3 reload on
migration") in v5.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc3ba56385d03501eb582e4b86691ba378e556f9]
stable/5.15: [155ec243ef726f4bc49536fa0bfb565dc011ab17]
stable/6.1: [580ea57840864d40e019bc13fd26afdc8d510a2f]
stable/6.12: [ce904c8a5bbe697eae0f7e34b07095bd7a6dee19]
stable/6.18: [969e5e13ff5c18603f21d1f9f64ec9194e141ac0]
stable/6.6: [deb8f6dfd31d94b18dbeeaa8c01fbec5fc70fd2b]

CVE-2026-43316: media: solo6x10: Check for out of bounds chip_id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43316

According to the .vulnerable file, this bug was introduced by commit
faa4fd2 in v2.6.36-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [28e566d69f3cb39ba173c539dee1e28c06218ab5]
cip/4.4-st: [4700372d988c93ebbc18c497ee878db1f35fa3d6]
mainline: [0fdf6323c35a134f206dcad5babb4ff488552076]
stable/5.10: [c327192ca26670cf6e588c1eeda66cd2fa97630e]
stable/5.15: [0b3dadada2417782a63ce32dae05bafe1c949e3f]
stable/6.1: [603e3859393ee2ce91393b7d05e6e56e4b66e5cd]
stable/6.12: [5849ae68d7b8b6ad55cc1bf0d227dd2ae6362528]
stable/6.18: [d29f33b2cf98e4901cd5457d1ee34062e808df73]
stable/6.6: [33af366211ee78e3b074ff44a16121e537e86826]

CVE-2026-43317: most: core: fix leak on early registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43317

Introduced by commit 1f4c9d8 ("most: core: fix resource leak in
most_register_interface error paths") in v7.0-rc1.
Introduced by commit 723de0f ("staging: most: remove device from
interface structure") in v5.6-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [2c198c272f9c9213b0fdf6b4a879f445c574f416]
stable/6.12: [bbfe49ffb892bddf32c34bea95b7ff0fc30affb5]
stable/6.18: [f1ba620f9e8d7291f80c0554e4b820f5fb30e819]

CVE-2026-43318: drm/amdgpu: fix sync handling in amdgpu_dma_buf_move_notify

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43318

Introduced by commit a448cb0 ("drm/amdgpu: implement
amdgpu_gem_prime_move_notify v2") in v5.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b18fc0ab837381c1a6ef28386602cd888f2d9edf]
stable/6.12: [82a7ea35a1526bef8ae170c33ff80e5db7728961]
stable/6.18: [89a9389ad70d3c69538e59d87df67d407aef4c26]

CVE-2026-43319: spi: spidev: fix lock inversion between spi_lock and buf_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43319

According to the .vulnerable file, this bug was introduced by commit
a720416 in v6.2-rc4.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40534d19ed2afb880ecf202dab26a8e7a5808d16]
stable/6.12: [f8431b8672231d378b03176fe74c95adfd3522cf]
stable/6.18: [e341e18215030af2136836b78508e0d798916df7]

CVE-2026-43320: drm/amd/display: Fix dsc eDP issue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43320

According to the .vulnerable file, this bug was introduced by commit
3766a84 in v6.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [878a4b73c11111ff5f820730f59a7f8c6fd59374]
stable/6.12: [11718976c53a258c4d107aa05d68773379d0006f]
stable/6.18: [c10fe9471f3aa352bb9d9329d0b25e28e0672243]

CVE-2026-43321: bpf: Properly mark live registers for indirect jumps

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43321

According to the .vulnerable file, this bug was introduced by commit
493d9e0 in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1aab1ca576c90192ba961094d51b0be6355a4d6]
stable/6.18: [df02c3ff3be4bf998812c8c8e79d10db1329d535]

CVE-2026-43322: Bluetooth: hci_sync: Fix UAF in le_read_features_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43322

Introduced by commit a106e50 ("Bluetooth: HCI: Add support for LL
Extended Feature Set") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [035c25007c9e698bef3826070ee34bb6d778020c]

CVE-2026-43323: sched/fair: Fix zero_vruntime tracking fix

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43323

Introduced by commit b3d99f4 ("sched/fair: Fix zero_vruntime
tracking") in v7.0-rc2.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [1319ea57529e131822bab56bf417c8edc2db9ae8]
stable/6.12: [c089147074ed96ff4330739a0559394c19a3dfc8]
stable/6.18: [87573883c30f1a8555ff720836bb6ea231058539]

CVE-2026-43324: USB: dummy-hcd: Fix interrupt synchronization error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43324

Introduced by commit 04145a0 ("USB: UDC: Implement udc_async_callbacks
in dummy-hcd") in v5.14-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ca9e46f8f1f5a297eb0ac83f79d35d5b3a02541]
stable/5.15: [d847f375b1bcea713143bc02720d13d2d01b012a]
stable/6.1: [cbf7df5e5d27cd5bea92ee9a75a4b28dbcc718d4]
stable/6.12: [94d4fab1dd9e64f45449bcc7d6a5acf796b13015]
stable/6.18: [5687a09776069bd915560021c9728ca528440128]
stable/6.6: [5aa776c8615bea3b1eaeec87b0788375800ead4f]

CVE-2026-43325: wifi: iwlwifi: mvm: don't send a 6E related command
when not supported

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43325

Introduced by commit 0d2fc88 ("wifi: iwlwifi: nvm: parse the VLP/AFC
bit from regulatory") in v6.9-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [323156c3541e23da7e582008a7ac30cd51b60acd]
stable/6.18: [c0b3fa5e0eaecd38e6a9f8f78e86f468fbde719a]

CVE-2026-43326: sched_ext: Fix SCX_KICK_WAIT deadlock by deferring
wait to balance callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43326

Introduced by commit 90e5516 ("sched_ext: Implement SCX_KICK_WAIT") in
v6.12-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [415cb193bb9736f0e830286c72a6fa8eb2a9cc5c]

CVE-2026-43327: USB: dummy-hcd: Fix locking/synchronization error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43327

Introduced by commit 7dbd8f4 ("USB: dummy-hcd: Fix erroneous
synchronization change") in v4.14-rc4.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [4989d93a9d014e552ba6b9517703e74abb2aca91]
mainline: [616a63ff495df12863692ab3f9f7b84e3fa7a66d]
stable/5.10: [6350c7dd33ab481ef41c931a238361490c32d15c]
stable/5.15: [cc97fb5969177cccce2e23b31298df220fc7570d]
stable/6.1: [218886b2ef2dea7627d3700ab0abaf4bf9d1161f]
stable/6.12: [805b1833d6ed6da5086e610578a28e71bb54fbbb]
stable/6.18: [efbd9441f1e769a7aae1813d497cec09cbdff031]
stable/6.6: [791966f85b439b261bf19865cf1c07c065ffb4b4]

CVE-2026-43328: cpufreq: governor: fix double free in
cpufreq_dbs_governor_init() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43328

Introduced by commit 4ebe36c ("cpufreq: Fix kobject memleak") in v5.2-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [eee0b6c9cfcc3ca1c819dd5d6656e700874552c2]
mainline: [6dcf9d0064ce2f3e3dfe5755f98b93abe6a98e1e]
stable/5.10: [56bc91ee78babe9578585a2bc137abc4b3115ff3]
stable/6.1: [019ea28629720c220daedf38107c8787f330dc05]
stable/6.12: [427d048e4f6acbfa01b5a8062449fe0ee8987c0d]
stable/6.18: [d2703b4f8fb7cc6f0dfdb2dc2359cc46189e7357]
stable/6.6: [da39ee627fd82b52068d4d5f115749a8b7d271f9]

CVE-2026-43329: netfilter: flowtable: strictly check for maximum
number of actions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43329

Introduced by commit c29f74e ("netfilter: nf_flow_table: hardware
offload support") in v5.5-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76522fcdbc3a02b568f5d957f7e66fc194abb893]
stable/5.15: [ead66c77303f760f6c30be96e2e20d5a77cef614]
stable/6.1: [fe9018d3e94329f1951b00805a8640bc06f56ead]
stable/6.12: [57c78bd2e2dd08897acd35b2bf8bcef322e36f5e]
stable/6.18: [504c9456699dcf4d15195ef34a0fa94a80bfc877]
stable/6.6: [5382bb03e9c33b089d60788478b922a2dca284cc]

CVE-2026-43330: crypto: caam - fix overflow on long hmac keys

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43330

Introduced by commit 199354d ("crypto: caam - Remove GFP_DMA and add
DMA alignment padding") in v6.3-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80688afb9c35b3934ce2d6be9973758915e2e0ef]
stable/6.12: [c2fb4984fe09fc176fe4c12d5e3edf626df6511d]
stable/6.18: [aa545df011338df13f0833fc1fabcb15c0521959]
stable/6.6: [31022cfde5235c45fa765f0aabeff5f0652852f2]

CVE-2026-43331: x86/kexec: Disable KCOV instrumentation after load_segments()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43331

Introduced by commit 0d34599 ("x86/kernel: increase kcov coverage
under arch/x86/kernel folder") in v6.6-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [917e3ad3321e75ca0223d5ccf26ceda116aa51e1]
stable/6.18: [1e3e98596c2769721ade0418434852fb3af4849a]

CVE-2026-43332: thermal: core: Fix thermal zone device registration error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43332

Introduced by commit 04e6ccf ("thermal: core: Fix NULL pointer
dereference in zone registration error path") in v6.8-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [9e07e3b81807edd356e1f794cffa00a428eff443]
stable/6.12: [604da9c04c218362e1c1457304ebeb9c199d537c]
stable/6.18: [c4c7219e93319bba9ba0765dee597784c78f63c5]
stable/6.6: [9e796001af97a1f7368d5114b7a8533dd98d797a]

CVE-2026-43333: bpf: reject direct access to nullable PTR_TO_BUF pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43333

Introduced by commit 20b2aff ("bpf: Introduce MEM_RDONLY flag") in v5.17-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [b0db1accbc7395657c2b79db59fa9fae0d6656f3]
stable/5.15: [10bc4a4dcded509c5d5c67d497900c3922c604cd]
stable/6.1: [21a10c06ffae24cb01fd174a7ab7736001d2ea56]
stable/6.12: [70abd9d118da2f56beb4ec22e3a29becae373535]
stable/6.18: [63276547debc4d8a73eefb2c5273b2a905c961b0]
stable/6.6: [8755066f7bd0f4ac46a29d1708c7b20894539252]

CVE-2026-43334: Bluetooth: SMP: force responder MITM requirements
before building the pairing response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43334

Introduced by commit 2b64d15 ("Bluetooth: Add MITM mechanism to
LE-SMP") in v3.3-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b90f1bd010c589ced75d3ab1683a5627fff0aeca]
mainline: [d05111bfe37bfd8bd4d2dfe6675d6bdeef43f7c7]
stable/5.10: [425a22c5373d4e1b46492ab869074ebeeade61f3]
stable/5.15: [7ab69426e7ecbd18a222ee2ec87ca612d30197d7]
stable/6.1: [01bb4045d2306c266178f49ce0c3576d237a3040]
stable/6.12: [c8ff0ca6508535bccabd81c5c9dcc63de8a3d4fb]
stable/6.18: [fa14e0e19820b1bbdb42185c9c4efa950bcffef9]
stable/6.6: [91649c02c1baaa18cedf7fb425fa1f0f852c8183]

CVE-2026-43335: interconnect: qcom: sm8450: Fix NULL pointer
dereference in icc_link_nodes()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43335

Introduced by commit 51513be ("interconnect: qcom: sm8450: convert to
dynamic IDs") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbbd550d7c8d90d3af9fe8a12a9caff077ddb8e3]

CVE-2026-43336: lib/crypto: chacha: Zeroize permuted_state before it
leaves scope

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43336

Introduced by commit c08d0e6 ("crypto: chacha20 - Add a generic
ChaCha20 stream cipher implementation") in v4.2-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5046823f8fa3677341b541a25af2fcb99a5b1e0]
stable/5.10: [e90ee961af515a484f091678ce58a4c3f7b73b02]
stable/5.15: [b416a4245f04a450c67a13e6d96056c37c5b33fe]
stable/6.1: [bd62d9b44464a6c20a34a74068e7a784d0afa04a]
stable/6.12: [1d761e5a7340c46479fb2399598f331e4fe2c633]
stable/6.18: [1933249263c3a98df79992f61a566476e4163bcc]
stable/6.6: [066c760acead1fb743bae294dbd89f479ae43b9b]

CVE-2026-43337: drm/amd/display: Fix NULL pointer dereference in
dcn401_init_hw()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43337

Introduced by commit ca0fb24 ("drm/amd/display: Underflow Seen on
DCN401 eGPU") in v6.12-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e927b36ae18b66b49219eaa9f46edc7b4fdbb25e]
stable/6.18: [10c13c111d0d7f8e101c742feff264fc98e3f9f7]

CVE-2026-43338: btrfs: reserve enough transaction items for qgroup ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43338

According to the .vulnerable file, this bug was introduced by commit
5d13a37 in v3.6-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9a4e3015db1aeafbef407650eb8555445ca943e]
stable/6.12: [bb6eb33c908edbbb4d92abdc0c6c87f21b4952e8]
stable/6.18: [cf930a651eef6f8d915bf0ccd60c2045974f870c]

CVE-2026-43339: ipv6: prevent possible UaF in addrconf_permanent_addr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43339

Introduced by commit f1705ec ("net: ipv6: Make address flushing on
ifdown optional") in v4.6-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b3f73c594f69c127e354a46ab033eba579df9492]
mainline: [fd63f185979b047fb22a0dfc6bd94d0cab6a6a70]
stable/5.10: [eec49a33611f20336b357b3953df44f1a02049e8]
stable/5.15: [bacc7f31085c9820922f00bc7d79756ffa13123a]
stable/6.1: [7bfafa1b0cd582983ebec6bb20f0a435528fe567]
stable/6.12: [25357b670afb5b517096da783abaa5cc4bf8359e]
stable/6.18: [3cd4efb5df72843dfac892d0b3c7a4a8bd926b65]
stable/6.6: [7d9f2f4aabd116ca68fbdab5d8fb8dac74c2ea1e]

CVE-2026-43340: comedi: Reinit dev->spinlock between attachments to
low-level drivers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43340

Introduced by commit ed9eccb ("Staging: add comedi core") in v2.6.29-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [69b6bdb8cd77e381557878a1dc6037ed875ade03]
mainline: [4b9a9a6d71e3e252032f959fb3895a33acb5865c]
stable/5.10: [3181c34b415c5464be9d34bff3e43ef63b747039]
stable/5.15: [2b1f49e4fdff3ef0f8e9158bbb5b149e06287560]
stable/6.1: [4d5ffe524903a30e2e0da7d16841a56bec2de55c]
stable/6.12: [430291d8f3884f57ae0057049b0ca291453e29e1]
stable/6.18: [b89c026227712c367950bbae055a5b31073d3b30]
stable/6.6: [c01bcc67a9a692d65508ebd480405b5e77d562b7]

CVE-2026-43341: net/ipv6: ioam6: prevent schema length wraparound in trace fill

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43341

Introduced by commit 8c6f6fa ("ipv6: ioam: IOAM Generic Netlink API")
in v5.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e67ba9bb531e1ec6599a82a065dea9040b9ce50]
stable/6.1: [e96d48b37708d53cbdc47f6f60b0714fc4a5f596]
stable/6.12: [77695a69baca9b99d95fad09fc78c2318736604f]
stable/6.18: [184d2e9db27c0f76226b5cad16fe29510a5d2280]
stable/6.6: [d1b041080086e91d3733a5438a8c51ad5d3d8e09]

CVE-2026-43342: usb: gadget: f_rndis: Protect RNDIS options with mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43342

Introduced by commit 73517cf ("usb: gadget: add RNDIS configfs options
for class/subclass/protocol") in v4.14-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d8c68b1fc06ece60cf43e1306ff0f4ac121547e]
stable/5.10: [0a75d97c53477a59c0aa1c65f69038c719f9c5b8]
stable/5.15: [c1b3d5b0acb194efe20fc5864ee03439fa7bd45c]
stable/6.1: [65b7dbf80a1627667c241fff7c1c224f3118014f]
stable/6.12: [7d8fa3b8783ab95a46e20d97fbeeede719b2efda]
stable/6.18: [446f1842cda929c40d4697722bfdcfb334bc9692]
stable/6.6: [cb5316b37288ab8791584e32f114c4f41ad45b67]

CVE-2026-43343: usb: gadget: f_subset: Fix unbalanced refcnt in geth_free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43343

Introduced by commit 02832e5 ("usb: gadget: f_subset: add configfs
support") in v3.11-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [caa27923aacd8a5869207842f2ab1657c6c0c7bc]
stable/5.10: [a932b171554714b1bca313b853c7aa9f2930f9aa]
stable/5.15: [d7d702407b61e96286a15b6e715572f541a8d41c]
stable/6.1: [3f5bfc550a40d7493b1cf09540ed6b412b3b82be]
stable/6.12: [cc8ec610cd14c093a19371691a7ce1ee5421e829]
stable/6.18: [3d436670b47415da042452618fb5d8e317ab095f]
stable/6.6: [75776a055b656873319c3830fed471daef3ceb23]

CVE-2026-43344: perf/x86/intel/uncore: Fix die ID init and look up bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43344

Introduced by commit 9a7832c ("perf/x86/intel/uncore: With > 8 nodes,
get pci bus die id from NUMA info") in v5.12-rc1.
Introduced by commit 65248a9 ("perf/x86/uncore: Add a quirk for UPI on
SPR") in v6.3-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a16d1ec4dd0cdcf689f324adde6067083bce9099]

CVE-2026-43345: net: ipa: fix event ring index not programmed for IPA v5.0+

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43345

Introduced by commit faf0678 ("net: ipa: add IPA v5.0 GSI register
definitions") in v6.4-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56007972c0b1e783ca714d6f1f4d6e66e531d21f]
stable/6.12: [2bf18b643c4656413f7cfd5615af60a6b4e261da]
stable/6.18: [2d2dc166d55148cfcf8ae67b415f8d6d110e6fca]
stable/6.6: [ae8343a19ccb051d519dbb3a9082ddea9f0551d3]

CVE-2026-43346: ice: ptp: don't WARN when controlling PF is unavailable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43346

Introduced by commit e800654 ("ice: Use ice_adapter for PTP shared
data instead of auxdev") in v6.13-rc1.
Fixed in v7.0.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [bb3f21edc7056cdf44a7f7bd7ba65af40741838c]
stable/6.18: [e19675b384e9dcaca1bd5e4a67b8ad136eccfbe8]

CVE-2026-43347: arm64: dts: qcom: monaco: Reserve full Gunyah metadata region

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43347

Introduced by commit 7be190e ("arm64: dts: qcom: add QCS8300
platform") in v6.14-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85d98669fa7f1d3041d962515e45ee6e392db6f8]
stable/6.18: [edde62571f7602d83243ca51729ce42d22ea04d2]

CVE-2026-43348: mshv_vtl: Fix vmemmap_shift exceeding MAX_FOLIO_ORDER

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43348

Introduced by commit 7bfe3b8 ("Drivers: hv: Introduce mshv_vtl
driver") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [404cd6bffe17e25e0f94ed2775ffdd6cd10ac3fd]
stable/7.0: [a142ca4b6481e71498712800b20e0c0fcf02843b]

CVE-2026-43349: f2fs: fix to avoid uninit-value access in
f2fs_sanity_check_node_footer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43349

Introduced by commit 50ac3ec ("f2fs: fix to do sanity check on node
footer in {read,write}_end_io") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [7b9161a605e91d0987e2596a245dc1f21621b23f]
stable/6.18: [59970b2586fef4b13e96527b9d232bed30b640cd]
stable/7.0: [a10b89343d41ceee1af0ec38d3a74e526c77fa09]

CVE-2026-43350: smb: client: require a full NFS mode SID before
reading mode bits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43350

Introduced by commit e2f8fbf ("cifs: get mode bits from special sid on
stat") in v5.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2757ad3e4b6f9e0fed4c7739594e702abc5cab21]
stable/6.12: [c8eef12af1cc73031639ea7cf16e0b10e2536b0b]
stable/6.18: [38a69f08ee82c450d3e4168707fff2e317dc3ff7]
stable/6.6: [b53b8e98c23310294fc45fc686db5ee860311896]
stable/7.0: [f8488c07bea2431ee12a6067d736578064fa46b4]

CVE-2026-43351: KVM: arm64: Eagerly init vgic dist/redist on vgic creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43351

Introduced by commit b3aa928 ("KVM: arm64: vgic: Hoist SGI/PPI alloc
from vgic_init() to kvm_create_vgic()") in v6.14-rc3.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac6769c8f948dff33265c50e524aebf9aa6f1be0]
stable/6.18: [b7493f48c3dba75674a4ee505b4afa8fe5102457]

CVE-2026-43352: i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling in
DMA dequeue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43352

Introduced by commit 9ad9a52 ("i3c/master: introduce the mipi-i3c-hci
driver") in v5.11-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b795e68bf3073d67bebbb5a44d93f49efc5b8cc7]
stable/6.18: [003df94bcc9227e8e930abd03ac7f63ac10033dc]

CVE-2026-43353: i3c: mipi-i3c-hci: Fix race in DMA ring dequeue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43353

Introduced by commit 9ad9a52 ("i3c/master: introduce the mipi-i3c-hci
driver") in v5.11-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dca8aee80eea76d2aae21265de5dd64f6ba0f09]
stable/6.18: [b684b420a5bb0ea1b0e13abfdb8ce41c5266e62e]

CVE-2026-43354: iio: proximity: hx9023s: Protect against division by
zero in set_samp_freq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43354

Introduced by commit 60df548 ("iio: proximity: Add driver support for
TYHX's HX9023S capacitive proximity sensor") in v6.12-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a318cfc0853706f1d6ce682dba660bc455d674ef]
stable/6.12: [451ec5e67444f8460f9706a1bde146b5bbc86ce6]
stable/6.18: [ad9da7d39cecd3e92f54149ea0ebca390f33fe69]

CVE-2026-43355: iio: light: bh1780: fix PM runtime leak on error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43355

Introduced by commit 1f0477f ("iio: light: new driver for the ROHM
BH1780") in v4.7-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [76da73fe8a9fc831a968e8302bbdd3e7757ca59d]
mainline: [dd72e6c3cdea05cad24e99710939086f7a113fb5]
stable/5.10: [1eb3af4f59e09323788860a9155e9766b12891e5]
stable/6.1: [424bf90e87134effe4bd932608a15286493b11ab]
stable/6.18: [aae572ddc28578af476cce7da3faec0395ef0bf0]
stable/6.6: [fc77e0a5600e620a2ae51ec78933162fb217b20b]

CVE-2026-43356: iio: imu: adis: Fix NULL pointer dereference in adis_init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43356

Introduced by commit 3b29bce ("iio: imu: adis: Add custom ops struct")
in v6.15-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9990cd4f8827bd1ae3fb6eb7407630d8d463c430]
stable/6.18: [ba19dd366528b961430f5195c2e382420703074f]

CVE-2026-43357: iio: gyro: mpu3050-core: fix pm_runtime error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43357

Introduced by commit 3904b28 ("iio: gyro: Add driver for the MPU-3050
gyroscope") in v4.10-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acc3949aab3e8094641a9c7c2768de1958c88378]
stable/5.10: [935f57dd43492240e1ca220dd065d624efece6be]
stable/5.15: [8544c488e50206f00630a8bbba43d2c8bd290345]
stable/6.1: [35f54e7bcb1eccdc6e5bff06580eeef2e0ff3677]
stable/6.12: [66c0d1d600e7be034959cf49edab104cb5a39258]
stable/6.18: [42685cf96e28262e0b84d74447f3d99f3f6a72e0]
stable/6.6: [2a86a396aa001a9f9ba2d37dda36573a76f17c90]

CVE-2026-43358: btrfs: add missing RCU unlock in error path in
try_release_subpage_extent_buffer()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43358

Introduced by commit ad580df ("btrfs: fix subpage deadlock in
try_release_subpage_extent_buffer()") in v6.17-rc2.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2840e33127ce0eea880504b7f133e780f567a9b]
stable/6.18: [5e1ab71f74a1e61f1254dff128a764fdebaec0b8]

CVE-2026-43359: btrfs: fix transaction abort on set received ioctl due
to item overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43359

Introduced by commit dd5f961 ("Btrfs: maintain subvolume items in the
UUID tree") in v3.12-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87f2c46003fce4d739138aab4af1942b1afdadac]
stable/6.1: [b9914db13ac15aca3b74544c0bb1a2e0dad1f174]
stable/6.12: [2e57b8cac2ba0d38aac76c1ecdfd8b899e3581a5]
stable/6.18: [d11aefe654a04fc41996d254748d6a38b6b0a7be]
stable/6.6: [b19c0465e4daad5aa8f60552ea0578cf31a11b1e]

CVE-2026-43360: btrfs: fix transaction abort on file creation due to
name hash collision

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43360

Introduced by commit caae78e ("btrfs: move common inode creation code
into btrfs_create_new_inode()") in v5.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d1ababdedd4ba38867c2500eb7f95af5ddeeef7]
stable/6.1: [36947b5200b89bbe3a63629c12d4b31c84c0af9f]
stable/6.12: [5e2ea10b800d1bbb95e0c01a83f4f8119ac5d688]
stable/6.18: [9273175bf16c83f3ec93aa242d78c9b5db452d4d]
stable/6.6: [64ad49597d14c495ab8b7933bfefc83936a598e4]

CVE-2026-43361: btrfs: fix transaction abort when snapshotting
received subvolumes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43361

Introduced by commit dd5f961 ("Btrfs: maintain subvolume items in the
UUID tree") in v3.12-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1b18b959025e6b5dbad668f391f65d34b39595a]
stable/6.1: [9a9227b488ffb7cdbb5d930a01fc6956c05ba61a]
stable/6.12: [e3d8efc157bc590457d3e31da403af1a221643d6]
stable/6.18: [bac55dde8efa457e769c934fd88a63f2141ba238]
stable/6.6: [6bce705b699cba9afccb996c77d194fe003dfa2a]

CVE-2026-43362: smb: client: fix in-place encryption corruption in SMB2_write()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43362

According to the .vulnerable file, this bug was introduced by commit
026e93d in v4.11-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d78840a6a38d312dc1a51a65317bb67e46f0b929]
stable/6.12: [52327268224fb9ccc7ecfbbdfdfff54b6e93c518]
stable/6.18: [92e64f1852f455f57d0850989e57c30d7fac7d95]
stable/6.6: [438e77435aee2894d5edf90be5c87004a57f6258]

CVE-2026-43363: x86/apic: Disable x2apic on resume if the kernel expects so

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43363

Introduced by commit 6e1cb38 ("x64, x2apic/intr-remap: add x2apic
support, including enabling interrupt-remapping") in v2.6.28-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e72f28032f4a6fc69e3ca0bcf3fd3af1a0b128eb]
mainline: [8cc7dd77a1466f0ec58c03478b2e735a5b289b96]
stable/5.10: [a6ad6f2e31b524cbb66b2f370bad0cf17d327e6c]
stable/5.15: [3dd0812a7c764cd8f3b0182441ac22da0a7f3b09]
stable/6.1: [965289b120cc68cca886c75219c68b8c15751d73]
stable/6.12: [1a85f84214f9d790216547ac6086bf8033cd9e5a]
stable/6.18: [11712c4eb384098db4cb08792e223c818b908c1a]
stable/6.6: [f591938072115bf08730b8530c67fab189cc6308]

CVE-2026-43364: ublk: fix NULL pointer dereference in ublk_ctrl_set_size()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43364

Introduced by commit 98b9956 ("ublk: Add UBLK_U_CMD_UPDATE_SIZE") in v6.16-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25966fc097691e5c925ad080f64a2f19c5fd940a]
stable/6.18: [f13fe6794726755a43090cb680c4c58cea6aa5f1]

CVE-2026-43365: xfs: fix undersized l_iclog_roundoff values

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43365

Introduced by commit a6a65fe ("xfs: log stripe roundoff is a property
of the log") in v5.14-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52a8a1ba883defbfe3200baa22cf4cd21985d51a]
stable/5.15: [5afae524f83d6a18517298491a5624cb0eae5029]
stable/6.1: [2ecda4b83749c1fef0c9dea4fd5e8b513aba3e40]
stable/6.12: [e88ce9f0536f3b2149afb70625cfc4bd74a4ac6d]
stable/6.18: [446a1f5bb64ba38adb93cb043ff0f7b85e8937ca]
stable/6.6: [41e91dff2d3974730b5ee50daa8e27ec254cbf91]

CVE-2026-43366: io_uring/kbuf: check if target buffer list is still
legacy on recycle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43366

Introduced by commit c7fb194 ("io_uring: add support for ring mapped
supplied buffers") in v5.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2c185be5c85d37215397c8e8781abf0a69bec1f]
stable/6.1: [a7b33671e418fca507feebd1d56e7f4952a4b25c]
stable/6.12: [f3fb54e7a8b4aadcc2836ee463eec8c88709b8aa]
stable/6.18: [50ad880db3013c6fee0ef13781762a39e2e7ef83]
stable/6.6: [439a6728ec4641ffad1ca796622c19bc525e570f]

CVE-2026-43367: drm/amd: Fix a few more NULL pointer dereference in
device cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43367

Introduced by commit 39fc2bc ("drm/amdgpu: Protect GPU register
accesses in powergated state in some paths") in v7.0-rc1.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [72ecb1dae72775fa9fea0159d8445d620a0a2295]
stable/6.18: [38f1640db7f8bf57b9e09c5b0b8b205a598f1b3e]

CVE-2026-43368: drm/i915: Fix potential overflow of shmem scatterlist length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43368

Introduced by commit 0b62af2 ("i915: convert shmem_sg_free_table() to
use a folio_batch") in v6.5-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [029ae067431ab9d0fca479bdabe780fa436706ea]
stable/6.12: [1c956f0fccc26fefcbb507516c49d1db41c40471]
stable/6.18: [eae4bf4107571283031db96ce132e951615e2ae4]
stable/6.6: [aeb7255531ba4a5c3a64938577170d08b78de399]

CVE-2026-43369: drm/amd: Fix NULL pointer dereference in device cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43369

Introduced by commit 39fc2bc ("drm/amdgpu: Protect GPU register
accesses in powergated state in some paths") in v7.0-rc1.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [062ea905fff7756b2e87143ffccaece5cdb44267]
stable/6.18: [43025c941aced9a9009f9ff20eea4eb78c61deb8]

CVE-2026-43370: drm/amdgpu: Fix use-after-free race in VM acquire

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43370

According to the .vulnerable file, this bug was introduced by commit
ede0dd8 in v4.17-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [563e2caeab619a0202cb012f0eb23db546e03889]
mainline: [2c1030f2e84885cc58bffef6af67d5b9d2e7098f]
stable/5.10: [ae87aea330c24f462fc7058ed543ba8bc6798447]
stable/5.15: [46d309996bd9251792d7dafdbaf615cf202b4447]
stable/6.1: [e61e355cbe49e585097eee28c15b862bfb1c0668]
stable/6.12: [904025fa8bba1d028adade33346372b4ac1a9249]
stable/6.18: [7885eb335d8f9e9942925d57e300a85e3f82ded4]
stable/6.6: [c658c1c85ec235b7ecfbf8dbfee385b1332088f4]

CVE-2026-43371: net: macb: Shuffle the tx ring before enabling tx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43371

Introduced by commit bf9cf80 ("net: macb: Fix tx/rx malfunction after
phy link down and up") in v7.0-rc1.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [881a0263d502e1a93ebc13a78254e9ad19520232]
stable/6.1: [c6783bfa31a59f34fe4feb1bdbf67791ef3fb0b7]
stable/6.12: [88f974fe118cb4653f029929ecbca7cfe06132ae]
stable/6.18: [58f5d34f88e8f00910b692537f7b2efdb8c3705d]
stable/6.6: [0a47c3889fcd843c72aa57fa8c4d06f5801fced4]

CVE-2026-43372: net: dsa: microchip: Fix error path in PTP IRQ setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43372

Introduced by commit d0b8fec ("net: dsa: microchip: Fix symetry in
ksz_ptp_msg_irq_{setup/free}()") in v6.18.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [99c8c16a4aad0b37293cae213e15957c573cf79b]
stable/6.12: [e80fef36c676c947072dabeb5803ae59d92ba493]
stable/6.18: [6c58a9fdb0d0e1011aa02455d26d6ebea251979b]
stable/6.6: [3704ac6a0d9a78f66a187515a8ca3faedaf01cc5]

CVE-2026-43373: net: ncsi: fix skb leak in error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43373

Introduced by commit 7a82ecf ("net/ncsi: NCSI AEN packet handler") in v4.8-rc1.
Introduced by commit 138635c ("net/ncsi: NCSI response packet
handler") in v4.8-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8436f15b1702544614ae39a4d865cebb984a0621]
mainline: [5c3398a54266541610c8d0a7082e654e9ff3e259]
stable/5.10: [9891d7f4f1ede473c54b49776ae07755083eef06]
stable/5.15: [fef5aa6e3bcf3c8053307642663a63b7362d7552]
stable/6.1: [81d6aee32f8f7bbc175c05dbf61f4430bfb88c4a]
stable/6.12: [553366c271479c0d571dd1bb5d1bcde4747fb82e]
stable/6.18: [b70c4e5e711931cdd56e6e905737b72f1e649189]
stable/6.6: [59962588197863d0d746879f193905c0c6b3df49]

CVE-2026-43374: net: nexthop: fix percpu use-after-free in remove_nh_grp_entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43374

Introduced by commit f4676ea ("net: nexthop: Add nexthop group entry
stats") in v6.9-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2662e7593e94ae09b1cf7ee5f09160a3612bcb2]
stable/6.12: [abf4feaee6405f1441929c6ebe7a250f2cd170a7]
stable/6.18: [ab5ebab9664214ba41a7633cb4e72f128204f924]

CVE-2026-43375: net: mctp: fix device leak on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43375

Introduced by commit 0791c03 ("net: mctp: Add MCTP USB transport
driver") in v6.15-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [224a0d284c3caf1951302d1744a714784febed71]
stable/6.18: [3224990fb16a831aabc50b67c74f5d0074ce80dd]

CVE-2026-43376: ksmbd: fix use-after-free by using call_rcu() for oplock_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43376

Introduced by commit 18b4fac ("ksmbd: fix use-after-free in
smb_break_all_levII_oplock()") in v6.15-rc3.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [1dfd062caa165ec9d7ee0823087930f3ab8a6294]
stable/6.12: [08aa9f3c8cf4d0bee44df540dfe34e8d64069f2c]
stable/6.18: [1d6abf145615dbfe267ce3b0a271f95e3780e18e]
stable/6.6: [302fef75512b2c8329a3f5efab1ae7ba2562387a]

CVE-2026-43377: ksmbd: Don't log keys in SMB3 signing and encryption
key generation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43377

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [441336115df26b966575de56daf7107ed474faed]
stable/6.1: [4084ed720d7d5f4e975c9e4a6267a552dad3b24a]
stable/6.12: [3fe2d9ec166b7df9a8df6c0fdcfc210572e27e3f]
stable/6.18: [407cc37c21d51f9b9d4d20204b04890880cfa6ae]
stable/6.6: [fec5c70b82af3f59f15bb984df94e5ad1fccfb1e]

CVE-2026-43378: smb: server: fix use-after-free in smb2_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43378

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e689a56173827669a35da7cb2a3c78ed5c53680]
stable/6.1: [e1b21e6066615e7d3d3a7aa2677e415e563fd7cc]
stable/6.12: [54b48ae83de8bb06e65079d96368efe359d4909c]
stable/6.18: [8f5b1a7cb009a93c48e9e334a2f59a660f9afc07]
stable/6.6: [b720c84087cb547f23ce03eab93568c1769e4556]

CVE-2026-43379: ksmbd: fix use-after-free in smb_lazy_parent_lease_break_close()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43379

Introduced by commit 5fb282b ("ksmbd: fix possible null-deref in
smb_lazy_parent_lease_break_close") in v6.9-rc1.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [eac3361e3d5dd8067b3258c69615888eb45e9f25]
stable/6.12: [960699317d39f46611f4ebeb69edc567c1f4e6b6]
stable/6.18: [dbbd328cf58261ca239756fe1c0d10c9518d3399]
stable/6.6: [bf4d66d72e4a9e268c1012c331ce9eaedb5e2086]

CVE-2026-43380: hwmon: (pmbus/q54sj108a2) fix stack overflow in debugfs read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43380

Introduced by commit d014538 ("hwmon: (pmbus) Driver for Delta power
supplies Q54SJ108A2") in v5.11-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25dd70a03b1f5f3aa71e1a5091ecd9cd2a13ee43]
stable/5.15: [a0fc1b9c738fba231f190ab960c83202722efee5]
stable/6.1: [c59090c50f62a17129fc4c5407bc4071305a9e82]
stable/6.12: [b48a0f8d4541a4f6651dc9a64430ce9fdf5c120b]
stable/6.18: [73a7a345816946d276ad2c46c8bb771de67cfc46]
stable/6.6: [52db5ef163c96f916d424e472fb17aadc35a9f7a]

CVE-2026-43381: nouveau/dpcd: return EBUSY for aux xfer if the device is asleep

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43381

Introduced by commit 8894f49 ("drm/nouveau: register a drm_dp_aux
channel for each dp connector") in v3.16-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a020e92def54f22be80f1316fe8b6f976fc3ac0b]
mainline: [8f3c6f08ababad2e3bdd239728cf66a9949446b4]
stable/5.10: [178df7c91e6c202579284df9f79d1592a514cdcf]
stable/5.15: [4df518aa196085909fd7e32518ecd27fba60ed69]
stable/6.1: [cd24cab2023aa46b595bc6b9cc39d8973d9d0a8c]
stable/6.12: [6bdd2d70c338d52c387d3b3aadc596784ae81b01]
stable/6.18: [ad8fa5bff53f5d1f8394f996850da8ce070eaee3]
stable/6.6: [fad178ae894930520519ead3c8e0150641466360]

CVE-2026-43382: batman-adv: Avoid double-rtnl_lock ELP metric worker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43382

Introduced by commit 8c8ecc9 ("batman-adv: Drop unmanaged ELP metric
worker") in v6.14-rc3.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
cip/4.19-st: [8807caae510195032e183bc84f08c14132a509d7]
mainline: [cfc83a3c71517b59c1047db57da31e26a9dc2f33]
stable/5.10: [4c3ae249431b4fcb315d7dfb4c3a13f9e443fd9b]
stable/5.15: [192f40ad8a7dac58dae9199a065dbf7e6e67b75b]
stable/6.1: [fa7b4edfbabdf9235b0ab4bea297fc12b3bec9ca]
stable/6.12: [b7e5d8ddfdf1d6e9e0808d1adf7736a107372d77]
stable/6.18: [2ab9f2531d37775cd79228c1f5d80e6bd08d11d3]
stable/6.6: [f3ca45673dab0514a887231de6f3243a699d5bfd]

CVE-2026-43383: net/tcp-md5: Fix MAC comparison to be constant-time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43383

Introduced by commit cfb6eeb ("[TCP]: MD5 Signature Option (RFC2385)
support.") in v2.6.20.16.
Introduced by commit 658ddaa ("tcp: md5: RST: getting md5 key from
listener") in v3.4-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [aa760844433a8ac5a3d9c8abf307bf5e6ff0fbb7]
mainline: [46d0d6f50dab706637f4c18a470aac20a21900d3]
stable/5.10: [821c8751fdeecdeecabeb11704dd33439c9e4bbc]
stable/6.1: [345a9530756528d7ca407663d659c3c40e75c3dd]
stable/6.12: [02669e2a4d207068edce7e8b5fafd85822018ce6]
stable/6.18: [ae3831b44f477de048287493e184fc3ff913b624]
stable/6.6: [5d305a95130a8d08b9545e47f1e18d29d59866cb]

CVE-2026-43384: net/tcp-ao: Fix MAC comparison to be constant-time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43384

Introduced by commit 0a3a809 ("net/tcp: Verify inbound TCP-AO signed
segments") in v6.7-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67edfec516d30d3e62925c397be4a1e5185802fc]
stable/6.12: [8be6ed64966da48b6c4726918f106c18742a5125]
stable/6.18: [a269cbdc442f8658bca35383e34b9d0b0ff95a1c]

CVE-2026-43385: net: Fix rcu_tasks stall in threaded busypoll

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43385

Introduced by commit c18d4b1 ("net: Extend NAPI threaded polling to
allow kthread based busy polling") in v6.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a86a1f7d88996085934139fa4c063b6299a2dd3]

CVE-2026-43386: staging: rtl8723bs: fix potential out-of-bounds read
in rtw_restruct_wmm_ie

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43386

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fe1ce5e388b0193415da10574340b33c88c69156]
mainline: [a75281626fc8fa6dc6c9cc314ee423e8bc45203b]
stable/5.10: [6ff2243d5e05a5239e39d4ba61d96b0ea3bf7259]
stable/5.15: [12cc6e8f8d4245b7b5a408c6fc8ab1d098d67020]
stable/6.1: [209644e25757c499e1c1f08c071ea0386d4448b6]
stable/6.12: [e14a1148f02e8cf1ca380d57e4b95ca36c97f45d]
stable/6.18: [4dd2d9cf563c54e09d5f7eacf95c5b8f538b513b]
stable/6.6: [768f25613a9fe6766d15a4a72979657adfc1c6d8]

CVE-2026-43387: staging: rtl8723bs: properly validate the data in
rtw_get_ie_ex()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43387

According to the .vulnerable file, this bug was introduced by commit
554c0a3 in v4.12-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0109b9d3e1e455429279d602f6276e34689750a]
stable/5.10: [ac38856092b4c994f94343251b30520bdeb7f475]
stable/5.15: [35969c3a208a07cb8642301df5869c34e2db7071]
stable/6.1: [8097a48c606a9306281ea7bd73bf2afc97553733]
stable/6.12: [821f7d759fb2de33c5e5b0c4981181c4d0c3e9b1]
stable/6.18: [6d62fa548387e159a21ea95132c09bfc96d336ed]
stable/6.6: [740bca8bbdb707c0e4bb11e3316deb2f04fc7ce1]

CVE-2026-43388: mm/damon/core: clear walk_control on inactive context
in damos_walk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43388

Introduced by commit bf0eaba ("mm/damon/core: implement damos_walk()")
in v6.14-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d210fdcac9c0d1380eab448aebc93f602c1cd4e6]
stable/6.18: [ce0aa47c963b8c3e5beace89e2b5a665a64b5b6b]

CVE-2026-43389: mm: memfd_luo: always dirty all folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43389

Introduced by commit b3749f1 ("mm: memfd_luo: allow preserving memfd")
in v6.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e04bf1f33151a30e06a65b74b5f2c19fc2be128]

CVE-2026-43390: nstree: tighten permission checks for listing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43390

Introduced by commit 76b6f5d ("nstree: add listns()") in v6.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d76afe84fa2babf604b3c173730d4d2b067e361]

CVE-2026-43391: nsfs: tighten permission checks for handle opening

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43391

Introduced by commit 5222470 ("nsfs: support file handles") in v6.18-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2324a9317f00013facb0ba00b00440e19d2af5e]

CVE-2026-43392: sched_ext: Fix starvation of scx_enable() under
fair-class saturation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43392

Introduced by commit 8c2090c ("sched_ext: Initialize in bypass mode")
in v6.12-rc2.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b06ccbabe2506fd70b9167a644978b049150224a]
stable/6.12: [e0b14bf06393be137d3efb6a3b7cd5b4b9810a6b]
stable/6.18: [c44198f25fdfecc0ec0fe366bf8a47fe17d8e229]

CVE-2026-43393: btrfs: fix chunk map leak in btrfs_map_block() after
btrfs_chunk_map_num_copies()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43393

Introduced by commit 0ae653f ("btrfs: reduce chunk_map lookups in
btrfs_map_block()") in v6.12-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f15fb3d41543244d1179f423da4a4832a55bc050]
stable/6.12: [0e4aaf5a3212b6a469c2489637c29a8e2a5062a5]
stable/6.18: [7bdf00ed75c477252578068dba19934cd825f20a]

CVE-2026-43394: nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43394

Introduced by commit 16a4711 ("NFSD: add listener-{set,get} netlink
command") in v6.10-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92978c83bb4eef55d02a6c990c01c423131eefa7]
stable/6.12: [02e87ec0bc706cb93fa47b43d18c4d10102c7d54]
stable/6.18: [019debe5851d7355bea9ff0248cc317878924d8f]

CVE-2026-43395: drm/xe/sync: Cleanup partially initialized sync on parse failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43395

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bfd7575092420ba5a0b944953c95b74a5646ff8]
stable/6.12: [91c228f96fcfacc2341a58815b1da8c69da94ebb]
stable/6.18: [af65cd1853599394b94201c08bed7a46717db478]

CVE-2026-43396: drm/xe/sync: Fix user fence leak on alloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43396

Introduced by commit 0995c2f ("drm/xe: Enforce correct user fence
signaling order using") in v6.18-rc5.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0879c3f04f67e2a1677c25dcc24669ce21eb6a6c]
stable/6.18: [05edc78eb4699e8e000a62aaa8dace50a17e19e3]

CVE-2026-43397: drm/bridge: samsung-dsim: Fix memory leak in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43397

Introduced by commit e744712 ("drm: bridge: Generalize Exynos-DSI
driver into a Samsung DSIM bridge") in v6.4-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [803ec1faf7c1823e6e3b1f2aaa81be18528c9436]
stable/6.12: [0b07f7d2c5a4078c2f1c11bb36685084fe4e5c95]
stable/6.18: [e6d779654cda63d632bd8dfcdcabd125057e30a5]
stable/6.6: [98310fe3a2a79671b739a5344c1a11d74c503e25]

CVE-2026-43398: drm/amdgpu: add upper bound check on user inputs in wait ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43398

According to the .vulnerable file, this bug was introduced by commit
a292fde in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64ac7c09fc44985ec9bb6a9db740899fa40ca613]
stable/6.18: [b1d10508da559da2e0ca9cca6505094a7df948e1]

CVE-2026-43399: drm/amdgpu/userq: Fix reference leak in amdgpu_userq_wait_ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43399

Introduced by commit a292fde ("drm/amdgpu: Implement userqueue
signal/wait IOCTL") in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49abfa812617a7f2d0132c70d23ac98b389c6ec1]
stable/6.18: [762f47e2b824383d5be65eee2c40a1269b7d50c8]

CVE-2026-43400: drm/amdgpu: add upper bound check on user inputs in signal ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43400

According to the .vulnerable file, this bug was introduced by commit
a292fde in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea78f8c68f4f6211c557df49174c54d167821962]
stable/6.18: [6fff5204d8aa26b1be50b6427f833bd3e8899c4f]

CVE-2026-43401: cpufreq: intel_pstate: Fix NULL pointer dereference in
update_cpu_qos_request()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43401

Introduced by commit ae1bdd2 ("cpufreq: intel_pstate: Adjust frequency
percentage computations") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab39cc4cb8ceecdc2b61747433e7237f1ac2b789]
stable/6.18: [6bfda7ce56e7d14a677b7bcd6c7a5009cc29aa88]

CVE-2026-43402: kthread: consolidate kthread exit paths to prevent
use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43402

Introduced by commit 4d13f43 ("kthread: Implement preferred affinity")
in v6.14-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28aaa9c39945b7925a1cc1d513c8f21ed38f5e4f]
stable/6.18: [4729c7b00a347fd37d0cbc265b85f2884c3e06b6]

CVE-2026-43403: nsfs: tighten permission checks for ns iteration ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43403

Introduced by commit a1d220d ("nsfs: iterate through mount
namespaces") in v6.12-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6b899f08066e744f89df16ceb782e06868bd148]
stable/6.12: [3376b345df155ca36d8611857b41ff7d5183fc38]
stable/6.18: [2f3dea284c761c890d676f77d5e55c0c496b4ef4]

CVE-2026-43404: mm: Fix a hmm_range_fault() livelock / starvation problem

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43404

Introduced by commit 1afaeb8 ("mm/migrate: Trylock device page in
do_swap_page") in v6.15-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b570f37a2ce480be26c665345c5514686a8a0274]
stable/6.18: [94b6d0ba4b640ba23bb6c708a59316e74e5ede63]

CVE-2026-43405: libceph: Use u32 for non-negative values in ceph_monmap_decode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43405

According to the .vulnerable file, this bug was introduced by commit
a5cbd5f in v5.11-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [770444611f047dbfd4517ec0bc1b179d40c2f346]
stable/5.15: [ee5588e2bc41acb73f6676c0520420c107cd0140]
stable/6.1: [86f7060cd638d6eb042e8ed780fb83a59ca0dcb3]
stable/6.12: [b268984ae88cb0dcd7a8e8263962c748448e26e8]
stable/6.18: [ba0a4df8c563536857dcbf7b4dbd0f2a15f57ace]
stable/6.6: [5f2806684b05bd24d05c091083b8e2517ba8ffac]

CVE-2026-43406: libceph: prevent potential out-of-bounds reads in
process_message_header()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43406

According to the .vulnerable file, this bug was introduced by commit
cd1a677 in v5.11-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69fb5d91bba44ecf7eb80530b85fa4fb028921d5]
stable/5.15: [76ccf21a12c5f6d6790bc32c7da82446d877b2f4]
stable/6.1: [75582aaa580c11aed4c7731cad6b068b700e7efb]
stable/6.12: [dbd857a9e1e33ea71eaf3e211877027e533770d1]
stable/6.18: [69fe5af33fa3806f398d21c081d73c66e5523bc2]
stable/6.6: [50156622eb0888e62541d715a98584480a1bc7cb]

CVE-2026-43407: libceph: Fix potential out-of-bounds access in
ceph_handle_auth_reply()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43407

According to the .vulnerable file, this bug was introduced by commit
4e7a5dc in v2.6.34-rc2.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7e9639e80835a2b6d0940ff2d1870cb758276eb6]
mainline: [b282c43ed156ae15ea76748fc15cd5c39dc9ab72]
stable/5.10: [ea080b21092590122c3f971cf588932cdbf47847]
stable/5.15: [edc678e5cd11730a2834b43071d8923f05bc334d]
stable/6.1: [6cee34d6669fe176b4259131adb1a145c939b472]
stable/6.12: [ed024d2f4c79c0eb2464df0fb640610ac301f9a0]
stable/6.18: [f9da5c1bbac5c8e33259fe00ed7347438fffa969]
stable/6.6: [8bb87547e92dcf0928ed763c60e0ac8d733c3656]

CVE-2026-43408: ceph: add a bunch of missing ceph_path_info initializers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43408

Introduced by commit 15f519e ("ceph: fix race condition validating
r_parent before applying state") in v6.17-rc6.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [43323a5934b660afae687e8e4e95ac328615a5c4]
stable/6.12: [644b47f0574fd82aeb9d00317eca8d1f2a525c8c]
stable/6.18: [8be8911f590813e6f90bc6407ced1b23e50bc5da]

CVE-2026-43409: kprobes: avoid crash when rmmod/insmod after ftrace killed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43409

Introduced by commit ae6aa16 ("kprobes: introduce ftrace based
optimization") in v3.7-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e113f0b46d19626ec15388bcb91432c9a4fd6261]
stable/6.12: [b0ca81616a010807e91fc31db9be242b96326adc]
stable/6.18: [cae928e3178c75602c21d67e21255d73e7e9ed4f]
stable/6.6: [8b6767e4141b2a42745b544d4555cf1614ba1a2d]

CVE-2026-43410: firmware: stratix10-rsu: Fix NULL pointer dereference
when RSU is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43410

Introduced by commit 1584753 ("firmware: stratix10-rsu: Migrate RSU
driver to use stratix10 asynchronous framework.") in v6.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c45f7263100cece247dd3fa5fe277bd97fdb5687]

CVE-2026-43411: tipc: fix divide-by-zero in tipc_sk_filter_connect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43411

Introduced by commit 6787927 ("tipc: buffer overflow handling in
listener socket") in v4.20-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c5a9baa15de240e747263aba435a0951da8d8d2]
stable/5.10: [600feb0a66a98c6b7f6f02b5f3612e75f9b8540f]
stable/5.15: [3bc9998041076ee05d3f312a22cee6b2ca35527f]
stable/6.1: [579956f9f297eb1b6a5d24de313f3acccee1f9d5]
stable/6.12: [c2ebfbe63deb7bfd4dc2532bae62a7ed67713272]
stable/6.18: [2754e7b3d64748643df867d1ea6fec522914b635]
stable/6.6: [a360d3815aae1f00dd71b7714a846482e85cc1f7]

CVE-2026-43412: ASoC: qcom: qdsp6: Fix q6apm remove ordering during
ADSP stop and start

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43412

Introduced by commit 5477518 ("ASoC: qdsp6: audioreach: add q6apm
support") in v5.16-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6db827b430bdcca3976cebca7bd69cca03cde2c]
stable/6.1: [94bda21adb2a51f69366b847b4d80dfe50bd9fb9]
stable/6.12: [0da170b9e600da6930cfb8352e4cc036db3b6159]
stable/6.18: [22b05abb17e3c6ef45035141fe3d26f815ff9d30]
stable/6.6: [a8e9cab16771b15160465783507496dc83742d8e]

CVE-2026-43413: scsi: hisi_sas: Fix NULL pointer exception during user_scan()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43413

Introduced by commit e21fe3a ("scsi: hisi_sas: add initialisation for
v3 pci-based controller") in v4.13-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ddc0c26916574395447ebf4cff684314f6873a9]
stable/6.12: [40119a21d9769bf8fdab5c93c6c878296e628abf]
stable/6.18: [21a13db8d449b9c7eda4471da7f12417602dbbc7]
stable/6.6: [70c78429ef383e35f9c58848994aeeac8083ae35]

CVE-2026-43414: scsi: qla2xxx: Completely fix fcport double free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43414

Introduced by commit 82f522a ("scsi: qla2xxx: Fix double free of
fcport") in v6.9-rc2.
Introduced by commit 4895009 ("scsi: qla2xxx: Prevent command send on
chip reset") in v6.9-rc2.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [c0b7da13a04bd70ef6070bfb9ea85f582294560a]

CVE-2026-43415: scsi: ufs: core: Fix SError in ufshcd_rtc_work()
during UFS suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43415

Introduced by commit 6bf999e ("scsi: ufs: core: Add UFS RTC support")
in v6.8-rc1.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b0bd84c39289ef6a6c3827dd52c875659291970a]
stable/6.12: [2fcc2fc21cae7a0cbe73053f7fc70680ce2a7f69]
stable/6.18: [b17211b512cbf0e07de27e1932428ee6c20df910]
stable/6.6: [a6a894413b043704b77a6294c379c93b1477e48d]

CVE-2026-43416: powerpc, perf: Check that current->mm is alive before
getting user callchain

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43416

Introduced by commit 20002de ("perf_counter: powerpc: Add callchain
support") in v2.6.32-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9bbfb4bfa86c6b5515b868d6982ac60505d7e39]
stable/6.18: [98074e16742ae87fb82e234b419783c5ffc9baea]

CVE-2026-43417: sched/mmcid: Handle vfork()/CLONE_VM correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43417

Introduced by commit fbd0e71 ("sched/mmcid: Provide CID ownership mode
fixup functions") in v6.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28b5a1395036d6c7a6c8034d85ad3d7d365f192c]

CVE-2026-43418: sched/mmcid: Prevent CID stalls due to concurrent forks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43418

Introduced by commit fbd0e71 ("sched/mmcid: Provide CID ownership mode
fixup functions") in v6.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2e48c429ec54715d16fefa719dd2fbded2e65be]

CVE-2026-43419: ceph: fix memory leaks in ceph_mdsc_build_path()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43419

Introduced by commit 3fd945a ("ceph: encode encrypted name in
ceph_mdsc_build_path and dentry release") in v6.6-rc1.
Introduced by commit 550f7ca ("ceph: give up on paths longer than
PATH_MAX") in v6.13-rc4.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [040d159a45ded7f33201421a81df0aa2a86e5a0b]
stable/6.12: [5895d0164c84d7fec6abc198920c257f55c51899]
stable/6.18: [097cd68f46686391a98f2618188f0cb7b7570de2]
stable/6.6: [657dc653b06a3cc0282aea447a3f137fa94066a4]

CVE-2026-43420: ceph: fix i_nlink underrun during async unlink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43420

Introduced by commit 2ccb454 ("ceph: perform asynchronous unlink if we
have sufficient caps") in v5.7-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce0123cbb4a40a2f1bbb815f292b26e96088639f]
stable/5.10: [9b31e88ac5623d15c8bc46f69dfe1d3b43a8f67c]
stable/5.15: [6d5fd8bb574bef039eb3b738e523870433a2aeb9]
stable/6.1: [fcc477a6e8856c8a42b3c9e171724d8d6dfadd06]
stable/6.12: [aedd29386b23f3e1e6818943e11abfff2953732f]
stable/6.18: [7db008e85a5d17b64bc5390b828bf457ae91a415]
stable/6.6: [b3f5513141ecc6b277a8f7b7efe58a0cf9a5e859]

CVE-2026-43421: usb: gadget: f_ncm: Fix net_device lifecycle with device_move

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43421

Introduced by commit 40d133d ("usb: gadget: f_ncm: convert to new
function interface with backward compatibility") in v3.11-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec35c1969650e7cb6c8a91020e568ed46e3551b0]
stable/6.12: [93f116c3393a22acab96ad1bef12b2572eb80ca4]
stable/6.18: [e584cb58a2ea7ff4d3a4bc43d5ca512ed3ecb77d]

CVE-2026-43422: usb: legacy: ncm: Fix NPE in gncm_bind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43422

Introduced by commit 56a512a ("usb: gadget: f_ncm: align net_device
lifecycle with bind/unbind") in v7.0-rc1.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [fde0634ad9856b3943a2d1a8cc8de174a63ac840]
stable/6.18: [be5738d19bed244ede84da45bc45395bcb1d99e0]

CVE-2026-43423: usb: gadget: f_ncm: Fix atomic context locking issue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43423

Introduced by commit 56a512a ("usb: gadget: f_ncm: align net_device
lifecycle with bind/unbind") in v7.0-rc1.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [0d6c8144ca4d93253de952a5ea0028c19ed7ab68]
stable/6.18: [e533a44fb1b337d14f772585b67328bee2e0b5e3]

CVE-2026-43424: usb: gadget: f_tcm: Fix NULL pointer dereferences in
nexus handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43424

Introduced by commit c52661d ("usb-gadget: Initial merge of target
module for UASP + BOT") in v3.5-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5bbf1b97b8a28590692df31b29912cf5f1ca38bf]
mainline: [b9fde507355342a2d64225d582dc8b98ff5ecb19]
stable/5.10: [b9b26d7f3aa288cfa54a7bc68612bab1f153f156]
stable/6.1: [2a2ef846a54a06c33b5c2d4b0d918583e1e7c0b7]
stable/6.12: [f962ca3b020e13d6714f27e8c36fe742441c58d1]
stable/6.18: [679d9535aeb15c10bce89c44102004b96624d706]
stable/6.6: [d146f27758049fa55ae4c53785a852d3cf7a18d6]

CVE-2026-43425: usb: image: mdc800: kill download URB on timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43425

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [16e39151103733be7270b605504c615aa5265175]
mainline: [1be3b77de4eb89af8ae2fd6610546be778e25589]
stable/5.10: [9fa5a49760979ba016506fe292a431c8b83f043e]
stable/5.15: [15536f6c15f48037a1672cbdea53266d67861ff6]
stable/6.1: [9bf877cc67309b2a063b0087c3ad8585fb11cec3]
stable/6.12: [d4a400a6a4c4d49f77a04a3f401df5ae1a10657c]
stable/6.18: [b7fed917f84e484e06c5e9926746d0b524e3a93e]
stable/6.6: [155f471e38aa516f6c58c2ae03ca3dc222fa2fdb]

CVE-2026-43426: usb: renesas_usbhs: fix use-after-free in ISR during
device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43426

Introduced by commit f1407d5 ("usb: renesas_usbhs: Add Renesas USBHS
common code") in v3.0-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cbc242b88c607f55da3d0d0d336b49bf1e20412]
stable/5.10: [c7012fc73dab4829404fedeeaa8531f12ac8545f]
stable/5.15: [51afaf919bbaacdd9cc9e146033ae0a743a42dd7]
stable/6.1: [1899edac312ef17a7234851686e8a703f56d0a84]
stable/6.12: [6287e0c01ccb818e7214f88d885ffb7c9e81b0e0]
stable/6.18: [0b7d11fd6e742ecc0b1eca44b4f0b93140c74bae]
stable/6.6: [9c6159d5b72d5fc265cce5da04f27d730b552e69]

CVE-2026-43427: usb: class: cdc-wdm: fix reordering issue in read code path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43427

Introduced by commit afba937 ("USB: CDC WDM driver") in v2.6.26-rc4.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ac977a4739bb58589bcb25998e7665f790f07521]
mainline: [8df672bfe3ec2268c2636584202755898e547173]
stable/5.10: [638328ca9c17ae6511ad62198c57bae32ffa3c91]
stable/5.15: [170e8daca24da6edb4be82ab01abf44e87af387b]
stable/6.1: [c8fa96ed021923dae147bcd9f9205b8df7b82360]
stable/6.12: [276aef0fd2b92f41b920ac891c72cadeee957934]
stable/6.18: [67ed312124bb1b61858778ac0b985b48961c862a]
stable/6.6: [4ee3062bf2c9a722afef429826e8607eaf3fc6a0]

CVE-2026-43428: USB: core: Limit the length of unkillable synchronous timeouts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43428

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1015c27a5e1a63efae2b18a9901494474b4d1dc3]
stable/5.10: [4e86f5b79e62ded7e3c3ebd688cf5775e618148a]
stable/5.15: [06d2bbc4c66c6b0e8a43728c4949026026a5be67]
stable/6.1: [6c62935670acdbb7687ced20494923b66fbb0367]
stable/6.12: [24b31a227f679a942d820840a4dea7f0c09a387f]
stable/6.18: [64f3d75633aedc12bdff220e9a4337177430bd9d]
stable/6.6: [659c0c7d50a4b0f6aa197c4c098cfd91daf63862]

CVE-2026-43429: USB: usbtmc: Use usb_bulk_msg_killable() with
user-specified timeouts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43429

Introduced by commit 048c6d8 ("usb: usbtmc: Add ioctls to set/get usb
timeout") in v4.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7784caa413a89487dd14dd5c41db8753483b2acb]
stable/5.10: [e14a0dcdf468c3ad616bb06696c7c64c36e736d8]
stable/5.15: [7fa72c369c23c27d1f64883c1e276af950557fb1]
stable/6.1: [72c0a063489be183cfb99e7050aaef503bdb6449]
stable/6.12: [0535f84cb94c9d8bcba0a2a5b3fac81b7d97235d]
stable/6.18: [6cb7dc91f057dd8ce44f6caa2995d8e22784ed0a]
stable/6.6: [39bd4097292fd8564cf2cfba9356f8ab11e38d12]

CVE-2026-43430: usb: yurex: fix race in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43430

According to the .vulnerable file, this bug was introduced by commit
6bc235a in v2.6.37-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [956246144931a553a9fe0ece4aa7c28a958d5ec9]
mainline: [7a875c09899ba0404844abfd8f0d54cdc481c151]
stable/5.10: [a7934d7202a39c3160aa30521c382c7b744ae4a2]
stable/5.15: [a8b3b3d730acea1640bc89465f2832cf06a1e13a]
stable/6.1: [687d26d43a5aaf44323ce7d601cf242bb87e9559]
stable/6.12: [3cec135415a89723e2d38e1c8cc5098203355965]
stable/6.18: [a41d3d9202e951995cfac6248c565423079c71fa]
stable/6.6: [939e3d17b843b0bae70467fef4481069d73c8520]

CVE-2026-43431: xhci: Fix NULL pointer dereference when reading portli
debugfs files

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43431

Introduced by commit 384c57e ("usb: xhci: Add debugfs support for xHCI
Port Link Info (PORTLI) register.") in v6.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae4ff9dead5efa2025eddfcdb29411432bf40a7c]

CVE-2026-43432: usb: xhci: Fix memory leak in xhci_disable_slot()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43432

Introduced by commit 7faac19 ("xhci: avoid race between disable slot
command and host runtime suspend") in v5.16-rc5.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
cip/4.19-st: [3b2516883489b299d17eb625fd30334e2cea9259]
mainline: [c1c8550e70401159184130a1afc6261db01fc0ce]
stable/5.10: [1e800e26d54ccf2ddf2ea6d6cbe021c804d8aa62]
stable/5.15: [6288baf0c8c4dcfbf206773aede9c1f2269cec28]
stable/6.1: [46aea90763832cd6e9b0c2e1c00e6a9512156d4b]
stable/6.12: [807e4fb5140c73eb5dba1e399a990db5c1f3cdf8]
stable/6.18: [c65f1b840ab8ce72ba68f1b63bab7960f8fdfa89]
stable/6.6: [2e2baa8fb5aa4d080cbfeb84c51eff797529f413]

CVE-2026-43433: rust_binder: avoid reading the written value in offsets array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43433

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cb9e13fec0de7c942f5f927469beb8e48ddd20f]
stable/6.18: [e19afb53f7723b3bd22224f2b0c7dcfa70bb973f]

CVE-2026-43434: rust_binder: check ownership before using vma

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43434

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ef2c15aeae07647f530d30f6daaf79eb801bcd1]
stable/6.18: [20a01f20d1f4064d90a8627aa41b5987f0220bb9]

CVE-2026-43435: rust_binder: fix oneway spam detection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43435

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fc87c240b8f30e22b7ebaae29d57105589e1c0b]
stable/6.18: [edf685946c4acbe57cb96f8d5f3c07e9a2e973c8]

CVE-2026-43436: ALSA: usb-audio: Check endpoint numbers at parsing
Scarlett2 mixer interfaces

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43436

According to the .vulnerable file, this bug was introduced by commit
6c0a207 in v5.14-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df1d8abf36ca3681c21a6809eaa9a1e01ef897a6]
stable/6.1: [b014cc945baba75816cda0cf8934be87c9ed4947]
stable/6.12: [b267255c15d2a5b90c4e926146aa155e5161e264]
stable/6.18: [3d542cf3c4c854cdf5d58049771f68926b9eb2b9]
stable/6.6: [c5c5a6c53cf3b658f1d4512dfa61f3cd25bc34ba]

CVE-2026-43437: ALSA: pcm: fix use-after-free on linked stream runtime
in snd_pcm_drain()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43437

Introduced by commit f2b3614 ("ALSA: PCM - Don't check DMA time-out
too shortly") in v3.0-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b1dbd69ba6f8f8c69bc7b77c2ce3b9c6ed05ba6]
stable/5.10: [9baee36e8c5443411c4629afabafaff8a46a23fd]
stable/6.1: [fc71f888994569f87d5bee20b1ac6c9c1e3a7a79]
stable/6.12: [ae8f8d30d334bad5b1b3cdb1eb8a0b771f55e432]
stable/6.18: [4a758e9a1f5ed722f83c4dd35f867fe811553bcb]
stable/6.6: [629cf09464cf98670996ea5c191dc9743e6f3f00]

CVE-2026-43438: sched_ext: Remove redundant css_put() in scx_cgroup_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43438

Introduced by commit 8195136 ("sched_ext: Add cgroup support") in v6.12-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1336b579f6079fb8520be03624fcd9ba443c930b]
stable/6.12: [cc095cd305fddbe25a968e4a78436ff9476cf0f6]
stable/6.18: [6eaaa67d6998f6c30c462b140db8c062e07ec473]

CVE-2026-43439: cgroup: fix race between task migration and iteration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43439

Introduced by commit b636fd3 ("cgroup: Implement
css_task_iter_skip()") in v5.2-rc5.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [9b49310f77105444479111ad4e4f04877a794c60]
mainline: [5ee01f1a7343d6a3547b6802ca2d4cdce0edacb1]
stable/5.10: [7c85debc35e6d131bd29c64f2ae78c6ede0e55c4]
stable/5.15: [3b95abab7369235a37b15eaec6e1a0b443bba7c7]
stable/6.1: [4a9654a2b46cfdaae287fb8995f536245635e467]
stable/6.12: [9cca530c7cc1b3e02cb8fa7f80060dd4b38562ce]
stable/6.18: [86ceaccfdfa16dad05addb33dc206e03589bcfd1]
stable/6.6: [3dfd1328c05234e8d8fa61948b2ba82680594988]

CVE-2026-43440: net/mana: Null service_wq on setup error to prevent
double destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43440

Introduced by commit f975a09 ("net: mana: Fix double destroy_workqueue
on service rescan PCI path") in v7.0-rc2.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [87c2302813abc55c46485711a678e3c312b00666]
stable/6.18: [59489ce60d7412ed82fb1d8002faa3102dcd4916]

CVE-2026-43441: net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43441

Introduced by commit 4e24be0 ("bonding: add new parameter ns_targets")
in v5.18-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30021e969d48e5819d5ae56936c2f34c0f7ce997]
stable/6.1: [49dbfcb70eca5f6f9043594e1e323c74c39e3863]
stable/6.12: [c78f01abe535853f13f0b26cd5b1d2f19bf52e2f]
stable/6.18: [95faa1459b83fa544191e82ccc73856f03b7741f]
stable/6.6: [cf6099ef493b94e140b0fad52482a78853115318]

CVE-2026-43442: io_uring: fix physical SQE bounds check for SQE_MIXED
128-byte ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43442

Introduced by commit 1cba30b ("io_uring: add support for
IORING_SETUP_SQE_MIXED") in v6.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f02c6b196036dbb6defb4647d8707d29b7fe95b]

CVE-2026-43443: ASoC: amd: acp-mach-common: Add missing error check
for clock acquisition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43443

Introduced by commit 8b72562 ("ASoC: amd: acp: Add support for
RT5682-VS codec") in v5.16-rc1.
Introduced by commit d4c750f ("ASoC: amd: acp: Add generic machine
driver support for ACP cards") in v5.16-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30c64fb9839949f085c8eb55b979cbd8a4c51f00]

CVE-2026-43444: drm/amdkfd: Unreserve bo if queue update failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43444

Introduced by commit 305cd10 ("drm/amdkfd: Validate user queue
update") in v6.12-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ce75a0b7e1bfddbcb9bc8aeb2e5e7fa99971acf]
stable/6.12: [781110700ada22168fbb490dd61432d23a17a5b4]
stable/6.18: [529c985da1b277b36dc99aad660f96dc70f3c467]

CVE-2026-43445: e1000/e1000e: Fix leak in DMA error cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43445

Introduced by commit c1fa347 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix
tests of unsigned in *_tx_map()") in v2.6.33-rc6.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [05e0be859341d8142543bb8083f0877ea8355297]
mainline: [e94eaef11142b01f77bf8ba4d0b59720b7858109]
stable/5.10: [7eaeb778bfaa3b2a804f89321c234d59c74569db]
stable/5.15: [0606c24a745bafd1be5d66c48361638cd9cad74b]
stable/6.1: [519051c711dfd239ef6e4b28878efee400a035f9]
stable/6.12: [fa5ba9867a55e640df0dc79bf0199770fb043f03]
stable/6.18: [30e87ade8d678c25a8546cf38c0b498fa5cb27d3]
stable/6.6: [0a1fc25deabab4efce64610e3c449485c4fa8f5f]

CVE-2026-43446: accel/amdxdna: Fix runtime suspend deadlock when there
is pending job

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43446

Introduced by commit 063db45 ("accel/amdxdna: Enhance runtime power
management") in v6.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b13cb8f48a42ddf6dd98865b673a82e37ff238b]

CVE-2026-43447: iavf: fix PTP use-after-free during reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43447

Introduced by commit 7c01dbf ("iavf: periodically cache PHC time") in v6.15-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efc54fb13d79117a825fef17364315a58682c7ec]
stable/6.18: [1b034f2429ce6b45ce74dc266175d277acafc5c4]

CVE-2026-43448: nvme-pci: Fix race bug in nvme_poll_irqdisable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43448

Introduced by commit fa059b8 (nvme-pci: Simplify nvme_poll_irqdisable)
in v5.7-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc71f409b22ca831a9f87a2712eaa09ef2bb4a5e]
stable/6.1: [265dbc9bc33c29f60f90be3e0afe1c4067ebb70b]
stable/6.12: [843e913cef4e33723663a899727f685a95ab53fe]
stable/6.18: [b56c49897bdac5cb49e3495ef421c391628ee9bb]
stable/6.6: [628773eba024d1107cc9ec157a682cbb42ac912a]

CVE-2026-43449: nvme-pci: Fix slab-out-of-bounds in nvme_dbbuf_set

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43449

Introduced by commit 0f0d2c8 (nvme: free sq/cq dbbuf pointers when
dbbuf set fails) in v5.10-rc5.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [9537060d13a67bc4b0631c1ab58c14294bb9d468]
mainline: [b4e78f1427c7d6859229ae9616df54e1fc05a516]
stable/5.10: [2b9d605c3f0d3262142f196249cd3bd58c857c71]
stable/5.15: [86183d550559e45e07059bbdf17331fea469e38c]
stable/6.1: [d7990c936e25f484b61a5adeeadc1d290a9fd16e]
stable/6.12: [50bad78f03a02d3c0f228edf9912b494d3e7acb9]
stable/6.18: [328c551f0cc81ee776b186b86cc6e5253bb6fda7]
stable/6.6: [83e6edd6358326c9c2de31a54bb4a1ec50703f1f]

CVE-2026-43450: netfilter: nfnetlink_cthelper: fix OOB read in
nfnl_cthelper_dump_table()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43450

Introduced by commit 12f7a50 ("netfilter: add user-space connection
tracking helper infrastructure") in v3.6-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a6dd158155d2c942fb9e7beb6007a41c782535aa]
mainline: [6dcee8496d53165b2d8a5909b3050b62ae71fe89]
stable/5.10: [0605e1985a95d4334a67869aee45a47e82301abf]
stable/5.15: [92441f6d9405a0c18d03f278b395e782f79a4a30]
stable/6.1: [3cc328ffc32ddb389cba7b78b6aa95d995c2876e]
stable/6.12: [894c5780ddadd5fde0e16f66587918e6be1504c4]
stable/6.18: [05018cd9370f77bb18fbf6e15ff33c7a06f10b3c]
stable/6.6: [4a1f6ee69267a5f524102c028981410eeacfa3da]

CVE-2026-43451: netfilter: nfnetlink_queue: fix entry leak in bridge
verdict error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43451

Introduced by commit 8d45ff2 ("netfilter: bridge: nf queue verdict to
use NFQA_VLAN and NFQA_L2HDR") in v4.7-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b0ce34204fa25ae86f09ac6f43f3ff858a3f586b]
mainline: [f1ba83755d81c6fc66ac7acd723d238f974091e9]
stable/5.10: [a907bea273b60d3e604ec4e8e1f6c49954805794]
stable/5.15: [0b18d1b834ab5a5009be70b530f978d7989e445b]
stable/6.1: [b38d2b4603fd3dda24eb8b3dd81c18a0930be97b]
stable/6.12: [cf4a4df38d1747e06fc54f9879bd7a6f4178032f]
stable/6.18: [9853d94b82d303fc4ac37d592a23a154096ecd41]
stable/6.6: [47b1c5d1b0944aa88299f55a846fabaefc756982]

CVE-2026-43452: netfilter: x_tables: guard option walkers against
1-byte tail reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43452

Introduced by commit 2e4e6a1 ("[NETFILTER] x_tables: Abstraction layer
for {ip,ip6,arp}_tables") in v2.6.20.16.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [212599fd56406e3f00b5a8102f426a350b49cb87]
mainline: [cfe770220ac2dbd3e104c6b45094037455da81d4]
stable/5.10: [c2a445367a496a3c25dbc940c10c8bd1cfd4c14a]
stable/5.15: [ae1e1267650638136b84c23f2b31250f0ccb6823]
stable/6.1: [c39f84e4be1be63fc60ca7141ea7b76edcea5907]
stable/6.12: [5b18b8b35c7cded2d17b2b2604c9b0694ff48d1c]
stable/6.18: [bc18551c6169eac5ed813778d3e3e484002dbbe5]
stable/6.6: [9b94f0e42ed248eb31929da84ed9f5310d7ff540]

CVE-2026-43453: netfilter: nft_set_pipapo: fix stack out-of-bounds
read in pipapo_drop()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43453

Introduced by commit 3c4287f ("nf_tables: Add set type for arbitrary
concatenation of ranges") in v5.6-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6d8cd2db236a9dd13dbc2d05843b3445cc964b5]
stable/5.10: [1957e793196e7f8557374fd4eda53abcbb42e1c0]
stable/5.15: [57fb87ca095d5127cd7a27583b8ec43dcf7c9e9e]
stable/6.1: [60c1d18781e37bfb96290b86510eb01c5fa24d75]
stable/6.12: [dfbdac719198778b581bc0dd055df2542edb8c62]
stable/6.18: [e047f6fbb975f685d6c9fcef95b3b7787a79b46d]
stable/6.6: [0a55d62cdb628923d8a21724374a70c76ac7d19d]

CVE-2026-43454: netfilter: nf_tables: Fix for duplicate device in netdev hooks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43454

Introduced by commit a331b78 ("netfilter: nf_tables: Respect
NETDEV_REGISTER events") in v6.16-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7cdc5a97d02c943f4bdde4d5767ad0c13cad92b]
stable/6.18: [6d2a95c6890577cc3eab2b20018e16850d7fb094]

CVE-2026-43455: mctp: route: hold key->lock in mctp_flow_prepare_output()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43455

Introduced by commit 67737c4 ("mctp: Pass flow data & flow release
events to drivers") in v5.16-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d86aa41c073c4e7eb75fd2e674f1fd8f289728a]
stable/6.1: [47893166bc5611ee9a20de6b8d2933b2320fb772]
stable/6.12: [0695712f3a6f1a48915f95767cfb42077683dcdc]
stable/6.18: [925a5ffd99cddd7a7e41d5ad120c7a2c6d50260f]
stable/6.6: [86f5334fcb48a5b611c33364ab52ca684d0f6d91]

CVE-2026-43456: bonding: fix type confusion in bond_setup_by_slave()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43456

Introduced by commit 1284cd3 ("bonding: two small fixes for IPoIB
support") in v2.6.24-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [950803f7254721c1c15858fbbfae3deaaeeecb11]
stable/6.12: [9baf26a91565b7bb2b1d9f99aaf884a2b28c2f6d]
stable/6.18: [6ac890f1d60ac3707ee8dae15a67d9a833e49956]

CVE-2026-43457: mctp: i2c: fix skb memory leak in receive path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43457

Introduced by commit f5b8abf ("mctp i2c: MCTP I2C binding driver") in v5.18-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3f5e0f22cfc2371e7471c9fd5b4da78f9df7c69]
stable/6.1: [0fb2adbdd5c03e8c9ebcdc48afd414b2724c85eb]
stable/6.12: [9f81be2ab9d8e4744871bfb3e868ef413413829f]
stable/6.18: [1ec54187e1aa40a4cfa2b265e9a311179f24b98d]
stable/6.6: [d7900a43b0a314a645ca0a2adf45928dbc7001f4]

CVE-2026-43458: serial: caif: hold tty->link reference in ldisc_open
and ser_release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43458

Introduced by commit e31d5a0 ("caif: tty's are kref objects so take a
reference") in v2.6.35-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [41225d400717b705368cb24b9d21f6c878362b7f]
mainline: [288598d80a068a0e9281de35bcb4ce495f189e2a]
stable/5.10: [23a3ac2e2262a291498567418227b99e1f3606b1]
stable/5.15: [52135420e9f75853ea0c6cea7b736e3e98495f7d]
stable/6.1: [ca2ceba983bb23ea0202c2882d963253416654a3]
stable/6.12: [27e43356d0defb9fc7fa25265219a3ffeb7b3e98]
stable/6.18: [35b58d3bc716ebb9ebd10fe1cac8c1177242511c]
stable/6.6: [8460187b4852fd00bd1c76394358053f3fa4d089]

CVE-2026-43459: ASoC: soc-core: flush delayed work before removing
DAIs and widgets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43459

Introduced by commit e894efe ("ASoC: core: add support to card
rebind") in v4.20-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95bc5c225513fc3c4ce169563fb5e3929fbb938b]
stable/5.10: [bf80a89da97285d9b877e0c6995e870d46b8025c]
stable/5.15: [3887e514978d28216246360b46a9cb534969eb5a]
stable/6.1: [231568afbc0cd25b8fb2a94ebf9738eabe1cf007]
stable/6.12: [eab71e11ce2447c1e01809cbc11eab4234cf8dc8]
stable/6.18: [7d33e6140945482a07f8089ee86e13e02553ffdb]
stable/6.6: [317a9298c54bb00319da73e5a7179f00e67fcbdf]

CVE-2026-43460: spi: rockchip-sfc: Fix double-free in remove() callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43460

Introduced by commit 8011709 ("spi: rockchip-sfc: Support pm ops") in v6.14-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [111e2863372c322e836e0c896f6dd9cf4ee08c71]
stable/6.18: [b6051f2bdd4bd3dde85b68558edd3a6843489221]

CVE-2026-43461: spi: amlogic: spifc-a4: Fix DMA mapping error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43461

Introduced by commit 4670db6 ("spi: amlogic: add driver for Amlogic
SPI Flash Controller") in v6.18-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b20b437666e1cb26a7c499d1664e8f2a0ac67000]
stable/6.18: [0a83d6c9e149a176340190fa9cbadf2266db4c9a]

CVE-2026-43462: net: spacemit: Fix error handling in emac_tx_mem_map()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43462

Introduced by commit bfec6d7 ("net: spacemit: Add K1 Ethernet MAC") in
v6.18-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86292155bea578ebab0ca3b65d4d87ecd8a0e9ea]
stable/6.18: [c34ebd7b24ea70be3c6fdb6936f79f593f37df60]

CVE-2026-43463: rxrpc, afs: Fix missing error pointer check after
rxrpc_kernel_lookup_peer()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43463

Introduced by commit 72904d7 ("rxrpc, afs: Allow afs to pin rxrpc_peer
objects") in v6.8-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4245a79003adf30e67f8e9060915bd05cb31d142]
stable/6.18: [d55fa7cd4b19ba91b34b307d769c149e56ad0a75]

CVE-2026-43464: net/mlx5e: RX, Fix XDP multi-buf frag counting for legacy RQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43464

Introduced by commit afd5ba5 ("net/mlx5e: RX, Fix generating skb from
non-linear xdp_buff for legacy RQ") in v6.18-rc3.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [a6413e6f6c9d9bb9833324cb3753582f7bc0f2fa]
stable/6.18: [c74557495efb4bd0adefdfc8678ecdbc82a06da3]

CVE-2026-43465: net/mlx5e: RX, Fix XDP multi-buf frag counting for striding RQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43465

Introduced by commit 87bcef1 ("net/mlx5e: RX, Fix generating skb from
non-linear xdp_buff for striding RQ") in v6.18-rc3.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [db25c42c2e1f9c0d136420fff5e5700f7e771a6f]
stable/6.18: [7d7342a18fadcdb70a63b3c930dc63528ce51832]

CVE-2026-43466: net/mlx5e: Fix DMA FIFO desync on error CQE SQ recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43466

Introduced by commit db75373 ("net/mlx5e: Recover Send Queue (SQ) from
error state") in v4.17-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1633111d69053512d099658d4a05fc736fab36b0]
stable/5.10: [821f85d619f7f22cda7b9d7de89cf5eeb1d11544]
stable/5.15: [6eb68ecc5acc3b319986566c595990b8a7265b23]
stable/6.1: [6f41f7812bfa7f991b732a4b45c5c52fc4be3b4e]
stable/6.12: [9c5ee9b981ee050b73fdf3f4a2464d6f1a8e10a8]
stable/6.18: [ce1b19dd0684eeb68a124c11085bd611260b36d9]
stable/6.6: [383b37c04a4827ba60b2bafc1a6cdfd995aed58f]

CVE-2026-43467: net/mlx5: Fix crash when moving to switchdev mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43467

Introduced by commit 664f76b ("net/mlx5: Fix IPsec cleanup over MPV
device") in v6.18-rc3.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [24b2795f9683e092dc22a68f487e7aaaf2ddafea]
stable/6.12: [05c9a6df3646cdd25e0e10e6ef2d20cdba3ed8f9]
stable/6.18: [835778685f157b4fd4683b670cfe4010265bac60]

CVE-2026-43468: net/mlx5: Fix deadlock between devlink lock and esw->wq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43468

Introduced by commit f1bc646 ("net/mlx5: Use devl_ API in
mlx5_esw_offloads_devlink_port_register") in v6.0-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aed763abf0e905b4b8d747d1ba9e172961572f57]
stable/6.1: [0de867f6e34eae6907b367fd152c55e61cb98608]
stable/6.12: [3c7313cb41b1b427078440364d2f042c276a1c0b]
stable/6.18: [4a7838bebc38374f74baaf88bf2cf8d439a92923]
stable/6.6: [957d2a58f7f8ebcbdd0a85935e0d2675134b890d]

CVE-2026-43469: xprtrdma: Decrement re_receiving on the early exit paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43469

Introduced by commit 15788d1 ("xprtrdma: Do not refresh Receive Queue
while it is draining") in v5.13-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b6275c80a0c81c5f8943272292dfe67730ce849]
stable/5.15: [7ea69259a60a364f56cf4aa9e2eafb588d1c762b]
stable/6.1: [8cb6b5d8296b1f99a8d36849901ebabfe3f749db]
stable/6.12: [49f53ee4e25297d886f14e31f355ad1c2735ddfb]
stable/6.18: [8127b5fec04757c2a41ed65bca0b3266968efd3b]
stable/6.6: [74c39a47856bddcde7874f2196a00143b5cd0af9]

CVE-2026-43470: nfs: return EISDIR on nfs3_proc_create if d_alias is a dir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43470

Introduced by commit 7c6c524 ("NFS: add atomic_open for NFSv3 to
handle O_TRUNC correctly.") in v6.10-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [410666a298c34ebd57256fde6b24c96bd23059a2]
stable/6.12: [7e2963773760a664684435201960dd2fb712f1b5]
stable/6.18: [203c792cb4315360d49973ae2e57feeb6d3dcf7e]

CVE-2026-43471: scsi: ufs: core: Fix possible NULL pointer dereference
in ufshcd_add_command_trace()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43471

According to the .vulnerable file, this bug was introduced by commit
9307a99 in v6.10.
Fixed in v7.0-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [30df81f2228d65bddf492db3929d9fcaffd38fc5]
stable/6.12: [be730f9ee92ae08f2bc4b336967bcfd8183c06fe]
stable/6.18: [f4f590c6c9df7453bbda2ef9170b1b09e42a124c]
stable/6.6: [0614f5618c24fbc3d555efade22887b102ad7ad6]

CVE-2026-43472: unshare: fix unshare_fs() handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43472

According to the .vulnerable file, this bug was introduced by commit
741a295 in v2.6.20.16.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e7d8d5d5507cc3418c5f38bc854d7ed3c99bf16a]
mainline: [6c4b2243cb6c0755159bd567130d5e12e7b10d9f]
stable/5.10: [845bf3c6963a52096d0d3866e4a92db77a0c03d8]
stable/5.15: [d3ffc8f13034af895531a02c30b1fe3a34b46432]
stable/6.1: [d0d99f60538ddb4a62ccaac2168d8f448965f083]
stable/6.12: [aa9ebc084505fb26dd90f4d7a249045aad152043]
stable/6.18: [af8f4be3b68ac8caa41c8e5ead0eeaf5e85e42d0]
stable/6.6: [d7963d6997fea86a6def242ac36198b86655f912]

CVE-2026-43473: scsi: mpi3mr: Add NULL checks when resetting request
and reply queues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43473

According to the .vulnerable file, this bug was introduced by commit
fe6db61 in v5.17-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa96392ebebc8fade2b878acb14cce0f71016503]
stable/5.15: [f8e833572a3e12a2a1ffe7b3646af024264d38ca]
stable/6.1: [7df0296ad4e9253d12c6dbe7f120044dddc95600]
stable/6.12: [78d3f201f8b609928eade53cf03a52df5415aaf7]
stable/6.18: [e978a36f332ede78eb4de037b517db16265d420d]
stable/6.6: [7da755e0d02e9ca035065127e108d1fed8950dc8]

CVE-2026-43474: fs: init flags_valid before calling vfs_fileattr_get

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43474

According to the .vulnerable file, this bug was introduced by commit
be7efb2 in v6.17-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb184dd19154fc486fa3d9e02afe70a97e54e055]
stable/6.18: [379e19e820dd1c6145426b97467728b3b89c0b42]

CVE-2026-43475: scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43475

According to the .vulnerable file, this bug was introduced by commit
d86adf4 in v4.11-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3b3ca0f8595955a24cbee2dcb79d529d133e6ecc]
mainline: [57297736c08233987e5d29ce6584c6ca2a831b12]
stable/5.10: [cf00cb15f2515e38d3b7571bf6800b7c6ce70a84]
stable/5.15: [b82462af23e45e066dd56d2736ea70159a6ad647]
stable/6.1: [91ab59f76d0866079420ebff1c7959fcd87a242e]
stable/6.12: [f8db760f4f52a73a022a3d6c84c488ead952a9b5]
stable/6.18: [c2e73d8acd056347a70047e6be7cd98e0e811dfa]
stable/6.6: [e7919a293f9b6101e38bde0d8613daea6c9955df]

CVE-2026-43500: rxrpc: Also unshare DATA/RESPONSE packets when paged
frags are present

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43500

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71]
stable/6.18: [3eae0f4f9f7206a4801efa5e0235c25bbd5a412c]
stable/7.0: [d45179f8795222ce858770dc619abe51f9d24411]

CVE-2026-43476: iio: chemical: sps30_i2c: fix buffer size in
sps30_i2c_read_meas()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43476

Introduced by commit 8f3f130 ("iio: sps30: separate core and interface
specific code") in v5.14-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [216345f98cae7fcc84f49728c67478ac00321c87]
stable/5.15: [9aff2e9c2927ecd9652872a43a0725f101128104]
stable/6.1: [08881d82f94deaa51800360029908863e5c4c39d]
stable/6.12: [2a4d111a6a34afb8bb4f118009e7728ed2ec7e10]
stable/6.18: [90e978ace598567e6e30de79805bddf37cf892ac]
stable/6.6: [dcdf1e92674efb6692f4ebe189e0aa9fde23a541]

CVE-2026-43477: drm/i915/vrr: Configure VRR timings after enabling
TRANS_DDI_FUNC_CTL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43477

Introduced by commit dda7dcd ("drm/i915/vrr: Use fixed timings for
platforms that support VRR") in v6.16-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [237aab549676288d9255bb8dcc284738e56eaa31]
stable/6.18: [8a7d29b8bda144d44e61df1b2705b1d4378f4e44]

CVE-2026-43478: ASoC: codecs: rt1011: Use component to get the dapm
context in spk_mode_put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43478

Introduced by commit 5b35bb5 ("ASoC: codecs: rt1011: convert to
snd_soc_dapm_xxx()") in v6.19-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30e4b2290cc2a8d1b9ddb9dcb9c981df1f2a7399]

CVE-2026-43479: net: usb: lan78xx: fix WARN in __netif_napi_del_locked
on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43479

Introduced by commit e110bc8 ("net: usb: lan78xx: Convert to PHYLINK
for improved PHY and MAC management") in v6.17-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [312c816c6bc30342bc30dca0d6db617ab4d3ae4e]
stable/6.18: [20ce2bd1c1848414c5d3520d301ed3f5751ed634]

CVE-2026-43480: ASoC: amd: acp3x-rt5682-max9836: Add missing error
check for clock acquisition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43480

Introduced by commit 6b8e4e7 ("ASoC: amd: Add machine driver for Raven
based platform") in v5.7-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53f3a900e9a383d47af7253076e19f510c5708d0]
stable/5.10: [2dc43ac8da7b2bebc5a51a3d86a6275d78f27cff]
stable/5.15: [4d802f23fcbfec05134653fd001f6c7c3fd55196]
stable/6.1: [2b0c4a399c8d27f20ecf17dda76751141d6dbb59]
stable/6.12: [33de168afdd57265a0e0c20dbd3648a2d8f7cdc4]
stable/6.18: [790851ecc983c719fa2e6adb17b02f3acc1d217d]
stable/6.6: [35c7624d30cb45ec336cd16ce072acc32ae351cb]

CVE-2026-43481: net-shapers: don't free reply skb after genlmsg_reply()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43481

Introduced by commit 4b623f9 ("net-shapers: implement NL get
operation") in v6.13-rc1.
Introduced by commit 553ea9f ("net: shaper: implement introspection
support") in v6.13-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57885276cc16a2e2b76282c808a4e84cbecb3aae]
stable/6.18: [8738dcc844fff7d0157ee775230e95df3b1884d7]

CVE-2026-43482: sched_ext: Disable preemption between scx_claim_exit()
and kicking helper work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43482

Introduced by commit f0e1a06 ("sched_ext: Implement BPF extensible
scheduler class") in v6.12-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83236b2e43dba00bee5b82eb5758816b1a674f6a]
stable/6.12: [41423912f7ac7494ccd6eef411227b4efce740e0]
stable/6.18: [522acaae34aa7e05859260056b39c7c030592a0c]

CVE-2026-43483: KVM: SVM: Set/clear CR8 write interception when AVIC
is (de)activated

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43483

Introduced by commit 3bbf356 ("svm: Do not intercept CR8 when enable
AVIC") in v4.7-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87d0f901a9bd8ae6be57249c737f20ac0cace93d]
stable/6.1: [a4123fe5d9122eef9852e4921f7cc463420f30d4]
stable/6.12: [01651e7751edbbc0fb4598f8367a3dabcfc8c182]
stable/6.18: [ba3bca40f9f25c053f69413e5f4a41dd0fd762bf]
stable/6.6: [816fa1dfae4532e851b1fe6b2434c753ecbd86c7]

CVE-2026-43484: mmc: core: Avoid bitfield RMW for claim/retune flags

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43484

Introduced by commit 6c0cedd ("mmc: core: Introduce host claiming by
context") in v4.15-rc1.
Introduced by commit 1e8e55b ("mmc: block: Add CQE support") in v4.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [901084c51a0a8fb42a3f37d2e9c62083c495f824]
stable/5.15: [41dce4dae583a8ce06a7ebf4ce704c46a142957c]
stable/6.1: [bb7fc2498c3bb25fa6a91f22f4760005325cfbd5]
stable/6.12: [45038e03f15e992c48603fff8c6b1c9be5397ac9]
stable/6.18: [0e06cc511c61cff1591e5435a207759adcc76b6d]
stable/6.6: [270277c2ab631044867adb1bd2f2433d3892de6e]

CVE-2026-43485: nouveau/gsp: drop WARN_ON in ACPI probes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43485

Introduced by commit 176fdcb ("drm/nouveau/gsp/r535: add support for
booting GSP-RM") in v6.7-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9478c166c46934160135e197b049b5a05753f2ad]
stable/6.18: [214b6bde0e941a34ba877cf2f26f85d62fb5d598]

CVE-2026-43486: arm64: contpte: fix set_access_flags() no-op check for
SMMU/ATS faults

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43486

Introduced by commit 4602e57 ("arm64/mm: wire up PTE_CONT for user
mappings") in v6.9-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97c5550b763171dbef61e6239cab372b9f9cd4a2]
stable/6.12: [05d239f2c95e66e27e7fb4e99ee07eb56e3e34b0]
stable/6.18: [6f92a7a8b48a523f910ef25dd83808710724f59b]

CVE-2026-43487: ata: libata-core: Disable LPM on ST1000DM010-2EP102

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43487

Introduced by commit 7627a0e ("ata: ahci: Drop low power policy board
type") in v6.9-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3b1d3ae1d87bc9398fb715c945968bf4c75a09a]
stable/6.12: [f897b72cc74d24e7106716184f450d4045a6289b]
stable/6.18: [87f0349beaacab2ac60c4a1b6dcff254cef7d5a0]

CVE-2026-43488: usb: xhci: Prevent interrupt storm on host controller
error (HCE)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43488

Introduced commit is not determined.Fixed in v7.0-rc4.


Fixed status
mainline: [d6d5febd12452b7fd951fdd15c3ec262f01901a4]
stable/6.12: [6f91f3f087194c114d6d8ea4591b850bb00672f8]
stable/6.18: [cd41e0d1df8fcf5eae294657da52b50d1ce03246]
stable/6.6: [b2dd9abf8c06cfcbcf242321fd54ae51a4807705]

CVE-2026-43489: liveupdate: luo_file: remember retrieve() status

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43489

Introduced by commit 7c722a7 ("liveupdate: luo_file: implement file
systems callbacks") in v6.19-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f85b1c6af5bc3872f994df0a5688c1162de07a62]

CVE-2026-46300: Fragnesia: the Dirty Frag vulnerability class

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46300


This bug is a variant of Dirty Frag vulnerability class. Patch is not
merged in to the mainline as of 2026-05-14.
Bug introduced commit was backported to following branches.
stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6 stable/7.0

Fixed status
Not fixed yet.

* Updated CVEs

CVE-2025-38584: padata: Fix pd UAF once and for all

stable/6.12 was fixed.

Fixed status
stable/6.12: [f231d5d001ec75f5886c02d496a4c79edc383d45]

CVE-2026-23468: drm/amdgpu: Limit BO list entry count to prevent
resource exhaustion

stable/6.12 was fixed.

Fixed status
stable/6.12: [2723e6851309531ce61aed74e93a0cd268cc862a]

CVE-2026-23473: [REJECTED]: io_uring/poll: fix multishot recv missing
EOF on wakeup race

stable/6.12 was fixed.

Fixed status
stable/6.12: [35f1eb2e9812f25425a942b6469b9c9f731e5586]

CVE-2026-31419: net: bonding: fix use-after-free in bond_xmit_broadcast()

stable/6.12 was fixed.

Fixed status
stable/6.12: [3453882f36c40d2339267093676585a89808a73d]

CVE-2026-31589: mm: call ->free_folio() directly in folio_unmap_invalidate()

stable/6.18 was fixed.

Fixed status
stable/6.18: [efc52947247a21bbf79059539bbbd40f4ea76f00]

CVE-2026-31709: smb: client: validate the whole DACL before rewriting
it in cifsacl

stable/6.12 was fixed.

Fixed status
stable/6.12: [d92f3f0b22414e7515696a02224d0af55e3004a3]

CVE-2026-31715: f2fs: fix UAF caused by decrementing sbi->nr_pages[]
in f2fs_write_end_io()

stable/6.12 was fixed.

Fixed status
stable/6.12: [7be222de96c0f9eee6e65eeb017ef855ee185cfa]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

