Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3314C10F04
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:10 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.103808.1701983587353912263
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=k0UEnTy3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-286b45c5a8dso1442822a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983586; x=1702588386; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0nPmOcfOVECciqzLVywtUPswIeNfAkHQEG6m00v3OIM=;
        b=k0UEnTy3Yu0lOAiy/xFxTL5UEdFaMjiRDVmT6F5ENrCOcc5b0nER+rRnfSx6wEtGTT
         lncEcjxcxwJECf9a3Fnya7muull9cFJehNLQ7XFEKBiah/q1ZmdZORuMs1/9gqZrndHn
         WchJXNtNTkXpdWlsW0v8WbwMskwY6+o+x2xqcllVAU+Xfs+3K/Y3vCRzuDHjYkC32IBu
         dpNAjkfLO/KTWYDKI9KW4wnnTAhI2aFxnQbQHlkrThFyxWLMpVAomXQgwJ2r4PGPB0p7
         0lj83J6o0rjMEZtwWU2j3tb0v4NDOD+x0m899DeJyRzyf7c+/XboSFL1af0nEISVHKp+
         +meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983586; x=1702588386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nPmOcfOVECciqzLVywtUPswIeNfAkHQEG6m00v3OIM=;
        b=MvLul1yWpl/0uRt9aUEiWcd21mZHAVr/541gP+ORgKt/lhVgI126cFRSRB0+IGOrA8
         o62QNdC3WkzNQtDwzCe1aYRcWvZe0kVKUQq+MjoN+Q7+GzTfVg6xHlQfBwzyJfd2ljbS
         VMa71UJai74HcO2Z9J6q3MmVjWFKXs8Jf3t/WGHjbEi62ukAfEGdftduQPTceqH6/FoK
         0jgh1t/o9Dpw9S+ijmWX4ONqCqn0pVO6DwsnoMe0DILy4hPvmZebSyA11ml46kfUEuGo
         tvJLGOJquluMX9C+QoJ+u0CObqiXF4+cWTGxIYMPh/NQn4LVKO5jAxDAbwmbn/wZEr8q
         ljKg==
X-Gm-Message-State: AOJu0YxlK2WcTF6VRcpVTKb2qcB8uq1kNoPaMNwS5s4IlieSQCIJBcQs
	z3r13nh8gioZgY1tDAvSHXfrRZvQKV2ULI9eAjSBug==
X-Google-Smtp-Source: AGHT+IFAyVTAA60PU3DGup2MlssFN1LvU931AhEtRaFGijxlXo+RHl9wxSYfmt5kyb6WCaHFDwyZAw==
X-Received: by 2002:a17:90a:35b:b0:286:6cc1:77fd with SMTP id 27-20020a17090a035b00b002866cc177fdmr2907881pjf.64.1701983586286;
        Thu, 07 Dec 2023 13:13:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090ad48c00b002839d7d8bf3sm1849196pju.55.2023.12.07.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Message-ID: <65723560.170a0220.6089f.5888@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip ltp-pty: 8 runs,
 2 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13915

cip/linux-5.10.y-cip ltp-pty: 8 runs, 2 regressions (v5.10.201-cip41-28-ga3=
86bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig | 1  =
        =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6572283f359d5c5cf8e1347f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/riscv/defconfig/gcc-10/lab-broonie/ltp-pty-qemu_sm=
p8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/riscv/defconfig/gcc-10/lab-broonie/ltp-pty-qemu_sm=
p8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6572283f359d5c5cf8e134=
80
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6572270a8f8cae7943e13553

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6572270a8f8cae7943e135=
54
        failing since 27 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =20

