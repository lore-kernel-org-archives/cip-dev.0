Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA0C27C76
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 04:07:03 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.37727.1674619615307938318
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 20:06:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=TxtPBNIW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id p24so16728374plw.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 20:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nvbS7G0ij7+rCezjpaIumN/bFz7K8Bxe4rDi9qRF92U=;
        b=TxtPBNIW4HMjfbNyC2pLYgx4LEwVnkZo+5Bd44mJdezYNCzmIZnJGXw/wcTTDaP2Ab
         rL2frAF8i3hoki7mRTfDQOkf/F9vG1k4YaNPfTf9c9wx1rn7CO1NF/su1f57Q6MSP9Zw
         KtisQf+xekkwpj63qdT5neQRxc4Z0Zcuh3+L8+UKI1u0NVwXHuPamjWM6LOZc8ExuuAL
         nVPNNfQ4i8Ja8NQmCHTKPtpYsD1ZFj12o7oG1tIys9FPIfjekSUfrYMNuCQ0ebytccGS
         c/CbUnBSQeY1G8IokGCnRG9NA4NDoyE0Fc3ni/V3NCL43HxtH7ZFrposXOpE2aC3f41I
         iFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvbS7G0ij7+rCezjpaIumN/bFz7K8Bxe4rDi9qRF92U=;
        b=hs1EqjYYAfgz6RGKWPtA9ATWUmq5QC8Dmv51W9nhBiEM1N1uY7XdXRVDBGtjgHDSXS
         ofPuhUbdAoLFj6D5RPBMBUr+MDqvSYJeZFGLnftqTFKSFga2FWBYQMRy8rmo80Z4gIeo
         kxJQ3LeUCBlq7H20sE/nS+KCK2SQo11OjmFeZ5K8KCua74tt38TyLuRN8GwInoipbv7m
         ZnZkJvR2Qe6PaGF8I62VC/jJLSF0MqU68TQch5cSaMZDrPE7Ybfpp+WL5SXOCysAxAps
         EH3I8oxFo110DVkOieIak1pTC+Ydrw4QLnIcQORcG6Em4t5TXtodnE3EKXNYkx8FJPMF
         8o7g==
X-Gm-Message-State: AFqh2kqkbkIBgRmz22zceZ95yUzDdAuLifnR8+L6bK4Ew/f0fJJFKGDS
	c7co1mBGQpaMopqc0CnRHikmP2cwBDYfSFe+nNg=
X-Google-Smtp-Source: AMrXdXvgve/BKPlOX16DrsGQzozHkocBZaTJnNn3CMsukrqZFeKXxHMGF28xEX0oGdmyxoRx0rXn2g==
X-Received: by 2002:a17:902:d512:b0:192:fd1e:a968 with SMTP id b18-20020a170902d51200b00192fd1ea968mr43981299plg.46.1674619614465;
        Tue, 24 Jan 2023 20:06:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id io18-20020a17090312d200b00194c82c2a7bsm2445090plb.224.2023.01.24.20.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:06:54 -0800 (PST)
Message-ID: <63d0aade.170a0220.6a6a4.4c22@mx.google.com>
Date: Tue, 24 Jan 2023 20:06:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Kernel: v4.4-st20-821-g39bdf0444b23
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-821-g39bdf0444b23)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jan 2023 04:07:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10478

cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20-82=
1-g39bdf0444b23)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-821-g39bdf0444b23/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-821-g39bdf0444b23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      39bdf0444b238ce8b92fda121bd1462a27f07a66

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  d042c168dd037bb0128b86ee4ac4f5c526eddc7b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d0944e4bb17d9763915ed0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-8=
21-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-8=
21-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/63d0944e4b=
b17d9763915ed1
        new failure (last pass: v4.4-st20-234-g4e6ec7162c8e) =

 =20

