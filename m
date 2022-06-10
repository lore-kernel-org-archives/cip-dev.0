Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E70C43334
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 12:20:39 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web12.26196.1654863631841125478
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:20:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=5dYiN6hI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 123so14246956pgb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=R/Z8wRmeRTVbUIfE25lUaUe6oGQhcDJieqcgCSPdhHw=;
        b=5dYiN6hIMIezyqA1d190rqE/2HPuVsFFVAU2JODNtVHwnc7deQ/b6cBJ3MN+oFBX+j
         kWmNdz9qXZYUPiae+GGSVgr4B78LCJTTGm3IOMHheYx/MB7VxaXBdPBozNOMRTqms4Xz
         E+HHjzO9efHLxqOmYwcDghEzfg/3RHIXUFhfOtecB8EMotkYEf7Bf7WEtmiDZer0KM8/
         fJpInAO1JZWuEvyYpahecJAsVfLF9rsdHAhRvLyJHkD9SGImYkdtSVprS851kiKAk6H/
         A/YoTVQVlPHdcct8XP37Y9ewImAVksEQVLOAxDIqqfQlNXDxXIbn3Mv9AZQEfIMNHV62
         Jn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=R/Z8wRmeRTVbUIfE25lUaUe6oGQhcDJieqcgCSPdhHw=;
        b=FHXfZvyG+ULXmyEzYkTQZPprCV0669NXWFPQ85cuxQSKqsfxlsHetF4mhSCc8f7dLd
         6kAFBHdG/kE2bPabnx1k/91HVeEQP1VY9FKixWfltrL1XlemN+8xDj1VKIvfyB+b7GJf
         UOKrsUNVFD2+AZpZH0YBqAeAT4V21og0V4RLP53I5F8NwHUwD7KLDU29cyqj8iCjH2Z8
         vV9Ba+JKS1tF5HDhzO8bu4xz2CaKMJUFjI0Q1RQuTINrbOTiMvUUT7Ediu1XIKyhPTdD
         9iIpeB+l1tdpwlL39AfGKA6DmmjzfUCOuT+FS9SPMRH/7U6wM7zbCob1eb8cZS/5JZNZ
         WWSA==
X-Gm-Message-State: AOAM531BvH3vKNjvblWrB9ypixtyloE1bhPaYnMoV6UX2lVXVbNqMg7/
	c1WrOiXsQKROwXGhT5K/N4PRGECwQrR+iiK//z8=
X-Google-Smtp-Source: 
 ABdhPJz5+5NOGwC8Ui5I12s+FHcOCMGm7ngsQkikwppGBUSt9HGch7WqVYQxU5aQ0FVp5EUwZMVVDw==
X-Received: by 2002:a63:84c3:0:b0:3fc:8c46:2447 with SMTP id
 k186-20020a6384c3000000b003fc8c462447mr38808883pgd.285.1654863631261;
        Fri, 10 Jun 2022 05:20:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 jh13-20020a170903328d00b0015eab1b097dsm18682563plb.22.2022.06.10.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 05:20:30 -0700 (PDT)
Message-ID: <62a3370e.1c69fb81.f268b.3dee@mx.google.com>
Date: Fri, 10 Jun 2022 05:20:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.246-cip75
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-pty: 5 runs, 1 regressions (v4.19.246-cip75)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 12:20:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8539

cip/linux-4.19.y-cip ltp-pty: 5 runs, 1 regressions (v4.19.246-cip75)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.246-cip75/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.246-cip75
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      38ce181ac6ca9f3decdd389cbfd0a38fecdb28c7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  aa0d8ff94a7df8b63b81f185b261bc9f24bf36fc =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a331f87d0dc1dacea39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220603.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62a331f87d0dc1dacea39b=
d0
        failing since 73 days (last pass: v4.19.229-cip67, first fail: v4.1=
9.235-cip70) =

 =20

