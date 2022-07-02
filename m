Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CE2C43334
	for <webhook@archiver.kernel.org>; Sat,  2 Jul 2022 21:12:59 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.54628.1656796370167127206
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=lIoSiMgT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id q18so5319972pld.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+efv1zSfKiQx3KBsABAB6JrRaAjgqhEym91mb5lWVRs=;
        b=lIoSiMgTzwmixaijPTJh4Y6vk48L+rML6JViITMWiwkHS7UpB30AiZXetWAmdmEWGL
         awuj4/k6UmOcsbn0Uu8zuxle0UgrJtGXBjVATGs1IPgcX237mbZJMUoY84YBaWHXayTa
         /FgrWwHU8zEyITWBplg8n9Vf945sm2iqCyqTUjcTttDhOK6y1s7huVF9i4fFumu7bUIw
         3Ao7B5NktYamiylaQgIx6OyLU6hhF7DDChbyyxFxmACeLPUGj8vdjaV79SYeGw661res
         Ic2M9a0ayp7htlbLjvlTu00KfCWsFWnjAltlASSyaaJAUdLxNU46vhNQQ0d5CNb9t+pM
         86Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+efv1zSfKiQx3KBsABAB6JrRaAjgqhEym91mb5lWVRs=;
        b=iMxDA16tWEP12QvuJ++VY3QEh4Aqy7IqmFKjRKQddaY3j3u/DTv3JJ/a4t3XvgtJin
         jibog+sWw9y/ajhI4HL1B2mfJKKeXGKNbraqoN+Um09BXN3ouVg4o3E3UK4rVA81FcO1
         WDM5AUfKz9SnBAX+Wax74ovRAeMzft/IwHW2bmujaJwgUWltL9DiknaUaLkbEFC4XULw
         LQT3ApQfaahxblmsDVpWfDLPlKIt7cLVDLnT8yTQ0aMdnJ6Na7XDth09LzfOkHt0Scde
         5GuJolBFWZTQichlbWvirJWRYoxU4jcj5mTPTErcts6BR076g9LzhEQDdYY5fRJ3GJuA
         jaaQ==
X-Gm-Message-State: AJIora9dNe7rYaJ1nveK8LLfFXdTJa+eCrqttsb4rlnnXwqpIsKwpps4
	WGhiPBnJipgBJ5a1dMglvpsun6ljRSbEsltc
X-Google-Smtp-Source: 
 AGRyM1vFAeJ6d1c1SIXdSpCJ56pJBZUwK1kBhTgumdieDg8oftoYXbsUcLUepBBy4Psr7+uWxfxhfQ==
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e94e with SMTP id
 n17-20020a170903111100b0016aacf4e94emr26650722plh.59.1656796369504;
        Sat, 02 Jul 2022 14:12:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x2-20020a628602000000b00525251ce47esm452165pfd.103.2022.07.02.14.12.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:12:49 -0700 (PDT)
Message-ID: <62c0b4d1.1c69fb81.9f0a3.0974@mx.google.com>
Date: Sat, 02 Jul 2022 14:12:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-118-gb03e159be974
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 6 runs,
 2 regressions (v5.10.125-cip10-118-gb03e159be974)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Jul 2022 21:12:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8641

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 6 runs, 2 regressions (v5.1=
0.125-cip10-118-gb03e159be974)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-118-gb03e159be974/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-118-gb03e159be974
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b03e159be9746a2cba92777632dfc469e7cdecf3 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a2d8c4496f2424a39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c0a2d8c4496f2424a39bed
        failing since 51 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a51c5ec7461396a39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c0a51c5ec7461396a39bda
        failing since 53 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =20

