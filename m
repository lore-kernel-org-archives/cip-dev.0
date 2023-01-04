Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A8C4708E
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 12:52:03 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.11174.1672836720666131504
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 04:52:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cGPs90dT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id a30so7128920pfr.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TwSjDMtT+cfkNhbU2ydToU8MG8Rar9fxhhuNa15+GVc=;
        b=cGPs90dTcevm024HogApFP9jeYl4xGD/MD4IaO+Ts10JhuPoT2Ymye2c3XojXvBgMg
         x6YEwepbfmT+c+4XYm1kicWDidV4cy3l3Dku2DlLIk/L3QsuDiaIyD/7H/5l2tngBAFK
         dZjsmXz82Ivwxq1QsUFy6fhNlHXi/c5sozXkzZjglQ4/0db319cP+CV9fJkZHEEwXOlb
         lJVE+Tw9s1Y7ZXVkBPqqyxPBrdTyK+vVEeDmi02/Oqnd/bt6D7qZH+DCfMkQ+gj+A4+1
         t4NnygrxrilEL0O0tZZzA6xZvNauEk5fEjww7pNNOZae9TUBYiwsMedCy1cxxkR2gmil
         Dqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwSjDMtT+cfkNhbU2ydToU8MG8Rar9fxhhuNa15+GVc=;
        b=C6f3lBu1zm5bHk37blS2/0rqq1EP24NqaHEoaHwNOO8VpZlOqgCkS7TeOrt5kEQyQS
         cHTXNjwj9oJrXZ+XrL1DUUmSWRMdmJRrSjZ8nmbL95JIfBoUadNFATf278desKA8Z0qi
         gRnKUQ7WXYScj7F9FwgEgNukZcAjwV/7AYYzPcKCQI9IFZRjzO5alAcQzhxmfbb5qFnJ
         bJIc8tgb48H1NQ0hs6dIRVNG1ZFquj6pgJMAoIPxhbAGPn/whijhEEcx8DRhJPIoI1Gx
         2q3iMGpjakQPWyswU/She1zwm5fosQZiNxQAJpHWwEIkl4I+hA1bdOfClgGQzPobKTVA
         SGhQ==
X-Gm-Message-State: AFqh2kp0IhBP5o17ydqAv/xvJ1RtNjBADVrSBwsnQ0skIdCKwd0NMz8I
	h0lGxOscynZWW1K/ACxBWntvAywfezyFOoIudfk=
X-Google-Smtp-Source: AMrXdXu0VMSH7mCKE3WFAnN/g+YgqAhnfvVW+OrAX17t629atnU2dFFEMGU5vD//tGmmqCaf9AXmDQ==
X-Received: by 2002:a62:6d07:0:b0:581:b3f4:21f8 with SMTP id i7-20020a626d07000000b00581b3f421f8mr21428202pfc.31.1672836719735;
        Wed, 04 Jan 2023 04:51:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d3-20020a623603000000b005775c52dbc4sm6443100pfa.167.2023.01.04.04.51.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:51:59 -0800 (PST)
Message-ID: <63b5766f.620a0220.b60a1.91d2@mx.google.com>
Date: Wed, 04 Jan 2023 04:51:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 38 runs,
 2 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 12:52:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10300

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 38 runs, 2 regress=
ions (v5.10.161-cip23-65-gca8c192cb189)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63b5707656994fb5c24eee2f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221230.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63b5707656994fb5c=
24eee30
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63b57395591e6e50f74eeea2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-ci=
p/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-ci=
p/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221230.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63b57395591e6e50f=
74eeea3
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20

