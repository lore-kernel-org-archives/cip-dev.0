Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351FDECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 18:51:38 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.2846.1661971897452624289
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:51:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=zuKE/8wL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 p8-20020a17090ad30800b001fdfc8c7567so3949358pju.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=1t8QEFZcVldTAUqwnK7MhJh9T79xjGJVLMG8Bsru55k=;
        b=zuKE/8wLzawSUOKMtpCJlN1oCR9GnoltMN0EpdBOWDkZ3b2QNGxT71ZN3ZAwK8fpL0
         f05lEjBW4bUJ53XpnIFoBT2Up9qn4RxSgI3EGLKev/SUpbcUgtHsZx8/g10PkgnbIwgq
         uHE6lrpcw2qKpoa2thuNw4uKpXoS1aKrtZhfIpGEgsRnMNqN5BCs4xXtUfQXH4babpuu
         KcJ1wM5uX3CKGt29tDClT5uihtzZanqtWszFPiDMMLo0yRGBk4zC7eWz0jVowDmXtMkD
         nuUB8/q07HBt6YUu09TCI8aZF1yu0t+GXMhAhI0dayDA0wxs1OpAaFfhAbQCwL/kJDDO
         YHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=1t8QEFZcVldTAUqwnK7MhJh9T79xjGJVLMG8Bsru55k=;
        b=O7L++YUOEsFHEowhsiMwIih7Xx4kg4NCRGq3033PoJ91J3jxgbIULh2Blog0nNYDP6
         sZTjVWTcENMH368P+qoWrtmXAR5GqBK1oYKMSZQ00OYr6sz093N9LH0BpUkqq4dWEmal
         fIkxCEdO6RFICQwZoOVlj3djcyCxnMZnwQa/M4bcgndXgfjBnQQVwuBLZR75+ssY0vGz
         6vt1EYLlxsLaVpW8+vMgjOEiUWzIeTosvwue5S1y7yhcreMH9rDF0H9sHXUZHRVQwiJN
         WXzVW6qHqcpm1q5VHT/lYzcv/p1cfDY24hEQtHzTvo8/yAWoFycH/w3dTI8oN09QMMJJ
         cPdQ==
X-Gm-Message-State: ACgBeo21Cg8zqoGERzSeXngm0uiuPygdN64uBZXY+qQVRHNJNTIFRj+T
	GiHsDzv+qnv2c9T+qEXR7Ml49GN3SbAVaYDh4t0=
X-Google-Smtp-Source: 
 AA6agR6EQd7+OdBW2EqGVJQIty6AXjmmQhqWYjoDukgLnYtDXlpi3tFlFRJef2WbAjEx7OAkltPfFw==
X-Received: by 2002:a17:90a:2ac1:b0:1fd:7e42:142f with SMTP id
 i1-20020a17090a2ac100b001fd7e42142fmr4501615pjg.181.1661971896592;
        Wed, 31 Aug 2022 11:51:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q2-20020a170902a3c200b001714e7608fdsm11965495plb.256.2022.08.31.11.51.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:51:36 -0700 (PDT)
Message-ID: <630fadb8.170a0220.1b999.5c7a@mx.google.com>
Date: Wed, 31 Aug 2022 11:51:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-90-gd4130d0ee3c7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 8
 runs, 1 regressions (v5.10.138-cip15-90-gd4130d0ee3c7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 18:51:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9391

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 8 runs, 1=
 regressions (v5.10.138-cip15-90-gd4130d0ee3c7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.138-cip15-90-gd4130d0ee3c7/plan/kselftest=
-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.138-cip15-90-gd4130d0ee3c7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d4130d0ee3c72fc50c48ae861863e85537802c47 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/630fa5c24138fb0f57355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/630fa5c2=
4138fb0f57355643
        new failure (last pass: v5.10.136-cip14-542-g97767707d3d0) =

 =20

