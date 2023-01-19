Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E2C00A5A
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 09:59:10 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.42128.1674122348926941196
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 19 Jan 2023 01:59:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=iXmjc9LA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so4476825pjq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 19 Jan 2023 01:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XXDPkjlFGZL8TUF+V00bkEkAzhNiJ4me0tVu3n+c6RA=;
        b=iXmjc9LAHWsdgHuumxZLuxNWpjSyjd8CshungsgfJ/eNTmQW/gkzyivLyyt9s4fBt4
         3bXVC4cwd0CntOvbOx54y6sryAad2UdxoV/i3nuoz8h1HtzFESLVZrbdCnFGPW+eyj61
         WIoKIqEw8r3ZLsOExPwl95ISNlaC6M61kxWLDV39579417QLppg4tBGyReq0R7PRFsdU
         WT0V8h9N/U9LLK1cmNNMu5UuR0nh5HPiFhCJBCwxWivL4Shaw/48CQHO2Krk7VHIY8/i
         4rQYrzk7XPFW1Pq7Yv/4hFJ3x0/Vna5KX6q62mK94enkhEDqcV+Ce+z2kB5dJyUP4+ZY
         y7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXDPkjlFGZL8TUF+V00bkEkAzhNiJ4me0tVu3n+c6RA=;
        b=3QMVolH7KUgvjHn/QX/IWa3J7tQGmYrtm2bHvZHnMetdOxwYzxzGObBLivKTjs9i/p
         m1KciUaDPnL0inuUnZ+EyDPetWbxHdaJ548vgS4p4Fjcti5x99+ummTprmx6kz+kH39p
         LoPJCAuCXrr0Okmbdyy3JLpSDoM3sO7t4bV5reIHqycEoa5mt5HRGYoDNhnixZaZs7SO
         UPjaneFHGhI3QgVqgqwXCni3uc0tp2bA0GHTu6TfuIFVduZp1dO3iANN2MeOhl6gosi9
         otsriGtHgrg2VRqLsgrs/e+SRwdlJ5+SsLiCxg9FJuxVF/bhAzNEWXm1b3Iw/W/tCnYx
         XYXA==
X-Gm-Message-State: AFqh2krlFmBF68s7oBNZmlXD69GRzGwLqvsceAq8vrIdqGUy0mAl3hJI
	EddsMdhc5mCtU7uOVbD2nWYOuuySm4eDvvHrxxAm6A==
X-Google-Smtp-Source: AMrXdXtuBcskq4bN4l7xYpvoCb9r2YglsHMhn9Sg3GwcvckU0J6ESfCtqv36/+m4lBqVAgUJvxWiAg==
X-Received: by 2002:a17:90b:11d4:b0:229:f3ff:f63d with SMTP id gv20-20020a17090b11d400b00229f3fff63dmr369010pjb.49.1674122347600;
        Thu, 19 Jan 2023 01:59:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a16c200b002272616d3e1sm2727259pje.40.2023.01.19.01.59.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 01:59:07 -0800 (PST)
Message-ID: <63c9146b.170a0220.8e90c.42bb@mx.google.com>
Date: Thu, 19 Jan 2023 01:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.269-cip88-479-g3f9e11225caa5
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 27 runs,
 11 regressions (v4.19.269-cip88-479-g3f9e11225caa5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 09:59:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10432

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 27 runs, 11 regres=
sions (v4.19.269-cip88-479-g3f9e11225caa5)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

meson-gxm-khadas-vim2     | arm64  | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.269-cip88-479-g3f9e11225caa5/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.269-cip88-479-g3f9e11225caa5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3f9e11225caa53af6e56924348b7fb20ccc15806 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c9101bdccbe5dfc0915ec6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c9101bdccbe5dfc0915ecb
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:40:15.702823  + set +x
    2023-01-19T09:40:15.709223  <8>[   15.561255] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8794199_1.5.2.3.1>
    2023-01-19T09:40:15.814933  / # #
    2023-01-19T09:40:15.915903  export SHELL=3D/bin/sh
    2023-01-19T09:40:15.916163  #
    2023-01-19T09:40:16.017110  / # export SHELL=3D/bin/sh. /lava-8794199/e=
nvironment
    2023-01-19T09:40:16.017278  =

    2023-01-19T09:40:16.118247  / # . /lava-8794199/environment/lava-879419=
9/bin/lava-test-runner /lava-8794199/1
    2023-01-19T09:40:16.118536  =

    2023-01-19T09:40:16.123576  / # /lava-8794199/bin/lava-test-runner /lav=
a-8794199/1 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90f955598420b3b915ec6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c90f955598420b3b915ecb
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:38:17.238895  [   45.552172] <LAVA_SIGNAL_ENDRUN 0_dmesg =
142244_1.6.2.4.1>
    2023-01-19T09:38:17.358524  / # #
    2023-01-19T09:38:17.461044  export SHELL=3D/bin/sh
    2023-01-19T09:38:17.461656  #
    2023-01-19T09:38:17.563522  / # export SHELL=3D/bin/sh. /lava-142244/en=
vironment
    2023-01-19T09:38:17.564075  =

    2023-01-19T09:38:17.665984  / # . /lava-142244/environment/lava-142244/=
bin/lava-test-runner /lava-142244/1
    2023-01-19T09:38:17.666794  =

    2023-01-19T09:38:17.670769  / # /lava-142244/bin/lava-test-runner /lava=
-142244/1
    2023-01-19T09:38:17.827316  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90f4c5c70db60a6915ec9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c90f4c5c70db60a6915ecc
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:36:52.358627  + set +x
    2023-01-19T09:36:52.360707  <8>[   42.672756] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828964_1.6.2.4.1>
    2023-01-19T09:36:52.490466  / # #
    2023-01-19T09:36:52.592405  export SHELL=3D/bin/sh
    2023-01-19T09:36:52.592945  #
    2023-01-19T09:36:52.694365  / # export SHELL=3D/bin/sh. /lava-828964/en=
vironment
    2023-01-19T09:36:52.694813  =

    2023-01-19T09:36:52.796261  / # . /lava-828964/environment/lava-828964/=
bin/lava-test-runner /lava-828964/1
    2023-01-19T09:36:52.797010  =

    2023-01-19T09:36:52.798563  / # /lava-828964/bin/lava-test-runner /lava=
-828964/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90b11de1b989886915eea

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c90b11de1b989886915eed
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:18:58.262830  + set +x<8>[   55.764774] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 828917_1.6.2.4.1>
    2023-01-19T09:18:58.263347  =

    2023-01-19T09:18:58.452794  #
    2023-01-19T09:18:58.555977  / # #export SHELL=3D/bin/sh
    2023-01-19T09:18:58.556773  =

    2023-01-19T09:18:58.658651  / # export SHELL=3D/bin/sh. /lava-828917/en=
vironment
    2023-01-19T09:18:58.659267  =

    2023-01-19T09:18:58.761104  / # . /lava-828917/environment/lava-828917/=
bin/lava-test-runner /lava-828917/1
    2023-01-19T09:18:58.762175  =

    2023-01-19T09:18:58.769130  / # /lava-828917/bin/lava-test-runner /lava=
-828917/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90dcd745d947a4c915f59

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c90dcd745d947a4c915f5e
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:30:46.470517  / # #
    2023-01-19T09:30:46.573683  export SHELL=3D/bin/sh
    2023-01-19T09:30:46.574499  #
    2023-01-19T09:30:46.676839  / # export SHELL=3D/bin/sh. /lava-8794323/e=
nvironment
    2023-01-19T09:30:46.677664  =

    2023-01-19T09:30:46.779802  / # . /lava-8794323/environment/lava-879432=
3/bin/lava-test-runner /lava-8794323/1
    2023-01-19T09:30:46.781127  =

    2023-01-19T09:30:46.793727  / # /lava-8794323/bin/lava-test-runner /lav=
a-8794323/1
    2023-01-19T09:30:46.942322  + export TESTRUN_ID=3D1_bootrr
    2023-01-19T09:30:46.942537  + cd /lava-8794323/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
meson-gxm-khadas-vim2     | arm64  | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90d01ac776d709b915ec2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c90d01ac776d709=
b915ec3
        new failure (last pass: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63c90d4a6290463894915eda

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63c90d4a6290463894915f11
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:28:32.800813  -case
    2023-01-19T09:28:32.814706  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99
    2023-01-19T09:28:32.814974  =

    2023-01-19T09:28:32.819020  Try 'seq --help' for more information.
    2023-01-19T09:28:32.832723  /lava-8793939/1/../bin/lava-test-ca<8>[   3=
5.487147] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-rt55=
14-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63c90d4a6290463894915f12
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:28:32.757860  =

    2023-01-19T09:28:32.782311  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99
    2023-01-19T09:28:32.786002  Try 'seq --help' for more information.
    2023-01-19T09:28:32.786495  =

    2023-01-19T09:28:32.799939  /lava-8793939/1/../bin/lava-test<8>[   35.4=
54026] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max9835=
7A-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63c90d4a6290463894915f13
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:28:32.724250  =

    2023-01-19T09:28:32.724333  se
    2023-01-19T09:28:32.739102  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99
    2023-01-19T09:28:32.742928  Try 'seq --help' for more information.
    2023-01-19T09:28:32.746555  /lava-8793939/1/../bin/lava-test-case
    2023-01-19T09:28:32.757367  <8>[   35.413143] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63c90d4a6290463894915f14
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:28:32.706098  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99
    2023-01-19T09:28:32.706515  =

    2023-01-19T09:28:32.710094  Try 'seq --help' for more information.
    2023-01-19T09:28:32.723708  /lava-8793939/1/../bin/lava-test-ca<8>[   3=
5.378521] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-da72=
19-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63c912668fc4c23f19915ee2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c912668fc4c23f19915ee7
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:50:10.225381  [   22.284333] <LAVA_SIGNAL_ENDRUN 0_dmesg =
142076_1.6.2.4.1>
    2023-01-19T09:50:10.335720  / # #
    2023-01-19T09:50:10.437731  export SHELL=3D/bin/sh
    2023-01-19T09:50:10.438146  #
    2023-01-19T09:50:10.539575  / # export SHELL=3D/bin/sh. /lava-142076/en=
vironment
    2023-01-19T09:50:10.540338  =

    2023-01-19T09:50:10.642023  / # . /lava-142076/environment/lava-142076/=
bin/lava-test-runner /lava-142076/1
    2023-01-19T09:50:10.642853  =

    2023-01-19T09:50:10.645963  / # /lava-142076/bin/lava-test-runner /lava=
-142076/1
    2023-01-19T09:50:10.725301  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

