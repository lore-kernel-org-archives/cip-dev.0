Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395ADC43334
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:05:04 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web08.2413.1655283896214068629
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:04:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=RqLyuVuH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id
 o33-20020a17090a0a2400b001ea806e48c6so1436331pjo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4OwiGLcwaio9D3NdOcGz/iPWQEbdDfLysbNIKMmNPU8=;
        b=RqLyuVuHqfdLGlZesXJSrjmZj53kbAcYUCEp+oEOwYxcwF7WacgJbOafZeiFYt5KI3
         SejGDdmJEzuszEvBcqQlWYfYrkJxPcmjzu8VLwMqW/zis8zmv3Vz6hMzDPCgofak4WqX
         2AfsEkVgcfGqrYAovduuwHPzzjVWBwoFaXdZmLsSrY99iw0kTfgObKOtBRFzSfnxxQgo
         SUKqZ2E7+3G93ze85NT0FnY+TndFjgHR3wcgmEMNA5cg+WSdQeWsQi/ZCbrn1Ioibs5Y
         JmUYZCqJtGGdDdKwKj0Thoq3lIO9hDx8EII0XFlPL+W2dMQIRKTLW0ks9umQrQ2Pi71j
         dp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4OwiGLcwaio9D3NdOcGz/iPWQEbdDfLysbNIKMmNPU8=;
        b=ZdUMTQZdap2fRVFSgCuinWtEHRUL6jShj+KzfdpE1vkLOgZkxSVnVVKk6HKxUi7iU+
         3n3XI21ztY+33vBl0+KloXXlY8Xdt00Cs/oUkGFZVNt8p8CBmF2b20wb5YBHENCahDT8
         Qp0GDrV7VlNpE7eOfKwXKfzs84qPk3SkDu8Rh3eLqxqnAAZUHk8k/Ex4+d2CLcEtH4Ga
         mb4h/IYODUQChYQM5Cu2/Y9G5Ng0XrhE8V3D7+YZnQHjNn4wpKn95eHiiMWEBOlwUPRn
         JdErLfYoZbW/2nZPq7VLIuhFFlODXz0dADjCED5exdDSaWEadVn7g8hBYngzAIyzJGZ4
         bGbg==
X-Gm-Message-State: AOAM530aO3rxcvtpq3qjbaxx68v3ZMfHZY1kZCGlJeuJlRozAhaehppd
	NnfT+pSNUKhicVyKQUCsFxksiS9HfVaMn3yhXOw=
X-Google-Smtp-Source: 
 AGRyM1upWB7Rg8pXVNC4L3Yw2hahuUKA7et7W7ceyNbKF5Y3ymvwvQo8x/CO+Mtb0X1zVBLCOKNrJg==
X-Received: by 2002:a17:902:e5ca:b0:167:4e08:a63a with SMTP id
 u10-20020a170902e5ca00b001674e08a63amr8353091plf.69.1655283895381;
        Wed, 15 Jun 2022 02:04:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 k12-20020a63ab4c000000b00408a96d3932sm3293517pgp.58.2022.06.15.02.04.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:04:54 -0700 (PDT)
Message-ID: <62a9a0b6.1c69fb81.dfd3a.4699@mx.google.com>
Date: Wed, 15 Jun 2022 02:04:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-312-g3a12bf5207d81
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 21 runs,
 4 regressions (v4.4-st5-312-g3a12bf5207d81)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 09:05:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8560

cip-gitlab/ci/pavel/linux-test baseline-nfs: 21 runs, 4 regressions (v4.4-s=
t5-312-g3a12bf5207d81)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
beaglebone-black  | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig |=
 1          =

beaglebone-black  | arm   | lab-cip       | gcc-10   | multi_v7_defconfig |=
 1          =

juno-uboot        | arm64 | lab-broonie   | gcc-10   | defconfig          |=
 1          =

rk3288-veyron-jaq | arm   | lab-collabora | gcc-10   | multi_v7_defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-312-g3a12bf5207d81/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-312-g3a12bf5207d81
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a12bf5207d810922b696a4c99c88e2841af6212 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
beaglebone-black  | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/62a758457540cb34fba39bcf

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220610.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62a758457540=
cb34fba39bd6
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)
        1 lines

    2022-06-13T15:30:47.075008  / # =

    2022-06-13T15:30:47.079544  =

    2022-06-13T15:30:52.097411  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/219899/extract-nfsrootfs-vatzdwnp'
    2022-06-13T15:30:52.108188  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/219899/extract-nfsrootfs-vatzdwnp'
    2022-06-13T15:30:54.396262  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2022-06-13T15:30:54.406927  export NFS_SERVER_IP=3D'192.168.56.123'
    2022-06-13T15:30:54.509570  / # #
    2022-06-13T15:30:54.515195  #
    2022-06-13T15:30:54.617056  / # export SHELL=3D/bin/sh
    2022-06-13T15:30:54.622709  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
beaglebone-black  | arm   | lab-cip       | gcc-10   | multi_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/62a756f69245252702a39cca

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220610.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62a756f69245=
252702a39ccf
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)
        1 lines

    2022-06-13T15:25:08.636447  / # =

    2022-06-13T15:25:08.644463  =

    2022-06-13T15:25:13.652799  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/697174/extract-nfsrootfs-p6j7wpzq'
    2022-06-13T15:25:13.663506  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/697174/extract-nfsrootfs-p6j7wpzq'
    2022-06-13T15:25:15.708246  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-06-13T15:25:15.718987  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-06-13T15:25:15.822352  / # #
    2022-06-13T15:25:15.829245  #
    2022-06-13T15:25:15.930766  / # export SHELL=3D/bin/sh
    2022-06-13T15:25:15.938893  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
juno-uboot        | arm64 | lab-broonie   | gcc-10   | defconfig          |=
 1          =


  Details:     https://kernelci.org/test/plan/id/62a7597f5f7e5ead42a39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220610.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62a7597f5f7e5ead4=
2a39be9
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d) =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-10   | multi_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/62a7b599ebf10238bda39bea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-nfs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-nfs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220610.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62a7b599ebf10238b=
da39beb
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d) =

 =20

