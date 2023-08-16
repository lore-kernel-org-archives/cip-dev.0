Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82769C27C7A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 23:05:15 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web11.174852.1692227104172982044
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 16:05:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=3mEmKBW+;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56cc461f34fso4536800eaf.0
        for <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1692227102; x=1692831902;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WnkEJmXZIRP08CLSdC4RlQjVumTT3Tphb+d4P9g3Ps8=;
        b=3mEmKBW+RqM9wnIKA12mPuWZvx59K622upPY+tkqA4e/ZzLKn9qv1SeRxkZxI0qMUh
         q84pzn1QSlT4sqd5ak871go2xk663zh+8YN15DPCouUrsT4pwLuzbYvfqPySJvWdQkeF
         97w4cESnCNnWMHp+yKkZVbxDcXv85Mgml/kJzt7im/TwXDAh23XMhgtD4WhHxjoh/pru
         d+YVIHr1S6+DDz4BtpIPN9rStFSEvNGPFUBkaxYLvoUBEgskzpHDArQJExgAGnoiPQNF
         Rtc3k+us8fAcg7/GtBz1N11ezFN0MGZIZK0x6Zny+PAuaXcDiuhtvHt8MvtRsHXeQQPb
         n8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692227102; x=1692831902;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnkEJmXZIRP08CLSdC4RlQjVumTT3Tphb+d4P9g3Ps8=;
        b=gLm5E47VnE5LLPmoFmd0tk8yM8JQp4OcEYopEO8IpbpLtmG8Jtwi2MyQtrCaIb43P/
         2EUzofE/w4AONA+DNimSMy3kO1QtfDN4Oke62IzDjZXMKeeZJnsTDvSe6oBlWtFE50kj
         TJ8tRMootck0QcPzkzbHyhdRfi1spfAfq6FNOtfsJbBEYvu6Zp9tc+dM/HjnAsONQELl
         cY/4dEv5qYa/gYRyWmSJvEQ6Kla+WS+yr6UWz43+i4sL0I1KTsp/E2cSpfvXwzzlxf7D
         iY+tWRJg1IBru9CWkgtQ3evD0nfHLFClj8Cb5pBLxYHKbI1vyp7HBA3kfnVAX9hhHtN1
         zx4w==
X-Gm-Message-State: AOJu0Yw8ZA6nimI4ib+aY7ouX33Mo2IuDfL6+umSKg/ixHBsgwXSi/83
	soCK8DpVApVE/eyjqYeMx3PbP4Zh++HE908mrMZCsJaN1xlfiol+RbU=
X-Google-Smtp-Source: AGHT+IFeMmv+EPEMCc1NxVVbBUWC8Z04tHS+FdhdyrZG3qkj7xMeAYN0LHt9CX/13xFGUzmJMJ75+jfmmJozdTynqTI=
X-Received: by 2002:a4a:7619:0:b0:56e:4965:d412 with SMTP id
 t25-20020a4a7619000000b0056e4965d412mr3479180ooc.3.1692227102045; Wed, 16 Aug
 2023 16:05:02 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Aug 2023 08:04:25 +0900
Message-ID: <CAODzB9ou9nBiKb4Fge1NSg0ke+NaQF7mccV_d=GfewuTB2hKqQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 23:05:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12740

Hi !

It's this week's CVE report.

This week reported 2 new CVEs and 19 updated CVEs.

* New CVEs

CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the
net/sched classifiers: cls_fw, cls_u32 and cls_route

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free flaw was found in net/sched/cls_fw.c in classifiers
(cls_fw, cls_u32, and cls_route) in the Linux Kernel. This flaw allows
a local attacker to perform a local privilege escalation due to
incorrect handling of the existing filter, leading to a kernel
information leak issue.

This bug was introduced in 3.18-rc1.

Fixed status
mainline: [3044b16e7c6fe5d24b1cdbcf1bd0a9d92d1ebd81,
76e42ae831991c828cffa8c37736ebfb831ad5ec,
  b80b829e9e2c1b3f7aae34855e04d8f6ecaf13c8]

CVE-2023-40283: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

CVSS v3 score is not provided.

An issue was discovered in l2cap_sock_release in
net/bluetooth/l2cap_sock.c in the Linux kernel before 6.4.10. There is
a use-after-free because the children of an sk are mishandled.

Linux 4.4 seems to be affected too.

Fixed status
mainline: [1728137b33c00d5a2b5110ed7aafb42e7c32e4a1]
stable/4.14: [51822644a047eac2310fab0799b64e3430b5a111]
stable/4.19: [82cdb2ccbe43337798393369f0ceb98699fe6037]
stable/5.10: [06f87c96216bc5cd1094c23492274f77f1d5dd3b]
stable/5.15: [fbe5a2fed8156cc19eb3b956602b0a1dd46a302d]
stable/5.4: [a2da00d1ea1abfb04f846638e210b5b5166e3c9c]
stable/6.1: [29fac18499332211b2615ade356e2bd8b3269f98]
stable/6.4: [10426afe65c8bf7b24dd0c7be4dcc65f86fc99f9]

* Updated CVEs

CVE-2022-20166: drivers core: Use sysfs_emit and sysfs_emit_at for
show(device *...) functions

stable/4.19 was fixed.

Fixed status
mainline: [aa838896d87af561a33ecefea1caa4c15a68bc47]
stable/4.19: [3ce2cd63e8ee037644db0cbea65e6c40ab6cc178]
stable/5.4: [9e9241d3345af3f2a78a5b60701a9cf0d15bf942]

CVE-2023-1206: hash collisions in the IPv6 connection lookup table

stable 4.14, 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [d11b0df7ddf1831f3e170972f43186dad520bfcc]
stable/4.14: [ebfedbfb36eecab2d4bfa6faeaad763cbfe3a0e8]
stable/4.19: [8fa0dea2fc96f192d81a12434e48deda2e556320]
stable/5.10: [0cd74fbd3b8327e60525e1ec4a6c28895693909f]
stable/5.15: [ecb741a17cb2abf693b34d8e05a1e7e40494afb6]
stable/5.4: [d87d67c8bdd13b2d4f7414ba97c54ba825337c47]
stable/6.1: [51aea7e9d5212adb8a3d198510cfcde4125988f9]
stable/6.4: [1e50c11ed44e28a57c6215a5e7643ae85c6297fa]

CVE-2023-1611: Kernel: race between quota disable and quota assign
ioctls in fs/btrfs/ioctl.c

stable 5.4 was fixed.

Fixed status
mainline: [2f1a6be12ab6c8470d5776e68644726c94257c54]
stable/5.10: [5f6347034341bf45056ca1ec3fa72040152ecf83]
stable/5.15: [c976f9233ef926e090db5614a837824a0bcab3fb]
stable/5.4: [0e0f324c259d87639bda61a0bdea9c32c4aecdc6]
stable/6.1: [a38ff2024805a30d9b96f52557c6ea0bbc31252a]
stable/6.2: [4caab245b0469ce9258ba099a41e909f5d307b33]

CVE-2023-20588: 'x86/CPU/AMD: Do not leak quotient data after a division by 0

stable 5.10, 5.15, 6.1, and 6.4 were fixed.

Fixed status
mainline: [77245f1c3c6495521f6a3af082696ee2f8ce3921]
stable/5.10: [b6fc2fbf89089ecfb8eb9a89a7fc91d444f4fec7]
stable/5.15: [a74878207b02060c5feaf88b5566208ed08eb78d]
stable/6.1: [f2615bb47be4f53be92c81a6a8aa286c92ef04d9]
stable/6.4: [c9c0b889e2d33d49b06bb716b95a192ed3449173]

CVE-2023-3006: arm64: Add AMPERE1 to the Spectre-BHB affected list

stable 5.4 was fixed.

Fixed status
mainline: [0e5d5ae837c8ce04d2ddb874ec5f920118bd9d31]
stable/5.10: [52a43b82006dc88f996bd06da5a3fcfef85220c8]
stable/5.15: [52c2329147cf5d956dcaa3a91c886c550e7bdd39]
stable/5.4: [f41cab7a4653a5b39e49f1385fca53c0b8f93324]

CVE-2023-3212: gfs2: Don''t deref jdesc in evict

stable 4.14 and 4.19 were fixed.

Fixed status
mainline: [504a10d9e46bc37b23d0a1ae2f28973c8516e636]
stable/4.14: [6fb4b344382879bd4f8cc8394f6fff77c1388b15]
stable/4.19: [d3af9cea9a1ce56f427e41e5ffcdafe9280f099f]
stable/5.10: [d03d31d3a206093b9b8759dddf0ba9bd843606ba]
stable/5.15: [fd8b4e28f400a067e6ef84569816967be1f0642b]
stable/5.4: [23f98fe887ce3e7c8bd111f37e62735c5018c534]
stable/6.1: [5ae4a618a1558d2b536fdd5d42e53d3e2d73870c]
stable/6.3: [14c454764a37b194dc916c07488ce7339c82bc4f]

CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write

stable 4.14 and 4.19 were fixed.

Fixed status
mainline: [caf3ef7468f7534771b5c44cd8dbd6f7f87c2cbd]
stable/4.14: [185a79c8be264720b0b89ce2cc42ca2582dbce6f]
stable/4.19: [025fd7efe2639773540a5e425b7bc0dc10b6b023]
stable/5.10: [ea213922249c7e448d217a0a0441c6f86a8155fd]
stable/5.15: [870dcc31c0cf47cb15a568ade4168dc644b3ccfb]
stable/5.4: [b7d636c924eb275651bfb036eb8eca49c3f7bc24]
stable/6.1: [40f83dd66a823400d8592e3b71e190e3ad978eb5]
stable/6.4: [b79c09c2bf2d7643902a6ef26152de602c5c5e4b]

CVE-2023-3609: net/sched: cls_u32: Fix reference counter leak leading
to overflow

stable 4.14 and 4.19 were fixed.

Fixed status
mainline: [04c55383fa5689357bcdd2c8036725a55ed632bc]
stable/4.14: [a7f178f8439e939efdd12d190783eb0fabf5990d]
stable/4.19: [8ffaf24a377519e4396f03da5ccda082edae1ac9]
stable/5.10: [af6eaa57986e82d7efd81984ee607927c6de61e4]
stable/5.15: [0e1098d72fa462944c68262e1b5cca045dcb555e]
stable/5.4: [46305daf8064598a4008af1728651296815a74ed]
stable/6.1: [07f9cc229b44cbcee6385802d390091d915f38c3]

CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_enqueue

stable 4.14, 4.19, and 5.4 were fixed.

Fixed status
mainline: [3e337087c3b5805fe0b8a46ba622a962880b5d64]
stable/4.14: [c3f21ea515cb4ad7db86ddb511cead2f09e1c1e6]
stable/4.19: [ee3bc829f9b4df96d208d58b654e400fa1f3b46c]
stable/5.10: [8359ee85fd6dabc5c134ed69fb22faadd8a44071]
stable/5.15: [91d3554ab1fc2804c36a815c0f79502d727a41e6]
stable/5.4: [cf8ecd6ea68099a38e94e9b82cf58f6fd4cdf3c9]
stable/6.1: [70feebdbfad85772ab3ef152812729cab5c6c426]
stable/6.4: [bd2333fa86dc520823e8c317980b29ba91ee6b87]

CVE-2023-3776: net/sched: cls_fw: Fix improper refcount update leads
to use-after-free

stable 4.14 and 4.19 were fixed.

Fixed status
mainline: [0323bce598eea038714f941ce2b22541c46d488f]
stable/4.14: [fa020e39526994c7248f241f75d615b0df5d7671]
stable/4.19: [612f468cfc3df83777ae21058419b1fc8e9037eb]
stable/5.10: [80e0e8d5f54397c5048fa2274144134dd9dc91b5]
stable/5.15: [5b55f2d6ef403fcda93ae4eb4d8c1ba164c66e92]
stable/5.4: [808211a8d427404331e39e3b8c94ab5242eef8f5]
stable/6.1: [c91fb29bb07ee4dd40aabd1e41f19c0f92ac3199]
stable/6.4: [0a2e3f49febda459252f58cec2d659623d582800]

CVE-2023-3995: netfilter: nf_tables: disallow rule addition to bound
chain via NFTA_RULE_CHAIN_ID

stable 5.10 was fixed.

Fixed status
mainline: [0ebc1064e4874d5987722a2ddbc18f94aa53b211]
stable/5.10: [308a43f1521d5b7220693d0865b23e8dad3ed137]
stable/5.15: [5bee91121ccea8d69cea51632e9a1dd348ee49a1]
stable/6.1: [268cb07ef3ee17b5454a7c4b23376802c5b00c79]
stable/6.4: [14448359681062bf51d9c67e0264869548b79853]

CVE-2023-4015: netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR

stable 5.10 was fixed.

Fixed status
mainline: [0a771f7b266b02d262900c75f1e175c7fe76fec2]
stable/5.10: [ab5a97a94b57324df76d659686ac2d30494170e6]
stable/5.15: [98bcfcaecc76c4be288278c213b47d36292f40fa]
stable/6.1: [4237462a073e24f71c700f3e5929f07b6ee1bcaa]
stable/6.4: [027d00132487bcf2a4ee7493bb8de9d6331d48e3]

CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the
net/sched classifiers: cls_fw, cls_u32 and cls_route

stable 4.19, 5.10, 5.15, 5.4, 6.1, and 6.4 were fixed.

Fixed status
mainline: [3044b16e7c6fe5d24b1cdbcf1bd0a9d92d1ebd81,
76e42ae831991c828cffa8c37736ebfb831ad5ec,
  b80b829e9e2c1b3f7aae34855e04d8f6ecaf13c8]
stable/4.19: [4aae24015ecd70d824a953e2dc5b0ca2c4769243,
ad8f36f96696a7f1d191da66637c415959bab6d8]
stable/5.10: [b4256c99a7116c9514224847e8aaee2ecf110a0a,
a8d478200b104ff356f51e1f63499fe46ba8c9b8,
  aaa71c4e8ad98828ed50dde3eec8e0d545a117f7]
stable/5.15: [262430dfc618509246e07acd26211cb4cca79ecc,
9edf7955025a602ab6bcc94d923c436e160a10e3,
  79c3d81c9ad140957b081c91908d7e2964dc603f]
stable/5.4: [be785808db32b595728c4042d002c83d0dd4b66f,
83e3d4b0ae373dcba30c68bf28f8d179191a297a,
  1c8262f31fd2d23d1cfd2539715d976c2a99e582]
stable/6.1: [aab2d095ce4dd8d01ca484c0cc641fb497bf74db,
7f691439b29be0aae68f83ad5eecfddc11007724,
  d4d3b53a4c66004e8e864fea744b3a2b86a73b62]
stable/6.4: [4b717802428fa02cbcbb61209f638f65f9cd4710,
7d848d718aeb3b482e177b682dd04e76dd413afb,
  a836184b670f59e24d3a0f7c07115ec6e6ce6900]

CVE-2023-4132: smsusb: use-after-free caused by do_submit_urb()

stable 4.14 was fixed. Added one more fixed commit to 4.19.

Fixed status
mainline: [ebad8e731c1c06adf04621d6fd327b860c0861b5,
6f489a966fbeb0da63d45c2c66a8957eab604bf6]
stable/4.14: [c379272ea9c2ee36f0a1327b0fb8889c975093f7,
45224862e49e1fde86cbd26c7612f029b4e2e662]
stable/4.19: [1477b00ff582970df110fc9e15a5e2021acb9222,
54073c46cbbd2c0c03d6f7d481540cb95cf181a1]
stable/5.10: [42f8ba8355682f6c4125b75503cac0cef4ac91d3,
d87ef4e857b790f1616809eccda6b4d0c9c3da11]
stable/5.15: [114f768e7314ca9e1fdbebe11267c4403e89e7f2,
784a8027b8ac5a876d71cb3d3d4d97b2b6cb5920]
stable/5.4: [a41bb59eff7a58a6772f84a5b70ad7ec26dad074,
d485150c9a52167a6175f542397a098b4cd89dc9]
stable/6.1: [479796534a450fd44189080d51bebefa3b42c6fc,
8abb53c5167cfb5bb275512a3da4ec2468478626]
stable/6.4: [ebad8e731c1c06adf04621d6fd327b860c0861b5,
ae65238d3f5a2df48341a7112820e04fb1017422]

CVE-2023-4147: netfilter: nf_tables: disallow rule addition to bound
chain via NFTA_RULE_CHAIN_ID

stable 5.10 was fixed.

Fixed status
mainline: [0ebc1064e4874d5987722a2ddbc18f94aa53b211]
stable/5.10: [308a43f1521d5b7220693d0865b23e8dad3ed137]
stable/5.15: [5bee91121ccea8d69cea51632e9a1dd348ee49a1]
stable/6.1: [268cb07ef3ee17b5454a7c4b23376802c5b00c79]
stable/6.4: [14448359681062bf51d9c67e0264869548b79853]

CVE-2023-4194: tap: tap_open(): correctly initialize socket uid next
fix of i_uid to current_fsuid

stable 5.10, 5.15, 5.4, 6.1, and 6.4 were fixed.

Fixed status
mainline: [9bc3047374d5bec163e83e743709e23753376f0c,
5c9241f3ceab3257abe2923a59950db0dc8bb737]
stable/5.10: [5ea23f1cb67e4468db7ff651627892c9217fec24,
33a339e717be2c88b7ad11375165168d5b40e38e]
stable/5.15: [4ed3eed99ee6137cf6682621657f0e7699957f56,
32ca6a55e10ed9736672565d64771f6ea74e4341]
stable/5.4: [1d53ea776760097186258ced06d468bf26adb437,
1202deb153d68d569439a4d1772eba20daa95589]
stable/6.1: [b6846d7c408b33e4701f4f5ca28932e2a08e0a2e,
767800fc402deac438c5aed9c82f0e71a70c86fd]
stable/6.4: [36161e7d40e7293d7f213e16d881042d15c8a53a,
ea6cce8d689930ba480f7b02af8d9fc686534ab0]

CVE-2023-4273: exfat: check if filename entries exceeds max filename length

stable 5.10, 6.1, and 6.4 were fixed.

Fixed status
mainline: [d42334578eba1390859012ebb91e1e556d51db49]
stable/5.10: [381f7df0f3c3bd7dceb3e2b2b64c2f6247e2ac19]
stable/6.1: [c2fdf827f8fc6a571e1b7cc38a61041f0321adf5]
stable/6.4: [e1a73ba43cf883cb37f6331aca5a4c5be6350982]

CVE-2023-33250: a use-after-free bug was found in iopt_unmap_iova_range

The mainline and stable/6.4 were fixed.
It introduced by commit 51fe614 ("iommufd: Data structure to provide
IOVA to PFN mapping") in 6.2-rc1.
Before Linux 6.2  are not affected.

Fixed status
mainline: [dbe245cdf5189e88d680379ed13901356628b650,
804ca14d04df09bf7924bacc5ad22a4bed80c94f]
stable/6.4: [dbe65261fe1367dc307a89466a1a75c0d80b8233,
19d93648142a4cfe5bf36278f3beee582605cd01]

CVE-2023-4155: KVM: SEV: only access GHCB fields once

stable 6.1 and 6.4 were fixed.

Fixed status
mainline: [7588dbcebcbf0193ab5b76987396d0254270b04a]
stable/6.1: [5bdf1c1f346c81996b6e36b5efd5c92aeda4fbe4]
stable/6.4: [ab8e9a874574ce511eca21caa5d7ef5426963a54]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
      :masami.ichikawa@miraclelinux.com

