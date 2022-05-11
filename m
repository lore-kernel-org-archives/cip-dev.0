X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.11999.1652278180511567181
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 07:09:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zUW+MbgJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d22so1983808plr.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=a0ecJa+8ePlZso1AHCe/lkVrCehHjFpNz7M/xu3Nc5o=;
        b=zUW+MbgJSFqWIsuN7dpxeSMOT8JiKoo2yma3yQgODEbGhfaFHWiY9iVTAOpIFDYfbC
         f2c0zfD7iFKiNwn/Dfjv9ymTjc9dY37dM4BLRVWayKlfngj51m2lYvPHQkvLHEzgefKY
         7AU/qwoT9QDQerC5iyoDoLpD0J35c+tisWrfCeydfrHpGW/einq3c/OprIxZO8HV5v3L
         eOSI4l/j0LgwTFVwiiOUn8zKl/3m4RWU03e3UT2ADth+duHhxK9Oz2BZMjrjJxBcYElC
         PedPMDwXbtsnCa1Fmz76Kxy0rPIZy0K2BZh8o9cXI+ABXhYzzhGgIj6fgzd+Sk2sRAF2
         lPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=a0ecJa+8ePlZso1AHCe/lkVrCehHjFpNz7M/xu3Nc5o=;
        b=CKmd1hrwCD18bZJQnkwDPAh2XnDex6CZTWS07O99mYVDhiSnBGKnI2zZct0IfzW0tA
         eXznIhcPOuTloQvLdey21mNihIoTQCzyvdqlRXIJz0lo3Y0E+zmIH2kkYPv2nLFqFwkG
         HURbjwHCpFaDfullGQ9Pd0wQBY6QR8PIE087OxdC979nozF3uwTfVgv23Ew/8KSMuFzE
         P6UVfTwKZaTi70aLQHqnaFt6RhOVKSxhfEFZtQ7rQ10cLj4aRk80RcB1VuOjFvXRZvDD
         stb7HeT3WwDlHtAONLi0BgUu0vkUPrx/+C06U9F3nrxCoFx8dQa75KqjAYnFM4mQaz9C
         La4g==
X-Gm-Message-State: AOAM531c61GUefx8tV8/JlZDJhWBe9fXlSpiyhfNEWm+p0BZIg6OsR1T
	xODH1UrkUnyu3snDA8Ut+MsQMz+GmwOFEdnQiQ8=
X-Google-Smtp-Source: ABdhPJwn3VihmwuldQfuo9MSiJob0ULh3w4zQLV+xQ4G2JljMDENoHlYHT3jRVVFBw2+6C1DpVlAPA==
X-Received: by 2002:a17:90a:f3c7:b0:1d9:6832:7be0 with SMTP id ha7-20020a17090af3c700b001d968327be0mr5606437pjb.209.1652278179724;
        Wed, 11 May 2022 07:09:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id pc11-20020a17090b3b8b00b001dc4d22c0a7sm1940214pjb.10.2022.05.11.07.09.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:09:39 -0700 (PDT)
Message-ID: <627bc3a3.1c69fb81.ba69c.3f13@mx.google.com>
Date: Wed, 11 May 2022 07:09:39 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-17-g04a3c17cb526f
Subject: cip-gitlab/ci/pavel/linux-test smc: 7 runs, 4 regressions (v4.4-st5-17-g04a3c17cb526f) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 7 runs, 4 regressions (v4.4-st5-17-g04a=
3c17cb526f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-17-g04a3c17cb526f/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-17-g04a3c17cb526f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      04a3c17cb526ff31d466407f119fa9692b4cee08 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bc21f7165aa79e48f5754

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627bc21f7165aa79e48f5755
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/627bc396a56198912d8f572d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627bc396a56198912d8f572e
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bc20510792770a98f5719

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627bc20510792770a98f571a
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/627bc21a7165aa79e48f5746

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627bc21a7165aa79e48f5747
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

