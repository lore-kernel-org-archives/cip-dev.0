Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC986C43219
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 10:33:51 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.17660.1667471622505812245
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Nov 2022 03:33:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0M3msGq4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id g129so1280514pgc.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Nov 2022 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kM+y0uZDegedYA+yeY7Slo3XR8RY3IKVvgLLS3Bes+c=;
        b=0M3msGq4Y85o+C0YSdVj3Yr7q2hPqx2tbEdQfSxGESb9vNaUY8F4cafm/HJJU060Ic
         h3P+22dPs2OcTlKFl4Oj69JiziC3d02wanwXkaQt3iVI+ImJ7sTMLu17RKp52m3p3DPc
         gumbePqSWKfSE8CBPB9W3Vnl+6LC3CUYfsHAgGbDrKGT7sexroND6MoobfQ0MQTWlsU3
         Tt8/g76J8/Py5mV/uI2QFzyoB/v6b4NbdNqZu8hUa1XzHZGgmhLHd++LRhrZHtZSGSN+
         rEjFR6lwPQXUG/BwyETmfWQfti9yUdfJMI3xD6HPd0tVh6uD76nrfBRbWdU+c60sF4Fb
         tQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM+y0uZDegedYA+yeY7Slo3XR8RY3IKVvgLLS3Bes+c=;
        b=F5z/IQWaHoU44LHvSH8zzCCJrUq2RrWCGnvB65tvszkGIA9aPyVNu7bP5/qLyMN/XN
         tvKQHXObcmgm0aWv7jqkwi5/ydKzAJ5qa8YOJKZ9uh9dd3UY1xzARc9IXIjymDJpECYT
         C/E26Tffu1wvq5ZOlRTS0vC0K7CBPSCufYZV3zHp926GieOoGZ0V1NSTvIhAhPysAGhX
         N/gdInFS8vFDKMAMOYtWwwrO9tT5OYfVgm6WQd/jserEvk84PN+8iHUiAD039OJpsba6
         22hVqUa8oDc9gEeL+zT3TWbcFuv5SsgKFNv2BDUO2qriupAUhNimummQk1djERCqRt/C
         PvWQ==
X-Gm-Message-State: ACrzQf3DsMFXlIsfkTHQBQrILW7N5xpfgYV4JGirLXxRxUU/8wkqoXt6
	vaWeW90/T+9e3WXFdD3FrofQpcdPYVEvA425
X-Google-Smtp-Source: AMsMyM670CBBmvE1gau0Imp6oIEoIc5K/9b5lAsPH0Nw1mZP7ApAYIWNng8S3XJH4wkAdrqBUWtUkA==
X-Received: by 2002:a05:6a00:140f:b0:56e:1190:e731 with SMTP id l15-20020a056a00140f00b0056e1190e731mr7819164pfu.39.1667471621594;
        Thu, 03 Nov 2022 03:33:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c24-20020a631c58000000b0046f7b0f504esm483270pgm.58.2022.11.03.03.33.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:33:41 -0700 (PDT)
Message-ID: <63639905.630a0220.f3e8c.0935@mx.google.com>
Date: Thu, 03 Nov 2022 03:33:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs,
 1 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 10:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9908

cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs, 1 regressions (v5.1=
0.147-cip18-12-gcb2b164780be)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-12-gcb2b164780be/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63638488bcf63d65f9e7db50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/kself=
test-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/kself=
test-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63638488bcf63d=
65f9e7db51
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =

 =20

