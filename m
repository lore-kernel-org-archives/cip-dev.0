Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120FFCCA47C
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 02:34:45 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web08.79936.1656988480541274863
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 19:34:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AqvxEViS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id z1so4071226plb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 19:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dcIghStE3ZBdjRJeE0RHreiwREoOWB6fVW/2A6qfoNw=;
        b=AqvxEViS6Y6AJrP0YnsEGIZCjpvDbnNL9HIuMlrjAnBjrVvwNpe6IZTz7Ey7ZxMOq4
         PeazyzcDMUTT26DUTkCqNZ2ovziZ+trY2a1+wluP7xXIQ/V++VHDIMXT6NEOj2wDvqnt
         sTXukAocCI6VzdSCMLHdCp8+apyTFH+i+G7OkX+VV3Hotl3VTbPQHW2/w6dgVNf/+nCZ
         thSu8R9rqP/+xF/6S8Std8WX4w1jZJUiYoY2xlLMkU8Zmb1zRWXyF1LTKoiEDtHXePJZ
         Y6q8Qudai5PVWsf8leH7g4Xjp49/7D8sR/p6Nparas5fIFyOKT1RwddubL1bDHgKbCGv
         jKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dcIghStE3ZBdjRJeE0RHreiwREoOWB6fVW/2A6qfoNw=;
        b=XSnzp6aoQyx0lkNPzS6HwQbxFMNSgupyu7dVG+BWYq6UNRk74K7ydV0K0ohuwLAUMx
         w+VCF6z1Wv2mHEmVZ5djdP1LDFY67/m2GbPGQ7bDO53uOdcihqoIcUNXF23qWVfYIScO
         ssdGt84psFO3CJOMnkgkcOS/8zhiT4izUf7ekdIppJ0RsoOvZgEmpD0Fm6Isa9jtJayH
         /yBtVXdyOWoSAv95KDhmUf/trB45+UF6XUmnR9sKalm9nyOu1mr0gD/7OW/sXYBStgVp
         MRwFC5zCuuoQMHwATVVjWGti9JY7wi0RhHdzWyVjby4XcpsJJ2SmESG9ENNj/+C16ty2
         11qQ==
X-Gm-Message-State: AJIora9YUDDi0DYKBjafPekw9giCtX5P+TrNqAMihHcIkEpYwMFQdmVO
	ZogDZzDtefobckfyQXSkBARHPo2Quln3hi+l
X-Google-Smtp-Source: 
 AGRyM1voFwfsQb+sW+P3FKL8RaIyLdTpLf1eZQJbps7i4srUoA5vOp4zpvLugaaJsHW2CFGYbRTTRQ==
X-Received: by 2002:a17:90a:640d:b0:1ed:2255:372b with SMTP id
 g13-20020a17090a640d00b001ed2255372bmr40588573pjj.128.1656988479648;
        Mon, 04 Jul 2022 19:34:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b2-20020a170902a9c200b0015ee985999dsm21943080plr.97.2022.07.04.19.34.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 19:34:39 -0700 (PDT)
Message-ID: <62c3a33f.1c69fb81.40509.f9f6@mx.google.com>
Date: Mon, 04 Jul 2022 19:34:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-119-g603acbe1aceb
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 10 runs,
 1 regressions (v5.10.125-cip10-119-g603acbe1aceb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 02:34:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8653

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 10 runs, 1 reg=
ressions (v5.10.125-cip10-119-g603acbe1aceb)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-119-g603acbe1aceb/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-119-g603acbe1aceb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      603acbe1acebe85cab7f594d9952a493be976262 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62c39b15c9193045c7a39bff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c39b15c9193=
045c7a39c00
        failing since 2 days (last pass: v5.10.121-cip9-287-ge9094c8446fc, =
first fail: v5.10.125-cip10-118-gb03e159be974) =

 =20

