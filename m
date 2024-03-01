Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF0C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 18:16:35 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.31133.1709316992197385189
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 10:16:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tD6DvTg0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d95d67ff45so20796355ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 10:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709316991; x=1709921791; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NZoQ0WQgPlbfUMhwfpr3JEN4Zc3enERjrdZXv5tCzlU=;
        b=tD6DvTg0sgzbu/9R5jf+KRtTrRGK8/RnaZao425ewYDMMJLs84N3O0f3uirFfl6ySr
         wcs/eWPtbXFkwkEKaFqjFEuxnIHqKBln2OH+rBUy41SjeKuRqGm9ZQh592zXIN48zGFB
         hkY44XfG2ug+Ei+7C0Y49VBfbQwYTxDPd+7p8IhDpR6Of1+IRb7jNNsSBJNmFpx8ryxo
         IgXmpdQ+gD9WxM5u9mKJ+DHdVszj80kRe7G2GfKUqDkSFVnbqWQkgMp5mEsNjtToq58e
         IodcctVB4+kp2fA1BEVqNO4xkHYZPtpd8WkRCoymtW2EgmMAsKkQoESg5cRuvrmJWT83
         +/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316991; x=1709921791;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZoQ0WQgPlbfUMhwfpr3JEN4Zc3enERjrdZXv5tCzlU=;
        b=TGnUKdGopUkOsap9cLr4FMCXmV/KWdSeCTQa6DJuPwLBVFeSB43BpBkjzSa/Pa6i7K
         SJod8IjA0lFRY40FY+eYVxHKNc7onAfuz+3Dnao00u33yk8GjntAb8AM5Y+v5X9gidyT
         zY8eLuFs0gqXBz6I8tng+ei4wJ6bYTbgNa4BcPdEMjx/n6/5IeH420MXzgg/M0P1dw5I
         mm5AyverwiFZlKkaESaTJvENbaX1b6wtSKtMB8D6IO+lhLrFuMWy+tddNJpxx0OCDVpG
         SRGhPnDLy0TdPThxbIQ3tiMFvg4Msr8pOft5q2z7+id2+f5tyCTkSMzETq4TTVZDKQHG
         FO5A==
X-Gm-Message-State: AOJu0Yzm814ROlW3OkIqhJ2VAgRe3coEev30AGGEMRttCmQr1oR6ghRJ
	gpaDG2dqTwwsUbWs5lGsWPgJbi8gJBBok9itFOCcMlYwIaa8UX03nTQZAyt9U7LqSeyF+FDQZe/
	XAMY=
X-Google-Smtp-Source: AGHT+IFEHDqL8QUYUobYgUE1VbBZSRNMbG/HfANHO6yilEeWKF932hZEMLheHQrR44P2lFVUhwHA2w==
X-Received: by 2002:a17:902:a384:b0:1dc:a5fd:6de9 with SMTP id x4-20020a170902a38400b001dca5fd6de9mr2427546pla.12.1709316991172;
        Fri, 01 Mar 2024 10:16:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709026bca00b001db5ee597e8sm3747596plt.261.2024.03.01.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:16:30 -0800 (PST)
Message-ID: <65e21b7e.170a0220.3bd0e.120e@mx.google.com>
Date: Fri, 01 Mar 2024 10:16:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-2245-gb01c108f53cc0
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-pty: 3 runs,
 1 regressions (v4.4-st20-2245-gb01c108f53cc0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 18:16:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15132

cip/linux-4.4.y-st-rc ltp-pty: 3 runs, 1 regressions (v4.4-st20-2245-gb01c1=
08f53cc0)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-2245-gb01c108f53cc0/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-2245-gb01c108f53cc0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b01c108f53cc00abfe18491837bb94881ee164b8

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


  Details:     https://kernelci.org/test/plan/id/65e20e359cb1e24bb5637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2245-gb01c108f53cc0/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2245-gb01c108f53cc0/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e20e359cb1e24bb56370=
13
        failing since 85 days (last pass: v4.4-st20-1872-g0dd3085de20bc, fi=
rst fail: v4.4-st20-1987-g9e48fc479c400) =

 =20

