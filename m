Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA886CCA48B
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.4927.1658400840156191456
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:54:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=2Uh3v1bK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id h132so1300625pgc.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LBphaaq57s88IcNPq/ryF7UkjBVQpLIpRqCzekEpRTE=;
        b=2Uh3v1bKPdznzpLSFWbZCrnU00o0/1KqbzLKTbz8/4amKMefTeCs5MSJU4Sbu2rpTl
         dvW6Q+/IPXEsr+81f1vMGeC6pj+WI5FLSX/exPkh3aknU+ZYWOmWk0YFORn9/d3fQPwM
         D+xTsNVXfIjbsr2VKb8mCq73fQp1uPKDJvLF6JONCHuFQI6oS/72oqiX+Se/cl6mXdSs
         Cqt/FosJ7PZPvuRRIC2BveII1suDgP+3HZKgpnirn18YWkvASX1vKUk/a4YZjtL1i5tE
         hG3lZtlGM053/d1+HpSi8SSyo53s7ZdI+CRmZEkCbTwBEW4k9LpfAeKFB6Xaohsk5nDb
         ynxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LBphaaq57s88IcNPq/ryF7UkjBVQpLIpRqCzekEpRTE=;
        b=wcha9pxgr6E1KgUwa3CizHqsoNXx0NncEBrNU7L0O2J3webhSZt93vWCpZP1b6KUK3
         0PtcfYk44aqrfcClYd6WsSvTR0+ZEI0zp31Ad3lEh2xAP9gCgLRXTr7F2iZLiiYKB7L6
         w1N7drw/sAv0z89wSDy/cZTldqbRJcR5sMoE78a2Sk9KFYXvo6rzaP8zPZomAX+mJE8e
         +8liuZCS1rl7+u2Bj0vYczy/4g/Or252eBjysANPiYynCq4jQbxSLImRO1HW3CWBLlGv
         unD2KUMsMIEBBGbJUchUsop3wJOUVc/iJGjl/1pnjAjj4SARBY3MiIZ/Bq63bemwbzmk
         iNug==
X-Gm-Message-State: AJIora+Fdo8J3hFwMs5k0dcDVAJTy+aV5bkCsMjC3USCcTKgyrxmOEY4
	pp30YJL//u2TpeYDUD4aj4xZZuG7tQFp9ria1m4=
X-Google-Smtp-Source: 
 AGRyM1tdQfLcWhWfJ3XIQbKl6bIdoPFbW/gR/fZS0H/FW1onNumrrAYzTK6QSX1/OcAsewU56PaYZw==
X-Received: by 2002:a63:1e49:0:b0:3fd:cf48:3694 with SMTP id
 p9-20020a631e49000000b003fdcf483694mr38765946pgm.275.1658400839461;
        Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q21-20020aa79835000000b0052ac12e7596sm1416272pfl.114.2022.07.21.03.53.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
Message-ID: <62d93047.1c69fb81.1fa25.2224@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 10 runs,
 1 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8879

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 10 runs, 1 regressio=
ns (v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d925e0891feac367daf066

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62d925e0891feac367d=
af067
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

