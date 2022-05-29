X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.25721.1653835801649917042
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 May 2022 07:50:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QXjaox0D;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id r71so8076446pgr.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 May 2022 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=skLPjRvvlUtyB1ySJPWJ1yD7fCOEvFPdhNA+hOIzqpo=;
        b=QXjaox0DLSrK6w8V4JlnsQ/1TJqi61+DDGbJqPeTaz7cVYOqyeTxa0u6bWg+SKPYnp
         TGB/gfBIrQeUb8455jzovNilGuswjwDL+KlnAWL6wq1/VjBH2GHq/v5oKy2kqdDOe8bQ
         7lUlZg+zWRSichbmjnH0fwQxqO3cf/yrijW7jpCqOlgR5uca5UqmRhVqRY22zU1+CIuJ
         3XnwY9Cnx11ufmqLgWxee7bgiLJKkydU3sYjoPK8C0XrQ0wWGUgSnu8i+quZPTAD4t1r
         WhJKkjIM2yE5n2Rx/CaHleJQVfwOuJZutLO64+U2w5K85sJnUeFcYRsyDS/7P/sE6rfi
         nF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=skLPjRvvlUtyB1ySJPWJ1yD7fCOEvFPdhNA+hOIzqpo=;
        b=mo1u89kd18D8NBoP7hrwPaqempYCJlZH28GDoiUOllGhFW/gYEYxTunX48Dr6QBEQ9
         JPI0RuDrN0ybmvo2q2DEoP3oemyTCH02t8HMEaPeadMdmBmt39EOm8aI+Hb4HfL2R/Aw
         VQMphPoXQWFXipD7rPoqm6m8DeAzBaHyqXJmEYzKTUwp0strD4IY0anPbo89bwsTVuI7
         FwFcswBzISdrq1oT2lfB8/WWIqr+ra4YW+TKRHfpAwWN6ouEpeZjmXd1+lYtTITR3Vxk
         XzfKsW5k+Zz289wLVXzfRVBShNAd4AOAeR4WMQWKaf3iEpNrqxUoKkKosAGgJA/A+0oc
         ReEA==
X-Gm-Message-State: AOAM530evNEiQdH60BnKEzATwCGY24gMhefAQDiVXMChNQ6eVwqM2K9S
	I3KmB7R7udqDGt88caX0uL91n+H+i62JDEwLZ0o=
X-Google-Smtp-Source: ABdhPJxsSXTz6CZJtf/m/lazcEqHmZ4ZVfqxSl0IhbYtMd+GJAXcy6jl0f6/7oBtaJZi6d+TcZ9Qyg==
X-Received: by 2002:a65:4304:0:b0:3fb:9303:de99 with SMTP id j4-20020a654304000000b003fb9303de99mr12941201pgq.429.1653835800836;
        Sun, 29 May 2022 07:50:00 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00150300b00518e1251197sm7321271pfu.148.2022.05.29.07.49.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 07:49:59 -0700 (PDT)
Message-ID: <62938817.1c69fb81.cdd4f.0477@mx.google.com>
Date: Sun, 29 May 2022 07:49:59 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-297-gc0d53c2a5c03d
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs, 6 regressions (v4.4-st5-297-gc0d53c2a5c03d) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs, 6 regressions (v4.=
4-st5-297-gc0d53c2a5c03d)

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

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-297-gc0d53c2a5c03d/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-297-gc0d53c2a5c03d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0d53c2a5c03d0b2672a56140f211b51b3e047c1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62937b169b83b98d4da39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62937b169b83b=
98d4da39bce
        failing since 18 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/629379d20c87d0b49ea39bcd

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/629379d2=
0c87d0b49ea39bd0
        new failure (last pass: v5.10.112-cip6)
        1 lines

    2022-05-29T13:48:50.392324  / # =

    2022-05-29T13:48:50.394827  =

    2022-05-29T13:48:55.420403  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/688596/extract-nfsrootfs-k3oj1di3'
    2022-05-29T13:48:55.431083  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/688596/extract-nfsrootfs-</lib/lava/dispatcher/tmp/688596/extract-nf=
srootfs-k                         3oj1di3'
    2022-05-29T13:48:57.602276  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-29T13:48:57.612927  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-29T13:48:57.718733  / # #
    2022-05-29T13:48:57.721138  #
    2022-05-29T13:48:57.836863  / # export SHELL=3D/bin/sh
    2022-05-29T13:48:57.839190  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62937c7e32bd5dd26ca39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62937c7e32bd5=
dd26ca39bd3
        failing since 1 day (last pass: v4.4-st5-1797-gb2b8419761095, first=
 fail: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62937a3e3e2a6da913a39bd9

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62937a3e=
3e2a6da913a39bdc
        new failure (last pass: v5.10.112-cip6)
        1 lines

    2022-05-29T13:50:21.084580  / # =

    2022-05-29T13:50:21.094224  =

    2022-05-29T13:50:26.119239  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/688598/extract-nfsrootfs-bmey4rcr'
    2022-05-29T13:50:26.130051  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/688598/extract-nfsrootfs-</lib/lava/dispatcher/tmp/688598/extract-nf=
srootfs-b                         mey4rcr'
    2022-05-29T13:50:28.202752  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-29T13:50:28.213542  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-29T13:50:28.343031  / # #
    2022-05-29T13:50:28.351032  #
    2022-05-29T13:50:28.480500  / # export SHELL=3D/bin/sh
    2022-05-29T13:50:28.488355  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629379a52c990460eea39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/629379a52c990=
460eea39bce
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937db97ad1184be6a39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62937db97ad11=
84be6a39bd3
        new failure (last pass: v5.10.112-cip6) =

 =20

