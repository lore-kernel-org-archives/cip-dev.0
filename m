Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25956C61DA7
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:34:52 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.35335.1700685285758047845
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:34:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qa+Z7q3y;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cf56e28465so1370445ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700685284; x=1701290084; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=94AlNi7tElv5gt3UCIApd0zOz1G77gWtzDe90XqisKI=;
        b=qa+Z7q3ydAf6FoLibzSFw4eGJ+QupJ1FAoCbuJ4UWp2ZmtnFQU8sy0zwrOtWVUf5DB
         Q7vjkGwA2XrdYu6aa/65g2vUEZlTk+NJkQQMTkGdQGufHzPre8W/Wxb6HLuPeaSieOgC
         ulpwkNFVOvMuNoLix0Ybc8wqoL/oHI9Qg6Cc2vIXu653ABdJZVGtHS2WoP+Q4BWzee8i
         3Ci2dXU+KKvb3bKSHIz17gQGxJCgLQ5+a1nJP/ng3bY+8klC9oiqmI0oqhnxTpjHgLuq
         ojtjd3RZ1u6EjVea23KMpZjlyjcXQ+D4j1BabaHu1ml/asAO1etvNhV++T9qOgmGrC1h
         yqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685284; x=1701290084;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94AlNi7tElv5gt3UCIApd0zOz1G77gWtzDe90XqisKI=;
        b=PM/eztZrgTGLbuSm3WXYMbhR81KoTdJQ4Ife2nDMVFNWdZhvNnYmgcQgLNSCSglMJg
         cdEhAg6qzkP8quGkss3NttUydBAll6wpwUzNSYDEEMEFyqESTM8YuLncWe013pYaiTvd
         MkeBLT1NICvDq7UwNljATIJl9aOTv+OZtPQa+/NqoTuwYhE0M1lXRk1ke5lUyuu5poZB
         mhzIvpbiLD7RZ3yXnbqjptdWmWZIseunNburdUeSIJ0orG9CdK2EEAmZC9RT3Gi72YmC
         WCxIKz19unTqlHLApjwXUhLuOLfccRA/QisGYumEZam7/PR3oytE6hlHGkiZm9YN5b8T
         dfzQ==
X-Gm-Message-State: AOJu0YzLYDMLpy3ACjfpfZ3diGfEZWP1jLAiQUtoa3cfGUCNMn4UhNUf
	IqUdheu6Bdd1gO3Ud56w8k/z9ub787uts8m+rbc=
X-Google-Smtp-Source: AGHT+IHd1vbO7VXEEE1LohM1tiOsS6dq0u1kT4RODYUPKalZNdNXTiVMdspvsGTAIqyMShPK1S/gHQ==
X-Received: by 2002:a17:903:2444:b0:1ce:1892:2fa6 with SMTP id l4-20020a170903244400b001ce18922fa6mr4097985pls.0.1700685284621;
        Wed, 22 Nov 2023 12:34:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001bb0eebd90asm83603plx.245.2023.11.22.12.34.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Message-ID: <655e65e2.170a0220.f4b5f.06e2@mx.google.com>
Date: Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs,
 2 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13648

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs, 2 reg=
ressions (v5.10.200-cip40-188-g33d0b44cd71d)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655e5836f6190255e47e4b01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/655e5836f619=
0255e47e4b02
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655e51fa022933315d7e4b27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/655e51fa0229=
33315d7e4b28
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

