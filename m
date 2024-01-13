Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EAFC4707B
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 07:27:39 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web11.14940.1705130850141023221
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 23:27:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=F153SGV7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.42, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-20503dc09adso4529287fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 23:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705130849; x=1705735649; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b/NFVOSwnk1XkUAy9OGJpdNa6ZEFE4QNaV26PEGIvW4=;
        b=F153SGV7X3pnVSGtffjuPbLAVH0juCeg+57pNPiWfCeHHEDZM2e/VRquI9d3js0uj3
         Dk5cM98L6pZQ9aO+ErHPzrTRYBxG+qh3eyp/SYwtFjt6lUDKsKD5PuNe5fJfzEHDizbn
         HRnld0uHaYLWnMXEZURvuWoggtlaR3wyixzFQ1zvCP8Pq4eKp9I3CqNrQt8b/HajAyzB
         +z3kkklIujN+W5Xx8PNLgFVX0BCWPG2UNLF6wKxZBmSvGC9uvLLBX9e+4kGJ+URsIlQr
         zuUxT4dIy55Hz9fmkxiKjMEGnVNkcf2j9ocB0+E0HxomXe4akATa7ThlMqoYnjl13BAa
         Vxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130849; x=1705735649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/NFVOSwnk1XkUAy9OGJpdNa6ZEFE4QNaV26PEGIvW4=;
        b=oWNtH3IJ0Vd9gdOOar/M10/dJCp0pA7AJF6lNNBa7efPYqCrpIwIiJJ10QkmAUjKq2
         /MDmtfEvv/kCUWfNh5ARDrs932PSuzs/JsC29Y5O3yiceyI7Qd3iNUB62Z+OKnpdRTjj
         1DGHsEi4BqczYj/tUHJbGGwNSlXfPqNa8vWgCHNZFxuDYuUOxBeL3N6EAGeIzbBHhSC0
         DVFgLnaab7iuW96ThHh0UaZoLb0onVhMCLmJJ7YUnKkfHQUSbGFhufWBD3GNFMbKP51W
         pdMYKWt5Glr7KfuuQvwLfhl+7DeziL+MaM1zNs6r6VkAanOUEHqXLHPELX1upzD4KcTp
         M22A==
X-Gm-Message-State: AOJu0YxK07mdkTLcPgT2ctSSgM/pqvdzotmaSsPrJMR0Q8HlOWRWilaO
	yMzwruqpaClC9YJ5g25zTgDp+xcR4v5wpah1DEv4bh+3dZI=
X-Google-Smtp-Source: AGHT+IEQddodptcT8OD03Bic6c1thnNO2VvfvkgfVWZXilLHU68dSl/QCQFkUT7VVSvhQH4B4KcZ0A==
X-Received: by 2002:a05:6871:d281:b0:206:9ffd:b8d8 with SMTP id pl1-20020a056871d28100b002069ffdb8d8mr2986020oac.56.1705130848879;
        Fri, 12 Jan 2024 23:27:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id so8-20020a17090b1f8800b0028e01fcf1f2sm3570320pjb.40.2024.01.12.23.27.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Message-ID: <65a23b5d.170a0220.75be3.d154@mx.google.com>
Date: Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 18 runs,
 4 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 07:27:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14366

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 18 runs, 4 regressions =
(v5.10.205-905-gb40421b142370)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979

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


  Details:     https://kernelci.org/test/plan/id/65a22904ff641cd9c052a42f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65a22904ff641cd9c052a4=
30
        new failure (last pass: v5.10.205-897-gcc9858ae2881) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22d965cd57b567252a443

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-brooni=
e/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-brooni=
e/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65a22d965cd57b567252a4=
44
        new failure (last pass: v5.10.205-897-gcc9858ae2881) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a228adb6d727fbfd52a40b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65a228adb6d727fbfd52a4=
0c
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22d855cd57b567252a3fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/lt=
p-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/lt=
p-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65a22d855cd57b567252a3=
fb
        failing since 45 days (last pass: v5.10.200-cip40-188-g33d0b44cd71d=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =20

