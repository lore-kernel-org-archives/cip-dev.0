X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web08.31100.1653329245156801897
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 23 May 2022 11:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=r6uBG4VA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id s14so13793775plk.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 23 May 2022 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KOTaE77P6thNyNFrCeloDU4QM29N7UIfEOWkP3K45KM=;
        b=r6uBG4VAlrA8lq1eMM1eNQO6mwoy0fnKeHgrWCMHN3Y4VUGoSG/KeaLpG0Nto+iUe4
         c+t7Iu6Rd1193aRVCgSfYk2sJ9meklfo5YTbsZ+RKzbxRpAW5JTysg3VbRj3uEOEgI/F
         p0qkRgY/bEqgGIyH1njq2DhFU6selE3QT83Gr+PAnotPXmHhBXfEVfGFgfCOhRrKGdmY
         4JbATDdRRVHHTYnw7QpqUqJ2l8K3BlsNzGJ4sdY7HlHASzVZLNaVEtqYoyF7eIUAcxpr
         QCEeO6AL5EXpBx/jQnZuaFrAkNGmATUtFgViQVNF8g1dFFdPKxIoVzU7sxbYMSxa/2dD
         lhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KOTaE77P6thNyNFrCeloDU4QM29N7UIfEOWkP3K45KM=;
        b=6LTWENN58Mm49nYOpNf7ZaWBm167nc34xo28ZGmxRwEiiJmZ601wSL1D03bg56LQWV
         gix7tNPqXNW45iFwkvwTArZlWltWuM1N9jtG/2JuFmGIz+JStN98mJHzKu3o59JdnNYj
         sC02sVrwQirhq5XhrdnVKA6yhsGKh4qMI+iJbc7WhTcS4ozD/7jr6jeN3qMtR8Htagy3
         kihXs7/A/Q4Oohf7Bah5/YKo7sD8HyzwmKruI8XbFOqQg6gZZkU4G8u2QGG1CtYzIK9f
         5Djs3jMQmxonCM0qopO2hwFMu60n36u9AF11go17IHGBcqaERyzwTRTcKHGJ+ysiQl0c
         XMFA==
X-Gm-Message-State: AOAM531t1ONI3/2G08N+Iz+J3/WX2op83/EUzfiSo05PXcC5iaUvUAlW
	KMP1iVqNGYqdEB2VyjI7MkOvXBf7uISkWwiOXYc=
X-Google-Smtp-Source: ABdhPJwGO4ubKBKuNbrcLX7JicPkA6c5Su+dLNuCzHpyhGW4eUh8d9X5LYiUqfTAZ/Bx+zGRS4QkGw==
X-Received: by 2002:a17:90a:af8a:b0:1df:9f11:dbc7 with SMTP id w10-20020a17090aaf8a00b001df9f11dbc7mr205520pjq.233.1653329244519;
        Mon, 23 May 2022 11:07:24 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q102-20020a17090a1b6f00b001dfffd861cbsm1803pjq.21.2022.05.23.11.07.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:07:24 -0700 (PDT)
Message-ID: <628bcd5c.1c69fb81.2bb00.001e@mx.google.com>
Date: Mon, 23 May 2022 11:07:24 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-1797-gb2b8419761095
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 5 regressions (v4.4-st5-1797-gb2b8419761095) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 5 regressions (v4.4-st5-179=
7-gb2b8419761095)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1797-gb2b8419761095/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1797-gb2b8419761095
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2b8419761095643d782c4cb4a982131b3efb6b8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17e9ae697a340242c49188ace12a60cd3bc95a53 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbaaa1d6e395e9ea39be9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/628bbaaa1d6e395e9ea39b=
ea
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bba0897ad5e33eca39c1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/628bba0897ad5e33eca39c=
1e
        new failure (last pass: v4.4.302-cip69-296-g52de9431d314) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bb6f7d93e8a62e2a39bf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/628bb6f7d93e8a62e2a39b=
f6
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbcfbd119219331a39bf0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/628bbcfbd119219331a39b=
f1
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bcacd50bb335548a39be6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/628bcacd50bb335548a39b=
e7
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

