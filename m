Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90CEC7EE2F
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:29:32 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.5065.1685964565591267152
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:29:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=weRxCjLy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-543a09ee32eso829282a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685964565; x=1688556565;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XpcVg5EKrs9nKWuTlR7RIgJcWEgwC8jFnn3ooF1CtS4=;
        b=weRxCjLy9uzAL0ruXJXlnxq8OnSy9pm6U0xv5wrM/weDOBJA1SiTY+KhV1OZ0YRI5e
         sZaohousFZ5dXkFeJvwmYcq9LCJZQXDrnWi0DEubc4a0ziM/r1UrDrRd0KFA4phWey4v
         ft8HidgvlhT1gJui9GGqe1DMEclAB2qLwCvrI1i11Ny33YvMHhGQA1bRGTMNWDfG1u4O
         rT/F0oDWEZfUUAstIchwUy8aBfdH08+K9kuzc0bWP5vwCFgRcZQLaqBGgMbkbmXW4TGk
         RtVCPP3h0SzeOOwA5KW4Zo5AYLLe+XApL/YVJos2WXKTRUD+FeaPtCDC7Pzy3QLAWpYq
         Wn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964565; x=1688556565;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpcVg5EKrs9nKWuTlR7RIgJcWEgwC8jFnn3ooF1CtS4=;
        b=YxUQf/Ves44MX4+p1yFPtFgBW6IH79uBYX0HEg/BjrpKIHzZWmm/KUFVf4T3jMHhuk
         x4+wN/brptGCHfdJZVwsdrHJNiTP6RUbqk42YcT8JxDUw2oN5mDxcvDbVQMc8eifMoOu
         +8cgl/NrdGfNqJjf4ljeDiH0HYNBOHYKqEiJ7PwniCmi3obJ80drJ66cECEBeE+HxEDS
         v/hmhUZp+9L/bBVpTTpQWbjfr8qbkcVWYqniiml4Guv/RXun8UWQj+dyXkJRbmGMNSp4
         UMFXY6oO+QhhWwHasE/+wP92x8awfwwKZoTr5Q7jGCJFsRgXhPVC7VRWw+Dwoj0wnbUf
         2vNQ==
X-Gm-Message-State: AC+VfDxY++G01RT2L9y7pPfzCV8mgXpDomBkKokYOhAPlHxMQRCfuF1F
	+kwAoXpMU9/O9FpeljY2XHBnMod9qqDM7bkFOZ6lRg==
X-Google-Smtp-Source: ACHHUZ6rOi+vv1tv0oUd44QYSymMq3F178BliB2bh68lGHpe5xKUyZ7hVU3+d66f0JR+phg+IOPZQA==
X-Received: by 2002:a17:903:2449:b0:1ad:ea13:1914 with SMTP id l9-20020a170903244900b001adea131914mr8357862pls.30.1685964564671;
        Mon, 05 Jun 2023 04:29:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090332c600b001ae44e2f425sm6373093plr.223.2023.06.05.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:29:24 -0700 (PDT)
Message-ID: <647dc714.170a0220.16b50.acae@mx.google.com>
Date: Mon, 05 Jun 2023 04:29:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gf0f6960f132cd
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs,
 2 regressions (v5.10.180-cip34-19-gf0f6960f132cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:29:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11801

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.180-cip34-19-gf0f=
6960f132cd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-19-gf0f6960f132cd/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-19-gf0f6960f132cd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0f6960f132cdf82ed0fcb61de7c496d33f0998f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb630fd528cce2f5de72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/647dbb630fd528cce2f5de73
        failing since 509 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dc0db89e3046d29f5de5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/647dc0db89e3046d29f5de5c
        failing since 509 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

