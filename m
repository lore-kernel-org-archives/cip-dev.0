Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4DDC3DA7B
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 21:10:41 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.6523.1671225035962550697
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 16 Dec 2022 13:10:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7ecDGpQO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id 4so3528141plj.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 16 Dec 2022 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L53JNAsYfXJv/0XN7FTm9RiNTE33k/BhAFGOzF8WlqE=;
        b=7ecDGpQOC91Igh0vMW1eQ8l0s56gaR/r9KzV8CwGXhBReklq8ehOWAq398/OMdBjg4
         vxZBloPY1FkHGO/2WlpyqVjUOjxn36ZmT3QGvzbyNjfiAarRRBS9xL4Y6KCQ4tsPn6xq
         42cdW2PjsANHv4T7Xyhfw8rwIG+lRMTAA/9Jp9pko0WRb9bBAiAqN24lrdDSnl+pgzZd
         77NBwLJFAPGfRPlf093R+ToA6SZiFTEuma0OPJoiDsxZqoYVaC1QVLFKEtYFrEBqFXWB
         aVlgfLBo67Tz840PEsYEVkMRqct2/83EqNRaeLww1ISHjZWpLJ03idIW2bnLjw+iaNw9
         DnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L53JNAsYfXJv/0XN7FTm9RiNTE33k/BhAFGOzF8WlqE=;
        b=ywgQ2HJfIbFhUJhsAbmqYRLRXfxJx6U35kFuePo0gfTzU4OkMb90CY+K6twrx27vYT
         3qBm1KoztSR/Bxq6kYikukL7JJBUoLZ7DLBufPJa6yDV/oLkfIcU+uu7ZFfEddRKze2r
         CfLJkSCOgZP0cxnEq/wql7/JIdExVuQB0aPkSw1aDeUKzuMWITyHNznzudzJlAwnVlaE
         kObiZbc9al61Kwr/Vek2Ikow/88bfue8yrEDNeouXrwDlmHcd1zPubnaMfA8NLsb/Yvb
         FVNFZEfX6x9mxSK1gf+KnI+/P/xuLakdRnoFRNIohn8sC80xlipbiz6eWmP9vzl14Xmn
         A1nQ==
X-Gm-Message-State: ANoB5plo7chjhYT/wtQ+QKcjre4OpdCIij38fX4KNmlvhH2QP4SGXGY9
	KUSNuMvcpVVSg6Mjy2aik9nWyL+zmXzBltZR4v8=
X-Google-Smtp-Source: AA0mqf7ER3ebbDGh8fVGuaRIBisj58vN7JsyQyjGZvx20rkOa6AHYFGpEdU+GaK18ybizIY2zFdtxg==
X-Received: by 2002:a17:902:d4cb:b0:189:d0b4:52d0 with SMTP id o11-20020a170902d4cb00b00189d0b452d0mr48261768plg.46.1671225035251;
        Fri, 16 Dec 2022 13:10:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b0018958a913a2sm2054024plh.223.2022.12.16.13.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:10:34 -0800 (PST)
Message-ID: <639cdeca.170a0220.a812a.43e9@mx.google.com>
Date: Fri, 16 Dec 2022 13:10:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22-7-g92462fd9830b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-futex: 8 runs,
 1 regressions (v5.10.158-cip22-7-g92462fd9830b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 21:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10243

cip/linux-5.10.y-cip kselftest-futex: 8 runs, 1 regressions (v5.10.158-cip2=
2-7-g92462fd9830b)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22-7-g92462fd9830b/plan/kselftest-futex/

  Test:     kselftest-futex
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
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/639cd157b2f108ff382abd33

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-=
meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-=
meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221209.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/639cd157b2f108=
ff382abd34
        new failure (last pass: v5.10.158-cip22) =

 =20

