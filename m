Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF5C54E55
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 01:05:53 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.40414.1709341545585954562
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 17:05:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qI+H7rXW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso23183555ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 17:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709341544; x=1709946344; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y3B3ZjmZ2RIsKPmjNBpG0BqBBkzeIEBRP7SQE6kE8U=;
        b=qI+H7rXWGpe62RUn/3gSZVhw+vaMKZofwQ8IbkS159lnu0uOJFTZqgY8zgEiwu6pgE
         OjGTQwyMEGjf8XlgYOOD6/z25JwtRBpHPQtHqwD9hNCwNCKiN/kTVjJvbRZwKCjhJMT1
         GbsR1Ua7K4DAzID80Q5wWGodDUnaIHvsNAQ5NN7I0HNEbvYOKA9Er1f1/eFKv54WXVck
         BGKdH5zhHP+I9UgIgVgvQgbFPk36K8MpbC5aye10HW3lOKrUS2onueCSHLgA0Cg8Cpt9
         t/AR4O+ST2u6j5O1VLLzsuI9ipmO2jgWVkqUVZpmb9s328BTnuCYWtr0BZOlCQQQm20I
         b8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341544; x=1709946344;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Y3B3ZjmZ2RIsKPmjNBpG0BqBBkzeIEBRP7SQE6kE8U=;
        b=UKMWPLJsD6m5hGlayJk1NUav13O+35KPZdNrPEr3zojoCOLzA42J1eWqgsNaNg9623
         h/ZFPH7uDUjsgK4rQ2zlDh6Gg8bJLIkZn6AWHe/cExkFa93vXQ94k2sEzs4Ev/y+h1UJ
         SXaNIrE8ZSdonGbblea2DDD5vPleWDGiTihwHkkD1dDepWJVZ4Aw582oVobiO2MGUMUm
         gHjD5OSQ8PaD4BQThDYiwvSU0ogBKHdmDLkF0y/LI+ssg1YDei3zJvuHx2JPRl1GeUnN
         a+8H+NY4OY2JwZpYAS/cfBMlqujEoQC2P70JXGRf77juFWPjxB7xHx1B0Bo+vHjrk3PX
         XOlA==
X-Gm-Message-State: AOJu0Yzdoi6Gjj6V7UxTH8z4TqO7b4274pBh1GppT1ZkDTB1GCqmvpBm
	OxeWwhNCwqcWoBJAyTnDreTStYvcVcVJyPnpCipnBwhDlYZl/k5nxtadXlz/gLMMhbdiYVicP39
	5GFY=
X-Google-Smtp-Source: AGHT+IEfR/4gxyPY4yGzrKqCkquVa6j7dz2HigtcwGOtZQ0++O5mZRbcilCsIzktqPW88S+wSN67Zg==
X-Received: by 2002:a17:902:8493:b0:1db:28dd:a428 with SMTP id c19-20020a170902849300b001db28dda428mr2777753plo.23.1709341544560;
        Fri, 01 Mar 2024 17:05:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f13-20020a170903104d00b001dc96292774sm4062968plc.296.2024.03.01.17.05.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:05:41 -0800 (PST)
Message-ID: <65e27b65.170a0220.c7c0d.3ca9@mx.google.com>
Date: Fri, 01 Mar 2024 17:05:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.306-cip107-1142-gdcbd51e7744f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs,
 2 regressions (v4.19.306-cip107-1142-gdcbd51e7744f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 01:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15156

cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs, 2 regressions (v4.19.306=
-cip107-1142-gdcbd51e7744f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.306-cip107-1142-gdcbd51e7744f/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.306-cip107-1142-gdcbd51e7744f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2699a8eeab82b35637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e2699a8eeab82b356=
37013
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e269abfbad39fa8c637037

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e269abfbad39fa8c6=
37038
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =20

