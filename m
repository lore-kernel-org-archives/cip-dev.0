Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4164AEE8006
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 14:03:08 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.39563.1694181787183878803
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Sep 2023 07:03:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kwuZ4Mo/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c1e780aa95so15658745ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Sep 2023 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694181786; x=1694786586; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Bdb7VcTCGs57+KZ4uCF3K7IZ7qUj4pP5KOGkm0FAkY=;
        b=kwuZ4Mo/hgNElCPTqRkoKcxdsUEhOFcKOXQat/rI2NcYR+Xi6Mx8pJbNG5NceNrULw
         tOx4Gexo/WQ7x++xSWPq73KSQs9V9LjxZvuhleIyZiH1+/ayjCfJOnEtL8oX+uMGh1GG
         5f/YQIMgmxYUpkr1glKcGtXoukwYcH1HD8DwlJnUryp31jllYl6mX9E5iMCUITN1dy7+
         mV+Wdf0eOOo12UyV0NFNNprdrJNYXothnt3+ZymCXXVMEV8zH/nRRv+Wa2aF3WACCSh/
         LQmAHbD9NfE/HLIjRWZRQYj7DdTClyZyv1wvPIG5lXU29QqiXW+ymy0ot0z5eDBORGni
         xHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694181786; x=1694786586;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Bdb7VcTCGs57+KZ4uCF3K7IZ7qUj4pP5KOGkm0FAkY=;
        b=achH4eWQAs3W/ge0BR4jCn4ShUKNJBGIFQ7to9SxgpEfynoiTzil39v1kGoDPKXgEd
         kenaNDW76fiMIreWmqgtThjCuTT6ShbhFIPqDxdHpiJm7R71f29KWHwIKnO3JW66vbaS
         CajdCqT0tlpeb3XWvILqquwvuqRvhavhRkILiQdOJfoubZKTRYz60fPXmP93HlMFqhck
         2i99vEf8MS9E8AyzpfT7MJgQGzkX33n6qdiMdZmMdBpbAhxyjpFGtmdSRH1FMFhFerNI
         YdyjpXL4vV/dbRymUE5zM2xmoDJIzgz5NKE91ZaWBH4UWJtTeh3dhoXSfPqyQdARQbBD
         VmvA==
X-Gm-Message-State: AOJu0YwiYrOSFzL5TSen8UVwuM+d3LTiqPU9S1vdWVq5nUsE+eYwu8/d
	b3L9W3uuroIBwfKVZj2RHCoU3bB3FZ3Ybxctp1kPbg==
X-Google-Smtp-Source: AGHT+IECzbsNuO9jz8qcG7ByJRJmuhx/l8lf1r0V38p5HoT1cqrYiJFYENgc82ygLrqhtK6J2B+yUg==
X-Received: by 2002:a17:903:44f:b0:1b3:ea47:796c with SMTP id iw15-20020a170903044f00b001b3ea47796cmr2602498plb.29.1694181786058;
        Fri, 08 Sep 2023 07:03:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001bdc6ca748esm1610229pll.185.2023.09.08.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:03:05 -0700 (PDT)
Message-ID: <64fb2999.170a0220.44ed2.34ae@mx.google.com>
Date: Fri, 08 Sep 2023 07:03:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.52-cip5
Subject: cip/linux-6.1.y-cip baseline-nfs: 22 runs,
 2 regressions (v6.1.52-cip5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Sep 2023 14:03:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13012

cip/linux-6.1.y-cip baseline-nfs: 22 runs, 2 regressions (v6.1.52-cip5)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.52-cip5/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.52-cip5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      98ee1708ccc7301dbbfaafec75350f88527046a1 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/64fb21d5f801f9d97e286d88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64fb21d5f801f9d97=
e286d89
        failing since 49 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fb25776f5516f0b7286d74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64fb25776f5516f0b=
7286d75
        new failure (last pass: v6.1.46-cip4-14-g09ffd7fb38ff) =

 =20

