Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E9BC4321E
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 23:17:56 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web12.434.1668035872378495091
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 15:17:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=aGSwLY2a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 6so58234pgm.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KftMdcewNo0mUB/ekm86Unn7guwMpN3vk+pdVNHlcno=;
        b=aGSwLY2ag4rHpx6izOtaZFX7AoK4l0YQoICIR/gfo2SL9Pn/JWnC5Bv2ZGdeko5jpx
         wJgAnhtvCbPg9u99WK07efctlmEukE7HbML9pDUwOTxpMFNXJHErrWEUsfdGd5NuwKhF
         yq28YvwKXfzGmCXfwNJptY5acA72TXvslhZ1f/0gqGy4gjKbKJOkSOk7MfG6ihFSmnrj
         kiMcMpwdjoC01smhehG63ZYsXvxUvbLNfLxUggWyO0xbtPHb+Xe28CuTuDHJnoNhsmJf
         qq7Ws7qzGD2S+Z3Nlown5llOLaxEG4NSfCUWEZ/sqhs2CV4PPlRoClmIEpWd9GWTLJx/
         D0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KftMdcewNo0mUB/ekm86Unn7guwMpN3vk+pdVNHlcno=;
        b=bpkdJECya+Fe2RjsPnaolgltLwzIDzaEA1/67KMLIp94DusM4O4n0AhWK7/G/S0W34
         JSHkRR6G/T3BJxAPnEOWEyDFjqU/+ZC4/H5aadaCK0W2HPgxHaAk2e/vQL/XM75MzTyg
         TclXHm4boqpt4m7LDlkFQ9UtqWWxU6eAVIThWJDDbreSt+GnHKHasJX2MjGVH1w5Mp05
         WnoTePqKg3H7DgxC4scqi3jMsgDG49FpWYG9QX/2969kKgVaRpwvRsqn70n425od17ue
         UpAWB0vAnx5IN+OukUDCfUaVfdtLfgazuupUh2Rsb/v5FjJGR5TOyY1N76PqQmx56fU4
         bfiw==
X-Gm-Message-State: ACrzQf2O/vYiTk9IMgHtVUZi02N/v8N5wwlHrpzsXDv6e/Bz5bU4aWIm
	l11DS5oWtomrcZBnPd6XpVnngM86VzWYtnpmsL8=
X-Google-Smtp-Source: AMsMyM4BG31VrrADvEHjirbdqKuVWfLSdM4ZkjmVGDFuSthcB8lZ7BGiAtNUeIthp74uHQfnXdUkHw==
X-Received: by 2002:a63:6d48:0:b0:46f:c6e0:6942 with SMTP id i69-20020a636d48000000b0046fc6e06942mr43487852pgc.588.1668035871596;
        Wed, 09 Nov 2022 15:17:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a056a00000e00b0056bc9294e1asm8783228pfk.24.2022.11.09.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:17:51 -0800 (PST)
Message-ID: <636c351f.050a0220.91a92.ef86@mx.google.com>
Date: Wed, 09 Nov 2022 15:17:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-rt8
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt kselftest-futex: 3 runs,
 1 regressions (v5.10.153-cip19-rt8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 23:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9989

cip/linux-5.10.y-cip-rt kselftest-futex: 3 runs, 1 regressions (v5.10.153-c=
ip19-rt8)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.153-cip19-rt8/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.153-cip19-rt8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4b5bf35ef58ec8f9f73fd6fec577de2f6710955f =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636c254e6c6fdb4bdfe7dbb2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g12=
b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g12=
b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/636c254e6c6fdb=
4bdfe7dbb3
        failing since 39 days (last pass: v5.10.109-cip5-rt4, first fail: v=
5.10.145-cip17-rt7) =

 =20

