Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF79BC4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 21:14:41 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.1711.1707340479421290105
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 13:14:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ueZXJP8s;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7354ba334so9270345ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 13:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707340478; x=1707945278; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv8HXbiT2Whq6ELZhM87uBdRxvcI0oxUDbgtYnTwbOo=;
        b=ueZXJP8s4ZuOY6H0AXgft0jxmJrTZGZz/GEdex8X77mUTPvr0sEygr2KjP/QCB7RLr
         lkk46HtZImmXRnEfOTuEZgNQAbOwoXStIP1utX7LXbRFFJR4RcLB5vZ9laOyd90wTRDr
         dnmvA58nXncwNLYOKibtUhYiJYp6WJC+m+J84P2mA7agwiviOzf85YlWHGsoNiIcP3Ro
         rSQjpEmLvDmropwRpeab3W0AhuitSK0MT5anQ80rDtzJFTwaCL7cs9/IF3oEdNSHK5AY
         Q9mWaHaa+C3KGZhWIhtMDtbjmu3OJ8dNav7rdVjubNxc6nAA3rj5UNKm1M5CjMAVvhWE
         jc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340478; x=1707945278;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv8HXbiT2Whq6ELZhM87uBdRxvcI0oxUDbgtYnTwbOo=;
        b=MNHLqepI5gHIXPT5J7HqByyapU5MzMSsWG5GAtgsRAbibdwhFzH1U4r/ka++XQWpcB
         D4SZAQVolUTRtykOmoo88SPkNDbJpwYlpGsx6bSEOGTe9NI235463NW7g7w/YlDywXQh
         sUR3d89h+0TGObJ8+uV9Ger7sD0hUz7S745oQ5SBqspeCBGSPOtSpMzCLoR5UivXfd6E
         dys8dMzDH0iv5PtcuSu6eAp40uw46sDWhqMrRqU4ii8EBWiq5myB19OsXTwRYKqQyUb5
         l4CLUh5t6mgcvtsQy8GvKvEJsI4eC6hdngNOm+XIW1tvN3W1tGSgYQyhifiRMfY1AR35
         kP3A==
X-Gm-Message-State: AOJu0YyUencm1l/TXyvQts7vmwMilTZroTSKPhimQpPjgWfuspHtlljK
	VfW1TOAxmq/DaGyBoiAQ/Z1FmKWWv6+Goo4PbfhFhSyqACMnvo+F5s5CGP0ovGPBPTsP3cvarpG
	/5bk=
X-Google-Smtp-Source: AGHT+IFlmpCjgGAsisljxq2iuRRBx6o+a1oi0HvTd4LVE3dWiape70Grqz+ln6SVU4AePioHPGL7mA==
X-Received: by 2002:a17:902:ecc6:b0:1d8:ebdf:183a with SMTP id a6-20020a170902ecc600b001d8ebdf183amr7057653plh.6.1707340478604;
        Wed, 07 Feb 2024 13:14:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuWNwKsX91EIJgRmsPVAYomgFGhWZpdrg872oDWoDi96sh9l94NJLUDXI6u9KVS9KfMvr//5P0vrVHhCFSU0UENLi2fD4Hs9SKbsMSTakuVhQovO0Vunv2mlnYBUhH5JFO5VBanrj4XbzD1trzYmevZg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090274c200b001d989407f97sm1917899plt.257.2024.02.07.13.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:14:36 -0800 (PST)
Message-ID: <65c3f2bc.170a0220.3b70a.6628@mx.google.com>
Date: Wed, 07 Feb 2024 13:14:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g681701bd9bc1f
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip72-1251-g681701bd9bc1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 21:14:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14910

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip72-1251-g68=
1701bd9bc1f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1251-g681701bd9bc1f/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1251-g681701bd9bc1f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      681701bd9bc1f65237982eebce24afcffab64f4f

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


  Details:     https://kernelci.org/test/plan/id/65c3deb442717ff7168e1e90

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c3deb442717ff7168e1e=
91
        failing since 35 days (last pass: v4.4.302-cip72-1187-g657481329b53=
c, first fail: v4.4.302-cip72-1224-ga0ac575eeff8) =

 =20

