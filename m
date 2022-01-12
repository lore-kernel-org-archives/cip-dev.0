Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7F4C433F5
	for <webhook@archiver.kernel.org>; Wed, 12 Jan 2022 23:40:06 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web08.1642.1642030804870328475
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Jan 2022 15:40:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=U0NMxuqN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.177,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f177.google.com with SMTP id y14so5467348oia.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 12 Jan 2022 15:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=r8Lc98Gqx0KhVy8GwTcyC4Wp9pdkWbrCqwjMTnDhCWo=;
        b=U0NMxuqNRStlV1P88xyygWHY9zC3s0N3zWD9i+yn3c97wiL1/YAMcAaR+qpOgjk/2O
         bhcE+EPAoWLu70uPuWlgq4DBLDGqtLHJwQFraK/+/ibQc2STDgBJaKjwJXxKgKjfjxGG
         r2wdRYALTtWtgwnCEynv0j6sc9EbHCI9UWr1hr8GWSO39lQutLdfp8DTMGBd07eLCfzq
         WLlGe3wicqO2tdYuvFAMX0qbOn3T2VZwLg3tcxPcbqPSv7o/7iNMMWToF6oSiqeDrv/e
         wyILmLzTXwput04JDzTvGdqvMoHdoJ0+niQsLBXFgEX9CFbniyz0/BMPeAOvff8eGKgi
         KpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r8Lc98Gqx0KhVy8GwTcyC4Wp9pdkWbrCqwjMTnDhCWo=;
        b=446yNNrs5UpkVLxiQ12sbRE5+vcu8hxuyMxGslb7i3WXUqPZD0SW4WLN097EZiLhq3
         wRq7RDQcz+o/tBHaIbnUC67/zZ03B2n++K+8VB5BMkHkhyI123RT+CEzHwffrnDHvq1X
         yrTXBH9Mt8at0tnuh/WwbycawpvvPeAQ6lipP2d49T3F7ZROuwN3UgSNNBMDc9lu8C5I
         AJZa4NqvlfMKtNHxdyNUVt0EbwLEX0IspyaPlVYP4pc6DufSJY7x95geH35OLHIIuxbs
         XH/a8DAcBpcZVTmDHfztjDhK7rMdawfkrfuu92h36lSjpe2NI47OpYGyhYfx+Ym/k2RL
         a3tg==
X-Gm-Message-State: AOAM530J2/rGFU3vMBlwLrhQ7bdbT2f5XvBLyILWGS0SZP+pzbmQPIRe
	/AmPFZhlOWv0K+iDcMQpYS/gmm5EMj5coAwRTwUlhRXZxUJtlQ==
X-Google-Smtp-Source: 
 ABdhPJykNTEWGCVLsSkpBfMPH1kgptcg+wNtqIyO2o1M91ylnJY6u/EzmkNESrYlmXrFQh0K4nYNsfpFnSqM258CBGU=
X-Received: by 2002:aca:4308:: with SMTP id q8mr1353910oia.66.1642030803653;
 Wed, 12 Jan 2022 15:40:03 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Jan 2022 08:39:28 +0900
Message-ID: 
 <CAODzB9ojKHaZ13TykpwVx3ot7Y45qQaZt7S0gCfag2E9Ad-Apw@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Jan 2022 23:40:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7455

Hi !

It's this week's CVE report.

This week reported 7 new CVEs.

* New CVEs

CVE-2021-39633: ip_gre: add validation for csum_start

CVSS v3 score is not provided

An information leak bug was found in gre_handle_offloads() which is in
net/ipv4/ip_gre.c.
This fix uses skb_checksum_start() to check data but this function was
introduced at 4.6-rc1 commit 08b64fc ("net: Store checksum result for
offloaded GSO checksums") so applying this patch requires commit
08b64fc too.

Fixed status

mainline: [1d011c4803c72f3907eccfc1ec63caefb852fcbf]
stable/4.14: [99279223a37b46dc7716ec4e0ed4b3e03f1cfa4c]
stable/4.19: [c33471daf2763c5aee2b7926202c74b75c365119]
stable/4.9: [41d5dfa408130433cc5f037ad89bed854bf936f7]
stable/5.10: [fb45459d9ddb1edd4a8b087bafe875707753cb10]
stable/5.4: [53b480e68c1c2c778b620cc7f45a2ba5dff518ca]

CVE-2021-39634: epoll: do not insert into poll queues until all sanity
checks are done

CVSS v3 score is not provided

A local attacker could gain his privilege by abusing this bug. All
stable kernels and the mainline kernels have already been fixed.

Fixed status

mainline: [f8d4f44df056c5b504b0d49683fb7279218fd207]
stable/4.14: [23fb662b13e4f75688123e1d16aa7116f602db32]
stable/4.19: [3e3bbc4d23eeb90bf282e98c7dfeca7702df3169]
stable/4.4: [ea984dfe0e7978cd294eb6a640ac27fa1834ac8d]
stable/4.9: [a16d314ccda2efa6173f2ae7d386f99c61d273a4]
stable/5.4: [8993da3d4d3a7ae721e9dafa140ba64c0e632a50]

CVE-2021-4155: xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP
just like fallocate

CVSS v3 score is not provided

An information leak bug was found in xfs by using XFS_IOC_ALLOCSP
operation via ioctl.
All stable kernels and the mainline kernel have been fixed.

Fixed status

mainline: [983d8e60f50806f90534cc5373d0ce867e5aaf79]
stable/4.14: [2af625c89bf4a41c8a0bc818d8cf30a291f216ca]
stable/4.19: [1c3564fca0e7b8c9e96245a2cb35e198b036ee9a]
stable/4.4: [56adcda55aa213e106224ff3d18ef4625e25f52b]
stable/4.9: [19e3d9a26f28f432ae89acec22ec47b2a72a502c]
stable/5.10: [16d8568378f9ee2d1e69216d39961aa72710209f]
stable/5.15: [b0e72ba9e520b95346e68800afff0db65e766ca8]
stable/5.4: [102af6edfd3a372db6e229177762a91f552e5f5e]

CVE-2021-4202: Race condition in nci_request() leads to use after free
while the device is getting removed

CVSS v3 score is not provided

Race condition bug in NFC device. A local attacker could do privilege
escalation via this bug. However, no CIP member enabled
CONFIG_NFC_NCI. All stable kernels and the mainline kernel have been
fixed.

Fixed status

mainline: [86cdf8e38792545161dbe3350a7eced558ba4d15,
48b71a9e66c2eab60564b1b1c85f4928ed04e406]
stable/4.14: [6e2944d8bbc58682691438b57620491b5a4b7cfb,
8937bfa226d4001875d8539ae811fce6d3df4c96]
stable/4.19: [62be2b1e7914b7340281f09412a7bbb62e6c8b67,
2350cffd71e74bf81dedc989fdec12aebe89a4a5]
stable/4.4: [6dc051117ba0e1dac9324593ff2c1c520f67ad21,
6f195c7691089c56cd1553a9ca3ca22790c0fe07]
stable/4.9: [4a59a3681158a182557c75bacd00d184f9b2a8f5,
57c076e64ab55adf556cc515914564d61979f7c2]
stable/5.10: [cb14b196d991c864ed2d1b6e79d68a7ce38e6538,
34e54703fb0fdbfc0a3cfc065d71e9a8353d3ac9]
stable/5.15: [96a209038a99a379444ea3ef9ae823e685ba60e7,
ed35e950d8e5658db5b45526be2c4e3778746909]
stable/5.4: [e418bb556ff801e11592851fd465415757a2ef68,
eff32973ecc3838d9a6dc5174bd24d76b120843c]

CVE-2021-4203: af_unix: fix races in sk_peer_pid and sk_peer_cred accesses

CVSS v3 score is not provided

A local attacker can cause a system crash or internal kernel
information leak via this issue.
All stable kernels and the mainline kernel have been fixed.

Fixed status

mainline: [35306eb23814444bd4021f8a1c3047d3cb0c8b2b]
stable/4.14: [9d76f723256d68eea16f0c563fc80b3c14258634]
stable/4.19: [0512a9aede6e4417c4fa6e0042a7ca8bc7e06b86]
stable/4.4: [323f0968a81b082cf02ef15b447cd35e4328385e]
stable/4.9: [09818f629bafbe20e24bac919019853ea3ac5ca4]
stable/5.10: [3db53827a0e9130d9e2cbe3c3b5bca601caa4c74]
stable/5.4: [0fcfaa8ed9d1dcbe377b202a1b3cdfd4e566114c]

CVE-2021-4204: eBPF Improper Input Validation Vulnerability

CVSS v3 score is not provided

A local attacker can escalate privileges via this bug.
This bug is affecting the 5.8 or later kernel. The commit 457f4436
("bpf: Implement BPF ring buffer and verifier support for it")
introduced this issue.

To mitigate this issue, set kernel.unprivileged_bpf_disabled to 1.

Fixed status

Not fixed yet.

CVE-2021-46283: netfilter: nf_tables: initialize set before expression setup

CVSS v3 score is not provided

A local attacker to cause a local DoS attack by this bug.
This issue was introduced at commit 65038428 (netfilter: nf_tables:
allow to specify stateful expression in set definition) which was
merged at 5.7-rc1. Before 5.7 kernels aren't affected by this issue.

Fixed status

mainline: [ad9f151e560b016b6ad3280b48e42fa11e1a5440]
stable/5.10: [36983fc2f87ea3b74a33bf460c9ee7329735b7b5]

* Updated CVEs

CVE-2021-45095: phonet: refcount leak in pep_sock_accep

Stable kernels are updated. So stable kernels and the mainline kernel
have been fixed.

Fixed status

mainline: [bcd0f93353326954817a4f9fa55ec57fb38acbb0]
stable/4.14: [a025db5658d5c10019ffed0d59026da8172897b6]
stable/4.19: [4dece2760af408ad91d6e43afc485d20386c2885]
stable/4.4: [172b3f506c24a61805b3910b9acfe7159d980b9b]
stable/4.9: [3bae29ecb2909c46309671090311230239f1bdd7]
stable/5.10: [4f260ea5537db35d2eeec9bca78a74713078a544]
stable/5.15: [9ca97a693aa8b86e8424f0047198ea3ab997d50f]
stable/5.4: [2a6a811a45fde5acb805ead4d1e942be3875b302]

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
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

