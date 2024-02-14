Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260FCC48BC3
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 22:48:33 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web10.1314.1707950912230209437
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 14:48:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=1eTlwvX4;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.172, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3beab443a63so212517b6e.3
        for <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1707950911; x=1708555711; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JTrQlSGMqHrttoGreuktm918OmUGQhtR0WIFnEd88Dw=;
        b=1eTlwvX4w45bqUQ5t42UQEODlcqzx6Yteg8tewtj62ipnQ35ii9sCYC9q+xJQLil8/
         2nQQ8eAoZlRAX/lI7WWDmQcJrpoYFC+OcDzKjZhEqVGlzpyk/dWxT+awiCl8mpjMmIPg
         F65CXlUJwlcsMRVPwHhufA4OIEC9qoKpwncoMkhVx8lbjfpe9N5cuiIzQ6G0BPd64z0j
         IclsVyeXtcfNPZcXammmz9qQ/rZcFxYPpYBAewpOe45DJmG1aQERBkiP/7L+LiBAclF/
         BOOkyCImUmRom/IDwAAPdZNW4id9swYuuXuoe4WPDlSO6lWj/LKumuVxhhOi2UbclgFz
         IlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950911; x=1708555711;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTrQlSGMqHrttoGreuktm918OmUGQhtR0WIFnEd88Dw=;
        b=CmkAt+3I9EB5aOpAWCLOx5ML2XZ1bH/zQ6ZaknfKGWCIj5XzdGZW+NOlABemuWE+Qy
         eUImcGZKSsaDHeA9oFkGiGV8wtMAdqWDvy06H4axHsuIo790vJfhrIl4sYhReSFoBJdY
         676IF5rQdyYR3OzRQ7Z3iKqdtPgY2K/euPWBVaJ5Q9ym43jb8gTT454CqopOFsve+JUO
         RTaVx8rU8+CzZAM+yKPCxpA/N+SP9SMwEZDnwE6qSi11drxKvKaC2slTjJNk2rj+TEFM
         l9PUbh5E5zub9wNvHlt7bW1bQG7Pwn13X+Nn646klT4thti/hzNEh8F6HshoNkqzUufM
         /OnQ==
X-Gm-Message-State: AOJu0YzwzyrRTmu1eeXEXADI+2g47bSG5/5lspFG3yoRuXL5NZpDWQt+
	KK5J/IrQHo1n2ZnTpZ7XoQrYg93NkRDJHq0aV2aeBRUo+CeZ8IrlCtPqyOjRZ5Y8kN9mOYPH0Yk
	/TpnaqYdgEgYEBfkUSVFc566Q5Ysz4vMtuL2hPFQUXuny4NzvIpM=
X-Google-Smtp-Source: AGHT+IE7HhiiK6KfkRFTMRaKpmczA4aNrs88lLyhkWMiAJepo57jZVsUTV5XFg4deGAN7wFwGhuKEZ47mo2MImeRL5M=
X-Received: by 2002:a05:6870:d193:b0:21a:3627:efe1 with SMTP id
 a19-20020a056870d19300b0021a3627efe1mr4089260oac.25.1707950910770; Wed, 14
 Feb 2024 14:48:30 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Feb 2024 07:47:54 +0900
Message-ID: <CAODzB9qVpnemoOL5zAOXjsqMkzAg3u4Pofa5t+qgBcYtwcNnNw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 22:48:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14984

Hi!

It's this week's CVE report.

This week reported 7 new CVEs and 2 updated CVEs.

FYI:
The Linux kernel project has been accepted as a CNA
(http://www.kroah.com/log/blog/2024/02/13/linux-is-a-cna/).
CVEs will be announced to the linux-cve-announce mailing
list(https://lore.kernel.org/linux-cve-announce/).

* New CVEs

CVE-2024-1312: mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.1(MEDIUM)

A use-after-free flaw was found in the Linux kernel's Memory
Management subsystem when a user wins two races at the same time with
a fail in the mas_prev_slot function.
This issue could allow a local user to crash the system.

This bug was introduced by commit 5e31275 ("mm: add per-VMA lock and
helper functions to control it") in 6.4-rc1.
It was fixed in 6.5-rc4. So, it affects 6.4-rc1 to 6.5-rc3.

Fixed status
mainline: [657b5146955eba331e01b9a6ae89ce2e716ba306]

CVE-2024-1151: net: openvswitch: limit the number of recursions from action sets

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.5(MEDIUM)

A vulnerability was reported in the Open vSwitch sub-component in the
Linux Kernel. The flaw occurs when a recursive operation of code push
recursively calls into the code block.
The OVS module does not validate the stack depth, pushing too many
frames and causing a stack overflow. As a result, this can lead to a
crash or other related issues.

This bug was introduced by commit 798c166173ff ("openvswitch: Optimize
sample action for the clone use cases") in 4.12-rc1.
Linux 4.4 isn't affected.

Fixed status
Patch is available on the netdev mailing
list(https://lore.kernel.org/all/20240207132416.1488485-1-aconole@redhat.com/)
but it hasn't been merged into the mainline yet.

CVE-2023-52429: dm: limit the number of targets and parameter size area

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

dm_table_create in drivers/md/dm-table.c in the Linux kernel through
6.7.4 can attempt to (in alloc_targets) allocate more than INT_MAX
bytes, and crash,
because of a missing check for struct dm_ioctl.target_count.

It was fixed in 6.8-rc3.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]

CVE-2024-25739: ubi: Check for too small LEB size in VTBL code

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

create_empty_lvol in drivers/mtd/ubi/vtbl.c in the Linux kernel
through 6.7.4 can attempt to allocate zero bytes, and crash, because
of a missing check for ubi->leb_size.

Fixed status
Patch is available on the lkml
(https://www.spinics.net/lists/kernel/msg5074816.html) but it hasn't
been merged yet.

CVE-2024-25740: memory leak in ubi_attach

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A memory leak flaw was found in the UBI driver in
drivers/mtd/ubi/attach.c in the Linux kernel through 6.7.4 for
UBI_IOCATT, because kobj->name is not released.

Fixed status
Not fixed yet

CVE-2024-25741: usb/f_printer: WARNING in usb_ep_queue

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

printer_write in drivers/usb/gadget/function/f_printer.c in the Linux
kernel through 6.7.4 does not properly call usb_ep_queue, which might
allow attackers to cause
a denial of service or have unspecified other impact.

Fixed status
Not fixed yet.

CVE-2024-25744: x86/coco: Disable 32-bit emulation by default on TDX and SEV

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel before 6.6.7, an untrusted VMM can trigger int80
syscall handling at any given point. This is related to
arch/x86/coco/tdx/tdx.c and
arch/x86/mm/mem_encrypt_amd.c.

This bug was introduced by commit 1da5c9b ("x86: Introduce
ia32_enabled()") in 6.7-rc1. This commit was backported to 6.1 and 6.6
but not backported to 5.x and 4.x kernels.
This bug was fixed in 6.7-rc5.

Fixed status
mainline: [b82a8dbd3d2f4563156f7150c6f2ecab6e960b30]
stable/6.1: [b8ec27ae221eee458b15b700706db311474ac619]
stable/6.6: [34c686e5be2fa1c03ae09568159a9ef37d1c7cf5]


* Updated CVEs

CVE-2024-23850: btrfs: do not ASSERT() if the newly created subvolume
already got read

Fixed in the mainline. This bug was introduced by commit 2dfb1e4
("btrfs: preallocate anon block device at first phase of snapshot
creation") in 5.9-rc1.
The commit 2dfb1e4 is not backported to before 5.9 so these kernels
are not affected.

Fixed status
mainline: [e03ee2fe873eb68c1f9ba5112fee70303ebf9dfb]

CVE-2024-24855: NULL pointer dereference bug was found in scsi device driver

Added fixed commit to the mainline. This commit was merged in 6.5-rc2.

Fixed status
mainline: [0e881c0a4b6146b7e856735226208f48251facd8]

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

