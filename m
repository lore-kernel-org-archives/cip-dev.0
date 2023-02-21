Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC5C61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 14:22:47 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.43045.1676989361058773595
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 21 Feb 2023 06:22:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=l2kc8mjq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id z2so5329287plf.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 21 Feb 2023 06:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nlcqM6n6NKy4ualwq3QC3C1BxfrsxjrLroDlEvqSI9c=;
        b=l2kc8mjqFvFmnMRWh+bYDd0H2Am0FY92VCyZh3a7jESdYSQO2UFpsE6LgdLqrqaqzt
         cQNOZRjAsrktj2wyqWbXlPg79YQDjy0wSW0XE09C8xB52GSiY3ITwmbCjY3Zkx3GvOeI
         GzFgepu5xPRVDJAAL8MPowCyrhQVGLFawnHWbvJU5cIPujO3Kto8mp0gRxxXO//A1CGl
         oTsQDwnxX0hozWJ6MW/G51MYZxw0LJG8Fe6plDz4dYW29LBDLXVTX4Ky+QXXlIhPYq3v
         8lV2yVYvKEnbY/UltnWqD9gQj4ITFPed8lhWbtF8we6AEI9GRGusbopLnvsvoQeojFjN
         T0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlcqM6n6NKy4ualwq3QC3C1BxfrsxjrLroDlEvqSI9c=;
        b=7as7u99P9Xkxlh5N/LaMihvnoKg+b0g3MXS98zhqZiWle1H6oa0elNzOiQeNuRQRMz
         cp55NNmLrZemOlUV4NQuJeF5r1h+bLVtVirbJjb45QqPrqSAMIq5PZ9xGgCfvHItMyTO
         vfbZUr1xd51I9CdJ/n3qE8uTK1EZrCKTb00kxOB0AZZHdrqCZVU8EMfIINmpqOKKdQYo
         ZKZEmbDO7KM3fIqLQucK5aIeK22hU5rkb/KPm4oFvEz/1034GpgceeOw0Fe9Y2Phc4GM
         LI6AGg9UPxwc/h1qzaSCRr+gAfnojiFB2xYbwZlNDm3xwH718BO1univNTklE6VJE4fn
         oT8w==
X-Gm-Message-State: AO0yUKUQ4JaOzRaWotRUb1MpcLGE0hnXttQvIQs7DsnX2ZDsu1l/TFzC
	ffxEStOE2ZJhx1EI4nXcNNyABEHUr4bbVhvfw9Q=
X-Google-Smtp-Source: AK7set8OfoWA5tAWUVcF7PXzKCr2AeHyXHOx/N4ACbCKk6Wk+kM0TLAvsA+MmlLabJaWU1JFHb/CvQ==
X-Received: by 2002:a17:902:ec8a:b0:19c:a3be:a911 with SMTP id x10-20020a170902ec8a00b0019ca3bea911mr118148plg.27.1676989360094;
        Tue, 21 Feb 2023 06:22:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x9-20020a63aa49000000b004fc2582aedbsm2473526pgo.17.2023.02.21.06.22.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 06:22:39 -0800 (PST)
Message-ID: <63f4d3af.630a0220.c7ea1.43d1@mx.google.com>
Date: Tue, 21 Feb 2023 06:22:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-2-g28bb49f7179b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs,
 1 regressions (v5.10.167-cip26-2-g28bb49f7179b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 14:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10755

cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs, 1 regressions (v5.1=
0.167-cip26-2-g28bb49f7179b)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.167-cip26-2-g28bb49f7179b/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.167-cip26-2-g28bb49f7179b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      28bb49f7179b9cb7b4cd5c5a139820ec49c19d6d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63f4d0b982c94552698c8647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig/gcc-10/lab-broonie/kselfte=
st-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig/gcc-10/lab-broonie/kselfte=
st-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230211.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63f4d0b982c945=
52698c8648
        failing since 32 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =20

