Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AF9C001E0
	for <webhook@archiver.kernel.org>; Sat, 15 Jul 2023 02:31:20 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.4887.1689388275385990516
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 19:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=kDMToXAY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-666eec46206so2514961b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 19:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689388274; x=1691980274;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+EaZRUkxd95rIGv+5DsBuK/0kZzYeiu7IkZ2yStpN5c=;
        b=kDMToXAY/2D7q1WTEnFUz4TsTpY+lfqWUnDNMUx/4HtTuPDNcqX3v7idzEf1IFdtN8
         ry9O/1mqamtv/OnT1DkxLI7bmcvih4DXrbpEtFLMlQM2bwPa1NvfeEr4FlObKsa5yE6K
         oc8Vuk7g97+FACeLukGIQ3aliGXaspJoacWLloVyYcZ+NJYX1qgPKYfzV5yqc7CZrQpa
         9E9Kw0AiOPlagdA3Cwz8An+HY+QG+VyXXRDTT4K3vl3b9r4ibGk8t5SPSwAV+IasTmkq
         A6oUAKimZWeCDn7pfEf07z3YevfLjpOaUqjFVmDSIyLyiqn+/GmwD+vzhGfBnYwlmpSW
         4B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689388274; x=1691980274;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EaZRUkxd95rIGv+5DsBuK/0kZzYeiu7IkZ2yStpN5c=;
        b=je/2HmWm10sJrx0kpC8l/AoV4atNbiJ//ycq3BLKpgJh99fzoCAOSjuLHPPDsXcD/M
         EAnCNy4+l5cTau8QhPsYX4rUoWbGeVnNUzBhFko2rCDiGp/1B5BqFgA25OzxbsjuHQSY
         mkVsZUE/Mif8gFfkfkYGtp7KIY8m8szI3tSl7yHvLEGPxSkJP7UZ/H/Ucje2htUmjlG9
         KLN+uYCTZO/T3Xp4V7vTP1CiutqG7j8hcehSYsObKq8cZUn28o+xMbc0hXxSSlyVkvaH
         lycmcmLuMJ85mbFqZpT+yPjBJQVLlii5ZOsmSc0KJCaO7+T0+MN2uPxtChBfUwV9GNnv
         Giuw==
X-Gm-Message-State: ABy/qLYDV+Jeq9kLXCefwHI96Yqe38duYYxSiubimHUnis6uo9eG2c0g
	Yq1XM9F4j36qMQ6lNEjVsJ3vUGSPIK6KranxWDaA/Q==
X-Google-Smtp-Source: APBJJlHEEjdVWgDzsGOuXHaphvPd9dbZGcOZwJbBXJLakRyFtzgaVnP9rzaqqV8cJbk39Z5VHTICGg==
X-Received: by 2002:a05:6a20:1d5:b0:132:f3c0:c743 with SMTP id 21-20020a056a2001d500b00132f3c0c743mr5460327pzz.61.1689388274221;
        Fri, 14 Jul 2023 19:31:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o17-20020a639211000000b00553ad4ae5e5sm8162057pgd.22.2023.07.14.19.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Message-ID: <64b204ef.630a0220.14c75.27d6@mx.google.com>
Date: Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.186-cip37-rt15
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 10 runs,
 1 regressions (v5.10.186-cip37-rt15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Jul 2023 02:31:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12358

cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 10 runs, 1 regressions (v5.10.=
186-cip37-rt15)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.186-cip37-rt15/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.186-cip37-rt15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db05335d4d4ee47b8fc64652b2c2ad8e57eeaf52

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64b1eeb0144cdfc06c8ace23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig/gcc-10/lab-collabora/ltp-fcntl-locktests-qem=
u_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig/gcc-10/lab-collabora/ltp-fcntl-locktests-qem=
u_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64b1eeb014=
4cdfc06c8ace24
        new failure (last pass: v5.10.184-cip36-rt14) =

 =20

