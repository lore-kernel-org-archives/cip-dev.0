Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD49ECCA479
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 08:22:49 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.69498.1656922964529150899
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 01:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=KZSJPXLw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id a15so1886395pjs.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2GSQXFH/qh+AH5cgM3aLb+3xra1DIU1MyGORiEWzVF8=;
        b=KZSJPXLwWwIO6Um7eq/mPd1HHcMlPhHz0+buP19lyD2lyQK+REbfoB63graXoK9R3+
         MY4GWC1K1DJj2kXDnf4ylI5zSw3ZcqZoAy6zNv6z+wQnLGLW2f3Nk7Gz8jxri7CuTQQ8
         cwjR6aeHnGfz9UVOzzIv1UhWUPuWD3oKz90OCZfqSE6CRIrZOzogr1o6SGb8rtCpoQB0
         6WAjULlLr1Ui3i16uayObk6QFuWi1SHmP5VnKVgV4HzcXQqm9fHKPiVeqEnaEpERe7Y4
         vADjAlEz+BjEYW0YfJ+myEoZ79RxQ4iGEc8sYn7SNRr35ZWVEGaJkBIl8lif4nq0YNRW
         rHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2GSQXFH/qh+AH5cgM3aLb+3xra1DIU1MyGORiEWzVF8=;
        b=50rI3xBVjnWW7I+ROlsgIgIAjrxSRa5POiKMs3scpUEXPI2+q3obioarYjiZ9tYbpR
         Yn0NLGRGAPjk4r4oJ9xwsAhQua92mxu94ktCr1sHf/z7FdSw7hhQzAsY97kY5Zep75Ac
         VFz4hSPYl/E7j7/7A4DNreEKEe3mx7EL2Fp4/Xsg74dlZBp9fKmBB3pp013bnPV/dj8l
         ThUt5XMT2or3vnUshaw90fKFdXP1CbkxqttppY3nxdv4nl3sVWiyKqKlsMmMj0ju2N6V
         01Z7pFKD2o+FkjPjFjjbadOl4DNI82lT4GAaw3aAc62ubRRaA55QvObrQrgOFRDweiQQ
         7mRQ==
X-Gm-Message-State: AJIora8RwbS5ZYlGQr6VWKWw87Hf2l1bKMxjlx82WKfdeKxAyGz2azLn
	jxvKTs1aHODgKG2VZ84jzyXs4DilerCo6uW+
X-Google-Smtp-Source: 
 AGRyM1tI3NMg+m2cEtiRhGqqmaoVu9X0GM7ENIBhrimt2uT5PGgyhut5v4lveUGx8rtNRmurwE3HJw==
X-Received: by 2002:a17:902:d2d0:b0:16b:b955:9b46 with SMTP id
 n16-20020a170902d2d000b0016bb9559b46mr19771079plc.125.1656922963604;
        Mon, 04 Jul 2022 01:22:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e3-20020a17090ae4c300b001ec729d4f08sm11985742pju.54.2022.07.04.01.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:22:43 -0700 (PDT)
Message-ID: <62c2a353.1c69fb81.7b601.1889@mx.google.com>
Date: Mon, 04 Jul 2022 01:22:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 2 regressions (v5.10.126-cip11)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Jul 2022 08:22:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8647

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 2 regressions (v5.10.126-cip1=
1)

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
l/v5.10.126-cip11/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.126-cip11
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      400500e48ef52304feac8a819c6c911660ce59d8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62c292761a6549eedea39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m=
-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m=
-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c292761a6549=
eedea39bcf
        new failure (last pass: v5.10.125-cip10) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c299079795f5ce72a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kselftest-futex-r8a7=
74a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kselftest-futex-r8a7=
74a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c299079795f5=
ce72a39bce
        new failure (last pass: v5.10.121-cip9) =

 =20

