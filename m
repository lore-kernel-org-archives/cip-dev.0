Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF7C433EF
	for <webhook@archiver.kernel.org>; Fri, 24 Dec 2021 07:33:12 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.43445.1640331189942424916
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=vtGLFVZB;
 spf=pass (domain: miraclelinux.com, ip: 209.85.214.174,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pl1-f174.google.com with SMTP id z3so6119909plg.8
        for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bu8exFLyAobVaf1aHCVHEOjcG30qy0vWxQtTCIN0s5Y=;
        b=vtGLFVZBYx4X7MrNTN8WPfsvuYhd4W2mxT5zqvXFJEYk9hfs8GJIbDlKxjl1jxdIFD
         fqUN/4zRprznegN79bZY4DKRM4Nde1t293OpegCGw2Remaj3JvF3m7T8sx1AaW6zBlCs
         Y4t4n462UdB24O3vvdGn66kX2UDPHmAdj3QEya5fN+quTeeP/jTSxZGn21QsRTNJzlhg
         fsKDjlYGCSP+Eawz7nl47v5kyfB6DbXF6qNUC9Q4SbYnfRXh08wG5FNMfgKUYXUlQv3e
         ElwTYQwPgs+tpFwKpwpmBb8AmnENjI3GZaG13doHWT1IdWKQp5PTXJK5XMBrMpyhJJzv
         zfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bu8exFLyAobVaf1aHCVHEOjcG30qy0vWxQtTCIN0s5Y=;
        b=RRrdzwsuR3LfHkvN47m4CTj6CdzSyAvMZUuqfcQw9lr2d4iTvRXKlxq08+lgtJawHp
         SE0yqC7xaWvzqSJr8Z0XO97XY3b89Y4vkRiZB5sBmd5GLT8S0nDcTQGX5bC1NMFNZzrB
         QhTvTRsGpkpbKVa31V6w8UvZkOXQ83Tp+R0x5dfcstgK343gtqWOmBaAaxxQaBx8oavM
         cmrzQ7hTc3MSmOAqcw+ZPV8uK64RY7+MCPvjZmyEG93i7d/btzWNt7G0in9nDB7iFsXS
         QOzXi5ujU8cE/80kPp0eBG9C6CIxM4Ww9V8O8WssR0lB2xkl9yt8R5bBIYo/enopQqXy
         PZAg==
X-Gm-Message-State: AOAM531VAZ8GBshrZnQmiVIAJQj0c6ad4hwQZNI+0CCGSXFHilMkmRFZ
	Sbtd7cTBg3SxCUDYb9c+Fb5Ujcaas2fy
X-Google-Smtp-Source: 
 ABdhPJz0Zyrmx4e8+M8mMZfEO1LsB11BArw5AA3U+BE8tSLhQnS0vWa4ncgCTQkkSUE7qhrxx3AMrA==
X-Received: by 2002:a17:902:7b8d:b0:143:95e3:7dc0 with SMTP id
 w13-20020a1709027b8d00b0014395e37dc0mr5670165pll.21.1640331189304;
        Thu, 23 Dec 2021 23:33:09 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 u18sm8763175pfi.158.2021.12.23.23.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 23:33:08 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [PATCH 0/4] Add cip-core-image-kernelci
Date: Fri, 24 Dec 2021 16:32:38 +0900
Message-Id: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Dec 2021 07:33:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7264

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


