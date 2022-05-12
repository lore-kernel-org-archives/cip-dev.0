X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.2102.1652347149304154426
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 02:19:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gJmBFNRc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id i24so4254028pfa.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nSv1Phqg93k9NNvIpe7A+Kp5sw1kPbnbwSUqdfYG6iM=;
        b=gJmBFNRcOfEBkBLopEWsbx6TgjgHtm/Y/uJp2o30Fi3wJxNrHK5zBDDICj3Ipo/xqm
         L7QH56mFIwOZ3K098yCRtA21DX4wiSrZs1rX40qjtRx7kWCHytJKZbNmAx44vVpC6PzG
         7+eT7voVVnSSxm8q6y3Qd5SWePmPhSlNp5dtApd4pkM7PeM2A++bNAm1iKP1fy0/R+Zj
         r6H1kHvF81n2fP9IER3VN6vznb5nZlicZbflrIRc3cTkXXcCjyk4IZHSfW/VgrJyvDEy
         VhZ9px4kAusEpEB5OZyGtfUu1jgnwiHQDaJxnVuZINWAenm1IErkYxOVQfW6EaxUi10i
         z7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nSv1Phqg93k9NNvIpe7A+Kp5sw1kPbnbwSUqdfYG6iM=;
        b=n0sa9NVdkF/wzf4irp62N02z/J32cldOgLau1weGqiXK28+/xgNVaYkC2ijRbbph9n
         6CE7ln/QGbNh9RnUNBCdhX7wcuquEbMVO3s9UfQFD9/enTKC/VEPaFziTkotO7JdXdjQ
         cWklB+bkRdp3hrsZc7rhaYihLc/A+PX3gvbMufJp2lKfEuZBv5U9uE/yero9VKc4TJFz
         h7PnDjgaYnU1KEtoxdya6sx9bNjVkDhBHFK3EJIXcj41A1hh5IxyOhXZPOGc9okHGTlF
         e3Ldtj+1yUc6Fz0QNt5ySpbimm29VGi4fv+SdtsNs7o2mDV2Vjn6+Andv78dAbOE3Txj
         R6yA==
X-Gm-Message-State: AOAM532YwOTR4zQXs3W9ZORZIt6+ZuaixnNOL/GcHxV6lHaNQsXmF66x
	SnoHXOICGXyFRHj4uN5/6VuXkkymZGjSWey9Foo=
X-Google-Smtp-Source: ABdhPJz8NwZ4lD/9NMOq1JwEZJnFdwC4ac8s/BVyI4E8qEJwsoq+C8GCvnfAiTuy+fWKwRdfPzxw6w==
X-Received: by 2002:aa7:84cf:0:b0:50d:d25a:5d37 with SMTP id x15-20020aa784cf000000b0050dd25a5d37mr29648207pfn.84.1652347148550;
        Thu, 12 May 2022 02:19:08 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j21-20020a62e915000000b005104c6d7941sm3184474pfh.31.2022.05.12.02.19.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:19:08 -0700 (PDT)
Message-ID: <627cd10c.1c69fb81.f9ed5.7544@mx.google.com>
Date: Thu, 12 May 2022 02:19:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-49-g02cbcd6511d4
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 5 regressions (v4.4-st5-49-g02cbcd6511d4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 5 regressions (v4.=
4-st5-49-g02cbcd6511d4)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-broonie   | gcc-10   | multi_v7_defconfig=
           | 1          =

beaglebone-black   | arm    | lab-cip       | gcc-10   | multi_v7_defconfig=
           | 1          =

beaglebone-black   | arm    | lab-broonie   | gcc-10   | omap2plus_defconfi=
g          | 1          =

beaglebone-black   | arm    | lab-cip       | gcc-10   | omap2plus_defconfi=
g          | 1          =

hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-49-g02cbcd6511d4/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-49-g02cbcd6511d4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02cbcd6511d490bde09277489d0cd57e67cd1d77 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-broonie   | gcc-10   | multi_v7_defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/627cce95eeffdf77168f571e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627cce95eeffd=
f77168f571f
        failing since 1 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | multi_v7_defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/627cc9a9cd952663ed8f5718

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-c=
ip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-c=
ip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627cc9a9=
cd952663ed8f571b
        failing since 1 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-12T08:47:22.770797  / # =

    2022-05-12T08:47:22.773177  =

    2022-05-12T08:47:27.792627  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/678031/extract-nfsrootfs-h6llptt6'
    2022-05-12T08:47:27.803329  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/678031/extract-nfsrootfs-</lib/lava/dispatcher/tmp/678031/extract-nf=
srootfs-h                         6llptt6'
    2022-05-12T08:47:29.971995  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-12T08:47:29.982691  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-12T08:47:30.088533  / # #
    2022-05-12T08:47:30.090997  #
    2022-05-12T08:47:30.206528  / # export SHELL=3D/bin/sh
    2022-05-12T08:47:30.208931  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-broonie   | gcc-10   | omap2plus_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccd6826d3bba38a8f5718

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/omap2plus_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/omap2plus_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627ccd6826d3b=
ba38a8f5719
        new failure (last pass: v4.4-st5-17-g04a3c17cb526f) =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | omap2plus_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/627cc91d08c715d4658f5727

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627cc91d=
08c715d4658f572a
        failing since 1 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-12T08:44:58.832062  / # =

    2022-05-12T08:44:58.836750  =

    2022-05-12T08:45:03.857119  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/678029/extract-nfsrootfs-witd6d56'
    2022-05-12T08:45:03.867811  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/678029/extract-nfsrootfs-</lib/lava/dispatcher/tmp/678029/extract-nf=
srootfs-w                         itd6d56'
    2022-05-12T08:45:06.056611  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-12T08:45:06.067341  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-12T08:45:06.192895  / # #
    2022-05-12T08:45:06.196064  #
    2022-05-12T08:45:06.325979  / # export SHELL=3D/bin/sh
    2022-05-12T08:45:06.329211  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627cced9f331f5f1968f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627cced9f331f=
5f1968f5718
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

