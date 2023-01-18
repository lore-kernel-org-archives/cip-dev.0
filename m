Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E6C46467
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 21:20:56 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.29547.1674076847747087261
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 13:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KxfU5yjr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id b6so169529pgi.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 13:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y+u2H54zWQCKbRsN5Q5m1Ik6672wG9iWDPw9898YFgI=;
        b=KxfU5yjrsHu2kjw1+eIEUqDhd/M8q18MzNwCmY4JK21JQOBpg9T3TmBAhv/Q850wyL
         ZWQ9EmzX/vqQrixUEKe39BWxikfJwFFgpa2JoYh4B9URvg2EzGzVORXVH6iJBQwgQJPG
         owvHuDUQa1C2as3qdovnUVw4LeVF3b+d6QZX96Y8yeYKSYlIuozSgOPDbCwzhQPO9kcG
         SfmwTNnGmXDXq0fFPyL6Ckew2QH7X5HuFb+pspMUw487XFZr8/dzaAYnZbNKvAXsDYnq
         jkf2MN7yUvsBrMvx5yVAayEg8XNSBOV/hVXHY62wgWAAGpmjjjxbmN2UtzJQ8romsKNG
         RT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+u2H54zWQCKbRsN5Q5m1Ik6672wG9iWDPw9898YFgI=;
        b=KO+2p4xuSCU+x6uBs5VTsDzFC0y3+64UOyHcxkjMd300lkiMmvr0/uEt5KSHctZZ7f
         l6m7UPXLZhPz6YClLGxIQD7PgRKjvd2Vflr9f3CgRATXfeoUI9ACAxIzchaOi+QPFYpu
         Fj04A0BAUABC0v9wj3/yybwJICoLc0t0hNjFBMcmCnqSy+Qx0WX0ablKrJFTSl7YR3cU
         Y0Cn1uAVEykyw1IvHywZBYP5XU4EhIzz5x4nmPhAH+d6fH1S/p4T+k0W8zeuerbkWpGF
         dcXbJaQvwfXFEgNSAbqkJiKPtq9sJ2ugB+Bn3EiyQ8TzRLVJpP2JkHRYGL5tHUsU7RTf
         M8cw==
X-Gm-Message-State: AFqh2koJwrEFS351NoaR9DiJQOedmnFRHvRDTqx8DXqCskOb8+cAXcGa
	cSvBrrQw3EqrN7d/HnmVJGlj1nORRqUXQFMAK+c3SA==
X-Google-Smtp-Source: AMrXdXtAVE1VvZRGzqB8NyajVAQJxbVx3j4v7tiKz/DWpTSHtHOfWpQUagB4C+ACcPJIzMXrQ1TedQ==
X-Received: by 2002:aa7:850c:0:b0:580:ccae:291c with SMTP id v12-20020aa7850c000000b00580ccae291cmr8957362pfn.24.1674076846797;
        Wed, 18 Jan 2023 13:20:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm21895917pfl.146.2023.01.18.13.20.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:20:46 -0800 (PST)
Message-ID: <63c862ae.a70a0220.88384.3d9c@mx.google.com>
Date: Wed, 18 Jan 2023 13:20:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-1495-gc851fb1e222f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 1 runs,
 1 regressions (v4.19.269-rt119-1495-gc851fb1e222f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 21:20:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10404

cip-gitlab/ci/pavel/linux-test ltp-mm: 1 runs, 1 regressions (v4.19.269-rt1=
19-1495-gc851fb1e222f)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-1495-gc851fb1e222f/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-1495-gc851fb1e222f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c851fb1e222f4acf955da1ad9b020f3fc8a51c4b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8541844b15a4b70915f35

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63c8541844b15a4b70915f36
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =20

