Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25907C021AA
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 22:35:38 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web11.36288.1740004537344066485
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2025 14:35:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=pcTPXPoW;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so354627276.3
        for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2025 14:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1740004536; x=1740609336; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zQfzDyc1yLwVFmjJK4buD4RBmEplMUXgPIWmaTL+FE4=;
        b=pcTPXPoWMKL6OjmkH5W07FJCVWvN4adKGhJoaCTwkBvsCFSinwPopHX8Db8lbdpAEq
         ZLwE5hUSjGN1/gA1OX2TjbKde8QftHSaJAYLVeB2Pnr99Lzpyyr3cjzg8QV9Z3dW1gQb
         VsmQAPRdrL5cJZfwILswzYGzGFm99BrGxjsyYzMURXXRZJnYnq6qme4COP06oVhP9jOq
         iAiX3SDLJ7jdcMnLBVzQthE0L7UxV548bhsbSV4zLPBvq9rg5BMpF8uCPNp5XXG1tZM3
         XihxoGXJbcQM1hud4bj8Ce2T5A4MrSILhR16+DrcFkOx/29yAEaZmfd0SskM0tmjWjJW
         27gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740004536; x=1740609336;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQfzDyc1yLwVFmjJK4buD4RBmEplMUXgPIWmaTL+FE4=;
        b=jKqP53KxZ+mckEFFxHPMzcMwfalcssF4u1wJxo3dbB0u+ey6QO1Ult16mrGPa9qtou
         LmeSoWC1leKha0+NUT10FD3i11NC4z7Vpv11ZJ31Ls/5N+SBLuumzp4M0zYpYC9z6fJb
         oku4d0xUwHOfstOejtcYBcw7aX0grF85MBWDTAFfytIlLmSA5qGcl1CtvWfObXok7CiG
         7XgKlOj/BzNabTeNy5QBV3l2q7X2g7GZd3t8Zhpaa4XH+cRUPMm2rQQhLkpGOxLkKHcB
         BBar/qomcF4VjwvQFcFLan0vhxp9XGFFAZmFAN9/1uuK7RyyEtpv5MakfHPpmt9bGLki
         n5AQ==
X-Gm-Message-State: AOJu0Ywz98alpnlA/3XWZpQQqLpeYF3vpL475DZ/CGQKVidSiSIBGJ2q
	S32ntEZD+9QQwRWOguS+mpmXtrisUhNxnPkEmn5SbmdguQ9ZRDRUG19sg66/waV097REybi6FnA
	T9/BmmRXQoR5tBHxSeqkhjR7v3ik6XkaiUfQIJzKwV2x919iuuQ0=
X-Gm-Gg: ASbGncttDeZiaISXUbiTToNWL9ys8bRraU+NXmO0PGH0m3PuFsBVeY2iUGSuNoUPUKQ
	B+QprfQj2Y8ZKEOaaRfzmHgiAgHQqZtN4qDcRKG88O09MfybDJ3rFnO79BVNiXcwULNccueoMzA
	==
X-Google-Smtp-Source: AGHT+IG+z4BiedDKTy6HLwkaFbuESB24T21KbNlpqYOj4O7KJe/goFRvnxfEuJEdBSvB0Pt6iEp/Wo77GUrwAYTMMhA=
X-Received: by 2002:a05:690c:6187:b0:6f9:3dd2:793f with SMTP id
 00721157ae682-6fb58365f2amr163241157b3.28.1740004536009; Wed, 19 Feb 2025
 14:35:36 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Feb 2025 07:35:00 +0900
X-Gm-Features: AWEUYZmgjvwQeFIXPTy4TXt3wZ0cVf2FVyW7b4p1uzmzZz8P4Fz7gkXpVhmXqio
Message-ID: <CAODzB9rf3we3E82C0XzSJhOYOCmxBhOf4AFYen=_48d9sdSSqw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2025 22:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17870

Hi!

It's this week's CVE report.

This week reported 20 new CVEs and 2 updated CVEs.

* New CVEs
CVE-2024-57949: irqchip/gic-v3-its: Don't enable interrupts in
its_irq_set_vcpu_affinity()

Announce: https://lore.kernel.org/linux-cve-announce/2025020928-CVE-2024-57=
949-1d60@gregkh/

Introduced by commit b97e8a2 ("irqchip/gic-v3-its: Fix potential race
condition in its_vlpi_prop_update()") in v6.10-rc3.
Fixed in v6.13.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [35cb2c6ce7da545f3b5cb1e6473ad7c3a6f08310]
stable/6.1: [d7b0e89610dd45ac6cf0d6f99bfa9ccc787db344]
stable/6.6: [6c84ff2e788fce0099ee3e71a3ed258b1ca1a223]

CVE-2025-21684: gpio: xilinx: Convert gpio_lock to raw spinlock

Announce: https://lore.kernel.org/linux-cve-announce/2025020930-CVE-2025-21=
684-bf8d@gregkh/

Introduced by commit a32c7ca ("gpio: gpio-xilinx: Add interrupt
support") in v5.12-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9860370c2172704b6b4f0075a0c2a29fd84af96a]
stable/6.6: [b0111650ee596219bb5defa0ce1a1308e6e77ccf]

CVE-2025-21685: platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger:
fix serdev race

Announce: https://lore.kernel.org/linux-cve-announce/2025020931-CVE-2025-21=
685-d720@gregkh/

Introduced by commit b2ed33e ("platform/x86: Add
lenovo-yoga-tab2-pro-1380-fastcharger driver") in v6.10-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59616a91e5e74833b2008b56c66879857c616006]

CVE-2024-57950: drm/amd/display: Initialize denominator defaults to 1

Announce: https://lore.kernel.org/linux-cve-announce/2025021052-CVE-2024-57=
950-ec91@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13.
It looks as if this bug was introduced by commit 70839da
("drm/amd/display: Add new
DCN401 sources") in 6.11-rc1.

Fixed status
mainline: [36b23e3baf9129d5b6c3a3a85b6b7ffb75ae287c]

CVE-2025-21686: io_uring/rsrc: require cloned buffers to share
accounting contexts

Announce: https://lore.kernel.org/linux-cve-announce/2025021054-CVE-2025-21=
686-d416@gregkh/

Introduced by commit 7cc2a6e ("io_uring: add
IORING_REGISTER_COPY_BUFFERS method") in v6.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19d340a2988d4f3e673cded9dde405d727d7e248]

CVE-2025-21687: vfio/platform: check the bounds of read/write syscalls

Announce: https://lore.kernel.org/linux-cve-announce/2025021054-CVE-2025-21=
687-59a8@gregkh/

Introduced by commit 6e3f264 (=E2=80=9Cvfio/platform: read and write suppor=
t
for the device fd=E2=80=9D) in v4.1-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce9ff21ea89d191e477a02ad7eabf4f996b80a69]
stable/5.10: [d19a8650fd3d7aed8d1af1d9a77f979a8430eba1]
stable/5.15: [92340e6c5122d823ad064984ef7513eba9204048]
stable/5.4: [f21636f24b6786c8b13f1af4319fa75ffcf17f38]
stable/6.1: [6bcb8a5b70b80143db9bf12dfa7d53636f824d53]
stable/6.6: [c981c32c38af80737a2fedc16e270546d139ccdd]

CVE-2025-21688: drm/v3d: Assign job pointer to NULL before signaling the fe=
nce

Announce: https://lore.kernel.org/linux-cve-announce/2025021054-CVE-2025-21=
688-bdf5@gregkh/

Introduced by commit e4b5ccd ("drm/v3d: Ensure job pointer is set to
NULL after job completion") in v6.13.
Fixed in v6.12.12.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [01a7e3a43ee2e6607169a75889412344c10b37fd]
stable/5.10: [1f66a3a1a516e4d545906916b3f3c8d1c5e909e6]
stable/5.15: [9793206fbf5293534c3a79d78f196e2cbb48c22d]
stable/6.1: [1f66a3a1a516e4d545906916b3f3c8d1c5e909e6]
stable/6.6: [6cfafcad46e95351c477da0ae7e3acb8f7550ada]

CVE-2025-21689: USB: serial: quatech2: fix null-ptr-deref in
qt2_process_read_urb()

Announce: https://lore.kernel.org/linux-cve-announce/2025021055-CVE-2025-21=
689-7ffe@gregkh/

Introduced by commit f7a33e6 ("USB: serial: add quatech2 usb to serial
driver") in v3.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [575a5adf48b06a2980c9eeffedf699ed5534fade]
stable/5.10: [94770cf7c5124f0268d481886829dc2beecc4507]
stable/5.15: [6068dcff7f19e9fa6fa23ee03453ad6a40fa4efe]
stable/5.4: [fa4c7472469d97c4707698b4c0e098f8cfc2bf22]
stable/6.1: [4b9b41fabcd38990f69ef0cee9c631d954a2b530]
stable/6.6: [6377838560c03b36e1153a42ef727533def9b68f]

CVE-2025-21690: scsi: storvsc: Ratelimit warning logs to prevent VM
denial of service

Announce: https://lore.kernel.org/linux-cve-announce/2025021055-CVE-2025-21=
690-e8ec@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [d2138eab8cde61e0e6f62d0713e45202e8457d6d]
stable/5.15: [81d4dd05c412ba04f9f6b85b718e6da833be290c]
stable/6.1: [182a4b7c731e95c08cb47f14b87a272b6ab2b2da]
stable/6.6: [088bde862f8d3d0fc52e40e66a0484a246837087]

CVE-2025-21691: cachestat: fix page cache statistics permission checking

Announce: https://lore.kernel.org/linux-cve-announce/2025021055-CVE-2025-21=
691-2bd2@gregkh/

Introduced by commit cf264e1 ("cachestat: implement cachestat
syscall") in v6.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f537664e705b0bf8b7e329861f20128534f6a83]
stable/6.6: [7d6405c13b0d8a8367cd8df63f118b619a3f0dd2]

CVE-2025-21692: net: sched: fix ets qdisc OOB Indexing

Announce: https://lore.kernel.org/linux-cve-announce/2025021056-CVE-2025-21=
692-9c7f@gregkh/

Introduced by commit dcc68b4 ("net: sch_ets: Add a new Qdisc") in v5.6-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d62b04fca4340a0d468d7853bd66e511935a18cb]
stable/5.10: [03c56665dab1f4ac844bc156652d50d639093fa5]
stable/5.15: [bcf0d815e728a3a304b50455b32a3170c16e1eaa]
stable/6.1: [1332c6ed446be787f901ed1064ec6a3c694f028a]
stable/6.6: [f4168299e553f17aa2ba4016e77a9c38da40eb1d]

CVE-2025-21693: mm: zswap: properly synchronize freeing resources
during CPU hotunplug

Announce: https://lore.kernel.org/linux-cve-announce/2025021056-CVE-2025-21=
693-b6d1@gregkh/

Introduced by commit 1ec3b5f ("mm/zswap: move to use crypto_acomp API
for hardware acceleration") in v5.11-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12dcb0ef540629a281533f9dedc1b6b8e14cfb65]

CVE-2024-57951: hrtimers: Handle CPU state correctly on hotplug

Announce: https://lore.kernel.org/linux-cve-announce/2025021256-CVE-2024-57=
951-691d@gregkh/

Introduced by commit 5c0930c ("hrtimers: Push pending hrtimers away
from outgoing CPU earlier") in v6.7-rc2.
Fixed in v6.13.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [2f8dea1692eef2b7ba6a256246ed82c365fdc686]
stable/5.10: [14984139f1f2768883332965db566ef26db609e7]
stable/5.15: [15b453db41d36184cf0ccc21e7df624014ab6a1a]
stable/5.4: [95e4f62df23f4df1ce6ef897d44b8e23c260921a]
stable/6.1: [3d41dbf82e10c44e53ea602398ab002baec27e75]
stable/6.6: [a5cbbea145b400e40540c34816d16d36e0374fbc]

CVE-2024-57952: Revert "libfs: fix infinite directory reads for offset dir"

Announce: https://lore.kernel.org/linux-cve-announce/2025021259-CVE-2024-57=
952-c0fe@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.
This patch revert commit 64a7ce7 ("libfs: fix infinite directory reads for
offset dir") in 6.11-rc4.

Fixed status
mainline: [b662d858131da9a8a14e68661656989b14dbf113]

CVE-2025-21694: fs/proc: fix softlockup in __read_vmcore (part 2)

Announce: https://lore.kernel.org/linux-cve-announce/2025021259-CVE-2025-21=
694-f5ca@gregkh/

Introduced by commit 5cbcb62 ("fs/proc: fix softlockup in
__read_vmcore") in v6.10-rc1.
Fixed in v6.13.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.6

Fixed status
mainline: [cbc5dde0a461240046e8a41c43d7c3b76d5db952]
stable/5.10: [80da29deb88a3a907441fc35bb7bac309f31e713]
stable/5.15: [649b266606bc413407ce315f710c8ce8a88ee30a]
stable/5.4: [84c4ed15626574c9ac6c1039ba9c137a77bcc7f2]
stable/6.1: [65c367bd9d4f43513c7f837df5753bea9561b836]
stable/6.6: [a5a2ee8144c3897d37403a69118c3e3dc5713958]

CVE-2025-21695: platform/x86: dell-uart-backlight: fix serdev race

Announce: https://lore.kernel.org/linux-cve-announce/2025021259-CVE-2025-21=
695-ca7d@gregkh/

Introduced by commit 484bae9 ("platform/x86: Add new Dell UART
backlight driver") in v6.10-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b2128aa2d45ab20b22548dcf4b48906298ca7fd]

CVE-2025-21696: mm: clear uffd-wp PTE/PMD state on mremap()

Announce: https://lore.kernel.org/linux-cve-announce/2025021259-CVE-2025-21=
696-2482@gregkh/

Introduced by commit 63b2d41 ("userfaultfd: wp: add the writeprotect
API to userfaultfd ioctl") in v5.7-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cef0bb836e3cfe00f08f9606c72abd72fe78ca3]

CVE-2025-21697: drm/v3d: Ensure job pointer is set to NULL after job comple=
tion

Announce: https://lore.kernel.org/linux-cve-announce/2025021259-CVE-2025-21=
697-e883@gregkh/

Introduced by commit 14d1d19 ("drm/v3d: Remove the bad signaled()
implementation.") in v4.19-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4b5ccd392b92300a2b341705cc4805681094e49]
stable/5.10: [a34050f70e7955a359874dff1a912a748724a140]
stable/5.15: [14e0a874488e79086340ba8e2d238cb9596b68a8]
stable/5.4: [1bd6303d08c85072ce40ac01a767ab67195105bd]
stable/6.1: [2a1c88f7ca5c12dff6fa6787492ac910bb9e4407]
stable/6.6: [63195bae1cbf78f1d392b1bc9ae4b03c82d0ebf3]

CVE-2025-21698: Revert "usb: gadget: u_serial: Disable ep before
setting port to null to fix the crash caused by port being null"

Announce: https://lore.kernel.org/linux-cve-announce/2025021201-CVE-2025-21=
698-ec61@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.
This fix revert commit 13014969 ("usb: gadget: u_serial: Disable ep before
setting port to null to fix the crash caused by port being null") in 6.13-r=
c7
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [086fd062bc3883ae1ce4166cff5355db315ad879]
stable/5.10: [99c866bea85efdebfb6953a8a305f21ef5ca4991]
stable/5.15: [20ce02f2f73af331dec76d3b8b78b18f4699db05]
stable/5.4: [76e7577bb89b327abdf72d4c0d486074a17f712a]
stable/6.1: [33233b06ad15730d0463e8f152db2eca15c7f498]
stable/6.6: [3d8f4dc8c78ffd77a4106614977c1e51531690f7]

CVE-2025-21699: gfs2: Truncate address space when flipping GFS2_DIF_JDATA f=
lag

Announce: https://lore.kernel.org/linux-cve-announce/2025021202-CVE-2025-21=
699-029f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [7c9d9223802fbed4dee1ae301661bf346964c9d2]
stable/5.10: [8c41abc11aa8438c9ed2d973f97e66674c0355df]
stable/5.15: [4e3ded34f3f3c9d7ed2aac7be8cf51153646574a]
stable/5.4: [2b0bd5051ad1c1e9ef4879f18e15a7712c974f3e]
stable/6.1: [2a40a140e11fec699e128170ccaa98b6b82cb503]
stable/6.6: [4dd57d1f0e9844311c635a7fb39abce4f2ac5a61]

* Updated CVEs

CVE-2024-50017: x86/mm/ident_map: Use gbpages only where full GB page
should be mapped.

stable/6.6 was fixed.

Fixed status
stable/6.11: [a23823098ab2c277c14fc110b97d8d5c83597195]
stable/6.6: [d113f9723f2bfd9c6feeb899b8ddbee6b8a6e01f]

CVE-2024-56549: cachefiles: Fix NULL pointer dereference in object->file

stable/6.6 was fixed.

Fixed status
stable/6.12: [9582c7664103c9043e80a78f5c382aa6bdd67418]
stable/6.6: [785408bbafcfa24c9fc5b251f03fd0780ce182bd]


Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

