Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0482C6FD1C
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 08:38:31 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.62993.1678610302361711133
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Mar 2023 00:38:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bmBoK7py;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so8896373pjg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Mar 2023 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678610301;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A/VT8JIAHJLBaqfdBcjb1oMtqZtK+TzLBLSyp80zSGU=;
        b=bmBoK7pyxnwkO/4dKS0KpHAHL5eZ0Cu2YSTOwfH126tCmwecVMRgnqNyfdpg9Y/7+E
         OjPqrpoy578RGjBzyfoQPAaRNtHtqSPG6Msbq3avpSfGt18Es+UAUQUkCoywf4i9u67I
         81VfabwBlr9YKOOlIQ+aXs0uM0UszA8OwjD+tm43XsGjHmhiWtqhYJyXwYUzKG6WromQ
         F1KM6Vvq0UqokbBz1ny+j5Lsp+n2OWoUxseMGCKpdfeuFlUeqsJbvwPEKP/65/MOD1B1
         JKhDBUOJMjcaomgjLsiZWTOjV+3octDRmt22qcuy8ta6XllEL1X4wEBGurGI/ow+07U4
         1l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678610301;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/VT8JIAHJLBaqfdBcjb1oMtqZtK+TzLBLSyp80zSGU=;
        b=DRl4e4wl7P24c/MMy0JKHcvq81A+yZd7FYp3tgAsa4RUYhKrnlz+PKg5LNpysBlyao
         emcXI4q3ge+lk74BpQNbTZxj+TflZ1jUr91o/cewCcDhCsTFtS0jaPckOJzyenz6nceB
         csIR5RpTSkyVO5Hi23itrGrjTIBl4urwpHVFOtYKL69bmRVX+rGvWPE76GaRIpDyjnp6
         BIiA38gcMTf1H8TRUTBrXzTCNxAXGJQL7JC7wLdfSnxWRaGowOL7emp+cvVsXTzJ7vC0
         qQTGWQ53jkAX1EkFrU6ud70/ard2+YPPUvjcOJDlx+pN0uuLUnshrWCHTQjvD3gmLsh0
         WcBA==
X-Gm-Message-State: AO0yUKVNMWXlQp36vzKlP+zZLbLhzkU9Yr549Yf+Kn1YkgSK/qopQPaM
	Mpb+MGO3s2yRREXvbtmjkGqsovyIxw8KB54rRJs=
X-Google-Smtp-Source: AK7set8BMfyJbicI4QCnw9v4920fDV/ZMg/TaV/vx8eI4zAvJ2TaiLKi9xSnmJQlk/iRQOY64tu0pA==
X-Received: by 2002:a05:6a20:1609:b0:cc:d44a:bec2 with SMTP id l9-20020a056a20160900b000ccd44abec2mr36450797pzj.1.1678610301544;
        Sun, 12 Mar 2023 00:38:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b8-20020a631b08000000b004fbe302b3f6sm2522099pgb.74.2023.03.12.00.38.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 00:38:21 -0800 (PST)
Message-ID: <640d8f7d.630a0220.dbb1f.4242@mx.google.com>
Date: Sun, 12 Mar 2023 00:38:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-638-g0d599cd2b6695
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 68 runs,
 3 regressions (v5.10.168-cip27-638-g0d599cd2b6695)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 08:38:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10987

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 68 runs, 3 regress=
ions (v5.10.168-cip27-638-g0d599cd2b6695)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                  | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-638-g0d599cd2b6695/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-638-g0d599cd2b6695
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0d599cd2b6695e03b8e4b1bdf0c2663d16568070 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/640d8892b3563efea58c8642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-c=
c.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-c=
c.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640d8892b3563efea=
58c8643
        new failure (last pass: v5.10.168-cip27-109-g23841ec76bec) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/640d89aefb0f83d3c78c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640d89aefb0f83d3c=
78c8630
        new failure (last pass: v5.10.168-cip27-109-g23841ec76bec) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/640d8a0fdc8bf7820a8c8656

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640d8a0fdc8bf7820=
a8c8657
        new failure (last pass: v5.10.168-cip27-109-g23841ec76bec) =

 =20

