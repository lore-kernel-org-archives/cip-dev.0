Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DA0EB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:16:45 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.11404.1686748602735164297
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=lHQlqjQF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6664e4d8fb4so460065b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686748602; x=1689340602;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DL/b5+3q8MO4DYnWnDPGVC8wf5VJrcpZSBATlO92lI4=;
        b=lHQlqjQFAhl1x/Bz80phgo5Svuwvc2s5Fc/6vc0HDK0r0B1dBlpe204VvHpZ4bVpef
         k/KyS5UunHxrAslDnmkfG2wCZEbVKcyojub7ilKui1KlY9GumthbSBD0It0+u/0UXyRE
         /TSeM9qFJlFlEUaJ/42g37FAmETFCjgyxwYPvyJEXg2CrBV14uKTIiPN+NQl+vB21aRf
         +bqwy5JuDInT8ppibY4v250HfUncULTJt8faKGsUcqnz74WgSqKJMg23rZ3/gZtcEXZA
         2SWOKurvcDcw4gbE3sYFzNzr/+TE1yXZSqI9v9yx0KGnk84QmtZ+SjUFpvSZEQsrXsqP
         p9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748602; x=1689340602;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DL/b5+3q8MO4DYnWnDPGVC8wf5VJrcpZSBATlO92lI4=;
        b=VCrXpgbSyU2AUC7nutklC4aQ3f6V8SKY4hPUhIK3jk+sZL1kqk7ZIETDVIY6XBg580
         Mz90GTLwIfG6b7oVubFbvaAughLgdc+WLePC3c6wkUIBrRIXlDLCbuN5Vs7wM+NgRl7j
         WvbVYKpfUhoKg2EzS/Ybm4KoVw7P0GIiN0c31brdZw7ncCmP26SjtXUBzDgMwPrVdMe4
         rk2ZzegDR8sKOQDiDauf1zuUG1ICZlb4seEyHhZ4BZ+iU4ncp6kUZ58bEzKlq/QZpuBB
         x1/6hpX7Ow4+yyQtMX/47b194L5wqGbY6dym042v8oYDassRo7eOi0vjX5HXQ/2dg4zq
         7dMw==
X-Gm-Message-State: AC+VfDylLm+Gbqr3H5bz7njQaij3GI5Yw9qKe+oH6gNzGzsoyrdl/vEr
	Fun3u9wH/h3+5TaMTpUbROV5wYe9JO6PzkYv0/YFOQ==
X-Google-Smtp-Source: ACHHUZ7zWD3uXbzXMTI63XafcFTnJ0SigC59PF96u5+5vLeOHBW24d+q7ENGa7rdvpm3tLzq5tT82Q==
X-Received: by 2002:a05:6a20:4320:b0:106:25b3:2f92 with SMTP id h32-20020a056a20432000b0010625b32f92mr1452280pzk.52.1686748601570;
        Wed, 14 Jun 2023 06:16:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b00634b91326a9sm3096714pfn.143.2023.06.14.06.16.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:16:41 -0700 (PDT)
Message-ID: <6489bdb9.a70a0220.770c.5b6f@mx.google.com>
Date: Wed, 14 Jun 2023 06:16:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.284-cip99-114-g02e97826987bf
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 7 runs,
 1 regressions (v4.19.284-cip99-114-g02e97826987bf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12022

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 7 runs, 1 regre=
ssions (v4.19.284-cip99-114-g02e97826987bf)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.284-cip99-114-g02e97826987bf/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.284-cip99-114-g02e97826987bf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02e97826987bf9401c9a3fb9d2d52ab90340ea1d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b4c79fa3fb888c30615c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020=
-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020=
-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6489b4c79fa3fb=
888c30615d
        new failure (last pass: v4.19.283-cip98-224-g5f5303d7920a9) =

 =20

