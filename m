Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10566CCA479
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 07:07:43 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.2774.1657177661047370923
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ZZNDLaHv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id 70so2489271pfx.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VELBbTjw8qZlfvJHz4Su5X4/kbDgjRXnaf6iLB2cFbo=;
        b=ZZNDLaHv1VnokrxsXfH/MaSjcpQ3C6lwcBR/lq5YPBoByp+UjquKAMsucDKexg0jCC
         199LMYziCFe5uxii0z3c7BXE8uD0Qw9lNbp+7XwgPalcMEQc1XADYutvT0GlfERr+B1Z
         DqGgsUyLC7zcO7rtk9ZXaRalTf/fOxrTJKw11nZrZLOqszEoYZwSjHUvUZG9wuNFQTP5
         vyh6mOu4yWASQsY/0ZrTL+x4Vew3k1uqx8+mdSYzDBvrBMw/G27lNHg/oA68PZfs6749
         29/yD8FjC+zwRhne3MclZEFo2XxBVBcxZCmV5rQ5g0DLqsUCufH6UmuHuhdma4tKLcE8
         SfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VELBbTjw8qZlfvJHz4Su5X4/kbDgjRXnaf6iLB2cFbo=;
        b=Sf/M/d6dgnHp+Zi5bATnrCQXE8bdLGWN5rKYmoRauHnwPujhsQAj2gSqEJAKO//iPK
         tWnt3nrvyz+TtwMY/fvliF0M0Qc0rML6v53BsCQvbYvtj8DS5jziD5XVwZogdUCmEU7r
         JVXXWSG7YOJoPvQQ4fyp0zRcjD26Y1WvjdB3JpkWhFXQWf3LQOE/9SXT51PfdO89VjCx
         DBQ6Ir036jsBH8E9jT6ziJB0WC21Smuohw3MMgd0TK1rPD91567RNcYLBSaWASwpJ7n/
         5vsXntutFXzdsDVlnxImdFBdnEfWpG8nEtD8Oo4IvgOAn2Q9g/vOSf3PESrH8KBFgsk1
         p8GA==
X-Gm-Message-State: AJIora8z1nviAsIxXCbiHgYuqL6xzwG6PA8b6BodHRK7H1OoZzggzmQH
	KxN2IIEpbh45J8/rlO03ZSwLXwlk/ehr3eEF
X-Google-Smtp-Source: 
 AGRyM1sR6u850Hh2DF6unXU8UN9vtLy4hbfNVCMPubhs1579q05EUXOKZiLb29IlPlOnoEgNi8epbg==
X-Received: by 2002:a65:6b8a:0:b0:3fc:4c06:8a8d with SMTP id
 d10-20020a656b8a000000b003fc4c068a8dmr37691554pgw.83.1657177659971;
        Thu, 07 Jul 2022 00:07:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x7-20020aa79567000000b0052524b1bfc3sm27270345pfq.147.2022.07.07.00.07.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:07:39 -0700 (PDT)
Message-ID: <62c6863b.1c69fb81.2169a.6e2e@mx.google.com>
Date: Thu, 07 Jul 2022 00:07:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-116-gef362fbbff528
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs,
 1 regressions (v5.10.126-cip11-116-gef362fbbff528)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 07:07:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8709

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs, 1 regr=
essions (v5.10.126-cip11-116-gef362fbbff528)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-116-gef362fbbff528/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-116-gef362fbbff528
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef362fbbff528b6dc0695b488cfc8cde20b404e4 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62c67528b6f77c25eda39c11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c67528b6f77c=
25eda39c12
        failing since 4 days (last pass: v5.10.121-cip9-287-ge9094c8446fc, =
first fail: v5.10.125-cip10-118-gb03e159be974) =

 =20

