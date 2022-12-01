Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26DC4321E
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 22:23:37 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.59577.1669933414246069258
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Dec 2022 14:23:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OgCnam/x;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id g10so2977829plo.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Dec 2022 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QORDlWP+mhc0RjgGQH7MI5JXfG5WhJ3jk12dN80H6zA=;
        b=OgCnam/xeWwEY3MbfHHCZKsFz773JV7VsafQRcNNCSS/98Cf/ZQHivBdM9SQY54Ffm
         37KkSfnOuHKvRM5RXR/cugBatJiqHk0XmgtS696bgQmmFT1jdCGhYEzNKSyqnGx86c9i
         CB3cLeizE7FFfV7tduPOfs4GuGWxaueXzMDHUX9XGbJiIhOTZdSyUSJ7QmWaCEZOXUrX
         ycjU3oEeTERQHJFD1a90xmD3Pe+jmAssxX39Qhfj9ltSBuueMRP79MrDWkptS4twltXP
         34ZgMvGwV9JbGGNynEKnmc1iDNYfM2SSAcn/8S4eckNxAbwsuIMIxhO0f/1fY87ENLzj
         fHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QORDlWP+mhc0RjgGQH7MI5JXfG5WhJ3jk12dN80H6zA=;
        b=QoPw+vgmKen6zvcCf6TbxuP1E7RNaoHgZ/MujIwJIKowh8/SFDmf7CBSPALPVAIIxC
         alrZO4lMTPbMIoOEMaxTmkzTKvX4tlAuMDtlT8x1mU554NuNvmwCGxVHAMGHA4u/6992
         b0IJYLhlDFWVkrO7susRENj1F7+aoHgkuqLd252gM9jEf3UNuAQ4ipZNQ6CGJLbOCf9s
         8OSZiOXw20dCEFfocbDY8vmqNFx5R1yxi40OoZQ/rkgkNtqOxPK+yyxVHsis2Flz+pm/
         OBWFYWCEP3Zwi9lXbf9hXW3g9cxDy/gbl0l1U/MKmrWwgcIhZHmczu2NsrXhKqMswxpP
         uOAQ==
X-Gm-Message-State: ANoB5pnaBb7fgisKJy4cR9ghgSheCGa4DmS1L9M52e31zfxsH4yOAltq
	d8pn/Z6LloREgiorFXt7TyPoXQnpLz2C64Esg+o=
X-Google-Smtp-Source: AA0mqf5i0PA4b0D3uG9mjVgyoib+vcsKL4vtw5MhVwziQf2I2TvrvLZmKtGmsPspmFBq8yIJNL5HEw==
X-Received: by 2002:a17:90a:e7c5:b0:219:252e:32c1 with SMTP id kb5-20020a17090ae7c500b00219252e32c1mr26772790pjb.182.1669933413120;
        Thu, 01 Dec 2022 14:23:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u126-20020a627984000000b00575caf80d08sm3739621pfc.31.2022.12.01.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:23:32 -0800 (PST)
Message-ID: <63892964.620a0220.144c8.7201@mx.google.com>
Date: Thu, 01 Dec 2022 14:23:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71-1-g61333eee4869
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 2 runs,
 1 regressions (v4.4.302-cip71-1-g61333eee4869)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 22:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10157

cip/linux-4.4.y-cip ltp-fcntl-locktests: 2 runs, 1 regressions (v4.4.302-ci=
p71-1-g61333eee4869)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71-1-g61333eee4869/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71-1-g61333eee4869
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      61333eee4869050c46b5f75ae6d337998d39f2a0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  498247917f40b0a82cb149e2ec1cb518acd7b632 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6389172604058a08972abcfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221125.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6389172604=
058a08972abcfc
        failing since 9 days (last pass: v4.4.302-cip70-98-g7f7838c92740f, =
first fail: v4.4.302-cip70-236-g69445bc0d4209) =

 =20

