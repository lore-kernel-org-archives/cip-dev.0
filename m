Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BFC10DC3
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.5758.1702291971739461502
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=CHTzT0e9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ce72730548so3671162b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291971; x=1702896771; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fhJi4UnpLc6SLK8mIxABcAZF7j51+h5F6crujG2UTTM=;
        b=CHTzT0e98CEAvnxBRENZlsnSN6rQ75F50eYmlI2Ga12PsvoPtglwKatt8djaBpcPjm
         2VXmIoKl+diaPrYxzw5p644AT/uBYEr2f8LvRaIktF21gGQOJLY0dFkWDYdiFMYuy/W6
         EkdBTtlbgBLHeYSFLCUqk4m3i1iAmGGzQ8ejfSCtELa5A29RHPlqzFXG5Um8pKhmQb2N
         xsjXDzPISOaCAtdWA3DgUdwlRwaayb0Mg/SkArLA0I8iIdo4hUlgPnmjEiy+e3HoM72+
         DRuwILoqISywqqpadJdL+jHlDxvuQ72fWYm2Dzp8083VZVslfX5I1wsxs8kbfX63bUmc
         1Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291971; x=1702896771;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhJi4UnpLc6SLK8mIxABcAZF7j51+h5F6crujG2UTTM=;
        b=wTx6Fiwe7QKLNiUzxF5z6NH0dubvIVWjdeymcXpBuYAE1pyYamSVIgzZbrYBYkrkoI
         GAuwwoBU+enoA60+626qbOoEpXVN4ntvfEinD698txgGPqbqG9EmJOzEFFWOntnXkdgQ
         pqftKkNPAVDBbsR+mkGcY71lNGQbXXNBa5I7p7oHcvsrEKPP/0Eb+I53mIsQHElTLAlE
         MDfl5Z1kdg0RSOaMLNpciWD0sci1VNUl67Fzlc1HygNJQ9rcjhlKzgrg9+y3WERjJ1Ed
         njge8G9Gs+nDbbdSbZ1T41DHVxLMhhOLxwMlebIUAbkRNowmaOvBg33o4+uyWOEYRFtW
         e7Tw==
X-Gm-Message-State: AOJu0Yx2dHLfO/5EJNmhcUsZnNqJmX+uvRZEOOAxEESqZLk/gGRv0Du3
	EUTnS20HxNNbQeC+sW/5RBXon3nT1qXpG6kah2cYSQ==
X-Google-Smtp-Source: AGHT+IHFCQybmMl0VjPfeZI+vgTUfjiqCeKfDazkb9kh87T9FwSzJCO2QUta7/TW5g7UYhReJvFiLQ==
X-Received: by 2002:a05:6a00:2e10:b0:6d0:9913:3363 with SMTP id fc16-20020a056a002e1000b006d099133363mr576521pfb.46.1702291970805;
        Mon, 11 Dec 2023 02:52:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006cee23e7677sm5334900pfn.210.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Message-ID: <6576e9fd.a70a0220.e5774.d7ce@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip kselftest-futex: 8 runs,
 2 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14016

cip/linux-5.10.y-cip kselftest-futex: 8 runs, 2 regressions (v5.10.201-cip4=
1-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6576de1c0f25a5cd43e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6576de1c0f25a5=
cd43e1347b
        new failure (last pass: v5.10.201-cip41-46-g596f4c151d286) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6576dbc7a8260c9962e134cb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6576dbc7a8260c=
9962e134cc
        failing since 16 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd) =

 =20

