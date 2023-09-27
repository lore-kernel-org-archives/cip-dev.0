Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F75E80ABE
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 22:58:46 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web11.2408.1695855520343667345
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Sep 2023 15:58:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=xAty56OW;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6b9e478e122so6942978a34.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Sep 2023 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1695855519; x=1696460319; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OmZ9UbR8D5uUjaGlqU9MKvL58KjBSCKFB1MSYWPyTN0=;
        b=xAty56OWFqbKp0LvKH+3w8XLE5A2IfpeWCqOSmMwTb3WRE9vF4arkHelYf9TXOqozd
         z+oif5jMMdahZMd9tqr+J6lSv07Key3ooOM9NE20RTrq/m2Z8cPfo2zVeaeZsy061/9P
         e06h1aB4jRyyVED0MfMoXmxDTaUJcxRxx+CR7UyOmkxp1SEQUclfSWJmfAm6ZbnVCpPK
         oPkZneFZ0geRPYivhweeBIb65I5Jp3IqjuuEB0anW/V8f6Q8aN6tb9RRGBjK7C5az03c
         rg06pQJJwz/x2Lo667QhX2sPv/7JeMnoqp32eCQEaadEpuEdJ9VEAvkOqVDTN+L+70OX
         1/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695855519; x=1696460319;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmZ9UbR8D5uUjaGlqU9MKvL58KjBSCKFB1MSYWPyTN0=;
        b=nc6ZN9LiT3qJBtP4QbMOl8BXzRXckMlsMun8dUeMk4mBdKzznDflWJQrWnjQG9dgwN
         JGaGxso9zECq0OojozVbvbAK9iAXsWPv9lu2XXzFetesKvpyKW0JuBfUFsJE2u4vbHGz
         DX/uRvv7JHiHXDM5qD0Tgb3X/mZlUjXlqGPFh6ZdRL1D7A/l7xEaZNC5ZnYj5DlUCO7m
         yT9X4oOWGPvUs5X7VGqD1annmPTM6EU7Z+/TGKey+IxmPR7c26DHv5EvWXME/Ry+NQes
         kwAQoAaWl72944z5UhaT+KTiy3vb8X6YwH7ueTgMv+Tk6kCjFgChYRBOpQ/OmUHbCRdG
         sO4Q==
X-Gm-Message-State: AOJu0YxVOVk86yX7DxNpVsmF9s87qGMatOHL4P9J97dpxitNw/zfkHbs
	o5gagnvFUAA3J1RJ9ZL/7NE5GwcgCA7/zY6rNqMTeZfTxXByc1C3CBs=
X-Google-Smtp-Source: AGHT+IGrMMvLIXYjyjbLsreLKkytiHlDz+v89vwkEqRl67c+y7vMdWAVQb/Tzp/4RJY+shrA+6vqKI0hmpuFlcdoa1s=
X-Received: by 2002:a05:6870:d1c3:b0:1b0:3637:2bbe with SMTP id
 b3-20020a056870d1c300b001b036372bbemr4207378oac.54.1695855519187; Wed, 27 Sep
 2023 15:58:39 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 Sep 2023 07:58:03 +0900
Message-ID: <CAODzB9qEo8oKfeuD95RngoMbaRJ13vYxbokY6rY_boroWtX5ew@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Sep 2023 22:58:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13238

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 7 updated CVEs.

* New CVEs

CVE-2023-42753: netfilter: ipset: add the missing
IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

CVSS v3 score is 7.8 HIGH (NIST).
CVSS v3 score is 7.0 HIGH (CNA).

An array out-of-bound access bug was found in the netfilter subsystem.
If an attacker passes crafted cidr value as 0 that causes an integer
underflow. As a result, it leads to slab oob access.

This bug was introduced by commit 886503f ("netfilter: ipset: actually
allow allowable CIDR 0 in hash:net,port,net") in 4.20-rc1. This commit
was backported to 4.19 so 4.19 also affected.

Fixed status
mainline: [050d91c03b28ca479df13dfb02bcd2c60dd6a878]
stable/4.14: [7935b636dd693dfe4483cfef4a1e91366c8103fa]
stable/4.19: [e632d09dffc68b9602d6893a99bfe3001d36cefc]
stable/5.10: [83091f8ac03f118086596f17c9a52d31d6ca94b3]
stable/5.15: [a9e6142e5f8f6ac7d1bca45c1b2b13b084ea9e14]
stable/5.4: [109e830585e89a03d554bf8ad0e668630d0a6260]
stable/6.1: [7ca0706c68adadf86a36b60dca090f5e9481e808]
stable/6.5: [d95c8420efe684b964e3aa28108e9a354bcd7225]


CVE-2023-42755: wild pointer access in rsvp classifer in the Linux kernel

CVSS v3 score is not provided.

There is a slab-out-of-bound access bug found in the net/sched
subsystem which leads Dos.
This fix removes CONFIG_NET_CLS_RSVP and NET_CLS_RSVP6 because these
features haven't been getting
much maintenance attention due to lack of known users.

Fixed status
mainline: [265b4da82dbf5df04bee5a5d46b7474b1aaf326a]
stable/4.14: [a048f77ba9cf7f77a06b2ee60446c6cc061c2daf]
stable/4.19: [6ca0ea6a46e7a2d70fb1b1f6a886efe2b2365e16]
stable/5.10: [8db844077ec9912d75952c80d76da71fc2412852]
stable/5.15: [08569c92f7f339de21b7a68d43d6795fc0aa24f2]
stable/5.4: [42900fd140c8db99141b9f083bfe8de887190ed9]
stable/6.1: [b93aeb6352b0229e3c5ca5ca4ff015b015aff33c]

CVE-2023-5158: vringh: don''t use vringh_kiov_advance() in vringh_iov_xfer()

CVSS v3 score is 5.5 MEDIUM (NIST).
CVSS v3 score is 6.5 MEDIUM (CNA).

A flaw was found in vringh_kiov_advance in drivers/vhost/vringh.c in
the host side of a virtio ring in the Linux Kernel. This issue may
result in a denial of service from guest to host via zero length
descriptor.

It was introduced by commit b8c06ad4d67d ("vringh: implement
vringh_kiov_advance()") in 5.13-rc1.

Fixed status
Patch is available on the virtualization mailing
list(https://lore.kernel.org/virtualization/20230925103057.104541-1-sgarzare@redhat.com/T/#u),
but it hasn't been merged yet.

CVE-2023-5197: netfilter: nf_tables: disallow rule removal from chain binding

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux kernel's netfilter:
nf_tables component can be exploited to achieve local privilege
escalation. Addition and removal of rules from chain bindings within
the same transaction leads to use-after-free.

This bug was introduced by commit d0e2c7d ("netfilter: nf_tables: add
NFT_CHAIN_BINDING") in 5.9-rc1.
So, 5.4, 4.19, 4.14, and 4.4 are not affected.

Fixed status
mainline: [f15f29fd4779be8a418b66e9d52979bb6d6c2325]

CVE-2023-42756: netfilter: ipset: Fix race between IPSET_CMD_CREATE
and IPSET_CMD_SWAP

CVSS v3 score is not provided.

A race condition bug was found in netfilter/ip_set subsystem. It leads
local DoS.

This bug was introduced by commit 24e2278 ("netfilter: ipset: Add
schedule point in call_ad().") in 6.4-rc6.
This commit was backported to 6.x and 5.x. However the commit is not
backported to Linux 4.x series. So, Linux 4.x is not affected.

Fixed status
mainline: [7433b6d2afd512d04398c73aa984d1e285be125b]

* Updated CVEs

CVE-2022-28796: jbd2_journal_wait_updates in fs/jbd2/transaction.c in
the Linux kernel

Stable 5.15 was fixed.

Fixed status
mainline: [cc16eecae687912238ee6efbff71ad31e2bc414e]
stable/5.15: [e9270898222ae8404f6b3738f82bc964b0dc1819]
stable/5.17: [bff94c57bd130e3062afa94414c2294871314096]

CVE-2023-4128: Use-after-free vulnerabilities in the net/sched
classifiers: cls_fw, cls_u32 and cls_route

Stable 4.14 was fixed.

Fixed status
mainline: [3044b16e7c6fe5d24b1cdbcf1bd0a9d92d1ebd81,
76e42ae831991c828cffa8c37736ebfb831ad5ec,
  b80b829e9e2c1b3f7aae34855e04d8f6ecaf13c8]
stable/4.14: [f0f874147a5b00eae875c24281531f8de7900079,
530a85ea747965b7c275fa44a364916e0ec2efaa,
  226d84d54a9339b7045aff36c8f56d6ee9270476]
stable/4.19: [4aae24015ecd70d824a953e2dc5b0ca2c4769243,
ad8f36f96696a7f1d191da66637c415959bab6d8,
  4f38dc8496d1991e2c055a0068dd98fb48affcc6]
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

CVE-2023-4207: net/sched: cls_fw: No longer copy tcf_result on update
to avoid use-after-free

Stable 4.14 and 4.19 were fixed.

Fixed status
mainline: [76e42ae831991c828cffa8c37736ebfb831ad5ec]
stable/4.14: [530a85ea747965b7c275fa44a364916e0ec2efaa]
stable/4.19: [4f38dc8496d1991e2c055a0068dd98fb48affcc6]
stable/5.10: [a8d478200b104ff356f51e1f63499fe46ba8c9b8]
stable/5.15: [9edf7955025a602ab6bcc94d923c436e160a10e3]
stable/5.4: [83e3d4b0ae373dcba30c68bf28f8d179191a297a]
stable/6.1: [7f691439b29be0aae68f83ad5eecfddc11007724]
stable/6.4: [7d848d718aeb3b482e177b682dd04e76dd413afb]

CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc curve

Stable 4.19 and 5.4 were fixed.

Fixed commit
mainline: [b3d26c5702c7d6c45456326e56d2ccf3f103e60f]
stable/4.19: [7c62e0c3c6e9c9c15ead63339db6a0e158d22a66]
stable/5.10: [b08cc6c0396fd5cfaac4ca044f2282367347c062]
stable/5.15: [4cf994d3f4ff42d604fae2b461bdd5195a7dfabd]
stable/5.4: [da13749d5ff70bb033a8f35da32cfd6e88246b2f]
stable/6.1: [a1e820fc7808e42b990d224f40e9b4895503ac40]
stable/6.4: [5293f466d41d6c2eaad8b833576ea3dbee630dc2]
stable/6.5: [eb07894c51c7d6bb8d00948a3e6e7b52c791e93e]

CVE-2023-4921: net: sched: sch_qfq: Fix UAF in qfq_dequeue()

Stable 4.14, 4.19, and 5.4 were fixed.

Fixed status
mainline: [8fc134fee27f2263988ae38920bc03da416b03d8]
stable/4.14: [d9f43fc5a78d1505733d3621cd4c044eaf71a02f]
stable/4.19: [7ea1faa59c75336d86893378838ed1e6f20c0520]
stable/5.10: [746a8df5e4d235059b1adf02e8456e7ec132d2d8]
stable/5.15: [6ea277b2c6263931798234e2eed892ecfbb85596]
stable/5.4: [a6d11571b91d34fd7ce8451c2dfd112194c79ae2]
stable/6.1: [a18349dc8d916a64d7c93f05da98953e3386d8e9]
stable/6.5: [e5471b82c36396e809817cb988dfc4bce0a688cb]

CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in
btsdio_remove due to unfinished work

Added commit 3efcbf2 ("Bluetooth: btsdio: fix use after free bug in
btsdio_remove due to race condition") to stable/4.19.

Fixed status
mainline: [1e9ac114c4428fdb7ff4635b45d4f46017e8916f,
73f7b171b7c09139eb3c6a5677c200dc1be5f318]
stable/4.14: [95eacef5692545f199fae4e52abfbfa273acb351]
stable/4.19: [af4d48754d5517d33bac5e504ff1f1de0808e29e,
3efcbf25e5ab4d4ad1b7e6ba0869ff85540e3f6e]
stable/5.10: [da3d3fdfb4d523c5da30e35a8dd90e04f0fd8962,
746b363bef41cc159c051c47f9e30800bc6b520d]
stable/5.15: [8efae2112d910d8e5166dd0a836791b08721eef1]
stable/5.4: [a18fb433ceb56e0787546a9d77056dd0f215e762]
stable/6.1: [cbf8deacb7053ce3e3fed64b277c6c6989e65bba,
179c65828593aff1f444e15debd40a477cb23cf4]
stable/6.2: [c59c65a14e8f7d738429648833f3bb3f9df0513f]

CVE-2023-1194: use-after-free in parse_lease_state()

The mainline and stable 6.1 was fixed.

Fixed status
mainline: [fc6c6a3c324c1b3e93a03d0cfa3749c781f23de0]
stable/6.1: [8f2984233c87a1d08f4c45f077130590c7a2c991]

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

