Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82684C6FA82
	for <webhook@archiver.kernel.org>; Sat, 17 Sep 2022 16:15:35 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web08.138.1663431332428157870
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=6fIsru0B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id jm11so24156565plb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=W8YoDU9uc2whTvEzrh/0VJse1cAjvmw64FIgSMJgv8k=;
        b=6fIsru0B0L+8nzbrkmkInLDcq9f4JWbXOgiNNne3Nb2wHa6wDhH8kv+XPdAsD/HSRP
         HjdIVXt+YLr/CC+M3+nm30Ttr6MIPTRhJ9Y30/F6ZRU7PDj5rONu23XH138FwXz3h0tK
         APexWrfn6QFZ8XqXSrqwZAUDQ2OOmdwO0uRGsoPlYt1snoyPKpD+FEEfmvrk/5ztoYmC
         3mB7TcY6eVfuJNCf8e2VRs5pGIc5wkupcfzxERZDxmRsDiyVdUTYW83TIqso2sdCgVfk
         6ye9Am0+L7Nrgq3XkcXMu653x4Cg/JgW9KExmKi2fsItEMidh/802tIpYcnoyqkSqtJl
         NOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=W8YoDU9uc2whTvEzrh/0VJse1cAjvmw64FIgSMJgv8k=;
        b=pGTs4TpTuhh+YAF2lju6d+glgpJynhtdpCtnefrsKcBYtkKQ/vqtKTmxjin2q2p7fP
         8FAR6lYuhXMJyPVkm3E/zui55ifgcnMhU0XrwzYr5A4lUUEIh0dWAyjdL/sBSmhe+uE+
         miWzx8UTwMGGliWyHt/Ki2isYQoiUlWYtjPeAjH2AAdTv8X7OFiug9rXk0hMLKJwjSQW
         kBvozC32+h51Og6pwQu7HLx9YkN0E/YuyYlmsD8AYzSzaAK9tNHR64IBwQVA2FrWrTcE
         FOng7/DE9pNnE4wnI/tGNTjaeuffP95ZYWgvtX3eGPSN05rOZTIjMtOOSZrwXiVPR0Lq
         2P7A==
X-Gm-Message-State: ACrzQf1n4//yePi9ZE1PTyR/8vc2cWYOJmSUHMEeWcAP0GqzkNSDR/BY
	7Op4UOHHv0Fdf2E5qVq+xBSyHytENmSpH05SR/8=
X-Google-Smtp-Source: 
 AMsMyM5DEcuX+QpHs3jI57+TBbjVHFiytj+CvEjTQxyevLxh/qOk1EIUjl3bTz5iQok8jOZIfJc6IA==
X-Received: by 2002:a17:902:e5c1:b0:176:c2b3:6a4c with SMTP id
 u1-20020a170902e5c100b00176c2b36a4cmr5141693plf.87.1663431331672;
        Sat, 17 Sep 2022 09:15:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 s14-20020a65644e000000b00438fe64d61esm12288051pgv.0.2022.09.17.09.15.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:15:31 -0700 (PDT)
Message-ID: <6325f2a3.650a0220.29ff3.6973@mx.google.com>
Date: Sat, 17 Sep 2022 09:15:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-229-gb433f12afe250
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs,
 4 regressions (v4.4-st20-229-gb433f12afe250)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Sep 2022 16:15:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9500

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 4 regressions (v4.=
4-st20-229-gb433f12afe250)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-229-gb433f12afe250/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-229-gb433f12afe250
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b433f12afe2506afd30066f5b2b826129a20bc03 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ecde7dd64900cc355645

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/6325ecde=
7dd64900cc35564a
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)
        1 lines

    2022-09-17T15:50:31.682302  / # =

    2022-09-17T15:50:31.692651  =

    2022-09-17T15:50:36.734562  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/527838/extract-nfsrootfs-7u7feu1o'
    2022-09-17T15:50:36.744888  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/527838/extract-nfsrootfs-</lib/lava/dispatcher/tmp/527838/extract-nf=
srootfs-7                         u7feu1o'
    2022-09-17T15:50:39.099070  / # export NFS_SERVER_IP=3D'192.168.56.125'
    2022-09-17T15:50:39.109379  export NFS_SERVER_IP=3D'192.168.56.125'
    2022-09-17T15:50:39.255141  / # #
    2022-09-17T15:50:39.259160  #
    2022-09-17T15:50:39.401427  / # export SHELL=3D/bin/sh
    2022-09-17T15:50:39.406597  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ebe5f77bbf7a2b355659

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/6325ebe5=
f77bbf7a2b35565c
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)
        1 lines

    2022-09-17T15:46:27.806285  / # =

    2022-09-17T15:46:27.811688  =

    2022-09-17T15:46:32.851728  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/744689/extract-nfsrootfs-u6i080pl'
    2022-09-17T15:46:32.862462  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/744689/extract-nfsrootfs-</lib/lava/dispatcher/tmp/744689/extract-nf=
srootfs-u                         6i080pl'
    2022-09-17T15:46:35.053230  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-09-17T15:46:35.063925  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-09-17T15:46:35.189639  / # #
    2022-09-17T15:46:35.192964  #
    2022-09-17T15:46:35.322134  / # export SHELL=3D/bin/sh
    2022-09-17T15:46:35.325309  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb89a47e7d92f035564d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6325eb89a47e7=
d92f035564e
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325edef9fb6707e3435565b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6325edef9fb67=
07e3435565c
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

