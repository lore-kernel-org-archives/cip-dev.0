Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FFBC7EE37
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 18:39:34 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.2398.1686335969866611531
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 11:39:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=KA0FEruV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso2187431b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686335968; x=1688927968;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/fuMjiVKlct/C93cETa88wtJn0Zozc/mMHR3HMjhwk=;
        b=KA0FEruVxmn6Ok8TjaxKw+1Jm/DojDKh2VfifKqscONjjk3x3y/C5FKwmwKpPfqDce
         TVmxDN1n+pOdfUegUQaYgoevS/Kq7zFiFw/XQSqLG/QX2ujE7/1I6LbNkIqL7bBGZ8xF
         V8fzbzsuYLp9H4O5SJHblooP7JtlEc5+MYLRTJ39HNkrcBgkeGpFSgSF6bd5v2MV+iXK
         XSBFZrdKfZhUEeB0dTE8ND5/E0/olx80GrA+O/mZWmRul4OZzzdB/SXuxzYuA2zJfFP/
         Bvy/tOuF3BsDqZU1uZUg86qFjAkQwKMbw96EmlJRYiQ8BatWpIGjrsr1Oy54OVqRPKQ5
         KhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335968; x=1688927968;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/fuMjiVKlct/C93cETa88wtJn0Zozc/mMHR3HMjhwk=;
        b=dlhRJ5eszTOUAoV25U//4Pc0CQgRFthjWBHbEoEOFuTeKkhPu4xPUke1/a9e0dDl3q
         9/10iW1bl+2LhWWLnV/bs/QdyZ1v3EnlRVclGKjsvAUO7Jz03VvBGqCituoI91dfZUKk
         OeonuHg/XpY6ZNCjAJpF6uhJH5ypbAQq56+lAFe8I1V9uYJtvfeBUXGa/iTMDDRuRa17
         g8uurNdt1rhVkgRRNDT2NVUfmyxHDfFFCZ7SkahPYJuksjyNCOx1jaCUIF306MzJkvZy
         qkKdiIz+lNxDdDxJ4+wZo+y7mc2NbTgHn/J4BQMLVQpCRdaq7vMWTbwBfDh63kk+Aylx
         afsA==
X-Gm-Message-State: AC+VfDyAYpfs9KI7KGbrkXVLeQCHfYbs4+/PGqOkatgyU1IL1O9+tZcY
	plvr691EcNajdgxtLgsqgQtYt4rPb3kwWvDYRyk5uA==
X-Google-Smtp-Source: ACHHUZ7MaEaJTnXRn7typ6o+5q052F929+febzqcyxYBwvSd16qSyUS+SG1YATWQZmBSdsfCI3Cbqw==
X-Received: by 2002:a17:902:8648:b0:1b0:524b:e597 with SMTP id y8-20020a170902864800b001b0524be597mr1945289plt.2.1686335968534;
        Fri, 09 Jun 2023 11:39:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902968300b001b0266579ebsm3562112plp.194.2023.06.09.11.39.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:39:27 -0700 (PDT)
Message-ID: <648371df.170a0220.257dd.806a@mx.google.com>
Date: Fri, 09 Jun 2023 11:39:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-1248-gcaf6e8ee921e9
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs,
 1 regressions (v4.19.283-cip98-1248-gcaf6e8ee921e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 18:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11954

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs, 1 regressions=
 (v4.19.283-cip98-1248-gcaf6e8ee921e9)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.283-cip98-1248-gcaf6e8ee921e9/plan/kselftest-filesyst=
ems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.283-cip98-1248-gcaf6e8ee921e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      caf6e8ee921e9e7714b8669fc9187fcd56d5a5e6 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648361906fcad2a90e30613d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64836190=
6fcad2a90e30613e
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =20

