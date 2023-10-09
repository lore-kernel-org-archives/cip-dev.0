Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3493CD6121
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:47:01 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.71559.1696877219123568925
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=AWKZM6zO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c5db4925f9so35606035ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696877217; x=1697482017; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=obyXstduh8Ck5q0+KeXJgl4L8WU9r7UOzqzG6UI+SbA=;
        b=AWKZM6zOsCYOa38RfUMr6mHoqq7cWR3OKTmxdxhQ45A9YUbvRf7yqNS+maE2BWmy0X
         6d75xbgtr+nLww6KmMkOE0Fy2CdXw9vq+0+VIbUeor45nsYdfL6+7tHYzf435xYlhLHa
         zjfBw9qqlLlC6QBKt9gGuHenIp27uBrl6OO0FRBJ/LArbCFGMg5NLFc6cEhiT/CoQ8Ky
         tZhIrrML7/zE9AqWuIjYS3oOLMab86/rGv2WjyJ5PbKSJNJZqHp1a8YF9GZYhecRRbJH
         CiFYQmMgAZIw/9Ie+kNTwOlJPx7qafjqZYE7rzIgxpOGC1nAz5kOwiDHRlw6bjEFPPVL
         QrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877217; x=1697482017;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obyXstduh8Ck5q0+KeXJgl4L8WU9r7UOzqzG6UI+SbA=;
        b=t4cIMDcQFHzD1peLWnv6FT1/HQO8hQvr1W7SHBOKa3pXPgGTdnSXdfOsIhjjmSnSxa
         gKRqdzCCJ09pbAP9iex54CtWAf/XdITtEpGbEVBwLsoPfN8hnBjkMwzNfbOsT1js+C26
         /l7ELRVp4Yg3sG5OK5vGfwhGhuO6nm2WzApAcY4/efhvTDkbo+lzZP/+nCc7yM3veE9h
         FQ72ZZKViNxBzA9S9ve3Xdg57Gf7epwHNwASd2DTzzuY5HsP94SkpfVfnwxtCsYE/tsr
         2WT8br9sENODf7BMdGDq9iSTxR54wz8pZKJV6IeV7AzJG4qPJsLajqfdNe3K1zvRPyEH
         2XSw==
X-Gm-Message-State: AOJu0Yze0/ozMcFi4GgJxmJNs7s74bwCfV7LoieN4vGri/iFlQ0Mo0QE
	9wqFyvOXB1zULbFoTx7PnBdFJaf7hfL9NTTXa3QaIw==
X-Google-Smtp-Source: AGHT+IGKE6DCSIwuBCemg1fOXwVmHOH/XoUGMz51aEDw3rZFxlu8oZdBlr6lrTVBedvtSB3nhS9mNg==
X-Received: by 2002:a17:903:1c8:b0:1c0:afda:7707 with SMTP id e8-20020a17090301c800b001c0afda7707mr21159199plh.34.1696877217600;
        Mon, 09 Oct 2023 11:46:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jf2-20020a170903268200b001c736370245sm9993944plb.54.2023.10.09.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:46:56 -0700 (PDT)
Message-ID: <65244aa0.170a0220.8d1a9.9c03@mx.google.com>
Date: Mon, 09 Oct 2023 11:46:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-gc774a35d86d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st-rc ltp-ipc: 7 runs,
 1 regressions (v4.4-st20-1778-gc774a35d86d2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:47:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13327

cip/linux-4.4.y-st-rc ltp-ipc: 7 runs, 1 regressions (v4.4-st20-1778-gc774a=
35d86d2)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1778-gc774a35d86d2/plan/ltp-ipc/

  Test:     ltp-ipc
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


  Details:     https://kernelci.org/test/plan/id/6524423be91330f190efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6524423be91330f190efce=
f7
        failing since 6 days (last pass: v4.4-st20-1430-g2fe294a51ca0, firs=
t fail: v4.4-st20-1779-g48d33e0df7175) =

 =20

