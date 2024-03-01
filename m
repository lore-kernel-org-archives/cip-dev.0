Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A2AC5475B
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 19:50:26 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.33718.1709322623704222986
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 11:50:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nm61yR8N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d911c2103aso8991155ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709322623; x=1709927423; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UJRyYZxWpDGVQcr7JCDHFeCt8EwnGF8W/kIf4VfPGuQ=;
        b=nm61yR8NEkBaq1AgrjTlEqmeC5bx5fC3+CGzKIRSwhnvx0UxT7+S+or+8wir4KKJo8
         4jrN1tIN2sCqka2Z/kDQaXKCdBCelr4C8/5p5RKjvSQdB8N2oEUwi8zJ6XLhRf/W1KRs
         FeRUALLJO4hVngUWa01codxvwr7Numf6SIguqeiR7+bjCFlS71oI1ZQe4uJpY9CkTFdp
         XL6KSUPkLVz40A/opQujtGaG1hxdMXJxCIPIYt1gEm5YzMnhkcS2JONDzoMzZhpsA/6q
         a4XR8XTo8isvcafErhm/cOrYbbArJpGssyqBHvvBe0Tt9qzHCyCdcQJkLnRVBaYAyKMB
         yaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322623; x=1709927423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJRyYZxWpDGVQcr7JCDHFeCt8EwnGF8W/kIf4VfPGuQ=;
        b=aLOB3qAfaSBsHqYFj0t6TXwpDj3uSbLhPJmNzjREzsls6Izh1PYAFdnBZ5FU+8PmFJ
         5VPHN/aZHaCe2m0CHCB45Uw4yJ/bVLNR5cM33RyFUfFFbbXwgsadLjQChDLtk5HelfrI
         IrHjomau5UiA7pbRgzbj+o10skn3J/zoWlfukg+pJzT1z6lKwqMBzVLOAaan8jnyD+Go
         lKDthtQ4JamLVunqnVpp0J8/oHlJntS4bF4J70CAa/XTpm6dRLLU97SmwugK0OjxQvzG
         HeQi3isQXvEdotgOLfjyo7actvXYMRUdPqEKL+qX90jcnzYOxzNxnS20tS5FHq/WQFAp
         GsiA==
X-Gm-Message-State: AOJu0YxStI93UBPiwyHTD/gEy7QpIWUrH+UPUxYBsMV/V+sQpwp7VtQS
	mPnvsAIWtRnKWsoL4mYQmGaXeRnc5HM6iO//RSRty9c8q0Ii6auGh8f2Bt/SYLS4e2RUfEL9kU2
	WqmI=
X-Google-Smtp-Source: AGHT+IGl4EQ/otrCI/cO/IMBkwjq1mhjcn+dlITpMrXTSpu6uDG0XHD4d7DcDMjbIbBJC3vMngLLdg==
X-Received: by 2002:a17:902:e88c:b0:1dc:c445:b253 with SMTP id w12-20020a170902e88c00b001dcc445b253mr3225584plg.36.1709322622595;
        Fri, 01 Mar 2024 11:50:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709027c8900b001db717d2dbbsm3821997pll.210.2024.03.01.11.50.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:50:22 -0800 (PST)
Message-ID: <65e2317e.170a0220.52213.29b0@mx.google.com>
Date: Fri, 01 Mar 2024 11:50:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.306-cip107-254-gfeae08b50ac51
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 5 runs,
 3 regressions (v4.19.306-cip107-254-gfeae08b50ac51)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 19:50:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15134

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 5 runs, 3 regr=
essions (v4.19.306-cip107-254-gfeae08b50ac51)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.306-cip107-254-gfeae08b50ac51/plan/baseli=
ne-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.306-cip107-254-gfeae08b50ac51
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      feae08b50ac51891b1ac8f457acdb2bcd62fdc22 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65e2268b433b38202d637031

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e2268b433b3=
8202d637032
        failing since 114 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65e22cd1e26a4673e2637044

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e22cd1e26a4=
673e2637045
        failing since 114 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65e2294c762dbd002a637018

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e2294c762db=
d002a637019
        failing since 568 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.252-cip78-146-g6acc38498265c) =

 =20

