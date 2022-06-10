Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B86DC433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 13:06:59 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.26843.1654866414548409064
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 06:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BgI9npax;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id g186so15842929pgc.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UR8CDpPc2fIOA2GUHmpjvBPy2gPszp4vMUAur4C6I+4=;
        b=BgI9npax/1cnMoOqJsCLSvc6PdjwTqEiey7lIy0kXkfUeDk4B/FRPOH7D0uoPHHzkO
         h9GO40V8GK0HQ7N/nEn1+fTloxNk0arKvzl1SoBs7l0/kCax6tB9P4r6TNdUTmOlYbAh
         KPMhoDjUzJUwP8TC4m0tRCZJj3KmiKSaBSw89Sykj7KgyosSdvfW0L3lwcoD2xG78v4H
         hQJAPmlTlBWxzb4c++GXrxEV0Hy9k4QRhIIIjAezbDe539pwBuZ2kWrJXbZVTS90CyVF
         kAhK8g55i1WFajsDZT4uQSOkqciTYSl+XUE/Jo6g3PRBJK0iK4fumvonLd1mM/e0YM/+
         EUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UR8CDpPc2fIOA2GUHmpjvBPy2gPszp4vMUAur4C6I+4=;
        b=nGiqjEBwMCmn03ECXY7B4YQ67IhN5ZLW5EJZeWqHNFUAvo0HpVxGia2+n+iWg0CC1f
         yiD8HJSzxThoFq7M1dzI8fBT/o7BqstNFr4k4EqCxn3S//9ZVA5Rakevcc1x3eTgyDFe
         34wMWaTuAHBcYr3frLAnD3YAkYeBZL1AZTRgv92HAzj/hSy0eQXz3zvkDdzvNbURvpbS
         FPTPmbRh6dqq00mCEqm+ZD+5ow9dsK1ebtLGGAeM1lq6G1KGUNJtOkmC8l9U03aUsV/o
         LGjQkdjR/5REpCjJ0AmKpj0dGHRP5CZ0E/2A+nVC1G/zb5/xMRBCFQ0s5qos/InEqGRq
         qEkg==
X-Gm-Message-State: AOAM532005WCmynz3uRaRTAGdNWUViwcFCtEbisva1mKTDUt5F+c5T4F
	SDH4wXnbHfK5VgxZJww4x27OojBK0Dx1DElB0bU=
X-Google-Smtp-Source: 
 ABdhPJy25JhCXU58yh7rUzO7IEAy5rs5A5zzA5sXCBsc0pw/1Tt3Vynh5qLJiosjYZaLSWDN4WeCcQ==
X-Received: by 2002:a63:2213:0:b0:3fe:7f8:c917 with SMTP id
 i19-20020a632213000000b003fe07f8c917mr16485601pgi.406.1654866413849;
        Fri, 10 Jun 2022 06:06:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a21-20020a62d415000000b0051f2b9f9b05sm1680298pfh.76.2022.06.10.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:06:53 -0700 (PDT)
Message-ID: <62a341ed.1c69fb81.79c96.1ff3@mx.google.com>
Date: Fri, 10 Jun 2022 06:06:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 4 runs, 1 regressions (v5.10.121-cip9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 13:06:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8545

cip/linux-5.10.y-cip smc: 4 runs, 1 regressions (v5.10.121-cip9)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.121-cip9/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.121-cip9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bd24696dd7ad23517733728da675a00cd3073916 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a3392d384b6ee8f4a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.121=
-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.121=
-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220603.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62a3392d384b6ee8f4a39bce
        new failure (last pass: v5.10.112-cip6) =

 =20

