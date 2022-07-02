Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E97BC433EF
	for <webhook@archiver.kernel.org>; Sat,  2 Jul 2022 20:42:49 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web08.54083.1656794567082270460
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 13:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=m47Ih3qJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 j1-20020a17090aeb0100b001ef777a7befso862231pjz.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dx/T0g5aDw62uOe9kiPwRdM/e9R4gvCUymX39vz2d80=;
        b=m47Ih3qJHM96wtOpFC450J56vkgS/8KqahMzBrtmj2pADtC8fBVV0fTA3q8N0eaZH8
         a0Qs+kGO9bDY4A/GCKpK1lpt4cQqiBS4owYr+Y5QinEh+b6hktQlba5dKKZQo7w4WXlK
         rRNP+9HH6hn18uqOjWmAFjJc3puJmxt50eVp0ryi5OlDP0qXgMlBodGNXNh4+WWgJoZz
         bXS062VwIbNT+NiPACg/CjIVgSN6sPLjbkyZAYOzb7gjqOr5SS9LaaoKdymv5lwK0WMw
         NVRFlZcRnXYuqAllEhy4EuOWEieZAhR3vg6pGfRvnjCSz5JM/csiDhdpKo3e58NsmqEj
         wVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dx/T0g5aDw62uOe9kiPwRdM/e9R4gvCUymX39vz2d80=;
        b=hoXRqkSMQxwMChwEihI/pr1t/+FntCkeQg/KHWoaFScMcc7AlHSsUTnC4MV7bKVuqI
         7DVHrmzie3QnEYQmaTLZdobZnfIhsqH10G6a93ayLkobpGGmm/B6nCn8cxFHcb0SMUbJ
         ivQvMxP853JODEfB5GN0nUQQd5Qx4GYu/jRBI6z61oLiv7s2V9IbjVSIKCo+w1PoIwcF
         SiYpXwwC0QaBLYisBXtEn8eG3gPr7/8G8ruQNyhVNnl/eSGdel5Zv3rsKzQbIPhlX1iE
         E/pPrLn8cxP7dc+pIBMyaTNfb9RvXQ6PO1mhWJ/yY+7QCS8iXLPVn+uJ4j/cKSuQ67MA
         ROlw==
X-Gm-Message-State: AJIora84jpJHQMPMCotFgNf49k2l85Aa0OLKNPfYK2o1Z6qB5Ixbdy5E
	qGPi+icli1W+FxWGoQlg943dhQuoO9VaXIk1
X-Google-Smtp-Source: 
 AGRyM1v2okHrNnz8p7P3CP2zAsrNntib+zEIu9JMru7dw17TS3oj0WJ2n++SJE33fMJZDA+ptsuE2A==
X-Received: by 2002:a17:90b:1e0e:b0:1ec:ac5b:ddca with SMTP id
 pg14-20020a17090b1e0e00b001ecac5bddcamr23650110pjb.97.1656794566212;
        Sat, 02 Jul 2022 13:42:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y11-20020a63de4b000000b0040c644e82efsm17508336pgi.43.2022.07.02.13.42.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 13:42:45 -0700 (PDT)
Message-ID: <62c0adc5.1c69fb81.7b950.91f3@mx.google.com>
Date: Sat, 02 Jul 2022 13:42:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-118-gb03e159be974
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 10 runs,
 2 regressions (v5.10.125-cip10-118-gb03e159be974)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Jul 2022 20:42:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8634

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 10 runs, 2 reg=
ressions (v5.10.125-cip10-118-gb03e159be974)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-118-gb03e159be974/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-118-gb03e159be974
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b03e159be9746a2cba92777632dfc469e7cdecf3 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62c0a2ae13ad59eda8a39bde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c0a2ae13ad5=
9eda8a39bdf
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62c0a16eebdcbb1c6ba39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c0a16eebdcb=
b1c6ba39bce
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc) =

 =20

