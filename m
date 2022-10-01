Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F2C433FE
	for <webhook@archiver.kernel.org>; Sat,  1 Oct 2022 20:31:58 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.1443.1664656313200744848
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AmFiYI3h;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id x29so1668820pfp.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=s6aT2K4fBI0rkgbau8+wVeRl4qVmDPWht/oaPYE225Q=;
        b=AmFiYI3hxIiojl0ltv97MyzoJTjnw6I61F2ezwJO3qmV+hMDMgwD8ZWtO7PXSJ+Hda
         xmia13pbKHSmd/Ed9zoOEyMyiZS8HL1jMx1PEEjTi9np3pop9WpKt/t6aN6+ZDbRtOH/
         DZftz3xf+vqYSYb3gXN8vp4D4qg/0IF5+0DgmUtZsDbeMijbGHQvFvE+L3am+/awyqSs
         /AD3rw6Bm2IASZhb+qal0F8HGpN5P/eiRcH4tT17LAYK6xSXGh0C7C+xGIveE5sI96LL
         wMtxlHXI9rdd+eG8cwRatavby3hMnDnNPfbGw/ABoCSDfIOFhvgGldFtiiaG4PfGOcTp
         fnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=s6aT2K4fBI0rkgbau8+wVeRl4qVmDPWht/oaPYE225Q=;
        b=KGccasBLT+Jg6X74gYSG1bUZ6u7cnz0N4byXNTwTD0jCl+OefQKiM/DOEtqecZl7Ah
         SPmfGDNPb8F0JjqTKekoRI2Hjm78MXAq0Vez4PxNJuMNLO+wOyW+Euu9JkAucbkrP6XQ
         gLXNwyiJeh3wN7vOkSbmyV2sHvVgwDTZQfY+1QKwUxXhAvdDA9fRqfas5MsIIoFUCiU4
         UF1aIBPR8Z2nrE5BnKnMKGhCxv9SOuu4yA4uhOtfrI8+cgApCA4g+QA4ptxXcZYU5fiI
         tyaZfKoJdzueej5EWhJ9YjatZE8CSzbN6bLbtUAUFEyARPeA6zAPxbZexbUFPcUgb+UG
         zx7Q==
X-Gm-Message-State: ACrzQf1APjYVuQHotYZXW2AD1QJDJCvLoQP9Y93xuq0l6aM5d7JDpAhC
	aNz2nHOhtlOORXvGzoeSYVj2vVIHHc2LofJ7lNU=
X-Google-Smtp-Source: 
 AMsMyM6ooM7AVmXvkyGRFzEkTEFUho5N8N5jLNu+ePyWbLmXAK91OCGI6p3l0jErFqLvUaczDpnwhQ==
X-Received: by 2002:a63:6a85:0:b0:43b:d845:f67d with SMTP id
 f127-20020a636a85000000b0043bd845f67dmr12443343pgc.349.1664656312610;
        Sat, 01 Oct 2022 13:31:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p4-20020a654bc4000000b0043cd6db9816sm3842400pgr.71.2022.10.01.13.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 13:31:51 -0700 (PDT)
Message-ID: <6338a3b7.650a0220.dca98.70a6@mx.google.com>
Date: Sat, 01 Oct 2022 13:31:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt kselftest-filesystems: 3 runs,
 1 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Oct 2022 20:31:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9610

cip/linux-5.10.y-cip-rt kselftest-filesystems: 3 runs, 1 regressions (v5.10=
.145-cip17-rt7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.145-cip17-rt7/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.145-cip17-rt7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63389615aa6cc47206ec4ec2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63389615=
aa6cc47206ec4ec3
        new failure (last pass: v5.10.109-cip5-rt4) =

 =20

