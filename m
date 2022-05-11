X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web09.11485.1652276376494094600
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 06:39:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1q+gpsK0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id c9so1934939plh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8A+hzF7FYI26bm8HWyYvc4y0JGv62hojkY3h8wXOtkk=;
        b=1q+gpsK082UF8HXO3np+updD4SQ1INPABg+ugfo0iEj6JVS4xATrvKnZuZW9sagczx
         pjGsJ5FeTxbj1IJQL9O2MgtxU9lDnPXZ/BtYsjDBAREeRes5jgXL4L+ZiAYq32OOEGPt
         vdHm4GnTi8JYD0iGraRYMYoW1ZJilgA4vOuzirWEfSmgyyaFZEoYCtQHUV5WVYet/ZlW
         5tL6ijYtqdpsKsWhz4Ap8iAHGLpLQP72eXipie/Al1lsmdC39ifD7ghbpReDFGkODfNS
         As/qYRCQSLMMl7w1EJdNLznP0n7lq9niiS6Mf9XhtY8TWPEDxCTh+2PM2pU2A4+sNKFB
         J4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8A+hzF7FYI26bm8HWyYvc4y0JGv62hojkY3h8wXOtkk=;
        b=v6KND7eUey/7JcIve0lmxlr+PC+TEiXCpmh0JVik7Xy6GsfvMTesf0C/xiAzuamFLk
         BJVuXFUgx7sqARW02kfMErx6ErQKrkb8xmHOHgwD48ig/pLfXGbbirI6n00f8KPWreNE
         xYQt0FoPkXv7tjwdoH81fjFLoY1hnmHiwBqzJZAC8vMFUVkm55Euhg2Eav9u6/8kiTN/
         7+R0HUcak35bX35cKMBn36rgNYcSclB4YBxn/ToCJG+nGpawAkgAWa+VMwGQu2oO0OuX
         E2Mebm3DjThWLgVZSh4AOE8BFLr1SJX4S9KTlaMdwxEAsaSFxD37iIid0nB2XsxI1gBI
         HwXw==
X-Gm-Message-State: AOAM5316X8CH4CSUdLFD84Bk7B3XN8tjgJFp3AeQymTIlCr5Xe/xNAiT
	SlEzQd1xSj9sDt2oQhdv4sP7DnSJEknTkA5C3tw=
X-Google-Smtp-Source: ABdhPJyTtjheWfBC7wdPvf8lV/UCqHlMopA6OPvk7Z/qt1MEHssTeslouPwbsxx8ipkR6bq8tanhTA==
X-Received: by 2002:a17:903:2341:b0:15e:bc62:bdb4 with SMTP id c1-20020a170903234100b0015ebc62bdb4mr25140946plh.167.1652276375667;
        Wed, 11 May 2022 06:39:35 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a63d406000000b003c14af5063esm1725884pgh.86.2022.05.11.06.39.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:39:35 -0700 (PDT)
Message-ID: <627bbc97.1c69fb81.1c983.38ea@mx.google.com>
Date: Wed, 11 May 2022 06:39:35 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-17-g04a3c17cb526f
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 12 runs, 7 regressions (v4.4-st5-17-g04a3c17cb526f) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 12 runs, 7 regressions (v4.4-s=
t5-17-g04a3c17cb526f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-17-g04a3c17cb526f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-17-g04a3c17cb526f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      04a3c17cb526ff31d466407f119fa9692b4cee08 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb65f3a735f19658f57b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627bb65f3a735f196=
58f57b1
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bbabde6ceaca5c98f572b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627bbabde6ceaca5c=
98f572c
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bbb1741b52330168f572d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627bbb1741b523301=
68f572e
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb5f635191c2d468f5759

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627bb5f635191c2d4=
68f575a
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb6405fe608c6bf8f5732

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627bb6405fe6=
08c6bf8f5737
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T13:12:12.349621  / # =

    2022-05-11T13:12:12.351911  =

    2022-05-11T13:12:17.361299  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677774/extract-nfsrootfs-987d0xwk'
    2022-05-11T13:12:17.371980  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677774/extract-nfsrootfs-987d0xwk'
    2022-05-11T13:12:19.538492  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-11T13:12:19.549188  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-11T13:12:19.652576  / # #
    2022-05-11T13:12:19.655014  #
    2022-05-11T13:12:19.758110  / # export SHELL=3D/bin/sh
    2022-05-11T13:12:19.760356  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb99305225400e68f5739

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627bb99305225400e=
68f573a
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bbbdafd4468fb398f573b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627bbbdafd4468fb3=
98f573c
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

