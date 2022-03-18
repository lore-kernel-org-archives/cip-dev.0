X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web12.11629.1647620449793665009
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 18 Mar 2022 09:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=kPXAn+Gt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id p17so7321110plo.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 18 Mar 2022 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=znjcN1HHXLxHRjyEOLN29K57SlrFMCkxXD2VBOdmIeI=;
        b=kPXAn+GtuwbTZGvgA6jb1h/OGzU6ciA7e7sUlvLN+sSwll17IkBg3//y+ixjNzdQyQ
         m5avBxUDvDb6lZ8qjqPKxzRiM9LUEI6x+Ng4Cf2shYE14CWWh2mKTJuPN8BrfRWEIUEl
         +388F+kRDwFLwasqNtB2K5b7XpTzjV1dW+GkDtVmS14u/HRpl0BLEkTA/0GG8uLz5S08
         Y3zowTp9Ny0CkQHbgExPWZYICRtzFztEA4B2hiwrOSSqmENzJFn96X3SUeyBfhjfqTcD
         Gmldae7vNQB4+/dS1ew7cQq/a6szeMudht0OJQMlk46qZFnNzs6DXhj2+u47QQOjS06o
         YHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=znjcN1HHXLxHRjyEOLN29K57SlrFMCkxXD2VBOdmIeI=;
        b=a4Iw9Ln20AI6bh010qoKk/smf8ULDoE7XkFnCDoC5HVoWHl/yS8waFgftm+VWp5bsp
         5k77EP7QxRfUQe4inz+2f77b9n65bYzGNXdZT0Fp1T7thxPEHWYG471CiUqBMhuuJkTE
         /JSyB97X9gWQENNFcUDz3MCSji5QpqEqFZD/Ha9cWBzBkDTjBHhN8efz0GJUt1WuO1NS
         dVdECqqJPcdk66QUK3h9vIc76fmCA/3pZBjrqyn6Jh1MdEeaqkmYqPGmMm5TpfV361E6
         KosmubxA089N9tCJcc+Kr9NQQ8+t+IQGlq1cjTgylkQHVMRciP7VIKaYWlmhb01JXXQm
         MRKg==
X-Gm-Message-State: AOAM532/D/JpMsFusfctg3Tbgd9E8543iyeWejurv5ugjYFS5IJV1/IC
	GCIxf8R4k2UvjkVtdyePRh5fiZz9MvgioC7Ajn8=
X-Google-Smtp-Source: ABdhPJwHB0oEeN8YWLxZuSG2dzt6itirn9orrzbGHoqJxjpBJLSaSSGIDfvjbHpBKeJA2gDdnoMl5A==
X-Received: by 2002:a17:902:ce91:b0:154:16c2:63b3 with SMTP id f17-20020a170902ce9100b0015416c263b3mr245412plg.22.1647620449193;
        Fri, 18 Mar 2022 09:20:49 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a056a000b8200b004fa23c8b522sm10221119pfj.156.2022.03.18.09.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:20:48 -0700 (PDT)
Message-ID: <6234b160.1c69fb81.7dec2.bbc3@mx.google.com>
Date: Fri, 18 Mar 2022 09:20:48 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4.302-cip68-19-g33cb6f438d5a
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
Subject: cip/linux-4.4.y-cip build: 146 builds: 4 failed, 142 passed (v4.4.302-cip68-19-g33cb6f438d5a) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.4.y-cip build: 146 builds: 4 failed, 142 passed (v4.4.302-cip68=
-19-g33cb6f438d5a)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-cip/k=
ernel/v4.4.302-cip68-19-g33cb6f438d5a/

Tree: cip
Branch: linux-4.4.y-cip
Git Describe: v4.4.302-cip68-19-g33cb6f438d5a
Git Commit: 33cb6f438d5acbe92fa6aee23ee3e7e5590a9cca
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 6 unique architectures

Build Failures Detected:

arm:
    rpc_defconfig: (gcc-10) FAIL

mips:
    fuloong2e_defconfig: (gcc-10) FAIL
    ip27_defconfig: (gcc-10) FAIL
    ip28_defconfig: (gcc-10) FAIL

---
For more info write to <info@kernelci.org>

