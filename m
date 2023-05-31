Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B505BC77B7C
	for <webhook@archiver.kernel.org>; Wed, 31 May 2023 09:55:12 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web10.10303.1685526911148237320
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 May 2023 02:55:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=GzNImoF5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.178, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-39a55e5cfc0so218440b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 May 2023 02:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685526910; x=1688118910;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HVuuDtvC/kFLAQjV6Mbt1kqZOnXtvRn42rNT4ULJDn8=;
        b=GzNImoF5u8i/Aks3JuFFH5rLsdapphrxbNQo5qKZ2Rabe2BHiK4fjBVbvh03yfcw10
         Nayi4cIi15ScZlZ15kfp3S8RWK/N71DOTrhzZD9vW0qxIzAvq1/SmhUgy36RToxlmo4c
         e0gt5uYyj2iOvKyWgeyBqYb6b1r+Gfu225g8i6/v2kvkP3f1UN+M/qAJ/OjuXu5NNQsU
         0Z4TV9lWlebQC+FYYOpzf1VHNIWL4k2NnZWp0Z78Q1WFzeA3RmckuQi6dPIwScE5JyJU
         PEoL68maylTNxpMiMtgdkla/+MJyzEgJcuy/+aCLvvmSWrowncTWEUMsIU5NMiL4Y70X
         tjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526910; x=1688118910;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVuuDtvC/kFLAQjV6Mbt1kqZOnXtvRn42rNT4ULJDn8=;
        b=clMKCIfb4b2vS2ZsAnpi6h62OnAvulopbznvPqu976Pt8Jc+6P1hC0Rr2svm6whyiC
         DXTzdO8lHOllM602NVrXHkP7Z2SAPn6wsOeqVwe1gTbrblwl7dHoj9TcoZUd9/ykUJfz
         qSlHGNWeY5u0eXo3u0I4c3y0eA0Oo/j24U0Kl/HQnQEzaielSuM+scKSeq4nr/hkEdE/
         mnofbJFLI6aiKSxSlhOA1WD4i+Pl6Er+QVkm4FATSTsDO9HepN1uBT4gfmCwlAC/bwLP
         eJT570WnQGUa8zxr4efbNSkxB2mWpt2ZuffwH2lBSkZfQhXFkUiDIxvTvHXyoFUhJupH
         KICQ==
X-Gm-Message-State: AC+VfDxuNRa6KTnw49fgp3onJamFmINy/7U60b4xMkzJLpbrLRNoQw7U
	CD2G2Bfi/7SBuAuZGuThj09BUTTsPiw9vxJCI7HuOA==
X-Google-Smtp-Source: ACHHUZ7uISVjEFiF3l2h5iIYHu3kGzWLQZz1aKAaUGGvW+0IeJZ0HHWeiKDH/GdTwIirCxhRkFSz9g==
X-Received: by 2002:a05:6808:220c:b0:398:7e72:330f with SMTP id bd12-20020a056808220c00b003987e72330fmr4392266oib.23.1685526909913;
        Wed, 31 May 2023 02:55:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001ac55a5e5eesm929616plf.121.2023.05.31.02.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:55:09 -0700 (PDT)
Message-ID: <6477197d.170a0220.b7c86.167c@mx.google.com>
Date: Wed, 31 May 2023 02:55:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1307-g20af3740f4fc
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 27 runs,
 4 regressions (v4.4-st20-1307-g20af3740f4fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 May 2023 09:55:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11710

cip/linux-4.4.y-st-rc baseline-nfs: 27 runs, 4 regressions (v4.4-st20-1307-=
g20af3740f4fc)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | multi_v7_def=
config           | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1307-g20af3740f4fc/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1307-g20af3740f4fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      20af3740f4fcb1ef7c5d829654de94824a2d493f =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6477103ce7fea745bf2e8687

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6477103ce7fea745b=
f2e8688
        failing since 34 days (last pass: v4.4-st20-1097-g52d843097a439, fi=
rst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/647710e5f8423b83562e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647710e5f8423b835=
62e85f0
        failing since 27 days (last pass: v4.4-st20-1186-g2516b357b2e3a, fi=
rst fail: v4.4-st20-1186-gb629b961cbe6) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647713dd9406c6a4e52e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647713dd9406c6a4e=
52e85ea
        new failure (last pass: v4.4-st20-1186-gb629b961cbe6) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6477138f4b5c3c5adc2e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6477138f4b5c3c5ad=
c2e85f2
        failing since 141 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

