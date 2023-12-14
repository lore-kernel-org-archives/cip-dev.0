Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B9CC4167B
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:52:40 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.27860.1702572752804110330
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:52:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pj0E5CTh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d069b1d127so50437645ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702572752; x=1703177552; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/f3GsB2rLHEpwq9mmPheirUd8HNjXfg6/v0bYs/nlCI=;
        b=pj0E5CTh8YyezVwHd2FduQot5mVnw8Sv3nxV0HGJarrGI/3wYzSXeWkbaXLv9qFZmZ
         aRx01gYuY/RU/f/MafLv62BUgD9HLTw5GN+UGfCOFaKaPQLuSdD4eMvyCaOD0cjQNhMM
         tKiNYbRUiFVhARl5TFTuyST8IA6wf9FUdPW69QtZSnw7UsZXS8PtkawzMcuMK2OBHdNX
         UpUa/xsYiVitsGAofW9OcDaVt4/oih0eivGZIGpflHDKyqjE9rnpaYJVSkg7OblrLUHF
         YL0JE6L7wf5tkeMbMTLQoP9khiAiZxbIGzRyjzOa6siwq38nOb8ugmqWFVxf8KW1F94S
         4aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572752; x=1703177552;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/f3GsB2rLHEpwq9mmPheirUd8HNjXfg6/v0bYs/nlCI=;
        b=MVpWBRPeiEWAtNppDt9ZJPBpDmrZ/UHAyMLVZVTnVi+N1WXV7fEjTTMskZyRMbrn9E
         lPSxyi3kNkzBwWSkA9QIVsmt0yPVDTkY+1hGtvEaN+eiFi4Nfm1cd7+RwJ62H7Bj01Yf
         VYPoBZOajMscaeoUXLVQQC41Dxt9co1FYtVoWo9DrQjOmgXWSWNMLKW/ogAYgraAFrC0
         xmosuj5KxEw6GsC7AVmPJ27mvXYMhQZVSjFgfKjD7VxOZUYk3fzuJQq1V+nWCP6NxXDI
         27+w3SRCIEs9ECr92UH66wI6bYu8vBsqoNirDBWoI3h2+gyx0bY5pxH+QDQJ7m3231Vx
         B3ZA==
X-Gm-Message-State: AOJu0YxTIDYQrhaELPnV0NTJAyzt7BGzGny68crZz1dt/7rxqOuq41rl
	90bTq/wxNoB3Sxi8Ag0+1iaV81f8v3CHYeg/Iaw=
X-Google-Smtp-Source: AGHT+IHGf/MaYg/yn3g1Tp4zbaAirlNa5Xk1qsOxyUkbU1Hgm5TwgJx5h9aPByrAB7h7Zs+TfZQwKg==
X-Received: by 2002:a17:902:cece:b0:1d3:51c7:a2ea with SMTP id d14-20020a170902cece00b001d351c7a2eamr2014677plg.107.1702572751841;
        Thu, 14 Dec 2023 08:52:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028593e9eaadsm14698368pjq.31.2023.12.14.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:52:31 -0800 (PST)
Message-ID: <657b32cf.170a0220.99f57.c7e6@mx.google.com>
Date: Thu, 14 Dec 2023 08:52:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-1-g2d3d776d703d7
Subject: cip/linux-6.1.y-cip baseline-nfs: 50 runs,
 1 regressions (v6.1.66-cip11-1-g2d3d776d703d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14124

cip/linux-6.1.y-cip baseline-nfs: 50 runs, 1 regressions (v6.1.66-cip11-1-g=
2d3d776d703d7)

Regressions Summary
-------------------

platform   | arch  | lab         | compiler | defconfig | regressions
-----------+-------+-------------+----------+-----------+------------
imx8mp-evk | arm64 | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.66-cip11-1-g2d3d776d703d7/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.66-cip11-1-g2d3d776d703d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2d3d776d703d7a5abcbbebb5ff00910d7e1102ac =



Test Regressions
---------------- =



platform   | arch  | lab         | compiler | defconfig | regressions
-----------+-------+-------------+----------+-----------+------------
imx8mp-evk | arm64 | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657b2bc71426c34491e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.66-ci=
p11-1-g2d3d776d703d7/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-imx8mp=
-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.66-ci=
p11-1-g2d3d776d703d7/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-imx8mp=
-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657b2bc71426c3449=
1e13476
        new failure (last pass: v6.1.64-cip10) =

 =20

