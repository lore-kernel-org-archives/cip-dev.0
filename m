Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A895AC77B7F
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 15:22:30 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.22720.1683127347597167156
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 08:22:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0RAbVYi5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6436e004954so99221b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683127347; x=1685719347;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=05qFGdNSX+ufUJDS1+q7/P6gGKOdGDbN/mmVRep/E+w=;
        b=0RAbVYi5Zp3J5ZcBp1QahDhofXqE5vVF6yo6kufXOcTDk1xzZRA3V2sRZz7Hyo3P8i
         yv0IozMJW9Gb3a0qcGtF3x6WmmOXZEOoqCvkr+nfmdY88mWm9z56kv9hm4ayz9e2y3cu
         NBevRzA5Esd5985KElYTa94qFAV1Z023EzjKa7aBNRgTcoyjy+TlCiMljXtcFzaS3qQh
         mrM6dT1BdqjEpdfVy9xpTzKteX0XXq7UOUIomUvmTBREOMUdPo9LwlNfnW+2trFy8rHm
         YrjyaZMnJfUzCxmExbrd06srDfsnZ9MC31kiNOOEpQ+fbmsmoLD48XcAxB5JzV0GTEYQ
         uSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683127347; x=1685719347;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05qFGdNSX+ufUJDS1+q7/P6gGKOdGDbN/mmVRep/E+w=;
        b=Foj9R4R1AdCBpKirSL3H0TC9r4J68/ByuoPdy7CknScb/TQ7Cim7A84lNlU4bJlMXd
         MZJEF2Ty+C+oZTtq/Fh3eFmAlaYBH+NayDODGLSdfHr7fLa1qGxtW4o4XE/fiZNxbpvP
         5MN7M2hZjPixSt0x5X19Y7MbQGEOEVbcLOoZw39Xndhr2vl6qn9uFayjWVMwDk1nzGpl
         tPYD5iJYW7NwGy2aMFcCrHp4gYGZawLPIoEVAWQlOglhQIYmjDC5GMTcUHs2RJXBjoQC
         gcMFw1SINHIexhS80p10YaQt4t3ZonAZLklC3L250OaQldg6XkL88cI1TCuJU4qIlEvs
         kDhw==
X-Gm-Message-State: AC+VfDzbsHk/gg56rVxPx1ni6xh5/WbkLA1md4uYHn1/mPbnQKZNBeLd
	CYtlY2LIyAKLIlFlfAOdLfjqzVcFJiYaixbFwQwHbA==
X-Google-Smtp-Source: ACHHUZ5Xdah/k4LqWtSxoqu/cU084Qu6KcqvIGPiPdjUUXLODgpDs6gQwfN/w6lPq8ko/KWOb1dJgQ==
X-Received: by 2002:a05:6a20:a121:b0:f6:15f3:ca36 with SMTP id q33-20020a056a20a12100b000f615f3ca36mr29120997pzk.50.1683127346747;
        Wed, 03 May 2023 08:22:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u22-20020a634556000000b005287b22ea8esm12388324pgk.88.2023.05.03.08.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:22:26 -0700 (PDT)
Message-ID: <64527c32.630a0220.2dbf3.9460@mx.google.com>
Date: Wed, 03 May 2023 08:22:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.302-cip72-372-ga3bc58e64f55
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip baseline: 57 runs,
 3 regressions (v4.4.302-cip72-372-ga3bc58e64f55)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 15:22:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11404

cip/linux-4.4.y-cip baseline: 57 runs, 3 regressions (v4.4.302-cip72-372-ga=
3bc58e64f55)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =

rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-372-ga3bc58e64f55/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-372-ga3bc58e64f55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a3bc58e64f55aa72a4c70a5e27ee369c025756dd =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/645275d6e814e9f8862e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645275d6e814e9f8862e8=
5f4
        new failure (last pass: v4.4.302-cip72) =

 =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/6452756ba8b343fe162e85ed

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6452756ba8b343fe162e8616
        failing since 97 days (last pass: v4.4.302-cip71-1-g61333eee4869, f=
irst fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-05-03T14:53:03.221719  [   24.575704] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-05-03T14:53:03.262838  BusyBox v1.31.1 (2023-04-21 13:14:56 UTC) m=
ulti-call binary.

    2023-05-03T14:53:03.263162  =


    2023-05-03T14:53:03.266813  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-03T14:53:03.267043  =


    2023-05-03T14:53:03.271573  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6452756ba8b343fe162e8617
        failing since 97 days (last pass: v4.4.302-cip71-1-g61333eee4869, f=
irst fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-05-03T14:53:03.140457  [   24.495575] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-05-03T14:53:03.181617  BusyBox v1.31.1 (2023-04-21 13:14:56 UTC) m=
ulti-call binary.

    2023-05-03T14:53:03.181776  =


    2023-05-03T14:53:03.185798  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-03T14:53:03.186032  =


    2023-05-03T14:53:03.190525  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-05-03T14:53:03.192735  FIRST, INC default to 1.

    2023-05-03T14:53:03.192961  =


    2023-05-03T14:53:03.196084  	-w	Pad to last with leading zeros

    2023-05-03T14:53:03.198240  	-s SEP	String separator
 =

    ... (1 line(s) more)  =

 =20

