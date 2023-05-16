Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75892C7EE23
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 21:11:55 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.34138.1684271508527727029
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 14:11:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=KIK3G14P;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-64ab2a37812so8583457b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684271506; x=1686863506;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ERoE+pKC3HzwSeMqCGOqVoJdXcgD72ilD7lfHnurxuM=;
        b=KIK3G14PkE0kLwO99b5b6TPUrpqQHjQjFROcetRItLbPa6wppX4t5oUUxEECYnLWea
         lC/gIAe0wL0gvxEsukGEh1cObprMzsCvBgA+hfzRN2OfIbcD4UOsGRvL1S9/s3qTDzxW
         bhPe4qydeENV34abEgLN690phC5M0892F7YfZ027RcFKELQf+mFcjYU3WisWhROnihwJ
         IUYKa+uztTuj3xEjBWazgUpNw0VQTBafF99ORyBs+2+lsFHKyiqxhgzxmIvIOpd/mSQ6
         5EmrLfKgUm0vE9txwYW3R0sCfYGqCvwbImv0OLI8lCdWDMgb9FOBX8k8CM8U74SwqVm7
         74Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271506; x=1686863506;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERoE+pKC3HzwSeMqCGOqVoJdXcgD72ilD7lfHnurxuM=;
        b=FBNMDBkYRg1RwwJ88l1WZL094tOndUHUCUGXlK+8ewVaET4Wj3X+F/CJm4k6S+37yU
         diDDJIEvC7FieXH75QVYMGA2W10hzNz9KcVw2gMN4SBOz7SE37k40YJM4Hatpla4Ixh/
         8Yxr4Lxy7i6JX83u00Ecv1gnh0P27bjpiHiJmqRLyf/pLc1lfC+saTTI6nRKKeQd0WxF
         SC+umKcVRN4b6jhPYfZmD8EyPkon6vvu+U8G0f8Q9PL/pucIzADdARxMe4tK5ZYGaFWv
         0DOviafFE/+dipjFQlGa6O2887hxfXo3z0KI7RaFnMqv33G17RRn0lUdXEnRIbuZm41X
         86zQ==
X-Gm-Message-State: AC+VfDzfw2/gHOLmCUSALeLCSfuzmIwFTfLbaZsfwt8gHzNI5+Eq9ZE+
	w7o1juQZhC4CFTvM6KH/yK+Rpg5NnjvPXWvjwN/TmA==
X-Google-Smtp-Source: ACHHUZ4tMc8d0jpBRl8MAicUbkzdt4F1kf9Nwm8gbClgkrFy/oUiUjbRajI08UEZyS3N0I0IWu0idg==
X-Received: by 2002:a05:6a00:188c:b0:646:c56c:f0e0 with SMTP id x12-20020a056a00188c00b00646c56cf0e0mr61031pfh.15.1684271506593;
        Tue, 16 May 2023 14:11:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b0063932e36437sm13755742pfn.134.2023.05.16.14.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:11:45 -0700 (PDT)
Message-ID: <6463f191.620a0220.51567.c2d1@mx.google.com>
Date: Tue, 16 May 2023 14:11:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-4-gd8c029e4780f
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs,
 2 regressions (v5.10.179-cip32-4-gd8c029e4780f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 21:11:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11479

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.179-cip32-4-gd8c0=
29e4780f)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.179-cip32-4-gd8c029e4780f/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.179-cip32-4-gd8c029e4780f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d8c029e4780f8e18a07a1a17c1a9de1e01f3adae

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ebe309d307cc2b2e8612

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6463ebe309d307cc2b2e8613
        failing since 490 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463ec2abbf0e7f7e22e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6463ec2abbf0e7f7e22e85e7
        failing since 490 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

