Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F6C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 10:03:51 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.17631.1667469822005900736
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Nov 2022 03:03:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=l5EGjhVP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id p21so1433474plr.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Nov 2022 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dvj2grDEfZZ3KTaWQjSzKndF8symdqXMnOQDX9jHExs=;
        b=l5EGjhVPJQcZ5O4YG7N/XTtL6NXwY0i7bieKa7lyrpLA7iUQfoCWNV6YqalCWSCrpw
         1LuHPGedrY50WpIjThFEzUjDhn/H37Cm7U+M5T1CriwCEMh9ckv+uEIocwjU41ulRCr9
         WjZKaH2Yg0YH3DUI5B9uQl6HY1CImo6mLJIRU7TV+Fhc05WUqBULz2mfm1k3ftBini4x
         Hvpb4bf2fWxheIO1jpQgHneig4sNc3uphTATgzjaY7KRXOq1zsXHo3W83D+bl1qL1yiS
         FGyZkX0ryjl05+maenDE5qNVXMGXIHZPulC58Oa/poUb540BFAcEoO05689t9kq+ACw3
         seYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvj2grDEfZZ3KTaWQjSzKndF8symdqXMnOQDX9jHExs=;
        b=XY8F0hQLT6ImsvpURwkjs5qOM8qbzDZXS1w3zE8k3vKorLLT0ksONI1Q7siRK7ReGb
         as8GXfaUYgHNQi+ivvMtCG8UG/Jv78SrB/x76jECgqYDIwQWImR+772Yt4xBOv0K8PnE
         5m2vKeNuVmZuQoVWUMK5KGT2HWMYZvgv0JD8ipd2jEDnnI3abbSOByDDsMeOerqop2Na
         bH1wQdLzns6ygGncoaSBr23IqnDxKw6jsPFu/KJ9891oBB6YAxmNeSXJRmW/PyGCkjiU
         9ADExQOqyc5gYjMaDlqIRWexun5SOXmhxO0w5PYcuOFRCplq4kaqv/fYcY183UFwYRMF
         E5Sw==
X-Gm-Message-State: ACrzQf1OtLxGey76VYSIl6wo/VHW6fn0NDHkaNgNRlgE/6PsQZNW30VR
	Ij7aDzLXC2d1AkKEJRqIX07PTf5MGC64KEMd
X-Google-Smtp-Source: AMsMyM73E51/eagJfciCrrHLUgHKm+o5JIAVKBNeo98A+r+o+blJ2bYr11SMobtyYNALivS2fAjaRg==
X-Received: by 2002:a17:90a:4ece:b0:213:1130:ca9c with SMTP id v14-20020a17090a4ece00b002131130ca9cmr46025202pjl.17.1667469821132;
        Thu, 03 Nov 2022 03:03:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902f21300b0018725c2fc46sm129793plc.303.2022.11.03.03.03.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:03:40 -0700 (PDT)
Message-ID: <636391fc.170a0220.1e00e.02b9@mx.google.com>
Date: Thu, 03 Nov 2022 03:03:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs,
 2 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 10:03:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9906

cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs, 2 regressions (v5.10.=
147-cip18-12-gcb2b164780be)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | omap2plus_=
defconfig | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-12-gcb2b164780be/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | omap2plus_=
defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/636385899b6706f9a5e7db71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636385899b6706f9a=
5e7db72
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/636386676512ee26e7e7db6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636386676512ee26e=
7e7db70
        new failure (last pass: v5.10.145-518-gc75907dbbb95a) =

 =20

