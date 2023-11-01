Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E42C4332F
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:43:23 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web11.1975.1698878592828475725
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Nov 2023 15:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=aWyLMZiY;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.49, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1efb9571b13so200952fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 01 Nov 2023 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1698878592; x=1699483392; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qHKoHnyMRRrikVdPRlahQzlZiKkDJ+QTgkB5y5YyoDk=;
        b=aWyLMZiYwOjg2ZAmCPM4DRSH+MmVKQEIlrmi+ItjQ9wLkYTdxOMoPNTzdCYt5AKB2D
         zo0DunoJg0fdzSU1Jbt7rHvrNBs4gnmwspl86Sq63IvxRHG2kYSsEzuq/Kmahzlzs1gG
         VGdjs2lqsQNj56P8QMBBkWWnY5unsy6/DHBQHb0pwJq0FaxwvZvnEm3sWDpUSKidMOuP
         /UHl14XbZJ9Fu2sgzZfAbCPCdw3Sws/f3S/RKXH1YLJv5mf42zvtqVh4V5iPqC0HECNg
         l6NpCC+9u5ULSvYoUsG0jp7L5I0lol9sVPRrx9dfxNqZu9dgEXFp+3t1ikE+DrLO1j41
         xq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878592; x=1699483392;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHKoHnyMRRrikVdPRlahQzlZiKkDJ+QTgkB5y5YyoDk=;
        b=MmMQWP4nVXLxqI3ys2o2lBk64quqIiqLlUdUSqfKkLNOWTJFLTt7blORzSNnp74jkF
         pkXCJ7lLt4x+2gZ3N9e24EVTL0YTYwvyc/SHs95T0GquqOXxAhWC0TgnACzWk+dLeR+V
         0KqTfBBKpLKArJtcuHMfbG3rhylLoecfMO7daMA8bIZ0mPZ8KrRMFICtABZ/lcBG2k82
         x8FK1f8AftpE8WAYrIwlcP0vBAlHWwhZx/T27sPpr09RowdGR2OQOi698CxdnWkZ9n4i
         iS4mM73XWXHWoairiJnntbG/s1wffbKmIgBDE4c+Gqf7/TQVvT8cZ1S5a+K0yaHfondL
         wxdw==
X-Gm-Message-State: AOJu0Yy4k40wjwH7cP2Qry2byX8tr9llDCZC1233bGnWaHbDPUrFdKYP
	UpeDx3LJVS21JX2pTDu5M0JQvbczUBbUzxGqxRR1UnaSAPNbX/dpBBI=
X-Google-Smtp-Source: AGHT+IFtNLl2kb9kK6vb6mATvCEyHxUisNvGxmc7QhKpq+7B5rmS7mteBRdoRUuKH/8/O4zM7C0slVqBW1cABzSGyBg=
X-Received: by 2002:a05:6870:af8a:b0:1ea:c8a9:fce5 with SMTP id
 uz10-20020a056870af8a00b001eac8a9fce5mr19831467oab.38.1698878591770; Wed, 01
 Nov 2023 15:43:11 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Nov 2023 07:42:35 +0900
Message-ID: <CAODzB9qXfWykaoX8ei-g4_=7OhfOz5f+u=v4jOTRN0RirioRwg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Nov 2023 22:43:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13508

Hi!

It's this week's CVE report.

This week reported 2 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-46813: SEV-ES local priv escalation for userspace that have
access to MMIO regions

CVSS v3(NIST): N/A

An issue was discovered in the Linux kernel before 6.5.9, exploitable
by local users with userspace access to MMIO registers. Incorrect
access checking in the #VC handler and instruction emulation of the
SEV-ES emulation of MMIO accesses could lead to arbitrary write access
to kernel memory (and thus privilege escalation). This depends on a
race condition through which userspace can replace an instruction
before the #VC handler reads it.

This feature has been introduced since 5.10 so before 5.10 kernels are
not affected.
It was fixed in 6.6-rc7.

Fixed status
mainline: [63e44bc52047f182601e7817da969a105aa1f721,
b9cb9c45583b911e0db71d09caa6b56469eb2bdf,
  a37cd2a59d0cb270b1bba568fd3a3b8668b9d3ba]
stable/5.10: [6550cbe25de182f6c0176909a90b324cb375133f,
5bb9ba7dafbe18e027e335f74372ca65f07f7edd,
  d78c5d8c23c3f0e24168ea98760016665bf92a79]
stable/6.1: [57d0639f60f1ff04cbe7fd52823b94b894d7f812,
def94eb9a804acdcdba5b959ad72cf9119f03f3b,
  95ff590b802757f8b6bd32e7e5b21ef9b91e2583]

CVE-2023-46862: io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

CVSS v3(NIST): N/A

An issue was discovered in the Linux kernel through 6.5.9. During a
race with SQ thread exit, an io_uring/fdinfo.c io_uring_show_fdinfo
NULL pointer dereference can occur.

It looks like commit dbbe9c6 (" io_uring: show sqthread pid and cpu in
fdinfo") introduced this issue since 5.10-rc1.

Fixed status
mainline: [7644b1a1c9a7ae8ab99175989bfc8676055edb46]

* Updated CVEs

CVE-2023-1193: use-after-free in setup_async_work()

The mainline was fixed.

Fixed status
mainline: [3a9b557f44ea8f216aab515a7db20e23f0eb51b9]

CVE-2023-35827: net: ravb: Fix possible UAF bug in ravb_remove

The mainline, 5.10, 5.15, 5.4, 6.1, and 6.5 were fixed.

Fixed status
mainline: [3971442870713de527684398416970cf025b4f89]
stable/5.10: [db9aafa19547833240f58c2998aed7baf414dc82]
stable/5.15: [616761cf9df9af838c0a1a1232a69322a9eb67e6]
stable/5.4: [65d34cfd4e347054eb4193bc95d9da7eaa72dee5]
stable/6.1: [6f6fa8061f756aedb93af12a8a5d3cf659127965]
stable/6.5: [105abd68ad8f781985113aee2e92e0702b133705]

CVE-2023-4610: slab-use-after-free Read in radix_tree_lookup while
fuzzing Linux kernel 6.4-rc6 with syzkaller

The mainline was fixed. This fix reverts commit f95bdb7 ("mm: vmscan:
make global slab shrink lockless") that was merged in 6.4-rc1.

Fixed status
mainline: [71c3ad65fabec9620d3f548b2da948c79c7ad9d5]

CVE-2023-5158: vringh: don''t use vringh_kiov_advance() in vringh_iov_xfer()

Fixed in mainline, 5.15, 6.1, and 6.5.

Fixed status
mainline: [7aed44babc7f97e82b38e9a68515e699692cc100]
stable/5.15: [1e69422efcc60571cc04f6c1940da848a8c2f21b]
stable/6.1: [3a72decd6b49ff11a894aabd4d9b3025f046fe61]
stable/6.5: [0bf2b9c2f3545ffce5720de61c33fc171c0e480a]

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

