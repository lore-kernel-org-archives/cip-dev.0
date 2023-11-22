Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38116C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 23:22:43 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web10.78667.1700695353504054469
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 15:22:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=2+t6lCRM;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f0f94943d9so201388fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1700695352; x=1701300152; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l2S/3x5/qFrvnpOds3nNS1+9aj8BOtyb733jmja9Hd8=;
        b=2+t6lCRMhm5agCeFYdfaGCpsVXK1EIZqnUupou61C5Cc92V5hK67qR3JGVB8FvWsLW
         p8ay7nExlh+jCw5tjKPWIFQf1V1wP10stYGqzxU7cORjDee5nXNw6m8gByD7d2bhgRUx
         l4OrihSg0PPbNBU26RcgpQVlgDYQXmk8GwbBiRcpHA6ozsIFslE5c4ySjZu12MBYKGRa
         KxkC2cz5a0oarjejccO2qjq8ZuOhdgmjYBQvy/PHd3FtfxT7mljjoR+F72Uv+lY4JGQg
         YKSJEQqF5KIzL2hTa5v+wLCvExH3472UO9DNwa/ThMKDg2NE/kriCXBRXnlAHHcoFXNl
         zW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695352; x=1701300152;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2S/3x5/qFrvnpOds3nNS1+9aj8BOtyb733jmja9Hd8=;
        b=eJn11VnaTbe5SZjQt9EpLGSVPgIXrT89EXqFfDkOmc0Vziq4fljB5D8jC1+bQzF8hW
         RLYeO8fb4L3vGKCgOYKpotXVYrUBCQVYi9aSZbZEuuUxDKPpQNexkIpR7SSfC8suxnV/
         ZbD55K1TnY36mLtuEm3bPzrvOae2B2D6mPG7v02OL30XI1KjL8jce8yYGe9WWBFSjrNs
         nSwMeD/uQwsRkDecPw+DTw8uTJhmXXgJ5kQEEbrACDjK6o25VUOmWEs6ozw1O9cmDYBv
         oKZQS//e+WzUM8TfcqlgXAMUZbjGyIFtA3aC7oAHGtmvoWWFcB+CSUxY8Fo/vIcADd2Y
         mJlg==
X-Gm-Message-State: AOJu0YwhE45ATcBTRoy8bt6BsTl7pYJiFCrZJB5LuG4THZGwtsz7a+WG
	+qEQhSG3qSSszVBWrajy/ZLdGT/Mh5+N8YKzDyDJ2KVEFJKlGsy3ncA=
X-Google-Smtp-Source: AGHT+IGWbLZG6v22ms58ZRvMiwp/M+29KUCd2FOi/PRPiKrUgAuWPCmPuGsVsQU+xqGpggwcUWSjZ8e4dN6rvaYBlQU=
X-Received: by 2002:a05:6871:5289:b0:1f9:5f20:8c6c with SMTP id
 hu9-20020a056871528900b001f95f208c6cmr4786218oac.14.1700695352411; Wed, 22
 Nov 2023 15:22:32 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Nov 2023 08:21:56 +0900
Message-ID: <CAODzB9rjkHHcdptFxb8Si5rpx=5d2WAiPEpspJdFekhP7WefHQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 23:22:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13656

Hi!

It's this week's CVE report.

This week reported 3 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2023-6121: nvmet: nul-terminate the NQNs passed in the connect command

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.3 (MEDIUM)

An out-of-bounds read vulnerability was found in the NVMe-oF/TCP
subsystem in the Linux kernel. This flaw allows a remote attacker to
send a crafted TCP packet, triggering a heap-based buffer overflow
that results in kmalloc data to be printed (and potentially leaked) to
the kernel ring buffer (dmesg).

Fixed status
Patch is available at the linux-nvme list but it hasn't been merged yet.

CVE-2023-6176: A NULL pointer dereference bug was found in the net/tls/tls_sw.c

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.4 (MEDIUM)

A null pointer dereference flaw was found in the Linux kernel API for
the cryptographic algorithm scatterwalk functionality. This issue
occurs when a user constructs a malicious packet with specific socket
configuration, which could allow a local user to crash the system or
escalate their privileges on the system.

This bug was introduced by commit 635d939 ("net/tls: free record only
on encryption error") in 5.7-rc7.
The commit 635d939 was backported to 5.4. So 5.4 or greater kernels
are affected by this issue.

Fixed status
mainline: [cfaa80c91f6f99b9342b6557f0f0e1143e434066]
stable/5.10: [a5096cc6e7836711541b7cd2d6da48d36fe420e9]
stable/5.15: [481bd6dcc5fe6c0ec57b61240ab552f67ff51b6b]
stable/5.4: [f9f3ce7719ebb437a883ae0db26723f17190df83]
stable/6.1: [7f4116c6f98412a6e29ace6d6a7b41ebb4e8a392]
stable/6.5: [74aecad5da19004ccf6321fd397d14b10756622a]

CVE-2023-6238: nvme: memory corruption via unprivileged user passthrough

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.0 (HIGH)

A buffer overflow vulnerability was found in the NVM Express (NVMe)
driver in the Linux kernel. An unprivileged user could specify a small
meta buffer and let the device perform larger Direct Memory Access
(DMA) into the same buffer, overwriting unrelated kernel memory,
causing random kernel crashes and memory corruption.

Fixed status
Patch is available but it hasn't been merged yet.

* Updated CVEs

No updates


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

