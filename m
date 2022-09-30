Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283AC433FE
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 11:49:58 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.4618.1664538593886342357
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:49:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ldQbb7qJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id v1so3761083plo.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=21limTaDM+yzx/EE508hqT8aeEJsguHjMhoUuD/BpNE=;
        b=ldQbb7qJzGxEkPKkVFZsKOGznGHuyohlbaJpDYn5Z3lbNd5pI08JllgRjar3iEs9ai
         k4WXpaXuGglCRKp+erIti7hIV7zMmSLKjIQoTLglpaaDPYibD4vm7/zF6vDNIctF/SRa
         ihouLvJbZ6IrnwJGnBKCtNexq8A4YH3GEqi7qg1kicgez+JYRepGvRFHci1AMMcvizlq
         hDTGNy3DT9blG3gXoLsvwrmflOByv8YKPxsLo4A66VJCMtJ1RWhqHgAg8FzOqISafgKj
         iiGv46Z7o8oQM9e8CoCcyX8wqvyUlgn/eerhTx17pIcXcaesvA+SyzfAhLMDbCSW3lTm
         h+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=21limTaDM+yzx/EE508hqT8aeEJsguHjMhoUuD/BpNE=;
        b=Ldldo3P9bUkBRPCv2AYuTF3iG5ogLKQ3HB+uX1sNWKJRUwGGc9M66tWIahUkVjq8mZ
         T3JS1TuSBCOi4eVGhNX4tIK3q+q7groagW0dt/0Tsgmer2Y7VV/wUFq2dgaoEYOfnsJ4
         LUuL3uJSIveUF9CC18c1aBOvHOWFQFPqNZsN+7+7KYKb5AigX4rTPqjiLlHoDRixGAhc
         g4T4F3qKgGq+rNTMcUZImaztcC2JrKz2pIunW4zPb00gpNShkcnavuX3XJ7NqUBV/zI8
         kx4T9J3r+2cEvJYNexjRrbTQKME96tBLGSos8W2q0Sicy0R2VSz+6iAumx7Iowc+U2lP
         98Xg==
X-Gm-Message-State: ACrzQf19eeils/KJXqNLEfgyIP27slbC16o9LJ+9MQ/gS13u42gCN0dr
	u4COuxJfRLrAZhYNqGh8LX4vTxGITz0G/NB/nfI=
X-Google-Smtp-Source: 
 AMsMyM5VEsgc6AFnvXXkNM5OcpiPEAuudTahg8PYE9swURmrxaWkU02Uc+/5njkCECLLNbW0g1RwiQ==
X-Received: by 2002:a17:903:189:b0:178:3df7:f32e with SMTP id
 z9-20020a170903018900b001783df7f32emr8451928plg.47.1664538592677;
        Fri, 30 Sep 2022 04:49:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e12-20020a170902784c00b0017a0f40fa19sm1664262pln.191.2022.09.30.04.49.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:49:52 -0700 (PDT)
Message-ID: <6336d7e0.170a0220.821dc.3139@mx.google.com>
Date: Fri, 30 Sep 2022 04:49:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-422-g411cd76b5afe8
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 10 runs,
 1 regressions (v5.10.145-cip17-422-g411cd76b5afe8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 11:49:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9583

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 10 runs, 1 regression=
s (v5.10.145-cip17-422-g411cd76b5afe8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-422-g411cd76b5afe8/plan/kselftest-filesyste=
ms/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-422-g411cd76b5afe8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6336c954a9f08ba344ec4ee9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6336c954=
a9f08ba344ec4eea
        failing since 24 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d=
, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

