Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDCC10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:27:56 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.83928.1701955675214030285
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:27:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wSpoOVs2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d06819a9cbso6375705ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 05:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701955674; x=1702560474; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uYfA+iqzO2dBt/ZiOAS/V1ysepeaz539dq9xLhRSCz4=;
        b=wSpoOVs23Kg+eFKFN89aBbo8RGQo+lyecuCBqA/Ko62kOTr2FwnxNxX+J2s8cYzaWd
         Q6IOW/1jqVd3jeJFP8lTDGuVo3uKVStBUYmxqALlIYG/8h9MniS2qVgGiegsaPxXfGFG
         Ud7avahn5UeWGvPSEmyd7Cm0boxfh/rR+d4ECacbmh69LiTHQjSD6MfloL+5MoPeVcGS
         lkWevu8A/rvk29zOKpssmbywkHBN4N0ZjBD7rXNF8NgD+JcOS0lYwimxayPsWUqFJHtx
         YGVlA80ye6X1lgdgtWR2/Z7x5xUjznVEYCfyXerR6fwRSkcBXGBQ2ddYvqdBOCv+1orf
         /8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955674; x=1702560474;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYfA+iqzO2dBt/ZiOAS/V1ysepeaz539dq9xLhRSCz4=;
        b=emxZDTun4C6Y4zOQ9oxuWduj8EI1nFOjuOZ4Ttn1KURVCy6thrwFUJ2X0npMIy9QMV
         x0MWNMD8Bq5ef7udndFsHPiKIKWEigpZRnWdVQwILd2butvhyVmYWMlQxFnmrdJEifSk
         s2HiX7dcwlKNgrQ3SiNk3G7tD1B6VEfX/t8AHtDTZtbWf/urOgJ5MrDl+T8gtA4Kq1p6
         4aZ5SqJtm3NX0gkJS+GqlFliSG7tPbswJoxi3eI+k7xJansxxCEiBoM+TmLQ2V0RJm7t
         1+acgRmK920Mr2x3gZ5rAVY4OUYDU+L6iCVlyEQpSA7pXUzWPGCKHk9DwJ6VDgxvD0AD
         /Sog==
X-Gm-Message-State: AOJu0YwJXEo4041+dB5OE7D4R1iQcwKPe29LcK5KWn7UnYw/H+IChaYu
	6FxnPOCizqJr45jwnFUIzjmPIheOTHx2knymbVaW3A==
X-Google-Smtp-Source: AGHT+IHBFOS7INkeYaAfRlcFY2Ei6T0vpeBPixA9LEeIW2mP1xYei066MkKM3/z+k6fYZtjwS6D5Ow==
X-Received: by 2002:a17:902:ceca:b0:1d1:cc09:50af with SMTP id d10-20020a170902ceca00b001d1cc0950afmr2080476plg.71.1701955674339;
        Thu, 07 Dec 2023 05:27:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p19-20020a170902b09300b001cfd2cb1907sm1382071plr.206.2023.12.07.05.27.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:27:52 -0800 (PST)
Message-ID: <6571c858.170a0220.e6c5f.2c25@mx.google.com>
Date: Thu, 07 Dec 2023 05:27:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-g38e219eb6aa85
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs,
 1 regressions (v5.10.201-cip41-28-g38e219eb6aa85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:27:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13839

cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs, 1 regressions (v5.10.201-cip=
41-28-g38e219eb6aa85)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-28-g38e219eb6aa85/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-28-g38e219eb6aa85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38e219eb6aa85cc3be6dec326b24dcf8cf438d01

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bceb19ffcbcda7e13545

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6571bceb19ffcbcda7e13546
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =20

