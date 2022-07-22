Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BE0CCA473
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 17:44:17 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web12.10676.1658511850597364410
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 10:44:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=SzMEG91Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 72so5029267pge.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=m0BLRNlzr1kPhLp5k6sxnEAkZgOMUWhbkSIF4pZN7EE=;
        b=SzMEG91Qtf2fiUQ4MTTv3EFU+NmuHXBohjGxHR9oNgRdUOPmpOvv4OjMUXT1ZtZ31j
         oZqkb9nufLV7Yt1yFq9ppNQG60kLqszKwRxbaiX4NqAo4o85/Rvblk6SOo/+Ky3EP7fj
         ExKg11AIRNFpd4x4n8SBCndX4tXH/AOYnFsEZYIubgdG0eFY1zF9nByYC+ijWiej0zaD
         i8jD+PWQT9d8XZBELSOZ6ru+NCYzioqxH8RK6fTpTBdT7AY1DNs10G2ume8TitdxUZYe
         tV4slUm2khCe7jOO1e4oT5VocziQNewv+nvZ/0BGU9V5acgUpAqincpPilEwobIABFA3
         AWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=m0BLRNlzr1kPhLp5k6sxnEAkZgOMUWhbkSIF4pZN7EE=;
        b=0dOuID4vuW1xAEazoej2X7vGH48npGfjZiKe9KNgGXcZN8tPHXwxw7AFRmxRp4qSS5
         yJRwp18dTnUIxFpxQTlS9eXCjNmMrJYC0M7vU/URV6kUwTick4pnwEDMZgpwDednnk7k
         ESRQDCqhIaT+MTf7amPAyFLKBqDQdURECOJchn7woR76jdz7hPbexBthhQG+bQ8ZBQID
         9JvyrwS9UIk/+HQk/A/603Of23UVAbwdc6Wq3zkU7/ISW3S2K7nDsOB8XjhVgXp+R8uZ
         Wx9M9dSryjO/yXnJ/wBQyjtP+9vbTS6h/4HxaIOeAAiVO0yA9omg3kb+hxa4ZbU1bDcH
         bXEQ==
X-Gm-Message-State: AJIora+VLLW6fN2hSAZ1hgwl/LL4+BFUQhLTl1hezCB7c30kjJl183GL
	5+R7aljDqlS2rce/UfRNODlXG1IhlmWrjpF2
X-Google-Smtp-Source: 
 AGRyM1v7whHfmA0htHjO/qRio6DMLbvUIPZpcxMfH2pfGVO6sAymRDsTJ6Hrgv45M4gz6XB9VK7uxQ==
X-Received: by 2002:a63:d34d:0:b0:412:6c20:2899 with SMTP id
 u13-20020a63d34d000000b004126c202899mr737750pgi.602.1658511849800;
        Fri, 22 Jul 2022 10:44:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b13-20020aa7950d000000b00528c3ad8e09sm4142410pfp.66.2022.07.22.10.44.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 10:44:09 -0700 (PDT)
Message-ID: <62dae1e9.1c69fb81.5f925.6bcb@mx.google.com>
Date: Fri, 22 Jul 2022 10:44:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77-82-g10c370b53152
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 8 runs,
 3 regressions (v4.19.251-cip77-82-g10c370b53152)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Jul 2022 17:44:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8882

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 8 runs, 3 regr=
essions (v4.19.251-cip77-82-g10c370b53152)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.251-cip77-82-g10c370b53152/plan/baseline-=
cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.251-cip77-82-g10c370b53152
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10c370b53152e01c8282be083dc0943e33d50ead =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62da5645f0d302c253daf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62da5645f0d30=
2c253daf065
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62da5d25f8a2059ba0daf05a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62da5d25f8a20=
59ba0daf05b
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da5f199d5fd98a59daf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62da5f199d5fd=
98a59daf060
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =20

