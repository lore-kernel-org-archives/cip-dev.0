Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8DBC46467
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 12:01:39 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.17110.1669118490534536941
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 04:01:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Iwv0flPG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so17079072pjc.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 04:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oCxfHWrefZCYaR8nyyW3qSC+qRC0GuiTdYirTEDjr4w=;
        b=Iwv0flPGFJqVw8TI3G+edZEr5nWTiz4mExvzumcBJBXJsYxDWHqpi++BT4eXAcrDjW
         w3TIW0I8XJdD2ZXR5vXhY5jF/MAyorNlpKLMCLClsjr8P/d4uT+uk2x5WHuzxqRtQHke
         T1qRm3XgDdBmPKFCF9Bs77cgNt2PhhFeuM0OtUOWqF/U0dYGodCevBYk0h7HlApqao3N
         5on0SwJhLyOl3UZt9ythcT4tMiSZjftJwE1rS5hHTrhWMJKwl5KVZ+36IU2nL2tutV5T
         ushjJlhSPxaNIFr1ThNvso7XdtEjYRetQRWwPJihG2LtsXfyNEWJr9zz/7hrWW+I4n9a
         eNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCxfHWrefZCYaR8nyyW3qSC+qRC0GuiTdYirTEDjr4w=;
        b=U77cLaAFNA0/3u2245XZ/2/PbGEjiWpN549bNLQ8MOQVjl7zdv5J0/wFcDQIyLSQMu
         XDZCgOLy1s937IBDu9i2PMYTkPkdsjQWIsKXREBA7SJacyHYX97Mj2FpcSNaOCo1fLCZ
         eBX1UAgRtEBGkXS9Yz8cWB8Fi850ySQqed9V4yot9GWwgwqxWPgqa2ETGWl7S6yUQDLa
         GAXnVDgwvrtl8DvfH1bDbrb6YZHDu+bP9eA5fKkN4VX/sGfcX+1jilPgZa5eT0ukWEBu
         Tr2hHCxBm6zhTw2b5nPhMHuZtQtzFTLHprtNDDmMXFK9KEzFX7bCZwXxYJYnZcrl9TYa
         dyQw==
X-Gm-Message-State: ANoB5pnZMGYBaLpgpV94EN2BPpelG5cBrqIXB3wUyd+mps847K8WOb2z
	MFEF0hiNqTIvxv5Q7fAo8ODE6vn5PVgaCnoI32k=
X-Google-Smtp-Source: AA0mqf7K5gtmNLalSNvmQGk6zKaG56m84F52f5z9qVcYVvxQkaOU+bXuuQZYg2iSYkBQ295HDnaVaA==
X-Received: by 2002:a17:90a:c095:b0:212:e766:f3e4 with SMTP id o21-20020a17090ac09500b00212e766f3e4mr24574237pjs.213.1669118489479;
        Tue, 22 Nov 2022 04:01:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e7-20020aa798c7000000b0056bee23a80bsm10481421pfm.137.2022.11.22.04.01.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:01:29 -0800 (PST)
Message-ID: <637cba19.a70a0220.9e1df.0130@mx.google.com>
Date: Tue, 22 Nov 2022 04:01:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 3 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 12:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10080

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-cip70-236-g69445bc0d4209)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-236-g69445bc0d4209/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cab3f2a34f666fe2abd2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/637cab3f2a=
34f666fe2abd2d
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb25b8598eb7c102abd50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/637cb25b85=
98eb7c102abd51
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cabf5ce565e80172abcfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/637cabf5ce=
565e80172abcfc
        new failure (last pass: v4.19.265-cip85-rt27) =

 =20

