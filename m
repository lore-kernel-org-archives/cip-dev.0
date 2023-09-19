Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BE8CD5BCE
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 14:31:07 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.10363.1695133864682559829
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 07:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SMXAHMEK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-578a91ac815so998980a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695133863; x=1695738663; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+8B71ZKS+Z8rDt1HlEZVEDlzGEtJGyovCBFOR16HbDo=;
        b=SMXAHMEKnF7vCWCxfAWLl5HjumpSXjb4KOvE5BNeV2xca+9KtXM4OTVY88Du93SZjX
         9XbVNfNem1c/4YEL8KOAdSLv19/bfGYtPhMj7y6G6ar/Skuw63o7n1mvWdNeuulF0OcA
         wY8ygbIEhnGgTIzU/GstFzP9F+M1H1YjGrTsFKKVbtlXW6DI3e3wrFTNas+pb5J1xV8r
         5Vp4ASd5WXmuH4+XUDcR1WGBFprhQDAfoQKmjqW2tehCvdujTG5yerm8JccdQGG5Fz4u
         3Q1qgQHTIYCxzIVSDWa6l9mu04O4vVAOJM9y/YBgKQo3hg5X8vJYS1Z9ZFtBmr4Z5Y2I
         sA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695133863; x=1695738663;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8B71ZKS+Z8rDt1HlEZVEDlzGEtJGyovCBFOR16HbDo=;
        b=nRL1IOMA/wMIoot1mKtHFu3x8a0akslEjeoxjGwpjOEMFPOsduArMqR4vPy574HOOC
         nLtTPM5ezJ6sU7+G48+Ac18tK0EriK9O1idCvntmFa5JA+8c3zHjzyrPwzYpqKYqBlVx
         cCVBvJUTeq+zZv9dtWM/QjUz6CeJPwoyiy1nBi/KJ24Sq4dtCc+la2BdtZftXM2Sae2W
         CTKbGLJoq/YtkB3GefXnC5qWbRY5J0UMJTcTFd5F1PrsEl0aD6crfpAqFZ12NjqnzG+S
         UpjNTRJzxQH30gV+Pxn8+n1nam3sLvXS8E3ac+iOXc6cwa22aHhEQsOYz0SzfaKYijIe
         O3iA==
X-Gm-Message-State: AOJu0YwtjPQhz7ZuULqci84vfHjCa9/JOss3ajDGJqjH4sAYPsAHDR7Y
	io7eLtO4b0AINi4Wl1ONGXa1xxpbmYFR60Gd1/GK8A==
X-Google-Smtp-Source: AGHT+IHzM65QhlTn/pbp7ooLm4erkNeDjdDKHzzgIDRFJ+Y9B4UbZD1XqmCtofSc2hNOweW4x2TJ3w==
X-Received: by 2002:a05:6a20:1595:b0:13d:17cc:5bca with SMTP id h21-20020a056a20159500b0013d17cc5bcamr6840247pzj.18.1695133863401;
        Tue, 19 Sep 2023 07:31:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t6-20020a62ea06000000b006884549adc8sm8688809pfh.29.2023.09.19.07.31.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:31:02 -0700 (PDT)
Message-ID: <6509b0a6.620a0220.40f5a.e29c@mx.google.com>
Date: Tue, 19 Sep 2023 07:31:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.191-cip38-661-g112a3073ff26
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs,
 2 regressions (v5.10.191-cip38-661-g112a3073ff26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 14:31:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13152

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs, 2 regressions (=
v5.10.191-cip38-661-g112a3073ff26)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-661-g112a3073ff26/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-661-g112a3073ff26
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      112a3073ff2650cf1c0684ba93fb4a7284304812

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


  Details:     https://kernelci.org/test/plan/id/65099e15f9624dcfe08a0a79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65099e15f9624dcfe08a0a=
7a
        failing since 23 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a2d9adbdb27a8f8a0a4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6509a2d9adbdb27a8f8a0a=
50
        new failure (last pass: v5.10.191-cip38-218-g9947ff6f0dba7) =

 =20

