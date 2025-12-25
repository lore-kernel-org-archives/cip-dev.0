Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83865E7AD42
	for <webhook@archiver.kernel.org>; Thu, 25 Dec 2025 05:13:28 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.134361.1766639605296258630
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Dec 2025 21:13:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=sdU/G24b;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.174, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78fcb465733so38422477b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 24 Dec 2025 21:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1766639604; x=1767244404; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TbaFe2rzVeN5JEIr42zMElcKtipGS3TQ3qp/6CBpL4I=;
        b=sdU/G24b1uEu++8IOwk3BzS11Nubnze4UKvmCd30U70f5ntwEF0K2wHmcSsGsavKQB
         cauLbWzk+xFQE+QmO7XhlOrN84x1TLiUJNXMbCQIg8My95iHOYOcShznbqph+pzr+7Vi
         8x3uTBUoXJCxrQo+QkR1loorER0celiV1cFgrNhIrJSJ5iVzPvKF+0AFl3CIxxRrhB2u
         BLjN2gIjWtN74Rcb8qwwKhcReZ+i8BRpQ+n4F59xGTQ457eGgsPtOowFaBh8Ap1OvGE7
         5YbbELpjAfoGdzzwApu5wYGy58Auw03UgT1k9eQYCSU1wfPif/WzxIII8AOLxpAyclu9
         zBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766639604; x=1767244404;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbaFe2rzVeN5JEIr42zMElcKtipGS3TQ3qp/6CBpL4I=;
        b=deVypfv19uyn3KnZT3xzKQrljKm/VpmTdS/9wEYI81CIasWhWBYsKs1TGIdF7XaEOf
         JNnEbIB01JI9dERVdOBCwOfAAE7WHcjsEr8k/7WaH9twzdi0RW2Ox7R5Tgoll3v52wPi
         5wjR/nzolklEcud/XopKQGHL/4R4caBdm6Qs+uvaqoKzPZTTSbtlbxESsOHN8F4d4TRK
         BVovP3rg26c562u4dl20x3fM8G+ireLv9zJH07+NEusoY5lu/bRC+Sey+wD2CuLHatdv
         gK0wG1oW20pzc8+i/jCdJUXCe60stFw7pk9bkbNJpfgZNSJpVCf8oU1xvYaT1K09H4NA
         Gyyw==
X-Gm-Message-State: AOJu0YxwxlXjZmhAmAiB1cyNQq/doYSo2zty10/GlbB0/YVLl4/xWu/N
	mdiYgf6cOF7mvZPxm58t1Bnsbl3SUM25SuWzyvhMzA1nnhDBSN1+Ig82IOnfe7dmoWlO8VvOSN0
	4OZeewr56OEYcty/ITwdYhzXKjXTMXTlHMje1rcMYCKwIQGqmq1T+Z3g=
X-Gm-Gg: AY/fxX4TXAB+3CfasngCVjeCnZN3Sq6lmyEO3O4jqEC4h3h9/3Q8NjjAXc+UqSIFWt4
	t7tKB+ZMlGDNS6Z6sSKdzvOgedA7nzLyu99baunCpzoiMERvF9jsqn0G7MaksvsAVNrXj/gtlE6
	n8ovAninoLudvw09UOPZxvoL4dvBA3DHy2KgirAm7UjMOXjIS72SQAqIRU/t9ULPzMBy5w7Ne3d
	XnvMCc8y0RoJ2Uy0EB+vnwV+269XdbWRt1Kgtjrtyx9weKzzNqZrni6MfP405XiSvC5uQ7D
X-Google-Smtp-Source: AGHT+IEladZzFVoSp/1OfOoQ5t4cg7S68gxLUCVHfb90Rq4wUqlko7sWH3RaE1YNSnw2AsdC9RVE0+nCIl5q3XtLCNk=
X-Received: by 2002:a05:690c:490e:b0:78c:2f29:eee7 with SMTP id
 00721157ae682-78fb41c7cd4mr165911057b3.59.1766639601737; Wed, 24 Dec 2025
 21:13:21 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Dec 2025 14:12:45 +0900
X-Gm-Features: AQt7F2rure3FwUYp3EbXxhLfaY7G5NKYa5Efy7MCeipry8vSoKbsEKzyVqxxtFA
Message-ID: <CAODzB9qsyVLwHfQqTyWJu1jTJqx9t9g_oi63aLj3ovsrFGZ2_A@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Dec 2025 05:13:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21219

Hi!

It's this week's CVE report.

This week reported 349 new CVEs and 1 updated CVEs.

* New CVEs
CVE-2025-68323: usb: typec: ucsi: fix use-after-free caused by uec->work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68323

Introduced by commit 00327d7 ("usb: typec: ucsi: add Huawei Matebook E
Go ucsi driver") in v6.16-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b7a0f47aaf2439d517ba0a6b29c66a535302154]

CVE-2025-68324: scsi: imm: Fix use-after-free bug caused by unfinished
delayed work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68324

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab58153ec64fa3fc9aea09ca09dc9322e0b54a7c]
stable/6.12: [31ab2aad7a7b7501e904a09bf361e44671f66092]

CVE-2025-68325: net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68325

Introduced by commit 15de71d ("net/sched: Make cake_enqueue return
NET_XMIT_CN when past buffer_limit") in v6.17-rc3.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [9fefc78f7f02d71810776fdeb119a05a946a27cc]
stable/6.12: [0b6216f9b3d1c33c76f74511026e5de5385ee520]

CVE-2025-68326: drm/xe/guc: Fix stack_depot usage

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68326

Introduced by commit 16b7e65 ("drm/xe/guc: Track FAST_REQ H2Gs to
report where errors came from") in v6.17-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e234632e39bd21dd28ffc9ba3ae8eec4deb949c]

CVE-2025-68327: usb: renesas_usbhs: Fix synchronous external abort on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68327

Introduced by commit f1407d5 ("usb: renesas_usbhs: Add Renesas USBHS
common code") in v3.0-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb9ac779830b2235847b72cb15cf07c7e3333c5e]
stable/5.10: [fd1a7bf3a8cac13f6d2d52d8c7570ba41621db9a]
stable/5.15: [cd5e86e34c66a831b5cb9b720ad411a006962cc8]
stable/6.1: [230b1bc1310edcd5c1b71dcd6b77ccba43139cb5]
stable/6.12: [26838f147aeaa8f820ff799d72815fba5e209bd9]
stable/6.6: [9d86bc8b188a77c8d6f7252280ec2bd24ad6fbc1]

CVE-2025-68328: firmware: stratix10-svc: fix bug in saving controller data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68328

Introduced by commit b5dc75c ("firmware: stratix10-svc: extend svc to
support new RSU features") in v5.4-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0fcf70c680e4d1669fcb3a8632f41400b9a73c2]
stable/5.10: [9d0a330abd9e49bcebf6307aac185081bde49a43]
stable/5.15: [354fb03002da0970d337f0d3edbeb46cc4fa6f41]
stable/6.1: [b359df793f609b1efce31dadfe6883ec73852619]
stable/6.12: [60ab1851614e6007344042b66da6e31d1cc26cb3]
stable/6.6: [71796c91ee8e33faf4434a9e210b5063c28ea907]

CVE-2025-68329: tracing: Fix WARN_ON in tracing_buffers_mmap_close for
split VMAs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68329

Introduced by commit cf9f0f7 ("tracing: Allow user-space mapping of
the ring-buffer") in v6.10-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b042fdf18e89a347177a49e795d8e5184778b5b6]
stable/6.12: [922fdd0b755a84f9933b3ca195f60092b6bb88ee]

CVE-2025-68330: iio: accel: bmc150: Fix irq assumption regression

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68330

Introduced commit is not determined.Fixed in v6.18.


Fixed status
mainline: [3aa385a9c75c09b59dcab2ff76423439d23673ab]
stable/5.15: [aad9d048a3211c48ec02efa405bf462856feb862]
stable/6.1: [c891f504bb66604c822e7985e093cf39b97fdeb0]
stable/6.12: [65ad4ed983fd9ee0259d86391d6a53f78203918c]
stable/6.6: [cdd4a9e98004bd7c7488311951fa6dbae38b2b80]

CVE-2025-68331: usb: uas: fix urb unmapping issue when the uas device
is remove during ongoing data transfer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68331

Introduced by commit eb2a86a ("USB: UAS: fix disconnect by unplugging
a hub") in v5.10-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26d56a9fcb2014b99e654127960aa0a48a391e3c]
stable/5.10: [6289fc489e94c9beb6be2b502ccc263663733d72]
stable/5.15: [66ac05e7b0d6bbd1bee9fcf729e20fd4cce86d17]
stable/6.1: [75f8e2643085db4f7e136fc6b368eb114dd80a64]
stable/6.12: [2b90a8131c83f6f2be69397d2b7d14d217d95d2f]
stable/6.6: [e3a55221f4de080cb7a91ba10f01c4f708603f8d]

CVE-2025-68332: comedi: c6xdigio: Fix invalid PNP driver unregistration

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68332

Introduced by commit 2c89e15 ("Staging: comedi: add c6xdigio driver")
in v2.6.30-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72262330f7b3ad2130e800cecf02adcce3c32c77]
stable/6.12: [9fd8c8ad35c8d2390ce5ca2eb523c044bebdc072]

CVE-2025-68333: sched_ext: Fix possible deadlock in the deferred_irq_workfn()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68333

Introduced commit is not determined.Fixed in v6.18-rc7.


Fixed status
mainline: [a257e974210320ede524f340ffe16bf4bf0dda1e]

CVE-2025-68334: platform/x86/amd/pmc: Add support for Van Gogh SoC

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68334

Introduced commit is not determined.Fixed in v6.18-rc7.


Fixed status
mainline: [db4a3f0fbedb0398f77b9047e8b8bb2b49f355bb]

CVE-2025-68335: comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68335

Introduced by commit 00aba6e ("staging: comedi: pcl818: remove
'neverending_ai' from private data") in v3.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a51f025b5038abd3d22eed2ede4cd46793d89565]
stable/6.12: [5caa40e7c6a43e08e3574f990865127705c22861]

CVE-2025-68336: locking/spinlock/debug: Fix data-race in do_raw_write_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68336

Introduced by commit 1a365e8 ("locking/spinlock/debug: Fix various
data races") in v5.5-rc3.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [c14ecb555c3ee80eeb030a4e46d00e679537f03a]
stable/6.12: [b163a5e8c703201c905d6ec7920ed79d167e8442]

CVE-2025-68337: jbd2: avoid bug_on in jbd2_journal_get_create_access()
when file system corrupted

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68337

Introduced by commit 470decc ("[PATCH] jbd2: initial copy of files
from jbd") in v2.6.20.16.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [986835bf4d11032bba4ab8414d18fce038c61bb4]
stable/6.12: [a2a7f854d154a3e9232fec80782dad951655f52f]

CVE-2025-68338: net: dsa: microchip: Don't free uninitialized ksz_irq

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68338

Introduced by commit cc13ab1 ("net: dsa: microchip: ptp: enable
interrupt for timestamping") in v6.3-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25b62cc5b22c45face094ae3e8717258e46d1d19]
stable/6.12: [9428654c827fa8d38b898135d26d39ee2d544246]

CVE-2025-68339: atm/fore200e: Fix possible data race in fore200e_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68339

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82fca3d8a4a34667f01ec2351a607135249c9cff]
stable/5.10: [1b60f42a639999c37da7f1fbfa1ad29cf4cbdd2d]
stable/5.15: [bd1415efbab507b9b995918105eef953013449dd]
stable/6.1: [ed34c70d88e2b8b9bc6c3ede88751186d6c6d5d1]
stable/6.12: [667ac868823224374f819500adc5baa2889c7bc5]
stable/6.6: [9917ba597cf95f307778e495f71ff25a5064d167]

CVE-2025-68340: team: Move team device type change at the end of team_port_add

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68340

Introduced by commit 1d76efe ("team: add support for non-ethernet
devices") in v3.7-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ae9cfc454ea5ead5f3ddbdfe2e70270d8e2c8ef]
stable/6.12: [4040b5e8963982a00aa821300cb746efc9f2947e]

CVE-2025-68341: veth: reduce XDP no_direct return section to fix race

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68341

Introduced by commit 401cb7d ("net: Reference bpf_redirect_info via
task_struct on PREEMPT_RT.") in v6.11-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a14602fcae17a3f1cb8a8521bedf31728f9e7e39]
stable/6.12: [c1ceabcb347d1b0f7e70a7384ec7eff3847b7628]

CVE-2025-68342: can: gs_usb: gs_usb_receive_bulk_callback(): check
actual_length before accessing data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68342

Introduced by commit d08e973 ("can: gs_usb: Added support for the
GS_USB CAN devices") in v3.16-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [395d988f93861101ec89d0dd9e3b876ae9392a5b]
stable/6.12: [ad55004a3cb5b41ef78aa6c09e7bc5a489ba652b]
stable/6.6: [4ffac725154cf6a253f5e6aa0c8946232b6a0af5]

CVE-2025-68343: can: gs_usb: gs_usb_receive_bulk_callback(): check
actual_length before accessing header

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68343

Introduced by commit d08e973 ("can: gs_usb: Added support for the
GS_USB CAN devices") in v3.16-rc1.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fe9f3279f7d2518439a7962c5870c6e9ecbadcf]
stable/6.1: [18cbce43363c9f84b90a92d57df341155eee0697]
stable/6.12: [616eee3e895b8ca0028163fcb1dce5e3e9dea322]
stable/6.6: [3433680b759646efcacc64fe36aa2e51ae34b8f0]

CVE-2022-50697: mrp: introduce active flags to prevent UAF when applicant uninit

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50697

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [78d48bc41f7726113c9f114268d3ab11212814da]
cip/4.4-st: [76a3e2728c06961e1462b42d3dbaf820216ba67d]
mainline: [ab0377803dafc58f1e22296708c1c28e309414d6]
stable/5.10: [755eb0879224ffc2a43de724554aeaf0e51e5a64]
stable/5.15: [5d5a481a7fd0234f617535dc464ea010804a1129]
stable/6.1: [563e45fd5046045cc194af3ba17f5423e1c98170]

CVE-2022-50698: ASoC: da7219: Fix an error handling path in
da7219_register_dai_clks()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50698

Introduced by commit 78013a1 ("ASoC: da7219: Fix clock handling around
codec level probe") in v5.10-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abb4e4349afe7eecdb0499582f1c777031e3a7c8]
stable/5.10: [4993c1511d66326f1037bc5156b024a6a96d23ef]
stable/5.15: [f5f1f5ee5048cfa7bd07f496b33bd2cfc198a176]

CVE-2022-50699: selinux: enable use of both GFP_KERNEL and GFP_ATOMIC
in convert_context()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50699

Introduced by commit ee1a84f ("selinux: overhaul sidtab to fix bug and
improve performance") in v5.0-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abe3c631447dcd1ba7af972fe6f054bee6f136fa]
stable/5.10: [2723875e9d677401d775a03a72abab7e9538c20c]
stable/5.15: [3006766d247bc93a25b34e92fff2f75bda597e2e]

CVE-2022-50700: wifi: ath10k: Delay the unmapping of the buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50700

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [acd4324e5f1f11351630234297f95076f0ac9a2f]
stable/6.1: [79a124b588aadb5a22695542778de14366ff3219]

CVE-2022-50701: wifi: mt76: mt7921s: fix slab-out-of-bounds access in sdio host

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50701

Introduced by commit 764dee4 ("mt76: sdio: move common code in
mt76_sdio module") in v5.16-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aec4cf2ea0797e28f18f8dbe01943a56d987fe56]
stable/6.1: [8b5174a7f25d03df0ffa171ff86de383a89e8e89]

CVE-2022-50702: vdpa_sim: fix possible memory leak in
vdpasim_net_init() and vdpasim_blk_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50702

Introduced by commit 899c4d1 ("vdpa_sim_blk: add support for vdpa
management tool") in v5.13-rc1.
Introduced by commit a3c06ae ("vdpa_sim_net: Add support for user
supported devices") in v5.12-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aeca7ff254843d49a8739f07f7dab1341450111d]
stable/5.15: [586e6fd7d581f987f7d0d2592edf0b26397e783e]
stable/6.1: [337c24d817e28dd454ca22f1063dfad20822426e]

CVE-2022-50703: soc: qcom: smsm: Fix refcount leak bugs in qcom_smsm_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50703

Introduced by commit c97c409 ("soc: qcom: smsm: Add driver for
Qualcomm SMSM") in v4.5-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [42df28994eba7b56c762f7bbe7efd5611a1cd15b]
mainline: [af8f6f39b8afd772fda4f8e61823ef8c021bf382]
stable/5.10: [39781c98ad46b4e85053345dff797240c1ed7935]
stable/5.15: [96e0028debdd07a6d582f0dfadf9a3ec2b5fffff]

CVE-2022-50704: USB: gadget: Fix use-after-free during usb config switch

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50704

Introduced by commit 0a55187 ("USB: gadget core: Issue ->disconnect()
callback from usb_gadget_disconnect()") in v4.20-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afdc12887f2b2ecf20d065a7d81ad29824155083]
stable/6.1: [99a58ac42d9b6911834b0224b6782aea0c311346]

CVE-2022-50705: io_uring/rw: defer fsnotify calls to task context

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50705

Introduced by commit f63cf51 ("io_uring: ensure that fsnotify is
always called") in v5.18-rc1.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [b000145e9907809406d8164c3b2b8861d95aecd1]
stable/5.10: [ea2e6286e3e89a115ae554e20ba9aec2b2e1ddff]
stable/5.15: [89a410dbd0f159ddd308f19d6eb682fc753e4771]

CVE-2022-50706: net/ieee802154: don't warn zero-sized raw_sendmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50706

Introduced by commit fd18942 ("bpf: Don't redirect packets with
invalid pkt_len") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
cip/4.19-st: [63a35f421ea7a7d71f008bbb2b93bdc3c1e1530f]
cip/4.4-st: [596bd11f0cd1ddca69cdc115f27615dd933b14a9]
mainline: [b12e924a2f5b960373459c8f8a514f887adf5cac]
stable/5.10: [791489a5c56396ddfed75fc525066d4738dace46]
stable/5.15: [34f31a2b667914ab701ca725554a0b447809d7ef]

CVE-2022-50707: virtio-crypto: fix memory leak in
virtio_crypto_alg_skcipher_close_session()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50707

Introduced by commit 0756ad1 ("virtio-crypto: use private buffer for
control request") in v5.19-rc1.
Fixed in v6.2-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b1d65f717cd6305a396a8738e022c6f7c65cfbe8]
stable/5.10: [79026a2d0a1b080257773d22a493f9bcab8c65be]
stable/5.15: [409c30ff6cac26f78408e2c9a3fc37f60fb1ecaa]
stable/6.1: [0871df190fe6723464efe0f493d476411616f553]

CVE-2022-50708: HSI: ssi_protocol: fix potential resource leak in ssip_pn_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50708

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by dc7bf5d ("HSI: Introduce driver for SSI
Protocol") in v3.16-rc1.

Fixed status
mainline: [b28dbcb379e6a7f80262c2732a57681b1ee548ca]

CVE-2022-50709: wifi: ath9k: avoid uninit memory read in ath9k_htc_rx_msg()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50709

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [84242f15f911f34aec9b22f99d1e9bff19723dbe]
cip/4.4-st: [c64d1b370762da0ed8a13440f9619c415777cfca]
mainline: [b383e8abed41cc6ff1a3b34de75df9397fa4878c]
stable/5.10: [9661724f6206bd606ecf13acada676a9975d230b]
stable/5.15: [b1b4144508adfc585e43856b31baaf9008a3beb4]

CVE-2022-50710: ice: set tx_tstamps when creating new Tx rings via ethtool

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50710

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by fcea6f3 ("ice: Add stats and ethtool
support") in v4.17-rc1.

Fixed status
mainline: [b3b173745c8cab1e24d6821488b60abed3acb24d]
stable/5.15: [624f03a027f2b18647cc4f1a7a81920a1e4e0201]

CVE-2022-50711: net: ethernet: mtk_eth_soc: fix possible memory leak
in mtk_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50711

Introduced by commit 804775d ("net: ethernet: mtk_eth_soc: add support
for Wireless Ethernet Dispatch (WED)") in v5.19-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3d0d98179d62f9d55635a600679c4fa362baf8d]

CVE-2022-50712: devlink: hold region lock when flushing snapshots

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50712

Introduced by commit 2dec18a ("net: devlink: remove region snapshots
list dependency on devlink->lock") in v6.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4cafb3d2c740f8d1b1234b43ac4a60e5291c960]
stable/6.1: [6298cab4d80bfdb6fe01fe31fd9f0ba26317fdae]

CVE-2022-50713: clk: visconti: Fix memory leak in visconti_register_pll()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50713

Introduced by commit b4cbe60 ("clk: visconti: Add support common clock
driver and reset driver") in v5.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b55226f8553d255f5002c751c7c6ba9291f34bf2]
stable/6.1: [f0f1982ddfb418bf7bf05dadebae5c6869a41d41]

CVE-2022-50714: wifi: mt76: mt7921e: fix rmmod crash in driver reload test

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50714

Introduced by commit 1c71e03 ("mt76: mt7921: move mt7921_init_hw in a
dedicated work") in v5.18-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5a62d612b7baf6e09884e4de94decb6391d6a9d]

CVE-2022-50715: md/raid1: stop mdx_raid1 thread when raid1 array run failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50715

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [0c7c7468c3ae222e297b7dc74d6ccb69c4d0183c]
cip/4.4-st: [88aa5bbec92da53337353ec721a17228bc34fad5]
mainline: [b611ad14006e5be2170d9e8e611bf49dff288911]
stable/5.10: [10d713532ffc67b13df61ed9c138a8ce0a186236]
stable/5.15: [a3cc41e05e8af340a2a759b168c29fffdb9194eb]
stable/6.1: [d26364596db8f8b55277b2afb3952e05a4057a21]

CVE-2022-50716: wifi: ar5523: Fix use-after-free on ar5523_cmd() timed out

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50716

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [6447beefd21326a3f4719ec2ea511df797f6c820]
cip/4.4-st: [f549b1fb7cc4c3a64cdd76dfd80078ca01eb1ece]
mainline: [b6702a942a069c2a975478d719e98d83cdae1797]
stable/5.10: [8af52492717e3538eba3f81d012b1476af8a89a6]
stable/5.15: [3eca9697c2f3905dea3ad2fc536ebaa1fbd735bd]
stable/6.1: [9aef34e1ae35a87e5f6a22278c17823b7ce64c88]

CVE-2022-50717: nvmet-tcp: add bounds check on Transfer Tag

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50717

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by 872d26a ("nvmet-tcp: add NVMe over TCP
target driver") in v5.0-rc1.

Fixed status
mainline: [b6a545ffa2c192b1e6da4a7924edac5ba9f4ea2b]
stable/5.10: [d5bb45f47b37d10f010355686b28c9ebacb361d4]
stable/5.15: [ec8adf767e1cfa7031f853b8c71ba1963f07df15]

CVE-2022-50718: drm/amdgpu: fix pci device refcount leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50718

Introduced by commit 3f12acc ("drm/amdgpu: put the audio codec into
suspend state before gpu reset V3") in v5.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b85e285e3d6352b02947fc1b72303673dfacb0aa]
stable/5.10: [3725a8f26bdbc38dfdf545836117f1e069277c91]
stable/5.15: [02105f0b3021ee5853b2fa50853c42f35fc01cfd]
stable/6.1: [d7352b410471cbebf6350b2990bae82bb0d59a76]

CVE-2022-50719: ALSA: line6: fix stack overflow in line6_midi_transmit

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50719

Introduced commit is not determined.Fixed in v6.2-rc2.


Fixed status
cip/4.19-st: [0c76087449ee4ed45a88b10017d02c6694caedb1]
cip/4.4-st: [59148c1ae4fd6e485984cbc380133023049d6a8b]
mainline: [b8800d324abb50160560c636bfafe2c81001b66c]
stable/5.10: [66f359ad66d49f75d39ac729f9114dabf90b81bb]
stable/5.15: [0c9118e381ff538874e00fd4e66a768273c150fb]
stable/6.1: [389d34c2a8b52acc351fd932ed4bea41fee5a39b]

CVE-2022-50720: x86/apic: Don't disable x2APIC if locked

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50720

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [b8d1d163604bd1e600b062fb00de5dc42baa355f]

CVE-2022-50721: dmaengine: qcom-adm: fix wrong calling convention for
prep_slave_sg

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50721

Introduced by commit 03de6b2 ("dmaengine: qcom-adm: stop abusing
slave_id config") in v5.17-rc1.
Introduced by commit 5c9f8c2 ("dmaengine: qcom: Add ADM driver") in v5.11-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9d2140c3badf4107973ad77c5a0ec3075705c85]

CVE-2022-50722: media: ipu3-imgu: Fix NULL pointer dereference in
active selection access

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50722

Introduced by commit 0d346d2 ("media: v4l2-subdev: add subdev-wide
state struct") in v5.14-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9eb3ab6f30bf32f7326909f17949ccb11bab514]
stable/5.15: [5265cc1202a31f7097691c3483a0d60d624424a5]

CVE-2022-50723: bnxt_en: fix memory leak in bnxt_nvm_test()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50723

Introduced by commit 5b6ff12 ("bnxt_en: implement callbacks for
devlink selftests") in v6.0-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba077d683d45190afc993c1ce45bcdbfda741a40]

CVE-2022-50724: regulator: core: fix resource leak in regulator_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50724

Introduced by commit aea6cb9 ("regulator: resolve supply after
creating regulator") in v5.10-rc1.
Introduced by commit 8a866d5 ("regulator: core: Resolve supply name
earlier to prevent double-init") in v6.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba62319a42c50e6254e98b3f316464fac8e77968]
stable/5.10: [6a03c31d08f95dca9633a552de167b9e625833a8]
stable/5.15: [c4c64d8abd656b9807b63178750fa91454602b86]
stable/6.1: [f86b2f216636790d5922458578825e4628fb570f]

CVE-2022-50725: media: vidtv: Fix use-after-free in vidtv_bridge_dvb_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50725

Introduced by commit f90cf60 ("media: vidtv: add a bridge driver") in v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba8d9405935097e296bcf7a942c3a01df0edb865]
stable/5.10: [0369af6fe33d4053899b121b32e91f870b2cf0ae]
stable/5.15: [c290aa527fd832d278c6388a3ba53a9890fbd74a]
stable/6.1: [8a204a0b4a0d105229735222c515759ea2b126c1]

CVE-2022-50726: net/mlx5: Fix possible use-after-free in async command interface

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50726

Introduced by commit e355477 ("net/mlx5: Make mlx5_cmd_exec_cb() a
safe API") in v5.1-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bacd22df95147ed673bec4692ab2d4d585935241]
stable/5.10: [bbcc06933f35651294ea1e963757502312c2171f]
stable/5.15: [ab3de780c176bb91995c6166a576b370d9726e17]

CVE-2022-50727: scsi: efct: Fix possible memleak in efct_device_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50727

Introduced by commit 4df84e8 ("scsi: elx: efct: Driver initialization
routines") in v5.14-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb0cd225dd37df1f4a22e36dad59ff33178ecdfc]
stable/5.15: [038359eeccffaf0de4c1c9c51ee19cc5649619a1]
stable/6.1: [c7e96168a8ca3be96c4959475164bef31115f07e]

CVE-2022-50728: s390/lcs: Fix return type of lcs_start_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50728

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [e684215d8a903752e2b0cc946517fb61e57a880a]
cip/4.4-st: [7b3b163084a2fc96e196f04f8c5ec85b0d8452e4]
mainline: [bb16db8393658e0978c3f0d30ae069e878264fa3]
stable/5.10: [ebc3c77785dc8b5b626309c0032a38fbb139287a]
stable/5.15: [5ad774fb823c24bbeb21a15a67103ea7a6f5b928]
stable/6.1: [cda74cdc280ba35c8993e7517bac5c257ff36f18]

CVE-2022-50729: ksmbd: Fix resource leak in ksmbd_session_rpc_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50729

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc044414fa0326a4e5c3c509c00b1fcaf621b5f4]
stable/5.15: [31c1b5d3000cdff70b98d5af045271e09079bec1]
stable/6.1: [f9ed133381eba883c5e0059063d5b3ca7cac6d41]

CVE-2022-50730: ext4: silence the warning when evicting inode with
dioread_nolock

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50730

Introduced by commit ceff86f ("ext4: Avoid freeing inodes on dirty
list") in v5.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc12ac98ea2e1b70adc6478c8b473a0003b659d3]
stable/5.10: [bdc698ce91f232fd5eb11d2373e9f82f687314b8]
stable/5.15: [0d041b7251c13679a0f6c7926751ce1d8a7237c1]
stable/6.1: [b085fb43feede48ebf80ab7e2dd150c8d9902932]

CVE-2022-50731: crypto: akcipher - default implementation for setting
a private key

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50731

Introduced by commit 78a0324 ("crypto: akcipher - default
implementations for request callbacks") in v5.2-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc155c6c188c2f0c5749993b1405673d25a80389]
stable/5.10: [a1354bdd191d533211b7cb723aa76a66f516f197]
stable/5.15: [779a9930f3e152c82699feb389a0e6d6644e747e]

CVE-2022-50732: staging: rtl8192u: Fix use after free in ieee80211_rx()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50732

Introduced by commit 8fc8598 ("Staging: Added Realtek rtl8192u driver
to staging") in v2.6.33-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a0df8d44b555ae09729d6533fd4532977563c7b9]
cip/4.4-st: [3212ea0556bb49836a92f0ef43e27943a66185eb]
mainline: [bcc5e2dcf09089b337b76fc1a589f6ff95ca19ac]
stable/5.10: [daa8045a991363ccdae5615d170f35aa1135e7a7]
stable/5.15: [b0aaec894a909c88117c8bda6c7c9b26cf7c744b]
stable/6.1: [73df1172bbcc8d45cd28e3b1a9ca2edb2f9f7ce6]

CVE-2022-50733: usb: idmouse: fix an uninit-value in idmouse_open

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50733

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [f589b667567fde4f81d6e6c40f42b9f2224690ea]
cip/4.4-st: [d4b70f3043e85f778cb6114c60388ce55093f660]
mainline: [bce2b0539933e485d22d6f6f076c0fcd6f185c4c]
stable/5.10: [b8bbae3236ab7dccc66c42bc3f7cdbcfc0786e54]
stable/5.15: [20b8c456df584ebb2387dc23d40ebe4ff334417c]

CVE-2022-50734: nvmem: core: Fix memleak in nvmem_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50734

Introduced by commit de0534d ("nvmem: core: fix error handling while
validating keepout regions") in v5.15-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd1244561fa2a4531ded40dbf09c9599084f8b29]
stable/5.15: [9391cc3a787a58aa224a6440d7f244d780ba2896]

CVE-2022-50735: wifi: mt76: do not run mt76u_status_worker if the
device is not running

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50735

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by b40b15e ("mt76: add usb support to mt76
layer") in v4.19-rc1.

Fixed status
mainline: [bd5dac7ced5a7c9faa4dc468ac9560c3256df845]
stable/5.15: [69346de0eb956fb92949b9473de4647d9c34a54f]
stable/6.1: [f5ac749a0b21beee55d87d0b05de36976b22dff9]

CVE-2022-50736: RDMA/siw: Fix immediate work request flush to completion queue

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50736

Introduced by commit 303ae1c ("rdma/siw: application interface") in v5.3-rc1.
Introduced by commit b0fff73 ("rdma/siw: completion queue methods") in v5.3-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdf1da5df9da680589a7f74448dd0a94dd3e1446]
stable/5.10: [75af03fdf35acf15a3977f7115f6b8d10dff4bc7]
stable/5.15: [f8d8fbd3b6d6cc3f25790cca5cffe8ded512fef6]
stable/6.1: [f3d26a8589dfdeff328779b511f71fb90b10005e]

CVE-2022-50737: fs/ntfs3: Validate index root when initialize NTFS security

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50737

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected code was added by 82cae26 ("fs/ntfs3: Add initialization of
super block") in v5.15-rc1.

Fixed status
mainline: [bfcdbae0523bd95eb75a739ffb6221a37109881e]
stable/5.15: [d7ce7bb6881aae186e50f57eea935cff8d504751]
stable/6.1: [d6379ce242960a8e9ecd6ff76f476d9336c21f16]

CVE-2022-50738: vhost-vdpa: fix an iotlb memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50738

Introduced by commit 037d430 ("vhost-vdpa: call vhost_vdpa_cleanup
during the release") in v5.19-rc5.
Introduced by commit 3d56987 ("vhost-vdpa: introduce asid based
IOTLB") in v5.19-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c070c1912a83432530cbb4271d5b9b11fa36b67a]
stable/6.1: [a2907867e2c86067accd2f011d6f23ee5533aa6c]

CVE-2022-50739: fs/ntfs3: Add null pointer check for inode operations

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50739

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected code was added by 82cae26 ("fs/ntfs3: Add initialization of
super block") in v5.15-rc1.

Fixed status
mainline: [c1ca8ef0262b25493631ecbd9cb8c9893e1481a1]
stable/5.15: [f62506f5e45afbb01c84c3f28a2878b320a0b0f7]
stable/6.1: [a7b23037b38b577d9a4372e0c6b7c9fe808070c1]

CVE-2022-50740: wifi: ath9k: hif_usb: fix memory leak of urbs in
ath9k_hif_usb_dealloc_tx_urbs()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50740

Introduced by commit 03fb92a ("ath9k: hif_usb: fix race condition
between usb_get_urb() and usb_kill_anchored_urbs()") in v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [eddbb8f7620f9f8008b090a6e10c460074ca575a]
cip/4.4-st: [7d3b823a504dff5492a2da70f4c6172e0109f22b]
mainline: [c2a94de38c74e86f49124ac14f093d6a5c377a90]
stable/5.10: [c3fb3e9a2c0c1a0fa492d90eb19bcfa92a5f884d]
stable/5.15: [d856f7574bcc1d81de565a857caf32f122cd7ce0]
stable/6.1: [08aa0537ec8cf29ceccae98acc1a534fc12598c1]

CVE-2022-50741: media: imx-jpeg: Disable useless interrupt to avoid kernel panic

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50741

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by 2db16c6 ("media: imx-jpeg: Add V4L2 driver
for i.MX8 JPEG Encoder/Decoder") in v5.13-rc1.

Fixed status
mainline: [c3720e65c9013a7b2a5dbb63e6bf6d74a35dd894]
stable/5.15: [ad31bc146f0e4521805695f4f99d8a3c3b2761f6]
stable/6.1: [35591c2469953d59abdb16cb7beac834052cdb4f]

CVE-2022-50742: misc: ocxl: fix possible refcount leak in afu_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50742

Introduced by commit 0601466 ("ocxl: move event_fd handling to
frontend") in v5.2-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3b69ba5114c860d730870c03ab4ee45276e5e35]
stable/5.10: [7ba19a60c74fb0057d4daef2fa2cbfc9522f3ba1]
stable/5.15: [11bd8bbdf8f6f5c1145bb158793107a57e3a1f07]

CVE-2022-50743: erofs: Fix pcluster memleak when its block address is zero

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50743

Introduced by commit cecf864 ("erofs: support inline data
decompression") in v5.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c42c0ffe81176940bd5dead474216b7198d77675]
stable/6.1: [618e712b99c78d1004b70a1a9ab0a4830d0b2673]

CVE-2022-50744: scsi: lpfc: Fix hard lockup when reading the
rx_monitor from debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50744

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [c44e50f4a0ec00c2298f31f91bc2c3e9bbd81c7e]
stable/5.15: [2cf66428a2545bb33beb9624124a2377468bb478]
stable/6.1: [39761417ea7b654217d6d9085afbf7c87ba3675d]

CVE-2022-50745: staging: media: tegra-video: fix device_node use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50745

Introduced by commit 1ebaeb0 ("media: tegra-video: Add support for
external sensor capture") in v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4d344163c3a7f90712525f931a6c016bbb35e18]
stable/5.10: [5451efb2ca30f3c42b9efb8327ce35b62870dbd3]
stable/5.15: [ce50c612458091d926ccb05d7db11d9f93532db2]
stable/6.1: [0fd003d3c708c80350a815eaf37b8e1114b976cf]

CVE-2022-50746: erofs: validate the extent length for uncompressed pclusters

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50746

Introduced by commit 02827e1 ("staging: erofs: add
erofs_map_blocks_iter") in v4.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c505feba4c0d76084e56ec498ce819f02a7043ae]
stable/6.1: [40c73b2ea9611b5388807be406f30f5e4e1162da]

CVE-2022-50747: hfs: Fix OOB Write in hfs_asc2mac

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50747

Introduced by commit 328b922 ("[PATCH] hfs: NLS support") in v2.6.20.16.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ba8f0ca386dd15acf5a93cbac932392c7818eab4]
cip/4.4-st: [866d3a6e6e23c852550be50eb3cf1b0eaa9965a9]
mainline: [c53ed55cb275344086e32a7080a6b19cb183650b]
stable/5.10: [cff9fefdfbf5744afbb6d70bff2b49ec2065d23d]
stable/5.15: [7af9cb8cbb81308ce4b06cc7164267faccbf75dd]
stable/6.1: [88579c158e026860c61c4192531e8bc42f4bc642]

CVE-2022-50748: ipc: mqueue: fix possible memory leak in init_mqueue_fs()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50748

Introduced by commit dc55e35 ("ipc: Store mqueue sysctls in the ipc
namespace") in v5.19-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c579d60f0d0cd87552f64fdebe68b5d941d20309]

CVE-2022-50749: acct: fix potential integer overflow in encode_comp_t()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50749

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [1750a0983c455a9b3badd848471fc8d58cb61f67]
cip/4.4-st: [1566462bc17af47009f52a89e096084d2b435025]
mainline: [c5f31c655bcc01b6da53b836ac951c1556245305]
stable/5.10: [6edd0cdee5780fd5f43356b72b29a2a6d48ef6da]
stable/5.15: [ebe16676e1dcaa4556ec4d36ca40c82e99e88cfa]
stable/6.1: [0aac6e60c464a5f942f995428e67f8ae1c422250]

CVE-2022-50750: drm/panel/panel-sitronix-st7701: Remove panel on DSI
attach failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50750

Introduced by commit 849b2e3 ("drm/panel: Add Sitronix ST7701 panel
driver") in v5.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c62102165dd79284d42383d2f7ed17301bd8e629]
stable/5.10: [576828e59a0e03bbc763872912b04f3e3a1b3311]
stable/5.15: [13fc167e1645c43c631d7752d98e377f0e4cbb15]
stable/6.1: [465611e812587e72bf235034edce0e51be3d6809]

CVE-2022-50751: configfs: fix possible memory leak in configfs_create_dir()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50751

Introduced by commit 7063fbf ("[PATCH] configfs: User-driven
configuration filesystem") in v2.6.20.16.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c65234b283a65cfbfc94619655e820a5e55199eb]
stable/5.10: [74ac7c9ee2d486c501e7864c903f5098fc477acd]
stable/5.15: [07f82dca112262b169bec0001378126439cab776]
stable/6.1: [c72eb6e6e49a71f7598740786568fafdd013a227]

CVE-2022-50752: md/raid5: Remove unnecessary bio_put() in raid5_read_one_chunk()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50752

Introduced by commit c82aa1b ("md/raid5: move checking badblock before
clone bio in raid5_read_one_chunk") in v5.14-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c66a6f41e09ad386fd2cce22b9cded837bbbc704]
stable/5.15: [7a37c58ee72e1fadd22c4ee990cb74c2ca2280e7]

CVE-2022-50753: f2fs: fix to do sanity check on summary info

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50753

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [c6ad7fd16657ebd34a87a97d9588195aae87597d]
stable/5.10: [4a8e8bf280703e04e0b9d91f101e1fdd9a5bd09e]
stable/5.15: [73687c53919f49dff3852155621dab7a35c52854]

CVE-2022-50754: apparmor: fix a memleak in multi_transaction_new()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50754

Introduced by commit 1dea3b4 ("apparmor: speed up transactional
queries") in v4.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [95e6adc6a7a4761ddf69ad713e55a06a3206309d]
mainline: [c73275cf6834787ca090317f1d20dbfa3b7f05aa]
stable/5.10: [935d86b29093e75b6c547d90b3979c2c2d23f1c4]
stable/5.15: [775a37ffa9f4681c4ad84c8634a7eec8af7098d4]
stable/6.1: [3d27a436e294ac5d7a51bd5348ca63a42a468b35]

CVE-2022-50755: udf: Avoid double brelse() in udf_rename()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50755

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [d6da7ec0f94f5208c848e0e94b70f54a0bd9c587]
cip/4.4-st: [7b544c6a74e177c637477d19f523937cf8ccbe4a]
mainline: [c791730f2554a9ebb8f18df9368dc27d4ebc38c2]
stable/5.10: [40dba68d418237b1ae2beaa06d46a94dd946278e]
stable/5.15: [e7a6a53c871460727be09f4414ccb29fb8697526]
stable/6.1: [090bf49833c51da297ec74f98ad2bf44daea9311]

CVE-2022-50756: nvme-pci: fix mempool alloc size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50756

Introduced by commit 943e942 ("nvme-pci: limit max IO size and
segments to avoid high order allocations") in v4.18-rc2.
Fixed in v6.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c89a529e823d51dd23c7ec0c047c7a454a428541]
stable/5.10: [dfb6d54893d544151e7f480bc44cfe7823f5ad23]
stable/5.15: [9141144b37f30e3e7fa024bcfa0a13011e546ba9]
stable/6.1: [b1814724e0d7162bdf4799f2d565381bc2251c63]

CVE-2022-50757: media: camss: Clean up received buffers on failed
start of streaming

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50757

Introduced by commit 0ac2586 ("media: camss: Add files which handle
the video device nodes") in v4.14-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [04c734c716a97f1493b1edac41316aaed1d2a9d9]
mainline: [c8f3582345e6a69da65ab588f7c4c2d1685b0e80]
stable/5.10: [3d5cab726e3b370fea1b6e67183f0e13c409ce5c]
stable/5.15: [d1c44928bb3ca0ec88e7ad5937a2a26a259aede6]
stable/6.1: [24df4fa3e795fb4b15fd4d3c036596e0978d265a]

CVE-2022-50758: staging: vt6655: fix potential memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50758

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected code was added by 5341ee0 ("staging: vt6655: check for memory
allocation failures") in v4.18-rc1.

Fixed status
cip/4.19-st: [e741e38aa98704fbb959650ecd270b71b2670680]
mainline: [c8ff91535880d41b49699b3829fb6151942de29e]
stable/5.10: [1b3cebeca99e8e0aa4fa57faac8dbf41e967317a]
stable/5.15: [ff8551d411f12b5abc5ca929ab87643afa8a9588]

CVE-2022-50759: media: i2c: ov5648: Free V4L2 fwnode data on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50759

Introduced by commit e43ccb0 ("media: i2c: Add support for the OV5648
image sensor") in v5.12-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c95770e4fc172696dcb1450893cda7d6324d96fc]
stable/6.1: [3a54b72868930f07935accaf95ec4df639324940]

CVE-2022-50760: drm/amdgpu: Fix PCI device refcount leak in
amdgpu_atrm_get_bios()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50760

Introduced by commit d38ceaf ("drm/amdgpu: add core driver (v4)") in v4.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3360125d721c91d697c71201f18f042ff743e936]
cip/4.4-st: [0f17758c18239e768a5aa2263895df492f4efcaf]
mainline: [ca54639c7752edf1304d92ff4d0c049d4efc9ba0]
stable/5.10: [7c1ddf7c664b5bc91f14b1bdeaa45520ef1760e4]
stable/5.15: [8f2d2badf8ca5e7e7c30d88840b695c8af7286f3]
stable/6.1: [a8b54ad7106c0604c4adc4933138b3557739bce0]

CVE-2022-50761: x86/xen: Fix memory leak in xen_init_lock_cpu()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50761

Introduced by commit 2d9e1e2 ("xen: implement Xen-specific spinlocks")
in v2.6.27-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [53ff99c76be611acea37d33133c9136969914865]
cip/4.4-st: [663377dc80183e368740dd5c004f1b43f281bda9]
mainline: [ca84ce153d887b1dc8b118029976cc9faf2a9b40]
stable/5.10: [70e7f308d7a8e915c7fbc0f1d959968eab8000cd]
stable/5.15: [70966d6b0f59f795b08a70adf5e4478348ecbfbb]
stable/6.1: [b44457b83a034efef58ffa5f3131d4615f1a9837]

CVE-2022-50762: fs/ntfs3: Avoid UBSAN error on true_sectors_per_clst()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50762

Introduced by commit a3b7743 (fs/ntfs3: validate BOOT
sectors_per_clusters) in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [caad9dd8792a2622737b7273cb34835fd9536cd2]
stable/5.15: [4b51f27d4448c84957bce190292f75d4896d56b3]
stable/6.1: [95afb464c86c6e9e95ea9e595282fa6f693072e8]

CVE-2022-50763: crypto: marvell/octeontx - prevent integer overflows

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50763

Introduced by commit d9110b0 ("crypto: marvell - add support for
OCTEON TX CPT engine") in v5.7-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [caca37cf6c749ff0303f68418cfe7b757a4e0697]
stable/5.10: [7bfa7d67735381715c98091194e81e7685f9b7db]
stable/5.15: [12acfa1059ad69aa352ddb2bf23ba1b831aff15f]

CVE-2022-50764: ipv6/sit: use DEV_STATS_INC() to avoid data-races

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50764

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [cb34b7cf17ecf33499c9298943f85af247abc1e9]
stable/5.15: [222cc04356984f3f98acfa756a69d4bed7c501ac]
stable/6.1: [207501a986831174df09a36a8cb62a28f92f0dc8]

CVE-2022-50765: RISC-V: kexec: Fix memory leak of elf header buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50765

Introduced by commit 8acea45 ("RISC-V: Support for kexec_file on
panic") in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbc32023ddbdf4baa3d9dc513a2184a84080a5a2]
stable/6.1: [cdea2da6787583ecca43594132533a2ac8d7cd21]

CVE-2022-50766: btrfs: set generation before calling
btrfs_clean_tree_block in btrfs_init_new_buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50766

Introduced by commit bc877d2 ("btrfs: Deduplicate extent_buffer init
code") in v4.19-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbddcc4fa3443fe8cfb2ff8e210deb1f6a0eea38]
stable/5.15: [0a408c6212c16b9a2a1141d3c531247582ef8101]

CVE-2022-50767: fbdev: smscufx: Fix several use-after-free bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50767

Introduced commit is not determined.Fixed in v6.1-rc3.


Fixed status
cip/4.19-st: [70faf9d9b6cc74418716bbf76fe75bd2da10ad4a]
cip/4.4-st: [bd2619b9d4276935f3c21a2f8543c26d1416678a]
mainline: [cc67482c9e5f2c80d62f623bcc347c29f9f648e1]
stable/5.10: [d9ddfeb01fb95ffbbc7031d46a5ee2a5e45cbb86]
stable/5.15: [cc6a7249842fceda7574ceb63275a2d5e99d2862]

CVE-2022-50768: scsi: smartpqi: Correct device removal for
multi-actuator devices

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50768

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by 6c22376 ("smartpqi: initial commit of
Microsemi smartpqi driver") in v4.9-rc1.

Fixed status
mainline: [cc9befcbbb5ebce77726f938508700d913530035]
stable/6.1: [d1c8b86b4ab7e8588a8cfadbdd6f20adbb15c938]

CVE-2022-50769: mmc: mxcmmc: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50769

Introduced by commit d96be87 ("mmc: Add a MX2/MX3 specific SDHC
driver") in v2.6.29-rc4.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b8bdb3fd13d5cd1e86d22fd3f803a742fd88af89]
cip/4.4-st: [3bdb862b84063515cdf7267477fb9715fd225140]
mainline: [cde600af7b413c9fe03e85c58c4279df90e91d13]
stable/5.10: [3904eb97bb78fdca3e16d30a38ce5697b9686110]
stable/5.15: [2d496050ded83b13b16f05e1fc0329b0210d2493]
stable/6.1: [d2ead18bc7cc166220cab5a744a05c5b69431a12]

CVE-2022-50770: ocfs2: fix memory leak in ocfs2_mount_volume()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50770

Introduced by commit 9140db0 ("ocfs2: recover orphans in offline slots
during recovery and mount") in v2.6.30-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce2fcf1516d674a174d9b34d1e1024d64de9fba3]
stable/5.10: [2b7e59ed2e77136e9360274f8f0fc208a003e95c]
stable/5.15: [8059e200259e9c483d715fc2df6340c227c3e196]
stable/6.1: [50ab0ca3aff4da26037113d69f5a756d8c1a92cd]

CVE-2022-50771: rcu: Fix __this_cpu_read() lockdep warning in
rcu_force_quiescent_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50771

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [ceb1c8c9b8aa9199da46a0f29d2d5f08d9b44c15]
stable/5.10: [5a52380b8193cf8be6c4a6b94b86ef64ed80c0dc]
stable/5.15: [98a5b1265a36e9d843a51ddd6c9fa02da50d2c57]
stable/6.1: [80a3e7ab477b3655615fc1627c88c248d4ad28d9]

CVE-2022-50772: netdevsim: fix memory leak in nsim_bus_dev_new()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50772

Introduced by commit 40e4fe4 ("netdevsim: move device registration and
related code to bus.c") in v5.2-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf2010aa1c739bab067cbc90b690d28eaa0b47da]

CVE-2022-50773: ALSA: mts64: fix possible null-ptr-defer in snd_mts64_interrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50773

Introduced by commit 68ab801 ("[ALSA] Add snd-mts64 driver for ESI
Miditerminal 4140") in v2.6.20.16.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7e91667db38abb056da5a496d40fbd044c66bed2]
cip/4.4-st: [dfa1356b4e980475564ad1f901e124968ae7d4f4]
mainline: [cf2ea3c86ad90d63d1c572b43e1ca9276b0357ad]
stable/5.10: [0649129359219ce6ff380ec401f87308485c6ae3]
stable/5.15: [cba633b24a98d957e8190ef8bc4d4cdb4f6e9313]
stable/6.1: [250eed7b9994d79f9c409f954dbd08e88f5afd83]

CVE-2022-50774: crypto: qat - fix DMA transfer direction

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50774

Introduced by commit d370cec ("crypto: qat - Intel(R) QAT crypto
interface") in v3.17-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf5bb835b7c8a5fee7f26455099cca7feb57f5e9]
stable/5.10: [426d5bc089e7731e36b514d1beca19e777a2d653]
stable/5.15: [1f1ab76e251521bd2fa5244473efcf663792745d]

CVE-2022-50775: RDMA/hns: Fix refcount leak in hns_roce_mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50775

Introduced by commit 0045e0d ("RDMA/hns: Support direct wqe of
userspace") in v5.17-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf6a05c8494a8ae7fec8e5f1229b45ca5b4bcd30]
stable/6.1: [fa87cf2e756efe809ee8683d4f282f4de962dab6]

CVE-2022-50776: clk: st: Fix memory leak in st_of_quadfs_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50776

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [be03875007621fcee96e6f9fd7b9e59c8dfcf6fa]
cip/4.4-st: [ea0039ae395341c05c54a21602d6f309484da8f9]
mainline: [cfd3ffb36f0d566846163118651d868e607300ba]
stable/5.10: [efd025f32fce27a8ada9bcb4731e8a84476e5b3d]
stable/5.15: [adf6a00859d014cecf046dc91f75c0e65a544360]
stable/6.1: [f4731395d6db850127634197863aede188d8e9de]

CVE-2022-50777: net: phy: xgmiitorgmii: Fix refcount leak in xgmiitorgmii_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50777

Introduced by commit ab4e6ee ("net: phy: xgmiitorgmii: Check
phy_driver ready before accessing") in v4.19-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [78b0b1ff525d9be4babf5a148a4de0d50042d95d]
mainline: [d039535850ee47079d59527e96be18d8e0daa84b]
stable/5.10: [106d0d33c9d1ec4ddeeffc1fdc717ff09953d4ed]
stable/5.15: [4d112f001612c79927c1ecf29522b34c4fa292e0]
stable/6.1: [ee84d37a5f08ed1121cdd16f8f3ed87552087a21]

CVE-2022-50778: fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50778

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [d07c0acb4f41cc42a0d97530946965b3e4fa68c1]

CVE-2022-50779: orangefs: Fix kmemleak in orangefs_prepare_debugfs_help_string()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50779

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file is added by 274dcf5 ("Orangefs: kernel client part 3")
in v4.6-rc1.

Fixed status
cip/4.19-st: [ba9d3b9cec20957fd86bb1bf525b4ea8b64b2dea]
mainline: [d23417a5bf3a3afc55de5442eb46e1e60458b0a1]
stable/5.10: [b8affa0c6405ee968dcb6030bee2cf719a464752]
stable/5.15: [39529b79b023713d4f2d3479dc0ca43ba99df726]
stable/6.1: [19be31668552a198e887762e25bdcc560800ecb4]

CVE-2022-50780: net: fix UAF issue in nfqnl_nf_hook_drop() when
ops_init() failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50780

Introduced by commit f875bae ("net: Automatically allocate per
namespace data.") in v2.6.33-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5a2ea549be94924364f6911227d99be86e8cf34a]
mainline: [d266935ac43d57586e311a087510fe6a084af742]
stable/5.10: [c3edc6e808209aa705185f732e682a370981ced1]
stable/5.15: [a1e18acb0246bfb001b08b8b1b830b5ec92a0f13]

CVE-2022-50781: amdgpu/pm: prevent array underflow in
vega20_odn_edit_dpm_table()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50781

Introduced by commit d5bf265 ("drm/amd/powerplay: added vega20
overdrive support V3") in v4.20-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d27252b5706e51188aed7647126e44dcf9e940c1]
stable/5.10: [85273b4a7076ed5328c8ace02234e4e7e10972d5]
stable/5.15: [f289a38df0da4cfe4b50d04b1b9c3bc646fecd57]
stable/6.1: [8084bd0a64e278314b733993f388d83a86aa1183]

CVE-2022-50782: ext4: fix bug_on in __es_tree_search caused by bad quota inode

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50782

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [fb1d3b4107b4837b4a0dbbf01954269bd6acfdc3]
mainline: [d323877484765aaacbb2769b06e355c2041ed115]
stable/5.10: [98004f926d27eaccdd2d336b7916a42e07392da1]
stable/5.15: [0dcbf4dc3d54aab5990952cfd832042fb300dbe3]
stable/6.1: [1daff79463d7d76096c84c57cddc30c5d4be2226]

CVE-2022-50783: mptcp: use proper req destructor for IPv6

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50783

Introduced by commit 79c0949 ("mptcp: Add key generation and token
tree") in v5.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3295fee3c756ece33ac0d935e172e68c0a4161b]
stable/5.10: [6eb02c596ec02e5897ae377e065cb7df55337a96]
stable/5.15: [bd5dc96fea4edd16d2e22f41b4dd50a4cfbeb919]
stable/6.1: [1922ea6b0ae2ea0c9a09be0eafafe1cd1069d259]

CVE-2023-53867: ceph: fix potential use-after-free bug when trimming caps

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53867

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [aaf67de78807c59c35bafb5003d4fb457c764800]
stable/6.1: [2b2515b8095cf2149bef44383a99d5b5677f1831]

CVE-2023-53986: mips: bmips: BCM6358: disable RAC flush for TP1

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53986

Introduced by commit d59098a ("MIPS: bmips: use generic dma
noncoherent ops") in v4.19-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab327f8acdf8d06601fbf058859a539a9422afff]
stable/5.10: [47a449ec09b4479b89dcc6b27ec3829fc82ffafb]
stable/5.15: [65b723644294f1d79770704162c0e8d1f700b6f1]
stable/6.1: [2cdbcff99f15db86a10672fb220379a1ae46ccae]

CVE-2023-53987: ping: Fix potentail NULL deref for /proc/net/icmp.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53987

Introduced by commit dbca159 ("ping: convert to RCU lookups, get rid
of rwlock") in v6.0-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab5fb73ffa01072b4d8031cc05801fa1cb653bee]
stable/6.1: [5a08a32e624908890aa0a2eb442bb6a7669891a8]

CVE-2023-53988: fs/ntfs3: Fix slab-out-of-bounds read in hdr_delete_de()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53988

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab84eee4c7ab929996602eda7832854c35a6dda2]
stable/5.15: [c58ea97aa94f033ee64a8cb6587d84a9849b6216]
stable/6.1: [9163a5b4ed290da4a7d23fa92533e0e81fd0166e]

CVE-2023-53989: arm64: mm: fix VA-range sanity check

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53989

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [ab9b4008092c86dc12497af155a0901cc1156999]
stable/5.10: [32020fc2a8373d3de35ae6d029d5969a42651e7a]
stable/5.15: [621619f626cbe702ddbdc54117f3868b8ebd8129]

CVE-2023-53990: SMB3: Add missing locks to protect deferred close file list

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53990

Introduced by commit ca08d0e ("cifs: Fix memory leak on the deferred
close") in v6.0-rc2.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [ab9ddc87a9055c4bebd6524d5d761d605d52e557]
stable/5.15: [0f87e18203bd30f71eb1a65259e28e291b6cc43a]
stable/6.1: [3aa9d065b0685b4e6052f3f2a2462966fdc44fd2]

CVE-2023-53991: drm/msm/dpu: Disallow unallocated resources to be returned

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53991

Introduced by commit bb00a45 ("drm/msm/dpu: Refactor resource
manager") in v5.7-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abc40122d9a69f56c04efb5a7485795f5ac799d1]
stable/5.10: [8dbd54d679e3ab37be43bc1ed9f463dbf83a2259]
stable/5.15: [bf661c5e3bc48973acb363c76e3db965d9ed26d0]
stable/6.1: [9e1e236acdc42b5c43ec8d7f03a39537e70cc309]

CVE-2023-53992: wifi: cfg80211: ocb: don't leave if not joined

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53992

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [abc76cf552e13cfa88a204b362a86b0e08e95228]
stable/6.1: [d7b0fe3487d203c04ee1bda91a63bd4dd398c350]

CVE-2023-53993: PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53993

Introduced by commit 9d24322 ("PCI/DOE: Add DOE mailbox support
functions") in v6.0-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abf04be0e7071f2bcd39bf97ba407e7d4439785e]
stable/6.1: [2a0e0f4773fe8032fb17e56f897bee32ce3cdc2b]

CVE-2023-53994: ionic: remove WARN_ON to prevent panic_on_warn

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53994

Introduced by commit 77ceb68 ("ionic: Add notifyq support") in v5.4-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abfb2a58a5377ebab717d4362d6180f901b6e5c1]
stable/5.10: [f8cc4fd99a325505e15c3da95d6de266efd3d9b5]
stable/5.15: [1417dd787a5e55b410a00a28231b0dcb19172457]
stable/6.1: [dc470466753ad0dd3a8c48aaefa05a992c119b9c]

CVE-2023-53995: net: ipv4: fix one memleak in __inet_del_ifa()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53995

Introduced by commit 0ff60a4 ("[IPV4]: Fix secondary IP addresses
after promotion") in v2.6.20.16.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac28b1ec6135649b5d78b028e47264cb3ebca5ea]
stable/5.10: [7c8ddcdab1b900bed69cad6beef477fff116289e]
stable/5.15: [2f1e86014d0cc084886c36a2d77bc620e2d42618]
stable/6.1: [980f8445479814509a3cd55a8eabaae1c9030a4c]

CVE-2023-53996: x86/sev: Make enc_dec_hypercall() accept a size
instead of npages

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53996

Introduced by commit 064ce6c ("mm: x86: Invoke hypercall when page
encryption status is changed") in v5.16-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac3f9c9f1b37edaa7d1a9b908bc79d843955a1a2]
stable/6.1: [ba50e7773a99a109a1ea6f753b766a080d3b21cc]

CVE-2023-53997: thermal: of: fix double-free on unregistration

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53997

Introduced by commit 3d439b1 ("thermal/core: Alloc-copy-free the
thermal zone parameters structure") in v6.4-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac4436a5b20e0ef1f608a9ef46c08d5d142f8da6]

CVE-2023-53998: hwrng: virtio - Fix race on data_avail and actual data

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53998

Introduced by commit f7f510e ("virtio: An entropy device, as suggested
by hpa.") in v2.6.26-rc5.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [241ef15776a7c8505008db689175b320d345ecd3]
mainline: [ac52578d6e8d300dd50f790f29a24169b1edd26c]
stable/5.10: [77471e4912d3960dafe141e268c44be8024fe4dc]
stable/5.15: [c76d991b6f01a5d931e7053a73bc9524975a5215]
stable/6.1: [22c30022cde6e2c88612b3a499223cfa912f1bc7]

CVE-2023-53999: net/mlx5e: TC, Fix internal port memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53999

Introduced by commit 8300f22 ("net/mlx5e: Create new flow attr for
multi table actions") in v5.18-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac5da544a3c2047cbfd715acd9cec8380d7fe5c6]

CVE-2023-54000: net: hns3: fix deadlock issue when externel_lb and
reset are executed together

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54000

Introduced by commit 04b6ba1 ("net: hns3: add support for external
loopback test") in v6.1-rc1.
Fixed in v6.5-rc6.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [ac6257a3ae5db5193b1f19c268e4f72d274ddb88]
stable/5.15: [d9f609cb50ebab4aa6341112f406bf9d3928ac81]
stable/6.1: [743f7c1762e098048ede8cdf8c89a118f8d12391]

CVE-2023-54001: staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54001

Introduced by commit 2865d42 ("staging: r8712u: Add the new driver to
the mainline kernel") in v2.6.37-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac83631230f77dda94154ed0ebfd368fc81c70a3]
stable/5.10: [fc511ae405f7ba29fbcb0246061ec15c272386e1]
stable/5.15: [acacdbe0f740ca8c5d5da73d50870903a3ded677]
stable/6.1: [41e05572e871b10dbdc168c76175c97982daf4a4]

CVE-2023-54002: btrfs: fix assertion of exclop condition when starting balance

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54002

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
mainline: [ac868bc9d136cde6e3eb5de77019a63d57a540ff]
stable/6.1: [17eaeee4c5f24946aad0298d51f32981c3161d13]

CVE-2023-54003: RDMA/core: Fix GID entry ref leak when create_ah fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54003

Introduced by commit 1a1f460 ("RDMA: Hold the sgid_attr inside the
struct ib_ah/qp") in v4.19-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aca3b0fa3d04b40c96934d86cc224cccfa7ea8e0]
stable/5.10: [d1b9b3191697a80aca8e247320eba46f24d41d18]
stable/5.15: [e97ff11b396c320d2cc025b09741ba432fcb20a2]
stable/6.1: [370280c65c28a515b841c9f2c08524f06182510c]

CVE-2023-54004: udplite: Fix NULL pointer dereference in
__sk_mem_raise_allocated().

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54004

Introduced by commit 850cbad ("udp: use it's own memory accounting
schema") in v4.10-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cc56de054d828935aa37734b479f82fa34b5f9bd]
mainline: [ad42a35bdfc6d3c0fc4cb4027d7b2757ce665665]
stable/5.10: [5014b64e369bdf997935b132a1ac4d64b6e47ad4]
stable/5.15: [387bd0a3af3bdd2b16f8dbef0c9fcccac63000a4]
stable/6.1: [2a112f04629f7839e7cb509b27b8d3b735afe255]

CVE-2023-54005: binder: fix memory leak in binder_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54005

Introduced by commit f2517eb ("android: binder: Add global lru
shrinker to binder") in v4.14-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ceb0f8cc987fb3d25c06b9662e08a42f99651207]
mainline: [adb9743d6a08778b78d62d16b4230346d3508986]
stable/5.10: [d7e5e2b87f5d27469075b6326b6b358e38cd9dcb]
stable/5.15: [03eebad96233397f951d8e9fafd82a1674a77284]
stable/6.1: [f11a26633eb6d3bb24a10b1bacc4e4a9b0c6389f]

CVE-2023-54006: af_unix: Fix data-race around unix_tot_inflight.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54006

Introduced by commit 9305cfa ("[AF_UNIX]: Make unix_tot_inflight
counter non-atomic") in v2.6.24-rc3.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [20aa8325464d8905450089eed96ca102a074d853]
cip/4.4-st: [54f4ac580fe0a299dd3c738c6e690ca3918fd29c]
mainline: [ade32bd8a738d7497ffe9743c46728db26740f78]
stable/5.10: [cf29b42766ad4af2ae6a449f583796951551b48d]
stable/5.15: [e5edc6e44a882c0458878ab10eaddfe60ac34e57]
stable/6.1: [2d8933ca863e252fb09ad0be483255e3dfeb1f54]

CVE-2023-54007: vmci_host: fix a race condition in vmci_host_poll() causing GPF

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54007

Introduced by commit 8bf5039 ("VMCI: host side driver
implementation.") in v3.9-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2053e93ac15519ed1f1fe6eba79a33a4963be4a3]
mainline: [ae13381da5ff0e8e084c0323c3cc0a945e43e9c7]
stable/5.10: [85b4aa4eb2e3a0da111fd0a1cdbf00f986ac6b6b]
stable/5.15: [770d30b1355c6c8879973dd054fca9168def182c]
stable/6.1: [d22b2a35729cb1de311cb650cd67518a24e13fc9]

CVE-2023-54008: virtio_vdpa: build affinity masks conditionally

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54008

Introduced by commit 3dad568 ("virtio-vdpa: Support interrupt affinity
spreading mechanism") in v6.4-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae15aceaa98ad9499763923f7890e345d9f46b60]

CVE-2023-54009: i2c: cadence: cdns_i2c_master_xfer(): Fix runtime PM
leak on error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54009

Introduced by commit 1a351b1 ("i2c: cadence: Added slave support") in v5.8-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae1664f04f504a998737f5bb563f16b44357bcca]
stable/5.10: [fd7bf900c3215c77f6d779d1532faa22b79f2430]
stable/5.15: [2d65599ad1e4f195bbb80752cd5cbc2f1a018dba]
stable/6.1: [a712b5a95270e62209f5c2201c774f708f75234e]

CVE-2023-54010: ACPICA: ACPICA: check null return of
ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54010

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [35d67ffad6f5d78dbd800d354f5334c7b71a19e0]
cip/4.4-st: [454a4b89e5f56659e5afe0898fb73571f68e17e4]
mainline: [ae5a0eccc85fc960834dd66e3befc2728284b86c]
stable/5.10: [978e0d05547ae707d51a942fc7e85a34e181ee6f]
stable/5.15: [d997c920a5305b37f0b8a40501b5aca10d099ecd]
stable/6.1: [fee6133490091492dc66bcf71479bd53bd17a7d2]

CVE-2023-54011: scsi: mpi3mr: Fix an issue found by KASAN

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54011

Introduced by commit 42fc9fe ("scsi: mpi3mr: Add helper functions to
manage device's port") in v6.1-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae7d45f5283d30274039b95d3e6d53d33c66e991]
stable/6.1: [abfe73c16b295f2213e9bfc0a1df232056032448]

CVE-2023-54012: net: fix stack overflow when LRO is disabled for
virtual interfaces

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54012

Introduced by commit fd867d5 ("net/core: generic support for disabling
netdev features down stack") in v4.4-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae9b15fbe63447bc1d3bba3769f409d17ca6fdf6]
stable/5.10: [4bb955c4d2830a58c08e2a48ab75d75368e3ff36]
stable/5.15: [cf3b5cd7127cc10c5b12400c545f263f0e5e715c]
stable/6.1: [ed66e6327a69fec95034cda2ac5b6a57b8b3b622]

CVE-2023-54013: interconnect: Fix locking for runpm vs reclaim

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54013

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected file was added by 11f1cec ("interconnect: Add generic on-chip
interconnect API") in v5.1-rc1.

Fixed status
mainline: [af42269c3523492d71ebbe11fefae2653e9cdc78]
stable/5.15: [9be2957f014d91088db1eb5dd09d9a03d7184dce]
stable/6.1: [ee42bfc791aa3cd78e29046f26a09d189beb3efb]

CVE-2023-54014: scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54014

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [ccd3bc595bda67db5a347b9050c2df28f292d3fb]
cip/4.4-st: [ea0ee56909e525927dda5316ff1260a38df18ed8]
mainline: [af73f23a27206ffb3c477cac75b5fcf03410556e]
stable/5.10: [921d6844625527a92d1178262a633cc88a8e61bd]
stable/5.15: [1ccd52b790a66b8b5f75c87eab8c3a37f941a2bf]
stable/6.1: [e466930717ef18c112585a39fc6174d8eb441df5]

CVE-2023-54015: net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54015

Introduced by commit fadd59f ("net/mlx5: Introduce inter-device
communication mechanism") in v5.0-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af87194352cad882d787d06fb7efa714acd95427]
stable/5.10: [d4d10a6df1529b3f446cdada5c25e065f4712756]
stable/5.15: [1e755065368000205e6683fa924b2654e99f573b]
stable/6.1: [eaa365c10459052cbe3e44caa4ad760cb93bd435]

CVE-2023-54016: wifi: ath12k: Fix memory leak in rx_desc and tx_desc

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54016

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected file is added by d889913 ("wifi: ath12k: driver for Qualcomm
Wi-Fi 7 devices") in v6.3-rc1.

Fixed status
mainline: [afb522b36e76acaa9f8fc06d0a9742d841c47c16]

CVE-2023-54017: powerpc/pseries: fix possible memory leak in ibmebus_bus_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54017

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [3cc4c2f6c266fe5b33a7fa797f31e8b3f06ce58c]
cip/4.4-st: [07096fa4df5f821dfb461b3a4f54b0a0aa5f2e8c]
mainline: [afda85b963c12947e298ad85d757e333aa40fd74]
stable/5.10: [9f3b2b666833ebef6d0ce5a40e189f38e70342a1]
stable/5.15: [d35e7ae10eb8917883da2a0b1823c620a1be42d6]
stable/6.1: [96f27ff732208dce6468016e7a7d5032bd1bfc23]

CVE-2023-54018: drm/msm/hdmi: Add missing check for alloc_ordered_workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54018

Introduced by commit c6a57a5 ("drm/msm/hdmi: add hdmi hdcp support
(V3)") in v4.3-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [392f7eb3946ab3780b931af723033e19f82c9134]
cip/4.4-st: [5099c8aa69868025e8c0fb111bd0af6c1d749467]
mainline: [afe4cb96153a0d8003e4e4ebd91b5c543e10df84]
stable/5.10: [1bab31a0969ca4ac90907a5d3b44af104229eafd]
stable/5.15: [9a01ecc312e764ec4527ad49105a3ca799f1860c]
stable/6.1: [e55f93d674314f2fb69eba0dc24acfdf72805611]

CVE-2023-54019: sched/psi: use kernfs polling functions for PSI trigger polling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54019

Introduced by commit 0e94682 ("psi: introduce psi monitor") in v5.2-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aff037078ecaecf34a7c2afab1341815f90fba5e]
stable/6.1: [92cc0153324b6ae8577a39f5bf2cd83c9a34ea6a]

CVE-2023-54020: dmaengine: sf-pdma: pdma_desc memory leak fix

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54020

Introduced by commit b2cc5c4 ("dmaengine: sf-pdma: Add multithread
support for a DMA channel") in v6.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [b02e07015a5ac7bbc029da931ae17914b8ae0339]
stable/5.15: [ad222c9af25e3f074c180e389b3477dce42afc4f]
stable/6.1: [03fece43fa109beba7cc9948c02f5e2d1205d607]

CVE-2023-54021: ext4: set goal start correctly in ext4_mb_normalize_request

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54021

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [390eee955d4de4662db5e3e9e9a9eae020432cb7]
cip/4.4-st: [3882e90d425fdf2d9c0cfd0705628a79b65def97]
mainline: [b07ffe6927c75d99af534d685282ea188d9f71a6]
stable/5.10: [3ca3005b502ca8ea87d6a344323b179b48c4e4a3]
stable/5.15: [bc4a3e1d07a86ae5845321d371190244acacb2f2]
stable/6.1: [c6bee8970075b256fc1b07bf4873049219380818]

CVE-2023-54022: ALSA: usb-audio: Fix potential memory leaks at error
path for UMP open

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54022

Introduced by commit ff49d1d ("ALSA: usb-audio: USB MIDI 2.0 UMP
support") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1757fa30ef14f254f4719bf6f7d54a4c8207216]

CVE-2023-54023: btrfs: fix race between balance and cancel/pause

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54023

Introduced commit is not determined.Fixed in v6.5-rc3.


Fixed status
mainline: [b19c98f237cd76981aaded52c258ce93f7daa8cb]
stable/6.1: [ddf7e8984c83aee9122552529f4e77291903f8d9]

CVE-2023-54024: KVM: Destroy target device if coalesced MMIO
unregistration fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54024

Introduced by commit 5d3c4c7 ("KVM: Stop looking for coalesced MMIO
zones if the bus is destroyed") in v5.13-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b1cb1fac22abf102ffeb29dd3eeca208a3869d54]
stable/5.10: [76a9886e1b61ce5592df5ae78a19ed30399ae189]
stable/5.15: [999439fd5da5a76253e2f2c37b94204f47d75491]
stable/6.1: [ccf6a7fb1aedb1472e1241ee55e4d26b68f8d066]

CVE-2023-54025: wifi: rsi: Do not configure WoWlan in shutdown hook if
not enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54025

Introduced by commit 16bbc3e ("rsi: fix null pointer dereference
during rsi_shutdown()") in v5.7-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b241e260820b68c09586e8a0ae0fc23c0e3215bd]
stable/5.10: [b2aeb97fd470206e67f7b3b4a3e68212a13f747b]
stable/5.15: [4391fa180856ff84a2cef4a92694a689eebb855e]
stable/6.1: [eb205a06908122f50b1dd1baa43f7c8036bfc7dc]

CVE-2023-54026: opp: Fix use-after-free in lazy_opp_tables after probe deferral

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54026

Introduced by commit 7eba0c7 ("opp: Allow lazy-linking of
required-opps") in v5.12-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2a2ab039bd58f51355e33d7d3fc64605d7f870d]
stable/5.15: [39a0e723d3502f6dc4c603f57ebe8dc7bcc4a4bc]
stable/6.1: [76ab057de777723ec924654502d1a260ba7d7d54]

CVE-2023-54027: iio: core: Prevent invalid memory access when there is no parent

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54027

Introduced by commit 8136655 ("iio: core: Convert to use firmware node
handle instead of OF node") in v5.19-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2a69969908fcaf68596dfc04369af0fe2e1d2f7]
stable/6.1: [312f04ede209f0a186799fe8e64a19b49700d5dc]

CVE-2023-54028: RDMA/rxe: Fix the error "trying to register non-static
key in rxe_cleanup_task"

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54028

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Introduced by commit 2d4b21e ("IB/rxe: Prevent from completer to
operate on non valid QP") in v4.10-rc6.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2b1ddc457458fecd1c6f385baa9fbda5f0c63ad]
stable/6.1: [3236221bb8e4de8e3d0c8385f634064fb26b8e38]

CVE-2023-54029: wifi: iwlwifi: fix iwl_mvm_max_amsdu_size() for MLO

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54029

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [b2bc600cced23762d4e97db8989b18772145604f]
stable/6.1: [63e2d06adf6b0842132ba89efdf8fada5f7ff1ac]

CVE-2023-54030: io_uring/net: don't overflow multishot recv

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54030

Introduced by commit b3fdea6 ("io_uring: multishot recv") in v6.0-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2e74db55dd93d6db22a813c9a775b5dbf87c560]

CVE-2023-54031: vdpa: Add queue index attr to vdpa_nl_policy for
nlattr length check

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54031

Introduced by commit 13b00b1 ("vdpa: Add support for querying vendor
statistics") in v5.19-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3003e1b54e057f5f3124e437b80c3bef26ed3fe]
stable/6.1: [8ad9bc25cbdcec72e7ca43dd8281decb69ea9a70]

CVE-2023-54032: btrfs: fix race when deleting quota root from the
dirty cow roots list

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54032

Introduced by commit bed92ea ("Btrfs: qgroup implementation and
prototypes") in v3.6-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6da229754099518cfa27cbfcd0fd042618785fad]
cip/4.4-st: [640f4298daaacd3857c7ccb115b9537e7e50bf32]
mainline: [b31cb5a6eb7a48b0a7bfdf06832b1fd5088d8c79]
stable/5.10: [6819bb0b8552dcc5f82ca606c8911b8c67e0628f]
stable/5.15: [7ba0da31dd4a8fd24d416016c538a95a5664ff02]
stable/6.1: [a53d78d9a8551e72c46ded23e8b0a56e55d32032]

CVE-2023-54033: bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54033

Introduced by commit 20b6cc3 ("bpf: Avoid hashtab deadlock with
map_locked") in v5.11-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b34ffb0c6d23583830f9327864b9c1f486003305]
stable/5.15: [79ea1a12fb9a8275b6e19d4ca625dd872dedcbb9]
stable/6.1: [1a9e80f757bbb1562d82e350afce2bb2f712cc3d]

CVE-2023-54034: iommufd: Make sure to zero vfio_iommu_type1_info
before copying to user

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54034

Introduced by commit d624d66 ("iommufd: vfio container FD ioctl
compatibility") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3551ead616318ea155558cdbe7e91495b8d9b33]

CVE-2023-54035: netfilter: nf_tables: fix underflow in chain reference counter

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54035

Introduced by commit d6b4786 ("netfilter: nf_tables: fix underflow in
object reference counter") in v6.4.
Introduced by commit 628bd3e ("netfilter: nf_tables: drop map element
references from preparation phase") in v6.4.
Fixed in v6.5-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [b389139f12f287b8ed2e2628b72df89a081f0b59]
stable/6.1: [b068314fd8ce751a7f906e55bb90f3551815f1a0]

CVE-2023-54036: wifi: rtl8xxxu: Fix memory leaks with RTL8723BU, RTL8192EU

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54036

Introduced by commit e542e66 ("rtl8xxxu: add bluetooth co-existence
support for single antenna") in v5.5-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b39f662ce1648db0b9de32e6a849b098480793cb]
stable/5.10: [430f9f9bec53a75f9ccc53e156a66f13fc098b83]
stable/5.15: [35fb0e275af1aa1ca0a9784417e90f988aaf8e78]
stable/6.1: [93c3f34ec02fc81188d328287d4fddd498ccddea]

CVE-2023-54037: ice: prevent NULL pointer deref during reload

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54037

Introduced by commit 5b246e5 ("ice: split probe into smaller
functions") in v6.3-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3e7b3a6ee92ab927f750a6b19615ce88ece808f]

CVE-2023-54038: Bluetooth: hci_conn: return ERR_PTR instead of NULL
when there is no link

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54038

Introduced by commit 0614974 ("Bluetooth: hci_conn: Add support for
linking multiple hcon") in v6.4-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4066eb04bb67e7ff66e5aaab0db4a753f37eaad]

CVE-2023-54039: can: j1939: j1939_tp_tx_dat_new(): fix out-of-bounds
memory access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54039

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b45193cb4df556fe6251b285a5ce44046dd36b4a]
stable/5.10: [70caa596d158a5d84b117f722d58f3ea503a5ba9]
stable/5.15: [4fe1d9b6231a68ffc91318f57fd8e4982f028cf7]
stable/6.1: [4c3fb22a6ec68258ee129a2e6b720f43dffc562f]

CVE-2023-54040: ice: fix wrong fallback logic for FDIR

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54040

Introduced by commit 1f7ea1c ("ice: Enable FDIR Configure for AVF") in
v5.13-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4a01ace20f5c93c724abffc0a83ec84f514b98d]
stable/5.15: [391d28c0e38c0e5b11a4240a2b4976cf63e87f45]
stable/6.1: [aad3b871efe26f36f45f8b4649653b5d3fd9c35e]

CVE-2023-54041: io_uring: fix memory leak when removing provided buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54041

Introduced by commit cc3cec8 ("io_uring: speedup provided buffer
handling") in v5.18-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4a72c0589fdea6259720375426179888969d6a2]
stable/6.1: [ac48787f58d1068f4e06d627c1135784d64b4c72]

CVE-2023-54042: powerpc/64s: Fix VAS mm use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54042

Introduced by commit 7bc6f71 ("powerpc/vas: Define and use common
vas_window struct") in v5.14-rc1.
Introduced by commit b22f2d8 ("powerpc/pseries/vas: Integrate API with
open/close windows") in v5.14-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4bda59b47879cce38a6ec5a01cd3cac702b5331]
stable/5.15: [f7d92313002b2d543500cc417d8079aaed1fb0a8]
stable/6.1: [4e82f92c349ea603736ade1e814861c0182a55ad]

CVE-2023-54043: iommufd: Do not add the same hwpt to the ioas->hwpt_list twice

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54043

Introduced by commit e8d5721 ("iommufd: Add kAPI toward external
drivers for physical devices") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4ff830eca097df51af10a9be29e8cc817327919]

CVE-2023-54044: spmi: Add a check for remove callback when removing a
SPMI driver

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54044

Introduced by commit 6f00f8c ("mfd: qcom-spmi-pmic: Use
devm_of_platform_populate()") in v4.13-rc1.
Introduced by commit 5a86bf3 ("spmi: Linux driver framework for SPMI")
in v3.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [699949219e35fe29fd42ccf8cd92c989c3d15109]
cip/4.4-st: [03e94b6ba0cfef12f2664cb72cbf99ed7f989d13]
mainline: [b56eef3e16d888883fefab47425036de80dd38fc]
stable/5.10: [c45ab3ab9c371c9ac22bbe1217e5abb2e55a3d4b]
stable/5.15: [ee0b6146317a98bfec848d7bde5586beb245a38f]
stable/6.1: [428cc252701d6864151f3a296ffc23e1e49a7408]

CVE-2023-54045: audit: fix possible soft lockup in __audit_inode_child()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54045

Introduced by commit 5195d8e ("audit: dynamically allocate audit_names
when not enough space is in the names array") in v3.3-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1640c7bd4eddec6c72f3a99cbb74e333a2ce9f5d]
cip/4.4-st: [66e8006fd4b5ca42178244eae9d331f66c0fef5d]
mainline: [b59bc6e37237e37eadf50cd5de369e913f524463]
stable/5.10: [98ef243d5900d75a64539a2165745bffbb155d43]
stable/5.15: [0152e7758cc4e9f8bfba8dbea4438d8e488d6c08]
stable/6.1: [9ca08adb75fb40a8f742c371927ee73f9dc753bf]

CVE-2023-54046: crypto: essiv - Handle EBUSY correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54046

Introduced by commit be1eb7f ("crypto: essiv - create wrapper
template...") in v5.4-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5a772adf45a32c68bef28e60621f12617161556]
stable/5.10: [796e02cca30a67322161f0745e5ce994bbe75605]
stable/5.15: [840a1d3b77c1b062bd62b4733969a5b1efc274ce]
stable/6.1: [a006aa3eedb8bfd6fe317c3cfe9c86ffe76b2385]

CVE-2023-54047: drm/rockchip: dw_hdmi: cleanup drm encoder during unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54047

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [b5af48eedcb53491c02ded55d5991e03d6da6dbf]
stable/6.1: [110d4202522373d629d14597af9bac97eb58bd67]

CVE-2023-54048: RDMA/bnxt_re: Prevent handling any completions after qp destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54048

Introduced by commit 1ac5a40 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
in v4.11-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5bbc6551297447d3cca55cf907079e206e9cd82]
stable/5.15: [b79a0e71d6e8692e0b6da05f8aaa7d69191cf7e7]
stable/6.1: [b8500538b8f5b2cd86b02754c8de83eaa7a2d6ba]

CVE-2023-54049: rpmsg: glink: Add check for kstrdup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54049

Introduced by commit b4f8e52 ("rpmsg: Introduce Qualcomm RPM glink
driver") in v4.13-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [13928a837e0f014dac0322dd9f8a67c486e7f232]
mainline: [b5c9ee8296a3760760c7b5d2e305f91412adc795]
stable/5.10: [71ac2ffd7f80fdd350486f6645dc48456e55a59b]
stable/5.15: [abd740db896b3c588dced175af98b95852c1854b]
stable/6.1: [cae0787e408c30a575760a531ccb69a6b48bbfaf]

CVE-2023-54050: ubifs: Fix memleak when insert_old_idx() failed

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54050

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cc29c7216d7f057eb0613b97dc38c7e1962a88d2]
mainline: [b5fda08ef213352ac2df7447611eb4d383cce929]
stable/5.10: [66e9f2fb3e753f820bec2a98e8c6387029988320]
stable/5.15: [3ae75f82c33fa1b4ca2006b55c84f4ef4a428d4d]
stable/6.1: [ef9aac603659e9ffe7d69ae16e3f0fc0991a965b]

CVE-2023-54051: net: do not allow gso_size to be set to GSO_BY_FRAGS

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54051

Introduced by commit 3953c46 ("sk_buff: allow segmenting based on frag
sizes") in v4.8-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4c9bfadb4301daaceb6c575fa6ad3bc82c152e79]
mainline: [b616be6b97688f2f2bd7c4a47ab32f27f94fb2a9]
stable/5.10: [0a593e8a9d24360fbc469c5897d0791aa2f20ed3]
stable/5.15: [578371ce0d7f67ea1e65817c04478aaab0d36b68]
stable/6.1: [2e03a92b241102aaf490439aa1b00239f84f530f]

CVE-2023-54052: wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54052

Introduced by commit 163f4d2 ("mt76: mt7921: add MAC support") in v5.12-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b642f4c5f3de0a8f47808d32b1ebd9c427a42a66]
stable/6.1: [1cd102aaedb277fbe81dd08cd9f5cae951de2bff]

CVE-2023-54053: wifi: iwlwifi: pcie: fix possible NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54053

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [b655b9a9f8467684cfa8906713d33b71ea8c8f54]
stable/5.10: [0fc0d287c1e7dcb39a3b9bb0f8679cd68c2156c7]
stable/5.15: [7545f21eee1356ec98581125c4dba9c4c0cc7397]
stable/6.1: [0f9a1bcb94016d3a3c455a77b01f6bb06e15f6eb]

CVE-2023-54054: scsi: qla2xxx: Fix buffer overrun

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54054

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [b68710a8094fdffe8dd4f7a82c82649f479bb453]
stable/5.10: [eecb8a491c824a9376155d26ec95b6d0054c059c]
stable/5.15: [89250e775dcc4482d8e970ed92ad2c9458b14a8a]
stable/6.1: [2dddbf8de128289a3fb7ae38d9bc4b2217205ec1]

CVE-2023-54055: RDMA/irdma: Fix memory leak of PBLE objects

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54055

Introduced by commit 44d9e52 ("RDMA/irdma: Implement device
initialization definitions") in v5.14-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b69a6979dbaa2453675fe9c71bdc2497fedb11f9]
stable/5.15: [810250c9c6616fe131099c0e51c61f2110ed07bf]
stable/6.1: [ee02fa4a71bdb95a444124e5c11eaa22f1f44738]

CVE-2023-54056: kheaders: Use array declaration instead of char

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54056

Introduced by commit 43d8ce9 ("Provide in-kernel headers to make
extending kernel easier") in v5.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b69edab47f1da8edd8e7bfdf8c70f51a2a5d89fb]
stable/5.10: [fcd2da2e6bf2640a31a2a5b118b50dc3635c707b]
stable/5.15: [4a07d2d511e2703efd4387891d49e0326f1157f3]
stable/6.1: [b9f6845a492de20679b84bda6b08be347c5819da]

CVE-2023-54057: iommu/amd: Add a length limitation for the
ivrs_acpihid command-line parameter

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54057

Introduced by commit ca3bf5d ("iommu/amd: Introduces ivrs_acpihid
kernel parameter") in v4.7-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6b26d86c61c441144c72f842f7469bb686e1211]
stable/5.10: [f2a5ec7f7b28f9b9cd5fac232ff51019a7f7b9e9]
stable/5.15: [c513043e0afe6a8ba79d00af358655afabb576d2]
stable/6.1: [2ae19ac3ea82a5b87a81c10adbb497c9e58bdd60]

CVE-2023-54058: firmware: arm_ffa: Check if ffa_driver remove is
present before executing

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54058

Introduced by commit 244f5d5 ("firmware: arm_ffa: Add missing remove
callback to ffa_bus_type") in v5.15-rc6.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b71b55248a580e9c9befc4ae060539f1f8e477da]
stable/5.15: [6a26c62625c59b8dd7f52c518cb4f60a63470a0e]
stable/6.1: [ad73dc7263ea90302d6c7eeb7e9f7cbcfa0b0617]

CVE-2023-54059: soc: mediatek: mtk-svs: Enable the IRQ later

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54059

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected file was added by 681a02e ("soc: mediatek: SVS: introduce MTK
SVS engine") in v6.0-rc1.

Fixed status
mainline: [b74952aba6c3f47e7f2c5165abaeefa44c377140]
stable/6.1: [6b99ebd30d65ee5ab8e8dd1d378550911eff5e4f]

CVE-2023-54060: iommufd: Set end correctly when doing batch carry

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54060

Introduced by commit f394576 ("iommufd: PFN handling for iopt_pages")
in v6.2-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7c822fa6b7701b17e139f1c562fc24135880ed4]

CVE-2023-54061: x86: fix clear_user_rep_good() exception handling annotation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54061


This bug was fixed by b805d21 ("x86: fix clear_user_rep_good()
exception handling annotation") in v6.3.3.
Bug introduced commit was backported to following branches.
stable/6.1

Fixed status
mainline: [n,e,v,e,r]

CVE-2023-54062: ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54062

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
cip/4.19-st: [f30f3391d089dc91aef91d08f4b04a6c0df2b067]
mainline: [b87c7cdf2bed4928b899e1ce91ef0d147017ba45]
stable/5.10: [1a8822343e67432b658145d2760a524c884da9d4]
stable/5.15: [8beaa3cb293a8f7bacf711cf52201d59859dbc40]
stable/6.1: [c5fa4eedddd1c8342ce533cb401c0e693e55b4e3]

CVE-2023-54063: fs/ntfs3: Fix OOB read in indx_insert_into_buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54063

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8c44949044e5f7f864525fdffe8e95135ce9ce5]
stable/5.15: [cd7e1d67924081717c5c96ead758a1a77867689a]
stable/6.1: [17048287ac79abd33b275ac3b5738285d406481b]

CVE-2023-54064: ipmi:ssif: Fix a memory leak when scanning for an adapter

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54064

Introduced by commit c4436c9 ("ipmi_ssif: avoid registering duplicate
ssif interface") in v5.4-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8d72e32e1453d37ee5c8a219f24e7eeadc471ef]
stable/5.10: [13623b966bb6d36ba61646b69cd49cdac6e4978a]
stable/5.15: [3ad53071fe8547eb8d8813971844cc43246008ee]
stable/6.1: [74a1194cce60a90723d0fe148863c18931a31153]

CVE-2023-54065: net: dsa: realtek: fix out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54065

Introduced by commit aac9400 ("net: dsa: realtek: add new mdio
interface for drivers") in v5.18-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b93eb564869321d0dffaf23fcc5c88112ed62466]
stable/6.1: [cc0f9bb99735d2b68fac68f37b585d615728ce5b]

CVE-2023-54066: media: dvb-usb-v2: gl861: Fix null-ptr-deref in
gl861_i2c_master_xfer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54066

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected code was added by 1ea76d1 ("media: gl861: re-implement I2C
adapter logic") in v5.5-rc1.

Fixed status
mainline: [b97719a66970601cd3151a3e2020f4454a1c4ff6]
stable/5.10: [578b67614ae0e4fba3945b66a4c8f9ae77115bcb]
stable/5.15: [2a33fc57133d6f39d62285df6706aeb1714967f1]
stable/6.1: [dfcd3c010209927b9f45b860f046635dc32e32e1]

CVE-2023-54067: btrfs: fix race when deleting free space root from the
dirty cow roots list

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54067

Introduced by commit a5ed918 ("Btrfs: implement the free space
B-tree") in v4.5-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [babebf023e661b90b1c78b2baa384fb03a226879]
stable/6.1: [6f1c81886b0b56cb88b311e5d2f203625474d892]

CVE-2023-54068: f2fs: compress: fix to call
f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54068

Introduced by commit 4c8ff70 ("f2fs: support data compression") in v5.6-rc1.
Introduced by commit 7377e85 ("f2fs: compress: fix potential deadlock
of compress file") in v5.17-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [babedcbac164cec970872b8097401ca913a80e61]
stable/5.10: [a8226a45b2a9ce83ba7a167a387a00fecc319e71]
stable/5.15: [169134da419cb8ffbe3b0743bc24573e16952ea9]
stable/6.1: [6604df2a9d07ba8f8fb1ac14046c2c83776faa4f]

CVE-2023-54069: ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54069

Introduced by commit 93cdf49 ("ext4: Fix best extent lstart adjustment
logic in ext4_mb_new_inode_pa()") in v6.4-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
mainline: [bc056e7163ac7db945366de219745cf94f32a3e6]
stable/5.10: [58fe961c606c446f5612f6897827b1cac42c2e89]
stable/5.15: [f2c3a3aa6f11ad9878dbc3a067b0633e07b586c1]
stable/6.1: [fcefddf3a151b2c416b20120c06bb1ba9ad676fb]

CVE-2023-54070: igb: clean up in all error paths when enabling SR-IOV

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54070

Introduced by commit 50f3034 ("igb: Enable SR-IOV after reinit") in v6.3-rc4.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc6ed2fa24b14e40e1005488bbe11268ce7108fa]

CVE-2023-54071: wifi: rtw88: use work to update rate to avoid RCU warning

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54071

Introduced by commit c1edc86 ("rtw88: add ieee80211:sta_rc_update
ops") in v5.19-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcafcb959a57a6890e900199690c5fc47da1a304]
stable/6.1: [107677a8f43521e33e4a653e50fdf55ba622a4ce]

CVE-2023-54072: ALSA: pcm: Fix potential data race at PCM memory
allocation helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54072

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [bd55842ed998a622ba6611fe59b3358c9f76773d]
stable/5.10: [7e11c58b2620a22c67a5ae28d64ce383890ee9f4]
stable/5.15: [a0ab49e7a758b488b2090171a75d50735c0876f6]
stable/6.1: [3eb4e47a94e3f76521d7d344696db61e6a9619c7]

CVE-2023-54073: tpm: Add !tpm_amd_is_rng_defective() to the
hwrng_unregister() call site

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54073

Introduced by commit f1324bb ("tpm: disable hwrng for fTPM on some AMD
designs") in v6.3-rc2.
Introduced by commit b006c43 ("hwrng: core - start hwrng kthread also
for untrusted sources") in v6.1-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [bd8621ca1510e6e802df9855bdc35a04a3cfa932]
stable/6.1: [1408d27f25c7b73ece7545cb6434965eedc49ddb]

CVE-2023-54074: net/mlx5e: Use correct encap attribute during invalidation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54074

Introduced by commit 8300f22 ("net/mlx5e: Create new flow attr for
multi table actions") in v5.18-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be071cdb167fc3e25fe81922166b3d499d23e8ac]
stable/6.1: [00959a1bad58e4b6c14a2729f84d354255073609]

CVE-2023-54075: ASoC: mediatek: common: Fix refcount leak in parse_dai_link_info

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54075

Introduced by commit 4302187 ("ASoC: mediatek: common: add soundcard
driver common code") in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [beed115c2ce78f990222a29abed042582df4e87c]

CVE-2023-54076: smb: client: fix missed ses refcounting

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54076

Introduced by commit 8e35541 ("cifs: fix sharing of DFS connections")
in v6.4-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf99f6be2d20146942bce6f9e90a0ceef12cbc1e]

CVE-2023-54077: fs/ntfs3: Fix memory leak if ntfs_read_mft failed

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54077

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfa434c60157c9793e9b12c9b68ade02aff9f803]
stable/5.15: [3030f2b9b3329db3948c1a145a5493ca6f617d50]
stable/6.1: [1bc6bb657dfb0ab3b94ef6d477ca241bf7b6ec06]

CVE-2023-54078: media: max9286: Free control handler

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54078

Introduced by commit 66d8c9d ("media: i2c: Add MAX9286 driver") in v5.9-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfce6a12e5ba1edde95126aa06778027f16115d4]
stable/5.10: [9a3a907cf69f804eb41ece5c079720d1a6a15aa1]
stable/5.15: [1ad4b8c4552b4096dfc86531462dc1899f96af94]
stable/6.1: [1e9fc6c473210138eff3425a6136f0a9bf4eb0ae]

CVE-2023-54079: power: supply: bq27xxx: Fix poll_interval handling and
races on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54079

Introduced by commit 8cfaaa8 ("bq27x00_battery: Fix OOPS caused by
unregistring bq27x00 driver") in v3.3-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [465d919151a1e8d40daf366b868914f59d073211]
mainline: [c00bc80462afc7963f449d7f21d896d2f629cacc]
stable/5.10: [e85757da9091998276ff21a13915ac25229cc232]
stable/5.15: [e98e5bebfcafc75a7b41192a607dfea5c1268afa]
stable/6.1: [d952a1eaafcc5f0351caad5dbe9b5b3300d1d529]

CVE-2023-54080: btrfs: zoned: skip splitting and logical rewriting on
pre-alloc write

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54080

Introduced by commit cbfce4c ("btrfs: optimize the logical to physical
mapping for zoned writes") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c02d35d89b317994bd713ba82e160c5e7f22d9c8]

CVE-2023-54081: xen: speed up grant-table reclaim

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54081

Introduced commit is not determined.Fixed in v6.5-rc4.


Fixed status
mainline: [c04e9894846c663f3278a414f34416e6e45bbe68]
stable/6.1: [cd1a8952ff529adc210e62306849fd6f256608c0]

CVE-2023-54082: af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54082



Bug introduced commit is not backported to older stable kernels.

Fixed status
stable/5.10: [c080cee930303124624fe64fc504f66c815ee6b9]

CVE-2023-54083: phy: tegra: xusb: Clear the driver reference in usb-phy dev

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54083

Introduced by commit e8f7d2f ("phy: tegra: xusb: Add usb-phy support")
in v5.7-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0c2fcb1325d0d4f3b322b5ee49385f8eca2560d]
stable/5.10: [b6a107c52073496d2e5d2837915f59fb3103832f]
stable/5.15: [b84998a407a882991916b1a61d987c400d8a0ce6]
stable/6.1: [238edc04ddb9d272b38f5419bcd419ad3b92b91b]

CVE-2023-54084: ALSA: firewire-digi00x: prevent potential use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54084

Introduced by commit 9a08067 ("ALSA: firewire-digi00x: support AMDTP
domain") in v5.4-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0e72058d5e21982e61a29de6b098f7c1f0db498]
stable/5.10: [13c5fa1248bf06e95a25907c1be83948b8c44c50]
stable/5.15: [bbb5ac533ca6c4e2775a95388c9c0c610bb442b7]
stable/6.1: [ee1a221d947809c0308f27567c07a3ac93406057]

CVE-2023-54085: mptcp: fix NULL pointer dereference on fastopen early fallback

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54085

Introduced by commit 36b122b ("mptcp: add
subflow_v(4,6)_send_synack()") in v6.2-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0ff6f6da66a7791a32c0234388b1bdc00244917]

CVE-2023-54086: bpf: Add preempt_count_{sub,add} into btf id deny list

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54086

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [c11bd046485d7bf1ca200db0e7d0bdc4bafdd395]
stable/5.15: [095018267c87b8bfbbb12eeb1c0ebf2359e1782c]
stable/6.1: [60039bf72f81638baa28652a11a68e9b0b7b5b2d]

CVE-2023-54087: ubi: Fix possible null-ptr-deref in ubi_free_volume()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54087

Introduced by commit 801c135 ("UBI: Unsorted Block Images") in v2.6.22-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [45b2c5ca4d2edae70f19fdb086bd927840c4c309]
cip/4.4-st: [227b1627c131d0eca59fff40fb4886dc59c24921]
mainline: [c15859bfd326c10230f09cb48a17f8a35f190342]
stable/5.10: [fcbc795abe7897da4b5d2a6ab5010e36774b00c2]
stable/5.15: [5ec4c8aca5a221756a9007deadfea92795319fee]
stable/6.1: [2ea7195b195009ecf0046e55361f393ba96d02db]

CVE-2023-54088: blk-cgroup: hold queue_lock when removing blkg->q_node

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54088

Introduced by commit f1c006f ("blk-cgroup: synchronize pd_free_fn()
from blkg_free_workfn() and blkcg_deactivate_policy()") in v6.3-rc1.
Fixed in v6.5-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [c164c7bc9775be7bcc68754bb3431fce5823822e]
stable/6.1: [b5dae1cd0d8368b4338430ff93403df67f0b8bcc]

CVE-2023-54089: virtio_pmem: add the missing REQ_OP_WRITE for flush bio

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54089

Introduced by commit b4a6bb3 ("block: add a sanity check for non-write
flush/fua bios") in v6.3-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1dbd8a849183b9c12d257ad3043ecec50db50b3]

CVE-2023-54090: ixgbe: Fix panic during XDP_TX with > 64 CPUs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54090

Introduced by commit 4fe8158 ("ixgbe: let the xdpdrv work with more
than 64 cpus") in v5.16-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c23ae5091a8b3e50fe755257df020907e7c029bb]
stable/6.1: [1924450175349e64f8dfc3689efcb653dba0418e]

CVE-2023-54091: drm/client: Fix memory leak in drm_client_target_cloned

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54091

Introduced by commit 1d42bbc ("drm/fbdev: fix cloning on fbcon") in v2.6.35-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a4b978249e8fa94956fce8b70a709f7797716f62]
cip/4.4-st: [ebdf7eb8c0f4a118d02890dc1a43cb07b3202a02]
mainline: [c2a88e8bdf5f6239948d75283d0ae7e0c7945b03]
stable/5.10: [105275879a80503686a8108af2f5c579a1c5aef4]
stable/5.15: [a85e23a1ef63e45a18f0a30d7816fcb4a865ca95]
stable/6.1: [b5359d7a5087ac398fc429da6833133b4784c268]

CVE-2023-54092: KVM: s390: pv: fix index value of replaced ASCE

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54092

Introduced by commit faa2f72 ("KVM: s390: pv: leak the topmost page
table when destroy fails") in v6.0-rc1.
Fixed in v6.5-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [c2fceb59bbda16468bda82b002383bff59de89ab]
stable/5.10: [8e635da0e0d3cb45e32fa79b36218fb98281bc10]
stable/5.15: [49a2686adddebe1ae76b4d368383208656ef6606]
stable/6.1: [017f686bcb536ff23d49c143fdf9d1fd89a9a924]

CVE-2023-54093: media: anysee: fix null-ptr-deref in anysee_master_xfer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54093

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [e04affec2506ff5c12a18d78d7e694b3556a8982]
cip/4.4-st: [d5b48c4a1d71febb1e8ceb8d50f59c886a33e7d1]
mainline: [c30411266fd67ea3c02a05c157231654d5a3bdc9]
stable/5.10: [4a9763d2bc4a6d6fab42555b9c0b2eefa32585ac]
stable/5.15: [3dd5846a873938ec7b6d404ec27662942cd8f2ef]
stable/6.1: [14b94154a72388b57221a2a73795c0ea61a95373]

CVE-2023-54094: net: prevent skb corruption on frag list segmentation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54094

Introduced by commit 3a1296a ("net: Support GRO/GSO fraglist
chaining.") in v5.6-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c329b261afe71197d9da83c1f18eb45a7e97e089]
stable/5.10: [bc3ab5d2ab69823f5cff89cf74ef78ffa0386c9a]
stable/5.15: [ea438eed94ac0fe69b93ac034738823c0e989a12]
stable/6.1: [1731234e8b60063eae858c77b55c7a88f5084353]

CVE-2023-54095: powerpc/iommu: Fix notifiers being shared by PCI and VIO buses

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54095

Introduced by commit d6b9a81 ("powerpc: IOMMU fault injection") in v3.6-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [075a4dcdbc9a5ea793cb8ec8b78a6c0b7636fd52]
cip/4.4-st: [98cb73a77e82161ce9af8831fbdf7b0cf6bc586a]
mainline: [c37b6908f7b2bd24dcaaf14a180e28c9132b9c58]
stable/5.10: [f08944e3c6962b00827de7263a9e20688e79ad84]
stable/5.15: [a9ddbfed53465bc7c411231db32a488066c0c1be]
stable/6.1: [f17d5efaafba3d5f02f0373f7c5f44711d676f3e]

CVE-2023-54096: soundwire: fix enumeration completion

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54096

Introduced by commit fb9469e ("soundwire: bus: fix race condition with
enumeration_complete signaling") in v5.7-rc1.
Introduced by commit a90def0 ("soundwire: bus: fix race condition with
initialization_complete signaling") in v5.7-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c40d6b3249b11d60e09d81530588f56233d9aa44]
stable/5.10: [48d1d0ce0782f995fda678508fdae35c5e9593f0]
stable/5.15: [a36b522767f3a72688893a472e80c9aa03e67eda]
stable/6.1: [e1d54962a63b6ec04ed0204a3ecca942fde3a6fe]

CVE-2023-54097: regulator: stm32-pwr: fix of_iomap leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54097

Introduced by commit dc62f95 ("regulator: stm32-pwr: Fix return value
check in stm32_pwr_regulator_probe()") in v5.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4a413e56d16a2ae84e6d8992f215c4dcc7fac20]
stable/5.10: [dfce9bb3517a78507cf96f9b83948d0b81338afa]
stable/5.15: [ad6481f49fb2c703efa3a929643934f24b666d6a]
stable/6.1: [f25994f7a9ad53eb756bc4869497c3ebe281ad5e]

CVE-2023-54098: drm/i915/gvt: fix gvt debugfs destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54098

Introduced by commit bc7b0be ("drm/i915/gvt: Add basic debugfs
infrastructure") in v4.16-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4b850d1f448a901fbf4f7f36dec38c84009b489]
stable/5.10: [bb7c7b2c89d2feb347b6f9bffc1c75987adb1048]
stable/5.15: [ae9a61511736cc71a99f01e8b7b90f6fb6128ed8]
stable/6.1: [fe340500baf84b6531c9fc508b167525b9bf6446]

CVE-2023-54099: fs: Protect reconfiguration of sb read-write from racing writes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54099

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [c541dce86c537714b6761a79a969c1623dfa222b]
stable/5.10: [7e4e87ec56aa6d008c64eab31b340a7c452b26cc]
stable/5.15: [0ccfe21949bc9f706a86ee7351b74375c0745757]
stable/6.1: [295ef44a2abaf97d7a594b1d4c60d4be3738191f]

CVE-2023-54100: scsi: qedi: Fix use after free bug in qedi_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54100

Introduced by commit 4b1068f ("scsi: qedi: Add MFW error recovery
process") in v5.7-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5749639f2d0a1f6cbe187d05f70c2e7c544d748]
stable/5.10: [fa19c533ab19161298f0780bcc6523af88f6fd20]
stable/5.15: [5e756a59cee6a8a79b9059c5bdf0ecbf5bb8d151]
stable/6.1: [3738a230831e861503119ee2691c4a7dc56ed60a]

CVE-2023-54101: driver: soc: xilinx: use _safe loop iterator to avoid
a use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54101

Introduced by commit c7fdb24 ("drivers: soc: xilinx: add xilinx event
management driver") in v5.17-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c58da0ba3e5c86e51e2c1557afaf6f71e00c4533]
stable/6.1: [49fca83f6f3f0cafe5bf5b43e8ee81cf73c2d5e0]

CVE-2023-54102: scsi: lpfc: Prevent lpfc_debugfs_lockstat_write()
buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54102

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected code was added by 6a828b0 ("scsi: lpfc: Support non-uniform
allocation of MSIX vectors to hardware queues") in v5.1-rc1.

Fixed status
mainline: [c6087b82a9146826564a55c5ca0164cac40348f5]
stable/5.10: [e0e7faee3a7dd6f51350cda64997116a247eb045]
stable/5.15: [f91037487036e2d2f18d3c2481be6b9a366bde7f]
stable/6.1: [a9df88cb31dcbd72104ec5883f35cbc1fb587e47]

CVE-2023-54103: media: mtk-jpeg: Fix use after free bug due to uncanceled work

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54103

Introduced by commit b2f0d27 ("[media] vcodec: mediatek: Add Mediatek
JPEG Decoder Driver") in v4.12-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c677d7ae83141d390d1253abebafa49c962afb52]
stable/5.10: [d346a2ef6b1ebb77d740890cfaf8478c5b286380]
stable/5.15: [d56dbfe750a8f96789cc86a911864f663e63bc5d]
stable/6.1: [715c0200b4809396998e562ce5cd0284e7314cc1]

CVE-2023-54104: mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54104

Introduced by commit 54309d6 ("mtd: rawnand: fsl_upm: Implement
exec_op()") in v5.9-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6abce60338aa2080973cd95be0aedad528bb41f]
stable/5.10: [1f09d67d390647f83f8f9d26382b0daa43756e6f]
stable/5.15: [eb7a5e4d14c8659cb97db6863316280e15f67209]
stable/6.1: [f4b700c71802c81e6f9dce362ee7a0312c8377ba]

CVE-2023-54105: can: isotp: check CAN address family in isotp_bind()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54105

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [c6adf659a8ba85913e16a571d5a9bcd17d3d1234]
stable/5.10: [de3c02383aa678f6799402ac47fdd89cf4bfcaa9]
stable/5.15: [2fc6f337257f4f7c21ecff429241f7acaa6df4e8]
stable/6.1: [9427584c2f153d0677ef3bad6f44028c60d728c4]

CVE-2023-54106: net/mlx5: fix potential memory leak in mlx5e_init_rep_rx

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54106

Introduced by commit af8bbf7 ("net/mlx5e: Convert mlx5e_flow_steering
member of mlx5e_priv to pointer") in v6.0-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6cf0b6097bf1bf1b2a89b521e9ecd26b581a93a]
stable/6.1: [0582a3caaa3e2f7b80bcb113ad3c910eac15a63e]

CVE-2023-54107: blk-cgroup: dropping parent refcount after pd_free_fn() is done

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54107

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [c7241babf0855d8a6180cd1743ff0ec34de40b4e]
stable/6.1: [029f1f1efa84387474b445dac4281cf95a398db8]

CVE-2023-54108: scsi: qla2xxx: Fix DMA-API call trace on NVMe LS requests

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54108

Introduced by commit c85ab7d ("scsi: qla2xxx: Fix missed DMA unmap for
NVMe ls requests") in v5.18-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [c75e6aef5039830cce5d4cf764dd204522f89e6b]
stable/5.10: [e596253113b69b4018818260bd5da40c201bee73]
stable/5.15: [77302fb0e357da666d5249a6e91078feeef3dade]
stable/6.1: [3ee4f1991c54c6707aa9df47e51c02ea25bb63e3]

CVE-2023-54109: media: rcar_fdp1: Fix refcount leak in probe and remove function

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54109

Introduced by commit 4710b75 ("[media] v4l: Add Renesas R-Car FDP1
Driver") in v4.10-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [418a8f3140e07f33bbd5a81625d0ef46c0732cef]
mainline: [c766c90faf93897b77c9c5daa603cffab85ba907]
stable/5.10: [1acb982e3616e70128994fdecf2368a259c8a489]
stable/5.15: [2322b262d2205720518785c2706a3283725ba402]
stable/6.1: [45b7461d914c867ef21c74798da8c42d13d3a0df]

CVE-2023-54110: usb: rndis_host: Secure rndis_query check against int overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54110

Introduced by commit ddda086 ("USB: rndis_host, various cleanups") in
v2.6.22-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [02ffb4ecf0614c58e3d0e5bfbe99588c9ddc77c0]
cip/4.4-st: [964b72b7f108573907258510763dd9680b17e275]
mainline: [c7dd13805f8b8fc1ce3b6d40f6aff47e66b72ad2]
stable/5.10: [232ef345e5d76e5542f430a29658a85dbef07f0b]
stable/5.15: [11cd4ec6359d90b13ffb8f85a9df8637f0cf8d95]
stable/6.1: [a713602807f32afc04add331410c77ef790ef77a]

CVE-2023-54111: pinctrl: rockchip: Fix refcount leak in
rockchip_pinctrl_parse_groups

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54111

Introduced by commit d3e5116 ("pinctrl: add pinctrl driver for
Rockchip SoCs") in v3.11-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5868013522297bf628eee4322d99d6d4de4f308e]
cip/4.4-st: [4138e187ddc2215e12cc2751b831c188b235ae49]
mainline: [c818ae563bf99457f02e8170aabd6b174f629f65]
stable/5.10: [d562054a3a2eede3507a5461011ee82b671fcb88]
stable/5.15: [0f735f232ff59863e0b6ebac0849d637e215a9c2]
stable/6.1: [dbef00ef4b9b98d15183340396e5df0fa7a860d8]

CVE-2023-54112: kcm: Fix memory leak in error path of kcm_sendmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54112

Introduced by commit ab7ac4e ("kcm: Kernel Connection Multiplexor
module") in v4.6-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5e5554389397e98fafb9efe395d8b4830dd5f042]
mainline: [c821a88bd720b0046433173185fd841a100d44ad]
stable/5.10: [33db24ad811b3576a0c2f8862506763f2be925b0]
stable/5.15: [97275339c34cfbccd65e87bc38fd910ae66c48ba]
stable/6.1: [16989de75497574b5fafd174c0c233d5a86858b7]

CVE-2023-54113: rcu: dump vmalloc memory info safely

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54113

Introduced by commit 98f1808 ("mm: Make mem_dump_obj() handle
vmalloc() memory") in v5.12-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c83ad36a18c02c0f51280b50272327807916987f]
stable/5.15: [0a22f9c17b1aa2a35b5eedee928f7841595b55cd]
stable/6.1: [3f7a4e88e40e38c0b16a4bcb599b7b1d8c81440d]

CVE-2023-54114: net: nsh: Use correct mac_offset to unwind gso skb in
nsh_gso_segment()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54114

Introduced by commit c411ed8 ("nsh: add GSO support") in v4.14-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d2309e0cb27b6871b273fbc1725e93be62570d86]
mainline: [c83b49383b595be50647f0c764a48c78b5f3c4f8]
stable/5.10: [02b20e0bc0c2628539e9e518dc342787c3332de2]
stable/5.15: [cdd8160dcda1fed2028a5f96575a84afc23aff7d]
stable/6.1: [6fbedf987b6b8ed54a50e2205d998eb2c8be72f9]

CVE-2023-54115: pcmcia: rsrc_nonstatic: Fix memory leak in
nonstatic_release_resource_db()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54115

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [2d45e2be0be35a3d66863563ed2591ee18a6897e]
cip/4.4-st: [d5dd54cd48d6b3bc24af555fa3cf2a8feb56c414]
mainline: [c85fd9422fe0f5d667305efb27f56d09eab120b0]
stable/5.10: [04bb8af40a7729c398ed4caea7e66cedd2881719]
stable/5.15: [97fd1c8e9c5aa833aab7e836760bc13103afa892]
stable/6.1: [e8a80cf06b4bb0396212289d651b384c949f09d0]

CVE-2023-54116: drm/fbdev-generic: prohibit potential out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54116

Introduced by commit aa15c67 ("drm/fb-helper: Fix vertical damage
clipping") in v5.18-rc1.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8687694bb1f5c48134f152f8c5c2e53483eb99d]
stable/6.1: [efd2821b8abeccb6b51423002e2a62921481a26e]

CVE-2023-54117: s390/dcssblk: fix kernel crash with list_add corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54117

Introduced by commit fb08a19 ("dax: simplify the dax_device <->
gendisk association") in v5.17-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8f40a0bccefd613748d080147469a4652d6e74c]
stable/6.1: [6489ec0107860345bc57dcde39e63dfb05ac5c11]

CVE-2023-54118: serial: sc16is7xx: setup GPIO controller later in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54118

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [c8f71b49ee4d28930c4a6798d1969fa91dc4ef3e]
stable/5.10: [17b96b5c19bec791b433890549e44ca523dc82aa]
stable/5.15: [49b326ce8a686428d8cbb82ed74fc88ed3f95a51]
stable/6.1: [f57c2164d082a36d177ab7fbf54c18970df89c22]

CVE-2023-54119: inotify: Avoid reporting event with invalid wd

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54119

Introduced by commit 7e790dd ("inotify: fix error paths in
inotify_update_watch") in v2.6.31-rc5.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c915d8f5918bea7c3962b09b8884ca128bfd9b0c]
stable/5.10: [2d65c97777e5b4a845637800d5d7b648f5772106]
stable/5.15: [17ad86d8c12220de97e80d88b5b4c934a40e1812]
stable/6.1: [145f54ea336b06cf4f92eeee996f2ffca939ea43]

CVE-2023-54120: Bluetooth: Fix race condition in hidp_session_thread

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54120

Introduced commit is not determined.Fixed in v6.3-rc7.


Fixed status
cip/4.19-st: [5f3d214d19899183d4e0cce7552998262112e4ab]
cip/4.4-st: [4c59daa3d2f095937a0c8ede490b9a6816da42d7]
mainline: [c95930abd687fcd1aa040dc4fe90dff947916460]
stable/5.10: [f7ec5ca433ceead8d9d78fd2febff094f289441d]
stable/5.15: [0efb276d5848a3accc37c6f41b85e442c4768169]
stable/6.1: [f6719fd8f409fa1da8dc956e93822d25e1e8b360]

CVE-2023-54121: btrfs: fix incorrect splitting in btrfs_drop_extent_map_range

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54121

Introduced by commit 55ef689 ("Btrfs: Fix btrfs_drop_extent_cache for
skip pinned case") in v2.6.33-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c962098ca4af146f2625ed64399926a098752c9c]
stable/6.1: [9f68e2105dd96cf0fafffffafb2337fbd0fbae1f]

CVE-2023-54122: drm/msm/dpu: Add check for cstate

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54122

Introduced by commit 1cff744 ("drm/msm: Convert to using
__drm_atomic_helper_crtc_reset() for reset.") in v5.3-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c96988b7d99327bb08bd9efd29a203b22cd88ace]
stable/5.10: [31f2f8de0ea7387cde18a24f94ba5e0b886b9842]
stable/5.15: [d4ba50614cb3f0686bbdb505af685d78e75861dc]
stable/6.1: [42442d42c57b9fbc35cb5ef72c7e5347c5f7d082]

CVE-2023-54123: md/raid10: fix memleak for 'conf->bio_split'

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54123

Introduced by commit fc9977d ("md/raid10: simplify the splitting of
requests.") in v4.12-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [133008af833b4f2e021d2c294c29c70364a3f0ba]
mainline: [c9ac2acde53f5385de185bccf6aaa91cf9ac1541]
stable/5.10: [6361b0592b46c465ac926c1f3105d66c30d9658b]
stable/5.15: [7f673fa34c0e3f95ee951a1bbf61791164871d2e]
stable/6.1: [b21019a220d9cac08819bb6c63000de9ee61eb9e]

CVE-2023-54124: f2fs: fix to drop all dirty pages during umount() if
cp_error is set

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54124

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [92575f05a32dafb16348bfa5e62478118a9be069]
mainline: [c9b3649a934d131151111354bcbb638076f03a30]
stable/5.10: [ad87bd313f70b51e48019d5ce2d02d73152356b3]
stable/5.15: [d8f4ad5f3979dbd8e6251259562f12472717883a]
stable/6.1: [7741ddc882a0c806a6508ba8203c55a779db7a21]

CVE-2023-54125: fs/ntfs3: Return error for inconsistent extended attributes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54125

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected file was added by be71b5c ("fs/ntfs3: Add attrib operations")
in v5.15-rc1.

Fixed status
mainline: [c9db0ff04649aa0b45f497183c957fe260f229f6]

CVE-2023-54126: crypto: safexcel - Cleanup ring IRQ workqueues on load failure

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54126

Introduced by commit 1b44c5a ("inside-secure - add SafeXcel EIP197
crypto engine driver") in v4.13-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca25c00ccbc5f942c63897ed23584cfc66e8ec81]
stable/5.10: [0a89d4a075524cf1f865cfdbb9cf38ab8e3e5409]
stable/5.15: [09e177d6f7edd0873a63f51abe914902ec0f4400]
stable/6.1: [4d9d2fd86766ee3ec077c011aa482e85b6c9595c]

CVE-2023-54127: fs/jfs: prevent double-free in dbUnmount() after
failed jfs_remount()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54127

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [aef6507e85475e30831c30405d785c7ed976ea4a]
cip/4.4-st: [6647c215be697783dfd6c4491cbde688e42cac58]
mainline: [cade5397e5461295f3cb87880534b6a07cafa427]
stable/5.10: [6f8b34458948ffca2fe90cd8c614e3fa2ebe0b27]
stable/5.15: [aa5b019a3e0f7f54f4e5370c1af827f6b00fd26b]
stable/6.1: [2f7a36448f51d08d3a83f1514abcca4b680bcd3c]

CVE-2023-54128: fs: drop peer group ids under namespace lock

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54128

Introduced by commit 2a18672 ("fs: add mount_setattr()") in v5.12-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb2239c198ad9fbd5aced22cf93e45562da781eb]
stable/5.15: [0af8fae81d8b7f1beddc17c5d4cfa43235134648]
stable/6.1: [ddca03d97daa7b07b60c52e3d3060762732c6666]

CVE-2023-54129: octeontx2-af: Add validation for lmac type

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54129

Introduced by commit 61071a8 ("octeontx2-af: Forward CGX link
notifications to PFs") in v4.20-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb5edce271764524b88b1a6866b3e626686d9a33]
stable/6.1: [83a7f27c5b94e43f29f8216a32790751139aa61e]

CVE-2023-54130: hfs/hfsplus: avoid WARN_ON() for sanity check, use
proper error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54130

Introduced by commit 55d1cbb ("hfs/hfsplus: use WARN_ON for sanity
check") in v5.16-rc1.
Introduced by commit 8d824e6 ("hfs: fix OOB Read in __hfs_brec_find")
in v6.2-rc1.
Fixed in v6.2-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
cip/4.19-st: [82725be426bce0a425cc5e26fbad61ffd29cff03]
cip/4.4-st: [db35eae827de5c9b03cc8c4ba536581bbd196671]
mainline: [cb7a95af78d29442b8294683eca4897544b8ef46]
stable/5.10: [be01f35efa876eb81cebab2cb0add068b7280ef4]
stable/5.15: [f10defb0be6ac42fb6a97b45920d32da6bd6fde8]
stable/6.1: [45917be9f0af339a45b4619f31c902d37b8aed59]

CVE-2023-54131: wifi: rt2x00: Fix memory leak when handling surveys

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54131

Introduced by commit 5447626 ("rt2x00: save survey for every channel
visited") in v5.11-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbef9a83c51dfcb07f77cfa6ac26f53a1ea86f49]
stable/5.15: [eb77c0c0a17c53d83b5fe8e46490fb0a7ed9e6af]
stable/6.1: [bea3f8aa999318bdffa2d17753e492f76904f0ce]

CVE-2023-54132: erofs: stop parsing non-compact HEAD index if
clusterofs is invalid

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54132

Introduced by commit 02827e1 ("staging: erofs: add
erofs_map_blocks_iter") in v4.19-rc1.
Introduced by commit 152a333 ("staging: erofs: add compacted
compression indexes support") in v5.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc4efd3dd2ac9f89143e5d881609747ecff04164]
stable/5.10: [7a4579cd6e4936de107c82499c3c9ee11b63401e]
stable/5.15: [060fecf1114ff9fcfe87953fe8c4fc5048777160]
stable/6.1: [7ee7a86e28ce9ead7112286c388df8d254c373c6]

CVE-2023-54133: nfp: clean mc addresses in application firmware when
closing port

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54133

Introduced by commit e20aa07 ("nfp: fix schedule in atomic context
when sync mc address") in v6.2-rc3.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc7eab25b1cf3f9594fe61142d3523ce4d14a788]

CVE-2023-54134: autofs: fix memory leak of waitqueues in autofs_catatonic_mode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54134

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [976abbdc120a97049b9133e60fa7b29627d11de4]
cip/4.4-st: [c5ec7cc4c26a7b83c8cadf1e947331ba5b4c0749]
mainline: [ccbe77f7e45dfb4420f7f531b650c00c6e9c7507]
stable/5.10: [69ddafc7a7afd8401bab53eff5af813fa0d368a2]
stable/5.15: [71eeddcad7342292c19042c290c477697acaccab]
stable/6.1: [726deae613bc1b6096ad3b61cc1e63e33330fbc2]

CVE-2023-54135: maple_tree: fix potential out-of-bounds access in
mas_wr_end_piv()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54135

Introduced by commit 54a611b ("Maple Tree: add new data structure") in v6.1-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd00dd2585c4158e81fdfac0bbcc0446afbad26d]
stable/6.1: [4e2ad53ababeaac44d71162650984abfe783960c]

CVE-2023-54136: serial: sprd: Fix DMA buffer leak issue

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54136

Introduced by commit f4487db ("serial: sprd: Add DMA mode support") in v5.2-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd119fdc3ee1450fbf7f78862b5de44c42b6e47f]
stable/5.10: [9a26aaea6c212ea26bab159933dbfd3321a491f6]
stable/5.15: [f34508d934c4f2efb6a85787fc37f42184dabadf]
stable/6.1: [6d209ed70f9c388727995aaece1f930fe63d402b]

CVE-2023-54137: vfio/type1: fix cap_migration information leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54137

Introduced by commit ad72170 ("vfio iommu: Add migration capability to
report supported features") in v5.8-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd24e2a60af633f157d7e59c0a6dba64f131c0b1]
stable/5.10: [ad83d83dd891244de0d07678b257dc976db7c132]
stable/5.15: [13fd667db999bffb557c5de7adb3c14f1713dd51]
stable/6.1: [f6f300ecc196d243c02adeb9ee0c62c677c24bfb]

CVE-2023-54138: drm/msm: fix NULL-deref on irq uninstall

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54138

Introduced by commit f026e43 ("drm/msm: Convert to Linux IRQ
interfaces") in v5.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd459c005de3e2b855a8cc7768e633ce9d018e9f]
stable/5.15: [e2d1cc82ad509c07a9ab0ab4bf88b6613fbf784b]
stable/6.1: [dd8ce825b165acf997689c5ffa45d6a7a1fc0260]

CVE-2023-54139: tracing/user_events: Ensure write index cannot be negative

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54139

Introduced by commit 7f5a08c ("user_events: Add minimal support for
trace_event into ftrace") in v5.18-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd98c93286a30cc4588dfd02453bec63c2f4acf4]
stable/6.1: [0489c2b2c3104b89f078dbcec8c744dfc157d3e9]

CVE-2023-54140: nilfs2: fix WARNING in mark_buffer_dirty due to
discarded buffer reuse

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54140

Introduced by commit 8c26c4e ("nilfs2: fix issue with flush kernel
thread after remount in RO mode because of driver's internal error or
metadata corruption") in v3.10-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d95e403588738c7ec38f52b9f490b15e7745d393]
cip/4.4-st: [06faf373c638c0b58bf3b26814c56a7da94a205c]
mainline: [cdaac8e7e5a059f9b5e816cda257f08d0abffacd]
stable/5.10: [f1d637b63d8a27ac3386f186a694907f2717fc13]
stable/5.15: [b911bef132a06de01a745c6a24172d6db7216333]
stable/6.1: [4da07e958bfda2d69d83db105780e8916e3ac02e]

CVE-2023-54141: wifi: ath11k: Add missing hw_ops->get_ring_selector()
for IPQ5018

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54141

Introduced by commit ba60f27 ("wifi: ath11k: initialize hw_ops for
IPQ5018") in v6.3-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce282d8de71f07f0056ea319541141152c65f552]

CVE-2023-54142: gtp: Fix use-after-free in __gtp_encap_destroy().

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54142

Introduced by commit e198987 ("gtp: fix suspicious RCU usage") in v5.3-rc1.
Fixed in v6.5-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [e5aa6d829831a55a693dbaeb58f8d22ba7f2b3e6]
mainline: [ce3aee7114c575fab32a5e9e939d4bbb3dcca79f]
stable/5.10: [bccc7ace12e69dee4684a3bb4b69737972e570d6]
stable/5.15: [ebd6d2077a083329110695a996c00e8ca94bc640]
stable/6.1: [17d6b6354f0025b7c10a56da783fd0cbb3819c5d]

CVE-2023-54143: media: mediatek: vcodec: fix resource leaks in
vdec_msg_queue_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54143

Introduced by commit b199fe4 ("media: mtk-vcodec: Add msg queue
feature for lat and core architecture") in v5.18-rc1.
Introduced by commit 2f5d0ae ("media: mediatek: vcodec: support
stateless AV1 decoder") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf10b0bb503c974ba049d6f888b21178be20a962]
stable/6.1: [858322c409e0aba8f70810d23f35c482744f007c]

CVE-2023-54144: drm/amdkfd: Fix kernel warning during topology setup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54144

Introduced by commit 0f28cca ("drm/amdkfd: Extend KFD device topology
to surface peer-to-peer links") in v6.0-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf97eb7e47d4671084c7e114c5d88a3d0540ecbd]
stable/6.1: [306888b1246bf44e703b6f1ccc746c2746c1a981]

CVE-2023-54145: bpf: drop unnecessary user-triggerable WARN_ONCE in
verifierl log

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54145

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [cff36398bd4c7d322d424433db437f3c3391c491]
stable/6.1: [40c88c429a598006f91ad7a2b89856cd50b3a008]

CVE-2023-54146: x86/kexec: Fix double-free of elf header buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54146

Introduced by commit b3e34a4 ("x86/kexec: fix memory leak of elf
header buffer") in v5.19-rc1.
Fixed in v6.2-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [d00dd2f2645dca04cf399d8fc692f3f69b6dd996]
stable/5.10: [4c71a552b97fb4f46eb300224434fe56fcf4f254]
stable/5.15: [554a880a1fff46dd5a355dec21cd77d542a0ddf2]
stable/6.1: [5bd3c7abeb69fb4133418b846a1c6dc11313d6f0]

CVE-2023-54147: media: platform: mtk-mdp3: Add missing check and free
for ida_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54147

Introduced by commit 61890cc ("media: platform: mtk-mdp3: add MediaTek
MDP3 driver") in v6.1-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d00f592250782538cda87745607695b0fe27dcd4]
stable/6.1: [51fc1880e47421ee7b192372e8e86b7bbba40776]

CVE-2023-54148: net/mlx5e: Move representor neigh cleanup to profile cleanup_tx

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54148

Introduced by commit 2be5bd4 ("net/mlx5: Handle pairing of E-switch
via uplink un/load APIs") in v6.4-rc4.
Fixed in v6.5-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [d03b6e6f31820b84f7449cca022047f36c42bc3f]
stable/6.1: [d628ba98eb1637acce44001e04c718d8dbb1f7ce]

CVE-2023-54149: net: dsa: avoid suspicious RCU usage for synced
VLAN-aware MAC addresses

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54149

Introduced by commit 64fdc5f ("net: dsa: sync unicast and multicast
addresses for VLAN filters too") in v6.3-rc5.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d06f925f13976ab82167c93467c70a337a0a3cda]

CVE-2023-54150: drm/amd: Fix an out of bounds error in BIOS parser

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54150

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [d116db180decec1b21bba31d2ff495ac4d8e1b83]
stable/5.10: [b8e7589f50b709b647b642531599e70707faf70c]
stable/5.15: [66acfe798cd08b36cfbb65a30fab3159811304a7]
stable/6.1: [5675ecd2e0b00a4318ba1db1a1234e7d45b13d6b]

CVE-2023-54151: f2fs: Fix system crash due to lack of free space in LFS

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54151

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [d11cef14f8146f3babd286c2cc8ca09c166295e2]
stable/6.1: [f4631d295ae3fff9e240ab78dc17f4b83d14f7bc]

CVE-2023-54152: can: j1939: prevent deadlock by moving j1939_sk_errqueue()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54152

Introduced by commit 5b9272e ("can: j1939: extend UAPI to notify about
RX status") in v5.15-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1366b283d94ac4537a4b3a1e8668da4df7ce7e9]
stable/5.15: [8a581b71cf686b4cd1a85c9c2dfc2fb88382c3b4]
stable/6.1: [ace6aa2ab5ba5869563ca689bbd912100514ae7b]

CVE-2023-54153: ext4: turn quotas off if mount failed after enabling quotas

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54153

Introduced by commit 1121563 ("ext4: don't BUG on inconsistent journal
feature") in v5.9-rc2.
Fixed in v6.5-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [d13f99632748462c32fc95d729f5e754bab06064]
stable/5.15: [c327b83c59ee938792a0300df646efac39c7d6a7]
stable/6.1: [deef86fa3005cbb61ae8aa5729324c09b3f4ba73]

CVE-2023-54154: scsi: target: core: Fix target_cmd_counter leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54154

Introduced by commit becd9be ("scsi: target: Move sess cmd counter to
new struct") in v6.4-rc1.
Fixed in v6.6-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [d14e3e553e05cb763964c991fe6acb0a6a1c6f9c]
stable/6.1: [1cd41d1669bcbc5052afa897f85608a62ff3fb30]

CVE-2023-54155: net: core: remove unnecessary frame_sz check in
bpf_xdp_adjust_tail()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54155

Introduced by commit 43b5169 ("net, xdp: Introduce xdp_init_buff
utility routine") in v5.12-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d14eea09edf427fa36bd446f4a3271f99164202f]
stable/5.15: [a09c258cfa77d3ba0a7acc555c73eb6b005c4bd8]
stable/6.1: [20acffcdc2b74fb7dcc4e299f7aca173df89d911]

CVE-2023-54156: sfc: fix crash when reading stats while NIC is resetting

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54156

Introduced by commit d3142c1 ("sfc: refactor EF10 stats handling") in v5.9-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1b355438b8325a486f087e506d412c4e852f37b]
stable/5.10: [cb1aa7cc562cab6a87ea33574c8c65f2d2fd7aeb]
stable/5.15: [91f4ef204e731565afdc6c2a7fcf509a3fd6fd67]
stable/6.1: [446f5567934331923d0aec4ce045e4ecb0174aae]

CVE-2023-54157: binder: fix UAF of alloc->vma in race with munmap()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54157

Introduced by commit c0fd210 ("Revert "android: binder: stop saving a
pointer to the VMA"") in v6.4-rc4.
Introduced by commit dd2283f ("mm: mmap: zap pages with read mmap_sem
in munmap") in v4.20-rc1.
Fixed in v6.4-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [d1d8875c8c13517f6fd1ff8d4d3e1ac366a17e07]
stable/5.15: [1bb8a65190d45cd5c7dbc85e29b9102110cd6be6]
stable/6.1: [931ea1ed31be939c1efdbc49bc66d2a45684f9b4]

CVE-2023-54158: btrfs: don't free qgroup space unless specified

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54158

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
mainline: [d246331b78cbef86237f9c22389205bc9b4e1cc1]
stable/5.10: [148b16cd30b202999ec5b534e3e5d8ab4b766f21]
stable/5.15: [f264be24146bee2d652010a18ae2517df5856261]
stable/6.1: [15e877e5923ec6d6caa5e447dcc4b79a8ff7cc53]

CVE-2023-54159: usb: mtu3: fix kernel panic at qmu transfer done irq handler

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54159

Introduced by commit 48e0d37 ("usb: mtu3: supports new QMU format") in v5.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d28f4091ea7ec3510fd6a3c6d433234e7a2bef14]
stable/5.10: [012936502a9cb7b0604e85bb961eb15e2bb40dd9]
stable/5.15: [ee53a7a88027cea765c68f3b00a50b8f58d6f786]
stable/6.1: [f26273428657ef4ca74740e578ae45a3be492f6f]

CVE-2023-54160: firmware: arm_sdei: Fix sleep from invalid context BUG

Announce: https://www.cve.org/CVERecord?id=CVE-2023-54160

Introduced commit is not determined.Fixed in v6.4-rc1.
The arm_sdei.c was added by ad6eb31 ("firmware: arm_sdei: Add driver
for Software Delegated Exceptions") in v4.16-rc1.

Fixed status
cip/4.19-st: [59842a9ba27d5390ae5bf3233a92cad3a26d495c]
mainline: [d2c48b2387eb89e0bf2a2e06e30987cf410acad4]
stable/5.10: [7d8f5ccc826b39e05ff252b1fccd808c7a0725e0]
stable/5.15: [66caf22787714c925e755719c293aaf3cb0b873b]
stable/6.1: [a8267bc8de736cae927165191b52fbc20d101dd1]

CVE-2023-54161: af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Announce: no reference



Bug introduced commit is not backported to older stable kernels.

Fixed status
stable/5.15: [d39fc9b94dc0719afa4bc8e58341a5eb41febef3]

CVE-2025-68344: ALSA: wavefront: Fix integer overflow in sample size validation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68344

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c4a13ba88594fd4a27292853e736c6b4349823d]
stable/6.12: [5588b7c86effffa9bb55383a38800649d7b40778]

CVE-2025-68345: ALSA: hda: cs35l41: Fix NULL pointer dereference in
cs35l41_hda_read_acpi()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68345

Introduced by commit 7b2f3eb ("ALSA: hda: cs35l41: Add support for
CS35L41 in HDA systems") in v5.17-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c34b04cc6178f33c08331568c7fd25c5b9a39f66]

CVE-2025-68346: ALSA: dice: fix buffer overflow in detect_stream_formats()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68346

Introduced by commit 58579c0 ("ALSA: dice: use extended protocol to
detect available stream formats") in v4.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [324f3e03e8a85931ce0880654e3c3eb38b0f0bba]
stable/6.12: [c0a1fe1902ad23e6d48e0f68be1258ccf7a163e6]

CVE-2025-68347: ALSA: firewire-motu: fix buffer overflow in hwdep read
for DSP events

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68347

Introduced by commit 634ec0b ("ALSA: firewire-motu: notify event for
parameter change in register DSP model") in v5.16-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [210d77cca3d0494ed30a5c628b20c1d95fa04fb1]
stable/6.12: [6275fd726d53a8ec724f20201cf3bd862711e17b]

CVE-2025-68348: block: fix memory leak in __blkdev_issue_zero_pages

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68348

Introduced by commit bf86bcd ("blk-lib: check for kill signal in ioctl
BLKZEROOUT") in v6.11-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7e3f852a42d7cd8f1af2c330d9d153e30c8adcf]
stable/6.12: [453e4b0c84d0db1454ff0adf655d91179e6fca3a]

CVE-2025-68349: NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in
pnfs_mark_layout_stateid_invalid

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68349

Introduced by commit fe1cf94 ("pNFS: Clear all layout segment state in
pnfs_mark_layout_stateid_invalid") in v4.10-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0f8058f2cb56de0b7572f51cd563ca5debce746]
stable/6.12: [59947dff0fb7c19c09ce6dccbcd253fd542b6c25]

CVE-2025-68350: exfat: fix divide-by-zero in exfat_allocate_bitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68350

Introduced by commit 9fd6886 ("exfat: optimize allocation bitmap
loading time") in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d70a5804c563b5e34825353ba9927509df709651]

CVE-2025-68351: exfat: fix refcount leak in exfat_find

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68351

Introduced by commit 82ebecd ("exfat: fix improper check of
dentry.stream.valid_size") in v6.18-rc2.
Introduced by commit 13940ce ("exfat: add a check for invalid data
size") in v6.14-rc6.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [9aee8de970f18c2aaaa348e3de86c38e2d956c1d]

CVE-2025-68352: spi: ch341: fix out-of-bounds memory access in
ch341_transfer_one

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68352

Introduced by commit 8846739 ("spi: add ch341a usb2spi driver") in v6.11-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [545d1287e40a55242f6ab68bcc1ba3b74088b1bc]
stable/6.12: [cad6c0fd6f3c0e76a1f75df4bce3b08a13f08974]

CVE-2025-68353: net: vxlan: prevent NULL deref in vxlan_xmit_one

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68353

Introduced by commit 6f19b2c ("vxlan: use generic function for tunnel
IPv4 route lookup") in v6.7-rc1.
Introduced by commit 2aceb89 ("vxlan: use generic function for tunnel
IPv6 route lookup") in v6.7-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f73a56f986005f0bc64ed23873930e2ee4f5911]

CVE-2025-68354: regulator: core: Protect regulator_supply_alias_list
with regulator_list_mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68354

Introduced by commit a06ccd9 ("regulator: core: Add ability to create
a lookup alias for supply") in v3.13-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cc15a10c3b4ab14cd71b779fd5c9ca0cb2bc30d]
stable/6.12: [a9864d42ebcdd394ebb864643b961b36e7b515be]

CVE-2025-68355: bpf: Fix exclusive map memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68355

Introduced by commit baefdbd ("bpf: Implement exclusive map creation")
in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [688b745401ab16e2e1a3b504863f0a45fd345638]

CVE-2025-68356: gfs2: Prevent recursive memory reclaim

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68356

Introduced by commit dc0b943 ("gfs: Don't use GFP_NOFS in
gfs2_unstuff_dinode") in v6.6-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c5f4a53476e3cab70adc77b38942c066bd2c17c]
stable/6.12: [edb2b255618621dc83d0ec23150e16b2c697077f]

CVE-2025-68357: iomap: allocate s_dio_done_wq for async reads as well

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68357

Introduced commit is not determined.Fixed in v6.19-rc1.
Affected file was added by db07443 ("iomap: move the direct IO code
into a separate file") in v5.3-rc1.

Fixed status
mainline: [7fd8720dff2d9c70cf5a1a13b7513af01952ec02]

CVE-2025-68358: btrfs: fix racy bitfield write in btrfs_clear_space_info_full()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68358

Introduced by commit 957780e ("Btrfs: introduce ticketed enospc
infrastructure") in v4.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38e818718c5e04961eea0fa8feff3f100ce40408]

CVE-2025-68359: btrfs: fix double free of qgroup record after failure
to add delayed ref head

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68359

Introduced by commit 6ef8fbc ("btrfs: fix missing error handling when
adding delayed ref with qgroups enabled") in v6.12-rc3.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [725e46298876a2cc1f1c3fb22ba69d29102c3ddf]

CVE-2025-68360: wifi: mt76: wed: use proper wed reference in mt76 wed
driver callabacks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68360

Introduced by commit 83eafc9 ("wifi: mt76: mt7996: add wed tx
support") in v6.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [385aab8fccd7a8746b9f1a17f3c1e38498a14bc7]

CVE-2025-68361: erofs: limit the level of fs stacking for file-backed mounts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68361

Introduced by commit fb17675 ("erofs: add file-backed mount support")
in v6.12-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d53cd891f0e4311889349fff3a784dc552f814b9]
stable/6.12: [34447aeedbaea8f9aad3da5b07030a1c0e124639]

CVE-2025-68362: wifi: rtl818x: rtl8187: Fix potential buffer underflow
in rtl8187_rx_cb()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68362

Introduced by commit 6f7853f ("rtl8187: change rtl8187_dev.c to
support RTL8187B (part 2)") in v2.6.27-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b647d2574e4583c2e3b0ab35568f60c88e910840]
stable/6.12: [4758770a673c60d8f615809304d72e1432fa6355]

CVE-2025-68363: bpf: Check skb->transport_header is set in bpf_skb_check_mtu

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68363

Introduced by commit 34b2021 ("bpf: Add BPF-helper for MTU checking")
in v5.12-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d946f3c98328171fa50ddb908593cf833587f725]
stable/6.12: [30ce906557a21adef4cba5901c8e995dc18263a9]

CVE-2025-68364: ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_extent()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68364

Introduced by commit 8f603e5 ("Ocfs2/move_extents: move a range of
extent.") in v3.0-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a7d58845fae061c62b50bc5eeb9bae4a1dedc3d]
stable/6.12: [e5c2503696ec2e0dc7b2aee902dc859ccde39ddf]

CVE-2025-68365: fs/ntfs3: Initialize allocated memory before use

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68365

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Introduced by commit 78ab59f ("fs/ntfs3: Rework file operations") in v5.15-rc1.
Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Introduced by commit 78ab59f ("fs/ntfs3: Rework file operations") in v5.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8a3ca23bbd9d849308a7921a049330dc6c91398]

CVE-2025-68366: nbd: defer config unlock in nbd_genl_connect

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68366

Introduced by commit e46c728 ("nbd: add a basic netlink interface") in
v4.12-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1649714b930f9ea6233ce0810ba885999da3b5d4]
stable/6.12: [c9b99c948b4fb014812afe7b5ccf2db121d22e46]

CVE-2025-68367: macintosh/mac_hid: fix race condition in mac_hid_toggle_emumouse

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68367

Introduced by commit 99b089c ("Input: Mac button emulation - implement
as an input filter") in v2.6.34-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e4b207ffe54cf33a4b7a2912c4110f89c73bf3f]
stable/6.12: [230621ffdb361d15cd3ef92d8b4fa8d314f4fad4]

CVE-2025-68368: md: init bioset in mddev_init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68368

Introduced by commit d981ed8 ("md: Add new_level sysfs interface") in v6.12-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [381a3ce1c0ffed647c9b913e142b099c7e9d5afc]

CVE-2025-68369: ntfs3: init run lock for extend inode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68369

Introduced by commit 4e8011f ("ntfs3: pretend $Extend records as
regular files") in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [be99c62ac7e7af514e4b13f83c891a3cccefaa48]
stable/6.12: [6e17555728bc469d484c59db4a0abc65c19bc315]

CVE-2025-68370: coresight: tmc: add the handle of the event to the path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68370

Introduced by commit 080ee83 ("Coresight: Change functions to accept
the coresight_path") in v6.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aaa5abcc9d44d2c8484f779ab46d242d774cabcb]

CVE-2025-68371: scsi: smartpqi: Fix device resources accessed after
device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68371

Introduced by commit 2d80f40 ("scsi: smartpqi: Update deleting a LUN
via sysfs") in v6.0-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b518e86d1a70a88f6592a7c396cf1b93493d1aab]
stable/6.12: [eccc02ba1747501d92bb2049e3ce378ba372f641]

CVE-2025-68372: nbd: defer config put in recv_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68372

Introduced by commit 87aac3a ("nbd: make the config put is called
before the notifying the waiter") in v5.10-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [9517b82d8d422d426a988b213fdd45c6b417b86d]
stable/6.12: [6b69593f72e1bfba6ca47ca8d9b619341fded7d6]

CVE-2025-68373: md: avoid repeated calls to del_gendisk

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68373

Introduced by commit 9e59d60 ("md: call del_gendisk in control path")
in v6.17-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90e3bb44c0a86e245d8e5c6520206fa113acb1ee]

CVE-2025-68374: md: fix rcu protection in md_wakeup_thread

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68374

Introduced by commit 4469315 ("md: protect md_thread with rcu") in v6.5-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0dc76205549b4c25705e54345f211b9f66e018a0]
stable/6.12: [21989cb5034c835b212385a2afadf279d8069da0]

CVE-2025-68375: perf/x86: Fix NULL event access and potential PEBS record loss

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68375

Introduced by commit 9734e25 ("perf: Fix the throttle logic for a
group") in v6.16-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e772a93eb61cb6265bdd1c5bde17d0f2718b452]

CVE-2025-68376: coresight: ETR: Fix ETR buffer use-after-free issue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68376

Introduced by commit bd2767e ("coresight: Fix run time warnings while
reusing ETR buffer") in v6.6-rc6.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35501ac3c7d40a7bb9568c2f89d6b56beaf9bed3]

CVE-2025-68377: ns: initialize ns_list_node for initial namespaces

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68377

Introduced by commit 885fc8a ("nstree: make iterator generic") in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dd50c58664e2684bd610a57bf3ab713cbb0ea91]

CVE-2025-68378: bpf: Fix stackmap overflow check in __bpf_get_stackid()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68378

Introduced by commit ee2a098 ("bpf: Adjust BPF stack helper functions
to accommodate skip > 0") in v5.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [23f852daa4bab4d579110e034e4d513f7d490846]
stable/6.12: [d1f424a77b6bd27b361737ed73df49a0158f1590]

CVE-2025-68379: RDMA/rxe: Fix null deref on srq->rq.queue after resize failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68379

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [503a5e4690ae14c18570141bc0dcf7501a8419b0]
stable/6.12: [b8f6eeb87a76b6fb1f6381b0b2894568e1b784f7]

CVE-2025-68380: wifi: ath11k: fix peer HE MCS assignment

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68380

Introduced by commit 61fe43e ("ath11k: add support for setting fixed
HE rate/gi/ltf") in v5.16-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a013ca2d490c73c40588d62712ffaa432046a04]
stable/6.12: [097c870b91817779e5a312c6539099a884b1fe2b]

CVE-2025-68724: crypto: asymmetric_keys - prevent overflow in
asymmetric_key_generate_id

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68724

Introduced by commit 7901c1a ("KEYS: Implement binary asymmetric key
ID handling") in v3.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df0845cf447ae1556c3440b8b155de0926cbaa56]
stable/6.12: [c73be4f51eed98fa0c7c189db8f279e1c86bfbf7]

CVE-2025-68725: bpf: Do not let BPF test infra emit invalid GSO types to stack

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68725

Introduced by commit 850a88c ("bpf: Expose __sk_buff wire_len/gso_segs
to BPF_PROG_TEST_RUN") in v5.6-rc1.
Introduced by commit cf62089 ("bpf: Add gso_size to __sk_buff") in v5.7-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04a899573fb87273a656f178b5f920c505f68875]

CVE-2025-68726: crypto: aead - Fix reqsize handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68726

Introduced by commit afddce1 ("crypto: api - Add reqsize to
crypto_alg") in v6.16-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b04d8f00569573796dd05397f5779135593eb24]

CVE-2025-68727: ntfs3: Fix uninit buffer allocated by __getname()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68727

Introduced by commit 78ab59f ("fs/ntfs3: Rework file operations") in v5.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9948dcb2f7b5a1bf8e8710eafaf6016e00be3ad6]
stable/6.12: [4b1fd82848fdf0e01b3320815b261006c1722c3e]

CVE-2025-68728: ntfs3: fix uninit memory after failed mi_read in mi_format_new

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68728

Introduced by commit 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73e6b9dacf72a1e7a4265eacca46f8f33e0997d6]
stable/6.12: [7ce8f2028dfccb2161b905cf8ab85cdd9e93909c]

CVE-2025-68729: wifi: ath12k: Fix MSDU buffer types handling in RX error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68729

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36f9edbb9d0fc36c865c74f3c1ad8e1261ad3981]

CVE-2025-68730: accel/ivpu: Fix page fault in
ivpu_bo_unbind_all_bos_from_context()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68730

Introduced by commit 8d88e4c ("accel/ivpu: Use GEM shmem helper for
all buffers") in v6.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b694b405a84696f1d964f6da7cf9721e68c4714]

CVE-2025-68731: accel/amdxdna: Fix an integer overflow in
aie2_query_ctx_status_array()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68731

Introduced by commit 2f509fe ("accel/amdxdna: Add ioctl
DRM_IOCTL_AMDXDNA_GET_ARRAY") in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e16c8bf9aebf629344cfd4cd5e3dc7d8c3f7d82]

CVE-2025-68732: gpu: host1x: Fix race in syncpt alloc/free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68732

Introduced by commit f5ba33f ("gpu: host1x: Reserve VBLANK syncpoints
at initialization") in v5.13-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7d393267c497502fa737607f435f05dfe6e3d9b]
stable/6.12: [4e6e07ce0197aecfb6c4a62862acc93b3efedeb7]

CVE-2025-68733: smack: fix bug: unprivileged task can create labels

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68733

Introduced by commit 38416e5 ("Smack: limited capability for changing
process label") in v4.4-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c147e13ea7fe9f118f8c9ba5e96cbd644b00d6b3]
stable/6.12: [ac9fce2efabad37c338aac86fbe100f77a080e59]

CVE-2025-68734: isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68734

Introduced by commit 69f52ad ("mISDN: Add HFC USB driver") in v2.6.29-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f978e3f1570155a1327ffa25f60968bc7b9398f]
stable/5.10: [adb7577e23a431fc53aa1b6107733c0d751015fb]
stable/5.15: [b70c24827e11fdc71465f9207e974526fb457bb9]
stable/6.1: [3f7c72bc73c4e542fde14cce017549d8a0b61a3c]
stable/6.12: [6dce43433e0635e7b00346bc937b69ce48ea71bb]
stable/6.6: [03695541b3349bc40bf5d6563d44d6147fb20260]

CVE-2025-68735: drm/panthor: Prevent potential UAF in group creation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68735

Introduced by commit de85488 ("drm/panthor: Add the scheduler logical
block") in v6.10-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eec7e23d848d2194dd8791fcd0f4a54d4378eecd]

CVE-2025-68736: landlock: Fix handling of disconnected directories

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68736

Introduced by commit b91c3e4 ("landlock: Add support for file
reparenting with LANDLOCK_ACCESS_FS_REFER") in v5.19-rc1.
Introduced by commit cb2c7d1 ("landlock: Support filesystem
access-control") in v5.13-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49c9e09d961025b22e61ef9ad56aa1c21b6ce2f1]

CVE-2025-68737: arm64/pageattr: Propagate return value from
__change_memory_common

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68737

Introduced by commit a166563 ("arm64: mm: support large block mapping
when rodata=full") in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5efd56fa157d2e7d789949d1d64eccbac18a897]

CVE-2025-68738: wifi: mt76: mt7996: fix null pointer deref in mt7996_conf_tx()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68738

Introduced by commit c0df2f0 ("wifi: mt76: mt7996: prepare
mt7996_mcu_set_tx for MLO support") in v6.14-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79277f8ad15ec5f255ed0e1427c7a8a3e94e7f52]

CVE-2025-68739: PM / devfreq: hisi: Fix potential UAF in OPP handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68739

Introduced by commit 7da2fda ("PM / devfreq: Add HiSilicon uncore
frequency scaling driver") in v6.17-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26dd44a40096468396b6438985d8e44e0743f64c]

CVE-2025-68740: ima: Handle error code returned by ima_filter_rule_match()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68740

Introduced by commit 4af4662 ("integrity: IMA policy") in v2.6.30-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [738c9738e690f5cea24a3ad6fd2d9a323cf614f6]
stable/6.12: [c2238d487a640ae3511e1b6f4640ab27ce10d7f6]

CVE-2025-68741: scsi: qla2xxx: Fix improper freeing of purex item

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68741

Introduced by commit 875386b ("scsi: qla2xxx: Add Unsolicited LS
Request and Response Support for NVMe") in v6.6-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78b1a242fe612a755f2158fd206ee6bb577d18ca]
stable/6.12: [8e9f0a0717ba31d5842721627ade1e62d7aec012]

CVE-2025-68742: bpf: Fix invalid prog->stats access when
update_effective_progs fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68742

Introduced by commit 492ecee ("bpf: enable program stats") in v5.1-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dc211c1159d991db609bdf4b0fb9033c04adcbc]
stable/6.12: [539137e3038ce6f953efd72110110f03c14c7d97]

CVE-2025-68743: mshv: Fix create memory region overlap check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68743

Introduced by commit 621191d ("Drivers: hv: Introduce mshv_root module
to expose /dev/mshv to VMMs") in v6.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba9eb9b86d232854e983203dc2fb1ba18e316681]

CVE-2025-68744: bpf: Free special fields when update [lru_,]percpu_hash maps

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68744

Introduced by commit 65334e6 ("bpf: Support kptrs in percpu hashmap
and percpu LRU hashmap") in v6.4-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6af6e49a76c9af7d42eb923703e7648cb2bf401a]
stable/6.12: [3bf1378747e251571e0de15e7e0a6bf2919044e7]

CVE-2025-68745: scsi: qla2xxx: Clear cmds after chip reset

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68745

Introduced by commit aefed3e ("scsi: qla2xxx: target: Fix offline port
handling and host reset handling") in v5.2-rc1.
Introduced by commit 26f9ce5 ("scsi: qla2xxx: Fix missed DMA unmap for
aborted commands") in v5.18-rc7.
Fixed in v6.19-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [d46c69a087aa3d1513f7a78f871b80251ea0c1ae]

CVE-2025-68746: spi: tegra210-quad: Fix timeout handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68746

Introduced by commit 921fc18 ("spi: tegra210-quad: Add support for
Tegra210 QSPI controller") in v5.12-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4e002d8a7cee3b1d70efad0e222567f92a73000]
stable/6.12: [551060efb156c50fe33799038ba8145418cfdeef]

CVE-2025-68747: drm/panthor: Fix UAF on kernel BO VA nodes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68747

Introduced by commit 8a1cc07 ("drm/panthor: Add GEM logical block") in
v6.10-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98dd5143447af0ee33551776d8b2560c35d0bc4a]
stable/6.12: [5a0060ddfc1fcfdb0f7b4fa1b7b3b0c436151391]

CVE-2025-68748: drm/panthor: Fix UAF race between device unplug and FW
event processing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68748

Introduced by commit de85488 ("drm/panthor: Add the scheduler logical
block") in v6.10-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7051f6ba968fa69918d72cc26de4d6cf7ea05b90]
stable/6.12: [31db188355a49337e3e8ec98b99377e482eab22c]

CVE-2025-68749: accel/ivpu: Fix race condition when unbinding BOs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68749

Introduced by commit 48aea7f ("accel/ivpu: Fix locking in
ivpu_bo_remove_all_bos_from_context()") in v6.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00812636df370bedf4e44a0c81b86ea96bca8628]

CVE-2025-68750: usb: potential integer overflow in usbg_make_tpg()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68750

Introduced commit is not determined.Fixed in v6.16-rc1.


Fixed status
cip/4.19-st: [e42837983357947e726df63e81915bfe578b0944]
mainline: [153874010354d050f62f8ae25cbb960c17633dc5]
stable/5.10: [603a83e5fee38a950bfcfb2f36449311fa00a474]
stable/5.15: [6f77e344515b5258edb3988188311464209b1c7c]
stable/6.1: [6722e080b5b39ab7471386c73d0c1b39572f943c]
stable/6.12: [358d5ba08f1609c34a054aed88c431844d09705a]
stable/6.6: [a33f507f36d5881f602dab581ab0f8d22b49762c]


* Updated CVEs

CVE-2024-35974: block: fix q->blkg_list corruption during disk rebind

stable/6.1 was fixed.

Fixed status
stable/6.1: [b5dae1cd0d8368b4338430ff93403df67f0b8bcc]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

