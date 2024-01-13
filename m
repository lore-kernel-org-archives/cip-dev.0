Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E44C4707B
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 07:27:29 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.14939.1705130848651554598
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 23:27:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=LP/Md+o3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so1847614a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 23:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705130847; x=1705735647; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jNAXL5pRXrxIqrHL3z5WHaYHc6iPlx7gyRaE8UkCknA=;
        b=LP/Md+o3ZZnSPfms7kpOmYNkcT2fglEAz0/djPJwT7WC8SMFqoZU0Vp9w0IqfhG7Ib
         HvpoNjSlzmJYE4UiEQCZdXXIb4qhfDbmKipsLJghtVdGg4cIOWbCnihCVlQKkmScejrW
         3UvBm8AoEzv5RzXOJGnLBmuDkesR0WAXNrWlhAp85SEWVKnFssxiUcr9n/A5sD8BESgS
         /CUlrjKnuto2ziOv0w8YB78MJYroEL+QK8IN7x1gqCXsVJAzdKAlVFS/P5/oxRD3eq7p
         eV1L+IDCd33CkZk3odgG3cgnMrFdG8K0L+TavwXANOf/e5efEqUFSwxy5GjolM0JBuRH
         17LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130847; x=1705735647;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNAXL5pRXrxIqrHL3z5WHaYHc6iPlx7gyRaE8UkCknA=;
        b=gGr3iuNvJOkizaiT7dnysV9KGbogfkZmdWTqHd+J9+47InV0UVJi4sEqbs5JtF6EUo
         qnLaQ++IgA0gofKdxVEUalVpMXOR7goHmtiGAkh+fYgu6qsBcy1tmQYw5L+cjM0B2kO8
         OpakpTVKK1jAyUtuvKVn/LsE7V/Se5nBLxEoN4atUL7D4v612fXdURet7sxP78bGrIG9
         sfpuCp8t2H0Y0J3yIG3DR2WNmN4jqguJ61YPn9/3WwhfJY1VrCAvgTU+Uw3B9zdzGe4f
         zsKN2oVjd1cooVDqpOJYweSGeLKxz5GnQKs0WTTUp8CEAH3LEUDEzA20iYCxgDUpCGS7
         Lipw==
X-Gm-Message-State: AOJu0YxMAkVDnVciUgl7PU6HZ/R3NfwAizJKgs6CiSCWFazfbh0zcnLv
	v0jKD5v7dzMrbQ3n0zCJTua7y6PB69rdtFf5Ov3tvAvyq2Y=
X-Google-Smtp-Source: AGHT+IFD/I70JGBg4lcBfHXtaw3cxda0ttjIGH6KK0Hj2x0sIZHiTE475DY+pYhH1v2gxpf8nWaf9w==
X-Received: by 2002:a17:90a:c68d:b0:28d:9b25:8ff4 with SMTP id n13-20020a17090ac68d00b0028d9b258ff4mr5401215pjt.26.1705130847350;
        Fri, 12 Jan 2024 23:27:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mm4-20020a1709030a0400b001d4921cbe6fsm4309783plb.8.2024.01.12.23.27.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Message-ID: <65a23b5d.170a0220.f050.eea2@mx.google.com>
Date: Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 11 runs,
 3 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 07:27:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14365

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 11 runs, 3 re=
gressions (v5.10.205-905-gb40421b142370)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/kselftest-sec=
comp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65a23041fab6bc883f52a3f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65a23041fab6=
bc883f52a3f4
        failing since 45 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22b55a3ffce66a852a456

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65a22b55a3ff=
ce66a852a457
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22ff2a786a5e9cb52a46e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65a22ff2a786=
a5e9cb52a46f
        new failure (last pass: v5.10.205-897-gcc9858ae2881) =

 =20

