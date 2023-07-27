Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8550C001E0
	for <webhook@archiver.kernel.org>; Thu, 27 Jul 2023 12:16:29 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.5803.1690460185237384239
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Jul 2023 05:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=m81mLmbO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1bb81809ca8so6651345ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Jul 2023 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690460184; x=1691064984;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eVnqLhfY7UTmN8D0KI9LCEJ6k4WBD7kGLTgmLQQU4K4=;
        b=m81mLmbOVT7s7Ig6KxSnniCe0AldFdIYmz08UFtZTIjQJ1U0P2LAUzRxF2gPoxFz+O
         uVmzWpbkL5fihHtZa9ae2Jto3+ldN7aHjMgYdtAOT9m6QHc/Jsas+GIFOQ9i46fszLDe
         vhXLdxG9/Y5gh8/1Qk8OFFf2MVv2OpV3HAaZvEjSU/cRcNDFGooUOHg3HmZpP/SuR6O5
         hz66Sa28OL0chsc5dbwU7qvVyeTIbTMSiC5IRkR6VMlVLLFxZJ989lfA39AroLXWESCE
         5t86lv1kH46zWRwwSFtp8WXhyI4E3rjZi1nbMvhOVXNchinpgGx7MPexPFGMjNWyThba
         1sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460184; x=1691064984;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVnqLhfY7UTmN8D0KI9LCEJ6k4WBD7kGLTgmLQQU4K4=;
        b=abQprj5u6uFHn4TKHPN12+VtpgBLYhA4WvEFYWg+YU8Ew6IXuQXzrRRDzj+ZHKPF7O
         7/Jll/oFN9AOaxut7VBL0Z4nJ1K4D333vSojjf0RSBsA0vMpWL+vwo7DjWo3nPKtumbS
         YSaZZJccYMh4Y9MvcNWJbf2cYR7nNfxWK7yPdYIGmHiAscilz6ILT5Gw+SGY5/ML+57Z
         Qz9ZXAcKVJ/S0eDC0hr2dNTHxKXFLpQRJYOzX5E3ZIPiz7/dr7i/emnRVurrrSCC+/zg
         jqtqUG+HkF8E1vsWVDAb1KbZg2ExY+IGATj0VLw+jm8qorPDoH+b2P1xqgCdGuPkHnkp
         QC2Q==
X-Gm-Message-State: ABy/qLbZOFidTeCu+ZZPorPSTpHju6S75RIeFkqt8Y5wrPTE01I6o4hC
	PZsF4Z/yn9OiQaNJ7szR8/7rLnTyh+9c19OsnWGfrg==
X-Google-Smtp-Source: APBJJlEofdt4LM2AhyigMv3zQ1A8rUBG3oxGZhAaMMEo/f1K76cZrWTDgoJaVwXzRTviXHflEyVxDQ==
X-Received: by 2002:a17:902:a514:b0:1bb:1494:f7f7 with SMTP id s20-20020a170902a51400b001bb1494f7f7mr4441218plq.23.1690460184301;
        Thu, 27 Jul 2023 05:16:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jm16-20020a17090304d000b001b3ce619e2esm1484406plb.179.2023.07.27.05.16.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Message-ID: <64c26017.170a0220.ecad5.26a8@mx.google.com>
Date: Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.186-cip37-526-g7640d76efb649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 4 runs,
 4 regressions (v5.10.186-cip37-526-g7640d76efb649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 12:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12514

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 4 runs, 4 regression=
s (v5.10.186-cip37-526-g7640d76efb649)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =

qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-526-g7640d76efb649/plan/ltp-tim=
ers/

  Test:     ltp-timers
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



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64c25038dadd7d67e08ace1e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c25038dad=
d7d67e08ace23
        failing since 43 days (last pass: v5.10.180-cip34-236-g6d219c607dc6=
8, first fail: v5.10.182-cip35-8-gc3d08808cfa7)

    2023-07-27T11:08:26.421718  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c25038dad=
d7d67e08ace23
        failing since 43 days (last pass: v5.10.180-cip34-236-g6d219c607dc6=
8, first fail: v5.10.182-cip35-8-gc3d08808cfa7)

    2023-07-27T11:08:26.421718  =

   =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64c24f9c6663d822358ace1c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c24f9c666=
3d822358ace21
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-07-27T11:05:38.345394  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c24f9c666=
3d822358ace21
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-07-27T11:05:38.345394  =

   =

 =20

