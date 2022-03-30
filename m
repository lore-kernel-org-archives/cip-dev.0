Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF75EC433EF
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 23:23:01 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web09.808.1648682580498967617
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 16:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=0n7vZAmv;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id v75so23707087oie.1
        for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 16:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=51ZkBrZ7gzX81csGexOZFaMdd8EQUizNRaywgSDgYJs=;
        b=0n7vZAmvs0IuWATQV4YW0uEFlMGHmzvf1V/ZAN0NVKPds2thKArGxpLSSWZbNuMn0R
         s15QP38+nHiP8zNmnKIRWans4CXCJjXsQACaeVkqO0fLkOmjkYNFNcLNhaeHdIXarSp5
         tzp0hC90gvDmPihHnfjUU63vXeHCGG27O8gIYEgpGcvQ8K04p+J0xm2jE9Js9P0ZKB8j
         y+wvfzMxc9dp+JSDxQvpBQdkVXrgNFOwTxT2MKg7iH7Ht46k41kYsE1g6TbUClUAXshv
         DBaGxJz7D1txBlZHhU1ZXASRd33+QPaduq8Y7r6Zdvc6f4AvhZL20IJO4XjOZDbxVgl/
         lPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=51ZkBrZ7gzX81csGexOZFaMdd8EQUizNRaywgSDgYJs=;
        b=5wq0r8Rp3hoED/S+kDyV+eqxlJUl+M2vOTXKb0LzhA7kXtn9rK3+G342W3UYxvH1Jb
         GtEAy8+WX6LoHFgB84Bim8AukXbecS6JEaXqJloil/9xuDgvGMDrFA9Iyo3+uperMDFK
         sDFbHL2ndt4boaIhGBwuRAaZPWWGP8/jxU8ZjcNF9/lqqOHIJOyVCoX74VG8oIGs6MkW
         +rpMMrdCA3mosRZEPaxQDWsNbPuRhcbNOJ6YFJQ/9GvEgHh1PD65/gskC4OnX5yi+XIr
         uLnqD8z1u3jnJXyPeO9QFy9ffc3EGB1luL6kQrVr27eIynxnF+gEKNSXWYd5+JQZlhim
         9d+w==
X-Gm-Message-State: AOAM531FuW+FnUkscLu3GX4rmsuQb/7evrTfM+gzAZVqzhlyyrCB2F+M
	zXkOw0hXFdyHVuGE8h1caG0pBmB+UHTFlsrwKFw8Yf9/Ft3ZCw==
X-Google-Smtp-Source: 
 ABdhPJxhFUrWb7qqWZu4e2CJQjgdJrfmHAclc2VWB+Np2hp3CpPF0CmmwmGZA91/qB964oCb1oZkcjQbqHZZDNBRkuA=
X-Received: by 2002:a54:4715:0:b0:2ec:f0e2:fc67 with SMTP id
 k21-20020a544715000000b002ecf0e2fc67mr1384768oik.87.1648682579383; Wed, 30
 Mar 2022 16:22:59 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 31 Mar 2022 08:22:23 +0900
Message-ID: 
 <CAODzB9q2v02kZa4_+uD0-H9FVk=bJu+x6E9ppkSKVkAGcs6KUQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 23:23:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7891

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 4 updated CVEs.

* New CVEs

CVE-2022-0168: smb2_ioctl_query_info NULL Pointer Dereference

CVSS v3 score is not provided

A local DoS issue was found in smb2_ioctl_query_info() . A local user
with privileged (CAP_SYS_ADMIN) can crash the system.
The smb2_ioctl_query_info() was introduced by commit f5b05d6 ("cifs:
add IOCTL for QUERY_INFO passthrough to userspace") which was merged
in 4.20-rc1.

Fixed status

Not fixed yet.

CVE-2022-1055: net: sched: fix use-after-free in tc_new_tfilter()

CVSS v3 score is 6.3 MEDIUM

An UFA bug was found in tc_new_tfilter().
This issue was introduced by commit 470502d ("net: sched: unlock rules
update API") which was merged in 5.1-rc1.
The mainline and stable kernels were fixed.

Fixed status

mainline: [04c2a47ffb13c29778e2a14e414ad4cb5a5db4b5]
stable/5.10: [e7be56926397cf9d992be8913f74a76152f8f08d]
stable/5.15: [f36cacd6c933183c1a8827d5987cf2cfc0a44c76]
stable/5.16: [95e34f61b58a152656cbe8d6e19843cc343fb089]
stable/5.4: [b1d17e920dfcd4b56fa2edced5710c191f7e50b5]

CVE-2022-1048: race condition in snd_pcm_hw_free leading to use-after-free

CVSS v3 score is not provided

An UFA bug was found in the ALSA pcm module. This bug can be the cause
of system crash or privilege escalation by a local user.

Applying patches to 4.4, it needs to be modified.

Fixed status

mainline: [92ee3c60ec9fe64404dc035e7c41277d74aa26cb,
dca947d4d26dbf925a64a6cfb2ddbc035e831a3d,
  3c3201f8c7bb77eb53b08a3ca8d9a4ddc500b4c0,
69534c48ba8ce552ce383b3dfdb271ffe51820c3]
stable/5.10: [0f6947f5f5208f6ebd4d76a82a4757e2839a23f8,
8527c8f052fb42091c6569cb928e472376a4a889,
  a38440f006974e693f92a1ea10f819eccc4dcc37,
b560d670c87d7d40b3cf6949246fa4c7aa65a00a]
stable/5.15: [33061d0fba51d2bf70a2ef9645f703c33fe8e438,
47711ff10c7e126702cfa725f6d86ef529d15a5f,
  cb6a39c5ebd0a125c420c5a10999813daaece019,
51fce708ab8986a9879ee5da946a2cc120f1036d]
stable/5.16: [0090c13cbbdffd7da079ac56f80373a9a1be0bf8,
4d1b0ace2d56dc27cc4921eda7fae57f77f03eb5,
  e1ff3a347ed1531eec40a24c47eab15f0efbf835,
a21d2f323b5a978dedf9ff1d50f101f85e39b3f2]
stable/5.17: [1bbf82d9f961414d6c76a08f7f843ea068e0ab7b,
dd2f8c684da3e226e5ec7a81c89ff5fd4a957a03,
    e9d05532252ec41d000021d3cf40f3a2084fd5f9,
5ed8f8e3c4e59d0396b9ccf2e639711e24295bb6]

CVE-2022-1015: OOB access bug in netfilter

CVSS v3 score is not provided

This issue leads to local privilege escalation.
This root cause was introduced by commit 49499c3 ("netfilter:
nf_tables: switch registers to 32 bit addressing") which merged in
4.1-rc.
However, it is exploitable by commit 345023b ("netfilter: nftables:
add nft_parse_register_store() and use it") which merged in
5.12-rc1-dontuse.
Therefore, earlier than 5.12 kernels have an OOB bug but they wouldn't
exploit via this bug.

Fixed status

mainline: [6e1acfa387b9ff82cfc7db8cc3b6959221a95851]
stable/5.15: [1bd57dea456149619f3b80d67eee012122325af8]
stable/5.16: [2c8ebdaa7c9755b85d90c07530210e83665bad9a]
stable/5.17: [afdc3f4b81f0ec9f97f0910476af4620a2481a6d]

CVE-2022-1016: kernel information leak bug in netfilter

CVSS v3 score is not provided

There is an uninitialized stack in the nft_do_chain routine that can
lead to kernel information leak.
This bug was introduced by commit 9651851 ("netfilter: add nftables")
that was merged in 3.13-rc1.

For 4.4

Applying commit 4c905f has a merge conflict but is easy to fix.

Fixed status

mainline: [4c905f6740a365464e91467aa50916555b28213d]
stable/4.14: [a3cc32863b175168283cb0a5fde08de6a1e27df9]
stable/4.19: [88791b79a1eb2ba94e95d039243e28433583a67b]
stable/4.9: [4d28522acd1c4415c85f6b33463713a268f68965]
stable/5.10: [2c74374c2e88c7b7992bf808d9f9391f7452f9d9]
stable/5.15: [fafb904156fbb8f1dd34970cd5223e00b47c33be]
stable/5.16: [64f24c76dd0ce53d0fa3a0bfb9aeea507c769485]
stable/5.17: [dd03640529204ef4b8189fbdea08217d8d98271f]
stable/5.4: [06f0ff82c70241a766a811ae1acf07d6e2734dcb]

CVE-2022-27950: memory leak bug in drivers/hid/hid-elo.c

CVSS v3 score is not provided

A memory leak bug was found in elo_probe() in drivers/hid/hid-elo.c
when hid_parse() fails.
This bug was introduced by commit fbf4272 ("HID: elo: update the
reference count of the usb device structure") which was merged in
5.15-rc1. This bug exists between 5.15 to 5.16.11.

Fixed status

mainline: [817b8b9c5396d2b2d92311b46719aad5d3339dbe]
stable/5.15: [de0d102d0c8c681fc9a3263d842fb35f7cf662f4]
stable/5.16: [80dad7483e3940dc9d9d55f8b34d1f4ba85a505e]

* Updated CVEs

CVE-2021-4197: cgroup: Use open-time creds and namespace for migration
perm checks

stable/5.10 was updated this week.

Fixed status

mainline: [1756d7994ad85c2479af6ae5a9750b92324685af,
0d2b5955b36250a9428c832664f2079cbf723bec,
  e57457641613fef0d147ede8bd6a3047df588b95]
stable/5.10: [f28364fe384feffbe7d44b095ef4571285465c47,
824a950c3f1118eb06b1877c49ed1b2eca8e236d]
stable/5.15: [c6ebc35298848accb5e50c37fdb2490cf4690c92,
50273128d640e8d21a13aec5f4bbce4802f17d7d,
  43fa0b3639c5fd48c96b19d645d0c7ff2327651a]

CVE-2022-27666, CVE-2022-0886: esp: Fix possible buffer overflow in
ESP transformation

stable/4.14, stable/4.19, and stable/5.4 kernels were fixed this week.
All kernels are fixed.

Fixed status

mainline: [ebe48d368e97d007bfeb76fcb065d6cfc4c96645]
stable/4.14: [2c8abafd6c72ef04bc972f40332c76c1dd04446d]
stable/4.19: [ce89087966651ad41e103770efc5ce2742046284]
stable/5.10: [9248694dac20eda06e22d8503364dc9d03df4e2f]
stable/5.15: [4aaabbffc3b0658ce80eebdde9bafa20a3f932e0]
stable/5.16: [9afe83f62aac348db1facb28bfc106109a06e44d]
stable/5.4: [fee4dfbda68ba10f3bbcf51c861d6aa32f08f9e4]

CVE-2022-26490: nfc: st21nfca: Fix potential buffer overflows in EVT_TRANSACTION

stable kernels are fixed this week.

Fixed status

mainline: [4fbcc1a4cb20fe26ad0225679c536c80f1648221]
stable/4.14: [d908d2776464a8021a1f63eba6e7417fbe7653c9]
stable/4.19: [0043b74987acb44f1ade537aad901695511cfebe]
stable/4.9: [c1184fa07428fb81371d5863e09795f0d06d35cf]
stable/5.10: [25c23fe40e6e1ef8e6d503c52b4f518b2e520ab7]
stable/5.15: [a34c47b1ab07153a047476de83581dc822287f39]
stable/5.16: [0646efbb6e100a3f93eba3b6a10a7f4c28dd1478]
stable/5.4: [0aef7184630b599493a0dcad4eec6d42b3e68e91]

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

