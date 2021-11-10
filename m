Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3376C433EF
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 23:53:13 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web10.3669.1636588390699285665
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Nov 2021 15:53:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=XJZxdf2M;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.48,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f48.google.com with SMTP id
 l7-20020a0568302b0700b0055ae988dcc8so6331067otv.12
        for <cip-dev@lists.cip-project.org>;
 Wed, 10 Nov 2021 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=BQYmft/5zQ/dRA0I/KiLn8Yntw6CmBwxxOhSTj1b0nQ=;
        b=XJZxdf2MbxviteV5NDKDuR4vwtQgd5MyuCLD5RTr/yqNOjMVwUi296v3w3BCV6kTOG
         2UOS94KU/g3eTWMMSSxaYF27xKmfDVbrgZU6sz/PofbXL9qPtxBSDUxvG62BeHwRptUd
         Q6DPi6rdIKPaSDERMEVLvVwJHYkDZdV3G9UJo/JBvYQPR5uzsspvXDaP/cYFYrB4E9Om
         lLr6W0kOtjkMECSpT3CCh3JJOO7vIbhuKvpy7iIIy/uBfNbvvAlq/nLx+QsBxgwbuTLU
         G7/1T1lWVbIZuEbufu5q+iNw4k8IFq+alcs0YblhUtP7lMr4aV72l20vx8yclGb7v8tO
         6zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BQYmft/5zQ/dRA0I/KiLn8Yntw6CmBwxxOhSTj1b0nQ=;
        b=x/lNbxhnLd/jHG7nO7mCvxrWoolvORKrcWruiewYfmVIRsch+mO2hujFCeQWhfyIVm
         IY1Nmb6lKA75BKnBzHNukHrlsnKb0LIMazdUD/uIH/1k618wRzUCZPhY91WtxVuF6+Xa
         c5QhT2KFBCM/0gWQ2JrmiV40Az3IFUqsx23xdQhkvf5pqAFckyQTHd3n7BiJfpYpTiT4
         VqqfMB0oInvZ/AI5EJ1cnUWIfqXsOOVjlL7HpDjCdU/YPhgNO5v+DgTzxlcjLRLj1yqn
         hbeBR2yd6lpVAxjC7VbtI5qBGi4SHX3ZI8T5cB2ylu0fg8o3yoTXdqYl0J/F96EVMrFS
         PIgg==
X-Gm-Message-State: AOAM531mdVjBpW1j/WIuXRgw6q8Ww0XCx1YZD4HW65FCJm7GihXQ/TVP
	ZojGQ1I+W0aDs2A9YLLnCjdqxaX9q5pslI+NIuC/kKC2nkcJRQ==
X-Google-Smtp-Source: 
 ABdhPJyJ1iKO2iImTEINbp0bJl4d+1VWwdLY1fj3yQJPpAg1or+xkMZbYz3NnWSw7GJltz0Hsee8kjmCOq/nklyd41A=
X-Received: by 2002:a9d:4a8d:: with SMTP id i13mr2587633otf.180.1636588389559;
 Wed, 10 Nov 2021 15:53:09 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Nov 2021 08:52:33 +0900
Message-ID: 
 <CAODzB9okpxqQ9ezVD0ua8wKqCjo=j1zw0pU18v7gmE=r1KGOQg@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Nov 2021 23:53:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6872

Hi !

It's this week's CVE report.

This week reported 4 new CVEs.

* New CVEs

CVE-2021-0920: af_unix: fix garbage collect vs MSG_PEEK

CVSS v3 score is not provided.

Mainline and stable kernels are already fixed.

Fixed status

mainline: [cbcf01128d0a92e131bd09f1688fe032480b65ca]
stable/4.14: [af3e2b87b36100c28feb71da52c57293c4540690]
stable/4.19: [1dabafa9f61118b1377fde424d9a94bf8dbf2813]
stable/4.4: [72247f34d90e25c1493436e45e193e8306082b19]
stable/4.9: [a805a7bd94644207d762d9c287078fecfcf52b3e]
stable/5.10: [93c5951e0ce137e994237c19cd75a7caa1f80543]
stable/5.4: [85abe0d47fe65391ed41f78a66b5eff73987c086]

CVE-2021-0929: staging: ion: move buffer kmap from begin/end_cpu_access()

CVSS v3 score is not provided.

ION is a memory manager which is used by Android. This CVE may affect
4.4, 4.19, and 5.10 however according to the cip-kernel-config, no cip
member enabled ION. The ION driver has been removed since 5.11.

Fixed status

mainline: [3e9e0c5c764704218c0960ffdb139de075afaadf]

CVE-2021-3736: uninitialized kernel stack may lead to information disclosure

According to the Red Hat
bugzilla(https://bugzilla.redhat.com/show_bug.cgi?id=1995570), there
is a memory leak problem in samples/vfio-mdev/mbochs.c. This
vulnerability is in a sample code. Also no cip member enabled
CONFIG_SAMPLE_VFIO_MDEV_MBOCHS. Bugzilla comment #6 pointed commit
de5494af4815a4c9328536c72741229b7de88e7f ("vfio/mbochs: Fix missing
error unwind of mbochs_used_mbytes
") as a fix commit but not confirmed yet. If commit de5494af4815a is
the fix, this vulnerability was introduced since 5.14-rc1.

Fixed status

Not fixed.

CVE-2021-43389: isdn: cpai: check ctr->cnr to avoid array index out of bound

CVSS v3 score is "5.5 MEDIUM".

The array index out of bound bug in the drivers/isdn/capi/kcapi.c.
This bug has been fixed in mainline and stable kernels. No cip member
use CAPI.

Fixed status

mainline: [1f3e2e97c003f80c4b087092b225c8787ff91e4d]
stable/4.14: [9b6b2db77bc3121fe435f1d4b56e34de443bec75]
stable/4.19: [7d91adc0ccb060ce564103315189466eb822cc6a]
stable/4.4: [e8b8de17e164c9f1b7777f1c6f99d05539000036]
stable/4.9: [24219a977bfe3d658687e45615c70998acdbac5a]
stable/5.10: [7f221ccbee4ec662e2292d490a43ce6c314c4594]
stable/5.14: [cc20226e218a2375d50dd9ac14fb4121b43375ff]
stable/5.4: [285e9210b1fab96a11c0be3ed5cea9dd48b6ac54]


* Updated CVEs

CVE-2021-42739: media: firewire: firedtv-avc: fix a buffer overflow in
avc_ca_pmt()

4.19 and 5.X kernels have been fixed in this week. However, appliying
patch to 4.4 and 4.9 are failed.
According to the cip-kernel-config repo, no CIP member uses firewire driver.

Fixed status

mainline: [35d2969ea3c7d32aee78066b1f3cf61a0d935a4e]
stable/4.19: [53ec9dab4eb0a8140fc85760fb50effb526fe219]
stable/5.10: [d7fc85f6104259541ec136199d3bf7c8a736613d]
stable/5.14: [02a476ca886dc8155025fe99cbbad4121d029fa7]
stable/5.15: [cb667140875a3b1db92e4c50b4617a7cbf84659b]
stable/5.4: [2461f38384d50dd966e1db44fe165b1896f5df5a]

CVE-2021-3892: memory leak in fib6_rule_suppress could result in DoS

According to the SUSE bugzilla
(https://bugzilla.suse.com/show_bug.cgi?id=1192261#c1), this CVE is
duplicate of CVE-2019-18198.
If so, this CVE is already fixed.

CVE-2021-3640: UAF in sco_send_frame function

Fixed commit is 99c23da0eed4fd20cae8243f2b51e10e66aa0951 ("Bluetooth:
sco: Fix lock_sock() blockage by memcpy_from_msg()"). Backport patches
for 4.19, 5.4, 5.10, 5.14, and 5.15 have been sent to stable mailing
list on Nov 9. This fix can be applied to 4.4 by git-am without error.

mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]

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

