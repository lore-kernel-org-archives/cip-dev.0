Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA20FC636D3
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:16 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.133841.1700827631417131943
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=j30YWz/C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ce95f96edcso14203885ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827630; x=1701432430; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I0A/BkUIhl7TVpYaEr77igVSGuVmMpOId9agIhQ3vYQ=;
        b=j30YWz/ClVFd2RBKYaPBF/LSXufOdxIjRG+GMh9MEgmVYDeuM98UOJYb7YReFAJC1G
         l8gbWHTDJRYsSnRi/T/pwGQqSbREwpe3BgyaUwY63EviKZhWM3D312CPn/EPHWRpUAVl
         pZuh+pNYkVYL7q+TCRUxItFTSg3UWAP5FuOeabdjxYBCfiy+fiieVgIvh+p7gqU5PJ4Z
         9i7dqx406IqXE2Z2OqJIpX6jIcpcHtE08v2cxFbAM7IpCSk0NX6o45HTTU0e0Pj2uhlq
         mT6swcYFlRkpQwWLi0UfW8HYsC80ClF8IDz2eDKdZwOfZgnq9eUPHKYhAxZBi2U3cBXZ
         OoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827630; x=1701432430;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0A/BkUIhl7TVpYaEr77igVSGuVmMpOId9agIhQ3vYQ=;
        b=quvVrVTFDieXPj40XX0s04zNnO8wu+EN7P/fTd4Pi58C5r4tnxI5uSiIT43T7Je3tp
         FxA1ZFukP8xEzMEyAf9QviFDiq5U3DQJ5Y4XEXpnkGsSRxss4pD5mBiDaGAi+QrZ+ACM
         +KsWBxQ6gJXmlMHCPJIndGloG81MggMKe/IszPqt8if3hKg08tDOXZ0BBd3DkR9BER0d
         R3acmJ0d8txqeCXcxLe8G4Xli15FpnnSX3kDYIHX61KV5HRtBmt1zNbUu1Gey0daKOba
         t9fQ47xTXjrJXdHgMYuwIp59xQJzTq8XBpNkLjfZU314ZU9Hu0fSycfUouigT/yzC6lV
         awgw==
X-Gm-Message-State: AOJu0YyUaW49X5gPNS2EjAwb3ybhgqnGMU5LGuega7H2aUNv7zvGRM36
	qNevBPkvtbVs2kVov89jI3MJNsiCX6klyyg5bko=
X-Google-Smtp-Source: AGHT+IEuUGaQ65R6DOHDeR5don6AOSesEdyyBdatCGXSJV+h+utgnd+V1u3NzD//3oMIydKf1yoDTg==
X-Received: by 2002:a17:902:e845:b0:1cf:57b3:2665 with SMTP id t5-20020a170902e84500b001cf57b32665mr2987097plg.11.1700827630372;
        Fri, 24 Nov 2023 04:07:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b001cf5c9af489sm3106088plk.150.2023.11.24.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Message-ID: <656091ed.170a0220.cb980.7348@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 2 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13731

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 2 regressions (v5.10.201-cip41-=
11-ga539098fe70dd)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65608a9843c0cc5b127e4a80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-broonie/kself=
test-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-broonie/kself=
test-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65608a9843c0cc5b=
127e4a81
        new failure (last pass: v5.10.200-cip40) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/656083321ca3fef84e7e4af6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/656083321ca3fef8=
4e7e4af7
        failing since 50 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

