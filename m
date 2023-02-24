Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B92C6FA9D
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 11:01:29 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.15017.1677236488489857398
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 03:01:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=8QFAVmLn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id ko13so16995079plb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 03:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H4r6RpuBr6Hw7uuRA3kmZPg359UAJjF/xTXmE7rO/F0=;
        b=8QFAVmLnINTKHriAXOiMyZdHbqOGZF3K8PZtfjcsGGdvVrONWHV/34Zgs0UvXA4Uo/
         ipQS+PsC4iFddwRINPwPEB+tNnD/zNoQJIgfjfz0ofEjqCY9Eo5aPFgawE1HGF+7WHPe
         dlmx9GlL7h2l9OrooSfextfnn0UQkJY/RgUufbbWMpNoPzw3cjnpW/npFBQH5D2j7z17
         s3rE/9HCzGenZyPNiYqekBTnrFCodgc+UXtYDQwrZfld//YsDI59nxkkIgPjXSnCCUb/
         LOtt0rBz4XZw6MbcHsxHvNNEl3J26eRTD7GwHoO7/H4NaaB9Wh/BSVaToU7sqe1hXzFV
         FaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4r6RpuBr6Hw7uuRA3kmZPg359UAJjF/xTXmE7rO/F0=;
        b=TF+A+0peV5knWEj4t/w1rCiNRdhyvhpDVAAQmeMTg2AWZpbJXNgAHNvnNqKVFUPTCm
         VMlRqKDxbpKASvn5cuixp2IThpHs7NI+5kLqMJBnnJlKc6koePjnsC9lPZrIIbCFMghn
         eFZPVo60IF+Hg84x4M97wt8eFhbNYZtkW3kSoKuUyntfFX9P1Q0EUqnyOLMdiuP6lCfn
         YRKYKDWRpANNQ+BlNWCZD56t/KpSQqgKTuqhil2IGSDJ+F4FuI7MIOFMm3FCfoCFoSec
         nQp8l36xkV0VuqSNID4sJi7SPyNDbqKk89IUNG/Om5QSCUkfyVMTlrVWoTsP+f7HSaF8
         bw2g==
X-Gm-Message-State: AO0yUKV35yYiavMSg2ZBzwXUUZr9SkrpLTytqMUE0QXmtEaXWCzFt50B
	nFp4hU6VzVUnEjzmbv4LgWtAVM+6aPR+x4DPQl/WgA==
X-Google-Smtp-Source: AK7set81eC13ypr08UafLQDMF96Sb4BIMwElpLIqtQctzIRJFUUetaHfEYVJ8wqSywFWcQVnkHmwfw==
X-Received: by 2002:a05:6a20:394f:b0:c0:df5b:e9e7 with SMTP id r15-20020a056a20394f00b000c0df5be9e7mr18467172pzg.60.1677236486870;
        Fri, 24 Feb 2023 03:01:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b00593e5a45ce7sm3075828pfe.173.2023.02.24.03.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:01:26 -0800 (PST)
Message-ID: <63f89906.a70a0220.ddb2a.58ed@mx.google.com>
Date: Fri, 24 Feb 2023 03:01:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.168-cip27
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 149 runs,
 32 regressions (v5.10.168-cip27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 11:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10807

cip/linux-5.10.y-cip baseline: 149 runs, 32 regressions (v5.10.168-cip27)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

qemu_i386-uefi            | i386   | lab-broonie     | gcc-10   | i386_defc=
onfig               | 1          =

qemu_i386-uefi            | i386   | lab-collabora   | gcc-10   | i386_defc=
onfig               | 1          =

qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

qemu_x86_64-uefi          | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi          | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.168-cip27/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.168-cip27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cc82f737b68c179240070fa34771bcfd0a5fa421 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88ab6ff553eea8c8c8666

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f88ab6ff553eea8c8c866f
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:00:00.730215  + set +x

    2023-02-24T10:00:00.736470  <8>[   10.459279] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9314545_1.4.2.3.1>

    2023-02-24T10:00:00.841364  / # #

    2023-02-24T10:00:00.942171  export SHELL=3D/bin/sh

    2023-02-24T10:00:00.942394  #

    2023-02-24T10:00:01.043287  / # export SHELL=3D/bin/sh. /lava-9314545/e=
nvironment

    2023-02-24T10:00:01.043493  =


    2023-02-24T10:00:01.144423  / # . /lava-9314545/environment/lava-931454=
5/bin/lava-test-runner /lava-9314545/1

    2023-02-24T10:00:01.144714  =


    2023-02-24T10:00:01.150458  / # /lava-9314545/bin/lava-test-runner /lav=
a-9314545/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88abace79a85d248c864c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f88abace79a85d248c8655
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:00:05.879796  + set +x

    2023-02-24T10:00:05.886321  <8>[   10.736967] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9314509_1.4.2.3.1>

    2023-02-24T10:00:05.993586  =


    2023-02-24T10:00:06.094536  / # #export SHELL=3D/bin/sh

    2023-02-24T10:00:06.094729  =


    2023-02-24T10:00:06.195669  / # export SHELL=3D/bin/sh. /lava-9314509/e=
nvironment

    2023-02-24T10:00:06.195989  =


    2023-02-24T10:00:06.296949  / # . /lava-9314509/environment/lava-931450=
9/bin/lava-test-runner /lava-9314509/1

    2023-02-24T10:00:06.297253  =


    2023-02-24T10:00:06.302490  / # /lava-9314509/bin/lava-test-runner /lav=
a-9314509/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88accb05808c0338c863a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f88accb05808c0338c8643
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:00:17.054035  + set +x

    2023-02-24T10:00:17.060354  <8>[   10.589173] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9314562_1.4.2.3.1>

    2023-02-24T10:00:17.165296  / # #

    2023-02-24T10:00:17.268198  export SHELL=3D/bin/sh

    2023-02-24T10:00:17.269016  #

    2023-02-24T10:00:17.370836  / # export SHELL=3D/bin/sh. /lava-9314562/e=
nvironment

    2023-02-24T10:00:17.371679  =


    2023-02-24T10:00:17.473572  / # . /lava-9314562/environment/lava-931456=
2/bin/lava-test-runner /lava-9314562/1

    2023-02-24T10:00:17.474750  =


    2023-02-24T10:00:17.479561  / # /lava-9314562/bin/lava-test-runner /lav=
a-9314562/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88c1ec2903376b38c86a1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f88c1ec2903376b38c86aa
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:06:06.475442  + set +x
    2023-02-24T10:06:06.480613  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 68784_1.5.2.=
4.1>
    2023-02-24T10:06:06.594408  / # #
    2023-02-24T10:06:06.697139  export SHELL=3D/bin/sh
    2023-02-24T10:06:06.697908  #
    2023-02-24T10:06:06.799828  / # export SHELL=3D/bin/sh. /lava-68784/env=
ironment
    2023-02-24T10:06:06.800609  =

    2023-02-24T10:06:06.902543  / # . /lava-68784/environment/lava-68784/bi=
n/lava-test-runner /lava-68784/1
    2023-02-24T10:06:06.903815  =

    2023-02-24T10:06:06.910315  / # /lava-68784/bin/lava-test-runner /lava-=
68784/1 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f8926601f9fbe8518c86a1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f8926601f9fbe8518c86aa
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:32:54.598347  <8>[   21.245740] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 68873_1.5.2.4.1>
    2023-02-24T10:32:54.708893  / # #
    2023-02-24T10:32:54.810952  export SHELL=3D/bin/sh
    2023-02-24T10:32:54.811326  #
    2023-02-24T10:32:54.912481  / # export SHELL=3D/bin/sh. /lava-68873/env=
ironment
    2023-02-24T10:32:54.913048  =

    2023-02-24T10:32:55.014635  / # . /lava-68873/environment/lava-68873/bi=
n/lava-test-runner /lava-68873/1
    2023-02-24T10:32:55.015542  =

    2023-02-24T10:32:55.019686  / # /lava-68873/bin/lava-test-runner /lava-=
68873/1
    2023-02-24T10:32:55.114980  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88cdb087bcd62258c8679

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f88cdb087bcd62258c8682
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:09:10.143848  <8>[   16.278222] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 68826_1.5.2.4.1>
    2023-02-24T10:09:10.255107  / # #
    2023-02-24T10:09:10.358210  export SHELL=3D/bin/sh
    2023-02-24T10:09:10.359119  #
    2023-02-24T10:09:10.461211  / # export SHELL=3D/bin/sh. /lava-68826/env=
ironment
    2023-02-24T10:09:10.462126  =

    2023-02-24T10:09:10.564228  / # . /lava-68826/environment/lava-68826/bi=
n/lava-test-runner /lava-68826/1
    2023-02-24T10:09:10.565633  =

    2023-02-24T10:09:10.570249  / # /lava-68826/bin/lava-test-runner /lava-=
68826/1
    2023-02-24T10:09:10.677206  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f89264eb89888a638c864b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f89264eb89888a638c8654
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:32:51.578126  + set<8>[    9.853939] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9315288_1.5.2.4.1>

    2023-02-24T10:32:51.578389   +x

    2023-02-24T10:32:51.685523  / # #

    2023-02-24T10:32:51.787612  export SHELL=3D/bin/sh

    2023-02-24T10:32:51.788639  #

    2023-02-24T10:32:51.890702  / # export SHELL=3D/bin/sh. /lava-9315288/e=
nvironment

    2023-02-24T10:32:51.893436  =


    2023-02-24T10:32:51.995777  / # . /lava-9315288/environment/lava-931528=
8/bin/lava-test-runner /lava-9315288/1

    2023-02-24T10:32:51.997108  =


    2023-02-24T10:32:51.999107  / # /lava-9315288/bin/lava-test-runner /lav=
a-9315288/1
 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88b0e4f4ba2b8fa8c8662

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f88b0e4f4ba2b8fa8c866b
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:01:27.603380  + set +x
    2023-02-24T10:01:27.603585  [   11.464467] <LAVA_SIGNAL_ENDRUN 0_dmesg =
912414_1.5.2.3.1>
    2023-02-24T10:01:27.711565  / # #
    2023-02-24T10:01:27.813285  export SHELL=3D/bin/sh
    2023-02-24T10:01:27.813932  #
    2023-02-24T10:01:27.915235  / # export SHELL=3D/bin/sh. /lava-912414/en=
vironment
    2023-02-24T10:01:27.915774  =

    2023-02-24T10:01:28.017116  / # . /lava-912414/environment/lava-912414/=
bin/lava-test-runner /lava-912414/1
    2023-02-24T10:01:28.017847  =

    2023-02-24T10:01:28.021382  / # /lava-912414/bin/lava-test-runner /lava=
-912414/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f8923e2ba0eff3988c867a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f8923e2ba0eff3988c8683
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:32:07.410176  + set[    7.238637] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 912423_1.5.2.3.1>
    2023-02-24T10:32:07.410400   +x
    2023-02-24T10:32:07.516494  / # #
    2023-02-24T10:32:07.618265  export SHELL=3D/bin/sh
    2023-02-24T10:32:07.618765  #
    2023-02-24T10:32:07.720010  / # export SHELL=3D/bin/sh. /lava-912423/en=
vironment
    2023-02-24T10:32:07.720583  =

    2023-02-24T10:32:07.822073  / # . /lava-912423/environment/lava-912423/=
bin/lava-test-runner /lava-912423/1
    2023-02-24T10:32:07.822707  =

    2023-02-24T10:32:07.826212  / # /lava-912423/bin/lava-test-runner /lava=
-912423/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88af51eb80662708c8650

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f88af51eb80662708c8670
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:01:14.659033  + set +x

    2023-02-24T10:01:14.664653  <8>[   15.669292] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9314655_1.5.2.3.1>

    2023-02-24T10:01:14.769411  =


    2023-02-24T10:01:14.870413  / # #export SHELL=3D/bin/sh

    2023-02-24T10:01:14.870643  =


    2023-02-24T10:01:14.971531  / # export SHELL=3D/bin/sh. /lava-9314655/e=
nvironment

    2023-02-24T10:01:14.971762  =


    2023-02-24T10:01:15.072657  / # . /lava-9314655/environment/lava-931465=
5/bin/lava-test-runner /lava-9314655/1

    2023-02-24T10:01:15.072971  =


    2023-02-24T10:01:15.074976  / # /lava-9314655/bin/lava-test-runner /lav=
a-9314655/1
 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_i386-uefi            | i386   | lab-broonie     | gcc-10   | i386_defc=
onfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88a600a263146fe8c866d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88a600a263146fe8c8=
66e
        new failure (last pass: v5.10.165-cip25) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_i386-uefi            | i386   | lab-collabora   | gcc-10   | i386_defc=
onfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/63f889f3e5c26ea5438c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f889f3e5c26ea5438c8=
638
        new failure (last pass: v5.10.165-cip25) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88b004f4ba2b8fa8c863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88b004f4ba2b8fa8c8=
63e
        failing since 0 day (last pass: v5.10.162-cip24, first fail: v5.10.=
167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88bc8c003b5d7568c8649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88bc8c003b5d7568c8=
64a
        new failure (last pass: v5.10.162-cip24) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88a35e622b9162c8c8666

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88a35e622b9162c8c8=
667
        failing since 0 day (last pass: v5.10.162-cip24, first fail: v5.10.=
167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88bb07cdb512b048c86b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88bb07cdb512b048c8=
6b5
        new failure (last pass: v5.10.162-cip24) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88aecb05808c0338c8678

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi=
-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi=
-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88aecb05808c0338c8=
679
        failing since 0 day (last pass: v5.10.165-cip25, first fail: v5.10.=
167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88c19c2903376b38c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88c19c2903376b38c8=
630
        failing since 0 day (last pass: v5.10.162-cip24, first fail: v5.10.=
167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88a337385d2eaac8c865f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88a337385d2eaac8c8=
660
        failing since 0 day (last pass: v5.10.165-cip25, first fail: v5.10.=
167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88bad7cdb512b048c86ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88bad7cdb512b048c8=
6af
        failing since 0 day (last pass: v5.10.162-cip24, first fail: v5.10.=
167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88afa4f4ba2b8fa8c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f88afa4f4ba2b8fa8c8=
630
        new failure (last pass: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/63f892780b42b457378c8641

  Results:     63 PASS, 8 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/63f892780b42b457378c8674
        failing since 39 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:33:11.313308  P	String separator

    2023-02-24T10:33:11.316907  /lava-9315297/1/../bin/lava-test-case

    2023-02-24T10:33:11.322969  BusyBox v1.31.1 (2023-02-17 15:41:33 UTC) m=
ulti-call binary.

    2023-02-24T10:33:11.323437  =


    2023-02-24T10:33:11.327547  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-24T10:33:11.328195  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63f892780b42b457378c8675
        failing since 39 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:33:11.289556  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   52.437361] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-02-24T10:33:11.290025  ST

    2023-02-24T10:33:11.290283  =


    2023-02-24T10:33:11.294617  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-24T10:33:11.297056  FIRST, INC default to 1.

    2023-02-24T10:33:11.297291  =


    2023-02-24T10:33:11.300908  	-w	Pad to last with leading zeros

    2023-02-24T10:33:11.311203  	-s SE<8>[   52.462921] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63f892780b42b457378c8676
        failing since 39 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:33:11.274677  BusyBox v1.31.1 (2023-02-17 15:41:33 UTC) m=
ulti-call binary.

    2023-02-24T10:33:11.275167  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f892780b42b457378c868a
        failing since 39 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:32:59.159550  <8>[   40.312728] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-02-24T10:32:59.162548  + set +x

    2023-02-24T10:32:59.170044  <8>[   40.325340] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9315297_1.5.2.3.1>

    2023-02-24T10:32:59.277516  #

    2023-02-24T10:32:59.278793  =


    2023-02-24T10:32:59.381213  / # #export SHELL=3D/bin/sh

    2023-02-24T10:32:59.382008  =


    2023-02-24T10:32:59.484039  / # export SHELL=3D/bin/sh. /lava-9315297/e=
nvironment

    2023-02-24T10:32:59.484868  =


    2023-02-24T10:32:59.586956  / # . /lava-9315297/environment/lava-931529=
7/bin/lava-test-runner /lava-9315297/1
 =

    ... (26 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63f88b830fad9a026c8c865a

  Results:     86 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63f88b840fad9a026c8c8680
        failing since 331 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-02-24T10:03:19.544973  <8>[   32.597787] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>

    2023-02-24T10:03:20.570490  /lava-9314688/1/../bin/lava-test-case

    2023-02-24T10:03:20.581967  <8>[   33.634288] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63f88b840fad9a026c8c8695
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:03:18.866508  /lava-9314688/1/../bin/lava-tes<8>[   31.91=
2997] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357=
A-present RESULT=3Dfail>

    2023-02-24T10:03:18.867157  t-case

    2023-02-24T10:03:18.872996  BusyBox v1.31.1 (2023-02-17 14:37:44 UTC) m=
ulti-call binary.

    2023-02-24T10:03:18.873615  =


    2023-02-24T10:03:18.877468  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-24T10:03:18.877554  =


    2023-02-24T10:03:18.883112  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-24T10:03:18.885216  FIRST, INC default to 1.

    2023-02-24T10:03:18.886013  =


    2023-02-24T10:03:18.888444  	-w	Pad to last with leading zeros
 =

    ... (1 line(s) more)  =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63f88b840fad9a026c8c8696
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:03:18.831204  BusyBox v1.31.1 (2023-02-17 <8>[   31.87902=
7] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-dp-present =
RESULT=3Dfail>

    2023-02-24T10:03:18.834239  14:37:44 UTC) multi-call binary.

    2023-02-24T10:03:18.834359  =


    2023-02-24T10:03:18.839167  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-24T10:03:18.839254  =


    2023-02-24T10:03:18.844246  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-24T10:03:18.846469  FIRST, INC default to 1.

    2023-02-24T10:03:18.847234  =


    2023-02-24T10:03:18.850111  	-w	Pad to last with leading zeros

    2023-02-24T10:03:18.852956  	-s SEP	String separator
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63f88b840fad9a026c8c8697
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:03:18.796083  <8>[   31.845886] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-02-24T10:03:18.800766  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-24T10:03:18.800851  =


    2023-02-24T10:03:18.805809  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-24T10:03:18.808056  FIRST, INC default to 1.

    2023-02-24T10:03:18.808767  =


    2023-02-24T10:03:18.812353  	-w	Pad to last with leading zeros

    2023-02-24T10:03:18.814469  	-s SEP	String separator

    2023-02-24T10:03:18.817588  /lava-9314688/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63f88b840fad9a026c8c8698
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:03:18.785577  BusyBox v1.31.1 (2023-02-17 14:37:44 UTC) m=
ulti-call binary.

    2023-02-24T10:03:18.785669  =

   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88c772aff0d18d88c8746

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f88c772aff0d18d88c874f
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:07:36.859920  + set +x
    2023-02-24T10:07:36.863729  <8>[   17.113059] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 68789_1.5.2.4.1>
    2023-02-24T10:07:36.976938  / # #
    2023-02-24T10:07:37.080053  export SHELL=3D/bin/sh
    2023-02-24T10:07:37.080960  #
    2023-02-24T10:07:37.183488  / # export SHELL=3D/bin/sh. /lava-68789/env=
ironment
    2023-02-24T10:07:37.184320  =

    2023-02-24T10:07:37.286959  / # . /lava-68789/environment/lava-68789/bi=
n/lava-test-runner /lava-68789/1
    2023-02-24T10:07:37.288441  =

    2023-02-24T10:07:37.292580  / # /lava-68789/bin/lava-test-runner /lava-=
68789/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f893b8b343d291c88c8648

  Results:     5 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f893b8b343d291c88c8651
        failing since 39 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:38:20.387773  + set +x

    2023-02-24T10:38:20.394174  <8>[   17.403161] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9315293_1.5.2.3.1>

    2023-02-24T10:38:20.501625  =


    2023-02-24T10:38:20.603766  / # #export SHELL=3D/bin/sh

    2023-02-24T10:38:20.604644  =


    2023-02-24T10:38:20.706666  / # export SHELL=3D/bin/sh. /lava-9315293/e=
nvironment

    2023-02-24T10:38:20.707491  =


    2023-02-24T10:38:20.809601  / # . /lava-9315293/environment/lava-931529=
3/bin/lava-test-runner /lava-9315293/1

    2023-02-24T10:38:20.810961  =


    2023-02-24T10:38:20.813405  / # /lava-9315293/bin/lava-test-runner /lav=
a-9315293/1
 =

    ... (15 line(s) more)  =

 =20

