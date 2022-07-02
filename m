Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E0CC43334
	for <webhook@archiver.kernel.org>; Sat,  2 Jul 2022 21:12:49 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.54625.1656796367059245883
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=v5ZXGHMk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id w24so5833360pjg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rgCJTlD9UvjVdWIeaeZ+ckeUFhXc1W9wjuJbP+lIojw=;
        b=v5ZXGHMk6LmwsDg+o2n01d+bga6utrpitKhrysKRrsE54/LuO9MgDPcsmdYa8obqbw
         zImBeMiWDv246c1N8AF9OIYbsTPVVnqCr5I7hMV37ZJMoUwaCTKT4vZruvpPDXl0gz6s
         4hS6i1qCLV7nl9U/w/cTYdfKkGMtZ2jhaMPl7iG/7t3PONf/NETWNQYC4jCNWBvty2cI
         MjrX49sOyYz6w5w9uQPRok4dGF6cFiVrhbeaC2Nar7qul9JhY/OpsOkG/kYgLObEb/8n
         P72huYDykOvsEGPclGNkuZO/ZpUVmo0eYa3CUONVm3KBtcMJiFxvJRbVl4HYYiF/ghWT
         If+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rgCJTlD9UvjVdWIeaeZ+ckeUFhXc1W9wjuJbP+lIojw=;
        b=3xYY12nCYWwW620fKTsBE7DArwGJu7LYAtrUvTn5avMVFji1aDSR2/4MWdK4Z5XTaG
         g3um1B6ZlD+AXsF7KHrOZnbilm+s/0pIvyZJpPspwMP57GGTv0k32vbJPAAsCryPgNsE
         Mvn48fHReXJ/7a1UTY/jycnKm3DIGleVqeiixBw/PEA3zaNzaw02Z/10e7yYsldHVahv
         iRPuhbDoY8lyf5oTMxpMSV7X7HJixGR6ka67EPSLHzoKlk4uJa84VKZV/yik8SJq5jI7
         LhM9ka4/DTj7nSdhfRGcPoRBbkEWHi1GHdhOrb2bnD+gmyhNDz9mP/8lGhOBSCZGkJUK
         fIYQ==
X-Gm-Message-State: AJIora9i0mSFj/ilqFvZmY2trqFI3uwxxZGycRPt0EX0o3VvxrjnCRJa
	h/R6XE0kc/3HHv9fITqyLCHOO/Qv/tHs3+wZ
X-Google-Smtp-Source: 
 AGRyM1vkjrh0EV+VLqizM29u/0/9A+96Arh06oAZ2fnaG4T/6S44NtJPhASbbF3cAyXL/w5UTE4/0Q==
X-Received: by 2002:a17:90a:6fc5:b0:1ec:87db:b9f6 with SMTP id
 e63-20020a17090a6fc500b001ec87dbb9f6mr24920025pjk.104.1656796366223;
        Sat, 02 Jul 2022 14:12:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q17-20020a656851000000b003fdc16f5de2sm17830928pgt.15.2022.07.02.14.12.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:12:45 -0700 (PDT)
Message-ID: <62c0b4cd.1c69fb81.e6b66.9dac@mx.google.com>
Date: Sat, 02 Jul 2022 14:12:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-118-gb03e159be974
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 6 runs,
 1 regressions (v5.10.125-cip10-118-gb03e159be974)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Jul 2022 21:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8637

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 6 runs, 1 regre=
ssions (v5.10.125-cip10-118-gb03e159be974)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-118-gb03e159be974/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-118-gb03e159be974
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b03e159be9746a2cba92777632dfc469e7cdecf3 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a55a3d2c73c546a39c18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c0a55a3d2c73=
c546a39c19
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc) =

 =20

