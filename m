Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DAECD3423
	for <webhook@archiver.kernel.org>; Sat,  2 May 2026 14:45:14 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14967.1777010700369165649
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 23:05:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci.org header.s=google header.b=IEK+So+h;
 spf=pass (domain: kernelci.org, ip: 74.125.82.50, mailfrom: bot@kernelci.org)
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12dbd0f8063so3248629c88.0
        for <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 23:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777010699; x=1777615499; darn=lists.cip-project.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feXPqwoNlTtF41OSeySGwOyBcfITCYMXJ0fleNsNHZY=;
        b=IEK+So+hoQd3uGD4JFrE04kqd1QHVcgvDb2OcGIJlpSJtjmMW7YnnfRN1hKcARP6NR
         0gwWZGwrLPqBiSlACAwf/zOEYF71EFn+nffz+fzq6aRbXXaMlQMAB9pGzIkfgAXyCw29
         O2FLboyJx7S9+/Y5hJPcvRibKM2fFAGQLoLfYYUj8/FvtMESBXHkdm9e37D1+3QP8qCJ
         3GD5FgfKbFva1RsHwGRh/8HBTqpGMHR4pZnO/XIeugIWzmy31nVN4zGAE7nXuCpPWLsd
         dMjcu7devp81OiJjOntSWqwko0RpqhwzSaOPSl7m6f6NnG5vvEM4HgqiEENxoNJGMELj
         E5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777010699; x=1777615499;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=feXPqwoNlTtF41OSeySGwOyBcfITCYMXJ0fleNsNHZY=;
        b=nRxZyc0KgB9SZdLqstKlem8e5Eph5DSG7S1tn/5TSd4xs2l9UQnejVusFpEcdqGJWV
         M6OlGBDAXue9nMOAoCh1z4yeMHCG2FE0nUHup/qLmHWKX1W641htbtSRBpopkkbOVvbU
         g+Rtk/QK8/d3xJLWHJ5SuI88j3GWRtTDvq5lhtATBFgA08Ks8sNuvpoRTfooSV1kFVpX
         WepxQBZfzaGe5Kio6cMaUr4QJBlzQsPRgTQNHku/vQVqCLGgVAox3L+U7QoYkDNJx212
         fZY9kgFsvk1ImbL8TchApQWTxG+4nafhC2u88ZxTDOP4hrcJnhhweJB2fh+A8j7iqcUe
         CrCg==
X-Forwarded-Encrypted: i=1; AFNElJ8n0w8raP2OkpvOTbT9duKnKJhhqYYwahDRagIqKpBStvGCpCIuuWloP8Y/ZnJ/GRmHx5sH6ku/@lists.cip-project.org
X-Gm-Message-State: AOJu0YzRRx2lDgObios9PRCjGjhc8plxF11xhNFyVuZ7o74kx5adlYny
	oRLTQ1E85yDwOGPLdgxPE164HN/CDp5qiA/RLASw4WQ86Fz7NxLApYcct7Gtgpk5rA4McTG7TMo
	HkpR6
X-Gm-Gg: AeBDieu0kCYqasLXeR5UUPBSBVaL0hyuNbjjvLfnUpVrBUuHCVt2MuoZ2fvB5b/3P5P
	MABINT9YAtnjaGP3dHkHKjh2LmSRzilGn0ZerImyI/RqE3JhVweWknVAOQ0oo190uhIQZI5jcJL
	ZZXWLZPSnmnGV0HoPJ8KyNSnBAfl0tzKyN+hooK0ogevhpu2EMQBhAc4uq9aX1I5rTcFJ/3b2xD
	mnGAxchKqr+WsMGx15qdTKfmP+vn+lnD5qWFx+4OvcGaeXVYjz+Ggu6hVjDfd58KfAWRH3czhaX
	k+OiCIf9kRwrQuk7Kbnr3rNfrzz2v9lxxfFkmTQjrFFWzLXEeXeN1BVSMeyGjZc1mk1qW0U16HK
	qwtRkjB9hNkhjus7O4HPrcN+DHLFEy/xmhii252i2kIRRFJ3qVYtUHtUMssJsLa8EN7XQlq9W4n
	Vt2tlt/Pp+72wmW9QsEs5PABpp6tLIaSX/D4uqdg==
X-Received: by 2002:a05:7300:e611:b0:2d8:7302:d37 with SMTP id 5a478bee46e88-2e466044875mr17031057eec.1.1777010344824;
        Thu, 23 Apr 2026 22:59:04 -0700 (PDT)
Received: from ab39070dab57 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c86sm37035351eec.1.2026.04.23.22.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:59:04 -0700 (PDT)
MIME-Version: 1.0
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIGNpcC9saW51eC01LjEwLnktY2lwOiAoYnVpbGQpIC4vYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmg6NDc6NTg6IGVycm9yOiDigJhwaHlzX3JhbV9iYXNl4oCZIHUuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, cip-dev@lists.cip-project.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 24 Apr 2026 05:59:04 -0000
Message-ID: <177701034361.433.11564842085112077601@ab39070dab57>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 May 2026 14:45:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22835





Hello,

New build issue found on cip/linux-5.10.y-cip:

---
 ./arch/riscv/include/asm/pgtable.h:47:58: error: ‘phys_ram_base’ undeclared (first use in this function) in arch/riscv/mm/extable.o (arch/riscv/mm/extable.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:18a939442411a85014e6de5cee57169b6a2ca6e6
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
- commit HEAD:  ed9775e24a0ff211274a0669ad6096a94bb670e8


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
                 from arch/riscv/mm/extable.c:12:
./arch/riscv/include/asm/pgtable-64.h: In function ‘pud_page’:
./arch/riscv/include/asm/pgtable.h:47:58: error: ‘phys_ram_base’ undeclared (first use in this function)
   47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
      |                                                          ^~~~~~~~~~~~~
./include/asm-generic/memory_model.h:54:34: note: in expansion of macro ‘vmemmap’
   54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
      |                                  ^~~~~~~
./include/asm-generic/memory_model.h:82:21: note: in expansion of macro ‘__pfn_to_page’
   82 | #define pfn_to_page __pfn_to_page
      |                     ^~~~~~~~~~~~~
./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro ‘pfn_to_page’
   70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
      |                ^~~~~~~~~~~
./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifier is reported only once for each function it appears in
   47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
      |                                                          ^~~~~~~~~~~~~
./include/asm-generic/memory_model.h:54:34: note: in expansion of macro ‘vmemmap’
   54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
      |                                  ^~~~~~~
./include/asm-generic/memory_model.h:82:21: note: in expansion of macro ‘__pfn_to_page’
   82 | #define pfn_to_page __pfn_to_page
      |                     ^~~~~~~~~~~~~
./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro ‘pfn_to_page’
   70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
      |                ^~~~~~~~~~~
./arch/riscv/include/asm/pgtable.h: In function ‘pmd_page’:
./arch/riscv/include/asm/pgtable.h:47:58: error: ‘phys_ram_base’ undeclared (first use in this function)
   47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
      |                                                          ^~~~~~~~~~~~~
./include/asm-generic/memory_model.h:54:34: note: in expansion of macro ‘vmemmap’
   54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
      |                                  ^~~~~~~
./include/asm-generic/memory_model.h:82:21: note: in expansion of macro ‘__pfn_to_page’
   82 | #define pfn_to_page __pfn_to_page
      |                     ^~~~~~~~~~~~~
./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro ‘pfn_to_page’
  181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
      |                ^~~~~~~~~~~

=====================================================


# Builds where the incident occurred:

## defconfig+kselftest+lab-setup+cip://5.10.y-cip/riscv/cip_merged_defconfig on (riscv):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-riscv-510-cip-69eaf9329b5a968309fda467/.config
- dashboard: https://d.kernelci.org/build/maestro:69eaf9329b5a968309fda467


#kernelci issue maestro:18a939442411a85014e6de5cee57169b6a2ca6e6

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

