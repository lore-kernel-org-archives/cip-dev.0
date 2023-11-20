Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300DFC54E76
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 11:21:49 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.48098.1700479304443601922
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 20 Nov 2023 03:21:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ZYBZBPlE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cc2fc281cdso28431875ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 20 Nov 2023 03:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700479303; x=1701084103; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh4vXR7WONouOs/xfbCIwypuH7lslhMAXvlTFcdYIbc=;
        b=ZYBZBPlE3nhQD5PYE/T9HXcCeErbL6uWpwcB7UZjQJe5X6kAStXCZDsEP0aFXh+wT3
         0WyQlHSLz2SORuHF+iBvv/N5WQX6HIIRP9C2Wp2TUtkdszrm3qj5wYbPjKtRJdhV7QvK
         inqfslnvUXDMjsRvZbA47bcod4y8hs6GsNzoA01LTjo0oFEpLx0/Ye+/yehOQ4esNaaf
         LwrzfSaKcbnp2JIZTfUxKW0VLk9zSftvgAOH8IrM06AM70INzoX9FigHVLYH/o8PikRg
         rTGcBCYvFyHuHABc8J1acTJf1m2UB1liv95qq0KgHPVeCbvZymY/hqixNi1GtkctJfck
         0Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479303; x=1701084103;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sh4vXR7WONouOs/xfbCIwypuH7lslhMAXvlTFcdYIbc=;
        b=ABId1ZeXPWHEq0er4HuGfxpUBaK8YCtOp6zbkLjYmwI2C9zTMPx2D8aNQbT1t4AL05
         FVPV9IG6qGkIb1yHpfyKpNDX1GgXwQJUlyoairy9juB5Io9X91OGNlV9EY4MFeO2HEGD
         VkvjPY9Ayvf3STpS7ZPZSjD3zIYbchEb92EsZpOqUfKoYBKbbw+S4BG1q3ckPhRe8qRU
         uwd/4T8gjBvEN1blJvxNX8qxwZKXPH/nN5lDpRPPmx08fj76YaCe3icEmQ3PlU3aGHWf
         al6WcuF1LDo+oUsTAh+0HzSokt56IQrcXPaAD3V4/0Eo5rUBcyBagfWiRmF7/Yq9vsjr
         MZ7w==
X-Gm-Message-State: AOJu0Yz4cHbSczXRC3YtPNrbMPLoghwpO7Rhw7PZitEJsMT7PP5Kqhwn
	h/TlI0RsJjeCHhcDEwjvZCTuYSfCQksm10qSEVw=
X-Google-Smtp-Source: AGHT+IGN5w/HFiLQ8Im7YKkJ/KzPVvusTddL//rR0sMotGgMSgxaNwFBgrLP4Q2pqnqfveDQiZv3MA==
X-Received: by 2002:a17:902:d885:b0:1ce:5bb1:4e19 with SMTP id b5-20020a170902d88500b001ce5bb14e19mr4452684plz.66.1700479303021;
        Mon, 20 Nov 2023 03:21:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001c47541ecd7sm5200976plj.250.2023.11.20.03.21.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:21:42 -0800 (PST)
Message-ID: <655b4146.170a0220.148e4.bed9@mx.google.com>
Date: Mon, 20 Nov 2023 03:21:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-513-g195b5d2b5c744
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 5 runs,
 2 regressions (v5.10.200-cip40-513-g195b5d2b5c744)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Nov 2023 11:21:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13599

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 5 runs, 2 regressions (=
v5.10.200-cip40-513-g195b5d2b5c744)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.200-cip40-513-g195b5d2b5c744/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.200-cip40-513-g195b5d2b5c744
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      195b5d2b5c7445a89862b44b490b78e540906e81

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


  Details:     https://kernelci.org/test/plan/id/655b335fd3394d4fea7e4aaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/ltp-=
fcntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/ltp-=
fcntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/655b335fd3=
394d4fea7e4aab
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/655b35508cf41b4bdc7e4a70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/riscv/defconfig/gcc-10/lab-broonie/ltp-=
fcntl-locktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/riscv/defconfig/gcc-10/lab-broonie/ltp-=
fcntl-locktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/655b35508c=
f41b4bdc7e4a71
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =20

