Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E9C64EC4
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:37:55 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.12483.1676029067917396062
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:37:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QtNKupGg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id b5so6175525plz.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X1uXeNBKvxthHMFASEirfPLoXJgEfvHv8gy/4L1IWnA=;
        b=QtNKupGgjwZR+CB95av4OlR1Lz/9rVlKO4CL6+caXuYxywD4SMdDTzrlDtnGpGjQ1F
         ZK7tOLyMLn2o1pOgJJH6r4yKUK6FlX/f6loPusaDmPt53SFIX70407MS3pHmei8n+PtU
         fRIYCdW+NAcckL6qr4LgAAD7iandey9/LZ1BOQK9VR4nE9ThaJr3sbnvJsXXNXHFdJku
         MEvhPJ3s4VxZHE95nDDMZOll4SNWMX48l6/oLL3r8EmYB6d1WfCarb7wmljlL2/LHvdE
         HSuBawvSL3nk8mtVApT50aUE4CrSmBMhcqSOyLA+/UYr64wDx+61hTpJtM6lc3TEyaWb
         SkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1uXeNBKvxthHMFASEirfPLoXJgEfvHv8gy/4L1IWnA=;
        b=1zwaAAdOaupLbQtFOeG+1O4Q9EpL4lqJ32MT3vtJ/pNCq/f/kQQsBr4C55Fb3m4YP9
         bblLRhfBTtuQlDrVVQlTqLC3rMR/rK535+aMta4Qr7XLWAarvS2NB5n/BSMmMH/xhhUf
         sT0Ec5UxFSoWuIwKP8/O8r4qilVj98hLYuV48FednmZrD0oKGMdL5P26iDNSl8J+NhQ4
         KGhnI7PCZMVXssFbxAlaerHBqrMb6Y+y3/v6fKsNyxQFr8PT7v8RZlDni3VFbHXjUCTc
         oYlUECsm5vwk7sRoxOHGK6IcNT22c0RQzh141ajhpfAxvo91AAhriaZLadQkXccs9fPL
         lYAg==
X-Gm-Message-State: AO0yUKXhHFm+EFa/Y9zuYYIyNbBjjqeeaHrJ3dbOpUJ3CIb0Ieu3JDcl
	isrhi8c/WgCVuLcXDAfMcEKQCSkZRKLNVLuX6jDppQ==
X-Google-Smtp-Source: AK7set+6IqBO14l8ChgOu9+HjhAb7GTUYTm1SD2bAehT/3xlHUuFVvB7SgIEl0Zb2t5N+lWsRXerZw==
X-Received: by 2002:a17:902:cec5:b0:198:ee12:ce93 with SMTP id d5-20020a170902cec500b00198ee12ce93mr16269186plg.46.1676029067230;
        Fri, 10 Feb 2023 03:37:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709029a8900b0019605d48707sm3187329plp.114.2023.02.10.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:37:46 -0800 (PST)
Message-ID: <63e62c8a.170a0220.8e840.5ce7@mx.google.com>
Date: Fri, 10 Feb 2023 03:37:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.167-cip26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:37:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10645

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.167-cip26)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dd0dd3e572fd82c1c232ad1f089ca628d7dc16de =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63e626b0549aa371d08c865d

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63e626b1549aa371d0=
8c8669
        failing since 221 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-02-10T11:12:41.688645  <8>[   12.284603] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63e626b1549aa371d0=
8c866a
        failing since 221 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-02-10T11:12:41.675514  <8>[   12.270978] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

