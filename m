Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A24C7EE24
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:59:24 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.261.1686009564483335732
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:59:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=r/6X1hjb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2773550a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686009563; x=1688601563;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f75uwroFjCWw1RJqTOZhW54ZAaHJ8vG5VEqEGP6wKqs=;
        b=r/6X1hjbU5AhnUGqDeypvQA1sxQKLhexrrMFYGWyjDp7fq1RDttgbMbdwTZaheBVvD
         pRL8jvilYcRFuoG1sUvVLW6spKzlphwUwWudQZYl1k5WLtS0sYKv0lFMNMLMJvcsmWAC
         VXNkL33X6NJGIYDjwPvPrjYzKhKFEI5B8i8hB81nN7R96T5cMauUDmWLsLUtAzxA4t+j
         3REgSCGZATc7Opqa83NXxxhzme2cCVTci401cKBNsGdCyp+XzeQWeDAn7AofOQnSZVUI
         BfS26F6lKE2SOPG7ONNs7mw1gB8pkHhzlSWfLY+ASx7y3o5yOQLsoT6OfwNgfuCM6DoX
         w+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009563; x=1688601563;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f75uwroFjCWw1RJqTOZhW54ZAaHJ8vG5VEqEGP6wKqs=;
        b=KT6n3vkJ2/uIFsUW6nNrPFk0/E2zL86Byd9cgwrsncRlBPF9EsqmlE2Ulwxh17gF64
         F0bGxl0vS2ak6amftsqlV8rMxPCLGL5R15JAouJS6SxLcJZmnvBP+lhM8CJ71wQ/jPUn
         HVm4+gHubFWmW7JOSS4VPJjcnkk7Xo0MhNy2gdDhqVSK6PWJ79V7/4CHVvCSjsQ4Se/S
         Os6jX9xtg1JugSoQr3z7hgF74LvHUp4vXIfYEaKcYMy5WPO5KRJGikjWF8hNW0mwhKZ3
         7j1zm/tyyeuLc44/n7btxnT/yBoEukmOiZFExKTTKR7SdXLH2ZHluCONUV9JPzvHG157
         8WcQ==
X-Gm-Message-State: AC+VfDwNQUE4I5m8rrV+tnQw1hciiQfNacu1mC01QYn64msCczUGWv2h
	18Y5TA1/D6VjYECKfB91By+Sf7r63RTuHnmWrI8hfw==
X-Google-Smtp-Source: ACHHUZ7bboKZjxz+EXsw7Fm+YQ9MdndDP7N+e6uMrsph3omv8oDg3yq5kjZOWPrmxhgLSAF6qoDeIg==
X-Received: by 2002:a05:6a20:1583:b0:114:7637:3459 with SMTP id h3-20020a056a20158300b0011476373459mr574014pzj.4.1686009563382;
        Mon, 05 Jun 2023 16:59:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d70400b001a95f632340sm7127684ply.46.2023.06.05.16.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:59:22 -0700 (PDT)
Message-ID: <647e76da.170a0220.8bf3c.ceca@mx.google.com>
Date: Mon, 05 Jun 2023 16:59:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip ltp-pty: 9 runs,
 1 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11834

cip/linux-6.1.y-cip ltp-pty: 9 runs, 1 regressions (v6.1.26-1314-g1ab0ac1d7=
e2e3)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.26-1314-g1ab0ac1d7e2e3/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e717d554ad9526df5de4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp=
-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp=
-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/647e717d554ad9526df5de=
4d
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

