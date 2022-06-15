Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C0BC43334
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:35:04 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web08.2596.1655285699254758474
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:34:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=cE8vrEP2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id t2so9939575pld.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7/EoknERReatCoT9jk5u9a0rn3Lq3UxjPcpSRdpB46I=;
        b=cE8vrEP2+RHo7pdNOSg0SBIDiQe7LBHVJrb2KJ/4KYyoSlTgqeL3zl51dshDaBy3yL
         3QlHbU2ZDyuqY2juxU5RXGSc2C7OJyopm6eQlO6svmej7XQ3mdQpQTf5+VF50XZXCdND
         xw9eVCr2w9emn3o9e11skBVG+cApJ/vVxDGipI8s76qs4WVLNb8v/gT/jeq700cNB3jD
         oa/BYiv9TqiurWOTfNUINJkf8jnYpu484szj8Dq8hkgNWWE+R+kv8D97R/GCYBg/qmL0
         fCyani7tZpy1Q/Dk6qPbRetZF383DBmZiLV3uRaw80q3lKHc5RKpTdLnpO8TFGS3xVA7
         rkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7/EoknERReatCoT9jk5u9a0rn3Lq3UxjPcpSRdpB46I=;
        b=GYUvuvFnyYN4FR0o++mBvhLXy25gw5XU3B/1eL7piEzes/JT+ASak/eHAZe/P9vgKy
         lKDxkX62haiGh/ytjPytwUMxRjl7vkuM7wEDaPb2kwkA51+GFsIhkyAozlRv/TQwdb2Z
         5GMd2wJwVUGCfuq1mgv8GyLY0gJ2H975vgPZeu2n+GGbL5xL0xIM0946D9ip+6SyrzEu
         2vkKtgdjnNCNiZe0iJxulztcCvs7yL+3O4auoOHtsNPR7Ki2etwxZZXcTBVgnF+wx46J
         u8rAcJx3eBGuQ48MxLbay+ZpuSLPt1bU3ph5V5wNNFpvQJ12XaPdy+x3HoFK3f1taRd2
         DLuQ==
X-Gm-Message-State: AJIora/jL0PWiN8sRYneR4rBT5emKEf5dshdlTObANOwA6MXumGTn6RE
	Mvyj1D3aF2/Nr/lc0AIfu9E/4ko2ZDovBhNbkKo=
X-Google-Smtp-Source: 
 AGRyM1s8w+P5AedgowyTa4tGAIeVUxczgErbuGk53Gjp2JybmK1BmCUA+kvN+/dJzmhvSdt4BJBB5A==
X-Received: by 2002:a17:90b:388f:b0:1e8:57db:443 with SMTP id
 mu15-20020a17090b388f00b001e857db0443mr9225815pjb.52.1655285698281;
        Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c14-20020aa781ce000000b0050dc7628178sm9263541pfn.82.2022.06.15.02.34.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Message-ID: <62a9a7c2.1c69fb81.1c9ca.b916@mx.google.com>
Date: Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-312-g3a12bf5207d81
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs,
 1 regressions (v4.4-st5-312-g3a12bf5207d81)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 09:35:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8563

cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs, 1 regressions (v4.4-st5-312=
-g3a12bf5207d81)

Regressions Summary
-------------------

platform   | arch  | lab         | compiler | defconfig | regressions
-----------+-------+-------------+----------+-----------+------------
juno-uboot | arm64 | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-312-g3a12bf5207d81/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-312-g3a12bf5207d81
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a12bf5207d810922b696a4c99c88e2841af6212

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform   | arch  | lab         | compiler | defconfig | regressions
-----------+-------+-------------+----------+-----------+------------
juno-uboot | arm64 | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62a8a4ce8bf2a4e48aa39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/ltp-pty-jun=
o-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/ltp-pty-jun=
o-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62a8a4ce8bf2a4e48aa39b=
ce
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-261-g4f0b5ddda6cf) =

 =20

