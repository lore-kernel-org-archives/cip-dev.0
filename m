Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7976AECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 13:22:31 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web09.25520.1661952148128395260
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=24mGhJo+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d12so14105649plr.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=TBdWPOfO1WBMks1NHST9WWB5prwgfluRBHA4QRUGGpI=;
        b=24mGhJo+Z8TuBN3kB02bR2JN1WvtrDYKVt45NoKLJjeUmnk972bOWIlzhMOhnJHNoA
         9caOf6mhKmiM0DeHB3gNSVJmkvSmsSS00xWCw+JIVVZ3uFBbaC/1Xlt1C+ns//qqhE2E
         msuQdcZLsGzEA5BGsO3/gs7gXL9Xb7uIzxQzBl6cPS5x9YtK0nybVAAfKO/9wqZVRFQ/
         FjtQrqOarUNb4rShMWLEHsL0bFnz0ckMeTzAqsHnYkYMDwFIa+93nn1VoAZONksFApKS
         hysrCz3nyGLaRDN21EuL2+DWNFiYNHZwQVTT+NPR3MRBYCGxb3THaojGJOENstVIQPKO
         vT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=TBdWPOfO1WBMks1NHST9WWB5prwgfluRBHA4QRUGGpI=;
        b=s7YgPXrSByrpXqEsZFIg6C/X2ufjI5Jr1P25pBpfK3YYUtO0LeHFHCkFqSoH/vnDMH
         QOvJJpz8v579C2TjZ9RzncoEJO/hQ+k9rkk7SNYWO0yqIV/0NESdqO3yQ+l5NkkeDS11
         C1umR1fUQfuaT8DMWiAd3wfGVnlEej/+C2AmKlTKyEbAMieImosB5MdDabHpw1qAyVRU
         dVnseYayJigY2yg55v5wT87c0h/KpBPgcgz14gzR422fhjMMofZjRh1oBBEAIZTk/TMa
         tXQgZjf/BHOHb5wCo2pn3jg1RoIy2BB1g+nK1WWfPTP7c+K5DBHycGpB2tpI2RO9KQgy
         NAGg==
X-Gm-Message-State: ACgBeo0o0oGkc02JeyKvGNtwrH+UYAWUCPodulbka4y50HRyQ82q7vwt
	ialzL87ZdBWSnspZeUEvBDm4TE3861y60bVOsJE=
X-Google-Smtp-Source: 
 AA6agR7MjM0e8llocoFFEWr6qi0OvzMin/ts/f3c3E3KsTk99yJO9zo+lVFVZLufU8iG51aa8ofJxA==
X-Received: by 2002:a17:903:244f:b0:175:34d6:97a8 with SMTP id
 l15-20020a170903244f00b0017534d697a8mr5976373pls.100.1661952147499;
        Wed, 31 Aug 2022 06:22:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z14-20020a1709027e8e00b001709e3c755fsm11470779pla.230.2022.08.31.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:22:26 -0700 (PDT)
Message-ID: <630f6092.170a0220.f2131.4acb@mx.google.com>
Date: Wed, 31 Aug 2022 06:22:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15
Subject: cip/linux-5.10.y-cip kselftest-lib: 11 runs,
 1 regressions (v5.10.138-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 13:22:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9342

cip/linux-5.10.y-cip kselftest-lib: 11 runs, 1 regressions (v5.10.138-cip15)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.138-cip15/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.138-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f2d94917db95e02bef61288aba5b06e0dfef3a73 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630f4bd2c1287ff78f355663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g1=
2b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g1=
2b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/630f4bd2c1287ff7=
8f355664
        failing since 8 days (last pass: v5.10.131-cip13-84-g3b53e4dbd9f41,=
 first fail: v5.10.136-cip14) =

 =20

