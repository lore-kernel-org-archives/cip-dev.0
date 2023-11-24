Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC9C636CB
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:59:47 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.134885.1700830782220183524
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:59:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=drWvpPBT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-285636785ddso1307363a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700830780; x=1701435580; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LYDACYo0wQSPBagExnCU8eXN85Ilv8/esRE6BjkOKWY=;
        b=drWvpPBTJcpF80eRZXDwjE1GZhUfJ7AXTLNOzpkUCq9EhtERqFk5mms0GMzOMVwMmY
         c8E+OSgcJH3lIrgas1AAnqoBVDcgejy7YtRFt4uLeJVsGygCw1XSS+UOxiiNXn0xGXWe
         CxvghXOW4XrzxPV8c/v0uCGWrd+T5FkDhbQnluzaW5ozrXkWsgJJwqPcGxIIJ8NZanqL
         xb0u7roVAGjzVAOJG9qDHrNeYy0gBn9MbpLK6ISYkiUeCDeInhTJVPofldRa7hKf13nV
         vakBd0ZZNam1j1M3xTATV/6aUSlKPWIP/LioB3lG0fEjIfmxeQ6pbv7JPGRSF9Tml1Cv
         RViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830780; x=1701435580;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYDACYo0wQSPBagExnCU8eXN85Ilv8/esRE6BjkOKWY=;
        b=gKgnfacVruYXCbZuFa8suqLSXmW0BLE3D0gxD2rmmJr7yLgVdD1Mgih2/yzMzfZ2+H
         76DpQd4ackTbTI+dX7c4Weu2zbjorCPSQw4z45ivGgk0b3w+xZtio8gxOfYNO/f6VWTY
         zfgFC5ibZcmW2dAQwnWVygopRSs9H21nUBlZoRl6lCzB1AIldgw9lHQoivfm7l6kYVUK
         tLP/+g2uKgJEehtwrv9HWLGd2h3ud+p4RShfmNkURtvp6DCQ77NECiJj9eahbI0Xs5BZ
         Fnz3BWfRoHawo/YhR9TYUgAXQwDuBRILuIXsboR4NRJjHM4yqcLYUmCqpNCFLQquvPk3
         5j/w==
X-Gm-Message-State: AOJu0YyWHwa+GakRRlCFOdFclj8b2QSRBMdtYXuTfGU8O+H3k0ECFCp5
	qW+FQAxxWHul2hPb9BSPW/OLf4ZMzZzECnR3Uw4=
X-Google-Smtp-Source: AGHT+IGfRVjCUDS7hQQgDupYs9HxmgA33YtPiZS6RI1ky5MPSWlMQaigMKzobutkhHz7tEXcWYE8Sg==
X-Received: by 2002:a17:90b:1d81:b0:285:652a:6f5b with SMTP id pf1-20020a17090b1d8100b00285652a6f5bmr2496746pjb.6.1700830780588;
        Fri, 24 Nov 2023 04:59:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adb0200b0027d0de51454sm3212557pjv.19.2023.11.24.04.59.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:59:39 -0800 (PST)
Message-ID: <65609e3b.170a0220.7bb8f.86a5@mx.google.com>
Date: Fri, 24 Nov 2023 04:59:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 10 runs,
 2 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:59:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13743

cip-gitlab/ci/pavel/linux-test ltp-pty: 10 runs, 2 regressions (v6.1.62-cip=
9-12-g3a5321f469b07)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-12-g3a5321f469b07/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656092075be9feb4c47e4a77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/656092075be9feb4c47e4a=
78
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656094304f743dfe5d7e4aa3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/656094304f743dfe5d7e4a=
a4
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =20

