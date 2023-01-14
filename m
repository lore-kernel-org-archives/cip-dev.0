Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296BC6379F
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:30:29 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.109133.1673667019976564952
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:30:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=YL16r1b7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id 200so11319144pfx.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TGgVLd19m2Vi6eaXQhNhPE30hY3gtS5Nr09CsuUphhw=;
        b=YL16r1b7Y1CBabgfEBeSpGNNeFhMLSUlCLLpNKsDF3BCklgckGR8LnF6N16aUaErGh
         7ECTSjT/Tqa4fHe0Bu2J8CZVNS7xzt0kP2chCv6iS/owt8OcMGLgbJQpHaZ3mGvoYu2+
         V0HA9t5/J5n0h1D0nyL7ykK9nRqfcvxKk9GP5U92JRlyWhi/pc7V0wEenO126VPqB7bg
         sAfSpsGSj2G1wKDo2/HToJLoZCByf2EmtB6gfZZ+iIL3rPB27JLGfnFCNzyaPFRo5dZO
         S+W1IJ9YH6xtwtPcOIjQPDufGyKA8K+46ZlxF9/0MhImiBCZ9ncbDKohimVlM36F4AVH
         ONWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGgVLd19m2Vi6eaXQhNhPE30hY3gtS5Nr09CsuUphhw=;
        b=wXcbwugq+2x8oX8JqekmaskcgMhG3qnwUxBwPM3Ad8LOBqiiGiJcZLQi+dysNErxeP
         4z0+rtrpI4aDhN4ifw1XyjDhMmw5D2vcoQ9RVyJyn+UcRFvvxhI6tRnvRe3AX0MmxXnB
         I3aMygqSra33GRsvhiykobpok3Am6jGKNr80I9KyGomhzXn+a/YoJHtOYzrGR9+rK0YB
         810+Ls2m+r+6VZnpGwIQEt6MdbaQP3xgDVPPtYCwh8ce9wIoO7VCQH/KEfhq/bTmLK7A
         elqKx+r+DIQB6uUYw7L5/rt/mk+AiriCMUN3eEIJfAtst8xCSnu2TUgQqN5wqF/OtGAu
         kLQQ==
X-Gm-Message-State: AFqh2kr3vcQSyP0ZlQX/G/SKtmLJOjrXtDvKVKMNo7g9Y6pZrLYsVmt+
	0RJGYOO+9BVCCWwBxJQQISI/G+7zul1KrgMyhno=
X-Google-Smtp-Source: AMrXdXuISBIWwHhKCFJJadPuHu6NlSMAgpxMFbZLCfdJzugHknek2qQQcQAg4CNu1caj+HNqXCipyg==
X-Received: by 2002:a62:a510:0:b0:58b:9473:7ae0 with SMTP id v16-20020a62a510000000b0058b94737ae0mr11374035pfm.32.1673667019292;
        Fri, 13 Jan 2023 19:30:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f127-20020a623885000000b00588cb819473sm10101449pfa.39.2023.01.13.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:30:18 -0800 (PST)
Message-ID: <63c221ca.620a0220.d6ea5.1bbd@mx.google.com>
Date: Fri, 13 Jan 2023 19:30:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10357

cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.162-cip24)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.162-cip24/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c215c64cfd0506141d39d2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-h=
p-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-h=
p-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63c215c74cfd0506141d39d3
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b) =

 =20

