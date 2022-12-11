Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C662C4708D
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 20:20:25 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.25761.1670790018866066075
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 12:20:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Fxg5zG2K;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id m4so10034407pls.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 12:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R/+6oIpxgPNAuYTSpAWH5BBGB8qxZ9sSj8Po6IShhQY=;
        b=Fxg5zG2KunpEQNmq+yuwwO61pwYCrVAYqBiBbo0DsgjWDWORWUYlzxGBb545XCI7X+
         cphXD+58y2DfexbJbnBt7EuNuNNBeEFhX3zEyYTPOi1SI5RpnqGC1qi20GWEQg7wFiHA
         xDQ6ic2LJoDYLBnd5/hsm5tioknejvDtbS8OpC97UgeKs7+D1mX9s8KTzqIvz8Lv2AxF
         1tDLwIycCIu1WG4lvd5YwEB9nbmwZLjA+mWPnV18Cfbe+e8PRCu9i2wKwMxJChmfiISb
         14V2/ay681OiGQ4gIOSuXtVzm6wAaxTNjYmyeKK+I2emqaOeGtv45KmJf2SyTU7DoLoq
         W8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/+6oIpxgPNAuYTSpAWH5BBGB8qxZ9sSj8Po6IShhQY=;
        b=MFfFSAlXywslgyVh6uOTqUjCb5gEdZWFqbSDN9DYR5YSP+H6ghBHku3Q6H5K4B/g1x
         g+lndZBC29BKBidWWAXMDA13q/Rn2FbSONKpNTUK1JTGrIeWqUlkuFhb2+4X4DJ1ttvo
         Z5rCkujgyKrpv7IX4hKyV1KWaCRCOmFBamTIpQgSrlSPSFGo32tdh7VkArHuDRg4jBY3
         4ePEs4uh9Zk49qtGOujDOnkFHBSRlJaSZCtWjl5FaziqRgXsZTLJKc2jFMC6O4dPTOAY
         doWNikJieJGqOm04FZE89ijmhN/a0wr4jtl+E+Tazi1x7J03Wf4Rpiu08cAP6q5M5SJA
         o1Tg==
X-Gm-Message-State: ANoB5pl3UNLV79jqyH3BDXyTJJx6O6Wuf1DvcqTa4jGtl9CvjqDGNkgE
	Rp4gEPtSDD2dC3RpeBqX/zTFdgoP5hIxMdO44ws=
X-Google-Smtp-Source: AA0mqf7Q5lCX537i2gvno+jZ8T0aqjW+rXpdtFVQP6Lpl1d4dNALhPga3+ENcATBFB1cA4yGj5B4qA==
X-Received: by 2002:a17:902:eb83:b0:18e:8223:6447 with SMTP id q3-20020a170902eb8300b0018e82236447mr5121349plg.22.1670790017627;
        Sun, 11 Dec 2022 12:20:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001769e6d4fafsm4725916plb.57.2022.12.11.12.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 12:20:17 -0800 (PST)
Message-ID: <63963b81.170a0220.80a41.8409@mx.google.com>
Date: Sun, 11 Dec 2022 12:20:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.158-cip22-rt9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 8 runs,
 2 regressions (v5.10.158-cip22-rt9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 20:20:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10207

cip/linux-5.10.y-cip-rt ltp-mm: 8 runs, 2 regressions (v5.10.158-cip22-rt9)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                | regressions
-----------------------------+--------+---------------+----------+---------=
-----------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.158-cip22-rt9/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.158-cip22-rt9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e76de05a93390f5ec7fae2941d8f24d367c9b2b8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                | regressions
-----------------------------+--------+---------------+----------+---------=
-----------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63962f92ae68e639262abd03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-a=
sus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-a=
sus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63962f92ae68e639262abd04
        new failure (last pass: v5.10.153-cip19-rt8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                | regressions
-----------------------------+--------+---------------+----------+---------=
-----------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63962c70b68ec96d862abd7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-h=
p-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-h=
p-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63962c70b68ec96d862abd7c
        new failure (last pass: v5.10.153-cip19-rt8) =

 =20

