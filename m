Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43CCC04E69
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 11:30:18 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.158583.1692185412062284120
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 04:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=HoPeXDZe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bdca7cc28dso34522215ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692185410; x=1692790210;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gW8z8LGGRJ7EeAkhtuUKZONF5pXVtMlYf0c2fIQYA/M=;
        b=HoPeXDZegeauV8fk4HkR0MTm7oOBbt7Dvl0oKaliZvluOxOKIO4N/t56DqDD6sJ36p
         XcDquhhhonuEfPwLZA8MSnOX9cdx/pVjuQa3iR9RJ9rxei5yC8IrKJ/Zef+F7VYhCwc5
         vKYT7lpldjZHYx4fCVlhJAKFWhGZWBkbIBCQ01cZ6l5MWL/gRulGC8x5eAZL1rkqBqkX
         N7xpuKwXkTJSf1v+ctn5Yj2zhx6VB5UIQpbFkivxt9WGmMdoZYEmbt6dzYoXW7gmiAVS
         yIY92jHw8fwnJrPpHj3UO6+HeXgClQtJi+JZmESVmDX1bpXAZIerDXv2r58Tf2WOlMCA
         Qf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185410; x=1692790210;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW8z8LGGRJ7EeAkhtuUKZONF5pXVtMlYf0c2fIQYA/M=;
        b=ULnaQkZ3cdq+cidi6ERFdXj7vRn0eWVAk9FRIPUbnblJtZYrVmCINK0qa8czYUDm72
         Ih0bg5eekHubd9lRr+38SXjrhikFRlldhV9FkS/8U1XlOVy4MKiywjAPfbF3rVjdurK5
         ymIMze8AdcRWkwQjBcJF8P+Xp22smbpRf8jotMkkTYtc2ceUh4NDM5EiEg8f2SxtO2Qc
         wCNUvOO5kXDkQqPe3Q4g68yQSe2gF5hOKWNtahes6SOvmmG6rvnlqPgKK+PA9xmNwQ9j
         Tj9fJUtvZcICKXXUFCZHQUyY6MUhqoePnD6QEBfwKzqv79f+zWN9ZOff59JZg3hi4Gst
         iPmA==
X-Gm-Message-State: AOJu0Yz0Ipl2KAG/2JG6Rnv8dFLRY2wCwSZsPxBZSRhMRMwWdALA8i27
	senVbDU+88wP0hvfox3fD2Z7eYyVgEWYVZ9k7NFPDw==
X-Google-Smtp-Source: AGHT+IEmca/AOA3RkXSlbYntBNjhQzSfBOq+UNlqwjQYmByvw9Vko4OYKBi3iEnT/Ro62mPO09sKnw==
X-Received: by 2002:a17:902:74c6:b0:1a9:b8c3:c2c2 with SMTP id f6-20020a17090274c600b001a9b8c3c2c2mr1811730plt.37.1692185410253;
        Wed, 16 Aug 2023 04:30:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001b8b2fb52d4sm2177plh.203.2023.08.16.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:30:09 -0700 (PDT)
Message-ID: <64dcb341.170a0220.e77b4.000f@mx.google.com>
Date: Wed, 16 Aug 2023 04:30:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-14-gc9b5a049d8ea
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip smc: 3 runs,
 2 regressions (v5.10.186-cip37-14-gc9b5a049d8ea)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 11:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12669

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.186-cip37-14-gc9b5a0=
49d8ea)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-14-gc9b5a049d8ea/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-14-gc9b5a049d8ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c9b5a049d8ead0f771ee3424c42b20632ebc5b3b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64dca0822d37da3f2835b221

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64dca0822d37da3f28=
35b22d
        failing since 408 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-08-16T10:11:13.606914  <8>[   12.851148] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64dca0822d37da3f28=
35b22e
        failing since 408 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-08-16T10:11:13.593024  <8>[   12.837435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

