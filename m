Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A09C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 15:37:49 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.164088.1692200259937722094
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 08:37:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Augs9AJd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bc73a2b0easo44335715ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692200259; x=1692805059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aXYmB7O7ssEXLp6PblxabKPPOFR5X4quLcnZOeIT1ng=;
        b=Augs9AJdgKOGwGNMDL/G0CDftfF9GZc5knLF1mnU/Oi6H63WMvmLL8vQh0Y8PaWJh+
         v7n04IC2yjJc9si8DVCXlJnYChWyH2o6rE+iUNlERsXT1x1sn9kibOPPHLNUft2SuZ3J
         UcJrixRchhMGc95Et0nBqUZhTDy5d+lGcOOj/KcXyuE4ynO6K+d6rJaFnYWBVBI7YmQo
         ztZ7C3ypmWSJGUwYkVeGtNlgMPmT53ES7sTj1OU26zv/6rTPM2Cc0udoWTLeZjoigz+O
         ejFYVcHdRUC6t8Uw37crK4tK17owSgo/sAwh9QCkO/HlfeuUp0rbvej3sufMPTDU3Pvy
         OS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200259; x=1692805059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXYmB7O7ssEXLp6PblxabKPPOFR5X4quLcnZOeIT1ng=;
        b=CnPuv4DkGijgOSyp+0PjjstjpIoRYClPIlbIKYJNeyv1IbiiZhhcUvrsU4gao4WymQ
         8r8tC60B2IzEKc+Dv9HZ0cCHq4Dz6epsKSXa+A2u6iqr5o3MK7C4O0wY5xtLtXJOtSaT
         qgeIf6TlyP7zcnwrrbtUGYmNqA3J45nNmpG3AubtXHBTIN44dwdU8eC/T5P6dFYq9O1V
         Syci1ZITf5YH9+I205CkVRwmysl0eOMuQTF1CXMs2tGUESV7hH+atXzRSwjf5h4XP0gC
         XiibMrkh2FF7JngP9tRiRlqZdWskbUY21vRt8oOXZ8+vL+pLGZch9K4pJPsAe1P998zA
         TBQQ==
X-Gm-Message-State: AOJu0Yyud40Y6Uu3VHu4a1ItTwuRjcbCnDrMth4vk2OWSIXQC/eohR75
	2ylooTsGpRkBQERICvcQp+9KCydJS8RVF8203PFdng==
X-Google-Smtp-Source: AGHT+IHwAaEm3rITmACUm9I2nj46kdKa1rSJaDRHmVNwFVWWM68JygfXEv99OpnrV/x10GQ9VujIwg==
X-Received: by 2002:a17:903:41c7:b0:1b8:6850:c3c4 with SMTP id u7-20020a17090341c700b001b86850c3c4mr2244967ple.22.1692200258848;
        Wed, 16 Aug 2023 08:37:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001b891259eddsm13212281plh.197.2023.08.16.08.37.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:37:35 -0700 (PDT)
Message-ID: <64dced3f.170a0220.7cbfa.8bbe@mx.google.com>
Date: Wed, 16 Aug 2023 08:37:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-3262-g667bb8d8b2cb
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 1 runs,
 1 regressions (v4.4-st20-3262-g667bb8d8b2cb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 15:37:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12738

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 1 runs, 1 regressions=
 (v4.4-st20-3262-g667bb8d8b2cb)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3262-g667bb8d8b2cb/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3262-g667bb8d8b2cb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      667bb8d8b2cb1a46bab0ddda1cf60f6e73eff4c6 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce541dce04ef65835b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64dce541=
dce04ef65835b1da
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =20

