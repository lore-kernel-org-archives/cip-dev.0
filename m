Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF22CCA488
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web09.4943.1658400836950187938
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=X4c+4DBq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id 70so1429981pfx.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YUQh4hQ/Er+SScpntV8WIiQLmAMuul8mq0OnTcUpwoM=;
        b=X4c+4DBqATCQPqFotBgFlh6BdZ2JY5SpJyae1k140ER99aOlmdUfevfaQPYng/cwDI
         Xog4bleYikmwFbp0a65pzq2GmxL4ANpIrBUVVkZo4AXC6nu/gXvW42ATeo3w7DYi4RED
         A4JponYKVCWOhROLWzyNXAuOgOy+VPkbGF6k9Anx7m02dj8xprUF8ZBPKDIAzZrOZxCT
         cUmJA+X2hUTKQiMjfEq3ZO636KfY9iAeinVYghIYzbn8pGNbUkBQLa2ix7yoaWe2UsO/
         c63Jo0tWoXw6SDtYibrFCFgUZkfnJpX0kZ2A+EvsXS+y0sIg6FjWKGoOCc5+mEEvJTGQ
         veOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YUQh4hQ/Er+SScpntV8WIiQLmAMuul8mq0OnTcUpwoM=;
        b=nBBcDdeF5hWOf6fIdm5RGdPWUCP5udI2NEdLpPaQGfmZSVskImwFFv/HDU6aEP6YDk
         6pVBgS2r4eem4786S8aTqLvgnTe5A5bUaQ6xXyh/neoIvGin7oWeXsVHZcNSSHXx+fwq
         P/xBZ/le+5UwZCaro5NQqQM7Nh1D8JaHsAO0R5BtaOSM9QufY61kqGV/sv6u/j3ratK6
         V4jyPOrNqm5bDlNJx0xRl035VaH8cikZwHGO8HsP8hsmTmS6FOGlc34WTKHq61qsWsop
         G0P4+nxvYhYI3sC6mrwqeRduRngVRWTc9Nr5lk6fv+Feu0DpWCUr+HlXptamNjkp4VMg
         rInA==
X-Gm-Message-State: AJIora/FCbFOsj5uI+ZARA7N1bvXFmgeFhXEEK3wZXMhbPVfX12byRk/
	JnFDOmt2VBmkwjczYyVHUAPUle9zuwz6jxOqnUw=
X-Google-Smtp-Source: 
 AGRyM1vft+/w+E1xlYhKw4dBlz8fUaM6tyGKY/qi0vPiPcLcrD1TKr46FPplSzzcnAHtVkPTl+UIlA==
X-Received: by 2002:a63:1943:0:b0:411:5e12:4e4f with SMTP id
 3-20020a631943000000b004115e124e4fmr37449993pgz.400.1658400835940;
        Thu, 21 Jul 2022 03:53:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 g11-20020a170902d5cb00b0016a6cd546d6sm1315736plh.251.2022.07.21.03.53.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:55 -0700 (PDT)
Message-ID: <62d93043.1c69fb81.127e1.20a7@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 2 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8873

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 2 regres=
sions (v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62d9218807959647c5daf087

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220716.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62d9218807959647=
c5daf088
        failing since 14 days (last pass: v5.10.126-cip11-1-gc5218dc69ff1, =
first fail: v5.10.126-cip11-116-gef362fbbff528) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62d92a54e264ebc4e0daf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220716.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62d92a54e264ebc4=
e0daf05a
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

