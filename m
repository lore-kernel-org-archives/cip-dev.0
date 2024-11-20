Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B287DD743EA
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 22:23:22 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
 by mx.groups.io with SMTP id smtpd.web10.534.1732141392083334025
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Nov 2024 14:23:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=yGhZSepj;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.172, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e387e50d98eso185656276.2
        for <cip-dev@lists.cip-project.org>; Wed, 20 Nov 2024 14:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1732141391; x=1732746191; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NzOTT6cfuRBKDvDtVWLgoPhjXnD2wpSHStZXPQom8tU=;
        b=yGhZSepjU76VHCxl3PkTUQeb5/S1wekn26Sv1FED4FrEVeaSHzW5VnaFBHan23S6vc
         3GHFhHlw42hq3Lx21BtdFXhz6aOUeVMw4j0jl2TFpc4qIhVrnJKV/+YDFA4ZfbifZnUY
         tDUHAUD/KIfVf6T3J1bw+VZ8SMrRX6KO4TVcSYDNCj3mQA6WB/FAK9HnsmAZN/2c+SbX
         BZpCc6USdcffGvGwefQtDir2qAU/6iSqd8pt7LkuehD8K38rFK3OL4UdKUsuuhXGaGAI
         toPmqyVh4IQEOcyaB/DKV/PpUWlJK4vxuVCxIFpSS7zLuSPp6b2s3oF914tL/l5xsMGz
         FuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732141391; x=1732746191;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzOTT6cfuRBKDvDtVWLgoPhjXnD2wpSHStZXPQom8tU=;
        b=Er1a6ZDIZTSmkgxuBj7xoVTZh/HhnofyHEk/Z41KJ/HmH0ZFZlLsSuha2E1VTL5npM
         HwY7FgQmB6kyFP6OFNcCQ1nK18GRemIOMAySd2PBeeM3ILrrluai9G4DYUP9bVvtQPLZ
         4OT1R/IvpGK3yfBAPq8FLwhZ7P27zGzdSLX3wDyYAhcqORmNGNTIMHrnh39b6c6OQjIY
         8ZvYl+ZSCQieMV2/30E05vNcxapLeu8okens7LSg0ofDhF7jCEHBDxivofNz2PBaYlSA
         0BaGamvJxdrb5CPhyYOmot5bFghWBitb2cUB6gtAqeyvvaWSq0HYj4MebQvGC8VeltXj
         I/AQ==
X-Gm-Message-State: AOJu0Yyepr8tvdNushtZvH3XG6QYmqPKUYIvGhDSTt2IDpLylKVi3/7o
	U9f/HLAwE5mwuHm4bAhoBDypBT4IyH+KQD2t1pfY1anWIG4M26TesK5xerbpzpl4B+aCPllvgxo
	H04S+s72IGrzAooKDioZVEl6pfp7Xr3B4dOWYCFZzjq7BV3kwjyQ=
X-Gm-Gg: ASbGncu0cTDnFe9uO8Yt09DONLDeUiZwIAhGgA8rW5Ezv2LwnwGJsnl6rkJ0hjNFrMV
	BU1Rp/fZ6+UQjz0DeZbKPv3EoRSqUcqVW
X-Google-Smtp-Source: AGHT+IE2Ank27+TVj5xRhA6713hJvkCKl2W/0D/OmU/5DyiMjn9RS9on+KFNM7R3r5cDx+oRslUeMBRk2TnaGoKVN7Y=
X-Received: by 2002:a05:6902:dca:b0:e38:a031:bbd5 with SMTP id
 3f1490d57ef6-e38cb5a9686mr4022153276.31.1732141389939; Wed, 20 Nov 2024
 14:23:09 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Nov 2024 07:22:34 +0900
Message-ID: <CAODzB9owUF8QyNoHZvO7tZ9patRCm1FvPVNde=k1yh-A+w8K5Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Nov 2024 22:23:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17264

Hi!

It's this week's CVE report.

This week reported 93 new CVEs and 19 updated CVEs.

* New CVEs
CVE-2023-4458: [ksmbd: fix wrong DataOffset validation of create context]

Announce: https://www.cve.org/CVERecord?id=CVE-2023-4458
None
It looks as if this bug was introduced by commit 8f77150 ("ksmbd:
add buffer validation for SMB2_CREATE_CONTEXT") in 5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17d5b135bb720832364e8f55f6a887a3c7ec8fdb]
stable/5.15: [2e3f57f74c0af085a2519860eac42b33f7659600]
stable/6.1: [7d8855fd849d9c3186a9e1d3085ea4aedc6e019f]

CVE-2023-39176: [Linux Kernel ksmbd Transform Header Out-Of-Bounds
Read Information
Disclosure Vulnerability]

Announce: https://www.cve.org/CVERecord?id=CVE-2023-39176

None
Commit 5aa4fda ("ksmbd: validate command request size") fixes 2b9b8f3 ("ksmbd:
validate command payload size"). Fixed in 6.5-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79ed288cef201f1f212dfb934bcaac75572fb8f6,5aa4fda5aa9c2a5a7bac67b4a12b089ab81fee3c]
stable/5.15: [aeb974907642be095e38ecb1a400ca583958b2b0,595679098bdcdbfbba91ebe07a2f7f208df93870]
stable/6.1: [f339d76a3a972601d0738b881b099d49ebbdc3a2,c6bef3bc30fd4a175aef846b7d928a6c40d091cd]

CVE-2023-39179: [Linux Kernel ksmbd Read Request Out-Of-Bounds Read
Information Disclosure
Vulnerability]

Announce: https://www.cve.org/CVERecord?id=CVE-2023-39179

None
Fixed in 6.5-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e202a1e8634b186da38cbbff85382ea2b9e297cf]
stable/5.15: [d424c636b750d2f1f24b116e0260f09c1c888c4c]
stable/6.1: [99a2426b135e590ab7e2c930f7ce489ea1e4edbd]

CVE-2023-39180: [Linux Kernel ksmbd Read Request Memory Leak Denial-of-Service
Vulnerability]

Announce: https://www.cve.org/CVERecord?id=CVE-2023-39180

None
Fixed in 6.5-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e202a1e8634b186da38cbbff85382ea2b9e297cf]
stable/5.15: [d424c636b750d2f1f24b116e0260f09c1c888c4c]
stable/6.1: [99a2426b135e590ab7e2c930f7ce489ea1e4edbd]

CVE-2023-52921: drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()

Announce: https://lore.kernel.org/linux-cve-announce/2024111958-CVE-2023-52921-78df@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.5-rc6.
It looks as if this bug was introduced by commit 2ebf61f ("drm/amdgpu:
Fix memory
leak in amdgpu_cs_pass1") in 6.2-rc1.

Fixed status
mainline: [90e065677e0362a777b9db97ea21d43a39211399]
stable/6.1: [9a2393af1f35d1975204fc00035c64a1c792b278]

CVE-2024-50264: vsock/virtio: Initialization of the dangling pointer
occurring in vsk->trans

Announce: https://lore.kernel.org/linux-cve-announce/2024111920-CVE-2024-50264-0889@gregkh/

Introduced by commit 06a8fc7 ("VSOCK: Introduce
virtio_vsock_common.ko") in v4.8-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ca575374dd9a507cdd16dfa0e78c2e9e20bd05f]
stable/4.19: [5f092a4271f6dccf88fe0d132475a17b69ef71df]
stable/5.10: [eb1bdcb7dfc30b24495ee4c5533af0ed135cb5f1]
stable/5.15: [2a6a4e69f255b7aed17f93995691ab4f0d3c2203]
stable/5.4: [fd8ae346692a56b4437d626c5460c7104980f389]
stable/6.1: [44d29897eafd0e1196453d3003a4d5e0b968eeab]
stable/6.6: [b110196fec44fe966952004bd426967c2a8fd358]

CVE-2024-50265: ocfs2: remove entry once instead of
null-ptr-dereference in ocfs2_xa_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2024111921-CVE-2024-50265-dcd9@gregkh/

Introduced by commit 399ff3a ("ocfs2: Handle errors while setting
external xattr values.") in v2.6.34-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b63c0e01fba40e3992bc627272ec7b618ccaef7]
stable/4.19: [38cbf13b2e7a31362babe411f7c2c3c52cd2734b]
stable/5.10: [6a7e6dcf90fe7721d0863067b6ca9a9442134692]
stable/5.15: [dcc8fe8c83145041cb6c80cac21f6173a3ff0204]
stable/5.4: [168a9b8303fcb0317db4c06b23ce1c0ce2af4e10]
stable/6.1: [86dd0e8d42828923c68ad506933336bcd6f2317d]
stable/6.6: [dd73c942eed76a014c7a5597e6926435274d2c4c]

CVE-2024-50266: clk: qcom: videocc-sm8350: use HW_CTRL_TRIGGER for vcodec GDSCs

Announce: https://lore.kernel.org/linux-cve-announce/2024111922-CVE-2024-50266-7fe4@gregkh/

Introduced by commit ec9a652 ("venus: pm_helpers: Use
dev_pm_genpd_set_hwmode to switch GDSC mode on V6") in v6.11-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f903663a8dcd6e1656e52856afbf706cc14cbe6d]

CVE-2024-50267: USB: serial: io_edgeport: fix use after free in debug printk

Announce: https://lore.kernel.org/linux-cve-announce/2024111924-CVE-2024-50267-2d0d@gregkh/

Introduced by commit 984f686 ("USB: serial: io_edgeport.c: remove
dbg() usage") in v3.7-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37bb5628379295c1254c113a407cab03a0f4d0b4]
stable/4.19: [e6ceb04eeb6115d872d4c4078d12f1170ed755ce]
stable/5.10: [e567fc8f7a4460e486e52c9261b1e8b9f5dc42aa]
stable/5.15: [44fff2c16c5aafbdb70c7183dae0a415ae74705e]
stable/5.4: [39709ce93f5c3f9eb535efe2afea088805d1128f]
stable/6.1: [275258c30bbda29467216e96fb655b16bcc9992b]
stable/6.6: [13d6ff3ca76056d06a9d88300be2a293442ff595]

CVE-2024-50268: usb: typec: fix potential out of bounds in
ucsi_ccg_update_set_new_cam_cmd()

Announce: https://lore.kernel.org/linux-cve-announce/2024111925-CVE-2024-50268-9b55@gregkh/

Introduced by commit 170a672 ("usb: typec: ucsi: add support for
separate DP altmode devices") in v5.6-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dd08a0b4193087976db6b3ee7807de7e8316f96]
stable/5.10: [d76923164705821aa1b01b8d9d1741f20c654ab4]
stable/5.15: [8f47984b35f3be0cfc652c2ca358d5768ea3456b]
stable/6.1: [604314ecd682913925980dc955caea2d036eab5f]
stable/6.6: [69e19774f15e12dda6c6c58001d059e30895009b]

CVE-2024-50269: usb: musb: sunxi: Fix accessing an released usb phy

Announce: https://lore.kernel.org/linux-cve-announce/2024111926-CVE-2024-50269-830b@gregkh/

Introduced by commit 6ed05c6 ("usb: musb: sunxi: Explicitly release
USB PHY on exit") in v4.14-rc6.
Fixed in v6.12-rc7.
Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [498dbd9aea205db9da674994b74c7bf8e18448bd]
stable/4.19: [721ddad945596220c123eb6f7126729fe277ee4f]
stable/5.10: [6e2848d1c8c0139161e69ac0a94133e90e9988e8]
stable/5.15: [63559ba8077cbadae1c92a65b73ea522bf377dd9]
stable/5.4: [4aa77d5ea9944468e16c3eed15e858fd5de44de1]
stable/6.1: [ccd811c304d2ee56189bfbc49302cb3c44361893]
stable/6.6: [8a30da5aa9609663b3e05bcc91a916537f66a4cd]

CVE-2024-50270: mm/damon/core: avoid overflow in damon_feed_loop_next_input()

Announce: https://lore.kernel.org/linux-cve-announce/2024111927-CVE-2024-50270-473a@gregkh/

Introduced by commit 9294a03 ("mm/damon/core: implement goal-oriented
feedback-driven quota auto-tuning") in v6.8-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4401e9d10ab0281a520b9f8c220f30f60b5c248f]

CVE-2024-50271: signal: restore the override_rlimit logic

Announce: https://lore.kernel.org/linux-cve-announce/2024111929-CVE-2024-50271-9089@gregkh/

Introduced by commit d646969 ("Reimplement RLIMIT_SIGPENDING on top of
ucounts") in v5.14-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e05e5c7ee8758141d2db7e8fea2cab34500c6ed]
stable/6.1: [012f4d5d25e9ef92ee129bd5aa7aa60f692681e1]
stable/6.6: [4877d9b2a2ebad3ae240127aaa4cb8258b145cf7]

CVE-2024-50272: filemap: Fix bounds checking in filemap_read()

Announce: https://lore.kernel.org/linux-cve-announce/2024111930-CVE-2024-50272-5691@gregkh/

Introduced by commit c2a9737 ("vfs,mm: fix a dead loop in
truncate_inode_pages_range()") in v4.9-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ace149e0830c380ddfce7e466fe860ca502fe4ee]
stable/6.1: [26530b757c81f1389fb33ae0357500150933161b]
stable/6.6: [a2746ab3bbc9c6408da5cd072653ec8c24749235]

CVE-2024-50273: btrfs: reinitialize delayed ref list after deleting it
from the list

Announce: https://lore.kernel.org/linux-cve-announce/2024111931-CVE-2024-50273-6359@gregkh/

Introduced by commit 1d57ee9 ("btrfs: improve delayed refs
iterations") in v4.10-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9a75ec45f1111ef530ab186c2a7684d0a0c9245]
stable/4.19: [2fd0948a483e9cb2d669c7199bc620a21c97673d]
stable/5.10: [bf0b0c6d159767c0d1c21f793950d78486690ee0]
stable/5.15: [c24fa427fc0ae827b2a3a07f13738cbf82c3f851]
stable/5.4: [93c5b8decc0ef39ba84f4211d2db6da0a4aefbeb]
stable/6.1: [2cb1a73d1d44a1c11b0ee5eeced765dd80ec48e6]
stable/6.6: [f04be6d68f715c1473a8422fc0460f57b5e99931]

CVE-2024-50274: idpf: avoid vport access in idpf_get_link_ksettings

Announce: https://lore.kernel.org/linux-cve-announce/2024111932-CVE-2024-50274-a441@gregkh/

Introduced by commit 02cbfba ("idpf: add ethtool callbacks") in v6.7-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81d2fb4c7c18a3b36ba3e00b9d5b753107472d75]

CVE-2024-50275: arm64/sve: Discard stale CPU state when handling SVE traps

Announce: https://lore.kernel.org/linux-cve-announce/2024111934-CVE-2024-50275-2e49@gregkh/

Introduced by commit cccb78c ("arm64/sve: Rework SVE access trap to
convert state in registers") in v5.13-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [751ecf6afd6568adc98f2a6052315552c0483d18]
stable/6.6: [51d11ea0250d6ee461987403bbfd4b2abb5613a7]

CVE-2024-50276: net: vertexcom: mse102x: Fix possible double free of TX skb

Announce: https://lore.kernel.org/linux-cve-announce/2024111935-CVE-2024-50276-3026@gregkh/

Introduced by commit 2f207cb ("net: vertexcom: Add MSE102x SPI
support") in v5.17-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f26339b2ed63d1e8e18a18674fb73a392f3660e]
stable/6.1: [2cf0e77f5a0aa1ff336aa71743eda55c73902187]
stable/6.6: [1325e838089da25217f4b403318a270fcdf88f34]

CVE-2024-50277: dm: fix a crash if blk_alloc_disk fails

Announce: https://lore.kernel.org/linux-cve-announce/2024111936-CVE-2024-50277-1fe3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc7.
It looks as if this bug was introduced by commit 74fa8f9c ("block: pass a
queue_limits argument to blk_alloc_disk") in 6.9-rc1. Since this commit,
the blk_alloc_disk returns ERR_PTR instead of NULL.

Fixed status
mainline: [fed13a5478680614ba97fc87e71f16e2e197912e]

CVE-2024-50278: dm cache: fix potential out-of-bounds access on the first resume

Announce: https://lore.kernel.org/linux-cve-announce/2024111937-CVE-2024-50278-d6c9@gregkh/

Introduced by commit f494a9c ("dm cache: cache shrinking support") in v3.13-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0ade5d98979585d4f5a93e4514c2e9a65afa08d]
stable/4.19: [e492f71854ce03474d49e87fd98b8df1f7cd1d2d]
stable/5.10: [483b7261b35a9d369082ab298a6670912243f0be]
stable/5.15: [fdef3b94dfebd57e3077a578b6e309a2bb6fa688]
stable/5.4: [2222b0929d00e2d13732b799b63be391b5de4492]
stable/6.1: [c52ec00cb2f9bebfada22edcc0db385b910a1cdb]
stable/6.6: [036dd6e3d2638103e0092864577ea1d091466b86]

CVE-2024-50279: dm cache: fix out-of-bounds access to the dirty bitset
when resizing

Announce: https://lore.kernel.org/linux-cve-announce/2024111939-CVE-2024-50279-d3f9@gregkh/

Introduced by commit f494a9c ("dm cache: cache shrinking support") in v3.13-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [792227719725497ce10a8039803bec13f89f8910]
stable/4.19: [4fa4feb873cea0e9d6ff883b37cca6f33169d8b4]
stable/5.10: [ee1f74925717ab36f6a091104c170639501ce818]
stable/5.15: [ff1dd8a04c30e8d4e2fd5c83198ca672eb6a9e7f]
stable/5.4: [8501e38dc9e0060814c4085815fc83da3e6d43bf]
stable/6.1: [56507203e1b6127967ec2b51fb0b23a0d4af1334]
stable/6.6: [e57648ce325fa405fe6bbd0e6a618ced7c301a2d]

CVE-2024-50280: dm cache: fix flushing uninitialized delayed_work on
cache_ctr error

Announce: https://lore.kernel.org/linux-cve-announce/2024111940-CVE-2024-50280-068b@gregkh/

Introduced by commit 6a459d8 ("dm cache: Fix UAF in destroy()") in v6.2-rc1.
Fixed in v6.12-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [135496c208ba26fd68cdef10b64ed7a91ac9a7ff]
stable/6.1: [5a754d3c771280f2d06bf8ab716d6a0d36ca256e]
stable/6.6: [8cc12dab635333c4ea28e72d7b947be7d0543c2c]

CVE-2024-50281: KEYS: trusted: dcp: fix NULL dereference in AEAD
crypto operation

Announce: https://lore.kernel.org/linux-cve-announce/2024111941-CVE-2024-50281-f70e@gregkh/

Introduced by commit 0e28bf6 ("KEYS: trusted: dcp: fix leak of blob
encryption key") in v6.11-rc4.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04de7589e0a95167d803ecadd115235ba2c14997]

CVE-2024-50282: drm/amdgpu: add missing size check in
amdgpu_debugfs_gprwave_read()

Announce: https://lore.kernel.org/linux-cve-announce/2024111943-CVE-2024-50282-1579@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc7.
Vulnerable function was added by commit 553f973 ("drm/amd/amdgpu: Update
debugfs for XCC support (v3)") in 6.5-rc1.

Fixed status
mainline: [4d75b9468021c73108b4439794d69e892b1d24e3]
stable/4.19: [673bdb4200c092692f83b5f7ba3df57021d52d29]
stable/5.10: [17f5f18085acb5e9d8d13d84a4e12bb3aff2bd64]
stable/5.15: [aaf6160a4b7f9ee3cd91aa5b3251f5dbe2170f42]
stable/5.4: [7ccd781794d247589104a791caab491e21218fba]
stable/6.1: [25d7e84343e1235b667cf5226c3934fdf36f0df6]
stable/6.6: [8906728f2fbd6504cb488f4afdd66af28f330a7a]

CVE-2024-50283: ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp

Announce: https://lore.kernel.org/linux-cve-announce/2024111944-CVE-2024-50283-3aad@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc7.
It looks as if this bug was introduced by commit 7aa8804 ("ksmbd: fix
user-after-free from session log off") in 6.12-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 stable/5.15 stable/6.1 stable/6.11 stable/6.6

Fixed status
mainline: [b8fc56fbca7482c1e5c0e3351c6ae78982e25ada]
stable/6.1: [f7557bbca40d4ca8bb1c6c940ac6c95078bd0827]
stable/6.6: [c6cdc08c25a868a08068dfc319fa9fce982b8e7f]

CVE-2024-50284: ksmbd: Fix the missing xa_store error check

Announce: https://lore.kernel.org/linux-cve-announce/2024111945-CVE-2024-50284-650e@gregkh/

Introduced by commit b685757 ("ksmbd: Implements sess->rpc_handle_list
as xarray") in v6.3-rc1.
Fixed in v6.12-rc7.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [3abab905b14f4ba756d413f37f1fb02b708eee93]
stable/6.1: [d8664ce789bd46290c59a00da6897252f92c237d]
stable/6.6: [726c1568b9145fa13ee248df184b186c382a7ff8]

CVE-2024-50285: ksmbd: check outstanding simultaneous SMB operations

Announce: https://lore.kernel.org/linux-cve-announce/2024111946-CVE-2024-50285-6013@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc7.

Fixed status
mainline: [0a77d947f599b1f39065015bec99390d0c0022ee]
stable/6.6: [1f993777275cbd8f74765c4f9d9285cb907c9be5]

CVE-2024-50286: ksmbd: fix slab-use-after-free in ksmbd_smb2_session_create

Announce: https://lore.kernel.org/linux-cve-announce/2024111948-CVE-2024-50286-85e9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc7.

Fixed status
mainline: [0a77715db22611df50b178374c51e2ba0d58866e]
stable/6.1: [f56446ba5378d19e31040b548a14ee9a8f1500ea]
stable/6.6: [e923503a56b3385b64ae492e3225e4623f560c5b]

CVE-2024-50287: media: v4l2-tpg: prevent the risk of a division by zero

Announce: https://lore.kernel.org/linux-cve-announce/2024111949-CVE-2024-50287-bf9b@gregkh/

Introduced by commit 63881df ("[media] vivid: add the Test Pattern
Generator") in v3.18-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6a3ea83fbe15d4818d01804e904cbb0e64e543b]
stable/4.19: [e3c36d0bde309f690ed1f9cd5f7e63b3a513f94a]
stable/5.10: [054931ca3cfcb8e8fa036e887d6f379942b02565]
stable/5.15: [a749c15dccc58d9cbad9cd23bd8ab4b5fa96cf47]
stable/5.4: [0bfc6e38ee2250f0503d96f1a1de441c31d88715]
stable/6.1: [c63c30c9d9f2c8de34b16cd2b8400240533b914e]
stable/6.6: [2d0f01aa602fd15a805771bdf3f4d9a9b4df7f47]

CVE-2024-50288: media: vivid: fix buffer overwrite when using > 32 buffers

Announce: https://lore.kernel.org/linux-cve-announce/2024111950-CVE-2024-50288-1c5d@gregkh/

Introduced by commit cea70ed ("media: test-drivers: vivid: Increase
max supported buffers for capture queues") in v6.8-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96d8569563916fe2f8fe17317e20e43f54f9ba4b]

CVE-2024-50289: media: av7110: fix a spectre vulnerability

Announce: https://lore.kernel.org/linux-cve-announce/2024111952-CVE-2024-50289-5a27@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [458ea1c0be991573ec436aa0afa23baacfae101a]

CVE-2024-50290: media: cx24116: prevent overflows on SNR calculus

Announce: https://lore.kernel.org/linux-cve-announce/2024111953-CVE-2024-50290-9705@gregkh/

Introduced by commit 8953db7 ("V4L/DVB (9178): cx24116: Add module
parameter to return SNR as ESNO.") in v2.6.28-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [576a307a7650bd544fbb24df801b9b7863b85e2f]
stable/4.19: [127b9076baeadd734b18ddc8f2cd93b47d5a3ea3]
stable/5.10: [828047c70f4716fde4b1316f7b610e97a4e83824]
stable/5.15: [f2b4f277c41db8d548f38f1dd091bbdf6a5acb07]
stable/5.4: [cad97ca8cfd43a78a19b59949f33e3563d369247]
stable/6.1: [fbefe31e4598cdb0889eee2e74c995b2212efb08]
stable/6.6: [83c152b55d88cbf6fc4685941fcb31333986774d]

CVE-2024-50291: media: dvb-core: add missing buffer index check

Announce: https://lore.kernel.org/linux-cve-announce/2024111954-CVE-2024-50291-5c62@gregkh/

Introduced by commit 7dc866d ("media: dvb-core: Use vb2_get_buffer()
instead of directly access to buffers array") in v6.8-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa88dc7db176c79b50adb132a56120a1d4d9d18b]

CVE-2024-50292: ASoC: stm32: spdifrx: fix dma channel release in
stm32_spdifrx_remove

Announce: https://lore.kernel.org/linux-cve-announce/2024111955-CVE-2024-50292-e8b6@gregkh/

Introduced by commit 794df94 ("ASoC: stm32: spdifrx: manage rebind
issue") in v5.7-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bb4af400c386374ab1047df44c508512c08c31f]
stable/5.10: [3a977b554f668382dfba31fd62e4cce4fe5643db]
stable/5.15: [0d75f887aabd80cf37ea48d28f159afa7850ea28]
stable/6.1: [4f1d74f74752eab8af6b8b28797dc6490d57374c]
stable/6.6: [23bdbd1ef3e063e03d3c50c15a591b005ebbae39]

CVE-2024-50293: net/smc: do not leave a dangling sk pointer in __smc_create()

Announce: https://lore.kernel.org/linux-cve-announce/2024111957-CVE-2024-50293-1bf1@gregkh/

Introduced by commit d25a92c ("net/smc: Introduce IPPROTO_SMC") in v6.11-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d293958a8595ba566fb90b99da4d6263e14fee15]

CVE-2024-50294: rxrpc: Fix missing locking causing hanging calls

Announce: https://lore.kernel.org/linux-cve-announce/2024111958-CVE-2024-50294-0ac7@gregkh/

Introduced by commit 9d35d88 ("rxrpc: Move client call connection to
the I/O thread") in v6.2-rc4.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc9de52de38f656399d2ce40f7349a6b5f86e787]
stable/6.6: [996a7208dadbf2cdda8d51444d5ee1fdd1ccbc92]

CVE-2024-50295: net: arc: fix the device for dma_map_single/dma_unmap_single

Announce: https://lore.kernel.org/linux-cve-announce/2024111959-CVE-2024-50295-1201@gregkh/

Introduced by commit f959dcd ("dma-direct: Fix potential NULL pointer
dereference") in v5.10-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71803c1dfa29e0d13b99e48fda11107cc8caebc7]
stable/5.10: [30606ea3fae57f8e9f2467415389e988e3c53a18]
stable/5.15: [3898393b5483c8aa2efd7cb13aa70e22078ab022]
stable/6.1: [fd4e062fbc07156f8e9d73212d347c744572677e]
stable/6.6: [8ed7a4a39c3f7cd9655af867e878fda512ae67ad]

CVE-2024-50296: net: hns3: fix kernel crash when uninstalling driver

Announce: https://lore.kernel.org/linux-cve-announce/2024111900-CVE-2024-50296-774e@gregkh/

Introduced by commit 0dd8a25 ("net: hns3: disable sriov before unload
hclge layer") in v5.15-rc7.
Fixed in v6.12-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.4

Fixed status
mainline: [df3dff8ab6d79edc942464999d06fbaedf8cdd18]
stable/4.19: [a0df055775f30850c0da8f7dab40d67c0fd63908]
stable/5.10: [590a4b2d4e0b73586e88bce9b8135b593355ec09]
stable/5.15: [e36482b222e00cc7aeeea772fc0cf2943590bc4d]
stable/5.4: [7ae4e56de7dbd0999578246a536cf52a63f4056d]
stable/6.1: [76b155e14d9b182ce83d32ada2d0d7219ea8c8dd]
stable/6.6: [719edd9f3372ce7fb3b157647c6658672946874b]

CVE-2024-50297: net: xilinx: axienet: Enqueue Tx packets in dql before
dmaengine starts

Announce: https://lore.kernel.org/linux-cve-announce/2024111902-CVE-2024-50297-7693@gregkh/

Introduced by commit 6a91b84 ("net: axienet: Introduce dmaengine
support") in v6.8-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ccdcdf186aec6b9111845fd37e1757e9b413e2f]

CVE-2024-50298: net: enetc: allocate vf_state during PF probes

Announce: https://lore.kernel.org/linux-cve-announce/2024111903-CVE-2024-50298-2ef7@gregkh/

Introduced by commit d4fd040 ("enetc: Introduce basic PF and VF ENETC
ethernet drivers") in v5.1-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e15c5506dd39885cd047f811a64240e2e8ab401b]
stable/6.6: [ef0edfbe9eeed1fccad7cb705648af5222664944]

CVE-2024-50299: sctp: properly validate chunk size in sctp_sf_ootb()

Announce: https://lore.kernel.org/linux-cve-announce/2024111904-CVE-2024-50299-795d@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ead60804b64f5bd6999eec88e503c6a1a242d41]
stable/4.19: [67b9a278b80f71ec62091ded97c6bcbea33b5ec3]
stable/5.10: [40b283ba76665437bc2ac72079c51b57b25bff9e]
stable/5.15: [a758aa6a773bb872196bcc3173171ef8996bddf0]
stable/5.4: [9b5d42aeaf1a52f73b003a33da6deef7df34685f]
stable/6.1: [bf9bff13225baf5f658577f7d985fc4933d79527]
stable/6.6: [d3fb3cc83cf313e4f87063ce0f3fea76b071567b]

CVE-2024-50300: regulator: rtq2208: Fix uninitialized use of regulator_config

Announce: https://lore.kernel.org/linux-cve-announce/2024111906-CVE-2024-50300-a5c0@gregkh/

Introduced by commit 85a11f5 ("regulator: rtq2208: Add Richtek RTQ2208
SubPMIC") in v6.6-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2feb023110843acce790e9089e72e9a9503d9fa5]
stable/6.6: [9b7c0405af667857b3ad24a7ef6723f5475a9e43]

CVE-2024-50301: security/keys: fix slab-out-of-bounds in key_task_permission

Announce: https://lore.kernel.org/linux-cve-announce/2024111907-CVE-2024-50301-ec76@gregkh/

Introduced by commit b2a4df2 ("KEYS: Expand the capacity of a
keyring") in v3.13-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a74da044ec9ec8679e6beccc4306b936b62873f]
stable/4.19: [c3ce634ad953ce48c75c39bdfd8b711dd95f346f]
stable/5.10: [1e4332581cd4eed75aea77af6f66cdcdda8b49b9]
stable/5.15: [199c20fb7499c79557a075dc24e9a7dae7d9f1ce]
stable/5.4: [4efb69a0e294ef201bcdf7ce3d6202cd0a545a5d]
stable/6.1: [bbad2d5b6c99db468d8f88b6ba6a56ed409b4881]
stable/6.6: [3e79ad156bedf2da0ab909a118d2cec6c9c22b79]

CVE-2024-50302: HID: core: zero-initialize the report buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024111908-CVE-2024-50302-f677@gregkh/

Introduced by commit 27ce405 ("HID: fix data access in implement()")
in v3.12-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [177f25d1292c7e16e1199b39c85480f7f8815552]
stable/4.19: [e7ea60184e1e88a3c9e437b3265cbb6439aa7e26]
stable/5.10: [d7dc68d82ab3fcfc3f65322465da3d7031d4ab46]
stable/5.15: [05ade5d4337867929e7ef664e7ac8e0c734f1aaf]
stable/5.4: [3f9e88f2672c4635960570ee9741778d4135ecf5]
stable/6.1: [1884ab3d22536a5c14b17c78c2ce76d1734e8b0b]
stable/6.6: [9d9f5c75c0c7f31766ec27d90f7a6ac673193191]

CVE-2024-50303: resource,kexec: walk_system_ram_res_rev must retain
resource flags

Announce: https://lore.kernel.org/linux-cve-announce/2024111922-CVE-2024-50303-2bd7@gregkh/

Introduced by commit 7acf164 ("resource: add
walk_system_ram_res_rev()") in v6.8-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b125a0def25a082ae944c9615208bf359abdb61c]

CVE-2024-50304: ipv4: ip_tunnel: Fix suspicious RCU usage warning in
ip_tunnel_find()

Announce: https://lore.kernel.org/linux-cve-announce/2024111924-CVE-2024-50304-da6d@gregkh/

Introduced by commit c544193 ("GRE: Refactor GRE tunneling code.") in v3.10-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90e0569dd3d32f4f4d2ca691d3fa5a8a14a13c12]

CVE-2024-53042: ipv4: ip_tunnel: Fix suspicious RCU usage warning in
ip_tunnel_init_flow()

Announce: https://lore.kernel.org/linux-cve-announce/2024111924-CVE-2024-53042-f7e1@gregkh/

Introduced by commit db53cd3 ("net: Handle l3mdev in
ip_tunnel_init_flow") in v5.18-rc4.
Fixed in v6.12-rc6.
Bug introduced commit was backported to following branches.
cip/5.10 stable/5.10 stable/5.15

Fixed status
mainline: [ad4a3ca6a8e886f6491910a3ae5d53595e40597d]
stable/5.10: [e2742758c9c85c84e077ede5f916479f724e11c2]
stable/5.15: [5edcb3fdb12c3d46a6e79eeeec27d925b80fc168]
stable/6.1: [72c0f482e39c87317ebf67661e28c8d86c93e870]
stable/6.6: [699b48fc31727792edf2cab3829586ae6ba649e2]

CVE-2024-53043: mctp i2c: handle NULL header address

Announce: https://lore.kernel.org/linux-cve-announce/2024111925-CVE-2024-53043-f450@gregkh/

Introduced by commit f5b8abf ("mctp i2c: MCTP I2C binding driver") in v5.18-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01e215975fd80af81b5b79f009d49ddd35976c13]
stable/6.1: [4707893315802a0917231b94cb20cbe50ccbfe03]
stable/6.6: [8e886e44397ba89f6e8da8471386112b4f5b67b7]

CVE-2024-53044: net/sched: sch_api: fix xa_insert() error path in
tcf_block_get_ext()

Announce: https://lore.kernel.org/linux-cve-announce/2024111925-CVE-2024-53044-e0d1@gregkh/

Introduced by commit 94e2557 ("net: sched: move block device tracking
into tcf_block_get/put_ext()") in v6.8-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a13e690191eafc154b3f60afe9ce35aa9b9128b4]

CVE-2024-53045: ASoC: dapm: fix bounds checker error in dapm_widget_list_create

Announce: https://lore.kernel.org/linux-cve-announce/2024111925-CVE-2024-53045-e1dc@gregkh/

Introduced by commit 80e698e ("ASoC: soc-dapm: Annotate struct
snd_soc_dapm_widget_list with __counted_by") in v6.7-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ef9439f7a19fd3d43b288d38b1c6e55b668a4fe]

CVE-2024-53046: arm64: dts: imx8ulp: correct the flexspi compatible string

Announce: https://lore.kernel.org/linux-cve-announce/2024111926-CVE-2024-53046-b36d@gregkh/

Introduced by commit ef89fd5 ("arm64: dts: imx8ulp: add flexspi node")
in v6.6-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [409dc5196d5b6eb67468a06bf4d2d07d7225a67b]
stable/6.6: [e3fb0e6afcc399660770428a35162b4880e2e14e]

CVE-2024-53047: mptcp: init: protect sched with rcu_read_lock

Announce: https://lore.kernel.org/linux-cve-announce/2024111926-CVE-2024-53047-8214@gregkh/

Introduced by commit 1730b2b ("mptcp: add sched in mptcp_sock") in v6.6-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3deb12c788c385e17142ce6ec50f769852fcec65]
stable/6.6: [cb8b81ad3e893a6d18dcdd3754cc2ea2a42c0136]

CVE-2024-53048: ice: fix crash on probe for DPLL enabled E810 LOM

Announce: https://lore.kernel.org/linux-cve-announce/2024111926-CVE-2024-53048-cdd4@gregkh/

Introduced by commit d7999f5 ("ice: implement dpll interface to
control cgu") in v6.7-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e58c33106220c6c0c8fbee9ab63eae76ad8f260]

CVE-2024-53049: slub/kunit: fix a WARNING due to unwrapped
__kmalloc_cache_noprof

Announce: https://lore.kernel.org/linux-cve-announce/2024111926-CVE-2024-53049-fa45@gregkh/

Introduced by commit a0a44d9 ("mm, slab: don't wrap internal functions
with alloc_hooks()") in v6.11-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b059d0d1e624adc6e69a754bc48057f8bf459dc]

CVE-2024-53050: drm/i915/hdcp: Add encoder check in hdcp2_get_capability

Announce: https://lore.kernel.org/linux-cve-announce/2024111927-CVE-2024-53050-b59c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit d079b7e ("drm/i915: Factor out HDCP shim
functions from dp for use by dp_mst") in 5.10-rc1.
It looks as if commit 130849f ("drm/i915/hdcp: Use intel_connector as
argument for hdcp_2_2_capable") in 6.7-rc1 started using intel_dp_hdcp2_capable
function in the affected function.

Fixed status
mainline: [d34f4f058edf1235c103ca9c921dc54820d14d40]

CVE-2024-53051: drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability

Announce: https://lore.kernel.org/linux-cve-announce/2024111927-CVE-2024-53051-5184@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
It looks as if this bug was introduced by commit bdc93fe0 ("drm/i915/debugfs:
hdcp capability of a sink") in 5.0-rc1.

Fixed status
mainline: [31b42af516afa1e184d1a9f9dd4096c54044269a]

CVE-2024-53052: io_uring/rw: fix missing NOWAIT check for O_DIRECT start write

Announce: https://lore.kernel.org/linux-cve-announce/2024111927-CVE-2024-53052-3bd9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc6.

Fixed status
mainline: [1d60d74e852647255bd8e76f5a22dc42531e4389]
stable/5.10: [485d9232112b17f389b29497ff41b97b3189546b]
stable/5.15: [4e24041ba86d50aaa4c792ae2c88ed01b3d96243]
stable/6.1: [9e8debb8e51354b201db494689198078ec2c1e75]
stable/6.6: [003d2996964c03dfd34860500428f4cdf1f5879e]

CVE-2024-53053: scsi: ufs: core: Fix another deadlock during RTC update

Announce: https://lore.kernel.org/linux-cve-announce/2024111927-CVE-2024-53053-57bf@gregkh/

Introduced by commit 6bf999e ("scsi: ufs: core: Add UFS RTC support")
in v6.8-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb7e509c4e0197f63717fee54fb41c4990ba8d3a]

CVE-2024-53054: cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction

Announce: https://lore.kernel.org/linux-cve-announce/2024111927-CVE-2024-53054-7da4@gregkh/

Introduced by commit 4bfc0bb ("bpf: decouple the lifetime of
cgroup_bpf from cgroup itself") in v5.3-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [117932eea99b729ee5d12783601a4f7f5fd58a23]
stable/6.1: [71f14a9f5c7db72fdbc56e667d4ed42a1a760494]
stable/6.6: [0d86cd70fc6a7ba18becb52ad8334d5ad3eca530]

CVE-2024-53055: wifi: iwlwifi: mvm: fix 6 GHz scan construction

Announce: https://lore.kernel.org/linux-cve-announce/2024111928-CVE-2024-53055-4a64@gregkh/

Introduced by commit eae94cf ("iwlwifi: mvm: add support for 6GHz") in
v5.11-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7245012f0f496162dd95d888ed2ceb5a35170f1a]
stable/5.15: [2ac15e5a8f42fed5d90ed9e1197600913678c50f]
stable/6.1: [cde8a7eb5c6762264ff0f4433358e0a0d250c875]
stable/6.6: [fc621e7a043de346c33bd7ae7e2e0c651d6152ef]

CVE-2024-53056: drm/mediatek: Fix potential NULL dereference in
mtk_crtc_destroy()

Announce: https://lore.kernel.org/linux-cve-announce/2024111928-CVE-2024-53056-ae69@gregkh/

Introduced by commit 7627122 ("drm/mediatek: Add cmdq_handle in
mtk_crtc") in v5.17-rc1.
Fixed in v6.12-rc6.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [4018651ba5c409034149f297d3dd3328b91561fd]

CVE-2024-53057: net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Announce: https://lore.kernel.org/linux-cve-announce/2024111928-CVE-2024-53057-a3a5@gregkh/

Introduced by commit 066a3b5 ("[NET_SCHED] sch_api: fix
qdisc_tree_decrease_qlen() loop") in v2.6.25.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e95c4384438adeaa772caa560244b1a2efef816]
stable/4.19: [e7f9a6f97eb067599a74f3bcb6761976b0ed303e]
stable/5.10: [ce691c814bc7a3c30c220ffb5b7422715458fd9b]
stable/5.15: [05df1b1dff8f197f1c275b57ccb2ca33021df552]
stable/5.4: [dbe778b08b5101df9e89bc06e0a3a7ecd2f4ef20]
stable/6.1: [580b3189c1972aff0f993837567d36392e9d981b]
stable/6.6: [597cf9748c3477bf61bc35f0634129f56764ad24]

CVE-2024-53058: net: stmmac: TSO: Fix unbalanced DMA map/unmap for
non-paged SKB data

Announce: https://lore.kernel.org/linux-cve-announce/2024111928-CVE-2024-53058-7bd0@gregkh/

Introduced by commit f748be5 ("stmmac: support new GMAC4") in v4.7-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66600fac7a984dea4ae095411f644770b2561ede]
stable/5.15: [ece593fc9c00741b682869d3f3dc584d37b7c9df]
stable/6.1: [a3ff23f7c3f0e13f718900803e090fd3997d6bc9]
stable/6.6: [07c9c26e37542486e34d767505e842f48f29c3f6]

CVE-2024-53059: wifi: iwlwifi: mvm: Fix response handling in
iwl_mvm_send_recovery_cmd()

Announce: https://lore.kernel.org/linux-cve-announce/2024111928-CVE-2024-53059-4f81@gregkh/

Introduced by commit f130bb7 ("iwlwifi: add FW recovery flow") in v5.1-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07a6e3b78a65f4b2796a8d0d4adb1a15a81edead]
stable/5.10: [45a628911d3c68e024eed337054a0452b064f450]
stable/5.15: [3f45d590ccbae6dfd6faef54efe74c30bd85d3da]
stable/5.4: [9c98ee7ea463a838235e7a0e35851b38476364f2]
stable/6.1: [64d63557ded6ff3ce72b18ab87a6c4b1b652161c]
stable/6.6: [3eb986c64c6bfb721950f9666a3b723cf65d043f]

CVE-2024-53060: drm/amdgpu: prevent NULL pointer dereference if ATIF
is not supported

Announce: https://lore.kernel.org/linux-cve-announce/2024111931-CVE-2024-53060-3b94@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc7.
It looks as if this bug was introduced by commit d38ceaf ("drm/amdgpu:
add core driver (v4)") in 4.2-rc1.

Fixed status
mainline: [a6dd15981c03f2cdc9a351a278f09b5479d53d2e]
stable/4.19: [ce8a00a00e36f61f5a1e47734332420b68784c43]
stable/5.10: [2ac7f253deada4d449559b65a1c1cd0a6f6f19b7]
stable/5.15: [27fc29b5376998c126c85cf9b15d9dfc2afc9cbe]
stable/5.4: [8d7a28eca7553d35d4ce192fa1f390f2357df41b]
stable/6.1: [1a9f55ed5b512f510ccd21ad527d532e60550e80]
stable/6.6: [a613a392417532ca5aaf3deac6e3277aa7aaef2b]

CVE-2024-53061: media: s5p-jpeg: prevent buffer overflows

Announce: https://lore.kernel.org/linux-cve-announce/2024111931-CVE-2024-53061-a7a1@gregkh/

Introduced by commit 6c96dbb ("[media] s5p-jpeg: add support for
5433") in v4.4-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14a22762c3daeac59a5a534e124acbb4d7a79b3a]
stable/4.19: [c5f6fefcda8fac8f082b6c5bf416567f4e100c51]
stable/5.10: [f54e8e1e39dacccebcfb9a9a36f0552a0a97e2ef]
stable/5.15: [a930cddfd153b5d4401df0c01effa14c831ff21e]
stable/5.4: [e5117f6e7adcf9fd7546cdd0edc9abe4474bc98b]
stable/6.1: [c85db2d4432de4ff9d97006691ce2dcb5bda660e]
stable/6.6: [784bc785a453eb2f8433dd62075befdfa1b2d6fd]

CVE-2024-53062: media: mgb4: protect driver against spectre

Announce: https://lore.kernel.org/linux-cve-announce/2024111931-CVE-2024-53062-c9f7@gregkh/

Introduced by commit 0ab1367 ("media: pci: mgb4: Added Digiteq
Automotive MGB4 driver") in v6.7-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aee207e5b3c94ef859316008119ea06d6798d49]

CVE-2024-53063: media: dvbdev: prevent the risk of out of memory access

Announce: https://lore.kernel.org/linux-cve-announce/2024111932-CVE-2024-53063-1ffa@gregkh/

Introduced by commit 5dd3f30 ("V4L/DVB (9361): Dynamic DVB minor
allocation") in v2.6.29-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [972e63e895abbe8aa1ccbdbb4e6362abda7cd457]
stable/4.19: [fedfde9deb83ac8d2f3d5f36f111023df34b1684]
stable/5.10: [a4a17210c03ade1c8d9a9f193a105654b7a05c11]
stable/5.15: [5f76f7df14861e3a560898fa41979ec92424b58f]
stable/5.4: [3b88675e18b6517043a6f734eaa8ea6eb3bfa140]
stable/6.1: [b751a96025275c17f04083cbfe856822f1658946]
stable/6.6: [1e461672616b726f29261ee81bb991528818537c]

CVE-2024-53064: idpf: fix idpf_vc_core_init error path

Announce: https://lore.kernel.org/linux-cve-announce/2024111932-CVE-2024-53064-119c@gregkh/

Introduced by commit 4930fbf ("idpf: add core init and interrupt
request") in v6.7-rc1.
Introduced by commit 34c21fa ("idpf: implement virtchnl transaction
manager") in v6.9-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b58031ff96b84a38d7b73b23c7ecfb2e0557f43]

CVE-2024-53065: mm/slab: fix warning caused by duplicate kmem_cache
creation in kmem_buckets_create

Announce: https://lore.kernel.org/linux-cve-announce/2024111932-CVE-2024-53065-3a63@gregkh/

Introduced by commit b32801d ("mm/slab: Introduce
kmem_buckets_create() and family") in v6.11-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c9201afebea1efc7ea4b8f721ee18a05bb8aca1]

CVE-2024-53066: nfs: Fix KMSAN warning in decode_getfattr_attrs()

Announce: https://lore.kernel.org/linux-cve-announce/2024111932-CVE-2024-53066-abf7@gregkh/

Introduced by commit 88034c3 ("NFSv4.1 mdsthreshold attribute xdr") in v3.5-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc270d7159699ad6d11decadfce9633f0f71c1db]
stable/4.19: [25ffd294fef81a7f3cd9528adf21560c04d98747]
stable/5.10: [8fc5ea9231af9122d227c9c13f5e578fca48d2e3]
stable/5.15: [9b453e8b108a5a93a6e348cf2ba4c9c138314a00]
stable/5.4: [bbfcd261cc068fe1cd02a4e871275074a0daa4e2]
stable/6.1: [f6b2b2b981af8e7d7c62d34143acefa4e1edfe8b]
stable/6.6: [f749cb60a01f8391c760a1d6ecd938cadacf9549]

CVE-2024-53067: scsi: ufs: core: Start the RTC update work later

Announce: https://lore.kernel.org/linux-cve-announce/2024111933-CVE-2024-53067-0c9e@gregkh/

Introduced by commit 6bf999e ("scsi: ufs: core: Add UFS RTC support")
in v6.8-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54c814c8b23bc7617be3d46abdb896937695dbfa]

CVE-2024-53068: firmware: arm_scmi: Fix slab-use-after-free in
scmi_bus_notifier()

Announce: https://lore.kernel.org/linux-cve-announce/2024111933-CVE-2024-53068-8c2a@gregkh/

Introduced by commit ee7a9c9 ("firmware: arm_scmi: Add support for
multiple device per protocol") in v5.6-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [295416091e44806760ccf753aeafdafc0ae268f3]
stable/6.6: [15b17bbcea07d49c43d21aa700485cbd9f9d00d8]

CVE-2024-53069: firmware: qcom: scm: fix a NULL-pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024111933-CVE-2024-53069-2786@gregkh/

Introduced by commit 449d0d8 ("firmware: qcom: scm: smc: switch to
using the SCM allocator") in v6.11-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca61d6836e6f4442a77762e1074d2706a2a6e578]

CVE-2024-53070: usb: dwc3: fix fault at system suspend if device was
already runtime suspended

Announce: https://lore.kernel.org/linux-cve-announce/2024111933-CVE-2024-53070-6eea@gregkh/

None
This bug was introduced by commit 705e3ce ("usb: dwc3: core: Fix system
suspend on TI AM62 platforms") in 6.12-rc4. Fixed in 6.12-rc7.
Bug introduced commit was backported to following branches.
cip/6.1 stable/5.15 stable/6.1 stable/6.11 stable/6.6

Fixed status
mainline: [9cfb31e4c89d200d8ab7cb1e0bb9e6e8d621ca0b]
stable/5.15: [d9e65d461a9de037e7c9d584776d025cfce6d86d]
stable/6.1: [562804b1561cc248cc37746a1c96c83cab1d7209]
stable/6.6: [4abc5ee334fe4aba50461c45fdaaa4c5e5c57789]

CVE-2024-53071: drm/panthor: Be stricter about IO mapping flags

Announce: https://lore.kernel.org/linux-cve-announce/2024111934-CVE-2024-53071-ddbc@gregkh/

Introduced by commit 5fe909c ("drm/panthor: Add the device logical
block") in v6.10-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f432a1621f049bb207e78363d9d0e3c6fa2da5db]

CVE-2024-53072: platform/x86/amd/pmc: Detect when STB is not available

Announce: https://lore.kernel.org/linux-cve-announce/2024111934-CVE-2024-53072-f307@gregkh/

Introduced by commit 3d7d407 ("platform/x86: amd-pmc: Add support for
AMD Spill to DRAM STB feature") in v5.18-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bceec87a73804bb4c33b9a6c96e2d27cd893a801]
stable/6.1: [a50863dd1f92d43c975ab2ecc3476617fe98a66e]
stable/6.6: [7a3ed3f125292bc3398e04d10108124250892e3f]

CVE-2024-53073: NFSD: Never decrement pending_async_copies on error

Announce: https://lore.kernel.org/linux-cve-announce/2024111924-CVE-2024-53073-16f8@gregkh/

None
This bug was introduced by commit aadc3bb ("NFSD: Limit the number of
concurrent async COPY operations") in 6.12-rc1. Fixed in 6.12-rc6.
Bug introduced commit was backported to following branches.
stable/6.11

Fixed status
mainline: [8286f8b622990194207df9ab852e0f87c60d35e9]

CVE-2024-53074: wifi: iwlwifi: mvm: don't leak a link on AP removal

Announce: https://lore.kernel.org/linux-cve-announce/2024111924-CVE-2024-53074-e49b@gregkh/

Introduced by commit a8b5d48 ("wifi: iwlwifi: mvm: Configure the link
mapping for non-MLD FW") in v6.9-rc2.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ed092997a004d68a3a5b0eeb94e71b69839d0f7]

CVE-2024-53075: riscv: Prevent a bad reference count on CPU nodes

Announce: https://lore.kernel.org/linux-cve-announce/2024111924-CVE-2024-53075-2e34@gregkh/

Introduced by commit 604f32e ("riscv: cacheinfo: initialize
cacheinfo's level and  type from ACPI PPTT") in v6.11-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37233169a6ea912020c572f870075a63293b786a]

CVE-2024-53076: iio: gts-helper: Fix memory leaks for the error path
of iio_gts_build_avail_scale_table()

Announce: https://lore.kernel.org/linux-cve-announce/2024111925-CVE-2024-53076-713e@gregkh/

Introduced by commit 38416c2 ("iio: light: Add gain-time-scale
helpers") in v6.4-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [369f05688911b05216cfcd6ca74473bec87948d7]
stable/6.6: [62c11896683129790b8f5ab6eb7e695818b0b723]

CVE-2024-53077: rpcrdma: Always release the rpcrdma_device's xa_array

Announce: https://lore.kernel.org/linux-cve-announce/2024111925-CVE-2024-53077-f48f@gregkh/

Introduced by commit 7e86845 ("rpcrdma: Implement generic device
removal") in v6.11-rc1.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63a81588cd2025e75fbaf30b65930b76825c456f]

CVE-2024-53078: drm/tegra: Fix NULL vs IS_ERR() check in probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024111925-CVE-2024-53078-f504@gregkh/

Introduced by commit 45c690a ("drm/tegra: Use
iommu_paging_domain_alloc()") in v6.11.
Fixed in v6.12-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a85df8c7b5ee2d3d4823befada42c5c41aff4cb0]

CVE-2024-53079: mm/thp: fix deferred split unqueue naming and locking

Announce: https://lore.kernel.org/linux-cve-announce/2024111901-CVE-2024-53079-7501@gregkh/

Introduced by commit 87eaceb ("mm: thp: make deferred split shrinker
memcg aware") in v5.4-rc1.
Introduced by commit dafff3f ("mm: split underused THPs") in v6.12-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8f931bba0f92052cf842b7e30917b1afcc77d5a]
stable/6.6: [fc4951c3e3358dd82ea508e893695b916c813f17]

CVE-2024-53080: drm/panthor: Lock XArray when getting entries for the VM

Announce: https://lore.kernel.org/linux-cve-announce/2024111904-CVE-2024-53080-e1a8@gregkh/

Introduced by commit 647810e ("drm/panthor: Add the MMU/VM logical
block") in v6.10-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [444fa5b100e5c90550d6bccfe4476efb0391b3ca]

CVE-2024-53081: media: ar0521: don't overflow when checking PLL values

Announce: https://lore.kernel.org/linux-cve-announce/2024111904-CVE-2024-53081-72b5@gregkh/

Introduced by commit 852b50a ("media: On Semi AR0521 sensor driver")
in v6.0-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [438d3085ba5b8b5bfa5290faa594e577f6ac9aa7]
stable/6.1: [5e1523076acf95b4ea68d19b6f27e6891267cc24]
stable/6.6: [a244b82d0ae60326901f2b50c15e3118298b7ecd]

CVE-2024-53082: virtio_net: Add hash_key_length check

Announce: https://lore.kernel.org/linux-cve-announce/2024111904-CVE-2024-53082-30c0@gregkh/

Introduced by commit c7114b1 ("drivers/net/virtio_net: Added basic RSS
support.") in v5.18-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f7d9c1964fcd16d02a8a9d4fd6f6cb60c4cc530]
stable/6.1: [f3401e3c8d339ddb6ccb2e3d11ad634b7846a806]
stable/6.6: [af0aa8aecbe8985079232902894cc4cb62795691]

CVE-2024-53083: usb: typec: qcom-pmic: init value of hdr_len/txbuf_len earlier

Announce: https://lore.kernel.org/linux-cve-announce/2024111905-CVE-2024-53083-6ed0@gregkh/

Introduced by commit a4422ff (" usb: typec: qcom: Add Qualcomm PMIC
Type-C driver") in v6.5-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [029778a4fd2c90c2e76a902b797c2348a722f1b8]
stable/6.6: [35925e2b7b404cad3db857434d3312b892b55432]

CVE-2024-53084: drm/imagination: Break an object reference loop

Announce: https://lore.kernel.org/linux-cve-announce/2024111905-CVE-2024-53084-1021@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc7.
The drm/imagination driver was added by commit 4babef0 ("drm/imagination: Add
skeleton PowerVR driver") in 6.8-rc1.

Fixed status
mainline: [b04ce1e718bd55302b52d05d6873e233cb3ec7a1]

CVE-2024-53085: tpm: Lock TPM chip in tpm_pm_suspend() first

Announce: https://lore.kernel.org/linux-cve-announce/2024111905-CVE-2024-53085-9cf3@gregkh/

Introduced by commit 99d4645 ("tpm: Prevent hwrng from activating
during resume") in v6.4-rc3.
Fixed in v6.12-rc7.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [9265fed6db601ee2ec47577815387458ef4f047a]

CVE-2024-53086: drm/xe: Drop VM dma-resv lock on xe_sync_in_fence_get
failure in exec IOCTL

Announce: https://lore.kernel.org/linux-cve-announce/2024111906-CVE-2024-53086-af24@gregkh/

Introduced by commit 58480c1 ("drm/xe: Skip VMAs pin when requesting
signal to the last XE_EXEC") in v6.10-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64a2b6ed4bfd890a0e91955dd8ef8422a3944ed9]

CVE-2024-53087: drm/xe: Fix possible exec queue leak in exec IOCTL

Announce: https://lore.kernel.org/linux-cve-announce/2024111906-CVE-2024-53087-6cd3@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af797b831d8975cb4610f396dcb7f03f4b9908e7]

CVE-2024-53088: i40e: fix race condition by adding filter's
intermediate sync state

Announce: https://lore.kernel.org/linux-cve-announce/2024111906-CVE-2024-53088-795c@gregkh/

Introduced by commit 278e7d0 ("i40e: store MAC/VLAN filters in a hash
with the MAC Address as key") in v4.10-rc1.
Fixed in v6.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f30490e9695ef7da3d0899c6a0293cc7cd373567]
stable/5.15: [262dc6ea5f1eb18c4d08ad83d51222d0dd0dd42a]
stable/6.1: [7ad3fb3bfd43feb4e15c81dffd23ac4e55742791]
stable/6.6: [bf5f837d9fd27d32fb76df0a108babcaf4446ff1]

* Updated CVEs

CVE-2024-38538: net: bridge: xmit: make sure we have at least eth
header len bytes

stable/5.15 was fixed.

Fixed status
stable/5.15: [c964429ef53f42098a6545a5dabeb1441c1e821d]
stable/6.1: [28126b83f86ab9cc7936029c2dff845d3dcedba2]
stable/6.6: [1abb371147905ba250b4cc0230c4be7e90bea4d5]
stable/6.9: [5b5d669f569807c7ab07546e73c0741845a2547a]

CVE-2024-38540: bnxt_re: avoid shift undefined behavior in
bnxt_qplib_alloc_init_hwq

stable/6.1 was fixed.

Fixed status
stable/6.1: [84d2f29152184f0d72ed7c9648c4ee6927df4e59]
stable/6.6: [a658f011d89dd20cf2c7cb4760ffd79201700b98]
stable/6.9: [8b799c00cea6fcfe5b501bbaeb228c8821acb753]

CVE-2024-42291: ice: Add a per-VF limit on number of FDIR filters

stable/5.15 was fixed.

Fixed status
stable/5.15: [e81b674ead8e2172b2a69e7b45e079239ace4dbc]
stable/6.1: [8e02cd98a6e24389d476e28436d41e620ed8e559]
stable/6.10: [292081c4e7f575a79017d5cbe1a0ec042783976f]
stable/6.6: [d62389073a5b937413e2d1bc1da06ccff5103c0c]

CVE-2024-43868: riscv/purgatory: align riscv_kernel_entry

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [10ffafb456f293976c42f700578ef740467cb569]
stable/6.10: [5d4aaf16a8255f7c71790e211724ba029609c5ff]
stable/6.6: [6e62dab357eea12db0fc62dea94c7a892888e6e8]

CVE-2024-50036: net: do not delay dst_entries_add() in dst_release()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [e3915f028b1f1c37e87542e5aadd33728c259d96]
stable/6.1: [a60db84f772fc3a906c6c4072f9207579c41166f]
stable/6.11: [3c7c918ec0aa3555372c5a57f18780b7a96c5cfc]
stable/6.6: [eae7435b48ffc8e9be0ff9cfeae40af479a609dd]

CVE-2024-50126: net: sched: use RCU read-side critical section in taprio_dump()

stable/6.1 was fixed.

Fixed status
stable/6.1: [b911fa9e92ee586e36479ad57b88f20471acaca1]
stable/6.11: [e4369cb6acf6b895ac2453cc1cdf2f4326122c6d]
stable/6.6: [5d282467245f267c0b9ada3f7f309ff838521536]

CVE-2021-47195: spi: fix use-after-free of the add_lock mutex

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [11eab327a2a8bd36c38afbff920ae1bd45588dd4]
stable/5.15: [37330f37f6666c7739a44b2b6b95b047ccdbed2d]
stable/5.4: [54c2c96eafcfd242e52e932ab54ace4784efe1dd]

CVE-2021-47469: spi: Fix deadlock when adding SPI controllers on SPI buses

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [c8dce228db6f81dbc897a018dfc5c418e917cf64]
stable/5.4: [aa3f3d7bef59583f2d3234173105a27ff61ef8fe]

CVE-2024-38538: net: bridge: xmit: make sure we have at least eth
header len bytes

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [3e01fc3c66e65d9afe98f1489047a1b2dd8741ca]
stable/5.10: [82090f94c723dab724b1c32db406091d40448a17]
stable/5.15: [c964429ef53f42098a6545a5dabeb1441c1e821d]
stable/5.4: [b2b7c43cd32080221bb233741bd6011983fe7c11]
stable/6.1: [28126b83f86ab9cc7936029c2dff845d3dcedba2]
stable/6.6: [1abb371147905ba250b4cc0230c4be7e90bea4d5]
stable/6.9: [5b5d669f569807c7ab07546e73c0741845a2547a]

CVE-2024-38588: ftrace: Fix possible use-after-free issue in ftrace_location()

stable/5.4 was fixed.

Fixed status
stable/5.10: [1880a324af1c95940a7c954b6b937e86844a33bd]
stable/5.15: [8ea8ef5e42173560ac510e92a1cc797ffeea8831]
stable/5.4: [eea46baf145150910ba134f75a67106ba2222c1b]
stable/6.1: [dbff5f0bfb2416b8b55c105ddbcd4f885e98fada]
stable/6.6: [7b4881da5b19f65709f5c18c1a4d8caa2e496461]
stable/6.9: [31310e373f4c8c74e029d4326b283e757edabc0b]

CVE-2024-41080: io_uring: fix possible deadlock in
io_register_iowq_max_workers()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b17397a0a5c56e111f61cb5b77d162664dc00de9]
stable/5.15: [97ed7ff58de66c544692b3c2b988f3f594348de0]
stable/6.1: [fdacd09f2ddf7a00787291f08ee48c0421e5b709]
stable/6.6: [950ac86cff338ab56e2eaf611f4936ee34893b63]

CVE-2024-47674: mm: avoid leaving partial pfn mappings around in error case

stable/5.4 was fixed.

Fixed status
stable/5.10: [35770ca6180caa24a2b258c99a87bd437a1ee10f]
stable/5.15: [5b2c8b34f6d76bfbd1dd4936eb8a0fbfb9af3959]
stable/5.4: [3213fdcab961026203dd587a4533600c70b3336b]
stable/6.1: [65d0db500d7c07f0f76fc24a4d837791c4862cd2]
stable/6.6: [a95a24fcaee1b892e47d5e6dcc403f713874ee80]

CVE-2024-49950: Bluetooth: L2CAP: Fix uaf in l2cap_connect

stable/6.1 was fixed.

Fixed status
stable/6.1: [b22346eec479a30bfa4a02ad2c551b54809694d0]
stable/6.11: [a1c6174e23df10b8e5770e82d63bc6e2118a3dc7]
stable/6.6: [b90907696c30172b809aa3dd2f0caffae761e4c6]

CVE-2024-49960: ext4: fix timer use-after-free on failed mount

stable/6.1 was fixed.

Fixed status
stable/6.1: [cf3196e5e2f36cd80dab91ffae402e13935724bc]
stable/6.11: [b85569585d0154d4db1e4f9e3e6a4731d407feb0]
stable/6.6: [9203817ba46ebba7c865c8de2aba399537b6e891]

CVE-2024-49986: platform/x86: x86-android-tablets: Fix use after free
on platform_device_register() errors

stable/6.1 was fixed.

Fixed status
stable/6.1: [ba0b09a2f327319e252d8f3032019b958c0a5cd9]
stable/6.11: [73a98cf79e4dbfa3d0c363e826c65aae089b313c]
stable/6.6: [aac871e493fc8809e60209d9899b1af07e9dbfc8]

CVE-2024-49991: drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer

stable/6.1 was fixed.

Fixed status
stable/6.1: [e7831613cbbcd9058d3658fbcdc5d5884ceb2e0c]
stable/6.11: [6c9289806591807e4e3be9a23df8ee2069180055]
stable/6.6: [30ceb873cc2e97348d9da2265b2d1ddf07f682e1]

CVE-2024-50036: net: do not delay dst_entries_add() in dst_release()

stable/5.10 was fixed.

Fixed status
stable/5.10: [547087307bc19417b4f2bc85ba9664a3e8db5a6a]
stable/5.15: [e3915f028b1f1c37e87542e5aadd33728c259d96]
stable/6.1: [a60db84f772fc3a906c6c4072f9207579c41166f]
stable/6.11: [3c7c918ec0aa3555372c5a57f18780b7a96c5cfc]
stable/6.6: [eae7435b48ffc8e9be0ff9cfeae40af479a609dd]

CVE-2024-50067: uprobe: avoid out-of-bounds memory access of fetching args

stable/6.1 was fixed.

Fixed status
stable/6.1: [0dc3ad9ad2188da7f090b3dbe4d2fcd9ae8ae64f]
stable/6.11: [537ad4a431f6dddbf15d40d19f24bb9ee12b55cb]
stable/6.6: [9e5f93788c9dd4309e75a56860a1ac44a8e117b9]

CVE-2024-50243: fs/ntfs3: Fix general protection fault in run_is_mapped_full

stable/6.1 was fixed.

Fixed status
stable/6.1: [509c1c6b499a4d9026b58c6e1c3a10ed8db1839f]
stable/6.11: [8e87c9aa8cf92cfceaff0aab244318bbb8b35137]
stable/6.6: [68b39c0765de7c97b34889c1f5e81c2a223fdacc]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

