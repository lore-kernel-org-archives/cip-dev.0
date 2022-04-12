X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web09.5187.1649724275756906912
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 17:44:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=egvJQE4X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id z16so16052523pfh.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 17:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gxYwrmWEZRR+W3qd7cA30z+4dH3AAGS0tC815HAWWSI=;
        b=egvJQE4X2Ibe1PIN3HWKU9O8Gw8cPwqh6zJH2kSiVxEjjN6LUWJSV7s7ve3/IofvYI
         HZRH5DBJXSGwPaXk9gGjkcfe4BW3U6WMfUe8nbGptHK+AjCM5Okze+QDwWIGBNS5WYeH
         wGTzHQozzU11YHU3gSy7YMKrfJugMw4qy+ZijMX7Hzosk8E8NnUn2USaKxjxucvS+K3M
         d9Pk7AlIvWq4BZjr76keLOJMSxJvc+T8pZG629bMDFsfMe45+tSytKA8uWZWFATHP3Tl
         YHkncMf2YtF2ejjBIba0OEqHevWtZHW1RDFyJIHY8gDgfwDeZowVtWws72/5e3RrqAQO
         kk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gxYwrmWEZRR+W3qd7cA30z+4dH3AAGS0tC815HAWWSI=;
        b=H6qJfT6VCj7QZPZ5APJOjry7YdBFegTWeNkLl2geZxxrdJrgfDwYUpN77Idy8LBqbM
         2peYNpox5mBped/xVfcgKRcgMUcY54ilMWsEJvwbmGvUVnyyIz1qzsvfHnBeNlbSaIfA
         Bugwfj1go0BPWTLtqf270r+HW/fpUXx/EI6U4w/hmBplofqGB45Zfnhgx0OyqrJt7TN0
         bbyrak5Nx3o/HBB8rv/wA0QLKwLvSl4j+kpHE3DQXjbrnaWeQhK8BrIgJGsA75LlPecv
         RpebggeSxst3HZkt0p0OqfkTDCKYkVLj2UrcazA6gNHYbsFs+jnT/HuDq6wxZBDioDUW
         AjIQ==
X-Gm-Message-State: AOAM533RJKcaXcU5fxcN9MgZRFbyzPfnxRPbdjguto20aj/JdiaarZEs
	jqtNiGrpfxgnYF9Oe7zF4T28Yegk/zEm7/Bj
X-Google-Smtp-Source: ABdhPJy8B7/QTUSerLPZlbHlHpcVUnzdzSWAjmxbjd+nywMRBpBishm+5qbQ/nlghW1z6Zq9mPCTBw==
X-Received: by 2002:a63:6a88:0:b0:398:7866:5ce4 with SMTP id f130-20020a636a88000000b0039878665ce4mr28144288pgc.240.1649724275004;
        Mon, 11 Apr 2022 17:44:35 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b004fe3d6c1731sm23574593pfo.175.2022.04.11.17.44.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 17:44:34 -0700 (PDT)
Message-ID: <6254cb72.1c69fb81.cd506.fcc5@mx.google.com>
Date: Mon, 11 Apr 2022 17:44:34 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-2498-g49524d978f8eb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 13 runs, 8 regressions (v4.4-st5-2498-g49524d978f8eb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 13 runs, 8 regressions (v4.4-s=
t5-2498-g49524d978f8eb)

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

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-2498-g49524d978f8eb/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-2498-g49524d978f8eb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      49524d978f8eb9de24ce93fcca8d5a39522876c3 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c38c5a80b7c77aae069e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6254c38c5a80b7c77=
aae069f
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c498286387259bae0696

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6254c498286387259=
bae0697
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c4a36a1d964bc5ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6254c4a36a1d964bc=
5ae067d
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c46cf35e4bb1a5ae06ae

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6254c46cf35e=
4bb1a5ae06b3
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593)
        1 lines

    2022-04-12T00:14:20.314217  / # =

    2022-04-12T00:14:20.316535  =

    2022-04-12T00:14:25.325473  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/661663/extract-nfsrootfs-u6dlz5yx'
    2022-04-12T00:14:25.336190  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/661663/extract-nfsrootfs-u6dlz5yx'
    2022-04-12T00:14:27.502467  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-04-12T00:14:27.513176  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-04-12T00:14:27.616532  / # #
    2022-04-12T00:14:27.619003  #
    2022-04-12T00:14:27.722233  / # export SHELL=3D/bin/sh
    2022-04-12T00:14:27.724585  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c5d926ce002042ae0693

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6254c5d926ce=
002042ae0698
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593)
        1 lines

    2022-04-12T00:20:09.730996  / # =

    2022-04-12T00:20:09.739419  =

    2022-04-12T00:20:14.758428  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/661668/extract-nfsrootfs-2fzn29eo'
    2022-04-12T00:20:14.769332  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/661668/extract-nfsrootfs-2fzn29eo'
    2022-04-12T00:20:16.828453  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-12T00:20:16.839341  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-12T00:20:16.952054  / # #
    2022-04-12T00:20:16.959812  #
    2022-04-12T00:20:17.072603  / # export SHELL=3D/bin/sh
    2022-04-12T00:20:17.080301  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c5d64ac618624fae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6254c5d64ac618624=
fae067d
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c544bd895d1ce3ae06ac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6254c544bd895d1ce=
3ae06ad
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254ca71d737bcb938ae0692

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6254ca71d737bcb93=
8ae0693
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =20

