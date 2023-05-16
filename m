Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB08C77B7F
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 18:27:54 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.29665.1684261669969203463
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 11:27:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=hfOjMgdS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so7760688b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684261669; x=1686853669;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7pKu6j0Xt833uU/bCtpA493nKqfqw64ZyfSg587uhmY=;
        b=hfOjMgdSfuYf5wsCMPdPm4NmD0BDiQNYA5wnaxgMg3Jy9Q0anwEdm+RINdOMUzWG50
         OVHu3Qc6KtXBJ6RZ9OjLcefxkJLxOaKTw2Be6wmr31r9qIH21UuUW5V790SsiACOtTet
         d3Lnt1hkokFcO7t6/C5s6KnGOfdxf9YeB5lZG/COiLHT+sMjHdIq+qeGZOKYaXi2KSIR
         atV7KxQVI5gDCsGzIwSKBTES/KWuIoqLmWH4mA2i9xKdYYC3LPAdTgna8oac900akC/Z
         YwquDr1XaJ9uP2b5Mld4E9p8tljED8x4joPNeBQD+/tg93//9OY5e/Jih7hUqLsAUtyU
         UCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261669; x=1686853669;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pKu6j0Xt833uU/bCtpA493nKqfqw64ZyfSg587uhmY=;
        b=I5M5vr0SBDEFeEqTZP5SP0IYGWUNfDr4eqcyxo7beSuzvhfhlANZBxmAtfgHQeWtQX
         qCxrjhlECVvGwz1abNGAR6V7t2M56mJj95jWLArq0zj/ogSDgtRYnQNqbMD3MH5eRcNX
         lacQJeRn/mr8w82De04d0MeEL95VXhDGVGt7svhJyAEc+z4s2PIJMRgig9zcezGnp63K
         wzQwE+6teH2JTBWUlmXJkzy3YF/MahCkQfSBDZbtg7R+T6KnDrbLDpM96dni9K6JoSo9
         x9u+Cu/goxdlEOD/MzpQCX4dbMaDos9QnVIfDGDD6ptrIU5FmLj1WTsAjjf3MlRWheFz
         aCpA==
X-Gm-Message-State: AC+VfDyvWwY1b/jut1shPCipxgKSrAzPbpvil1gWQlocgrr8DebsA8rQ
	b1oSHGvVDZ0tekT59OdydGI8X4DERu4SaID1kGN0Zw==
X-Google-Smtp-Source: ACHHUZ65DwIHrz1RLGTfHift546hHzrQkPF54iDtDADZmNjdLxKY6vrZuxH5EEHFkuiY0zJ9FZoz0Q==
X-Received: by 2002:a17:902:dac4:b0:1ae:89a:a4 with SMTP id q4-20020a170902dac400b001ae089a00a4mr11940179plx.8.1684261668908;
        Tue, 16 May 2023 11:27:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b001ab12ccc2a7sm15856990plp.98.2023.05.16.11.27.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:27:48 -0700 (PDT)
Message-ID: <6463cb24.170a0220.801eb.fa72@mx.google.com>
Date: Tue, 16 May 2023 11:27:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-4-g580ea5dd85ae
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 36 runs,
 4 regressions (v5.10.179-cip32-4-g580ea5dd85ae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 18:27:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11471

cip-gitlab/ci/pavel/linux-test baseline-nfs: 36 runs, 4 regressions (v5.10.=
179-cip32-4-g580ea5dd85ae)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-4-g580ea5dd85ae/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-4-g580ea5dd85ae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      580ea5dd85ae9165b28861c2f5ab8bf05a13ecc3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c38544af6c44c32e85f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6463c38544af6c44c=
32e85fa
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c60030f042260a2e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6463c60030f042260=
a2e85f0
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6463c28ef9a7ab02a12e863d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6463c28ef9a7ab02a12e866f
        failing since 55 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-16T17:50:48.934465  /lava-10338791/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6463c28ef9a7ab02a12e8670
        failing since 55 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-16T17:50:47.863493  /lava-10338791/1/../bin/lava-test-case

    2023-05-16T17:50:47.889815  <8>[   94.755888] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

