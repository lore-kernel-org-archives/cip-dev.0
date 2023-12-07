Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B75C46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:27:56 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.83530.1701955672125996157
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:27:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=GPSXUPlh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ce4d4c5ea2so507832b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701955671; x=1702560471; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aXKVaOX3idmP8mdxi7bSER62VjOrfN38Do3NMIpwPiY=;
        b=GPSXUPlhm+P+OMhF0C8R77Zox/mth8/OCPTpt3ACxvgiKo6Sgrnv8aJycSp8MXtpy1
         2mqW8f6v9qjH6d39MXmJFmYM3Z00T9FaVaj4Yypl045YFthxXLniIQiu1QkssO+SvLFU
         48PXC0gNtyVhzv4cpya7SlvK2eZPu+5uKUUPdDBiZHiE2ceqIUWwdbB94WiqSMGEyACl
         lOY9+ItbS/j7L5uOz2lGhdRyAwZJj/gelg8FcWAkWcVnPJ80yeS5Nm2oNwPb9Qd86lvA
         M6Xnwg8vjYJBJbDFrpa8TE29rdwqAdhTpYIDUEMvjGOMlBixK/GUM1038pDF48nqoceE
         IEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955671; x=1702560471;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXKVaOX3idmP8mdxi7bSER62VjOrfN38Do3NMIpwPiY=;
        b=PFeS7/QmBYGrRtPGFOG30GyQHkGveMvqWw0KHP+pI2t1Lg3PYnefJXMjuj5WGggqQW
         320NN1zarDXObRrfWpUOW7MUGL/yIu8ByIq5Nh8Jbp2RWvuhc1eyIgadVFTk2SJEzsrJ
         fFEkrZCMxNUHczcouCiwd4FYgRc3XRNab7idO9ZGY7/0VnAGZerD6p8iWdorczXH4nlW
         CTAh/R+1TafPydSsHtk1tG16mSTOEYzb497XUfh/LnkN8uvrZr/d9d083v4JcaVwSuwt
         jqeOtzF9sOiXxSNsiS0/mKuc0fA1qRuNEoZP+6yv8R+SylDqeMiDOZPsAIezKzEg6azW
         9AoA==
X-Gm-Message-State: AOJu0YwysIVObE+7xEGY/TcfaKiHhYKG8fhRA6n3YRptEIXktcUOkScc
	FPPMmjppVv34uRpBYw2RGSQ1tAgHogpAtCCfYU8icA==
X-Google-Smtp-Source: AGHT+IGulXhPx3DvuyaMdxSKnuP30QcL0L9HZsnmq1nijOERbPkhvZpVFxmA3exb/98eIlQEyIKe/w==
X-Received: by 2002:a05:6a00:1743:b0:6ce:6c6d:1622 with SMTP id j3-20020a056a00174300b006ce6c6d1622mr2636301pfc.62.1701955670930;
        Thu, 07 Dec 2023 05:27:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z6-20020a62d106000000b006ce66866226sm1318531pfg.84.2023.12.07.05.27.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:27:50 -0800 (PST)
Message-ID: <6571c856.620a0220.23194.3259@mx.google.com>
Date: Thu, 07 Dec 2023 05:27:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-g38e219eb6aa85
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs,
 1 regressions (v5.10.201-cip41-28-g38e219eb6aa85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:27:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13836

cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs, 1 regressions (v5.10.201-c=
ip41-28-g38e219eb6aa85)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-28-g38e219eb6aa85/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-28-g38e219eb6aa85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38e219eb6aa85cc3be6dec326b24dcf8cf438d01

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6571b546e13794c4fde134a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/riscv/defconfig/gcc-10/lab-collabora/ltp=
-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/riscv/defconfig/gcc-10/lab-collabora/ltp=
-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6571b546e13794c4fde134=
a1
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =20

