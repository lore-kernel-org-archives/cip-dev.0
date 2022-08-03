Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2942AC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 18:19:19 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web08.217.1659550748600503382
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=YGc0KFPR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id
 p14-20020a17090a74ce00b001f4d04492faso2964623pjl.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=s+yRKsPTCR17JapW/QeOSdrOPGaupC1qRmxDHV83UkM=;
        b=YGc0KFPRZcK+1KL9/b+HP+f9hoQ/VL1jjn+mgIRfu72k8CuwsNZLxo3+kO8OyZ4vrW
         aCxYA6H7PFYoJOBpzJCBtV18fEkdnD9Ebv5HmoVWBvyoIIQNFVRskkR1hWi4d0o3QPCz
         sONaY1h6Dg1Sa0XdQD55p8eScskeQfiwQneonaMyRUBTRf7PXcka+sA99VL9a31NhJBU
         ZoiksSe9j6PVdwZjLWdAKCTJ6MEH8ir8qdzvdYSeXIU3PIjPXrDsgFc/gDZcXrRXA0BW
         Ur8BAs/+mh11TEwkOcPbbmMjfPzSrVQ6uA0VKijisMp5cLMlpnqfxDbPKpk35q990AIV
         yecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=s+yRKsPTCR17JapW/QeOSdrOPGaupC1qRmxDHV83UkM=;
        b=V6LrmOSyPTZz113G+d2VIncv05EIw1RKIU9HlFHebe8C7h7uzssTvk74MywrsFmYWX
         wEeJHnHh2p/sG03ZXmY/WGaJcfn5PgL2KdgQGOL1kD+ujH57NwEn01lOpYdT440AbxqS
         yphBNkgDGlHt0IyBVGI5bWj7jjUSyFKMkYKpTydjrT+La7AaRNMZQlVshT4WdsOzlH/u
         3RaKqrlNVt+spXPDag7CrvK8kIkZkm20i7GkNiqVMdxZjVphjMCEQRecMVNKMfUPUNVf
         8b6KhY/ok0dznLmWInJ9Pck9E1Pchjt1xV9saN3wtwWWuY1eNSVw4+3qsVv6bbJ1cgqL
         5FGw==
X-Gm-Message-State: ACgBeo3OO8tBWt8ckC3bzMi4AUrtcM/J1xwDJ2njjCENuVT/FTd7NGuS
	MKtlptwMfP5CLFQGK+m0qgivYbIuHU+uWTeEWHg=
X-Google-Smtp-Source: 
 AA6agR4ac8dcqx+IwHiQUvrbQwWoJMOok546FQt7mK8wAFz5jeiMy9V/nIL5QZItfxPFKUJvp3sMrw==
X-Received: by 2002:a17:90b:4d12:b0:1f5:5af8:c093 with SMTP id
 mw18-20020a17090b4d1200b001f55af8c093mr911071pjb.33.1659550747919;
        Wed, 03 Aug 2022 11:19:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x190-20020a6263c7000000b0052ac99c2c1csm13249250pfb.83.2022.08.03.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:19:07 -0700 (PDT)
Message-ID: <62eabc1b.620a0220.150d4.58ff@mx.google.com>
Date: Wed, 03 Aug 2022 11:19:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip/linux-5.10.y-cip smc: 10 runs,
 3 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 18:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9103

cip/linux-5.10.y-cip smc: 10 runs, 3 regressions (v5.10.131-cip13-24-ga6f4e=
a41fe167)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-24-ga6f4ea41fe167/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaab582c38af6462daf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62eaab582c38af6462daf058
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaacac446e247a65daf06b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62eaacac446e247a65daf06c
        failing since 54 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaab34f95139dc4edaf0ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62eaab34f95139dc4edaf0ae
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81) =

 =20

