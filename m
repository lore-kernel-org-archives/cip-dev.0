Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB7C4332F
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 22:56:40 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web10.107183.1699484191770223255
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Nov 2023 14:56:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Qa09/FhI;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f066fc2a28so118593fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 08 Nov 2023 14:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1699484191; x=1700088991; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPUrXBGCJ23vfjx9Grh1LeajzB8uWWVpmAo1YOlUPxo=;
        b=Qa09/FhIHSmIvxlvXjk2+AkMbjdXwjhcYbsrtg9dkwVYNVQSlft9Sc+HdpczM+0wGc
         nrSFHRty3dFUF+wAt0F8oQREZ2FlGsmNVXXATGwxd70f8R9H3qpuj+sXbPLh9EiWgXUC
         0wjl7o8j1p9AsMwVInB78+Bk9ZKUMcv3m5qB45VT8KqB1F+L9tPrDRZbV1D79N6D8E8l
         6Ek28BY4ZD/ITqMsjKA8KMEw/yQEicIfRsKFPWyWhk2GYGgU4UBMXVqhPO/SFYcEJdR+
         7GkQOP1LUXiGDHnRZA0Es57+061aqzgV/lqhrB7tfgTG9UO6gLVY2kIy/Kr0GHZPYm6Y
         59rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699484191; x=1700088991;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPUrXBGCJ23vfjx9Grh1LeajzB8uWWVpmAo1YOlUPxo=;
        b=Dz9FRiJvX//z7q70mz5ngPWt3DmMHNudfgM4fTBSvGLodaEyk10G/Qd0r/7NqQQ28I
         3oMEXdatUexfmdrSdmUrL/qep07c6CK9VpJ/TedVC/d1vzvg9/uG6j211xdFkish9XgU
         a3uX5kB4e6lmeSLucGETSVf9escfm5nA2z2Bc2Zw5+AL7sSzpmrunIVpqjv6BFlqVPok
         l881yW8iElwyLXmildEmeRjWVMsrk10Cv0PfpK1BraK1gHhcT1Sis1E0JxtZMJFdm9eS
         WNtnsHGm39GJKztxl7WHfYctzTfwzaWS1vdEnfts4CiAnjcePzjY24AkAiFSnpLW+HFj
         aE0Q==
X-Gm-Message-State: AOJu0YyPyD18HqqlouDkRhr4IzamoX+GB53c6XMH9iN5qOr3Iu2nb73m
	k9eT5x2qNiQcY+NNMsKl5u00lPkcIWGZuPFkaqSJO16EG3+3JPE08AI=
X-Google-Smtp-Source: AGHT+IHL2s8NK5wridi7jLWD6N+93EdBM8C+bp5p4Hh8RZQC9m8euAmvoi2DQJKTmNx6t/8y575axQRahZl7c8mAZGk=
X-Received: by 2002:a05:6870:1145:b0:1d5:f070:d518 with SMTP id
 5-20020a056870114500b001d5f070d518mr3011206oag.52.1699484190694; Wed, 08 Nov
 2023 14:56:30 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Nov 2023 07:55:54 +0900
Message-ID: <CAODzB9q1AOFqyaKhEpdFmFzpXj6vu8Ve4FhT3Q7Ra4VPJ=9JWw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Nov 2023 22:56:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13543

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 7 updated CVEs.

* New CVEs

CVE-2023-47233: Use after Free bug in brcmf_cfg80211_detach

CVSS v3(NIST): N/A

The brcm80211 component in the Linux kernel through 6.5.10 has a
brcmf_cfg80211_detach use-after-free in the device unplugging
(disconnect the USB by hotplug) code. For physically proximate
attackers with local access, this "could be exploited in a real world
scenario." This is related to brcmf_cfg80211_escan_timeout_worker in
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.

Introduced by commit e756af5 ("brcmfmac: add e-scan support.") in 3.7-rc1.

Fixed status
Not fixed yet

* Updated CVEs

CVE-2023-46862: io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

Stable 6.1 and 6.5 were fixed.

Fixed status
mainline: [7644b1a1c9a7ae8ab99175989bfc8676055edb46]
stable/6.1: [9236d2ea6465b37c0a73d994c1ad31753d31e5f5]
stable/6.5: [56e08ccc969796168f0e6adf6642f8546f54ba6f]

CVE-2023-5158: vringh: don''t use vringh_kiov_advance() in vringh_iov_xfer()

Fixed in mainline, 5.15, 6.1, and 6.5.

Fixed status
mainline: [7aed44babc7f97e82b38e9a68515e699692cc100]
stable/5.15: [1e69422efcc60571cc04f6c1940da848a8c2f21b]
stable/6.1: [3a72decd6b49ff11a894aabd4d9b3025f046fe61]
stable/6.5: [0bf2b9c2f3545ffce5720de61c33fc171c0e480a]

CVE-2021-44879: f2fs: fix to do sanity check on inode type during
garbage collection

Stable 4.14, 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [9056d6489f5a41cfbb67f719d2c0ce61ead72d9f]
stable/4.14: [a481db81e7ead1369acca8e13b6939778cb7d2c5]
stable/4.19: [45c9da086dded78a12bc580f5bb012545a910803]
stable/5.10: [571ce7d944cdd204da163cb5d5cc75bb38090246]
stable/5.15: [0ddbdc0b7f0cec3815ac05a30b2c2f6457be3050]
stable/5.16: [d667b9f61df7bdfcb59dd1406fd2392c358f0008]
stable/5.4: [e9a988cd4c8baac7550aa0c2f1efc9533ed9da36]

CVE-2023-3567: use-after-free in vcs_read in drivers/tty/vt/vc_screen.c

Stable 4.14 was fixed.

Fixed status
mainline: [226fae124b2dac217ea5436060d623ff3385bc34]
stable/4.14: [af79ea9a2443016f64d8fd8d72020cc874f0e066]
stable/4.19: [6332f52f44b9776568bf3c0b714ddfb0bb175e78]
stable/5.10: [55515d7d8743b71b80bfe68e89eb9d92630626ab]
stable/5.15: [fc9e27f3ba083534b8bbf72ab0f5c810ffdc7d18]
stable/5.4: [d0332cbf53dad06a22189cc341391237f4ea6d9f]
stable/6.1: [8506f16aae9daf354e3732bcfd447e2a97f023df]

CVE-2023-45863: kobject: Fix slab-out-of-bounds in fill_kobj_path()

Stable 4.14, 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [3bb2a01caa813d3a1845d378bbe4169ef280d394]
stable/4.14: [b43cf5ad5241d6f33a02c93271a282d5ed6c4cce]
stable/4.19: [0af6c6c15681cf80aeb85fcb3a1928c63aa89deb]
stable/5.10: [b2e62728b106fe54f8618c21a252df7d4a4cc775]
stable/5.15: [89a0079049f5568268d75c8cdf28bec0e2553e23]
stable/5.4: [5776aeee2a604ccc03e8269713624f9c8fd318e0]
stable/6.1: [fe4dd80d58ec5633daf5d50671d1341f738508bf]

CVE-2023-5090: x86: KVM: SVM: always update the x2avic msr interception

Stable 6.1 was fixed.

Fixed status
mainline: [b65235f6e102354ccafda601eaa1c5bef5284d21]
stable/6.1: [7ab62e3415fb59289ab6dea31f0cc0237b949200]
stable/6.5: [94805f9d3a3fb1f091bcc08b9c4846c4346706eb]

CVE-2023-5178: nvmet-tcp: Fix a possible UAF in queue intialization setup

Stable 5.4 was fixed.

Fixed status
mainline: [d920abd1e7c4884f9ecd0749d1921b7ab19ddfbd]
stable/5.10: [e985d78bdcf37f7ef73666a43b0d2407715f00d3]
stable/5.15: [34f62612be2a7f90ab68a14154db6664a32f8db0]
stable/5.4: [4e53bab11f01a401a5acd3bc94335b27ec79106b]
stable/6.1: [f691ec5a548257edb3aacd952e2a574e4e57b2c4]
stable/6.5: [675f0e9bb716fa3252979145b9b1a950140e94e9]

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

