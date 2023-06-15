Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89179C001DC
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:38:10 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.15036.1686825483197942447
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:38:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=tBUDcdNe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b3afd2f9bdso34546215ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686825482; x=1689417482;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dt/IElcW/lluFzU+W/uvN5+UYfAtsazqXqrzm7PC1Ug=;
        b=tBUDcdNelWcF+vjeot6o3SOFU6jlx6qZwVIeCBfaJUU7BYFyH6W2E80iVkGtC0gz+I
         3WUL5G4DwFBVH+vgZBVNrepLjZUKe4Ggb022ugrBh6GCPg4TyRQHgYRXtYP5H/07PAT+
         R+JbbH1om9xud6Ipi2Qjb5MYCJcHkpDQ/K5doaFMBk426wVpg+d5vlEkKl69C9w1UjZW
         8JtXLoiEU6KNzPsc3HmH8vM0rbTQDp+dOADBgoUXeLCVWyMb50ZdEaW7QRpFhEwDn6qO
         4iQ+Eh/VH9Hf1H6Z9PZG2UZlEURaeamdedeSYaVu1yZf6fPyNrBKyeMmIJcKnopimbgq
         mPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825482; x=1689417482;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dt/IElcW/lluFzU+W/uvN5+UYfAtsazqXqrzm7PC1Ug=;
        b=iyL7+NP88zPUwMZJ7j2tu7zpmt2WYwPJdea7Fhc1yilzQyKhCkvL693n6CAPY7LJqn
         bxay6IscdDvxauI3oAg/zfLMRxroeG90MUD0h7+nhGnxAaVmPzGdeA1ryupoORrbcSGk
         CIJik7hD8/y5DvPlIxvhQD3T3BkiEg3ink4lNn8eWUHfK9zkcnFsV7Eio+3baSD08HYu
         +b3bmeEwrrz0ztNKpiYvf4Cbk6EwSQUIH6ppikdl3Jlx18thSuV+9QunL2Px5fDI4bsD
         2Zpv5sdht1w5QRqxaHxNqmMDOSe0mfRv3BdsjPKmVuJ+kh9DvfqAQ6LY3/bLdwutZgjg
         0h/A==
X-Gm-Message-State: AC+VfDwu85VaX8/GEfMWgdc2PKt1IGO29ALessqeI6daINk1AvT2FuMO
	2qAGA25HZ4GRbd1/ZCTOq0qp1jyNjnlvE8WCLbPUfQ==
X-Google-Smtp-Source: ACHHUZ7/hk8+nREIJqbKB06hI0QwbFg39+1fW5JTyYGxeupsabPBPVYpxSYLAfCmohFj9QK+8EXNmA==
X-Received: by 2002:a17:903:2289:b0:1b3:d646:291c with SMTP id b9-20020a170903228900b001b3d646291cmr10018416plh.14.1686825482072;
        Thu, 15 Jun 2023 03:38:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj7-20020a170903048700b001b3fb2f0296sm3555497plb.120.2023.06.15.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:37:59 -0700 (PDT)
Message-ID: <648aea07.170a0220.715ee.8025@mx.google.com>
Date: Thu, 15 Jun 2023 03:37:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 12 runs,
 3 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12050

cip/linux-5.10.y-cip ltp-fcntl-locktests: 12 runs, 3 regressions (v5.10.182=
-cip35-8-gdba81ae6f2be)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
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



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648adf0ce99def898e306178

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/648adf0ce9=
9def898e306179
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad8a4ef8467125830614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/648ad8a4ef=
8467125830614b
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ae3b989a52c2eb5306136

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/648ae3b989=
a52c2eb5306137
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =20

