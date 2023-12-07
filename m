Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB57DC10F1D
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.84732.1701957717681178994
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:01:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Uu7cNYm3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d06819a9cbso6699405ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957716; x=1702562516; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xa1o7dzuS2tH6sjvrFAHW5jdvR5vicS6fujdxP7FMQ=;
        b=Uu7cNYm3ldkxY7nJ6TSRgbUJSvVOr+/PSwGD9aBrkDOhmMKVBiS3S+xfnl+BhqEfiK
         +u/hOqewtbi5HHePS94/eDgxr+ZxLaI6xB16kpTVQFADCTO7WHNrnBqkqcLs8fNDqBWD
         Fvf8tQSjBBuBw46K3Q1glxqwjklvYhtW4YcduxwmXDUT5SjxmKY0ZCWrCpT+nVzBqfF7
         f3gyHpIhSN3XYE5qVCgN7x+wKOSzqEtXYunTMED0XYf2qm+ZUV/R04R76Ij9VZjbQ7Wz
         zgARWvPHhW3RosQCX4N7qSEqQ2bKUOEGf96rPmo4Ef1LW6yswYjG49Ih8pT3P/l16+v1
         mOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957716; x=1702562516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xa1o7dzuS2tH6sjvrFAHW5jdvR5vicS6fujdxP7FMQ=;
        b=HiqVa+LKF1SDkTtnSpvR65D8LkV2ym3swiURmkLg//Wy+8n3IHgOTT+gOh1pEK/0v1
         0/8QKIS8Ow7/aR8DYg1dO3nby6X4XU+fcO3icAn/KPnFLImjmFDu0+/ADWtxUSEfVwHp
         MJ2AmlhZc2yIsNxqOE5gaXfELRS7Pc9cs4tmzx5p6tQVPYfswQgN53QPkKYk9Q8Hb5kk
         h4M5bOLpvTA1/90mWhpZXJEQ4Yg/U7AxFMVaugQI8mikvM+Erk/GSTzScbAEPGYkNd+b
         5FODeUqD8dFDTIhfE56UDwJi/oSpoykiRIW+5AzIBISsuT4MOlkYawC3Gl5fw+8udV0f
         Kx5Q==
X-Gm-Message-State: AOJu0YyXPZE1Dw5cL7a4dQ5X0Ut+qCJFdM9A4j/kksfJ06oOPdSMaHaw
	KGzqZtvfAhgQZgOWyVGhGYTFoux5yYiupbmo2djMBA==
X-Google-Smtp-Source: AGHT+IHZS896SDFN1FgSKH1YMNoPVXTqmeFgw3rcu3AXgJvVDv8uAtfus+2+3liOJSNRbeChLeD1RQ==
X-Received: by 2002:a17:903:32ca:b0:1d0:6ffd:ae05 with SMTP id i10-20020a17090332ca00b001d06ffdae05mr2329358plr.108.1701957716557;
        Thu, 07 Dec 2023 06:01:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk8-20020a170903330800b001d1c9e0c12csm1448316plb.56.2023.12.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Message-ID: <6571d053.170a0220.dfce8.3312@mx.google.com>
Date: Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 2 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13864

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 2 regressions (v5.10.201-cip41-=
16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6571c5cc1d1c63330be13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-broonie/kself=
test-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-broonie/kself=
test-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6571c5cc1d1c6333=
0be13477
        failing since 13 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bfbbeaa0421242e13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6571bfbbeaa04212=
42e13478
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

