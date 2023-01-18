Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447FC32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 16:35:34 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.20401.1674059728141389180
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 08:35:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=o9AxiQHq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id s3so24098687pfd.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nixcmFrzdsZSWXRNr8TXooqJn0+4VU/9D0u6zLgoYVg=;
        b=o9AxiQHqfdmFZc7xGTH/7r+76kXjB2clTUfX/liAq6b35Oi9tdFjXe/OHDQYMU+N4Z
         nNmhlenVELvyHReM3WEgIsFNxRMOUWk5T4Z8VdIPc+7JhZG1dL/AFZVustYcq4kwDY82
         y7h3+4KserqqChE83SBHNNa/NAdrTkj99BoXWorIUcz7PWW7fMdP08gsu6c0B7gTBWIi
         euoIyeeS8gt+IeXO6Kg0sOXMZzx/EZqpF7mHpNC3IHHECzAzHZVNhvRAtbFFYGYKnDo4
         OLPChnkvMUBimMn6C9dmnwwQZu8YV9MkErcH9tzvXiauWfPVJAew89c9r8ZDROomEa87
         FPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nixcmFrzdsZSWXRNr8TXooqJn0+4VU/9D0u6zLgoYVg=;
        b=df6gm/FPdE0WrUr7HTG7jKZnNpjq2ccEnAnL/z9Gg5Xort9yToHasu7su/cJOhPU7j
         Crhzf420T7AO7E4hy8dNBm4XC75hleg0wUUZrpf2DaloYaeAepKaJEiXpW+vRDWCz9Bx
         i3GtHSYBgi9dZggK+1MXLarA1GRVv0kqg/yBhGLtZEmos4oPEUAX0VAyjj6bsXvwDw1c
         +3Zsb9URSykGpdPUWaCZuj7TCKygKHge4kru6lB0YoafKIIq86/vKyWXF3YIYiDCLQkQ
         cE/kpEkyWB5DuVm55714BAQi9SZhj6uinu3+Riu9lbEePcOmgIpCFFcWvYpjDfWfrtTG
         WxPA==
X-Gm-Message-State: AFqh2koDrRGyJDEm+9V1KYpwxx3tj0UJjSPOWPuEvlC7UZF0JLxRQYwS
	TGLN+OHAgbEAXOPxfpnkrSszFMB10nYedy+6CfLrrg==
X-Google-Smtp-Source: AMrXdXtCOfx/EzaYxzgRpj1rRIgeV6EQZFJwpsBxga9vgM2i/ZhN32clWCrjaOgRQBiRiIlglexnow==
X-Received: by 2002:a05:6a00:1755:b0:58b:bfc2:a337 with SMTP id j21-20020a056a00175500b0058bbfc2a337mr7723103pfc.30.1674059727264;
        Wed, 18 Jan 2023 08:35:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s64-20020a625e43000000b0056da63c8515sm22648550pfb.91.2023.01.18.08.35.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:35:26 -0800 (PST)
Message-ID: <63c81fce.620a0220.addf0.42d2@mx.google.com>
Date: Wed, 18 Jan 2023 08:35:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-853-g709bb3738fde
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 6 runs,
 5 regressions (v5.10.162-cip24-853-g709bb3738fde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 16:35:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10395

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 6 runs, 5 regression=
s (v5.10.162-cip24-853-g709bb3738fde)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_riscv64             | riscv | lab-baylibre  | gcc-10   | defconfig | 2=
          =

qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig | 2=
          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-853-g709bb3738fde/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-853-g709bb3738fde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      709bb3738fde9ab95ab1303d161730f508a6659e =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_riscv64             | riscv | lab-baylibre  | gcc-10   | defconfig | 2=
          =


  Details:     https://kernelci.org/test/plan/id/63c80e003c55f6b4e9915ee1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/riscv/defconfig/gcc-10/lab-b=
aylibre/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/riscv/defconfig/gcc-10/lab-b=
aylibre/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30109.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  88bee6417f05c63ac99e0b3ce63f31eb08bb71c7 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c80e003c5=
5f6b4e9915ee6
        new failure (last pass: v5.10.162-cip24-788-g63c30712099cf) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c80e003c5=
5f6b4e9915ee6
        new failure (last pass: v5.10.162-cip24-788-g63c30712099cf) =

 =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig | 2=
          =


  Details:     https://kernelci.org/test/plan/id/63c80b44190554689c915ec5

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30109.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  88bee6417f05c63ac99e0b3ce63f31eb08bb71c7 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c80b44190=
554689c915eca
        new failure (last pass: v5.10.162-cip24-788-g63c30712099cf)

    2023-01-18T15:07:26.793662     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c80b44190=
554689c915eca
        new failure (last pass: v5.10.162-cip24-788-g63c30712099cf)

    2023-01-18T15:07:26.793662     =

 =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/63c80e63d67991414a915ec8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



  * ltp-timers.login: https://kernelci.org/test/case/id/63c80e63d67991414a9=
15ec9
        new failure (last pass: v5.10.162-cip24-788-g63c30712099cf) =

 =20

