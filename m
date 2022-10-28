Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9111ECAAA1
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 15:21:36 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web09.724.1666970490411334317
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 28 Oct 2022 08:21:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=IQ78kahY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id g62so5028663pfb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 28 Oct 2022 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lmnJMIJtCnkHoBCmzgtLv9dQBkzxnAIHAzyA27oNkoU=;
        b=IQ78kahYS88lgD6A2PBksydH6lgmM1zRLB+plphTC81+Z+GXsydoUb1Lf0rolu0NWS
         LDaZPiksnSxyUAVIdo5Kx51iI4FZZXwLAH/70UHvz014h7ztWPc+Zmyz/7/+eztKVjnj
         ZKVEySrfkF0FbQTINZ7OIGvLULqp6YsQgAqeFohB3VZlFWH6llapW1gUbuPdriv7hNWe
         X8fnhlL6N+b0cZPRzlHBU0F3SWJY8wYp/8lbOWLTHmtgodWtRk4XNbbNwWfOOfxWFcQE
         RUfylN+UDdq1qF9vZUhBf3zS9nyzQ9vvMq4pnG/v5t7yL7xAM4a6eboU2D6db9PlxRSa
         DBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmnJMIJtCnkHoBCmzgtLv9dQBkzxnAIHAzyA27oNkoU=;
        b=qweZhE68m4IdchGJE9WJIaePdUL7C4VYx5p2ew2X2O8R1IfoEfjUuo/Gz0/PLwxM9m
         pto/JnozdORsEpA+HaZ0Wm//rIandqFbAsGza14zNM+ZhfggLnfnL9Z+B0ts7Qkngf+G
         s6fhBowQsg7elvNqkJSSuoLBZqT4cISo0by2kItqKxIBBHyWZ8pkEw2V07HkrKqDUvCQ
         CZKL0W4UE66NnB8WB7blJ9yzW9Q8ugyEJIIXw9sGREXlrl3BxNrQrIUxrLOf4hqJAjd2
         sqSh7cFp/iISmhRwxtZjGlBTWHXKL0KKdkBFfZRpBgXDorN4Yi/kEF4QSiYITF+NvDv4
         33qw==
X-Gm-Message-State: ACrzQf3ahYp5NDeQ3rEzDm4AFcMk6mhQC0gcEJsRqATH5r36F0AR2dXG
	Rva5WQOmfY+k+NE0qfRdF9GR6k0bR6Pxgwzx
X-Google-Smtp-Source: AMsMyM4sGCWoxabnrFXw5AIHccFlVIyYjMR6oERP0L44OU7olB+Y+DNqIIkX3n8+EWYGwGtszUILsQ==
X-Received: by 2002:aa7:9298:0:b0:56b:b6dc:988a with SMTP id j24-20020aa79298000000b0056bb6dc988amr29004041pfa.5.1666970489474;
        Fri, 28 Oct 2022 08:21:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r38-20020a635166000000b004597e92f99dsm2821617pgl.66.2022.10.28.08.21.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:21:29 -0700 (PDT)
Message-ID: <635bf379.630a0220.60ab4.5b1d@mx.google.com>
Date: Fri, 28 Oct 2022 08:21:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-468-g86403a07ae1c
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9
 runs, 1 regressions (v5.10.147-cip18-468-g86403a07ae1c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Oct 2022 15:21:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9888

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9 runs, 1=
 regressions (v5.10.147-cip18-468-g86403a07ae1c)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-468-g86403a07ae1c/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-468-g86403a07ae1c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      86403a07ae1c0fdab3215fcaa06d157c20aee250 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/635bef0b7e608c514fe7dbc7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/kselftest-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/kselftest-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/635bef0b=
7e608c514fe7dbc8
        new failure (last pass: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

