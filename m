Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F26BEB64DC
	for <webhook@archiver.kernel.org>; Sun,  9 Jul 2023 13:30:03 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.17185.1688909397554509875
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 09 Jul 2023 06:29:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=A87LDOmN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-66c729f5618so3079431b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 09 Jul 2023 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688909396; x=1691501396;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru2fh7Gzi13r+jvTJCVRy6dPSlKTnka8kQku+v05oP0=;
        b=A87LDOmNQnogY+NwSnaJJrnZCf5MGINWWs4O/st5HrxaVaZ57Ew0nAOSf4sqDRbAkc
         ZKf5b74GDYrUGjspJ1ym5q9ryuxZDIV/ZBYGXfawmfmHrRCiHniE1y+l5WgBDwl9uZhe
         xFKWOSC41C8v4F0u7qPbMktSvIOzMjeoktPWxoxazJkb/9gcS5z/kIsCSft3s1ksF0l6
         BHw2QLEC0VQLrQR9tn2rNhGILKOOzS/gNiNGcWUs5jEGXCFYtnpa37gJdjCsQt4IUoVv
         tKNRceNXlHnUS3/LvBgHSkS1gXX15W/dhwCylkb6pNL5P/OALP03KhglE55fy2hvBAeA
         yRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688909396; x=1691501396;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru2fh7Gzi13r+jvTJCVRy6dPSlKTnka8kQku+v05oP0=;
        b=G09GysP1c0sFqgz0jWmG/dGxglOC9U8OifZRb2ZXVMrAxo7a2b7f1TlC5hSPBiUigi
         LxWYpDTKenxE5kWMT3OAAR08wVJc9VGoWBQmrN6wAtMBdgNrRFLB/6RVxLKeNIdfELMc
         f8j0Xpw0f0rfuKEi+7aHM6kdiRv3cJ7dmBF7itd26vlTxQO+uJPWjI9EGddYivD12uqy
         R6UPDznUIS4rT1ZIW7HchElaD/WP9f/skipuvyP/owiyKhH2u4nQ6g33IJfsW2+p75L/
         z+ND450HhqT+vRx9RaRMl+GOKIuUhHg37IVp1VbL1GWHnoDQGQJOhlyo4JjYjWX/KHNo
         wgbg==
X-Gm-Message-State: ABy/qLZHW5AiE1mhej5NXGska1xAdng/UCUMDrEAN0kI9xT/pPFjv9IG
	H5B1Qlmrl7s2hIO/4Lmd1B+8TmBdURFWDAhyANE=
X-Google-Smtp-Source: APBJJlGm0NPR8nL4Oizrj16Wz2cbMqkNDye0Fs3u39c6UCSLABfQeK1nBUjj3RRXZE4c+LSqBOi0Ag==
X-Received: by 2002:a05:6a00:150c:b0:676:76ea:e992 with SMTP id q12-20020a056a00150c00b0067676eae992mr13496665pfu.5.1688909396360;
        Sun, 09 Jul 2023 06:29:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78107000000b00682c1db7551sm5474178pfi.49.2023.07.09.06.29.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 06:29:55 -0700 (PDT)
Message-ID: <64aab653.a70a0220.eeb46.aa44@mx.google.com>
Date: Sun, 09 Jul 2023 06:29:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.31-65-geef5a19d48f6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs,
 2 regressions (v6.1.31-65-geef5a19d48f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Jul 2023 13:30:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12283

cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs, 2 regressions (v6.1=
.31-65-geef5a19d48f6)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-65-geef5a19d48f6/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-65-geef5a19d48f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eef5a19d48f6fa603cebb6b0341962fd9acc0e3b =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/64aaae21e59cb5e171bb2a96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselfte=
st-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselfte=
st-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64aaae21e59cb5=
e171bb2a97
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/64aaaff7efac71b030bb2a82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftest-f=
utex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftest-f=
utex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64aaaff7efac71=
b030bb2a83
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =20

