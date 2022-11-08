Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D25EC4332F
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 21:07:34 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.2725.1667941649991436485
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Nov 2022 13:07:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PZuD21XA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id j12so15265097plj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Nov 2022 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jwnx9n6Nkyd8cOBFOo+rq76uur72RdSKhMALYK2bjag=;
        b=PZuD21XAEBsq2eMoqx/Hep30qizbTu53kScZyFVfdgfxAoxwMMCZVLraiddrmrUG8Z
         6Rat9CLjT4+qh5hqkRXee3MHNjkIsIPJPTsdr5QyUxD0Gcsq6VfQbTfblIR50jwRx7lD
         sQccKQG3P8aC7Vng2Ea3k7nN1Jjl5W5YP8RuaFDR59FD/zkrYUOn3TGae65GyKMRC3qP
         ll2iCmu52qZx/6MWfuBAdnNM2x5X7AfIqyuxgIgb9VAAxES1o7OyJu20GNiOhzJL+mIg
         nZIZSJLaluWmFP69LpeTP+WtmZFpP5++MHa/YLpICsw1VohICoA/WIwO+pD7O8x+M5TH
         KkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwnx9n6Nkyd8cOBFOo+rq76uur72RdSKhMALYK2bjag=;
        b=jUxdwbRKY1no+ib6PkZYv5OoAu6+GG4eo6dOMtq0h6nq2CsVAqZj+XEai+vvsEo+ie
         53lIQW2VHqxfOPFDNN4Y0mh/703zLLQhMbReiWeu+oBpT27NjOfaKFWzLUpmAkSedCSU
         I6wuZWX23ZqPGdF9TAvl25Ij+44Wh4Dx1tnJ68gxV5NA6665UqkdoJO6KxYKovBCdBI7
         7bZQtL0Cq7P61FkAGkptRTqeEOTAdBnHWGCKd7yKWyG9h1K/eeTNXt3C/OK3AVDkMWqR
         XRFKNOTcfKLmSZP9lU3WBKkjJueqREeoS+BgsejK0ZRsTQsYL1A83ed4YA8bO+FsxDAj
         2Gdg==
X-Gm-Message-State: ACrzQf2a+7ncXCEFjYs6rSlqDJH6nMP8jDyF75HdEJqCkOG/4TVa/Arf
	EMs8R9ptdItaXaNRrZNwVTrGIt9mN5ecSKxy
X-Google-Smtp-Source: AMsMyM5njCO4+ZnwqnralNNVEpNwIuI8hf8v0GwndSdTZFjcMSWKn6qIwog6IE6XiA1YyFzQLudpPw==
X-Received: by 2002:a17:902:ed8e:b0:187:1c78:80c2 with SMTP id e14-20020a170902ed8e00b001871c7880c2mr50961107plj.38.1667941652420;
        Tue, 08 Nov 2022 13:07:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709027fc400b0016d5b7fb02esm7359967plb.60.2022.11.08.13.07.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:07:32 -0800 (PST)
Message-ID: <636ac514.170a0220.89424.c6a4@mx.google.com>
Date: Tue, 08 Nov 2022 13:07:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-15-gef247a3cd0ad
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs,
 1 regressions (v5.10.147-cip18-15-gef247a3cd0ad)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 21:07:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9954

cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs, 1 regressions (v5.10.147-ci=
p18-15-gef247a3cd0ad)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-15-gef247a3cd0ad/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-15-gef247a3cd0ad
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef247a3cd0adc25a8015590a0e7652ad30c2b2f7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636abae9b55db59e52e7db54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/636abae9b55db59e52e7db=
55
        new failure (last pass: v5.10.147-cip18-12-gcb2b164780be) =

 =20

