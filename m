Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789FEC54798
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 11:36:56 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.8654.1708688210529231592
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 03:36:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=k+p/wA3E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d944e8f367so4695845ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 03:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708688209; x=1709293009; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4T9Pq28Ma5sLVElRxWYNVC14Dgh4xQ0BOLWqGgoj6M=;
        b=k+p/wA3E1cnJkEUjeaRQiyRygCu7uaknW9Zli2ytYcj6KV6LB0wVTwxqfOIea0UQuN
         LU3kZlQMNolkVl12IAi8b/tzoTZPrP9xGQoiKESyL4VDTTwpD+F1XOp7P9pPDruzFRd4
         1pH5qx34CkzPtZA9YKAmXrwERFL/Aqy8rDRAfdaGrPIgCo7ap+wTFlhucUhpl4pAgtrf
         isu2UPOwJE3RtNlrmKTXcsGKAsWPDa/N8MUVdxvTVw3Engh6WHFw5eT8HwLQHLiIjtGY
         /wD5sSBYW98Wmgq8sMa2jb3yFIiRXw5400nwLEh35DqZJK/wQ3azNKQocB9FF3fxxoRK
         iXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688209; x=1709293009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4T9Pq28Ma5sLVElRxWYNVC14Dgh4xQ0BOLWqGgoj6M=;
        b=G3uj82Rxfe4BylAnAkbm1jEqgCGuhur3KZlfGvPsv7vF1Pm0zsJBRy8RZOhcdw42iw
         o+3vFNONh07dx0Ogw/60wkaEriUurD7D2jJl7JopSJHO4vs0+hj31yhFQgw1OaG/aUWy
         saUtult8Vc4TQbD0xdt/6ZGhzoAXbU8W3nvgMY8Lx8o9+b+u85iuClkGwXaGi73sJdZD
         GYtqxHbDW9kgpVrs4ELbXGOfjiyUQDJWeHR8Ez2MVgY7ygy66+Sf8ZVdPgaEoG0zp6mT
         E8en6Ha8xk3SsORIO6y8HiqicsQ6CUR+sg86MZM3ZQXJw6lEGdr/KoCc6yCwJmNCv3s4
         rSaA==
X-Gm-Message-State: AOJu0YxKlftltEc2/4KGTeBUODEv5TBLq40jLnGXXAD7zD7lScupsOUt
	nIXtG6IYNf71H/u+paH5bwGbywy2WpZMW2gTcNG02adcP5XKUh0x5Do8yU8PuyTuaZOBE8JgXjA
	Je60=
X-Google-Smtp-Source: AGHT+IHgKcqWZ9+CLm2datDxaLiS9ibns9kBdc4vz94WJJnp5e1QtNlpUQhGCGffGmydwSxq1BB8Sg==
X-Received: by 2002:a17:902:ed05:b0:1db:28dd:a428 with SMTP id b5-20020a170902ed0500b001db28dda428mr1523442pld.23.1708688209456;
        Fri, 23 Feb 2024 03:36:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902f21400b001d8f6ae51aasm11470973plc.64.2024.02.23.03.36.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:36:49 -0800 (PST)
Message-ID: <65d88351.170a0220.3adb6.637a@mx.google.com>
Date: Fri, 23 Feb 2024 03:36:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 74 runs,
 5 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 11:36:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15069

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 74 runs, 5 regress=
ions (v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87c7bf13bc522b2637030

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65d87c7bf13bc522b=
2637031
        new failure (last pass: v5.10.205-905-gb40421b142370) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d877f4a292593e83637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65d877f4a292593e8=
3637013
        failing since 210 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87d93be43f62b5563705d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65d87d93be43f62b5=
563705e
        failing since 195 days (last pass: v5.10.186-cip37-566-g36076316ef0=
49, first fail: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65d87bc7ac30a00d0a637033

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65d87bc7ac30a00d0a637039
        failing since 308 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-02-23T11:04:26.592070  /lava-12838079/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65d87bc7ac30a00d0a63703a
        failing since 308 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-02-23T11:04:25.489226  /lava-12838079/1/../bin/lava-test-case

    2024-02-23T11:04:25.529595  <8>[   36.940640] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

