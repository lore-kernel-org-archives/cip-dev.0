Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4E7CE79AA
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 22:26:34 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.23571.1695162389435180444
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 15:26:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=V0Wbl/fE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68fbd31d9deso5736288b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695162388; x=1695767188; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X2obEbpYlf3E2tgjWfTLtuJ4AePN0/ZwcF6uPkpumug=;
        b=V0Wbl/fExV/YfYpSKnwNm22NXqW4VhXFEWyviXBuvejjoDzW7FTcB6fc5LYOXbJ0Vu
         3OX94kTKdCKSwtUnMlVH1SRcPMciozDBA9Te9N8lfQ1X0pERF3WqOr42DQV6MB4m91vA
         rAhPuOz3P840W/x4uNEGJ14wNSfXSnxgZwBSNQhXxRWZ9A1jdyqlMQJsjIW8UkdiBjBK
         mBmEnMyWG1z5Ktgax0efgUxUjwr6S74DuIFecyI2QxocxBWWjn6ZNzBESVeoPqQ+kec8
         dxdVxHoTHsYVBr8QUf6EPXHmIQz2ebgsaktr72MVcot7QB0cOijpyG+7RqTc6pSAuEKk
         BBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695162388; x=1695767188;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2obEbpYlf3E2tgjWfTLtuJ4AePN0/ZwcF6uPkpumug=;
        b=WLBpsuw5WfO6p7339lF21gT1eaQkpj3Fto/ZuMCxvtuBzE9NxWInk1LZ1T/xEWZVun
         sTP30N2yi+1f2vNYx94I2ttfyR5/tXx7QMV62vQBUIFObskMARb3dcV9d8ra2ZdoeCAw
         RyKa2u0x0sUeoH/4w3Qlu7XAp123EcJZo1AniZ7+/xr6udz2rQ/bG0B90mppGqjKVX2U
         nOrZP6XbadYOGk4Pf4seXUHglVcqFpQhMKNXnhMXRoD81YQyUUyx2NlgNrZwuhaLz5Jp
         Ae7ZGSh6AotRV6lW0/ADtNkyzMyc554K31PiXBJoKOk5yrTbM5vHRBxEzbNKEGi+Z2fH
         Q1WQ==
X-Gm-Message-State: AOJu0YyqjPhTc9bHSmw+E44iP0QBqB6z/REa3mUXZBSX0lYrCyOmeiU9
	f0Zw76WixBDcei9xhPFsahHb58pOHkyCSIOQo5X4xQ==
X-Google-Smtp-Source: AGHT+IEoHDhRxOKej/ndFAANbXrPMiMDWWJcil9o4kaaayJHfWA2Rh3vhwsYmpHp+6ocYALG8CeLSA==
X-Received: by 2002:a05:6a00:18a9:b0:68f:cdf3:dd54 with SMTP id x41-20020a056a0018a900b0068fcdf3dd54mr1068569pfh.9.1695162388279;
        Tue, 19 Sep 2023 15:26:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z23-20020aa785d7000000b0068fbad48817sm9045670pfn.123.2023.09.19.15.26.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 15:26:27 -0700 (PDT)
Message-ID: <650a2013.a70a0220.e90c9.fda9@mx.google.com>
Date: Tue, 19 Sep 2023 15:26:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-500-gc5c4e5fc16817
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v5.10.194-cip39-500-gc5c4e5fc16817)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 22:26:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13165

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v5.10.194=
-cip39-500-gc5c4e5fc16817)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-500-gc5c4e5fc16817/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-500-gc5c4e5fc16817
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5c4e5fc16817fa66c225fdaa51cf126889d5c5b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/650a118c0f7f8609d58a0a48

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/650a118c0f7=
f8609d58a0a4d
        failing since 106 days (last pass: v6.1.26-1298-g61395b9756bd5, fir=
st fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/650a118c0f7=
f8609d58a0a4d
        failing since 106 days (last pass: v6.1.26-1298-g61395b9756bd5, fir=
st fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

