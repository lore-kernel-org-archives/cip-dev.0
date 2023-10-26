Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA67C25B47
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 00:29:22 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.189552.1698280157459282188
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 25 Oct 2023 17:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=BOBDRAIS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c8a1541232so2537015ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 25 Oct 2023 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698280156; x=1698884956; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2/PkHJ242Wyuh0o4nCpVsI6aiU4PtVZ9o37SMka7rkQ=;
        b=BOBDRAISTJde5ORz+GWRf8z9Tl1CXQ8cvIhq5/VnCeGpsfpyhfpgJboMmhS/f463bi
         btS8ddKKnmIjOULp400cFNwhKknh7ixk6fGV4gu7OO6DLt6d3J7Ev7xxVBx3dHnQnp84
         JhR7qGetMJlFa3diUTLExKpy2fAtYfDvXeheXiDe6TDqs03ptigJsPPb/ShzDZdnFA8u
         CRSKP79Stak1cFyzB+7GUTav5KReuch317KlaAT6Z7MCkNN3GZ1HxOC8/ozA0EHO3Z4M
         L4QjdgG0gaZHVXMAHfN3MTgn4e47NBY4mZvlFcSZe1LoBwUzdn4+pcpXN2F4nQNB4KSr
         /cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280156; x=1698884956;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/PkHJ242Wyuh0o4nCpVsI6aiU4PtVZ9o37SMka7rkQ=;
        b=E/z4DyxehOTqagaWcGCjLduZqlupQQsGQWQjZbZgKklrwhUeERAeIVMa9RZj8Q2kIO
         OWa2kuulMDM62RuGBGDbeHmjeEs91g+Vj982jXF30KXCh+Bx20+L+ULjlxTnVPc7V06D
         2wLSRX9dMAVu8sHbwNM2+Ac3Ml8pNkEV4arTtb5tH8tbD1fa16ZJXybC+stLiKjAu8sn
         LU2MCe57fiATFwNeYtJYJXbg1xuQU/gaYF62qB8l+cCovlCIJjDoXFwa9kv54ZnREEU4
         x9UHF5ghtAEqNmkzXSOYTUalqTkeuagSv/3EFQCE3tEDRZxw3AR65qkLmUHymCpj8bg2
         0MDw==
X-Gm-Message-State: AOJu0Yx4w0lN69Xu+AwmSp5WBhFa3sBA9RjtG8MUUnjzFgnCD/ax+vZg
	CTcoCipkOafihZn1s1k67UpFpQIL/FGpgo92zTw=
X-Google-Smtp-Source: AGHT+IFCJn8vl9uWRj5YN+JokuLfHh2xFDFYYLc8CDT65MI3pymtpOCuGb+tUkE3OKac1ngn0cuBIw==
X-Received: by 2002:a17:903:32c9:b0:1c9:dc6f:d1d6 with SMTP id i9-20020a17090332c900b001c9dc6fd1d6mr20791874plr.0.1698280156372;
        Wed, 25 Oct 2023 17:29:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b001a80ad9c599sm9759447plt.294.2023.10.25.17.29.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:29:15 -0700 (PDT)
Message-ID: <6539b2db.170a0220.fd0d.1784@mx.google.com>
Date: Wed, 25 Oct 2023 17:29:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-915-g33f52aa14b957
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 119 runs,
 3 regressions (v5.10.194-915-g33f52aa14b957)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 00:29:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13452

cip-gitlab/ci/pavel/linux-test baseline: 119 runs, 3 regressions (v5.10.194=
-915-g33f52aa14b957)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
imx6dl-udoo       | arm  | lab-broonie   | gcc-10   | imx_v6_v7_defconfig |=
 1          =

imx6q-udoo        | arm  | lab-broonie   | gcc-10   | imx_v6_v7_defconfig |=
 1          =

rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-915-g33f52aa14b957/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-915-g33f52aa14b957
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33f52aa14b9570bcc02c5ccb3277101f421e6f93 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
imx6dl-udoo       | arm  | lab-broonie   | gcc-10   | imx_v6_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6539aed924fcae9f50efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6539aed924fcae9f50efc=
ef7
        new failure (last pass: v4.4.302-cip78-rt45-338-gf468de833aa13) =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
imx6q-udoo        | arm  | lab-broonie   | gcc-10   | imx_v6_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6539ae4d10154f45d9efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6539ae4d10154f45d9efc=
ef4
        new failure (last pass: v4.4.302-cip78-rt45-338-gf468de833aa13) =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6539ab6bb2c782a19aefcf59

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6539ab6cb2c782a19aefcf8a
        new failure (last pass: v4.4.302-cip78-rt45-338-gf468de833aa13)

    2023-10-26T00:01:41.985158  ad to last with leading zeros

    2023-10-26T00:01:41.987567  	-s SEP	String separator

    2023-10-26T00:01:41.991580  /lava-11879155/1/../bin/lava-test-case

    2023-10-26T00:01:41.997661  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-26T00:01:41.997716  =


    2023-10-26T00:01:42.002152  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-26T00:01:42.002370  =


    2023-10-26T00:01:42.007384  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-26T00:01:42.009870  FIRST, INC default to 1.

    2023-10-26T00:01:42.010087  =

 =

    ... (5 line(s) more)  =

 =20

