Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49BBC433EF
	for <webhook@archiver.kernel.org>; Thu, 12 May 2022 00:16:19 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.1271.1652314570975402283
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 May 2022 17:16:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=IA8VrXBN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.51,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f51.google.com with SMTP id
 a22-20020a9d3e16000000b00606aeb12ab6so1584984otd.7
        for <cip-dev@lists.cip-project.org>;
 Wed, 11 May 2022 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=K1M1/365pPqT4kqbBC9Gasli/bzk8gynos/oc17in3s=;
        b=IA8VrXBN5Xx21/7Hf4rs5qQFXAzMJ6w6XGUdP2UokZl8vEUFVZuww4f82jDhs4XYBz
         3ix2CsoJWkqXhhG5ipTyxDjDqU3cdgumrGNuXr2zHEIs50DY6jxf1EItRZ87Di9wQ/gI
         vfqk+gCyLd4DHa8ajuBAaTjWzt4XlBDdWfMdthZg9S1ARLbspkca8IbwbMdW1kqRIkKt
         Rvizldp0PTFShlJhk9ROm110/Fuhu77GY0k5RTqxevG3fi0H31aKbWlkNTkfJPigbKM4
         X4uqbutBASBp/jEejhPVqGH8mM57J/PQ2c9o5ZGX8kvBpu+O1cNtBO+XfCRRkiqzadmH
         vEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K1M1/365pPqT4kqbBC9Gasli/bzk8gynos/oc17in3s=;
        b=N0hR/5kvO9vunraInOIsUTHQ7m1DScckW0qPZH3ZUcNoNS8Zx48lvKHdVHeNBG9bd5
         ou96ZlILS5Dbf50z39PxZUTcTMeLeQG6FFsMDwR+4I3t+8Vy7kMkMPG+e3GNwLDxZmXw
         czMA3nzzwsDf+XKKCk/+UTmpXtgSZKJhE1AXX1GPlKQR5l4/0Ln45SjTfAIRapfOJE2J
         lnzuN4nwhI1SoIneOECWKILtY0vM8bWRBXT/RmpIgEZW1QEdUO6SYsoDLvPs+d+H9qnE
         Jc8c4Z6iQ0KPO5vU+dKtPiciQblKQC255vCyNV8g9+M3gABeRncNJmIL5FsBXXxstxPU
         etrQ==
X-Gm-Message-State: AOAM531gwHh6qXKaL53BTfLEZo+dGVs6418ZLyZMtSmwMFEAz9bdGUSj
	sjOaSQacQWCNIVjYTBiRYW0w7ihlbdPcxJ4b1mw7znslALNjZQ==
X-Google-Smtp-Source: 
 ABdhPJxoAL8CgUgqHZb9O5FWxY7kj2nmMy4jYjWyn8RE9AOPiWUgH+H4Pm1eKZX45EUOFBZXcWygzewptCLySLKIzSY=
X-Received: by 2002:a9d:5c8b:0:b0:606:4ec:6b9b with SMTP id
 a11-20020a9d5c8b000000b0060604ec6b9bmr10213165oti.336.1652314569852; Wed, 11
 May 2022 17:16:09 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 May 2022 09:15:33 +0900
Message-ID: 
 <CAODzB9r6O+QY+jcLESe_DHasB-bg1YsemSpbfkaA2jO+57vUFg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 May 2022 00:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8323

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 2 updated CVEs.
There were no critical vulnerabilities this week.

* New CVEs

CVE-2021-26401: The speculative execution window of AMD LFENCE/JMP
mitigation (MITIGATION V2-2) may be large enough to be exploited on
AMD CPUs.

CVSS v3 score is 5.6 MEDIUM.

To mitigate CVE-2017-5715(Spectre Variant 2) wasn't sufficient on some AMD CPUs.
Affected CPUs are listed on the web
page(https://www.amd.com/en/corporate/product-security/bulletin/amd-sb-1036).

All stable kernels have fixed this issue. cip/4.19 and cip/5.10 have
been fixed too.

Fixed status

mainline: [244d00b5dd4755f8df892c86cab35fb2cfd4f14b]
stable/4.14: [85938688be23ecd36a06757096896b2779b80d97]
stable/4.19: [d3cb3a6927222268a10b2f12dfb8c9444f7cc39e]
stable/4.9: [b6a1aec08a84ccb331ce526c051df074150cf3c5]
stable/5.10: [2fdf67a1d215574c31b1a716f80fa0fdccd401d7]
stable/5.15: [a56566d7a957c34811384d6300a53a97be94cd20]
stable/5.4: [b1bacf22a847d21a12900bd6a1eacaecb5bca253]

CVE-2022-1012: secure_seq: use the 64 bits of the siphash for port
offset calculation

CVSS v3 score is not assigned.

A memory leak issue was found in secure_ipv4_port_ephemeral() and
secure_ipv6_port_ephemeral().
Commit 7cd23e5 ("secure_seq: use SipHash in place of MD5") is
referenced as the cause of this bug. This commit was merged in
4.11-rc1.
This bug was fixed in 5.18-rc6.

Fixed status

mainline: [b2d057560b8107c633b39aabe517ff9d93f285e3]

CVE-2022-1651: virt: acrn: fix a memory leak in acrn_dev_ioctl() in
drivers/virt/acrn/hsm.c.

CVSS v3 score is not assigned.

A memory leak bug was found in acrn_dev_ioctl() in
Commit 9c5137a ("virt: acrn: Introduce VM management interfaces") and
2ad2aae ("virt: acrn: Introduce an ioctl to set vCPU registers state")
are cause of this issue. Both commits were merged in 5.12-rc1-dontuse.

This bug was fixed in 5.18-rc1.

Fixed status

mainline: [ecd1735f14d6ac868ae5d8b7a2bf193fa11f388b]
stable/5.15: [1d5103d9bb7d42fc220afe9f01ec6b9fe0ea5773]
stable/5.17: [f8e6e18d117e461110c849a11c6a396dcccdbd4e]

CVE-2022-1652: A concurrency use-after-free in bad_flp_intr

CVSS v3 score is not assigned.

An UAF bug was found in the floppy driver. When after freeing an
object in floppy_end_request(), reset_interrupt() still holds the
freed object.

Fixed status

Not fixed yet.

* Updated CVEs

CVE-2022-1195: kernel: A possible race condition (use-after-free) in
drivers/net/hamradio/6pack ( mkiss.c) after unregister_netdev

5.4 kernel was fixed this week.

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
stable/5.4: [ef5f7bfa19e3fc366f4c6d1a841ceaddf7a9f5d4,
7361a35bf33064da203e521357acc4fccb8927e5,
  c9af90f0c6b8c461426abfe50f495dc5608399ba,
a5c6a13e9056d87805ba3042c208fbd4164ad22b]

CVE-2022-29968: io_uring: fix uninitialized field in rw io_kiocb

5.17 was fixed this week.

Fixed status

mainline: [32452a3eb8b64e01e2be717f518c0be046975b9d]
stable/5.17: [77089e6ff273f43c42e99a690ae45ee39a6a62de]

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

