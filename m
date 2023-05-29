Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F14CC7EE23
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:57:10 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.40706.1685321823464088324
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:57:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ebkAQhd4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d247a023aso2032052b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685321822; x=1687913822;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EUgOnEdLSQOoyEmg/xzf3DoEIGkDAovQuBG+k1Q7ohg=;
        b=ebkAQhd4KvIkX4cNDgJj8Jap/MuGsxd8p75M/q4mMTzxPCiR7TZV/FKnPCSHu7XtSm
         SHedrNEAYW/jHj6Y4dv6ZaWxzE+M4K3PP5dbMd5RSa5mdftvPEdrPPEHdv2603UQm0z7
         SfZbj+GsG8CiUbqQ+PFTXJY/+Gdd83sTzJlWDaz5zv2JToYpQd+UVHffOly8781rjK8y
         5TEg0SGaSNeSb2rcOX3tbW8MaydKtXF9f1H2+JxjC3lMKWGEWqM55EKWeJjTnmMGd5hf
         VYYtVVjr+we6gRxYSqaUw9fv80+NZrx21Rt8/C6HpAgl6mg9gorPgKVRD4+TPCcHS84j
         HFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321822; x=1687913822;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUgOnEdLSQOoyEmg/xzf3DoEIGkDAovQuBG+k1Q7ohg=;
        b=cTl7uCUW+57nyU4YjpsNfNgfobT9yYqjIKKdygLVr8/PTQ9VrHhC/+OUhpdC2udz6s
         yZgEIOqChFjBtPzI9CqfCnQtgKI5myLho1iDJalydsrFpTFdaQQmKwjNB8c/viKORch7
         57RDapJXkAUETLBGH6WozLIQh5GxIFWyxGfw8pi7p/7Bg8Ovvt3ypSJMxOLaG2B0uVpW
         sEoT5OkdRqndQk+//D9Nm2d4fnYCoc+KBXI/I7mNNkn31+TJDcSU/Cn4oXjdlr+Yl37Q
         LsMD+IxGx0QOO6gZfYZ5F51qZhOKLxYeTt56Poy299Rqh30Spqc8C+m28K74T0eCq6xC
         p1Ug==
X-Gm-Message-State: AC+VfDwkJfFtZKcPqn3ySdufkUSxNRID4FpYVHMYtcphmzH0Lukj5nBQ
	azZ9e01d8LBdRV/ra6Yk+Bl6P4mNLWeoHPYzVJyu6Q==
X-Google-Smtp-Source: ACHHUZ4opOw26NKahP0sOy2dtA5Bd4aBGgcfCsnOecP6cq91r3bjkauWQnepE6Ml41zfCkGWGlg1ww==
X-Received: by 2002:a05:6a21:6d93:b0:10f:b53d:8641 with SMTP id wl19-20020a056a216d9300b0010fb53d8641mr7368799pzb.46.1685321822474;
        Sun, 28 May 2023 17:57:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78682000000b00640d80c8a2bsm5668653pfo.50.2023.05.28.17.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:56:59 -0700 (PDT)
Message-ID: <6473f85b.a70a0220.74e53.b8c1@mx.google.com>
Date: Sun, 28 May 2023 17:56:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 11 runs,
 1 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:57:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11680

cip/linux-5.10.y-cip ltp-pty: 11 runs, 1 regressions (v5.10.180-cip33-21-g8=
eb0cdf459a2)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-21-g8eb0cdf459a2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8eb0cdf459a2bb2971bbf3eecc4f894d2717cff9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6473e9803b8582702a2e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-qemu_s=
mp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-qemu_s=
mp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30519.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6473e9803b8582702a2e85=
eb
        failing since 5 days (last pass: v5.10.180-cip33, first fail: v5.10=
.180-cip33-11-gfea7994097935) =

 =20

