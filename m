Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E2D6D244
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 22:14:13 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web11.83432.1732745644936196849
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 14:14:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=ugnH+Msb;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso193066276.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1732745644; x=1733350444; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JWKcDCmYaZ5sMt7gZ/B345NTP2W/5tSv20UswGFJRHk=;
        b=ugnH+Msbnq+o3MOwFxxeNpIam3VMYQi9xxyTR8w3EuPY4ZT4tNdS1p+gjmIzcbLn9n
         Wqu6mp9ONvyPX3+oERX2ajUlj6o/ZtTKUppoUw2lms/gx1Riq/QgGJLxkRP3ws2ZFBJP
         0UDG0zq9Fdy1sLnB4O8d+merWvwddyxUrpHobFnWyp6uJTCNZNHni1VzvFsxWnRvXsln
         hzfSMCqdASLkzToppnTRl1Ho+vZ/4ZCTVptLes3HlPt/QAvBLeJoHiMXLGBRalV40tzg
         nEIrAb4aAvxuY4tizWSCtwjnvrJ5I1E8pepTeRv8k7zdMzs/zpw5FpaR0cMFfLFpiE8M
         Zw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732745644; x=1733350444;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWKcDCmYaZ5sMt7gZ/B345NTP2W/5tSv20UswGFJRHk=;
        b=A1xuWe9sXlZjTXMdBn6LN717xWiFbMklxHB+FN5+iLZq0VtcC7CRRatPoG+xG5DkvR
         6+9xpmOEkRV4RupyiL8H/LisRt8BbVy+w0HX6PJGIWyZkiI4jUvG1bI5w6q7dyG1w7zt
         Xfkn10W/dqYxMNKKA1tSZfBjOsc2aj+tY8TeeUDbmbrAUCXQMKDJoWJLvLWsL+Jh/TrS
         fm3HJPJ8fnG0YI4JfNZs+wsWQIA1iR9rNbOvq6wuFZtRoaE1JTaNGXzdUA/Se94cq6zl
         9TixxcG64DPVLWidaCkcLqyA5JNhBNUAdIYlFfZgZQQP1gza0ppX4usca7iXwI2B9qTU
         KrPw==
X-Gm-Message-State: AOJu0YxnxJ5rB4cpdVKWZH1J74wz3/bvnUS6043xaT3LA8I8kU5C9OVs
	qCADH3O1JsqeEltoO/yT834q8sc7TM3gMhHKuP1AAHf+1dvZ0w18l85KwfCx7kltn0QCm9YPiUz
	X22WOx5Uj0ynKILH7s1CMbV7xXTiBVtJvpH/V4iYeHZxu6NbDC2c=
X-Gm-Gg: ASbGncudcY1CYnROyJ4lyvDgn7T6vHPL9IsZcNsDKBxxPQpTUdrmG/4+x/3C65MXgmg
	qBUYboAbVEr2GPC53RFxZWtHTV68pKSrn
X-Google-Smtp-Source: AGHT+IGGrNnOTVdNTh+B8qvL+PGm2YsW9aapn4Old+g3HADFFd3XCWSeIfqYrx3Q+4i1f/tkjNYwjYvW3wtH0huTnjw=
X-Received: by 2002:a05:6902:18c5:b0:e38:b2ce:987 with SMTP id
 3f1490d57ef6-e395b86acbdmr4432177276.3.1732745643787; Wed, 27 Nov 2024
 14:14:03 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 Nov 2024 07:13:28 +0900
Message-ID: <CAODzB9pQucxuoUvb8X4cbeKGWHO2G0xhrdng1e5eQx_Gg_wHhg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 22:14:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17295

Hi!

It's this week's CVE report.

This week reported 14 new CVEs and 18 updated CVEs.

* New CVEs
CVE-2024-53089: LoongArch: KVM: Mark hrtimer to expire in hard interrupt context

Announce: https://lore.kernel.org/linux-cve-announce/2024112149-CVE-2024-53089-c8b4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc5.
LoongArch is not supported by CIP.

Fixed status
mainline: [73adbd92f3223dc0c3506822b71c6b259d5d537b]

CVE-2024-53090: afs: Fix lock recursion

Announce: https://lore.kernel.org/linux-cve-announce/2024112151-CVE-2024-53090-8ea9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc5.

Fixed status
mainline: [610a79ffea02102899a1373fe226d949944a7ed6]

CVE-2024-53091: bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx

Announce: https://lore.kernel.org/linux-cve-announce/2024112151-CVE-2024-53091-7f61@gregkh/

Introduced by commit 634f1a7 ("vsock: support sockmap") in v6.4-rc1.
Introduced by commit 94531cf ("af_unix: Add unix_stream_proto for
sockmap") in v5.15-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44d0469f79bd3d0b3433732877358df7dc6b17b1]
stable/6.6: [a078a480ff3f43d74d8a024ae10c3c7daf6db149]

CVE-2024-53092: virtio_pci: Fix admin vq cleanup by using correct info pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024112152-CVE-2024-53092-0060@gregkh/

Introduced by commit 4c3b54a ("virtio_pci_modern: use completion
instead of busy loop to wait on admin cmd result") in v6.11-rc2.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97ee04feb682c906a1fa973ebe586fe91567d165]

CVE-2024-53093: nvme-multipath: defer partition scanning

Announce: https://lore.kernel.org/linux-cve-announce/2024112152-CVE-2024-53093-f854@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc4.

Fixed status
mainline: [1f021341eef41e77a633186e9be5223de2ce5d48]
stable/6.1: [60de2e03f984cfbcdc12fa552f95087c35a05a98]
stable/6.6: [4a57f42e5ed42cb8f1beb262c4f6d3e698939e4e]

CVE-2024-53094: RDMA/siw: Add sendpage_ok() check to disable MSG_SPLICE_PAGES

Announce: https://lore.kernel.org/linux-cve-announce/2024112152-CVE-2024-53094-7059@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc4.

Fixed status
mainline: [4e1e3dd88a4cedd5ccc1a3fc3d71e03b70a7a791]
stable/6.6: [3406bfc813a9bbd9c3055795e985f527b7852e8c]

CVE-2024-53095: smb: client: Fix use-after-free of network namespace.

Announce: https://lore.kernel.org/linux-cve-announce/2024112152-CVE-2024-53095-7ffd@gregkh/

Introduced by commit 26abe14 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets.") in v4.2-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef7134c7fc48e1441b398e55a862232868a6f0a7]
stable/6.6: [e8c71494181153a134c96da28766a57bd1eac8cb]

CVE-2024-53096: mm: resolve faulty mmap_region() error path behaviour

Announce: https://lore.kernel.org/linux-cve-announce/2024112506-CVE-2024-53096-5bcc@gregkh/

Introduced by commit deb0f65 ("mm/mmap: undo ->mmap() when
arch_validate_flags() fails") in v6.1-rc1.
Fixed in v6.12-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [5de195060b2e251a835f622759550e6202167641]
stable/6.1: [52c81fd0f5a8bf8032687b94ccf00d13b44cc5c8]
stable/6.6: [bdc136e2b05fabcd780fe5f165d154eb779dfcb0]

CVE-2024-53097: mm: krealloc: Fix MTE false alarm in __do_krealloc

Announce: https://lore.kernel.org/linux-cve-announce/2024112505-CVE-2024-53097-cd93@gregkh/

Introduced by commit 1a83a71 ("mm: krealloc: consider spare memory for
__GFP_ZERO") in
6.12-rc1. Fixed in 6.12-rc6.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.11 stable/6.6

Fixed status
mainline: [704573851b51808b45dae2d62059d1d8189138a2]
stable/5.10: [8ebee7565effdeae6085458f8f8463363120a871]
stable/5.15: [d02492863023431c31f85d570f718433c22b9311]
stable/5.4: [8ebee7565effdeae6085458f8f8463363120a871]
stable/6.1: [d43f1430d47c22a0727c05b6f156ed25fecdfeb4]
stable/6.6: [486aeb5f1855c75dd810c25036134961bd2a6722]

CVE-2024-53098: drm/xe/ufence: Prefetch ufence addr to catch bogus address

Announce: https://lore.kernel.org/linux-cve-announce/2024112506-CVE-2024-53098-2135@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc5.
It looks as if this bug was introduced by commit 9c1813b
("drm/xe/ufence: Prefetch
ufence addr to catch bogus address") in 6.12-rc5.
Bug introduced commit was backported to following branches.
stable/6.11

Fixed status
mainline: [9c1813b3253480b30604c680026c7dc721ce86d1]

CVE-2024-53099: bpf: Check validity of link->type in bpf_link_show_fdinfo()

Announce: https://lore.kernel.org/linux-cve-announce/2024112506-CVE-2024-53099-e454@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc5.
It looks as if this bug was introdcued by commit f2e10bf ("bpf: Add support for
BPF_OBJ_GET_INFO_BY_FD for bpf_link") in 5.8-rc1.

Fixed status
mainline: [8421d4c8762bd022cb491f2f0f7019ef51b4f0a7]
stable/6.6: [d5092b0a1aaf35d77ebd8d33384d7930bec5cb5d]

CVE-2024-53100: nvme: tcp: avoid race between queue_lock lock and destroy

Announce: https://lore.kernel.org/linux-cve-announce/2024112506-CVE-2024-53100-0d0d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc4.
It looks as if this bug was introduced by commit 76d54bf ("nvme-tcp: don't
access released socket during error recovery") in 6.3-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [782373ba27660ba7d330208cf5509ece6feb4545]
stable/6.1: [4f946479b326a3cbb193f2b8368aed9269514c35]
stable/6.6: [975cb1d2121511584695d0e47fdb90e6782da007]

CVE-2024-53101: fs: Fix uninitialized value issue in from_kuid and from_kgid

Announce: https://lore.kernel.org/linux-cve-announce/2024112506-CVE-2024-53101-203a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc5.
It looks as if this bug was introduced by commit 468eedd ("ocfs2: Remove mlog(0)
from fs/ocfs2/file.c") in 2.6.39-rc1.

Fixed status
mainline: [15f34347481648a567db67fb473c23befb796af5]
stable/4.19: [a0c77e5e3dcbffc7c6080ccc89c037f0c86496cf]
stable/5.10: [9db25c2b41c34963c3ccf473b08171f87670652e]
stable/5.15: [b3e612bd8f64ce62e731e95f635e06a2efe3c80c]
stable/5.4: [17ecb40c5cc7755a321fb6148cba5797431ee5b8]
stable/6.1: [5a72b0d3497b818d8f000c347a7c11801eb27bfc]
stable/6.6: [1cb5bfc5bfc651982b6203c224d49b7ddacf28bc]

CVE-2024-53102: nvme: make keep-alive synchronous operation

Announce: https://lore.kernel.org/linux-cve-announce/2024112507-CVE-2024-53102-a45c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc4.

Fixed status
mainline: [d06923670b5a5f609603d4a9fee4dec02d38de9c]
stable/6.1: [afa229465399f89d3af9d72ced865144c9748846]
stable/6.6: [1a1bcca5c9efd2c72c8d2fcbadf2d673cceb2ea7]

* Updated CVEs

CVE-2022-45888: char: xillybus: Fix use-after-free in xillyusb_open()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c2dcdaa27d0a00bd8ac3a415d7f4c811631d4f5c]

CVE-2023-52812: drm/amd: check num of link levels when update pcie param

stable/6.1 was fixed.

Fixed status
stable/6.1: [2f2d48b6247ae3001f83c98730b3cce475cb2927]
stable/6.6: [09f617219fe9ccd8d7b65dc3e879b5889f663b5a]

CVE-2024-26952: ksmbd: fix potencial out-of-bounds when buffer offset is invalid

stable/6.1 was fixed.

Fixed status
stable/6.1: [ad6480c9a5d884e2704adc51d69895d93339176c]
stable/6.6: [39bdc4197acf2ed13269167ccf093ee28cfa2a4e]
stable/6.8: [0c5541b4c980626fa3cab16ba1a451757778bbb5]

CVE-2024-26954: ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d70c2e0904ab3715c5673fd45788a464a246d1db]
stable/6.8: [4f97e6a9d62cb1fce82fbf4baff44b83221bc178]

CVE-2024-35964: Bluetooth: ISO: Fix not validating setsockopt user input

stable/6.1 was fixed.

Fixed status
stable/6.1: [cec736e60dc18d91b88af28d96664bff284b02d1]
stable/6.6: [6a6baa1ee7a9df33adbf932305053520b9741b35]
stable/6.8: [0c4a89f4690478969729c7ba5f69d53d8516aa12]

CVE-2024-36244: net/sched: taprio: extend minimum interval restriction
to entire cycle too

stable/6.1 was fixed.

Fixed status
stable/6.1: [34d83c3e6e97867ae061d14eb52123404aab1cbc]
stable/6.6: [b939d1e04a90248b4cdf417b0969c270ceb992b2]
stable/6.9: [91f249b01fe490fce11fbb4307952ca8cce78724]

CVE-2024-36478: null_blk: fix null-ptr-dereference while configuring
'power' and 'submit_queues'

stable/6.1 was fixed.

Fixed status
stable/6.1: [1d4c8baef435c98e8d5aa7027dc5a9f70834ba16]
stable/6.6: [aaadb755f2d684f715a6eb85cb7243aa0c67dfa9]
stable/6.9: [5d0495473ee4c1d041b5a917f10446a22c047f47]

CVE-2024-36915: nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies

stable/6.1 was fixed.

Fixed status
stable/6.1: [298609e7069ce74542a2253a39ccc9717f1d877a]
stable/6.6: [0f106133203021533cb753e80d75896f4ad222f8]

CVE-2024-36923: fs/9p: fix uninitialized values during inode evict

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [18cf7026355187b8d2b4cdfed61dbf873e9d29ff]
stable/6.6: [3a741b80b3457f079cf637e47800fb7bf8038ad6]

CVE-2024-38553: net: fec: remove .ndo_poll_controller to avoid deadlocks

stable/6.1 was fixed.

Fixed status
stable/6.1: [e2348d8c61d03feece1de4c05f72e6e99f74c650]
stable/6.6: [d38625f71950e79e254515c5fc585552dad4b33e]
stable/6.9: [87bcbc9b7e0b43a69d44efa5f32f11e32d08fa6f]

CVE-2024-42129: leds: mlxreg: Use devm_mutex_init() for mutex initialization

stable/6.6 was fixed.

Fixed status
stable/6.6: [172ffd26a5af13e951d0e82df7cfc5a95b04fa80]

CVE-2024-42322: ipvs: properly dereference pe in ip_vs_add_service

stable/6.1 was fixed.

Fixed status
stable/6.1: [b2c664df3bb46aabac6a5fd78aaa5bd614cfad97]
stable/6.10: [c420cd5d5bc6797f3a8824e7d74f38f0c286fca5]
stable/6.6: [3dd428039e06e1967ce294e2cd6342825aaaad77]

CVE-2024-44949: parisc: fix a possible DMA corruption

stable/6.1 was fixed.

Fixed status
stable/6.1: [00baca74fb5879e5f9034b6156671301f500f8ee]
stable/6.10: [533de2f470baac40d3bf622fe631f15231a03c9f]
stable/6.6: [642a0b7453daff0295310774016fcb56d1f5bc7f]

CVE-2024-49974: NFSD: Limit the number of concurrent async COPY operations

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7ea9260874b779637aff6d24c344b8ef4ac862a0]
stable/6.11: [6a488ad7745b8f64625c6d3a24ce7e448e83f11b]
stable/6.6: [ae267989b7b7933dfedcd26468d0a88fc3a9da9e]

CVE-2024-50221: drm/amd/pm: Vangogh: Fix kernel memory out of bounds write

stable/6.6 was fixed.

Fixed status
stable/6.11: [f8fd9f0d57af4f8f48b383ec28287af85b47cb9f]
stable/6.6: [f111de0f010308949254ee1cc45df8e6b8e1d7d4]

CVE-2024-50241: NFSD: Initialize struct nfsd4_copy earlier

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [c3074003fa6837c2b89a34d8d12d9463b59d22d6]
stable/6.11: [e30a9a2f69c34a00a3cb4fd45c5d231929e66fb1]
stable/6.6: [421f1a2a1afb47d88de09457ef7687e1df7bc997]

CVE-2024-50242: fs/ntfs3: Additional check in ntfs_file_release

stable/6.1 was fixed.

Fixed status
stable/6.1: [d1ac7e2620302e3e49573df39bd4e868e8b4962a]
stable/6.11: [82685eb6ca1db2bd11190451085bcb86ed03aa24]
stable/6.6: [550ef40fa6366d5d11b122e5f36b1f9aa20c087e]

CVE-2024-53073: NFSD: Never decrement pending_async_copies on error

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [949ee5d44d1fd95119b29b3382a933cdc617bf9e]
stable/6.11: [1421883aa30c5d26bc3370e2d19cb350f0d5ca28]
stable/6.6: [fb79d68a36e21960341ccab07d1ac06d93830321]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

