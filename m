Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C928C761AF
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:38:33 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.39377.1679481509873178305
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 03:38:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=eKPp3hIf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id bc12so18251861plb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679481509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ah/Rob+JMhi1Vych4yF9BFIgL5XRxG2d7qf7GzQWmg=;
        b=eKPp3hIftLMshWVIu+cKawuQ4yJm9pIoQyHDYepL6EGjOp/29DqsvIvCNAo1Vk8zQC
         S0VUjvYIuPVHgq5kncH1HVdEaQL3Z26QiUIFaGf08nWYZWyq99XI+n3yL3hUkD6CNVjI
         p7KXtS5/lt4Si5bKJlEj+Scrg/6Ijjpx4U3kOjcCh0d2DxqTAE19cfoFPCb4iVJSaisk
         yhyq0spA/MbA+l04NRGI68T4SKsmGeGN3onOi/+88aMSIBT0OjC6+HR8RGJPlL7TfAZM
         TypUkqnSTUpyFY2icWSBSCaV4FkpPrw2h2ImP40+HUVf3HJjRqZUaVIbJzS/9SBd+tju
         VLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ah/Rob+JMhi1Vych4yF9BFIgL5XRxG2d7qf7GzQWmg=;
        b=P06wFpaSwpcV7cZ8+Puq+hLQ9RwtM2UCQmduvwbKpeJyvVsuAX+F86dJxHJ5KEKcbD
         sRglWwB1ZAFp1EyyIdunjOfVbH887kb+IePyLEKGwkRGQhUt6VwB/AORJzt9yMQQurvE
         uM0WNAmgoV1XrDbJvuTq54R6ce2yEy/2/7q6avHMv2UnxmaktKklLmDc/N2vn33xTp+7
         dYgDVHjBPai86UnXFsWiqrKhQtQH6g34cJxH3HHUrheXz1suExdhQK7+1x+03ZIALVgA
         202p/YEns6l/4kWX/4ZOvGr2M4luFcYoQ9TcajlD07nyKznk9XXhCdkfO5PWv/2rx7cx
         WPNg==
X-Gm-Message-State: AO0yUKUHjSazrP/eENjGGtcmIZ5kSWvSQq4TEEmzIdCywIfd8JzWBRwo
	YB8AHyJdwitj55fqvgJH5RhmM2idXpq5Q9ypGtQouA==
X-Google-Smtp-Source: AK7set8JfDjoJIG4v4WyJ5xKZOVHE7N71W9Tkm9nUmhghMPMDkre81Gs9x3R62CFCcF/AH5hm6ih9A==
X-Received: by 2002:a17:90b:4a46:b0:237:d2d8:3256 with SMTP id lb6-20020a17090b4a4600b00237d2d83256mr3173009pjb.20.1679481509080;
        Wed, 22 Mar 2023 03:38:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902bb8800b0019ee042602bsm10272902pls.92.2023.03.22.03.38.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:38:28 -0700 (PDT)
Message-ID: <641adaa4.170a0220.93456.2a5e@mx.google.com>
Date: Wed, 22 Mar 2023 03:38:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-1098-g26d9f86d942d
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs,
 7 regressions (v4.19.277-cip94-1098-g26d9f86d942d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 10:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11070

cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs, 7 regressions (v4.19.277=
-cip94-1098-g26d9f86d942d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.277-cip94-1098-g26d9f86d942d/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.277-cip94-1098-g26d9f86d942d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641ad460da82dede049c9527

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/641ad460da82dede049=
c9528
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641acf40bcf3d7b0fb9c9528

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641acf40bcf=
3d7b0fb9c9533
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641acf40bcf=
3d7b0fb9c9533
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/641ad21043424b90a99c9508

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-cip/ltp-time=
rs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-cip/ltp-time=
rs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641ad210434=
24b90a99c9513
        failing since 126 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641ad210434=
24b90a99c9513
        failing since 126 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v4.19.265-cip85-rt27) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641ad26cbe471d9dff9c9505

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641ad26cbe4=
71d9dff9c950a
        failing since 133 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641ad26cbe4=
71d9dff9c950a
        failing since 133 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

