Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7856AE706F4
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 08:59:38 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.11672.1695286776807891200
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Sep 2023 01:59:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pgLykWNe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso442712b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Sep 2023 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695286775; x=1695891575; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F2CTS7v1bZbHk+OSzvNsJIeHNCcJPrSeEJtpfppzo0w=;
        b=pgLykWNeQV7dDhjLDtgXBA8jOuEjaRVYPuxrmwKEBBJRpQuMfgVfh6QsUsHS/+uZk1
         tiCNIE4/eL1/6AjHupQTWNL88HTp7eax6z8podVw8m/k/Neth05/lHPmwETzzzX3RdMt
         LT0Zn//ORSWWkhJfcwNgpVkdl92amRsckbWkOHkgW1M+P75zU5VVNPSXrS9V49TQ1ZjN
         QOs8kd+81piG+RtWowiS/J93VXC3xHuwn0yD2T50+dt8Doc55VR3kOcH5MD6S17UN1Ig
         JhyFfRQMEGTo9hYvhgEBRE06ZTSCoxRxVDfRJogydLVzFT2LfOf8eWWxXzZBkw6gfUbl
         Cckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695286775; x=1695891575;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2CTS7v1bZbHk+OSzvNsJIeHNCcJPrSeEJtpfppzo0w=;
        b=fROgebDi2iOHJPPe6jhL4vTyvDEHvSQAYxvJ7Wnhdcbne44pcSqxd90T8vxNkGPiZJ
         eed/5x5Wvj53IbqUku++xLwJg53Y3akGaS6ReEcpX1c+7rClp6NWmgF5ciAYKRAso/ak
         Jdt/8dFoMnmSvRTV33eo6tgUX0tPjt7bK4xW/36LCNhQkW0ozLI1YofQg7HJHxbbIAr7
         S2OOB7Oo5Wvuu/8PONpcA4fCRPSdhPvbqdfPQ2O1lojd0CFPUD30IZtWlCI6oWXTAWK4
         /Y43LOnBOxLJhpLfNcqt6sFG6AokS7pE+VtlG3iQtP7wLn12WF6DlGUDLRULtI8YtR++
         Z8bg==
X-Gm-Message-State: AOJu0YxA6b2oemZb5do6T7hZNptX1BmiP9e/K3bPsfGb5dXx24U52b+b
	uFdm+h5qfOKHX8J94vnsT+0xyApW6W00PrNsb67eZA==
X-Google-Smtp-Source: AGHT+IFrUHT8721A6eRiJ+coFJ3MQuRN5PobdsORgeiLvizqFbxR2HPENF7gnAoKZBg1s/tZeFjrQw==
X-Received: by 2002:a05:6a00:16d0:b0:690:fd48:1aa4 with SMTP id l16-20020a056a0016d000b00690fd481aa4mr4607025pfc.0.1695286775383;
        Thu, 21 Sep 2023 01:59:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78c1a000000b0067b643b814csm847284pfd.6.2023.09.21.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:59:34 -0700 (PDT)
Message-ID: <650c05f6.a70a0220.c301e.2744@mx.google.com>
Date: Thu, 21 Sep 2023 01:59:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.54-cip6
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline-nfs: 24 runs,
 2 regressions (v6.1.54-cip6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 08:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13187

cip/linux-6.1.y-cip baseline-nfs: 24 runs, 2 regressions (v6.1.54-cip6)

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
/v6.1.54-cip6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.54-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5f8461a2ec855187b1bab7e4aa419338772fe9bc =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/650bf81f75ad7483c88a0a59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650bf81f75ad7483c=
88a0a5a
        failing since 62 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650bf9df9b55968b968a0a46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650bf9df9b55968b9=
68a0a47
        failing since 12 days (last pass: v6.1.46-cip4-14-g09ffd7fb38ff, fi=
rst fail: v6.1.52-cip5) =

 =20

