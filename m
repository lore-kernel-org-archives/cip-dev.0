Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB797C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 05:20:05 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web12.80829.1656998395695014260
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 22:19:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=IYp0znkV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id o15so6593773pjh.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 22:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tbGrq1EP6SWC/8GsPvzsWgyJmTRHmyRDXWHw2e7ReQQ=;
        b=IYp0znkVSg+ZNuoIfUk/SYyI+SJjCvbqQKFo2v6ZkWblGNG95+0cmQI0YwWH31lNlP
         Raj+1k1oV8OJI1SNlweMhWWtRT8gkHnOkbcPbsW19FOV2WIj8nZibUGazuPvWFI6U+qu
         pucJK4v8JMUaBrKSBb7qtDPJr3tFhDa377ObScho935R4TF4HT6dM7//k6xLRKMop7V4
         mO779ESd8tVOxj+r5Qs/gzytKaDXjvrjzZH7bRmXO+6juFKfoXMcKsc+9x8MD6Q02pgu
         vsQjzVmebvoo3H/9Sao2OCfBxwCnBkAn4Gl5oEv+/mEKr2rj978YJ6+7YXKHO/XuSFxB
         N8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tbGrq1EP6SWC/8GsPvzsWgyJmTRHmyRDXWHw2e7ReQQ=;
        b=CTNzRD6GLIbrPdrLYe4SDyn1Z/eX00IOFtd/uCFigtIomJ+mLzUVQ6uVqyfaimwREn
         zHvwvVHilkED5yYy8PhZeemGGz8Ea+h4GMOblWiiHeHzQoAEw72YU0Rf6duEWvcMwWIs
         x3kXUXjxoLDR84mX1nVSPAu7/nIhAercBPqyeQoR8cxasGKKh9EkR+CnuXDo1UE7tGN6
         dL8Jnfcd+TWODEvyDLrmjA6YKHVl7CTS03jFYWyJ+8lvFgBQDu3bjcYyNPRsVT1DFfV2
         I6GIijIZndE3VIXUcB2KBc642aRRcvNlPG2eOeVSUddgYYmkVtX4/vFI9pJ97QDnnM9H
         lcEA==
X-Gm-Message-State: AJIora9jNXCmfQKE/aoaHGXVT9iFgQO0ntq1ILXfyIUoI0DHrR1koA2n
	tyqeh01gCiwUS+H7myAjIdSKnxZ3LkKr/uji
X-Google-Smtp-Source: 
 AGRyM1uyX4nmLKLcaboDkgyBV2cUbdDn9XSTZ2H1uWxwp1FIGS7jCuelI939qig7eN4m91ge+4SA2Q==
X-Received: by 2002:a17:902:c950:b0:16b:8ec7:b34 with SMTP id
 i16-20020a170902c95000b0016b8ec70b34mr39041766pla.143.1656998394764;
        Mon, 04 Jul 2022 22:19:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y201-20020a6264d2000000b0052521a00e69sm21857036pfb.124.2022.07.04.22.19.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 22:19:54 -0700 (PDT)
Message-ID: <62c3c9fa.1c69fb81.ab36e.f37c@mx.google.com>
Date: Mon, 04 Jul 2022 22:19:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76-54-gb41c396e258f
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 9 runs,
 2 regressions (v4.19.249-cip76-54-gb41c396e258f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 05:20:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8676

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 9 runs, 2 regre=
ssions (v4.19.249-cip76-54-gb41c396e258f)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.249-cip76-54-gb41c396e258f/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.249-cip76-54-gb41c396e258f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b41c396e258f2fee2f17d7d65e4e03a629ba380b =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62c3b5561469cab263a39be2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c3b5561469ca=
b263a39be3
        new failure (last pass: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62c3b6363c2feb78f4a39bd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c3b6363c2feb=
78f4a39bd9
        new failure (last pass: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

