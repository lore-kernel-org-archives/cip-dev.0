Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E0EEB64DD
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 06:10:24 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.82503.1691561424444622824
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 23:10:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=G4+pY0sZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.180, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a4875e65a3so4539138b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691561423; x=1692166223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NXSpBRvwbNM1tluKqK92SVq5SxJeUFlt6s2GC+dmEOw=;
        b=G4+pY0sZw81QqKkbTlBDfCJvcBnABiK7mOHtEnDJEyUC859SKZb67i6Z3E/YHLcoVH
         Nkd8hahdvi+9cVESMD2LZ3yeP823JTopE1RJ/xxvM81ci/kUyCpXJoPa0zzntmGwtn8B
         ll9dtl041JgGjqLgY4LN+Cug+DOolNHS4vvx50XI7ymHQMQaVoeGzb8uAlt/fEyCXUfW
         yATqXvLs1abRVRbBXZ4vQuv0quyf2Q73WEyQrL+I0jLZduxfmwnw1EIwrrS/pkVec8nO
         QpyJ7ik8YMxpsDYUUz7k2k8QhkM7lpzt/zKp1ByEyQhE3DTjknuE13vcvsLokuUimevO
         s5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691561423; x=1692166223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXSpBRvwbNM1tluKqK92SVq5SxJeUFlt6s2GC+dmEOw=;
        b=LwyNBgBeCYFyhZ4C3G7vgAyxMlTId7Ak76+DRPzlTb+vWGJVsYfYVHCunoQtMqYFaS
         oqQDznm7LOmgZ56zz42EN8YuMRlf34lm7T5QKz88b23GO20KjEPF7q6oQXZaZBAT5crn
         541XB/KLrNgIZedGm51dnT9wMhjrX6WKvixN2TF2GKpVAizSYOQR5YkIR/GLrKv00wIp
         UQ8U2+XJhZmWc/KEms+ibLZcL45qpMxaci/uzVdBWDQif+5M+0UtNP/psvW+JyPeABUz
         eLrUJNv3nv5PApursH001fwKxWhbe24jfJjYq8D5ZR2ckN4smMmMePxGDt6q+hovQfI6
         yzWg==
X-Gm-Message-State: AOJu0Yw50j+21lSxlTstwxh35ogWs1dlT9UpfAo3OcQ1Eos0/jrnx2h5
	40WcABdsUwhM0FxEh4hzJcxCGWN8h+tPNj5K4UETbg==
X-Google-Smtp-Source: AGHT+IFDaGV3OSIWXzE2+gFW9C/Lv+bykaTCjfHb9kv4nBuZu031Jx4cCPOCshGNBynskilWxLX/6Q==
X-Received: by 2002:a54:4487:0:b0:3a7:398d:d2f1 with SMTP id v7-20020a544487000000b003a7398dd2f1mr1654277oiv.49.1691561423196;
        Tue, 08 Aug 2023 23:10:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001b9df8f2907sm10117117plh.264.2023.08.08.23.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:10:22 -0700 (PDT)
Message-ID: <64d32dce.170a0220.51187.32bb@mx.google.com>
Date: Tue, 08 Aug 2023 23:10:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-13-g260094841fe1a
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs,
 1 regressions (v5.10.186-cip37-13-g260094841fe1a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 06:10:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12581

cip/linux-5.10.y-cip ltp-pty: 6 runs, 1 regressions (v5.10.186-cip37-13-g26=
0094841fe1a)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-13-g260094841fe1a/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-13-g260094841fe1a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      260094841fe1a0a9e5ab7b9ae32450e8e4e0a4f4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31ee20ff818a28435b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64d31ee20ff818a28435b1=
dc
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb751) =

 =20

