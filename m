Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A6AC4708E
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 21:10:41 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.6524.1671225036330560793
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 16 Dec 2022 13:10:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HvP6Zwmu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so3579275pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 16 Dec 2022 13:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SOyhVIcWMCITfBmWPo6En6UQ1qj+BDGezAS2PCxfF+E=;
        b=HvP6Zwmuq1g5Dtx2lUjZpl/qAHaiAKkDbbd9iOzwFoaAhhImOv2J4JyyTQd2bn8LT0
         pBOvLZJ67b6ohfpSf7fWYciQt5EQZ6F/c5sQoPMtEp9YcqS4hGpBBdHlsqjQHNT/vmyj
         dJ3xe4cC7XbO6MmXShR0O5zgpVarPPG2HbFuEcxM0V4qYIyzLZ6w3Vrd07xQn8WBJt2W
         qrKD+1IT99UsQMtIdfI0DcGhOfdV3SYlIfgwS1zf9B1ckSXjL2ViG0STOAQ5egFXYH7c
         cygun4b/fnzObXoQ4By4V9VuPtEzpjJwHrVG5B5nqhjHSkezN/bLQuM8GViTxL3GGOYG
         +4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOyhVIcWMCITfBmWPo6En6UQ1qj+BDGezAS2PCxfF+E=;
        b=1jd6mV11l7JqYz8bYG7ImUJWoXOzGbrvYhCwWiNnZKvq7TGcuiclJal9ta2x3VKhbf
         gNxNJlLSwMY2/qf+rhQXij4YPZQ9cyUygNFCWvxJPFBdjtw/DGqXROGYnOxPJ40Kikee
         ligGKD0mNzno4fqdIrJNE10+NNa59ZjIQUOguqwPIKZDuJ/UaGSRHvOJczc9Lc6CaqTi
         Tg5J5yCy8snnekA3d0D6mPk8INbhAxEQSl6UF1/X0S+x9OJfYxNUWCqohgWtU/oJ8OMC
         MKQHtk1wM/5D4PzmUPoQy6y4reQ2SY2TwJp0Z7WNtnMLRhg9uaGfz9a47egYJTGVVIpg
         QXhg==
X-Gm-Message-State: ANoB5pm3tz2ODzNYwI4VREJoq1uwVZm298xYC/UdFgZDI4w4K4S9SBJn
	Q8CVqmf0zdUNLF/Lo1G8wDx7izWVHYg3ano9zNA=
X-Google-Smtp-Source: AA0mqf5B4s2p+Dh5FbvC5nY7xZrhfwmrbziFDkfQi0OQHYmx4dDus0hiNLEVLRsmeuLdBAcdOKLTgg==
X-Received: by 2002:a17:90a:1504:b0:219:6a87:bd09 with SMTP id l4-20020a17090a150400b002196a87bd09mr41604044pja.18.1671225035615;
        Fri, 16 Dec 2022 13:10:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i3-20020a631303000000b00478fbfd5276sm1899925pgl.15.2022.12.16.13.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:10:34 -0800 (PST)
Message-ID: <639cdeca.630a0220.fcac.43d7@mx.google.com>
Date: Fri, 16 Dec 2022 13:10:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22-7-g92462fd9830b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lib: 12 runs,
 1 regressions (v5.10.158-cip22-7-g92462fd9830b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 21:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10244

cip/linux-5.10.y-cip kselftest-lib: 12 runs, 1 regressions (v5.10.158-cip22=
-7-g92462fd9830b)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22-7-g92462fd9830b/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22-7-g92462fd9830b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92462fd9830b23227198482fe4bee42316a5694d =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/639ccb67a2292289522abd1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselft=
est-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselft=
est-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221209.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/639ccb67a2292289=
522abd1b
        new failure (last pass: v5.10.158-cip22) =

 =20

