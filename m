Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FE3C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:19 +0000 (UTC)
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by mx.groups.io with SMTP id smtpd.web10.24548.1636993217068061067
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=sh2mQ58f;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.194,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pf1-f194.google.com with SMTP id z6so15489207pfe.7
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGmm5BjB0pWaI9BVDN3B8MYGxq0MR6yVroIW9jNCR7k=;
        b=sh2mQ58fJQHUB2iyPe5hfHWrILi4BArU59LEUNfEC+TiMFwSoNfhQQLg4hcMA7uTFv
         MUG6hbx4fvsybzhHo77MJHDyAXBWmUpo5iT0NejahUNlOaUXDJ6WbxpWpJE1PMf7qsAs
         bTTODlNJf1sNi+YMv7Fq4qAeVArTGdkQZN2D8XNUpwCzT6ptHou3KhhhWMcWUnCwFpR9
         PH6oHkiMPjtXDSRy72jz7cKTMlvFvsnqu7dULRwlc7z8eGzZhp2YsIGm4wnzxnHBvbUa
         pxHFm/348glv5eAaM0/jCbxOvqp0ltVSUwsGlb0utDVIn/uTXSmjZC3F7bcI9uc52H91
         f0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGmm5BjB0pWaI9BVDN3B8MYGxq0MR6yVroIW9jNCR7k=;
        b=MQdPJ4t9r66PdNmb8rrL2UwuNb5iU8dGoWOcxjJ8NNpL8lbwRBz+RlTs9LM+Nu82uD
         AKcgfvSwUlnJKSSqMVjmHD5Cbnjn7qJ4q1QI63foM4hkueQJViw87z4JSHWDydw85vbf
         aVFi4H2dAA3N9rNrxcZX5MJ2v+imgI2LuQcnPsccsVHneQnU8krCZNJXyxUB1vMGCSOC
         vyaIlF2265kq+JLf0FqR0rNaujJnE2KPEaByxnKoZraQz3rngWW356cn7eBbNE0xJoir
         3nuGBgT2Gy0BQsriz+i1WZSq++X6+HqK84Sclw2cRo0C+ODxUUg5Ik+qmKnl9FH9hvAe
         XpnQ==
X-Gm-Message-State: AOAM530QYoCW2hcfbQ5YjCGQ398orxigs55ZU06JfJnxOOfC18Xa7gue
	tHqk0b91ww2ujBzBL/jZA9uO785hmVCKEU4=
X-Google-Smtp-Source: 
 ABdhPJxaqm+yha9pYbHhNgP63VbXUFsGK+vOBl7jleFib22hHM2rrUNdGFcSJTM++43MR5J6aaisZw==
X-Received: by 2002:aa7:87c5:0:b0:4a0:25d0:d88c with SMTP id
 i5-20020aa787c5000000b004a025d0d88cmr33963488pfo.43.1636993215497;
        Mon, 15 Nov 2021 08:20:15 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:14 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 00/11] cip-core-image-kernelci
Date: Tue, 16 Nov 2021 01:17:13 +0900
Message-Id: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6903

This patch series add a new image with settings for 
KernelCI.

This new image is called cip-core-image-kernelci and is 
based on isar-cip-core general image.
The cip-core-image-kernelci images are built by GitlabCI
and uploaded to KernelCI production fileserver.
https://storage.kernelci.org/images/rootfs/cip/

These patches are already integrated in the
isar-cip-core:alicef/kernelci_image repository branch and
are generating the images that are currently 
used by KernelCI.

cip-core-image-kernelci as been tested and are
already used in KernelCI production with good results.
https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/

Alice Ferrazzi (11):
  Deploy tarballs and initrd to kernelci
  Rename initrd with the gz suffix
  Add latest folder to the storage fileserver
  Create kernelci build step
  Ignore extension argument when not set
  Enable KernelCI build step also for arm and arm64
  Create cip-core-image-kernelci
  Remove root password
  Set the profile for KernelCI
  dmesg.sh is needed for KernelCI
  Upload to KernelCI production

 .gitlab-ci.yml                                | 40 +++++++++-
 kas/opt/kernelci.yml                          | 16 ++++
 .../images/cip-core-image-kernelci.bb         | 16 ++++
 .../files/99-silent-printk.conf               |  1 +
 .../kernelci-customizations/files/dmesg.sh    | 23 ++++++
 .../kernelci-customizations/files/ethernet    | 23 ++++++
 .../kernelci-customizations/files/postinst    | 34 +++++++++
 .../kernelci-customizations.bb                | 38 ++++++++++
 scripts/deploy-kernelci.py                    | 76 +++++++++++++++++++
 9 files changed, 266 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/kernelci.yml
 create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
 create mode 100644 recipes-core/kernelci-customizations/files/99-silent-printk.conf
 create mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
 create mode 100644 recipes-core/kernelci-customizations/files/ethernet
 create mode 100644 recipes-core/kernelci-customizations/files/postinst
 create mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb
 create mode 100755 scripts/deploy-kernelci.py

-- 
2.33.1


