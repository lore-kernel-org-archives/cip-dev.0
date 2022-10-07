Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAEFC433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:37:44 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web08.3309.1665142662427572150
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:37:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=0me+sSBi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id c24so4311509plo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BfsvWS9F9Zhd7Km4CGRmwZ2oZ/6+nrgohY9MIa9LD+c=;
        b=0me+sSBiBfHFoJ7TfP/9DavtEx0g/Bwda1JgdNMC0OV+sB684qS4Lpd4f/psFfqIZS
         l9OnfxvdMrXDbPtPJCrwDUcFiADxYj3+q+Tux4MvkfGDaQQdl9iF4k/N83g6ErQ/zt2l
         msbdaTXoti+UlJ1gUNKtDng34YiQwLFRIEQDaDSeJHW/NWnMnPMe2w10U8vF0kYD4EFz
         wbiyc86dbxKb8ruCYe5TBFFuFznmuWfrLwifdtyOYyQjhjjr5eMEjLM10bi32t/YvMWv
         OsDJVudADq8eugrAiKMAwlVRkdlsXRVYo9wdD9u4Kn57K4J7SZJ5z95dglYiuOvClxeP
         ouYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfsvWS9F9Zhd7Km4CGRmwZ2oZ/6+nrgohY9MIa9LD+c=;
        b=jYyqkRP1xXYKGvBgwUtSQ3mb/4c6+mXlpPtvQLv18c0UrssA+VZb/ffufz10o1ozLO
         hwyMeTTM/KxrhuK3ZJ7Id3sdgHYZmlnzOifAmhAWG9IUx+dIOf8tZfXDcG7frg/w4nWO
         eHAFRgTnN/8NkTC3jrSbT+l+9hMiLwKkr82cTaYfs04f0YtauKr4kSj8W+ByvXmt8LD+
         Yl2diE+ry/bSmcN5G9u6jPuId76s2Q99Pm50Re3tvyt3c4k0ylune0VFMMg+ibfhtOLd
         2H5C3xWxb2BKmcwW5e0+JwvlZk4cyD6ZoKSEJemImoqMEIAUk6zeikXO++wpIf2PnVWr
         zkgA==
X-Gm-Message-State: ACrzQf2IdijNU6K2GyluQx/RLDHKS4T5yBYKDGEtXtN0OzTt+bNzkcZ5
	XkBIMC4zP0vm6u5MlxxXaCt6v21BuuJhb1/OAf0=
X-Google-Smtp-Source: 
 AMsMyM4iYRST4NlA93TBNE6qTvNXL7XNKHFUtcOut81hLR/WvRg6vNN6vDtGYAkBV3uwBHtTBMGrog==
X-Received: by 2002:a17:902:d492:b0:177:ee56:3b6a with SMTP id
 c18-20020a170902d49200b00177ee563b6amr4788080plg.132.1665142661749;
        Fri, 07 Oct 2022 04:37:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q13-20020aa7842d000000b0056234327070sm1443549pfn.95.2022.10.07.04.37.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:37:41 -0700 (PDT)
Message-ID: <63400f85.a70a0220.22dab.2654@mx.google.com>
Date: Fri, 07 Oct 2022 04:37:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs,
 1 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 11:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9685

cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs, 1 regressions (v5.10.145=
-cip17-rt7)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-rt7/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-rt7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63400f3242bd70a35fcab617

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63400f3242bd70a35fc=
ab618
        new failure (last pass: v5.10.145-cip17-421-g0d804ef4a611) =

 =20

