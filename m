Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F061C05027
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:48:25 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.12621.1676029702297457181
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:48:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=iYVvQm6h;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so5290178pjw.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5JGdboVNzS6QFUCaLAiewdboVAOYEckl8g07XBI+XK0=;
        b=iYVvQm6hhkDJTG+s4eqswdy99y1wc5H4V1UC1+DApYEz+9qAH4bVHr0hdKkFBxzMMS
         i7G8cKVQvgHxLi6nZN/uNB6/+7e2TquGALk0/FiFI7peDSpMT9w1fu6PYi1CTSomTloU
         eRC7j857R0pxt1UuT314+VYDUiQbM8OPIUtakKgp6kfix7HBOfgSboqjr0KGKssWHl6Z
         zlJhWxCG42kp7yz0r1xEoLvneFxO2XvCengWFep23u7oAZad0XrRHZZ0oeH61HjtPeCi
         L9Ew1xoRhD2nQSL40l8r1G8X2tErziA9bq3vzbJeNxKaZeINSMdvjGxQE4PB3yV8jGpQ
         diMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JGdboVNzS6QFUCaLAiewdboVAOYEckl8g07XBI+XK0=;
        b=7XHJyUc9m3W2eWXLAuMUERhUDCzOs8KSekCb8BMnPlWAq6vbHhcKtLQMoq6W6KzwML
         ZRi35w7ZrhLImezI2eDXK/Z88Mc+QWdfEEV812X5NqUXiH1hlTETlXzAMUv824jaIgpH
         zGFOA04hKX6ly362I6Cd9qUGQHDv5nGyLPDHUGeOarVZZVuGUpghxgEAohSVuuYZcEnP
         xH0hGHMAaVkz7NhppNPd9DeDDvYA7o2H53Q6eKyxiT+GiqIYMMgGGdo+mJzkOaiUiy1w
         uHqD3N7cqde50xwOOVkAJsLm39G81bMq9kvqoC0Pc067HeNX9qBQ8ZzFHty14CpHN1mz
         hjKw==
X-Gm-Message-State: AO0yUKU73je3apeNJ72e8iE+uqzsHLhrpd596wYS7h9qSQDjEyDbrdKN
	cDP0q7rVqyB8mmITS3wli6DfxBquRfT80uIXcMo=
X-Google-Smtp-Source: AK7set/UA9kBw6zB/UoDto6ldQLg14jwrCIkq+mN98zjxK3H/uPwrmRoJ4t3RCXr3k6oCSn1FtsAWQ==
X-Received: by 2002:a17:902:ce83:b0:196:11b1:101d with SMTP id f3-20020a170902ce8300b0019611b1101dmr15982441plg.28.1676029701194;
        Fri, 10 Feb 2023 03:48:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f22-20020a170902ab9600b0019a7385079esm1111348plr.123.2023.02.10.03.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:48:20 -0800 (PST)
Message-ID: <63e62f04.170a0220.b8948.1ba3@mx.google.com>
Date: Fri, 10 Feb 2023 03:48:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.272-cip91
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-mm: 3 runs, 1 regressions (v4.19.272-cip91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:48:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10646

cip/linux-4.19.y-cip ltp-mm: 3 runs, 1 regressions (v4.19.272-cip91)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.272-cip91/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.272-cip91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a308535fd0f82d23c6acc4bb20c69066ca01bdd6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  7b5ee038995273bcb614321dd1112311e3b7e8eb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63e627af8f8a11ec8a8c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63e627af8f8a11ec8a8c8649
        failing since 391 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

