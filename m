Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC7AC636D6
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 23:19:54 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web11.8485.1676503183828642215
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Feb 2023 15:19:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=lFf0oRpT;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.174, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f174.google.com with SMTP id bh15so78272oib.4
        for <cip-dev@lists.cip-project.org>; Wed, 15 Feb 2023 15:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOSaQSpaF4AeWQZou9544VTh/gl9tQJsiv/YhpeTdjA=;
        b=lFf0oRpTwL8IbS2bUf4/l9McynfuZf7COExYbrsagrVv7pci9zyxTbMe9ELYJnSGtr
         95LE3ucdIBNr8smChkenJJ+PxajhTXLM7EY64s0EbW5XAhRG/9DcjsuiIDo01/4FBrL6
         B0KH9K36If/ZHVi0+7yuULyCuiZo6WU8oO4z4XNmpY8gfz2BRcAhRsaz9Ij33lEGU7ho
         oQwQ8JxqM0os2vc/Ur7CW/soEomiY8L2uNyHGEZsieh/JyoLxYZkf5vHs9YGkmJIHEds
         UI6a6v+ig8+4Jk9bIsII5auBB829/eM4j2ELB3l7ro3qeTldum8YrDTI4F5GeCpJ8TRM
         KP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOSaQSpaF4AeWQZou9544VTh/gl9tQJsiv/YhpeTdjA=;
        b=jYYL55yDAUQDHaKrw80JEcgXlsylSft/FI4klsMQBae/FQlWd3hZAjDfflOTsuxEF+
         S1IbeXrQduQOtXXA9YGxo7xNtgB4tuxghSHMJUoRiSXwe8Tc0fzLjNAgh0vIWrJpQ4q3
         +LMHaseTjFVmNtBwRXHAuLAGPtLlOcCsaLgPZE1te2NVuGL5hRopvIzgB3fH+y6AKeEz
         zIuy7aGOYoq886bl7ibl3Mqotv8+S89o+buYTFOvK5KRDlSYzutEWdII3fmixLVU5fnB
         L9ABcr6vI4c3SwobfsNEHcwEnZTbNNKMtxYY186yH4YLk9NbhzvX9nzvh4OrXmOSj8y+
         Vibg==
X-Gm-Message-State: AO0yUKUuanIvU+ZyV5APMWZXitPp/8SSC/yIzQS4g470NEp7u30MG00N
	F5YzoO5K+DhXL4++ibsj9S0m/1xhqxAFUyzhpe7AF9aWYX9J1Hat
X-Google-Smtp-Source: AK7set9KmN/0JeVCHbb4dVMPZYgAO0wXFy6kYC22UrhIGNoD7GC2ddK4/bIcGknN6QfuRYU46CWfLcteYWYc9WpWXDY=
X-Received: by 2002:a05:6808:2087:b0:37d:81ab:3787 with SMTP id
 s7-20020a056808208700b0037d81ab3787mr21388oiw.58.1676503182691; Wed, 15 Feb
 2023 15:19:42 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Feb 2023 08:19:06 +0900
Message-ID: <CAODzB9qegyw30FEZLre5kW8hmp1U=DBcgOOQzneacEUtHePJxA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Feb 2023 23:19:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10700

Hi !

It's this week's CVE report.

This week reported 2 new CVEs and no updated CVEs.

* New CVEs

CVE-2022-27672: Cross-Thread Return Address Predictions

CVSS v3 score is not provided

When SMT is enabled, certain AMD processors may speculatively execute
instructions using a target from the sibling thread after an SMT mode
switch potentially resulting in information disclosure.

It affects certain AMD processors only. List of affected CPUs are
listed on AMD's security advisory
page(https://www.amd.com/en/corporate/product-security/bulletin/amd-sb-1045).

Fixed status
mainline: [be8de49bea505e7777a69ef63d60e02ac1712683,
6f0f2d5ef895d66a3f2b32dd05189ec34afa5a55,
  493a2c2d23ca91afba96ac32b6cbafb54382c2a3]
stable/5.15: [8f12dcab90e886d0169a9cd372a8bb35339cfc19,
5122e0e44363e3d837592b78bc04222b9d289868,
  17170acdc7c8b8585501bb443b4f196168ae9890]
stable/6.1: [cc95b5d240b631e42e2863e1dcb6ad83920cc449,
40c4fdfc942e0c93054884546bf785fe24c6831e,
  da1ae884562cc22e2705113cc39712477e37ab4e]

CVE-2023-20937: Privilege escalation bug was found in Android kernel

CVSS v3 score is not provided

This bug is in Android Common Kernel so that it doesn't affect to
mainline/stable/cip kernels.

* Updated CVEs

No updated CVEs this week.

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

