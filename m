Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B42C54E94
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 00:00:19 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.62312.1674691212940507181
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Jan 2023 16:00:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=5aCUI6gO;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id r9so67213oig.12
        for <cip-dev@lists.cip-project.org>; Wed, 25 Jan 2023 16:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SyP8rDQ28YQ8AO17NNPduZhoY+jkWGhlsPEzuqu/pUE=;
        b=5aCUI6gOHZUD/fTvCOist7hWKc/EgvBiBKudxAybny2xudimNllE8WV3dfHRM2axgY
         7jwJC/1gOERF6Kce2BZ7ccqsCR0I+R+UpZxkpjjcS7nRo97PCx3iTQBy2sLjTAKqiNOE
         n7Ups8JYyAKjWzJQv59w6JF49K5nZbLuoto+PBxVdCphRYsz9vWVYZcb1CoFeXdfGtfi
         q8PAg+fyqB8OfyrAvOuwu9L/cZGxRNzu/3Z5eOcbYjl6tXqCoOuX0kHEhUlovQ15hId6
         Cu+AHOIvg5Mmk+fOTr++o5XR96liEqnxNkf3z9btwut4WFNZRpS2B2R2061aAIT/KV0l
         l08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SyP8rDQ28YQ8AO17NNPduZhoY+jkWGhlsPEzuqu/pUE=;
        b=l8iiQaEQXyr8eJhwQoybG5df64OWPqc7sUwFIqLL4fk6+l7kbIieMHdC4rJiC7WD8/
         gKXwBc22buDYzvxiSe+lTtCzoO5PMD+2w7x7wScmaw24VqQk5hHNQ40/QISt1cDsARgJ
         Q2K+QP/EozP4SRt9bE/ZNDU82iwzRtRZAKYj2GCBDuBNLaJ3RV0qvkzdxuv5oB43d7gt
         c08Lj0V2l2UvJXzsyf/pbkilLzRfG7yA0mMNWrMRSuRoRgIQ1e/KUxhldoZCuVPH7/8D
         YSigjUv6sIpoTuTcglWW9LQBS1jxIsFey2UvVpa1vcZQGhTJ2YzJdXA8dK/lpftksXV0
         jFPw==
X-Gm-Message-State: AFqh2kpTBAh7qV429Blj3Ctt9EbChky0iCaXYrp0Zhkb0fwDmLGQ8I9u
	giJbGOKJOWy6+I3li+mJbSCkqrI1r3wxxpC0EO4ldieIAINZRUYB
X-Google-Smtp-Source: AMrXdXsTSw5uyu3ec1lOXMFPCLogchlq7eaLaEG1IFQcUbbDOmor78cxcGe7W81x48UuC2uI/VPDC37hF/EpVPdPLTY=
X-Received: by 2002:a05:6808:205:b0:35a:640c:ceb3 with SMTP id
 l5-20020a056808020500b0035a640cceb3mr1740714oie.58.1674691211708; Wed, 25 Jan
 2023 16:00:11 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Jan 2023 08:59:35 +0900
Message-ID: <CAODzB9qLr1oF15irR_ik-oOWk9WQoY7ChmfmG2Qym3b4yhrnzA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jan 2023 00:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10480

Hi !

It's this week's CVE report.

This week reported 1 new CVEs and 2 updated CVEs.

ProjectZero recently published a technique for exploiting a Null
pointer dereference on a modern
kernel(https://googleprojectzero.blogspot.com/2023/01/exploiting-null-dereferences-in-linux.html).
In this article, it recommended the oops_limit feature to prevent this
exploitation technique. The oops_limit feature has been backported to
6.1.y (https://lore.kernel.org/stable/202301191532.AEEC765@keescook/T/#u).
The oops_limit patches are available on 5.10
(https://lore.kernel.org/stable/20230124193004.206841-1-ebiggers@kernel.org/)
and 5.15 (https://lore.kernel.org/stable/20230124185110.143857-1-ebiggers@kernel.org/)

* New CVEs

CVE-2023-0468: use-after-free in io_uring poll events due to race condition

CVSS v3 score is not provided

A use-after-free flaw was found in io_uring/poll.c in
io_poll_check_events in the io_uring subcomponent in the Linux Kernel
due to a race condition of poll_refs.
This flaw may cause a NULL pointer dereference.

This bug was introduced by commit aa43477 ("io_uring: poll rework") in 5.17-rc1.
This commit was backported to 5.15 so 5.15 is affected. It isn't
backported to 5.4 and 5.10.

Fixed status
mainline: [12ad3d2d6c5b0131a6052de91360849e3e154846,
a26a35e9019fd70bf3cf647dcfdae87abc7bacea]
stable/5.15: [df4b177b48516da64b988722a22d93d257dcda9a,
4b702b7d11ce1b9d26fc6d7c5a7ef4ac1d455048]

* Updated CVEs

CVE-2023-0179: netfilter: nft_payload: incorrect arithmetics when
fetching VLAN header bits

Fixed status
mainline: [696e1a48b1a1b01edad542a1ef293665864a4dd0]
stable/5.10: [550efeff989b041f3746118c0ddd863c39ddc1aa]
stable/5.15: [a8acfe2c6fb99f9375a9325807a179cd8c32e6e3]
stable/6.1: [76ef74d4a379faa451003621a84e3498044e7aa3]

CVE-2022-4842: fs/ntfs3: Fix attr_punch_hole() null pointer dereference

5.15 and 6.1 were fixed.

Fixed status
mainline: [6d5c9e79b726cc473d40e9cb60976dbe8e669624]
stable/5.15: [9cca110cf8bb0653b423dba7a7c4cc23ccf91b28]
stable/6.1: [ff3b1a624380c14b81f4e51c48e404a45f047aab]

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

