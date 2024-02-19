Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815BDC5475B
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 06:11:18 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.36082.1708323072686439369
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Feb 2024 22:11:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1tFQfaOs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d953fa3286so22526805ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 18 Feb 2024 22:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708323071; x=1708927871; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mKZ/92APL3Smcn7c3/9UKpPa5GYVQtCul1ojTDqDRqw=;
        b=1tFQfaOsC4dAOnx9PgKwhuMEXkRNBMz1Ua2oPS4b90NeXpcRD4uTp3E5iwUv5djNsa
         RPDH1dz8AFx5PpoA46OITrcbyqdl1MErD7UWpst9hRFXQ0+CxAMYb3uDYuH5TWIcnOGC
         RNYrDsOf9keWbXMZJj71Ud1hgA5bvDW/tdkfnqDv10aIfuPRJmH/xsrX+nbtQM6WZvQr
         WT8+Ie7kfx/ZwQ6zW/3oPb91Enqw0u5NXcX1dPDzTvkNxXzkxjXWuIFctg2mJsaaB0Ai
         h5CIlb1LpjyOsG2RxDl2vXE1MhgCTQ5ZeybOlSLkTduMiL3s8KesW0P+cBNwcxTU0MVO
         Od4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708323071; x=1708927871;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKZ/92APL3Smcn7c3/9UKpPa5GYVQtCul1ojTDqDRqw=;
        b=hI2+VKeJzLv6lBNMgr1JTKb78fBj/afbibLBQwLlV99Mq/8OKIedo+Gevq2V80/zh6
         FY0lOI+ohJgq/3w/8LDuO7/Dz2uMPKjlfMT0J4H8ektVIT7PkLqcfrB/HrO+lkHzrWG8
         FwpqHBg2FoUQCsuDMBB8rd/vOesI8yJziVjzLFLGLTN3xNAyvt9hgWS36aQxMcawBD6F
         mY2ovxJ2yuNe59TdDK5eaFVUbNSM1qOn6ym2bskAnnPimKkdG7fi19llyJtuaJJy2n6x
         TUx5F6pLQZickEeJ4bY76xAwtjVmxX737kWLcKoLRjzILrCgnYi3hQDOWP1q1KLQ6cJ8
         snZA==
X-Gm-Message-State: AOJu0YxFy1VgJ6LU1tEeScyiZCyVGr7BywNvYKTlo3UWFUUMPCuBXSux
	fH2S7Zwacw0cqu1lUV+IKTnrkffKwWHT82u+kO1mcGOpsKcB0I3hOHawYdNfcQwwvnf6smUV7fi
	L
X-Google-Smtp-Source: AGHT+IGpDNpLBJUDhUga5HZ40BAbkvBouvpRmUdQkf5NDW7uLGy2BsztNvwmxDX2olxbHxerMos/1A==
X-Received: by 2002:a17:903:1ca:b0:1db:aab5:1db5 with SMTP id e10-20020a17090301ca00b001dbaab51db5mr10898465plh.42.1708323071574;
        Sun, 18 Feb 2024 22:11:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d71729ec9csm3580470plb.188.2024.02.18.22.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 22:11:11 -0800 (PST)
Message-ID: <65d2f0ff.170a0220.23e1b.a558@mx.google.com>
Date: Sun, 18 Feb 2024 22:11:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.306-cip107
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 54 runs,
 2 regressions (v4.19.306-cip107)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 06:11:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15026

cip/linux-4.19.y-cip baseline-nfs: 54 runs, 2 regressions (v4.19.306-cip107)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.306-cip107/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.306-cip107
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      800dfc28d1a90b195d50f75fa7711d00cc1825bf =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65d2ea664a208a9eef637039

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65d2ea664a208a9eef637043
        failing since 333 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2024-02-19T05:42:52.140011  /lava-12799815/1/../bin/lava-test-case

    2024-02-19T05:42:52.160659  <8>[   39.469741] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65d2ea664a208a9eef637044
        failing since 333 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2024-02-19T05:42:51.089910  /lava-12799815/1/../bin/lava-test-case

    2024-02-19T05:42:51.110285  <8>[   38.419345] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

