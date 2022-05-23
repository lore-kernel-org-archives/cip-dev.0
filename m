X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.30373.1653327442530599857
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 23 May 2022 10:37:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=GeVtR3Of;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id z11so4856290pjc.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 23 May 2022 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=d9eX16TbQ5MLTP+bYOfZw/RoQFCcPFNHlTHCbDESYxE=;
        b=GeVtR3OfIxL9wAhGUqcNlY2HoagXuKMteX0Hp+tYYNu/g5r0kdBQqGiCUkxX3zhkzA
         CdHpznhT/a1SX8rOa+KKyUDQVafBNfrhboFA3yPiS2Jj8ZtNlZK413ZDy2f0vF9JtKt3
         4EdPoAyeYmuuo+Exr4t2DpF/VBUUn9SzwU9iBD7v+p5jWCo7VJGOHUgyQr5+ovlwHj6G
         LSurlGagBzsQp6gTxXclOjAdR95JBqB+HZjf9eRcMVGDaHQNDuN1tl6hrPXaIktNfiof
         jLbvFDYVMkk1+5tjcszlI1E+qimD9oLxw2ZeNJ8OcpVrO74NAdBH+C7k2iNBSKG6YvAJ
         lfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=d9eX16TbQ5MLTP+bYOfZw/RoQFCcPFNHlTHCbDESYxE=;
        b=AJNYqQ6BFQKE/nWFkjuJWmoa58E2Wy/6x+HFuXjaCvp/+LWbWSzMTscXO9i8RB6mNu
         1N2A/K6dy4LTXkmVh7sajyGonGslGCydkgW7I6POrLkzS3wv/upb+YimScHx+hqCcuPy
         2Fao2Okw8rbrV0DNY95NZBeoKgewQKSEKwvX1GSZOrqtsT+EI26BaDH0AAJkYaVfaTFJ
         9Nm2yBqkDQccJaDQk45WPbORSSynLOnhcC7CyC7pVI7sBx9kbAQ2sMDPzEGiilQcv7yn
         H0pY3O7c/CuvrvqPBcRqsL8TFBtbrtKbEnPhz1wh4auHAYDzKWMU7/SLmgWl4fvuCGcq
         decQ==
X-Gm-Message-State: AOAM531Uqg1UC8708Su+h+E/frCHUSFfrYawBqk3uXU296hURfa2hIJx
	Zqz3KD75Edw1DExioox9kJibeCEkFcXy7lS7K1Q=
X-Google-Smtp-Source: ABdhPJw4ONQl6VC1pHGJK/x5dutE3Wz9/a14X5x7/i9PQ7CYmv61o6ivNCQgYfqF1dlpq791LTFVVA==
X-Received: by 2002:a17:902:ebd1:b0:162:224f:abbb with SMTP id p17-20020a170902ebd100b00162224fabbbmr6524328plg.160.1653327441708;
        Mon, 23 May 2022 10:37:21 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902c40e00b0015e8d4eb27esm5526790plk.200.2022.05.23.10.37.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:37:21 -0700 (PDT)
Message-ID: <628bc651.1c69fb81.1c2fb.cb8a@mx.google.com>
Date: Mon, 23 May 2022 10:37:21 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-1797-gb2b8419761095
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 17 runs, 12 regressions (v4.4-st5-1797-gb2b8419761095) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 17 runs, 12 regressions (v4.4-=
st5-1797-gb2b8419761095)

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

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1797-gb2b8419761095/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1797-gb2b8419761095
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2b8419761095643d782c4cb4a982131b3efb6b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bb61469f70a531da39c4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628bb61469f70a531=
da39c4d
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbab31d6e395e9ea39bf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628bbab31d6e395e9=
ea39bf6
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bba9659e98be588a39bd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628bba9659e98be58=
8a39bd9
        failing since 7 days (last pass: v4.4.302-cip69-50-gba851b77071ca, =
first fail: v4.4-st5-208-g5e70bc68d09e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bb6e39fd4928edba39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628bb6e39fd4928ed=
ba39bed
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbac64dbac7278fa39be6

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/628bbac64dba=
c7278fa39bed
        failing since 13 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-23T16:47:34.689968  / # =

    2022-05-23T16:47:34.696947  =

    2022-05-23T16:47:39.711848  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/164492/extract-nfsrootfs-v9ukoutf'
    2022-05-23T16:47:39.722830  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/164492/extract-nfsrootfs-v9ukoutf'
    2022-05-23T16:47:42.013896  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-23T16:47:42.024922  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-23T16:47:42.130154  / # #
    2022-05-23T16:47:42.137139  #
    2022-05-23T16:47:42.239703  / # export SHELL=3D/bin/sh
    2022-05-23T16:47:42.246560  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/628bb714ae6f4722d8a39c4c

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/628bb714ae6f=
4722d8a39c51
        failing since 13 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-23T16:32:01.592647  / # =

    2022-05-23T16:32:01.594948  =

    2022-05-23T16:32:06.604425  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/684349/extract-nfsrootfs-daamjuva'
    2022-05-23T16:32:06.615117  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/684349/extract-nfsrootfs-daamjuva'
    2022-05-23T16:32:08.781652  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-23T16:32:08.792359  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-23T16:32:08.895716  / # #
    2022-05-23T16:32:08.898065  #
    2022-05-23T16:32:09.001186  / # export SHELL=3D/bin/sh
    2022-05-23T16:32:09.003526  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbb660d18c63212a39c15

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/628bbb660d18=
c63212a39c1c
        failing since 13 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-23T16:50:31.102685  / # =

    2022-05-23T16:50:31.108772  =

    2022-05-23T16:50:36.128670  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/164529/extract-nfsrootfs-rib_tfqf'
    2022-05-23T16:50:36.139220  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/164529/extract-nfsrootfs-rib_tfqf'
    2022-05-23T16:50:38.432692  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-23T16:50:38.443168  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-23T16:50:38.551656  / # #
    2022-05-23T16:50:38.556518  #
    2022-05-23T16:50:38.669014  / # export SHELL=3D/bin/sh
    2022-05-23T16:50:38.673875  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/628bb7b526df67dab5a39beb

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/628bb7b526df=
67dab5a39bf0
        failing since 13 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-23T16:34:29.883179  / # =

    2022-05-23T16:34:29.886097  =

    2022-05-23T16:34:34.897917  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/684351/extract-nfsrootfs-adlar4px'
    2022-05-23T16:34:34.908607  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/684351/extract-nfsrootfs-adlar4px'
    2022-05-23T16:34:37.082000  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-23T16:34:37.092673  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-23T16:34:37.199395  / # #
    2022-05-23T16:34:37.202135  #
    2022-05-23T16:34:37.314911  / # export SHELL=3D/bin/sh
    2022-05-23T16:34:37.317526  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbc3b4ebb5b75d5a39be7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628bbc3b4ebb5b75d=
5a39be8
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bc5fc94a300d272a39c3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628bc5fc94a300d27=
2a39c3b
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbdd3ffeaa1a8e8a39bde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628bbdd3ffeaa1a8e=
8a39bdf
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbec336f96dbd7ba39c04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628bbec336f96dbd7=
ba39c05
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-261-g4f0b5ddda6cf) =

 =20

