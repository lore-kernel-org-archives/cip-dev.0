Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38462C36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 22:27:56 +0000 (UTC)
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
 by mx.groups.io with SMTP id smtpd.web10.21159.1744237671066128662
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Apr 2025 15:27:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=YliibLZE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.196, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6ff0c9d1761so2120797b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 09 Apr 2025 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1744237670; x=1744842470; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kG6mwPUJMpPNcVnQrJT0tkHEd+iljU3ydZLlFcDQ+0c=;
        b=YliibLZEI44tvQP1wb2Hl8Tftr4XvQbuqumSIqyzNGgnyZhuOr4a71UGF6c4PAUUO1
         4C9t4TNazyF71ipTRn/Q9Ubei7Zt/+7TRQkaq9k795JM3YezNaPeRRpIUYTAdoPmFpgR
         IKK9sUFcGRE1OyC6ZAmcTtUSSbmaQqXio0AIWetjecnnsbeYfICYMiuha7EoA1PBjyqQ
         cUC5wcrR+QcT98bAG+louvVirfTttGVFTdjqdQrlCjvyPp5m52f9dE12mRYG/YPZp9vK
         oKLYfcTWd9XpBIWlwvmxEp6vUNL7GBHLlO6q9YZKkpSVCTMSNXkXbPHR/nWvYtQQ4tB4
         Ml8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744237670; x=1744842470;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kG6mwPUJMpPNcVnQrJT0tkHEd+iljU3ydZLlFcDQ+0c=;
        b=tlFx7j1FTxVkCZAxdZzGSVVifVGgz4/5K3g+ynu5cih86RF6UD5u3S3vuweNGU2s9W
         q7dH+3Jx3fQ9khQrwHDcF4g8ryLZ04bl6iYJcy1mZT4utIwaNs/g+EaNExE7kMZMw8nC
         pOkBN6/349B/uVqxQrwYpJv5VyyfX4scZf0WaJnjeFKkU3UAMLQgjqXAjcSGXHSCiHcf
         nxSJGaYE0c2QpX67EdRA2tW8igECCt71GFRQ4VTtDaeYsLcApT0k7t0NXXtJtFTgSxA3
         VWdgr9E472wpgo1cVQzKDS3xMkedNHDHBgV0t++AmNqMchL6guPpPlar5cSbVZn4DggH
         MXiw==
X-Gm-Message-State: AOJu0YzsZlZijl0hMwx2fvnVOwwAhAg5UxIOZmvYPKgQ/jEHPu/+kPWm
	dNs3o7u1O8o2vfbwXzkEPgVfna1FxE3E3nDpMvOTIr8MwJG5Oxr//YUzk8OC3NJrTnkttmjxCxK
	6V9knsEIq3V9J2qDTNrBjB+JTcqAgK8c4Qc1bT/nG38ZPw6vhL7AHZbHF
X-Gm-Gg: ASbGncvPe3BZDxYHeGbH41QxKukPUGfdwWLJiPFhB0UWVoWqD92ph7pjZ4nsW49ozMO
	/0rWF9LhFTNGVCeZk+fy+O19EtJcTDVd5Y2ytP44FOeGRcNJKS4N4APRfXdVdPyVD0zZA6X8Ii1
	hQkW7gDSSO5OtvZFD2YpXwVboS7hOpA00dwA==
X-Google-Smtp-Source: AGHT+IH3uANU1g+fShqbRS4JUqopzhJQigSM8DyKEbjBbxcAnFnadyGce33aFXUcXrOaDSyw5d827231BzVi8T4ty0k=
X-Received: by 2002:a05:690c:6309:b0:6f9:50aa:8605 with SMTP id
 00721157ae682-7054a16e5admr7413087b3.34.1744237669667; Wed, 09 Apr 2025
 15:27:49 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Apr 2025 07:27:14 +0900
X-Gm-Features: ATxdqUH7489USzVOJh8CwWAE1YZDLNSt7wJnClpyezMNi-b4WqE3kOLssn8SV2s
Message-ID: <CAODzB9oKVV2Vp9gwB8w8an2gL=WAch4TxuPzOZGsF96L9LvCUQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Apr 2025 22:27:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18500

Hi!

It's this week's CVE report.

This week reported 23 new CVEs and 6 updated CVEs.

* New CVEs

CVE-2025-21995: drm/sched: Fix fence reference count leak

Announce: https://lore.kernel.org/linux-cve-announce/2025040346-CVE-2025-21995-64c3@gregkh/

Introduced by commit 2fdb8a8 ("drm/scheduler: rework entity flush,
kill and fini") in v6.2-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a952f1ab696873be124e31ce5ef964d36bce817f]
stable/6.6: [c76bd3c99293834de7d1dca5de536616d5655e38]

CVE-2025-21996: drm/radeon: fix uninitialized size issue in
radeon_vce_cs_parse()

Announce: https://lore.kernel.org/linux-cve-announce/2025040348-CVE-2025-21996-8e4a@gregkh/

Introduced by commit 2fc5703 ("drm/radeon: check VCE relocation buffer
range v3") in v3.15-rc7.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd8689b52a24807c2d5ce0a17cb26dc87f75235c]
stable/6.1: [78b07dada3f02f77762d0755a96d35f53b02be69]
stable/6.6: [3ce08215cad55c10a6eeeb33d3583b6cfffe3ab8]

CVE-2025-21997: xsk: fix an integer overflow in xp_create_and_assign_umem()

Announce: https://lore.kernel.org/linux-cve-announce/2025040348-CVE-2025-21997-492c@gregkh/

Introduced by commit 94033cd ("xsk: Optimize for aligned case") in v5.16-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [559847f56769037e5b2e0474d3dbff985b98083d]
stable/6.1: [205649d642a5b376724f04f3a5b3586815e43d3b]
stable/6.6: [b7b4be1fa43294b50b22e812715198629806678a]

CVE-2025-21998: firmware: qcom: uefisecapp: fix efivars registration race

Announce: https://lore.kernel.org/linux-cve-announce/2025040348-CVE-2025-21998-b57d@gregkh/

Introduced by commit 6612103 ("firmware: qcom: qseecom: convert to
using the TZ allocator") in v6.11-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da8d493a80993972c427002684d0742560f3be4a]

CVE-2025-21999: proc: fix UAF in proc_get_inode()

Announce: https://lore.kernel.org/linux-cve-announce/2025040348-CVE-2025-21999-bc57@gregkh/

Introduced by commit 778f3dd ("Fix procfs compat_ioctl regression") in
v2.6.23-rc2.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [654b33ada4ab5e926cd9c570196fefa7bec7c1df]
stable/6.1: [966f331403dc3ed04ff64eaf3930cf1267965e53]
stable/6.6: [63b53198aff2e4e6c5866a4ff73c7891f958ffa4]

CVE-2025-22000: mm/huge_memory: drop beyond-EOF folios with the right
number of refs

Announce: https://lore.kernel.org/linux-cve-announce/2025040349-CVE-2025-22000-50c3@gregkh/

Introduced by commit c010d47 ("mm: thp: split huge page to any lower
order pages") in v6.9-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14efb4793519d73fb2902bb0ece319b886e4b4b9]

CVE-2025-22001: accel/qaic: Fix integer overflow in qaic_validate_req()

Announce: https://lore.kernel.org/linux-cve-announce/2025040349-CVE-2025-22001-5187@gregkh/

Introduced by commit ff13be8 ("accel/qaic: Add datapath") in v6.4-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67d15c7aa0864dfd82325c7e7e7d8548b5224c7b]
stable/6.6: [4b2a170c25862ad116bd31be6b9841646b4862e8]

CVE-2025-22002: netfs: Call `invalidate_cache` only if implemented

Announce: https://lore.kernel.org/linux-cve-announce/2025040349-CVE-2025-22002-7f70@gregkh/

Introduced by commit 0e0f2df ("netfs: Dispatch write requests to
process a writeback slice") in v6.8-rc1.
Introduced by commit 288ace2 ("netfs: New writeback implementation")
in v6.10-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [344b7ef248f420ed4ba3a3539cb0a0fc18df9a6c]

CVE-2025-22003: can: ucan: fix out of bound read in strscpy() source

Announce: https://lore.kernel.org/linux-cve-announce/2025040349-CVE-2025-22003-ea29@gregkh/

Introduced by commit 7fdaf89 ("can: ucan: use strscpy() to instead of
strncpy()") in v6.2-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d22a122ffb116c3cf78053e812b8b21f8852ee9]
stable/6.6: [cc29775a8a72d7f3b56cc026796ad99bd65804a7]

CVE-2025-22004: net: atm: fix use after free in lec_send()

Announce: https://lore.kernel.org/linux-cve-announce/2025040349-CVE-2025-22004-64f9@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3009d0d6ab78053117f8857b921a8237f4d17b3]
stable/6.1: [51e8be9578a2e74f9983d8fd8de8cafed191f30c]
stable/6.6: [9566f6ee13b17a15d0a47667ad1b1893c539f730]

CVE-2025-22005: ipv6: Fix memleak of nhc_pcpu_rth_output in
fib_check_nh_v6_gw().

Announce: https://lore.kernel.org/linux-cve-announce/2025040349-CVE-2025-22005-3e0f@gregkh/

Introduced by commit 7dd7316 ("ipv6: Always allocate pcpu memory in a
fib6_nh") in v5.3-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9740890ee20e01f99ff1dde84c63dcf089fabb98]
stable/6.1: [77c41cdbe6bce476e08d3251c0d501feaf10a9f3]
stable/6.6: [119dcafe36795a15ae53351cbbd6177aaf94ffef]

CVE-2025-22006: net: ethernet: ti: am65-cpsw: Fix NAPI registration sequence

Announce: https://lore.kernel.org/linux-cve-announce/2025040350-CVE-2025-22006-d1a7@gregkh/

Introduced by commit 681eb2b ("net: ethernet: ti: am65-cpsw: ensure
proper channel cleanup in error path") in 6.14-rc1. Fixed in 6.14.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13

Fixed status
mainline: [5f079290e5913a0060e059500b7d440990ac1066]

CVE-2025-22007: Bluetooth: Fix error code in chan_alloc_skb_cb()

Announce: https://lore.kernel.org/linux-cve-announce/2025040350-CVE-2025-22007-40b3@gregkh/

Introduced by commit 6b8d4a6 ("Bluetooth: 6LoWPAN: Use connected
oriented channel instead of fixed one") in v3.17-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72d061ee630d0dbb45c2920d8d19b3861c413e54]
stable/6.1: [788ae2ae4cf484e248b5bc29211c7ac6510e3e92]
stable/6.6: [ecd06ad0823a90b4420c377ef8917e44e23ee841]

CVE-2025-22008: regulator: check that dummy regulator has been probed
before using it

Announce: https://lore.kernel.org/linux-cve-announce/2025040841-CVE-2025-22008-af1a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14.
It looks as if following each commit appears to contain its own vulnerability.
Commit 9f7e25e ("regulator: core: Handle full constraints systems when
resolving supplies") in 4.2-rc4.
Commit f5c042b ("regulator: workaround self-referent regulators") in 5.10-rc5.
Commit a4d7641 ("regulator: core: simplify _regulator_get()") 4.11-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
mainline: [2c7a50bec4958f1d1c84d19cde518d0e96a676fd]
stable/6.1: [270fe5c090f62dfce1cad0f5053e4827a6f50df4]
stable/6.6: [998b1aae22dca87da392ea35f089406cbef6032d]

CVE-2025-22009: regulator: dummy: force synchronous probing

Announce: https://lore.kernel.org/linux-cve-announce/2025040842-CVE-2025-22009-2b2b@gregkh/

Introduced by commit 259b93b ("regulator: Set
PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14") in
v6.4-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8619909b38eeebd3e60910158d7d68441fc954e9]
stable/6.6: [e26f24ca4fb940b15e092796c5993142a2558bd9]

CVE-2025-22010: RDMA/hns: Fix soft lockup during bt pages loop

Announce: https://lore.kernel.org/linux-cve-announce/2025040843-CVE-2025-22010-82d7@gregkh/

Introduced by commit 38389ea ("RDMA/hns: Add mtr support for mixed
multihop addressing") in v5.3-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25655580136de59ec89f09089dd28008ea440fc9]
stable/6.1: [4104b0023ff66b5df900d23dbf38310893deca79]
stable/6.6: [975355faba56c0751292ed15a90c3e2c7dc0aad6]

CVE-2025-22011: ARM: dts: bcm2711: Fix xHCI power-domain

Announce: https://lore.kernel.org/linux-cve-announce/2025040843-CVE-2025-22011-9e83@gregkh/

Introduced by commit 522c35e ("ARM: dts: bcm2711: Add BCM2711 xHCI
support") in v6.8-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f44fa354a0715577ca32b085f6f60bcf32c748dd]

CVE-2025-22012: Revert "arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu"

Announce: https://lore.kernel.org/linux-cve-announce/2025040843-CVE-2025-22012-e03f@gregkh/

Introduced by commit 6b31a97 ("arm64: dts: qcom: sdm845: Affirm
IDR0.CCTW on apps_smmu") in v6.13-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f00db31d235946853fb430de8c6aa1295efc8353]

CVE-2025-22013: KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state

Announce: https://lore.kernel.org/linux-cve-announce/2025040843-CVE-2025-22013-c885@gregkh/

Introduced by commit 93ae6b0 ("KVM: arm64: Discard any SVE state when
entering KVM guests") in v6.2-rc1.
Introduced by commit 8c845e2 ("arm64/sve: Leave SVE enabled on syscall
if we don't context switch") in v6.2-rc1.
Introduced by commit ef3be86 ("KVM: arm64: Add save/restore support
for FPMR") in v6.12-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbc7e61195e23f744814e78524b73b59faa54ab4]
stable/6.6: [806d5c1e1d2e5502175a24bf70f251648d99c36a]

CVE-2025-22014: soc: qcom: pdr: Fix the potential deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2025040843-CVE-2025-22014-9c4f@gregkh/

Introduced by commit fbe639b ("soc: qcom: Introduce Protection Domain
Restart helpers") in v5.7-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2eeb03ad9f42dfece63051be2400af487ddb96d2]
stable/6.1: [0a566a79aca9851fae140536e0fc5b0853c90a90]
stable/6.6: [f2bbfd50e95bc117360f0f59e629aa03d821ebd6]

CVE-2025-22015: mm/migrate: fix shmem xarray update during migration

Announce: https://lore.kernel.org/linux-cve-announce/2025040843-CVE-2025-22015-3408@gregkh/

Introduced by commit fc346d0 ("mm: migrate high-order folios in swap
cache correctly") in v6.7-rc8.
Fixed in v6.14.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [60cf233b585cdf1f3c5e52d1225606b86acd08b0]
stable/6.1: [49100c0b070e900f87c8fac3be9b9ef8a30fa673]
stable/6.6: [29124ae980e2860f0eec7355949d3d3292ee81da]

CVE-2025-22016: dpll: fix xa_alloc_cyclic() error handling

Announce: https://lore.kernel.org/linux-cve-announce/2025040844-CVE-2025-22016-ac9d@gregkh/

Introduced by commit 97f265e ("dpll: allocate pin ids in cycle") in v6.8-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3614bf90130d60f191a5fe218d04f6251c678e13]

CVE-2025-22017: devlink: fix xa_alloc_cyclic() error handling

Announce: https://lore.kernel.org/linux-cve-announce/2025040844-CVE-2025-22017-a66e@gregkh/

Introduced by commit c137743 ("devlink: introduce object and nested
devlink relationship infra") in v6.7-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3b97b7d4bf316c3991e5634c9f4847c2df35478]


* Updated CVEs

CVE-2024-38611: media: i2c: et8ek8: Don't strip remove function when
driver is builtin

stable/6.1 was fixed.

Fixed status
stable/6.1: [04d1086a62ac492ebb6bb0c94c1c8cb55f5d1f36]
stable/6.6: [c1a3803e5bb91c13e9ad582003e4288f67f06cd9]
stable/6.9: [904db2ba44ae60641b6378c5013254d09acf5e80]

CVE-2024-46772: drm/amd/display: Check denominator crb_pipes before used

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [04805efe8623f8721f3c01182ea73d68e88c62d8]
stable/6.10: [ede06d23392529b039cf7ac11b5875b047900f1c]
stable/6.6: [b9264aa24f628eba5779d1c916441e0cedde9b3d]

CVE-2024-50056: usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [03fa71e97e9bb116993ec1d51b8a6fe776db0984]
stable/6.11: [cedeb36c3ff4acd0f3d09918dfd8ed1df05efdd6]
stable/6.6: [72a68d2bede3284b95ee93a5ab3a81758bba95b0]

CVE-2024-50137: reset: starfive: jh71x0: Fix accessing the empty
member on JH7110 SoC

stable/6.6 was fixed.

Fixed status
stable/6.11: [c923f1fb8ae8627322d167b73bb4f978404a05de]
stable/6.6: [3918b2016d28c9b2bddd5ab194ab366a4e2310f5]

CVE-2024-56620: scsi: ufs: qcom: Only free platform MSIs when ESI is enabled

stable/6.6 was fixed.

Fixed status
stable/6.12: [f99cb5f6344ef93777fd3add7979ebf291a852df]
stable/6.6: [f16a097047e38dcdd169a15e3eed1b2f2147a2e7]

CVE-2025-21918: usb: typec: ucsi: Fix NULL pointer access

stable/6.1 was fixed.

Fixed status
stable/6.1: [7a735a8a46f6ebf898bbefd96659ca5da798bce0]
stable/6.12: [079a3e52f3e751bb8f5937195bdf25c5d14fdff0]
stable/6.13: [592a0327d026a122e97e8e8bb7c60cbbe7697344]
stable/6.6: [46fba7be161bb89068958138ea64ec33c0b446d4]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

