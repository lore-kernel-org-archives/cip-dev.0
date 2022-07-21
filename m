Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C5C433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:24:14 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web09.4700.1658399053951541491
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:24:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=mLjH3Wfc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id 70so1368874pfx.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FyTUvR+NnlFuqv67z2J63h+pUEk2MSOXOboZZUiMCKA=;
        b=mLjH3Wfc8SsDTmS1xm0YgYFWKPpFtgDTEO6gwdPBp6f6eUrdcsJR+w+oyHbS84HgGM
         nLaEjbtIBjvedP2waqrihha7vDcIelNdpTtaHHjQrmUsjU7iIZFEInB2kF9gjIFEqApR
         oxLwGyOHhvQUuAUKazamAr60o/RjbtbEkK2s5DYMxrbUm3Y0gkpFyn75a7R+octGzBP4
         IovciWFdxnmQUtR8yo4baFGDiLcVE11thfV4OoTl08dVp9zTsmVB9K60hF+R8m2QXWcf
         iVutP1hMR0xB/OoFhJjC+VFT2t6cDWSIM+bmVrWe5luPnRdJbG6q+K5T5d/os8xA9uV/
         RFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FyTUvR+NnlFuqv67z2J63h+pUEk2MSOXOboZZUiMCKA=;
        b=kX6iMY+ljeViPtr4pCj+LvCTf9q7mYydOGIj59WelfI6SrqHIL33prm9s++qbo7lmp
         s/tFUDLK7IAEueTBwrzSVXdamwMn//QgOXYtma/k5jNTKuFIQnZqqLyzexd0uE2zpwcH
         PyZFJQsoxmjj66ziFU7jrMFftZmVRtUD0PV+TUkQMAVVmHALihELEJMTgS/ImL3PKmVs
         8h/3wqx4Ba3Gd2qhbLK0GMUq3pI6AGt7NArx9vVuLNTd3iPWZEo6rj4XMiVss2D+l1g3
         kysJ4Asez6KabVp1n8wdtJ7AiZTyZ9OW4UfK2Gy7RCOrWIuutbopb6OgEcYo8hoaBoq4
         bB7Q==
X-Gm-Message-State: AJIora/NO2gYUF7F+3+t2W5XLxDwzGx1oAW3a4cSnmKs+edjBKjVDEQ7
	+eqlFNH0af8FUxNm+hALvrzZ1zW2SVkWG+/JC7A=
X-Google-Smtp-Source: 
 AGRyM1up9PY9bVygLPRPqYPVioGZS+HEo93uCFHMrXD1qAd9l2j4xvFMZrhR9jAbYFp1JyaCBRQCBg==
X-Received: by 2002:a63:8841:0:b0:412:b40b:cfb5 with SMTP id
 l62-20020a638841000000b00412b40bcfb5mr38854261pgd.197.1658399053008;
        Thu, 21 Jul 2022 03:24:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q2-20020a170902a3c200b0016bdcb8fbcdsm1280466plb.47.2022.07.21.03.24.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:24:12 -0700 (PDT)
Message-ID: <62d9294c.1c69fb81.f13c0.207e@mx.google.com>
Date: Thu, 21 Jul 2022 03:24:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 8 runs,
 2 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:24:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8868

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 8 runs, 2 regr=
essions (v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62d91ccf14844b662cdaf08a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62d91ccf14844=
b662cdaf08b
        failing since 14 days (last pass: v5.10.126-cip11-1-gc5218dc69ff1, =
first fail: v5.10.126-cip11-116-gef362fbbff528) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d91c43e8e5ed5250daf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62d91c43e8e5e=
d5250daf065
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

