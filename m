Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F31C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 21:10:43 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web08.267.1657055437758722562
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 14:10:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=mc9yXylG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id 3so2507718pfx.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=auYiW1LGBuJG4z4H/9lz9DoJKBiHAJlAH+QQH/1fEO0=;
        b=mc9yXylGuitJbosPjn1fhRpLDduDCZj88b146sJ8HkmDqmC3SIDcJOd++JEaAbt5Np
         /7lOKASLnycjUyzm8UW4jFt+xYiwacdHw7hr24dWdeTVZ19qNkhW1o0hVbSmxkO0ng/W
         1Ypn1aYhZRMqpuEJu/Xjl2yHxcPQ7XuQtWnFuWdky+Wbk7qMPhMOI6GNElWqgB2wLVQA
         Vr9A1q0bZenEvgDK/J5cCTd8C5frkkW/0eEaZS2/n4qoPilrkuo0XE33L8zABzoTcgNx
         sOGDnQQhWNPswzzcjN4am1hh647Vl51bLk6ElcJLVIfLNVT1jRPE6SBvplpOvXDfw/6r
         sMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=auYiW1LGBuJG4z4H/9lz9DoJKBiHAJlAH+QQH/1fEO0=;
        b=or232u2q2PCAolv1eLZu2jIjs+PtFyM5GSUpc+49aJqs6fr2cKZ4wxwHFyTH+CI4e7
         xz/D2Z3zFOSnGSa8IyF16NuS5uIsCNUp+Y4ty3l3Wj71VKR2QTjf3t9FqSDkkap2arAF
         0i+cmQxmbT/8FwtAUljpVeK7/hwvrqDOGmqmJ+SvE71tzF+fTvOLmlDDJtqSzcw5vCaB
         u4WJm1zKwPdS6VYzkCFKfWlqmGv2P7eznW28y4kr/6AJ9ukKrsYYhJ4FniawmWUxnUK5
         2pvxaStH3RkPOuHttmUaU4T7FhcDmI4NcsbwVFo3HEVpE6QivWo2mw7xGtUV1JUjBOxt
         N4oA==
X-Gm-Message-State: AJIora8BPw0pmrivq47rA9H3r70d3QhFb5VFTD4yjNVXBhm+saL65sa9
	MnVt1lnsSw89XXSo2ogZRuzp3B+jLfmFbSr4
X-Google-Smtp-Source: 
 AGRyM1vqYgbnW9fJnNgjoygVLcA6ecSR6nANaffMPepSJzRf59sAQ7aepJC73cGlzZDf7VC+ylLT6g==
X-Received: by 2002:a63:f14a:0:b0:412:434a:4b8a with SMTP id
 o10-20020a63f14a000000b00412434a4b8amr11364225pgk.620.1657055436687;
        Tue, 05 Jul 2022 14:10:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n7-20020a170903110700b0016bfa097927sm863878plh.249.2022.07.05.14.10.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:10:36 -0700 (PDT)
Message-ID: <62c4a8cc.1c69fb81.602d5.1805@mx.google.com>
Date: Tue, 05 Jul 2022 14:10:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-1-gc5218dc69ff1
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 6 runs,
 1 regressions (v5.10.126-cip11-1-gc5218dc69ff1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 21:10:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8691

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 6 runs, 1 regre=
ssions (v5.10.126-cip11-1-gc5218dc69ff1)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-1-gc5218dc69ff1/plan/kselftest-=
futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-1-gc5218dc69ff1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5218dc69ff1f0703b893c079a21669841b479e1 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62c496f20b0280e6e1a39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig/gcc-10/lab-bay=
libre/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig/gcc-10/lab-bay=
libre/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c496f20b0280=
e6e1a39be9
        failing since 2 days (last pass: v5.10.121-cip9-287-ge9094c8446fc, =
first fail: v5.10.125-cip10-118-gb03e159be974) =

 =20

