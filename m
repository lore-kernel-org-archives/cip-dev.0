Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A857C43334
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 23:22:09 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web08.1332.1657149727238296578
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jul 2022 16:22:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Uu4hBlIR;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.41,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-10c0052da61so12466040fac.12
        for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jul 2022 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KRCYyiUFQvvt8FyrPWa4T5Si1G23zFofExHHcAs4wFI=;
        b=Uu4hBlIRKNqQdmINN/sMyDg9TaKj/whTjCha6/B8YHGq4chhr1DX4sO2J7arGUV1VV
         gYgPpWvvj267Q8bZZKNOckxtD8IWHDU3LeSJpXITl0rHZwdAqv/TK5Ub7MQcrLXPiSls
         u2bVmTrrxpAlJbIuNc0f8OaYbos/28l9vb+qCmDidkItNB4B0kOS+irgRSCFFhB+SlLX
         9Rhg5kQq7rvoEZxotpPQyeiy0esUWKitz0Qx+qzybdxnnK06IezGsrIix4dMsgpUb5Od
         G76GRcLNgA8K2rYWioixdtU1uT4ogT4mYbcn0wxXMw9aasZjbk1FSzv214bciXywNMVF
         EFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KRCYyiUFQvvt8FyrPWa4T5Si1G23zFofExHHcAs4wFI=;
        b=2lmloZz1q0bXAQ2KSqI7kKZ01JuXv9pfoVUS5NBzjCiSS3jF2JRc4qJtQFI1AncV6m
         TZjgvxSi+42NT4WDw5cut4lOa+Ap3JshdhA/yXNtS1gI8g7jS0U1wWY8eg5i7TEPbBtQ
         hK0PF+HmMXNHUAIkiIZIotg1UuE99WNcQjKBILrqEktA2FplDmZtfnI/rT1+BaEu3Jaf
         9Q1CyIIOqd2wDSRECwoskx5gzV5jT1GY8ClNFkX34akqiwo3f0Jfz1ASZLkkThxJuK/q
         uOhX775iAN/YnoCfyk07w7X4VfKU0pA5WjuUt+6R4ZZhIgXbTkzI0CGHiduzMgt3Oz9w
         wphA==
X-Gm-Message-State: AJIora+Au3vIXsybR52+9cV2KSotfamZZ8P6EvOHt9CapYSlZpCRt7jV
	s4zRE2g3tHlT45gBnQawBr85dhVg2DrqaLDCY+08s9qOdBeVaQ==
X-Google-Smtp-Source: 
 AGRyM1vROtdz87o5dA5jGrWMXiYaZmWEsJh//NvEMclnS9KJokflExbra6ElUtRjD7Alue0I9hcGZf+dH+Ou6HPL4mM=
X-Received: by 2002:a05:6870:9a18:b0:101:3954:9730 with SMTP id
 fo24-20020a0568709a1800b0010139549730mr744728oab.253.1657149726077; Wed, 06
 Jul 2022 16:22:06 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Jul 2022 08:21:30 +0900
Message-ID: 
 <CAODzB9rT+O0BCmDzNDUwBad4n0H_-Hbe6UsGe-dw2f5uZSV_4w@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Jul 2022 23:22:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8702

Hi !

It's this week's CVE report.

This week reported 8 CVEs and 2 updated CVEs.

* New CVEs

CVE-2022-2318: UAF vulnerabilities in rose protocol

CVSS v3 score is not assigned.

A use-after-free bug was found in net/rose/rose_timer.c. An attacker
will be able to crash system via this vulnerability.
4.4 kernel is vulnerable too.

No CIP member enables CONFIG_ROSE.

Fixed status
mainline: [9cc02ede696272c5271a401e4f27c262359bc2f6]

CVE-2022-26365: Xen Linux disk/nic frontends data leaks

CVSS v3 score is not assigned.

When allocating a shared page in
fill_grant_buffer()/blkfront_setup_indirect() via alloc_page(), it
doesn't initialize the allocated page.
In the result, unintended data in the page will leak.

4.4 kernel seems to be vulnerable.

Fixed status
mainline: [2f446ffe9d737e9a844b97887919c4fda18246e7]

CVE-2022-33740: Xen Linux disk/nic frontends data leaks

CVSS v3 score is not assigned.

When allocating a shared page in xennet_alloc_one_rx_buffer() via
alloc_page(), it doesn't initialize the allocated page.
In the result, unintended data in the page will leak.

4.4 kernel seems to be vulnerable.

Fixed status
mainline: [307c8de2b02344805ebead3440d8feed28f2f010]

CVE-2022-33741: Xen Linux disk/nic frontends data leaks

CVSS v3 score is not assigned.

Xen backend will be able to read data from a shared page which is not
related to this backend.

Commit 4491001 ("xen/netfront: force data bouncing when backend is
untrusted") is based on commit fd07160 ("xen-netfront: avoid packet
loss when ethernet header crosses page boundary") which is not merged
in 4.4.

Fixed status
mainline: [4491001c2e0fa69efbb748c96ec96b100a5cdb7e]

CVE-2022-33742: Xen Linux disk/nic frontends data leaks

CVSS v3 score is not assigned.

Xen backend will be able to read data from a shared page which is not
related to this backend.

Commit 2400617 ("xen/blkfront: force data bouncing when backend is
untrusted") is based on commit 3df0e50 ("xen/blkfront: pseudo support
for multi hardware queues/rings") which is not merged in 4.4.

Fixed status
mainline: [2400617da7eebf9167d71a46122828bc479d64c9]

CVE-2022-33743: Xen network backend may cause Linux netfront to use freed SKBs

CVSS v3 score is not assigned.

Xen's network backend will use freed SKBs which will cause system crash.

4.4 seems vulnerable.
Apply commit f63c2c2 will fail because it modifies blkif_free_ring()
which is introduced by commit 3df0e50 ("xen/blkfront: pseudo support
for multi hardware queues/rings").

Fixed status
mainline: [f63c2c2032c2e3caad9add3b82cc6e91c376fd26]

CVE-2022-33744: Xen Arm guests can cause Dom0 DoS via PV devices

CVSS v3 score is not assigned.

Arm guests can cause Dom0 DoS via PV devices When mapping pages of
guests on Arm.
4.4 seems to be vulnerable.

Fixed status
mainline: [b75cd218274e01d026dc5240e86fdeb44bbed0c8]

CVE-2022-34918: netfilter: nf_tables: stricter validation of element data

CVSS v3 score is not assigned.

A heap overflow bug was found in nft_set_elem_init() in netfilter
subsystem. This bug lead to a local privilege escalation.
This vulnerability was introduced by commit fdb9c40 ("netfilter:
nf_tables: allow up to 64 bytes in the set element data area") which
is merged in 5.8-r1. The commit fdb9c40 is not backported to 4.x
stable kernels.
However, commit 7e6bc1f ("netfilter: nf_tables: stricter validation of
element data") mentions 7d7402642ea ("netfilter: nf_tables: variable
sized set element keys / data") introduced this bug. So, it seems that
a vulnerability was introduced by commit fdb9c40 and a bug not
vulnerable bug was introduced by commit 7d7402642eaf.

Fixed status
Fixed in netdev
tree(https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=7e6bc1f6cabcd30aba0b11219d8e01b952eacbb6)but
not merged into the mainline yet.

* Updated CVEs

CVE-2021-33624: Linux kernel BPF protection against speculative
execution attacks can be bypassed to read arbitrary kernel memory

Commit 30ea1c5 ("bpf, selftests: Adjust few selftest outcomes wrt
unreachable code") was added to stable/5.10.

Fixed status
mainline: [d203b0fd863a2261e5d00b97f3d060c4c2a6db71,
fe9a5ca7e370e613a9a75a13008a3845ea759d6e,
 9183671af6dbf60a1219371d4ed73e23f43b49db,
973377ffe8148180b2651825b92ae91988141b05]
stable/4.19: [0abc8c9754c953f5cd0ac7488c668ca8d53ffc90,
c510c1845f7b54214b4117272e0d87dff8732af6,
  9df311b2e743642c5427ecf563c5050ceb355d1d,
c15b387769446c37a892f958b169744dabf7ff23]
stable/5.10: [e9d271731d21647f8f9e9a261582cf47b868589a,
8c82c52d1de931532200b447df8b4fc92129cfd9,
  5fc6ed1831ca5a30fb0ceefd5e33c7c689e7627b,
30ea1c535291e88e41413464277fcf98a95cf8c6]
stable/5.12: [408a4956acde24413f3c684912b1d3e404bed8e2,
68a1936e1812653b68c5b68e698d88fb35018835,
  4a99047ed51c98a09a537fe2c12420d815dfe296,
e5e2010ac3e27efa1e6e830b250f491da82d51b4]
stable/5.4: [283d742988f6b304f32110f39e189a00d4e52b92,
d2f790327f83b457db357e7c66f942bc00d43462,
  fd568de5806f8859190e6305a1792ba8cb20de61,
a0f66ddf05c2050e1b7f53256bd9c25c2bb3022b]

CVE-2022-23038: Xen: fix race conditions, resulting in potential data
leaks, data corruption, DoS by malicious backends

stable 4.19 was fixed this week.

Fixed status
mainline: [6b1775f26a2da2b05a6dc8ec2b5d14e9a4701a1a,
33172ab50a53578a95691310f49567c9266968b0]
stable/4.19: [17659846fe336366b1663194f5669d10f5947f53,
62a696c15cfcfd32527f81ca3d94f2bde57475dc]
stable/4.9: [73e1d9b33f2bd93ce30719dfc8990b6328243b7e,
98bdfdf89e987406f4afdc7694cbdbb715383d8e]
stable/5.10: [3d81e85f30a8f712c3e4f2a507553d9063a20ed6,
3047255182774266950b22acc29c22a2d76e859e]

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

