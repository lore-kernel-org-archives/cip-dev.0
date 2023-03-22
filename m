Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA43C761A6
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:33:02 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.37610.1679473980618449370
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:33:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=r4Ti74HV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id u5so18587880plq.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MeRVG7EeOD1bnYdF/2p1IDdLIv1X3qOaqpZjTce9iM0=;
        b=r4Ti74HVDt2pvS4N6U2cGeVxi2z56mRoo5uyEkNBV3C0s6Mfyh5KfFVUOPpg82IpUE
         APU4WM7WdBpatvSTnD/47L9oCOYi1WctuwTmyDmf8RUWptgti8//+KHMdtN5s2F0Vlr3
         Js1Acqom/X3PKCt1p+Icqo4h64KyjPrc9bh/V/BGagUEWDK9Gnfqs9jybKxk2Xm78jjv
         ZCkCIVYHPSIa15smfHnXLLcU+STTU2XHkpl7QFKZHvKINc577QKrWnbo25omkCaX0COf
         QPNtXVrV9xP9epZvKyLG0lthZ/kcLq2z2BYU1Qsb40XsSUEf9CbkRO5HQs3a4PYT5vlQ
         03hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeRVG7EeOD1bnYdF/2p1IDdLIv1X3qOaqpZjTce9iM0=;
        b=rIEPEbXwbEv5VJ1ThKrylf8WP5teSFyUAgiA6XRwFoezytoq94uPiuYrXTWglIB+Wu
         BmrpoaGF60Vj7e8zW4IFTU2IhkF2AWFXijyPqDp9lxpAxvL7/aZFmSlnki3oIN++rHFk
         ijIVMUhIRw0C8kh+1oi9hEARYNfD85wyQMNdd8/kS+OJzvNxDCIcaozH6UwaJN3RDe13
         kCBlLYq3GtzQPnxLtyGCL01WMi6Q+rOpWrghLjxxsFzTrsVvAvyliEDAX16af/xOus8k
         LtEsEJegxD5yJzouGXr8ELw+E8NI045xKPm4+9DoMx9cDgfKn5TMC2RTfDslNlgSLgv6
         I+NA==
X-Gm-Message-State: AO0yUKXn7gkVhXh9HHc4oGEIG8jA1bt+uvHzvvArBDjW+I+t3uBQs7sr
	ULWF5d5+tLglRBSMQpyyF+loBSJ8MKy/Ko2QZYE=
X-Google-Smtp-Source: AK7set87kRU7DrX92Nra1j9+vk0Mm7OP6lzM1XruCnVzNg5OZSNjGhOQVi4YummFEH6+23ajn+BE1Q==
X-Received: by 2002:a05:6a20:1823:b0:d9:5a7c:b1c5 with SMTP id bk35-20020a056a20182300b000d95a7cb1c5mr4458541pzb.11.1679473979889;
        Wed, 22 Mar 2023 01:32:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a6563c8000000b0050f9b7e64fasm3343453pgv.77.2023.03.22.01.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:32:59 -0700 (PDT)
Message-ID: <641abd3b.650a0220.e51de.6a21@mx.google.com>
Date: Wed, 22 Mar 2023 01:32:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip ltp-pty: 9 runs, 2 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11059

cip/linux-5.10.y-cip ltp-pty: 9 runs, 2 regressions (v5.10.175-cip29)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.175-cip29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaaca10045417ca9c952e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/641aaaca10045417ca9c95=
2f
        new failure (last pass: v5.10.173-cip28) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab39544038ff39f9c950b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/riscv/defconfig/gcc-10/lab-broonie/ltp-pty-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/riscv/defconfig/gcc-10/lab-broonie/ltp-pty-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30317.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/641ab39544038ff39f9c95=
0c
        new failure (last pass: v5.10.173-cip28) =

 =20

