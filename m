Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3363C072A2
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 22:48:59 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.27360.1700088539138191413
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 14:48:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=UW865yIA;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso81574fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 14:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1700088538; x=1700693338; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zHI8PylHmqMDMm6lqIePL9b9iJeMdEfJKEvZym8LXX4=;
        b=UW865yIA/bJim/d+aclN0Dgx6DrHvmwB3RIz6kbJ8+DoFHCKEYvYX68XD3hP4iMLv+
         R7+dRrbvYQF89zo8n21Ch7W5/iFcVpuYGb2XUCH1nUcPfYHVAffuNLp9tfIkwXPDuuYj
         OquM0bAQl/qiXmVL5rp9EBStcs86FkUP1rb+crPm83JeHl0Blh9cbrwmkYgar5vy5L9R
         Rhqase7G1H8Xft+CZmnZESm1HeHR/a8tMu+QZNdt1Lt/Gyie6MaQZHrybRTVhJzvvyNc
         kpFSWWimurrTP6+pTLmERdVdSx6up5vDsZM7gzGjJ4tzyQKiUqxaWJrCSqzKisdOLQc9
         t61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700088538; x=1700693338;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHI8PylHmqMDMm6lqIePL9b9iJeMdEfJKEvZym8LXX4=;
        b=U6pqx9iune/4hRguRbi16XGcsyc7Iw+p7dVanxemXP0VOljQVhqwmXb80rBYtP66nm
         Ngb0qMlvRLFNarMlRvhBek/H21fYVnxWAu6cPrG7FaFifxFWgi/ChH99FUUHkIC/fdMa
         17fDtkvIIZ722lORjOU7OaHR6rQ4Mlm06WY3KKHZ8+vCiR6BGB8j0Jy+/Lbo/nGvlRgd
         FsO0Kk0O7lwh62oafi1IQciF0Ei87H0aVhO8R0DUQ+4KeSIeM5McPI5RzTbP7l5LVh1X
         PGeL0g6j4GQYjuzWS9BuouIfnOH8FJPSP6u/JGOd62mFr2qjHSnvVgoPoQvBM2MKh2Rb
         Q93Q==
X-Gm-Message-State: AOJu0YwRNbDA8g0LILsh41JpVTMMKvlV2RexPrqhuMSUD5zcLRBpfAjL
	TYRDvi6MOXlXq17Ux/c6VKv4QyIYQxJfOMIKAVJJEnJiZwB6gMF7OW8=
X-Google-Smtp-Source: AGHT+IEqUBjc2QTar77L+yqpf4H4sqHsKtbeaKBdLy16nBq4lBGRKmKwM7Ti4AgS+h3BhbqH2hVbj49KRy2MOAbjK98=
X-Received: by 2002:a05:6870:d0cc:b0:1ef:d2b2:fe16 with SMTP id
 k12-20020a056870d0cc00b001efd2b2fe16mr14708670oaa.43.1700088538079; Wed, 15
 Nov 2023 14:48:58 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Nov 2023 07:48:21 +0900
Message-ID: <CAODzB9r5dW9fwvNexYe_+VpycEXpfJS7gbH_49V3oRicz2Z=ow@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 22:48:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13590

Hi!

It's this week's CVE report.

This week reported 4 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2023-39197: netfilter: conntrack: dccp: copy entire header to
stack buffer, not just basic one

CVSS v3(NIST): N/A

An out-of-bound access bug was found in the netfilter conntrack
feature. This vulnerability will expose sensitive information via DCCP
protocol to remote user.
This bug was introduced by commit 2bc7804 ("[NETFILTER]: nf_conntrack:
add DCCP protocol support") in 2.6.26-rc1.

Fixed status
mainline: [ff0a3a7d52ff7282dbd183e7fc29a1fe386b0c30]
stable/5.10: [9bdcda7abaf22f6453e5b5efb7eb4e524095d5d8]
stable/5.15: [c052797ac36813419ad3bfa54cb8615db4b41f15]
stable/5.4: [337fdce450637ea663bc816edc2ba81e5cdad02e]
stable/6.1: [26bd1f210d3783a691052c51d76bb8a8bbd24c67]

CVE-2023-39198: drm/qxl: fix UAF on handle creation

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.5 (HIGH)

A race condition was found in the QXL driver in the Linux kernel. The
qxl_mode_dumb_create() function dereferences the qobj returned by the
qxl_gem_object_create_with_handle(), but the handle is the only one
holding a reference to it. This flaw allows an attacker to guess the
returned handle value and trigger a use-after-free issue, potentially
leading to a denial of service or privilege escalation.

Fixed status
mainline: [c611589b4259ed63b9b77be6872b1ce07ec0ac16]
stable/5.15: [d578c919deb786b4d6ba8c7639255cb658731671]
stable/6.1: [a1fa8f0fc58e0ec972f718030710efc442d7304b]

CVE-2023-6039: net: usb: lan78xx: reorder cleanup operations to avoid UAF bugs

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.5 (MEDIUM)

A use-after-free flaw was found in lan78xx_disconnect in
drivers/net/usb/lan78xx.c in the network sub-component,
net/usb/lan78xx in the Linux Kernel. This flaw allows a local attacker
to crash the system when the LAN78XX USB device detaches.

Introduced by commit 77dfff5 ("lan78xx: Fix race condition in
disconnect handling") in 5.15-rc1. Prior to 5.15 kernels are not
affected.

Fixed status
mainline: [1e7417c188d0a83fb385ba2dbe35fd2563f2b6f3]

CVE-2023-6111: netfilter: nf_tables: remove catchall element in GC sync path

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

This bug was introduced by commit 4a9e12e ("netfilter: nft_set_pipapo:
call nft_trans_gc_queue_sync() in catchall GC") in 6.6-rc3.
This commit was backported to 5.15, 6.1, and 6.5 so that prior to 5.15
are not affected.

Fixed status
mainline: [93995bf4af2c5a99e2a87f0cd5ce547d31eb7630]

* Updated CVEs

No update.

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

