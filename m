Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3476C433F5
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 00:06:35 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web11.893.1637193992880674167
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 16:06:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=0f2ZC9Tc;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.46,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f46.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso7698621otj.11
        for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 16:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Mar4w8Nbiz9i4XspT/KvBuyoX1HTMNToidUGgcJB8Qk=;
        b=0f2ZC9Tcc0to9YF9CtxZsAOuOtJRdh4iHtg1uezNridcONPzg6kkCo/DEISTBWc78b
         x8iXL9fIjPn5NZ0nKVbIPcspeck36jLzcjnvwJ5JHyQc7pr+UOK2uL3onWHPrjE0VPVW
         tBM2jHfQlJwq8h1fu2OHxmrxYGkz7mfzHZYvbFCHlSffiIx/XK/TRKmQ7EvNGlnrjzDj
         fhdA+y8+QSvRP4/9QRfnm+WyM44Q5rPjQ4Zt9lXIUZ9xbG/msc11B+ZRVQ8ZCNSvpTb7
         EhNfGWkLxcu0pasGbFN0cZUv7yKdHD0kehBZ1Dl9fnWgYUawZu8UBjtRo1HrS6+yb60w
         W3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Mar4w8Nbiz9i4XspT/KvBuyoX1HTMNToidUGgcJB8Qk=;
        b=4PdKhAEEDe8ayiOcNaCdbZNHRY0wwVJHCzfS/ScCNIAGpiLypq7O0df6ekk0oVUx6+
         XEt9CqwjbC7pA6i4cw/D8TxWI+aQI/TCA+oF79Fb1+x0kBJYTcKtyYKQvrUqTIjUHCXo
         61mv03L8w1UIsLIUnOZc/9V+iJWpd9ftxRccfC7CBOC3psBzo9J3GCfNSz0OjAU14IrL
         QAiUXM/xSclDc0foObJ58AhAnnO4Lh/VTKupcjAKiCR0GTyL9Jm5D2cvIB7uFvcz99qF
         voAppzwYHscELDWmxdIYuzxHA5ys+G2IzVkx1ZRK/ctPfS2wU+ZBSDI3RFvdQm+fNEeT
         EESw==
X-Gm-Message-State: AOAM533s0kU5rzbdi5y6NkVcqVj5meBaSUhanSJkUyPsSXdP9uXD7lO7
	X2q2NE75s4wDYYhn2GJpH4LkVwJ9ABzw6WyEgSVn6DzyOrqHAg==
X-Google-Smtp-Source: 
 ABdhPJz425mpq1fyKelKAunQ2ujt5uIOh0uRows36UlbFudAIAkIEVMF99ZByElbCofcPjjCUyTDw6ZY173j84KNs0c=
X-Received: by 2002:a9d:4a8d:: with SMTP id
 i13mr18005899otf.180.1637193991959;
 Wed, 17 Nov 2021 16:06:31 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Nov 2021 09:05:56 +0900
Message-ID: 
 <CAODzB9rpX2mcJ85o3w+PcuUWdRcPiujsFwJbrZwCJmo5fv_=+g@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Nov 2021 00:06:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6948

Hi !

It's this week's CVE report.

This week reported two new CVEs. They have not been fixed in the mainline yet.

* New CVEs

CVE-2021-43975: atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc_wait

CVSS v3 score is not provided.

OOB read/write bug in aQuantia device driver code. Patch was merged
into the netdev tree on Nov 15.

Fixed status

Not fixed in the mainline yet.

CVE-2021-43976: mwifiex_usb: Fix skb_over_panic in mwifiex_usb_recv

CVSS v3 score is not provided.

Bug is in the Marvell WiFi-Ex driver code. Patch is being in reviewed
on the linux-wireless list
(https://patchwork.kernel.org/project/linux-wireless/patch/YX4CqjfRcTa6bVL+@Zekuns-MBP-16.fios-router.home/).

Fixed status

Not yet.

* Updated CVEs

CVE-2021-37159: net: hso: do not call unregister if not registered

4.4 and 4.9 have been fixed. All stable kernels are fixed.

Fixed status

mainline: [a6ecfb39ba9d7316057cea823b196b734f6b18ca]
stable/4.14: [4c0db9c4b3701c29f47bac0721e2f7d2b15d8edb]
stable/4.19: [f6cf22a1ef49f8e131f99c3f5fd80ab6b23a2d21]
stable/4.4: [cbefdf724282e6a948885f379dc92ab841c2fee0]
stable/4.9: [88b912e02d75bacbb957d817db70e6a54ea3a21c]
stable/5.10: [115e4f5b64ae8d9dd933167cafe2070aaac45849]
stable/5.13: [eeaa4b8d1e2e6f10362673d283a97dccc7275afa]
stable/5.4: [fe57d53dd91d7823f1ceef5ea8e9458a4aeb47fa]


CVE-2021-42739: media: firewire: firedtv-avc: fix a buffer overflow in
avc_ca_pmt()

stable/4.14 has been fixed.

Fixed status

stable/4.14: [8d6c05da808f8351db844b69a9d6ce7f295214bb]
stable/4.19: [53ec9dab4eb0a8140fc85760fb50effb526fe219]
stable/5.10: [d7fc85f6104259541ec136199d3bf7c8a736613d]
stable/5.14: [02a476ca886dc8155025fe99cbbad4121d029fa7]
stable/5.15: [cb667140875a3b1db92e4c50b4617a7cbf84659b]
stable/5.4: [2461f38384d50dd966e1db44fe165b1896f5df5a]

CVE-2020-27820: use-after-free in nouveau kernel module

Fixed status

Patches were merged in 5.16-rc1.

mainline: [aff2299e0d81b26304ccc6a1ec0170e437f38efc,
abae9164a421bc4a41a3769f01ebcd1f9d955e0e,
  f55aaf63bde0d0336c3823bb3713bd4a464abbcf]

CVE-2021-3640: UAF in sco_send_frame function

Patch was merged in 5.16-rc1. Patch for 4.4, 4.9, 4.14, 4.19, and 5.10
are in the stable-rc tree.

Fixed status

mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]

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

