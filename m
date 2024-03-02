Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D9AC54798
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 23:06:38 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web11.62882.1709420795100069262
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Mar 2024 15:06:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Eaui+qGI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c1a172e46bso2758744b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 02 Mar 2024 15:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709420794; x=1710025594; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0gPl9Hl02q+IQOiW7R+dqMRja4D9uYtVAXC1tWy4zwg=;
        b=Eaui+qGIssZ9t2U/e6qSmVClcCm9ooc/nZCCGL/BrVvAVG4Da7iBhBfkk9kETLLehu
         5uw1HlGXp1GkdsB6Y176hX5k8eKDnfr+R6cvnRKvrjRxTMa/nKM9q7uMRCa5WIxe3K7p
         3pBGKgG9BhfAavXlsl5oEF35XH1cOIA21ZRkMWjlO1X2rcHuOFC0yyeH4p0B3Rc5zmsA
         gZiC7+/zY3/3eGVSPHM/bIs1aUWrf8EOmjx8OGzN/MeKMW0zE4rzIxmz3lYRK+WWPd9r
         sdgiTGtGdupU2NwMyR3+Pn4rq+2RfhqhDs1QPT7idzoblEHVMefBCvvJOetEt3MBvA4e
         odqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709420794; x=1710025594;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gPl9Hl02q+IQOiW7R+dqMRja4D9uYtVAXC1tWy4zwg=;
        b=Ktp1GvNcJXPML80ZJcH8deB1yIUfuYxww0XhdQ5SW/ucJsJkzMRlHJag9AJsZWwuAy
         rAPLpUWUva2RJw1ok9SfDowxLxB/jAQHFuNug4bfPIqcAgp1pfes5qZir+zEiu9L71cx
         eiVjxGRh1eclkQMJjXvgTH/A9bQjiZ3JRXOGx7DxzQ0UdXHZ4hIG1+81EfzisYjlxdEF
         sc/wE24VcdHvpr67pBLbDmSEzZ4XMaZqh22A6ypJIWSFl7y6n+IHajtMEKHoEbf1Web9
         7Vyw0yWOFogtGeRJAO3cJmwXm+n/8XbOcYBPN4vXb6buwgqj7dAuADeqH5m0u8hRTR5c
         FO8A==
X-Gm-Message-State: AOJu0Yzkd8bN9uFxQn04/CRqFfvbhA3K6SvcBRUKF+kruQmbjVfOeVtZ
	oOl1W08gZgQvaJf6RgBPN0GyLmJ4qvpIr/HczoxEX1XA2FB9eIYeDdC989JXQYwbZ/uptQPZ2AW
	i01E=
X-Google-Smtp-Source: AGHT+IHOI0xrVXCbYfsQZjWWfU8M8alneZHO9uJpDnv0OgHfNxbF18/aXUdlbX9TTI5RBEN8kYeJag==
X-Received: by 2002:a05:6808:d51:b0:3c1:dbd8:e49b with SMTP id w17-20020a0568080d5100b003c1dbd8e49bmr4314192oik.6.1709420793433;
        Sat, 02 Mar 2024 15:06:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sn7-20020a17090b2e8700b00298ca131c75sm7456570pjb.24.2024.03.02.15.06.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:06:32 -0800 (PST)
Message-ID: <65e3b0f8.170a0220.16e1c.1682@mx.google.com>
Date: Sat, 02 Mar 2024 15:06:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-404-gdddfc5d4f194
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs,
 3 regressions (v6.1.78-cip15-404-gdddfc5d4f194)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 23:06:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15166

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 3 regressions (v6.=
1.78-cip15-404-gdddfc5d4f194)

Regressions Summary
-------------------

platform         | arch  | lab         | compiler | defconfig           | r=
egressions
-----------------+-------+-------------+----------+---------------------+--=
----------
beaglebone-black | arm   | lab-broonie | gcc-10   | multi_v7_defconfig  | 1=
          =

beaglebone-black | arm   | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =

r8a774c0-ek874   | arm64 | lab-cip     | gcc-10   | defconfig           | 1=
          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-404-gdddfc5d4f194/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-404-gdddfc5d4f194
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dddfc5d4f194925df6ee3d06e86b1d1e12412f06 =



Test Regressions
---------------- =



platform         | arch  | lab         | compiler | defconfig           | r=
egressions
-----------------+-------+-------------+----------+---------------------+--=
----------
beaglebone-black | arm   | lab-broonie | gcc-10   | multi_v7_defconfig  | 1=
          =


  Details:     https://kernelci.org/test/plan/id/65e3a8505a0a6d882a637051

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e3a8505a0a6=
d882a637052
        failing since 531 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch  | lab         | compiler | defconfig           | r=
egressions
-----------------+-------+-------------+----------+---------------------+--=
----------
beaglebone-black | arm   | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/65e3a8435a0a6d882a637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e3a8435a0a6=
d882a637014
        failing since 103 days (last pass: v4.4-st20-231-g7349cef09ddd2, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform         | arch  | lab         | compiler | defconfig           | r=
egressions
-----------------+-------+-------------+----------+---------------------+--=
----------
r8a774c0-ek874   | arm64 | lab-cip     | gcc-10   | defconfig           | 1=
          =


  Details:     https://kernelci.org/test/plan/id/65e3ab46efda093f99637096

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e3ab46efda0=
93f99637097
        failing since 103 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543=
e, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

