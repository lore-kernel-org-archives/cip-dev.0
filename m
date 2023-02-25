Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D0C7EE2E
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:56:09 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.51915.1677354960262863746
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:56:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=aKfy+KOS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id bd34so1391758pfb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+pri0QPIXTkT7TQ+rKVVu3dh9GOymS/VhYsypsRErRU=;
        b=aKfy+KOSUyiYeokEQzOuxPoPLQ1QXyoH36dZKJrVxBU+KfgfbDs+3q3IIPbmJzrKDf
         1SpVEYPZVnd3wiB0Y/ikWlSlcsuaUKYETtfglp7nKKMCg+Z+/IypfH0a9W6uY9S4Aokb
         MoCuKHd5aSOrXFjnFmevCnTslTmkXZ7luzPfg2IK+kEEWg1tqkscfPH9cFlAjLvLKb0V
         SpHsRF/lD39F9htd79ZPMhzySjwTq6i1DDsRT6gBchSlPuWW/uIEXZFUh4LIpxPH19Ot
         bXynrur4nyy+QSbbUzOhx4AZUfp0KcsqUr1rfhImeKRW3EqeJ/7taWlLkm6A/2uP50cC
         MUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pri0QPIXTkT7TQ+rKVVu3dh9GOymS/VhYsypsRErRU=;
        b=OLJBCFYLiw+CPwDGBKwGeP7KSQGMAXX8Mv4IGMa/6jy3USWWku9kKbPK0Am/oAmAX9
         gEQi+cfGZ8rUHxVWJPNiTXX2TzqVaMdzS3SA+PcgPXWrrzUpQ8q/esqtSD1HEYSh8ymx
         xpVqZHINlB5vnRnoiJ3z+iD5TZnEjz85GByAThP+ea8iZFQelmIAPSJi80gGPIvIeiP3
         iKDBsajqY11lQ9nEUk98jRtWbvIByUJ2fAk/XCMLgz5CU2Huet5AiLsCZHmZC2zXZ/XV
         buaHmIw4Fuoo43a11HRKeaOJN/DkkPqPwrcMqBLGudiaaAQXXY8rE+LrZrmadris1JIm
         c9kg==
X-Gm-Message-State: AO0yUKWhChnB8V/tYl8hhWmkvcIz80nAvi80HMetnXTMfr9DXTKnSfFA
	86+IcdQuIPWDkgVzA7/wwfn2BVwGRE553XEmGco=
X-Google-Smtp-Source: AK7set8auj6hBThYXKihsBeh/wmovnE+l4bksA5qJ4bHb5H3d/HqLlpsCtFzRiNPnpcc5Pp+nvOHKQ==
X-Received: by 2002:aa7:9dce:0:b0:5e2:da34:4aaf with SMTP id g14-20020aa79dce000000b005e2da344aafmr5395657pfq.4.1677354959293;
        Sat, 25 Feb 2023 11:55:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w6-20020aa78586000000b00593906a8843sm1581311pfn.176.2023.02.25.11.55.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:55:59 -0800 (PST)
Message-ID: <63fa67cf.a70a0220.e61f6.25cd@mx.google.com>
Date: Sat, 25 Feb 2023 11:55:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-86-g19cf8cd2dd993
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 8 runs,
 1 regressions (v5.10.168-cip27-86-g19cf8cd2dd993)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:56:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10851

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 8 runs, 1 regressions (=
v5.10.168-cip27-86-g19cf8cd2dd993)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-86-g19cf8cd2dd993/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-86-g19cf8cd2dd993
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      19cf8cd2dd99376e3a8b44aa56fbc1e1f7bfb770

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa58b2b2b901443a8c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30217.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63fa58b2b2b901443a8c86=
30
        new failure (last pass: v5.10.167-cip26-192-ga2cd4acb16b2) =

 =20

