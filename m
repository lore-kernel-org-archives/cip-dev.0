Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EC6C54E49
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:06:57 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.9069.1708690012032688651
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:06:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=EyVnXxXo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso103875b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690011; x=1709294811; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QzGeGRwpSPGG9Gu6yCbnt6L3DZvAk5t1+rcyiltdRxk=;
        b=EyVnXxXo/PLQJH0Er2jNagAquWs4o3FspVT2wwXm1NYc67FcKz4ukDJ+2kkvgEUefR
         AnO5XDPdK6GlbbP8mtLujATJnt5fYRzH6/6UjdZy0d03vjDepQHkhweyAQ1wylokyv6z
         gU/HNoxL1dESAzwWFCMf11URvRDbuy79ykCeBZ3rK2z43Vs/SHJYLyyetHp9hNAZ1ExA
         ui0+ExN3VGLbiXNsIhZwdvoqdKNC8MYP7JMms2cDIz8XFFmqwK0nPKLzXDiq7ccwJNT6
         bYp58TVihl1GoENkrxVtLT6m0aaom1sRVHxWKEaUqdAxsCmvNhq5Iwbpj+fQ7UANP7hD
         nKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690011; x=1709294811;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzGeGRwpSPGG9Gu6yCbnt6L3DZvAk5t1+rcyiltdRxk=;
        b=klh2y5xLZEFXb7wEhj/aZ+GDjGbsTrndn8+LvXxIeWnncEZzXhmArfX5ZX3Ur/QOlb
         8LYncIkgFdungVH+FcB7o1KKzd04U5dIQMMn6mWB5Kt0L1p4qbZq0mF1bCuwMnia7FWv
         pOA9BHpEorVsXon1UOfWf/muxWfnqiIQcTSoSRoUxus/BnJ2Rk3pTm2SmFEBpnFOxUxo
         wam2avYJwb+eS5uHbT34wOTG+qfqtEjb1abJuDXNe+Lfz/cye0ZlrBMUnAxoMB8wpayU
         8RYJ5gcHsmC6iwV6sAsNdBRc32i47Zn7zAqHXtfH5vY2kpxKtvQOERrldC21TPgshI6u
         mzYA==
X-Gm-Message-State: AOJu0YyAtzFxrSJ4zyu3zEUtapZh8I9C0I24WeuNf1X5gghCeEYYWSiz
	//MeZS0cv9t803M1Xjv//j9keMwYQ7a6O4EJG07nfrCNViWDSHh3uKOFH00Zagd2KwAV4jQB3E2
	hRmo=
X-Google-Smtp-Source: AGHT+IGlYvnSFh4HrEzrItRXJi2phE5doVayCgHuAMoz8B6oRfaS5bfBBqmDmNRS5Ebr7DnfvK6B9w==
X-Received: by 2002:a05:6a00:188b:b0:6e4:7b27:2887 with SMTP id x11-20020a056a00188b00b006e47b272887mr1864358pfh.7.1708690010791;
        Fri, 23 Feb 2024 04:06:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u4-20020a62d444000000b006e2b23ea858sm12769720pfl.195.2024.02.23.04.06.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Message-ID: <65d88a57.620a0220.689fb.aafa@mx.google.com>
Date: Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs,
 2 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15075

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs, 2 regressions (=
v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87a7c15566d5743637066

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/riscv/defconfig/gcc-10/lab-=
collabora/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/riscv/defconfig/gcc-10/lab-=
collabora/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-pty.login: https://kernelci.org/test/case/id/65d87a7c15566d57436370=
67
        new failure (last pass: v5.10.205-905-gb40421b142370) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87c533368507c6a63701f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65d87c533368507c6a6370=
20
        failing since 112 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

