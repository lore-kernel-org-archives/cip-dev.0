Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540B0EE01F7
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 17:40:02 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
 by mx.groups.io with SMTP id smtpd.web10.3473.1694626795800576254
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 10:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lPiD0iYT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.45, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57128297bd7so80825eaf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694626794; x=1695231594; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g9Y6xlhQUm8VFvl8+KaHaLrwO1e8bbqfoLtHUy28kpE=;
        b=lPiD0iYTVHfIw81ed96w9t+wP5UjuArjUnNZw6hEbmdyWFHnPcaq5Xf3akE1io6CGE
         ySzgjTTB5/RLM/6kVk68N6O/oBhENEn+E0wEulNKJMPr3Svx0IDAB6ux015cRoCwPmBN
         FdFDP7JCefxSupyYxpvGDAjx9H+WH6Toef/GQJ9AZx/I/vquZtMkei9zgFfSCJJ/00i1
         shVm0+oJ3r4qa5E4bjUpQiaHxtm/ueCBxzDIkKHkIS1Zld+dY4TwbyJ8OoO+NqsT0Bo+
         6mOeo1ctkdX0CFJKgHCegVpUmqLhxO4k2zylMbqvhLY1oAD1gA2yS2JQk84uxbUqQgNT
         Ximg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626794; x=1695231594;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9Y6xlhQUm8VFvl8+KaHaLrwO1e8bbqfoLtHUy28kpE=;
        b=XOfGFE0hsgp3IVLbMcd0v45S5agqwOPbbYMzwE/rq+jNzsoBw2tTtTxyjM9ERb11W4
         74DoTYXaeM69y2CVfIlXlfeVP/3Z5Hpy35GSY3j8bXVPLPprLspeQxII5IegJhngHkD3
         P0iLmgdmRP2GOTZFoW6d5Okv4mjbdjkK0ewqA75vtWaD5FriIIOcYWf4s+W4oT0fZcjv
         dOLWm06UhFGyqtFL0SS9RjfYpU+J21FQeVVfQM83jag3eM8iJjPsxYLVnZHYNmttLYSw
         0o/bHDNrTny0BXwHmMReOTvUq2AJjiDJH7nJ96RUcBujFzJ2TYe+BC3bWenox9bJ7ocE
         RqEQ==
X-Gm-Message-State: AOJu0Ywadi4ChhHWcn/Nl7jb+7iTJhIBBiFp7iz05oZDKDZlATItOiQv
	MIr/1DgFOpk1Aei3iFrYJdm/Q8FKFGs/G08jbpo=
X-Google-Smtp-Source: AGHT+IEDAW0kq070Rqma5PR42rzqPRFZWeUF117WPhD7ZAJm4AOam4ijwpFFzIntOZUe54Zlqmu2qA==
X-Received: by 2002:a05:6359:621:b0:142:d62b:304b with SMTP id eh33-20020a056359062100b00142d62b304bmr2525879rwb.2.1694626794584;
        Wed, 13 Sep 2023 10:39:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bt26-20020a63291a000000b005777b3f000asm4828794pgb.18.2023.09.13.10.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:39:54 -0700 (PDT)
Message-ID: <6501f3ea.630a0220.68444.0a58@mx.google.com>
Date: Wed, 13 Sep 2023 10:39:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.191-cip38-29-g9e1aa2001db8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 3 runs,
 2 regressions (v5.10.191-cip38-29-g9e1aa2001db8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 17:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13117

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.191-cip38-29-g9e1aa2=
001db8)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-29-g9e1aa2001db8/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-29-g9e1aa2001db8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9e1aa2001db862da32812062860b8756cbc8890a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6501e03d201260791c8a0a88

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6501e03e201260791c=
8a0a94
        failing since 436 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-09-13T16:16:00.186479  <8>[   12.695329] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6501e03e201260791c=
8a0a95
        failing since 436 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-09-13T16:16:00.172670  <8>[   12.681725] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

