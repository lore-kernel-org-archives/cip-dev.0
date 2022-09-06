Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BE0ECAAD3
	for <webhook@archiver.kernel.org>; Tue,  6 Sep 2022 01:09:16 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web12.32129.1662426554476089450
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Sep 2022 18:09:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=cGsjm6nw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id 9so6587402plj.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Sep 2022 18:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=WNpcK2H7Fb8GAv1Wi13Q4BOMRpEGtpL4axk1sVsrz6g=;
        b=cGsjm6nwrD/v8c+gYSx32iRFj/gKNrcvKVFeWU3R4rQ/6ubEHNGf5EGpv9M8S3ZIKN
         +ZfBqnL0FXfmaTv+cJhuFMVv6hm9TKk8YzftoSOnsQdy1bJtyaOCv4yw8f814XvOHHEe
         FFEzhgFfJQ5U0dZfNWITIOGGzlv4nwO7qdHT2WXG2od+YsbyAkcEQKZzSNJIu8ICLscD
         0M9+qsInwLO0k0GZly1xTcmVWd7FBlurHO/24+FlHaDOC/KbL9mWxf80/I6HpFLJVhg+
         lrrEKucAA79Q+nAbYWa/+Y/5kc9r5/GWKccCzp9bEPPzrLwR0Hek8aYjMvOIFJZDwoek
         LBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=WNpcK2H7Fb8GAv1Wi13Q4BOMRpEGtpL4axk1sVsrz6g=;
        b=iKkrZk9Hi69B5iMwt9mTDVhp9RWpWou6yuJ+F7L6gLFSSjqOq4W/afDnt8lvPy684X
         Vw2DMTx6ZXtGFBvbNSpACBzNzMi5gY3MYk2oxGdl6pbygsaX2GGAsVjuKrcyjPSg/Eyj
         IjsnP1qplIRC49QgUHgVzQGb77YS3y52pEFvLMt9t9cTVmHL3fDi7/e/+8f/pj3Wn8fb
         uBw1RHwqlPIuL0K8N7SwYqJUZuHaxCv3Xbd7q+/ciugjdwuRDR+ZlX6bSC7fNPiQP5co
         TYlDAiWCpn2yStoLvJuhOGXdvdRflW9L1q3vuJH+gndaZXqEeBtrzro668+rY+b3xze+
         roEw==
X-Gm-Message-State: ACgBeo2bSbvDjrvoLGl4CzZPaSQug0KU1oUpDHoVpOic8RaPbYgebPb9
	ndJqV4PAzMPeyH9IB+Mvc//Kz2HkFJvbM3DoEd8=
X-Google-Smtp-Source: 
 AA6agR6PXGCTpKNNWhcJEIPXsXDjwg+vyNBOi0+hQk3JYUnZIiiX+4mW3vwwicrTtO+/EsGGd7QcTA==
X-Received: by 2002:a17:902:ec8c:b0:175:14e5:9ab7 with SMTP id
 x12-20020a170902ec8c00b0017514e59ab7mr33102257plg.141.1662426553574;
        Mon, 05 Sep 2022 18:09:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 lx8-20020a17090b4b0800b002002014039asm5369498pjb.6.2022.09.05.18.09.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 18:09:13 -0700 (PDT)
Message-ID: <63169db9.170a0220.6128f.72b9@mx.google.com>
Date: Mon, 05 Sep 2022 18:09:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-10-g52cbd8ad1543e
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 37 runs,
 4 regressions (v5.10.138-cip15-10-g52cbd8ad1543e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Sep 2022 01:09:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9461

cip-gitlab/ci/pavel/linux-test baseline-nfs: 37 runs, 4 regressions (v5.10.=
138-cip15-10-g52cbd8ad1543e)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.138-cip15-10-g52cbd8ad1543e/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.138-cip15-10-g52cbd8ad1543e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52cbd8ad1543e12ef69b428c8535df3b2e60fa86 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/63169d03d1bc93d465355647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63169d03d1bc93d46=
5355648
        failing since 24 days (last pass: v4.4-st20-96-g74ff989472f09, firs=
t fail: v5.10.131-cip13-35-gab58aa0904675) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:     https://kernelci.org/test/plan/id/631696825ff979115e355685

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/631696825ff979115e3556cc
        failing since 118 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-09-06T00:38:09.838016  <8>[   93.701436] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>
    2022-09-06T00:38:10.885097  /lava-7195578/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/631696825ff979115e3556cd
        failing since 118 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-09-06T00:38:09.800034  /lava-7195578/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/631696825ff979115e3556ce
        failing since 118 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-09-06T00:38:08.731339  /lava-7195578/1/../bin/lava-test-case
    2022-09-06T00:38:08.763624  <8>[   92.628885] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

