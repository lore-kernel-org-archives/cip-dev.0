Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3462FC433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 23:02:46 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web08.288.1668034963416771388
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Nov 2022 15:02:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=AGwRMH4S;
 spf=pass (domain: miraclelinux.com, ip: 209.85.218.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ej1-f52.google.com with SMTP id bj12so628877ejb.13
        for <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 15:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+nBioOIWD+jCdk/2xym4qe17+IBhTI7CQQgENxkR0m4=;
        b=AGwRMH4SfGe8TKrdT/NigELHE3LeXCQudjZtSQv/O+yAxGCpJUt0HjE77jdRpWx6NE
         xhNSRiVgzwph2z6CteBBl4xC06k+WqF3jyDu3wGYJCmPxpcNb4nut3v/X8t658kmcIdR
         KYLSCh8XnmuzidmSFGmg5RRzJ7gm03v0EJy8PjqN33/pZRw10F5GHo3p6sr07nh8tcca
         4OFiMZBl5nmrkgMrADrYXVgcnHKda5EPPtJV1/xsWkYJ9GPAoIq0XIAfLfliQ2d6nSVY
         Z5s8+ixV8p0N8TVfnuFagTGl0gi2fLsQt1MtnDwYotAEUT4bL3kr2RB4a0BaAptCPvkg
         vyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nBioOIWD+jCdk/2xym4qe17+IBhTI7CQQgENxkR0m4=;
        b=a1PZ3QY5c1t0dyd/NC/PAQxOKpl5do42Imb1d+0D3ZUBHWZae/fEN1tnB6CnT0yaD8
         kHLLz/jH5ShBbanHAOyOEZ3aePiOPEOlGt/2ogpCBk/rGzuZflGONit5oppBYWw1MLGL
         xK4ENKVjZTOPAzYlIDwR1rdiIZWy6svTVyJg5/EGR7HEaYiBttMuP0KudWZnBRjADPVt
         +hLHv5Q2f2t5tgM1DTEs2E0pKup+6UhKTEo26eZS++cw0Gq/yThEUsHy8HcVA+FrGmZQ
         6qfqJyfwIz3YYOK4lHOpme7Olehy7CkFnLAnyt1tL2DNLehUK5c0tCqkGqlHPWoQqoFf
         X0wQ==
X-Gm-Message-State: ACrzQf1dXLiPAUe53lVkOvdSx7HC8EB5IYCOmauy5lrMvfAfYDdm27lq
	zuywOe3tgyXLnP71Vk4fEMR2TOBUKbGWciaIayLg5efLE51BfQ==
X-Google-Smtp-Source: AMsMyM58hC29XU8p9h1tNbCtRQF0LfXThDQtOc/0AX0GtPcybDdvUZ1DbH9uaGBpoXia+pAgFeuw3yeGUtYW8bg8JJg=
X-Received: by 2002:a17:907:2135:b0:7ad:b152:90f2 with SMTP id
 qo21-20020a170907213500b007adb15290f2mr1907818ejb.345.1668034961443; Wed, 09
 Nov 2022 15:02:41 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Nov 2022 08:02:05 +0900
Message-ID: <CAODzB9pTzPzkeG7W6uY-E5ivktoXzv5=tQ77QnC7qNbk-h1udg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 23:02:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9987

Hi !

It's this week's CVE report.

This week reported 3 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2022-42895: Bluetooth: L2CAP: Fix attempting to access uninitialized memory

CVSS v3 score is not provided.

An accessing uninitialized variable bug was found in
l2cap_parse_conf_req() in net/bluetooth/l2cap_core.c
The efs variable is on the stack. It is initialized when the type
variable is L2CAP_CONF_EFS.
So, if type isn't L2CAP_CONF_EFS and rfc.mode is L2CAP_MODE_ERTM, then
accessing uninitialized variable bug occurs.

It looks 4.4 is affected by this issue too.

Fixed status
mainline: [b1a2cd50c0357f243b7435a732b4e62ba3157a2e]

CVE-2022-42896: Bluetooth: L2CAP: Fix accepting connection request for
invalid SPSM

CVSS v3 score is not provided.

There was a valid range check for SPSM. Therefore, it will accept
connections with invalid SPSM value.

It looks 4.4 is affected by this issue too.

Fixed status
mainline: [711f8c3fb3db61897080468586b970c87c61d9e4]

CVE-2022-43945: A buffer overflow bug was found in nfsd

CVSS v3 score is 7.5 HIGH.

The Linux kernel NFSD implementation prior to versions 5.19.17 and
6.0.2 are vulnerable to buffer overflow. NFSD tracks the number of
pages held by each NFSD thread by combining the receive and send
buffers of a remote procedure call (RPC) into a single array of pages.
A client can force the send buffer to shrink by sending an RPC message
over TCP with garbage data added at the end of the message. The RPC
message with garbage data is still correctly formed according to the
specification and is passed forward to handlers. Vulnerable code in
NFSD is not expecting the oversized request and writes beyond the
allocated buffer space.

nfsd3_proc_read() and nfsd_proc_read() changed to set argp->count
value adding an extra min_t() macro.
nfsd_init_dirlist_pages() and nfsd3_init_dirlist_pages() changed the
process of setting buf->buflen value.
However, 4.4, 4.19, 5.10 use different ways to set these values. So,
even if these kernels are vulnerable, it needs a different way to fix
them.

Fixed status
mainline: [00b4492686e0497fdb924a9d4c8f6f99377e176c,
640f87c190e0d1b2a0fcb2ecf6d2cd53b1c41991,
  401bc1f90874280a80b93f23be33a0e7e2d1f912,
fa6be9cc6e80ec79892ddf08a8c10cabab9baf38]
stable/5.15: [dc7f225090c29a5f3b9419b1af32846a201555e7,
071a076fd1b763aa6fe478efa047e0a549ba9c22,
  2be9331ca6061bc6ea32247266f45b8b21030244,
75d9de25a6f833dd0701ca546ac926cabff2b5af]
stable/6.0: [f59c74df82f6ac9d2ea4e01aa3ae7c6c4481652d,
279274e31270c28b86feffe5e166d4088f22317b,
  1868332032eccbab8c1878a0d918193058c0a905,
309f29361b6bfae96936317376f1114568c5de19]

* Updated CVEs

CVE-2022-20369: 'media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP
buffers across ioctls

4.14 and 4.19 were fixed this week.

Fixed status
mainline: [8310ca94075e784bbb06593cd6c068ee6b6e4ca6]
stable/4.14: [7339b6bdf9e084f9e83c084ccc8879b6ae80b75a]
stable/4.19: [95c4751705f7eef0f16a245e121259857f867c4a]
stable/5.10: [8a83731a09a5954b85b1ce49c01ff5c2a3465cb7]
stable/5.15: [48d00e24822e4384edcee3aae03d54c1b7982eba]
stable/5.4: [54e1abbe856020522a7952140c26a4426f01dab6]

CVE-2022-3524: tcp/udp: Fix memory leak in ipv6_renew_options().

5.15 and 6.0 were fixed this week.

Fixed status
mainline: [3c52c6bb831f6335c176a0fc7214e26f43adbd11]
stable/5.15: [1401e9336bebaa6dd5a320f83bddc17619d4e3a6]
stable/6.0: [0c5d628f1e1d049c33595693fab1b6e9baf25795]

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

