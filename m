Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED62C83F10
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 23:00:08 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web10.360.1752102005035332415
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Jul 2025 16:00:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=gpDnnyLk;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.179, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e1d8c2dc2so4315367b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 09 Jul 2025 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1752102004; x=1752706804; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EkR8QLt+FWqj3lepyX/wxO/UJuf4SfBsnxLIsC2Cmrk=;
        b=gpDnnyLkhbhnhKQfNa1/k05x+uBy4Aop61dfxoIpxr6rU35XR0KHuSgT5tFfvqlzmn
         eOSpxz1JhPBceEOVFHFiVoTFzm0xjSFGXfjAu9/n33AGzPLMT9cmmHTMfy/K295nS8SL
         k/6P+xMph+tWyTxYU8QD9rdeu/4IQ4UMfJHQvYYywmQ3EeTh4EPEsWEhZlwIRQsanaTC
         crUcS4Vd/ZwHW0NJlZMyGZ9kjmF1yXjlZPBJs3Me2lvxjSF0k28lK7MdA6UXHc8LWk1r
         p9lfp+cS4/iit6uWpr364XHmGSFkfmAru0oFRzZMNxzs1zZXVW1rnqOjoH+xmZA7NHF1
         qpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102004; x=1752706804;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkR8QLt+FWqj3lepyX/wxO/UJuf4SfBsnxLIsC2Cmrk=;
        b=ZelNaVMwuQSHJVpNiGqCzf1T2/91VoekH5LjNg0S1M7TTMpTsr3S+861srLJFZOFqh
         ln/vOES9WDar06woyfMxnKx8kVGV5huccENPyOToH0C18gAy3cKOR0JLIvlnny/F93dI
         jOCCX5b24oKZ9Fv7YvV47IdQ3IsUXP+gXXvEMsu1wcuuSxzA7nyycj51FyCpBXvHnP/E
         w1dXQxbfoUPqhLG1fw6pmKuM2+Gvn7z7+ML7U3PPpVnachsYLLw8haVPQs0vfnFt8fqM
         bmvAeAaXVW7a5UaSNUUEfGc65UQMQCIkILk0RvHtc5XYtonoY3KYU/0Fua5JZ6ICB7uz
         fkdg==
X-Gm-Message-State: AOJu0Yzm8mjdK9EXjfSr6UH6Hzba+r84QlMTCKg5uFEDuH77NbX5MfuQ
	SJbcNfL0YYpBW48Cip3/NDZtf1XsJPMc9SZ/E+5XqdrEmWWGKcPX6yO+l3YpuDoXraQYVRoKWwt
	E7m9Rc77i5bp6/eSib3iyKRBWxH+g+Mhxt2wjcVGb7w3eQ9PL+svhrPI=
X-Gm-Gg: ASbGncuqvgLQm5bHRvRWD5fGHy42sAcRxpX86PJBqLKZSbgIV15IiOVLS38+moOYcgu
	KW+Lo6COqkWo8my+MheGHpQy5iCNgSPupZTXBO/9/UZXGmRFGjA4G8uEW6nontxF34jbdv2iGJF
	UzNo0c3X4C2/QA1K2l0A4+rxg2bRn7RNFCEXj48v80ATOv
X-Google-Smtp-Source: AGHT+IE1d4P+Dtrel6fDKx0jD0cjvDWzRAujem6C72q3Yrvac9dip+BFnTOeVLBligVUleTsuW6YV+hSATX8Mz+l1cM=
X-Received: by 2002:a05:690c:6807:b0:70e:2ced:6f5f with SMTP id
 00721157ae682-717c47f9134mr9644437b3.37.1752102001531; Wed, 09 Jul 2025
 16:00:01 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Jul 2025 07:59:25 +0900
X-Gm-Features: Ac12FXzRPUVOE9WQef3S0snXlj_-b4o6H1vO5KtxNvl_OtRTH8ed9CCelnBTzIo
Message-ID: <CAODzB9qwO9i==Xa9ZQ3qi8RqKSLcWs9KdK5qGqOHZYPuECVq7w@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Jul 2025 23:00:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19390

Hi!

It's this week's CVE report.

This week reported 170 new CVEs and 9 updated CVEs.

* New CVEs
CVE-2025-38094: net: cadence: macb: Fix a possible deadlock in macb_halt_tx.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38094

Introduced by commit e86cd53 ("net/macb: better manage tx errors") in v3.8-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c92d6089d8ad7d4d815ebcedee3f3907b539ff1f]
stable/5.10: [0772a608d799ac0d127c0a36047a2725777aba9d]
stable/5.15: [64675a9c00443b2e8af42af08c38fc1b78b68ba2]
stable/6.1: [aace6b63892ce8307e502a60fe2f5a4bc6e1cfe7]
stable/6.12: [3e64d35475aa21d13dab71da51de51923c1a3a48]
stable/6.6: [1d60c0781c1bbeaa1196b0d8aad5c435f06cb7c4]

CVE-2025-38095: dma-buf: insert memory barrier before updating num_fences

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38095

Introduced by commit a590d0f ("dma-buf: Update reservation
shared_count after adding the new fence") in v5.0-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72c7d62583ebce7baeb61acce6057c361f73be4a]
stable/6.1: [3becc659f9cb76b481ad1fb71f54d5c8d6332d3f]
stable/6.12: [fe1bebd0edb22e3536cbc920ec713331d1367ad4]
stable/6.6: [c9d2b9a80d06a58f37e0dc8c827075639b443927]

CVE-2025-38096: wifi: iwlwifi: don't warn when if there is a FW error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38096

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Vulnerable function was added by 0d91a2b ("wifi: iwlwifi: remove
struct iwl_trans_ops")
in 6.11-rc1.

Fixed status
mainline: [c7f50d0433a016d43681592836a3d484817bfb34]
stable/6.12: [0446d34a853d9576e2a7628c803d2abd2f8cf3a8]

CVE-2025-38097: espintcp: remove encap socket caching to avoid reference leak

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38097

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [028363685bd0b7a19b4a820f82dd905b1dc83999]
stable/6.1: [e4cde54b46a87231c77256a633be1bef62687d69]
stable/6.12: [9cbca30102028f9ad3d2098f935c4368f581fd07]
stable/6.6: [b58a295d10065960bcb9d60cb8ca6ead9837cd27]

CVE-2025-38098: drm/amd/display: Don't treat wb connector as physical
in create_validate_stream_for_sink

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38098

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Vulnerable function was added by cbd14ae ("drm/amd/display: Fix incorrectly
pruned modes with deep color") in 5.8-rc1.

Fixed status
mainline: [cbf4890c6f28fb1ad733e14613fbd33c2004bced]
stable/6.12: [b14e726d57f61085485f107a6203c50a09695abd]

CVE-2025-38099: Bluetooth: Disable SCO support if READ_VOICE_SETTING
is unsupported/broken

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38099

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [14d17c78a4b1660c443bae9d38c814edea506f62]
stable/6.12: [f48ee562c095e552a30b8d9cc0566a267b410f8a]

CVE-2025-38100: x86/iopl: Cure TIF_IO_BITMAP inconsistencies

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38100

Introduced by commit ea5f1cd ("x86/ioperm: Remove bitmap if all
permissions dropped") in v5.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b68e978718f14fdcb080c2a7791c52a0d09bc6d]
stable/5.10: [d64b7b05a827f98d068f412969eef65489b0cf03]
stable/5.15: [2dace5e016c991424a3dc6e83b1ae5dca8992d08]
stable/6.1: [aa5ce1485562f20235b4c759eee5ab0c41d2c220]
stable/6.12: [b3b3b6366dc8eb5b22edba9adc4bff3cdacfd64c]
stable/6.6: [2cfcbe1554c119402e7382de974c26b0549899fe]

CVE-2025-38101: ring-buffer: Fix buffer locking in
ring_buffer_subbuf_order_set()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38101

Introduced by commit f9b94da ("ring-buffer: Set new size of the ring
buffer sub page") in v6.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40ee2afafc1d9fe3aa44a6fbe440d78a5c96a72e]
stable/6.12: [e09c0600beea469b3ebf974464e526a02d59ad62]

CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and
vmci_ctx_unset_notify

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38102

Introduced by commit a1d8843 ("VMCI: Fix two UVA mapping bugs") in v4.0-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bd6406fb5f36c2bb1e96e27d4c3e9f4d09edde4]
stable/5.15: [b4209e4b778e4e57d0636e1c9fc07a924dbc6043]
stable/6.1: [58a90db70aa6616411e5f69d1982d9b1dd97d774]
stable/6.12: [00ddc7dad55b7bbb78df80d6e174d0c4764dea0c]
stable/6.6: [6e3af836805ed1d7a699f76ec798626198917aa4]

CVE-2025-38103: HID: usbhid: Eliminate recurrent out-of-bounds bug in
usbhid_parse()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38103

Introduced by commit f043bfc ("HID: usbhid: fix out-of-bounds bug") in
v4.14-rc5.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [fe7f7ac8e0c708446ff017453add769ffc15deed]
stable/5.10: [41827a2dbdd7880df9881506dee13bc88d4230bb]
stable/5.15: [1df80d748f984290c895e843401824215dcfbfb0]
stable/5.4: [7a6d6b68db128da2078ccd9a751dfa3f75c9cf5b]
stable/6.1: [a8f842534807985d3a676006d140541b87044345]
stable/6.12: [74388368927e9c52a69524af5bbd6c55eb4690de]
stable/6.6: [4fa7831cf0ac71a0a345369d1a6084f2b096e55e]

CVE-2025-38105: ALSA: usb-audio: Kill timer properly at removal

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38105

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [0718a78f6a9f04b88d0dc9616cc216b31c5f3cf1]

CVE-2025-38106: io_uring: fix use-after-free of sq->thread in
__io_uring_show_fdinfo()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38106

Introduced by commit 3fcb9d1 ("io_uring/sqpoll: statistics of the true
utilization of sq threads") in v6.9-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac0b8b327a5677dc6fecdf353d808161525b1ff0]
stable/6.12: [af8c13f9ee040b9a287ba246cf0055f7c77b7cc8]

CVE-2025-38107: net_sched: ets: fix a race in ets_qdisc_change()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38107

Introduced by commit b05972f ("net: sched: tbf: don't call qdisc_put()
while holding tree lock") in v6.0-rc4.
Fixed in v6.16-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [d92adacdd8c2960be856e0b82acc5b7c5395fddb]
stable/5.10: [eb7b74e9754e1ba2088f914ad1f57a778b11894b]
stable/5.15: [0b479d0aa488cb478eb2e1d8868be946ac8afb4f]
stable/6.1: [347867cb424edae5fec1622712c8dd0a2c42918f]
stable/6.12: [073f64c03516bcfaf790f8edc772e0cfb8a84ec3]
stable/6.6: [0383b25488a545be168744336847549d4a2d3d6c]

CVE-2025-38108: net_sched: red: fix a race in __red_change()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38108

Introduced by commit 0c8d13a ("net: sched: red: delay destroying child
qdisc on replace") in v5.0-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85a3e0ede38450ea3053b8c45d28cf55208409b8]
stable/5.10: [a1bf6a4e9264a685b0e642994031f9c5aad72414]
stable/5.15: [110a47efcf23438ff8d31dbd9c854fae2a48bf98]
stable/5.4: [2790c4ec481be45a80948d059cd7c9a06bc37493]
stable/6.1: [f569984417a4e12c67366e69bdcb752970de921d]
stable/6.12: [4b755305b2b0618e857fdadb499365b5f2e478d1]
stable/6.6: [2a71924ca4af59ffc00f0444732b6cd54b153d0e]

CVE-2025-38109: net/mlx5: Fix ECVF vports unload on shutdown flow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38109

Introduced by commit a7719b2 ("net/mlx5: Add management of EC VF
vports") in v6.5-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [687560d8a9a2d654829ad0da1ec24242f1de711d]
stable/6.12: [da15ca0553325acf68039015f2f4db750c8e2b96]
stable/6.6: [5953ae44dfe5dbad374318875be834c3b7b71ee6]

CVE-2025-38110: net/mdiobus: Fix potential out-of-bounds clause 45
read/write access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38110

Introduced by commit 4e4aafc ("net: mdio: Add dedicated C45 API to
MDIO bus drivers") in v6.3-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [260388f79e94fb3026c419a208ece8358bb7b555]
stable/6.12: [31bf7b2b92563a352788cf9df3698682f659bacc]
stable/6.6: [abb0605ca00979a49572a6516f6db22c3dc57223]

CVE-2025-38111: net/mdiobus: Fix potential out-of-bounds read/write access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38111

Introduced by commit 080bb35 ("net: phy: Maintain MDIO device and bus
statistics") in v5.6-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e629694126ca388916f059453a1c36adde219c4]
stable/5.10: [19c5875e26c4ed5686d82a7d8f7051385461b9eb]
stable/5.15: [014ad9210373d2104f6ef10e6bb999a7a0a4c50e]
stable/5.4: [ff70bd8ff44fcfb0a3c84b054eca7bcb7d958839]
stable/6.1: [73d478234a619f3476028cb02dee699c30ae8262]
stable/6.12: [b02d9d2732483e670bc34cb233d28e1d43b15da4]
stable/6.6: [bab6bca0834cbb5be2a7cfe59ec6ad016ec72608]

CVE-2025-38112: net: Fix TOCTOU issue in sk_is_readable()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38112

Introduced by commit 8934ce2 ("bpf: sockmap redirect ingress support")
in v4.17-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2660a544fdc0940bba15f70508a46cf9a6491230]
stable/5.10: [c2b26638476baee154920bb587fc94ff1bf04336]
stable/5.15: [6fa68d7eab34d448a61aa24ea31e68b3231ed20d]
stable/6.1: [8926a7ef1977a832dd6bf702f1a99303dbf15b15]
stable/6.12: [1e0de7582ceccbdbb227d4e0ddf65732f92526da]
stable/6.6: [ff55c85a923e043d59d26b20a673a1b4a219c310]

CVE-2025-38113: ACPI: CPPC: Fix NULL pointer dereference when nosmp is used

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38113

Introduced by commit 3cc30dd ("cpufreq: CPPC: Enable fast_switch") in v5.19-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15eece6c5b05e5f9db0711978c3e3b7f1a2cfe12]
stable/6.1: [356d09c7f5bf525086002a34f8bae40b134d1611]
stable/6.12: [32a48db4cf28ea087214c261da8476db218d08bd]
stable/6.6: [c6dad167aade4bf0bef9130f2f149f4249fc4ad0]

CVE-2025-38114: e1000: Move cancel_work_sync to avoid deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38114

Introduced by commit e400c74 ("e1000: Hold RTNL when e1000_down can be
called") in v6.13-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4a8085ceefb7bbb12c2b71c55e71fc946c6929f]

CVE-2025-38115: net_sched: sch_sfq: fix a potential crash on gso_skb handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38115

Introduced by commit a53851e ("net: sched: explicit locking in gso_cpu
fallback") in v4.16-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82ffbe7776d0ac084031f114167712269bf3d832]
stable/5.10: [b44f791f27b14c9eb6b907fbe51f2ba8bec32085]
stable/5.15: [5814a7fc3abb41f63f2d44c9d3ff9d4e62965b72]
stable/5.4: [c337efb20d6d9f9bbb4746f6b119917af5c886dc]
stable/6.1: [9c19498bdd7cb9d854bd3c54260f71cf7408495e]
stable/6.12: [d1bc80da75c789f2f6830df89d91fb2f7a509943]
stable/6.6: [b4e9bab6011b9559b7c157b16b91ae46d4d8c533]

CVE-2025-38116: wifi: ath12k: fix uaf in ath12k_core_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38116

Introduced by commit 6f245ea ("wifi: ath12k: introduce device group
abstraction") in v6.14-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3fe49dbddd73f0155a8935af47cb63693069dbe]

CVE-2025-38117: Bluetooth: MGMT: Protect mgmt_pending list with its own lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38117

Introduced by commit a380b6c ("Bluetooth: Add generic mgmt helper
API") in v4.1-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fe26f694c824b8a4dbf50c635bee1302e3f099c]
stable/6.12: [4e83f2dbb2bf677e614109df24426c4dded472d4]
stable/6.6: [bdd56875c6926d8009914f427df71797693e90d4]

CVE-2025-38118: Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38118

Introduced by commit 66bd095 ("Bluetooth: advmon offload MSFT remove
monitor") in v5.12-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6ed54e86aae9e4f7286ce8d5c73780f91b48d1c]
stable/6.1: [3c9aba9cbdf163e2654be9f82d43ff8a04273962]
stable/6.12: [9df3e5e7f7e4653fd9802878cedc36defc5ef42d]
stable/6.6: [9f66b6531c2b4e996bb61720ee94adb4b2e8d1be]

CVE-2025-38119: scsi: core: ufs: Fix a hang in the error handler

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38119

Introduced by commit 6269473 ("[SCSI] ufs: Add runtime PM support for
UFS host controller driver") in v3.12-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a3514d348de87a9d5e2ac00fbac4faae0b97996]
stable/5.15: [f592eb12b43f21dbc972cbe583a12d256901e569]
stable/6.1: [ded80255c59a57cd3270d98461f6508730f9767c]
stable/6.12: [3464a707d137efc8aea1d4ae234d26a28d82b78c]
stable/6.6: [21f071261f946c5ca1adf378f818082a112b34d2]

CVE-2025-38120: netfilter: nf_set_pipapo_avx2: fix initial map fill

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38120

Introduced by commit 791a615 ("netfilter: nf_set_pipapo: fix initial
map fill") in v6.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [ea77c397bff8b6d59f6d83dae1425b08f465e8b5]
stable/5.15: [b5ad58285f9217d68cd5ea2ad86ce254a3fe7c4d]
stable/6.1: [90bc7f5a244aadee4292b28098b7c98aadd4b3aa]
stable/6.12: [251496ce1728c9fd47bd2b20a7b21b20b9a020ca]
stable/6.6: [39bab2d3517b5b50c609b4f8c66129bf619fffa0]

CVE-2025-38121: wifi: iwlwifi: mld: avoid panic on init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38121

Introduced by commit 7391b2a ("wifi: iwlwifi: rework firmware error
handling") in v6.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [960c7e6d388034d219dafffa6da0a5c2ccd5ff30]

CVE-2025-38122: gve: add missing NULL check for
gve_alloc_pending_packet() in TX DQO

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38122

Introduced by commit a57e5de ("gve: DQO: Add TX path") in v5.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12c331b29c7397ac3b03584e12902990693bc248]
stable/5.15: [ae98a1787fdcb0096d122bc80d93c3c7d812c04b]
stable/6.1: [2e5ead9e4e91fbe7799bd38afd8904543be1cb51]
stable/6.12: [a0319c9b1648a67511e947a596ca86888451c0a7]
stable/6.6: [7f6265fce3bd424ded666481b37f106d7915fb6b]

CVE-2025-38123: net: wwan: t7xx: Fix napi rx poll issue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38123

Introduced by commit 5545b7b ("net: wwan: t7xx: Add NAPI support") in v6.2-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [905fe0845bb27e4eed2ca27ea06e6c4847f1b2b1]
stable/6.12: [e2df04e69c3f10b412f54be036dd0ed3b14756cf]
stable/6.6: [cc89f457d9133a558d4e8ef26dc20843c2d12073]

CVE-2025-38124: net: fix udp gso skb_segment after pull from frag_list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38124

Introduced by commit a1e40ac ("gso: fix udp gso fraglist segmentation
after pull from frag_list") in v6.12-rc2.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [3382a1ed7f778db841063f5d7e317ac55f9e7f72]
stable/6.1: [0e65f38bd1aa14ea86e221b7bb814d38278d86c3]
stable/6.12: [4399f59a9467a324ed46657555f0e1f209a14acb]
stable/6.6: [85eef1748c024da1a191aed56b30a3a65958c50c]

CVE-2025-38125: net: stmmac: make sure that ptp_rate is not 0 before
configuring EST

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38125

Introduced by commit 8572aec ("net: stmmac: Add basic EST support for
XGMAC") in v5.6-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbefe2ffa7784525ec5d008ba87c7add19ec631a]
stable/6.12: [451ee661d0f6272017fa012f99617101aa8ddf2c]

CVE-2025-38126: net: stmmac: make sure that ptp_rate is not 0 before
configuring timestamping

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38126

Introduced by commit 19d857c ("stmmac: Fix calculations for ptp
counters when clock input = 50Mhz.") in v4.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [030ce919e114a111e83b7976ecb3597cefd33f26]
stable/6.1: [32af9c289234990752281c805500dfe03c5b2b8f]
stable/6.12: [bb033c6781ce1b0264c3993b767b4aa9021959c2]
stable/6.6: [b263088ee8ab14563817a8be3519af8e25225793]

CVE-2025-38127: ice: fix Tx scheduler error handling in XDP callback

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38127

Introduced by commit efc2214 ("ice: Add support for XDP") in v5.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0153f36041b8e52019ebfa8629c13bf8f9b0a951]
stable/6.12: [276849954d7cbe6eec827b21fe2df43f9bf07011]
stable/6.6: [1d3c5d0dec6797eca3a861dab0816fa9505d9c3e]

CVE-2025-38128: Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38128

Introduced by commit 827af47 ("Bluetooth: MGMT: Add initial
implementation of MGMT_OP_HCI_CMD_SYNC") in v6.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03f1700b9b4d4f2fed3165370f3c23db76553178]

CVE-2025-38129: page_pool: Fix use-after-free in page_pool_recycle_in_ring

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38129

Introduced by commit ff7d6b2 ("page_pool: refurbish version of
page_pool code") in v4.18-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [271683bb2cf32e5126c592b5d5e6a756fa374fd9]
stable/6.12: [e869a85acc2e60dc554579b910826a4919d8cd98]

CVE-2025-38130: drm/connector: only call HDMI audio helper plugged cb
if non-null

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38130

Introduced by commit baf6166 ("drm/connector: implement generic HDMI
audio helpers") in v6.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be9b3f9a54101c19226c25ba7163d291183777a0]

CVE-2025-38131: coresight: prevent deactivate active config while
enabling the config

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38131

Introduced by commit f8cce2f ("coresight: syscfg: Add API to activate
and enable configurations") in v5.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [408c97c4a5e0b634dcd15bf8b8808b382e888164]
stable/6.1: [dfe8224c9c7a43d356eb9f74b06868aa05f90223]
stable/6.12: [31028812724cef7bd57a51525ce58a32a6d73b22]
stable/6.6: [b3b4efa2e623aecaebd7c9b9e4171f5c659e9724]

CVE-2025-38132: coresight: holding cscfg_csdev_lock while removing
cscfg from csdev

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38132

Introduced by commit 02bd588 ("coresight: configuration: Update API to
permit dynamic load/unload") in v5.17-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53b9e2659719b04f5ba7593f2af0f2335f75e94a]

CVE-2025-38133: iio: adc: ad4851: fix ad4858 chan pointer handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38133

Introduced by commit 6250803 ("iio: adc: ad4851: add ad485x driver")
in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [499a8cee812588905cc940837e69918c1649a19e]

CVE-2025-38134: usb: acpi: Prevent null pointer dereference in
usb_acpi_add_usb4_devlink()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38134

Introduced by commit f1bfb4a ("usb: acpi: add device link between
tunneled USB3 device and USB4 Host Interface") in v6.12-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73fb0ec9436ae87bcae067ce35d6cdd72bade86c]
stable/6.12: [8fa544bff8466062e42949c93f3e528f4be5624b]

CVE-2025-38135: serial: Fix potential null-ptr-deref in mlb_usio_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38135

Introduced by commit ba44dc0 ("serial: Add Milbeaut serial control")
in v5.2-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86bcae88c9209e334b2f8c252f4cc66beb261886]
stable/5.10: [81159a6b064142b993f2f39828b77e199c77872a]
stable/5.15: [19fd9f5a69363d33079097d866eb6082d61bf31d]
stable/5.4: [a05ebe384c7ca75476453f3070c67d9cf1d1a89f]
stable/6.1: [548b0e81b9a0902a8bc8259430ed965663baadfc]
stable/6.12: [c23d87b43f7dba5eb12820f6cf21a1cd4f63eb3d]
stable/6.6: [a6c7c365734cd0fa1c5aa225a6294fdf80cad2ea]

CVE-2025-38136: usb: renesas_usbhs: Reorder clock handling and power
management in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38136

Introduced by commit f1407d5 ("usb: renesas_usbhs: Add Renesas USBHS
common code") in v3.0-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffb34a60ce86656ba12d46e91f1ccc71dd221251]
stable/5.10: [155453ada562c450a4ff5fcf4852b9fa5b6b793a]
stable/5.15: [0a1e16a6cbf4452b46f20b862d6141a1e90844ee]
stable/5.4: [095cc0b5888acc228f12344e85b17539b9ce9367]
stable/6.1: [1637623ad6205162b17804d07512e6f4cbd2a050]
stable/6.12: [d4c368e4a638ddf4a9d6d687b0ff691aa46cce53]
stable/6.6: [db96a4fd8614d47c0def265e0e6c996b0ee52a38]

CVE-2025-38137: PCI/pwrctrl: Cancel outstanding rescan work when unregistering

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38137

Introduced by commit 8f62819 ("PCI/pwrctl: Rescan bus on a separate
thread") in v6.11-rc7.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b926f237743f020518162c62b93cb7107a2b5eb]

CVE-2025-38138: dmaengine: ti: Add NULL check in udma_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38138

Introduced by commit 25dcb5d ("dmaengine: ti: New driver for K3 UDMA")
in v5.6-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd447415e74bccd7362f760d4ea727f8e1ebfe91]
stable/5.10: [ec1ea394c40523835bbedd8fc4934b77b461b6fe]
stable/5.15: [9f133e04c62246353b8b1f0a679535c65161ebcf]
stable/6.1: [d61d5ba5bd5b0e39e30b34dcd92946e084bca0d0]
stable/6.12: [bc6ddff79835f71310a21645d8fcf08ec473e969]
stable/6.6: [b79e10050d9d1e200541d25751dd5cb8ec58483c]

CVE-2025-38139: netfs: Fix oops in write-retry from mis-resetting the
subreq iterator

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38139

Introduced by commit cd0277e ("netfs: Use new folio_queue data type
and iterator instead of xarray iter") in v6.12-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4481f7f2b3df123ec77e828c849138f75cff2bf2]

CVE-2025-38140: dm: limit swapping tables for devices with zone write plugs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38140

Introduced by commit bb37d77 ("dm: introduce zone append emulation")
in v5.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [121218bef4c1df165181f5cd8fc3a2246bac817e]

CVE-2025-38141: dm: fix dm_blk_report_zones

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38141

Introduced by commit f211268 ("dm: Use the block layer zone append
emulation") in v6.10-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37f53a2c60d03743e0eacf7a0c01c279776fef4e]
stable/6.12: [f9c1bdf24615303d48a2d0fd629c88f3189563aa]

CVE-2025-38142: hwmon: (asus-ec-sensors) check sensor index in read_string()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38142

Introduced by commit d0ddfd2 ("hwmon: (asus-ec-sensors) add driver for
ASUS EC") in v5.18-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25be318324563c63cbd9cb53186203a08d2f83a1]
stable/6.1: [6bf529ce84dccc0074dbc704e70aee4aa545057e]
stable/6.12: [19bd9cde38dd4ca1771aed7afba623e7f4247c8e]
stable/6.6: [4e9e45746b861ebd54c03ef301da2cb8fc990536]

CVE-2025-38143: backlight: pm8941: Add NULL check in wled_configure()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38143

Introduced by commit f86b775 ("backlight: pm8941: Convert to using
%pOFn instead of device_node.name") in v5.0-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e12d3e1624a02706cdd3628bbf5668827214fa33]
stable/5.10: [6a56446595730a5e3f06a30902e23cb037d28146]
stable/5.15: [9d06ac32c202142da40904180f2669ed4f5073ac]
stable/6.1: [21528806560510458378ea52c37e35b0773afaea]
stable/6.12: [1be2000b703b02e149f8f2061054489f6c18c972]
stable/6.6: [fde314445332015273c8f51d2659885c606fe135]

CVE-2025-38144: watchdog: lenovo_se30_wdt: Fix possible devm_ioremap()
NULL pointer dereference in lenovo_se30_wdt_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38144

Introduced by commit c284153 ("watchdog: lenovo_se30_wdt: Watchdog
driver for Lenovo SE30 platform") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4e2401438a26131ecff9be6a3a1d4cbfea66f9a]

CVE-2025-38145: soc: aspeed: Add NULL check in aspeed_lpc_enable_snoop()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38145

Introduced by commit 3772e5d ("drivers/misc: Aspeed LPC snoop output
using misc chardev") in v4.19-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1706e0e1a74b095cbc60375b9b1e6205f5f4c98]
stable/5.10: [c550999f939b529d28a914d5034cc4290066aea6]
stable/5.15: [1fd889c145722579aa038c31cbc07cfdd4d75166]
stable/5.4: [2beee9cf833374550e673d428ad8b6ab37c175b3]
stable/6.1: [d62a589eaaec6385e3e2b25cf5a28b4560ace93f]
stable/6.12: [f697ef117ecbf3a367dfc559a6a3589905956530]
stable/6.6: [8312b1f776f71979bf33bda7acc05b348e8792c7]

CVE-2025-38146: net: openvswitch: Fix the dead loop of MPLS parse

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38146

Introduced by commit fbdcdd7 ("Change in Openvswitch to support MPLS
label depth of 3 in ingress direction") in v5.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bdc924bfb319fb10d1113cbf091fc26fb7b1f99]
stable/5.10: [4b9a086eedc1fddae632310386098c12155e3d0a]
stable/5.15: [ad17eb86d042d72a59fd184ad1adf34f5eb36843]
stable/6.1: [f26fe7c3002516dd3c288f1012786df31f4d89e0]
stable/6.12: [69541e58323ec3e3904e1fa87a6213961b1f52f4]
stable/6.6: [8ebcd311b4866ab911d1445ead08690e67f0c488]

CVE-2025-38147: calipso: Don't call calipso functions for AF_INET sk.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38147

Introduced by commit ceba183 ("calipso: Set the calipso socket label
to match the secattr.") in v4.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e9f2df1c550ead7cecb3e450af1105735020c92]
stable/5.10: [0c813dbc851dbf418fdc6dc883fd0592d6c555cd]
stable/5.15: [26ce90f1ce60b0ff587de8d6aec399aa55cab28e]
stable/5.4: [fc2da88411470480b8b7e9177e930cedd893cf56]
stable/6.1: [c32ebe33626335a536dbbdd09571c06dd9bc1729]
stable/6.12: [dd8928897594931d6912ef2f7a43e110b4958d3d]
stable/6.6: [946bfdfcb76ac2bac5b8526447035885ff41c598]

CVE-2025-38148: net: phy: mscc: Fix memory leak when using one step timestamping

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38148

Introduced by commit 7d272e6 ("net: phy: mscc: timestamping and PHC
support") in v5.9-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [846992645b25ec4253167e3f931e4597eb84af56]
stable/6.1: [db2a12ddd3a31f668137ff6a4befc1343c79cbc4]
stable/6.12: [66abe22017522dd56b820e41ca3a5b131a637001]
stable/6.6: [0b40aeaf83ca04d4c9801e235b7533400c8b5f17]

CVE-2025-38149: net: phy: clear phydev->devlink when the link is deleted

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38149

Introduced by commit bc66fa8 ("net: phy: Add link between phy dev and
mac dev") in v6.2-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0795b05a59b1371b18ffbf09d385296b12e9f5d5]
stable/6.12: [ddc654e89ace723b78c34911c65243accbc9b75c]
stable/6.6: [363fdf2777423ad346d781f09548cca14877f729]

CVE-2025-38150: af_packet: move notifier's packet_dev_mc out of rcu
critical section

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38150

Introduced by commit ad7c7b2 ("net: hold netdev instance lock during
sysfs operations") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8d85ef0a631df9127f202e6371bb33a0b589952]

CVE-2025-38151: RDMA/cma: Fix hang when cma_netevent_callback fails to
queue_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38151

Introduced by commit 45f5dcd ("RDMA/cma: Fix workqueue crash in
cma_netevent_work_handler") in v6.15-rc3.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [92a251c3df8ea1991cd9fe00f1ab0cfce18d7711]
stable/6.1: [1ac40736c8c4255d8417b937c9715b193f4a87b3]
stable/6.12: [02e45168e0fd6fdc6f8f7c42c4b500857aa5efb0]
stable/6.6: [ac7897c0124066b9705ffca252a3662d54fc0c9b]

CVE-2025-38153: net: usb: aqc111: fix error handling of usbnet read calls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38153

Introduced by commit df2d59a ("net: usb: aqc111: Add support for
getting and setting of MAC address") in v5.0-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [405b0d610745fb5e84fc2961d9b960abb9f3d107]
stable/5.10: [11273279012c922f37cfb4dd95d142803fc07b98]
stable/5.15: [f398d2dfe450ce2c031d10b585448862d74a0501]
stable/5.4: [8c97655275482ef5384ce0501640630a0fc0f6f4]
stable/6.1: [acb47a40b5e38be03ef659b7bacdddc592ed73b7]
stable/6.12: [30a9e834c74e260533b8d0885e3c89f6f32f7993]
stable/6.6: [60790d287c1a1ced3554d4a87c2f27bf299a932a]

CVE-2025-38154: bpf, sockmap: Avoid using sk_socket after free when sending

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38154

Introduced by commit 4b4647a ("sock_map: avoid race between
sock_map_close and sk_psock_put") in v6.10-rc2.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [8259eb0e06d8f64c700f5fbdb28a5c18e10de291]
stable/5.15: [4edb40b05cb6a261775abfd8046804ca139a5546]
stable/6.1: [b19cbf0b9a91f5a0d93fbcd761ff71c48ab40ed9]
stable/6.12: [15c0250dae3b48a398447d2b364603821ed4ed90]
stable/6.6: [4c6fa65ab2aec7df94809478c8d28ef38676a1b7]

CVE-2025-38155: wifi: mt76: mt7915: Fix null-ptr-deref in mt7915_mmio_wed_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38155

Introduced by commit 4f831d1 ("wifi: mt76: mt7915: enable WED RX
support") in v6.2-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efb95439c1477bbc955cacd0179c35e7861b437c]
stable/6.12: [790d05cde359356feea8915094a51166af1629f5]
stable/6.6: [e9f9cef1877ac32285dbc1f31b86c8955b712fc2]

CVE-2025-38156: wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38156

Introduced by commit 83eafc9 ("wifi: mt76: mt7996: add wed tx
support") in v6.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f30e2b059757d8711a823e4c9c023db62a1d171]
stable/6.12: [1072fc0ca1f8d0d5397d24853386876f937b8e63]

CVE-2025-38157: wifi: ath9k_htc: Abort software beacon handling if disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38157

Introduced by commit 832f6a1 ("ath9k_htc: Add beacon slots") in v3.0-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac4e317a95a1092b5da5b9918b7118759342641c]
stable/5.10: [0281c19074976ec48f0078d50530b406ddae75bc]
stable/5.15: [7ee3fb6258da8c890a51b514f60d7570dc703605]
stable/5.4: [e5ce9df1d68094d37360dbd9b09289d42fa21e54]
stable/6.1: [40471b23147c86ea3ed97faee79937c618250bd0]
stable/6.12: [ee5ee646385f5846dcbc881389f3c44a197c402a]
stable/6.6: [5482ef9875eaa43f0435e14570e1193823de857e]

CVE-2025-38158: hisi_acc_vfio_pci: fix XQE dma address error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38158

Introduced by commit b0eed08 ("hisi_acc_vfio_pci: Add support for VFIO
live migration") in v5.18-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bb7170c5a055ea17c6857c256ee73c10ff872eb]
stable/6.1: [809a9c10274e1bcf6d05f1c0341459a425a4f05f]
stable/6.12: [884a76e813178778d271fea59783763d32bb7e72]
stable/6.6: [f0423873e7aeb69cb68f4e8fa3827832e7b037ba]

CVE-2025-38159: wifi: rtw88: fix the 'para' buffer size to avoid
reading out of bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38159

Introduced by commit 4136214 ("rtw88: add BT co-existence support") in v5.4-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c2c372de2e108319236203cce6de44d70ae15cd]
stable/5.15: [1ee8ea6937d13b20f90ff35d71ccc03ba448182d]
stable/6.1: [68a1037f0bac4de9a585aa9c879ef886109f3647]
stable/6.12: [c13255389499275bc5489a0b5b7940ccea3aef04]
stable/6.6: [74e18211c2c89ab66c9546baa7408288db61aa0d]

CVE-2025-38160: clk: bcm: rpi: Add NULL check in raspberrypi_clk_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38160

Introduced by commit 93d2725 ("clk: bcm: rpi: Discover the firmware
clocks") in v5.9-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73c46d9a93d071ca69858dea3f569111b03e549e]
stable/5.10: [938f625bd3364cfdc93916739add3b637ff90368]
stable/5.15: [54ce9bcdaee59d4ef0703f390d55708557818f9e]
stable/6.1: [52562161df3567cdaedada46834a7a8d8c4ab737]
stable/6.12: [0a2712cd24ecfeb520af60f6f859b442c7ab01ff]
stable/6.6: [3c1adc2f8c732ea09e8c4bce5941fec019c6205d]

CVE-2025-38161: RDMA/mlx5: Fix error flow upon firmware failure for RQ
destruction

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38161

Introduced by commit e2013b2 ("net/mlx5_core: Add RQ and SQ event
handling") in v4.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d2ea5aebbb2f3ebde4403f9c55b2b057e5dd2d6]
stable/5.10: [26d2f662d3a6655a82fd8a287e8b1ce471567f36]
stable/5.15: [f9784da76ad7be66230e829e743bdf68a2c49e56]
stable/6.1: [cf32affe6f3801cfb72a65e69c4bc7a8ee9be100]
stable/6.12: [50ac361ff8914133e3cf6ef184bac90c22cb8d79]
stable/6.6: [7c4c84cdcc19e89d42f6bf117238e5471173423e]

CVE-2025-38162: netfilter: nft_set_pipapo: prevent overflow in lookup
table allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38162

Introduced by commit 3c4287f ("nf_tables: Add set type for arbitrary
concatenation of ranges") in v5.6-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c5c6aa9967dbe55bd017bb509885928d0f31206]
stable/6.12: [c1360ac8156c0a3f2385baef91d8d26fd9d39701]

CVE-2025-38163: f2fs: fix to do sanity check on sbi->total_valid_block_count

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38163

Introduced by commit 39a53e0 ("f2fs: add superblock and major
in-memory structure") in v3.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05872a167c2cab80ef186ef23cc34a6776a1a30c]
stable/5.10: [f1b743c1955151bd392539b739a3ad155296be13]
stable/5.15: [6a324d77f7ea1a91d55c4b6ad970e3ac9ab6a20d]
stable/5.4: [49bc7bf38e42cfa642787e947f5721696ea73ac3]
stable/6.1: [25f3776b58c1c45ad2e50ab4b263505b4d2378ca]
stable/6.12: [65b3f76592aed5a43c4d79375ac097acf975972b]
stable/6.6: [a39cc43efc1bca74ed9d6cf9e60b995071f7d178]

CVE-2025-38164: f2fs: zone: fix to avoid inconsistence in between SIT and SSA

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38164

Introduced by commit 9703d69 ("f2fs: support file pinning for zoned
devices") in v6.9-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [773704c1ef96a8b70d0d186ab725f50548de82c4]
stable/6.12: [44a51592ac657d8e422585414d7ec17a5b50fb0e]

CVE-2025-38165: bpf, sockmap: Fix panic when calling skb_linearize

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38165

Introduced by commit a454d84 ("bpf, sockmap: Fix skb refcnt race after
locking changes") in v6.6-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [5ca2e29f6834c64c0e5a9ccf1278c21fb49b827e]
stable/6.1: [9718ba6490732dbe70190d42c21deb1440834402]
stable/6.12: [3d25fa2d7f127348c818e1dab9e58534f7ac56cc]
stable/6.6: [db1d15a26f21f97459508c42ae87cabe8d3afc3b]

CVE-2025-38166: bpf: fix ktls panic with sockmap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38166

Introduced by commit fcb14cb ("new iov_iter flavour - ITER_UBUF") in v6.0-rc1.
Introduced by commit d3b18ad ("tls: add bpf support to sk_msg
handling") in v4.20-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54a3ecaeeeae8176da8badbd7d72af1017032c39]
stable/6.1: [328cac3f9f8ae394748485e769a527518a9137c8]
stable/6.12: [57fbbe29e86042bbaa31c1a30d2afa16c427e3f7]
stable/6.6: [2e36a81d388ec9c3f78b6223f7eda2088cd40adb]

CVE-2025-38167: fs/ntfs3: handle hdr_first_de() return value

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38167

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af5cab0e5b6f8edb0be51a9f47f3f620e0b4fd70]
stable/5.15: [5390b3d4c6d41d05bb9149d094d504cbc9ea85bf]
stable/6.1: [83cd0aa74793384dbdffc140500b200e9776a302]
stable/6.12: [2d5879f64554181b89f44d4817b9ea86e8e913e1]
stable/6.6: [701340a25b1ad210e6b8192195be21fd3fcc22c7]

CVE-2025-38168: perf: arm-ni: Unregister PMUs on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38168

Introduced by commit 4d5a768 ("perf: Add driver for Arm NI-700
interconnect PMU") in v6.12-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f57afde6a44d9e044885e1125034edd4fda02e8]
stable/6.12: [7e958e116e3be05a1f869b5a885fc5d674c7725f]

CVE-2025-38169: arm64/fpsimd: Avoid clobbering kernel FPSIMD state with SMSTOP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38169

Introduced by commit e92bee9 ("arm64/fpsimd: Avoid erroneous elide of
user state reload") in v6.10-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01098d893fa8a6edb2b56e178b798e3e6b674f02]
stable/6.12: [55d52af498daea75aa03ba9b7e444c8ae495ac20]

CVE-2025-38170: arm64/fpsimd: Discard stale CPU state when handling SME traps

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38170

Introduced by commit 8bd7f91 ("arm64/sme: Implement traps and syscall
handling for SME") in v5.19-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3eaab3c70905c5467e5c4ea403053d67505adeb]
stable/6.1: [de89368de3894a8db27caeb8fd902ba1c49f696a]
stable/6.12: [6103f9ba51a59afb5a0f32299c837377c5a5a693]
stable/6.6: [43be952e885476dafb74aa832c0847b2f4f650c6]

CVE-2025-38171: power: supply: max77705: Fix workqueue error handling in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38171

Introduced by commit a6a494c ("power: supply: max77705: Add charger
driver for Maxim 77705") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11741b8e382d34b13277497ab91123d8b0b5c2db]

CVE-2025-38172: erofs: avoid using multiple devices with different type

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38172

Introduced by commit fb17675 ("erofs: add file-backed mount support")
in v6.12-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9748f2f54f66743ac77275c34886a9f890e18409]
stable/6.12: [65115472f741ca000d7ea4a5922214f93cd1516e]

CVE-2025-38173: crypto: marvell/cesa - Handle zero-length skcipher requests

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38173

Introduced by commit f63601f ("crypto: marvell/cesa - add a new driver
for Marvell's CESA") in v4.2-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a4e047c6cc07676f637608a9dd675349b5de0a7]
stable/5.10: [c064ae2881d839709bd72d484d5f2af157f46024]
stable/5.15: [e1cc69da619588b1488689fe3535a0ba75a2b0e7]
stable/5.4: [32d3e8049a8b60f18c5c39f5931bfb1130ac11c9]
stable/6.1: [78ea1ff6cb413a03ff6f7af4e28e24b4461a0965]
stable/6.12: [7894694b5d5b2ecfd7fb081d6f60b9e169ab4d13]
stable/6.6: [5e9666ac8b94c978690f937d59170c5237bd2c45]

CVE-2025-38174: thunderbolt: Do not double dequeue a configuration request

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38174

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by d7f781b ("thunderbolt: Rework control channel
to be more reliable") in 4.13-rc1.

Fixed status
mainline: [0f73628e9da1ee39daf5f188190cdbaee5e0c98c]
stable/5.10: [0a3011d47dbc92a33621861c423cb64833d7fe57]
stable/5.15: [2f62eda4d974c26bc595425eafd429067541f2c9]
stable/5.4: [e49e994cd83705f7ca30eda1e304abddfd96a37a]
stable/6.1: [85286e634ebbaf9c0fb1cdf580add2f33fc7628c]
stable/6.12: [eb2d5e794fb966b3ef8bde99eb8561446a53509f]
stable/6.6: [5a057f261539720165d03d85024da2b52e67f63d]

CVE-2025-38175: binder: fix yet another UAF in binder_devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38175

Introduced by commit 12d909c ("binderfs: add new binder devices to
binder_devices") in v6.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9857af0fcff385c75433f2162c30c62eb912ef6d]

CVE-2025-38176: binder: fix use-after-free in binderfs_evict_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38176

Introduced by commit e77aff5 ("binderfs: fix use-after-free in
binder_devices") in v6.14-rc6.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c0a559825281764061a127632e5ad273f0466ad]

CVE-2025-38177: sch_hfsc: make hfsc_qlen_notify() idempotent

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38177

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc2.


Fixed status
mainline: [51eb3b65544c9efd6a1026889ee5fb5aa62da3bb]
stable/6.1: [0475c85426b18eccdcb7f9fb58d8f8e9c6c58c87]
stable/6.12: [d06476714d2819b550e0cc39222347e2c8941c9d]
stable/6.6: [9030a91235ae4845ec71902c3e0cecfc9ed1f2df]

CVE-2025-38178: EDAC/igen6: Fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38178

Introduced by commit 20e190b ("EDAC/igen6: Skip absent memory
controllers") in v6.16-rc1.
Fixed in v6.15.4.

Bug introduced commit was backported to following branches.
stable/6.15

Fixed status
mainline: [40e69c93d6dadc5355bfe90f3940c402d171289c]

CVE-2025-38179: smb: client: fix max_sge overflow in
smb_extract_folioq_to_rdma()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38179

Introduced by commit c45ebd6 ("cifs: Provide the capability to extract
from ITER_FOLIOQ to RDMA SGEs") in v6.12-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a379a8a2a0032e12e7ef397197c9c2ad011588d6]
stable/6.12: [8ae7814589d7bd850294ac14ec4c1725dafd42ca]

CVE-2025-38180: net: atm: fix /proc/net/atm/lec handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38180

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d03b79f459c7935cff830d98373474f440bd03ae]
stable/5.10: [f2d1443b18806640abdb530e88009af7be2588e7]
stable/5.15: [ca3829c18c8d0ceb656605d3bff6bb3dfb078589]
stable/5.4: [fcfccf56f4eba7d00aa2d33c7bb1b33083237742]
stable/6.1: [e612c4b014f5808fbc6beae21f5ccaca5e76a2f8]
stable/6.12: [5fe1b23a2f87f43aeeac51e08819cbc6fd808cbc]
stable/6.6: [a5e3a144268899f1a8c445c8a3bfa15873ba85e8]

CVE-2025-38181: calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38181

Introduced by commit e1adea9 ("calipso: Allow request sockets to be
relabelled by the lsm.") in v4.8-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10876da918fa1aec0227fb4c67647513447f53a9]
stable/5.10: [f4ae0f61dd9a63329ecb49b1e6356139d43240b8]
stable/5.15: [dc724bd34d56f5589f7587a091a8cda2386826c4]
stable/5.4: [956f1499412ed0953f6a116df7fdb855e9f1fc66]
stable/6.1: [058dd4a370f23a5553a9449f2db53d5bfa88d45e]
stable/6.12: [988edde4d52d5c02ea4dd95d7619372a5e2fb7b7]
stable/6.6: [bde8833eb075ba8e8674de88e32de6b669966451]

CVE-2025-38182: ublk: santizize the arguments from userspace when
adding a device

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38182

Introduced by commit 71f28f3 ("ublk_drv: add io_uring based userspace
block driver") in v6.0-rc1.
Introduced by commit 62fe99c ("ublk: add read()/write() support for
ublk char device") in v6.5-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c8472855884355caf3d8e0c50adf825f83454b2]
stable/6.12: [0f8df5d6f25ac17c52a8bc6418e60a3e63130550]
stable/6.6: [3162d8235c8c4d585525cee8a59d1c180940a968]

CVE-2025-38183: net: lan743x: fix potential out-of-bounds write in
lan743x_ptp_io_event_clock_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38183

Introduced by commit 60942c3 ("net: lan743x: Add support for PTP-IO
Event Input External Timestamp (extts)") in v5.18-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e353b0854d3a1a31cb061df8d022fbfea53a0f24]
stable/6.1: [e8d48201a132f4aab31351c19a802c5a5ae820fa]
stable/6.12: [41017bd66c533f7af912c58273c7dfd5de0065d4]
stable/6.6: [66bba1fd5bad548c03f7e42669a59f3f4d8211cc]

CVE-2025-38184: tipc: fix null-ptr-deref when acquiring remote ip of
ethernet bearer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38184

Introduced by commit 832629c ("tipc: add UDP remoteip dump to netlink
API") in v4.9-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f82727adcf2992822e12198792af450a76ebd5ef]
stable/5.10: [c2e17984752b9131061d1a2ca1199da2706337fd]
stable/5.15: [8595350615f952fcf8bc861464a6bf6b1129af50]
stable/5.4: [3998283e4c32c0fe69edd59b0876c193f50abce6]
stable/6.1: [05d332ba075753d569d66333d62d60fff5f57ad8]
stable/6.12: [0d3d91c3500f0c480e016faa4e2259c588616e59]
stable/6.6: [d3dfe821dfe091c0045044343c8d86596d66e2cf]

CVE-2025-38185: atm: atmtcp: Free invalid length skb in atmtcp_c_send().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38185

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f370ae1fb6317985f3497b1bb80d457508ca2f7]
stable/5.10: [a4b0fd8c25a7583f8564af6cc910418fb8954e89]
stable/5.15: [1b0ad18704913c92a3ad53748fbc0f219a75b876]
stable/5.4: [c19c0943424b412a84fdf178e6c71fe5480e4f0f]
stable/6.1: [ca00f0e6d733ecd9150716d1fd0138d26e674706]
stable/6.12: [e996507f59610e5752b8702537f13f551e7a2c96]
stable/6.6: [3261c017a7c5d2815c6a388c5a3280d1fba0e8db]

CVE-2025-38186: bnxt_en: Fix double invocation of
bnxt_ulp_stop()/bnxt_ulp_start()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38186

Introduced by commit 3c163f3 ("bnxt_en: Optimize recovery path ULP
locking in the driver") in v6.10-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e9ac33fa271be0d2480fd732f9642d81542500b]
stable/6.12: [6f2cd309492924b8afd2c62aebff815c1119d124]

CVE-2025-38187: drm/nouveau: fix a use-after-free in r535_gsp_rpc_push()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38187

Introduced by commit 176fdcb ("drm/nouveau/gsp/r535: add support for
booting GSP-RM") in v6.7-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9802f0a63b641f4cddb2139c814c2e95cb825099]

CVE-2025-38188: drm/msm/a7xx: Call CP_RESET_CONTEXT_STATE

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38188

Introduced by commit af66706 ("drm/msm/a6xx: Add skeleton A7xx
support") in v6.7-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b520c6104f34e3a548525173c38ebca4402cac3]
stable/6.12: [8a1f52651dd8203695d293c6824d8f6c067877d1]

CVE-2025-38189: drm/v3d: Avoid NULL pointer dereference in
`v3d_job_update_stats()`

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38189

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc3.
Affected file was added by 57692c9 ("drm/v3d: Introduce a new DRM driver for
Broadcom V3D V3.x+") in 4.18-rc1.
The v3d_job_update_stats was called from v3d_cache_clean_job_run and
v3d_cpu_job_run.
The v3d_cache_clean_job_run was added by 09a93cc ("drm/v3d: Implement
show_fdinfo()
callback for GPU usage stats") in 6.8-rc1. The v3d_cpu_job_run get
file pointer since
aafc1a2 ("drm/v3d: Add a CPU job submission") in 6.8-rc1. Both
functions get file pointer
but not if the pointer is NULL or not. So, it looks as if these
commits might added vulnerability.

Fixed status
mainline: [e1bc3a13bd775791cca0bb144d977b00f3598042]
stable/6.12: [c886784000934d5486621106da0614c85bcd76a8]

CVE-2025-38190: atm: Revert atm_account_tx() if copy_from_iter_full() fails.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38190

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7851263998d4269125fd6cb3fdbfc7c6db853859]
stable/5.10: [c12430edd92fd49a4800b0f3fb395b50cb16bcc1]
stable/5.15: [287b4f085d2ca3375cf1ee672af27410c64777e8]
stable/5.4: [5e0d00992118e234ebf29d5145c1cc920342777e]
stable/6.1: [2252c539c43f9a1431a7e8b34e3c18e9dd77a96d]
stable/6.12: [3d828519bd69bfcaabdd942a872679617ef06739]
stable/6.6: [3902205eadf35db59dbc2186c2a98b9e6182efa5]

CVE-2025-38191: ksmbd: fix null pointer dereference in destroy_previous_session

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38191

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc3.
It looks as if this bug was introduced by e2f34481 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.

Fixed status
mainline: [7ac5b66acafcc9292fb935d7e03790f2b8b2dc0e]
stable/6.1: [281afc52e2961cd5dd8326ebc9c5bc40904c0468]
stable/6.12: [1193486dffb7432a09f57f5d09049b4d4123538b]
stable/6.6: [0902625a24eea7fdc187faa5d97df244d159dd6e]

CVE-2025-38192: net: clear the dst when changing skb protocol

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38192

Introduced by commit d219df6 ("bpf: Add ipip6 and ip6ip decap support
for bpf_skb_adjust_room()") in v6.3-rc1.
Introduced by commit 1b00e0d ("bpf: update skb->protocol in
bpf_skb_net_grow") in v5.2-rc1.
Introduced by commit 6578171 ("bpf: add bpf_skb_change_proto helper")
in v4.8-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba9db6f907ac02215e30128770f85fbd7db2fcf9]
stable/6.12: [2a3ad42a57b43145839f2f233fb562247658a6d9]
stable/6.6: [bfa4d86e130a09f67607482e988313430e38f6c4]

CVE-2025-38193: net_sched: sch_sfq: reject invalid perturb period

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38193

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ca52541c05c832d32b112274f81a985101f9ba8]
stable/5.15: [956b5aebb349449b38d920d444ca1392d43719d1]
stable/6.1: [b11a50544af691b787384089b68f740ae20a441b]
stable/6.12: [f9b97d466e6026ccbdda30bb5b71965b67ccbc82]
stable/6.6: [0357da9149eac621f39e235a135ebf155f01f7c3]

CVE-2025-38194: jffs2: check that raw node were preallocated before
writing summary

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38194

Introduced by commit 2f78540 ("[JFFS2] Reduce visibility of
raw_node_ref to upper layers of JFFS2 code.") in v2.6.20.16.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec9e6f22bce433b260ea226de127ec68042849b0]
stable/5.10: [8ce46dc5b10b0b6f67663202a4921b0e11ad7367]
stable/5.15: [4adee34098a6ee86a54bf3ec885eab620c126a6b]
stable/5.4: [337f80f3d546e131c7aa90b61d8cde051ae858c7]
stable/6.1: [c0edcdb4fc106d69a2d1a0ce4868193511c389f3]
stable/6.12: [da12ef7e19048dc5714032c2db587a215852b200]
stable/6.6: [3f46644a5131a4793fc95c32a7d0a769745b06e7]

CVE-2025-38195: LoongArch: Fix panic caused by NULL-PMD in huge_pte_offset()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38195

Introduced by commit bd51834 ("LoongArch: Return NULL from
huge_pte_offset() for invalid PMD") in v6.15-rc4.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [ee084fa96123ede8b0563a1b5a9b23adc43cd50d]
stable/6.12: [985f086f281b7bbb6644851e63af1a17ffff9277]
stable/6.6: [b427d98d55217b53c88643579fbbd8a4c351a105]

CVE-2025-38196: io_uring/rsrc: validate buffer count with offset for cloning

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38196

Introduced by commit b16e920 ("io_uring/rsrc: allow cloning at an
offset") in v6.13-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d27f11bf02b38c431e49a17dee5c10a2b4c2e28]

CVE-2025-38197: platform/x86: dell_rbu: Fix list usage

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38197

Introduced by commit d19f359 ("platform/x86: dell_rbu: don't open code
list_for_each_entry*()") in v5.7-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61ce04601e0d8265ec6d2ffa6df5a7e1bce64854]
stable/5.10: [5e8c658acd1b7c186aeffa46bf08795e121f401a]
stable/5.15: [07d7b8e7ef7d1f812a6211ed531947c56d09e95e]
stable/6.1: [a7b477b64ef5e37cb08dd536ae07c46f9f28262e]
stable/6.12: [4d71f2c1e5263a9f042faa71d59515709869dc79]
stable/6.6: [f3b840fb1508a80cd8a0efb5c886ae1995a88b24]

CVE-2025-38198: fbcon: Make sure modelist not set on unregistered console

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38198

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by 409d6c9 ("fbcon: Introduce wrapper for
console->fb_info lookup") in 5.19-rc1.

Fixed status
mainline: [cedc1b63394a866bf8663a3e40f4546f1d28c8d8]
stable/6.1: [b3237d451bf3a4490cb1a76f3b7c91d9888f1c4b]
stable/6.12: [f28f1f578cd810779d01999c60618cda14c281dd]
stable/6.6: [519ba75728ee8cd561dce25fc52a2ec5c47171dc]

CVE-2025-38199: wifi: ath12k: Fix memory leak due to multiple rx_stats
allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38199

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
This bug was introduced by d889913 ("wifi: ath12k: driver for Qualcomm
Wi-Fi 7 devices")
in 6.3-rc1.

Fixed status
mainline: [c426497fa2055c8005196922e7d29c41d7e0948a]

CVE-2025-38200: i40e: fix MMIO write access to an invalid page in i40e_clear_hw

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38200

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
It was introduced by 838d41d ("i40e: clear all queues and interrupts")
in 3.17-rc1.

Fixed status
mainline: [015bac5daca978448f2671478c553ce1f300c21e]
stable/5.10: [5e75c9082987479e647c75ec8fdf18fa68263c42]
stable/5.15: [fecb2fc3fc10c95724407cc45ea35af4a65cdde2]
stable/5.4: [872607632c658d3739e4e7889e4f3c419ae2c193]
stable/6.1: [d88a1e8f024ba26e19350958fecbf771a9960352]
stable/6.12: [3502dd42f178dae9d54696013386bb52b4f2e655]
stable/6.6: [8cde755f56163281ec2c46b4ae8b61f532758a6f]

CVE-2025-38201: netfilter: nft_set_pipapo: clamp maximum map bucket
size to INT_MAX

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38201

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by 9f439bd ("netfilter: nft_set_pipapo: speed up
bulk element insertions") in 6.9-rc1.

Fixed status
mainline: [b85e3367a5716ed3662a4fe266525190d2af76df]
stable/6.12: [0ab3de047808f375a36cd345225572eb3366f3c6]

CVE-2025-38202: bpf: Check rcu_read_lock_trace_held() in
bpf_map_lookup_percpu_elem()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38202

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable code was added by 07343110 ("bpf: add bpf_map_lookup_percpu_elem
for percpu map") in 5.19-rc1.

Fixed status
mainline: [d4965578267e2e81f67c86e2608481e77e9c8569]
stable/6.1: [2f8c69a72e8ad87b36b8052f789da3cc2b2e186c]
stable/6.12: [2d834477bbc1e8b8a59ff8b0c081529d6bed7b22]
stable/6.6: [7bf4461f1c97207fda757014690d55a447ce859f]

CVE-2025-38203: jfs: Fix null-ptr-deref in jfs_ioc_trim

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38203

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable code was introduced by 4e7a4b0 ("jfs: Fix FITRIM argument handling")
in 3.7-rc3.

Fixed status
mainline: [a4685408ff6c3e2af366ad9a7274f45ff3f394ee]
stable/5.10: [a9d41c925069c950e18160e12a7e10e0f58c56fb]
stable/5.15: [4a8cb9908b51500a76f5156423bd295df53bff89]
stable/5.4: [0d50231d473f89024158dc62624930de45d13718]

CVE-2025-38204: jfs: fix array-index-out-of-bounds read in add_missing_indices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38204

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
It seems as if this  bug was introduced in 2.6.12-rc2 or early.

Fixed status
mainline: [5dff41a86377563f7a2b968aae00d25b4ceb37c9]
stable/5.10: [bfa4655d28f338e68d345aed80d19be7999bbce2]
stable/5.15: [44618bee303bed151ef3a525ff79fbd7689593b5]
stable/5.4: [81af4b34fd72d390d7f237c6a545cc6d09707956]

CVE-2025-38205: drm/amd/display: Avoid divide by zero by initializing
dummy pitch to 1

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38205

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable code was added by 7966f31 ("drm/amd/display: Introduce
DML2") in 6.7-rc1.

Fixed status
mainline: [7e40f64896e8e3dca471e287672db5ace12ea0be]

CVE-2025-38206: exfat: fix double free in delayed_free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38206

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable code was added by 370e812 ("exfat: add nls operations") in 5.7-rc1.

Fixed status
mainline: [1f3d9724e16d62c7d42c67d6613b8512f2887c22]
stable/5.10: [13d8de1b6568dcc31a95534ced16bc0c9a67bc15]
stable/5.15: [66e84439ec2af776ce749e8540f8fdd257774152]

CVE-2025-38207: mm: fix uprobe pte be overwritten when expanding vma

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38207

Introduced by commit 2b14449 ("uprobes, mm, x86: Add the ability to
install and remove uprobes breakpoints") in v3.5-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b12d06c37fd3a394376f42f026a7478d826ed63]

CVE-2025-38208: smb: client: add NULL check in automount_fullpath

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38208

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable code was added by 348a04a ("smb: client: get rid of dfs code dep in
 namespace.c") in 6.6-rc1.

Fixed status
mainline: [f1e7a277a1736e12cc4bd6d93b8a5c439b8ca20c]
stable/6.12: [a9e916fa5c7d0ec2256aa44aa24ddd92f529ce35]
stable/6.6: [37166d63e42c34846a16001950ecec96229a8d17]

CVE-2025-38209: nvme-tcp: remove tag set when second admin queue config fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38209

Introduced by commit 104d0e2 ("nvme-fabrics: reset admin connection
for secure concatenation") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7143706702a209c814ed2c3fc6486c2a7decf6c]

CVE-2025-38210: configfs-tsm-report: Fix NULL dereference of tsm_ops

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38210

Introduced by commit 70e6f7e ("configfs-tsm: Introduce a shared ABI
for attestation reports") in v6.7-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fba4ceaa242d2bdf4c04b77bda41d32d02d3925d]
stable/6.12: [015f04ac884a454d4d8aaa7b67758f047742b1cf]

CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects after
cm_id destruction

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38211

Introduced by commit 59c68ac ("iw_cm: free cm_id resources on the last
deref") in v4.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6883b680e703c6b2efddb4e7a8d891ce1803d06b]
stable/5.15: [3b4a50d733acad6831f6bd9288a76a80f70650ac]
stable/6.1: [78381dc8a6b61c9bb9987d37b4d671b99767c4a1]
stable/6.12: [764c9f69beabef8bdc651a7746c59f7a340d104f]
stable/6.6: [23a707bbcbea468eedb398832eeb7e8e0ceafd21]

CVE-2025-38212: ipc: fix to protect IPCS lookups using RCU

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38212

Introduced by commit b34a6b1 ("ipc: introduce shm_rmid_forced sysctl")
in v3.1-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d66adabe91803ef34a8b90613c81267b5ded1472]
stable/5.10: [b968ba8bfd9f90914957bbbd815413bf6a98eca7]
stable/5.15: [74bc813d11c30e28fc5261dc877cca662ccfac68]
stable/5.4: [5f1e1573bf103303944fd7225559de5d8297539c]
stable/6.1: [78297d53d3878d43c1d627d20cd09f611fa4b91d]
stable/6.12: [68c173ea138b66d7dd1fd980c9bc578a18e11884]
stable/6.6: [5180561afff8e0f029073c8c8117c95c6512d1f9]

CVE-2025-38213: vgacon: Add check for vc_origin address range in vgacon_scroll()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38213

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [864f9963ec6b4b76d104d595ba28110b87158003]
stable/5.10: [843de5fbfe277e30fb333a7fa033b684c37829ac]
stable/5.15: [bf9c07864765864b968e59c7b72db91130d621ca]
stable/5.4: [e44532b1c358bfd2c4c7dc28fd01d47fef09ac70]
stable/6.1: [9928ba7de39793a1c7c77b8b9e6ecf6209110311]
stable/6.12: [f20fd54af4e1077fdbca4dd98375a4d1d941e50d]
stable/6.6: [2f4040a5855a59e48296f1b5a7cc0fceea3195b1]

CVE-2025-38214: fbdev: Fix fb_set_var to prevent null-ptr-deref in
fb_videomode_to_var

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38214

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05f6e183879d9785a3cdf2f08a498bc31b7a20aa]
stable/5.10: [fab201d72fde38d081e2c5d4ad25595c535b7b22]
stable/5.15: [1a10d91766eb6ddfd5414e4785611e33a4fe0f9b]
stable/5.4: [ee20216f12d9482cd70e44dae5e7fabb38367c71]
stable/6.1: [ff0e037241173b574b385bff53d67567b9816db5]
stable/6.12: [b3071bb463ea1e6c686d0dc9638fc940f2f5cf17]
stable/6.6: [3ca78032a388a0795201792b36e6fc9b6e6e8eed]

CVE-2025-38215: fbdev: Fix do_register_framebuffer to prevent
null-ptr-deref in fb_videomode_to_var

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38215

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17186f1f90d34fa701e4f14e6818305151637b9e]
stable/6.1: [908c5bb64f9c4319902b8ca1aa3fef8f83302520]
stable/6.12: [3f2098f4fba7718eb2501207ca6e99d22427f25a]
stable/6.6: [0909b2b49c4546a7a08c80f53d93736b63270827]

CVE-2025-38216: iommu/vt-d: Restore context entry setup order for
aliased devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38216

Introduced by commit 2031c46 ("iommu/vt-d: Add support for static
identity domain") in v6.12-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [320302baed05c6456164652541f23d2a96522c06]
stable/6.12: [fb5873b779dd5858123c19bbd6959566771e2e83]

CVE-2025-38217: hwmon: (ftsteutates) Fix TOCTOU race in fts_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38217

Introduced by commit 1c5759d ("hwmon: (ftsteutates) Replace
fanX_source with pwmX_auto_channels_temp") in v6.3-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14c9ede9ca4cd078ad76a6ab9617b81074eb58bf]
stable/6.12: [83e2ba8971ccd8fc08319fc7593288f070d80a76]
stable/6.6: [d95d87841d2a575bed3691884e8fedef57d7710d]

CVE-2025-38218: f2fs: fix to do sanity check on sit_bitmap_size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38218

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [5db0d252c64e91ba1929c70112352e85dc5751e7]
stable/5.10: [82f51bff393e4c12cf4de553120ca831cfa4ef19]
stable/5.15: [38ef48a8afef8df646b6f6ae7abb872f18b533c1]
stable/6.1: [ad862f71016ba38039df1c96ed55c0a4314cc183]
stable/6.12: [ee1b421c469876544e297ec1090574bd76100247]
stable/6.6: [79ef8a6c4ec53d327580fd7d2b522cf4f1d05b0c]

CVE-2025-38219: f2fs: prevent kernel warning due to negative i_nlink
from corrupted image

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38219

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [42cb74a92adaf88061039601ddf7c874f58b554e]
stable/5.10: [1f6332872374b7f482fc4ad865f9422fedb587fc]
stable/5.15: [fbfe8446cd3274b9e367f5708d94574230a44409]
stable/5.4: [d9a55869d8237e677ddaa18b0f58586364cfbc1c]
stable/6.1: [5018d035530b6fbfad33eeb1dd1bc87da419a276]
stable/6.12: [aaa644e7ffff02e12c89cbce4753bc0b6f23ff87]
stable/6.6: [a87cbcc909ccfd394d4936a94663f586453d0961]

CVE-2025-38220: ext4: only dirty folios when data journaling regular files

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38220

Introduced by commit d84c9eb ("ext4: Mark pages with journalled data
dirty") in v6.4-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e26268ff1dcae5662c1b96c35f18cfa6ab73d9de]
stable/6.12: [be5f3061a6f904e3674257879e71881ceee5b673]
stable/6.6: [cf6a4c4ac7b6e3214f25df594c9689a62f1bb456]

CVE-2025-38221: ext4: fix out of bounds punch offset

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38221

Introduced by commit 982bf37 ("ext4: refactor ext4_punch_hole()") in v6.15-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5e58bcd79625423487fa3ecba8e8411b5396327]

CVE-2025-38222: ext4: inline: fix len overflow in ext4_prepare_inline_data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38222

Introduced by commit f19d587 ("ext4: add normal write support for
inline data") in v3.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [227cb4ca5a6502164f850d22aec3104d7888b270]
stable/5.10: [717414a8c083c376d4a8940a1230fe0c6ed4ee00]
stable/5.15: [9d1d1c5bf4fc1af76be154d3afb2acdbd89ec7d8]
stable/5.4: [d3dfc60efd145df5324b99a244b0b05505cde29b]
stable/6.1: [cf5f319a2d8ab8238f8cf3a19463b9bff6420934]
stable/6.12: [5766da2237e539f259aa0e5f3639ae37b44ca458]
stable/6.6: [26e09d18599da0adc543eabd300080daaeda6869]

CVE-2025-38223: ceph: avoid kernel BUG for encrypted inode with
unaligned file size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38223

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [060909278cc0a91373a20726bd3d8ce085f480a9]
stable/6.12: [75583606aeef357a524cf6afd07f4b653ae48964]

CVE-2025-38224: can: kvaser_pciefd: refine error prone echo_skb_max
handling logic

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38224

Introduced by commit 8256e0c ("can: kvaser_pciefd: Fix echo_skb race") in v6.15.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [54ec8b08216f3be2cc98b33633d3c8ea79749895]
stable/6.12: [d8a054b6e6824a8b52c3977ebd38c9583a63efac]

CVE-2025-38225: media: imx-jpeg: Cleanup after an allocation error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38225

Introduced by commit 2db16c6 ("media: imx-jpeg: Add V4L2 driver for
i.MX8 JPEG Encoder/Decoder") in v5.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7500bb9cf164edbb2c8117d57620227b1a4a8369]
stable/6.1: [b89ff9cf37ff59399f850d5f7781ef78fc37679f]
stable/6.12: [0ee9469f818a0b4de3c0e7aecd733c103820d181]
stable/6.6: [ec26be7d6355a05552a0d0c1e73031f83aa4dc7f]

CVE-2025-38226: media: vivid: Change the siize of the composing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38226

Introduced by commit 94a7ad9 ("media: vivid: fix compose size exceed
boundary") in v6.2-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [f83ac8d30c43fd902af7c84c480f216157b60ef0]
stable/5.10: [635cea4f44c1ddae208666772c164eab5a6bce39]
stable/5.15: [89b5ab822bf69867c3951dd0eb34b0314c38966b]
stable/6.1: [5d89aa42534723400fefd46e26e053b9c382b4ee]
stable/6.12: [00da1c767a6567e56f23dda586847586868ac064]
stable/6.6: [f6b1b0f8ba0b61d8b511df5649d57235f230c135]

CVE-2025-38227: media: vidtv: Terminating the subsequent process of
initialization failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38227

Introduced by commit 3be8037 ("media: vidtv: add error checks") in v5.10-rc6.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d5f88f053480326873115092bc116b7d14916ba]
stable/5.10: [e1d72ff111eceea6b28dccb7ca4e8f4900b11729]
stable/5.15: [7e62be1f3b241bc9faee547864bb39332955509b]
stable/6.1: [685c18bc5a36f823ee725e85aac1303ef5f535ba]
stable/6.12: [72541cae73d0809a6416bfcd2ee6473046a0013a]
stable/6.6: [9824e1732a163e005aa84e12ec439493ebd4f097]

CVE-2025-38228: media: imagination: fix a potential memory leak in e5010_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38228

Introduced by commit a1e2940 ("media: imagination: Add E5010 JPEG
Encoder driver") in v6.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [609ba05b9484856b08869f827a6edee51d51b5f3]
stable/6.12: [2a2bd7df402decbdefd0acb64ba4e17a0a2a4117]

CVE-2025-38229: media: cxusb: no longer judge rbuf when the write fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38229

Introduced by commit 22c6d93 ("[PATCH] dvb: usb: support Medion hybrid
USB2.0 DVB-T/analogue box") in v2.6.13-rc3.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73fb3b92da84637e3817580fa205d48065924e15]
stable/5.10: [390b864e3281802109dfe56e508396683e125653]
stable/5.15: [41807a5f67420464ac8ee7741504f6b5decb3b7c]
stable/6.1: [84eca597baa346f09b30accdaeca10ced3eeba2d]
stable/6.12: [9bff888c92f5c25effbb876d22a793c2388c1ccc]
stable/6.6: [04354c529c8246a38ae28f713fd6bfdc028113bc]

CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent crashes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38230

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37bfb464ddca87f203071b5bd562cd91ddc0b40a]
stable/6.1: [9242ff6245527a3ebb693ddd175493b38ddca72f]
stable/6.12: [8b69608c6b6779a7ab07ce4467a56df90152cfb9]
stable/6.15: [b62a1e59d8716bbd2e73660743fe06acc97ed7d1]
stable/6.6: [0c40fa81f850556e9aa0185fede9ef1112db7b39]

CVE-2025-38231: nfsd: Initialize ssc before laundromat_work to prevent
NULL dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38231

Introduced by commit f4e44b3 ("NFSD: delay unmount source's export
after inter-server copy completed.") in v5.14-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b31da62889e6d610114d81dc7a6edbcaa503fcf8]
stable/5.10: [deaeb74ae9318252829c59a84a7d2316fc335660]
stable/5.15: [0fccf5f01ed28725cc313a66ca1247eef911d55e]
stable/6.1: [a97668ec6d73dab237cd1c15efe012a10090a4ed]
stable/6.12: [d622c2ee6c08147ab8c9b9e37d93b6e95d3258e0]
stable/6.6: [5060e1a5fef184bd11d298e3f0ee920d96a23236]

CVE-2025-38232: NFSD: fix race between nfsd registration and exports_proc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38232

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [f7fb730cac9aafda8b9813b55d04e28a9664d17c]
stable/6.12: [2029ca75cdfa6a25716a5a76b751486cce7e3822]

CVE-2025-38233: powerpc64/ftrace: fix clobbered r15 during livepatching

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38233

Introduced by commit eec3796 ("powerpc64/ftrace: Move ftrace sequence
out of line") in v6.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb5b691f8273432297611863ac142e17119279e0]

CVE-2025-38234: sched/rt: Fix race in push_rt_task

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38234

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [690e47d1403e90b7f2366f03b52ed3304194c793]

CVE-2025-38235: HID: appletb-kbd: fix "appletb_backlight" backlight
device reference counting

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38235

Introduced by commit 93a0fc4 ("HID: hid-appletb-kbd: add support for
automatic brightness control while using the touchbar") in v6.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4540e41e753a7d69ecd3f5bad51fe620205c3a18]

CVE-2025-38236: af_unix: Don't leave consecutive consumed OOB skbs.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38236

Introduced by commit 314001f ("af_unix: Add OOB support") in v5.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32ca245464e1479bfea8592b9db227fdc1641705]
stable/6.1: [a12237865b48a73183df252029ff5065d73d305e]
stable/6.12: [61a9ad7b69ce688697e5f63332f03e17725353bc]
stable/6.6: [fad0a2c16062ac7c606b93166a7ce9d265bab976]

CVE-2025-38237: media: platform: exynos4-is: Add hardware sync wait to
fimc_is_hw_change_mode()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38237

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Vulnerable function was added by 9a761e4 ("[media] exynos4-is: Add Exynos4x12
FIMC-IS driver") in 3.10-rc1.

Fixed status
mainline: [bd9f6ce7d512fa21249415c16af801a4ed5d97b6]
stable/5.10: [e4077a10a25560ec0bd0b42322e4ea027d6f76e2]
stable/5.15: [bb97dfab7615fea97322b8a6131546e80f878a69]
stable/5.4: [b0d92b94278561f43057003a73a17ce13b7c1a1a]

CVE-2024-36350: TSA-SQ (TSA in the Store Queues)

Announce: no reference


Fixed in master bransh as of 2025-07-10. According to the advisory,
only AMD Fam19h CPUs
(Zen3/4 microarchitectures) are affected.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9af88a3d384c8b55beb5dc5483e5da0135fadbd,d8010d4ba43e9f790925375a7de100604a5e2dba,31272abd5974b38ba312e9cf2ec2f09f9dd7dcba,2329f250e04d3b8e78b36a68b9880ca7750a07ef,8e786a85c0a3c0fffae6244733fb576eeabd9dec]

CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)

Announce: no reference


Fixed in master bransh as of 2025-07-10. According to the advisory,
only AMD Fam19h CPUs
(Zen3/4 microarchitectures) are affected.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9af88a3d384c8b55beb5dc5483e5da0135fadbd,d8010d4ba43e9f790925375a7de100604a5e2dba,31272abd5974b38ba312e9cf2ec2f09f9dd7dcba,2329f250e04d3b8e78b36a68b9880ca7750a07ef,8e786a85c0a3c0fffae6244733fb576eeabd9dec]

CVE-2025-38238: scsi: fnic: Fix crash in fnic_wq_cmpl_handler when
FDMI times out

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38238

Introduced by commit 09c1e6a ("scsi: fnic: Add and integrate support
for FDMI") in v6.14-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a35b29bdedb4d2ae3160d4d6684a6f1ecd9ca7c2]

CVE-2025-38239: scsi: megaraid_sas: Fix invalid node index

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38239

Introduced by commit 8049da6 ("scsi: megaraid_sas: Use
irq_set_affinity_and_hint()") in v5.17-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [752eb816b55adb0673727ba0ed96609a17895654]
stable/6.1: [f1064b3532192e987ab17be7281d5fee36fd25e1]
stable/6.12: [19a47c966deb36624843b7301f0373a3dc541a05]
stable/6.6: [bf2c1643abc3b2507d56bb6c22bf9897272f8a35]

CVE-2025-38241: mm/shmem, swap: fix softlockup with mTHP swapin

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38241

Introduced by commit 1dd44c0 ("mm: shmem: skip swapcache for swapin of
synchronous swap device") in v6.14-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a05dd8ae5cbb1cb45f349922cfea4f548a5e5d6f]

CVE-2025-38242: mm: userfaultfd: fix race of userfaultfd_move and swap cache

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38242

Introduced by commit adef440 ("userfaultfd: UFFDIO_MOVE uABI") in v6.8-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ea148a799198518d8ebab63ddd0bb6114a103bc]

CVE-2025-38243: btrfs: fix invalid inode pointer dereferences during log replay

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38243

Introduced by commit b4c50cb ("btrfs: return a btrfs_inode from
read_one_inode()") in v6.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2dcf838cf5c2f0f4501edaa1680fcad03618d760]

CVE-2025-38244: smb: client: fix potential deadlock when reconnecting channels

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38244

Introduced by commit d7d7a66 ("cifs: avoid use of global locks for
high contention data") in v6.0-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [711741f94ac3cf9f4e3aa73aa171e76d188c0819]
stable/6.12: [7f3ead8ebc0ef65b6c89a13912b4e80218425629]
stable/6.6: [c82c7041258d96e3286f6790ab700e4edd3cc9e3]

CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in
atm_dev_deregister().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38245

Introduced by commit 64bf69d ("[ATM]: deregistration removes device
from atm_devs list immediately") in v2.6.20.16.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a433791aeaea6e84df709e0b9584b9bbe040cd1c]
stable/6.1: [b2e40fcfe1575faaa548f87614006d3fe44c779e]
stable/6.12: [ae539d963a17443ec54cba8a767e4ffa318264f4]
stable/6.6: [cabed6ba92a9a8c09da02a3f20e32ecd80989896]

CVE-2025-38246: bnxt: properly flush XDP redirect lists

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38246

Introduced by commit a7559bc ("bnxt: support transmit and free of
aggregation buffers") in v5.19-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9caca6ac0e26cd20efd490d8b3b2ffb1c7c00f6f]
stable/6.12: [c6665b8f0f58082c480ed8627029f44d046ef2c8]

CVE-2025-38247: userns and mnt_idmap leak in open_tree_attr(2)

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38247

Introduced by commit c4a1682 ("fs: add open_tree_attr()") in v6.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0748e553df0225754c316a92af3a77fdc057b358]

CVE-2025-38248: bridge: mcast: Fix use-after-free during router port
configuration

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38248

Introduced by commit 2796d84 ("net: bridge: vlan: convert mcast router
global option to per-vlan entry") in v5.15-rc1.
Introduced by commit 4b30ae9 ("net: bridge: mcast: re-implement
br_multicast_{enable, disable}_port functions") in v6.16-rc1.
Fixed in v6.16-rc4.

Bug introduced commit was backported to following branches.
stable/5.15 stable/6.1 stable/6.12 stable/6.15 stable/6.6

Fixed status
mainline: [7544f3f5b0b58c396f374d060898b5939da31709]

CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in
snd_usb_get_audioformat_uac3()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38249

Introduced by commit 9a2fe9b ("ALSA: usb: initial USB Audio Device
Class 3.0 support") in v4.17-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb4e2a6e8f28a3c0ad382e363aeb9cd822007b8a]
stable/6.1: [6eb211788e1370af52a245d4d7da35c374c7b401]
stable/6.12: [0ee87c2814deb5e42921281116ac3abcb326880b]
stable/6.6: [74fcb3852a2f579151ce80b9ed96cd916ba0d5d8]

CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38250

Introduced by commit bf18c71 ("Bluetooth: vhci: Free driver_data on
file release") in v3.4-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d6123102e9fbedc8d25bf4731da6d513173e49e]
stable/6.12: [ce23b73f0f27e2dbeb81734a79db710f05aa33c6]

CVE-2025-38251: atm: clip: prevent NULL deref in clip_push()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38251

Introduced by commit 93a2014 ("atm: fix a UAF in
lec_arp_clear_vccs()") in v5.7-rc5.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b993ea46b3b601915ceaaf3c802adf11e7d6bac6]
stable/6.1: [88c88f91f4b3563956bb52e7a71a3640f7ece157]
stable/6.12: [a07005a77b18ae59b8471e7e4d991fa9f642b3c2]
stable/6.6: [3c709dce16999bf6a1d2ce377deb5dd6fdd8cb08]

CVE-2025-38252: cxl/ras: Fix CPER handler device confusion

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38252

Introduced by commit 36f257e ("acpi/ghes, cxl/pci: Process CXL CPER
Protocol Errors") in v6.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c70ec71abdaf4e4fa48cd8fdfbbd864d78235a8]

CVE-2025-38253: HID: wacom: fix crash in wacom_aes_battery_handler()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38253

Introduced by commit fd2a9b2 ("HID: wacom: Remove AES power_supply
after extended inactivity") in v6.8-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3054152c12e2eed1e72704aff47b0ea58229584]
stable/6.12: [a4f182ffa30c52ad1c8e12edfb8049ee748c0f1b]

CVE-2025-38254: drm/amd/display: Add sanity checks for drm_edid_raw()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38254

Introduced by commit 48edb2a ("drm/amd/display: switch
amdgpu_dm_connector to use struct drm_edid") in v6.13-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6847b3b6e84ef37451c074e6a8db3fbd250c8dbf]

CVE-2025-38255: lib/group_cpus: fix NULL pointer dereference from
group_cpus_evenly()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38255

Introduced by commit 6a6dcae ("blk-mq: Build default queue map via
group_cpus_evenly()") in v6.3-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df831e97739405ecbaddb85516bc7d4d1c933d6b]
stable/6.12: [29d39e0d5f16c060e32542b2cf351c09fd22b250]
stable/6.6: [64a99eff8dcf1f951a544e6058341b2b19a8fdbd]

CVE-2025-38256: io_uring/rsrc: fix folio unpinning

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38256

Introduced by commit a8edbb4 ("io_uring/rsrc: enable multi-hugepage
buffer coalescing") in v6.12-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5afb4bf9fc62d828647647ec31745083637132e4]
stable/6.12: [53fd75f25b223878b5fff14932e3a22f42b54f77]

CVE-2025-38257: s390/pkey: Prevent overflow in size calculation for
memdup_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38257

Introduced by commit f2bbc96 ("s390/pkey: add CCA AES cipher key
support") in v5.4-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7360ee47599af91a1d5f4e74d635d9408a54e489]
stable/6.1: [faa1ab4a23c42e34dc000ef4977b751d94d5148c]
stable/6.12: [f855b119e62b004a5044ed565f2a2b368c4d3f16]
stable/6.6: [88f3869649edbc4a13f6c2877091f81cd5a50f05]

CVE-2025-38258: mm/damon/sysfs-schemes: free old
damon_sysfs_scheme_filter->memcg_path on write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38258

Introduced by commit 7ee161f ("mm/damon/sysfs-schemes: implement
filter directory") in v6.3-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f489fe6afb395dbc79840efa3c05440b760d883]
stable/6.12: [c5d5b0047b0c0f304608f3824139f7bd34c48413]
stable/6.6: [490a43d07f1663d827e802720d30cbc0494e4f81]

CVE-2025-38259: ASoC: codecs: wcd9335: Fix missing free of regulator supplies

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38259

Introduced by commit 20aedaf ("ASoC: wcd9335: add support to wcd9335
codec") in v5.1-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9079db287fc3e38e040b0edeb0a25770bb679c8e]
stable/6.1: [edadaf4239c14dc8a19ea7f60b97d5524d93c29b]
stable/6.12: [a8795f3cd289cd958f6396a1b43ba46fa8e22a2e]
stable/6.6: [9830ef1803a5bc50b4a984a06cf23142cd46229d]

CVE-2025-38260: btrfs: handle csum tree error with rescue=ibadroots correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38260

Introduced by commit abed4aa ("btrfs: track the csum, extent, and free
space trees in a rb tree") in v5.17-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [547e836661554dcfa15c212a3821664e85b4191a]
stable/6.1: [f8ce11903211542a61f05c02caedd2edfb4256b8]
stable/6.12: [bbe9231fe611a54a447962494472f604419bad59]
stable/6.6: [fc97a116dc4929905538bc0bd3af7faa51192957]

CVE-2025-38261: riscv: save the SR_SUM status over switches

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38261

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [788aa64c01f1262310b4c1fb827a36df170d86ea]

CVE-2025-38262: tty: serial: uartlite: register uart driver in init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38262

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.


Fixed status
mainline: [6bd697b5fc39fd24e2aa418c7b7d14469f550a93]
stable/6.1: [6db06aaea07bb7c8e33a425cf7b98bf29ee6056e]
stable/6.12: [685d29f2c5057b32c7b1b46f2a7d303b926c8f72]
stable/6.6: [8e958d10dd0ce5ae674cce460db5c9ca3f25243b]

CVE-2025-38263: bcache: fix NULL pointer in cache_set_flush()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38263

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
It seems as if this bug was introduced by 08fdb2c ("bcache: remove
for_each_cache()") in 5.10-rc1.

Fixed status
mainline: [1e46ed947ec658f89f1a910d880cd05e42d3763e]
stable/6.1: [c4f5e7e417034b05f5d2f5fa9a872db897da69bd]
stable/6.12: [667c3f52373ff5354cb3543e27237eb7df7b2333]
stable/6.6: [553f560e0a74a7008ad9dba05c3fd05da296befb]

CVE-2025-38264: nvme-tcp: sanitize request list handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38264

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc1.
Affected file was added by 3f2304f ("nvme-tcp: add NVMe over TCP host driver")
in 5.0-rc1.

Fixed status
mainline: [0bf04c874fcb1ae46a863034296e4b33d8fbd66c]
stable/6.12: [78a4adcd3fedb0728436e8094848ebf4c6bae006]


* Updated CVEs

CVE-2024-36913: Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [7f2afcbfe4f6b6047b5f68db5067b7321e5be125]
stable/6.6: [6123a4e8e25bd40cf44db14694abac00e6b664e6]

CVE-2024-57976: btrfs: do proper folio cleanup when cow_file_range() failed

stable/6.12 was fixed.

Fixed status
stable/6.12: [10b3772292bf1be45604ba83fd9650eb94382e78]
stable/6.13: [692cf71173bb41395c855acbbbe197d3aedfa5d4]

CVE-2024-58091: drm/fbdev-dma: Add shadow buffering for deferred I/O

stable/6.12 was fixed.

Fixed status
stable/6.12: [0d087de947babf7ed70029d042abcc6ed06ff415]
stable/6.13: [cdc581169942de3b9e2648cfbd98c5ff9111c2c8]

CVE-2025-21879: btrfs: fix use-after-free on inode when scanning root
during em shrinking

stable/6.12 was fixed.

Fixed status
stable/6.12: [07836bc18f4ae42da4e922244f4685561c18755e]
stable/6.13: [5e79d26014f9386387575b9ed60d342057cee49b]

CVE-2025-21942: btrfs: zoned: fix extent range end unlock in cow_file_range()

stable/6.12 was fixed.

Fixed status
stable/6.12: [5f4863cfb29a7b4fe7625ce148d0b9000b75b802]
stable/6.13: [3fcff2f55389306482ab049b4321bda49495e546]

CVE-2025-22101: net: libwx: fix Tx L4 checksum

stable/6.12 was fixed.

Fixed status
stable/6.12: [6d56ea133adf0389b216ba6e47f7f35e95776713]
stable/6.14: [5f583e059eced1857f41e221ef5951e029e632bd]

CVE-2025-23155: net: stmmac: Fix accessing freed irq affinity_hint

stable/6.12 was fixed.

Fixed status
stable/6.12: [442312c2a90d60c7a5197246583fa91d9e579985]
stable/6.14: [9e51a6a44e2c4de780a26e8fe110d708e806a8cd]

CVE-2025-37842: spi: fsl-qspi: use devm function instead of driver remove

stable/6.12 was fixed.

Fixed status
stable/6.12: [f68b27d82a749117d9c7d7f33fa53f46373e38e2]
stable/6.14: [f9bfb3a5f6f616f3eb7665c8ff3bcb9760ae33c8]

CVE-2025-38215: fbdev: Fix do_register_framebuffer to prevent
null-ptr-deref in fb_videomode_to_var

stable/6.1 was fixed.

Fixed status
stable/6.1: [908c5bb64f9c4319902b8ca1aa3fef8f83302520]
stable/6.12: [3f2098f4fba7718eb2501207ca6e99d22427f25a]
stable/6.15: [d803c4c2a4ac8ce2be6d899d5c7ab0bf7ec355e9]
stable/6.6: [0909b2b49c4546a7a08c80f53d93736b63270827]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

