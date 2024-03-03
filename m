Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8760C54E49
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 21:13:34 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.83169.1709500410289722603
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 13:13:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PMR5uviq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so13151255ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 13:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709500409; x=1710105209; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iq0WWDEEUU+qxy4jvk0FJTFluMz7+qNGRLC1W2FQ7C8=;
        b=PMR5uviqASwet1SCIVQhM2KEC3KFYnL8RFPhw5nu8/z05jwtk+cxET6n7S+usw1LBk
         Ph0FFwHNUQZzBZ/I3+rfldWHUm9RAbm8pc3dm9RLlca9pHYYHHMsinNAF66lIMM9GrMi
         +IYhf54w1J+0ehzXEHHjNnyQZszN30mkj3yvy9Sviq3JaqR9YUwxH1sp1LZnlKgBhg7G
         z9AhfwWniDJZggD2eG00S3VWyXztUOAUjN1bTqykZvZAzbMqygYZaoya5N++fcdqHKkw
         DxK0lc+BizVdDh2lFreOLEzKLbwF/3rQCoc2mgSHZUK5RuILrqQ4IYHZ3ONA5zyyPbDk
         T1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709500409; x=1710105209;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq0WWDEEUU+qxy4jvk0FJTFluMz7+qNGRLC1W2FQ7C8=;
        b=Lq9tRj8C2dCK3fivmpVEO4aY/x8J+Ia+eX8Ez8A4GwFrlDq56LwHCdQfU5Nvn3PxIP
         qjy4qQ2rvU3v2ivbHpUaOrYhgN6jmhcHhi4qrRxerw0Mf7cChQ3azVY2+hQUfcMS8xrB
         9VtT0eJUT9qvPtRRYfNRmiHsyNTEZklN+JVPbHnC2M5D5+hD7ERdk3N0gyU6gjIFGpwq
         BePy0s+sbO0e+T715wALPzaYTTV9cDRhR8ouurI1CoNZHDDpkiZszqovye6YugZq73vG
         o7hJ4rCAClvlAA0k88v2ltYnmfZ5Ys11QGojGYTbRI8BM0wUsPPzNjwjPA19ka2SA9jc
         bmtA==
X-Gm-Message-State: AOJu0YyY5Zi4y6vQBTXrsvOeCvGIkYPtNmQWAdUQKKMsf9arzQa5SsTi
	F0PxaAuJ0UPNkPiy2c05RQtnPqOE2JjYkZDmD8GiCsGLH4j+vtEtVJeYwwIYoOrlA/lqjGCL1bp
	QETE=
X-Google-Smtp-Source: AGHT+IEmzrW1fhyplMenfoWp2GnCx6qfYdqhrDpZi3WncgicJzdE0dp+a37BvExIyrL4hp1KQ/08bw==
X-Received: by 2002:a17:902:f691:b0:1dc:7856:2200 with SMTP id l17-20020a170902f69100b001dc78562200mr8528321plg.18.1709500409113;
        Sun, 03 Mar 2024 13:13:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001d77a0e1374sm7042813plk.151.2024.03.03.13.13.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:13:28 -0800 (PST)
Message-ID: <65e4e7f8.170a0220.6cc48.b8e6@mx.google.com>
Date: Sun, 03 Mar 2024 13:13:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-547-gb5450675e67c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 7 runs,
 4 regressions (v6.1.78-cip15-547-gb5450675e67c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 21:13:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15180

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 7 runs, 4 regressions (v6.=
1.78-cip15-547-gb5450675e67c)

Regressions Summary
-------------------

platform         | arch  | lab         | compiler | defconfig              =
    | regressions
-----------------+-------+-------------+----------+------------------------=
----+------------
beaglebone-black | arm   | lab-broonie | gcc-10   | multi_v7_defconfig     =
    | 1          =

beaglebone-black | arm   | lab-broonie | gcc-10   | omap2plus_defconfig    =
    | 1          =

r8a774c0-ek874   | arm64 | lab-cip     | gcc-10   | defconfig+arm64-chromeb=
ook | 1          =

r8a774c0-ek874   | arm64 | lab-cip     | gcc-10   | defconfig              =
    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-547-gb5450675e67c/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-547-gb5450675e67c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b5450675e67cda5a44ee81ea4d17ab5db9b7deff =



Test Regressions
---------------- =



platform         | arch  | lab         | compiler | defconfig              =
    | regressions
-----------------+-------+-------------+----------+------------------------=
----+------------
beaglebone-black | arm   | lab-broonie | gcc-10   | multi_v7_defconfig     =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dc06245bdaa9dc6370f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e4dc06245bd=
aa9dc6370f1
        failing since 532 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch  | lab         | compiler | defconfig              =
    | regressions
-----------------+-------+-------------+----------+------------------------=
----+------------
beaglebone-black | arm   | lab-broonie | gcc-10   | omap2plus_defconfig    =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4e20a85b40c56e0637076

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e4e20a85b40=
c56e0637077
        failing since 104 days (last pass: v4.4-st20-231-g7349cef09ddd2, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform         | arch  | lab         | compiler | defconfig              =
    | regressions
-----------------+-------+-------------+----------+------------------------=
----+------------
r8a774c0-ek874   | arm64 | lab-cip     | gcc-10   | defconfig+arm64-chromeb=
ook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4da43c31ece22b4637028

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e4da43c31ec=
e22b4637029
        failing since 101 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543=
e, first fail: v6.1.62-cip9-13-g34c303883a305) =

 =



platform         | arch  | lab         | compiler | defconfig              =
    | regressions
-----------------+-------+-------------+----------+------------------------=
----+------------
r8a774c0-ek874   | arm64 | lab-cip     | gcc-10   | defconfig              =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dcae8bc6973fc0637094

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e4dcae8bc69=
73fc0637095
        failing since 104 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543=
e, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

