Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B736C433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 12:54:46 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web08.11216.1642683283748772980
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:54:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=vxv6/7Bv;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.46,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pj1-f46.google.com with SMTP id
 d12-20020a17090a628c00b001b4f47e2f51so6845800pjj.3
        for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiRrFejfQhUfZXfaSlcMh2PUwXV7IM/lKkLo98GtvCA=;
        b=vxv6/7BvjEaf0SnkvW10zO8GmyRVukuBFDoBJ2iMTmXw/Fb1u+VagbcRf6sgfSnK0w
         rgnasQqXs964sdB1f482lYDZVwqcmI4SUJ0lgQWAW3Bqi+e3A793RtHnf8xRgTcStB08
         z69BfX6KwwbOADD5mp7z7JiP5/gU6hhPvQ+fcpUnItUxYiJoQEGO5zfFYErYrx1gncJK
         Db+dPvVQ4RcnNH+jETV6uBbcoXj25t+ryrWU0mNCOM4VTgAIA3DOH+0zsmg6bGU7ilAw
         TgLgosuT8H38dvAJpWQ6mEZtTCFPDdI9CymMQ6kQx482EMXyuZoTi0P8/m0BGQG46jgA
         F0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiRrFejfQhUfZXfaSlcMh2PUwXV7IM/lKkLo98GtvCA=;
        b=69bbBLGrAyZsFHTuqbQjoN5OwTPvbZ4oliQY/tOk3/T5on/xGOwuxiHsgTP0zH4pSP
         sHEo+Fv9Rtq9wltMb+IWnJ4Hmoyni9EX3fyaIWtUv+ih3itl99b1cRDcFOXZhDmrss2z
         blOXMWEiGWaaQxHjrhbBfoBCbgW0vCvUSSU9Xbj1M96MlsQOxGWncl5err34d76BrSRv
         ivk7S0ZbSI5eaMOwDwvv4+mzMHMXrbvG7psmOtjh+7i10zWQVQL3+nF8tky+spK9gVdn
         FNyTvfHe6OokroPjSWhhdhHzZ5ZArh0lH/ls+ApTiruBArWsduzFL5vdjVWQFrOp5xyo
         /yiA==
X-Gm-Message-State: AOAM533jxlMtrtlkFI/SaLVCaEtJjOoVfdoFlSxPl7CUfgOKYNEKP17I
	hl/YHyvfnaoTzHYRQXMdDY1P89C6GPII
X-Google-Smtp-Source: 
 ABdhPJybiyITM7eLBoaDUrGeq4Pwnw84zjMGjDuBLrIsldmC/PgxIhAt9s/Hrea43N6+J1TWPTOQcg==
X-Received: by 2002:a17:90a:6282:: with SMTP id
 d2mr10700055pjj.74.1642683283120;
        Thu, 20 Jan 2022 04:54:43 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 n11sm9975634pjf.29.2022.01.20.04.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:54:42 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v2 0/4] Add cip-core-image-kernelci building
 and uploading system
Date: Thu, 20 Jan 2022 21:54:14 +0900
Message-Id: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 12:54:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7472

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

v2:
* drop trailing semicolon from gitlab-ci.yml


Alice Ferrazzi (4):
  Add cip-core-image-kernelci
  Add dmesg filter needed for lava test result
  Add script deploy-kernelci.py for upload the cip-core-image-kernelci
  enable cip-core-image-kernelci

 .gitlab-ci.yml                                | 38 +++++++++++++
 kas/opt/kernelci.yml                          | 16 ++++++
 .../images/cip-core-image-kernelci.bb         | 16 ++++++
 .../files/99-silent-printk.conf               |  1 +
 .../kernelci-customizations/files/dmesg.sh    | 23 ++++++++
 .../kernelci-customizations/files/ethernet    | 23 ++++++++
 .../kernelci-customizations/files/postinst    | 34 ++++++++++++
 .../kernelci-customizations.bb                | 35 ++++++++++++
 scripts/deploy-kernelci.py                    | 55 +++++++++++++++++++
 9 files changed, 241 insertions(+)
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


