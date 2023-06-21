Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7573BEB64DD
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 20:03:29 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.97.1687377807822670557
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 13:03:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Kft9gG/c;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b55bc0c907so33319785ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687377807; x=1689969807;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OHgUdq2V1XhpcVi2VnaNUbGb76c50gzBjl8WyVtfi2k=;
        b=Kft9gG/cpRYjba302rMLwJCRbnP0amjbnSOyDJs6v8RGYsgYxJzWNlPdY3mcsH/xZ0
         U6ZdGQ/vfXk8ehcT7J69gm9DM2AS9auYTr9FgCnWB+8kjGO66M5n0lgoaOpGD/I4PI3B
         EFxa9BNVy9YBYJ/ZUcwC+5zaFjDRoZVJyP6JBszQsuskpvWMGQeSr6I0Xs39/+pTuUcr
         qzT0J8XSTIDAjIX55CtL18mqGCkaP/5XWtvHFFna5bf7YXRuEY53FfWaaritWT4pgazF
         IoBy4vu3CutflroZRfg9IdJooag7Mr946QeunqOKF/Ch76A22AeC7mMZJqSoHVGcEU0q
         rkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377807; x=1689969807;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHgUdq2V1XhpcVi2VnaNUbGb76c50gzBjl8WyVtfi2k=;
        b=jk+8MJ3jTa6ztAInLIisJ2rD9P7I2Z/Pvp3i6UsunkIfDG1UGdUycAp3UXQ7ILXrzS
         w6ksapgN9pjR24C5T9VJ71WyzZUyy9u88TNm4jN0JXBSzWHhWz4wfKHssb6raImqUw+N
         2//QtP6feSK2C3o120Wl+olZxa6XvfBqFINQfsf9Lw5s7e3wGMihd2kRvCDCJ73w7JkW
         dkpafpvoML0ZaAw4Gdb/nKTmIqFYeLq08qLbU0uerbOaj2AqN27rF28EoYFD+mZS4ogy
         mXF0EOgpBpb9HlA5YGRxfLG0L+BEmHpAMDMuGZVpXgqEE/pwyi1YT3ryX7n4Jm1TlF+2
         sCHg==
X-Gm-Message-State: AC+VfDwdJA+tExCnYvwaKug6lpV8LZ1gkSdSmRsI9PnddrkdJWUwc4P9
	U48sIMzfV5TJ0ONPuWSwHqn8xuhnNkPsNhE/K88+Iw==
X-Google-Smtp-Source: ACHHUZ7emWDntMZMtCP8IVJwtf2lDzmC9sSwdAS8wbeFLMzHcdB3Z+fErzVM57ztE5VhUe7l/I6Weg==
X-Received: by 2002:a17:903:1250:b0:1ac:aba5:7885 with SMTP id u16-20020a170903125000b001acaba57885mr18755625plh.47.1687377806770;
        Wed, 21 Jun 2023 13:03:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n21-20020a170902969500b001b016313b1esm3922028plp.82.2023.06.21.13.03.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:03:26 -0700 (PDT)
Message-ID: <6493578e.170a0220.c56a4.9481@mx.google.com>
Date: Wed, 21 Jun 2023 13:03:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9
 runs, 1 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 20:03:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12096

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9 runs, 1=
 regressions (v5.10.182-cip35-289-g3c0549540706)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64934f8b5b524e00a330613c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/kselftest-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/kselftest-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64934f8b=
5b524e00a330613d
        new failure (last pass: v5.10.182-cip35-191-gf4efde512959) =

 =20

