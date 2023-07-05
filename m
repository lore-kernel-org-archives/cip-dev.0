Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF148EB64DD
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 11:26:35 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.14416.1688556393597284680
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 04:26:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=W3IEG2yr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b8b2cb7384so1958405ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688556392; x=1691148392;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MdSGi4bEE88ng0xEq88J96uwy86I5mWEg0bWmBggIq8=;
        b=W3IEG2yr7aVmzA4niAvQOXUa2jZZqkvq9xmeeNrT+rlcCk2pAOOK06HvzdkzjawS/9
         xHoz8i4vIUAfWj4NW139pPpLcBMxEDJVdMHRE+Hm4JAKKFj7vlfOeKS3zd+VOX5f9Am7
         RQHNF9nLhnRxahsk872ssfWe3XXb/95sAejKqwqitZRmIl7euXlTCOPdskwSb1FI8qWD
         nNw3G+3y1xs0HOzhmaAH1jOGBfH9y+3tXkqsUlbqs02GeFT5ZDvID3+NQEY6k11ZV6SV
         2GmXv8rjrJvSBlZNa9wi4AV/k1oiiotta1X2yW4JwLMuim+iuhlJj4sL8j0gcrYs5spB
         hyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688556392; x=1691148392;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdSGi4bEE88ng0xEq88J96uwy86I5mWEg0bWmBggIq8=;
        b=dx6ma0bQEPi87XMRUp0LfuOrO4DhmfMY/kxaCwSzMteIluq7LR8aSHgnOsyznGJsOb
         BeV7iJx53GlUod8H/RkZ7nGK4mKxJ5ZwDb9O0kE5omb509u5cgVXIL7q3ViZPxZaP0ak
         u8ngnURWKfyrFXFFl+Imh3/hm76yAjah0NKUCUDKPBhHzR7jYwAeTA8AQ26qLYXHUPfj
         yN+Gp5LzUwA2SVvvCVqsn74drojZF6gyYOlDKX/0A83KDLEnWHS+r+cm8x1wNB9D+oIU
         GYZyFde1JJJSKvfpMGaDKvA8rEugQ6Oxa5FxieH3KDJiXuyxXaFcla61YHJaNj89QWOL
         VGuA==
X-Gm-Message-State: ABy/qLYUtKt6H3fbbiyVR8VTBq2O6EIKBIB6y+27emhxazEa8wxJeEgX
	ahDhKPhvARr9UHQd7Dq+DaSJBdTjQB5+OIUbn955pg==
X-Google-Smtp-Source: APBJJlHJayxblW6HuVsRnn6RkbhRXr8ou4UDmZV5Kl7XZkimYGA1DsQ/nPLVXpBMgaWFY6kflb6tbA==
X-Received: by 2002:a17:902:da92:b0:1b8:6b17:9093 with SMTP id j18-20020a170902da9200b001b86b179093mr14205325plx.1.1688556392496;
        Wed, 05 Jul 2023 04:26:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b001b8959fb293sm5530906plg.125.2023.07.05.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:26:31 -0700 (PDT)
Message-ID: <64a55367.170a0220.c3946.aa9e@mx.google.com>
Date: Wed, 05 Jul 2023 04:26:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1430-g2fe294a51ca0
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rc
Subject: cip/linux-4.4.y-st-rc ltp-pty: 3 runs,
 1 regressions (v4.4-st20-1430-g2fe294a51ca0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 11:26:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12233

cip/linux-4.4.y-st-rc ltp-pty: 3 runs, 1 regressions (v4.4-st20-1430-g2fe29=
4a51ca0)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1430-g2fe294a51ca0/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1430-g2fe294a51ca0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fe294a51ca02b301704e4ab494c690d4b6342b1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a544b6cb847f8586bb2ab8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1430-g2fe294a51ca0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1430-g2fe294a51ca0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64a544b6cb847f8586bb2a=
b9
        failing since 69 days (last pass: v4.4-st20-1097-g52d843097a439, fi=
rst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =20

