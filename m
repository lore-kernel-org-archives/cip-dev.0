Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B156DC677F1
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 20:03:58 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.3513.1677096234689692557
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Feb 2023 12:03:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KrVr/pZ3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso2525332pjv.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Feb 2023 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CY4ofczUhaKVotcYlmwSBp9H3PIR4tKq/tfC9BcZeko=;
        b=KrVr/pZ3Ra61LV0YuGKYj/PvWBfyYPW8jo4U/wN3ei3Cu/DP+qudScCysstyrV0aeF
         4oRaZPZxm8nMgPQHSYzQ3me36ditOeuadTE9HqjnuNthlQM/0X/vSd2/Qi8o0E9X/lL7
         274WwzqXTc6dHawwML3DPE5KXI84aTuc4ICYVvR9/1I3zO/4VfPJE6/swnhPDcwPr39w
         lIa43MyzH6ZxASwibT2TcY2DXCs4QL0+GTtX/yjg0iecSJeDbCuyLhG4ZZB+L0JvpBdf
         xlW9fSmNlRxElUDSL4PLhUZEzb3m5Ew+nNAeQ6Y7qbL9UAbKb8JHd/Xti4JjGX8Cai3U
         /QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CY4ofczUhaKVotcYlmwSBp9H3PIR4tKq/tfC9BcZeko=;
        b=LQAUWXFjxW/aGABKh1N8LQC/6FKnQu+HWHgG2YvSiH4yvqGzMaLXfjSdPX4gzoWZQA
         QieEU3306n9NnHFNpCQB91YG1rRaUCVoYnRYW2OM+UVQJVQNu9tXn2zdcplVY/BRDGCP
         YAEBZDTa0UpEXRwGUHhWST86egciV7We9HxLdYoVb21ls8wvTjfPHfxMe6DTxfGL+eIG
         KjXD5WJ8uX5oeMHE1PmASw9kkrGT8Vp62eeigBdyqNY06Nn4l8RJA4Bz1t+7BD9W3AoE
         2hQ0IlKHQCuJ0cqH8pbYRaV0RlNcvCx7COIMWASGp7AoEd/kifySiVgqr3s93eb3uob2
         fwZA==
X-Gm-Message-State: AO0yUKW+91DJKtbcdOLRyeqRPWoG77TgmvxE0knoK60ezH4vDTiZZqpj
	tny++Zp/oJ/PmvH/bXumLbFry/MznMkUJq1mo1yfjA==
X-Google-Smtp-Source: AK7set9Q5TTHKjbteZMgRO8AHtFdTS3DjbwzFvOK7roqS+4LYgK0ywZlcZUgSdfXESVZ0ccO3Ro0jQ==
X-Received: by 2002:a17:902:d486:b0:19a:8b3a:fad with SMTP id c6-20020a170902d48600b0019a8b3a0fadmr14121403plg.20.1677096233775;
        Wed, 22 Feb 2023 12:03:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jk20-20020a170903331400b0019258bcf3ffsm5875286plb.56.2023.02.22.12.03.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 12:03:53 -0800 (PST)
Message-ID: <63f67529.170a0220.71c02.b1b9@mx.google.com>
Date: Wed, 22 Feb 2023 12:03:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-192-ga2cd4acb16b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9
 runs, 1 regressions (v5.10.167-cip26-192-ga2cd4acb16b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 20:03:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10790

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9 runs, 1=
 regressions (v5.10.167-cip26-192-ga2cd4acb16b2)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.167-cip26-192-ga2cd4acb16b2/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.167-cip26-192-ga2cd4acb16b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a2cd4acb16b241aa1a262f5213f9c4e8ddfd0714 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63f66f308e2707d5bd8c8657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63f66f30=
8e2707d5bd8c8658
        new failure (last pass: v5.10.167-cip26-2-g1e87e7748b91) =

 =20

