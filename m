Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C4C4829A
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 06:05:29 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.14564.1707285928156553041
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 22:05:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vnCpx4at;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d93edfa76dso2544785ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 22:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707285927; x=1707890727; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/czr8BZSQLC+jYNjeMble8Edu45vehUwNq0sD7BQuMo=;
        b=vnCpx4atAjfhYmUl1ryW6ss5z1Uk1SmycuRDX3W2N4APLGwnRPtMljnMK3mBx7MuM5
         0RpBuU7IosEEjYaoxdKdo1y4N0mI0yhQmESm87JVy2oPleEa0C1AQ3IzrDKkTI7lIjqq
         P85+JjQUYxZP3wZwcApZXyO/KWjRf3c4oDp7BS5OBtC4D4ZLG6J/wfIwCFGLm9Z5kBJe
         QKEyGFJAStCXE7dT1eRqHzNZIgU/umJf1ETJ4QS1/Ev+qvHdKMAl5rc6RSPt9KnbwASL
         xYzx8BhMRNZjSE3toX7NUxQvB8MmNN1Mg15aI6cOdL/2SLeMVH6uq+LRdIHW/bVEmPel
         1VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285927; x=1707890727;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/czr8BZSQLC+jYNjeMble8Edu45vehUwNq0sD7BQuMo=;
        b=ssYzKTvh7gw/bxlq/0fWsYO9K1bbJx9LrPsoaAs9O2KFq6pemEFsWGU7yI8cg/9Gid
         qNA2lXWvBqsUByrJ985UlKuEm40RH4410X7wVRXuGJbNtYK5llCcmXv4STbyLwiJSF60
         PXIqIFIH/jNAczX9XPR0pj3WntK4durlmothkL3VtPi2y69klvJtoaz62IOlUeskKtyE
         XXfLVUykBgY9mVFg3xANnaCrRlPr4cwDeMiocP7Lk3jpL1ClXIkE0kJNl+pmKgThCZYz
         7JYwfitf42bi5qT15vFj1FB7dDuua913DA3aKrN2Y9cgFfIGU6M67OsWsDVQ7IaMDTT2
         xeZw==
X-Gm-Message-State: AOJu0YzGjhcRSY+MJHGiNZLUNTdreaWgUtMVOrG2q19a6098qV+pPVPZ
	fxTh9NXcFlTaYaHvLVihCf+ICqwVHWig1/NX5MlxGG7CYfNRa59BSqgABMarj9G256V4kvGHgGq
	d
X-Google-Smtp-Source: AGHT+IG0GCInS+u9TdcqMkelRi+k0hF1n21t7tHAtsYj/4Beb0/mOmbBJXqAOn3lzjdU1SmC8sg4uQ==
X-Received: by 2002:a17:902:e54a:b0:1d9:a890:e714 with SMTP id n10-20020a170902e54a00b001d9a890e714mr5201044plf.21.1707285927071;
        Tue, 06 Feb 2024 22:05:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWu/03DqG8DejzrPoC7tzk9d1eVSoz8XLLILJbMlh+3C0InpwJsVUsvD9gLO3suyT91ARt7kXKkT9L4pS5AH7J+23a5m2RjkFSgam4H4uA5EaasbC1RNLxGY38iUtVddtwa1Dl0WRmLdh4TAuqtJxY8Ew==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902c1cc00b001d739667fc3sm546101plc.207.2024.02.06.22.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:05:26 -0800 (PST)
Message-ID: <65c31da6.170a0220.9bd0b.1669@mx.google.com>
Date: Tue, 06 Feb 2024 22:05:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-gd530578b1386
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip72-1250-gd530578b1386)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 06:05:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14872

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p72-1250-gd530578b1386)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1250-gd530578b1386/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1250-gd530578b1386
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d530578b1386a94e84c4ef7993e59fd028af441d

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


  Details:     https://kernelci.org/test/plan/id/65c310b8e0f52816b38e1e95

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c310b8e0=
f52816b38e1e96
        failing since 34 days (last pass: v4.4.302-cip72-1187-g657481329b53=
c, first fail: v4.4.302-cip72-1224-ga0ac575eeff8) =

 =20

