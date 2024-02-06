Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257A0C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 23:11:17 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.7722.1707261068124888030
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 15:11:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2L9pAQCV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2909a632e40so14911a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 15:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707261067; x=1707865867; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h099m1RM8vCTLbL3BJ+0yo9OpSBS2SZgZUqSvcylS7g=;
        b=2L9pAQCVQWRgHRwUpfVvsTDZy+cHcux16ZNNv07TDgm1DKGFlmfH/KH/E/FHS9+F1k
         DfzsXcbZDEZ1P4nHsbsZ0SQbfIL/0N1Vt2m7V6SKndlfxAMJsLqsmYZx9Mp8G02u11P4
         t+p+4cPqpOmKL6noOyQ7V7xeB0INa+g3aTZQdK+r4rQfONOfkqI8t8STGMNlfMO1dyzh
         nFtcBP/QTRKDzxxH5SjXIO/LjnJrrUxyh7xX7E8Vcn0ISLUsZlqJabn55lrFD0Gjir2O
         CikFysOn86/VmUVk2tm048RzS1QU3o6WQCG3ul50ypKMWXowF9q1o5eEwtNoFAE3zXyM
         KROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261067; x=1707865867;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h099m1RM8vCTLbL3BJ+0yo9OpSBS2SZgZUqSvcylS7g=;
        b=jchbxRZg2d0g83ZgTxssplQgCN2Xu142Y3jJ0it5nmOmfCxHLg75ijCRMs16IRUAqW
         +uiWjRd72f/8bdlKFbZmN7/jaCJk7T2OAn+lrO17UfNcoAv4MyFpoakWoqp8PrMV/4RO
         Av8mWVFzixodKju3HT+qRMfiVPuqh448iYr1nnvN9GDVFcvsnab9jAKy4j/iZejcVoI9
         Lt+8Iugdm8T/kKGUWpREt359HpR3bAtJEFu4i4VJbtLmOkIJzPzzf2VxvrdLAzIlPeBF
         1vVBirySSpytjoG1PRHYz9rG5wtbBPJEUwY3OrLylCPSenW8YyHqaVeWwQsJzfHiaSjh
         dK6g==
X-Gm-Message-State: AOJu0YxiyGxRnFN21QwKD2h1KPT+Jln58ewefIJ3ZJ0xgT46CP1zRDX4
	Go0wvm2jH5an8NDOokQKsqj5Luq+xJJakYHH6j2gnPGR8rUdLXRNtWQ5zyTH5Za8j123j0DYP6w
	e
X-Google-Smtp-Source: AGHT+IHHH6K9oCUzusA+Lh+yxrYhBYF7T/MlLBZhaf20vAANzSQkjmDRZ/dQNnPEjIahlceGChNPUg==
X-Received: by 2002:a17:90a:fb87:b0:290:9e9e:a87e with SMTP id cp7-20020a17090afb8700b002909e9ea87emr998128pjb.42.1707261067203;
        Tue, 06 Feb 2024 15:11:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6RpkppCAxkEgIUDxDGTKcurAcVY3nZ5G7+/kFvYLNPjFM45XRTZLqFGMu3hsjnCvKGiJznRRlYcO4l7iS7YAZPvP1mtVBYHa5yQkTbE6tsCLikxtgvarkogwQmrKs13Z3qzqOLxspH0vwHwEL+4N1Yw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sj6-20020a17090b2d8600b00296b42b8501sm79396pjb.12.2024.02.06.15.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:11:05 -0800 (PST)
Message-ID: <65c2bc89.170a0220.e5fd9.05d6@mx.google.com>
Date: Tue, 06 Feb 2024 15:11:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-2-g5723c66be3b0
Subject: cip/linux-4.19.y-cip baseline-nfs: 53 runs,
 3 regressions (v4.19.304-cip106-2-g5723c66be3b0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 23:11:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14842

cip/linux-4.19.y-cip baseline-nfs: 53 runs, 3 regressions (v4.19.304-cip106=
-2-g5723c66be3b0)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-2-g5723c66be3b0/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-2-g5723c66be3b0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5723c66be3b09629fae4fec9711e11f0d020e81a =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b50f08133f83ca8e1e79

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2b50f08133f83ca8e1eab
        failing since 130 days (last pass: v4.19.287-cip100, first fail: v4=
.19.295-cip103)

    2024-02-06T22:38:32.963554  + set +x
    2024-02-06T22:38:32.963876  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 550419_1.6.2=
.4.1>
    2024-02-06T22:38:33.081370  #
    2024-02-06T22:38:33.184243  / # #export SHELL=3D/bin/sh
    2024-02-06T22:38:33.185053  =

    2024-02-06T22:38:33.287124  / # export SHELL=3D/bin/sh. /lava-550419/en=
vironment
    2024-02-06T22:38:33.287915  =

    2024-02-06T22:38:33.390071  / # . /lava-550419/environment/lava-550419/=
bin/lava-test-runner /lava-550419/1
    2024-02-06T22:38:33.391456  =

    2024-02-06T22:38:33.395201  / # /lava-550419/bin/lava-test-runner /lava=
-550419/1 =

    ... (12 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65c2b53dff64e544538e1e7f

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65c2b53dff64e544538e1e85
        failing since 321 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2024-02-06T22:39:40.890391  <8>[   38.675869] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-02-06T22:39:41.921030  /lava-12709818/1/../bin/lava-test-case

    2024-02-06T22:39:41.940316  <8>[   39.726241] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65c2b53dff64e544538e1e86
        failing since 321 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2024-02-06T22:39:40.869384  /lava-12709818/1/../bin/lava-test-case
   =

 =20

