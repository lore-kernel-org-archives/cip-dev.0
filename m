Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F9FC25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:42:57 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.72582.1698331368779103283
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Oct 2023 07:42:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=y0thHWcE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1cc0e78ec92so4776675ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Oct 2023 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698331368; x=1698936168; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mH/eaBQtJZ3M0u8UBCtdaOJmFLqC9ZzZ8pCSogL9wZc=;
        b=y0thHWcEKATDKLJRrjAcWnVOI9jBl43Z2A27Mxe7MwoscycWmW0/pop8NbmMPxetFT
         KqCYEXoM4CsV1E3/+nNh7i/q4BGpT7kqF1lCkyTcV61IruTgS9Ws3qYnfEdcr1fBzk17
         R2G5LuXJy2MMxborsah+XQbQidPdkmGcmuFrPs1O4IFWRc/URLLz6+iKYYrJv8VsYNZN
         ghVEKo9GPym/4+0BLv7B8xqk+FJ9F6mRdvNf+k73ihiScEnyBZzu5Jx5ysRZDjqT3pl2
         Isn5OJhf/Uj2X0xZso28Zu2k/4AdpvGjdyAQqpn8PONWirzzPJLZq4863agzw0HN6S+O
         RC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331368; x=1698936168;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH/eaBQtJZ3M0u8UBCtdaOJmFLqC9ZzZ8pCSogL9wZc=;
        b=w4m2Sw+NPGcxouJPRXiYgMP21TdyOfwgOGuBQfDfuGtHZhI+rDvK2QSU8TRQ62It2d
         cRT+n1CWBzDSfifU0BJw4mzrGXBupf1ca8tW2087joFyhXJL0i3Fvng3atkN3Uk/ell8
         oIUXCEHCKrlYmkgunSWpKw1DoOJJ6rjagynUg/KHzZiHzQtsjlxpmqlBaq9gAKSZ6w0w
         lTL52Y0LfgLQGJaTs4a0bGmcPX8FocMWB1RsbTp3fKutWC9fPfAUdK/x+2DHyaizurZI
         1jdxPb9YLhVN1gQ6slG8dTk/cMdXqNDFxnbthSuIQ15k6hzRPkpCx53GFKFr/PfLFQba
         gYoA==
X-Gm-Message-State: AOJu0YwlNuI2u3WFkuabszHYgTU2rprp0FImZCk5IM6sFKKs511q/NbB
	al9wAjE/KyRDMzNmUVatFDQeYBnN/P5XC/ZMrbU=
X-Google-Smtp-Source: AGHT+IEy3VA6MoC7M9bMHKqHe6cJaLu192ayv0OT9Kqp6yjUIcdGdiYo/KvHPDbapMZNR+T8vOlqpg==
X-Received: by 2002:a17:902:da92:b0:1c7:4f87:3dbe with SMTP id j18-20020a170902da9200b001c74f873dbemr18974751plx.31.1698331367910;
        Thu, 26 Oct 2023 07:42:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902988c00b001c3be750900sm11097407plp.163.2023.10.26.07.42.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:42:46 -0700 (PDT)
Message-ID: <653a7ae6.170a0220.2905c.4d24@mx.google.com>
Date: Thu, 26 Oct 2023 07:42:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-3596-g73e7f2b880d98
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs,
 1 regressions (v4.4-st20-3596-g73e7f2b880d98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 14:42:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13472

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4-st20-3596-g=
73e7f2b880d98)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3596-g73e7f2b880d98/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3596-g73e7f2b880d98
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      73e7f2b880d98bcbacb997959b6c7b220f7fe382 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e19ec94d7af6befcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/653a6e19ec94d7af6befcef8
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =20

