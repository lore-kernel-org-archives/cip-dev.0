Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD94EC433EF
	for <webhook@archiver.kernel.org>; Wed, 23 Feb 2022 23:41:40 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web09.3579.1645659699075634878
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Feb 2022 15:41:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=zTFcdyBb;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.169,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f169.google.com with SMTP id s5so713921oic.10
        for <cip-dev@lists.cip-project.org>;
 Wed, 23 Feb 2022 15:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=aFg1VSBi46VwR0Pf0D2glCes/aqXz8zQVUQ7qj3kNx8=;
        b=zTFcdyBbuoITEBbAKY/5EJSOxuxr0kibQz1zx09bpPphbqWpy6Wp7Y2P0tlJpeDxg4
         8CxQVu2jJmu0z9POewH6U8oT+eRz3X0kKqQDwSreMCyKyq30NzJBwY2Feg/pSYfOpAlE
         yqbQspl8Umsjr7SFZjfPfX7A0bWIAh08zSwR020NVeNAsGFZ0EbW0ZU1IVzrP4z75HWC
         RazS+/X3PW2uD0nXncbQGwTtHU5dGUtBMxdkQ3XCiAQzcat3Ytr1vWtcJLLcmMx7NcpY
         H6JFDO/yXJuVhvpr27oCWzT3FAsc8nTgo87bGBQls0d8oYJF14JkouZOsdK6Oixin1IO
         iw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aFg1VSBi46VwR0Pf0D2glCes/aqXz8zQVUQ7qj3kNx8=;
        b=TYxc9zV3wO5ME+id2TI+4WEry7KV6ZCv/zFMEoRg+jvcJtVqtN8RQG1bAhQudkfmpv
         ngCpm/nca3R4jfDhoxREHSpDVdZQrnOlcnQlGhmp5Eoo6EpmnSAJRhqNE6Pp7gTG7a9o
         4qbjsRPgc2FgQEpVYRPX2W2ZJ2iViQ1OCi4+HiSarXRoIWSKiPa7eyN88rt7YLygjugG
         fTfoj1bCA4q2iADz9nwLW0hKRaqFSIz0ZM1nrP1tVY007bquJoMw8Dx/CsrNxEQEIWU0
         iFuX8NB53YN8E2gGYE2z1Zqya8jeyM9aV8w15NbJmek5bUAphLBlJLfAuc5M8ytjY6cu
         aJuA==
X-Gm-Message-State: AOAM531OehmxKMqJuRbpQ21nbl1uekay9w4Ol1HM+MSdHTZfy/YM8XTH
	PLKzKpkGhomUjKS/lmiyz4X5EcpyMwhXNRlbZONSEaf9jbiV6w==
X-Google-Smtp-Source: 
 ABdhPJxNNXwJVJLBBv1xeGEekVGdinUgJgxHJHCBzNnhMEcQS5clxhQT+TXErvaJ40Rz22FTDcbKCCJUcyVl+y9/7sA=
X-Received: by 2002:a05:6808:1b12:b0:2d4:a440:4a36 with SMTP id
 bx18-20020a0568081b1200b002d4a4404a36mr6000852oib.194.1645659697919; Wed, 23
 Feb 2022 15:41:37 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Feb 2022 08:41:02 +0900
Message-ID: 
 <CAODzB9rz0t9orpns_WqnkbwtdWvhiH3HWaFW_2JkP5iEYh_rog@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Feb 2022 23:41:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7639

Hi !

It's this week's CVE report.

This week reported 7 new CVEs and 1 updated CVE.

* New CVEs

CVE-2022-0644: vfs: check fd has read access in kernel_read_file_from_fd()

CVSS v3 score is not provided

There was a missing permission check in kernel_read_file_from_fd()
which causes an unprivileged user can read a file without permission.
This bug was introduced by commit b844f0e("vfs: define
kernel_copy_file_from_fd()") which was merged at 4.6-rc1.
The mainline and stable kernels were fixed.

Fixed status

mainline: [032146cda85566abcd1c4884d9d23e4e30a07e9a]
stable/4.14: [aaa5e83805b09c7ed24c06227321575278e3de1d]
stable/4.19: [c1ba20965b59c2eeb54a845ca5cab4fc7bcf9735]
stable/4.9: [52ed5a196b1146e0368e95edc23c38fa1b50825a]
stable/5.10: [b721500c979b71a9f02eb84ca384082722c62d4e]
stable/5.4: [0f218ba4c8aac7041cd8b81a5a893b0d121e6316]

CVE-2022-0646: mctp: serial: Cancel pending work from ndo_uninit handler

CVSS v3 score is not provided

MCTP serial transport driver was introduced at 5.17-rc1 so that stable
kernels aren't affected by this issue.
The patch was merged into netdev/net.git tree.

Fixed status

Not fixed yet.

CVE-2022-25258: USB: gadget: validate interface OS descriptor requests

CVSS v3 score is not provided

The USB Gadget subsystem lacks certain validation of interface OS
descriptor requests (ones with a large array index and ones associated
with NULL function pointer retrieval). Memory corruption might occur.

Patch can be applied to 4.4 with a bit modification to fix merge conflicts.

The mainline and stable kernels were fixed.

Fixed status

mainline: [75e5b4849b81e19e9efe1654b30d7f3151c33c2c]
stable/4.14: [c7ad83d561df15ac6043d3b0d783aee777cf1731]
stable/4.19: [e5eb8d19aee115d8fb354d1eff1b8df700467164]
stable/4.9: [f3bcd744b0bc8dcc6cdb3ac5be20f54aecfb78a4]
stable/5.10: [22ec1004728548598f4f5b4a079a7873409eacfd]
stable/5.15: [3e33e5c67cb9ebd2b791b9a9fb2b71daacebd8d4]
stable/5.16: [8895017abfc76bbc223499b179919dd205047197]
stable/5.4: [38fd68f55a7ef57fb9cc3102ac65d1ac474a1a18]

CVE-2022-25265: kernel: Executable Space Protection Bypass

CVSS v3 score is not provided

A certain binary files may have the exec-all attribute if they were
built in approximately 2003 (e.g., with GCC 3.2.2 and Linux kernel
2.4.20). This can cause execution of bytes located in supposedly
non-executable regions of a file.

Fixed status

Not fixed yet.

CVE-2022-0500: kernel: Linux ebpf logic vulnerability leads to
critical memory read and write gaining root privileges

CVSS v3 score is not provided

OOB write bug was found in unrestricted eBPF usage by the BPF_BTF_LOAD.
According to the
https://lore.kernel.org/bpf/20211217003152.48334-1-haoluo@google.com/
, commit 34d3a78 ("bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM") is
the main fix for this issue. This commit fixes commit 63d9b80 ("bpf:
Introducte bpf_this_cpu_ptr()"), eaa6bcb ("bpf: Introduce
bpf_per_cpu_ptr()"), and 4976b71 ("bpf: Introduce pseudo_btf_id").
These commits were merged from 5.10-rc1. So, stable 5.4, 4.19, 4.9,
and 4.4 kernels are not included in the commit.

To mitigate this issue, disable unprivileged eBPF.

Fixed status

mainline: [20b2aff4bc15bda809f994761d5719827d66c0b4,
216e3cd2f28dbbf1fe86848e0e29e6693b9f0a20,
  34d3a78c681e8e7844b43d1a2f4671a04249c821,
3c4807322660d4290ac9062c034aed6b87243861,
  48946bd6a5d695c50b34546864b79c1f910a33c1,
c25b2ae136039ffa820c26138ed4a5e5f3ab3841,
  cf9f2f8d62eca810afbd1ee6cc0800202b000e57]
stable/5.16: [e982070f8970bb62e69ed7c9cafff886ed200349,
4a6c35debbd46d796c81eb3ffcd6c747e76ec7a3,
  199cdd057eb747b36a193ecf96d2452e36643163,
5b33e437dc6a02e3298858ca8591096f36b1421d,
  bcd98af3eb7527f6ba39c976cbcf4454fa1106e1,
77459bc4d5e2c6f24db845780b4d9d60cf82d06a,
  6f6edc4211b379ef6de25d9182148c7ca26ffcfb]

CVE-2022-25375: usb: gadget: rndis: check size of RNDIS_MSG_SET command

CVSS v3 score is not provided

Kernel data leak bug was found in the RNDIS USB Gadget. Patch can be
applied to 4.4 without any errors.
The mainline and stable kernels were already fixed.

Fixed status

mainline: [38ea1eac7d88072bbffb630e2b3db83ca649b826]
stable/4.14: [4c22fbcef778badb00fb8bb9f409daa29811c175]
stable/4.19: [db9aaa3026298d652e98f777bc0f5756e2455dda]
stable/4.9: [ff0a90739925734c91c7e39befe3f4378e0c1369]
stable/5.10: [fb4ff0f96de37c44236598e8b53fe43b1df36bf3]
stable/5.15: [2da3b0ab54fb7f4d7c5a82757246d0ee33a47197]
stable/5.16: [2724ebafda0a8df08a9cb91557d33226bee80f7b]
stable/5.4: [c9e952871ae47af784b4aef0a77db02e557074d6]

CVE-2022-25636: netfilter: nf_tables_offload: incorrect flow offload
action array size

CVSS v3 score is not provided

net/netfilter/nf_dup_netdev.c in the Linux kernel 5.4 through 5.6.10
allows local users to gain privileges because of a heap out-of-bounds
write. This is related to nf_tables_offload.

This issue was introduced by commit be2861d ("netfilter:
nft_{fwd,dup}_netdev: add offload support") that was merged since
5.4-rc1.

Fixed status

fixed in netfilter tree commit b1a5983 ("netfilter: nf_tables_offload:
incorrect flow offload action array size") but hasn't been merged into
the mainline yet.

* Updated CVEs

CVE-2021-32606: net/can/isotp: race condition leads to local privilege
escalation

This bug was introduced by commit 921ca57 ("can: isotp: add
SF_BROADCAST support for functional addressing") which was merged at
5.11-rc1. so before 5.11 kernels aren't  affected by this issue.
However, this patch was backported to 5.10 but it wasn't merged into
5.10( https://lore.kernel.org/stable/20220216063137.2023-2-socketcan@hartkopp.net/
). Therefore 921ca57 and 5d42865 were merged into 5.10 now and
backported patches correctly.

Fixed status

mainline: [2b17c400aeb44daf041627722581ade527bb3c1d]
stable/5.10: [5d42865fc311af63785c9aa45ca30d1717c1c653]
stable/5.12: [b190618d8337b9466d985854e417dc0e8b012e3c]


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

