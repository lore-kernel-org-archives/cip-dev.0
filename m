Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A199CC47DA2
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 10:43:00 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.16544.1705142576819089055
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 13 Jan 2024 02:42:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=cuW/8tMC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so6002570b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 13 Jan 2024 02:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705142576; x=1705747376; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cDHA16++r8iuxPzeP4wVtf+74jmyoxzIrP0DqoHGhe8=;
        b=cuW/8tMCtzam9xtUL6XH8Hgo7vvfyaFSAu7UQgHkHiweKrbmyLocxyzsFy6FKGQbM6
         1yq2L+JW6V1NWi/LGbm02iJh0Hwq+0OwQNv6NW1yxqcb8L6JpvRp2+d0iyLibPS5M5oA
         nGiUQHRAhxznA/rjmHdFMBxX3i0lu6qjIwPOac8weUyq7bXL8qnC/6jepmRE0mR+myVn
         MqBvBU8+lOeNZk9ljcno7IKqJKEb0ScWijJlvtJWqFfkHzBUOxEmexxllhCciLElRDOH
         LsN9f0nAaFKgK/pXH6OyqsYj9qWEnp+lFlRFB+tSAr5oRc6QJ/l7ehixE4s0hug4qz3E
         632A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705142576; x=1705747376;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDHA16++r8iuxPzeP4wVtf+74jmyoxzIrP0DqoHGhe8=;
        b=AP8xBpzXfuedRr0uM2gZMCy6P6jPQvYuvN9cBRVvYQF0HZdT4Gk8U8lqRxDLRfB+5c
         sG2pJ+EdsFMQhWgbFkfpuYHdq770jdwc7NRMSACqRe7o+yChYYEQ0sj+S6jLe3yN1ExR
         TnRuvc55vBi5m97jVm+5TjOVNGg5wJNG0hZtvO5/TMDEAOZB8+bDZ+nQzOeCKe91Fs9z
         hSL3LZCSoEeazuL0O6PSY9rY+NTskiHmTWi+kTsOVpmSdfQ6phqJdo/6dRMFzm1xr94e
         7MXC9DvbXClB+mJWowL8JXFV4DLTucvVW9bGIvFOb3IJS9TTtj8e4WgLeG/83DjMItdQ
         TPXw==
X-Gm-Message-State: AOJu0YycsC9iGpPqReBlcMqJxcwoXJ4Rn0YerFBlUwisif9tAEn1TJJg
	fnZBOOFya6ms74woOsmvxNzkALeT1H2eEofPodG570dhjXM=
X-Google-Smtp-Source: AGHT+IGkmkFM/Y2RMl2/ZkWgAR4U0wl2Chngy2VTdqjwPHE1QcatlwBAeDK2rxLW35LK/jGe3VSlfg==
X-Received: by 2002:a05:6a00:b4c:b0:6d9:b075:a7d6 with SMTP id p12-20020a056a000b4c00b006d9b075a7d6mr3096314pfo.19.1705142575849;
        Sat, 13 Jan 2024 02:42:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056a002fcc00b006d9af7f09easm4510963pfb.29.2024.01.13.02.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 02:42:55 -0800 (PST)
Message-ID: <65a2692f.050a0220.1ebd4.ea18@mx.google.com>
Date: Sat, 13 Jan 2024 02:42:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.304-cip106
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 48 runs,
 3 regressions (v4.19.304-cip106)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 10:43:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14372

cip/linux-4.19.y-cip baseline-nfs: 48 runs, 3 regressions (v4.19.304-cip106)

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
l/v4.19.304-cip106/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6617f4528449a329abd3b2dab36052b341610d99 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/65a262377d0512b32852a412

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20e=
k.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20e=
k.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a262377d0512b32852a447
        failing since 106 days (last pass: v4.19.287-cip100, first fail: v4=
.19.295-cip103)

    2024-01-13T10:12:27.342803  + set +x<8><LAVA_SIGNAL_ENDRUN 0_dmesg 4551=
67_1.6.2.4.1>
    2024-01-13T10:12:27.495492  #
    2024-01-13T10:12:27.598612  / # #export SHELL=3D/bin/sh
    2024-01-13T10:12:27.599404  =

    2024-01-13T10:12:27.701310  / # export SHELL=3D/bin/sh. /lava-455167/en=
vironment
    2024-01-13T10:12:27.702081  =

    2024-01-13T10:12:27.804247  / # . /lava-455167/environment/lava-455167/=
bin/lava-test-runner /lava-455167/1
    2024-01-13T10:12:27.805688  =

    2024-01-13T10:12:27.809128  / # /lava-455167/bin/lava-test-runner /lava=
-455167/1
    2024-01-13T10:12:28.173070  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65a2607fc6195af32a52a3f1

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65a2607fc6195af32a52a3fb
        failing since 297 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2024-01-13T10:05:33.707581  <8>[   40.379482] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-01-13T10:05:34.744007  /lava-12522723/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65a2607fc6195af32a52a3fc
        failing since 297 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2024-01-13T10:05:33.678396  /lava-12522723/1/../bin/lava-test-case
   =

 =20

