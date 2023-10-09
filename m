Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F168ACD611D
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:47:01 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web11.71063.1696877219761049220
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ei2qyU+d;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.48, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57bce354d94so2318637eaf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696877218; x=1697482018; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RF4MvcPhhH5pMBSYV+MpJ0AqFGzNij54dNq+rZ9N+S8=;
        b=ei2qyU+d7A8u74sKzJZu1lPoCqXHaiOrXIHGldAYZz5vAq52+qaU7MJNRcdgpX/LmG
         7uZZwh9Mqx7FX5kDkuqOm1xZC5dXblLZUTr0AEVou48INUOOjL76KKzKswuez/z9Tl2V
         ZSN4rhRXH1Brda2qOKJIx1IMvKY0rih1D/BSjXKrENSWQDEKGTXsLKWo9xL8v7tlUTpR
         IhawfWUJ2QVz5DLAfIoRTWQBzS+NNKoYb/vbM0nf3sUJ9ZlLHiqmy2nqq3N6nhwbhZ3u
         T+U2zcHQn3DpH7/U4zdWXMCCrdOOLA9V6sH+jvtCazab3pvHjYc80HQ5ej1PcwmxxDtR
         UqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877218; x=1697482018;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF4MvcPhhH5pMBSYV+MpJ0AqFGzNij54dNq+rZ9N+S8=;
        b=FIUHU8Zlsm13N2t4P4kro46UHzXkbGgot0o4xd3pLKII4oQe1MCG5qhINhhGFPXtY9
         gW7muL7FIEKciPmawubWaJKO79KqDeTDFqB8FGBlIlWuyUS1kSRqDzMDb04CslA1RSPK
         roK4wyLruC0c+s5/P72DE/qnNFe9mNuEZ6nwoiTSbV4eyDr454wbheVAJYnAf2w5vMTJ
         7mKqNZm4AsH2Dd4aHizmU0biaigZNLmccLgoDpApeln8Rt61p10M2c/54IIoZc0X/sjR
         zoQWEjfRdtcIZ5qYaS+UQZfP11Hb8TdbC42eiVfNAipqBqfTJ8qgml5ZfK3SuByXAWIN
         OhdA==
X-Gm-Message-State: AOJu0YxolSq74f4vs3ogOVvj51Ml5oIZf42cvbysRKNU1aLlmT9gqXhg
	VmNNYHkV5t6pGUzBN4tdJOBQh6YPSSDzS59wZlvIuw==
X-Google-Smtp-Source: AGHT+IF/ltk53i6HMIR5dr3zRrdNRh07x+JH/tq5Cx/KDtoRextmrbAtu80BS2iwWthcUP1zCJ460A==
X-Received: by 2002:a05:6358:93a5:b0:143:9763:e6 with SMTP id h37-20020a05635893a500b00143976300e6mr11560940rwb.0.1696877218033;
        Mon, 09 Oct 2023 11:46:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m20-20020a17090a7f9400b00262ca945cecsm10571910pjl.54.2023.10.09.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:46:56 -0700 (PDT)
Message-ID: <65244aa0.170a0220.3d78e.b997@mx.google.com>
Date: Mon, 09 Oct 2023 11:46:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-gc774a35d86d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st-rc ltp-timers: 8 runs,
 1 regressions (v4.4-st20-1778-gc774a35d86d2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:47:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13328

cip/linux-4.4.y-st-rc ltp-timers: 8 runs, 1 regressions (v4.4-st20-1778-gc7=
74a35d86d2)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1778-gc774a35d86d2/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1778-gc774a35d86d2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c774a35d86d261f0d49d25d9a02dbaf95cfd288c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652442c78b0459f940efcefe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/652442c78b0459f940e=
fceff
        failing since 6 days (last pass: v4.4-st20-1430-g2fe294a51ca0, firs=
t fail: v4.4-st20-1779-g48d33e0df7175) =

 =20

