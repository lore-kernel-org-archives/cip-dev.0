X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.450.1652370902943254644
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 08:55:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=prnyDphT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso5253744pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3ca6IRmkTMVXqPyPam4S+zhBblmxichhxQLVSnwiEEc=;
        b=prnyDphT6g1a02CMZoWrlEL/3Oy2bAyT+cIuSQbEE32UCnRz6HqHwqMSSAPbSO2MYf
         dS66Y/EB9oxO9j4fboAzb+Qogf1VqxUofRak5WPvD6/avmN8NS+duvt9cnYAOGt/nfHR
         HKmERCOgsEguWc3rqPd7BOqvMDrOMyX+yK1snBbCdEm22GK+ri8EfPfkptJZba76WEZ6
         Jego/KL1a9k2wG4Q8bHvzDofnGoOIvSu8q28O1UJUXAqjuK+HMiCEhWEjThIjNNJB3hE
         zH4GR9A8v+giGOVBzdqvMkesBf0o7vm5iQ1FVsS5qagW6y95Zbx0IU5SjLN9LHso2obA
         2PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3ca6IRmkTMVXqPyPam4S+zhBblmxichhxQLVSnwiEEc=;
        b=gKBn4AnV5T3qN/gMlwIXEP9cO9GIxOj6MusuFddKQ/xLYZC5u7Twn/mh1Oh8sXonvz
         2sQexqylxuLrhZFwbqA+X1tArt19hjsk3ZLfff1FeVCQsRJqhpOa03DCLr/26xJKAft0
         muXBF73sInfSG2bmnQkOEMhrT90MsXk2f2EuJZY6TSiKb2BD3VYkiGNfpSY1FF3vS3NM
         wAqDz5/mjOYij3stWzGKdH9UtdOfTRdcFj4PKPzwLZqyg16b/yGp0Q1z38GW8jIO4tkH
         crqR7MMl+sHKGTkn0o3RXfhCRYaQqNPUGLG1jGk/T/3O1h8o8FqVSqipUWu+hpJlAB5x
         KZ2A==
X-Gm-Message-State: AOAM53262UTU/Aks3swxFd20Ru05ecKneYp9l6d7DsTkCci7PEF8FhHQ
	nreVv4YrsVAHrhPpBbsSLUGBdwrsGQrAvEI+qMI=
X-Google-Smtp-Source: ABdhPJxfLswvEgi7cBOWQksP4XPkp9+q6kZ2KBMGPlIphPgdgFfEJL9CWDVVajb+5xiosqbKysxuJg==
X-Received: by 2002:a17:90b:17d2:b0:1dc:9999:3e78 with SMTP id me18-20020a17090b17d200b001dc99993e78mr11412479pjb.180.1652370902251;
        Thu, 12 May 2022 08:55:02 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0015e8d4eb22csm81981pll.118.2022.05.12.08.55.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:55:02 -0700 (PDT)
Message-ID: <627d2dd6.1c69fb81.72e23.0384@mx.google.com>
Date: Thu, 12 May 2022 08:55:02 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.112-cip6-289-g2969e096d186
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 7 runs, 1 regressions (v5.10.112-cip6-289-g2969e096d186) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 7 runs, 1=
 regressions (v5.10.112-cip6-289-g2969e096d186)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-289-g2969e096d186/plan/kselftest=
-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-289-g2969e096d186
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2969e096d186c13cc3c3fc8927147105d46895c3 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627d224b028ad432ae8f5718

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/627d224b=
028ad432ae8f5719
        new failure (last pass: v5.10.112-cip6-88-gf3397cadb2dd6) =

 =20

