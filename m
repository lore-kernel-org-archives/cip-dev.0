Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671B8C07E98
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 00:17:09 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.15088.1701217020415582126
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 16:17:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=u4Far1dW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6cc2027f7a2so3254029b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 16:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701217019; x=1701821819; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TzkzB50WtYbs1KfL6UXpzhxVLqvPvECli8HegkzRDPI=;
        b=u4Far1dWUWAaX6/x8JOGm1C6PlZJeMGNCnbHIXr7cFdkCRSB99NWCTe5M7YBWb4TFb
         9yDoKaaNzn+YXiEPwGbAsZckDbaHJgxHlJ8jSFhZWv5sQwPorF281nZhcNqncSwuZ2+O
         eq6dpa1PAMz3UjYXzenGQcbQk+mNIZ+Ir1HmpvWFYBMGzAUJKQFdLemIKqx8InzvL69W
         GLRG9kCRKIKzVAF404gZ1uuRH1mFESZIDb5ApX5p/248wozTcgDnndqTTvjo477nPHyN
         6ROAu5gqgLyn+zMOzKsMcH7Ydc/NWh2nxFvGjcm2PM8gcFH3AnxUF5MPyFeXRXjNXKlO
         90uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217019; x=1701821819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzkzB50WtYbs1KfL6UXpzhxVLqvPvECli8HegkzRDPI=;
        b=mt1edNMhXwQzIrpjdObLMxc2s4Zb2ZOMij2RAXu33qRFsYU5WmFFPAt2ii1o7fNXoH
         SY5woCdTsXrVTUJqbV0xX3+EV9Cw72V6BStqmkj/q0PrpJnm91KeGK4sJe+I0jcqmfeU
         329vKKWJ1dnBfAn9zDQNYdLk8ueH/xuQ0LxtjBRjjYMTojNrooEtpDgUIKMzANpkj5rE
         cY3Bu6SlwjSr757fYhFCkUccpS1KfncpdwhCK+5VRUvGuN8hGh1axy1MKRaFN9eBZKRC
         5TWbupafv5fo5ajoTctotOykBvj8Nsq7bKzCVdWRCY87TvoMJIYnMxnreAMXgCpno1eW
         p+IA==
X-Gm-Message-State: AOJu0Yy7HT/HHWwlPeGcmwpMTrOdrGOQxmRMEPqhQkEBaAG4CC/LMphU
	cOEwWEdUWAfZu2lV9OgpeUk0h2C4ksDwKX3sVf4=
X-Google-Smtp-Source: AGHT+IEl8VzvuP9XJdQHYfvXm6NHmRyXWKjEoGPKxpfZlfNw5qEvQcouza2Tuu1FfBUYA4+w2ERGGA==
X-Received: by 2002:a05:6a21:6d84:b0:18c:15ec:3058 with SMTP id wl4-20020a056a216d8400b0018c15ec3058mr15658620pzb.4.1701217019054;
        Tue, 28 Nov 2023 16:16:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k7-20020aa792c7000000b006cbb58301basm9805262pfa.19.2023.11.28.16.16.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:16:56 -0800 (PST)
Message-ID: <656682f8.a70a0220.8c6eb.8f04@mx.google.com>
Date: Tue, 28 Nov 2023 16:16:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs,
 2 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 00:17:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13758

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs, 2 regressions (=
v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig      =
            | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/656673f8bf9aac4df67e4a8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/riscv/defconfig/gcc-10/lab-=
broonie/ltp-pty-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/riscv/defconfig/gcc-10/lab-=
broonie/ltp-pty-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/656673f8bf9aac4df67e4a=
8c
        new failure (last pass: v5.10.200-cip40-188-g33d0b44cd71d) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65667160e7e821e9bf7e4ac1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65667160e7e821e9bf7e4a=
c2
        failing since 26 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

