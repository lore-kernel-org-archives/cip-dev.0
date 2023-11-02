Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB233C4167D
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:49:19 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.38681.1698947356216442635
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:49:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=DgbndjCm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6c115026985so1298797b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698947355; x=1699552155; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WYugoU5O/X3lpPwLSsn7224TTTXWadV1G/4yNA3AgUM=;
        b=DgbndjCmAmKJBLquQWNq7HBFxGlBu06W/aBNKsYMFV57EAQfLWkRUmhP+RIr0ga8so
         17x9zQtRa/nfPNop+Gc2vrrjs8uJ23Lvxhrzf42dKR4u1sOAIJxUPq53+k7GhqUkk79M
         2Zsi27Oz95cqKnmoUXouPeV6HtcKcNpZAf4TZ1VTBnJwP6KiX0uhK3Pu136f41/Mtu9O
         RYd2YUmjzDOziSltLMbzUfjFox3SHnmK+Z8NlvUw5xTobVk8lcM5C+KXnNLwv6aRm9Oz
         1DHnegxrs8QsdniTD2oq3s8ca/PodHIj0784us3bXae9S2xQ1gL3EsVMdv4kO9EIvIV/
         oeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947355; x=1699552155;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYugoU5O/X3lpPwLSsn7224TTTXWadV1G/4yNA3AgUM=;
        b=YGpStDPgOZf/s/EO72ItfNIeNvmQwvxdxHP4O0Bu/3YC3lHGPf5CjpmGKeNjnbl8FC
         eyaa3b6NjQEqJFq0OpuSZYZZP8accvSLCsfgXARnGaQ1n9naMjUgtVIVfMF/jk4vMOn3
         XLhkRM5HRI1ny2WORSVQ9yusAE8wnxB1uvG3f3CuFLmociajvfjjt3ANrzOv6jnnVhs+
         /IzjTrfQHpv4xyUtmkPWs+FTFvOBDCZfsnKbVnNKyWrd4DvyvFmHbOLkjuUxXI5+6ztd
         MJYMuTu2IHe2fYG9CLLBLQ+7lCmWkBdOme2UnRXmzuN+6svuPV5iW2e+OjxP4al4tJwj
         u+RQ==
X-Gm-Message-State: AOJu0Yxq0tp7BChaZpXEliylzlAVJ+PDKeOYRTDxiKJkmoC83sqi3wKW
	dPo6jNh2lvfbJFB8AEtHhmzoZlif9lXWXooMI5wNLA==
X-Google-Smtp-Source: AGHT+IHKcQQcV+XmY4YNUDBkJ8Wt5suNq9siic5AsOikcPtFymW86DVx3CNJ/UATW7tWXy3c2dHt8w==
X-Received: by 2002:a05:6a00:23d5:b0:690:ce36:8b00 with SMTP id g21-20020a056a0023d500b00690ce368b00mr23511063pfc.2.1698947355235;
        Thu, 02 Nov 2023 10:49:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y15-20020a62ce0f000000b006b24b99afd4sm43830pfg.176.2023.11.02.10.49.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:49:12 -0700 (PDT)
Message-ID: <6543e118.620a0220.a7609.0489@mx.google.com>
Date: Thu, 02 Nov 2023 10:49:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs,
 3 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:49:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13526

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs, 3 regressions =
(v5.10.194-cip39-915-g96fa7f16cf02)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6543d177c8422ce29befcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6543d177c8422ce29befcf=
0c
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cb336ab8393ccdefcf24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6543cb336ab8393ccdefcf=
25
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6543ce8e113df631c6efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6543ce8e113df631c6efce=
f4
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =20

