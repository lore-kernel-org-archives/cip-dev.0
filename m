Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BEBC7EE23
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 10:18:32 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.16768.1682590704369381077
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Apr 2023 03:18:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Tt02NR0C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-52079a12451so6207232a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Apr 2023 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682590703; x=1685182703;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf6lq5GQtSM13CEk4pUX3BDNheWpI9+OscOlKAbXh9k=;
        b=Tt02NR0CIlyl190q7q/uMhoFJqdxViQLlROey6JtZ3bmsX2hmIjwqgVLGoLxJ6VUIr
         D5kylykaOXm1AV4LPYNNEGUzbhOS7DsWlQIHnkiH7LPObsqUNnJlEYJINwfe1PrRICzh
         1p1f8dgpDA+877BwycMz3PCbsaTWPmg7fh07kpZGiQiPCgPMT3RzT1EEe4uQIzFwlHxq
         PbtwxHrql31wCpKf9x0k/c8jYqao+wF9DHZtifd1ueUW6VimWC0xfve3eDduFIcoi3Is
         R8xUlZLKCDVLjEc5Iuinm4iExIXEUyW9rmsO3eP7UOxX1Hw3fkfEcgtPxhVdB0VLQeCK
         4QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590703; x=1685182703;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf6lq5GQtSM13CEk4pUX3BDNheWpI9+OscOlKAbXh9k=;
        b=iqWgk6UHnvbvfXbQ62hgihnQj2UigMiy/hG3Zbm0NWGPzmrY+0ZS6MgxzWf5+j7MAX
         w1a95IaRa8a0LJ+gUnUmDOg8CdJ+ZzLYJ8tqkVppfi+pMrks4u6p+KzNPdm8u7E8X2XT
         6JzEXVvmih8ziu2OZ/nFqYY8hJYe1Jwdvd4nwy5ahdP5yz8Yq+ykrGL+4MMbr5R8T0MI
         ZwWGvO/wVS4HtnIHrtw9yO6WCf5dTdg8eVjIDSey+pihgIHyMJ8RSHheCmX34waSuNOl
         kq9Wx7+2Q3iYm9DHOZjmdcXHzOmFGFROYDNWkPXfPHM9Gp5nuOJGZkN4MfmnN91nshrI
         B9Pg==
X-Gm-Message-State: AC+VfDwLAm8QaesFXzHil72Tn8CU87K5VcsNMZBXCdDYAPQ/QT/rbF+H
	EtLO5uYXeFfUEWoLVTWPVAdUdeyWZR2jBNoIK8iAdw==
X-Google-Smtp-Source: ACHHUZ6IHLa4GVfvTK5LvYJzWqVwQVJftHlz33xqVK47YbGJR8SLADKwW3IUjcHkM92aXGmnxOdvpA==
X-Received: by 2002:a17:90b:3b8e:b0:246:fdcc:f84c with SMTP id pc14-20020a17090b3b8e00b00246fdccf84cmr1265668pjb.35.1682590703129;
        Thu, 27 Apr 2023 03:18:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090a800500b00247a8ef11d8sm12922118pjn.24.2023.04.27.03.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:18:22 -0700 (PDT)
Message-ID: <644a4bee.170a0220.7fc90.c2b8@mx.google.com>
Date: Thu, 27 Apr 2023 03:18:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-g2516b357b2e3a
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-pty: 3 runs,
 1 regressions (v4.4-st20-1186-g2516b357b2e3a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 10:18:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11366

cip/linux-4.4.y-st-rc ltp-pty: 3 runs, 1 regressions (v4.4-st20-1186-g2516b=
357b2e3a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-g2516b357b2e3a/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-g2516b357b2e3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2516b357b2e3a612ef2904362b0acbb97746d0a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3b7f18f1b8b19c2e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/644a3b7f18f1b8b19c2e85=
ee
        new failure (last pass: v4.4-st20-1097-g52d843097a439) =

 =20

