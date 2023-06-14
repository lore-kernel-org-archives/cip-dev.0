Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9CFEB64DD
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:22:45 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.11599.1686748961495821753
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=2MjM23jW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-662f0feafb2so4929653b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686748960; x=1689340960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZQmj6fqx2FzeqO0L71hV3SY6DbIWjcjkRP6ZRMzvc0=;
        b=2MjM23jWygWVYwnBb+lDUfD3mG+osdY1lIaMeLO0R84rYi8SOyiJmKzli24Wz/joO7
         tFpCQ52P8kRQdNidQAVJpbxOnevtF0JD3+inUSJkrLfZmN2SPU6//I9pOv7BNmzqNMKz
         5ePPkn5zoijxqrMWCFka4QjlSI6Ex26J0FcgfkAQxGdgtg4k6bNnyu1JQRn+eSy+zYq2
         0yZWReR/pYuHE0JRdGv5pY3kJM40T/0Lu8BQJjLgTl9uMrZu8qxi43+SGTyBfsLgl5JI
         UndPmMz8ivVVlaEmsO1TmR2LqX3fe0T+/OPYZpvO5e4Zg41KBRIwH5ZItzWzUT6nOsDQ
         xJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748960; x=1689340960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZQmj6fqx2FzeqO0L71hV3SY6DbIWjcjkRP6ZRMzvc0=;
        b=WkjGR0H3RJg5u9Odfc0vO1+1CNGVuLBnsYOgZYSnm8vhdb/5JfgfFIS0wndI/uW922
         cxgmmJHlg8Oju0T9ddu0XkprS16G+dA3zLgXEsk0f3XYQVibE2hbUURZKjNT0Gj6lXr0
         xepW3Uwi+N70iCSWy9hCMGr6BzqRhPg1NHm/bioeKhRbFB5CDLSPNJukXhRQ7MjXNBCE
         aRlA0iOHAtwz+rmphVgYLoPBN0GzVdteesVgkRiMKo2O24ou4RmeXNehUxJzeYYyrOSl
         OOqSqaMZTPZrfvaAG11uHswI+tm5XbwDHHdLoPpzgs/Yms5mTFqUTCZVI7Mrxv+7w+q9
         JFBQ==
X-Gm-Message-State: AC+VfDxGW5HjXP7ZQIrYaQsS31fG/vgqk9y86CMxin/K4igRPsGTsFO5
	OIz+jiPL8G3mKFEafo2uhGob7TMv/DeXyYTlcAwrpg==
X-Google-Smtp-Source: ACHHUZ7p/orKzQ5lOEu2+Y0eShD3YXtnpMa4shjD3Z856AI9hsKq6TN/kVJ7EQFAwrqEEh0uv5Mavg==
X-Received: by 2002:a05:6a20:3947:b0:11d:8c4:3966 with SMTP id r7-20020a056a20394700b0011d08c43966mr2224452pzg.13.1686748960533;
        Wed, 14 Jun 2023 06:22:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b0064d413ca7desm10655007pfi.171.2023.06.14.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:22:39 -0700 (PDT)
Message-ID: <6489bf1f.620a0220.14d9a.53ec@mx.google.com>
Date: Wed, 14 Jun 2023 06:22:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-1-g7cde3fba93966
Subject: cip/linux-5.10.y-cip smc: 4 runs,
 2 regressions (v5.10.182-cip35-1-g7cde3fba93966)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:22:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12028

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.182-cip35-1-g7cde3fb=
a93966)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-1-g7cde3fba93966/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-1-g7cde3fba93966
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7cde3fba93966b9614ca285f91928a57a79f7f3f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6489ae83db705ea296306146

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6489ae83db705ea296=
306152
        failing since 345 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-14T12:11:32.198192  <8>[   17.254756] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6489ae83db705ea296=
306153
        failing since 345 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-14T12:11:32.184397  <8>[   17.241090] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

