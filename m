Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD3C19F29
	for <webhook@archiver.kernel.org>; Thu, 28 Jul 2022 10:10:26 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web09.30885.1659003022604234875
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:10:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AqtbwiLy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 12so1189087pga.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=TiEe2PUtlcznitF4SLL3e4RkmIZ8zlgCaz83Fc2C9FE=;
        b=AqtbwiLy3qIX78x0shdK8Pi+4OdJnbsYYIQI+kPkI0rurYL9M/4kKWYjAmuGoFZpnZ
         sV/t6SsL6owclZiyc2HGbBpmUpQvlHjlIuyK061NiB01+MtCeD6Fvrd9hhWzVQxy1F7f
         fEIUhPYfeL2jYgL3ULKw7jciNLiBL9N7IbHPh6WhikaJCa1PM9ah0mlcNGuKADQ3iXqD
         XUqNdWbMm7jNRwOtlxj7AUF6B2+ZvphW/1jTSMBZzE8mfUzCf8Z5BUqv8GOpm11vxZjR
         yA7ztEd4Mtq8fNNjJGaQPMA9eNvDYkdpS0qFbIEmMlLMcwdKtLDNTIdjuhQIUV/3CVeD
         lfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=TiEe2PUtlcznitF4SLL3e4RkmIZ8zlgCaz83Fc2C9FE=;
        b=COPFBIn7wGZWmkyIP/GazqoL0gkC27BY6S2v0zuFDP10yzt7ZT2FxljoTCD9rrpGss
         icfacmjQiEEMEpC77nvn4zfU8YIgIJz0NXVpRpHnlZGQjflZ+I1k8OktsCRh8IaI5iJY
         eVNf5f+1Udo4CaJE80Ww9OyJqZ3eyMi4xO40fSq5WLV3Ld//O63GuCl6DPMI27Gq0pIu
         8cTv2zEM0arfiC3iSqNw9L5IwSLzqB+lgJl/9TE65DH3Ki9MG9cplnUeE0tkhb2/hRbF
         tupuLH2oWhdYJynRXJJ83BdV3Rzdz3qtWdQwR7xOEIk+VcG/tzjadaDE1S/Wj7UhXY3f
         L0lg==
X-Gm-Message-State: AJIora+BZd6u4YAc0nFF7ydHFOvRk55wdKHbgvMZI8RCPpI+LDhBUk7+
	PgyPXQ+RdhG90gh+1Kfuut5tkG7ethhyL5Ov1rQ=
X-Google-Smtp-Source: 
 AGRyM1uIBHwsqWXvm5hQEOceygEvmJBMTXpuyZS41Thv2roo+UyH5rdpKwE7kgx99qoobiNUQwjtIw==
X-Received: by 2002:a62:e10d:0:b0:52a:b77e:8bd3 with SMTP id
 q13-20020a62e10d000000b0052ab77e8bd3mr26703387pfh.66.1659003021477;
        Thu, 28 Jul 2022 03:10:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l15-20020a17090aec0f00b001f216407204sm595312pjy.36.2022.07.28.03.10.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:10:21 -0700 (PDT)
Message-ID: <62e2608d.170a0220.2aa74.0b6e@mx.google.com>
Date: Thu, 28 Jul 2022 03:10:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-585-gc99f2b257bde
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 26 runs,
 11 regressions (v4.4-st5-585-gc99f2b257bde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Jul 2022 10:10:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8961

cip-gitlab/ci/pavel/linux-test baseline-nfs: 26 runs, 11 regressions (v4.4-=
st5-585-gc99f2b257bde)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

sun4i-a10-olinuxino-lime     | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-585-gc99f2b257bde/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-585-gc99f2b257bde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b0b4ac1cc65984daf06a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0b0b4ac1cc6598=
4daf06b
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b1b6d14a67a1c2daf098

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0b1b6d14a67a1c=
2daf099
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b17f5bba492157daf05d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0b17f5bba49215=
7daf05e
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b1c7b27451e36cdaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0b1c7b27451e36=
cdaf057
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b5aeee47496d50daf057

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62e0b5aeee47=
496d50daf05c
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c)
        1 lines

    2022-07-27T03:48:48.248244  / # =

    2022-07-27T03:48:48.250529  =

    2022-07-27T03:48:53.260035  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/716783/extract-nfsrootfs-va054nc8'
    2022-07-27T03:48:53.270727  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/716783/extract-nfsrootfs-va054nc8'
    2022-07-27T03:48:55.437197  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-07-27T03:48:55.447835  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-07-27T03:48:55.551165  / # #
    2022-07-27T03:48:55.553489  #
    2022-07-27T03:48:55.656664  / # export SHELL=3D/bin/sh
    2022-07-27T03:48:55.659012  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b135bb46d10172daf086

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0b135bb46d1017=
2daf087
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b30beabb58f740daf058

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0b30beabb58f74=
0daf059
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b78ac79b59e730daf058

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0b78ac79b59e73=
0daf059
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b1f7d3501f0966daf07d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs=
-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs=
-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0b1f7d3501f096=
6daf07e
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0d89875eb55cf6edaf05d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-collabora/bas=
eline-nfs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-collabora/bas=
eline-nfs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0d89875eb55cf6=
edaf05e
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun4i-a10-olinuxino-lime     | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/62e119e9ff6e556754daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/sunxi_defconfig/gcc-10/lab-baylibre/baselin=
e-nfs-sun4i-a10-olinuxino-lime.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/sunxi_defconfig/gcc-10/lab-baylibre/baselin=
e-nfs-sun4i-a10-olinuxino-lime.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e119e9ff6e55675=
4daf057
        new failure (last pass: v4.4-st5-586-geb97410e0086c) =

 =20

