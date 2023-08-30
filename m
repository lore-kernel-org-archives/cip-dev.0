Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40205C6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 23:09:12 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web10.4687.1693436949758471250
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Aug 2023 16:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=cDhzOaWZ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-565f2567422so171572eaf.2
        for <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1693436948; x=1694041748; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KHieVsKrFwdxs8Ae89zna2cbk0RvzbnM7UQc8KoMxjQ=;
        b=cDhzOaWZNgl9B/56YxgjjH/qZsjwVyI/x8w66bSB+U/5aVnrhJzWJl8lttGZfBSCZq
         poZgJDedb8Ho16LX6SflBk+4n9xb8KqvbjhMfCUx9N4BqD0/PkaPyVjwdkmiXFk8YPVZ
         0czFUM7hEdyNyLxjQ1rz0c3+AUkiyTynM1ktJPWIYaG+p/OopopS3rNA86ppe3fTqHYJ
         xXp5nm72dBSZGfa6sNcliCxU5sQqna1wTQm5DP6YBl6knAI/grRbZt+SjPN6JU6016qu
         rgTvKhxF6irfv+E7Y8mmC551t6q3hVGpXWoiLi626zNARmz/CUTnepLoY8agk20UtE/k
         IhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436948; x=1694041748;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHieVsKrFwdxs8Ae89zna2cbk0RvzbnM7UQc8KoMxjQ=;
        b=YSdvxK+K3rXeDtJWUCClnst3jqqpdbyKak1x/A0QYLWi05iFyvxyYAwdiQWlE2LMnR
         q5dH5Z9twW6YMYJvsqel7TBA6ZmjItEV4Yt6cv9UKGzOkBMeXbXLSbzfHpP5r+ou3FWM
         cxgXx/rx8pdJRyq9ofS8RySjyfP+Q9mWrH8m5qT++xarP6EvuzjLjaxRtfOv1tZD3u2M
         U41gSXObLF8OqCbyF+TCseRs/GywBIHKj/bslqC4WCCiUNB4Kwee1G7pMAfVyVYllHXM
         Fmwvi4H+9mk1DaDuEoJJK48seiGrs8zcoIS+5vqUFqNJY1Dq/gMFGdTZQN3L00ow8YKo
         Ct8g==
X-Gm-Message-State: AOJu0YxvVY/cGfPAXPn6jufRih1StEahCJrOotXjibsF18O2xImhsc3S
	G+MvWv+fFH2mPdVrjlfZ3W16XbqGQcJIzctsU66y+IADSfKur17QIQg=
X-Google-Smtp-Source: AGHT+IFt9TH4cZyNE9UUpFnOPUghYFhSDfWN7OnzZa4+Mtzbi1LZ8/WeJm1IFUYU286Eb2FvSlcAijp0ZLPLaLG/t/Y=
X-Received: by 2002:a4a:3416:0:b0:570:c136:fa3c with SMTP id
 b22-20020a4a3416000000b00570c136fa3cmr3371157ooa.2.1693436948128; Wed, 30 Aug
 2023 16:09:08 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 31 Aug 2023 08:08:31 +0900
Message-ID: <CAODzB9o=B5Xc-9EgQGO6aqkc2g5uXb6LugD2bNukw9TM+fVBdQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 23:09:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12927

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 5 updated CVEs.

* New CVEs

CVE-2023-4563: Use-after-free in nft_verdict_dump due to a race
between set GC and transaction

CVSS v3 score is not provided.

A use-after-free bug was found in the nftable. It allows a local
attacker to crash the system or may lead to kernel information leak.

Fixed status
mainline: [24138933b97b055d486e8064b4a1721702442a9b,
5f68718b34a531a556f2f50300ead2862278da26,
f6c383b8c31a93752a52697f8430a71dcbc46adf,
c92db3030492b8ad1d0faace7a93bbcf53850d0c,
a2dd0233cbc4d8a0abb5f64487487ffc9265beb5,
6a33d8b73dfac0a41f3877894b38082bd0c9a5bc,
02c6c24402bf1c1e986899c14ba22a10b510916b,
23185c6aed1ffb8fc44087880ba2767aba493779]

CVE-2023-4569: [nf] netfilter: nf_tables: deactivate catchall elements
in next generation

CVSS v3 score is not provided (NIST).
CVSS v3 score is 5.5 MEDIUM (CNA).

A memory leak flaw was found in nft_set_catchall_flush in
net/netfilter/nf_tables_api.c in the Linux Kernel.
This issue may allow a local attacker to cause a double-deactivations
of catchall elements, which results in a memory leak.

This bug was introduced by commit aaa3104 ("netfilter: nftables: add
catch-all set element support") in 5.13-rc1
so before Linux 5.13 are not affected.

Fixed status
mainline: [90e5b3462efa37b8bba82d7c4e63683856e188af]
stable/5.15: [1adaec4758d1cefbf348a291ad9b752aaa10f8d3]
stable/6.1: [00ea7eb1c69eec91cdf9259f0e427c56e7999fcd]
stable/6.4: [83ff16e449a675e215125d97a2c4a7f097d291d0]

CVE-2023-25775: improper access control flaw in RDMA driver

CVSS v3 score is 9.8 HIGH (NIST).
CVSS v3 score is 5.5 MEDIUM (CNA).

Improper access control in the Intel(R) Ethernet Controller RDMA
driver for linux before version
1.9.30 may allow an unauthenticated user to potentially enable
escalation of privilege via network access.

This issue was introduced by commit b48c24c2 ("RDMA/irdma: Implement
device supported verb APIs") in 5.14-rc1.
Before 5.14 kernels are not affected.

Fixed status
mainline: [bb6d73d9add68ad270888db327514384dfa44958]

CVE-2023-4611: mm/mempolicy: Take VMA lock before replacing policy

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.0 HIGH (CNA).

A use-after-free flaw was found in mm/mempolicy.c in the memory
management subsystem in the Linux Kernel.
This issue is caused by a race between mbind() and VMA-locked page
fault, and may allow a local attacker
to crash the system or lead to a kernel information leak.

This issue was introduced by commit 5e31275 ("mm: add per-VMA lock and
helper functions to control it") in 6.4-rc1.
Before 6.4 kernels are not affected.

Fixed status
mainline: [6c21e066f9256ea1df6f88768f6ae1080b7cf509]
stable/6.4: [e872d6b6ea4947fb87f0d6ea1ef814019dbed89e]

* Updated CVEs

CVE-2023-3772: xfrm: add NULL check in xfrm_update_ae_params

stable 4.14, 4.19, 5.4, 5.10, and 5.15 were fixed.

Fixed status
mainline: [00374d9b6d9f932802b55181be9831aa948e5b7c]
stable/4.14: [ed1cba039309c80b49719fcff3e3d7cdddb73d96]
stable/4.19: [44f69c96f8a147413c23c68cda4d6fb5e23137cd]
stable/5.10: [bd30aa9c7febb6e709670cd5154194189ca3b7b5]
stable/5.15: [075448a2eb753f813fe873cfa52853e9fef8eedb]
stable/5.4: [8046beb890ebc83c5820188c650073e1c6066e67]
stable/6.1: [87b655f4936b6fc01f3658aa88a22c923b379ebd]
stable/6.4: [53df4be4f5221e90dc7aa9ce745a9a21bb7024f4]

CVE-2023-3773: xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

stable/5.10 and stable/5.15 were fixed.

Fixed status
mainline: [5e2424708da7207087934c5c75211e8584d553a0]
stable/5.10: [614811692e21cef324d897202ad37c17d4390da3]
stable/5.15: [8e5e967348caead2e03f047af28a4bcd79b80b9c]
stable/6.1: [a442cd17019385c53bbddf3bb92d91474081916b]
stable/6.4: [a9020514f175ef15bb68eea9345782abfd9afea3]

CVE-2023-4273: exfat: check if filename entries exceeds max filename length

stable 5.15 was fixed.

Fixed status
mainline: [d42334578eba1390859012ebb91e1e556d51db49]
stable/5.10: [381f7df0f3c3bd7dceb3e2b2b64c2f6247e2ac19]
stable/5.15: [6b64974e02ea82d0bae917f1fa79495a1a59b5bf]
stable/6.1: [c2fdf827f8fc6a571e1b7cc38a61041f0321adf5]
stable/6.4: [e1a73ba43cf883cb37f6331aca5a4c5be6350982]

CVE-2023-1077: sched/rt: pick_next_rt_entity(): check list_entry

stable/4.19 was fixed.

Fixed status
mainline: [7c4a5b89a0b5a57a64b601775b296abf77a9fe97]
stable/4.19: [84d90fb72a053c034b018fcc3cfaa6f606faf1c6]
stable/5.10: [80a1751730b302d8ab63a084b2fa52c820ad0273]
stable/5.15: [2c36c390a74981d03f04f01fe7ee9c3ac3ea11f7]
stable/5.4: [084cd75643b61fb924f70cba98a71dea14942938]
stable/6.1: [6b4fcc4e8a3016e85766c161daf0732fca16c3a3]
stable/6.2: [1099004ae1664703ec573fc4c61ffb24144bcb63]

CVE-2023-2430: io_uring/msg_ring: fix missing lock on overflow for IOPOLL

stable/6.1 was fixed.

Fixed status
mainline: [e12d7a46f65ae4b7d58a5e0c1cbfa825cf8d830d]
stable/6.1: [22a406b3629a10979916ea7cace47858410117b5]

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

