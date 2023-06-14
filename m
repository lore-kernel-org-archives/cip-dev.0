Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85F3EB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 22:44:06 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web10.5549.1686782636927275045
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jun 2023 15:43:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=ePXgA3pm;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-392116b8f31so4057696b6e.2
        for <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1686782635; x=1689374635;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9K7Jcy/0jBwFYZCwXAHbxigXjywUqbrpBB5AUsmh2CI=;
        b=ePXgA3pmJYzGu+bYrosZMjz8ETZH0cY1PnJIqsStjQdCLeegZ3nzLt34LGfzNcpYXV
         dXbjRAsKEBSCKXFUkk0z8HxGQhNM4fVhXVLS5uIJxjjkJQ+2NOpsqqm3g7mgnOUhEVeu
         /0m1AvU/DMEjNPGV2HGpU6ni2VqMN6K/wXRvM7aAT1WnWwYfE4xNBFCiwaACaWjRk9fU
         VAxBCyV7wacBH/5zM3DMjCy1cljR/i21/bs0dAKPwP7YkJossbteof6TlVtN4DdlyO69
         QEt0dCyIAQkXEywURG7zuQcESpvBU2BS8kT7C78wOypA6qqYpIK4W0Ub9QudFgob0xod
         NvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686782635; x=1689374635;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K7Jcy/0jBwFYZCwXAHbxigXjywUqbrpBB5AUsmh2CI=;
        b=itHwDzJ+W4m3aq1AlOUUrdekW1TjwlXJmrS/TOyPGuGVTwGH011Hh+b5ya46ZQxs+t
         H3lOYUM9H9DHP2XCY8ahc3S8DTzdZD4lITVXH5obM1o7rtEI1I1W2ubrEh73sax7/9DS
         1Jtzv0AmeUvxOG9VusE0HNXwOG2wEMSbTd1/w6HL+8ZcaMy4tJoub7zAL88wGpJbTqDD
         29gKEHrCHh8J9sQtmDErN+4Gn505V8EUYDSDgpao8olHTwIzO36ijDpO7a9m72EYjld9
         sOCGCZ59p/p0u1ZrC8r2a+n3hNqN1mSrnYMFIDAj/6QU0jK3YjyVuwfPhtwEW3p+lTkV
         wZOA==
X-Gm-Message-State: AC+VfDyU2q6DqXiQkAGn9/v6HuYvVX7CHLL8xoFUNscEdJkzn9P5vNBN
	M2OTtCxKJkjoa5PoBdPaRh8iylYVD/x6nPAgbAymfEe8uaaEIgg9G/c=
X-Google-Smtp-Source: ACHHUZ5B470Jj0SdCOwS/lXX1SeOuw4dYKNgkQbIdk0svb3S/EOKhvTEVgCTzv3EDNH5HV0QmiitVANQo0pgHi+qB18=
X-Received: by 2002:a05:6808:1a02:b0:39a:7830:f237 with SMTP id
 bk2-20020a0568081a0200b0039a7830f237mr13341882oib.7.1686782635377; Wed, 14
 Jun 2023 15:43:55 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Jun 2023 07:43:19 +0900
Message-ID: <CAODzB9oUr_wN0h73C4aAQg6qk+awCv6QpxD11bME1K4GPJFsmg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 22:44:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12039

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 7 updated CVEs.

* New CVEs

CVE-2023-3141: memstick: r592: Fix UAF bug in r592_remove due to race condi=
tion

CVSS v3 score is 5.9 MEDIUM.

The client side in OpenSSH 5.7 through 8.4 has an Observable
Discrepancy leading to an information leak in the algorithm
negotiation. This allows man-in-the-middle attackers to target initial
connection attempts (where no host key for the server has been cached
by the client).

Fixed status
mainline: [63264422785021704c39b38f65a78ab9e4a186d7]
stable/4.14: [3faa6fe21c516dbcca469c297df77decbc2fed0f]
stable/4.19: [dce890c3dfaf631d0a8ac79c2792911f9fc551fa]
stable/5.10: [5c23f6da62f71ebfeda6ea3960982ccd926ebb09]
stable/5.15: [162a9b321538972a260c7b178638c2368c071f77]
stable/5.4: [a2a5d3a584bf86c9c09017381a8fc63cfaf5a9e6]
stable/6.1: [9a342d4eb9fb8e52f7d1afe088a79513f3f9a9a5]
stable/6.3: [76fec5f01c9c70e11b85fdeb3f2707589c9238ca]

CVE-2023-3159: A use-after-free bug was found in firmware driver code

CVSS v3 score is not provided.

A use after free issue was discovered in driver/firewire in
outbound_phy_packet_callback in the Linux Kernel. In this flaw a local
attacker with special privilege may cause a use after free problem
when queue_event() fails.

It was fixed in 5.18-rc6. All stable kernels and cip kernels were fixed.

Fixed status
mainline: [b7c81f80246fac44077166f3e07103affe6db8ff]
stable/4.14: [1269a6567274edecd04ee7fd7871aa4d0c937f2a]
stable/4.19: [34380b5647f13fecb458fea9a3eb3d8b3a454709]
stable/5.10: [e757ff4bbc893bc030c2d10143091094da73b9ff]
stable/5.15: [e259ba5c08d3791ab269b7775f1de5b36b06388c]
stable/5.4: [34b9b91829111a7e44b593c790a22680c89cd402]

CVE-2023-3161: An OOB access bug was found in fbdev driver

CVSS v3 score is not provided.

A flaw was found in the Framebuffer Console (fbcon) in the Linux
Kernel. When providing font->width and font->height greater than 32 to
fbcon_set_font, since there are no checks in place, a
shift-out-of-bounds occurs leading to undefined behavior and possible
denial of service.

It was fixed in 6.2-rc7. All stable kernels and cip kernels were fixed.

Fixed status
mainline: [2b09d5d364986f724f17001ccfe4126b9b43a0be]
stable/4.14: [7625513267a2b155a5e31e4ac443bf954591b7fa]
stable/4.19: [1c3d4901fad1db6a4e2dcdd6b13ed0ea22f227a1]
stable/5.10: [28d190882ba55cbcee1db8e4ae90c149178dcf64]
stable/5.15: [dccbd062d71657648efc32fdc9919b33763cc68b]
stable/5.4: [4abcd352a0222cc807f6f87d2f58d59aeeb70340]
stable/6.1: [5e7f6e2ade57dfd6d133ff7c643abd2079248943]

CVE-2023-3212: NULL pointer dereference in gfs2_evict_inode() in fs/gfs2/su=
per.c

CVSS v3 score is not provided.

A Null pointer dereference bug was found in the gfs2 file system=E3=80=80wh=
ere
the evict code attempts to reference the freed and NULL-ified journal
descriptor structure (jdesc).
The vulnerability arises from a sequence of events that includes the
freeing of journals and the subsequent reference to the now
freed/zeroed sd_jdesc pointer.

It was fixed in 6.4-rc2.

Fixed status
mainline: [504a10d9e46bc37b23d0a1ae2f28973c8516e636]
stable/5.10: [d03d31d3a206093b9b8759dddf0ba9bd843606ba]
stable/5.15: [fd8b4e28f400a067e6ef84569816967be1f0642b]
stable/6.1: [5ae4a618a1558d2b536fdd5d42e53d3e2d73870c]
stable/6.3: [14c454764a37b194dc916c07488ce7339c82bc4f]

* Updated CVEs

CVE-2022-48425: fs/ntfs3: Validate MFT flags before replaying logs

The stable/6.1 was fixed.

Fixed status
mainline: [98bea253aa28ad8be2ce565a9ca21beb4a9419e5]
stable/5.15: [2a67f26f70ab344ae6ea78638890eebc1191a501]
stable/6.1: [a8eaa9a06addbd9cb0238cb1c729921ecbb6504c]
stable/6.3: [e6f4b1c32d6d6047958d7700d12fed6d91f441e7]

CVE-2023-1838: Fix double fget() in vhost_net_set_backend()

The stable/4.14 was fixed.

Fixed status
mainline: [fb4554c2232e44d595920f4d5c66cf8f7d13f9bc]
stable/4.14: [d1bcb0ab20980c6da663708c9a47c322703f9fc3]
stable/4.19: [6ca70982c646cc32e458150ee7f2530a24369b8c]
stable/5.10: [ec0d801d1a44d9259377142c6218885ecd685e41]
stable/5.15: [42d8a6dc45fc6619b8def1a70b7bd0800bcc4574]
stable/5.4: [3a12b2c413b20c17832ec51cb836a0b713b916ac]

CVE-2023-2007: Linux Kernel DPT I2O Controller Time-Of-Check
Time-Of-Use Information Disclosure Vulnerability

Stable 4.19 and 5.10 were fixed.

Fixed status
mainline: [b04e75a4a8a81887386a0d2dbf605a48e779d2a0]
stable/4.19: [1b88816a9499608c736e192e0f442e65d4b71de1]
stable/5.10: [a2cd7599b558d6c70c01880d470f6eedaf6a8f23]

CVE-2023-2124: OOB access in the Linux kernel's XFS subsystem

Stable 6.1 and 6.3 were fixed.

Fixed status
mainline: [22ed903eee23a5b174e240f1cdfa9acf393a5210]
stable/5.10: [0e98a97f772f2ffcee8ced7a49b71e72916e0aa1]
stable/5.15: [6cfe9ddb6aa698464fa16fb77a0233f68c13360c]
stable/6.1: [a2961463d74f5c86a8dda3b41c484c28ccc4c289]
stable/6.3: [69ebe82c73f4f9f4b49ed3b35ce347af20716d0a]

CVE-2023-31084: BUG: WARNING in dvb_frontend_get_event

All stable kernels were fixed.

Fixed status
mainline: [b8c75e4a1b325ea0a9433fa8834be97b5836b946]
stable/4.14: [72197f21d9a6c47286a57d323f6858fbed1d0f77]
stable/4.19: [f3b5442184a0dab5cee9b2682f947393569e24b2]
stable/5.10: [ca2d171fd1f3ea03198b8775443d2767301dce9b]
stable/5.15: [22fc36d59eab8e0bcc8ef72bba2363285784ac74]
stable/5.4: [66a6d704c251aac864b69ae094a7579e0837eec9]
stable/6.1: [d0088ea444e676a0c75551efe183bee4a3d2cfc8]
stable/6.3: [47dc2e5f5fb45aff7f9c32f10412125ee13cb5ce]

CVE-2023-34255: xfs: verify buffer contents when we skip log replay

Stable 6.1 and 6.3 were fixed.

Fixed status
mainline: [22ed903eee23a5b174e240f1cdfa9acf393a5210]
stable/5.10: [0e98a97f772f2ffcee8ced7a49b71e72916e0aa1]
stable/5.15: [6cfe9ddb6aa698464fa16fb77a0233f68c13360c]
stable/6.1: [a2961463d74f5c86a8dda3b41c484c28ccc4c289]
stable/6.3: [69ebe82c73f4f9f4b49ed3b35ce347af20716d0a]

CVE-2023-3111: btrfs: unset reloc control if transaction commit fails
in prepare_to_relocate()

Stable 4.14, 4.19, 5.4, and 5.10 were fixed.

Fixed status
mainline: [85f02d6c856b9f3a0acf5219de6e32f58b9778eb]
stable/4.14: [ff0e8ed8dfb584575cffc1561f17a1d094e8565b]
stable/4.19: [dcb11fe0a0a9cca2b7425191b9bf30dc29f2ad0f]
stable/5.10: [b60e862e133f646f19023ece1d476d630a660de1]
stable/5.15: [78f8c2370e3d33e35f23bdc648653d779aeacb6e]
stable/5.4: [8e546674031fc1576da501e27a8fd165222e5a37]

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
      :masami.ichikawa@miraclelinux.com

