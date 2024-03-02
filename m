Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0444C54E41
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 03:49:43 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web10.42875.1709351377239499694
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 19:49:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wAomQxAK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.52, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21e45ece781so1887470fac.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 19:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709351375; x=1709956175; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cLWWFkDQiLYBqjNOhci3JuS5ij3voHDjfZgXOT6U0GQ=;
        b=wAomQxAKSq+txGY9ASaqwU16B/pN9seX3oyWyJa0QWVt/lM0RdsLlKye6hVQx/3fDF
         kk4TT/5wGkYiHL7tvkXtWxoqk9Am/xTkfX9D1GdlHebtS2v3PAHPF8GH5hfIJmFx/agy
         r1ZuTdVsiLsDWprGTWcGJASEvyGTdA4alva4FTxKZLJHwdzauMhGOrgks+1rHmfK6ChC
         vpf+VFr/GosJSbORirZQe+DVFN6Vu2p8+iq4rJ2MwX0jZ38QbrGDa7itNC69bdh7g1CE
         4/ZYUIQbPByqx/srpztu+ycNwottzkjPx+DCY6vEWk0HltlQ5iN9HCJRRZFmhAPU19t6
         0P+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709351375; x=1709956175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLWWFkDQiLYBqjNOhci3JuS5ij3voHDjfZgXOT6U0GQ=;
        b=cY7KnmYBI3sUg4GKPGPRycxwkakusctRVLv+qvDQXH2/p/liKskfSEl7xzq2D9+Msp
         2kJm1JM9OXvfO2g2kzZ2GrSJ7pQbzuPDEBmwSr1agpRQvKEIYnxe7WxKf4cjXH853KlD
         i9/WET+ksYnJP8HXOgRYJHUeSCRUBUPOEUjvwMpywmmeP5caEEupYL1fh4tbpUBua6QK
         nYoTZISyP3oadOVFEb26DkWeLsdY8i5mXCW4TrJxmK0wjNJX7FlIf8Pu+Bx08BRJ6s+v
         fjadEZrQcUWI1VXyJNzcl2F4r+5n8tKhYgvwXnEgzAX8LnUZc4ut0rl6jVm1TC6Clf5K
         nvlQ==
X-Gm-Message-State: AOJu0Yy/lSOHxLb6F+2srX5EMA7bCNk6D6B6SmHTTiohSibgr+dNrZd3
	fgKpW6qOoTej21xfraKE+a7IxXyzZexzc91ZL8qQ4jqnaYvO8s5pOpBNx7+Hosb23amEGQ/Nflt
	25JY=
X-Google-Smtp-Source: AGHT+IFCTA0NR5WroxZyvxE1RDA42C5LMESW3huQnhbKGTWdtC1n0DssELuLzchFdnkH2d1Zs1G15Q==
X-Received: by 2002:a05:6870:830d:b0:21f:f020:ef1d with SMTP id p13-20020a056870830d00b0021ff020ef1dmr3653659oae.49.1709351375624;
        Fri, 01 Mar 2024 19:49:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b22-20020a63cf56000000b005dc884e9f5bsm3820871pgj.38.2024.03.01.19.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 19:49:34 -0800 (PST)
Message-ID: <65e2a1ce.630a0220.72a20.307d@mx.google.com>
Date: Fri, 01 Mar 2024 19:49:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.306-cip107-rt35
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt preempt-rt: 2 runs,
 1 regressions (v4.19.306-cip107-rt35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 03:49:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15162

cip/linux-4.19.y-cip-rt preempt-rt: 2 runs, 1 regressions (v4.19.306-cip107=
-rt35)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...d+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.306-cip107-rt35/plan/preempt-rt/

  Test:     preempt-rt
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.306-cip107-rt35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428

  Test suite revisions:
    rt-tests
      URL:  https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
      SHA:  0ff13431d2d132ba21ce82a6def38e7d0e18a045 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...d+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28aa42a2388a20d63701b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/preempt-rt-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/preempt-rt-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-rt=
/20240129.0/amd64/rootfs.cpio.gz =



  * preempt-rt.login: https://kernelci.org/test/case/id/65e28aa42a2388a20d6=
3701c
        new failure (last pass: v4.19.299-cip105-rt34) =

 =20

