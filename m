Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C41EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 21:50:47 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.2861.1689889844889017287
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 14:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Q007qHfA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1b8bbce9980so8301075ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689889844; x=1690494644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GwIQxwuRkOtvadlBDatRirqFfvp963ap9C7cQu31Hkc=;
        b=Q007qHfAAbGhsn9oKuy+YfuMlYBB9/UImSBDWDfPelvUjF1Hpm4FyYGyZHGLzeaBDb
         eHWSW5OAW+5bzrx2fvoJ3c3PDDLtm0WUoZ+5a4M6cZJahzvZeOY5P4GDkHjcnWu+sXyO
         v6u4GtbR6/4AvUS0TyvmBmWl/S3xOjodf/JLzFin+zhspf9XQt9v9D7ksXPCjVfkvWP1
         5ukblalPdKWV3uPw2eN9/0IGmbK2f58yPPDjoi+e9n5BsRbCqs4hJFkgs/eku1H+M6D1
         jYiHUYdJ/KjcQp2lgaDY5ZdNTKUP/APR5kSLvrrTx1+KCR35f9oAKRlaAUyQ+2YC0wqk
         x8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889844; x=1690494644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwIQxwuRkOtvadlBDatRirqFfvp963ap9C7cQu31Hkc=;
        b=ifEmHV5VXiX3qKT7zS+HzOOYcNvIwSk91OO73pW7d4zk4Mzu8ZLj2qLnHPYjhDEFwA
         GDKfvb9SZ21WQWMdGyyuJ1FIHyI7eQbklhN+bT7FbAJrnc248fq2cwnugw9UAvG+O8K7
         jGB4E2EAsB7ToG4if4R/UVzOO68/ChvWlMlehZGXrdtP8FS6GccgjmUotWOlAp88gscI
         DY/9V64vP9grpFEgv3UK98rtvxlLqcSSeQnFn2Ti9+ai8DBSrkruYTum+qlrooiKT93Y
         mPALFhUrZLwLLimotZAV4r6RHprQaC6kZ+cn7apfNAWSJlCHrwqUs4EFDfN9dDaXe1uR
         0FSA==
X-Gm-Message-State: ABy/qLYym6bxwZ1psGhbLrSgdmtvkeFbxCEbAcJWD/8qdZnsir4edQd5
	Yd4Gc7pkjIonWoUEf0+9g3RAlNQO3FHY4NkiQQ4SSA==
X-Google-Smtp-Source: APBJJlH9F19rfL/jQagHlxY+buK3Hj7cxYaTBTCPWuIbt5S8CzC4ez5t2cjOolXpeGRTJXvVlzUd8Q==
X-Received: by 2002:a17:902:cec7:b0:1bb:3406:a612 with SMTP id d7-20020a170902cec700b001bb3406a612mr266376plg.57.1689889843449;
        Thu, 20 Jul 2023 14:50:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001ab18eaf90esm1879412plc.158.2023.07.20.14.50.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 14:50:42 -0700 (PDT)
Message-ID: <64b9ac32.170a0220.47b7f.3e21@mx.google.com>
Date: Thu, 20 Jul 2023 14:50:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-11-gafa55beeffce9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 13 runs,
 19 regressions (v5.10.186-cip37-11-gafa55beeffce9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 21:50:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12487

cip-gitlab/ci/pavel/linux-test baseline-nfs: 13 runs, 19 regressions (v5.10=
.186-cip37-11-gafa55beeffce9)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-11-gafa55beeffce9/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-11-gafa55beeffce9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      afa55beeffce969994d148ab3f2c8871b09e8945 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64b98a72d3a81aa9598ace1c

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b98=
a72d3a81aa9598ace1f
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:18.474550  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:26:18.541338  [   83.839598] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64b98a72d3a81aa9598ace20
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:17.335758  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:26:17.407586  [   82.704937] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64b98a72d3a81aa9598ace22
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:14.958422  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:26:15.026116  [   80.323479] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-20T19:26:16.088929  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:26:16.155997  [   81.452557] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64b98a72d3a81aa9598ace23
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:12.680307  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:26:12.752658  [   78.049566] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-20T19:26:13.816938  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:26:13.892009  [   79.188974] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64b98a72d3a81aa9598ace24
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:10.395437  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:26:10.470118  [   75.767321] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-20T19:26:11.533692  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:26:11.616595  [   76.913062] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64b98a72d3a81aa9598ace30
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:57.338591  /lava-4142/1/../bin/lava-test-case
    2023-07-20T19:25:57.412863  [   62.708546] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b98a72d3a81aa9598ace49
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:49.417402  + set +x
    2023-07-20T19:25:49.420923  [   54.718514] <LAVA_SIGNAL_ENDRUN 0_dmesg =
4142_1.6.2.4.1>
    2023-07-20T19:25:49.541101  / # #
    2023-07-20T19:25:49.644215  export SHELL=3D/bin/sh
    2023-07-20T19:25:49.645175  #
    2023-07-20T19:25:49.747350  / # export SHELL=3D/bin/sh. /lava-4142/envi=
ronment
    2023-07-20T19:25:49.748250  =

    2023-07-20T19:25:49.850418  / # . /lava-4142/environment/lava-4142/bin/=
lava-test-runner /lava-4142/1
    2023-07-20T19:25:49.851849  =

    2023-07-20T19:25:49.856495  / # /lava-4142/bin/lava-test-runner /lava-4=
142/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64b98a6525cadb99948ace1e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b98a6525cadb99948ace21
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:42.990287  + set +x
    2023-07-20T19:25:42.993529  [   46.936738] <LAVA_SIGNAL_ENDRUN 0_dmesg =
988054_1.6.2.4.1>
    2023-07-20T19:25:43.161613  #
    2023-07-20T19:25:43.264584  / # #export SHELL=3D/bin/sh
    2023-07-20T19:25:43.265283  =

    2023-07-20T19:25:43.367139  / # export SHELL=3D/bin/sh. /lava-988054/en=
vironment
    2023-07-20T19:25:43.367871  =

    2023-07-20T19:25:43.469776  / # . /lava-988054/environment/lava-988054/=
bin/lava-test-runner /lava-988054/1
    2023-07-20T19:25:43.470944  =

    2023-07-20T19:25:43.477874  / # /lava-988054/bin/lava-test-runner /lava=
-988054/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64b98a6525cadb99948ace3a
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:53.530066  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:25:53.718413  [   57.658939] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64b98a6525cadb99948ace46
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:08.751387  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:26:08.920232  [   72.863903] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-20T19:26:09.976515  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:26:10.154954  [   74.097352] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64b98a6525cadb99948ace47
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:11.216348  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:26:11.413869  [   75.356984] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-20T19:26:12.473052  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:26:12.647224  [   76.590693] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64b98a6525cadb99948ace48
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:13.710511  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:26:13.874129  [   77.817378] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-20T19:26:14.935502  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:26:15.114982  [   79.057443] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64b98a6525cadb99948ace4a
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:16.376111  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:26:16.574544  [   80.517720] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b98=
a6525cadb99948ace4b
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:26:17.630902  /lava-988054/1/../bin/lava-test-case
    2023-07-20T19:26:17.801885  [   81.746383] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b99540a96dbe53278ace2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b99540a96dbe532=
78ace2b
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9945224fba93b4a8ace53

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b9945224fba93b4a8ace58
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T20:08:42.859991  + [   18.255761] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 11120951_1.5.2.3.1>

    2023-07-20T20:08:42.863276  set +x

    2023-07-20T20:08:42.968437  / # #

    2023-07-20T20:08:43.070605  export SHELL=3D/bin/sh

    2023-07-20T20:08:43.071516  #

    2023-07-20T20:08:43.173126  / # export SHELL=3D/bin/sh. /lava-11120951/=
environment

    2023-07-20T20:08:43.173922  =


    2023-07-20T20:08:43.275698  / # . /lava-11120951/environment/lava-11120=
951/bin/lava-test-runner /lava-11120951/1

    2023-07-20T20:08:43.276903  =


    2023-07-20T20:08:43.281331  / # /lava-11120951/bin/lava-test-runner /la=
va-11120951/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9944ca1bb10b8578ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b9944ca1bb10b8578ace21
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T20:08:20.494957  + [   18.567809] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 11120953_1.5.2.3.1>

    2023-07-20T20:08:20.498528  set +x

    2023-07-20T20:08:20.602626  / # #

    2023-07-20T20:08:20.703169  export SHELL=3D/bin/sh

    2023-07-20T20:08:20.703323  #

    2023-07-20T20:08:20.803841  / # export SHELL=3D/bin/sh. /lava-11120953/=
environment

    2023-07-20T20:08:20.804020  =


    2023-07-20T20:08:20.904567  / # . /lava-11120953/environment/lava-11120=
953/bin/lava-test-runner /lava-11120953/1

    2023-07-20T20:08:20.904834  =


    2023-07-20T20:08:20.909597  / # /lava-11120953/bin/lava-test-runner /la=
va-11120953/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b995e02960490b078ace31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b995e02960490b0=
78ace32
        failing since 9 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.184-cip36-13-g8201543bbc8b6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b98c572c65ac52db8ace3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b98c572c65ac52d=
b8ace3f
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b) =

 =20

