Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38962C0032E
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 19:00:01 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.52209.1698260395965608381
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 25 Oct 2023 11:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HlqLxLrP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-27e4e41a4fcso20673a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 25 Oct 2023 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698260395; x=1698865195; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZyMkPN8wnrOnPc/qUBmIvelLBS2GGnFptwp3/Oq69w=;
        b=HlqLxLrPpQQQefqpUOFkrUjfky6jcNRlHyPv2VO/4Sbo1wL+6c44rJ435Wl7DnCd9i
         YQirRiaQou34SL8WaX0WBgPzIRIRXnZjf3QkJ+XwKVle+FycExfPMk4ouHjODLeWKzeL
         muTufiXKE0iaOqn8snlHJS5mG0eLQ4c4qcPG7bWBt3O5MVmKCQt5SK87eE8LzMX8xglW
         Zaj/0xZoBh8zYOAtTwRJVJMjrmpfhevQK3fCVyF7/qAF2SjZkkbBne/2Tc6W3r3uQF+5
         4hB8Kl5U/FftbWYNglEBtK6Azn+JI7hsLaEar7PtsDyvmLmHi2X8B2Aq/1a+E8mUG2Zw
         zzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260395; x=1698865195;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZyMkPN8wnrOnPc/qUBmIvelLBS2GGnFptwp3/Oq69w=;
        b=uOxFUoywcCsUx798TS6hhVydyqf073Xa7NaMqorRYINViceMWgRvC1q281bMKDErGH
         igbVmbgah0qBDeshs7J09jdslxUIc5eJI5EPhiBMiORylbcN6imi+rpT4ksdNhLeh13+
         8CQzK9lex+o72Ny8JlqYWxHHZamEk4nh3UkLM95ggRckkaC5o8mr5gLbCicZ0x9oRucw
         TM0sf+DoCMISik+gZaYhKjsU8WWFkiaMrODmeTkmt2pR2exlqVtMB0+wjif3dH8pGwYD
         rEvEfUxeBp5u3WEZUEm5hn18fE1GwWCu0ajmWTcTear6E5lbJgHxp4ctalWHtkUjLRGl
         u7Sg==
X-Gm-Message-State: AOJu0YwsCRnHYhldsbdFvM7xWf+CvfH1CBH9TK3Gc9gCD40dyKYZt0+F
	nadPERcQOi4/hwH64Oon0fE8SkvTLMWGOCc7mYQ=
X-Google-Smtp-Source: AGHT+IHDGMNZ8NHAu3slfOaakAPCJye8yCYiDVvNjMYCPsRO8RXNo76xNAJoUJnTGYjKyaRC9ztc/Q==
X-Received: by 2002:a17:90a:7066:b0:27d:2ecd:6a23 with SMTP id f93-20020a17090a706600b0027d2ecd6a23mr13225572pjk.14.1698260394557;
        Wed, 25 Oct 2023 11:59:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bj23-20020a17090b089700b002775281b9easm219368pjb.50.2023.10.25.11.59.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 11:59:53 -0700 (PDT)
Message-ID: <653965a9.170a0220.7cc80.16c8@mx.google.com>
Date: Wed, 25 Oct 2023 11:59:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-193-g33550555e507c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs,
 2 regressions (v4.19.295-cip103-193-g33550555e507c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Oct 2023 19:00:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13449

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs, 2 regression=
s (v4.19.295-cip103-193-g33550555e507c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.295-cip103-193-g33550555e507c/plan/ltp-ti=
mers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.295-cip103-193-g33550555e507c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33550555e507c555c8f8e194b8778427898d1c3f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65395df1192e916369efceff

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-193-g33550555e507c/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-193-g33550555e507c/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65395df1192=
e916369efcf04
        new failure (last pass: v4.19.295-cip103-95-ge42cfc8bb88b7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65395df1192=
e916369efcf04
        new failure (last pass: v4.19.295-cip103-95-ge42cfc8bb88b7) =

 =20

