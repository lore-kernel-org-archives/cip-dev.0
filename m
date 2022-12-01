Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B056C43217
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 13:39:42 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.43455.1669901973319374129
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Dec 2022 05:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2XitprD9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id o12so1874399pjo.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Dec 2022 05:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rr1MKConrJaya+pv2e/JmQStfO7GMKCYbHz1cN28ItA=;
        b=2XitprD91q4AG+tevv9bs4lbIN7SGP/ixfbng/UksFEVX2TfTBME33V9MApiIZmM2h
         loRcjxNML4WGs1cwPA8PflxMD5+SX8QJD7AplQ7UElEcc7OPq6U7kwTHa63w6CiIe1QD
         dV3McHYyQ2eO9wIIPBXzWk8zh+d51TZLP4oPnl50KNBwB3qOSE9gx6vzUzMYmzWMGYHJ
         yIw0zFoGICveqcWIX9Isl8rJD9UxNZBSDms74Rz1mOEHsMmUvYEC0ccSPb6MDmTJqW9O
         oQ1nUmfQyVgM96QwHVkN+VuMEct7a2498nDhsiFxmsgiVnLzPCGT7bmjoPZWAFhkNzKo
         CYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rr1MKConrJaya+pv2e/JmQStfO7GMKCYbHz1cN28ItA=;
        b=4Dbyu9/pXwGgxpS7i3G70asmCVZ2YtCAmMhAf5w0G3RXHYzhK3lV3IRH+M7OtFW/WN
         kj0Hf3QJSe/1LxN71jVMmlnpi6HSYuRMNEZbXxFcunCJqnzWaG8pqp4wJ/Vjq7QU0FFN
         5kwKXkI+C98n2JahBUHwX6Ii82dmNX17AMBrEenfBdbdh294frwWYk2E2L/8rCjQ37Fy
         ya0O8tW+QhkQ+4Q4TL/ZvNNtRz73lE0VDb1n8PccNNLt+rrkqdIc8DKsTcC8kecsWkQe
         0GzriPBPF9z5NTqJJOuygBj0+iuaG1DidPau1yyyzqxnRufdrgB9lAKN6BAsgAaSX2Dp
         7qng==
X-Gm-Message-State: ANoB5pnP57WgFLUbKtUVlkUxl+2dm4Gw++VfGMSMU14Dqe7Yszjo9Drd
	FeXcZEFzrr03lxdP8s242ZVy5Vnb5naoN0i0Zqk=
X-Google-Smtp-Source: AA0mqf6neErHfIKgm4EU1C2K3qMHRtqmDyRxDVuqopYsbFjOQt0JFgrOfUHaL8cBgJqa2ng0+QB81w==
X-Received: by 2002:a17:90a:de0e:b0:219:629a:fdbf with SMTP id m14-20020a17090ade0e00b00219629afdbfmr9177190pjv.238.1669901972364;
        Thu, 01 Dec 2022 05:39:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902db0800b001895f7c8a71sm3667210plx.97.2022.12.01.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:39:31 -0800 (PST)
Message-ID: <6388ae93.170a0220.906d2.6fae@mx.google.com>
Date: Thu, 01 Dec 2022 05:39:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Kernel: v4.4.302-cip71-rt41
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip-rt baseline: 117 runs,
 6 regressions (v4.4.302-cip71-rt41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 13:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10154

cip/linux-4.4.y-cip-rt baseline: 117 runs, 6 regressions (v4.4.302-cip71-rt=
41)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig | 1   =
       =

qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig | 1   =
       =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip71-rt41/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip71-rt41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      83cf69382b99a59619dd4cbe57c4038402270da9 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6388a90cf2cc07ca732abd20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6388a90cf2cc07ca732ab=
d21
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6388a8bb1cab70d7952abd08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6388a8bb1cab70d7952ab=
d09
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6388a8b31cab70d7952abcfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6388a8b31cab70d7952ab=
cfc
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6388a910be1909c2842abd06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6388a910be1909c2842ab=
d07
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6388a8bd1cab70d7952abd0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6388a8bd1cab70d7952ab=
d0f
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6388a8b61cab70d7952abd01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip71-rt41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6388a8b61cab70d7952ab=
d02
        new failure (last pass: v4.4.296-cip67-rt37) =

 =20

