Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5610C0032E
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 23:31:02 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web10.188385.1698276653161274668
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Oct 2023 16:30:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=T0UMp1Dm;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1e9c42fc0c9so168728fac.1
        for <cip-dev@lists.cip-project.org>; Wed, 25 Oct 2023 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1698276652; x=1698881452; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j1is/seXycitfG4zluJuVH3Z5oPgV73/EyOcf+sEMU8=;
        b=T0UMp1Dm2DCN9QS1bOOk5k/eQZn8yu4DEaWeHubM+/mtgvpqHbNIm91xEuktP0SYFr
         rX1U5sMCIe1QMBtk177LQilDSTrWKW5LMo9Xr/wKY95lDystGc5d8oCjEn4dKTjDIcYY
         1V6INpA0C2lcxzHFHDUk1jwXg8m3035OeeobvTrCYRerfjAUBtXdqyohNt0Ddsa2jMjr
         r8n0dfR6kzQFxvNfCd9hVrKDrLokCWgrhxWT5yJ5qU1s5hgMglJ+EhmW2/jkAAdCzX9u
         nbh1nokXvJsByDHuHY+kYHWznpyWjRJJ2xe32UxYEE4pM9Tcm60ge3xrmNP9ZLRRzWyv
         nSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698276652; x=1698881452;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1is/seXycitfG4zluJuVH3Z5oPgV73/EyOcf+sEMU8=;
        b=WJ+VVVdYYIVZT92VYQ4+PIf8T/NEJtQDowlba2cHMUvYndYtHgi3PhK2J9sdQGkHdV
         0OyJ1VbUDmeXLmTBkSzxny6YS0hrlFssIr/MeUHlBdtIEIh8FCEUKUmnzHv88J3YH9Uo
         o4Flo5k7cAmkNwp/caqrQ5xiblkwkmcV54pCB0Hl/3DMPMkuKDY4QEmMjS2MQhl67Dl4
         S3Pe0lMcp0LxMsILqIvTZAaGS0rqbUEf+9k9BDh2Giqi0of3PtaXJ7nwFwwnPXREsYKt
         98DvT+K5Fomx0gkzarspYx95ARWIQkToLVG0LcFPGs2IdpfcEPCFHGY3oSZLBP2ePMBm
         bxOA==
X-Gm-Message-State: AOJu0YzbrnQGm2F/HUZsXfI4PV2g92YvRcG5hyiJw5XbEq2hkEFB/58N
	T0UJlI5/IAE6ZZv2qQH2STPZfr3Cenbv3j/qVLOFC8Y0XMT2K0xdxQ0=
X-Google-Smtp-Source: AGHT+IE3bEuKHfmUiOwcQzWkMQd1Ywuz+KITGNNa66C9l2MB9BnkiIgquHLavwNvlok7Bik7bq4GJ+afqtr3TdjqLL0=
X-Received: by 2002:a05:6870:3042:b0:1e9:de37:a75d with SMTP id
 u2-20020a056870304200b001e9de37a75dmr18104065oau.17.1698276652026; Wed, 25
 Oct 2023 16:30:52 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Oct 2023 08:30:16 +0900
Message-ID: <CAODzB9obg4-dAWpuxm6ovOLQDYPPCmGNvi2Jikzx=jLf6Xg-ww@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Oct 2023 23:31:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13450

Hi!

It's this week's CVE report.

This week reported 3 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2023-5090: x86: KVM: SVM: always update the x2avic msr interception

CVSS v3(NIST): N/A

The svm_set_x2apic_msr_interception() is used to call intercept x2apic mars.
However, the svm_set_x2apic_msr_interception() has incorrect check for
 "'!apic_x2apic_mode()" which prevent it from doing anything in this
case. As a result of this, all x2apic msrs are left unintercepted, and
that exposes the bare metal x2apic (if enabled) to the guest.

Introduced by commit 4d1d794 ("KVM: SVM: Introduce logic to
(de)activate x2AVIC mode") in 6.0-rc1.
Before 6.0 LTS kernels don't contain the commit.

Fixed status
mainline: [b65235f6e102354ccafda601eaa1c5bef5284d21]
stable/6.5: [94805f9d3a3fb1f091bcc08b9c4846c4346706eb]

CVE-2023-5717: perf: Disallow mis-matched inherited group reads

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 HIGH

A heap out-of-bounds write vulnerability in the Linux kernel's Linux
Kernel Performance Events (perf) component can be exploited to achieve
local privilege escalation. If perf_read_group() is called while an
event's sibling_list is smaller than its child's sibling_list, it can
increment or write to memory locations outside of the allocated
buffer.

This bug was introduced by commit fa8c269 ("perf/core: Invert
perf_read_group() loops") in 4.4-rc1. Fixed in 6.6-rc7.

Fixed status
mainline: [32671e3799ca2e4590773fd0e63aaa4229e50c06]
stable/4.14: [555e15e93f6dbb8ce6b5b92e5272473abfe8bd2b]
stable/4.19: [a714491fa92d2068358dd603cc50bf2062517bd8]
stable/5.10: [487a8e24643a0effb2ba19cad3227fc75dc3c4b7]
stable/5.15: [71d224acc4d1df1b61a294abee0f1032a9b03b40]
stable/5.4: [7252c8b981853bb8930de44fab924f947362683f]
stable/6.1: [f6952655a61264900ed08e9d642adad8222f8e29]
stable/6.5: [20f925d38e1ecc1d36ee6bf6e325fb514a6f727d]

CVE-2023-5633: drm/vmwgfx: Keep a gem reference to user bos in surfaces

The reference count changes made as part of the CVE-2023-33951 and
CVE-2023-33952 fixes exposed a use-after-free flaw in the way memory
objects were handled when they were being used to store a surface.
When running inside a VMware guest with 3D acceleration enabled, a
local, unprivileged user could potentially use this flaw to escalate
their privileges.

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8(HIGH)

This bug was introduced by commit a950b98 ("drm/vmwgfx: Do not drop
the reference to the handle too soon") in 6.2.
This commit is not backported to 5.x and 4.x kernels. It is fixed in 6.6-rc6.

Fixed status
mainline: [91398b413d03660fd5828f7b4abc64e884b98069]
stable/6.5: [1474b39f961703d0bb33833a6d6b112826839781]

* Updated CVEs

CVE-2023-5178: nvmet-tcp: Fix a possible UAF in queue intialization setup

The mainline was fixed in 6.6-rc7.
This bug was introduced by commit 872d26a ("nvmet-tcp: add NVMe over
TCP target driver") in 5.0-rc1. Linux 4.x kernels are not affected.

Fixed status
mainline: [d920abd1e7c4884f9ecd0749d1921b7ab19ddfbd]
stable/5.10: [e985d78bdcf37f7ef73666a43b0d2407715f00d3]
stable/5.15: [34f62612be2a7f90ab68a14154db6664a32f8db0]
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

