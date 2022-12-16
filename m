Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861CCC001B2
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 20:40:41 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.5766.1671223235727687427
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 16 Dec 2022 12:40:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OUyCVkzD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id 130so2547560pfu.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 16 Dec 2022 12:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3etVtcTPjeiXiDbLFjBQqDJ9uGCyb3NWJ9IG1h41BLE=;
        b=OUyCVkzDb2NYptBmQy/CroGM/MeJjIxHpNT8839CZm6wAm5AxGkeP9caCgJwo4E9Zj
         m6u3845X4FZQB936iOt+3948rL8PR32b9TsPBSS8VRHaRP+hbeUP0hwofOhA/uc53H7f
         rpTbEbA8bMdrkBZEiFqhh7OyxVoY4l+6ZWBj2U+c1srPVhubMfm5M3KaevXhBq8JrY1U
         /2yyNzWdv/gp2RWmcvOeKYmkMX3DXfpbZ8s9rSxkkq5AG5HcemnW/qQUk/mnPPrFs0S/
         neOKub2QkvnF1jL5+ZC32a0Ha9owZ13N1issoxQi7dDxn0Q/bNB999EmZVbNTN/vO5wX
         gIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3etVtcTPjeiXiDbLFjBQqDJ9uGCyb3NWJ9IG1h41BLE=;
        b=ekOuqIGd7lzr97WCYqlzbtWGreaEIf58wcg9eLYPSpdR14YnKg8+Whr8qVEteuT5lY
         sg5fG5nnOeL5uInrigzfahCZsg80rpkDdrV5PD2HeJ0r0Rt27zbtAeayeNxKHquU/SN1
         qI1790GfUEpUUslnKA/XkTc+Zpufi+LqQlryQguMJWSOXERslKAjjmxAvFwTB1B7ernT
         e7yfa1U/R9qZ7Y2OpABCl+6MAzwRWlmZ0e+2rfQUIVulc6GWqXtpeucEGYO+Le9/a09f
         EY4sRhUu21UKixhAftnP9FNd7EMLFXj7kVgUkEc6+vjkuiSNvCBvRd+F1ajXxdaaTPeg
         VYOw==
X-Gm-Message-State: ANoB5plOEVHoriPq7mb0ahf5RH2m5O5G1tmuJCQrmIJ/YyBe/gESgh2L
	URb/Q3+WDsOoDINQkHlmr8W825vRXuBmPDhVMro=
X-Google-Smtp-Source: AA0mqf6nSWPQSOZ6jvSb4u7a7rE3SAUuz1TssalSF7wOglAyDzz090plwBM1i1VM2N3NV3v7pWMBKA==
X-Received: by 2002:aa7:9627:0:b0:578:5e94:22d0 with SMTP id r7-20020aa79627000000b005785e9422d0mr26689138pfg.19.1671223234906;
        Fri, 16 Dec 2022 12:40:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y29-20020aa793dd000000b005770d46545dsm1901358pff.30.2022.12.16.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:40:34 -0800 (PST)
Message-ID: <639cd7c2.a70a0220.5dac4.3bac@mx.google.com>
Date: Fri, 16 Dec 2022 12:40:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22-7-g92462fd9830b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 150 runs,
 2 regressions (v5.10.158-cip22-7-g92462fd9830b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 20:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10241

cip/linux-5.10.y-cip baseline: 150 runs, 2 regressions (v5.10.158-cip22-7-g=
92462fd9830b)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22-7-g92462fd9830b/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22-7-g92462fd9830b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92462fd9830b23227198482fe4bee42316a5694d =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/639cca2e97e8b6db782abd33

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221209.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/639cca2e97e8b6db782ab=
d34
        failing since 6 days (last pass: v5.10.154-cip20, first fail: v5.10=
.158-cip22) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/639cce5bffade4cda12abd1f

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221209.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/639cce5bffade4cda12abd41
        failing since 262 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-12-16T20:00:19.936795  /lava-8392597/1/../bin/lava-test-case   =

 =20

