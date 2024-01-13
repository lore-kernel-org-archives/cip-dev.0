Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA1BC47DA2
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 07:27:29 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.15246.1705130846712656849
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 23:27:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=QXh7A1jx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so5984232b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 23:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705130845; x=1705735645; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7baybP21lu6M9ZtjxyQX6oIe6iCPQU9dViVAIUVRB9Y=;
        b=QXh7A1jxsdZxu+nKOIzXFTYCZTfaPI+XuCMBDeRwmqXwyfpN6uAxkoYBxpnwL13TXD
         93dFUvyygkdeJhRupyHqr69MieRPFYV6IwYSfGuI5QiwshGhWeBdjErsMai2lwX4wgQ7
         1cjgY2OYPQX/qJZrwO5SezkvI/Nw3c6htT19S3GRPPJiIYyb840pNjpFNbIvHovIrJzr
         bT93ZUGeE0nxSKMI84AzBsZnSbVHl3mz9Olik9kmSba08t+0s0r8Trj7ZNUZlHFUiG+p
         iihJP8t+Zg8tNc0mL3mvsLIdcq4+kDd7cZtwhbYBrJEw/vXidZcbKnyfSuWnKBosCWOb
         145A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130845; x=1705735645;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7baybP21lu6M9ZtjxyQX6oIe6iCPQU9dViVAIUVRB9Y=;
        b=cTkb977urIAHyjLSupnQDpYh+6xXGZ5PNtAJm9WnsV1YAXYK4Vnb1pkixiLprCqvIy
         WYgW86v1zczf9Y8Gl5KmA9//RRTfmDbUp9fX+MfJ19UMqgRsvHPV0pzWoO8zfmykYBws
         q/1R9b2ienpZmnN9N4b3+xT4oNfEBIq5JZJuiIo8blHz8BVzoJ9kdExhqT9BTJvZxuDy
         F3cZW+E/immaAgp/n8qHpIYyrqUPhP4xZHJ5WuncMoJ2J1p+BbRepRkRMqIzwHz+7DNo
         IBP2U4zvw4grIC3fdsAwGbX8V3rYNFBLRymBJvxfzp61QMiP6vAO47kos10TYv5qiCbp
         LWgg==
X-Gm-Message-State: AOJu0YzCa3wHFaaj4Mr7RduF68B0rrBCRZedss+yNy4uM/zFprp64gOB
	UbxpYN0J19Fw8HPEnQsbOUXJm4Dbq85FQwyGgTkns7nIFsY=
X-Google-Smtp-Source: AGHT+IE4DmD77mHMSJRZHOl8GM5d+XLtd04sGlii1Dc8gulF+CBDByBIq59aRcxCB/zo/VTKuHSWDQ==
X-Received: by 2002:a05:6a20:2594:b0:19a:25c6:1a5a with SMTP id k20-20020a056a20259400b0019a25c61a5amr2326661pzd.92.1705130845444;
        Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a192-20020a6390c9000000b005ce170c797bsm4263234pge.87.2024.01.12.23.27.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:27:24 -0800 (PST)
Message-ID: <65a23b5c.630a0220.3fe98.e903@mx.google.com>
Date: Fri, 12 Jan 2024 23:27:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 13 runs,
 2 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 07:27:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14363

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 13 runs, 2 regres=
sions (v5.10.205-905-gb40421b142370)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a229deec1c5c8e3252a44a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65a229deec1c5c8e=
3252a44b
        failing since 23 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed=
, first fail: v5.10.201-cip41-540-g3640150b3b169) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22fb5544d9f61c052a41b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65a22fb5544d9f61=
c052a41c
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

