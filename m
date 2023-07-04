Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE33EB64DA
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 07:26:07 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.53527.1688455561953751181
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Jul 2023 00:26:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=fgO9dPZb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b8a8154f9cso930675ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Jul 2023 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688455561; x=1691047561;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HdGCy4SIfPWUyZsX4SCXRBH9OD+61SfhhdqvwigRDxc=;
        b=fgO9dPZbInWqp1qDQX72tX/6mPz7F0K+co6HpnAVP+sW9K+ycdau+sSqG9ACnLQFkD
         AL4BWlN7o0w76yrHxmqzLyVMwGmqWvalRucuz76RmFH1RCaIKaUVwgu3VPv12qlCHIxU
         N3WFS3B3wyK2agY4l/vMvhEIPNb0aRL4BMJoAtjar/Jjr/QXWpf344WI9tnkAYddbuls
         8r3RrQQBaScxiV2eFZGlydLo9RRYQ3ysZjqsszHYdjBqls7bN3kJJVgeVMSkhpMPegsF
         cJkJrApKO/nb/D9Gf4bL7WMdT9mYHoy7W8rmwagAt2hv4+PL32CpJnyyYVb0MUhs7siz
         1MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455561; x=1691047561;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdGCy4SIfPWUyZsX4SCXRBH9OD+61SfhhdqvwigRDxc=;
        b=Ep0RvBcumhCJ9arIDJ2FWVZ8bW8bUcf7v6QqseO0RdPzt9gY45utv/n8NcKi4de0mK
         NlI3//kQpHtLKQswMIkEPwixhx+EC0q2+aooosqvCiwhBSTqWB4HJ4+5y1jbzDe5iF+1
         GsKmc3/W2lVmvueUhlvtp906YIlnxNvWmylY5F7o/Vrag0DZDY5wd9L9d8Ear5hdiIty
         St1HpAJiUCJFIOjaw3w07WaaRnv7WSwit8v271lxLNU5NY0U69AZh0gbv5lcAOKEmssw
         04dXnjtDZxqo39QAxwpv26QPHr9mcIghIiswAdeHJ7jpuZ9eMPMch1Cggr24GmSR9CBP
         /TuQ==
X-Gm-Message-State: ABy/qLaphFaTpR/L/1KCG8F2e6++6ZEpC+X9HUGSGmLzH1VkU3arYa5t
	LWqiDCjdtNW+23V+wCcD1+yY7KGnzyh4EW+EvN7fEA==
X-Google-Smtp-Source: APBJJlFWQdSZdAeO0IqqNq+dkKhpn5CZdhwp8KOfNk84rtV0gj6zDOzH6CWpI5ovOKSjkezo1zCdPQ==
X-Received: by 2002:a17:902:d4ca:b0:1b8:c63:4b79 with SMTP id o10-20020a170902d4ca00b001b80c634b79mr20498663plg.19.1688455561036;
        Tue, 04 Jul 2023 00:26:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902ba9300b001ab39cd875csm16512104pls.133.2023.07.04.00.25.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Message-ID: <64a3c985.170a0220.e61ef.078b@mx.google.com>
Date: Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 2 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 07:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12210

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 2 =
regressions (v5.10.184-cip36-10-ga711f789c23e1)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3c50e74d9aa8c82bb2a82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64a3c50e74=
d9aa8c82bb2a83
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b942034a832e4fbb2ad9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64a3b94203=
4a832e4fbb2ada
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706) =

 =20

