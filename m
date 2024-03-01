Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E8C54E49
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 15:58:05 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.26800.1709308676535658096
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 07:57:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jDr9jLoV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so41435b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709308675; x=1709913475; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQSIioszRARBDsJfqD5aTl3Q8u1ZYUHZyZ9Sizm6xok=;
        b=jDr9jLoV9Y9y42+5iQu5WXtV/IXDpKAlppXn+9VojkMXaahrtBmAdxU0qNfO0vdlsC
         q8f3YHyOJeFV8YSMtSU+q+T/6FnBOIXlBruOV/AzLTRKZO1zVudueUgzfZ8yEtDU+ao3
         BAZvL1pDwajhENolAiMa9nxUA/zmSzmhlgH95/HnTbV+y+59QZUHdUhMiuv45n/S0tys
         rv25HQS0FopezL9DEnQM8FozRwn10iqqP9ohZzUuEv/CNUaHs65OLdblfkeh987ajd4+
         Dvc4vqlYOO1romfICvenBxscbsCE1GdSSHYDowPCAXYZqrSP3bsFQ4DyEm7g4S9e0y6J
         Cyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308675; x=1709913475;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQSIioszRARBDsJfqD5aTl3Q8u1ZYUHZyZ9Sizm6xok=;
        b=n9fS0ipoKt2zLoqeO/yqjJiun6XmdlI89mk1YqGtQ8dIuVwNmJdrG/IQN3u88p9npR
         zE3Hm0YJjjmTksbKpwSERNC4IiOH7xKEJnWf8NwGFJnl04oqG2wGmWckvFaJjZVQrhMC
         TyD3PNCKEyU+9BQd+oXzbKmFMIwhnLEME4pMcRIbbKr4llQksz2orSkS3abfy+VDCo+F
         pDyBK8UoTYOl1LtMLve+knKhXKYSWwRvjVwgkdRU73QDYIOOLTc6tXR8OvDO/nRYxk06
         +dfHeAGzw3Z4Of6WSqy8QXD88adkAprpveNNihG5tvOswesV+HiRmFZds4r2QHn4lyHk
         7q3A==
X-Gm-Message-State: AOJu0YzLxPI8CFAheBOLpxeAUH8ACIQh+1ts9zbVcxGj6zLyN2v8woko
	WG2rREp7CyAqsABM82c1Fo3t1XGtYtBdoOcuA3Rnhx8W1IPzq90wXmMqZLpC+uLQfEysalveGOY
	wHUo=
X-Google-Smtp-Source: AGHT+IGmQaOvUWe7ooTsyD3qlPlQ+Y6s8SXTlNpcHNsGNbtGcio/9BqN6M4IKSVt3KrVKOsv2Czu0Q==
X-Received: by 2002:a05:6a00:9388:b0:6e5:bb8:dc19 with SMTP id ka8-20020a056a00938800b006e50bb8dc19mr2897349pfb.15.1709308675543;
        Fri, 01 Mar 2024 07:57:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006e56a599acfsm3127433pfk.194.2024.03.01.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:57:54 -0800 (PST)
Message-ID: <65e1fb02.050a0220.f23e3.eb23@mx.google.com>
Date: Fri, 01 Mar 2024 07:57:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-56-g6ff909810a18d
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 15 runs,
 5 regressions (v5.10.209-cip44-56-g6ff909810a18d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 15:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15129

cip/linux-5.10.y-cip ltp-timers: 15 runs, 5 regressions (v5.10.209-cip44-56=
-g6ff909810a18d)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

qemu_riscv64                 | riscv | lab-broonie   | gcc-10   | defconfig=
                  | 2          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-56-g6ff909810a18d/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-56-g6ff909810a18d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6ff909810a18da01523521db983d48116abb28ec =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ed1a375d487a4d637015

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e1ed1a375d487a4d6=
37016
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_riscv64                 | riscv | lab-broonie   | gcc-10   | defconfig=
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/65e1ea22d45fa01ec1637041

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e1ea22d45=
fa01ec1637046
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e1ea22d45=
fa01ec1637046
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ebdb8457fcd5f7637017

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e1ebdb8457fcd5f76=
37018
        failing since 16 days (last pass: v5.10.209-cip44-50-ga624abaa85d7,=
 first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1f3c3f242ec89ee63707c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e1f3c3f242ec89ee6=
3707d
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =20

