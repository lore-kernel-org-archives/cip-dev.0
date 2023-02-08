Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01842C636D3
	for <webhook@archiver.kernel.org>; Wed,  8 Feb 2023 23:45:17 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web11.1304.1675899914712619758
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Feb 2023 15:45:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=Grf28bjE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.179, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f179.google.com with SMTP id 20so270174oix.5
        for <cip-dev@lists.cip-project.org>; Wed, 08 Feb 2023 15:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02BLuhxe91TxmKGxPNYQrKcEBHrvMa7W+iNZ5fG7sgc=;
        b=Grf28bjEiUFjnbmxym9i1Q0RxRbEKl+6iynum2vnIz+3wDRGWhv1ETvNgl48xl59XJ
         v1kviNhuRYIUCLUoJIxhsLsx7UBspkTEr9xP5pVxKdmjcXpKokyeV036B+12bhaWRA4i
         qL3r0HW14GHMqu9YuKmHaR66icgCPG8QeMZS5egB6jQTosSl6r+CAwAq+840YQ+vkbGj
         BA+Mj8Ac5hGKbIk5bIAznzNE/2DwoGdim2zxRjbycBB/f9/G6JqFfrVV852Ve8topyrD
         FKExPY2sPlarchn3W1TpnvhtrxGBTx8HfXIwemuNNY8kHqQimMp38aOcEhAd8gehJ6VW
         UEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02BLuhxe91TxmKGxPNYQrKcEBHrvMa7W+iNZ5fG7sgc=;
        b=jXxNu4QDR6qk9RMIjtiR4OFpGa2eZJad4LH/XiCxy+BnoVAahPcCjL8NRsM+C/ulvj
         Tj4STi/iWj9fFWOtT+aDUx1ZJAmLeV7j+PNlUWMaBi0sMG2MI1IzWivwWfoBoSvUnD2d
         SUGcRaKjblqXBrkoZW1xtZ8UdzfaD/r+i982AhcxSsTOPrrmD9DBsVRC/trHUDmfMoqi
         oBrlJow0WXHlmDNDF0az8D2HTz1hK0YFHwHDigaDtG3/scyH5hoMwbZY78ULqd3YSgI6
         P2gTtM6uU+2nCMFp6sqPVabz4OSnf0/cGXgpJbNCwYFmJLCovoD8oGZMaqlt07IM5nQ4
         MQPw==
X-Gm-Message-State: AO0yUKXwNcVpKtSiI3Fn7CLjF7gSXnEgU1Z2tpNeHi3fvy0zKdeHwaZk
	FOANLvvLQ+tlOc5deXQxd9chVo0gMJKHI+sAuMdtJieFnfVVN5cO
X-Google-Smtp-Source: AK7set8Rf7ioFtLRa9pYFRxuKnLhkW+UH7LXmnJWjd6ulHzEXAQQIkgqcc4QGTbWWD+77B6+JiSe0HFwjXWJ6HplUuo=
X-Received: by 2002:aca:3e85:0:b0:37b:78ca:c932 with SMTP id
 l127-20020aca3e85000000b0037b78cac932mr468983oia.102.1675899913234; Wed, 08
 Feb 2023 15:45:13 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Feb 2023 08:44:36 +0900
Message-ID: <CAODzB9r=DKTC2kgP3_dxb5m2Jj3T3K=vnbwky9Ov7iY=3jBSRA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Feb 2023 23:45:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10629

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2023-0615: multiple issues for the Video for Linux version 2 test driver

CVSS v3 score is not provided

A memory leak flaw and potential divide by zero and Integer overflow
was found in the Linux kernel V4L2 and vivid test code functionality.
This issue occurs when a user triggers ioctls, such as
VIDIOC_S_DV_TIMINGS ioctl. This could allow a local user to crash the
system if vivid test code enabled.

Config files in cip-kernel-config do not enable vivid's test driver.

Fixed status
mainline: [94a7ad9283464b75b12516c5512541d467cefcf8]
stable/4.14: [5edc3604151919da8da0fb092b71d7dce07d848a]
stable/4.19: [9c7fba9503b826f0c061d136f8f0c9f953ed18b9]
stable/5.10: [f9d19f3a044ca651b0be52a4bf951ffe74259b9f]
stable/5.15: [ab54081a2843aefb837812fac5488cc8f1696142]
stable/5.4: [54f259906039dbfe46c550011409fa16f72370f6]
stable/6.1: [2f558c5208b0f70c8140e08ce09fcc84da48e789]

CVE-2023-25012: HID: bigben_remove: manually unregister leds

CVSS v3 score is not provided

The Linux kernel through 6.1.9 has a Use-After-Free in bigben_remove
in drivers/hid/hid-bigbenff.c via a crafted USB device because the LED
controllers remain registered for too long.

This bug was introduced by commit 4eb1b01de5b9 ("HID: hid-bigbenff:
fix race condition for scheduled work during removal") in 5.6-rc4.
This patch was backported to 5.4 so linux 5.4 is affected as well.

Fixed status
Patch is available
(https://lore.kernel.org/all/20230125-hid-unregister-leds-v1-1-9a5192dcef16@diag.uniroma1.it/)
but it hasn't been merged yet.

CVE-2023-0045: Bypassing Spectre-BTI User Space Mitigations

CVSS v3 score is not provided

An attacker can bypass Spectre-BTI user space mitigations. The kernel
doesn't issue an IBPB immediately during the syscall so there is no
mitigation in a short period of time.
The impact is low. It would only affect applications that immediately
load secrets after the prctl() call.

Fixed status
mainline: [a664ec9158eeddd75121d39c9a0758016097fa96]
stable/4.14: [e1feec3bd63b7e526f92464def38a5fbe437dc99]
stable/4.19: [940ede60d74d2fc7291b96cb38072d705333c8e0]
stable/5.10: [67e39c4f4cb318cfbbf8982ab016c649ed97edaf]
stable/5.15: [cb42aa7b5f726e3fddc8656b8f5c723537d654f1]
stable/5.4: [8cbd7f26438738238c245a9c0aaf7ebf43283fba]
stable/6.1: [e8377f0456fb6738a4668d4df16c13d7599925fd]

CVE-2023-20938: Privilege escalation bug was found in android binder driver

CVSS v3 score is not provided

Privilege escalation bug was found in android binder driver.  There is
no detail about this vulnerability.
No CIP member enables CONFIG_ANDROID_BINDER_IPC.

Fixed status
mainline: [9a0a930fe2535a76ad70d3f43caeccf0d86a3009,
09184ae9b5756cc469db6fd1d1cfdcffbf627c2d,
  656e01f3ab54afe71bed066996fc2640881e1220,
6d98eb95b450a75adb4516a1d33652dc78d2b20c,
  ef38de9217a04c9077629a24652689d8fdb4c6c6,
2d1746e3fda0c3612143d7c06f8e1d1830c13e23]
stable/5.10: [2e3c27f24173c6f3d799080da82126fa044a2f5e,
c9d3f25a7f4e3aab3dfd91885e3d428bccdcb0e1,
  5204296fc76623552d53f042e2dc411b49c151f2,
23e9d815fad84c1bee3742a8de4bd39510435362,
  ae9e0cc973fb7499ea1b1a8dfd0795f728b84faf,
017de842533f4334d646f1d480f591f4ca9f5c7a]
stable/5.4: [15e098ab1d3c8d6b2521b7cc4bc6da80936e9af6,
74e7f1828ab4205ebacf7c92b700279113dd075d,
  7b31ab0d9efb032ac1a8f25d419f7b9df1b1cfe3,
c056a6ba35e00ae943e377eb09abd77a6915b31a,
  4741b00cac23d5fe7d6f74858dff1968eeb1b63a,
4e682ce5601a617b105b7f801f67511dfbd04079]

* Updated CVEs

CVE-2022-4129: l2tp: missing lock when clearing sk_user_data can lead
to NULL pointer

5.4 was fixed.

Fixed status
mainline: [b68777d54fac21fc833ec26ea1a2a84f975ab035,
af295e854a4e3813ffbdef26dbb6a4d6226c3ea1]
stable/5.10: [e34a965f771f1977f172593c73e373036c765724,
5b209b8c99d487a1c32983981bf3552980fda591]
stable/5.15: [87d9205d9a57dfc1f39f840b32e38475c3f523f6,
22c7d45ca3d7672f0b209783726d7559a2343f21]
stable/5.4: [7188c37f3c2527086aa46cbb37060fa73b144c65,
4fd6a6b1019e56ece1886d854a87051ffc86957f]

CVE-2023-23559: rndis_wlan: Prevent buffer overflow in rndis_query_oid

4.14, 4.19, and 5.4 were fixed.

Fixed status
mainline: [b870e73a56c4cccbec33224233eaf295839f228c]
stable/4.14: [8a97563bf04358f035a0b98142ae48f1ef095b61]
stable/4.19: [b4cc9d7ae9bed976de5463958afea2983b4ca57f]
stable/5.10: [802fd7623e9ed19ee809b503e93fccc1e3f37bd6]
stable/5.15: [8cbf932c5c40b0c20597fa623c308d5bde0848b5]
stable/5.4: [9042a9a3f29c942387e6d6036551d90c9ae6ce4f]
stable/6.1: [7794efa358bca8b8a2a80070c6e088a74945f018]

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

