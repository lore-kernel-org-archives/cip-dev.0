Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10AAEB64DA
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 00:35:46 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.web11.10983.1688603739055845940
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 17:35:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=naimn2I6;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5634db21a78so79196eaf.0
        for <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 17:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1688603738; x=1691195738;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MZIZpa08ZHvJV0KSYbDah0aPU8K5Rl/fbzSj6SdOjso=;
        b=naimn2I6u5vQm3hF3vFCzuU3dv2qmgc7+14DH7cAXf+IBfilMe7t47SqpzoFc9P3T/
         DBNZv6O74HGhV+/DnSHrcRPHHFg1Sc5bSZVLx/9txPh6ndaYiD5FDI7A5eEbSiHZrVUe
         cQSHROIZDaOsh5L8UkPiAABstEg40Y9Xt3syV5Ojm8sCAN2NCm5LWGIWBHf1WCDPQz2+
         xEoVXWwsf1ljBVuQSnHVdp8Fgsa/07+ANhHWCBxjkd7dDpNFUjrgR5YT08hAPo0bUvHC
         VppPwPeR9Dvb0eByhhBZnxH2PUZDXZoMd8fs3mB8IEOc/wLm7+XkA03a7thkTCFqwRIH
         Ad4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688603738; x=1691195738;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZIZpa08ZHvJV0KSYbDah0aPU8K5Rl/fbzSj6SdOjso=;
        b=dZ5xqVW3v3r/wEHJMinZQ85GuyCBYxW+T0LIPtz2sEmZzYc2XgackeicDwAL2gWQ4N
         tlllhg/6H6Dikbfp4si0pwBdNllSd1AWVgjrraWwzJKBw0YcoTYgsnD/+MVFYtv5qBjH
         rveZdRlxWQRvclCxKU1zn3HGUMyhkBHfw3ugFmilMBtyaZ2mMpLSR1AEC+FMfnxNDWaB
         spLcIfCrVNDrN8EAyBtiN2hZCGYXc1oIQunPDelx24APwE74EX3+vPDhNfrXj184Z0c7
         9bmMggoA17LfsygEmc9AoWGWBJl2s3pAzcttzQQxDQCnwuopcrjqAJc9QQQvzMmScA6s
         tUgg==
X-Gm-Message-State: ABy/qLbOHvo9egATgyDHXFK19YJBb4ljrrnGGrLx78JKrTEOoiyKBQBL
	+u2mmiPOY+j+1rcVwhcqGtSqW1CPhwFaW+X0zM8+A3BkoMLXeAVxT0w=
X-Google-Smtp-Source: APBJJlErMl3dy9JzO24+dIA8TzFkxsybxzGO6pgDBz1eUuTtb63aKsJDPEP1ORqKZquo283oJaMPCkCot1w0oSy9nbU=
X-Received: by 2002:a4a:41d0:0:b0:565:8b3c:32ee with SMTP id
 x199-20020a4a41d0000000b005658b3c32eemr430536ooa.1.1688603737557; Wed, 05 Jul
 2023 17:35:37 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Jul 2023 09:35:00 +0900
Message-ID: <CAODzB9ow5eZ7z9rfioi83xBh4e3r0DqeivR6wi1=o251Y59EmQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 00:35:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12241

Hi !

It's this week's CVE report.

This week reported 14 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2023-1295: A TOCTOU bug was found in io_uring subsystem.

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 (HIGH).

A time-of-check to time-of-use issue exists in io_uring subsystem's
IORING_OP_CLOSE operation in the Linux kernel's versions 5.6 - 5.11
(inclusive), which allows a local user to elevate their privileges to
root. Introduced in b5dba59e0cf7e2cc4d3b3b1ac5fe81ddf21959eb, patched
in 9eac1904d3364254d622bf2c771c4f85cd435fc2, backported to stable in
788d0824269bef539fe31a785b1517882eafed93.

It was Introduced by commit b5dba59 (io_uring: add support for
IORING_OP_CLOSE) in 5.6-rc1. So before 5.6 kernels are not affected.

Fixed status
mainline: [9eac1904d3364254d622bf2c771c4f85cd435fc2]

CVE-2023-2163: bpf: Fix incorrect verifier pruning due to missing
register precision taints

CVSS v3 score is not provided.

An OOB read/write access was found in the eBPF subsystem.
This bug was introduced by commit b5dc0163d8fd ("bpf: precise
scalar_value tracking") in 5.3-rc1.

Fixed status
mainline: [71b547f561247897a0a14f3082730156c0533fed]
stable/5.10: [b1281d008845ae9a4de9ef7510dcc1667557a67a]
stable/5.15: [e722ea6dae2cc042d1bb7090e2ef8456dd5a0e57]
stable/5.4: [0f0a291cc5208dcc6436974246e8c18106e3c3d2]
stable/6.1: [89603f4c9154e818b9ead1abe08545a053c66ded]

CVE-2023-2860: ipv6: sr: fix out-of-bounds read when setting HMAC data.

CVSS v3 score is not provided.

An oob read bug was found in IPv6 subsystem.
This bug was introduced by commit 4f4853d ("ipv6: sr: implement API to
control SR HMAC structure") in 4.10-rc1.

Fixed status
mainline: [84a53580c5d2138c7361c7c3eea5b31827e63b35]
stable/4.14: [dc9dbd65c803af1607484fed5da50d41dc8dd864]
stable/4.19: [f684c16971ed5e77dfa25a9ad25b5297e1f58eab]
stable/5.10: [076f2479fc5a15c4a970ca3b5e57d42ba09a31fa]
stable/5.15: [55195563ec29f80f984237b743de0e2b6ba4d093]
stable/5.4: [3df71e11a4773d775c3633c44319f7acdb89011c]

CVE-2023-33951: Linux Kernel vmwgfx Driver Race Condition Information
Disclosure Vulnerability

CVSS v3 score is not provided.

This vulnerability allows local attackers to disclose sensitive
information on affected installations of Linux Kernel. An attacker
must first obtain the ability to execute high-privileged code on the
target system in order to exploit this vulnerability.
The specific flaw exists within the handling of GEM objects. The issue
results from the lack of proper locking when performing operations on
an object. An attacker can leverage this vulnerability to disclose
information in the context of the kernel.

It was introduced by commit 8afa13a ("drm/vmwgfx: Implement
DRIVER_GEM") in 5.17-rc1.

Fixed status
mainline: [9ef8d83e8e25d5f1811b3a38eb1484f85f64296c]
stable/6.1: [0a127ac972404600c99eb141c8d5b5348e53ee4f]

CVE-2023-33952: Linux Kernel vmwgfx Driver Double Free Local Privilege
Escalation Vulnerability

CVSS v3 score is not provided.

This vulnerability allows local attackers to escalate privileges on
affected installations of Linux Kernel. An attacker must first obtain
the ability to execute high-privileged code on the target system in
order to exploit this vulnerability.
The specific flaw exists within the handling of vmw_buffer_object
objects. The issue results from the lack of validating the existence
of an object prior to performing further free operations on the
object. An attacker can leverage this vulnerability to escalate
privileges and execute code in the context of the kernel.

It was introduced by commit 8afa13a ("drm/vmwgfx: Implement
DRIVER_GEM") in 5.17-rc1.

Fixed status
mainline: [9ef8d83e8e25d5f1811b3a38eb1484f85f64296c]
stable/6.1: [0a127ac972404600c99eb141c8d5b5348e53ee4f]

CVE-2023-3439: A use-after-free bug was found in the MCTP subsystem

CVSS v3 score is not provided.

A flaw was found in the MCTP protocol in the Linux kernel. The
function mctp_unregister() reclaims the device's relevant resource
when a netcard detaches. However, a running routine may be unaware of
this and cause the use-after-free of the mdev->addrs object,
potentially leading to a denial of service.

It was introduced by commit 583be98 (mctp: Add device handling and
netlink interface) in 5.15-rc1.

Fixed status
mainline: [b561275d633bcd8e0e8055ab86f1a13df75a0269]

CVE-2023-3117: A use-after-free flaw was found in the Netfilter subsystem

CVSS v3 score is not provided.

It is duplicate of CVE-2023-3390.

CVE-2023-31248: nf_tables UAF when using nft_chain_lookup_byid

CVSS v3 score is not provided (NIST).
CVSS v3 score is not 7.8 HIGH (CNA).

Linux Kernel nftables Use-After-Free Local Privilege Escalation
Vulnerability; `nft_chain_lookup_byid()` failed to check whether a
chain was active and CAP_NET_ADMIN is in any user or network namespace

It was introduced by commit 837830a4b439 ("netfilter: nf_tables: add
NFTA_RULE_CHAIN_ID attribute") in 5.9-rc1.
That is not backported to stable kernels. So, 4.4, 4.14, 4.19, 5.4 are
not affected.

Fixed status
Patch is reviewing on the netfilter-devel mailing list.

CVE-2023-32247: Linux Kernel ksmbd Session Setup Memory Exhaustion
Denial-of-Service Vulnerability

CVSS v3 score is not provided.

This vulnerability allows remote attackers to create a
denial-of-service condition on affected installations of Linux Kernel.
Authentication is not required to exploit this vulnerability, but only
systems with ksmbd enabled are vulnerable.

The specific flaw exists within the handling of SMB2_SESSION_SETUP
commands. The issue results from the lack of control of resource
consumption. An attacker can leverage this vulnerability to create a
denial-of-service condition on the system.

The ksmbd subsystem was introduced in 5.15 so before this versions are
not affected.

Fixed status
mainline: [ea174a91893956450510945a0c5d1a10b5323656]
stable/6.1: [1fc8a2b14ef5223f8e0b95faba2ee0a6e4d0f99d]
stable/6.3: [6775ee7ef4b37c521aa4cf3730f54554c4875542]

CVE-2023-32252: Linux Kernel ksmbd Session NULL Pointer Dereference
Denial-of-Service Vulnerability

CVSS v3 score is not provided.

This vulnerability allows remote attackers to create a
denial-of-service condition on affected installations of Linux Kernel.
Authentication is not required to exploit this vulnerability, but only
systems with ksmbd enabled are vulnerable.

The specific flaw exists within the handling of SMB2_LOGOFF commands.
The issue results from the lack of proper validation of a pointer
prior to accessing it. An attacker can leverage this vulnerability to
create a denial-of-service condition on the system.

The ksmbd subsystem was introduced in 5.15 so before this versions are
not affected.

Fixed status
mainline: [f5c779b7ddbda30866cf2a27c63e34158f858c73]
stable/6.1: [f623f627ad2b1dc215ab3b0df53fb05cfd3a1c3b]
stable/6.3: [02f41d88f15d6b7d523e52cc3f87488f57e9265b]

CVE-2023-32257: Linux Kernel ksmbd Session Race Condition Remote Code
Execution Vulnerability

CVSS v3 score is not provided.

This vulnerability allows remote attackers to execute arbitrary code
on affected installations of Linux Kernel. Authentication is not
required to exploit this vulnerability, but only systems with ksmbd
enabled are vulnerable.

The specific flaw exists within the processing of SMB2_SESSION_SETUP
and SMB2_LOGOFF commands. The issue results from the lack of proper
locking when performing operations on an object. An attacker can
leverage this vulnerability to execute code in the context of the
kernel.

The ksmbd subsystem was introduced in 5.15 so before this versions are
not affected.

Fixed status
mainline: [f5c779b7ddbda30866cf2a27c63e34158f858c73]
stable/6.1: [f623f627ad2b1dc215ab3b0df53fb05cfd3a1c3b]
stable/6.3: [02f41d88f15d6b7d523e52cc3f87488f57e9265b]

CVE-2023-32258: Linux Kernel ksmbd Session Race Condition Remote Code
Execution Vulnerability

CVSS v3 score is not provided.

This vulnerability allows remote attackers to execute arbitrary code
on affected installations of Linux Kernel. Authentication is not
required to exploit this vulnerability, but only systems with ksmbd
enabled are vulnerable.

The specific flaw exists within the processing of SMB2_LOGOFF and
SMB2_CLOSE commands. The issue results from the lack of proper locking
when performing operations on an object. An attacker can leverage this
vulnerability to execute code in the context of the kernel.

The ksmbd subsystem was introduced in 5.15 so before this versions are
not affected.

Fixed status
mainline: [abcc506a9a71976a8b4c9bf3ee6efd13229c1e19]
stable/6.1: [4aba9ab6a007e41182454f84f95c0bddf7d6d7e1]
stable/6.3: [920d5dd2d041484bf001c9713c2e3bcc6de79726]

CVE-2023-3269: StackRot: Linux kernel privilege escalation vulnerability

CVSS v3 score is not provided.

Since Linux 6.1 the VMA tree structure was changed fron red-black tree
to maple tree(https://lwn.net/Articles/845507/). This vulnerability
which called StackRot allows a user to gain their privilege by
use-after-free-by-RCU(UAFBR) bug.

You can read more detail on the github (https://github.com/lrh2000/StackRot).

The maple tree was introduced in 6.1-rc1 and it is not backported to
stable kernels. Therefore, 4.x and 5.x kernels aren't affected.

Fixed status
mainline: [c2508ec5a58db67093f4fb8bf89a9a7c53a109e9,
eda0047296a16d65a7f2bc60a408f70d178b2014,
  ae870a68b5d13d67cf4f18d47bb01ee3fee40acb,
e6fe228c4ffafdfc970cf6d46883a1f481baf7ea,
  4bce37a68ff884e821a02a731897a8119e0c37b7,
7267ef7b0b77f4ed23b7b3c87d8eca7bd9c2d007,
  8b35ca3e45e35a26a21427f35d4093606e93ad0a,
a050ba1e7422f2cc60ff8bfde3f96d34d00cb585,
  2cd76c50d0b41cec5c87abfcdf25b236a2793fb6,
f440fa1ac955e2898893f9301568435eb5cdfc4b,
  f313c51d26aa87e69633c9b46efb37a930faca71,
8d7071af890768438c14db6172cc8f9f4d04e184,
  a425ac5365f6cb3cc47bf83e6bff0213c10445f7]
stable/6.1: [d6a5c7a1a6e52d4c46fe181237ca96cd46a42386,
755aa1bc6aaf9961aa4bdb54f32faaba06c08792,
  b92cd80e5f0b14760a49ff68da23959a38452cda,
82972ea17b47e2f9b08a91d62e92731367475f11,
  7227d70acc7813c77e797be00503177ce484228a,
ac764deea709b4d13fa78265cb2ec463da05a5d6,
  1f4197f050dec016783663682b9eccbb603befa7,
21ee33d51bf9f9489c7e0eb8cb17c803e2d03bd0,
  48c232819e77dcd7ff476e964bc671e0589daae6,
6a6b5616c3d04eba12dd0abc0522e5bae5f1ee5a,
  c4b31d1b694e101cae7469a20762647185e11721,
e6bbad75712a97b9b16433563c1358652a33003e]
stable/6.3: [bce721f87edd54379120ffb85111357923f4f326,
88b1d56e3c81d88584d28592b7afe72099739e3d,
  4f6263b1fb29302453b9806b435ddd588ee5fb71,
337a7cb4a6c3c3c8a029b758f8b99435ac2c99a1,
  4af485289adc3576bf0835e2f63604b268d63942,
6fafcfb83bab112ac06ca793adf2a00fcdb10f0f,
  97308720616ed56291b1d3d45a81617fe91e8794,
7e697935bab3c6d7a6e8b8f0b6c2894509ea9bf8,
  723b929cbc2a032f581e0b603ad040470ed883f8,
0f1e856aba03d19490b9e5649f70438b9c98d27c,
  011b261f0872e47d27c84172ad86a536d1cc5233,
5f50096f0a7e2eb4f0ab3eff781e594308e89f80,
  704a0c495572c6a8607fd2dd9f3518630906ef4b]
stable/6.4: [b11fa3d22ac0fbc0bfaa740b3b3669d43ec48503,
d939d8c154f1dcc8ff6818e564a518b382a32ef5,
  7a1383601b7ced8976854706f22630f4bc3473bf,
b6f36565369c66459dbdde7199e8fa89cbb5f54b,
  929eb6b2a6901d5c7ef13a6aab0a07c31a603a05,
7e99b9821acc954f407da09b31a4a95d35dd147d,
  4e3fb74f605054555693031083248903dc2796d6,
203cfe05efc84b6d888fdc37862c53c6ee64a006,
  accf6d0c5832e3a880e6798fc4cc76d49573e7f4,
b2d6752dbfe74d9eed81fe5cb608232e87c823f4,
  af099fa739b8408ea3b3c854a3098a6fd94855cb,
fb32951c89030c5f9944ca8aa10301d7eb733b49,
  f450d0307644f0efd91ed99f613069302ff52e52]

CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write

CVSS v3 score is not provided (NIST).
CVSS v3 score is not 7.8 HIGH (CNA).

Linux Kernel nftables Out-Of-Bounds Read/Write Vulnerability;
nft_byteorder poorly handled vm register contents when CAP_NET_ADMIN
is in any user or network namespace

Introduced by commit 96518518cc41 ("netfilter: add nftables") in 3.13-rc1.

Fixed status
Patch is reviewing on the netfilter-devel mailing list.

* Updated CVEs

CVE-2023-1295: A TOCTOU bug was found in io_uring subsystem

The stable/5.10 was fixed.

Fixed status
mainline: [9eac1904d3364254d622bf2c771c4f85cd435fc2]
stable/5.10: [788d0824269bef539fe31a785b1517882eafed93]

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

