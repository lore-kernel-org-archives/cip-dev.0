Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7DACCA47B
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 05:20:05 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.81084.1656998398462825551
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 22:19:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=sqW0TujA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id a15so4349603pjs.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4bJnm9At8dkqxGF4+g695IJpaFz6EcTdcdpRI64YMlQ=;
        b=sqW0TujAQ3A/RAN2zmOMXZ8guwopPSpADuSLv4YulH1YBn3xfbs4az5yIJfjIuEfnc
         Uq7+3bKYB/bnTJEMwqc4neDVXFOGhEUv7rT2PQAesrqWfjOnedRBbbbGZrj2A1XEHy5s
         xySqr73YOq/ai1n0lskjBq5Xh6IRjiYzvbXVHObiqLHT9zAlXjND+cr/oDrjE5shBh2N
         lyCcPlokoL40xhktVqp+PdHOmytyJ90X9O+JsExPfhiMEUR7HRXjerGcsETerIhcMEuo
         u9c5fN/mShD3qM8aDvo1wh11FFEM+6xPkB3wSL+PYhC15C7u8KoAcFChJ8t7/pFTwEvn
         DYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4bJnm9At8dkqxGF4+g695IJpaFz6EcTdcdpRI64YMlQ=;
        b=25srR3EeMBjpCy+tt7kUvX8OP50KvVY/ww3BRJTHba9VDY6M2ZZadIauVHH0BWfgQt
         EdrwmBJ2Tqp044XmNkbUDCIqvzVCzsjmolhWT0OSVc9cw13VGdMiBDZmot4V3dbO7aYV
         YUEGoTeb2J6jg6mFG1UbNeypoyJsweRKLqxuhbS8S5WF2VFhD7fZuwU+vRfrnkeEktn7
         EKGIm78sa2i+fffPq9de4bjb/lzuGxNxvySdXPDtRKqcpDc+rGEIxWavP7RlqrxBa4Je
         Gszlgw+nC69DXcbRkliiPRtYjop00DAdeVtA71MM4+Ne4OhyDNWZVLoJQA0zJAZNFq3V
         15YQ==
X-Gm-Message-State: AJIora/4ZktNTsie2WQnmY9x08jehicoBDT+qwzyNSUG1zkVXJtB6UgC
	AE2j5bneZRKf7/BlX6poorZEm1cZAIIDTYyj
X-Google-Smtp-Source: 
 AGRyM1tXlH1lyHbMbo43VsSmuPq4TkHa79SC1oArLGNGMKh5J48TcXrEtQatxRg+5gNeFb4zy3ozsA==
X-Received: by 2002:a17:90a:eb09:b0:1ef:7df7:cdf7 with SMTP id
 j9-20020a17090aeb0900b001ef7df7cdf7mr16081750pjz.185.1656998397893;
        Mon, 04 Jul 2022 22:19:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b0016a6cd546d6sm22207520ple.251.2022.07.04.22.19.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 22:19:57 -0700 (PDT)
Message-ID: <62c3c9fd.1c69fb81.38d8e.f5c4@mx.google.com>
Date: Mon, 04 Jul 2022 22:19:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76-54-gb41c396e258f
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 11 runs,
 2 regressions (v4.19.249-cip76-54-gb41c396e258f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 05:20:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8677

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 11 runs, 2 regressions (v4.=
19.249-cip76-54-gb41c396e258f)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.249-cip76-54-gb41c396e258f/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.249-cip76-54-gb41c396e258f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b41c396e258f2fee2f17d7d65e4e03a629ba380b =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3b53e1469cab263a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c3b53e1469cab263a39bce
        failing since 28 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3bb7cf5294c9690a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c3bb7cf5294c9690a39bce
        failing since 28 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

