Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D40C38147
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 16:05:34 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.19615.1674057925423165966
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 08:05:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=aKg3dWHU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so2852316pjm.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oDPHM0U0ajE2mMgBiJVi8ItxnXBBiOawgrYU2HD2+mQ=;
        b=aKg3dWHUG8ZudcXhuSuUsHdrSmgSGNba2qToRwTVlZWTSsO31qkg3uZReoltUKrY/G
         wVpziWfgiuzzUufVCIZkkAF7DrN9SQ3xYgvfll4j8tYFbsm5oib+q/9QUXofbqd38N+Q
         YyD96jVfEF2T+/aqN7RT/o2fgtGHRYxBMafcRDi4q7f1gognV9yRRa/LhqoFjyi+b6J9
         +JIkeCfyGRWsj7edZV6cXvFKlUPetcbKvCdCSbaLtnM9z1P5xieCIPZhSoQm5g0Ipp00
         UIVlpUESrNSHnWpH69+FUSQ6Sl4tOGvU3L5js3VD/Qe6n3mT8OWsjUCKJpjRkABeQxWf
         LHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDPHM0U0ajE2mMgBiJVi8ItxnXBBiOawgrYU2HD2+mQ=;
        b=6svJHo5Mb78odYzs5txmdMFVyHzR7RuYusDqPLq/ct3FGh0kDJ436OknKVgMHfAZKA
         tdICPMWYo5GiJxzZFdncot5erOa/ws6/cnuxqnYPti6vf8P8ztWk2tUGVAhzrdHcJScr
         qlcKOf0lZF1dZ2Cywu5C3t2gq3lDboFk53fZx8Qh8rl/fspdzt1c5lK9/Z4QNZ/IC/vN
         gU3Q8E8mTm20WvuVmtCTL0X/5JT6c7XMCQARoUyjhcncH/fRmS0A66OhGSKizizOnDMZ
         8JkipSQKss6kzp+6J9/iy13rRgtZk1j7zzqN4Fd4B6fqe8LrzgK94NV+82gvDoLIPp3P
         DLQg==
X-Gm-Message-State: AFqh2kpqIUNa5B/WyXF1duqDfun1aXWbBL1/Qq4fuQTK/KSjHq6U6SUO
	fc+FdeUdwC5snXOMVe9lMyFngeqZA9UDn820VBMNYA==
X-Google-Smtp-Source: AMrXdXugZcxWZZiPr2JeX6Q/PSnORXJVKKoccFkQJiVTRWC4M2H84RJo4MARdf77BEhV8EXe5xOiMw==
X-Received: by 2002:a05:6a20:1615:b0:af:ca6c:7d9f with SMTP id l21-20020a056a20161500b000afca6c7d9fmr10001315pzj.19.1674057924429;
        Wed, 18 Jan 2023 08:05:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902f14d00b001873aa85e1fsm23216996plb.305.2023.01.18.08.05.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:05:23 -0800 (PST)
Message-ID: <63c818c3.170a0220.c5c6f.53bc@mx.google.com>
Date: Wed, 18 Jan 2023 08:05:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-853-g709bb3738fde
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 52 runs,
 3 regressions (v5.10.162-cip24-853-g709bb3738fde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 16:05:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10391

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 52 runs, 3 regress=
ions (v5.10.162-cip24-853-g709bb3738fde)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

meson-g12b-odroid-n2         | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

meson-gxm-khadas-vim2        | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-853-g709bb3738fde/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-853-g709bb3738fde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      709bb3738fde9ab95ab1303d161730f508a6659e =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63c80bbb1ae1f4f198915ece

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c80bbb1ae1f4f19=
8915ecf
        failing since 81 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-468-g86403a07ae1c) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-odroid-n2         | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63c80cf9eee2ec3eae915eef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-g12b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-g12b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c80cf9eee2ec3ea=
e915ef0
        new failure (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxm-khadas-vim2        | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63c80bbd1ae1f4f198915ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c80bbd1ae1f4f19=
8915ed2
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20

