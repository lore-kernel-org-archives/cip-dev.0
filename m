Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044BFC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 10:55:10 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.5800.1665485702753124327
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 03:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=sLLpdfMC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id b2so12834504plc.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr7ftfRqTFKbdg8S7DSifiUBgRVxrlL6vrVlSgSE0uE=;
        b=sLLpdfMCaku119IvCKZM9qqJTLl8T1SC40QSyXsrVvv2xCMz8vI0K8EhmaYydb+9mr
         k0OAVIhGtSvSIeE2HS+02Id8/tJmKqFtjNzVCrO/6p4PysKyO65ESbpM1O8AHvQ4gu6K
         0/K/UVB/lSEALbyJ0gsNDegMdMV7l5hDkNZJTeAqqLUMQGrJd88bBqF+OKNHsANXPJw0
         zoIxWG4nEQa/hfW4ee1B/MH4UF5SMIwDPGVkExdF9HrHHnONc2iHqaIjL/IrsSlFoEsr
         5qEwbI2TJqalwkm7vigjqZ05t/2+iCQ0H/BXQ6aCusRoCw7Pft8Wqozmof4kLHRw8rWm
         7VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr7ftfRqTFKbdg8S7DSifiUBgRVxrlL6vrVlSgSE0uE=;
        b=eV+BifbO88lJyTSXCs0fBI87N4JiND5o86TBGrsTHiOXl7YbtjqXr91SWwxpGD9dB6
         /gU3P6162m1oZLPzZUrRVAddtFjTXs7PnvTsh8X7XzTSsYTM2uEVxfagd6/ksVc92Ged
         LD4gYEqhAwX8599TStXf3xZJ0cqP1J96bOVN+kw8A7gK1ja3ODQuu11ipiF7JW98Tu4u
         M+mxEysLe1FO5ZuNm8M9X0A/EznMvJLs+o5C0DDLlfHk1S32e6vikCr723SqIPpfPgR9
         O3PPoOXV5tXLsA9NytvFMFS0jGhbRcDd5KfItc4pXyUlkJmLbXK7lnXWSVdzjMd1GZ2/
         jb5w==
X-Gm-Message-State: ACrzQf2OAYkQ1vBIPFZZceJn5BYZlI25UCJin7Dh47d6AzhnzYs67Qos
	XECKzSSfePVsW8Ojllu6YtMnzI273QIfyWi05T4=
X-Google-Smtp-Source: 
 AMsMyM5vWLCaquYupZcFIyJRQMZJdmDEFH8AFTKpyDYama6wpmh2PeeGusatIr+10scQbJrDTmShEA==
X-Received: by 2002:a17:90b:1bc9:b0:20d:75b8:ee5d with SMTP id
 oa9-20020a17090b1bc900b0020d75b8ee5dmr1452772pjb.147.1665485701787;
        Tue, 11 Oct 2022 03:55:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 bc2-20020a170902930200b00172951ddb12sm8313704plb.42.2022.10.11.03.55.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:55:01 -0700 (PDT)
Message-ID: <63454b85.170a0220.7f873.dbd0@mx.google.com>
Date: Tue, 11 Oct 2022 03:55:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-1-g92b5279a8e1f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 81 runs,
 1 regressions (v5.10.145-cip17-1-g92b5279a8e1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 10:55:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9711

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 81 runs, 1 regressions=
 (v5.10.145-cip17-1-g92b5279a8e1f)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig           | regressio=
ns
---------+------+--------------+----------+---------------------+----------=
--
panda    | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-1-g92b5279a8e1f/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-1-g92b5279a8e1f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      92b5279a8e1f1dd8189276753604ca74c0f32a76 =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig           | regressio=
ns
---------+------+--------------+----------+---------------------+----------=
--
panda    | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/63453eece5f8f917c7cab61b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm/omap2plus_defconfig/gcc-10=
/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm/omap2plus_defconfig/gcc-10=
/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63453eece5f8f917c7cab=
61c
        failing since 40 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

