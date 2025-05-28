Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533EC5AD49
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 22:24:32 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web11.8122.1748471061817700966
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 May 2025 15:24:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=suv/zpNU;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.170, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7dc5f8148bso1426904276.0
        for <cip-dev@lists.cip-project.org>; Wed, 28 May 2025 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1748471061; x=1749075861; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7J3T5JU63NFHiw1DCly3Fp25gkRdcKL1qtBHGdJ8qZc=;
        b=suv/zpNUhCMivKqkf/nJP9fMCI4DlQrR9TnI3Hhldhd5tLFQxR9xqlZyEI8Nr31+AX
         jcVtptFaSHV1o5zOQcLXpDnEUPaieeu+a2e/rErDbXJB1OKHIkVUjYvZR7aLbMM3iaz6
         NFixQeZLWNAqtrDpbaVaaIOJpiqTpzMxIqa1uqXRv5zr5tIkGeYVxtmqi1jJo+BuMsQ0
         ZUN/an/RX68ncmfgW3Bw/WRC+rXIZrixHjvN0A2Yz7xIhdVVl8JNxS22HjVHRVqg+gus
         8uOye5eKOO+oIdy9ri1mzDUY5/4un9PM4bEvuvWZVQXr5UfLa5FStXVAP+NnHNWEZQpy
         eTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748471061; x=1749075861;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7J3T5JU63NFHiw1DCly3Fp25gkRdcKL1qtBHGdJ8qZc=;
        b=qH7ZohLV+pcjJGK8JiB3jJuRDk4Gfv4eBkON+zXOzO4lHK97zdBY2vztNRhr9zblGw
         5nmdWGxK3ZAz/rNtNvwFw7l7itzeh+Iay+7cZvHojuiI+UnUD9Bcr+5rc87DVjg1M7Mp
         EN8XRg/V6NKaENhX8MJYffdZlccYCT42nziShhy9A1Q0EyW6eZmnIgULUOipa5IMfHFy
         KaPU7UbBY4KtWipTVUhAPpaxxYSxKhSWj8D6d+ISTUGRJluvRps3csWSmHds0LN9kgQ3
         WJYDb4O8I5BwE/WUR7kDIEBfuIcZ8al175Rw5zz7nNcYV+6N2Kra40XCZigiTiPamdSj
         607Q==
X-Gm-Message-State: AOJu0YxIfFBV2xntCsMsGMFUe/l9PXw8KkH/eoYj4QGIQpZ/jDJgr2yX
	iVv/BGsakIt6/PDY2DUNIPMKVvau1W9EKgLfPktJwvte98/pI5eAvQep6spRKa6p1z6AHVwSQxI
	gVhHKbjCZ751tT5ahS9crTNY+/uthYzJlNa25nX4Gnq9hUNifiP/vERU=
X-Gm-Gg: ASbGncvLaLy0lQidlgAgE8oyrXLNv0T8KtDeWZomadS3nwUbBMewcKlWJju2lZR6GvM
	kq9yr5CRsgGN8iUDd7UaSMBWJO4rAOMSzCq59PUJbCUb0hzaj7sQ+QRlJyAfRW+l3TUT4JoeGY/
	B+LnmHFlcBMJfJ8kPYPszmZlEZQ5GpDHOKlA==
X-Google-Smtp-Source: AGHT+IG2juLNACQKpONsrkORjP9kdS2F6KAUQ8qhqthgYkawD2tUGMWD2ul/LiAHmb1KF6ZhJ/8QxwpxmvksPahBGR4=
X-Received: by 2002:a05:690c:4b8e:b0:70b:3e8b:a1d0 with SMTP id
 00721157ae682-70f87680743mr22457757b3.5.1748471060647; Wed, 28 May 2025
 15:24:20 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 May 2025 07:23:44 +0900
X-Gm-Features: AX0GCFsEoTfsNxiKtmhvgjfsxUhEtT1FXGu5hQUMm06hLm3dODLSD6snv7plCUM
Message-ID: <CAODzB9rLY02Mt+r+DF=cJmeo8rDyu1G-FV0oCv8kYyVhZoFtEw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 May 2025 22:24:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18956

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 24 updated CVEs.

* New CVEs
CVE-2025-37992: net_sched: Flush gso_skb list too during ->change()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37992

Introduced by commit 76e3cc1 ("codel: Controlled Delay AQM") in v3.5-rc1.
Introduced by commit 4b549a2 ("fq_codel: Fair Queue Codel AQM") in v3.5-rc1.
Introduced by commit afe4fd0 ("pkt_sched: fq: Fair Queue packet
scheduler") in v3.12-rc1.
Introduced by commit ec97ecf ("net: sched: add Flow Queue PIE packet
scheduler") in v5.6-rc1.
Introduced by commit 10239ed ("net-qdisc-hhf: Heavy-Hitter Filter
(HHF) qdisc") in v3.14-rc1.
Introduced by commit d4b3621 ("net: pkt_sched: PIE AQM scheme") in v3.14-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d3cbfd6d54a2c39ce3244f33f85c595844bd7b8]
stable/5.15: [d3336f746f196c6a53e0480923ae93939f047b6c]
stable/6.1: [d38939ebe0d992d581acb6885c1723fa83c1fb2c]
stable/6.12: [d1365ca80b012d8a7863e45949e413fb61fa4861]
stable/6.6: [a7d6e0ac0a8861f6b1027488062251a8e28150fd]


* Updated CVEs

CVE-2022-49063: ice: arfs: fix use-after-free when freeing @rx_cpu_rmap

stable/5.15 was fixed.

Fixed status
stable/5.15: [618df75f2e30c7838a3e010ca32cd4893ec9fe33]

CVE-2022-49168: btrfs: do not clean up repair bio if submit fails

stable/5.15 was fixed.

Fixed status
stable/5.15: [7170875083254b51fcc5d67f96640977083f481e]

CVE-2024-26618: arm64/sme: Always exit sme_alloc() early with existing storage

stable/6.1 was fixed.

Fixed status
stable/6.1: [f6421555dbd7cb3d4d70b69f33f998aaeca1e3b5]
stable/6.6: [569156e4fa347237f8fa2a7e935d860109c55ac4]
stable/6.7: [814af6b4e6000e574e74d92197190edf07cc3680]

CVE-2024-26783: mm/vmscan: fix a bug calling wakeup_kswapd() with a
wrong zone index

stable/6.1 was fixed.

Fixed status
stable/6.1: [e5ec1c24e71dbf144677a975d6ba91043c2193db]
stable/6.6: [d6159bd4c00594249e305bfe02304c67c506264e]
stable/6.7: [bdd21eed8b72f9e28d6c279f6db258e090c79080]

CVE-2024-26807: spi: cadence-qspi: fix pointer reference in runtime PM hooks

stable/6.1 was fixed.

Fixed status
stable/6.1: [2c914aac9522f6e93822c18dff233d3e92399c81]
stable/6.6: [03f1573c9587029730ca68503f5062105b122f61]
stable/6.7: [34e1d5c4407c78de0e3473e1fbf8fb74dbe66d03]

CVE-2024-35790: usb: typec: altmodes/displayport: create sysfs nodes
as driver's default device attribute group

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [9794ffd9d0c39ee070fbd733f862bbe89b28ba33]
stable/6.1: [f1c5ddaef506e3517dce338c08a60663b1521920]
stable/6.6: [4a22aeac24d0d5f26ba741408e8b5a4be6dc5dc0]

CVE-2024-36903: ipv6: Fix potential uninit-value access in __ip6_make_skb()

stable/6.1 was fixed.

Fixed status
stable/6.1: [a05c1ede50e9656f0752e523c7b54f3a3489e9a8]
stable/6.6: [68c8ba16ab712eb709c6bab80ff151079d11d97a]

CVE-2024-36927: ipv4: Fix uninit-value access in __ip_make_skb()

stable/6.1 was fixed.

Fixed status
stable/6.1: [55bf541e018b76b3750cb6c6ea18c46e1ac5562e]
stable/6.6: [5db08343ddb1b239320612036c398e4e1bb52818]

CVE-2024-43840: bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [077149478497b2f00ff4fd9da2c892defa6418d8]
stable/6.10: [6d218fcc707d6b2c3616b6cd24b948fd4825cfec]
stable/6.6: [d9664e6ff040798a46cdc5d401064f55b8676c83]

CVE-2024-46751: btrfs: don't BUG_ON() when 0 reference count at
btrfs_lookup_extent_info()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [d64807ded1b6054f066e03d8add6d920f3db9e5d]
stable/6.1: [18eb53a2734ff61b9a72c4fef5db7b38cb48ae16]
stable/6.10: [ef9a8b73c8b60b27d9db4787e624a3438ffe8428]
stable/6.6: [3cfec712a439c5c5f5c718c5c669ee41a898f776]

CVE-2024-50203: bpf, arm64: Fix address emission with tag-based KASAN enabled

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [9e80f366ebfdfafc685fe83a84c34f7ef01cbe88]
stable/6.11: [7db1a2121f3c7903b8e397392beec563c3d00950]
stable/6.6: [f521c2a0c0c4585f36d912bf62c852b88682c4f2]

CVE-2024-53203: usb: typec: fix potential array underflow in
ucsi_ccg_sync_control()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [e15fd96c0b701c53f9006bcc836eaeb35a05a023]
stable/6.1: [e44189455c62469eb91d383ce9103d54c1f807a3]
stable/6.12: [56971710cd541f2f05160a84b3183477d34a1be9]
stable/6.6: [0e66fd8e5a2e45c7dacfc9178ba702153f4a61a8]

CVE-2024-53209: bnxt_en: Fix receive ring space parameters when XDP is active

stable/6.1 was fixed.

Fixed status
stable/6.1: [b7fd784d7c6a1bd927a23e0d06f09a776ee3889b]
stable/6.12: [84353386762a0a16dd444ead76c012e167d89b41]
stable/6.6: [7f306c651feab2f3689185f60b94e72b573255db]

CVE-2024-56655: netfilter: nf_tables: do not defer rule destruction via call_rcu

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b8d8f53e1858178882b881b8c09f94ef0e83bf76]
stable/6.1: [b0f013bebf94fe7ae75e5a53be2f2bd1cc1841e3]
stable/6.12: [7cf0bd232b565d9852cb25fd094f77254773e048]
stable/6.6: [27f0574253f6c24c8ee4e3f0a685b75ed3a256ed]

CVE-2024-57945: riscv: mm: Fix the out of bound issue of vmemmap address

stable/6.1 was fixed.

Fixed status
stable/6.1: [92f08673d3f1893191323572f60e3c62f2e57c2f]
stable/6.12: [d2bd51954ac8377c2f1eb1813e694788998add66]
stable/6.6: [a4a7ac3d266008018f05fae53060fcb331151a14]

CVE-2025-21645: platform/x86/amd/pmc: Only disable IRQ1 wakeup where
i8042 actually enabled it

stable/6.1 was fixed.

Fixed status
stable/6.1: [ab47d72b736e78d3c2370b26e0bfc46eb0918391]
stable/6.12: [b25778c87a6bce40c31e92364f08aa6240309e25]
stable/6.6: [5cc621085e2b7a9b1905a98f8e5a86bb4aea2016]

CVE-2025-21931: hwpoison, memory_hotplug: lock folio before unmap
hwpoisoned folio

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3926b572fd073491bde13ec42ee08ac1b337bf4d]
stable/6.12: [576a2f4c437c19bec7d05d05b5990f178d2b0f40]
stable/6.13: [629dfc6ba5431056701d4e44830f3409b989955a]
stable/6.6: [93df6da64b004f75d307ed08d3f0f1020280d339]

CVE-2025-22062: sctp: add mutual exclusion in proc_sctp_do_udp_port()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [65ccb2793da7401772a3ffe85355c831b313c59f]
stable/6.1: [386507cb6fb7cdef598ddcb3f0fa37e6ca9e789d]
stable/6.12: [e5178bfc55b3a78000f0f8298e7ade88783ce581]
stable/6.13: [efb8cb487be8f4ba6aaef616011d702d6a083ed1]
stable/6.14: [d3d7675d77622f6ca1aae14c51f80027b36283f8]
stable/6.6: [b3598f53211ba1025485306de2733bdd241311a3]

CVE-2025-22102: Bluetooth: btnxpuart: Fix kernel panic during FW release

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d22496de5049d9b8f5b6d8623682a56b3c3d7e18]
stable/6.14: [6749cf49eff7ce6dadcb603c5c8db70b28079a5d]
stable/6.6: [a0a736d9857cadd87ae48b151d787e28954ea831]

CVE-2025-2312: cifs-utils: cifs.upcall makes an upcall to the wrong namespace in
containerized environments

stable/6.12 was fixed.

Fixed status
stable/6.12: [6b2d1fbd41469b64ad9923a449d9e4be2eef550c]

CVE-2025-37957: KVM: SVM: Forcibly leave SMM mode on SHUTDOWN interception

stable/6.6 was fixed.

Fixed status
stable/6.12: [d362b21fefcef7eda8f1cd78a5925735d2b3287c]
stable/6.14: [e9b28bc65fd3a56755ba503258024608292b4ab1]
stable/6.6: [ec24e62a1dd3540ee696314422040180040c1e4a]

CVE-2025-37960: memblock: Accept allocated memory before use in
memblock_double_array()

stable/6.6 was fixed.

Fixed status
stable/6.12: [d66a22f6a432a9dd376c9b365d7dc89bd416909c]
stable/6.14: [aa513e69e011a2b19fa22ce62ce35effbd5e0c81]
stable/6.6: [7bcd29181bab8d508d2adfdbb132de8b1e088698]

CVE-2025-37967: usb: typec: ucsi: displayport: Fix deadlock

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [f4bd982563c2fd41ec9ca6c517c392d759db801c]
stable/6.1: [f32451ca4cb7dc53f2a0e2e66b84d34162747eb7]
stable/6.12: [5924b324468845fc795bd76f588f51d7ab4f202d]
stable/6.14: [61fc1a8e1e10cc784cab5829930838aaf1d37af5]
stable/6.6: [962ce9028ca6eb450d5c205238a3ee27de9d214d]

CVE-2025-37968: iio: light: opt3001: fix deadlock due to concurrent flag access

stable/6.12 was fixed.

Fixed status
stable/6.12: [7ca84f6a22d50bf8b31efe9eb05f9859947266d7]
stable/6.14: [2c95c8f0959d0a72575eabf2ff888f47ed6d8b77]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

