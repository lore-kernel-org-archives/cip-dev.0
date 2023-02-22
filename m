Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D25C61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 19:33:58 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.2650.1677094434613748258
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Feb 2023 11:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=MH9I+ifu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id z10so6937780ple.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Feb 2023 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a4hFutTry5p4+OaeylZnan8pUacGmR9VqscujzOySjI=;
        b=MH9I+ifuvQ8MJHhryigzOxXcpiDgwHExqOn91Bvxa5WkBC4bCRgYlRYAvlQRZqFCW5
         ADtnVQg0OZoLlwCaQzkSNGPeZBsTzNvyj05EDW3mfQaKPKpJIy2hat9NEpn2hzY1TtKl
         YB7eh/o16KODXdYMElcWf3j5/LBZXKloljydk15Kq0ewarfElDwbpKz+W/H/OpGHhg/u
         Dv8jAojiYAvj8m7Ez0+UOOCTCx1delOiKlfVmXAXcQADjz02VUzb9ze2h+3moY0UNuKm
         +uXf4CPnW8EAOqb7/4mv8nIy79nHIb/GMK+LLUksYqfjS9uX/jNe+8Wn28A0BE3MxgmA
         r28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4hFutTry5p4+OaeylZnan8pUacGmR9VqscujzOySjI=;
        b=0GXv1zgGMjsHLnTdLv2WFyZ18EJILOk4HoJKOrQ8Bxa8EP81ZwLYRXJbAVdz5Vk/Sg
         BG/XbNw+rOcluwHs7/RSPbkwADYQGjB0ZfEO+DY+KeaSJ3tBwY1aql5tIfxyPJtTW5kn
         wmK911NtGe0G4JZbrZcchhXfdqga+vek7EnCpiWrUid6Jisu9HT7VsTH/BwwvGwVSXOF
         k0rhiAzklA2JtcMfVYcNWux1Hhw3FhuqNpNnwqOR/zHpZdKabISkNf0ifMreood15qBC
         Z/RtwadEHmXUjIrC8Mb6gPOSyxIcnFnmxcx5kfzQhvBUybImJo44jtFiLs/vK9CfKJ6f
         9YWw==
X-Gm-Message-State: AO0yUKUcyOZDddf5vEPTjhQckUfdypADU5Y7lZZo4jd4fN/ps3vI5zPj
	TcPlvOeBfOXD2m28Mdo55Tr0tajn7Cf9+HFPnXJ5cg==
X-Google-Smtp-Source: AK7set/xN+mPLKoLdNvYNEX7lB80M/I2ZzJ/hiSC7cahVXfgp6FRtF7r2yoS1JYuhqqxw8CBDp9Qdg==
X-Received: by 2002:a05:6a20:690b:b0:cb:cd69:48d2 with SMTP id q11-20020a056a20690b00b000cbcd6948d2mr3887780pzj.30.1677094433625;
        Wed, 22 Feb 2023 11:33:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iy22-20020a170903131600b00189b2b8dbedsm12224141plb.228.2023.02.22.11.33.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:33:53 -0800 (PST)
Message-ID: <63f66e21.170a0220.8db05.70ea@mx.google.com>
Date: Wed, 22 Feb 2023 11:33:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-192-ga2cd4acb16b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 68 runs,
 1 regressions (v5.10.167-cip26-192-ga2cd4acb16b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 19:33:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10786

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 68 runs, 1 regress=
ions (v5.10.167-cip26-192-ga2cd4acb16b2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.167-cip26-192-ga2cd4acb16b2/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.167-cip26-192-ga2cd4acb16b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a2cd4acb16b241aa1a262f5213f9c4e8ddfd0714 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63f664902c8008e2a58c866e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f664902c8008e2a=
58c866f
        new failure (last pass: v5.10.167-cip26-2-g1e87e7748b91) =

 =20

