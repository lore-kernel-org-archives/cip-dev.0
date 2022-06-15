Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF572C43334
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 23:44:49 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web12.11975.1655336680682451066
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jun 2022 16:44:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=0Lv928nf;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.175,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f175.google.com with SMTP id p129so5420oig.3
        for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jun 2022 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=gETsWkp6dgqF1qJ7lrCZnKpKEJ66oeZJPBEmNz1yYGg=;
        b=0Lv928nfa8cCwC7pVKqZA3jYGi+fcR1ljjNslJn/yDx9MLJIE67BkGBCsTZgL1lSoD
         THdwFRNK2AENjvq13JqP2ty8+zih/MIH6DLMwgG0uxnxYREJnQ9cNOcKuPSWvvBITGLc
         Qxr5gx4HEmDopcQbCsRuidsU8Pf+eIjm1td1kHP/vyxrDvbSnxHf7TC0kxTWhCdnvA/m
         cyeSGJwgY0VmUz+2UdFMQyVzKCx0crBqTX54dZs073tojZDECcdCvea3JJoVoL3MQLFU
         /H00fs5cD9vLUvaFEPy3WIZDWV3HTpTjvVKjUaUR2wSmGhcGCyWFf7kXZgAzAxBmfHJg
         ojPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gETsWkp6dgqF1qJ7lrCZnKpKEJ66oeZJPBEmNz1yYGg=;
        b=DH1j1Z2aFuPLwcOHwqkFPBIFLHMVtEEEZhXlTjd0mfQM+h7W5pMp7e40axsKX0KnQd
         CgnUYU/buDP3hB5fmy3Er5lX3qfN/DffQgKTDI4HtJKaukt5GV/wPZu2VjE0XJ+6pPIn
         +6Y3qw+IIcg7T0t4MCorxXHyE8jW9s1M9QLnqhvXX6+xKtzHsDZZgNhsGkc3nx/HM6Yo
         K0ecc4MYCzrh+Fh773wcX+Tps2TEHjuFVzlZ/5NIjCFCiH/ujFhNZK0mdjNTJXnojlJm
         j5TcDTn9qjWnOhQG4iSL7KLQJ+/CaVKODyz0LbXO3TwFgX9EYX2zhyUqeI5E2G9doiuU
         lcpA==
X-Gm-Message-State: AOAM531qfCS+cTk5+x9cl4sKzvqjosxrHveGo0lkbL6Zkc4mSB0Tai3M
	ItZeyzkmE58ZQUkKrSYv/wD0r6SBt8uCDuX8HiVfbcBx0rtMYw==
X-Google-Smtp-Source: 
 ABdhPJxfMzBSKQA2Bnn6EZcdwbBHFThDYrxzkBOWfci230jb63K0auQ2Tp9hmROTxRw6GOcy+La7g++yl1l1qu+zCj8=
X-Received: by 2002:a05:6808:1a0f:b0:32f:6700:37ab with SMTP id
 bk15-20020a0568081a0f00b0032f670037abmr5890235oib.87.1655336677956; Wed, 15
 Jun 2022 16:44:37 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Jun 2022 08:44:02 +0900
Message-ID: 
 <CAODzB9qmZ1m6L8MZYUOooRYfXh5Z_uj=o=ieR+Rn9jfSmdxQQA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 23:44:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8567

Hi !

It's this week's CVE report.

This week reported 3 new CVEs and 3 updated CVEs.

FYI: A new side-channel attack which is called "Hertzbleed Attack" has
been published.
This vulnerability has assigned to CVE-2022-23823 and CVE-2022-24436.
Researchers confirmed Intel's 8th to the 11th generation Core
microarchitecture and AMD Ryzen processors are affected but the
haven't confirmed other processors(e.g. ARM) are affected or not.
Intel and AMD provided guidance to mitigate the Heartbleed Attack.
However, researchers said that Intel and AMD haven't planned to
provide microcode patches.

https://www.hertzbleed.com/

* New CVEs

CVE-2022-32981: powerpc/32: Fix overread/overwrite of thread_struct via ptrace

CVSS v3 score is not assigned.

This vulnerability only affects powerpc 32bit architecture.
There is a buffer overflow in ptrace PEEKUSER and POKEUSER (aka
PEEKUSR and POKEUSR) when accessing floating point registers.

Fixed status
mainline: [8e1278444446fc97778a5e5c99bca1ce0bbc5ec9]
stable/4.14: [d13c94c4b6f816e79b8e4df193db1bdcc7253610]
stable/4.19: [a0e38a2808ea708beb4196a8873cecc23efb8e64]
stable/4.9: [89dda10b73b7ce184caf18754907126ce7ce3fad]
stable/5.10: [3be74fc0afbeadc2aff8dc69f3bf9716fbe66486]
stable/5.15: [2a0165d278973e30f2282c15c52d91788749d2d4]
stable/5.18: [7764a258356c454fe56b9f56fc07c0e146a3bccb]
stable/5.4: [0c4bc0a2f8257f79a70fe02b9a698eb14695a64b]

CVE-2022-32250: use-after-free bug in net/netfilter/nf_tables_api.c
causes a local user to escalate privileges.

CVSS v3 score is 7.8 HIGH

net/netfilter/nf_tables_api.c in the Linux kernel through 5.18.1
allows a local user (able to create user/net namespaces) to escalate
privileges to root because an incorrect NFT_STATEFUL_EXPR check leads
to a use-after-free.

The bug fix commit 5207780 ("netfilter: nf_tables: disallow
non-stateful expression in sets earlier") and  bug introduced commit
0b2d8a7 ("netfilter: nf_tables: add helper functions for expression
handling") are same as CVE-2022-1966.
So, it looks like this CVE is a duplicate of CVE-2022-1966.

Fixed status
mainline: [520778042ccca019f3ffa136dd0ca565c486cedd]
stable/4.14: [5b732a9e8e22395d911b3e6c343cbed0e1cec275]
stable/4.19: [ed44398b45add3d9be56b7457cc9e05282e518b4]
stable/4.9: [94e9b75919619ba8c4072abc4917011a7a888a79]
stable/5.10: [ea62d169b6e731e0b54abda1d692406f6bc6a696]
stable/5.15: [f692bcffd1f2ce5488d24fbcb8eab5f351abf79d]
stable/5.17: [d8db0465bcc4d4b54ecfb67b820ed26eb1440da7]
stable/5.18: [8f44c83e51b4ca49c815f8dd0d9c38f497cdbcb0]
stable/5.4: [f36736fbd48491a8d85cd22f4740d542c5a1546e]

CVE-2022-1976: io_uring: reinstate the inflight tracking

CVSS v3 score is not assigned.

There is a use-after-free bug in fs/io_uring.c that caused a system crash.
This issue was introduced by commit d536123 ("io_uring: drop the old
style inflight file tracking") in 5.18-rc2.
5.18 and the mainline are affected by this vulnerability. Kernel 5.17
contains the commit d536123 but this version is EOL.

Fixed status
mainline: [9cae36a094e7e9d6e5fe8b6dcd4642138b3eb0c7]

* Updated CVEs

CVE-2021-4034: kernel vs pkexec API confusion leads to easy local root

Added 4.14, 5.4, 5.15 and 5.17 kernel fixed commits.

Fixed status
mainline: [dcd46d897adb70d63e025f175a00a89797d31a43]
stable/4.14: [98e0c7c702894987732776736c99b85ade6fba45]
stable/4.19: [b50fb8dbc8b81aaa126387de428f4c42a7c72a73]
stable/4.9: [41f6ea5b9aaa28b740d47ffe995a5013211fdbb0]
stable/5.10: [27a6f495b63a1804cc71be45911065db7757a98c]
stable/5.15: [1290eb4412aa0f0e9f3434b406dc8e255da85f9e]
stable/5.17: [cfbfff8ce5e3d674947581f1eb9af0a1b1807950]
stable/5.4: [1fe82bfd9e4ce93399d815ca458b58505191c3e8]

CVE-2022-1973: fs/ntfs3: Fix invalid free in log_replay

Stable kernels 5.15, 5.17, and 5.18 were fixed. All kernels are fixed.

Fixed status
mainline: [f26967b9f7a830e228bb13fb41bd516ddd9d789d]
stable/5.15: [61decb58486d7c0cbded25fe4d301ab4fa148cd8]
stable/5.17: [2088cc00491e8d25a99d0f247df843e9c3df2040]
stable/5.18: [2aafbe9fb210a355d6e0e92a91f294dee80e5d44]

CVE-2022-1966: netfilter: nf_tables: disallow non-stateful expression
in sets earlier

stable 4.14, 4.19, 4.9, and 5.4 were fixed.

Fixed status
mainline: [520778042ccca019f3ffa136dd0ca565c486cedd]
stable/4.14: [5b732a9e8e22395d911b3e6c343cbed0e1cec275]
stable/4.19: [ed44398b45add3d9be56b7457cc9e05282e518b4]
stable/4.9: [94e9b75919619ba8c4072abc4917011a7a888a79]
stable/5.10: [ea62d169b6e731e0b54abda1d692406f6bc6a696]
stable/5.15: [f692bcffd1f2ce5488d24fbcb8eab5f351abf79d]
stable/5.17: [d8db0465bcc4d4b54ecfb67b820ed26eb1440da7]
stable/5.18: [8f44c83e51b4ca49c815f8dd0d9c38f497cdbcb0]
stable/5.4: [f36736fbd48491a8d85cd22f4740d542c5a1546e]

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

