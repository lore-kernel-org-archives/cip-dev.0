X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.25992.1653837579700501445
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 May 2022 08:19:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=iVR8jgUy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id m14-20020a17090a414e00b001df77d29587so11237549pjg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 May 2022 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=V3zlhTUADWlq68pDeP4TaKxtzs5liW7Web5TEoxxzoI=;
        b=iVR8jgUybHMW2d0zBmtR1vXsHH21LlBA/S/rrBafywVNEoQ5OR5609AQgUMq8/5A+h
         htSyzMh0o/spT/soij24LrPk8RfmqPIgiWsRir6mvxMEtuhUPHorcAji1PWdeZ2Z/U8F
         DT6S2JDetMDg1r0EKinLQWx+2U3v92ti5fksdI+Z4kBwbbvF+aq2p621AaLORr04sT3e
         QerhVri7ZIN5xiVGVN1ueeWems/TB40Xs0f0I0pdbOFaOKz92MfX/4Xm7UwyWEXKm8TK
         jvmOo2ZPvlEM3aubFrXyAASuBtkZrP5Nny7G9lBhN3b/jvm2nrWcuqtGZd6iBAzYJeAG
         uWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=V3zlhTUADWlq68pDeP4TaKxtzs5liW7Web5TEoxxzoI=;
        b=LkE6H6KJxaDqXrfDlb2ofXSEAzCycCjfT/hRc1/ZeCGWnPMcS/vM65q6azJoBW2ILy
         cVtGcUx9web+58tXEyEgeLSN2Ei/UshMmKkgtITkGJTxUOSBFHVsmz0rcseMLuNFtRiY
         BepFEbklcit8fPSuJrlCuc9GglzQvYdYpqu8KcveFK0kAZcjWXpZOq/8Z9vfvDgG8JRm
         +rRhTKD9tj8S84tW87EHOgZ6YfK5AKOyflovd1yKxpkY51hmTEUq1PpXsWAXtJ5hECY7
         3LT6ToMQ52pFizL2HRXW3xFyfhpxWjO7IGPsaFUc8hKcMBqTgWR60JDJtZl1gXMNKQUE
         aX3g==
X-Gm-Message-State: AOAM532RJ13z+3HxDb/9PL3yz3O3YzoMBre25ORSD8VxeYFNd31JXObY
	kMfAeDUf9qBgw9O77UiwoRZDXOnD0k7i44C0U1A=
X-Google-Smtp-Source: ABdhPJzWByXByzQafpeT4VBJ3xcBbPAyrItzhd1sbJkW/UDO9YsaXEwD5yuMd5VX3kW64KGpozHB9g==
X-Received: by 2002:a17:90b:1e0d:b0:1e0:7133:b3dc with SMTP id pg13-20020a17090b1e0d00b001e07133b3dcmr18573417pjb.42.1653837579063;
        Sun, 29 May 2022 08:19:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c135-20020a621c8d000000b0051874318772sm7010813pfc.201.2022.05.29.08.19.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 08:19:38 -0700 (PDT)
Message-ID: <62938f0a.1c69fb81.65f21.fce3@mx.google.com>
Date: Sun, 29 May 2022 08:19:38 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-297-gc0d53c2a5c03d
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4-st5-297-gc0d53c2a5c03d) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4-st5-297-gc0=
d53c2a5c03d)

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
nux-test/kernel/v4.4-st5-297-gc0d53c2a5c03d/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-297-gc0d53c2a5c03d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0d53c2a5c03d0b2672a56140f211b51b3e047c1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937a951d3b5a920ba39bd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62937a951d3b5a920ba39bd5
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62937e990b850e5ab5a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-=
qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-=
qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62937e990b850e5ab5a39bce
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62937998903f0eaf0aa39be9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62937998903f0eaf0aa39bea
        failing since 18 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62937e0dcc8caa6408a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62937e0dcc8caa6408a39bce
        failing since 18 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

