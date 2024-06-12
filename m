Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF3BC27C53
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 22:48:16 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web11.2163.1718232489543444608
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Jun 2024 15:48:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=wY5B1DbQ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24c9f630e51so175120fac.1
        for <cip-dev@lists.cip-project.org>; Wed, 12 Jun 2024 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1718232488; x=1718837288; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eage0LeonAMN26G4Sn/VGIMSTHoKAltFVbS0E2bRLX8=;
        b=wY5B1DbQOp3Q44oRtfIOR4PZFJ06r9DjxhwJeenB0nzjwRUf6Ujnk1gsNNV0t4Wzk8
         cMVymOmvQFbhpOCLiA9zk5vj2g29+IIY4Vc8AoaHqqbnFUavXeg4joZPJlvIc16eoHMM
         ZfABBaC1wn6BuZojWCFwIGsQS72qVZoNcTSPeSY2kN1isWcminH6CkxhbpwXXCxDOqPt
         CLal/bXAn4Zry+DDfFLtSpjqKYp5B/oMIBqVTtoREWupt1ltlz6ZpmrAql7K2E3JurR8
         UBax8dVYxmiLz3LqMS2bKZo1ihlXHksEteeDUirYb9XWnHpsPE47qvo9YMFJhKT+PHeq
         Nm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232488; x=1718837288;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eage0LeonAMN26G4Sn/VGIMSTHoKAltFVbS0E2bRLX8=;
        b=gux0FAKaV8Obg+0aJ1tlOMRsWYfK/UIgnXWpBHGq8CGiA7XPQIfuOPiwn/k8FWvJcy
         h4FNzco5+FG3aaFhHRYONpXCffLnSzzVcbIfhGpSTsBf+cVYQof97IbPnfxRBcg9my7X
         oDC8L9lVnzQPAKPZ7IA3KHoT4Wi5sl7RCEhoXZ2lHM14K7TE3+L7T2IX9Dn3T6ZY1KLW
         OrhRZF/k67mDX8pJFOVihhdnLK2XNgcszx4kIvXadu2qfkQ2rxbvTlxf8HsoPU+NQIev
         3YoMlyOu9ydUYOFboO1n/FdlzqiL0jJYW0Mxi+KB4Jux8k0jTwI2DclQ4jqlrYxJVkUY
         w8Eg==
X-Gm-Message-State: AOJu0YzeHcxJqNihjYO2mEqc9fqWhsfY2VEOZlVGaHzHUXDA3OE89O+L
	XjC6d3B3bJQ7XuR5UMLypOwTjnQUY5n2ak2L6N+qmfrb9qOANTNdQSqdhqbXDBUe4dR94bMl9G/
	/RcYydIuxXKS+jCiCx3I4Yw6A+MTIOOyApVX9bkRmC7IUeadOjqk=
X-Google-Smtp-Source: AGHT+IFQqYWboUCVF6f7/78QynqclL61Tl6m7GZQLqkUqY+Cl6a//LlJwo57goSWK2HYnegZcNh8V/7Sosx1VfLScEQ=
X-Received: by 2002:a05:6871:7429:b0:24f:e8f1:675b with SMTP id
 586e51a60fabf-25514cc5e09mr3541268fac.30.1718232488301; Wed, 12 Jun 2024
 15:48:08 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Jun 2024 07:47:32 +0900
Message-ID: <CAODzB9ptLM+NR6XdpB3pp5r9z4trTw-Ty68QhqJM6xtkPN1LjA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Jun 2024 22:48:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16195

Hi!

It's this week's CVE report.

This week reported 8 new CVEs and 4 updated CVEs.

* New CVEs
CVE-2024-36965: remoteproc: mediatek: Make sure IPI buffer fits in L2TCM

Announce: https://lore.kernel.org/linux-cve-announce/2024060801-CVE-2024-36965-dfe6@gregkh/

Introduced by commit 3efa0ea ("remoteproc/mediatek: read IPI buffer
offset from FW") in v5.11-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [331f91d86f71d0bb89a44217cc0b2a22810bbd42]
stable/5.15: [00548ac6b14428719c970ef90adae2b3b48c0cdf]
stable/6.1: [1d9e2de24533daca36cbf09e8d8596bf72b526b2]
stable/6.6: [26c6d7dc8c6a9fde9d362ab2eef6390efeff145e]

CVE-2024-36966: erofs: reliably distinguish block based and fscache mode

Announce: https://lore.kernel.org/linux-cve-announce/2024060804-CVE-2024-36966-8bbb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc7.
This bug depends on the status of the EROFS_FS_ONDEMAND option. This option was
introduced by commit c6be2bd0 ("erofs: register fscache volume") in 5.19-rc1.
Also commit 9c0cc9c7 ("erofs: add 'fsid' mount option") in 5.19-rc1 changes
erofs_kill_sb() to support on-demand read semantics. It seems as if commit
9c0cc9c7 causes this bug.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7af2ae1b1531feab5d38ec9c8f472dc6cceb4606]
stable/6.6: [f9b877a7ee312ec8ce17598a7ef85cb820d7c371]

CVE-2024-36967: KEYS: trusted: Fix memory leak in tpm2_key_encode()

Announce: https://lore.kernel.org/linux-cve-announce/2024060804-CVE-2024-36967-b73d@gregkh/

Introduced by commit f221974 ("security: keys: trusted: use ASN.1 TPM2
key format for the blobs") in v5.13-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffcaa2172cc1a85ddb8b783de96d38ca8855e248]
stable/5.15: [1e6914fa8e7798bcf3ce4a5b96ea4ac1d5571cdf]
stable/6.1: [5d91238b590bd883c86ba7707c5c9096469c08b7]
stable/6.6: [e62835264d0352be6086975f18fdfed2b5520b13]

CVE-2024-36968: Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024060804-CVE-2024-36968-6d78@gregkh/

Introduced by commit 6ed58ec ("Bluetooth: Use LE buffers for LE
traffic") in v2.6.39-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5b862c6a221459d54e494e88965b48dcfa6cc44]
stable/6.6: [ad3f7986c5a0f82b8b66a0afe1cc1f5421e1d674]

CVE-2024-36969: drm/amd/display: Fix division by zero in setup_dsc_config

Announce: https://lore.kernel.org/linux-cve-announce/2024060804-CVE-2024-36969-6945@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
The setup_dsc_config() was introduced by commit 97bda032 ("drm/amd/display:
Add DSC support for Navi (v2)") in 5.3-rc1. It seems as if this bug exists
since this commit.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [130afc8a886183a94cf6eab7d24f300014ff87ba]
stable/5.15: [a32c8f951c8a456c1c251e1dcdf21787f8066445]
stable/6.1: [91402e0e5de9124a3108db7a14163fcf9a6d322f]
stable/6.6: [7e4f50dfc98c49b3dc6875a35c3112522fb25639]

CVE-2024-36970: wifi: iwlwifi: Use request_module_nowait

Announce: https://lore.kernel.org/linux-cve-announce/2024060855-CVE-2024-36970-2eb9@gregkh/

Introduced by commit f5c31bc ("Merge tag 'leds-next-6.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds") in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d913719df14c28c4d3819e7e6d150760222bda4]

CVE-2024-36971: net: fix __dst_negative_advice() race

Announce: https://lore.kernel.org/linux-cve-announce/20240610090330.1347021-2-lee@kernel.org/

Introduced by commit a87cb3e ("net: Facility to report route quality
of connected sockets") in v4.6-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92f1655aa2b2294d0b49925f3b875a634bd3b59e]

CVE-2024-36972: af_unix: Update unix_sk(sk)->oob_skb under
sk_receive_queue lock.

Announce: https://lore.kernel.org/linux-cve-announce/20240610145748.1497527-2-lee@kernel.org/

None
Introduced by commit 2aab4b9 ("af_unix: fix struct pid leaks in OOB
support") in 6.3-rc2. Fixed in 6.3-rc2. Bug introduced commit was
backported to 5.15 and 6.1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [9841991a446c87f90f66f4b9fee6fe934c1336a2]
stable/6.1: [4bf6964451c3cb411fbaa1ae8b214b3d97a59bf1]
stable/6.6: [d59ae9314b97e01c76a4171472441e55721ba636]

* Updated CVEs

CVE-2024-24863: Null pointer dereference bug in malidp_mw_connector_reset

stable 6.1 and 6.6 were fixed.

Fixed status
mainline: [a1f95aede6285dba6dd036d907196f35ae3a11ea]
stable/6.1: [e4b52d49383306ef73fd1bd9102538beebb0fe07]
stable/6.6: [335cc45ef2b81b68be63c698b4f867a530bdf7a5]
stable/6.9: [93f76ec1eddce60dbb5885cbc0d7df54adee4639]

CVE-2024-36014: drm/arm/malidp: fix a possible null pointer dereference

stable 6.1 and 6.6 were fixed.

Fixed status
mainline: [a1f95aede6285dba6dd036d907196f35ae3a11ea]
stable/6.1: [e4b52d49383306ef73fd1bd9102538beebb0fe07]
stable/6.6: [335cc45ef2b81b68be63c698b4f867a530bdf7a5]
stable/6.9: [93f76ec1eddce60dbb5885cbc0d7df54adee4639]

CVE-2024-36015: ppdev: Add an error check in register_device

stable 6.1, 6.6, and 6.9 were fixed.

Fixed status
mainline: [fbf740aeb86a4fe82ad158d26d711f2f3be79b3e]
stable/6.1: [df9329247dbbf00f6057e002139ab3fa529ad828]
stable/6.6: [ec3468221efec6660ff656e9ebe51ced3520fc57]
stable/6.9: [5d5b24edad1107a2ffa99058f20f6aeeafeb5d39]

CVE-2024-36016: tty: n_gsm: fix possible out-of-bounds in gsm0_receive()

stable 6.1 and 6.6 were fixed.

Fixed status
mainline: [47388e807f85948eefc403a8a5fdc5b406a65d5a]
stable/6.1: [46f52c89a7e7d2691b97a9728e4591d071ca8abc]
stable/6.6: [774d83b008eccb1c48c14dc5486e7aa255731350]
stable/6.9: [b890d45aaf02b564e6cae2d2a590f9649330857d]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

