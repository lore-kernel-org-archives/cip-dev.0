Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C94C46CA7
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:10 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.103812.1701983589484100822
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=oo8QQIqS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d0bcc0c313so10636605ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983588; x=1702588388; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UGqXtGgt6TE/2rh417+zIQrbXDCmX23Dlq1Q4Ii4z+8=;
        b=oo8QQIqSe9FE3JQgHp1qjYE0kdAlHij1zzHlAiZks5IEJaVV8hK+BXVOHyX7MD2Toc
         16yawktpOi5WXL/S5VBpXZA0Z49tk9uEndC5sDqDJTIuflHMCvKtm2Uo5nfzJAmD0nTm
         0sMvcYm/UVrtv9OYUAHQ5KSxT0fw5RhNyOPmtSnq/EvHwQU3ezhS9YET06UMybWmjWS8
         3zTV2jNsY49r2cnqOy51R8siFZS7M0vdhzWGRqOl+XIJ1sKVozXM3C17DdmXbrHH9jW+
         x2Gr9aZeYjewEgCyeWe2IzXxxLFIxbDmNBsUlbYfoyx/+zG+8TkVIz0sWJALh97QcMwv
         t7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983588; x=1702588388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGqXtGgt6TE/2rh417+zIQrbXDCmX23Dlq1Q4Ii4z+8=;
        b=BI8r12FUqSCD1WsGFI9vAno0uzf7m1jK17VPK8V0BVJuWvL5hynyExf+gRuT68lHte
         ulwokZNblbfMNmQwRzOXhpiilG9BLKNXqJdW16PVhDqvBkJr8wE0u/UOpu8x5cfGSJ4d
         jkGliw46A3RTP51TJaizvs8vaznagWhidVkilYcvyAddiQ3xZqwcTaqlYbQIbADXDuQ/
         sS5c+C/Yc/lb81bX+DNtTtTzQJ+Vh00V4HUz22EDgrOdE2ibo00YFLUqDW4jSxEvfe4t
         1e6dMhX09LBYpNo788VIpkAF1hYnDqgBL7vsDh5jCcyL8AaL+cPDV3AI/5yVSM9kGvjO
         1XnQ==
X-Gm-Message-State: AOJu0Yz06mDJ958CunGa6IMvFES9vU5f6uuHzIFyKY2ICt3loXltA/Oo
	dmboQYb2teOIcOSbiKQxQaHEkZT9MjZzfe41leAOoQ==
X-Google-Smtp-Source: AGHT+IFXPc/X+QdulCGOY5Y7HtKpmLpHsnCMDVPOGeMn9aQhCbU33vD+bpyu9jKVohacxHFspvV7zg==
X-Received: by 2002:a17:903:2487:b0:1d0:6ffd:8369 with SMTP id p7-20020a170903248700b001d06ffd8369mr2509854plw.116.1701983588412;
        Thu, 07 Dec 2023 13:13:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001cfb99d8b82sm253666plg.136.2023.12.07.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Message-ID: <65723560.170a0220.cc057.1a32@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip ltp-timers: 13 runs,
 3 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13918

cip/linux-5.10.y-cip ltp-timers: 13 runs, 3 regressions (v5.10.201-cip41-28=
-ga386bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig | 2  =
        =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig | 2  =
        =


  Details:     https://kernelci.org/test/plan/id/6572260fd67a8e37f8e134f3

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6572260fd67=
a8e37f8e134f8
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6572260fd67=
a8e37f8e134f8
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65722948f8247b3684e13479

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65722948f8247b3684e=
1347a
        failing since 27 days (last pass: v5.10.194-cip39-1-g53e59f50ca3ff,=
 first fail: v5.10.200-cip40) =

 =20

