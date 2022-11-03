Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDCEC433FE
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 10:33:51 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.17711.1667471622447774077
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Nov 2022 03:33:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Blwz6TsH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so1433540pji.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Nov 2022 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z0XYgtAY7SG1N2/PoJGjZgKaxV2nfxx4MZxpuQ4fYOU=;
        b=Blwz6TsHIUU3WvesNXDPOHfO7Qwu9zcGkwEFjp9oT07vMQWWSAgMbo+FV6acH7lhf7
         i9vzXLhoirZt0SzvH2QBLstvtdbxohhImjFhwYXCh25xUB3u+mbO3ejACpulCGDi/sJ2
         cpj7zt5sfiIUGRGXpGcRbPIxGidEIiQ6ARpjfIILorHFIs7o+jXaiIb6F3fgIr5Qi9fc
         vXdMwolx/LiedQIM+DVI/v9UY03ijiI+L0wGiGd0o8mjDtEwZRoECiMy2wJbXSobW79d
         96LQV1jst3h5QOQb7g1Q3cRQQ6x8iFLf+5QjbFdnd4ZBhR4/03jXHxWQA1q24l5l5EMg
         mR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0XYgtAY7SG1N2/PoJGjZgKaxV2nfxx4MZxpuQ4fYOU=;
        b=yFVmEBq7xvxGyUI07lFDKbww/UjKncITJnXo3vjHlhPU8FfuC3wkVr4hYzqWedfjq7
         xyLlvOwq6RN0+N2iEU3D0R0o6ckfth+M135X/PymEakBgrhvJQNfqT+kU/0OZQXrer8u
         IYln4QSDwpwO9ak5wYZNjaM5dDX0C/Cl8JQahGA2pozrmNDAEmwmpDd8qn8wkcQ7A5cN
         ihRViypdWu5ffTiJqWjTNCjbVEk1gaR4WvmNpTsqJh9LCWINTaiI1qO4bgfL8Y5LWEOK
         +X3P4MEhb9B/Y1CMf2dHAaY+ITnCSnzJFXPSwEIyrFNliaGK7oYoaC6QmZbDTis0u0Ef
         A2zg==
X-Gm-Message-State: ACrzQf1N/liIBRE0ZS7Wgvkd8cLpCBlwU83rh/27OQLoSA+a2ixIAaOH
	8vkf3HDBqAv0H7gdvn98zXmgxeiSDJkL9yRD
X-Google-Smtp-Source: AMsMyM6/PK0igQkBoH/zOMEXN7VmmMY0w5DP8BEzbD1Czpw2GhUdMXYbRk2uX90deivc5ecdD0/wpQ==
X-Received: by 2002:a17:90b:2705:b0:20a:b25d:5d93 with SMTP id px5-20020a17090b270500b0020ab25d5d93mr48099306pjb.218.1667471621273;
        Thu, 03 Nov 2022 03:33:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b00186f81bb3f0sm309653plx.122.2022.11.03.03.33.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:33:40 -0700 (PDT)
Message-ID: <63639904.170a0220.b658c.067e@mx.google.com>
Date: Thu, 03 Nov 2022 03:33:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 9 runs,
 1 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 10:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9907

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 9 runs, 1 regressions=
 (v5.10.147-cip18-12-gcb2b164780be)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-12-gcb2b164780be/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
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


  Details:     https://kernelci.org/test/plan/id/636387f620d15ad8a9e7db62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/kself=
test-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/kself=
test-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/636387f6=
20d15ad8a9e7db63
        failing since 58 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d=
, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

