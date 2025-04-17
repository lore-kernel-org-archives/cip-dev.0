Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24DC369BD
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 00:05:17 +0000 (UTC)
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
 by mx.groups.io with SMTP id smtpd.web11.34102.1744848308547565384
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 17:05:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=ImsJVB4L;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.196, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e63a159525bso208279276.2
        for <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 17:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1744848307; x=1745453107; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xyh/0OLEVIsv8HLepy7KUdsoo3lu5Jv8Bgajr8lldhs=;
        b=ImsJVB4Lob9ItUPrYJrhiqOuCftFG+3D3e++PWpJkK2u6LYWuY3Li0Ttio15z1diNM
         5z4MnDHfHWF9KT+gVVYii9slB/1gZEWAIFDZ5lFbKQfkFh7mpC4qdfSSsjrs8G1c1MM9
         fvHIts0/0BeoJ336EZ+K6e/iynhqASHGQ1n7CASrdpOEjHBFhuC1R9IalbYXT1gpAVOU
         KH9z1A0fEftubJCwHoml+sJv0CNaMeubGuPKA//0k7VKw4RC6oaYaC6cf/zjt9cbwVd1
         nvjkvNakjfnZraevYq5UZsYlkAmiWa19tf4DF1GJYBiF37TsShe2jV9AMnew/4OdWgYP
         ux6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744848307; x=1745453107;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xyh/0OLEVIsv8HLepy7KUdsoo3lu5Jv8Bgajr8lldhs=;
        b=c/Jt1e41eMRJrUOp346tttjzwVrNDxWVmqKBfb7aJol4x7UryG7EFmThSwgaxV1/p3
         jn/dhB2wWblnmcIxahDfmQoPeaImnkjNHL96O+QVIo2vuToEldW3/RiqyO1yZtjCDxh3
         rcaVj76jheLDlrEjBgmxEjn40c7pSYNn7w+F/anKQ+krOxZP1w6VqH8GfSN4OR+YV9tY
         S00QpNUTGu/aCLzoVCdSvLp7zYSQiSuTKBzQWTlEGvJbomoLusF+j0ehRv1UShKxWUVW
         GTi0lsmM2EYQ0xK3sToPf/zxXBYflKdNOvgKjCraj/wnN7Vv9mZjob4rBfqjzqEVZ5Yq
         suzA==
X-Gm-Message-State: AOJu0YxcL24o+2A1Hwd2PcDjTbxlHxajq4K5mtuVdNnWSKYHcY349Vj2
	Fn1SIhBVfyob8ZTQogDQ6EaRgTmq8H+aTZfv39TEOlc8D5hG8JZTkSqUEyAz1txOjg0se8wzWtw
	UbHned5PzqaLHr9XoVaVpu8xXAJ7ahmm0MA3W2izONy41V8MzzbNjVnGN
X-Gm-Gg: ASbGncvC12cFKoaw0HGS5Pgm/MtKAcCxG6fDpy1LLp4Qs18lRt5Q2X5cKCHLSkTSQ01
	OXBzwXW9gtqjt/WvWE+KJVpEGO0N03hNn94YhvagDNQG1/Zdtvqs1Kyqwgcppcgckr3s7H2EfO6
	B4HOeRY5k2W9+bGCWNMD3saqQjJUDbJj8Zqw==
X-Google-Smtp-Source: AGHT+IH+ogm8GfgArlo3QsbSPmeXHM45YFbCzR8UY7WdlYxFweRWR2sdOB0mpJb8nx7T00sCabjaIJKYfqlto9rRuMo=
X-Received: by 2002:a05:6902:2e0f:b0:e6b:8256:5d67 with SMTP id
 3f1490d57ef6-e7275900d71mr5683153276.7.1744848305470; Wed, 16 Apr 2025
 17:05:05 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Apr 2025 09:04:29 +0900
X-Gm-Features: ATxdqUHt4apKBCxzP62P3MIJZyNStAJIGxHZBf-wav6AUgZ6WECVXTg7JMqjkng
Message-ID: <CAODzB9rbKNqrM3-+VouQDgTWEiyB3-GYgtBFB46aRaU=_BdUPw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 00:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18515

Hi!

It's this week's CVE report.

This week reported 128 new CVEs and 40 updated CVEs.

* New CVEs

CVE-2023-53034: ntb_hw_switchtec: Fix shift-out-of-bounds in
switchtec_ntb_mw_set_trans

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53034

Introduced by commit 1e2fd20 ("ntb_hw_switchtec: Check for alignment
of the buffer in mw_set_trans()") in v4.16-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de203da734fae00e75be50220ba5391e7beecdf9]
stable/5.10: [5b6857bb3bfb0dae17fab1e42c1e82c204a508b1]
stable/5.15: [2429bdf26a0f3950fdd996861e9c1a3873af1dbe]
stable/5.4: [f56951f211f181410a383d305e8d370993e45294]
stable/6.1: [7ed22f8d8be26225a78cf5e85b2036421a6bf2d5]
stable/6.6: [c61a3f2df162ba424be0141649a9ef5f28eaccc1]

CVE-2024-58092: nfsd: fix legacy client tracking initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58092

Introduced by commit 74fd487 ("nfsd: new Kconfig option for legacy
client tracking") in v6.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de71d4e211eddb670b285a0ea477a299601ce1ca]

CVE-2024-58093: PCI/ASPM: Fix link state exit during switch upstream
function removal

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58093

Introduced by commit 456d8aa ("PCI/ASPM: Disable ASPM on MFD function
removal to avoid use-after-free") in v6.5-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [cbf937dcadfd571a434f8074d057b32cd14fbea5]
stable/5.10: [62db339ecc3d58d8fd83a9e4d80061cd943bb6e2]
stable/5.15: [e5cd58f61e9d8024ee11bd78c12c8916891d4077]
stable/5.4: [0a0f9aecf66b98959aab7fb5764b4b3e522f4f5b]
stable/6.1: [cd4b07507794f7ad1a74e12eca75121d98187e66]
stable/6.6: [8b930ddc2044e36866c41423e89889e0258695a3]

CVE-2024-58094: jfs: add check read-only before truncation in
jfs_truncate_nolock()

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58094

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5799dd77054c1ec49b0088b006c9908e256843b]

CVE-2024-58095: jfs: add check read-only before txBeginAnon() call

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58095

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0176e69743ecc02961f2ae1ea42439cd2bf9ed58]

CVE-2024-58096: wifi: ath11k: add srng->lock for ath11k_hal_srng_* in
monitor mode

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58096

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63b7af49496d0e32f7a748b6af3361ec138b1bd3]

CVE-2024-58097: wifi: ath11k: fix RCU stall while reaping monitor
destination ring

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58097

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16c6c35c03ea73054a1f6d3302a4ce4a331b427d]

CVE-2025-22018: atm: Fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22018

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf2986fcf82a449441f9ee4335df19be19e83970]
stable/5.10: [1505f9b720656b17865e4166ab002960162bf679]
stable/5.15: [d7f1e4a53a51cc6ba833afcb40439f18dab61c1f]
stable/5.4: [ab92f51c7f53a08f1a686bfb80690ebb3672357d]
stable/6.1: [0ef6e49881b6b50ac454cb9d6501d009fdceb6fc]
stable/6.6: [9da6b6340dbcf0f60ae3ec6a7d6438337c32518a]

CVE-2025-22019: bcachefs: bch2_ioctl_subvolume_destroy() fixes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22019

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Affected function was added by commit 42d2373 ("bcachefs: Snapshot
creation, deletion")
in 6.7-rc1.

Fixed status
mainline: [707549600c4a012ed71c0204a7992a679880bf33]

CVE-2025-22020: memstick: rtsx_usb_ms: Fix slab-use-after-free in
rtsx_usb_ms_drv_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22020

Introduced by commit 6827ca5 ("memstick: rtsx_usb_ms: Support runtime
power management") in v5.0-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4676741a3464b300b486e70585c3c9b692be1632]
stable/5.10: [9dfaf4d723c62bda8d9d1340e2e78acf0c190439]
stable/5.15: [31f0eaed6914333f42501fc7e0f6830879f5ef2d]
stable/5.4: [914c5e5bfceb9878f3056eaf4d1c88f2cbe0a185]
stable/6.1: [52d942a5302eefb3b7a3bfee310a5a33feeedc21]
stable/6.6: [6186fb2cd36317277a8423687982140a7f3f7841]

CVE-2025-22021: netfilter: socket: Lookup orig tuple for IPv6 SNAT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22021

Introduced by commit eb31628 ("netfilter: nf_tables: Add support for
IPv6 NAT") in v3.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [932b32ffd7604fb00b5c57e239a3cc4d901ccf6e]
stable/5.10: [58ab63d3ded2ca6141357a2b24eee8453d0f871d]
stable/5.15: [1ca2169cc19dca893c7aae6af122852097435d16]
stable/5.4: [6488b96a79a26e19100ad872622f04e93b638d7f]
stable/6.1: [1ec43100f7123010730b7ddfc3d5c2eac19e70e7]
stable/6.6: [5251041573850e5020cd447374e23010be698898]

CVE-2025-22022: usb: xhci: Apply the link chain quirk on NEC isoc endpoints

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22022

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [bb0ba4cb1065e87f9cc75db1fa454e56d0894d01]

CVE-2025-22023: usb: xhci: Don't skip on Stopped - Length Invalid

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22023

Introduced by commit d56b0b2 ("usb: xhci: ensure skipped isoc TDs are
returned when isoc ring is stopped") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58d0a3fab5f4fdc112c16a4c6d382f62097afd1c]

CVE-2025-22024: nfsd: fix management of listener transports

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22024

Introduced by commit 16a4711 ("NFSD: add listener-{set,get} netlink
command") in v6.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d093c90892607be505e801469d6674459e69ab89]

CVE-2025-22025: nfsd: put dl_stid if fail to queue dl_recall

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22025

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [230ca758453c63bd38e4d9f4a21db698f7abada8]
stable/5.10: [b874cdef4e67e5150e07eff0eae1cbb21fb92da1]
stable/5.15: [cdb796137c57e68ca34518d53be53b679351eb86]
stable/6.1: [d96587cc93ec369031bcd7658c6adc719873c9fd]
stable/6.6: [9a81cde8c7ce65dd90fb47ceea93a45fc1a2fbd1]

CVE-2025-22026: nfsd: don't ignore the return code of svc_proc_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22026

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [930b64ca0c511521f0abdd1d57ce52b2a6e3476b]

CVE-2025-22027: media: streamzap: fix race between device
disconnection and urb callback

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22027

Introduced by commit 8e9e606 ("V4L/DVB: staging/lirc: port
lirc_streamzap to ir-core") in v2.6.36-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f656cfbc7a293a039d6a0c7100e1c846845148c1]
stable/6.1: [30ef7cfee752ca318d5902cb67b60d9797ccd378]
stable/6.6: [15483afb930fc2f883702dc96f80efbe4055235e]

CVE-2025-22028: media: vimc: skip .s_stream() for stopped entities

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22028

Introduced by commit adc589d ("media: vimc: Add vimc-streamer for
stream control") in v5.1-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [36cef585e2a31e4ddf33a004b0584a7a572246de]

CVE-2025-22029: exec: fix the racy usage of fs_struct->in_exec

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22029

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [af7bb0d2ca459f15cb5ca604dab5d9af103643f0]
stable/6.6: [753a620a7f8e134b444f89fe90873234e894e21a]

CVE-2025-22030: mm: zswap: fix crypto_free_acomp() deadlock in
zswap_cpu_comp_dead()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22030

Introduced by commit 12dcb0e ("mm: zswap: properly synchronize freeing
resources during CPU hotunplug") in v6.13.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [c11bcbc0a517acf69282c8225059b2a8ac5fe628]

CVE-2025-22031: PCI/bwctrl: Fix NULL pointer dereference on bus number
exhaustion

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22031

Introduced by commit 665745f ("PCI/bwctrl: Re-add BW notification
portdrv as PCIe BW controller") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [667f053b05f00a007738cd7ed6fa1901de19dc7e]

CVE-2025-22032: wifi: mt76: mt7921: fix kernel panic due to null
pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22032

Introduced by commit 90c1028 ("wifi: mt76: mt7925: Update
mt792x_rx_get_wcid for per-link STA") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13

Fixed status
mainline: [adc3fd2a2277b7cc0b61692463771bf9bd298036]

CVE-2025-22033: arm64: Don't call NULL in do_compat_alignment_fixup()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22033

Introduced by commit 3fc24ef ("arm64: compat: Implement misalignment
fixups for multiword loads") in v6.1-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c28f31deeacda307acfee2f18c0ad904e5123aac]
stable/6.1: [cf187601053ecaf671ae645edb898901f81d03e9]
stable/6.6: [617a4b0084a547917669fef2b54253cc9c064990]

CVE-2025-22034: mm/gup: reject FOLL_SPLIT_PMD with hugetlb VMAs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22034

Introduced by commit 9cb28da ("mm/gup: handle hugetlb in the generic
follow_page_mask code") in v6.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8977752c8056a6a094a279004a49722da15bace3]

CVE-2025-22035: tracing: Fix use-after-free in
print_graph_function_flags during tracer switching

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22035

Introduced by commit eecb91b ("tracing: Fix memleak due to race
between current_tracer and trace") in v6.5.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [7f81f27b1093e4895e87b74143c59c055c3b1906]
stable/5.10: [de7b309139f862a44379ecd96e93c9133c69f813]
stable/5.15: [81a85b12132c8ffe98f5ddbdc185481790aeaa1b]
stable/5.4: [42561fe62c3628ea3bc9623f64f047605e98857f]
stable/6.1: [a2cce54c1748216535dda02e185d07a084be837e]
stable/6.6: [099ef3385800828b74933a96c117574637c3fb3a]

CVE-2025-22036: exfat: fix random stack corruption after get_block

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22036

Introduced by commit 11a347f ("exfat: change to get file size from
DataLength") in v6.8-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bb7ff4204b6d4927e982cd256286c09ed4fd8ca]

CVE-2025-22037: ksmbd: fix null pointer dereference in alloc_preauth_hash()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22037

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ksbmd is introduced by 5.15

Fixed status
mainline: [c8b5b7c5da7d0c31c9b7190b4a7bba5281fc4780]

CVE-2025-22038: ksmbd: validate zero num_subauth before sub_auth is accessed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22038

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ksmbd is introduced by 5.15.

Fixed status
mainline: [bf21e29d78cd2c2371023953d9c82dfef82ebb36]
stable/6.1: [3ac65de111c686c95316ade660f8ba7aea3cd3cc]
stable/6.6: [0e36a3e080d6d8bd7a34e089345d043da4ac8283]

CVE-2025-22039: ksmbd: fix overflow in dacloffset bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22039

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ksmbd is introduced by 5.15.

Fixed status
mainline: [beff0bc9d69bc8e733f9bca28e2d3df5b3e10e42]

CVE-2025-22040: ksmbd: fix session use-after-free in multichannel connection

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22040

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ksmbd is introduced by 5.15.

Fixed status
mainline: [fa4cdb8cbca7d6cb6aa13e4d8d83d1103f6345db]
stable/6.1: [596407adb9af1ee75fe7c7529607783d31b66e7f]
stable/6.6: [3980770cb1470054e6400fd97668665975726737]

CVE-2025-22041: ksmbd: fix use-after-free in ksmbd_sessions_deregister()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22041

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ksmbd is introduced by 5.15.

Fixed status
mainline: [15a9605f8d69dc85005b1a00c31a050b8625e1aa]
stable/6.1: [f0eb3f575138b816da74697bd506682574742fcd]
stable/6.6: [a8a8ae303a8395cbac270b5b404d85df6ec788f8]

CVE-2025-22042: ksmbd: add bounds check for create lease context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22042

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ksmbd is introduced by 5.15.

Fixed status
mainline: [bab703ed8472aa9d109c5f8c1863921533363dae]
stable/6.1: [629dd37acc336ad778979361c351e782053ea284]
stable/6.6: [60b7207893a8a06c78441934931a08fdad63f18e]

CVE-2025-22043: ksmbd: add bounds check for durable handle context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22043

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ksmbd is introduced by 5.15.

Fixed status
mainline: [542027e123fc0bfd61dd59e21ae0ee4ef2101b29]
stable/6.6: [8d4848c45943c9cf5e86142fd7347efa97f497db]

CVE-2025-22044: acpi: nfit: fix narrowing conversion in acpi_nfit_ctl

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22044

Introduced by commit 6450ddb ("ACPI: NFIT: Define runtime firmware
activation commands") in v5.9-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ff0e408db36c21ed3fa5e3c1e0e687c82cf132f]
stable/5.10: [4b65cff06a004ac54f6ea8886060f0d07b1ca055]
stable/5.15: [92ba06aef65522483784dcbd6697629ddbd4c4f9]
stable/6.1: [bae5b55e0f327102e78f6a66fb127275e9bc91b6]
stable/6.6: [c90402d2a226ff7afbe1d0650bee8ecc15a91049]

CVE-2025-22045: x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22045

Introduced by commit 016c4d9 ("x86/mm/tlb: Add freed_tables argument
to flush_tlb_mm_range") in v4.20-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ef938c3503563bfc2ac15083557f880d29c2e64]
stable/5.10: [556d446068f90981e5d71ca686bdaccdd545d491]
stable/5.15: [0a8f806ea6b5dd64b3d1f05ff774817d5f7ddbd1]
stable/5.4: [618d5612ecb7bfc1c85342daafeb2b47e29e77a3]
stable/6.1: [0708fd6bd8161871bfbadced2ca4319b84ab44fe]
stable/6.6: [7085895c59e4057ffae17f58990ccb630087d0d2]

CVE-2025-22046: uprobes/x86: Harden uretprobe syscall trampoline check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22046

Introduced by commit ff474a7 ("uprobe: Add uretprobe syscall to speed
up return probe") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa6192adc32f4fdfe5b74edd5b210e12afd6ecc0]

CVE-2025-22047: x86/microcode/AMD: Fix __apply_microcode_amd()'s return value

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22047

Introduced by commit 50cef76 ("x86/microcode/AMD: Load only
SHA256-checksummed patches") in v6.14-rc6.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13 stable/6.6

Fixed status
mainline: [31ab12df723543047c3fc19cb8f8c4498ec6267f]
stable/6.6: [763f4d638f71cb45235395790a46e9f9e84227fd]

CVE-2025-22048: LoongArch: BPF: Don't override subprog's return value

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22048

Introduced by commit 73c359d ("LoongArch: BPF: Sign-extend return
values") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [60f3caff1492e5b8616b9578c4bedb5c0a88ed14]
stable/6.6: [7df2696256a034405d3c5a71b3a4c54725de4404]

CVE-2025-22049: LoongArch: Increase ARCH_DMA_MINALIGN up to 16

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22049

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [4103cfe9dcb88010ae4911d3ff417457d1b6a720]
stable/6.1: [f39af67f03b564b763b06e44cb960c10a382d54a]
stable/6.6: [279ec25c2df49fba1cd9488f2ddd045d9cb2112e]

CVE-2025-22050: usbnet:fix NPE during rx_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22050

Introduced by commit 04e9068 ("usbnet: fix cyclical race on disconnect
with work queue") in v6.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [51de3600093429e3b712e5f091d767babc5dd6df]
stable/5.15: [95789c2f94fd29dce8759f9766baa333f749287c]
stable/6.1: [0f10f83acfd619e13c64d6705908dfd792f19544]
stable/6.6: [acacd48a37b52fc95f621765762c04152b58d642]

CVE-2025-22051: staging: gpib: Fix Oops after disconnect in agilent usb

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22051

Introduced by commit fbae709 ("staging: gpib: Update messaging and
usb_device refs in agilent_usb") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8491e73a5223acb0a4b4d78c3f8b96aa9c5e774d]

CVE-2025-22052: staging: gpib: Fix Oops after disconnect in ni_usb

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22052

Introduced by commit 4934b98 ("staging: gpib: Update messaging and
usb_device refs in ni_usb") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a239c6e91b665f1837cf57b97fe638ef1baf2e78]

CVE-2025-22053: net: ibmveth: make veth_pool_store stop hanging

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22053

Introduced by commit 860f242 ("[PATCH] ibmveth change buffer pools
dynamically") in v2.6.20.16.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [053f3ff67d7feefc75797863f3d84b47ad47086f]
stable/6.6: [1e458c292f4c687dcf5aad32dd4836d03cd2191f]

CVE-2025-22054: arcnet: Add NULL check in com20020pci_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22054

Introduced by commit 6b17a59 ("arcnet: restoring support for multiple
Sohard Arcnet cards") in v6.7-rc5.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [fda8c491db2a90ff3e6fbbae58e495b4ddddeca3]
stable/5.10: [905a34dc1ad9a53a8aaaf8a759ea5dbaaa30418d]
stable/5.15: [ef8b29398ea6061ac8257f3e45c9be45cc004ce2]
stable/5.4: [661cf5d102949898c931e81fd4e1c773afcdeafa]
stable/6.1: [be8a0decd0b59a52a07276f9ef3b33ef820b2179]
stable/6.6: [ececf8eff6c25acc239fa8f0fd837c76bc770547]

CVE-2025-22055: net: fix geneve_opt length integer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22055

Introduced by commit 925d844 ("netfilter: nft_tunnel: add support for
geneve opts") in v5.7-rc1.
Introduced by commit 4ece477 ("lwtunnel: add options setting and
dumping for geneve") in v5.5-rc1.
Introduced by commit 0ed5269 ("net/sched: add tunnel option support to
act_tunnel_key") in v4.19-rc1.
Introduced by commit 0a6e777 ("net/sched: allow flower to match tunnel
options") in v4.19-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b27055a08ad4b415dcf15b63034f9cb236f7fb40]
stable/5.10: [a2cb85f989e2074e2f392e00188c438cab3de088]
stable/5.15: [b4513ad0f391871d3feee8ddf535609a3aabeeac]
stable/6.1: [21748669c5825761cbbf47cbeeb01387ddccc8cb]
stable/6.6: [5a2976cc4d9c36ff58a0f10e35ce4283cbaa9c0e]

CVE-2025-22056: netfilter: nft_tunnel: fix geneve_opt type confusion addition

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22056

Introduced by commit 925d844 ("netfilter: nft_tunnel: add support for
geneve opts") in v5.7-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b755d8eb1ace3870789d48fbd94f386ad6e30be]
stable/5.10: [31d49eb436f2da61280508d7adf8c9b473b967aa]
stable/5.15: [ca2adfc03cd6273f0b589fe65afc6f75e0fe116e]
stable/6.1: [a263d31c8c92e5919d41af57d9479cfb66323782]
stable/6.6: [28d88ee1e1cc8ac2d79aeb112717b97c5c833d43]

CVE-2025-22057: net: decrease cached dst counters in dst_release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22057

Introduced by commit d71785f ("net: add dst_cache to ovs vxlan
lwtunnel") in v4.6-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a0a3ff6593d670af2451ec363ccb7b18aec0c0a]
stable/6.6: [ccc331fd5bcae131d2627d5ef099d4a1f6540aea]

CVE-2025-22058: udp: Fix memory accounting leak.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22058

Introduced by commit f970bd9 ("udp: implement memory accounting
helpers") in v4.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df207de9d9e7a4d92f8567e2c539d9c8c12fd99d]
stable/6.1: [9122fec396950cc866137af7154b1d0d989be52e]
stable/6.6: [aeef6456692c6f11ae53d278df64f1316a2a405a]

CVE-2025-22059: udp: Fix multiple wraparounds of sk->sk_rmem_alloc.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22059

Introduced by commit 6a1f12d ("udp: relax atomic operation on
sk->sk_rmem_alloc") in v6.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a465a0da13ee9fbd7d3cd0b2893309b0fe4b7e3]

CVE-2025-22060: net: mvpp2: Prevent parser TCAM memory corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22060

Introduced by commit 3f51850 ("ethernet: Add new driver for Marvell
Armada 375 network unit") in v3.17-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96844075226b49af25a69a1d084b648ec2d9b08d]
stable/5.15: [e3711163d14d02af9005e4cdad30899c565f13fb]
stable/6.1: [b3f48a41a00d6d8d9c6fe09ae47dd21c8c1c8b03]
stable/6.6: [5b0ae1723a7d9574ae1aee7d9cf9757a30069865]

CVE-2025-22061: net: airoha: Fix qid report in
airoha_tc_get_htb_get_leaf_queue()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22061

Introduced by commit ef1ca92 ("net: airoha: Add sched HTB offload
support") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57b290d97c6150774bf929117ca737a26d8fc33d]

CVE-2025-22062: sctp: add mutual exclusion in proc_sctp_do_udp_port()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22062

Introduced by commit 046c052 ("sctp: enable udp tunneling socks") in v5.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10206302af856791fbcc27a33ed3c3eb09b2793d]

CVE-2025-22063: netlabel: Fix NULL pointer exception caused by CALIPSO
on IPv4 sockets

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22063

Introduced by commit ceba183 ("calipso: Set the calipso socket label
to match the secattr.") in v4.8-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [078aabd567de3d63d37d7673f714e309d369e6e2]
stable/5.10: [1e38f7a6cdd68377f8a4189b2fbaec14a6dd5152]
stable/5.15: [a7e89541d05b98c79a51c0f95df020f8e82b62ed]
stable/5.4: [1ad9166cab6a0f5c0b10344a97bdf749ae11dcbf]
stable/6.1: [797e5371cf55463b4530bab3fef5f27f7c6657a8]
stable/6.6: [1927d0bcd5b81e80971bf6b8eba267508bd1c78b]

CVE-2025-22064: netfilter: nf_tables: don't unregister hook when table
is dormant

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22064

Introduced by commit b9703ed ("netfilter: nf_tables: support for
adding new devices to an existing netdev chain") in v6.4-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [688c15017d5cd5aac882400782e7213d40dc3556]
stable/6.6: [6134d1ea1e1408e8e7c8c26545b3b301cbdf1eda]

CVE-2025-22065: idpf: fix adapter NULL pointer dereference on reboot

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22065

Introduced by commit e850efe ("idpf: add module register and probe
functionality") in v6.7-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c9106f4906a85f6b13542d862e423bcdc118cc3]

CVE-2025-22066: ASoC: imx-card: Add NULL check in imx_card_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22066

Introduced by commit aa73670 ("ASoC: imx-card: Add imx-card machine
driver") in v5.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93d34608fd162f725172e780b1c60cc93a920719]
stable/5.15: [018e6cf2503e60087747b0ebc190e18b3640766f]
stable/6.1: [38253922a89a742e7e622f626b41c64388367361]
stable/6.6: [e283a5bf4337a7300ac5e6ae363cc8b242a0b4b7]

CVE-2025-22067: spi: cadence: Fix out-of-bounds array access in
cdns_mrvl_xspi_setup_clock()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22067

Introduced by commit 26d34fd ("spi: cadence: Add clock configuration
for Marvell xSPI overlay") in v6.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ba0847fa1c22e7801cebfe5f7b75aee4fae317e]

CVE-2025-22068: ublk: make sure ubq->canceling is set when queue is frozen

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22068

Introduced by commit 216c8f5 ("ublk: replace monitor with cancelable
uring_cmd") in v6.7-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8741d0737921ec1c03cf59aebf4d01400c2b461a]

CVE-2025-22069: riscv: fgraph: Fix stack layout to match
__arch_ftrace_regs argument of ftrace_return_to_handler

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22069

Introduced by commit a3ed415 ("fgraph: Replace fgraph_ret_regs with
ftrace_regs") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67a5ba8f742f247bc83e46dd2313c142b1383276]

CVE-2025-22070: fs/9p: fix NULL pointer dereference on mkdir

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22070

Introduced by commit dafbe68 ("9p fid refcount: cleanup p9_fid_put
calls") in v6.0-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f61ac7c65bdb26accb52f9db66313597e759821]

CVE-2025-22071: spufs: fix a leak in spufs_create_context()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22071

Introduced by commit 5811906 "[POWERPC] spufs: Fix memory leak on SPU
affinity" in v2.6.25-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f5cce3fc55b08ee4da3372baccf4bcd36a98396]
stable/5.10: [410c787d89c92df4215d7b1a338e2c1a8aba6b9b]
stable/5.15: [c4e72a0d75442237b6f3bcca10a7d81b89376d16]
stable/5.4: [829bd6139968e2e759f3928cf65ad0db1e302fe3]
stable/6.1: [a333f223e555d27609f8b45d75a08e8e1d36c432]
stable/6.6: [239ea3c34673b3244a499fd65771c47e5bffcbb0]

CVE-2025-22072: spufs: fix gang directory lifetimes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22072

Introduced by commit 877907d "[POWERPC] spufs: Fix gang destroy leaks"
in v2.6.22-rc5.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c134deabf4784e155d360744d4a6a835b9de4dd4]
stable/6.1: [880e7b3da2e765c1f90c94c0539be039e96c7062]
stable/6.6: [324f280806aab28ef757aecc18df419676c10ef8]

CVE-2025-22073: spufs: fix a leak on spufs_new_file() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22073

Introduced by commit 3f51dd9 "[PATCH] spufs: fix spufs_fill_dir error
path" in v2.6.20.16.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1ca8698ca1332625d83ea0d753747be66f9906d]
stable/5.10: [132925bd6772d7614340fb755ac5415462ac8edd]
stable/5.15: [53b189651c33b5f1fb3b755e6a37a8206978514e]
stable/5.4: [b1eef06d10c1a9848e3a762919bbbe315a0a7cb4]
stable/6.1: [96de7fbdc2dcadeebc17c3cb89e7cdab487bfce0]
stable/6.6: [90d1b276d1b1379d20ad27d1f6349ba9f44a2e00]

CVE-2025-22074: ksmbd: fix r_count dec/increment mismatch

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22074

Introduced by commit 3aa660c ("ksmbd: prevent connection release
during oplock break notification") in v6.14-rc7.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13 stable/6.6

Fixed status
mainline: [ddb7ea36ba7129c2ed107e2186591128618864e1]
stable/6.6: [4790bcb269e5d6d88200a67c54ae6d627332a3be]

CVE-2025-22075: rtnetlink: Allocate vfinfo size for VF GUIDs when supported

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22075

Introduced by commit 30aad41 ("net/core: Add support for getting VF
GUIDs") in v5.5-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23f00807619d15063d676218f36c5dfeda1eb420]
stable/5.10: [0f5489707cf528f9df2f39a3045c1ee713ec90e7]
stable/5.15: [bb7bdf636cef74cdd7a7d548bdc7457ae161f617]
stable/6.1: [5fed5f6de3cf734b231a11775748a6871ee3020f]
stable/6.6: [15f150771e0ec97f8ab1657e7d2568e593c7fa04]

CVE-2025-22076: exfat: fix missing shutdown check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22076

Introduced by commit f761fcd ("exfat: Implement sops->shutdown and
ioctl") in v6.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47e35366bc6fa3cf189a8305bce63992495f3efa]

CVE-2025-22077: smb: client: Fix netns refcount imbalance causing
leaks and use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22077

Introduced by commit ef7134c ("smb: client: Fix use-after-free of
network namespace.") in v6.12-rc7.
Introduced by commit e9f2517 ("smb: client: fix TCP timers deadlock
after rmmod") in v6.13-rc4.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.6

Fixed status
mainline: [4e7f1644f2ac6d01dc584f6301c3b1d5aac4eaef]
stable/6.6: [c6b6b8dcef4adf8ee4e439bb97e74106096c71b8]

CVE-2025-22078: staging: vchiq_arm: Fix possible NPR of keep-alive thread

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22078

Introduced by commit 863a756 ("staging: vc04_services: vchiq_core:
Stop kthreads on vchiq module unload") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3db89bc6d973e2bcaa852f6409c98c228f39a926]

CVE-2025-22079: ocfs2: validate l_tree_depth to avoid out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22079

Introduced by commit ccd979b ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a406aff8c05115119127c962cbbbbd202e1973ef]
stable/5.10: [538ed8b049ef801a86c543433e5061a91cc106e3]
stable/5.15: [17c99ab3db2ba74096d36c69daa6e784e98fc0b8]
stable/5.4: [ef34840bda333fe99bafbd2d73b70ceaaf9eba66]
stable/6.1: [11e24802e73362aa2948ee16b8fb4e32635d5b2a]
stable/6.6: [3d012ba4404a0bb517658699ba85e6abda386dc3]

CVE-2025-22080: fs/ntfs3: Prevent integer overflow in hdr_first_de()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22080

Introduced by commit 60ce8df ("fs/ntfs3: Fix wrong if in
hdr_first_de") in v6.2-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bb81b94f7a9cba6bde9a905cef52a65317a8b04]
stable/6.6: [f6d44b1aa46d317e52c21fb9314cfb20dd69e7b0]

CVE-2025-22081: fs/ntfs3: Fix a couple integer overflows on 32bit systems

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22081

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ad414f4df2294b28836b5b7b69787659d6aa708]
stable/5.15: [0922d86a7a6032cb1694eab0b44b861bd33ba8d5]
stable/6.1: [1a14e9718a19d2e88de004a1360bfd7a86ed1395]
stable/6.6: [0dfe700fbd3525f30a36ffbe390a5b9319bd009a]

CVE-2025-22082: iio: backend: make sure to NULL terminate stack buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22082

Introduced by commit cdf01e0 ("iio: backend: add debugFs interface")
in v6.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [035b4989211dc1c8626e186d655ae8ca5141bb73]

CVE-2025-22083: vhost-scsi: Fix handling of multiple calls to
vhost_scsi_set_endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22083

Introduced by commit 25b98b6 ("vhost scsi: alloc cmds per vq instead
of session") in v5.10-rc5.
Introduced by commit 4f7f46d ("tcm_vhost: Use vq->private_data to
indicate if the endpoint is setup") in v3.9-rc7.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5dd639a1646ef5fe8f4bf270fad47c5c3755b9b6]
stable/6.6: [2b34bdc42df047794542f3e220fe989124e4499a]

CVE-2025-22084: w1: fix NULL pointer dereference in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22084

Introduced by commit a3c0880 ("w1: add UART w1 bus driver") in v6.9-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0dd6770a72f138dabea9eae87f3da6ffa68f0d06]

CVE-2025-22085: RDMA/core: Fix use-after-free when rename device name

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22085

Introduced by commit 9cbed5a ("RDMA/nldev: Add support for RDMA
monitoring") in v6.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d6a9e7449e2a0c1e2934eee7880ba8bd1e464cd]

CVE-2025-22086: RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22086

Introduced by commit e126ba9 ("mlx5: Add driver for Mellanox
Connect-IB adapters") in v3.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ed3b0cb3f827072e93b4c5b6e2b8106fd7cccbd]
stable/5.10: [856d9e5d72dc44eca6d5a153581c58fbd84e92e1]
stable/5.15: [f0447ceb8a31d79bee7144f98f9a13f765531e1a]
stable/5.4: [3b97d77049856865ac5ce8ffbc6e716928310f7f]
stable/6.1: [dc7139b7031d877acd73d7eff55670f22f48cd5e]
stable/6.6: [7c51a6964b45b6d40027abd77e89cef30d26dc5a]

CVE-2025-22087: bpf: Fix array bounds error with may_goto

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22087

Introduced by commit 011832b ("bpf: Introduce may_goto instruction")
in v6.9-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ebc5030e0c5a698f1dd9a6684cddf6ccaed64a0]

CVE-2025-22088: RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22088

Introduced by commit 920d93e ("RDMA/erdma: Add connection management
(CM) support") in v6.0-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83437689249e6a17b25e27712fbee292e42e7855]
stable/6.1: [bc1db4d8f1b0dc480d7d745a60a8cc94ce2badd4]
stable/6.6: [667a628ab67d359166799fad89b3c6909599558a]

CVE-2025-22089: RDMA/core: Don't expose hw_counters outside of init
net namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22089

Introduced by commit 467f432 ("RDMA/core: Split port and device
counter sysfs attributes") in v5.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1ecb30f90856b0be4168ad51b8875148e285c1f]
stable/5.15: [9a5b7f8842a90a5e6eeff37f9f6d814e61ea3529]
stable/6.1: [d5212b99649c5740154f307e9e3d7fee9bf62773]
stable/6.6: [0cf80f924aecb5b2bebd4f4ad11b2efc676a0b78]

CVE-2025-22090: x86/mm/pat: Fix VM_PAT handling when fork() fails in
copy_page_range()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22090

Introduced by commit d155df5 ("x86/mm/pat: clear VM_PAT if
copy_p4d_range failed") in v6.4-rc1.
Introduced by commit 2ab6403 ("x86: PAT: hooks in generic vm code to
help archs to track pfnmap regions - v3") in v2.6.29-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc84bc2aba85a1508f04a936f9f9a15f64ebfb31]
stable/6.6: [b07398e8a5da517083f5c3f2daa8f6681b48ab28]

CVE-2025-22091: RDMA/mlx5: Fix page_size variable overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22091

Introduced by commit cef7dde ("net/mlx5: Expand mkey page size to
support 6 bits") in v6.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0c2427412b43cdf1b7b0944749ea17ddb97d5a5]

CVE-2025-22092: PCI: Fix NULL dereference in SR-IOV VF creation error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22092

Introduced by commit e3f30d5 ("PCI: Make pci_destroy_dev() concurrent
safe") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04d50d953ab46d96b0b32d5ad955fceaa28622db]

CVE-2025-22093: drm/amd/display: avoid NPD when ASIC does not support DMUB

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22093

Introduced by commit b5c764d ("drm/amd/display: Use HW lock mgr for
PSR1") in v6.13.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [42d9d7bed270247f134190ba0cb05bbd072f58c2]
stable/6.1: [d953e2cd59ab466569c6f9da460e01caf1c83559]
stable/6.6: [b3a93a2407ad23c8d5bacabaf7cecbb4c6cdd461]

CVE-2025-22094: powerpc/perf: Fix ref-counting on the PMU 'vpa_pmu'

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22094

Introduced by commit 176cda0 ("powerpc/perf: Add perf interface to
expose vpa counters") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff99d5b6a246715f2257123cdf6c4a29cb33aa78]

CVE-2025-22095: PCI: brcmstb: Fix error path after a call to
regulator_bulk_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22095

Introduced by commit 9e6be01 ("PCI: brcmstb: Enable child bus device
regulators from DT") in v6.0-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3651ad5249c51cf7eee078e12612557040a6bdb4]
stable/6.1: [99a0efba9f903acbdece548862b6b4cbe7d999e1]
stable/6.6: [eedd054834930b8d678f0776cd4b091b8fffbb4a]

CVE-2025-22096: drm/msm/gem: Fix error code msm_parse_deps()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22096

Introduced by commit 866e43b ("drm/msm: UAPI error reporting") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b305b7cadce835505bd93183a599acb1f800a05]

CVE-2025-22097: drm/vkms: Fix use after free and double free on init error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22097

Introduced by commit 2df7af9 ("drm/vkms: Add vkms_config type") in v5.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed15511a773df86205bda66c37193569575ae828]
stable/5.15: [49a69f67f53518bdd9b7eeebf019a2da6cc0e954]
stable/6.1: [79d138d137b80eeb0a83244d1cff29e64cf91067]
stable/6.6: [561fc0c5cf41f646f3e9e61784cbc0fc832fb936]

CVE-2025-22098: drm: zynqmp_dp: Fix a deadlock in zynqmp_dp_ignore_hpd_set()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22098

Introduced by commit 28edaac ("drm: zynqmp_dp: Add debugfs interface
for compliance testing") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f887685ee0eb4ef716391355568181230338f6eb]

CVE-2025-22099: drm: xlnx: zynqmp_dpsub: Add NULL check in zynqmp_audio_init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22099

Introduced by commit 3ec5c15 ("drm: xlnx: zynqmp_dpsub: Add DP audio
support") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0660f9c588a1246a1a543c91a1e3cad910237da]

CVE-2025-22100: drm/panthor: Fix race condition when gathering fdinfo
group samples

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22100

Introduced by commit e16635d ("drm/panthor: add DRM fdinfo support")
in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0590c94c3596d6c1a3d549ae611366f2ad4e1d8d]

CVE-2025-22101: net: libwx: fix Tx L4 checksum

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22101

Introduced by commit 3403960 ("net: wangxun: libwx add tx offload
functions") in v6.5-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7d82913d5f9e97860772ee4051eaa66b56a6273]

CVE-2025-22102: Bluetooth: btnxpuart: Fix kernel panic during FW release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22102

Introduced by commit e3c4891 ("Bluetooth: btnxpuart: Handle FW
Download Abort scenario") in v6.11-rc1.
Introduced by commit 689ca16 ("Bluetooth: NXP: Add protocol support
for NXP Bluetooth chipsets") in v6.4-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [1f77c05408c96bc0b58ae476a9cadc9e5b9cfd0f]

CVE-2025-22103: net: fix NULL pointer dereference in l3mdev_l3_rcv

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22103

Introduced by commit c675e06 ("ipvlan: decouple l3s mode dependencies
from other modes") in v5.1-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0032c99e83b9ce6d5995d65900aa4b6ffb501cce]

CVE-2025-22104: ibmvnic: Use kernel helpers for hex dumps

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22104

Introduced by commit 032c5e8 ("Driver for IBM System i/p VNIC
protocol") in v4.5-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d93a6caab5d7d9b5ce034d75b1e1e993338e3852]

CVE-2025-22105: bonding: check xdp prog when set bond mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22105

Introduced by commit 9e2ee5c ("net, bonding: Add XDP support to the
bonding driver") in v5.15-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [094ee6017ea09c11d6af187935a949df32803ce0]

CVE-2025-22106: vmxnet3: unregister xdp rxq info in the reset path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22106

Introduced by commit 54f00cc ("vmxnet3: Add XDP support.") in v6.6-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0dd765fae295832934bf28e45dd5a355e0891ed4]

CVE-2025-22107: net: dsa: sja1105: fix kasan out-of-bounds warning in
sja1105_table_delete_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22107

Introduced by commit 6666ceb ("net: dsa: sja1105: Add support for VLAN
operations") in v5.2-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f2b28b79d2d1946ee36ad8b3dc0066f73c90481]

CVE-2025-22108: bnxt_en: Mask the bd_cnt field in the TX BD properly

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22108

Introduced by commit 3948b05 ("net: introduce a config option to tweak
MAX_SKB_FRAGS") in v6.4-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [107b25db61122d8f990987895c2912927b8b6e3f]

CVE-2025-22109: ax25: Remove broken autobind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22109

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f6efbabceb6b2914ee9bafb86d9a51feae9cce8]

CVE-2025-22110: netfilter: nfnetlink_queue: Initialize ctx to avoid
memory allocation error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22110

Introduced by commit 2d470c7 ("lsm: replace context+len with
lsm_context") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [778b09d91baafb13408470c721d034d6515cfa5a]

CVE-2025-22111: net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22111

Introduced by commit 893b195 ("net: bridge: fix ioctl locking") in v5.15-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed3ba9b6e280e14cc3148c1b226ba453f02fa76c]

CVE-2025-22112: eth: bnxt: fix out-of-range access of vnic_info array

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22112

Introduced by commit 6619585 ("eth: bnxt: do not use BNXT_VNIC_NTUPLE
unconditionally in queue restart logic") in v6.14-rc7.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13

Fixed status
mainline: [919f9f497dbcee75d487400e8f9815b74a6a37df]

CVE-2025-22113: ext4: avoid journaling sb update on error if journal
is destroying

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22113

Introduced by commit 2d01ddc ("ext4: save error info to sb through
journal if available") in v5.11-rc4.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce2f26e73783b4a7c46a86e3af5b5c8de0971790]

CVE-2025-22114: btrfs: don't clobber ret in btrfs_validate_super()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22114

Introduced by commit 2a9bb78 ("btrfs: validate system chunk array at
btrfs_validate_super()") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9db9c7dd5b4e1d3205137a094805980082c37716]

CVE-2025-22115: btrfs: fix block group refcount race in
btrfs_create_pending_block_groups()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22115

Introduced by commit 0657b20 ("btrfs: fix use-after-free of new block
group that became unused") in v6.5-rc3.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [2d8e5168d48a91e7a802d3003e72afb4304bebfa]

CVE-2025-22116: idpf: check error for register_netdev() on init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22116

Introduced by commit 0fe4546 ("idpf: add create vport and netdev
configuration") in v6.7-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [680811c67906191b237bbafe7dabbbad64649b39]

CVE-2025-22117: ice: fix using untrusted value of pkt_len in
ice_vc_fdir_parse_raw()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22117

Introduced by commit 99f419d ("ice: enable FDIR filters from raw
binary patterns for VFs") in v6.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1388dd564183a5a18ec4a966748037736b5653c5]

CVE-2025-22118: ice: validate queue quanta parameters to prevent OOB access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22118

Introduced by commit 0153077 ("ice: Support VF queue rate limit and
quanta size configuration") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2f7d3f7331b92cb820da23e8c45133305da1e63]

CVE-2025-22119: wifi: cfg80211: init wiphy_work before allocating rfkill fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22119

Introduced by commit 72d5204 ("wifi: cfg80211: cancel wiphy_work
before freeing wiphy") in v6.14-rc7.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.12 stable/6.13 stable/6.6

Fixed status
mainline: [fc88dee89d7b63eeb17699393eb659aadf9d9b7c]

CVE-2025-22120: ext4: goto right label 'out_mmap_sem' in ext4_setattr()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22120

Introduced by commit c7fc036 ("ext4: partial zero eof block on
unaligned inode size extension") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.6

Fixed status
mainline: [7e91ae31e2d264155dfd102101afc2de7bd74a64]

CVE-2025-22121: ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22121

Introduced by commit e50e512 ("ext4: xattr-in-inode support") in v4.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5701875f9609b000d91351eaa6bfd97fe2f157f4]

CVE-2025-22122: block: fix adding folio to bio

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22122

Introduced by commit ed9832b ("block: introduce folio awareness and
add a bigger size from folio") in v6.12-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26064d3e2b4d9a14df1072980e558c636fb023ea]

CVE-2025-22123: f2fs: fix to avoid accessing uninitialized curseg

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22123

Introduced by commit 8b10d36 ("f2fs: introduce FAULT_NO_SEGMENT") in v6.9-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [986c50f6bca109c6cf362b4e2babcb85aba958f6]

CVE-2025-22124: md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22124

Introduced by commit ab99a87 ("md/md-bitmap: fix writing non bitmap
pages") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [6130825f34d41718c98a9b1504a79a23e379701e]

CVE-2025-22125: md/raid1,raid10: don't ignore IO flags

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22125

Introduced by commit e34cbd3 ("blk-wbt: add general throttling
mechanism") in v4.10-rc1.
Introduced by commit 5404bc7 ("[PATCH] Allow file systems to
differentiate between data and meta reads") in v2.6.20.16.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e879a0d9cb086c8e52ce6c04e5bfa63825a6213c]

CVE-2025-22126: md: fix mddev uaf while iterating all_mddevs list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22126

Introduced by commit f265143 ("md: stop using for_each_mddev in
md_notify_reboot") in v6.0-rc1.
Introduced by commit 16648ba ("md: stop using for_each_mddev in
md_exit") in v6.0-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8542870237c3a48ff049b6c5df5f50c8728284fa]

CVE-2025-22127: f2fs: fix potential deadloop in prepare_compress_overwrite()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22127

Introduced by commit 4c8ff70 ("f2fs: support data compression") in v5.6-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3147ee567dd9004a49826ddeaf0a4b12865d4409]

CVE-2025-22128: wifi: ath12k: Clear affinity hint before calling
ath12k_pci_free_irq() in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-22128

Introduced by commit a3012f2 ("wifi: ath12k: set IRQ affinity to CPU0
in case of one MSI vector") in v6.8-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b43b1e2c52db77c872bd60d30cdcc72c47df70c7]

CVE-2025-23129: wifi: ath11k: Clear affinity hint before calling
ath11k_pcic_free_irq() in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23129

Introduced by commit 39564b4 ("wifi: ath11k: fix boot failure with one
MSI vector") in v6.7-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [68410c5bd381a81bcc92b808e7dc4e6b9ed25d11]

CVE-2025-23130: f2fs: fix to avoid panic once fallocation fails for pinfile

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23130

Introduced by commit f5a53ed ("f2fs: support aligned pinned file") in v5.5-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48ea8b200414ac69ea96f4c231f5c7ef1fbeffef]

CVE-2025-23131: dlm: prevent NPD when writing a positive value to event_done

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23131

Introduced by commit 8511a27 ("dlm: fix use count with multiple
joins") in v2.6.31-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e2bad543eca5c25cd02cbc63d72557934d45f13]

CVE-2025-23132: f2fs: quota: fix to avoid warning in dquot_writeback_dquots()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23132

Introduced by commit af033b2 ("f2fs: guarantee journalled quota data
by checkpoint") in v4.20-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb85c2410d6f581e957cd03a644ff6ddbe592af9]

CVE-2025-23133: wifi: ath11k: update channel list in reg notifier
instead reg worker

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23133

Introduced by commit f45cb6b ("wifi: ath11k: avoid deadlock during
regulatory update in ath11k_regd_update()") in v6.1-rc5.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [933ab187e679e6fbdeea1835ae39efcc59c022d2]

CVE-2025-23134: ALSA: timer: Don't take register_mutex with copy_from/to_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23134

Introduced by commit 3923de0 ("ALSA: pcm: oss: Use guard() for setup")
in v6.9-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3424c8f53bc63c87712a7fc22dc13d0cc85fb0d6]

CVE-2025-23135: RISC-V: KVM: Teardown riscv specific bits after kvm_exit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23135

Introduced by commit 54e4332 ("RISC-V: KVM: Initial skeletal support
for AIA") in v6.4-rc1.
Introduced by commit eded675 ("riscv: KVM: add basic support for host
vs guest profiling") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d117e67f318303f6ab699a5511d1fac3f170545]

CVE-2025-23136: thermal: int340x: Add NULL check for adev

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23136

Introduced by commit 77e337c ("Thermal: introduce INT3402 thermal
driver") in v3.18-rc2.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2542a3f70e563a9e70e7ded314286535a3321bdb]
stable/5.10: [bc7b5f782d28942dbdfda70df30ce132694a06de]
stable/5.15: [3155d5261b518776d1b807d9d922669991bbee56]
stable/5.4: [d0d21c8e44216fa9afdb3809edf213f3c0a8c060]
stable/6.1: [6a810c462f099353e908c70619638884cb82229c]
stable/6.6: [ac2eb7378319e3836cdf3a2c15a0bdf04c50e81d]

CVE-2025-23137: cpufreq/amd-pstate: Add missing NULL ptr check in
amd_pstate_update

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23137

Introduced by commit e8f555d ("cpufreq/amd-pstate: fix setting policy
current frequency value") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [426db24d4db2e4f0d6720aeb7795eafcb9e82640]

CVE-2025-23138: watch_queue: fix pipe accounting mismatch

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23138

Introduced by commit e95aada ("pipe: wakeup wr_wait after setting
max_usage") in v6.8-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [f13abc1e8e1a3b7455511c4e122750127f6bc9b0]
stable/5.10: [8658c75343ed00e5e154ebbe24335f51ba8db547]
stable/5.15: [471c89b7d4f58bd6082f7c1fe14d4ca15c7f1284]
stable/6.1: [d40e3537265dea9e3c33021874437ff26dc18787]
stable/6.6: [6dafa27764183738dc5368b669b71e3d0d154f12]

* Updated CVEs

CVE-2021-47489: drm/amdgpu: Fix even more out of bound writes from debugfs

stable/5.10 was fixed.

Fixed status
stable/5.10: [1336b886b162fdc84708096ea152a61c0e1fc09c]

CVE-2022-49046: i2c: dev: check return value when calling dev_set_name()

stable/5.10 was fixed.

Fixed status
stable/5.10: [2e539b17d4cbe5fb8b5152dd9a6e4a8828f97db2]
stable/5.15: [2f345bb14ad4744950499ff222e2899209297afa]

CVE-2022-49546: x86/kexec: fix memory leak of elf header buffer

stable/5.10 was fixed.

Fixed status
stable/5.10: [23cf39dccf7653650701a6f39b119e9116a27f1a]
stable/5.15: [8765a423a87d74ef24ea02b43b2728fe4039f248]

CVE-2022-49636: vlan: fix memory leak in vlan_newlink()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
cip/4.19: [7ec428dc43a61f20c65932073a9dc613dcbe2013]
cip/4.19-st: [7ec428dc43a61f20c65932073a9dc613dcbe2013]
stable/5.10: [df27729a4fe0002dfd80c96fe1c142829c672728]
stable/5.15: [f5dc10b910bdac523e5947336445a77066c51bf9]
stable/5.4: [549de58dba4bf1b2adc72e9948b9c76fa88be9d2]

CVE-2022-49728: ipv6: Fix signed integer overflow in __ip6_append_data

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f26422eabeb517629568edf8c2dd9c6cb9147584]
stable/5.15: [70549c80fe80ac4e2a22068c76ebebced24f7e74]

CVE-2024-26928: smb: client: fix potential UAF in cifs_debug_files_proc_show()

stable/5.15 was fixed.

Fixed status
stable/5.15: [a140224bcf87eb98a87b67ff4c6826c57e47b704]
stable/6.1: [229042314602db62559ecacba127067c22ee7b88]
stable/6.6: [a65f2b56334ba4dc30bd5ee9ce5b2691b973344d]
stable/6.8: [3402faf78b2516b0af1259baff50cc8453ef0bd1]

CVE-2024-38611: media: i2c: et8ek8: Don't strip remove function when
driver is builtin

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [963523600d9f1e36bc35ba774c2493d6baa4dd8f]
stable/5.15: [ece3fc1c10197052044048bea4f13cfdcf25b416]
stable/6.1: [04d1086a62ac492ebb6bb0c94c1c8cb55f5d1f36]
stable/6.6: [c1a3803e5bb91c13e9ad582003e4288f67f06cd9]
stable/6.9: [904db2ba44ae60641b6378c5013254d09acf5e80]

CVE-2024-46753: btrfs: handle errors from btrfs_dec_ref() properly

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [0e4840ae09f375381167000ce47424818fcbcc7c]
stable/5.15: [2c4fe45351e544da4b8f10c74b277117a4fa7869]
stable/6.1: [9c8237021b53d52357c0de07a768582fafb2791d]
stable/6.10: [a7f16a7a709845855cb5a0e080a52bda5873f9de]
stable/6.6: [67e4ca7ddc67ef949326b4dc404a9678bbe67d72]

CVE-2024-46812: drm/amd/display: Skip inactive planes within
ModeSupportAndSystemConfiguration

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2fd32a65f2e78eff0862c8fdf7815ca6bb44fb2e]
stable/5.15: [4331ae2788e779b11f3aad40c04be6c64831f2a2]
stable/6.1: [3300a039caf850376bc3416c808cd8879da412bb]
stable/6.10: [ee9d6df6d9172917d9ddbd948bb882652d5ecd29]
stable/6.6: [8406158a546441b73f0b216aedacbf9a1e5748fb]

CVE-2024-46813: drm/amd/display: Check link_index before accessing dc->links[]

stable/6.6 was fixed.

Fixed status
stable/6.10: [ac04759b4a002969cf0f1384f1b8bb2001cfa782]
stable/6.6: [032c5407a608ac3b2a98bf4fbda27d12c20c5887]

CVE-2024-46821: drm/amd/pm: Fix negative array index read

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [befd1dc693c98bad69a701ede3a298698f0f9436]
stable/5.15: [e549cd6da1f21c34ba0f65adeca6a8aa9860b381]
stable/6.1: [60f4a4bc3329e5cb8c4df0cc961f0d5ffd96e22d]
stable/6.10: [06a3810010b525b9958424e344f0c25b09e128fa]
stable/6.6: [4711b1347cb9f0c3083da6d87c624d75f9bd1d50]

CVE-2024-46823: kunit/overflow: Fix UB in overflow_allocation_test

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [cacce7faa7c475cea55e82cc3a27794561fac157]
stable/6.10: [d1207f07decc66546a7fa463d2f335a856c986ef]
stable/6.6: [99ddb9c58511f1b71e23d02a06082bf6d2dd2133]

CVE-2024-53144: Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [baaa50c6f91ea5a9c7503af51f2bc50e6568b66b]
stable/5.15: [22b49d6e4f399a390c70f3034f5fbacbb9413858]
stable/6.1: [d17c631ba04e960eb6f8728b10d585de20ac4f71]
stable/6.6: [830c03e58beb70b99349760f822e505ecb4eeb7e]

CVE-2024-56664: bpf, sockmap: Fix race between element replace and close()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6deb9e85dc9a2ba4414b91c1b5b00b8415910890]
stable/5.15: [fdb2cd8957ac51f84c9e742ba866087944bb834b]
stable/6.1: [b79a0d1e9a374d1b376933a354c4fcd01fce0365]
stable/6.12: [bf2318e288f636a882eea39f7e1015623629f168]
stable/6.6: [b015f19fedd2e12283a8450dd0aefce49ec57015]

CVE-2024-8805: Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [baaa50c6f91ea5a9c7503af51f2bc50e6568b66b]
stable/5.15: [22b49d6e4f399a390c70f3034f5fbacbb9413858]
stable/6.1: [d17c631ba04e960eb6f8728b10d585de20ac4f71]
stable/6.11: [5291ff856d2c5177b4fe9c18828312be30213193]
stable/6.6: [830c03e58beb70b99349760f822e505ecb4eeb7e]

CVE-2025-21779: KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if
local APIC isn't in-kernel

stable/5.10 was fixed.

Fixed status
stable/5.10: [61224533f2b61e252b03e214195d27d64b22989a]
stable/5.15: [45fa526b0f5a34492ed0536c3cdf88b78380e4de]
stable/6.1: [5393cf22312418262679eaadb130d608c75fe690]
stable/6.12: [aca8be4403fb90db7adaf63830e27ebe787a76e8]
stable/6.13: [ca29f58ca374c40a0e69c5306fc5c940a0069074]
stable/6.6: [874ff13c73c45ecb38cb82191e8c1d523f0dc81b]

CVE-2025-21941: drm/amd/display: Fix null check for
pipe_ctx->plane_state in resource_build_scaling_params

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [265422915416468ba91bffa56addbff45e18342a]
stable/5.15: [f435192e00bc4d5d4134356b93212670ec47fa8d]
stable/6.1: [c1e54752dc12e90305eb0475ca908f42f5b369ca]
stable/6.12: [e0345c3478f185ca840daac7f08a1fcd4ebec3e9]
stable/6.13: [3748fad09d89e9a5290e1738fd6872a79f794743]
stable/6.6: [3b3c2be58d5275aa59d8b4810a59f173f2f5bac1]

CVE-2025-21956: drm/amd/display: Assign normalized_pix_clk when color depth = 14

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [0174a2e5770efee9dbd4b58963ed4d939298ff5e]
stable/5.15: [0c0016712e5dc23ce4a7e673cbebc24a535d8c8a]
stable/5.4: [cca3ab74f90176099b6392e8e894b52b27b3d080]
stable/6.1: [dc831b38680c47d07e425871a9852109183895cf]
stable/6.12: [04f90b505ad3a6eed474bbaa03167095fef5203a]
stable/6.13: [27df30106690969f7d63604f0d49ed8e9bffa2cb]
stable/6.6: [a8f77e1658d78e4a8bb227a83bcee67de97f7634]

CVE-2025-21957: scsi: qla1280: Fix kernel oops when debug level > 2

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [11a8dac1177a596648a020a7f3708257a2f95fee]
stable/5.15: [c737e2a5fb7f90b96a96121da1b50a9c74ae9b8c]
stable/5.4: [afa27b7c17a48e01546ccaad0ab017ad0496a522]
stable/6.1: [24602e2664c515a4f2950d7b52c3d5997463418c]
stable/6.12: [af71ba921d08c241a817010f96458dc5e5e26762]
stable/6.13: [7ac2473e727d67a38266b2b7e55c752402ab588c]
stable/6.6: [ea371d1cdefb0951c7127a33bcd7eb931cf44571]

CVE-2025-21959: netfilter: nf_conncount: Fully initialize struct
nf_conncount_tuple in insert_tree()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [2a154ce766b995494e88d8d117fa82cc6b73dd87]
stable/5.15: [e8544a5a97bee3674e7cd6bf0f3a4af517fa9146]
stable/5.4: [f522229c5563b59b4240261e406779bba6754159]
stable/6.1: [a62a25c6ad58fae997f48a0749afeda1c252ae51]
stable/6.12: [db1e0c0856821c59a32ea3af79476bf20a6beeb2]
stable/6.13: [2db5baaf047a7c8d6ed5e2cc657b7854e155b7fc]
stable/6.6: [fda50302a13701d47fbe01e1739c7a51114144fb]

CVE-2025-21962: cifs: Fix integer overflow while processing closetimeo
mount option

stable/5.15 was fixed.

Fixed status
stable/5.15: [513f6cf2e906a504b7ab0b62b2eea993a6f64558]
stable/6.1: [9968fcf02cf6b0f78fbacf3f63e782162603855a]
stable/6.12: [1c46673be93dd2954f44fe370fb4f2b8e6214224]
stable/6.13: [b24edd5c191c2689c59d0509f0903f9487eb6317]
stable/6.6: [6c13fcb7cf59ae65940da1dfea80144e42921e53]

CVE-2025-21963: cifs: Fix integer overflow while processing acdirmax
mount option

stable/5.15 was fixed.

Fixed status
stable/5.15: [0c26edf477e093cefc41637f5bccc102e1a77399]
stable/6.1: [39d086bb3558da9640ef335f97453e01d32578a1]
stable/6.12: [2809a79bc64964ce02e0c5f2d6bd39b9d09bdb3c]
stable/6.13: [6124cbf73e3dea7591857dd63b8ccece28952afd]
stable/6.6: [9e438d0410a4002d24f420f2c28897ba2dc0af64]

CVE-2025-21964: cifs: Fix integer overflow while processing acregmax
mount option

stable/5.15 was fixed.

Fixed status
stable/5.15: [a13351624a6af8d91398860b8c9d4cf6c8e63de5]
stable/6.1: [dd190168e60ac15408f074a1fe0ce36aff34027b]
stable/6.12: [833f2903eb8b70faca7967319e580e9ce69729fc]
stable/6.13: [5f500874ab9b3cc8c169c2ab49f00b838520b9c5]
stable/6.6: [0252c33cc943e9e48ddfafaa6b1eb72adb68a099]

CVE-2025-21968: drm/amd/display: Fix slab-use-after-free on hdcp_work

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [06acfdef370ae018dad9592369e2d2fd9a40c09e]
stable/5.15: [1397715b011bcdc6ad91b17df7acaee301e89db5]
stable/6.1: [4964dbc4191ab436877a5e3ecd9c67a4e50b7c36]
stable/6.12: [bac7b8b1a3f1a86eeec85835af106cbdc2b9d9f7]
stable/6.13: [93d701064e56788663d7c5918fbe5e060d5df587]
stable/6.6: [378b361e2e30e9729f9a7676f7926868d14f4326]

CVE-2025-21970: net/mlx5: Bridge, fix the crash caused by LAG state check

stable/5.15 was fixed.

Fixed status
stable/5.15: [f90c4d6572488e2bad38cca00f1c59174a538a1a]
stable/6.1: [86ff45f5f61ae1d0d17f0f6d8797b052eacfd8f1]
stable/6.12: [f7bf259a04271165ae667ad21cfc60c6413f25ca]
stable/6.13: [5dd8bf6ab1d6db40f5d09603759fa88caec19e7f]
stable/6.6: [bd7e3a42800743a7748c83243e4cafc1b995d4c4]

CVE-2025-21971: net_sched: Prevent creation of classes with TC_H_ROOT

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [7a82fe67a9f4d7123d8e5ba8f0f0806c28695006]
stable/5.15: [003d92c91cdb5a64b25a9a74cb8543aac9a8bb48]
stable/5.4: [e05d9938b1b0ac40b6054cc5fa0ccbd9afd5ed4c]
stable/6.1: [e5ee00607bbfc97ef1526ea95b6b2458ac9e7cb7]
stable/6.12: [5c3ca9cb48b51bd72bf76b8b05e24f3cd53db5e7]
stable/6.13: [94edfdfb9505ab608e86599d1d1e38c83816fc1c]
stable/6.6: [78533c4a29ac3aeddce4b481770beaaa4f3bfb67]

CVE-2025-21975: net/mlx5: handle errors in mlx5_chains_create_table()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [15bdd93728369b2c8942a8e5d549d4b5dc04a2d9]
stable/5.15: [29c419c64e9b396baeda1d8713d2aa3ba7c0acf6]
stable/6.1: [1598307c914ba3d2642a2b03d1ff11efbdb7c6c2]
stable/6.12: [1d34296409a519b4027750e3e82d9e19553a7398]
stable/6.13: [093b4aaec97ec048623e3fe1e516fc45a954d412]
stable/6.6: [637105ef0d46fe5beac15aceb431da3ec832bb00]

CVE-2025-21981: ice: fix memory leak in aRFS after reset

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ef2bc94059836a115430a6ad9d2838b0b34dc8f5]
stable/5.15: [e6902101f34f098af59b0d1d8cf90c4124c02c6a]
stable/6.1: [fcbacc47d16306c87ad1b820b7a575f6e9eae58b]
stable/6.12: [3b27e6e10a32589fcd293b8933ab6de9387a460e]
stable/6.13: [78f3d64b30210c0e521c59357431aca14024cb79]
stable/6.6: [5d30d256661fc11b6e73fac6c3783a702e1006a3]

CVE-2025-21991: x86/microcode/AMD: Fix out-of-bounds on systems with
CPU-less NUMA nodes

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [985a536e04bbfffb1770df43c6470f635a6b1073]
stable/5.15: [18b5d857c6496b78ead2fd10001b81ae32d30cac]
stable/5.4: [d509c4731090ebd9bbdb72c70a2d70003ae81f4f]
stable/6.1: [ec52240622c4d218d0240079b7c1d3ec2328a9f4]
stable/6.12: [488ffc0cac38f203979f83634236ee53251ce593]
stable/6.13: [5ac295dfccb5b015493f86694fa13a0dde4d3665]
stable/6.6: [e686349cc19e800dac8971929089ba5ff59abfb0]

CVE-2025-21992: HID: ignore non-functional sensor in HP 5MP Camera

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [b6c6c2d8ab4932e5d6d439f514276cb3d257b8fe]
stable/5.15: [007a849126ef7907761af6a1379400558a72e703]
stable/5.4: [9af297aea8f76a0ad21f2de5f2cd6401a748b9c3]
stable/6.1: [9acdb0059fb6b82158e15adae91e629cb5974564]
stable/6.12: [6ca3d4d87af406a390a34ea924ab65c517e6e132]
stable/6.13: [920ea73215dbf948b661b88a79cb47b7f96adfbd]
stable/6.6: [7a7ada33879a631b05b536e66d1c5b1219d3bade]

CVE-2025-21993: iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in
ibft_attr_show_nic()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [f763c82db8166e28f45b7cc4a5398a7859665940]
stable/5.15: [b388e185bfad32bfed6a97a6817f74ca00a4318f]
stable/5.4: [a858cd58dea06cf85b142673deea8c5d87f11e70]
stable/6.1: [9bfa80c8aa4e06dff55a953c3fffbfc68a3a3b1c]
stable/6.12: [b253660fac5e0e9080d2c95e3a029e1898d49afb]
stable/6.13: [c1c6e527470e5eab0b2d57bd073530fbace39eab]
stable/6.6: [2d1eef248107bdf3d5a69d0fde04c30a79a7bf5d]

CVE-2025-21994: ksmbd: fix incorrect validation for num_aces field of smb_acl

stable/5.15 was fixed.

Fixed status
stable/5.15: [c3a3484d9d31b27a3db0fab91fcf191132d65236]
stable/6.1: [9c4e202abff45f8eac17989e549fc7a75095f675]
stable/6.12: [a4cb17797a5d241f1e509cb5b46ed95a80c2f5fd]
stable/6.13: [f6a6721802ac2f12f4c1bbe839a4c229b61866f2]
stable/6.6: [d0f87370622a853b57e851f7d5a5452b72300f19]

CVE-2025-21996: drm/radeon: fix uninitialized size issue in
radeon_vce_cs_parse()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [5b4d9d20fd455a97920cf158dd19163b879cf65d]
stable/5.15: [9b2da9c673a0da1359a2151f7ce773e2f77d71a9]
stable/5.4: [0effb378ebce52b897f85cd7f828854b8c7cb636]
stable/6.1: [78b07dada3f02f77762d0755a96d35f53b02be69]
stable/6.12: [dd1801aa01bba1760357f2a641346ae149686713]
stable/6.13: [f5e049028124f755283f2c07e7a3708361ed1dc8]
stable/6.6: [3ce08215cad55c10a6eeeb33d3583b6cfffe3ab8]

CVE-2025-21999: proc: fix UAF in proc_get_inode()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [eda279586e571b05dff44d48e05f8977ad05855d]
stable/5.15: [4b0b8445b6fd41e6f62ac90547a0ea9d348de3fa]
stable/6.1: [966f331403dc3ed04ff64eaf3930cf1267965e53]
stable/6.12: [ede3e8ac90ae106f0b29cd759aadebc1568f1308]
stable/6.13: [64dc7c68e040251d9ec6e989acb69f8f6ae4a10b]
stable/6.6: [63b53198aff2e4e6c5866a4ff73c7891f958ffa4]

CVE-2025-22004: net: atm: fix use after free in lec_send()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [8cd90c7db08f32829bfa1b5b2b11fbc542afbab7]
stable/5.15: [82d9084a97892de1ee4881eb5c17911fcd9be6f6]
stable/5.4: [50e288097c2c6e5f374ae079394436fc29d1e88e]
stable/6.1: [51e8be9578a2e74f9983d8fd8de8cafed191f30c]
stable/6.12: [326223182e4703cde99fdbd36d07d0b3de9980fb]
stable/6.13: [f3271f7548385e0096739965961c7cbf7e6b4762]
stable/6.6: [9566f6ee13b17a15d0a47667ad1b1893c539f730]

CVE-2025-22005: ipv6: Fix memleak of nhc_pcpu_rth_output in
fib_check_nh_v6_gw().

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [1bd12dfc058e1e68759d313d7727d68dbc1b8964]
stable/5.15: [596a883c4ce2d2e9c175f25b98fed3a1f33fea38]
stable/5.4: [16267a5036173d0173377545b4b6021b081d0933]
stable/6.1: [77c41cdbe6bce476e08d3251c0d501feaf10a9f3]
stable/6.12: [29d91820184d5cbc70f3246d4911d96eaeb930d6]
stable/6.13: [d3d5b4b5ae263c3225db363ba08b937e2e2b0380]
stable/6.6: [119dcafe36795a15ae53351cbbd6177aaf94ffef]

CVE-2025-22007: Bluetooth: Fix error code in chan_alloc_skb_cb()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [1bd68db7beb426ab5a45d81516ed9611284affc8]
stable/5.15: [76304cba8cba12bb10d89d016c28403a2dd89a29]
stable/5.4: [b3d607e36fef4bd05fb938a8a868ff70e9fedbe2]
stable/6.1: [788ae2ae4cf484e248b5bc29211c7ac6510e3e92]
stable/6.12: [761b7c36addd22c7e6ceb05caaadc3b062d99faa]
stable/6.13: [a78692ec0d1e17a96b09f2349a028878f5b305e4]
stable/6.6: [ecd06ad0823a90b4420c377ef8917e44e23ee841]

CVE-2025-22008: regulator: check that dummy regulator has been probed
before using it

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [3a9c46af5654783f99015727ac65bc2a23e2735a]
stable/5.15: [8e500180904aae63afdce95cb378aeabe119ecda]
stable/6.1: [270fe5c090f62dfce1cad0f5053e4827a6f50df4]
stable/6.12: [a99f1254b11eaadd0794b74a8178bad92ab01cae]
stable/6.13: [21e3fdf3146f9c63888d6bfabbd553434a5fb93f]
stable/6.6: [998b1aae22dca87da392ea35f089406cbef6032d]

CVE-2025-22010: RDMA/hns: Fix soft lockup during bt pages loop

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [461eb4ddede266df8f181f578732bb01742c3fd6]
stable/5.15: [efe544462fc0b499725364f90bd0f8bbf16f861a]
stable/6.1: [4104b0023ff66b5df900d23dbf38310893deca79]
stable/6.12: [13a52f6c9ff99f7d88f81da535cb4e85eade662b]
stable/6.13: [9ab20fec7a1ce3057ad86afd27bfd08420b7cd11]
stable/6.6: [975355faba56c0751292ed15a90c3e2c7dc0aad6]

CVE-2025-22014: soc: qcom: pdr: Fix the potential deadlock

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [72a222b6af10c2a05a5fad0029246229ed8912c2]
stable/5.15: [daba84612236de3ab39083e62c9e326a654ebd20]
stable/6.1: [0a566a79aca9851fae140536e0fc5b0853c90a90]
stable/6.12: [f4489260f5713c94e1966e5f20445bff262876f4]
stable/6.13: [02612f1e4c34d94d6c8ee75bf7d254ed697e22d4]
stable/6.6: [f2bbfd50e95bc117360f0f59e629aa03d821ebd6]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

