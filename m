Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D9CC4829E
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 00:24:51 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.10657.1707179084493070164
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 16:24:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=RmCmwPBg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29026523507so4160023a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 16:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707179083; x=1707783883; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pvdx+G/7hqGLy+KkEGhF+/a+VGc6XJ6t8WZVr1lt3e8=;
        b=RmCmwPBgdAccGBaxjF9d4SfWGd8+seuKGLjOWIt/Vq6w/qGNQiZdpcm10hXhwJevOr
         hal3xnkT5l5jJ0PKvki0byCbMPJ9hYqpWb8qD1uhcbbD9lTG4w9BIhNI4q2dc5TOXZHC
         Qio3UrYqlk32VsOp3NeMhKS9o1c0UaQACOJPn145mexYwFh/Xu9DjVxSzBqiqnjP1eIz
         aSzR/E4qaznz6hc/boonAovzzlrDlkflfgvRZ6+Uu5G8M8VRia3m2GQ51XfMoEmTmwBk
         8e1ThtURuNTMegBPuQOpPT+f6dqxtAcXNaovpDCKU7PIqtc3CDds5E6eWni3CFVsw1/y
         p50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707179083; x=1707783883;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvdx+G/7hqGLy+KkEGhF+/a+VGc6XJ6t8WZVr1lt3e8=;
        b=CQ/mxZtz+5f89KR40gJnTJ5FjD9DwNbl/WeZr7vbLC1C1nAakRqnQX2b2o41QxpV8M
         3NPavc4dO6nd8I6YwiMCFq1DsIVJ35V3bpxUtr0zQg0RVY0a5xkUiU+bgAd1V3Ieepbe
         34bTGB1ESKq2tQKc0tBETFsS5+4P13ZJrTW7OM1g4ucbdZ4lKyQL2IueH7Xnc7xjBJHV
         q/Ycy2ydyntwGtGiksJvioIgib0XVXoxETcmzN7WQXwBv+QTi5zkeY6PymnjmlMXW72j
         /bbFC9PfUhCPCm25bT7UwXwvXmqW8WcsznT3SVb70COSy5H7AtCx4vmpNeW21JYiS9LO
         i/vg==
X-Gm-Message-State: AOJu0Yyt/JKZrI9gh+YPWJAP/sgzY0rMunsUIK8BNJSTe31bjEHG12X7
	t+ZADjadbtSjBB0cp2t+io2DlCxnPAZKjPM2SfujYO11F5YE9s1ioU4hfu/okM/wm1bq3SH++CP
	I
X-Google-Smtp-Source: AGHT+IG4R/j26aTmwhyvEBntU3kkWNJFI4zjH5A9opL5aF+HfOJ9a4TIUPoELboi0MKDPOv6RSnO2g==
X-Received: by 2002:a17:90a:202:b0:296:3a70:ad55 with SMTP id c2-20020a17090a020200b002963a70ad55mr869318pjc.34.1707179083329;
        Mon, 05 Feb 2024 16:24:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id li13-20020a17090b48cd00b0029681231ae1sm92233pjb.28.2024.02.05.16.24.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:24:42 -0800 (PST)
Message-ID: <65c17c4a.170a0220.58862.048e@mx.google.com>
Date: Mon, 05 Feb 2024 16:24:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-526-gbbb905888ca85
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 13 runs,
 2 regressions (v5.10.209-cip44-526-gbbb905888ca85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 00:24:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14761

cip-gitlab/ci/pavel/linux-test ltp-pty: 13 runs, 2 regressions (v5.10.209-c=
ip44-526-gbbb905888ca85)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-526-gbbb905888ca85/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-526-gbbb905888ca85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bbb905888ca85ace83da9e4113b4957345c47d70

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16d651368f55f6800a047

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-pty-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-pty-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c16d651368f55f6800a0=
48
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16d883b50dca38e00a044

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/ltp-pty-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/ltp-pty-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c16d883b50dca38e00a0=
45
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

