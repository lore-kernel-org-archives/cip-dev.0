Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26E2C25B0E
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 01:08:11 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web12.23532.1660698491218215966
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=OwB940kb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id p18so10716956plr.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=C8BHaRVfJrEEDV+jbFE+d/D9YVOd7YHRvPS1egZwHoY=;
        b=OwB940kbV+zxYILJpsi+KAoFgh/bFlJruT7Jd4sPamPhuQnz7XzMOsQQQXQ0RX1vbN
         gM0X2qQN9bmX0N0626SPbK5iBNFXY09656fI7E4r+/ol6H+75hjYfvulBwmnwo8qr0Hr
         pIrnimNEqCpufjzSxr8tCYqHxi9LprGospN6v+YXHOh3tJ55lAQrK+FZzGxfI9VL6TLU
         8hpgJuKmHraPZYxJh02GX4JkVQuJykafEhQUMpfI9i8jVEJrEixoCAOg2F1eN/evaCcD
         g86J1Lgd1jEhi7iwzelXY+cDT6AI0xqrS1wK0RHdJCNcJnjpw8xeZ89fOjYj2PlXPZex
         hb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=C8BHaRVfJrEEDV+jbFE+d/D9YVOd7YHRvPS1egZwHoY=;
        b=qrhOYFlhOl5khk0R2zRA1xpSvWSRIw61VQHYznPqj/yovY07TbUSmRvl3ECFrxi8Ry
         7jGbSmcVNndZDkp1ISfRXhhrFtSfU0RqAoLt0rEg08AsMCo1y2BfTomnKsES3yVRwvWe
         G9RDw/pDzKuESKrJcIG2fpFkEyuMbIQ8r7NVPqSdGf1yKOli9VXJ1Z7qyc8d9q9zMzRy
         0YBD8TSzi5FSSrHOSWK56QMaayx0ZsGrddoWmeYQMSy3HvTLTfZpa5zQoQBBOEt4oCC7
         Y5veAZ+j+yQ6vHL2gxx+KuweKId6Li+rWg66tYtqX5s0hjD0SwE1iUC/kIimXo3Xm4R4
         PyEA==
X-Gm-Message-State: ACgBeo1c7E/zhgZ6RdvwXd9wi3pFTeTTUvACiWAsDkExplUr0gNLcWEW
	ntsWPRaUtfORGiJw8pNnk3iAc8f6AOZrDhAY
X-Google-Smtp-Source: 
 AA6agR70pwVqHBQq2gjf4Wg6x67oZD3QuFFHOkEb7NSzCLFCw5Y28eGZ1tKcPmJ2eJFv9/+3cY6kBg==
X-Received: by 2002:a17:90b:3c0a:b0:1f4:fe95:c426 with SMTP id
 pb10-20020a17090b3c0a00b001f4fe95c426mr1282896pjb.108.1660698490406;
        Tue, 16 Aug 2022 18:08:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x29-20020aa7957d000000b0052c849d0886sm9080595pfq.86.2022.08.16.18.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:08:09 -0700 (PDT)
Message-ID: <62fc3f79.a70a0220.ebdee.ff39@mx.google.com>
Date: Tue, 16 Aug 2022 18:08:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-49-g1145e9c6352e6
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 1 regressions (v5.10.131-cip13-49-g1145e9c6352e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 01:08:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9265

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 1 regressions (v5.10.131-cip1=
3-49-g1145e9c6352e6)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-49-g1145e9c6352e6/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-49-g1145e9c6352e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1145e9c6352e68c31b58d1035f4f1ff07b2f9c89 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2a6f1e14a7885135565b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/kselftest-fute=
x-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/kselftest-fute=
x-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62fc2a6f1e14a7=
885135565c
        failing since 21 days (last pass: v5.10.129-cip12, first fail: v5.1=
0.129-cip12-36-g21d9d56f4de5a) =

 =20

