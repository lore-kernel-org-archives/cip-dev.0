Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A7C77B76
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:30:19 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.11405.1682004613487026309
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:30:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ponxipB4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1a6f0d8cdfeso10794895ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682004613; x=1684596613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7yWm9CzhPYUuveFvTNOnxRUUxoeUNM7kPKJJcsBF6D8=;
        b=ponxipB4G39ZJDdS3PvPl3tQ8LQvQjnF6ffXIkP7Q1NNhpJKdx6gqd+3mXK+on4JWj
         cOYUeh356vm/t27hXQcK/38E8Sx+6OeCVD+PkAXV5gVZtVsGj4mzR+Wy4sb9brzvWAej
         9NF3G41q87R3Ai2bbXDPzBND1g5HwBZPeSZILjhbtLrO5A3C1RncZ7Q2dpmobQIaoMC3
         9MzLO7tvYL1epEnpndrg0xb3VPpbWHghoHafVorUo2LfwzAWyHge557l5VZTAyJhKKOQ
         iHCU9iVaVtbNj3sebLAGLT3KxcEp/gRMQEZfdVwqQDHHX4UvJCpYf7chJbL2+hHdFzsy
         xJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004613; x=1684596613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yWm9CzhPYUuveFvTNOnxRUUxoeUNM7kPKJJcsBF6D8=;
        b=VzXS5S6u3tMGXPhYtcZCMpF3zbVXrGLR2ZpmL+N4MXmsOKb8PYqoIVWg+5O+lZjf2O
         dJIQHpY4Y51PrjfwB1lv4u/NxPhjUB85mF/+fRY4DY6mgdz2JCBq8xcBARBG4i0TOz7v
         liWdSVDCvxz5+c8vFak1jqS+eeGajDiHQg14B3n/yRvMwrHa33b9ksWwlHbi/6BPhZAq
         ddrSaCQ8ULr604qyl6MG2C9ZBD8PvMQEBfZtjAcls8kqztQOF/R64xKuYkn/qFxy1SOd
         t4UjI5nCIo6SGUzrBkdlKAz00Sxrp4dAfj30/66uYr8sHUlRNZz3neFeVsGEo+PcZJvR
         CJkQ==
X-Gm-Message-State: AAQBX9eBZ0DxI9xKfAIF9PaIGTOAqpeVUqMHF2qDKcM/q1WCDTi7BjT2
	hw5RFOKihl3PPLSXMfqGTKMvm0wZbTIXhN1DHZj0BsNu
X-Google-Smtp-Source: AKy350Z4oorHggY4b4049obP7pQxarECkXbFe/iz3BGX2T0WvE8e5SxqwMlTG5FGrcmXBdQsAXRUbQ==
X-Received: by 2002:a17:903:189:b0:1a2:86c6:7b66 with SMTP id z9-20020a170903018900b001a286c67b66mr1999010plg.4.1682004612737;
        Thu, 20 Apr 2023 08:30:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902900900b001a514d75d16sm1323604plp.13.2023.04.20.08.30.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:30:12 -0700 (PDT)
Message-ID: <64415a84.170a0220.41219.2a9d@mx.google.com>
Date: Thu, 20 Apr 2023 08:30:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1099-g7b2580e1565dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs,
 5 regressions (v4.4-st20-1099-g7b2580e1565dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11253

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs, 5 regressions=
 (v4.4-st20-1099-g7b2580e1565dd)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1099-g7b2580e1565dd/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1099-g7b2580e1565dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2580e1565ddf95b5123aaa9a1f4c33e354e397 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414dc6cb8cae7e8a2e8620

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64414dc6=
cb8cae7e8a2e8621
        failing since 29 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414debcb8cae7e8a2e8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64414deb=
cb8cae7e8a2e8631
        new failure (last pass: v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414f171776ee60ce2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64414f17=
1776ee60ce2e85e7
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414f2b46030dc1172e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64414f2b=
46030dc1172e85e7
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64414dc97eb1f92fbf2e8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
kselftest-filesystems-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
kselftest-filesystems-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64414dc9=
7eb1f92fbf2e8645
        new failure (last pass: v4.4.302-cip74-rt43) =

 =20

