Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE55C433F5
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 23:55:15 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web12.2597.1634169312719603885
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 16:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=VCFLXX3a;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id n63so6111541oif.7
        for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=QeLKxx9j3ZbsAsvFsAMernrnGfpr27wKvo4Ickv3btE=;
        b=VCFLXX3ao0hKxrqdfPeKLaANAle2ukHUGLPmQRy70z/slGvZmmF8JJ9f1OFh/UubIS
         G1ZD5y5H8XOUnKa1IgDRLeaxOqJcyZlUY/bp+6sP5zAN6JkjlbQffydXA9rPRLs6Z2M1
         3ig/7D+PtTOplC2diBdxU1oCHH1hXX576fL1rziVOU7N0PSjpbnr7SAlKWwrhc19+H97
         w8kBaOBTmZ8RPX0Gv7ExaS9kY1tDEaCTZwNeQIuePx73YuEIngFMa9HJxSZQvFMjNesc
         ZlE3jx5ouhqWESYoTRO5BmxnoJcdJs6RPBOVW/uAQDWoywiCQkR6F5kmvi7hH8E3OmY7
         7CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QeLKxx9j3ZbsAsvFsAMernrnGfpr27wKvo4Ickv3btE=;
        b=rpWraMcqAb++W/cAnIPjttfu9zyNXPrKTaIOXr1nYUtdwGBZyKqncWkOiyjUHM89k7
         aAdJdba37PU7q2vsfKE0j5fiS3xk4wEKgr2A0NxpqE7Hy58ycvRva6Ms6dSPa+JXLa5Y
         wTrExPmXx/TGBebje+oUbHlRDtG2KB0Wy5x6IckA62skX65f6pSglfXPhAU1sidhmZBH
         yPHkgw1Y5w+kSw6hyk3qN73uoN66AD9vZG942qsYrs4c+M16lhVnKDN9yHyf5RxBLMyG
         175Poom7fWNhKP5uEDJiR5qfkbY9pYp68YKmYEyHMCVVAQq+j1CxpZu6RH2s4a0OWxTe
         r5HA==
X-Gm-Message-State: AOAM532+m9aySTHciqzQAoX9P/JNj0LRPqg4Zd18N2LA/ooZ2sbpOxOR
	mXkilveB/gKN3dLLcq9tjOf/SzwXLj/icqx5y6FT9R7VgQZisQ==
X-Google-Smtp-Source: 
 ABdhPJwInD5MV8NAzRKon7cZPsQilB6V9hEl1bFelFZtGDTqTHvm/wYhw1ocZg243ndwIbckpTynQ/n/FgO1I3wFgtU=
X-Received: by 2002:a05:6808:22a3:: with SMTP id
 bo35mr1715261oib.66.1634169311637;
 Wed, 13 Oct 2021 16:55:11 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Oct 2021 08:54:35 +0900
Message-ID: 
 <CAODzB9qOyXSQ=P0x1CrPEC1=mCW3PUN4_Zx9hp0ZPpZWbM1WUw@mail.gmail.com>
Subject: New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 23:55:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6822

Hi !

It's this week's CVE report.

This week reported 4 new CVEs.

* New CVEs

CVE-2021-0935: bug is in ipv6 and l2tp code.

This CVE addresses two commits, one in the ipv6 stack and the other in l2tp.
There is two introduced commits one is 85cb73f ("net: ipv6: reset
daddr and dport in sk if connect() fails") was merged in 4.12 and the
other commit 3557baa ("[L2TP]: PPP over L2TP driver core") was merged
in 2.6.23-rc1.

Fixed commits have been merged since 4.16-rc7 so 4.16 or later kernels
don't affect this vulnerability.

Commit 2f987a76("net: ipv6: keep sk status consistent after datagram
connect failure") fixes 85cb73f and commit b954f940("l2tp: fix races
with ipv4-mapped ipv6 addresses") fixes commit 3557baa.

To apply patches to 4.4, it needs to fix conflicts.

CVSS v3 score is not provided.

Fixed status

mainline: [2f987a76a97773beafbc615b9c4d8fe79129a7f4,
b954f94023dcc61388c8384f0f14eb8e42c863c5]
stable/4.14: [a8f02befc87d6f1a882c9b14a31bcfa1fbd3d430,
b0850604cc5dac60754cc2fcdf7d2ca97a68a4dc]
stable/4.19: [2f987a76a97773beafbc615b9c4d8fe79129a7f4,
b954f94023dcc61388c8384f0f14eb8e42c863c5]
stable/4.4: not fixed yet
stable/4.9: [c49f30b2979bfc8701620e598558f29a48e07234,
535ef684ec6079bccc2037c76bc607d29dca05dc]
stable/5.10: [2f987a76a97773beafbc615b9c4d8fe79129a7f4,
b954f94023dcc61388c8384f0f14eb8e42c863c5]
stable/5.4: [2f987a76a97773beafbc615b9c4d8fe79129a7f4,
b954f94023dcc61388c8384f0f14eb8e42c863c5]

CVE-2021-0937: netfilter: x_tables: fix compat match/target pad
out-of-bound write

This vulnerability was introduced since 4.6.19-rc1 and fixed in
5.12-rc8. All stable kernels are already fixed.

CVSS v3 score is not provided.

Fixed status

mainline: [b29c457a6511435960115c0f548c4360d5f4801d]
stable/4.14: [522a0191944e3db9c30ade5fa6b6ec0d7c42f40d]
stable/4.19: [12ec80252edefff00809d473a47e5f89c7485499]
stable/4.4: [b0d98b2193a38ef93c92e5e1953d134d0f426531]
stable/4.9: [0c58c9f9c5c5326320bbe0429a0f45fc1b92024b]
stable/5.10: [1f3b9000cb44318b0de40a0f495a5a708cd9be6e]
stable/5.4: [cc59b872f2e1995b8cc819b9445c1198bfe83b2d]


CVE-2021-0938: compiler.h: fix barrier_data() on clang

This bug was introduced in 4.19-rc1 and fixed in 5.10-rc4. so all
stable kernels are fixed.
If kernel was built from clang, this bug will be affected.

CVSS v3 score is not provided.

Fixed status

mainline: [3347acc6fcd4ee71ad18a9ff9d9dac176b517329]
stable/4.14: not affect
stable/4.19: [b207caff4176e3a6ba273243da2db2e595e4aad2]
stable/4.4: not affect
stable/4.9: not affect
stable/5.10: not affect
stable/5.4: [c2c5dc84ac51da90cadcb12554c69bdd5ac7aeeb]

CVE-2021-0941: bpf: Remove MTU check in __bpf_skb_max_len

CVSS v3 score is not provided.

This bug is fixed in v5.12-rc1-dontuse. The kernel 4.4 doesn't contain
__bpf_skb_max_len() so 4.4 may not affect this vulnerability. The
__bpf_skb_max_len() was introduced since 4.13-rc1 commit
2be7e212("bpf: add bpf_skb_adjust_room helper
").

Fixed status.

mainline: [6306c1189e77a513bf02720450bb43bd4ba5d8ae]
stable/4.14: [64cf6c3156a5cbd9c29f54370b801b336d2f7894]
stable/4.19: [8c1a77ae15ce70a72f26f4bb83c50f769011220c]
stable/4.4: not affect
stable/4.9: [1636af9e8a8840f5696ad2c01130832411986af4]
stable/5.10: [fd38d4e6757b6b99f60314f67f44a286f0ab7fc0]
stable/5.4: [42c83e3bca434d9f63c58f9cbf2881e635679fee]

* Updated CVEs

CVE-2021-3744: crypto: ccp - fix resource leaks in ccp_run_aes_gcm_cmd()
CVE-2021-3764: DoS in ccp_run_aes_gcm_cmd() function

CVE-2021-3744 and CVE-2021-3764 are fixed by commit 505d9dcb("crypto:
ccp - fix resource leaks in ccp_run_aes_gcm_cmd()
"). Both vulnerabilities were in ccp_run_aes_gcm_cmd() which has been
introduced since 4.12-rc1. Therefore before 4.12 kernels aren't
affected this vulnerability.

Fixed status

mainline: [505d9dcb0f7ddf9d075e729523a33d38642ae680]
stable/4.14: [3707e37b3fcef4d5e9a81b9c2c48ba7248051c2a]
stable/4.19: [710be7c42d2f724869e5b18b21998ceddaffc4a9]
stable/4.4: not affect
stable/4.9: not affect
stable/5.10: [17ccc64e4fa5d3673528474bfeda814d95dc600a]
stable/5.14: [e450c422aa233e9f80515f2ee9164e33f158a472]
stable/5.4: [24f3d2609114f1e1f6b487b511ce5fa36f21e0ae]

CVE-2021-41864: bpf: Fix integer overflow in prealloc_elems_and_freelist()

This bug was introduced in 4.6-rc1 so that 4.4 isn't affected this bug.
4.19, 5.10, 5.14, and 5.4 have been fixed this week.
Patch to 4.14 can be applied by git am without any modification. Patch
to 4.9 can be applied by 3-way merge.

Fixed status

mainline: [30e29a9a2bc6a4888335a6ede968b75cd329657a]
stable/4.14: not fixed yet
stable/4.19: [078cdd572408176a3900a6eb5a403db0da22f8e0]
stable/4.4: not affect
stable/4.14: not fixed yet
stable/5.10: [064faa8e8a9b50f5010c5aa5740e06d477677a89]
stable/5.14: [3a1ac1e368bedae2777d9a7cfdc65df4859f7e71]
stable/5.4: [b14f28126c51533bb329379f65de5b0dd689b13a]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2021-3640: UAF in sco_send_frame function

Fixed in bluetooth-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/sco.c?id=99c23da0eed4fd20cae8243f2b51e10e66aa0951

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

