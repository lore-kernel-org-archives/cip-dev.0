Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D1EC433EF
	for <webhook@archiver.kernel.org>; Wed,  8 Dec 2021 23:44:40 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web10.4361.1639007078264441136
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Dec 2021 15:44:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Dil4GicA;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.48,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f48.google.com with SMTP id
 47-20020a9d0332000000b005798ac20d72so4420956otv.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 08 Dec 2021 15:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=9196rFxJAjlbKdL7uCDVNz56GGpDnKJjFndW6yW6aoA=;
        b=Dil4GicA3Rr791ArLs7FCtfilDmKtbZoYf5OBty4vg3nxZOU0WDh/jlWoXq+KCyq/p
         mITh5EabYNNo9kfT2LGQ/drmqqB9NtQk3yIwAcydKXzTeOpR7PPcjLCCmD/76lxB+pdl
         lk0s2KqW4jyqP5AYvYys860BWrEn4+3uQjGdWaZT8A7P1Z9l7HI33quDIjoo5kuuFEM+
         X0hASu+OPV2upfEdYUFksxlp8deqYzKWUeXzV+QLemFUi3rpTZ0RDnKGdUc2xU01EhOb
         ZaFNpxNiNosGeWPPCT/mCPvjuMMpvPH8X/bOuFBSyZHiqlBscOedqBXOA4ucSKyweXYw
         iHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9196rFxJAjlbKdL7uCDVNz56GGpDnKJjFndW6yW6aoA=;
        b=iH507CasjwynP+eRgMPewnTf5/6IlVEWx8JYwiZPw21iHkUeBrJz8bC8lQOSyKLzsk
         ESC2z7B1iIUpeXPL200pYls7sK2nSqceDr4ZxJMsMmMTybwZTeM3Hg1M2zL/6atuMOK+
         QASyyy99OPTGq2GRXJIrwO07fiZat5/fqiz3vrDOFK04ltAR9crrhCt/WnM/+AQVJRXd
         WJOZsZ0Wfw9Ob0Aj/4heCLTIQs9sD+wEiFlIrDMUo78PT2WDL/6spfNQkJ36VkX63qP/
         3sCsPSZ9FdrhtIJUnq77gl3LCEp1Lyq2GtmADJf6D5oIWxo65/aDUVOrw9tkICFb3isb
         qhNw==
X-Gm-Message-State: AOAM530n+KLzkrpAAshXbQxRIMMoYyoj7yRmavNl4iu6cteriup3hp6s
	wW+yxYHRxfQp1uPxBT+q+7JpyGq/u/d1LEuLQXO9779GKV8r5Q==
X-Google-Smtp-Source: 
 ABdhPJyy6GJgjO+cltV48IEcPhzaj/LBeholnwKSfv+IFc8RXzdigrSCulohKj9Ew36CmdBuUtFWdYv133AJ3WuXm5s=
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr2393106oti.67.1639007077221;
 Wed, 08 Dec 2021 15:44:37 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Dec 2021 08:44:01 +0900
Message-ID: 
 <CAODzB9om4QmKLw-ABYqwWSBKL0Sndapov8FWLmhPQKtq1ZvQKA@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Dec 2021 23:44:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7076

Hi !

It's this week's CVE report.

This week reported three new CVEs.

* New CVEs

CVE-2021-1048: fix regression in "epoll: Keep a reference on files
added to the check list"

CVSS v3 score is not provided

The bug in ep_loop_check_proc(), which mishandled  reference of file.
This bug has been fixed in 5.9-rc4 so 5.9 or later kernel aren't
affected.

Fixed status

mainline: [77f4689de17c0887775bb77896f4cc11a39bf848]
stable/4.14: [c5c6e00f6cc5d3ed0d6464b14e33f2f5c8505888]
stable/4.19: [37d933e8b41b83bb8278815e366aec5a542b7e31]
stable/4.4: [6504c100804870911f074fd67f280756b6805958]
stable/4.9: [8238ee93a30a5ff6fc75751e122a28e0d92f3e12]
stable/5.4: [88405cf0f2bd771670b76c42b169527ff86048da]

CVE-2021-39636: "no details"

CVSS v3 score is not provided

There is no vulnerability details yet. However, there is five patches
are addressed so the bug is in the netfilter module.

f32815d ("xtables: add xt_match, xt_target and data copy_to_user
functions"): merged in 4.11-rc1
f77bc5b ("iptables: use match, target and data copy_to_user helpers"):
merged in 4.11-rc1
e47ddb2 ("ip6tables: use match, target and data copy_to_user
helpers"): merged in 4.11-rc1
ec23189 ("xtables: extend matches and targets with .usersize"): merged
in 4.11-rc1
1e98ffe ("netfilter: x_tables: fix pointer leaks to userspace"):
merged in 4.16-rc1. This fixes commit ec23189 ("xtables: extend
matches and targets with .usersize") that was merged in 4.11-rc1.

Fixed status

mainline: [f32815d21d4d8287336fb9cef4d2d9e0866214c2,
f77bc5b23fb1af51fc0faa8a479dea8969eb5079,
  e47ddb2c4691fd2bd8d25745ecb6848408899757,
ec23189049651b16dc2ffab35a4371dc1f491aca,
  1e98ffea5a8935ec040ab72299e349cb44b8defd]
stable/4.14: [f32815d21d4d8287336fb9cef4d2d9e0866214c2,
f77bc5b23fb1af51fc0faa8a479dea8969eb5079,
  e47ddb2c4691fd2bd8d25745ecb6848408899757,
ec23189049651b16dc2ffab35a4371dc1f491aca,
  ad10785a706e63ff155fc97860cdcc5e3bc5992d]

CVE-2018-25020: bpf: fix truncated jump targets on heavy expansions

CVSS v3 score is not provided

Fixed status

The BPF subsystem in the kernel through 4.17-rc7 has overflow bug.

mainline: [050fad7c4534c13c8eb1d9c2ba66012e014773cb]

* Updated CVEs

CVE-2021-4037: kernel: security regression for CVE-2018-13405

The commit 01ea173 ("fix up non-directory creation in SGID
directories") has been merged since 5.12-rc1-dontuse so after this
version aren't affected.

Fixed status

mainline: [01ea173e103edd5ec41acec65b9261b87e123fc2]

CVE-2021-4002: hugetlbfs: flush TLBs correctly after huge_pmd_unshare

stable 4.14, 4.4 and 4.9 kernels are fixed in this week.

Fixed status

mainline: [a4a118f2eead1d6c49e00765de89878288d4b890]
stable/4.14: [7bf1f5cb5150b1a53f6ccaadc0bc77f8f33206c8]
stable/4.19: [b0313bc7f5fbb6beee327af39d818ffdc921821a]
stable/4.4: [8a8ae093b52ba76b650b493848d67e7b526c8751]
stable/4.9: [8e80bf5d001594b037de04fb4fe89f34cfbcb3ba]
stable/5.10: [40bc831ab5f630431010d1ff867390b07418a7ee]
stable/5.15: [556d59293a2a94863797a7a50890992aa5e8db16]
stable/5.4: [201340ca4eb748c52062c5e938826ddfbe313088]

CVE-2021-43975: atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc_wait

stable 4.19, 5.10, 5,15, and 5.4 kernels are fixed in this week.

Fixed status

mainline: [b922f622592af76b57cbc566eaeccda0b31a3496]
stable/4.19: [0275fcd9b54f0364f66f2f3f6a0f3748648f3d35]
stable/5.10: [2c514d25003ac89bb7716bb4402918ccb141f8f5]
stable/5.15: [cec49b6dfdb0b9fefd0f17c32014223f73ee2605]
stable/5.4: [89d15a2e40d7edaaa16da2763b349dd7b056cc09]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

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

