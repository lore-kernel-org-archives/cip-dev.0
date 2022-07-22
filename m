Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDFCCA47C
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 18:14:17 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web09.11176.1658513655371027919
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=USVmifqe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id b9so5091315pfp.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=uQ42y/3RyxZLSK8FrAXlWyCDwLJ4THkEd96s9xillDQ=;
        b=USVmifqeHrIQDtfy4SGlMYqpXQ/16NjgeT7zw40RCJs0lb5VU50HkS7zN/MZdtirAz
         V3TWpJa8Vrffzm6dDQgRI31sJDpl+ImnRsuxW1gypHq7+UQo4FmLBKXvbtX8qfmiMtog
         IkHC7/s5GjCuq3OBz8bW/lBkepYwTvztWI7adKK45KVes89hbPKbWr/BGnQtI4OpYD8x
         NPOImcCbGB6QzGBUTkiHU2q9YEoHuOs5Pi3u67Pxo5GAq1bPFD8G+iqe9FCO5wd6k/Gx
         D7AmO5VwBukznTmuV1nx6DCHyzXCsacX6BVyfVpY8UGaKp2HWxnr9yxVUEsd8K8lj+Sr
         gPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=uQ42y/3RyxZLSK8FrAXlWyCDwLJ4THkEd96s9xillDQ=;
        b=efP9nauyEXt/2BX3UyNibLfOQ3To7WyKpxZIaWKl9hzbWd7alF6ktoVcNzQugWr5P2
         61t6xQ54rASM84mheE/KiQTCHtIjIFfo1r2JJys+zBXCtL0u71lUcUD3/FW1XBg9RWUL
         B7ByT3SXYUPrsdbNAFdlbtBRQw/yJf59PYqJ9aYcVqUwnwDz1SrG8Sb+pbpjjNaelBFW
         Bu8tVnR64UdzJZMzDemalCsZSo13uqctQyvVzlzM+nb89V47MUqwQM4iKBuTUbJwHTub
         TUWIAdxC9gACGMOHWXUepWayc69EKbH4IwuRooahEnJNHSxiaFDUzHZv1s6ZhWoVQWwU
         JtsA==
X-Gm-Message-State: AJIora9jjsFKYDKPVgXtqAJ0D+AtjXl/1ehnQclUusD35BPmKmo/O2s4
	F2uX+bXH4OgR9i0JCHS18P12KRNJYLwJCJPO
X-Google-Smtp-Source: 
 AGRyM1szZU+qFnNErWLGvT63jLUelvPSQWthUf4mVRWiMM1di6VtMh94tHiGlpG3yL4W8nUGRBsW4A==
X-Received: by 2002:a63:1360:0:b0:410:702f:d1d4 with SMTP id
 32-20020a631360000000b00410702fd1d4mr798531pgt.625.1658513654731;
        Fri, 22 Jul 2022 11:14:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 f15-20020a170902ce8f00b0016b68cf6ae5sm4087661plg.226.2022.07.22.11.14.14
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:14:14 -0700 (PDT)
Message-ID: <62dae8f6.1c69fb81.4036.66a6@mx.google.com>
Date: Fri, 22 Jul 2022 11:14:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77-82-g10c370b53152
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 11 runs,
 2 regressions (v4.19.251-cip77-82-g10c370b53152)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Jul 2022 18:14:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8891

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 11 runs, 2 regressions (v4.=
19.251-cip77-82-g10c370b53152)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.251-cip77-82-g10c370b53152/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.251-cip77-82-g10c370b53152
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10c370b53152e01c8282be083dc0943e33d50ead =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62da59c84b0ef31303daf06f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62da59c84b0ef31303daf070
        failing since 45 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da5b1c9fffdc60bbdaf068

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62da5b1c9fffdc60bbdaf069
        failing since 45 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

