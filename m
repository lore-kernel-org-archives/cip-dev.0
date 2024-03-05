Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD7C54E49
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 13:45:34 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.23310.1709646326265839383
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Mar 2024 05:45:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Kueodhv+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc139ed11fso51508325ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Mar 2024 05:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709646325; x=1710251125; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lnCAYAbMHKa7XQjIuAYfPo/lhW4A9sYIPfEH7t+uM3I=;
        b=Kueodhv+bKVbsQGLg9/glPtcmiOUiOw+sROyP4y7bQlxNEElAdBt+7tDhOoFeqLDYf
         2d86gBv2Q8GNwYS4IkWpXHw7fpWJSanGAgsEyNj9nhHqPsY4hZC/A2DD6j7MF5GVW3s5
         HAjfpP5Ww+lKQx8aIMFqsYcCch/fxYzy8bigiORKUXnEFR5PG9/lHQK3CVd9ov7Cjyg4
         UlmgszjedtehxNng/UNWtbQNiKK/R61TbrshwA92I+qq2qu8ez1efocpXjuJBD69VtjD
         884z2in09ZpkjZEbiJViOdBKlol9Q9EYVkT+MwL2VLd99VqLa1sWY3lf4riyaj49Hzwk
         HpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709646325; x=1710251125;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnCAYAbMHKa7XQjIuAYfPo/lhW4A9sYIPfEH7t+uM3I=;
        b=EEk0MBC/VCkThHoQjFVP2GK99UTrVx6iGpayCgRVWmyoZzltnQL0EL8S6ezLoQumfP
         K1I7yavo5LNSVEuMSDX0UtxE+yzWUV2sk/7FTriLlc3kcDm/9Z5s8lifHbmPpf9vNjj1
         ZH815niNFvcqhUzvYkeydjCgk7ovW8v79pay4vshRsApldZgQ1369kwAt8OFOuy5gOjG
         F5ShuWvRFnNKmELQhyYwP82UPvR6SydhQG+eo41OIqffYDrothEcbQ/C7y5w2mJtnTn6
         KzdAoaFXrabuZqPaIxXQ33/PUQlIPsQPj0l+JGYaJqciNsFKqMSOMeKeD4PhdTUo266l
         +3Ow==
X-Gm-Message-State: AOJu0YzegQrYvUj9b7cFbhwQtuGwW/L3sMvfss+hA/4raqSI2FLtp/R3
	64/P+w7EFoCoWVZsYralPbGkme/GCm92SoWSs3QhGLaJgEok6x9Ofn3C7rJH2M+1hDMAi+6ElFC
	vxBk=
X-Google-Smtp-Source: AGHT+IHOkXh0zicQC/+vpS5UUtV9nA7PkjtCJRMdISBKkfV65O0pKqV9i3QR6fys2M6dJ51lT0h4xA==
X-Received: by 2002:a17:903:22c8:b0:1db:c649:cff0 with SMTP id y8-20020a17090322c800b001dbc649cff0mr3313106plg.25.1709646325209;
        Tue, 05 Mar 2024 05:45:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090264c900b001dcdfbad420sm9967781pli.149.2024.03.05.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:45:24 -0800 (PST)
Message-ID: <65e721f4.170a0220.ce697.6ed1@mx.google.com>
Date: Tue, 05 Mar 2024 05:45:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-2247-g140bf69dc64d
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-mm: 1 runs,
 1 regressions (v4.4-st20-2247-g140bf69dc64d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 13:45:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15223

cip/linux-4.4.y-st-rc ltp-mm: 1 runs, 1 regressions (v4.4-st20-2247-g140bf6=
9dc64d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-2247-g140bf69dc64d/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-2247-g140bf69dc64d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      140bf69dc64d0cace758052e3af9e9cc3e90a09f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e71b62ca7e09b23f4c42db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2247-g140bf69dc64d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2247-g140bf69dc64d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65e71b62ca7e09b23f4c42dc
        new failure (last pass: v4.4-st20-2244-g20d1c7153f15) =

 =20

