Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B41C43334
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 23:31:22 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.1295.1657323079946066202
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:31:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=3tP45mBL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id m14so47773plg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gITO05OPMym5zomVr0BmUwrxfpD6xH+TWlECT9ANaPA=;
        b=3tP45mBLZqf5pSw3VOEXA268INiCNesbmSO7pJoWS24Pe06e/zJebZiEtGY6khyYD9
         lae5trV+dL33DpT9UgvEPNpHcWMHFTk0wMswJTIrZfzdWcxNpce+0qT869m6dQiw3an+
         UpF+aVrS44XVmyKmCWmZwZ1h6mF+niiAlbWJVP/IHk+bTiOy/vhKkyqI9xByWcVCIMSe
         GVlVCmgqgLdSh97Yyv+oOHGvcOBdtog4dcACujqNTgzxsYDm9LvWm3kNPrkKZWHT3LMZ
         frVkG94ddVbNsPDuWi5gVe/aTq8u2UV3GCXyMOTD0JyE+zeB7VZP+cc3w9J3ngRnLlDm
         oZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gITO05OPMym5zomVr0BmUwrxfpD6xH+TWlECT9ANaPA=;
        b=sqEEddGEZeWXGcrmbHIYXzCMzuZaUqqWPQsR1uz2upBX63l9DgGCEXHiMrHCZ+4n/w
         m46fvBu1K81otubHtENxIaYLwSBgsoe7t6o8ZnaO8OrFOqdYfc4uNrEYPFnaXuEBYgE8
         aZb2d8V0DoQSSC52DlT4bkYc1k3QM/uSHKMe0mrbxXxEnmAjHfsfZa0cxqi9l9tbG9A5
         G8lPcuqBz9cqx5D9ZDfrSAfbQ7UM07dWdhQN5wjz9LSVQeHbRgDK7NOfzmjkisBx9CVN
         GpnzZ9UgtRuFInF9/71XZjW1Zx5Ovp43LbpOO8KsYesLpSpc8iResIK+ULVfwjWuX6CH
         lSIQ==
X-Gm-Message-State: AJIora961ZEUB2zpOlpggzGIt/U/uN3DiKz/mwjtazBmmKXrMLooGawZ
	0Rt+E9Wzx3Up0LoCAAaHC0KtVLpOKWVEH92v
X-Google-Smtp-Source: 
 AGRyM1tqo74P4DivWAaJJT4yorvX6vKs9jqsCLuZs7zlqqA8RO12N9DKLRDCP1MIjpXwCKNiU0hG2A==
X-Received: by 2002:a17:902:9046:b0:168:b8ee:8164 with SMTP id
 w6-20020a170902904600b00168b8ee8164mr5917600plz.159.1657323079316;
        Fri, 08 Jul 2022 16:31:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x189-20020a6263c6000000b00528c7f6f4dcsm139604pfb.52.2022.07.08.16.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:31:18 -0700 (PDT)
Message-ID: <62c8be46.1c69fb81.a767e.0448@mx.google.com>
Date: Fri, 08 Jul 2022 16:31:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-mm: 5 runs, 1 regressions (v4.19.251-cip77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 23:31:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8731

cip/linux-4.19.y-cip ltp-mm: 5 runs, 1 regressions (v4.19.251-cip77)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.251-cip77/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.251-cip77
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e634159f2620ade28a9251a9bc2cc23b84f527f2

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b9c721ae59abf3a39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62c8b9c721ae59abf3a39bd6
        failing since 174 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

