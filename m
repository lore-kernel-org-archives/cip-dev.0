Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8189FC54E58
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 23:37:37 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.web10.2119.1710977852359026566
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 16:37:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=JRSadfmr;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4d3b82e53so563943eaf.0
        for <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1710977851; x=1711582651; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mst7C3eaR5hRfL83jz3GV0zcd8WrOYXRDKBpG9DSHYU=;
        b=JRSadfmrI9so9CyIqVb9hLn57X0hBmeMHd1TnJ+fXu0UIYybCb/CPxBHvsMH2uGa1S
         DcGyEWm7hPmJJWLjgA0U3Wf9idhY0t7a2KRI8JDDQJXj0QHC5f26qCg9oO0VCrFx4Ni0
         cBJBEruX3+bpBROFtYbnchsN+UzwOYH1STNEGHOKeCBEvcoYUhQjALLA53Es+9eqbS+o
         APG2yiZIPrbJCMU85ZFl0khTpCQa7+mTaeFQUXIntEhWluq2L4DTHmIavajQCarxHPcM
         u/FfASitXSMNVbsB6KMg+5FV5w/X4jYpOJ/fb0gS0Yxo4WrHgO3ZDiH56C3qmB/O1IAf
         0Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977851; x=1711582651;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mst7C3eaR5hRfL83jz3GV0zcd8WrOYXRDKBpG9DSHYU=;
        b=Rj9LgpeIx92EvIRbFCNmPXPUi/OZBciwQnkh5xYCzSheUQOR5UGpmNrEgLjnKpUz7U
         4VgvT4Mo7uId+ia82f6cQepWyscKmzCbds3DLfYFDlaYfmRhYlrcXJaj8Xu/CHSOmZR4
         C4tMPs3MbTQJaGf5txW8lzx3OfNRYnodHUe8znPcLhI7pI6O4xutvJtCgP1bAa74IDb6
         n9EZCjzlnVQoowoUUXXC60mOUM7JFTz7GKLl+G21dJ40iBFn/4kIZ0tcjtit8QYShLCV
         wdwbB8YaoU38WputyrzmgIUbA9n/D2HZqvx/oZM5cDS5RCys+E5SKJZ4BU00EkmoOAvg
         6BYQ==
X-Gm-Message-State: AOJu0YxYXfi/mV4D3kkjALfDnXm/YzNW+jroaSRdRgRV2nirTgGHDrrO
	rj4GngdwYM7dUZqyMDsqf9hB1qg62sSe/23AAP2SF/4WRX8ku48YnyLjnmgOa0kCuMDgfWKIxS6
	iOAkc5JZeCvZ9RJR3yohUyW+RmF8/d3H1bzQrrz6LsTxmtOepVgw=
X-Google-Smtp-Source: AGHT+IGGAA/BuICIEF6/XFsQCiobTk3Hf1v1Xts18wDHrEbc7hRS5xWiuL5bLZRFLV6MS47f90xflbLdeC069dMJdGI=
X-Received: by 2002:a05:6870:36d5:b0:221:9cf3:8ae5 with SMTP id
 u21-20020a05687036d500b002219cf38ae5mr505913oak.24.1710977850617; Wed, 20 Mar
 2024 16:37:30 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Mar 2024 08:36:54 +0900
Message-ID: <CAODzB9pNwYV-A0LECf3nYi08NGYNSF5wF=hp78=s_d=_R5O_nw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 23:37:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15393

Hi!

It's this week's CVE report.

This week reported 49 new CVEs and 11 updated CVEs.

* New CVEs

CVE-2021-47109: neighbour: allow NUD_NOARP entries to be forced GCed

Announce: https://lore.kernel.org/linux-cve-announce/2024031558-CVE-2021-47109-5bde@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5895631 (neighbor: Improve garbage collection) in v5.0-rc1.
Older stable kernels are not affected.
Fixed in v5.13-rc7.

Fixed status
mainline: [7a6b1ab7475fd6478eeaf5c9d1163e7a18125c8f]
stable/5.10: [d17d47da59f726dc4c87caebda3a50333d7e2fd3]
stable/5.4: [d99029e6aab62aef0a0251588b2867e77e83b137]

CVE-2021-47110: x86/kvm: Disable kvmclock on all CPUs on shutdown

Announce: https://lore.kernel.org/linux-cve-announce/2024031506-CVE-2021-47110-2cb8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc2.
It looks like this fix may be applied to older stable kernels.

Fixed status
mainline: [c02027b5742b5aa804ef08a4a9db433295533046]
stable/5.10: [3b0becf8b1ecf642a9edaf4c9628ffc641e490d6]
stable/5.4: [9084fe1b3572664ad276f427dce575f580c9799a]

CVE-2021-47111: xen-netback: take a reference to the RX task thread

Announce: https://lore.kernel.org/linux-cve-announce/2024031506-CVE-2021-47111-4bd0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2ac061c ('xen/netback: cleanup init and deinit
code') in v5.5-rc1.
Older stable kernels are not affected. It's the same as CVE-2021-28691.
Fixed in v5.13-rc6.

Fixed status
mainline: [107866a8eb0b664675a260f1ba0655010fac1e08]
stable/5.10: [6b53db8c4c14b4e7256f058d202908b54a7b85b4]

CVE-2021-47112: x86/kvm: Teardown PV features on boot CPU as well

Announce: https://lore.kernel.org/linux-cve-announce/2024031507-CVE-2021-47112-339c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc2.
Linux 4.19 may be able to apply this fix.
The kvm_cpu_down_prepare() was introduced by commit 9a20ea4 ("x86/kvm:
Convert to hotplug state machine") in 4.9-rc1.
So, Linux 4.4 may not be affected.

Fixed status
mainline: [8b79feffeca28c5459458fe78676b081e87c93a4]
stable/5.10: [38b858da1c58ad46519a257764e059e663b59ff2]
stable/5.4: [7620a669111b52f224d006dea9e1e688e2d62c54]

CVE-2021-47113: btrfs: abort in rename_exchange if we fail to insert
the second ref

Announce: https://lore.kernel.org/linux-cve-announce/2024031507-CVE-2021-47113-bf29@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc5.
This commit log says it's for 4.9+. the btrfs_rename_exchange() is not
found in the Linux 4.4.

Fixed status
mainline: [dc09ef3562726cd520c8338c1640872a60187af5]
stable/5.10: [0df50d47d17401f9f140dfbe752a65e5d72f9932]

CVE-2021-47114: ocfs2: fix data corruption by fallocate

Announce: https://lore.kernel.org/linux-cve-announce/2024031507-CVE-2021-47114-6af8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc5.
All stable kernels have been fixed.

Fixed status
cip/4.4: [624fa7baa3788dc9e57840ba5b94bc22b03cda57]
cip/4.4-rt: [624fa7baa3788dc9e57840ba5b94bc22b03cda57]
cip/4.4-st: [624fa7baa3788dc9e57840ba5b94bc22b03cda57]
mainline: [6bba4471f0cc1296fe3c2089b9e52442d3074b2e]
stable/4.19: [cec4e857ffaa8c447f51cd8ab4e72350077b6770]
stable/4.4: [624fa7baa3788dc9e57840ba5b94bc22b03cda57]
stable/5.10: [c8d5faee46242c3f33b8a71a4d7d52214785bfcc]
stable/5.4: [cc2edb99ea606a45182b5ea38cc8f4e583aa0774]

CVE-2021-47115: nfc: fix NULL ptr dereference in llcp_sock_getname()
after failed connect

Announce: https://lore.kernel.org/linux-cve-announce/2024031508-CVE-2021-47115-9715@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This CVE was rejected.

Introduced by commit d646960 ("NFC: Initial LLCP support") in v3.3-rc1.
Fixed in v5.13-rc5.
All stable kernels have been fixed.

Fixed status
cip/4.4: [eb6875d48590d8e564092e831ff07fa384d7e477]
cip/4.4-rt: [eb6875d48590d8e564092e831ff07fa384d7e477]
cip/4.4-st: [eb6875d48590d8e564092e831ff07fa384d7e477]
mainline: [4ac06a1e013cf5fdd963317ffd3b968560f33bba]
stable/4.19: [93e4ac2a9979a9a4ecc158409ed9c3044dc0ae1f]
stable/4.4: [eb6875d48590d8e564092e831ff07fa384d7e477]
stable/5.10: [48ee0db61c8299022ec88c79ad137f290196cac2]
stable/5.4: [5d4c4b06ed9fb7a69d0b2e2a73fc73226d25ab70]

CVE-2021-47116: ext4: fix memory leak in ext4_mb_init_backend on error path.

Announce: https://lore.kernel.org/linux-cve-announce/2024031508-CVE-2021-47116-8383@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc5.
It seems as if commit f91436d5 ("fs/ext4: fix integer overflow in
s_log_groups_per_flex") in 5.12-rc4 introduced this bug.
The commit f91436d5 was backported to 5.10.

Fixed status
mainline: [a8867f4e3809050571c98de7a2d465aff5e4daf5]
stable/5.10: [2050c6e5b161e5e25ce3c420fef58b24fa388a49]

CVE-2021-47117: ext4: fix bug on in ext4_es_cache_extent as
ext4_split_extent_at failed

Announce: https://lore.kernel.org/linux-cve-announce/2024031508-CVE-2021-47117-5ea7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc5.
All stable kernels have been fixed.

Fixed status
cip/4.4: [e33bafad30d34cfa5e9787cb099cab05e2677fcb]
cip/4.4-rt: [e33bafad30d34cfa5e9787cb099cab05e2677fcb]
cip/4.4-st: [e33bafad30d34cfa5e9787cb099cab05e2677fcb]
mainline: [082cd4ec240b8734a82a89ffb890216ac98fec68]
stable/4.19: [569496aa3776eea1ff0d49d0174ac1b7e861e107]
stable/4.4: [e33bafad30d34cfa5e9787cb099cab05e2677fcb]
stable/5.10: [d3b668b96ad3192c0581a248ae2f596cd054792a]
stable/5.4: [920697b004e49cb026e2e15fe91be065bf0741b7]

CVE-2021-47118: pid: take a reference when initializing `cad_pid`

Announce: https://lore.kernel.org/linux-cve-announce/2024031509-CVE-2021-47118-faf2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9ec5209 ("[PATCH] replace cad_pid by a struct
pid") in v2.6.20.16.
Fixed in v5.13-rc5.
All stable kernels have been fixed.

Fixed status
cip/4.4: [764c2e892d1fe895392aff62fb353fdce43bb529]
cip/4.4-rt: [764c2e892d1fe895392aff62fb353fdce43bb529]
cip/4.4-st: [764c2e892d1fe895392aff62fb353fdce43bb529]
mainline: [0711f0d7050b9e07c44bc159bbc64ac0a1022c7f]
stable/4.19: [d106f05432e60f9f62d456ef017687f5c73cb414]
stable/4.4: [764c2e892d1fe895392aff62fb353fdce43bb529]
stable/5.10: [7178be006d495ffb741c329012da289b62dddfe6]
stable/5.4: [2cd6eedfa6344f5ef5c3dac3aee57a39b5b46dff]

CVE-2021-47119: ext4: fix memory leak in ext4_fill_super

Announce: https://lore.kernel.org/linux-cve-announce/2024031509-CVE-2021-47119-22d3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ce40733 ("ext4: Check for return value from
sb_set_blocksize") in v2.6.25-rc1.
Introduced by commit ac27a0e ("ext4: initial copy of files from ext3")
in v2.6.20.16.
Fixed in v5.13-rc5.

Fixed status
mainline: [afd09b617db3786b6ef3dc43e28fe728cfea84df]
stable/5.10: [01d349a481f0591230300a9171330136f9159bcd]

CVE-2021-47120: HID: magicmouse: fix NULL-deref on disconnect

Announce: https://lore.kernel.org/linux-cve-announce/2024031510-CVE-2021-47120-c3db@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9d7b186 ("HID: magicmouse: add support for Apple
Magic Trackpad 2") in v4.20-rc1.
This commit is not backported to 4.4 and 4.19.
Fixed in v5.13-rc5.

Fixed status
mainline: [4b4f6cecca446abcb686c6e6c451d4f1ec1a7497]
stable/5.10: [b5d013c4c76b276890135b5d32803c4c63924b77]
stable/5.4: [368c5d45a87e1bcc7f1e98e0c255c37b7b12c5d6]

CVE-2021-47121: net: caif: fix memory leak in cfusbl_device_notify

Announce: https://lore.kernel.org/linux-cve-announce/2024031510-CVE-2021-47121-13c1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7ad65bf ("caif: Add support for CAIF over CDC NCM
USB interface") in v3.3-rc1.
Fixed in v5.13-rc5.
All stable kernels have been fixed.

Fixed status
cip/4.4: [cc302e30a504e6b60a9ac8df7988646f46cd0294]
cip/4.4-rt: [cc302e30a504e6b60a9ac8df7988646f46cd0294]
cip/4.4-st: [cc302e30a504e6b60a9ac8df7988646f46cd0294]
mainline: [7f5d86669fa4d485523ddb1d212e0a2d90bd62bb]
stable/4.19: [9ea0ab48e755d8f29fe89eb235fb86176fdb597f]
stable/4.4: [cc302e30a504e6b60a9ac8df7988646f46cd0294]
stable/5.10: [46403c1f80b0d3f937ff9c4f5edc63bb64bc5051]
stable/5.4: [4d94f530cd24c85aede6e72b8923f371b45d6886]

CVE-2021-47122: net: caif: fix memory leak in caif_device_notify

Announce: https://lore.kernel.org/linux-cve-announce/2024031510-CVE-2021-47122-b183@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7c18d22 ("caif: Restructure how link caif link
layer enroll") in v3.3-rc1.
Fixed in v5.13-rc5.
All stable kernels have been fixed.

Fixed status
cip/4.4: [b042e2b2039565eb8f0eb51c14fbe1ef463c8cd8]
cip/4.4-rt: [b042e2b2039565eb8f0eb51c14fbe1ef463c8cd8]
cip/4.4-st: [b042e2b2039565eb8f0eb51c14fbe1ef463c8cd8]
mainline: [b53558a950a89824938e9811eddfc8efcd94e1bb]
stable/4.19: [3be863c11cab725add9fef4237ed4e232c3fc3bb]
stable/4.4: [b042e2b2039565eb8f0eb51c14fbe1ef463c8cd8]
stable/5.10: [af2806345a37313f01b1c9f15e046745b8ee2daa]
stable/5.4: [f52f4fd67264c70cd0b4ba326962ebe12d9cba94]

CVE-2021-47123: io_uring: fix ltout double free on completion race

Announce: https://lore.kernel.org/linux-cve-announce/2024031511-CVE-2021-47123-8318@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 90cd7e4 ("io_uring: track link timeout's master
explicitly") in v5.11-rc1.
Fixed in v5.13-rc2.
All stable kernels have been fixed.

Fixed status
mainline: [447c19f3b5074409c794b350b10306e1da1ef4ba]

CVE-2021-47124: io_uring: fix link timeout refs

Announce: https://lore.kernel.org/linux-cve-announce/2024031511-CVE-2021-47124-42c9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9ae1f8d ("io_uring: fix inconsistent lock state")
in v5.12-rc1.
Fixed in v5.13-rc2. The io_uring feature was introduced in 5.1.

Fixed status
mainline: [a298232ee6b9a1d5d732aa497ff8be0d45b5bd82]
stable/5.10: [6f5d7a45f58d3abe3a936de1441b8d6318f978ff]

CVE-2021-47125: sch_htb: fix refcount leak in htb_parent_to_leaf_offload

Announce: https://lore.kernel.org/linux-cve-announce/2024031511-CVE-2021-47125-9c33@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ae81feb ("sch_htb: fix null pointer dereference
on a null new_q") in v5.12-rc7.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [944d671d5faa0d78980a3da5c0f04960ef1ad893]

CVE-2021-47126: ipv6: Fix KASAN: slab-out-of-bounds Read in
fib6_nh_flush_exceptions

Announce: https://lore.kernel.org/linux-cve-announce/2024031512-CVE-2021-47126-f717@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f88d8ea ("ipv6: Plumb support for nexthop object
in a fib6_info") in v5.3-rc1.
Introduced by commit 706ec91 ("ipv6: Fix nexthop refcnt leak when
creating ipv6 route info") in v5.8.
These commits are not backported to 4.x kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [821bbf79fe46a8b1d18aa456e8ed0a3c208c3754]
stable/5.10: [09870235827451409ff546b073d754a19fd17e2e]
stable/5.4: [7ba7fa78a92dc410b6f93ed73075ab669c3a0b59]

CVE-2021-47127: ice: track AF_XDP ZC enabled queues in bitmap

Announce: https://lore.kernel.org/linux-cve-announce/2024031512-CVE-2021-47127-d0d6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c7a2190 ("ice: Remove xsk_buff_pool from VSI
structure") in v5.12-rc1.
This commit is not backportd to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [e102db780e1c14f10c70dafa7684af22a745b51d]

CVE-2021-47128: bpf, lockdown, audit: Fix buggy SELinux lockdown
permission checks

Announce: https://lore.kernel.org/linux-cve-announce/2024031512-CVE-2021-47128-bef7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 59438b4 ("security,lockdown,selinux: implement
SELinux lockdown") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [ff40e51043af63715ab413995ff46996ecf9583f]
stable/5.10: [ff5039ec75c83d2ed5b781dc7733420ee8c985fc]

CVE-2021-47129: netfilter: nft_ct: skip expectations for confirmed conntrack

Announce: https://lore.kernel.org/linux-cve-announce/2024031513-CVE-2021-47129-7ba5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 857b460 ("netfilter: nft_ct: add ct expectations
support") in v5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [1710eb913bdcda3917f44d383c32de6bdabfc836]
stable/5.10: [5f3429c05e4028a0e241afdad856dd15dec2ffb9]
stable/5.4: [da8d31e80ff425f5a65dab7060d5c4aba749e562]

CVE-2021-47130: nvmet: fix freeing unallocated p2pmem

Announce: https://lore.kernel.org/linux-cve-announce/2024031513-CVE-2021-47130-9f71@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c6e3f13 ("nvmet: add metadata support for block
devices") in v5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [bcd9a0797d73eeff659582f23277e7ab6e5f18f3]
stable/5.10: [c440cd080761b18a52cac20f2a42e5da1e3995af]

CVE-2021-47131: net/tls: Fix use-after-free after the TLS device goes
down and up

Announce: https://lore.kernel.org/linux-cve-announce/2024031513-CVE-2021-47131-eafc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e8f6979 ("net/tls: Add generic NIC offload
infrastructure") in v4.18-rc1.
This commit is not backportd to 4.4.
Fixed in v5.13-rc5.

Fixed status
mainline: [c55dcdd435aa6c6ad6ccac0a4c636d010ee367a4]
stable/5.10: [f1d4184f128dede82a59a841658ed40d4e6d3aa2]

CVE-2021-47132: mptcp: fix sk_forward_memory corruption on retransmission

Announce: https://lore.kernel.org/linux-cve-announce/2024031514-CVE-2021-47132-80b2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 64b9cea ("mptcp: fix spurious retransmissions")
in v5.12-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [b5941f066b4ca331db225a976dae1d6ca8cf0ae3]

CVE-2021-47133: HID: amd_sfh: Fix memory leak in amd_sfh_work

Announce: https://lore.kernel.org/linux-cve-announce/2024031514-CVE-2021-47133-1141@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4b2c53d ("SFH:Transport Driver to add support of
AMD Sensor Fusion Hub (SFH)") in v5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [5ad755fd2b326aa2bc8910b0eb351ee6aece21b1]

CVE-2021-47134: efi/fdt: fix panic when no valid fdt found

Announce: https://lore.kernel.org/linux-cve-announce/2024031515-CVE-2021-47134-3348@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b91540d ("RISC-V: Add EFI runtime services") in v5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [668a84c1bfb2b3fd5a10847825a854d63fac7baa]
stable/5.10: [5148066edbdc89c6fe5bc419c31a5c22e5f83bdb]

CVE-2021-47135: mt76: mt7921: fix possible AOOB issue in
mt7921_mcu_tx_rate_report

Announce: https://lore.kernel.org/linux-cve-announce/2024031515-CVE-2021-47135-2c50@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1c099ab ("mt76: mt7921: add MCU support") in v5.12-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc5.

Fixed status
mainline: [d874e6c06952382897d35bf4094193cd44ae91bd]

CVE-2023-52609: binder: fix race between mmput() and do_exit()

Announce: https://lore.kernel.org/linux-cve-announce/20240318100758.2828621-9-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 457b9a6 ("Staging: android: add binder driver")
in v2.6.29-rc1.
This is android's driver.
Fixed in v6.8-rc1.

Fixed status
mainline: [9a9ab0d963621d9d12199df9817e66982582d5a5]
stable/4.19: [95b1d336b0642198b56836b89908d07b9a0c9608]
stable/5.10: [7e7a0d86542b0ea903006d3f42f33c4f7ead6918]
stable/5.15: [98fee5bee97ad47b527a997d5786410430d1f0e9]
stable/5.4: [252a2a5569eb9f8d16428872cc24dea1ac0bb097]
stable/6.1: [6696f76c32ff67fec26823fc2df46498e70d9bf3]
stable/6.6: [67f16bf2cc1698fd50e01ee8a2becc5a8e6d3a3e]
stable/6.7: [77d210e8db4d61d43b2d16df66b1ec46fad2ee01]

CVE-2023-52610: net/sched: act_ct: fix skb leak and crash on ooo frags

Announce: https://lore.kernel.org/linux-cve-announce/20240318100758.2828621-10-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b57dc7c ("net/sched: Introduce action ct") in v5.3-rc1.
Linux 4.x is not affected.
Fixed in v6.8-rc1.

Fixed status
mainline: [3f14b377d01d8357eba032b4cabc8c1149b458b6]
stable/5.15: [172ba7d46c202e679f3ccb10264c67416aaeb1c4]
stable/6.1: [0b5b831122fc3789fff75be433ba3e4dd7b779d4]
stable/6.6: [73f7da5fd124f2cda9161e2e46114915e6e82e97]
stable/6.7: [f5346df0591d10bc948761ca854b1fae6d2ef441]

CVE-2023-52611: wifi: rtw88: sdio: Honor the host max_req_size in the RX path

Announce: https://lore.kernel.org/linux-cve-announce/20240318100758.2828621-11-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 65371a3 ("wifi: rtw88: sdio: Add HCI
implementation for SDIO based chipsets") in v6.4-rc1.
This patch is not backported to older stable kernels.
Fixed in v6.8-rc1.

Fixed status
mainline: [00384f565a91c08c4bedae167f749b093d10e3fe]
stable/6.6: [5b5ddf21b978ec315cab9d9e7e6ac7374791a8c7]
stable/6.7: [0e9ffff72a0674cd6656314dbd99cdd2123a3030]

CVE-2023-52612: crypto: scomp - fix req->dst buffer overflow

Announce: https://lore.kernel.org/linux-cve-announce/20240318100758.2828621-12-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1ab53a7 ("crypto: acomp - add driver-side scomp
interface") in v4.10-rc1.
Linux 4.4 is not affected.
Fixed in v6.8-rc1.

Fixed status
mainline: [744e1885922a9943458954cfea917b31064b4131]
stable/4.19: [1142d65c5b881590962ad763f94505b6dd67d2fe]
stable/5.10: [4518dc468cdd796757190515a9be7408adc8911e]
stable/5.15: [a5f2f91b3fd7387e5102060809316a0f8f0bc625]
stable/5.4: [e0e3f4a18784182cfe34e20c00eca11e78d53e76]
stable/6.1: [4df0c942d04a67df174195ad8082f6e30e7f71a5]
stable/6.6: [7d9e5bed036a7f9e2062a137e97e3c1e77fb8759]
stable/6.7: [71c6670f9f032ec67d8f4e3f8db4646bf5a62883]

CVE-2023-52613: drivers/thermal/loongson2_thermal: Fix incorrect
PTR_ERR() judgment

Announce: https://lore.kernel.org/linux-cve-announce/20240318100758.2828621-13-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e7e3a7c ("thermal/drivers/loongson-2: Add thermal
management support") in v6.6-rc1.
This patch is not backported to older stable kernels.
Fixed in v6.8-rc1.

Fixed status
mainline: [15ef92e9c41124ee9d88b01208364f3fe1f45f84]
stable/6.6: [70481755ed77400e783200e2d022e5fea16060ce]
stable/6.7: [6010a9fc14eb1feab5cafd84422001134fe8ec58]

CVE-2023-52614: PM / devfreq: Fix buffer overflow in trans_stat_show

Announce: https://lore.kernel.org/linux-cve-announce/20240318101458.2835626-9-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e552bba ("PM / devfreq: Add sysfs node for
representing frequency transition information.") in v3.8-rc1.
Fixed in v6.8-rc1.
Backporting to this fix for the following branches failed.

4.19: https://lore.kernel.org/stable/2024012637-creation-woven-808c@gregkh/
5.4: https://lore.kernel.org/stable/2024012635-corner-boondocks-1f40@gregkh/
5.10: https://lore.kernel.org/stable/2024012634-unbounded-bullfight-568f@gregkh/
5.15: https://lore.kernel.org/stable/2024012633-cornhusk-gusto-e970@gregkh/

Fixed status
mainline: [08e23d05fa6dc4fc13da0ccf09defdd4bbc92ff4]
stable/5.15: [796d3fad8c35ee9df9027899fb90ceaeb41b958f]
stable/6.1: [8a7729cda2dd276d7a3994638038fb89035b6f2c]
stable/6.6: [a979f56aa4b93579cf0e4265ae04d7e9300fd3e8]
stable/6.7: [eaef4650fa2050147ca25fd7ee43bc0082e03c87]

CVE-2023-52615: hwrng: core - Fix page fault dead lock on mmap-ed hwrng

Announce: https://lore.kernel.org/linux-cve-announce/20240318101458.2835626-10-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9996508 ("hwrng: core - Replace u32 in driver API
with byte array") in v2.6.33-rc1.
All stable kernels are fixed.
Fixed in v6.8-rc1.

Fixed status
cip/4.4: [02eaf55d73263373c47207ecd2a3fd85478fb8a6]
cip/4.4-rt: [02eaf55d73263373c47207ecd2a3fd85478fb8a6]
cip/4.4-st: [02eaf55d73263373c47207ecd2a3fd85478fb8a6]
mainline: [78aafb3884f6bc6636efcc1760c891c8500b9922]
stable/4.19: [eafd83b92f6c044007a3591cbd476bcf90455990]
stable/5.10: [c6a8111aacbfe7a8a70f46cc0de8eed00561693c]
stable/5.15: [26cc6d7006f922df6cc4389248032d955750b2a0]
stable/5.4: [5030d4c798863ccb266563201b341a099e8cdd48]
stable/6.1: [aa8aa16ed9adf1df05bb339d588cf485a011839e]
stable/6.6: [ecabe8cd456d3bf81e92c53b074732f3140f170d]
stable/6.7: [6822a14271786150e178869f1495cc03e74c5029]

CVE-2023-52616: crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

Announce: https://lore.kernel.org/linux-cve-announce/20240318101458.2835626-11-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d58bb7e ("lib/mpi: Introduce ec implementation to
MPI library") in v5.10-rc1.
Linux 4.x is not affected.
Fixed in v6.8-rc1.

Fixed status
mainline: [ba3c5574203034781ac4231acf117da917efcd2a]
stable/5.10: [0c3687822259a7628c85cd21a3445cbe3c367165]
stable/5.15: [2bb86817b33c9d704e127f92b838035a72c315b6]
stable/6.1: [bb44477d4506e52785693a39f03cdc6a2c5e8598]
stable/6.6: [7ebf812b7019fd2d4d5a7ca45ef4bf3a6f4bda0a]
stable/6.7: [7abdfd45a650c714d5ebab564bb1b988f14d9b49]

CVE-2023-52617: PCI: switchtec: Fix stdev_release() crash after
surprise hot remove

Announce: https://lore.kernel.org/linux-cve-announce/20240318102117.2839904-7-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 doesn't have PCI_SW_SWITCHTEC feature that was introduced by
commit 080b47de ("MicroSemi Switchtec management interface driver") in
4.12-rc1.
The dma_mrpc variable is introduced by commit f7eb7b8a ("switchtec:
Add MRPC DMA mode support") in 5.0-rc1.
So, the MRPC DMA mode is not implemented in Linux 4.19 therefore Linux
4.19 seems not to be affected.

Fixed status
mainline: [df25461119d987b8c81d232cfe4411e91dcabe66]
stable/5.10: [4a5d0528cf19dbf060313dffbe047bc11c90c24c]
stable/5.15: [ff1c7e2fb9e9c3f53715fbe04d3ac47b80be7eb8]
stable/5.4: [d8c293549946ee5078ed0ab77793cec365559355]
stable/6.1: [1d83c85922647758c1f1e4806a4c5c3cf591a20a]
stable/6.6: [0233b836312e39a3c763fb53512b3fa455b473b3]
stable/6.7: [e129c7fa7070fbce57feb0bfc5eaa65eef44b693]

CVE-2023-52618: block/rnbd-srv: Check for unlikely string overflow

Announce: https://lore.kernel.org/linux-cve-announce/20240318102117.2839904-8-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The drivers/block/rnbd/rnbd-srv.c was added by commit 2de6c8de1
("block/rnbd: server: main functionality") in 5.8-rc1.

Fixed status
mainline: [9e4bf6a08d1e127bcc4bd72557f2dfafc6bc7f41]
stable/5.10: [95bc866c11974d3e4a9d922275ea8127ff809cf7]
stable/5.15: [f6abd5e17da33eba15df2bddc93413e76c2b55f7]
stable/6.1: [af7bbdac89739e2e7380387fda598848d3b7010f]
stable/6.6: [5b9ea86e662035a886ccb5c76d56793cba618827]
stable/6.7: [a2c6206f18104fba7f887bf4dbbfe4c41adc4339]

CVE-2023-52619: pstore/ram: Fix crash when setting number of cpus to
an odd number

Announce: https://lore.kernel.org/linux-cve-announce/20240318102117.2839904-9-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
This patch can be applied to Linux 4.4.

Fixed status
mainline: [d49270a04623ce3c0afddbf3e984cb245aa48e9c]
stable/4.19: [8b69c30f4e8b69131d92096cb296dc1f217101e4]
stable/5.10: [a63e48cd835c34c38ef671d344cc029b1ea5bf10]
stable/5.15: [2a37905d47bffec61e95d99f0c1cc5dc6377956c]
stable/5.4: [e9f6ac50890104fdf8194f2865680689239d30fb]
stable/6.1: [75b0f71b26b3ad833c5c0670109c0af6e021e86a]
stable/6.6: [0593cfd321df9001142a9d2c58d4144917dff7ee]
stable/6.7: [cd40e43f870cf21726b22487a95ed223790b3542]

CVE-2024-26631: ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work

Announce: https://lore.kernel.org/linux-cve-announce/20240318100758.2828621-14-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2d9a93b ("mld: convert from timer to delayed
work") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc1.

Fixed status
mainline: [2e7ef287f07c74985f1bf2858bedc62bd9ebf155]
stable/5.15: [62b3387beef11738eb6ce667601a28fa089fa02c]
stable/6.1: [380540bb06bb1d1b12bdc947d1b8f56cda6b5663]
stable/6.6: [3cc283fd16fba72e2cefe3a6f48d7a36b0438900]
stable/6.7: [3bb5849675ae1d592929798a2b37ea450879c855]

CVE-2024-26632: block: Fix iterating over an empty bio with
bio_for_each_folio_all

Announce: https://lore.kernel.org/linux-cve-announce/20240318100758.2828621-15-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 640d193 ("block: Add bio_for_each_folio_all()")
in v5.17-rc1.
This patch is not backported to older stable kernels.
Fixed in v6.8-rc1.

Fixed status
mainline: [7bed6f3d08b7af27b7015da8dc3acf2b9c1f21d7]
stable/6.1: [c6350b5cb78e9024c49eaee6fdb914ad2903a5fe]
stable/6.6: [a6bd8182137a12d22d3f2cee463271bdcb491659]
stable/6.7: [ca3ede3f5893e2d26d4dbdef1eec28a8487fafde]

CVE-2024-26633: ip6_tunnel: fix NEXTHDR_FRAGMENT handling in
ip6_tnl_parse_tlv_enc_lim()

Announce: https://lore.kernel.org/linux-cve-announce/20240318100758.2828621-16-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fbfa743 ("ipv6: fix ip6_tnl_parse_tlv_enc_lim()")
in v4.10-rc6.
All stable kernels are fixed.
Fixed in v6.8-rc1.

Fixed status
cip/4.4: [2a1d5c8380e863dfd2ae61cc34e87aa3e37f3800]
cip/4.4-rt: [2a1d5c8380e863dfd2ae61cc34e87aa3e37f3800]
cip/4.4-st: [2a1d5c8380e863dfd2ae61cc34e87aa3e37f3800]
mainline: [d375b98e0248980681e5e56b712026174d617198]
stable/4.19: [135414f300c5db995e2a2f3bf0f455de9d014aee]
stable/5.10: [da23bd709b46168f7dfc36055801011222b076cd]
stable/5.15: [4329426cf6b8e22b798db2331c7ef1dd2a9c748d]
stable/5.4: [3f15ba3dc14e6ee002ea01b4faddc3d49200377c]
stable/6.1: [62a1fedeb14c7ac0947ef33fadbabd35ed2400a2]
stable/6.6: [687c5d52fe53e602e76826dbd4d7af412747e183]
stable/6.7: [ba8d904c274268b18ef3dc11d3ca7b24a96cb087]

CVE-2024-26634: net: fix removing a namespace with conflicting altnames

Announce: https://lore.kernel.org/linux-cve-announce/20240318101458.2835626-12-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7663d52 ("net: check for altname conflicts when
changing netdev's netns") in v6.6-rc7.
This commit is backported to 6.1. Linux 5.x and 4.x are not affected.
Fixed in v6.8-rc2.

Fixed status
mainline: [d09486a04f5da0a812c26217213b89a3b1acf836]
stable/6.1: [a2232f29bf52c24f827865b3c90829c44b6c695b]
stable/6.6: [e855dded4b70d1975ee7b9fed0c700391e3c8ea6]
stable/6.7: [8072699aa9e67d1727692cfb3c347263bb627fb9]

CVE-2024-26635: llc: Drop support for ETH_P_TR_802_2.

Announce: https://lore.kernel.org/linux-cve-announce/20240318101458.2835626-13-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 211ed86 ("net: delete all instances of special
processing for token ring") in v3.5-rc1.
All stable kernels are fixed.
Fixed in v6.8-rc2.

Fixed status
cip/4.4: [f8193f86f0c661e7aa5b8242c14635c7f215a3f8]
cip/4.4-rt: [f8193f86f0c661e7aa5b8242c14635c7f215a3f8]
cip/4.4-st: [f8193f86f0c661e7aa5b8242c14635c7f215a3f8]
mainline: [e3f9bed9bee261e3347131764e42aeedf1ffea61]
stable/4.19: [165ad1e22779685c3ed3dd349c6c4c632309cc62]
stable/5.10: [9ccdef19cf9497c2803b005369668feb91cacdfd]
stable/5.15: [c0fe2fe7a5a291dfcf6dc64301732c8d3dc6a828]
stable/5.4: [b8e8838f82f332ae80c643dbb1ca4418d0628097]
stable/6.1: [660c3053d992b68fee893a0e9ec9159228cffdc6]
stable/6.6: [f1f34a515fb1e25e85dee94f781e7869ae351fb8]
stable/6.7: [df57fc2f2abf548aa889a36ab0bdcc94a75399dc]

CVE-2024-26636: llc: make llc_ui_sendmsg() more robust against bonding changes

Announce: https://lore.kernel.org/linux-cve-announce/20240318101458.2835626-14-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
All stable kernels are fixed.
Fixed in v6.8-rc2.

Fixed status
cip/4.4: [4ddc8884b6d21e2830feb0fa52501220d53ebcf6]
cip/4.4-rt: [4ddc8884b6d21e2830feb0fa52501220d53ebcf6]
cip/4.4-st: [4ddc8884b6d21e2830feb0fa52501220d53ebcf6]
mainline: [dad555c816a50c6a6a8a86be1f9177673918c647]
stable/4.19: [84e9d10419f6f4f3f3cd8f9aaf44a48719aa4b1b]
stable/5.10: [04f2a74b562f3a7498be0399309669f342793d8c]
stable/5.15: [c22044270da68881074fda81a7d34812726cb249]
stable/5.4: [b643d0defcbacd7fe548bc65c3e4e6f17dc5eb2d]
stable/6.1: [6d53b813ff8b177f86f149c2f744442681f720e4]
stable/6.6: [cafd3ad3fe03ef4d6632747be9ee15dc0029db4b]
stable/6.7: [c451c008f563d56d5e676c9dcafae565fcad84bb]

CVE-2024-26637: wifi: ath11k: rely on mac80211 debugfs handling for vif

Announce: https://lore.kernel.org/linux-cve-announce/20240318101458.2835626-15-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0a3d898 ("wifi: mac80211: add/remove driver
debugfs entries as appropriate") in v6.7.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc2.

Fixed status
mainline: [556857aa1d0855aba02b1c63bc52b91ec63fc2cc]
stable/6.7: [aa74ce30a8a40d19a4256de4ae5322e71344a274]

CVE-2024-26638: nbd: always initialize struct msghdr completely

Announce: https://lore.kernel.org/linux-cve-announce/20240318101458.2835626-16-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f94fd25 ("tcp: pass back data left in socket
after receive") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc1.

Fixed status
mainline: [78fbb92af27d0982634116c7a31065f24d092826]
stable/6.1: [d9c54763e5cdbbd3f81868597fe8aca3c96e6387]
stable/6.6: [1960f2b534da1e6c65fb96f9e98bda773495f406]
stable/6.7: [b0028f333420a65a53a63978522db680b37379dd]

CVE-2024-26639: mm, kmsan: fix infinite recursion due to RCU critical section

Announce: https://lore.kernel.org/linux-cve-announce/20240318102117.2839904-10-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5ec8e8e ("mm/sparsemem: fix race in accessing
memory_section->usage") in 6.8-rc1.
This commit is backported to 5.10, 5.15, 6.1, and 6.6.
Fixed by commit f6564fce256a ("mm, kmsan: fix infinite recursion due
to RCU critical section") in 6.8-rc3.

Fixed status
mainline: [f6564fce256a3944aa1bc76cb3c40e792d97c1eb]
stable/6.1: [dc904345e3771aa01d0b8358b550802fdc6fe00b]
stable/6.6: [6335c0cdb2ea0ea02c999e04d34fd84f69fb27ff]
stable/6.7: [5a33420599fa0288792537e6872fd19cc8607ea6]

CVE-2024-26640: tcp: add sanity checks to rx zerocopy

Announce: https://lore.kernel.org/linux-cve-announce/20240318102117.2839904-11-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 93ab6cc ("tcp: implement mmap() for zero copy
receive") in v4.18-rc1.
Linux 4.4 is not affected.
Fixed in v6.8-rc3.

Fixed status
mainline: [577e4432f3ac810049cb7e6b71f4d96ec7c6e894]
stable/5.10: [f48bf9a83b1666d934247cb58a9887d7b3127b6f]
stable/5.15: [718f446e60316bf606946f7f42367d691d21541e]
stable/6.1: [b383d4ea272fe5795877506dcce5aad1f6330e5e]
stable/6.6: [d15cc0f66884ef2bed28c7ccbb11c102aa3a0760]
stable/6.7: [1b8adcc0e2c584fec778add7777fe28e20781e60]

CVE-2024-26641: ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()

Announce: https://lore.kernel.org/linux-cve-announce/20240318102117.2839904-12-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0d3c703 ("ipv6: Cleanup IPv6 tunnel receive
path") in v4.7-rc1.
Linux 4.4 is not affected.
Fixed in v6.8-rc3.

Fixed status
mainline: [8d975c15c0cd744000ca386247432d57b21f9df0]
stable/5.10: [a9bc32879a08f23cdb80a48c738017e39aea1080]
stable/5.15: [af6b5c50d47ab43e5272ad61935d0ed2e264d3f0]
stable/6.1: [d54e4da98bbfa8c257bdca94c49652d81d18a4d8]
stable/6.6: [350a6640fac4b53564ec20aa3f4a0922cb0ba5e6]
stable/6.7: [c835df3bcc14858ae9b27315dd7de76370b94f3a]

* Updated CVEs

CVE-2023-28746: Register File Data Sampling (RFDS)

stable 6.1, 6.6, 6.7, and 6.8 were fixed.

Fixed status
mainline: [e95df4ec0c0c9791941f112db699fae794b9862a,
4e42765d1be01111df0c0275bbaf1db1acef346e,
  8076fcde016c9c0e0660543e67bff86cb48a7c9c,
2a0180129d726a4b953232175857d442651b55a0]
stable/6.1: [8b5760939db9c49c03b9e19f6c485a8812f48d83,
29476fac750dddeabc3503bf9b13e05b949d7adb,
  d405b9c03f06b1b5e73ebc4f34452687022f7029,
b2e92ab17e440a97c716b701ecd897eebca11ac0]
stable/6.6: [c35ca0968de41952af2ad7d22881e4a7c6e1b145,
ddfd38558acc5b3891fd197372fedb76372da740,
  77018fb9efe50cf24e61275ee09253cf1fbb6854,
4a5b5bfea063745471af6395d22ebaea8242225e]
stable/6.7: [18867a204511d032c2a6ed083461a10905061fac,
13acf9f1df3513ea7a5170399c2a8e297e5fbdc1,
  fe5f4d14cdad934c5c92080cebd5b18189bf4ac9,
328607cf9e1fcbbc3f5521391d601306f72a5890]
stable/6.8: [056c33c67a74aec19668b927d460825f5e9aab42,
7586a7c0ba2f16ee6fe7f1ad95313775717e9f53,
  c8a1b14f43bb89a62c1471ec2931f152b37b3782,
50d33b98b1e23d1cd8743b3cac7a0ae5718b8b00]

CVE-2024-23196: NULL pointer dereference bug was found in sound/hda
device driver

Fixed in 6.5-rc1. The mainline, 5.10, 5.15, 5.4, and 6.1 were fixed.
Vulnerable function snd_hdac_regmap_sync() was introduced by commit
1a462be52 ("ALSA: hda: Manage concurrent reg access more properly") in
5.6-rc1.
This commit is not backported to 4.x so 4.19 and 4.4 are not affected.

Fixed status
mainline: [1f4a08fed450db87fbb5ff5105354158bdbe1a22]
stable/5.10: [9f9eed451176ffcac6b5ba0f6dae1a6b4a1cb0eb]
stable/5.15: [8703b26387e1fa4f8749db98d24c67617b873acb]
stable/5.4: [109f0aaa0b8838a88af9125b79579023539300a7]
stable/6.1: [cdd412b528dee6e0851c4735d6676ec138da13a4]

CVE-2024-22099: NULL pointer dereference bug and buffer overflow
vulnerabilities was found in the bluetooth subsystem

Fixed in 6.8-rc7 in the mainline.
This fix can be applied to all stable kernels.

Fixed status
mainline: [2535b848fa0f42ddff3e5255cf5e742c9b77bb26]

CVE-2024-23307: Integer Overflow bug was found md/raid/raid5 modules

Fixed in the master branch in the mainline.

Fixed status
mainline: [dfd2bf436709b2bccb78c2dda550dde93700efa7]

CVE-2024-24860: NULL pointer dereference bug was found in bluetooth
device driver in {min,max}_key_size_set()

The mainline, 5.10, 5.15, 6.1, 6.6, and 6.7 were fixed.
This bug was introduced by commit 18f8124 ("Bluetooth: Move
{min,max}_key_size debugfs ...") in 5.6-rc1.
This commit is not backported to older stable kernels.

Fixed status
mainline: [da9065caa594d19b26e1a030fd0cc27bd365d685]
stable/5.10: [394c6c0b6d9bdd7d6ebca35ca9cfbabf44c0c257]
stable/5.15: [4c71c01df8ef209e7fe22b58666cd2cf3dbafb44]
stable/6.1: [96860d9ad462db61f4eeb09934235c38eab655c4]
stable/6.6: [f56e715ef1c19c42c6aa6cb9280947dea13aab2e]
stable/6.7: [d1c6a77d6d48215ba723f910eaabdb6e60d21a37]

CVE-2024-24861: Race condition bug was found in media/xc4000 device
driver in xc4000 xc4000_get_frequency()

Fixed in the master branch in the mainline.
This bug was introduced by commit 4c07e32 ("[media] xc4000: Fix
get_frequency()") in 3.17-rc1.

Fixed status
mainline: [36d503ad547d1c75758a6fcdbec2806f1b6aeb41]

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

