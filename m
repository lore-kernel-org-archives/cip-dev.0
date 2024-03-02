Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05466C54798
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 23:37:09 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web11.63459.1709422619459772519
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Mar 2024 15:36:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Jbvn/HyO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.169, mailfrom: bot@kernelci.org)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-364f791a428so17744775ab.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 02 Mar 2024 15:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709422618; x=1710027418; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9cz67WeUuDAwQixUXJZXLFR4x6hSHS5eWc8fdQfZp5g=;
        b=Jbvn/HyOKxolsbuYH+NtTFdVdbrDcNyJ3d/Xp32Uc23U4HNy4TuH1caObU2SuMTyxM
         B+fj2OMn69YsPStuRPNHHt0xUIZS5on34/S6pwosXl7HLGf9BAMFnY9ZSIz0mXhZfiw+
         bB4n8DqWxfIFvwgHxtGvbcOUePDUz53gXUBF3vymhKkjbG0w6dCYoLXFKAzB/B1+IU4n
         nSglUAfGHE6XGQXNnv1U+WRljzJQ5emfYKOPOkdyMr/DklCZnqHVBb5zWnJPeX+J994o
         Dqegpns65wkbi6bJJFIsBQ+ZBRmVvXdF9prNLtzQzzIUDViX4BW6lwDHwbo+H61yPW/r
         Ck7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709422618; x=1710027418;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cz67WeUuDAwQixUXJZXLFR4x6hSHS5eWc8fdQfZp5g=;
        b=bFDhIKBncNqytuKo1G30na1cIiN9Ja8mDXmBrdKNKh1FAU3SiuugxuFfXw2YD36Pyg
         uwMqOcTihv6a3cjy0gvHmD3auAZDY9zFQ8Oz/ibXyZrpvipaLcSnMbHvUdTCdA6O2LDR
         jN7kITZ2s0h9jvep3NAhkFgqO+TGXDOLMHTNEErYQLDIP0z3bERGjCTtW643mTogWicz
         7yynGppD6PczcVt18fHpQIqccZT4U/FXaPBmYHa3SntTvf3Y7b2YCRDBFA+W7eh/eoCk
         BShoWnuj5EySufGeGimU5KNd7DrPmiSjfath7xOdI8uEtFeOsX6GBqz/DVa7kjyDq3Pk
         mZRA==
X-Gm-Message-State: AOJu0YxZMvXT015DT7pIBEd07ZKzkZmr1H6HbQqEJiyqW7u21NyV/L4h
	y9pNmFb1PKwmMkTbrOD0+gZ5VZfZvN8ksWc3NE7u9Sd8XLc50EbtV17Su822RN1GQFlKD7PkrZi
	d7Pk=
X-Google-Smtp-Source: AGHT+IGaMg6AHRDyifeDXHFNSWMNzWwWZ8YdTDqZPRU3ud/QmmNBdysgrMz5qbL9yYLHNvC2YmgJsA==
X-Received: by 2002:a05:6e02:1d07:b0:365:245c:6c9b with SMTP id i7-20020a056e021d0700b00365245c6c9bmr7500664ila.13.1709422618177;
        Sat, 02 Mar 2024 15:36:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o133-20020a62cd8b000000b006e06aaf5e58sm5178902pfg.34.2024.03.02.15.36.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Message-ID: <65e3b819.620a0220.4f60.6a75@mx.google.com>
Date: Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-404-gdddfc5d4f194
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs,
 1 regressions (v6.1.78-cip15-404-gdddfc5d4f194)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 23:37:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15170

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 1 regressions (v6.1.78-cip15=
-404-gdddfc5d4f194)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-404-gdddfc5d4f194/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-404-gdddfc5d4f194
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dddfc5d4f194925df6ee3d06e86b1d1e12412f06

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


  Details:     https://kernelci.org/test/plan/id/65e3aa2bac509bfda7637080

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65e3aa2bac509bfda7637081
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f) =

 =20

