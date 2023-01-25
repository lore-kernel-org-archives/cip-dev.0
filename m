Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B29C27C76
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 03:37:03 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.37303.1674617813605426689
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 19:36:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=IJq7Zseo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so2764765pjq.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 19:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9j+z0f+QZVG4bY0xfIlmUWRs6CqXkWrZ/CPt1ZiC1xM=;
        b=IJq7ZseoWBsMC9+Pc1Cx4Z48JuJlNGsZZXEo7qjRl5L1UqAyMLlV+5sW9PfWTBtfZG
         fCeIcvKFoQbhrho7OrG15Jcl3e9iUDmu+kyGCrVue1bzhYvlZC54Ex347t+AV5OA/WMD
         mBmx8BcUEeInDScaIEAcjykD2VrmXTSSVlt2vrKUjDXz92BEjY7udIXGXY6fa374L883
         mekJR9gNHv31jCiDjC/utvGmKmbo+Trrcx8rLbxny4hczVZoncqDRsM3AIn0+i9oAi7y
         +JHubxpfgxXD1LYu5zMhyYj5qfJgCvtGi3+Gp1faalPcJtKf0H6XohgOGZFBJjPlX2P4
         vhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9j+z0f+QZVG4bY0xfIlmUWRs6CqXkWrZ/CPt1ZiC1xM=;
        b=ltsurcJmRGJvEsk8rky6SJMIV8LtZCgZ2pKxK8iAt+NX/ZYNN3YwWz+f2U80k3xrz7
         YUkgWuqSTAbEC/+FQLitMpSFSLWGSUvA6uKpoJ0OCObHmanBxEc8VTD/z1KsuMfDVWMc
         jDezpZT+k80B1rPrQSG7GbXAVUDPLYdbqg0lhWsl9KMC2nDQdH6OyjYuqg93UPT6dEg7
         lP1c5WVurhGU7SiYUyiSyak8j8gK2nR04vit4wdh+XfN/o5vcAt/ACTBPUxMqoFnznbW
         ePMCLq/4q8tjieTHchgtUHzPdyLY4cPSQtLDZftXDy63uLy2Av98n+Bz8o0JPGhvGew7
         86Sg==
X-Gm-Message-State: AFqh2kq/42Yl5TX+hf9ASPmJ+Me56sQCmDz0GxRvXtMPDlz1Ze8yyeNN
	j3sHoSMeSsidBJjirnE3rF8PM2QWSGWjiwVt
X-Google-Smtp-Source: AMrXdXskZl6hofaQS5BiDyDw/zhhrDzDN/8ywX9PRjSILyqco4cqkHb8P71dIhca99pTUH2+qMwcew==
X-Received: by 2002:a17:90a:f606:b0:228:f6cc:dc4f with SMTP id bw6-20020a17090af60600b00228f6ccdc4fmr32494619pjb.10.1674617812786;
        Tue, 24 Jan 2023 19:36:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mm3-20020a17090b358300b0022be5d70acdsm341391pjb.20.2023.01.24.19.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:36:52 -0800 (PST)
Message-ID: <63d0a3d4.170a0220.72760.0a5a@mx.google.com>
Date: Tue, 24 Jan 2023 19:36:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Kernel: v4.4-st20-821-g39bdf0444b23
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st baseline-nfs: 23 runs,
 1 regressions (v4.4-st20-821-g39bdf0444b23)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jan 2023 03:37:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10474

cip/linux-4.4.y-st baseline-nfs: 23 runs, 1 regressions (v4.4-st20-821-g39b=
df0444b23)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-821-g39bdf0444b23/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-821-g39bdf0444b23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      39bdf0444b238ce8b92fda121bd1462a27f07a66 =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d0a226aa690aef7f915eec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-8=
21-g39bdf0444b23/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetso=
n-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-8=
21-g39bdf0444b23/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetso=
n-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d0a226aa690aef7=
f915eed
        new failure (last pass: v4.4-st20-234-g4e6ec7162c8e) =

 =20

