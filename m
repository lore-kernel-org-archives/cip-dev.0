Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D5C7EE2D
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 08:27:42 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.3695.1685089653627624153
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 26 May 2023 01:27:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=qgwvK1Ja;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-534696e4e0aso305336a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 26 May 2023 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685089652; x=1687681652;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MsVDD/UzZTJQcaNK/uNV13f8vsC7WcdqHDidOby3Wjs=;
        b=qgwvK1JaC0WvuqiIliCwYKqujSveXdN4GAps6MgKCSpTOK0zHTrsBeUWbDtbdtMc3j
         QAuFHDHuBACVfTyt9ZlB7hVO/VI3OaSbp3GWx71BL/0mekiXlSfP0SXtImHH7k4H2ioi
         KLFZRMzw6+3ndw5pQk6j4bfR1N4TNoAs+0UoOn3mAZoHShhIqaTk4IgErznsZOfwqjVo
         LVZy7z8A7eN+pcuLbC9ShZ1X2VFSE0smc3rWhVsOO+QbIj/c4AGa9e0JAJbvTjtuJXAS
         57mpDCemIFWfcWLwS+k13DHjo90r8YFx4K0KoPJ+4xBCQEbljIwFm3ZgiICzf2pB0aIx
         jA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089652; x=1687681652;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsVDD/UzZTJQcaNK/uNV13f8vsC7WcdqHDidOby3Wjs=;
        b=G9Io/+Tsq0kRrpdkjk3aP4CnBMc+jaJxY8MdPnbGFztHIaWjSGFH29C4cgzeQnaxwW
         DmHV0xKk7eaMoZx8uxU5tQLVyx2Ln4CuiCQe+tORDOO4sqs3HQBSBNINLoVXB9u1s+qR
         oFecwL3mQgOS7CW7N1fnw27lhYZp+I7INiucWjwgbK40mQ8psVoYE9D9tmSaPkNJzLQL
         V30XHlSFoL3tjYgsJjrAPVVMddGmLoUkmWKhHw2LtQazAuwQqOyYFfu9DNWoqf5rory0
         rDru8+mlqYBmIN6c1xpY7MHtIl4jUHLIMTir/GjDM7ATaUG7xAlr5EkTY7dN6lZL7bBA
         /kow==
X-Gm-Message-State: AC+VfDwxEzsqBwc2J5X8EF7JN9wgWoUoMoam9qRzGJYPbGR7dxTCACmu
	N/ejbycpu1wSxcukmvQTiMWYN512Ok4G9rtkKxAlrg==
X-Google-Smtp-Source: ACHHUZ7/xOv1HZyTgRyzFJ7MkP6s7SlOWjjb4bxfgx0Ok9X5PEkXeYB2Lqd6jCvFvK6P1Qn4r7t9CQ==
X-Received: by 2002:a17:90a:498a:b0:253:6db6:18be with SMTP id d10-20020a17090a498a00b002536db618bemr1445154pjh.14.1685089652362;
        Fri, 26 May 2023 01:27:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fs11-20020a17090af28b00b0025368c90773sm4067579pjb.34.2023.05.26.01.27.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:27:31 -0700 (PDT)
Message-ID: <64706d73.170a0220.5b526.8824@mx.google.com>
Date: Fri, 26 May 2023 01:27:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-21-g090289427e8b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 9 runs,
 1 regressions (v5.10.180-cip33-21-g090289427e8b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 08:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11653

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 9 runs, 1 reg=
ressions (v5.10.180-cip33-21-g090289427e8b2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip33-21-g090289427e8b2/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip33-21-g090289427e8b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      090289427e8b2be9dac126c4d1b760b100f2c6b8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6470605f5ffb2443fb2e8646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6470605f5ffb=
2443fb2e8647
        new failure (last pass: v5.10.179-cip32-384-g291adc46abef0) =

 =20

