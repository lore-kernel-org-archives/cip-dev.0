Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD6FC433F5
	for <webhook@archiver.kernel.org>; Thu, 28 Oct 2021 00:05:48 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web12.4570.1635379545944239943
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Oct 2021 17:05:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=nEkb9X5L;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.51,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f51.google.com with SMTP id
 l10-20020a056830154a00b00552b74d629aso6106879otp.5
        for <cip-dev@lists.cip-project.org>;
 Wed, 27 Oct 2021 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wfZA8ShUp/3+RhlYrcGr14WPmp5Yig/FKB0VevXCu9U=;
        b=nEkb9X5LYaKP8qij3JpFb22KAOov0Oskhq4SOAweDrXf4LYG79gQ1EE0u6iowa4uI7
         Gzpy+m7poAcfkb/7bcuWmxO68heDlTaf4mxJs9Hxkek+uXHdZDmmqq5reuhXbPYKA205
         +UVVqVQ0XlUEwh4yl45FdazSOd3lJk7igV6fhqASS5JndpaoS6aoPBG/y1U0IEIIG8Wp
         BoLaTvcYf8gD/09zCsyj/2BRUFkiwoI0skfxs31bypTtogF8T982rlOdr8MJaLU2HG4m
         2f81/Vbt4DdYeUcPOt6zSXu4mKFKuivSpPdDVLQ2f2HcHdRliY6s6DixJS87f7x+FnqR
         70fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wfZA8ShUp/3+RhlYrcGr14WPmp5Yig/FKB0VevXCu9U=;
        b=bFlRwPaedV++XirbKsi3cbcsD+810BDf/rrLSW1yTVswBXvlld0102VqCAJTOu+FY2
         bPZ2RAtCjBdniY8HxE67UyRTr/jGo2vb82GkjPhidCefFkFgvour+I/Gl3YZ4iL7X8AU
         LLMJk9ydjgNPAbY+YXjnO90SpugBCju+pdja4db3/i1PIqmPA4ZCyTlB9ccLbFj09aag
         KThAdE9ASqsWXrtrsp2x6aWsldyhrYqjrzNR0sPw0qVsoJB44BQuZo1TPjFFV4kIutM2
         IGOl5uUoePqtEtNuQq9CZfOai8JdJNhmgXfz1osVa+f5YhmZsp6xTmN+vAwKQMA16kMS
         DgvQ==
X-Gm-Message-State: AOAM531D/5Hhw6L4G/w0O2DM1Mr3fwx4QQNBHOPTnUqzwGXnWAcfb/sE
	65sesLnsBQDhSFNu51VkokzG2pgbpIfDcPkIxrZoYT4lz1wVWg==
X-Google-Smtp-Source: 
 ABdhPJwfSmySFSPnrEF2/yz534itaAjEBGNNxLzmEmBAM4cg+11SrwQ94QBEVcyNOPeAYOU6VlGrUBhczN89bHuXpWY=
X-Received: by 2002:a05:6830:147:: with SMTP id
 j7mr741358otp.67.1635379544782;
 Wed, 27 Oct 2021 17:05:44 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 Oct 2021 09:05:08 +0900
Message-ID: 
 <CAODzB9rhgj0tKE1RqMZyMmj9op3ODqSBJsDvvgdLHHy-4d9xxQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Oct 2021 00:05:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6842

Hi !

It's this week's CVE report.

This week reported 3 new CVEs. These CVEs are already fixed.

* New CVEs

CVE-2021-3896: isdn: cpai: check ctr->cnr to avoid array index out of bound

According to the cip-kernel-config, no CIP member enables CONFIG_ISDN
so CIP member won't affect this vulnerability.

CVSS v3 score is not provided.

Fixed in 5.15-rc6. All stable kernels are fixed.

Fixed status

mainline: [1f3e2e97c003f80c4b087092b225c8787ff91e4d]
stable/4.14: [9b6b2db77bc3121fe435f1d4b56e34de443bec75]
stable/4.19: [7d91adc0ccb060ce564103315189466eb822cc6a]
stable/4.4: [e8b8de17e164c9f1b7777f1c6f99d05539000036]
stable/4.9: [24219a977bfe3d658687e45615c70998acdbac5a]
stable/5.10: [7f221ccbee4ec662e2292d490a43ce6c314c4594]
stable/5.14: [cc20226e218a2375d50dd9ac14fb4121b43375ff]
stable/5.4: [285e9210b1fab96a11c0be3ed5cea9dd48b6ac54]

CVE-2021-3760: nfc: nci: fix the UAF of rf_conn_info object

CVSS v3 score is not provided.

Fixed in 5.15-rc6. All stable kernels are fixed.

Fixed status

mainline: [1b1499a817c90fd1ce9453a2c98d2a01cca0e775]
stable/4.14: [a2efe3df65359add2164740a5777c26e64dd594b]
stable/4.19: [1ac0d736c8ae9b59ab44e4e80ad73c8fba5c6132]
stable/4.4: [1d5e0107bfdbef6cc140fb5d7a1a817a40948528]
stable/4.9: [8a44904ce83ebcb1281b04c8d37ad7f8ab537a3d]
stable/5.10: [77c0ef979e32b8bc22f36a013bab77cd37e31530]
stable/5.14: [6197eb050cfab2c124cd592594a1d73883d7f9e8]
stable/5.4: [1f75f8883b4fe9fe1856d71f055120315e758188]

CVE-XXXX-XXXXX: KVM: PPC: Book3S HV: Make idle_kvm_start_guest()
return 0 if it went to guest

CVE number hasn't been assigned yet.

This vulnerability has been introduced since 5.2-rc1 so before 5.2
kernels aren't affected this issue. also it's only affected powerpc
architecture.

Fixed status

mainline: [cdeb5d7d890e14f3b70e8087e745c4a6a7d9f337]
stable/5.10: [197ec50b2df12dbfb17929eda643b16117b6f0ca]
stable/5.14: [5a8c22e7fb66260c9182ee3a3085c2046503c54b]
stable/5.4: [d0148cfaf89ce2af0d76e39943e200365e7fc99a]

* Updated CVEs

CVE-2021-20321: ovl: fix missing negative dentry check in ovl_rename()

stable/4.4 has been fixed this week. All stable kernels are fixed.

Fixed status

mainline: [a295aef603e109a47af355477326bd41151765b6]
stable/4.14: [1caaa820915d802328bc72e4de0d5b1629eab5da]
stable/4.19: [9d4969d8b5073d02059bae3f1b8d9a20cf023c55]
stable/4.4: [a4f281ffc1d128d7ea693cbc3a796e56e919fd7c]
stable/4.9: [286f94453fb34f7bd6b696861c89f9a13f498721]
stable/5.10: [9763ffd4da217adfcbdcd519e9f434dfa3952fc3]
stable/5.14: [71b8b36187af58f9e67b25021f5debbc04a18a5d]
stable/5.4: [fab338f33c25c4816ca0b2d83a04a0097c2c4aaf]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2021-3640: UAF in sco_send_frame function

Fixed in bluetooth-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/sco.c?id=99c23da0eed4fd20cae8243f2b51e10e66aa0951

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

