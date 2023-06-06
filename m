Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE66C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 14:51:50 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.460.1686063101031941764
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 07:51:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=aPofE5bc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso5631622a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686063100; x=1688655100;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd0GcqBiX33XCQLh1ONOoTn9yNgYKsHTwvnPtxURf9E=;
        b=aPofE5bcCqHr3F6kWNEy5t9hNnaUwUtNFAA+n2UwqazXfLLEIAfuUXq6ymScQKH61f
         cc1vtFJeEZA349HZvG82RPWqUB6thmP44TmknMnadlUb8CFTyRdjmdBE6m0LXr6CDRjm
         vR8wMWaGKfkiod1Jq6bgo8A317oM4T09PRAw6nrj/kQvJXG5nRaZJLzG+XUx+xxAtqDN
         ClWoqQYQPk321h+eBBoMBGddFWbfWKcfMsUt+Ih9+S1LJ1PR43fBQre+F/u+3D2fQWXZ
         jEuo8ivJu5Pk8dmfPx1Nb9NUNOfbuOmrGsZ1uE9wuVOW3kc3+N+qgHo1Y723yiVj0GGY
         Fi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063100; x=1688655100;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd0GcqBiX33XCQLh1ONOoTn9yNgYKsHTwvnPtxURf9E=;
        b=JbEJqpjJSK2wxhYgsuO0WgVCMiuf4rHh/Gq5FjEGS2nCOvhjH2ua2TVLUK3k4/L+SG
         4fAPd1kqjVW8BUzWZKRLRpGHvDF7OyM39E9cMcvsu20g7/lxZTn3ZrqQIpjefWZG0+IJ
         3yRKVG9Ls4HwvNK8/eqH6VrBZBiR53bHITO9smSzwnf5Zhjhy0jXwYAe1h0yrb1FKND1
         sXjgsqGGNRFJJWFbXKFXhjG3MyMYkhpC/XhxxxY4t2QO+tuim9Ym3CrrlBuTOFGJ59k+
         LuyHutAtvlWbgwSlPd8nqekCcmbqLu5o3Avmu68dvkDBCg2ZPUK2eWe3Peit8Xtwywsg
         qdzw==
X-Gm-Message-State: AC+VfDzSutRr1r56pcZeviDFZ1rD88KfxeMEcOeDiYiEdh0P7m7be6AD
	VspEJBVL9hQRGVitpL6HoMxqm+/ID0lD/fHKqjvbgA==
X-Google-Smtp-Source: ACHHUZ6EOX6CsBSw41qwFbhdTPEQmT19PQM3+zbZHnt+s9lNi6XWV+BgU0kW2XWhWda+LKIbfIa2jg==
X-Received: by 2002:a17:902:ceca:b0:19c:dbce:dce8 with SMTP id d10-20020a170902ceca00b0019cdbcedce8mr2491400plg.15.1686063099993;
        Tue, 06 Jun 2023 07:51:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b001a52974700dsm8661667plh.174.2023.06.06.07.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:51:39 -0700 (PDT)
Message-ID: <647f47fb.170a0220.5b8c9.ff60@mx.google.com>
Date: Tue, 06 Jun 2023 07:51:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip72-495-ga0a97337aff8d
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline: 67 runs,
 3 regressions (v4.4.302-cip72-495-ga0a97337aff8d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 14:51:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11894

cip/linux-4.4.y-cip baseline: 67 runs, 3 regressions (v4.4.302-cip72-495-ga=
0a97337aff8d)

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
/v4.4.302-cip72-495-ga0a97337aff8d/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-495-ga0a97337aff8d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0a97337aff8d76931b459e84792717c3bf6d6b4 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/647f3a7cb67f65ae48f5de51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f3a7cb67f65ae48f5d=
e52
        failing since 33 days (last pass: v4.4.302-cip72, first fail: v4.4.=
302-cip72-372-ga3bc58e64f55) =

 =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/647f3c245584e526d7f5de33

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/647f3c245584e526d7f5de60
        failing since 131 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-06-06T14:00:56.857277  ST

    2023-06-06T14:00:56.857593  =


    2023-06-06T14:00:56.862404  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-06T14:00:56.864111  FIRST, INC default to 1.

    2023-06-06T14:00:56.864361  =


    2023-06-06T14:00:56.867455  	-w	Pad to last with leading zeros

    2023-06-06T14:00:56.869855  	-s SEP	String separator

    2023-06-06T14:00:56.873164  /lava-10607166/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/647f3c245584e526d7f5de61
        failing since 131 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-06-06T14:00:56.844125  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-06T14:00:56.844369  =


    2023-06-06T14:00:56.856661  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  26.244720] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>
   =

 =20

