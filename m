Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E88C4707B
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 08:13:13 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.13463.1704269583598279091
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Jan 2024 00:13:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2j/KeA4N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso2877275a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 Jan 2024 00:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704269582; x=1704874382; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj4UpEFDV7sdZVlJ4iqEGXqYpO9jpml+YOe+Ey9njuQ=;
        b=2j/KeA4Nnaia/4HKn0E9Ey4rNZNQcGNXJqIhjkMVc+yEcJI+YCklBBN2PARbB/SRXx
         MyeTJQZGJZaAlcRVZnmX8O44ap8v4mw6okoyJNYuaC1NmYqtTFlVlbK8mYrf9ouojV6H
         3HfY+Wdb6aQYDqb1eUu8VgoUGSi7qBb2tkDUaSHy/Fav3Ij3IsrWeWbrdfxsIhyAIQKT
         qamqXf89JCq5Nwn0ARlTFQJTXIBLNNuJ6FqlCXbnZzZeQocFC3mrahhMDfhthEJatM5U
         Q+HfYUArTtcUjfO9liaZawq/f9inNtIAw+kUEcgIt0vyqLKNUNznBYPo2M1nrQwlj26X
         jHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704269582; x=1704874382;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zj4UpEFDV7sdZVlJ4iqEGXqYpO9jpml+YOe+Ey9njuQ=;
        b=l4i2YRLhYObhiazW5qpa9fWiv0IzlhFXZMUeiMH7jcr0OymKAcqlCv66vEShXlZtOp
         gS04JdIe1bwi/ZiPtEyWua7SJpXhY7ULAt6AQ3HkcJ3wPqFjSHTw84ed444ide1qrVCK
         c5MYW3kkZxfvWM16pFg1KDiiPY7+UN5I9er5cSZMtv79vg89KWqvhkDPKDFL1PrAjjif
         8cRMmKSXTNJ2r9JneVRnyXOeN0OFrVcs4QmdgB/qKCEDlEWSmC3lkVm+X2GdxB/q/YF5
         Z20tjGi/q55SSM6ZlaRiJsykGoBO+dzb6fFRZEvFfXOmxI/hJ9/ksySUwBeDysQTG75q
         Qfwg==
X-Gm-Message-State: AOJu0YyQVK5eIxATiTeeErA8bf9h276Hmcge9hV7dhIl/Gi6EF8JaFd8
	fPJFvIIArHf8dipCR8+G2eSz5lPHuRLC73pYH4lcrFtT+IY=
X-Google-Smtp-Source: AGHT+IEVOef6OkyzbwDev2rJacuos4OAjCek1HgsxLJO4nTXAUx2QVN6qGs9vex7CjVpcjBpJopjnw==
X-Received: by 2002:a05:6a20:734e:b0:197:4ccb:1c0d with SMTP id v14-20020a056a20734e00b001974ccb1c0dmr1493530pzc.87.1704269582164;
        Wed, 03 Jan 2024 00:13:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja22-20020a170902efd600b001d078445059sm23403733plb.143.2024.01.03.00.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 00:13:01 -0800 (PST)
Message-ID: <6595170d.170a0220.9e826.386e@mx.google.com>
Date: Wed, 03 Jan 2024 00:13:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1224-ga0ac575eeff8
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline: 63 runs,
 2 regressions (v4.4.302-cip72-1224-ga0ac575eeff8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 08:13:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14240

cip/linux-4.4.y-cip baseline: 63 runs, 2 regressions (v4.4.302-cip72-1224-g=
a0ac575eeff8)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1224-ga0ac575eeff8/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1224-ga0ac575eeff8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0ac575eeff89882d3aa16d67979a86e668f5d1d =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/6595101b3b0677559077b597

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6595101b3b0677559077b5c4
        failing since 342 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2024-01-03T07:50:28.914387  ST

    2024-01-03T07:50:28.914439  =


    2024-01-03T07:50:28.919015  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-01-03T07:50:28.921091  FIRST, INC default to 1.

    2024-01-03T07:50:28.921146  =


    2024-01-03T07:50:28.924339  	-w	Pad to last with leading zeros

    2024-01-03T07:50:28.933509  	-s SE[   24.546597] <LAVA_SIGNAL_TESTCASE =
TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6595101b3b0677559077b5c5
        failing since 342 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2024-01-03T07:50:28.901352  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-01-03T07:50:28.901527  =


    2024-01-03T07:50:28.913956  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.525549] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>
   =

 =20

