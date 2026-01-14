Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EA1D3CC88
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 23:07:08 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23868.1768432019794556939
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 15:07:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=2wWPLEO5;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78fdb90b670so2841437b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1768432019; x=1769036819; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3K+7zeWXaFX/mRJ3adk38/EyompXCZXEAolB93KhBlY=;
        b=2wWPLEO5KiiQZ5oAc5kPX9CKZKFmDYoKVZ8pcvaq1IRvDTBvaAUtN2C2NZSgsislrG
         WQOtMl4yjjmVgO41uYlZSBYulBJWVZSUjhN4I362qWMOvrihfwwsazs0rp1TkCzTZy0B
         SrAWItYdbMBXba70suKLwqy6caUolL/leY7bdHn8pdRt74gvERNYUkMHaKDVwQA+6aIj
         M6dSjRTWFpHVlvoBydp/eJJczN5mv8VL1LuH2o0cwCuCHVQCWCtsEgWAVTbNGSROUJqQ
         6r9+uHu3PM1vtbWdTH/uwaYWLxyrqg6eMd0/yetz5p+k9BHR4lC5nloXFMDCkZ/ItfXV
         ztTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768432019; x=1769036819;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3K+7zeWXaFX/mRJ3adk38/EyompXCZXEAolB93KhBlY=;
        b=ogS44FFQ9rvBPo2/kyNR6RmZCCTcu0FlNy9DhRW4bmctHsk434KzYBMfUg7vxhbXZ4
         thv2Np4ZlRrTauZXwu/SKG1MyAIKptt8z+Zl3tkEan71/BG52IslaGMcEi9t95JUDtQF
         2kCDXlpLOeWSodTs+ghzOk+IqMVHHtHiorNHIlMIDf3UhRb+y0KwIVnU3EwlMKdhGToz
         AJYDIerquCeEnGtdXOupEKRoNUG7zmVoNJ7AXlUx6YTRQoLHRLi4ux3yPBSX8tUvgvgp
         4p+Y3wr/BpZ0VzQ3ex8ch7Yy3XFWC3ACNhz7WuBO31Q0PhRIYDT/KokB/puIGCikSg6C
         G+uA==
X-Gm-Message-State: AOJu0Yzy91UFKJpQexbY+vH0NiuC1nc06awhjkI4tg+lO6b+tbig3Y0I
	n5/Fued87Y7SkJ0bNK83k0a0xR7Rt4Sf0hC6qBUv19Ad7IYaAtJcrnbCTxg2mHlkSFw9nhwXfp/
	e6gmH4nN+ELDNte73moaUDGg0gcJFJJvCmR31LUvTpwons5qw8F1Ohfw=
X-Gm-Gg: AY/fxX5JADLJPvfO4KFYBBfu+SEpBx0k+WiiTAXK+Evigxz8eWRpdR6OuCDLRhuX1zW
	wPyfK3LwPoavkyZ56QBtSkTI9xNflzjxfGaZW7yDgvlDAPrQB1eW1yy27nLGeETG8eB1z+iLgMd
	mbH7orxZmbfIO8RD5TyCPrL5ECyTsLic9Yf9kAbiRRbFz1DpTStjWpFX/UoJjaRHFWmi4c+THxC
	2XCNCuYCN2zaYW47/1iC+vUceXk13nW1pGZG1qazh2FeAv+T69MfvKvLAfKxEE7iAZ2HS2hKXPt
	U0DLxwI=
X-Received: by 2002:a05:690e:134f:b0:646:6a95:9626 with SMTP id
 956f58d0204a3-64903b45e81mr2780394d50.60.1768432016395; Wed, 14 Jan 2026
 15:06:56 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Jan 2026 08:06:19 +0900
X-Gm-Features: AZwV_QglLap5UpO3xQDqYwJ6ePFsWEju81zXxpDkGsQO4D9yMzRkXEI-K_EZ6Gw
Message-ID: <CAODzB9qjp_mMSy2ytaax+3c4nSqGnTEM-squJamK7bVMzyyGgw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 23:07:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21560

Hi!

It's this week's CVE report.

This week reported 139 new CVEs and 83 updated CVEs.

* New CVEs
CVE-2025-62626: Improper handling of insufficient entropy in the AMD
CPUs could allow a
local attacker to influence the values returned by the RDSEED instruction,
potentially resulting in the consumption of insufficiently random values.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-62626

Fixed status
Not fixed yet.

CVE-2025-68767: hfsplus: Verify inode mode when loading from disk

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68767

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [005d4b0d33f6b4a23d382b7930f7a96b95b01f39]
stable/6.1: [001f44982587ad462b3002ee40c75e8df67d597d]
stable/6.12: [edfb2e602b5ba5ca6bf31cbac20b366efb72b156]
stable/6.6: [05ec9af3cc430683c97f76027e1c55ac6fd25c59]

CVE-2025-68768: inet: frags: flush pending skbs in fqdir_pre_exit()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68768

Introduced by commit d5dd887 ("inet: fix various use-after-free in
defrags units") in v5.3-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [006a5035b495dec008805df249f92c22c89c3d2e]

CVE-2025-68769: f2fs: fix return value of f2fs_recover_fsync_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68769

Introduced by commit 6781eab ("f2fs: give -EINVAL for norecovery and
rw mount") in v4.7-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [01fba45deaddcce0d0b01c411435d1acf6feab7b]
stable/6.1: [9bc246018aaa3b46a7710428d0a2196c229f9d49]
stable/6.12: [473550e715654ad7612aa490d583cb7c25fe2ff3]
stable/6.6: [a4c67d96f92eefcfa5596a08f069e77b743c5865]

CVE-2025-68770: bnxt_en: Fix XDP_TX path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68770

Introduced by commit 7f0a168 ("bnxt_en: Add completion ring pointer in
TX and RX ring structures") in v6.8-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0373d5c387f24de749cc22e694a14b3a7c7eb515]
stable/6.12: [4b83902a1e67ff327ab5c6c65021a03e72c081d6]

CVE-2025-68771: ocfs2: fix kernel BUG in ocfs2_find_victim_chain

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68771

According to the .vulnerable file, this bug was introduced by commit
ccd979b in v2.6.20.16.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [039bef30e320827bac8990c9f29d2a68cd8adb5f]
stable/6.1: [b08a33d5f80efe6979a6e8f905c1a898910c21dd]
stable/6.12: [e24aedae71652d4119049f1fbef6532ccbe3966d]
stable/6.6: [96f1b074c98c20f55a3b23d2ab44d9fb0f619869]

CVE-2025-68772: f2fs: fix to avoid updating compression context during writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68772

Introduced by commit 4c8ff70 ("f2fs: support data compression") in v5.6-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10b591e7fb7cdc8c1e53e9c000dc0ef7069aaa76]
stable/6.1: [ad26bfbc085c939b5dca77ff8c14798c06d151c4]
stable/6.12: [0bf1a02494c7eb5bd43445de4c83c8592e02c4bf]
stable/6.6: [bcd0086ee5a2e88c1224ff2ec1e4a43c83efe5a0]

CVE-2025-68773: spi: fsl-cpm: Check length parity before switching to
16 bit mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68773

Introduced by commit fc96ec8 ("spi: fsl-cpm: Use 16 bit mode for large
transfers with even size") in v6.4-rc1.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [1417927df8049a0194933861e9b098669a95c762]
stable/6.1: [837a23a11e0f734f096c7c7b0778d0e625e3dc87]
stable/6.12: [743cebcbd1b2609ec5057ab474979cef73d1b681]
stable/6.6: [3dd6d01384823e1bd8602873153d6fc4337ac4fe]

CVE-2025-68774: hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68774

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [152af114287851583cf7e0abc10129941f19466a]
stable/6.1: [b68dc4134b18a3922cd33439ec614aad4172bc86]
stable/6.12: [457f795e7abd7770de10216d7f9994a3f12a56d6]
stable/6.6: [b9d1c6bb5f19460074ce9862cb80be86b5fb0a50]

CVE-2025-68775: net/handshake: duplicate handshake cancellations leak socket

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68775

Introduced by commit 3b3009e ("net/handshake: Create a NETLINK service
for handling handshake requests") in v6.4-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15564bd67e2975002f2a8e9defee33e321d3183f]
stable/6.12: [e1641177e7fb48a0a5a06658d4aab51da6656659]
stable/6.6: [011ae80c49d9bfa5b4336f8bd387cd25c7593663]

CVE-2025-68776: net/hsr: fix NULL pointer dereference in
prp_get_untagged_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68776

Introduced by commit f266a68 ("net/hsr: Better frame dispatch") in v3.17-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [188e0fa5a679570ea35474575e724d8211423d17]
stable/6.1: [7be6d25f4d974e44918ba3a5d58ebb9d36879087]
stable/6.12: [1742974c24a9c1f1fd2e5edca0cbaccb720b397a]
stable/6.6: [8f289fa12926aae44347ca7d490e216555d8f255]

CVE-2025-68777: Input: ti_am335x_tsc - fix off-by-one error in
wire_order validation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68777

Introduced by commit bb76dc0 ("input: ti_am33x_tsc: Order of TSC
wires, made configurable") in v3.11-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [248d3a73a0167dce15ba100477c3e778c4787178]
stable/6.1: [08c0b561823a7026364efb38ed7f4a3af48ccfcd]
stable/6.12: [84e4d3543168912549271b34261f5e0f94952d6e]
stable/6.6: [bf95ec55805828c4f2b5241fb6b0c12388548570]

CVE-2025-68778: btrfs: don't log conflicting inode if it's a dir moved
in the current transaction

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68778

According to the .vulnerable file, this bug was introduced by commit
44f714d in v4.8-rc2.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [266273eaf4d99475f1ae57f687b3e42bc71ec6f0]
stable/6.1: [d64f3834dffef80f0a9185a037617a54ed7f4bd2]
stable/6.12: [d478f50727c3ee46d0359f0d2ae114f70191816e]
stable/6.6: [7359e1d39c78816ecbdb0cb4e93975794ce53973]

CVE-2025-68779: net/mlx5e: Avoid unregistering PSP twice

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68779

Introduced by commit 89ee2d9 ("net/mlx5e: Support PSP offload
functionality") in v6.18-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35e93736f69963337912594eb3951ab320b77521]

CVE-2025-68780: sched/deadline: only set free_cpus for online runqueues

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68780

According to the .vulnerable file, this bug was introduced by commit
9659e1e in v4.0-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [382748c05e58a9f1935f5a653c352422375566ea]
stable/6.1: [fb36846cbcc936954f2ad2bffdff13d16c0be08a]
stable/6.12: [dbc61834b0412435df21c71410562d933e4eba49]
stable/6.6: [91e448e69aca4bb0ba2e998eb3e555644db7322b]

CVE-2025-68781: usb: phy: fsl-usb: Fix use-after-free in delayed work
during device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68781

Introduced by commit 0807c50 ("USB: add Freescale USB OTG Transceiver
driver") in v3.0-rc1.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41ca62e3e21e48c2903b3b45e232cf4f2ff7434f]
stable/6.1: [4476c73bbbb09b13a962176fca934b32d3954a2e]
stable/6.12: [69f9a0701abc3d1f8225074c56c27e6c16a37222]
stable/6.6: [319f7a85b3c4e34ac2fe083eb146fe129a556317]

CVE-2025-68782: scsi: target: Reset t_task_cdb pointer in error case

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68782

Introduced by commit 9e95fb8 ("scsi: target: Fix NULL pointer
dereference") in v5.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5053eab38a4c4543522d0c320c639c56a8b59908]
stable/6.1: [8727663ded659aad55eef21e3864ebf5a4796a96]
stable/6.12: [0d36db68fdb8a3325386fd9523b67735f944e1f3]
stable/6.6: [0260ad551b0815eb788d47f32899fbcd65d6f128]

CVE-2025-68783: ALSA: usb-mixer: us16x08: validate meter packet indices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68783

Introduced by commit d2bb390 ("ALSA: usb-audio: Tascam US-16x08 DSP
mixer quirk") in v4.11-rc1.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5526c1c6ba1d0913c7dfcbbd6fe1744ea7c55f1e]
stable/6.1: [cde47f4ccad6751ac36b7471572ddf38ee91870c]
stable/6.12: [a8ad320efb663be30b794e3dd3e829301c0d0ed3]
stable/6.6: [2f21a7cbaaa93926f5be15bc095b9c57c35748d9]

CVE-2025-68784: xfs: fix a UAF problem in xattr repair

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68784

Introduced by commit e47dcf1 ("xfs: repair extended attributes") in v6.10-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5990fd756943836978ad184aac980e2b36ab7e01]
stable/6.12: [1e2d3aa19c7962b9474b22893160cb460494c45f]

CVE-2025-68785: net: openvswitch: fix middle attribute validation in
push_nsh() action

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68785

Introduced by commit b2d0f5d ("openvswitch: enable NSH support") in v4.15-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ace7ef87f059d68b5f50837ef3e8a1a4870c36e]
stable/6.1: [1b569db9c2f28b599e40050524aae5f7332bc294]
stable/6.12: [2ecfc4433acdb149eafd7fb22d7fd4adf90b25e9]
stable/6.6: [10ffc558246f2c75619aedda0921906095e46702]

CVE-2025-68786: ksmbd: skip lock-range check on equal size to avoid
size==0 underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68786

According to the .vulnerable file, this bug was introduced by commit
f441584 in v5.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d510ac31626ed157d2182149559430350cf2104]
stable/6.1: [52fcbb92e0d3acfd1448b2a43b6595d540da5295]
stable/6.12: [a6f4cfa3783804336491e0edcb250c25f9b59d33]
stable/6.6: [da29cd197246c85c0473259f1cad897d9d28faea]

CVE-2025-68787: netrom: Fix memory leak in nr_sendmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68787

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [613d12dd794e078be8ff3cf6b62a6b9acf7f4619]
stable/6.1: [73839497bbde5cd4fd02bbd9c8bc2640780ae65d]
stable/6.12: [8d1ccba4b171cd504ecfa47349cb9864fc9d687c]
stable/6.6: [156a0f6341dce634a825db49ca20b48b1ae9bcc1]

CVE-2025-68788: fsnotify: do not generate ACCESS/MODIFY events on
child for special files

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68788

According to the .vulnerable file, this bug was introduced by commit
72acc85 in v2.6.36-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [635bc4def026a24e071436f4f356ea08c0eed6ff]
stable/6.1: [6a7d7d96eeeab7af2bd01afbb3d9878a11a13d91]
stable/6.12: [82f7416bcbd951549e758d15fc1a96a5afc2e900]
stable/6.6: [e0643d46759db8b84c0504a676043e5e341b6c81]

CVE-2025-68789: hwmon: (ibmpex) fix use-after-free in high/low store

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68789

Introduced by commit 57c7c3a ("hwmon: IBM power meter driver") in v2.6.24-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6946c726c3f4c36f0f049e6f97e88c510b15f65d]
stable/6.1: [533ead425f8109b02fecc7e72d612b8898ec347a]
stable/6.12: [68d62e5bebbd118b763e8bb210d5cf2198ef450c]
stable/6.6: [fa37adcf1d564ef58b9dfb01b6c36d35c5294bad]

CVE-2025-68790: net/mlx5: Fix double unregister of HCA_PORTS component

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68790

Introduced by commit 5a977b5 ("net/mlx5: Lag, move devcom registration
to LAG layer") in v6.18-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a107cfe9c99a079e578a4c5eb70038101a3599f]

CVE-2025-68791: fuse: missing copy_finish in fuse-over-io-uring argument copies

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68791

Introduced by commit c090c8a ("fuse: Add io-uring sqe commit and fetch
support") in v6.14-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e0d7f7f4a43ac8868e98c87ecf48805aa8c24dd]

CVE-2025-68792: tpm2-sessions: Fix out of range indexing in name_size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68792

Introduced by commit 1085b82 ("tpm: Add the rest of the session HMAC
API") in v6.10-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e9722e9a7bfe1bbad649937c811076acf86e1fd]

CVE-2025-68793: drm/amdgpu: fix a job->pasid access race in gpu recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68793

Introduced by commit a72002c ("drm/amdgpu: Make use of
drm_wedge_task_info") in v6.17-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77f73253015cbc7893fca1821ac3eae9eb4bc943]

CVE-2025-68794: iomap: adjust read range correctly for
non-block-aligned positions

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68794

According to the .vulnerable file, this bug was introduced by commit
9dc55f1 in v4.19-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7aa6bc3e8766990824f66ca76c19596ce10daf3e]
stable/6.12: [12053695c8ef5410e8cc6c9ed4c0db9cd9c82b3e]
stable/6.6: [82b60ffbb532d919959702768dca04c3c0500ae5]

CVE-2025-68795: ethtool: Avoid overflowing userspace buffer on stats query

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68795

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b07be1ff1cb6c49869910518650e8d0abc7d25f]
stable/6.1: [4afcb985355210e1688560dc47e64b94dad35d71]
stable/6.12: [7bea09f60f2ad5d232e2db8f1c14e850fd3fd416]
stable/6.6: [ca9983bc3a1189bd72f9ae449d925a66b2616326]

CVE-2025-68796: f2fs: fix to avoid updating zero-sized extent in extent cache

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68796

Introduced by commit 6e96194 ("f2fs: support in batch fzero in dnode
page") in v4.7-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c37c79510329cd951a4dedf3f7bf7e2b18dccec]
stable/6.1: [e50b81c50fcbe63f50405bb40f262162ff32af88]
stable/6.12: [4f244c64efe628d277b916f47071adf480eb8646]
stable/6.6: [efe3371001f50a2d6f746b50bdc6f9f26b2089ec]

CVE-2025-68797: char: applicom: fix NULL pointer dereference in ac_ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68797

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82d12088c297fa1cef670e1718b3d24f414c23f7]
stable/6.1: [0b8b353e09888bccee405e0dd6feafb60360f478]
stable/6.12: [74883565c621eec6cd2e35fe6d27454cf2810c23]
stable/6.6: [d285517429a75423789e6408653e57b6fdfc8e54]

CVE-2025-68798: perf/x86/amd: Check event before enable to avoid GPF

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68798

According to the .vulnerable file, this bug was introduced by commit
ada5434 in v5.19-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [866cf36bfee4fba6a492d2dcc5133f857e3446b0]
stable/6.1: [49324a0c40f7e9bae1bd0362d23fc42232e14621]
stable/6.12: [e1028fb38b328084bc683a4efb001c95d3108573]
stable/6.6: [6e41d9ec8d7cc3f01b9ba785e05f0ebef8b3b37f]

CVE-2025-68799: caif: fix integer underflow in cffrml_receive()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68799

Introduced by commit b482cd2 ("net-caif: add CAIF core protocol
stack") in v2.6.35-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a11ff0948b5ad09b71896b7ccc850625f9878d1]
stable/6.1: [785c7be6361630070790f6235b696da156ac71b3]
stable/6.12: [4ec29714aa4e0601ea29d2f02b461fc0ac92c2c3]
stable/6.6: [f818cd472565f8b0c2c409b040e0121c5cf8592c]

CVE-2025-68800: mlxsw: spectrum_mr: Fix use-after-free when updating
multicast route stats

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68800

Introduced by commit f38656d ("mlxsw: spectrum_mr: Protect multicast
route list with a lock") in v5.7-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ac1dacec458f55f871f7153242ed6ab60373b90]
stable/6.1: [37ca08b35a27ce8fd8e74dd3fd2ae21c23b63b73]
stable/6.12: [216afc198484fde110ebeafc017992266f4596ce]
stable/6.6: [5f2831fc593c2b2efbff7dd0dd7441cec76adcd5]

CVE-2025-68801: mlxsw: spectrum_router: Fix neighbour use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68801

Introduced by commit 6cf3c97 ("mlxsw: spectrum_router: Add private
neigh table") in v4.8-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b0e69763ef948fb872a7767df4be665d18f5fd4]
stable/6.1: [c437fbfd4382412598cdda1f8e2881b523668cc2]
stable/6.12: [ed8141b206bdcfd5d0b92c90832eeb77b7a60a0a]
stable/6.6: [4a3c569005f42ab5e5b2ad637132a33bf102cc08]

CVE-2025-68802: drm/xe: Limit num_syncs to prevent oversized allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68802

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e461304009135270e9ccf2d7e2dfe29daec9b60]
stable/6.12: [e281d1fd6903a081ef023c341145ae92258e38d2]

CVE-2025-68803: NFSD: NFSv4 file creation neglects setting ACL

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68803

Introduced by commit c0cbe70 ("NFSD: add posix ACLs to struct
nfsd_attrs") in v6.0-rc1.
Fixed in v6.19-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [913f7cf77bf14c13cfea70e89bcb6d0b22239562]
stable/6.1: [60dbdef2ebc2317266a385e4debdb1bb0e57afe1]
stable/6.12: [bf4e671c651534a307ab2fabba4926116beef8c3]

CVE-2025-68804: platform/chrome: cros_ec_ishtp: Fix UAF after unbinding driver

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68804

Introduced by commit 26a1426 ("platform/chrome: Add ChromeOS EC ISHTP
driver") in v5.3-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [944edca81e7aea15f83cf9a13a6ab67f711e8abd]
stable/6.1: [8dc1f5a85286290dbf04dd5951d020570f49779b]
stable/6.12: [4701493ba37654b3c38b526f6591cf0b02aa172f]
stable/6.6: [393b8f9bedc7806acb9c47cefdbdb223b4b6164b]

CVE-2025-68805: fuse: fix io-uring list corruption for terminated
non-committed requests

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68805

Introduced by commit c090c8a ("fuse: Add io-uring sqe commit and fetch
support") in v6.14-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95c39eef7c2b666026c69ab5b30471da94ea2874]

CVE-2025-68806: ksmbd: fix buffer validation by including null
terminator size in EA length

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68806

According to the .vulnerable file, this bug was introduced by commit
0ba5439 in v6.6-rc1.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [95d7a890e4b03e198836d49d699408fd1867cb55]
stable/6.1: [cae52c592a07e1d3fa3338a5f064a374a5f26750]
stable/6.12: [d26af6d14da43ab92d07bc60437c62901dc522e6]
stable/6.6: [a28a375a5439eb474e9f284509a407efb479c925]

CVE-2025-68807: block: fix race between wbt_enable_default and IO submission

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68807

Introduced by commit 78c2713 ("block: move wbt_enable_default() out of
queue freezing from sched ->exit()") in v6.16-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9869d3a6fed381f3b98404e26e1afc75d680cbf9]

CVE-2025-68808: media: vidtv: initialize local pointers upon transfer
of memory ownership

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68808

Introduced by commit 3be8037 ("media: vidtv: add error checks") in v5.10-rc6.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98aabfe2d79f74613abc2b0b1cef08f97eaf5322]
stable/6.1: [3caa18d35f1dabe85a3dd31bc387f391ac9f9b4e]
stable/6.12: [a69c7fd603bf5ad93177394fbd9711922ee81032]
stable/6.6: [fb9bd6d8d314b748e946ed6555eb4a956ee8c4d8]

CVE-2025-68809: ksmbd: vfs: fix race on m_flags in vfs_cache

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68809

According to the .vulnerable file, this bug was introduced by commit
f441584 in v5.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [991f8a79db99b14c48d20d2052c82d65b9186cad]
stable/6.12: [ccc78781041589ea383e61d5d7a1e9a31b210b93]
stable/6.6: [5adad9727a815c26013b0d41cfee92ffa7d4037c]

CVE-2025-68810: KVM: Disallow toggling KVM_MEM_GUEST_MEMFD on an
existing memslot

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68810

Introduced by commit a7800aa ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
for guest-specific backing memory") in v6.8-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9935df5333aa503a18de5071f53762b65c783c4c]
stable/6.12: [89dbbe6ff323fc34659621a577fe0af913f47386]

CVE-2025-68811: svcrdma: use rc_pageoff for memcpy byte offset

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68811

Introduced by commit 8e12258 ("svcrdma: Move
svc_rdma_read_info::ri_pageno to struct svc_rdma_recv_ctxt") in
v6.8-rc1.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8ee9099f30654917aa68f55d707b5627e1dbf77]
stable/6.12: [e8623e9c451e23d84b870811f42fd872b4089ef6]

CVE-2025-68812: media: iris: Add sanity check for stop streaming

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68812

Introduced by commit 11712ce ("media: iris: implement vb2 streaming
ops") in v6.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad699fa78b59241c9d71a8cafb51525f3dab04d4]

CVE-2025-68813: ipvs: fix ipv4 null-ptr-deref in route error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68813

Introduced by commit ed0de45 ("ipv4: recompile ip options in
ipv4_link_failure") in v5.1-rc6.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [ad891bb3d079a46a821bf2b8867854645191bab0]
stable/6.1: [cdeff10851c37a002d87a035818ebd60fdb74447]
stable/6.12: [25ab24df31f7af843c96a38e0781b9165216e1a8]
stable/6.6: [4729ff0581fbb7ad098b6153b76b6f5aac94618a]

CVE-2025-68814: io_uring: fix filename leak in __io_openat_prep()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68814

Introduced by commit b944559 ("io_uring: openat directly into fixed fd
table") in v5.15-rc1.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b14fad555302a2104948feaff70503b64c80ac01]
stable/6.1: [8f44c4a550570cd5903625133f938c6b51310c9b]
stable/6.12: [e232269d511566b1f80872256a48593acc1becf4]
stable/6.6: [18b99fa603d0df5e1c898699c17d3b92ddc80746]

CVE-2025-68815: net/sched: ets: Remove drr class from the active list
if it changes to strict

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68815

Introduced by commit cd9b50a ("net/sched: ets: fix crash when flipping
from 'strict' to 'quantum'") in v5.14.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b1e125ae425aba9b45252e933ca8df52a843ec70]
stable/6.1: [8067db5c95aab9461d23117679338cd8869831fa]
stable/6.12: [cca2ed931b734fe48139bc6f020e47367346630f]
stable/6.6: [2f125ebe47d6369e562f3cbd9b6227cff51eaf34]

CVE-2025-68816: net/mlx5: fw_tracer, Validate format string parameters

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68816

Introduced by commit 70dd6fd ("net/mlx5: FW tracer, parse traces and
kernel tracing support") in v4.19-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b35966042d20b14e2d83330049f77deec5229749]
stable/6.1: [38ac688b52ef26a88f8bc4fe26d24fdd0ff91e5d]
stable/6.12: [45bd283b1d69e2c97cddcb9956f0e0261fc4efd7]
stable/6.6: [8ac688c0e430dab19f6a9b70df94b1f635612c1a]

CVE-2025-68817: ksmbd: fix use-after-free in ksmbd_tree_connect_put
under concurrency

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68817

According to the .vulnerable file, this bug was introduced by commit
33b235a in v6.6-rc5.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [b39a1833cc4a2755b02603eec3a71a85e9dff926]
stable/6.1: [d092de8a26c952379ded8e6b0bda31d89befac1a]
stable/6.12: [21a3d01fc6db5129f81edb0ab7cb94fd758bcbea]
stable/6.6: [d64977495e44855f2b28d8ce56107c963a7a50e4]

CVE-2025-68818: scsi: Revert "scsi: qla2xxx: Perform lockless command
completion in abort path"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68818

According to the .vulnerable file, this bug was introduced by commit
0367076 in v6.3-rc4.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [b57fbc88715b6d18f379463f48a15b560b087ffe]
stable/6.1: [c5c37a821bd1708f26a9522b4a6f47b9f7a20003]
stable/6.12: [b10ebbfd59a535c8d22f4ede6e8389622ce98dc0]
stable/6.6: [e9e601b7df58ba0c667baf30263331df2c02ffe1]

CVE-2025-68819: media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100_i2c_msg()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68819

Introduced by commit 60688d5 ("V4L/DVB (8735): dtv5100: replace dummy
frontend by zl10353") in v2.6.28-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b91e6aafe8d356086cc621bc03e35ba2299e4788]
stable/6.1: [61f214a878e96e2a8750bf96a98f78c658dba60c]
stable/6.12: [fe3e129ab49806aaaa3f22067ebc75c2dfbe4658]
stable/6.6: [4a54d8fcb093761e4c56eb211cf4e39bf8401fa1]

CVE-2025-68820: ext4: xattr: fix null pointer deref in ext4_raw_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68820

Introduced by commit c8e008b ("ext4: ignore xattrs past end") in v6.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [b97cb7d6a051aa6ebd57906df0e26e9e36c26d14]
stable/6.1: [190ad0f22ba49f1101182b80e3af50ca2ddfe72f]
stable/6.12: [5b154e901fda2e98570b8f426a481f5740097dc2]
stable/6.6: [b5d942922182e82724b7152cb998f540132885ec]

CVE-2025-68821: fuse: fix readahead reclaim deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68821

Introduced by commit e26ee4e ("fuse: allocate ff->release_args only if
release is needed") in v6.9-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [bd5603eaae0aabf527bfb3ce1bb07e979ce5bd50]
stable/6.1: [4703bc0e8cd3409acb1476a70cb5b7ff943cf39a]
stable/6.12: [fbba8b00bbe4e4f958a2b0654cc1219a7e6597f6]
stable/6.6: [cf74785c00b8b1c0c4a9dd74bfa9c22d62e2d99f]

CVE-2025-68822: Input: alps - fix use-after-free bugs caused by
dev3_register_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68822

Introduced by commit 04aae28 ("Input: ALPS - do not mix trackstick and
external PS/2 mouse data") in v4.0-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf40644ef8c8a288742fa45580897ed0e0289474]
stable/6.12: [ed8c61b89be0c45f029228b2913d5cf7b5cda1a7]

CVE-2025-68823: ublk: fix deadlock when reading partition table

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68823

Introduced by commit 71f28f3 ("ublk_drv: add io_uring based userspace
block driver") in v6.0-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c258f5c4502c9667bccf5d76fa731ab9c96687c1]

CVE-2025-71064: net: hns3: using the num_tqps in the vf driver to
apply for resources

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71064

Introduced by commit e2cb1de ("net: hns3: Add HNS3 VF HCL(Hardware
Compatibility Layer) Support") in v4.16-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2a16269742e176fccdd0ef9c016a233491a49ad]
stable/6.1: [6cd8a2930df850f4600fe8c57d0662b376520281]
stable/6.12: [429f946a7af3fbf08761d218746cd4afa80a7954]
stable/6.6: [1956d47a03eb625951e9e070db39fe2590e27510]

CVE-2025-71065: f2fs: fix to avoid potential deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71065

Introduced by commit 95fa90c ("f2fs: support recording errors into
superblock") in v6.1-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca8b201f28547e28343a6f00a6e91fa8c09572fe]
stable/6.12: [6c3bab5c6261aa22c561ef56b7365959a90e7d91]
stable/6.6: [8bd6dff8b801abaa362272894bda795bf0cf1307]

CVE-2025-71066: net/sched: ets: Always remove class from active list
before deleting in ets_qdisc_change

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71066

Introduced by commit de6d259 ("net/sched: sch_ets: don't peek at
classes beyond 'nbands'") in v5.16-rc3.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [ce052b9402e461a9aded599f5b47e76bc727f7de]
stable/6.1: [a75d617a4ef08682f5cfaadc01d5141c87e019c9]
stable/6.12: [06bfb66a7c8b45e3fed01351a4b087410ae5ef39]
stable/6.6: [9987cda315c08f63a02423fa2f9a1f6602c861a0]

CVE-2025-71067: ntfs: set dummy blocksize to read boot_block when mounting

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71067

According to the .vulnerable file, this bug was introduced by commit
28861e3 in v5.15-rc6.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1693a7d5a38acf6424235a6070bcf5b186a360d]
stable/6.12: [4fff9a625da958a33191c8553a03283786f9f417]
stable/6.6: [44a38eb4f7876513db5a1bccde74de9bc4389d43]

CVE-2025-71068: svcrdma: bound check rq_pages index in inline path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71068

Introduced by commit d7cc739 ("svcrdma: support multiple Read chunks
per RPC") in v5.11-rc1.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1bea0ce35b6095544ee82bb54156fc62c067e58]
stable/6.12: [5f140b525180c628db8fa6c897f138194a2de417]
stable/6.6: [7ba826aae1d43212f3baa53a2175ad949e21926e]

CVE-2025-71069: f2fs: invalidate dentry cache on failed whiteout creation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71069

Introduced by commit 7e01e7a ("f2fs: support RENAME_WHITEOUT") in v4.2-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d33f89b34aa313f50f9a512d58dd288999f246b0]
stable/6.1: [64587ab4d1f16fc94f70e04fa87b2e3f69f8a7bb]
stable/6.12: [c89845fae250efdd59c1d4ec60e9e1c652cee4b6]
stable/6.6: [3d65e27e57aaa9d66709fda4cbfb62a87c04a3f5]

CVE-2025-71070: ublk: clean up user copy references on ublk server exit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71070

Introduced by commit e63d222 ("ublk: simplify aborting ublk request")
in v6.15-rc3.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [daa24603d9f0808929514ee62ced30052ca7221c]

CVE-2025-71071: iommu/mediatek: fix use-after-free on probe deferral

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71071

Introduced by commit 2659392 ("iommu/mediatek: Add error path for loop
of mm_dts_parse") in v6.2-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [de83d4617f9fe059623e97acf7e1e10d209625b5]
stable/6.1: [896ec55da3b90bdb9fc04fedc17ad8c359b2eee5]
stable/6.12: [1ef70a0b104ae8011811f60bcfaa55ff49385171]
stable/6.6: [5c04217d06a1161aaf36267e9d971ab6f847d5a7]

CVE-2025-71072: shmem: fix recovery on rename failures

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71072

Introduced by commit a2e4595 ("shmem: stable directory offsets") in v6.6-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1b4c6a58304fd490124cc2b454d80edc786665c]
stable/6.12: [4b0fe71fb3965d0db83cdfc2f4fe0b3227d70113]

CVE-2025-71073: Input: lkkbd - disable pending work before freeing device

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71073

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e58c88f0cb2d8ed89de78f6f17409d29cfab6c5c]
stable/6.12: [3a7cd1397c209076c371d53bf39a55c138f62342]

CVE-2025-71074: functionfs: fix the open/removal races

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71074

According to the .vulnerable file, this bug was introduced by commit
ddf8abd in v2.6.35-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5bf5ee266633cb18fff6f98f0b7d59a62819eee]

CVE-2025-71075: scsi: aic94xx: fix use-after-free in device removal path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71075

Introduced by commit 2908d77 ("[SCSI] aic94xx: new driver") in v2.6.20.16.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6ab594672d4cba08540919a4e6be2e202b60007]
stable/6.1: [b3e655e52b98a1d3df41c8e42035711e083099f8]
stable/6.12: [a41dc180b6e1229ae49ca290ae14d82101c148c3]
stable/6.6: [e354793a7ab9bb0934ea699a9d57bcd1b48fc27b]

CVE-2025-71076: drm/xe/oa: Limit num_syncs to prevent oversized allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71076

Introduced by commit c8507a2 ("drm/xe/oa/uapi: Define and parse OA
sync properties") in v6.13-rc1.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [f8dd66bfb4e184c71bd26418a00546ebe7f5c17a]
stable/6.12: [b963636331fb4f3f598d80492e2fa834757198eb]

CVE-2025-71077: tpm: Cap the number of PCR banks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71077

Introduced by commit bcfff83 ("tpm: dynamically allocate the
allocated_banks array") in v5.1-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faf07e611dfa464b201223a7253e9dc5ee0f3c9e]
stable/6.1: [ceb70d31da5671d298bad94ae6c20e4bbb800f96]
stable/6.12: [b69492161c056d36789aee42a87a33c18c8ed5e1]
stable/6.6: [d88481653d74d622d1d0d2c9bad845fc2cc6fd23]

CVE-2025-71078: powerpc/64s/slb: Fix SLB multihit issue during SLB preload

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71078

Introduced by commit 5434ae7 ("powerpc/64s/hash: Add a SLB preload
cache") in v4.20-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00312419f0863964625d6dcda8183f96849412c6]
stable/6.1: [c9f865022a1823d814032a09906e91e4701a35fc]
stable/6.12: [895123c309a34d2cfccf7812b41e17261a3a6f37]
stable/6.6: [b13a3dbfa196af68eae2031f209743735ad416bf]

CVE-2025-71079: net: nfc: fix deadlock between nfc_unregister_device
and rfkill_fop_write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71079

Introduced by commit 3e3b5df ("NFC: reorder the logic in
nfc_{un,}register_device") in v5.16-rc2.
Fixed in v6.19-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [1ab526d97a57e44d26fadcc0e9adeb9c0c0182f5]
stable/6.1: [ee41f4f3ccf8cd6ba3732e867abbec7e6d8d12e5]
stable/6.12: [8fc4632fb508432895430cd02b38086bdd649083]
stable/6.6: [6b93c8ab6f6cda8818983a4ae3fcf84b023037b4]

CVE-2025-71080: ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71080

Introduced by commit d2d6422 ("x86: Allow to enable PREEMPT_RT.") in v6.12-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1adaea51c61b52e24e7ab38f7d3eba023b2d050d]
stable/6.12: [1dc33ad0867325f8d2c6d7b2a6f542d4f3121f66]

CVE-2025-71081: ASoC: stm32: sai: fix OF node leak on probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71081

Introduced by commit 5914d28 ("ASoC: stm32: sai: Add synchronization
support") in v4.15-rc1.
Introduced by commit d4180b4 ("ASoC: stm32: sai: fix set_sync
service") in v5.1-rc5.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23261f0de09427367e99f39f588e31e2856a690e]
stable/6.1: [acda653169e180b1d860dbb6bc5aceb105858394]
stable/6.12: [bae74771fc5d3b2a9cf6f5aa64596083d032c4a3]
stable/6.6: [4054a3597d047f3fe87864ef87f399b5d523e6c0]

CVE-2025-71082: Bluetooth: btusb: revert use of devm_kzalloc in btusb

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71082

Introduced by commit 98921db ("Bluetooth: Use devm_kzalloc in btusb.c
file") in v3.7-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [252714f1e8bdd542025b16321c790458014d6880]
stable/6.1: [cca0e9206e3bcc63cd3e72193e60149165d493cc]
stable/6.12: [1e54c19eaf84ba652c4e376571093e58e144b339]
stable/6.6: [c0ecb3e4451fe94f4315e6d09c4046dfbc42090b]

CVE-2025-71083: drm/ttm: Avoid NULL pointer deref for evicted BOs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71083

Introduced by commit 7d08df5 ("drm/ttm: Add ttm_bo_access") in v6.14-rc1.
Introduced by commit 09ac4fc ("drm/ttm: Implement
vm_operations_struct.access v2") in v4.14-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [491adc6a0f9903c32b05f284df1148de39e8e644]
stable/6.1: [4b9944493c6d92d7b29cfd83aaf3deb842b8da79]
stable/6.12: [5a81095d3e1b521ac7cfe3b14d5f149bace3d6e0]
stable/6.6: [3d004f7341d4898889801ebb2ef61ffca610dd6f]

CVE-2025-71084: RDMA/cm: Fix leaking the multicast GID table reference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71084

Introduced by commit fe454dc ("RDMA/ucma: Fix use-after-free bug in
ucma_create_uevent") in v5.12-rc1.
Fixed in v6.19-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [57f3cb6c84159d12ba343574df2115fb18dd83ca]
stable/6.1: [ab668a58c4a2ccb6d54add7a76f2f955d15d0196]
stable/6.12: [5cb34bb5fd726491b809efbeb5cfd63ae5bf9cf3]
stable/6.6: [c0acdee513239e1d6e1b490f56be0e6837dfd162]

CVE-2025-71085: ipv6: BUG() in pskb_expand_head() as part of
calipso_skbuff_setattr()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71085

Introduced by commit 2917f57 ("calipso: Allow the lsm to label the
skbuff directly.") in v4.8-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58fc7342b529803d3c221101102fe913df7adb83]
stable/6.1: [2bb759062efa188ea5d07242a43e5aa5464bbae1]
stable/6.12: [bf3709738d8a8cc6fa275773170c5c29511a0b24]
stable/6.6: [c53aa6a5086f03f19564096ee084a202a8c738c0]

CVE-2025-71086: net: rose: fix invalid array index in rose_kill_by_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71086

Introduced by commit 64b8bc7 ("net/rose: fix races in
rose_kill_by_device()") in v6.7-rc7.
Fixed in v6.19-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [6595beb40fb0ec47223d3f6058ee40354694c8e4]
stable/6.1: [1418c12cd3bba79dc56b57b61c99efe40f579981]
stable/6.12: [b409ba9e1e63ccf3ab4cc061e33c1f804183543e]
stable/6.6: [9f6185a32496834d6980b168cffcccc2d6b17280]

CVE-2025-71087: iavf: fix off-by-one issues in iavf_config_rss_reg()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71087

Introduced by commit 43a3d9b ("i40evf: Allow PF driver to configure
RSS") in v4.7-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6daa2893f323981c7894c68440823326e93a7d61]
stable/6.1: [d7369dc8dd7cbf5cee3a22610028d847b6f02982]
stable/6.12: [f36de3045d006e6d9be1be495f2ed88d1721e752]
stable/6.6: [18de0e41d69d97fab10b91fecf10ae78a5e43232]

CVE-2025-71088: mptcp: fallback earlier on simult connection

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71088

Introduced by commit 23e89e8 ("tcp: Don't drop SYN+ACK for
simultaneous connect().") [1] in v6.11-rc1.
Introduced by commit 4fd19a3 ("mptcp: fix inconsistent state on
fastopen race") [2] in v6.7-rc7.
Introduced by commit 1e777f3 ("mptcp: add MSG_FASTOPEN sendmsg flag
support") [3] in v6.2-rc1.
Fixed in v6.19-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [71154bbe49423128c1c8577b6576de1ed6836830]
stable/6.1: [b5f46a08269265e2f5e87d855287d6d22de0a32b]
stable/6.12: [79f80a7a47849ef1b3c25a0bedcc448b9cb551c1]
stable/6.6: [c9bf315228287653522894df9d851e9b43db9516]

CVE-2025-71089: iommu: disable SVA when CONFIG_X86 is set

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71089

Introduced by commit 26b25a2 ("iommu: Bind process address spaces to
devices") in v5.2-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72f98ef9a4be30d2a60136dd6faee376f780d06c]
stable/6.12: [c2c3f1a3fd74ef16cf115f0c558616a13a8471b4]
stable/6.6: [240cd7f2812cc25496b12063d11c823618f364e9]

CVE-2025-71090: nfsd: fix nfsd_file reference leak in
nfsd4_add_rdaccess_to_wrdeleg()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71090

Introduced by commit e7a8ebc ("NFSD: Offer write delegation for OPEN
with OPEN4_SHARE_ACCESS_WRITE") in v6.17-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8072e34e1387d03102b788677d491e2bcceef6f5]

CVE-2025-71091: team: fix check for port enabled in
team_queue_override_port_prio_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71091

Introduced by commit 6c31ff3 ("team: remove synchronize_rcu() called
during queue override change") in v3.11-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [932ac51d9953eaf77a1252f79b656d4ca86163c6]
stable/6.1: [53a727a8bfd78c739e130a781192d0f6f8e03d39]
stable/6.12: [107d245f84cb4f55f597d31eda34b42a2b7d6952]
stable/6.6: [6bfb62b6010a16112dcae52f490e5e0e6abe12a3]

CVE-2025-71092: RDMA/bnxt_re: Fix OOB write in bnxt_re_copy_err_stats()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71092

Introduced by commit ef56081 ("RDMA/bnxt_re: RoCE related hardware
counters update") in v6.18-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b68a1cc966bc947d00e4c0df7722d118125aa37]

CVE-2025-71093: e1000: fix OOB in e1000_tbi_should_accept()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71093

Introduced by commit 2037110 ("e1000: move tbi workaround code into
helper function") in v3.18-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c72a5182ed92904d01057f208c390a303f00a0f]
stable/6.1: [ad7a2a45e2417ac54089926b520924f8f0d91aea]
stable/6.12: [26c8bebc2f25288c2bcac7bc0a7662279a0e817c]
stable/6.6: [2c4c0c09f9648ba766d399917d420d03e7b3e1f8]

CVE-2025-71094: net: usb: asix: validate PHY address before use

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71094

Introduced by commit 7e88b11 ("net: usb: asix: refactor
asix_read_phy_addr() and handle errors on return") in v5.14-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1e077a3f76eea0dc671ed6792e7d543946227e8]
stable/6.1: [f5f4f30f3811d37e1aa48667c36add74e5a8d99f]
stable/6.12: [98a12c2547a44a5f03f35c108d2022cc652cbc4d]
stable/6.6: [38722e69ee64dbb020028c93898d25d6f4c0e0b2]

CVE-2025-71095: net: stmmac: fix the crash issue for zero copy XDP_TX action

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71095

Introduced by commit bba2556 ("net: stmmac: Enable RX via AF_XDP
zero-copy") in v5.13-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a48e232210009be50591fdea8ba7c07b0f566a13]
stable/6.1: [3f7823219407f2f18044c2b72366a48810c5c821]
stable/6.12: [45ee0462b88396a0bd1df1991f801c89994ea72b]
stable/6.6: [4d0ceb7677e1c4616afb96abb4518f70b65abb0d]

CVE-2025-71096: RDMA/core: Check for the presence of LS_NLA_TYPE_DGID correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71096

Introduced by commit ae43f82 ("IB/core: Add IP to GID netlink
offload") in v4.7-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7b8e876e0ef0232b8076972c57ce9a7286b47ca]
stable/6.1: [45532638de5da24c201aa2a9b3dd4b054064de7b]
stable/6.12: [acadd4097d25d6bd472bcb3f9f3eba2b5105d1ec]
stable/6.6: [9d85524789c2f17c0e87de8d596bcccc3683a1fc]

CVE-2025-71097: ipv4: Fix reference count leak when using error routes
with nexthop objects

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71097

Introduced by commit 493ced1 ("ipv4: Allow routes to use nexthop
objects") in v5.3-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac782f4e3bfcde145b8a7f8af31d9422d94d172a]
stable/6.1: [30386e090c49e803c0616a7147e43409c32a2b0e]
stable/6.12: [ee4183501ea556dca31f5ffd8690aa9fd25b609f]
stable/6.6: [5979338c83012110ccd45cae6517591770bfe536]

CVE-2025-71098: ip6_gre: make ip6gre_header() robust

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71098

Introduced by commit c12b395 ("gre: Support GRE over IPv6") in v3.7-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db5b4e39c4e63700c68a7e65fc4e1f1375273476]
stable/6.1: [adee129db814474f2f81207bd182bf343832a52e]
stable/6.12: [5fe210533e3459197eabfdbf97327dacbdc04d60]
stable/6.6: [1717357007db150c2d703f13f5695460e960f26c]

CVE-2025-71099: drm/xe/oa: Fix potential UAF in xe_oa_add_config_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71099

Introduced by commit cdf02fe ("drm/xe/oa/uapi: Add/remove OA config
perf ops") in v6.11-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcb171931954c51a1a7250d558f02b8f36570783]
stable/6.12: [c6d30b65b7a44dac52ad49513268adbf19eab4a2]

CVE-2025-71100: wifi: rtlwifi: 8192cu: fix tid out of range in
rtl92cu_tx_fill_desc()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71100

Introduced by commit 8ca4cde ("wifi: rtlwifi: rtl8192cu: Fix TX
aggregation") in v6.9-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd39edb445f07400e748da967a07d5dca5c5f96e]
stable/6.12: [9765d6eb8298b07d499cdf9ef7c237d3540102d6]

CVE-2025-71101: platform/x86: hp-bioscfg: Fix out-of-bounds array
access in ACPI package parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71101

Introduced by commit e6c7b3e ("platform/x86: hp-bioscfg:
string-attributes") in v6.6-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e44c42c830b7ab36e3a3a86321c619f24def5206]
stable/6.12: [db4c26adf7117b1a4431d1197ae7109fee3230ad]
stable/6.6: [cf7ae870560b988247a4bbbe5399edd326632680]

CVE-2025-71102: scs: fix a wrong parameter in __scs_magic

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71102

Introduced by commit 5bbaf9d ("scs: Add support for stack usage
debugging") in v5.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08bd4c46d5e63b78e77f2605283874bbe868ab19]
stable/6.1: [57ba40b001be27786d0570dd292289df748b306b]
stable/6.12: [9ef28943471a16e4f9646bc3e8e2de148e7d8d7b]
stable/6.6: [062774439d442882b44f5eab8c256ad3423ef284]

CVE-2025-71103: drm/msm: adreno: fix deferencing ifpc_reglist when not declared

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71103

Introduced by commit a6a0157 ("drm/msm/a6xx: Enable IFPC on Adreno
X1-85") in v6.18-rc1.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [129049d4fe22c998ae9fd1ec479fbb4ed5338c15]

CVE-2025-71104: KVM: x86: Fix VM hard lockup after prolonged
inactivity with periodic HV timer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71104

Introduced by commit d8f2f49 ("x86/kvm: fix LAPIC timer drift when
guest uses periodic mode") in v4.17-rc7.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18ab3fc8e880791aa9f7c000261320fc812b5465]
stable/6.1: [807dbe8f3862fa7c164155857550ce94b36a11b9]
stable/6.12: [e746e51947053a02af2ea964593dc4887108d379]
stable/6.6: [7b54ccef865e0aa62e4871d4ada2ba4b9dcb8bed]

CVE-2025-71105: f2fs: use global inline_xattr_slab instead of per-sb slab cache

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71105

Introduced by commit a999150 ("f2fs: use kmem_cache pool during inline
xattr lookups") in v5.7-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f27ef42bb0b7c0740c5616ec577ec188b8a1d05]
stable/6.1: [72ce19dfed162da6e430467333b2da70471d08a4]
stable/6.12: [1eb0b130196bcbc56c5c80c83139fa70c0aa82c5]
stable/6.6: [be4c3a3c6c2304a8fcd14095d18d26f0cc4e222a]

CVE-2025-71106: fs: PM: Fix reverse check in filesystems_freeze_callback()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71106

Introduced by commit a3f8f86 ("power: always freeze efivarfs") in v6.18-rc7.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [222047f68e8565c558728f792f6fef152a1d4d51]

CVE-2025-71107: f2fs: ensure node page reads complete before
f2fs_put_super() finishes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71107

Introduced by commit 2087258 ("f2fs: fix to drop all dirty meta/node
pages during umount()") in v6.5-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [297baa4aa263ff8f5b3d246ee16a660d76aa82c4]
stable/6.12: [3b15d5f12935e9e25f9a571e680716bc9ee61025]
stable/6.6: [c3031cf2b61f1508662fc95ef9ad505cb0882a5f]

CVE-2025-71108: usb: typec: ucsi: Handle incorrect num_connectors capability

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71108

Introduced commit is not determined.Fixed in v6.19-rc1.
Affected function was added by c1b0bc2 ("usb: typec: Add support for
UCSI interface") in v4.13-rc1.

Fixed status
mainline: [30cd2cb1abf4c4acdb1ddb468c946f68939819fb]
stable/6.1: [f72f97d0aee4a993a35f2496bca5efd24827235d]
stable/6.12: [3042a57a8e8bce4a3100c3f6f03dc372aab24943]
stable/6.6: [914605b0de8128434eafc9582445306830748b93]

CVE-2025-71109: MIPS: ftrace: Fix memory corruption when kernel is
located beyond 32 bits

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71109

Introduced commit is not determined.Fixed in v6.19-rc1.


Fixed status
mainline: [36dac9a3dda1f2bae343191bc16b910c603cac25]
stable/6.12: [e3e33ac2eb69d595079a1a1e444c2fb98efdd42d]

CVE-2025-71110: mm/slub: reset KASAN tag in defer_free() before
accessing freed memory

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71110

Introduced by commit af92793 ("slab: Introduce kmalloc_nolock() and
kfree_nolock().") in v6.18-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53ca00a19d345197a37a1bf552e8d1e7b091666c]

CVE-2025-71111: hwmon: (w83791d) Convert macros to functions to avoid TOCTOU

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71111

Introduced by commit 9873964 ("[PATCH] HWMON: w83791d: New hardware
monitoring driver for the Winbond W83791D") in v2.6.20.16.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [670d7ef945d3a84683594429aea6ab2cdfa5ceb4]
stable/6.1: [f2b579a0c37c0df19603d719894a942a295f634a]
stable/6.12: [a9fb6e8835a22f5796c1182ed612daed3fd273af]
stable/6.6: [f94800fbc26ccf7c81eb791707b038a57aa39a18]

CVE-2025-71112: net: hns3: add VLAN id validation before using

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71112

Introduced by commit fe4144d ("net: hns3: sync VLAN filter entries
when kill VLAN ID failed") in v5.3-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ef935e65902bfed53980ad2754b06a284ea8ac1]
stable/6.1: [00e56a7706e10b3d00a258d81fcb85a7e96372d6]
stable/6.12: [95cca255a7a5ad782639ff0298c2a486707d1046]
stable/6.6: [b7b4f3bf118f51b67691a55b464f04452e5dc6fc]

CVE-2025-71113: crypto: af_alg - zero initialize memory allocated via
sock_kmalloc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71113

Introduced by commit fe869cd ("crypto: algif_hash - User-space
interface for hash operations") in v2.6.38-rc1.
Introduced by commit 5afdfd2 ("crypto: algif_rng - add random number
generator support") in v4.0-rc1.
Introduced by commit 2d97591 ("crypto: af_alg - consolidation of
duplicate code") in v4.14-rc1.
Introduced by commit 67b164a ("crypto: af_alg - Disallow multiple
in-flight AIO requests") in v6.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [6f6e309328d53a10c0fe1f77dec2db73373179b6]
stable/6.1: [f81244fd6b14fecfa93b66b6bb1d59f96554e550]
stable/6.12: [5a4b65523608974a81edbe386f8a667a3e10c726]
stable/6.6: [84238876e3b3b262cf62d5f4d1338e983fb27010]

CVE-2025-71114: via_wdt: fix critical boot hang due to unnamed
resource allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71114

Introduced commit is not determined.Fixed in v6.19-rc1.
Affected function was added by dc3c56b ("watchdog: new driver for VIA
chipsets") in v3.3-rc1.

Fixed status
mainline: [7aa31ee9ec92915926e74731378c009c9cc04928]
stable/6.1: [47c910965c936724070d2a8094a4c3ed8f452856]
stable/6.12: [f7b6370d0fbee06a867037d675797a606cb62e57]
stable/6.6: [d2c7c90aca7b37f60f16b2bedcfeb16204f2f35d]

CVE-2025-71115: um: init cpu_tasks[] earlier

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71115

Introduced commit is not determined.Fixed in v6.19-rc1.


Fixed status
mainline: [7b5d4416964c07c902163822a30a622111172b01]

CVE-2025-71116: libceph: make decode_pool() more resilient against
corrupted osdmaps

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71116

Introduced commit is not determined.Fixed in v6.19-rc1.


Fixed status
mainline: [8c738512714e8c0aa18f8a10c072d5b01c83db39]
stable/6.1: [c82e39ff67353a5a6cbc07b786b8690bd2c45aaa]
stable/6.12: [5d0d8c292531fe356c4e94dcfdf7d7212aca9957]
stable/6.6: [e927ab132b87ba3f076705fc2684d94b24201ed1]

CVE-2025-71117: block: Remove queue freezing from several sysfs store callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71117

Introduced by commit af28141 ("block: freeze the queue in
queue_attr_store") in v6.11-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [935a20d1bebf6236076785fac3ff81e3931834e9]

CVE-2025-71118: ACPICA: Avoid walking the Namespace if start_node is NULL

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71118

Introduced commit is not determined.Fixed in v6.19-rc1.


Fixed status
mainline: [9d6c58dae8f6590c746ac5d0012ffe14a77539f0]
stable/6.1: [7f9b951ed11842373851dd3c91860778356d62d3]
stable/6.12: [0d8bb08126920fd4b12dbf32d9250757c9064b36]
stable/6.6: [1bc34293dfbd266c29875206849b4f8e8177e6df]

CVE-2025-71119: powerpc/kexec: Enable SMT before waking offline CPUs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71119

Introduced by commit 3825346 ("cpu/SMT: Create
topology_smt_thread_allowed()") in v6.6-rc1.
Fixed in v6.19-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [c2296a1e42418556efbeb5636c4fa6aa6106713a]
stable/6.1: [7cccd82a0e4aad192fd74fc60e61ed9aed5857a3]
stable/6.12: [f0c0a681ffb77b8c5290c88c02d968199663939b]
stable/6.6: [d790ef0c4819424ee0c2f448c0a8154c5ca369d1]

CVE-2025-71120: SUNRPC: svcauth_gss: avoid NULL deref on zero length
gss_token in gss_read_proxy_verf

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71120

Introduced by commit 5866efa ("SUNRPC: Fix svcauth_gss_proxy_init()")
in v5.5-rc1.
Fixed in v6.19-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [d4b69a6186b215d2dc1ebcab965ed88e8d41768d]
stable/6.1: [f9e53f69ac3bc4ef568b08d3542edac02e83fefd]
stable/6.12: [a2c6f25ab98b423f99ccd94874d655b8bcb01a19]
stable/6.6: [7452d53f293379e2c38cfa8ad0694aa46fc4788b]

CVE-2025-71121: parisc: Do not reprogram affinitiy on ASP chip

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71121

Introduced commit is not determined.Fixed in v6.19-rc1.


Fixed status
mainline: [dca7da244349eef4d78527cafc0bf80816b261f5]
stable/6.1: [4d0858bbeea12a50bfb32137f74d4b74917ebadd]
stable/6.12: [60560d13ff368415c96a0c1247bea16d427c0641]
stable/6.6: [e09fd2eb6d4c993ee9eaae556cb51e30ec1042df]

CVE-2025-71122: iommufd/selftest: Check for overflow in
IOMMU_TEST_OP_ADD_RESERVED

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71122

Introduced by commit f4b20bb ("iommufd: Add kernel support for testing
iommufd") in v6.2-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6a973af11135439de32ece3b9cbe3bfc043bea8]
stable/6.12: [e6c122cffcbb2e84d321ec8ba0e38ce8e7c10925]
stable/6.6: [4cc829d61f10c20523fd4085c1546e741a792a97]

CVE-2025-71123: ext4: fix string copying in parse_apply_sb_mount_options()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71123

Introduced by commit 8ecb790 ("ext4: avoid potential buffer over-read
in parse_apply_sb_mount_options()") in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [ee5a977b4e771cc181f39d504426dbd31ed701cc]
stable/6.1: [6e37143560e37869d51b7d9e0ac61fc48895f8a0]
stable/6.12: [db9ee13fab0267eccf6544ee35b16c9522db9aac]
stable/6.6: [902ca2356f1e3ec5355c5808ad5d3f9d0095b0cc]

CVE-2025-71124: drm/msm/a6xx: move preempt_prepare_postamble after error check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71124

Introduced by commit 50117ca ("drm/msm/a6xx: Use posamble to reset
counters on preemption") in v6.13-rc1.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef3b04091fd8bc737dc45312375df8625b8318e2]

CVE-2025-71125: tracing: Do not register unsupported perf events

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71125

Introduced by commit 4b14793 ("tracing: Add support for 'synthetic'
events") in v4.17-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef7f38df890f5dcd2ae62f8dbde191d72f3bebae]
stable/6.1: [f7305697b60d79bc69c0a6e280fc931b4e8862dd]
stable/6.12: [3437c775bf209c674ad66304213b6b3c3b1b3f69]
stable/6.6: [65b1971147ec12f0b1cee0811c859a3d7d9b04ce]

CVE-2025-71126: mptcp: avoid deadlock on fallback while reinjecting

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71126

Introduced by commit f8a1d9b ("mptcp: make fallback action and
fallback decision atomic") in v6.16-rc7.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [ffb8c27b0539dd90262d1021488e7817fae57c42]
stable/6.1: [0107442e82c0f8d6010e07e6030741c59c520d6e]
stable/6.12: [0ca9fb4335e726dab4f23b3bfe87271d8f005f41]
stable/6.6: [252892d5a6a2f163ce18f32716e46fa4da7d4e79]

CVE-2025-71127: wifi: mac80211: Discard Beacon frames to non-broadcast address

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71127

Introduced by commit af2d14b ("mac80211: Beacon protection using the
new BIGTK (STA)") in v5.7-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [193d18f60588e95d62e0f82b6a53893e5f2f19f8]
stable/6.1: [88aab153d1528bc559292a12fb5105ee97528e1f]
stable/6.12: [7b240a8935d554ad36a52c2c37c32039f9afaef2]
stable/6.6: [6e5bff40bb38741e40c33043ba0816fba5f93661]

CVE-2025-71128: erspan: Initialize options_len before referencing options.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71128

Introduced by commit bb5e62f ("net: Add options as a flexible array to
struct ip_tunnel_info") in v6.15-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35ddf66c65eff93fff91406756ba273600bf61a3]

CVE-2025-71129: LoongArch: BPF: Sign extend kfunc call arguments

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71129

Introduced by commit 5dc6155 ("LoongArch: Add BPF JIT support") in v6.1-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f5a238f24d7b75f9efe324d3539ad388f58536e]
stable/6.12: [0d666db731e95890e0eda7ea61bc925fd2be90c6]
stable/6.6: [fd43edf357a3a1f5ed1c4bf450b60001c9091c39]

CVE-2025-71130: drm/i915/gem: Zero-initialize the eb.vma array in
i915_gem_do_execbuffer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71130

Introduced by commit 544460c ("drm/i915: Multi-BB execbuf") in v5.16-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fe2bd195435e71c117983d87f278112c5ab364c]
stable/6.1: [25d69e07770745992387c016613fd7ac8eaf9893]
stable/6.12: [24d55ac8e31d2f8197bfad71ffcb3bae21ed7117]
stable/6.6: [0336188cc85d0eab8463bd1bbd4ded4e9602de8b]

CVE-2025-71131: crypto: seqiv - Do not use req->iv after crypto_aead_encrypt

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71131

Introduced by commit 0a27032 ("[CRYPTO] seqiv: Add Sequence Number IV
Generator") in v2.6.25-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50fdb78b7c0bcc550910ef69c0984e751cac72fa]
stable/6.1: [50f196d2bbaee4ab2494bb1b0d294deba292951a]
stable/6.12: [ccbb96434d88e32358894c879457b33f7508e798]
stable/6.6: [0279978adec6f1296af66b642cce641c6580be46]

CVE-2025-71132: smc91x: fix broken irq-context in PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71132

Introduced by commit 342a932 ("locking/spinlock: Provide RT variant
header: <linux/spinlock_rt.h>") in v5.15-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6402078bd9d1ed46e79465e1faaa42e3458f8a33]
stable/6.1: [9d222141b00156509d67d80c771fbefa92c43ace]
stable/6.12: [36561b86cb2501647662cfaf91286dd6973804a6]
stable/6.6: [ef277ae121b3249c99994652210a326b52d527b0]

CVE-2025-71133: RDMA/irdma: avoid invalid read in irdma_net_event

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71133

Introduced by commit 915cc7a ("RDMA/irdma: Add miscellaneous utility
definitions") in v5.14-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f05611728e9d0ab024832a4f1abb74a5f5d0bb0]
stable/6.1: [305c02e541befe4a44ffde30ed374970f41aeb6c]
stable/6.12: [bf197c7c79ef6458d1ee84dd7db251b51784885f]
stable/6.6: [fc23d05f0b3fb4d80657e7afebae2cae686b31c8]

CVE-2025-71134: mm/page_alloc: change all pageblocks migrate type on coalescing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71134

Introduced by commit e6cf9e1 ("mm: page_alloc: fix up block types when
merging compatible blocks") in v6.10-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7838a4eb8a1d23160bd3f588ea7f2b8f7c00c55b]
stable/6.12: [914769048818021556c940b9163e8056be9507dd]

CVE-2025-71135: md/raid5: fix possible null-pointer dereferences in
raid5_store_group_thread_cnt()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71135

Introduced by commit fa1944b ("md/raid5: Wait sync io to finish before
changing group cnt") in v6.13-rc1.
Fixed in v6.19-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [7ad6ef91d8745d04aff9cce7bdbc6320d8e05fe9]
stable/6.12: [20597b7229aea8b5bc45cd92097640257c7fc33b]

CVE-2025-71136: media: adv7842: Avoid possible out-of-bounds array
accesses in adv7842_cp_log_status()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71136

Introduced by commit a89bcd4 ("[media] adv7842: add new video decoder
driver") in v3.12-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8163419e3e05d71dcfa8fb49c8fdf8d76908fe51]
stable/6.1: [d6a22a4a96e4dfe6897cb3532d2b3016d87706f0]
stable/6.12: [60dde0960e3ead8a9569f6c494d90d0232ac0983]
stable/6.6: [a73881ae085db5702d8b13e2fc9f78d51c723d3f]

CVE-2025-71137: octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71137

Introduced by commit d45d897 ("octeontx2-pf: Add basic ethtool
support") in v5.6-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85f4b0c650d9f9db10bda8d3acfa1af83bf78cf7]
stable/6.1: [658caf3b8aad65f8b8e102670ca4f68c7030f655]
stable/6.12: [aa743b0d98448282b2cb37356db8db2a48524624]
stable/6.6: [b23a2e15589466a027c9baa3fb5813c9f6a6c6dc]

CVE-2025-71138: drm/msm/dpu: Add missing NULL pointer check for
pingpong interface

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71138

Introduced by commit d7d0e73 ("drm/msm/dpu: introduce the
dpu_encoder_phys_* for writeback") in v5.19-rc1.
Fixed in v6.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88733a0b64872357e5ecd82b7488121503cb9cc6]
stable/6.12: [471baae774a30a04cf066907b60eaf3732928cb7]
stable/6.6: [678d1c86566dfbb247ba25482d37fddde6140cc9]

CVE-2025-71139: kernel/kexec: fix IMA when allocation happens in CMA area

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71139

Introduced by commit 07d2490 ("kexec: enable CMA based contiguous
allocation") in v6.17-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3785ae5d334bb71d47a593d54c686a03fb9d136]

CVE-2025-71140: media: mediatek: vcodec: Use spinlock for context list
protection lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71140

Introduced by commit 6467cda ("media: mediatek: vcodec: adding lock to
protect decoder context list") in v6.9-rc4.
Introduced by commit afaaf3a ("media: mediatek: vcodec: adding lock to
protect encoder context list") in v6.9-rc4.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [a5844227e0f030d2af2d85d4aed10c5eca6ca176]
stable/6.12: [b92c19675f632a41af1222027a231bc2b7efa7ed]
stable/6.6: [2c1ea6214827041f548279c9eda341eda0cc8351]

CVE-2025-71141: drm/tilcdc: Fix removal actions in case of failed probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71141

Introduced by commit 3c4baba ("drm: Call drm_atomic_helper_shutdown()
at shutdown/remove time for misc drivers") in v6.7-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [a585c7ef9cabda58088916baedc6573e9a5cd2a7]
stable/6.6: [21e52dc7762908c3d499cfb493d1b8281fc1d3ab]

CVE-2025-71142: cpuset: fix warning when disabling remote partition

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71142

Introduced by commit f62a5d3 ("cgroup/cpuset: Remove
remote_partition_check() & make update_cpumasks_hier() handle remote
partition") in v6.15-rc2.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa7d3a56a20f07978d9f401e13637a6479b13bd0]

CVE-2025-71143: clk: samsung: exynos-clkout: Assign .num before accessing .hws

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71143

Introduced by commit f316cdf ("clk: Annotate struct
clk_hw_onecell_data with __counted_by") in v6.6-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf33f0b7df13685234ccea7be7bfe316b60db4db]
stable/6.12: [eb1f3a6ab3efee2b52361879cdc2dc6b11f499c0]
stable/6.6: [fbf57f5e453dadadb3d29b2d1dbe067e3dc4e236]

CVE-2025-71144: mptcp: ensure context reset on disconnect()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71144

Introduced by commit ae15506 ("mptcp: fix duplicate reset on
fastclose") in v6.18-rc7.
Fixed in v6.19-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [86730ac255b0497a272704de9a1df559f5d6602e]
stable/6.12: [1c7c3a9314d8a7fc0e9a508606466a967c8e774a]
stable/6.6: [5c7c7135468f3fc6379cde9777a2c18bfe92d82f]

* Updated CVEs

CVE-2025-38234: sched/rt: Fix race in push_rt_task

stable/6.12 was fixed.

Fixed status
stable/6.12: [debfbc047196df1f6bfd52f2d028c21dce67f0de]

CVE-2025-39872: hsr: hold rcu and dev lock for hsr_get_port_ndev

stable/6.12 was fixed.

Fixed status
stable/6.12: [9433ba79c2ec3ec7c9a711748701549339c3438c]

CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible
code warnings

stable/6.12 was fixed.

Fixed status
stable/6.12: [d1944bab8e0c1511f0cbf364aa06547735bb0ddb]

CVE-2025-40170: net: use dst_dev_rcu() in sk_setup_caps()

stable/6.12 was fixed.

Fixed status
stable/6.12: [5d1be493d1110c9e720b4c51a6e587bb2fb4ac12]

CVE-2025-40276: drm/panthor: Flush shmem writes before mapping buffers
CPU-uncached

stable/6.12 was fixed.

Fixed status
stable/6.12: [8355eea2a2e9c323021dfdcb95d7767d382123c4]

CVE-2025-40325: md/raid10: wait barrier before returning discard
request with REQ_NOWAIT

stable/6.12 was fixed.

Fixed status
stable/6.12: [31ff67982c5fa39c0093b9d9f429fef91c2494b7]

CVE-2025-68206: netfilter: nft_ct: add seqadj extension for natted connections

stable/6.12 was fixed.

Fixed status
stable/6.12: [4ab2cd906e4e1a19ddbda6eb532851b0e9cda110]

CVE-2025-68345: ALSA: hda: cs35l41: Fix NULL pointer dereference in
cs35l41_hda_read_acpi()

stable/6.1, 2stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e63f9c81ca28b06eeeac3630faddc50717897351]
stable/6.12: [e6ba921b17797ccc545d80e0dbccb5fab91c248c]
stable/6.6: [7a35a505d76a4b6cd426b59ff2d800d0394cc5d3]


CVE-2025-68357: iomap: allocate s_dio_done_wq for async reads as well

stable/6.12 was fixed.

Fixed status
stable/6.12: [51297686e00f4d5d941b0f20f12b2f12879d753c]

CVE-2024-40928: net: ethtool: fix the error condition in
ethtool_get_phy_stats_ethtool()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f9e57e7ca77393b5b7072800370370b02eaad0f8]

CVE-2024-43899: drm/amd/display: Fix null pointer deref in dcn20_resource.c

stable/6.6 was fixed.

Fixed status
stable/6.6: [6940c1d0c84a34d5a2038714c218238101a1db5b]

CVE-2024-46786: fscache: delete fscache_cookie_lru_timer when fscache
exits to avoid UAF

stable/6.1 was fixed.

Fixed status
stable/6.1: [c1fc36d5470335546c45799d94d7bb2cbc09e8b7]

CVE-2024-49968: ext4: filesystems without casefold feature cannot be
mounted with siphash

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [11bd1c279bac701ba91119875796ffff3b98250e]
stable/6.6: [52c4538a92da6f3242d4140c03ddc5ee71b39ba8]

CVE-2024-50081: blk-mq: setup queue ->tag_set before initializing hctx

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [73d964ce4bc8b4de88a7c2e40df494f0d5cd8950]
stable/6.6: [25466e5b4bb11a8415ce8d0be89ab77135f7e444]

CVE-2024-56646: ipv6: avoid possible NULL deref in modify_prefix_route()

stable/6.6 was fixed.

Fixed status
stable/6.6: [90f7d995b861fd77ae4885cc58e26a6a4e5ccdb9]

CVE-2024-57795: RDMA/rxe: Remove the direct link to net_device

stable/6.6 was fixed.

Fixed status
stable/6.6: [32ca3557d968e662957131374a5f81c9c9cdbba8]

CVE-2024-57982: xfrm: state: fix out-of-bounds read during lookup

stable/6.6 was fixed.

Fixed status
stable/6.6: [b86dc510308d7a8955f3f47a4fea4bef887653e4]

CVE-2025-21946: ksmbd: fix out-of-bounds in parse_sec_desc()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f4ee19528664777af8b842f8f001be98345aa973]

CVE-2025-22022: usb: xhci: Apply the link chain quirk on NEC isoc endpoints

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1143f790a6316201dc8f067eba4c94ea97ecb6ca]
stable/6.6: [dbf427663ce272070d3004b5fca63a4a537d781c]

CVE-2025-22090: x86/mm/pat: Fix VM_PAT handling when fork() fails in
copy_page_range()

stable/6.1 was fixed.

Fixed status
stable/6.1: [a6623712ba8449876f0b3de9462831523fb851e4]

CVE-2025-22107: net: dsa: sja1105: fix kasan out-of-bounds warning in
sja1105_table_delete_entry()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b52153da1f42e2f4d6259257a7ba027331671a93]
stable/6.6: [4584486cfcca24b7b586da3377eb3cffd48669ec]

CVE-2025-22111: net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [338a0f3c66aef4ee13052880d02200aae8f2d8a8]
stable/6.12: [4888e1dcc341e9a132ef7b8516234b3c3296de56]
stable/6.6: [d767ce15045df510f55cdd2af5df0eee71f928d0]

CVE-2025-22121: ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

stable/6.6 was fixed.

Fixed status
stable/6.6: [3c591353956ffcace2cc74d09930774afed60619]

CVE-2025-38022: RDMA/core: Fix "KASAN: slab-use-after-free Read in
ib_register_device" problem

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [312dae3499106ec8cb7442ada12be080aa9fbc3b]
stable/6.6: [17d3103325e891e10994e7aa28d12bea04dc2c60]

CVE-2025-38125: net: stmmac: make sure that ptp_rate is not 0 before
configuring EST

stable/6.6 was fixed.

Fixed status
stable/6.6: [b92ec4a848728460f181def33735605f154d438f]

CVE-2025-38129: page_pool: Fix use-after-free in page_pool_recycle_in_ring

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1a8c0b61d4cb55c5440583ec9e7f86a730369e32]
stable/6.6: [4914c0a166540e534a0c1d43affd329d95fb56fd]

CVE-2025-38408: genirq/irq_sim: Initialize work context pointers properly

stable/6.6 was fixed.

Fixed status
stable/6.6: [ec3656a8cb428d763def32bc2fa695f94be23629]

CVE-2025-39871: dmaengine: idxd: Remove improper idxd_free

stable/6.1 was fixed.

Fixed status
stable/6.1: [24414bbcb37e1af95190af36c21ae51d497e1a9e]

CVE-2025-40110: drm/vmwgfx: Fix a null-ptr access in the cursor snooper

stable/6.1 was fixed.

Fixed status
stable/6.1: [af9d88cbf0fce52f465978360542ef679713491f]

CVE-2025-40215: xfrm: delete x->tunnel as we delete x

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [0da961fa46da1b37ef868d9b603bd202136f8f8e]
stable/6.6: [d0e0d1097118461463b76562c7ebaabaa5b90b13]

CVE-2025-40256: xfrm: also call xfrm_state_delete_tunnel at destroy
time for states that were never added

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [64441724387b4ac92f67ef51caaaeffe99c950d1]
stable/6.6: [763e5c351206c1e4d910db4a1159053f6263689c]

CVE-2025-68254: staging: rtl8723bs: fix out-of-bounds read in OnBeacon
ESR IE parsing

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [bb5940193d813449540d8d3a82abc045be41f48a]
stable/6.6: [c173ce97d3f0f0c0fefa39139d6d04ba60b5db22]

CVE-2025-68255: staging: rtl8723bs: fix stack buffer overflow in
OnAssocReq IE parsing

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [d129dc2a5d59b4d9cd2cc0b6eeb04df8461199f0]
stable/6.6: [34620eb602aa432f090b2b784ee5c5070fb16cf9]

CVE-2025-68256: staging: rtl8723bs: fix out-of-bounds read in
rtw_get_ie() parser

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b977eb31802817f4a37da95bf16bfdaa1eeb5fc2]
stable/6.6: [30c558447e90935f0de61be181bbcedf75952e00]

CVE-2025-68257: comedi: check device's attached status in compat ioctls

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [f13895c03620933a58907e3250016f087e39b78c]
stable/6.6: [b975f91de5f8f63cf490f0393775cc795f8b0557]

CVE-2025-68258: comedi: multiq3: sanitize config options in multiq3_attach()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [ad7ed3c9c7b8408e8612697bc43a5441fe386c71]
stable/6.6: [049f14557450351750f929ebfff36d849511e132]

CVE-2025-68259: KVM: SVM: Don't skip unrelated instruction if
INT3/INTO is replaced

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [2e84a018c2895c05abe213eb10db128aa45f6ec6]
stable/6.6: [152289a51107ef45bbfe9b4aeeaa584a503042b5]

CVE-2025-68261: ext4: add i_data_sem protection in
ext4_destroy_inline_data_nolock()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [5b266cf6851ce72b11b067fe02adf5a8687104ad]
stable/6.6: [144c48da33a01d92995aeccd8208eb47d2a8e659]

CVE-2025-68263: ksmbd: ipc: fix use-after-free in ipc_msg_send_request

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [de85fb58f9967ba024bb08e0041613d37b57b4d1]
stable/6.6: [708a620b471a14466f1f52c90bf3f65ebdb31460]

CVE-2025-68264: ext4: refresh inline data size before write operations

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [89c2c41f0974e530b2d032c3695095aa0559adb1]
stable/6.6: [1687a055a555347b002f406676a1aaae4668f242]

CVE-2025-68265: nvme: fix admin request_queue lifetime

stable/6.6 was fixed.

Fixed status
stable/6.6: [a505f0ba36ab24176c300d7ff56aff85c2977e6c]

CVE-2025-68266: bfs: Reconstruct file type when loading from disk

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [8f73336b75bd3457b6f9410f2a0601a238f32238]
stable/6.6: [a9f626396bfe66f49b743601e862767928237cc0]

CVE-2025-68291: mptcp: Initialise rcv_mss before calling
tcp_send_active_reset() in mptcp_do_fastclose().

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [46b8b58f93f1b383c3840fc6e8fab6c3bce9295f]
stable/6.6: [eee39f83246a81d970a9ecb7392b7ab74e660094]

CVE-2025-68325: net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [fcb91be52eb6e92e00b533ebd7c77fecada537e1]
stable/6.6: [d01f0e072dadb02fe10f436b940dd957aff0d7d4]

CVE-2025-68332: comedi: c6xdigio: Fix invalid PNP driver unregistration

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e8110402b0c24d822b0b933d87d50870d59667ef]
stable/6.6: [72b3627b0d3b819de49b29c2c8cb1c64d54536b9]

CVE-2025-68335: comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [935ad4b3c325c24fff2c702da403283025ffc722]
stable/6.6: [88d99ca5adbd01ff088f5fb2ddeba5755e085e52]

CVE-2025-68336: locking/spinlock/debug: Fix data-race in do_raw_write_lock

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [93bd23524d63deb80fb85beb2e43fafeb1043d0f]
stable/6.6: [39d2ef113416f1a4205b03fb0aa2e428d1412c77]

CVE-2025-68337: jbd2: avoid bug_on in jbd2_journal_get_create_access()
when file system corrupted

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3faac6531d4818cd6be45e5bbf32937bbbc795c0]
stable/6.6: [b4f8eabf6d991bd41fabcdf9302c4b3eab590cf4]

CVE-2025-68344: ALSA: wavefront: Fix integer overflow in sample size validation

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4f811071e702fbb74933526e2fbadf8c4ed0c0c4]
stable/6.6: [02b63f3bc29265bd9e83191792d200ed563acacf]

CVE-2025-68346: ALSA: dice: fix buffer overflow in detect_stream_formats()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4a6ab0f6cc9bdfdfecbf257a46ff4275bd965af4]
stable/6.6: [dea3ed2c16f99f46f97b1a090bf80ecdd6972ce0]

CVE-2025-68347: ALSA: firewire-motu: fix buffer overflow in hwdep read
for DSP events

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [16620f0617400746984362c3d6ac547eeae1d35f]
stable/6.6: [ddd32ec66bc4eb6969fe835e4cc1c0706c6348fe]

CVE-2025-68349: NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in
pnfs_mark_layout_stateid_invalid

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [104080582ae0aa6dce6c6d75ff89062efe84673b]
stable/6.6: [f718f9ea6094843b8c059b073af49ad61e9f49bb]

CVE-2025-68354: regulator: core: Protect regulator_supply_alias_list
with regulator_list_mutex

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a63fbc07d1b34a9821ea3b31ff4e6456f9d0aa61]
stable/6.6: [09811a83b214cc15521e0d818e43ae9043e9a28d]

CVE-2025-68362: wifi: rtl818x: rtl8187: Fix potential buffer underflow
in rtl8187_rx_cb()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e2f3ea15e804607e0a4a34a2f6c331c8750b68bc]
stable/6.6: [dc153401fb26c1640a2b279c47b65e1c416af276]

CVE-2025-68363: bpf: Check skb->transport_header is set in bpf_skb_check_mtu

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b3171a5e4622e915e94599a55f4964078bdec27e]
stable/6.6: [97b876fa88322625228792cf7a5fd77531815a80]

CVE-2025-68364: ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_extent()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1ad2f81a099b8df5f72bce0a3e9f531263a846b8]
stable/6.6: [bcb94288d95cfc52f4d7cead260f4db54c8c741a]

CVE-2025-68366: nbd: defer config unlock in nbd_genl_connect

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [ae3e7bc1f4b393ae20e5c85583eb2c6977374716]
stable/6.6: [2e5e0665a594f076ef2b9439447bae8be293d09d]

CVE-2025-68367: macintosh/mac_hid: fix race condition in mac_hid_toggle_emumouse

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [583d36523f56d8e9ddfa0bec20743a6faefc9b74]
stable/6.6: [61abf8c3162d155b4fd0fb251f08557093363a0a]

CVE-2025-68369: ntfs3: init run lock for extend inode

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [433d1f7c628c3cbdd7efce064d6c7acd072cf6c4]
stable/6.6: [907bf69c6b6ce5d038eec7a599d67b45b62624bc]

CVE-2025-68371: scsi: smartpqi: Fix device resources accessed after
device removal

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7dfa5a5516ec3c6b9b6c22ee18f0eb2df3f38ef2]
stable/6.6: [6d2390653d82cad0e1ba2676e536dd99678f6ef1]

CVE-2025-68372: nbd: defer config put in recv_work

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3692884bd6187d89d41eef81e5a9724519fd01c1]
stable/6.6: [1ba2ced2bbdf7e64a30c3e88c70ea8bc208d1509]

CVE-2025-68379: RDMA/rxe: Fix null deref on srq->rq.queue after resize failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [58aca869babd48cb9c3d6ee9e1452c4b9f5266a6]

CVE-2025-68380: wifi: ath11k: fix peer HE MCS assignment

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [92791290e4f6a1de25d35af792ab8918a70737f6]
stable/6.6: [4304bd7a334e981f189b9973056a58f84cc2b482]

CVE-2025-68724: crypto: asymmetric_keys - prevent overflow in
asymmetric_key_generate_id

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [dfc1613961828745165aec6552c3818fa14ab725]
stable/6.6: [5b8ac617c8dab5cad3c4dc8d84d0987808a0f99c]

CVE-2025-68727: ntfs3: Fix uninit buffer allocated by __getname()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [53f4d6cb97096590410f3719f75cdf9fc5120f37]
stable/6.6: [dcb5e3cd96b77d52bb65988e4c914636a6d4fdd9]

CVE-2025-68728: ntfs3: fix uninit memory after failed mi_read in mi_format_new

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [c70b3abfd530c7f574bc25a5f84707e6fdf0def8]
stable/6.6: [8bf729b96303bb862d7c6dc05edcf51274ae04cf]

CVE-2025-68732: gpu: host1x: Fix race in syncpt alloc/free

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4aeaece518fa4436af93d1d8b786200d9656ff4b]
stable/6.6: [6245cce711e2cdb2cc75c0bb8632952e36f8c972]

CVE-2025-68733: smack: fix bug: unprivileged task can create labels

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4a7a7621619a366712fb9cefcb6e69f956c247ce]
stable/6.6: [f8fd5491100f920847a3338d5fba22db19c72773]

CVE-2025-68740: ima: Handle error code returned by ima_filter_rule_match()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [88cd5fbf5869731be8fc6f7cecb4e0d6ab3d8749]
stable/6.6: [cca3e7df3c0f99542033657ba850b9a6d27f8784]

CVE-2025-68741: scsi: qla2xxx: Fix improper freeing of purex item

stable/6.6 was fixed.

Fixed status
stable/6.6: [4bccd506a1f1ab01d1f45b2a3effff6bedc73cf9]

CVE-2025-68742: bpf: Fix invalid prog->stats access when
update_effective_progs fails

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [93d1964773ff513c9bd530f7686d3e48b786fa6b]
stable/6.6: [bf2c990b012100610c0f1ec5c4ea434da2d080c2]

CVE-2025-68744: bpf: Free special fields when update [lru_,]percpu_hash maps

stable/6.6 was fixed.

Fixed status
stable/6.6: [994d6303ed0b84cbc795bb5becf7ed6de40d3f3c]

CVE-2025-68746: spi: tegra210-quad: Fix timeout handling

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [83309dd551cfd60a5a1a98d9cab19f435b44d46d]
stable/6.6: [c934e40246da2c5726d14e94719c514e30840df8]

CVE-2025-68753: ALSA: firewire-motu: add bounds check in put_user loop
for DSP events

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [ea2c921d9de6e32ca50cb817b9d57bb881be70de]
stable/6.6: [6d4f17782ce4facf3197e79707df411ee3d7b30a]

CVE-2025-68755: staging: most: remove broken i2c driver

stable/6.6 was fixed.

Fixed status
stable/6.6: [6cbba922934805f86eece6ba7010b7201962695d]

CVE-2025-68756: block: Use RCU in blk_mq_[un]quiesce_tagset() instead
of set->tag_list_lock

stable/6.6 was fixed.

Fixed status
stable/6.6: [ca8764c0ea1fb825f17f19704af55e9e02c9f768]

CVE-2025-68757: drm/vgem-fence: Fix potential deadlock on release

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1026d1b0bd55e1be7ba0f9e9b1c9f6e02448f25a]
stable/6.6: [9dc3c78d21e16f5af1a9c3d11b4bd5276f891fe0]

CVE-2025-68758: backlight: led-bl: Add devlink to supplier LEDs

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e06df738a9ad8417f1c4c7cd6992cda320e9e7ca]
stable/6.6: [30cbe4b642745a9488a0f0d78be43afe69d7555c]

CVE-2025-68759: wifi: rtl818x: Fix potential memory leaks in
rtl8180_init_rx_ring()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a4fb7cca9837378878e6c94d9e7af019c8fdfcdb]
stable/6.6: [bf8513dfa31ea015c9cf415796dca2113d293840]

CVE-2025-68763: crypto: starfive - Correctly handle return of sg_nents_for_len

stable/6.6 was fixed.

Fixed status
stable/6.6: [6cd14414394b4f3d6e1ed64b8241d1fcc2271820]

CVE-2025-68764: NFS: Automounted filesystems should inherit
ro,noexec,nodev,sync flags

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [c09070b4def1b34e473a746c6a5331ccb80902c1]
stable/6.6: [dce10c59211e5cd763a62ea01e79b82a629811e3]

CVE-2025-68765: mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [594ff8bb69e239678a8baa461827ce4bb90eff8f]
stable/6.6: [1c3c234af9407256ed670c8752923a672eea4225]

CVE-2025-68766: irqchip/mchp-eic: Fix error code in mchp_eic_domain_alloc()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [324c60a67c4b9668497940f667db14d216cc7b1b]
stable/6.6: [c21c606ad398eeb86a0f3aaff9ba4f2665e286c6]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

