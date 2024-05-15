Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C4AC25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 22:12:45 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
 by mx.groups.io with SMTP id smtpd.web10.7246.1715811156264445275
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 May 2024 15:12:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=e924twVy;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.49, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b2a66dce8fso3110478eaf.1
        for <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1715811155; x=1716415955; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FecrejgdgUdlmZKJRfky8PvJkTI4ZrCCtEm7Xqg6Mzg=;
        b=e924twVyPctEe5Fa5L0yeml8AgMLmZPiJLGBcbtK64TuJ9dqsj6X5FO1v2tqhkJpVA
         RMt3wjJN0Iwj+nDXIyVSChgV/HM8oal33LfdKIKTPw8djmmQdzb122W/uMgLpHF+icpt
         wnDnPbd2bPKCPbE6j05CtW3BYBPGorTMvykzZpIonD5tgmk6NGmTAbWL/WSNIh8xeclP
         IOy6SumZXiT+8S7wesrk41D/YyEmGLq00mPkZdkgNYX4Dfrs9z+t6iOSlU41W8L9efQW
         1mOlLa+WERHoyxd6KEvXYCfSE1BLyr/vtgpGyYRroMpioHyvAJnrgy0OvC0OCipdPldu
         MrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715811155; x=1716415955;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FecrejgdgUdlmZKJRfky8PvJkTI4ZrCCtEm7Xqg6Mzg=;
        b=nkDNBqaS7fDPWtWZvmjaRQfWgluXd5u7t+b+ZLnki1RMzeP4+0F6kOSF2hRKTXLAun
         rxJ1GEhl8cbm+2tf01i2H+B16qCCIr0RmvZB2HX5R0c5poESXOw3bkcAmxxHfy2S5wGW
         rii64rN83ZK7x8b33bAHy1bNntSb8XQTO38tZkmilEgzKUTuWVcmp7hh6oSrMkAyHP4l
         JfLmD91DVcXIJyWqgCbRbrSEsdF391sW1c8e2BAO1m4oUBcSV+dJqjTrqBTbzE0fMbvU
         wH5X2xfuzBsHpohvYFBY4C9NEh4DMvhkWw27gprjqEF6KLvuLryMe344qUMWCsiBxWHI
         PMJw==
X-Gm-Message-State: AOJu0YwweBJmumBSA4PRv0LzM4uLujNhskQ8zcTYXWBXUSSxAi5hN2Dd
	CbAXs3gRv/fOsfdXYNl5O2ql99voFBkQrH0NfXfDe5gN1YKFx6eB/1YW8yR6YCKh2T00xJYh2bT
	QHZQOgBjbSzVLGDHqNeUyYoGc81sHSSdYeV0bdn5E12keM74979E=
X-Google-Smtp-Source: AGHT+IEkfd8irFd3xCblaWPj4ePg547GXarpoqeCBBnYcP/CsXMRNSqMyPUzWpmJMOWN29jW0aO9W10u+DbiBCZe3Mk=
X-Received: by 2002:a05:6871:588:b0:23d:5285:5dc6 with SMTP id
 586e51a60fabf-24172c4db06mr19950107fac.52.1715811155133; Wed, 15 May 2024
 15:12:35 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 May 2024 07:11:59 +0900
Message-ID: <CAODzB9oBpPA03XOZxPcg6DLox2C0tFxQN1=pJLfh++TPmTLbkw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 22:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15900

Hi!

It's this week's CVE report.

This week reported 6 new CVEs and 5 updated CVEs.

* New CVEs

CVE-2023-52655: usb: aqc111: check packet for fixup for true limit

Announce: https://lore.kernel.org/linux-cve-announce/2024051307-CVE-2023-52655-3f94@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc3.
Vulnerable function was introduced by commit 361459cd ("net: usb:
aqc111: Implement RX data path") in 5.0-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ccab434e674ca95d483788b1895a70c21b7f016a]
stable/5.10: [d69581c17608d81824dd497d9a54b6a5b6139975]
stable/5.15: [46412b2fb1f9cc895d6d4036bf24f640b5d86dab]
stable/5.4: [84f2e5b3e70f08fce3cb1ff73414631c5e490204]
stable/6.1: [82c386d73689a45d5ee8c1290827bce64056dddd]
stable/6.6: [2ebf775f0541ae0d474836fa0cf3220e502f8e3e]

CVE-2023-52656: io_uring: drop any code related to SCM_RIGHTS

Announce: https://lore.kernel.org/linux-cve-announce/2024051338-CVE-2023-52656-6545@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The io_uring feature was introduced in 5.1 so 4.x is not affected.

Fixed status
mainline: [6e5e6d274956305f1fc0340522b38f5f5be74bdb]
stable/5.10: [a6771f343af90a25f3a14911634562bb5621df02]
stable/5.15: [d909d381c3152393421403be4b6435f17a2378b4]
stable/5.4: [cfb24022bb2c31f1f555dc6bc3cc5e2547446fb3]
stable/6.1: [a3812a47a32022ca76bf46ddacdd823dc2aabf8b]

CVE-2024-27398: Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout

Announce: https://lore.kernel.org/linux-cve-announce/2024051355-CVE-2024-27398-08ef@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ba316be ("Bluetooth: schedule SCO timeouts with
delayed_work") in v5.15-rc1.
Fixed in v6.9.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.4

Fixed status
mainline: [483bc08181827fc475643272ffb69c533007e546]

CVE-2024-27399: Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Announce: https://lore.kernel.org/linux-cve-announce/2024051300-CVE-2024-27399-afa8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3df91ea ("Bluetooth: Revert to mutexes from RCU
list") in v3.4-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [adf0398cee86643b8eacde95f17d073d022f782c]

CVE-2024-27400: drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2

Announce: https://lore.kernel.org/linux-cve-announce/2024051317-CVE-2024-27400-3b00@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 94aeb41 ("drm/amdgpu: fix ftrace event
amdgpu_bo_move always move on same heap") in v6.8-rc1.
Fixed in v6.9-rc7.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [d3a9331a6591e9df64791e076f6591f440af51c3]

CVE-2024-27401: firewire: nosy: ensure user_length is taken into
account when fetching packet contents

Announce: https://lore.kernel.org/linux-cve-announce/2024051341-CVE-2024-27401-e31d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc7.
It seems as if this bug was introduced in the first commit 286468
("firewire: new driver: nosy - IEEE 1394 traffic sniffer") in
2.6.36-rc1.

Fixed status
mainline: [38762a0763c10c24a4915feee722d7aa6e73eb98]


* Updated CVEs

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

According to the SUSE bugzilla comment
5(https://bugzilla.suse.com/show_bug.cgi?id=CVE-2020-26556), Linux
kernel cannot do anything to this bug.
Userspace application disables mesh service to migigate this CVE.
So, ignore this CVE.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

According to the SUSE bugzilla comment
5(https://bugzilla.suse.com/show_bug.cgi?id=CVE-2020-26557), Linux
kernel cannot do anything to this bug.
Userspace application disables mesh service to migigate this CVE.
So, ignore this CVE.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

According to the SUSE bugzilla comment
5(https://bugzilla.suse.com/show_bug.cgi?id=CVE-2020-26559), Linux
kernel cannot do anything to this bug.
Userspace application disables mesh service to migigate this CVE.
So, ignore this CVE.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

According to the SUSE bugzilla comment
7(https://bugzilla.suse.com/show_bug.cgi?id=CVE-2020-26560), Linux
kernel cannot do anything
to this bug. Userspace application disables mesh service to migigate this CVE.
So, ignore this CVE.

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

According to the SUSE
bugzilla(https://bugzilla.suse.com/show_bug.cgi?id=CVE-2021-31615) and
Red Hat bugzilla(https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2021-31615),
both said that this CVE is protocol level issue that cannot be fixed
in
software.
So, ignore this CVE.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

