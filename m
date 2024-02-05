Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B00EC48295
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 13:44:07 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.62649.1707140637962895449
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 05:43:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Xc3lJ82n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3216904a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 05:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707140637; x=1707745437; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0YWohQ0bD8mm+igAyg9KTt5nthEhw6k2dOoHF9kpkMs=;
        b=Xc3lJ82nzJcHGoWYnnnh76zCLwE2p38sq5xMYMeuhwISyLCfundgAs2dE6Qa1Ale+R
         HnUIys3uA5fz8DBK/Z2Gt3ugjQD9Kh5FBL7AygCAKoh4E3GrvzGE+DO3Okq1s2aQlSre
         hDvZD7nyZRcTTfrD6m/ujDXc90XvXGFJbZUnC0vFK6L4T7C0slFp9NjIGvs15vl0oyJK
         VAajqwBaz/CJJQZOfJnlursdBRPuTrGeNBrv30087ZaoeDiVdEeGhVj65ojLJIDi8Bu3
         PfGM09Vm9ZriwYSna3SKOoNPtLWw5Xl7EGp1wwbf9eIaGdaO9QSMKlAY3C1SgAushpGa
         LKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140637; x=1707745437;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YWohQ0bD8mm+igAyg9KTt5nthEhw6k2dOoHF9kpkMs=;
        b=hi1jQGKUA58ftRIZk/+GVduXWTa0RPZ1fOQjNiOUh2gJfA1C4PB3aSlU2DonyWe+cr
         brZH6Noc21l+KiTl3WeD9Al5H+lId67RdBsze/itGz8ZaD5qKG6Te+IVYdC2REJ3ofQ+
         YxIaxEE1R6SE8mxJIh8DgJD3liK9iFYBXjA71IlxS/bmy8wXA1/PQ70Y5GxxJGXWuFIH
         oIYPzOq/+jrDnCp1A/9kVyMgB0VRuYHKjnr0aUTSNqZ5M+//Ng0f3hY4o/3ybiFnz8Dg
         WLlHqtcgBatqpTmJZbQqSf7epCZi9Aw3sP/oY+we9UPWzNfm93t8sx6qPpBoip5HL21Q
         sHPg==
X-Gm-Message-State: AOJu0Yxv3jk8XeatMB37qg5YS930wO6vWook0vfhHVNqOm+AzENepIFi
	1Ie+xMoQwmFAu8prqfzFKDxdvO9DCoLYXZdMaFLMKDtHMecZLKQDOk4tJ/bE387djrfoIVsjVwj
	R
X-Google-Smtp-Source: AGHT+IHGL9eUUf+JESIu4Z9JzgzrjjrMkRvXaqqRPG4066fshugRnQ8iCUlCq+C8H/9NpNTPUeELOA==
X-Received: by 2002:a05:6a20:7611:b0:19e:4ebd:92c8 with SMTP id m17-20020a056a20761100b0019e4ebd92c8mr5801823pze.0.1707140636869;
        Mon, 05 Feb 2024 05:43:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g4-20020a63f404000000b005cfba3c84b7sm7042015pgi.81.2024.02.05.05.43.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:43:56 -0800 (PST)
Message-ID: <65c0e61c.630a0220.d57f.6b17@mx.google.com>
Date: Mon, 05 Feb 2024 05:43:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-6-ga817aa655908
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 12 runs,
 1 regressions (v6.1.75-cip14-6-ga817aa655908)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 13:44:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14724

cip-gitlab/ci/pavel/linux-test ltp-pty: 12 runs, 1 regressions (v6.1.75-cip=
14-6-ga817aa655908)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-6-ga817aa655908/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-6-ga817aa655908
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a817aa655908e54b6999ed3d0663c3f370d059ec

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0dec6660e4f265200a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig+arm64-chromebook/gcc-10/lab-=
collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig+arm64-chromebook/gcc-10/lab-=
collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c0dec6660e4f265200a0=
3a
        new failure (last pass: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =20

