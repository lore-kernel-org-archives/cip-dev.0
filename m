X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web12.6273.1647926448326701848
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wCQfhaTJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id p17so14522687plo.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rGOKkjsComktNqeEq0Zzz9e5rrAGIhjQreY6s6DvBVc=;
        b=wCQfhaTJEuD+ez/PnW9lGqkL+k8M7fP4PPXsOSdKdLXmpF7jwfTxlqdiMxY+q+7XtE
         e239XjNiuELDgbpkfavTrrtNfryYTh0wy1t6HamvHF8OXx1OerEfN9rm0uluh6z8K0S1
         utPkadgih6/Is+MhoyvhT4hJfUwXGuCI+cXzM/bD7E0ITR6oDupN2mEzGeQerGA6rlPT
         SpkY9QOlOrA2Rbo+5n9Ddax/QHMHmephrzmQDy6m5MKEC1A3a1vsvw0RF6CAncJad9QD
         PHEcjpkRIOCEa7m3sOoioUNQoH31d89K5qm+uXuxrVZUn3E3Ew1MBg+AY4FfdAI7gZFY
         HH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rGOKkjsComktNqeEq0Zzz9e5rrAGIhjQreY6s6DvBVc=;
        b=awCRlr9g5UhvV/UzodcOFR6oN+qL3vybAPIqc9PT2xURxBIqS4jSYZ0bEtkz6ZiYY3
         1NUeoyW6qPkjYWMWUHvfvce9fjNrT6/VIcsGlz1jpcx6vFRkwY9PHRysIyeYQLYdVg47
         QBYt0GLXDp7ukwCskfazg3ooizi/CxnoqlO7dxpUNcjQTeYE8V8ZNdBGoqpa3+9Z2zA+
         +sgo1FUgSu33MPPMedq+0FS2xdG8hXvcgOyrRPLWdJNf/4CkME679VLmRUFH6eIXPvlh
         dFOmSsKHR1gTDDaLEaDxlPC9zw6iKgglZnRhBgUVKmKXEQM0eDqd+TuDNeDn2ymGyeOi
         wDSQ==
X-Gm-Message-State: AOAM531Cr9y8WefiWrf4huUG5xE1K4V/4j/6+Gw4KlrFdbvy+HecXGP1
	//shGZhINpXHJb37avr4Xh3bIIhK/CBHKhqetMk=
X-Google-Smtp-Source: ABdhPJzEM5AfuLV2EdDOg/zHh5hZI7doqeJ5ARDGh/YCqHV7+VbojpCZur0P0n4N3ABf9ygFL4ha8w==
X-Received: by 2002:a17:90b:4c41:b0:1c7:3fa8:9b6a with SMTP id np1-20020a17090b4c4100b001c73fa89b6amr2906474pjb.120.1647926447574;
        Mon, 21 Mar 2022 22:20:47 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j14-20020a056a00174e00b004f66ce6367bsm24709538pfc.147.2022.03.21.22.20.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:20:47 -0700 (PDT)
Message-ID: <62395caf.1c69fb81.b2cbd.24a2@mx.google.com>
Date: Mon, 21 Mar 2022 22:20:47 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip68-128-g4031bdd82383
Subject: cip-gitlab/ci/pavel/linux-test baseline: 15 runs, 4 regressions (v4.4.302-cip68-128-g4031bdd82383) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 15 runs, 4 regressions (v4.4.302-c=
ip68-128-g4031bdd82383)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

meson8b-odroidc1          | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip68-128-g4031bdd82383/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-128-g4031bdd82383
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4031bdd8238386ea87c992b18bc65b684bddc2d7 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6239569c10a8013e852172bd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6239569c10a8013e85217=
2be
        failing since 7 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623956b410a8013e852172c6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/623956b410a8013e85217=
2c7
        failing since 7 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623959eec9e9327bcb2172dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/623959eec9e9327bcb217=
2dd
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
meson8b-odroidc1          | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6239555344ff9ab1732172e2

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/arm/multi_v7_defconfig/gcc-10/lab-baylibr=
e/baseline-meson8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/arm/multi_v7_defconfig/gcc-10/lab-baylibr=
e/baseline-meson8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6239555344ff9ab1732172e6
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225)

    2022-03-22T04:49:14.255226  /lava-1729605/1/../bin/lava-test-case
    2022-03-22T04:49:14.255891  [   17.312179] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2022-03-22T04:49:14.256130  /lava-1729605/1/../bin/lava-test-case
    2022-03-22T04:49:14.256347  [   17.329419] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>
    2022-03-22T04:49:14.256558  + set +x
    2022-03-22T04:49:14.256766  [   17.340546] <LAVA_SIGNAL_ENDRUN 1_bootrr=
 1729605_1.5.2.4.5>   =

 =20

