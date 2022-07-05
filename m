Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50109C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 20:40:41 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web09.89557.1657053636640340007
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 13:40:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=7JR9W4Re;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id k14so11962324plh.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FTdtn9wB2LXEB0oPDh3AAi376U1UJDJCOv5OugwoMIc=;
        b=7JR9W4Re+fEcG1fFWtYX5kY9WQx4OoDG+egTmroXyp/imYx5Ma2FLYmBLOSNmBKi7i
         TivB64BnXxKwtv2zhWOtxpYFSZ83zjtdwg8UxNhPBnYJHvIKhpd58fWs/dogN4G9pR6l
         l/1auYdM7A1xYtL26WhS2l907sE0DtAPQ/9UJcXHMntpVVPXzmG/zCkCNg4rBrAKSC5m
         IwGsaRTQ2gXfek4tmMuzTqKPw0o/8jsyQL6UwlCX07nFUnEToVOH3lLvxr08DpwAG0PL
         dPyJbI5ycO4D5f0zmh9baYOWfiDYwNo5GQGApeHlKCbIr/Fn/GAgLGm884JMl4UclJa+
         EvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FTdtn9wB2LXEB0oPDh3AAi376U1UJDJCOv5OugwoMIc=;
        b=VWls0t1aAKqS4QPefyWjmL6cwyuSXrsF4GotsdwvMGJcHUSWboCv9ozq/9Lr9SroSu
         NBEK7dJ18P+bdCwL7Z5zG65Z6mT8AX0Sko/9+gVk8mmi4/3F1/Okqd8fkzxlE2BNZSbB
         93fNL+8ZjIhl5VEnYPqoM1nR2PTrqVzxZzX092L4FYZy7s2JW3YtZajAnVp/Jet5A8fn
         6h7w9P5ei66c4RbDfWPpx6DJvbBp27Dvq4s2+r7sdzIqYoZ0EG2qIG/XnPUj0vCEvNpJ
         yWa5Cp9ICrP4fm1eY52o/khoOon9N2NzmaN3ZrmbVlJuPpaOGp8ydIBNyMg+2t76i1y0
         T2MA==
X-Gm-Message-State: AJIora/jr7SCtBJFvDIZSXUcqWQrS4IF1osz8t5fQ4BJa4LOF4xonwII
	1+nOJfzJqNohsKNlNUOvAnhNQrjt70+dGobL
X-Google-Smtp-Source: 
 AGRyM1tfwO+CJWvua2qDineKZG3ztjrLo1LW8Ui149wZZT5hEU4YhjC4dt7aAh1UR2ydd8M3RWivXg==
X-Received: by 2002:a17:90a:f415:b0:1ef:8811:e0c7 with SMTP id
 ch21-20020a17090af41500b001ef8811e0c7mr15008525pjb.130.1657053635752;
        Tue, 05 Jul 2022 13:40:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q13-20020a17090311cd00b0016bdeb58611sm5870834plh.112.2022.07.05.13.40.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:40:34 -0700 (PDT)
Message-ID: <62c4a1c2.1c69fb81.431dd.8502@mx.google.com>
Date: Tue, 05 Jul 2022 13:40:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-1-gc5218dc69ff1
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 11 runs,
 2 regressions (v5.10.126-cip11-1-gc5218dc69ff1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 20:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8689

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 11 runs, 2 reg=
ressions (v5.10.126-cip11-1-gc5218dc69ff1)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-1-gc5218dc69ff1/plan/baseline-c=
ip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-1-gc5218dc69ff1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5218dc69ff1f0703b893c079a21669841b479e1 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62c4971d82fc5d278fa39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm/multi_v7_defconfig/gcc-10/=
lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm/multi_v7_defconfig/gcc-10/=
lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c4971d82fc5=
d278fa39bd0
        new failure (last pass: v5.10.125-cip10-119-g603acbe1aceb) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62c495a3e9e8f786d6a39c41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c495a3e9e8f=
786d6a39c42
        failing since 2 days (last pass: v5.10.121-cip9-287-ge9094c8446fc, =
first fail: v5.10.125-cip10-118-gb03e159be974) =

 =20

