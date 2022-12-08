Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F0FC4332F
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 16:20:47 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.18702.1670516438356723537
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 08 Dec 2022 08:20:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=j+f89Ybb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id y17so1976813plp.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 08 Dec 2022 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iAyRYe0aFFo51fDucq9XuErmVqqbgfaXACHCpamIaW4=;
        b=j+f89Ybb/q+whNaDFbcH8Mx+n2CbYdnkc7QhbcHdbTLcZcKamiUTvpSz7T5SpOKGwb
         ntSO9Ah8a/WHY0L597mNO1n+DOJtHoehXyaezGkaVUUG33hJySdwDXLuAgkQsTKZVeO+
         WhB8fQJC+o/TrcbsbQaUqzBHGr1snbmyllmtyl+SERC7GtO2ckmiZtxJ8KcIJZzyLIta
         w1ECE5C5OaI+KjbfNB9hJfRxS/8GsZtlSXsyLe1r2NbS9HtwvbgVNIH04ok7Hh/4w1qj
         RLCH0NSLEZMa3xMuCUuPB4o4IPtj0mOfZz0meWSW7iNU84ioUJcy38ZWe8NgN1Sajop7
         atMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAyRYe0aFFo51fDucq9XuErmVqqbgfaXACHCpamIaW4=;
        b=GTcpRvDit9oHNYvPjngLM3tdnGDGV0ci5bKu3hXRsHcJ2b77ZyZivwGqrxbwOKoJ8Q
         bE9qiDqbepRsDJt8m/sdmZ75r1RXr4WfZ/Kquz3lua3MZ3SfgWiJ95gNQ46wdw/9LT+x
         SvV0Urh8nKlqrBHTm9xoCtW0LN7cnOFOwKNTK6N1dZVWSSzBWqajAgGjHkl8ObcvLuqS
         Z6HA5QCXh1QlAMrySGC8YyofooCa2JcJh1jKkzlyekLyLDqEZqOe5pr8LroDN+w70WfG
         6SmKOmNafjRMnI0+JuzV+rjfzp7je/du/GIf0FfzYK2w0FtYUptRbsdaKulRv8PiF99J
         pB2A==
X-Gm-Message-State: ANoB5pkBgTQM/6auY/zr8tRRkQfJjRRkDiuhzroWvqwsc5qNd8+H3ztv
	nJkNh/dtC1zsRPor/WEQD63ouB9xAZmqXs2tkc8=
X-Google-Smtp-Source: AA0mqf5t8wooScXcl5JTPQ9fYYiDpapAkLjfSxrM5CnmTbJrfj+/DcKMeqRAlYPvs5gXdQ+BadujWQ==
X-Received: by 2002:a17:902:e20c:b0:189:a934:ee33 with SMTP id u12-20020a170902e20c00b00189a934ee33mr2238820plb.58.1670516437461;
        Thu, 08 Dec 2022 08:20:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b00178143a728esm16694880plb.275.2022.12.08.08.20.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:20:37 -0800 (PST)
Message-ID: <63920ed5.170a0220.35c6.0197@mx.google.com>
Date: Thu, 08 Dec 2022 08:20:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.155-cip21-405-g26d566555c3de
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 5 runs,
 1 regressions (v5.10.155-cip21-405-g26d566555c3de)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Dec 2022 16:20:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10169

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 5 runs, 1 regre=
ssions (v5.10.155-cip21-405-g26d566555c3de)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.155-cip21-405-g26d566555c3de/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.155-cip21-405-g26d566555c3de
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d566555c3de5796328380cfeda5b2372f45010 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/639200ed3ddfcfba432abdac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm/multi_v7_defconfig/gcc-=
10/lab-cip/kselftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm/multi_v7_defconfig/gcc-=
10/lab-cip/kselftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/639200ed3ddfcf=
ba432abdad
        new failure (last pass: v5.10.154-cip20-99-g0e320e4d37e4) =

 =20

