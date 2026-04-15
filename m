Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B9FF433CF
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 22:30:22 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7288.1776292218389521908
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 15:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=hJ7t/iTF;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79db5e18ac6so461447b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 15:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776292217; cv=none;
        d=google.com; s=arc-20240605;
        b=bpltZS9IooNHJ+VJ+m/V7trUgWVKMI08vhQYejES7UBmgn08vkci00REhgsUs1xXD7
         m0MEjuTLd3Yn5RP0gAq3i4VbpfkL3rWneJCvzxK+H7QZasangWyjq5yqyayIuR6Qwsnc
         PvOk7QpUH6CX9pB7/Tx8Xze0MyjnGFySZRvse7n5JAsrsFZf3A1LNoWSo25CFOZ7wYZZ
         nNf0UneJA/I21rZj9dOyQYxKd5WJTWKBy6PW6a6kqvvOw61rdD5kcrrCkTEZiZZBK1VO
         xOBc+eW1kFeT4ebYLmVyumEw9RpeoP5PcU83mwuohdm1N+MA6wgzv6pWKGPMLsE4yJmG
         g4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gfh08XEPmhzADkdeFd5TVjjZC9rBYr51Kb7kIewfHrc=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=FxwlI1nwkEB49cZYug/j7E09Uv1t8Ra0t1Zh2yB852syN0n9bq9MQ510EANrIH1fS6
         Hh1Ir4uTzRB+WEkZVzMHAOsybtSv/djCkBYIMw7g6u53hsfWkAJ/X/yMy6KRAzrW1XwL
         Yc/cxpSNKqnEZT4myzY9YVNpBPNk4NkcBRUkJvcLo1X1sC3MnRHRMC6FeQsmFNdI7ZKd
         Vw6XEoVu9hlZbJ5wdYyvzxA9gkelwxKg2pdDF7lX/lJdid/YqLKB8LAH858OLjQRvhkL
         i3KWIQ0RpX5BmNXQbryU230aKhYmk/wz/5He7k1KaBSS4TUfl5mWg6quwnahyKDnw/JV
         ZTfg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1776292217; x=1776897017; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfh08XEPmhzADkdeFd5TVjjZC9rBYr51Kb7kIewfHrc=;
        b=hJ7t/iTFro2tPx9rQE9Zi6/IniyUwIZ754NYV25jqFIHBYD5c799NQfYBCu+ICkYZ3
         R2JhxicFB/S9/PUYrjfyCW+DV80kdMV4D2mRXzeLwZCKoRuO5Vw/+Cy6p1GjwJk2NBcV
         91EuaA5qZ1jzneCOvSOYpE+iafM+P3OmCQIrwFOQgjHWMqciykmpQjYcKRYIXzQURiYZ
         4H4v0oufOESsBg1cR7B8u05hh/5Qi+b2prxuxHIbeTWVfx/kQhBKT8/qOznkQcMXCALu
         9heKqVbgyVsTS9W46NeezUJQaM0tU5HvfEnjewUbOCTbFkf9Y/YIGPX9K7JAUyUqJAOk
         QE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292217; x=1776897017;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfh08XEPmhzADkdeFd5TVjjZC9rBYr51Kb7kIewfHrc=;
        b=tI5XDOegI4Dw7ot3H5QtenDwOZF69uaIhYE83WuyoCuvasUdws5lG5sqtlpETGtSn2
         eROcrUMlqp13RGi31T5pwwWyvJXlP0JJOViNVGn0zHUELG98xG2tsyHNqLGh/VdLhl4Z
         sQ5m29k5qckQ1khPZlx8U5jC5dMVJV3ca9C1dRCNj+XLhXB7YZeUbNfeyvffe0tl+sQy
         WxSgek2O9REsnMhjQBfHrDHLtDE45bN56+EaUp697MGEUzKyawcIda1afduthM07fzdi
         cZICA3w035t2B0Xt4xxj0/ouzgHPbC2rS3u+n+AiKIfciH7eM3vm+DQBrRxajyzuk0i0
         aCaw==
X-Gm-Message-State: AOJu0Yz/Mn/Hdb+mByXaho+wYGVHOek2XowLy/Sm3dQHSvmQxs7wtGMH
	uIp7kTBC559J1N8u9Zy/niPGa+y8jLMpfFv0CTc3IxyYkrEa78XUFUntz/bUQXEzVUUyGXwVVIC
	jMpKFFKrtMceSRYHh5SYhyzhxyfL0vct0LWg6pDS9hKoIXWHJgxbUxPvasQ==
X-Gm-Gg: AeBDieuQdymxPbFAcAmPI9qQcqF778xf5vXd5SulawWeCwfLfGzdvzLcjsASS/oIlO9
	oMKKymCBZV9bl8SJ3QcaOt0LKDimkZY9uzalW3cNC0TWr8ZwLoQ+kGLvagq+XQZZELnJwwR8faO
	Q30rXRLua5ZH7vyisrfaD/PvWvXGp/z76TnYsxHUYP4tceFvW5CUMnivHSYhIMezl4XLUzxDG1d
	xoxJ4aepN/Re0UTUBTsC291nQqIt989L6r1DO61ZCb4QuEnmwqyU0ix+ucDWn0/VUvRNi0Vg9r8
	3lwNm4L7
X-Received: by 2002:a53:e948:0:b0:646:9ddf:5f2 with SMTP id
 956f58d0204a3-652f6481964mr910245d50.31.1776292216898; Wed, 15 Apr 2026
 15:30:16 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Apr 2026 07:29:40 +0900
X-Gm-Features: AQROBzDEo9DNJiFjixxwkYjyY2oWUIPY6-uqi51cNsacgdUaLUc_2Lky-3qgqUw
Message-ID: <CAODzB9rarr+mbQSMmosAOEBzHmF2iG1EG+RBteNqVyNk6PWTqw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 22:30:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22733

Hi!

It's this week's CVE report.

This week reported 16 new CVEs and 12 updated CVEs.

* New CVEs
CVE-2026-31413: bpf: Fix unsound scalar forking in
maybe_fork_scalars() for BPF_OR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31413

Introduced by commit bffacdb ("bpf: Recognize special arithmetic shift
in the verifier") in v7.0-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.19

Fixed status
mainline: [c845894ebd6fb43226b3118d6b017942550910c5]
stable/6.12: [342aa1ee995ef5bbf876096dc3a5e51218d76fa4]
stable/6.18: [58bd87d0e69204dbd739e4387a1edb0c4b1644e7]
stable/6.19: [d13281ae7ea8902b21d99d10a2c8caf0bdec0455]

CVE-2026-31414: netfilter: nf_conntrack_expect: use expect->helper

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31414

According to the .vulnerable file, this bug was introduced by commit
ea781f1 in v2.6.30-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f01794106042ee27e54af6fdf5b319a2fe3df94d]
stable/6.1: [847cb7fe26c5ce5dce0d1a41fac1ea488b7f1781]
stable/6.12: [4bd1b3d839172724b33d8d02c5a4ff6a1c775417]
stable/6.18: [b53294bff19e56ada2f230ceb8b1ffde61cc3817]
stable/6.19: [3dfd3f7712b5a800f2ba632179e9b738076a51f0]
stable/6.6: [e7ccaa0a62a8ff2be5d521299ce79390c318d306]

CVE-2026-31415: ipv6: avoid overflows in ip6_datagram_send_ctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31415

Introduced by commit 333fad5 ("[IPV6]: Support several new sockopt /
ancillary data in Advanced API (RFC3542).") in v2.6.20.16.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e453375561fc60820e6b9d8ebeb6b3ee177d42e]
stable/6.1: [0bdaf54d3aaddfe8df29371260fa8d4939b4fd6f]
stable/6.12: [63fda74885555e6bd1623b5d811feec998740ba4]
stable/6.18: [9ed81d692758dfb9471d7799b24bfa7a08224c31]
stable/6.19: [872b74900d5daa37067ac676d9001bb929fc6a2a]
stable/6.6: [5e4ee5dbea134e9257f205e31a96040bed71e83f]

CVE-2026-31416: netfilter: nfnetlink_log: account for netlink header size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31416

Introduced by commit 9dfa1df ("netfilter: nf_log: account for size of
NLMSG_DONE attribute") in v3.18-rc3.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d52a4a0520a6696bdde51caa11f2d6821cd0c01]
stable/6.1: [761b45c661af48da6a065868d59ab1e1f64fd9b6]
stable/6.12: [6b419700e459fbf707ca1543b7c1b57a60fedb73]
stable/6.18: [88a8f56e6276f616baad4274c6b8e4683e26e520]
stable/6.19: [f08ffa3e1c8e36b6131f69c5eb23700c28cbd262]
stable/6.6: [607245c4dbb86d9a10dd8388da0fb82170a99b61]

CVE-2026-31417: net/x25: Fix overflow when accumulating packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31417

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1822cb524e89b4cd2cf0b82e484a2335496a6d9]
stable/6.1: [6e568835ea54a3e1d08e310e34f95d434e739477]
stable/6.12: [4e2d1bcef78d21247fe8fef13bc7ed95885df2b5]
stable/6.18: [8c92969c197b91c134be27dc3afb64ab468853a9]
stable/6.19: [f953f11ccf4afe6feb635c08145f4240d9a6b544]
stable/6.6: [1734bd85c5e0a7a801295b729efb56b009cb8fc3]

CVE-2026-31418: netfilter: ipset: drop logically empty buckets in mtype_del

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31418

Introduced by commit 8af1c6f ("netfilter: ipset: Fix forceadd
evaluation path") in v5.6-rc4.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9862ef9ab0a116c6dca98842aab7de13a252ae02]
stable/6.1: [ad92ee87462f9a3061361d392e9dbfe2e5c1c9fb]
stable/6.12: [b7eef00f08b92b0b9efe8ae0df6d0005e6199323]
stable/6.18: [68ca0eea0af02bed36c5e2c13e9fa1647c31a7d4]
stable/6.19: [ceacaa76f221a6577aba945bb8873c2e640aeba4]
stable/6.6: [6cea34d7ec6829b62f521a37a287f670144a2233]

CVE-2026-31419: net: bonding: fix use-after-free in bond_xmit_broadcast()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31419

Introduced by commit 4e5bd03 ("net: bonding: fix bond_xmit_broadcast
return value error bug") in v5.17-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [2884bf72fb8f03409e423397319205de48adca16]
stable/6.18: [d4cc7e4c80b1634c7b1497574a2fdb18df6c026c]
stable/6.19: [f5b94654a4a19891a8108d66ef166de6c028c6cd]

CVE-2026-31420: bridge: mrp: reject zero test interval to avoid OOM panic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31420

Introduced by commit 20f6a05 ("bridge: mrp: Rework the MRP netlink
interface") in v5.8-rc1.
Introduced by commit 7ab1748 ("bridge: mrp: Extend MRP netlink
interface for configuring MRP interconnect") in v5.9-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa6e24963342de4370e3a3c9af41e38277b74cf3]
stable/6.19: [c9bc352f716d1bebfe43354bce539ec2d0223b30]

CVE-2026-31421: net/sched: cls_fw: fix NULL pointer dereference on shared blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31421

Introduced by commit 1abf272 ("net: sched: tcindex, fw, flow: use
tcf_block_q helper to get struct Qdisc") in v4.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faeea8bbf6e958bf3c00cb08263109661975987c]
stable/6.1: [3d41f9a314afa94b1c7c7c75405920123220e8cd]
stable/6.12: [5cf41031922c154aa5ccda8bcdb0f5e6226582ec]
stable/6.18: [3cb055df9e8625ce699a259d8178d67b37f2b160]
stable/6.19: [96426c348def662b06bfdc65be3002905604927a]
stable/6.6: [18328eff2f97d1a6adcdb6d4a0f42f2f83a31e28]

CVE-2026-31422: net/sched: cls_flow: fix NULL pointer dereference on
shared blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31422

Introduced by commit 1abf272 ("net: sched: tcindex, fw, flow: use
tcf_block_q helper to get struct Qdisc") in v4.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a280dd4bd1d616a01d6ffe0de284c907b555504]
stable/6.1: [cc707a4fd4c3b6ab2722e06bc359aa010e13d408]
stable/6.12: [9bf5fc36a43f7b8b5507c96e74fb81f1e8b4957e]
stable/6.18: [a208c3e1232997e9317887294c20008dfcb75449]
stable/6.19: [415ea0c973c754b9f375225807810eb9045f4293]
stable/6.6: [4a09f72007201c9f667dc47f64517ec23eea65e5]

CVE-2026-31423: net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31423

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4576100b8cd03118267513cafacde164b498b322]
stable/6.1: [25b6821884713a31e2b49fb67b0ebd765b33e0a9]
stable/6.12: [b9e6431cbea8bb1fae8069ed099b4ee100499835]
stable/6.18: [17c1b9807b8a67d676b6dcf749ee932ebaa7f568]
stable/6.19: [d0aefec1b1a1ba2c1d251028dc2c4e5b4ce1fea5]
stable/6.6: [c56f78614e7781aaceca9bd3cb2128bf7d45c3bd]

CVE-2026-31424: netfilter: x_tables: restrict
xt_check_match/xt_check_target extensions for NFPROTO_ARP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31424

Introduced by commit 9291747 ("netfilter: xtables: add device group
match") in v2.6.39-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d5d488f11776738deab9da336038add95d342d1]
stable/6.1: [1cd6313c8644bfebbd813a05da9daa21b09dd68c]
stable/6.12: [e7e1b6bcb389c8708003d40613a59ff2496f6b1f]
stable/6.18: [dc3e27dd7d76e21106b8f9bbdc31f5da74a89014]
stable/6.19: [3e79374b03bf9a2f282f0eb1d0ac3776f7e0f28a]
stable/6.6: [f00ac65c90ea475719e08d629e2e26c8b4e6999b]

CVE-2026-31425: rds: ib: reject FRMR registration before IB connection
is established

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31425

Introduced by commit 1659185 ("RDS: IB: Support Fastreg MR (FRMR)
memory registration mode") in v4.6-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a54ecccfae62c5c85259ae5ea5d9c20009519049]
stable/6.1: [450ec93c0f172374acbf236f1f5f02d53650aa2d]
stable/6.12: [a5bfd14c9a299e6db4add4440430ee5e010b03ad]
stable/6.18: [23e07c340c445f0ebff7757ba15434cb447eb662]
stable/6.19: [47de5b73db3b88f45c107393f26aeba26e9e8fae]
stable/6.6: [6b0a8de67ac0c74e1a7df92b73c862cb36780dfc]

CVE-2026-31426: ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31426

Introduced by commit 03e9a0e ("ACPI: EC: Consolidate event handler
installation code") in v5.7-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6484cadbcaf26b5844b51bd7307a663dda48ef6]
stable/6.1: [022d1727f33ff90b3e1775125264e3023901952e]
stable/6.12: [808c0f156f48d5b8ca34088cbbfba8444e606cbc]
stable/6.18: [d04c007047c88158141d9bd5eac761cdadd3782c]
stable/6.19: [be1a827e15991e874e0d5222d0ea5fdad01960fe]
stable/6.6: [9c886e63b69658959633937e3acb7ca8addf7499]

CVE-2026-31427: netfilter: nf_conntrack_sip: fix use of uninitialized
rtp_addr in process_sdp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31427

Introduced by commit 4ab9e64 ("[NETFILTER]: nf_nat_sip: split up SDP
mangling") in v2.6.26-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a2b724460cb67caed500c508c2ae5cf012e4db4]
stable/6.1: [6e5e3c87b7e6212f1d8414fc2e4d158b01e12025]
stable/6.12: [7edca70751b9bdb5b83eed53cde21eccf3c86147]
stable/6.18: [01f34a80ac23ae90b1909b94b4ed05343a62f646]
stable/6.19: [52fdda318ef2362fc5936385bcb8b3d0328ee629]
stable/6.6: [fe463e76c9b4b0b43b5ee8961b4c500231f1a3f6]

CVE-2026-31428: netfilter: nfnetlink_log: fix uninitialized padding
leak in NFULA_PAYLOAD

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31428

Introduced by commit df6fb86 ("[NETFILTER]: nfnetlink: convert to
generic netlink attribute functions") in v2.6.24-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52025ebaa29f4eb4ed8bf92ce83a68f24ab7fdf7]
stable/6.1: [fc961dd7272b5e4a462999635e44a4770d7f2482]
stable/6.12: [a2f6ff3444b663d6cfa63eadd61327a18592885a]
stable/6.18: [c9f6c51d36482805ac3ffadb9663fe775a13e926]
stable/6.19: [7eff72968161fb8ddb26113344de3b92fb7d7ef5]
stable/6.6: [a8365d1064ded323797c5e28e91070c52f44b76c]



* Updated CVEs
CVE-2024-47736: erofs: handle overlapped pclusters out of crafted
images properly

stable/6.1 was fixed.

Fixed status
stable/6.1: [c1172e65aad4b115392ea4c6e61e56e5b9b69df4]

CVE-2025-37945: net: phy: allow MDIO bus PM ops to start/stop state
machine for phylink-controlled PHY

stable/6.1 was fixed.

Fixed status
stable/6.1: [17eef1e44883845b9567afc893dc41e004c08d65]

CVE-2025-37980: block: fix resource leak in blk_register_queue() error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [6af6d5feebf9423ab3b252831d1f52de31a8b5e0]

CVE-2025-38303: Bluetooth: eir: Fix possible crashes on eir_create_adv_data

stable/6.1 was fixed.

Fixed status
stable/6.1: [2d4588f55cc10fc228f3b46469dbfb3f0a8b13c8]

CVE-2025-38710: gfs2: Validate i_depth for exhash directories

stable/6.6 was fixed.

Fixed status
stable/6.6: [cddea0c721106ea480371412d8de21705eb27376]

CVE-2025-40242: gfs2: Fix unlikely race in gdlm_put_lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [5fdc1474e678eea1700aa266c0b7c2c96f81dd0d]

CVE-2025-71269: btrfs: do not free data reservation in fallback from
inline due to -ENOSPC

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [3edd1f6c7c520536b62b2904807033597554dbac]
stable/6.12: [0a1fbbd780f04d1b6cf48dd327c866ba937de1c4]
stable/6.6: [3a9fd45afadec1fbfec72057b9473d509fa8b68c]

CVE-2026-23360: nvme: fix admin queue leak on controller reset

stable/6.1 was fixed.

Fixed status
stable/6.1: [6e28bab900e40e4d610b04f9f82e01983d8fb356]

CVE-2026-23389: ice: Fix memory leak in ice_set_ringparam()

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [b23282218eca27b710111460b4964c8a456c6c44]
stable/6.18: [63dc317dfcd3faffd082c2bf3080f9ad070273da]

CVE-2026-23401: KVM: x86/mmu: Drop/zap existing present SPTE even when
creating an MMIO SPTE

stable/6.1 was fixed.

Fixed status
stable/6.1: [ed5909992f344a7d3f4024261e9f751d9618a27d]

CVE-2026-23414: tls: Purge async_hold in tls_decrypt_async_wait()

stable/6.1 was fixed.

Fixed status
stable/6.1: [ac435be7c7613eb13a5a8ceb5182e10b50c9ce87]

CVE-2026-31408: Bluetooth: SCO: Fix use-after-free in sco_recv_frame()
due to missing sock_hold

stable/6.1 was fixed.

Fixed status
stable/6.1: [b0a7da0e3f7442545f071499beb36374714bb9de]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

