Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4256C4167B
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 23:04:38 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web11.57538.1701299070845032054
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Nov 2023 15:04:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=xT3QXnYj;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1fa4b632198so136792fac.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1701299070; x=1701903870; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luY6jClflZoeuWh3nhahacVI03HRZZ5c3Y+cwty/hKo=;
        b=xT3QXnYjhBEfi3LrOI3ubkyJgItwtoMEKDqn+buKMQHy8CZ2EJRh/Om2M5UBeg+86Q
         Z3YJFOM0GuCaw6e3G7cmSvGXLWCV417ci1l58mxWCg0VUalmtvLKPVZRSdfVGFUZvPgb
         JHRSQUMRsBdg3Es5yL1wByKFR1Avaia/BReUh38xleNLY1cQIau1rjdTteVoK+FdvlKS
         fu9H2gXCtcfnJzurEZ2o9isoi5nmvVKyNxeBxvezbadmqsvy7y2jkWwvP8HXBDoUyulj
         calpdC6NIcHHvcSo1fTE/h7cyZ8h/2EyB7YLv6bGvY5uHCTlDGkRjXhrl97+J5KGZ/3V
         K8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701299070; x=1701903870;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luY6jClflZoeuWh3nhahacVI03HRZZ5c3Y+cwty/hKo=;
        b=sbnSI2YAZNdTkduBNbu+Sze4ZEqtr/6v2CoBtLLpvJe32L4FHaAvPeVn95iSkdg+ae
         IcYpugD4ct4iBZ4dQFBQFNNapZdO7SiZD8pZdhAdxReTUvy9ywGEL8JxwjZYkf67uXVK
         k44dK7DxiaAaFNDejtl0Fox4DAqg2fjJkpQPlrskRxIxE5OdtwNgVx29z21IzqGmxpDq
         gwK3XAD2vabR4/mYzs2Ui1nJvN+PrA5u5jBr/9U16b/CsVwx+7W/v4j1lodJTcw3pCeu
         PQaWrxPNvSzaXoN3tMiTjzCsQ7OsSHAWiSmbHaHZrmRDmLlzBk0Hjgfw16IOJ9ioxyIj
         LlRA==
X-Gm-Message-State: AOJu0YwQRmp6fKjPM4tJvI58T4RPzvoQuIT/tcKp1loLFOAXJtbfdRtA
	XffiuI3bmrTCAp5dyiOjXJlZTbZerymmDlkTA/sBKUYi6s4aZdTk5E8=
X-Google-Smtp-Source: AGHT+IGLUm0PtMzlRjESnOq+9FgsfAWA3LyB+IDjZ3xKpO3BHlyABtSPuHBJMhJpQXG7XZDkXV/ymGz6YLApEmRrje0=
X-Received: by 2002:a05:6870:148c:b0:1fa:25d8:46a8 with SMTP id
 k12-20020a056870148c00b001fa25d846a8mr18845066oab.32.1701299069579; Wed, 29
 Nov 2023 15:04:29 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Nov 2023 08:03:53 +0900
Message-ID: <CAODzB9qbYaM5giYGU4DQdsd1VK0OAboXEOZxyHeFwogpF8rPEA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 23:04:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13762

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 6 updated CVEs.

* New CVEs

CVE-2023-5972: Null pointer dereference bug was found in the netfilter

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.0 (HIGH)

A null pointer dereference flaw was found in the nft_inner.c
functionality of netfilter in the Linux kernel.
This issue could allow a local user to crash the system or escalate
their privileges on the system.

This bug was introduced by commit 3a07327 ("netfilter: nft_inner:
support for inner tunnel header matching") in 6.2-rc1.
This bug is not affected prior to 6.2.

Fixed status
mainline: [505ce0630ad5d31185695f8a29dde8d29f28faa7,
52177bbf19e6e9398375a148d2e13ed492b40b80]
stable/6.5: [8a544721329e711f85358f73fe56964cdedeb531,
d6ba6de49c2d52df811513515ea17ecbbb6ba51a]

* Updated CVEs

CVE-2023-6121: nvmet: nul-terminate the NQNs passed in the connect command

Fixed in the mainline in 6.7-rc3.

Fixed status
mainline: [1c22e0295a5eb571c27b53c7371f95699ef705ff]

CVE-2023-0590: net: sched: fix race condition in qdisc_graft()

stable/4.19 and 4.14 were fixed.

Fixed status
mainline: [ebda44da44f6f309d302522b049f43d6f829f7aa]
stable/4.14: [42c50c7efcd1d263455438b81fe9388e685bfb66]
stable/4.19: [f782929b90b5ac88d4445c853949d9efa6db6bae]
stable/5.10: [7aa3d623c11b9ab60f86b7833666e5d55bac4be9]
stable/5.15: [ce1234573d183db1ebcab524668ca2d85543bf80]
stable/5.4: [0f5c0e0a4c0b081e5f959578a8e56c7921e63a2d]

CVE-2023-4244: A use-after-free vulnerability in the Linux kernel's netfilter

stable/5.4 was fixed.

Fixed status
mainline: [5f68718b34a531a556f2f50300ead2862278da26,
f6c383b8c31a93752a52697f8430a71dcbc46adf,
  c92db3030492b8ad1d0faace7a93bbcf53850d0c,
a2dd0233cbc4d8a0abb5f64487487ffc9265beb5,
  24138933b97b055d486e8064b4a1721702442a9b,
6a33d8b73dfac0a41f3877894b38082bd0c9a5bc,
  02c6c24402bf1c1e986899c14ba22a10b510916b,
23185c6aed1ffb8fc44087880ba2767aba493779]
stable/4.19: [255bb7fd670589c00cb2f8a1353b721306135ca3]
stable/5.10: [448be0774882f95a74fa5eb7519761152add601b,
146c76866795553dbc19998f36718d7986ad302b,
  77046cb00850e35ba935944b5100996b2ce34bba,
911dd3cdf1083f4c2e7df72aaab486a1d6dbcc0a,
  b15ea4017af82011dd55225ce77cce3d4dfc169c,
4046f2b56e5a7ba7e123ff961dd51187b8d59e78,
  dc0b1f019554e601f57e78d8f5c70e59d77e49a5,
a7653eaea0a59a6993c62d3653af5c880ce28533]
stable/5.4: [bbdb3b65aa91aa0a32b212f27780b28987f2d94f,
c357648929c8dff891502349769aafb8f0452bc2,
  85520a1f1d879455a8b6c950e7a92d3e8fa667b6,
1398a0eee290e3ddf1d5ce2539e47dd41830a0d5,
  1da4874d05da1526b11b82fc7f3c7ac38749ddf8,
29ff9b8efb84070b2ee9cf238efe0b202df079ff,
  b76dcf4662235b6f1a942892230a880382a3471d,
81da9e2c42556ada249cfb0d1d65d65986ac31ca]
stable/6.1: [7148bca63b212fc8e5c2e8374e14cd62b1c8441c,
59dab3bf0b8fc08eb802721c0532f13dd89209b8,
  ea3eb9f2192e4fc33b795673e56c97a21987f868,
df650d6a4bf47248261b61ef6b174d7c54034d15,
  4ead4f74b3a9162b205f702d72d4a3421356dbc1,
0b9af4860a61f55cf716267b5ae5df34aacc4b39,
  41113aa5698ad7a82635bcb747d483e4458d518d,
afa584c35065051a11ae3ea3cc105b634053fcd8]

CVE-2023-4563: Use-after-free in nft_verdict_dump due to a race
between set GC and transaction

stable/5.4 was fixed.

Fixed status
mainline: [24138933b97b055d486e8064b4a1721702442a9b,
5f68718b34a531a556f2f50300ead2862278da26,
  f6c383b8c31a93752a52697f8430a71dcbc46adf,
c92db3030492b8ad1d0faace7a93bbcf53850d0c,
  a2dd0233cbc4d8a0abb5f64487487ffc9265beb5,
6a33d8b73dfac0a41f3877894b38082bd0c9a5bc,
  02c6c24402bf1c1e986899c14ba22a10b510916b,
23185c6aed1ffb8fc44087880ba2767aba493779]
stable/5.10: [b15ea4017af82011dd55225ce77cce3d4dfc169c,
448be0774882f95a74fa5eb7519761152add601b,
  146c76866795553dbc19998f36718d7986ad302b,
77046cb00850e35ba935944b5100996b2ce34bba,
  911dd3cdf1083f4c2e7df72aaab486a1d6dbcc0a,
4046f2b56e5a7ba7e123ff961dd51187b8d59e78,
  dc0b1f019554e601f57e78d8f5c70e59d77e49a5,
a7653eaea0a59a6993c62d3653af5c880ce28533]
stable/5.4: [1da4874d05da1526b11b82fc7f3c7ac38749ddf8,
bbdb3b65aa91aa0a32b212f27780b28987f2d94f,
  c357648929c8dff891502349769aafb8f0452bc2,
85520a1f1d879455a8b6c950e7a92d3e8fa667b6,
  1398a0eee290e3ddf1d5ce2539e47dd41830a0d5,
29ff9b8efb84070b2ee9cf238efe0b202df079ff,
  b76dcf4662235b6f1a942892230a880382a3471d,
81da9e2c42556ada249cfb0d1d65d65986ac31ca]

CVE-2023-46862: io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

stable/5.10 and 5.15 were fixed.

Fixed status
mainline: [7644b1a1c9a7ae8ab99175989bfc8676055edb46]
stable/5.10: [c6e8af2a8a63e0957284c16003c501e4a058e8d9]
stable/5.15: [3d7912710e5e187217313fea5c145881cfeaf952]
stable/6.1: [9236d2ea6465b37c0a73d994c1ad31753d31e5f5]
stable/6.5: [56e08ccc969796168f0e6adf6642f8546f54ba6f]

CVE-2023-6111: netfilter: nf_tables: remove catchall element in GC sync path

stable/5.15, 6.1, 6.5, and 6.6 were fixed.

Fixed status
mainline: [93995bf4af2c5a99e2a87f0cd5ce547d31eb7630]
stable/5.15: [0d9506c766c9601fe22d15584a99c704d7941ef6]
stable/6.1: [13e2d49647a7f137ebc063a4a9702dda80371b2e]
stable/6.5: [e3e68e617bfa8dfc8625d5e728b0fe4b4fb83876]
stable/6.6: [80d6a9236ab6d2c0fd241514d1af2e325d16a210]

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

