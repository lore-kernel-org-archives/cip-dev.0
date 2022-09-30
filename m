Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F5CC433F5
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 11:19:58 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web08.4549.1664536793927135780
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:19:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BSE0UkKF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id g130so3389237pfb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=rG9gufAIr5nlD7bpYV2RjGBHknPw6NDfPecjEDOESps=;
        b=BSE0UkKFOEXwd4PXsslXuYVaNqKKq8zeXcgStm7y4BA8XWu+tVmEaSfwknVjTJgT5N
         BlTaSpv/5d2LHCfhCWsAFhlsPO3oOxtSZqrIqWkdEzuFRLle74ZyZ7vUGd2uJ9RswTwJ
         SUHyrW8x5cthkbLIy9ySFOfovm8ta8vLT2QIHQ0QUVhDwtdkVf15KdNyXym46hFEYNuL
         IbRhbs0YYccs4QjRddZFalrUJQ9pVVf5kaHhG0aLdK1QMqdOMuuSkSabu6SB1uyj62Ao
         MUbcx4cgY8HVDb9pmNkhAAKsy0/s4gq2Z1bcKSA6p0lIF1eMk12zTDUP3WgKATq7ESQq
         Vdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=rG9gufAIr5nlD7bpYV2RjGBHknPw6NDfPecjEDOESps=;
        b=jKJfibWJ9osrxG7tiRPjYIUjNGBPIkxjPjJYG/jSgnFX3zp6L6OjXaD1sLnUYCvnaT
         G2njI1Zo/Itf15KW1KdsP5s0efspLYYVPpS1GKosoyKY42cNY14d+h+RRW5a+2p9VRaw
         TCmP3MUr6CCYGkqWWq/smyaVdGsYQZvbwUyaOZYsX/wKitNG1FjfrZqv8AwCKJ1hArt3
         CRpTylyCzScPFOkACLG9cy78cVbr4RV9NMcIXXeLHVaTYmFJdq5JLXwJXv3kM3Pg/4Sm
         Olyxtf+k4eoccIU8FLKh+rBRgbTB65LBmP3nqfAkn5xT9cLBuu5xaXjWG4wwJaYxwptV
         ms8w==
X-Gm-Message-State: ACrzQf1TRY4VFqvvGs7KNRcxSYHWX1JZzGfPVXFvV/20ygLqoqdxfkE7
	0txk11lk6lmtMF0yYdvsRXK7VzbzxNef+jwjMBc=
X-Google-Smtp-Source: 
 AMsMyM7DdsYBmQZU9RD/HnTk8QGX+iYtzbTsbiAwmd6fTsYf/SCCoNYwtvjyVv3UChLCFAaEmNSb8g==
X-Received: by 2002:a05:6a00:88f:b0:558:8186:3ec3 with SMTP id
 q15-20020a056a00088f00b0055881863ec3mr8400420pfj.83.1664536792712;
        Fri, 30 Sep 2022 04:19:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 j13-20020a170902da8d00b0017887d6aa1dsm1646470plx.146.2022.09.30.04.19.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:19:52 -0700 (PDT)
Message-ID: <6336d0d8.170a0220.4f849.3258@mx.google.com>
Date: Fri, 30 Sep 2022 04:19:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-422-g411cd76b5afe8
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 35 runs,
 6 regressions (v5.10.145-cip17-422-g411cd76b5afe8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 11:19:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9580

cip-gitlab/ci/pavel/linux-test baseline-nfs: 35 runs, 6 regressions (v5.10.=
145-cip17-422-g411cd76b5afe8)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =

imx6dl-udoo      | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =

imx6q-udoo       | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-422-g411cd76b5afe8/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-422-g411cd76b5afe8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6336c6e9cbeb7344b6ec4edb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6336c6e9cbeb7344b=
6ec4edc
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6dl-udoo      | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6336d06c6b10b1f8eaec4f04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6336d06c6b10b1f8e=
aec4f05
        new failure (last pass: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6336d06d6b10b1f8eaec4f07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6336d06d6b10b1f8e=
aec4f08
        new failure (last pass: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:     https://kernelci.org/test/plan/id/6336c79292a68d4222ec4fbf

  Results:     83 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/6336c79392a68d4222ec5005
        failing since 142 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-09-30T10:39:58.616774  /lava-7459587/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/6336c79392a68d4222ec5006
        failing since 142 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-09-30T10:39:56.512843  <8>[   92.288035] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>
    2022-09-30T10:39:57.552714  /lava-7459587/1/../bin/lava-test-case
    2022-09-30T10:39:57.588857  <8>[   93.362454] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/6336c79392a68d4222ec5007
        failing since 142 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-09-30T10:39:56.476961  /lava-7459587/1/../bin/lava-test-case   =

 =20

