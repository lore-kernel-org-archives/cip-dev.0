Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FCAEE14B0
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 16:31:51 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.3419.1694017906153008750
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Sep 2023 09:31:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fC0eFnbp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bf1935f6c2so8582945ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Sep 2023 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694017905; x=1694622705; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=71OgbAGJqFgQUTSnynYX/c2BoZzMpgXKC4sK9ZVVuH4=;
        b=fC0eFnbpbDA0/9T6wHLJcJB+aYxg2/lJa6iUgY0Dl4ng6dR3QIdoEz4hiKc8phfY3f
         8kgCgwaRDlWqDK1oWZHNnUtLNvkj204DLTfbgqRxfo+mBaDueuG2ebLRJByEzWwm2EoS
         5m3TMLeQslSIszV/B8xXwJAuH+d+uyRLah34lrdjfhe9TCwoK79RnODMsgvwQhZ2ChcH
         WbLaVxrbvGok93kHNMzKoa7fhKscEmOIaf7Bwh5dIfptURpmWzqVE5PkT1aJyCv6+Iz7
         jwQ9W6dQfeT8uM6gr5lhJwWMdJ+uoyQNKskqu7AxDdbtfZ2iqAporCfwmA8F7eX3L4vy
         Pi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694017905; x=1694622705;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71OgbAGJqFgQUTSnynYX/c2BoZzMpgXKC4sK9ZVVuH4=;
        b=d27aBFmb+Z8Hr2rnf+hkal+mME6F2g9QcVPtzb3vpPpUWWb5cpbFEtjQbifgS/mHWR
         89g9BlSCpqE+XMXORseUhV6mG0lubivQxMrhx5VIS+9zoe58ScXpgGaOIrdZvAjBSP4u
         wfQ4lRjoEaeGkwqKZIWhE2ipwL5eSmj50vozEezlYNGSvWnYW0pWOPJKcS6LtSMYjKz5
         M2fekoG6EPsEa13HzFUYxBKPtMI/RmS8jI2BZ+CJBS/dyc8BSkU/rU4fEP2jfOfWa5Jn
         wQiOSZmY4Dbxlu4QcEYgkSEg0zn+eRltPudjpDL5atHKpDg+NvUvwKL3oSYPWdGKK3JW
         /2NQ==
X-Gm-Message-State: AOJu0YxVG1YkScJ7G+kmlsAtT/aEW+kFHBGQjv+91/7aPIpZNeiplJoi
	LacacvFAFQ/LEe9tPxssV6tAq2qgiy/AbB9xULFDdQ==
X-Google-Smtp-Source: AGHT+IFjYHbx3Kqxja8CAcJEsMFNOPpYWOND6sdGWOf1e9Fj2tQf3En9X/SkFoGTEC7Z3VMhiIZPGA==
X-Received: by 2002:a17:902:d4c5:b0:1c1:f3f7:50bc with SMTP id o5-20020a170902d4c500b001c1f3f750bcmr137087plg.26.1694017905109;
        Wed, 06 Sep 2023 09:31:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001b9de39905asm11275497pld.59.2023.09.06.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:31:44 -0700 (PDT)
Message-ID: <64f8a970.170a0220.8bbf7.8293@mx.google.com>
Date: Wed, 06 Sep 2023 09:31:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-831-g202f2689d81b
Subject: cip/linux-4.4.y-cip baseline: 67 runs,
 3 regressions (v4.4.302-cip72-831-g202f2689d81b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 16:31:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12997

cip/linux-4.4.y-cip baseline: 67 runs, 3 regressions (v4.4.302-cip72-831-g2=
02f2689d81b)

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
/v4.4.302-cip72-831-g202f2689d81b/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-831-g202f2689d81b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      202f2689d81b96b16bdc48aca2a2446568135a0c =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/64f8a2c3fbd9c76b46286d6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-831-g202f2689d81b/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-831-g202f2689d81b/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f8a2c3fbd9c76b46286=
d70
        failing since 126 days (last pass: v4.4.302-cip72, first fail: v4.4=
.302-cip72-372-ga3bc58e64f55) =

 =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/64f8a212f5a7c94849286df3

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-831-g202f2689d81b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-831-g202f2689d81b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64f8a212f5a7c94849286e2c
        failing since 223 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-09-06T16:01:15.567557  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.691518] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>

    2023-09-06T16:01:15.567805  ST

    2023-09-06T16:01:15.567859  =


    2023-09-06T16:01:15.572378  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-09-06T16:01:15.574800  FIRST, INC default to 1.

    2023-09-06T16:01:15.574862  =


    2023-09-06T16:01:15.578166  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64f8a212f5a7c94849286e2d
        failing since 223 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-09-06T16:01:15.523407  [   24.653385] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-09-06T16:01:15.555012  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-09-06T16:01:15.555254  =

   =

 =20

