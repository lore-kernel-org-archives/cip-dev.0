Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B053AC61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 00:04:33 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.1021.1678925063154862591
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Mar 2023 17:04:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=Y/J6Lbw2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f54.google.com with SMTP id v2-20020a056830090200b0069c6952f4d3so90366ott.7
        for <cip-dev@lists.cip-project.org>; Wed, 15 Mar 2023 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1678925061;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AqPoGHgelkTTq6RnNGsl8IhuEwshgPV/3V2QtfLScuI=;
        b=Y/J6Lbw2wtoYvfaGjGpUNSwludtzUb3CaFYH/sERMXV1lBiRyVDHRwEQ3qhDhYHtwW
         itymiyT39u3XhW9NR7nxKkXHhLGG/XRovZvlyTnVz87PZ+DNerA1bk9KFrgHRUWuIecd
         NIUgveoQASo9BfRgOn9j3Etv7i6WcNXUzMksQHjLl7XN2PwUjd5yj3jOfgS1jVEgiBI7
         x4IS51DnwFfsFtlMRbzD9ggYKsnXyPCfAqmdti1oph0v5tP1LfTOYpvlbkbaBoZrNqzw
         YoTxUKgMexbfs26uGdJ5JWdQ1wMSi5/vjjJbuaiGlKuAlyH/3wJbhfrhMuU27dZHJ0zp
         P0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925061;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqPoGHgelkTTq6RnNGsl8IhuEwshgPV/3V2QtfLScuI=;
        b=3O/OwV5uXaAnGc4DunCNRWpo000g9/vLwRiUBN3yJflnOGtJow9zeUKF2UJ5N4yujV
         k3RUXDK35f7ejWyTLZA1ELWcTDmYGQi5zUZA8liEgI1sF0FfodG+CwAN4K8onFhLdccw
         i/xdDcIATLNFA1wa2nt5ENPC16OrItrSz6HrnhqxyXPRurYtArQTEPS+pjNbfV5kpDMj
         rieLvgqHjWXERDXSmnAVFxsUPKxlz/REYnXBFgLDsKC4PG0ZulZ1a0Slqdit61u7v+yB
         duqvZ5RfLLVQv/FcnvV0SeaWaasEjw1rv+Rq7D9kw3mN/0KFUHKUGFoVvcmkNujovD1o
         m74w==
X-Gm-Message-State: AO0yUKWFElja9rJDAbSWDZw4f26QnkIYeYamC5/K9nGK3uk7mNdUwtb5
	/ye7LaLlSSisnhKzzdSwfEuV11OjJhm20JbxGHh8OTNtUpvmzA5AYm8=
X-Google-Smtp-Source: AK7set/qMnh9wcoRI8PRUIyv9sJBSKTVTKJevL4tmnDo6SAmkgyic7hDsWbNekMGVIa9AoqGh81UC32GzUhGpekebzw=
X-Received: by 2002:a9d:6092:0:b0:699:78fe:8f24 with SMTP id
 m18-20020a9d6092000000b0069978fe8f24mr1604479otj.4.1678925061397; Wed, 15 Mar
 2023 17:04:21 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Mar 2023 09:03:44 +0900
Message-ID: <CAODzB9qc6gzsAjfaJcu22tgEJzOtnsNE0+A5p+=FFd50+FipAA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Mar 2023 00:04:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11028

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 7 updated CVEs.

* New CVEs

CVE-2023-1032: net: avoid double iput when sock_alloc_file fails

CVSS v3 score is not provided.

A double-free bug was found in io_uring subsystem when handling
IORING_OPSOCKET operation.
This bug was introduced by commit da214a4 ("net: add
__sys_socket_file()") in 5.19-rc1. This patch is not backported to
older stable kernels. So, before 5.19 kernels are not affected by this
issue.

Fixed status
mainline: [649c15c7691e9b13cbe9bf6c65c365350e056067]
stable/6.1: [7c7570791b15c3b78e3229ae97825e7eb869c7da]
stable/6.2: [cb6aedc1fd9d808d7319db2f953f4886dd46c627]

CVE-2023-1380: wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

CVSS v3 score is not provided.

A slab-out-of-bounds read was found in brcmf_get_assoc_ies() in brcmfmac driver.
It hasn't been fixed in the mainline yet but it has been merged into
wireless-next tree.

It looks like 4.4 will be vulnerable as well.

CVE-2023-1382: Kernel: denial of service in tipc_conn_close

CVSS v3 score is not provided.

A race condition bug was found in net/tipc/topsrv.c. This results in a
null pointer dereference and use-after-free may be triggered.
It was introduced by commit c5fa7b3 ("tipc: introduce new TIPC server
infrastructure") in 3.11-rc1.

Fixed status
mainline: [0e5d56c64afcd6fd2d132ea972605b66f8a7d3c4,
a7b42969d63f47320853a802efd879fbdc4e010e]
stable/4.19: [2c9c64a95d97727c9ada0d35abc90ee5fdbaeff7,
f46826a6fce33c3549332c3eb1fbf615dc79be18]
stable/5.10: [e87a077d09c05985a0edac7c6c49bb307f775d12,
4058e3b74ab3eabe0835cee9a0c6deda79e8a295]
stable/5.15: [4ae907c45fcad4450423b8cdefa5a74bad772068,
33fb115a76ae6683e34f76f7e07f6f0734b2525f]
stable/5.4: [30f91687fa2502abb0b4d79569b63d1381169ccf,
59f9aad22fd743572bdafa37d3e1dd5dc5658e26]

CVE-2023-1390: components for: CVE-2023-1390 kernel: remote DoS in
TIPC kernel module

CVSS v3 score is not provided.

A null pointer dereference bug was found in the tipc module. If a
remote attacker sends a malicious packet, the system will crash.
It was introduced by commit af9b028 ("tipc: make media xmit call
outside node spinlock context") in 4.3-rc1.

Fixed status
mainline: [b77413446408fdd256599daf00d5be72b5f3e7c6]
stable/4.14: [3ed0b5bb8cf71b4b9f995d4b3763648674fa032a]
stable/4.19: [4d1d3dddcb3f26000e66cd0a9b8b16f7c2eb41bb]
stable/5.10: [60b8b4e6310b7dfc551ba68e8639eeaf70a0b2dd]
stable/5.4: [56e8947bcf814d195eb4954b4821868803d3dd67]

CVE-2023-28327: kernel: denial of service problem in net/unix/diag.c

CVSS v3 score is not provided.

A null pointer dereference issue was found in the unix protocol in
net/unix/diag.c. It allows a local user to crash the system.
Introduced by commit cae9910 ("net: Add UNIX_DIAG_UID to Netlink UNIX
socket diagnostics.") in 5.3-rc1. Before 5.3 kernels aren't affected.

Fixed status
mainline: [b3abe42e94900bdd045c472f9c9be620ba5ce553]
stable/5.10: [575a6266f63dbb3b8eb1da03671451f0d81b8034]
stable/5.15: [5c014eb0ed6c8c57f483e94cc6e90f34ce426d91]
stable/5.4: [c66d78aee55dab72c92020ebfbebc464d4f5dd2a]

CVE-2023-28328: media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()

CVSS v3 score is not provided.

A null pointer dereference bug was found in dvd-usb driver.
Introduced by commit 76f9a82 ("V4L/DVB: AZ6027: Initial import of the
driver") in 2.6.34-rc1.

Fixed status
mainline: [0ed554fd769a19ea8464bb83e9ac201002ef74ad]
stable/4.14: [c712d1ccbfb787620422b437a5b8fac0802547bd]
stable/4.19: [7abfe467cd685f5da7ecb415441e45e3e4e2baa8]
stable/5.10: [559891d430e3f3a178040c4371ed419edbfa7d65]
stable/5.15: [210fcf64be4db82c0e190e74b5111e4eef661a7a]
stable/5.4: [8b256d23361c51aa4b7fdb71176c1ca50966fb39]
stable/6.1: [6b60cf73a931af34b7a0a3f467a79d9fe0df2d70]

* Updated CVEs

CVE-2023-1076: tap: tap_open(): correctly initialize socket uid

stable 5.10, 5.15, 5.4, 6.1, and 6.2 were fixed.

Fixed status
mainline: [66b2c338adce580dfce2199591e65e2bab889cff,
a096ccca6e503a5c575717ff8a36ace27510ab0a]
stable/5.10: [4a9272a864cbf6dacc3f4b35213108dd01691d31,
9a31af61f397500ccae49d56d809b2217d1e2178]
stable/5.15: [db6efde0ab809d68c0db9284aae8224317367206,
67f9f02928a34aad0a2c11dab5eea269f5ecf427]
stable/5.4: [522d319cda951d5c7464490dfdd341e8b73eb7f8,
d92d87000eda9884d49f1acec1c1fccd63cd9b11]
stable/6.1: [035a80733ec47ed81aa159e16e56d2de106d3335,
b4ada752eaf1341f47bfa3d8ada377eca75a8d44]
stable/6.2: [fce60a29cc0cf888687e2686538a23d1a0db0468,
4aa4b4b3b3e9551c4de2bf2987247c28805fb8f6]

CVE-2023-1077: sched/rt: pick_next_rt_entity(): check list_entry

stable 5.10, 5.15, 5.4, 6.1, and 6.2 were fixed.

Fixed status
mainline: [7c4a5b89a0b5a57a64b601775b296abf77a9fe97]
stable/5.10: [80a1751730b302d8ab63a084b2fa52c820ad0273]
stable/5.15: [2c36c390a74981d03f04f01fe7ee9c3ac3ea11f7]
stable/5.4: [084cd75643b61fb924f70cba98a71dea14942938]
stable/6.1: [6b4fcc4e8a3016e85766c161daf0732fca16c3a3]
stable/6.2: [1099004ae1664703ec573fc4c61ffb24144bcb63]

CVE-2023-1079: Use-After-Free in asus_kbd_backlight_set()

stable 4.14, 4.19, 5.10, 5.15, 5.4, 6.1, and 6.2 were fixed.

Fixed status
mainline: [4ab3a086d10eeec1424f2e8a968827a6336203df]
stable/4.14: [df0fad94ca3787727b9cdd76797aaacf46fe93ed]
stable/4.19: [74b78391a9b6f67de90b13f5a85e329e3b3f5a72]
stable/5.10: [21a2eec4a440060a6eb294dc890eaf553101ba09]
stable/5.15: [3959316f8ceb17866646abc6be4a332655407138]
stable/5.4: [dd08e68d04d08d2f42b09162c939a0b0841216cc]
stable/6.1: [ee907829b36949c452c6f89485cb2a58e97c048e]
stable/6.2: [b08bcfb4c97d7bd41b362cff44b2c537ce9e8540]

CVE-2023-1118: kernel: use-after-free in drivers/media/rc/ene_ir.c due
to race condition

stable 4.14, 4.19, 5.10, 5.15, 5.4, 6.1, and 6.2 were fixed.

Fixed status
mainline: [29b0589a865b6f66d141d79b2dd1373e4e50fe17]
stable/4.14: [0987f836bc1a258cb8fb51669a5afb67bb01c31b]
stable/4.19: [52bde2754d76fc97390f097fba763413607f157a]
stable/5.10: [78da5a378bdacd5bf68c3a6389bdc1dd0c0f5b3c]
stable/5.15: [29962c478e8b2e6a6154d8d84b8806dbe36f9c28]
stable/5.4: [d120334278b370b6a1623a75ebe53b0c76cb247c]
stable/6.1: [029c1410e345ce579db5c007276340d072aac54a]
stable/6.2: [182ea492aae5b64067277e60a4ea5995c4628555]

CVE-2023-25012: HID: bigben_remove: manually unregister leds

stable 5.10, 5.15, 5.4, 6.1, and 6.2 were fixed.

Fixed status
mainline: [76ca8da989c7d97a7f76c75d475fe95a584439d7]
stable/5.10: [fddde36316da8acb45a3cca2e5fda102f5215877]
stable/5.15: [0fd9998052926ed24cfb30ab1a294cfeda4d0a8f]
stable/5.4: [25e14bf0c894f9003247e3475372f33d9be1e424]
stable/6.1: [f2bf592ebd5077661e00aa11e12e054c4c8f6dd0]
stable/6.2: [90289e71514e9533a9c44d694e2b492be9ed2b77]

CVE-2023-23004: malidp: Fix NULL vs IS_ERR() checking

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [15342f930ebebcfe36f2415049736a77d7d2e045]
stable/5.10: [a5bbea50d622b8f49ab8ee3b0eb283107febcf1a]
stable/5.15: [1c7988d5c79f72287177bb774cde15fde69f3c97]

CVE-2023-26606: KASAN: use-after-free Read in ntfs_trim_fs

The mainline, 5.15, and 6.1 were fixed.

Fixed status
mainline: [557d19675a470bb0a98beccec38c5dc3735c20fa]
stable/5.15: [ab53749c32db90eeb4495227c998d21dc07ad8c1]
stable/6.1: [f2e58e95273ce072ca95a2afa1f274825a1e1772]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

