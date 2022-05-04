Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F84C433F5
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 22:54:00 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web10.4291.1651704830596944151
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 15:53:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Xkd9tLcN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id w194so1471503oie.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 15:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Spzf4qHoOIjWjknZYhvlWkymxHHreJA6lPUad3itplY=;
        b=Xkd9tLcNCslKdUOUMMV+i8qmjf2PwM23N7HmctNglBzKspcxxWfmz0R/t7jLR2gqPl
         CCx9n+virjS17Xa7WP9q1S5kxVhz25E5E7n3Bkp2QoHQyQ24CPqg33YstDBJ1HhuEZis
         KUWZHeYK1yOYJF2RElmMp8JMWvZ8HA+uLEePvP8B7hOu3DyZpojydAKxszFXKTbgaTXM
         c6UtZ+nGRv6hGt/L2nWFmw3uTLJfJbvOFi4Si7XpYKIIk/v/kYwzO0T2mAB2D4nE/Va3
         78oahke1kMbO1pa1MO5gRhg9UTk4dLtxDI8RyeW3PSU8njAHUouyPP1wPp421pUDCG1n
         Jqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Spzf4qHoOIjWjknZYhvlWkymxHHreJA6lPUad3itplY=;
        b=B45WYPiIPWvAhdhDlAmn6KnYyBYvZTJ6etckfLHoe6idWn8rkCujIz3xJE4Crq20ha
         duGePjOPoFWbXtXLnYhUfKkfFuDjN9pluo6JiLfSW1qlTFsnfWxivPonLr3ide5HnMnE
         hmd6HKNZ50a2ksTtgHySa0C2ENyfbi9MGiDUoF+uQtuTUyiM813PC4eD9Iuq7anud7wc
         iLIympt0a2yXzLQ2b1WrNJ/4cYN2yLzcMCWYpjmhPV+tNQgbyf5TRH3uJH4HIoURp8vq
         /fA8Dtk2NB7R3tROeS39mIjyhh7n94kjZQ1o4I3z1VEYjJXZKqwT8Z5rDmcFfga1kvzL
         aB2w==
X-Gm-Message-State: AOAM530QqQR9bjHGl4YIuSFeuJRgQ8fiYbkayDe3CpUndZzWhU+RgsNf
	HJ1Hb240HjMfZKGyYyA7fJ4/zJO+PgQmJiHMseN3CDc93QxwNg==
X-Google-Smtp-Source: 
 ABdhPJwwJkA32Psd1yXNgjCm+WIV54RgCaGctC/5T2xhMZnqIM9MY3+uQIBCfgv+fPVkeYpPFM/ugwI1u4O8LLpoFG8=
X-Received: by 2002:a54:4f87:0:b0:324:ea60:b97d with SMTP id
 g7-20020a544f87000000b00324ea60b97dmr966992oiy.87.1651704829477; Wed, 04 May
 2022 15:53:49 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 May 2022 07:53:13 +0900
Message-ID: 
 <CAODzB9rG--wyA3tnPrwQ98w7dfR=eRNtV6xfH=xKjbfjx9vm9Q@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 22:54:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8252

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 2 updated CVEs.
There were no critical vulnerabilities this week.

* New CVEs

CVE-2022-1508 : io_uring: reexpand under-reexpanded iters

CVSS v3 score is not provided

An OOB read bug was reported by KASAN. A local attacker can read some
memory by this bug.
Since io_uring was introduced in 5.1, kernels below this version will
not be affected.
This vulnerability was fixed in 5.15-rc1.

Fixed status

mainline: [89c2b3b74918200e46699338d7bcc19b1ea12110,
2112ff5ce0c1128fe7b4d19cfe7f2b8ce5b595fa]

CVE-2022-29968: io_uring: fix uninitialized field in rw io_kiocb

CVSS v3 score is not provided

This bug was introduced by commit 3e08773 ("block: switch polling to
be bio based") which was merged in 5.16-rc1. Therefore earlier than
5.16 kernels aren't affected by this issue.

Fixed status

mainline: [32452a3eb8b64e01e2be717f518c0be046975b9d]

CVE-2022-1516: net/x25: Fix null-ptr-deref caused by x25_disconnect

CVSS v3 score is not provided

A null pointer dereference bug was found in x25_disconnect(). This bug
was intoroduced by commit 4becb7e ("net/x25: Fix x25_neigh refcnt leak
when x25 disconnect"). This patch was backported to 4.4. so 4.4 kernel
is affected by this issue.
No CIP members enable CONFIG_X25.

Fixed status

mainline: [7781607938c8371d4c2b243527430241c62e39c2]
stable/4.14: [858642789ada1b48630f322e59416ca9fca3e6b7]
stable/4.19: [4c240c5a105557e4546d0836e694868f22fd09b0]
stable/4.9: [dffc859d1d9560da594e4282091781b8d2715f00]
stable/5.10: [5c94b6205e87411dbe9dc1ca088eb36b8837fb47]
stable/5.15: [409570a619c1cda2e0fde6018a256b9e3d3ba0ee]
stable/5.17: [671529db75e6be777bb1c76aa07c2bdd2992be6d]
stable/5.4: [9acf05b4e7b55fdb712ef7b331dbce5bcd391d0f]

CVE-2022-20008: mmc: block: fix read single on recovery logic

CVSS v3 score is not provided

An information disclosure vulnerability was found in mmc driver.
This vulnerability was introduced by 8119697 ("mmc: block: Add blk-mq
support") that was merged in 4.16-rc1.

Fixed status

mainline: [54309fde1a352ad2674ebba004a79f7d20b9f037]
stable/4.19: [c91b06297563e84ac072464fe6cc141cc15435f0]
stable/5.10: [ab2b4e65a130d67478bd5b35ca9004b2075805fa]

* Updated CVEs

CVE-2022-1195: kernel: A possible race condition (use-after-free) in
drivers/net/hamradio/6pack( mkiss.c) after unregister_netdev

Commit 9d2a1b1 ("hamradio: defer 6pack kfree after unregister_netdev")
and 3befa9b ("hamradio: remove needs_free_netdev to avoid UAF") were
added to 4.19.

Fixed status

mainline: [3e0588c291d6ce225f2b891753ca41d45ba42469,
0b9111922b1f399aba6ed1e1b8f2079c3da1aed8,
    81b1d548d00bcd028303c4f3150fa753b9b8aa71,
b2f37aead1b82a770c48b5d583f35ec22aabb61e]
stable/4.19: [896193a02a2981e60c40d4614fd095ce92135ccd,
b68f41c6320b2b7fbb54a95f07a69f3dc7e56c59,
  9d2a1b180f0d5fdf0844cb4c740fafd67bebb9d2,
3befa9b67f2205f10c3b01cc687672e3969be569]
stable/4.9: [8a1a314965a17c62084a056b4f2cb7a770854c90,
83ba6ec97c74fb1a60f7779a26b6a94b28741d8a]
stable/5.10: [450121075a6a6f1d50f97225d3396315309d61a1,
7dd52af1eb5798f590d9d9e1c56ed8f5744ee0ca,
  80a4df14643f78b14f1e8e2c7f9ca3da41b01654,
cfa98ffc42f16a432b77e438e2fefcdb942eeb04]
stable/5.15: [cb6c99aedd2c843056a598a8907a6128cb07603b,
c799c18a287e024e1c885da329aad8f719b255c3,
  9873fe0f3857c500fa21f92fe43b2a177e8de208,
03d00f7f1815ec00dab5035851b3de83afd054a8]

CVE-2022-0500: kernel: Linux ebpf logic vulnerability leads to
critical memory read and write gaining root privileges

stable/5.15 was fixed this week.

Fixed status

mainline: [20b2aff4bc15bda809f994761d5719827d66c0b4,
216e3cd2f28dbbf1fe86848e0e29e6693b9f0a20,
  34d3a78c681e8e7844b43d1a2f4671a04249c821,
3c4807322660d4290ac9062c034aed6b87243861,
  48946bd6a5d695c50b34546864b79c1f910a33c1,
c25b2ae136039ffa820c26138ed4a5e5f3ab3841,
  cf9f2f8d62eca810afbd1ee6cc0800202b000e57]
stable/5.15: [b453361384c2db1c703dacb806d5fd36aec4ceca,
2a77c58726aba893129a369ed3d2be004dda41cd,
  15166bb3000fc8b5faa8fa606eb25d300e6892ef,
3c141c82b95807473d77079936769e04a84e4ca3,
  d58a396fa6c98bde64772c1db715dfca32610597,
8d38cde47a7e17b646401fa92d916503caa5375e,
  b710f73704d61069b2f05358309290551e5a8732]
stable/5.16: [e982070f8970bb62e69ed7c9cafff886ed200349,
4a6c35debbd46d796c81eb3ffcd6c747e76ec7a3,
  199cdd057eb747b36a193ecf96d2452e36643163,
5b33e437dc6a02e3298858ca8591096f36b1421d,
  bcd98af3eb7527f6ba39c976cbcf4454fa1106e1,
77459bc4d5e2c6f24db845780b4d9d60cf82d06a,
  6f6edc4211b379ef6de25d9182148c7ca26ffcfb]

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

