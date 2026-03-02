Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB91D58E4B
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 03:02:41 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.151466.1772417116636104821
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Mar 2026 18:05:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sVHq/x87;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.219.41, mailfrom: bot@kernelci.org)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899d6b7b073so31899296d6.2
        for <cip-dev@lists.cip-project.org>; Sun, 01 Mar 2026 18:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1772417115; x=1773021915; darn=lists.cip-project.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6NqM3hzueGhswpkXMQ+y6J5duywPh+5KN+wR8Ysn4I=;
        b=sVHq/x87vaPK+DlWcD/4ZxYP0oip8H+E7CzOkaEu+gE/mCwjtyuaAPaAe2F58Rh8dQ
         U72YdT02qS1Un5qCUC5bDRYlZ7We/JhOw1qFfaOUzjGVFIkoH1bVGUe4qeXj46cwXkl3
         1DTXAxFzhEHol5/ezWp125CDkrSZ1H7o6DKL9vQHxPYpE+CeLEXo/01brfhtQ/j39nvh
         AF3Mv8BS+VqD4H9LzE00kp7qsOFlnApDaLFBi8kkOnhkTbbYD8EYXs2Z3aLdPBqy87FI
         ej/ZbUFAUMCLoh+6Op31vqCMw+zM45I9yrNPGt534GXv+/oFjoIYIhghdHmZRDXNtUc1
         1j5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772417115; x=1773021915;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6NqM3hzueGhswpkXMQ+y6J5duywPh+5KN+wR8Ysn4I=;
        b=WYRVfW5jyhrH2ofXxFfc+H8y1EGLKo4Ipyxlv45rZMGXhrVp9v9VA7ncXSwbRH9tPF
         kuhN6bxSirIVINEdiM4foXhEpTTFD+PmYyxEtNq3g7ydu0/2UjK+z4LjMXU7N77jQ4IY
         3mSxSswx3pXQ3Ei2Na5AwVbq633+PS3XiSW/HQKrIpJiQgOaYJhvM/JJOAzNLMz3WBXR
         kZ0ID5ZhH8vgbukYq5/aguiHjfR8XCffiikGoaiziBD9uK5OmTF6UqqRp1bgSb4MiBjH
         m2KBFJX5GKpZx386oAwXHngfZ0lA6hhqiKpg1bkGAvN93IS3Rs8qHx5ihd+907F7LSN3
         LJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnCyk/csYvldKyfVzlnKxczVFDWMEQA2UFyYUH5ESuB1RU1pfFSny5Pkn63guDAFpHxbIa18La@lists.cip-project.org
X-Gm-Message-State: AOJu0YwOjzOjsuoi8hCWIbCB+13r+8l4HnNpwzxck5h8bWyrwhE+4vpg
	1ICQIk72QgFlN5ZKJj9fsUUHm41vM0ZDk7uKNGKpjSseNZJkbyZmWkIDcQ27xhn1Mt2ZGik7/hg
	Xcjch
X-Gm-Gg: ATEYQzxVYW41+E0Np+QSXRchlRKyOTroAHgdTIVjsJSYhBeYH9LurlDtKucfVn2SK3p
	msxvZI3Vd2Kd+qmMRhwq8OFenRM7TEXtoYnZV06BsYRfNXH8adoRi8AcXAf3FJuOfRABOcnMpIe
	1bZMU1/SsSyvuTBafFquH57mHDdWgjT8hAZnC8z5w64zyACCHCDBwy6taYGhHRBgTuP7UftOMY2
	Dxt49jLr6BKx6IEONNAI9AKb6cpJEG8XkQpmnxxSp/b4l1A+sGFY+PActywCjpinuEr/eFmwkHV
	kuco77MWRVNpYpE/dtdfNxAMi68twe3QvRD9TCnp6I7q1jo7GhwYCyVo+UIPHv84gzHmPIhZ3l7
	L22/Yxvj6j/PI+UdVVz2i47uY8dH3Di3mRDor4w67S7jZ2g59tDdSzl4ds9K87/9iikb1d8VbbK
	6/tAvIIobxnFq0DJWB
X-Received: by 2002:a05:7022:43aa:b0:11b:9386:8267 with SMTP id a92af1059eb24-1278fc8ed7bmr4155832c88.44.1772416744324;
        Sun, 01 Mar 2026 17:59:04 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df36asm12219845c88.4.2026.03.01.17.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 17:59:03 -0800 (PST)
MIME-Version: 1.0
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIGNpcC9saW51eC01LjEwLnktY2lwOiAoYnVpbGQpIC4vYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmg6NDc6NTg6IGVycm9yOiDigJhwaHlzX3JhbV9iYXNl4oCZIHUuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, cip-dev@lists.cip-project.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 02 Mar 2026 01:59:03 -0000
Message-ID: <177241674295.4931.1639151501403818844@d14e337afe00>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Mar 2026 03:02:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22033





Hello,

New build issue found on cip/linux-5.10.y-cip:

---
 ./arch/riscv/include/asm/pgtable.h:47:58: error: ‘phys_ram_base’ undeclared (first use in this function) in arch/riscv/kernel/soc.o (arch/riscv/kernel/soc.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:a44f11709a2b24065c2a83190153e7064da24401
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
- commit HEAD:  de96b8c0e298067b4bbffa294baeed909a588408


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
                 from arch/riscv/kernel/soc.c:7:
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
  AS      arch/riscv/kernel/vdso/flush_icache.o
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
In file included from ./include/linux/pgtable.h:6,
                 from ./include/linux/mm.h:33,
                 from ./include/linux/kallsyms.h:12,
                 from ./include/linux/ftrace.h:11,
                 from ./include/linux/init_task.h:9,
                 from init/init_task.c:2:
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
  AS      arch/riscv/kernel/vdso/note.o
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
In file included from ./arch/riscv/include/asm/uaccess.h:11,
                 from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/rcuwait.h:6,
                 from ./include/linux/percpu-rwsem.h:7,
                 from ./include/linux/fs.h:33,
                 from init/do_mounts_initrd.c:4:
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
In file included from ./include/linux/pgtable.h:6,
                 from ./include/linux/mm.h:33,
                 from arch/riscv/mm/init.c:8:
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
  VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
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
In file included from ./arch/riscv/include/asm/uaccess.h:11,
                 from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/rcuwait.h:6,
                 from ./include/linux/percpu-rwsem.h:7,
                 from ./include/linux/fs.h:33,
                 from init/initramfs.c:3:
./arch/riscv/include/asm/pgtable-64.h: In function ‘pud_page’:
In file included from ./arch/riscv/include/asm/uaccess.h:11,
                 from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/sched/cputime.h:5,
                 from kernel/sched/sched.h:11,
                 from kernel/sched/clock.c:56:
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
In file included from ./arch/riscv/include/asm/uaccess.h:11,
                 from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/sched/cputime.h:5,
                 from kernel/sched/sched.h:11,
                 from kernel/sched/loadavg.c:9:
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
./arch/riscv/include/asm/pgtable.h: In function ‘pmd_page’:
  OBJCOPY arch/riscv/kernel/vdso/vdso.so
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
In file included from ./arch/riscv/include/asm/uaccess.h:11,
                 from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/rcuwait.h:6,
                 from ./include/linux/percpu-rwsem.h:7,
                 from ./include/linux/fs.h:33,
                 from ./include/linux/seq_file.h:11,
                 from arch/riscv/kernel/cpu.c:7:
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
In file included from ./arch/riscv/include/asm/uaccess.h:11,
                 from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from kernel/locking/mutex.c:23:
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
  AS      arch/riscv/kernel/vdso/vdso.o
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
  SO2S    arch/riscv/kernel/vdso/vdso-syms.S

=====================================================


# Builds where the incident occurred:

## defconfig+kselftest+lab-setup+cip://5.10.y-cip/riscv/cip_merged_defconfig on (riscv):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-riscv-510-cip-69a4e24e7136242fe390371e/.config
- dashboard: https://d.kernelci.org/build/maestro:69a4e24e7136242fe390371e


#kernelci issue maestro:a44f11709a2b24065c2a83190153e7064da24401

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

