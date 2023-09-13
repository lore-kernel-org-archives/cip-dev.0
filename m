Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CAEE01E7
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 16:43:41 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.1726.1694623412221490140
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 09:43:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hpEmITKq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c336f5b1ffso59725255ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694623411; x=1695228211; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x7f7VqmauOdACchZ3SMmTAV+SGwRAj9wG7nAL7NR22U=;
        b=hpEmITKqk+ZxFy4K4k9U7F2D7RekKMKDSwiMNHYy3eOxSrTDNxF1tI20lAzLwBofdD
         zQ5Ict63XyuDvmzkNmDDBN3/92loITERxV+Pb9zS+aOXfQcm6oKT6wvaAPDimWlykxWr
         ovlDmX7ysqft6ZwkTai7uwejDUoWxxa5/R+Pyo7T7hylkb/O9nLlpUEq3Aa9iH+JAOQe
         /21LyPSgiXKN8BzL2sqcX9oS1M+g159Pvvspw0LYIRlOdYjLXQ3nhMXt9eVaAXifDAs3
         vWlvG9jPOgEmaQxvYJOYjmbEoe/oPTe8S7u55jIOaZCNCHcSMfkuDzjyGgdHOtaGpnkG
         JEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623411; x=1695228211;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7f7VqmauOdACchZ3SMmTAV+SGwRAj9wG7nAL7NR22U=;
        b=herdcFTOPGbL+pqfSnK9Yd49lHKJ9qlbELdR9Pg6MSu14JWuY08heTnDH9ExIX1Sql
         nNU4UDaf+B/KizAr1cI7OmrvN05L2UPrvfDh5atIKwa8cXYCwIEetebTYRo0wbKm96zV
         NSyV85Rffs6L+E5ByUvfiM8DbR20SYHGEWTKFFJVv4vXQGsHufxnL0nVMOUz7JjK7+gR
         xrrcgjOe6rHCoT/7JrVAXBr33L6JslTwWXpEVN4hFaJndw7eDAMLP2Kuv+m3E2fAKtoc
         6WhV/UWuS8vTHsC40UskUtRM+0pRsEm1h4mDqOD2ArYXx4EMkMPbRhSGFJmw+M1sGCn2
         Vz4Q==
X-Gm-Message-State: AOJu0YyFYDUHuW17arhhhWJX4FawCDgnS3RcDQTwZCsnYepi1rbJCsFu
	dyw++py85d3OMz1oXNCEIeA4lWTBe4YlyF4h77U=
X-Google-Smtp-Source: AGHT+IG7l6eK7dsDcZKDayj8Mlrz1PT5GnOZfuIZN8E24jmdwBibPqxwwHi2m0rycbHsoYfUom3GfA==
X-Received: by 2002:a17:903:22cd:b0:1c3:52ed:1905 with SMTP id y13-20020a17090322cd00b001c352ed1905mr4199125plg.28.1694623411314;
        Wed, 13 Sep 2023 09:43:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001b8c6890623sm10695906plg.7.2023.09.13.09.43.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:43:30 -0700 (PDT)
Message-ID: <6501e6b2.170a0220.d418e.f381@mx.google.com>
Date: Wed, 13 Sep 2023 09:43:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.191-cip38-29-g9e1aa2001db86
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v5.10.191-cip38-29-g9e1aa2001db86)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 16:43:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13110

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v5.10.191=
-cip38-29-g9e1aa2001db86)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-29-g9e1aa2001db86/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-29-g9e1aa2001db86
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9e1aa2001db862da32812062860b8756cbc8890a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/6501d1beea5f54aa8a8a0a71

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6501d1beea5=
f54aa8a8a0a76
        failing since 99 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6501d1beea5=
f54aa8a8a0a76
        failing since 99 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

