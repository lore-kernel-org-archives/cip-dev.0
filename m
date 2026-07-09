Return-Path: <whyshall.dev@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F413C43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 09:13:04 +0000 (UTC)
Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2268.1783572827891924605
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 21:53:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KPqWXiOO;
 spf=pass (domain: gmail.com, ip: 74.125.231.132, mailfrom: whyshall.dev@gmail.com)
Received: by mail-oo2-f4.google.com with SMTP id 46e09a7af769-7e9f37a2160so362063a34.0
        for <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 21:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783572827; cv=none;
        d=google.com; s=arc-20260327;
        b=jZBqlLcb/RidpLapVJMZBzhmYmhV1534SP3Dgj8E/etY5ljj1vr+QLTaWa3suB9WZ3
         QPYf3mlZdKHGVVsCUKsI93JI6qSpZmiw8hc1s29aAvyPm1ZesY3EFEsb44eAKLlfbyg9
         UOxw+EyZVLJ/pbf0hf6NifuJjPCUmvjUNEH7IM46JWojwK7mqCMtOQ2rX7j35+VtFvxn
         srkNdj7kmJzME9uhw/dDau1WBp1qV36FRe3NYpmhsIUYtjBnO3MrkVfcnEqTatbNje8p
         vM7atzN6h1uxJJCCkRl9X845vTd91CR+wY7I+bnOTBxz7GTfiyzm62PAynyQBi2mSWp5
         pcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1/Htsa56u/JRtEHYrlLrjnxaT83oJe59cRDx/FYQ0DY=;
        fh=RaKH4vXZgYv/1PYcQkfLRK5D2CnBMLe+KcXQA6BQxAs=;
        b=HiYriOTwC5aS0AWv4fYLuFFfRqZnWK6KFsy/lz44K54bMYB84kygqAOomKs7Y0hZE6
         ieS8dsWHF3avpbKdF4ryPx/ww+vJYpQK5u28DUK8eC2BP8ijhnKirP7w2lvCfX9hWMej
         UW4/2jhIlXemnAMFgE16zS1O8wVF7g6bb0XZuswXFg65osOzj4TJb8GayA3iyY/nYAII
         I4JCyGpXe/pXXFi+nPFrwCjB07jkmW5A+PUul5ZR3O4/7aC9w8f/e6bHlEP7YrJnvadu
         EGfNMiXPoXasTs8ZKUIsyGRPFyspOCQLHD7sJv+bTNSHR0UDxn5cg7+vbg+0dZi4n2o7
         0AvA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783572827; x=1784177627; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1/Htsa56u/JRtEHYrlLrjnxaT83oJe59cRDx/FYQ0DY=;
        b=KPqWXiOO9G0BgeYY9A9lql6hzajACZtvmcDSXno2UOY1s+qh3IsO+JD8NPNJwWmTjW
         sROx33Hyyy7Fq/R+i2+ean9+TxOOm7ZK8fKNpz1/bmP6zW5f0a0vDboDXvr3xjqkoFrG
         l4L9G06h93o07bSc62+P9kzhc2Mxity2S7C/kgg6dXpYjInbnSo2nmIMQ+jS9kQtlknE
         DI7t5bEvGEhYyz/eIaZ1GRKxsQFOJNSrZs0gX2Ya7vdz6UOpLWA2MXbtG/n7BHWe4Kl3
         94D507+34upfPLkZTmzv93eaQqkfQ9S331Zn9uXfU8HWa6xrRyT6RQrtaUBHXzMrCYrK
         qoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783572827; x=1784177627;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/Htsa56u/JRtEHYrlLrjnxaT83oJe59cRDx/FYQ0DY=;
        b=gxsfak/62j+ndm3w12+TCa9JmLvmYDh1YWDUQjn+kmRGB03SB82jGzcXFgdKnbO6Bm
         ikB80nuWhGRIp0w3uF3/F8t+1H978gmZnLo2BknViTsN7OAa9k+0wviNqttN0+e1R0CE
         garMYAXkTVOlggJX3aFvNr6kpSg43kB5D1rq9/upXsGBqSK7/zQN4AehF7ToBDFJVh8Z
         VRoWnWDj9bhwHtcGjZUWsGrvFT5JrPh1ODBEbKd8vceu5bUhI8EsLUJrBUXoNuXiEds4
         YHo4Lgf9ZwMvF21TTU2HKm/QTmxN7drM9a/SH6hwCVCjIzORZ6n2KaFRuUflv8nCn3An
         22kg==
X-Gm-Message-State: AOJu0Yy87gZ1Iwlb3RZtW72v/xlbpG+/dHNTXbOwT9CNguWqG9CB29gl
	iimsEMgQzQPUyz+AzM1XMD28rWJo7IVofSjxKk4YJs/I/D12O+aibVvlq1XRGV/7N/5ydy2Fp3m
	whx022Xh0IAkNVUazST81IXX4pDeYDIqE7eSd4yw=
X-Gm-Gg: AfdE7cnckj/fF+A5sO8U67qQ78il2xox0mP4HJhnWCuQhh15K7JzC3ao2wTco8KdtW8
	XvT1G7PIRLB2NHsBX+DeounIWJGZVOyQ771YKWbEBuEhuLYFe5kxFroVKaiCYQqzHFk9yz8aPxC
	FfhiC+tlZS5kuCuluny+Oqm+MxieWzf4f5EK4bGOIOF7VwYZp2cJvpallH4qPdxp+/6K8dSCY8N
	EzGrvIqd09NuMo+PQw/YM1HcxlIK6S+KmXcy3mCMpNk2yWTdklTwVyvuGTdKdimtg+D/vMe
X-Received: by 2002:a05:6820:4ccb:b0:6a1:4507:3544 with SMTP id
 006d021491bc7-6a36d8ea5edmr3761936eaf.28.1783572826850; Wed, 08 Jul 2026
 21:53:46 -0700 (PDT)
MIME-Version: 1.0
From: whyshall.dev@gmail.com
Date: Thu, 09 Jul 2026 02:13:04 -0700
X-Gm-Features: AUfX_my4jccLDr7W7nrjyY1exCFqgo6r4kY7jGz8ugt7aewI-hpEs9yRo4rZV5k
Message-ID: <CAOksrezPuEAoJ86FHMS_ajoH0h7pe3usksyo84n5rF9RKHfu4g@mail.gmail.com>
Subject: Urgent: Regarding Fixing of Security Vulnerabilities
To: cip-dev@lists.cip-project.org
X-Old-Date: Thu, 9 Jul 2026 10:23:35 +0530
Content-Type: multipart/alternative; boundary="000000000000c68a330656266867"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jul 2026 09:13:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23552
Message-ID: <20260709091304.RS-HV9xRMukFV0v02e2SEqvWAR9RA_yC-Dq8jV7WmaI@z>

--000000000000c68a330656266867
Content-Type: text/plain; charset=UTF-8

Hi ,

We are planning to migrate our product to the Linux Kernel 4.19.y CIP release to benefit from its long-term maintenance and security updates.

We have a few questions regarding security vulnerability tracking for the CIP kernel:

* Is there any tool, dashboard, or documentation available to determine:

* The Kernel CVEs applicable to a specific 4.19.y CIP release.
* Which CVEs have already been fixed till the given CIP release.
* Which CVEs are still outstanding.

* Is there a published roadmap or policy indicating how unresolved Kernel CVEs are evaluated and scheduled for backporting to the 4.19.y CIP branch?
* For CVEs that remain unfixed in the CIP kernel:

* What are the expected implications or risks for users of the CIP release?
* Are these vulnerabilities typically already addressed in the upstream mainline Linux kernel, with backporting to CIP pending due to compatibility or maintenance considerations?

* 
If there are unfixed vulnerabilities that are considered critical for our product, what is the recommended approach to address them?

* 
Does the CIP project provide any guidance or best practices for evaluating, backporting, or mitigating such vulnerabilities?

* 
If a required fix is available only in the upstream mainline kernel, are there any recommendations or guidelines for safely backporting it to the CIP kernel?

Any guidance on the recommended process or tools for tracking the security status of CIP kernel releases would be greatly appreciated.

Also, we came across an opensource tool called *kernel-backport-checker* , which identifies *Linux kernel CVEs* that have been addressed through backported commits in a Git repository, filtered based on the kernel configuration. We executed this tool against the latest CIP release, cip-4.19.325-cip134.

The output generated by the tool is provided below:

./kernel-backport-checker.sh \
>         -s ../../linux-cip-4.19.325- cip134 \
>         -d ../linux \
>         -b ../linux-stable \
>         -e ../kev-data \
>         -f ../nvd-json-data-feeds \
>         -k ../../linux-cip-4.19.325- cip134/.config \
>         -o ../../linux-cip-4.19.325- cip134/cve_report -j 4
============================== ==========
Kernel Backport Checker v3.2.0
============================== ==========

[INFO] Configuration:
[INFO]   Kernel Source:   ../../linux-cip-4.19.325- cip134
[INFO]   Kernel Config:   ../../linux-cip-4.19.325- cip134/.config
[INFO]   Git Repository:  ../linux
[INFO]   Stable/Vendor:   ../linux-stable
[INFO]   KEV File:        ../kev-data/known_exploited_ vulnerabilities.json
[INFO]   NVD Feeds:       ../nvd-json-data-feeds
[INFO]   Output:          ../../linux-cip-4.19.325- cip134/cve_report
[INFO]   Parallel Jobs:   4

[INFO] Detecting kernel version...
[INFO] Kernel version: 4.19.325
[INFO] Loading kernel config: ../../linux-cip-4.19.325- cip134/.config
[INFO] Loaded 1752 enabled CONFIG options
[INFO] Building CONFIG mapping from kernel Makefiles...
[INFO] Built CONFIG mapping: 16301 file mappings, 1503 directory mappings
[INFO] Scanning NVD feeds for CVEs affecting Linux kernel 4.19.325...
[INFO]   Phase 1: Finding kernel CVE files...
[INFO]   Found 18117 CVE files with Linux kernel CPEs
[INFO]   Phase 2: Extracting version ranges (sequential to ensure accuracy)...
[INFO]   Extracted 155638 version entries
[INFO]   Phase 3: Filtering for version 4.19.325...
[INFO] NVD scan complete: 3600 CVEs affect kernel 4.19.325
[INFO] Extracting upstream fix commit hashes from NVD references (jobs=4)...
[INFO] Extracted 17487 fix commit refs for 3410 CVEs
[INFO] Building git hash index...
[INFO] Git hash index built: 1967640 commits
[INFO] Extracting backported CVE fixes from git...
[INFO] Searching stable/vendor repo for CVE mentions: ../linux-stable
[INFO] Found 4388 commit-CVE pairs (733 unique CVEs in git)
[INFO] Building CISA KEV index...
[INFO] KEV index built: 1631 CVEs
[INFO] Processing results...
[INFO]   Matching fix commits against git repos...
[INFO]   Found 17469 fix commits in git repos
[INFO]   Extracting changed files and diffs from fix commits (jobs=4)...
[INFO]   Exporting lookup tables for parallel processing...
[INFO]   Processing 3600 affected CVEs (jobs=4)...
[INFO]   Processing complete.
[INFO] Generating CSV report...
[INFO] ============================== =============
[INFO] Report: ../../linux-cip-4.19.325- cip134/cve_report/backport- report.csv
[INFO] ============================== =============
[INFO]
[INFO] Summary for kernel 4.19.325:
[INFO]   Total CVEs:              3600
[INFO]   Not applicable:          1718
[INFO]   Applicable:              1882
[INFO]     Fixed via backport:    73
[INFO]     Likely fixed (review): 32
[INFO]     Unfixed (remaining):   745
[INFO]     Inconclusive:          1032
[INFO]
[INFO]   CVEs in CISA KEV:        6 (fixed: 1)
[INFO]
[INFO]   Severity (applicable / unfixed):
[INFO]     CRITICAL:              21 / 5
[INFO]     HIGH:                  512 / 194
[INFO]     MEDIUM:                1327 / 538
[INFO]     LOW:                   22 / 8

[INFO] Done!

Why is this tool giving *Inconclusive* ?Will these ever be counted as vulnerabilities or not?
Also, the number of *unfixed CVEs* as per this tool are 745. This tool also generates the list of those unfixed CVEs in a .csv file.
Will these vulnerabilities *be resolved by CIP* in the next release or will it *take multiple releases* and hence more time to get solved? That is why I had asked whether CIP maintains a list of solved and unsolved vulnerabilities till date for 4.19.y-cip kernel !

We would appreciate your feedback on these results as well.

--000000000000c68a330656266867
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<div style=3D"color: #000000; font-family: roboto; line-height: normal;">&n=
bsp;Hi ,</div>
<p style=3D"color: #000000; font-family: roboto; line-height: normal;"><spa=
n style=3D"line-height: normal;">We are planning to migrate our product to =
the Linux Kernel 4.19.y CIP release to benefit from its long-term maintenan=
ce and security updates.</span></p>
<p style=3D"color: #000000; font-family: roboto; line-height: normal;"><spa=
n style=3D"line-height: normal;">We have a few questions regarding security=
 vulnerability tracking for the CIP kernel:</span></p>
<ol style=3D"color: #000000; font-family: roboto;" start=3D"1">
<li><span style=3D"line-height: normal;">Is there any tool, dashboard, or d=
ocumentation available to determine:</span>
<ul>
<li><span style=3D"line-height: normal;">The Kernel CVEs applicable to a sp=
ecific 4.19.y CIP release.</span></li>
<li><span style=3D"line-height: normal;">Which CVEs have already been fixed=
 till the given CIP release.</span></li>
<li><span style=3D"line-height: normal;">Which CVEs are still outstanding.<=
/span></li>
</ul>
</li>
<li><span style=3D"line-height: normal;">Is there a published roadmap or po=
licy indicating how unresolved Kernel CVEs are evaluated and scheduled for =
backporting to the 4.19.y CIP branch?</span></li>
<li><span style=3D"line-height: normal;">For CVEs that remain unfixed in th=
e CIP kernel:</span>
<ul>
<li><span style=3D"line-height: normal;">What are the expected implications=
 or risks for users of the CIP release?</span></li>
<li><span style=3D"line-height: normal;">Are these vulnerabilities typicall=
y already addressed in the upstream mainline Linux kernel, with backporting=
 to CIP pending due to compatibility or maintenance considerations?</span><=
/li>
</ul>
</li>
<li>
<div style=3D"line-height: normal;"><span style=3D"line-height: normal;">If=
 there are unfixed vulnerabilities that are considered critical for our pro=
duct, what is the recommended approach to address them?</span></div>
</li>
</ol>
<ul style=3D"color: #000000; font-family: roboto;">
<ul>
<li>
<div style=3D"line-height: normal;"><span style=3D"line-height: normal;">Do=
es the CIP project provide any guidance or best practices for evaluating, b=
ackporting, or mitigating such vulnerabilities?</span></div>
</li>
<li>
<div style=3D"line-height: normal;"><span style=3D"line-height: normal;">If=
 a required fix is available only in the upstream mainline kernel, are ther=
e any recommendations or guidelines for safely backporting it to the CIP ke=
rnel?</span></div>
</li>
</ul>
</ul>
<p style=3D"color: #000000; font-family: roboto; line-height: normal;"><spa=
n style=3D"line-height: normal;">Any guidance on the recommended process or=
 tools for tracking the security status of CIP kernel releases would be gre=
atly appreciated.<br /><br /><br /><br /></span></p>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">Also, we came acro=
ss an opensource tool called<span>&nbsp;</span><strong>kernel-backport-chec=
ker</strong>, which identifies<span>&nbsp;</span><strong>Linux kernel CVEs<=
/strong><span>&nbsp;</span>that have been addressed through backported comm=
its in a Git repository, filtered based on the kernel configuration. We exe=
cuted this tool against the latest CIP release, cip-4.19.325-cip134.<br /><=
br />The output generated by the tool is provided below:<br /><br />./kerne=
l-backport-checker.sh \</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -s ../../linux-cip-4.19.325-<wbr />cip13=
4 \</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -d ../linux \</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -b ../linux-stable \</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -e ../kev-data \</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -f ../nvd-json-data-feeds \</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -k ../../linux-cip-4.19.325-<wbr />cip13=
4/.config \</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -o ../../linux-cip-4.19.325-<wbr />cip13=
4/cve_report -j 4</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wb=
r />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">Kernel Backport Ch=
ecker v3.2.0</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wb=
r />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&nbsp;</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Configurati=
on:</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Kernel Source:&nbsp;&nbsp; ../../linux-cip-4.19.325-<wbr />cip134</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Kernel Config:&nbsp;&nbsp; ../../linux-cip-4.19.325-<wbr />cip134/.config<=
/div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Git Repository:&nbsp; ../linux</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Stable/Vendor:&nbsp;&nbsp; ../linux-stable</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 KEV File:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ../kev-data/known_expl=
oited_<wbr />vulnerabilities.json</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 NVD Feeds:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ../nvd-json-data-feeds</div=
>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Output:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ../../linux-=
cip-4.19.325-<wbr />cip134/cve_report</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Parallel Jobs:&nbsp;&nbsp; 4</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&nbsp;</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Detecting k=
ernel version...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Kernel vers=
ion: 4.19.325</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Loading ker=
nel config: ../../linux-cip-4.19.325-<wbr />cip134/.config</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Loaded 1752=
 enabled CONFIG options</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Building CO=
NFIG mapping from kernel Makefiles...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Built CONFI=
G mapping: 16301 file mappings, 1503 directory mappings</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Scanning NV=
D feeds for CVEs affecting Linux kernel 4.19.325...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Phase 1: Finding kernel CVE files...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Found 18117 CVE files with Linux kernel CPEs</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Phase 2: Extracting version ranges (sequential to ensure accuracy)...</div=
>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Extracted 155638 version entries</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Phase 3: Filtering for version 4.19.325...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] NVD scan co=
mplete: 3600 CVEs affect kernel 4.19.325</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Extracting =
upstream fix commit hashes from NVD references (jobs=3D4)...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Extracted 1=
7487 fix commit refs for 3410 CVEs</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Building gi=
t hash index...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Git hash in=
dex built: 1967640 commits</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Extracting =
backported CVE fixes from git...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Searching s=
table/vendor repo for CVE mentions: ../linux-stable</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Found 4388 =
commit-CVE pairs (733 unique CVEs in git)</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Building CI=
SA KEV index...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] KEV index b=
uilt: 1631 CVEs</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Processing =
results...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Matching fix commits against git repos...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Found 17469 fix commits in git repos</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Extracting changed files and diffs from fix commits (jobs=3D4)...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Exporting lookup tables for parallel processing...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Processing 3600 affected CVEs (jobs=3D4)...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Processing complete.</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Generating =
CSV report...</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<wbr />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Report: ../=
../linux-cip-4.19.325-<wbr />cip134/cve_report/backport-<wbr />report.csv</=
div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<wbr />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Summary for=
 kernel 4.19.325:</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Total CVEs:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 3600</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Not applicable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1718=
</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Applicable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 1882</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
&nbsp;&nbsp; Fixed via backport:&nbsp;&nbsp;&nbsp; 73</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
&nbsp;&nbsp; Likely fixed (review): 32</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
&nbsp;&nbsp; Unfixed (remaining):&nbsp;&nbsp; 745</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
&nbsp;&nbsp; Inconclusive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 1032</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 CVEs in CISA KEV:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6 (fixed: 1)</=
div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
 Severity (applicable / unfixed):</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
&nbsp;&nbsp; CRITICAL:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 21 / 5</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
&nbsp;&nbsp; HIGH:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 512 / 194</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
&nbsp;&nbsp; MEDIUM:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1327 / 538</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO]&nbsp;&nbsp;=
&nbsp;&nbsp; LOW:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 / 8</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">&nbsp;</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">[INFO] Done!</div>
<div style=3D"font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial; color: #000000; font-family: Verdana, Arial, Helvetica, sans-=
serif; font-size: 13.3333px; background-color: #ffffff;">
<div>&nbsp;</div>
<div>Why is this tool giving<span>&nbsp;</span><strong>Inconclusive<span>&n=
bsp;</span></strong>?Will these ever be counted as vulnerabilities or not?<=
br />Also, the number of<span>&nbsp;</span><strong>unfixed CVEs</strong><sp=
an>&nbsp;</span>as per this tool are 745. This tool also generates the list=
 of those unfixed CVEs in a .csv file.<br />Will these vulnerabilities<span=
>&nbsp;</span><strong>be resolved by CIP</strong><span>&nbsp;</span>in the =
next release or will it<span>&nbsp;</span><strong>take multiple releases</s=
trong><span>&nbsp;</span>and hence more time to get solved? That is why I h=
ad asked whether CIP maintains a list of solved and unsolved vulnerabilitie=
s till date for 4.19.y-cip kernel ! &nbsp;<br /><br />We would appreciate y=
our feedback on these results as well.&nbsp;</div>
</div>
<p style=3D"color: #000000; font-family: roboto; line-height: normal;"><spa=
n style=3D"line-height: normal;">&nbsp;</span></p>
</div>

--000000000000c68a330656266867--

