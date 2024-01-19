Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF4BC47DAF
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 01:32:43 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.11651.1705627958978949078
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 17:32:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=aS4uJBwB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so924275b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 17:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705627958; x=1706232758; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yH9jJGagrAhlYIL8/HcFmtEydQPac9MSx6ZwPeUCs00=;
        b=aS4uJBwBvKtP+aHjw43s1tHV2jXU9CNlckB7sacEhTHw6NEbu8+Ys6TDhT9ygo8p8U
         tiL2da4rUMr2mBNVuDjdB63p2RskUGid0vKc22Xgk+9vo0lEPFjuprf97RcBd68W4Kp2
         mY1FxgfmUgDKgRW51NROHHiRF11rXCxtIl4w61yke6wBB0e/FRUmgHwubjxanwj+ZZwG
         qrKR4ixYOQXT5ivPotKhZTgYJKvCM7Y40MC2ybcEgKfpOj8GEDatXRUiZm3p/7NPTCxN
         GaxVCkpqhlZltifWkoKznPNOwt4UT7EJGKmeLd0uf+Za1ud6meN3BmYthH8tEJsFGI1S
         hOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705627958; x=1706232758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH9jJGagrAhlYIL8/HcFmtEydQPac9MSx6ZwPeUCs00=;
        b=CIojq8E8uENqBR7NBiizWTjGzcr2XMfA+0Slt+iFMNqLpfwFm74x7Jv52DREAxzygI
         C9WoVZt7g/cIGYCH2Y3JhSfRzNmTj7KYdQZXUf1l4SMBakRqyFgZ0FRTh9gQqE7qPHG2
         b+NTPkqTObibR9nwl/jvXtiU2J/NPbw+ihhnIGE/O29RCAksT7vzmnSPehHnflmH6q1m
         Bk+fcGUSo/t6C7zwhNphe6ppwEkdC7HMkg0rvaPotrStaOLRv/WCuQ8YD3Ky8hBREmL6
         Z1zKHsWPkn895DuTun0phPJ7Vb2p0FSzb6v2vdl5OANcwzz/BKYsMYVRQKSZFIuiCmME
         emhQ==
X-Gm-Message-State: AOJu0YyCUdFr5FxtucwqO0TOgP4E8i8zjNgDYU0LN2RHtG9v52XDmybx
	gfs179wwUnDdS2YAlrVcCwoomu8N7wmpz9ZMs38J5WO9HW/JJTsO/a6puOAF+MksuSMroN2WDt2
	0Ieo=
X-Google-Smtp-Source: AGHT+IEHsAACnopO+mQUkrx21dgY/xbJm7FeWGiq1qQ0WR8YCwp4GeJ5AJTTVMPx185qmKHCaxEPpg==
X-Received: by 2002:a05:6a20:af07:b0:19a:fad2:51d6 with SMTP id dr7-20020a056a20af0700b0019afad251d6mr341888pzb.14.1705627957375;
        Thu, 18 Jan 2024 17:32:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fa10-20020a056a002d0a00b006db9604bf8csm3892337pfb.131.2024.01.18.17.32.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:32:36 -0800 (PST)
Message-ID: <65a9d134.050a0220.d9ec.1bb4@mx.google.com>
Date: Thu, 18 Jan 2024 17:32:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 11 runs,
 1 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 01:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14419

cip-gitlab/ci/pavel/linux-test ltp-ipc: 11 runs, 1 regressions (v6.1.72-cip=
13-30-g79e2886a5da69)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-30-g79e2886a5da69/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546

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
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/65a9bb74e031a99d0a52a3f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/riscv/defconfig/gcc-10/lab-collabora/ltp-i=
pc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/riscv/defconfig/gcc-10/lab-collabora/ltp-i=
pc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65a9bb74e031a99d0a52a3=
f7
        new failure (last pass: v6.1.66-cip11-rt6-10-g38253b8903b4) =

 =20

