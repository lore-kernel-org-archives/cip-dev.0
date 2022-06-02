Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7350C43334
	for <webhook@archiver.kernel.org>; Thu,  2 Jun 2022 00:15:16 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web09.957.1654128908647308531
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jun 2022 17:15:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=xDkFIxZz;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.46,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-d39f741ba0so4787855fac.13
        for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jun 2022 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=/BMUHore7gKrIZnZ1t7ewlaSBG0ByX3ZV2njMpFuMzI=;
        b=xDkFIxZzD4YtYlOAED2UHnleA1PHQHSj+hncpKgKNgpN7jIuDQbRWWuK9DceMOYByB
         aCKVFjl64AyVPp7sLl9iPmkgD5r8rHo21ObyjZDEgAcX66IlipqHwNeoZsMqpExaZ8P8
         hmldkaEITOkPuHuI3Lw5VSn/NqLI99GK3iJI7eVSEMk+JsDU8TxDme2XzPnOlHhZzKc2
         cxzpq75Ea2mQsnVNwOsUzO3Rehf0Vmi7cBdsz2E2JzbnOWmaw35hp5ENelxA6TEcnpXO
         SLjzHVVD+GjDfKmmryqTjYcKsijRfgzwYkonNYlJl5FUGz82rXr1d0s6LaHZl3p0zjio
         0yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/BMUHore7gKrIZnZ1t7ewlaSBG0ByX3ZV2njMpFuMzI=;
        b=HuQW3WR/LaTXjwm+KAo9gi+pV5kKh3FQ9+/TMYAMbpBlkAiMQ6MK3oeemxsDZqrpZI
         Ty1nuFulgEypXS8VKpv+kmsXxTbzWCBsxqZ72hDfvjOMrxtrP57N3DWC9Xl8PcZpKR69
         rWh927aQ4d5azSPHglgtka035CQXJOEuGCRDAXKjLQvbmTpHU2k1rrfR8epM3FPBixRD
         aFEmEzs33aT0v8wUm/6ECCKomW0jcWDw4yVPDpaW9eonVdpU2GlKsL/TppQAHJuMI0tb
         VIHqwHutA1YxjkZ6qNWqV500T7YlHExRH1JKVmG2P2kJgA1C1xXdV24lR4hpBDjtYn/X
         OkrA==
X-Gm-Message-State: AOAM530x3VVNw0ICLcyl9CmRLEwdSk1bWv9n6Vc0XdeK+bzr4YpUCSrs
	duqg8cq4z8b96LQRRkymbjIskqld20Enw9MdAdkf09PfrV7Wag==
X-Google-Smtp-Source: 
 ABdhPJyAA1HuPEV4b9gmn9Aj6BAaF0A/m+CQV0gZQtNLIv08rESmMthD+7hGPhDI0Ty3pJVx6rssWJWcn6V46cgZJTw=
X-Received: by 2002:a05:6870:f225:b0:f1:fc2d:af76 with SMTP id
 t37-20020a056870f22500b000f1fc2daf76mr19186354oao.87.1654128907100; Wed, 01
 Jun 2022 17:15:07 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Jun 2022 09:14:31 +0900
Message-ID: 
 <CAODzB9q3OBD0k6W2bcWrSZo2jC3EvV0PrLyWmO07rxR4nQgkJA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jun 2022 00:15:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8476

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2022-1678: tcp: fix possible socket leaks in internal pacing mode

CVSS v3 score is not assigned.

An issue was discovered in the Linux Kernel from 4.18 to 4.19, an
improper update of sock reference in TCP pacing can lead to
memory/netns leak, which can be used by remote clients.

This issue was introduced by commit 73a6bab5 ("tcp: switch pacing
timer to softirq based hrtimer") which was merged in 4.18-rc1. This
patch wasn't backported to 4.9, 4.4. So 4.4 and 4.9 aren't affected by
this issue.

In the mainline, this issue was fixed by commit 864e5c0 ("tcp:
optimize tcp internal pacing").
However, in the stable/4.19, this issues was fixed by commit 0a70f11
("tcp: fix possible socket leaks in internal pacing mode").
The commit 0a70f11 describes that "In linux-4.20, TCP stack adopted
EDT (Earliest DepartureTime) model and this issue was incidentally
fixed.".

The mainline and stable kernels were fixed.

Fixed status
mainline: [864e5c090749448e879e86bec06ee396aa2c19c5:]
stable/4.19: [0a70f118475e037732557796accd0878a00fc25a]

CVE-2022-1462: kernel: possible race condition in drivers/tty/tty_buffers.c

CVSS v3 score is not assigned.

An oob read bug was found in the TeleTYpe subsystem. A local user use
TIOCSPTLCK and TIOCGPTPEER and TIOCSTI and TCXONC to make a race
condition in the flush_to_ldisc(). It will cause an user can  to crash
the system or read unauthorized random data from memory.

Fixed status
Not fixed yet

CVE-2022-1882: fs/pipe: Deinitialize the watch_queue when pipe is freed

CVSS v3 score is not assigned.

According to the RZ
bugzilla(https://bugzilla.redhat.com/show_bug.cgi?id=2089701) , that
describes the following detail.
A UAF flaw in Linux Kernel found in pipes functionality. The problem
located in function free_pipe_info of the fs/pipe.c.
When a pipe node is freed, it doesn't make pipe->watch_queue->pipe
null. When function post_one_notification is called, it will use this
field, but it has been freed and watch_queue->pipe is a dangling
pointer.
The problem was introduced since commit db8facfc9fafacefe8a835
"watch_queue, pipe: Free watchqueue state after clearing pipe ring".

Fixed status
Patch is available but it hasn't been merged yet.

CVE-2022-1852: KVM: x86: avoid calling x86 emulator without a decoded
instruction

CVSS v3 score is not assigned.

When x86_decode_emulated_instruction() detects a break point and
kvm_vcpu_check_breakpoint() set 0 to "r" function argument, it is
misunderstood as EMULATION_OK and x86_emulate_instruction() is called
without having decoded the instruction.
This causes various havoc from running with a stale emulation context.

This bug was introduced by commit 4aa2691 ("KVM: x86: Factor out x86
instruction emulation with decoding") in 5.12-rc1-dontuse.
The commit 4aa2691 was backported to 5.10 so that 5.10 affected by
this isuse too.

Fixed status
mainline: [fee060cd52d69c114b62d1a2948ea9648b5131f9]

CVE-2022-1966: netfilter: nf_tables: disallow non-stateful expression
in sets earlier

CVSS v3 score is not assigned.

An UAF write bug was found in the netfilter subsystem that will cause
privilege escalation. This vulnerability is triggered by creating
user/net namespace.

This vulnerability was introduced by commit 0b2d8a7 ("netfilter:
nf_tables: add helper functions for expression handling") in 4.1-rc1.

Fixed status
fixed in the netfilter
tree(https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/net/netfilter?id=520778042ccca019f3ffa136dd0ca565c486cedd)
but it hasn't been merged into the mainline yet.

CVE-2022-1943: udf: Avoid using stale lengthOfImpUse

CVSS v3 score is not assigned.

udf_write_fi() uses lengthOfImpUse of the entry it is writing to.
However this field has not yet been initialized so it either contains
completely bogus value or value from last directory entry at that
place.
In either case this is wrong and can lead to filesystem corruption or
kernel crashes.

This bug was introduced by commit 979a6e28dd96 ("udf: Get rid of
0-length arrays in struct fileIdentDesc") which was merged in
5.15-rc1.
Earlier than 5.15 kernels aren't affected by this issue.

Fixed status
mainline: [c1ad35dd0548ce947d97aaf92f7f2f9a202951cf]
stable/5.15: [9e951f2d85c9430ea8ae0c8448e47e3c234f1580]
stable/5.17: [cfd64b858cb2b56969138df7970cb0b7f2388fb0]

* Updated CVEs

CVE-2022-1012: secure_seq: use the 64 bits of the siphash for port
offset calculation

Commit a5c68f4 ("secure_seq: use the 64 bits of the siphash for port
offset calculation") was backported to stable/5.10 this week.

Fixed status
mainline: [b2d057560b8107c633b39aabe517ff9d93f285e3,
9e9b70ae923baf2b5e8a0ea4fd0c8451801ac526,
  4dfa9b438ee34caca4e6a4e5e961641807367f6f,
ca7af0402550f9a0b3316d5f1c30904e42ed257d,
  e9261476184be1abd486c9434164b2acbe0ed6c2,
4c2c8f03a5ab7cb04ec64724d7d176d00bcc91e5,
  e8161345ddbb66e449abde10d2fdce93f867eba9]
stable/4.19: [abcf4e1277d169b82dd7ee290006487ed16016ce]
stable/5.10: [d254309aab27fdcdc68e6bc9c663e51f3e7b37dc,
a5c68f457fbf52c5564ca4eea03f84776ef14e41]
stable/5.15: [1a8ee547da2b64d6a2aedbd38a691578eff14718,
ff01554d8755bdbe2aec2e2cff322d95f328cb89,
  f41f6336bfc43500e4e94ada703cd5aebb91789e,
b763fce193b42048444afd85d066b136288ad2c8,
  4a3eefa399e675c4a5239497832a72733281a20f,
952a238d779eea4ecb2f8deb5004c8f56be79bc9,
  f26c6f9404e1d6f3bfc9780ffba82a01a595d147]
stable/5.17: [6976724355f5fdada89de528730f9a7b4928f2e3,
27003fa8b581098aa9768bc03f82d5654368cb02,
  3a8081f81323e1550c241157244318db166b660e,
c2cef1db8f8aa81330fee4538a1158e1f6fd5bd1,
  01e16c23823a057667feb5cf26ba0c963fef6afd,
e3ee7bb47d6509c3e8a3e96e5d8e3bf21549b6e8,
  5034cbb361e1c447911a15b1d3982d5df7aa17b9]

CVE-2022-1789: KVM: x86/mmu: fix NULL pointer dereference on guest INVPCID

5.10, 5.15, and 5.17 were fixed this week.

Fixed status
mainline: [9f46c187e2e680ecd9de7983e4d081c3391acc76]
stable/5.10: [9b4aa0d80b18b9d19e62dd47d22e274ce92cdc95]
stable/5.15: [acd12d16528152b32fa09be2c5ef95047f69af05]
stable/5.17: [19a66796d1f0dd4ce4b05f76d53ce1d0a7dc817d]

CVE-2022-21499: lockdown: also lock down previous kgdb use

5.10, 5.15, and 5.17 were fixed this week.

Fixed status
mainline: [eadb2f47a3ced5c64b23b90fd2a3463f63726066]
stable/5.10: [a8f4d63142f947cd22fa615b8b3b8921cdaf4991]
stable/5.15: [69c5d307dce1560fafcb852f39d7a1bf5e266641]
stable/5.17: [281d356a035132f2603724ee0f04767d70e2e98e]
stable/5.18: [eca56bf0066ef2f1e7be0e3fa7564b85a309872c]

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

