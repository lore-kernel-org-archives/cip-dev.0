Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310C5C48295
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:20:44 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.9155.1706826038178887947
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 14:20:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=N+cltie4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddcfbc5a5fso1185516b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706826037; x=1707430837; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+KLtswdm6UFxDTbu4dmuC0fdxd/msP6ZN8WKO3Gojcw=;
        b=N+cltie4+xGN8ZrWKqxZ6ltQqzO9KA0ijLd2RkVHcc2WfRQpASVYLmjYJBkKn5+mt1
         cHFRSKcSSeHkNpDydA20RJ42b7PtblY7qCn5jEQAWGQTF+lWf0fN6lHVcjQf6A5MpFw5
         wSReSZyYZt0iEZAzGRg0sbiRJ0rNd3uU0DZJRpphI3kuVA1XQmZdMXAF4Fj5lRKEsKCJ
         PHIgilAi/ubjtasqshee4lWWbXsk60IRnInrFD/6ErpupPe7l+Y8FKO7yLnjV5gn3ey0
         EkKcsL7kij2PRjMe6GibCW4wdr6B4G49qNdsEIWI5YkdXhmgJPg572R4VzgqfDvkUsoc
         vSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826037; x=1707430837;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KLtswdm6UFxDTbu4dmuC0fdxd/msP6ZN8WKO3Gojcw=;
        b=JhczO2evljN3f3bBbYc3LdjNgli2eUPA27n/dWxU47440WCimSVmucvWisRWBFwrUa
         l74cqFK708chSNNTKYxOqVF7ECBTMLJOWx/3At0tlViuOnXJttZPKtNh2b8VQfXdEZFj
         N0Xp2vTFI7xQNgj0Ke10G6J/KQxNXGMIu4W5APKF0dPze2wvxB/+1QpGIYO2GQ+mGS0O
         00yZPEer5momQIQyYjR5Y5lX8xQpeag1c9hxWhj/V1P4vMKRdv2BO4GAEtp2Ow4VS5in
         LBZS7+70xt/twNC+RmdA9wYEBNSYikNf4ZKH/RWJEchCLHxu9kuIN9tQyBbND+athbFs
         OmSg==
X-Gm-Message-State: AOJu0Yw6WimQ+1rKyIiUr0be8vS+rs9631mu8SM64+SJah8OH9GssZDP
	x65s14APQ7yJDF+ahhUDRbNbgGBJjCGXtQw2cIobWtQVMMPEa2Ucb/Dw2cgF2gB9bpjlLidh0XY
	g
X-Google-Smtp-Source: AGHT+IF7xLdQif4IAp+EcmNMnsVxno6/UCisnAqjJijOHFrgd9fBuyGaijKQikQkB5k/Jw7VLHMJ3A==
X-Received: by 2002:a05:6a20:e125:b0:19c:a4d3:2041 with SMTP id kr37-20020a056a20e12500b0019ca4d32041mr4389056pzb.42.1706826037110;
        Thu, 01 Feb 2024 14:20:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVyE6KMWuiVt5rWSjGQbGX9AesJ0xDn2eHr9G22kFMiCbGkP3utSLgLa7j2ysp1KxBWQINZNSFIpXmjxmvEE1tKU938jR2BmjroKPPlQi+FRhc2UqUC19DhgEGebPhsP6z923TAApxDQZ5NozRNrHzX7A==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f28-20020a631f1c000000b0058901200bbbsm345151pgf.40.2024.02.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:20:34 -0800 (PST)
Message-ID: <65bc1932.630a0220.c2933.2662@mx.google.com>
Date: Thu, 01 Feb 2024 14:20:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 18 runs,
 5 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14596

cip/linux-5.10.y-cip ltp-ipc: 18 runs, 5 regressions (v5.10.208-cip43-4-g1c=
63c70fb18b8)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc07e9d3c16d090c00a063

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65bc07e9d3c16d090c00a0=
64
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0d4dcf574476c300a1c1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-gx=
l-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-gx=
l-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65bc0d4dcf574476c300a1=
c2
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b22c71e25877600a04b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_s=
mp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_s=
mp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65bc0b22c71e25877600a0=
4c
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc08f3043c20a8c700a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65bc08f3043c20a8c700a0=
3a
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0e17cebba14a4600a04a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65bc0e17cebba14a4600a0=
4b
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

