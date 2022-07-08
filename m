Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB183CCA47B
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 23:31:22 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web09.1293.1657323077013555038
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:31:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MLldKSfe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id f11so50758plr.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7iyIlBraRwR0MTS7oHVsYOj9mRdqqgpPnE+Dg7KMvq4=;
        b=MLldKSfeAZNXi6Fiv9H/v2xMiMj0dufaRI0zGeUaNf/n7cRiOcUQbMFTsTZM6Hz3Fe
         FpKpuI0mZUVd4yze5ZNw9wZh4XEe3/IeKUhO2cm7cTsas50C43Ycguor0v8KgL8yTfMN
         XK7hQbGhoi6OgCGv99SWSJG7xocNtcMjvRRgUFu2WZDpflM0qFC0A7PYwPvQDVFpvxZ8
         h3UownudhNZYDsiGmWLBlylPq2BWeY0/nOXCIEJkcYwYHXY1cqVamqTRl4vGJDQmLxrW
         K2xBiaD+vLlU7zx1KeKRHIdDFPgUyTP9BDvDwNsbYXWSIM5LnQFWLwOR4gJPmhzSQCwA
         hRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7iyIlBraRwR0MTS7oHVsYOj9mRdqqgpPnE+Dg7KMvq4=;
        b=QwpPxlhKIPNsBPzax2fD2x0CZLTuy8TgWTQRR8YnjHZjomV8KbQFkRpB8k4FczgY69
         WY1xLWJxU8agQKtCBbxtu+Bv4vpBeC42JG6RQYrTcIsgPL0+uP5DXqc2jG9WtRTYbOOi
         q/A6P5kpdoctiNSJu4ThJKKb/wTj/2y+Mi2xNbMi5ic2/zk1oZA1qmYqjlJc32v9JvnK
         tLZf6s1Q+2pf0q0lqA5ojgoQLFVWXeA2z/f4QL+1VToWxIUP4PvYPn1YnAUROjNAtqsD
         CkTilBAdbop/2LjW8og9WzwdVFCw+rOBkILhme6LmeKeQ3+9B55usJ3jJF+RvF3Qi4Ir
         LPUg==
X-Gm-Message-State: AJIora/e8r5t1NQFPTsNuslzvHfr2I8fZ9KtupFEVTn7IODdhofiOJnO
	duCBjRWoIUFwMOdNUrJDbUaH92gifNUPnuw9
X-Google-Smtp-Source: 
 AGRyM1vV3dWJajc16bAkhx95X56dyzFMvzgEol6HHcTnM8Pzqh0DTR9AcEOvC1lrsn5uxRazjNjtAw==
X-Received: by 2002:a17:902:db0a:b0:16b:f92d:e8f6 with SMTP id
 m10-20020a170902db0a00b0016bf92de8f6mr6091424plx.143.1657323076348;
        Fri, 08 Jul 2022 16:31:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 g21-20020a170902d5d500b0016b8bec1ed9sm81569plh.93.2022.07.08.16.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:31:15 -0700 (PDT)
Message-ID: <62c8be43.1c69fb81.105d9.028e@mx.google.com>
Date: Fri, 08 Jul 2022 16:31:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip kselftest-futex: 9 runs,
 1 regressions (v4.19.251-cip77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 23:31:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8730

cip/linux-4.19.y-cip kselftest-futex: 9 runs, 1 regressions (v4.19.251-cip7=
7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.251-cip77/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.251-cip77
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e634159f2620ade28a9251a9bc2cc23b84f527f2 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b180060dfb1b90a39bf4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-gxl-s905x-=
libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-gxl-s905x-=
libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c8b180060dfb=
1b90a39bf5
        new failure (last pass: v4.19.249-cip76) =

 =20

