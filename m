Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01156C77B73
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 23:25:54 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.7144.1684452350885297771
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 16:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=mpyPibnB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-64ab2a37812so167815b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684452350; x=1687044350;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EDZrf4xbQTnzWw0iiBbAASKtKyHmnAyjUui9QPDouWc=;
        b=mpyPibnBnZa1dZCB+/aIFC2KNNzUkU930Y86SGnbJ5Ry9CNTcM2B9KDQocpdl2ILFz
         rkT6nIBgHc3yjC8mVdpSxmX96vKF5tDWm7fLEyRSl+Cq9I8lNr1FID0J/GCcH3ygtwpp
         Ef8Ccf4uYhRVGLWRE0vWHDsdVGM+JWC6TfajAPCzcT9CfE0aJvKuuRpbHbbL17soAVGk
         2UZ2YHDoLMuZVHBNNB2INb2Ak6FVF5uqa5v4F3icIE3Arigc+h5w+6w9wJnOET55nSRH
         rcTA/gTLyXxnJ4QS71LN62IqHqWR7vhCd2qx91Dh+PsRZeci9QlYPV6pILgn1TsIH0LD
         MdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452350; x=1687044350;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDZrf4xbQTnzWw0iiBbAASKtKyHmnAyjUui9QPDouWc=;
        b=c8OEf5xyGAi/VAmI4IGdxMcuyyFmcqc5MZ+CwDLNragcvTpvxBzJFqxBkGX9xdL4pH
         jzudXxzQJhLQy1ScUZ8ocxYx44YIQ73pdtOvmFXK+Si9Z41yVyCw24zRGbapMFUIAIQR
         1L7lLExJADyv6t7DbJX+gT0bEURHZYHT4UofOQAW9hz+EUfSrzpO4o0kmPdHswHYFwA+
         /PYvzGfLv5Teq/jcw84K8oa0mFQ6dnUJHqzsH4oDBFzpHmKDHcmjoxjrLxGCMXq//LLQ
         BZTzx/ALWrKxh/jpBhJ77fdh3oeONiD1W07vruB1E7BOxcttBiOAM6PbO00q3gWDeFhS
         ezXg==
X-Gm-Message-State: AC+VfDxHol2Dyf889l0ytPannYdG2RL4Bbv4lBkaTcL0FF9uYo8wxL31
	MxGrM80cusyRkX7FQVRQ99JjPyYmkWZBLoq3AG9dFw==
X-Google-Smtp-Source: ACHHUZ4ZucIqvLQtg9cVkG8UogJAPzx2rEfKgKxw6vxNw+QQ0HvtScaMkOek0a8dZsX+G9Q7+HY21g==
X-Received: by 2002:a05:6a20:9189:b0:106:9266:4448 with SMTP id v9-20020a056a20918900b0010692664448mr803829pzd.16.1684452349894;
        Thu, 18 May 2023 16:25:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b0062cf75a9e6bsm1815325pfi.131.2023.05.18.16.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:25:49 -0700 (PDT)
Message-ID: <6466b3fd.620a0220.5b6cf.4052@mx.google.com>
Date: Thu, 18 May 2023 16:25:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-rt13
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-ipc: 22 runs,
 1 regressions (v5.10.179-cip32-rt13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 23:25:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11528

cip/linux-5.10.y-cip-rt ltp-ipc: 22 runs, 1 regressions (v5.10.179-cip32-rt=
13)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
 | regressions
------------------+-------+---------------+----------+---------------------=
-+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig+preempt_rt=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.179-cip32-rt13/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.179-cip32-rt13
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1f0aef82759c2eef50bcbfaab1bad1aaa64a721c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
 | regressions
------------------+-------+---------------+----------+---------------------=
-+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig+preempt_rt=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a5506a8b6581122e865b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-ipc-qemu=
_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-ipc-qemu=
_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6466a5506a8b6581122e86=
5c
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

