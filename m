Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC13C74A5B
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 23:53:18 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web10.13055.1680133993384788229
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Mar 2023 16:53:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=YA3LYC40;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.172, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f172.google.com with SMTP id l18so12939519oic.13
        for <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1680133992;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=adHtZtSnlYcu9eOjU0Ts8LmuzDt0yqFDII3SEUj+zA0=;
        b=YA3LYC40RG1VNzhaM3uSchi6MnVWKGJXuZYqxDMewwDKhEZvihX57DVVPUJb5A3da2
         wuuXPlaI2Wt2SuqR7j/ikKvGUjwGvijOEvVoxYpedgXzmdAJhDPrZsGwWwpejDvEWLg0
         3hXj+OeX4C002zif6v4T45hoylZlvoUd0jH1Yz3h54zjmV5X99qvjUTq4m6kt+ImAg1v
         fw8Rz2YN24HCamGfY5nCzNLYGGBXaHT9/tfn5+gPf/adQQQ5KxGxI3JxvZXzvpeJ8UQl
         It665cNJAcokChVA77OamQh64R0KqE8j5e/pd4v+E2QmEc9ha7yCsdcbzCxVknqY+Z5k
         BGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680133992;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adHtZtSnlYcu9eOjU0Ts8LmuzDt0yqFDII3SEUj+zA0=;
        b=Pxa8aEN4SaPZMb0JYQMagf7PS5LNAb9e2FOQJVyz/ztUVY8ENMCkDxoSn+xTYzVQWU
         RVnRFdu0rf/O+vhWNwf9BzN6Ka8oBehljFBgYRrO92mIOzHJmCjMSmCb1jViEXRivXUG
         KrcYc+w8mN8T1mWSASy3x4Fma8BthwWaPvMU+2WGFJenln45/KC6XY8e/VgLsHuYc471
         YxAAwbrhjkXVYcdw/+gLtJ2xObRGrQjws1dw5kVPAClDwN6q+IHNS110QvaVpXCDPd98
         I9gIz9qiqEozRPhHuCcCRVKsE4Tm+f3o0nRH3kZhI2Cen4O3o1AupQLtgonfypMehb1x
         1lRQ==
X-Gm-Message-State: AAQBX9fB1myaqa5PX6XW3VmjzPidXs52FKP43N2RFTaI0tuJt5FBUUO4
	VXIH6GI/HVJz4dEJp1DRKnQtZoUDyzqi9IIjwf7f7xXe1vPHis21bEU=
X-Google-Smtp-Source: AKy350Y1x6YoliPEJI5dK1ZsM4L5IYfeWXfPHo6adWcRAbmVHTBUDgvZ5StdkvMsUdVwEUha5FfqENP9jhVx5Kudu+s=
X-Received: by 2002:a54:4716:0:b0:384:1e6a:bf10 with SMTP id
 k22-20020a544716000000b003841e6abf10mr3251813oik.5.1680133991840; Wed, 29 Mar
 2023 16:53:11 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Mar 2023 08:52:35 +0900
Message-ID: <CAODzB9rdW=WGaAdNeihuT1zFHC=v_zbCoRPOq_QT_4=8WcBiug@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 23:53:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11133

Hi !

It's this week's CVE report.

This week reported 12 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2022-4744: tun: avoid double free in tun_free_netdev

CVSS v3 score is not provided.

A double free bug was found in the tun driver in the tun_free_netdev().
This bug will cause system crashes or potentially privilege escalation.
It looks as if 4.14 and 4.19 may be affected. 4.4 may not be affected.

Fixed status
mainline: [158b515f703e75e7d68289bf4d98c664e1d632df]
stable/5.10: [a01a4e9f5dc93335c716fa4023b1901956e8c904]
stable/5.15: [3cb5ae77799e8ed6ec3fec0b6b4cd07f01650cc5]

CVE-2023-0386: ovl: fail on invalid uid/gid mapping at copy up

CVSS v3 score is 7.8 HIGH.

A flaw was found in the Linux kernel, where unauthorized access to the
execution of the setuid file with capabilities was found in the Linux
kernel=E2=80=99s OverlayFS subsystem in how a user copies a capable file fr=
om
a nosuid mount into another mount.
This uid mapping bug allows a local user to escalate their privileges
on the system.
This bug was introduced by commit 459c7c5 ("ovl: unprivieged mounts")
in 5.11-rc1 so before 5.11 LTS kernels are not affected.

Fixed status
mainline: [4f11ada10d0ad3fd53e2bd67806351de63a4f9c3]
stable/5.15: [e91308e63710574c4b6a0cadda3e042a3699666e]
stable/6.1: [42fea1c35254c49cce07c600d026cbc00c6d3c81]

CVE-2023-1583: kernel: NULL pointer dereference in io_file_bitmap_get
in io_uring/filetable.c

CVSS v3 score is not provided.

A NULL pointer dereference bug was found in io_file_bitmap_get() in
io_uring subsystem. It will allow an unprivileged user to crash a
system via this bug.
It was introduced by commit 4278a0d ("io_uring: defer alloc_hint
update to io_file_bitmap_set()") in 5.19-rc1 so before 5.19 LTS
kernels aren't affected.

Fixed status
mainline: [02a4d923e4400a36d340ea12d8058f69ebf3a383]

CVE-2020-36691: netlink: limit recursion depth in policy validation

CVSS v3 score is 5.5 MEDIUM.

An issue was discovered in the Linux kernel before 5.8. lib/nlattr.c
allows attackers to cause a denial of service (unbounded recursion)
via a nested Netlink policy with a back reference.

Fixed status
mainline: [7690aa1cdf7c4565ad6b013b324c28b685505e24]

CVE-2023-0160: possibility of deadlock in libbpf function sock_hash_delete_=
elem

CVSS v3 score is not provided.

There is a possible deadlock bug in sock_hash_delete_elem() in bpf subsyste=
m.

Fixed status
Not fixed yet.

CVE-2023-28772: A heap overflow bug was found in seq_buf_putmem_hex()

CVSS v3 score is 7.8 HIGH.

An issue was discovered in the Linux kernel before 5.13.3.
lib/seq_buf.c has a seq_buf_putmem_hex buffer overflow.
This bug was introduced by commit 5e3ca0e ("ftrace: introduce the
"hex" output method") in 2.6.27-rc1.
So, all stable kernels are affected by this issue.

Fixed status
mainline: [d3b16034a24a112bb83aeb669ac5b9b01f744bb7]
stable/4.14: [50b51460f59acbd403475510ad423bb5ea7a4c97]
stable/4.19: [1f4c6061fccee64b2072b28dfa3e93cf859c4c0a]
stable/5.10: [f9fb4986f4d81182f938d16beb4f983fe71212aa]
stable/5.4: [33ab9138a13e379cf1c4ccd76b97ae2ee8c5421b]

CVE-2023-1582: fs/proc: task_mmu.c: don''t read mapcount for migration entr=
y

CVSS v3 score is not provided.

A race condition bug was found in task_mmu.c in procfs. If
PageDoubleMap() was called when this page is not a tail page of THP,
it will cause a system crash.
It was introduced by commit e9b61f1 ("thp: reintroduce
split_huge_page()") in 4.5-rc1 so Linux 4.4 kernels are not affected.

Fixed status
mainline: [24d7275ce2791829953ed4e72f68277ceb2571c6]
stable/5.10: [db3f3636e4aed2cba3e4e7897a053323f7a62249]
stable/5.15: [a8dd0cfa37792863b6c4bf9542975212a6715d49]

CVE-2023-1611: Kernel: race between quota disable and quota assign
ioctls in fs/btrfs/ioctl.c

CVSS v3 score is not provided.

A slab-use-after-free read flaw was found in btrfs_search_slot in
fs/btrfs/ctree.c. This bug allows a user to read kernel information
via ioctl.

Fixed status
Patch is available but it hasn't been merged into the mainline yet.

CVE-2023-1637: x86/speculation: Restore speculation related MSRs
during S3 resume

CVSS v3 score is not provided.

A flaw that boot CPU could be vulnerable for the speculative execution
behavior kind of attacks in the Linux kernel X86 CPU Power management
options functionality was found in the way user resuming CPU from
suspend-to-RAM. A local user could use this flaw to potentially get
unauthorized access to some memory of the CPU similar to the
speculative execution behavior kind of attacks.

It was introduced by commit 7724397 ("x86/bugs/intel: Set proper CPU
features and setup RDS") in 4.17-rc1. Linux 4.14 and 4.4 contain this
patch so they are affected too.

Fixed status
mainline: [e2a1256b17b16f9b9adf1b6fea56819e7b68e463]
stable/4.14: [7b5f17024f115b6aa42d2a079326dd0ca8e3449b]
stable/4.19: [edc7b755e8fce10009ac85bb234a035557301bc4]
stable/5.10: [fc4bdaed4d4ea4209e65115bd3948a1e4ac51cbb]
stable/5.15: [fab4b79e869a8e1c0f7d931a4eff0285d9b5efa7]
stable/5.4: [17f3e31c860371ff72db7f9b2fb44ab008a133e0]

CVE-2023-28866: HCI: Fix global-out-of-bounds

CVSS v3 score is not provided.

In the Linux kernel through 6.2.8, net/bluetooth/hci_sync.c allows
out-of-bounds access because amp_init1[] and amp_init2[] are supposed
to have an intentionally invalid element, but do not.
It was introduced by commit d0b1370 ("Bluetooth: hci_sync: Rework init
stages") in 5.17-rc1. This patch is not backported to older stable
kernels so before 5.17 kernels are not affected.

Fixed status
mainline: [bce56405201111807cc8e4f47c6de3e10b17c1ac]

CVE-2023-1652: NFSD: fix use-after-free in nfsd4_ssc_setup_dul()

CVSS v3 score is not provided.

A use-after-free flaw was found in nfsd4_ssc_setup_dul in
fs/nfsd/nfs4proc.c in the NFS filesystem in the Linux Kernel. This
issue could allow a local attacker to crash the system or it may lead
to a kernel information leak problem.
This bug was introduced by commit f4e44b3 ("NFSD: delay unmount
source's export after inter-server copy completed.") in 5.14-rc1 so
before 5.14 kernels aren't affected.

Fixed status
mainline: [e6cf91b7b47ff82b624bdfe2fdcde32bb52e71dd]
stable/5.15: [0a27dcd5343026ac0cb168ee63304255372b7a36]
stable/6.1: [32d5eb95f8f0e362e37c393310b13b9e95404560]

CVE-2023-28464: Bluetooth: hci_conn_cleanup function has double free

CVSS v3 score is not provided.

A use-after-free bug was found in hci_conn_hash_flush() in the
Bluetooth subsystem. It may cause a DOS or privilege escalation.
It looks as if all LTS kernels are affected.

Fixed status
Patch is available in the lkml
(https://lore.kernel.org/lkml/20230309074645.74309-1-wzhmmmmm@gmail.com/).

* Updated CVEs

no updated CVEs this week.

Fixed status

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

