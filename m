Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01016C3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 23:00:49 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web10.2793.1746658837716972777
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 May 2025 16:00:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=WFcXwzfJ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e78e13d7aa4so467715276.0
        for <cip-dev@lists.cip-project.org>; Wed, 07 May 2025 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1746658837; x=1747263637; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iV3Nw4hxpB+tD3VMfPG4xVp+xEOEky+ZImBfynsjR8U=;
        b=WFcXwzfJ0HK9o/SW750eCjnQY1MTCCTf3rk8t1eaYD5No9qjojEb6b06sZ+VPZ4Nyb
         W85g1PBm5pZXywUdCJr65zdIr+BM9QJ7LNwyiNclhuy2KPyqvd77SHmMru+JiYqIWsMS
         E18vy33S2PpP3DVCWjTObeBiFIuamiulykLeaUcvNjIZF09an2o04fk6F8I/QfoXySuv
         0Qg1dqbMYsipx9SCRr8X/zeCCvg/zs2m+gCoXS4IL+dz8qEQ+A8RZ+0qNPzPY0LC5ShZ
         1eTucSy/tK/Kl+QZH+1KGu5XxM7CuJ5cUpr2uhEHGAP9pIoVLUgvSYnfE56l9QEmPfzL
         v8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746658837; x=1747263637;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iV3Nw4hxpB+tD3VMfPG4xVp+xEOEky+ZImBfynsjR8U=;
        b=I9OQDrDuVVcTklnWi4bcZa7Kny9rS3UxpMkY7aKmD2THQitm+ZOqx86Lygaypqwbq2
         kerINDK+dgMTsEaDPARAcGrRx7JHRWsxREApIQPOj5oHQEXNNDdHamCo+95CE2aglQRP
         A6xAATQjeMPvIU41yMGQIahGJYmcOyzrWGZb5Cvtaxl15fhU8ACpGLI/XDxW3RnFPHIu
         maKJ4i2aAMKp8H23cdNQJrE+MczAeAXQraYx7+aSSHiyHwwhB002sgvtK3YZH/EjfN5Y
         l/gS2b8+tgIPvSrrQ7r/PaBJny4qnVAd/b6mrXl20t4nxN7bdqcwoXRikcYC3C2QIVhg
         jVSA==
X-Gm-Message-State: AOJu0YxERK5c00nbC63EBj6imCG14ZgB7SBgdj0gT1izJBwxoyTBI8FA
	RrB5r7A1uPyxo5GJwyCIa2KKE5itJ+ePPbSA/dz1TlukLOeBDTYFWwzN9YyRC+zDyiw2eu/771C
	6W4DvE3bQhXLpHDyxRGOsAOrhCNxG2ndpC/cmIoxcQXhmQV8pNy4=
X-Gm-Gg: ASbGncv5Pwk7x/GVgMXurA7ppmVHiNmBy5DH4dkGBep1BM61PSrqb8zOBQiEEXjMZ4Z
	zYTgeHulaLhOwsjBMwnbi8LdblL6mtQ2/MgmsCeQrZXexn0NPZ6lc4FsWluRiXw2laf98TmRJuX
	i2qav3+RqdjBSc4LK2RuqfzmlqMkmyolo42Q==
X-Google-Smtp-Source: AGHT+IFYzGeL75IEPwz6Aw2K2GWUI7edSKlIrUWWjimGxY+P/hNi6Caljbs4OprkfStpkGmkQsP6FIg9BLX+6WMKmsw=
X-Received: by 2002:a05:6902:2701:b0:e6b:7bed:5861 with SMTP id
 3f1490d57ef6-e78810e7291mr6408801276.19.1746658833598; Wed, 07 May 2025
 16:00:33 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 May 2025 07:59:57 +0900
X-Gm-Features: ATxdqUHz6je_bu19ot_EafXozj2J8sqTx8YdzojB_Ibs5m56EYGMOmrFCwN36Qk
Message-ID: <CAODzB9pVUfmGVuZ9wW7MQb8TwUL9CvzF9YrT4cdESkXyGWXjSw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 May 2025 23:00:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18777

Hi!

It's this week's CVE report.

This week reported 345 new CVEs and 78 updated CVEs.

* New CVEs
CVE-2020-36790: nvmet: fix a memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2020-36790

Introduced by commit 013b7eb ("nvmet: make ctrl model configurable")
in v5.7-rc1.
Fixed in v5.9-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [382fee1a8b623e2546a3e15e80517389e0e0673e]

CVE-2022-49762: ntfs: check overflow when iterating ATTR_RECORDs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49762

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [45683723f6b53e39e8a4cec0894e61fd6ec71989]
cip/4.4-st: [d8999ba4a6f2b53f4725860a20adb6f2d8d6de52]
mainline: [63095f4f3af59322bea984a6ae44337439348fe0]
stable/4.19: [45683723f6b53e39e8a4cec0894e61fd6ec71989]
stable/5.10: [957732a09c3828267c2819d31c425aa793dd475b]
stable/5.15: [b63ddb3ba61e2d3539f87e095c881e552bc45dab]
stable/5.4: [b612f924f296408d7d02fb4cd01218afd4ed7184]

CVE-2022-49763: ntfs: fix use-after-free in ntfs_attr_find()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49763

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [d0006d739738a658a9c29b438444259d9f71dfa0]
cip/4.4-st: [0c2e78c6592fec15e12c0d255a544e95e01cc6c4]
mainline: [d85a1bec8e8d552ab13163ca1874dcd82f3d1550]
stable/4.19: [d0006d739738a658a9c29b438444259d9f71dfa0]
stable/5.10: [b825bfbbaafbe8da2037e3a778ad660c59f9e054]
stable/5.15: [5330c423b86263ac7883fef0260b9e2229cb531e]
stable/5.4: [266bd5306286316758e6246ea0345133427b0f62]

CVE-2022-49764: bpf: Prevent bpf program recursion for raw tracepoint probes

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49764

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc1.


Fixed status
mainline: [05b24ff9b2cfabfcfd951daaa915a036ab53c9e1]

CVE-2022-49765: net/9p: use a dedicated spinlock for trans_fd

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49765

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc1.


Fixed status
mainline: [296ab4a813841ba1d5f40b03190fd1bd8f25aab0]
stable/5.15: [43bbadb7e4636dc02f6a283c2a39e6438e6173cd]

CVE-2022-49766: netlink: Bounds-check struct nlmsgerr creation

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49766

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc1.


Fixed status
mainline: [710d21fdff9a98d621cd4e64167f3ef8af4e2fd1]

CVE-2022-49767: 9p/trans_fd: always use O_NONBLOCK read/write

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49767

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [7abf40f06a76c0dff42eada10597917e9776fbd4]
cip/4.4-st: [541cd3051873089056e1652a81db06bc8c839407]
mainline: [ef575281b21e9a34dfae544a187c6aac2ae424a9]
stable/4.19: [7abf40f06a76c0dff42eada10597917e9776fbd4]
stable/5.10: [a8e2fc8f7b41fa9d9ca5f624f4e4d34fce5b40a9]
stable/5.15: [0e07032b4b4724b8ad1003698cb81083c1818999]
stable/5.4: [b1ad04da7fe4515e2ce2d5f2dcab3b5b6d45614b]

CVE-2022-49768: 9p: trans_fd/p9_conn_cancel: drop client lock earlier

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49768

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [fec1406f5e7ab20b71f6d231792b0040e3300aaf]
cip/4.4-st: [6da7bb29ba9951ff7c7f9fa121e7c3404542f53a]
mainline: [52f1c45dde9136f964d63a77d19826c8a74e2c7f]
stable/4.19: [fec1406f5e7ab20b71f6d231792b0040e3300aaf]
stable/5.10: [f14858bc77c567e089965962877ee726ffad0556]
stable/5.15: [a4f1a01b2e81378fce9ca528d4d8a049e4b58fcd]
stable/5.4: [96760723aae1b45f733f702abb4333137143909f]

CVE-2022-49769: gfs2: Check sb_bsize_shift after reading superblock

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49769

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [15c83fa0fd659dd9fbdc940a560b61236e876a80]
cip/4.4-st: [921bd588b9423e745736569d895873fe25e0f58e]
mainline: [670f8ce56dd0632dc29a0322e188cc73ce3c6b92]
stable/4.19: [15c83fa0fd659dd9fbdc940a560b61236e876a80]
stable/5.10: [5fa30be7ba81191b0a0c7239a89befc0c94286d5]
stable/5.15: [28275a7c84d21c55ab3282d897f284d8d527173c]
stable/5.4: [8b6534c9ae9dba5489703a19d8ba6c8f2cfa33c2]

CVE-2022-49770: ceph: avoid putting the realm twice when decoding snaps fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49770

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc6.


Fixed status
cip/4.19-st: [274e4c79a3a2a24fba7cfe0e41113f1138785c37]
mainline: [51884d153f7ec85e18d607b2467820a90e0f4359]
stable/4.19: [274e4c79a3a2a24fba7cfe0e41113f1138785c37]
stable/5.10: [044bc6d3c2c0e9090b0841e7b723875756534b45]
stable/5.15: [2f6e2de3a5289004650118b61f138fe7c28e1905]
stable/5.4: [cb7495fe957526555782ce0723f79ce92a6db22e]

CVE-2022-49771: dm ioctl: fix misbehavior if list_versions races with
module loading

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49771

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc6.


Fixed status
cip/4.19-st: [3a1c35d72dc0b34d1e746ed705790c0f630aa427]
cip/4.4-st: [6887ff23a6338cfda416f9e2416643c5cf57bb56]
mainline: [4fe1ec995483737f3d2a14c3fe1d8fe634972979]
stable/4.19: [3a1c35d72dc0b34d1e746ed705790c0f630aa427]
stable/5.10: [f59f5a269ca5e43c567aca7f1f52500a0186e9b7]
stable/5.15: [6ffce7a92ef5c68f7e5d6f4d722c2f96280c064b]
stable/5.4: [b545c0e1e4094d4de2bdfe9a3823f9154b0c0005]

CVE-2022-49772: ALSA: usb-audio: Drop snd_BUG_ON() from
snd_usbmidi_output_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49772

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc6.


Fixed status
cip/4.19-st: [c43991065f36f7628cd124e037b8750c4617a7a7]
cip/4.4-st: [ade4ca536801b499482c663f171ec9c5fcd3d617]
mainline: [ad72c3c3f6eb81d2cb189ec71e888316adada5df]
stable/4.19: [c43991065f36f7628cd124e037b8750c4617a7a7]
stable/5.10: [a80369c8ca50bc885d14386087a834659ec54a54]
stable/5.15: [02b94885b2fdf1808b1874e009bfb90753f8f4db]
stable/5.4: [e7dc436aea80308a9268e6d2d85f910ff107de9b]

CVE-2022-49773: drm/amd/display: Fix optc2_configure warning on dcn314

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49773

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc6.
Commit 2ce0b21 ("drm/amd/display: Fix OPTC function pointers for
DCN314") changed
to optc2_configure_crc instead of optc1_configure_crc.

Fixed status
mainline: [e7e4f77c991c9abf90924929a9d55f90b0bb78de]

CVE-2022-49774: KVM: x86/xen: Fix eventfd error handling in
kvm_xen_eventfd_assign()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49774

Introduced by commit 2fd6df2 ("KVM: x86/xen: intercept EVTCHNOP_send
from guests") in v5.19-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7353633814f6e5b4899fb9ee1483709d6bb0e1cd]

CVE-2022-49775: tcp: cdg: allow tcp_cdg_release() to be called multiple times

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49775

Introduced by commit 2b0a8c9 ("tcp: add CDG congestion control") in v4.2-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9e481d87349d2282f400ee1d010a169c99f766b8]
cip/4.4-st: [6a3f796d40df073f76c805b1bfbf03aaffe010c6]
mainline: [72e560cb8c6f80fc2b4afc5d3634a32465e13a51]
stable/4.19: [9e481d87349d2282f400ee1d010a169c99f766b8]
stable/5.10: [35309be06b6feded2ab2cafbc2bca8534c2fa41e]
stable/5.15: [b49026d9c86f35a4c5bfb8d7345c9c4379828c6b]
stable/5.4: [78be2ee0112409ae4e9ee9e326151e0559b3d239]

CVE-2022-49776: macvlan: enforce a consistent minimal mtu

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49776

Introduced by commit 9157208 ("net: use core MTU range checking in
core net infra") in v4.10-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [650137a7c0b2892df2e5b0bc112d7b09a78c93c8]
mainline: [b64085b00044bdf3cd1c9825e9ef5b2e0feae91a]
stable/4.19: [650137a7c0b2892df2e5b0bc112d7b09a78c93c8]
stable/5.10: [e929ec98c0c3b10d9c07f3776df0c1a02d7a763e]
stable/5.15: [e41cbf98df22d08402e65174d147cbb187fe1a33]
stable/5.4: [a62aa84fe19eb24d083d600a074c009a0a66d4f3]

CVE-2022-49777: Input: i8042 - fix leaking of platform device on module removal

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49777

Introduced by commit 9222ba6 ("Input: i8042 - add deferred probe
support") in v5.16-rc7.
Fixed in v6.1-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [81df118e79b2136b5c016394f67a051dc508b7b6]
mainline: [81cd7e8489278d28794e7b272950c3e00c344e44]
stable/4.19: [81df118e79b2136b5c016394f67a051dc508b7b6]
stable/5.10: [3f25add5ecf88de0f8ff2b27b6c0731a1f1b38ed]
stable/5.15: [d5f7f6e63fed9c2ed09725d90059a28907e197e3]
stable/5.4: [4f348b60c79671eee33c1389efe89109c93047da]

CVE-2022-49778: arm64/mm: fix incorrect file_map_count for non-leaf pmd/pud

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49778

Introduced by commit 42b2547 ("arm64/mm: enable
ARCH_SUPPORTS_PAGE_TABLE_CHECK") in v5.19-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b47348fc0b18a78c96f8474cc90b7525ad1bbfe]

CVE-2022-49779: kprobes: Skip clearing aggrprobe's post_handler in
kprobe-on-ftrace case

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49779

Introduced by commit 0bc11ed ("kprobes: Allow kprobes coexist with
livepatch") in v5.4-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5dd7caf0bdc5d0bae7cf9776b4d739fb09bd5ebb]
stable/5.10: [7d606ae1abcc3eab5408e42444d789dc7def51b8]
stable/5.15: [c49cc2c059b503e962c2f13a806c105f9b757df4]
stable/5.4: [7b0007b28dd970176f2e297c06ae63eea2447127]

CVE-2022-49780: scsi: target: tcm_loop: Fix possible name leak in
tcm_loop_setup_hba_bus()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49780

Introduced by commit 3703b2c ("[SCSI] tcm_loop: Add multi-fabric
Linux/SCSI LLD fabric module") in v2.6.39-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [41a6b8b527a5957fab41c3c05e25ad125268e2e9]
mainline: [bc68e428d4963af0201e92159629ab96948f0893]
stable/4.19: [41a6b8b527a5957fab41c3c05e25ad125268e2e9]
stable/5.10: [75205f1b47a88c3fac4f30bd7567e89b2887c7fd]
stable/5.15: [a636772988bafab89278e7bb3420d8e8eacfe912]
stable/5.4: [28f7ff5e7559d226e63c7c5de74eb075a83d8c53]

CVE-2022-49781: perf/x86/amd: Fix crash due to race between
amd_pmu_enable_all, perf NMI and throttling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49781

Introduced by commit ada5434 ("perf/x86/amd: Add AMD Fam19h Branch
Sampling support") in v5.19-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [baa014b9543c8e5e94f5d15b66abfe60750b8284]

CVE-2022-49782: perf: Improve missing SIGTRAP checking

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49782

Introduced by commit ca6c213 ("perf: Fix missing SIGTRAPs") in 6.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [bb88f9695460bec25aa30ba9072595025cf6c8af]
stable/5.15: [35c60b4e8ca76712dd03bafe2598e31578248916]

CVE-2022-49783: x86/fpu: Drop fpregs lock before inheriting FPU permissions

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49783

Introduced by commit 9e798e9 ("x86/fpu: Prepare fpu_clone() for
dynamically enabled features") in v5.16-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36b038791e1e2baea892e9276588815fd14894b4]

CVE-2022-49784: perf/x86/amd/uncore: Fix memory leak for events array

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49784

Introduced by commit 39621c5 ("perf/x86/amd/uncore: Use dynamic events
array") in v6.0-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdfe34597139cfcecd47a2eb97fea44d77157491]

CVE-2022-49785: x86/sgx: Add overflow check in sgx_validate_offset_length()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49785

Introduced by commit c6d26d3 ("x86/sgx: Add
SGX_IOC_ENCLAVE_ADD_PAGES") in v5.11-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0861f49bd946ff94fce4f82509c45e167f63690]
stable/5.15: [5277e3d633a5d4157987f4aff068caa55e36db19]

CVE-2022-49786: blk-cgroup: properly pin the parent in blkcg_css_online

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49786

Introduced by commit 397c9f4 ("blk-cgroup: move
blkcg_{pin,unpin}_online out of line") in v5.19-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7dbd43f4a828fa1d9a8614d5b0ac40aee6375fe]

CVE-2022-49787: mmc: sdhci-pci: Fix possible memory leak caused by
missing pci_dev_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49787

Introduced by commit 659c9bc ("mmc: sdhci-pci: Build o2micro support
in the same module") in v4.4-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5dbd6378dbf96787d6dbcca44156c511ae085ea3]
mainline: [222cfa0118aa68687ace74aab8fdf77ce8fbd7e6]
stable/4.19: [5dbd6378dbf96787d6dbcca44156c511ae085ea3]
stable/5.10: [4423866d31a06a810db22062ed13389416a66b22]
stable/5.15: [a99a547658e5d451f01ed307426286716b6f01bf]
stable/5.4: [27f712cd47d65e14cd52cc32a23d42aeef583d5d]

CVE-2022-49788: misc/vmw_vmci: fix an infoleak in
vmci_host_do_receive_datagram()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49788

Introduced by commit 06164d2 ("VMCI: queue pairs implementation.") in v3.9-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5a275528025ae4bc7e2232866856dfebf84b2fad]
cip/4.4-st: [a6f092d69b0cee202649bb488ab6ffd29bed64ec]
mainline: [e5b0d06d9b10f5f43101bd6598b076c347f9295f]
stable/4.19: [5a275528025ae4bc7e2232866856dfebf84b2fad]
stable/5.10: [62634b43d3c4e1bf62fd540196f7081bf0885c0a]
stable/5.15: [8e2f33c598370bcf828bab4d667d1d38bcd3c57d]
stable/5.4: [e7061dd1fef2dfb6458cd521aef27aa66f510d31]

CVE-2022-49789: scsi: zfcp: Fix double free of FSF request when qdio send fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49789

Introduced by commit e60a6d6 ("[SCSI] zfcp: Remove function
zfcp_reqlist_find_safe") in v2.6.34-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0954256e970ecf371b03a6c9af2cf91b9c4085ff]
stable/5.10: [d2c7d8f58e9cde8ac8d1f75e9d66c2a813ffe0ab]
stable/5.15: [11edbdee4399401f533adda9bffe94567aa08b96]
stable/5.4: [1bf8ed585501bb2dd0b5f67c824eab45adfbdccd]

CVE-2022-49790: Input: iforce - invert valid length check when
fetching device IDs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49790

Introduced by commit 6ac0aec ("Input: iforce - allow callers supply
data buffer when fetching device IDs") in v5.3-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8ebf250997c5fb253582f42bfe98673801ebebd]
stable/5.10: [24cc679abbf31477d0cc6106ec83c2fbae6b3cdf]
stable/5.15: [fdd57c20d4408cac3c3c535c120d244e083406c9]
stable/5.4: [5d53797ce7ce8fb1d95a5bebc5efa9418c4217a3]

CVE-2022-49791: io_uring: fix multishot accept request leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49791

Introduced by commit 390ed29 ("io_uring: add IORING_ACCEPT_MULTISHOT
for accept") in v5.19-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91482864768a874c4290ef93b84a78f4f1dac51b]

CVE-2022-49792: iio: adc: mp2629: fix potential array out of bound access

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49792

Introduced by commit 7abd9fb ("iio: adc: mp2629: Add support for
mp2629 ADC driver") in v5.8-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca1547ab15f48dc81624183ae17a2fd1bad06dfc]
stable/5.10: [d95b85c5084ad70011988861ee864529eefa1da0]
stable/5.15: [1678d4abb2dc2ca3b05b998a9d88616976e4f947]

CVE-2022-49793: iio: trigger: sysfs: fix possible memory leak in
iio_sysfs_trig_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49793

Introduced by commit 1f78568 ("staging:iio:trigger sysfs userspace
trigger rework.") in v3.0-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b47bb521961f027b4dcf8683337a7a1ba9e5ea1f]
cip/4.4-st: [9986e3708c8272069384ed4d2ad504df8c7340be]
mainline: [efa17e90e1711bdb084e3954fa44afb6647331c0]
stable/4.19: [b47bb521961f027b4dcf8683337a7a1ba9e5ea1f]
stable/5.10: [8dddf2699da296c84205582aaead6b43dd7e8c4b]
stable/5.15: [656f670613662b6cc77aad14112db2803ad18fa8]
stable/5.4: [0dd52e141afde089304de470148d311b05c14564]

CVE-2022-49794: iio: adc: at91_adc: fix possible memory leak in
at91_adc_allocate_trigger()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49794

Introduced by commit 0e589d5 ("ARM: AT91: IIO: Add AT91 ADC driver.")
in v3.5-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2b29a7f2d52fb5281b30cf61c947d88bab18a29b]
cip/4.4-st: [6136e471a14b48ea96225ea371e3b3d5e72ad071]
mainline: [65f20301607d07ee279b0804d11a05a62a6c1a1c]
stable/4.19: [2b29a7f2d52fb5281b30cf61c947d88bab18a29b]
stable/5.10: [85d2a8b287a89853c0dcfc5a97b5e9d36376fe37]
stable/5.15: [1bf8c0aff8fb5c4edf3ba6728e6bedbd610d7f4b]
stable/5.4: [7b75515728b628a9a7540f201efdeb8ca7299385]

CVE-2022-49795: rethook: fix a potential memleak in rethook_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49795

Introduced by commit 54ecbe6 ("rethook: Add a generic return hook") in
v5.18-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a1ebe35cb3b7aa1f4b26b37e2a0b9ae68dc4ffb]

CVE-2022-49796: tracing: kprobe: Fix potential null-ptr-deref on
trace_array in kprobe_event_gen_test_exit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49796

Introduced by commit 6483624 ("tracing: Add kprobe event command
generation test module") in v5.6-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22ea4ca9631eb137e64e5ab899e9c89cb6670959]
stable/5.10: [28a54854a95923b6266a9479ad660ca2cc0e1d5f]
stable/5.15: [e57daa750369fedbf678346aec724a43b9a51749]

CVE-2022-49797: tracing: kprobe: Fix potential null-ptr-deref on
trace_event_file in kprobe_event_gen_test_exit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49797

Introduced by commit 6483624 ("tracing: Add kprobe event command
generation test module") in v5.6-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0d75267f59d7084e0468bd68beeb1bf9c71d7c0]
stable/5.10: [bb70fcae4115d24b7e8cee17a6da8b1943f546bb]
stable/5.15: [3a41c0f2a5c3bf72b4c4e9dd4b1025378201e332]

CVE-2022-49798: tracing: Fix race where eprobes can be called before the event

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49798

Introduced by commit 7491e2c ("tracing: Add a probe that attaches to
trace events") in v5.15-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94eedf3dded5fb472ce97bfaf3ac1c6c29c35d26]
stable/5.15: [7291dec4f2d17a2d3fd1f789fb41e58476539f21]

CVE-2022-49799: tracing: Fix wild-memory-access in register_synth_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49799

Introduced by commit 4b14793 ("tracing: Add support for 'synthetic'
events") in v4.17-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b5f1c34d3f5a664a57a5a7557a50e4e3cc2505c]
stable/5.10: [315b149f08229a233d47532eb5da1707b28f764c]
stable/5.15: [6517b97134f724d12f673f9fb4f456d75c7a905f]

CVE-2022-49800: tracing: Fix memory leak in test_gen_synth_cmd() and
test_empty_synth_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49800

Introduced by commit 9fe41ef ("tracing: Add synth event generation
test module") in v5.6-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4527fef9afe5c903c718d0cd24609fe9c754250]
stable/5.10: [65ba7e7c241122ef0a9e61d1920f2ae9689aa796]
stable/5.15: [07ba4f0603aba288580866394f2916dfe55823a2]

CVE-2022-49801: tracing: Fix memory leak in tracing_read_pipe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49801

Introduced by commit efbbdaa ("tracing: Show real address for trace
event arguments") in v5.12-rc1.
Fixed in v6.1-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [649e72070cbbb8600eb823833e4748f5a0815116]
stable/5.15: [2c21ee020ce43d744ecd7f3e9bddfcaafef270ce]

CVE-2022-49802: ftrace: Fix null pointer dereference in ftrace_add_mod()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49802

Introduced by commit 673feb9 ("ftrace: Add :mod: caching
infrastructure to trace_array") in v4.13-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b5bfc61f541d3f092b13dedcfe000d86eb8e133c]
mainline: [19ba6c8af9382c4c05dc6a0a79af3013b9a35cd0]
stable/4.19: [b5bfc61f541d3f092b13dedcfe000d86eb8e133c]
stable/5.10: [6a14828caddad0d989495a72af678adf60992704]
stable/5.15: [1bea037a1abb23a6729bef36a2265a4565f5ea77]
stable/5.4: [f715f31559b82e3f75ce047fa476de63d8107584]

CVE-2022-49803: netdevsim: Fix memory leak of nsim_dev->fa_cookie

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49803

Introduced by commit d3cbb90 ("netdevsim: add ACL trap reporting
cookie as a metadata") in v5.7-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [064bc7312bd09a48798418663090be0c776183db]

CVE-2022-49804: s390: avoid using global register for current_stack_pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49804

Introduced by commit 30de14b ("s390: current_stack_pointer shouldn't
be a function") in v5.18-rc3.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3c11025bcd2142a61abe5806b2f86a0e78118df]

CVE-2022-49805: net: lan966x: Fix potential null-ptr-deref in
lan966x_stats_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49805

Introduced by commit 12c2d0a ("net: lan966x: add ethtool configuration
and statistics") in v5.17-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba86af3733aece88dbcee0dfebf7e2dcfefb2be4]

CVE-2022-49806: net: microchip: sparx5: Fix potential null-ptr-deref
in sparx_stats_init() and sparx5_start()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49806

Introduced by commit af4b110 ("net: sparx5: add ethtool configuration
and statistics support") in v5.14-rc1.
Introduced by commit b37a1ba ("net: sparx5: add mactable support") in v5.14-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [639f5d006e36bb303f525d9479448c412b720c39]
stable/5.15: [80e590aeb132887102c3fa79d99b338f099dc952]

CVE-2022-49807: nvmet: fix a memory leak in nvmet_auth_set_key

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49807

Introduced by commit db1312d ("nvmet: implement basic In-Band
Authentication") in v6.0-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a52566279b4ee65ecd2503d7b7342851f84755c]

CVE-2022-49808: net: dsa: don't leak tagger-owned storage on switch
driver unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49808

Introduced by commit 7f29731 ("net: dsa: make tagging protocols
connect to individual switches from a tree") in v5.17-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e0c19fcb8b5323716140fa82b79aa9f60e60407]

CVE-2022-49809: net/x25: Fix skb leak in x25_lapb_receive_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49809

Introduced by commit cb101ed ("x25: Handle undersized/fragmented skbs") in v3.1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0ef17d966445358a55c5f4ccf2c73cca3e39192b]
cip/4.4-st: [e77f6d82284cca006bcdc2dfdb8e4789b3cb9bda]
mainline: [2929cceb2fcf0ded7182562e4888afafece82cce]
stable/4.19: [0ef17d966445358a55c5f4ccf2c73cca3e39192b]
stable/5.10: [9f00da9c866d506998bf0a3f699ec900730472da]
stable/5.15: [c8baf1fc248b2e88642f094fea9509a9bf98c5bb]
stable/5.4: [e109b41870db995cae25dfaf0cc3922f9028b1a1]

CVE-2022-49810: netfs: Fix missing xas_retry() calls in xarray iteration

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49810

Introduced by commit 3d3c950 ("netfs: Provide readahead and readpage
netfs helpers") in v5.13-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e043a80b5dae5c2d2cf84031501de7827fd6c00]

CVE-2022-49811: drbd: use after free in drbd_create_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49811

Introduced by commit b6f85ef ("drbd: Iterate over all connections") in
v3.15-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bf47ca1b35fc1f55091ffaff5fbe41ea0c6f59a1]
mainline: [a7a1598189228b5007369a9622ccdf587be0730f]
stable/4.19: [bf47ca1b35fc1f55091ffaff5fbe41ea0c6f59a1]
stable/5.10: [9ed51414aef6e59e832e2960f10766dce2d5b1a1]
stable/5.15: [7d93417d596402ddd46bd76c721f205d09d0d025]
stable/5.4: [813a8dd9c45fd46f5cbbfbedf0791afa7740ccf5]

CVE-2022-49812: bridge: switchdev: Fix memory leaks when changing VLAN protocol

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49812

Introduced by commit 2797379 ("net: bridge: Fix VLANs memory leak") in v5.0-rc3.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d45921ee4cb364910097e7d1b7558559c2f9fd2]
stable/5.10: [347f1793b573466424c550f2748ed837b6690fe7]
stable/5.15: [fc16a2c81a3eb1cbba8775f5bdc67856df903a7c]

CVE-2022-49813: net: ena: Fix error handling in ena_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49813

Introduced by commit 1738cd3 ("net: ena: Add a driver for Amazon
Elastic Network Adapters (ENA)") in v4.9-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d349e9be5a2c2d7588a2c4e4bfa0bb3dc1226769]
stable/5.10: [6b23a4b252044e4fd23438930d452244818d7000]
stable/5.15: [3f7b2ef8fe924e299bc339811ea3f1b9935c040f]

CVE-2022-49814: kcm: close race conditions on sk_receive_queue

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49814

Introduced by commit ab7ac4e ("kcm: Kernel Connection Multiplexor
module") in v4.6-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d9ad4de92e184b19bcae4da10dac0275abf83931]
mainline: [5121197ecc5db58c07da95eb1ff82b98b121a221]
stable/4.19: [d9ad4de92e184b19bcae4da10dac0275abf83931]
stable/5.10: [4154b6afa2bd639214ff259d912faad984f7413a]
stable/5.15: [f7b0e95071bb4be4b811af3f0bfc3e200eedeaa3]
stable/5.4: [ce57d6474ae999a3b2d442314087473a646a65c7]

CVE-2022-49815: erofs: fix missing xas_retry() in fscache mode

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49815

Introduced by commit d435d53 ("erofs: change to use asynchronous io
for fscache readpage/readahead") in v5.19-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37020bbb71d911431e16c2c940b97cf86ae4f2f6]

CVE-2022-49816: xen/pcpu: fix possible memory leak in register_pcpu()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49816

Introduced by commit f65c9bb ("xen/pcpu: Xen physical cpus
online/offline sys interface") in v3.6-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6209a85079a035b5c2279b15b197531156b549fa]
cip/4.4-st: [17a33db35378857c360a4e2507aa6ea0903bdd6d]
mainline: [da36a2a76b01b210ffaa55cdc2c99bc8783697c5]
stable/4.19: [6209a85079a035b5c2279b15b197531156b549fa]
stable/5.10: [bb9924a6edd9d4a9ef83a5f337af60f8a7a68f98]
stable/5.15: [c08c13cb13fa3866dd0700db3b246fcd2043ab81]
stable/5.4: [0199bf0a8f74509736744c9e36f4473a5892a09d]

CVE-2022-49817: net: mhi: Fix memory leak in mhi_net_dellink()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49817

Introduced by commit 13adac0 ("net: mhi_net: Register wwan_ops for
link creation") in v5.14-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7c125bd79f50ec6094761090be81d02726ec6f4]
stable/5.15: [88da008e5e2f9753726ea5a51ef2eb144e9de927]

CVE-2022-49818: mISDN: fix misuse of put_device() in mISDN_register_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49818

Introduced by commit e7d1d4d ("mISDN: fix possible memory leak in
mISDN_register_device()")
in 6.1-rc4

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [d40b35a7922f4df3767ad6fb8ef3dc86e31d7ba3]
cip/4.4-st: [e157fd0ff2b7500724ea4012fcf9e78b7903ac8c]
mainline: [2d25107e111a85c56f601a5470f1780ec054e6ac]
stable/4.19: [d40b35a7922f4df3767ad6fb8ef3dc86e31d7ba3]
stable/5.10: [709aa1f73d3e9e9ea16e2c4e44f2874c5d2c382c]
stable/5.15: [596230471da3415e92ae6b9d2a4e26f4a81cac5a]
stable/5.4: [83672c1b83d107b0d4fe0accf1bf64d8988398e6]

CVE-2022-49819: octeon_ep: fix potential memory leak in octep_device_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49819

Introduced by commit 862cd65 ("octeon_ep: Add driver framework and
device initialization") in v5.19-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4041be97b15302ebfffda8bbd45f3b2d096048f]

CVE-2022-49820: mctp i2c: don't count unused / invalid keys for flow release

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49820

Introduced by commit f5b8abf ("mctp i2c: MCTP I2C binding driver") in v5.18-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cbd48d5fa14e4c65f8580de16686077f7cea02b]

CVE-2022-49821: mISDN: fix possible memory leak in mISDN_dsp_element_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49821

Introduced by commit 1fa5ae8 ("driver core: get rid of struct device's
bus_id string array") in v2.6.30-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [727ed7d28348c026c7ef4d852f3d0e5054d376e8]
cip/4.4-st: [696c449343657e0a6d611b309928a9b98f8f4c11]
mainline: [98a2ac1ca8fd6eca6867726fe238d06e75eb1acd]
stable/4.19: [727ed7d28348c026c7ef4d852f3d0e5054d376e8]
stable/5.10: [083a2c9ef82e184bdf0b9f9a1e5fc38d32afbb47]
stable/5.15: [7a05e3929668c8cfef495c69752a9e91fac4878f]
stable/5.4: [0f2c681900a01e3f23789bca26d88268c3d5b51d]

CVE-2022-49822: cifs: Fix connections leak when tlink setup failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49822

Introduced by commit 56c762e ("cifs: Refactor out cifs_mount()") in v5.0-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dcdf5f5b2137185cbdd5385f29949ab3da4f00c]
stable/5.15: [a9059e338fc000c0b87d8cf29e93c74fd703212e]

CVE-2022-49823: ata: libata-transport: fix error handling in ata_tdev_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49823

Introduced by commit d902747 ("[libata] Add ATA transport class") in
v2.6.37-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ff36351309e3eadcff297480baf4785e726de9b]
stable/5.10: [ef2ac07ab83163b9a53f45da20e14302591ad9cc]
stable/5.15: [f23058dc2398db1d8faca9a2b1ce30b85cdd8b22]

CVE-2022-49824: ata: libata-transport: fix error handling in ata_tlink_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49824

Introduced by commit d902747 ("[libata] Add ATA transport class") in
v2.6.37-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf0816f6322c5c37ee52655f928e91ecf32da103]
stable/5.10: [7377a14598f6b04446c54bc4a50cd249470d6c6f]
stable/5.15: [67b219314628b90b3a314528e177335b0cd5c70b]

CVE-2022-49825: ata: libata-transport: fix error handling in ata_tport_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49825

Introduced by commit d902747 ("[libata] Add ATA transport class") in
v2.6.37-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3613dbe3909dcc637fe6be00e4dc43b4aa0470ee]
stable/5.10: [b5362dc1634d8b8d5f30920f33ac11a3276b7ed9]
stable/5.15: [e7bb1b7a7bf26f6b7372b7b683daece4a42fda02]

CVE-2022-49826: ata: libata-transport: fix double ata_host_put() in
ata_tport_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49826

Introduced by commit 2623c7a ("libata: add refcounting to ata_host")
in v4.17-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [30e12e2be27ac6c4be2af4163c70db381364706f]
mainline: [8c76310740807ade5ecdab5888f70ecb6d35732e]
stable/4.19: [30e12e2be27ac6c4be2af4163c70db381364706f]
stable/5.10: [ac471468f7c16cda2525909946ca13ddbcd14000]
stable/5.15: [377ff82c33c0cb74562a353361b64b33c09562cf]
stable/5.4: [bec9ded5404cb14e5f5470103d0973a2ff83d6a5]

CVE-2022-49827: drm: Fix potential null-ptr-deref in drm_vblank_destroy_worker()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49827

Introduced by commit 5e6c2b4 ("drm/vblank: Add vblank works") in v5.9-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4979524f5a2a8210e87fde2f642b0dc060860821]
stable/5.10: [1d160dfb3fdf11ba9447e862c548447f91f4e74a]
stable/5.15: [e884a6c2d49a6c12761e5bed851e9fe93bd923a1]

CVE-2022-49828: hugetlbfs: don't delete error page from pagecache

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49828

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc5.


Fixed status
mainline: [8625147cafaa9ba74713d682f5185eb62cb2aedb]
stable/5.15: [30571f28bb35c826219971c63bcf60d2517112ed]

CVE-2022-49829: drm/scheduler: fix fence ref counting

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49829

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc3.


Fixed status
mainline: [b3af84383e7abdc5e63435817bb73a268e7c3637]

CVE-2022-49830: drm/drv: Fix potential memory leak in drm_dev_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49830

Introduced by commit 2cbf7fc ("drm: Use drmm_ for drm_dev_init
cleanup") in v5.8-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff963634f7b2e0dc011349abb3fb81a0d074f443]
stable/5.10: [c47a823ea186263ab69cfb665327b7f72cb5e779]
stable/5.15: [07e56de8766fe5be67252596244b84ac0ec0de91]

CVE-2022-49831: btrfs: zoned: initialize device's zone info for seeding

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49831

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc5.


Fixed status
mainline: [a8d1b1647bf8244a5f270538e9e636e2657fffa3]
stable/5.15: [91c38504e589dadbcde47b1cacdfc5b684154d44]

CVE-2022-49832: pinctrl: devicetree: fix null pointer dereferencing in
pinctrl_dt_to_map

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49832

Introduced by commit 57291ce ("pinctrl: core device tree mapping table
parsing support") in v3.5-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a988dcd3dd9e691c5ccc3324b209688f3b5453e9]
cip/4.4-st: [88649f65ab1fb945ad16a9bda3536a377cc0f495]
mainline: [91d5c5060ee24fe8da88cd585bb43b843d2f0dce]
stable/4.19: [a988dcd3dd9e691c5ccc3324b209688f3b5453e9]
stable/5.10: [777430aa4ddccaa5accec6db90ffc1d47f00d471]
stable/5.15: [97e5b508e96176f1a73888ed89df396d7041bfcb]
stable/5.4: [040f726fecd88121f3b95e70369785ad452dddf9]

CVE-2022-49833: btrfs: zoned: clone zoned device info when cloning a device

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49833

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc5.


Fixed status
mainline: [21e61ec6d0bb786818490e926aa9aeb4de95ad0d]

CVE-2022-49834: nilfs2: fix use-after-free bug of ns_writer on remount

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49834

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc5.


Fixed status
cip/4.19-st: [b4736ab5542112fe0a40f140a0a0b072954f34da]
cip/4.4-st: [44b1da9b0277321619e20aec6f3de7167750be95]
mainline: [8cccf05fe857a18ee26e20d11a8455a73ffd4efd]
stable/4.19: [b4736ab5542112fe0a40f140a0a0b072954f34da]
stable/5.10: [4feedde5486c07ea79787839153a71ca71329c7d]
stable/5.15: [afbd1188382a75f6cfe22c0b68533f7f9664f182]
stable/5.4: [9b162e81045266a2d5b44df9dffdf05c54de9cca]

CVE-2022-49835: ALSA: hda: fix potential memleak in 'add_widget_node'

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49835

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc5.


Fixed status
cip/4.19-st: [90b7d055e2b5f39429f9a9e3815b48a48530ef28]
cip/4.4-st: [8eab6040323d01908f123d9735edbdf25bb852fb]
mainline: [9a5523f72bd2b0d66eef3d58810c6eb7b5ffc143]
stable/4.19: [90b7d055e2b5f39429f9a9e3815b48a48530ef28]
stable/5.10: [3a79f9568de08657fcdbc41d6fc4c0ca145a7a2b]
stable/5.15: [7140d7aaf93da6a665b454f91bb4dc6b1de218bd]
stable/5.4: [02dea987ec1cac712c78e75d224ceb9bb73519ed]

CVE-2022-49836: siox: fix possible memory leak in siox_device_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49836

Introduced by commit bbecb07 ("siox: new driver framework for
eckelmann SIOX") in v4.16-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0a5da069603ecc3d7aa09167450235462adaa295]
mainline: [6e63153db50059fb78b8a8447b132664887d24e3]
stable/4.19: [0a5da069603ecc3d7aa09167450235462adaa295]
stable/5.10: [a4b5423f88a17a36550ae8c16c46779b1ee42f4b]
stable/5.15: [5d03c2911c529ea4d6ebfec53425f1091e8d402b]
stable/5.4: [f9fe7ba4ea5b24ffdf8e125f660aca3ba4a147fb]

CVE-2022-49837: bpf: Fix memory leaks in __check_func_call

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49837

Introduced by commit 69c087b ("bpf: Add bpf_for_each_map_elem()
helper") in v5.13-rc1.
Introduced by commit fd978bf ("bpf: Add reference tracking to
verifier") in v4.20-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb86559a691cea5fa63e57a03ec3dc9c31e97955]
stable/5.15: [d4944497827a3d14bc5a26dbcfb7433eb5a956c0]

CVE-2022-49838: sctp: clear out_curr if all frag chunks of current msg
are pruned

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49838

Introduced by commit 5bbbbe3 ("sctp: introduce stream scheduler
foundations") in v4.15-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f201ae14ae0f91dbf1cffea7bb1e29e81d4d108]
stable/5.10: [e27458b18b35caee4b27b37a4a9c503b93cae5cc]
stable/5.15: [2ea600b598dd3e061854dd4dd5b4c815397dfcea]

CVE-2022-49839: scsi: scsi_transport_sas: Fix error handling in sas_phy_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49839

Introduced by commit c7ebbbc ("[SCSI] SAS transport class") in v2.6.20.16.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d7bebf2dfb0dc97aac1fbace0910e557ecdb16f]
stable/5.10: [03aabcb88aeeb7221ddb6196ae84ad5fb17b743f]
stable/5.15: [2f21d653c648735657e23948b1d7ac7273de0f87]

CVE-2022-49840: bpf, test_run: Fix alignment problem in bpf_prog_test_run_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49840

Introduced by commit 1cf1cae ("bpf: introduce BPF_PROG_TEST_RUN
command") in v4.12-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [730fb1ef974a13915bc7651364d8b3318891cd70]
mainline: [d3fd203f36d46aa29600a72d57a1b61af80e4a25]
stable/4.19: [730fb1ef974a13915bc7651364d8b3318891cd70]
stable/5.10: [e60f37a1d379c821c17b08f366412dce9ef3d99f]
stable/5.15: [eaa8edd86514afac9deb9bf9a5053e74f37edf40]
stable/5.4: [7a704dbfd3735304e261f2787c52fbc7c3884736]

CVE-2022-49841: serial: imx: Add missing .thaw_noirq hook

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49841

Introduced by commit 09df0b3 ("serial: imx: fix endless loop during
suspend") in v4.16-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e401312ca6e180ee1bd65f6a766e99dd40aa95e7]
mainline: [4561d8008a467cb05ac632a215391d6b787f40aa]
stable/4.19: [e401312ca6e180ee1bd65f6a766e99dd40aa95e7]
stable/5.10: [0a3160f4ffc70ee4bfa1521f698dace06e6091fd]
stable/5.15: [ae22294e213a402a70fa1731538367d1b758ffe7]
stable/5.4: [476b09e07bd519ec7ba5941a6a6f9a02256dbb21]

CVE-2022-49842: ASoC: core: Fix use-after-free in snd_soc_exit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49842

Introduced by commit fb25789 ("ASoC: Work around allmodconfig
failure") in v3.0-rc1.
Fixed in v6.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a3365e62239dc064019a244bde5686ac18527c22]
cip/4.4-st: [0b59b4f95b73e6477b1ab6a9338c7145c801a5f0]
mainline: [6ec27c53886c8963729885bcf2dd996eba2767a7]
stable/4.19: [a3365e62239dc064019a244bde5686ac18527c22]
stable/5.10: [8d21554ec7680e9585fb852d933203c3db60dad1]
stable/5.15: [34eee4189bcebbd5f6a2ff25ef0cb893ad33d51e]
stable/5.4: [2ec3f558db343b045a7c7419cdbaec266b8ac1a7]

CVE-2022-49843: drm/amdkfd: Migrate in CPU page fault use current mm

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49843


Introduced by commit e1f84ee ("drm/amdkfd: handle CPU fault on COW mapping")
in 6.1-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3a876060892ba52dd67d197c78b955e62657d906]
stable/5.15: [1dea25e25acd990d7657940ffcab8354c28fa292]

CVE-2022-49844: can: dev: fix skb drop check

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49844

Introduced by commit a6d190f ("can: skb: drop tx skb if in listen only
mode") in v6.0-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae64438be1923e3c1102d90fd41db7afcfaf54cc]

CVE-2022-49845: can: j1939: j1939_send_one(): fix missing CAN header
initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49845

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3eb3d283e8579a22b81dd2ac3987b77465b2a22f]
stable/5.10: [f8e0edeaa0f2b860bdbbf0aafb4492533043d650]
stable/5.15: [69e86c6268d59ceddd0abe9ae8f1f5296f316c3c]
stable/5.4: [d0513b095e1ef1469718564dec3fb3348556d0a8]

CVE-2022-49846: udf: Fix a slab-out-of-bounds write bug in udf_find_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49846

Introduced by commit 066b9cd ("udf: Use separate buffer for copying
split names") in v4.6-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7a6051d734f1ed0031e2216f9a538621235c11a4]
mainline: [c8af247de385ce49afabc3bf1cf4fd455c94bfe8]
stable/4.19: [7a6051d734f1ed0031e2216f9a538621235c11a4]
stable/5.10: [03f9582a6a2ebd25a440896475c968428c4b63e7]
stable/5.15: [c736ed8541605e3a25075bb1cbf8f38cb3083238]
stable/5.4: [d8971f410739a864c537e0ac29344a7b6c450232]

CVE-2022-49847: net: ethernet: ti: am65-cpsw: Fix segmentation fault
at module unload

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49847

Introduced by commit e8609e6 ("net: ethernet: ti: am65-cpsw: Convert
to PHYLINK") in v5.18-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a0c016a4831ea29be09bbc8162d4a2a0690b4b8]

CVE-2022-49848: phy: qcom-qmp-combo: fix NULL-deref on runtime resume

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49848

Introduced by commit fc64623 ("phy: qcom-qmp-combo,usb: add support
for separate PCS_USB region") in v6.0-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04948e757148f870a31f4887ea2239403f516c3c]

CVE-2022-49849: btrfs: fix match incorrectly in dev_args_match_device

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49849

Introduced by commit 562d7b1 ("btrfs: handle device lookup with
btrfs_dev_lookup_args") in v5.16-rc1.
Fixed in v6.1-rc5.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [0fca385d6ebc3cabb20f67bcf8a71f1448bdc001]
stable/5.15: [c9fe4719c662e0af17eea723cf345e37719fd3c9]

CVE-2022-49850: nilfs2: fix deadlock in nilfs_count_free_blocks()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49850

Introduced by commit e828949 ("nilfs2: call nilfs_error inside bmap
routines") in v2.6.38-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f0cc93080d4c09510b74ecba87fd778cca390bb1]
cip/4.4-st: [2af0ffc665a09ebc964d8b2120bbfb2d817265fb]
mainline: [8ac932a4921a96ca52f61935dbba64ea87bbd5dc]
stable/4.19: [f0cc93080d4c09510b74ecba87fd778cca390bb1]
stable/5.10: [1d4ff73062096c21b47954d2996b4df259777bda]
stable/5.15: [abc082aac0d9b6b926038fc3adb7008306581be2]
stable/5.4: [36ff974b0310771417c0be64b64aa221bd70d63d]

CVE-2022-49851: riscv: fix reserved memory setup

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49851

Introduced by commit 922b037 ("riscv: Fix memblock reservation for
device tree blob") in v5.4-rc2.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50e63dd8ed92045eb70a72d7ec725488320fb68b]
stable/5.10: [94ab8f88feb75e3b1486102c0c9c550f37d9d137]
stable/5.15: [518e49f0590de66555503aabe199ba8d3f2e24ac]

CVE-2022-49852: riscv: process: fix kernel info leakage

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49852

Introduced by commit 7db91e5 ("RISC-V: Task implementation") in v4.15-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c4601d30f7d989b4f354df899ab85b5f7a750d30]
mainline: [6510c78490c490a6636e48b61eeaa6fb65981f4b]
stable/4.19: [c4601d30f7d989b4f354df899ab85b5f7a750d30]
stable/5.10: [e56d18a976dda653194218df6d40d8122c775712]
stable/5.15: [cc36c7fa5d9384602529ba3eea8c5daee7be4dbc]
stable/5.4: [c5c0b3167537793a7cf936fb240366eefd2fc7fb]

CVE-2022-49853: net: macvlan: fix memory leaks of macvlan_common_newlink

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49853

Introduced by commit aa5fd0f ("driver: macvlan: Destroy new macvlan
port if macvlan_common_newlink failed.") in v4.9-rc6.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a81b44d1df1f07f00c0dcc0a0b3d2fa24a46289e]
mainline: [23569b5652ee8e8e55a12f7835f59af6f3cefc30]
stable/4.19: [a81b44d1df1f07f00c0dcc0a0b3d2fa24a46289e]
stable/5.10: [956e0216a19994443c90ba2ea6b0b284c9c4f9cb]
stable/5.15: [a8d67367ab33604326cc37ab44fd1801bf5691ba]
stable/5.4: [685e73e3f7a9fb75cbf049a9d0b7c45cc6b57b2e]

CVE-2022-49854: mctp: Fix an error handling path in mctp_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49854

Introduced by commit 4d8b931 ("mctp: Add neighbour implementation") in
v5.15-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4072058af4fd8fb4658e7452289042a406a9398]
stable/5.15: [49d8a6e24a3496d86e8d8ae748375df984fb6d6f]

CVE-2022-49855: net: wwan: iosm: fix memory leak in ipc_pcie_read_bios_cfg

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49855

Introduced by commit 7e98d78 ("net: iosm: entry point") in v5.14-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d38a648d2d6cc7bee11c6f533ff9426a00c2a74c]
stable/5.15: [13b1ea861e8aeb701bcfbfe436b943efa2d44029]

CVE-2022-49856: net: tun: call napi_schedule_prep() to ensure we own a napi

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49856


Introduced by commit 1118b20 ("net: tun: Fix memory leaks of napi_get_frags") in
6.1-rc5.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [310f0855352ee4b2eb38855c99185c23e6e1496b]
mainline: [07d120aa33cc9d9115753d159f64d20c94458781]
stable/5.10: [534762e261c84d43e5d56a780e40278b94c20540]
stable/5.15: [9132fa043f96ac545254ab326db5c6fd47d54acb]
stable/5.4: [30b0263d0366ea63aa7cad0407dfd945cc348580]

CVE-2022-49857: net: marvell: prestera: fix memory leak in
prestera_rxtx_switch_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49857

Introduced by commit 501ef30 ("net: marvell: prestera: Add driver for
Prestera family ASIC devices") in v5.10-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [519b58bbfa825f042fcf80261cc18e1e35f85ffd]
stable/5.10: [5333cf1b7f6861912aff6263978d4781f9858e47]
stable/5.15: [409731df6310a33f4d0a3ef594d2410cdcd637f2]

CVE-2022-49858: octeontx2-pf: Fix SQE threshold checking

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49858

Introduced by commit 3ca6c4c ("octeontx2-pf: Add packet transmission
support") in v5.6-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0dfc4c88ef39be0ba736aa0ce6119263fc19aeb]

CVE-2022-49859: net: lapbether: fix issue of invalid opcode in lapbeth_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49859

Introduced by commit 514e115 ("net: x25: Queue received packets in the
drivers instead of per-CPU queues") in v5.13-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3faf7e14ec0c3462c2d747fa6793b8645d1391df]
stable/5.15: [4689bd3a1b23a1bd917899e63b81bca2ccdfab45]

CVE-2022-49860: dmaengine: ti: k3-udma-glue: fix memory leak when
register device fail

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49860

Introduced by commit 5b65781 ("dmaengine: ti: k3-udma-glue: Add
support for K3 PKTDMA") in v5.11-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac2b9f34f02052709aea7b34bb2a165e1853eb41]
stable/5.15: [1dd27541aa2b95bde71bddd43d73f9c16d73272c]

CVE-2022-49861: dmaengine: mv_xor_v2: Fix a resource leak in mv_xor_v2_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49861

Introduced by commit 3cd2c31 ("dmaengine: mv_xor_v2: Fix clock
resource by adding a register clock") in v4.16-rc5.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [20479886b40c0ed4864a5fc8490a1f6b70cccf1b]
mainline: [081195d17a0c4c636da2b869bd5809d42e8cbb13]
stable/4.19: [20479886b40c0ed4864a5fc8490a1f6b70cccf1b]
stable/5.10: [0b7ee3d50f32d277bf024b4ddb4de54da43a3025]
stable/5.15: [992e966caf57e00855edbd79f19d911809732a69]
stable/5.4: [1d84887327659c58a6637060ac8c50c3a952a163]

CVE-2022-49862: tipc: fix the msg->req tlv len check in
tipc_nl_compat_name_table_dump_header

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49862

Introduced by commit 974cb0e ("tipc: fix uninit-value in
tipc_nl_compat_name_table_dump") in v5.0-rc3.
Fixed in v6.1-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [55a253a6753a603e80b95932ca971ba514aa6ce7]
cip/4.4-st: [0311a95aa8d9d03267bba533360199559c91fb99]
mainline: [1c075b192fe41030457cd4a5f7dea730412bca40]
stable/4.19: [55a253a6753a603e80b95932ca971ba514aa6ce7]
stable/5.10: [f31dd158580940938f77514b87337a777520185a]
stable/5.15: [301caa06091af4d5cf056ac8249cbda4e6029c6a]
stable/5.4: [36769b9477491a7af6635863bd950309c1e1b96c]

CVE-2022-49863: can: af_can: fix NULL pointer dereference in can_rx_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49863

Introduced by commit 4e096a1 ("net: introduce CAN specific pointer in
the struct net_device") in v5.12-rc1.
Fixed in v6.1-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [8aa59e355949442c408408c2d836e561794c40a1]
stable/5.10: [d68fa77ee3d03bad6fe84e89759ddf7005f9e9c6]
stable/5.15: [261178a1c2623077d62e374a75c195e6c99a6f05]
stable/5.4: [afab4655750fcb3fca359bc7d7214e3d634cdf9c]

CVE-2022-49864: drm/amdkfd: Fix NULL pointer dereference in svm_migrate_to_ram()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49864

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc4.
Introduced by commit 48ff079 ("drm/amdkfd: HMM migrate vram to ram")
in 5.14-rc1.

Fixed status
mainline: [5b994354af3cab770bf13386469c5725713679af]
stable/5.15: [3c1bb6187e566143f15dbf0367ae671584aead5b]

CVE-2022-49865: ipv6: addrlabel: fix infoleak when sending struct
ifaddrlblmsg to network

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49865

Introduced by commit 2a8cc6c ("[IPV6] ADDRCONF: Support RFC3484
configurable address selection policy table.") in v2.6.25-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6d26d0587abccb9835382a0b53faa7b9b1cd83e3]
cip/4.4-st: [0f8690d89dcc31c54ebf804fa81eeb708a283eb8]
mainline: [c23fb2c82267638f9d206cb96bb93e1f93ad7828]
stable/4.19: [6d26d0587abccb9835382a0b53faa7b9b1cd83e3]
stable/5.10: [a033b86c7f7621fde31f0364af8986f43b44914f]
stable/5.15: [2acb2779b147decd300c117683d5a32ce61c75d6]
stable/5.4: [58cd7fdc8c1e6c7873acc08f190069fed88d1c12]

CVE-2022-49866: net: wwan: mhi: fix memory leak in mhi_mbim_dellink

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49866

Introduced by commit aa730a9 ("net: wwan: Add MHI MBIM network
driver") in v5.15-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [668205b9c9f94d5ed6ab00cce9a46a654c2b5d16]
stable/5.15: [2845bc9070cef0c651987487d84d4813d64675dd]

CVE-2022-49867: net: wwan: iosm: fix memory leak in ipc_wwan_dellink

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49867

Introduced by commit 2a54f2c ("net: iosm: net driver") in v5.14-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f25caaca424703d5a0607310f0452f978f1f78d9]
stable/5.15: [2ce2348c2858d723f7fe389dead9b43b08e0944e]

CVE-2022-49868: phy: ralink: mt7621-pci: add sentinel to quirks table

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49868

Introduced by commit d87da32 ("phy: ralink: Add PHY driver for MT7621
PCIe PHY") in v5.11-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [819b885cd886c193782891c4f51bbcab3de119a4]
stable/5.15: [500bcd3a99eae84412067c3b9e7ffba1c66e6383]

CVE-2022-49869: bnxt_en: Fix possible crash in bnxt_hwrm_set_coal()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49869

Introduced by commit 2151fe0 ("bnxt_en: Handle RESET_NOTIFY async
event from firmware.") in v5.4-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d81ea3765dfa6c8a20822613c81edad1c4a16a0]
stable/5.10: [38147073c96dce8c7e142ce0e5f305a420a729ba]
stable/5.15: [ac257c43fa615d22180916074feed803b8bb8cb0]
stable/5.4: [a5a05fbef4a0dfe45fe03b2f1d02ba23aebf5384]

CVE-2022-49870: capabilities: fix undefined behavior in bit shift for
CAP_TO_MASK

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49870

Introduced by commit e338d26 ("Add 64-bit capability support to the
kernel") in v2.6.25-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dbaab08c8677d598244d21afb7818e44e1c5d826]
cip/4.4-st: [db45a8b3f8a4c015cb87abb079e0e54d4069bf17]
mainline: [46653972e3ea64f79e7f8ae3aa41a4d3fdb70a13]
stable/4.19: [dbaab08c8677d598244d21afb7818e44e1c5d826]
stable/5.10: [fcbd2b336834bd24e1d9454ad5737856470c10d7]
stable/5.15: [151dc8087b5609e53b069c068e3f3ee100efa586]
stable/5.4: [5661f111a1616ac105ec8cec81bff99b60f847ac]

CVE-2022-49871: net: tun: Fix memory leaks of napi_get_frags

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49871

Introduced by commit 90e33d4 ("tun: enable napi_gro_frags() for
TUN/TAP driver") in v4.15-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [223ef6a94e52331a6a7ef31e59921e0e82d2d40a]
mainline: [1118b2049d77ca0b505775fc1a8d1909cf19a7ec]
stable/4.19: [223ef6a94e52331a6a7ef31e59921e0e82d2d40a]
stable/5.10: [3401f964028ac941425b9b2c8ff8a022539ef44a]
stable/5.15: [d7569302a7a52a9305d2fb054df908ff985553bb]
stable/5.4: [a4f73f6adc53fd7a3f9771cbc89a03ef39b0b755]

CVE-2022-49872: net: gso: fix panic on frag_list with mixed head alloc types

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49872

Introduced by commit 3dcbdb1 ("net: gso: Fix skb_segment splat when
splitting gso_size mangled skb having linear-headed frag_list") in
v5.3.
Fixed in v6.1-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [bd5362e58721e4d0d1a37796593bd6e51536ce7a]
mainline: [9e4b7a99a03aefd37ba7bb1f022c8efab5019165]
stable/4.19: [bd5362e58721e4d0d1a37796593bd6e51536ce7a]
stable/5.10: [50868de7dc4e7f0fcadd6029f32bf4387c102ee6]
stable/5.15: [ad25a115f50800c6847e0d841c5c7992a9f7c1b3]
stable/5.4: [65ad047fd83502447269fda8fd26c99077a9af47]

CVE-2022-49873: bpf: Fix wrong reg type conversion in release_reference()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49873

Introduced by commit fd978bf ("bpf: Add reference tracking to
verifier") in v4.20-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1db20814af532f85e091231223e5e4818e8464b]
stable/5.10: [cedd4f01f67be94735f15123158f485028571037]
stable/5.15: [466ce46f251dfb259a8cbaa895ab9edd6fb56240]

CVE-2022-49874: HID: hyperv: fix possible memory leak in mousevsc_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49874

Introduced by commit 74c4fb0 ("HID: hv_mouse: Properly add the hid
device") in v3.3-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a6d2fb1874c52ace1f5cf1966ee558829c5c19b6]
cip/4.4-st: [fca0b18d733af5eefbae9fdfbbfb718131f4a00b]
mainline: [b5bcb94b0954a026bbd671741fdb00e7141f9c91]
stable/4.19: [a6d2fb1874c52ace1f5cf1966ee558829c5c19b6]
stable/5.10: [8597b59e3d22b27849bd3e4f92a3d466774bfb04]
stable/5.15: [5ad95d71344b7ffec360d62591633b3c465dc049]
stable/5.4: [e29289d0d8193fca6d2c1f0a1de75cfc80edec00]

CVE-2022-49875: bpftool: Fix NULL pointer dereference when pin {PROG,
MAP, LINK} without FILE

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49875

Introduced by commit 75a1e79 ("tools: bpftool: Allow all prog/map
handles for pinning objects") in v5.7-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34de8e6e0e1f66e431abf4123934a2581cb5f133]
stable/5.10: [8c80b2fca4112d724dde477aed13f7b0510a2792]
stable/5.15: [6dcdd1b68b7f9333d48d48fc77b75e7f235f6a4a]

CVE-2022-49876: wifi: mac80211: fix general-protection-fault in
ieee80211_subif_start_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49876

Introduced by commit f856373 ("wifi: mac80211: do not wake queues on a
vif that is being stopped") in v5.19-rc7.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [780854186946e0de2be192ee7fa5125666533b3a]

CVE-2022-49877: bpf, sockmap: Fix the sk->sk_forward_alloc warning of
sk_stream_kill_queues

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49877

Introduced by commit 84472b4 ("bpf, sockmap: Fix more uncharged while
msg has more_data") in v5.18-rc1.
Fixed in v6.1-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [8ec95b94716a1e4d126edc3fb2bc426a717e2dba]
stable/5.10: [cc21dc48a78cc9e5af9a4d039cd456446a6e73ff]
stable/5.15: [95adbd2ac8de82e43fd6b347e7e1b47f74dc1abb]
stable/5.4: [d975bec1eaeb52341acc9273db79ddb078220399]

CVE-2022-49878: bpf, verifier: Fix memory leak in array reallocation
for stack state

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49878

Introduced by commit c69431a ("bpf: verifier: Improve function state
reallocation") in v5.14-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42378a9ca55347102bbf86708776061d8fe3ece2]
stable/5.15: [06615967d4889b08b19ff3dda96e8b131282f73d]

CVE-2022-49879: ext4: fix BUG_ON() when directory entry has invalid rec_len

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49879

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc4.


Fixed status
mainline: [17a0bc9bd697f75cfdf9b378d5eb2d7409c91340]
stable/5.10: [156451a67b93986fb07c274ef6995ff40766c5ad]
stable/5.15: [999cff2b6ce3b45c08abf793bf55534777421327]
stable/5.4: [2fa24d0274fbf913b56ee31f15bc01168669d909]

CVE-2022-49880: ext4: fix warning in 'ext4_da_release_space'

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49880

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc4.


Fixed status
cip/4.19-st: [890d738f569fa9412b70ba09f15407f17a52da20]
cip/4.4-st: [60e6ba25dbf082d62ce32929969ae3f1ede3195a]
mainline: [1b8f787ef547230a3249bcf897221ef0cc78481b]
stable/4.19: [890d738f569fa9412b70ba09f15407f17a52da20]
stable/5.10: [5370b965b7a945bb8f48b9ee23d83a76a947902e]
stable/5.15: [0a43c015e98121c91a76154edf42280ce1a8a883]
stable/5.4: [72743d5598b9096950bbfd6a9b7f173d156eea97]

CVE-2022-49881: wifi: cfg80211: fix memory leak in query_regdb_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49881

Introduced by commit 007f6c5 ("cfg80211: support loading regulatory
database as firmware file") in v4.15-rc1.
Fixed in v6.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [219446396786330937bcd382a7bc4ccd767383bc]
mainline: [57b962e627ec0ae53d4d16d7bd1033e27e67677a]
stable/4.19: [219446396786330937bcd382a7bc4ccd767383bc]
stable/5.10: [e1e12180321f416d83444f2cdc9259e0f5093d35]
stable/5.15: [38c9fa2cc6bf4b6e1a74057aef8b5cffd23d3264]
stable/5.4: [0ede1a988299e95d54bd89551fd635980572e920]

CVE-2022-49882: KVM: Reject attempts to consume or refresh inactive
gfn_to_pfn_cache

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49882

Introduced by commit 982ed0d ("KVM: Reinstate gfn_to_pfn_cache with
invalidation support") in v5.17-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecbcf030b45666ad11bc98565e71dfbcb7be4393]

CVE-2022-49883: KVM: x86: smm: number of GPRs in the SMRAM image
depends on the image format

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49883

Introduced by commit b443183 ("KVM: x86: Reduce the number of emulator
GPRs to '8' for 32-bit KVM") in v6.0-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [696db303e54f7352623d9f640e6c51d8fa9d5588]

CVE-2022-49884: KVM: Initialize gfn_to_pfn_cache locks in dedicated helper

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49884

Introduced by commit 982ed0d ("KVM: Reinstate gfn_to_pfn_cache with
invalidation support") in v5.17-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52491a38b2c2411f3f0229dc6ad610349c704a41]

CVE-2022-49885: ACPI: APEI: Fix integer overflow in ghes_estatus_pool_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49885

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc2.
Introduced by commit fb7be08 ("ACPI / APEI: Make estatus pool
allocation a static size")
in 5.1-rc1.

Fixed status
mainline: [43d2748394c3feb86c0c771466f5847e274fc043]
stable/5.10: [9edf20e5a1d805855e78f241cf221d741b50d482]
stable/5.15: [c50ec15725e005e9fb20bce69b6c23b135a4a9b7]

CVE-2022-49886: x86/tdx: Panic on bad configs that #VE on "private"
memory access

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49886

Introduced by commit 9a22bf6 ("x86/traps: Add #VE support for TDX
guest") in v5.19-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [373e715e31bf4e0f129befe87613a278fac228d3]

CVE-2022-49887: media: meson: vdec: fix possible refcount leak in vdec_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49887

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc2.
Affected functions were added by commit 3e7f51b ("media: meson: add
v4l2 m2m video decoder driver")
in 5.3-rc1.

Fixed status
mainline: [7718999356234d9cc6a11b4641bb773928f1390f]
stable/5.10: [be6e22f54623d8a856a4f167b25be73c2ff1ff80]
stable/5.15: [f96ad391d054bd5c36994f98afd6a12cbb5600bf]
stable/5.4: [70119756311a0be3b95bec2e1ba714673e90feba]

CVE-2022-49888: arm64: entry: avoid kprobe recursion

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49888

Introduced by commit 6459b84 ("arm64: entry: consolidate Cortex-A76
erratum 1463225 workaround") in v5.12-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [024f4b2e1f874934943eb2d3d288ebc52c79f55c]
stable/5.15: [71d6c33fe223255f4416a01514da2c0bc3e283e7]

CVE-2022-49889: ring-buffer: Check for NULL cpu_buffer in
ring_buffer_wake_waiters()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49889

Introduced by commit f3ddb74 ("tracing: Wake up ring buffer waiters on
closing of the file") in 6.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [7433632c9ff68a991bd0bc38cabf354e9d2de410]
stable/5.15: [b5074df412bf3df9d6ce096b6fa03eb1082d05c9]

CVE-2022-49890: capabilities: fix potential memleak on error path from
vfs_getxattr_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49890

Introduced by commit 8db6c34 ("Introduce v3 namespaced file
capabilities") in v4.14-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [90577bcc01c4188416a47269f8433f70502abe98]
mainline: [8cf0a1bc12870d148ae830a4ba88cfdf0e879cee]
stable/4.19: [90577bcc01c4188416a47269f8433f70502abe98]
stable/5.10: [cdf01c807e974048c43c7fd3ca574f6086a57906]
stable/5.15: [2de8eec8afb75792440b8900a01d52b8f6742fd1]
stable/5.4: [0c3e6288da650d1ec911a259c77bc2d88e498603]

CVE-2022-49891: tracing: kprobe: Fix memory leak in
test_gen_kprobe/kretprobe_cmd()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49891

Introduced by commit 6483624 ("tracing: Add kprobe event command
generation test module") in v5.6-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66f0919c953ef7b55e5ab94389a013da2ce80a2c]
stable/5.10: [bef08acbe560a926b4cee9cc46404cc98ae5703b]
stable/5.15: [d1b6a8e3414aeaa0985139180c145d2d0fbd2a49]

CVE-2022-49892: ftrace: Fix use-after-free for dynamic ftrace_ops

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49892

Introduced by commit edb096e ("ftrace: Fix memleak when unregistering
dynamic ops when tracing disabled") in v4.14-rc1.
Fixed in v6.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [0e792b89e6800cd9cb4757a76a96f7ef3e8b6294]
stable/5.10: [ea5f2fd4640ecbb9df969bf8bb27733ae2183169]
stable/5.15: [88561a66777e7a2fe06638c6dcb22a9fae0b6733]

CVE-2022-49893: cxl/region: Fix cxl_region leak, cleanup targets at
region delete

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49893

Introduced by commit b9686e8 ("cxl/region: Enable the assignment of
endpoint decoders to regions") in v6.0-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d9e734018d70cecf79e2e4c6082167160a0f13f]

CVE-2022-49894: cxl/region: Fix region HPA ordering validation

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49894

Introduced by commit 384e624 ("cxl/region: Attach endpoint decoders")
in v6.0-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a90accb358ae33ea982a35595573f7a045993f8b]

CVE-2022-49895: cxl/region: Fix decoder allocation crash

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49895

Introduced by commit 384e624 ("cxl/region: Attach endpoint decoders")
in v6.0-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71ee71d7adcba648077997a29a91158d20c40b09]

CVE-2022-49896: cxl/pmem: Fix cxl_pmem_region and cxl_memdev leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49896

Introduced by commit 04ad63f ("cxl/region: Introduce cxl_pmem_region
objects") in v6.0-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d07ae22e79ebc2d7528bbc69daa53b86981cb3a]

CVE-2022-49897: fscrypt: fix keyring memory leak on mount failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49897


Introduced by commit d7e7b9a ("fscrypt: stop using keyrings subsystem for
fscrypt_master_key") in 6.1-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [ccd30a476f8e864732de220bd50e6f372f5ebcab]
stable/5.10: [29997a6fa60de1de2fa0de471e7652efa6e95868]
stable/5.15: [cff805b1518f38d57866065343db2285f2dcd5ab]

CVE-2022-49898: btrfs: fix tree mod log mishandling of reallocated nodes

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49898

Introduced by commit bd989ba ("Btrfs: add tree modification log
functions") in v3.5-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [968b71583130b6104c9f33ba60446d598e327a8b]
stable/5.15: [007058eb8292efc4c88f921752194b83269da085]

CVE-2022-49899: fscrypt: stop using keyrings subsystem for fscrypt_master_key

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49899

Introduced by commit 22d94f4 ("fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY
ioctl") in v5.4-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7e7b9af104c7b389a0c21eb26532511bce4b510]
stable/5.10: [391cceee6d435e616f68631e68f5b32d480b1e67]
stable/5.15: [e6f4fd85ef1ee6ab356bfbd64df28c1cb73aee7e]

CVE-2022-49900: i2c: piix4: Fix adapter not be removed in piix4_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49900

Introduced by commit 528d53a ("i2c: piix4: Fix probing of reserved
ports on AMD Family 16h Model 30h") in v5.4-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [569bea74c94d37785682b11bab76f557520477cd]
stable/5.10: [bfd5e62f9a7ee214661cb6f143a3b40ccc63317f]
stable/5.15: [d78ccdce662e88f41e87e90cf2bee63c1715d2a5]

CVE-2022-49901: blk-mq: Fix kmemleak in blk_mq_init_allocated_queue

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49901

Introduced by commit 2f8f133 ("blk-mq: always free hctx after request
queue is freed") in v5.2-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [943f45b9399ed8b2b5190cbc797995edaa97f58f]

CVE-2022-49902: block: Fix possible memory leak for rq_wb on add_disk failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49902

Introduced by commit 83cbce9 ("block: add error handling for
device_add_disk / add_disk") in v5.15-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa81cbafbf5764ad5053512152345fab37a1fe18]
stable/5.15: [4e68c5da60cd79950bd56287ae80b39d6261f995]

CVE-2022-49903: ipv6: fix WARNING in ip6_route_net_exit_late()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49903

Introduced by commit cdb1876 ("[NETNS][IPV6] route6 - create route6
proc files for the namespace") in v2.6.26-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [83fbf246ced54dadd7b9adc2a16efeff30ba944d]
mainline: [768b3c745fe5789f2430bdab02f35a9ad1148d97]
stable/4.19: [83fbf246ced54dadd7b9adc2a16efeff30ba944d]
stable/5.10: [5dbb47ee89762da433cd8458788d7640c85f1a07]
stable/5.15: [0ed71af4d017d2bd2cbb8f7254f613a4914def26]
stable/5.4: [381453770f731f0f43616a1cd4c759b7807a1517]

CVE-2022-49904: net, neigh: Fix null-ptr-deref in neigh_table_clear()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49904

Introduced by commit 66ba215 ("neigh: fix possible DoS due to net
iface start/stop loop") in v6.0-rc2.
Fixed in v6.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [b736592de2aa53aee2d48d6b129bc0c892007bbe]
mainline: [f8017317cb0b279b8ab98b0f3901a2e0ac880dad]
stable/4.19: [b736592de2aa53aee2d48d6b129bc0c892007bbe]
stable/5.10: [1c89642e7f2b7ecc9635610653f5c2f0276c0051]
stable/5.15: [2b45d6d0c41cb9593868e476681efb1aae5078a1]
stable/5.4: [b49f6b2f21f543d4dc88fb7b1ec2adccb822f27c]

CVE-2022-49905: net/smc: Fix possible leaked pernet namespace in smc_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49905

Introduced by commit 194730a ("net/smc: Make SMC statistics network
namespace aware") in v5.14-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62ff373da2534534c55debe6c724c7fe14adb97f]
stable/5.15: [61defd6450a9ef4a1487090449999b0fd83518ef]

CVE-2022-49906: ibmvnic: Free rwi on reset success

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49906

Introduced by commit 4f408e1 ("ibmvnic: retry reset if there are no
other resets") in v5.14-rc2.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6dd2fe71153f0ff748bf188bd4af076fe09a0a6]
stable/5.15: [535b78739ae75f257c894a05b1afa86ad9a3669e]

CVE-2022-49907: net: mdio: fix undefined behavior in bit shift for
__mdiobus_register

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49907

Introduced by commit 4fd5f81 ("phylib: allow incremental scanning of
an mii bus") in v2.6.28-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a3fafc974be37319679f36dc4e7cca7db1e02973]
cip/4.4-st: [91f5321f86ca8177096b48ef6158164cb8af8efd]
mainline: [40e4eb324c59e11fcb927aa46742d28aba6ecb8a]
stable/4.19: [a3fafc974be37319679f36dc4e7cca7db1e02973]
stable/5.10: [634f066d02bdb22a26da7deb0c7617ab1a65fc9d]
stable/5.15: [985a88bf0b27193522bba7856b1763f428cef19d]
stable/5.4: [4954b5359eb141499492fadfab891e28905509e2]

CVE-2022-49908: Bluetooth: L2CAP: Fix memory leak in vhci_write

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49908

Introduced by commit 4d7ea8e ("Bluetooth: L2CAP: Fix handling
fragmented length") in v5.12-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c9524d929648935bac2bbb4c20437df8f9c3f42]
stable/5.15: [aa16cac06b752e5f609c106735bd7838f444784c]

CVE-2022-49909: Bluetooth: L2CAP: fix use-after-free in l2cap_conn_del()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49909

Introduced by commit d0be834 ("Bluetooth: L2CAP: Fix use-after-free
caused by l2cap_chan_put") in v5.19.
Fixed in v6.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [7f7bfdd9a9af3b12c33d9da9a012e7f4d5c91f4b]
cip/4.4-st: [f7e57a06309762718752216dcdefb578f6df3dcf]
mainline: [0d0e2d032811280b927650ff3c15fe5020e82533]
stable/4.19: [7f7bfdd9a9af3b12c33d9da9a012e7f4d5c91f4b]
stable/5.10: [d9ec6e2fbd4a565b2345d4852f586b7ae3ab41fd]
stable/5.15: [a3a7b2ac64de232edb67279e804932cb42f0b52a]
stable/5.4: [c1f594dddd9ffd747c39f49cc5b67a9b7677d2ab]

CVE-2022-49910: Bluetooth: L2CAP: Fix use-after-free caused by
l2cap_reassemble_sdu

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49910

Introduced by commit d2a7ac5 ("Bluetooth: Add the ERTM receive state
machine") in v3.6-rc1.
Introduced by commit 4b51dae ("Bluetooth: Add streaming mode receive
and incoming packet classifier") in v3.6-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6c7407bfbeafc80a04e6eaedcf34d378532a04f2]
cip/4.4-st: [ebb58af21d44eb91e22cdb8fb6b2e1370c548790]
mainline: [3aff8aaca4e36dc8b17eaa011684881a80238966]
stable/4.19: [6c7407bfbeafc80a04e6eaedcf34d378532a04f2]
stable/5.10: [cb1c012099ef5904cd468bdb8d6fcdfdd9bcb569]
stable/5.15: [8278a87bb1eeea94350d675ef961ee5a03341fde]
stable/5.4: [4cd094fd5d872862ca278e15b9b51b07e915ef3f]

CVE-2022-49911: netfilter: ipset: enforce documented limit to prevent
allocating huge memory

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49911

Introduced by commit ccf0a4b ("netfilter: ipset: Add bucketsize
parameter to all hash types") in v5.11-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [510841da1fcc16f702440ab58ef0b4d82a9056b7]
stable/5.15: [42d20d5e24575c9afa2d66d9a51e7386db9514f5]

CVE-2022-49912: btrfs: fix ulist leaks in error paths of qgroup self tests

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49912

Introduced by commit 442244c ("btrfs: qgroup: Switch self test to
extent-oriented qgroup mechanism.") in v4.2-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [203204798831c35d855ecc6417d98267d2d2184b]
cip/4.4-st: [866c54ee4eaf8b6e7f5e7341ea3ac2c932560f93]
mainline: [d37de92b38932d40e4a251e876cc388f9aee5f42]
stable/4.19: [203204798831c35d855ecc6417d98267d2d2184b]
stable/5.10: [0a0dead4ad1a2e2a9bdf133ef45111d7c8daef84]
stable/5.15: [f46ea5fa3320dca4fe0c0926b49a5f14cb85de62]
stable/5.4: [5d1a47ebf84540e40b5b43fc21aef0d6c0f627d9]

CVE-2022-49913: btrfs: fix inode list leak during backref walking at
find_parent_nodes()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49913

Introduced by commit 86d5f99 ("btrfs: convert prelimary reference
tracking to use rbtrees") in v4.14-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92876eec382a0f19f33d09d2c939e9ca49038ae5]
stable/5.10: [61e06128113711df0534c404fb6bb528eb7d2332]
stable/5.15: [222a3d533027b9492d5b7f5ecdc01a90f57bb5a9]
stable/5.4: [6a6731a0df8c47ecc703bd7bb73459df767051e0]

CVE-2022-49914: btrfs: fix inode list leak during backref walking at
resolve_indirect_refs()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49914

Introduced by commit 3301958 ("Btrfs: add inodes before dropping the
extent lock in find_all_leafs") in v3.5-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cded2c89774b99b67c98147ae103ea878c92a206]
mainline: [5614dc3a47e3310fbc77ea3b67eaadd1c6417bf1]
stable/4.19: [cded2c89774b99b67c98147ae103ea878c92a206]
stable/5.10: [a52e24c7fcc3c5ce3588a14e3663c00868d36623]
stable/5.15: [6ba3479f9e96b9ad460c7e77abc26dd16e5dec4f]
stable/5.4: [2c0329406bb28109c07c6e23e5e3e0fa618a95d7]

CVE-2022-49915: mISDN: fix possible memory leak in mISDN_register_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49915

Introduced by commit 1fa5ae8 ("driver core: get rid of struct device's
bus_id string array") in v2.6.30-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a636fc5a7cabd05699b5692ad838c2c7a3abec7b]
cip/4.4-st: [837a1efa42b0ddcb93718c8e23ad3c496ceb552a]
mainline: [e7d1d4d9ac0dfa40be4c2c8abd0731659869b297]
stable/4.19: [a636fc5a7cabd05699b5692ad838c2c7a3abec7b]
stable/5.10: [e77d213843e67b4373285712699b692f9c743f61]
stable/5.15: [029d5b7688a2f3a86f2a3be5a6ba9cc968c80e41]
stable/5.4: [2ff6b669523d3b3d253a044fa9636a67d0694995]

CVE-2022-49916: rose: Fix NULL pointer dereference in rose_send_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49916

Introduced by commit 3c53cd6 ("rose: check NULL
rose_loopback_neigh->loopback") in v6.0-rc3.
Fixed in v6.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [5b46adfbee1e429f33b10a88d6c00fa88f3d6c77]
cip/4.4-st: [82fc575253a1e9692abc845e6f6b9026e24601c5]
mainline: [e97c089d7a49f67027395ddf70bf327eeac2611e]
stable/4.19: [5b46adfbee1e429f33b10a88d6c00fa88f3d6c77]
stable/5.10: [f06186e5271b980bac03f5c97276ed0146ddc9b0]
stable/5.15: [3e2129c67daca21043a26575108f6286c85e71f6]
stable/5.4: [b13be5e852b03f376058027e462fad4230240891]

CVE-2022-49917: ipvs: fix WARNING in ip_vs_app_net_cleanup()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49917

Introduced by commit 457c4cb ("[NET]: Make /proc/net per network
namespace") in v2.6.24-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [adc76740ccd52e4a1d910767cd1223e134a7078b]
mainline: [5663ed63adb9619c98ab7479aa4606fa9b7a548c]
stable/4.19: [adc76740ccd52e4a1d910767cd1223e134a7078b]
stable/5.10: [2c8d81bdb2684d53d6cedad7410ba4cf9090e343]
stable/5.15: [06d7596d18725f1a93cf817662d36050e5afb989]
stable/5.4: [8457a00c981fe1a799ce34123908856b0f5973b8]

CVE-2022-49918: ipvs: fix WARNING in __ip_vs_cleanup_batch()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49918

Introduced by commit 61b1ab4 ("IPVS: netns, add basic init per
netns.") in v2.6.39-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f08ee2aa24c076f81d84e26e213d8c6f4efd9f50]
mainline: [3d00c6a0da8ddcf75213e004765e4a42acc71d5d]
stable/4.19: [f08ee2aa24c076f81d84e26e213d8c6f4efd9f50]
stable/5.10: [931f56d59c854263b32075bfac56fdb3b1598d1b]
stable/5.15: [5ee2d6b726b0ce339e36569e5849692f4cf4595e]
stable/5.4: [7effc4ce3d1434ce6ff286866585a6e905fdbfc1]

CVE-2022-49919: netfilter: nf_tables: release flow rule object from commit path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49919

Introduced by commit 9dd732e ("netfilter: nf_tables: memleak flow rule
from commit path") in v5.19-rc2.
Fixed in v6.1-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [26b5934ff4194e13196bedcba373cd4915071d0e]
stable/5.10: [b2d7a92aff0fbd93c29d2aa6451fb99f050e2c4e]
stable/5.15: [6044791b7be707fd0e709f26e961a446424e5051]
stable/5.4: [74fd5839467054cd9c4d050614d3ee8788386171]

CVE-2022-49920: netfilter: nf_tables: netlink notifier might race to
release objects

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49920

Introduced by commit 6001a93 ("netfilter: nftables: introduce table
ownership") in v5.12-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4bc8271db21ea9f1c86a1ca4d64999f184d4aae]
stable/5.15: [1ffe7100411a8b9015115ce124cd6c9c9da6f8e3]

CVE-2022-49921: net: sched: Fix use after free in red_enqueue()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49921

Introduced by commit d7f4f33 ("sch_red: update backlog as well") in v4.7-rc3.
Fixed in v6.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [e877f8fa49fbccc63cb2df2e9179bddc695b825a]
cip/4.4-st: [6bdbc4a7f952f419c95c1397bbb247a4a653c73b]
mainline: [8bdc2acd420c6f3dd1f1c78750ec989f02a1e2b9]
stable/4.19: [e877f8fa49fbccc63cb2df2e9179bddc695b825a]
stable/5.10: [5960b9081baca85cc7dcb14aec1de85999ea9d36]
stable/5.15: [fc4b50adb400ee5ec527a04073174e8e73a139fa]
stable/5.4: [52e0429471976785c155bfbf51d80990c6cd46e2]

CVE-2022-49922: nfc: nfcmrvl: Fix potential memory leak in
nfcmrvl_i2c_nci_send()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49922

Introduced by commit b5b3e23 ("NFC: nfcmrvl: add i2c driver") in v4.4-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c8e7d4a1166f063703955f1b2e765a6db5bf1771]
cip/4.4-st: [fc5b70abf10ce4c4eec04a3c38e5f1d6fc76ab58]
mainline: [93d904a734a74c54d945a9884b4962977f1176cd]
stable/4.19: [c8e7d4a1166f063703955f1b2e765a6db5bf1771]
stable/5.10: [52438e734c1566f5e2bcd9a065d2d65e306c0555]
stable/5.15: [5dfdac5e3f8db5f4445228c44f64091045644a3b]
stable/5.4: [f30060efcf18883748a0541aa41acef183cd9c0e]

CVE-2022-49923: nfc: nxp-nci: Fix potential memory leak in nxp_nci_send()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49923

Introduced by commit dece458 ("NFC: nxp-nci: Add support for NXP NCI
chips") in v4.1-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bf1ed6aff0f70434bd0cdd45495e83f1dffb551]
stable/5.10: [9ae2c9a91ff068f4c3e392f47e8e26a1c9f85ebb]
stable/5.15: [3cba1f061bfe23fece2841129ca2862cdec29d5c]

CVE-2022-49924: nfc: fdp: Fix potential memory leak in fdp_nci_send()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49924

Introduced by commit a06347c ("NFC: Add Intel Fields Peak NFC solution
driver") in v4.4-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e4aae6b8ca76afb1fb64dcb24be44ba814e7f8a]
stable/5.10: [e8c11ee2d07f7c4dfa2ac0ea8efc4f627e58ea57]
stable/5.15: [44bc1868a4f542502ea2221fe5ad88ca66d1c6b6]

CVE-2022-49925: RDMA/core: Fix null-ptr-deref in ib_core_cleanup()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49925

Introduced by commit 03db3a2 ("IB/core: Add RoCE GID table
management") in v4.3-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07c0d131cc0fe1f3981a42958fc52d573d303d89]
stable/5.10: [d360e875c011a005628525bf290322058927e7dc]
stable/5.15: [6b3d5dcb12347f3518308c2c9d2cf72453a3e1e5]
stable/5.4: [af8fb5a0600e9ae29950e9422a032c3c22649ee5]

CVE-2022-49926: net: dsa: Fix possible memory leaks in dsa_loop_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49926

Introduced by commit 98cd155 ("net: dsa: Mock-up driver") in v4.12-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d593e1ede655b74c42e4e4fe285ea64aee96fb5c]
mainline: [633efc8b3dc96f56f5a57f2a49764853a2fa3f50]
stable/4.19: [d593e1ede655b74c42e4e4fe285ea64aee96fb5c]
stable/5.10: [37a098fc9b42bd7fce66764866aa514639667b6e]
stable/5.15: [9f555b1584fc2d5d16ee3c4d9438e93ac7c502c7]
stable/5.4: [bbc5d7b46a729bfcbb5544f6612b7a67dd4f4d6f]

CVE-2022-49927: nfs4: Fix kmemleak when allocate slot failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49927

Introduced by commit abf79bb ("NFS: Add a slot table to struct
nfs_client for NFSv4.0 transport blocking") in v3.12-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [86ce0e93cf6fb4d0c447323ac66577c642628b9d]
cip/4.4-st: [a479fcc3b2129bca5e3cc6e8fba54963eb137aa0]
mainline: [7e8436728e22181c3f12a5dbabd35ed3a8b8c593]
stable/4.19: [86ce0e93cf6fb4d0c447323ac66577c642628b9d]
stable/5.10: [45aea4fbf61e205649c29200726b9f45c1718a67]
stable/5.15: [24641993a7dce6b1628645f4e1d97ca06c9f765d]
stable/5.4: [925cb538bd5851154602818dc80bf4b4d924c127]

CVE-2022-49928: SUNRPC: Fix null-ptr-deref when xps sysfs alloc failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49928

Introduced by commit 2a338a5 ("sunrpc: add a symlink from rpc-client
directory to the xprt_switch") in v5.14-rc1.
Introduced by commit d408ebe ("sunrpc: add add sysfs directory per
xprt under each xprt_switch") in v5.14-rc1.
Introduced by commit baea994 ("sunrpc: add xprt_switch direcotry to
sunrpc's sysfs") in v5.14-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbdeaee94a415800c65a8c3fa04d9664a8b8fb3a]
stable/5.15: [d59722d088a9d86ce6d9d39979e5d1d669d249f7]

CVE-2022-49929: RDMA/rxe: Fix mr leak in RESPST_ERR_RNR

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49929

Introduced by commit 8a1a0be ("RDMA/rxe: Replace mr by rkey in
responder resources") in v5.18-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5f9a01fae42684648c2ee3cd9985f80c67ab9f7]

CVE-2022-49930: RDMA/hns: Fix NULL pointer problem in free_mr_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49930

Introduced by commit 70f9252 ("RDMA/hns: Use the reserved loopback QPs
to free MR before destroying MPT") in v5.18-rc1.
Fixed in v6.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12bcaf87d8b66d8cd812479c8a6349dcb245375c]

CVE-2022-49931: IB/hfi1: Correctly move list in sc_disable()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49931

Introduced by commit 13bac86 ("IB/hfi1: Fix abba locking issue with
sc_disable()") in v5.15.
Fixed in v6.1-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [1afac08b39d85437187bb2a92d89a741b1078f55]
stable/5.10: [7c4260f8f188df32414a5ecad63e8b934c2aa3f0]
stable/5.15: [ba95409d6b580501ff6d78efd00064f7df669926]
stable/5.4: [25760a41e3802f54aadcc31385543665ab349b8e]

CVE-2025-23139: Bluetooth: hci_uart: Fix another race during initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23139


Introduced by commit 366ceff ("Bluetooth: hci_uart: fix race during
initialization")
in 6.15-rc1.
Bug introduced commit was backported to following branches.
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.12 stable/6.14 stable/6.6

Fixed status
mainline: [5df5dafc171b90d0b8d51547a82657cd5a1986c7]
stable/5.10: [a40f94f7caa8d3421b64f63ac31bc0f24c890f39]
stable/5.15: [9e5a0f5777162e503400c70c6ed25fbbe2d38799]
stable/5.4: [1dcf08fcff5ca529de6dc0395091f28854f4e54a]
stable/6.1: [80f14e9de6a43a0bd8194cad1003a3e6dcbc3984]
stable/6.12: [281782d2c6730241e300d630bb9f200d831ede71]
stable/6.14: [db7509fa110dd9b11134b75894677f30353b2c51]
stable/6.6: [02e1bcdfdf769974e7e9fa285e295cd9852e2a38]

CVE-2025-23140: misc: pci_endpoint_test: Avoid issue of interrupts
remaining after request_irq error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23140

Introduced by commit e033271 ("pci_endpoint_test: Add 2 ioctl
commands") in v4.19-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6cb7828c8e17520d4f5afb416515d3fae1af9a9]
stable/5.10: [e516e187bf32d8decc7c7d0025ae4857cad13c0e]
stable/5.15: [54c9f299ad7d7c4be5d271ed12d01a59e95b8907]
stable/5.4: [705be96504779e4a333ea042b4779ea941f0ace9]
stable/6.1: [9d5118b107b1a2353ed0dff24404aee2e6b7ca0a]
stable/6.12: [0557e70e2aeba8647bf5a950820b67cfb86533db]
stable/6.14: [770407f6173f4f39f4e2c1b54422b79ce6c98bdb]
stable/6.6: [5a4b7181213268c9b07bef8800905528435db44a]

CVE-2025-23141: KVM: x86: Acquire SRCU in KVM_GET_MP_STATE to protect
guest memory accesses

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23141

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc2.


Fixed status
mainline: [ef01cac401f18647d62720cf773d7bb0541827da]
stable/6.1: [0357c8406dfa09430dd9858ebe813feb65524b6e]
stable/6.6: [8a3df0aa1087a89f5ce55f4aba816bfcb1ecf1be]

CVE-2025-23142: sctp: detect and prevent references to a freed
transport in sendmsg

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23142

Introduced by commit df132ef ("sctp: clear the transport of some
out_chunk_list chunks in sctp_assoc_rm_peer") in v4.20-rc1.
Fixed in v6.15-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [f1a69a940de58b16e8249dff26f74c8cc59b32be]
stable/5.10: [3257386be6a7eb8a8bfc9cbfb746df4eb4fc70e8]
stable/5.15: [0f7df4899299ce4662e5f95badb9dbc57cc37fa5]
stable/5.4: [547762250220325d350d0917a7231480e0f4142b]
stable/6.1: [7a63f4fb0efb4e69efd990cbb740a848679ec4b0]
stable/6.12: [9e7c37fadb3be1fc33073fcf10aa96d166caa697]
stable/6.14: [2e5068b7e0ae0a54f6cfd03a2f80977da657f1ee]
stable/6.6: [c6fefcb71d246baaf3bacdad1af7ff50ebcfe652]

CVE-2025-23143: net: Fix null-ptr-deref by
sock_lock_init_class_and_name() and rmmod.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23143

Introduced by commit ed07536 ("[PATCH] lockdep: annotate nfs/nfsd
in-kernel sockets") in v2.6.20.16.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bb2f7a1ad1f11d861f58e5ee5051c8974ff9569]

CVE-2025-23144: backlight: led_bl: Hold led_access lock when calling
led_sysfs_disable()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23144

Introduced by commit ae232e4 ("backlight: add led-backlight driver")
in v5.6-rc5.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
stable/5.10: [87d947a0607be384bfe7bb0935884a711e35ca07]
stable/5.15: [74c7d67a3c305fc1fa03c32a838e8446fb7aee14]
stable/6.1: [b447885ec9130cf86f355e011dc6b94d6ccfb5b7]
stable/6.12: [61a5c565fd2442d3128f3bab5f022658adc3a4e6]
stable/6.14: [b8ddf5107f53789448900f04fa220f34cd2f777e]
stable/6.6: [1c82f5a393d8b9a5c1ea032413719862098afd4b]

CVE-2025-23145: mptcp: fix NULL pointer in can_accept_new_subflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23145

Introduced by commit 9466a1c ("mptcp: enable JOIN requests even if
cookies are in use") in v5.9-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
stable/5.10: [8cf7fef1bb2ffea7792bcbf71ca00216cecc725d]
stable/5.15: [b3088bd2a6790c8efff139d86d7a9d0b1305977b]
stable/6.1: [855bf0aacd51fced11ea9aa0d5101ee0febaeadb]
stable/6.12: [dc81e41a307df523072186b241fa8244fecd7803]
stable/6.14: [4b2649b9717678aeb097893cc49f59311a1ecab0]
stable/6.6: [7f9ae060ed64aef8f174c5f1ea513825b1be9af1]

CVE-2025-23146: mfd: ene-kb3930: Fix a potential NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23146

Introduced by commit ede6b2d ("mfd: ene-kb3930: Add driver for ENE
KB3930 Embedded Controller") in v5.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cdf1d2a816a93fa02f7b6b5492dc7f55af2a199]
stable/5.10: [6dc88993ee3fa8365ff6a5d6514702f70ba6863a]
stable/5.15: [90ee23c2514a22a9c2bb39a540cbe1c9acb27d0b]
stable/6.1: [2edb5b29b197d90b4d08cd45e911c0bcf24cb895]
stable/6.12: [7b47df6498f223c8956bfe0d994a0e42a520dfcd]
stable/6.14: [76d0f4199bc5b51acb7b96c6663a8953543733ad]
stable/6.6: [ea07760676bba49319d553af80c239da053b5fb1]

CVE-2025-23147: i3c: Add NULL pointer check in i3c_master_queue_ibi()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23147

Introduced by commit 3a379bb ("i3c: Add core I3C infrastructure") in v5.0-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd496a44f041da9ef3afe14d1d6193d460424e91]
stable/5.10: [09359e7c8751961937cb5fc50220969b0a4e1058]
stable/5.15: [3ba402610843d7d15c7f3966a461deeeaff7fba4]
stable/5.4: [1b54faa5f47fa7c642179744aeff03f0810dc62e]
stable/6.1: [d83b0c03ef8fbea2f03029a1cc1f5041f0e1d47f]
stable/6.12: [e6bba328578feb58c614c11868c259b40484c5fa]
stable/6.14: [ff9d61db59bb27d16d3f872bff2620d50856b80c]
stable/6.6: [6871a676aa534e8f218279672e0445c725f81026]

CVE-2025-23148: soc: samsung: exynos-chipid: Add NULL pointer check in
exynos_chipid_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23148

Introduced by commit 3253b7b ("soc: samsung: Add exynos chipid driver
support") in v5.4-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8222ef6cf29dd7cad21643228f96535cc02b327]
stable/5.10: [8ce469d23205249bb17c1135ccadea879576adfc]
stable/5.15: [8ee067cf0cf82429e9b204283c7d0d8d6891d10e]
stable/6.1: [475b9b45dc32eba58ab794b5d47ac689fc018398]
stable/6.12: [44a2572a0fdcf3e7565763690d579b998a8f0562]
stable/6.14: [4129760e462f45f14e61b10408ace61aa7c2ed30]
stable/6.6: [5f80fd2ff8bfd13e41554741740e0ca8e6445ded]

CVE-2025-23149: tpm: do not start chip while suspended

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23149

Introduced by commit 9265fed ("tpm: Lock TPM chip in tpm_pm_suspend()
first") in v6.12-rc7.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [17d253af4c2c8a2acf84bb55a0c2045f150b7dfd]
stable/6.6: [1404dff1e11bf927b70ac25e1de97bed9742ede4]

CVE-2025-23150: ext4: fix off-by-one error in do_split

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23150

Introduced by commit 5872331 ("ext4: fix potential negative array
index in do_split()") in v5.9-rc2.
Fixed in v6.15-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
mainline: [94824ac9a8aaf2fb3c54b4bdde842db80ffa555d]
stable/5.10: [515c34cff899eb5dae6aa7eee01c1295b07d81af]
stable/5.15: [2883e9e74f73f9265e5f8d1aaaa89034b308e433]
stable/5.4: [b96bd2c3db26ad0daec5b78c85c098b53900e2e1]
stable/6.1: [35d0aa6db9d93307085871ceab8a729594a98162]
stable/6.12: [16d9067f00e3a7d1df7c3aa9c20d214923d27e10]
stable/6.14: [ab0cc5c25552ae0d20eae94b40a93be11b080fc5]
stable/6.6: [2eeb1085bf7bd5c7ba796ca4119925fa5d336a3f]

CVE-2025-23151: bus: mhi: host: Fix race between unprepare and queue_buf

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23151

Introduced by commit b89b6a8 ("bus: mhi: host: Add spinlock to protect
WP access when queueing TREs") in v6.8-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [0686a818d77a431fc3ba2fab4b46bbb04e8c9380]
stable/5.15: [899d0353ea69681f474b6bc9de32c663b89672da]
stable/6.1: [3e7ecf181cbdde9753204ada3883ca1704d8702b]
stable/6.12: [a77955f7704b2a00385e232cbcc1cb06b5c7a425]
stable/6.14: [ee1fce83ed56450087309b9b74ad9bcb2b010fa6]
stable/6.6: [5f084993c90d9d0b4a52a349ede5120f992a7ca1]

CVE-2025-23152: arm64/crc-t10dif: fix use of out-of-scope array in
crc_t10dif_arch()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23152

Introduced by commit 2051da8 ("arm64/crc-t10dif: expose CRC-T10DIF
function through lib") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d48b663f410f8b35b8ba9bd597bafaa00f53293b]

CVE-2025-23153: arm/crc-t10dif: fix use of out-of-scope array in
crc_t10dif_arch()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23153

Introduced by commit 1684e82 ("arm/crc-t10dif: expose CRC-T10DIF
function through lib") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3371f569223c4e8d36edbb0ba789ee5f5cb7316f]

CVE-2025-23154: io_uring/net: fix io_req_post_cqe abuse by send bundle

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23154

Introduced by commit a05d1f6 ("io_uring/net: support bundles for
send") in v6.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6889ae1b4df1579bcdffef023e2ea9a982565dff]

CVE-2025-23155: net: stmmac: Fix accessing freed irq affinity_hint

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23155

Introduced by commit 8deec94 ("net: stmmac: set IRQ affinity hint for
multi MSI vectors") in v5.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c60d101a226f18e9a8f01bb4c6ca2b47dfcb15ef]

CVE-2025-23156: media: venus: hfi_parser: refactor hfi packet parsing logic

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23156

Introduced by commit 1a73374 ("media: venus: hfi_parser: add common
capability parser") in v4.19-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9edaaa8e3e15aab1ca413ab50556de1975bcb329]
stable/5.10: [0beabe9b49190a02321b02792b29fc0f0e28b51f]
stable/5.15: [f195e94c7af921d99abd79f57026a218d191d2c7]
stable/6.1: [0f9a4bab7d83738963365372e4745854938eab2d]
stable/6.12: [bb3fd8b7906a12dc2b61389abb742bf6542d97fb]
stable/6.14: [6d278c5548d840c4d85d445347b2a5c31b2ab3a0]
stable/6.6: [05b07e52a0d08239147ba3460045855f4fb398de]

CVE-2025-23157: media: venus: hfi_parser: add check to avoid out of bound access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23157

Introduced by commit 1a73374 ("media: venus: hfi_parser: add common
capability parser") in v4.19-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [172bf5a9ef70a399bb227809db78442dc01d9e48]
stable/5.10: [2b8b9ea4e26a501eb220ea189e42b4527e65bdfa]
stable/5.15: [1ad6aa1464b8a5ce5c194458315021e8d216108e]
stable/5.4: [e5133a0b25463674903fdc0528e0a29b7267130e]
stable/6.1: [26bbedd06d85770581fda5d78e78539bb088fad1]
stable/6.12: [53e376178ceacca3ef1795038b22fc9ef45ff1d3]
stable/6.14: [cb5be9039f91979f8a2fac29f529f746d7848f3e]
stable/6.6: [d4d88ece4ba91df5b02f1d3f599650f9e9fc0f45]

CVE-2025-23158: media: venus: hfi: add check to handle incorrect queue size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23158

Introduced by commit d96d3f3 ("[media] media: venus: hfi: add Venus
HFI files") in v4.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69baf245b23e20efda0079238b27fc63ecf13de1]
stable/5.10: [a45957bcde529169188929816775a575de77d84f]
stable/5.15: [32af5c1fdb9bc274f52ee0472d3b060b18e4aab4]
stable/5.4: [1b86c1917e16bafbbb08ab90baaff533aa36c62d]
stable/6.1: [cf5f7bb4e0d786f4d9d50ae6b5963935eab71d75]
stable/6.12: [679424f8b31446f90080befd0300ea915485b096]
stable/6.14: [101a86619aab42bb61f2253bbf720121022eab86]
stable/6.6: [40084302f639b3fe954398c5ba5ee556b7242b54]

CVE-2025-23159: media: venus: hfi: add a check to handle OOB in sfr region

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23159

Introduced by commit d96d3f3 ("[media] media: venus: hfi: add Venus
HFI files") in v4.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4b211714bcc70effa60c34d9fa613d182e3ef1e]
stable/5.10: [8879397c0da5e5ec1515262995e82cdfd61b282a]
stable/5.15: [1b8fb257234e7d2d4b3f48af07c5aa5e11c71634]
stable/5.4: [4dd109038d513b92d4d33524ffc89ba32e02ba48]
stable/6.1: [4e95233af57715d81830fe82b408c633edff59f4]
stable/6.12: [530f623f56a6680792499a8404083e17f8ec51f4]
stable/6.14: [d78a8388a27b265fcb2b8d064f088168ac9356b0]
stable/6.6: [5af611c70fb889d46d2f654b8996746e59556750]

CVE-2025-23160: media: mediatek: vcodec: Fix a resource leak related
to the scp device in FW initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23160

Introduced by commit 53dbe08 ("media: mtk-vcodec: potential null
pointer deference in SCP") in v6.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [4936cd5817af35d23e4d283f48fa59a18ef481e4]
stable/6.6: [fd7bb97ede487b9f075707b7408a9073e0d474b1]

CVE-2025-23161: PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23161

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Introduced by commit 185a383 ("x86/PCI: Add driver for Intel Volume
Management Device (VMD)")
in 4.5-rc1.

Fixed status
mainline: [18056a48669a040bef491e63b25896561ee14d90]
stable/5.15: [c250262d6485ca333e9821f85b07eb383ec546b1]
stable/6.1: [c2968c812339593ac6e2bdd5cc3adabe3f05fa53]
stable/6.12: [5c3cfcf0b4bf43530788b08a8eaf7896ec567484]
stable/6.14: [20d0a9062c031068fa39f725a32f182b709b5525]
stable/6.6: [13e5148f70e81991acbe0bab5b1b50ba699116e7]

CVE-2025-23162: drm/xe/vf: Don't try to trigger a full GT reset if VF

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23162

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
xe_gt.c was added by dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs")
in 6.8-rc1. xe_gt_sriov_vf.[ch] was added by f2345ed ("drm/xe/vf: Add
support for
VF to query its configuration") in 6.11-rc1.

Fixed status
mainline: [459777724d306315070d24608fcd89aea85516d6]

CVE-2025-23163: net: vlan: don't propagate flags on open

Announce: https://www.cve.org/CVERecord?id=CVE-2025-23163

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [27b918007d96402aba10ed52a6af8015230f1793]
stable/5.10: [b1e3eeb037256a2f1206a8d69810ec47eb152026]
stable/5.15: [523fa0979d842443aa14b80002e45b471cbac137]
stable/5.4: [a32f1d4f1f4c9d978698f3c718621f6198f2e7ac]
stable/6.1: [53fb25e90c0a503a17c639341ba5e755cb2feb5c]
stable/6.12: [299d7d27af6b5844cda06a0fdfa635705e1bc50f]
stable/6.14: [538b43aa21e3b17c110104efd218b966d2eda5f8]
stable/6.6: [d537859e56bcc3091805c524484a4c85386b3cc8]

CVE-2025-37738: ext4: ignore xattrs past end

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37738

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [c8e008b60492cf6fd31ef127aea6d02fd3d314cd]
stable/5.10: [76c365fa7e2a8bb85f0190cdb4b8cdc99b2fdce3]
stable/5.15: [f737418b6de31c962c7192777ee4018906975383]
stable/5.4: [6aff941cb0f7d0c897c3698ad2e30672709135e3]
stable/6.1: [cf9291a3449b04688b81e32621e88de8f4314b54]
stable/6.12: [eb59cc31b6ea076021d14b04e7faab1636b87d0e]
stable/6.14: [836e625b03a666cf93ff5be328c8cb30336db872]
stable/6.6: [362a90cecd36e8a5c415966d0b75b04a0270e4dd]

CVE-2025-37739: f2fs: fix to avoid out-of-bounds access in
f2fs_truncate_inode_blocks()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37739

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [e6494977bd4a83862118a05f57a8df40256951c0]
stable/5.10: [a67e1bf03c609a751d1740a1789af25e599966fa]
stable/5.15: [67e16ccba74dd8de0a7b10062f1e02d77432f573]
stable/6.1: [98dbf2af63de0b551082c9bc48333910e009b09f]
stable/6.12: [ecc461331604b07cdbdb7360dbdf78471653264c]
stable/6.14: [6ba8b41d0aa4b82f90f0c416cb53fcef9696525d]
stable/6.6: [8b5e5aac44fee122947a269f9034c048e4c295de]

CVE-2025-37740: jfs: add sanity check for agwidth in dbMount

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37740

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [ddf2846f22e8575d6b4b6a66f2100f168b8cd73d]
stable/5.10: [722e72f7f9c69fcb3ab7988c2471feff7a4c8de1]
stable/5.15: [a741f29ac8b6374c9904be8b7ac7cdfcd7e7e4fa]
stable/5.4: [a065cec230aa807c18828a3eee82f1c8592c2adf]
stable/6.1: [a260bf14cd347878f01f70739ba829442a474a16]
stable/6.12: [ccd97c8a4f90810f228ee40d1055148fa146dd57]
stable/6.14: [e3f85edb03183fb06539e5b50dd2c4bb42b869f0]
stable/6.6: [cc0bc4cb62ce5fa0c383e3bf0765d01f46bd49ac]

CVE-2025-37741: jfs: Prevent copying of nlink with value 0 from disk inode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37741

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [b61e69bb1c049cf507e3c654fa3dc1568231bd07]
stable/5.15: [4f10732712fce33e53703ffe5ed9155f23814097]
stable/6.1: [cab1852368dd74d629ee02abdbc559218ca64dde]
stable/6.12: [63148ce4904faa668daffdd1d3c1199ae315ef2c]
stable/6.14: [d0d7eca253ccd0619b3d2b683ffe32218ebca9ac]
stable/6.6: [067347e00a3a7d04afed93f080c6c131e5dd15ee]

CVE-2025-37742: jfs: Fix uninit-value access of imap allocated in the
diMount() function

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37742

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [9629d7d66c621671d9a47afe27ca9336bfc8a9ea]
stable/5.15: [4f10732712fce33e53703ffe5ed9155f23814097]
stable/6.1: [cab1852368dd74d629ee02abdbc559218ca64dde]
stable/6.12: [63148ce4904faa668daffdd1d3c1199ae315ef2c]
stable/6.14: [d0d7eca253ccd0619b3d2b683ffe32218ebca9ac]
stable/6.6: [067347e00a3a7d04afed93f080c6c131e5dd15ee]

CVE-2025-37743: wifi: ath12k: Avoid memory leak while enabling statistics

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37743

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ath12k driver was added by commit d889913 ("wifi: ath12k: driver for
Qualcomm Wi-Fi 7 devices")
in 6.3-rc1.

Fixed status
mainline: [ecfc131389923405be8e7a6f4408fd9321e4d19b]

CVE-2025-37744: wifi: ath12k: fix memory leak in ath12k_pci_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37744

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
ath12k driver was added by commit d889913 ("wifi: ath12k: driver for
Qualcomm Wi-Fi 7 devices")
in 6.3-rc1.

Fixed status
mainline: [1b24394ed5c8a8d8f7b9e3aa9044c31495d46f2e]

CVE-2025-37745: PM: hibernate: Avoid deadlock in
hibernate_compressor_param_set()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37745

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Affected function was added by commit 3fec6e5 ("PM: hibernate: Support
to select compression algorithm")
in 6.9-rc1.

Fixed status
mainline: [52323ed1444ea5c2a5f1754ea0a2d9c8c216ccdf]

CVE-2025-37746: perf/dwc_pcie: fix duplicate pci_dev devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37746

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Affected file was added by af9597a ("drivers/perf: add DesignWare PCIe
PMU driver")
in 6.8-rc1.

Fixed status
mainline: [7f35b429802a8065aa61e2a3f567089649f4d98e]

CVE-2025-37747: perf: Fix hang while freeing sigtrap event

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37747

Introduced by commit 3a54654 ("perf: Fix event leak upon exec and file
release") in v6.11-rc1.
Fixed in v6.15-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [56799bc035658738f362acec3e7647bb84e68933]

CVE-2025-37748: iommu/mediatek: Fix NULL pointer deference in
mtk_iommu_device_group

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37748

Introduced by commit 9e3a2a6 ("iommu/mediatek: Adapt sharing and
non-sharing pgtable case") in v5.19-rc1.
Introduced by commit bcb81ac ("iommu: Get DT/ACPI parsing into the
proper probe path") in v6.15-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38e8844005e6068f336a3ad45451a562a0040ca1]
stable/6.1: [2f75cb27bef43c8692b0f5e471e5632f6a9beb99]
stable/6.6: [6abd09bed43b8d83d461e0fb5b9a200a06aa8a27]

CVE-2025-37749: net: ppp: Add bound checking for skb data on ppp_sync_txmung

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37749

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aabc6596ffb377c4c9c8f335124b92ea282c9821]
stable/5.10: [de5a4f0cba58625e88b7bebd88f780c8c0150997]
stable/5.15: [99aa698dec342a07125d733e39aab4394b3b7e05]
stable/5.4: [529401c8f12ecc35f9ea5d946d5a5596cf172b48]
stable/6.1: [b78f2b458f56a5a4d976c8e01c43dbf58d3ea2ca]
stable/6.12: [b4c836d33ca888695b2f2665f948bc1b34fbd533]
stable/6.14: [6e8a6bf43cea4347121ab21bb1ed8d7bef7e732e]
stable/6.6: [fbaffe8bccf148ece8ad67eb5d7aa852cabf59c8]

CVE-2025-37750: smb: client: fix UAF in decryption with multichannel

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37750

Introduced by commit f7025d8 ("smb: client: allocate crypto only for
primary server") in v6.12-rc1.
Introduced by commit b0abcd6 ("smb: client: fix UAF in async
decryption") in v6.12-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9502dd5c7029902f4a425bf959917a5a9e7c0e50]

CVE-2025-37751: x86/cpu: Avoid running off the end of an AMD erratum table

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37751

Introduced by commit f3f3251 ("x86/cpu: Move AMD erratum 1386 table
over to 'x86_cpu_id'") in v6.14-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0df00ebc57f803603f2a2e0df197e51f06fbe90]

CVE-2025-37752: net_sched: sch_sfq: move the limit validation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37752

Introduced by commit 1068568 ("net_sched: sch_sfq: don't allow 1
packet limit") in v6.14-rc1.
Fixed in v6.15-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [b3bf8f63e6179076b57c9de660c9f80b5abefe70]
stable/6.1: [1348214fa042a71406964097e743c87a42c85a49]
stable/6.6: [d2718324f9e329b10ddc091fba5a0ba2b9d4d96a]

CVE-2025-37753: s390/cpumf: Fix double free on error in cpumf_pmu_event_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37753

Introduced by commit c70ca29 ("perf/core: Simplify the
perf_event_alloc() error path") in v6.15-rc1.
Fixed in v6.12.24.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.14

Fixed status
mainline: [bdbecb2bf531fadbbc9347a79009f7a58ea7eb03]

CVE-2025-37754: drm/i915/huc: Fix fence not released on early probe errors

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37754

Introduced by commit 27536e0 ("drm/i915/huc: track delayed HuC load
with a fence") in v6.2-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3ea2eae70692a455e256787e4f54153fb739b90]
stable/6.6: [9f5ef4a5eaa61a7a4ed31231da45deb85065397a]

CVE-2025-37755: net: libwx: handle page_pool_dev_alloc_pages error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37755

Introduced by commit 3c47e8a ("net: libwx: Support to receive packets
in NAPI") in v6.3-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f1ff1b38a7c8b872382b796023419d87d78c47e]
stable/6.6: [c17ef974bfcf1a50818168b47c4606b425a957c4]

CVE-2025-37756: net: tls: explicitly disallow disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37756

Introduced by commit 3c4d755 ("tls: kernel TLS support") in v4.13-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5071a1e606b30c0c11278d3c6620cd6a24724cf6]
stable/5.10: [7bdcf5bc35ae59fc4a0fa23276e84b4d1534a3cf]
stable/5.15: [ac91c6125468be720eafde9c973994cb45b61d44]
stable/6.1: [f3ce4d3f874ab7919edca364c147ac735f9f1d04]
stable/6.12: [9fcbca0f801580cbb583e9cb274e2c7fbe766ca6]
stable/6.14: [8513411ec321942bd3cfed53d5bb700665c67d86]
stable/6.6: [2bcad8fefcecdd5f005d8c550b25d703c063c34a]

CVE-2025-37757: tipc: fix memory leak in tipc_link_xmit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37757

Introduced by commit 365ad35 ("tipc: reduce risk of user starvation
during link congestion") in v4.11-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69ae94725f4fc9e75219d2d69022029c5b24bc9a]
stable/5.10: [d4d40e437adb376be16b3a12dd5c63f0fa768247]
stable/5.15: [ed06675d3b8cd37120b447646d53f7cd3e6fcd63]
stable/5.4: [84895f5ce3829d9fc030e5ec2d8729da4c0c9d08]
stable/6.1: [24e6280cdd7f8d01fc6b9b365fb800c2fb7ea9bb]
stable/6.12: [7c5957f7905b4aede9d7a559d271438f3ca9e852]
stable/6.14: [a40cbfbb8f95c325430f017883da669b2aa927d4]
stable/6.6: [09c2dcda2c551bba30710c33f6ac678ae7395389]

CVE-2025-37758: ata: pata_pxa: Fix potential NULL pointer dereference
in pxa_ata_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37758

Introduced by commit 2dc6c6f ("[ARM] pata_pxa: DMA-capable PATA
driver") in v2.6.36-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad320e408a8c95a282ab9c05cdf0c9b95e317985]
stable/5.10: [17d5e6e915fad5a261db3698c9c5bbe702102d7c]
stable/5.15: [d0d720f9282839b9db625a376c02a1426a16b0ae]
stable/5.4: [a551f75401793ba8075d7f46ffc931ce5151f03f]
stable/6.1: [2dc53c7a0c1f57b082931facafa804a7ca32a9a6]
stable/6.12: [ee2b0301d6bfe16b35d57947687c664ecb815775]
stable/6.14: [2ba9e4c69207777bb0775c7c091800ecd69de144]
stable/6.6: [5b09bf6243b0bc0ae58bd9efdf6f0de5546f8d06]

CVE-2025-37759: ublk: fix handling recovery & reissue in ublk_abort_queue()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37759

Introduced by commit 8284066 ("ublk: grab request reference when the
request is handled by userspace") in v6.5-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ee6bd5d4fce502a5b5a2ea805e9ff16e6aa890f]

CVE-2025-37760: mm/vma: add give_up_on_oom option on modify/merge, use
in uffd release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37760

Introduced by commit 47b16d0 ("mm: abort vma_modify() on merge out of
memory failure") in v6.14-rc6.
Fixed in v6.15-rc3.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [41e6ddcaa0f18dda4c3fadf22533775a30d6f72f]

CVE-2025-37761: drm/xe: Fix an out-of-bounds shift when invalidating TLB

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37761

Introduced by commit 332dd01 ("drm/xe: Add range based TLB
invalidations") in v6.8-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bcfeddb36b77f9fe3b010bb0b282b7618420bba]

CVE-2025-37762: drm/virtio: Fix missed dmabuf unpinning in error path
of prepare_fb()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37762

Introduced by commit 4a696a2 ("drm/virtio: Add prepare and cleanup
routines for imported dmabuf obj") in v6.14-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [395cc80051f8da267b27496a4029dd931a198855]

CVE-2025-37763: drm/imagination: take paired job reference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37763

Introduced by commit eaf01ee ("drm/imagination: Implement job
submission and scheduling") in v6.8-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ba2abe154ef68f9612eee9d6fbfe53a1736b064]

CVE-2025-37764: drm/imagination: fix firmware memory leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37764

Introduced by commit cc1aeed ("drm/imagination: Implement firmware
infrastructure and META FW support") in v6.8-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5b230e7f3a55bd8bd8d012eec75a4b7baa671d5]

CVE-2025-37765: drm/nouveau: prime: fix ttm_bo_delayed_delete oops

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37765

Introduced by commit 22b33e8 ("nouveau: add PRIME support") in v3.5-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ec0fbb28d049273bfd4f1e7a5ae4c74884beed3]
stable/5.10: [47761deabb69a5df0c2c4ec400d80bb3e072bd2e]
stable/5.15: [ada78110b2d3ec88b398a49703bd336d4cee7a08]
stable/5.4: [706868a1a1072cffd8bd63f7e161d79141099849]
stable/6.1: [12b038d521c75e3521522503becf3bc162628469]
stable/6.12: [6e2c805996a49998d31ac522beb1534ca417e761]
stable/6.14: [6b95947ee780f4e1fb26413a1437d05bcb99712b]
stable/6.6: [31e94c7989572f96926673614a3b958915a13ca9]

CVE-2025-37766: drm/amd/pm: Prevent division by zero

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37766

Introduced by commit 031db09 ("drm/amd/powerplay/vega20: enable fan
RPM and pwm settings V2") in v4.20-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e3d9508c056d7e0a56b58d5c81253e2a0d22b6c]
stable/5.10: [ce773dd844ee19a605af27f11470887e0f2044a9]
stable/5.15: [80814924260cea431a8fc6137d11cc8cb331a10c]
stable/5.4: [6b9f9b998b107c7539f148a013d789ddb860c3b9]
stable/6.1: [ffd688804425579a472fbd2525bedb58b1d28bd9]
stable/6.12: [42f7b5d12c28b2a601a98d10a80c6db1fe1a2900]
stable/6.14: [affd2241927a1e74c0aecd50c2d920dc4213c56d]
stable/6.6: [068091b796480819bf70b159f17e222ad8bea900]

CVE-2022-49932: KVM: VMX: Do _all_ initialization before exposing
/dev/kvm to userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49932

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.


Fixed status
mainline: [e32b120071ea114efc0b4ddd439547750b85f618]
stable/6.1: [e136e969d268b9b89329c816c002e53f60e82985]

CVE-2022-49933: KVM: VMX: Reset eVMCS controls in VP assist page
during hardware disabling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49933

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.


Fixed status
mainline: [2916b70fc342719f570640de07251b7f91feebdb]
stable/6.1: [afb26bfc01db6ef4728e96314f08431934ffe833]

CVE-2023-53035: nilfs2: fix kernel-infoleak in nilfs_ioctl_wrap_copy()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53035

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc4.


Fixed status
cip/4.19-st: [9c5034e9a0e03db8d5e9eabb176340259b5b97e4]
cip/4.4-st: [0381c91da49c6229b8aad4ebdf0392efd2a121cf]
mainline: [003587000276f81d0114b5ce773d80c119d8cb30]
stable/4.19: [9c5034e9a0e03db8d5e9eabb176340259b5b97e4]
stable/5.10: [d18db946cc6a394291539e030df32324285648f7]
stable/5.15: [5bb105cc72beb9d51bf12f5c657336d2d35bdc5d]
stable/5.4: [8f5cbf6a8c0e19b062b829c5b7aca01468bb57f6]
stable/6.1: [5f33b042f74fc9662eba17f4cd19b07d84bbc6c5]

CVE-2023-53036: drm/amdgpu: Fix call trace warning and hang when
removing amdgpu device

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53036

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc2.
Affected function amdgpu_bo_release_notify was added by commit ab2f7a5
("drm/amdgpu:
Implement VRAM wipe on release") in 5.4-rc1.

Fixed status
mainline: [93bb18d2a873d2fa9625c8ea927723660a868b95]
stable/6.1: [f06b902511ea05526f405ee64da54a8313d91831]

CVE-2023-53037: scsi: mpi3mr: Bad drive in topology results kernel crash

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53037

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc2.


Fixed status
mainline: [8e45183978d64699df639e795235433a60f35047]
stable/6.1: [1f822ae8fb2a20fffa71e9bfa9b203c03d72d3ba]

CVE-2023-53038: scsi: lpfc: Check kzalloc() in lpfc_sli4_cgn_params_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53038

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc2.
Introduced by 72df8a4 ("scsi: lpfc: Add support for cm enablement
buffer") in 5.15-rc1.

Fixed status
mainline: [312320b0e0ec21249a17645683fe5304d796aec1]
stable/5.15: [67b8343998b84418bc5b5206aa01fe9b461a80ef]
stable/6.1: [4829a1e1171536978b240a1438789c2e4d5c9715]

CVE-2023-53039: HID: intel-ish-hid: ipc: Fix potential use-after-free
in work function

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53039

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc2.
Affected file was added by commit ae02e5d ("HID: intel-ish-hid: ipc
layer") in 4.9-rc1.

Fixed status
mainline: [8ae2f2b0a28416ed2f6d8478ac8b9f7862f36785]
stable/5.15: [8c1d378b8c224fd50247625255f09fc01dcc5836]
stable/6.1: [0a594cb490ca6232671fc09e2dc1a0fc7ccbb0b5]

CVE-2023-53040: ca8210: fix mac_len negative array access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53040

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc2.
Affected function was added by ded845a ("ieee802154: Add CA8210 IEEE 802.15.4
device driver") in 4.12-rc1.

Fixed status
cip/4.19-st: [5da4469a7aa011de614c3e2ae383c35a353a382e]
mainline: [6c993779ea1d0cccdb3a5d7d45446dd229e610a3]
stable/4.19: [5da4469a7aa011de614c3e2ae383c35a353a382e]
stable/5.10: [7df72bedbdd1d02bb216e1f6eca0a16900238c4e]
stable/5.15: [d143e327c97241599c958d1ba9fbaa88c37db721]
stable/5.4: [d2b3bd0d4cadfdb7f3454d2aef9d5d9e8b48aae4]
stable/6.1: [fd176a18db96d574d8c4763708abcec4444a08b6]

CVE-2023-53041: scsi: qla2xxx: Perform lockless command completion in abort path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53041

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc4.


Fixed status
mainline: [0367076b0817d5c75dfb83001ce7ce5c64d803a9]
stable/5.10: [231cfa78ec5badd84a1a2b09465bfad1a926aba1]
stable/5.15: [d6f7377528d2abf338e504126e44439541be8f7d]
stable/5.4: [9189f20b4c5307c0998682bb522e481b4567a8b8]
stable/6.1: [cd0a1804ac5bab2545ac700c8d0fe9ae9284c567]

CVE-2023-53042: drm/amd/display: Do not set DRR on pipe Commit

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53042

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc3.
Affected file was added by d99f138 ("drm/amd/display: Add DCN3 HWSEQ")
in 5.9-rc1.

Fixed status
mainline: [56574f89dbd84004c3fd6485bcaafb5aa9b8be14]
stable/6.1: [f8080f1e300e7abcc03025ec8b5bab69ae98daaa]

CVE-2023-53043: arm64: dts: qcom: sc7280: Mark PCIe controller as cache coherent

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53043

Introduced by commit 92e0ee9 ("arm64: dts: qcom: sc7280: Add PCIe and
PHY related node") in v5.16-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a63441e83724fee1ef3fd37b237d40d90780766]
stable/6.1: [267b899375bf38944d915c9654d6eb434edad0ce]

CVE-2023-53044: dm stats: check for and propagate alloc_percpu failure

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53044

Introduced by commit fd2ed4d ("dm: add statistics support") in v3.12-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0d96bd507ed7e7d565b6d53ebd3874686f123b2e]
cip/4.4-st: [184e008226615af5d0b75631aaef9da38ed9022a]
mainline: [d3aa3e060c4a80827eb801fc448debc9daa7c46b]
stable/4.19: [0d96bd507ed7e7d565b6d53ebd3874686f123b2e]
stable/5.10: [c68f08cc745675a17894e1b4a5b5b9700ace6da4]
stable/5.15: [443c9d522397511a4328dc2ec3c9c63c73049756]
stable/5.4: [4a32a9a818a895671bd43e0c40351e60e4e9140b]
stable/6.1: [a42180dd361584816bfe15c137b665699b994d90]

CVE-2023-53045: usb: gadget: u_audio: don't let userspace block driver unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53045

Introduced by commit 132fcb4 ("usb: gadget: Add Audio Class 2.0
Driver") in v3.4-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3256e152b645fc1e788ba44c2d8ced690113e3e6]
mainline: [6c67ed9ad9b83e453e808f9b31a931a20a25629b]
stable/4.19: [3256e152b645fc1e788ba44c2d8ced690113e3e6]
stable/5.10: [33f341c1fc60e172a3515c51bdabee11e83d1ee9]
stable/5.15: [b131989797f7287d7fdadb2bababc05a15d44750]
stable/5.4: [0eda2004f38d95ef5715d62be884cd344260535b]
stable/6.1: [3bc7324e4911351e39c54a62e6ca46321cb10faf]

CVE-2023-53046: Bluetooth: Fix race condition in hci_cmd_sync_clear

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53046

Introduced by commit 6a98e38 ("Bluetooth: Add helper for serialized
HCI command execution") in v5.17-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c66bee492a5fe00ae3fe890bb693bfc99f994c6]
stable/6.1: [608901a77c945ac15dea23f6098c9882ef19d9f0]

CVE-2023-53047: tee: amdtee: fix race condition in amdtee_open_session

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53047

Introduced by commit 757cc3e ("tee: add AMD-TEE driver") in v5.6-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8502fba45bd30e1a6a354d9d898bc99d1a11e6d]
stable/5.10: [f632a90f8e39db39b322107b9a8d438b826a7f4f]
stable/5.15: [02b296978a2137d7128151c542e84dc96400bc00]
stable/6.1: [a63cce9393e4e7dbc5af82dc87e68cb321cb1a78]

CVE-2023-53048: usb: typec: tcpm: fix warning when handle
discover_identity message

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53048

Introduced by commit e00943e ("usb: typec: tcpm: PD3.0 sinks can send
Discover Identity even in device mode") in v5.13-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abfc4fa28f0160df61c7149567da4f6494dfb488]
stable/5.15: [bb579b3f75c60bf488a7c36e092e8be583407d53]
stable/6.1: [d55ca2d2ea1a7ec553213986993fba8c0257381c]

CVE-2023-53049: usb: ucsi: Fix NULL pointer deref in ucsi_connector_change()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53049

Introduced by commit bdc62f2 ("usb: typec: ucsi: Simplified
registration and I/O API") in v5.5-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f87fb985452ab2083967103ac00bfd68fb182764]
stable/5.10: [a6adfe9bbd6ac11e398b54ccd99a0f8eea09f3c0]
stable/5.15: [7dd27aed9c456670b3882877ef17a48195f21693]
stable/6.1: [1c5abcb13491da8c049f20462189c12c753ba978]

CVE-2023-53050: thunderbolt: Fix memory leak in margining

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53050

Introduced by commit d0f1e0c ("thunderbolt: Add support for receiver
lane margining") in v6.1-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acec726473822bc6b585961f4ca2a11fa7f28341]
stable/6.1: [f390095bbd131ec2dfb29792d9f6fd0f0656bfc0]

CVE-2023-53051: dm crypt: add cond_resched() to dmcrypt_write()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53051

Introduced by commit dc26762 ("dm crypt: offload writes to thread") in v4.0-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7b9f8efb5fc888dd938d2964e705b8e00f1dc0f6]
cip/4.4-st: [e6c1ace928530c39e80b9e94d46cf9e82056854d]
mainline: [fb294b1c0ba982144ca467a75e7d01ff26304e2b]
stable/4.19: [7b9f8efb5fc888dd938d2964e705b8e00f1dc0f6]
stable/5.10: [66ff37993dd7e9954b6446237fe2453b380ce40d]
stable/5.15: [eb485b7404a281d974bd445ddc5b0b8d5958f371]
stable/5.4: [885c28ceae7dab2b18c2cc0eb95f1f82b1f629d1]
stable/6.1: [f0eb61b493dbbc32529fbd0d2e945b71b0e47306]

CVE-2023-53052: cifs: fix use-after-free bug in refresh_cache_worker()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53052

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc3.


Fixed status
mainline: [396935de145589c8bfe552fa03a5e38604071829]

CVE-2023-53053: erspan: do not use skb_mac_header() in ndo_start_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53053

Introduced by commit 1baf5eb ("erspan: auto detect truncated
packets.") in v4.18-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [da149daf821a3c05cd04f7c60776c86c5ee9685c]
mainline: [8e50ed774554f93d55426039b27b1e38d7fa64d8]
stable/4.19: [da149daf821a3c05cd04f7c60776c86c5ee9685c]
stable/5.10: [f8cec30541f5c5cc218e9a32138d45d227727f2f]
stable/5.15: [b41f37dbd9cdb60000e3b0dfad6df787591c2265]
stable/5.4: [b72f453e886af532bde1fd049a2d2421999630d3]
stable/6.1: [9c7d6803689c99d55bbb862260d0ba486ff23c0b]

CVE-2023-53054: usb: dwc2: fix a devres leak in hw_enable upon suspend resume

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53054

Introduced by commit 54c1960 ("usb: dwc2: Always disable regulators on
driver teardown") in v5.10-rc1.
Introduced by commit 33a06f1 ("usb: dwc2: Fix error path in gadget
registration") in v5.9-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f747313249b74f323ddf841a9c8db14d989f296a]
stable/5.10: [1f01027c51eb16145e8e07fafea3ca07ef102d06]
stable/5.15: [cba76e1fb896b573f09f51aa299223276a77bc90]
stable/6.1: [ffb8ab6f87bd28d700ab5c20d9d3a7e75067630d]

CVE-2023-53055: fscrypt: destroy keyring after security_sb_delete()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53055

Introduced by commit d7e7b9a ("fscrypt: stop using keyrings subsystem
for fscrypt_master_key") in v6.1-rc1.
Fixed in v6.3-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [ccb820dc7d2236b1af0d54ae038a27b5b6d5ae5a]
stable/5.15: [992a3f3e8a0c92151dfdf65fc85567c865fd558a]
stable/6.1: [d77531fac6a1fd9f1db0195438ba5419d72b96c4]

CVE-2023-53056: scsi: qla2xxx: Synchronize the IOCB count to be in order

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53056

Introduced by 5f63a16 ("scsi: qla2xxx: Fix exchange oversubscription for
management commands") in 6.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [d3affdeb400f3adc925bd996f3839481f5291839]
stable/5.15: [6295b3ec64a3623fa96869ffb7cf17d0b3c92035]
stable/6.1: [6d57b77d7369ed73836c82b25f785b34923eef84]

CVE-2023-53057: Bluetooth: HCI: Fix global-out-of-bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53057

Introduced by commit d0b1370 ("Bluetooth: hci_sync: Rework init
stages") in v5.17-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bce56405201111807cc8e4f47c6de3e10b17c1ac]
stable/6.1: [b3168abd24245aa0775c5a387dcf94d36ca7e738]

CVE-2023-53058: net/mlx5: E-Switch, Fix an Oops in error handling code

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53058

Introduced by commit 133dcfc ("net/mlx5: E-Switch, Alloc and free
unique metadata for match") in v5.8-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [640fcdbcf27fc62de9223f958ceb4e897a00e791]
stable/5.10: [5eadc80328298ef7beaaf0cd96791667d3b485ca]
stable/5.15: [388188fb58bef9e7f3ca4f8970f03d493b66909f]
stable/6.1: [c4c977935b2fc60084b3735737d17a06e7ba1bd0]

CVE-2023-53059: platform/chrome: cros_ec_chardev: fix kernel data leak
from ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53059

Introduced by commit eda2e30 ("mfd / platform: cros_ec: Miscellaneous
character device to talk with the EC") in v5.4-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b20cf3f89c56b5f6a38b7f76a8128bf9f291bbd3]
stable/5.10: [f86ff88a1548ccf5a13960c0e7625ca787ea0993]
stable/5.15: [ebea2e16504f40d2c2bac42ad5c5a3de5ce034b4]
stable/5.4: [13493ad6a220cb3f6f3552a16b4f2753a118b633]
stable/6.1: [eab28bfafcd1245a3510df9aa9eb940589956ea6]

CVE-2023-53060: igb: revert rtnl_lock() that causes deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53060

Introduced by commit 6faee3d ("igb: Add lock to avoid data race") in v6.0-rc2.
Fixed in v6.3-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [7d845e9a485f287181ff81567c3900a8e7ad1e28]
mainline: [65f69851e44d71248b952a687e44759a7abb5016]
stable/4.19: [7d845e9a485f287181ff81567c3900a8e7ad1e28]
stable/5.10: [4d2626e10709ff8474ffd1a9db3cf4647569e89c]
stable/5.15: [66e5577cabc3d463eea540332727929d0ace41c6]
stable/5.4: [cd1e320ac0958298c2774605ad050483f33a21f2]
stable/6.1: [62a64645749926f9d75af82a96440941f22b046f]

CVE-2023-53061: ksmbd: fix possible refcount leak in smb2_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53061

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2624b445544ffc1472ccabfb6ec867c199d4c95c]
stable/5.15: [c33344b7972225b232966f95d31f6312dcc6273d]
stable/6.1: [303f8e58cc3ace744801dcdcabfc06ffc72ed62d]

CVE-2023-53062: net: usb: smsc95xx: Limit packet length to skb->len

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53062

Introduced by commit 2f7ca80 ("net: Add SMSC LAN9500 USB2.0 10/100
ethernet adapter driver") in v2.6.28-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d3c145a4d24b752c9a1314d5a595014d51471418]
cip/4.4-st: [5f147b687a0bba90a8d848a7d4e37f3bd8f0f75a]
mainline: [ff821092cf02a70c2bccd2d19269f01e29aa52cf]
stable/4.19: [d3c145a4d24b752c9a1314d5a595014d51471418]
stable/5.10: [33d1603a38e05886c538129ddfe00bd52d347e7b]
stable/5.15: [ba6c40227108f8ee428e42eb0337b48ed3001e65]
stable/5.4: [f2111c791d885211714db85f9a06188571c57dd0]
stable/6.1: [e041bef1adee02999cf24f9a2e15ed452bc363fe]

CVE-2023-53063: Bluetooth: btsdio: fix use after free bug in
btsdio_remove due to unfinished work

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53063

Introduced by commit ddbaf13 ("[Bluetooth] Add generic driver for
Bluetooth SDIO devices") in v2.6.24-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [af4d48754d5517d33bac5e504ff1f1de0808e29e]
cip/4.4-st: [d4aa78788e2c7fe15115fe6fd453dee4932754a2]
mainline: [1e9ac114c4428fdb7ff4635b45d4f46017e8916f]
stable/4.19: [af4d48754d5517d33bac5e504ff1f1de0808e29e]
stable/5.10: [da3d3fdfb4d523c5da30e35a8dd90e04f0fd8962]
stable/5.15: [8efae2112d910d8e5166dd0a836791b08721eef1]
stable/5.4: [a18fb433ceb56e0787546a9d77056dd0f215e762]
stable/6.1: [cbf8deacb7053ce3e3fed64b277c6c6989e65bba]

CVE-2023-53064: iavf: fix hang on reboot with ice

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53064

Introduced by commit 9745780 ("iavf: Add waiting so the port is
initialized in remove") in v5.17-rc7.
Introduced by commit a841733 ("iavf: Fix race condition between
iavf_shutdown and iavf_remove") in v6.1-rc7.
Fixed in v6.3-rc4.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [4e264be98b88a6d6f476c11087fe865696e8bef5]
stable/5.15: [7a29799fc141ba9e6cf921fc8e958e3398ad1a4f]
stable/6.1: [502b898235f06130750c91512c86dd0e9efe28e6]

CVE-2023-53065: perf/core: Fix perf_output_begin parameter is
incorrectly invoked in perf_event_bpf_output

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53065

Introduced by commit 267fb27 ("perf: Reduce stack usage of
perf_output_begin()") in v5.10-rc4.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb81a2ed4f52be831c9fb879752d89645a312c13]
stable/5.10: [ddcf8320003638a06eb1e46412e045d0c5701575]
stable/5.15: [ac5f88642cb211152041f84a985309e9af4baf59]
stable/6.1: [ff8137727a2af4ad5f6e6c8b9f7ec5e8db9da86c]

CVE-2023-53066: qed/qed_sriov: guard against NULL derefs from
qed_iov_get_vf_info

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53066

Introduced by commit f990c82 ("qed*: Add support for
ndo_set_vf_trust") in v4.11-rc1.
Introduced by commit 733def6 ("qed*: IOV link control") in v4.7-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7742c08e012eb65405e8304d100641638c5ff882]
mainline: [25143b6a01d0cc5319edd3de22ffa2578b045550]
stable/4.19: [7742c08e012eb65405e8304d100641638c5ff882]
stable/5.10: [39c3b9dd481c3afce9439b29bafe00444cb4406b]
stable/5.15: [e42d3bde4ec03c863259878dddaef5c351cca7ad]
stable/5.4: [42d72c6d1edc9dc09a5d6f6695d257fa9e9cc270]
stable/6.1: [97ea704f39b5ded96f071e98701aa543f6f89683]

CVE-2023-53067: LoongArch: Only call get_timer_irq() once in
constant_clockevent_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53067

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.
Affected file was added by 628c3bb ("LoongArch: Add boot and setup
routines") in 5.19-rc1.

Fixed status
mainline: [bb7a78e343468873bf00b2b181fcfd3c02d8cb56]
stable/6.1: [b9c379e1d7e141b102f41858c9b8f6f36e7c89a4]

CVE-2023-53068: net: usb: lan78xx: Limit packet length to skb->len

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53068

Introduced by commit 55d7de9 ("Microchip's LAN7800 family USB 2/3 to
10/100/1000 Ethernet device driver") in v4.3-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f247f5a2c18b3f21206cdd51193df4f38e1b9f5]
stable/6.1: [83de34967473ed31d276381373713cc2869a42e5]

CVE-2023-53069: octeontx2-vf: Add missing free for alloc_percpu

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53069

Introduced by commit 5c05120 ("octeontx2-pf: cn10k: Use runtime
allocated LMTLINE region") in v5.14-rc2.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f038f3917baf04835ba2b7bcf2a04ac93fbf8a9c]
stable/5.15: [90874b76e5f82eaa3309714d72ff2cd8bb8d1b02]
stable/6.1: [840631bcf21f58c0a3f01378a54d79e9ce86b226]

CVE-2023-53070: ACPI: PPTT: Fix to avoid sleep in the atomic context
when PPTT is absent

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53070

Introduced by commit 0c80f9e ("ACPI: PPTT: Leave the table mapped for
the runtime usage") in v6.0-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91d7b60a65d9f71230ea09b86d2058a884a3c2af]
stable/6.1: [1318a07706bb2f8c65f88f39a16c2b5260bcdcd4]

CVE-2023-53071: wifi: mt76: do not run mt76_unregister_device() on
unregistered hw

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53071

Introduced by commit 1c71e03 ("mt76: mt7921: move mt7921_init_hw in a
dedicated work") in v5.18-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41130c32f3a18fcc930316da17f3a5f3bc326aa1]
stable/6.1: [dffe86df26aee01a5fc56a175b7a7f157961e370]

CVE-2023-53072: mptcp: use the workqueue to destroy unaccepted sockets

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53072

Introduced by commit 58b0991 ("mptcp: create msk early") in v5.7-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6985b9b82954caa53f862d6059d06c0526254f0]
stable/6.1: [2827f099b3fb9a59263c997400e9182f5d423e84]

CVE-2023-53073: perf/x86/amd/core: Always clear status for idx

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53073

Introduced by commit 7685665 ("perf/x86/amd/core: Add PerfMonV2
overflow handling") in v5.19-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [263f5ecaf7080513efc248ec739b6d9e00f4129f]
stable/6.1: [ab33a8f7649b0324639a336e1081aaea51a4523e]

CVE-2023-53074: drm/amdgpu: fix ttm_bo calltrace warning in psp_hw_fini

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53074

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.
Affected file was added by 0e5ca0d ("drm/amdgpu: add PSP driver for
vega10 (v2)")
in 4.12-rc1.

Fixed status
mainline: [23f4a2d29ba57bf88095f817de5809d427fcbe7e]
stable/6.1: [7be9a2f8c5179520a7d5570e648e0c97d09e4fae]

CVE-2023-53075: ftrace: Fix invalid address access in lookup_rec()
when index is 0

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53075

Introduced by commit 9644302 ("ftrace: Speed up search by skipping
pages by address") in v3.5-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7569ee04b0e3b32df79f64db3a7138573edad9bc]
cip/4.4-st: [41df3950b79f1e50107ab25e289a8d489184819e]
mainline: [ee92fa443358f4fc0017c1d0d325c27b37802504]
stable/4.19: [7569ee04b0e3b32df79f64db3a7138573edad9bc]
stable/5.10: [83c3b2f4e7c61367c7b24551f4c6eb94bbdda283]
stable/5.15: [2a0d71fabfeb349216d33f001a6421b1768bd3a9]
stable/5.4: [ac58b88ccbbb8e9fb83e137cee04a856b1ea6635]
stable/6.1: [4f84f31f63416b0f02fc146ffdc4ab32723eb7e8]

CVE-2023-53076: bpf: Adjust insufficient default bpf_jit_limit

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53076

Introduced by commit fdadd04 ("bpf: fix bpf_jit_limit knob for
PAGE_SIZE >= 64K") in v4.20.
Fixed in v6.3-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [42049e65d338870e93732b0b80c6c41faf6aa781]
mainline: [10ec8ca8ec1a2f04c4ed90897225231c58c124a7]
stable/4.19: [42049e65d338870e93732b0b80c6c41faf6aa781]
stable/5.10: [a4bbab27c4bf69486f5846d44134eb31c37e9b22]
stable/5.15: [54869daa6a437887614274f65298ba44a3fac63a]
stable/5.4: [d69c2ded95b17d51cc6632c7848cbd476381ecd6]
stable/6.1: [9cda812c76067c8a771eae43bb6943481cc7effc]

CVE-2023-53077: drm/amd/display: fix shift-out-of-bounds in
CalculateVMAndRowBytes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53077

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.
Affected file was added by 6725a88 ("drm/amd/display: Add DCN3 DML") in 5.9-rc1.

Fixed status
mainline: [031f196d1b1b6d5dfcb0533b431e3ab1750e6189]
stable/5.10: [7257070be70e19a9138f39009c1a26c83a8a7cfa]
stable/5.15: [bec1bea2fa974e63f6059c33edde669c7894d0bc]
stable/6.1: [a16394b5d661afec9a264fecac3abd87aea439ea]

CVE-2023-53078: scsi: scsi_dh_alua: Fix memleak for 'qdata' in alua_activate()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53078

Introduced by commit 625fe85 ("scsi: scsi_dh_alua: Check
scsi_device_get() return value") in v4.11-rc5.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c110051d335ef7f62ad33474b0c23997fee5bfb5]
mainline: [a13faca032acbf2699293587085293bdfaafc8ae]
stable/4.19: [c110051d335ef7f62ad33474b0c23997fee5bfb5]
stable/5.10: [c09cdf6eb815ee35e55d6c50ac7f63db58bd20b8]
stable/5.15: [9311e7a554dffd3823499e309a8b86a5cd1540e5]
stable/5.4: [5c4d71424df34fc23dc5336d09394ce68c849542]
stable/6.1: [1c55982beb80c7d3c30278fc6cfda8496a31dbe6]

CVE-2023-53079: net/mlx5: Fix steering rules cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53079

Introduced by commit a35f71f ("net/mlx5: E-Switch, Implement
promiscuous rx modes vf request handling") in v4.7-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [922f56e9a795d6f3dd72d3428ebdd7ee040fa855]
stable/5.10: [18cead61e437f4c7898acca0a5f3df12f801d97f]
stable/5.15: [4df1f2d36bdc9a368650bf14b9097c555e95f71d]
stable/6.1: [63546395a0e6ac264f78f65218086ce6014b4494]

CVE-2023-53080: xsk: Add missing overflow check in xdp_umem_reg

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53080

Introduced by commit bbff2f3 ("xsk: new descriptor addressing scheme")
in v4.18-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7df4813b149362248d6ef7be41a311e27bf75fe]
stable/5.10: [580634b03a55f04a3c1968bcbd97736c079c6601]
stable/5.15: [3cfc3564411acf96bf2fb791f706a1aa4f872c1d]
stable/6.1: [a069909acc4435eeb41d05ccc03baa447cc01b7e]

CVE-2023-53081: ocfs2: fix data corruption after failed write

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53081

Introduced by commit 6dbf7bb ("fs: Don't invalidate page buffers in
block_write_full_page()") in v5.10-rc1.
Fixed in v6.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
cip/4.19-st: [c26f3ff4c0be590c1250f945ac2e4fc5fcdc5f45]
cip/4.4-st: [96822116b5e8365a957f2682b1e04132ee0c3e93]
mainline: [90410bcf873cf05f54a32183afff0161f44f9715]
stable/4.19: [c26f3ff4c0be590c1250f945ac2e4fc5fcdc5f45]
stable/5.10: [91d7a4bd5656552d6259e2d0f8859f9e8cc5ef68]
stable/5.15: [a9e53869cb43c96d6d851c491fd4e26430ab6ba6]
stable/5.4: [4c24eb49ab44351424ac8fe8567f91ea48a06089]
stable/6.1: [47eb055ad3588fc96d34e9e1dd87b210ce62906b]

CVE-2023-53082: vp_vdpa: fix the crash in hot unplug with vp_vdpa

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53082

Introduced by commit ffbda8e ("vdpa/vp_vdpa : add vdpa tool support in
vp_vdpa") in v5.19-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aed8efddd39b3434c96718d39009285c52b1cafc]
stable/6.1: [baafa2960731211837d8fc04ff3873ecb7440464]

CVE-2023-53083: nfsd: don't replace page in rq_pages if it's a
continuation of last page

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53083

Introduced by commit 91e23b1 ("NFSD: Clean up nfsd_splice_actor()") in
v5.19-rc1.
Fixed in v6.1.22.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [51ddb84baff6f09ad62b5999ece3ec172e4e3568]
stable/5.10: [8235cd619db6e67f1d7d26c55f1f3e4e575c947d]
stable/6.1: [8235cd619db6e67f1d7d26c55f1f3e4e575c947d]

CVE-2023-53084: drm/shmem-helper: Remove another errant put in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53084

Introduced by commit f49a51b ("drm/shme-helpers: Fix dma_buf_mmap
forwarding bug") in v5.10-rc2.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee9adb7a45516cfa536ca92253d7ae59d56db9e4]
stable/5.10: [684c7372bbd6447c2e86a2a84e97a1478604d21f]
stable/5.15: [5cfb617967b05f8f27e862c97db1fabd8485f4db]
stable/6.1: [dede8c14a37a7ac458f9add56154a074ed78e7cf]

CVE-2023-53085: drm/edid: fix info leak when failing to get panel id

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53085

Introduced by commit 69c7717 ("drm/edid: Dump the EDID when
drm_edid_get_panel_id() has an error") in v6.2-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d8457fe0eb9c80ff7795cf8a30962128b71d853]

CVE-2023-53086: wifi: mt76: connac: do not check WED status for non-mmio devices

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53086

Introduced by commit d1369e5 ("wifi: mt76: connac: introduce
mt76_connac_mcu_sta_wed_update utility routine") in v6.2-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5683e1488aa9b0805a9403d215e48fed29d6d923]

CVE-2023-53087: drm/i915/active: Fix misuse of non-idle barriers as
fence trackers

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53087

Introduced by commit 3117701 ("drm/i915/gt: Schedule request
retirement when timeline idles") in v5.5-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0e6b416b25ee14716f3549e0cbec1011b193809]
stable/5.10: [5e784a7d07af42057c0576fb647b482f4cb0dc2c]
stable/5.15: [6ab7d33617559cced63d467928f478ea5c459021]
stable/6.1: [5c7591b8574c52c56b3994c2fbef1a3a311b5715]

CVE-2023-53088: mptcp: fix UaF in listener shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53088

Introduced by commit 6aeed90 ("mptcp: fix race on unaccepted mptcp
sockets") in v5.19-rc5.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a3f4f1f9c27215e4ddcd312558342e57b93e518]
stable/6.1: [5564be74a22a61855f8b8c100d8c4abb003bb792]

CVE-2023-53089: ext4: fix task hung in ext4_xattr_delete_inode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53089

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.
Affected function was added by e50e512 ("ext4: xattr-in-inode
support") in 4.13-rc1.

Fixed status
cip/4.19-st: [64b72f5e7574020dea62ab733d88a54d903c42a1]
mainline: [0f7bfd6f8164be32dbbdf36aa1e5d00485c53cd7]
stable/4.19: [64b72f5e7574020dea62ab733d88a54d903c42a1]
stable/5.10: [a98160d8f3e6242ca9b7f443f26e7ef3a61ba684]
stable/5.15: [1aec41c98cce61d19ce89650895e51b9f3cdef13]
stable/5.4: [2c96c52aeaa6fd9163cfacdd98778b4a0398ef18]
stable/6.1: [94fd091576b12540924f6316ebc0678e84cb2800]

CVE-2023-53090: drm/amdkfd: Fix an illegal memory access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53090

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [5a3fb3b745af0ce46ec2e0c8e507bae45b937334]
mainline: [4fc8fff378b2f2039f2a666d9f8c570f4e58352c]
stable/4.19: [5a3fb3b745af0ce46ec2e0c8e507bae45b937334]
stable/5.10: [6936525142a015e854d0a23e9ad9ea0a28b3843d]
stable/5.15: [2fece63b55c5d74cd6f5de51159e2cde37e10555]
stable/5.4: [bbf5eada4334a96e3a204b2307ff5b14dc380b0b]
stable/6.1: [d9923e7214a870b312bf61f6a89c7554d0966985]

CVE-2023-53091: ext4: update s_journal_inum if it changes after journal replay

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53091

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.


Fixed status
mainline: [3039d8b8692408438a618fac2776b629852663c3]
stable/5.15: [499fef2030fb754c68b1c7cb3a799a3bc1d0d925]
stable/6.1: [70e66bdeae4d0f7c8e87762f425b68aedd5e8955]

CVE-2023-53092: interconnect: exynos: fix node leak in probe PM QoS error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53092

Introduced by commit 2f95b9d ("interconnect: Add generic interconnect
driver for Exynos SoCs") in v5.11-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3aab264875bf3c915ea2517fae1eec213e0b4987]
stable/5.15: [fd4738ae1a0c216d25360a98e835967b06d6a253]
stable/6.1: [c479e4ac4a3d1485a48599e66ce46547c1367828]

CVE-2023-53093: tracing: Do not let histogram values have some modifiers

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53093

Introduced by commit c6afad4 ("tracing: Add hist trigger 'sym' and
'sym-offset' modifiers") in v4.7-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0213434fe3e4a0d118923dc98d31e7ff1cd9e45]
stable/6.1: [39cd75f2f3a43c0e2f95749eb6dd6420c553f87d]

CVE-2023-53094: tty: serial: fsl_lpuart: fix race on RX DMA shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53094

Introduced by commit 4a8588a ("serial: fsl_lpuart: delete timer on
shutdown") in v4.0-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1be6f2b15f902c02e055ae0b419ca789200473c9]
stable/5.10: [19a98d56dfedafb25652bdb9cd48a4e73ceba702]
stable/5.15: [90530e7214c8a04dcdde57502d93fa96af288c38]
stable/6.1: [954fc9931f0aabf272b5674cf468affdd88d3a36]

CVE-2023-53095: drm/ttm: Fix a NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53095

Introduced by commit 6a9b028 ("drm/ttm: move the LRU into resource
handling v4") in v5.19-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a9a8fe26751334b7739193a94eba741073b8a55]
stable/6.1: [9ba1720f6c4a0f13c3f3cb5c28132ee75555d04f]

CVE-2023-53096: interconnect: fix mem leak when freeing nodes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53096

Introduced by commit 11f1cec ("interconnect: Add generic on-chip
interconnect API") in v5.1-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5904f415e1af72fa8fe6665aa4f554dc2099a95]
stable/5.10: [efae80ca13faa94457208852825731da44a788ad]
stable/5.15: [2e0b13a1827229a02abef97b50ffaf89ba25370a]
stable/5.4: [f1e3a20c60196c37a402c584d0c9de306ba988ce]
stable/6.1: [3167306455d0fbbbcf08cb25651acc527a86a95e]

CVE-2023-53097: powerpc/iommu: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53097

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.


Fixed status
mainline: [b505063910c134778202dfad9332dfcecb76bab3]
stable/5.15: [e3a62a35f903fd8be5b44542fe3901ec45f16757]
stable/6.1: [24c1bd1cd0d1ff821fd7d2f01a1e648c7882dfc2]

CVE-2023-53098: media: rc: gpio-ir-recv: add remove function

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53098

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc1.


Fixed status
mainline: [30040818b338b8ebc956ce0ebd198f8d593586a6]
stable/5.10: [a5c140d88a69eb43de2a030f1d7ff7b16bff3b1a]
stable/5.15: [513572bb89e8075f5d2a2bb4c89f1152e44da9d8]
stable/6.1: [00e81f191bc00cb6faabf468960e96ebf0404a6c]

CVE-2023-53099: firmware: xilinx: don't make a sleepable memory
allocation from an atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53099

Introduced by commit acfdd18 ("firmware: xilinx: Use hash-table for
api feature check") in v5.10-rc6.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38ed310c22e7a0fc978b1f8292136a4a4a8b3051]
stable/5.10: [b37d3ccbd549494890672136a0e623eb010d46a7]
stable/5.15: [86afb633beaa02ee95b5126a14c9f22cfade4fd9]
stable/6.1: [162049c31eb64308afa22e341a257a723526eb5c]

CVE-2023-53100: ext4: fix WARNING in ext4_update_inline_data

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53100

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc2.


Fixed status
cip/4.19-st: [39c5df2ca544368b44b59d0f6d80131e90763371]
cip/4.4-st: [51267c9c9cf8e7ff6ec0e9a20a3866790f2145b0]
mainline: [2b96b4a5d9443ca4cad58b0040be455803c05a42]
stable/4.19: [39c5df2ca544368b44b59d0f6d80131e90763371]
stable/5.10: [a9bd94f67b27739bbe8583c52256502bd4cc7e83]
stable/5.15: [ca500cf2eceb5a8e93bf71ab97b5f7a18ecabce2]
stable/5.4: [74d775083e9f3d9dadf9e3b5f3e0028d1ad0bd5c]
stable/6.1: [35161cec76772f74526f5886ad4082ec48511d5c]

CVE-2023-53101: ext4: zero i_disksize when initializing the bootloader inode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53101

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc2.


Fixed status
cip/4.19-st: [59eee0cdf8c036f554add97a4da7c06d7a9ff34a]
cip/4.4-st: [a02f7f99c46524fe675fc95037ee0b1e79934800]
mainline: [f5361da1e60d54ec81346aee8e3d8baf1be0b762]
stable/4.19: [59eee0cdf8c036f554add97a4da7c06d7a9ff34a]
stable/5.10: [3f00c476da8fe7c4c34ea16abb55d74127120413]
stable/5.15: [01a821aacc64d4b05dafd239dbc9b7856686002f]
stable/5.4: [0d8a6c9a6415999fee1259ccf1796480c026b7d6]
stable/6.1: [9cb27b1e76f0cc886ac09055bc41c0ab3f205167]

CVE-2023-53102: ice: xsk: disable txq irq before flushing hw

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53102

Introduced by commit 2d4238f ("ice: Add support for AF_XDP") in v5.5-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b830c9642386867863ac64295185f896ff2928ac]
stable/5.10: [cccba1ff0798a27f7b8d0c06762ef977400a2afb]
stable/5.15: [b89a453c6918e0f346fb0562e8c7812b94d28c73]
stable/6.1: [2ecc6e44959382f95c9d427cd8da85121a9cecda]

CVE-2023-53103: bonding: restore bond's IFF_SLAVE flag if a non-eth
dev enslave fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53103

Introduced by commit 7d5cd2c ("bonding: correctly handle bonding type
change on enslave failure") in v4.2-rc4.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e667d469098671261d558be0cd93dca4d285ce1e]
stable/5.15: [93c8cbeb1b2b8ff670b3dfd01b3abd843995c80f]
stable/6.1: [ecb1b5135bd3f232d5335b3935e2c2ac11bfa02f]

CVE-2023-53104: net: usb: smsc75xx: Move packet length check to
prevent kernel panic in skb_pull

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53104



Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
cip/4.19-st: [89441504d66d116eb5ce58c132f58cdcca5b498a]
cip/4.4-st: [04dc1173832985793e783608e5993cd51c6eac54]
mainline: [43ffe6caccc7a1bb9d7442fbab521efbf6c1378c]
stable/5.10: [2cc46ed406bb325f10a251b03d9a83ae67b3d3d8]
stable/5.15: [7bf0eac3fdd2d25f5c6ceab63e3e4902e274f7ee]
stable/5.4: [e0d07a3203c36d073af2177edfc6b070220a60cb]
stable/6.1: [4caee8e7d91e4f06f21881726da9c1bb2cd6e4fa]

CVE-2023-53105: net/mlx5e: Fix cleanup null-ptr deref on encap lock

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53105

Introduced by commit 04de7dd ("net/mlx5e: Infrastructure for
duplicated offloading of TC flows") in v5.0-rc1.
Introduced by commit 1418ddd ("net/mlx5e: Duplicate offloaded TC
eswitch rules under uplink LAG") in v5.0-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9668f0b1d28570327dbba189f2c61f6f9e43ae7]
stable/6.1: [b7350f8dbe0c2a1d4d3ad7c35b610abd3cb91750]

CVE-2023-53106: nfc: st-nci: Fix use after free bug in ndlc_remove due
to race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53106

Introduced by commit 35630df ("NFC: st21nfcb: Add driver for
STMicroelectronics ST21NFCB NFC chip") in v3.17-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3405eb641dafcc8b28d174784b203c1622c121bf]
cip/4.4-st: [270eaa6f6b7f1303004061a1144103a34c17513b]
mainline: [5000fe6c27827a61d8250a7e4a1d26c3298ef4f6]
stable/4.19: [3405eb641dafcc8b28d174784b203c1622c121bf]
stable/5.10: [43aa468df246175207a7d5d7d6d31b231f15b49c]
stable/5.15: [84dd9cc34014e3a3dcce0eb6d54b8a067e97676b]
stable/5.4: [b0c202a8dc63008205a5d546559736507a9aae66]
stable/6.1: [5e331022b448fbc5e76f24349cd0246844dcad25]

CVE-2023-53107: veth: Fix use after free in XDP_REDIRECT

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53107

Introduced by commit 718a18a ("veth: Rework veth_xdp_rcv_skb in order
to accept non-linear skb") in v5.18-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c10131803e45269ddc6c817f19ed649110f3cae]
stable/6.1: [717d20710596b5b26595ede454d1105fa176f4a4]

CVE-2023-53108: net/iucv: Fix size of interrupt data

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53108

Introduced by commit 2356f4c ("[S390]: Rewrite of the IUCV base code,
part 2") in v2.6.21-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b0d2bb5e31a693ebc8888eb407f8a257a3680efa]
cip/4.4-st: [fc271c30b352823519c20058b28f2cb637e8a346]
mainline: [3d87debb8ed2649608ff432699e7c961c0c6f03b]
stable/4.19: [b0d2bb5e31a693ebc8888eb407f8a257a3680efa]
stable/5.10: [bd2e78462ae18484e55ae4d285df2c86b86bdd12]
stable/5.15: [3cfdefdaaa4b2a77e84d0db5e0a47a7aa3bb615a]
stable/5.4: [71da5991b6438ad6da13ceb25465ee2760a1c52f]
stable/6.1: [c78f1345db4e4b3b78f9b768f4074ebd60abe966]

CVE-2023-53109: net: tunnels: annotate lockless accesses to dev->needed_headroom

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53109

Introduced by commit 8eb30be ("ipv6: Create ip6_tnl_xmit") in v4.7-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [51f3bd3765bc5ca4583af07a00833da00d2ace1d]
mainline: [4b397c06cb987935b1b097336532aa6b4210e091]
stable/4.19: [51f3bd3765bc5ca4583af07a00833da00d2ace1d]
stable/5.10: [be59b87ee4aed81db7c10e44f603866a0ac3ca5d]
stable/5.15: [e0a557fc1daf5c1086e47150a4571aebadbb62be]
stable/5.4: [5aaab217c8f5387b9c5fff9e940d80f135e04366]
stable/6.1: [a69b72b57b7d269e833e520ba7500d556e8189b6]

CVE-2023-53110: net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53110

Introduced by commit 0b29ec6 ("net/smc: immediate termination for SMCR
link groups") in v5.5-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22a825c541d775c1dbe7b2402786025acad6727b]
stable/5.10: [31817c530768b0199771ec6019571b4f0ddbf230]
stable/5.15: [b108bd9e6be000492ebebe867daa699285978a10]
stable/6.1: [3c270435db8aa34929263dddae8fd050f5216ecb]

CVE-2023-53111: loop: Fix use-after-free issues

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53111

Introduced by commit c74d40e ("loop: charge i/o to mem and blk cg") in
v5.14-rc1.
Introduced by commit bc07c10 ("block: loop: support DIO & AIO") in v4.4-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b0cb770f5d7b1ff40bea7ca385438ee94570eec]
stable/5.15: [407badf73ec9fb0d5744bf2ca1745c1818aa222f]
stable/6.1: [e3fda704903f6d1fc351412f1bc6620333959ada]

CVE-2023-53112: drm/i915/sseu: fix max_subslices
array-index-out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53112

Introduced by commit bc3c5e0 ("drm/i915/sseu: Don't try to store EU
mask internally in UAPI format") in v6.0-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [193c41926d152761764894f46e23b53c00186a82]
stable/6.1: [1a1682abf7399318ac074b1f2ac6a8c992b5b3da]

CVE-2023-53113: wifi: nl80211: fix NULL-ptr deref in offchan check

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53113

Introduced by commit 7b0a0e3 ("wifi: cfg80211: do some rework towards
MLO link APIs") in v6.0-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f624bb6fad23df3270580b4fcef415c6e7bf7705]
stable/6.1: [87e80ea4fbc9ce2f2005905fdbcd38baaa47463a]

CVE-2023-53114: i40e: Fix kernel crash during reboot when adapter is
in recovery mode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53114

Introduced by commit 4ff0ee1 ("i40e: Introduce recovery mode support")
in v5.2-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e4f8a0c495413a50413e8c9f1032ce1bc633bae]
stable/5.10: [3cbecb1c9085a00155639404f7addbcbfc987ba3]
stable/5.15: [4ff82695266576a0b4f1077a7100b2451e476df4]
stable/5.4: [6e18f66b704bd725196508c1db93bf7338cdc8de]
stable/6.1: [c703362a66ea971905b9dc153fc54d1b6ac05423]

CVE-2023-53115: scsi: mpi3mr: Fix memory leaks in mpi3mr_init_ioc()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53115

Introduced by commit fe6db61 ("scsi: mpi3mr: Handle offline FW
activation in graceful manner") in v5.17-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c798304470cab88723d895726d17fcb96472e0e9]
stable/6.1: [5aab9342f12f980b64617a034d121efbbf09100a]

CVE-2023-53116: nvmet: avoid potential UAF in nvmet_req_complete()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53116

Introduced by commit a07b497 ("nvmet: add a generic NVMe target") in v4.8-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fafcb4b26393870c45462f9af6a48e581dbbcf7e]
mainline: [6173a77b7e9d3e202bdb9897b23f2a8afe7bf286]
stable/4.19: [fafcb4b26393870c45462f9af6a48e581dbbcf7e]
stable/5.10: [a6317235da8aa7cb97529ebc8121cc2a4c4c437a]
stable/5.15: [f1d5888a5efe345b63c430b256e95acb0a475642]
stable/5.4: [04c394208831d5e0d5cfee46722eb0f033cd4083]
stable/6.1: [bcd535f07c58342302a2cd2bdd8894fe0872c8a9]

CVE-2023-53117: fs: prevent out-of-bounds array speculation when
closing a file descriptor

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53117

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc2.


Fixed status
cip/4.19-st: [3d5d9501b634fd268eb56428cda92cd317752d69]
cip/4.4-st: [b8361681beac507978534e979b24d39431c0f3f5]
mainline: [609d54441493c99f21c1823dfd66fa7f4c512ff4]
stable/4.19: [3d5d9501b634fd268eb56428cda92cd317752d69]
stable/5.10: [a759905de9cd6ec9ca08ceadf0920272772ed830]
stable/5.15: [f8cd8754a03a3748384ee438c572423643c9c315]
stable/5.4: [6631c8da02cfad96c53b217cf647b511c7f34faf]
stable/6.1: [cec08b7d1ebcd3138d4658b3868ce26aeb1e8e06]

CVE-2023-53118: scsi: core: Fix a procfs host directory removal regression

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53118

Introduced by commit fc66371 ("scsi: core: Remove the
/proc/scsi/${proc_name} directory earlier")
in 6.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
mainline: [be03df3d4bfe7e8866d4aa43d62e648ffe884f5f]
stable/5.10: [68c665bb185037e7eb66fb792c61da9d7151e99c]
stable/5.15: [2a764d55e938743efa7c2cba7305633bcf227f09]
stable/5.4: [88c3d3bb6469cea929ac68fd326bdcbefcdfdd83]
stable/6.1: [7e0ae8667fcdd99d1756922e1140cac75f5fa279]

CVE-2023-53119: nfc: pn533: initialize struct pn533_out_arg properly

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53119

Introduced by commit 9dab880 ("nfc: pn533: Wait for out_urb's
completion in pn533_usb_send_frame()") in v6.2-rc4.
Fixed in v6.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
cip/4.19-st: [4c20a07ed26a71a8ccc9c6d935fc181573f5462e]
mainline: [484b7059796e3bc1cb527caa61dfc60da649b4f6]
stable/4.19: [4c20a07ed26a71a8ccc9c6d935fc181573f5462e]
stable/5.10: [2703da78849c47b6b5b4471edb35fc7b7f91dead]
stable/5.15: [2bee84369b76f6c9ef71938069c65a6ebd1a12f7]
stable/5.4: [0f9c1f26d434c32520dfe33326b28c5954bc4299]
stable/6.1: [a97ef110c491b72c138111a595a3a3af56cbc94c]

CVE-2023-53120: scsi: mpi3mr: Fix config page DMA memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53120

Introduced by commit 32d457d ("scsi: mpi3mr: Add framework to issue
config requests") in v6.1-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d2b02172b6a2ae6aecd7ef6480b9c4bf3dc59f4]
stable/6.1: [dca06ccf13de14e144d34f158f73ae0032f80e63]

CVE-2023-53121: tcp: tcp_make_synack() can be called from process context

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53121

Introduced by commit 8336886 ("tcp: TCP Fast Open Server - support TFO
listeners") in v3.7-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e23ca307745be3df7fe9762f3e2a7e311a57852e]
mainline: [bced3f7db95ff2e6ca29dc4d1c9751ab5e736a09]
stable/4.19: [e23ca307745be3df7fe9762f3e2a7e311a57852e]
stable/5.10: [77ad58bca0119e8cc3e0e9d91a3f22caa66e4dfa]
stable/5.15: [ad07290d63ff6689f50565b02f5b6f34ec15a5ca]
stable/5.4: [442aa78ed70188b21ccd8669738448702c0a3281]
stable/6.1: [9180aa4622a720b433e842b4d3aa34d73eec577a]

CVE-2023-53122: RISC-V: fix taking the text_mutex twice during sifive
errata patching

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53122


Introduced by 9493e6f ("RISC-V: take text_mutex during alternative patching")
in 6.3-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [bf89b7ee52af5a5944fa3539e86089f72475055b]
stable/6.1: [2feac714c6818f7767cfc21a3c10fa926b7398a3]

CVE-2023-53123: PCI: s390: Fix use-after-free of PCI resources with
per-function hotplug

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53123

Introduced by commit a50297c ("s390/pci: separate zbus creation from
scanning") in v5.13-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab909509850b27fd39b8ba99e44cda39dbc3858c]
stable/5.15: [437bb839e36cc9f35adc6d2a2bf113b7a0fc9985]
stable/6.1: [a2410d0c3d2d714ed968a135dfcbed6aa3ff7027]

CVE-2023-53124: scsi: mpt3sas: Fix NULL pointer access in
mpt3sas_transport_port_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53124

Introduced by commit 78316e9 ("scsi: mpt3sas: Fix possible resource
leaks in mpt3sas_transport_port_add()") in v6.2-rc1.
Fixed in v6.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [d3c57724f1569311e4b81e98fad0931028b9bdcd]
stable/5.10: [6f0c2f70d9929208d8427ec72c3ed91e2251e289]
stable/5.15: [9937f784a608944107dcc2ba9a9c3333f8330b9e]
stable/5.4: [090305c36185c0547e4441d4c08f1cf096b32134]
stable/6.1: [b5e5bbb3fa5f8412e96c5eda7f4a4af6241d6bd3]

CVE-2023-53125: net: usb: smsc75xx: Limit packet length to skb->len

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53125

Introduced by commit d0cad87 ("smsc75xx: SMSC LAN75xx USB gigabit
ethernet adapter driver") in v2.6.34-rc2.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [53966d572d056d6b234cfe76a5f9d60049d3c178]
cip/4.4-st: [adb3a462b353c581338ccb27dc451389729c4e4e]
mainline: [d8b228318935044dafe3a5bc07ee71a1f1424b8d]
stable/4.19: [53966d572d056d6b234cfe76a5f9d60049d3c178]
stable/5.10: [e294f0aa47e4844f3d3c8766c02accd5a76a7d4e]
stable/5.15: [105db6574281e1e03fcbf87983f4fee111682306]
stable/5.4: [9fabdd79051a9fe51388df099aff6e4b660fedd2]
stable/6.1: [c7bdc137ca163b90917c1eeba4f1937684bd4f8b]

CVE-2023-53126: scsi: mpi3mr: Fix sas_hba.phy memory leak in mpi3mr_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53126

Introduced by commit 42fc9fe ("scsi: mpi3mr: Add helper functions to
manage device's port") in v6.1-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4caa1a4255cc44be56bcab3db2c97c632e6cc10]
stable/6.1: [480aae2f30637b5140e9c7a9b10298e538df2b5e]

CVE-2023-53127: scsi: mpi3mr: Fix expander node leak in mpi3mr_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53127

Introduced by commit e22bae3 ("scsi: mpi3mr: Add expander devices to
STL") in v6.1-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce756daa36e1ba271bb3334267295e447aa57a5c]
stable/6.1: [0023972a7593720f8878aed06c03ac9e541078be]

CVE-2023-53128: scsi: mpi3mr: Fix throttle_groups memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53128

Introduced by commit f10af05 ("scsi: mpi3mr: Resource Based Metering")
in v6.0-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f305a7b6ca21a665e8d0cf70b5936991a298c93c]
stable/6.1: [574cc10edaa7dba833764efed8c57ee0e6bf7574]

CVE-2023-53129: ext4: Fix deadlock during directory rename

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53129


Introduced by 0813299 ("ext4: Fix possible corruption when moving a directory")
in 6.3-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [3c92792da8506a295afb6d032b4476e46f979725]
stable/5.10: [b113f90204479f55a17295bedf0cc966a60c7a56]
stable/5.15: [a2bc806e95bde8de3a0d675051d9ae78dcf6c691]
stable/5.4: [6b06c4ae64e3557a19b3bb0b6dbf641bc41fc218]
stable/6.1: [2ef7f829214fa8f428d953b49557b89b2b02db66]

CVE-2023-53130: block: fix wrong mode for blkdev_put() from
disk_scan_partitions()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53130


Introduced by e5cfefa ("block: fix scan partition for exclusively open
device again")
in 6.3-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [428913bce1e67ccb4dae317fd0332545bf8c9233]
stable/6.1: [e5febcfbae9396fb3f064a2a14368c3d77d73ad4]

CVE-2023-53131: SUNRPC: Fix a server shutdown leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53131

Introduced by commit ed6473d ("NFSv4: Fix callback server shutdown")
in v4.12-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ca6705d9d609441d34f8b853e1e4a6369b3b171]
stable/5.10: [ce7dd61e004002bc1c48d1ca47c887f3f3cc7370]
stable/5.15: [ad7e40ee157ba33950a4ccdc284334580da3638d]
stable/6.1: [7a3720361068ab520aed4608bad31ea9a6cc7fe7]

CVE-2023-53132: scsi: mpi3mr: Fix mpi3mr_hba_port memory leak in mpi3mr_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53132

Introduced by commit 42fc9fe ("scsi: mpi3mr: Add helper functions to
manage device's port") in v6.1-rc1.
Fixed in v6.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0f3c3728da8af76dfe435f7f0cfa2b9d9e43ef0]
stable/6.1: [f28bdab9e208792212c52b0c232a13bba84cf048]

CVE-2023-53133: bpf, sockmap: Fix an infinite loop error when len is 0
in tcp_bpf_recvmsg_parser()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53133

Introduced by commit 1f5be6b ("udp: Implement udp_bpf_recvmsg() for
sockmap") in v5.13-rc1.
Introduced by commit 9825d86 ("af_unix: Implement
unix_dgram_bpf_recvmsg()") in v5.15-rc1.
Introduced by commit c5d2177 ("bpf, sockmap: Fix race in ingress
receive verdict with redirect to self") in v5.16-rc1.
Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v6.3-rc2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d900f3d20cc3169ce42ec72acc850e662a4d4db2]
stable/5.15: [4a476285f6d2921c3c9faa494eab83b78f78fc55]
stable/6.1: [f45cf3ae3068e70e2c7f3e24a7f8e8aa99511f03]

CVE-2023-53134: bnxt_en: Avoid order-5 memory allocation for TPA data

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53134

Introduced by commit 79632e9 ("bnxt_en: Expand bnxt_tpa_info struct to
support 57500 chips.") in v5.4-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [accd7e23693aaaa9aa0d3e9eca0ae77d1be80ab3]
stable/5.10: [d16701a385b54f44bf41ff1d7485e7a11080deb3]
stable/5.15: [20fd0607acbf9770db9b99e3418dd75614f80b6c]
stable/5.4: [16f3aae1aa2dd89bc8d073a67f190af580386ae9]
stable/6.1: [fcae40e65802547def39b4deaa2ae38a29864d81]

CVE-2023-53135: riscv: Use READ_ONCE_NOCHECK in imprecise unwinding stack mode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53135

Introduced by commit 5d8544e ("RISC-V: Generic library routines and
assembly") in v4.15-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76950340cf03b149412fe0d5f0810e52ac1df8cb]
stable/5.10: [3de277af481ab931fab9e295ad8762692920732a]
stable/5.15: [3a9418d2c93c1c86ce4d0595112d91c7a8e70c2c]
stable/5.4: [a99a61d9e1bfca2fc37d223a6a185c0eb66aba02]
stable/6.1: [324912d6c0c4006711054d389faa2239c1655e1e]

CVE-2023-53136: af_unix: fix struct pid leaks in OOB support

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53136

Introduced by commit 314001f ("af_unix: Add OOB support") in v5.15-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aab4b96900272885bc157f8b236abf1cdc02e08]
stable/5.15: [f3969427fb06a2c3cd6efd7faab63505cfa76e76]
stable/6.1: [ac1968ac399205fda9ee3b18f7de7416cb3a5d0d]

CVE-2023-53137: ext4: Fix possible corruption when moving a directory

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53137

Introduced by commit 32f7f22 ("ext4: let ext4_rename handle inline
dir") in v3.8-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0813299c586b175d7edb25f56412c54b812d0379]
stable/5.10: [0c440f14558bfacd22c6935ae1fd4b2a09e96b5d]
stable/5.15: [c50fc503ee1b97f12c98e26afc39fdaebebcf04f]
stable/5.4: [8dac5a63cf79707b547ea3d425fead5f4482198f]
stable/6.1: [b0bb13612292ca90fa4c2a7e425375649bc50d3e]

CVE-2023-53138: net: caif: Fix use-after-free in cfusbl_device_notify()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53138

Introduced by commit 7ad65bf ("caif: Add support for CAIF over CDC NCM
USB interface") in v3.3-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1793da97a23e31c5bf06631f3f3e5a25f368fd64]
cip/4.4-st: [a11e48683e5fe3792ccb2e759a38f61cef6cdee9]
mainline: [9781e98a97110f5e76999058368b4be76a788484]
stable/4.19: [1793da97a23e31c5bf06631f3f3e5a25f368fd64]
stable/5.10: [c3aaec463a632cf4187dc017e421bfa69d7834a9]
stable/5.15: [3f14457e1584224f4296af613bbd99deb60b5d91]
stable/5.4: [9dc16be373b382ddd4c274052a6e870a95e76c01]
stable/6.1: [287027d8a567168a5d8ce5cb0cba16a34791a48c]

CVE-2023-53139: nfc: fdp: add null check of devm_kmalloc_array in
fdp_nci_i2c_read_device_properties

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53139

Introduced by commit a06347c ("NFC: Add Intel Fields Peak NFC solution
driver") in v4.4-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [98f49e693e02c1dafd5786be3468657840dd6f06]
cip/4.4-st: [a1c079ba7686e40bee1c1e099127e44b7d9b02fc]
mainline: [11f180a5d62a51b484e9648f9b310e1bd50b1a57]
stable/4.19: [98f49e693e02c1dafd5786be3468657840dd6f06]
stable/5.10: [80be62358fa5507cefbaa067c7e6648401f2c3da]
stable/5.15: [4357bbb921fe9e81d0fd9f70d669d1f177d8380e]
stable/5.4: [0a3664a1058d4b2b1ea2112cc275ca47fba7fc08]
stable/6.1: [ce93f1afc05941a572f5a69e2ed4012af905a693]

CVE-2023-53140: scsi: core: Remove the /proc/scsi/${proc_name} directory earlier

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53140

Introduced by commit 77c0197 ("[SCSI] fix /proc memory leak in the
SCSI core") in v2.6.30-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [13daafe1e209b03e9bda16ff2bd2b2da145a139b]
mainline: [fc663711b94468f4e1427ebe289c9f05669699c9]
stable/4.19: [13daafe1e209b03e9bda16ff2bd2b2da145a139b]
stable/5.10: [6b223e32d66ca9db1f252f433514783d8b22a8e1]
stable/5.15: [e471e928de97b00f297ad1015cc14f9459765713]
stable/5.4: [891a3cba425cf483d96facca55aebd6ff1da4338]
stable/6.1: [17e98a5ede81b7696bec421f7afa2dfe467f5e6b]

CVE-2023-53141: ila: do not generate empty messages in
ila_xlat_nl_cmd_get_mapping()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53141

Introduced by commit 7f00fea ("ila: Add generic ILA translation
facility") in v4.5-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c631e52aea0fc8d4deea06e439f5810a8b40ad0f]
mainline: [693aa2c0d9b6d5b1f2745d31b6e70d09dbbaf06e]
stable/4.19: [c631e52aea0fc8d4deea06e439f5810a8b40ad0f]
stable/5.10: [42d9ed4e5dc5f87fbd67c232e2e4a9b88ceeb47f]
stable/5.15: [91aceb3844d4aec555c7f423f9fd843eff5835e9]
stable/5.4: [783f218940b3c7b872e4111d0145000f26ecbdf6]
stable/6.1: [25b54f247ea060aeb85ec88a82c75060fca03521]

CVE-2023-53142: ice: copy last block omitted in ice_get_module_eeprom()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53142

Introduced by commit e9c9692 ("ice: Reimplement module reads used by
ethtool") in v5.13-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84cba1840e68430325ac133a11be06bfb2f7acd8]
stable/5.15: [c813f7a3161481483ae2077651b21bc217c419e0]
stable/6.1: [90b40ab29298db3a4879c1d3c4e685184386bce6]

CVE-2023-53143: ext4: fix another off-by-one fsmap error on 1k block filesystems

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53143

Introduced by commit 4a49562 ("ext4: fix off-by-one fsmap error on 1k
block filesystems") in v4.13-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f16054ac1774915160ca4e1c73ff7a269465a1b9]
mainline: [c993799baf9c5861f8df91beb80e1611b12efcbd]
stable/4.19: [f16054ac1774915160ca4e1c73ff7a269465a1b9]
stable/5.10: [1d2366624b4c19a2ba6baf67fe57f4a1b0f67c05]
stable/5.15: [c5d7c31e17224d847a330180ec1b03bf390632b2]
stable/5.4: [c24f838493792b5e78a3596b4ca96375aa0af4c2]
stable/6.1: [eb3a695aa71a514f2e7f5778e05faba3733b70a0]

CVE-2023-53144: erofs: fix wrong kunmap when using LZMA on HIGHMEM platforms

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53144

Introduced by commit 622cead ("erofs: lzma compression support") in v5.16-rc1.
Fixed in v6.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f121dfb15f7b4ab345992ce96003eb63fd608f4]
stable/6.1: [fa4056781ac067b5946c6811459e1a36842047fd]

CVE-2025-37797: net_sched: hfsc: Fix a UAF vulnerability in class handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37797

Introduced by commit 21f4d5c ("net_sched/hfsc: fix curve activation in
hfsc_change_class()") in v4.14-rc2.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3df275ef0a6ae181e8428a6589ef5d5231e58b5c]
stable/5.10: [39b9095dd3b55d9b2743df038c32138efa34a9de]
stable/5.15: [fcc8ede663569c704fb00a702973bd6c00373283]
stable/5.4: [28b09a067831f7317c3841812276022d6c940677]
stable/6.1: [20d584a33e480ae80d105f43e0e7b56784da41b9]
stable/6.6: [3aa852e3605000d5c47035c3fc3a986d14ccfa9f]

CVE-2025-37798: codel: remove sch->q.qlen check before
qdisc_tree_reduce_backlog()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37798

Introduced by commit 4b549a2 ("fq_codel: Fair Queue Codel AQM") in v3.5-rc1.
Introduced by commit 76e3cc1 ("codel: Controlled Delay AQM") in v3.5-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [342debc12183b51773b3345ba267e9263bdfaaef]
stable/6.1: [829c49b6b2ff45b043739168fd1245e4e1a91a30]
stable/6.6: [2f9761a94bae33d26e6a81b31b36e7d776d93dc1]

CVE-2025-37799: vmxnet3: Fix malformed packet sizing in vmxnet3_process_xdp

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37799

Introduced by e127ce7 ("vmxnet3: Fix missing reserved tailroom").
Fixed in master.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [4c2227656d9003f4d77afc76f34dd81b95e4c2c4]
stable/6.6: [c4312c4d244aa58e811ff0297e013124d115e793]

CVE-2022-21546: scsi: target: Fix WRITE_SAME No Data Buffer crash

Announce: https://www.cve.org/CVERecord?id=CVE-2022-21546



Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccd3f449052449a917a3e577d8ba0368f43b8f29]

CVE-2024-58098: bpf: track changes_pkt_data property for global functions

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58098

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.


Fixed status
mainline: [51081a3f25c742da5a659d7fc6fd77ebfdd555be]

CVE-2024-58100: bpf: check changes_pkt_data property for extension programs

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58100

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.


Fixed status
mainline: [81f6d0530ba031b5f038a091619bf2ff29568852]

CVE-2024-58237: bpf: consider that tail calls invalidate packet pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58237

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.


Fixed status
mainline: [1a4607ffba35bf2a630aab299e34dd3f6e658d70]

CVE-2020-36791: net_sched: keep alloc_hash updated after hash allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2020-36791

Introduced by commit 599be01 ("net_sched: fix an OOB access in cls_tcindex")
in 5.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
cip/4.19-st: [557d015ffb27b672e24e6ad141fd887783871dc2]
cip/4.4-st: [d6cdc5bb19b595486fb2e6661e5138d73a57f454]
mainline: [0d1c3530e1bd38382edef72591b78e877e0edcd3]
stable/4.19: [557d015ffb27b672e24e6ad141fd887783871dc2]
stable/5.4: [d23faf32e577922b6da20bf3740625c1105381bf]


* Updated CVEs
CVE-2021-47247: net/mlx5e: Fix use-after-free of encap entry in neigh
update handler

stable/5.10 was fixed.

Fixed status
stable/5.10: [0d1e7a7964ce6abb28883a3906bbc20fe0009f03]

CVE-2021-47352: virtio-net: Add validation for used length

stable/5.4 was fixed.

Fixed status
stable/5.10: [c92298d228f61589dd21657af2bea95fc866b813]
stable/5.4: [c1b40d1959517ff2ea473d40eeab4691d6d62462]

CVE-2022-48893: drm/i915/gt: Cleanup partial engine discovery failures

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [78350c36fb15afef423404a83dcbc5c558dce795]
stable/5.15: [7d21587d35bc816c85a51b8686f0f7e8e676fb14]
stable/6.1: [5c855bcc730656c4b7d30aaddcd0eafc7003e112]

CVE-2022-49190: kernel/resource: fix kfree() of bootmem memory again

stable/5.10 was fixed.

Fixed status
stable/5.10: [3379a60f6bb4afcd9c456e340ac525ae649d3ce7]
stable/5.15: [a9e88c2618d228d7a4e7e515cf30dc0d0d813f27]

CVE-2022-49219: vfio/pci: fix memory leak during D3hot to D0 transition

stable/5.10 was fixed.

Fixed status
stable/5.10: [da426ad86027b849b877d4628b277ffbbd2f5325]
stable/5.15: [4319f17fb8264ba39352b611dfa913a4d8c1d1a0]

CVE-2022-49309: drivers: staging: rtl8723bs: Fix deadlock in
rtw_surveydone_event_callback()

stable/5.10 was fixed.

Fixed status
stable/5.10: [c84e5c819600ee0628f61b33d145258ae0f3d7a7]
stable/5.15: [f89f6c3ebf69623b8ea48200bd690e9e210335a1]

CVE-2022-49535: scsi: lpfc: Fix null pointer dereference after failing
to issue FLOGI and PLOGI

stable/5.15 was fixed.

Fixed status
stable/5.15: [c7dc74ab7975c9b96284abfe4cca756d75fa4604]

CVE-2023-23000: phy: tegra: xusb: Fix return value of
tegra_xusb_find_port_node function

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e025d0772ebcca04487aa0623abdf0599ee2930b]
stable/5.15: [c1cbf006feee7492eada54dec6c115bc2c7e5791]

CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [99960d282fba6634fa758df4124cb73ef8a77d8a]
stable/5.15: [ed3b36f351d97dacb62cd0f399e8cf79f73bd30a]
stable/6.1: [908b3b5e97d25e879de3d1f172a255665491c2c3]

CVE-2023-52621: bpf: Check rcu_read_lock_trace_held() before calling
bpf map helpers

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [82f2df94dac1aa9b879e74d1f82ba1b631bdc612]
stable/5.15: [3516f93cc63d956e1b290ae4b7bf2586074535a0]
stable/6.1: [d6d6fe4bb105595118f12abeed4a7bdd450853f3]
stable/6.6: [483cb92334cd7f1d5387dccc0ab5d595d27a669d]
stable/6.7: [c7f1b6146f4a46d727c0d046284c28b6882c6304]

CVE-2023-52752: smb: client: fix use-after-free bug in
cifs_debug_data_proc_show()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2abdf136784b7edaec7ffe0f4b461b63f9c4c4de]
stable/5.15: [336a066990bb3962c46daf574ace596bda9303ce]
stable/6.1: [558817597d5fbd7af31f891b67b0fd20f0d047b7]
stable/6.6: [0ab6f842452ce2cae04209d4671ac6289d0aef8a]

CVE-2023-52757: smb: client: fix potential deadlock when releasing mids

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [99f476e27aad5964ab13777d84fda67d1356dec1]
stable/5.15: [ce49569079a9d4cad26c0f1d4653382fd9a5ca7a]
stable/6.1: [9eb44db68c5b7f5aa22b8fc7de74a3e2e08d1f29]
stable/6.6: [c1a5962f1462b64fe7b69f20a4b6af8067bc2d26]

CVE-2024-24855: NULL pointer dereference bug was found in scsi device driver

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [192fff6c78231a47f5372ae1411a5a1a81615814]
stable/5.15: [6e9ed2f4721ea00f6333ccfe34b3ddaef4e62f39]
stable/6.1: [30652c8ceb9a1e6c13c03f9e570d560f86022d75]

CVE-2024-26686: fs/proc: do_task_stat: use sig->stats_lock to gather
the threads/children stats

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [4fe85bdaabd63f8f8579b24a10ed597c9c482164]
stable/5.15: [0c35d1914353799c54fa1843fe7dea6fcbcdbac5]
stable/6.1: [cf4b8c39b9a0bd81c47afc7ef62914a62dd5ec4d]
stable/6.6: [3820b0fac7732a653bcc6f6ac20c1d72e697f8f6]
stable/6.7: [27978243f165b44e342f28f449b91327944ea071]

CVE-2024-26739: net/sched: act_mirred: don't override retval if we
already lost the skb

stable/6.1 was fixed.

Fixed status
stable/6.1: [e873e8f7d03a2ee5b77fb1a305c782fed98e2754]
stable/6.6: [28cdbbd38a4413b8eff53399b3f872fd4e80db9d]
stable/6.7: [f4e294bbdca8ac8757db436fc82214f3882fc7e7]

CVE-2024-26744: RDMA/srpt: Support specifying the srpt_service_guid parameter

stable/5.4 was fixed.

Fixed status
cip/4.19: [84f1dac960cfa210a3b7a7522e6c2320ae91932b]
cip/4.19-rt: [84f1dac960cfa210a3b7a7522e6c2320ae91932b]
cip/4.19-st: [84f1dac960cfa210a3b7a7522e6c2320ae91932b]
stable/4.19: [84f1dac960cfa210a3b7a7522e6c2320ae91932b]
stable/5.10: [5a5c039dac1b1b7ba3e91c791f4421052bf79b82]
stable/5.15: [989af2f29342a9a7c7515523d879b698ac8465f4]
stable/5.4: [e0055d6461b36bfc25a9d2ab974eef78d36a6738]
stable/6.1: [aee4dcfe17219fe60f2821923adea98549060af8]
stable/6.6: [fe2a73d57319feab4b3b175945671ce43492172f]
stable/6.7: [c99a827d3cff9f84e1cb997b7cc6386d107aa74d]

CVE-2024-26928: smb: client: fix potential UAF in cifs_debug_files_proc_show()

stable/5.10 was fixed.

Fixed status
stable/5.10: [8f8718afd446cd4ea3b62bacc3eec09f8aae85ee]
stable/5.15: [a140224bcf87eb98a87b67ff4c6826c57e47b704]
stable/6.1: [229042314602db62559ecacba127067c22ee7b88]
stable/6.6: [a65f2b56334ba4dc30bd5ee9ce5b2691b973344d]
stable/6.8: [3402faf78b2516b0af1259baff50cc8453ef0bd1]

CVE-2024-26952: ksmbd: fix potencial out-of-bounds when buffer offset is invalid

stable/5.15 was fixed.

Fixed status
stable/5.15: [480469f145e5abf83361e608734e421b7d99693d]
stable/6.1: [ad6480c9a5d884e2704adc51d69895d93339176c]
stable/6.6: [39bdc4197acf2ed13269167ccf093ee28cfa2a4e]
stable/6.8: [0c5541b4c980626fa3cab16ba1a451757778bbb5]

CVE-2024-27054: s390/dasd: fix double module refcount decrement

stable/5.10 was fixed.

Fixed status
stable/5.10: [9fe0562179d8fa960afca0eaed6d4ba4122a3cc6]
stable/5.15: [edbdb0d94143db46edd373cc93e433832d29fe19]
stable/6.1: [ad999aa18103fa038787b6a8a55020abcf34df1a]
stable/6.6: [ec09bcab32fc4765e0cc97e1b72cdd067135f37e]
stable/6.8: [ebc5a3bd79e54f98c885c26f0862a27a02c487c5]

CVE-2024-27402: phonet/pep: fix racy skb_queue_empty() use

stable/5.15 was fixed.

Fixed status
stable/5.15: [7d3914a477eed92b48c493a8631cc4554ab4fd4f]
stable/6.1: [9d5523e065b568e79dfaa2ea1085a5bcf74baf78]
stable/6.6: [0a9f558c72c47472c38c05fcb72c70abb9104277]

CVE-2024-35866: smb: client: fix potential UAF in cifs_dump_full_key()

stable/5.15 was fixed.

Fixed status
stable/5.15: [d798fd98e3563027c5162259ead517057d6fa794]
stable/6.1: [f4a60d360d9114b5085701a3702a0102b0d6d846]
stable/6.6: [10e17ca4000ec34737bde002a13435c38ace2682]
stable/6.8: [3103163ccd3be4adcfa37e15608fb497be044113]

CVE-2024-35867: smb: client: fix potential UAF in cifs_stats_proc_show()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [838ec01ea8d3deb5d123e8ed9022e8162dc3f503]
stable/5.15: [bb6570085826291dc392005f9fec16ea5da3c8ad]
stable/6.1: [16b7d785775eb03929766819415055e367398f49]
stable/6.6: [c3cf8b74c57924c0985e49a1fdf02d3395111f39]
stable/6.8: [1e12f0d5c66f07c934041621351973a116fa13c7]

CVE-2024-35943: pmdomain: ti: Add a null pointer check to the
omap_prm_domain_init

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e65f7eb117e1b44742212d65784236269085e736]
stable/5.15: [984212fa6b4bc6d9ed58f5b0838e8d5af7679ce5]
stable/6.1: [bc08f5ab11b1881b85371f0bd9c9a3d27f65cca8]
stable/6.6: [ce666cecc09c0f92d5f86d89d8068ecfcf723a7e]
stable/6.8: [04f23510daa40f9010fadf309507564a34ad956f]

CVE-2024-36908: blk-iocost: do not WARN if iocg was already offlined

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [56a9d07f427378eeb75b917bb49c6fbea8204126]
stable/5.15: [7d215e013d097ed6fc4b0ad0272c9514214dc408]
stable/6.1: [aed0aac18f039dd4af13c143063754efca358cb0]
stable/6.6: [1c172ac7afe4442964f4153b2c78fe4e005d9d67]

CVE-2024-38540: bnxt_re: avoid shift undefined behavior in
bnxt_qplib_alloc_init_hwq

stable/5.15 was fixed.

Fixed status
stable/5.15: [66a9937187ac9b5c5ffff07b8b284483e56804d1]
stable/6.1: [84d2f29152184f0d72ed7c9648c4ee6927df4e59]
stable/6.6: [a658f011d89dd20cf2c7cb4760ffd79201700b98]
stable/6.9: [8b799c00cea6fcfe5b501bbaeb228c8821acb753]

CVE-2024-38541: of: module: add buffer overflow check in of_modalias()

stable/6.1 was fixed.

Fixed status
stable/6.1: [5d59fd637a8af42b211a92b2edb2474325b4d488]
stable/6.6: [0b0d5701a8bf02f8fee037e81aacf6746558bfd6]
stable/6.9: [e45b69360a63165377b30db4a1dfddd89ca18e9a]

CVE-2024-41073: nvme: avoid double free special payload

stable/5.10 was fixed.

Fixed status
stable/5.10: [882574942a9be8b9d70d13462ddacc80c4b385ba]
stable/5.15: [c5942a14f795de957ae9d66027aac8ff4fe70057]
stable/6.1: [f3ab45aacd25d957547fb6d115c1574c20964b3b]
stable/6.6: [ae84383c96d6662c24697ab6b44aae855ab670aa]

CVE-2024-42160: f2fs: check validation of fault attrs in f2fs_build_fault_attr()

stable/5.15 was fixed.

Fixed status
stable/5.15: [6e5b601706ce05d94338cad598736d96bb8096c8]
stable/6.1: [bc84dd2c33e0c10fd90d60f0cfc0bfb504d4692d]
stable/6.6: [44958ca9e400f57bd0478115519ffc350fcee61e]

CVE-2024-42322: ipvs: properly dereference pe in ip_vs_add_service

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [36c997f1e03601475ad0fda0e0f59b7a209e756b]
stable/5.15: [211168339657f36f32fb597afd0e3ac82d726119]
stable/6.1: [b2c664df3bb46aabac6a5fd78aaa5bd614cfad97]
stable/6.10: [c420cd5d5bc6797f3a8824e7d74f38f0c286fca5]
stable/6.6: [3dd428039e06e1967ce294e2cd6342825aaaad77]

CVE-2024-43904: drm/amd/display: Add null checks for 'stream' and
'plane' before dereferencing

stable/5.15 was fixed.

Fixed status
stable/5.15: [fcf9d6a9f30ea414b6b84a6e901cebd44e146847]
stable/6.1: [5e84eda48ffb2363437db44bbd0235594f8a58f9]
stable/6.10: [16a8a2a839d19c4cf7253642b493ffb8eee1d857]
stable/6.6: [10c20d79d59cadfe572480d98cec271a89ffb024]

CVE-2024-44938: jfs: Fix shift-out-of-bounds in dbDiscardAG

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [bb7c605a754823b86dd74f6537ccb9d38a9dec5a]
stable/5.15: [4de2c04c3acd5b84f50b0d2f8f09e9b2f42374b9]
stable/6.1: [bd04a149e3a29e7f71b7956ed41dba34e42d539e]
stable/6.10: [234e6ea0855cdb5673d54ecaf7dc5c78f3e84630]
stable/6.6: [f650148b43949ca9e37e820804bb6026fff404f3]

CVE-2024-46742: smb/server: fix potential null-ptr-deref of
lease_ctx_info in smb2_open()

stable/5.15 was fixed.

Fixed status
stable/5.15: [878f32878351104448b86ef5b85d1f8ed6f599fb]
stable/6.1: [ec28c35029b7930f31117f9284874b63bea4f31b]
stable/6.10: [3b692794b81f2ecad69a4adbba687f3836824ada]
stable/6.6: [07f384c5be1f8633b13f0a22616e227570450bc6]

CVE-2024-46774: powerpc/rtas: Prevent Spectre v1 gadget construction
in sys_rtas()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d2834ff1d9641a8695a09ea79cd901c7b6d4d05f]
stable/5.15: [a262c2dc833f2fe1bd5c53a4d899e7077d3b1da9]
stable/6.1: [b137af795399d8b657bad1646c18561530f35ed1]
stable/6.10: [68d8156480940b79227d58865ec5d2947b9384a8]
stable/6.6: [1f1feff02e9da0dd0cdb195c428c42b5f9b6c771]

CVE-2024-46784: net: mana: Fix error handling in mana_create_txq/rxq's
NAPI cleanup

stable/5.15 was fixed.

Fixed status
stable/5.15: [386617efacab10bf5bb40bde403467c57cc00470]
stable/6.1: [9178eb8ebcd887ab75e54ac40d538e54bb9c7788]
stable/6.10: [4982a47154f0b50de81ee0a0b169a3fc74120a65]
stable/6.6: [9e0bff4900b5d412a9bafe4baeaa6facd34f671c]

CVE-2024-46816: drm/amd/display: Stop amdgpu_dm initialize when link
nums greater than max_links

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e2411b6abf6e5d6c33d0450846673cdf536f0ba4]
stable/5.15: [e3cd0d8362de47f613bfdf315b3f3a9ab71e66bf]
stable/6.1: [13080d052c995aee14695a5b740c245121eb2bcc]
stable/6.10: [36c39a8dcce210649f2f45f252abaa09fcc1ae87]
stable/6.6: [c84632096722fd31251f0957fafc9e90d9a247fd]

CVE-2024-49960: ext4: fix timer use-after-free on failed mount

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7aac0c17a8cdf4a3236991c1e60435c6a984076c]
stable/5.15: [22e9b83f0f33bc5a7a3181769d1dccbf021f5b04]
stable/6.1: [cf3196e5e2f36cd80dab91ffae402e13935724bc]
stable/6.11: [b85569585d0154d4db1e4f9e3e6a4731d407feb0]
stable/6.6: [9203817ba46ebba7c865c8de2aba399537b6e891]

CVE-2024-49989: drm/amd/display: fix double free issue during amdgpu
module unload

stable/5.15 was fixed.

Fixed status
stable/5.15: [43c296870740a3a264cdca9f18db12e12e9cfbdb]
stable/6.1: [df948b5ba6858d5da34f622d408e5517057cec07]
stable/6.11: [3c0ff4de45ce2c5f7997a1ffa6eefee4b79e6b58]
stable/6.6: [cf6f3ebd6312d465fee096d1f58089b177c7c67f]

CVE-2024-50047: smb: client: fix UAF in async decryption

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8f14a476abba13144df5434871a7225fd29af633]
stable/5.15: [ef51c0d544b1518b35364480317ab6d3468f205d]
stable/6.1: [bce966530fd5542bbb422cb45ecb775f7a1a6bc3]
stable/6.11: [538c26d9bf70c90edc460d18c81008a4e555925a]
stable/6.6: [0809fb86ad13b29e1d6d491364fc7ea4fb545995]

CVE-2024-50125: Bluetooth: SCO: Fix UAF on sco_sock_timeout

stable/5.15 was fixed.

Fixed status
stable/5.15: [74a466a15731a754bcd8b5a83c126b5122e15a45]
stable/6.1: [9ddda5d967e84796e7df1b54a55f36b4b9f21079]
stable/6.11: [80b05fbfa998480fb3d5299d93eab946f51e9c36]
stable/6.6: [d30803f6a972b5b9e26d1d43b583c7ec151de04b]

CVE-2024-50154: tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [c964bf65f80a14288d767023a1b300b30f5b9cd0]
stable/5.15: [8459d61fbf24967839a70235165673148c7c7f17]
stable/5.4: [106e457953315e476b3642ef24be25ed862aaba3]
stable/6.1: [5071beb59ee416e8ab456ac8647a4dabcda823b1]
stable/6.11: [51e34db64f4e43c7b055ccf881b7f3e0c31bb26d]
stable/6.6: [997ae8da14f1639ce6fb66a063dab54031cd61b3]

CVE-2024-50258: net: fix crash when config small gso_max_size/gso_ipv4_max_size

stable/5.15 was fixed.

Fixed status
stable/5.15: [90c8482a5d9791259ba77bfdc1849fc5128b4be7]
stable/6.1: [e9365368b483328639c03fc730448dccd5a25b6b]
stable/6.11: [e72fd1389a5364bc6aa6312ecf30bdb5891b9486]
stable/6.6: [ac5977001eee7660c643f8e07a2de9001990b7b8]

CVE-2024-50272: filemap: Fix bounds checking in filemap_read()

stable/5.15 was fixed.

Fixed status
stable/5.15: [6cc52df69e8464811f9f6fc12f7aaa78451eb0b8]
stable/6.1: [26530b757c81f1389fb33ae0357500150933161b]
stable/6.11: [6450e73f4c86d481ac2e22e1bc848d346e140826]
stable/6.6: [a2746ab3bbc9c6408da5cd072653ec8c24749235]

CVE-2024-50280: dm cache: fix flushing uninitialized delayed_work on
cache_ctr error

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [40fac0271c7aedf60d81ed8214e80851e5b26312]
stable/5.15: [d154b333a5667b6c1b213a11a41ad7aaccd10c3d]
stable/6.1: [5a754d3c771280f2d06bf8ab716d6a0d36ca256e]
stable/6.11: [aee3ecda73ce13af7c3e556383342b57e6bd0718]
stable/6.6: [8cc12dab635333c4ea28e72d7b947be7d0543c2c]

CVE-2024-53128: sched/task_stack: fix object_is_on_stack() for KASAN
tagged pointers

stable/5.15 was fixed.

Fixed status
stable/5.15: [82e813b12b10ff705f3f5d600d8492fc5248618b]
stable/6.1: [397383db9c69470642ac95beb04f2150928d663b]
stable/6.11: [fbfe23012cec509dfbe09852019c4e4bb84999d0]
stable/6.6: [2d2b19ed4169c38dc6c61a186c5f7bdafc709691]

CVE-2024-53185: smb: client: fix NULL ptr deref in crypto_aead_setkey()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [92c5b62879073b489793a067dbe8d4f2728cdcad]
stable/5.15: [4a788ebbb10db9da453d52eaf44a41c13dc446df]
stable/6.1: [44c495818d9c4a741ab9e6bc9203ccc9f55f6f40]
stable/6.12: [9b8904b53b5ace0519c74cd89fc3ca763f3856d4]
stable/6.6: [46f8e25926817272ec8d5bfbd003569bdeb9a8c8]

CVE-2024-54458: scsi: ufs: bsg: Set bsg_queue to NULL after removal

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [bb4783c670180b922267222408e1c48d22dfbb46]
stable/5.15: [22018622e1e9e371198dbd983af946a844d5924c]
stable/6.1: [5e7b6e44468c3242c21c2a8656d009fb3eb50a73]
stable/6.12: [88a01e9c9ad40c075756ba93b47984461d4ff15d]
stable/6.13: [9193bdc170cc23fe98aca71d1a63c0bf6e1e853b]
stable/6.6: [5f782d4741bf558def60df192b858b0efc6a5f0a]

CVE-2024-56551: drm/amdgpu: fix usage slab after free

stable/5.15 was fixed.

Fixed status
stable/5.15: [3cc1116de10953f0265a05d9f351b02a9ec3b497]
stable/6.1: [05b1b33936b71e5f189a813a517f72e8a27fcb2f]
stable/6.12: [6383199ada42d30562b4249c393592a2a9c38165]
stable/6.6: [3990ef742c064e22189b954522930db04fc6b1a7]

CVE-2024-56599: wifi: ath10k: avoid NULL pointer error during sdio remove

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [27d5d217ae7ffb99dd623375a17a7d3418d9c755]
stable/5.15: [27fda36eedad9e4ec795dc481f307901d1885112]
stable/6.1: [6e5dbd1c04abf2c19b2282915e6fa48b6ccc6921]
stable/6.12: [543c0924d446b21f35701ca084d7feca09511220]
stable/6.6: [b35de9e01fc79c7baac666fb2dcb4ba7698a1d97]

CVE-2024-56608: drm/amd/display: Fix out-of-bounds access in
'dcn21_link_encoder_create'

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [280f722601c8bf4d8a9c62dd727cf3a2fd0a47be]
stable/5.15: [b19ca8425a4b86e8f0d7c33c4e87ef7b0ebdaa29]
stable/6.1: [5bd410c21037107b83ffbb51dd2d6460f9de9ed1]
stable/6.12: [f01ddd589e162979421e6914b1c74018633f01e0]
stable/6.6: [08ac5fdb9c6dc34d0ed4bc64ce3c5c3d411b3b53]

CVE-2024-56609: wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb

stable/6.1 was fixed.

Fixed status
stable/6.1: [4e8ce3978d704cb28678355d294e10a008b6230a]
stable/6.12: [9bca6528f20325d30c22236b23116f161d418f6d]
stable/6.6: [3d94c4b21966b49c3e26ceeefacaa11ff7ee6d68]

CVE-2024-56658: net: defer final 'struct net' free in netns dismantle

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c261dcd61c9e88a8f1a66654354d32295a975230]
stable/5.15: [dac465986a4a38cd2f13e934f562b6ca344e5720]
stable/6.1: [3267b254dc0a04dfa362a2be24573cfa6d2d78f5]
stable/6.12: [6610c7f8a8d47fd1123eed55ba8c11c2444d8842]
stable/6.6: [b7a79e51297f7b82adb687086f5cb2da446f1e40]

CVE-2024-56751: ipv6: release nexthop on device removal

stable/5.15 was fixed.

Fixed status
stable/5.15: [77aa9855a878fb43f547ddfbda3127a1e88ad31a]
stable/6.1: [b2f26a27ea3f72f75d18330f76f5d1007c791848]
stable/6.12: [0e4c6faaef8a24b762a24ffb767280e263ef8e10]
stable/6.6: [43e25adc80269f917d2a195f0d59f74cdd182955]

CVE-2025-21681: openvswitch: fix lockup on tx to unregistering netdev
with carrier

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [87fcf0d137c770e6040ebfdb0abd8e7dd481b504]
stable/5.15: [930268823f6bccb697aa5d2047aeffd4a497308c]
stable/5.4: [b5c73fc92f8d15c16e5dc87b5c17d2abf1e6d092]
stable/6.1: [ea9e990356b7bee95440ba0e6e83cc4d701afaca]
stable/6.12: [82f433e8dd0629e16681edf6039d094b5518d8ed]
stable/6.6: [ea966b6698785fb9cd0fdb867acd91b222e4723f]

CVE-2025-21853: bpf: avoid holding freeze_mutex during mmap operation

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2ce31c97c219b4fe797749f950274f246eb88c49]
stable/5.15: [0d90d9e154144a3a80e9fc0eb9b21b7fc990f68f]
stable/6.1: [4759acbd44d24a69b7b14848012ec4201d6c5501]
stable/6.12: [d95607a5f2f9bb08194c9deaf4a5f3e8ba59a9d4]
stable/6.13: [271e49f8a58edba65bc2b1250a0abaa98c4bfdbe]
stable/6.6: [29cfda62ab4d92ab94123813db49ab76c1e61b29]

CVE-2025-22013: KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state

stable/5.15 was fixed.

Fixed status
stable/5.15: [5289ac43b69c61a49c75720921f2008005a31c43]
stable/6.1: [04c50cc23a492c4d43fdaefc7c1ecc0ff6f7b82e]
stable/6.12: [79e140bba70bcacc5fe15bf8c0b958793fd7d56f]
stable/6.13: [900b444be493b7f404898c785d6605b177a093d0]
stable/6.6: [806d5c1e1d2e5502175a24bf70f251648d99c36a]

CVE-2025-22027: media: streamzap: fix race between device
disconnection and urb callback

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e11652a6514ec805440c1bb3739e6c6236fffcc7]
stable/5.15: [f1d518c0bad01abe83c2df880274cb6a39f4a457]
stable/6.1: [30ef7cfee752ca318d5902cb67b60d9797ccd378]
stable/6.12: [adf0ddb914c9e5b3e50da4c97959e82de2df75c3]
stable/6.13: [4db62b60af2ccdea6ac5452fd20e29587ed85f57]
stable/6.14: [8760da4b9d44c36b93b6e4cf401ec7fe520015bd]
stable/6.6: [15483afb930fc2f883702dc96f80efbe4055235e]

CVE-2025-22028: media: vimc: skip .s_stream() for stopped entities

stable/6.6 was fixed.

Fixed status
stable/6.12: [845e9286ff99ee88cfdeb2b748f730003a512190]
stable/6.13: [6f6064dab4dcfb7e34a395040a0c9dc22cc8765d]
stable/6.14: [7a58d4c4cf8ff60ab1f93399deefaf6057da91c7]
stable/6.6: [a505075730d23ccc19fc4ac382a0ed73b630c057]

CVE-2025-22120: ext4: goto right label 'out_mmap_sem' in ext4_setattr()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [45314999f950321a341033ae8f9ac12dce40669b]
stable/6.14: [32d872e3905746ff1048078256cb00f946b97d8a]
stable/6.6: [551667f99bcf04fa58594d7d19aef73c861a1200]

CVE-2025-37767: drm/amd/pm: Prevent division by zero

stable/5.15 was fixed.

Fixed status
stable/5.15: [f2904fa2b9da943db6bef7c0f8b3fb4fc14acbc4]
stable/6.1: [8f7b5987e21e003cafac28f0e4d323e6496f83ba]
stable/6.12: [fb803d4bb9ea0a61c21c4987505e4d4ae18f9fdc]
stable/6.14: [327107bd7f052f4ee2d0c966c7ae879822f1814f]
stable/6.6: [c3ff73e3bddf1a6c30d7effe4018d12ba0cadd2e]

CVE-2025-37768: drm/amd/pm: Prevent division by zero

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [3cdd02cb70682d7d205ca6dc02a4d1eb76758d24]
stable/5.15: [be0fffc4152aac4f0291ed2d793f3cfee788449d]
stable/6.1: [5fc4fb54f6f064c25bfbbfd443aa861d3422dd4c]
stable/6.12: [8e9c4f8d197d5709c75effa5d58e80b4fa01981a]
stable/6.14: [9e4f1e21fe7b93a8ef57db433071266c2590e260]
stable/6.6: [b0742a709be7979c7a480772046a1f36d09dab00]

CVE-2025-37770: drm/amd/pm: Prevent division by zero

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e109528bbf460e50074c156253d9080d223ee37f]
stable/5.15: [0c02fcbe4a1393a3c02da6ae35e72493cfdb2155]
stable/6.1: [836a189fb422e7efb81c51d5160e47ec7bc11500]
stable/6.12: [bd4d90adbca1862d03e581e10e74ab73ec75e61b]
stable/6.14: [05de66de280ea1bd0459c994bfd2dd332cfbc2a9]
stable/6.6: [587de3ca7875c06fe3c3aa4073a85c4eff46591f]

CVE-2025-37771: drm/amd/pm: Prevent division by zero

stable/5.15 was fixed.

Fixed status
stable/5.15: [b7c41df4913789ebfe73cc1e17c6401d4c5eab69]
stable/6.1: [402964994e8ece29702383b234fabcf04791ff95]
stable/6.12: [6413fed016208171592c88b5df002af8a1387e24]
stable/6.14: [baa54adb5e0599299b8f088efb5544d876a3eb62]
stable/6.6: [5096174074114f83c700a27869c54362cbb10f3e]

CVE-2025-37773: virtiofs: add filesystem context source name check

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [9d6dcf18a1b49990295ac8a05fd9bdfd27ccbf88]
stable/5.15: [5ee09cdaf3414f6c92960714af46d3d90eede2f3]
stable/5.4: [b84f13fdad10a543e2e65bab7e81b3f0bceabd67]
stable/6.1: [599d1e2a6aecc44acf22fe7ea6f5e84a7e526abe]
stable/6.12: [c3e31d613951c299487844c4d1686a933e8ee291]
stable/6.14: [a648d80f8d9b208beee03a2d9aa690cfacf1d41e]
stable/6.6: [f6ec52710dc5e156b774cbef5d0f5c99b1c53a80]

CVE-2025-37777: ksmbd: fix use-after-free in __smb2_lease_break_noti()

stable/6.12 was fixed.

Fixed status
stable/6.12: [1aec4d14cf81b7b3e7b69eb1cfa94144eed7138e]
stable/6.14: [e59796fc80603bcd8569d4d2e10b213c1918edb4]

CVE-2025-37780: isofs: Prevent the use of too small fid

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [5e7de55602c61c8ff28db075cc49c8dd6989d7e0]
stable/5.15: [63d5a3e207bf315a32c7d16de6c89753a759f95a]
stable/5.4: [ee01a309ebf598be1ff8174901ed6e91619f1749]
stable/6.1: [0fdafdaef796816a9ed0fd7ac812932d569d9beb]
stable/6.12: [56dfffea9fd3be0b3795a9ca6401e133a8427e0b]
stable/6.14: [007124c896e7d4614ac1f6bd4dedb975c35a2a8e]
stable/6.6: [952e7a7e317f126d0a2b879fc531b716932d5ffa]

CVE-2025-37781: i2c: cros-ec-tunnel: defer probe if parent EC is not present

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [b66d4910a608427367c4e21499e149f085782df7]
stable/5.15: [cd83035b6f2a102c2d5acd3bfb2a11ff967aaba6]
stable/5.4: [092de5ac8cb2eaa9593a765fa92ba39d8173f984]
stable/6.1: [3090cad5ccff8963b95160f4060068048a1e4c4c]
stable/6.12: [1355b5ca4782be85a2ef7275e4c508f770d0fb27]
stable/6.14: [da8edc9eb2516aface7f86be5fa6d09c0d07b9f8]
stable/6.6: [e89bf1311d4497c6743f3021e9c481b16c3a41c9]

CVE-2025-37782: hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [f6651c04191d49907d40f0891bbe51ef9703c792]
stable/5.15: [a33c035df01d1e008874607da74bf7cf45152f47]
stable/5.4: [8060afd77761eac2048db12fb0510d76ce0cf1f3]
stable/6.1: [0296f9733543c7c8e666e69da743cfffd32dd805]
stable/6.12: [84e8719c087e68c967975b78e67be54f697c957f]
stable/6.14: [9c93fb4ad8d3b730afe1a09949ebbea64d4f60eb]
stable/6.6: [9f77aa584a659b21211a794e53522e6fb16d4a16]

CVE-2025-37785: ext4: fix OOB read when checking dotdot dir

stable/5.4 was fixed.

Fixed status
stable/5.10: [e47f472a664d70a3d104a6c2a035cdff55a719b4]
stable/5.15: [b7531a4f99c3887439d778afaf418d1a01a5f01b]
stable/5.4: [14da7dbecb430e35b5889da8dae7bef33173b351]
stable/6.1: [89503e5eae64637d0fa2218912b54660effe7d93]
stable/6.12: [b47584c556444cf7acb66b26a62cbc348eb92b78]
stable/6.13: [ac28c5684c1cdab650a7e5065b19e91577d37a4b]
stable/6.14: [53bc45da8d8da92ec07877f5922b130562eb4b00]
stable/6.6: [52a5509ab19a5d3afe301165d9b5787bba34d842]

CVE-2025-37787: net: dsa: mv88e6xxx: avoid unregistering devlink
regions which were never registered

stable/5.15 was fixed.

Fixed status
stable/5.15: [8ccdf5e24b276848eefb2755e05ff0f005a0c4a1]
stable/6.1: [b3c70dfe51f10df60db2646c08cebd24bcdc5247]
stable/6.12: [3665695e3572239dc233216f06b41f40cc771889]
stable/6.14: [5f5e95945bb1e08be7655da6acba648274db457d]
stable/6.6: [bbb80f004f7a90c3dcaacc982c59967457254a05]

CVE-2025-37788: cxgb4: fix memory leak in cxgb4_init_ethtool_filters()
error path

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e9de08e15aee35b96064960f95997bb6c1209c4b]
stable/5.15: [118d05b530343cd9322607b9719405ba254a4183]
stable/6.1: [fa2d7708955e4f8212fd69bab1da604e60cb0b15]
stable/6.12: [dafb6e433ab2333b67be05433dc9c6ccbc7b1284]
stable/6.14: [76deedea08899885f076aba0bb80bd1276446822]
stable/6.6: [08aa59c0be768596467552c129e9f82166779a67]

CVE-2025-37789: net: openvswitch: fix nested key length validation in
the set() action

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [7fcaec0b2ab8fa5fbf0b45e5512364a168f445bd]
stable/5.15: [a27526e6b48eee9e2d82efff502c4f272f1a91d4]
stable/5.4: [54c6957d1123a2032099b9eab51c314800f677ce]
stable/6.1: [1489c195c8eecd262aa6712761ba5288203e28ec]
stable/6.12: [be80768d4f3b6fd13f421451cc3fee8778aba8bc]
stable/6.14: [03d7262dd53e8c404da35cc81aaa887fd901f76b]
stable/6.6: [824a7c2df5127b2402b68a21a265d413e78dcad7]

CVE-2025-37790: net: mctp: Set SOCK_RCU_FREE

stable/5.15 was fixed.

Fixed status
stable/5.15: [5c1313b93c8c2e3904a48aa88e2fa1db28c607ae]
stable/6.1: [b9764ebebb007249fb733a131b6110ff333b6616]
stable/6.12: [3f899bd6dd56ddc46509b526e23a8f0a97712a6d]
stable/6.14: [e3b5edbdb45924a7d4206d13868a2aac71f1e53d]
stable/6.6: [a8a3b61ce140e2b0a72a779e8d70f60c0cf1e47a]

CVE-2025-37792: Bluetooth: btrtl: Prevent potential NULL dereference

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [73dc99c0ea94abd22379b2d82cacbc73f3e18ec1]
stable/5.15: [2d7c60c2a38b4b461fa960ad0995136a6bfe0756]
stable/5.4: [c3e9717276affe59fd8213706db021b493e81e34]
stable/6.1: [d8441818690d795232331bd8358545c5c95b6b72]
stable/6.12: [aaf356f872a60db1e96fb762a62c4607fd22741f]
stable/6.14: [53ceef799dcfc22c734d600811bfc9dd32eaea0a]
stable/6.6: [3db6605043b50c8bb768547b23e0222f67ceef3e]

CVE-2025-37794: wifi: mac80211: Purge vif txq in ieee80211_do_stop()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [a932a5ce4eee0cbad20220f950fe7bd3534bcbc9]
stable/5.15: [305741e7e63234cbcf9b5c4e6aeca25ba0834be8]
stable/5.4: [929ec2c9ad34248ef625e137b6118b6e965797d9]
stable/6.1: [5f6863dc407f25fcf23fc857f9ac51756a09ea2c]
stable/6.12: [a8df245b5b29f6de98d016dc18e2bb35ec70b0cb]
stable/6.14: [8bc34db7f771a464ff8f686b6f8d4e04963fec27]
stable/6.6: [c74b84544dee27298a71715b3ce2c40d372b5a23]

CVE-2025-37795: wifi: mac80211: Update skb's control block key in
ieee80211_tx_dequeue()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [47fe322fb4e000f3bb89c2b370a15f3dfdfb9109]
stable/5.15: [9d00c0a807a3bb7d8fadcd6c26f95f207ab0ce15]
stable/5.4: [bb5c4347d50410e3b262c1dd4081e36aa06826f8]
stable/6.1: [a167a2833d3f862e800cc23067b21ff1df3a1085]
stable/6.12: [159499c1341f66a71d985e9b79f2131e88d1c646]
stable/6.14: [0cbd747f343c28d911443dd4174820600cc0d952]
stable/6.6: [7fa75affe2a97abface2b0d9b95e15728967dda7]

CVE-2025-37796: wifi: at76c50x: fix use after free access in at76_disconnect

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [6e4ab3e574c2a335b40fa1f70d1c54fcb58ab33f]
stable/5.15: [3c619aec1f538333b56746d2f796aab1bca5c9a5]
stable/5.4: [c731cdfddcf1be1590d5ba8c9b508f98e3a2b3d6]
stable/6.1: [5e7df74745700f059dc117a620e566964a2e8f2c]
stable/6.12: [a9682bfef2cf3802515a902e964d774e137be1b9]
stable/6.14: [152721cbae42713ecfbca6847e0f102ee6b19546]
stable/6.6: [7ca513631fa6ad3011b8b9197cdde0f351103704]

CVE-2025-37838: HSI: ssi_protocol: Fix use after free vulnerability in
ssi_protocol Driver Due to Race Condition

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [4a8c29beb8a02b5a0a9d77d608aa14b6f88a6b86]
stable/5.15: [72972552d0d0bfeb2dec5daf343a19018db36ffa]
stable/5.4: [d03abc1c2b21324550fa71e12d53e7d3498e0af6]
stable/6.1: [d58493832e284f066e559b8da5ab20c15a2801d3]
stable/6.12: [ae5a6a0b425e8f76a9f0677e50796e494e89b088]
stable/6.13: [834e602d0cc7c743bfce734fad4a46cefc0f9ab1]
stable/6.14: [4b4194c9a7a8f92db39e8e86c85f4fb12ebbec4f]
stable/6.6: [58eb29dba712ab0f13af59ca2fe545f5ce360e78]

CVE-2025-39989: x86/mce: use is_copy_from_user() to determine
copy-from-user context

stable/6.6 was fixed.

Fixed status
stable/6.12: [3e3d8169c0950a0b3cd5105f6403a78350dcac80]
stable/6.13: [449413da90a337f343cc5a73070cbd68e92e8a54]
stable/6.14: [0b8388e97ba6a8c033f9a8b5565af41af07f9345]
stable/6.6: [5724654a084f701dc64b08d34a0e800f22f0e6e4]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

