Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F39DC43217
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 15:52:08 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web08.585.1664553123577586485
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=OoXsJp6U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id e68so4610931pfe.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=1jOFAmxTtNlEHDg974G9HEVTV9F/7u2As7eBysiM+2U=;
        b=OoXsJp6Ue07DCPeHw7HuXDj0l/NQ1KWl8HOWAbcT6B2rXkVWpJCg/fnPeYIiAsQvVC
         Zs+N3XdVcSIiUjiiq7VoMYbwi5q3wUJjTHoukxl53R39SVPW1bxtanSPukvb0rchcuTZ
         59mpikyN9jdDE7RSYOkLQpGmDVImcmLVT5872mobt9H36IN7IHFp5STlendE3pxXfUrK
         SJ3j1GB4tuwT3lLJ5JA0hHfVTFr4gquXsEJIAB9lMabvSyARpCXSwHOt9BDBHZ0Hzupu
         VMkaLilVW3c0lw+REpC11QwKD+mTNomgYZDHLKfDZRthQiK/d+XBM/b5/1vjEpDbJ4G0
         goTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=1jOFAmxTtNlEHDg974G9HEVTV9F/7u2As7eBysiM+2U=;
        b=1UTFme9cqqDe6hytbgkwcdC9BhjL8lUNlt9YulehtxycD/7kL9YcfTVTm0SO541smW
         pgHw4uih8lBptYCdtbkJVv1bdvcg63BXjFncGrJ666Q10Qewcq+USQnS/XfMmg8OFZlD
         NFx3PQyxTh7Ra8LuiNzWZOuvEjexz5Xlm7rpGwYigGizDVHBGvJ6VRh80Y/+L7FrYD/J
         1lqvEczt2Th6rlkWqCJMt5jvl9Ud33UEWZOs5c2dNiBEO0ZCrqX48i15jekM2nV4ig3p
         3Pt3XjLjBrSKmUKA0C9NOudFUbKfIWzcRo2+77MnVODw9T45Q6e5C0lr/a4fRNEzxzMk
         uBrw==
X-Gm-Message-State: ACrzQf0GSeCKx06RQc4insyE6Nu20OuBaOoEaI71adgWZYaa01ze+OKO
	ENjyDhiawt25xQASYDO3YxtBph9+yB3csRXhdbE=
X-Google-Smtp-Source: 
 AMsMyM6HJIur1mpRijBkKQfNnSXwtVKtKQpEWkXbEswxLPvoOsGXjOP5Z3RauIj0j/DaCXCM1oOMxg==
X-Received: by 2002:a65:6e4a:0:b0:438:874c:53fd with SMTP id
 be10-20020a656e4a000000b00438874c53fdmr8364110pgb.355.1664553126979;
        Fri, 30 Sep 2022 08:52:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 k17-20020a170902c41100b0016c0b0fe1c6sm2102187plk.73.2022.09.30.08.52.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:52:06 -0700 (PDT)
Message-ID: <633710a6.170a0220.45c39.475e@mx.google.com>
Date: Fri, 30 Sep 2022 08:52:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-98-gb2bfffe124dae
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 6 runs,
 5 regressions (v4.4.302-cip70-98-gb2bfffe124dae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 15:52:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9599

cip-gitlab/ci/pavel/linux-test smc: 6 runs, 5 regressions (v4.4.302-cip70-9=
8-gb2bfffe124dae)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 2          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-98-gb2bfffe124dae/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-98-gb2bfffe124dae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2bfffe124dae9fd793da3a9d45f286a98412d6b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63370668ef83e0c30aec4ec1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/63370668ef83e0c30aec4ec2
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6337039419109d2bffec4ec5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/smc-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/smc-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6337039419109d2bffec4ec6
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 2          =


  Details:     https://kernelci.org/test/plan/id/6336ff984d26f1f2c8ec4ead

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig/gcc-10/lab-collab=
ora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig/gcc-10/lab-collab=
ora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6336ff984d26f1f2c8=
ec4eaf
        failing since 44 days (last pass: v5.10.131-cip13-49-g1145e9c6352e6=
, first fail: v5.10.131-cip13-84-g5fcbe4a63ab4d)

    2022-09-30T14:39:07.265077  [    2.012132] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =


  * smc.CVE-2017-5715: https://kernelci.org/test/case/id/6336ff984d26f1f2c8=
ec4ebc
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8)

    2022-09-30T14:39:07.209299  [    1.956530] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2017-5715 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6337030839d71dd93cec4eab

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2017-5715: https://kernelci.org/test/case/id/6337030839d71dd93c=
ec4eba
        failing since 12 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-30T14:53:36.838828  [    7.080335] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2017-5753 RESULT=3Dpass>
    2022-09-30T14:53:36.874637  [    7.123351] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2017-5715 RESULT=3Dfail>   =

 =20

