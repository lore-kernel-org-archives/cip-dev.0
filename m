Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16867C61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:31:15 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.19826.1678714268801896994
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:31:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=i36FdESP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id u5so12920425plq.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678714268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DLeJ3Y3G5Cjyd3zgHN/Yxl3k9H5SPWQWVM8x3vkQCrM=;
        b=i36FdESPUfvUjhOAnS10JYoE3f9xuosZHKb/puMXnJd6TY2oITIQdDMJan8oE2aHb8
         gHT+dSnilEqAVEC/clY/2MqApTIN7H8kosFanr1S2T7sSHLvGFbl3x6XOTwyGTxi6+4+
         yhBJJaH+ACk+iusXIZPLNjFUVmSZgDtjOdG6pmutSX9S8AqL/QhMEpxk4NG+W9bn0Rp4
         qXydlGDJKOpStOWaEpJH70OOZtn+SYc5ecfkfiObtlzG1DgHhsDoSZbdXl8XeZhEPvsa
         QsQlJjR9l/M3aGuBkE9uWWgz9VOQ6lCT+V9KBnQBit6dfNnogSfWpgGxTgJ00DqEnohs
         l6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLeJ3Y3G5Cjyd3zgHN/Yxl3k9H5SPWQWVM8x3vkQCrM=;
        b=QS4eSxluawt9gaCJnVW5V8/K0IEl9bmpOR5yoYsie40LU8N5p9vqIa84zNlJhQSTGW
         +Kov14LDou4pbT1krzXSi+yMenHdAfHuePD2VScEzTCZMRSOjQw1oEsEyCA9OTyTyTe+
         kfSR+T5/9JdFvZYNECY8AmrVNs1kP0IN0rctkKjXFYm31THyamYHQeEDnveYRYkBCUR+
         exePssrtN9xvuaeAcYuWzciIQtU644+IAKzLvOVRSYYFnFZpnfDywDQD8Dmw35Vmc6ms
         ftqaexk8owcerVxqlS+7iVr8lC5tT09JhGBqAelIPEKOfOC1RIvTt0BCkMGV3qPTevyJ
         FNDw==
X-Gm-Message-State: AO0yUKWOz5bc0Ib3CawfGzn7LnPbWCxICNT+DOOdZl9tPSGLepOGKUNb
	yJVa7js2Bu/ATCXhYkpo3sb80Dr+2iplMXbvzPbdnr0X
X-Google-Smtp-Source: AK7set8zeZ4eWfMyXSeRhR+O2HtsWQ3Ps2dtYYBTKyAvCaIQc+0M/PIU4m9y1kHPinVZVFYPf7bceQ==
X-Received: by 2002:a17:90a:1a03:b0:236:a1f9:9a8a with SMTP id 3-20020a17090a1a0300b00236a1f99a8amr10263798pjk.8.1678714267734;
        Mon, 13 Mar 2023 06:31:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090a9c0a00b0023cfbe7d62esm3805370pjp.1.2023.03.13.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:31:07 -0700 (PDT)
Message-ID: <640f259b.170a0220.18579.26a7@mx.google.com>
Date: Mon, 13 Mar 2023 06:31:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.173-cip28
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs, 2 regressions (v5.10.173-cip28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11008

cip/linux-5.10.y-cip ltp-pty: 6 runs, 2 regressions (v5.10.173-cip28)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig           =
       | 1          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.173-cip28/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.173-cip28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2988848bfa1d1f2c02318f2193b06874fb5f62eb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3cbaaddf6f785d91aeb370beb75d0623f8c48624 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig           =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/640f18d1c582af69dc8c863b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30303.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/640f18d1c582af69dc8c86=
3c
        new failure (last pass: v5.10.168-cip27) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f2501a7a14440298c8649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/640f2501a7a14440298c86=
4a
        new failure (last pass: v5.10.168-cip27) =

 =20

