Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA27C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 22:52:43 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.3180.1702507959817028831
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Dec 2023 14:52:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=fdUHMmfO;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6d855efb920so6025402a34.1
        for <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 14:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1702507958; x=1703112758; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y62u5uliXd4hBbkhAd9CtyZ1jemPzrmo2xlmRBxn9m0=;
        b=fdUHMmfO3F4S1SNCHti9vpj3Ex4CikByvy8G6YZ78R7yctSI/LvRjanUjA/2HKk0if
         DcMycyyV+11vzkSRZXIKJh6w+sQuMCqEPC+npuadgb7ZBleu7pnYZvkpcu6TYj9NiXfv
         Wbt+Prx2ikiP3L8ONv5AvYULsUV6tCCY2B/OEa/OxVzHUfqn6NfZHnJQkyA+C/jQ4/uP
         6PvbqFSTxBRV+dEbOZpZOdHqSJYp8FB+h+6iIN3idFSVXylYx8tr41tffpzctUwu4AZR
         Is48FiR/l9zxVsiW8WimyICEifM7dwfxV/BYUad3RorFVaincjywy9tq6R5CDYezZ2tX
         Oqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507958; x=1703112758;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y62u5uliXd4hBbkhAd9CtyZ1jemPzrmo2xlmRBxn9m0=;
        b=Br2HXFJ3Kb0JIeIPEvZmY3YTx73mJI7xqrlIQv0wMrTChH5PWU3gDaQS+udAkPbkAi
         D9secripxWpOW4aupE1VwsTqvyNE9YEQpuzDau80qKZ8fn08DT0Kzvet2re7fOc5NLHl
         7GsuxOSjMIdRUbUhPg7b46X4oC1ZwWwAD+9NhIIxuKb+j+hlvbatmgWEEfjecvD3OGwe
         ybJmaAS0TzriglZaWBs9rDz0MN61WHj8qSHKVGDqr3/rEG8k2aQHRXkinE+SxpWFQalq
         7UJfsVxjwxDQhDKEJLWowImjRAFAABNqW2Epv9dHgnY6zkkhbEhLRXDfSNwprDXdVHGy
         IuXA==
X-Gm-Message-State: AOJu0YwRPWxnQ+UFRsBa5jGYrtip49pyyfOWppD8f7Cq44ZZ+ypYU/i4
	oCOpS/KvT+GJ2w83C7C2lgzvUfdWJqbs8gOsYtBSnfaszzBJoZlhCX0=
X-Google-Smtp-Source: AGHT+IHRf3gwNrU3JwebMmK3jMuwmaNl05lNQ6EHDZpHpbRBbCgbRQ9syOwnSao3UO+hy+D7woHtmrY4bwc/hSETDQs=
X-Received: by 2002:a05:6871:9187:b0:1e9:badb:acaa with SMTP id
 ak7-20020a056871918700b001e9badbacaamr11166045oac.23.1702507958489; Wed, 13
 Dec 2023 14:52:38 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Dec 2023 07:52:02 +0900
Message-ID: <CAODzB9rz0OqgV+0vx_TfFuhhJ3HhCPnrYKMHy8LCVfeBf3mALQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 22:52:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14071

Hi!

It's this week's CVE report.

This week reported 9 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-6560: io_uring out of boundary memory access in __io_uaddr_map()

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.5 (MEDIUM)

An oob access vulnerability was found in the io_uring subsystem. There
is incorrect mapped page check when pages are not continuous. The
check logic checks the first and last page so if pages are not
continuous,  it results will do out of boundaries memory access.

This bug was introduced by commit 03d89a2 ("io_uring: support for user
allocated memory for rings/sqes") in 6.5-rc1.
It has been fixed in 6.7-rc4. The commit 03d89a2 is not backported to
stable kernels.

Fixed status
mainline: [820d070feb668aab5bc9413c285a1dda2a70e076]
stable/6.6: [4be625ba36bcfdfb9c72b712acd4ef943a269ebb]

CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.1 (HIGH)

An out-of-bounds read vulnerability was found in smbCalcSize in
fs/smb/client/netmisc.c in the Linux Kernel. This issue could allow a
local attacker to crash the system or leak internal kernel
information.

Fixed status
Not fixed yet.

CVE-2023-6610: OOB Access in smb2_dump_detail

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.1 (HIGH)

An out-of-bounds read vulnerability was found in smb2_dump_detail in
fs/smb/client/smb2ops.c in the Linux Kernel. This issue could allow a
local attacker to crash the system or leak internal kernel
information.

Fixed status
Not fixed yet.

CVE-2023-6622: netfilter: nf_tables: bail out on mismatching dynset
and set expressions

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.5 (MEDIUM)

A null pointer dereference vulnerability was found in
nft_dynset_init() in net/netfilter/nft_dynset.c in nf_tables in the
Linux kernel. This issue may allow a local attacker with CAP_NET_ADMIN
user privilege to trigger a denial of service.

This bug was introduced by commit 48b0ae0 ("netfilter: nftables:
netlink support for several set element expressions") in 5.11-rc1 so
prior to 5.11 kernels are not affected.

Fixed status
mainline: [3701cd390fd731ee7ae8b8006246c8db82c72bea]
stable/5.15: [cf5f113c41eb2c7dbe19d849a0883f7a429fa54b]
stable/6.1: [96f8654b701f772af5f358b91807ce2836ff3444]
stable/6.6: [5eeba00a89c5c6be4e45b69bef20d1d1b9edb968]

CVE-2023-50431: habanalabs: fix information leak in sec_attest_info()

CVSS v3(NIST): 5.5 (MEDIUM)
CVSS v3(CNA): N/A

sec_attest_info in drivers/accel/habanalabs/common/habanalabs_ioctl.c
in the Linux kernel through 6.6.5 allows an information leak to user
space because info->pad0 is not initialized.

Patch is available on the dri-devel list
(https://lists.freedesktop.org/archives/dri-devel/2023-November/431772.html)
but it hasn't been merged into the mainline yet.

Fixed status
Not fixed yet.

CVE-2023-6679: dpll: sanitize possible null pointer dereference in
dpll_pin_parent_pin_set()

CVSS v3(NIST): 5.5 (MEDIUM)
CVSS v3(CNA): 4.4 (MEDIUM)

A null pointer dereference vulnerability was found in
dpll_pin_parent_pin_set() in drivers/dpll/dpll_netlink.c in the
Digital Phase Locked Loop (DPLL) subsystem in the Linux kernel. This
issue could be exploited to trigger a denial of service.

Patch is available on the netdev mailing list
(https://lore.kernel.org/netdev/20231211083758.1082853-1-jiri@resnulli.us/)
but it hasn't been merged yet.
This bug was introduced by commit 9d71b54b65b1 ("dpll: netlink: Add
DPLL framework base functions") in 6.7-rc1.

Fixed status
Not fixed yet.

CVE-2023-6356: NULL pointer dereference in nvmet_tcp_build_iovec

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

According to the Redhat Bugzilla, it describes that "There's a flaw in
Linux kernel's NVMe driver where an attacker can send crafted TCP
packets leading to NULL point dereference in nvmet_tcp_build_iovec. A
successfully attack can result in a remote Denial-of-service."

Fixed status
Not fixed yet.

CVE-2023-6535: NULL pointer dereference in nvmet_tcp_execute_request

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

According to the Redhat Bugzilla, it describes that "There's a flaw in
Linux kernel's NVMe driver where an attacker can send crafted TCP
packets leading to NULL point dereference in nvmet_tcp_build_iovec. A
successfully attack can result in a remote Denial-of-service."

Fixed status
Not fixed yet.

CVE-2023-6536: NULL pointer dereference in __nvmet_req_complete

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

According to the Redhat Bugzilla, it describes that "There's a flaw in
Linux kernel's NVMe driver where an attacker can send crafted
NVMe-oF/TCP packets leading to NULL point dereference in
__nvmet_req_complete. A successfuly attack can result in a remote
Denial-of-service."

Fixed status
Not fixed yet.

* Updated CVEs

CVE-2023-25775: improper access control flaw in RDMA driver

stable 4.14, 4.19, 5.10, and 5.4 were fixed.

Fixed status:
mainline: [bb6d73d9add68ad270888db327514384dfa44958]
stable/4.14: [92f871191e0bcb35dff37815579f15cac329955c]
stable/4.19: [f3c2760510c119c609e751c5a0b06cec6ae4bb4d]
stable/5.10: [ac65f8979b0eaac80c4710729c509d8837d8fdb7]
stable/5.4: [518b7f7d87aa87cf5173a937baa9a93fc6ed3d6d]
stable/6.1: [f01cfec8d3456bf389918eb898eda11f46d8b1b7]
stable/6.4: [ceba966f1d6391800cab3c1c9ac1661b5166bc5b]
stable/6.5: [782c5702b933477b088e80e6d07b9493145b2916]

CVE-2023-45898: ext4: fix slab-use-after-free in ext4_es_insert_extent()

stable 5.10 and 5.4 were fixed.

Fixed status
mainline: [768d612f79822d30a1e7d132a4d4b05337ce42ec]
stable/5.10: [10341e77e49fab3e095ae548ceb39335741b8fe9]
stable/5.15: [e33eb4997585f2e17513e3f2923080dc08cbb00b]
stable/5.4: [70edeedd795a634fdd99e757c7931b9e81686560]
stable/6.1: [8384d8c5cc398cf59ab829d71d750752002f0a21]
stable/6.5: [c15bf3330a9e3c01b23e59899a6a02432a62ddc3]

CVE-2023-6121: nvmet: nul-terminate the NQNs passed in the connect command

stable 5.10 and 5.4 were fixed.

Fixed status
mainline: [1c22e0295a5eb571c27b53c7371f95699ef705ff]
stable/5.10: [2be451e7a2f124899546c1bb5c6d509a927968c8]
stable/5.15: [e26c6febac43a2dd2c5fb993b2137489005d43bf]
stable/5.4: [afbedd6136cbff0b4412efd09d98d2cb7348563c]
stable/6.1: [0e485f12ebb7b69b67c7f85195a1b4aad95d354a]
stable/6.6: [2291653c27236d34ca7df3bfd3427ce6e30c2d95]

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

