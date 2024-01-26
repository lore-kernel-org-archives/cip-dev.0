Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F073BC47422
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 06:18:39 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.10006.1706249911437576797
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 25 Jan 2024 22:18:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kgN/ez8G;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so1007469b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 25 Jan 2024 22:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706249910; x=1706854710; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ITglA6SgtVPQrMkxyBXTN7CpXipqkkoUPcuPCy2BNP8=;
        b=kgN/ez8Gr5c6ubS7fj1oz834PNC5RblDFErpcQfXVIvIJ/2DHSYlKIR14UTgqje998
         uPFqfz2PXhfIEpX5VFwvOULPogcSZihaBMIRwbFCe4NiNPe6fZLBoR326dK52uEKVQEk
         GzyivCi6qN4viCKjjjyfXfT99l1toJstZj3mycZbtUL3jqu91WNni8F/0PAc7gaxY7UQ
         +1hEDzeac6tOGghCtSupyFvODIYc1YX98D9hayrunAuEpiSMyx8J3jErB2yNUwJ4RT//
         LxjCdZjbz6eiTb0H+T/gBKr7NfClbtJt9IhuvXQBuIfjdo9VrLo5bG9cK+YAsptz3v0O
         dlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706249910; x=1706854710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITglA6SgtVPQrMkxyBXTN7CpXipqkkoUPcuPCy2BNP8=;
        b=PVh+CBRYy/jjx3P42WvSsI4Hu6qY6BK37E8GbpMdpm4Qw68H3BXFLQXQmy1A+w9L6y
         1geRRnoTHypFKARdvGx3a4lZPOXQ8+WUJ1Llu5d5VR1mkgld1wPh5YAV6etWOAtTPGlS
         YMHEaOxH83DVv0aGImhgotRfyhkbjmPVQW5nk1LNF3vewiHSr5PfFcbTkW6PdXjbCR2A
         YtGatsHXXYXmBJMxrXY8mEnM+8Mpyl7hAL97m5+Y7OiICksaNC5trTzO5Yw/lEd09tLS
         GqUrtyHD48KgIr9Iv4iPpMvu7cK0AzlDskO746XQurRojM4uI9DuCS9tHGcHEcie8YTl
         o2xQ==
X-Gm-Message-State: AOJu0YzdWCwMHexJukrq+V4wO1sv9wWnYfvtz6O9Sqmc8Az8sWsQjNPj
	43BiAgBvCu6m0c6LHk4g/dSh8WTFjrLKKFa7XR9TQsLs3n54kwZDFaGxErAs3qaER1/Z92xAl6K
	y20s=
X-Google-Smtp-Source: AGHT+IGUBlEbN4x5itnihfPJrN+jkflRzKzUgORjVRB4NtnG3kF1IXjVswCnchoqM291/uI7wNfQTw==
X-Received: by 2002:a05:6a20:c886:b0:19c:68c1:d580 with SMTP id hb6-20020a056a20c88600b0019c68c1d580mr567038pzb.45.1706249910143;
        Thu, 25 Jan 2024 22:18:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s20-20020a056a00195400b006dbe42b8f75sm459164pfk.220.2024.01.25.22.18.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 22:18:29 -0800 (PST)
Message-ID: <65b34eb5.050a0220.86ebb.13bb@mx.google.com>
Date: Thu, 25 Jan 2024 22:18:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.304-cip106-176-g770d0422c72e9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 102 runs,
 3 regressions (v4.19.304-cip106-176-g770d0422c72e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jan 2024 06:18:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14464

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 102 runs, 3 regression=
s (v4.19.304-cip106-176-g770d0422c72e9)

Regressions Summary
-------------------

platform          | arch | lab         | compiler | defconfig          | re=
gressions
------------------+------+-------------+----------+--------------------+---=
---------
at91sam9g20ek     | arm  | lab-broonie | gcc-10   | at91_dt_defconfig  | 2 =
         =

r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.304-cip106-176-g770d0422c72e9/plan/baseli=
ne/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.304-cip106-176-g770d0422c72e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      770d0422c72e9acab17684ec2bbff7bc9a09b1a4 =



Test Regressions
---------------- =



platform          | arch | lab         | compiler | defconfig          | re=
gressions
------------------+------+-------------+----------+--------------------+---=
---------
at91sam9g20ek     | arm  | lab-broonie | gcc-10   | at91_dt_defconfig  | 2 =
         =


  Details:     https://kernelci.org/test/plan/id/65b33d01d9a6206a5a52a406

  Results:     42 PASS, 8 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/at91_dt_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/at91_dt_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65b33d01d=
9a6206a5a52a415
        new failure (last pass: v4.19.304-cip106-27-gf3e967c370d44)

    2024-01-26T05:02:38.231809  /lava-511308/1/../bin/lava-test-case
    2024-01-26T05:02:38.266440  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
b33d01d9a6206a5a52a416
        new failure (last pass: v4.19.304-cip106-27-gf3e967c370d44)

    2024-01-26T05:02:37.145966  /lava-511308/1/../bin/lava-test-case
    2024-01-26T05:02:37.181132  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform          | arch | lab         | compiler | defconfig          | re=
gressions
------------------+------+-------------+----------+--------------------+---=
---------
r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65b3469dfb96f0da9352a422

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65b3469dfb96f0da9352a=
423
        new failure (last pass: v4.19.304-cip106-27-gf3e967c370d44) =

 =20

