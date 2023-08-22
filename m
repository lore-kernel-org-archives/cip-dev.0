Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB91EE4993
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 13:19:48 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.7907.1692710380356771516
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 06:19:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=m201Cria;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-68a440a8a20so1957691b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692710379; x=1693315179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dxx/0N4xQqi2FQsJ6z4+pskNKhtKEcYps/hQozEVL0w=;
        b=m201CriaxH8nnSP1J4r4bDwdOpsuTJHK0E2aO+yhtfkuyzYTOH8DhXZVcI4THbLB3z
         wesieXEJB5ce6m+fWH0OIgmwnfFtw49Dwx3a+STSFn25RKcmeHPAvR4JGN6zfJLG9ZJD
         bNUc96MhZCpS1+q14jdxAz64akwYG2AMRghp863dn2julGVjqxNxMtyW1XKIz2+46vNC
         5OMAJEvv5xrCj5UX6Td0XYue1npcIAZ7FzttOs8Hiq1fIcEQv/n0U3PMsWp5mIE0+HwY
         EX11SLRwqN+EoHnoblQy9yZWpjAVhx672HN2Nc3FmGmYghTOMSN9MXfg9Ici72w0ezPB
         T9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710379; x=1693315179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxx/0N4xQqi2FQsJ6z4+pskNKhtKEcYps/hQozEVL0w=;
        b=ic1eJTkUuAsNl5eZzKfgYvj/38Y9QwFRFZp5pIB856RuuxRppqDNxHruPOve2lwkMQ
         vHH9Z9GPMCvuH9H++yBkxDHlO7wrzl+2CVljL4U7eopr0EUi+3gbgskgNTjPutUOWLWh
         atyiXMG6pkh3uwc48Jy9ACVgOnyVuQDDL0QDDlnuWIfRjQklIqcg9Y2OSmd9iI5habGC
         iR2c365Q9oyfWQhvZOhAX+yz/o4Ncs4PO4XpIxR/H5LI+4hAu12hultfTjB+vBDCOEjg
         Bl/1Dc0bIv8b3n8IgejsOg1eyG6T32j7rGm2oRHfT9f76Ae5qgF4WhYcAnkTLxGUe2x0
         c+zg==
X-Gm-Message-State: AOJu0Yw/lZZc71p/JWYP8p+pmmPmtZ9lfe+K8BZl/Uw1xyyKADkdpOIf
	bv6SKgh5L6XULu8B95fLWcDsYZF/I7ysIRb38iy1Kg==
X-Google-Smtp-Source: AGHT+IGKwi+iYM6+49PAVscY28uQXHuvyVREziVmilCZYAorArYOqwvxvpH+q+FkTYvxrRTuZJyajQ==
X-Received: by 2002:a05:6a20:1013:b0:137:8599:691e with SMTP id gs19-20020a056a20101300b001378599691emr10518371pzc.49.1692710379341;
        Tue, 22 Aug 2023 06:19:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79109000000b0065980654baasm7750150pfh.130.2023.08.22.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:19:38 -0700 (PDT)
Message-ID: <64e4b5ea.a70a0220.a63f4.e063@mx.google.com>
Date: Tue, 22 Aug 2023 06:19:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-27-gd6d928db0a620
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-mm: 1 runs,
 1 regressions (v5.10.186-cip37-27-gd6d928db0a620)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 13:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12822

cip/linux-5.10.y-cip ltp-mm: 1 runs, 1 regressions (v5.10.186-cip37-27-gd6d=
928db0a620)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-27-gd6d928db0a620/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-27-gd6d928db0a620
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d6d928db0a620394e433833b5dda4ec7ac822999

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a97c1191988a24b1e3bd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64e4a97c1191988a24b1e3be
        new failure (last pass: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =20

