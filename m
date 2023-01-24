Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B395C54EAA
	for <webhook@archiver.kernel.org>; Tue, 24 Jan 2023 13:47:00 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.15070.1674568012187662049
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 05:46:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2uv0eJRi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id lp10so11517112pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 05:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rMZs4H6MO9IuMmoIpzlX8RCdUvV7qL8Rr5gq70tA/1M=;
        b=2uv0eJRike7KWnGCk2zk4DEou4/arEPk8EJlIHrqZQ5IFaLtL5/6Zle3EDjJuWeGpq
         PwGjxJFDguAMOC/7R37Jks0PeSfgnrGYcTHUKs5PX9VnGFsf1pyyRP9Y+4QEm8BJSLag
         y7TQeTKyC0DWQHPQYt4TdIJXUDwxacy/aQ9bZwSj3iTHcSbZ1bA6H6JK08WzY2hXFhj1
         6SakU8+qL+RZocLj2g1ukLvJ2mgHHMnTlf3hwu+WjkbYdanGoopIU4uK12e/qQNlOq3k
         bZQS5FcAPcUabo+VeRl5lfx2KvP8q4FiBQa3TY0nbNz5OVJLMSpdLzqnlqv5UN3LUOEW
         otqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMZs4H6MO9IuMmoIpzlX8RCdUvV7qL8Rr5gq70tA/1M=;
        b=NvGotKfa5HpGg2NZFTgpt+2bHsF4+mvLSD4HWRskmMJay24C3azAW+d6CJ9Qi8+sgZ
         /RrWoBOTuN+IJyd8Fv8FY8Xz0hwaRnqML96sPxzaEkjU0Y6hh1fcm7Y/5LtgpSqiRwVq
         BGvY8773WOksdlVV9bBFymPLSY9kIAEUtVQZssXa969T2288T49QxAEQ/AojDv++cEUI
         FK64Y5Uhtk14SWYiFCdmMHc6fenxPXZtDxhjZMufBUPRDXJB696qpoAmZBnI5qGIBtuI
         sPg6Y1mFTXPjz09r5RpPc0wKW9hidRuXysj0Q3TLpIJ+HCRK5gL5ufSq4VveidveVqKH
         kEzw==
X-Gm-Message-State: AFqh2kob2hwszc/KF3XKBfhN7TI8DgtQ+eO09Wo7k/QYsq4Spj3EiRAw
	CWn/B+BzpQi3IxW55IcCJszZJeFZyPaOLbwhSkY=
X-Google-Smtp-Source: AMrXdXv0JuCadp01WHopcYh469cNgWyrRpUVf/I2reFLfYvue0o1fLsl6F0c+R6DuAxHG54qLca0PA==
X-Received: by 2002:a05:6a20:8b02:b0:b8:3ec5:e11f with SMTP id l2-20020a056a208b0200b000b83ec5e11fmr28751987pzh.16.1674568011026;
        Tue, 24 Jan 2023 05:46:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bt21-20020a632915000000b0045dc85c4a5fsm1442203pgb.44.2023.01.24.05.46.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:46:50 -0800 (PST)
Message-ID: <63cfe14a.630a0220.a46e1.2275@mx.google.com>
Date: Tue, 24 Jan 2023 05:46:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-952-gf408044f5bad
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 7
 runs, 1 regressions (v5.10.162-cip24-952-gf408044f5bad)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jan 2023 13:47:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10470

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 7 runs, 1=
 regressions (v5.10.162-cip24-952-gf408044f5bad)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-952-gf408044f5bad/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-952-gf408044f5bad
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f408044f5bad2c96806e41c8eac61744913398d4 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63cfd3061ac67786fd915eca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63cfd306=
1ac67786fd915ecb
        failing since 145 days (last pass: v5.10.136-cip14-542-g97767707d3d=
0, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

