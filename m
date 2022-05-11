X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.291.1652304085376941553
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 14:21:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=s6iPXr6V;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id s14so3069079plk.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pnNTuJsyZg2pen/HlAK5at/1PtliOH5qHemsbR6nsE4=;
        b=s6iPXr6VG/j2JytXNxxkhMU51TctrIPBezJtNZ999jMknHTe0G/m1k596mhqh6LjaZ
         QE0fCBXIagpYGpsh8i1WH1BMBUWoZi/tJvXq7bxSuRUkBtGxHFZO3zH+52GJEjlgMDqp
         /wki6KbZQbyMbGK/p0cl7eCNkLoiibEPW2nM93qGTHrPzFwHBkSWgv1/Bg0YqmZUFAjD
         SkggyaXEnqdm+Hnh04cy+8QJXKjExr9bnENZ89g5Udk9J7PvOKX7bIygdhRaRhGkZXZ8
         L2Eyb6nl8EjAaONrYBgwpE2uQZFcigfnwE0hOF4lLlkFNhKZv8SCJDboez+zzClsUiFk
         yTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pnNTuJsyZg2pen/HlAK5at/1PtliOH5qHemsbR6nsE4=;
        b=UnN1yaHorpN5egrTLrN3E9g/rJf6wsIX4PGYZqvLaSS/C2fklwypTAvZHAAkcYhP5a
         4KO+Ig+dWcMCb9lez+xDQCYbDKkY4yR30meifhEvRqeZkg3BWuM4qVjzvbtp620VQW/y
         GipArIhNUtQigkzYgJVDp6vGipjUniDoLfAPiJHNme4caaeXcH6q51Sgj5okyzHHvcAI
         7QV0xArsuXk5XGq4hkqVowQ8GGuSlB00jm7rmQVAx8D16uLaMDRCzd6ARtSqUHqNr/o4
         VdlDcHY5J7RFGqscB+bvMLg6L9FWFxcGJAjWW0gMe8WR02/v0itWBHXgBkh+KbndMB1h
         9YEA==
X-Gm-Message-State: AOAM5308ObJsZSWPigwPmvRN5dhnAG5CkIrHD6p8ggy3YXpwgS0tE0ge
	lnJV4my3j1BiDyEGtvtD9ilvb1yr65Dvh+5Y71w=
X-Google-Smtp-Source: ABdhPJwvO9kp3wFAWbgo/LVAF13dokfD2KpfZsOz90JY3Dly4TEvm9wtHBjsAGHx5fP9F/WIkOCMvg==
X-Received: by 2002:a17:90b:1291:b0:1db:eab7:f165 with SMTP id fw17-20020a17090b129100b001dbeab7f165mr7385578pjb.74.1652304084397;
        Wed, 11 May 2022 14:21:24 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902d11400b0015e8d4eb282sm2313169plw.204.2022.05.11.14.21.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:21:24 -0700 (PDT)
Message-ID: <627c28d4.1c69fb81.e9aea.5462@mx.google.com>
Date: Wed, 11 May 2022 14:21:24 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-261-g4f0b5ddda6cf
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 10 runs, 6 regressions (v4.4-st5-261-g4f0b5ddda6cf) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 10 runs, 6 regressions (v4.4-s=
t5-261-g4f0b5ddda6cf)

Regressions Summary
-------------------

platform                 | arch  | lab          | compiler | defconfig     =
      | regressions
-------------------------+-------+--------------+----------+---------------=
------+------------
beaglebone-black         | arm   | lab-broonie  | gcc-10   | multi_v7_defco=
nfig  | 1          =

beaglebone-black         | arm   | lab-cip      | gcc-10   | multi_v7_defco=
nfig  | 1          =

beaglebone-black         | arm   | lab-broonie  | gcc-10   | omap2plus_defc=
onfig | 1          =

beaglebone-black         | arm   | lab-cip      | gcc-10   | omap2plus_defc=
onfig | 1          =

juno-uboot               | arm64 | lab-broonie  | gcc-10   | defconfig     =
      | 1          =

sun4i-a10-olinuxino-lime | arm   | lab-baylibre | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-261-g4f0b5ddda6cf/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-261-g4f0b5ddda6cf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4f0b5ddda6cf91123ba71e05f9b8c6d129f6cc14 =



Test Regressions
---------------- =



platform                 | arch  | lab          | compiler | defconfig     =
      | regressions
-------------------------+-------+--------------+----------+---------------=
------+------------
beaglebone-black         | arm   | lab-broonie  | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/627bdbc71044e54f938f5738

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627bdbc71044=
e54f938f573f
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T15:52:25.656530  / # =

    2022-05-11T15:52:25.663496  =

    2022-05-11T15:52:30.679421  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/132278/extract-nfsrootfs-dy583bd_'
    2022-05-11T15:52:30.690422  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/132278/extract-nfsrootfs-dy583bd_'
    2022-05-11T15:52:32.981322  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T15:52:32.992288  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T15:52:33.097405  / # #
    2022-05-11T15:52:33.104286  #
    2022-05-11T15:52:33.206736  / # export SHELL=3D/bin/sh
    2022-05-11T15:52:33.213584  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab          | compiler | defconfig     =
      | regressions
-------------------------+-------+--------------+----------+---------------=
------+------------
beaglebone-black         | arm   | lab-cip      | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/627b8848f4d5c8276e8f5717

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627b8848f4d5=
c8276e8f571c
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T09:56:04.762399  / # =

    2022-05-11T09:56:04.770774  =

    2022-05-11T09:56:09.788614  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677603/extract-nfsrootfs-zrvu5xss'
    2022-05-11T09:56:09.799508  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677603/extract-nfsrootfs-zrvu5xss'
    2022-05-11T09:56:11.849285  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-11T09:56:11.860205  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-11T09:56:11.965259  / # #
    2022-05-11T09:56:11.973425  #
    2022-05-11T09:56:12.075793  / # export SHELL=3D/bin/sh
    2022-05-11T09:56:12.084129  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab          | compiler | defconfig     =
      | regressions
-------------------------+-------+--------------+----------+---------------=
------+------------
beaglebone-black         | arm   | lab-broonie  | gcc-10   | omap2plus_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/627bd9d265051daf4b8f5719

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627bd9d26505=
1daf4b8f5720
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T15:43:46.926369  / # =

    2022-05-11T15:43:46.932278  =

    2022-05-11T15:43:51.953301  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/132259/extract-nfsrootfs-2lawtodp'
    2022-05-11T15:43:51.964311  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/132259/extract-nfsrootfs-2lawtodp'
    2022-05-11T15:43:54.265460  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T15:43:54.276447  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T15:43:54.388852  / # #
    2022-05-11T15:43:54.394329  #
    2022-05-11T15:43:54.508607  / # export SHELL=3D/bin/sh
    2022-05-11T15:43:54.514041  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab          | compiler | defconfig     =
      | regressions
-------------------------+-------+--------------+----------+---------------=
------+------------
beaglebone-black         | arm   | lab-cip      | gcc-10   | omap2plus_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/627b879b2bb06a9d9b8f5729

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627b879b2bb0=
6a9d9b8f572e
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T09:53:12.732360  / # =

    2022-05-11T09:53:12.735492  =

    2022-05-11T09:53:17.748853  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677600/extract-nfsrootfs-cf8okycw'
    2022-05-11T09:53:17.759517  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677600/extract-nfsrootfs-cf8okycw'
    2022-05-11T09:53:19.932990  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-11T09:53:19.943671  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-11T09:53:20.051144  / # #
    2022-05-11T09:53:20.053840  #
    2022-05-11T09:53:20.167268  / # export SHELL=3D/bin/sh
    2022-05-11T09:53:20.169961  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab          | compiler | defconfig     =
      | regressions
-------------------------+-------+--------------+----------+---------------=
------+------------
juno-uboot               | arm64 | lab-broonie  | gcc-10   | defconfig     =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/627b8a6520bc3dc4228f5776

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs=
-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs=
-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627b8a6520bc3dc42=
28f5777
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                 | arch  | lab          | compiler | defconfig     =
      | regressions
-------------------------+-------+--------------+----------+---------------=
------+------------
sun4i-a10-olinuxino-lime | arm   | lab-baylibre | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/627ba5b7307f844bc08f571b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-nfs-sun4i-a10-olinuxino-lime.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-nfs-sun4i-a10-olinuxino-lime.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627ba5b7307f844bc=
08f571c
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =20

