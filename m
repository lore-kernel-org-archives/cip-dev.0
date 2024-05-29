Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E007C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 22:21:36 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web10.2275.1717021291972470204
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 15:21:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=sAlYy9/X;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24fd457934cso135206fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1717021291; x=1717626091; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wFpKoOf2FYcY66Fah6TFbLClbUFnGNfQus6m1b2OxcI=;
        b=sAlYy9/XayAlQyz0Yrsuxyg+7pXjmsxHGV2ETTUGL5JqRctXmVPAUYMtzXj7iLVGqM
         FsvGKIznrQhLZvGfHOCDZMiDMYgrLkRqFYp9mRnh1MG51S+p3xPtB8Jbmt221GdrlHBa
         G1QtT96JJ8ObRuIyaOKCLAV1BuQybTsHgFqhpyi0yuvhL0IxI+QVWLG57JCmUkin1YcH
         NfF7UYj+k8VBcdu7juC7aNLTHa0jx7VAu+t7BE0ZiZSabTleAqrP/Eun4f0WhQuzzCxU
         ZRRsbsl8Bko/HNBoaJKGNNeiGl3CzxWsH7lVmsX7mQZ4h53qJPwaMYX0Y07s7gKNJ0ax
         DDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021291; x=1717626091;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFpKoOf2FYcY66Fah6TFbLClbUFnGNfQus6m1b2OxcI=;
        b=CpSPPF4jDn+Qg6PEHGzl+JaWLTP3/Co2dTbqJQC6b2L7RnC2JzBXDQTP+I/BroqlzO
         kNUOziiy7/+qCGWXk3A37N7TlGrFOoEDU2GEQudbzDEnS3CfjsoCyDEWzwS+UcLrHa6d
         TJZiEM1lewwtlxLgA5x0GTN7LdVfNmVseY7DCsfQN6EuecqHkO9xwPU7//Hkns3NP5RS
         PuHJVijZYrlv1B6fgIftJ0IMzinOADt3yMPSDfaTDHz+PAzADY7VtPu6kgE5xffHR2SF
         8aimgqGTfr5jiVJbLy5Yh+DNykF15F0pm1bTEofkw0lAGNUWGmKB+dwZpxEEljTdw2wO
         Rc7g==
X-Gm-Message-State: AOJu0YzII8zuX4UClO1HKpUfGD/f3/gajKaVw0PWsWx/HTr/LOmQzOmQ
	M+Vj0pVQ8rWjnLgmxCdIPUkmjM6LAzIBG9bABLY0oTNh/2zNpF5BOVdJlpQSqWNsRMLBDGT8aex
	sgdXLr24tvKvi53ITmb3wG7lyYzf/xUA9gpss4kLqu6+AF8HuLaI=
X-Google-Smtp-Source: AGHT+IGoneVfb716laA3RPOCjK+xKlgiaj87D7OGE9nSlZ4RGiwOZNIZ7pKUTXS7o5ab0ZdpldZ2HA/Mbm+GqrNYb2g=
X-Received: by 2002:a05:6871:3391:b0:24f:e79f:8600 with SMTP id
 586e51a60fabf-25060af9e8amr562630fac.1.1717021288411; Wed, 29 May 2024
 15:21:28 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 May 2024 07:20:52 +0900
Message-ID: <CAODzB9rK94j2MMkx4O85+yL0Z2Bu+aH1xjKXpsXwn2eD=WtG7Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 22:21:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16068

Hi!

It's this week's CVE report.

This week reported 149 new CVEs and 12 updated CVEs.

* New CVEs

CVE-2021-47433: btrfs: fix abort logic in btrfs_replace_file_extents

Announce: https://lore.kernel.org/linux-cve-announce/2024052235-CVE-2021-47=
433-659b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc6.
Executing btrfs_abort_transaction in btrfs_replace_file_extents (old
name is btrfs_punch_hole_range)
was added by commit 690a5dbfc ("Btrfs: fix ENOSPC errors, leading to
transaction aborts, when cloning extents") in 5.4-rc1.
So, prior to 5.4 kernels are not affected.

Fixed status
mainline: [4afb912f439c4bc4e6a4f3e7547f2e69e354108f]
stable/5.10: [0e32a2b85c7d92ece86c17dfef390c5ed79c6378]

CVE-2021-47434: xhci: Fix command ring pointer corruption while
aborting a command

Announce: https://lore.kernel.org/linux-cve-announce/2024052237-CVE-2021-47=
434-2f8e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc6.
Linux 4.4 is affected too.

Fixed status
mainline: [ff0e50d3564f33b7f4b35cadeabd951d66cfc570]
stable/4.19: [62c182b5e763e5f4062e72678e72ce3e02dd4d1b]
stable/5.10: [dec944bb7079b37968cf69c8a438f91f15c4cc61]
stable/5.4: [01c2dcb67e71c351006dd17cbba86c26b7f61eaf]

CVE-2021-47435: dm: fix mempool NULL pointer race when completing IO

Announce: https://lore.kernel.org/linux-cve-announce/2024052238-CVE-2021-47=
435-65c6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc6.
It seems as if 4.4 is affected too

Fixed status
mainline: [d208b89401e073de986dc891037c5a668f5d5d95]
stable/4.19: [9e07272cca2ed76f7f6073f4444b1143828c8d87]
stable/5.10: [d29c78d3f9c5d2604548c1065bf1ec212728ea61]
stable/5.4: [ad1393b92e5059218d055bfec8f4946d85ad04c4]

CVE-2021-47436: usb: musb: dsps: Fix the probe error path

Announce: https://lore.kernel.org/linux-cve-announce/2024052238-CVE-2021-47=
436-5bb9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7c75bde ("usb: musb: musb_dsps: request_irq()
after initializing musb") in 5.15-rc1.Fixed in  5.15-rc6.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [c2115b2b16421d93d4993f3fe4c520e91d6fe801]
stable/4.19: [e923bce31ffefe4f60edfc6b84f62d4a858f3676]
stable/5.10: [9d89e287116796bf987cc48f5c8632ef3048f8eb]
stable/5.4: [9ab5d539bc975b8dcde86eca1b58d836b657732e]

CVE-2021-47437: iio: adis16475: fix deadlock on frequency set

Announce: https://lore.kernel.org/linux-cve-announce/2024052238-CVE-2021-47=
437-10ea@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 39c024b ("iio: adis16475: improve sync scale mode
handling") in v5.13-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9da1b86865ab4376408c58cd9fec332c8bdb5c73]

CVE-2021-47438: net/mlx5e: Fix memory leak in mlx5_core_destroy_cq() error =
path

Announce: https://lore.kernel.org/linux-cve-announce/2024052238-CVE-2021-47=
438-ceac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e126ba9 ("mlx5: Add driver for Mellanox
Connect-IB adapters") in v3.11-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94b960b9deffc02fc0747afc01f72cc62ab099e3]
stable/5.10: [4f7bddf8c5c01cac74373443b13a68e1c6723a94]

CVE-2021-47439: net: dsa: microchip: Added the condition for
scheduling ksz_mib_read_work

Announce: https://lore.kernel.org/linux-cve-announce/2024052239-CVE-2021-47=
439-b411@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 469b390 ("net: dsa: microchip: use delayed_work
instead of timer + work") in v5.7-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef1100ef20f29aec4e62abeccdb5bdbebba1e378]
stable/5.10: [f2e1de075018cf71bcd7d628e9f759cb8540b0c3]

CVE-2021-47440: net: encx24j600: check error in devm_regmap_init_encx24j600

Announce: https://lore.kernel.org/linux-cve-announce/2024052239-CVE-2021-47=
440-452a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 04fbfce ("net: Microchip encx24j600 driver") in v4.4-r=
c1.
Fixed in  v5.15-rc6.

Fixed status
cip/4.4: [66358471fa75a713fd76bc8a4bd74cb14cd50a4f]
cip/4.4-rt: [66358471fa75a713fd76bc8a4bd74cb14cd50a4f]
cip/4.4-st: [66358471fa75a713fd76bc8a4bd74cb14cd50a4f]
mainline: [f03dca0c9e2297c84a018e306f8a9cd534ee4287]
stable/4.19: [5e5494e6fc8a29c927e0478bec4a078a40da8901]
stable/4.4: [66358471fa75a713fd76bc8a4bd74cb14cd50a4f]
stable/5.10: [e19c10d6e07c59c96e90fe053a72683ad8b0397e]
stable/5.4: [4c2eb80fc90b05559ce6ed1b8dfb2348420b5644]

CVE-2021-47441: mlxsw: thermal: Fix out-of-bounds memory accesses

Announce: https://lore.kernel.org/linux-cve-announce/2024052239-CVE-2021-47=
441-8775@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a50c1e3 ("mlxsw: core: Implement thermal zone")
in v4.10-rc1.
Introduced by commit a421ce0 ("mlxsw: core: Extend cooling device with
cooling levels") in v5.0-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [332fdf951df8b870e3da86b122ae304e2aabe88c]
stable/5.10: [e59d839743b50cb1d3f42a786bea48cc5621d254]
stable/5.4: [ae0993739e14a102d506aa09e11b0065f3144f10]

CVE-2021-47442: NFC: digital: fix possible memory leak in
digital_in_send_sdd_req()

Announce: https://lore.kernel.org/linux-cve-announce/2024052240-CVE-2021-47=
442-5dcb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2c66dae ("NFC Digital: Add NFC-A technology
support") in v3.13-rc1.
Fixed in  v5.15-rc6.

Fixed status
cip/4.4: [74569c78aa84f8c958f1334b465bc530906ec99a]
cip/4.4-rt: [74569c78aa84f8c958f1334b465bc530906ec99a]
cip/4.4-st: [74569c78aa84f8c958f1334b465bc530906ec99a]
mainline: [291c932fc3692e4d211a445ba8aa35663831bac7]
stable/4.19: [071bdef36391958c89af5fa2172f691b31baa212]
stable/4.4: [74569c78aa84f8c958f1334b465bc530906ec99a]
stable/5.10: [50cb95487c265187289810addec5093d4fed8329]
stable/5.4: [2bde4aca56db9fe25405d39ddb062531493a65db]

CVE-2021-47443: NFC: digital: fix possible memory leak in
digital_tg_listen_mdaa()

Announce: https://lore.kernel.org/linux-cve-announce/2024052240-CVE-2021-47=
443-e331@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1c7a4c2 ("NFC Digital: Add target NFC-DEP
support") in v3.13-rc1.
Fixed in  v5.15-rc6.

Fixed status
cip/4.4: [429054ec51e648d241a7e0b465cf44f6633334c5]
cip/4.4-rt: [429054ec51e648d241a7e0b465cf44f6633334c5]
cip/4.4-st: [429054ec51e648d241a7e0b465cf44f6633334c5]
mainline: [58e7dcc9ca29c14e44267a4d0ea61e3229124907]
stable/4.19: [9881b0c860649f27ef2565deef011e516390f416]
stable/4.4: [429054ec51e648d241a7e0b465cf44f6633334c5]
stable/5.10: [3f2960b39f22e26cf8addae93c3f5884d1c183c9]
stable/5.4: [7ab488d7228a9dceb2456867f1f0919decf6efed]

CVE-2021-47444: drm/edid: In connector_bad_edid() cap num_of_ext by
num_blocks read

Announce: https://lore.kernel.org/linux-cve-announce/2024052240-CVE-2021-47=
444-d54b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e11f5bd ("drm: Add support for DP 1.4 Compliance
edid corruption test") in v5.7-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97794170b696856483f74b47bfb6049780d2d3a0]
stable/5.10: [a7b45024f66f9ec769e8dbb1a51ae83cd05929c7]

CVE-2021-47445: drm/msm: Fix null pointer dereference on pointer edp

Announce: https://lore.kernel.org/linux-cve-announce/2024052241-CVE-2021-47=
445-3659@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ab5b010 ("drm/msm: Initial add eDP support in msm
drm driver (v5)") in v4.0-rc1.
Fixed in  v5.15-rc6.

Fixed status
cip/4.4: [f175b9a83e5c252d7c74acddc792840016caae0a]
cip/4.4-rt: [f175b9a83e5c252d7c74acddc792840016caae0a]
cip/4.4-st: [f175b9a83e5c252d7c74acddc792840016caae0a]
mainline: [2133c4fc8e1348dcb752f267a143fe2254613b34]
stable/4.19: [7f642b93710b6b1119bdff90be01e6b5a2a5d669]
stable/4.4: [f175b9a83e5c252d7c74acddc792840016caae0a]
stable/5.10: [91a340768b012f5b910a203a805b97a345b3db37]
stable/5.4: [f302be08e3de94db8863a0b2958b2bb3e8e998e6]

CVE-2021-47446: drm/msm/a4xx: fix error handling in a4xx_gpu_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024052241-CVE-2021-47=
446-8d69@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5785dd7 ("drm/msm: Fix duplicate gpu node in icc
summary") in v5.11-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [980d74e7d03ccf2eaa11d133416946bd880c7c08]

CVE-2021-47447: drm/msm/a3xx: fix error handling in a3xx_gpu_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024052241-CVE-2021-47=
447-62f1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5785dd7 ("drm/msm: Fix duplicate gpu node in icc
summary") in v5.11-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3eda901995371d390ef82d0b6462f4ea8efbcfdf]

CVE-2021-47448: mptcp: fix possible stall on recvmsg()

Announce: https://lore.kernel.org/linux-cve-announce/2024052241-CVE-2021-47=
448-6a2d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7a6a6cb ("mptcp: recvmsg() can drain data from
multiple subflow") in v5.6-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [612f71d7328c14369924384ad2170aae2a6abd92]

CVE-2021-47449: ice: fix locking for Tx timestamp tracking flush

Announce: https://lore.kernel.org/linux-cve-announce/2024052242-CVE-2021-47=
449-6323@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit4dd0d5c ("ice: add lock around Tx timestamp
tracker flush") in 5.15-rc1. Fixed in 5.15-rc6
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d4a223a86afe658cd878800f09458e8bb54415d]

CVE-2021-47450: KVM: arm64: Fix host stage-2 PGD refcount

Announce: https://lore.kernel.org/linux-cve-announce/2024052242-CVE-2021-47=
450-c72f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1025c8c ("KVM: arm64: Wrap the host with a stage
2") in v5.13-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d58a17ef54599506d44c45ac95be27273a4d2b1]

CVE-2021-47451: netfilter: xt_IDLETIMER: fix panic that occurs when
timer_type has garbage value

Announce: https://lore.kernel.org/linux-cve-announce/2024052242-CVE-2021-47=
451-72c7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 68983a3 ("netfilter: xtables: Add snapshot of
hardidletimer target") in v5.7-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [902c0b1887522a099aa4e1e6b4b476c2fe5dd13e]
stable/5.10: [2a670c323055282c9b72794a491d53cef86bbeaf]

CVE-2021-47452: netfilter: nf_tables: skip netdev events generated on
netns removal

Announce: https://lore.kernel.org/linux-cve-announce/2024052243-CVE-2021-47=
452-40cb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 767d121 ("netfilter: nftables: fix possible UAF
over chains from packet path in netns") in v5.11.
Fixed in  v5.15-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [68a3765c659f809dcaac20030853a054646eb739]

CVE-2021-47453: ice: Avoid crash from unnecessary IDA free

Announce: https://lore.kernel.org/linux-cve-announce/2024052243-CVE-2021-47=
453-2f17@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d25a0fc ("ice: Initialize RDMA support") in v5.14-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73e30a62b19b9fbb4e6a3465c59da186630d5f2e]

CVE-2021-47454: powerpc/smp: do not decrement idle task preempt count
in CPU offline

Announce: https://lore.kernel.org/linux-cve-announce/2024052243-CVE-2021-47=
454-e852@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2c669ef ("powerpc/preempt: Don't touch the idle
task's preempt_count during hotplug") in v5.14-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [787252a10d9422f3058df9a4821f389e5326c440]
stable/5.10: [53770a411559cf7bc0906d1df319cc533d2f4f58]

CVE-2021-47455: ptp: Fix possible memory leak in ptp_clock_register()

Announce: https://lore.kernel.org/linux-cve-announce/2024052244-CVE-2021-47=
455-c4a1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a33121e ("ptp: fix the race between the release
of ptp_clock and cdev") in v5.5-rc5.
Fixed in  v5.15-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st stable/4.19 stable/5.4

Fixed status
mainline: [4225fea1cb28370086e17e82c0f69bec2779dca0]

CVE-2021-47456: can: peak_pci: peak_pci_remove(): fix UAF

Announce: https://lore.kernel.org/linux-cve-announce/2024052244-CVE-2021-47=
456-dc47@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e6d9c80 ("can: peak_pci: add support of some new
PEAK-System PCI cards") in v3.4-rc1.
Fixed in  v5.15-rc7.

Fixed status
cip/4.4: [1c616528ba4aeb1125a06b407572ab7b56acae38]
cip/4.4-rt: [1c616528ba4aeb1125a06b407572ab7b56acae38]
cip/4.4-st: [1c616528ba4aeb1125a06b407572ab7b56acae38]
mainline: [949fe9b35570361bc6ee2652f89a0561b26eec98]
stable/4.19: [adbda14730aacce41c0d3596415aa39ad63eafd9]
stable/4.4: [1c616528ba4aeb1125a06b407572ab7b56acae38]
stable/5.10: [28f28e4bc3a5e0051faa963f10b778ab38c1db69]
stable/5.4: [1248582e47a9f7ce0ecd156c39fc61f8b6aa3699]

CVE-2021-47457: can: isotp: isotp_sendmsg(): add result check for
wait_event_interruptible()

Announce: https://lore.kernel.org/linux-cve-announce/2024052244-CVE-2021-47=
457-d807@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e057dd3 ("can: add ISO 15765-2:2016 transport
protocol") in v5.10-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9acf636215a6ce9362fe618e7da4913b8bfe84c8]
stable/5.10: [053bc12df0d6097c1126d0e14fa778a0a8faeb64]

CVE-2021-47458: ocfs2: mount fails with buffer overflow in strlen

Announce: https://lore.kernel.org/linux-cve-announce/2024052244-CVE-2021-47=
458-545c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.15-rc7.

Fixed status
cip/4.4: [ac011cb3ff7a76b3e0e6e77158ee4ba2f929e1fb]
cip/4.4-rt: [ac011cb3ff7a76b3e0e6e77158ee4ba2f929e1fb]
cip/4.4-st: [ac011cb3ff7a76b3e0e6e77158ee4ba2f929e1fb]
mainline: [b15fa9224e6e1239414525d8d556d824701849fc]
stable/4.19: [7623b1035ca2d17bde0f6a086ad6844a34648df1]
stable/4.4: [ac011cb3ff7a76b3e0e6e77158ee4ba2f929e1fb]
stable/5.10: [93be0eeea14cf39235e585c8f56df3b3859deaad]
stable/5.4: [d3a83576378b4c904f711598dde2c5e881c4295c]

CVE-2021-47459: can: j1939: j1939_netdev_start(): fix UAF for rx_kref
of j1939_priv

Announce: https://lore.kernel.org/linux-cve-announce/2024052224-CVE-2021-47=
459-4f79@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9d52a3ebd284882f5562c88e55991add5d01586]
stable/5.10: [864e77771a24c877aaf53aee019f78619cbcd668]
stable/5.4: [a0e47d2833b4f65e6c799f28c6b636d36b8b936d]

CVE-2021-47460: ocfs2: fix data corruption after conversion from inline for=
mat

Announce: https://lore.kernel.org/linux-cve-announce/2024052225-CVE-2021-47=
460-19e3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6dbf7bb ("fs: Don't invalidate page buffers in
block_write_full_page()") in v5.10-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19 stable/5.4

Fixed status
mainline: [5314454ea3ff6fc746eaf71b9a7ceebed52888fa]
stable/4.19: [a3a089c241cd49b33a8cdd7fcb37cc87a086912a]
stable/5.10: [f1b98569e81c37d7e0deada7172f8f60860c1360]
stable/5.4: [b05caf023b14cbed9223bb5b48ecc7bffe38f632]

CVE-2021-47461: userfaultfd: fix a race between writeprotect and exit_mmap(=
)

Announce: https://lore.kernel.org/linux-cve-announce/2024052225-CVE-2021-47=
461-a472@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 63b2d41 ("userfaultfd: wp: add the writeprotect
API to userfaultfd ioctl") in v5.7-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb185d5f1ebf900f4ae3bf84cee212e6dd035aca]
stable/5.10: [3cda4bfffd4f755645577aaa9e96a606657b4525]

CVE-2021-47462: mm/mempolicy: do not allow illegal
MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()

Announce: https://lore.kernel.org/linux-cve-announce/2024052225-CVE-2021-47=
462-f177@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bda420b ("numa balancing: migrate on fault among
multiple bound nodes") in v5.12-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d2aec9e123bb9c49cb5c7fc654f25f81e688e8c]

CVE-2021-47463: mm/secretmem: fix NULL page->mapping dereference in
page_is_secretmem()

Announce: https://lore.kernel.org/linux-cve-announce/2024052226-CVE-2021-47=
463-c131@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1507f51 ("mm: introduce memfd_secret system call
to create "secret" memory areas") in v5.14-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79f9bc5843142b649575f887dccdf1c07ad75c20]

CVE-2021-47464: audit: fix possible null-pointer dereference in
audit_filter_rules

Announce: https://lore.kernel.org/linux-cve-announce/2024052226-CVE-2021-47=
464-8254@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bf36123 ("audit: add saddr_fam filter field") in v5.3-=
rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e3ee990c90494561921c756481d0e2125d8b895]
stable/5.10: [16802fa4c33eb1a8efb23f1e93365190e4047d05]
stable/5.4: [d6f451f1f60c58d73038c7c3177066f8f084e2a2]

CVE-2021-47465: KVM: PPC: Book3S HV: Fix stack handling in
idle_kvm_start_guest()

Announce: https://lore.kernel.org/linux-cve-announce/2024052226-CVE-2021-47=
465-bd6f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 10d9161 ("powerpc/64s: Reimplement book3s idle
code in C") in v5.2-rc1.
Fixed in  v5.15-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b4416c5095c20e110c82ae602c254099b83b72f]
stable/5.10: [fbd724c49bead048ae9fc1a5b7bff2fb3e54f855]
stable/5.4: [80bbb0bc3a0288442f7fe6fc514f4ee1cb06ccb7]

CVE-2021-47466: mm, slub: fix potential memoryleak in kmem_cache_open()

Announce: https://lore.kernel.org/linux-cve-announce/2024052227-CVE-2021-47=
466-ff03@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 210e7a4 ("mm: SLUB freelist randomization") in v4.8-rc=
1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9037c57681d25e4dcc442d940d6dbe24dd31f461]
stable/5.10: [568f906340b43120abd6fcc67c37396482f85930]
stable/5.4: [4f5d1c29cfab5cb0ab885059818751bdef32e2bb]

CVE-2021-47467: kunit: fix reference count leak in kfree_at_end

Announce: https://lore.kernel.org/linux-cve-announce/2024052227-CVE-2021-47=
467-29a2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc6.
Introduced by commit 1d71307 ("kunit: add unit test for filtering
suites by names") in 5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f62314b1ced25c58b86e044fc951cd6a1ea234cf]

CVE-2021-47468: isdn: mISDN: Fix sleeping function called from invalid cont=
ext

Announce: https://lore.kernel.org/linux-cve-announce/2024052227-CVE-2021-47=
468-6c1b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc6.

Fixed status
cip/4.4: [6f95c97e0f9d6eb39c3f2cb45e8fa4268d1b372b]
cip/4.4-rt: [6f95c97e0f9d6eb39c3f2cb45e8fa4268d1b372b]
cip/4.4-st: [6f95c97e0f9d6eb39c3f2cb45e8fa4268d1b372b]
mainline: [6510e80a0b81b5d814e3aea6297ba42f5e76f73c]
stable/4.19: [a5b34409d3fc52114c828be4adbc30744fa3258b]
stable/4.4: [6f95c97e0f9d6eb39c3f2cb45e8fa4268d1b372b]
stable/5.10: [9f591cbdbed3d7822b2bdba89b34a6d7b434317d]
stable/5.4: [4054b869dc263228d30a4755800b78f0f2ba0c89]

CVE-2021-47469: spi: Fix deadlock when adding SPI controllers on SPI buses

Announce: https://lore.kernel.org/linux-cve-announce/2024052227-CVE-2021-47=
469-00c0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc6.
It seems as if 4.x, 5.4, and 5.10 may be affected too.

Fixed status
mainline: [6098475d4cb48d821bdf453c61118c56e26294f0]

CVE-2021-47470: mm, slub: fix potential use-after-free in slab_debugfs_fops

Announce: https://lore.kernel.org/linux-cve-announce/2024052228-CVE-2021-47=
470-094f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 64dd684 ("mm: slub: move sysfs slab alloc/free
interfaces to debugfs") in v5.14-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67823a544414def2a36c212abadb55b23bcda00c]

CVE-2021-47471: drm: mxsfb: Fix NULL pointer dereference crash on unload

Announce: https://lore.kernel.org/linux-cve-announce/2024052228-CVE-2021-47=
471-3ef4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ae1ed00 ("drm: mxsfb: Stop using DRM simple
display pipeline helper") in v5.10-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cfc183052c3dbf8eae57b6c1685dab00ed3db4a]
stable/5.10: [f40c2281d2c0674d32ba732fee45222d76495472]

CVE-2021-47472: net: mdiobus: Fix memory leak in __mdiobus_register

Announce: https://lore.kernel.org/linux-cve-announce/2024052228-CVE-2021-47=
472-bd55@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc4.

Fixed status
cip/4.4: [fd2400dd4f1b8bd7a309b1b424d9e0d188151b01]
cip/4.4-rt: [fd2400dd4f1b8bd7a309b1b424d9e0d188151b01]
cip/4.4-st: [fd2400dd4f1b8bd7a309b1b424d9e0d188151b01]
mainline: [ab609f25d19858513919369ff3d9a63c02cd9e2e]
stable/4.19: [8121d0d4fd108280f5cd7b7fe8c6592adaa37be9]
stable/4.4: [b89f4537d7fdbd0bafb6d8a66a484e0bc99871a4]
stable/5.10: [c828115a14eacbf42042770fd68543f134e89efa]
stable/5.4: [6a18d155d5b35ad50c8fac2be091212487ae58ec]

CVE-2021-47473: scsi: qla2xxx: Fix a memory leak in an error path of
qla2x00_process_els()

Announce: https://lore.kernel.org/linux-cve-announce/2024052229-CVE-2021-47=
473-c883@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8c0eb59 ("[SCSI] qla2xxx: Fix a memory leak in an
error path of qla2x00_process_els()") in v3.11-rc1.
Fixed in  v5.15-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fb223d0ad801f633c78cbe42b1d1b55f5d163ad]
stable/5.10: [96f0aebf29be25254fa585af43924e34aa21fd9a]

CVE-2021-47474: comedi: vmk80xx: fix bulk-buffer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024052233-CVE-2021-47=
474-7185@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 985cafc ("Staging: Comedi: vmk80xx: Add k8061
support") in v2.6.31-rc1.
Fixed in  v5.16-rc1.

Fixed status
cip/4.4: [e0e6a63fd97ad95fe05dfd77268a1952551e11a7]
cip/4.4-rt: [e0e6a63fd97ad95fe05dfd77268a1952551e11a7]
cip/4.4-st: [e0e6a63fd97ad95fe05dfd77268a1952551e11a7]
mainline: [78cdfd62bd54af615fba9e3ca1ba35de39d3871d]
stable/4.19: [063f576c43d589a4c153554b681d32b3f8317c7b]
stable/4.4: [e0e6a63fd97ad95fe05dfd77268a1952551e11a7]
stable/5.10: [b7fd7f3387f070215e6be341e68eb5c087eeecc0]
stable/5.15: [47b4636ebdbeba2044b3db937c4d2b6a4fe3d0f2]
stable/5.4: [1ae4715121a57bc6fa29fd992127b01907f2f993]

CVE-2021-47475: comedi: vmk80xx: fix transfer-buffer overflows

Announce: https://lore.kernel.org/linux-cve-announce/2024052236-CVE-2021-47=
475-6524@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 985cafc ("Staging: Comedi: vmk80xx: Add k8061
support") in v2.6.31-rc1.
Fixed in  v5.16-rc1.

Fixed status
cip/4.4: [5229159f1d052821007aff1a1beb7873eacf1a9f]
cip/4.4-rt: [5229159f1d052821007aff1a1beb7873eacf1a9f]
cip/4.4-st: [5229159f1d052821007aff1a1beb7873eacf1a9f]
mainline: [a23461c47482fc232ffc9b819539d1f837adf2b1]
stable/4.19: [7a2021b896de1ad559d33b5c5cdd20b982242088]
stable/4.4: [5229159f1d052821007aff1a1beb7873eacf1a9f]
stable/5.10: [33d7a470730dfe7c9bfc8da84575cf2cedd60d00]
stable/5.15: [06ac746d57e6d32b062e220415c607b7e2e0fa50]
stable/5.4: [199acd8c110e3ae62833c24f632b0bb1c9f012a9]

CVE-2021-47476: comedi: ni_usb6501: fix NULL-deref in command paths

Announce: https://lore.kernel.org/linux-cve-announce/2024052236-CVE-2021-47=
476-5a68@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a03bb00 ("staging: comedi: add NI USB-6501
support") in v3.18-rc1.
Fixed in  v5.16-rc1.

Fixed status
cip/4.4: [58478143771b20ab219937b1c30a706590a59224]
cip/4.4-rt: [58478143771b20ab219937b1c30a706590a59224]
cip/4.4-st: [58478143771b20ab219937b1c30a706590a59224]
mainline: [907767da8f3a925b060c740e0b5c92ea7dbec440]
stable/4.19: [bc51111bf6e8e7b6cc94b133e4c291273a16acd1]
stable/4.4: [58478143771b20ab219937b1c30a706590a59224]
stable/5.10: [ef143dc0c3defe56730ecd3a9de7b3e1d7e557c1]
stable/5.15: [d6a727a681a39ae4f73081a9bedb45d14f95bdd1]
stable/5.4: [b0156b7c9649d8f55a2ce3d3258509f1b2a181c3]

CVE-2021-47477: comedi: dt9812: fix DMA buffers on stack

Announce: https://lore.kernel.org/linux-cve-announce/2024052236-CVE-2021-47=
477-955e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 63274cd ("Staging: comedi: add usb dt9812
driver") in v2.6.29-rc1.
Fixed in  v5.16-rc1.

Fixed status
cip/4.4: [a6af69768d5cb4b2528946d53be5fa19ade37723]
cip/4.4-rt: [a6af69768d5cb4b2528946d53be5fa19ade37723]
cip/4.4-st: [a6af69768d5cb4b2528946d53be5fa19ade37723]
mainline: [536de747bc48262225889a533db6650731ab25d3]
stable/4.19: [39ea61037ae78f14fa121228dd962ea3280eacf3]
stable/4.4: [a6af69768d5cb4b2528946d53be5fa19ade37723]
stable/5.10: [786f5b03450454557ff858a8bead5d7c0cbf78d6]
stable/5.15: [20cebb8b620dc987e55ddc46801de986e081757e]
stable/5.4: [3efb7af8ac437085b6c776e5b54830b149d86efe]

CVE-2021-47478: isofs: Fix out of bound access for corrupted isofs image

Announce: https://lore.kernel.org/linux-cve-announce/2024052237-CVE-2021-47=
478-c124@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.16-rc1.

Fixed status
cip/4.4: [156ce5bb6cc43a80a743810199defb1dc3f55b7f]
cip/4.4-rt: [156ce5bb6cc43a80a743810199defb1dc3f55b7f]
cip/4.4-st: [156ce5bb6cc43a80a743810199defb1dc3f55b7f]
mainline: [e96a1866b40570b5950cda8602c2819189c62a48]
stable/4.19: [b0ddff8d68f2e43857a84dce54c3deab181c8ae1]
stable/4.4: [156ce5bb6cc43a80a743810199defb1dc3f55b7f]
stable/5.10: [86d4aedcbc69c0f84551fb70f953c24e396de2d7]
stable/5.15: [e7fb722586a2936b37bdff096c095c30ca06404d]
stable/5.4: [6e80e9314f8bb52d9eabe1907698718ff01120f5]

CVE-2021-47479: staging: rtl8712: fix use-after-free in rtl8712_dl_fw

Announce: https://lore.kernel.org/linux-cve-announce/2024052237-CVE-2021-47=
479-2b82@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8c213fa ("staging: r8712u: Use asynchronous
firmware loading") in v3.3-rc4.
Fixed in  v5.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c052cc1a069c3e575619cf64ec427eb41176ca70]
stable/5.10: [c430094541a80575259a94ff879063ef01473506]
stable/5.15: [a65c9afe9f2f55b7a7fb4a25ab654cd4139683a4]

CVE-2021-47480: scsi: core: Put LLD module refcnt after SCSI device is rele=
ased

Announce: https://lore.kernel.org/linux-cve-announce/2024052237-CVE-2021-47=
480-eaa0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc7.

Fixed status
cip/4.4: [1105573d964f7b78734348466b01f5f6ba8a1813]
cip/4.4-rt: [1105573d964f7b78734348466b01f5f6ba8a1813]
cip/4.4-st: [1105573d964f7b78734348466b01f5f6ba8a1813]
mainline: [f2b85040acec9a928b4eb1b57a989324e8e38d3f]
stable/4.19: [c2df161f69fb1c67f63adbd193368b47f511edc0]
stable/4.4: [1105573d964f7b78734348466b01f5f6ba8a1813]
stable/5.10: [7b57c38d12aed1b5d92f74748bed25e0d041729f]
stable/5.4: [1ce287eff9f23181d5644db787f472463a61f68b]

CVE-2021-47481: RDMA/mlx5: Initialize the ODP xarray when creating an ODP M=
R

Announce: https://lore.kernel.org/linux-cve-announce/2024052238-CVE-2021-47=
481-745e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a639e66 ("RDMA/mlx5: Zero out ODP related items
in the mlx5_ib_mr") in v5.13-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5508546631a0f555d7088203dec2614e41b5106e]

CVE-2021-47482: net: batman-adv: fix error handling

Announce: https://lore.kernel.org/linux-cve-announce/2024052238-CVE-2021-47=
482-5612@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c6c8fea ("net: Add batman-adv meshing protocol")
in v2.6.38-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older  kernels.

Fixed status
cip/4.4: [0c6b199f09be489c48622537a550787fc80aea73]
cip/4.4-rt: [0c6b199f09be489c48622537a550787fc80aea73]
cip/4.4-st: [0c6b199f09be489c48622537a550787fc80aea73]
mainline: [6f68cd634856f8ca93bafd623ba5357e0f648c68]
stable/4.19: [fbf150b16a3635634b7dfb7f229d8fcd643c6c51]
stable/4.4: [0c6b199f09be489c48622537a550787fc80aea73]
stable/5.10: [b0a2cd38553c77928ef1646ed1518486b1e70ae8]
stable/5.4: [6422e8471890273994fe8cc6d452b0dcd2c9483e]

CVE-2021-47483: regmap: Fix possible double-free in regcache_rbtree_exit()

Announce: https://lore.kernel.org/linux-cve-announce/2024052238-CVE-2021-47=
483-8306@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3f4ff56 ("regmap: rbtree: Make cache_present
bitmap per node") in v3.12-rc1.
Fixed in  v5.15.

Fixed status
cip/4.4: [e72dce9afbdbfa70d9b44f5908a50ff6c4858999]
cip/4.4-rt: [e72dce9afbdbfa70d9b44f5908a50ff6c4858999]
cip/4.4-st: [e72dce9afbdbfa70d9b44f5908a50ff6c4858999]
mainline: [55e6d8037805b3400096d621091dfbf713f97e83]
stable/4.19: [3dae1a4eced3ee733d7222e69b8a55caf2d61091]
stable/4.4: [e72dce9afbdbfa70d9b44f5908a50ff6c4858999]
stable/5.10: [36e911a16b377bde0ad91a8c679069d0d310b1a6]
stable/5.4: [1cead23c1c0bc766dacb900a3b0269f651ad596f]

CVE-2021-47484: octeontx2-af: Fix possible null pointer dereference.

Announce: https://lore.kernel.org/linux-cve-announce/2024052239-CVE-2021-47=
484-389a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8756828 ("octeontx2-af: Add NPA aura and pool
contexts to debugfs") in v5.5-rc1.
Introduced by commit 9a946de ("octeontx2-af: Modify nix_vtag_cfg
mailbox to support TX VTAG entries") in v5.11-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2d4c543f74c90f883e8ec62a31973ae8807d354]

CVE-2021-47485: IB/qib: Protect from buffer overflow in struct
qib_user_sdma_pkt fields

Announce: https://lore.kernel.org/linux-cve-announce/2024052239-CVE-2021-47=
485-4584@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f931551 ("IB/qib: Add new qib driver for QLogic
PCIe InfiniBand adapters") in v2.6.35-rc1.
Fixed in  v5.15.

Fixed status
cip/4.4: [bda41654b6e0c125a624ca35d6d20beb8015b5d0]
cip/4.4-rt: [bda41654b6e0c125a624ca35d6d20beb8015b5d0]
cip/4.4-st: [bda41654b6e0c125a624ca35d6d20beb8015b5d0]
mainline: [d39bf40e55e666b5905fdbd46a0dced030ce87be]
stable/4.19: [73d2892148aa4397a885b4f4afcfc5b27a325c42]
stable/4.4: [bda41654b6e0c125a624ca35d6d20beb8015b5d0]
stable/5.10: [c3e17e58f571f34c51aeb17274ed02c2ed5cf780]
stable/5.4: [0f8cdfff06829a0b0348b6debc29ff6a61967724]

CVE-2021-47486: riscv, bpf: Fix potential NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052239-CVE-2021-47=
486-6a5a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ca6cb54 ("riscv, bpf: Factor common RISC-V JIT
code") in v5.7-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27de809a3d83a6199664479ebb19712533d6fd9b]
stable/5.10: [cac6b043cea3e120f4fccec16f7381747cbfdc0d]

CVE-2021-47487: drm/amdgpu: fix out of bounds write

Announce: https://lore.kernel.org/linux-cve-announce/2024052239-CVE-2021-47=
487-6e14@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15.
It seems as if this bug was introduced by commit 918698d
("drm/amd/display: Return the number of bytes parsed than allocated")
in 5.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5afa7898ab7a0ec9c28556a91df714bf3c2f725e]
stable/5.10: [eb3b6805e3e9d98b2507201fd061a231988ce623]

CVE-2021-47488: cgroup: Fix memory leak caused by missing cgroup_bpf_offlin=
e

Announce: https://lore.kernel.org/linux-cve-announce/2024052240-CVE-2021-47=
488-9c35@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2b0d3d3 ("percpu_ref: reduce memory footprint of
percpu_ref in fast path") in v5.10-rc1.
Introduced by commit 4bfc0bb ("bpf: decouple the lifetime of
cgroup_bpf from cgroup itself") in v5.3-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04f8ef5643bcd8bcde25dfdebef998aea480b2ba]
stable/5.10: [01599bf7cc2b49c3d2be886cb438647dc25446ed]

CVE-2021-47489: drm/amdgpu: Fix even more out of bound writes from debugfs

Announce: https://lore.kernel.org/linux-cve-announce/2024052240-CVE-2021-47=
489-3f3a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 918698d ("drm/amd/display: Return the number of
bytes parsed than allocated") in v5.10-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f4e54bd312d3dafb59daf2b97ffa08abebe60f5]

CVE-2021-47490: drm/ttm: fix memleak in ttm_transfered_destroy

Announce: https://lore.kernel.org/linux-cve-announce/2024052240-CVE-2021-47=
490-e510@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15.
The commit 8eb8833e ("drm/ttm: add gem base object") in 5.4-rc1 added
base object into struct ttm_buffer_object.
Therefore prior to 5.4 kernels do not have an object to free in the fix.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0db55f9a1bafbe3dac750ea669de9134922389b5]
stable/5.10: [bbc920fb320f1c241cc34ac85edaa0058922246a]
stable/5.4: [960b1fdfc39aba8f41e9e27b2de0c925c74182d9]

CVE-2021-47491: mm: khugepaged: skip huge page collapse for special files

Announce: https://lore.kernel.org/linux-cve-announce/2024052241-CVE-2021-47=
491-437d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 99cb0db ("mm,thp: add read-only THP support for
(non-shmem) FS") in v5.4-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4aeaa06d45e90f9b279f0b09de84bd00006e733]
stable/5.10: [6d67b2a73b8e3a079c355bab3c1aef7d85a044b8]

CVE-2021-47492: mm, thp: bail out early in collapse_file for writeback page

Announce: https://lore.kernel.org/linux-cve-announce/2024052241-CVE-2021-47=
492-ee88@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 99cb0db ("mm,thp: add read-only THP support for
(non-shmem) FS") in v5.4-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74c42e1baacf206338b1dd6b6199ac964512b5bb]
stable/5.10: [69a7fa5cb0de06c8956b040f19a7248c8c8308ca]

CVE-2021-47493: ocfs2: fix race between searching chunks and release
journal_head from buffer_head

Announce: https://lore.kernel.org/linux-cve-announce/2024052241-CVE-2021-47=
493-24fb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15.
It looks as if 4.x and 5.4 may affected too.

Fixed status
mainline: [6f1b228529ae49b0f85ab89bcdb6c365df401558]
stable/5.10: [5043fbd294f5909a080ade0f04b70a4da9e122b7]

CVE-2021-47494: cfg80211: fix management registrations locking

Announce: https://lore.kernel.org/linux-cve-announce/2024052241-CVE-2021-47=
494-d0d7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6cd536f ("cfg80211: change internal management
frame registration API") in v5.8-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09b1d5dc6ce1c9151777f6c4e128a59457704c97]
stable/5.10: [4c22227e39c7a0b4dab55617ee8d34d171fab8d4]

CVE-2021-47495: usbnet: sanity check for maxpacket

Announce: https://lore.kernel.org/linux-cve-announce/2024052242-CVE-2021-47=
495-a5f8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc7.

Fixed status
cip/4.4: [b9eba0a4a527e04d712f0e0401e5391ef124b33e]
cip/4.4-rt: [b9eba0a4a527e04d712f0e0401e5391ef124b33e]
cip/4.4-st: [b9eba0a4a527e04d712f0e0401e5391ef124b33e]
mainline: [397430b50a363d8b7bdda00522123f82df6adc5e]
stable/4.19: [002d82227c0abe29118cf80f7e2f396b22d448ed]
stable/4.4: [b9eba0a4a527e04d712f0e0401e5391ef124b33e]
stable/5.10: [693ecbe8f799405f8775719deedb1f76265d375a]
stable/5.4: [492140e45d2bf27c1014243f8616a9b612144e20]

CVE-2021-47496: net/tls: Fix flipped sign in tls_err_abort() calls

Announce: https://lore.kernel.org/linux-cve-announce/2024052242-CVE-2021-47=
496-4d0d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c46234e ("tls: RX path for ktls") in v4.17-rc1.
Fixed in  v5.15.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da353fac65fede6b8b4cfe207f0d9408e3121105]
stable/5.10: [f3dec7e7ace38224f82cf83f0049159d067c2e19]
stable/5.4: [e0cfd5159f314d6b304d030363650b06a2299cbb]

CVE-2021-47497: nvmem: Fix shift-out-of-bound (UBSAN) with byte size cells

Announce: https://lore.kernel.org/linux-cve-announce/2024052242-CVE-2021-47=
497-449e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 69aba79 ("nvmem: Add a simple NVMEM framework for
consumers") in v4.3-rc1.
Fixed in  v5.15-rc6.

Fixed status
cip/4.4: [abcb8d33e4d2215ccde5ab5ccf9f730a59d79d97]
cip/4.4-rt: [abcb8d33e4d2215ccde5ab5ccf9f730a59d79d97]
cip/4.4-st: [abcb8d33e4d2215ccde5ab5ccf9f730a59d79d97]
mainline: [5d388fa01fa6eb310ac023a363a6cb216d9d8fe9]
stable/4.19: [eb0fc8e7170e61eaf65d28dee4a8baf4e86b19ca]
stable/4.4: [abcb8d33e4d2215ccde5ab5ccf9f730a59d79d97]
stable/5.10: [57e48886401b14cd351423fabfec2cfd18df4f66]
stable/5.4: [0594f1d048d8dc338eb9a240021b1d00ae1eb082]

CVE-2021-47498: dm rq: don't queue request to blk-mq during DM suspend

Announce: https://lore.kernel.org/linux-cve-announce/2024052243-CVE-2021-47=
498-dc02@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in  v5.15-rc6.
It seems as if 4.x and 5.4 may be affected. however, the const value
BLK_STS_RESOURCE was added by
commit 2a842aca ("block: introduce new block status code type") in 4.13-rc1=
.

Fixed status
mainline: [b4459b11e84092658fa195a2587aff3b9637f0e7]

CVE-2024-36010: igb: Fix string truncation warnings in igb_set_fw_version

Announce: https://lore.kernel.org/linux-cve-announce/2024052237-CVE-2024-36=
010-c98b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1978d3e ("intel: fix string truncation warnings")
in v6.7-rc1.
Fixed in  v6.8-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c56d055893cbe97848611855d1c97d0ab171eccc]

CVE-2024-36011: Bluetooth: HCI: Fix potential null-ptr-deref

Announce: https://lore.kernel.org/linux-cve-announce/2024052312-CVE-2024-36=
011-2a8b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f777d88 (Bluetooth: ISO: Notify user space about
failed bis connections) in v6.6-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2706004a1b8b526592e823d7e52551b518a7941]
stable/6.6: [1f7ebb69c1d65732bcac2fda9d15421f76f01e81]
stable/6.8: [9f3be61f55d4eedc20eedc56c0f04a5ce2b4a55a]

CVE-2024-36012: Bluetooth: msft: fix slab-use-after-free in msft_do_close()

Announce: https://lore.kernel.org/linux-cve-announce/2024052314-CVE-2024-36=
012-3062@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bf6a4e3 ("Bluetooth: disable advertisement
filters during suspend") in v5.12-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10f9f426ac6e752c8d87bf4346930ba347aaabac]
stable/6.1: [e3880b531b68f98d3941d83f2f6dd11cf4fd6b76]
stable/6.6: [a85a60e62355e3bf4802dead7938966824b23940]
stable/6.8: [4f1de02de07748da80a8178879bc7a1df37fdf56]

CVE-2024-36013: Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect(=
)

Announce: https://lore.kernel.org/linux-cve-announce/2024052314-CVE-2024-36=
013-0c90@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 73ffa90 ("Bluetooth: Move conf_{req,rsp} stuff to
struct l2cap_chan") in v3.0-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d7b41c0e43995b0e992b9f8903109275744b658]

CVE-2021-47499: iio: accel: kxcjk-1013: Fix possible memory leak in
probe and remove

Announce: https://lore.kernel.org/linux-cve-announce/2024052447-CVE-2021-47=
499-bf2e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a25691c ("iio: accel: kxcjk1013: allow using an
external trigger") in v4.2-rc1.
Fixed in v5.16-rc5.

Fixed status
cip/4.4: [8c1d43f3a3fc7184c42d7398bdf59a2a2903e4fc]
cip/4.4-rt: [8c1d43f3a3fc7184c42d7398bdf59a2a2903e4fc]
cip/4.4-st: [8c1d43f3a3fc7184c42d7398bdf59a2a2903e4fc]
mainline: [70c9774e180d151abaab358108e3510a8e615215]
stable/4.19: [a3730f74159ad00a28960c0efe2a931fe6fe6b45]
stable/4.4: [8c1d43f3a3fc7184c42d7398bdf59a2a2903e4fc]
stable/5.10: [ee86d0bad80bdcd11a87e188a596727f41b62320]
stable/5.15: [14508fe13b1c578b3d2ba574f1d48b351975860c]
stable/5.4: [8c163a14277115ca962103910ab4cce55e862ffb]

CVE-2021-47500: iio: mma8452: Fix trigger reference couting

Announce: https://lore.kernel.org/linux-cve-announce/2024052450-CVE-2021-47=
500-3c02@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ae6d9ce ("iio: mma8452: Add support for interrupt
driven triggers.") in v4.2-rc1.
Fixed in v5.16-rc5.

Fixed status
cip/4.4: [094d513b78b1714113bc016684b8142382e071ba]
cip/4.4-rt: [094d513b78b1714113bc016684b8142382e071ba]
cip/4.4-st: [094d513b78b1714113bc016684b8142382e071ba]
mainline: [cd0082235783f814241a1c9483fb89e405f4f892]
stable/4.19: [f5deab10ced368c807866283f8b79144c4823be8]
stable/4.4: [094d513b78b1714113bc016684b8142382e071ba]
stable/5.10: [db12d95085367de8b0223929d1332731024441f1]
stable/5.15: [c43517071dfc9fce34f8f69dbb98a86017f6b739]
stable/5.4: [acf0088ac073ca6e7f4cad6acac112177e08df5e]

CVE-2021-47501: i40e: Fix NULL pointer dereference in i40e_dbg_dump_desc

Announce: https://lore.kernel.org/linux-cve-announce/2024052450-CVE-2021-47=
501-e183@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 02e9c29 ("i40e: debugfs interface") in v3.12-rc1.
Fixed in v5.16-rc5.

Fixed status
mainline: [23ec111bf3549aae37140330c31a16abfc172421]
stable/5.10: [e5b7fb2198abc50058f1a29c395b004f76ab1c83]
stable/5.15: [16431e442db248ecd8aa9457cf0a656f1885f56e]

CVE-2021-47502: ASoC: codecs: wcd934x: handle channel mappping list correct=
ly

Announce: https://lore.kernel.org/linux-cve-announce/2024052451-CVE-2021-47=
502-8650@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a70d924 ("ASoC: wcd934x: add capture dapm
widgets") in v5.6-rc1.
Introduced by commit dd9eb19 ("ASoC: wcd934x: add playback dapm
widgets") in v5.6-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23ba28616d3063bd4c4953598ed5e439ca891101]
stable/5.10: [1089dac26c6b4b833323ae6c0ceab29fb30ede72]
stable/5.15: [339ffb5b56005582aacc860524d2d208604049d1]

CVE-2021-47503: scsi: pm80xx: Do not call scsi_remove_host() in pm8001_allo=
c()

Announce: https://lore.kernel.org/linux-cve-announce/2024052451-CVE-2021-47=
503-b1c2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 05c6c02 ("scsi: pm80xx: Increase number of
supported queues") in v5.10-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [653926205741add87a6cf452e21950eebc6ac10b]
stable/5.10: [1e434d2687e8bc0b3cdc9dd093c0e9047c0b4add]
stable/5.15: [f8dccc1bdea7e21b5ec06c957aef8831c772661c]

CVE-2021-47504: io_uring: ensure task_work gets run as part of cancelations

Announce: https://lore.kernel.org/linux-cve-announce/2024052451-CVE-2021-47=
504-2a5d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc5.
The io_uring feature was introduced in 5.1 so 4.x is not affected.

Fixed status
mainline: [78a780602075d8b00c98070fa26e389b3b3efa72]
stable/5.15: [8e12976c0c19ebc14b60046b1348c516a74c25a2]

CVE-2021-47505: aio: fix use-after-free due to missing POLLFREE handling

Announce: https://lore.kernel.org/linux-cve-announce/2024052452-CVE-2021-47=
505-427f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2c14fa8 ("aio: implement IOCB_CMD_POLL") in v4.18-rc1.
Fixed in v5.16-rc5.

Fixed status
mainline: [50252e4b5e989ce64555c7aef7516bdefc2fea72]
stable/4.19: [321fba81ec034f88aea4898993c1bf15605c023f]
stable/5.10: [47ffefd88abfffe8a040bcc1dd0554d4ea6f7689]
stable/5.15: [60d311f9e6381d779d7d53371f87285698ecee24]
stable/5.4: [4105e6a128e8a98455dfc9e6dbb2ab0c33c4497f]

CVE-2021-47506: nfsd: fix use-after-free due to delegation race

Announce: https://lore.kernel.org/linux-cve-announce/2024052452-CVE-2021-47=
506-c143@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc5.

Fixed status
cip/4.4: [04a8d07f3d58308b92630045560799a3faa3ebce]
cip/4.4-rt: [04a8d07f3d58308b92630045560799a3faa3ebce]
cip/4.4-st: [04a8d07f3d58308b92630045560799a3faa3ebce]
mainline: [548ec0805c399c65ed66c6641be467f717833ab5]
stable/4.19: [2becaa990b93cbd2928292c0b669d3abb6cf06d4]
stable/4.4: [04a8d07f3d58308b92630045560799a3faa3ebce]
stable/5.10: [eeb0711801f5e19ef654371b627682aed3b11373]
stable/5.15: [148c816f10fd11df27ca6a9b3238cdd42fa72cd3]
stable/5.4: [e0759696de6851d7536efddfdd2dfed4c4df1f09]

CVE-2021-47507: nfsd: Fix nsfd startup race (again)

Announce: https://lore.kernel.org/linux-cve-announce/2024052452-CVE-2021-47=
507-e722@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bd5ae92 ("nfsd: register pernet ops last,
unregister first") in v5.12-rc1.
Fixed in v5.16-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [b10252c7ae9c9d7c90552f88b544a44ee773af64]
stable/5.10: [c520943a00ad5015704969ad3304c956bcd49d25]
stable/5.15: [8bf902fee5893cfc2f04a698abab47629699ae9a]
stable/5.4: [f5734b1714ca355703e9ea8fb61d04beff1790b9]

CVE-2021-47508: btrfs: free exchange changeset on failures

Announce: https://lore.kernel.org/linux-cve-announce/2024052453-CVE-2021-47=
508-1a19@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da5e817d9d75422eaaa05490d0b9a5e328fc1a51]
stable/5.15: [ca06c5cb1b6dbfe67655b33c02fc394d65824519]

CVE-2021-47509: ALSA: pcm: oss: Limit the period size to 16MB

Announce: https://lore.kernel.org/linux-cve-announce/2024052429-CVE-2021-47=
509-a210@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc5.

Fixed status
cip/4.4: [d1bb703ad050de9095f10b2d3416c32921ac6bcc]
cip/4.4-rt: [d1bb703ad050de9095f10b2d3416c32921ac6bcc]
cip/4.4-st: [d1bb703ad050de9095f10b2d3416c32921ac6bcc]
mainline: [8839c8c0f77ab8fc0463f4ab8b37fca3f70677c2]
stable/4.19: [2e54cf6794bf82a54aaefc78da13819aea9cd28a]
stable/4.4: [d1bb703ad050de9095f10b2d3416c32921ac6bcc]
stable/5.10: [ad45babf7886e7a212ee1d5eda9ef49f696db43c]
stable/5.15: [35a3e511032146941085f87dd9fb5b82ea5c00a2]
stable/5.4: [76f19e4cbb548e28547f8c328aa0bfb3a10222d3]

CVE-2021-47510: btrfs: fix re-dirty process of tree-log nodes

Announce: https://lore.kernel.org/linux-cve-announce/2024052430-CVE-2021-47=
510-7c3f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d357515 ("btrfs: zoned: redirty released extent
buffers") in v5.12-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84c25448929942edacba905cecc0474e91114e7a]
stable/5.15: [477675049ca803aa95ff77468ffbddd966b415b0]

CVE-2021-47511: ALSA: pcm: oss: Fix negative period/buffer sizes

Announce: https://lore.kernel.org/linux-cve-announce/2024052430-CVE-2021-47=
511-7bec@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc5.

Fixed status
cip/4.4: [be8869d388593e57223ad39297c8e54be632f2f2]
cip/4.4-rt: [be8869d388593e57223ad39297c8e54be632f2f2]
cip/4.4-st: [be8869d388593e57223ad39297c8e54be632f2f2]
mainline: [9d2479c960875ca1239bcb899f386970c13d9cfe]
stable/4.19: [f96c0959c1ee92adc911c10d6ec209af50105049]
stable/4.4: [be8869d388593e57223ad39297c8e54be632f2f2]
stable/5.10: [02b2b691b77cd7b951fa7b6c9d44d4e472cdc823]
stable/5.15: [00a860678098fcd9fa8db2b5fb9d2ddf4776d4cc]
stable/5.4: [f12c8a7515f641885677960af450082569a87243]

CVE-2021-47512: net/sched: fq_pie: prevent dismantle issue

Announce: https://lore.kernel.org/linux-cve-announce/2024052430-CVE-2021-47=
512-4d70@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ec97ecf ("net: sched: add Flow Queue PIE packet
scheduler") in v5.6-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61c2402665f1e10c5742033fce18392e369931d7]
stable/5.10: [2a51edaf5cc563574878b93d7ef3d5955dda7030]
stable/5.15: [d86216dfda7c98375f809e26a30bfdaaba21d46e]

CVE-2021-47513: net: dsa: felix: Fix memory leak in felix_setup_mmio_filter=
ing

Announce: https://lore.kernel.org/linux-cve-announce/2024052430-CVE-2021-47=
513-c6d0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8d5f795 ("net: dsa: felix: break at first CPU
port during init and teardown") in v5.15-rc6.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8b1d7698038e76363859fb47ae0a262080646f5]
stable/5.15: [973a0373e88cc19129bd6ef0ec193040535397d9]

CVE-2021-47514: devlink: fix netns refcount leak in devlink_nl_cmd_reload()

Announce: https://lore.kernel.org/linux-cve-announce/2024052431-CVE-2021-47=
514-9975@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ccdf072 ("devlink: Add reload action option to
devlink reload command") in v5.10-rc1.
Introduced by commit dc64cc7 ("devlink: Add devlink reload limit
option") in v5.10-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dbb0dad8e63fcd0b5a117c2861d2abe7ff5f186]
stable/5.10: [4b7e90672af8e0c78205db006f1b0a20ebd07f5f]
stable/5.15: [fe30b70ca84da9c4aca85c03ad86e7a9b89c5ded]

CVE-2021-47515: seg6: fix the iif in the IPv6 socket control block

Announce: https://lore.kernel.org/linux-cve-announce/2024052431-CVE-2021-47=
515-5c06@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ef48974 ("ipv6: sr: clear IP6CB(skb) on SRH
ip4ip6 encapsulation") in v5.0-rc6.
Fixed in v5.16-rc5.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [ae68d93354e5bf5191ee673982251864ea24dd5c]
stable/4.19: [6431e71093f3da586a00c6d931481ffb0dc2db0e]
stable/5.10: [666521b3852d2b2f52d570f9122b1e4b50d96831]
stable/5.15: [98adb2bbfa407c9290bda299d4c6f7a1c4ebd5e1]
stable/5.4: [ef8804e47c0a44ae106ead1740408af5ea6c6ee9]

CVE-2021-47516: nfp: Fix memory leak in nfp_cpp_area_cache_add()

Announce: https://lore.kernel.org/linux-cve-announce/2024052431-CVE-2021-47=
516-29dd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4cb584e ("nfp: add CPP access core") in v4.11-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c56c96303e9289cc34716b1179597b6f470833de]
stable/4.19: [eb51f639ef3fd5498b7def290ed8681b6aadd9a7]
stable/5.10: [484069b5de9d223cc1c64c6f80389a99cfef51f1]
stable/5.15: [f707820c09239d6f67699d9b2ff57863cc7905b0]
stable/5.4: [2e0e072e62fdaf7816220af08e05c020f0fcb77a]

CVE-2021-47517: ethtool: do not perform operations on net devices
being unregistered

Announce: https://lore.kernel.org/linux-cve-announce/2024052432-CVE-2021-47=
517-df40@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 041b1c5 ("ethtool: helper functions for netlink
interface") in v5.6-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dde91ccfa25fd58f64c397d91b81a4b393100ffa]
stable/5.10: [7c26da3be1e9843a15b5318f90db8a564479d2ac]
stable/5.15: [cfd719f04267108f5f5bf802b9d7de69e99a99f9]

CVE-2021-47518: nfc: fix potential NULL pointer deref in nfc_genl_dump_ses_=
done

Announce: https://lore.kernel.org/linux-cve-announce/2024052432-CVE-2021-47=
518-632d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ac22ac4 ("NFC: Add a GET_SE netlink API") in v3.12-rc1=
.
Fixed in v5.16-rc5.

Fixed status
cip/4.4: [87cdb8789c38e44ae5454aafe277997c950d00ed]
cip/4.4-rt: [87cdb8789c38e44ae5454aafe277997c950d00ed]
cip/4.4-st: [87cdb8789c38e44ae5454aafe277997c950d00ed]
mainline: [4cd8371a234d051f9c9557fcbb1f8c523b1c0d10]
stable/4.19: [3b861a40325eac9c4c13b6c53874ad90617e944d]
stable/4.4: [87cdb8789c38e44ae5454aafe277997c950d00ed]
stable/5.10: [83ea620a1be840bf05089a5061fb8323ca42f38c]
stable/5.15: [fae9705d281091254d4a81fa2da9d22346097dca]
stable/5.4: [48fcd08fdbe05e35b650a252ec2a2d96057a1c7a]

CVE-2021-47519: can: m_can: m_can_read_fifo: fix memory leak in error branc=
h

Announce: https://lore.kernel.org/linux-cve-announce/2024052432-CVE-2021-47=
519-ed69@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e393817 ("can: m_can: Disable IRQs on FIFO bus
errors") in v5.15-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31cb32a590d62b18f69a9a6d433f4e69c74fdd56]
stable/5.15: [75a422165477dd12d2d20aa7c9ee7c9a281c9908]

CVE-2021-47520: can: pch_can: pch_can_rx_normal: fix use after free

Announce: https://lore.kernel.org/linux-cve-announce/2024052433-CVE-2021-47=
520-af45@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b21d18b ("can: Topcliff: Add PCH_CAN driver.") in
v2.6.37-rc1.
Fixed in v5.16-rc5.

Fixed status
cip/4.4: [bafe343a885c70dddf358379cf0b2a1c07355d8d]
cip/4.4-rt: [bafe343a885c70dddf358379cf0b2a1c07355d8d]
cip/4.4-st: [bafe343a885c70dddf358379cf0b2a1c07355d8d]
mainline: [94cddf1e9227a171b27292509d59691819c458db]
stable/4.19: [3e193ef4e0a3f5bf92ede83ef214cb09d01b00aa]
stable/4.4: [bafe343a885c70dddf358379cf0b2a1c07355d8d]
stable/5.10: [703dde112021c93d6e89443c070e7dbd4dea612e]
stable/5.15: [6c73fc931658d8cbc8a1714b326cb31eb71d16a7]
stable/5.4: [abb4eff3dcd2e583060082a18a8dbf31f02689d4]

CVE-2021-47521: can: sja1000: fix use after free in ems_pcmcia_add_card()

Announce: https://lore.kernel.org/linux-cve-announce/2024052433-CVE-2021-47=
521-8637@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fd734c6 ("can/sja1000: add driver for EMS PCMCIA
card") in v3.2-rc1.
Fixed in v5.16-rc5.

Fixed status
cip/4.4: [cbd86110546f7f730a1f5d7de56c944a336c15c4]
cip/4.4-rt: [cbd86110546f7f730a1f5d7de56c944a336c15c4]
cip/4.4-st: [cbd86110546f7f730a1f5d7de56c944a336c15c4]
mainline: [3ec6ca6b1a8e64389f0212b5a1b0f6fed1909e45]
stable/4.19: [ccf070183e4655824936c0f96c4a2bcca93419aa]
stable/4.4: [cbd86110546f7f730a1f5d7de56c944a336c15c4]
stable/5.10: [923f4dc5df679f678e121c20bf2fd70f7bf3e288]
stable/5.15: [474f9a8534f5f89841240a7e978bafd6e1e039ce]
stable/5.4: [1a295fea90e1acbe80c6d4940f5ff856edcd6bec]

CVE-2021-47522: HID: bigbenff: prevent null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052433-CVE-2021-47=
522-ad59@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc5.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [918aa1ef104d286d16b9e7ef139a463ac7a296f0]
stable/5.10: [6272b17001e6fdcf7b4a16206287010a1523fa6e]
stable/5.15: [58f15f5ae7786c824868f3a7e093859b74669ce7]
stable/5.4: [8e0ceff632f48175ec7fb4706129c55ca8a7c7bd]

CVE-2021-47523: IB/hfi1: Fix leak of rcvhdrtail_dummy_kvaddr

Announce: https://lore.kernel.org/linux-cve-announce/2024052433-CVE-2021-47=
523-6f3a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 46b010d ("staging/rdma/hfi1: Workaround to
prevent corruption during packet delivery") in v4.5-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60a8b5a1611b4a26de4839ab9c1fc2a9cf3e17c1]
stable/5.10: [2c08271f4ed0e24633b3f81ceff61052b9d45efc]
stable/5.15: [834d0fb978643eaf09da425de197cc16a7c2761b]

CVE-2021-47524: serial: liteuart: fix minor-number leak on probe errors

Announce: https://lore.kernel.org/linux-cve-announce/2024052434-CVE-2021-47=
524-7fd0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da81e5 ("drivers/tty/serial: add LiteUART
driver") in v5.11-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd5e90b16cca8a697cbe17b72e2a5f49291cabb2]
stable/5.15: [888fc81107cacd2a4f681bac7bb785cef868214f]

CVE-2021-47525: serial: liteuart: fix use-after-free and memleak on unbind

Announce: https://lore.kernel.org/linux-cve-announce/2024052434-CVE-2021-47=
525-2b58@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da81e5 ("drivers/tty/serial: add LiteUART
driver") in v5.11-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05f929b395dec8957b636ff14e66b277ed022ed9]
stable/5.15: [602824cf9aa9db8830ffe5cfb2cd54365cada4fe]

CVE-2021-47526: serial: liteuart: Fix NULL pointer dereference in ->remove(=
)

Announce: https://lore.kernel.org/linux-cve-announce/2024052434-CVE-2021-47=
526-7f02@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da81e5 ("drivers/tty/serial: add LiteUART
driver") in v5.11-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f55f89d98c8b3e12b4f55f71c127a173e29557c]
stable/5.15: [189c99c629bbf85916c02c153f904649cc0a9d7f]

CVE-2021-47527: serial: core: fix transmit-buffer reset and memleak

Announce: https://lore.kernel.org/linux-cve-announce/2024052435-CVE-2021-47=
527-e6f5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 761ed4a ("tty: serial_core: convert uart_close to
use tty_port_close") in v4.9-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00de977f9e0aa9760d9a79d1e41ff780f74e3424]
stable/4.19: [1179b168fa3f3a6aae3bd140000455a0e58457db]
stable/5.10: [e1722acf4f0d4d67b60f57e08ce16f8b66cd4b8f]
stable/5.15: [64e491c1634b73d3bddc081d08620bdc92ab2c12]
stable/5.4: [c5da8aa441053958594f94254592bb41264bdfbf]

CVE-2021-47528: usb: cdnsp: Fix a NULL pointer dereference in
cdnsp_endpoint_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024052435-CVE-2021-47=
528-da4e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3d82904 ("usb: cdnsp: cdns3 Add main part of
Cadence USBSSP DRD Driver") in v5.12-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37307f7020ab38dde0892a578249bf63d00bca64]
stable/5.15: [7d94bc8e335cb33918e52efdbe192c36707bfa24]

CVE-2021-47529: iwlwifi: Fix memory leaks in error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024052435-CVE-2021-47=
529-a476@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9dad325 ("iwlwifi: support loading the reduced
power table from UEFI") in v5.14-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a571bc28326d9f3e13f5f2d9cda2883e0631b0ce]
stable/5.15: [4768935c25403ba96e7a745645df24a51a774b7e]

CVE-2021-47530: drm/msm: Fix wait_fence submitqueue leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052436-CVE-2021-47=
530-08d5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a61acbb ("drm/msm: Track "seqno" fences by idr")
in v5.15-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea0006d390a28012f8187717aea61498b2b341e5]
stable/5.15: [4c3cdbf2540319ea674f1f3c54f31f14c6f39647]

CVE-2021-47531: drm/msm: Fix mmap to include VM_IO and VM_DONTDUMP

Announce: https://lore.kernel.org/linux-cve-announce/2024052436-CVE-2021-47=
531-3ab6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 510410b ("drm/msm: Implement mmap as GEM object
function") in v5.15-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3466d9e217b337bf473ee629c608e53f9f3ab786]
stable/5.15: [8e2b7fe5e8a4be5e571561d9afcfbd92097288ba]

CVE-2021-47532: drm/msm/devfreq: Fix OPP refcnt leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052436-CVE-2021-47=
532-9eaf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9bc9557 ("drm/msm: Devfreq tuning") in v5.15-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59ba1b2b4825342676300f66d785764be3fcb093]
stable/5.15: [a4eb55901df1dce8c6944438bbdf57caf08911e2]

CVE-2021-47533: drm/vc4: kms: Clear the HVS FIFO commit pointer once done

Announce: https://lore.kernel.org/linux-cve-announce/2024052436-CVE-2021-47=
533-a03a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9ec03d7 ("drm/vc4: kms: Wait on previous FIFO
users before a commit") in v5.12-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d134c5ff71c7f2320fc7997f2fbbdedf0c76889a]
stable/5.15: [2931db9a5ed219546cf2ae0546698faf78281b89]

CVE-2021-47534: drm/vc4: kms: Add missing drm_crtc_commit_put

Announce: https://lore.kernel.org/linux-cve-announce/2024052437-CVE-2021-47=
534-ef5f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9ec03d7 ("drm/vc4: kms: Wait on previous FIFO
users before a commit") in v5.12-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [049cfff8d53a30cae3349ff71a4c01b7d9981bc2]
stable/5.15: [53f9601e908d42481addd67cdb01a9288c611124]

CVE-2021-47535: drm/msm/a6xx: Allocate enough space for GMU registers

Announce: https://lore.kernel.org/linux-cve-announce/2024052437-CVE-2021-47=
535-41d3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 142639a ("drm/msm/a6xx: fix crashstate capture
for A650") in v5.9-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4d25abf9720b69a03465b09d0d62d1998ed6708]
stable/5.10: [d646856a600e8635ba498f20b194219b158626e8]
stable/5.15: [83e54fcf0b14ca2d869dd37abe1bb6542805f538]

CVE-2021-47536: net/smc: fix wrong list_del in smc_lgr_cleanup_early

Announce: https://lore.kernel.org/linux-cve-announce/2024052437-CVE-2021-47=
536-fa00@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a0a62ee ("net/smc: separate locks for SMCD and
SMCR link group lists") in v5.5-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [789b6cc2a5f9123b9c549b886fdc47c865cfe0ba]
stable/5.10: [77731fede297a23d26f2d169b4269466b2c82529]
stable/5.15: [95518fe354d712dca6f431cf2a11b8f63bc9a66c]

CVE-2021-47537: octeontx2-af: Fix a memleak bug in rvu_mbox_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024052438-CVE-2021-47=
537-015c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 98c5611 (=E2=80=9Cocteontx2-af: cn10k: Add mbox suppor=
t
for CN10K platform=E2=80=9D) in v5.12-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e07a097b4986afb8f925d0bb32612e1d3e88ce15]
stable/5.15: [1c0ddef45b7e3dbe3ed073695d20faa572b7056a]

CVE-2021-47538: rxrpc: Fix rxrpc_local leak in rxrpc_lookup_peer()

Announce: https://lore.kernel.org/linux-cve-announce/2024052438-CVE-2021-47=
538-5639@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9ebedde ("rxrpc: rxrpc_peer needs to hold a ref
on the rxrpc_local record") in v5.4-rc4.
Fixed in v5.16-rc4.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [beacff50edbd6c9659a6f15fc7f6126909fade29]
stable/4.19: [913c24af2d13a3fd304462916ee98e298d56bdce]
stable/5.10: [60f0b9c42cb80833a03ca57c1c8b078d716e71d1]
stable/5.15: [9469273e616ca8f1b6e3773c5019f21b4c8d828c]
stable/5.4: [3e70e3a72d80b16094faccbe438cd53761c3503a]

CVE-2021-47539: rxrpc: Fix rxrpc_peer leak in rxrpc_look_up_bundle()

Announce: https://lore.kernel.org/linux-cve-announce/2024052438-CVE-2021-47=
539-f0a6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 245500d ("rxrpc: Rewrite the client connection
manager") in v5.10-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca77fba821351190777b236ce749d7c4d353102e]
stable/5.10: [35b40f724c4ef0f683d94dab3af9ab38261d782b]
stable/5.15: [bc97458620e38961af9505cc060ad4cf5c9e4af7]

CVE-2021-47540: mt76: mt7915: fix NULL pointer dereference in
mt7915_get_phy_mode

Announce: https://lore.kernel.org/linux-cve-announce/2024052439-CVE-2021-47=
540-3bea@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 37f4ca9 ("mt76: mt7915: register per-phy HE
capabilities for each interface") in v5.8-rc1.
Introduced by commit e57b790 ("mt76: add mac80211 driver for MT7915
PCIe-based chipsets") in v5.8-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e53d6d26920d5221d3f4d4f5ffdd629ea69aa5c]
stable/5.10: [932b338f4e5c4cb0c2ed640da3bced1e63620198]
stable/5.15: [14b03b8cebdf18ff13c39d58501b625411314de2]

CVE-2021-47541: net/mlx4_en: Fix an use-after-free bug in
mlx4_en_try_alloc_resources()

Announce: https://lore.kernel.org/linux-cve-announce/2024052439-CVE-2021-47=
541-c3da@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ec25bc0 ("net/mlx4_en: Add resilience in low
memory systems") in v4.7.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [addad7643142f500080417dd7272f49b7a185570]
stable/4.19: [676dc7d9b15bf8733233a2db1ec3f9091ab34275]
stable/5.10: [f1d43efa59f1edd3e7eca0e94559b4c6b1cd4e2b]
stable/5.15: [75917372eef0dbfb290ae45474314d35f97aea18]
stable/5.4: [e461a9816a1ac5b4aeb61621b817225b61e46a68]

CVE-2021-47542: net: qlogic: qlcnic: Fix a NULL pointer dereference in
qlcnic_83xx_add_rings()

Announce: https://lore.kernel.org/linux-cve-announce/2024052439-CVE-2021-47=
542-125d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7f96645 ("qlcnic: 83xx memory map and HW access
routine") in v3.9-rc1.
Fixed in v5.16-rc4.

Fixed status
cip/4.4: [3a061d54e260b701b538873b43e399d9b8b83e03]
cip/4.4-rt: [3a061d54e260b701b538873b43e399d9b8b83e03]
cip/4.4-st: [3a061d54e260b701b538873b43e399d9b8b83e03]
mainline: [e2dabc4f7e7b60299c20a36d6a7b24ed9bf8e572]
stable/4.19: [57af54a56024435d83e44c78449513b414eb6edf]
stable/4.4: [3a061d54e260b701b538873b43e399d9b8b83e03]
stable/5.10: [15fa12c119f869173f9b710cbe6a4a14071d2105]
stable/5.15: [c5ef33c1489b2cd74368057fa00b5d2183bb5853]
stable/5.4: [bbeb0325a7460ebf1e03f5e0bfc5c652fba9519f]

CVE-2021-47543: perf report: Fix memory leaks around perf_tip()

Announce: https://lore.kernel.org/linux-cve-announce/2024052439-CVE-2021-47=
543-a01a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9fc706108c15f8bc2d4ccccf8e50f74830fabd9]
stable/5.10: [ff061b5bda73c4f785b4703eeb0848fd99e5608a]
stable/5.15: [71e284dcebecb9fd204ff11097469cc547723ad1]
stable/5.4: [df5990db088d4c7fea9a2f9b8195a7859e1768c4]

CVE-2021-47544: tcp: fix page frag corruption on page fault

Announce: https://lore.kernel.org/linux-cve-announce/2024052440-CVE-2021-47=
544-ceb5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5640f76 ("net: use a per task frag allocator") in v3.7=
-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dacb5d8875cc6cd3a553363b4d6f06760fcbe70c]
stable/5.10: [c6f340a331fb72e5ac23a083de9c780e132ca3ae]
stable/5.15: [5a9afcd827cafe14a95c9fcbded2c2d104f18dfc]

CVE-2021-47545: perf hist: Fix memory leak of a perf_hpp_fmt

Announce: https://lore.kernel.org/linux-cve-announce/2024052440-CVE-2021-47=
545-0f72@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc2.
It seems as if this bug was commit 564132f ("perf hists: Properly
release format fields") in 4.6-rc1.

Fixed status
mainline: [0ca1f534a776cc7d42f2c33da4732b74ec2790cd]
stable/4.19: [24a139c105fa0f7f99888cf328bf6a02fc841675]
stable/5.10: [a4c17ebdd6249cb4e061358d3693383f6628e069]
stable/5.15: [5b5c6f57a1f81499db4c8ea597898cb1b87de0b6]
stable/5.4: [b380d09e44e8479e71e3ae8446b515a5b3166244]

CVE-2021-47546: ipv6: fix memory leak in fib6_rule_suppress

Announce: https://lore.kernel.org/linux-cve-announce/2024052440-CVE-2021-47=
546-f25b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ca7a03c ("ipv6: do not free rt if
FIB_LOOKUP_NOREF is set on suppress rule") in v5.4-rc1.
Fixed in v5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cdef485217d30382f3bf6448c54b4401648fe3f1]
stable/5.10: [209d35ee34e25f9668c404350a1c86d914c54ffa]
stable/5.15: [8ef8a76a340ebdb2c2eea3f6fb0ebbed09a16383]
stable/5.4: [ee38eb8cf9a7323884c2b8e0adbbeb2192d31e29]

CVE-2021-47547: net: tulip: de4x5: fix the problem that the array
'lp->phy[8]' may be out of bound

Announce: https://lore.kernel.org/linux-cve-announce/2024052441-CVE-2021-47=
547-f3e7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc2.

Fixed status
cip/4.4: [ec5bd0aef1cec96830d0c7e06d3597d9e786cc98]
cip/4.4-rt: [ec5bd0aef1cec96830d0c7e06d3597d9e786cc98]
cip/4.4-st: [ec5bd0aef1cec96830d0c7e06d3597d9e786cc98]
mainline: [61217be886b5f7402843677e4be7e7e83de9cb41]
stable/4.19: [2c1a6a9a011d622a7c61324a97a49801ba425eff]
stable/4.4: [ec5bd0aef1cec96830d0c7e06d3597d9e786cc98]
stable/5.10: [f059fa40f0fcc6bc7a12e0f2a2504e9a4ff74f1f]
stable/5.15: [12f907cb11576b8cd0b1d95a16d1f10ed5bb7237]
stable/5.4: [77ff166909458646e66450e42909e0adacc99049]

CVE-2021-47548: ethernet: hisilicon: hns: hns_dsaf_misc: fix a
possible array overflow in hns_dsaf_ge_srst_by_port()

Announce: https://lore.kernel.org/linux-cve-announce/2024052441-CVE-2021-47=
548-e9c0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a66998e0fbf213d47d02813b9679426129d0d114]
stable/4.19: [dd07f8971b81ad98cc754b179b331b57f35aa1ff]
stable/5.10: [22519eff7df2d88adcc2568d86046ce1e2b52803]
stable/5.15: [fc7ffa7f10b9454a86369405d9814bf141b30627]
stable/5.4: [99bb25cb6753beaf2c2bc37927c2ecc0ceff3f6d]

CVE-2021-47549: sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl

Announce: https://lore.kernel.org/linux-cve-announce/2024052441-CVE-2021-47=
549-5aac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit faf0b2e ("drivers/ata: add support to Freescale
3.0Gbps SATA Controller") in v2.6.24-rc1.
Fixed in v5.16-rc4.

Fixed status
cip/4.4: [cdcd80292106df5cda325426e96495503e41f947]
cip/4.4-rt: [cdcd80292106df5cda325426e96495503e41f947]
cip/4.4-st: [cdcd80292106df5cda325426e96495503e41f947]
mainline: [6c8ad7e8cf29eb55836e7a0215f967746ab2b504]
stable/4.19: [0769449b0a5eabc3545337217ae690e46673e73a]
stable/4.4: [cdcd80292106df5cda325426e96495503e41f947]
stable/5.10: [4a46b2f5dce02539e88a300800812bd24a45e097]
stable/5.15: [adf098e2a8a1e1fc075d6a5ba2edd13cf7189082]
stable/5.4: [77393806c76b6b44f1c44bd957788c8bd9152c45]

CVE-2021-47550: drm/amd/amdgpu: fix potential memleak

Announce: https://lore.kernel.org/linux-cve-announce/2024052442-CVE-2021-47=
550-a5e1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27dfaedc0d321b4ea4e10c53e4679d6911ab17aa]
stable/5.10: [c746945fb6bcbe3863c9ea6369c7ef376e38e5eb]
stable/5.15: [75752ada77e0726327adf68018b9f50ae091baeb]

CVE-2021-47551: drm/amd/amdkfd: Fix kernel panic when reset failed and
been triggered again

Announce: https://lore.kernel.org/linux-cve-announce/2024052442-CVE-2021-47=
551-0318@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc2.
It seems as if this bug was introduced by commit d95e8e ("drm/amdgpu:
refine create and release logic of hive info") in 5.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cf49e00d40d5132e3d067b5aa6d84791929ab15]
stable/5.10: [74aafe99efb68f15e50be9f7032c2168512f98a8]
stable/5.15: [06c6f8f86ec243b89e52f0c3dc7062bcb9de74df]

CVE-2021-47552: blk-mq: cancel blk-mq dispatch work in both
blk_cleanup_queue and disk_release()

Announce: https://lore.kernel.org/linux-cve-announce/2024052442-CVE-2021-47=
552-99f3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a19b28f7929866e1cec92a3619f4de9f2d20005]
stable/5.15: [e03513f58919d9e2bc6df765ca2c9da863d03d90]

CVE-2021-47553: sched/scs: Reset task stack state in bringup_cpu()

Announce: https://lore.kernel.org/linux-cve-announce/2024052442-CVE-2021-47=
553-1026@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f1a0a37 ("sched/core: Initialize the idle task
with preemption disabled") in v5.14-rc1.
Fixed in v5.16-rc3.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [dce1ca0525bfdc8a69a9343bc714fbc19a2f04b3]
stable/5.10: [e6ee7abd6bfe559ad9989004b34c320fd638c526]
stable/5.15: [229c555260cb9c1ccdab861e16f0410f1718f302]

CVE-2021-47554: vdpa_sim: avoid putting an uninitialized iova_domain

Announce: https://lore.kernel.org/linux-cve-announce/2024052443-CVE-2021-47=
554-f8a6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4080fc1 ("vdpa_sim: use iova module to allocate
IOVA addresses") in v5.13-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb93ce4b150dde79f58e34103cbd1fe829796649]
stable/5.15: [e4d58ac67e63727aa45a4a26185876f598e8b3dd]

CVE-2021-47555: net: vlan: fix underflow for the real_dev refcnt

Announce: https://lore.kernel.org/linux-cve-announce/2024052443-CVE-2021-47=
555-3043@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 563bcba ("net: vlan: fix a UAF in
vlan_dev_real_dev()") in 5.16-rc1. Fixed in  5,16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01d9cc2dea3fde3bad6d27f464eff463496e2b00]
stable/5.10: [6e800ee43218a56acc93676bbb3d93b74779e555]
stable/5.15: [f7fc72a508cf115c273a7a29350069def1041890]
stable/5.4: [5e44178864b38dd70b877985abd7d86fdb95f27d]

CVE-2021-47556: ethtool: ioctl: fix potential NULL deref in
ethtool_set_coalesce()

Announce: https://lore.kernel.org/linux-cve-announce/2024052443-CVE-2021-47=
556-558e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f3ccfda ("ethtool: extend coalesce setting uAPI
with CQE mode") in v5.15-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0276af2176c78771da7f311621a25d7608045827]
stable/5.15: [abfdd9e2f0f9699015d72317f74154d3e53664e6]

CVE-2021-47557: net/sched: sch_ets: don't peek at classes beyond 'nbands'

Announce: https://lore.kernel.org/linux-cve-announce/2024052444-CVE-2021-47=
557-bc88@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit dcc68b4 ("net: sch_ets: Add a new Qdisc") in v5.6-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de6d25924c2a8c2988c6a385990cafbe742061bf]
stable/5.10: [ae2659d2c670252759ee9c823c4e039c0e05a6f2]
stable/5.15: [e25bdbc7e951ae5728fee1f4c09485df113d013c]

CVE-2021-47558: net: stmmac: Disable Tx queues when reconfiguring the inter=
face

Announce: https://lore.kernel.org/linux-cve-announce/2024052444-CVE-2021-47=
558-d713@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5fabb01 ("net: stmmac: Add initial XDP support")
in v5.13-rc1.
Introduced by commit aa042f6 ("net: stmmac: Add support to Ethtool
get/set ring parameters") in v5.10-rc1.
Introduced by commit 0366f7e ("net: stmmac: add ethtool support for
get/set channels") in v5.10-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b270bfe697367776eca2e6759a71d700fb8d82a2]
stable/5.15: [a92f0eebb8dc008b9e8c51c6f7b8c93b27a29a43]

CVE-2021-47559: net/smc: Fix NULL pointer dereferencing in smc_vlan_by_tcps=
k()

Announce: https://lore.kernel.org/linux-cve-announce/2024052450-CVE-2021-47=
559-9909@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cb9d43f ("net/smc: determine vlan_id of stacked
net_device") in v4.18-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [587acad41f1bc48e16f42bb2aca63bf323380be8]
stable/5.10: [c94cbd262b6aa3b54d73a1ed1f9c0d19df57f4ff]
stable/5.15: [bb851d0fb02547d03cd40106b5f2391c4fed6ed1]

CVE-2021-47560: mlxsw: spectrum: Protect driver from buggy firmware

Announce: https://lore.kernel.org/linux-cve-announce/2024052451-CVE-2021-47=
560-4a52@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 28b1987 ("mlxsw: spectrum: Register CPU port with
devlink") in v5.4-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63b08b1f6834bbb0b4f7783bf63b80c8c8e9a047]
stable/5.10: [90d0736876c50ecde1a3275636a06b9ddb1cace9]
stable/5.15: [da4d70199e5d82da664a80077508d6c18f5e76df]

CVE-2021-47561: i2c: virtio: disable timeout handling

Announce: https://lore.kernel.org/linux-cve-announce/2024052451-CVE-2021-47=
561-4a07@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3cfc883 ("i2c: virtio: add a virtio i2c frontend
driver") in v5.15-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84e1d0bf1d7121759622dabf8fbef4c99ad597c5]
stable/5.15: [cc432b0727ce404cc13e8f6b5ce29f412c3f9f1f]

CVE-2021-47562: ice: fix vsi->txq_map sizing

Announce: https://lore.kernel.org/linux-cve-announce/2024052451-CVE-2021-47=
562-52ec@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit efc2214 ("ice: Add support for XDP") in v5.5-rc1.
Introduced by commit 22bf877 ("ice: introduce XDP_TX fallback path")
in v5.16-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [792b2086584f25d84081a526beee80d103c2a913]
stable/5.10: [1eb5395add786613c7c5579d3947aa0b8f0ec241]
stable/5.15: [992ba40a67638dfe2772b84dfc8168dc328d5c4c]

CVE-2021-47563: ice: avoid bpf_prog refcount underflow

Announce: https://lore.kernel.org/linux-cve-announce/2024052452-CVE-2021-47=
563-008a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit efc2214 ("ice: Add support for XDP") in v5.5-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f65ee535df775a13a1046c0a0b2d72db342f8a5b]
stable/5.10: [e65a8707b4cd756d26d246bb2b9fab06eebafac1]
stable/5.15: [1f10b09ccc832698ef4624a6ab9a213b6ccbda76]

CVE-2021-47564: net: marvell: prestera: fix double free issue on err path

Announce: https://lore.kernel.org/linux-cve-announce/2024052452-CVE-2021-47=
564-2e3b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e1189d9 ("net: marvell: prestera: Add Switchdev
driver implementation") in v5.10-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8d032507cb7912baf1d3e0af54516f823befefd]
stable/5.10: [5dca8eff4627315df98feec09fff9dfe3356325e]
stable/5.15: [03e5203d2161a00afe4d97d206d2293e40b2f253]

CVE-2021-47565: scsi: mpt3sas: Fix kernel panic during drive powercycle tes=
t

Announce: https://lore.kernel.org/linux-cve-announce/2024052452-CVE-2021-47=
565-5f60@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f92363d ("[SCSI] mpt3sas: add new driver
supporting 12GB SAS") in v3.8-rc1.
Fixed in v5.16-rc3.

Fixed status
cip/4.4: [5d4d50b1f159a5ebab7617f47121b4370aa58afe]
cip/4.4-rt: [5d4d50b1f159a5ebab7617f47121b4370aa58afe]
cip/4.4-st: [5d4d50b1f159a5ebab7617f47121b4370aa58afe]
mainline: [0ee4ba13e09c9d9c1cb6abb59da8295d9952328b]
stable/4.19: [0d4b29eaadc1f59cec0c7e85eae77d08fcca9824]
stable/4.4: [5d4d50b1f159a5ebab7617f47121b4370aa58afe]
stable/5.10: [2bf9c5a5039c8f4b037236aed505e6a25c1d5f7b]
stable/5.15: [8485649a7655e791a6e4e9f15b4d30fdae937184]
stable/5.4: [7e324f734a914957b8cc3ff4b4c9f0409558adb5]

CVE-2021-47566: proc/vmcore: fix clearing user buffer by properly
using clear_user()

Announce: https://lore.kernel.org/linux-cve-announce/2024052453-CVE-2021-47=
566-12b8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 997c136 ("fs/proc/vmcore.c: add hook to
read_from_oldmem() to check for non-ram pages") in v3.0-rc1.
Fixed in v5.16-rc2.

Fixed status
cip/4.4: [a9e164bd160be8cbee1df70acb379129e3cd2e7c]
cip/4.4-rt: [a9e164bd160be8cbee1df70acb379129e3cd2e7c]
cip/4.4-st: [a9e164bd160be8cbee1df70acb379129e3cd2e7c]
mainline: [c1e63117711977cc4295b2ce73de29dd17066c82]
stable/4.19: [9ef384ed300d1bcfb23d0ab0b487d544444d4b52]
stable/4.4: [a9e164bd160be8cbee1df70acb379129e3cd2e7c]
stable/5.10: [a8a917058faf4abaec9fb614bb6d5f8fe3529ec6]
stable/5.15: [7b3a34f08d11e7f05cd00b8e09adaa15192f0ad1]
stable/5.4: [fd7974c547abfb03072a4ee706d3a6f182266f89]

CVE-2021-47567: powerpc/32: Fix hardlockup on vmap stack overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024052453-CVE-2021-47=
567-b955@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c118c73 ("powerpc/32: Fix vmap stack - Do not
activate MMU before reading task struct") in v5.10-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bb60ea611db1e04814426ed4bd1c95d1487678e]
stable/5.10: [dfe906da9a1abebdebe8b15bb3e66a2578f6c4c7]
stable/5.15: [c4e3ff8b8b1d54f0c755670174c453b06e17114b]

CVE-2021-47568: ksmbd: fix memleak in get_file_stream_info()

Announce: https://lore.kernel.org/linux-cve-announce/2024052453-CVE-2021-47=
568-bf15@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 34061d6 ("ksmbd: validate OutputBufferLength of
QUERY_DIR, QUERY_INFO, IOCTL requests") in v5.15-rc7.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [178ca6f85aa3231094467691f5ea1ff2f398aa8d]
stable/5.15: [11e659827c3a2facb3a04e08cc97ff14d5091f51]

CVE-2021-47569: io_uring: fail cancellation for EXITING tasks

Announce: https://lore.kernel.org/linux-cve-announce/2024052453-CVE-2021-47=
569-2d3a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 89b263f ("io_uring: run linked timeouts from
task_work") in v5.15-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [617a89484debcd4e7999796d693cf0b77d2519de]
stable/5.15: [3d2a1e68fd9904fdc1b02f2e7d40ca47df7ba39f]

CVE-2021-47570: staging: r8188eu: fix a memory leak in rtw_wx_read32()

Announce: https://lore.kernel.org/linux-cve-announce/2024052454-CVE-2021-47=
570-573d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2b42bd5 ("staging: r8188eu: introduce new os_dep
dir for RTL8188eu driver") in v5.15-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be4ea8f383551b9dae11b8dfff1f38b3b5436e9a]
stable/5.15: [c8d3775745adacf9784a7a80a82d047051752573]

CVE-2021-47571: staging: rtl8192e: Fix use after free in
_rtl92e_pci_disconnect()

Announce: https://lore.kernel.org/linux-cve-announce/2024052454-CVE-2021-47=
571-05b5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6689817 ("staging: rtl8192e: Fix unload/reload
problem") in v3.2-rc1.
Fixed in v5.16-rc3.

Fixed status
cip/4.4: [d43aecb694b10db9a4228ce2d38b5ae8de374443]
cip/4.4-rt: [d43aecb694b10db9a4228ce2d38b5ae8de374443]
cip/4.4-st: [d43aecb694b10db9a4228ce2d38b5ae8de374443]
mainline: [b535917c51acc97fb0761b1edec85f1f3d02bda4]
stable/4.19: [bca19bb2dc2d89ce60c4a4a6e59609d4cf2e13ef]
stable/4.4: [d43aecb694b10db9a4228ce2d38b5ae8de374443]
stable/5.10: [8d0163cec7de995f9eb9c3128c83fb84f0cb1c64]
stable/5.15: [e27ee2f607fe6a9b923ef1fc65461c0613c97594]
stable/5.4: [2e1ec01af2c7139c6a600bbfaea1a018b35094b6]

CVE-2021-47572: net: nexthop: fix null pointer dereference when IPv6
is not enabled

Announce: https://lore.kernel.org/linux-cve-announce/2024052454-CVE-2021-47=
572-50bc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 53010f9 ("nexthop: Add support for IPv6
gateways") in v5.3-rc1.
Fixed in v5.16-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c743127cc54b112b155f434756bd4b5fa565a99]
stable/5.10: [b70ff391deeec35cdd8a05f5f63f5fe28bc4f225]
stable/5.15: [39509d76a9a3d02f379d52cb4b1449469c56c0e0]
stable/5.4: [7b6f44856da5ba0b1aa61403eb9fddd272156503]

CVE-2023-52880: tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Announce: https://lore.kernel.org/linux-cve-announce/2024052422-CVE-2023-52=
880-d2ff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.6-rc1.

Fixed status
cip/4.4: [e531043ff282eb1ce8993ee5ebf0e5bf950c298f]
cip/4.4-rt: [e531043ff282eb1ce8993ee5ebf0e5bf950c298f]
cip/4.4-st: [e531043ff282eb1ce8993ee5ebf0e5bf950c298f]
mainline: [67c37756898a5a6b2941a13ae7260c89b54e0d88]
stable/4.19: [7d303dee473ba3529d75b63491e9963342107bed]
stable/5.10: [ada28eb4b9561aab93942f3224a2e41d76fe57fa]
stable/5.15: [2d154a54c58f9c8375bfbea9f7e51ba3bfb2e43a]
stable/5.4: [7a529c9023a197ab3bf09bb95df32a3813f7ba58]
stable/6.1: [2b85977977cbd120591b23c2450e90a5806a7167]

CVE-2023-52881: tcp: do not accept ACK of bytes we never sent

Announce: https://lore.kernel.org/linux-cve-announce/2024052941-CVE-2023-52=
881-4283@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 354e4aa ("tcp: RFC 5961 5.2 Blind Data Injection
Attack Mitigation") in v3.8-rc1.
Fixed in v6.7-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [ac30c08ffa7b20741b6babb5fe4c738756b0bba4]
cip/4.4-rt: [ac30c08ffa7b20741b6babb5fe4c738756b0bba4]
cip/4.4-st: [ac30c08ffa7b20741b6babb5fe4c738756b0bba4]
mainline: [3d501dd326fb1c73f1b8206d4c6e1d7b15c07e27]
stable/4.19: [458f07ffeccd17f99942311e09ef574ddf4a414a]
stable/5.10: [b17a886ed29f3b70b78ccf632dad03e0c69e3c1a]
stable/5.15: [0d4e0afdd6658cd21dd5be61880411a2553fd1fc]
stable/5.4: [7ffff0cc929fdfc62a74b384c4903d6496c910f0]
stable/6.1: [008b807fe487e0b15a3a6c39add4eb477f73e440]
stable/6.6: [2087d53a66e97a5eb5d1bf558d5bef9e5f891757]

CVE-2024-36014: drm/arm/malidp: fix a possible null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052935-CVE-2024-36=
014-bcb7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8cbc5ca ("drm: mali-dp: Add writeback connector")
in v4.19-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1f95aede6285dba6dd036d907196f35ae3a11ea]

CVE-2024-36015: ppdev: Add an error check in register_device

Announce: https://lore.kernel.org/linux-cve-announce/2024052957-CVE-2024-36=
015-3c7c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9a69645 ("ppdev: fix registering same device
name") in v4.11-rc4.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbf740aeb86a4fe82ad158d26d711f2f3be79b3e]

CVE-2024-36016: tty: n_gsm: fix possible out-of-bounds in gsm0_receive()

Announce: https://lore.kernel.org/linux-cve-announce/2024052947-CVE-2024-36=
016-d30a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e1eaea4 ("tty: n_gsm line discipline") in v2.6.35-rc1.
Fixed in v6.10-rc1.

Fixed status
mainline: [47388e807f85948eefc403a8a5fdc5b406a65d5a]

* Updated CVEs

CVE-2022-48655: firmware: arm_scmi: Harden accesses to the reset domains

stable 5.4 and 5.10 were fixed.

Fixed status
mainline: [e9076ffbcaed5da6c182b144ef9f6e24554af268]
stable/5.10: [f2277d9e2a0d092c13bae7ee82d75432bb8b5108]
stable/5.15: [1f08a1b26cfc53b7715abc46857c6023bb1b87de]
stable/5.4: [7184491fc515f391afba23d0e9b690caaea72daf]

CVE-2023-52429: dm: limit the number of targets and parameter size area

stable/4.19 was fixed.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]
stable/4.19: [1ddc0c3f4996c4ca1216ede1fa7699a803204590]
stable/5.10: [a891a0621e725e85529985139cada8cb5a74a116]
stable/5.15: [888a0a46b80fa37eacfe81faf47ba0b83876251d]
stable/5.4: [86f4a49f32e2392c97296e89da8c25e8fb482c0d]
stable/6.1: [c5d83ac2bf6ca668a39ffb1a576899a66153ba19]
stable/6.6: [438d19492b7f002334573bae43276297eb234c80]
stable/6.7: [cd70175481f63af31901dd463e44386f033c3f4c]

CVE-2023-52434: smb: client: fix potential OOBs in smb2_parse_contexts()

stable/5.4 was fixed.

Fixed status
mainline: [af1689a9b7701d9907dfc84d2a4b57c4bc907144]
stable/5.10: [13fb0fc4917621f3dfa285a27eaf7151d770b5e5]
stable/5.15: [890bc4fac3c0973a49cac35f634579bebba7fe48]
stable/5.4: [6726429c18c62dbf5e96ebbd522f262e016553fb]
stable/6.1: [1ae3c59355dc9882e09c020afe8ffbd895ad0f29]
stable/6.6: [17a0f64cc02d4972e21c733d9f21d1c512963afa]

CVE-2023-52585: drm/amdgpu: Fix possible NULL dereference in
amdgpu_ras_query_error_status_helper()

stable/5.10, 5.15, 5.4, 6.1, and 6.6 were fixed.

Fixed status
mainline: [b8d55a90fd55b767c25687747e2b24abd1ef8680]
stable/5.10: [0eb296233f86750102aa43b97879b8d8311f249a]
stable/5.15: [7e6d6f27522bcd037856234b720ff607b9c4a09b]
stable/5.4: [467139546f3fb93913de064461b1a43a212d7626]
stable/6.1: [92cb363d16ac1e41c9764cdb513d0e89a6ff4915]
stable/6.6: [c364e7a34c85c2154fb2e47561965d5b5a0b69b1]
stable/6.7: [195a6289282e039024ad30ba66e6f94a4d0fbe49]

CVE-2024-23851: Kernel crash in drivers/md/dm-ioctl.c when allocate
memory more than INT_MAX bytes

stable/4.19 was fixed.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]
stable/4.19: [1ddc0c3f4996c4ca1216ede1fa7699a803204590]
stable/5.10: [a891a0621e725e85529985139cada8cb5a74a116]
stable/5.15: [888a0a46b80fa37eacfe81faf47ba0b83876251d]
stable/5.4: [86f4a49f32e2392c97296e89da8c25e8fb482c0d]
stable/6.1: [c5d83ac2bf6ca668a39ffb1a576899a66153ba19]
stable/6.6: [438d19492b7f002334573bae43276297eb234c80]
stable/6.7: [cd70175481f63af31901dd463e44386f033c3f4c]

CVE-2024-26583: tls: fix race between async notify and socket close

stable/5.15 was fixed.

Fixed status
mainline: [aec7961916f3f9e88766e2688992da6980f11b8d]
stable/5.15: [f17d21ea73918ace8afb9c2d8e734dbf71c2c9d7]
stable/6.1: [7a3ca06d04d589deec81f56229a9a9d62352ce01]
stable/6.6: [86dc27ee36f558fe223dbdfbfcb6856247356f4a]
stable/6.7: [6209319b2efdd8524691187ee99c40637558fa33]

CVE-2023-52434: smb: client: fix potential OOBs in smb2_parse_contexts()

stable/5.4 was fixed.

Fixed status
mainline: [af1689a9b7701d9907dfc84d2a4b57c4bc907144]
stable/5.10: [13fb0fc4917621f3dfa285a27eaf7151d770b5e5]
stable/5.15: [890bc4fac3c0973a49cac35f634579bebba7fe48]
stable/5.4: [6726429c18c62dbf5e96ebbd522f262e016553fb]
stable/6.1: [1ae3c59355dc9882e09c020afe8ffbd895ad0f29]
stable/6.6: [17a0f64cc02d4972e21c733d9f21d1c512963afa]

CVE-2024-26584: net: tls: handle backlogging of crypto requests

stable/5.15 was fixed.

Fixed status
mainline: [8590541473188741055d27b955db0777569438e3]
stable/5.15: [3ade391adc584f17b5570fd205de3ad029090368]
stable/6.1: [cd1bbca03f3c1d845ce274c0d0a66de8e5929f72]
stable/6.6: [13eca403876bbea3716e82cdfe6f1e6febb38754]
stable/6.7: [ab6397f072e5097f267abf5cb08a8004e6b17694]

CVE-2024-26800: tls: fix use-after-free on failed backlog decryption

stable/5.15 was fixed.

Fixed status
mainline: [13114dc5543069f7b97991e3b79937b6da05f5b0]
stable/6.1: [f2b85a4cc763841843de693bbd7308fe9a2c4c89]
stable/6.6: [81be85353b0f5a7b660635634b655329b429eefe]
stable/6.7: [1ac9fb84bc7ecd4bc6428118301d9d864d2a58d1]

CVE-2024-26952: ksmbd: fix potencial out-of-bounds when buffer offset is in=
valid

stable/6.6 was fixed.

Fixed status
mainline: [c6cd2e8d2d9aa7ee35b1fa6a668e32a22a9753da]
stable/6.6: [39bdc4197acf2ed13269167ccf093ee28cfa2a4e]
stable/6.8: [0c5541b4c980626fa3cab16ba1a451757778bbb5]

CVE-2024-36013: Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect(=
)

stable/6.6 and 6.8 were fixed.

Fixed status
mainline: [4d7b41c0e43995b0e992b9f8903109275744b658]
stable/6.6: [cfe560c7050bfb37b0d2491bbe7cd8b59e77fdc5]
stable/6.8: [826af9d2f69567c646ff46d10393d47e30ad23c6]

CVE-2024-24862:

The mainline stable/6.6, and stable/6.8 were fixed.

Fixed status
mainline: [1f886a7bfb3faf4c1021e73f045538008ce7634e]
stable/6.6: [4b31a226097cf8cc3c9de5e855d97757fdb2bf06]
stable/6.8: [95e5d9eb26705a9a76d2ef8bcba9ee2e195d653d]


Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

