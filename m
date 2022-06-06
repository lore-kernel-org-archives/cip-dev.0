Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C47ACCA473
	for <webhook@archiver.kernel.org>; Mon,  6 Jun 2022 08:52:23 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web08.29764.1654505535511030661
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Jun 2022 01:52:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=EEjAN0On;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id e11so12192329pfj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Jun 2022 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eKErbH04c2X8sfuITcGa16k5CJUjHdm/2KD4asmo24o=;
        b=EEjAN0OnfmzcGc4IDRo4VE9gxrLiJ7Mn7hNzyypsYJCu+QuQcPFwFAOpUcouhjpeh7
         GYR3Q80MK5aeV0Fkz8fi0RWteV31mm644BYIaRaW4NnaDE1eTCr7uIQOfAFrpoHDgOym
         7Yy5xYJfL9togI2FfyFFkjA0f2cLe3r6+jckeaJ9SI4eBs5l9Gl3vv4hnIgQ4jVILK+3
         4Zjyy6J2p89d1yw+jOWJD1pdCgHC1Z4pN7rlv0ISRhjcSXKVA+POPBRI56rGnwFiwe1N
         VSqvUhUu5xCCyf83Wfii7R3B7tOLzl5QvHYEtMpjPmqFRCqNw8k6Jvf/lUaCg7u7TykO
         RLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eKErbH04c2X8sfuITcGa16k5CJUjHdm/2KD4asmo24o=;
        b=6b+Ckn4S0GXDnB2Oe4zxNjbfL5cIXWeog9oKXrcy9bvIpD+i2liJzRLcfv6a6KSCw+
         m1H/V114rAeERW2rYSNCeHeXyQXsNs7JYpH/PecMjy3sBYlHaL2Sm41gALTHa07lRccA
         tqN3dvQbaWsQUuziEOZahbR67as/5MHKHs+puvDvqBNMwqP5L5gi/c3c0bHh1K2r14Al
         qjfhUx66ip5ael2IUd5ijLeiVVK4YyySQ4ismoZdJZoQn7ek6JLtNcWHQ00NDRTB2n55
         bhlotg1VVL7dr5UGzymDyt9fBJp/pN0VNkAKtYXD3p2LNTo6ZN1QKnHSQ1WEoi9pxG2O
         mnOA==
X-Gm-Message-State: AOAM531tf8qmEnP+o/YbL3JFHFtWLK/M79jg4zo/3cCDr9vyu2R7MogO
	H2tvX1j7f5V2AyJBnCCARdhwF9xYMDjdLWlL
X-Google-Smtp-Source: 
 ABdhPJzR5lqkRf7OCRKtR7XHNXsdLLBSzCtcsOypIpaARPVSGN31ZAJ9Ife0mjKupy4OWS4lSiwmOg==
X-Received: by 2002:a63:5924:0:b0:3fb:a75e:9e8a with SMTP id
 n36-20020a635924000000b003fba75e9e8amr20223833pgb.394.1654505534600;
        Mon, 06 Jun 2022 01:52:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p2-20020a170902c70200b001617541c94fsm9986123plp.60.2022.06.06.01.52.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 01:52:13 -0700 (PDT)
Message-ID: <629dc03d.1c69fb81.83442.6dbb@mx.google.com>
Date: Mon, 06 Jun 2022 01:52:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.245-cip74-32-g2d021d7a9e637
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 10 runs,
 2 regressions (v4.19.245-cip74-32-g2d021d7a9e637)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jun 2022 08:52:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8493

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 10 runs, 2 reg=
ressions (v4.19.245-cip74-32-g2d021d7a9e637)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.245-cip74-32-g2d021d7a9e637/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.245-cip74-32-g2d021d7a9e637
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d021d7a9e637c95607b890c32ce5cbf91baec0d =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/629dba572d68dcc107a39bfe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/629dba572d68d=
cc107a39bff
        new failure (last pass: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/629db8b2c9f0aab0ada39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/629db8b2c9f0a=
ab0ada39bd6
        new failure (last pass: v4.19.242-cip73-50-gd57bc44cb340) =

 =20

