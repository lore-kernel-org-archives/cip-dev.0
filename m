Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8824C41513
	for <webhook@archiver.kernel.org>; Sat, 22 Jul 2023 15:24:28 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.7588.1690039464807904748
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 22 Jul 2023 08:24:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=fEvgEF16;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1b852785a65so19887155ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 22 Jul 2023 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690039463; x=1690644263;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IQNHVLTiQhDnNOGbIad8r0yd2TQYRvjaoHEawvC8JoU=;
        b=fEvgEF16SAO4lNCa4t3h5CMT+BoFZ71T2HAKNY8Vex8rgTWghoQ/uRzPGGwgDJHJQ3
         qKBr1hT3pgv5HtB36StwKGF7Ot9kZQJc8LGnFVurCbKTePQSB8grFdkRCLM3zdrXdfjV
         YRAuJL9KBpV3R3ctHm0VXCLXsbzYG0KZYfiZvglsFgMx3ewy1kSSfHC1/CRFR8jtFHPe
         PFBFaFAOnu04pwiVDTILsauJC2N5UyleB6pQEnZiFMMNMYOC/RJ+9ttH604+M0hTwtYk
         uxtaxAEok7DmY+y6dIzkpNn6SIw9D3DK5iFmwiM2RJecq6sY8DPynfeJFC3CzpJW6avs
         NDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690039463; x=1690644263;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQNHVLTiQhDnNOGbIad8r0yd2TQYRvjaoHEawvC8JoU=;
        b=Iee3oBwsoNProHg5djpbIwwuOKAvqW/H7j6Ex7XKlJK5oHOvNUXQ7hJiVJTbxjyAVe
         9LKnU+ybCBM7VIMOOiKo2VPXSA9N7f11V5w+3qq7Cfw8h0XP9eTzu+Ir/G0eNnFedWHh
         vEDWhw6oCNu+xfAeU6wZQr8mZ+wbJVmlhu59D/wV49llNdEiOjQGBPEx784SNyq9tBrr
         szV7yOLMgMT1cHdw9gKzps8SH0xKsq7w2vem4AJkJdkRroS3V1glbMiNy5kXfJIrIBLu
         mBc2RqRFm8CmC/IcqBTdGjhVsuaBPNGzed8FVpXz32AJlv5vKbigv1gsAVkclQPhGaw8
         0G2w==
X-Gm-Message-State: ABy/qLbtsIm5m946ablkl9UY1n2+v0/li/pQAkzpkKvImLPLIrly9ygY
	PQd2FC3jXx3g/f7FLPp8sEzXFewtrejDtwk84V8=
X-Google-Smtp-Source: APBJJlHTCpM4Nktsd+1oDkxA+2ghb+C5j9TDVnXf6kpfQRNDTGN2DyTyYHOPiQdvr15HBkMFEH2gbw==
X-Received: by 2002:a17:902:a515:b0:1b7:de50:7d9c with SMTP id s21-20020a170902a51500b001b7de507d9cmr5824893plq.15.1690039463237;
        Sat, 22 Jul 2023 08:24:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b001ac95be5081sm5484980ple.307.2023.07.22.08.24.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 08:24:22 -0700 (PDT)
Message-ID: <64bbf4a6.170a0220.a6a4c.a264@mx.google.com>
Date: Sat, 22 Jul 2023 08:24:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-12-g2710acbceb75
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 31 runs,
 8 regressions (v5.10.186-cip37-12-g2710acbceb75)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Jul 2023 15:24:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12496

cip-gitlab/ci/pavel/linux-test baseline: 31 runs, 8 regressions (v5.10.186-=
cip37-12-g2710acbceb75)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 3          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-12-g2710acbceb75/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-12-g2710acbceb75
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2710acbceb751c864f5fbbd3521374e60d9802fe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bbe46395a5db906c8ace20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64bbe46395a5db906c8ac=
e21
        failing since 3 days (last pass: v6.1.38-cip1-10-g02aa22be941dd, fi=
rst fail: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 3          =


  Details:     https://kernelci.org/test/plan/id/64bbd5cde370ea189a8ace1c

  Results:     46 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/arm/at91_dt_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/arm/at91_dt_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/64b=
bd5cde370ea189a8ace21
        failing since 1 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-22T13:12:22.648773  /lava-5539/1/../bin/lava-test-case
    2023-07-22T13:12:22.686817  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/64bbd5cde370ea189a8ace2c
        failing since 1 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-22T13:12:18.445825  /lava-5539/1/../bin/lava-test-case
    2023-07-22T13:12:18.484329  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-07-22T13:12:18.526951  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-07-22T13:12:19.547348  /lava-5539/1/../bin/lava-test-case
    2023-07-22T13:12:19.586600  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
64bbd5cde370ea189a8ace2d
        failing since 1 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-22T13:12:17.352090  /lava-5539/1/../bin/lava-test-case
    2023-07-22T13:12:17.390986  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64bbd8c56fd3b808588ace1c

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/arm/multi_v5_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/arm/multi_v5_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/64b=
bd8c56fd3b808588ace21
        failing since 1 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-22T13:25:04.980522  /lava-5540/1/../bin/lava-test-case
    2023-07-22T13:25:05.018767  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64bbd3c08617f438ec8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/arm/bcm2835_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/arm/bcm2835_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bbd3c08617f438ec8ace21
        failing since 3 days (last pass: v5.10.184-cip36-13-g8201543bbc8b6,=
 first fail: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-22T13:05:21.539598  / # #

    2023-07-22T13:05:21.641600  export SHELL=3D/bin/sh

    2023-07-22T13:05:21.642291  #

    2023-07-22T13:05:21.743689  / # export SHELL=3D/bin/sh. /lava-11125231/=
environment

    2023-07-22T13:05:21.744380  =


    2023-07-22T13:05:21.845794  / # . /lava-11125231/environment/lava-11125=
231/bin/lava-test-runner /lava-11125231/1

    2023-07-22T13:05:21.846854  =


    2023-07-22T13:05:21.889471  / # /lava-11125231/bin/lava-test-runner /la=
va-11125231/1

    2023-07-22T13:05:21.928166  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-22T13:05:21.972072  + cd /lava-11125231/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bbe386ebe5f3f1898ace38

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bbe386ebe5f3f1898ace3d
        failing since 38 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-22T14:11:07.384028  + set +x

    2023-07-22T14:11:07.391270  <8>[   10.525598] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11125260_1.4.2.3.1>

    2023-07-22T14:11:07.499491  / # #

    2023-07-22T14:11:07.602036  export SHELL=3D/bin/sh

    2023-07-22T14:11:07.602892  #

    2023-07-22T14:11:07.704517  / # export SHELL=3D/bin/sh. /lava-11125260/=
environment

    2023-07-22T14:11:07.705386  =


    2023-07-22T14:11:07.807102  / # . /lava-11125260/environment/lava-11125=
260/bin/lava-test-runner /lava-11125260/1

    2023-07-22T14:11:07.808532  =


    2023-07-22T14:11:07.813727  / # /lava-11125260/bin/lava-test-runner /la=
va-11125260/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bbe37ba549302cdd8ace60

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bbe37ba549302cdd8ace65
        failing since 38 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-22T14:10:53.414615  + set +x<8>[   13.057344] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11125290_1.4.2.3.1>

    2023-07-22T14:10:53.414696  =


    2023-07-22T14:10:53.516292  #

    2023-07-22T14:10:53.617006  / # #export SHELL=3D/bin/sh

    2023-07-22T14:10:53.617170  =


    2023-07-22T14:10:53.717838  / # export SHELL=3D/bin/sh. /lava-11125290/=
environment

    2023-07-22T14:10:53.718041  =


    2023-07-22T14:10:53.818674  / # . /lava-11125290/environment/lava-11125=
290/bin/lava-test-runner /lava-11125290/1

    2023-07-22T14:10:53.820003  =


    2023-07-22T14:10:53.825256  / # /lava-11125290/bin/lava-test-runner /la=
va-11125290/1
 =

    ... (12 line(s) more)  =

 =20

