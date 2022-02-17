Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BDC433EF
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 00:10:01 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web12.1377.1645056600200660592
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 16:10:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ALByQBfC;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.47,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f47.google.com with SMTP id
 g6-20020a9d6486000000b005acf9a0b644so2562499otl.12
        for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 16:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XAd0e3gkqTh6iRqSxXvaDFxDaQosLEudBBttPJez5Q0=;
        b=ALByQBfCQ+hbbZsvHDOUQRy9Ok0oE7eCEmbR9S0IbU1oCw6GgJ+EKwJlvbbCZw56zC
         vAWvLzjZxtRc4xhnVt7P8TFfQBAfZD0SnxBWnWwS5Tot/Dq66f76a09cZJ7C8vEundjP
         /4AKaAa/QmR2m/jvRugwQA81fuVqGo6vjrkbqaA6BKgJf9CgM+IOJyp3fmUj7NaoNbsj
         I+kN0ZiVf0nGhcj4AN0UkXuha1Cq1KHU/bbp8ZWgyVDNJjXLfo19SSvROEsTZzyNPMnk
         Qc3FjjJWtvtEKgKIHUvUDsv/bz4YW0W6PQ6ZYSrBNsUJw58Ji4b+L9aq4xSy9i3ZSKhx
         61tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XAd0e3gkqTh6iRqSxXvaDFxDaQosLEudBBttPJez5Q0=;
        b=ELE2M5AEpEs/ZLm22sm0UGaN3dWQhjuo4fZ6Vwj1B4vyIfDlejCWRtxocJOgMyR4gv
         pmDUT3zg7Oved6m4WtSv0mcz85SM2IiaubeaG0LjlXGepEmIaCPXBcKMqHOWfXeh3Lgf
         lx/z0dYpyhCLU2tW9p+2Sx2UiDb8h+/ekYyRdundH4aCUHxgwDq+V5VzSvTOoJP3REsK
         xIyWb/+12HRHXIF6Gt0q8jetcTBsA2vKEEMdc7m3Ap3U5kAI4Dp9vTx2RnUSLmoI+oFE
         RWk5ayI6zcZM010ENxiYOlrIN/A2YCULmucb0W9mPccNyGVYdshWfjk2zKkRySg/5JTV
         U5bw==
X-Gm-Message-State: AOAM530/kkEPgJ4WafS7jYKTa25lHSp+WYSn1fEoQWfCaCjjVWV/gMKp
	TkPjD0Aq6B52RDFPLOe+vAcLyG23FtKEH8aflaouXTQ+uAQqpw==
X-Google-Smtp-Source: 
 ABdhPJwylYzhNmy52d+dq428erFBBB6tO5l5zWrTMqCemMDJiXfk3z8VuvbnxJLa/UJ+cNd3/IryagltcjYvyPASSqI=
X-Received: by 2002:a9d:ec2:0:b0:592:badf:cd7c with SMTP id
 60-20020a9d0ec2000000b00592badfcd7cmr132543otj.67.1645056599023; Wed, 16 Feb
 2022 16:09:59 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Feb 2022 09:09:23 +0900
Message-ID: 
 <CAODzB9q+vbdYe_OOuyo2+DOQQsm3x-9M7zxpEd=-R9aV9JKqZQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Feb 2022 00:10:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7627

Hi !

It's this week's CVE report.

This week reported 9 new CVEs.

* New CVEs

CVE-2021-44879: f2fs: fix to do sanity check on inode type during
garbage collection

CVSS v3 score is not provided

In gc_data_segment in fs/f2fs/gc.c in the Linux kernel before 5.16.3,
special files are not considered, leading to a move_data_page NULL
pointer dereference.

The gc_data_segment() in the 4.4 kernel does a different check from
other kernels so that patch cannot be applied.

Fixed status

mainline: [9056d6489f5a41cfbb67f719d2c0ce61ead72d9f]
stable/5.15: [0ddbdc0b7f0cec3815ac05a30b2c2f6457be3050]
stable/5.16: [d667b9f61df7bdfcb59dd1406fd2392c358f0008]

CVE-2022-0435: tipc: improve size validations for received domain records

CVSS v3 score is not provided

This issue was introduced by commit 35c55c9 ("tipc: add neighbor
monitoring framework") which was merged in 4.8-rc1. It was fixed in
5.17-rc4. The 4.4 kernel isn't affected.

Fixed status

mainline: [9aa422ad326634b76309e8ff342c246800621216]
stable/4.14: [fde4ddeadd099bf9fbb9ccbee8e1b5c20d530a2d]
stable/4.19: [f1af11edd08dd8376f7a84487cbb0ea8203e3a1d]
stable/4.9: [175db196e45d6f0e6047eccd09c8ba55465eb131]
stable/5.10: [3c7e5943553594f68bbc070683db6bb6f6e9e78e]
stable/5.15: [1f1788616157b0222b0c2153828b475d95e374a7]
stable/5.16: [59ff7514f8c56f166aadca49bcecfa028e0ad50f]
stable/5.4: [d692e3406e052dbf9f6d9da0cba36cb763272529]

CVE-2022-0516: KVM: s390: Return error on SIDA memop on normal guest

CVSS v3 score is not provided

This issue is s390 architecture specific. It was introduced at commit
19e12277("KVM: S390: protvirt: Introduce instruction data area bounce
buffer") which was merged in 5.7-rc1. All kernels were already fixed.

Fixed status

mainline: [2c212e1baedcd782b2535a3f86bc491977677c0e]
stable/5.10: [b62267b8b06e9b8bb429ae8f962ee431e6535d60]
stable/5.15: [14f880ea779e11a6c162f122c1199e3578e6e3f3]
stable/5.16: [8c68c50109c22502b647f4e86ec74400c7a3f6e0]

CVE-2022-24958: drivers/usb/gadget/legacy/inode.c mishandles dev->buf relea=
se

CVSS v3 score is not provided

The drivers/usb/gadget/legacy/inode.c in the Linux kernel through
5.16.8 mishandles dev->buf release. This bug will cause an UAF.

for 4.4, commit 501e38a("usb: gadget: clear related members when goto
fail") has merge conflict, but it is easy to fix.

Fixed status

mainline: [89f3594d0de58e8a57d92d497dea9fee3d4b9cda,
501e38a5531efbd77d5c73c0ba838a889bfc1d74]

CVE-2022-24959: yam: fix a memory leak in yam_siocdevprivate()

CVSS v3 score is not provided

An issue was discovered in the Linux kernel before 5.16.5. There is a
memory leak in yam_siocdevprivate in drivers/net/hamradio/yam.c.

This bug was introduced by commit 0781168("yam: fix a missing-check
bug") that was introduced at 4.19-rc7.
Stable 4.9 and 4.4 kernels were not affected.

Fixed status

mainline: [29eb31542787e1019208a2e1047bb7c76c069536]
stable/4.14: [4bbdfb71d2898a9d6e777a948a7484903a4ad2c3]
stable/4.19: [4bd197ce18329e3725fe3af5bd27daa4256d3ac7]
stable/5.10: [729e54636b3ebefb77796702a5b1f1ed5586895e]
stable/5.15: [0690c3943ed0fa76654e600eca38cde6a13c87ac]
stable/5.16: [deb0f02d08276d87212c1f19d9d919b13dc4c033]
stable/5.4: [7afc09c8915b0735203ebcb8d766d7db37b794c0]

CVE-2021-33061: Insufficient control flow management for the Intel(R)
82599 Ethernet Controllers and Adapters may allow an authenticated
user to potentially enable denial of service via local access.

CVSS v3 score is 5.5 MEDIUM

This bug let DoS attack. It was fixed and released at 2021/10/05.

Fixed status

Fixed in Intel=C2=AE 82599 Ethernet Series Controllers and associated
Adapters Kernel-mode Driver versions to 5.13.4 or higher.

CVE-2021-33096: Improper isolation of shared resources in network on
chip for the Intel(R) 82599 Ethernet Controllers and Adapters may
allow an authenticated user to potentially enable denial of service
via local access.

CVSS v3 score is 5.5 MEDIUM

This bug let DoS attack.Intel recommended that "Consult the
Direct-Assignment Networking Fault Isolation in a Data Center
Environment Prescriptive Guidance Addressing INTEL-SA-00571
Application Note. " in their Security Advisory(INTEL-SA-00571), so
that there is no patches for CVE-2021-33096.

Fixed status

Security Advisory INTEL-SA-00571 gives recommendations.

CVE-2021-45402: The check_alu_op() allows local users to obtain
potentially sensitive address information because it mishandles mov32
instruction.

CVSS v3 score is not provided

This bug was introduced by commit 3f50f13("bpf: Verifier, do explicit
ALU32 bounds tracking") which was merged at 5.7-rc1, so that before
5.7-rc1 kernels are not affected by this issue. It was fixed in
5.16-rc6 in the mainline and backported to stable kernels.

Fixed status

mainline: [3cf2b61eb06765e27fec6799292d9fb46d0b7e60,
e572ff80f05c33cd0cb4860f864f5c9c044280b6]
stable/5.10: [e2aad0b5f2cbf71a31d00ce7bb4dee948adff5a9,
279e0bf80d95184666c9d41361b1625c045d1dcb]
stable/5.15: [f77d7a35d4913e4ab27abb36016fbfc1e882a654,
dbda060d50abbe91ca76010078742ca53264bfa6]

CVE-2022-0617: Null pointer dereference can be triggered when write to
an ICB inode

CVSS v3 score is not provided

Null pointer dereference bug was bound in the UDF file system.
The mainline, stable kernels, and cip/4.4 kernel are already fixed.

Fixed status

cip/4.4: [0f28e1a57baf48a583093e350ea2bd3e4c09b8ea,
f25e032aa6e5cb2a22879759e4b08e4cd1c84e95]
mainline: [7fc3b7c2981bbd1047916ade327beccb90994eee,
ea8569194b43f0f01f0a84c689388542c7254a1f]
stable/4.14: [a312cbdb9045a52e5c1fec4ac7b86895f508dc76,
3fdf975173dc5acbd6e25b451bcbd558ba9d839a]
stable/4.19: [a23a59717f9f01a49394488f515550f9382fbada,
3740d41e7363374182a42f1621e06d5029c837d5]
stable/4.9: [f24454e42b5a58267928b0de53b0dd9b43e4dd46,
de10d14ce3aacba73c835cb979a85ef9683c193f]
stable/5.10: [de7cc8bcca90a9d77c915ee1d922dbd670c47d84,
0a3cfd258923aee63e7f144f134d42e205421848]
stable/5.15: [cbf96c58e28b1fece9630102781a93ff32c347f7,
2ea17d25be51ed8ea9fa59a66c9152d3c5ba0c7a]
stable/5.16: [620e8243cf5389e706c1c8f66ffacb3c84308a9e,
8baf0dbef73e1d1ad41f5db77bf20234fb7a7773]
stable/5.4: [31136e5467f381cf18e2cfd467207dda7678c7a2,
86bcc670d3000095bdb70342cf4d3fb6f3fc0a1a]

* Updated CVEs

CVE-2021-3894: sctp: local DoS: unprivileged user can cause BUG()

A local unprivileged user can cause local DoS by sctp subsystem. This
issue was introduced by commit cc16f00 (" sctp: add support for
generating stream reconf ssn reset request chunk") which was merged at
4.11-rc1. It was fixed in 5.15-rc6.

Fixed status

mainline: [a2d859e3fc97e79d907761550dbc03ff1b36479c]
stable/4.19: [c57fdeff69b152185fafabd37e6bfecfce51efda]
stable/5.10: [d84a69ac410f6228873d05d35120f6bdddab7fc3]

CVE-2022-0487: Use after free in moxart_remove

UAF bug was found in moxart_remove() in drivers/mmc/host/moxart-mmc.c.
All stable kernels were fixed this week.

Apply patch bd2db32 ("moxart: fix potential use-after-free on remove
path") to 4.4 needs to a bit modify code. However, it seems no CIP
member enables CONFIG_MMC_MOXART.

Fixed status

mainline: [bd2db32e7c3e35bd4d9b8bbff689434a50893546]
stable/4.14: [e6f580d0b3349646d4ee1ce0057eb273e8fb7e2e]
stable/4.19: [9c25d5ff1856b91bd4365e813f566cb59aaa9552]
stable/4.9: [f5dc193167591e88797262ec78515a0cbe79ff5f]
stable/5.10: [be93028d306dac9f5b59ebebd9ec7abcfc69c156]
stable/5.15: [af0e6c49438b1596e4be8a267d218a0c88a42323]
stable/5.16: [7f901d53f120d1921f84f7b9b118e87e94b403c5]
stable/5.4: [3a0a7ec5574b510b067cfc734b8bdb6564b31d4e]

CVE-2022-0492: cgroup-v1: Require capabilities to set release_agent

There was a bug in cgroups v1 release_agent feature to escalate
privilege and bypass namespace isolation.
4.X series were fixed this week.

Fixed status

mainline: [24f6008564183aa120d07c03d9289519c2fe02af]
stable/4.14: [b391bb3554dd6e04b7a8ede975dbd3342526a045]
stable/4.19: [939f8b491887c27585933ea7dc5ad4123de58ff3]
stable/4.9: [7e33a0ad792f04bad920c7197bda8cc2ea08d304]
stable/5.10: [1fc3444cda9a78c65b769e3fa93455e09ff7a0d3]
stable/5.15: [4b1c32bfaa02255a5df602b41587174004996477]
stable/5.16: [9c9dbb954e618e3d9110f13cc02c5db1fb73ea5d]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

