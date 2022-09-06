Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E860ECAAA1
	for <webhook@archiver.kernel.org>; Tue,  6 Sep 2022 01:39:16 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web09.32214.1662428355162034986
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Sep 2022 18:39:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=HhFtbgob;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id y127so9929395pfy.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Sep 2022 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=urVzXm8ssE6dAa1S6JUf6XPw2Y/exqHeBGReaCYLdfs=;
        b=HhFtbgobV/60bUDl7PCR2RTQBwJxqYUBioZIw9CflY+eDFN2nhYAD7fpiptZjzl3+M
         MYPf+Q2OmDQemscr7fQzje/UGTS6zXJpkDb/NZB1XShd8pA4iVpsKx8ehRk6o/2sevzU
         whqy973i+qO8fZHxP1/0xNwzwAv0ilUstVfY4gs9Eo5rdeEUwlDNB3C4zi7J9XmbspFR
         W+p2JMWhw1hOy1Rd+Co5id9E8vYK7usfvgXzbiKQxlOkXKWISogitoa7uakXawJjj38L
         Th+/JERBfzCbZdHhb+zCuvQaFBzcVGsrpGW0P9aUhivvkEzHds3Avxwp6WzHrWu1j1cC
         zyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=urVzXm8ssE6dAa1S6JUf6XPw2Y/exqHeBGReaCYLdfs=;
        b=yts++ytyIWwlTO0+0TsUKgyIFUudV4dvELNmEUkTpBYag751tE6oYB3dx4123Ugssw
         aYbrxrC2Zf1N0p/a+cQGzbTXUTw/fQOZRrNFTo7OkcvEImACC7tS7gAWZ36v3v8P06jA
         +Pyuy8LhhcseFxXhvcrnbFvXlzDXYoPDdi9+j7jLr7DFreDZtRPFLNwXMEBQg22nNv2y
         xNvjnvEHq3gfTTWPNTjWVlFRHne++AxXM0MyZ5E/eV4qRo3Jk39S/VP2oqYG6lJN4GSe
         WPCKmxXE40O4pafPdbi/5KRdJ3CZUfT1ElOSDxncAE2nRC3J/9T1wyGHzwfSJP0Fxfx6
         dW8w==
X-Gm-Message-State: ACgBeo10mTXbYB9TuH+7/E14WZs+M9RZHQO4303SiGbiKLqEQb1ZSCha
	KAdh/KuV9PKC/ZrzRx4Z0L8MhDVtFuiV4/ziCkw=
X-Google-Smtp-Source: 
 AA6agR4QGLVKVkX/2o9qPkO/6yLbTJvJi6KmoushU0+GDIbL8UGu/LnLPcMzgtquZ3AsENJTWI6pjA==
X-Received: by 2002:a63:1c9:0:b0:42c:254a:d15f with SMTP id
 192-20020a6301c9000000b0042c254ad15fmr33308470pgb.468.1662428354071;
        Mon, 05 Sep 2022 18:39:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x63-20020a626342000000b0052c849d0886sm8465235pfb.86.2022.09.05.18.39.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 18:39:13 -0700 (PDT)
Message-ID: <6316a4c1.620a0220.ae6b5.cfa5@mx.google.com>
Date: Mon, 05 Sep 2022 18:39:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-10-g52cbd8ad1543e
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 9 runs,
 1 regressions (v5.10.138-cip15-10-g52cbd8ad1543e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Sep 2022 01:39:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9463

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 9 runs, 1 regressions=
 (v5.10.138-cip15-10-g52cbd8ad1543e)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.138-cip15-10-g52cbd8ad1543e/plan/kselftest-filesystem=
s/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.138-cip15-10-g52cbd8ad1543e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52cbd8ad1543e12ef69b428c8535df3b2e60fa86 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/631697a141ddd6680d355655

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig/gcc-10/lab-baylibre/ksel=
ftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig/gcc-10/lab-baylibre/ksel=
ftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/631697a1=
41ddd6680d355656
        new failure (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d) =

 =20

