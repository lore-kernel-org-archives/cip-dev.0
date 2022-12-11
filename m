Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB2C4708E
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 19:04:14 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.24012.1670785447796576295
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 11:04:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7zdMFWDg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id s196so6819546pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vm4eihjjHLH1+QHcZNazZXxaLiaDyLeZdngn8nrEc9k=;
        b=7zdMFWDgmShzRuEiYPl8q0dytd2aMBsOMFQlrLUP/DwyNbQKa4lpWlJKHvedBGnoNN
         g5oAv+HfPrAVyosi9rWDioYyshOCePNtRJddeg1+Mbqnj+4OBJTW5JES4bt2Sk1EskBn
         w4KzRUlFlq8H66X8qXYPgwZYHjejVJhDAkcuBgheJmFxZnjmi5sTk/IeSTlWr9Z5Bs+8
         nrps+LQXdOmfpniLl5jv/UgY2+PNhs0vXiVfLG4BMn9rAkrNYhfgE6Jo27S4UE1oEeIe
         /pzr6qWgd5Nh73RzgtfOu1JM+g724IIvr5B6UuIxvufMfMqcVR6qCMT8MqF1Xxz72kNZ
         9X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vm4eihjjHLH1+QHcZNazZXxaLiaDyLeZdngn8nrEc9k=;
        b=mE2khF4Wq5+v5OKQI/N1UkJ0NQE0bOK3i7F7WWfPGI1dfxSNKnyY2i9DLA08u1gXiM
         1T99CFOT56I480a6H6iC7nt4zt7mMm4m5fSCXp8/E3IxHTz4ANdXw2b3uGMc31KJ41M0
         26byldxea+f4DhGLenwTcT2MCHmD06t6dWj5Gj279JBOFu7pc3S4Q0uT/3DHUdco+Q8V
         Uk8xoz8ZHz5FObSA6KzJMIl7awAF+Xji6Nvn9qZV/MRCvydR/xxCbfR35zfi13IlPbI0
         HLt8uvewycNLm1a8d1mJnouDfPLoiJZU7KHFG/HVKCFh9DIJSFDHkJt8HCuyF7DvklOx
         HJaA==
X-Gm-Message-State: ANoB5pntvuke1mt04AouWT1k65zrFVSUJOz6dPmTqDAXfHzp+8KK9GkR
	PPH3Qpcwk2Op5EdS8I4kXGLZbacSlXU8V9nD
X-Google-Smtp-Source: AA0mqf402x8tM1sfmjglceIAk6PtIUv5TL+a6LeuB8mfBIlMhKu+RKwBYyprW//yA2MkrqFRwBldww==
X-Received: by 2002:aa7:9011:0:b0:577:8bae:29a9 with SMTP id m17-20020aa79011000000b005778bae29a9mr12952067pfo.18.1670785446499;
        Sun, 11 Dec 2022 11:04:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a62a203000000b00574740c99e9sm4285111pff.129.2022.12.11.11.04.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 11:04:06 -0800 (PST)
Message-ID: <639629a6.620a0220.bc08b.6edc@mx.google.com>
Date: Sun, 11 Dec 2022 11:04:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.158-cip22-435-g2c52868ae1cbc
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs,
 4 regressions (v5.10.158-cip22-435-g2c52868ae1cbc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 19:04:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10201

cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs, 4 regressions (v5.10.15=
8-cip22-435-g2c52868ae1cbc)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.158-cip22-435-g2c52868ae1cbc/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.158-cip22-435-g2c52868ae1cbc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e76de05a93390f5ec7fae2941d8f24d367c9b2b8 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/63962009fff06398bb2abd1b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-cip/ltp-time=
rs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-cip/ltp-time=
rs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962009fff=
06398bb2abd26
        failing since 25 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962009fff=
06398bb2abd26
        failing since 25 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v4.19.265-cip85-rt27) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63961fdbb42b54e80a2abd31

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63961fdbb42=
b54e80a2abd36
        failing since 32 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63961fdbb42=
b54e80a2abd36
        failing since 32 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

