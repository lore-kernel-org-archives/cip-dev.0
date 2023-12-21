Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71379C46CD8
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 01:30:05 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web10.42394.1703122198153451834
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Dec 2023 17:29:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2rvGQdav;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.174, mailfrom: bot@kernelci.org)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35da160de2bso1186715ab.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Dec 2023 17:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703122197; x=1703726997; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MyILJ0tCPrD5uJrV39LXRHGaAmeimxO/HSJp0gMRPug=;
        b=2rvGQdav0Gw14Ci3DOzjR14sSQ+QnzvXU6Mh0iLAfZT5zHqXAWemFRNzEiHqtBE/Z2
         +IlsFrtdBxq13IUbmAwlROKNlHpieB6KexBbbfkoXfFBmlTMLbhfzDV+6XWZDhOE5hwh
         Dv1slH+qmiQw9g2nr4XWhnDEnDUmf7pkotFq+zzwKAmZX2FY4HSiixYV672aUci2wHRp
         mifLkSj2WrNMOMjpfGpcfeP466HvUj/bixk+Rbk7GZ78bI+f7eWCR32G9lpbp6zIUvvO
         tl/KoAqc83OnQ+knUdTgqO6WYlxbK6/XgllG7BXxSXFNyMwiw5d4XfjZTKL2Vhg+M63V
         FTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122197; x=1703726997;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyILJ0tCPrD5uJrV39LXRHGaAmeimxO/HSJp0gMRPug=;
        b=ENI1dewzwVkoeERICURM/20GCIa7e6hpHCvJQ/ABH20TOxrPrTQnk864JfjwAvTrl2
         OqL1t5u/dfEsCcAPzS9qbq6AkO73U7dj6Og+addLSwDXwuAjPHDqgLURAWXluBtfvDaa
         1O7e8XG+qKNa9ihud3ui1uazZchtYFPdGjt6x3RxTyHgJweNDidpzisPL8mIjgRXSKXv
         4EAwrWOnWvRwoOV7tFPXofR/tJWWgQ3EFdKqPf5X1MpcwudCCKZMpD6t4GefSGVFzeG6
         NSzr2st3BFiRchQay18hSlgtFUMNfnFSFTHwoRDiOncomwFUgjlz8nLZx0+ueKppjZnO
         vyzw==
X-Gm-Message-State: AOJu0Yz4F48oxDWX6MNF3LQvdG8xiqj7ta/9UFbdpgJfLct/Uz58/3pa
	4U3YbAn6ny3QJHZnxV/gzQtGCaYu7wXiXIi4cjw=
X-Google-Smtp-Source: AGHT+IHFluiLfOJhl7DO3r5+IQPmHdI3u/OSYu5XqxzhYw/5caUCk3d+KQ7ZyjjroP77T95lTvBsXQ==
X-Received: by 2002:a05:6e02:3206:b0:35f:b106:9092 with SMTP id cd6-20020a056e02320600b0035fb1069092mr7805728ilb.10.1703122196903;
        Wed, 20 Dec 2023 17:29:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001d398876f5esm361259plb.121.2023.12.20.17.29.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Message-ID: <65839513.170a0220.3b7d8.19ab@mx.google.com>
Date: Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-540-g3640150b3b169
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 7 runs,
 1 regressions (v5.10.201-cip41-540-g3640150b3b169)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 01:30:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14176

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 7 runs, 1 regressions (v=
5.10.201-cip41-540-g3640150b3b169)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-540-g3640150b3b169/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-540-g3640150b3b169
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3640150b3b169fcd03031a9e8aab166a9730a1f9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65838a71d928d7c4fce134a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65838a71d928d7c4fce134a8
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =20

