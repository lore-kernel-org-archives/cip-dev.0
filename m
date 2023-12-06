Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515FFC4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 23:22:52 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.62710.1701904971500870443
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 15:22:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=bkzfhbg/;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9d21959aaso196837a34.2
        for <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 15:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1701904970; x=1702509770; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MB6WEtu9r8Sgj44G5tSSYq34MU24AdpRkJKG0TZ2N+c=;
        b=bkzfhbg/YnczDoaNaMIEapkICTnOjKGBIy0jM4s/fyHREidux4ILrP8t0pMi9Q7hfn
         fCMZLi29UO33rnIYtUSw2ZpWKb8v69U7auERa2b5XS8fU5y0uj3O6WCou2XbsL7hrbmk
         uCLeqtIqd6HbHuBb80WpFzR55PScsinG4/DQqZk8RXA/m+VYgRMytwlSAhgmpoCzzOmk
         GeoI1asINFMMH/OvUnFJNtoDb1S9oJaf5SXAd3ISPoeJeLtnFvG4+W8HJGIpgC6B7gfe
         3ss86YOpsPUD9yvUrCQ91W/uufXgb4aZNlljBmVeJ2zSoYIXRRBueaHeheDGDj8MC+cu
         ACaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701904970; x=1702509770;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MB6WEtu9r8Sgj44G5tSSYq34MU24AdpRkJKG0TZ2N+c=;
        b=IvT3M43lkFRxQSslw1VkeW9Gt6toOx/dmbHY2QuO4MwMe2dGB8Hm0SIquuRzBPZJFD
         1TCTk0R0i8PsyC3R/QDY2+WJUclq5v2Y4SQM3l/9Cg/HhBiknbt6TzKdKdcpNucaLI1e
         1phCJODzPA2IAb8ycDJ2Xtt2mDGjdFTJBykGSx9qrKs77/kclGNQAxU7zeNiWjEo3vRQ
         Mm2vBsiXePg6oksf3O7Tzk5iWTpdMwIPSJONyPZUXC5Hk9+pWvwtn34/EtDmTZ7zoxNg
         YtYniIrHX0pKOV+/DYTK3fZoFfIyusH6xKOZfMlFLUhDH+006zk+Z38FL+MAq9TdgkT6
         Nv/Q==
X-Gm-Message-State: AOJu0Yx6UbmRf+8xwna9L1u1t9XkpUU/DhTFc+0FTkvB5EJoCQXXSZN7
	w6d3VlsvO3tCyDtP+WFEhEqzFv0L7sL+Mlsa8t0NeM2EhFLZ5g4fyc0=
X-Google-Smtp-Source: AGHT+IGhs04qRTx32mYC+ROfbrb0TgaPjIUWOwJDf7AQnkUi30XSIZDKwUYHRqRknhYMZwVJZVTQ8uWPAxzhnvsXx6M=
X-Received: by 2002:a05:6870:1488:b0:1fa:5890:7840 with SMTP id
 k8-20020a056870148800b001fa58907840mr1629098oab.35.1701904969817; Wed, 06 Dec
 2023 15:22:49 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Dec 2023 08:22:13 +0900
Message-ID: <CAODzB9poD5_hCa4hZfxHbiRyqt15PgjrzzK_cZpcRW-Lkenu5Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 23:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13802

Hi!

It's this week's CVE report.

This week reported 2 new CVEs and 2 updated CVEs.

A cpu vulnerability called "Spectre based on Linear Address Masking"
(shortly SLAM) was published this week.
For more information is in https://seclists.org/oss-sec/2023/q4/260.

* New CVEs

CVE-2023-24023: A man-in-the-middle attacks was found in Bluetooth
Core Specification 4.2 through 5.4

CVSS v3(NIST): 6.8 (MEDIUM)
CVSS v3(CNA): N/A

Bluetooth BR/EDR devices with Secure Simple Pairing and Secure
Connections pairing in Bluetooth Core Specification 4.2 through 5.4
allow certain man-in-the-middle attacks that force a short key length,
and might lead to discovery of the encryption key and live injection,
aka BLUFFS.

This CVE's CPE is assigned to bluetooth(vendor) and
bluetooth_core_specification(product).

Fixed status
Not yet.

CVE-2023-33053: Memory corruption in Kernel while parsing metadata.

CVSS v3(NIST): N/A
CVSS v3(CNA): 8.4 (HIGH)

Bug is in the qcom_mdt_read_metadata() in the
drivers/soc/qcom/mdt_loader.c. This function was introduced by commit
498b98e ("soc: qcom: mdt_loader: Support loading non-split images") in
5.3-rc1.
The qcom_mdt_read_metadata() doesn't check if ehdr->e_phnum is bigger
than PN_XNUM so if ehdr->e_phnum is bigger than PN_XNUM it will occur
an oob access.
According to the cip-kernel-config repo, no CIP member enables
CONFIG_QCOM_MDT_LOADER.

Fixed status
Patch is available(https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/commit/06426824a281c9aef5bf0c50927eae9c7431db1e)
but it hasn't been merged into the mainline yet.

* Updated CVEs

CVE-2023-45898: ext4: fix slab-use-after-free in ext4_es_insert_extent()

stable 5.15 and 6.1 were fixed.

Fixed status:
mainline: [768d612f79822d30a1e7d132a4d4b05337ce42ec]
stable/5.15: [e33eb4997585f2e17513e3f2923080dc08cbb00b]
stable/6.1: [8384d8c5cc398cf59ab829d71d750752002f0a21]
stable/6.5: [c15bf3330a9e3c01b23e59899a6a02432a62ddc3]

CVE-2023-6121: nvmet: nul-terminate the NQNs passed in the connect command

stable 5.15, 6.1, and 6.6 were fixed.

Fixed status
mainline: [1c22e0295a5eb571c27b53c7371f95699ef705ff]
stable/5.15: [e26c6febac43a2dd2c5fb993b2137489005d43bf]
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

