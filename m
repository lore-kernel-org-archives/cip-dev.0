Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A9C7EE45
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 18:39:34 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.2433.1686335971917352012
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 11:39:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ZzWLLYNn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b0424c5137so10419325ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686335971; x=1688927971;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/0pENo16nw5m48KUPaf/K83WZzdxig13seeiVqYydjs=;
        b=ZzWLLYNnx0xK7ZHyiS7mSz5/IQfhoSToABjGC3oj0YFB03Y1OZPoDTR0EgTm+TA/Qe
         LFVQORglaFfJHRwaLonWCvSFmb4jxQ4pbs8nVP/sY2YIjmk/ENUYPZwsy4eiDKSPS8BA
         75W7HMu5CiN377LULzceVFnbOGdzuHOjzF+coFX70V3SMLi1qYtiBfFdR9nnY2XqtRiH
         DCKjDUymvWXG+Xl5lUt7sBooL6NFhSFh9lVnVObJMWUfpiYYj9TBVCREvD5Hub8ETsaX
         3e2wOAu51r+Tp2Q1VbNi7EbQzltOk3D2c1KIchJY/zBHi4p4eh1CeAoFJqWF/Eo2ZbyK
         xx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335971; x=1688927971;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0pENo16nw5m48KUPaf/K83WZzdxig13seeiVqYydjs=;
        b=PF8sLxxXsLccpwVjIpE7V5GnRCJ/AQdJp9iXpLeaISicxVcnm56tqplCjbfr8O4DzA
         rD49JVLslMbNI2JUTyGGnF7JBdfUEmGyzRUXxOW6VXh+p1spbhYrafOD0eFS7gg5ZhkV
         OGkNaB3tGHKrwaMfLIzYvLUuDcK6/rRKF/Fmj+D/VdXolg6aS2Kpvbby7C9d3s0a9k/0
         /2jfcwtKAl6xQJw+NNLRuRotmA2eHX4dAsIBoi+2QyNFT6PaGXkPWjufNcW5ZPIP3sul
         xnrJoUznzYpSRt9AIaXCiNVcm9JV6lfW2VqrIYGoWAhih5meh0sU3T7bNthl90kQoiJt
         UDjw==
X-Gm-Message-State: AC+VfDxL6g+tuT30ncgEw8Oxt0FIWZx1L8UFIh1AxDRKkGjqSnLRFqci
	mvEuEd80BVeqjm3dd46xNZfAUwI9AnnGQqBjT23eSw==
X-Google-Smtp-Source: ACHHUZ6iCb7a9YGQiiRs9B6luEUJqVR5UnXwDT7K6WyCjn6xJAPAUs6hAIN6tV5NuJlwBKzNnOxu+w==
X-Received: by 2002:a17:902:b58f:b0:1b1:a9e7:5d4b with SMTP id a15-20020a170902b58f00b001b1a9e75d4bmr1787944pls.22.1686335970828;
        Fri, 09 Jun 2023 11:39:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903244e00b001a9bcedd598sm3599797pls.11.2023.06.09.11.39.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:39:28 -0700 (PDT)
Message-ID: <648371e0.170a0220.8ded.7d5e@mx.google.com>
Date: Fri, 09 Jun 2023 11:39:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-1248-gcaf6e8ee921e9
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs,
 1 regressions (v4.19.283-cip98-1248-gcaf6e8ee921e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 18:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11957

cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs, 1 regressions (v4.19.283-ci=
p98-1248-gcaf6e8ee921e9)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.283-cip98-1248-gcaf6e8ee921e9/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.283-cip98-1248-gcaf6e8ee921e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      caf6e8ee921e9e7714b8669fc9187fcd56d5a5e6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64836c306409fa67f030613f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64836c306409fa67f03061=
40
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =20

