Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BCC27C53
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 01:47:07 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.37776.1718848019506751426
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 18:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=JesWnBpi;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.45, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-259884ef4ddso195554fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1718848018; x=1719452818; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1P7+7fiou5aODSskJvX15eO+BgYsKGctBBqIH5B3HUs=;
        b=JesWnBpi7Nmp4KFuGkSs7S+A+wzMnuKTFnwmh2jArGOtRlJGY5NbHEM3E/n9mi9sg/
         Xth9rT+hqL1/dFEdTAhXDvzJNKICjfYyv3mu9/noRkxOOvxX58xfytfDWDDNYeZgcG0S
         ebrwjtpoS4YNsiS2lhofvaTq0L8ENS9vJxIQ/SJa7sWjwj5Uvf/ye5kEbMCMZSm+Mq0V
         OI9Peh8H7DJr+SYy+q6ehSnizobP8GjgJVFmiRJKVahPpjKrhqCigQBKS+K29A8oIwol
         E9olHDs0rrchT2W7u1QzFrQVX/4HMUiI7dc0MzYj+d09m+K0cgrE/Rr8vuYpfK5J59OR
         +11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718848018; x=1719452818;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1P7+7fiou5aODSskJvX15eO+BgYsKGctBBqIH5B3HUs=;
        b=talxDqvd8XIpuJbWOsmMBK0WDqIeJE8RW0BoHTYFEwhAxII42A6VQhJSXqKGpR1wEN
         ycDmLT4EpWtmz6VaDZhiPm8cujo6ZCjtiAh3JjzRbRGc1KZVa0VHtFyaMiIstPzmDXnM
         7FQFN/u3UewgebzKujbh98CsOz90en7nkQadphrAPvw9y9iQ+vzD4tClPkWh4pQPHqQo
         mXrydMEQaF09jZWmw1Fa7sBrXnBQFwGAvwMqGk45DhhErYL+JVzH+bdO6w00eFuvI3Ha
         h670eAOpPu+ZSK/stNRhbDGnf17OrWp2HunMvq08jXOQ+DRg0lDFUXa/oYZ5vF+jmkBd
         NdOQ==
X-Gm-Message-State: AOJu0YzT4GQLeK0MPLl7j6bLhk23WXkv5aYIuMPJxGHtIlTCMnCoKrC5
	7VOia8XHC9al0oMiNNmmY9nkgMTD76FuBh4vbPyTbk51ZUGiJijqn3my5ZS7eHuEEe2w+rgFlm7
	2hlaMt0bpsHekgdcNG4y50My587gm5f26DdVIdU1wBLykf9zyhiw=
X-Google-Smtp-Source: AGHT+IH3XxcQ1eeyvLq3MMh8IRkpPCniE/7/mE28y1pUnDvEg9mUGml3zGn6ZZtBxUS90/LqyHiY963UIOk+1RqghqA=
X-Received: by 2002:a05:6870:4204:b0:254:affe:5a09 with SMTP id
 586e51a60fabf-25c948f40f0mr4840086fac.3.1718848016722; Wed, 19 Jun 2024
 18:46:56 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Jun 2024 10:46:20 +0900
Message-ID: <CAODzB9qccTi6qBXT3gzRzxozhpk86SfisvN6yz1f5bwATyHK4g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 01:47:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16299

Hi!

It's this week's CVE report.

This week reported 132 new CVEs and 21 updated CVEs.

* New CVEs
CVE-2024-36974: net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP

Announce: https://lore.kernel.org/linux-cve-announce/2024061810-CVE-2024-36=
974-a482@gregkh/

Introduced by commit a3d43c0 ("taprio: Add support adding an admin
schedule") in v5.2-rc1.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f921a58ae20852d188f70842431ce6519c4fdc36]

CVE-2024-36975: KEYS: trusted: Do not use WARN when encode fails

Announce: https://lore.kernel.org/linux-cve-announce/2024061828-CVE-2024-36=
975-6719@gregkh/

Introduced by commit f221974 ("security: keys: trusted: use ASN.1 TPM2
key format for the blobs") in v5.13-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [050bf3c793a07f96bd1e2fd62e1447f731ed733b]
stable/5.15: [96f650995c70237b061b497c66755e32908f8972]
stable/6.1: [681935009fec3fc22af97ee312d4a24ccf3cf087]
stable/6.6: [1c652e1e10676f942149052d9329b8bf2703529a]

CVE-2024-36976: Revert "media: v4l2-ctrls: show all owned controls in
log_status"

Announce: https://lore.kernel.org/linux-cve-announce/2024061855-CVE-2024-36=
976-27e0@gregkh/

Introduced by commit 9801b5b ("media: v4l2-ctrls: show all owned
controls in log_status") in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eba63df7eb1f95df6bfb67722a35372b6994928d]

CVE-2024-36977: usb: dwc3: Wait unconditionally after issuing EndXfer comma=
nd

Announce: https://lore.kernel.org/linux-cve-announce/2024061804-CVE-2024-36=
977-e1e8@gregkh/

Introduced by commit b353eb6 ("usb: dwc3: gadget: Skip waiting for
CMDACT cleared during endxfer") in v6.1-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d26ba0944d398f88aaf997bda3544646cf21945]
stable/6.1: [341eb08dbca9eae05308c442fbfab1813a44c97a]
stable/6.6: [ec96bcf5f96a7a5c556b0e881ac3e5c3924d542c]

CVE-2021-47573: xen/blkfront: harden blkfront against event channel storms

Announce: https://lore.kernel.org/linux-cve-announce/2024061911-CVE-2021-47=
573-5c43@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc7.

Fixed status
cip/4.4: [3e04b9e6aa7d77287e70a400be83060d2b7b2cfe]
cip/4.4-rt: [3e04b9e6aa7d77287e70a400be83060d2b7b2cfe]
cip/4.4-st: [3e04b9e6aa7d77287e70a400be83060d2b7b2cfe]
mainline: [0fd08a34e8e3b67ec9bd8287ac0facf8374b844a]
stable/4.19: [269d7124bcfad2558d2329d0fe603ca20b20d3f4]
stable/5.10: [8ac3b6ee7c9ff2df7c99624bb1235e2e55623825]
stable/5.15: [caf9b51829a50590b84daea924a0fd62d32bc952]
stable/5.4: [4ed9f5c511ce95cb8db05ff82026ea901f45fd76]

CVE-2021-47574: xen/netfront: harden netfront against event channel storms

Announce: https://lore.kernel.org/linux-cve-announce/2024061914-CVE-2021-47=
574-18b4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc7.

Fixed status
cip/4.4: [81900aa7d7a130dec4c55b68875e30fb8c9effec]
cip/4.4-rt: [81900aa7d7a130dec4c55b68875e30fb8c9effec]
cip/4.4-st: [81900aa7d7a130dec4c55b68875e30fb8c9effec]
mainline: [b27d47950e481f292c0a5ad57357edb9d95d03ba]
stable/4.19: [3559ca594f15fcd23ed10c0056d40d71e5dab8e5]
stable/5.10: [d31b3379179d64724d3bbfa87bd4ada94e3237de]
stable/5.15: [a29c8b5226eda52e6d6ff151d9343558ea3ad451]
stable/5.4: [3e68d099f09c260a7dee28b99af02fe6977a9e66]

CVE-2021-47575: xen/console: harden hvc_xen against event channel storms

Announce: https://lore.kernel.org/linux-cve-announce/2024061914-CVE-2021-47=
575-a011@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc7.

Fixed status
cip/4.4: [c7eaa5082bccfc00dfdb500ac6cc86d6f24ca027]
cip/4.4-rt: [c7eaa5082bccfc00dfdb500ac6cc86d6f24ca027]
cip/4.4-st: [c7eaa5082bccfc00dfdb500ac6cc86d6f24ca027]
mainline: [fe415186b43df0db1f17fa3a46275fd92107fe71]
stable/4.19: [57e46acb3b48ea4e8efb1e1bea2e89e0c6cc43e2]
stable/5.10: [8fa3a370cc2af858a9ba662ca4f2bd0917550563]
stable/5.15: [153d1ea3272209fc970116f09051002d14422cde]
stable/5.4: [560e64413b4a6d9bd6630e350d5f2e6a05f6ffe3]

CVE-2021-47576: scsi: scsi_debug: Sanity check block descriptor length
in resp_mode_select()

Announce: https://lore.kernel.org/linux-cve-announce/2024061914-CVE-2021-47=
576-5f60@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc3.
It looks as if 4.4 is affected too.

Fixed status
mainline: [e0a2c28da11e2c2b963fc01d50acbf03045ac732]
stable/4.19: [04181973c38f3d6a353f9246dcf7fee08024fd9e]
stable/5.10: [a9078e791426c2cbbdf28a320c3670f6e0a611e6]
stable/5.15: [dfc3fff63793c571147930b13c0f8c689c4281ac]
stable/5.4: [b847ecff850719c46c95acd25a0d555dfd16e10d]

CVE-2021-47577: io-wq: check for wq exit after adding new worker task_work

Announce: https://lore.kernel.org/linux-cve-announce/2024061915-CVE-2021-47=
577-c4c7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc5.
The IO_WQ was introduced by commit 771b53d0 ("io-wq: small threadpool
implementation for io_uring") in 5.5-rc1. so that prior to 5.5 kernels
are not affected. 5.10 was fixed by commit 788d0824 ("io_uring:
import 5.15-stable io_uring") when  sync io_uring code to 5.15.

Fixed status
mainline: [71a85387546e50b1a37b0fa45dadcae3bfb35cf6]
stable/5.10: [788d0824269bef539fe31a785b1517882eafed93]
stable/5.15: [4b4e5bbf9386d4ec21d91c0cb0fd60b9bba778ec]

CVE-2021-47578: scsi: scsi_debug: Don't call kcalloc() if size arg is zero

Announce: https://lore.kernel.org/linux-cve-announce/2024061915-CVE-2021-47=
578-e81a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc1.
The resp_verify() was added by commit c3e2fe92 ("scsi: scsi_debug:
Implement VERIFY(10), add VERIFY(16)") in 5.8-rc1. The resp_report_zones()
was added by commit f0d1cf93 ("scsi: scsi_debug: Add ZBC zone commands")
in 5.8-rc1.

Fixed status
mainline: [3344b58b53a76199dae48faa396e9fc37bf86992]
stable/5.10: [aa1f912712a109b6306746133de7e5343f016b26]
stable/5.15: [47d11d35203b0aa13533634e270fe2c3610e531b]

CVE-2021-47579: ovl: fix warning in ovl_create_real()

Announce: https://lore.kernel.org/linux-cve-announce/2024061915-CVE-2021-47=
579-4f78@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc1.
It seems as if linux 4.4 is affected too.

Fixed status
mainline: [1f5573cfe7a7056e80a92c7a037a3e69f3a13d1c]
stable/4.19: [445d2dc63e5871d218f21b8f62ab29ac72f2e6b8]
stable/5.10: [6859985a2fbda5d1586bf44538853e1be69e85f7]
stable/5.15: [d2ccdd4e4efab06178608a34d7bfb20a54104c02]
stable/5.4: [f9f300a92297be8250547347fd52216ef0177ae0]

CVE-2021-47580: scsi: scsi_debug: Fix type in min_t to avoid stack OOB

Announce: https://lore.kernel.org/linux-cve-announce/2024061916-CVE-2021-47=
580-eac9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc3.
It seems as if 4.4, 4.19, and 5.4 are affected too.

Fixed status
mainline: [36e07d7ede88a1f1ef8f0f209af5b7612324ac2c]
stable/5.10: [bdb854f134b964528fa543e0351022eb45bd7346]
stable/5.15: [3085147645938eb41f0bc0e25ef9791e71f5ee4b]

CVE-2021-47581: xen/netback: don't queue unlimited number of packages

Announce: https://lore.kernel.org/linux-cve-announce/2024061916-CVE-2021-47=
581-1d34@gregkh/

Introduced by commit f48da8b ("xen-netback: fix unlimited guest Rx
internal queue and carrier flapping") in v3.18-rc3.
Fixed in v5.16-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [0928efb09178e01d3dc8e8849aa1c807436c3c37]
cip/4.4-rt: [0928efb09178e01d3dc8e8849aa1c807436c3c37]
cip/4.4-st: [0928efb09178e01d3dc8e8849aa1c807436c3c37]
mainline: [be81992f9086b230623ae3ebbc85ecee4d00a3d3]
stable/4.19: [c9f17e92917fd5786be872626a3928979ecc4c39]
stable/5.10: [88f20cccbeec9a5e83621df5cc2453b5081454dc]
stable/5.15: [bd926d189210cd1d5b4e618e45898053be6b4b3b]
stable/5.4: [0d99b3c6bd39a0a023e972d8f912fd47698bbbb8]

CVE-2021-47582: USB: core: Make do_proc_control() and do_proc_bulk() killab=
le

Announce: https://lore.kernel.org/linux-cve-announce/2024061916-CVE-2021-47=
582-69aa@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc1.

Fixed status
mainline: [ae8709b296d80c7f45aa1f35c0e7659ad69edce1]
stable/5.15: [403716741c6c2c510dce44e88f085a740f535de6]

CVE-2021-47583: media: mxl111sf: change mutex_init() location

Announce: https://lore.kernel.org/linux-cve-announce/2024061916-CVE-2021-47=
583-b02c@gregkh/

Introduced by commit 8572211 ("[media] mxl111sf: convert to new DVB
USB") in v3.7-rc1.
Fixed in v5.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44870a9e7a3c24acbb3f888b2a7cc22c9bdf7e7f]
stable/4.19: [4b2d9600b31f9ba7adbc9f3c54a068615d27b390]
stable/5.10: [b99bdf127af91d53919e96292c05f737c45ea59a]
stable/5.15: [8c6fdf62bfe1bc72bfceeaf832ef7499c7ed09ba]
stable/5.4: [96f182c9f48b984447741f054ec301fdc8517035]

CVE-2021-47584: iocost: Fix divide-by-zero on donation from low hweight cgr=
oup

Announce: https://lore.kernel.org/linux-cve-announce/2024061917-CVE-2021-47=
584-5246@gregkh/

Introduced by commit f1de243 ("blk-iocost: revamp donation amount
determination") in v5.10-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edaa26334c117a584add6053f48d63a988d25a6e]
stable/5.10: [a7c80674538f15f85d68138240aae440b8039519]
stable/5.15: [3a1a4eb574178c21241a6200f4785572e661c472]

CVE-2021-47585: btrfs: fix memory leak in __add_inode_ref()

Announce: https://lore.kernel.org/linux-cve-announce/2024061917-CVE-2021-47=
585-0a6a@gregkh/

Introduced by commit d3316c8 ("btrfs: Properly handle backref_in_log
retval") in v5.5-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f35838a6930296fc1988764cfa54cb3f705c0665]
stable/5.10: [005d9292b5b2e71a009f911bd85d755009b37242]
stable/5.15: [493ff661d434d6bdf02e3a21adae04d7a0b4265d]

CVE-2021-47586: net: stmmac: dwmac-rk: fix oob read in rk_gmac_setup

Announce: https://lore.kernel.org/linux-cve-announce/2024061917-CVE-2021-47=
586-69ce@gregkh/

Introduced by commit 3bb3d6b ("net: stmmac: Add RK3566/RK3568 SoC
support") in v5.14-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0546b224cc7717cc8a2db076b0bb069a9c430794]
stable/5.15: [0b4a5d1e15ce72f69be48f38dc0401dab890ae0f]

CVE-2021-47587: net: systemport: Add global locking for descriptor lifecycl=
e

Announce: https://lore.kernel.org/linux-cve-announce/2024061918-CVE-2021-47=
587-9146@gregkh/

Introduced by commit 80105be ("net: systemport: add Broadcom
SYSTEMPORT Ethernet MAC driver") in v3.16-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [8ed2f5d08d6e59f8c78b2869bfb95d0be32c094c]
cip/4.4-rt: [8ed2f5d08d6e59f8c78b2869bfb95d0be32c094c]
cip/4.4-st: [8ed2f5d08d6e59f8c78b2869bfb95d0be32c094c]
mainline: [8b8e6e782456f1ce02a7ae914bbd5b1053f0b034]
stable/4.19: [595a684fa6f23b21958379a18cfa83862c73c2e1]
stable/5.10: [6e1011cd183faae8daff275c72444edcdfe0d473]
stable/5.15: [eb4687c7442942e115420a30185f8d83faf37696]
stable/5.4: [c675256a7f131f5ba3f331efb715e8f31ea0e392]

CVE-2021-47588: sit: do not call ipip6_dev_free() from sit_init_net()

Announce: https://lore.kernel.org/linux-cve-announce/2024061918-CVE-2021-47=
588-7298@gregkh/

Introduced by commit cf124db ("net: Fix inconsistent teardown and
release of private netdev state.") in v4.12-rc6.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e28587cc491ef0f3c51258fdc87fbc386b1d4c59]
stable/4.19: [e56b65c1e74d7f706d74b51baba15187be2fb4b5]
stable/5.10: [6f46c59e60b64620d5d386c8ee2eaa11ebe3b595]
stable/5.15: [44a6c846bc3a7efe7d394bab8b2ae3b7f580e190]
stable/5.4: [ad0ed314d6167b212939e3839428ba0c8bb16adb]

CVE-2021-47589: igbvf: fix double free in `igbvf_probe`

Announce: https://lore.kernel.org/linux-cve-announce/2024061918-CVE-2021-47=
589-d405@gregkh/

Introduced by commit d4e0fe0 (igbvf: add new driver to support 82576
virtual functions) in v2.6.30-rc2.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [ffe1695b678729edec04037e691007900a2b2beb]
cip/4.4-rt: [ffe1695b678729edec04037e691007900a2b2beb]
cip/4.4-st: [ffe1695b678729edec04037e691007900a2b2beb]
mainline: [b6d335a60dc624c0d279333b22c737faa765b028]
stable/4.19: [cc9b655bb84f1be283293dfea94dff9a31b106ac]
stable/5.10: [74a16e062b23332d8db017ff4a41e16279c44411]
stable/5.15: [944b8be08131f5faf2cd2440aa1c24a39a163a54]
stable/5.4: [8addba6cab94ce01686ea2e80ed1530f9dc33a9a]

CVE-2021-47590: mptcp: fix deadlock in __mptcp_push_pending()

Announce: https://lore.kernel.org/linux-cve-announce/2024061919-CVE-2021-47=
590-6db0@gregkh/

Introduced by commit 1b3e7ed ("mptcp: setsockopt: handle SO_KEEPALIVE
and SO_PRIORITY") in v5.13-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d79e3756ca90f7a6087b77b62c1d9c0801e0820]
stable/5.15: [23311b92755ffa9087332d1bb8c71c0f6a10cc08]

CVE-2021-47591: mptcp: remove tcp ulp setsockopt support

Announce: https://lore.kernel.org/linux-cve-announce/2024061919-CVE-2021-47=
591-955a@gregkh/

Introduced by commit d9e4c12 ("mptcp: only admit explicitly supported
sockopt") in v5.13-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [404cd9a22150f24acf23a8df2ad0c094ba379f57]
stable/5.15: [3de0c86d42f841d1d64f316cd949e65c566f0734]

CVE-2021-47592: net: stmmac: fix tc flower deletion for VLAN priority
Rx steering

Announce: https://lore.kernel.org/linux-cve-announce/2024061919-CVE-2021-47=
592-7ca6@gregkh/

Introduced by commit 0e039f5 ("net: stmmac: add RX frame steering
based on VLAN priority in tc flower") in v5.13-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aeb7c75cb77478fdbf821628e9c95c4baa9adc63]
stable/5.15: [97cb5c82aa1dd85a39b1bd021c8b5f18af623779]

CVE-2021-47593: mptcp: clear 'kern' flag from fallback sockets

Announce: https://lore.kernel.org/linux-cve-announce/2024061919-CVE-2021-47=
593-a7a7@gregkh/

Introduced by commit cf7da0d ("mptcp: Create SUBFLOW socket for
incoming connections") in v5.6-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6692b3b97bdc165d150f4c1505751a323a80717]
stable/5.10: [451f1eded7f56e93aaf52eb547ba97742d9c0e97]
stable/5.15: [c26ac0ea3a91c210cf90452e625dc441adf3e549]

CVE-2021-47594: mptcp: never allow the PM to close a listener subflow

Announce: https://lore.kernel.org/linux-cve-announce/2024061920-CVE-2021-47=
594-953e@gregkh/

Introduced by commit 740d798 ("mptcp: remove id 0 address") in v5.13-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0cdc5dbcf2ba0d99785da5aabf1b17943805b8a]
stable/5.15: [1456a0004cc54c58adb2501cb0c95dc8b3c83e9e]

CVE-2021-47595: net/sched: sch_ets: don't remove idle classes from the
round-robin list

Announce: https://lore.kernel.org/linux-cve-announce/2024061920-CVE-2021-47=
595-e9f3@gregkh/

Introduced by commit de6d259 ("net/sched: sch_ets: don't peek at classes
beyond 'nbands'") in 5.16-rc3. Fixed in 5.16-rc6.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [c062f2a0b04d86c5b8c9d973bea43493eaca3d32]
stable/5.10: [81fbdd45652d8605a029e78ef14a6aaa529c4e72]
stable/5.15: [491c1253441e2fdc8f6a6f4976e3f13440419b7a]

CVE-2021-47596: net: hns3: fix use-after-free bug in hclgevf_send_mbx_msg

Announce: https://lore.kernel.org/linux-cve-announce/2024061920-CVE-2021-47=
596-cd94@gregkh/

Introduced by commit d835524 ("net: hns3: add trace event support for
PF/VF mailbox") in v5.8-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27cbf64a766e86f068ce6214f04c00ceb4db1af4]
stable/5.10: [12512bc8f25b8ba9795dfbae0e9ca57ff13fd542]
stable/5.15: [4f4a353f6fe033807cd026a5de81c67469ff19b0]

CVE-2021-47597: inet_diag: fix kernel-infoleak for UDP sockets

Announce: https://lore.kernel.org/linux-cve-announce/2024061921-CVE-2021-47=
597-7dd2@gregkh/

Introduced by commit 3c4d05c ("inet_diag: Introduce the inet socket
dumping routine") in v3.3-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71ddeac8cd1d217744a0e060ff520e147c9328d1]
stable/5.10: [3a4f6dba1eb98101abc012ef968a8b10dac1ce50]
stable/5.15: [e5d28205bf1de7082d904ed277ceb2db2879e302]
stable/5.4: [7b5596e531253ce84213d9daa7120b71c9d83198]

CVE-2021-47598: sch_cake: do not call cake_destroy() from cake_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024061921-CVE-2021-47=
598-3fad@gregkh/

Introduced by commit 046f6fd ("sched: Add Common Applications Kept
Enhanced (cake) qdisc") in v4.19-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab443c53916730862cec202078d36fd4008bea79]
stable/4.19: [4e388232e630ebe4f94b4a0715ec98c0e2b314a3]
stable/5.10: [20ad1ef02f9ad5e1dda9eeb113e4c158b4806986]
stable/5.15: [f6deae2e2d83bd267e1986f5d71d8c458e18fd99]
stable/5.4: [0d80462fbdcafd536dcad7569e65d3d14a7e9f2f]

CVE-2021-47599: btrfs: use latest_dev in btrfs_show_devname

Announce: https://lore.kernel.org/linux-cve-announce/2024061921-CVE-2021-47=
599-37b9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc1.
It seems as if prior to 5.16 kernels might be affected.

Fixed status
mainline: [6605fd2f394bba0a0059df2b6cfc87b0b6d393a2]
stable/5.15: [e342c2558016ead462f376b6c6c2ac5efc17f3b1]

CVE-2021-47600: dm btree remove: fix use after free in rebalance_children()

Announce: https://lore.kernel.org/linux-cve-announce/2024061922-CVE-2021-47=
600-5cc4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc6.

Fixed status
cip/4.4: [a48f6a2bf33734ec5669ee03067dfb6c5b4818d6]
cip/4.4-rt: [a48f6a2bf33734ec5669ee03067dfb6c5b4818d6]
cip/4.4-st: [a48f6a2bf33734ec5669ee03067dfb6c5b4818d6]
mainline: [1b8d2789dad0005fd5e7d35dab26a8e1203fb6da]
stable/4.19: [293f957be5e39720778fb1851ced7f5fba6d51c3]
stable/5.10: [0e21e6cd5eebfc929ac5fa3b97ca2d4ace3cb6a3]
stable/5.15: [607beb420b3fe23b948a9bf447d993521a02fbbb]
stable/5.4: [501ecd90efdc9b2edc6c28852ecd098a4adf8f00]

CVE-2021-47601: tee: amdtee: fix an IS_ERR() vs NULL bug

Announce: https://lore.kernel.org/linux-cve-announce/2024061922-CVE-2021-47=
601-5e15@gregkh/

Introduced by commit 757cc3e ("tee: add AMD-TEE driver") in v5.6-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d7482771fac8d8e38e763263f2ca0ca12dd22c6]
stable/5.10: [640e28d618e82be78fb43b4bf5113bc90d6aa442]
stable/5.15: [832f3655c6138c23576ed268e31cc76e0f05f2b1]

CVE-2021-47602: mac80211: track only QoS data frames for admission control

Announce: https://lore.kernel.org/linux-cve-announce/2024061922-CVE-2021-47=
602-d8dc@gregkh/

Introduced by commit 02219b3 ("mac80211: add WMM admission control
support") in v3.19-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5e568c3a4ec2ddd23e7dc5ad5b0c64e4f22981a]
stable/4.19: [69f054d6642c8f6173724ce17e7ee3ff66b8f682]
stable/5.10: [eed897a22230e3231a740eddd7d6d95ba476625f]
stable/5.15: [42d08e97b196479f593499e887a9ab81446a34b9]
stable/5.4: [46b9e29db2012a4d2a40a26101862e002ccf387b]

CVE-2021-47603: audit: improve robustness of the audit queue handling

Announce: https://lore.kernel.org/linux-cve-announce/2024061922-CVE-2021-47=
603-ec18@gregkh/

Introduced by commit 5b52330 ("audit: fix auditd/kernel connection
state tracking") in v4.11-rc4.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4b3ee3c85551d2d343a3ba159304066523f730f]
stable/4.19: [8389f50ceb854cb437fefb9330d5024ed3c7c1f5]
stable/5.10: [4cc6badff97f74d0fce65f9784b5df3b64e4250b]
stable/5.15: [a5f4d17daf2e6cd7c1d9676b476147f6b4ac53f2]
stable/5.4: [0d3277eabd542fb662be23696e5ec9f390d688e1]

CVE-2021-47604: vduse: check that offset is within bounds in get_config()

Announce: https://lore.kernel.org/linux-cve-announce/2024061923-CVE-2021-47=
604-e309@gregkh/

Introduced by commit c8a6153 ("vduse: Introduce VDUSE - vDPA Device in
Userspace") in v5.15-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc1db0060c02d119fd4196924eff2d1129e9a442]
stable/5.15: [ebbbc5fea3f648175df1aa3f127c78eb0252cc2a]

CVE-2021-47605: vduse: fix memory corruption in vduse_dev_ioctl()

Announce: https://lore.kernel.org/linux-cve-announce/2024061923-CVE-2021-47=
605-3d20@gregkh/

Introduced by commit c8a6153 ("vduse: Introduce VDUSE - vDPA Device in
Userspace") in v5.15-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff9f9c6e74848170fcb45c8403c80d661484c8c9]
stable/5.15: [e6c67560b4341914bec32ec536e931c22062af65]

CVE-2021-47606: net: netlink: af_netlink: Prevent empty skb by adding
a check on len.

Announce: https://lore.kernel.org/linux-cve-announce/2024061923-CVE-2021-47=
606-daa5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.16-rc4.

Fixed status
cip/4.4: [c54a60c8fbaa774f828e26df79f66229a8a0e010]
cip/4.4-rt: [c54a60c8fbaa774f828e26df79f66229a8a0e010]
cip/4.4-st: [c54a60c8fbaa774f828e26df79f66229a8a0e010]
mainline: [f123cffdd8fe8ea6c7fded4b88516a42798797d0]
stable/4.19: [ff3f517bf7138e01a17369042908a3f345c0ee41]
stable/5.10: [dadce61247c6230489527cc5e343b6002d1114c5]
stable/5.15: [4c986072a8c9249b9398c7a18f216dc26a9f0e35]
stable/5.4: [c0315e93552e0d840e9edc6abd71c7db82ec8f51]

CVE-2021-47607: bpf: Fix kernel address leakage in atomic cmpxchg's r0 aux =
reg

Announce: https://lore.kernel.org/linux-cve-announce/2024061924-CVE-2021-47=
607-0fbd@gregkh/

Introduced by commit 5ffa255 ("bpf: Add instructions for
atomic_[cmp]xchg") in v5.12-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a82fe085f344ef20b452cd5f481010ff96b5c4cd]
stable/5.15: [f87a6c160ecc8c7b417d25f508d3f076fe346136]

CVE-2021-47608: bpf: Fix kernel address leakage in atomic fetch

Announce: https://lore.kernel.org/linux-cve-announce/2024061924-CVE-2021-47=
608-f4eb@gregkh/

Introduced by commit 37086bf ("bpf: Propagate stack bounds to
registers in atomics w/ BPF_FETCH") in v5.12-rc1.
Fixed in v5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d3baf0afa3aa9102d6a521a8e4c41888bb79882]
stable/5.15: [423628125a484538111c2c6d9bb1588eb086053b]

CVE-2021-47609: firmware: arm_scpi: Fix string overflow in SCPI genpd drive=
r

Announce: no reference

None
Introduced by commit 8bec433 ("firmware: scpi: add device power domain
support using genpd") in 4.8-rc1. Fixed in 5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [865ed67ab955428b9aa771d8b4f1e4fb7fd08945]
stable/4.19: [7e8645ca2c0046f7cd2f0f7d569fc036c8abaedb]
stable/5.10: [f0f484714f35d24ffa0ecb4afe3df1c5b225411d]
stable/5.15: [976389cbb16cee46847e5d06250a3a0b5506781e]
stable/5.4: [802a1a8501563714a5fe8824f4ed27fec04a0719]

CVE-2021-47610: drm/msm: Fix null ptr access msm_ioctl_gem_submit()

Announce: no reference

None
Since commit 79341eb74 ("drm/msm: Return ERR_PTR() from submit_create()")
in 5.15-rc1, submit_create() returns ERROR reason instead of NULL.
So, msm_ioctl_gem_submit() needs to set NULL to submit value because
msm_ioctl_gem_submit() check if submit is NULL or not before leaving this
function.
Fixed in 5.16-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26d776fd0f79f093a5d0ce1a4c7c7a992bc3264c]
stable/5.15: [f6db3d98f876870c35e96693cfd54752f6199e59]

CVE-2021-47611: mac80211: validate extended element ID is present

Announce: no reference

None
Introduced by commit 41cbb0f ("mac80211: add support for HE") in 4.19-rc1.
Fixed in 5.16-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [768c0b19b50665e337c96858aa2b7928d6dcf756]
stable/4.19: [03029bb044ccee60adbc93e70713f3ae58abc3a1]
stable/5.10: [7fd214fc7f2ee3a89f91e717e3cfad55f5a27045]
stable/5.15: [c62b16f98688ae7bc0ab23a6490481f4ce9b3a49]
stable/5.4: [a19cf6844b509d44ecbd536f33d314d91ecdd2b5]

CVE-2021-47612: nfc: fix segfault in nfc_genl_dump_devices_done

Announce: no reference

None
Introduced commit is not determined.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [ea55b3797878752aa076b118afb727dcf79cac34]
cip/4.4-rt: [ea55b3797878752aa076b118afb727dcf79cac34]
cip/4.4-st: [ea55b3797878752aa076b118afb727dcf79cac34]
mainline: [fd79a0cbf0b2e34bcc45b13acf962e2032a82203]
stable/4.19: [2a8845b9603c545fddd17862282dc4c4ce0971e3]
stable/5.10: [c602863ad28ec86794cb4ab4edea5324f555f181]
stable/5.15: [d89e4211b51752daf063d638af50abed2fd5f96d]
stable/5.4: [d731ecc6f2eaec68f4ad1542283bbc7d07bd0112]

CVE-2021-47613: i2c: virtio: fix completion handling

Announce: no reference

None
Introduced by commit 3cfc883 ("i2c: virtio: add a virtio i2c frontend
driver") in 5.15-rc1. Fixed in 5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b503de239f62eca898cfb7e820d9a35499137d22]
stable/5.15: [9cbb957441ed8873577d7d313a3d79d69f1dad5c]

CVE-2021-47614: RDMA/irdma: Fix a user-after-free in add_pble_prm

Announce: no reference

None
Introduced by commit e8c4dbc ("RDMA/irdma: Add PBLE resource manager")
in 5.14-rc1. Fixed in 5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e11a39a82e95ce86f849f40dda0d9c0498cebd9]
stable/5.15: [11eebcf63e98fcf047a876a51d76afdabc3b8b9b]

CVE-2021-47615: RDMA/mlx5: Fix releasing unallocated memory in dereg MR flo=
w

Announce: https://lore.kernel.org/linux-cve-announce/2024061909-CVE-2021-47=
615-3c6a@gregkh/

Introduced by commit f18ec42 ("RDMA/mlx5: Use a union inside
mlx5_ib_mr") in v5.13-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0ae4afe3d35e67db042c58a52909e06262b740f]
stable/5.15: [c44979ace49b4aede3cc7cb5542316e53a4005c9]

CVE-2021-47616: RDMA: Fix use-after-free in rxe_queue_cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024061909-CVE-2021-47=
616-5ee0@gregkh/

Introduced by commit 514aee6 ("RDMA: Globally allocate and release QP
memory") in v5.15-rc1.
Fixed in v5.16-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84b01721e8042cdd1e8ffeb648844a09cd4213e0]
stable/5.15: [acb53e47db1fbc7cd37ab10b46388f045a76e383]

CVE-2024-36978: net: sched: sch_multiq: fix possible OOB write in multiq_tu=
ne()

Announce: https://lore.kernel.org/linux-cve-announce/2024061926-CVE-2024-36=
978-b4b8@gregkh/

Introduced by commit c2999f7 ("net: sched: multiq: don't call
qdisc_put() while holding tree lock") in v5.4-rc1.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [affc18fdc694190ca7575b9a86632a73b9fe043d]

CVE-2024-36979: net: bridge: mst: fix vlan use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024061945-CVE-2024-36=
979-b4a6@gregkh/

Introduced by commit ec7328b ("net: bridge: mst: Multiple Spanning
Tree (MST) mode") in v5.18-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a7c1661ae1383364cd6092d851f5e5da64d476b]
stable/6.1: [8ca9a750fc711911ef616ceb627d07357b04545e]
stable/6.6: [4488617e5e995a09abe4d81add5fb165674edb59]

CVE-2024-38538: net: bridge: xmit: make sure we have at least eth
header len bytes

Announce: https://lore.kernel.org/linux-cve-announce/2024061947-CVE-2024-38=
538-e28a@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bd67ebb50c0145fd2ca8681ab65eb7e8cde1afc]
stable/6.1: [28126b83f86ab9cc7936029c2dff845d3dcedba2]
stable/6.6: [1abb371147905ba250b4cc0230c4be7e90bea4d5]

CVE-2024-38539: RDMA/cma: Fix kmemleak in rdma_core observed during
blktests nvme/rdma use siw

Announce: https://lore.kernel.org/linux-cve-announce/2024061947-CVE-2024-38=
539-5ae1@gregkh/

Introduced by commit f8ef1be ("RDMA/cma: Avoid GID lookups on iWARP
devices") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c0731832d3b7420cbadba6a7f334363bc8dfb15]
stable/6.6: [3eb127dc408bf7959a4920d04d16ce10e863686a]

CVE-2024-38540: bnxt_re: avoid shift undefined behavior in
bnxt_qplib_alloc_init_hwq

Announce: https://lore.kernel.org/linux-cve-announce/2024061947-CVE-2024-38=
540-1d0a@gregkh/

Introduced by commit 0c4dcd6 ("RDMA/bnxt_re: Refactor hardware queue
memory allocation") in v5.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78cfd17142ef70599d6409cbd709d94b3da58659]
stable/6.6: [a658f011d89dd20cf2c7cb4760ffd79201700b98]

CVE-2024-38541: of: module: add buffer overflow check in of_modalias()

Announce: https://lore.kernel.org/linux-cve-announce/2024061948-CVE-2024-38=
541-53d0@gregkh/

Introduced by commit bc57506 ("of/device: use
of_property_for_each_string to parse compatible strings") in
v4.14-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf7385cb26ac4f0ee6c7385960525ad534323252]
stable/6.6: [0b0d5701a8bf02f8fee037e81aacf6746558bfd6]

CVE-2024-38542: RDMA/mana_ib: boundary check before installing cq callbacks

Announce: https://lore.kernel.org/linux-cve-announce/2024061948-CVE-2024-38=
542-2481@gregkh/

Introduced by commit 2a31c5a ("RDMA/mana_ib: Introduce
mana_ib_install_cq_cb helper function") in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f79edef79b6a2161f4124112f9b0c46891bb0b74]

CVE-2024-38543: lib/test_hmm.c: handle src_pfns and dst_pfns allocation fai=
lure

Announce: https://lore.kernel.org/linux-cve-announce/2024061948-CVE-2024-38=
543-ff2e@gregkh/

Introduced by commit b2ef9f5 ("mm/hmm/test: add selftest driver for
HMM") in v5.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2af060d1c18beaec56351cf9c9bcbbc5af341a3]
stable/6.1: [1a21fdeea502658e315bd939409b755974f4fb64]
stable/6.6: [65e528a69cb3ed4a286c45b4afba57461c8b5b33]

CVE-2024-38544: RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt

Announce: https://lore.kernel.org/linux-cve-announce/2024061949-CVE-2024-38=
544-601b@gregkh/

Introduced by commit 0b1e5b9 ("IB/rxe: Add port protocol stats") in v4.12-r=
c1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b23b6097303ed0ba5f4bc036a1c07b6027af5c6]
stable/6.1: [faa8d0ecf6c9c7c2ace3ca3e552180ada6f75e19]
stable/6.6: [21b4c6d4d89030fd4657a8e7c8110fd941049794]

CVE-2024-38545: RDMA/hns: Fix UAF for cq async event

Announce: https://lore.kernel.org/linux-cve-announce/2024061949-CVE-2024-38=
545-7161@gregkh/

Introduced by commit 9a44353 ("IB/hns: Add driver files for hns RoCE
driver") in v4.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a942ec2745ca864cd8512142100e4027dc306a42]
stable/6.1: [763780ef0336a973e933e40e919339381732dcaf]
stable/6.6: [63da190eeb5c9d849b71f457b15b308c94cbaf08]

CVE-2024-38546: drm: vc4: Fix possible null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024061949-CVE-2024-38=
546-ce19@gregkh/

Introduced by commit bb7d785 ("drm/vc4: Add HDMI audio support") in v4.12-r=
c1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c534b63bede6cb987c2946ed4d0b0013a52c5ba7]
stable/5.10: [2d9adecc88ab678785b581ab021f039372c324cb]
stable/5.15: [6cf1874aec42058a5ad621a23b5b2f248def0e96]
stable/6.1: [80431ea3634efb47a3004305d76486db9dd8ed49]
stable/6.6: [42c22b63056cea259d5313bf138a834840af85a5]

CVE-2024-38547: media: atomisp: ssh_css: Fix a null-pointer
dereference in load_video_binaries

Announce: https://lore.kernel.org/linux-cve-announce/2024061950-CVE-2024-38=
547-176a@gregkh/

Introduced by commit a49d253 ("staging/atomisp: Add support for the
Intel IPU v2") in v4.12-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b621e9e9e148c0928ab109ac3d4b81487469acb]
stable/5.10: [4b68b861b514a5c09220d622ac3784c0ebac6c80]
stable/5.15: [82c2c85aead3ea3cbceef4be077cf459c5df2272]
stable/6.1: [a1ab99dcc8604afe7e3bccb01b10da03bdd7ea35]
stable/6.6: [cc20c87b04db86c8e3e810bcdca686b406206069]

CVE-2024-38548: drm: bridge: cdns-mhdp8546: Fix possible null pointer
dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024061950-CVE-2024-38=
548-29a5@gregkh/

Introduced by commit fb43aa0 ("drm: bridge: Add support for Cadence
MHDP8546 DPI/DP bridge") in v5.10-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [935a92a1c400285545198ca2800a4c6c519c650a]
stable/5.10: [85d1a27402f81f2e04b0e67d20f749c2a14edbb3]
stable/5.15: [89788cd9824c28ffcdea40232c458233353d1896]
stable/6.1: [ca53b7efd4ba6ae92fd2b3085cb099c745e96965]
stable/6.6: [dcf53e6103b26e7458be71491d0641f49fbd5840]

CVE-2024-38549: drm/mediatek: Add 0 size check to mtk_drm_gem_obj

Announce: https://lore.kernel.org/linux-cve-announce/2024061950-CVE-2024-38=
549-6ae4@gregkh/

Introduced by commit 119f517 ("drm/mediatek: Add DRM Driver for
Mediatek SoC MT8173.") in v4.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e4350095e8ab2577ee05f8c3b044e661b5af9a0]
stable/4.19: [79078880795478d551a05acc41f957700030d364]
stable/5.10: [d17b75ee9c2e44d3a3682c4ea5ab713ea6073350]
stable/5.15: [0e3b6f9123726858cac299e1654e3d20424cabe4]
stable/5.4: [be34a1b351ea7faeb15dde8c44fe89de3980ae67]
stable/6.1: [13562c2d48c9ee330de1077d00146742be368f05]
stable/6.6: [af26ea99019caee1500bf7e60c861136c0bf8594]

CVE-2024-38550: ASoC: kirkwood: Fix potential NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024061950-CVE-2024-38=
550-a20b@gregkh/

Introduced by commit bb6a40f ("ASoC: kirkwood: Fix reference to PCM
buffer address") in v5.14-rc6.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea60ab95723f5738e7737b56dda95e6feefa5b50]
stable/5.15: [d48d0c5fd733bd6d8d3ddb2ed553777ab4724169]
stable/6.1: [de9987cec6fde1dd41dfcb971433e05945852489]
stable/6.6: [1a7254525ca7a6f3e37d7882d7f7ad97f6235f7c]

CVE-2024-38551: ASoC: mediatek: Assign dummy when codec not specified
for a DAI link

Announce: https://lore.kernel.org/linux-cve-announce/2024061951-CVE-2024-38=
551-babb@gregkh/

Introduced by commit 4302187 ("ASoC: mediatek: common: add soundcard
driver common code") in v6.3-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f39231888c63f0a7708abc86b51b847476379d8]
stable/6.6: [87b8dca6e06f9b1681bc52bf7bfa85c663a11158]

CVE-2024-38552: drm/amd/display: Fix potential index out of bounds in
color transformation function

Announce: https://lore.kernel.org/linux-cve-announce/2024061951-CVE-2024-38=
552-dba6@gregkh/

Introduced by commit b629596 ("drm/amd/display: Build unity lut for
shaper") in v4.16-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63ae548f1054a0b71678d0349c7dc9628ddd42ca]
stable/4.19: [604c506ca43fce52bb882cff9c1fdf2ec3b4029c]
stable/5.10: [04bc4d1090c343025d69149ca669a27c5b9c34a7]
stable/5.15: [ced9c4e2289a786b8fa684d8893b7045ea53ef7e]
stable/5.4: [e280ab978c81443103d7c61bdd1d8d708cf6ed6d]
stable/6.1: [98b8a6bfd30d07a19cfacdf82b50f84bf3360869]
stable/6.6: [4e8c8b37ee84b3b19c448d2b8e4c916d2f5b9c86]

CVE-2024-38553: net: fec: remove .ndo_poll_controller to avoid deadlocks

Announce: https://lore.kernel.org/linux-cve-announce/2024061951-CVE-2024-38=
553-2e34@gregkh/

Introduced by commit 7f5c6ad ("net/fec: add poll controller function
for fec nic") in v3.2-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2e0c58b25a0a0c37ec643255558c5af4450c9f5]
stable/6.6: [d38625f71950e79e254515c5fc585552dad4b33e]

CVE-2024-38554: ax25: Fix reference count leak issue of net_device

Announce: https://lore.kernel.org/linux-cve-announce/2024061952-CVE-2024-38=
554-29b0@gregkh/

Introduced by commit d01ffb9 ("ax25: add refcount in ax25_dev to avoid
UAF bugs") in v5.17-rc3.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [36e56b1b002bb26440403053f19f9e1a8bc075b2]
stable/6.1: [3ec437f9bbae68e9b38115c4c91de995f73f6bad]
stable/6.6: [965d940fb7414b310a22666503d2af69459c981b]

CVE-2024-38555: net/mlx5: Discard command completions in internal error

Announce: https://lore.kernel.org/linux-cve-announce/2024061952-CVE-2024-38=
555-aefb@gregkh/

Introduced by commit 51d138c ("net/mlx5: Fix health error state
handling") in v5.12-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [db9b31aa9bc56ff0d15b78f7e827d61c4a096e40]
stable/5.10: [f6fbb8535e990f844371086ab2c1221f71f993d3]
stable/5.15: [3cb92b0ad73d3f1734e812054e698d655e9581b0]
stable/6.1: [bf8aaf0ae01c27ae3c06aa8610caf91e50393396]
stable/6.6: [1337ec94bc5a9eed250e33f5f5c89a28a6bfabdb]

CVE-2024-38556: net/mlx5: Add a timeout to acquire the command queue semaph=
ore

Announce: https://lore.kernel.org/linux-cve-announce/2024061952-CVE-2024-38=
556-8afa@gregkh/

Introduced by commit 8e715cd ("net/mlx5: Set command entry semaphore
up once got index free") in v5.17-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [485d65e1357123a697c591a5aeb773994b247ad7]
stable/6.1: [4baae687a20ef2b82fde12de3c04461e6f2521d6]
stable/6.6: [f9caccdd42e999b74303c9b0643300073ed5d319]

CVE-2024-38557: net/mlx5: Reload only IB representors upon lag disable/enab=
le

Announce: https://lore.kernel.org/linux-cve-announce/2024061953-CVE-2024-38=
557-2cb9@gregkh/

Introduced by commit 598fe77 ("net/mlx5: Lag, Create shared FDB when
in switchdev mode") in v5.15-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f06228d4a2dcc1fca5b3ddb0eefa09c05b102c4]
stable/6.6: [e93fc8d959e56092e2eca1e5511c2d2f0ad6807a]

CVE-2024-38558: net: openvswitch: fix overwriting ct original tuple for ICM=
Pv6

Announce: https://lore.kernel.org/linux-cve-announce/2024061953-CVE-2024-38=
558-ddfd@gregkh/

Introduced by commit 9dd7f89 ("openvswitch: Add original direction
conntrack tuple to sw_flow_key.") in v4.11-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [c5085dfa5124fae28a0a7db8c11a36c1530994d3]
cip/4.4-st: [c5085dfa5124fae28a0a7db8c11a36c1530994d3]
mainline: [7c988176b6c16c516474f6fceebe0f055af5eb56]
stable/4.19: [6a51ac92bf35d34b4996d6eb67e2fe469f573b11]
stable/5.10: [5ab6aecbede080b44b8e34720ab72050bf1e6982]
stable/5.15: [483eb70f441e2df66ade78aa7217e6e4caadfef3]
stable/5.4: [0b532f59437f688563e9c58bdc1436fefa46e3b5]
stable/6.1: [9ec8b0ccadb908d92f7ee211a4eff05fd932f3f6]
stable/6.6: [78741b4caae1e880368cb2f5110635f3ce45ecfd]

CVE-2024-38559: scsi: qedf: Ensure the copied buf is NUL terminated

Announce: https://lore.kernel.org/linux-cve-announce/2024061953-CVE-2024-38=
559-3e03@gregkh/

Introduced by commit 61d8658 ("scsi: qedf: Add QLogic FastLinQ offload
FCoE driver framework.") in v4.11-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0184a375ee797eb657d74861ba0935b6e405c62]
stable/4.19: [1f84a2744ad813be23fc4be99fb74bfb24aadb95]
stable/5.10: [769b9fd2af02c069451fe9108dba73355d9a021c]
stable/5.15: [dccd97b39ab2f2b1b9a47a1394647a4d65815255]
stable/5.4: [a75001678e1d38aa607d5b898ec7ff8ed0700d59]
stable/6.1: [d93318f19d1e1a6d5f04f5d965eaa9055bb7c613]
stable/6.6: [563e609275927c0b75fbfd0d90441543aa7b5e0d]

CVE-2024-38560: scsi: bfa: Ensure the copied buf is NUL terminated

Announce: https://lore.kernel.org/linux-cve-announce/2024061953-CVE-2024-38=
560-f0a2@gregkh/

Introduced by commit 9f30b67 ("bfa: replace 2 kzalloc/copy_from_user
by memdup_user") in v3.19-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [7bba9abccf60bc73e95b0aa565ebb05e7d156bf8]
cip/4.4-st: [7bba9abccf60bc73e95b0aa565ebb05e7d156bf8]
mainline: [13d0cecb4626fae67c00c84d3c7851f6b62f7df3]
stable/4.19: [481fc0c8617304a67649027c4a44723a139a0462]
stable/5.10: [00b425ff0891283207d7bad607a2412225274d7a]
stable/5.15: [1708e3cf2488788cba5489e4f913d227de757baf]
stable/5.4: [595a6b98deec01b6dbb20139f71edcd5fb760ec2]
stable/6.1: [7d3e694c4fe30f3aba9cd5ae86fb947a54c3db5c]
stable/6.6: [204714e68015d6946279719fd464ecaf57240f35]

CVE-2024-38561: kunit: Fix kthread reference

Announce: https://lore.kernel.org/linux-cve-announce/2024061954-CVE-2024-38=
561-2505@gregkh/

Introduced by commit adf5054 ("kunit: fix UAF when run kfence test
case test_gfpzero") in v5.18-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8aa1b98ce40184521ed95ec26cc115a255183b2]
stable/6.1: [1f2ebd3758e1cef6a1f998a1f7ea73310dcb1699]
stable/6.6: [1ec7ccb4cd4b6f72c2998b07880fa7aaf8dfe1d4]

CVE-2024-38562: wifi: nl80211: Avoid address calculations via out of
bounds array indexing

Announce: https://lore.kernel.org/linux-cve-announce/2024061954-CVE-2024-38=
562-21d9@gregkh/

Introduced by commit e3eac9f ("wifi: cfg80211: Annotate struct
cfg80211_scan_request with __counted_by") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [838c7b8f1f278404d9d684c34a8cb26dc41aaaa1]
stable/6.6: [ed74398642fcb19f6ff385c35a7d512c6663e17b]

CVE-2024-38563: wifi: mt76: mt7996: fix potential memory leakage when
reading chip temperature

Announce: https://lore.kernel.org/linux-cve-announce/2024061954-CVE-2024-38=
563-2c2e@gregkh/

Introduced by commit 6879b2e ("wifi: mt76: mt7996: add thermal sensor
device support") in v6.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [474b9412f33be87076b40a49756662594598a85e]

CVE-2024-38564: bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
enforcement in BPF_LINK_CREATE

Announce: https://lore.kernel.org/linux-cve-announce/2024061955-CVE-2024-38=
564-b069@gregkh/

Introduced by commit af6eea5 ("bpf: Implement bpf_link-based cgroup
BPF program attachment") in v5.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [543576ec15b17c0c93301ac8297333c7b6e84ac7]
stable/6.6: [6675c541f540a29487a802d3135280b69b9f568d]

CVE-2024-38565: wifi: ar5523: enable proper endpoint verification

Announce: https://lore.kernel.org/linux-cve-announce/2024061955-CVE-2024-38=
565-9d22@gregkh/

Introduced by commit b7d572e ("ar5523: Add new driver") in v3.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [27b55ff4e36f0e43d277d4a47a12a02bb27cf11f]
cip/4.4-st: [27b55ff4e36f0e43d277d4a47a12a02bb27cf11f]
mainline: [e120b6388d7d88635d67dcae6483f39c37111850]
stable/4.19: [79ddf5f2020fd593d50f1363bb5131283d74f78f]
stable/5.10: [ee25389df80138907bc9dcdf4a2be2067cde9a81]
stable/5.15: [b4c24de37a6bb383394a6fef2b85a6db41d426f5]
stable/5.4: [68a5a00c5d38978a3f8460c6f182f7beec8688ff]
stable/6.1: [34f7ebff1b9699e0b89fa58b693bc098c2f5ec72]
stable/6.6: [b33a81e4ecfb022b028cae37d1c1ce28ac1b359d]

CVE-2024-38566: bpf: Fix verifier assumptions about socket->sk

Announce: https://lore.kernel.org/linux-cve-announce/2024061955-CVE-2024-38=
566-0ac6@gregkh/

Introduced by commit 6fcd486 ("bpf: Refactor RCU enforcement in the
verifier.") in v6.4-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0db63c0b86e981a1e97d2596d64ceceba1a5470e]
stable/6.6: [39f8a29330f433000e716eefc4b9abda05b71a82]

CVE-2024-38567: wifi: carl9170: add a proper sanity check for endpoints

Announce: https://lore.kernel.org/linux-cve-announce/2024061956-CVE-2024-38=
567-5724@gregkh/

Introduced by commit a84fab3 ("carl9170: 802.11 rx/tx processing and
usb backend") in v2.6.37-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [e404d8ab5fe1aaae7ae45afe6e82d310bcb4ee63]
cip/4.4-st: [e404d8ab5fe1aaae7ae45afe6e82d310bcb4ee63]
mainline: [b6dd09b3dac89b45d1ea3e3bd035a3859c0369a0]
stable/4.19: [eb0f2fc3ff5806cc572cd9055ce7c52a01e97645]
stable/5.10: [8650725bb0a48b206d5a8ddad3a7488f9a5985b7]
stable/5.15: [6a9892bf24c906b4d6b587f8759ca38bff672582]
stable/5.4: [ac3ed46a8741d464bc70ebdf7433c1d786cf329d]
stable/6.1: [265c3cda471c26e0f25d0c755da94e1eb15d7a0c]
stable/6.6: [62eb07923f3693d55b0c2d9a5a4f1ad72cb6b8fd]

CVE-2024-38568: drivers/perf: hisi: hns3: Fix out-of-bound access when
valid event group

Announce: https://lore.kernel.org/linux-cve-announce/2024061956-CVE-2024-38=
568-86e2@gregkh/

Introduced by commit 66637ab ("drivers/perf: hisi: add driver for HNS3
PMU") in v6.0-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81bdd60a3d1d3b05e6cc6674845afb1694dd3a0e]
stable/6.1: [3669baf308308385a2ab391324abdde5682af5aa]
stable/6.6: [be1fa711e59c874d049f592aef1d4685bdd22bdf]

CVE-2024-38569: drivers/perf: hisi_pcie: Fix out-of-bound access when
valid event group

Announce: https://lore.kernel.org/linux-cve-announce/2024061956-CVE-2024-38=
569-2a26@gregkh/

Introduced by commit 8404b0f ("drivers/perf: hisi: Add driver for
HiSilicon PCIe PMU") in v5.17-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77fce82678ea5fd51442e62febec2004f79e041b]
stable/6.1: [3d1face00ebb7996842aee4214d7d0fb0c77b1e9]
stable/6.6: [8e9aab2492178f25372f1820bfd9289fbd74efd0]

CVE-2024-38570: gfs2: Fix potential glock use-after-free on unmount

Announce: https://lore.kernel.org/linux-cve-announce/2024061956-CVE-2024-38=
570-a8ef@gregkh/

Introduced by commit fb6791d ("GFS2: skip dlm_unlock calls in
unmount") in v3.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d98779e687726d8f8860f1c54b5687eec5f63a73]
stable/6.6: [0636b34b44589b142700ac137b5f69802cfe2e37]

CVE-2024-38571: thermal/drivers/tsens: Fix null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024061957-CVE-2024-38=
571-fbe7@gregkh/

Introduced by commit dfc1193 ("thermal/drivers/tsens: Replace custom
8960 apis with generic apis") in v5.13-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d998ddc86a27c92140b9f7984ff41e3d1d07a48f]
stable/5.15: [27600e0c5272a262b0903e35ae1df37d33c5c1ad]
stable/6.1: [11c731386ed82053c2759b6fea1a82ae946e5e0f]
stable/6.6: [2d5ca6e4a2872e92a32fdfd87e04dd7d3ced7278]

CVE-2024-38572: wifi: ath12k: fix out-of-bound access of qmi_invoke_handler=
()

Announce: https://lore.kernel.org/linux-cve-announce/2024061957-CVE-2024-38=
572-28d5@gregkh/

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1bdff48a1bb4a4ac660c19c55a820968c48b3f2]
stable/6.6: [95575de7dede7b1ed3b9718dab9dda97914ea775]

CVE-2024-38573: cppc_cpufreq: Fix possible null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024061957-CVE-2024-38=
573-d4b6@gregkh/

Introduced by commit a28b2bf ("cppc_cpufreq: replace per-cpu data
array with a list") in v5.11-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf7de25878a1f4508c69dc9f6819c21ba177dbfe]
stable/5.15: [9a185cc5a79ba408e1c73375706630662304f618]
stable/6.1: [769c4f355b7962895205b86ad35617873feef9a5]
stable/6.6: [f84b9b25d045e67a7eee5e73f21278c8ab06713c]

CVE-2024-38574: libbpf: Prevent null-pointer dereference when prog to
load has no BTF

Announce: https://lore.kernel.org/linux-cve-announce/2024061958-CVE-2024-38=
574-d9a9@gregkh/

Introduced by commit df7c3f7 ("libbpf: make uniform use of btf__fd()
accessor inside libbpf") in v6.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bf48fa19a4b1d186e08b20bf7e5de26a15644fb]

CVE-2024-38575: wifi: brcmfmac: pcie: handle randbuf allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024061946-CVE-2024-38=
575-8b6b@gregkh/

Introduced by commit 91918ce ("wifi: brcmfmac: pcie: Provide a buffer
of random bytes to the device") in v6.4-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [316f790ebcf94bdf59f794b7cdea4068dc676d4c]
stable/6.1: [0eb2c0528e232b3c32cde9d5e1c9f80ba2996e49]
stable/6.6: [c37466406f075476c2702ecc01917928af871f3b]

CVE-2024-38576: rcu: Fix buffer overflow in print_cpu_stall_info()

Announce: https://lore.kernel.org/linux-cve-announce/2024061946-CVE-2024-38=
576-a4a4@gregkh/

Introduced by commit 245a629 ("rcu: Dump rcuc kthread status for CPUs
not reporting quiescent state") in v6.0-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3758f7d9917bd7ef0482c4184c0ad673b4c4e069]
stable/6.1: [e2228ed3fe7aa838fba87c79a76fb1ad9ea47138]
stable/6.6: [afb39909bfb5c08111f99e21bf5be7505f59ff1c]

CVE-2024-38577: rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overf=
low

Announce: https://lore.kernel.org/linux-cve-announce/2024061947-CVE-2024-38=
577-7369@gregkh/

Introduced by commit edf3775 ("rcu-tasks: Add count for idle tasks on
offline CPUs") in v5.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc5645fddb0ce28492b15520306d092730dffa48]
stable/6.1: [08186d0c5fb64a1cc4b43e009314ee6b173ed222]
stable/6.6: [32d988f48ed287e676a29a15ac30701c35849aec]

CVE-2024-38578: ecryptfs: Fix buffer size for tag 66 packet

Announce: https://lore.kernel.org/linux-cve-announce/2024061947-CVE-2024-38=
578-6bf2@gregkh/

Introduced by commit dddfa46 ("[PATCH] eCryptfs: Public key; packet
management") in v2.6.21-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [52f9fbf3dba57fd078aa947361193da10d108c6e]
cip/4.4-st: [52f9fbf3dba57fd078aa947361193da10d108c6e]
mainline: [85a6a1aff08ec9f5b929d345d066e2830e8818e5]
stable/4.19: [1c125b9287e58f364d82174efb167414b92b11f1]
stable/5.10: [edbfc42ab080e78c6907d40a42c9d10b69e445c1]
stable/5.15: [12db25a54ce6bb22b0af28010fff53ef9cb3fe93]
stable/5.4: [235b85981051cd68fc215fd32a81c6f116bfc4df]
stable/6.1: [0d0f8ba042af16519f1ef7dd10463a33b21b677c]
stable/6.6: [2ed750b7ae1b5dc72896d7dd114c419afd3d1910]

CVE-2024-38579: crypto: bcm - Fix pointer arithmetic

Announce: https://lore.kernel.org/linux-cve-announce/2024061947-CVE-2024-38=
579-e96a@gregkh/

Introduced by commit 9d12ba8 ("crypto: brcm - Add Broadcom SPU
driver") in v4.11-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b3460cbf454c6b03d7429e9ffc4fe09322eb1a9]
stable/4.19: [c256b616067bfd6d274c679c06986b78d2402434]
stable/5.10: [ebed0d666fa709bae9e8cafa8ec6e7ebd1d318c6]
stable/5.15: [c69a1e4b419c2c466dd8c5602bdebadc353973dd]
stable/5.4: [e719c8991c161977a67197775067ab456b518c7b]
stable/6.1: [49833a8da6407e7e9b532cc4054fdbcaf78f5fdd]
stable/6.6: [d0f14ae223c2421b334c1f1a9e48f1e809aee3a0]

CVE-2024-38580: epoll: be better about file lifetimes

Announce: https://lore.kernel.org/linux-cve-announce/2024061948-CVE-2024-38=
580-d87f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc7.

Fixed status
mainline: [4efaa5acf0a1d2b5947f98abb3acf8bfd966422b]
stable/5.15: [cbfd1088e24ec4c1199756a37cb8e4cd0a4b016e]
stable/6.1: [559214eb4e5c3d05e69428af2fae2691ba1eb784]
stable/6.6: [4f65f4defe4e23659275ce5153541cd4f76ce2d2]

CVE-2024-38581: drm/amdgpu/mes: fix use-after-free issue

Announce: https://lore.kernel.org/linux-cve-announce/2024061948-CVE-2024-38=
581-592d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc6.
Affected file drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c is introduced by
commit 32de57e9 ("drm/amdgpu/mes: manage mes doorbell allocation") in 5.19.

Fixed status
mainline: [948255282074d9367e01908b3f5dcf8c10fc9c3d]
stable/6.1: [70b1bf6d9edc8692d241f59a65f073aec6d501de]
stable/6.6: [39cfce75168c11421d70b8c0c65f6133edccb82a]

CVE-2024-38582: nilfs2: fix potential hang in nilfs_detach_log_writer()

Announce: https://lore.kernel.org/linux-cve-announce/2024061948-CVE-2024-38=
582-6165@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
cip/4.4: [3512e41a336b43f88525948cd1ebcc9080b982c3]
cip/4.4-st: [3512e41a336b43f88525948cd1ebcc9080b982c3]
mainline: [eb85dace897c5986bc2f36b3c783c6abb8a4292e]
stable/4.19: [911d38be151921a5d152bb55e81fd752384c6830]
stable/5.10: [eff7cdf890b02596b8d73e910bdbdd489175dbdb]
stable/5.15: [06afce714d87c7cd1dcfccbcd800c5c5d2cf1cfd]
stable/5.4: [bc9cee50a4a4ca23bdc49f75ea8242d8a2193b3b]
stable/6.1: [1c3844c5f4eac043954ebf6403fa9fd1f0e9c1c0]
stable/6.6: [a8799662fed1f8747edae87a1937549288baca6a]

CVE-2024-38583: nilfs2: fix use-after-free of timer for log writer thread

Announce: https://lore.kernel.org/linux-cve-announce/2024061948-CVE-2024-38=
583-9fb7@gregkh/

Introduced by commit fdce895 ("nilfs2: change sc_timer from a pointer
to an embedded one in struct nilfs_sc_info") in v2.6.35-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5d4e04634c9cf68bdf23de08ada0bb92e8befe7]
stable/4.19: [822ae5a8eac30478578a75f7e064f0584931bf2d]
stable/5.10: [67fa90d4a2ccd9ebb0e1e168c7d0b5d0cf3c7148]
stable/5.15: [e65ccf3a4de4f0c763d94789615b83e11f204438]
stable/5.4: [82933c84f188dcfe89eb26b0b48ab5d1ca99d164]
stable/6.1: [86a30d6302deddb9fb97ba6fc4b04d0e870b582a]
stable/6.6: [f9186bba4ea282b07293c1c892441df3a5441cb0]

CVE-2024-38584: net: ti: icssg_prueth: Fix NULL pointer dereference in
prueth_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024061949-CVE-2024-38=
584-6a99@gregkh/

Introduced by commit 128d587 ("net: ti: icssg-prueth: Add ICSSG
ethernet driver") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b31c7e78086127a7fcaa761e8d336ee855a920c6]
stable/6.6: [5cd17f0e74cb99d209945b9f1f06d411aa667eb1]

CVE-2024-38585: tools/nolibc/stdlib: fix memory error in realloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024061949-CVE-2024-38=
585-4af2@gregkh/

Introduced by commit 0e0ff63 ("tools/nolibc/stdlib: Implement
`malloc()`, `calloc()`, `realloc()` and `free()`") in v5.19-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [791f4641142e2aced85de082e5783b4fb0b977c2]
stable/6.1: [5996b2b2dac739f2a27da13de8eee5b85b2550b3]
stable/6.6: [f678c3c336559cf3255a32153e9a17c1be4e7c15]

CVE-2024-38586: r8169: Fix possible ring buffer corruption on
fragmented Tx packets.

Announce: https://lore.kernel.org/linux-cve-announce/2024061949-CVE-2024-38=
586-70d6@gregkh/

Introduced by commit 9020845 ("r8169: improve rtl8169_start_xmit") in v5.7-=
rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c71e3a5cffd5309d7f84444df03d5b72600cc417]
stable/5.15: [b6d21cf40de103d63ae78551098a7c06af8c98dd]
stable/6.1: [0c48185a95309556725f818b82120bb74e9c627d]
stable/6.6: [68222d7b4b72aa321135cd453dac37f00ec41fd1]

CVE-2024-38587: speakup: Fix sizeof() vs ARRAY_SIZE() bug

Announce: https://lore.kernel.org/linux-cve-announce/2024061950-CVE-2024-38=
587-46ec@gregkh/

Introduced by commit c8d2f34 ("speakup: Avoid crash on very long
word") in v6.9-rc5.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.6

Fixed status
cip/4.4: [27037a05c28af16afe00928032f9e3a68ef66c34]
cip/4.4-st: [27037a05c28af16afe00928032f9e3a68ef66c34]
mainline: [008ab3c53bc4f0b2f20013c8f6c204a3203d0b8b]
stable/4.19: [42f0a3f67158ed6b2908d2b9ffbf7e96d23fd358]
stable/5.10: [07ef95cc7a579731198c93beed281e3a79a0e586]
stable/5.15: [504178fb7d9f6cdb0496d5491efb05f45597e535]
stable/5.4: [cd7f3978c2ec741aedd1d860b2adb227314cf996]
stable/6.1: [3726f75a1ccc16cd335c0ccfad1d92ee08ecba5e]
stable/6.6: [c6e1650cf5df1bd6638eeee231a683ef30c7d4eb]

CVE-2024-38588: ftrace: Fix possible use-after-free issue in ftrace_locatio=
n()

Announce: https://lore.kernel.org/linux-cve-announce/2024061950-CVE-2024-38=
588-f908@gregkh/

Introduced by commit ae6aa16 ("kprobes: introduce ftrace based
optimization") in v3.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e60b613df8b6253def41215402f72986fee3fc8d]
stable/6.1: [dbff5f0bfb2416b8b55c105ddbcd4f885e98fada]
stable/6.6: [7b4881da5b19f65709f5c18c1a4d8caa2e496461]

CVE-2024-38589: netrom: fix possible dead-lock in nr_rt_ioctl()

Announce: https://lore.kernel.org/linux-cve-announce/2024061954-CVE-2024-38=
589-de10@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [402d01c97402232056b2105bda78fdc0da0ddb6b]
cip/4.4-st: [402d01c97402232056b2105bda78fdc0da0ddb6b]
mainline: [e03e7f20ebf7e1611d40d1fdc1bde900fd3335f6]
stable/4.19: [b9d663fbf74290cb68fbc66ae4367bd56837ad1d]
stable/5.10: [b117e5b4f27c2c9076561b6be450a9619f0b79de]
stable/5.15: [421c50fa81836775bf0fd6ce0e57a6eb27af24d5]
stable/5.4: [1fbfb483c1a290dce3f41f52d45cc46dd88b7691]
stable/6.1: [3db2fc45d1d2a6457f06ebdfd45b9820e5b5c2b7]
stable/6.6: [f28bdc2ee5d9300cc77bd3d97b5b3cdd14960fd8]

CVE-2024-38590: RDMA/hns: Modify the print level of CQE error

Announce: https://lore.kernel.org/linux-cve-announce/2024061954-CVE-2024-38=
590-55eb@gregkh/

Introduced by commit 7c044ad ("RDMA/hns: Simplify the cqe code of poll
cq") in v5.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [349e859952285ab9689779fb46de163f13f18f43]
stable/5.10: [45b31be4dd22827903df15c548b97b416790139b]
stable/5.15: [cc699b7eb2bc963c12ffcd37f80f45330d2924bd]
stable/6.1: [17f3741c65c4a042ae8ba094068b07a4b77e213c]
stable/6.6: [6f541a89ced8305da459e3ab0006e7528cf7da7b]

CVE-2024-38591: RDMA/hns: Fix deadlock on SRQ async events.

Announce: https://lore.kernel.org/linux-cve-announce/2024061954-CVE-2024-38=
591-a4ae@gregkh/

Introduced by commit 81fce62 ("RDMA/hns: Add SRQ asynchronous event
support") in v5.0-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b46494b6f9c19f141114a57729e198698f40af37]
stable/5.15: [4a3be1a0ffe04c085dd7f79be97c91b0c786df3d]
stable/6.1: [756ddbe665ea7f9416951bd76731b174d136eea0]
stable/6.6: [22c915af31bd84ffaa46145e317f53333f94a868]

CVE-2024-38592: drm/mediatek: Init `ddp_comp` with devm_kcalloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024061955-CVE-2024-38=
592-5b29@gregkh/

Introduced by commit 01389b3 ("drm/mediatek: Add connector dynamic
selection capability") in v6.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01a2c5123e27b3c4685bf2fc4c2e879f6e0c7b33]

CVE-2024-38593: net: micrel: Fix receiving the timestamp in the frame
for lan8841

Announce: https://lore.kernel.org/linux-cve-announce/2024061955-CVE-2024-38=
593-8b0e@gregkh/

Introduced by commit cc75549 ("net: micrel: Change to receive
timestamp in the frame for lan8841") in v6.5-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aea27a92a41dae14843f92c79e9e42d8f570105c]
stable/6.6: [3ddf170e4a604f5d4d9459a36993f5e92b53e8b0]

CVE-2024-38594: net: stmmac: move the EST lock to struct stmmac_priv

Announce: https://lore.kernel.org/linux-cve-announce/2024061955-CVE-2024-38=
594-75c8@gregkh/

Introduced by commit b2aae65 ("net: stmmac: add mutex lock to protect
est parameters") in v5.14-rc2.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [36ac9e7f2e5786bd37c5cd91132e1f39c29b8197]

CVE-2024-38595: net/mlx5: Fix peer devlink set for SF representor devlink p=
ort

Announce: https://lore.kernel.org/linux-cve-announce/2024061955-CVE-2024-38=
595-0721@gregkh/

Introduced by commit bf72998 ("net/mlx5: Restore mistakenly dropped
parts in register devlink flow") in v6.9-rc5.
Introduced by commit c6e77aa ("net/mlx5: Register devlink first under
devlink lock") in v6.9-rc4.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c453e8cc672de1f9c662948dba43176bc68d7f0]

CVE-2024-38596: af_unix: Fix data races in unix_release_sock/unix_stream_se=
ndmsg

Announce: https://lore.kernel.org/linux-cve-announce/2024061956-CVE-2024-38=
596-f660@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [540bf24fba16b88c1b3b9353927204b4f1074e25]
stable/4.19: [fca6072e1a7b1e709ada5604b951513b89b4bd0a]
stable/5.10: [4d51845d734a4c5d079e56e0916f936a55e15055]
stable/5.15: [9aa8773abfa0e954136875b4cbf2df4cf638e8a5]
stable/5.4: [de6641d213373fbde9bbdd7c4b552254bc9f82fe]
stable/6.1: [8299e4d778f664b31b67cf4cf3d5409de2ecb92c]
stable/6.6: [0688d4e499bee3f2749bca27329bd128686230cb]

CVE-2024-38597: eth: sungem: remove .ndo_poll_controller to avoid deadlocks

Announce: https://lore.kernel.org/linux-cve-announce/2024061956-CVE-2024-38=
597-ad49@gregkh/

Introduced by commit fe09bb6 ("sungem: Spring cleaning and GRO
support") in v3.1-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac0a230f719b02432d8c7eba7615ebd691da86f4]
stable/5.10: [e22b23f5888a065d084e87db1eec639c445e677f]
stable/5.15: [fbeeb55dbb33d562149c57e794f06b7414e44289]
stable/6.1: [476adb3bbbd7886e8251d3b9ce2d3c3e680f35d6]
stable/6.6: [5de5aeb98f9a000adb0db184e32765e4815d860b]

CVE-2024-38598: md: fix resync softlockup when bitmap size is less
than array size

Announce: https://lore.kernel.org/linux-cve-announce/2024061956-CVE-2024-38=
598-8629@gregkh/

Introduced by commit 301867b ("md/raid10: check slab-out-of-bounds in
md_bitmap_get_counter") in v6.5-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
mainline: [f0e729af2eb6bee9eb58c4df1087f14ebaefe26b]
stable/4.19: [d4b9c764d48fa41caa24cfb4275f3aa9fb4bd798]
stable/5.10: [3f5b73ef8fd6268cbc968b308d8eafe56fda97f3]
stable/5.15: [69296914bfd508c85935bf5f711cad9b0fe78492]
stable/5.4: [43771597feba89a839c5f893716df88ae5c237ce]
stable/6.1: [71e8e4f288e74a896b6d9cd194f3bab12bd7a10f]
stable/6.6: [c9566b812c8f66160466cc1e29df6d3646add0b1]

CVE-2024-38599: jffs2: prevent xattr node from overflowing the eraseblock

Announce: https://lore.kernel.org/linux-cve-announce/2024061957-CVE-2024-38=
599-9b9d@gregkh/

Introduced by commit aa98d7c ("[JFFS2][XATTR] XATTR support on JFFS2
(version. 5)") in v2.6.20.16.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [68acf289b5e327705d213baa962ca69048b94003]
cip/4.4-st: [68acf289b5e327705d213baa962ca69048b94003]
mainline: [c6854e5a267c28300ff045480b5a7ee7f6f1d913]
stable/4.19: [2904e1d9b64f72d291095e3cbb31634f08788b11]
stable/5.10: [f0eea095ce8c959b86e1e57fe36ca4fea5ae54f8]
stable/5.15: [a1d21bcd78cf4a4353e1e835789429c6b76aca8b]
stable/5.4: [526235dffcac74c7823ed504dfac4f88d84ba5df]
stable/6.1: [f06969df2e40ab1dc8f4364a5de967830c74a098]
stable/6.6: [af82d8d2179b7277ad627c39e7e0778f1c86ccdb]

CVE-2024-38600: ALSA: Fix deadlocks with kctl removals at disconnection

Announce: https://lore.kernel.org/linux-cve-announce/2024061957-CVE-2024-38=
600-aa7e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [87988a534d8e12f2e6fc01fe63e6c1925dc5307c]
stable/5.15: [ff80185e7b7b547a0911fcfc8aefc61c3e8304d7]
stable/6.1: [c2fb439f4f1425a961d20bec818fed2c2d9ef70a]
stable/6.6: [2f103287ef7960854808930499d1181bd0145d68]

CVE-2024-38601: ring-buffer: Fix a race between readers and resize checks

Announce: https://lore.kernel.org/linux-cve-announce/2024061923-CVE-2024-38=
601-dc52@gregkh/

Introduced by commit 659f451 ("ring-buffer: Add integrity check at end
of iter read") in v3.5-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [dfa8036705faa13b7db0f3f19caaf8abe99cead4]
cip/4.4-st: [dfa8036705faa13b7db0f3f19caaf8abe99cead4]
mainline: [c2274b908db05529980ec056359fae916939fdaa]
stable/4.19: [b50932ea673b5a089a4bb570a8a868d95c72854e]
stable/5.10: [1e160196042cac946798ac192a0bc3398f1aa66b]
stable/5.15: [595363182f28786d641666a09e674b852c83b4bb]
stable/5.4: [c68b7a442ee61d04ca58b2b5cb5ea7cb8230f84a]
stable/6.1: [54c64967ba5f8658ae7da76005024ebd3d9d8f6e]
stable/6.6: [af3274905b3143ea23142bbf77bd9b610c54e533]

CVE-2024-38602: ax25: Fix reference count leak issues of ax25_dev

Announce: https://lore.kernel.org/linux-cve-announce/2024061924-CVE-2024-38=
602-e098@gregkh/

Introduced by commit d01ffb9 ("ax25: add refcount in ax25_dev to avoid
UAF bugs") in v5.17-rc3.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [b505e0319852b08a3a716b64620168eab21f4ced]
stable/6.1: [ae467750a3765dd1092eb29f58247950a2f9b60c]
stable/6.6: [38eb01edfdaa1562fa00429be2e33f45383b1b3a]

CVE-2024-38603: drivers/perf: hisi: hns3: Actually use
devm_add_action_or_reset()

Announce: https://lore.kernel.org/linux-cve-announce/2024061924-CVE-2024-38=
603-e1f0@gregkh/

Introduced by commit 66637ab ("drivers/perf: hisi: add driver for HNS3
PMU") in v6.0-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [582c1aeee0a9e73010cf1c4cef338709860deeb0]
stable/6.1: [1491a01ef5a98149048b12e208f6ed8e86ad10b9]
stable/6.6: [a7678a16c25b6ece1667ac681e3e783ff3de7a6f]

CVE-2024-38604: block: refine the EOF check in blkdev_iomap_begin

Announce: https://lore.kernel.org/linux-cve-announce/2024061924-CVE-2024-38=
604-a738@gregkh/

Introduced by commit 487c607 ("block: use iomap for writes to block
devices") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c12028aec837f5a002009bbf68d179d506510e8]
stable/6.6: [910717920c8c3f9386277a44c44d448058a18084]

CVE-2024-38605: ALSA: core: Fix NULL module pointer assignment at card init

Announce: https://lore.kernel.org/linux-cve-announce/2024061925-CVE-2024-38=
605-3dc4@gregkh/

Introduced by commit 81033c6 ("ALSA: core: Warn on empty module") in v5.9-r=
c1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39381fe7394e5eafac76e7e9367e7351138a29c1]
stable/5.10: [d7ff29a429b56f04783152ad7bbd7233b740e434]
stable/5.15: [e7e0ca200772bdb2fdc6d43d32d341e87a36f811]
stable/6.1: [e007476725730c1a68387b54b7629486d8a8301e]
stable/6.6: [e644036a3e2b2c9b3eee3c61b5d31c2ca8b5ba92]

CVE-2024-38606: crypto: qat - validate slices count returned by FW

Announce: https://lore.kernel.org/linux-cve-announce/2024061925-CVE-2024-38=
606-6148@gregkh/

Introduced by commit 69e7649 ("crypto: qat - add support for device
telemetry") in v6.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [483fd65ce29317044d1d00757e3fd23503b6b04c]

CVE-2024-38607: macintosh/via-macii: Fix "BUG: sleeping function
called from invalid context"

Announce: https://lore.kernel.org/linux-cve-announce/2024061925-CVE-2024-38=
607-089e@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [65bccbb8aaef138e401c0d0ad2e77f7951566337]
cip/4.4-st: [65bccbb8aaef138e401c0d0ad2e77f7951566337]
mainline: [d301a71c76ee4c384b4e03cdc320a55f5cf1df05]
stable/4.19: [e4ff8bcfb2841fe4e17e5901578b632adb89036d]
stable/5.10: [280619bbdeac186fb320fab3d61122d2a085def8]
stable/5.15: [010d4cb19bb13f423e3e746b824f314a9bf3e9a9]
stable/5.4: [1e9c3f2caec548cfa7a65416ec4e6006e542f18e]
stable/6.1: [787fb79efc15b3b86442ecf079b8148f173376d7]
stable/6.6: [d43a8c7ec0841e0ff91a968770aeca83f0fd4c56]

CVE-2024-38608: net/mlx5e: Fix netif state handling

Announce: https://lore.kernel.org/linux-cve-announce/2024061920-CVE-2024-38=
608-4068@gregkh/

Introduced by commit 2c3b5be ("net/mlx5e: More generic netdev
management API") in v4.12-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d5918477f94e4c2f064567875c475468e264644]

CVE-2024-38609: wifi: mt76: connac: check for null before dereferencing

Announce: https://lore.kernel.org/linux-cve-announce/2024061921-CVE-2024-38=
609-1fad@gregkh/

Introduced by commit 098428c ("wifi: mt76: connac: set correct
muar_idx for mt799x chipsets") in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb47c7be0e93dd5acda078163799401ac3a78e10]

CVE-2024-38610: drivers/virt/acrn: fix PFNMAP PTE checks in acrn_vm_ram_map=
()

Announce: https://lore.kernel.org/linux-cve-announce/2024061921-CVE-2024-38=
610-21f9@gregkh/

Introduced by commit 8a6e85f ("virt: acrn: obtain pa from VMA with
PFNMAP flag") in v5.18-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3d6586008f7b638f91f3332602592caa8b00b559]
stable/5.15: [5c6705aa47b5b78d7ad36fea832bb69caa5bf49a]
stable/6.1: [afeb0e69627695f759fc73c39c1640dbf8649b32]
stable/6.6: [e873f36ec890bece26ecce850e969917bceebbb6]

CVE-2024-38611: media: i2c: et8ek8: Don't strip remove function when
driver is builtin

Announce: https://lore.kernel.org/linux-cve-announce/2024061921-CVE-2024-38=
611-bb0f@gregkh/

Introduced by commit c5254e7 ("[media] media: Driver for Toshiba
et8ek8 5MP sensor") in v4.11-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [545b215736c5c4b354e182d99c578a472ac9bfce]
stable/6.6: [c1a3803e5bb91c13e9ad582003e4288f67f06cd9]

CVE-2024-38612: ipv6: sr: fix invalid unregister error path

Announce: https://lore.kernel.org/linux-cve-announce/2024061922-CVE-2024-38=
612-7fc1@gregkh/

Introduced by commit 46738b1 ("ipv6: sr: add option to control
lwtunnel support") in v4.10-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [160e9d2752181fcf18c662e74022d77d3164cd45]
stable/4.19: [10610575a3ac2a702bf5c57aa931beaf847949c7]
stable/5.10: [00e6335329f23ac6cf3105931691674e28bc598c]
stable/5.15: [1a63730fb315bb1bab97edd69ff58ad45e04bb01]
stable/5.4: [646cd236c55e2cb5f146fc41bbe4034c4af5b2a4]
stable/6.1: [e77a3ec7ada84543e75722a1283785a6544de925]
stable/6.6: [3398a40dccb88d3a7eef378247a023a78472db66]

CVE-2024-38613: m68k: Fix spinlock race in kernel thread creation

Announce: https://lore.kernel.org/linux-cve-announce/2024061922-CVE-2024-38=
613-abc6@gregkh/

Introduced by commit 533e690 ("m68k: split ret_from_fork(), simplify
kernel_thread()") in v3.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [b7e1243d52b2161051416da7aa79ef5ff9e86e82]
cip/4.4-st: [b7e1243d52b2161051416da7aa79ef5ff9e86e82]
mainline: [da89ce46f02470ef08f0f580755d14d547da59ed]
stable/4.19: [2a8d1d95302c7d52c6ac8fa5cb4a6948ae0d3a14]
stable/5.10: [4eeffecc8e3cce25bb559502c2fd94a948bcde82]
stable/5.15: [77b2b67a0f8bce260c53907e5749d61466d90c87]
stable/5.4: [5213cc01d0464c011fdc09f318705603ed3a746b]
stable/6.1: [0d9ae1253535f6e85a016e09c25ecbe6f7f59ef0]
stable/6.6: [f3baf0f4f92af32943ebf27b960e0552c6c082fd]

CVE-2024-38614: openrisc: traps: Don't send signals to kernel mode threads

Announce: https://lore.kernel.org/linux-cve-announce/2024061922-CVE-2024-38=
614-50ce@gregkh/

Introduced by commit 2726765 ("openrisc: Support floating point user
api") in v6.4-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c88cfb5cea5f8f9868ef02cc9ce9183a26dcf20f]
stable/6.6: [c0ed9a711e3392d73e857faa031d8d349c0d70db]

CVE-2024-38615: cpufreq: exit() callback is optional

Announce: https://lore.kernel.org/linux-cve-announce/2024061922-CVE-2024-38=
615-0d4c@gregkh/

Introduced by commit 91a12e9 ("cpufreq: Allow light-weight tear down
and bring up of CPUs") in v5.1-rc1.
Introduced by commit f339f35 ("cpufreq: Rearrange locking in
cpufreq_remove_dev()") in v5.19-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [b8f85833c05730d631576008daaa34096bc7f3ce]
stable/5.10: [dfc56ff5ec9904c008e9376d90a6d7e2d2bec4d3]
stable/5.15: [35db5e76d5e9f752476df5fa0b9018a2398b0378]
stable/5.4: [2d730b465e377396d2a09a53524b96b111f7ccb6]
stable/6.1: [8bc9546805e572ad101681437a49939f28777273]
stable/6.6: [3e99f060cfd2e36504d62c9132b453ade5027e1c]

CVE-2024-38616: wifi: carl9170: re-fix fortified-memset warning

Announce: https://lore.kernel.org/linux-cve-announce/2024061923-CVE-2024-38=
616-5632@gregkh/

Introduced by commit fb5f6a0 ("mac80211: Use memset_after() to clear
tx status") in v5.17-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [066afafc10c9476ee36c47c9062527a17e763901]
stable/6.1: [13857683126e8a6492af73c74d702835f7a2175b]
stable/6.6: [87586467098281f04fa93e59fe3a516b954bddc4]

CVE-2024-38617: kunit/fortify: Fix mismatched kvalloc()/vfree() usage

Announce: https://lore.kernel.org/linux-cve-announce/2024061923-CVE-2024-38=
617-5530@gregkh/

Introduced by commit 9124a26 ("kunit/fortify: Validate __alloc_size
attribute results") in v6.2-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [998b18072ceb0613629c256b409f4d299829c7ec]
stable/6.6: [7880dbf4eafe22a6a41a42e774f1122c814ed02d]

CVE-2024-38618: ALSA: timer: Set lower bound of start tick time

Announce: https://lore.kernel.org/linux-cve-announce/2024061923-CVE-2024-38=
618-35a9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [4a63bd179fa8d3fcc44a0d9d71d941ddd62f0c4e]
stable/4.19: [68396c825c43664b20a3a1ba546844deb2b4e48f]
stable/5.10: [bdd0aa055b8ec7e24bbc19513f3231958741d0ab]
stable/5.15: [83f0ba8592b9e258fd80ac6486510ab1dcd7ad6e]
stable/5.4: [74bfb8d90f2601718ae203faf45a196844c01fa1]
stable/6.1: [ceab795a67dd28dd942d0d8bba648c6c0f7a044b]
stable/6.6: [2c95241ac5fc90c929d6c0c023e84bf0d30e84c3]


* Updated CVEs

CVE-2023-4244: A use-after-free vulnerability in the Linux kernel's netfilt=
er

Added commit 94313a196 to stable/4.19.

Fixed status
mainline: [5f68718b34a531a556f2f50300ead2862278da26,f6c383b8c31a93752a52697=
f8430a71dcbc46adf,c92db3030492b8ad1d0faace7a93bbcf53850d0c,a2dd0233cbc4d8a0=
abb5f64487487ffc9265beb5,24138933b97b055d486e8064b4a1721702442a9b,6a33d8b73=
dfac0a41f3877894b38082bd0c9a5bc,02c6c24402bf1c1e986899c14ba22a10b510916b,23=
185c6aed1ffb8fc44087880ba2767aba493779]
stable/4.19: [255bb7fd670589c00cb2f8a1353b721306135ca3,94313a196b44184b5b52=
c1876da6a537701b425a]
stable/5.10: [448be0774882f95a74fa5eb7519761152add601b,146c76866795553dbc19=
998f36718d7986ad302b,77046cb00850e35ba935944b5100996b2ce34bba,911dd3cdf1083=
f4c2e7df72aaab486a1d6dbcc0a,b15ea4017af82011dd55225ce77cce3d4dfc169c,4046f2=
b56e5a7ba7e123ff961dd51187b8d59e78,dc0b1f019554e601f57e78d8f5c70e59d77e49a5=
,a7653eaea0a59a6993c62d3653af5c880ce28533]
stable/5.4: [bbdb3b65aa91aa0a32b212f27780b28987f2d94f,c357648929c8dff891502=
349769aafb8f0452bc2,85520a1f1d879455a8b6c950e7a92d3e8fa667b6,1398a0eee290e3=
ddf1d5ce2539e47dd41830a0d5,1da4874d05da1526b11b82fc7f3c7ac38749ddf8,29ff9b8=
efb84070b2ee9cf238efe0b202df079ff,b76dcf4662235b6f1a942892230a880382a3471d,=
81da9e2c42556ada249cfb0d1d65d65986ac31ca]
stable/6.1: [7148bca63b212fc8e5c2e8374e14cd62b1c8441c,59dab3bf0b8fc08eb8027=
21c0532f13dd89209b8,ea3eb9f2192e4fc33b795673e56c97a21987f868,df650d6a4bf472=
48261b61ef6b174d7c54034d15,4ead4f74b3a9162b205f702d72d4a3421356dbc1,0b9af48=
60a61f55cf716267b5ae5df34aacc4b39,41113aa5698ad7a82635bcb747d483e4458d518d,=
afa584c35065051a11ae3ea3cc105b634053fcd8]

CVE-2023-4881: netfilter: nftables: exthdr: fix 4-byte stack OOB write

Added fixed commit to stable/4.19.

Fixed status
mainline: [fd94d9dadee58e09b49075240fe83423eb1dcd36]
stable/4.19: [28a97c43c9e32f437ebb8d6126f9bb7f3ca9521a]
stable/5.10: [a7d86a77c33ba1c357a7504341172cc1507f0698]
stable/5.15: [1ad7b189cc1411048434e8595ffcbe7873b71082]
stable/6.1: [d9ebfc0f21377690837ebbd119e679243e0099cc]

CVE-2023-52433: netfilter: nft_set_rbtree: skip sync GC for new
elements in this transaction

Added fixed commit to stable/4.19.

Fixed status
mainline: [2ee52ae94baabf7ee09cf2a8d854b990dac5d0e4]
stable/4.19: [9db9feb841f7449772f9393c16b9ef4536d8c127]
stable/5.10: [c323ed65f66e5387ee0a73452118d49f1dae81b8]
stable/5.15: [9af7dfb3c9d7985172a240f85e684c5cd33e29ce]
stable/5.4: [03caf75da1059f0460666c826e9f50e13dfd0017]
stable/6.1: [9a8c544158f68f656d1734eb5ba00c4f817b76b1]

CVE-2023-52581: netfilter: nf_tables: fix memleak when more than 255
elements expired

Added fixed commit to stable/4.19.

Fixed status
mainline: [cf5000a7787cbc10341091d37245a42c119d26c5]
stable/4.19: [7cf055b43756b10aa2b851c927c940f5ed652125]
stable/5.10: [09c85f2d21ab6b5acba31a037985b13e8e6565b8]
stable/5.15: [ef99506eaf1dc31feff1adfcfd68bc5535a22171]
stable/5.4: [a995a68e8a3b48533e47c856865d109a1f1a9d01]
stable/6.1: [7e5d732e6902eb6a37b35480796838a145ae5f07]

CVE-2023-52628: netfilter: nftables: exthdr: fix 4-byte stack OOB write

Added fixed commit to stable/4.19.

Fixed status
mainline: [fd94d9dadee58e09b49075240fe83423eb1dcd36]
stable/4.19: [28a97c43c9e32f437ebb8d6126f9bb7f3ca9521a]
stable/5.10: [a7d86a77c33ba1c357a7504341172cc1507f0698]
stable/5.15: [1ad7b189cc1411048434e8595ffcbe7873b71082]
stable/6.1: [d9ebfc0f21377690837ebbd119e679243e0099cc]

CVE-2024-26581: netfilter: nft_set_rbtree: skip end interval element from g=
c

Added fixed commit to stable/4.19.

Fixed status
mainline: [60c0c230c6f046da536d3df8b39a20b9a9fd6af0]
stable/4.19: [c60d252949caf9aba537525195edae6bbabc35eb]
stable/5.10: [4cee42fcf54fec46b344681e7cc4f234bb22f85a]
stable/5.15: [2bab493a5624444ec6e648ad0d55a362bcb4c003]
stable/5.4: [10e9cb39313627f2eae4cd70c4b742074e998fd8]
stable/6.1: [1296c110c5a0b45a8fcf58e7d18bc5da61a565cb]
stable/6.6: [b734f7a47aeb32a5ba298e4ccc16bb0c52b6dbf7]

CVE-2024-26643: netfilter: nf_tables: mark set as dead when unbinding
anonymous set with timeout

Added fixed commit to stable/4.19.

Fixed status
mainline: [552705a3650bbf46a22b1adedc1b04181490fc36]
stable/4.19: [d75a589bb92af1abf3b779cfcd1977ca11b27033]
stable/5.10: [e2d45f467096e931044f0ab7634499879d851a5c]
stable/5.15: [291cca35818bd52a407bc37ab45a15816039e363]
stable/5.4: [edcf1a3f182ecf8b6b805f0ce90570ea98c5f6bf]
stable/6.1: [406b0241d0eb598a0b330ab20ae325537d8d8163]
stable/6.6: [b2d6f9a5b1cf968f1eaa71085ceeb09c2cb276b1]

CVE-2024-26835: netfilter: nf_tables: set dormant flag on hook register fai=
lure

Added fixed commit to stable/4.19.

Fixed status
mainline: [bccebf64701735533c8db37773eeacc6566cc8ec]
stable/4.19: [a6411f3c48f991c19aaf9a24fce36865fbba28d7]
stable/5.10: [31ea574aeca1aa488e18716459bde057217637af]
stable/5.15: [664264a5c55bf97a9c571c557d477b75416199be]
stable/5.4: [ae4360cbd385f0d7a8a86d5723e50448cc6318f3]
stable/6.1: [0c9302a6da262e6ab6a6c1d30f04a6130ed97376]
stable/6.6: [f2135bbf14949687e96cabb13d8a91ae3deb9069]

CVE-2024-27065: netfilter: nf_tables: do not compare internal table
flags on updates

Added fixed commit to stable/4.19.

Fixed status
mainline: [4a0e7f2decbf9bd72461226f1f5f7dcc4b08f139]
stable/4.19: [845083249d6a392f3a88804e1669bdb936ee129f]
stable/5.10: [fcf32a5bfcb8a57ac0ce717fcfa4d688c91f1005]
stable/5.15: [640dbf688ba955e83e03de84fbdda8e570b7cce4]
stable/5.4: [2531f907d3e40a6173090f10670ae76d117ab27b]
stable/6.1: [9683cb6c2c6c0f45537bf0b8868b5d38fcb63fc7]
stable/6.6: [4d37f12707ee965d338028732575f0b85f6d9e4f]

CVE-2024-35897: netfilter: nf_tables: discard table flag update with
pending basechain deletion

Added fixed commit to stable/4.19.

Fixed status
mainline: [1bc83a019bbe268be3526406245ec28c2458a518]
stable/4.19: [e75faf01e22ec7dc671640fa0e0968964fafd2fc]
stable/5.10: [b58d0ac35f6d75ec1db8650a29dfd6f292c11362]
stable/5.15: [6cbbe1ba76ee7e674a86abd43009b083a45838cb]
stable/5.4: [9a3b90904d8a072287480eed4c3ece4b99d64f78]
stable/6.1: [2aeb805a1bcd5f27c8c0d1a9d4d653f16d1506f4]
stable/6.6: [9627fd0c6ea1c446741a33e67bc5709c59923827]

CVE-2024-35900: netfilter: nf_tables: reject new basechain after table
flag update

Added fixed commit to stable/4.19.

Fixed status
mainline: [994209ddf4f430946f6247616b2e33d179243769]
stable/4.19: [6d12f21f8bbe23fde25b77c2bf5973c136b8bef8]
stable/5.10: [7b6fba6918714afee3e17796113ccab636255c7b]
stable/5.15: [8ba81dca416adf82fc5a2a23abc1a8cc02ad32fb]
stable/5.4: [41bad13c0e8a5a2b47a7472cced922555372daab]
stable/6.1: [745cf6a843896cdac8766c74379300ed73c78830]
stable/6.6: [420132bee3d0136b7fba253a597b098fe15493a7]

CVE-2024-24863: Null pointer dereference bug in malidp_mw_connector_reset

Added fixed commit to stable 4.19, 5.10, 5.15, and 5.4.

Fixed status
mainline: [a1f95aede6285dba6dd036d907196f35ae3a11ea]
stable/4.19: [b6cc5dd06336ed8bb3a7a1fc5aaf7d5e88bc0818]
stable/5.10: [a5fa5b40a278a3ca978fed64707bd27614adb1eb]
stable/5.15: [3e54d4e95120641216dfe91a6c49f116a9f68490]
stable/5.4: [565d9ad7e5a18eb69ed8b66a9e9bb3f45346520c]
stable/6.1: [e4b52d49383306ef73fd1bd9102538beebb0fe07]
stable/6.6: [335cc45ef2b81b68be63c698b4f867a530bdf7a5]

CVE-2024-27019: netfilter: nf_tables: Fix potential data-race in
__nft_obj_type_get()

Added fixed commit to stable/5.10.

Fixed status
mainline: [d78d867dcea69c328db30df665be5be7d0148484]
stable/5.10: [cade34279c2249eafe528564bd2e203e4ff15f88]
stable/5.15: [379bf7257bc5f2a1b1ca8514e08a871b7bf6d920]
stable/6.1: [df7c0fb8c2b9f9cac65659332581b19682a71349]
stable/6.6: [ad333578f736d56920e090d7db1f8dec891d815e]

CVE-2024-35927: drm: Check output polling initialized before disabling

Added fixed commit to stable 5.10 and 6.1.

Fixed status
mainline: [5abffb66d12bcac84bf7b66389c571b8bb6e82bd]
stable/5.15: [786c27982a39d79cc753f84229eb5977ac8ef1c1]
stable/6.1: [4ad8d57d902fbc7c82507cfc1b031f3a07c3de6e]
stable/6.6: [3d1b47e3a935abd4f258a945db87e7267ff4079c]

CVE-2024-35976: xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RIN=
G

Added fixed commit to stable/5.4.

Fixed status
mainline: [237f3cf13b20db183d3706d997eedc3c49eacd44]
stable/5.10: [a82984b3c6a7e8c7937dba6e857ddf829d149417]
stable/5.15: [f0a068de65d5b7358e9aff792716afa9333f3922]
stable/5.4: [0b45c25d60e38f5c2cb6823f886773a34323306d]
stable/6.1: [2a523f14a3f53b46ff0e1fafd215b0bc5f6783aa]
stable/6.6: [b143e19dc28c3211f050f7848d87d9b0a170e10c]

CVE-2024-36014: drm/arm/malidp: fix a possible null pointer dereference

Added fixed commit to 4.19, 5.10, 5.15, and 5.4.

Fixed status
mainline: [a1f95aede6285dba6dd036d907196f35ae3a11ea]
stable/4.19: [b6cc5dd06336ed8bb3a7a1fc5aaf7d5e88bc0818]
stable/5.10: [a5fa5b40a278a3ca978fed64707bd27614adb1eb]
stable/5.15: [3e54d4e95120641216dfe91a6c49f116a9f68490]
stable/5.4: [565d9ad7e5a18eb69ed8b66a9e9bb3f45346520c]
stable/6.1: [e4b52d49383306ef73fd1bd9102538beebb0fe07]
stable/6.6: [335cc45ef2b81b68be63c698b4f867a530bdf7a5]

CVE-2024-36015: ppdev: Add an error check in register_device

Added fixed commit to 4.19, 5.10, 5.15, and 5.4.

Fixed status
mainline: [fbf740aeb86a4fe82ad158d26d711f2f3be79b3e]
stable/4.19: [65cd017d43f4319a56747d38308b0a24cf57299e]
stable/5.10: [d32caf51379a4d71db03d3d4d7c22d27cdf7f68b]
stable/5.15: [b65d0410b879af0295d22438a4a32012786d152a]
stable/5.4: [b8c6b83cc3adff3ddf403c8c7063fe6d08b2b9d9]
stable/6.1: [df9329247dbbf00f6057e002139ab3fa529ad828]
stable/6.6: [ec3468221efec6660ff656e9ebe51ced3520fc57]

CVE-2024-36016: tty: n_gsm: fix possible out-of-bounds in gsm0_receive()

Added fixed commit to 4.19, 5.10, 5.15, and 5.4.

Fixed status
cip/4.4: [0dfa639498701fa01ff3d6d3112b20e74161aa34]
cip/4.4-st: [0dfa639498701fa01ff3d6d3112b20e74161aa34]
mainline: [47388e807f85948eefc403a8a5fdc5b406a65d5a]
stable/4.19: [9513d4148950b05bc99fa7314dc883cc0e1605e5]
stable/5.10: [0fb736c9931e02dbc7d9a75044c8e1c039e50f04]
stable/5.15: [4c267110fc110390704cc065edb9817fdd10ff54]
stable/5.4: [b229bc6c6ea9fe459fc3fa94fd0a27a2f32aca56]
stable/6.1: [46f52c89a7e7d2691b97a9728e4591d071ca8abc]
stable/6.6: [774d83b008eccb1c48c14dc5486e7aa255731350]

CVE-2024-36891: maple_tree: fix mas_empty_area_rev() null pointer dereferen=
ce

Added fixed commit to stable/6.1.

Fixed status
mainline: [955a923d2809803980ff574270f81510112be9cf]
stable/6.1: [883e5d542bbdddbddeba60250cb482baf3ae2415]
stable/6.6: [6c9c7c1e63b198a8b979ad963eb21410f10ccb00]

CVE-2024-36971: net: fix __dst_negative_advice() race

Added fixed commit to 4.19, 5.10, 5.15, 5.4, 6.1, and 6.6.

Fixed status
mainline: [92f1655aa2b2294d0b49925f3b875a634bd3b59e]
stable/4.19: [051c0bde9f0450a2ec3d62a86d2a0d2fad117f13]
stable/5.10: [2295a7ef5c8c49241bff769e7826ef2582e532a6]
stable/5.15: [eacb8b195579c174a6d3e12a9690b206eb7f28cf]
stable/5.4: [db0082825037794c5dba9959c9de13ca34cc5e72]
stable/6.1: [81dd3c82a456b0015461754be7cb2693991421b4]
stable/6.6: [5af198c387128a9d2ddd620b0f0803564a4d4508]

CVE-2024-36972: af_unix: Update unix_sk(sk)->oob_skb under
sk_receive_queue lock.

Added fixed commit to 5.15.

Fixed status
mainline: [9841991a446c87f90f66f4b9fee6fe934c1336a2]
stable/5.15: [518a994aa0b87d96f1bc6678a7035df5d1fcd7a1]
stable/6.1: [4bf6964451c3cb411fbaa1ae8b214b3d97a59bf1]
stable/6.6: [d59ae9314b97e01c76a4171472441e55721ba636]


Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

