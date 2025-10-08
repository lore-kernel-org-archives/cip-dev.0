Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC8CCA470
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 22:25:50 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.web11.4344.1759962342344677857
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Oct 2025 15:25:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=2ab5KAQt;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d603b60cbso3420277b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 08 Oct 2025 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1759962341; x=1760567141; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7GhBAxmZ4dHkpo/bC2FKDvPHlPQWDVCP88Bg+P9+wyg=;
        b=2ab5KAQtOfDuQCLAlWKgXAAm+dQyH9lrTbPDG0tJvPeKEw7wE/14U/EJPoGTdDxHz0
         fFYmjm9Yj4yEaupfIL4FPvPXMdJ+NAOhE3wjq40XEFbI0VjQpGQel7blhMzezekYNvoP
         xfz41Shb2TnpB2NzAh0gbhQpDJ2R4moNoZZKVoXbqZIoGtuVBAm/SToEBrz062Dn25lh
         GqPpbm+dl0GriAlGWnuLZ2IA6GTmZaTunm85Kea+yVRIYQ4CD+FLeZTL9r+CbWMyNnw6
         0peoQKW/dIv6rsSq29mGk1pFQwpOMHnF2hWtED1J0uWOfoDWcTOtUIi0jqp39amGlhsN
         vuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759962341; x=1760567141;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GhBAxmZ4dHkpo/bC2FKDvPHlPQWDVCP88Bg+P9+wyg=;
        b=QFwQMjdlWijnW6y/ho/61q1zhEIhvrva1vp59+jaWLOOnubeUO15YbOIUTrdpVHSv6
         VzZaOnV/gzwkt7BfkiDY6dLD4oClxVh6A20O1Bewp7+UZeSSlX1NFow6Mxh+5HI8hkGs
         sLejvOW3OB/4FmDzH36wsRLpjIcmsZkD9iuNwCUcOJ2MFznvD5nN/PuR/EEhsxfxKT5F
         xNEzYtZBbPYcTCpYVzpfHWw0r8+luPuJlEUWT4yfWlcLriMpj4s6vE7aWFWD/acYgiPj
         dBZ2K6RriuZCAUxbJ289AxcZI4oPaAc+NSywso/1nHQzu0eXM8yahp05qr3vzA9RUr+e
         He2g==
X-Gm-Message-State: AOJu0YyEtXwfU7MdQxhRQcC6vlX65FoIAZ0c30b9BTMLzPAbFuUup6Us
	XZWMUNnJfiX184gjvjqh8/DCNs6rkh29VsZDiQZZP/IezyKsX+B8MOdr9Par5kpSZcEiw+rf2or
	NtzJPdh8Z/XDEOdzVH7G0c16vZwAcGxAOas3om1AKVHpEOJR1Mh48khg=
X-Gm-Gg: ASbGncuEBO9RU3IxWnugEUAOUBJMqDZB7uogmaTd42rzSemK68bJLV+B0aFoDdJAdAI
	XbDrEG/eDNYq0h7/x0nfbUNZG8f6l0SFYCmk7E/y+RwiJ//OF1ip62cOnF91dTsRz67t3LWXTkc
	KF9y79907rbGzbqBDlBgKvV6uoZcFFh83KaWjkhweI6faGwmnRF+Jd/uSZnStGkB63lYQvGPFQb
	biCeosyZwVpj7DL3/6Snd3wKIg8WMBW
X-Google-Smtp-Source: AGHT+IFqPQYdCItqTWtg/F1cXvP6vrZgvK0D6iPY5eT6cB8NQD5MUzlmv5BjeZGh+D8xNFfkBlmlw7J58z0QT9bb66w=
X-Received: by 2002:a53:c590:0:b0:615:7d8f:66ed with SMTP id
 956f58d0204a3-63ccb886097mr4395036d50.17.1759962335507; Wed, 08 Oct 2025
 15:25:35 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Oct 2025 07:24:59 +0900
X-Gm-Features: AS18NWByHlnwHVJVxhpLzQh4hH6DRC_TyS4ur0rPgvn7QF97L6xZDlGvaciQNSg
Message-ID: <CAODzB9pDdTTaz39XAiTn3=zPdYXTB0iDb6Jm+64dxyHHRKSRQg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Oct 2025 22:25:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20162

Hi!

It's this week's CVE report.

This week reported 263 new CVEs and 13 updated CVEs.

* New CVEs
CVE-2022-50470: xhci: Remove device endpoints from bandwidth list when
freeing the device

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50470

Introduced commit is not determined.Fixed in v6.1-rc3.


Fixed status
cip/4.19-st: [cebbc8d335d6bcc1316584f779c08f80287c6af8]
cip/4.4-st: [78589c77c5a9310f4126619502595ad7146d1c0e]
mainline: [5aed5b7c2430ce318a8e62f752f181e66f0d1053]
stable/5.10: [678d2cc2041cc6ce05030852dce9ad42719abcfc]
stable/5.15: [c892a81c7424b4f6a660cb9c249d354ccf3afeca]
stable/5.4: [8f1cd9633d1f21efc13e8fc75be8f2b6bb85e38c]
stable/6.1: [5aed5b7c2430ce318a8e62f752f181e66f0d1053]

CVE-2022-50471: xen/gntdev: Accommodate VMA splitting

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50471

Introduced by commit ab31523 ("xen/gntdev: allow usermode to map
granted pages") in v2.6.38-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c13a4a0291b30191eff9ead8d010e1ca43a4d0c]
stable/5.10: [3c6a888e352283a14f37b9b433cd598a1a3a7dd0]
stable/5.15: [7c16d0a4e6a436b4e7c92bead3fab55aaa4c1141]
stable/6.1: [5c13a4a0291b30191eff9ead8d010e1ca43a4d0c]

CVE-2022-50472: IB/mad: Don't call to function that might sleep while
in atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50472

Introduced by commit 821bf1d ("IB/MAD: Add recv path trace point") in v5.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c20311d76cbaeb7ed2ecf9c8b8322f8fc4a7ae3]
stable/5.15: [47e31b86edff36f2d26cbc88ce695d98ff804178]
stable/6.1: [fa8a2f3be78e4585996bcf4c15e4504441a4c7a0]

CVE-2022-50473: cpufreq: Init completion before kobject_init_and_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50473

Introduced by commit 4ebe36c ("cpufreq: Fix kobject memleak") in v5.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c51054896bcce1d33d39fead2af73fec24f40b6]
stable/5.10: [e379b88a8f8cffc99b318e028705ed9e3da0e1e0]
stable/5.15: [8fb4c98f20dfca1237de2e3dfdbe78d156784fd3]
stable/5.4: [3cdd91a9163248935720927531066b74f57aa43b]
stable/6.1: [e7c0c943ed675b66d4bbb16c51c6a3bb58da047e]

CVE-2022-50474: macintosh: fix possible memory leak in macio_add_one_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50474

Introduced by commit 1fa5ae8 ("driver core: get rid of struct device's
bus_id string array") in v2.6.30-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [35858b87a943917fa30172aa4bf01ce7adbcb42c]
cip/4.4-st: [02085351781fdc8f0f44c66d7ee10d5c464ee330]
mainline: [5ca86eae55a2f006e6c1edd2029b2cacb6979515]
stable/5.10: [2ac0a7059b7bcbed35bfffa34a82c9a9e99638ef]
stable/5.15: [19ded60b40e86b0903c8d5bd0161437ed5107a8b]
stable/5.4: [b29a2f1dd33ae9b94821ab2f4d398b9081786748]
stable/6.1: [76837e7f6b30da72ad59f56291e22804a219e015]

CVE-2022-50475: RDMA/core: Make sure "ib_port" is valid when access sysfs node

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50475

Introduced by commit d8a5883 ("RDMA/core: Replace the ib_port_data
hw_stats pointers with a ib_port pointer") in v5.14-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e15ff29b156bbbdeadae230c8ecd5ecd8ca2477]
stable/5.15: [f981c697b2f9bd5dd2f060e47ff8b5e0a2cd0c06]
stable/6.1: [cd06d32a71fbb198b2d43dddf794badd80ffd25d]

CVE-2022-50476: ntb_netdev: Use dev_kfree_skb_any() in interrupt context

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50476

Introduced by commit 765ccc7 ("ntb_netdev: correct skb leak") in v3.9-rc1.
Introduced by commit 548c237 ("net: Add support for NTB virtual
ethernet device") in v3.9-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8b78493968ed3cef0326183ed059c55e42f24d5b]
cip/4.4-st: [58663857fe9b3de5b769f352e648e046b7c875dd]
mainline: [5f7d78b2b12a9d561f48fa00bab29b40f4616dad]
stable/5.10: [13286ad1c7c49c606fdcba4cf66f953a1a16c1ca]
stable/5.15: [21296a52caa6a6bad6debdfe40ad81d4f1a27e69]
stable/5.4: [a6b9e09403102bdf8402dae734800e4916c7ea58]
stable/6.1: [07e28a8f450217db679802ebd4de0915556ce846]

CVE-2022-50477: rtc: class: Fix potential memleak in devm_rtc_allocate_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50477

Introduced by commit 24d2318 ("rtc: class: check return value when
calling dev_set_name()") in v5.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60da73808298ff2cfa9f165d55eb3d7aa7078601]
stable/6.1: [59457a0f079eae19aaf322b3cc1c8ba66f55c5f3]

CVE-2022-50478: nilfs2: fix shift-out-of-bounds/overflow in
nilfs_sb2_bad_offset()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50478

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [9b3ba54025357440d6c4414c670984f628c6f6bf]
cip/4.4-st: [ed9bc7216eb9805916e1224d2af32c9869c4f4ed]
mainline: [610a2a3d7d8be3537458a378ec69396a76c385b6]
stable/5.10: [d464b035c0613856d012cf1704879d3ff3f057fb]
stable/5.15: [b47f5c579c8186f7f5ab5e4254e0734ea5b7bf7a]
stable/5.4: [d706485dffbbbf848e681edda29c7a46ac55698c]
stable/6.1: [62d11ec205ef14d8acf172cfc9904fdbf200025a]

CVE-2022-50479: drm/amd: fix potential memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50479

Introduced commit is not determined.Fixed in v6.1-rc1.
Affectest code was added by 3cffeff ("drm/amd/display: Add DCN314 DC
resources") in 6.0-rc1.

Fixed status
mainline: [6160216fd2c97107e8a9ab39863b056d677fcd85]
stable/6.1: [6160216fd2c97107e8a9ab39863b056d677fcd85]

CVE-2022-50480: memory: pl353-smc: Fix refcount leak bug in pl353_smc_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50480

Introduced by commit fee10bd ("memory: pl353: Add driver for arm pl353
static memory controller") in v5.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61b3c876c1cbdb1efd1f52a1f348580e6e14efb6]
stable/5.10: [fde46754d5483bc398018bbec3c8ef5c55219e67]
stable/5.15: [566b143aa5112a0c2784e20603778518bb799537]
stable/5.4: [b37f4a711e5d4bf3608ccbc6de82b52e92b441a0]
stable/6.1: [61b3c876c1cbdb1efd1f52a1f348580e6e14efb6]

CVE-2022-50481: cxl: fix possible null-ptr-deref in cxl_guest_init_afu|adapter()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50481

Introduced by commit 14baf4d ("cxl: Add guest-specific code") in v4.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d775a1da5a52b4f4bb02f2707ba420d1bec48dbb]
mainline: [61c80d1c3833e196256fb060382db94f24d3d9a7]
stable/5.10: [170e8c2d2b61e15e7f7cfeded81bc1e959a15ed8]
stable/5.15: [e5021bbf11b024cc65ea1e84c377df484183be4b]
stable/5.4: [60b2ed21a65f3f5318666ccd765c3507991370cf]
stable/6.1: [ab44c182353be101c3be9465e1d15d42130c53c4]

CVE-2022-50482: iommu/vt-d: Clean up si_domain in the init_dmars() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50482

Introduced by commit 86080cc ("iommu/vt-d: Allocate si_domain in
init_dmars()") in v4.2-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5cecfe151874b835331efe086bbdcaeaf64f6b90]
mainline: [620bf9f981365c18cc2766c53d92bf8131c63f32]
stable/5.10: [d74196bb278b8f8af88e16bd595997dfa3d6fdb0]
stable/5.15: [0365d6af75f9f2696e94a0fef24a2c8464c037c8]
stable/5.4: [724483b585a1b1e063d42ac5aa835707ff2ec165]
stable/6.1: [620bf9f981365c18cc2766c53d92bf8131c63f32]

CVE-2022-50483: net: enetc: avoid buffer leaks on xdp_do_redirect() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50483

Introduced by commit 9d2b68c ("net: enetc: add support for
XDP_REDIRECT") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [628050ec952d2e2e46ec9fb6aa07e41139e030c8]
stable/5.15: [bcf2c1dc5358dcf7e34a68cdb6b0bbf967801efa]
stable/6.1: [306526331e7a37e714e11ab7c6d73eb004745224]

CVE-2022-50484: ALSA: usb-audio: Fix potential memory leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50484

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [46f0aed47673e275d682af60ed26dcc28add8eae]
cip/4.4-st: [e5f586d3d09da525c049dbb6a72683183bd3f1b6]
mainline: [6382da0828995af87aa8b8bef28cc61aceb4aff3]
stable/5.10: [bc1d16d282bca421c6fc31de4b8fd412010f01bd]
stable/5.15: [0672215994e2347a9b4f145e2bc1709b1e01cee3]
stable/5.4: [988ec0cd0a2643c25c1658f7c33de2e15a5a2e31]
stable/6.1: [6382da0828995af87aa8b8bef28cc61aceb4aff3]

CVE-2022-50485: ext4: add EXT4_IGET_BAD flag to prevent unexpected bad inode

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50485

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [63b1e9bccb71fe7d7e3ddc9877dbdc85e5d2d023]
stable/5.10: [c0a738875c2e9c8c3366d792f8bf7fe508d5e5a5]
stable/5.15: [f7e6b5548f915d7aa435d0764d41eacfb49c6e09]
stable/5.4: [2142dfa1de61e25b83198af0308ec7689cca25d3]
stable/6.1: [488a5c2bf7543c3cd3f07a025f2e62be91599430]

CVE-2022-50486: net: ethernet: ti: Fix return type of netcp_ndo_start_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50486

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [d837d74eae077cc3ef9e191ba8535b5f602d4673]
cip/4.4-st: [ca99df55b3e5227da06f325b99e6f5bbb6a49a9d]
mainline: [63fe6ff674a96cfcfc0fa8df1051a27aa31c70b4]
stable/5.10: [5b0b6553bf4ad3a435a57e02c68d6075f384e1be]
stable/5.15: [a413ebb6049edd881c6427cfa25a7efddd6a4f74]
stable/5.4: [dbe1a6b930ae9647e8ce0b684c903ac67d4398eb]
stable/6.1: [1e4953b826e12b31995564a459dbd4e9e4604a35]

CVE-2022-50487: NFSD: Protect against send buffer overflow in NFSv3 READDIR

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50487

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [640f87c190e0d1b2a0fcb2ecf6d2cd53b1c41991]
stable/5.10: [57774b1526163766403167b7bf00b136fb103761]
stable/5.15: [071a076fd1b763aa6fe478efa047e0a549ba9c22]
stable/6.1: [640f87c190e0d1b2a0fcb2ecf6d2cd53b1c41991]

CVE-2022-50488: block, bfq: fix possible uaf for 'bfqq->bic'

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50488

Introduced by commit 3bc5e68 ("bfq: Split shared queues on move
between cgroups") in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [64dc8c732f5c2b406cc752e6aaa1bd5471159cab]
stable/5.10: [5533742c7cb1bc9b1f0bf401cc397d44a3a9e07a]
stable/5.15: [094f3d9314d67691cb21ba091c1b528f6e3c4893]
stable/6.1: [761564d93c8265f65543acf0a576b32d66bfa26a]

CVE-2022-50489: drm/mipi-dsi: Detach devices when removing the host

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50489

Introduced by commit 068a002 ("drm: Add MIPI DSI bus support") in v3.14-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [95ae458209f5a556bba98aff872f933694914eb7]
cip/4.4-st: [c9f99e1fe227237d68c30447cc882facc597bbcc]
mainline: [668a8f17b5290d04ef7343636a5588a0692731a1]
stable/5.10: [45120fa5e522d444e3fc1c5a9afc5d53eed91d00]
stable/5.15: [26c1b4cfe56f040f71a51c92da1f4cac2e3b9455]
stable/5.4: [8242167cfc83dd7e4c96f44b45f108db9bb88146]
stable/6.1: [668a8f17b5290d04ef7343636a5588a0692731a1]

CVE-2022-50490: bpf: Propagate error from htab_lock_bucket() to userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50490

Introduced by commit 20b6cc3 ("bpf: Avoid hashtab deadlock with
map_locked") in v5.11-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66a7a92e4d0d091e79148a4c6ec15d1da65f4280]
stable/5.15: [0e13425104903970a5ede853082d3bbb4edec6f3]
stable/6.1: [66a7a92e4d0d091e79148a4c6ec15d1da65f4280]

CVE-2022-50491: coresight: cti: Fix hang in cti_disable_hw()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50491

Introduced by commit 835d722 ("coresight: cti: Initial CoreSight CTI
Driver") in v5.7-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6746eae4bbaddcc16b40efb33dab79210828b3ce]
stable/5.10: [e33ce54cef5d429430e3b1ae5c8ee4f4103c4fdc]
stable/5.15: [4c365a0c21aaf2b8fcc88de8dc298803288f61ac]
stable/6.1: [6746eae4bbaddcc16b40efb33dab79210828b3ce]

CVE-2022-50492: drm/msm: fix use-after-free on probe deferral

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50492

Introduced by commit d28ea55 ("drm/msm: properly add and remove
internal bridges") in v5.19-rc1.
Introduced by commit a3376e3 ("drm/msm: convert to drm_bridge") in v3.12-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6808abdb33bf90330e70a687d29f038507e06ebb]
stable/6.1: [6808abdb33bf90330e70a687d29f038507e06ebb]

CVE-2022-50493: scsi: qla2xxx: Fix crash when I/O abort times out

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50493

Introduced by commit 71c80b7 ("scsi: qla2xxx: Do command completion on
abort timeout") in v5.5-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [68ad83188d782b2ecef2e41ac245d27e0710fe8e]
stable/5.15: [d3871af13aa03fbbe7fbb812eaf140501229a72e]
stable/6.1: [05382ed9142cf8a8a3fb662224477eecc415778b]

CVE-2022-50494: thermal: intel_powerclamp: Use get_cpu() instead of
smp_processor_id() to avoid crash

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50494

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [6904727db0eb62fb0c2dce1cf331c341d97ee4b7]
cip/4.4-st: [518c0f14a2f7972c7d629002f6b0241329bcaed9]
mainline: [68b99e94a4a2db6ba9b31fe0485e057b9354a640]
stable/5.10: [513943bf879d45005213e6f5cfb7d9e9943f589f]
stable/5.15: [5614908434451aafbf9b24cb5247cf1d21269f76]
stable/5.4: [5a646c38f648185ee2c62f2a19da3c6f04e27612]
stable/6.1: [68b99e94a4a2db6ba9b31fe0485e057b9354a640]

CVE-2022-50495: [REJECTED]: x86/xen: Fix memory leak in xen_smp_intr_init{_pv}()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50495

This CVE was rejected. Introduced by commit 9702785 ("i386: move xen")
in v2.6.24-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9209d2cbf5845b8bf8e722015d86f65a9d2bc76a]
mainline: [69143f60868b3939ddc89289b29db593b647295e]
stable/5.10: [fc134c355b5299495b14a54dd9bb7af8a646cb7c]
stable/5.15: [23aef94eea714b721546c0c49a324a8da8d00fb5]
stable/5.4: [ec88254208dd01fa1646e939047d382b216340ac]
stable/6.1: [f698f88f042c6a19bbbac6c84782039a75e7f349]

CVE-2022-50496: dm cache: Fix UAF in destroy()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50496

Introduced by commit c6b4fcb ("dm: add cache target") in v3.9-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4d20032dd90664de09f2902a7ea49ae2f7771746]
cip/4.4-st: [8bb72075d77225f28cdcab1c28bbf3d3c567c6aa]
mainline: [6a459d8edbdbe7b24db42a5a9f21e6aa9e00c2aa]
stable/5.10: [2b17026685a270b2beaf1cdd9857fcedd3505c7e]
stable/5.15: [d2a0b298ebf83ab6236f66788a3541e91ce75a70]
stable/5.4: [2f097dfac7579fd84ff98eb1d3acd41d53a485f3]
stable/6.1: [6a3e412c2ab131c54945327a7676b006f000a209]

CVE-2022-50497: binfmt_misc: fix shift-out-of-bounds in check_special_flags

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50497

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [97382a2639b1cd9631f6069061e9d7062cd2b098]
cip/4.4-st: [179ec0887f4e25f3779e0e6510487474bf055986]
mainline: [6a46bf558803dd2b959ca7435a5c143efe837217]
stable/5.10: [dcbc51d31d0afbd45e830e3cf565a7b3ca7bf0d8]
stable/5.15: [88cea1676a09f7c45a1438153a126610c33b1590]
stable/5.4: [419b808504c26b3e3342365f34ccd0843e09a7f8]
stable/6.1: [a91123d4bda463469f68f0427adabf8108001f94]

CVE-2022-50498: eth: alx: take rtnl_lock on resume

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50498

Introduced by commit 4a5fe57 ("alx: use fine-grained locking instead
of RTNL") in v5.14-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ad1c94e1e7e374d88f0cfd77936dddb8339aaba]
stable/5.15: [6f1991a940b90753b34570f093a21dba366e8cc0]
stable/6.1: [6ad1c94e1e7e374d88f0cfd77936dddb8339aaba]

CVE-2022-50499: media: dvb-core: Fix double free in dvb_register_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50499

Introduced by commit fcd5ce4 ("media: dvb-core: fix a memory leak
bug") in v5.4-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [70bc51303871159796b55ba1a8f16637b46c2511]
cip/4.4-st: [ae54d4476406538bad9d93fd15d91635e431da5c]
mainline: [6b0d0477fce747d4137aa65856318b55fba72198]
stable/5.10: [7dd5a68cdbbbe7fc67ba701cb52ba10d8ba149f8]
stable/5.15: [acf984a3718c2458eb9e08b6714490a04f213c58]
stable/5.4: [b21f62b49ee9c3e0216d685d9cfd6003e5727271]
stable/6.1: [123eddf92a114e03919942641d2c2b1f4ca56ea6]

CVE-2022-50500: netdevsim: fix memory leak in nsim_drv_probe() when
nsim_dev_resources_register() failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50500

Introduced by commit 37923ed ("netdevsim: Add simple FIB resource
controller via devlink") in v4.17-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b1da9f7126f05e857da6db24c6a04aa7974d644]
stable/6.1: [6b1da9f7126f05e857da6db24c6a04aa7974d644]

CVE-2022-50501: media: coda: Add check for dcoda_iram_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50501

Introduced by commit b313bcc ("[media] coda: simplify IRAM setup") in v3.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [45f57abaee136a1e39d2b04443a1bd5311ba7d94]
cip/4.4-st: [24eeb166de7ec9829eb4dbed18d9fb5e457aa2e0]
mainline: [6b8082238fb8bb20f67e46388123e67a5bbc558d]
stable/5.10: [35ddd00b36589cf948875b825eedaab1aefd5ad5]
stable/5.15: [b99872178e7473f21904fdeea38109275aad8ae8]
stable/5.4: [2b436f1410245412ea5e4c356a175a928d73eed3]
stable/6.1: [05f165ded4a7baec31b65aba88e2cd1fb9b91db2]

CVE-2022-50503: mtd: lpddr2_nvm: Fix possible null-ptr-deref

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50503

Introduced by commit 96ba9dd ("mtd: lpddr: add driver for LPDDR2-NVM
PCM memories") in v3.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e6aafb57d90ff2c1e18554f3a3c36247a59825ce]
cip/4.4-st: [19807f2c69eadb4933ea17a23644b0576c32f7e0]
mainline: [6bdd45d795adf9e73b38ced5e7f750cd199499ff]
stable/5.10: [0919982a1744346269320615615c7deb14106661]
stable/5.15: [e0d3e46ac6669cdf1b99bc7b7d92f1221b9a1ff2]
stable/5.4: [8eb64dc5a790a529ef49ec94b3337af09dac15d3]
stable/6.1: [c4cc41e94d8357f5f02b8ef40257bb23931d8438]

CVE-2022-50504: powerpc/rtas: avoid scheduling in rtas_os_term()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50504

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [ffa991a003abb4f8cb9e5004646bfe2d9a46912c]
cip/4.4-st: [17e7aecddd7bac19e4f942057d4d02b375c8e20c]
mainline: [6c606e57eecc37d6b36d732b1ff7e55b7dc32dd4]
stable/5.10: [6f7e2fcab73372a371ab4017cbedf7a71f4f9b40]
stable/5.15: [7280fdb80bf0fe35d9b799fc7009f2cbe0a397d7]
stable/5.4: [515959eb49e6d218a46979d66f36fdef329ac7d2]
stable/6.1: [482d990a5dd1027ee0b70a8a570d56749cac8103]

CVE-2022-50505: iommu/amd: Fix pci device refcount leak in ppr_notifier()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50505

Introduced by commit daae2d2 ("iommu/amd: Don't copy GCR3 table root
pointer") in v4.14-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [efd50c65fd1cdef63eb58825f3fe72496443764c]
mainline: [6cf0981c2233f97d56938d9d61845383d6eb227c]
stable/5.10: [03f51c72997559e73b327608f0cccfded715c9a0]
stable/5.15: [6e501b3fd7a2e1c4372d72bc70717aaca2beb8a5]
stable/5.4: [8581ec1feb895ff596fe3d326d9ba320083290aa]
stable/6.1: [b0637f4bd426925f5c3a15e8f8e36190fe06bac5]

CVE-2022-50506: drbd: only clone bio if we have a backing device

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50506

Introduced by commit c347a78 ("drbd: set ->bi_bdev in drbd_req_new")
in v5.18-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d42ddf7f27b6723549ee6d4c8b1b418b59bf6b5]
stable/6.1: [6d42ddf7f27b6723549ee6d4c8b1b418b59bf6b5]

CVE-2022-50507: fs/ntfs3: Validate data run offset

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50507

Introduced commit is not determined.Fixed in v6.2-rc1.
ntfs3 was introduced in 5.15.

Fixed status
mainline: [6db620863f8528ed9a9aa5ad323b26554a17881d]
stable/5.15: [de5e0955248ff90a2ae91e7f5c108392b52152d0]
stable/6.1: [9173b89c16a603d73c434b695fe2a7a13491300f]

CVE-2022-50508: wifi: mt76: mt76x0: fix oob access in
mt76x0_phy_get_target_power

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50508

Introduced by commit ba45841 ("wifi: mt76: mt76x02: simplify struct
mt76x02_rate_power") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e1abc51c945663bddebfa1beb9590ff5b250eb7]

CVE-2023-53533: Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53533

Introduced by commit 0b9f28f ("Input: add official Raspberry Pi's
touchscreen driver") in v5.0-rc1.
Introduced by commit 3b8ddff ("input: raspberrypi-ts: Release firmware
handle when not needed") in v5.13-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [5bca3688bdbc3b58a2894b8671a8e2378efe28bd]
stable/5.10: [0d6a5c9489c8a3d434e685066119c4333476dccd]
stable/5.15: [7acad58049acc6ac148e8b613a6eceeca4bcb4a7]
stable/5.4: [1dfa3c9dd27bdc347733d06e980395768520bc3e]
stable/6.1: [36d087e49dabd28d2c13a7532dac72d625ce69fb]

CVE-2023-53534: drm/mediatek: mtk_drm_crtc: Add checks for devm_kcalloc

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53534

Introduced by commit 31c5558 ("drm/mediatek: Refactor plane init") in v5.5-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bf1e3bd7da625ccf9a22c8cb7d65271e6e47f4c]
stable/5.10: [b64b6dff15a38468b8cd33fc7864fa4e02b0933a]
stable/5.15: [62952905e195f7350bc230cf0960a74ddbceed5d]
stable/6.1: [67ea657c7891c2f86a7750395640d9bdf2555926]

CVE-2023-53535: net: bcmgenet: Add a check for oversized packets

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53535

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [c34b1c0870323649d45c5074828d7f754dea2673]
cip/4.4-st: [ed230482ad9697f18209f3c3033bf726ab3ed1a7]
mainline: [5c0862c2c962052ed5055220a00ac1cefb92fbcd]
stable/5.10: [841881320562cbeac7046b537b91cd000480cea2]
stable/5.15: [124ca24e0de958d2e20e0aa1e2434af7b72f8887]
stable/5.4: [87363d1ab55e497702a9506ff423c422639c8a25]
stable/6.1: [5f56767fb5f2df875b6553e08dbec6a45431c988]

CVE-2023-53536: blk-crypto: make blk_crypto_evict_key() more robust

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53536

Introduced by commit 1b26283 ("block: Keyslot Manager for Inline
Encryption") in v5.8-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c7cb94452901a93e90c2230632e2c12a681bc92]
stable/5.10: [701a8220762ff90615dc91d3543f789391b63298]
stable/5.15: [5bb4005fb667c6e2188fa87950f8d5faf2994410]
stable/6.1: [64ef787bb1588475163069c2e62fdd8f6c27b1f6]

CVE-2023-53537: f2fs: fix to avoid use-after-free for cached IPU bio

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53537

Introduced by commit 0b20fce ("f2fs: cache global IPU bio") in v5.5-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cdb422c839134273866208dad5360835ddb9794]
stable/5.10: [b2f423fda64fb49213aa0ed5056079cf295a5df2]
stable/5.15: [9a7f63283af6befc0f91d549f4f6917dff7479a9]
stable/6.1: [7d058f0ab161437369ad6e45a4b67c2886e71373]

CVE-2023-53538: btrfs: insert tree mod log move in push_node_left

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53538

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [5cead5422a0e3d13b0bcee986c0f5c4ebb94100b]

CVE-2023-53539: RDMA/rxe: Fix incomplete state save in rxe_requester

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53539

Introduced by commit 3050b99 ("IB/rxe: Fix race condition between
requester and completer") in v4.8-rc7.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d122db2ff80cd2aed4dcd630befb56b51ddf947]
stable/6.1: [70518f3aaf5a059b691867d7d2d46b999319656a]
stable/6.6: [5d122db2ff80cd2aed4dcd630befb56b51ddf947]

CVE-2023-53540: wifi: cfg80211: reject auth/assoc to AP with our address

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53540

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [5d4e04bf3a0f098bd9033de3a5291810fa14c7a6]
stable/6.1: [676a423410131d111a264d29aecbe6aadd57fb22]
stable/6.6: [5d4e04bf3a0f098bd9033de3a5291810fa14c7a6]

CVE-2023-53541: mtd: rawnand: brcmnand: Fix potential out-of-bounds
access in oob write

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53541

Introduced by commit 27c5b17 ("mtd: nand: add NAND driver "library"
for Broadcom STB NAND controller") in v4.2-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [14b1d00520b4d6a4818364334ce472b79cfc8976]
cip/4.4-st: [4840dda7d48ff2bd73075befe15134f79e21cb5f]
mainline: [5d53244186c9ac58cb88d76a0958ca55b83a15cd]
stable/5.10: [d00b031266514a9395124704630b056a5185ec17]
stable/5.15: [2353b7bb61e45e7cfd21505d0c6747ac8c9496a1]
stable/5.4: [aae45746f4aee9818296e0500e0703e9d8caa5b8]
stable/6.1: [45fe4ad7f439799ee1b7b5f80bf82e8b34a98d25]
stable/6.6: [5d53244186c9ac58cb88d76a0958ca55b83a15cd]

CVE-2023-53542: ARM: dts: exynos: Use Exynos5420 compatible for the
MIPI video phy

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53542

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [537bdfc1a67836fbd68bbe4210bc380f72cca47f]
mainline: [5d5aa219a790d61cad2c38e1aa32058f16ad2f0b]
stable/5.10: [199624f3144d79fab1cff533ce6a4b82390520a3]
stable/5.15: [2e68a0f7bc576318a58335c31c542b358bc63f83]
stable/5.4: [f10001af0f7246cf3e43530d25f8d59a8db10df6]
stable/6.1: [f2a6198f5ed7d6e4e06d87a4de007f2e45cc9583]

CVE-2023-53543: vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53543

Introduced by commit ad69dd0 ("vdpa: Introduce query of device config
layout") in v5.16-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d6ba607d6cb5c58a4ddf33381e18c83dbb4098f]
stable/6.1: [ff71709445ac033e6e250d971683110e4781c068]

CVE-2023-53544: cpufreq: davinci: Fix clk use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53544

Introduced by commit 6601b80 ("davinci: add generic CPUFreq driver for
DaVinci") in v2.6.33-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4-st: [99563e8cf95c27e8a8967147fc6956db43ff4a57]
mainline: [5d8f384a9b4fc50f6a18405f1c08e5a87a77b5b3]
stable/6.1: [a5f024d0e6f91e05c816ad4ee8837173369dd5cb]

CVE-2023-53545: drm/amdgpu: unmap and remove csa_va properly

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53545

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [5daff15cd013422bc6d1efcfe82b586800025384]

CVE-2023-53546: net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53546

Introduced by commit 1d91864 ("net/mlx5: DR, Add direct rule command
utilities") in v5.4-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5dd77585dd9d0e03dd1bceb95f0269a7eaf6b936]
stable/5.10: [165159854757dbae0dfd1812b27051da35aa6223]
stable/5.15: [00cecb0a8f9e7a21754d5ad85813ab6b47b3308f]
stable/5.4: [800d8c96bf997da5eb76ccf8d88795c4231c83fb]
stable/6.1: [3169c3854397f3070a63b1b772db16dcb8cba7b4]

CVE-2023-53547: drm/amdgpu: Fix sdma v4 sw fini error

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53547

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected file is introduced in 4.12-rc1.

Fixed status
mainline: [5e08e9c742a00384e5abe74bd40cf4dc15cb3a2e]
stable/6.1: [210ef6cd8e634f18fd889421012192b81325b27b]

CVE-2023-53548: net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53548

Introduced commit is not determined.Fixed in v6.5-rc3.


Fixed status
cip/4.19-st: [53c250ea57cf03af41339234b9855ae284f9db91]
cip/4.4-st: [991f263c6951658c66f9489d97d90aa2ec1e0fe1]
mainline: [5e1627cb43ddf1b24b92eb26f8d958a3f5676ccb]
stable/5.10: [ec0d0be41721aca683c5606354a58ee2c687e3f8]
stable/5.15: [27d0f755d649d388fcd12f01436c9a33289e14e3]
stable/5.4: [a05ac5d00eb7fcb2fda806caa4f56e88df6bc6bb]
stable/6.1: [1bebbd9b8037a9cc75984317cb495dec4824c399]

CVE-2023-53549: netfilter: ipset: Rework long task execution when
adding/deleting entries

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53549

Introduced by commit 5f7b51b ("netfilter: ipset: Limit the maximal
range of consecutive elements to add/delete") in v5.14-rc6.
Fixed in v6.2-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [5e29dc36bd5e2166b834ceb19990d9e68a734d7d]
stable/5.10: [ee756980e491c829ba0495bb420b7224a9ee26b2]
stable/5.15: [a1e1521b463968b4eca7163f61fb6cc54d008061]
stable/6.1: [8964cc36ba011dc0e1041131fa2e91fb4c2a811b]

CVE-2023-53550: cpufreq: amd-pstate: fix global sysfs attribute type

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53550

Introduced by commit 3666062 ("cpufreq: amd-pstate: move to use
bus_get_dev_root()") in v6.4-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e720f8c8c9d959283c3908bbf32a91a01a86547]

CVE-2023-53551: usb: gadget: u_serial: Add null pointer check in gserial_resume

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53551

Introduced by commit aba3a8d ("usb: gadget: u_serial: add suspend
resume callbacks") in v5.8-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ec63fdbca604568890c577753c6f66c5b3ef0b5]
stable/5.10: [c5360eec648bd506afa304ae4a71f82e13d41897]
stable/5.15: [3b24c980dc07be4550a9d1450ed7057f882530e5]
stable/6.1: [ec357cd3e8af614855d286dd378725cdc7264df6]

CVE-2023-53552: drm/i915: mark requests for GuC virtual engines to
avoid use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53552

Introduced by commit bcb9aa4 ("Revert "drm/i915: Hold reference to
intel_context over life of i915_request"") in v6.0-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eefc5307c983b59344a4cb89009819f580c84fa]
stable/6.1: [8017a27cec32eac8c8f9430b0a3055840136b856]
stable/6.6: [5eefc5307c983b59344a4cb89009819f580c84fa]

CVE-2023-53553: HID: hyperv: avoid struct memcpy overrun warning

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53553

Introduced by commit 542f25a ("HID: hyperv: Replace one-element array
with flexible-array member") in v6.2-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f151364b1da6bd217632fd4ee8cc24eaf66a497]

CVE-2023-53554: staging: ks7010: potential buffer overflow in
ks_wlan_set_encode_ext()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53554

Introduced by commit b121d84 ("staging: ks7010: simplify calls to
memcpy()") in v4.12-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [663fff29fd613e2b0d30c4138157312ba93c4939]
mainline: [5f1c7031e044cb2fba82836d55cc235e2ad619dc]
stable/5.10: [caac4b6c15b66feae4d83f602e1e46f124540202]
stable/5.15: [baf420e30364ef9efe3e29a5c0e01e612aebf3fe]
stable/5.4: [5373a1aa91b2298f9305794b8270cf9896be96b6]
stable/6.1: [7ae9f55a495077f838bab466411ee6f38574df9b]

CVE-2023-53555: mm/damon/core: initialize damo_filter->list from
damos_new_filter()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53555

Introduced by commit 98def23 ("mm/damon/core: implement damos filter")
in v6.3-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f1fc67f2cb8d3035d3acd273b48b97835af8afd]

CVE-2023-53556: iavf: Fix use-after-free in free_netdev

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53556

Introduced by commit 5eae00c ("i40evf: main driver core") in v3.14-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f4fa1672d98fe99d2297b03add35346f1685d6b]
stable/5.10: [a4635f190f332304db4a49e827ece790b804b5db]
stable/5.15: [345c44e18cc10cded85cb9134830e1684495c866]
stable/5.4: [17046107ca15d7571551539d94e76aba2bf71fd3]
stable/6.1: [ca12b98e04b5d1902ac08fe826d3500cb4b6e891]

CVE-2023-53557: fprobe: Release rethook after the ftrace_ops is unregistered

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53557

Introduced by commit 5b0ab78 ("fprobe: Add exit_handler support") in v5.18-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f81018753dfd4989e33ece1f0cb6b8aae498b82]
stable/6.1: [ce3ec57faff559ccae1e0150c1f077eb2df648a4]

CVE-2023-53558: rcu-tasks: Avoid pr_info() with spin lock in
cblist_init_generic()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53558

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected code was added by ab97152 ("rcu-tasks: Use more callback
queues if contention encountered") in 5.17-rc1.

Fixed status
mainline: [5fc8cbe4cf0fd34ded8045c385790c3bf04f6785]
stable/6.1: [9027d69221ff96e1356f070f7feb2ff989ae7388]

CVE-2023-53559: ip_vti: fix potential slab-use-after-free in decode_session6

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53559

Introduced by commit f855691 ("xfrm6: Fix the nexthdr offset in
_decode_session6.") in v3.19-rc7.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7dfe23659f3677c08a60a0056cda2d91a79c15ca]
cip/4.4-st: [340c57d268b43ec4215b8573242cc0959599879c]
mainline: [6018a266279b1a75143c7c0804dd08a5fc4c3e0b]
stable/5.10: [0b4d69539fdea138af2befe08893850c89248068]
stable/5.15: [e1e04cc2ef2c0c0866c19f5627149a76c2baae32]
stable/5.4: [d34c30442d5e53a33cde79ca163320dbe2432cbd]
stable/6.1: [2b05bf5dc437f7891dd409a3eaf5058459391c7a]

CVE-2023-53560: tracing/histograms: Add histograms to hist_vars if
they have referenced variables

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53560

Introduced by commit 067fe03 ("tracing: Add variable reference
handling to hist triggers") in v4.17-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4ffad1528e81c91769d9da1f8436080861c8ec67]
mainline: [6018b585e8c6fa7d85d4b38d9ce49a5b67be7078]
stable/5.10: [1576f0df7b4d1f82db588d6654b89d796fa06929]
stable/5.15: [97f54b330c797ed27fba8791baeaa38ace886cbd]
stable/5.4: [4815359056083c555f97a5ee3af86519be5166de]
stable/6.1: [5fd32eb6fa0ac795aa5a64bc004ab68d7b44196a]

CVE-2023-53561: net: wwan: iosm: fix NULL pointer dereference when
removing device

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53561

Introduced by commit 3670970 ("net: iosm: shared memory IPC
interface") in v5.14-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60829145f1e2650b31ebe6a0ec70a9725b38fa2c]
stable/6.1: [ee44bacf462db3ec6e4f0dcfa7931e768670d77c]

CVE-2023-53562: drm/msm: fix vram leak on bind errors

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53562

Introduced by commit d863f0c ("drm/msm: Call msm_init_vram before
binding the gpu") in v5.11-rc3.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [60d476af96015891c7959f30838ae7a9749932bf]
stable/6.1: [544711591a67a6da4d9f0f70ba3c805eb2548729]

CVE-2023-53563: cpufreq: amd-pstate-ut: Fix kernel panic when loading the driver

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53563

Introduced by commit 14eb1c9 ("cpufreq: amd-pstate: Add test module
for amd-pstate driver") in v6.1-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60dd283804479c4a52f995b713f448e2cd65b8c8]
stable/6.1: [fcf78a17bbb94bebaa912f0460a1848f7d374c94]
stable/6.6: [60dd283804479c4a52f995b713f448e2cd65b8c8]

CVE-2023-53564: ocfs2: fix defrag path triggering jbd2 ASSERT

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53564

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [7f3b1c28e2908755fb248d3ee8ff56826f2387db]
cip/4.4-st: [2f4f4f8f436bfebc8404eba93afb01412a00e5ef]
mainline: [60eed1e3d45045623e46944ebc7c42c30a4350f0]
stable/5.10: [2c559b3ba8e0b9e3c4bb08159a28ccadc698410f]
stable/5.15: [33665d1042666f2e5c736a3df1f453e31f030663]
stable/5.4: [669134a66d37258e1c4a5cfbd5b82f547ae30fca]
stable/6.1: [8163ea90d89b7012dd1fa4b28edf5db0c641eca7]

CVE-2023-53565: wifi: brcmfmac: Check for probe() id argument being NULL

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53565

Introduced by commit da6d9c8 ("wifi: brcmfmac: add firmware vendor
info in driver info") in v6.2-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60fc756fc8e6954a5618eecac73b255d651602e4]

CVE-2023-53566: netfilter: nft_set_rbtree: fix null deref on element insertion

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53566

Introduced by commit c9e6978 ("netfilter: nft_set_rbtree: Switch to
node list walk for overlap detection") in v6.2-rc6.
Fixed in v6.4-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
cip/4.19-st: [b76db53ee8802ee5683f8cb401d7e2ec6f9b3d56]
mainline: [61ae320a29b0540c16931816299eb86bf2b66c08]
stable/5.10: [3fa13203b6d90cc3a33af47b058739f92ab82eef]
stable/5.15: [ec5caa765f7f6960011c919c9aeb1467940421f6]
stable/5.4: [899aa5638568abf5d69de7a7bb95e4615157375b]
stable/6.1: [a836be60a3aabcedcd9c79f545d409ace1f20ba6]

CVE-2023-53567: spi: qup: Don't skip cleanup in remove's error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53567

Introduced by commit 64ff247 ("spi: Add Qualcomm QUP SPI controller
support") in v3.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fd53f41bd86daa39b454fd4637a908ff2123547f]
mainline: [61f49171a43ab1f80c73c5c88c508770c461e0f2]
stable/5.10: [bc88243bbe6140d289bb32b4ee4607ba5ce1124a]
stable/5.15: [f345d4d71e87d878437417ffbb9a7d4e16d235eb]
stable/5.4: [8632384337038b97910c2f7bb5a3f377aa68d001]
stable/6.1: [2d0f63077f481f11a07f20eab1c1f4367dfaef32]

CVE-2023-53568: s390/zcrypt: don't leak memory if dev_set_name() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53568

Introduced by commit 00fab23 ("s390/zcrypt: multiple zcrypt device
nodes support") in v4.20-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6252f47b78031979ad919f971dc8468b893488bd]
stable/5.10: [0878052579cb2773caee64812a811edcab6b5a55]
stable/5.15: [131cd74a8e38d75239f2c81dfee53d6554eb8bf8]
stable/5.4: [6b0cb9c055843777b374309503d89eabeb769355]
stable/6.1: [147d8da33a2c2195ec63acd56cd7d80a3458c253]
stable/6.6: [6252f47b78031979ad919f971dc8468b893488bd]

CVE-2023-53569: ext2: Check block size validity during mount

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53569

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [451b98155be5dfee05bc6e7c8b30c0be4add3f71]
cip/4.4-st: [290dd6be1ae808ccd8a060f851b767fd0768bddf]
mainline: [62aeb94433fcec80241754b70d0d1836d5926b0a]
stable/5.10: [22ab5fed07ad4b206ea910fd0132d1a0d4831584]
stable/5.15: [99f8a15af6c9f0653193104a9e70891f950c6001]
stable/5.4: [c4813f858e5c3e4c4659ce95385c1c400c593e1e]
stable/6.1: [e6f4fb28890c1361e0db9eb1adee3fc04e7fe7f5]

CVE-2023-53570: wifi: nl80211: fix integer overflow in
nl80211_parse_mbssid_elems()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53570

Introduced by commit dc1e3cb ("nl80211: MBSSID and EMA support in AP
mode") in v5.16-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6311071a056272e1e761de8d0305e87cc566f734]
stable/6.1: [e642eb67b8c10dcce758d549cc81564116e0fa49]

CVE-2023-53571: drm/i915: Make intel_get_crtc_new_encoder() less oopsy

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53571

Introduced by commit 3a47ae2 ("drm/i915/display: Make WARN* drm
specific where encoder ptr is available") in v5.7-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [631420b06597a33c72b6dcef78d1c2dea17f452d]
stable/5.10: [780f303233c35eeb5132e3ee1cbc8f4cebe86dd2]
stable/5.15: [54202488c835dab8c648acd107f0bb8eaa699894]
stable/6.1: [0fe6ef82e4f4764e8f556632e4cd93d78d448e99]

CVE-2023-53572: clk: imx: scu: use _safe list iterator to avoid a use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53572

Introduced by commit 77d8f30 ("clk: imx: scu: add two cells binding
support") in v5.11-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [632c60ecd25dbacee54d5581fe3aeb834b57010a]
stable/5.15: [f95ff838ac39f861d1f95a0f3bbb1e01c2517d79]
stable/6.1: [08cc7cd2c2a29a2abf5bceb8f048c0734d3694ba]

CVE-2023-53573: clk: rs9: Fix suspend/resume

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53573

Introduced by commit 2ff4ba9 ("clk: rs9: Fix I2C accessors") in v6.1-rc4.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [632e04739c8f45c2d9ca4d4c5bd18d80c2ac9296]
stable/6.1: [74f4471ad64214dd5046213ebdd6e0930da7bd2c]

CVE-2023-53574: wifi: rtw88: delete timer and free skb queue when unloading

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53574

Introduced commit is not determined.Fixed in v6.6-rc1.
The rtw88 driver was added in 5.2-rc1.

Fixed status
mainline: [634fcbcaa4062db39aeb5ac6ed1bc1feb8dd5216]
stable/6.6: [634fcbcaa4062db39aeb5ac6ed1bc1feb8dd5216]

CVE-2023-53575: wifi: iwlwifi: mvm: fix potential array out of bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53575

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected file was added in 6.2-rc1.

Fixed status
mainline: [637452360ecde9ac972d19416e9606529576b302]

CVE-2023-53576: null_blk: Always check queue mode setting from configfs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53576

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [63f8793ee60513a09f110ea460a6ff2c33811cdb]
stable/5.10: [e732a266b973cd4e115e2cc2ea5007119e8a7fbc]
stable/5.15: [35e304dbcefa95237a3d6f94c007bfb10f012b17]
stable/6.1: [fd35b7bb6d5a329c427924886949ab51f210200a]

CVE-2023-53577: bpf, cpumap: Make sure kthread is running before map
update returns

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53577

Introduced by commit 6710e11 ("bpf: introduce new bpf cpu map type
BPF_MAP_TYPE_CPUMAP") in v4.15-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [640a604585aa30f93e39b17d4d6ba69fcb1e66c9]
stable/5.15: [b44d28b98f185d2f2348aa3c3636838c316f889e]
stable/6.1: [7a1178a3671b40746830d355836b72e47ceb2490]

CVE-2023-53578: net: qrtr: Fix an uninit variable access bug in qrtr_tx_resume()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53578

Introduced by commit 5fdeb0d ("net: qrtr: Implement outgoing flow
control") in v5.6-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6417070918de3bcdbe0646e7256dae58fd8083ba]
stable/5.10: [3814d211ff13ee35f2d9437439a6c7df58524137]
stable/5.15: [c6a796ee5a639ffb83c6e5469408cc2ec16cac6a]
stable/6.1: [bef57c227b52c2bde00fad33556175d36d12cfa0]

CVE-2023-53579: gpio: mvebu: fix irq domain leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53579

Introduced by commit 812d478 ("gpio/mvebu: Use irq_domain_add_linear")
in v4.9-rc4.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [644ee70267a934be27370f9aa618b29af7290544]
stable/5.15: [b19e90521286a03bc3793fd598f20277a8f99c85]
stable/6.1: [44e2afbf650f3264519643fcc9e6b4d2f6e8d547]

CVE-2023-53580: USB: Gadget: core: Help prevent panic during UVC unconfigure

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53580

Introduced by commit 286d997 ("usb: gadget: udc: core: Prevent
soft_connect_store() race") in v6.4-rc7.
Fixed in v6.5-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [65dadb2beeb7360232b09ebc4585b54475dfee06]
stable/6.1: [bed19d95fcb9c98dfaa9585922b39a2dfba7898d]

CVE-2023-53581: net/mlx5e: Check for NOT_READY flag state after locking

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53581

Introduced by commit ad86755 ("net/mlx5e: Protect unready flows with
dedicated lock") in v5.4-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65e64640e97c0f223e77f9ea69b5a46186b93470]
stable/5.10: [30c281a77fb1b2d362030ea243dd663201d62a21]
stable/5.15: [82ac62d76a000871004f534ad294e763e966d3b0]
stable/6.1: [e962fd5933ebc767ce2a1cf7b7c85035b5a5d04c]

CVE-2023-53582: wifi: brcmfmac: ensure CLM version is null-terminated
to prevent stack-out-of-bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53582

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [3b173b4ad9c001a555f44adc7836d6fe3afbe9ec]
mainline: [660145d708be52f946a82e5b633c020f58f996de]
stable/5.10: [0ca2efea4f11c6255061e852ac188264c469c197]
stable/5.15: [a0f0ce1c8ab9fe90618dc394e3d1568b5a9ac154]
stable/5.4: [423a1297ea72bbddf64dbb0957f2879c0f2aa5d0]
stable/6.1: [ecb980dc79709c02f579a9c03cb92ccec189ab38]

CVE-2023-53583: perf: RISC-V: Remove PERF_HES_STOPPED flag checking in
riscv_pmu_start()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53583

Introduced by commit 096b52f ("perf: RISC-V: throttle perf events") in v6.1-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66843b14fb71825fdd73ab12f6594f2243b402be]
stable/6.1: [aeb62beaf9cbd0a72e7f97c9af6d3e7f76ce2946]

CVE-2023-53584: ubifs: ubifs_releasepage: Remove ubifs_assert(0) to
valid this process

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53584

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66f4742e93523ab2f062d9d9828b3e590bc61536]
stable/6.1: [7750be5d3e18500b454714677463b500a0b8b0d8]

CVE-2023-53585: bpf: reject unhashed sockets in bpf_sk_assign

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53585

Introduced by commit cf7fbe6 ("bpf: Add socket assign support") in v5.7-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67312adc96b5a585970d03b62412847afe2c6b01]
stable/5.10: [791a12102e5191dcb6ce0b3a99d71b5a2802d12a]
stable/5.15: [7dcbc0bb0e5cc1823923744befce59ac353135e6]
stable/6.1: [c0ce0fb76610d5fad31f56f2ca8241a2a6717a1b]
stable/6.6: [67312adc96b5a585970d03b62412847afe2c6b01]

CVE-2023-53586: scsi: target: Fix multiple LUN_RESET handling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53586

Introduced by commit 51ec502 ("target: Delete tmr from list before
processing") in v4.11-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [673db054d7a2b5a470d7a25baf65956d005ad729]
stable/5.10: [e1f59cd18a10969d08a082264b557876ca38766e]
stable/5.15: [9158c86fd3237acaea8f0181c7836d90fd6eea10]
stable/6.1: [eacfe32c3650bfd0e54224d160c431013d7f6998]

CVE-2023-53587: ring-buffer: Sync IRQ works before buffer destruction

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53587

Introduced by commit 1569345 ("tracing/ring-buffer: Move poll wake ups
into ring buffer code") in v3.10-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2702b67f59d455072a08dc40312f9b090d4dec04]
cip/4.4-st: [254442105d9db3ebaf2be48a556ccdce2039dc45]
mainline: [675751bb20634f981498c7d66161584080cc061e]
stable/5.10: [1c99f65d6af2a454bfd5207b4f6a97c8474a1191]
stable/5.15: [c63741e872fcfb10e153517750f7908f0c00f60d]
stable/5.4: [2399b1fda025e939b6fb1ac94505bcf718534e65]
stable/6.1: [d9834abd8b24d1fe8092859e436fe1e0fd467c61]

CVE-2023-53588: wifi: mac80211: check for station first in client probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53588

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [67dfa589aa8806c7959cbca2f4613b8d41c75a06]
stable/6.1: [7e1cda5cf07f848e6b50b4e5e7761ffbce905a3d]
stable/6.6: [67dfa589aa8806c7959cbca2f4613b8d41c75a06]

CVE-2023-53589: wifi: iwlwifi: mvm: don't trust firmware n_channels

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53589

Introduced by commit dcaf9f5 ("iwlwifi: mvm: add MCC update FW API")
in v4.1-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [682b6dc29d98e857e6ca4bbc077c7dc2899b7473]
stable/5.10: [d0d39bed9e95f27a246be91c5929254ac043ed30]
stable/5.15: [05ad5a4d421ce65652fcb24d46b7e273130240d6]
stable/5.4: [e519a404a5bbba37693cb10fa61794a5fce4fd9b]
stable/6.1: [557ba100d8cf3661ff8d71c0b4a2cba8db555ec2]

CVE-2023-53590: sctp: add a refcnt in sctp_stream_priorities to avoid
a nested loop

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53590

Introduced by commit 9ed7bfc ("sctp: fix memory leak in
sctp_stream_outq_migrate()") in v6.1-rc8.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [68ba44639537de6f91fe32783766322d41848127]
stable/5.10: [8ee401f89cdb10f39098c0656d695b2bc4052100]
stable/5.15: [bf5540cbd20e2dae2c81ab9b31deef41ef147d0a]
stable/5.4: [cec326443f01283ef68ea00c06ea073b1835a562]
stable/6.1: [03c3a5584a0a29821e59b7834635ce823050caaa]

CVE-2023-53591: net/mlx5e: Fix deadlock in tc route query code

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53591

Introduced by commit f9d196b ("net/mlx5e: Use correct eswitch for
stack devices with lag") in v5.15-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [691c041bf20899fc13c793f92ba61ab660fa3a30]
stable/5.15: [69966bce28da6aadccfd968b75d128a79da32d17]
stable/6.1: [362063df6ceec80b0b6798b61ae03504dcc125a5]

CVE-2023-53592: gpio: sifive: Fix refcount leak in sifive_gpio_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53592

Introduced by commit 96868dc ("gpio/sifive: Add GPIO driver for SiFive
SoCs") in v5.6-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [694175cd8a1643cde3acb45c9294bca44a8e08e9]
stable/5.10: [f4a2ad1002006548e235255c65a4f1d07312be9d]
stable/5.15: [95da1882ce9372ba20278f87cdb7a34f9812c4b5]
stable/6.1: [9a402a210798662b04cbe6ca466e916a15efa03a]

CVE-2023-53593: cifs: Release folio lock on fscache read hit.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53593

Introduced commit is not determined.Fixed in v6.5-rc7.


Fixed status
cip/4.19-st: [5a87735675147f848445f05fd1f06168188f91af]
cip/4.4-st: [785416c3673941417decab261b9f6c995a8196a8]
mainline: [69513dd669e243928f7450893190915a88f84a2b]
stable/5.10: [6e74926ede96470be84e66a1c576982fe4f8ea79]
stable/5.15: [961f7ce16223aee2db583a43877d84e6d1f2b857]
stable/5.4: [4259dd534245579c966c53c15187cc8e9461d6e9]
stable/6.1: [9e725386d4262ef23ae51993f04602bc535b5be2]

CVE-2023-53594: driver core: fix resource leak in device_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53594

Introduced by commit cebf8fd ("driver core: fix race between
creating/querying glue dir and its cleanup") in v4.9-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [6977b1a5d67097eaa4d02b0c126c04cc6e8917c0]
stable/5.15: [8d389e363075c2e1deb84a560686ea92123e4b8b]
stable/6.1: [d1dbff10c6cd3b43457f3efd3c9c4950009635bf]

CVE-2023-53595: octeontx2-pf: mcs: Fix NULL pointer dereferences

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53595

Introduced by commit c54ffc7 ("octeontx2-pf: mcs: Introduce MACSEC
hardware offloading") in v6.1-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [699af748c61574125d269db260dabbe20436d74e]
stable/6.1: [a3dcc45eca017fca82ac47dbde6f41af960657e5]

CVE-2023-53596: drivers: base: Free devm resources when unregistering a device

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53596

Introduced by commit a525a3d ("driver core: free devres in
device_release") in v3.7-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [699fb50d99039a50e7494de644f96c889279aca3]
stable/6.1: [297992e5c63528e603666e36081836204fc36ec9]
stable/6.6: [699fb50d99039a50e7494de644f96c889279aca3]

CVE-2023-53597: cifs: fix mid leak during reconnection after timeout threshold

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53597

Introduced by commit 8e670f7 ("Handle STATUS_IO_TIMEOUT gracefully")
in v5.10-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69cba9d3c1284e0838ae408830a02c4a063104bc]
stable/5.15: [df31d05f0678cdd0796ea19983a2b93edca18bb0]
stable/6.1: [c55901d381a22300c9922170e59704059f50977b]

CVE-2023-53598: bus: mhi: host: Range check CHDBOFF and ERDBOFF

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53598

Introduced by commit 6cd330a ("bus: mhi: core: Add support for ringing
channel/event ring doorbells") in v5.7-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a0c637bfee69a74c104468544d9f2a6579626d0]
stable/5.10: [372f1752b74572b0a9d2288841eab7db17daccae]
stable/5.15: [2343385fe6eed11d0432ab42a97b3ca4aef06a99]
stable/6.1: [a2cbb1a45a0c86ce77839c0875414efe1a89315e]

CVE-2023-53599: crypto: af_alg - Fix missing initialisation affecting
gcm-aes-s390

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53599

Introduced by commit c1abe6f ("crypto: af_alg: Use
extract_iter_to_sg() to create scatterlists") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a4b8aa0a916b39a39175584c07222434fa6c6ef]
stable/6.6: [6a4b8aa0a916b39a39175584c07222434fa6c6ef]

CVE-2023-53600: tunnels: fix kasan splat when generating ipv4 pmtu error

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53600

Introduced by commit 4cb47a8 ("tunnels: PMTU discovery support for
directly bridged IP packets") in v5.9-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a7ac3d20593865209dceb554d8b3f094c6bd940]
stable/5.10: [5850c391fd7e25662334cb3cbf29a62bcbff1084]
stable/5.15: [e95808121953410db8c59f0abfde70ac0d34222c]
stable/6.1: [da5f42a6e7485fbb7a6dbd6a2b3045e19e4df5cc]

CVE-2023-53601: bonding: do not assume skb mac_header is set

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53601

Introduced by commit 7b8fc01 ("bonding: add a vlan+srcmac tx hashing
option") in v5.12-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a940abdef3162e5723f1495b8a49859d1708f79]
stable/5.15: [029d892b05fc5e42a1b1c0665f62cb3e4b23e6dc]
stable/6.1: [37b6143376a578265add04f35161b257eeb84a5e]

CVE-2023-53602: wifi: ath11k: fix memory leak in WMI firmware stats

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53602

Introduced commit is not determined.Fixed in v6.5-rc1.
The ath11k was added in 5.6-rc1.

Fixed status
mainline: [6aafa1c2d3e3fea2ebe84c018003f2a91722e607]
stable/6.1: [86f9330a49d1464849482298dd34d361859183eb]

CVE-2023-53603: scsi: qla2xxx: Avoid fcport pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53603

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected file was added in 5.15-rc1.

Fixed status
mainline: [6b504d06976fe4a61cc05dedc68b84fadb397f77]
stable/5.15: [4406fe8a96a946c7ea5724ee59625755a1d9c59d]
stable/6.1: [477bc74ad1add644b606bff6ba1284943c42818a]

CVE-2023-53604: dm integrity: call kmem_cache_destroy() in
dm_integrity_init() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53604

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected code was added by 7eada90 ("dm: add integrity target") in 4.12-rc1.

Fixed status
cip/4.19-st: [ca8b634fdf07dee3f6dfde57079c4511480b525e]
mainline: [6b79a428c02769f2a11f8ae76bf866226d134887]
stable/5.10: [44f29e93a55b544dc961b6f8b4e93abaeaafb9ee]
stable/5.15: [a5d8c6bf58e5b2e70fbc15f3b08dfc1ba6f269ac]
stable/5.4: [6d126899b0747305c9d39a0bcf87e0df9c3f555b]
stable/6.1: [3877b5c1509b16eeb1f275228fd91789cd88cf17]

CVE-2023-53605: drm: amd: display: Fix memory leakage

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53605

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 68c0fca ("drm/amd/display: support virtual
DCN") in 5.6-rc1.

Fixed status
mainline: [6b8701be1f66064ca72733c5f6e13748cdbf8397]
stable/5.10: [d473c55ce1975c9e601c25293328a5039225d2b2]
stable/5.15: [9ae15ebaefc4878d614f10cc56ea672f88cea582]
stable/6.1: [83ace0dd67ee386be1ddcf59dab49d6d9a54e62e]

CVE-2023-53606: nfsd: clean up potential nfsd_file refcount leaks in
COPY codepath

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53606

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [6ba434cb1a8d403ea9aad1b667c3ea3ad8b3191f]
stable/5.10: [fd63299db8090307eae66f2aef17c8f00aafa0a9]
stable/5.15: [b3169b6ffe036b549c296a9e71591d29a1fb3209]
stable/6.1: [75b8c681c563ef7e85da6862354efc18d2a08b1b]

CVE-2023-53607: ALSA: ymfpci: Fix BUG_ON in probe function

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53607

Introduced by commit 5c1733e ("ALSA: memalloc: Align buffer
allocations in page size") in v5.11-rc1.
Fixed in v6.3-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [6be2e7522eb529b41c16d459f33bbdbcddbf5c15]
stable/5.10: [96e34c88000febc83e41aa7db0b0a41676314818]
stable/5.15: [81d2a7e93c8322ca6b858f6736d7fc3d034e6c23]
stable/6.1: [32b9bd7cfc2e2d92d595386add4e111b232b351f]

CVE-2023-53608: nilfs2: fix potential UAF of struct nilfs_sc_info in
nilfs_segctor_thread()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53608

Introduced commit is not determined.Fixed in v6.3-rc6.


Fixed status
cip/4.19-st: [0dbf0e64b91ee8fcb278aea93eb06fc7d56ecbcc]
cip/4.4-st: [1e88f4060748166e9ee768513d4dd9a4edca71a1]
mainline: [6be49d100c22ffea3287a4b19d7639d259888e33]
stable/5.10: [f32297dba338dc06d62286dedb3cdbd5175b1719]
stable/5.15: [92684e02654c91a61a0b0561433b710bcece19fe]
stable/5.4: [613bf23c070d11c525268f2945aa594704a9b764]
stable/6.1: [bae009a2f1b7c2011d2e92d8c84868d315c0b97e]

CVE-2023-53609: scsi: Revert "scsi: core: Do not increase
scsi_device's iorequest_cnt if dispatch failed"

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53609

Introduced commit is not determined.Fixed in v6.4-rc3.
'Introduced by cfee29f ("scsi: core: Do not increase scsi_device's
iorequest_cnt if dispatch failed") in 6.2-rc1.'

Fixed status
mainline: [6ca9818d1624e136a76ae8faedb6b6c95ca66903]

CVE-2023-53610: irqchip: Fix refcount leak in platform_irqchip_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53610

Introduced by commit f8410e6 ("irqchip: Add
IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros") in
v5.9-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6caa5a2b78f5f53c433d3a3781e53325da22f0ac]
stable/5.10: [b00baffcc2561374f8fe8af873d00531f19864eb]
stable/5.15: [4401b485855700f296cae4d0db36a52948bff4fa]
stable/6.1: [ea54b608d85b7536f92238f3259730fa06cb5d21]

CVE-2023-53611: ipmi_si: fix a memleak in try_smi_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53611

Introduced by commit 7960f18 ("ipmi_si: Convert over to a shutdown
handler") in v4.18-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b9bc8fbb2d416ce87f0342478dc9fcfd79f2c65f]
mainline: [6cf1a126de2992b4efe1c3c4d398f8de4aed6e3f]
stable/5.10: [5c5f02e16b919c8cb6024dc3778c8d8f1fb1f26b]
stable/5.15: [cbb7d8a4b4beb3061b3a1847a742983a01dca381]
stable/5.4: [f53ab5a2bf20fed59a2f7542d3453228b8056358]
stable/6.1: [09cb2a71b2e982015fe0464f28da1ab42b8e6375]

CVE-2023-53612: hwmon: (coretemp) Simplify platform device handling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53612

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [6d03bbff456befeccdd4d663177c4d6c75d0c4ff]
stable/5.10: [5735878a7b7db7e9ce731cb36cec298a9de67549]
stable/5.15: [52ea47a0ddfbc5fe05e873d3f5a59db4ba3e03fe]
stable/5.4: [4000384684f612b3645a944f6acde0e65ac370b8]
stable/6.1: [8fcdbc4bc01365f4b10fed7db544a3149e3054fd]

CVE-2023-53613: dax: Fix dax_mapping_release() use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53613

Introduced by commit 0b07ce8 ("device-dax: introduce 'mapping'
devices") in v5.10-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d24b170a9db0456f577b1ab01226a2254c016a8]
stable/5.10: [94a85474f5e3e518bdbf8c9f51cb343d734a04f7]
stable/5.15: [9c2f993b6ca903c030d58451b5bf9ea27d0d17fa]
stable/6.1: [03859868ab82d57bfdd0cea1bf31f9319a5dded0]

CVE-2023-53614: mm/ksm: fix race with VMA iteration and mm_struct teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53614

Introduced by commit a5f18ba ("mm/ksm: use vma iterators instead of
vma linked list") in v6.1-rc1.
Fixed in v6.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6db504ce55bdbc575723938fc480713c9183f6a2]
stable/6.1: [286b0cab31bac29960e5684f6fb331d42f03b363]

CVE-2023-53615: scsi: qla2xxx: Fix deletion race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53615

Introduced by commit 726b854 ("qla2xxx: Add framework for async fabric
discovery") in v4.11-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dfe4344c168c6ca20fe7640649aacfcefcccb26]
stable/5.10: [4d7da12483e98c451a51bd294a3d3494f0aee5eb]
stable/5.15: [f1ea164be545629bf442c22f508ad9e7b94ac100]
stable/5.4: [a4628a5b98e4c6d905e1f7638242612d7db7d9c2]
stable/6.1: [cd06c45b326e44f0d21dc1b3fa23e71f46847e28]
stable/6.6: [6dfe4344c168c6ca20fe7640649aacfcefcccb26]

CVE-2023-53616: jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53616

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [114ea3cb13ab25f7178cb60283adb93d2f96dad7]
cip/4.4-st: [6e0883729dad5a8400b18383af0f3816779217ae]
mainline: [6e2bda2c192d0244b5a78b787ef20aa10cb319b7]
stable/5.10: [756747d4b439e3e1159282ae89f17eefebbe9b25]
stable/5.15: [ef7311101ca43dd73b45bca7a30ac72d9535ff87]
stable/5.4: [5873df0195124be2f357de11bfd473ead4f90ed8]
stable/6.1: [4de3a603010e0ca334487de24c6aab0777b7f808]
stable/6.6: [6e2bda2c192d0244b5a78b787ef20aa10cb319b7]

CVE-2025-39929: smb: client: fix smbdirect_recv_io leak in
smbd_negotiate() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39929

Introduced by commit f198186 ("CIFS: SMBD: Establish SMB Direct
connection") in v4.16-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [daac51c7032036a0ca5f1aa419ad1b0471d1c6e0]
stable/6.1: [3d7c075c878ac844e33c43e506c2fa27ac7e9689]
stable/6.12: [922338efaad63cfe30d459dfc59f9d69ff93ded4]
stable/6.6: [e7b7a93879558e77d950f1ff9a6f3daa385b33df]

CVE-2025-39931: crypto: af_alg - Set merge to zero early in af_alg_sendmsg

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39931

Introduced by commit 8ff5909 ("crypto: algif_skcipher - User-space
interface for skcipher operations") in v2.6.38-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9574b2330dbd2b5459b74d3b5e9619d39299fc6f]
stable/6.1: [6241b9e2809b12da9130894cf5beddf088dc1b8a]
stable/6.12: [24c1106504c625fabd3b7229611af617b4c27ac7]
stable/6.6: [2374c11189ef704a3e4863646369f1b8e6a27d71]

CVE-2025-39932: smb: client: let smbd_destroy() call
disable_work_sync(&info->post_send_credits_work)

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39932

Introduced by commit f198186 ("CIFS: SMBD: Establish SMB Direct
connection") in v4.16-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9dcbbcf9145b68aa85c40947311a6907277e097]
stable/6.12: [6ae90a2baf923e85eb037b636aa641250bf4220f]

CVE-2025-39933: smb: client: let recv_done verify data_offset,
data_length and remaining_data_length

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39933

Introduced by commit f198186 ("CIFS: SMBD: Establish SMB Direct
connection") in v4.16-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f57e53ea252363234f86674db475839e5b87102e]

CVE-2025-39934: drm: bridge: anx7625: Fix NULL pointer dereference
with early IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39934

Introduced by commit 8bdfc5d ("drm/bridge: anx7625: Add anx7625 MIPI
DSI/DPI to DP") in v5.11-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a10f910c77f280327b481e77eab909934ec508f0]
stable/5.15: [51a501e990a353a4f15da6bab295b28e5d118f64]
stable/6.1: [f9a089d0a6d537d0f2061c8a37a7de535ce0310e]
stable/6.12: [0da73f7827691a5e2265b110d5fe12f29535ec92]
stable/6.6: [15a77e1ab0a994d69b471c76b8d01117128dda26]

CVE-2025-39935: ASoC: codec: sma1307: Fix memory corruption in
sma1307_setting_loaded()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39935

Introduced by commit 576c57e ("ASoC: sma1307: Add driver for Iron
Device SMA1307") in v6.13-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78338108b5a856dc98223a335f147846a8a18c51]

CVE-2025-39936: crypto: ccp - Always pass in an error pointer to
__sev_platform_shutdown_locked()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39936

Introduced by commit 9770b42 ("crypto: ccp - Move dev_info/err
messages for SEV/SNP init and shutdown") in v6.16-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46834d90a9a13549264b9581067d8f746b4b36cc]

CVE-2025-39937: net: rfkill: gpio: Fix crash due to dereferencering
uninitialized pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39937

Introduced by commit 7d5e973 ("net: rfkill: gpio: get the name and
type from device property") in v4.6-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6f56a44e4c1014b08859dcf04ed246500e310e5]
stable/5.10: [8793e7a8e1b60131a825457174ed6398111daeb7]
stable/5.15: [ada2282259243387e6b6e89239aeb4897e62f051]
stable/5.4: [184f608a68f96794e8fe58cd5535014d53622cde]
stable/6.1: [47ade5f9d70b23a119ec20b1c6504864b2543a79]
stable/6.12: [21ba85d9d508422ca9e6698463ff9357c928c22d]
stable/6.6: [689aee35ce671aab752f159e5c8e66d7685e6887]

CVE-2025-39938: ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer
dereference if source graph failed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39938

Introduced by commit 30ad723 ("ASoC: qdsp6: audioreach: add q6apm
lpass dai support") in v5.16-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68f27f7c7708183e7873c585ded2f1b057ac5b97]
stable/6.1: [01d1ba106c9e02a2e7d41e07be49031a0ff0ecaa]
stable/6.12: [9c534dbfd1726502abcf0bd393a04214f62c050b]
stable/6.6: [411f7d4f7038200cdf6d4f71ee31026ebf2dfedb]

CVE-2025-39939: iommu/s390: Fix memory corruption when using identity domain

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39939

Introduced by commit 64af12c ("iommu/s390: implement iommu passthrough
via identity domain") in v6.15-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3506e9bcc777ed6af2ab631c86a9990ed97b474]

CVE-2025-39940: dm-stripe: fix a possible integer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39940

Introduced commit is not determined.Fixed in v6.17-rc7.


Fixed status
mainline: [1071d560afb4c245c2076494226df47db5a35708]
stable/6.12: [f8f64254bca5ae58f3b679441962bda4c409f659]

CVE-2025-39941: zram: fix slot write race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39941

Introduced by commit 7126803 ("zram: free slot memory early during
write") in v6.14-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce4be9e4307c5a60701ff6e0cafa74caffdc54ce]

CVE-2025-39942: ksmbd: smbdirect: verify remaining_data_length
respects max_fragmented_recv_size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39942

Introduced by commit 2ea086e ("ksmbd: add buffer validation for smb
direct") in v5.15-rc7.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1868ba37fd27c6a68e31565402b154beaa65df0]
stable/6.1: [196a3a7676d726ee67621ea2bf3b7815ac2685b4]
stable/6.12: [9644798294c7287e65a7b26e35aa6d2ce3345bcc]
stable/6.6: [d3cb3f209d35c44b7ee74f77ed27ebb28995b9ce]

CVE-2025-39943: ksmbd: smbdirect: validate data_offset and data_length
field of smb_direct_data_transfer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39943

Introduced by commit 2ea086e ("ksmbd: add buffer validation for smb
direct") in v5.15-rc7.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5282491fc49d5614ac6ddcd012e5743eecb6a67c]
stable/5.15: [773fddf976d282ef059c36c575ddb81567acd6bc]
stable/6.1: [bdaab5c6538e250a9654127e688ecbbeb6f771d5]
stable/6.12: [8be498fcbd5b07272f560b45981d4b9e5a2ad885]
stable/6.6: [eb0378dde086363046ed3d7db7f126fc3f76fd70]

CVE-2025-39944: octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39944

Introduced by commit 2958d17 ("octeontx2-pf: Add support for ptp
1-step mode on CN10K silicon") in v6.1-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8b4687151021db61841af983f1cb7be6915d4ef]
stable/6.1: [2786879aebf363806a13d41e8d5f99202ddd23d9]
stable/6.12: [ff27e23b311fed4d25e3852e27ba693416d4c7b3]
stable/6.6: [d2cfefa14ce8137b17f99683f968bebf134b6a48]

CVE-2025-39945: cnic: Fix use-after-free bugs in cnic_delete_task

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39945

Introduced by commit fdf2408 ("cnic: Defer iscsi connection cleanup")
in v2.6.37-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfa7d9b1e3a8604afc84e9e51d789c29574fb216]
stable/5.10: [7b6a5b0a6b392263c3767fc945b311ea04b34bbd]
stable/5.15: [0405055930264ea8fd26f4131466fa7652e5e47d]
stable/5.4: [fde6e73189f40ebcf0633aed2b68e731c25f3aa3]
stable/6.1: [e1fcd4a9c09feac0902a65615e866dbf22616125]
stable/6.12: [6e33a7eed587062ca8161ad1f4584882a860d697]
stable/6.6: [8eeb2091e72d75df8ceaa2172638d61b4cf8929a]

CVE-2025-39946: tls: make sure to abort the stream if headers are bogus

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39946

Introduced by commit 84c61fe ("tls: rx: do not use the standard
strparser") in v6.0-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0aeb54ac4cd5cf8f60131b4d9ec0b6dc9c27b20d]
stable/6.1: [b36462146d86b1f22e594fe4dae611dffacfb203]
stable/6.12: [208640e6225cc929a05adbf79d1df558add3e231]
stable/6.6: [4cefe5be73886f383639fe0850bb72d5b568a7b9]

CVE-2025-39947: net/mlx5e: Harden uplink netdev access against device unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39947

Introduced by commit 7a9fb35 ("net/mlx5e: Do not reload ethernet ports
when changing eswitch mode") in v5.13-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b4be64fd9fec16418f365c2d8e47a7566e9eba5]
stable/6.12: [d1f3db4e7a3be29fc17f01850f162363f919370d]
stable/6.6: [2cb17c88edd3a1c7aa6bc880dcdb35a6866fcb2e]

CVE-2025-39948: ice: fix Rx page leak on multi-buffer frames

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39948

Introduced by commit 743bbd9 ("ice: put Rx buffers after being done
with current frame") in v6.14-rc2.
Fixed in v6.17-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [84bf1ac85af84d354c7a2fdbdc0d4efc8aaec34b]
stable/6.12: [80555adb5c892f0e21d243ae96ed997ee520aea9]

CVE-2025-39949: qed: Don't collect too many protection override GRC elements

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39949

Introduced by commit d52c89f ("qed*: Utilize FW 8.37.2.0") in v4.18-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56c0a2a9ddc2f5b5078c5fb0f81ab76bbc3d4c37]
stable/5.10: [25672c620421fa2105703a94a29a03487245e6d6]
stable/5.15: [e0e24571a7b2f8c8f06e25d3417253ebbdbc8d5c]
stable/6.1: [8141910869596b7a3a5d9b46107da2191d523f82]
stable/6.12: [660b2a8f5a306a28c7efc1b4990ecc4912a68f87]
stable/6.6: [ea53e6a47e148b490b1c652fc65d2de5a086df76]

CVE-2025-39950: net/tcp: Fix a NULL pointer dereference when using
TCP-AO with TCP_REPAIR

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39950

Introduced by commit 7c2ffaf ("net/tcp: Calculate TCP-AO traffic
keys") in v6.7-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e7bba08923ebc675b1f0e0e0959e68e53047838]
stable/6.12: [5f445eb259906b61a518487a790e11d07d31738c]

CVE-2025-39951: um: virtio_uml: Fix use-after-free after put_device in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39951

Introduced by commit 04e5b1f ("um: virtio: Remove device on
disconnect") in v5.5-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ebf70cf181651fe3f2e44e95e7e5073d594c9c0]
stable/5.10: [14c231959a16ca41bfdcaede72483362a8c645d7]
stable/5.15: [5e94e44c9cb30d7a383d8ac227f24a8c9326b770]
stable/6.1: [aaf900a83508c8cd5cdf765e7749f9076196ec7f]
stable/6.12: [00e98b5a69034b251bb36dc6e7123d7648e218e4]
stable/6.6: [4f364023ddcfe83f7073b973a9cb98584b7f2a46]

CVE-2025-39952: wifi: wilc1000: avoid buffer overflow in WID string
configuration

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39952

Introduced commit is not determined.Fixed in v6.17-rc5.


Fixed status
mainline: [fe9e4d0c39311d0f97b024147a0d155333f388b5]
stable/6.12: [2203ef417044b10a8563ade6a17c74183745d72e]
stable/6.6: [6085291a1a5865d4ad70f0e5812d524ebd5d1711]

CVE-2025-39953: cgroup: split cgroup_destroy_wq into 3 workqueues

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39953

Introduced by commit 334c367 ("cgroup: reimplement rebind_subsystems()
using cgroup_apply_control() and friends") in v4.6-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79f919a89c9d06816dbdbbd168fa41d27411a7f9]
stable/5.10: [a0c896bda7077aa5005473e2c5b3c27173313b4c]
stable/5.15: [f2795d1b92506e3adf52a298f7181032a1525e04]
stable/5.4: [cabadd7fd15f97090f752fd22dd7f876a0dc3dc4]
stable/6.1: [993049c9b1355c78918344a6403427d53f9ee700]
stable/6.12: [ded4d207a3209a834b6831ceec7f39b934c74802]
stable/6.6: [4a1e3ec28e8062cd9f339aa6a942df9c5bcb6811]

CVE-2022-50509: media: coda: Add check for kmalloc

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50509

Introduced by commit cb1d3a3 ("[media] coda: add CODA7541 JPEG
support") in v3.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ba9cc9e2035f7a45f5222543265daf7cd51f2530]
cip/4.4-st: [7a10c3e7a97453eae55b8afc72d2c0f73af27cc3]
mainline: [6e5e5defdb8b0186312c2f855ace175aee6daf9b]
stable/5.10: [d9b37ea8869e4e6da90c07a310d819a78cbd23d2]
stable/5.15: [441c05485cf1a29eef05c1fd8281716815283315]
stable/5.4: [7a2c66429b04e85fee44d6d9f455327bf23cf49c]
stable/6.1: [0209e70ad496c1fcd85c2ec70e6736fd09f95d14]

CVE-2022-50510: perf/smmuv3: Fix hotplug callback leak in arm_smmu_pmu_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50510

Introduced by commit 7d839b4 ("perf/smmuv3: Add arm64 smmuv3 pmu
driver") in v5.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f2d566b46436a50a80d6445e82879686b89588c]
stable/5.10: [359286f886feef38536eaa7e673dc3440f03b0a1]
stable/5.15: [b131304fe722853cf26e55c4fa21fc58a36e7f21]
stable/5.4: [d69bdb61d577297d3851fc9f6403574bf73ef41f]
stable/6.1: [582babe17ea878ec1d76f30e03f3a6ce6e30eb91]

CVE-2022-50511: lib/fonts: fix undefined behavior in bit shift for
get_default_font

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50511

Introduced by commit c81f717 ("fbcon: Fix typo and bogus logic in
get_default_font") in v2.6.23-rc2.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fe888c4d2fb174408e4540bb2d5602b9f507f90]
stable/5.10: [c9a9aa02f0fa3318e0ae5774f404419a1b4759ca]
stable/5.15: [e83b47580a0738361772d6f24286adfdaba57e36]
stable/5.4: [e039929e36818507e90901edae87f6fa8bc81093]
stable/6.1: [890d91b31f4874361e0df047f57d268a7021cb12]

CVE-2022-50512: ext4: fix potential memory leak in ext4_fc_record_regions()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50512

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected code was added by 8016e29 ("ext4: fast commit recovery path")
in 5.10-rc1.

Fixed status
mainline: [7069d105c1f15c442b68af43f7fde784f3126739]
stable/5.10: [2cfb769d60a2a57eb3566765428b6131cd16dcfe]
stable/5.15: [417b0455a0b6d0f60a2930592731d1f8340e24be]

CVE-2022-50513: staging: rtl8723bs: fix a potential memory leak in
rtw_init_cmd_priv()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50513

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in 4.12-rc1.

Fixed status
mainline: [708056fba733a73d926772ea4ce9a42d240345da]
stable/5.10: [e6cc39db24a63f68314473621020ed8cad7be423]
stable/5.15: [39bef9c6a91bbb790d04c1347cfeae584541fb6a]
stable/5.4: [e5d8f05edb36fc4ab15beec62cb6ab62f5a60fe2]

CVE-2022-50514: usb: gadget: f_hid: fix refcount leak on error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50514

Introduced by commit 21a9476 ("usb: gadget: hid: add configfs
support") in v3.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [95412c932b3c9e8cc4431dac4fac8fcd80d54982]
mainline: [70a3288a7586526315105c699b687d78cd32559a]
stable/5.10: [e88b89a096af0001bcff6bf7ad2feb1486487173]
stable/5.15: [9d4a0aca8a75550d3456c8de339a341dc4536ec5]
stable/5.4: [80dc47e751a837106c09bec73964ff8f7ea280b4]
stable/6.1: [216437dd64fce36791a3b6cc8f8013df36856958]

CVE-2022-50515: drm/amdgpu: Fix memory leak in hpd_rx_irq_create_workqueue()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50515

Introduced by commit 8e79442 ("drm/amd/display: Fork thread to offload
work of hpd_rx_irq") in v5.16-rc1.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [7136f956c73c4ba50bfeb61653dfd6a9669ea915]
stable/5.15: [3ba3814c00a4817eb1cd31eff08d921c40e5f3a4]

CVE-2022-50516: fs: dlm: fix invalid derefence of sb_lvbptr

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50516

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [7175e131ebba47afef47e6ac4d5bab474d1e6e49]
stable/5.15: [ea7be82fd7e1f5de72208bce93fbbe6de6c13dec]

CVE-2022-50517: mm/huge_memory: do not clobber swp_entry_t during THP split

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50517

Introduced by commit b653db7 ("mm: Clear page->private when splitting
or migrating a page") in v5.19-rc4.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71e2d666ef85d51834d658830f823560c402b8b6]

CVE-2022-50518: parisc: Fix locking in pdc_iodc_print() firmware call

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50518

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [7236aae5f81f3efbd93d0601e74fc05994bc2580]
stable/6.1: [553bc5890ed96a8d006224c3a4673c47fee0d12a]

CVE-2022-50519: nilfs2: replace WARN_ONs by nilfs_error for checkpoint
acquisition failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50519

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [bf98be80cbe3b4e6c86c36ed00457389aca3eb15]
cip/4.4-st: [950e8d533ecbba42aaaf0087726f3cc306bef837]
mainline: [723ac751208f6d6540191689cfbf6c77135a7a1b]
stable/5.10: [8a18fdc5ae8e6d7ac33c6ee0a2e5f9f1414ef412]
stable/5.15: [c0c3d3d3ea41cb5228ee90568bb953f9a56c3227]
stable/5.4: [259c0f68168ac6a598db3486597b10e74d625db0]

CVE-2022-50520: drm/radeon: Fix PCI device refcount leak in
radeon_atrm_get_bios()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50520

Introduced by commit d8ade35 ("drm/radeon: handle non-VGA class pci
devices with ATRM") in v3.15-rc7.
Introduced by commit c61e277 ("drm/radeon: split ATRM support out from
the ATPX handler (v3)") in v3.6-rc3.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1079df6acf56f99d86b0081a38c84701412cc90e]
cip/4.4-st: [2b0344a8f07ac6e043eaa0734f8209f88d7e81e4]
mainline: [725a521a18734f65de05b8d353b5bd0d3ca4c37a]
stable/5.10: [3991d98a8a07b71c02f3a39f77d6d9a7f575a5c4]
stable/5.15: [88c6e0995c04b170563b5c894c50a3b2152e18c2]
stable/5.4: [470a77989037c3ab2b08bf2d026d2c0ddc35ff5b]
stable/6.1: [a6cffe54064a5f6c2162a85af3c16c6b453eac4e]

CVE-2022-50521: platform/x86: mxm-wmi: fix memleak in mxm_wmi_call_mx[ds|mx]()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50521

Introduced by commit 99b38b4 ("platform/x86: add MXM WMI driver.") in v3.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5b0f81b0808235967868e01336c976e840217108]
mainline: [727cc0147f5066e359aca65cc6cc5e6d64cc15d8]
stable/5.10: [17cd8c46cbec4e6ad593fb9159928b8e7608c11a]
stable/5.15: [3cf81501356c9e898ad94b2369ffc805f83f7d7b]
stable/5.4: [14bb4bde3b7b2584734b13747b345caeeb41bea3]
stable/6.1: [87426ce3bd57ad414b6e2436434ef8128986a9a5]

CVE-2022-50522: mcb: mcb-parse: fix error handing in chameleon_parse_gdd()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50522

Introduced by commit 3764e82 ("drivers: Introduce MEN Chameleon Bus")
in v3.15-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fd85ece416fd7edb945203e59d4cd94952f77e7c]
cip/4.4-st: [ce08554676fd20d2647284bc9bbae8322dc1f23b]
mainline: [728ac3389296caf68638628c987aeae6c8851e2d]
stable/5.10: [7b289b791a59386dc23a00d3cf17a0db984b40d3]
stable/5.15: [43bfc7c2402a22d3b4eb08c040f274ba2b76461a]
stable/5.4: [110dc34c9fa33d37f55b394b1199ea6c0ad1ee84]
stable/6.1: [4a9f1a8b3af287581ffb690d0e1593c681729ddb]

CVE-2022-50523: clk: rockchip: Fix memory leak in rockchip_clk_register_pll()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50523

Introduced by commit 90c5902 ("clk: rockchip: add clock type for pll
clocks and pll used on rk3066") in v3.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f02c1d8dc8d880cbaaf9094b4f396fe868ee23ff]
cip/4.4-st: [01d9377d63145f11e994545a29d40bf373d6c0a4]
mainline: [739a6a6bbdb793bd57938cb24aa5a6df89983546]
stable/5.10: [f4d70c139d313948e02360304a6cbcd3a4f5deb5]
stable/5.15: [5b0a1f1247cd42ac5e0d369f8dbb58762692edee]
stable/5.4: [26b94635f1c84d7f6cb482179125cb17e59c90a5]
stable/6.1: [f2ffb8653ea85ae39ce44347751fcc4c3e41f6bb]

CVE-2022-50524: iommu/mediatek: Check return value after calling
platform_get_resource()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50524

Introduced by commit 42d57fc ("iommu/mediatek: Initialise/Remove for
multi bank dev") in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73b6924cdebc899de9b719e1319aa86c6bed4acf]
stable/6.1: [feca904412483b2e0a903dd1f2e2843afd445f8c]

CVE-2022-50525: iommu/fsl_pamu: Fix resource leak in fsl_pamu_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50525

Introduced by commit 695093e ("iommu/fsl: Freescale PAMU driver and
iommu implementation.") in v3.12-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9fbccdf2fefa3944dd8ba8c6a808b387787f3917]
cip/4.4-st: [508024b2e16bdead8d2ff347c78f3f884ac559dc]
mainline: [73f5fc5f884ad0c5f7d57f66303af64f9f002526]
stable/5.10: [0d240ac0e4c35d3f64fc782c11433138c1bd016e]
stable/5.15: [e42b543d08052c3b223bcfb48f05cbaf0b767f86]
stable/5.4: [17fd440594961c5e2ea0f58591bc1bdba0629c75]
stable/6.1: [de7eb55009796687fc0a1670e0b944fa8ed54e9b]

CVE-2022-50526: drm/msm/dp: fix memory corruption with too many bridges

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50526

Introduced by commit 8a3b4c1 ("drm/msm/dp: employ bridge mechanism for
display enable and disable") in v5.17-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74466e46e7543c7f74f1502181e9ba93f7521374]

CVE-2022-50527: drm/amdgpu: Fix size validation for non-exclusive domains (v4)

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50527

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [7554886daa31eacc8e7fac9e15bbce67d10b8f1f]
stable/6.1: [8ba7c55e112f4ffd2a95b99be1cb1c891ef08ba1]

CVE-2022-50528: drm/amdkfd: Fix memory leakage

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50528

Introduced by commit d4ec4bd ("drm/amdkfd: Allow access for mmapping
KFD BOs") in v5.14-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75818afff631e1ea785a82c3e8bb82eb0dee539c]
stable/5.15: [8876793e56ec69b3be2a883b4bc440df3dbb1865]
stable/6.1: [c65564790048fa416ccd26a8945c7ec0cf9ef0b7]

CVE-2022-50529: test_firmware: fix memory leak in test_firmware_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50529

Introduced by commit c92316b ("test_firmware: add batched firmware
tests") in v4.14-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [04dd47a2e169f2d4489636afa07ff0469aab49ab]
mainline: [7610615e8cdb3f6f5bbd9d8e7a5d8a63e3cabf2e]
stable/5.10: [0b5a89e8bce1ea43687742b4de8e216189ff94ac]
stable/5.15: [357379d504c0c8b0834e206ad8c49e4b3c98ed4d]
stable/5.4: [628de998a3abfffb3f9677d2fb39a1d5dcb32fdb]
stable/6.1: [6dd5fbd243f19f087dc79481acb7d69fb57fea2c]

CVE-2022-50530: blk-mq: fix null pointer dereference in
blk_mq_clear_rq_mapping()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50530

Introduced by commit 63064be ("blk-mq: Add
blk_mq_alloc_map_and_rqs()") in v5.16-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76dd298094f484c6250ebd076fa53287477b2328]

CVE-2022-50531: tipc: fix an information leak in tipc_topsrv_kern_subscr

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50531

Introduced by commit 026321c ("tipc: rename tipc_server to
tipc_topsrv") in v4.17-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3d1b83ff7b6575a4e41283203e6b2e25ea700cd7]
mainline: [777ecaabd614d47c482a5c9031579e66da13989a]
stable/5.10: [e558e148938442dd49628cd7ef61c360832bef31]
stable/5.15: [dbc01c0a4e202a7e925dad1d4b7c1d6eb0c81154]
stable/5.4: [567f8de358b61015dcfb8878a1f06c5369a45f54]

CVE-2022-50532: scsi: mpt3sas: Fix possible resource leaks in
mpt3sas_transport_port_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50532

Introduced by commit f92363d ("[SCSI] mpt3sas: add new driver
supporting 12GB SAS") in v3.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78316e9dfc24906dd474630928ed1d3c562b568e]
stable/5.10: [ce1a69cc85006b494353911b35171da195d79e25]
stable/5.15: [6a92129c8f999ff5b122c100ce7f625eb3e98c4b]
stable/5.4: [d60000cb1195a464080b0efb4949daf7594e0020]
stable/6.1: [d17bca3ddfe507874cb826d32721552da12e741f]

CVE-2022-50533: wifi: mac80211: mlme: fix null-ptr deref on failed assoc

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50533

Introduced by commit 81151ce ("wifi: mac80211: support MLO
authentication/association with one link") in v6.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78a6a43aaf87180ec7425a2a90468e1b4d09a1ec]
stable/6.1: [bb7743955a929e44b308cc3f63f8cc03873c1bee]

CVE-2022-50534: dm thin: Use last transaction's pmd->root when commit failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50534

Introduced by commit 991d9fa ("dm: add thin provisioning target") in v3.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3db757ffdd87ed8d7118b2250236a496502a660f]
cip/4.4-st: [1c8b44bd9cf794fd7595d4417b359d3fc516d845]
mainline: [7991dbff6849f67e823b7cc0c15e5a90b0549b9f]
stable/5.10: [94f01ecc2aa0be992865acc80ebb6701f731f955]
stable/5.15: [4b710e8481ade7c9200e94d3018e99dc42a0a0e8]
stable/5.4: [f758987ff0af3a4b5ee69e95cab6a5294e4367b0]
stable/6.1: [b91f481300e3a10eaf66b94fc39b740928762aaf]

CVE-2022-50535: drm/amd/display: Fix potential null-deref in dm_resume

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50535

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected file was added by 4562236 ("drm/amd/dc: Add dc display driver
(v2)") in 4.15-rc1.

Fixed status
cip/4.19-st: [fd79b61af2782f8875c78f50cdb8630ec43e2990]
mainline: [7a7175a2cd84b7874bebbf8e59f134557a34161b]
stable/5.10: [9f73793b81637c60ccc83cc508645310b8ab7d80]
stable/5.15: [bb9a5562beb982aa5ebb73c521c49596ff8b8030]
stable/5.4: [d236103782de25736996a45bd36ac2a89bdc93c6]
stable/6.1: [8e365f1bd672cc9320a936f6ae6f8087aa40e9bc]

CVE-2022-50536: bpf, sockmap: Fix repeated calls to sock_put() when
msg has more_data

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50536

Introduced by commit cd9733f ("tcp_bpf: Fix one concurrency problem in
the tcp_bpf_send_verdict function") in v5.15.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [7a9841ca025275b5b0edfb0b618934abb6ceec15]
stable/5.10: [28e4a763cd4a2b1a78852216ef4bd7df3a05cec6]
stable/5.15: [8786bde11a4f31b63b3036731df0b47337a7a245]
stable/5.4: [7508b9f4daac4ec7dfe0b6fb2d688b1c1c105e10]
stable/6.1: [113236e8f49f262f318c00ebb14b15f4834e87c1]

CVE-2022-50537: firmware: raspberrypi: fix possible memory leak in
rpi_firmware_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50537

Introduced by commit 1e7c573 ("firmware: raspberrypi: Keep count of
all consumers") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [7b51161696e803fd5f9ad55b20a64c2df313f95c]
stable/5.10: [d34742245e4366579f9a80f8cfe4a63248e838e0]
stable/5.15: [b308fdedef095aac14569f810d46edf773ea7d1e]
stable/5.4: [62ac943eb2a9d655e431b9bc98ff6d7bd51a0e49]
stable/6.1: [71d2abab374f707ab8ac8dcef191fd2b3b67b8bd]

CVE-2022-50538: vme: Fix error not catched in fake_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50538

Introduced by commit 658bcda ("vme: Adding Fake VME driver") in v4.9-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [09be0e7ac5f9374b6f8de72c89ed67129af71f65]
mainline: [7bef797d707f1744f71156b21d41e3b8c946631f]
stable/5.10: [37d3de40c1ffb6a5e626bf46ff5ef5766c824e2c]
stable/5.15: [4bc217b25ea81034fad8e33fd33e4659f086421d]
stable/5.4: [f3f65c4177846c483bf009f8c512ab04b3c62466]
stable/6.1: [60ff9bd4ffc87bace581e235a6728f5ac8e5071f]

CVE-2022-50539: ARM: OMAP2+: omap4-common: Fix refcount leak bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50539

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by f746929 ("Revert \"ARM: OMAP4: remove dead
kconfig option OMAP4_ERRATA_I688\"") in 4.3-rc1.

Fixed status
mainline: [7c32919a378782c95c72bc028b5c30dfe8c11f82]
stable/6.1: [1d9452ae3bdb830f9309cf10a2f65977999cb14e]

CVE-2022-50540: dmaengine: qcom-adm: fix wrong sizeof config in slave_config

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50540

Introduced by commit 03de6b2 ("dmaengine: qcom-adm: stop abusing
slave_id config") in v5.17-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c8765308371be30f50c1b5b97618b731514b207]

CVE-2022-50541: dmaengine: ti: k3-udma: Reset UDMA_CHAN_RT byte
counters to prevent overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50541

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by 25dcb5d ("dmaengine: ti: New driver for K3
UDMA") in 5.6-rc1.

Fixed status
mainline: [7c94dcfa8fcff2dba53915f1dabfee49a3df8b88]
stable/5.15: [d68da10b0cceb4177b653833e794b2923a4ffbd7]

CVE-2022-50542: media: si470x: Fix use-after-free in si470x_int_in_callback()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50542

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [52f54fe78cca24850a30865037250f63eb3d5bf7]
cip/4.4-st: [87f6c0a70600b96a8002b2657aa9a80d94cc7e01]
mainline: [7d21e0b1b41b21d628bf2afce777727bd4479aa5]
stable/5.10: [1c6447d0fc68650e51586dde79b5090d9d77f13a]
stable/5.15: [6c8aee0c8fcc6dda94315f7908e8fa9bc75abe75]
stable/5.4: [0ca298d548461d29615f9a2b1309e8dcf4a352c6]
stable/6.1: [92b0888398e4ba51d93b618a6506781f4e3879c9]

CVE-2022-50543: RDMA/rxe: Fix mr->map double free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50543

Introduced by commit 1e75550 ("Revert "RDMA/rxe: Create duplicate
mapping tables for FMRs"") in v6.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d984dac8f6bf4ebd3398af82b357e1d181ecaac]
stable/6.1: [06f73568f553b5be6ba7f6fe274d333ea29fc46d]

CVE-2022-50544: usb: host: xhci: Fix potential memory leak in
xhci_alloc_stream_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50544

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [ddab9fe76296840aad686c66888a9c1dfdbff5ff]
cip/4.4-st: [3dd65440639247f0be78ac76ed2dd4a784aac98b]
mainline: [7e271f42a5cc3768cd2622b929ba66859ae21f97]
stable/5.10: [91271a3e772e180bbb8afb114c72fd294a02f93d]
stable/5.15: [fcd594da0b5955119d9707e4e0a8d0fb1c969101]
stable/5.4: [9fa81cbd2dd300aa8fe9bac70e068b9a11cbb144]

CVE-2022-50545: r6040: Fix kmemleak in probe and remove

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50545

Introduced by commit 3831861 ("r6040: implement phylib") in v2.6.36-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2ce242e1b9ad31c1f68496b3548e407a8cb2c07d]
cip/4.4-st: [409857266ce315136831c755195036024b52d94d]
mainline: [7e43039a49c2da45edc1d9d7c9ede4003ab45a5f]
stable/5.10: [3d5f83a62e8235d235534b3dc6f197d8a822c269]
stable/5.15: [9b5b50329e2e966831a7237dd6949e7b5362a49a]
stable/5.4: [b0a61359026b57a287a48fbb4ba1d097023eca3e]
stable/6.1: [5944c25c67de54e0aa53623e1e1af3bf8b16ed44]

CVE-2022-50546: ext4: fix uninititialized value in 'ext4_evict_inode'

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50546

Introduced by commit 6bc0d63 ("ext4: remove EA inode entry from
mbcache on inode eviction") in v6.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [f0bffdcc7cb14598af2aa706f1e0f2a9054154ba]
mainline: [7ea71af94eaaaf6d9aed24bc94a05b977a741cb9]
stable/5.10: [091f85db4c3fb1734a6d7fb4777a2b2831da6631]
stable/5.15: [3c31d8d3ad95aef8cc17a4fcf317e46217148439]
stable/5.4: [e431b4fb1fb8c2654b808086e9747a000adb9655]
stable/6.1: [9f966e021c20caae639dd0e404c8761e8281a2c4]

CVE-2022-50547: media: solo6x10: fix possible memory leak in solo_sysfs_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50547

Introduced by commit dcae5da ("[media] solo6x10: sync to latest code
from Bluecherry's git repo") in v3.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [963729538674be4cb8fa292529ecf32de0d6c6dd]
cip/4.4-st: [93f6b55f59398963bd90d43005e29122421a1500]
mainline: [7f5866dd96d95b74e439f6ee17b8abd8195179fb]
stable/5.10: [49060c0da57a381563e482e331dc9d4c3725b41b]
stable/5.15: [7cf71bbe5d2ee12613f6e278888f5fc9c5c0cc2b]
stable/5.4: [7b02c50d3978840781808e13bc13137fb81286b5]
stable/6.1: [9416861170ba0da8ddb0f4fd2d28334f0ed3b9c2]

CVE-2022-50548: media: i2c: hi846: Fix memory leak in hi846_parse_dt()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50548

Introduced by commit e8c0882 ("media: i2c: add driver for the SK Hynix
Hi-846 8M pixel camera") in v5.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80113026d415e27483669db7a88b548d1ec3d3d1]
stable/6.1: [4368730678412a8fa71960dbda81e122dafa70f7]

CVE-2022-50549: dm thin: Fix ABBA deadlock between shrink_slab and
dm_pool_abort_metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50549

Introduced by commit e49e582 ("dm thin: add read only and fail io
modes") in v3.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8111964f1b8524c4bb56b02cd9c7a37725ea21fd]
stable/5.10: [7e37578069737b04955c71dd85db8a3bc2709eff]
stable/5.15: [f8c26c33fef588ee54852cffa7cbb9f9d9869405]
stable/5.4: [200aa33b5d781e7c0fa6c0c7db9dbcc3f574ce8f]
stable/6.1: [cdf7a39bcc427febbfe3c3b9fe829825ead96c27]

CVE-2022-50550: blk-iolatency: Fix memory leak on add_disk() failures

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50550

Introduced by commit d706751 ("block: introduce blk-iolatency io
controller") in v4.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [813e693023ba10da9e75067780f8378465bf27cc]
stable/6.1: [215f9437dda09531bcb80605298a24219f01cec5]

CVE-2022-50551: wifi: brcmfmac: Fix potential shift-out-of-bounds in
brcmf_fw_alloc_request()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50551

Introduced commit is not determined.Fixed in v6.2-rc1.
Afected function was added by 2baa3aa ("brcmfmac: introduce
brcmf_fw_alloc_request() function") in 4.17-rc1.

Fixed status
cip/4.19-st: [9d2f70fa2c7cc6c73a420ff15682454782d3d6f6]
mainline: [81d17f6f3331f03c8eafdacea68ab773426c1e3c]
stable/5.10: [87792567d9ed93fd336d2c3b8d7870f44e141e6d]
stable/5.15: [0b12d2aa264bac35bff9b5399bb162262b2b8949]
stable/5.4: [5b06a8a25eba07628313aa3c5496522eff97be53]
stable/6.1: [ffb589963df103caaf062081a32db0b9e1798660]

CVE-2022-50552: blk-mq: use quiesced elevator switch when reinitializing queues

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50552

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected functions were added by d48ece2 ("blk-mq: init hctx sched
after update ctx and hctx mapping") in 4.19-rc1.

Fixed status
mainline: [8237c01f1696bc53c470493bf1fe092a107648a6]

CVE-2022-50553: tracing/hist: Fix out-of-bound write on
'action_data.var_ref_idx'

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50553

Introduced by commit d380dcd ("tracing: Fix now invalid var_ref_vals
assumption in trace action") in v5.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [82470f7d9044842618c847a7166de2b7458157a7]
stable/5.10: [0cb31bd88361edb96cfc622648717ba348f0f4dc]
stable/5.15: [15697f653399253f9be4ed2a1e03d795f3cfee94]
stable/5.4: [cf79d5410a569dad1d4112b5c3c02383cca8213a]
stable/6.1: [04241956ce8825ff06e06e4083e7b692e9d5f712]

CVE-2022-50554: blk-mq: avoid double ->queue_rq() because of early timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50554

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [82c229476b8f6afd7e09bc4dc77d89dc19ff7688]
stable/6.1: [8b3d6b029a552d2978bbac275303d11419826a69]

CVE-2022-50555: tipc: fix a null-ptr-deref in tipc_topsrv_accept

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50555

Introduced by commit 0ef897b ("tipc: separate topology server listener
socket from subcsriber sockets") in v4.17-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ce69bdac2310152bb70845024d5d704c52aabfc3]
mainline: [82cb4e4612c633a9ce320e1773114875604a3cce]
stable/5.10: [32a3d4660b34ce49ac0162338ebe362098e2f5df]
stable/5.15: [7a939503fc32bff4ed60800b73ff7fbb4aea2142]
stable/5.4: [24b129aed8730e48f47d852d58d76825ab6f407c]

CVE-2023-53617: soc: aspeed: socinfo: Add kfree for kstrdup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53617

Introduced by commit e0218dc ("soc: aspeed: Add soc info driver") in v5.11-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e6d847a8ce18ab2fbec4f579f682486a82d2c6b]
stable/5.15: [dfb9676ed25be25ca7cd198d0f0e093b76b7bc7f]
stable/6.1: [b662856b71343d9e731c1cd4bbe54758c7791abb]

CVE-2023-53618: btrfs: reject invalid reloc tree root keys with stack dump

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53618

Introduced commit is not determined.Fixed in v6.5-rc6.


Fixed status
mainline: [6ebcd021c92b8e4b904552e4d87283032100796d]
stable/5.15: [314135b7bae9618a317874ae195272682cf2d5d4]
stable/6.1: [3ae93b316ca4b8b3c33798ef1d210355f2fb9318]

CVE-2023-53619: netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53619

Introduced by commit 12f7a50 ("netfilter: add user-space connection
tracking helper infrastructure") in v3.6-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [00716f25f9697d02a0d9bd622575c7c7321ba3d0]
mainline: [6eef7a2b933885a17679eb8ed0796ddf0ee5309b]
stable/5.10: [8289d422f5e484efe4a565fe18e862ecd621c175]
stable/5.15: [6f03ce2f1abcb9f9d0511e3659ca6eb60e39f566]
stable/5.4: [61c7a5256543ae7d24cd9d21853d514c8632e1e9]
stable/6.1: [05561f822f27b9fa88fa5504ddec34bf38833034]

CVE-2023-53620: md: fix soft lockup in status_resync

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53620

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [6efddf1e32e2a264694766ca485a4f5e04ee82a7]
stable/6.1: [b4acb6c3ede88d6b7d33742a09e63cfce5e7fb69]

CVE-2023-53621: memcontrol: ensure memcg acquired by id is properly set up

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53621

Introduced by commit f78dfc7 ("workingset: fix confusion around
eviction vs refault container") in v6.3-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f0df8e16eb543167f2929cb756e695709a3551d]

CVE-2023-53622: gfs2: Fix possible data races in gfs2_show_options()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53622

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [235a5ae73cea29109a3e06f100493f17857e6a93]
cip/4.4-st: [f40eabf2f1636c5f4f766dcc374a11735d4b3039]
mainline: [6fa0a72cbbe45db4ed967a51f9e6f4e3afe61d20]
stable/5.10: [7c5b2649f6a37d45bfb7abf34c9b71d08677139f]
stable/5.15: [85e888150075cb221270b64bf772341fc6bd11d9]
stable/5.4: [b4a7ab57effbed42624842f2ab2a49b177c21a47]
stable/6.1: [a4f71523ed2123d63b431cc0cea4e9f363a0f054]

CVE-2023-53623: mm/swap: fix swap_info_struct race between swapoff and
get_swap_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53623

Introduced by commit a2468cc ("swap: choose swap device according to
numa node") in v4.14-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a55f268abdb74ac5633b75a09fefb58458e9d2a2]
mainline: [6fe7d6b992113719e96744d974212df3fcddc76c]
stable/5.10: [ea8c42b3b6d95ced3a4f555f04686d00ef0bb206]
stable/5.15: [4bdf1514b4268d29360ba9e43becdd49955bc7ae]
stable/5.4: [e7bba7ddb4318d5ea939c8db747c2c2780ab66f4]
stable/6.1: [85cc118ce6f1a627901b6db50c9d01f2ad78cdbf]

CVE-2023-53624: net/sched: sch_fq: fix integer overflow of "credit"

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53624

Introduced by commit afe4fd0 ("pkt_sched: fq: Fair Queue packet
scheduler") in v3.12-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7041101ff6c3073fd8f2e99920f535b111c929cb]
stable/5.10: [4b8a05e3801661a0438fcd0cdef181030d966a5a]
stable/5.15: [d0b43125ec892aeb1b03e5df5aab595097da225a]
stable/6.1: [4fbefeab88c6e79753a25099d455d3d59d2946b4]

CVE-2023-53625: drm/i915/gvt: fix vgpu debugfs clean in remove

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53625

Introduced by commit bc7b0be ("drm/i915/gvt: Add basic debugfs
infrastructure") in v4.16-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [704f3384f322b40ba24d958473edfb1c9750c8fd]
stable/5.10: [af90f8b36d78544433a48a3eda6a5faeafacd0a1]
stable/5.15: [f5a9bbf962e2c4b1d9addbfaf16d7ffcc2f63bde]
stable/6.1: [44c0e07e3972e3f2609d69ad873d4f342f8a68ec]

CVE-2023-53626: ext4: fix possible double unlock when moving a directory

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53626

Introduced by commit 0813299 ("ext4: Fix possible corruption when
moving a directory") in v6.3-rc1.
Fixed in v6.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [70e42feab2e20618ddd0cbfc4ab4b08628236ecd]
stable/5.10: [020166bc6669ca9fb267ebd96bd88c4fb64a5d46]
stable/5.15: [1c93c42c7bb23057bde8a0a2ab834927ff64d20c]
stable/5.4: [c16cbd8233d6c58fc488545393e49b5d55729990]
stable/6.1: [e71eb4dca41f0f36823724ced0406bb2dbdd5506]

CVE-2023-53627: scsi: hisi_sas: Grab sas_dev lock when traversing the
members of sas_dev.list

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53627

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected driver was added by e8899fa ("hisi_sas: Add initial bare main
driver") in 4.5-rc1.

Fixed status
mainline: [71fb36b5ff113a7674710b9d6063241eada84ff7]

CVE-2023-53628: drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53628

Introduced commit is not determined.Fixed in v6.4-rc2.
The gfx_v11_0.c was added by 3d879e8 ("drm/amdgpu: add init support
for GFX11 (v2)") in 5.19-rc1.

Fixed status
mainline: [720b47229a5b24061d1c2e29ddb6043a59178d79]
stable/6.1: [7b5a8a23acbc3ee50b23602b61db1563561faf84]

CVE-2023-53629: fs: dlm: fix use after free in midcomms commit

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53629

Introduced by commit 489d8e5 ("fs: dlm: add reliable connection if
reconnect") in v5.14-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [724b6bab0d75f1dc01fdfbf7fe8d4217a5cb90ba]
stable/6.1: [a3b0e9ac3c2447008db942d51f593841d8329e99]

CVE-2023-53630: iommufd: Fix unpinning of pages when an access is present

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53630

Introduced by commit 8d160cd ("iommufd: Algorithms for PFN storage")
in v6.2-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [727c28c1cef2bc013d2c8bb6c50e410a3882a04e]

CVE-2023-53631: platform/x86: dell-sysman: Fix reference leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53631

Introduced by commit e8a60aa ("platform/x86: Introduce support for
Systems Management Driver over WMI for Dell Systems") in v5.11-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7295a996fdab7bf83dc3d4078fa8b139b8e0a1bf]
stable/5.15: [d079a3e1ccdd183b75db4f5289be347980b45284]
stable/6.1: [6ced15ff1746006476f1407fe722911a45a7874d]

CVE-2023-53632: net/mlx5e: Take RTNL lock when needed before calling
xdp_set_features()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53632

Introduced by commit 4d5ab0a ("net/mlx5e: take into account device
reconfiguration for xdp_features flag") in v6.3-rc3.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72cc654970658e88a1cdea08f06b11c218efa4da]

CVE-2023-53633: accel/qaic: Fix a leak in map_user_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53633

Introduced by commit 129776a ("accel/qaic: Add control path") in v6.4-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73274c33d961f4aa0f968f763e2c9f4210b4f4a3]

CVE-2023-53634: bpf, arm64: Fixed a BTI error on returning to patched function

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53634

Introduced by commit efc9909 ("bpf, arm64: Add bpf trampoline for
arm64") in v6.0-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [738a96c4a8c36950803fdd27e7c30aca92dccefd]
stable/6.1: [8b9c64942ada229f52fe6f1b537a50f88b3c2673]

CVE-2023-53635: netfilter: conntrack: fix wrong ct->timeout value

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53635

Introduced by commit a4b4766 ("netfilter: nfnetlink_queue: rename
related to nfqueue attaching conntrack info") in v4.4-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73db1b8f2bb6725b7391e85aab41fdf592b3c0c1]
stable/6.1: [80c5ba0078e20d926d11d0778f9a43902664ebf0]

CVE-2023-53636: clk: microchip: fix potential UAF in auxdev release callback

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53636

Introduced by commit b56bae2 ("clk: microchip: mpfs: add reset
controller") in v6.1-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7455b7007b9e93bcc2bc9c1c6c73a228e3152069]
stable/6.1: [5b4052aa956e11bcd19e50ca559eb38dcb46201b]

CVE-2023-53637: media: i2c: ov772x: Fix memleak in ov772x_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53637

Introduced by commit 1112bab ("media: i2c: Copy ov772x soc_camera
sensor driver") in v4.17-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cc3b6011d7a9f149489eb9420c6305a779162c57]
mainline: [7485edb2b6ca5960205c0a49bedfd09bba30e521]
stable/5.10: [dfaafeb8e9537969e8dba75491f732478c7fa9d6]
stable/5.15: [1da495101ef7507eb4f4b1dbec2874d740eff251]
stable/5.4: [448ce1cd50387b1345ec14eb191ef05f7afc2a26]
stable/6.1: [ac93f8ac66e60227bed42d5a023f0e6c15b52c0a]

CVE-2023-53638: octeon_ep: cancel queued works in probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53638

Introduced by commit 24d4333 ("octeon_ep: poll for control messages")
in v6.4-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [758c91078165ae641b698750a72eafe7968b3756]

CVE-2023-53639: wifi: ath6kl: reduce WARN to dev_dbg() in callback

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53639

Introduced by commit de2070f ("ath6kl: Fix kernel panic on continuous
driver load/unload") in v3.9-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e7865f84adaf75cee1a4bbf79680329eca92b4e1]
cip/4.4-st: [8102fa741f8269fda5379c888b79ac067fc2f0c6]
mainline: [75c4a8154cb6c7239fb55d5550f481f6765fb83c]
stable/5.10: [1300517e371e4d0acdb0f1237477e1ed223c3a9a]
stable/5.15: [484d95c69fc1143f09e4c2e3b89019d68d190a92]
stable/5.4: [0d1792c98351b7c8ebdc53d052918e77d1e512c3]
stable/6.1: [644df7e865e76ab7a62c67c25cbbc093c944d0ef]

CVE-2023-53640: ASoC: lpass: Fix for KASAN use_after_free out of bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53640

Introduced commit is not determined.Fixed in v6.4-rc4.
Affected function was added by d207bde ("ASoC: codecs: lpass-tx-macro:
add dapm widgets and route") in 5.12-rc1-dontuse.

Fixed status
mainline: [75e5fab7db0cecb6e16b22c34608f0b40a4c7cd1]
stable/5.15: [8f1512d78b5de928f4616a871e77b58fd546e651]
stable/6.1: [8d81d3b0ed3610d24191d24f8e9e20f6775f0cc5]

CVE-2023-53641: wifi: ath9k: hif_usb: fix memory leak of remain_skbs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53641

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6719e3797ec52cd144c8a5ba8aaab36674800585]
mainline: [7654cc03eb699297130b693ec34e25f77b17c947]
stable/5.10: [320d760a35273aa815d58b57e4fd9ba5279a3489]
stable/5.15: [59073060fe0950c6ecbe12bdc06469dcac62128d]
stable/5.4: [d9899318660791141ea6002fda5577b2c5d7386e]
stable/6.1: [9b9356a3014123f0ce4b50d9278c1265173150ab]

CVE-2023-53643: nvme-tcp: don't access released socket during error recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53643

Introduced by commit 02c57a8 ("nvme-tcp: print actual source IP
address through sysfs "address" attr") in v6.1-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76d54bf20cdcc1ed7569a89885e09636e9a8d71d]
stable/6.1: [fe2d9e54165dadaa0d0cc3355c0be9c3e129fa0d]

CVE-2023-53644: media: radio-shark: Add endpoint checks

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53644

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [afd72825b4fcb7ae4015e1c93b054f4c37a25684]
cip/4.4-st: [4747aa8767e2237789872b86987bea1bfea72b50]
mainline: [76e31045ba030e94e72105c01b2e98f543d175ac]
stable/5.10: [8a30dce9d7f70f8438956f6a01142b926c301334]
stable/5.15: [b1bde4b4360c3d8a35504443efabd3243b802805]
stable/5.4: [2b580d0f03c4fc00013cd08f9ed96b87a08fd0d9]
stable/6.1: [53764a17f5d8f0d00b13297d06b5e65fa844288b]

CVE-2023-53645: bpf: Make bpf_refcount_acquire fallible for non-owning refs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53645

Introduced by commit d2dcc67 ("bpf: Migrate bpf_rbtree_add and
bpf_list_push_{front,back} to possibly fail") in v6.4-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7793fc3babe9fea908e57f7c187ea819f9fd7e95]

CVE-2023-53646: drm/i915/perf: add sentinel to xehp_oa_b_counters

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53646

Introduced by commit 0fa9349 ("drm/i915/perf: complete programming
whitelisting for XEHPSDV") in v6.2-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [785b3f667b4bf98804cad135005e964df0c750de]

CVE-2023-53647: Drivers: hv: vmbus: Don't dereference ACPI root object handle

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53647

Introduced by commit 7f163a6 ("drivers:hv: Modify hv_vmbus to search
for all MMIO ranges available.") in v4.3-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78e04bbff849b51b56f5925b1945db2c6e128b61]
stable/6.1: [96db43aced395844a7abc9a0a5cc702513e3534a]

CVE-2023-53648: ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53648

Introduced by commit da3cec3 ("ALSA: Kill snd_assert() in
sound/pci/*") in v2.6.28-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e4cccff1e7ab6ea30995b6fbbb007d02647e025c]
cip/4.4-st: [2b2a1195e18d64e3a83121c9c628268d2233584e]
mainline: [79597c8bf64ca99eab385115743131d260339da5]
stable/5.10: [f923a582217b198b557756809ffe42ac0fad6adb]
stable/5.15: [300e26e3e64880de5013eac8831cf44387ef752c]
stable/5.4: [5f13d67027fa782096e6aee0db5dce61c4aeb613]
stable/6.1: [d28b83252e150155b8b8c65b612c555e93c8b45f]

CVE-2023-53649: perf trace: Really free the evsel->priv area

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53649

Introduced by commit 3cb4d5e ("perf trace: Free syscall tp fields in
evsel->priv") in v5.14-rc2.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7962ef13651a9163f07b530607392ea123482e8a]
stable/5.15: [c3bc668581e71e7c3bc7eb1d647f25f8db222163]
stable/6.1: [62dd514c34be63d3d5cae1f52a7e8b96c6dd6630]

CVE-2023-53650: fbdev: omapfb: lcd_mipid: Fix an error handling path
in mipid_spi_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53650

Introduced by commit 66d2f99 ("omapfb: add support for MIPI-DCS
compatible LCDs") in v2.6.32-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7a8f9293bee51183023c5e37e7ebf0543cd2a134]
cip/4.4-st: [7dac53d49468f60218730ed743fb38d907a52282]
mainline: [79a3908d1ea6c35157a6d907b1a9d8ec06015e7a]
stable/5.10: [ce6e0434e502abdf966164b7c72523fb5fe54635]
stable/5.15: [716efd08985e3104031d1b655930b1f1c45fa8a7]
stable/5.4: [9e3858f82e3ced1e990ef7116c3a16c84e62093e]
stable/6.1: [3b4c21804076e461a6453ee4d09872172336aa1d]

CVE-2023-53651: Input: exc3000 - properly stop timer on shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53651

Introduced by commit 7e577a1 ("Input: add I2C attached EETI EXC3000
multi touch driver") in v4.15-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79c81d137d36f9635bbcbc3916c0cccb418a61dd]
stable/6.1: [526a177ac6353d65057eadb5d6edafc168f64484]

CVE-2023-53652: vdpa: Add features attr to vdpa_nl_policy for nlattr
length check

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53652

Introduced by commit 90fea5a ("vdpa: device feature provisioning") in v6.1-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79c8651587504ba263d2fd67fd4406240fb21f69]
stable/6.1: [44b508cc96889e61799cc0fc6c00766a54f3ab5a]

CVE-2023-53653: media: amphion: fix REVERSE_INULL issues reported by coverity

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53653

Introduced by commit 9f599f3 ("media: amphion: add vpu core driver")
in v5.18-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79d3bafaecc13bccab1ebbd28a15e669c5a4cdaf]
stable/6.1: [bddd678fd2864b435d00d51a4d3808a0d89c79de]

CVE-2023-53654: octeontx2-af: Add validation before accessing cgx and lmac

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53654

Introduced by commit 91c6945 ("octeontx2-af: cn10k: Add RPM MAC
support") in v5.12-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79ebb53772c95d3a6ae51b3c65f9985fdd430df6]
stable/5.15: [e425e2ba933618ee5ec8e4f3eb341efeb6c9ddef]
stable/6.1: [a5485a943193e55c79150382e6461e8ea759e96e]

CVE-2023-53655: rcu: Avoid stack overflow due to
__rcu_irq_enter_check_tick() being kprobe-ed

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53655

Introduced by commit aaf2bc5 ("rcu: Abstract out
rcu_irq_enter_check_tick() from rcu_nmi_enter()") in v5.8-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a29fb4a4771124bc61de397dbfc1554dbbcc19c]
stable/5.10: [eb18bc5a8678f431c500e6da1b8b5f34478d5bc1]
stable/5.15: [4c3d1a6720aefb02403ddfebe85db521d3af2c3b]
stable/6.1: [c8a3341b339285495cf7c8d061d659465f2311e0]

CVE-2023-53656: drivers/perf: hisi: Don't migrate perf to the CPU
going to teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53656

Introduced by commit 8404b0f ("drivers/perf: hisi: Add driver for
HiSilicon PCIe PMU") in v5.17-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a6a9f1c5a0a875a421db798d4b2ee022dc1ee1a]
stable/6.1: [be9c8c9c84b6d25a7b7d39954030aba6f759feb6]

CVE-2023-53657: ice: Don't tx before switchdev is fully configured

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53657

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected code was added by f5396b8 ("ice: switchdev slow path") in 5.16-rc1.

Fixed status
mainline: [7aa529a69e92b9aff585e569d5003f7c15d8d60b]
stable/6.1: [5760a72b3060150b587eff3e879648c7470efddd]

CVE-2023-53658: spi: bcm-qspi: return error if neither hif_mspi nor
mspi is available

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53658

Introduced by commit fa236a7 ("spi: bcm-qspi: Add Broadcom MSPI
driver") in v4.9-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d20db3c58a7f9361e370a7850ceb60dbdf62eea3]
mainline: [7c1f23ad34fcdace50275a6aa1e1969b41c6233f]
stable/5.10: [32b9c8f7892c19f7f5c9fed5fb410b9fd5990bb6]
stable/5.15: [217b6ea8cf7b819477bca597a6ae2d43d38ba283]
stable/5.4: [398e6a015877d44327f754aeb48ff3354945c78c]
stable/6.1: [d3dcdb43c872a3b967345144151a2c9bb9124c9b]

CVE-2023-53659: iavf: Fix out-of-bounds when setting channels on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53659

Introduced by commit 4e5e6b5 ("iavf: Fix return of set the new channel
count") in v5.16-rc2.
Fixed in v6.5-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [7c4bced3caa749ce468b0c5de711c98476b23a52]
stable/5.10: [b92defe4e8ee86996c16417ad8c804cb4395fddd]
stable/5.15: [0fb37ce6c01e17839e26d03222f0b44e6a3ed2b9]
stable/6.1: [6e1d8f1332076a002e6d910d255aa5903d341c56]

CVE-2023-53660: bpf, cpumap: Handle skb as well when clean up ptr_ring

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53660

Introduced by commit 11941f8 ("bpf: cpumap: Implement generic cpumap")
in v5.15-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c62b75cd1a792e14b037fa4f61f9b18914e7de1]
stable/5.15: [b58d34068fd9f96bfc7d389988dfaf9a92a8fe00]
stable/6.1: [cbd000451885801e9bbfd9cf7a7946806a85cb5e]

CVE-2023-53661: bnxt: avoid overflow in bnxt_get_nvram_directory()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53661

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected code was added by c0c050c ("bnxt_en: New Broadcom ethernet
driver.") in 4.4-rc1.

Fixed status
mainline: [7c6dddc239abe660598c49ec95ea0ed6399a4b2a]
stable/5.15: [d5eaf2a6b077f32a477feb1e9e1c1f60605b460e]
stable/6.1: [efb1a257513438d43f4335f09b2f684e8167cad2]

CVE-2023-53662: ext4: fix memory leaks in
ext4_fname_{setup_filename,prepare_lookup}

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53662

Introduced by commit 1ae98e2 ("ext4: optimize match for casefolded
encrypted dirs") in v5.13-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ca4b085f430f3774c3838b3da569ceccd6a0177]
stable/6.1: [1fb3f1bbfdb511034b0360dbeb0f6a8424ed2a5c]

CVE-2023-53663: KVM: nSVM: Check instead of asserting on nested TSC
scaling support

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53663

Introduced by commit 5228eb9 ("KVM: x86: nSVM: implement nested TSC
scaling") in v5.16-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cafe9b8e22bb3d77f130c461aedf6868c4aaf58]
stable/6.1: [6c1ecfea1daf6e75c46e295aad99dfbafd878897]

CVE-2023-53664: OPP: Fix potential null ptr dereference in
dev_pm_opp_get_required_pstate()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53664

Introduced by commit 84cb7ff ("OPP: pstate is only valid for genpd OPP
tables") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ddd8deb1c3c0363a7e14fafb5df26e2089a69a5]

CVE-2023-53665: md: don't dereference mddev after export_rdev()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53665

Introduced by commit 3ce94ce ("md: fix duplicate filename for rdev")
in v6.5-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7deac114be5fb25a4e865212ed0feaf5f85f2a28]

CVE-2023-53666: ASoC: codecs: wcd938x: fix missing mbhc init error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53666

Introduced by commit bcee7ed ("ASoC: codecs: wcd938x: add Multi Button
Headset Control support") in v5.15-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dfae2631bfbdebecd35fe7b472ab3cc95c9ed66]
stable/5.15: [5a34d252052b5da743ef82591c860fc947384d4e]
stable/6.1: [bb241ae928c694e365c30c888c9eb02dcc812dfd]

CVE-2023-53667: net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53667

Introduced by commit 289507d ("net: cdc_ncm: use sysfs for rx/tx
aggregation tuning") in v3.16-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bf415bfe7573596ac213b4fd1da9e62cfc9a9413]
mainline: [7e01c7f7046efc2c7c192c3619db43292b98e997]
stable/5.10: [42b78c8cc774b47023d6d16d96d54cc7015e4a07]
stable/5.15: [9be921854e983a81a0aeeae5febcd87093086e46]
stable/5.4: [ff484163dfb61b58f23e4dbd007de1094427669c]
stable/6.1: [6147745d43ff4e0d2c542e5b93e398ef0ee4db00]

CVE-2023-53668: ring-buffer: Fix deadloop issue on reading trace_pipe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53668

Introduced by commit a5fb833 ("ring-buffer: Fix uninitialized
read_stamp") in v3.6-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a55e8a3596048c2f7b574049aeb1885b5abba1cc]
cip/4.4-st: [e1e1022a56a4099059a604d2833df73702119211]
mainline: [7e42907f3a7b4ce3a2d1757f6d78336984daf8f5]
stable/5.10: [5e68f1f3a20fe9b6bde018e353269fbfa289609c]
stable/5.15: [bb14a93bccc92766b1d9302c6bcbea17d4bce306]
stable/5.4: [e84829522fc72bb43556b31575731de0440ac0dd]
stable/6.1: [8b0b63fdac6b70a45614e7d4b30e5bbb93deb007]

CVE-2023-53669: tcp: fix skb_copy_ubufs() vs BIG TCP

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53669

Introduced by commit 7c4e983 ("net: allow gso_max_size to exceed
65536") in v5.19-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e692df3933628d974acb9f5b334d2b3e885e2a6]
stable/6.1: [7fa93e39fbb0566019c388a8038a4d58552e0910]

CVE-2023-53670: nvme-core: fix dev_pm_qos memleak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53670

Introduced by commit f50fff7 ("nvme: implement In-Band
authentication") in v6.0-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ed5cf8e6d9bfb6a78d0471317edff14f0f2b4dd]
stable/6.1: [e1379e067b9485e5af03399fe3f0d39bccb023ad]

CVE-2023-53671: srcu: Delegate work to the boot cpu if using SRCU_SIZE_SMALL

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53671

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected file was added by dad81a2 ("srcu: Introduce CLASSIC_SRCU
Kconfig option") in 4.12-rc1.

Fixed status
mainline: [7f24626d6dd844bfc6d1f492d214d29c86d02550]
stable/6.1: [2c4d26dad76eadaa45a24543e311e9ce5d09f04e]

CVE-2023-53672: btrfs: output extra debug info if we failed to find an
inline backref

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53672

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [400e08a16604b534fdd82c5a288fa150d04f5f79]
mainline: [7f72f50547b7af4ddf985b07fc56600a4deba281]
stable/5.10: [b7c3cf2f6c42e6688b1c37215a0b1663f982f915]
stable/5.15: [6994f806c6d1ae8b59344d3700358547f3b3fe1d]
stable/5.4: [7afbfde45d665953b4d5a42a721e15bf0315d89b]
stable/6.1: [28062cd6eda04035d8f6ded2001292ac8b496149]

CVE-2023-53673: Bluetooth: hci_event: call disconnect callback before
deleting conn

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53673

Introduced by commit b8d2905 ("Bluetooth: clean up connection in
hci_cs_disconnect") in v5.7-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f7cfcb6f0825652973b780f248603e23f16ee90]
stable/6.1: [59bd1e476bbc7bc6dff3c61bba787095a4839796]

CVE-2023-53674: clk: Fix memory leak in devm_clk_notifier_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53674

Introduced by commit 6d30d50 ("clk: add devm variant of
clk_notifier_register") in v5.11-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fb933e56f77a57ef7cfc59fc34cbbf1b1fa31ff]
stable/5.15: [a326cf0107b197e649bbaa2a2b1355894826ce32]
stable/6.1: [49451db71b746df990888068961f1033f7c9b734]

CVE-2023-53675: scsi: ses: Fix possible desc_ptr out-of-bounds accesses

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53675

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [cffe09ca0555e235a42d6fa065e463c4b3d5b657]
cip/4.4-st: [41290f5253a21fcbc19e1bc548bb62753dfb2414]
mainline: [801ab13d50cf3d26170ee073ea8bb4eececb76ab]
stable/5.10: [c315560e3ef77c1d822249f1743e647dc9c9912a]
stable/5.15: [584892fd29a41ef424a148118a3103b16b94fb8c]
stable/5.4: [79ec5dd5fb07ecaea2f978c2d7a9f2f3526e4d19]
stable/6.1: [414418abc19fa4ccf730d273061a426c07a061d6]

CVE-2023-53676: scsi: target: iscsi: Fix buffer overflow in
lio_target_nacl_info_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53676

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [114b44dddea1f8f99576de3c0e6e9059012002fc]
cip/4.4-st: [fa337a4d227e6eaf8a2047e550bbd32d46c47fd6]
mainline: [801f287c93ff95582b0a2d2163f12870a2f076d4]
stable/5.10: [bbe3ff47bf09db8956bc2eeb49d2d514d256ad2a]
stable/5.15: [5353df78c22623b42a71d51226d228a8413097e2]
stable/5.4: [2cbe6a88fbdd6e8aeab358eef61472e2de43d6f6]
stable/6.1: [4738bf8b2d3635c2944b81b2a84d97b8c8b0978d]

CVE-2023-53677: drm/i915: Fix memory leaks in i915 selftests

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53677

Introduced by commit c3bfba9 ("drm/i915: Check for integer truncation
on scatterlist creation") in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [803033c148f754f32da1b93926c49c22731ec485]

CVE-2023-53678: drm/i915: Fix system suspend without fbdev being initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53678

Introduced by commit f8cc091 ("drm/i915/fbdev: suspend HPD before
fbdev unregistration") in v6.1-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8038510b1fe443ffbc0e356db5f47cbb8678a594]
stable/6.1: [27b5871abd5cc068c549fd23062c82e257fc0b9c]

CVE-2023-53679: wifi: mt7601u: fix an integer underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53679

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected driver was added by c869f77 ("add mt7601u driver") in 4.2-rc1.

Fixed status
mainline: [803f3176c5df3b5582c27ea690f204abb60b19b9]
stable/5.10: [47dc1f425af57b71111d7b01ebd24e04e8d967ef]
stable/5.15: [1a1f43059afae5cc9409e0c3bc63bfc09bc8facb]
stable/5.4: [67e4519afba215199b6dfa39ce5d7ea673ee4138]
stable/6.1: [61d0163e2be7a439cf6f82e9ad7de563ecf41e7a]

CVE-2023-53680: NFSD: Avoid calling OPDESC() with ops->opnum == OP_ILLEGAL

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53680

Introduced by commit f4f9ef4 ("nfsd4: opdesc will be useful outside
nfs4proc.c") in v4.14-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [804d8e0a6e54427268790472781e03bc243f4ee3]
stable/5.10: [50827896c365e0f6c8b55ed56d444dafd87c92c5]
stable/5.15: [a64160124d5a078be0c380b1e8a0bad2d040d3a1]
stable/6.1: [ffcbcf087581ae68ddc0a21460f7ecd4315bdd0e]

CVE-2023-53681: bcache: Fix __bch_btree_node_alloc to make the failure
behavior consistent

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53681

Introduced by commit cafe563 ("bcache: A block layer cache") in v3.10-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [587b4e8bb5dac682f09280ab35db4632b29d5ac4]
mainline: [80fca8a10b604afad6c14213fdfd816c4eda3ee4]
stable/5.10: [a4405f6ee03323410d7b10966fd67b35f71b1944]
stable/5.15: [f67b0e3081f2a24170280a33ac66f6b112083c03]
stable/5.4: [b070f29a61436f6f8a2e3abc7ea4f4be81695198]
stable/6.1: [7ecea5ce3dc17339c280c75b58ac93d8c8620d9f]

CVE-2023-53682: hwmon: (xgene) Fix ioremap and memremap leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53682

Introduced commit is not determined.Fixed in v6.3-rc4.
Affected file was added by ed42cfa ("hwmon: Add xgene hwmon driver") in 4.9-rc1.

Fixed status
mainline: [813cc94c7847ae4a17e9f744fb4dbdf7df6bd732]
stable/6.1: [9d482a09acd3d5f61a56aefc125d32c81994707b]

CVE-2023-53683: fs: hfsplus: remove WARN_ON() from
hfsplus_cat_{read,write}_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53683

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [c074913b12db3632b11588b31bbfb0fa80a0a1c9]
cip/4.4-st: [9438d2dc517cd0dbf3e9d02a0e872efee444fdd9]
mainline: [81b21c0f0138ff5a499eafc3eb0578ad2a99622c]
stable/5.10: [c8daee66585897a4c90d937c91e762100237bff9]
stable/5.15: [37cab61a52d6f42b2d961c51bcf369f09e235fb5]
stable/5.4: [a75d9211a07fed513c08c5d4861c4a36ac6a74fe]
stable/6.1: [48960a503fcec76d3f72347b7e679dda08ca43be]

CVE-2023-53684: xfrm: Zero padding when dumping algos and encap

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53684

Introduced commit is not determined.Fixed in v6.3-rc3.


Fixed status
mainline: [8222d5910dae08213b6d9d4bc9a7f8502855e624]
stable/5.15: [0725daaa9a879388ed312110f62dbd5ea2d75f8f]
stable/6.1: [5218af4ad5d8948faac19f71583bcd786c3852df]

CVE-2023-53685: tun: Fix memory leak for detached NAPI queue.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53685

Introduced by commit cde8b15 ("tuntap: add ioctl to attach or detach a
file form tuntap device") in v3.8-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82b2bc279467c875ec36f8ef820f00997c2a4e8e]
stable/6.1: [9cae243b9ae25adfe468cd47ceca591f6725b79c]

CVE-2023-53686: net/handshake: fix null-ptr-deref in handshake_nl_done_doit()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53686

Introduced by commit 3b3009e ("net/handshake: Create a NETLINK service
for handling handshake requests") in v6.4-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82ba0ff7bf0483d962e592017bef659ae022d754]

CVE-2023-53687: tty: serial: samsung_tty: Fix a memory leak in
s3c24xx_serial_getclk() when iterating clk

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53687

Introduced by commit 5f5a7a5 ("serial: samsung: switch to clkdev based
clock lookup") in v3.3-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [01dd8a43a84616c830782166ba3cceb01ad95363]
cip/4.4-st: [c8a98d35e08937783989e49572e5d5b386a1faac]
mainline: [832e231cff476102e8204a9e7bddfe5c6154a375]
stable/5.10: [1962717c4649e026a4252fe6625175affd28a593]
stable/5.15: [9dd8091959bc41fee51d0827276a2b982e84adf0]
stable/5.4: [46574e5a0a2aee41e6ebb979cfe1dbaea8693e16]
stable/6.1: [f0bf102ef9b05d7294bd8d506755465f6867d944]

* Updated CVEs

CVE-2025-21861: mm/migrate_device: don't add folio to be freed to LRU
in migrate_device_finalize()

stable/5.10, stable/5.15, stable/5.4, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [64397b0cb7c09e3ef3f9f5c7c17299c4eebd3875]
stable/5.15: [4f52f7c50f5b6f5eeb06823e21fe546d90f9c595]
stable/5.4: [61fa824e304ed162fe965f64999068e6fcff2059]
stable/6.1: [20fb6fc51863fbff7868de8b5f6d249d2094df1f]
stable/6.6: [78f579cb7d825134e071a1714d8d0c4fd0ffe459]

CVE-2025-23143: net: Fix null-ptr-deref by
sock_lock_init_class_and_name() and rmmod.

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [b7489b753667bc9245958a4896c9419743083c27]
stable/5.15: [d51e47e2ab6ef10a317d576075cf625cdbf96426]
stable/5.4: [83083c5fc7cf9b0f136a42f26aba60da380f3601]

CVE-2025-38236: af_unix: Don't leave consecutive consumed OOB skbs.

stable/5.15 was fixed.

Fixed status
stable/5.15: [523edfed4f68b7794d85b9ac828c5f8f4442e4c5]

CVE-2025-39869: dmaengine: ti: edma: Fix memory allocation size for
queue_priority_map

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d722de80ce037dccf6931e778f4a46499d51bdf9]
stable/5.15: [301a96cc4dc006c9a285913d301e681cfbf7edb6]
stable/5.4: [7d4de60d6db02d9b01d5890d5156b04fad65d07a]

CVE-2025-39873: can: xilinx_can: xcan_write_frame(): fix
use-after-free of transmitted SKB

stable/5.15 was fixed.

Fixed status
stable/5.15: [e202ffd9e54538ef67ec301ebd6d9da4823466c9]

CVE-2025-39876: net: fec: Fix possible NPD in
fec_enet_phy_reset_after_clk_enable()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [20a3433d31c2d2bf70ab0abec75f3136b42ae66c]
stable/5.15: [93a699d6e92cfdfa9eb9dbb8c653b5322542ca4f]
stable/5.4: [8c60d12bba14dc655d2d948b1dbf390b3ae39cb8]

CVE-2025-39880: libceph: fix invalid accesses to ceph_connection_v1_info

stable/5.15 was fixed.

Fixed status
stable/5.15: [ea12ab684f8ae8a6da11a22c78d94a79e2163096]

CVE-2025-39883: mm/memory-failure: fix
VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [fb65803ccff37cf9123c50c1c02efd1ed73c4ed5]
stable/5.15: [99f7048957f5ae3cee1c01189147e73a9a96de02]
stable/5.4: [8e01ea186a52c90694c08a9ff57bea1b0e78256a]

CVE-2025-39885: ocfs2: fix recursive semaphore deadlock in fiemap call

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [7e1514bd44ef68007703c752c99ff7319f35bce6]
stable/5.15: [ef30404980e4c832ef9bba1b10c08f67fa77a9ec]
stable/5.4: [16e518ca84dfe860c20a62f3615e14e8af0ace57]

CVE-2025-39907: mtd: rawnand: stm32_fmc2: avoid overlapping mappings
on ECC buffer

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [dfe2ac47a6ee0ab50393694517c54ef1e276dda3]
stable/5.15: [e32a2ea52b51368774d014e5bcd9b86110a2b727]
stable/5.4: [dc1c6e60993b93b87604eb11266ac72e1a3be9e0]

CVE-2025-39911: i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [6e4016c0dca53afc71e3b99e24252b63417395df]
stable/5.15: [b9721a023df38cf44a88f2739b4cf51efd051f85]
stable/5.4: [13ab9adef3cd386511c930a9660ae06595007f89]

CVE-2025-39913: tcp_bpf: Call sk_msg_free() when
tcp_bpf_send_verdict() fails to allocate psock->cork.

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [05366527f44cf4b884f3d9462ae8009be9665856]
stable/5.15: [7429b8b9bfbc276fd304fbaebc405f46b421fedf]
stable/5.4: [08f58d10f5abf11d297cc910754922498c921f91]

CVE-2025-39923: dmaengine: qcom: bam_dma: Fix DT error handling for
num-channels/ees

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [1d98ba204d8a6db0d986c7f1aefaa0dcd1c007a2]
stable/5.15: [6ac1599d0e78036d9d08efc2f58c2d91f0a3ee4c]
stable/5.4: [2e257a6125c63350f00dc42b9674f20fd3cf4a9f]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

