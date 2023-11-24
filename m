Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD79C636BD
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 00:19:02 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.122025.1700785134293888184
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 16:18:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SUx98x9J;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1cf89df1eecso9756795ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 16:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700785133; x=1701389933; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=glnW8CxKYteBRspZ53854aoJf+3ehsYOyl3yehb7BVQ=;
        b=SUx98x9JWceltRXT9uArkPrEMoM2gNazayPVwGfxUrTtRM7tCXs1iNIDphGc4NqM5I
         7N8ULYrbBlemFNG8coTGmu56vWfS+JG/Bu8xeKphJTDs4kqni71alOF+Somu3AoBmbqS
         404izslGedOiR+Y6vmOG0ohn/zKLORxbSpVbKu2c63rkPqg/AWOcVu31ML7l76903f25
         PQLbnUYhfHeroyTTHpuXivWttlqn7tH6mWEqajUURM6IwPxMJEbVseF8SpGu4+uYCvbq
         F4VsXvY7Vh3ohczzQCOeLfmDWnYZUdMHBfWk8HFhCJdm3j7SmZJv/IvuGSzlTPVdBy+q
         TCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785133; x=1701389933;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glnW8CxKYteBRspZ53854aoJf+3ehsYOyl3yehb7BVQ=;
        b=vDJToCizwx+nCwA5UGIm+f3xLcWHCx1NBgypXHUrm49Yqzr2Q3c02lrRXTB+1J0vx7
         q5HrrDPJHEGCrR95OY+4lVf2TrMO1Wko6vm3l3L4YUNEBEZYGhQpJwS6iT+EezG01lCf
         cyFdRKGGoBMQVCiVL/KHpylS05asVkGXClcJyOzWwpuX9x1MkjQsrXZ2s1y0uzcCMV8V
         z9nXJ6TNjimtUKQdcfzlnoDlwK301ISIqTX9NHuGIW8c2JS4af3JLrBHOqzyjeNTIqgA
         y7dVFOjL6gTW5LWZ9PAIRmJxvbOXxOK0m7jecFNQZ6+hol5veepXa29dX12gxSzJzxZw
         u43Q==
X-Gm-Message-State: AOJu0YwC9AqVTJbAm5cHbNXChoAECW26nMjYIW02q+NL5cHJ7oLXMG0G
	vv9kl+uQAkx0AoBUAlanWTopaH681exxtMojygk=
X-Google-Smtp-Source: AGHT+IE/Bg3NNigAajKFFwIGxRhSWaIE0qhYfMKVWxo2lLaH3O21iFpPsra4xxdgdelFy4a2QkZNbA==
X-Received: by 2002:a17:902:ed46:b0:1cf:959d:8cc with SMTP id y6-20020a170902ed4600b001cf959d08ccmr1050034plb.30.1700785132810;
        Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902724100b001bde6fa0a39sm1929695pll.167.2023.11.23.16.18.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:18:51 -0800 (PST)
Message-ID: <655febeb.170a0220.30742.4c32@mx.google.com>
Date: Thu, 23 Nov 2023 16:18:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 9 runs,
 1 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 00:19:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13695

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 9 runs, 1 regressions (=
v5.10.201-rt98-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/655fdee943e513d9387e4a8e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/ltp-f=
cntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/ltp-f=
cntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/655fdee943=
e513d9387e4a8f
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =20

