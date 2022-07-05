Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2549DC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:08:15 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.79864.1656990488096361374
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:08:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ah+KOzWm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d5so9868979plo.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XhKcPX+1sOvV7TcGiAV6W8VzN7Ab8gfdGODevnWk9ew=;
        b=ah+KOzWmEZTcx59iYCaSz7LCb59Hw7vIYrP8TQP9E1CohYWB2IwCA7kUqSI2oGCbIc
         NyY2OpOGiE7j5UwYP4QCQFu2rc2xJd3SB/glFfKGLpDEuRJr0HjniPE55spbxB/nhvQb
         MiF8IAXKkSYGOtYinohNr/Ms1cjGzIPQdswlQ+N/L18J4ixxFGFpPszzj73htIClQs9+
         EYsqmhoqi9XLwF+28Ln6d3lG7DXXAGj/u2lX3ylsIGNjENPUtis0uafgHc2nqQNXqih3
         ZzhDnZqfv+f0hmw32jYlwU2AK4+mfIov7jRBSzHqHr1nNxOlcjfKFqLrSmgerOSkgdir
         FPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XhKcPX+1sOvV7TcGiAV6W8VzN7Ab8gfdGODevnWk9ew=;
        b=6QZs4BWLWL2XtV1xXQtFoI3GcMSKroMiwT5rpniUPNm+8Vxa4NesJ0PKLvvXdrt+IB
         +X26nFzZ/RtDTWBD8pfUKZM2n8vWVnEsYpvbTnpWfn4nzmFhC5Eu144nP6vrHLqr3yes
         a1hdDM0bxWOJATJkhxNZzd0CeNVPxkOUOdLa7IwbsS970Ma6DhZ2qDxT+rWafMzz4exe
         5UhQQgW5sCNwuRCJHRTCRB6cuL9pV74YUIyoujKT2SdGNQPkP4NsHeKYwMcivK5P4+WK
         WWy/L620e1bUg/ZE1xeZSXb3TZopuma9yS8/s5agdeZ+U/hBuhfys05JA50/4rbFdSg2
         eLJw==
X-Gm-Message-State: AJIora8mzVCdckTLdQAIBYX4HtTHaPUD1wG26HC7Ww0OIJeXTgx0S2In
	xTHINRuiTlyNB6wEtCuzWBrRls7+MYQ3Ng93
X-Google-Smtp-Source: 
 AGRyM1u/+ZobqlJEKKaFgurjzcaN4EV5MynGxazfYAZ+506wI/pP7evraeSfzq4F/qy0VL/pJdtSgQ==
X-Received: by 2002:a17:90a:5d8b:b0:1ef:8659:92ab with SMTP id
 t11-20020a17090a5d8b00b001ef865992abmr11366591pji.7.1656990487406;
        Mon, 04 Jul 2022 20:08:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a11-20020a170902b58b00b0015e8d4eb26esm21958411pls.184.2022.07.04.20.08.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:08:07 -0700 (PDT)
Message-ID: <62c3ab17.1c69fb81.705e3.fa36@mx.google.com>
Date: Mon, 04 Jul 2022 20:08:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76-53-ga202ffa2bce5
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 58 runs,
 1 regressions (v4.19.249-cip76-53-ga202ffa2bce5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:08:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8664

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 58 runs, 1 regressions=
 (v4.19.249-cip76-53-ga202ffa2bce5)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.249-cip76-53-ga202ffa2bce5/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.249-cip76-53-ga202ffa2bce5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a202ffa2bce55da1a3b9c1f6ff2594af0b4e2d68 =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3a9a9467eeed2baa39c86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-53-ga202ffa2bce5/arm/tegra_defconfig/gcc-10/la=
b-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-53-ga202ffa2bce5/arm/tegra_defconfig/gcc-10/la=
b-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c3a9a9467eeed2baa39=
c87
        failing since 28 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

