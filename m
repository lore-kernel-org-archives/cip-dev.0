Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56BCC7EE23
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:57:00 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web10.40522.1685321819835719581
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:56:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=yjNYLg0T;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-52cb78647ecso1657736a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685321819; x=1687913819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKuf2eS5naEdZNjXsZA4geQwLeK20pEUpuuiARoy5sY=;
        b=yjNYLg0TfADtxJjvlIzLuS4iAK2JkRidMDTUXEj2IAE1/UjxL1oKfvYaYeA/ShhcNn
         Bz11FFsda2XDE+vJO6huXHIlGIi8NBgUVAJnZ6kql14a71OtD0tAcpTjOJyJliIj/Whp
         Xk9K+QmP9qkOxS3DFg2NkBgXTicd5tW2CDRGKuLalQWMHE3awcOyDzhpgHuSFqLw4YVB
         Y3XwMnIaAzQ5Vcpy+ZIYkS12d7sRG0aSTfoH2cRT+pyjK4pgla+6ZkOe/LlTjP1R2KrY
         fuDokg4OIg5UAkhPQVkLk3wBS2qaFQUGie/jyrPkHwDepgMOoz39siPgpuuS2gRhwjvE
         CZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321819; x=1687913819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKuf2eS5naEdZNjXsZA4geQwLeK20pEUpuuiARoy5sY=;
        b=Qetwc4tNFf8+7bBQu2A+xJGkaGww/J9l0BLRF3ZciYCEmCDmEF8kLxNsgBeqNfcNyA
         evXW9r5oOqLD4y71c7lDx3Lyt57+ZbX26g+Hsb3ux3G7JQ/ZJO28ayBuiEosEfd1iEuS
         /jpdOpZ1mCj0U7c+rb5502WGc+eTUXKNpHzU4NRdGSfAU5ragD6bXvjCbNRTGoDRw5FX
         kkHvjOqIE/YdZoOSRM91ArVRnGFDESBEz2hl1Hjb16VNUR18rHVOGUFjWiowrq5+HA8S
         en2CZB0nQYvS144hctiUey0mCST8mvhwtj8/qF7gzyDmHcGMayObMFeNBvss5i07tPX3
         BxDg==
X-Gm-Message-State: AC+VfDzZZv3+SZraXAbAWI8Ti/wPmDqGeljPtexamOTjIqCCVCEaL8jX
	NkfMiJLlrH0cpgyRtZLsF2oDjj8G/Fl84nNActHI7w==
X-Google-Smtp-Source: ACHHUZ77XiPR9ASrUzKbJl3xaeIkKFtRkSuz6IrjE5ik2XIH5B3zhkuq4VJwuap45iqmBKqECYnSeg==
X-Received: by 2002:a17:902:b204:b0:1af:b97c:2353 with SMTP id t4-20020a170902b20400b001afb97c2353mr9006614plr.15.1685321818960;
        Sun, 28 May 2023 17:56:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b001a6d4ffc760sm6839413plb.244.2023.05.28.17.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:56:58 -0700 (PDT)
Message-ID: <6473f85a.170a0220.75154.d156@mx.google.com>
Date: Sun, 28 May 2023 17:56:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 16 runs,
 2 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11676

cip/linux-5.10.y-cip ltp-ipc: 16 runs, 2 regressions (v5.10.180-cip33-21-g8=
eb0cdf459a2)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =

qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/ltp-ipc/

  Test:     ltp-ipc
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
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6473e7613054fb41072e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp=
8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp=
8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30519.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6473e7613054fb41072e85=
ea
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6473e713a043c748c52e85f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_s=
mp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_s=
mp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30519.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6473e713a043c748c52e85=
fa
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =20

