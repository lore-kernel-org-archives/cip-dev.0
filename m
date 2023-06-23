Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E686EB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 13:14:05 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.41656.1687526035821156117
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Jun 2023 06:13:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=pAVtkh/X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso276003a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Jun 2023 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687526035; x=1690118035;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IxV8o9ZJX3XTfRLJ3enDZ8bw5e93k4uT6PFP/+3YjFA=;
        b=pAVtkh/X2dmU9z9i2myxMnA0db5vmfcAFtx3WwuoAK5s1/Xmb8yFItChJTwIFRooYh
         ONLGJ4DoXLNLdxUZVGvRIywJzsz5XTEFeUXRGYiinbRuRriv2CHYAHaxhc8UNR2a9a+1
         d8tlHSok2dMCRnQ8DvXlzHGmMsOngVAE/8sA7k42DKpYH3TMpBLZfGR5zw3ZyFCz22JU
         296D2MXDp2GrwO8+EB14BSYP1p2KioxrREeATLQEdqSFBdY3qwi+z7k53QzgFonicjKF
         pcSkdkTyHuK2bJfWzmQrTN5wPRDgMZmTvRIRvr8EqFTWBVvXS3bBytL5Y9O8ae/DcMbk
         Ef/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687526035; x=1690118035;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxV8o9ZJX3XTfRLJ3enDZ8bw5e93k4uT6PFP/+3YjFA=;
        b=ljHX/xUbmA6xlDu/0dnOrgwWirV24Gs+eWHBKhh/4CEKGvJqw9zZ8rZmC+shz05Bo5
         M6kSMV5hdAbXKfWaZXYPTxJ5NHQ5gFMNukFGApEnTmVi3b03Bz2FmGCiPtOgajvl9T2D
         dydK3g2i4nkK6nMGeRLAhuXC0NN1rDoGRkSSgrGtZl7Ko/I8m/NWNSGnNrSm9ULoHzyv
         27oNH/aWfmRuJTbw0+EJohv93Gv/xdohQDXZcuxuPxpMwdckNAJANANNndwlXIEGXHGT
         Df7kSRHNYhBbv5zGSWVZ5cKOBtfsLbdk9BH/WrxxsooIEC7dUGPZAFAr7JCCYG3P2jCC
         w3Bw==
X-Gm-Message-State: AC+VfDz+SR6qh2Lx0RenyjMufuNkOoXzTnHqMxzDOtYWJi7ufgMrLcUO
	0JY4fXCMM8QX8ji4nXj3TIJW/Ajy93qDSLnUYllodg==
X-Google-Smtp-Source: ACHHUZ7WbN8MKXPKH74GQd5oh1PgambzxeH1u8F1sWwPDnqAFTYvf+YzHtgwL6iG3Mb5wotFoUyIIw==
X-Received: by 2002:a05:6a20:7489:b0:118:1a20:79ab with SMTP id p9-20020a056a20748900b001181a2079abmr22532214pzd.4.1687526034743;
        Fri, 23 Jun 2023 06:13:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902969200b001b3a21fbb4fsm7226254plp.12.2023.06.23.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:13:52 -0700 (PDT)
Message-ID: <64959a90.170a0220.1c607.0262@mx.google.com>
Date: Fri, 23 Jun 2023 06:13:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287-cip100
Subject: cip/linux-4.19.y-cip ltp-timers: 9 runs,
 2 regressions (v4.19.287-cip100)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 13:14:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12143

cip/linux-4.19.y-cip ltp-timers: 9 runs, 2 regressions (v4.19.287-cip100)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.287-cip100/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.287-cip100
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      843423b3724d762d5593ab9aaeb68ac695871b44

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64958af5fca5724f3a30613f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64958af5fca=
5724f3a306144
        failing since 209 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64958af5fca=
5724f3a306144
        failing since 209 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =20

