Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7623C433FE
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 01:25:16 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.13262.1669253108983276941
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 17:25:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=wx5Mp2Lw;
 spf=pass (domain: miraclelinux.com, ip: 209.85.166.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-io1-f42.google.com with SMTP id r81so353176iod.2
        for <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 17:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YzGXtiBK0RgvlgfwGdD/XP/rX/fJ5Syp+gd25Zy1nAo=;
        b=wx5Mp2LwCtqRTK58y3YobY6xzUeUeuenVkFeo9Pqsj5UprF3+FXpXcHJJddugPPAGm
         zSgqMbCoEX3/3xTFzq+wLxeqnPIRXhxfn3pZxQcMWiRKUcmF9y0KuUrJz37gauhiuh/0
         YdbxA0NOYNZl0brOU/EurLVnfyvMa95k8a3wOk3tzC2TRDpuGg1PJX2YE3TG6Ku8uWBU
         oWA5nkky86RBtkAdNDf9Ql8xg4rVZLjCCrfr1LYa84iCyGMjwsai4dlS/f3yuKwX6IK0
         xEznrn65xyICNqv55yjWVdySNopoNKk4V2cHwFuiZgnkEz/1gsxp8N1tTEUxy7xz9rKo
         /BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzGXtiBK0RgvlgfwGdD/XP/rX/fJ5Syp+gd25Zy1nAo=;
        b=oT32IrcyFs/yLWvTHli46ZXQ0hP8lrCo/ZfcLy7ECnSpeMF4du8N1jnnmAQozwFIpl
         C0ZNWarwkVAdc94y8EANfR+vBf3Ol+ahL5cteTglpnGgK1YCUsKdJoKgh+q4qPPCV16c
         fjAv2XWRSwc8ojyqAA2QWAvZ0C/RwmGYAveuJa3Z0uSOUnJaDrzOGN9iGEcBXruRpnF8
         4vulYcJvWvgU05/ZlnBYda3fCce6KmEN3IQGaDegn7SsmUFyfI6iIeTyqb12n4ldSfTL
         Gj0cwzXJdJETc+99xXswxJBMA2Fq1vrlycn/Ob9CZ4jvHdr4aAVeSAmR+dbIRgbRk3g1
         HmBg==
X-Gm-Message-State: ANoB5pmS9LQfn5D+RnVjrDxzqnFMuiCzdEWJVak7rhul33+svL7lWlIs
	jVvirWRL1HwJasAOTa4M8S1ZATQeGlZOeh9knNajgYocZOA=
X-Google-Smtp-Source: AA0mqf6FNUShhQegjyRBEs//Aj2goFkjboD9PeBu3wlnPxorJI4PDcrxpo5Dkr6Z5S59q374evEGUib6RpRNsUstxcw=
X-Received: by 2002:a6b:8e84:0:b0:6de:383e:414f with SMTP id
 q126-20020a6b8e84000000b006de383e414fmr13992218iod.47.1669253107997; Wed, 23
 Nov 2022 17:25:07 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Nov 2022 10:24:32 +0900
Message-ID: <CAODzB9pqn8v-Ue7iQBHWtFKBRHUq_Kw7Hbrd4t7tR1Bk-0_ZBA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Nov 2022 01:25:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10098

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2022-3910: Improper update of reference count in io_uring leads to
use-after-free

CVSS v3 score is not provided(NIST).
CVSS v3 score is 7.8 HIGH(CNA).

A use-after-free bug was found in io_uring subsystem. An improper
Update of Reference Count in io_uring leads to Use-After-Free and
Local Privilege Escalation. When io_msg_ring was invoked with a fixed
file, it called io_fput_file() which improperly decreased its
reference count (leading to Use-After-Free and Local Privilege
Escalation).

Introduced by aa184e8 ("io_uring: don't attempt to IOPOLL for MSG_RING
requests") which fixes 3f1d52a ("io_uring: defer msg-ring file
validity check until command issue").
Commit 3f1d52a was merged in 5.18-rc1 that is not backported to stable
kernels. This vulnerability was fixed in v6.0-rc6.

Fixed status
mainline: [fc7222c3a9f56271fba02aabbfbae999042f1679]

CVE-2022-4095: A Use-after-Free/Double-Free bug in rtl8712

CVSS v3 score is not provided.

A Use-after-Free/Double-Free bug was found in rtl8712 in staging
driver. This vulnerability leads DoS/Local privilege escalation.
This bug was Introduced in 2.6.37-rc1.

Fixed status
mainline: [e230a4455ac3e9b112f0367d1b8e255e141afae0]
stable/4.14: [376e15487fec837301d888068a3fcc82efb6171a]
stable/4.19: [9fd6170c5e2d0ccd027abe26f6f5ffc528e1bb27]
stable/4.9: [7dce6b0ee7d78667d6c831ced957a08769973063]
stable/5.10: [19e3f69d19801940abc2ac37c169882769ed9770]
stable/5.15: [dc02aaf950015850e7589696521c7fca767cea77]
stable/5.4: [d0aac7146e96bf39e79c65087d21dfa02ef8db38]

CVE-2022-4127: io_uring: NULL pointer dereference in
io_files_update_with_index_alloc

CVSS v3 score is not provided.

A NULL pointer dereference bug was found in
io_files_update_with_index_alloc() in io_uring subsystem. It will lead
system crash.

This bug was introduced by commit a7c41b4 ("io_uring: let
IORING_OP_FILES_UPDATE support choosing fixed file slots") in
5.19-rc1.
kernel version less than 5.19 aren't affected by this issue.

Fixed status
mainline: [d785a773bed966a75ca1f11d108ae1897189975b]

CVE-2022-4128: mptcp: NULL pointer dereference in subflow traversal at
disconnect time

CVSS v3 score is not provided.

A NULL pointer dereference bug was found in mctp module. This bug will
lead a system crash.
This issue was introduced by commit b29fcfb ("mptcp: full disconnect
implementation") in 5.17-rc1.
kernel version less than 5.17 aren't affected by this issue.

Fixed status
mainline: [5c835bb142d4013c2ab24bff5ae9f6709a39cbcf]

CVE-2022-41858: kernel: null-ptr-deref vulnerabilities in
sl_tx_timeout in drivers/net/slip

CVSS v3 score is not provided.

A NULL pointer dereference bug was found in slip module. This bug will
lead a system crash.
CIP 4.4 kernels are already fixed.

Fixed status
mainline: [ec4eb8a86ade4d22633e1da2a7d85a846b7d1798]
stable/4.14: [3fdb033f8f8c978489c7702a4a44494b7ae63424]
stable/4.19: [753b9d220a7d36dac70e7c6d05492d10d6f9dd36]
stable/4.9: [113284fe48770841e157e338bf3a2e9f197a8b50]
stable/5.10: [ca24c5e8f0ac3d43ec0cff29e1c861be73aff165]
stable/5.15: [efb020924a71391fc12e6f204eaf25694cc116a1]
stable/5.4: [d05cd68ed8460cb158cc62c41ffe39fe0ca16169]

* Updated CVEs

CVE-2022-23816: Mis-trained branch predictions for return instructions may allow
 arbitrary speculative code execution under certain
microarchitecture-dependent conditions on some AMD processors
CVE-2022-29900: Information leak through mispredicted returns on AMD processors
CVE-2022-29901: Information leak through mispredicted returns on Intel
processors

4.19 finally fixed Retbleed vulnerability(CVE-2022-23816,
CVE-2022-29900 and CVE-2022-29901).

Fixed status
stable/4.19: [67b137bf0d9d096f86c8bfa175ca5ab3629369c9,
8627f766f42beefcce9979e6db44541cc651d521,
c150c96152aa0ca3d59ecc71c0c4a8864abca42a,
e6bfe7967f1a06ff906a1d8d73696c750f833e74,
78c9a72da30a2a6e30c190f431d03a3b06bdcdc0,
0ff64957bae869ab7163d4b6c930f8ecfc6ae7cf,
12db59370889ce1a5e3deb50507d4141910c4341,
7c9a1a329b6273b5fe1c47f78a8efb15197937d5,
bd2b18f6d226de17b42b1f1ff15daf800a4f0c52,
c79ea34ffbb9af46a3e97f2a4550f83d0151a2e3,
4b74a4f69682058fa79ccc9643ea69a0f1b955ee,
310aee6c371b076f86b61f764fe77de0e2913edd,
9e03416b022e83c73bbbdc275f1df1c3e88e3155,
f1b4cf5ce43f28503ef24d30fdbb9247d141765d,
c1493b60fd131c0c1558a8f71192fbebe7ed998f,
6cc8bd7dd3f33c39469899b2045870b62dd1ef4d,
9dc813c5fe403345e3edf1e52ee1ee2ecfe0d46d,
d2c10ea360a307f520c22e56b77f9a40db79e253,
9f3330d4930e034d84ee6561fbfb098433ff0ab9,
ca47b5c598c2772aadd6bd5626ac531e640cd477,
93f951062040f132968103bb5a070aaafde2865c,
8bafec7f0eaa0d4f260fe74de49d9aaa0451bc3d,
1ec1aceda390df12ad85525521f3ce2c7d837934,
24344e2bee186d54e0fdfbae70e67ec39473a9ae,
e6ac9561776a1fa80e245993f94c8f63fa15632b,
6451e3ce91f70398dd5e0f9feada255f19d5b2b7,
f744b88dfc201bf8092833ec70b23c720188b527,
9f88c3b0a2bcf18b3ec7e551958723a1061c9b99,
1bce094085ff639bbe370821f2ab99e996a0e108,
745cd50cc41a4ca529d20a889699b829e739dddd,
48eb8d6ac7df51a6408d629306335449826fc3a8,
0019a40f27e98bac177d3ec3a006df3c177d9181,
7eb3e2a80fe6b41ead0eb08d6772f2604acc1899,
56cf3753a1ef6d269fe24872db53b7b135ca011a]

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

