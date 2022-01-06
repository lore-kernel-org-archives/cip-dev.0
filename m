Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35878C433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 11:16:55 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web12.7210.1641467813304759806
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:16:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=5630z86Y;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.44,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pj1-f44.google.com with SMTP id oa15so1348617pjb.4
        for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bu8exFLyAobVaf1aHCVHEOjcG30qy0vWxQtTCIN0s5Y=;
        b=5630z86Ye0c4xX0jEoogwLQjYLdkntWA4rIAIwSn0etzHogeu0igsP6TmHA2zrBI7/
         DlT7qr8+sHBchbGkc23LdYA5/xowTKWjOkh+7m5Dc117AWdnQ4ugHiVKEUOMD5MRM/2D
         sr0nTz+vhWhAhTiEb727AKQLyeYjguvL3MkyF98VPVzEUWOpzHFMil2JBvrJRJHGCYAL
         B5kJutxNyXojSG82dVgYe1y+v8FFJQgiHgnVlFzATNqU7Lm0Axtth80NRK2VjgAzpBoS
         5ofKjo6iaTaHLsVk9vv+LbJz6JJLSpApRMzcvqxHWfRtMiFzidbum/jYIIXA/BVmu7lD
         jzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bu8exFLyAobVaf1aHCVHEOjcG30qy0vWxQtTCIN0s5Y=;
        b=L0KHVpAYN60DqepZcUA3vI4aMsYaBoEupBYJFCESrkfhT0YpLp6/GmuGJf8JxccFFL
         lFsAxxgCsyJd8QcMtXswv1Rd7TcvyxOhPHgGBFjhBX4lc/RiYvb3MGjL8Ymzlw73R3r9
         mqX5GBAwSSsirEI0aTkHXGX++QXyXk0YuFl3hdy9kphhxdUSbtVukfNmFKSaViosxXQG
         3Jvti3NmOVZnOkC+9ESbeMHbufkluU1bEAgeQtqdTLCjYVfKxIoiqScmIBf7G5k1g4oT
         M1VracYhhV6lD2wvqXg4/0nVL09C0WGvNLKKDjHmSjl8r/a/mbnAkfk/PZfm9gdGxbJ1
         mOKw==
X-Gm-Message-State: AOAM532HloeBhb85+XFJUbTXzmrNcBLWV/+j4tSKV5+2V1Rbv/Gd8hee
	VzuWFXY2xhxZDE8SsmFyPqB9XG01dFkC
X-Google-Smtp-Source: 
 ABdhPJwcZp8uEDTPOPPOzESXtchsryS03t1jWz7FIalpQ9t67BmKcq6UGQQvBkvqy3qJGBxN5n22iA==
X-Received: by 2002:a17:90b:3809:: with SMTP id
 mq9mr9449121pjb.245.1641467812769;
        Thu, 06 Jan 2022 03:16:52 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 x6sm1766325pge.50.2022.01.06.03.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 03:16:52 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 0/4] Add cip-core-image-kernelci building and
 uploading system
Date: Thu,  6 Jan 2022 20:16:10 +0900
Message-Id: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 11:16:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7326

This patch series add a new image with settings for 
KernelCI.

This new image is called cip-core-image-kernelci and is 
based on isar-cip-core general image with some changes 
needed for make it work with KernelCI and taken from
KernelCI image base settings.
The cip-core-image-kernelci images are built by GitlabCI
and uploaded to KernelCI production fileserver.
https://storage.kernelci.org/images/rootfs/cip/

These patches are already integrated in the
isar-cip-core:alicef/kernelci_master_refactor repository branch 
and are generating the images that are currently 
used by KernelCI.

cip-core-image-kernelci as been tested and are
already used in KernelCI production with good results.
https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/

Alice Ferrazzi (4):
  Add cip-core-image-kernelci
  Add dmesg filter needed for lava test result
  Add script deploy-kernelci.py for upload the cip-core-image-kernelci
  enable cip-core-image-kernelci

 .gitlab-ci.yml                                | 40 +++++++++++++-
 kas/opt/kernelci.yml                          | 16 ++++++
 .../images/cip-core-image-kernelci.bb         | 16 ++++++
 .../files/99-silent-printk.conf               |  1 +
 .../kernelci-customizations/files/dmesg.sh    | 23 ++++++++
 .../kernelci-customizations/files/ethernet    | 23 ++++++++
 .../kernelci-customizations/files/postinst    | 34 ++++++++++++
 .../kernelci-customizations.bb                | 35 ++++++++++++
 scripts/deploy-kernelci.py                    | 55 +++++++++++++++++++
 9 files changed, 242 insertions(+), 1 deletion(-)
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


