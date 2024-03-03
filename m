Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B31C54E41
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 21:43:35 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.83877.1709502208920179872
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 13:43:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=f1/sVPR1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so14223185ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 13:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709502208; x=1710107008; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dAqvUGU50nOseA2osbqHPLnvk46NEEzppxclF7DyzuE=;
        b=f1/sVPR1/CLiuuZcvSinH++/6lwWaRkRjjllbxawVDcRDvqsGOPXg4BagQn27dFXl2
         4jOra47vLUG4yAk/mNAdC7ren6wnB7oyaN4VIYF+8eAHwd9O6TAuYutt8ycLNQPwh7jB
         MrngjQUmCsCfVzLFiMOc34VJXB3l45mZcdEr2XfHHlPnbN3CDMwQZ4CI+X1z5tkSu00X
         /i+mFUAYMPxgSXNm3+LVkZt2ksa17qGZ1Rl7F4vk8SlGcIleXfu3TO+NUsjs9zXAoD1u
         dM5QSzkh28HXjmQfQlgohxgWd/cQCVV7/BH6azIYhqnV5OmnJG7BhOvEPfPeEjSCO3Zq
         3liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502208; x=1710107008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAqvUGU50nOseA2osbqHPLnvk46NEEzppxclF7DyzuE=;
        b=Qvmh/zKchc7RBrbQJzsxDYWvxpTSYXyqRooO+8JuGIygXO19qYy8iLVMoLv2xOrCQX
         fJCyA40T+0F42Smua6mJ7jqMf6fNyaZmJgP9OarqzvJDehwvSD/q8LHyCd3TF2VyJwHy
         VX0GKXWf4mT3Croo58fjU8c5Q9JljQHqASKkl2sPNd44aoP8XCe2NqemP7v4DS+lve70
         pLPIfCoKMbPiWhey9FnjlRekfuZDM7u/epXC+9nsGH+Pt3HMm0rler1LJMP8Bmn7LZSS
         yZGsdMp4yRjwgMdEau2x9XjzPLwjdO304V0TkaeYxDXl8yBinglV/E3SggFsGj0zue0O
         q3XA==
X-Gm-Message-State: AOJu0YxvWLRtz8kTq5EmNSosZ6EmoLV1Ij4T7w56wbSQEsGOXj6Qjr9q
	21SVaZY5MbUJoksxCM0Zm9WoiW04rN9GdL+xgqIN6iEn0Y1DFWpXGRjGV438uKquKjT08vwIByQ
	Q+bs=
X-Google-Smtp-Source: AGHT+IEOhXDSenOSqXvwxHt9LZUiKsfbmRywy03yKMCmpOU46GtB4lo6MDtDhZOGSPRLjlUS63TDVQ==
X-Received: by 2002:a17:903:187:b0:1dc:adb2:628c with SMTP id z7-20020a170903018700b001dcadb2628cmr8742722plg.34.1709502207643;
        Sun, 03 Mar 2024 13:43:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001dcfa89c624sm3115616pli.250.2024.03.03.13.43.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:43:27 -0800 (PST)
Message-ID: <65e4eeff.170a0220.59e8e.893c@mx.google.com>
Date: Sun, 03 Mar 2024 13:43:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-547-gb5450675e67c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs,
 2 regressions (v6.1.78-cip15-547-gb5450675e67c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 21:43:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15184

cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs, 2 regressions (v6.1.78-cip=
15-547-gb5450675e67c)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig         | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-547-gb5450675e67c/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-547-gb5450675e67c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b5450675e67cda5a44ee81ea4d17ab5db9b7deff =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4e350cc84bb1872637014

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/armhf/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e4e350cc84bb18726370=
15
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dccc3987abc561637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e4dccc3987abc5616370=
13
        failing since 18 days (last pass: v5.10.209-cip44-526-gbbb905888ca8=
5, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =20

