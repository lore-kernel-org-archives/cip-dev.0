Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8777C38159
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 16:35:34 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.20398.1674059725474791650
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 08:35:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pGqjBH45;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so2078452pjq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p6q7B3gblli8QXYe9u73k/zrycNkMl0yND0HoCI6ms8=;
        b=pGqjBH45/m7hX/gRSNbFNp/fWWIEWlaRHBXBWhKsQF9w86xlQzSrch2vJ1kkm/gpoa
         Wl2y8bC9HGxSekpspZa0i0LsXaDZkGocx2ExGnPf9ZfyyBggrb6AJpnFBLyAvuI2h+0k
         edEsSQDJ5TdHh0HfOv4j0/Hirn+ikuJl74Scb3XbSC2/36MKd3yivuoduThj7khDpXkT
         DBIyGQK8A1hjWm3Vk59FJa1JPMd0acbhtHcpCR6D188XaTxbkw+yw6Bbm4WkGjIspc2O
         CWUytNb3Btmjry8IbyQGLaZi6RaePLed8XZ2s2XK0DsBypSjI6+kFSlHVmJv1qKogAMq
         HY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6q7B3gblli8QXYe9u73k/zrycNkMl0yND0HoCI6ms8=;
        b=e64yv+yapbZ6eu9U6janM5QKRmOkZCjcXwsCBAVECSdbxhF1bDAneDff6bj5sdxoOp
         rQDiN8PWpVcwrJv6Htz4VZjBrZ9PUKAvaj9YwdqyQw8mctAO9wVDeROyYyY1Jd5kDt1+
         0oKInq5POj6pAi8GTeTAnBLhAniU8tX4+e4RE3obimAJTMj8N38SvP4shxPyy7mq1cAW
         va26IjYQl6DReRNRhN+rtE2bwabRiWxH1i9djMbzRbl853OJmzaPA/Uz9RzYsjwiY+CS
         /oueEJ1ICQuuCcy/s6tK3epqhz7echgH1/Gs4oREQeLecvQhZ0hLm+7QJyFxbURmnKwo
         Ir/A==
X-Gm-Message-State: AFqh2kpGqP0QqKBMjbA9tILXRPbmGVvy5betcq00UxrGycUwzFMMs638
	vJpzL3xlWq6ySnfuh4OFeqcQY36KTTDZO6dLmcaNnQ==
X-Google-Smtp-Source: AMrXdXto31sYIV30Fa0npNL+nRCs8UOEH8PgR1240sWU/PV/3szDYLHHBUAKrnWUXvtihheS1yV2eg==
X-Received: by 2002:a17:902:f789:b0:192:9550:339a with SMTP id q9-20020a170902f78900b001929550339amr8503370pln.52.1674059724595;
        Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001811a197797sm8714580plg.194.2023.01.18.08.35.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Message-ID: <63c81fcc.170a0220.92ed9.d458@mx.google.com>
Date: Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-853-g709bb3738fde
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 4 runs,
 1 regressions (v5.10.162-cip24-853-g709bb3738fde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 16:35:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10393

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 4 runs, 1 regre=
ssions (v5.10.162-cip24-853-g709bb3738fde)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-853-g709bb3738fde/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-853-g709bb3738fde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      709bb3738fde9ab95ab1303d161730f508a6659e =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63c80d60cbab3a952f915ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63c80d60cbab3a=
952f915ed2
        failing since 167 days (last pass: v5.10.126-cip11-116-gef362fbbff5=
28, first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20

