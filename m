Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F193DEB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 15:28:18 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.2561.1689089294106349937
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 08:28:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=eYgebLhf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-666e6541c98so5238588b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689089293; x=1691681293;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EboPXDnjoSelN3LxIA8pY+ogS1CorVtI76hOEEhzO6E=;
        b=eYgebLhfK4y7Na1ZtTB7tUoWnzWsZe1vlnnfFKSfUaJfE75X9bt9OHr8sInWecqkBh
         /8/+QUK/JFitvV+VTP10R1tKOIh+d7pumt8p2HFDtNpPZC0lR6dYXT7UkteETzsCW2XD
         873XFB+F08ZIH7RTI5MEi770UYBNARQS3jn769x8KlNSoKddyic7MtV2SLFuF9jlmqad
         q6zvdViohzuhqfN8s9cSfneUZGL0OcHSQDCRMxdtVI0DSW16NWbAlAGpu06Qm7PeZ0D+
         mRuFcQiKd0rof2/D8QFstlGmgmn3nO3wSsBT9w9wLX27gNpArX+f6R9lHsq+dqEvDE1k
         15aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089293; x=1691681293;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EboPXDnjoSelN3LxIA8pY+ogS1CorVtI76hOEEhzO6E=;
        b=YH5fG8fhiU6fZPjtU8PHBk+ZnceeoRY/dN0OZ0/o5vRl8IuajTp6Rn8bsk4uiQB7CY
         7/JSJTdGCwQUyieKqb4AyQFwZIi2yrF09Qk3yxdn6z/XenhvnLmdZ4HKXLuWb0iiv/Zs
         CfbsM1otg9NnUayiYJIUG3UhGjpsLRoP/Toxmjf+rT3laAcY/AXk3xawp60Ir16XmgNT
         ShdAnijyQtYBBDD06MawRZJRWvL9mz72LR0XNpy/1uBPMBjZjeWpMDrJKIGF72dxTQ2Y
         8ZGeMlKcOSTflSeyX3HVgold0AJDtym5fo8zQrSeZDT520m5Gvkvw9cyQ2TFaALPWKgQ
         wFUw==
X-Gm-Message-State: ABy/qLaUHGrWUx3NoFAh1xOXqEGKh93gJn1TBrUPTw8p4zjXFiURHXCL
	4Oz9+twHJxO8IhU8yYPvQqG3IMSCYKJ7b3gCpDSQBA==
X-Google-Smtp-Source: APBJJlGXu+pAL5bmA4oaPbDVk8bcqUQx8OnZsQuWE32C5obNYGpKoDYEoKTsCnPh1XKVyWQriC+VFA==
X-Received: by 2002:a17:902:ea0b:b0:1b8:abe7:5a80 with SMTP id s11-20020a170902ea0b00b001b8abe75a80mr19530288plg.40.1689089293159;
        Tue, 11 Jul 2023 08:28:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk4-20020a170903330400b001b8b1f6619asm2080369plb.75.2023.07.11.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:28:12 -0700 (PDT)
Message-ID: <64ad750c.170a0220.2abc.45d5@mx.google.com>
Date: Tue, 11 Jul 2023 08:28:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1431-g4d27d09c95c37
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st
Subject: cip/linux-4.4.y-st baseline-nfs: 8 runs,
 1 regressions (v4.4-st20-1431-g4d27d09c95c37)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 15:28:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12316

cip/linux-4.4.y-st baseline-nfs: 8 runs, 1 regressions (v4.4-st20-1431-g4d2=
7d09c95c37)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1431-g4d27d09c95c37/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1431-g4d27d09c95c37
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4d27d09c95c374ad7dbaac2964032dd215c46b41 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6e9040a0a01341bb2ab1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
431-g4d27d09c95c37/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
431-g4d27d09c95c37/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ad6e9040a0a0134=
1bb2ab2
        failing since 99 days (last pass: v4.4-st20-939-g5ff13a6decb9, firs=
t fail: v4.4-st20-1098-g8d34bf42efd9b) =

 =20

