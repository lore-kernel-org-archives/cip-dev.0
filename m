Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD975C7EE32
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 18:37:44 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.17020.1685990259350445652
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 11:37:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=1OO5NNZZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso2911632b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685990258; x=1688582258;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjda7GYIJ+A0CNpj9cwAGx52snAjCUNgV7/HkTQSA60=;
        b=1OO5NNZZcbWPg7ltXzxp3kJq1K/Kx7RAJF8++JRlo2hM88fJpx7YP9y1UT7x2CYH4B
         ub0iMfrygeAInZFvH6W6CBDJlURZBF8ycb0km4KNJU5EAzIQP3YMKdLKrb8efOMw56mb
         Sscdy4mA+YN5prQGm3R0Oxs/AtK80KYmAmUZe6S6DzHdmhTCtEN2h59r3A1HdPKOAZD1
         u/R+YnZoVzN3PDKSMBIgtP7QsihfsojwhUU0v9/iVZ9dAW9v21uxSwcINrm7oB4Lw1CH
         vQqWfKXQSMjWBRAGFcOPEncf8qlXLPicOqtSdItlK6cudJwp/n+D/nBWI466qHwFNQGv
         xgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990258; x=1688582258;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zjda7GYIJ+A0CNpj9cwAGx52snAjCUNgV7/HkTQSA60=;
        b=OSeKGuZbfgfy81noi5xAf0SH7SPZ/6sXqAsWkX7Ensc/0MboHduxeAO6dMiStHRVYr
         8mJ1tsGYC+tjuAB004O5sojo7YRi9esSH4o12hPdoPfSi10+0ZPQd2JYGu+LKlQoPLvT
         O2U6V9uSaovK/mADktScEgfHBGlWtjd18vCOxFQN5YkDKGAjFvWHRZAtQBco0pfHVNOd
         5KpVysz/ed35M4ROG4BICTc1lNKgbfxQuXU59mp5R7iqoBesPKwhF+OYwi0sVv6exvj5
         ZOzr7/mG8Uc1+Djou+Y9kXY7P9xH1PVlDbfiSFsZtcugsPTwY+HyCojMtLJUm05rlCjG
         h89Q==
X-Gm-Message-State: AC+VfDwTn5oLbBQM4pOsg9B6PRagGPE4invdsZkAyDL84MOpcH62qflY
	heiEMWNZRbI07Dl+OstxnBwGcP/10jaNM7bXU1yFQg==
X-Google-Smtp-Source: ACHHUZ6odULvTjgWDqsIbj+hgthGzxR2p1Z5wMNHm3oK18vMm1nVyhcnc7pdHpGZpOpjMcLMvBOjLQ==
X-Received: by 2002:a05:6a20:7493:b0:10c:7c72:bdf9 with SMTP id p19-20020a056a20749300b0010c7c72bdf9mr4845321pzd.29.1685990258291;
        Mon, 05 Jun 2023 11:37:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b00659edece5dasm2384536pfn.49.2023.06.05.11.37.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:37:37 -0700 (PDT)
Message-ID: <647e2b71.a70a0220.f97db.40b3@mx.google.com>
Date: Mon, 05 Jun 2023 11:37:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-gc198172c84b6a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs,
 1 regressions (v5.10.180-cip34-26-gc198172c84b6a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 18:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11821

cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs, 1 regressions (v5.10.180-c=
ip34-26-gc198172c84b6a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip34-26-gc198172c84b6a/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/647e1e50c496a392a0f5de2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-pty-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-pty-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/647e1e50c496a392a0f5de=
2c
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

