Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2706E743DB
	for <webhook@archiver.kernel.org>; Fri, 29 Sep 2023 01:08:40 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.8452.1695949720304303065
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Sep 2023 18:08:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=i3GDFkqx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so9865449a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 28 Sep 2023 18:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695949719; x=1696554519; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SFdZLmgEfloWmdb12JbjB14GutZDeq9lLj8Juj2nUaU=;
        b=i3GDFkqx+GWKTnI3FDvfTBlwISjtQN+TdBZpw2hLgXCaQMGkt6TkazbrhJ+5Cndjf7
         uCOfJWE9begONlFg9hWUFeRb71MEKCo8fLUmtTWBpy5of4nGMAyn28j3sftTAddQchmJ
         2FHXMehDhj3mGSTqHBFTjJTVAyCU7BuPpzxFZZ0jh4sCbAkcKtO9lYOYU8hYvkbsZeTb
         bDA4YeQnb2SNLSKmTjfvVZ0U5Hc26aDjI7/qB6irLxHbze5ZgpZp1hrfOOxTkXjS9JnA
         OQauHi372cIU/FJQ+vrmBMlVV5kFCLfkM2IFPEs+hrYsQbVAgknOB0o/xtn8qKqjb1q2
         0dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695949719; x=1696554519;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFdZLmgEfloWmdb12JbjB14GutZDeq9lLj8Juj2nUaU=;
        b=K4E+7dpaGB/MPqnawNOPf7eN/bYphEehW5jeJEowWeAIePp0sPOZ2J1EySMffh7Bzu
         U1zVXJcpEYqjW0Qw2U9R97Kh6WM0SOTJ2Xw4Ikqs6iQ6EYkeUHpdGfVj+zZ6ZamnxXYl
         Mh+Wa/J76K15H7Rw+OAx1k9FY054U1A9NTVusf5+GrJHr0xhOdWierAnRtQNUpb/6kj1
         56xMvCfxZ2bPhOouCkh+uBsYBlHo1zQ//AUZ/VZkK81yJaZ5QtEV0x9bQNskm/Yz/Crc
         jh87Gs4rjphZAC/vYS/hGFY5gyWYGYhtMh8WgVlKnhF6owTgdAFtbJmZGXXki919F5F1
         lkFw==
X-Gm-Message-State: AOJu0YzHPSG/g7AxfB8S9DY1CZ4kXGY3xWpkd/jRVLZPtjKyWhkhD8SZ
	Amt2tQt9Lcu8lnkXzgomGS3ndiolSkwkQDdeyLHOYw==
X-Google-Smtp-Source: AGHT+IG8Iy70E/VHnvFN0Vd/d8Cjw483MKmtnkmJ9VNG9i19tIfkX6NGViPFYm1vVbYaY2QjRnf0Mg==
X-Received: by 2002:a17:90a:8cd:b0:277:70f5:115d with SMTP id 13-20020a17090a08cd00b0027770f5115dmr2859923pjn.0.1695949719246;
        Thu, 28 Sep 2023 18:08:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cq16-20020a17090af99000b00277724dbfc1sm176609pjb.53.2023.09.28.18.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 18:08:37 -0700 (PDT)
Message-ID: <65162395.170a0220.7ee86.0e22@mx.google.com>
Date: Thu, 28 Sep 2023 18:08:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.295-cip103
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 11 runs,
 2 regressions (v4.19.295-cip103)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Sep 2023 01:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13252

cip/linux-4.19.y-cip ltp-timers: 11 runs, 2 regressions (v4.19.295-cip103)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.295-cip103/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.295-cip103
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0bb9fab6f834f73d3a71af029f5bda19d99b33c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/651619824529642bea8a0a6e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65161982452=
9642bea8a0a73
        failing since 306 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65161982452=
9642bea8a0a73
        failing since 306 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =20

