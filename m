Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5216AC19F2D
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 10:51:57 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.10313.1660042310129533176
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 09 Aug 2022 03:51:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=lEPY0joO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id a8so11295352pjg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 09 Aug 2022 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=kNImRpD+5vaZexp63eqw9N28cCU+Vn9EiYsqUogK+wo=;
        b=lEPY0joOSinT5JCsBILm6c/NxPXpFFk8pdOqPxD6s/LVGh6WCckKoiS0kcFQDVsX6+
         jzEl39tfwcjV1XhfZ4UkD4dM8BqVnHzkaIu/JS1I5IAtmFJDoSPfsvX2YnqGQkyYt+qv
         pXCEDAWqiY8uAHzTvOlPaApHMcLCbdrJkZfpnKywYEdarT7kYKiRqKM8nGNzTqesacjg
         iydFXpZha3UGkya2/hQg3tFCaTzk1//yuOoJI33fCWFUTeZx0KoNFX5ff+D5Hdaj6EEe
         bMuC+CDQk8X6w25AtDucdykpFXSDXdugva7nSd/fKuQK/vOGjRz/OgI7o+wbT7NMqBUD
         kx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kNImRpD+5vaZexp63eqw9N28cCU+Vn9EiYsqUogK+wo=;
        b=Hf5wgQ2M4+/VJ4LiCUhBGJ/pjaYEr0lB98U1JX1BO5pm2MnJMQOm87OQjhoxeBQdMT
         vcBAQamvh3MfYTaLVIn8/S/fRO5lfgmP/7kevDQFUqZpmZ6jfabk3j5y1c2i3p/MHWLk
         e4a6kOmtyfJ4tMvx0e27MTQ6ccFR7wexmzQY1g1VBMwlaEALfr5rlgocBo9POjFNlKqb
         TAcPtm+QrPgFV8W2SoNSmILD74WaaVCzf7FSF4Ncv5w9WE8r63ynGRdT3Pg6MLSX9JJQ
         zmGsY2gEELmI/ECtCQdqtki6MSrz6833S9DT102RJPxYkSR4Qg+2qOZO7K12fkrraDMa
         woBg==
X-Gm-Message-State: ACgBeo2BRnyYcinBTRZybfIsyspiTlII0Lzq0dL/RygcenEZwz14QwF1
	AvWk1+GdZTT66JyFnNBsXQzs02qS9EmBTb4kWQQ=
X-Google-Smtp-Source: 
 AA6agR5VNOQLm5gsopEFPVveXDZ32LsT1XbinMMRBsq1Uixfd4S7ATuMXUJCqjrrssTUT0KTyejIYA==
X-Received: by 2002:a17:90b:1b01:b0:1f7:3e2c:7ea7 with SMTP id
 nu1-20020a17090b1b0100b001f73e2c7ea7mr12736656pjb.59.1660042309248;
        Tue, 09 Aug 2022 03:51:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q12-20020aa7960c000000b005251f4596f0sm10310786pfg.107.2022.08.09.03.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 03:51:48 -0700 (PDT)
Message-ID: <62f23c44.a70a0220.2e54d.0cdf@mx.google.com>
Date: Tue, 09 Aug 2022 03:51:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-38-ga8671b4cc3c74
Subject: cip/linux-5.10.y-cip baseline: 34 runs,
 1 regressions (v5.10.131-cip13-38-ga8671b4cc3c74)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Aug 2022 10:51:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9147

cip/linux-5.10.y-cip baseline: 34 runs, 1 regressions (v5.10.131-cip13-38-g=
a8671b4cc3c74)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig         | regress=
ions
--------------+------+-------------+----------+-------------------+--------=
----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | at91_dt_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-38-ga8671b4cc3c74/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-38-ga8671b4cc3c74
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a8671b4cc3c74094029e1b5523bcdc0d32eaa64a =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig         | regress=
ions
--------------+------+-------------+----------+-------------------+--------=
----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | at91_dt_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62f22fded92d99bd0edaf067

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-38-ga8671b4cc3c74/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-38-ga8671b4cc3c74/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62f22fded92d99bd0edaf=
068
        new failure (last pass: v5.10.131-cip13-37-ge3a52725ce96) =

 =20

