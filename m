Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A62EB64D8
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 20:03:29 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.99.1687377809058084015
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 13:03:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=FDty7Xtg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b512309d18so33637025ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687377808; x=1689969808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6s04+SncvcLwuP/9N6tLj2wAIPwolF0yokmfPX1Po3c=;
        b=FDty7XtgsdeHGdEKfv/6XNo7Jc3kzA3HtZR5P3mWhxsZULGwDDOSNSHFMSjeqsnkUs
         Q0TGO6/X7eVbbKd7x2C1uvfKZZOAnNm4+GFWEuU2BiINWJqlz+GMUIBUULPSrgo6EDV2
         t+RA+4us+mN3i4VEeDH4nwtDmSTMFzdi9+zSDgRYqcqgmhyv0VmBm9+SaOMcxYGUlqvm
         ngNUwXq+eOYBiUe6jtMAiE3K/r78dzmnfgedkql2g/OBUOrL5AlXs9k2Y2fGzaI9Cycz
         Cs6zxdcgFxHVsIEJj50YB9Jii5bK75aAIp7Kl9vINbVNTAU6OzS+GVBNUR7BMrS1Jm2+
         iflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377808; x=1689969808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6s04+SncvcLwuP/9N6tLj2wAIPwolF0yokmfPX1Po3c=;
        b=f5lJ2T8UtzuNcAzqsCAUzYRBkgJc3LeJB4dCt9JpWMSuAULaWHMqh9VKMAFZOHa+vg
         3tpLxeYBye6bqtlq9MOBo97asoOFBjHR3O585mLdEmR7MocPiTlHAAFqfzt1Ru9b4x2J
         xdAzBBvedhTbjGvxdsK+cxX9yyew0sILCkPgv7Fg9ioEOrR9gSS0kz+oFxA9R/JMMfBd
         23Rf2S/1uuICqTtOlMPrH9H5uUHrsnSKQIOo3sIDJ3k8wWfdZTv9uSIp4I7yQhd85V6o
         dOP1dQPx9U4g6wNF0qT0+DMFM064yIU4vzcNh6uKESkXzx4DV4C0f6QZo2Ks11OSc4X8
         09ow==
X-Gm-Message-State: AC+VfDwm9yIogFHlbz5I8xWx0UQJE4iQa6mAMfS+h7E1yzbivV+o7NX4
	thnMUTgZpqJH1SDukHBptqS0b05vDkCSxN+mpyQw8Q==
X-Google-Smtp-Source: ACHHUZ6mZFdYbA60rNmGJ8vpt5U1Vd6/AoeQJ9IJAWeOuYxMTk9nElnFBE8Cws9Wsmg9uaLZrd2LNw==
X-Received: by 2002:a17:902:ea8a:b0:1b2:5ade:9ebb with SMTP id x10-20020a170902ea8a00b001b25ade9ebbmr10419755plb.2.1687377808129;
        Wed, 21 Jun 2023 13:03:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001b50cbc0b4fsm3886214plb.111.2023.06.21.13.03.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Message-ID: <6493578f.170a0220.f7bdf.9531@mx.google.com>
Date: Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 1 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 20:03:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12098

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 1 =
regressions (v5.10.182-cip35-289-g3c0549540706)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/649350fecafd51f7bc30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/649350feca=
fd51f7bc30612f
        new failure (last pass: v5.10.182-cip35-191-gf4efde512959) =

 =20

