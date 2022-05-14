X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web12.3808.1652512869005467192
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 May 2022 00:21:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZuQWq/qa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id v11so9568677pff.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 May 2022 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fhnwaSekc+5vAvoyXRJGp99N08LJP81gg2uBOZzKetQ=;
        b=ZuQWq/qaaFtlls0L5vhoc6M6rMN11ne+fCoKABWp4G04FqZZRilJcu3XYLbWXTcsX0
         BPgbkLS/YECugjvZxylZKV2wvSCs9MhTPpae+U3hIh950GvbMUtn4N4sYpnrSgM5uY4D
         4KAjja/9GN35aPUBsVClmenA3Uu+w2jrh1GcvIqyjiKpFhMUG/+IcSYEByDt6nVci8PX
         48KlVD2yi6878XkL4WJhqZrYTc+OZsba5jzMbHLGyU9Er+rSF0jc8SIgKWXWsDtRMmPx
         gzqrmaSx9XbgBMuKaMi2UVqpdVH8R+beIHNHu5fenM6q8aTRN3a4AQdth7tRl2LXOT96
         cusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fhnwaSekc+5vAvoyXRJGp99N08LJP81gg2uBOZzKetQ=;
        b=daQsi1lsJIQdfkmQfKIjFQz52mhaVm1T5l3mJ/Nqr8chI+zy0MipmPUGm3GC4T24Fp
         OhP7XtyNbyL0B3Rl4rAUQWtHjs1jEV5vcy+mR/O9LM/5N6RscUvGZaGJp3dePk9+7rBa
         ZCUpIrdv2vLxuj1+bXcurnVxWx4fTnLlw5zm6fvhwJOakw9zXl+WqbmJBawDVAWqpAU/
         6i+7q8/0rUFMjp4xuztm17MSMSis6xVoFAarZKe8+rQDWcx+DOUguWPbd7WSayUw33HY
         qkrXzMYTJDSVBI5NomNkDDxUKNYEHfi4yhKdp35F2aixwnbu6B5qDXR1K8ohoH+vDh/x
         KCdQ==
X-Gm-Message-State: AOAM532dBpcWrKYyAYedJZE9MagY4uN35bzumOTRdjM4rt+U5wums2qo
	PBT/vuzLrqoIhCOhZF8vfteJRj0rycK43rAo7SQ=
X-Google-Smtp-Source: ABdhPJz+lWagyyV+9f890IKrUlnHAi1HDbiAaino+GYFxUUOXLlKjhoWaZEA/Elp2QfaX7n4Kk45IA==
X-Received: by 2002:a63:105:0:b0:3ab:e98:5844 with SMTP id 5-20020a630105000000b003ab0e985844mr6972050pgb.218.1652512868081;
        Sat, 14 May 2022 00:21:08 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b0015e8d4eb2e1sm3002194plg.299.2022.05.14.00.21.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 00:21:07 -0700 (PDT)
Message-ID: <627f5863.1c69fb81.bf492.7e7c@mx.google.com>
Date: Sat, 14 May 2022 00:21:07 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip69-50-gba851b77071ca
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.4.302-cip69-50-gba851b77071ca) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.=
4.302-cip69-50-gba851b77071ca)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip69-50-gba851b77071ca/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-50-gba851b77071ca
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ba851b77071ca2f6d6a35b5758aa276c8af6306d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/627f54cce45454d6038f5719

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627f54cc=
e45454d6038f571c
        failing since 3 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-14T07:05:30.106651  / # =

    2022-05-14T07:05:30.108977  =

    2022-05-14T07:05:35.128005  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/679428/extract-nfsrootfs-mw5lsmyh'
    2022-05-14T07:05:35.138690  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/679428/extract-nfsrootfs-</lib/lava/dispatcher/tmp/679428/extract-nf=
srootfs-m                         w5lsmyh'
    2022-05-14T07:05:37.307477  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-14T07:05:37.318182  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-14T07:05:37.424084  / # #
    2022-05-14T07:05:37.426451  #
    2022-05-14T07:05:37.541871  / # export SHELL=3D/bin/sh
    2022-05-14T07:05:37.544357  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/627f51d41ec070cc408f57c7

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627f51d4=
1ec070cc408f57ca
        failing since 3 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-14T06:52:41.121737  / # =

    2022-05-14T06:52:41.126055  =

    2022-05-14T06:52:46.166511  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/679423/extract-nfsrootfs-fbxpzr9l'
    2022-05-14T06:52:46.177193  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/679423/extract-nfsrootfs-</lib/lava/dispatcher/tmp/679423/extract-nf=
srootfs-f                         bxpzr9l'
    2022-05-14T06:52:48.389408  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-14T06:52:48.400093  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-14T06:52:48.524853  / # #
    2022-05-14T06:52:48.528065  #
    2022-05-14T06:52:48.655710  / # export SHELL=3D/bin/sh
    2022-05-14T06:52:48.658840  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f5045c0536544da8f5718

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627f5045c0536=
544da8f5719
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f5164a3fcf719358f5735

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627f5164a3fcf=
719358f5736
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

