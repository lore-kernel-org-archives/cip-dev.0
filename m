Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0F8D6B6DD
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 22:13:11 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web10.27809.1730326383668942178
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 15:13:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=QeAOpxin;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso364897276.0
        for <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1730326383; x=1730931183; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRmqpND7K6AC75Kmv6/fxKHMCJSDkRT2HGj0hcMXcgE=;
        b=QeAOpxinuBIZK0G5/RBp5sty73CsYbzpexIGpUeZUoL17p3+gDl3O8qZrFSrUc9tV8
         A8ina6QdkeMIGrwXF0xXswi+LrekqJXNmCWLxuHyRs/HO1dGyxdvnc0F345jIqmpvFbC
         X5NYBR3VAHQP2HNNcBtgUAfRUwuG+xpCq194jMOXOj1ivvbu8b95a074T+WJzIpWx+ch
         1ulI3dLA2f9dLEtUZp2mO/AFE6BC9dHpkq7llOPDjfRcG/o8VI+hdj4E3g10DpqT5KiP
         NqXaXTkn1ADGdVhVpxZlm9pBxThtRek+fdoZhpHalCj9grlkXkfwm4w0/G+D5kJUmIDp
         yAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730326383; x=1730931183;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRmqpND7K6AC75Kmv6/fxKHMCJSDkRT2HGj0hcMXcgE=;
        b=Ijot0VOD1Ac6ONIbI2C0BW33yTEWYPU7FC/oskPG4MVfLKLpt8JWLKBH+lECfBXH7U
         4DdPkiS5IpweazGWeyleIAzW7AQnmGpyJv2+hH3vu47e37sI7ez0W20YeMpMoO+qaSBq
         s0gZcHDGkB8uDqLjJMIqvEQbkIbfxroWWrvmPhzmVByflDo/17yQ32R2C+zS8n5BZdsd
         u66EpchKSOdDJJgTbh8k1trNTQsGdOt0vdVV+KN7gTV0RtWGo+ZBFXgNfGyjvvaMHtfo
         zxLRTiVoNELw0B0US5ei2TmBwIqctLv2JMpyuuLiovmjCjCq8wBitRqKkb4Dtq5aFXvE
         c55w==
X-Gm-Message-State: AOJu0YwCdCebAOfwzTLMKq82vLQt0d7vOzbcAy2ZcCjOFAIrhyb1pxOl
	+vE7/GfVvd9Di6zDvn23xKxhMfbv8ZtgzKHqpPqUNBnSNG38ntpL/QZyObkM10z2WscZaL44p9T
	tpVtPzhshf7u6WV/gte6zNx0Ion492Ay0lpjSeldDoCqkRFTxdR0=
X-Google-Smtp-Source: AGHT+IEU5Kk4nhjKs8jRjJ1l+3plFx0ROvUNPjnKZ/TVgkMzamqWgBOqOwOTfu+mJ88KOFkKFOPz1p/MS/BawLpd1Gg=
X-Received: by 2002:a05:6902:708:b0:e29:699:3ca5 with SMTP id
 3f1490d57ef6-e3087b83840mr15900933276.22.1730326382385; Wed, 30 Oct 2024
 15:13:02 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 31 Oct 2024 07:12:26 +0900
Message-ID: <CAODzB9qN+Y+AKu++xg8zaOSoHnsfgp2rtiaYtaWMogipx+gPhQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 22:13:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17124

Hi!

It's this week's CVE report.

This week reported 22 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2024-50067: uprobe: avoid out-of-bounds memory access of fetching args

Announce: https://lore.kernel.org/linux-cve-announce/2024102859-CVE-2024-50067-f7c0@gregkh/

Introduced by commit dcad1a2 ("tracing/uprobes: Fetch args before
reserving a ring buffer") in v3.14-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [373b9338c9722a368925d83bc622c596896b328e]

CVE-2024-50068: mm/damon/tests/sysfs-kunit.h: fix memory leak in
damon_sysfs_test_add_targets()

Announce: https://lore.kernel.org/linux-cve-announce/2024102930-CVE-2024-50068-2e3c@gregkh/

Introduced by commit b8ee557 ("mm/damon/sysfs-test: add a unit test
for damon_sysfs_set_targets()") in v6.7-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d6a1c835685de3b0c8e8dc871f60f4ef92ab01a]

CVE-2024-50069: pinctrl: apple: check devm_kasprintf() returned value

Announce: https://lore.kernel.org/linux-cve-announce/2024102933-CVE-2024-50069-fe0a@gregkh/

Introduced by commit a0f160f ("pinctrl: add pinctrl/GPIO driver for
Apple SoCs") in v5.16-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [665a58fe663ac7a9ea618dc0b29881649324b116]
stable/6.1: [0a4d4dbef622ac8796a6665e0080da2685f9220a]
stable/6.6: [fad940e2dd789155f99ecafa71a7baf6f96530bc]

CVE-2024-50070: pinctrl: stm32: check devm_kasprintf() returned value

Announce: https://lore.kernel.org/linux-cve-announce/2024102934-CVE-2024-50070-1cc7@gregkh/

Introduced by commit 32c170f ("pinctrl: stm32: set default gpio line
names using pin names") in v6.6-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0f0e3f0552a566def55c844b0d44250c58e4df6]
stable/6.6: [3b36bb1fca2b87f6292ca2a8593f297c5e9fab41]

CVE-2024-50071: pinctrl: nuvoton: fix a double free in
ma35_pinctrl_dt_node_to_map_func()

Announce: https://lore.kernel.org/linux-cve-announce/2024102934-CVE-2024-50071-6dd6@gregkh/

Introduced by commit f805e35 ("pinctrl: nuvoton: Add ma35d1 pinctrl
and GPIO driver") in v6.11-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fd976afe9743110f20a23f93b7ff9693f2be4bf]

CVE-2024-50072: x86/bugs: Use code segment selector for VERW operand

Announce: https://lore.kernel.org/linux-cve-announce/2024102934-CVE-2024-50072-14b5@gregkh/

Introduced by commit a0e2dab ("x86/entry_32: Add VERW just before
userspace transition") in v6.8-rc6.
Fixed in v6.12-rc4.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [e4d2102018542e3ae5e297bc6e229303abff8a0f]
stable/6.6: [481b477ab63c7245715a3e57ba79eb87c2dc0d02]

CVE-2024-50073: tty: n_gsm: Fix use-after-free in gsm_cleanup_mux

Announce: https://lore.kernel.org/linux-cve-announce/2024102935-CVE-2024-50073-307b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc4.

Fixed status
mainline: [9462f4ca56e7d2430fdb6dcc8498244acbfc4489]
stable/6.1: [bf171b5e86e41de4c1cf32fb7aefa275c3d7de49]
stable/6.6: [c29f192e0d44cc1cbaf698fa1ff198f63556691a]

CVE-2024-50074: parport: Proper fix for array out-of-bounds access

Announce: https://lore.kernel.org/linux-cve-announce/2024102935-CVE-2024-50074-d44d@gregkh/

Introduced by commit ab11dac ("dev/parport: fix the array
out-of-bounds risk") in v6.11-rc1.
Fixed in v6.12-rc4.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [02ac3a9ef3a18b58d8f3ea2b6e46de657bf6c4f9]
stable/5.10: [1826b6d69bbb7f9ae8711827facbb2ad7f8d0aaa]
stable/5.15: [440311903231c6e6c9bcf8acb6a2885a422e00bc]
stable/6.1: [fca048f222ce9dcbde5708ba2bf81d85a4a27952]
stable/6.6: [66029078fee00646e2e9dbb8f41ff7819f8e7569]

CVE-2024-50075: xhci: tegra: fix checked USB2 port number

Announce: https://lore.kernel.org/linux-cve-announce/2024102935-CVE-2024-50075-81b7@gregkh/

Introduced by commit a30951d ("xhci: tegra: USB2 pad power controls")
in v6.3-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d381137cb6ecf558ef6698c7730ddd482d4c8f2]
stable/6.6: [9c696bf4ab54c7cec81221887564305f0ceeac0a]

CVE-2024-50076: vt: prevent kernel-infoleak in con_font_get()

Announce: https://lore.kernel.org/linux-cve-announce/2024102936-CVE-2024-50076-43f7@gregkh/

Introduced by commit 05e2600 ("VT: Bump font size limitation to 64x128
pixels") in v6.3-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f956052e00de211b5c9ebaa1958366c23f82ee9e]
stable/6.6: [dc2d5f02636c7587bdd6d1f60fc59c55860b00a4]

CVE-2024-50077: Bluetooth: ISO: Fix multiple init when debugfs is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2024102936-CVE-2024-50077-2940@gregkh/

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9b7b535ba192c6b77e6c15a4c82d853163eab8c]
stable/6.1: [fa4b832c5a6ec35023a1b997cf658c436619c752]
stable/6.6: [8fb8e912afb4c47dec12ea9a5853e7a8db95816f]

CVE-2024-50078: Bluetooth: Call iso_exit() on module unload

Announce: https://lore.kernel.org/linux-cve-announce/2024102936-CVE-2024-50078-cfe9@gregkh/

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d458cd1221e9e56da3b2cc5518ad3225caa91f20]
stable/6.1: [4af7ba39a1a02e16ee8cd0d3b6c6657f51b8ad7a]
stable/6.6: [05f84d86169b2ebac185c5736a256823d42c425b]

CVE-2024-50079: io_uring/sqpoll: ensure task state is TASK_RUNNING
when running task_work

Announce: https://lore.kernel.org/linux-cve-announce/2024102936-CVE-2024-50079-47af@gregkh/

Introduced by commit af5d68f ("io_uring/sqpoll: manage task_work
privately") in v6.9-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f7033aa4089fbaf7a33995f0f2ee6c9d7b9ca1b]

CVE-2024-50080: ublk: don't allow user copy for unprivileged device

Announce: https://lore.kernel.org/linux-cve-announce/2024102936-CVE-2024-50080-72ba@gregkh/

Introduced by commit 1172d5b ("ublk: support user copy") in v6.5-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42aafd8b48adac1c3b20fe5892b1b91b80c1a1e6]
stable/6.6: [6414ab5c9c9c068eca6dc4fd3a036bc4b83164dc]

CVE-2024-50081: blk-mq: setup queue ->tag_set before initializing hctx

Announce: https://lore.kernel.org/linux-cve-announce/2024102937-CVE-2024-50081-f8d6@gregkh/

Introduced by commit 7b81581 ("blk-mq: add helper for checking if one
CPU is mapped to specified hctx") in v6.10-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c25c0c9035bb8b28c844dfddeda7b8bdbcfcae95]

CVE-2024-50082: blk-rq-qos: fix crash on rq_qos_wait vs.
rq_qos_wake_function race

Announce: https://lore.kernel.org/linux-cve-announce/2024102937-CVE-2024-50082-c5b1@gregkh/

Introduced by commit 38cfb5a ("blk-wbt: improve waking of tasks") in v4.19-rc2.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e972b08b91ef48488bae9789f03cfedb148667fb]
stable/5.10: [3bc6d0f8b70a9101456cf02ab99acb75254e1852]
stable/5.15: [455a469758e57a6fe070e3e342db12e4a629e0eb]
stable/6.1: [b5e900a3612b69423a0e1b0ab67841a1fb4af80f]
stable/6.6: [4c5b123ab289767afe940389dbb963c5c05e594e]

CVE-2024-50083: tcp: fix mptcp DSS corruption due to large pmtu xmit

Announce: https://lore.kernel.org/linux-cve-announce/2024102937-CVE-2024-50083-539c@gregkh/

Introduced by commit 8571248 ("tcp: coalesce/collapse must respect
MPTCP extensions") in v5.6-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dabcdf581217e60690467a37c956a5b8dbc6bd9]
stable/5.10: [c38add9ac0e4d4f418e6443a688491499021add9]
stable/5.15: [9729010a0ac5945c1bf6847dd0778d8a1a4b72ac]
stable/6.1: [ba8e65814e519eeb17d086952bce7de93f7a40da]
stable/6.6: [229dfdc36f31a8d47433438bc0e6e1662c4ab404]

CVE-2024-50084: net: microchip: vcap api: Fix memory leaks in
vcap_api_encode_rule_test()

Announce: https://lore.kernel.org/linux-cve-announce/2024102937-CVE-2024-50084-daf1@gregkh/

Introduced by commit a3c1e45 ("net: microchip: vcap: Fix
use-after-free error in kunit test") in v6.11-rc7.
Fixed in v6.12-rc4.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [217a3d98d1e9891a8b1438a27dfbc64ddf01f691]
stable/6.6: [20b5342de51bda794791e013b90754774003a515]

CVE-2024-50085: mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow

Announce: https://lore.kernel.org/linux-cve-announce/2024102938-CVE-2024-50085-7800@gregkh/

Introduced by commit 1c1f721 ("mptcp: pm: only decrement
add_addr_accepted for MPJ req") in v6.11-rc5.
Fixed in v6.12-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [7decd1f5904a489d3ccdcf131972f94645681689]
stable/5.15: [35301636439138b821f1f6169bd00d348ebd388a]
stable/6.1: [da3343bc0839b180fd9af9c27fa456d8231409f9]
stable/6.6: [7b2e478abab0b3a33515433a6af563aebba773c1]

CVE-2024-50086: ksmbd: fix user-after-free from session log off

Announce: https://lore.kernel.org/linux-cve-announce/2024102938-CVE-2024-50086-8134@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc4.

Fixed status
mainline: [7aa8804c0b67b3cb263a472d17f2cb50d7f1a930]
stable/6.1: [a9839c37fd813b432988f58a9d9dd59253d3eb2c]
stable/6.6: [5511999e9615e4318e9142d23b29bd1597befc08]

CVE-2024-50087: btrfs: fix uninitialized pointer free on
read_alloc_one_name() error

Announce: https://lore.kernel.org/linux-cve-announce/2024102938-CVE-2024-50087-dd58@gregkh/

Introduced by commit e43eec8 ("btrfs: use struct qstr instead of name
and namelen pairs") in v6.2-rc1.
Fixed in v6.12-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [2ab5e243c2266c841e0f6904fad1514b18eaf510]
stable/6.1: [b37de9491f140a0ff125c27dd1050185c3accbc1]
stable/6.6: [7fc7c47b9ba0cf2d192f2117a64b24881b0b577f]

CVE-2024-50088: btrfs: fix uninitialized pointer free in add_inode_ref()

Announce: https://lore.kernel.org/linux-cve-announce/2024102938-CVE-2024-50088-848b@gregkh/

Introduced by commit e43eec8 ("btrfs: use struct qstr instead of name
and namelen pairs") in v6.2-rc1.
Fixed in v6.12-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [66691c6e2f18d2aa4b22ffb624b9bdc97e9979e4]
stable/6.1: [12cf028381aa19bc38465341512c280256e8d82d]
stable/6.6: [e11ce03b58743bf1e096c48fcaa7e6f08eb75dfa]

* Updated CVEs

No updated CVEs this week.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

