Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189CC7EE32
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 20:57:56 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.193.1677877073483290281
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 03 Mar 2023 12:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Q+9apJoR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id z2so4016053plf.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 03 Mar 2023 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1677877073;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DiSrcOelVS5TiMGnh/LGjKZ6UHVafPjde7pQIDihb3A=;
        b=Q+9apJoRMB+5t9eaeLQvZqFnJBFfZmYCDTkx3CacxzUq/u4MnF2LKy6VtSeaj6c8+e
         /Uol11nGhnzZJu/shCJVft0TX7Usen7CUKfbWYkuKGVQiEJSAAEX7LKxRH57qxw/TwM+
         2BUeVu65altW41vjgkvVYtiRzjMYns6xENI7EEyNn5SEHpB5Nbx8I4Ly9v/z001Oaqg7
         x13BDHWwpR8RdD4vCqZX5afKyKffWtby/WpFSQ98o62CDekhXTRsSopjOr0e4BRf90+o
         YudGthWQ7wTsk+Jm2H5QDu83/cl4UsraW5tVF16PAlCg8ppQftReYnU1g5y3RJcpqv1z
         KgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677877073;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiSrcOelVS5TiMGnh/LGjKZ6UHVafPjde7pQIDihb3A=;
        b=iTVypZk2rrUlE95fpPvLQlwUP+vIw9p34JyayqeXwRbm+V/k+rRex1VSsP40AS2uqW
         bVi3ayoIhMlzshcpoLwsx9NNMonl99BQTNb7tlcRhjQzkF1/MeKr9qnTSzkO0l/5lGp4
         SkurDqUeBa2vASEJ5RSCrnEXF9exsSJttMj7E7v7Vp7xWaezRvg+dPzvvG2lb4IdCnmb
         HpEC034hb7oWTtaMIEy8vuVzHt/idkh6J/DOGtKNpJ/0UE7AJmiFizOp4NcY0rkkAyT2
         W4nNwPdTLUNT7Xb3kL0WZEsc5DVppv3PqvBug3+GZ5EZy+DhECm4IxHwcFARevTkwq/d
         BOQA==
X-Gm-Message-State: AO0yUKUhdbq8dae9HJpZIin29DyTSVpMJ4r28QyKkMVLkvGV5eC6MPqV
	pFytqCQLzYbWB4hkj3OIVjD/4Mh/lHkPgtQF0byopWD/
X-Google-Smtp-Source: AK7set+ZdS6USebfE5pgNTsqP+oZKt6rNfZMgjdfCN8KE24+38WOpthTl6ihio9XskqmOKSYYOXq4A==
X-Received: by 2002:a05:6a20:8353:b0:c2:f930:45e8 with SMTP id z19-20020a056a20835300b000c2f93045e8mr3034569pzc.46.1677877072728;
        Fri, 03 Mar 2023 12:57:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t8-20020aa79388000000b0058bb79beefcsm2026231pfe.123.2023.03.03.12.57.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:57:52 -0800 (PST)
Message-ID: <64025f50.a70a0220.1f06a.4671@mx.google.com>
Date: Fri, 03 Mar 2023 12:57:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-109-g23841ec76bec
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 10 runs,
 1 regressions (v5.10.168-cip27-109-g23841ec76bec)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 20:57:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10926

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 10 runs, 1 regressions =
(v5.10.168-cip27-109-g23841ec76bec)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-109-g23841ec76bec/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-109-g23841ec76bec
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      23841ec76bec7ddf00658918b23753dc2ca930ce

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a5d15b796362fd2731fa0290d48c096d370a040d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/640259fa8d8481b7ab8c868e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230224.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/640259fa8d8481b7ab8c86=
8f
        new failure (last pass: v5.10.168-cip27-86-g19cf8cd2dd993) =

 =20

