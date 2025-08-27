Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C78CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 23:11:50 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.8610.1756336305079022036
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Aug 2025 16:11:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=DoQzue61;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d608e34b4so2818987b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 16:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1756336304; x=1756941104; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbEbKH5bVEjVT0k7Nul9HKc3Z/GuLZElrEIgP+TxjD8=;
        b=DoQzue61wqLRVyyZdyhp9vAa5uWXUgw3TSwxTMPngPS2WXQypWPP0LgGKNoICE1BcP
         I/WPJgUdPvkkFgZBExl97MYdY8OS+gMvbPwbzRy4JnKSEUJCdm/NKmfAX7cNpscdq6Wt
         pSYJ/0LTpo25uODZ/34YjSUPuLmDsKDu9ZK0xSZBChB5l3XywU4xYGR5C4iYCT2tHaoT
         szt0BwNyD9uPbkvxIqfyA1BumojPE6JwpfUMaEV+91BtdTNmhebpAaRaJ+FGka5xlvb8
         kIr8wA+yd/wp3y1A8wKonbfWVq1shGhP2rYcIFwl0zDhUZe/HjcvV/MBwt9Cn/4cZw5o
         os9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336304; x=1756941104;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbEbKH5bVEjVT0k7Nul9HKc3Z/GuLZElrEIgP+TxjD8=;
        b=accnXG9tVdQfvqPS90js17zDQszUuVF3WHjPzGaDBRlVlqgH9bJdwUphlhspzWpfCc
         0xL21wtSkpYdS2h3n1sFGdCdJDCOS+KAlfnv6z6XNEVPnOsjekuOLWVcBQWkvqvDLmSX
         0UhuEpLTb/ZD91yfHrOq/cBSD0j6ewdhOsIeQRTR/fPvt0MdirHtDzXibuR0z0FrocGz
         6UDHbNAjyF68E3/lyzpBVDr6Bn2pKc8qU2AHXvbf0Ls33kHryIlI30NFvKOlfhcj+dvj
         ZB//6UEtO2AOsxYVhbYbu66a9XhGBvNx4GUr0fndwRKdl84PeoYRjiLPJdysGZfHdxCa
         0Neg==
X-Gm-Message-State: AOJu0YzDfzl3aAAr0TR1qlbpBPfdVK+4vhluvt2MmDewd59C7R/1Wf4X
	i34tcPkV3USEZ8RV3PMxeh0lXRcQ6XlPeyCFY8IdeZZT6d41n1GZ3MSTxoC4EZ83r8ZCHT8s+cv
	bGsyOgS9oqyOIip4bkDDFGRraVl1f39SmajWNdvzZ93HUKM1+lk5P0wY=
X-Gm-Gg: ASbGncu0c8PJ0sBqwlJztqlAOaOm4DlkfqzoNhu6JSv7/6HcPgTVv9YR3bgRFMdtCw7
	2dQIZM7IVqr7g5cnKpZG5JEeNbyYSHNkmaybrIFcaDJAf5//W7wn0C9fNYZ92BHOhYAJNJfHoED
	AmkMmswRIi9+RwMaOE+eSbkx9ONEB3M3O42NmiekJEakaXgbortYSX5t6m+C1ygafn9RMhdqFOD
	8W6lnl4
X-Google-Smtp-Source: AGHT+IEZSYKeUgq4TqL8GPZ1VeH5405gQzuKATBor1u9J8TnyD0qgRqQmdHP5NHNqjgB3YuzI7aFjcUctRPRKGtS+ug=
X-Received: by 2002:a05:690c:2603:b0:721:5aa1:8fe5 with SMTP id
 00721157ae682-7215aa19107mr14699627b3.4.1756336303479; Wed, 27 Aug 2025
 16:11:43 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 Aug 2025 08:11:06 +0900
X-Gm-Features: Ac12FXw3Png2FYcPvKmwjm_YCKnGDx2NSAw6DiyGPuGTdbtyyVPDCLGeedjZvbI
Message-ID: <CAODzB9p+RZX7QPeXDinjzc38WFKaT6b05erF8Bn_LfHLiuFRGA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 23:11:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19978

Hi!

It's this week's CVE report.

This week reported 61 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2024-58239: tls: stop recv() if initial process_rx_list gave us non-DATA

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58239

Introduced by commit 692d7b5 ("tls: Fix recvmsg() to be able to peek
across multiple records") in v5.1-rc1.
Fixed in v6.8-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdfbaec5923d9359698cbb286bc0deadbb717504]
stable/5.10: [31e10d6cb0c9532ff070cf50da1657c3acee9276]
stable/5.15: [4338032aa90bd1d5b33a4274e8fa8347cda5ee09]
stable/5.4: [f310143961e2d9a0479fca117ce869f8aaecc140]
stable/6.1: [6756168add1c6c3ef1c32c335bb843a5d1f99a75]
stable/6.6: [3b952d8fdfcf6fd8ea0b8954bc9277642cf0977f]

CVE-2025-38616: tls: handle data disappearing from under the TLS ULP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38616

Introduced by commit 84c61fe ("tls: rx: do not use the standard
strparser") in v6.0-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6db015fc4b5d5f63a64a193f65d98da3a7fc811d]
stable/6.12: [eb0336f213fe88bbdb7d2b19c9c9ec19245a3155]

CVE-2025-38617: net/packet: fix a race in packet_set_ring() and
packet_notifier()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38617

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01d3c8417b9c1b884a8a981a3b886da556512f36]
stable/6.1: [7de07705007c7e34995a5599aaab1d23e762d7ca]
stable/6.12: [f2e8fcfd2b1bc754920108b7f2cd75082c5a18df]
stable/6.6: [88caf46db8239e6471413d28aabaa6b8bd552805]

CVE-2025-38618: vsock: Do not allow binding to VMADDR_PORT_ANY

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38618

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aba0c94f61ec05315fa7815d21aefa4c87f6a9f4]
stable/6.1: [f138be5d7f301fddad4e65ec66dfc3ceebf79be3]
stable/6.12: [32950b1907919be86a7a2697d6f93d57068b3865]
stable/6.6: [44bd006d5c93f6a8f28b106cbae2428c5d0275b7]

CVE-2025-38619: media: ti: j721e-csi2rx: fix list_del corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38619

Introduced by commit b4a3d87 ("media: ti: Add CSI2RX support for
J721E") in v6.7-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae42c6fe531425ef2f47e82f96851427d24bbf6b]
stable/6.12: [68e5579f4de12207b23c41b44a4c0778b6c2858f]

CVE-2025-38620: zloop: fix KASAN use-after-free of tag set

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38620

Introduced by commit eb0570c ("block: new zoned loop block device
driver") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [765761851d89c772f482494d452e266795460278]

CVE-2025-38621: md: make rdev_addable usable for rcu mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38621

Introduced by commit bc08041 ("md: suspend array in md_start_sync() if
array need reconfiguration") in v6.7-rc1.
Introduced by commit 570b914 ("md: use RCU lock to protect traversal
in md_spares_need_change()") in v6.9-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13017b427118f4311471ee47df74872372ca8482]

CVE-2025-38622: net: drop UFO packets in udp_rcv_segment()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38622

Introduced by commit cf329aa ("udp: cope with UDP GRO packet
misdirection") in v5.0-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d46e51f1c78b9ab9323610feb14238d06d46d519]
stable/6.1: [791f32c5eab33ca3a153f8f6f763aa0df1ddc320]
stable/6.12: [c0ec2e47f1e92d69b42b17a4a1e543256778393e]
stable/6.6: [0d45954034f8edd6d4052e0190d3d6335c37e4de]

CVE-2025-38623: PCI: pnv_php: Fix surprise plug detection and recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38623

Introduced commit is not determined.Fixed in v6.17-rc1.
The drivers/pci/hotplug was added by 6672515 ("PCI/hotplug: PowerPC
PowerNV PCI hotplug driver") in 4.8-rc1.

Fixed status
mainline: [a2a2a6fc2469524caa713036297c542746d148dc]
stable/6.1: [473999ba937eac9776be791deed7c84a21d7880b]
stable/6.12: [48c6935a34981bb56f35be0774ec1f30c6e386f8]
stable/6.6: [6e7b24c71e530a6c1d656e73d8a30ee081656844]

CVE-2025-38624: PCI: pnv_php: Clean up allocated IRQs on unplug

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38624

Introduced commit is not determined.Fixed in v6.17-rc1.
The drivers/pci/hotplug was added by 6672515 ("PCI/hotplug: PowerPC
PowerNV PCI hotplug driver") in 4.8-rc1.

Fixed status
mainline: [4668619092554e1b95c9a5ac2941ca47ba6d548a]
stable/6.1: [398170b7fd0e0db2f8096df5206c75e5ff41415a]
stable/6.12: [28aa3cfce12487614219e7667ec84424e1f43227]
stable/6.6: [32173edf3fe2d447e14e5e3b299387c6f9602a88]

CVE-2025-38625: vfio/pds: Fix missing detach_ioas op

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38625

Introduced by commit 38fe397 ("vfio/pds: Initial support for pds VFIO
driver") in v6.6-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe24d5bc635e103a517ec201c3cb571eeab8be2f]
stable/6.12: [1df8150ab4cc422bddfbd312d6758c50b688a971]
stable/6.6: [7dbfae90c5a33f6b694e7068bc9522cc2655373d]

CVE-2025-38626: f2fs: fix to trigger foreground gc during
f2fs_map_blocks() in lfs mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38626

Introduced by commit 36abef4 ("f2fs: introduce mode=lfs mount option")
in v4.8-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1005a3ca28e90c7a64fa43023f866b960a60f791]
stable/6.12: [82765ce5c7a56f9309ee45328e763610eaf11253]
stable/6.6: [f289690f50a01c3e085d87853392d5b7436a4cee]

CVE-2025-38627: f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38627

Introduced by commit bff139b ("f2fs: handle decompress only post
processing in softirq") in v6.0-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39868685c2a94a70762bc6d77dc81d781d05bff5]

CVE-2025-38628: vdpa/mlx5: Fix release of uninitialized resources on error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38628

Introduced by commit 83e445e ("vdpa/mlx5: Fix error path during device
add") in v6.12.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc51a66815999afb7e9cd845968de4fdf07567b7]
stable/6.12: [37f26b9013b46457b0a96633fc3a7dc977d8beb1]

CVE-2025-38629: ALSA: usb: scarlett2: Fix missing NULL check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38629

Introduced by commit 8eba063 ("ALSA: scarlett2: Simplify linked
channel handling") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df485a4b2b3ee5b35c80f990beb554e38a8a5fb1]

CVE-2025-38630: fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38630

Introduced by commit 1b6c793 ("video: imxfb: Add DT support") in v3.11-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da11e6a30e0bb8e911288bdc443b3dc8f6a7cac7]
stable/6.1: [ac16154cccda8be10ee3ae188f10a06f3890bc5d]
stable/6.12: [40f0a51f6c54d46a94b9f1180339ede7ca7ee190]
stable/6.6: [4b5d36cc3014986e6fac12eaa8433fe56801d4ce]

CVE-2025-38631: clk: imx95-blk-ctl: Fix synchronous abort

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38631

Introduced by commit 5224b18 ("clk: imx: add i.MX95 BLK CTL clk
driver") in v6.10-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b08217a257215ed9130fce93d35feba66b49bf0a]
stable/6.12: [c1dead8bb303f86905ea6a09e5acda931165453b]

CVE-2025-38632: pinmux: fix race causing mux_owner NULL with active mux_usecount

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38632

Introduced by commit 5a3e85c ("pinmux: Use sequential access to access
desc->pinmux data") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [0b075c011032f88d1cfde3b45d6dcf08b44140eb]
stable/6.12: [9ea3f6b9a67be3476e331ce51cac316c2614a564]
stable/6.6: [9b2a3e7189028aa7c4d53a84364f2ea9fb209787]

CVE-2025-38633: clk: spacemit: mark K1 pll1_d8 as critical

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38633

Introduced by commit 1b72c59 ("clk: spacemit: Add clock support for
SpacemiT K1 SoC") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7554729de27daf6d54bcf8689d863bbe267828bf]

CVE-2025-38634: power: supply: cpcap-charger: Fix null check for
power_supply_get_by_name

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38634

Introduced by commit eab4e6d ("power: supply: cpcap-charger: get the
battery inserted infomation from cpcap-battery") in v5.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9fa3aae08f99493e67fb79413c0e95d30fca5e9]
stable/6.1: [a2436263144980cc99a9860c7b43335847afbe53]
stable/6.12: [f642500aa7ed93d2606e4f929244cce9c7467b3a]
stable/6.6: [8e9bdb563916287ba1b4258812434e0585ac6d00]

CVE-2025-38635: clk: davinci: Add NULL check in davinci_lpsc_clk_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38635

Introduced by commit c6ed4d7 ("clk: davinci: New driver for davinci
PSC clocks") in v4.17-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13de464f445d42738fe18c9a28bab056ba3a290a]
stable/6.1: [105e8115944a9f93e9412abe7bb07ed96725adf9]
stable/6.12: [7943ed1f05f5cb7372dca2aa227f848747a98791]
stable/6.6: [1d92608a29251278015f57f3572bc950db7519f0]

CVE-2025-38636: rv: Use strings in da monitors tracepoints

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38636

Introduced by commit 7925753 ("rv/include: Add deterministic automata
monitor definition via C macros") in v6.0-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f904ff6e58d398c4336f3c19c42b338324451f7]

CVE-2025-38638: ipv6: add a retry logic in net6_rt_notify()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38638

Introduced by commit 169fd62 ("ipv6: Get rid of RTNL for SIOCADDRT and
RTM_NEWROUTE.") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea2f921db7a483a526058c5b5b8162edd88dabe5]

CVE-2025-38639: netfilter: xt_nfacct: don't assume acct name is null-terminated

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38639

Introduced by commit ceb98d0 ("netfilter: xtables: add nfacct match to
support extended accounting") in v3.3-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf58e667af7d96c8eb9411f926a0a0955f41ce21]
stable/6.1: [e18939176e657a3a20bfbed357b8c55a9f82aba3]
stable/6.12: [7c1ae471da69c09242834e956218ea6a42dd405a]
stable/6.6: [58004aa21e79addaf41667bfe65e93ec51653f18]

CVE-2025-38640: bpf: Disable migration in nf_hook_run_bpf().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38640

Introduced by commit fd9c663 ("bpf: minimal support for programs
hooked into netfilter framework") in v6.4-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17ce3e5949bc37557305ad46316f41c7875d6366]
stable/6.12: [62f6175d145e00fc999fd2fcbffad3f59253c66a]
stable/6.6: [ee2502485702e4398cd74dbfb288bfa111d25e62]

CVE-2025-38641: Bluetooth: btusb: Fix potential NULL dereference on
kmalloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38641

Introduced by commit 7d70989 ("Bluetooth: btusb: Add HCI Drv commands
for configuring altsetting") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b505902c66a282dcb01bcdc015aa1fdfaaa075db]

CVE-2025-38642: wifi: mac80211: fix WARN_ON for monitor mode on some devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38642

Introduced by commit c4382d5 ("wifi: mac80211: update the right link
for tx power") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c57e5b9819dfd16d709bcd6cb633301ed0829a66]

CVE-2025-38643: wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38643

Introduced by commit 26ec17a ("cfg80211: Fix radar event during
another phy CAC") in v5.5-rc7.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
mainline: [2c5dee15239f3f3e31aa5c8808f18996c039e2c1]

CVE-2025-38644: wifi: mac80211: reject TDLS operations when station is
not associated

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38644

Introduced by commit 81dd2b8 ("mac80211: move TDLS data to mgd private
part") in v3.17-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16ecdab5446f15a61ec88eb0d23d25d009821db0]
stable/6.1: [0c84204cf0bbe89e454a5caccc6a908bc7db1542]
stable/6.12: [af72badd5ee423eb16f6ad7fe0a62f1b4252d848]
stable/6.6: [378ae9ccaea3f445838a087962a067b5cb2e8577]

CVE-2025-38645: net/mlx5: Check device memory pointer before usage

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38645

Introduced by commit c9b9dcb ("net/mlx5: Move device memory management
to mlx5_core") in v5.4-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70f238c902b8c0461ae6fbb8d1a0bbddc4350eea]
stable/6.1: [eebb225fe6c9103293807b8edabcbad59f9589bc]
stable/6.12: [4249f1307932f1b6bbb8b7eba60d82f0b7e44430]
stable/6.6: [62d7cf455c887941ed6f105cd430ba04ee0b6c9f]

CVE-2025-38646: wifi: rtw89: avoid NULL dereference when RX
problematic packet on unsupported 6 GHz band

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38646

Introduced by commit c6aa9a9 ("wifi: rtw89: add RNR support for 6 GHz
scan") in v6.4-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e04f01bb94fe61c73cc59f0495c3b6c16a83231]
stable/6.12: [77a7a48f87d673a68664bebf044214821decbfda]
stable/6.6: [892b29eab44b1803d2cad8e50f1bc2144ef478cb]

CVE-2025-38647: wifi: rtw89: sar: drop lockdep assertion in
rtw89_set_sar_from_acpi

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38647

Introduced by commit 88ca310 ("wifi: rtw89: sar: add skeleton for SAR
configuration via ACPI") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fe21445f7e801de5527d420f8e25e97b0cdd7e2]

CVE-2025-38648: spi: stm32: Check for cfg availability in stm32_spi_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38648

Introduced by commit fee6816 ("spi: stm32: disable device mode with
st,stm32f4-spi compatible") in v6.6-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21f1c800f6620e43f31dfd76709dbac8ebaa5a16]
stable/6.12: [a7645815edf4478f3258bb0db95a08986a77f5c0]
stable/6.6: [6031a54f4eac921efe6122a561d44df89b37f2d4]

CVE-2025-38649: arm64: dts: qcom: qcs615: fix a crash issue caused by
infinite loop for Coresight

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38649

Introduced by commit bf46963 ("arm64: dts: qcom: qcs615: Add coresight
nodes") in v6.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd4f35786d5f0798cc1f8c187a81a7c998e6c58f]

CVE-2025-38650: hfsplus: remove mutex_lock check in hfsplus_free_extents

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38650

Introduced by commit 31651c6 ("hfsplus: avoid deadlock on file
truncation") in v4.19-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcb96956c921f1aae7e7b477f2435c56f77a31b4]
stable/6.1: [a19ce9230b22a0866313932e7964cf05557a6008]
stable/6.12: [5055b7db94110f228961dea6b74eed0a93a50b01]
stable/6.6: [084933961ecda7561dedfb78c4676ccb90c91ada]

CVE-2025-38651: landlock: Fix warning from KUnit tests

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38651

Introduced by commit d9d2a68 ("landlock: Add unique ID generator") in v6.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0a69cf2c03e61bd8069becb97f66c173d0d1fa1]

CVE-2025-38652: f2fs: fix to avoid out-of-boundary access in devs.path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38652

Introduced by commit 3c62be1 ("f2fs: support multiple devices") in v4.10-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5661998536af52848cc4d52a377e90368196edea]
stable/6.1: [3466721f06edff834f99d9f49f23eabc6b2cb78e]
stable/6.12: [70849d33130a2cf1d6010069ed200669c8651fbd]
stable/6.6: [345fc8d1838f3f8be7c8ed08d86a13dedef67136]

CVE-2025-38653: proc: use the same treatment to check proc_lseek as
ones for proc_read_iter et.al

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38653

Introduced by commit 3f61631 ("take care to handle NULL
->proc_lseek()") in v6.0-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff7ec8dc1b646296f8d94c39339e8d3833d16c05]
stable/6.1: [c35b0feb80b48720dfbbf4e33759c7be3faaebb6]
stable/6.12: [fc1072d934f687e1221d685cf1a49a5068318f34]
stable/6.6: [33c778ea0bd0fa62ff590497e72562ff90f82b13]

CVE-2025-38654: pinctrl: canaan: k230: Fix order of DT parse and
pinctrl register

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38654

Introduced by commit 545887e ("pinctrl: canaan: Add support for k230
SoC") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d94a32ac688f953dc9a9f12b5b4139ecad841bbb]

CVE-2025-38655: pinctrl: canaan: k230: add NULL check in DT parse

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38655

Introduced by commit 545887e ("pinctrl: canaan: Add support for k230
SoC") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65bd0be486390fc12a84eafaad78758c5e5a55e6]

CVE-2025-38656: wifi: iwlwifi: Fix error code in iwl_op_mode_dvm_start()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38656

Introduced by commit 90a0d9f ("iwlwifi: Add missing check for
alloc_ordered_workqueue") in v6.17-rc1.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.16 stable/6.6

Fixed status
mainline: [cf80c02a9fdb6c5bc8508beb6a0f6a1294fc32f6]

CVE-2025-38657: wifi: rtw89: mcc: prevent shift wrapping in
rtw89_core_mlsr_switch()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38657

Introduced by commit 9dd85e7 ("wifi: rtw89: debug: add mlo_mode
dbgfs") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53cf488927a0f79968f9c03c4d1e00d2a79731c3]

CVE-2025-38658: nvmet: pci-epf: Do not complete commands twice if
nvmet_req_init() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38658

Introduced by commit 0faa0fe ("nvmet: New NVMe PCI endpoint function
target driver") in v6.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [746d0ac5a07d5da952ef258dd4d75f0b26c96476]

CVE-2025-38659: gfs2: No more self recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38659

Introduced by commit 601ef0d ("gfs2: Force withdraw to replay journals
and wait for it to finish") in v5.7-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deb016c1669002e48c431d6fd32ea1c20ef41756]
stable/6.12: [f5426ffbec971a8f7346a57392d3a901bdee5a9b]
stable/6.6: [1a91ba12abef628b43cada87478328274d988e88]

CVE-2025-38660: [ceph] parse_longname(): strrchr() expects NUL-terminated string

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38660

Introduced by commit dd66df0 "ceph: add support for encrypted snapshot
names" in v6.6-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [101841c38346f4ca41dc1802c867da990ffb32eb]
stable/6.12: [bb80f7618832d26f7e395f52f82b1dac76223e5f]

CVE-2025-38661: platform/x86: alienware-wmi-wmax: Fix `dmi_system_id` array

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38661

Introduced by commit 6d7f1b1 ("platform/x86: alienware-wmi: Split DMI
table") in v6.15-rc1.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8346c6af27f1c1410eb314f4be5875fdf1579a10]

CVE-2025-38662: ASoC: mediatek: mt8365-dai-i2s: pass correct size to
mt8365_dai_set_priv

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38662

Introduced by commit 402bbb1 ("ASoC: mediatek: mt8365: Add I2S DAI
support") in v6.12-rc1.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bea85979d05470e6416a2bb504a9bcd9178304c]
stable/6.12: [1dc0ed16cfbc3c28a07a89904071cfa802fdcee1]

CVE-2025-38663: nilfs2: reject invalid file types when reading inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38663

Introduced by commit 05fe58f ("nilfs2: inode operations") in v2.6.30-rc1.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4aead50caf67e01020c8be1945c3201e8a972a27]
stable/6.1: [1a5c204e175a78556b8ef1f7683249fa5197295a]
stable/6.12: [79663a15a1c70ca84f86f2dbba07b423fe7d5d4f]
stable/6.6: [bf585ee198bba4ff25b0d80a0891df4656cb0d08]

CVE-2025-38664: ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38664

Introduced by commit c764881 ("ice: Implement Dynamic Device
Personalization (DDP) download") in v5.4-rc1.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ff12d82dac119b4b99b5a78b5af3bf2474c0a36]
stable/6.1: [1c30093d58cd3d02d8358e2b1f4a06a0aae0bf5b]
stable/6.12: [0fde7dccbf4c8a6d7940ecaf4c3d80a12f405dd7]
stable/6.6: [3028f2a4e746b499043bbb8ab816f975473a0535]

CVE-2025-38665: can: netlink: can_changelink(): fix NULL pointer deref
of struct can_priv::do_set_mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38665

Introduced by commit 39549ee ("can: CAN Network device driver and
Netlink interface") in v2.6.31-rc1.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1f3f9797c1f44a762e6f5f72520b2e520537b52]
stable/6.1: [6bbcf37c5114926c99a1d1e6993a5b35689d2599]
stable/6.12: [0ca816a96fdcf32644c80cbe7a82c7b6ce6ddda5]
stable/6.6: [cf81a60a973358dea163f6b14062f17831ceb894]

CVE-2025-38666: net: appletalk: Fix use-after-free in AARP proxy probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38666

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c4a92d07b0850342d3becf2e608f805e972467c]
stable/6.1: [2a6209e4649d45fd85d4193abc481911858ffc6f]
stable/6.12: [5f02ea0f63dd38c41539ea290fcc1693c73aa8e5]
stable/6.6: [e4f1564c5b699eb89b3040688fd6b4e57922f1f6]

CVE-2025-38667: iio: fix potential out-of-bound write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38667

Introduced by commit 6d5dd48 iio: core: make use of
simple_write_to_buffer() in v6.15-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16285a0931869baa618b1f5d304e1e9d090470a8]

CVE-2025-38668: regulator: core: fix NULL dereference on unbind due to
stale coupling data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38668

Introduced commit is not determined.Fixed in v6.16-rc5.


Fixed status
mainline: [ca46946a482238b0cdea459fb82fc837fb36260e]
stable/6.1: [800a2cfb2df7f96b3fb48910fc595e0215f6b019]
stable/6.12: [5d4261dbb3335221fd9c6e69f909ba79ee6663a7]
stable/6.6: [233d3c54c9620e95193923859ea1d0b0f5d748ca]

CVE-2025-38669: Revert "drm/gem-shmem: Use dma_buf from GEM object instance"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38669

Introduced commit is not determined.Fixed in v6.16.
This fix reverted commit 1a148af ("drm/gem-shmem: Use dma_buf from
GEM object instance") in 6.15-rc1.

Fixed status
mainline: [6d496e9569983a0d7a05be6661126d0702cf94f7]

CVE-2025-38670: arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38670

Introduced by commit 59b37fe ("arm64: Stash shadow stack pointer in
the task struct on interrupt") in v6.3-rc1.
Fixed in v6.16.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [d42e6c20de6192f8e4ab4cf10be8c694ef27e8cb]
stable/6.12: [708fd522b86d2a9544c34ec6a86fa3fc23336525]
stable/6.6: [9433a5f437b0948d6a2d8a02ad7a42ab7ca27a61]

CVE-2025-38671: i2c: qup: jump out of the loop in case of timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38671

Introduced by commit fbfab1a ("i2c: qup: reorganization of driver code
to remove polling for qup v1") in v4.17-rc1.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7982a14b3012527a9583d12525cd0dc9f8d8934]
stable/6.1: [c523bfba46c4b4d7676fb050909533a766698ecd]
stable/6.12: [42c4471b30fa203249f476dd42321cd7efb7f6a8]
stable/6.6: [0d33913fce67a93c1eb83396c3c9d6b411dcab33]

CVE-2025-38672: Revert "drm/gem-dma: Use dma_buf from GEM object instance"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38672

Introduced commit is not determined.Fixed in v6.16.
This commit reverted commit e8afa15 ("drm/gem-dma: Use dma_buf from
GEM object instance") in 6.15-rc1.

Fixed status
mainline: [1918e79be908b8a2c8757640289bc196c14d928a]

CVE-2025-38673: Revert "drm/gem-framebuffer: Use dma_buf from GEM
object instance"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38673

Introduced commit is not determined.Fixed in v6.16.
This commit reverted commit cce16fc ("drm/gem-framebuffer: Use dma_buf
from GEM object instance") in 6.15-rc1.

Fixed status
mainline: [2712ca878b688682ac2ce02aefc413fc76019cd9]

CVE-2025-38674: Revert "drm/prime: Use dma_buf from GEM object instance"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38674

Introduced commit is not determined.Fixed in v6.16.
This commit reverted commit f83a9b8 ("drm/prime: Use dma_buf from GEM
object instance") in 6.15-rc1.

Fixed status
mainline: [fb4ef4a52b79a22ad382bfe77332642d02aef773]

CVE-2025-38675: xfrm: state: initialize state_ptrs earlier in xfrm_state_find

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38675

Introduced by commit e952837 ("xfrm: state: fix out-of-bounds read
during lookup") in v6.14-rc1.
Fixed in v6.16.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [94d077c331730510d5611b438640a292097341f0]
stable/6.12: [6bf2daafc51bcb9272c0fdff2afd38217337d0d3]

CVE-2025-38676: iommu/amd: Avoid stack buffer overflow from kernel cmdline

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38676

Introduced by commit b6b26d8 ("iommu/amd: Add a length limitation for
the ivrs_acpihid command-line parameter") in v6.3-rc1.
Fixed in v6.17-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [8503d0fcb1086a7cfe26df67ca4bd9bd9e99bdec]


* Updated CVEs

CVE-2023-52656: io_uring: drop any code related to SCM_RIGHTS

stable/6.6 was fixed.

Fixed status
stable/6.6: [6fc19b3d8a45ff0e5d50ec8184cee1d5eac1a8ba]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

