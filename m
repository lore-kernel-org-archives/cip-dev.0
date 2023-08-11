Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D7C41513
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 15:27:23 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.45598.1691767638834807362
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 11 Aug 2023 08:27:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vkqxCJj/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-686e0213c0bso1644393b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 11 Aug 2023 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691767638; x=1692372438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EC2zeHwWvaTSl/PUe256oFpXQdTiWG6ubl+hQyuL98Q=;
        b=vkqxCJj/hgUerj4NAOvFN3HVt408UEM3P3orQ9D0td3uncilOcPeZIMYkrC9Wqunlw
         wkw8OwDzNNok551AqM/xIsGTmnn4vNZXZOajNu2jvyq1ex0cg6NMyqXx5FT46rifMCTY
         22CgA8ZLwtrWBmncC2qwH4uARvEgeJTfHPecrd/cE+LlmUFDIdO8v2nPMJtfxmXTkPzJ
         5CTSK+ZcpfccF2aVOCT4wIyVsbRgx71XuCcKkaUwY8vUVs38SSPNSrqnS4x6C9edjUFa
         JwNWK67XxCK0jdlA5jtSL+I1XwPoDfdIJUGcqqQhb094Obfzedq8mvrvVYFklN4WGLz5
         u5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767638; x=1692372438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EC2zeHwWvaTSl/PUe256oFpXQdTiWG6ubl+hQyuL98Q=;
        b=k9Guu0DT7bunpa/7g01vRawPhR1EQCaPlhkKQdb6CK4yMFZ5GBmY8pm6lOxBAAkw/2
         Ni3bQ/Bo6O83Z4Szvun56jO4lkcO+hSq+xFK4NPZHx76JmWBVttzmUxlY8IXgeTJYewO
         ZeTprqmV8P2k5IxfNWexMSrgA6B+7AQlmd96uSk7OMpRa4RuEhkugeYk3ZgsjRGHbr7i
         kOs3xp4aNq14Z6u77lhXZEj6w2iCGqHODARmGTokCjxM0NfLQKRRMAF3t+HuFqKOU3Ti
         +4MUeCfK4Adxo2DaNK8wwwKt9DF9bbiF1nOprcrFiG6CVcj34xxDnsPL6us19sBqWdam
         EKrA==
X-Gm-Message-State: AOJu0YwIol5kOCuqn4V0lkMJTr/KBetaP7Yg95ILfUwgFh2LwwgAUtep
	W6w/dPwQFg5mlaAhDdsTvXbNX2UQ5xmBeSdrT5g+Qw==
X-Google-Smtp-Source: AGHT+IGt8tjgeEWrGfgKqv6xiaWd6DVmCnq08FAHPFzHiud36hTRO8sERGmtQvUFtyQTN7RcNjYLjg==
X-Received: by 2002:a05:6300:8082:b0:138:dbff:f029 with SMTP id ap2-20020a056300808200b00138dbfff029mr2059029pzc.18.1691767637757;
        Fri, 11 Aug 2023 08:27:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a14-20020aa780ce000000b0064fa2fdfa9esm3462372pfn.81.2023.08.11.08.27.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:27:17 -0700 (PDT)
Message-ID: <64d65355.a70a0220.d1e72.680d@mx.google.com>
Date: Fri, 11 Aug 2023 08:27:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-770-gddd36cfc4c4c8
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs,
 2 regressions (v5.10.186-cip37-770-gddd36cfc4c4c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Aug 2023 15:27:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12619

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs, 2 regression=
s (v5.10.186-cip37-770-gddd36cfc4c4c8)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-770-gddd36cfc4c4c8/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-770-gddd36cfc4c4c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ddd36cfc4c4c8e772fc77e48315307e9956bad25

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64d6420085ab939da835b1d9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64d6420085a=
b939da835b1de
        failing since 2 days (last pass: v5.10.186-cip37-526-g7640d76efb649=
, first fail: v5.10.186-cip37-566-g36076316ef049) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64d6420085a=
b939da835b1de
        failing since 2 days (last pass: v5.10.186-cip37-526-g7640d76efb649=
, first fail: v5.10.186-cip37-566-g36076316ef049) =

 =20

