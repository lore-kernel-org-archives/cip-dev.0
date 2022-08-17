Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F28C3F6B0
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 23:24:08 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web11.35660.1660778642144820834
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 16:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Etlb0wEV;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.53,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-f2a4c51c45so17740fac.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=PlZfJOjaQu7BcbyITJymJG9gFqX7R2Vo/0qWbGaake8=;
        b=Etlb0wEVO2YyfydyAAMf16Ru+X2JK47H7UjEZF/0f3BWpUUJM15zbKv8nP4be2QYS5
         /Szl+A1DRjeYJ5LO6RH9QYoZLBUZ5s+S0OUi8FU1P/gVM0qPIGaaDYa6J4qiyGRam9bq
         gJJVxlNJ6hbb71jAnwSQxa9lkdMHrXBRkZJ8Hw1KeQRv/g0BqfzZKevyLIXafVt/18RE
         savS3bz+jAAina6dRPF+9ITRgutGQrLqWurr0Uys+PZ5PjYAcrdLZ0LDgnC3LD7PE90l
         Auou3dnm4P+fyc7YoGtylREHxn+HaBQP9GlQd8KWpi2gXr6aP6WZfl+mSlQdaHSebECd
         ivGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=PlZfJOjaQu7BcbyITJymJG9gFqX7R2Vo/0qWbGaake8=;
        b=Mp4AGLlqOfJTIKDYx9kVKm/D7ewfsyBs9xZ3V1R5qqsvLZfkE4/sExxWHWvJ2sm16h
         EQILY8mWAQoy+xbfRzogrwJDSEEzB0UfL+2+G1QlxIR/t4Tv6CVUqIPBzosR5gr/ZjEJ
         WlhgYId0y2PFY8xfW0+kARZzEDYPAre21WOqW0O9NiyZQwTdiHAiNTFrDK9ZR8pJHaR6
         1wZdo9ZFCNe8EUIXDpCdQzLf4foOAJWqjc6kmMXa9RLtT5iGooVOKHWbd5j6pe8y+fhd
         YzaikflNyIry89rTNi9+LqZEXaL1Y0KXHhT6hBlLKHih4K4ZRL9d2/HzLkNPXYsSQ4h/
         kTDg==
X-Gm-Message-State: ACgBeo2SCmvkEz8dGpqOyziIduBNYBnT8zeLzlA2SYkwismMoF1haqEl
	a/lo5Q3dybCQ4daUriO7Vbv4Agj0rBJvqwsQ4CdPezvFyd/HdA==
X-Google-Smtp-Source: 
 AA6agR65CU85OS7RFY6LWoQhzD+RiTrtBRVO6JAo8oAI5qlseWs6pJhzpxl8AWiD9sk4xlnQ9S93UK5g+gPuZiUBudQ=
X-Received: by 2002:a05:6870:e313:b0:10e:757c:d388 with SMTP id
 z19-20020a056870e31300b0010e757cd388mr129580oad.280.1660778640868; Wed, 17
 Aug 2022 16:24:00 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Aug 2022 08:23:24 +0900
Message-ID: 
 <CAODzB9qbas0NgACadYMf7wpkRCEBeV8kQmFaNpTtL-k89Zdhwg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 23:24:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9281

Hi !

It's this week's CVE report.

This week reported 1 new CVEs and 6 updated CVEs.

* New CVEs

CVE-2022-2503: LoadPin bypass via dm-verity table reload

NIST: CVSS v3 score is not assigned.
Google: 6.9 MEDIUM

Dm-verity is used for extending root-of-trust to root filesystems.
LoadPin builds on this property to restrict module/firmware loads to
just the trusted root filesystem. Device-mapper table reloads
currently allow users with root privileges to switch out the target
with an equivalent dm-linear target and bypass verification till
reboot. This allows root to bypass LoadPin and can be used to load
untrusted and unverified kernel modules and firmware, which implies
arbitrary kernel execution and persistence for peripherals that do not
verify firmware updates.

The struct target_type verity_target is defined in
drivers/md/dm-verity.c in 4.4.302.

Fixed status
mainline: [4caae58406f8ceb741603eee460d79bacca9b1b5]
stable/4.14: [388bc1e69663956f8cee43af3bd02bd3061d222d]
stable/4.19: [6bff6107d1364c95109609c3fd680e6c8d7fa503]
stable/4.9: [27798cca4e54fe9c390396c4cc655480f827bbd5]
stable/5.10: [8df42bcd364cc3b41105215d841792aea787b133]
stable/5.15: [69712b170237ec5979f168149cd31e851a465853]
stable/5.18: [417c73db67ea7ad8f03dfd34c6b0bb5f54294fa9]
stable/5.4: [fd2f7e9984850a0162bfb6948b98ffac9fb5fa58]

* Updated CVEs

CVE-2021-4159: bpf: Verifer, adjust_scalar_min_max_vals to always call
update_reg_bounds()

stable 5.4 was fixed this week.

Fixed status
mainline: [294f2fc6da27620a506e6c050241655459ccd6bd]
stable/5.4: [7c1134c7da997523e2834dd516e2ddc51920699a]

CVE-2022-20369: media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP
buffers across ioctls

stable 5.4 was fixed this week.

Fixed status
mainline: [8310ca94075e784bbb06593cd6c068ee6b6e4ca6]
stable/5.10: [8a83731a09a5954b85b1ce49c01ff5c2a3465cb7]
stable/5.15: [48d00e24822e4384edcee3aae03d54c1b7982eba]
stable/5.4: [54e1abbe856020522a7952140c26a4426f01dab6]

CVE-2022-26373: Post-Barrier Return Stack Buffer Predictions (PBRSB)

stable 4.19, 5.10, 5.15, 5.18, and 5.4 were fixed this week.

Fixed status
mainline: [2b1299322016731d56807aa49254a5ea3080b6b3,
ba6e31af2be96c4d0536f2152ed6f7b6c11bca47]
stable/4.19: [b6c5011934a15762cd694e36fe74f2f2f93eac9b,
b1c9f470fb724d3cfd6cf8fe4a70c2ec4de2e9f4]
stable/5.10: [509c2c9fe75ea7493eebbb6bb2f711f37530ae19,
1bea03b44ea2267988cce064f5887b01d421b28c]
stable/5.15: [7fcd99e889c0634f8275ae7a6b06aec4a22c8715,
5c5c77746ce1108833d1fda005598a749eaef2cb]
stable/5.18: [0abdbbd9ae9c81615836278d787a8c8dcd576c36,
fd2128cd778f46f5444967ed203b91120ebdda72]
stable/5.19: [f826d0412d80348aa22274ec9884cab0950a350b,
f6664a403f11c97929ebde920da1ec1c10438428]
stable/5.4: [f2f41ef0352db9679bfae250d7a44b3113f3a3cc,
b58882c69f6633dcebd66bdb38658f688aa52ec9]

CVE-2022-36946: kernel panic when sending nf_queue verdict with 1-byte
nfta_payload attribute

stable/4.19 was fixed this week.

Fixed status
mainline: [99a63d36cb3ed5ca3aa6fcb64cffbeaf3b0fb164]
stable/4.19: [f295d365b30626f82423a923695274024016380e]
stable/5.10: [440dccd80f627e0e11ceb0429e4cdab61857d17e]
stable/5.15: [91c11008aab0282957b8b8ccb0707d90e74cc3b9]
stable/5.18: [883c20911d6261fc651820b63a77327b8c020264]
stable/5.4: [52be29e8b6455788a4d0f501bd87aa679ca3ba3c]

CVE-2022-2588: Linux kernel cls_route UAF

The mainline, stable 5.15, 5.18, and 5.19 were fixed this week.

Fixed status
mainline: [9ad36309e2719a884f946678e0296be10f0bb4c1]
stable/5.15: [57bbb691a93bd39d0644c5c879b354232d0e0eed]
stable/5.18: [e832c26e7edfa2ddbd2dcdd48016d13d747de6da]
stable/5.19: [ee3f18d90e80e79449d575fa3e7a6b775e9fc35e]


CVE-2022-2586: Linux kernel nf_tables cross-table reference UAF

The mainline was fixed this week. Stable 4.9 and 4.14 were failed to
apply 470ee20 (" netfilter: nf_tables: do not allow SET_ID to refer to
another table ").
The mainline, table 5.15, 5.18, and 5.19 were fixed this week.

Fixed status
mainline: [470ee20e069a6d05ae549f7d0ef2bdbcee6a81b2]
stable/5.15: [faafd9286f1355c76fe9ac3021c280297213330e]
stable/5.18: [f4fa03410f7c5f5bd8f90e9c11e9a8c4b526ff6f]
stable/5.19: [0d07039397527361850c554c192e749cfc879ea9]

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

