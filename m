Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D9C10F13
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:10 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.103811.1701983589001424048
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1d18yDui;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so1099561a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983588; x=1702588388; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hk8eSDW6ntOvYu2HIz2Vuj/25p/a1wQYHwY079UJqbQ=;
        b=1d18yDuio/2LGt9N7o7Js9OsVlUzJ/j5FKvSD4EQgVyQ9FgSISuuE1CcB1idyYn3y3
         XRmIArA6ysUV48Bf29viVk93yI+4ckCoJv3lTBFK7fBQOidhUs3kkoqxqXVWJpsVvyAt
         KVLoC8ptwJ9DFzPPK9j2G7bOGB/yuBNFJqU3/EIn1Nfrp/Yk2SpAFlrmoFDXxbHhtr7x
         qdjjXBa7vuxhEpS0PPkIzlFGa85JGKeK8ENP8C6iFfAiB15bM6kLwHKjBLUh0Zaj9sK6
         Vzc5dvC95ZzrdEX0Zo6795fGRN64OFWF2NKGF8zAs+rZAqCz+go+2QAp5clS1idntTps
         6MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983588; x=1702588388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hk8eSDW6ntOvYu2HIz2Vuj/25p/a1wQYHwY079UJqbQ=;
        b=pSk60qlwB32AzPj7+dlLGxkjHB+ikybew31kFxIZbNaM1mTk+7wJs7ofbTjVt8MDjc
         Avd+uaqetosIqOSJn+O44jzoZgu9zRepeRBnFIOI1+CPyrQL7B9KLSbDs+8NM65zbiBI
         4sZWAaF/0N3k2ErkKGYSzml9PQ0J1cfNYvZ+OtQ67BdrA8HiLNsH5aQw0LLVNrcmkeNC
         4mDfYoPSlZ7iKm5rC1POfraclAZrdDt6ifeM37yj1SySYJySwJ9Nx2RawbEPeE0VgF2/
         6ALiF5q9Sq2RgMIgIj6an4gJVQBtKA5ttMgR+pV2W/lZpx9ETywOc6STqGePk3XNHLpP
         66Ig==
X-Gm-Message-State: AOJu0YzaCZk9FKT8ODqUerrfoIbQbTkAKlEEV5x2GEZNO06NmTR1TILZ
	YxwgaGerFJ+IuXDw65C5NZfKhHD+pN68rCs+FQeZFA==
X-Google-Smtp-Source: AGHT+IENRzDcB2qTWAP+y/Htg4Z6pHVHUmM5jBfoEcG3XA+6M97KdPtEYjHZG37jBFU6tcx7iF8KqQ==
X-Received: by 2002:a05:6a20:6a20:b0:189:3748:f060 with SMTP id p32-20020a056a206a2000b001893748f060mr3386862pzk.26.1701983587985;
        Thu, 07 Dec 2023 13:13:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id du6-20020a056a002b4600b006cde7dd80cbsm222063pfb.191.2023.12.07.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Message-ID: <65723560.050a0220.69d36.1480@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip ltp-ipc: 14 runs,
 2 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13917

cip/linux-5.10.y-cip ltp-ipc: 14 runs, 2 regressions (v5.10.201-cip41-28-ga=
386bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/ltp-ipc/

  Test:     ltp-ipc
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



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65722506f575860bc3e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-cip/ltp-ipc-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-cip/ltp-ipc-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65722506f575860bc3e134=
77
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657228f8f6368bfc43e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657228f8f6368bfc43e134=
76
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

