Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED4C433EF
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 17:14:08 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.10413.1656090847293540735
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=SA5a+dNI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id q18so2608897pld.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HN7qV6V5LGPoq/a3juuCzBoGAB30bph/k63CWZCoxis=;
        b=SA5a+dNIsLthL0Yi02v/XB2qjQuxqO6ZBd6WjQ/E9ojzWm7Ki33T9R1O8xtt08f95E
         lalBxvxsNgMppp5JQcj+AlHUNP20g0lCwVUIwB4r8vOZf4WW53XmItx5KsP+oJFxhEhk
         z37GJErPZ1RENE43v+1QaspzJiOouGvptd2AfREu5I87ZdUy9kIvpwmiL13B78FSGGY7
         D0OXIqH/bFqyKcsgTwS2uhfs12Vz5lD4Bcj7BdIm2m76gsIX6s3IAN08UOJkaSQhY1sP
         v5oOu9Our9VDHbd347WJJkzdelzkaVUdvqtT6x83Ce8wzYmVNvU7JPtlUqk76YwG9DPt
         Db0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HN7qV6V5LGPoq/a3juuCzBoGAB30bph/k63CWZCoxis=;
        b=CMF9w5/rHzFyR4TK0/yTi9obYdIrUqodGlBUC92fdIHYHqBWA0wFswUia9sEtg+5O7
         JeSSbvHSnmrOgzrLeoSkK7RcTwYsGelnKBQpgo/eqVzrGIVztPQH7VbSWKQt2Eq0rNQA
         pxGgzoBN6z6XU86arGCcDDsHlmHX9iBIXOB9u1FspcC0DVlRMaEV3/3EFPqe1wUEa2yu
         Y1mkPUyiTx2JTqrkSmNNdzT2/h8NzjDxF20it7vbm/ZLjgux3O/yVqHX6xVE82N6812W
         +d6ToqxteFbavgRvkZ7pkDsoK9qdmUJemwH3C5eUG6aBL2e0YFQwNJ4kC3klMKXMKn68
         MoKQ==
X-Gm-Message-State: AJIora9qgMLjaLrs+QnUMtoyQA10spPodfGmqu1wnOd+K1BcXm8BwwUA
	E/XmOP57uyL+Afy5MfeHHhabuKnI4wxRKWeJST8=
X-Google-Smtp-Source: 
 AGRyM1txfVeTByNhV16sRYwboomdB7ndYzqjVPI7UD/uYVcms6w7PmR5P8B1MOuGaPDOH6e3jTmg0w==
X-Received: by 2002:a17:902:da92:b0:168:f947:4fcd with SMTP id
 j18-20020a170902da9200b00168f9474fcdmr71696plx.91.1656090846499;
        Fri, 24 Jun 2022 10:14:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 17-20020a056a00073100b0051b6091c452sm1957493pfm.70.2022.06.24.10.14.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:14:05 -0700 (PDT)
Message-ID: <62b5f0dd.1c69fb81.8c8ae.2d59@mx.google.com>
Date: Fri, 24 Jun 2022 10:14:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-272-g3fb28d4c623b
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs,
 1 regressions (v5.10.121-cip9-272-g3fb28d4c623b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jun 2022 17:14:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8593

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs, 1 regr=
essions (v5.10.121-cip9-272-g3fb28d4c623b)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-272-g3fb28d4c623b/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-272-g3fb28d4c623b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3fb28d4c623b354373a844dd48f16cb4f005388e =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62b5e07e0fda546712a39bfc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220610.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62b5e07e0fda54=
6712a39bfd
        new failure (last pass: v5.10.118-465-g0af29783a3c9) =

 =20

