Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DBBC61DF7
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 03:00:23 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web11.128555.1700794814114887148
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 19:00:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1IU1SfEI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.52, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f9e2d5bf26so397231fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 19:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700794813; x=1701399613; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j0NPzCaVMs6M1R3xhw5wdMko2o6fsN7aqBYsTXXhwxA=;
        b=1IU1SfEIjALvSrfki0OWovLV8zKE+/DU5wrYFvQBDl+qTmx9Zn4O4Q/D5pGk/FVZpR
         6V9ieAyHw0baR0itg5/5jzFyLLotflWk2NkOrDzdVByGiLqgYXMgBTNnICbK0sF5aedU
         7kx0DrFDHSIO226YbFY4qAHBPPMPOI9LGGUFc+CCLlh7OmxL047l9TqNvzT0zTFCJHek
         dff5bnAU+/IQTacqktpHGcFl+VdoA7yUxoG1Xq5o56T0Xoj0NX6Lhu6xm0LzEMMRd81G
         QuO2jy7uuKfj4Cx2W1TnfyJf8HLvzGePvh8xPG7vb+p069iozpAmZv7CKNOroFwxGr6o
         ys+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700794813; x=1701399613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0NPzCaVMs6M1R3xhw5wdMko2o6fsN7aqBYsTXXhwxA=;
        b=s1npNHq0btWW4NlJ6zwHRS1hJZsNCcX7bGOVDsDj+iaUZ6nXLLMzUf6/QATA1CP1JX
         tKNwuAcye9QKjyxT8c/VEh6bFTfnrEq0lVPJAdnld3p7kzD3tNfLQzcVBdt4IWZq5UC2
         m2Rdm0EfqsfSPhXsJoprKT/vqcybEAmgJEp1Q/9TEnT11u1beXhK5j35V0HREH1oRcqU
         itQDOKIHPIRsn3M2ZYstaMSdyjei9rSXfygvxNIzhVxWYdjQTXTZQWZWq8Ew6fkYMo1a
         UfON7fAHwqNLpIMOh9DVaDpy5hVO7DVsx+X1+4/SrH2R03MYJKITLZhIEiemOoedZIZG
         KZ9g==
X-Gm-Message-State: AOJu0Yx3OFEnMJcqXMuPo2zQPSLFzFhFFSWC3Kzbg4B/DUNAK1tBr/2G
	WwxfFbAqpJbkXZmS8MFmmw1dFd9frg1VDcT5uMQ=
X-Google-Smtp-Source: AGHT+IHB2gXmCkhGwyZTrl1u1eYldbzHC1vYMyvsUctw8DjjELHEXA8QGzib+whSKoqfbljKtKSGEw==
X-Received: by 2002:a05:6870:41ce:b0:1f5:ad14:890c with SMTP id z14-20020a05687041ce00b001f5ad14890cmr1680578oac.48.1700794812881;
        Thu, 23 Nov 2023 19:00:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090a420e00b0028066f3c373sm2162176pjg.17.2023.11.23.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:00:11 -0800 (PST)
Message-ID: <656011bb.170a0220.679e1.6856@mx.google.com>
Date: Thu, 23 Nov 2023 19:00:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt ltp-ipc: 24 runs,
 4 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 03:00:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13706

cip/linux-5.10.y-cip-rt ltp-ipc: 24 runs, 4 regressions (v5.10.201-cip41-rt=
17)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+p=
reempt_rt | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+p=
reempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.201-cip41-rt17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78ed1354cecc021db9a1d8a8b4755fdfcd826e33

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+p=
reempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65600393db48250a257e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-ipc-meson-=
gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-ipc-meson-=
gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65600393db48250a257e4a=
6e
        new failure (last pass: v5.10.184-cip36-rt14) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/656007b992d0e1c5c07e4a70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-l=
ibretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-l=
ibretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/656007b992d0e1c5c07e4a=
71
        new failure (last pass: v5.10.179-cip32-rt13) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+p=
reempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6560032313fabdff4b7e4a84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-ipc-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-ipc-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6560032313fabdff4b7e4a=
85
        new failure (last pass: v5.10.184-cip36-rt14) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/656005b7701db594a57e4a87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m=
-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m=
-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/656005b7701db594a57e4a=
88
        new failure (last pass: v5.10.179-cip32-rt13) =

 =20

