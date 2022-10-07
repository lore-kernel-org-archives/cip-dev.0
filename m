Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47335C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:07:44 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web12.3170.1665140859051459385
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:07:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rdSGhTzB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id x6so4215520pll.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Wr9TG76IvsrTWdtPUulJ1ht6IiBf80+lj7RI8EbFMA=;
        b=rdSGhTzBQR12xondHoZCYAf3LjxLV4hJW9nTX32AY1iB785rW5tOUNKGz9KuKNfoQR
         SWO3oBLWA2+/X+L4z93RTftSwStLY70QrpNde6xJ8IlBeFzGPMsoW261oSAwWqmNnK/x
         JKOH177OD7PThUO8L5v13HTw+zK2sJy3h/96yIf+ic4l3rlYKft5IAKPdfXodx5J9FZv
         ZOSdiejLNKKpLRM+nk5tuCl5JG4jwL1uo1vRPo5FEqkHMe0XlziEHSibet/fckHJixCJ
         rIeX+vAYIJXfpJsyfu7Y5mt6n0KZ5vqaNhAxe9jjqAyJ+HDaicNZiYNUAfyj0TktuQfu
         PZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Wr9TG76IvsrTWdtPUulJ1ht6IiBf80+lj7RI8EbFMA=;
        b=hoHoQe9He5CZ96teT0spL3P0XTMKecETQV5j7jqfCvMnBq3bvxL0zqXyO0Vtrptt44
         lCuS+DmSfxHOYPUaPrTffYsENBen00gUIAcivH6hEAdxkxW6IRdK6kHn7/a+5jRMEnWH
         0+163+vQt7qefXkJxL1YKGJcZpqR2BsCYgCuGrT6k+hRHrshwmPcUS5pFbKF1ZCyhTEx
         UrBaXUfoMKAQMkJK4gmUKA8pKeVKvS9nGAMs6+IY0OTVksJvm4eZqqCvUja/lREdUwpo
         dileM0NwWy0syUqYMw+tepzFDZl9IvEqen/kdW+PTda/cL3+f7DbDCx+Cz2P8oTnqBtr
         wG6A==
X-Gm-Message-State: ACrzQf2IbnJh3g0WK4u6otPcp5iiejKVlO9Y6Slj7F+jg3OMCHae/R3F
	O1m/LLuhhb0VKbIydsUhYWfV94UY+faAk/Uocx0=
X-Google-Smtp-Source: 
 AMsMyM7hYQS/P7WngGh7HhdPhkIYym/UhY6KSeNz36D2gxUiIvv4xhPesMGsRNEgxkBx6Y7xSB8nZQ==
X-Received: by 2002:a17:903:11c3:b0:17a:e62:16e8 with SMTP id
 q3-20020a17090311c300b0017a0e6216e8mr4382306plh.137.1665140858225;
        Fri, 07 Oct 2022 04:07:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a127-20020a621a85000000b0054cd16c9f6bsm1281731pfa.200.2022.10.07.04.07.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:07:37 -0700 (PDT)
Message-ID: <63400879.620a0220.eb30b.21ed@mx.google.com>
Date: Fri, 07 Oct 2022 04:07:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 24 runs,
 3 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 11:07:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9681

cip-gitlab/ci/pavel/linux-test baseline-nfs: 24 runs, 3 regressions (v5.10.=
145-cip17-rt7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
at91sam9g20ek                | arm   | lab-broonie  | gcc-10   | multi_v5_d=
efconfig | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie  | gcc-10   | defconfig =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-rt7/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-rt7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
at91sam9g20ek                | arm   | lab-broonie  | gcc-10   | multi_v5_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/633ffeb14d248ec26bcab61d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633ffeb14d248ec26=
bcab61e
        failing since 6 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6340037c6acb233545cab5fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson=
-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson=
-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6340037c6acb23354=
5cab5fb
        failing since 6 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie  | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/634002c60ac1d6c405cab601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/634002c60ac1d6c40=
5cab602
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

