Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8532C7EE23
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 18:57:54 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.30568.1684263473064061603
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 11:57:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vKy1wXA4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6439d505274so9236913b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684263472; x=1686855472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZA+DN/HdiddzG1G82JBrUdm7P7Iizf0fLRFbQQD99r4=;
        b=vKy1wXA4V8vRda+b98e4kOTE0xCv6nCvEgpdXHLQYgGqjim5JiL9kcZUrwtInxEpXD
         WYoGkNXv+csJu7dQy4FGsFrtWnatvQPxM4IgCg0XiOlpNrFulJMhaQPJFnSbzu/CeF3E
         er8d9TQGMx+ihto9GHqgPkNZg5jBM1t6kW6nC/r5mu9XaxaO/MtlNSWDKhkhwOtbhopY
         W7j6jLsbjqHWL0VdQB1bJ+8d6JjuAPI7xS9FiNg8MjUllSZ15zEWXgLFRrXDpxkFHyWF
         KG2CVxmuO16Z2DolVjBn0RihQLqv8buzRjpR1cxyWXgkXNeCKZgwHUU4czTfxTic9me4
         nYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263472; x=1686855472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZA+DN/HdiddzG1G82JBrUdm7P7Iizf0fLRFbQQD99r4=;
        b=dEIOtsn9tor9G32mvT2ASR9Qv8+SUlKR+xBA05GIt1OvV6/tl6LfITRlcKdMt9rIbC
         8x+eCE32vP3ChhyOpeiwS13QrXK1UxIu9YeQ0kioro/agOV2pXjjkYsbPvoJPeKsrGpu
         QB+m7wX4hE+CW/0Qnb1Zilb4tLuvelgGxUCaG5j9TN/vc3M8vzcskyvCLudStjBIfOdZ
         P0UIYx1CH6gVk2MD1lBVlgMj6zQehKIa9OXs7o2+npRH60kd0UOBLT8oEtEgcp8Y3F8P
         +lLMbtevAGE6R0y/BchCUuafJjDAHvCOQVrvaHZ6wa2hEgxz6vkympqE3285CbHm71sb
         tkKQ==
X-Gm-Message-State: AC+VfDxxINv6WbiWKKxSdgJD8pVKOlCSKFQd6sOEAy/QcBQ5wxphTyea
	KIIr7kIZadLJGM0ZQyLaJtdrX2pn8rlAzBt3Q9pqcg==
X-Google-Smtp-Source: ACHHUZ7TIKWNGDgJ5OMXenjr/ARO6t34+nWmnM18xW5zvbOMxqeSRJswWBEpk/NeTFrjld8mm85Etw==
X-Received: by 2002:a05:6a00:2309:b0:63d:254a:3902 with SMTP id h9-20020a056a00230900b0063d254a3902mr51439900pfh.12.1684263471963;
        Tue, 16 May 2023 11:57:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u19-20020aa78393000000b00642f527cd28sm13793004pfm.33.2023.05.16.11.57.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:57:51 -0700 (PDT)
Message-ID: <6463d22f.a70a0220.df4be.b731@mx.google.com>
Date: Tue, 16 May 2023 11:57:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-4-g580ea5dd85ae
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 8 runs,
 2 regressions (v5.10.179-cip32-4-g580ea5dd85ae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 18:57:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11473

cip-gitlab/ci/pavel/linux-test ltp-pty: 8 runs, 2 regressions (v5.10.179-ci=
p32-4-g580ea5dd85ae)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig           =
       | 1          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-4-g580ea5dd85ae/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-4-g580ea5dd85ae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      580ea5dd85ae9165b28861c2f5ab8bf05a13ecc3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig           =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c65020aa346b732e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/riscv/defconfig/gcc-10/lab-collabora/ltp-p=
ty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/riscv/defconfig/gcc-10/lab-collabora/ltp-p=
ty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6463c65020aa346b732e85=
e8
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ca040551113bc92e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6463ca040551113bc92e85=
e7
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73) =

 =20

