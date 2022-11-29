Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B6C4321E
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 11:23:27 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.147067.1669720999305805989
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Nov 2022 03:23:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Spg0p3zf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id w23so13068079ply.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Nov 2022 03:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jSd6fyuN4Lywx69GnRWbFEv3667YOCM7hzZ1tUbMq6I=;
        b=Spg0p3zfrDv2LbxqFSXdzo19qoWwruUle9TwhwXAWz9UkqOwxNDetN4MkLKaTtbZJE
         pGS57OqGe35WzAv1RiPDevxEsYkjjjwZD1i4NoUghDciMkBSwuruXe7zuHbmWoNE8T+z
         co8BxYpvYHy3LJy/YCjJQ+dpK551JTVmofZJhUDS+VJWCN2p+l4kB5/RfBGjBg6sWkD8
         G63rr4qe2If2NZX0k+Mj5vsT1rH0XfWllFd+EjQhvMdqP6+a1P7ROI9YgH67yQwTM5ui
         NYhLpQD5kcYh68JpDxtphHEOqez+hp1pp3+nQROFSHIW2jdZKGFNinv9BiZGzxjpsPRy
         Uc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSd6fyuN4Lywx69GnRWbFEv3667YOCM7hzZ1tUbMq6I=;
        b=RLFkDjgH4qrbRnMnB6jkog5+gjpbqp10gR52hYQfCThLuPxfr/b+n/s9zU93sIAxnc
         XmDuUEQRFWmuyStwkjsaljr6YYn7b8chF6+QD7zxn5bDl6QasX/MpKrHiMCdmZ1FU2hs
         GXbmTWmUAf877AnaRD0Jb8ReeQRlV+6oRxzv55+8ZgTIjm1MLRXhsy70RHuY8z9PaQ2C
         wnfN8aBjC/DbIcuysurIVKdzmesxIS0Nzwt8CnSCir2lDkAT5KY8+QxkAfuPqWSJTWqm
         6UlcZvPR2+6KQZHywzF3ojtPjxYOcJJb8uexp/7o0lJODHCo+U4ExCoJElFfslDJ7XSs
         7l6Q==
X-Gm-Message-State: ANoB5pnO18ihm/t+z30PSzV7hGciHud2fYKuQI/iqmoMgMOc45SlXP7O
	ICtSP2GtLpjCKTrArUNVbrrHNBkLsN5EQbRVOPY=
X-Google-Smtp-Source: AA0mqf4P06XttnmKv74l3qne1wMG2zsskeMFW+YTu0Bju8kAP3JbUQGoEK88WMgMC8a77/y8tt2C+w==
X-Received: by 2002:a17:903:120c:b0:188:fc5f:84f3 with SMTP id l12-20020a170903120c00b00188fc5f84f3mr48741249plh.2.1669720998508;
        Tue, 29 Nov 2022 03:23:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001887e30b9ddsm10532625plr.257.2022.11.29.03.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:23:18 -0800 (PST)
Message-ID: <6385eba6.170a0220.438a4.f680@mx.google.com>
Date: Tue, 29 Nov 2022 03:23:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Nov 2022 11:23:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10133

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip71)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c727b8f0ca6857a9782a1ee857a57e4f563b34fe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  498247917f40b0a82cb149e2ec1cb518acd7b632 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6385e2120df38b244d2abd31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-as=
us-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-as=
us-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221125.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6385e2120df38b244d2abd=
32
        failing since 137 days (last pass: v4.4.302-cip69-296-g52de9431d314=
, first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20

