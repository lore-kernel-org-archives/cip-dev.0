X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web09.6001.1653670297839633560
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 27 May 2022 09:51:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mANjaAvp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so7598631pju.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 27 May 2022 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Cyr2zQNAv0CwZ8lwkR8QVLuKF8v3LAMmx3aNlL95d1w=;
        b=mANjaAvp+/R7lEYM7dObEzy3o4jaKCz0CVdN3JrLLkx6JVNnGDb9nU1NZCF2YWiKkf
         LUdp5fypzxT9mnXqgWiEECL51YDyaTSMvvzIXF9DEvvaBAo23FJTM7yhsIiyw6fPj3/3
         5zi2K42Yx5ExHVqA2fuQ1Z1Z//k8r511pDiZsU4f8nDWLCvi47SFVyE2hMl2k5hwzPGb
         eJBDsQxUFD4lsJFDBN/+7ti57uiFCdhkK7XoPxM9qb7+KD5XM/tR2vDhkCrh5PU/YWvF
         +DNR/15esOtE6gdbI+qshd5AEZqMOaBB0srY1lUJxYQhf05h+6f8vGdU1IamsdUiG5kX
         gnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Cyr2zQNAv0CwZ8lwkR8QVLuKF8v3LAMmx3aNlL95d1w=;
        b=KV++CwNcahzFXtIYrER0K8M23S9JGYuOiXXBd4mZAZr6MH6riroK78d3sluA4voGDH
         O/1erWUZ5VXqIXETH2IDGd6VnZwwT2OiwYETI5S8elbvF2nhIpF0bDWof41timuRL72o
         OnwTx+SROEetcdCx1hRpjosYBHz3Uf8WM4qTNvs14a+xfqbB84Q+WU/JJesioZbK/aNN
         45kICOjy6Sk8BeQODbHiM7BdJ2XcB2M9VeSUydqRzs1f/D8kQ03nOuCS8CupI/1RlUD/
         stBQcuBYY0HSjqdrq25xfN69YfH6Mu9/xWCgmt+4RkNaiQvZH6RRUcMkaSYp2WKn2oii
         vdvQ==
X-Gm-Message-State: AOAM533MIP6tT/3CMUSCBBKgJvWkjVwQDufCQgEkwVi2I2K0RdFQk4rD
	vQb3o1/YrF3w5r6Jtq3gi/QsJ6tvLNK6GbHWQrw=
X-Google-Smtp-Source: ABdhPJwPdbhBpO4EySiGpNAbYNng6+2EBGYWeJZ8ueS5D33VXmktDWONP8dtam0HPCqFHq159R4HGA==
X-Received: by 2002:a17:90b:1bc7:b0:1dc:9781:85be with SMTP id oa7-20020a17090b1bc700b001dc978185bemr9390492pjb.1.1653670296955;
        Fri, 27 May 2022 09:51:36 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a670100b001dc1950ead5sm1777051pjj.38.2022.05.27.09.51.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 09:51:35 -0700 (PDT)
Message-ID: <62910197.1c69fb81.3ddce.4521@mx.google.com>
Date: Fri, 27 May 2022 09:51:35 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs, 1 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs, 1 regressions (v5.=
10.112-cip6)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.112-cip6/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.112-cip6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6290f8d144e5ef16e0a39bd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.112-cip6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.112-cip6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs=
-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6290f8d144e5e=
f16e0a39bd8
        new failure (last pass: v4.4-st5-1797-gb2b8419761095) =

 =20

