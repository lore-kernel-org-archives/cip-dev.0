Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC435C41513
	for <webhook@archiver.kernel.org>; Thu, 27 Jul 2023 12:16:29 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.5804.1690460186559152967
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Jul 2023 05:16:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vR0gkdop;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso514003a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Jul 2023 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690460185; x=1691064985;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OlFM+rBtY+H2br5f7rtkTj5dvTrl8I22NUgSDX2zGIM=;
        b=vR0gkdop5qK9yXLDwOnqV2gYkDQNhYeMMHFBlcQyxnpeEAlIO71acAsWVyTybxDi+b
         F86ZDoHUQVR/L36EJccATui77bfCAC/PqOfWppT2NaTHFVj846TVrI+qgi7p5qIkKFeL
         nN9GYooGs41x8zhZ6IKDFn4bKGKC3/tsqjnEj1DWKihPoMqF2hiLSdJmQYFL3a6mGPiQ
         XwJdDfKKFUydr2WuVSOZi1Mv5HHg9T6wIDqSw9MgzP4waNsZ73PyBy5uUh0qyYHWYC5R
         lrtX5qcBn7Kg5ymEWX4AyKQnsQOAZPKWjMICNnoWAy6guezolpSlrkxsfrwvFlDNBAE3
         RRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460185; x=1691064985;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlFM+rBtY+H2br5f7rtkTj5dvTrl8I22NUgSDX2zGIM=;
        b=fSSSkWPymiBhjAfB7PnMDWeLWdF1+SAFZV/QFJyJl37LORW8ZDGHVvWTpdbyt/QhfZ
         goU0MTOoxrCWYrfdrydjVIZbQgjlF5hONJOjT51XLkbrjRL4XlIZZmZlHN1PJA9nigXw
         jciYNI4Sd2l8RG7zsjoQ2Sx9ume4JmAaI8xS7B3UC1yq4YdYtLqRaBleMu8EqrngNHnG
         mHJl+No53/n7xu/UVA3cUr1MKG5+1VSuGlXcK+22jDRxyBg+eEFYfOEJuKzNKZa9uy+n
         pFtFdz3HNzCzINcpYiGg4T7VlkXAvNilFWWzUEZ2FNtAla5+TN1VwvnRq+EXfj85aALx
         VCRA==
X-Gm-Message-State: ABy/qLYlafg0C+iGdUpkwFF05Uiy8iVgKygI74wDVT92jC0jMEUxewzJ
	cGiSUeoVpgXz2z+OPkhj4TvmQhTGHyDoP6Eom1i/Rw==
X-Google-Smtp-Source: APBJJlH1G3N1W5FPq/vW/yBTKFHXaZWuKsk+GRChuzRUd2txbAef+7gJ8pZ3Xs8QtrBEwxXWLjzUEw==
X-Received: by 2002:a17:90b:3613:b0:268:10a3:cea8 with SMTP id ml19-20020a17090b361300b0026810a3cea8mr3791879pjb.9.1690460185511;
        Thu, 27 Jul 2023 05:16:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b001b8af7f632asm1482380plh.176.2023.07.27.05.16.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Message-ID: <64c26017.170a0220.ef54c.239e@mx.google.com>
Date: Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.186-cip37-526-g7640d76efb649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 5 runs,
 2 regressions (v5.10.186-cip37-526-g7640d76efb649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 12:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12515

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 5 runs, 2 regressions (=
v5.10.186-cip37-526-g7640d76efb649)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1          =

qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-526-g7640d76efb649/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-526-g7640d76efb649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7640d76efb649f3c7f8a243e5a966ef7bd8bda13

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64c25616bf1d070e158ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/riscv/defconfig/gcc-10/lab-=
broonie/ltp-ipc-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/riscv/defconfig/gcc-10/lab-=
broonie/ltp-ipc-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64c25616bf1d070e158ace=
1d
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24fbf498a7c79d38ace21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64c24fbf498a7c79d38ace=
22
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =20

