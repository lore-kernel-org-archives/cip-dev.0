Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A623C77B75
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 14:31:20 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.21102.1683124273809832942
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 07:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=L3JRZeoy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ab0c697c84so16971775ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683124273; x=1685716273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SM6ZPM9K2Kdl/iYYPjuM6sjnI+06w30/LecOFcgHdFI=;
        b=L3JRZeoyBdFHF75F/drGdP4WtabK7t8mhXdjLhpVp3JqsOSWy8hx57mqELFxtzuO4j
         Hwhuv0/LLgy8V/pQO/SwkbZk974KPr3Sd/S7PCxn0jnT3St8HFBtPb53tAwDvGptfuUm
         pMcOQDbSpgrWjUo+rxuwV49DDX29FAdiM3lTgVOsVtth10E5YxuNvxpuF2Df0CgxekLu
         SCQFShpDEkC2bqlSJF74t4Zv1oCeI0IuPEDX9GNXPlp1RzSRboddVgJmhSjULjCL9SAH
         dgz478r+cOJEeBhSeaRNfbA+h7uiNeDwZXNRAf85VUuqAH4eEhTLyCOwKMXgxZ6kdUpm
         hCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124273; x=1685716273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SM6ZPM9K2Kdl/iYYPjuM6sjnI+06w30/LecOFcgHdFI=;
        b=keO/krF3UGGwwei/zXetvdhbJJmdSN0UcOD74VU22jaQrFH+Uw9z0x+SSmOsf4VER/
         C10VLkx4kb36gJTHyT25RBiaGRUOcJJ/WqGmVKEuBuQMjvML3+Wku60nhya5iPyKDVa4
         VhPqBHZneldSBw4kw8XqrFZhrcMHpd3h3Hp9LVDJ5SL2frUZeN6uoGtPEkOkn/eg9jHh
         uqIYUEKqPwAmrFZlaXimocVXzqvAXlLmaWc2i7ocVwe1adztexCCVfeNl4S7QhEIthf7
         JfG2L/OPXBZ+TAAvHg/V/iYq3qL1DiZNMT5o5y/ppGCsQOEAJL2cnyxejgW3eHGkmJhx
         BHLQ==
X-Gm-Message-State: AC+VfDzkMpAerRyueIXyeSXWfqSyFUCRunDSqIKcU1N00UciBReNZh/a
	cJnLFGTnlg4f5gzqsvetsr/LtEwb6E56x7lW86N+SA==
X-Google-Smtp-Source: ACHHUZ6+tLk2VFX/2aIspvFFM/iHnhb6Ko4XlQhxE7q6QBwBWGsk0HQdSVd315n0JCCL7gJ5cQmULw==
X-Received: by 2002:a17:902:e810:b0:1a9:a3b3:f935 with SMTP id u16-20020a170902e81000b001a9a3b3f935mr246077plg.57.1683124272744;
        Wed, 03 May 2023 07:31:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902bd4300b001aaf83873dbsm5535072plx.162.2023.05.03.07.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:31:11 -0700 (PDT)
Message-ID: <6452702f.170a0220.b4918.b3b6@mx.google.com>
Date: Wed, 03 May 2023 07:31:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1187-g8497d3390dc2
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st baseline-nfs: 18 runs,
 3 regressions (v4.4-st20-1187-g8497d3390dc2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 14:31:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11399

cip/linux-4.4.y-st baseline-nfs: 18 runs, 3 regressions (v4.4-st20-1187-g84=
97d3390dc2)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1187-g8497d3390dc2/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1187-g8497d3390dc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8497d3390dc25bbe1606a8188178942016d00a67 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645269b03cad671f862e85f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230421.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/645269b03cad671f8=
62e85f6
        failing since 30 days (last pass: v4.4-st20-939-g5ff13a6decb9, firs=
t fail: v4.4-st20-1098-g8d34bf42efd9b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64526ae9ba318ec7492e85f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230421.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64526ae9ba318ec74=
92e85f8
        new failure (last pass: v4.4-st20-1098-g8d34bf42efd9b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64526999a7a19661c72e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230421.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64526999a7a19661c=
72e85f0
        new failure (last pass: v4.4-st20-1098-g8d34bf42efd9b) =

 =20

