Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2DAC0015E
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:38:10 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.14942.1686825485979627449
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:38:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XI5OaePu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.219.46, mailfrom: bot@kernelci.org)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-5ed99ebe076so26753426d6.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686825484; x=1689417484;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gftqzN4nN2kxlypngJd/3aksPiYw+mHYH1mzwbClI/o=;
        b=XI5OaePuUncDiNUuX4t47med+W03GRGke1NP9ibUeQz0fHbehUlePGhYKdVxMtiGT4
         imwto12bP+8l3uSPU1ApzDmGX7xY2BPtgbuW2575Y8SCkRdr9X8svjmftbKmH7fsZugu
         ajejSfxyPOq937IFMSuCic9IhcleXhWD3xbgzxINfaGBhIS6aDe9OjK5nx7auaEOPf8o
         WfWseF3Le55zKNh8KV0GGXuQGJPECWWfW2VG4J/lxpw0wO1UKAhginTTwVFfudRWddHj
         N/8rjLGSpifNSQbqI29+LWjbcUagZLodrJ45nuY0ZSGfJz3gePXDu5IsM2Nc9fiu45bi
         3VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825484; x=1689417484;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gftqzN4nN2kxlypngJd/3aksPiYw+mHYH1mzwbClI/o=;
        b=aoVhuoKM/MrVDVa861HunzaHew9LR/J1Xk4RdPXBi+v04DAEXr80mlqb2QZ4hdvi3F
         Zvo7EUrWGWC+IHLDnKlYCJJbV5pPKKqbmE24mcfku3JyRViqPcvg0zwyNvkUX8E23Pbw
         Bcz7DdJR4xgpH52VOmYqsqbmXBH8svM2zIeWkS0Smvofn3DUiV7PNgEFyhY9VA6QGm5H
         sfxY5Yrj+hEFE19K9u4BjFPIJg2VCUgqOk5PFjiMZhvqBhs2bWhleidqoQgdzLHp34IH
         ypZprvcGSzBbxEFIxXWg1660NKz0Zs7mPV8cg5BoE+TuEMxeKnEFhWHGr1RIQR0APv8c
         ybTw==
X-Gm-Message-State: AC+VfDwE8q7AZRf2s0wVY3P4q845GfFEbf9IhBKIOmOYQQEGeXmrEbgy
	cn/Iwz0GlqgsTmZlYCrqEMsZNdkbN9lIAFt+WGZZgA==
X-Google-Smtp-Source: ACHHUZ6bgOxhEOKgGgKhb+f/MsP1Bt1XMM+g7UPS/XhB3Ns5llv8FXdi+jqEG9LXJrSJEES+v/RxFg==
X-Received: by 2002:a05:6214:226a:b0:625:aa49:9abb with SMTP id gs10-20020a056214226a00b00625aa499abbmr19609739qvb.63.1686825484237;
        Thu, 15 Jun 2023 03:38:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y3-20020a636403000000b0053ba104c113sm1849061pgb.72.2023.06.15.03.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:38:02 -0700 (PDT)
Message-ID: <648aea0a.630a0220.de295.4099@mx.google.com>
Date: Thu, 15 Jun 2023 03:38:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs,
 2 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12053

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.182-cip35-8-gdba8=
1ae6f2be)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/648ae1ee65054a0527306166

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/648ae1ee65054a0527306167
        failing since 519 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ae77a6cbe885b4a30613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/648ae77a6cbe885b4a30613f
        failing since 519 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

