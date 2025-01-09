Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9D7E77188
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 00:21:45 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
 by mx.groups.io with SMTP id smtpd.web11.36667.1736382095628995350
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jan 2025 16:21:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=U6QaSCvA;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.173, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so502561276.3
        for <cip-dev@lists.cip-project.org>; Wed, 08 Jan 2025 16:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1736382094; x=1736986894; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I5GJukjYC+rW7SQSUoCZ2U71Yiu48dRExJgg9FGUiX4=;
        b=U6QaSCvAvcKS5NMDs474hFTu06QbBYxO8hLXGWtS/nQkXLxIXOhjCpPs9OtdRkjBet
         3hfSXc4xeTzOuV4Fdd+rEPb/MoXWylQHh5IPIxJdT0wVwLvLOjJpBT58Z+TlkE+32Ik1
         8p9Dvi4rsT4hlGQYT15WNxDSqHxsvIvtT5zO4YM5JUaUrqwZL2AQD3R2RjZaLhA7wX0b
         Ifw4gna5zb6ab+aNqXC/0Yr3nrAX9jy/w4o0IE6v9lNMMpu2z29QG28jwWcKr31QtfCp
         2jxtM0AjYBDL6wCrmYfgNcRbnkEtEK+wIEqoE0VGuMIZ2JJ++MSG0jTWWMgR58V4aZbH
         C9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736382094; x=1736986894;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5GJukjYC+rW7SQSUoCZ2U71Yiu48dRExJgg9FGUiX4=;
        b=xCBQNtUO1OQWdkLbaNOI2paDeH0AtZUZJGpWkSi6+2PZMh3nfJJrD+THmtsxYElou0
         xGqPTwhRwdkp7GXzIDOgQStRkNmjyeG1IrDwsrzTjVXDaLKvOyV6UirQ5PIOkvhQwkGp
         qkzUNlbdils8t+1ED3BdV7H3yI7yJp9jGlvGJV8Wj5tRHequ40mVUoObJYchvDebeBuo
         npoUAg5a6NoPLTFMiZ0/3Wnsr2tEPUbM/U83wU4VvlX8n2fQG/P/MiR7rzGQNuSPFseK
         l0DvcqthMvl+e7qObvbYpBo+1bj4O1lFVhNSWyr7ZCGKGaQl7A5OeJ2qAzkxkLsKOEhw
         KkVg==
X-Gm-Message-State: AOJu0YznWzXi29yxUwOYdK5A1cTXQUtz+/a9H3hXFcluB+Tka1iQbOh3
	yLvWZhIpLPnnDIUJlnnONHj+laMoI7//Wjqm3jlQ0OrcaO9VEYaJvSe+a1LMXyNnKHWt2VAFOci
	omhV380NQdCew33nXLM8ylQwpotxyTzMaZT7+P+x0rMrUQlYir6I=
X-Gm-Gg: ASbGnctB7deu/0EMseTEDvo3Nfm8+QWFgDs+POBVvTKvdNpZKzSRBM9G7B3tugleiRQ
	NFJ70+Ln1wg4VmNDx1xKjv806VnHrhBO5eGjc4oQ=
X-Google-Smtp-Source: AGHT+IEgI8XzJ2tU830I0Q0V7FTSHJaQqlg7JyoCalzf8WCqr5R7G012OLYuv/5GA4Nh2NbmhMIay3xLgoYc07Y5Rjg=
X-Received: by 2002:a05:690c:dc3:b0:6ef:4fba:8137 with SMTP id
 00721157ae682-6f5311e46d3mr42060217b3.6.1736382094119; Wed, 08 Jan 2025
 16:21:34 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Jan 2025 09:20:57 +0900
X-Gm-Features: AbW1kvb_MK9Ek2gMpYeEmZZnOQj7NmOQ0mvP1oY6Jt_y1Wiq64YxlX_rhG6_fYs
Message-ID: <CAODzB9oeyfOvKo6eY3cNzyvDOPJdTJcUSMZQx3Wp42Hv7Ow_6A@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 00:21:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17507

Hi!

It's this week's CVE report.

This week reported 32 new CVEs and 5 updated CVEs.

* New CVEs
CVE-2022-49035: media: s5p_cec: limit msg.len to CEC_MAX_MSG_SIZE

Announce: https://lore.kernel.org/linux-cve-announce/2025010208-CVE-2022-49035-5a59@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.1-rc2.
It looks as as if this bug was introduced by commit 1bcbf6f4 ("[media]
cec: s5p-cec:
Add s5p-cec driver") in 4.8-rc1.

Fixed status
mainline: [93f65ce036863893c164ca410938e0968964b26c]
stable/4.19: [a2728bf9b6c65e46468c763e3dab7e04839d4e11]
stable/5.10: [1609231f86760c1f6a429de7913dd795b9faa08c]
stable/5.15: [cbfa26936f318b16ccf9ca31b8e8b30c0dc087bd]
stable/5.4: [4a449430ecfb199b99ba58af63c467eb53500b39]

CVE-2024-56757: Bluetooth: btusb: mediatek: add intf release flow when
usb disconnect

Announce: https://lore.kernel.org/linux-cve-announce/2025010651-CVE-2024-56757-c26b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It looks as if vulnerable feature was added by commit ceac1cb
("Bluetooth: btusb: mediatek:
add ISO data transmission functions") in 6.11-rc1.

Fixed status
mainline: [489304e67087abddc2666c5af0159cb95afdcf59]

CVE-2024-56758: btrfs: check folio mapping after unlock in relocate_one_folio()

Announce: https://lore.kernel.org/linux-cve-announce/2025010653-CVE-2024-56758-eeb6@gregkh/

Introduced by commit e7f1326 ("btrfs: set page extent mapped after
read_folio in relocate_one_page") in v6.6-rc1.
Fixed in v6.13-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [3e74859ee35edc33a022c3f3971df066ea0ca6b9]

CVE-2024-56759: btrfs: fix use-after-free when COWing tree bock and
tracing is enabled

Announce: https://lore.kernel.org/linux-cve-announce/2025010653-CVE-2024-56759-e46e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc5.
It seems as if Linux 4.x kernels are affected too.

Fixed status
mainline: [44f52bbe96dfdbe4aca3818a2534520082a07040]

CVE-2024-56760: PCI/MSI: Handle lack of irqdomain gracefully

Announce: https://lore.kernel.org/linux-cve-announce/2025010654-CVE-2024-56760-af6e@gregkh/

Introduced by commit d2a463b ("PCI/MSI: Reject multi-MSI early") in v6.2-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a60b990798eb17433d0283788280422b1bd94b18]
stable/6.6: [b1f7476e07b93d65a1a3643dcb4a7bed80d4328d]

CVE-2024-56761: x86/fred: Clear WFE in missing-ENDBRANCH #CPs

Announce: https://lore.kernel.org/linux-cve-announce/2025010654-CVE-2024-56761-0be0@gregkh/

Introduced by commit a5f6c2a ("x86/shstk: Add user control-protection
fault handler") in v6.6-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc81e556f2a017d681251ace21bf06c126d5a192]

CVE-2024-56762: [REJECTED]: io_uring/sqpoll: fix sqpoll error handling races

Announce: https://lore.kernel.org/linux-cve-announce/2025010654-CVE-2024-56762-9a9f@gregkh/

This CVE was rejected. There is no mention of the commit that
introduced the bug in the CVE announcement.Fixed in v6.13-rc5.


Fixed status
mainline: [e33ac68e5e21ec1292490dfe061e75c0dbdd3bd4]
stable/6.1: [6237331361711810d8f2e3fbfe2f7a6f9548f5e0]
stable/6.6: [80120bb4eef7848d5aa3b1a0cd88367cd05fbe03]

CVE-2024-56763: tracing: Prevent bad count for tracing_cpumask_write

Announce: https://lore.kernel.org/linux-cve-announce/2025010655-CVE-2024-56763-17fd@gregkh/

Introduced by commit 9e01c1b ("cpumask: convert kernel trace
functions") in v2.6.29-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98feccbf32cfdde8c722bc4587aaa60ee5ac33f0]
stable/6.1: [3d15f4c2449558ffe83b4dba30614ef1cd6937c3]
stable/6.6: [03041e474a6a8f1bfd4b96b164bb3165c48fa1a3]

CVE-2024-56764: ublk: detach gendisk from ublk device if add_disk() fails

Announce: https://lore.kernel.org/linux-cve-announce/2025010655-CVE-2024-56764-347d@gregkh/

Introduced by commit bd23f6c ("ublk: quiesce request queue when
aborting queue") in v6.7-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75cd4005da5492129917a4a4ee45e81660556104]

CVE-2024-56765: powerpc/pseries/vas: Add close() callback in vas_vm_ops struct

Announce: https://lore.kernel.org/linux-cve-announce/2025010655-CVE-2024-56765-081f@gregkh/

Introduced by commit 37e6764 ("powerpc/pseries/vas: Add VAS migration
handler") in v5.18-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05aa156e156ef3168e7ab8a68721945196495c17]
stable/6.1: [8b2282b5084521254a2cd9742a3f4e1d5b77f843]
stable/6.6: [b7f60ffdfd96f8fc826f1d61a1c6067d828e20b9]

CVE-2024-56766: mtd: rawnand: fix double free in atmel_pmecc_create_user()

Announce: https://lore.kernel.org/linux-cve-announce/2025010656-CVE-2024-56766-80a2@gregkh/

Introduced by commit 6d734f1 ("mtd: rawnand: atmel: Fix possible
memory leak") in v6.13-rc1.
Fixed in v6.13-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [d8e4771f99c0400a1873235704b28bb803c83d17]
stable/6.1: [6ea15205d7e2b811fbbdf79783f686f58abfb4b7]
stable/6.6: [dd45c87782738715d5e7c167f8dabf0814a7394a]

CVE-2024-56767: dmaengine: at_xdmac: avoid null_prt_deref in
at_xdmac_prep_dma_memset

Announce: https://lore.kernel.org/linux-cve-announce/2025010656-CVE-2024-56767-420f@gregkh/

Introduced by commit b206d9a ("dmaengine: xdmac: Add memset support")
in v4.2-rc1.
Fixed in v6.13-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c43ec96e8d34399bd9dab2f2dc316b904892133f]
stable/6.1: [fdba6d5e455388377ec7e82a5913ddfcc7edd93b]
stable/6.6: [e658f1c133b854b2ae799147301d82dddb8f3162]

CVE-2024-56768: bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP

Announce: https://lore.kernel.org/linux-cve-announce/2025010657-CVE-2024-56768-c835@gregkh/

Introduced by commit 1ae6921 ("bpf: inline bpf_get_smp_processor_id()
helper") in v6.10-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23579010cf0a12476e96a5f1acdf78a9c5843657]

CVE-2024-56769: media: dvb-frontends: dib3000mb: fix uninit-value in
dib3000_write_reg

Announce: https://lore.kernel.org/linux-cve-announce/2025010657-CVE-2024-56769-021a@gregkh/

Introduced by commit 74340b0 ("V4L/DVB (4457): Remove
dib3000-common-module") in v2.6.20.16.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2dd59fe0e19e1ab955259978082b62e5751924c7]
stable/6.1: [3876e3a1c31a58a352c6bf5d2a90e3304445a637]
stable/6.6: [1d6de21f00293d819b5ca6dbe75ff1f3b6392140]

CVE-2024-56770: net/sched: netem: account for backlog updates from child qdisc

Announce: https://lore.kernel.org/linux-cve-announce/2025010803-CVE-2024-56770-62ce@gregkh/

Introduced by commit 5061253 ("netem: fix classful handling") in v3.3-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8d4bc455047cf3903cd6f85f49978987dbb3027]
stable/5.10: [216509dda290f6db92c816dd54b83c1df9da9e76]
stable/5.15: [c2047b0e216c8edce227d7c42f99ac2877dad0e4]
stable/5.4: [83c6ab12f08dcc09d4c5ac86fdb89736b28f1d31]
stable/6.1: [10df49cfca73dfbbdb6c4150d859f7e8926ae427]
stable/6.6: [3824c5fad18eeb7abe0c4fc966f29959552dca3e]

CVE-2024-56771: mtd: spinand: winbond: Fix 512GW, 01GW, 01JW and 02JW
ECC information

Announce: https://lore.kernel.org/linux-cve-announce/2025010808-CVE-2024-56771-3ace@gregkh/

Introduced by commit 6a804fb ("mtd: spinand: winbond: add support for
serial NAND flash") in v6.7-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fee9b240916df82a8b07aef0fdfe96785417a164]

CVE-2024-56772: kunit: string-stream: Fix a UAF bug in kunit_init_suite()

Announce: https://lore.kernel.org/linux-cve-announce/2025010810-CVE-2024-56772-a64d@gregkh/

Introduced by commit a3fdf78 ("kunit: string-stream: Decouple
string_stream from kunit") in v6.7-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39e21403c978862846fa68b7f6d06f9cca235194]

CVE-2024-56773: kunit: Fix potential null dereference in
kunit_device_driver_test()

Announce: https://lore.kernel.org/linux-cve-announce/2025010811-CVE-2024-56773-46a8@gregkh/

Introduced by commit d03c720 ("kunit: Add APIs for managing devices")
in v6.8-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [435c20eed572a95709b1536ff78832836b2f91b1]

CVE-2024-56774: btrfs: add a sanity check for btrfs root in btrfs_search_slot()

Announce: https://lore.kernel.org/linux-cve-announce/2025010811-CVE-2024-56774-e09f@gregkh/

Introduced by commit 42437a6 ("btrfs: introduce mount option
rescue=ignorebadroots") in v5.11-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ed51857a50f530ac7a1482e069dfbd1298558d4]
stable/5.15: [c71d114ef68c95da5a82ec85a721ab31f5bd905b]
stable/6.1: [db66fb87c21e8ae724886e6a464dcbac562a64c6]
stable/6.6: [757171d1369b3b47f36932d40a05a0715496dcab]

CVE-2024-56775: drm/amd/display: Fix handling of plane refcount

Announce: https://lore.kernel.org/linux-cve-announce/2025010811-CVE-2024-56775-b841@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It looks as if this bug was introduced by commit ad3b63a ("drm/amd/display:
add new windowed mpo odm minimal transition sequence") in 6.7-rc1.

Fixed status
mainline: [27227a234c1487cb7a684615f0749c455218833a]

CVE-2024-56776: drm/sti: avoid potential dereference of error pointers

Announce: https://lore.kernel.org/linux-cve-announce/2025010811-CVE-2024-56776-040d@gregkh/

Introduced by commit dd86dc2 ("drm/sti: implement atomic_check for the
planes") in v4.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [831214f77037de02afc287eae93ce97f218d8c04]
stable/5.15: [e98ff67f5a68114804607de549c2350d27628fc7]
stable/6.1: [40725c5fabee804fecce41d4d5c5bae80c45e1c4]
stable/6.6: [8ab73ac97c0fa528f66eeccd9bb53eb6eb7d20dc]

CVE-2024-56777: drm/sti: avoid potential dereference of error pointers
in sti_gdp_atomic_check

Announce: https://lore.kernel.org/linux-cve-announce/2025010812-CVE-2024-56777-a145@gregkh/

Introduced by commit dd86dc2 ("drm/sti: implement atomic_check for the
planes") in v4.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e965e771b069421c233d674c3c8cd8c7f7245f42]
stable/5.15: [f5804567cf9605d6e5ec46c0bb786f7d50f18c13]
stable/6.1: [b79612ed6bc1a184c45427105c851b5b2d4342ca]
stable/6.6: [997b64c3f4c1827c5cfda8ae7f5d13f78d28b541]

CVE-2024-56778: drm/sti: avoid potential dereference of error pointers
in sti_hqvdp_atomic_check

Announce: https://lore.kernel.org/linux-cve-announce/2025010812-CVE-2024-56778-45a9@gregkh/

Introduced by commit dd86dc2 ("drm/sti: implement atomic_check for the
planes") in v4.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1ab40a1fdfee732c7e6ff2fb8253760293e47e8]
stable/5.15: [31c857e7496d34e5a32a6f75bc024d0b06fd646a]
stable/6.1: [6b0d0d6e9d3c26697230bf7dc9e6b52bdb24086f]
stable/6.6: [82a5312f874fb18f045d9658e9bd290e3b0621c0]

CVE-2024-56779: nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur

Announce: https://lore.kernel.org/linux-cve-announce/2025010812-CVE-2024-56779-74f5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It seems as if 4.19 and 4.4 might be affected.

Fixed status
mainline: [98100e88dd8865999dc6379a3356cd799795fe7b]
stable/5.10: [2d505a801e57428057563762f67a5a62009b2600]
stable/5.15: [0ab0a3ad24e970e894abcac58f85c332d1726749]
stable/5.4: [a85364f0d30dee01c5d5b4afa55a9629a8f36d8e]
stable/6.1: [45abb68c941ebc9a35c6d3a7b08196712093c636]
stable/6.6: [37dfc81266d3a32294524bfadd3396614f8633ee]

CVE-2024-56780: quota: flush quota_release_work upon quota writeback

Announce: https://lore.kernel.org/linux-cve-announce/2025010813-CVE-2024-56780-6b91@gregkh/

Introduced by commit dabc8b2 ("quota: fix dqput() to follow the
guarantees dquot_srcu should provide") in v6.6-rc1.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
mainline: [ac6f420291b3fee1113f21d612fa88b628afab5b]
stable/5.10: [6f3821acd7c3143145999248087de5fb4b48cf26]
stable/5.15: [ab6cfcf8ed2c7496f55d020b65b1d8cd55d9a2cb]
stable/5.4: [a5abba5e0e586e258ded3e798fe5f69c66fec198]
stable/6.1: [3e6ff207cd5bd924ad94cd1a7c633bcdac0ba1cb]
stable/6.6: [bcacb52a985f1b6d280f698a470b873dfe52728a]

CVE-2024-56781: powerpc/prom_init: Fixup missing powermac #size-cells

Announce: https://lore.kernel.org/linux-cve-announce/2025010807-CVE-2024-56781-7b75@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [cf89c9434af122f28a3552e6f9cc5158c33ce50a]
stable/5.10: [a79a7e3c03ae2a07f68b5f24d5ed549f9799ec89]
stable/5.15: [ee68554d2c03e32077f7b984e5289fdb005036d2]
stable/5.4: [0b94d838018fb0a824e0cd3149034928c99fb1b7]
stable/6.1: [6d5f0453a2228607333bff0c85238a3cb495d194]
stable/6.6: [691284c2cd33ffaa0b35ce53b3286b90621e9dc9]

CVE-2024-56782: ACPI: x86: Add adev NULL check to
acpi_quirk_skip_serdev_enumeration()

Announce: https://lore.kernel.org/linux-cve-announce/2025010807-CVE-2024-56782-d049@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It looks as if this bug was introduced by commit 99b572e6 ("ACPI: x86: Add
DELL0501 handling to acpi_quirk_skip_serdev_enumeration()") in 6.9-rc1.

Fixed status
mainline: [4a49194f587a62d972b602e3e1a2c3cfe6567966]

CVE-2024-56783: netfilter: nft_socket: remove WARN_ON_ONCE on maximum
cgroup level

Announce: https://lore.kernel.org/linux-cve-announce/2025010807-CVE-2024-56783-4ed9@gregkh/

Introduced by commit 7f3287d ("netfilter: nft_socket: make cgroupsv2
matching work with namespaces") in v6.11.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [b7529880cb961d515642ce63f9d7570869bbbdc3]
stable/6.1: [7064a6daa4a700a298fe3aee11dea296bfe59fc4]
stable/6.6: [2f9bec0a749eb646b384fde0c7b7c24687b2ffae]

CVE-2024-56784: drm/amd/display: Adding array index check to prevent
memory corruption

Announce: https://lore.kernel.org/linux-cve-announce/2025010807-CVE-2024-56784-b2ba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It looks as if this bug was introduced by commit 0057b36a ("drm/amd/display:
Send message to notify the DPIA host router bandwidth") in 6.11-rc1.

Fixed status
mainline: [2c437d9a0b496168e1a1defd17b531f0a526dbe9]

CVE-2024-56785: MIPS: Loongson64: DTS: Really fix PCIe port nodes for ls7a

Announce: https://lore.kernel.org/linux-cve-announce/2025010808-CVE-2024-56785-5a66@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [4fbd66d8254cedfd1218393f39d83b6c07a01917]
stable/5.10: [5a2eaa3ad2b803c7ea442c6db7379466ee73c024]
stable/5.15: [a7fd78075031871bc68fc56fdaa6e7a3934064b1]
stable/6.1: [c8ee41fc3522c6659e324d90bc2ccd3b6310d7fc]
stable/6.6: [8ef9ea1503d0a129cc6f5cf48fb63633efa5d766]

CVE-2024-56786: bpf: put bpf_link's program when link is safe to be deallocated

Announce: https://lore.kernel.org/linux-cve-announce/2025010808-CVE-2024-56786-1f56@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
The vulnerable feature was added by commit 70ed506 ("bpf: Introduce pinnable
bpf_link abstraction") in 5.7-rc1.

Fixed status
mainline: [f44ec8733a8469143fde1984b5e6931b2e2f6f3f]
stable/6.6: [5fe23c57abadfd46a7a66e81f3536e4757252a0b]

CVE-2024-56787: soc: imx8m: Probe the SoC driver as platform driver

Announce: https://lore.kernel.org/linux-cve-announce/2025010808-CVE-2024-56787-bd0b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
Affected file was added by commit a7e26f3 ("soc: imx: Add generic
i.MX8 SoC driver")
in 5.2-rc1. imx8mq_soc_revision was added by commit a7e26f3 in
5.2-rc1. imx8mm_soc_uid was
added by commit 8dfe397 in 5.4-rc1. imx8mm_soc_revision was added by
commit 2b14b80 in 5.3-rc1.

Fixed status
mainline: [9cc832d37799dbea950c4c8a34721b02b8b5a8ff]
stable/5.15: [e497edb8f31ec2c2b6f4ce930e175aa2da8be334]
stable/6.1: [ea2ff66feb5f9b183f9e2f9d06c21340bd88de12]
stable/6.6: [2129f6faa5dfe8c6b87aad11720bf75edd77d3e4]

* Updated CVEs

CVE-2024-50121: nfsd: cancel nfsd_shrinker_work using sync mode in
nfs4_state_shutdown_net

stable/6.1 was fixed.

Fixed status
stable/6.1: [36775f42e039b01d4abe8998bf66771a37d3cdcc]
stable/6.11: [add1df5eba163a3a6ece11cb85890e2e410baaea]
stable/6.6: [f965dc0f099a54fca100acf6909abe52d0c85328]

CVE-2024-50146: net/mlx5e: Don't call cleanup on profile rollback failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [db84cb4c8c565e6d4de84b23c2818b63991adfdd]
stable/6.11: [3955b77494c3c7d14873b1db67e7e00c46a714db]

CVE-2024-53099: bpf: Check validity of link->type in bpf_link_show_fdinfo()

stable/6.1 was fixed.

Fixed status
stable/6.1: [4e8074bb33d18f56af30a0252cb3606d27eb1c13]
stable/6.11: [b3eb1b6a9f745d6941b345f0fae014dc8bb06d36]
stable/6.6: [d5092b0a1aaf35d77ebd8d33384d7930bec5cb5d]

CVE-2024-53128: sched/task_stack: fix object_is_on_stack() for KASAN
tagged pointers

stable/6.6 was fixed.

Fixed status
stable/6.11: [fbfe23012cec509dfbe09852019c4e4bb84999d0]
stable/6.6: [2d2b19ed4169c38dc6c61a186c5f7bdafc709691]

CVE-2024-56710: ceph: fix memory leak in ceph_direct_read_write()

stable/6.6 was fixed.

Fixed status
stable/6.12: [eb9041837123f31d5897e99bb761f46cb4ce5859]
stable/6.6: [44e518abbb498075ae85c7d1d1a503a6bb05ea2d]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

