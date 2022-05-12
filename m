X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web09.2242.1652348953968969800
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 02:49:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=R8aTyEhN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id r71so3791088pgr.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yM7gFRMVJjrh+jS+gYOztzHglapKTRvGVjpqe3HfDyY=;
        b=R8aTyEhNQMguLwa6Tk7iQ9GYqbwGBHdlWb/KTdH5J3lf/EL/W6mfv34A/kHuWSyi/B
         0wJRmESjMcpy4elsS+EUMVGN5qpP0IZkGiM5jghpMwCcOZoTPknMjq/XGo4wMYVdDNFT
         jPK1Lsz7TkLVP6ly+Wx0QKiE7LP7M5Zg2wdhVVWVi6cP3umBkWvcHwpiLmo2fdEfEPsn
         uzaSMAubGzgpBK9MEDOWwZumI440o9MLn4QgJ+rWMC1n9ulFAYCz/uxJyV6lvMKIOv/I
         4c7CyKmclDCvXypDmZCRXk3uSFbxwiWMEYeMa+QQ68tpWPgJyftqvWRixiHN8rMteXHW
         PKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yM7gFRMVJjrh+jS+gYOztzHglapKTRvGVjpqe3HfDyY=;
        b=jdCcKm5TX/Sqn0popb7/BsbwvdTHJ5Ups62jOxPfMVwLqO9CNBeJhYC6E8yQPQjwG5
         kpUcTML+7Q/YoaPBgTBS0jqVh1fYEfK29sWrH0fHz9eH6902xraoDH/qSCCVWgybloki
         n4erVk9hIAf87w3RXj2mGG2DMY1aX+KBsrysmVIOc/ZOtoaFbgtXLtrY7DbNgAg6mAxA
         WlBhCwQ2KytLEeesqUWv6YFH+8Fb5WdeboQ5M9uB0eVWZEsr6jTSa1TgtzBa56VrPAg8
         +ibEs37HK53ky3OBI3ObB3LNEZiYKP0xgLp0rNbe7LWMGOGulTw5mxwU+zR+YHfYRH38
         X53A==
X-Gm-Message-State: AOAM530WbcxFUY2kNMXH1fcZJuh79AYZ9FDVlLG3OGIKW2Geh33R7als
	p7C1bef02lRib1S4hCAMsTusmxf8hyC3u8xlTCA=
X-Google-Smtp-Source: ABdhPJyFtKOgRYmzLfOVnYggDqSdybVnu44OiY9NBdfpu3K73SV/sUYxXhJEflg4vRr0uESaj2EfbQ==
X-Received: by 2002:a63:535c:0:b0:3db:69da:1ef7 with SMTP id t28-20020a63535c000000b003db69da1ef7mr1574947pgl.239.1652348953299;
        Thu, 12 May 2022 02:49:13 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b0015e8d4eb1c6sm3588754plg.16.2022.05.12.02.49.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:49:12 -0700 (PDT)
Message-ID: <627cd818.1c69fb81.9df61.7fb3@mx.google.com>
Date: Thu, 12 May 2022 02:49:12 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-49-g02cbcd6511d4
Subject: cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4-st5-49-g02cbcd6511d4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4-st5-49-g02c=
bcd6511d4)

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

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-49-g02cbcd6511d4/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-49-g02cbcd6511d4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02cbcd6511d490bde09277489d0cd57e67cd1d77 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627cd4895453788d138f5724

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627cd4895453788d138f5725
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/627cd1fca6466d38208f5734

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-qe=
mu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-qe=
mu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627cd1fca6466d38208f5735
        failing since 1 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/627cd1ac82816405228f571a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627cd1ac82816405228f571b
        failing since 1 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627cd1e8a6466d38208f572e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm64/defconfig+arm64-chromebook/gcc-10/lab-broo=
nie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm64/defconfig+arm64-chromebook/gcc-10/lab-broo=
nie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627cd1e8a6466d38208f572f
        failing since 1 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

