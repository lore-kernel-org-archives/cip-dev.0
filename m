Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC4C4707B
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 22:53:38 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web11.7873.1704927212799839185
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jan 2024 14:53:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=WWBAI/wS;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dddc655a60so1725990a34.2
        for <cip-dev@lists.cip-project.org>; Wed, 10 Jan 2024 14:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1704927212; x=1705532012; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nr7+CqQqqa81rETCgk4JNRkxpt/0cxTYlpIz7aLpTGE=;
        b=WWBAI/wSZCculD/fDR3TzlOq6dDicmZlBryZ2c/NeSCLJF3MJYf/hTItRUrmQKspD/
         c5RGgb7KVaDv10uyczDDtiovTZO4/a2Uq1lnc4QXLgUod/1N//15dWj8QVatCtVKl4Qy
         JJNBO/R2hRP9/iHNycNUbZGBchkVQE5jXIU3wYKapwtBQuuSBKoX10I+ekW4KRZcSUQK
         PaoXrm8IooZRf9dzDVwqBxeiXYzz8swTq7oM0kQYuNH3u/dlzP9RfNs9WH+nPwUvCdSX
         tMFWXvdAMVdm9uA7a7lsMIQdwh0VottTv3mJc4zhAw1Pi9mCkhBrqkKnvIrsXCvl4Is4
         YlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704927212; x=1705532012;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nr7+CqQqqa81rETCgk4JNRkxpt/0cxTYlpIz7aLpTGE=;
        b=EfoLcy6MofOLJxzrvMAAd56zkce4kg0aID9F1V+csEz+EUMf7EUa7kwCX++BUa+/Fm
         evbheTg615YCdDzr1pK34GHAFdLvDH+y+S5CSkrGucIX5nyromhGfu7jUrROtczSpfSR
         2adtsSnHyeFM9sa3h8iyIbTawIoqPNfleCxKe75EgBjYU4yNaWXRBjlqEey0LLfdc6Ft
         smbUyUUuU29qS9MfuMWOCG9bs+/wIUpjYi93Sxn1Ghm0viSyOB/qk/T6dpSFH3eAz9EV
         0zC2o0HSQOSOn1CUoYebVOwQ7fW3xGzL0yQuI/ePhda7OjMpWxQP2Xk3ot0BNPGLiVyl
         36HQ==
X-Gm-Message-State: AOJu0YzgcjqEemrOn7C8StU4RFR9pyZabkJiVg9URaq6WTs+3+ouArC2
	oxNsqclhdMqXVkxvunf52K7EJ6nv1P7c+vcCffcG2473TT2BkfKOIS7RKYBVy98=
X-Google-Smtp-Source: AGHT+IEBJbHsEdhQZ9swHNIQklswRamSykZrQqimvg8aJBz1ZOhmJNitJ/6vI2OvaSznnA73c1sq+MQGH1mgd5bSZ4Y=
X-Received: by 2002:a05:6871:3187:b0:206:85bf:bea4 with SMTP id
 lv7-20020a056871318700b0020685bfbea4mr258501oac.93.1704927211665; Wed, 10 Jan
 2024 14:53:31 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Jan 2024 07:52:55 +0900
Message-ID: <CAODzB9ppqh8iyeUZYmS7L5KXkai-Ds=csLYRb56tM76zX89UCw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jan 2024 22:53:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14327

Hi!

It's this week's CVE report.

This week reported 2 new CVEs and 4 updated CVEs.

* New CVEs

CVE-2023-6270: AoE: improper reference count leads to use-after-free
vulnerability

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.0 (HIGH)

A flaw was found in the ATA over Ethernet (AoE) driver in the Linux
kernel. The aoecmd_cfg_pkts() function improperly updates the refcnt
on `struct net_device`, and a use-after-free can be triggered by
racing between the free on the struct and the access through the
`skbtxq` global queue. This could lead to a denial of service
condition or potential code execution.

Fixed status
Not fixed yet

CVE-2024-0228: netfilter: nf_tables: skip set commit for deleted/destroyed sets

This CVE was rejected because of a duplicate of CVE-2024-0193.

CVE-2024-0340: vhost: use kzalloc() instead of kmalloc() followed by memset()

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.4 (MEDIUM)

A vulnerability was found in vhost_new_msg in drivers/vhost/vhost.c in
the Linux kernel, which does not properly initialize memory in
messages passed between virtual guests and the host operating system
in the vhost/vhost.c:vhost_new_msg() function. This issue can allow
local privileged users to read some kernel memory contents when
reading from the /dev/vhost-net device file.

The vhost_new_msg() was introduced by commit 6b1e6cc ("vhost: new
device IOTLB API ") in 4.8-rc1. The memset() was added by commit
670ae9c ("vhost: fix info leak due to uninitialized memory") in
4.18-rc1.
The vhost_new_msg() doesn't exist in Linux 4.4.

Fixed status
mainline: [4d8df0f5f79f747d75a7d356d9b9ea40a4e4c8a9]

* Updated CVEs

CVE-2023-1193: use-after-free in setup_async_work()

stable 6.1 was fixed.

Fixed status
mainline: [3a9b557f44ea8f216aab515a7db20e23f0eb51b9]
stable/5.15: [9494242c8e76e6a98c8ab5f6aed0fa4bd56ac6d5]
stable/6.1: [8d271ef5e5cac8a470076891b248a28a2c57fb1e]

CVE-2023-51779: Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [2e07e8348ea454615e268222ae3fc240421be768]
stable/5.10: [db1b14eec8c61a20374de9f9c2ddc6c9406a8c42]
stable/5.15: [2b16d960c79abc397f102c3d23d30005b68cb036]
stable/6.1: [37f71e2c9f515834841826f4eb68ec33cfb2a1ff]
stable/6.6: [1d576c3a5af850bf11fbd103f9ba11aa6d6061fb]

CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize

stable 4.19, 5.4, 5.10 and 5.15 were fixed.

Fixed status
mainline: [b35858b3786ddbb56e1c35138ba25d6adf8d0bef]
stable/4.19: [89b6ae907c6bcc175bc95a67d6936217530a29ff]
stable/5.10: [0c54b79d1d9b25f5a406bcf1969f956e14c4704d]
stable/5.15: [ded3cfdefec8b2accc767f176419316b61c157c3]
stable/5.4: [508e2fdd978e4c26798eac2059f9520255904f82]
stable/6.1: [c60e10d1549f8748a68ec13dcd177c62843985ff]
stable/6.6: [ac48fcef5ec2e9ac85c0b39045d874e60eac75d7]


CVE-2024-0193: netfilter: nf_tables: skip set commit for deleted/destroyed sets

The mainline, stable 5.10, 5.15, 6.1, and 6.6 were fixed.

Fixed status
mainline: [7315dc1e122c85ffdfc8defffbb8f8b616c2eb1a]
stable/5.10: [73117ea03363d4493bd4e9f82f29b34b92d88a91]
stable/5.15: [d10f7540c5541ad9f4fe2a02a73153d25d4a540d]
stable/6.1: [0105571f80edb96f81bb4bbdd5233a9130dc345b]
stable/6.6: [b7f1c01b55ad2a5da12f08e5ec3c76dabb99882a]

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

