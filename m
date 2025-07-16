Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7281C83F1B
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 22:23:39 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.35188.1752704613063846950
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Jul 2025 15:23:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=TO9wGDa0;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710e344bbf9so2686997b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 16 Jul 2025 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1752704612; x=1753309412; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oo7XNH4aa1ENcm+zaCSaeCT1DDKNhYCBx5GUzEAGU2M=;
        b=TO9wGDa08ZtuoTLjJDFISmkUG/IGXHWpoSAWfqAN+UJom3imn5Lr+C4X7Wdd2efbAQ
         WicT/kB4kbjdmOrgzR6uYLi7N1O82GjLzATl7A28dLm5tnG3WbCRYld/Sx5U5thmxbHq
         VaYmO7FEL3DT7epSAuUlqS03Hb+MGfR6jRzj9DDqu+GkDektlP6eAEH9BFcXp56JAGkL
         UHjgmv3QFvPHgQAhxCvM69f5bWcEjkFg9GXwKn1oLfmlc/t6SBcZoyMnZu7kJPaERV6T
         zeS1WY9ThymRZPack567+Gnhi8sfre6z8ePykmpnkFcGv4LztyC/8xcGdntXlI03r3Wq
         9ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752704612; x=1753309412;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oo7XNH4aa1ENcm+zaCSaeCT1DDKNhYCBx5GUzEAGU2M=;
        b=xMWhTCOPsSFu3LGJtjzK4wj1yHH0XeSAhyidSwkRWmPQWGj5FhB9R6sctCxT2v6D87
         qPU4VWmJWE8WqXnXx8ztOSlCOUJRgGJSRjyLBTxIyFA5Z+Rbqf/1HuaA8rRYu8joNjKq
         YJL1TuYzn+P/w8ZtSsYcS/svN9jfEcVaQHw4wgAs0GKnsEl/pUE/cVBOiaWC6lXkT5A4
         JoeIh8Ok1hVLDTvPverA8AphQa1Ebyky+e+lwAMeTgZdSUmnm1NPBA5H1H4BChUvAa35
         CV8KyvEwg07MpYjnP3S+lYe/NcmYasOwZXMtNw/KXRMGNrZcPLrJiXrYUKAI5ZodnEmI
         kIdw==
X-Gm-Message-State: AOJu0Yzpg8y+AAsRloVN7U1CmaYybTUer6yurMCBOrehop84xqgN+fr9
	4JSjP9Pcld0WqZxEHqf4O34/w4wJcaoCylX3xly0fulgGrDW/FRYvGUl22p/XwYPzIEI5N1OAg8
	8xlxBlefirLQ++pM6a5NZqTR9EjWNHgieCk5VZikZfXgBhenXqOWD1CA=
X-Gm-Gg: ASbGncvYgzliPV0SCREo49+6gsFjynyckDadY+qRyalvyMfU3Lv0bha7LzkPnnY8wcT
	XOFX7Fw8b+BLHyN+qhaZTHyCbd1h7g5rCAhYgz4fd/uN63d9kIEqh3Kex5Fc+R4eL+9h32tSwo5
	bYhov/X/YO1i0fr5txYfkVKhoupY3rtCjVMA/1YVg9ccTnUVD7rstPL95tkvNcumxprFLTGUVEM
	DDq1RJO
X-Google-Smtp-Source: AGHT+IFP3i702rRUhdeqhbJem9qRwyPIEkcjBXEfa889ubV6vH+qVqolThAa9x0iK8DhXP7kxMl4vCnkSQRpUoB7DiA=
X-Received: by 2002:a05:690c:a085:10b0:718:38bd:bb3d with SMTP id
 00721157ae682-71838bdcfa1mr37697527b3.40.1752704610850; Wed, 16 Jul 2025
 15:23:30 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Jul 2025 07:22:54 +0900
X-Gm-Features: Ac12FXw9MYamWyLxLvS7i1siMA084YTZQybU-kAKKaPuhmsmyzlIVcAkscTQZeY
Message-ID: <CAODzB9q=151eaXFEnbwOVdzb1LW1ttmBBAOtDJ+xS-+6pt_zUg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Jul 2025 22:23:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19550

Hi!

It's this week's CVE report.

This week reported 84 new CVEs and 16 updated CVEs.

* New CVEs

CVE-2025-38265: serial: jsm: fix NPE during jsm_uart_port_init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38265

Introduced by commit 84a9582 ("serial: core: Start managing serial
controllers to enable runtime PM") in v6.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3975aa899c0a3bbc10d035e699b142cd1373a71]
stable/6.12: [985961dd2688a527a4847300d41beaad475ab7af]
stable/6.6: [3258d7ff8ebfa451426662b23e8f2b51b129afe1]

CVE-2025-38266: pinctrl: mediatek: eint: Fix invalid pointer
dereference for v1 platforms

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38266

Introduced by commit 3ef9f71 ("pinctrl: mediatek: Add EINT support for
multiple addresses") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c9977b263475373b31bbf86af94a5c9ae2be42c]

CVE-2025-38267: ring-buffer: Do not trigger WARN_ON() due to a commit_overrun

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38267

Introduced by commit fe832be ("ring-buffer: Have mmapped ring buffer
keep track of missed events") in v6.10-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fc78a7c9ca994e1da5d3940704d4e8f0ea8c5e4]
stable/6.12: [b8df8cb8f7eef52baa9ac5bf36a405ca67945a91]

CVE-2025-38268: usb: typec: tcpm: move tcpm_queue_vdm_unlocked to
asynchronous work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38268

Introduced by commit cdc9946 ("usb: typec: tcpm: enforce ready state
when queueing alt mode vdm") in v6.9-rc7.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [324d45e53f1a36c88bc649dc39e0c8300a41be0a]
stable/6.12: [7bdd712abefbec79176ab412d8c623e755c5d0ba]

CVE-2025-38269: btrfs: exit after state insertion failure at
btrfs_convert_extent_bit()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38269

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
It seems as if all LTS kernels are affected.

Fixed status
mainline: [3bf179e36da917c5d9bec71c714573ed1649b7c1]
stable/6.12: [58c50f45e1821a04d61b62514f9bd34afe67c622]

CVE-2025-38270: net: drv: netdevsim: don't napi_complete() from netpoll

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38270

Introduced by commit 3762ec0 ("netdevsim: add NAPI support") in v6.10-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1264971017b4d7141352a7fe29021bdfce5d885d]
stable/6.12: [a8ff2e362d901200a1075c3ca9c56d9c7bbef389]

CVE-2025-38271: net: prevent a NULL deref in rtnl_create_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38271

Introduced by commit 7e4d784 ("net: hold netdev instance lock during
rtnetlink operations") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [feafc73f3e6ae73371777a037d41d2e31c929636]

CVE-2025-38272: net: dsa: b53: do not enable EEE on bcm63xx

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38272

Introduced by commit 22256b0 ("net: dsa: b53: Move EEE functions to
b53") in v4.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1237c2d4a8db79dfd4369bff6930b0e385ed7d5c]

CVE-2025-38273: net: tipc: fix refcount warning in tipc_aead_encrypt

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38273

Introduced by commit e279024 ("net/tipc: fix slab-use-after-free Read
in tipc_aead_encrypt_done") in v6.15.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [f29ccaa07cf3d35990f4d25028cc55470d29372b]
stable/5.10: [445d59025d76d0638b03110f8791d5b89ed5162d]
stable/5.15: [e0b11227c4e8eb4bdf1b86aa8f0f3abb24e0f029]
stable/6.1: [307391e8fe70401a6d39ecc9978e13c2c0cdf81f]
stable/6.12: [c762fc79d710d676b793f9d98b1414efe6eb51e6]
stable/6.6: [acab7ca5ff19889b80a8ee7dec220ee1a96dede9]

CVE-2025-38274: fpga: fix potential null pointer deref in
fpga_mgr_test_img_load_sgt()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38274

Introduced by commit ccbc1c3 ("fpga: add an initial KUnit suite for
the FPGA Manager") in v6.6-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ebf1982038af12f3588417e4fd0417d2551da28]
stable/6.12: [8b2230ac7ff0aeb2441132df638a82ab124f8624]
stable/6.6: [e69e2cfd8b38d9463a250e153ef4963a604d61e9]

CVE-2025-38275: phy: qcom-qmp-usb: Fix an NULL vs IS_ERR() bug

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38275

Introduced by commit a5d6b1a ("phy: qcom-qmp-usb: fix memleak on probe
deferral") in v6.1-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d14402a38c2d868cacb1facaf9be908ca6558e59]
stable/6.1: [0b979a409e40457ca1b5cb48755d1f34eee58805]
stable/6.12: [5072c1749197fc28b27d7efc0d80320d7cac9572]
stable/6.6: [127dfb4f1c5a2b622039c5d203f321380ea36665]

CVE-2025-38276: fs/dax: Fix "don't skip locked entries when scanning entries"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38276

Introduced by commit 6be3e21 ("fs/dax: don't skip locked entries when
scanning entries") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd59137bfe70cf3646021b4721e430213b9c71bd]

CVE-2025-38277: mtd: nand: ecc-mxic: Fix use of uninitialized variable ret

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38277

Introduced by commit 48e6633 ("mtd: nand: mxic-ecc: Add Macronix
external ECC engine support") in v5.18-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d95846350aac72303036a70c4cdc69ae314aa26d]
stable/6.1: [4d9d6e4be09472aa72953caca3dbefdc27846170]
stable/6.12: [7a23cc510ecaabab4f6df7e9d910d16e279b72ad]
stable/6.6: [a0d9d9b5a4634e146ae41cb25667322e5c7d74d2]

CVE-2025-38278: octeontx2-pf: QOS: Refactor TC_HTB_LEAF_DEL_LAST callback

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38278

Introduced by commit 5e6808b ("octeontx2-pf: Add support for HTB
offload") in v6.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67af4ec948e8ce3ea53a9cf614d01fddf172e56d]
stable/6.12: [ec62c99914a79d84c8de5ba1b94d62f2ed721f2a]
stable/6.6: [5df8db01d6a4e9c35a5ba5d7e130d5cecd3ffcb4]

CVE-2025-38279: bpf: Do not include stack ptr register in precision
backtracking bookkeeping

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38279

Introduced by commit 407958a ("bpf: encapsulate precision backtracking
bookkeeping") in v6.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2d2115e56c4a02377189bfc3a9a7933552a7b0f]
stable/6.12: [4265682c29c92f52c0da6fad5a79b5801462c8de]

CVE-2025-38280: bpf: Avoid __bpf_prog_ret0_warn when jit fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38280

Introduced by commit fa9dd59 ("bpf: get rid of pure_initcall
dependency to enable jits") in v4.16-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86bc9c742426a16b52a10ef61f5b721aecca2344]
stable/5.15: [e7fb4ebee6e900899d2b2e5852c3e2eafcbcad66]
stable/6.1: [ef92b96530d1731d9ac167bc7c193c683cd78fff]
stable/6.12: [2bc6dffb4b72d53d6a6ada510269bf548c3f7ae0]
stable/6.6: [6f639c25bfad17d9fd7379ab91ff9678ea9aac85]

CVE-2025-38281: wifi: mt76: mt7996: Add NULL check in mt7996_thermal_init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38281

Introduced by commit 69d54ce ("wifi: mt76: mt7996: switch to single
multi-radio wiphy") in v6.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [caf4b347c5dc40fdd125793b5e82ba9fc4de5275]

CVE-2025-38282: kernfs: Relax constraint in draining guard

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38282

Introduced by commit bdb2fd7 ("kernfs: Skip kernfs_drain_open_files()
more aggressively") in v6.1-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [071d8e4c2a3b0999a9b822e2eb8854784a350f8a]
stable/6.1: [2d6a67c2b3b87808a347dc1047b520a9dd177a4f]
stable/6.12: [6bfb154f95d5f0ab7ed056f23aba8c1a94cb3927]
stable/6.6: [6c81f1c7812c61f187bed1b938f1d2e391d503ab]

CVE-2025-38283: hisi_acc_vfio_pci: bugfix live migration function
without VF device driver

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38283

Introduced by commit b0eed08 ("hisi_acc_vfio_pci: Add support for VFIO
live migration") in v5.18-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2777a40998deb36f96b6afc48bd397cf58a4edf0]
stable/6.12: [59a834592dd200969fdf3c61be1cb0615c647e45]
stable/6.6: [b5ef128926cd34dffa2a66607b9c82b902581ef8]

CVE-2025-38284: wifi: rtw89: pci: configure manual DAC mode via PCI
config API only

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38284

Introduced by commit 1fd4b3f ("wifi: rtw89: pci: support 36-bit PCI
DMA address") in v6.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a70cf04b08f44f41bce14659aa7012674b15d9de]

CVE-2025-38285: bpf: Fix WARN() in get_bpf_raw_tp_regs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38285

Introduced by commit 9594dc3 ("bpf: fix nested bpf tracepoints with
per-cpu data") in v5.2-rc6.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [3880cdbed1c4607e378f58fa924c5d6df900d1d3]
stable/5.10: [147ea936fc6fa8fe0c93f0df918803a5375ca535]
stable/5.15: [ee90be48edb3dac612e0b7f5332482a9e8be2696]
stable/5.4: [44ebe361abb322d2afd77930fa767a99f271c4d1]
stable/6.1: [e167414beabb1e941fe563a96becc98627d5bdf6]
stable/6.12: [c98cdf6795a36bca163ebb40411fef1687b9eb13]
stable/6.6: [6d8f39875a10a194051c3eaefebc7ac06a34aaf3]

CVE-2025-38286: pinctrl: at91: Fix possible out-of-boundary access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38286

Introduced by commit 6732ae5 ("ARM: at91: add pinctrl support") in v3.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [762ef7d1e6eefad9896560bfcb9bcf7f1b6df9c1]
stable/5.10: [db5665cbfd766db7d8cd0e5fd6e3c0b412916774]
stable/5.15: [2ecafe59668d2506a68459a9d169ebe41a147a41]
stable/5.4: [264a5cf0c422e65c94447a1ebebfac7c92690670]
stable/6.1: [f1c1fdc41fbf7e308ced9c86f3f66345a3f6f478]
stable/6.12: [e02e12d6a7ab76c83849a4122785650dc7edef65]
stable/6.6: [eb435bc4c74acbb286cec773deac13d117d3ef39]

CVE-2025-38287: IB/cm: Drop lockdep assert and WARN when freeing old msg

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38287

Introduced by commit 1e51592 ("IB/cm: Do not hold reference on cm_id
unless needed") in v6.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7590649ee7af381a9d1153143026dec124c5798e]

CVE-2025-38288: scsi: smartpqi: Fix smp_processor_id() call trace for
preemptible kernels

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38288

Introduced by commit 283dcc1 ("scsi: smartpqi: add counter for parity
write stream requests") in v6.12-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42d033cf4b517e91c187ad2fbd7b30fdc6d2d62c]
stable/6.12: [6589bc3699bcb45b35b3095c44a5af7a4d75ef7e]

CVE-2025-38289: scsi: lpfc: Avoid potential ndlp use-after-free in
dev_loss_tmo_callbk

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38289

Introduced by commit 4281f44 ("scsi: lpfc: Prevent NDLP reference
count underflow in dev_loss_tmo callback") in v6.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [b5162bb6aa1ec04dff4509b025883524b6d7e7ca]
stable/6.12: [ea405fb4144985d5c60f49c2abd9ba47ea44fdb4]

CVE-2025-38290: wifi: ath12k: fix node corruption in ar->arvifs list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38290

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [823435bd23108d6f8be89ea2d025c0e2e3769c51]
stable/6.12: [6285516170f9e2f04b9dbf1e5100e0d7cbac22b4]
stable/6.6: [be049199dec9189602bc06e2c70eda3aa0f2ea6e]

CVE-2025-38291: wifi: ath12k: Prevent sending WMI commands to firmware
during firmware crash

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38291

Introduced by commit a9b46dd ("wifi: ath12k: Add firmware coredump
collection support") in v6.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9e094a9734ea3bd4d4d117c915ccf129ac61ba1]

CVE-2025-38292: wifi: ath12k: fix invalid access to memory

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38292

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f17747fbda6fca934854463873c4abf8061491d]
stable/6.12: [371b340affa52f280f6eadfd25fbd43f09f0d5c0]

CVE-2025-38293: wifi: ath11k: fix node corruption in ar->arvifs list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38293

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31e98e277ae47f56632e4d663b1d4fd12ba33ea8]
stable/5.10: [6c139015b597e570dd5962934e9f9a2f4cc8ef48]
stable/5.15: [f9507cf2dd0e1ed5028c0e8240da6fe5fd3110d3]
stable/6.1: [b0974ed82e6ad5ff246fd90a5b14f3e7be4f2924]
stable/6.12: [f5d77d0d41ea7a204d47288d0cf0404a52b5890e]
stable/6.6: [f50ba7e7b607f2d00618799312e7fdb76a1ff48e]

CVE-2025-38294: wifi: ath12k: fix NULL access in assign channel context handler

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38294

Introduced by commit 90570ba ("wifi: ath12k: do not return invalid
link id for scan link") in v6.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea24531d00f782f4e659e8c74578b7ac144720ca]

CVE-2025-38295: perf/amlogic: Replace smp_processor_id() with
raw_smp_processor_id() in meson_ddr_pmu_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38295

Introduced by commit 2016e21 ("perf/amlogic: Add support for Amlogic
meson G12 SoC DDR PMU driver") in v6.2-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [097469a2b0f12b91b4f27b9e9e4f2c46484cde30]
stable/6.12: [b038ffbd49e41f99228dbb0c66d6dd7b20292884]
stable/6.6: [77511c2d2d1cbce8d9b4f50849843dd469d14173]

CVE-2025-38296: ACPI: platform_profile: Avoid initializing on non-ACPI platforms

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38296

Introduced by commit 77be5ca ("ACPI: platform_profile: Create class
for ACPI platform profile") in v6.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd133162c9cff5951a692fab9811fadf46a46457]

CVE-2025-38297: PM: EM: Fix potential division-by-zero error in
em_compute_costs()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38297

Introduced by commit 1b600da ("PM: EM: Optimize em_cpu_energy() and
remove division") in v6.9-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [179c0c7044a378198adb36f2a12410ab68cc730a]
stable/6.12: [81d72f9241d884ec29524431f74f8009310cfa0c]

CVE-2025-38298: EDAC/skx_common: Fix general protection fault

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38298

Introduced by commit 123b158 ("EDAC, i10nm: make skx_common.o a
separate module") in v6.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [20d2d476b3ae18041be423671a8637ed5ffd6958]
stable/5.10: [a6ed3a6edff09c1187cc6ade7f5967bca2376a13]
stable/5.15: [bf6a8502a5f4ff6e4d135d795945cdade49ec8b0]
stable/5.4: [80bf28fd623d97dd4f4825fbbe9d736cec2afba3]
stable/6.1: [e8530ed3c0769a4d8f79c212715ec1cf277787f8]
stable/6.12: [a13e8343ffcff27af1ff79597ff7ba241e6d9471]
stable/6.6: [3f5d0659000923735350da60ad710f8c804544fe]

CVE-2025-38299: ASoC: mediatek: mt8195: Set ETDM1/2 IN/OUT to COMP_DUMMY()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38299

Introduced by commit e70b8dd ("ASoC: mediatek: mt8195: Remove afe-dai
component and rework codec link") in v6.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7af317f7faaab09d5a78f24605057d11f5955115]
stable/6.12: [87dbfe2b392df9621f6e522e5fa6fb8849ca92ab]

CVE-2025-38300: crypto: sun8i-ce-cipher - fix error handling in
sun8i_ce_cipher_prepare()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38300

Introduced by commit 06f751b ("crypto: allwinner - Add sun8i-ce Crypto
Engine") in v5.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f31adc3e356f7350d4a4d68c98d3f60f2f6e26b3]
stable/6.1: [a0ac3f85b2e3ef529e852f252a70311f9029d5e6]
stable/6.12: [19d267d9fad00d94ad8477899e38ed7c11f33fb6]
stable/6.6: [c62b79c1c51303dbcb6edfa4de0ee176f4934c52]

CVE-2025-38301: nvmem: zynqmp_nvmem: unbreak driver after cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38301

Introduced by commit 29be47f ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe
cleanup") in v6.9-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe8abdd175d7b547ae1a612757e7902bcd62e9cf]
stable/6.12: [c8bb1bcea877446f86922a8fd1661b8c07d90e5c]

CVE-2025-38302: block: don't use submit_bio_noacct_nocheck in
blk_zone_wplug_bio_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38302

Introduced by commit 9b1ce7f ("block: Implement zone append
emulation") in v6.10-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf625013d8741c01407bbb4a60c111b61b9fa69d]
stable/6.12: [0fccb6773b1f4f992e435582cf8e050de421b678]

CVE-2025-38303: Bluetooth: eir: Fix possible crashes on eir_create_adv_data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38303

Introduced by commit 01ce70b ("Bluetooth: eir: Move EIR/Adv Data
functions to its own file") in v5.16-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47c03902269aff377f959dc3fd94a9733aa31d6e]
stable/6.12: [2af40d795d3fb0ee5c074b7ac56ab22402aa6e4f]

CVE-2025-38304: Bluetooth: Fix NULL pointer deference on eir_get_service_data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38304

Introduced by commit 8f9ae5b ("Bluetooth: eir: Add helpers for
managing service data") in v5.19-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20a2aa01f5aeb6daad9aeaa7c33dd512c58d81eb]
stable/6.1: [497c9d2d7d3983826bb02c10fb4a5818be6550fb]
stable/6.12: [842f7c3154d5b25ca11753c02ee8cf6ee64c0142]
stable/6.6: [4bf29910570666e668a60d953f8da78e95bb7fa2]

CVE-2025-38305: ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38305

Introduced by commit 73f3706 ("ptp: support ptp physical/virtual
clocks conversion") in v5.14-rc2.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87f7ce260a3c838b49e1dc1ceedf1006795157a2]
stable/5.15: [5d217e7031a5c06d366580fc6ddbf43527b780d4]
stable/6.1: [b1b73c452331451020be3bf4b014901015ae6663]
stable/6.12: [b93e6fef4eda48e17d9c642b9abad98a066fd4a3]
stable/6.6: [259119595227fd20f6aa29d85abe086b6fdd9eb1]

CVE-2025-38306: fs/fhandle.c: fix a race in call of has_locked_children()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38306

Introduced by commit 620c266 ("fhandle: relax open_by_handle_at()
permission checks") in v6.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f282cdc1d219c4a557f7009e81bc792820d9d9a]

CVE-2025-38307: ASoC: Intel: avs: Verify content returned by parse_int_array()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38307

Introduced by commit 5a565ba ("ASoC: Intel: avs: Probing and firmware
tracing over debugfs") in v6.2-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93e246b6769bdacb09cfff4ea0f00fe5ab4f0d7a]
stable/6.12: [18ff538aac63de1866e5a49d57e22788b5c21d12]
stable/6.6: [cc03c899e6d9812b25c3754c9a95c3830c4aec26]

CVE-2025-38308: ASoC: Intel: avs: Fix possible null-ptr-deref when initing hw

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38308

Introduced by commit f2f8474 ("ASoC: Intel: avs: Constrain path based
on BE capabilities") in v6.15-rc3.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f78724d4f0c665c83e202e3989d5333a2cb1036]

CVE-2025-38309: drm/xe/vm: move xe_svm_init() earlier

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38309

Introduced by commit 6fd979c ("drm/xe: Add SVM init / close / fini to
faulting VMs") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cf8cde41ad01150afbd1327ad1942387787f7fd]

CVE-2025-38310: seg6: Fix validation of nexthop addresses

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38310

Introduced by commit d1df6fd ("ipv6: sr: define core operations for
seg6local lightweight tunnel") in v4.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7632fedb266d93ed0ed9f487133e6c6314a9b2d1]
stable/5.15: [668923c474608dd9ebce0fbcc41bd8a27aa73dd6]
stable/6.1: [cef33a86bcb04ecf4dc10c56f6c42ee9d1c54bac]
stable/6.12: [d5d9fd13bc19a3f9f2a951c5b6e934d84205789e]
stable/6.6: [d2507aeea45b3c5aa24d5daae0cf3db76895c0b7]

CVE-2025-38311: iavf: get rid of the crit lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38311

Introduced by commit d1639a1 ("iavf: fix a deadlock caused by rtnl and
driver's lock circular dependencies") in v6.5-rc3.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [120f28a6f314fef7f282c99f196923fe44081cad]

CVE-2025-38312: fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38312

Introduced by commit 96fe6a2 ("[PATCH] fbdev: Add VESA Coordinated
Video Timings (CVT) support") in v2.6.20.16.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f6dae09fc8c306eb70fdfef70726e1f154e173a]
stable/5.10: [610f247f2772e4f92b63442125a1b7ade79898d8]
stable/5.15: [2d63433e8eaa3c91b2948190e395bc67009db0d9]
stable/5.4: [9027ce4c037b566b658b8939a76326b7125e3627]
stable/6.1: [54947530663edcbaaee1314c01fdd8c72861b124]
stable/6.12: [b235393b9f43ff86a38ca2bde6372312ea215dc5]
stable/6.6: [ab91647acdf43b984824776559a452212eaeb21a]

CVE-2025-38313: bus: fsl-mc: fix double-free on mc_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38313

Introduced by commit a042fbe ("staging: fsl-mc: simplify couple of
deallocations") in v4.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d694bf8a9acdbd061596f3e7549bc8cb70750a60]
stable/5.10: [3135e03a92f6b5259d0a7f25f728e9e7866ede3f]
stable/5.15: [7002b954c4a8b9965ba0f139812ee4a6f71beac8]
stable/5.4: [12e4431e5078847791936820bd39df9e1ee26d2e]
stable/6.1: [b2057374f326303c86d8423415ab58656eebc695]
stable/6.12: [1d5baab39e5b09a76870b345cdee7933871b881f]
stable/6.6: [4b23c46eb2d88924b93aca647bde9a4b9cf62cf9]

CVE-2025-38314: virtio-pci: Fix result size returned for the admin
command completion

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38314

Introduced by commit 704806c ("virtio: Extend the admin command to
include the result size") in v6.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ef41ebf787fcbde99ac404ae473f8467641f983]

CVE-2025-38315: Bluetooth: btintel: Check dsbr size from EFI variable

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38315

Introduced by commit eb9e749 ("Bluetooth: btintel: Allow configuring
drive strength of BRI") in v6.11-rc6.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3aa1dc3c9060e335e82e9c182bf3d1db29220b1b]
stable/6.12: [9427f6081f37c795a8bd29d0ee72a4da3bd64af8]

CVE-2025-38316: wifi: mt76: mt7996: avoid NULL pointer dereference in
mt7996_set_monitor()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38316

Introduced by commit 69d54ce ("wifi: mt76: mt7996: switch to single
multi-radio wiphy") in v6.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb423ddad0f6e6f55b1700422ab777b25597cc83]

CVE-2025-38317: wifi: ath12k: Fix buffer overflow in debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38317

Introduced by commit 3f73c24 ("wifi: ath12k: Add support to enable
debugfs_htt_stats") in v6.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c7a5031a6b0d42e640fbd2d5d05f61f74e32dce]
stable/6.12: [0c57aa8ef94cffc5c2d68230e19329a03e71a94f]

CVE-2025-38318: perf: arm-ni: Fix missing platform_set_drvdata()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38318

Introduced by commit 4d5a768 ("perf: Add driver for Arm NI-700
interconnect PMU") in v6.12-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc5106088d6db75df61308ef6de314d1f7959646]
stable/6.12: [8e43fa9c713a6d084a5732aa6dd41c734845f25e]

CVE-2025-38319: drm/amd/pp: Fix potential NULL pointer dereference in
atomctrl_initialize_mc_reg_table

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38319

Introduced by commit b3892e2 ("drm/amd/pp: Use atombios api directly
in powerplay (v2)") in v4.18-rc1.
Introduced by commit 5f92b48 ("drm/amd/pm: add mc register table
initialization") in v5.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [820116a39f96bdc7d426c33a804b52f53700a919]
stable/5.15: [85cdcb834fb490731ff2d123f87ca799c57dacf2]
stable/6.1: [7080c20a9139842033ed4af604dc1fa4028593ad]
stable/6.12: [64f3acc8c7e6809631457b75638601b36dea3129]
stable/6.6: [cdf7e1ff99ab06ef15d0b5d1aca5258a4fb62b85]

CVE-2025-38320: arm64/ptrace: Fix stack-out-of-bounds read in
regs_get_kernel_stack_nth()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38320

Introduced by commit 0a8ea52 ("arm64: Add
HAVE_REGS_AND_STACK_ACCESS_API feature") in v4.8-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39dfc971e42d886e7df01371cd1bef505076d84c]
stable/5.10: [67abac27d806e8f9d4226ec1528540cf73af673a]
stable/5.15: [92750bfe7b0d8dbcaf578c091a65eda1c5f9ad38]
stable/5.4: [64773b3ea09235168a549a195cba43bb867c4a17]
stable/6.1: [01f91d415a8375d85e0c7d3615cd4a168308bb7c]
stable/6.12: [22f935bc86bdfbde04009f05eee191d220cd8c89]
stable/6.6: [21da6d3561f373898349ca7167c9811c020da695]

CVE-2025-38321: smb: Log an error when close_all_cached_dirs fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38321

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc3.
It looks as if this bug was introduced by 3fa640d ("smb: During unmount, ensure
all cached dir instances drop their dentry") in 6.13-rc1.
Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [a2182743a8b4969481f64aec4908ff162e8a206c]
stable/6.12: [43f26094d6702e494e800532c3f1606e7a68eb30]
stable/6.6: [b8ced2b9a23a1a2c1e0ed8d0d02512e51bdf38da]

CVE-2025-38322: perf/x86/intel: Fix crash in icl_update_topdown_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38322

Introduced by commit f9bdf1f ("perf/x86/intel: Avoid disable PMU if
!cpuc->enabled in sample read") in v6.15-rc1.
Fixed in v6.16-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [b0823d5fbacb1c551d793cbfe7af24e0d1fa45ed]

CVE-2025-38323: net: atm: add lec_mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38323

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d13a3824bfd2b4774b671a75cf766a16637a0e67]
stable/5.10: [a7a713dfb5f9477345450f27c7c0741864511192]
stable/5.15: [17e156a94e94a906a570dbf9b48877956c60bef8]
stable/5.4: [e91274cc7ed88ab5bdc62d426067c82b0b118a0b]
stable/6.1: [18e8f0c4f826fb08c2d3825cdd6c57e24b207e0a]
stable/6.12: [f4d80b16ecc4229f7e6345158ef34c36be323f0e]
stable/6.6: [dffd03422ae6a459039c8602f410e6c0f4cbc6c8]

CVE-2025-38324: mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38324

Introduced by commit 0189197 ("mpls: Basic routing support") in v4.1-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dbb0d97c5096072c78a6abffe393584e57ae945]
stable/5.10: [36af82f25fbdcd719eb947c15ea874bf80bcf229]
stable/5.15: [d8cd847fb8626872631cc22d44be5127b4ebfb74]
stable/5.4: [2919297b18e5a5fb7e643f9e32c12c0b17cce1be]
stable/6.1: [49b8a9d7d44401a186e20b1aaf591d2e62727aeb]
stable/6.12: [517bc6836ee9fcffe2539f6f6aa3fdd9c7a7ae73]
stable/6.6: [a060781640012d5d5105072f4c44ed6ad6830ef9]

CVE-2025-38325: ksmbd: add free_transport ops in ksmbd connection

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38325

Introduced by commit 21a4e47 ("ksmbd: fix use-after-free in
__smb2_lease_break_noti()") in v6.15-rc3.
Fixed in v6.16-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [a89f5fae998bdc4d0505306f93844c9ae059d50c]
stable/6.12: [3890da762a66191c440b0bd6e3ee45501edbb0c1]

CVE-2025-38326: aoe: clean device rq_list in aoedev_downdev()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38326

Introduced by commit 3582dd2 ("aoe: convert aoeblk to blk-mq") in v4.20-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f90d45e57cb2ef1f0adcaf925ddffdfc5e680ca]
stable/5.10: [64fc0bad62ed38874131dd0337d844a43bd1017e]
stable/5.15: [ef0b5bbbed7f220db2e9c73428f9a36e8dfc69ca]
stable/5.4: [ed52e9652ba41d362e9ec923077f6da23336f269]
stable/6.1: [531aef4a1accb13b21a3b82ec29955f4733367d5]
stable/6.12: [fa2a79f0da92614c5dc45c8b3d2638681c7734ee]
stable/6.6: [8662ac79a63488e279b91c12a72b02bc0dc49f7b]

CVE-2025-38327: fgraph: Do not enable function_graph tracer when
setting funcgraph-args

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38327

Introduced by commit c7a60a7 ("ftrace: Have funcgraph-args take affect
during tracing") in v6.15-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [327e28664307d49ce3fa71ba30dcc0007c270974]

CVE-2025-38328: jffs2: check jffs2_prealloc_raw_node_refs() result in
few other places

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38328

Introduced by commit 2f78540 ("[JFFS2] Reduce visibility of
raw_node_ref to upper layers of JFFS2 code.") in v2.6.20.16.
Introduced by commit f560928 ("[JFFS2] Allocate node_ref for wasted
space when skipping to page boundary") in v2.6.20.16.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b6d96503255a3ed676cd70f8368870c6d6a25c6]
stable/5.10: [d96e6451a8d0fe62492d4cc942d695772293c05a]
stable/5.15: [f41c625328777f9ad572901ba0b0065bb9c9c1da]
stable/5.4: [7e860296d7808de1db175c1eda29f94a2955dcc4]
stable/6.1: [38d767fb4a7766ec2058f97787e4c6e8d10343d6]
stable/6.12: [d1b81776f337a9b997f797c70ac0a26d838a2168]
stable/6.6: [cd42ddddd70abc7127c12b96c8c85dbd080ea56f]

CVE-2025-38329: firmware: cs_dsp: Fix OOB memory read access in KUnit
test (wmfw info)

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38329

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by 5cf1b7b ("firmware: cs_dsp: Add mock wmfw file
generator for KUnit testing") in 6.14-rc1.

Fixed status
mainline: [d979b783d61f7f1f95664031b71a33afc74627b2]

CVE-2025-38330: firmware: cs_dsp: Fix OOB memory read access in KUnit
test (ctl cache)

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38330

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by 9b33a4f ("firmware: cs_dsp: Add KUnit testing
of control cache") in 6.14-rc1.

Fixed status
mainline: [f4ba2ea57da51d616b689c4b8826c517ff5a8523]

CVE-2025-38331: net: ethernet: cortina: Use TOE/TSO on all TCP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38331

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Affected driver was added by 4d5ae32f5 ("net: ethernet: Add a driver for Gemini
gigabit ethernet") in 4.16-rc1.

Fixed status
mainline: [6a07e3af4973402fa199a80036c10060b922c92c]
stable/6.1: [1b503b790109d19710ec83c589c3ee59e95347ec]
stable/6.12: [2bd434bb0eeb680c2b3dd6c68ca319b30cb8d47f]
stable/6.6: [a37888a435b0737128d2d9c6f67b8d608f83df7a]

CVE-2025-38332: scsi: lpfc: Use memcpy() for BIOS version

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38332

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
It looks as if this bug is introduced by b3b4f3e ("scsi: lpfc: Correct boot bios
information to FDMI registration") in 5.2-rc1.

Fixed status
mainline: [ae82eaf4aeea060bb736c3e20c0568b67c701d7d]
stable/5.10: [b699bda5db818b684ff62d140defd6394f38f3d6]
stable/5.15: [d34f2384d6df11a6c67039b612c2437f46e587e8]
stable/5.4: [ac7bfaa099ec3e4d7dfd0ab9726fc3bc7911365d]
stable/6.1: [75ea8375c5a83f46c47bfb3de6217c7589a8df93]
stable/6.12: [2f63bf0d2b146956a2f2ff3b25cee71019e64561]
stable/6.6: [34c0a670556b24d36c9f8934227edb819ca5609e]

CVE-2025-38333: f2fs: fix to bail out in get_new_segment()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38333

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
It looks as if all LTS kernels are affected.

Fixed status
mainline: [bb5eb8a5b222fa5092f60d5555867a05ebc3bdf2]
stable/6.12: [f0023d7a2a86999c8e1300e911d92f995a5310a8]

CVE-2025-38334: x86/sgx: Prevent attempts to reclaim poisoned pages

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38334

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by a495cbd ("x86/sgx: Add SGX infrastructure to
recover from poison") in 5.17-rc1.

Fixed status
mainline: [ed16618c380c32c68c06186d0ccbb0d5e0586e59]
stable/6.1: [00a88e9ea1b170d579c56327c38f7e8cf689df87]
stable/6.12: [dc5de5bd6deabd327ced2b2b1d0b4f14cd146afe]
stable/6.6: [62b62a2a6dc51ed6e8e334861f04220c9cf8106a]

CVE-2025-38335: Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38335

Introduced by commit 019002f ("Input: gpio-keys - use hrtimer for
release timer") in v5.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4a8f561d08e39f7833d4a278ebfb12a41eef15f]

CVE-2025-38336: ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38336

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc3.
It seems as if this bug was introduced by 6d0e194 ("pata_via: disable ATAPI DMA
on AVERATEC 3200") in 3.1-rc3.

Fixed status
mainline: [d29fc02caad7f94b62d56ee1b01c954f9c961ba7]
stable/5.10: [0d9a48dfa934f43ac839211ae4aeba34f666a9a5]
stable/5.15: [7fc89c218fc96a296a2840b1e37f4e0975f7a108]
stable/5.4: [67d66a5e4583fd3bcf13d6f747e571df13cbad51]
stable/6.1: [8212cd92fe40aae6fe5a073bc70e758c42bb4bfc]
stable/6.12: [947f9304d3c876c6672b947b80c0ef51161c6d2f]
stable/6.6: [8edfed4439b107d62151ff6c075958d169da3e71]

CVE-2025-38337: jbd2: fix data-race and null-ptr-deref in
jbd2_journal_dirty_metadata()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38337

Introduced by commit 6e06ae8 ("jbd2: speedup
jbd2_journal_dirty_metadata()") in v4.3-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af98b0157adf6504fade79b3e6cb260c4ff68e37]
stable/5.10: [ec669e5bf409f16e464bfad75f0ba039a45de29a]
stable/5.15: [43d5e3bb5f1dcd91e30238ea0b59a5f77063f84e]
stable/5.4: [5c1a34ff5b0bfdfd2f9343aa9b08d25df618bac5]
stable/6.1: [23361b479f2700c00960d3ae9cdc8ededa762d47]
stable/6.12: [f78b38af3540b4875147b7b884ee11a27b3dbf4c]
stable/6.6: [2e7c64d7a92c031d016f11c8e8cb05131ab7b75a]

CVE-2025-38338: fs/nfs/read: fix double-unlock bug in nfs_return_empty_folio()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38338

Introduced by commit 000dbe0 ("NFS: Convert buffered read paths to use
netfs when fscache is enabled") in v6.4-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c10fa44bc5f700e2ea21de2fbae520ba21f19d9]
stable/6.12: [5bf0b9eeb0174686f22c2e5b8fb9f47ad25da6f5]
stable/6.6: [14f5549ad163be2c018abc1bb38370fff617a243]

CVE-2025-38339: powerpc/bpf: fix JIT code size calculation of bpf trampoline

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38339

Introduced by commit d243b62 ("powerpc64/bpf: Add support for bpf
trampolines") in v6.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59ba025948be2a92e8bc9ae1cbdaf197660bd508]

CVE-2025-38340: firmware: cs_dsp: Fix OOB memory read access in KUnit test

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38340

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by 7c052c6 ("firmware: cs_dsp: Add mock bin file
generator for KUnit testing") in 6.14-rc1.

Fixed status
mainline: [fe6446215bfad11cf3b446f38b28dc7708973c25]

CVE-2025-38341: eth: fbnic: avoid double free when failing to DMA-map FW msg

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38341

Introduced by commit da3cde0 ("eth: fbnic: Add FW communication
mechanism") in v6.11-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bd1bafd4474ee26f504b41aba11f3e2a1175b88]
stable/6.12: [670179265ad787b9dd8e701601914618b8927755]

CVE-2025-38342: software node: Correct a OOB check in
software_node_get_reference_args()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38342

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
It looks as if this bug was introduced by e933bed ("software node:
remove separate
handling of references") in 5.6-rc1.

Fixed status
mainline: [31e4e12e0e9609850cefd4b2e1adf782f56337d6]
stable/5.10: [142acd739eb6f08c148a96ae8309256f1422ff4b]
stable/5.15: [56ce76e8d406cc72b89aee7931df5cf3f18db49d]
stable/6.1: [9324127b07dde8529222dc19233aa57ec810856c]
stable/6.12: [4b3383110b6df48e0ba5936af2cb68d5eb6bd43b]
stable/6.6: [f9397cf7bfb680799fb8c7f717c8f756384c3280]

CVE-2025-38343: wifi: mt76: mt7996: drop fragments with multicast or
broadcast RA

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38343

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by 98686c ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in 6.2-rc1.

Fixed status
mainline: [80fda1cd7b0a1edd0849dc71403a070d0922118d]
stable/6.12: [d4b93f9c2f666011dcf810050ef60a6b8d06f186]
stable/6.6: [24900688ee47071aa6a61e78473999b5b80f0423]

CVE-2025-38344: ACPICA: fix acpi parse and parseext cache leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38344

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by 42f8fb7 ("ACPICA: Source restructuring: split
large files into 8 new files.") in 3.9-rc1.

Fixed status
mainline: [bed18f0bdcd6737a938264a59d67923688696fc4]
stable/5.10: [41afebc9a0762aafc35d2df88f4e1b798155a940]
stable/5.15: [960236150cd3f08e13b397dd5ae4ccf7a2986c00]
stable/5.4: [1e0e629e88b1f7751ce69bf70cda6d1598d45271]
stable/6.1: [0a119fdaed67566aa3e0b5222dced4d08bbce463]
stable/6.12: [198c2dab022e5e94a99fff267b669d693bc7bb49]
stable/6.6: [1fee4324b5660de080cefc3fc91c371543bdb8f6]

CVE-2025-38345: ACPICA: fix acpi operand cache leak in dswstate.c

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38345

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [156fd20a41e776bbf334bd5e45c4f78dfc90ce1c]
stable/5.10: [1c0d9115a001979cb446ba5e8331dd1d29a10bbf]
stable/5.15: [5a68893b594ee6ce0efce5f74c07e64e9dd0c2c4]
stable/5.4: [4fa430a8bca708c7776f6b9d001257f48b19a5b7]
stable/6.1: [64c4bcf0308dd1d752ef31d560040b8725e29984]
stable/6.12: [76d37168155880f2b04a0aad92ceb0f9d799950e]
stable/6.6: [755a8006b76792922ff7b1c9674d8897a476b5d7]

CVE-2025-38346: ftrace: Fix UAF when lookup kallsym after ftrace disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38346

Introduced by commit aba4b5c ("ftrace: Save module init functions
kallsyms symbols for tracing") in v4.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f914b52c379c12288b7623bb814d0508dbe7481d]
stable/5.10: [8690cd3258455bbae64f809e1d3ee0f043661c71]
stable/5.15: [6805582abb720681dd1c87ff677f155dcf4e86c9]
stable/5.4: [d064c68781c19f378af1ae741d9132d35d24b2bb]
stable/6.1: [03a162933c4a03b9f1a84f7d8482903c7e1e11bb]
stable/6.12: [8e89c17dc8970c5f71a3a991f5724d4c8de42d8c]
stable/6.6: [83a692a9792aa86249d68a8ac0b9d55ecdd255fa]

CVE-2025-38347: f2fs: fix to do sanity check on ino and xnid

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38347

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [061cf3a84bde038708eb0f1d065b31b7c2456533]
stable/6.12: [fed611bd8c7b76b070aa407d0c7558e20d9e1f68]
stable/6.6: [aaddc6c696bd1bff20eaacfa88579d6eae64d541]

CVE-2025-38348: wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38348

Introduced by commit 7cb7707 ("p54: move eeprom code into common
library") in v2.6.28-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da1b9a55ff116cb040528ef664c70a4eec03ae99]
stable/5.10: [9701f842031b825e2fd5f22d064166f8f13f6e4d]
stable/5.15: [1f7f8168abe8cbe845ab8bb557228d44784a6b57]
stable/5.4: [12134f79e53eb56b0b0b7447fa0c512acf6a8422]
stable/6.1: [f39b2f8c1549a539846e083790fad396ef6cd802]
stable/6.12: [6d05390d20f110de37d051a3e063ef0a542d01fb]
stable/6.6: [0e4dc150423b829c35cbcf399481ca11594fc036]

* Updated CVEs

CVE-2024-26726: btrfs: don't drop extent_map for free space inode on write error

stable/5.15 was fixed.

Fixed status
stable/5.15: [143842584c1237ebc248b2547c29d16bbe400a92]

CVE-2024-27070: f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault

stable/6.6 was fixed.

Fixed status
stable/6.6: [897761d16564e899faecb9381b4818858705081f]

CVE-2024-36350: TSA-SQ (TSA in the Store Queues)

stable/6.1, stable/6.12, stable/6.15, stable/6.6 were fixed.

Fixed status
stable/6.1: [3893cd05fcf60c239a35c833a6677783ec18dfc5,
d12145e8454fbd1de168af57d444b943e4300dc1,
5c30f037bc0dde32517febb9fdebf02fbcf24959,
41d49d4e6abf4fbfe76ad09a4dbedaf749ad11a1]
stable/6.12: [0720e436e594d330bc10851889d90f6b48a2b32d,
7a0395f6607a5d01e2b2a86355596b3f1224acbd,
d5d66e31fd9a9b8217f59b4247b9f5c923b14597,
331cfdd27429ed7a64923123b2482e85238979fa,
0029b3c1320bb9cf6ce1e9bf93dadd909ca06fa1]
stable/6.15: [27abf1da6cade3a221537ef95c7f6c56c8838e37,
ab0f6573b2113647915923b5adeb4f6ebc83f271,
79529e51bbb4625e22ccb492833505df340a8727,
efb52d40b15807757c596f0760ee66a23a373e0c,
94560691aa1c6d642e3c8e9b7da4c3ad53e8f272,
62901034ddc8aa6fab5e21dcf6fbd0404e685c13]
stable/6.6: [2b6a5fbe9dc1842e3485557a057c8e6311b6fd72,
90293047df18caf7ed0fe566d89af0720f2dc98a,
276499bb6944c5300ee79439302529c3b28564dd,
6fb766d53f613e23c60fb91b6fdbc10d522cccc6,
8c1944905855c2ea56dbd21915dce6b802af49be]

CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)

stable/6.1, stable/6.12, stable/6.15, stable/6.6 were fixed.

Fixed status
stable/6.1: [3893cd05fcf60c239a35c833a6677783ec18dfc5,
d12145e8454fbd1de168af57d444b943e4300dc1,
5c30f037bc0dde32517febb9fdebf02fbcf24959,
41d49d4e6abf4fbfe76ad09a4dbedaf749ad11a1]
stable/6.12: [0720e436e594d330bc10851889d90f6b48a2b32d,
7a0395f6607a5d01e2b2a86355596b3f1224acbd,
d5d66e31fd9a9b8217f59b4247b9f5c923b14597,
331cfdd27429ed7a64923123b2482e85238979fa,
0029b3c1320bb9cf6ce1e9bf93dadd909ca06fa1]
stable/6.15: [27abf1da6cade3a221537ef95c7f6c56c8838e37,
ab0f6573b2113647915923b5adeb4f6ebc83f271,
79529e51bbb4625e22ccb492833505df340a8727,
efb52d40b15807757c596f0760ee66a23a373e0c,
94560691aa1c6d642e3c8e9b7da4c3ad53e8f272,
62901034ddc8aa6fab5e21dcf6fbd0404e685c13]
stable/6.6: [2b6a5fbe9dc1842e3485557a057c8e6311b6fd72,
90293047df18caf7ed0fe566d89af0720f2dc98a,
276499bb6944c5300ee79439302529c3b28564dd,
6fb766d53f613e23c60fb91b6fdbc10d522cccc6,
8c1944905855c2ea56dbd21915dce6b802af49be]

CVE-2025-38139: netfs: Fix oops in write-retry from mis-resetting the
subreq iterator

stable/6.12 was fixed.

Fixed status
stable/6.12: [e0fefe9bc07e6101fdc57abda3644f296c114e31]

CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent crashes

stable/5.15 was fixed.

Fixed status
stable/5.15: [c3705c82b7406a15ef38a610d03bf6baa43d6e0c]

CVE-2025-38242: mm: userfaultfd: fix race of userfaultfd_move and swap cache

stable/6.12 was fixed.

Fixed status
stable/6.12: [4c443046d8c9ed8724a4f4c3c2457d3ac8814b2f]

CVE-2025-38243: btrfs: fix invalid inode pointer dereferences during log replay

stable/6.12 was fixed.

Fixed status
stable/6.12: [401d098f92ea69d8a75f8b845daf343e511681ba]

CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in
atm_dev_deregister().

stable/5.15 was fixed.

Fixed status
stable/5.15: [26248d5d68c865b888d632162abbf8130645622c]

CVE-2025-38246: bnxt: properly flush XDP redirect lists

stable/6.6 was fixed.

Fixed status
stable/6.6: [16254aa985d14dee050564c4a3936f3dc096e1f7]

CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in
snd_usb_get_audioformat_uac3()

stable/5.15 was fixed.

Fixed status
stable/5.15: [c3fb926abe90d86f5e3055e0035f04d9892a118b]

CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush()

stable/6.6 was fixed.

Fixed status
stable/6.6: [bc0819a25e04cd68ef3568cfa51b63118fea39a7]

CVE-2025-38251: atm: clip: prevent NULL deref in clip_push()

stable/5.15 was fixed.

Fixed status
stable/5.15: [9199e8cb75f13a1650adcb3c6cad42789c43884e]

CVE-2025-38257: s390/pkey: Prevent overflow in size calculation for
memdup_user()

stable/5.15 was fixed.

Fixed status
stable/5.15: [ad1bdd24a02d5a8d119af8e4cd50933780a6d29f]

CVE-2025-38262: tty: serial: uartlite: register uart driver in init

stable/5.15 was fixed.

Fixed status
stable/5.15: [9c905fdbba68a6d73d39a6b7de9b9f0d6c46df87]

CVE-2025-38263: bcache: fix NULL pointer in cache_set_flush()

stable/5.15 was fixed.

Fixed status
stable/5.15: [1f25f2d3fa29325320c19a30abf787e0bd5fc91b]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

