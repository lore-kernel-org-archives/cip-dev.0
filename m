Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D22AC43217
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 11:44:00 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.2214.1667994238959228837
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 03:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fhlKY62M;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 130so3617685pgc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 03:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TEs7mrZDQDdclHcvjO8lKNvVQfBjRRT48F0x8ICW89s=;
        b=fhlKY62M+8eGfRFAVpB+IcdD65sZ9u52lsBu7HeOyA929jvf6O6Y+fksO+iz+ZHR05
         38VTLLczIfJH9aquCvixspBCt3RLjkWrZG6vI4fXsFUV/98e27y70kUZT9fxu5AStTBq
         TrIb6wqzRzdHGLAkJ9nKBB3/7dkWB6wo07lOSdzfAVnrCQbfrOiasId2FYWq3zQurinM
         g4R25gqZ0mLeOitpEk9cGYg/0g00She1NuymcM1wux3z/XJD2cZ5RTipokZ5X76z643u
         p6act82PbWaxPTuhUaGE5ubrsETFX8fMplcMZvfpOt0uHWPCmU+3xxmQuKfVu2hIKjBk
         wE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEs7mrZDQDdclHcvjO8lKNvVQfBjRRT48F0x8ICW89s=;
        b=xHPQ6JRJXIgBkevOh44Enni+ILcL+VVwV0PFW5ir63htcM8iNmvZXPhq+UuQoWp2po
         qkyXKjl69KzcKyvLjxBtuy86eLP+qlRUf2xL6iwrmv93LU8MoY7/SmTKMiHhJpZHtB2Q
         71cuQ9Okh1Y6ZoxI53TA1HuROia/oBfCJIN3FoHfFhnvilKFWtqAhc51HRjoClM7UHY+
         GQkzY4xNRF48O0b4i+mrGLl/XR5rwaz4Q5asLfpuLp8KglxmhtZeb/uqlwra1wUv3yRZ
         YsZ1whjt5Y436mLjqjY6pHh5akzTOTovvuA6pbQ9UL01ZQUQ0X/HXezrvxHOXtf3HxFX
         y66Q==
X-Gm-Message-State: ACrzQf3RreIVDybOlBBnvuZebatRDqo2RXKr+EMNvwd/UAHO/W9ULO/X
	F6bmVDDALWDpLeaqGFX9Gf+gh/xltCdEAIfD
X-Google-Smtp-Source: AMsMyM5BbiREwby6RlAv6U3ySJXlPK1iK5YWmunD7qZhcXZgrY89WIl8refZSyuYo3PhlbY2pvSEtw==
X-Received: by 2002:a63:5b58:0:b0:452:2ba4:f86b with SMTP id l24-20020a635b58000000b004522ba4f86bmr50386565pgm.223.1667994238347;
        Wed, 09 Nov 2022 03:43:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902b41300b00186b1bfbe79sm8863203plr.66.2022.11.09.03.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:43:58 -0800 (PST)
Message-ID: <636b927e.170a0220.86cc.e96e@mx.google.com>
Date: Wed, 09 Nov 2022 03:43:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 1 regressions (v5.10.153-cip19)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 11:44:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9961

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 1 regressions (v5.10.153-cip1=
9)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f7fc281d55b27b299e8388c7d44809289ba8b99 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636b8383002c4d78a0e7db61

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g12b-a311d=
-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g12b-a311d=
-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/636b8383002c4d=
78a0e7db62
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =20

