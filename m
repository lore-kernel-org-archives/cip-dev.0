Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A74C7EE23
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 12:16:36 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.15597.1684412191162905590
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 05:16:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=1uvZyYm6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-643990c5319so1408827b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684412190; x=1687004190;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xTdMU+8F6XFvlC4vfIUMgoJWvCnN916V3jFiwMR5p7Y=;
        b=1uvZyYm6qoRPSDcK+PMfaSJikdt57N47j5LTJJAHJXbLbksiZdbr7Jq6/xEtG/Zcj7
         df1NhsDEd4EyDWa7mYhjkaqq6crto78rbYVFo5StZvKBkRYoGmSnz2qE5VxgqEQm++7T
         5ezTd1UfqpebL9WAwb0/jtufrUcI3b94fByX//7NFI/9qh9gMzS/f+t+sUs5lo4dTPW0
         TDNjwxuq9DzvxVxQoPFj1igbf3ZtNHNfMSHOr+wBi8kahG8IVCuTNaHxeZEv1xiyVB1S
         KPN6WWtseGgH1Ej7iapIstZDaPs2iEs3tjeue8J94hWUrr/lzJNtkmmgoD/2iW6JbfCh
         BreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684412190; x=1687004190;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTdMU+8F6XFvlC4vfIUMgoJWvCnN916V3jFiwMR5p7Y=;
        b=ZpuwzCfEJWTou4OTewGO6B1AJCVl3H890VACQ73xa0FcReUT/tSZvkSZWEHglOmifn
         mPn5k8TL+vSTy8umTScR4LhGyZ38qYvzwoTPoTu3manNS/6RCP3Qi/8Jal5zM7+tuw8X
         8kn4sOIRVO7RcwgTIUTvTBOoY3yRdSgSr+WeVgLhcq1LlwjdWXab/VJkekoCy+3WpqlZ
         +gjM7O74VzdGL2pOxX60FMquT/+hHUrcyKrTZRx1jBnHUnG7kSX3IPAuk01KcSJJ7FCp
         PJ0lHBb5X8wW319tjJy8t6242Q/0P5gSz7FsWbHIUW/JeQnXyhwzVoeYt6P1qA6BG6Rh
         fxOg==
X-Gm-Message-State: AC+VfDx865YH516Y6sHuMNwfGaQuhl+/n3+/lAn1wkJHKTH9pP7UtD1f
	8kGngtT60hPtDA4ebt0TY0zQL4f8b4Sb73lCDmKfXQ==
X-Google-Smtp-Source: ACHHUZ4pTrZo6u+lhWfNDXykk0HL5JF+yUDyRLPPW4qmJ/0UIcabeyyiJNaCSazezyyubJojhqhVoQ==
X-Received: by 2002:a17:902:eccd:b0:1a6:f93a:a135 with SMTP id a13-20020a170902eccd00b001a6f93aa135mr2369489plh.61.1684412190175;
        Thu, 18 May 2023 05:16:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001ae5d21e95csm1290908plw.117.2023.05.18.05.16.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:16:29 -0700 (PDT)
Message-ID: <6466171d.170a0220.1af0f.1d67@mx.google.com>
Date: Thu, 18 May 2023 05:16:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-471-g18129e1b68691
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 11 runs,
 1 regressions (v5.10.179-cip32-471-g18129e1b68691)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 12:16:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11519

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 11 runs, 1 regressions =
(v5.10.179-cip32-471-g18129e1b68691)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-471-g18129e1b68691/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-471-g18129e1b68691
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18129e1b6869127ae39e5978bb2fe70ecd53f174

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/646607efb28561c9802e8651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-broonie/ltp-=
fcntl-locktests-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-broonie/ltp-=
fcntl-locktests-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/646607efb2=
8561c9802e8652
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae) =

 =20

