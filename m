Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F24C3DA7F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 22:19:12 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web11.46771.1723069150859474302
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Aug 2024 15:19:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=FSMEw+jr;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c667b28c82so164358eaf.1
        for <cip-dev@lists.cip-project.org>; Wed, 07 Aug 2024 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1723069150; x=1723673950; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XGdpCrZ1bvkISn9AN0caW0DzLcLO2PFgHPXhMfUYFic=;
        b=FSMEw+jrnXHi70P8H7x0E0qEi2DIlgOn+uCSM9hWTamYsI5iFqxIzJkplEnGJFpsKa
         8m5F2Ks3VMwMgfacAHqcgVdMQT9W02p/mPyOmq7UOtV0oG/polHhZHwXOqVVUb/rFQiG
         uvfG7f1G4a46pL7Y8yTKZqY6FFyQtqSjbNFT/8a7EcoTxWVSA9ohmgkYPxnOvSEo5Roo
         DpUGYqYV0s9Cv7AvVfzuHWKimQLxURredOPW8tGfT1XAZboV6j/ysUuPPEWzYZmuPDAu
         dZLvY2ixORGfJK646PI3ar5gf5jeEzZVvVjUKYyF6hHzdGFwExHpvnqjEUxFfk6arrFk
         EOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069150; x=1723673950;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGdpCrZ1bvkISn9AN0caW0DzLcLO2PFgHPXhMfUYFic=;
        b=tZKDaTXb+TeuzMmxLZd5k4b2pva11CcTLVoml+CV6ri8DWzEiOwC35FnbmLuHmWUI2
         yEOQDkJyWbIKofqSmoAviT28dYelEDWIWh6MuJxh23svG4spLEx2SIokaZgbGvfpq4Ye
         +7kKYNz6EoAdV9d2Mu98pzkCzTZQThuswBuR0SjmZnxw0g+u1g8Fjjbf9F1HK7UkSuxF
         FfERMC1dNcn4bAGXPmqQduWY3zAh2o7O0o1WyH7V+/naqPfoRWMF7TCPeT/0WUNw2bW6
         DVgNd7emIPobPSySIPxEQWwi9QzT7W1Yd7M1vtZFVBhtdblLUZu0CCoYGAreqMYP+VvL
         Qjgg==
X-Gm-Message-State: AOJu0Yz6u6gA7PQLAyOPMq1wV+a2QvzyQlAqI6WxP6+62xB5fioGVvx3
	ds6d73twhLnfc461VnCm2XLS294v6QaJPemHdqo4f1UHYK+L+b5IjIqTikn4sNJuL0EVkKDdP2S
	7nvGncxAmjg8CaFVll43BEnr+XgrttNVlMUjtlEDs9h5YqkwwH6I=
X-Google-Smtp-Source: AGHT+IFzsFuqUnZHgXaqSxMnhzPV7UiNfkvxMY7fo65B1FYrCk9f77wkMzUxKghqicpNjqDCFkr2r8doIh97fyxRx0A=
X-Received: by 2002:a05:6820:1786:b0:5d6:ab0:b9a6 with SMTP id
 006d021491bc7-5d8457ecd12mr1641166eaf.4.1723069148754; Wed, 07 Aug 2024
 15:19:08 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 Aug 2024 07:18:32 +0900
Message-ID: <CAODzB9o0QU7y72jeii3APPAqzmGrrnXH3VZbuVX_RmreeYYRQA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Aug 2024 22:19:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16761

Hi!

It's this week's CVE report.

This week reported 19 new CVEs and 58 updated CVEs.

* New CVEs

CVE-2024-42232: libceph: fix race between delayed_work() and ceph_monc_stop()

Announce: https://lore.kernel.org/linux-cve-announce/2024080737-CVE-2024-42232-8ab2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10.

Fixed status
cip/4.4: [2a1697e925071b330bb9a66a8c200ea4d0dfc18e]
cip/4.4-st: [2a1697e925071b330bb9a66a8c200ea4d0dfc18e]
mainline: [69c7b2fe4c9cc1d3b1186d1c5606627ecf0de883]
stable/4.19: [1177afeca833174ba83504688eec898c6214f4bf]
stable/5.10: [34b76d1922e41da1fa73d43b764cddd82ac9733c]
stable/5.15: [20cf67dcb7db842f941eff1af6ee5e9dc41796d7]
stable/5.4: [63e5d035e3a7ab7412a008f202633c5e6a0a28ea]
stable/6.1: [2d33654d40a05afd91ab24c9a73ab512a0670a9a]
stable/6.6: [9525af1f58f67df387768770fcf6d6a8f23aee3d]

CVE-2024-42233: filemap: replace pte_offset_map() with pte_offset_map_nolock()

Announce: https://lore.kernel.org/linux-cve-announce/2024080739-CVE-2024-42233-7fc5@gregkh/

Introduced by commit 58f327f ("filemap: avoid unnecessary major faults
in filemap_fault()") in v6.9-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24be02a42181f0707be0498045c4c4b13273b16d]

CVE-2024-42234: mm: fix crashes from deferred split racing folio migration

Announce: https://lore.kernel.org/linux-cve-announce/2024080739-CVE-2024-42234-1016@gregkh/

Introduced by commit 9bcef59 ("mm: memcg: fix split queue list crash
when large folio migration") in v6.7.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be9581ea8c058d81154251cb0695987098996cad]

CVE-2024-42235: s390/mm: Add NULL pointer check to crst_table_free()
base_crst_free()

Announce: https://lore.kernel.org/linux-cve-announce/2024080740-CVE-2024-42235-efae@gregkh/

Introduced by commit 6326c26 ("s390: convert various pgalloc functions
to use ptdescs") in v6.6-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5efb63acf7bddaf20eacfcac654c25c446eabe8]
stable/6.6: [794fa52b94637d6b2e8c9474fbe3983af5c9f046]

CVE-2024-42236: usb: gadget: configfs: Prevent OOB read/write in
usb_string_copy()

Announce: https://lore.kernel.org/linux-cve-announce/2024080740-CVE-2024-42236-365d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10.

Fixed status
cip/4.4: [635be42972505074c0d89fdc98a0ff5708c9a54f]
cip/4.4-st: [635be42972505074c0d89fdc98a0ff5708c9a54f]
mainline: [6d3c721e686ea6c59e18289b400cc95c76e927e0]
stable/4.19: [a444c3fc264119801575ab086e03fb4952f23fd0]
stable/5.10: [e8474a10c535e6a2024c3b06e37e4a3a23beb490]
stable/5.15: [72b8ee0d9826e8ed00e0bdfce3e46b98419b37ce]
stable/5.4: [c95fbdde87e39e5e0ae27f28bf6711edfb985caa]
stable/6.1: [2d16f63d8030903e5031853e79d731ee5d474e70]
stable/6.6: [d1205033e912f9332c1dbefa812e6ceb0575ce0a]

CVE-2024-42237: firmware: cs_dsp: Validate payload length before
processing block

Announce: https://lore.kernel.org/linux-cve-announce/2024080740-CVE-2024-42237-eba4@gregkh/

Introduced by commit f6bc909 ("firmware: cs_dsp: add driver to support
firmware loading on Cirrus Logic DSPs") in v5.16-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6598afa9320b6ab13041616950ca5f8f938c0cf1]
stable/6.1: [259955eca9b7acf1299b1ac077d8cfbe12df35d8]
stable/6.6: [3a9cd924aec1288d675df721f244da4dd7e16cff]

CVE-2024-42238: firmware: cs_dsp: Return error if block header overflows file

Announce: https://lore.kernel.org/linux-cve-announce/2024080740-CVE-2024-42238-a5fd@gregkh/

Introduced by commit f6bc909 ("firmware: cs_dsp: add driver to support
firmware loading on Cirrus Logic DSPs") in v5.16-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [959fe01e85b7241e3ec305d657febbe82da16a02]
stable/6.1: [b8be70566b33abbd0180105070b4c67cfef8c44f]
stable/6.6: [90ab191b7d181057d71234e8632e06b5844ac38e]

CVE-2024-42239: bpf: Fail bpf_timer_cancel when callback is being cancelled

Announce: https://lore.kernel.org/linux-cve-announce/2024080740-CVE-2024-42239-a15f@gregkh/

Introduced by commit b00628b ("bpf: Introduce bpf timers.") in v5.15-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4523831f07a267a943f0dde844bf8ead7495f13]
stable/6.6: [9369830518688ecd5b08ffc08ab3302ce2b5d0f7]

CVE-2024-42240: x86/bhi: Avoid warning in #DB handler due to BHI mitigation

Announce: https://lore.kernel.org/linux-cve-announce/2024080741-CVE-2024-42240-3d04@gregkh/

Introduced by commit 7390db8 ("x86/bhi: Add support for clearing
branch history at syscall entry") in v6.9-rc4.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [ac8b270b61d48fcc61f052097777e3b5e11591e0]
stable/5.15: [db56615e96c439e13783d7715330e824b4fd4b84]
stable/6.1: [a765679defe1dc1b8fa01928a6ad6361e72a1364]
stable/6.6: [dae3543db8f0cf8ac1a198c3bb4b6e3c24d576cf]

CVE-2024-42241: mm/shmem: disable PMD-sized page cache if needed

Announce: https://lore.kernel.org/linux-cve-announce/2024080741-CVE-2024-42241-baee@gregkh/

Introduced by commit 6b24ca4 ("mm: Use multi-index entries in the page
cache") in v5.17-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fd154ba926b34c833b7bfc4c14ee2e931b3d743]
stable/6.6: [93893eacb372b0a4a30f7de6609b08c3ba6c4fd9]

CVE-2024-42242: mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE

Announce: https://lore.kernel.org/linux-cve-announce/2024080741-CVE-2024-42242-add7@gregkh/

Introduced by commit 616f876 ("mmc: pass queue_limits to
blk_mq_alloc_disk") in v6.9-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63d20a94f24fc1cbaf44d0e7c0e0a8077fde0aef]

CVE-2024-42243: mm/filemap: make MAX_PAGECACHE_ORDER acceptable to xarray

Announce: https://lore.kernel.org/linux-cve-announce/2024080741-CVE-2024-42243-2ed5@gregkh/

Introduced by commit 793917d ("mm/readahead: Add large folio
readahead") in v5.18-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [099d90642a711caae377f53309abfe27e8724a8b]
stable/6.6: [a0c42ddd0969fdc760a85e20e267776028a7ca4e]

CVE-2024-42244: USB: serial: mos7840: fix crash on resume

Announce: https://lore.kernel.org/linux-cve-announce/2024080741-CVE-2024-42244-2346@gregkh/

Introduced by commit d83b405 ("USB: serial: add support for multiple
read urbs") in v3.3-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c15a688e49987385baa8804bf65d570e362f8576]
stable/5.10: [932a86a711c722b45ed47ba2103adca34d225b33]
stable/5.15: [b14aa5673e0a8077ff4b74f0bb260735e7d5e6a4]
stable/6.1: [1094ed500987e67a9d18b0f95e1812f1cc720856]
stable/6.6: [5ae6a64f18211851c8df6b4221381c438b9a7348]

CVE-2024-42245: Revert "sched/fair: Make sure to try to detach at
least one movable task"

Announce: https://lore.kernel.org/linux-cve-announce/2024080742-CVE-2024-42245-1413@gregkh/

Introduced by commit b0defa7 ("sched/fair: Make sure to try to detach
at least one movable task") in v6.1-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2feab2492deb2f14f9675dd6388e9e2bf669c27a]
stable/6.1: [d467194018dd536fe6c65a2fd3aedfcdb1424903]
stable/6.6: [1e116c18e32b035a2d1bd460800072c8bf96bc44]

CVE-2024-42246: net, sunrpc: Remap EPERM in case of connection failure
in xs_tcp_setup_socket

Announce: https://lore.kernel.org/linux-cve-announce/2024080742-CVE-2024-42246-0777@gregkh/

Introduced by commit d74bad4 ("bpf: Hooks for sys_connect") in v4.17-rc1.
Introduced by commit 4fbac77 ("bpf: Hooks for sys_bind") in v4.17-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [626dfed5fa3bfb41e0dffd796032b555b69f9cde]
stable/6.1: [f2431e7db0fe0daccb2f06bb0d23740affcd2fa6]
stable/6.6: [d6c686c01c5f12ff8f7264e0ddf71df6cb0d4414]

CVE-2024-42247: wireguard: allowedips: avoid unaligned 64-bit memory accesses

Announce: https://lore.kernel.org/linux-cve-announce/2024080742-CVE-2024-42247-5243@gregkh/

Introduced by commit e7096c1 ("net: WireGuard secure network tunnel")
in v5.6-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [948f991c62a4018fb81d85804eeab3029c6209f8]
stable/5.10: [ae630de24efb123d7199a43256396d7758f4cb75]
stable/5.15: [b4764f0ad3d68de8a0b847c05f427afb86dd54e6]
stable/6.1: [217978a29c6ceca76d3c640bf94bdf50c268d801]
stable/6.6: [6638a203abad35fa636d59ac47bdbc4bc100fd74]

CVE-2024-42248: tty: serial: ma35d1: Add a NULL check for of_node

Announce: https://lore.kernel.org/linux-cve-announce/2024080742-CVE-2024-42248-e682@gregkh/

Introduced by commit 930cbf9 ("tty: serial: Add Nuvoton ma35d1 serial
driver support") in v6.5-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acd09ac253b5de8fd79fc61a482ee19154914c7a]
stable/6.6: [23efa74cfe6eb923abb5b9bc51b2a04879013c67]

CVE-2024-42249: spi: don't unoptimize message in spi_async()

Announce: https://lore.kernel.org/linux-cve-announce/2024080742-CVE-2024-42249-ada7@gregkh/

Introduced by commit 7b1d87a ("spi: add spi_optimize_message() APIs")
in v6.9-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c86a918b1bdba78fb155184f8d88dfba1e63335d]

CVE-2024-42250: cachefiles: add missing lock protection when polling

Announce: https://lore.kernel.org/linux-cve-announce/2024080743-CVE-2024-42250-9580@gregkh/

Introduced by commit b817e22 ("cachefiles: narrow the scope of
triggering EPOLLIN events in ondemand mode") in v6.8-rc1.
Fixed in v6.6.41.
Bug introduced commit was backported to following branches.
cip/6.1 stable/6.1 stable/6.6

Fixed status
mainline: [6bb6bd3dd6f382dfd36220d4b210a0c77c066651]
stable/6.1: [97cfd5e20ddc2e33e16ce369626ce76c9a475fd7]
stable/6.6: [6bb6bd3dd6f382dfd36220d4b210a0c77c066651]

* Updated CVEs

CVE-2024-41021: s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()

stable/6.6 was fixed.

Fixed status
stable/6.10: [a3aefb871222a9880602d1a44a558177b4143e3b]
stable/6.6: [73a9260b7366d2906ec011e100319359fe2277d0]

CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [3f54a6a7702d875a5331f8546c1a6138f35a5ebd]
cip/4.4-st: [3f54a6a7702d875a5331f8546c1a6138f35a5ebd]
stable/4.19: [5bb642cc3355ffd3c8bca0a8bd8e6e65bcc2091c]
stable/5.10: [3b32f265805a49071e2c4568a524398ba22bf93c]
stable/5.15: [fcd31dd8291b23d713245947ec2b2d99ef07aef2]
stable/5.4: [d529193eae979a7bf2255cd9fe68b7af7a1c91b3]

CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [5c12cc6581e30b07ce31c6af049df89b3494b2c5]
cip/4.4-st: [5c12cc6581e30b07ce31c6af049df89b3494b2c5]
stable/4.19: [fda6d62642a9c544a293d7ad7cb058f8c7f8f3dd]
stable/5.10: [ea2ed3f78ab238865b9b9e19a85c1de16d570ab7]
stable/5.15: [5088b4d4f91f15f02f52f3f3d4eb5968a6a3cb51]
stable/5.4: [f194e63054458b8f5019b294529409875be13c0c]

CVE-2023-52803: SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [410fcd8ea8f7b421568195217f949d7fb03a26b7]
cip/4.4-st: [410fcd8ea8f7b421568195217f949d7fb03a26b7]
stable/4.19: [17866066b8ac1cc38fb449670bc15dc9fee4b40a]
stable/5.10: [dedf2a0eb9448ae73b270743e6ea9b108189df46]
stable/5.15: [194454afa6aa9d6ed74f0c57127bc8beb27c20df]
stable/5.4: [7d61d1da2ed1f682c41cae0c8d4719cdaccee5c5]
stable/6.1: [7749fd2dbef72a52b5c9ffdbf877691950ed4680]
stable/6.6: [cc2e7ebbeb1d0601f7f3c8d93b78fcc03a95e44a]

CVE-2024-36484: net: relax socket state check at accept time.

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [c7ec2b3b28888ad20be7f139f9b88930b793594c]
cip/4.4-st: [c7ec2b3b28888ad20be7f139f9b88930b793594c]
stable/4.19: [7de00adc9bd035d861ba4177848ca0bfa5ed1e04]
stable/5.10: [6e03006548c66b979f4e5e9fc797aac4dad82822]
stable/5.15: [21c14c556cccd0cb54b71ec5e901e64ba84c7165]
stable/5.4: [59801e88c99f7c3f44a4d20af6ba6417aa359b5d]
stable/6.1: [c09ddc605893df542c6cf8dde6a57a93f7cf0adb]
stable/6.6: [87bdc9f6f58b4417362d6932b49b828e319f97dc]
stable/6.9: [5f9a04a94fd1894d7009055ab8e5832a0242dba3]

CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and
AIO request complete

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [3e81dbc5a4e437c32ab06976ee3370c2b358788e]
cip/4.4-st: [3e81dbc5a4e437c32ab06976ee3370c2b358788e]
stable/4.19: [f71a53148ce34898fef099b75386a3a9f4449311]
stable/5.10: [e500b1c4e29ad0bd1c1332a1eaea2913627a92dd]
stable/5.15: [3613e5023f09b3308545e9d1acda86017ebd418a]
stable/5.4: [9e72ef59cbe61cd1243857a6418ca92104275867]
stable/6.1: [a0fdccb1c9e027e3195f947f61aa87d6d0d2ea14]
stable/6.6: [73c05ad46bb4fbbdb346004651576d1c8dbcffbb]

CVE-2024-37078: nilfs2: fix potential kernel bug due to lack of
writeback flag waiting

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [1e7f203b63f441656b9cae0ca555017a80798f03]
cip/4.4-st: [1e7f203b63f441656b9cae0ca555017a80798f03]
stable/4.19: [95f6f81e50d858a7c9aa7c795ec14a0ac3819118]
stable/5.10: [0ecfe3a92869a59668d27228dabbd7965e83567f]
stable/5.15: [33900d7eae616647e179eee1c66ebe654ee39627]
stable/5.4: [a75b8f493dfc48aa38c518430bd9e03b53bffebe]
stable/6.1: [271dcd977ccda8c7a26e360425ae7b4db7d2ecc0]
stable/6.6: [614d397be0cf43412b3f94a0f6460eddced8ce92]
stable/6.9: [1f3bff69f1214fe03a02bc650d5bbfaa6e65ae7d]

CVE-2024-38619: usb-storage: alauda: Check whether the media is initialized

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [0df99958f148819719e8360edca9d013dbfd3325]
cip/4.4-st: [0df99958f148819719e8360edca9d013dbfd3325]
stable/4.19: [e0aab7b07a9375337847c9d74a5ec044071e01c8]
stable/5.10: [f68820f1256b21466ff094dd97f243b7e708f9c1]
stable/5.15: [3eee13ab67f65606faa66e0c3c729e4f514838fd]
stable/5.4: [51fe16c058acb22f847e69bc598066ed0bcd5c15]
stable/6.1: [e0e2eec76920a133dd49a4fbe4656d83596a1361]
stable/6.6: [2cc32639ec347e3365075b130f9953ef16cb13f1]
stable/6.9: [24bff7f714bdff97c2a75a0ff6a368cdf8ad5af4]

CVE-2024-39469: nilfs2: fix nilfs_empty_dir() misjudgment and long
loop on I/O errors

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [65ea5a47714a3c763788660142a8b19b1863cb11]
cip/4.4-st: [65ea5a47714a3c763788660142a8b19b1863cb11]
stable/4.19: [2ac8a2fe22bdde9eecce2a42cf5cab79333fb428]
stable/5.10: [c77ad608df6c091fe64ecb91f41ef7cb465587f1]
stable/5.15: [11a2edb70356a2202dcb7c9c189c8356ab4752cd]
stable/5.4: [405b71f1251e5ae865f53bd27c45114e6c83bee3]
stable/6.1: [129dcd3e7d036218db3f59c82d82004b9539ed82]
stable/6.6: [d18b05eda7fa77f02114f15b02c009f28ee42346]
stable/6.9: [59f14875a96ef93f05b82ad3c980605f2cb444b5]

CVE-2024-39487: bonding: Fix out-of-bounds read in
bond_option_arp_ip_targets_set()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [7aa46ac8326ddf242d76f1fc86a4af47fb6f7da4]
cip/4.4-st: [7aa46ac8326ddf242d76f1fc86a4af47fb6f7da4]
stable/4.19: [6a8a4fd082c439e19fede027e80c79bc4c84bb8e]
stable/5.10: [707c85ba3527ad6aa25552033576b0f1ff835d7b]
stable/5.15: [bfd14e5915c2669f292a31d028e75dcd82f1e7e9]
stable/5.4: [6b21346b399fd1336fe59233a17eb5ce73041ee1]
stable/6.1: [c8eb8ab9a44ff0e73492d0a12a643c449f641a9f]
stable/6.6: [b75e33eae8667084bd4a63e67657c6a5a0f8d1e8]
stable/6.9: [9f835e48bd4c75fdf6a9cff3f0b806a7abde78da]

CVE-2024-39499: vmci: prevent speculation leaks by sanitizing event in
event_deliver()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [6f6ce9e70228216d326b84bea958213a7677b816]
cip/4.4-st: [6f6ce9e70228216d326b84bea958213a7677b816]
stable/4.19: [58730dfbd4ae01c1b022b0d234a8bf8c02cdfb81]
stable/5.10: [f70ff737346744633e7b655c1fb23e1578491ff3]
stable/5.15: [95ac3e773a1f8da83c4710a720fbfe80055aafae]
stable/5.4: [681967c4ff210e06380acf9b9a1b33ae06e77cbd]
stable/6.1: [95bac1c8bedb362374ea1937b1d3e833e01174ee]
stable/6.6: [e293c6b38ac9029d76ff0d2a6b2d74131709a9a8]
stable/6.9: [757804e1c599af5d2a7f864c8e8b2842406ff4bb]

CVE-2024-39501: drivers: core: synchronize really_probe() and dev_uevent()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [3aab177a1bec463f4b13a3504c6530e7a5887f40]
cip/4.4-st: [3aab177a1bec463f4b13a3504c6530e7a5887f40]
stable/4.19: [bb3641a5831789d83a58a39ed4a928bcbece7080]
stable/5.10: [760603e30bf19d7b4c28e9d81f18b54fa3b745ad]
stable/5.15: [ec772ed7cb21b46fb132f89241682553efd0b721]
stable/5.4: [13d25e82b6d00d743c7961dcb260329f86bedf7c]
stable/6.1: [08891eeaa97c079b7f95d60b62dcf0e3ce034b69]
stable/6.6: [a42b0060d6ff2f7e59290a26d5f162a3c6329b90]
stable/6.9: [95d03d369ea647b89e950667f1c3363ea6f564e6]

CVE-2024-39509: HID: core: remove unnecessary WARN_ON() in implement()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [dff699deb33958ea317f0e29f1f1a0e777085d46]
cip/4.4-st: [dff699deb33958ea317f0e29f1f1a0e777085d46]
stable/4.19: [955b3764671f3f157215194972d9c01a3a4bd316]
stable/5.10: [33f6832798dd3297317901cc1db556ac3ae80c24]
stable/5.15: [8bac61934cd563b073cd30b8cf6d5c758ab5ab26]
stable/5.4: [f9db5fbeffb951cac3f0fb1c2eeffb79785399ca]
stable/6.1: [bfd546fc7fd76076f81bf41b85b51ceda30949fd]
stable/6.6: [30f76bc468b9b2cbbd5d3eb482661e3e4798893f]
stable/6.9: [655c6de2f215b61d0708db6b06305eee9bbfeba2]

CVE-2024-40902: jfs: xattr: fix buffer overflow for invalid xattr

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [88840af6e4f2111c425c262cd529589c00691a02]
cip/4.4-st: [88840af6e4f2111c425c262cd529589c00691a02]
stable/4.19: [f0dedb5c511ed82cbaff4997a8decf2351ba549f]
stable/5.10: [fc745f6e83cb650f9a5f2c864158e3a5ea76dad0]
stable/5.15: [480e5bc21f2c42d90c2c16045d64d824dcdd5ec7]
stable/5.4: [1e84c9b1838152a87cf453270a5fa75c5037e83a]
stable/6.1: [33aecc5799c93d3ee02f853cb94e201f9731f123]
stable/6.6: [4598233d9748fe4db4e13b9f473588aa25e87d69]
stable/6.9: [b537cb2f4c4a1357479716a9c339c0bda03d873f]

CVE-2024-40904: USB: class: cdc-wdm: Fix CPU lockup caused by
excessive log messages

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [524f2530dd2fb31e63e7f7dd07e3bf47e105261e]
cip/4.4-st: [524f2530dd2fb31e63e7f7dd07e3bf47e105261e]
stable/4.19: [217d1f44fff560b3995a685a60aa66e55a7f0f56]
stable/5.10: [c0747d76eb05542b5d49f67069b64ef5ff732c6c]
stable/5.15: [53250b54c92fe087fd4b0c48f85529efe1ebd879]
stable/5.4: [05b2cd6d33f700597e6f081b53c668a226a96d28]
stable/6.1: [02a4c0499fc3a02e992b4c69a9809912af372d94]
stable/6.6: [72a3fe36cf9f0d030865e571f45a40f9c1e07e8a]
stable/6.9: [82075aff7ffccb1e72b0ac8aa349e473624d857c]

CVE-2024-40912: wifi: mac80211: Fix deadlock in
ieee80211_sta_ps_deliver_wakeup()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [8d15b74b7db8a550df489145eb43b71d34ed2538]
cip/4.4-st: [8d15b74b7db8a550df489145eb43b71d34ed2538]
stable/4.19: [e51637e0c66a6f72d134d9f95daa47ea62b43c7e]
stable/5.10: [e7e916d693dcb5a297f40312600a82475f2e63bc]
stable/5.15: [d90bdff79f8e40adf889b5408bfcf521528b169f]
stable/5.4: [28ba44d680a30c51cf485a2f5a3b680e66ed3932]
stable/6.1: [9c49b58b9a2bed707e7638576e54c4bccd97b9eb]
stable/6.6: [456bbb8a31e425177dc0e8d4f98728a560c20e81]
stable/6.9: [47d176755d5c0baf284eff039560f8c1ba0ea485]

CVE-2024-40932: drm/exynos/vidi: fix memory leak in .get_modes()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [bd47c85672600303dff05f9ea950fe0005d72c36]
cip/4.4-st: [bd47c85672600303dff05f9ea950fe0005d72c36]
stable/4.19: [540ca99729e28dbe902b01039a3b4bd74520a819]
stable/5.10: [0acc356da8546b5c55aabfc2e2c5caa0ac9b0003]
stable/5.15: [777838c9b571674ef14dbddf671f372265879226]
stable/5.4: [ebcf81504fef03f701b9711e43fea4fe2d82ebc8]
stable/6.1: [dcba6bedb439581145d8aa6b0925209f23184ae1]
stable/6.6: [a269c5701244db2722ae0fce5d1854f5d8f31224]
stable/6.9: [cb3ac233434dba130281db330c4b15665b2d2c4d]

CVE-2024-40942: wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [6d5d4645521663af261e7b90bd8e463106693785]
cip/4.4-st: [6d5d4645521663af261e7b90bd8e463106693785]
stable/4.19: [377dbb220edc8421b7960691876c5b3bef62f89b]
stable/5.10: [7518e20a189f8659b8b83969db4d33a4068fcfc3]
stable/5.15: [c4c865f971fd4a255208f57ef04d814c2ae9e0dc]
stable/5.4: [ec79670eae430b3ffb7e0a6417ad7657728b8f95]
stable/6.1: [617dadbfb2d3e152c5753e28356d189c9d6f33c0]
stable/6.6: [63d5f89bb5664d60edbf8cf0df911aaae8ed96a4]
stable/6.9: [d81e244af521de63ad2883e17571b789c39b6549]

CVE-2024-40943: ocfs2: fix races between hole punching and AIO+DIO

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [9436fbd75e462b68135dbbcfa0545f709cec4585]
cip/4.4-st: [9436fbd75e462b68135dbbcfa0545f709cec4585]
stable/4.19: [3c26b5d21b1239e9c7fd31ba7d9b2d7bdbaa68d9]
stable/5.10: [050ce8af6838c71e872e982b50d3f1bec21da40e]
stable/5.15: [38825ff9da91d2854dcf6d9ac320a7e641e10f25]
stable/5.4: [e8e2db1adac47970a6a9225f3858e9aa0e86287f]
stable/6.1: [ea042dc2bea19d72e37c298bf65a9c341ef3fff3]
stable/6.6: [3c361f313d696df72f9bccf058510e9ec737b9b1]
stable/6.9: [117b9c009b72a6c2ebfd23484354dfee2d9570d2]

CVE-2024-40959: xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [b6e894e8ebf75230761fd8ac9a7f778ad30c0a7a]
cip/4.4-st: [b6e894e8ebf75230761fd8ac9a7f778ad30c0a7a]
stable/4.19: [c71761292d4d002a8eccb57b86792c4e3b3eb3c7]
stable/5.10: [20427b85781aca0ad072851f6907a3d4b2fed8d1]
stable/5.15: [9f30f1f1a51d91e19f5a09236bb0b59e6a07ad08]
stable/5.4: [caf0bec84c62fb1cf6f7c9f0e8c857c87f8adbc3]
stable/6.1: [83c02fb2cc0afee5bb53cddf3f34f045f654ad6a]
stable/6.6: [f897d7171652fcfc76d042bfec798b010ee89e41]
stable/6.9: [600a62b4232ac027f788c3ca395bc2333adeaacf]

CVE-2024-40968: MIPS: Octeon: Add PCIe link status check

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [1b6ce29b701c06f4bed6e244b1489bb47504b4ff]
cip/4.4-st: [1b6ce29b701c06f4bed6e244b1489bb47504b4ff]
stable/4.19: [6bff05aaa32c2f7e1f6e68e890876642159db419]
stable/5.10: [6c1b9fe148a4e03bbfa234267ebb89f35285814a]
stable/5.15: [25998f5613159fe35920dbd484fcac7ea3ad0799]
stable/5.4: [64845ac64819683ad5e51b668b2ed56ee3386aee]
stable/6.1: [d996deb80398a90dd3c03590e68dad543da87d62]
stable/6.6: [1c33fd17383f48f679186c54df78542106deeaa0]
stable/6.9: [38d647d509543e9434b3cc470b914348be271fe9]

CVE-2024-40974: powerpc/pseries: Enforce hcall result buffer validity and size

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [8e628c289ac83353cac4121de9cef849b110d3a9]
cip/4.4-st: [8e628c289ac83353cac4121de9cef849b110d3a9]
stable/4.19: [acf2b80c31c37acab040baa3cf5f19fbd5140b18]
stable/5.10: [a8c988d752b3d98d5cc1e3929c519a55ef55426c]
stable/5.15: [262e942ff5a839b9e4f3302a8987928b0c8b8a2d]
stable/5.4: [19c166ee42cf16d8b156a6cb4544122d9a65d3ca]
stable/6.1: [8aa11aa001576bf3b00dcb8559564ad7a3113588]
stable/6.6: [3ad0034910a57aa88ed9976b1431b7b8c84e0048]
stable/6.9: [aa6107dcc4ce9a3451f2d729204713783b657257]

CVE-2024-40981: batman-adv: bypass empty buckets in batadv_purge_orig_ref()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [da45256c36eb08076790b80237b9a2571f9208ed]
cip/4.4-st: [da45256c36eb08076790b80237b9a2571f9208ed]
stable/4.19: [79636f636126775436a11ee9cf00a9253a33ac11]
stable/5.10: [82cdea8f3af1e36543c937df963d108c60bea030]
stable/5.15: [92176caf9896572f00e741a93cecc0ef1172da07]
stable/5.4: [154e3f862ba33675cf3f4abf0a0a309a89df87d2]
stable/6.1: [fed7914858a1f1f3e6350bb0f620d6ef15107d16]
stable/6.6: [2685008a5f9a636434a8508419cee8158a2f52c8]
stable/6.9: [ae7f3cffe86aea3da0e8e079525a1ae619b8862a]

CVE-2024-40984: ACPICA: Revert "ACPICA: avoid Info: mapping multiple
BARs. Your kernel is fine."

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [c5c5b28cc15a48efa91f5f9585608bf0a71b4749]
cip/4.4-st: [c5c5b28cc15a48efa91f5f9585608bf0a71b4749]
stable/4.19: [435ecc978c3d5d0c4e172ec5b956dc1904061d98]
stable/5.10: [6eca23100e9030725f69c1babacd58803f29ec8d]
stable/5.15: [dc5017c57f5eee80020c73ff8b67ba7f9fd08b1f]
stable/5.4: [ae465109d82f4fb03c5adbe85f2d6a6a3d59124c]
stable/6.1: [ddc1f5f124479360a1fd43f73be950781d172239]
stable/6.6: [434c6b924e1f4c219aab2d9e05fe79c5364e37d3]
stable/6.9: [e21a4c9129c72fa54dd00f5ebf71219b41d43c04]

CVE-2024-40987: drm/amdgpu: fix UBSAN warning in kv_dpm.c

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [d285a56b23662c34dbb542192a1b848a65e13a8a]
cip/4.4-st: [d285a56b23662c34dbb542192a1b848a65e13a8a]
stable/4.19: [4ad7d49059358ceadd352b4e2511425bdb68f400]
stable/5.10: [d8a04a6bfa75251ba7bcc3651ed211e82f13f388]
stable/5.15: [4d020c1dbd2b2304f44d003e6de956ae570049dc]
stable/5.4: [1c44f7759a5650acf8f13d3e0a184d09e03be9e4]
stable/6.1: [fc5cb952e6723c5c55e47b8cf94a891bd4af1a86]
stable/6.6: [b065d79ed06a0bb4377bc6dcc2ff0cb1f55a798f]
stable/6.9: [b0d612619ed70cab476c77b19e00d13aa414e14f]

CVE-2024-40988: drm/radeon: fix UBSAN warning in kv_dpm.c

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [ede576cd852daf76626e1b0cdbd1328158986f78]
cip/4.4-st: [ede576cd852daf76626e1b0cdbd1328158986f78]
stable/4.19: [07e8f15fa16695cf4c90e89854e59af4a760055b]
stable/5.10: [febe794b83693257f21a23d2e03ea695a62449c8]
stable/5.15: [cf1cc8fcfe517e108794fb711f7faabfca0dc855]
stable/5.4: [a8c6df9fe5bc390645d1e96eff14ffe414951aad]
stable/6.1: [f803532bc3825384100dfc58873e035d77248447]
stable/6.6: [9e57611182a817824a17b1c3dd300ee74a174b42]
stable/6.9: [468a50fd46a09bba7ba18a11054ae64b6479ecdc]

CVE-2024-41006: netrom: Fix a memory leak in nr_heartbeat_expiry()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [feae50bfb78cac81efe947043b1bee5b617a4836]
cip/4.4-st: [feae50bfb78cac81efe947043b1bee5b617a4836]
stable/4.19: [d616876256b38ecf9a1a1c7d674192c5346bc69c]
stable/5.10: [5391f9db2cab5ef1cb411be1ab7dbec728078fba]
stable/5.15: [280cf1173726a7059b628c610c71050d5c0b6937]
stable/5.4: [e07a9c2a850cdebf625e7a1b8171bd23a8554313]
stable/6.1: [a02fd5d775cf9787ee7698c797e20f2fa13d2e2b]
stable/6.6: [b6ebe4fed73eedeb73f4540f8edc4871945474c8]
stable/6.9: [d377f5a28332954b19e373d36823e59830ab1712]

CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race
is detected

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [f45b899adc6bf0c737310c6703f3cd83e2c00ab6]
cip/4.4-st: [f45b899adc6bf0c737310c6703f3cd83e2c00ab6]
stable/4.19: [d30ff33040834c3b9eee29740acd92f9c7ba2250]
stable/5.10: [5661b9c7ec189406c2dde00837aaa4672efb6240]
stable/5.15: [52c87ab18c76c14d7209646ccb3283b3f5d87b22]
stable/5.4: [dc2ce1dfceaa0767211a9d963ddb029ab21c4235]
stable/6.1: [ef8fc41cd6f95f9a4a3470f085aecf350569a0b3]
stable/6.6: [5f5d0799eb0a01d550c21b7894e26b2d9db55763]
stable/6.9: [b6d223942c34057fdfd8f149e763fa823731b224]

CVE-2024-41015: ocfs2: add bounds checking to ocfs2_check_dir_entry()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [f92bfcc25e7a23b921fed6d6bf80652f774948a9]
cip/4.4-st: [f92bfcc25e7a23b921fed6d6bf80652f774948a9]
stable/4.19: [13d38c00df97289e6fba2e54193959293fd910d2]
stable/5.10: [77495e5da5cb110a8fed27b052c77853fe282176]
stable/5.15: [53de17ad01cb5f6f8426f597e9d5c87d4cf53bb7]
stable/5.4: [564d23cc5b216211e1694d53f7e45959396874d0]
stable/6.1: [fd65685594ee707cbf3ddf22ebb73697786ac114]
stable/6.10: [edb2e67dd4626b06fd7eb37252d5067912e78d59]
stable/6.6: [e05a24289db90f76ff606086aadd62d068a88dcd]

CVE-2024-41017: jfs: don't walk off the end of ealist

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [af1a2788b6039dd6de3eb30b6ef04847b7a80d1a]
cip/4.4-st: [af1a2788b6039dd6de3eb30b6ef04847b7a80d1a]
stable/4.19: [7f91bd0f2941fa36449ce1a15faaa64f840d9746]
stable/5.10: [6386f1b6a10e5d1ddd03db4ff6dfc55d488852ce]
stable/5.15: [7e21574195a45fc193555fa40e99fed16565ff7e]
stable/5.4: [fc16776a82e8df97b6c4f9a10ba95aa44cef7ba5]
stable/6.1: [4e034f7e563ab723b93a59980e4a1bb33198ece8]
stable/6.10: [dbde7bc91093fa9c2410e418b236b70fde044b73]
stable/6.6: [17440dbc66ab98b410514b04987f61deedb86751]

CVE-2024-41020: filelock: Fix fcntl/close race recovery compat path

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [6ebd8367c352a40130a7224b34d78df9b9f2f9de]
cip/4.4-st: [6ebd8367c352a40130a7224b34d78df9b9f2f9de]
stable/4.19: [a561145f3ae973ebf3e0aee41624e92a6c5cb38d]
stable/5.10: [911cc83e56a2de5a40758766c6a70d6998248860]
stable/5.15: [53e21cfa68a7d12de378b7116c75571f73e0dfa2]
stable/5.4: [4c43ad4ab41602201d34c66ac62130fe339d686f]
stable/6.1: [f4d0775c6e2f1340ca0725f0337de149aaa989ca]
stable/6.10: [ed898f9ca3fa32c56c858b463ceb9d9936cc69c4]
stable/6.6: [73ae349534ebc377328e7d21891e589626c6e82c]

CVE-2024-41035: USB: core: Fix duplicate endpoint bug by clearing
reserved bits in the descriptor

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [c9b70ed4ae1f5b96d1fe3db7a65b4c8a68072113]
cip/4.4-st: [c9b70ed4ae1f5b96d1fe3db7a65b4c8a68072113]
stable/4.19: [d8418fd083d1b90a6c007cf8dcf81aeae274727b]
stable/5.10: [d09dd21bb5215d583ca9a1cb1464dbc77a7e88cf]
stable/5.15: [2bd8534a1b83c65702aec3cab164170f8e584188]
stable/5.4: [60abea505b726b38232a0ef410d2bd1994a77f78]
stable/6.1: [9edcf317620d7c6a8354911b69b874cf89716646]
stable/6.10: [a368ecde8a5055b627749b09c6218ef793043e47]
stable/6.6: [647d61aef106dbed9c70447bcddbd4968e67ca64]

CVE-2024-41044: ppp: reject claimed-as-LCP but actually malformed packets

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [7a6b9c818d25ba6faaf6089b7291bcdded0627c8]
cip/4.4-st: [7a6b9c818d25ba6faaf6089b7291bcdded0627c8]
stable/4.19: [97d1efd8be26615ff680cdde86937d5943138f37]
stable/5.10: [3ba12c2afd933fc1bf800f6d3f6c7ec8f602ce56]
stable/5.15: [ebc5c630457783d17d0c438b0ad70b232a64a82f]
stable/5.4: [6e8f1c21174f9482033bbb59f13ce1a8cbe843c3]
stable/6.1: [3134bdf7356ed952dcecb480861d2afcc1e40492]
stable/6.10: [f2aeb7306a898e1cbd03963d376f4b6656ca2b55]
stable/6.6: [099502ca410922b56353ccef2749bc0de669da78]

CVE-2024-41046: net: ethernet: lantiq_etop: fix double free in detach

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [e824e225f11dcb60bd1dba8dac08d4611cf09199]
cip/4.4-st: [e824e225f11dcb60bd1dba8dac08d4611cf09199]
stable/4.19: [1a2db00a554cfda57c397cce79b2804bf9633fec]
stable/5.10: [22b16618a80858b3a9d607708444426948cc4ae1]
stable/5.15: [69ad5fa0ce7c548262e0770fc2b726fe7ab4f156]
stable/5.4: [907443174e76b854d28024bd079f0e53b94dc9a1]
stable/6.1: [c2b66e2b3939af63699e4a4bd25a8ac4a9b1d1b3]
stable/6.10: [e1533b6319ab9c3a97dad314dd88b3783bc41b69]
stable/6.6: [9d23909ae041761cb2aa0c3cb1748598d8b6bc54]

CVE-2024-41059: hfsplus: fix uninit-value in copy_name

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [8e50795a5df1640900d539bc70c27c9d0aa6088f]
cip/4.4-st: [8e50795a5df1640900d539bc70c27c9d0aa6088f]
stable/4.19: [72805debec8f7aa342da194fe0ed7bc8febea335]
stable/5.10: [34f8efd2743f2d961e92e8e994de4c7a2f9e74a0]
stable/5.15: [d02d8c1dacafb28930c39e16d48e40bb6e4cbc70]
stable/5.4: [c733e24a61cbcff10f660041d6d84d32bb7e4cb4]
stable/6.1: [22999936b91ba545ce1fbbecae6895127945e91c]
stable/6.10: [0570730c16307a72f8241df12363f76600baf57d]
stable/6.6: [f08956d8e0f80fd0d4ad84ec917302bb2f3a9c6a]

CVE-2024-41063: Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [ff842781bb5663edbbe34f1c7a7c79fdd5e0a13e]
cip/4.4-st: [ff842781bb5663edbbe34f1c7a7c79fdd5e0a13e]
stable/4.19: [48542881997e17b49dc16b93fe910e0cfcf7a9f9]
stable/5.10: [ddeda6ca5f218b668b560d90fc31ae469adbfd92]
stable/5.15: [d2ce562a5aff1dcd0c50d9808ea825ef90da909f]
stable/5.4: [9cfc84b1d464cc024286f42a090718f9067b80ed]
stable/6.1: [96600c2e5ee8213dbab5df1617293d8e847bb4fa]
stable/6.6: [d6cbce18370641a21dd889e8613d8153df15eb39]

CVE-2024-41068: s390/sclp: Fix sclp_init() cleanup on failure

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [22fe3a43d95996126f2ca600ae49c220ddf3c193]
cip/4.4-st: [22fe3a43d95996126f2ca600ae49c220ddf3c193]
stable/4.19: [a778987afc36d5dc02a1f82d352a81edcaf7eb83]
stable/5.10: [2e51db7ab71b89dc5a17068f5e201c69f13a4c9a]
stable/5.15: [cf521049fcd07071ed42dc9758fce7d5ee120ec6]
stable/5.4: [455a6653d8700a81aa8ed2b6442a3be476007090]
stable/6.1: [79b4be70d5a160969b805f638ac5b4efd0aac7a3]
stable/6.6: [0a31b3fdc7e735c4f8c65fe4339945c717ed6808]

CVE-2024-41072: wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [3f4641034c5b4f954ccc6951da94be773011c53c]
cip/4.4-st: [3f4641034c5b4f954ccc6951da94be773011c53c]
stable/4.19: [b02ba9a0b55b762bd04743a22f3d9f9645005e79]
stable/5.10: [6295bad58f988eaafcf0e6f8b198a580398acb3b]
stable/5.15: [a43cc0558530b6c065976b6b9246f512f8d3593b]
stable/5.4: [de5fcf757e33596eed32de170ce5a93fa44dd2ac]
stable/6.1: [001120ff0c9e3557dee9b5ee0d358e0fc189996f]
stable/6.6: [fe9644efd86704afe50e56b64b609de340ab7c95]

CVE-2024-41089: drm/nouveau/dispnv04: fix null pointer dereference in
nv17_tv_get_hd_modes

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [9055a2b1109d7c8c785754aeffaba21b3e9ad782]
cip/4.4-st: [9055a2b1109d7c8c785754aeffaba21b3e9ad782]
stable/4.19: [ffabad4aa91e33ced3c6ae793fb37771b3e9cb51]
stable/5.10: [56fc4d3b0bdef691831cd95715a7ca3ebea98b2d]
stable/5.15: [5eecb49a6c268dc229005bf6e8167d4001dc09a0]
stable/5.4: [1c9f2e60150b4f13789064370e37f39e6e060f50]
stable/6.1: [30cbf6ffafbbdd8a6e4e5f0a2e9a9827ee83f3ad]
stable/6.6: [7ece609b0ce7a7ea8acdf512a77d1fee26621637]

CVE-2024-41095: drm/nouveau/dispnv04: fix null pointer dereference in
nv17_tv_get_ld_modes

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [e620ef43938192a82fb3c1e76e132a1c566e07a6]
cip/4.4-st: [e620ef43938192a82fb3c1e76e132a1c566e07a6]
stable/4.19: [9289cd3450d1da3e271ef4b054d4d2932c41243e]
stable/5.10: [259549b2ccf795b7f91f7b5aba47286addcfa389]
stable/5.15: [0d17604f2e44b3df21e218fe8fb3b836d41bac49]
stable/5.4: [dbd75f32252508ed6c46c3288a282c301a57ceeb]
stable/6.1: [f95ed0f54b3d3faecae1140ddab854f904a6e7c8]
stable/6.6: [cb751e48bbcffd292090f7882b23b215111b3d72]

CVE-2024-41097: usb: atm: cxacru: fix endpoint checking in cxacru_bind()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [0857b805a755b25c1d07df5338e14e4cbaef4716]
cip/4.4-st: [0857b805a755b25c1d07df5338e14e4cbaef4716]
stable/4.19: [5159a81924311c1ec786ad9fdef784ead8676a6a]
stable/5.10: [75ddbf776dd04a09fb9e5267ead5d0c989f84506]
stable/5.15: [1aac4be1aaa5177506219f01dce5e29194e5e95a]
stable/5.4: [23926d316d2836315cb113569f91393266eb5b47]
stable/6.1: [5584c776a1af7807ca815ee6265f2c1429fc5727]
stable/6.6: [f536f09eb45e4de8d1b9accee9d992aa1846f1d4]

CVE-2024-42070: netfilter: nf_tables: fully validate NFT_DATA_VALUE on
store to data registers

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [4f0f312fefd1be25d4a11dbdad9d90f34e15e480]
cip/4.4-st: [4f0f312fefd1be25d4a11dbdad9d90f34e15e480]
stable/4.19: [40188a25a9847dbeb7ec67517174a835a677752f]
stable/5.10: [5d43d789b57943720dca4181a05f6477362b94cf]
stable/5.15: [461302e07f49687ffe7d105fa0a330c07c7646d8]
stable/5.4: [23752737c6a618e994f9a310ec2568881a6b49c4]
stable/6.1: [efb27ad05949403848f487823b597ed67060e007]
stable/6.6: [952bf8df222599baadbd4f838a49c4fef81d2564]

CVE-2024-42084: ftruncate: pass a signed offset

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [9f3440427ed7ed494d55fc0059c8f194a9f7d13e]
cip/4.4-st: [9f3440427ed7ed494d55fc0059c8f194a9f7d13e]
stable/4.19: [c329760749b5419769e57cb2be80955d2805f9c9]
stable/5.10: [84bf6b64a1a0dfc6de7e1b1c776d58d608e7865a]
stable/5.15: [dbb226d81cd02cee140139c2369791e6f61f2007]
stable/5.4: [f531d4bc6c5588d713359e42ed65e46816d841d8]
stable/6.1: [5ae6af68410bdad6181ec82104bb9985a7a6a0fa]
stable/6.6: [836359247b0403e0634bfbc83e5bb8063fad287a]

CVE-2024-42089: ASoC: fsl-asoc-card: set priv->pdev before using it

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [ff3cd6c29df0c5a8cb101c9d96d35037e3bed807]
cip/4.4-st: [ff3cd6c29df0c5a8cb101c9d96d35037e3bed807]
stable/4.19: [ae81535ce2503aabc4adab3472f4338070cdeb6a]
stable/5.10: [3662eb2170e59b58ad479982dc1084889ba757b9]
stable/5.15: [544ab46b7ece6d6bebbdee5d5659c0a0f804a99a]
stable/5.4: [8896e18b7c366f8faf9344abfd0971435f1c723a]
stable/6.1: [8faf91e58425c2f6ce773250dfd995f1c2d461ac]
stable/6.6: [29bc9e7c75398b0d12fc30955f2e9b2dd29ffaed]

CVE-2024-42090: pinctrl: fix deadlock in create_pinctrl() when
handling -EPROBE_DEFER

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [4a51a2ca90eb9ff5776b89a17d9a85e3b3828b99]
cip/4.4-st: [4a51a2ca90eb9ff5776b89a17d9a85e3b3828b99]
stable/4.19: [e65a0dc2e85efb28e182aca50218e8a056d0ce04]
stable/5.10: [b813e3fd102a959c5b208ed68afe27e0137a561b]
stable/5.15: [01fe2f885f7813f8aed5d3704b384a97b1116a9e]
stable/5.4: [420ce1261907e5dbeda1e4daffd5b6c76f8188c0]
stable/6.1: [b36efd2e3e22a329444b6b24fa48df6d20ae66e6]
stable/6.6: [4038c57bf61631219b31f1bd6e92106ec7f084dc]

CVE-2024-42096: x86: stop playing stack games in profile_pc()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [8470f12539c176094144cec1203fb096ceb4a6ee]
cip/4.4-st: [8470f12539c176094144cec1203fb096ceb4a6ee]
stable/4.19: [65ebdde16e7f5da99dbf8a548fb635837d78384e]
stable/5.10: [49c09ca35a5f521d7fa18caf62fdf378f15e8aa4]
stable/5.15: [2d07fea561d64357fb7b3f3751e653bf20306d77]
stable/5.4: [27c3be840911b15a3f24ed623f86153c825b6b29]
stable/6.1: [161cef818545ecf980f0e2ebaf8ba7326ce53c2b]
stable/6.6: [16222beb9f8e5ceb0beeb5cbe54bef16df501a92]

CVE-2024-42097: ALSA: emux: improve patch ioctl data validation

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [ccb1d69b9ffcddf1bf4249541433917d6f625ee0]
cip/4.4-st: [ccb1d69b9ffcddf1bf4249541433917d6f625ee0]
stable/4.19: [40d7def67841343c10f8642a41031fecbb248bab]
stable/5.10: [d23982ea9aa438f35a8c8a6305943e98a8db90f6]
stable/5.15: [7a18293fd8d8519c2f7a03753bc1583b18e3db69]
stable/5.4: [79d9a000f0220cdaba1682d2a23c0d0c61d620a3]
stable/6.1: [d0ff2443fcbb472206d45a5d2a90cc694065804e]
stable/6.6: [d8f5ce3cb9adf0c72e2ad6089aba02d7a32469c2]

CVE-2024-42101: drm/nouveau: fix null pointer dereference in
nouveau_connector_get_modes

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [a597901aae85f34f7ed32e82ee21cfbff1415fbc]
cip/4.4-st: [a597901aae85f34f7ed32e82ee21cfbff1415fbc]
stable/4.19: [9baf60323efa992b7c915094529f0a1882c34e7e]
stable/5.10: [274cba8d2d1b48c72d8bd90e76c9e2dc1aa0a81d]
stable/5.15: [f48dd3f19614022f2e1b794fbd169d2b4c398c07]
stable/5.4: [e36364f5f3785d054a94e57e971385284886d41a]
stable/6.1: [1f32535238493008587a8c5cb17eb2ca097592ef]
stable/6.6: [744b229f09134ccd091427a6f9ea6d97302cfdd9]

CVE-2024-42102: Revert "mm/writeback: fix possible divide-by-zero in
wb_dirty_limits(), again"

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [087c0e236cfc37fb08ec40a5a54085e35aaef031]
cip/4.4-st: [087c0e236cfc37fb08ec40a5a54085e35aaef031]
stable/4.19: [253f9ea7e8e53a5176bd80ceb174907b10724c1a]
stable/5.10: [145faa3d03688cbb7bbaaecbd84c01539852942c]
stable/5.15: [2820005edae13b140f2d54267d1bd6bb23915f59]
stable/5.4: [23a28f5f3f6ca1e4184bd0e9631cd0944cf1c807]
stable/6.1: [cbbe17a324437c0ff99881a3ee453da45b228a00]
stable/6.6: [f6620df12cb6bdcad671d269debbb23573502f9d]

CVE-2024-42104: nilfs2: add missing check for inode numbers on directory entries

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [8586190cdd6dbc1e301f37d8ac9bee6bae65f637]
cip/4.4-st: [8586190cdd6dbc1e301f37d8ac9bee6bae65f637]
stable/4.19: [c33c2b0d92aa1c2262d999b2598ad6fbd53bd479]
stable/5.10: [2f2fa9cf7c3537958a82fbe8c8595a5eb0861ad7]
stable/5.15: [b11e8fb93ea5eefb2e4e719497ea177a58ff6131]
stable/5.4: [07c176e7acc5579c133bb923ab21316d192d0a95]
stable/6.1: [1b7d549ed2c1fa202c751b69423a0d3a6bd5a180]
stable/6.6: [3ab40870edb883b9633dc5cd55f5a2a11afa618d]

CVE-2024-42105: nilfs2: fix inode number range checks

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [bc1d4ada7379db8d87bfa1922a295b66853bd4c3]
cip/4.4-st: [bc1d4ada7379db8d87bfa1922a295b66853bd4c3]
stable/4.19: [57235c3c88bb430043728d0d02f44a4efe386476]
stable/5.10: [731011ac6c37cbe97ece229fc6daa486276052c5]
stable/5.15: [3be4dcc8d7bea52ea41f87aa4bbf959efe7a5987]
stable/5.4: [08cab183a624ba71603f3754643ae11cab34dbc4]
stable/6.1: [fae1959d6ab2c52677b113935e36ab4e25df37ea]
stable/6.6: [9194f8ca57527958bee207919458e372d638d783]

CVE-2024-42106: inet_diag: Initialize pad field in struct inet_diag_req_v2

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [9b6e6ce1551431d4d8d3a5c9b82dc0d2c5b7cc4b]
cip/4.4-st: [9b6e6ce1551431d4d8d3a5c9b82dc0d2c5b7cc4b]
stable/4.19: [7094a5fd20ab66028f1da7f06e0f2692d70346f9]
stable/5.10: [7ef519c8efde152e0d632337f2994f6921e0b7e4]
stable/5.15: [8366720519ea8d322a20780debdfd23d9fc0904a]
stable/5.4: [0184bf0a349f4cf9e663abbe862ff280e8e4dfa2]
stable/6.1: [d6f487e0704de2f2d15f8dd5d7d723210f2b2fdb]
stable/6.6: [76965648fe6858db7c5f3c700fef7aa5f124ca1c]

CVE-2024-42115: jffs2: Fix potential illegal address access in jffs2_free_inode

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [954b56c37665e341bf6f53fb983f9e59aecc034e]
cip/4.4-st: [954b56c37665e341bf6f53fb983f9e59aecc034e]
stable/4.19: [b6c8b3e31eb88c85094d848a0bd8b4bafe67e4d8]
stable/5.10: [6d6d94287f6365282bbf41e9a5b5281985970789]
stable/5.15: [5ca26334fc8a3711fed14db7f9eb1c621be4df65]
stable/5.4: [0b3246052e01e61a55bb3a15b76acb006759fe67]
stable/6.1: [751987a5d8ead0cc405fad96e83ebbaa51c82dbc]
stable/6.6: [d0bbbf31462a400bef4df33e22de91864f475455]

CVE-2024-42145: IB/core: Implement a limit on UMAD receive List

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [a066f0cb6e0885a26b667430f63bf846ff3ecf11]
cip/4.4-st: [a066f0cb6e0885a26b667430f63bf846ff3ecf11]
stable/4.19: [1288cf1cceb0e6df276e182f5412370fb4169bcb]
stable/5.10: [62349fbf86b5e13b02721bdadf98c29afd1e7b5f]
stable/5.15: [d73cb8862e4d6760ccc94d3b57b9ef6271400607]
stable/5.4: [b4913702419d064ec4c4bbf7270643c95cc89a1b]
stable/6.1: [63d202d948bb6d3a28cd8e8b96b160fa53e18baa]
stable/6.6: [b8c5f635997f49c625178d1a0cb32a80ed33abe6]

CVE-2024-42148: bnx2x: Fix multiple UBSAN array-index-out-of-bounds

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [7a3feeac7dda4074d16ca08e22131ede1043c417]
cip/4.4-st: [7a3feeac7dda4074d16ca08e22131ede1043c417]
stable/4.19: [cfb04472ce33bee2579caf4dc9f4242522f6e26e]
stable/5.10: [8b17cec33892a66bbd71f8d9a70a45e2072ae84f]
stable/5.15: [0edae06b4c227bcfaf3ce21208d49191e1009d3b]
stable/5.4: [cbe53087026ad929cd3950508397e8892a6a2a0f]
stable/6.1: [9504a1550686f53b0bab4cab31d435383b1ee2ce]
stable/6.6: [f1313ea92f82451923e28ab45a4aaa0e70e80b98]

CVE-2024-42153: i2c: pnx: Fix potential deadlock warning from
del_timer_sync() call in isr

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [761475562f9c4369ce439eb6fa4c2bee4ee71e39]
cip/4.4-st: [761475562f9c4369ce439eb6fa4c2bee4ee71e39]
stable/4.19: [a349e5ab4dc9954746e836cd10b407ce48f9b2f6]
stable/5.10: [2849a1b747cf37aa5b684527104d3a53f1e296d2]
stable/5.15: [3503372d0bf7b324ec0bd6b90606703991426176]
stable/5.4: [effe0500afda017a86c94482b1e36bc37586c9af]
stable/6.1: [3d32327f5cfc087ee3922a3bcdcc29880dcdb50f]
stable/6.6: [92e494a7568b60ae80d57fc0deafcaf3a4029ab3]

CVE-2024-42154: tcp_metrics: validate source addr length

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [b8617719d306c31426d3d6958895d7f67b8e1196]
cip/4.4-st: [b8617719d306c31426d3d6958895d7f67b8e1196]
stable/4.19: [19d997b59fa1fd7a02e770ee0881c0652b9c32c9]
stable/5.10: [cdffc358717e436bb67122bb82c1a2a26e050f98]
stable/5.15: [ef7c428b425beeb52b894e16f1c4b629d6cebfb6]
stable/5.4: [2a2e79dbe2236a1289412d2044994f7ab419b44c]
stable/6.1: [31f03bb04146c1c6df6c03e9f45401f5f5a985d3]
stable/6.6: [8c2debdd170e395934ac0e039748576dfde14e99]

CVE-2024-42223: media: dvb-frontends: tda10048: Fix integer overflow

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [2d534b531321282393d7c75864e9594c7d555966]
cip/4.4-st: [2d534b531321282393d7c75864e9594c7d555966]
stable/4.19: [8167e4d7dc086d4f7ca7897dcff3827e4d22c99a]
stable/5.10: [e1ba22618758e95e09c9fd30c69ccce38edf94c0]
stable/5.15: [bd5620439959a7e02012588c724c6ff5143b80af]
stable/5.4: [5c72587d024f087aecec0221eaff2fe850d856ce]
stable/6.1: [1663e2474e4d777187d749a5c90ae83232db32bd]
stable/6.6: [8ac224e9371dc3c4eb666033e6b42d05cf5184a1]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

