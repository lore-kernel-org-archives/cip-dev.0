Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35030C54E58
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:57:02 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.20892.1709200618877271365
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:56:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tuqJdSNH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc29f1956cso6423945ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709200617; x=1709805417; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+RYQ7PJQ6aD9q4cPNcq72Ca+oarmjiJxhc6uY89FipQ=;
        b=tuqJdSNHRYnlHR2Mm6MKWWcmn5S59djlGYM1VGiI7Gko6Th73eAsoaW8okwuxRphei
         IYyZK8g3DmO/sjb1GlCbii0l1UT3KKgXZJExfQU2RqHDBaee53IuDWMBVw4C0tVhuOgn
         aHGzFJ5AK8MY7wL+pLtFiR+r+q1rnVZ5caY+3Pdyaqg8yZHC2qM4uwnSBEv2MzPkejde
         +6cOcnLHrMp/n0CEWOEsM9UhNgyrqIrHXRnDkpGJ+52hGjaYwsoDRX/BsoJwEKc9AtFr
         RorxD+A5xsor8BVJwtmS6JaE8GMshEG1mXpLFz/R4pIu9mgdhpYykaO8GI9qsOkPMsfc
         lBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200617; x=1709805417;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RYQ7PJQ6aD9q4cPNcq72Ca+oarmjiJxhc6uY89FipQ=;
        b=lY6XB0tAmluZmJlP1uTu9jXuCTLBQ4Sm/956njRard82gtEtraI9syM/o4YwhHbz+h
         C0xM8S0VRQU1yLxWqXVwImLLNTsQEyTEX1JzxrXzG6PZWzUWhvrsBrh09K8mywwwcGwz
         pLrXjWvrC+poHbLnOLwxvacoWqJg4kTv9KkxeRSVoylVLIEQ7O9xs/bbGS5iTdMJLjy6
         1u+InpVBWXqs84tWLv4y3EarN3qk+MwIfrhJ+umcagXISBj3G8inmVmfPnQKrwqf07WR
         B8F+PGfHrTMTUjjWLLSQYXlNzB56/JGnTtaDl9LzAh8vUC3M6y/94JWYcEW8yj89My1o
         8cGA==
X-Gm-Message-State: AOJu0YyNN8lA44W/6+ajNo7b8MsBmY4io3FRBtDHTY1IRLsGLje/Tu2a
	rwkh6QP0LgQWRmTmklO7Ep6Z4EQrJpVh6RPzVWqeDrhMokMaWmD28R27Wl9QXUua08Wqap/zeZI
	SXjQ=
X-Google-Smtp-Source: AGHT+IEsyis8jnE0PsV0Cutnqxuy7MwqO/5rCSHy+KK0ZlZ8dbKZ4fh9ptPjQTSkeSxnPslqnzdkjA==
X-Received: by 2002:a17:903:228e:b0:1dc:7923:aa17 with SMTP id b14-20020a170903228e00b001dc7923aa17mr1911053plh.64.1709200617399;
        Thu, 29 Feb 2024 01:56:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902e84e00b001dbc3f2e7e8sm1036239plg.98.2024.02.29.01.56.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Message-ID: <65e054e5.170a0220.594ba.2c3b@mx.google.com>
Date: Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 15 runs,
 1 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15111

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 15 runs, 1 regressions =
(v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65e04547ed8b61b8cb637053

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e04547ed8b61b8cb6370=
54
        failing since 92 days (last pass: v5.10.200-cip40-188-g33d0b44cd71d=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =20

