Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3EC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:52:40 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.27862.1702572753243225850
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:52:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=eC65cMyv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c21e185df5so7183162a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702572752; x=1703177552; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nXbCTKFoS377VrQU2B32GSEeFFn78I1LYYbH2czWodQ=;
        b=eC65cMyv1QWGHsTA3YSIwWBkJERK3Ccs5HQcJeHc8LWUSWp/nYy4XycZ7dAu4C9ASF
         S3rEAI9II/VUxH8Cb0NxzkbaakqKsWqET8W4P3Pnp/Ht7Rqr0/YrXd0gvr9uqBfEnHtC
         g6CjL2iubqDGGOUcgr9LfNVhvn0SVxNn57BX9Xz7CYrlkkjzuPloyfSjzbcSWYhLcs5F
         +QVQLpqSaE2ljDQCVUofQtxwx4qbJFVqTXXe4S6ByuEV+bq9NTdwaOMIgobId0E+QX5X
         lAxoN2Gm071gHUZ6hoaB3qXnMiYV8v42jwyHlbRkbve/i0rQBZ3FGf12UCKiqQWR16Xy
         QJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572752; x=1703177552;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXbCTKFoS377VrQU2B32GSEeFFn78I1LYYbH2czWodQ=;
        b=mN0BdBfabOKEUaVg7rzQ/j2G7l2ADOdEUqxOL49nPBlEwkU6iHZbW2XZwOXGKKYTFG
         D2yn6mBQLDJLxwbuF2/I+VAO8ryQ7Gokf2iiklqOvlrZk2MfSGgn91te1f44oJi3Xwun
         KxMoJobR4aPRSEQHAMFf3EvGWAEALUiiUSvDCyMWJq7mTA/zKqIctBoMSI6OlelKUC02
         GCeq0nrKiwmYCHwOrONGf+5tnWeXVvIj7WEbwPZW5WAFqdx6hQ5UTP2kyWCtKffCVZ+A
         J0Tfsap9Zt7Kohk0ilY1Dcc0Wz2tcOng3LsmYRKwzLTzV21Gx5O7nFZ7cptu7GCG5AdZ
         dBVw==
X-Gm-Message-State: AOJu0YzgTBcMDuZ8doJkLkV5S7vqjTHCbeUIUF7FDOLhM5rlzFJcuv8J
	IguaQZTfHY0LcU0iF3rsIwaGOJ4ypf8iKIQRdJM=
X-Google-Smtp-Source: AGHT+IHwipzlWtwGDHvWkLh0hB//SoBIJB1XO34b7Qn5ywIhMOr7++2YUwLekMoarXAlkp788sT3KQ==
X-Received: by 2002:a05:6a20:1390:b0:18f:97c:9780 with SMTP id hn16-20020a056a20139000b0018f097c9780mr10009661pzc.104.1702572752109;
        Thu, 14 Dec 2023 08:52:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b006c4d2479bf8sm12010064pff.51.2023.12.14.08.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:52:31 -0800 (PST)
Message-ID: <657b32cf.a70a0220.f4765.62b0@mx.google.com>
Date: Thu, 14 Dec 2023 08:52:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-1-g2d3d776d703d7
Subject: cip/linux-6.1.y-cip baseline: 110 runs,
 1 regressions (v6.1.66-cip11-1-g2d3d776d703d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14125

cip/linux-6.1.y-cip baseline: 110 runs, 1 regressions (v6.1.66-cip11-1-g2d3=
d776d703d7)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.66-cip11-1-g2d3d776d703d7/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.66-cip11-1-g2d3d776d703d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2d3d776d703d7a5abcbbebb5ff00910d7e1102ac =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657b231c34cf8a96f2e13489

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.66-ci=
p11-1-g2d3d776d703d7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.66-ci=
p11-1-g2d3d776d703d7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b231c34cf8a96f2e1348e
        failing since 20 days (last pass: v6.1.59-cip8, first fail: v6.1.62=
-cip9-12-g3a5321f469b07)

    2023-12-14T15:45:44.549866  / # #

    2023-12-14T15:45:45.628794  export SHELL=3D/bin/sh

    2023-12-14T15:45:45.630062  #

    2023-12-14T15:45:47.115274  / # export SHELL=3D/bin/sh. /lava-12272260/=
environment

    2023-12-14T15:45:47.116505  =


    2023-12-14T15:45:49.832191  / # . /lava-12272260/environment/lava-12272=
260/bin/lava-test-runner /lava-12272260/1

    2023-12-14T15:45:49.834268  =


    2023-12-14T15:45:49.844899  / # /lava-12272260/bin/lava-test-runner /la=
va-12272260/1

    2023-12-14T15:45:49.904260  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T15:45:49.904713  + cd /lava-122722<8>[   28.526041] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12272260_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20

