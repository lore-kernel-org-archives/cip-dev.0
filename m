Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B96C28B22
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 23:05:27 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web11.7580.1741215925029233690
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 15:05:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=cQhu+QiH;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6119fc5e9bso20131276.0
        for <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 15:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1741215924; x=1741820724; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mnYb73syp8GUeP4FHjrD8BPCWeczvTUPN2mQzB6QPnA=;
        b=cQhu+QiHM1JylfoMwVgVr9vh8fDhAns/Ti6wIPkrleEAUPtEetLVjP8ExiDReraM6/
         TiRwJlQTPBlHxaWwspYvafG5tmQ8P+Hp7IpAmQ0uOMh3/Ud2RYzOwdVAsa5EHyWJtpqG
         wwcNfu6jPUpWOTRe/5R+y3jam08CjUg7X9cnkFflacrQP5NvxMpOmY7FDQXI7rZIUlI8
         DsN9ZOABfxZ7MrMqwECsQw00wlsTdsfcWmj3B8MB3sY7OFwPZd9M/L6nULQsG1JiVaQm
         OnlLrwbTDUOP4mcDUEDxqReyGyWElozfTqblDoqF/tOh6K+KSbocwqGPjDmY50N569vh
         5hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215924; x=1741820724;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnYb73syp8GUeP4FHjrD8BPCWeczvTUPN2mQzB6QPnA=;
        b=DgC1yUgK6Vc1pmpVea+mdzJJj/JzeoNr4G5biClhhox6GRcTBKqaGk0YCtxNZKomq2
         thwTKE3VKzvFVxqI3nOllpQqtHDHDONP2NOnWCBcpcSt8cComfFhaTuG7KKmYeZfZ+Wj
         xaO6B/ewszsrLsCp10ivzbARdW5Ikk7Cn0biyr/ENGudMWTg/eo9v7/9SyBOsVtsj7rg
         bAyG144kpjPOnwYGAoTuGDDYUra3fIfsj/5uEhq16pdunSo1w3nT+RTvRd76LKq9JdLf
         Q8rMzGogMm5CIqNnxHLqKUtJWbdgXc33ijtgTu68AnoOjxPtDRt6qXkP+BOnCkmjaVnc
         Zqzw==
X-Gm-Message-State: AOJu0YwIK4UqqhesOk4cEt3O1aaLan5rgMEhF6Iy2ibckoq03cm5bkQw
	ZCxbj95XdA61xGT8la8u2ZjlRxrpJbi7ar1wgkKFHL0ANlj6VOYm/NofIArPfCm0SQcPrscBpfu
	Fww4uum/tSJVuaTtoOgYb9WYjKg5mQGHtwyc1apd8vlhTAq8J/k4=
X-Gm-Gg: ASbGncsC4gP6Tulze4Nokexyy6o2rXN+tuwrha6atZDNdZz7oKDWn3eUB9ho6sU50po
	u97Wfjv/x0XeHx/NUcf33hkkQCXa2C9S+iRS2EyZ43bl+Y48GuA9AA1CFTQmvYbuAYNbD2uL3Ze
	n4BSWKJ7J/a+GVEmy5vtq5oSMCHsM=
X-Google-Smtp-Source: AGHT+IERY/YP16LLmzQvO86NKDYLjVHUYEaNVQ/t/16yVnvNz4hyc+ilhQFazNBqBwkuXboKrhT95bcx3GLnp3Rw5Y0=
X-Received: by 2002:a05:6902:98e:b0:e57:346f:5b12 with SMTP id
 3f1490d57ef6-e611e1b73fdmr6513241276.18.1741215923611; Wed, 05 Mar 2025
 15:05:23 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Mar 2025 08:04:47 +0900
X-Gm-Features: AQ5f1Jrwo_BnuqaE9Y9SbQwFzhE4RJHaQYYXlkhko4mxc09D-uBpADq0lNxgYi0
Message-ID: <CAODzB9qHpE35T=D+DdY4ZuVCOOV2pKnqaVRBtJpBUuUvtx+eKw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 23:05:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18047

Hi!

It's this week's CVE report.

This week reported 31 new CVEs and 7 updated CVEs.

* New CVEs

CVE-2024-58022: mailbox: th1520: Fix a NULL vs IS_ERR() bug

Announce: https://lore.kernel.org/linux-cve-announce/2025022748-CVE-2024-58022-60ab@gregkh/

Introduced by commit 5d4d263 ("mailbox: Introduce support for T-head
TH1520 Mailbox driver") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0f98e14c010bcf27898b635a54c1994ac4110a8]

CVE-2024-58034: memory: tegra20-emc: fix an OF node reference bug in
tegra_emc_find_node_by_ram_code()

Announce: https://lore.kernel.org/linux-cve-announce/2025022751-CVE-2024-58034-36fb@gregkh/

Introduced by commit 96e5da7 ("memory: tegra: Introduce Tegra20 EMC
driver") in v5.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9784e5cde1f9fb83661a70e580e381ae1264d12]
stable/6.1: [e9d07e91de140679eeaf275f47ad154467cb9e05]
stable/6.6: [c144423cb07e4e227a8572d5742ca2b36ada770d]

CVE-2024-58042: rhashtable: Fix potential deadlock by moving
schedule_work outside lock

Announce: https://lore.kernel.org/linux-cve-announce/2025022751-CVE-2024-58042-c5ba@gregkh/

Introduced by commit f0e1a06 ("sched_ext: Implement BPF extensible
scheduler class") in v6.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1d3422c95f003eba241c176adfe593c33e8a8f6]

CVE-2025-21798: firewire: test: Fix potential null dereference in
firewire kunit test

Announce: https://lore.kernel.org/linux-cve-announce/2025022751-CVE-2025-21798-5fcb@gregkh/

Introduced by commit 1c8506d ("firewire: test: add test of device
attributes for simple AV/C device") in v6.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [352fafe97784e81a10a7c74bd508f71a19b53c2a]

CVE-2025-21799: net: ethernet: ti: am65-cpsw: fix freeing IRQ in
am65_cpsw_nuss_remove_tx_chns()

Announce: https://lore.kernel.org/linux-cve-announce/2025022752-CVE-2025-21799-0420@gregkh/

Introduced by commit 93a7653 ("net: ethernet: ti: introduce
am65x/j721e gigabit eth subsystem driver") in v5.7-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4395a44acb15850e492dd1de9ec4b6479d96bc80]
stable/6.1: [aea5cca681d268f794fa2385f9ec26a5cce025cd]
stable/6.6: [88fd5db8c0073bd91d18391feb5741aeb0a2b475]

CVE-2025-21800: net/mlx5: HWS, fix definer's HWS_SET32 macro for negative offset

Announce: https://lore.kernel.org/linux-cve-announce/2025022752-CVE-2025-21800-d1e6@gregkh/

Introduced by commit 74a778b ("net/mlx5: HWS, added definers
handling") in v6.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be482f1d10da781db9445d2753c1e3f1fd82babf]

CVE-2025-21801: net: ravb: Fix missing rtnl lock in suspend/resume path

Announce: https://lore.kernel.org/linux-cve-announce/2025022752-CVE-2025-21801-5496@gregkh/

Introduced by commit 0184165 ("ravb: add sleep PM suspend/resume
support") in v4.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c2ebb2b49573e5f8726112ad06b1dffc3c9ea03]

CVE-2025-21802: net: hns3: fix oops when unload drivers paralleling

Announce: https://lore.kernel.org/linux-cve-announce/2025022752-CVE-2025-21802-0cc5@gregkh/

Introduced by commit 0dd8a25 ("net: hns3: disable sriov before unload
hclge layer") in v5.15-rc7.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [92e5995773774a3e70257e9c95ea03518268bea5]
stable/6.1: [e876522659012ef2e73834a0b9f1cbe3f74d5fad]
stable/6.6: [b5a8bc47aa0a4aa8bca5466dfa2d12dbb5b3cd0c]

CVE-2025-21803: LoongArch: Fix warnings during S3 suspend

Announce: https://lore.kernel.org/linux-cve-announce/2025022752-CVE-2025-21803-e8ea@gregkh/

Introduced by commit 366bb35 ("LoongArch: Add suspend (ACPI S3)
support") in v6.2-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26c0a2d93af55d30a46d5f45d3e9c42cde730168]
stable/6.6: [d49ab6857d98266010f3446c9c2063014db5b654]

CVE-2025-21804: PCI: rcar-ep: Fix incorrect variable used when calling
devm_request_mem_region()

Announce: https://lore.kernel.org/linux-cve-announce/2025022753-CVE-2025-21804-dea6@gregkh/

Introduced by commit 2a6d0d6 ("PCI: rcar: Add endpoint mode support")
in v5.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt

Fixed status
mainline: [2d2da5a4c1b4509f6f7e5a8db015cd420144beb4]
stable/6.1: [24576899c49509c0d533bcf569139f691d8f7af7]
stable/6.6: [2c54b9fca1755e80a343ccfde0652dc5ea4744b2]

CVE-2025-21805: RDMA/rtrs: Add missing deinit() call

Announce: https://lore.kernel.org/linux-cve-announce/2025022753-CVE-2025-21805-7256@gregkh/

Introduced by commit 667db86 ("RDMA/rtrs: Register ib event handler")
in v6.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81468c4058a62e84e475433b83b3edc613294f5e]

CVE-2025-21806: net: let net.core.dev_weight always be non-zero

Announce: https://lore.kernel.org/linux-cve-announce/2025022753-CVE-2025-21806-7910@gregkh/

Introduced by commit e387660 ("[NET]: Fix sysctl net.core.dev_weight")
in v2.6.12.
Introduced by commit 3d48b53 ("net: dev_weight: TX/RX orthogonality")
in v4.11-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1f9f79fa2af8e3b45cffdeef66e05833480148a]
stable/6.1: [5860abbf15eeb61838b5e32e721ba67b0aa84450]
stable/6.6: [6ce38b5a6a49e65bad163162a54cb3f104c40b48]

CVE-2025-21807: block: fix queue freeze vs limits lock order in sysfs
store methods

Announce: https://lore.kernel.org/linux-cve-announce/2025022753-CVE-2025-21807-a4bb@gregkh/

Introduced by commit ff956a3 ("block: use queue_limits_commit_update
in queue_discard_max_store") in v6.9-rc1.
Introduced by commit 0327ca9 ("block: use queue_limits_commit_update
in queue_max_sectors_store") in v6.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c99f66e4084a62a2cc401c4704a84328aeddc9ec]

CVE-2025-21808: net: xdp: Disallow attaching device-bound programs in
generic mode

Announce: https://lore.kernel.org/linux-cve-announce/2025022753-CVE-2025-21808-b8bf@gregkh/

Introduced by commit 2b3486b ("bpf: Introduce device-bound XDP
programs") in v6.3-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3595599fa8360bb3c7afa7ee50c810b4a64106ea]
stable/6.6: [b1bc4a35a04cbeb85b6ef5911ec015baa424989f]

CVE-2025-21809: rxrpc, afs: Fix peer hash locking vs RCU callback

Announce: https://lore.kernel.org/linux-cve-announce/2025022754-CVE-2025-21809-4258@gregkh/

Introduced by commit 72904d7 ("rxrpc, afs: Allow afs to pin rxrpc_peer
objects") in v6.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79d458c13056559d49b5e41fbc4b6890e68cf65b]

CVE-2025-21810: driver core: class: Fix wild pointer dereferences in
API class_dev_iter_next()

Announce: https://lore.kernel.org/linux-cve-announce/2025022754-CVE-2025-21810-0c14@gregkh/

Introduced by commit 7b884b7 ("driver core: class.c: convert to only
use class_to_subsys") in v6.4-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e128f82f7006991c99a58114f70ef61e937b1ac1]
stable/6.6: [f4b9bc823b0cfdebfed479c0e87d6939c7562e87]

CVE-2025-21811: nilfs2: protect access to buffers with no active references

Announce: https://lore.kernel.org/linux-cve-announce/2025022754-CVE-2025-21811-beb7@gregkh/

Introduced by commit 8c26c4e ("nilfs2: fix issue with flush kernel
thread after remount in RO mode because of driver's internal error or
metadata corruption") in v3.10-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [367a9bffabe08c04f6d725032cce3d891b2b9e1a]
stable/6.1: [58c27fa7a610b6e8d44e6220e7dbddfbaccaf439]
stable/6.6: [8e1b9201c9a24638cf09c6e1c9f224157328010b]

CVE-2025-21812: ax25: rcu protect dev->ax25_ptr

Announce: https://lore.kernel.org/linux-cve-announce/2025022754-CVE-2025-21812-9b17@gregkh/

Introduced by commit c433570 ("ax25: fix a use-after-free in
ax25_fillin_cb()") in v5.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [95fc45d1dea8e1253f8ec58abc5befb71553d666]
stable/6.1: [2802ed4ced27ebd474828fc67ffd7d66f11e3605]
stable/6.6: [7705d8a7f2c26c80973c81093db07c6022b2b30e]

CVE-2025-21813: timers/migration: Fix off-by-one root mis-connection

Announce: https://lore.kernel.org/linux-cve-announce/2025022709-CVE-2025-21813-9e46@gregkh/

Introduced by commit b729cc1 ("timers/migration: Fix another race
between hotplug and idle entry/exit") in v6.13.
Fixed in v6.14-rc2.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [868c9037df626b3c245ee26a290a03ae1f9f58d3]

CVE-2025-21814: ptp: Ensure info->enable callback is always set

Announce: https://lore.kernel.org/linux-cve-announce/2025022709-CVE-2025-21814-d723@gregkh/

Introduced by commit d94ba80 ("ptp: Added a brand new class driver for
ptp clocks.") in v3.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd53aa40e65f518453115b6f56183b0c201db26b]
stable/6.1: [5d1041c76de656f9f8d5a192218039a9acf9bd00]
stable/6.6: [81846070cba17125a866e8023c01d3465b153339]

CVE-2025-21815: mm/compaction: fix UBSAN shift-out-of-bounds warning

Announce: https://lore.kernel.org/linux-cve-announce/2025022709-CVE-2025-21815-19c9@gregkh/

Introduced by commit 3da0272 ("mm/compaction: correctly return failure
with bogus compound_order in strict mode") in v6.7-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1366e74342e75555af2648a2964deb2d5c92200]

CVE-2025-21816: hrtimers: Force migrate away hrtimers queued after
CPUHP_AP_HRTIMERS_DYING

Announce: https://lore.kernel.org/linux-cve-announce/2025022709-CVE-2025-21816-bbd4@gregkh/

Introduced by commit 5c0930c ("hrtimers: Push pending hrtimers away
from outgoing CPU earlier") in v6.7-rc2.
Fixed in v6.14-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [53dac345395c0d2493cbc2f4c85fe38aef5b63f5]

CVE-2025-21817: block: mark GFP_NOIO around sysfs ->store()

Announce: https://lore.kernel.org/linux-cve-announce/2025022710-CVE-2025-21817-2fc8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [7c0be4ead1f8f5f8be0803f347de0de81e3b8e1c]

CVE-2025-21818: x86/xen: fix xen_hypercall_hvm() to not clobber %rbx

Announce: https://lore.kernel.org/linux-cve-announce/2025022710-CVE-2025-21818-27ee@gregkh/

Introduced by commit b4845bb ("x86/xen: add central hypercall
functions") in v6.13-rc4.
Fixed in v6.14-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [98a5cfd2320966f40fe049a9855f8787f0126825]
stable/6.1: [522d726824cc570e0b6bf0b3af4d5a826f1b17c5]
stable/6.6: [242f7584da3ad041a9db809d33d27a8be8eccc29]

CVE-2025-21819: Revert "drm/amd/display: Use HW lock mgr for PSR1"

Announce: https://lore.kernel.org/linux-cve-announce/2025022710-CVE-2025-21819-5549@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc2.
This fix reverts a2b5a99 ("drm/amd/display: Use HW lock mgr for PSR1")
in 6.14-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [f245b400a223a71d6d5f4c72a2cb9b573a7fc2b6]
stable/6.1: [915697c2e69ac8d14dad498e6d6f43dbb7de3787]
stable/6.6: [dcc3f2c06d80da39eee742b51ddf0781affb260c]

CVE-2025-21820: tty: xilinx_uartps: split sysrq handling

Announce: https://lore.kernel.org/linux-cve-announce/2025022710-CVE-2025-21820-f4ab@gregkh/

Introduced by commit 74ea66d ("tty: xuartps: Improve sysrq handling")
in v4.6-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b06f388994500297bb91be60ffaf6825ecfd2afe]
stable/6.1: [de5bd24197bd9ee37ec1e379a3d882bbd15c5065]
stable/6.6: [8ea0e7b3d7b8f2f0fc9db491ff22a0abe120801c]

CVE-2025-21821: fbdev: omap: use threaded IRQ for LCD DMA

Announce: https://lore.kernel.org/linux-cve-announce/2025022707-CVE-2025-21821-ae41@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.
Affected function was introduced by commit f8e9e98 ("omap1: DMA: move
LCD related
code from plat-omap to mach-omap1") in 2.6.33-rc1.

Fixed status
mainline: [e4b6b665df815b4841e71b72f06446884e8aad40]
stable/6.1: [7bbbd311dd503653a2cc86d9226740883051dc92]
stable/6.6: [fb6a5edb60921887d7d10619fcdcbee9759552cb]

CVE-2025-21822: ptp: vmclock: Set driver data before its usage

Announce: https://lore.kernel.org/linux-cve-announce/2025022707-CVE-2025-21822-88c0@gregkh/

Introduced by commit 2050327 ("ptp: Add support for the AMZNC10C
'vmclock' device") in v6.13-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7d07cd4f77d77f366c8ffbb8ba8b61f614e5fce]

CVE-2025-21823: batman-adv: Drop unmanaged ELP metric worker

Announce: https://lore.kernel.org/linux-cve-announce/2025022708-CVE-2025-21823-9027@gregkh/

Introduced by commit c833484 ("batman-adv: ELP - compute the metric
based on the estimated throughput") in v4.6-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c8ecc98f5c65947b0070a24bac11e12e47cc65d]
stable/6.1: [781a06fd265a8151f7601122d9c2e985663828ff]
stable/6.6: [a7aa2317285806640c844acd4cd2cd768e395264]

CVE-2025-21824: gpu: host1x: Fix a use of uninitialized mutex

Announce: https://lore.kernel.org/linux-cve-announce/2025022708-CVE-2025-21824-1a04@gregkh/

Introduced by commit c8347f9 ("gpu: host1x: Fix boot regression for
Tegra") in v6.12-rc4.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02458fbfaa0170aabf8506f7d4ed054f02414251]

CVE-2022-49733: ALSA: pcm: oss: Fix race at SNDCTL_DSP_SYNC

Announce: https://lore.kernel.org/linux-cve-announce/2025030256-CVE-2022-49733-c0f1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc5.


Fixed status
mainline: [8423f0b6d513b259fdab9c9bf4aaa6188d054c2d]
stable/5.10: [fce793a056c604b41a298317cf704dae255f1b36]
stable/5.15: [8015ef9e8a0ee5cecfd0cb6805834d007ab26f86]
stable/5.4: [4051324a6dafd7053c74c475e80b3ba10ae672b0]

* Updated CVEs

CVE-2024-50146: net/mlx5e: Don't call cleanup on profile rollback failure

stable/6.6 was fixed.

Fixed status
stable/6.1: [db84cb4c8c565e6d4de84b23c2818b63991adfdd]
stable/6.11: [3955b77494c3c7d14873b1db67e7e00c46a714db]
stable/6.6: [d6fe973c8873c998734a050f366b28facc03d32a]

CVE-2024-52559: drm/msm/gem: prevent integer overflow in msm_ioctl_gem_submit()

stable/6.6 was fixed.

Fixed status
stable/6.12: [2f1845e46c41ed500789d53dc45b383b7745c96c]
stable/6.13: [e43a0f1327a1ee70754f8a0de6e0262cfa3e0b87]
stable/6.6: [2b99b2c4621d13bd4374ef384e8f1fc188d0a5df]

CVE-2024-57977: memcg: fix soft lockup in the OOM process

stable/6.6 was fixed.

Fixed status
stable/6.12: [c3a3741db8c1202aa959c77df3a4c361612d1eb1]
stable/6.13: [46576834291869457d4772bb7df72d7c2bb3d57f]
stable/6.6: [972486d37169fe85035e81b8c5dff21f70df1173]

CVE-2024-58002: media: uvcvideo: Remove dangling pointers

stable/6.6 was fixed.

Fixed status
stable/6.12: [438bda062b2c40ddd7df23b932e29ffe0a448cac]
stable/6.13: [9edc7d25f7e49c33a1ce7a5ffadea2222065516c]
stable/6.6: [4dbaa738c583a0e947803c69e8996e88cf98d971]

CVE-2025-21712: md/md-bitmap: Synchronize bitmap_get_stats() with
bitmap lifetime

stable/6.6 was fixed.

Fixed status
stable/6.12: [237e19519c8ff6949f0ef57c4a0243f5b2b0fa18]
stable/6.13: [4e9316eee3885bfb311b4759513f2ccf37891c09]
stable/6.6: [52848a095b55a302af92f52ca0de5b3112059bb8]

CVE-2025-21721: nilfs2: handle errors that nilfs_prepare_chunk() may return

stable/6.6 was fixed.

Fixed status
stable/6.12: [eddd3176b8c4c83a46ab974574cda7c3dfe09388]
stable/6.13: [481136234dfe96c7f92770829bec6111c7c5f5dd]
stable/6.6: [7891ac3b0a5c56f7148af507306308ab841cdc31]

CVE-2025-21746: Input: synaptics - fix crash when enabling pass-through port

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [3e179d3f1ada963475395d81bfe91daef4d1a24c]
stable/6.13: [87da1ea93ec9f9f0004e5b12e78789bc94e360bf]
stable/6.6: [a2cbcd70133dc0d4d4c95ad4cd5412b935354c7c]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

