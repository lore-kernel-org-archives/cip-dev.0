Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA1EC4829A
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 16:07:58 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.66467.1707149273470286388
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 08:07:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VfZha3pG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8ef977f1eso34253565ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707149272; x=1707754072; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kvZPtZfaCtpx8T8+bntYaFtoOLHd6/NzO8QSdLsjhIs=;
        b=VfZha3pGElWSiMd6E9N/aQ66fEMFJnEKDHuMCebx+wyMY1gD/V+IhJIr6cIdLNYAAE
         s6SIljwuGfLP3ceWVipgkz9DJY6SIic8XAAMtSZtDr9KpklcyxofEH+pR3/jxa6D2BEw
         3pEcNbSPhvZ6SyUGMdl4RgRIpt4z3QMYUHlzu/ApK4eV+mmXRCEG81T3xmWS4z4JKZuL
         7cgnvFxfDUSqi4UZmFqfIGv+qvbhpIn/pPYi89ac6W2KffJdcomQNmcbQ7Gyuh9z//U4
         T8lCKiEv2Y7Re2BjQVGmGl6YVgLc+jkIy0Pn7DpcqbJSBv2tYeCwvjTpvH6B7DS1e5Ip
         eiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149272; x=1707754072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvZPtZfaCtpx8T8+bntYaFtoOLHd6/NzO8QSdLsjhIs=;
        b=gGbmmWn7k1e47KQcjKzU7A6aBIXMjNIt+eZTs6c372VIpCxeeXyUL0I2UodoOwBMAd
         mTAfxkG15IqdgTTi8VLl9Nu+MvBhkFEmFrd5HrfpLo7EKmJ6lzWXPyrQYErbCUmELuxW
         BzXDiF1Wt+yzo1hROuXS02a/xPfm61Fnfdtr71q96T/EiaqiKYdjqWcT6+VBDqNLUjf8
         hTxwcxad8CTxO7F98A4RjZFlYsPtT66UOvPTbbcMUqU4wBM/NWJWB6xDsdOXLvGltWPs
         sO4RtfnKMWr1t7IYC1n3BYXa2Pe8xcKt9L8vctJNjkjXiE5/2p3STtq9LNSiMm173fnn
         RYCQ==
X-Gm-Message-State: AOJu0YxVyLaTE3FcjcG+4o6X/dpMchHyZ0XXdwiXmPRMTp/jlm+48v3F
	PmePwAKLOvP5n5iQI1ukVZt6wTf8pAc9C0qi+GedFjG2mJ68ZxzTqOSKUCCA38VBljipSQRXi8I
	j
X-Google-Smtp-Source: AGHT+IG0M9L1PkpBVNQwNlk78eh1hg1J8g5/IiyDNWQ9IcTLwROriu6TYYWtNH9zl7+KYq6qhkIq/g==
X-Received: by 2002:a17:902:aa85:b0:1d9:63a3:e962 with SMTP id d5-20020a170902aa8500b001d963a3e962mr8793754plr.6.1707149272213;
        Mon, 05 Feb 2024 08:07:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jg17-20020a17090326d100b001d94c01ae96sm41302plb.66.2024.02.05.08.07.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Message-ID: <65c107d7.170a0220.ffef3.0611@mx.google.com>
Date: Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs,
 2 regressions (v5.10.209-cip44-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 16:07:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14736

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs, 2 regressions =
(v5.10.209-cip44-rebase)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-rebase/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      17e47f846f71ff31baabe74a720660536794686d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f0c2c3c8db49d500a04b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-fcntl-locktests-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-fcntl-locktests-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c0f0c2c3=
c8db49d500a04c
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f721772aab545500a045

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c0f72177=
2aab545500a046
        failing since 1 day (last pass: v4.19.299-cip105-1134-gc868d5e4adaa=
, first fail: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =20

