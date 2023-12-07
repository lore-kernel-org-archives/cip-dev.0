Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF78DC46CA7
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.84744.1701957723866499016
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:02:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PELrygrm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d098b87eeeso8151045ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957723; x=1702562523; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a4Q6Y/a87unz+n4Xkg5rmncKFFdnys9MV4Hv1gCAJeo=;
        b=PELrygrm1My2XCArQXjSaMocjvZmA7Pc84cB6Etgcwt+2iGN0FyaTxGiNG8Wu1tgNk
         d7hkiFaCHdLS1hOlN2vIUQgebofCuJh+qiEO0YX7haw168WILpnrmhsBfi8pETPlURap
         UT0809o9VIg290ToNOHJCGJTmPSDNgHHQAaRT1csmWcuAJ8TSGqh3uk9n1eSuDGNfqur
         DHV2oMysWd8g4C1t2pLB26Yy5Muf64vRicKgkpAURHSfIfpsLBtQNnVNQLtKTY3aTPsH
         q8pOVk6BQUF2TCY30rI8jq3g5WX+UAMV82OL4i8fg8uotyq9ffH0PWDqq1zjdERARylS
         HmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957723; x=1702562523;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4Q6Y/a87unz+n4Xkg5rmncKFFdnys9MV4Hv1gCAJeo=;
        b=sLIx4YihKISgqYFdTPeqO6Lp5wyG4F1G48wkJInubUzvBG6F3btY1r/SiyaVHvyVVv
         Kok0tmM9GcYpXTfoPt2snE4ugroq/5Pjtkr4BhQ25N16LaPHrfLr2Rz4pzCzlP9h0jZ9
         2BkbfNdizQY0SyHRHcpU0trxif2sGir2bZhEadU+3jEEiItkvsNIbvbiUlFkV4L+NMgs
         Ahvq4KBCdToq8C1dzZjysJknlXig7XmumPzdrhLkcTcWRbV90IDany3nj1zA/uCR9jCa
         Lu1OkiCOfBZheLSdardJTdbG1pX7eWX20PMOsGfwKN38T7GW8C+KxDj7+CcLth7moz7Z
         LGFQ==
X-Gm-Message-State: AOJu0Yzh3rMzEjUP/tHAQeVE8I63YUGvo8QM3ML4ilJgPRTrGRPZ8TgU
	7o4+FoDh+xvoPyospaKDKfp/W1Fu9+oxrVcz74fyfw==
X-Google-Smtp-Source: AGHT+IExqF89HA0Q+MZ/VGkavhPVqGsR2wth6KEfYC1IB80nNKKBgzUq052xp/P0hnCP58p1Mui2zg==
X-Received: by 2002:a17:90b:1298:b0:286:6cc0:cac2 with SMTP id fw24-20020a17090b129800b002866cc0cac2mr2286915pjb.57.1701957722733;
        Thu, 07 Dec 2023 06:02:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ev4-20020a17090aeac400b0028a01156d24sm1363571pjb.49.2023.12.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:01:58 -0800 (PST)
Message-ID: <6571d056.170a0220.ab72f.3196@mx.google.com>
Date: Thu, 07 Dec 2023 06:01:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip ltp-ipc: 15 runs,
 2 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13871

cip/linux-5.10.y-cip ltp-ipc: 15 runs, 2 regressions (v5.10.201-cip41-16-g3=
c85fba3b6e5d)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6571bb3383d8a1d41de13478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-g=
xl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-g=
xl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6571bb3383d8a1d41de134=
79
        failing since 13 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6571b9726cb1d87f63e13479

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6571b9726cb1d87f63e134=
7a
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

