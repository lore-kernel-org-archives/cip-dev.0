Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920E1CC6B2A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 22:50:17 +0000 (UTC)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27154.1792018211822974000
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2026 15:50:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=Y8SJuIsL;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677af43eed4so4306991d50.0
        for <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 15:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792018211; cv=none;
        d=google.com; s=arc-20260327;
        b=YPfOoZN1Oq4SsYg9r5BbkBnDUk3+NtTqZ9f+SV+YCJrGq9zqvQnuCnpuvMc7oOyFfA
         jgrkl36U29ZQnOpOJ4YUYhhsaNU1gU9m6EhkOOiUOtyS1lZC2lTQTVkwCvdRQouq7rNA
         QU6jz4UgLdNwWxWA86MbsSIiAM3VXoFkKNz0+klpDatghl+7jK5ilJUVa6cNdn5glssP
         Sj38wY0k7FYpB9Ti+ewYtz9df+J5vsFJvEM1AiqyFaUWJNKZRdE5fX6uFI3VGjl1BsmC
         ii3ZTejHqWnse7gNm8u9R5USNDmfLxGi1f0P0SkLueE4ONMqIom6wnKZgl0XISvBowhF
         rwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=c82PrpQD2W5ql65LcACUJMf0yK9CCoBwGZETrCW2Glo=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=fy8TIVxU4v78nwDcqoL9kprgEWgwbeKZlUQ9KeJmNxvmYIuNMrlcq7tmoM5g0F2BU+
         Mj17JvUu7hv3lyju5gNakQj3ECntuYR/zw2yn1DozcKBAQigK/6VlOeUZSMMBbCPlHfw
         zH9APTqwTypbSVkC10JEeBrI/r+VnkOhVqGsRy9s7fnDbTo4QUcLFK3s9DxkMgIZ5K9i
         dU3ZXvUqzez1J6xfiUvXXkk3ebV6dhsDy0n7+RFyzLX+TXGVPA4DAlTCyEkICFMW8vbS
         gphAelCeeV9FscQzdgIFiS9WUpKgJD+1pQA/wZbSS+ldZ0mPnWxi03RT0sGZdPSZHQeP
         5YZg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1792018211; x=1792623011; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c82PrpQD2W5ql65LcACUJMf0yK9CCoBwGZETrCW2Glo=;
        b=Y8SJuIsLMagaSd4CCcMTm342Fy5nYetBp7/x7wSs096T+iq601VUDU867GPL+ma+tr
         UCanNkTIdPe4aOiO76RFPUHcu6O2v1xp5WF46W9BnQT1CYl9Ja0k2s3rkbPr7DDac5DZ
         bEfpKXtmq5bhDkWCm7CA8+RjLbTs790QaBSxKvJgPvBczwGGbhi8kLrroJHsP3Av92vq
         1gBSF4UtXu1hjOUzQnDVa0DlEhFiQ3EjeZGJ1D2zLEDfjiZuCgBPSSLZifuTzh4Qix0l
         zB3iLjXU21GK529IcBQrHCofJL7wPYyNr3PqtPRP/PmHcW3t4eiBbFpDyLGRQWRFNcnk
         2phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792018211; x=1792623011;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c82PrpQD2W5ql65LcACUJMf0yK9CCoBwGZETrCW2Glo=;
        b=iLR4UKk9ukWReIv9twNYKjUqp6EKy3D8cce2lYD4RG+hTvaRVKgzmwuacUX3nzTcpW
         OCp8Cxg64R3M8W+QLPHnkZ/D5eKr8CxOp9RyUwVtvJKjn17V+GuKOXjk/nOkanrgMw2B
         lBzMkpqwTEtftEQzknN361DhDT3tKKd4BRD91zOtaO3rAhY0I2prGhAUm8uhW2WO9hsn
         HvRjjgqoVeuQTorKY60yQsqjc2urt+l48AIEzF28ByLO568lUkEXR1dBk49s8aPqakNH
         mybR8YMhs5R1V6NcoEcaQSTNy16AULV2HjRpTWK/57/3n7Q2o2RNbq+PKBDbcZhB9apg
         SXWw==
X-Gm-Message-State: AFq9FYKbQcNJZjJQO8j1CXijnVBw1zkDcw/n6/+Kr24wq3fesWgJUAPV
	Xnq8ZHjJU/j/rQ32IhTdAcSV9yJ/2G7e55pp5OFVpnv6FqZ+6qxu4P1W6rpfDj+4vVvLaWJ+xJ0
	2v+20rU67Hy2CAfOLlA8RgqPXB/ca+qDH2aw0qKmlzzHIZo5lGMlnDrejlA==
X-Gm-Gg: AYBFou1igt7w4gTR7Adg4E3GL8IYZFYOwnNmGMiuaQVv8szKLMxxK80oTKGDYiay4NW
	Lc9mfvRZz9XCYkDdbQ2ezhY+gyXq7ZmE9hbtHKp5tmycW7EzH+YmlgxVK2xcUNOxutnCoPWlGOm
	kYm6z2bkifeX9W685KrAspKrFtoIlc7K5/WGJmxpfisn5/DHasPZEC/97plYQKMTUpuTyi0Ur/X
	cNoPoJC9i5uaXiHKqoSYTk/v09k1wXv2qvoZi4TuFa+hUHnUQQJQI1odwEUKNvGx9wpoJSyzmxz
	ZT/qFb2rtstGPwXTrrFDIht6kNsarNxwJfA5XRYTY4G/ElzuBzUFeJrEbWZlYO+D3amvDSR+Jn9
	YB5eGkvREAh//alVAqz5IAk+zdoQ=
X-Received: by 2002:a05:690e:806:10b0:676:9115:60f7 with SMTP id
 956f58d0204a3-679367692a4mr4854252d50.12.1792018209970; Wed, 14 Oct 2026
 15:50:09 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Oct 2026 07:49:33 +0900
X-Gm-Features: AclHuK8ofIXnE3-tUyICSFg8Ud4btXjHT31TdfjG0EB17EcYsS6LbX3iv2I2l6o
Message-ID: <CAODzB9pLTMVK3wqknzeQh8wadRb7J7p1r8aV2cP70wDFj3ihzA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 22:50:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24464

Hi!

It's this week's CVE report.

This week reported 57 new CVEs and 8 updated CVEs.

* New CVEs
CVE-2026-98375: xen/netfront: drop RX packets with a short Ethernet header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98375

Introduced by commit 0d16021 ("xen: add virtual network device
driver") in v2.6.23-rc1.
Fixed in .

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [089e58805c452e52179482b1025a8e309a57f801]
stable/6.18: [72d2f54367895d6e236b9857892e2e6b6036e067]
stable/7.2: [e2b721bc30f40ffa7ccc36a56d4e8990b8c0538e]

CVE-2026-98376: bpf: Use array_map_meta_equal for percpu array inner
map replacement

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98376

Introduced by commit db69718 ("bpf: inline bpf_map_lookup_elem() for
PERCPU_ARRAY maps") in v6.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [593980175389a05793f6060aa20e626330960395]

CVE-2026-98377: vlan: require the MAC header to be present in
__vlan_insert_inner_tag()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98377

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab888242fce4f16f6c4d4c6ec53939ad36aa3b3a]
stable/6.12: [40a5cc4b7251c74f3341332a226d02200e96bccf]
stable/6.18: [f42562dd027dc4ed103fae17b2206e73ea1963c4]
stable/7.2: [59af43ccece4d2d8b62e9e3ccc96b6e2e793bcdc]

CVE-2026-98378: bpf: Skip unsettled links in link iterator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98378

Introduced by commit 9f88361 ("bpf: Add bpf_link iterator") in v5.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50e80e2bb5e2be8515205b9c496b9640ddefa434]
stable/6.1: [68930f8d40ab4c10ca3b019f076136758fd100a8]
stable/6.12: [798a61edbc436cacdb659927d067368eeb1e30e2]
stable/6.18: [6e271f093d15d323f42de26f66556af53fa8e19f]
stable/6.6: [c251ed48bd9063cf7de6049421e78b6de989060f]
stable/7.2: [87ce4b53b7436b50fc984f0a6afaf77f68ac5573]

CVE-2026-98379: netfilter: ip6t_rpfilter: reject routes without inet6_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98379

Introduced by commit e26f9a4 ("netfilter: add ipv6 reverse path filter
match") in v3.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b9b5323725e458906c7620a3bc10398b51ad954]
stable/5.10: [f4de78756b0fddbd125b2b1b77c74f2eccc8e977]
stable/5.15: [1681ab6dd1271f2f36047490793b78b1848bbcc9]
stable/6.1: [65487e9e99431ffcf05024a817f51ee4e3bd9b47]
stable/6.12: [290c96e5d9471d1ded9ab1e8ffbb04f6ee7b0f40]
stable/6.18: [eafe081ea77d25b5c8e601680671b4ecb4520e7d]
stable/6.6: [f49da48bd679cfee646d6a40dd02b1933de577d1]
stable/7.2: [3a7384bc2e66217c9a01a392281334f4423740a0]

CVE-2026-98380: net/sched: reject IDR error pointers when deleting actions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98380

Introduced by commit 0190c1d ("net: sched: atomically check-allocate
action") in v4.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c82b797abe668d0b668601a93ba2c0b071a63574]
stable/5.10: [39b751a210bf61a374afa82749afc7a77a08bf1d]
stable/5.15: [dd80a7519824b72c8fcfd3cc50cb93f7e2d90923]
stable/6.1: [6bf076258aac4e0af69ef317656c31ce6444d647]
stable/6.12: [259caa711b7688365676442e2fdb286b8aceaa80]
stable/6.18: [968550a439f64bd1a6c0d88efb92e4f082f84a26]
stable/6.6: [6c9f07bf8800171de2cd3f02815cebe1f4d45f2d]
stable/7.2: [a9551f26287debe6d8aa6e8841974661065b975f]

CVE-2026-98381: veth: manage XDP program pointers during channel resize

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98381

Introduced by commit 4752eeb ("veth: implement support for set_channel
ethtool op") in v5.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7104a370714346b667712913dc16abf14bbc97ed]
stable/5.15: [7a8e143109ff2736dc79e41dcd55af7ceab7520a]
stable/6.1: [1a5c5b9c64ba5f39dba55da6e12561ca56eeb758]
stable/6.12: [3c10a5dd0d38f506f671dbb59e9d0ee4c72076f9]
stable/6.18: [25bb7c36225220d30f404d7e29d2e052bc5f4b99]
stable/6.6: [f0e8dba8c224981e53c792c6b3dbb7604fb2c2c6]
stable/7.2: [43f6b647f209591b1e3f726bb16b8dcba6b95908]

CVE-2026-98382: bpf: Reject dev-bound-only programs on other devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98382

Introduced by commit 2b3486b ("bpf: Introduce device-bound XDP
programs") in v6.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6db1ce73e9853f533eb7f413f14ba00f8ec6f80d]
stable/6.12: [0dceda331180617aeeb22381e8480b37f18ba08b]
stable/6.18: [940b626854de200e6187777d42114727daca617c]
stable/6.6: [e57f04194361574493e3e6cf0b9e9c69e4ae9791]
stable/7.2: [bb375f3c5990e29851894f20ebc4b9dbc6676126]

CVE-2026-98383: bpf: Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98383

Introduced by commit 004d4b2 ("ipv6: sr: Add seg6local action
End.BPF") in v4.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4a62833adff6ef0fe7c0b90393204fe3c26b5c5]
stable/5.10: [0f38472a2aa8704a6b514c0dfa9c32f3672b8f32]
stable/5.15: [cae8674489f26edf7553fdd660599466cbb4c32f]
stable/6.1: [9f9e57b5a3a033f95f49ef9d541340cdbcb80abb]
stable/6.12: [b9bb0e735460751b620156f800a4279a28573392]
stable/6.18: [37b18688cd18fd86d2f35c212df1611862a26cd5]
stable/6.6: [df0072be6fc373cb22f9ea854d458b04e32a03cf]
stable/7.2: [fca71ead7a20290af1e2046983eeafae43d21af1]

CVE-2026-98384: bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98384

Introduced by commit 4ddbcb8 ("bpf: Add bpf_sock_destroy kfunc") in v6.5-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01b245ba016d44861690594e10f67e026ce8552f]
stable/6.12: [a9651704c6fd64590b5ad4fbe7c3768accf95993]
stable/6.18: [91a482a81eabddebf5430cbbdf12027e1a91b767]
stable/6.6: [5b4eb82475ae17d55974235c09e97044829426a8]
stable/7.2: [2534a5e5d360c2b10203cfa80f4ab9d021e48f2f]

CVE-2026-98385: sched/cache: Decouple sched_cache_group from mm to fix UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98385

Introduced by commit df0d984 ("sched/cache: Introduce infrastructure
for cache-aware load balancing") in v7.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28f9c0e0a0b94c5d3e1b634db545f6e1f94858c5]
stable/7.2: [852ecb6bc0bc0106f44f74ba3944524732486025]

CVE-2026-98386: scsi: qla2xxx: Use memset_io() to clear QLAFX00
request ring slot

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98386

Introduced by commit 8ae6d9c ("[SCSI] qla2xxx: Enhancements to support
ISPFx00.") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [626e44f3d8a924a97a3848a9fd45833947e081e9]
stable/6.12: [53eb96c244d150dfb8cc4b5b0492ab53755f3701]
stable/6.18: [6ee6dfd922fafd508f6bde16de30dd2db796b7a7]
stable/7.2: [e41d28d9a242c4005b7d01a7ee7769405a6a2c2e]

CVE-2026-98387: s390/crypto: Fix skcipher_walk return code handling in aes_s390

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98387

Introduced by commit 7988fb2 ("crypto: s390/aes - convert to skcipher
API") in v5.5-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15fa028589c3a2545f0bff355eff06d5844196bf]
stable/6.12: [89b58645646d1dac34162cc2597f42266bfbf930]
stable/6.18: [35c3f97569306050e818fa18e17fa97c358f0f28]
stable/7.2: [aea3e1588f08e381a7a57b2bf1a60cc2347904cd]

CVE-2026-98388: exec: do_close_on_exec() before taking exec_update_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98388

Introduced by commit 6650527 ("proc: protect ptrace_may_access() with
exec_update_lock (part 1)") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [e780259b54e618ceb4763fbc21314acf3565e813]
stable/5.10: [955973fff4a36d39a848b00cac1706863f568fe1]
stable/5.15: [550feab5b01000ab314868b62211fb3ddfd600e8]
stable/6.1: [5aacc19ba2b1faf84c4a2f2cf9a1784e03d1ff38]
stable/6.12: [0d86cd6b709c39216e6ee5ea8f0fc4242bbb2b53]
stable/6.18: [19ddef61ee0a49782a60f8f497e50597ad5de2da]
stable/6.6: [3feb4020bfb7ccf0d347f27051639d25e19cd65d]
stable/7.2: [63be3d8511bdafa095cd14a393cbf3c58dbbb928]

CVE-2026-98389: drm/amdgpu: skip gfx switch_power_profile during GPU reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98389

Introduced commit is not determined.Fixed in v7.3-rc3.


Fixed status
mainline: [1f1d43418d61c8511779e0f63a954a78b9433b43]
stable/6.18: [054022c8e74fe9b6cde63e636146b87cfe40f107]
stable/7.2: [52947c09c41cfab4d3d802581b9acf8dbc142fc5]

CVE-2026-98390: x86/amd_node: Avoid divide by zero on virtualized systems

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98390

Introduced by commit 0a4b61d ("x86/amd_node: Fix AMD root device
caching") in v6.18-rc5.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72bd92bd8190d7869ecb462649ca40f297822a33]
stable/6.18: [9273a90465d58b82aca4bea71451ef6bee084928]
stable/7.2: [94e984d8858a3228952b02f84e66610961098cc2]

CVE-2026-98391: drm/xe: Guard page-fault worker with runtime PM check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98391

Introduced by commit f289f78 ("drm/xe: Add xe_guc_pagefault layer") in
v6.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20fce5b34b21a995839743b4917a1edd2fd503ba]
stable/7.2: [25764620ec64c0142e2c87c41787f45540cf09ff]

CVE-2026-98392: Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98392

Introduced by commit c2b636b ("Bluetooth: btintel_pcie: Add support
for PCIe transport") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dd1b41f96aad08444be1b7626c89de2b9f2abd4]
stable/6.12: [72bbd7c815ef92399b7b109977ae4669ce22ee6e]
stable/6.18: [932a87444107e6724d808082676bba5c915c98ad]
stable/7.2: [a641201a9b4d69ee8a7ef35f7aa597dddee6b9ee]

CVE-2026-98393: net: ipv4: Fix UDP length overflow with PMTU discover
and big MTU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98393

Introduced by commit daba287 ("ipv4: fix DO and PROBE pmtu mode
regarding local fragmentation with UFO/CORK") in v3.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b83641e0ab8b20eefcc4cdc5a059f897375291a2]
stable/6.18: [83fedc4741210f75be8ca5b487985a242bf6f18d]
stable/7.2: [81f540827d243b8dad76c1f44e70ea31719f393c]

CVE-2026-98394: af_unix: Return immediately when manage_oob() returns
NULL for 0-length buffer.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98394

Introduced by commit 314001f ("af_unix: Add OOB support") in v5.15-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e5ee08eb5858d175da6768d75d163817b6a9d4a]
stable/6.12: [3d3c7a3df66b2ca3d2cd1a2a0c37eb701feba713]
stable/6.18: [d5dd55b316ca229a4cbf11729483ba5bb57233e7]
stable/7.2: [c81c5be3826c8467945b964d0cf7f7b3d65461db]

CVE-2026-98395: powerpc/entry: Fix irq_soft_mask corruption on
replayed interrupt exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98395

Introduced by commit 334f3f6 ("powerpc/entry: Disable interrupts
before irqentry_exit") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63a7531ca31f9f097d9cc1cc3fe86ae683cdabdd]
stable/7.2: [95cd316a896f1c1aa4ee4a817ba3d4691103c81b]

CVE-2026-98396: powerpc: Do not restore KUAP in arch_exit_to_user_mode_prepare()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98396

Introduced by commit bee25f9 ("powerpc: Enable GENERIC_ENTRY feature")
in v7.2-rc1.
Introduced by commit 02565a7 ("powerpc: Introduce syscall exit arch
functions") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2549d749539487239475fbc8c614a1f9244d655]
stable/7.2: [c8e80c19c3b9c8db83a14fab00445a6064992442]

CVE-2026-98397: platform/x86: x86-android-tablets: hold device
reference for secondary fwnode teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98397

Introduced by commit 1448c2d ("platform/x86: x86-android-tablets:
enable fwnode matching of GPIO chips") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [144113b0a70fa18033a747ee5db6803308f7688c]
stable/7.2: [c62b6e081119f2ab03cfcafde1f83c0f50e8e726]

CVE-2026-98398: locking/lockdep: Invalidate stale class_cache entries
for zapped classes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98398

Introduced by commit a0b0fd5 ("locking/lockdep: Free lock classes that
are no longer in use") in v5.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02c6be7d675b21d81f0ba3a524346850a8c0e3bf]
stable/5.15: [f8a1281ab82df5b51fd0384354d4b21daf2b7af0]
stable/6.1: [1c9d664e2e067fca69e5a41d68e23bbc66a583fe]
stable/6.12: [f63c86e9d267629758adaba18579e784ddd63c32]
stable/6.18: [c7acfb04c7e2e2dea248282b21373d93296644dd]
stable/6.6: [6bc345f6d81ebe22e0f355c2a21d7e29691f9332]
stable/7.2: [baa320fbb2f9fea50f5632a307da8ce84fbef5bd]

CVE-2026-98399: s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98399

Introduced by commit 099b765 ("[S390] Automatic IPL after dump") in v2.6.30-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37f61b71cbc0caefc01022a19ee56fc2510e2e6e]
stable/6.12: [aed56fa3108b7095e6a048e134981506c056a6cb]
stable/6.18: [8d7988e8116c3d29d9e02ca9d37ee84577643f2d]
stable/6.6: [41647864e62b28388ecccc23a82f0e0a091f4ef2]
stable/7.2: [280ff19853440d59e031cd8fe161e81305721262]

CVE-2026-98400: s390/ipl: Fix NULL deref in kdump without re-IPL parm block

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98400

Introduced by commit 3b96784 ("s390/ipl: correct kdump reipl block
checksum calculation") in v4.17-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f918871112e8e7c581e99eb8e545af4e59c8367]
stable/6.12: [92d0829eae257544b6b0faccb6e7079c45e22d48]
stable/6.18: [50f9c40768e84f30d374235b3ee3850a94d9ac29]
stable/6.6: [030e88812435fc5d6aa42eee41fa77b5ea620327]
stable/7.2: [b6bf82bc5e00afaf836f8bb9a676bffc182a6bbd]

CVE-2026-98401: net: iptunnel: fix stale transport header during
tunnel decapsulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98401

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28a57fb2c5df4deb42a06e52fd36c14b37aa0034]
stable/6.12: [8c3d4dfcecf7670c1d752f1ae74b21b2af5feac1]
stable/6.18: [e4a5b01e59f7102169762b8f566c8e052d05c0ff]
stable/7.2: [3340b8565b85631cfeb0df049e8b46e3ef8bd7bd]

CVE-2026-98402: net: icmp: avoid invalid transport header access in
icmp_send tracepoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98402

Introduced by commit db3efdc ("net/ipv4: add tracepoint for
icmp_send") in v6.10-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [7fcc2fe39fed1cb98a7374a113ff3800e8f9af80]
stable/6.1: [ec6d4612d1c170e1cef1fe55526471da1e81e777]
stable/6.12: [b972b5e6168dc5d1e13297b1f37f71d6b21cc0f1]
stable/6.18: [04c0d35bac5122b533672a6775851dfae84e265e]
stable/6.6: [99654b651c6d5fe865798a2adb859767905f9278]
stable/7.2: [2b32f8c3560905582fb12ed68315a6e606367a6a]

CVE-2026-98403: s390/boot: Avoid IPL parameter append past command line

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98403

Introduced by commit 5ecb2da ("s390: support command lines longer than
896 bytes") in v5.16-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d76181dfabdaa720703167393704efacba343442]
stable/6.12: [af9866021a00ab9eeacf0c33ee73f3d134b4ed70]
stable/6.18: [73eec5a0d55916d7e1115f5d03a7ffc06d6215cf]
stable/7.2: [8d11bfec8666f8409fac9072e9c25b691d3e30ac]

CVE-2026-98404: drm/virtio: Fix a NULL vs ERR_PTR() bug in
virtio_gpu_user_framebuffer_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98404

Introduced by commit dc5698e ("Add virtio gpu driver.") in v4.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94579f24e2b526a04eb41050af0ba018c6f528e7]
stable/5.10: [975f3cf302bb7d7336df4c630a7c07e12780ad10]
stable/5.15: [07de0b31dd64094cd7d25729beaf2ecae74daa72]
stable/6.1: [5eda6cda0031ba17559d56882353be39e568ec09]
stable/6.12: [974845d2535a250b180e62f9ed50284f312c01a3]
stable/6.18: [45dc2788a5b0e1e2824d1f98af521bd3acc340d7]
stable/6.6: [3fe8a33715265ecb24ca0bcd0a575c926da4277c]
stable/7.2: [f1050a7d365283678b253828739d3866ae546a72]

CVE-2026-98405: smb: client: fix missing iov bounds check in parse_posix_sids()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98405

Introduced by commit a90f37e ("smb: client: parse owner/group when
creating reparse points") in v6.6.32.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b09d092eb24ad0110f16a9b7c1ed5d2a0c1733dc]
stable/6.12: [b862996e5105be1293da9cdc85da77b76021c3bd]
stable/6.18: [2f8ed71aaaba3bc8b19cd9930cc62e63e142b299]
stable/6.6: [d91b9a3b2b38e5ac1b51e9e5b23fe53ad7b49644]
stable/7.2: [eac6917a42899aad0617bbf04798c5dd946a1fe5]

CVE-2026-98406: wifi: mac80211: avoid WARN in set_bitrate_mask when
sdata not in driver

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98406

Introduced by commit 554a43d ("mac80211: check sdata_running on
ieee80211_set_bitrate_mask") in v3.5-rc5.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da2ca406f45a6e21760243152ed8d2e8e72915c2]
stable/5.10: [4ba86c44b2fcb1c3175caa2456b6d58f483446ab]
stable/5.15: [4095b66acae9893dd13deb39a4331651cb2f822b]
stable/6.1: [c2cd9c44777cf97be3e35c10b7c2d8f59ebb9306]
stable/6.12: [7978dda63d2b109ea9c3f7a096cd1aac6542cd54]
stable/6.18: [432c8532d5ccc2af77da43ed6ef1c80495a4efe8]
stable/6.6: [0d1700394e9f5d0bd9bebad8d5a50edf983f52fd]
stable/7.2: [c4ee5685af444024e6222ce29f6ed36adc44ffc3]

CVE-2026-98407: wifi: rsi: fix heap OOB write on key removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98407

Introduced by commit dad0d04 ("rsi: Add RS9113 wireless driver") in v3.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6c5ed7a98d7bc8b0f7918246f1c90ddb3f79dfa]
stable/5.10: [b79e2f6585c014c42384f4caa7a37b3e5d26179c]
stable/5.15: [c67fb3b875a83f9ba92afea4036c7b541f77512a]
stable/6.1: [62d40db89180cfab7a917395f9ffc1dac62b0019]
stable/6.12: [ac599cf8edf8aa2dae546f04d3f1849e32c2e738]
stable/6.18: [f4f2852b664c3ff1436785cd11258a0ce25b74b3]
stable/6.6: [00bea3589255603c38766cac4a4d6d36493b2556]
stable/7.2: [8dab6ee020b2cd951b670626ba44a95cd4deac3d]

CVE-2026-98408: watchdog: rzv2h: Avoid division by zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98408

Introduced by commit f6febd0 ("watchdog: Add Watchdog Timer driver for
RZ/V2H(P)") in v6.12-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt

Fixed status
mainline: [6274281c41efa8dd1aa5234c59ad904ff89d7af4]
stable/6.18: [eb14ee406e1d0fbbfb857f0eaa710daa8c2dc30e]
stable/7.2: [0dd78d9d9b546de08e2ae391541f48cea0a9b842]

CVE-2026-98409: watchdog: rtd119x: Avoid division by zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98409

Introduced by commit 2bdf6ac ("watchdog: Add Realtek RTD1295") in v4.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5af7d2cbd20f893def03c8310a460ade66a5d822]
stable/6.12: [1f22001b34984350844d629862f70934770cb796]
stable/6.18: [b4ede87765a2e58ca4f18f5f8037c4826b9cc93f]
stable/6.6: [757c721545b9ffac5c3042a0cd3685ea28af7e81]
stable/7.2: [8a12e049d517d7dee78500633f8f0e47262a67e0]

CVE-2026-98410: watchdog: da9063: fix suspend/resume handling of
HW_RUNNING watchdog

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98410

Introduced by commit a7ceca4 ("watchdog: da9063: optionally disable
watchdog during suspend") in v5.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cb575b71ab98194d2e040bded3a7281e089c5ed]
stable/6.1: [95adc37f47cdf5a5285f7163b24243680af510be]
stable/6.12: [1c42e39b0990371b9d76ae22c3f33eb6df341251]
stable/6.18: [960d1c85381bcaae866dd799b1c905ec5d39ebce]
stable/6.6: [c30b419c7e6fbe31c48a44c828174168b732dc5b]
stable/7.2: [1db134d0d2a51a136296584854570e5e04adedb0]

CVE-2026-98411: power: sequencing: fix NULL-pointer dereference in
pwrseq_device_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98411

Introduced by commit 249ebf3 ("power: sequencing: implement the pwrseq
core") in v6.11-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [242da4318d97380741516b595af3920207b2f0f1]
stable/6.12: [a2fb51ec8920279e9e908010f37b448775f42eff]
stable/6.18: [a2890c1eb96d1dd0bec1cce5fbc4ed5af1dfd55d]
stable/7.2: [efe21a5c5bfe23bd30a8e4ba4e2b04ae265348bb]

CVE-2026-98412: power: sequencing: fix NULL-pointer dereference in
pwrseq_unit_new()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98412

Introduced by commit 249ebf3 ("power: sequencing: implement the pwrseq
core") in v6.11-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [115b303e8e093d964089ec6f3c40d984d77b33d0]
stable/6.12: [29e03670cc384561a2037c69b0a1cc5232d3c6c3]
stable/6.18: [859880b07a75c7a29d141abfacbd750d25a8e920]
stable/7.2: [6e571aea60de7f4c62b77510495d1bcc7df406a1]

CVE-2026-98413: selinux: always fill AVC decision in avc_has_perm_noaudit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98413

Introduced by commit e6f2f38 ("selinux: replace BUG_ONs with WARN_ONs
in avc.c") in v5.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8861db305103107199b1426f25fde1fb6d465583]
stable/5.10: [c781e737aa0de95289b1774d5fd29388895737a9]
stable/5.15: [e308c5acfe283a66627fc407065626df4ab753ec]
stable/6.1: [f9da796fa238f8e4414ee8481e6c979759a3d563]
stable/6.12: [5a6f9a872b4ff68877caf998bee352153b7154bc]
stable/6.18: [24e00850bcff46b984f4c44b92e5499450fcfb5a]
stable/6.6: [e77461af13eab5c9a953cc52ec8432cc941d61e2]
stable/7.2: [835133337c2ce200db56f62d018c79087dee2603]

CVE-2026-98414: memcg: avoid charging the root memcg from
obj_cgroup_charge_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98414

Introduced by commit 20d6c17 ("memcg: avoid refill_stock for root
memcg") in v6.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e673d0879ef78c395cfe0d3ba316690a60055d8]
stable/6.18: [d5cdff14c385bf42d03c0dd4c3e88ddf4c28b8a9]
stable/7.2: [ecc03877b1b05cb1e3a72175ccb868383eccc518]

CVE-2026-98415: soc: samsung: exynos-pmu: fix use-after-free of
interrupt generator node

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98415

Introduced by commit 78b7289 ("soc: samsung: exynos-pmu: Enable CPU
Idle for gs101") in v6.18-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dd1999783d7d12434006289338373e49492dc96]
stable/6.18: [4450102d6aa2a85b1d2d8610920fcbe45eb0ef69]
stable/7.2: [164313e24cb0f51528bc2099c5564174ead11d8a]

CVE-2026-98416: dmaengine: ti: k3-udma-glue: fix NULL dereference in
k3_udma_glue_release_rx_chn()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98416

Introduced by commit d702419 ("dmaengine: ti: k3-udma: Add glue layer
for non DMAengine users") in v5.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0294b6dd515256c03ea2dbf508ddd3826d788579]
stable/5.10: [b51ed7885ab0e8ecad765adc13b465cb1498cdc9]
stable/5.15: [b2985956e06632939bee47cee13bccd78ad7c3a1]
stable/6.1: [967612574c542dec71f820a6eb16dea80dd187a1]
stable/6.12: [5a6cb4d387eebf7d32a6ed3fcd39f94bf38bd134]
stable/6.18: [b14e6c52872556de2d6c137531e0ce85085c10ed]
stable/6.6: [89f5414660724bb562db4ac74665da16d4a57d99]
stable/7.2: [5b2d92b7b177226e1dca2e80dc8369131276c2a4]

CVE-2026-98417: net: xfrm: reject unrepresentable espintcp transport headers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98417

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96f01b53c2d05e003b040892256de54a586e8529]
stable/5.10: [d37a5b87577c4b4c1a1dcb000a9dff1df2cf886b]
stable/5.15: [6c29681207bc213188afa603dff2d55e7178a341]
stable/6.1: [4a8243fd2e21980fa3fd10c0610e9155057cebd3]
stable/6.12: [327b2a457dd7d5445f7395f371f3c65de79bd5ce]
stable/6.18: [cce630c751279e974fa0bb574d80575e0cc7e8f3]
stable/6.6: [b2b84e73e0386ad0b4f9b8d3afde343e761f5275]
stable/7.2: [206f396f46149dc8bc4dfd2b54b9879ba3ee1d7d]

CVE-2026-98418: sched/core: Avoid false migration warning for proxy donors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98418

Introduced by commit b049b81 ("sched: Handle blocked-waiter migration
(and return migration)") in v7.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe3c73d7bc769e7afc252f867a3421fe168b898d]
stable/7.2: [e4a442da49fff7619b3cb2988e477022dcea6688]

CVE-2026-98419: drop_monitor: fix out-of-bounds write in reset_per_cpu_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98419

Introduced by commit 683703a ("drop_monitor: Update netlink protocol
to include netlink attribute header in alert message") in v2.6.31-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [439f392084f8f7f59ab9d47a9579185accefe1d8]
stable/5.10: [caf09c09e0f323015ab6777ed1bad5aa10688631]
stable/5.15: [56b12f0cd476e4d90a0e2663a80102b388ebf78c]
stable/6.1: [88d640efd655b10f9fa4e381caf777da1f17c2a6]
stable/6.12: [8a04047c6dbff2f49a561b1ff53b043f4807e855]
stable/6.18: [530ae0a1458078c7a81fbffd9ff17d42129364d9]
stable/6.6: [d54a044136b129822715e8798899af540ec7a9e9]
stable/7.2: [03b672eba4937ff18337049824a114012d57f202]

CVE-2026-98420: ksmbd: follow SMB2 session expiration semantics

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98420

Introduced by commit ea174a9 ("ksmbd: destroy expired sessions") in v6.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [d7fd1f98607f2cd358e583f9548bdf0173090a86]
stable/7.2: [c99ea7855124ca1428a1e59c2b4590aaef34eacf]

CVE-2026-98421: wifi: mac80211: require a peer station for TDLS setup confirm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98421

Introduced by commit 6f7eaa4 ("mac80211: add TDLS QoS param IE on
setup-confirm") in v3.17-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [038e1d126304fd25d507fd4e671232df57bd1799]
stable/6.1: [6bae6ef511a29ef12ab969adeea691067d4d5d74]
stable/6.12: [742c762bee59c973684f70dfed7de4945d3141e2]
stable/6.18: [fce36d242a18ddf64731d816a37564103172da11]
stable/6.6: [d0afa5395c46d73ad2090aa50209886e84f179bd]
stable/7.2: [1c0a5c96473b9e7a5f4c453ef6a13dc0f5589a4b]

CVE-2026-98422: wifi: mac80211: reset the AP_VLAN tailroom counter on ifdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98422

Introduced by commit f9dca80 ("mac80211: fix AP_VLAN crypto tailroom
calculation") in v4.1-rc6.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4504f3960dc4501c73be9f99eabda2e26e9db41e]
stable/5.10: [b0b32d3f163d24ea7134380666193bf398e9dc0b]
stable/5.15: [f6b34a7d64324faf28eedc0f8678b0f832f1cc36]
stable/6.1: [304a874670a0b6ab5589a7f60b4af0251797b121]
stable/6.12: [3d76b45e8432c0d75fcb9e90d92eaa3176898adf]
stable/6.18: [4b54d01b48445b66c9e576de92b90a3a3ae7b34a]
stable/6.6: [7775759e3cb35ef5a571b2d877c2a9b70a5d5f08]
stable/7.2: [875835377d8d62c849b4eb03a7abfafa71d7668f]

CVE-2026-98423: wifi: mac80211_hwsim: don't hand frames to mac80211
while stopping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98423

Introduced by commit 7882513 ("mac80211_hwsim driver support userspace
frame tx/rx") in v3.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87840d4a3a21b1c19b867a80e16ba69dff284de2]
stable/6.1: [5ce9b2bc9e73213e316a8c72400256a76bf41814]
stable/6.12: [2f59be7585dc81baa6f36b0035dd6848ea43d318]
stable/6.18: [5c79ef616aa16af582fb2cb93b0f750975a0004f]
stable/6.6: [c4e4fe330294e3936e0f4e15d6996468f8a45fb2]
stable/7.2: [d7fa45d8123a7f794b93fc22dbcf19f38dc4d8cb]

CVE-2026-98424: wifi: cfg80211: undo netns switch if renaming the wiphy fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98424

Introduced by commit 463d018 ("cfg80211: make aware of net
namespaces") in v2.6.32-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a41bd1938a9bfe226d444172a7e20e4bd5097960]
stable/6.18: [96bef5667b0c4aecb1b850d2343f69b9d684abb9]
stable/7.2: [739b7bf3942da4cde8eedb143d01a16ed865d1d7]

CVE-2026-98425: wifi: mac80211: don't warn when an IBSS has no channel to scan

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98425

Introduced by commit 34bcf71 ("mac80211: fix ibss scanning") in v3.8-rc4.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7491b7efbd9136b120a12ed72af9c12121dd134]
stable/6.12: [bb91c15953705445778c170a2523f12351c4d928]
stable/6.18: [5f139e17f5bdba6b68177dd8afe13fa4549dfc5f]
stable/7.2: [23d51c0bc18f21d957756ba4650520bb3bc726b2]

CVE-2026-98426: wifi: mwifiex: fix IRQ leak using wrong index in MSI-X
error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98426

Introduced by commit 99074fc ("mwifiex: enable pcie MSIx interrupt
mode support") in v4.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3d722190cdef18da4878b5efc27c3c386dda248]
stable/5.10: [11bc2cbb14f450eaa47cce9eb086f948ef8f4bcd]
stable/5.15: [1a60cb2292194cc9eafae7ca8a8a72d37ae78d97]
stable/6.1: [fcac5813f324cd07dfd36b4adf624fc70f7587d6]
stable/6.12: [5fd4cc87e6cc0839aac89c24ebe39ce262fe088f]
stable/6.18: [0969c9688389f2e0f65b1a924b0dd6625a3bb776]
stable/6.6: [2761b21cb896b1da8dd46cee5084c9032b2d7098]
stable/7.2: [03d5e4776e8b71c2468c5c3c48b39202c87a8796]

CVE-2026-98427: net/sched: codel: bound the dropping loop per dequeue call

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98427

Introduced by commit 76e3cc1 ("codel: Controlled Delay AQM") in v3.5-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f4a5ec6258fd7c92633ec4b0493fc51166d9398]
stable/7.2: [bacd72289d34d8c05b7de5a12448b87b6dd93878]

CVE-2026-98428: ALSA: usb: 6fire: Avoid embedded URBs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98428

Introduced commit is not determined.Fixed in v7.3-rc3.


Fixed status
mainline: [9fe49dbc023e82dfaee7b245997d820d01742a9a]
stable/6.1: [3ef9093d83ffecb8e5f6c9d5769a52d39df74f7a]
stable/6.12: [52a43c2d57e774489ac3fbbac06ff02f19bd9a52]
stable/6.18: [999f433c09e4668412bd68ca207ae2b4af863862]
stable/6.6: [8b8559aeaba2e51cfee1779b2383b085991f7d81]
stable/7.2: [d181434549b3da668110a25d743848cce9897f4e]

CVE-2026-98429: RDMA/efa: Keep EQ resources alive while IRQ is registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98429

Introduced by commit 2a15251 ("RDMA/efa: CQ notifications") in v5.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e22a3627b7151754f07f90ea3d1ab6e85f5d93f4]
stable/6.1: [3cd652dfcd822af26ba75d6d2d245ea7f73b499e]
stable/6.12: [795eb34bfd8b1ab347adc41a11e4bb97c3ac0ce6]
stable/6.18: [38871ff47e2a02f8d9a333a65f358d987247b5b0]
stable/6.6: [c767e2812cac83fef70fb8932c3f0fe97dff9388]
stable/7.2: [9ecd3dcbdf1f315aadc049b291f59c79dc478062]

CVE-2026-98430: RDMA/efa: Keep admin queues alive while IRQ is registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98430

Introduced by commit b7f5e88 ("RDMA/efa: Add the efa module") in v5.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e08aca85c02ff290f785f07acae758f0daf5f49e]
stable/6.1: [0a8a105978e5ace0d885964317c5aed8ab4c0a0c]
stable/6.12: [bc7e64bad96c23fb343f47689670d0037f1a65e7]
stable/6.18: [d2a1c0bf4139c17b8d7668322b78c28d8c5b2dd0]
stable/6.6: [00f7df59543cce445cfd2f109ace88c17d8aef4d]
stable/7.2: [cf5520d1c931a70ccce0a1a247113bcec47a42be]

CVE-2026-98431: RDMA/uverbs: Fix mmap_lock/disassociation_lock
circular dependency

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98431

Introduced by commit 51976c6 ("RDMA/core: Provide
rdma_user_mmap_disassociate() to disassociate mmap pages") in
v6.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [a44a3f175eaee7e5aeb6a8fed381c4a0d5f49236]
stable/7.2: [426f54f20b79c5b164a0472ad3f6ba36afcd08c6]


* Updated CVEs

CVE-2026-72064: net: mana: Sync page pool RX frags for CPU

stable/6.18 was fixed.

Fixed status
stable/6.18: [845c959178ccab020b67bed7f4eae3058135ec80]

CVE-2026-74596: fs,fsverity: remove check for fsverity being enabled
in setattr_prepare()

stable/6.18 was fixed.

Fixed status
stable/6.18: [b4c0c41b952c21baed3f822eab508ebbd1d355d9]

CVE-2026-80615: net: dst_metadata: fix false-positive memcpy overflow
in tun_dst_unclone

stable/6.18 was fixed.

Fixed status
stable/6.18: [90c29158159e4e02fe74c3d13787c1f9ff5e9e5f]

CVE-2026-80729: mm/huge_memory: initialise workingset state before folio split

stable/6.18 was fixed.

Fixed status
stable/6.18: [dc87b56b43c9143f2405e434cff1530c3488b571]

CVE-2026-80734: btrfs: initialize inode mapping flags for cached inodes

stable/6.18 was fixed.

Fixed status
stable/6.18: [e18b8236c57fcc67d793bfc866f4bb2581be9f72]

CVE-2026-89527: svcrdma: Use svc_xprt_put to free listener on create failure

stable/6.18 was fixed.

Fixed status
stable/6.18: [e68380710fc970e07610b2f42594575ad35fdb1c]

CVE-2026-89764: rust: devres: fix race between concurrent revokers

stable/6.18 was fixed.

Fixed status
stable/6.18: [e7930d857cc7930fc39b487ea9f3a453eca3713e]

CVE-2026-93179: drm/amd/powerplay: fix VoltageObjectInfo zero-stride
loop and OOB read

stable/6.18 was fixed.

Fixed status
stable/6.18: [0a6c9b3801903b6db91f3cbf148646b501dbded3]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

