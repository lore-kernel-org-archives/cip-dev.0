X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web12.7241.1647499442168942714
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 23:44:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zoiCl17e;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id c11so1960450pgu.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cP6K1qmUIXWxduKqKxnRa7bZfGLRZfbsGz+MVU0dLSg=;
        b=zoiCl17e0rs42idDAYUI8FSsBQ3MJDh1lWX0Y1TbfiJvXN/yEB4ciT19kXJ6XQ6+XQ
         FgGOtJAf9FIhYes971yf36GyQQn7l/9Qzqi64WO6sp3RGauBLregy2LG3MV/bPxKyuhC
         jqH5CpgY3W6oGrMHNlEGzeiLXQPPbT4vrqQ3Iyty6IbM6mM1Lif9WjRD6N0jrfKlPFD8
         f1qSXLUiOJwSXXsyhUhGOJqX/TZkjvf61LeBTmvVVY1Olhep16y0rualR0DfDkk+kzPj
         nqBco7zJkqw6/0d5aODAaC7pQFtQ2NjF1PJ687PLaP6ek9p7n7M3WbV+qnSlbfuUhTuM
         o/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cP6K1qmUIXWxduKqKxnRa7bZfGLRZfbsGz+MVU0dLSg=;
        b=PKbOUVLr16E7cKiWXQMfZF0/WTo34ufOmamApEhWXF4JinelH2jogEQlcVL31jssO+
         xmQubkSRFkpZ+qpmqOAVuUHoWLeNd5In2gAlsGm3qSOqgpxxMojK38TsGNH3xc17WVKH
         MTYNGopLqnDq/KCAkanLqiS7BMv5kaJRUXU5xc3DQr/b5Ivear/Q8QjY+4zAYYIjuc9s
         4rQK2a52WTLRHohe2dhLvsWPj/bazpxwHoxJX/PNqeZmYu9bM/y7aabDXBHzxoCsBDXW
         pnx1rumNTxEDxLtKzttsNbLYnbq92EVp6sesVZPlERTuoy7jevmbK/8S5+LygDjjPzzl
         jxnw==
X-Gm-Message-State: AOAM531Ix9EXDYS2JJDGmeeQc3/3Hp8BUYIJwUWkO/dDKSSN2shbHjL2
	w8SQZULjSN4Ol7IjfxpnoG21KVPnRTzzNTnWXrs=
X-Google-Smtp-Source: ABdhPJzmd1qi0T+IH9vZt+9tTLBGO+Onx+oiZgwzkdHlVQR1Zs1dFPQLyUHclDNgzT4FFZfnPLqAyQ==
X-Received: by 2002:a63:4f48:0:b0:378:a293:11f3 with SMTP id p8-20020a634f48000000b00378a29311f3mr2539933pgl.99.1647499441206;
        Wed, 16 Mar 2022 23:44:01 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm5756684pfw.188.2022.03.16.23.44.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 23:44:00 -0700 (PDT)
Message-ID: <6232d8b0.1c69fb81.52780.fb18@mx.google.com>
Date: Wed, 16 Mar 2022 23:44:00 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip68-19-gcfdd1ea3a7ba
Subject: cip-gitlab/ci/pavel/linux-test baseline: 24 runs, 11 regressions (v4.4.302-cip68-19-gcfdd1ea3a7ba) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 24 runs, 11 regressions (v4.4.302-=
cip68-19-gcfdd1ea3a7ba)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

beagle-xm                  | arm    | lab-baylibre  | gcc-10   | omap2plus_=
defconfig          | 2          =

meson8b-odroidc1           | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip68-19-gcfdd1ea3a7ba/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-19-gcfdd1ea3a7ba
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cfdd1ea3a7bab80ea3e513f28e7aa423fedf5d61 =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d133e44c15ba51b7391d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6232d133e44c15ba51b73=
91e
        failing since 2 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d0d37953c5873cb739a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6232d0d37953c5873cb73=
9a8
        failing since 2 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beagle-xm                  | arm    | lab-baylibre  | gcc-10   | omap2plus_=
defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/6232d5f1e0ebfe8ff7b73957

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/omap2plus_defconfig/gcc-10/lab-baylibr=
e/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/omap2plus_defconfig/gcc-10/lab-baylibr=
e/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6232d5f1e0ebfe8f=
f7b7395e
        new failure (last pass: v4.4.302-18-ga78419826225)
        1 lines

    2022-03-17T06:32:05.962435  / #
    2022-03-17T06:32:05.963031   #
    2022-03-17T06:32:06.066165  / # #
    2022-03-17T06:32:06.066754  =

    2022-03-17T06:32:06.168056  / # #export SHELL=3D/bin/sh
    2022-03-17T06:32:06.168472  =

    2022-03-17T06:32:06.269654  / # export SHELL=3D/bin/sh. /lava-1712706/e=
nvironment
    2022-03-17T06:32:06.270088  =

    2022-03-17T06:32:06.371231  / # . /lava-1712706/environment/lava-171270=
6/bin/lava-test-runner /lava-1712706/0
    2022-03-17T06:32:06.372289   =

    ... (10 line(s) more)  =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6232d5f1e0ebfe8=
ff7b73960
        new failure (last pass: v4.4.302-18-ga78419826225)
        29 lines

    2022-03-17T06:32:06.835249  [   49.892852] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2022-03-17T06:32:06.899338  kern  :emerg : Internal error: Oops - BUG: =
0 [#1] SMP ARM
    2022-03-17T06:32:06.905130  kern  :emerg : Process udevd (pid: 109, sta=
ck limit =3D 0xcbfc0218)
    2022-03-17T06:32:06.909666  kern  :emerg : Stack: (0xcbfc1cf8 to 0xcbfc=
2000)
    2022-03-17T06:32:06.918727  kern  :emerg : 1ce0:                       =
                                bf02bdc4 60000013
    2022-03-17T06:32:06.931248  kern  :emerg : 1d00: bf02bdc8 c06a55bc 0000=
0001 00[   49.984893] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Df=
ail UNITS=3Dlines MEASUREMENT=3D29>   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
meson8b-odroidc1           | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6232cf64983c1efbe0b73929

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-meson8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-meson8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6232cf64983c1efbe0b7392d
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225)

    2022-03-17T06:04:08.423988  /lava-1712644/1/../bin/lava-test-case
    2022-03-17T06:04:08.424600  [   17.312081] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2022-03-17T06:04:08.424844  /lava-1712644/1/../bin/lava-test-case
    2022-03-17T06:04:08.425068  [   17.329264] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>
    2022-03-17T06:04:08.425284  + set +x
    2022-03-17T06:04:08.425498  [   17.340484] <LAVA_SIGNAL_ENDRUN 1_bootrr=
 1712644_1.5.2.4.5>   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d7474f3f762c41b73927

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6232d7474f3f762c41b73=
928
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d8108d7a173f71b7391e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6232d8108d7a173f71b73=
91f
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d7c06527933676b7393e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6232d7c06527933676b73=
93f
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d823f4fe2fd539b739a4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm/multi_v7_defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6232d823f4fe2fd539b73=
9a5
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d7718a993fe3fbb73932

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6232d7718a993fe3fbb73=
933
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d76fb9e1904249b73929

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6232d76fb9e1904249b73=
92a
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =20

