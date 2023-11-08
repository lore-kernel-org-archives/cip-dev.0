Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EDC04FDE
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 13:00:56 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.12921.1699448447297711364
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 08 Nov 2023 05:00:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vn4ZlkcK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1cc2f17ab26so51349375ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 08 Nov 2023 05:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699448446; x=1700053246; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jSs7AXzkB5aCroo9VO4u9rgGsnHHoYM8SXskKEPsAPM=;
        b=vn4ZlkcK2kfps0m2HtlHCPVGQ5yHG44he9kg2LcNxaZCkDgFCzkY3bYSO8VWBmq202
         QU9fRNQL3PaTqQ4De3GfE+K4evWrjLaw1e7W7KZF85gKz5DkpdcDOnkOAp/fswGe8QOH
         qNWqMjm0qpmA1bhn4O9+F149NGBNfXE4vprzcGNg4ztAvFK3LST0c+J+7WI2usRKBBEk
         qwIxMz1fBJEOdBy1d8OgKAKxnEEdnY4UOPmY6zwogMPNTCgyt1UOWfWFP5lcY5B7iDzF
         kzYxU3vO7YFMeQ2ve/UHty2cnzEp+05fYIvx+FrJQa1CUd0/hXlMFzAd0hfjOjsQ3MZP
         Yo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699448446; x=1700053246;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSs7AXzkB5aCroo9VO4u9rgGsnHHoYM8SXskKEPsAPM=;
        b=Jvk6cUWHqXEEp7KvkWNaezTO01BPhnEVcrTmJv1BE1E8SEq38tZe9IqwoO2KzxINIq
         pVEO8bC6D4Q5kAgMQQBgGmqC2OCCyjVVtpX2QaxPZXJlxhO0rDRnxaptwYbWc9pmGEvC
         K4xEmboQTAsuwY8k7T0MmpSpI3192KXX124mqRfUGRhM1WRDbu4MRVhaqKk5yD1GeTeG
         r6QvRJdlJqGCzSy8RBNLPfVSOIBRKboHeiXJLC5tSXLza/wUNPcZ9HXAPwPmjrKVQFRz
         UCjS3Iu5GVIwRGw+mk9BKM6AD/FLOJFJ1B6vRL7N39nTutL42z0i/qYut0Sj2xol+OlE
         h9og==
X-Gm-Message-State: AOJu0YzmCK3OCeCovj+QGx6Ypml6DhKx/EcprjYivvhQPH0QAXzwbtSH
	9GkYqnu1VZV6od0ecIEXGqrF/SNI0+kTA4QgsHTO3w==
X-Google-Smtp-Source: AGHT+IEaxIUxuhBFsGl1/A8S3lDVarJQ/oDAp8mITZsuneRNK4he/W5IdvFLHd62phPQv7BkUQ2sqg==
X-Received: by 2002:a17:902:ab0f:b0:1cc:dda:9a1b with SMTP id ik15-20020a170902ab0f00b001cc0dda9a1bmr1631489plb.34.1699448446273;
        Wed, 08 Nov 2023 05:00:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b001cc50c5699asm1674560plf.301.2023.11.08.05.00.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 05:00:45 -0800 (PST)
Message-ID: <654b867d.170a0220.3d392.4a5a@mx.google.com>
Date: Wed, 08 Nov 2023 05:00:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297-cip104-63-ge7301d2e196ae
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 43 runs,
 2 regressions (v4.19.297-cip104-63-ge7301d2e196ae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Nov 2023 13:00:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13541

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 43 runs, 2 regress=
ions (v4.19.297-cip104-63-ge7301d2e196ae)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig           | regre=
ssions
--------------+------+-------------+----------+---------------------+------=
------
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1    =
      =

imx6dl-udoo   | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.297-cip104-63-ge7301d2e196ae/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.297-cip104-63-ge7301d2e196ae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e7301d2e196ae60b103ce909a0740547e15c30ea =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig           | regre=
ssions
--------------+------+-------------+----------+---------------------+------=
------
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/654b793db6b7084c2defcf03

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-63-ge7301d2e196ae/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-63-ge7301d2e196ae/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654b793db6b7084c2defcf39
        failing since 28 days (last pass: v4.19.284-cip99-114-g02e97826987b=
f, first fail: v4.19.295-cip103-95-ge42cfc8bb88b7)

    2023-11-08T12:03:38.659486  + set +x<8><LAVA_SIGNAL_ENDRUN 0_dmesg 2260=
83_1.6.2.4.1>
    2023-11-08T12:03:38.835133  #
    2023-11-08T12:03:38.938276  / # #export SHELL=3D/bin/sh
    2023-11-08T12:03:38.939045  =

    2023-11-08T12:03:39.041004  / # export SHELL=3D/bin/sh. /lava-226083/en=
vironment
    2023-11-08T12:03:39.041777  =

    2023-11-08T12:03:39.143860  / # . /lava-226083/environment/lava-226083/=
bin/lava-test-runner /lava-226083/1
    2023-11-08T12:03:39.145130  =

    2023-11-08T12:03:39.148661  / # /lava-226083/bin/lava-test-runner /lava=
-226083/1
    2023-11-08T12:03:39.512136  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform      | arch | lab         | compiler | defconfig           | regre=
ssions
--------------+------+-------------+----------+---------------------+------=
------
imx6dl-udoo   | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/654b7be7e13ad17a9befcf3a

  Results:     28 PASS, 5 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-63-ge7301d2e196ae/arm/imx_v6_v7_defconfig/gcc=
-10/lab-broonie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-63-ge7301d2e196ae/arm/imx_v6_v7_defconfig/gcc=
-10/lab-broonie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card-probed: https://kernelci.org/test/case/i=
d/654b7be7e13ad17a9befcf48
        new failure (last pass: v4.19.295-cip103-193-g33550555e507c)

    2023-11-08T12:15:17.902164  /lava-226121/1/../bin/lava-test-case
    2023-11-08T12:15:17.968078  <8>[   31.899184] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =20

