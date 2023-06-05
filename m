Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7680C7EE2F
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 18:37:44 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web10.16986.1685990257533908795
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 11:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=EOMPBuBP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-53482b44007so2690303a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685990256; x=1688582256;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MFQy9ylmoqyvFCy/keta4utFmwuc9dTuFUfg60zBKuQ=;
        b=EOMPBuBPXe9ljYAP2kitx34ksGf7we9Qlaicv2KhC7BK/VkdLa9gyc2n+8xfGPaxxD
         7HohAYNVfeN2NTl3KRrzm7NCAOIraecpBKBB8kCcszeeM2L4X9sXQQO8agGTgrnymNvP
         9VM3NddMIY6Bwn2JarnGhMI5npqcdDYYSWQv9BTYuhNn+RUe9Rb0tSmPfnV9J6rXDmlP
         Gw1WfZR9NoWqgX4ayckVP7UYTaTFLL2WXH4aTQLN+P/PTGWPkqHjAA3sQDaolbb9O9Ez
         lPa1SGUSbWTeLSzUm+Dihj/gNwED0AvztjArcV3sebXiB4babr+60d1ePJFiUgP4Jtl8
         ZmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990256; x=1688582256;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFQy9ylmoqyvFCy/keta4utFmwuc9dTuFUfg60zBKuQ=;
        b=kuxP3wQ+gbyTG33kpCDQVNkafOTm560LlbDPwqgdLQD9W+KYE1nfqXl9MvbmqhaIFf
         r0d8G/u/l52ovTJ5LILZnyAR4OT5wY3rXOqI8FTSupWsAtI+Or2gbv66mvlMu9NT98R1
         m22McbHtK/quwhhBrWw1PWqNz2DyHnLlFR6rViRVp6UpSxc5QIVGqIr3F8ENBOjQFy2t
         hlSVGKYknDC+2AM4jaLaBOqNYDojSP2dgDlp6vdIyT9MRcWlXYEjFWcnFXOj/TQfHpGC
         YZ8xTLKzU3DfJL50+tbcoQJQ2yX0U9rLX0QXTBVctWZqp5qHdfVdicK54AjzT1Opb+Kl
         GzCw==
X-Gm-Message-State: AC+VfDxfF99qOdNvfJLTfvRM+omBSHdCqRtbmZQ51A8jJRC8Qg3A7jLo
	WnbGZbihW0lla6nG9l+u+kwcqKzE4BT2ilh8nFRooA==
X-Google-Smtp-Source: ACHHUZ6kP8XC/wi9NSLwy/mRVK+LIimy7EM7VNpWDKvZvJTO4NQMKjVob3Lm0Eo9tyohLv6Nms5ZUQ==
X-Received: by 2002:a17:902:b211:b0:1b2:1b22:165 with SMTP id t17-20020a170902b21100b001b21b220165mr1330116plr.52.1685990256148;
        Mon, 05 Jun 2023 11:37:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b001b016313b1dsm6922045plf.86.2023.06.05.11.37.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:37:35 -0700 (PDT)
Message-ID: <647e2b6f.170a0220.d433c.c7b2@mx.google.com>
Date: Mon, 05 Jun 2023 11:37:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-gc198172c84b6a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 11 runs,
 1 regressions (v5.10.180-cip34-26-gc198172c84b6a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 18:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11819

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 11 runs, 1 regressions =
(v5.10.180-cip34-26-gc198172c84b6a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip34-26-gc198172c84b6a/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip34-26-gc198172c84b6a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c198172c84b6a9338925de15df053d71eda6a6cc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1ce8f8a0b91fe2f5de2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/647e1ce8f8=
a0b91fe2f5de2c
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

