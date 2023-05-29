Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD5C77B7E
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:57:10 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.40702.1685321821117901292
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:57:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=w0ikwpVZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-256797b5664so315573a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685321820; x=1687913820;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GM1wUYC+kKYZPiHzaeehCMu3+SeM8wk34bJoz+1OWe4=;
        b=w0ikwpVZltvQncN60mNQ/rBIvrkoM50i7Bqhp1mxoXQqyY4oupVvN5dyTRX019VnzZ
         HS0xtHsVPUcHMi7fcpF3H53RUHbf6eeG4D3ZbH6GCTNd4Vsi5Kk18vWrMH2G+L0l+6zz
         pztY3sBE1UdsXTOcvCTKix9vKxowJ9uuEcuzuYCJuHeaPVAbRFEq/Ln58oHms9GdiHGI
         36nr+f5EYkf1gz2dKuum0Buscv1nR4sIGeYseQR09NMky2pp8Jt4xDnlscsqO9kUJTQW
         3pTnHPNUgCGjIkw4WwZOmplr0mMp5CV2/rTx1XPEeJ2lSp795fYadlNfWjWjS0xkJWTi
         7OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321820; x=1687913820;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM1wUYC+kKYZPiHzaeehCMu3+SeM8wk34bJoz+1OWe4=;
        b=FXzuusGoKNzKsGtgFW43jeFIiM4pCrYP5IN5agLzgdhohkEGhLzm4hMQBbZE5rPtp9
         ehH6uLm9fEQ2KBOBuh6cj/IAtLv3SRyjs8S0zkYK0uTp1WC8Mg4Xr2o2RwqTeMubvNQE
         gmTs64TUh9oiNs3VUEgGxS35wMZ0MghwNGOSdfRbus9HU+gM1v6qYsfiFEq5E/TRXxrZ
         1FdFfdhExx+PsqQ6txfcmwd9XJysXPiDRzzK/DMpUl73K2X49ALhQF/O1ivFCQQH4Z3j
         DgHvXzCm/28Da2cBo0+RjEFHbesmPWOfv5+ER2c8M8DLOx7AZS3H9jI+RcuBAApIncKg
         ucVw==
X-Gm-Message-State: AC+VfDwEOO9l+wmJXVdncnpEoJSE3WJh3Q98kSA0xmpV/jL228Ouutkp
	i57mOh+etl3+hvPAHrHTgvQBEtQSkI09h/4LapLWDQ==
X-Google-Smtp-Source: ACHHUZ4EyIPO7xq7IZUnv7hkYFtmJCzV/cjBJIK3EcUObeKClx9uiT4uOxvNYcanJc+os/gnfVfy1Q==
X-Received: by 2002:a17:902:e5c2:b0:1ab:63e:67b0 with SMTP id u2-20020a170902e5c200b001ab063e67b0mr10025233plf.54.1685321820128;
        Sun, 28 May 2023 17:57:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bb9-20020a170902bc8900b0019a6cce2060sm6823169plb.57.2023.05.28.17.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:56:59 -0700 (PDT)
Message-ID: <6473f85b.170a0220.883ac.e093@mx.google.com>
Date: Sun, 28 May 2023 17:56:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs,
 2 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:57:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11677

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.180-cip33-21-g8eb=
0cdf459a2)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-21-g8eb0cdf459a2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8eb0cdf459a2bb2971bbf3eecc4f894d2717cff9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473f020e0e325a27b2e8605

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6473f020e0e325a27b2e8606
        failing since 502 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6473f11ba370f78e7b2e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6473f11ba370f78e7b2e85fe
        failing since 502 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

