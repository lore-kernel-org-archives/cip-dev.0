Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BDDCCA482
	for <webhook@archiver.kernel.org>; Sat,  9 Jul 2022 00:27:43 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web08.1704.1657326459695029528
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 17:27:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=N101YVf+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id o18so257383pgu.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=p+3MznC3YimwS4CT1X9WRRETPdgLVCRJsjb2P/MMVxA=;
        b=N101YVf+6CXQxT0l1sPKLKcrEoCofwzxeBZZ5h1kyIsYp2Wp/iaogRc7CtaBDuAhRu
         MEoIdJM4IyQ3AVj9AU8VKJl2TN3XNkhUSy2VflR+gO1E2baRdD/CHGfcqFr4wsEqo+Po
         qRQzckIdlfpMOJutKwG/Q4soMxKh1QSdE8XIGrzKJZCCtA1jxs4qg7ojZd3VzYkHb0h9
         tux7NcFoOoGL3sv8atztWrR6m4vasjrA81klI7k2cTz9LelZRUMewMJ01sR8mk45n8R6
         91QixIhMqpv+c0HUWhjtaRrnSgneuT6ilId/CaKGr7egh4Bhor+g1kOfxSB4YSs1MYDY
         ztRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=p+3MznC3YimwS4CT1X9WRRETPdgLVCRJsjb2P/MMVxA=;
        b=Nxkc3yv1lDG0N+cinNM8TTeMUJs0M4oysht8waCRePYrvfpJtlyF0Sp+PtHW+/qtlB
         mc1AdhjyMP9SWKtZIOh5wD4RkasBBTsyDn8cIIhfZssCB/OWe3qoeaGT7Kl+Otk4s9RM
         60gpHpE4QjNuqRiqL4oCxH0GzBURVt29RCPAPsSYMQA3Kh0aK9sxz0WW2VqkwuvMPg0h
         y8pqodE4+NBOLbcRbBBQhyh0yUylg32jBllRL1bJpvMyCUPxyXzQmkpUbNhQVglKWcvg
         UJGNovVsUi0A8FUP+TRxQbFhEbRFV/nO5GXvcgi6sCBAd6VSH5QwMc0roqtgfY5EpqAg
         IPtg==
X-Gm-Message-State: AJIora/nC5ctAPz2hL+eFOyjIGnBoQYdHhBwVbtYGcuyzFkFGbtMJ73a
	1gNntlqzagOKM5mZwmIA+yMR1Ezibj2TkMQR
X-Google-Smtp-Source: 
 AGRyM1uCON+mJyW1W8lGN2aKYAREJVTGdldxPrXtRC2zxWUjL7xXinQqOOLg4VpdkCzxD1mF7RbXAg==
X-Received: by 2002:a63:2bc1:0:b0:412:706e:73ad with SMTP id
 r184-20020a632bc1000000b00412706e73admr5303231pgr.488.1657326459128;
        Fri, 08 Jul 2022 17:27:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a4-20020aa795a4000000b00529cbfc8b38sm161865pfk.191.2022.07.08.17.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:27:38 -0700 (PDT)
Message-ID: <62c8cb7a.1c69fb81.2aa34.0542@mx.google.com>
Date: Fri, 08 Jul 2022 17:27:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-futex: 10 runs,
 1 regressions (v5.10.129-cip12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 09 Jul 2022 00:27:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8736

cip/linux-5.10.y-cip kselftest-futex: 10 runs, 1 regressions (v5.10.129-cip=
12)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      19dd4538e81e4019bc96ac6521af3a4ec93e110c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62c8bbcf0f02c02a56a39bf0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-gxl-s905x-=
libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-gxl-s905x-=
libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c8bbcf0f02c0=
2a56a39bf1
        new failure (last pass: v5.10.126-cip11) =

 =20

