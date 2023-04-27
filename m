Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F70FC77B73
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 09:48:22 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.16304.1682588900713766878
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Apr 2023 02:48:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3gamErQc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-52160f75920so5998760a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Apr 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682588899; x=1685180899;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cryL3iUny6ej/uatkeu9F1vtAGSddcgk6nU7c7VR2dc=;
        b=3gamErQc33d/wmTvN2ZuPEoVBTYJEd1cJ6VpGJGG11C1RBMN2To6soJaX6ZEVd+reL
         T/ljkLYDgt/3qvwM7uToEkqI55sJTmpfwvT7DpoxOEDK5/NSeailfgQNfJAbNmxvL5ij
         Jj9v3XVtYrrgysZCHz+zfZuMfkWyeySHo5oGBAnp96VW6GA+reIdvnJN4pXjQq4x3z15
         DuhD9A/GIM3BQLrW7NEBTz7cAv8lUhLx7+IX323h9XZreY1QfYTRnZWqqJtb/2pcWirv
         sadHtmm1wSKfLkKzbPoVlK7EAw4c1ItobfOWbxmFQpKww7a13lSjBmk88kizotfJJgVA
         ZJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682588899; x=1685180899;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cryL3iUny6ej/uatkeu9F1vtAGSddcgk6nU7c7VR2dc=;
        b=E8U2Lu8ozhPoTxgYPyu5HKINA16I7zn97/aO6f/HxVuv9s8yTxk6krxDTxsl3IGcny
         F9voS/xl5AuGhCVP10/Su2ebWi0eGC5NTLyUs4eYDpHcp1Wloz1hjaN8JLfumCIdH+NI
         dCcqzWGgHCGvsINrS0k7IEEQuH1SLicOn7iDu/fjuUPCSagGNiNbUMPQc0OXvJY2+fbL
         jyxr+VjcqXDYT7dcEBFyCjdSoC4bSgdXV88r9hcS5rFbt3cm+hOnj7OV+HzuceC9gIO7
         gh/UeJTjMD4alwW7kZrGaZpAkAUHtEwxG01GwmkfL9d3LjJjPbWlagjtx3bk5hOBK0C2
         CzKg==
X-Gm-Message-State: AC+VfDwtr8wKf0yNEawf7D6CQxrbe+rPUS9Kov9YsXO9gpJR58SbQiVF
	rl3aYvJ0l1SMRORRwySUbTxI25PiHlQ4KzSxXpFl8A==
X-Google-Smtp-Source: ACHHUZ4NS0b6YtBOEqoaEdX6ckVpGpp5TfnL4846nPLZOsam2l0p2h+ROUE286xqpcGwRuZDfcgw7w==
X-Received: by 2002:a17:90b:3703:b0:247:3cc6:f8ef with SMTP id mg3-20020a17090b370300b002473cc6f8efmr1201417pjb.32.1682588899370;
        Thu, 27 Apr 2023 02:48:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090a3fc200b0024c14cbc12csm705753pjm.13.2023.04.27.02.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 02:48:18 -0700 (PDT)
Message-ID: <644a44e2.170a0220.57ce3.0ee1@mx.google.com>
Date: Thu, 27 Apr 2023 02:48:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-g2516b357b2e3a
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 27 runs,
 3 regressions (v4.4-st20-1186-g2516b357b2e3a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 09:48:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11362

cip/linux-4.4.y-st-rc baseline-nfs: 27 runs, 3 regressions (v4.4-st20-1186-=
g2516b357b2e3a)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-g2516b357b2e3a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-g2516b357b2e3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2516b357b2e3a612ef2904362b0acbb97746d0a1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3b73b42a3347ac2e8616

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/644a3b73b42a3347a=
c2e8617
        new failure (last pass: v4.4-st20-1097-g52d843097a439) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3c90efd368655a2e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/644a3c90efd368655=
a2e85fb
        failing since 107 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3b805297c2f5522e863a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/644a3b805297c2f55=
22e863b
        failing since 107 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

