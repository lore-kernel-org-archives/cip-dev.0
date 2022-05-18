X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.1587.1652853230778055037
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 22:53:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=U7j/SSJr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso4605573pjj.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 22:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BiBnKswMg449ThXSBfY+wwoIEvIeofjv0mYoCMgFTeA=;
        b=U7j/SSJrrih/NtecE4yaYqnYKAZ2xEgYZuR9mhjZpRyBfU2fyC+qmUqTDAeXcYZ6sn
         pDQ1ja4e6NVcaMum3UwkZbM21z2AOW7DRqsHOpkQkbsuEVCVqZ5UDK7j7wvOtUOgjbxW
         XPGnsjMO1lN4KPMWAHbV2yBVkx3yV6yFm/g1xqMccTVB40kLIZ5RvhE0KiB5v+sCcnK9
         qkyh4rn7VMA8SB3w3kgn+e+9XHV1L2v4QecDkPLkXivh7QFgd/HEWTeiVxEQHuaEMlXj
         ZXCfBtWffiWW1KtinpkYyb5X/giGKcBpT0i8iFTbLm3NCJXUTZ/b57pJH9+sZt7VSRYC
         C8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BiBnKswMg449ThXSBfY+wwoIEvIeofjv0mYoCMgFTeA=;
        b=bRUWclUoV15gat4Ehi6WJZWh71bDJ7ANPs+WsyGkICytmK3jrrA4G5JeRM5AgyBdg3
         lvoH9EwuW06NxSQq86CrxKjnaDX4hphIEzliUlscpfRiYyXiSPDH6bNDBY/wN6FPd6Wg
         qJ3CCRygPskpA4jN4G2qjFezR6Xow+4dcIWxRVE/eo0Wpb4r7+fTg3xCbnIcm0PqHkUo
         WErynpVFambOZXetqp+palGP5XEDFfDfGzCD8bVg1RbTot2Ei0q0j/Ndhr/5+qWHt60G
         F2n8jkAz88cHMhOVYdNVo+/tDodnXlge4PP4z6ChrmjoIKdgK+9YwMvDQQQXQTYh9DHP
         ZL6A==
X-Gm-Message-State: AOAM53196vh/AMA4JjxybM2oAYRUofT57TxHz93tV5Vw/I+cE7WXemmh
	rGOrzU2RI3DlOyl1D0jubeikBMo6J4K1TO9REk0=
X-Google-Smtp-Source: ABdhPJyBhZL6zBXmUvvaalg7BrE9a90/CowZ3Qzh/rCCA3CGwYl9IFWG5sDHi21bGjClMLz51POnqQ==
X-Received: by 2002:a17:902:e484:b0:161:6657:dc5b with SMTP id i4-20020a170902e48400b001616657dc5bmr16121201ple.2.1652853229698;
        Tue, 17 May 2022 22:53:49 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 37-20020a630d65000000b003c14af50610sm601117pgn.40.2022.05.17.22.53.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:53:49 -0700 (PDT)
Message-ID: <628489ed.1c69fb81.4492.1eba@mx.google.com>
Date: Tue, 17 May 2022 22:53:49 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-296-g52de9431d314
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.4.302-cip69-296-g52de9431d314) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.=
4.302-cip69-296-g52de9431d314)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip69-296-g52de9431d314/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-296-g52de9431d314
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52de9431d314a28c4aa66d8f81144c9958c11168 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/628419c74b7be1c9bda39be6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/628419c74b7be=
1c9bda39be7
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/628418a34d866c9f7da39be7

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/628418a3=
4d866c9f7da39bea
        failing since 7 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-17T21:49:57.038443  / # =

    2022-05-17T21:49:57.046041  =

    2022-05-17T21:50:02.079510  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/681708/extract-nfsrootfs-000i3n02'
    2022-05-17T21:50:02.090421  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/681708/extract-nfsrootfs-</lib/lava/dispatcher/tmp/681708/extract-nf=
srootfs-0                         00i3n02'
    2022-05-17T21:50:04.149632  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-17T21:50:04.160586  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-17T21:50:04.276221  / # #
    2022-05-17T21:50:04.282857  #
    2022-05-17T21:50:04.397784  / # export SHELL=3D/bin/sh
    2022-05-17T21:50:04.405371  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841da2fdd6164091a39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62841da2fdd61=
64091a39bd0
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628420d0e1017e441ea39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/628420d0e1017=
e441ea39bd3
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

