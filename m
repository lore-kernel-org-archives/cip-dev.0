Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8015DC83F16
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 20:38:01 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.1338.1693427878996661543
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 13:37:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=v6Ngv8qf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68becf931d0so61388b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693427878; x=1694032678; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8XpQVKI/35kwTrJOaELUH0u3q5pH3q3zGlLZ1UvBqqM=;
        b=v6Ngv8qfmr8pR4Xgss0jna2tRiqQQcWuUGM8Qjs5g3HcbZlVKe1cngPam5kVkya8NR
         JYXacDWUHrjFyf76EkM7Pd1u9PyB6fg9KhV5iSUQk0Gi/a5wCKH69QJJ027hieMfKgsa
         pF2QoHaoq7Ud9B4gH6ESmXxOhjkd31PgOU4FhlE/9mG4CJVAGaUeEwQoaMAvavUe5EI+
         ezBcGDvVKwvM+s+Eay+PEOv6jTfvtEF+jO/2Cc2ydRNG+IVvyoJsWqQtDnDG5e7lbMv+
         ReK5eh+j1Ucpmw2S/vwpyxfiCJEU3DJ4Z/VZxu8/Ztm0Ej0XmWez7szDHKwlmq6sgjel
         pYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427878; x=1694032678;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XpQVKI/35kwTrJOaELUH0u3q5pH3q3zGlLZ1UvBqqM=;
        b=AD7El756NCIIvC6hCYmJrXpIWzL/eoyEENB9c8EDqY0Ad353MbY0SL2Va1DOw7aMxz
         KvOZE2YDsfKt/ER6ogViBiX9XMG5T6fAeLeqZXMTtQUvVfrPdcrGhQ1idtRdYO7cA91J
         Gc4xp/P3MWM+3oWY+Dzdm9ydmB+i/sSfy4CY2oaDOzTWbmYyC+nNJ2CI/i+gCoBOFIp8
         vu4TR5VGYyCaWvJXYFeN9p4C3mlUKlvB3bY+/a5SEa/Tb2kfB4Lwjeu8tfxGngOwxeIv
         YphhYZ0Exy67VX1XD1h+3as6fFQ5D+P3qWAe6UE/DQ14NVjFjxeQNlx+8fQWJmC4Z72M
         5q9A==
X-Gm-Message-State: AOJu0YyBry+ubwA2WkQXvEwafQl/0CNxsYyvqXwDgtbKjA3yifOtdaSh
	h/P2rEhdIT80UQO9JuxcdzrcJ9/sotv3l8c5CsU=
X-Google-Smtp-Source: AGHT+IFU+QnIaGWUwUXnmutD59yYjmBO5H5ACEi9p+KvJSjX5yqcfZuQeyswT1IGkOQI+ARWZzYqrw==
X-Received: by 2002:a05:6a00:80e:b0:64c:c5f9:1533 with SMTP id m14-20020a056a00080e00b0064cc5f91533mr3588295pfk.33.1693427877669;
        Wed, 30 Aug 2023 13:37:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c5-20020aa781c5000000b006889348ba6esm10457457pfn.127.2023.08.30.13.37.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:37:57 -0700 (PDT)
Message-ID: <64efa8a5.a70a0220.8212d.25d7@mx.google.com>
Date: Wed, 30 Aug 2023 13:37:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-218-g9947ff6f0dba7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs,
 1 regressions (v5.10.191-cip38-218-g9947ff6f0dba7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 20:38:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12924

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 1 regressions (=
v5.10.191-cip38-218-g9947ff6f0dba7)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-218-g9947ff6f0dba7/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-218-g9947ff6f0dba7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9947ff6f0dba77de14d710cf958ecb42c2f4c10f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef9a481ac44af2c4286db2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/riscv/defconfig/gcc-10/lab-=
broonie/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/riscv/defconfig/gcc-10/lab-=
broonie/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64ef9a481ac44af2c4286d=
b3
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =20

