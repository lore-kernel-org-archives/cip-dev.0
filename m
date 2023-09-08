Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42511EE800A
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 14:03:08 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.39896.1694181787547012026
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Sep 2023 07:03:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=KFA+BeAH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c336f3f449so18015415ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Sep 2023 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694181786; x=1694786586; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=prk7J4emmPp6V4IzX1Gir0gL8EY/whp8R4q8C4izFIM=;
        b=KFA+BeAHGiB2OjWBae6nFwN14y/W5mrEZFF/E8fwrOn14Zu17jm+2Zsi1RGm0tJeB4
         qM852/YqknjYu9MAztWWKcz5kQjXDbRhHnX2DMLg2phiPTAEgmJdxnogiBq0jWW3Z7mC
         aUueAAJOcUjw4XoSNpARQGDayqWMMd/j2OlaZcPHPeryJP6Et9iVMler65KWRMt4s93V
         UxnieDUFr9K0B6jFMvbzUA4XuZEoZDplvSR57hGVZbOOMHrsgF6Sh+mqxill2IE9Ki67
         CItRy3tdo0BLIPn4Ga3r7ks22cVepFPeg+DfCZc6D8ZZIjE6GdOrbUzfFLp84wiiT1EQ
         L+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694181786; x=1694786586;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prk7J4emmPp6V4IzX1Gir0gL8EY/whp8R4q8C4izFIM=;
        b=ueoAxUGPuwJ+TlWAkBp0HTT8XHwqYYEG7CJpqkw5PhHwMO+u4axvzQDdm3o54vK2Y8
         Dz1trYWHR4EYDbZQWuF2tKcU4vTQojiahGiCxzxrm38Orhtd2mt/c03rufHDrcXg9ylW
         AF659yMmecC5JF6px98Pj+vKoghSxEgsGZQEqyb9sLYxMif/1/R4d9epr00vcFqBZgl6
         BB1xWWRrCnNAcw+XEjXVyuD7JhXrud162vwjdi1+kWJIx/aAiNpkesCvUXZ/tPQ59BjY
         2WMshjUoLf615HQgFnLzyND9zQKk5a4axojwzSIEikDryRt6lZLbsYk+dHF4Ca+Nd3N0
         jcww==
X-Gm-Message-State: AOJu0YwDJamvph1hRcs3LWgylp/bSKA+wt/9I5xKuUJahzNtrPKSPs+D
	t4IBFGU3ogURXTx92USOGg3QxLsHkCM4sLpidUU0qw==
X-Google-Smtp-Source: AGHT+IF5swFhkYsXAQu634gZIt/zQ+AgmFGKO7lG/A+tkBQjSHjZxtJZGJf2eP5D0ACt8pSsjcRo9g==
X-Received: by 2002:a17:902:da8e:b0:1bd:a22a:d406 with SMTP id j14-20020a170902da8e00b001bda22ad406mr3063036plx.21.1694181786577;
        Fri, 08 Sep 2023 07:03:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b001aaf2e8b1eesm1636884pln.248.2023.09.08.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:03:06 -0700 (PDT)
Message-ID: <64fb299a.170a0220.437f5.37e8@mx.google.com>
Date: Fri, 08 Sep 2023 07:03:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.52-cip5
Subject: cip/linux-6.1.y-cip baseline: 136 runs, 7 regressions (v6.1.52-cip5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Sep 2023 14:03:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13013

cip/linux-6.1.y-cip baseline: 136 runs, 7 regressions (v6.1.52-cip5)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

juno-uboot               | arm64  | lab-broonie   | gcc-10   | cip://6.1.y-=
c...64_defconfig | 2          =

juno-uboot               | arm64  | lab-broonie   | gcc-10   | defconfig   =
                 | 1          =

r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

rk3399-rock-pi-4b        | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.52-cip5/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.52-cip5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      98ee1708ccc7301dbbfaafec75350f88527046a1 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fb23164c5e388350286db7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-ace=
r-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-ace=
r-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64fb23164c5e388350286=
db8
        failing since 25 days (last pass: v6.1.42-cip2-1-g47d13938e615, fir=
st fail: v6.1.45-cip3) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
juno-uboot               | arm64  | lab-broonie   | gcc-10   | cip://6.1.y-=
c...64_defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64fb23be02a0b7fdb22886ba

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
64fb23be02a0b7fdb22886d7
        failing since 39 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-09-08T13:37:53.960784  /lava-92216/1/../bin/lava-test-case
    2023-09-08T13:37:53.999513  <8>[   35.070579] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-09-08T13:37:54.000008  /lava-92216/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/64fb=
23be02a0b7fdb22886d9
        failing since 39 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-09-08T13:37:52.906642  /lava-92216/1/../bin/lava-test-case
    2023-09-08T13:37:52.930689  <8>[   34.017687] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-09-08T13:37:52.931190  /lava-92216/1/../bin/lava-test-case   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
juno-uboot               | arm64  | lab-broonie   | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64fb22cd4b96f9686a286dff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64fb22cd4b96f9686a286=
e00
        new failure (last pass: v6.1.46-cip4-14-g09ffd7fb38ff) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64fb2232ef5da5eb39286d6f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fb2232ef5da5eb39286d78
        failing since 39 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.42-cip2)

    2023-09-08T13:32:50.595944  / # #

    2023-09-08T13:32:50.697798  export SHELL=3D/bin/sh

    2023-09-08T13:32:50.698456  #

    2023-09-08T13:32:50.799662  / # export SHELL=3D/bin/sh. /lava-11471329/=
environment

    2023-09-08T13:32:50.799880  =


    2023-09-08T13:32:50.900537  / # . /lava-11471329/environment/lava-11471=
329/bin/lava-test-runner /lava-11471329/1

    2023-09-08T13:32:50.900812  =


    2023-09-08T13:32:50.908994  / # /lava-11471329/bin/lava-test-runner /la=
va-11471329/1

    2023-09-08T13:32:50.957024  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-08T13:32:50.968709  + cd /lav<8>[   19.057516] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11471329_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-rock-pi-4b        | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64fb232e135c2b519a286d76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64fb232e135c2b519a286=
d77
        new failure (last pass: v6.1.46-cip4-14-g09ffd7fb38ff) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64fb22300cec1dea3d286de7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fb22300cec1dea3d286dec
        failing since 39 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-09-08T13:33:01.979419  / # #

    2023-09-08T13:33:02.080346  export SHELL=3D/bin/sh

    2023-09-08T13:33:02.080487  #

    2023-09-08T13:33:02.181198  / # export SHELL=3D/bin/sh. /lava-11471316/=
environment

    2023-09-08T13:33:02.181838  =


    2023-09-08T13:33:02.282872  / # . /lava-11471316/environment/lava-11471=
316/bin/lava-test-runner /lava-11471316/1

    2023-09-08T13:33:02.283600  =


    2023-09-08T13:33:02.291256  / # /lava-11471316/bin/lava-test-runner /la=
va-11471316/1

    2023-09-08T13:33:02.363862  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-08T13:33:02.364035  + cd /lava-1147131<8>[   18.717374] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11471316_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

